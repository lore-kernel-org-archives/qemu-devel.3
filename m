Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B016AC54E4A
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 20:42:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rg9h9-00021b-PB; Fri, 01 Mar 2024 15:41:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rg9h8-0001zi-8j
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 15:41:26 -0500
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rg9h5-000705-KQ
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 15:41:25 -0500
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-29abd02d0d9so1926710a91.0
 for <qemu-devel@nongnu.org>; Fri, 01 Mar 2024 12:41:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709325682; x=1709930482; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TxofW6bNC8fGOO2v/wfoJQ/7dw6hp4z2OqJzWySAJjk=;
 b=CdcT8qGonIpTT6BsZgxe2USZBV5JQwyWBy/Ptj7UCpLUuz/SsLNBnDf8ZDKjcgah2N
 MibYlncFyi/4v9y6FDm/o+zkjvFEgdnDsYjECbRYx5/jk/xbwPjjMa7UScGDI4p+DPUm
 nXLTHxKhurxsZsvtV/qfb5AdSL7P4OyprG4MrriIIqy/5LjjGcnASJSZsKRbwQXOSuCv
 lytpVxjrfxkIkNDkvxRFgdEr+XQPN0G89c/1tWI9hPjVzmrpQAHGZKUnrIdH1uYQA0dB
 n01sHmiJd+4WtWs9hIMt9J+mFGozTkidWVdfNVsyArNqI8uMDbyn9siVQG5BYAAlg75O
 xH+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709325682; x=1709930482;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TxofW6bNC8fGOO2v/wfoJQ/7dw6hp4z2OqJzWySAJjk=;
 b=p3Zt4SA0kn4dELfE5yTJBEWn6GXFgF86Aqw/i2wNyPXJCSiDNZAQhJdc/gkOoPO94s
 7X6nH4hOw8wJ2lNzG0U5vVuuXEFIk7iDDymDvb+y1JX8wJjckKRrNcW6zGpCyBiVYlL1
 m77ySEu72YBXTPZsSN47mNJ1lEMjFGOQCpS2anCApSU2mVhPgFK40+00D20R4YfFHWFx
 9g/QhdxTOPo18L/lVI7GFcgt+CoBvpMvFEzlGWqLFMwO+WB1Jva4ERMuwy0K4Iv6FnK6
 HX4eM6nHYsm/sfyB6P5PF3GFZggHtCKz60KfOK72qSh8/CBu9wK3U0jaCVz1VSOkFSKM
 A6oQ==
X-Gm-Message-State: AOJu0YwBvVJQuJGfD3vrKP4eKLDldXK6zraHzSlJUiJAqUtUCsHk1LJh
 p2Vu6Jc02Agu2ABusxuGXEsmaOkf+Yk6A2u06SlSiBWcF9zMk+v2Baf1bKiz1CZh4OEt9H+rHUp
 5
X-Google-Smtp-Source: AGHT+IFNvNmwyWmQmn+FpdkfmWoQvf4px2mQhOqUVg6KSRMQrrWNCtTL4ucKsYbxyYfeAP/902q0Rw==
X-Received: by 2002:a17:90a:d718:b0:29b:1699:f5dc with SMTP id
 y24-20020a17090ad71800b0029b1699f5dcmr2822868pju.9.1709325682044; 
 Fri, 01 Mar 2024 12:41:22 -0800 (PST)
Received: from stoup.. (098-147-055-211.res.spectrum.com. [98.147.55.211])
 by smtp.gmail.com with ESMTPSA id
 l3-20020a17090ac58300b0029b2e00359esm681947pjt.36.2024.03.01.12.41.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Mar 2024 12:41:21 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v3 6/6] target/arm: Do memory type alignment check when
 translation enabled
Date: Fri,  1 Mar 2024 10:41:10 -1000
Message-Id: <20240301204110.656742-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240301204110.656742-1-richard.henderson@linaro.org>
References: <20240301204110.656742-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1034.google.com
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

If translation is enabled, and the PTE memory type is Device,
enable checking alignment via TLB_CHECK_ALIGNMENT.  While the
check is done later than it should be per the ARM, it's better
than not performing the check at all.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/ptw.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index ba1a27ca2b..fc2f226411 100644
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
@@ -2118,6 +2135,21 @@ static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
         if (aarch64 && cpu_isar_feature(aa64_bti, cpu)) {
             result->f.extra.arm.guarded = extract64(attrs, 50, 1); /* GP */
         }
+        device = S1_attrs_are_device(result->cacheattrs.attrs);
+    }
+
+    /*
+     * Enable alignment checks on Device memory.
+     *
+     * Per R_XCHFJ, this check is mis-ordered, in that this alignment check
+     * should have priority 30, while the permission check should be next at
+     * priority 31 and stage2 translation faults come after that.
+     * Due to the way the TCG softmmu TLB operates, we will have implicitly
+     * done the permission check and the stage2 lookup in finding the TLB
+     * entry, so the alignment check cannot be done sooner.
+     */
+    if (device) {
+        result->f.tlb_fill_flags |= TLB_CHECK_ALIGNED;
     }
 
     /*
-- 
2.34.1


