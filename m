Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78F3AC43327
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 09:16:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wer01-0000wc-Ni; Wed, 01 Jul 2026 05:12:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1weqzb-0000pk-Ek
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 05:12:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1weqza-0007Ih-23
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 05:12:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782897145;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4yBaZCqVS5OvWIaH4vQdFMJ7XFKVk46/GgIK1pAGS7I=;
 b=OVTIF2c83cPeiEr7FvEH0wx8Ickn+xRO/Usk2XUXa2EVOnmDSEKG/5FcWauvVq37NN7lUV
 7q6BzLcz1RFXD4t4fr8ym/19LPB7afpu8/ZCbeH8bzGFvkbvT7NZFYZInN/hDiNDAn37yf
 U2hZ8bv0F+9FIohzirF0CMXAVBWDlfM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-189-hHRNdt2EOlajnT7jDKyoKQ-1; Wed,
 01 Jul 2026 05:12:22 -0400
X-MC-Unique: hHRNdt2EOlajnT7jDKyoKQ-1
X-Mimecast-MFC-AGG-ID: hHRNdt2EOlajnT7jDKyoKQ_1782897140
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8072A1830199; Wed,  1 Jul 2026 09:12:20 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.44.33.117])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7A2B218005BF; Wed,  1 Jul 2026 09:12:17 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org, berrange@redhat.com,
 skolothumtho@nvidia.com, nicolinc@nvidia.com, nathanc@nvidia.com
Subject: [PATCH v2 1/5] hw/arm/smmuv3: Fix off-by-one bug in alignment strtab
 mask
Date: Wed,  1 Jul 2026 11:11:38 +0200
Message-ID: <20260701091209.2860306-2-eric.auger@redhat.com>
In-Reply-To: <20260701091209.2860306-1-eric.auger@redhat.com>
References: <20260701091209.2860306-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The stream table base address needs to be aligned to its size.

With FMT == 0, the spec says the linear stream table base address
musst have ADDR[LOG2SIZE + 5:0] = 0. STE are 64B

With FMT == 1, ADDR[MAX(5, (LOG2SIZE - SPLIT - 1 + 3)):0] = 0.
L1 descriptors are 8B.

MAKE_64BIT_MASK() second argument is a size and not a shift, so
there is an off-by-one computation.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 hw/arm/smmuv3.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 5e5a6a960c9..38aba9c0af9 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -664,7 +664,7 @@ int smmu_find_ste(SMMUv3State *s, uint32_t sid, STE *ste, SMMUEventInfo *event)
 {
     dma_addr_t addr, strtab_base;
     uint32_t log2size;
-    int strtab_size_shift;
+    int strtab_size;
     int ret;
 
     trace_smmuv3_find_ste(sid, s->features, s->sid_split);
@@ -685,9 +685,9 @@ int smmu_find_ste(SMMUv3State *s, uint32_t sid, STE *ste, SMMUEventInfo *event)
          * Align strtab base address to table size. For this purpose, assume it
          * is not bounded by SMMU_IDR1_SIDSIZE.
          */
-        strtab_size_shift = MAX(5, (int)log2size - s->sid_split - 1 + 3);
+        strtab_size = MAX(6, (int)log2size - s->sid_split + 3);
         strtab_base = s->strtab_base & SMMU_BASE_ADDR_MASK &
-                      ~MAKE_64BIT_MASK(0, strtab_size_shift);
+                      ~MAKE_64BIT_MASK(0, strtab_size);
         l1_ste_offset = sid >> s->sid_split;
         l2_ste_offset = sid & ((1 << s->sid_split) - 1);
         l1ptr = (dma_addr_t)(strtab_base + l1_ste_offset * sizeof(l1std));
@@ -729,9 +729,9 @@ int smmu_find_ste(SMMUv3State *s, uint32_t sid, STE *ste, SMMUEventInfo *event)
         }
         addr = l2ptr + l2_ste_offset * sizeof(*ste);
     } else {
-        strtab_size_shift = log2size + 5;
+        strtab_size = log2size + 6;
         strtab_base = s->strtab_base & SMMU_BASE_ADDR_MASK &
-                      ~MAKE_64BIT_MASK(0, strtab_size_shift);
+                      ~MAKE_64BIT_MASK(0, strtab_size);
         addr = strtab_base + sid * sizeof(*ste);
     }
 
-- 
2.53.0


