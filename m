Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE36DCA0FFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 16:38:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNlM-0004ob-IG; Sat, 30 Aug 2025 11:45:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us7bV-0004UP-QE
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 18:29:53 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us7bT-0003eI-8H
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 18:29:53 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-771eecebb09so3480515b3a.3
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 15:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756506590; x=1757111390; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TQEcJTT7KxKo513q/VtGBlaErUnfHZO8KB5vUddw60o=;
 b=m+V+gih3vOacEsT/q8Rau9bfRxoqbW/iqoPDp3kmkL81I6Z2XskUP5CRa2q2O/Uk+r
 6uF890OmqhzC+LnlnCKk8I5Ftz05+5z3Tah8j15hVjGMEebvk7hIyPM/Te0f6JEkANEa
 D2pUDJRAKoG5YBzMBIy661+GN8Pyssp+ljxy2JLwQsDq8Ecigg0oMYdpFYT3rFzOjyR+
 doPpEI6o4ZKFmlGV1NnVGdvM4jJZ+cjI9XiAzt1KyuYlYa56+khUd+KJfp4AEwExceYn
 FLx0qHwHpf5sQmN9a5hwti7D/Ljyz8KEmlXPHvs0//62oQSlmKSXyGZye/hTH9TgWHEq
 EpAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756506590; x=1757111390;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TQEcJTT7KxKo513q/VtGBlaErUnfHZO8KB5vUddw60o=;
 b=O7avYvhmTmeDvYYCEIsxz6NsVfcBzZopyt4u65I6Z2rXfb4TpqbC42+0fHv6yrYzzu
 ck7IIeXblD7ApZkvvh0dlx+ZoiUhl79IXFMFsdopkP5EVVEDkKlxOJ1Ge0i7Tm76jegR
 V+5wposdUnFFqriXtbhrIgcSVvqShj56Jkoc6pPsi8vWYQERhLCrBlnjDAPnsKvvmlA8
 Ctoe7fELjB5BNmoaoc57kRWjH4mYa1kQCM89FwoG/uxYDKiNvrnOapseTTkk+gb+mqFI
 3M3ElBE6Xzh1Wh9Ye/n2CTxvUjGHXnE2CByqCS2DTxWiEeaYz2pqi3A3s4djW0vBXTJr
 jTGA==
X-Gm-Message-State: AOJu0Yy2ErFE8N29aoCCJzVjbWuktJr6SLGsMnWEjV1wvw25rtvC6c1A
 AazEwqxiKRDJ6ajccM2hInmUrCJbC2P2MTIozIqr23rw7fYyRrMFjO/+Id0v6kVy1PLwettRLg+
 2nE3xVoE=
X-Gm-Gg: ASbGncslJX+h6QPBFZf/LgjWCJ0CYqPouYDAxMqAyjrfcKTKZOtoX9Gj0lvqo9Cv9bT
 bkSVKMJt4Sj/+bL9gTVy51c8UMLTL/9biOC1Bvzbev9mWC6z7goOiwjFNhQqOzkgn/RNTdgMaW1
 +eSfn8KY7FD7B0g2fjE2RC6Pg+9xDWtUdRcL7EG4+xeFSh4bqasStjDyp23JoqhP2Z/Fkzi0WXQ
 JXEyYMhk3NZ1bFgzfSVL4/+sCYNikws8NdmIU1wXZb18rL/hif4wcFPDGoLuGueiWFTH31O7V3M
 TNVucDk/UOLvRZZoOfjS/4QfyGfggj95n6h3hlm8wufmqbUEFnz/m6UI247JttWqmbPxaQWMZxb
 iyYJ9y/UV6yFEldPslb7d2prLNjmbgozDqs4+JFja3xXNNFfpQHttuiv1/412Uk6d0OKML1IEbw
 ==
X-Google-Smtp-Source: AGHT+IG+AUm9+euy6mP52to8wU/OJpIBaw3hjE2F6To7AGnabgL273wue8jRDm4RrjzgGS32VLVXcA==
X-Received: by 2002:a05:6a00:cc9:b0:771:f567:5bd2 with SMTP id
 d2e1a72fcca58-7723e3b13d3mr266556b3a.22.1756506589773; 
 Fri, 29 Aug 2025 15:29:49 -0700 (PDT)
