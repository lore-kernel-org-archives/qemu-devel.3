Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6A5FCA0EFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 16:38:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNiJ-0003SS-W9; Sat, 30 Aug 2025 11:42:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us7Wy-0002zq-J9
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 18:25:12 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us7Wu-0002st-I8
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 18:25:11 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-772301f8a4cso1238416b3a.3
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 15:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756506305; x=1757111105; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y9AwCvFTz8r3ZgF7ChY2U9tJWuC1SnogfSAKkPVxJRU=;
 b=iyz0nOM3MLH9+/gh7nMx3qfqGFVL21FdgLzYHW9406Sb9yE8pkgGXIv37x+zb+v2Tb
 5B0dbjdrVknap6CvuJU6IGCyHr1OzJAKOi8XhVNVVeP7lJtvIG/YnrBOopPbdv36GTiM
 AWBLoSDE7/Xw6vuabeYvpSpU9ZyJoL06jjyv6lxC0Tn8/7GMRrac/NqEqh0/w4Tm4Qzb
 ZQd82pXQiuAO92YV2iwvFiwFG0krxV8tzoavyNni7NdjvHYEHU2OSHQcvTMaFRYAMpaI
 jCGcCNoHiBB3Z/zG7VQtIZ3mSTknzKL/BuS0NnjvYcq9N8cN7lFPMvdmidgir8vD3Gws
 6Ywg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756506305; x=1757111105;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y9AwCvFTz8r3ZgF7ChY2U9tJWuC1SnogfSAKkPVxJRU=;
 b=kGqMTyV4KMVDns0fg4hH/EEWisSVcCod3si/jDexYJelk+7oELv3kwPAQgoCjAfpfy
 G1OD3FsswO76G9vcKIP+xBTGBSKrvUvcUzUfA02D0Zi6e7hLdJLSHwM5VASFdv3ccpk6
 dRymzmFG3NstSkvFWLMJWJP/iYNg0Z6HoPWzL/BRreo1cx31EGkVrHwnoUhqZPjksRd3
 SMajtzuKynZF3X1yiyaVVmYWsXpNuTwSOfu+hdlHAt2A8eu3MUeY+byinnEFJUIw5JZC
 D3PKfJD+fqjeQI6xSSg6P7MywFy+fOfbo+RTbiajSqKhdHxeI1BtmKL9zZLv3X0tpW/v
 2q6g==
X-Gm-Message-State: AOJu0YyqnJVgP2d8DXo6q1XRoqxC8Cc7yo/90e7yjQxxPfDE0le+YSz3
 6VEHc0Dw2uhUThSZO6lBYZbKK3BL82mfEq1KtaTIe2qQ36tq6ipv7xPrxVIYEB4rnKdEQSNaqoA
 j5aSEi9E=
X-Gm-Gg: ASbGncu1avwFCuwVLMFtX5rzZE8OOPAW5ur/bXbf1symHGFn05wzPD3EpHdkmfkYIwg
 DnzrkUuHhxF4pJ62U+nIf+T+QH9mH1CKAicp6wpkqOBM3ptMUP2L322bZ0BAYJKi2Aep7DnzSuh
 HaKBJuLUnSLahpRgoq88rXKMLR0rLKky13rdHu/DRnv7eiy9REbWaFTCHIOdhH2RCiiocnay6Ji
 UHMhs5OVbJurQFtCCEx3KWPmAatDxfVh2SnmlQdxERAtrUan0TkurGzU4czrLJ0ECexRBnmT0Ip
 +EnycTxrjFe5VGaKE3S7Ic6XzRhfEkjllDAoyXTyWCELS9QVlCcVd3eGexdv2tMbgO8FSTtaAbJ
 xkMggHaJ4JeBoKFRfM/7ZouRqoloC2xsDE88bAXAhAmmiMJL+JJPHsKPByIJkZLqqzQ+YinU=
X-Google-Smtp-Source: AGHT+IEvAFk1L+Pcn/Uzb6O2RnHrfPP/1zS5OHJzZ6IjJGH3HQ3YsJMLWnSlUDxaBb8GfBVdT+LUjg==
X-Received: by 2002:a05:6a20:5483:b0:243:d5ab:d202 with SMTP id
 adf61e73a8af0-243d6e0090emr333558637.15.1756506305279; 
 Fri, 29 Aug 2025 15:25:05 -0700 (PDT)
Received: from stoup.. (122-150-204-12.dyn.ip.vocus.au. [122.150.204.12])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7722a71c60bsm3302493b3a.103.2025.08.29.15.25.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 15:25:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 13/91] linux-user/openrisc: Convert target_elf_gregset_t to a
 struct
Date: Sat, 30 Aug 2025 08:23:09 +1000
Message-ID: <20250829222427.289668-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250829222427.289668-1-richard.henderson@linaro.org>
References: <20250829222427.289668-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 40a5bcccab..da034e5a76 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -655,18 +655,18 @@ static void elf_core_copy_regs(target_elf_gregset_t *r, const CPUMBState *env)
 
 /* See linux kernel arch/openrisc/include/asm/elf.h.  */
 #define ELF_NREG 34 /* gprs and pc, sr */
-typedef target_elf_greg_t target_elf_gregset_t[ELF_NREG];
+typedef struct target_elf_gregset_t {
+    target_elf_greg_t regs[ELF_NREG];
+} target_elf_gregset_t;
 
-static void elf_core_copy_regs(target_elf_gregset_t *regs,
+static void elf_core_copy_regs(target_elf_gregset_t *r,
                                const CPUOpenRISCState *env)
 {
-    int i;
-
-    for (i = 0; i < 32; i++) {
-        (*regs)[i] = tswapreg(cpu_get_gpr(env, i));
+    for (int i = 0; i < 32; i++) {
+        r->regs[i] = tswapreg(cpu_get_gpr(env, i));
     }
-    (*regs)[32] = tswapreg(env->pc);
-    (*regs)[33] = tswapreg(cpu_get_sr(env));
+    r->regs[32] = tswapreg(env->pc);
+    r->regs[33] = tswapreg(cpu_get_sr(env));
 }
 
 #endif /* TARGET_OPENRISC */
-- 
2.43.0


