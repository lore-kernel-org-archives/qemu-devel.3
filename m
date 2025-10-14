Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4ECECCD18E
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 20:11:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8lK0-0002fq-Sc; Tue, 14 Oct 2025 16:08:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v8lJv-0002bD-0o
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 16:08:31 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v8lJ8-0005P7-LD
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 16:08:28 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-26983b5411aso39791245ad.1
 for <qemu-devel@nongnu.org>; Tue, 14 Oct 2025 13:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760472459; x=1761077259; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rr1SG8CwBu1VucnWWptPEVYa6789mPM+H15vQvTLSsc=;
 b=TNuILdKq1pYfyunE+iGfvriYFwSUagCXh7qczAFOn+boVgvsaVKBPgo1rzakiNvY3z
 +uQiJyWjTcIbWA30oWpDehP8j2h3gxTqUvTUXzaNqvudVtv2wXoE2l3KajE2QQjDgtnw
 BBTDSZKLbQ1LKLY7tHzGQdDzQ0Rf4lVkiLUwYwVrr5M2IgPEnYProo8oZae6pKONsI0c
 7DW/4//JuE4dz7dK97WR4ieQa/OZemD6oEI3DhdrJun7dz7sFvQpWndkW1u03/fORFB7
 Y6uf14I6uhuISPBaWouqJGNcqOV/+2IcYoCTPvSFc3yXDkHdR2H6PQ4u+/svl8+DtDcI
 Sw+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760472459; x=1761077259;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rr1SG8CwBu1VucnWWptPEVYa6789mPM+H15vQvTLSsc=;
 b=drBURE7jIgBR2mdgWV7N1W6FsIIWfaVxGCIgOFyhoDjSLXDQK6vXqDtB738d0nYv2Y
 /5G2oj6gU4ApDp2grPvqQlnnutuzOjOYnbyMX5GWvr+szJphIcZhE/mCPKYjYmyuN23N
 +GyAZzSBuyxFeyDjz3jW1QzPxaQ26JGF1Is/yqlPbO96zBor6w5TuOhgx1ETnoZ+o2zn
 A4Tf/jmuflJm0k4fJ5m//S8QNvvO5crwqPqfkfMau1EYXsRZQ5xzoyaynbE6lhxnBU71
 yr8r/68poAK2nn13EmDzrRbHDmi3oTChdfoj9NLkyqXYAnHMRsD+z1pnVmiAwUVoDIAP
 FmBA==
X-Gm-Message-State: AOJu0YzkCDMos020DM66P92JetVRbO52YNyWlHydbJ3+PNqmfbnNoExI
 +znMnAcbIpj7ywbN3r8/ndnh8PfsAYv6IroS0/EtNJL2ZYU4rFv4V5qEeHNI7cjA5+kwf8nMsD/
 x/TEBDjQ=
X-Gm-Gg: ASbGnctX0AUUX7J+aFQ+IVeHE+OIRWCHTg5JpYAPaqKYVFNXbjQWRVeSCKeByBIrFov
 EhqLTxrKj4RuKPV96RzQUhm0yYSG6UO8YySfJHJ4XUNTovKVHEEOZgG6liRrLXiaJ2GY0bnxKjO
 zlHoxEQ3NblAjcaY0PkWezWFddPxo5mfFP84dvK8Src2J9nhisH2OoQ+6QZyiVHB0RHw3zJ2W6s
 TBlN08laWscZRBNqDa0Ui4Jv9bm9zYFMXTg+x3SQQtPZg6u5L54PZOrcPhFXn4lCo9iQC977/vD
 MYNBpPVX9VJSAChxd2KoF70PFEfBobG4Q7ReIQcmOxQwlYfNOV2/qfPjH8sPFg2aVibCUiSVJDO
 EzUUXeW9QDyqpI+iyQYZRgmniBH69tRNin7Yh8WZ5+hSGAlPcL0R2J8kUUzg5gw==
X-Google-Smtp-Source: AGHT+IEORm2OempA0nprPva33Zskk7T3VigLl9Y+4Lc4uKfEMDCSHxmj27ZDKs3CzVXyERBoldcobQ==
X-Received: by 2002:a17:903:2f0e:b0:248:a642:eec6 with SMTP id
 d9443c01a7336-29027402f2dmr280496955ad.50.1760472459497; 
 Tue, 14 Oct 2025 13:07:39 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29034f93ea2sm172100975ad.126.2025.10.14.13.07.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Oct 2025 13:07:39 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v2 28/37] target/arm: Implement TLBIP RVAE1, RVAAE1, RVALE1,
 RVAALE1
