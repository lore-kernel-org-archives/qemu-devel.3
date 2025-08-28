Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE05FCA0EED
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 12:17:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urbTz-00069i-BC; Thu, 28 Aug 2025 08:11:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urbSF-0003lQ-I5
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 08:10:17 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urbSD-0007aU-CX
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 08:10:11 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-24457f581aeso6960625ad.0
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 05:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756383007; x=1756987807; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sGKOMxTbtB0fTMjFgi2SLDv1p+aCDxxUGh+EB/xA3MU=;
 b=dUfHiygZbCqD/wbgc0SFeBawkCBc1giAd6J6g5mJOdt1McC3/IkrkvXJDEG2kKixET
 C2oXCpowIj26yg2x4OFhkaHie/LEZGbU25gNuubqv3pdrfEG2LnMlWJ4peUvNxFLWY49
 rteHEmX7R+XmbJ5hrhI+P0nVFZbHiXssQk/KuIb0Ce8M4U7C0qt0WshC9sJi1K7Ej/c2
 ejbOrerNB046tNEdYAc9mONlz6i7D0x2VY2H0kg9CFLpEAoKckmmqQbx4K9XPzU+GeMq
 u2lcDM76N1qkk3B/1Lx04g1jQsW3wWcLFHTLcgaYo5aZHLUm+h3EcwCTwd77LyPS9gxk
 JJWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756383007; x=1756987807;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sGKOMxTbtB0fTMjFgi2SLDv1p+aCDxxUGh+EB/xA3MU=;
 b=jNdWE2G0RRYZXIF/CNFd0x8Ukrd39A0s07qQhhd2rXHQS/YeD6NGcNdJfbAc1lSlET
 eImHfIRU/JzUOK2zoLhcX5x65KUxuf9UeqMEjQW1dn2FMMTiRiF6EnOCLEvOtDLeldeG
 ELEh6V09M0ypr9fBC3w6+d/lTRx8DoRddamsv/H4TB0NpyWnEktSnuD4kkZAryRBJC6m
 wbmZTweqthp/n9ixcZbrHVEsFSp5edPWEzBnx+MtltJPV+CRMtxX52fi7XfhgfKHVzOi
 8LVvRgGQBpGfYaby17vGQTtOB4RihYpPNi4QCZM/IsKj8SccR2NzsxobYQz0YVVkN5FO
 GkHA==
X-Gm-Message-State: AOJu0YyR6OEmeRp70aFHnWrzoDU42wsaf7R40oe+eSfpBKAkFtbz1qXl
 wD/5vlANNK03Rc+y9czmAn4d8fK1/FgoZFlM2dF/rb3Yc/AqWLn5V4ak4lWFog97atd0ZyveV2y
 c6XXw7NQ=
X-Gm-Gg: ASbGncsOVdTz9AuffZcsI4WXhCRGLbR4Hrvo8OV6Bavf2oHK9iqqF8wA5teQrmgc+q9
 Gx2IQZSiPf5KgLMCDDKnznaelp6Td/eImfvpx8Y/0uYh+CAaeYNaSRIm6DnePi+fKGlZ1kaY+YI
 3AiXNH7b/GtVaD/540mwqS2sgYSF5K6bGT/4kC0dU89Yt5/k9ZLyVjPi7370On5euQsgWZtkTNi
 5leeHmZblQ2YONn+ITV7Xv81MM960iDZ2N0RQsl2OzAon8N/libQ8n9dKJ4bWZH6aTuFCI91JtZ
 mjA2k7/odZjarouPws1h6ixn5fAkNv2CIej6gIMEfLXQBOX3/49e5lIkRqztBzqgh1D1eguT3hR
 g2szn0j/MuI3u8AY6kciRmiFdvWS6u1CAOJ6M
X-Google-Smtp-Source: AGHT+IEVXtxT6Fz/SifRKsKeA38aHVbkfWebjxmuyrvMNFAp+zLpmxGWu5yMIqa8bA/8/2od3fYfgQ==
X-Received: by 2002:a17:902:cec2:b0:242:9bc4:f1c9 with SMTP id
 d9443c01a7336-2462efdbcc7mr304676725ad.56.1756383007378; 
 Thu, 28 Aug 2025 05:10:07 -0700 (PDT)
Received: from stoup.. ([144.6.121.55]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b49cb8b4b98sm13933222a12.19.2025.08.28.05.10.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Aug 2025 05:10:07 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH v3 36/87] linux-user/aarch64: Expand target_elf_gregset_t
Date: Thu, 28 Aug 2025 22:07:45 +1000
Message-ID: <20250828120836.195358-37-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250828120836.195358-1-richard.henderson@linaro.org>
References: <20250828120836.195358-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

Make use of the fact that target_elf_gregset_t is a
proper structure by using target_user_pt_regs.

Drop ELF_NREG, target_elf_greg_t, and tswapreg.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/aarch64/target_elf.h | 11 +++++++----
 linux-user/aarch64/elfload.c    | 11 +++++------
 2 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/linux-user/aarch64/target_elf.h b/linux-user/aarch64/target_elf.h
index b0728a1008..9eb8bb547e 100644
--- a/linux-user/aarch64/target_elf.h
+++ b/linux-user/aarch64/target_elf.h
@@ -8,16 +8,19 @@
 #ifndef AARCH64_TARGET_ELF_H
 #define AARCH64_TARGET_ELF_H
 
+#include "target_ptrace.h"
+
 #define HAVE_ELF_HWCAP          1
 #define HAVE_ELF_HWCAP2         1
 #define HAVE_ELF_PLATFORM       1
 #define HAVE_ELF_CORE_DUMP      1
 
-typedef abi_ulong target_elf_greg_t;
-
-#define ELF_NREG                34
+/*
+ * See linux kernel: arch/arm64/include/asm/elf.h, where
+ * elf_gregset_t is mapped to struct user_pt_regs via sizeof.
+ */
 typedef struct target_elf_gregset_t {
-    target_elf_greg_t regs[ELF_NREG];
+    struct target_user_pt_regs pt;
 } target_elf_gregset_t;
 
 #endif
diff --git a/linux-user/aarch64/elfload.c b/linux-user/aarch64/elfload.c
index 00550f9fdf..07a0c3f844 100644
--- a/linux-user/aarch64/elfload.c
+++ b/linux-user/aarch64/elfload.c
@@ -349,13 +349,12 @@ const char *get_elf_platform(CPUState *cs)
     return TARGET_BIG_ENDIAN ? "aarch64_be" : "aarch64";
 }
 
-#define tswapreg(ptr)   tswapal(ptr)
-
 void elf_core_copy_regs(target_elf_gregset_t *r, const CPUARMState *env)
 {
-    for (int i = 0; i < 32; i++) {
-        r->regs[i] = tswapreg(env->xregs[i]);
+    for (int i = 0; i < 31; i++) {
+        r->pt.regs[i] = tswap64(env->xregs[i]);
     }
-    r->regs[32] = tswapreg(env->pc);
-    r->regs[33] = tswapreg(pstate_read((CPUARMState *)env));
+    r->pt.sp = tswap64(env->xregs[31]);
+    r->pt.pc = tswap64(env->pc);
+    r->pt.pstate = tswap64(pstate_read((CPUARMState *)env));
 }
-- 
2.43.0


