Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C7C8C54798
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 13:54:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhVF7-0002mP-1r; Tue, 05 Mar 2024 08:54:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rhVE7-0000yX-HD
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 08:53:09 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rhVDt-0005yY-I6
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 08:53:01 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-33d28468666so3791254f8f.0
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 05:52:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709646768; x=1710251568; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=FXV4byW7NW0KAiWMPyEzYmL7ozL2tTK1qICThutJLjQ=;
 b=zcASCyfmUFjW6ottGt8EJa+TuxnPrNmeHGMBV39T0JkibWYHpsDCq/zz8p0W/KS1he
 b51re6mcXhj/V0sKt/xNmjTcSF4rlfTaSZk6NcmuUILZ1+dBJ0Ha6v9MEWw5HO1FH2U1
 JxwGmgkDGA1CO4zofBrU2xZNe6AK7nBcR/Jftm92Ba3PXItu81/uiew5oNE3iYnG3h8E
 jILwiFldwApkZwlZCHtkoKayzIq1yyoCe+HgzZZpsSaF+PPlr7gyvkqNQyNe2khhfcED
 TTNyVMzx3Oxm8GG5s5KyTFIEPD+67KOL5+W1cSolw2IXW7WNUVaCd+rlJS11nQdqc9eM
 lM0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709646768; x=1710251568;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FXV4byW7NW0KAiWMPyEzYmL7ozL2tTK1qICThutJLjQ=;
 b=MhUFq/bqhkB9cbQBuHqYM/ImPg4jkKe/D4qhoa9k1j972rzNrB21LMl1/vxo/AP6Rc
 toyGUyqlWI4U/XKuBGsybDL6Mj3DGw4L4G4tPKE/pN9zEgtK8A8Jb3wDiHc6JZrRPf2v
 04FZGCDYU5DAvyXKZRboSGXTjnr/Vaq0eDbPAMTSr4cxSogGCD7NDz9TFmnM3g3xTbQ6
 qhG58SRpVA329oQw4lw0cV44rkPBqn4htU856ZEI9z7dXhT6gHTARsGfPiHpVrjoaXkM
 4J5WROlfS2joawGa5nNWkyOm27hQTRfMneFm3jE5yRsEvV2PCztrKtRFgCncxnVgtdX4
 mzGA==
X-Gm-Message-State: AOJu0YxpfK0DlXALXgfL/YtLmwMf0Td/dcaCO02wt6bE3XEdfhVOpP/c
 ioB5pHjRJ5UHrj0vKIg+IWEfE/zPQtfDuY4LMLmRZG942poSp0eDCZEm28adSgLlz6ueNjgPScp
 E
X-Google-Smtp-Source: AGHT+IEm8P39LQghdUDn7PFnk1waqB1EKiy7jsZThAleW+37bydRn7e8mVahJLHu4Chdjd1RXfNZLQ==
X-Received: by 2002:a5d:550b:0:b0:33d:47d1:38c3 with SMTP id
 b11-20020a5d550b000000b0033d47d138c3mr9364064wrv.36.1709646767727; 
 Tue, 05 Mar 2024 05:52:47 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 x3-20020a5d6503000000b0033e206a0a7asm11797532wru.26.2024.03.05.05.52.47
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Mar 2024 05:52:47 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 18/20] target/arm: Do memory type alignment check when
 translation enabled
Date: Tue,  5 Mar 2024 13:52:35 +0000
Message-Id: <20240305135237.3111642-19-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240305135237.3111642-1-peter.maydell@linaro.org>
References: <20240305135237.3111642-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Richard Henderson <richard.henderson@linaro.org>

If translation is enabled, and the PTE memory type is Device,
enable checking alignment via TLB_CHECK_ALIGNMENT.  While the
check is done later than it should be per the ARM, it's better
than not performing the check at all.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20240301204110.656742-7-richard.henderson@linaro.org
[PMM: tweaks to comment text]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/ptw.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index ba1a27ca2b5..31ae43f60ed 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -471,6 +471,16 @@ static bool granule_protection_check(CPUARMState *env, uint64_t paddress,
     return false;
 }
 
+static bool S1_attrs_are_device(uint8_t attrs)
+{
+    /*
+     * This slightly under-decodes the MAIR_ELx field:
+     * 0b0000dd01 is Device with FEAT_XS, otherwise UNPREDICTABLE;
+     * 0b0000dd1x is UNPREDICTABLE.
+     */
+    return (attrs & 0xf0) == 0;
+}
+
 static bool S2_attrs_are_device(uint64_t hcr, uint8_t attrs)
 {
     /*
@@ -1684,6 +1694,7 @@ static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
     bool aarch64 = arm_el_is_aa64(env, el);
     uint64_t descriptor, new_descriptor;
     ARMSecuritySpace out_space;
+    bool device;
 
     /* TODO: This code does not support shareability levels. */
     if (aarch64) {
@@ -2106,6 +2117,12 @@ static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
     if (regime_is_stage2(mmu_idx)) {
         result->cacheattrs.is_s2_format = true;
         result->cacheattrs.attrs = extract32(attrs, 2, 4);
+        /*
+         * Security state does not really affect HCR_EL2.FWB;
+         * we only need to filter FWB for aa32 or other FEAT.
+         */
+        device = S2_attrs_are_device(arm_hcr_el2_eff(env),
+                                     result->cacheattrs.attrs);
     } else {
         /* Index into MAIR registers for cache attributes */
         uint8_t attrindx = extract32(attrs, 2, 3);
@@ -2118,6 +2135,28 @@ static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
         if (aarch64 && cpu_isar_feature(aa64_bti, cpu)) {
             result->f.extra.arm.guarded = extract64(attrs, 50, 1); /* GP */
         }
+        device = S1_attrs_are_device(result->cacheattrs.attrs);
+    }
+
+    /*
+     * Enable alignment checks on Device memory.
+     *
+     * Per R_XCHFJ, this check is mis-ordered. The correct ordering
+     * for alignment, permission, and stage 2 faults should be:
+     *    - Alignment fault caused by the memory type
+     *    - Permission fault
+     *    - A stage 2 fault on the memory access
+     * but due to the way the TCG softmmu TLB operates, we will have
+     * implicitly done the permission check and the stage2 lookup in
+     * finding the TLB entry, so the alignment check cannot be done sooner.
+     *
+     * In v7, for a CPU without the Virtualization Extensions this
+     * access is UNPREDICTABLE; we choose to make it take the alignment
+     * fault as is required for a v7VE CPU. (QEMU doesn't emulate any
+     * CPUs with ARM_FEATURE_LPAE but not ARM_FEATURE_V7VE anyway.)
+     */
+    if (device) {
+        result->f.tlb_fill_flags |= TLB_CHECK_ALIGNED;
     }
 
     /*
-- 
2.34.1


