Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4564EC4345F
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Apr 2024 22:16:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1Cnm-0005uP-6H; Sun, 28 Apr 2024 18:15:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1CnY-0005sr-6K
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 18:15:07 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1CnV-0005JA-Ib
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 18:15:03 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-56e1baf0380so4781887a12.3
 for <qemu-devel@nongnu.org>; Sun, 28 Apr 2024 15:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714342499; x=1714947299; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Rnpe0rzeTKHAYN20E0T7xpdwaTDLO7bZVPKy5KYEFKE=;
 b=pFpi7ltFCaGsfWZJQzF2PuegYqBVbdG3Ho//XCbh1BZKdqDd1bT+3oFHHMMiGGJVcE
 8oMz5UQypZhLOki/FGamnKvNH67M56sz+YvKSgLycBtCMYa/cOiuGIrzCfVJ4fgT47hn
 JLoseqMGwoJZepsGE8pVAp9iGRXUMVvsPPu1RbB9BB8uhk2lPx5jUK+kAcYEe0hcWvuQ
 sqL4Gpu81LNaeHpUOqEnr87kFvfYDnS7wyKZVgvqe9AcWbVKNXPzznA2quVznwN9G9Xl
 JJn2WMtEtTIWtqt+Wa8UnjVZgQeX16l6UZMnbHlvPnrBxlt98VtGf56160Ik6BLwmcUN
 gZ/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714342499; x=1714947299;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Rnpe0rzeTKHAYN20E0T7xpdwaTDLO7bZVPKy5KYEFKE=;
 b=nGd+WxacJNaMKSv5A7/Sz8p/RuIB6wwHtAFT6PnUSt1ziw+seetXO97Ni91EAtGWvR
 d4wRVb+Tbut5fIczyYwRmO5VHjFVJj2iurUJIh/p5JEWd+gEMYw9CisFA27i6G+DUzuD
 oc+ImKC10rKjq9Onee/ySGn37jXJW1MaLtK1fnB7NIQK2WZh/BxqaLCTpjbGAtmBrS2B
 GeNt6VB1mVrZLwfW5ztZTcXknX5+591PUPyazfSscqMsOM0Sk+4Cnp77ZpCnFvFLWdiA
 I9X/e81kLNr4GxmC+p+0QsShrfKuRZJhxuDyC2r2pjiUqMqK4n1HBET4Hey2+LtjlYTF
 tXLQ==
X-Gm-Message-State: AOJu0Yw+Gx/GXNP3fPKu6JqJ/MBsUPeFBvUzo+Kb9xBA8N7GoUItMadw
 JMnGZLrtYWrzMp9r3OwZxNYKf7ldlrLBMulxOBIbpnfhKThBx+J6gJG4NpvLbiCZFa8mQpXY04v
 X
X-Google-Smtp-Source: AGHT+IEYzTto5Un6kFkn8KmG6JhzWo2l3h9rppKq2a/5h7DIEKAvdfa2CoMfP3SheC5K1WkyNFRGkQ==
X-Received: by 2002:a50:c056:0:b0:572:7ea0:66ca with SMTP id
 u22-20020a50c056000000b005727ea066camr1119043edd.36.1714342498614; 
 Sun, 28 Apr 2024 15:14:58 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.142.130])
 by smtp.gmail.com with ESMTPSA id
 c7-20020a0564021f8700b0057000ecadb0sm12458847edc.8.2024.04.28.15.14.57
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 28 Apr 2024 15:14:58 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 01/24] exec/user: Move 'thunk.h' from 'exec/user' to 'user'
Date: Mon, 29 Apr 2024 00:14:27 +0200
Message-ID: <20240428221450.26460-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240428221450.26460-1-philmd@linaro.org>
References: <20240428221450.26460-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x529.google.com
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
---
 bsd-user/qemu.h                 | 2 +-
 include/{exec => }/user/thunk.h | 8 ++++++--
 linux-user/user-internals.h     | 2 +-
 linux-user/thunk.c              | 2 +-
 4 files changed, 9 insertions(+), 5 deletions(-)
 rename include/{exec => }/user/thunk.h (97%)

diff --git a/bsd-user/qemu.h b/bsd-user/qemu.h
index 63ee07d534..e562adde65 100644
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
index 2ebfecf58e..b97def8d53 100644
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
 #include "exec/user/abitypes.h"
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


