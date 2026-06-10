Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BE6CCD98CC
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 16:16:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXLXX-0007fm-R3; Wed, 10 Jun 2026 12:12:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wXLXH-0007Yp-JB
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 12:12:11 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wXLXF-0005RY-Tp
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 12:12:11 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-45ef4223be7so3859790f8f.2
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 09:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781107928; x=1781712728; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=SmRsAHdPQfKrS+Isqf1/STAzX3OBOIAhRjx5G5H4Poc=;
 b=XBwGvT+b9OtV4zlc4nEWNO/zMLaVYXa2kSRnEV4FryBAENw8ZivG2GTkzW5YRR4Fsx
 Svhnkiuz2r6wdyQBUUVAeK4rWJTKvuAptdPSQt9xXorOKUDIc6Q4pnEPL9TvWtJMMmkP
 T6k6hg9N1OY6VxZerjiWENithDKw256IhKcwwz3kaV22iex0nYnCAGy3AfB4PrLBnVGn
 GhKoDHufda7mYTke6ZdWh6+dO5uaJy3uEL5Z3yaVHtomggc1o/KAkUNXX5eMcI6koU8Q
 Mko8nQmF5I+3qsieAn5SHiAab9aAm9x0ceSeZ8SCGV844O40UJ5BZi03Jzylh6PLgNsx
 91XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781107928; x=1781712728;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=SmRsAHdPQfKrS+Isqf1/STAzX3OBOIAhRjx5G5H4Poc=;
 b=j1lRCSjLCACjQmpfFwNYTeDOZI/AB4gn9aO82slWmUNmdQLNVCA2OiKLW9FEu5texm
 0zUUPR92WjuxjkFyt9x7g67t5E9+Jie92zD+ParyztWpZxbqFt8i69qQiNl+RcQdg2j3
 mY+TOc3OgfrC8MtGt2Xvby3ScSzm68OgTK0SoEWG70iVmF0CzU/O3LYScJ+BoC3peOat
 RapT70/ik1tlqdz9XxpZbu47zi1AZVl/mlzz/O252kxciwiKETBA3/NuFSnYjmbZUQwN
 0EoAQ9u8nfnXhvNUim3+dkDLf2TsAiJMgNY9d983+Y8UYzYtonHDKTMnuvmdXfRWCN9E
 lZnQ==
X-Gm-Message-State: AOJu0YwTod0flZgiHUrx1HfhlqEIPFEVIxsSTWnBsFCt+eHB+VrtmAhu
 CS5mw7f9GQjTdpCGfVId6u65tbljsTWEKwudfiSSNu0UA+19fjzh4OOvdz+5G7eXd5Ah9BKs4FP
 +3Uwf
X-Gm-Gg: Acq92OHhwltcRABbrdOq6Qz6LgtBjAufX0zY4rBqEvGhowtT1C2oUCc/GsZl3+gTzgi
 8T3ergQAquCx3NKZoUrFKQZ4iEm+c6PI0t/eODgdNUPZEU6y8u2tDpWqTaGYh56Fkn719rnAIzU
 JwHQLGzuuFLB3ttED1HSdp4sLVtDB6AtMj7cqYAXpW0YjUWw6/FIasmr813Uh1TCvL6ERhnOGUK
 VWKwqVuxy7oGif/1RE+RqP9ZsiVJZjSWVqJ9257LvVGpbDVUHYbOjE1Ttky4VuwBfX3ACn+5Pir
 Bnlqg58sQJMHURubQMVcHsmiTPYrpm/SXvYs21ZuW76QHSJvyVltmPpwrtOPyCW9tjTB0klx1n9
 inCuZG5TeNu+EIMaG5ky1/8WulG2DiJciAXp2FaTB/Y5pe3w4ju6hMG+loB5obF65SAAMcI16pb
 BjMrMspsc6VjLiOnFwMtljaPRBZYHIpd5oCi4M2DM8WCR7UaTtZCh79iR7P6e5AVVDJEvTxOLhQ
 7fwFpkxlff7RA55b9WJD/k7b8mz81eGFqZw3qNfi3+Pr1pK/dM75A==
