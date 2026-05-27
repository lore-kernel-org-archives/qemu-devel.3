Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB447CD4F54
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 10:34:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSBZq-0007vM-4r; Wed, 27 May 2026 06:33:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wSBZl-0007jN-RD
 for qemu-devel@nongnu.org; Wed, 27 May 2026 06:33:26 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wSBZj-0001LB-RX
 for qemu-devel@nongnu.org; Wed, 27 May 2026 06:33:25 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4904c1ce4c1so52694865e9.3
 for <qemu-devel@nongnu.org>; Wed, 27 May 2026 03:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779878002; x=1780482802; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=cxlLXKazVgkdAzcA4OOb8u+j32dbEyFYPUeS4I/ui1k=;
 b=LOgElZnkW8vpPhpsecBjxnSe2nJecVvXFp4jxRlXxYxk5MnunkLcLvoVUJyTXsn54C
 KkskoCx002fJjDx2OkyAp8B0GA/DuY7XGTDFWyWFozADP+kJn55QZMRz4FdYl793eFec
 aX93ACqqE5plYz3ttftfz+nSf55MTyZwPdflxQHHhXziUe0519AiPq1fdhlpSxWKJdMZ
 pBdp72P1sHTt40ZGrTenFbn/BfsNVfCKdonkIbMHOMvgVR7OGntL5KO7Gd9EptkzDBz5
 OlEfTlxAmUE4lHmDpLVqfIdTNhSBHXglpUV1EPZEZktjaUfsFYpboNF9RVZkAj+RTH58
 YXlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779878002; x=1780482802;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=cxlLXKazVgkdAzcA4OOb8u+j32dbEyFYPUeS4I/ui1k=;
 b=g0VbCvqvgRCXbWQkYJh8Vt+A5VvsVYPfbdSzaLA7FYEtyKCeFNnwbBWqUQpjYA+Ezi
 5jb4JSmQF0S29anZynHS58jiNPm8agyli2AiWXb+Wq9lH418UbN/5gTPc1AW/RFiIJ8P
 +05jfkqKb9BEQytWyA0iuA6a64XaC/vbxchL4533/zI7EQuhb+zoKYNcegnvyWMeZPYb
 +UrOlJ/CGQeDhFoT2vUvkXxK3c3OSUBaTgHO/6IPgybT2vpQRUFsGsUvVPwd3fuDS1E8
 78tOlSWYkfseD9Qyv/BBsg62ZPCxYcjFaHoUlNC/iaeqc4wr3X96F5HQoDk2QTiNoSZ0
 zCBQ==
X-Gm-Message-State: AOJu0YxvkW+k1mRH+YhVlijjTc/DCVJUga7DZ2CUFnA/4WYBxpzsdam1
 dy+Lpsn/dvZgrB+iFvQQ4p0CFvVI+fWrIe06Cg/1ttZif/fozmEZFjlOs7sZokx9d/at00V1Za1
 xCgH1YbBC2Q==
X-Gm-Gg: Acq92OEPEEVtKNj6OQ+epqoCDHd9wUifWRDiOfnbMZ9Ypvdf2pQShzxg9ZCFkjgGCpr
 LHyHSbeHlzy4krWR26eQ18qHzvroMPeJewQJlFpIDN2pBTZ76xKWcnVM2/y+UN46L2l+nIBnQ1U
 tfJVajWu2PQct0rX82L/4ot4LAJvMTqh9PdL3d1Ef8UraShgJ2DfR7I8aTgY72/xDZ5a7Fdw62J
 yuCpEOgYrXB2RzvPzuT7SBAcnODOIRvs5Z/AnCWuUTFmkCCxaRMBRHDykxrAfLKM/XmZLSVgLsc
 nbDdDclTvECeROPUA263ycL8GAMOnaICcQY+kCvpxkcWSHSvWHHax1FjBreDpLvl3xJCILW8Vuk
 3Vd/vBbc2ezCcNnVdjZE0ff+b1Yqe3EAKHjjdXPajuRdr1WAqcEb7N98ECipa6dF64+Mo2uwL8H
 aYgYo622CGLsnlje9EZ5XwE0vzEso+bCuiX8nS7tW/1ZOyTFk2/3yi7dY=
X-Received: by 2002:a05:600c:4510:b0:489:1c1f:35df with SMTP id
 5b1f17b1804b1-490424a682emr348815505e9.10.1779878001909; 
 Wed, 27 May 2026 03:33:21 -0700 (PDT)
Received: from m17.home (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45edb5b2ba9sm4881141f8f.31.2026.05.27.03.33.21
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 27 May 2026 03:33:21 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 24/32] target/arm: Factor aarch64_aa32_a57_init() out
Date: Wed, 27 May 2026 12:30:28 +0200
Message-ID: <20260527103037.4461-25-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260527103037.4461-1-philmd@linaro.org>
References: <20260527103037.4461-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

