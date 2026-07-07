Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AE9CC43602
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 08:51:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh1W3-0007hn-Vw; Tue, 07 Jul 2026 04:50:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wh1Vz-0007h1-Hz
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 04:50:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wh1Vy-0008Gd-6G
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 04:50:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783414249;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8U2MTWyabXUItvW1t0Lz2PRc6T/C9QiAccFcwCx/YkI=;
 b=hW8yNy83fJTznmpAcqtnDGOEzIKwX1h24a+Yr+worrNZk3pduK0xijJ5OMhm6LvduL/B6x
 Uo7Aw6vt7vIn+tBYWy2T2Vnm2QAPZyvk/5i7/UTHNXGmg+bpDsVt8iddhpFZpVKxPlzDga
 K3IOyAHRrqpyMWGims2sR1mvAO2D96Y=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-374-oW5hyGvhOTK8APObgSO5sw-1; Tue,
 07 Jul 2026 04:50:44 -0400
X-MC-Unique: oW5hyGvhOTK8APObgSO5sw-1
X-Mimecast-MFC-AGG-ID: oW5hyGvhOTK8APObgSO5sw_1783414242
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ABF6918052C9; Tue,  7 Jul 2026 08:50:42 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.44.50.66])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8F8541955F71; Tue,  7 Jul 2026 08:50:38 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org, berrange@redhat.com,
 skolothumtho@nvidia.com, nicolinc@nvidia.com, nathanc@nvidia.com,
 philmd@oss.qualcomm.com
Subject: [PATCH v3 1/5] hw/arm/smmuv3: Fix off-by-one bug in alignment strtab
 mask
Date: Tue,  7 Jul 2026 10:49:33 +0200
Message-ID: <20260707085028.165557-2-eric.auger@redhat.com>
In-Reply-To: <20260707085028.165557-1-eric.auger@redhat.com>
References: <20260707085028.165557-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

With FMT == 0 (linear stream table), the table size is log2size *
STE_SIZE (2^6). So the spec says the base address
must have ADDR[LOG2SIZE + 5:0] = 0.

With FMT == 1 (2 level stream table), the table size is
(log2size - split) * L1STD_SIZE (2^3) So the spec days
the effective base address is aligned by the SMMU to the larger of
64 bytes or the first-level table size:
ADDR[MAX(5, (LOG2SIZE - SPLIT - 1 + 3)):0] = 0.

MAKE_64BIT_MASK() second argument is a size and not a shift, so
fix this off-by-one computation.

Subsequent patches will fix the risk of overflow in MAKE_64BIT_MASK()

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 hw/arm/smmuv3-internal.h |  3 +++
 hw/arm/smmuv3.c          | 10 +++++-----
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/hw/arm/smmuv3-internal.h b/hw/arm/smmuv3-internal.h
index eb482c7000f..0819a4b2e8d 100644
--- a/hw/arm/smmuv3-internal.h
+++ b/hw/arm/smmuv3-internal.h
@@ -359,6 +359,9 @@ void smmuv3_record_event(SMMUv3State *s, SMMUEventInfo *event);
 void smmuv3_propagate_event(SMMUv3State *s, Evt *evt);
 int smmu_find_ste(SMMUv3State *s, uint32_t sid, STE *ste, SMMUEventInfo *event);
 
+#define STE_SIZE 6
+#define L1STD_SIZE 3
+
 static inline int oas2bits(int oas_field)
 {
     switch (oas_field) {
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 5e5a6a960c9..10c67645a57 100644
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
+        strtab_size = MAX(6, (int)log2size - s->sid_split + L1STD_SIZE);
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
+        strtab_size = log2size + STE_SIZE;
         strtab_base = s->strtab_base & SMMU_BASE_ADDR_MASK &
-                      ~MAKE_64BIT_MASK(0, strtab_size_shift);
+                      ~MAKE_64BIT_MASK(0, strtab_size);
         addr = strtab_base + sid * sizeof(*ste);
     }
 
-- 
2.53.0


