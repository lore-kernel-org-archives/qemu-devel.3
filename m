Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62D2AC4345F
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2024 15:37:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2uxo-00030H-GD; Fri, 03 May 2024 11:36:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s2uxm-0002pZ-A2
 for qemu-devel@nongnu.org; Fri, 03 May 2024 11:36:42 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s2uxk-0002jV-I3
 for qemu-devel@nongnu.org; Fri, 03 May 2024 11:36:42 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a597de5a715so344879966b.2
 for <qemu-devel@nongnu.org>; Fri, 03 May 2024 08:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714750599; x=1715355399; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cTcH38ypkKRkPbykxMZkLFBWPz8R6W/0jDZCFk5eJbs=;
 b=i26acGTplOGzFjS0zcKe2/uhaOrnXCCkn/NEoTo/2cH/gnwvfXj/6XUImBLDOl3DDw
 jJefUMWGnLvbpntMWGqojqHdfHnJ1rIWjrg3p00rt+yHs6Pmh1Dw/HoVFIIjpitAkHf1
 mqDrS6oEZs9MG1NtfL7y+PBSh31uxTqwUakqngaVJUGXq02NgNLKmtzV7Qq6FsKTJE5f
 CB3G/1D6tyxILO6sIP3lyMny9Svg4jka1OObi9yGpoBDJ22kHyMQrXizkymT5a/38uyW
 tDY8/csEDyTttLkuoXn4sK41ElCMzuIUxJg8AngSxOlPTo+UjzHM7NkAq7C6Oa3AIDty
 NFKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714750599; x=1715355399;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cTcH38ypkKRkPbykxMZkLFBWPz8R6W/0jDZCFk5eJbs=;
 b=BpgBOJsq7XXf9QKx/QAKInNEhZxvSPbLC8KLzkVVe5dSV48kiRJhw2KAEu2VuFgjez
 vIvs+Uyk6TFx8BQ9ohBIti/w0BABN5xTHajlKQawi6IxR01+myHCO6OyZbUV4HIuSCV9
 7zI+VAXIs/Z02BbJ/vndHAr2gXzojOrWxRNPVcmGo9SbcRkG6wWUcV7GFSdYOvzLq3HR
 rCV0tS+j6nOMY07qedagWgIMURrGswGqqNUx73HgM0M7DOPTtpyl7+aRNYV1yaykdtjF
 hLrh8ygGxe9LSGvloGL5PHoxY00y01LVfc+Tl/X69FJIa3gcPbsY1jJORyxD58kWwMb5
 99pg==
X-Gm-Message-State: AOJu0YxQPkhGdQvvRwZ/fvSNRyzqR0tlQUeRaUSNkRsqXvAvbc/6XRhG
 XG6FGzzLQD9LllUEuU/V1DRiPmZyU8BcoBgGIu9pYsEnuGuyihceiPOs2sBhwd9L1BMzHFEVB67
 y
X-Google-Smtp-Source: AGHT+IEp/nOaVNJv4FkILPN0MK77LeLnTdojXccBtx6O2sbyPxSgT00S1kNXZ7VhK/GM7BWHt7iglQ==
X-Received: by 2002:a17:907:bb86:b0:a59:9edf:14b8 with SMTP id
 xo6-20020a170907bb8600b00a599edf14b8mr411681ejc.3.1714750598831; 
 Fri, 03 May 2024 08:36:38 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.179.187])
 by smtp.gmail.com with ESMTPSA id
 sa14-20020a1709076d0e00b00a5981ff2123sm1207399ejc.182.2024.05.03.08.36.37
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 03 May 2024 08:36:38 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 04/14] user: Move 'abitypes.h' from 'exec/user' to 'user'
Date: Fri,  3 May 2024 17:36:03 +0200
Message-ID: <20240503153613.38709-5-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240503153613.38709-1-philmd@linaro.org>
References: <20240503153613.38709-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x630.google.com
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
Message-Id: <20240503125202.35667-1-philmd@linaro.org>
---
 bsd-user/qemu.h                    | 2 +-
 include/exec/cpu-all.h             | 2 +-
 include/exec/user/thunk.h          | 2 +-
 include/{exec => }/user/abitypes.h | 4 ++--
 include/user/syscall-trace.h       | 2 +-
 linux-user/qemu.h                  | 2 +-
 6 files changed, 7 insertions(+), 7 deletions(-)
 rename include/{exec => }/user/abitypes.h (97%)

diff --git a/bsd-user/qemu.h b/bsd-user/qemu.h
index 8629f0dcde..a0c1ad7efa 100644
--- a/bsd-user/qemu.h
+++ b/bsd-user/qemu.h
@@ -22,7 +22,7 @@
 #include "exec/cpu_ldst.h"
 #include "exec/exec-all.h"
 
-#include "exec/user/abitypes.h"
+#include "user/abitypes.h"
 
 extern char **environ;
 
diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index e75ec13cd0..032c6d990e 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -64,7 +64,7 @@
 /* MMU memory access macros */
 
 #if defined(CONFIG_USER_ONLY)
-#include "exec/user/abitypes.h"
+#include "user/abitypes.h"
 
 /*
  * If non-zero, the guest virtual address space is a contiguous subset
diff --git a/include/exec/user/thunk.h b/include/exec/user/thunk.h
index 2ebfecf58e..9f35c888f9 100644
--- a/include/exec/user/thunk.h
+++ b/include/exec/user/thunk.h
@@ -21,7 +21,7 @@
 #define THUNK_H
 
 #include "cpu.h"
-#include "exec/user/abitypes.h"
+#include "user/abitypes.h"
 
 /* types enums definitions */
 
diff --git a/include/exec/user/abitypes.h b/include/user/abitypes.h
similarity index 97%
rename from include/exec/user/abitypes.h
rename to include/user/abitypes.h
index 3ec1969368..5c9a955631 100644
--- a/include/exec/user/abitypes.h
+++ b/include/user/abitypes.h
@@ -1,5 +1,5 @@
-#ifndef EXEC_USER_ABITYPES_H
-#define EXEC_USER_ABITYPES_H
+#ifndef USER_ABITYPES_H
+#define USER_ABITYPES_H
 
 #ifndef CONFIG_USER_ONLY
 #error Cannot include this header from system emulation
diff --git a/include/user/syscall-trace.h b/include/user/syscall-trace.h
index b48b2b2d0a..9bd7ca19c8 100644
--- a/include/user/syscall-trace.h
+++ b/include/user/syscall-trace.h
@@ -10,7 +10,7 @@
 #ifndef SYSCALL_TRACE_H
 #define SYSCALL_TRACE_H
 
-#include "exec/user/abitypes.h"
+#include "user/abitypes.h"
 #include "gdbstub/user.h"
 #include "qemu/plugin.h"
 #include "trace/trace-root.h"
diff --git a/linux-user/qemu.h b/linux-user/qemu.h
index 4777856b52..263f445ff1 100644
--- a/linux-user/qemu.h
+++ b/linux-user/qemu.h
@@ -4,7 +4,7 @@
 #include "cpu.h"
 #include "exec/cpu_ldst.h"
 
-#include "exec/user/abitypes.h"
+#include "user/abitypes.h"
 
 #include "syscall_defs.h"
 #include "target_syscall.h"
-- 
2.41.0


