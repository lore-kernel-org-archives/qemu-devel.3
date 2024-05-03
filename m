Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCA63C4345F
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2024 15:37:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2uyM-0003Hn-Ay; Fri, 03 May 2024 11:37:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s2uxs-00036g-8v
 for qemu-devel@nongnu.org; Fri, 03 May 2024 11:36:49 -0400
Received: from mail-lf1-x12a.google.com ([2a00:1450:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s2uxq-0002jo-IR
 for qemu-devel@nongnu.org; Fri, 03 May 2024 11:36:48 -0400
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-51f1b378ca5so3539412e87.1
 for <qemu-devel@nongnu.org>; Fri, 03 May 2024 08:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714750604; x=1715355404; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z1hVAWqle0Mz/JboTJUAwXdqwQ9y68NGrGd6TXjKRdw=;
 b=A4zkzidb+D7JH8jZcQlQ8T1o1uDcPsyR65X3dg9hOb6fibUyNFB3z+MDB0KxliJWsx
 39CdS5VEosvV2o7WY9XAAy3xY7LSmunmky7pJw8N3O0mgPXiu+9RcVDOuX/T8OoEYa4f
 ybFuW3WG1RLQHFqMtQ/lBg/K6BEQmvzM3PDEXBaByZKw9x1KLE8j+aOAuMnACVq4bhro
 86GiLaLOSPC/DG6QF0EA09xaxjgYFy2PdOZL6NjETextGAhjKM06f8na9s6AZMwJPEwD
 TrLrXnztuEJVVnGDTr/p8RZ3qOL47675+70ZULZbyEbTxMgW6+Sw1L1UedTK+UJ97BBO
 pc/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714750604; x=1715355404;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=z1hVAWqle0Mz/JboTJUAwXdqwQ9y68NGrGd6TXjKRdw=;
 b=ah7kYzR0BHYBxK3tAZjgaLwiVuGBe76pAalOyxOCUu0o70+gv/fREltJNdF9CkzeCV
 vzmpYJPYt9KMb5K1bKT/rSl9kC9ePDavIiwq24E1BLKk+3UCpkGkqreGdoHPhUPV4RVM
 pwpkrXhXUEIXBLWXlUQ+IUHcHcgyz3nzjVNjqdTMBFuaGNhU6woPehpjX4QLJOfReJ1v
 a9pEeCdVb5Gh+TDAW0lPD8KjkQ7439oUAifqQo3pzHgMMQborYosL3z8UOwUMvl2LyiO
 Yb+/ytyIpbXyzoo72KwaNNZOYQNDzuHH4lpCHigDiG5UVI9YtUBayuiQnmRLborsBEwZ
 qErQ==
X-Gm-Message-State: AOJu0YxE/YCpelpjeQ19i1r9DN4z4rRGgKiis3URlNiXEpKqtKJKmp1n
 MbtKc0ZHx5RE8izulkWgWZ1rqMM/YjLbLOqJ/KVjfX8Wcyo3hyMvcTvbU64EtOMw60vS3LPCOhR
 H
X-Google-Smtp-Source: AGHT+IGQHu71mGmPbza/1iJRgncgeGQbQrF8epAxL5Pk8NczWyd1FSRr4NqFETROkSgYWt9O/We3Hg==
X-Received: by 2002:ac2:51b0:0:b0:51a:c3b8:b9cf with SMTP id
 f16-20020ac251b0000000b0051ac3b8b9cfmr2381768lfk.69.1714750604395; 
 Fri, 03 May 2024 08:36:44 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.179.187])
 by smtp.gmail.com with ESMTPSA id
 xo16-20020a170907bb9000b00a55b1253fe5sm1814337ejc.194.2024.05.03.08.36.43
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 03 May 2024 08:36:43 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 05/14] user: Move 'thunk.h' from 'exec/user' to 'user'
Date: Fri,  3 May 2024 17:36:04 +0200
Message-ID: <20240503153613.38709-6-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240503153613.38709-1-philmd@linaro.org>
References: <20240503153613.38709-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12a;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Keep all user emulation headers under the same user/ directory.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20240428221450.26460-2-philmd@linaro.org>
---
 MAINTAINERS                     | 1 -
 bsd-user/qemu.h                 | 2 +-
 include/{exec => }/user/thunk.h | 8 ++++++--
 linux-user/user-internals.h     | 2 +-
 linux-user/thunk.c              | 2 +-
 5 files changed, 9 insertions(+), 6 deletions(-)
 rename include/{exec => }/user/thunk.h (97%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 302b6fd00c..96411e6adf 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3692,7 +3692,6 @@ Overall usermode emulation
 M: Riku Voipio <riku.voipio@iki.fi>
 S: Maintained
 F: accel/tcg/user-exec*.c
-F: include/exec/user/
 F: include/user/
 F: common-user/
 
diff --git a/bsd-user/qemu.h b/bsd-user/qemu.h
index a0c1ad7efa..a916724de9 100644
--- a/bsd-user/qemu.h
+++ b/bsd-user/qemu.h
@@ -26,7 +26,7 @@
 
 extern char **environ;
 
-#include "exec/user/thunk.h"
+#include "user/thunk.h"
 #include "target_arch.h"
 #include "syscall_defs.h"
 #include "target_syscall.h"
diff --git a/include/exec/user/thunk.h b/include/user/thunk.h
similarity index 97%
rename from include/exec/user/thunk.h
rename to include/user/thunk.h
index 9f35c888f9..2a2104b568 100644
--- a/include/exec/user/thunk.h
+++ b/include/user/thunk.h
@@ -17,8 +17,12 @@
  * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
 
-#ifndef THUNK_H
-#define THUNK_H
+#ifndef USER_THUNK_H
+#define USER_THUNK_H
+
+#ifndef CONFIG_USER_ONLY
+#error Cannot include this header from system emulation
+#endif
 
 #include "cpu.h"
 #include "user/abitypes.h"
diff --git a/linux-user/user-internals.h b/linux-user/user-internals.h
index ce11d9e21c..5c7f173ceb 100644
--- a/linux-user/user-internals.h
+++ b/linux-user/user-internals.h
@@ -18,7 +18,7 @@
 #ifndef LINUX_USER_USER_INTERNALS_H
 #define LINUX_USER_USER_INTERNALS_H
 
-#include "exec/user/thunk.h"
+#include "user/thunk.h"
 #include "exec/exec-all.h"
 #include "exec/tb-flush.h"
 #include "qemu/log.h"
diff --git a/linux-user/thunk.c b/linux-user/thunk.c
index 071aad4b5f..3cd19e79c6 100644
--- a/linux-user/thunk.c
+++ b/linux-user/thunk.c
@@ -20,7 +20,7 @@
 #include "qemu/log.h"
 
 #include "qemu.h"
-#include "exec/user/thunk.h"
+#include "user/thunk.h"
 
 //#define DEBUG
 
-- 
2.41.0