Date: Tue, 14 Oct 2025 13:07:09 -0700
Message-ID: <20251014200718.422022-29-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251014200718.422022-1-richard.henderson@linaro.org>
References: <20251014200718.422022-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/tlb-insns.c | 93 ++++++++++++++++++++++++++++++--------
 1 file changed, 74 insertions(+), 19 deletions(-)

diff --git a/target/arm/tcg/tlb-insns.c b/target/arm/tcg/tlb-insns.c
index f7510a1208..daadba7bfc 100644
--- a/target/arm/tcg/tlb-insns.c
+++ b/target/arm/tcg/tlb-insns.c
@@ -918,16 +918,43 @@ static TLBIRange tlbi_aa64_get_range(CPUARMState *env, ARMMMUIdx mmuidx,
     return ret;
 }
 
-static void do_rvae_write(CPUARMState *env, uint64_t value,
-                          int idxmap, bool synced)
+static TLBIRange tlbi_aa64_get_range128(CPUARMState *env, ARMMMUIdx mmuidx,
+                                        uint64_t vallo, uint64_t valhi)
 {
-    ARMMMUIdx one_idx = ARM_MMU_IDX_A | ctz32(idxmap);
-    TLBIRange range;
-    int bits;
+    uint64_t uaddr = extract64(valhi << 12, 0, 56);
+    ARMVAParameters param = aa64_va_parameters(env, uaddr, mmuidx, true, false);
+    TLBIRange ret = { };
+    unsigned page_size_granule = extract64(vallo, 46, 2);
+    ARMGranuleSize gran = tlbi_range_tg_to_gran_size(page_size_granule);
 
-    range = tlbi_aa64_get_range(env, one_idx, value);
-    bits = tlbbits_for_regime(env, one_idx, range.base);
+    /* The granule encoded in value must match the granule in use. */
+    if (gran != param.gran) {
+        qemu_log_mask(LOG_GUEST_ERROR, "Invalid tlbi page size granule %d\n",
+                      page_size_granule);
+    } else {
+        unsigned page_shift = arm_granule_bits(gran);
+        unsigned num = extract64(vallo, 39, 5);
+        unsigned scale = extract64(vallo, 44, 2);
+        unsigned exponent = (5 * scale) + 1;
+        uint64_t max = 1ull << 56;
 
+        ret.length = (num + 1) << (exponent + page_shift);
+        ret.length = MIN(ret.length, max - uaddr);
+        /*
+         * Note that TLBIPRange ignores the high bits, because the HW TLB
+         * does not use it.  But the qemu softmmu tlb does, so sign-extend
+         * if and only if the regime has two ranges.
+         */
+        ret.base = uaddr | (-(uint64_t)param.select << 56);
+    }
+
+    return ret;
+}
+
+static void do_flush_range(CPUARMState *env, ARMMMUIdx one_idx, int idxmap,
+                           bool synced, TLBIRange range)
+{
+    int bits = tlbbits_for_regime(env, one_idx, range.base);
     if (synced) {
         tlb_flush_range_by_mmuidx_all_cpus_synced(env_cpu(env),
                                                   range.base,
@@ -940,6 +967,22 @@ static void do_rvae_write(CPUARMState *env, uint64_t value,
     }
 }
 
+static void do_rvae_write(CPUARMState *env, uint64_t value,
+                          int idxmap, bool synced)
+{
+    ARMMMUIdx one_idx = ARM_MMU_IDX_A | ctz32(idxmap);
+    do_flush_range(env, one_idx, idxmap, synced,
+                   tlbi_aa64_get_range(env, one_idx, value));
+}
+
+static void do_rvae_write128(CPUARMState *env, uint64_t vallo, uint64_t valhi,
+                             int idxmap, bool synced)
+{
+    ARMMMUIdx one_idx = ARM_MMU_IDX_A | ctz32(idxmap);
+    do_flush_range(env, one_idx, idxmap, synced,
+                   tlbi_aa64_get_range128(env, one_idx, vallo, valhi));
+}
+
 static void tlbi_aa64_rvae1_write(CPUARMState *env,
                                   const ARMCPRegInfo *ri,
                                   uint64_t value)
@@ -955,6 +998,14 @@ static void tlbi_aa64_rvae1_write(CPUARMState *env,
                   tlb_force_broadcast(env));
 }
 
+static void tlbi_aa64_rvae1_write128(CPUARMState *env,
+                                     const ARMCPRegInfo *ri,
+                                     uint64_t vallo, uint64_t valhi)
+{
+    do_rvae_write128(env, vallo, valhi, vae1_tlbmask(env),
+                     tlb_force_broadcast(env));
+}
+
 static void tlbi_aa64_rvae1is_write(CPUARMState *env,
                                     const ARMCPRegInfo *ri,
                                     uint64_t value)
@@ -1095,28 +1146,32 @@ static const ARMCPRegInfo tlbirange_reginfo[] = {
       .writefn = tlbi_aa64_rvae1is_write },
     { .name = "TLBI_RVAE1", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 0, .crn = 8, .crm = 6, .opc2 = 1,
-      .access = PL1_W, .accessfn = access_ttlb,
-      .type = ARM_CP_NO_RAW | ARM_CP_ADD_TLBI_NXS,
+      .access = PL1_W, .accessfn = access_ttlb, .access128fn = access_ttlb,
+      .type = ARM_CP_NO_RAW | ARM_CP_ADD_TLBI_NXS | ARM_CP_128BIT,
       .fgt = FGT_TLBIRVAE1,
-      .writefn = tlbi_aa64_rvae1_write },
+      .writefn = tlbi_aa64_rvae1_write,
+      .write128fn = tlbi_aa64_rvae1_write128 },
     { .name = "TLBI_RVAAE1", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 0, .crn = 8, .crm = 6, .opc2 = 3,
-      .access = PL1_W, .accessfn = access_ttlb,
-      .type = ARM_CP_NO_RAW | ARM_CP_ADD_TLBI_NXS,
+      .access = PL1_W, .accessfn = access_ttlb, .access128fn = access_ttlb,
+      .type = ARM_CP_NO_RAW | ARM_CP_ADD_TLBI_NXS | ARM_CP_128BIT,
       .fgt = FGT_TLBIRVAAE1,
-      .writefn = tlbi_aa64_rvae1_write },
+      .writefn = tlbi_aa64_rvae1_write,
+      .write128fn = tlbi_aa64_rvae1_write128 },
    { .name = "TLBI_RVALE1", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 0, .crn = 8, .crm = 6, .opc2 = 5,
-      .access = PL1_W, .accessfn = access_ttlb,
-      .type = ARM_CP_NO_RAW | ARM_CP_ADD_TLBI_NXS,
+      .access = PL1_W, .accessfn = access_ttlb, .access128fn = access_ttlb,
+      .type = ARM_CP_NO_RAW | ARM_CP_ADD_TLBI_NXS | ARM_CP_128BIT,
       .fgt = FGT_TLBIRVALE1,
-      .writefn = tlbi_aa64_rvae1_write },
+      .writefn = tlbi_aa64_rvae1_write,
+      .write128fn = tlbi_aa64_rvae1_write128 },
     { .name = "TLBI_RVAALE1", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 0, .crn = 8, .crm = 6, .opc2 = 7,
-      .access = PL1_W, .accessfn = access_ttlb,
-      .type = ARM_CP_NO_RAW | ARM_CP_ADD_TLBI_NXS,
+      .access = PL1_W, .accessfn = access_ttlb, .access128fn = access_ttlb,
+      .type = ARM_CP_NO_RAW | ARM_CP_ADD_TLBI_NXS | ARM_CP_128BIT,
       .fgt = FGT_TLBIRVAALE1,
-      .writefn = tlbi_aa64_rvae1_write },
+      .writefn = tlbi_aa64_rvae1_write,
+      .write128fn = tlbi_aa64_rvae1_write128 },
     { .name = "TLBI_RIPAS2E1IS", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 4, .crn = 8, .crm = 0, .opc2 = 2,
       .access = PL2_W, .type = ARM_CP_NO_RAW | ARM_CP_ADD_TLBI_NXS,
-- 
2.43.0


