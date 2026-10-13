Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26CA5CC6B03
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 08:46:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGY4X-0001YD-6f; Tue, 13 Oct 2026 04:41:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGY3l-0007xt-QG
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 04:40:34 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGY3j-0007xY-SP
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 04:40:33 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-48c4649b35bso2482897f8f.3
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 01:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791880830; x=1792485630; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=EDSv94O3ngBElAdZ3d0QnS2OnkdxbvDnsDEH1rGBv50=;
 b=FuOvJdGW3PQc4jbQPheRxAPZZ5ucWIKDtBqUwf3GhlPULbtu+MxSJci/YuQur545nz
 OMG3WX8Pg72/LvjQrmyvlNnXjbG+GxbauWjuWg0s6JbiM5M4/D6trYsxuckWobnMsH04
 RlqN+q5XW6j89IhpzYw2fE3hbRLy4iq+LeoP5l9iPcISgGqM3ovVenRjrF7/BEkCBvJ5
 fOM7gjCTsTWeDzw7m9FAjRlvHaPcJpP880uGEVpSLusTRNWcJ4r1UhPcqjJjg0IFiVJr
 t6vfwijYbnceYNIpVJVnLzhR2FKO4XDoClQDE1Ni0TPwQe7+QleuPHzLE+aI0HUbyg7/
 3tBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791880830; x=1792485630;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=EDSv94O3ngBElAdZ3d0QnS2OnkdxbvDnsDEH1rGBv50=;
 b=i5pOJoZjAZ1JGpmY3cPjH0UYvDg+r4XBdG+F9eXvRGeGwlDN+rDqjRv5VTurOXVGn4
 TF0aijgNHLmeoZQll2y4QDOFwZJsBl1xz98ZWVIBONCRzOk4wtWOycahXYK6SKu6dJ5d
 57NFeF5yJxWzag1nXDwhEMtyKWpwqTBRx7M3alcKwkCKQ6lNV2IkKV6w7mcGTwUOrbeY
 6SwXQn5CP2z4LEmE50sY6FX1n06K0QE7pUJqSxX1HdmaaEJKKpx5gWY5z+9Pz1wi/WmC
 gsG4FqPU4KydTX83tFai5o5JCTr9fYZE1e+Kl/1Dkh1PY5eiOO9vgLZ9AY3BYSpqAONm
 tqHQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwpmcE6p3FhpIqoDUy5ZjfHwo5QlnZB/NJGUG9BbiiH15niMyzENOgiv+Cf2UL53avB6bM1tixqsJ1H@nongnu.org
X-Gm-Message-State: AFq9FYLqwgpG50Q/j+Hz8H1JqcNIrS9Mc1+fnseoiQ1I4zSmflP4GMaL
 WfReuFXB3Xi2P+7OgSUYduHS7fvvwxGoG7+QQ+6VLi5LefPdn4A6dVRxq8uqbOvrDjQ=
X-Gm-Gg: AYBFou3YKKFVYM63nY9KGff4LFTy+BmcAGpaFGHNeFjouvHky7P68wMJD6kqp0lABIT
 fpUVidlBgGhp4eZf0ZKXB12nnDxXSguxPaazrZm6e+0KOPVqOhf/aErbovBvHbFlHteCE5L4Tvo
 wwkDcdLM/LzhDPr+txsVR67xU6t2wyvkFvsPDuGxGtW9NHsc3phWwtUW0McxYcH7+PmsSGxFloN
 lInsuKMY9VAZwuyLJFxg9/Y89mPVLfyBd5yE6kODCPKI+0XqwP5uDnkErrdI0skWbO9A9/8YqRq
 roHTg0I9F6I4hZjJrG+bfvZE1wp52Bj8hmC2QVToMr2i9TCqkHdH2Viz+N+NZFbOmfXOGp0+q2J
 6Gqlu1tYtEXCxMJgZZXRRj7UlXN7w+8eFwbJZFSaYzOVhv6jPA5FxiGGPpGTFLBMCRFJ6BH/6ho
 ONpOVJLlu4sE5PdCYnrFaYnzRQ81nXddBIhUtqLU1nyiw7PWMU6dnl40fECdhhL0GyjM3nqwrcn
 0scB44ECv/a3yIkU1MZ3S9jilyvqmZ/vH0ZZOCMJBe2JYRJGmPVKMK09QImMAgAarwM6kx+5OO5
 ASret35glYsWmw==