Received: from stoup.. (122-150-204-179.dyn.ip.vocus.au. [122.150.204.179])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7722a4bb5dasm3364297b3a.55.2025.08.29.15.29.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 15:29:49 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 56/91] linux-user/s390x: Expand target_elf_gregset_t
Date: Sat, 30 Aug 2025 08:23:52 +1000
Message-ID: <20250829222427.289668-57-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250829222427.289668-1-richard.henderson@linaro.org>
References: <20250829222427.289668-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
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

Make use of the fact that target_elf_gregset_t is a proper structure.
This lets us drop the ugly cast to uint32_t* in the middle.

Drop ELF_NREG, target_elf_greg_t, and tswapreg.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/s390x/target_elf.h | 12 +++++++-----
 linux-user/s390x/elfload.c    | 28 +++++++---------------------
 2 files changed, 14 insertions(+), 26 deletions(-)

diff --git a/linux-user/s390x/target_elf.h b/linux-user/s390x/target_elf.h
index b7d863ee66..670c7b3eed 100644
--- a/linux-user/s390x/target_elf.h
+++ b/linux-user/s390x/target_elf.h
@@ -8,15 +8,17 @@
 #ifndef S390X_TARGET_ELF_H
 #define S390X_TARGET_ELF_H
 
+#include "target_ptrace.h"
+
 #define HAVE_ELF_HWCAP          1
 #define HAVE_ELF_CORE_DUMP      1
 
-typedef abi_ulong target_elf_greg_t;
-
-/* See linux kernel: arch/s390/include/uapi/asm/ptrace.h (s390_regs).  */
-#define ELF_NREG                27
+/*
+ * See linux kernel: arch/s390/include/asm/elf.h, where
+ * elf_gregset_t is typedef'd to struct s390_regs.
+ */
 typedef struct target_elf_gregset_t {
-    target_elf_greg_t regs[ELF_NREG];
+    struct target_s390_regs pt;
 } target_elf_gregset_t;
 
 #endif
diff --git a/linux-user/s390x/elfload.c b/linux-user/s390x/elfload.c
index 4113273b72..27109279e2 100644
--- a/linux-user/s390x/elfload.c
+++ b/linux-user/s390x/elfload.c
@@ -68,29 +68,15 @@ const char *elf_hwcap_str(uint32_t bit)
     return bit < ARRAY_SIZE(hwcap_str) ? hwcap_str[bit] : NULL;
 }
 
-#define tswapreg(ptr)   tswapal(ptr)
-
-enum {
-    TARGET_REG_PSWM = 0,
-    TARGET_REG_PSWA = 1,
-    TARGET_REG_GPRS = 2,
-    TARGET_REG_ARS = 18,
-    TARGET_REG_ORIG_R2 = 26,
-};
-
 void elf_core_copy_regs(target_elf_gregset_t *r, const CPUS390XState *env)
 {
-    int i;
-    uint32_t *aregs;
-
-    r->regs[TARGET_REG_PSWM] = tswapreg(env->psw.mask);
-    r->regs[TARGET_REG_PSWA] = tswapreg(env->psw.addr);
-    for (i = 0; i < 16; i++) {
-        r->regs[TARGET_REG_GPRS + i] = tswapreg(env->regs[i]);
+    r->pt.psw.mask = tswapal(env->psw.mask);
+    r->pt.psw.addr = tswapal(env->psw.addr);
+    for (int i = 0; i < 16; i++) {
+        r->pt.gprs[i] = tswapal(env->regs[i]);
     }
-    aregs = (uint32_t *)&(r->regs[TARGET_REG_ARS]);
-    for (i = 0; i < 16; i++) {
-        aregs[i] = tswap32(env->aregs[i]);
+    for (int i = 0; i < 16; i++) {
+        r->pt.acrs[i] = tswap32(env->aregs[i]);
     }
-    r->regs[TARGET_REG_ORIG_R2] = 0;
+    r->pt.orig_gpr2 = 0;
 }
-- 
2.43.0