In order to make the following commit easier to review,
factor aarch64_aa32_a57_init() out of aarch64_a57_initfn()
as a preliminary step. We only add a %aa32_only argument
to restrict AArch64 features.

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Acked-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <20260526203722.79463-14-philmd@linaro.org>
---
 target/arm/cpu64.c | 36 ++++++++++++++++++++++++------------
 1 file changed, 24 insertions(+), 12 deletions(-)

diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 7b2f09cf8ec..7dce17fdb20 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -686,17 +686,20 @@ void aarch64_cpu_lpa2_finalize(ARMCPU *cpu, Error **errp)
     SET_IDREG(&cpu->isar, ID_AA64MMFR0, t);
 }
 
-static void aarch64_a57_initfn(Object *obj)
+static void aarch64_aa32_a57_init(Object *obj, bool aa32_only)
 {
     ARMCPU *cpu = ARM_CPU(obj);
     ARMISARegisters *isar = &cpu->isar;
+    const bool aarch64_enabled = !aa32_only;
 
     cpu->dtb_compatible = "arm,cortex-a57";
     set_feature(&cpu->env, ARM_FEATURE_V8);
     set_feature(&cpu->env, ARM_FEATURE_NEON);
     set_feature(&cpu->env, ARM_FEATURE_GENERIC_TIMER);
     set_feature(&cpu->env, ARM_FEATURE_BACKCOMPAT_CNTFRQ);
-    set_feature(&cpu->env, ARM_FEATURE_AARCH64);
+    if (aarch64_enabled) {
+        set_feature(&cpu->env, ARM_FEATURE_AARCH64);
+    }
     set_feature(&cpu->env, ARM_FEATURE_CBAR_RO);
     set_feature(&cpu->env, ARM_FEATURE_EL2);
     set_feature(&cpu->env, ARM_FEATURE_EL3);
@@ -727,10 +730,12 @@ static void aarch64_a57_initfn(Object *obj)
     SET_IDREG(isar, ID_ISAR4, 0x00011142);
     SET_IDREG(isar, ID_ISAR5, 0x00011121);
     SET_IDREG(isar, ID_ISAR6, 0);
-    SET_IDREG(isar, ID_AA64PFR0, 0x00002222);
-    SET_IDREG(isar, ID_AA64DFR0, 0x10305106);
-    SET_IDREG(isar, ID_AA64ISAR0, 0x00011120);
-    SET_IDREG(isar, ID_AA64MMFR0, 0x00001124);
+    if (aarch64_enabled) {
+        SET_IDREG(isar, ID_AA64PFR0, 0x00002222);
+        SET_IDREG(isar, ID_AA64DFR0, 0x10305106);
+        SET_IDREG(isar, ID_AA64ISAR0, 0x00011120);
+        SET_IDREG(isar, ID_AA64MMFR0, 0x00001124);
+    }
     cpu->isar.dbgdidr = 0x3516d000;
     cpu->isar.dbgdevid = 0x01110f13;
     cpu->isar.dbgdevid1 = 0x2;
@@ -742,14 +747,21 @@ static void aarch64_a57_initfn(Object *obj)
     cpu->ccsidr[1] = make_ccsidr(CCSIDR_FORMAT_LEGACY, 3, 64, 48 * KiB, 2);
     /* 2048KB L2 cache */
     cpu->ccsidr[2] = make_ccsidr(CCSIDR_FORMAT_LEGACY, 16, 64, 2 * MiB, 7);
-    set_dczid_bs(cpu, 4); /* 64 bytes */
-    cpu->gic_num_lrs = 4;
-    cpu->gic_vpribits = 5;
-    cpu->gic_vprebits = 5;
-    cpu->gic_pribits = 5;
+    if (aarch64_enabled) {
+        set_dczid_bs(cpu, 4); /* 64 bytes */
+        cpu->gic_num_lrs = 4;
+        cpu->gic_vpribits = 5;
+        cpu->gic_vprebits = 5;
+        cpu->gic_pribits = 5;
+    }
     define_cortex_a72_a57_a53_cp_reginfo(cpu);
 }
 
+static void aarch64_a57_initfn(Object *obj)
+{
+    aarch64_aa32_a57_init(obj, false);
+}
+
 static void aarch64_a53_initfn(Object *obj)
 {
     ARMCPU *cpu = ARM_CPU(obj);
@@ -886,7 +898,7 @@ static void aarch64_max_initfn(Object *obj)
     }
 
     if (tcg_enabled() || qtest_enabled()) {
-        aarch64_a57_initfn(obj);
+        aarch64_aa32_a57_init(obj, false);
     }
 
     /* '-cpu max' for TCG: we currently do this as "A57 with extra things" */
-- 
2.53.0


