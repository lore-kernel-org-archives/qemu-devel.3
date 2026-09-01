Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D147C61DD3
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 13:25:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1ONA-00011w-Ho; Tue, 01 Sep 2026 09:17:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x1ON6-00010F-2z
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 09:17:52 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x1ON4-0007AR-8l
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 09:17:51 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-c253425b253so132337566b.1
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 06:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788268669; x=1788873469; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=OsrVSZpdhbl0zgw5Bd147ufAXlFL6P0PvWbOYEnG4Tg=;
 b=v2faCUh/9mkJx4wjB6feqdlCLK5XztpF/QjPPRvkRz8k8zLI3105KTmMSBcOzgeOXC
 wxlVZxH4gKcsa25m+GCynYzh4RdIBLz/ZkfCrvw6PNY0NUvMDfIBNJzI3r4T5pU3UYLd
 xDj93xQyQJ8i5eaWOsSsvpiBEmLWi/cnyy67pLc7WZcv1TdMprut7SXZ1N39jlnbNduU
 8xgj2J6x3WrxmRGjstbtfMmkW7wQxnkKWmMn3iXEbcr/lREkc9STOcYjqBwGuFRuqdLL
 Elwd7uX+7IqmrGs/I1hy9xoSNownR3M5fc0DIMBCkW/7aAZz35RIUU5MP8CZzVt7k5wr
 4oYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788268669; x=1788873469;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=OsrVSZpdhbl0zgw5Bd147ufAXlFL6P0PvWbOYEnG4Tg=;
 b=pGAeSvalL/h5X7UpXL1/LVMwbnX205NuPyl+YesNpixZFR2FYmfd1kJq8aKvLGwtzG
 xBA9JYDtmgC17EGmvdPE6xCYbecY/2/HI1VS/ynkwCusBdhq6kViT84IDlMkGI702QX0
 21AMtR0cip9AJH5XakMDYO5i0Te1ZTcHghEftsM+D4jLSTiJeJVBAluxD85P+gtSgdXL
 XOtAAsPtOt/SE+U6hUorG6NGSinX4zWx6bgZwLIgnlrb5e3fLZ83lwnow2Vg10Rr981H
 pAKw39/aODg2y+Km5KsVqs1ydxO72EhG5qNNsj096cioGhapxRrh2XYaFZf/pZISLEoC
 SUlg==
X-Gm-Message-State: AFuF++liHf7AEnWAw7xGG6g26830eFaspeYnbIxbKUKEQXj3G9EgHOjW
 aHqX254/B1U+XBCYFFhVuwmC3sLli+l64/nVriGV04lu7+eMT7+cDvd4I7gPn3Q9COD0NJ2uki5
 IDigX4fE=
X-Gm-Gg: AR+sD11Lu7LJL/PISRX7LAITxiG3daJMp4z/ItwanIjbQfrGGHnEEh40SKs5X5qAVpr
 5iWQlK3dJX4s2OyTEVTMbvJRsu5C9+7vK1J++EEtee0qHAs/paG0no0rNSrdKSDbMVenVE3pquW
 5ZLnzDSVxCQO1GAMms3Zim49n2Nh5U5n5oXdpi6acjRDQnHmQv21RegZyXGT3iRHvF8baFzuUz3
 k7l6H5EXTw6zUybyVl4Ig0YxBjwI/NfgDySNGS2QZOGWgFgNcOZM1l+GU00tOBqkW/PUnvli2tw
 FDZ05s6lbN5t+tvUpD3njr7u9VevcbKyRY0zgg5h/gj4S1Stt0HV1EiaHO1qdLTNfAsYGMiGpzH
 RQHcynVFu66kN2DQaCmafA0RO96cpMhYM/wbv21RV9sxxIch2SgUgR5x2YZOqwhbhJ0sdySb0o/
 KTgg2M1OPsGywPb/MLmOWjQ3EJbSUVhCKzexDoXnumsJFY7gx8oUE4PfV34Qcqc4TGG4Eb37E9x
 MAavF0NxPKtswhYWw7TYVz978KNziaJPttpIp/MAwM6DD9yEMybJmFfJDVc2LlLBfmmuWtEM20Z
 DQAw
X-Received: by 2002:a17:907:cd0e:b0:c25:2fb9:b897 with SMTP id
 a640c23a62f3a-c2557164d7fmr2171221466b.18.1788268668654; 
 Tue, 01 Sep 2026 06:17:48 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c255ee2853dsm617907466b.18.2026.09.01.06.17.47
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 06:17:47 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 14/58] target/arm/tcg/cpu-v7m.c: add cortex-m85 model
Date: Tue,  1 Sep 2026 14:16:48 +0100
Message-ID: <20260901131732.2263947-15-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260901131732.2263947-1-peter.maydell@linaro.org>
References: <20260901131732.2263947-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x632.google.com
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