X-Received: by 2002:a05:6000:420b:b0:43d:775b:c9bd with SMTP id
 ffacd0b85a97d-4605668d9f7mr11202382f8f.10.1781107928223; 
 Wed, 10 Jun 2026 09:12:08 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f2dcbe3sm67911360f8f.8.2026.06.10.09.12.06
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 09:12:07 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 03/71] target/arm: add TCSO bitmasks to SCTLR
Date: Wed, 10 Jun 2026 17:10:54 +0100
Message-ID: <20260610161202.2235298-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260610161202.2235298-1-peter.maydell@linaro.org>
References: <20260610161202.2235298-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x433.google.com
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

From: Gabriel Brookman <brookmangabriel@gmail.com>

These are the bitmasks used to control the FEAT_MTE_STORE_ONLY feature.
They are now named and setting these fields of SCTLR is ignored if MTE
or MTE4 is disabled, as per convention.

Signed-off-by: Gabriel Brookman <brookmangabriel@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260529-feat-mte4-v7-2-ccbd3c14eb3c@gmail.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu-features.h |  5 +++++
 target/arm/cpu.h          |  2 ++
 target/arm/helper.c       | 20 ++++++++++++++------
 3 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 83897365ad..92400df649 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1196,6 +1196,11 @@ static inline bool isar_feature_aa64_mteperm(const ARMISARegisters *id)
     return FIELD_EX64_IDREG(id, ID_AA64PFR2, MTEPERM) >= 1;
 }
 
+static inline bool isar_feature_aa64_mte_store_only(const ARMISARegisters *id)
+{
+    return FIELD_EX64_IDREG(id, ID_AA64PFR2, MTESTOREONLY) == 1;
+}
+
 static inline bool isar_feature_aa64_sme(const ARMISARegisters *id)
 {
     return FIELD_EX64_IDREG(id, ID_AA64PFR1, SME) != 0;
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 85552b573c..d9c03c9c2e 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1468,6 +1468,8 @@ void pmu_init(ARMCPU *cpu);
 #define SCTLR_EnAS0   (1ULL << 55) /* FEAT_LS64_ACCDATA */
 #define SCTLR_EnALS   (1ULL << 56) /* FEAT_LS64 */
 #define SCTLR_EPAN    (1ULL << 57) /* FEAT_PAN3 */
+#define SCTLR_TCSO0   (1ULL << 58) /* FEAT_MTE_STORE_ONLY */
+#define SCTLR_TCSO    (1ULL << 59) /* FEAT_MTE_STORE_ONLY */
 #define SCTLR_EnTP2   (1ULL << 60) /* FEAT_SME */
 #define SCTLR_NMI     (1ULL << 61) /* FEAT_NMI */
 #define SCTLR_SPINTMASK (1ULL << 62) /* FEAT_NMI */
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 9dd8fdfa41..bb77cbae51 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -3300,12 +3300,20 @@ static void sctlr_write(CPUARMState *env, const ARMCPRegInfo *ri,
 
     /* ??? Lots of these bits are not implemented.  */
 
-    if (ri->state == ARM_CP_STATE_AA64 && !cpu_isar_feature(aa64_mte, cpu)) {
-        if (ri->opc1 == 6) { /* SCTLR_EL3 */
-            value &= ~(SCTLR_ITFSB | SCTLR_TCF | SCTLR_ATA);
-        } else {
-            value &= ~(SCTLR_ITFSB | SCTLR_TCF0 | SCTLR_TCF |
-                       SCTLR_ATA0 | SCTLR_ATA);
+    if (ri->state == ARM_CP_STATE_AA64) {
+        if (!cpu_isar_feature(aa64_mte, cpu)) {
+            if (ri->opc1 == 6) { /* SCTLR_EL3 */
+                value &= ~(SCTLR_ITFSB | SCTLR_TCF | SCTLR_ATA | SCTLR_TCSO);
+            } else {
+                value &= ~(SCTLR_ITFSB | SCTLR_TCF0 | SCTLR_TCF |
+                           SCTLR_ATA0 | SCTLR_ATA | SCTLR_TCSO | SCTLR_TCSO0);
+            }
+        } else if (!cpu_isar_feature(aa64_mte_store_only, cpu)) { /* not mte4 */
+            if (ri->opc1 == 6) { /* SCTLR_EL3 */
+                value &= ~SCTLR_TCSO;
+            } else {
+                value &= ~(SCTLR_TCSO | SCTLR_TCSO0);
+            }
         }
     }
 
-- 
2.43.0