X-Received: by 2002:a05:600c:1e0f:b0:4a1:7b87:8d34 with SMTP id
 5b1f17b1804b1-4a18e4b46e1mr212171255e9.21.1791880830101; 
 Tue, 13 Oct 2026 01:40:30 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18be96549sm495086735e9.6.2026.10.13.01.40.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 01:40:29 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 39/86] target/arm: GICv5 cpuif: Handle virtual interrupts for
 GIC CDDI
Date: Tue, 13 Oct 2026 09:38:46 +0100
Message-ID: <20261013083933.1024405-40-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261013083933.1024405-1-peter.maydell@linaro.org>
References: <20261013083933.1024405-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x429.google.com
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

Handle the virtual interrupt domain in our GIC CDDI implementation:
for LPIs and SPIs we just pass through the "virtual" parameter, but
for PPIs we must look at the virtual PPI state rather than the
physical PPI state.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/gicv5-cpuif.c | 11 ++++++++---
 target/arm/tcg/trace-events  |  2 +-
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/target/arm/tcg/gicv5-cpuif.c b/target/arm/tcg/gicv5-cpuif.c
index aeacc812fe0..c85d72b05d0 100644
--- a/target/arm/tcg/gicv5-cpuif.c
+++ b/target/arm/tcg/gicv5-cpuif.c
@@ -1254,7 +1254,7 @@ static void gic_cddi_write(CPUARMState *env, const ARMCPRegInfo *ri,
     GICv5IntType type = FIELD_EX64(value, GIC_CDDI, TYPE);
     uint32_t id = FIELD_EX64(value, GIC_CDDI, ID);
 
-    trace_gicv5_cddi(domain, value);
+    trace_gicv5_cddi(domain, virtual, value);
 
     switch (type) {
     case GICV5_PPI:
@@ -1268,8 +1268,13 @@ static void gic_cddi_write(CPUARMState *env, const ARMCPRegInfo *ri,
         ppireg = id / 64;
         ppibit = 1ULL << (id % 64);
 
-        env->gicv5_cpuif.ppi_active[ppireg] &= ~ppibit;
-        gic_recalc_ppi_hppi(env);
+        if (virtual) {
+            env->gicv5_cpuif.ich_ppi_active[ppireg] &= ~ppibit;
+            gic_recalc_virt_ppi_hppi(env);
+        } else {
+            env->gicv5_cpuif.ppi_active[ppireg] &= ~ppibit;
+            gic_recalc_ppi_hppi(env);
+        }
         break;
     }
     case GICV5_LPI:
diff --git a/target/arm/tcg/trace-events b/target/arm/tcg/trace-events
index 8e7e4c119db..31c6eafd8ed 100644
--- a/target/arm/tcg/trace-events
+++ b/target/arm/tcg/trace-events
@@ -8,7 +8,7 @@ gicv5_gicr_cdia_fail(int domain, const char *reason) "domain %d CDIA attempt fai
 gicv5_gicr_cdia(int domain, uint32_t id) "domain %d CDIA acknowledge of interrupt 0x%x"
 gicv5_cdeoi(int domain) "domain %d CDEOI performing priority drop"
 gicv5_vcdeoi(void) "virtual interrupt domain CDEOI performing priority drop"
-gicv5_cddi(int domain, uint32_t id) "domain %d CDDI deactivating interrupt ID 0x%x"
+gicv5_cddi(int domain, bool virtual, uint32_t id) "domain %d virtual %d CDDI deactivating interrupt ID 0x%x"
 gicv5_update_irq_fiq(bool irq, bool fiq, bool nmi) "now IRQ %d FIQ %d NMI %d"
 gicv5_update_virq_vfiq(bool virq, bool vinmi) "now VIRQ %d VINMI %d"
 gicv5_update_ppi_state(int ppi, bool level) "PPI %d source level now %d"
-- 
2.43.0