From: Simon Xu <simonxhy0404@gmail.com>

Add Arm Cortex-M85 CPU.  This is quite similar to the existing
Cortex-M85.  ID register values are based on the r1p1 TRM:
https://developer.arm.com/documentation/101924/0101/

In hardware, PACBTI support can be configured in or out; as QEMU does
not yet implement it, we report it as not present in ID_ISAR5.

Reviewed-by: Owen Giles <owen.giles@hpe.com>
Reviewed-by: Robert Elliott <elliott@hpe.com>
Signed-off-by: Simon Xu <simonxhy0404@gmail.com>
Message-Id: <20260805153005.9989-2-simonxhy0404@gmail.com>
[PMM: tweaked commit message, expanded comment about PACBTI]
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/cpu-v7m.c | 47 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/target/arm/tcg/cpu-v7m.c b/target/arm/tcg/cpu-v7m.c
index dc249ce1f14..48b31d5eac8 100644
--- a/target/arm/tcg/cpu-v7m.c
+++ b/target/arm/tcg/cpu-v7m.c
@@ -237,6 +237,51 @@ static void cortex_m55_initfn(Object *obj)
     cpu->ctr = 0x8303c003;
 }
 
+static void cortex_m85_initfn(Object *obj)
+{
+    ARMCPU *cpu = ARM_CPU(obj);
+    ARMISARegisters *isar = &cpu->isar;
+
+    set_feature(&cpu->env, ARM_FEATURE_V8);
+    set_feature(&cpu->env, ARM_FEATURE_V8_1M);
+    set_feature(&cpu->env, ARM_FEATURE_M);
+    set_feature(&cpu->env, ARM_FEATURE_M_MAIN);
+    set_feature(&cpu->env, ARM_FEATURE_M_SECURITY);
+    set_feature(&cpu->env, ARM_FEATURE_THUMB_DSP);
+    cpu->midr = 0x411fd231; /* r1p1 */
+    cpu->revidr = 0;
+    cpu->pmsav7_dregion = 16;
+    cpu->sau_sregion = 8;
+    /* These are the MVFR* values for the FPU + full MVE configuration */
+    cpu->isar.mvfr0 = 0x10110221;
+    cpu->isar.mvfr1 = 0x12100211;
+    cpu->isar.mvfr2 = 0x00000040;
+    SET_IDREG(isar, ID_PFR0, 0x20000030);
+    SET_IDREG(isar, ID_PFR1, 0x00000230);
+    SET_IDREG(isar, ID_DFR0, 0x10200000);
+    SET_IDREG(isar, ID_AFR0, 0x00000000);
+    SET_IDREG(isar, ID_MMFR0, 0x00111040);
+    SET_IDREG(isar, ID_MMFR1, 0x00000000);
+    SET_IDREG(isar, ID_MMFR2, 0x01000000);
+    SET_IDREG(isar, ID_MMFR3, 0x00000011);
+    SET_IDREG(isar, ID_ISAR0, 0x01103110);
+    SET_IDREG(isar, ID_ISAR1, 0x02212000);
+    SET_IDREG(isar, ID_ISAR2, 0x20232232);
+    SET_IDREG(isar, ID_ISAR3, 0x01111131);
+    SET_IDREG(isar, ID_ISAR4, 0x01310132);
+    /*
+     * Real Cortex-M85 CPUs can be configured with or without PACBTI.
+     * If PACBTI is present then ID_ISAR5[23:20] read as 0b0100,
+     * indicating that QARMA3 is used. QEMU does not yet implement
+     * PACBTI emulation for M-profile, so we report as a "no-PACBTI"
+     * CPU for now.
+     */
+    SET_IDREG(isar, ID_ISAR5, 0x00000000);
+    SET_IDREG(isar, ID_ISAR6, 0x00000000);
+    SET_IDREG(isar, CLIDR, 0x00000000); /* caches not implemented */
+    cpu->ctr = 0x8303c003;
+}
+
 static const TCGCPUOps arm_v7m_tcg_ops = {
     /* ARM processors have a weak memory model */
     .guest_default_memory_order = 0,
@@ -290,6 +335,8 @@ static const ARMCPUInfo arm_v7m_cpus[] = {
                              .class_init = arm_v7m_class_init },
     { .name = "cortex-m55",  .initfn = cortex_m55_initfn,
                              .class_init = arm_v7m_class_init },
+    { .name = "cortex-m85",  .initfn = cortex_m85_initfn,
+                             .class_init = arm_v7m_class_init },
 };
 
 static void arm_v7m_cpu_register_types(void)
-- 
2.43.0


