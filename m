Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16F6BC04FFE
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2024 19:50:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s0RVs-0002Rr-1P; Fri, 26 Apr 2024 15:45:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s0RVn-00025J-Jd
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 15:45:35 -0400
Received: from mail-lj1-x234.google.com ([2a00:1450:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s0RVj-0004jI-Ug
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 15:45:35 -0400
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2def8e5ae60so25090511fa.2
 for <qemu-devel@nongnu.org>; Fri, 26 Apr 2024 12:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714160729; x=1714765529; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z+2jDyZubLtcgNSevFNEEciw6F0x1NCcSU5rQYS3oAw=;
 b=UhjCGqBEM92b5zkUfUld/wygKKFVElvhoYrm3fHPiB9+D+2M24KTOejCjKZFFj2Rk6
 ysyuK73y9GVucNQgxVcuGw9Uk540c/LN1QibEolh61fvVjCyKTnfMPN/OLO4MlBtpHgd
 UPN4YwIUgNDURpjygXpg74DcypK9iqOzkG4vili37cLue/9LEPVbU3v+SuWC3P1+l6DH
 cujOXQhWoNm6500QUIyc/IAIEhAuqt6ffSnOXCe6ibgzDyc2FqC45BC47FoOP2cfinJ9
 QeJ8tjnX2cujeck0IB0JZ/QAt6HlzEy640a9TqDVjPmtQzlAZkI6YzVhRWeLyQ7kUbKO
 MyoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714160729; x=1714765529;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z+2jDyZubLtcgNSevFNEEciw6F0x1NCcSU5rQYS3oAw=;
 b=S7YTDZ/QG4NnVlo0XoPrB4DWO3qMr8TLzv4jhGyjyhDL695B0KpvDFDfRq0cSoDbZG
 sSNFx3aD7ewOW0UF7hznh8H1yNPUEacb5cRDOzzGV4kPNpOG+yTwkHZ13iGzRUXDQvW7
 Se1xvkD5plyI0849TDjshRLrnavPJ2nDcoV+WaIvql7CSZF+aA4cD+Ku8CTGo1MY47HK
 ++3S9PPRjOVmap0agFNwzQJdqCHsztmbM2JSzz+m5fV8Hvz9FD/3phVZodccjXeHxWXq
 WvP3HN8J6VCnf+qD/JaI14j1Rbag911Hv9nrCwRH61tNd1X0rMyNm7rZSOXiUeMSw+Dh
 PxEw==
X-Gm-Message-State: AOJu0YyXQyev2WJ/oUCuDFHfXC1oIbhuq7SDTt4iNdFuudTI36ygD+Vi
 JOQVL5vPM2v9UAx2ECe5ZiPZE3szG8LFf16K1khjDD/ErwQWkUy2sb+u+ovfba0dd+nKhLQeH7u
 P4YI=
X-Google-Smtp-Source: AGHT+IF+Ja9y+jYNQSuQM6lRomZm2tRamB1LylfatuO0fL1y6Q35I9B4AOk2Aa8R1AntdVvelLfkkg==
X-Received: by 2002:a2e:a4a4:0:b0:2db:7b:1a7b with SMTP id
 g4-20020a2ea4a4000000b002db007b1a7bmr2028423ljm.46.1714160729546; 
 Fri, 26 Apr 2024 12:45:29 -0700 (PDT)
Received: from m1x-phil.lan (aul93-h02-176-184-11-147.dsl.sta.abo.bbox.fr.
 [176.184.11.147]) by smtp.gmail.com with ESMTPSA id
 l10-20020a056402124a00b00571bec923bcsm10012663edw.93.2024.04.26.12.45.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 26 Apr 2024 12:45:29 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-riscv@nongnu.org, qemu-s390x@nongnu.org,
 qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>, Warner Losh <imp@bsdimp.com>,
 Kyle Evans <kevans@freebsd.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>
Subject: [PULL 35/38] exec: Restrict inclusion of 'user/guest-base.h'
Date: Fri, 26 Apr 2024 21:41:55 +0200
Message-ID: <20240426194200.43723-36-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240426194200.43723-1-philmd@linaro.org>
References: <20240426194200.43723-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::234;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x234.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Declare 'have_guest_base' in "user/guest-base.h".

Very few files require this header, so explicitly include
it there instead of "exec/cpu-all.h" which is used in many
source files.

Assert this user-specific header is only included from user
emulation.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20231211212003.21686-23-philmd@linaro.org>
Reviewed-by: Anton Johansson <anjo@rev.ng>
---
 include/exec/cpu-all.h    | 3 ---
 include/exec/cpu_ldst.h   | 2 ++
 include/user/guest-base.h | 6 ++++++
 bsd-user/main.c           | 1 +
 linux-user/elfload.c      | 1 +
 linux-user/main.c         | 1 +
 6 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index 027f19e052..e75ec13cd0 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -65,9 +65,6 @@
 
 #if defined(CONFIG_USER_ONLY)
 #include "exec/user/abitypes.h"
-#include "user/guest-base.h"
-
-extern bool have_guest_base;
 
 /*
  * If non-zero, the guest virtual address space is a contiguous subset
diff --git a/include/exec/cpu_ldst.h b/include/exec/cpu_ldst.h
index f3c2a3ca74..7d0a0412ad 100644
--- a/include/exec/cpu_ldst.h
+++ b/include/exec/cpu_ldst.h
@@ -74,6 +74,8 @@
 
 #if defined(CONFIG_USER_ONLY)
 
+#include "user/guest-base.h"
+
 #ifndef TARGET_TAGGED_ADDRESSES
 static inline abi_ptr cpu_untagged_addr(CPUState *cs, abi_ptr x)
 {
diff --git a/include/user/guest-base.h b/include/user/guest-base.h
index 1e42bca5db..055c1d14fe 100644
--- a/include/user/guest-base.h
+++ b/include/user/guest-base.h
@@ -7,6 +7,12 @@
 #ifndef USER_GUEST_BASE_H
 #define USER_GUEST_BASE_H
 
+#ifndef CONFIG_USER_ONLY
+#error Cannot include this header from system emulation
+#endif
+
 extern uintptr_t guest_base;
 
+extern bool have_guest_base;
+
 #endif
diff --git a/bsd-user/main.c b/bsd-user/main.c
index 01b313756e..29a629d877 100644
--- a/bsd-user/main.c
+++ b/bsd-user/main.c
@@ -36,6 +36,7 @@
 #include "qemu/help_option.h"
 #include "qemu/module.h"
 #include "exec/exec-all.h"
+#include "user/guest-base.h"
 #include "tcg/startup.h"
 #include "qemu/timer.h"
 #include "qemu/envlist.h"
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 207455c1ba..f9461d2844 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -8,6 +8,7 @@
 
 #include "qemu.h"
 #include "user/tswap-target.h"
+#include "user/guest-base.h"
 #include "user-internals.h"
 #include "signal-common.h"
 #include "loader.h"
diff --git a/linux-user/main.c b/linux-user/main.c
index 149e35432e..94e4c47f05 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -38,6 +38,7 @@
 #include "qemu/help_option.h"
 #include "qemu/module.h"
 #include "qemu/plugin.h"
+#include "user/guest-base.h"
 #include "exec/exec-all.h"
 #include "exec/gdbstub.h"
 #include "gdbstub/user.h"
-- 
2.41.0


