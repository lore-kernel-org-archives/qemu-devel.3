Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6DC3C44507
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 15:34:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjIec-0000G6-7C; Mon, 13 Jul 2026 11:33:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wjIeC-0008QS-6o
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 11:32:47 -0400
Received: from mail-wm2-x00.google.com ([2a00:1450:4864:31::])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wjIeA-000172-3o
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 11:32:43 -0400
Received: by mail-wm2-x00.google.com with SMTP id
 5b1f17b1804b1-492367f3094so14100855e9.0
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 08:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783956760; x=1784561560; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=jroCL+W1/ba9rRwipBCDoKmJSRF9H3/7GVEVaHjQaOQ=;
 b=sX2oXg2rMS6hT0692FJDD1rXZ8FIjEr0ZgtCsNPuotJdxdoSkqlBPMLzq/1oDoV501
 EjU2LBvT/FHkNkafyi80JDPRHLOaXzPl/1J1Ucdm77+ibzW9v638wgZwG0aH1bJY2TDv
 JlQwkNBeyOQhjihpb3ZD+K4hcGy6gBZqFPmZzIT6WcMdSMajj9biF4tQOKllj75CFZd1
 9eHZq/ks2ldP5MH1dxEvTeZsF80At18dFUjbgBbFJzDy3NqcljA3+k+p+Kkdpmd1IG4P
 rEBWTU6m5rLL32TFrVKlYA8UCAXBtjlN/ZP7K3f0h6Z93IVsA0JKfQiptQ1MCUF90ujJ
 TP1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783956760; x=1784561560;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=jroCL+W1/ba9rRwipBCDoKmJSRF9H3/7GVEVaHjQaOQ=;
 b=ZEuZZRtW6Z6Gi9nLnOtCbSzkVeIGRJiZtEjp5TnIJENTF8D8GXM/AmC0CxVbX0I1Qv
 tAJiPsHSFqUZJKG3IuiqR7NPmpjGmF14E+1gkRg9IISS2B1mWB2HIkXSASV1rYwOAevs
 er4h6SKRzGSOkpHr4gyRfebz8qLJn/MbqgwLTEhasI3n0HQWsdui80WkQ9dbvkWPCh0G
 hBTQwm6fhfq51iJLJeu4tFN4jqsMd2ldELmzUL/K25op0A7IIdlo2OzoUZ0gqGtfnw7+
 etgyNMij0BTMHASfO98mgig6I/AUjF6PUsaj31xqgiZ0UQSJ/SzXU2uwC5+nXgBEbp8f
 O/zw==
X-Gm-Message-State: AOJu0YyabAmVBO9wcNoeLrO34L8moRxyDi9DxYQwun3j2M5jTXu0GRan
 abtAmEJuswxDYMzMl9ymN0SXxApp1E4Cxohek0nxl4u5Tu0QajVQQ6beex+lopeR8YTlFoqUmq+
 RG0Lz3+iBcPFt
X-Gm-Gg: AfdE7ckNZBOtL3EES3MEkcpzpC9ZW9Ac2cMyAYhX8h+cvySVeNsqpwad1S8SIT/zqUe
 hDBSGUWwkwgumoKR8zXkswBJwQbFGnRrWoCHyqNKQbWZTmnHNLLU/EgaXuTrPB4G4S/NIVBZjlE
 3SxLPHJDgDkHhLRX29iExXs1eT0btDpZx9SKEYLU263DCn8FKweqBzIyJ7iR6D/F6eELXVs8aK0
 v1rkD1+V426aYyHMhx3PLHbOj8+BlFFniiaimARES3dJfckcv5wGPM3h8lnE8f3ZWGHWRcSeV5l
 GeoXtRbYd2mixH4w9XSc9v3hLsBFSu/QEcLoaIpc+XGuduP1/UTe88fkEkxYWxneMCJRJpdBOLq
 Mp2C2+BFhHe87YAgVOAoCO7CFRetqKUvA6yGCWV495Dx4O9csih7epNK0co/u4K+NWEVFCjBW4K
 obBqeaSR6uSOIG3oIPUsC0u6wIkMKGQ4DXYHskKg7NeM0kCGzdW2i5WVlrim31424YrUZ4uG7k1
 DmCNS6vhlalKDaDRQgvSCx+nxffaHGU
X-Received: by 2002:a05:600c:4e46:b0:493:efcd:b809 with SMTP id
 5b1f17b1804b1-49401d2d054mr42809275e9.6.1783956759914; 
 Mon, 13 Jul 2026 08:32:39 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49508727f7dsm3825985e9.4.2026.07.13.08.32.39
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 08:32:39 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 05/26] hw/arm/smmuv3: Fix possible overflow in strtab_base
 computation
Date: Mon, 13 Jul 2026 16:32:12 +0100
Message-ID: <20260713153233.3391818-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260713153233.3391818-1-peter.maydell@linaro.org>
References: <20260713153233.3391818-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:31::;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm2-x00.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

From: Eric Auger <eric.auger@redhat.com>

In the linear stream table mode (FMT = 0), if the guest programs
SMMU_STRTAB_BASE_CFG.LOG2SIZE (8 bits) to something bigger than 58,
MAKE_64BIT_MASK() will overflow. So cap the mask length to 64. We
still comply with the spec ADDR alignment computation:

ADDR[LOG2SIZE + 5:0] = 0.

In the 2 level stream table mode (FMT = 1), we don't have this risk
anymore since SPLIT is sanitized and equals to 6 at minimum.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3632
Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Shameer Kolothum <skolothumtho@nvidia.com>
Message-id: 20260707085028.165557-4-eric.auger@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/smmuv3.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index c2946d8d23c..3fd1dd7cf81 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -730,6 +730,7 @@ int smmu_find_ste(SMMUv3State *s, uint32_t sid, STE *ste, SMMUEventInfo *event)
         addr = l2ptr + l2_ste_offset * sizeof(*ste);
     } else {
         strtab_size = log2size + STE_SIZE;
+        strtab_size = MIN(64, strtab_size);
         strtab_base = s->strtab_base & SMMU_BASE_ADDR_MASK &
                       ~MAKE_64BIT_MASK(0, strtab_size);
         addr = strtab_base + sid * sizeof(*ste);
-- 
2.43.0


