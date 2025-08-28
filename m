Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8884BC8303F
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 17:31:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urgI8-0006Ez-Oe; Thu, 28 Aug 2025 13:20:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urbW8-000840-6O
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 08:14:18 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urbW0-0008HK-UP
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 08:14:06 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-24646202152so10795755ad.0
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 05:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756383243; x=1756988043; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=69mE6QIBq3ZmENHyPTgP1dYbpvYchVwJFEPdQRbtihM=;
 b=xv/r1xh5msSHloBRpsGse+M5mU16oMurK1O7hjxjsCnd2fSphUMte8V0g6nClE/xE+
 B0qZGzRT7dEGs8QzTSSvUiFgfkRHWIKJd6YoBTjZ24O2s8jOVQuOUlf12Ajc0gnDAGUw
 e+WZiTMUgBGVyfia1uoin1Omt5dZqHo9vxROg3/ozGhcXtwkOZK/Ey7aaaS36CwaEIyn
 38XXXDF6WLs518h4K9mNW5pzsNmI8Suz3f7tHYmUGnS4/EVBaJ1IfbARLjuTxtCrrjDG
 M13kzWhl93Rjonxg/XYgpexNtvXFR2LRTdPyiw0jDDY3AjJ/dVMVDCRyMQGn73+twD41
 tUjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756383243; x=1756988043;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=69mE6QIBq3ZmENHyPTgP1dYbpvYchVwJFEPdQRbtihM=;
 b=lgOCXne5MrlXVfO5mmp9iqRg1xGFy3rb75+Riwc/oQre6B67dAi/QRvNv+x6RSibfM
 V28SVmhlbZ1ETU6RXhB8wGlcgEtBXGQWU23t/ki4haZsg8XbwClPu40Ud2NxYeGVDJA8
 IOmqSz4BJVmEbD6YBCYSz//+O1p0SYqcPF2GGxnGJNblTRxoApyKxF1bIaOAdxdiL7oJ
 0oGhbBw4EXcDsxoug7W8I8u1ilPU0z/90lROm5l3OZXj48hY0fbSAqpXiCtpWuHCVwTa
 PeaZFFeEaR6w6rruqx0/ds0aUidneXGZN90UpzKOr5W8daY23k05J6etUGeID32HIGAz
 /GbA==
X-Gm-Message-State: AOJu0Ywyh9h85l3q7Idx/kVRddpwnnsvqM1jDsVyAQ/02WWAiZh5DxbJ
 lPekFvrnjFOqC4lkmvCxrzaoG/Dt8jHOgbh3gzBxvT7IDU0v7yLSzbeKBcS/hYEgwW98KipB/D/
 ErMqC9BY=
X-Gm-Gg: ASbGncuZlQTPJTJ4PxDUwlrfEw4OiiTEPK42caDEnf1hQeDc7TQnsUncxNvfP7fFiQa
 BlUZUE1PytAiZkKJdDRoCPG/gfH+UrSv0kemsPE5Cl5Qm6Fq0BwzQqcxPmyg5TIpFu3kIdyWdKy
 mUcsGEOluN6tJHmq2Cqyt53YxnHPZG57iN1MnYW+y+prkqvmJyvKdDEfrbuUDV4yMW2wjrO8wIU
 a8QGiXiYgEowJ/Oyap8k0bWVG1NAU04lpAtFNpt5pUUA6yuic8bX7YW7NpHzoDEcokJYdfnMLRH
 QZzC4+vbmRm+m7sMZGjZcu9DUtWfqhwApNFccT/AfpeY9PCdkH85ckYIs64Q/3UmaBsQDH4rtMz
 KwvUYPy0Hg5lgoFUTS4kukFBMTfExghK8h7Ax
X-Google-Smtp-Source: AGHT+IFdLJIpRp1Ou8yY2NuTtNiJhO61lIo284ui+XVaPL5gpQWrdFYaxwomgF3gbI/uyGmZaauDOg==
X-Received: by 2002:a17:903:1a45:b0:246:ddd6:f8b9 with SMTP id
 d9443c01a7336-246ddd6fd04mr196377315ad.43.1756383242807; 
 Thu, 28 Aug 2025 05:14:02 -0700 (PDT)
Received: from stoup.. ([144.6.121.55]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-248e3e0b75esm15129025ad.8.2025.08.28.05.14.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Aug 2025 05:14:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH v3 52/87] linux-user/s390x: Expand target_elf_gregset_t
Date: Thu, 28 Aug 2025 22:08:01 +1000
Message-ID: <20250828120836.195358-53-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250828120836.195358-1-richard.henderson@linaro.org>
References: <20250828120836.195358-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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


