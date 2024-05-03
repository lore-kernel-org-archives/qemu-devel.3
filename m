Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E4CFC4345F
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2024 12:53:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2sOn-0001Rl-U5; Fri, 03 May 2024 08:52:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s2sOe-0001Qw-6C
 for qemu-devel@nongnu.org; Fri, 03 May 2024 08:52:16 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s2sOX-00062F-60
 for qemu-devel@nongnu.org; Fri, 03 May 2024 08:52:15 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-572babec735so2287071a12.0
 for <qemu-devel@nongnu.org>; Fri, 03 May 2024 05:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714740725; x=1715345525; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ED+XYfvia/D/wqYKfRWUzlTd4pH/F9dBy4hK44N8rGo=;
 b=zeHGQLJhK9qIs27hSHrcs6KjM6QiAm2VDsJwidh1xFZmoyNbPWJivbtpV1ck4/bnbZ
 ledH6iVsFGp4PeDMfoQ8gybpQ1jDoNXcoTFDY5i6/RQnM667VDwW0w/MzDUgjliyqr3k
 WmaLWXMhl8pzN0AZGh0/gfRmSlxdynCupHB8Ujg9r21v/1P8v+HtqXr6mVBvxgqQ5u41
 764TOAiBHCW4MRkNBVGBCgYPJpI38V4TEnuS36YsuokX4+NtCvCVXw+HlqHS7ndnzNzP
 LUNC6f22merTL1A82JRwWz2x/cb2c+vLClvSyKDR3/QH0meV8Hrdc1bmBGfsVCcqyBNF
 N3XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714740725; x=1715345525;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ED+XYfvia/D/wqYKfRWUzlTd4pH/F9dBy4hK44N8rGo=;
 b=f3qYMA0r8POjIasQGwK8NnijsjlEm6v0w+cuqbRdj1n8Ds9FOSpXtJKQ9FLKgnOs+L
 y2+XIzCyGlDgF9XSL3c+Fpj1ER6V7K0958aN8LKVEOMLPGOZqlHL2oyXp/HswZMd27Nt
 2uHV/cipxdrY9kZS3NECdzo4XuXn9+KeJx32ZWPLaEXdfuJ60q+TmRYPNC1OJ5l+AUUq
 tVx6hx27oTGGL82px8BNR6Qq1PTvDmWL1GXX7i2Mv1BoTvK8Vp2KhmAkcWA2xClGQXP7
 /ppDVUoSeZ66Dv6Gx+Bx+blCIo5opTnYKpagrVJHKpoYn5qB0v263zO2Kpe49s2rvocb
 cKjQ==
X-Gm-Message-State: AOJu0YxiWDoPOCBw8WDw1ixRrGLbUKPGWeAJNHYGVtzk+gFAKBDpQl+M
 xkUOCyhZ8rAwv/zbzXjuOzuR+dnWBxbis2PQ29JFUbXlMAW7h88JiYlt2vnxl2GEQW+kIQN8XvV
 5
X-Google-Smtp-Source: AGHT+IGXAiUkdcGoFOVW946HW0oohfNLVW17DiBH5qmhXdKtYRJmHuUsftXSIHE8i9IWRMFRNQUvMw==
X-Received: by 2002:a17:906:f754:b0:a58:f186:229 with SMTP id
 jp20-20020a170906f75400b00a58f1860229mr2187674ejb.0.1714740725306; 
 Fri, 03 May 2024 05:52:05 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.179.187])
 by smtp.gmail.com with ESMTPSA id
 x19-20020a170906135300b00a599e418208sm95025ejb.9.2024.05.03.05.52.03
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 03 May 2024 05:52:04 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Warner Losh <imp@bsdimp.com>,
 Riku Voipio <riku.voipio@iki.fi>, Kyle Evans <kevans@freebsd.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] exec/user: Move 'abitypes.h' from 'exec/user' to 'user'
Date: Fri,  3 May 2024 14:52:02 +0200
Message-ID: <20240503125202.35667-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x536.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
Forgot to include this patch in "exec: Rework around CPUState user fields"
https://lore.kernel.org/qemu-devel/20240428221450.26460-1-philmd@linaro.org/
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


