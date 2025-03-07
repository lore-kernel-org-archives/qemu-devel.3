Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B34CC19F32
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 15:13:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqZIc-000160-3I; Fri, 07 Mar 2025 10:07:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tqZIX-00013W-80
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 10:07:37 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tqZIV-0008MV-85
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 10:07:36 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-390fdaf2897so2004104f8f.0
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 07:07:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741360053; x=1741964853; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=xyxLh5BLcDl2AJdz4+J0eOXFTj1L4hj69KVc/wA423Q=;
 b=w4wWq9eeSW9wQgLHt0yDevrtf4PbmBfYewtDKF/szeEj39zQylnLsc+tCr0NRzbmVr
 p4uOlb5PHIjUPIi6jysP1O30VxG8DY3fSh5u8uSCMAs4OCJv7lv9QTh36BqY36Du9MgX
 wHADPwvfcx4vrUzTMRsB6YK3aPYpUykLvgtGPfLPldWl9ECnolY2Cz/X4S1HWi0h5F4F
 F5SX6R6Pvydl6n7wEENn5bczWU9v0fJPVQ5UORF8KDp7ejz9I70XLAHUIsKaaszxvkkr
 mmi5MoLOSn1j8gPjsK15KzWSTeD/6tl3M0jr2Sx5uIAv8X2RixUzfkV77OIYxfJmwKwX
 PM7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741360053; x=1741964853;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xyxLh5BLcDl2AJdz4+J0eOXFTj1L4hj69KVc/wA423Q=;
 b=pTSWw1YXZ5qdprIk0f7Ab2bXjTIfRbpymkbdyDtgHIkFMpO88JvspFxss3yXY2p6AC
 C6N81ts2uhlyHj9RxqLUTHtdo3MF2VcOT/yI7b1bhK+wT8lOU8USVvj4xOuRXFSUlV5G
 e7MMGACyoNzMbdaNI/ueMXBMsJNedXaouB/QmZJXxNGCROFpY9zGz6yym7fouZF+6WjV
 ptwKJn2IuKWf4HInxUeBqf2UJPz4EiSDB8QJPFht0XwXPGj6WyT68MmUh2M89fw9aD3C
 umBkYEinhXz4ingFkkuZwEMvKguVAQYXWwcSrDXvtfIJPrkIQo0UDKDtqEJ7nRb3JGJM
 BCAw==
X-Gm-Message-State: AOJu0YzmGVX2DRRXzXZy4jCxuSx3aIikxdCG6RPshpiuHenM61ahWqvw
 wL2tGfccRhL+wlVRd4l+VEpcU6HDPs2r13hfOXEXq4nN6dVapYpe23ew2burvtWOd3LxWFOryL+
 l
X-Gm-Gg: ASbGncsA9tbBgb0lEQ5vdMZqwedmu9Cgj2tLpSQQwgQu7bZX3MYZN4AoxbEiTMmfcHz
 tCKmEkXGU0mn7YIZp1VuF3Y/s6fvKehgdJiLj+WGYLOsXGeB6K5D6vWVU9vLRtzi9g3r2OemfTt
 zcxiAZZTUw7pZylp2pm8i03bY6g6QfKEpGP1bz51H5r48+ch8efOU+koFtfCMjfYXnqwoI9LGjW
 F4RjtabzxsJMZMdTtaxwarrNk2wQ06sWUC1yGlJwqih0fR6U+emVAWePkczfhX6J44/mni++5Cq
 VrwlcmcKNcKfcuvmBYYGexq4N/wtp8/wIJ4OhLi/y0SL9I0ZF2s=
X-Google-Smtp-Source: AGHT+IHEGqfOeCUTUd48JJ3O2Jxl1KS6c7i79ND5qK/GUhCcZdkcDU7cx3gf2QXUaJ4nt3iRbGwsTg==
X-Received: by 2002:a5d:648b:0:b0:38d:e33d:d0eb with SMTP id
 ffacd0b85a97d-39132d093edmr3297518f8f.9.1741360053321; 
 Fri, 07 Mar 2025 07:07:33 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912c1031fdsm5443627f8f.89.2025.03.07.07.07.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Mar 2025 07:07:32 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 19/21] hw/arm/smmu: Introduce smmu_configs_inv_sid_range()
 helper
Date: Fri,  7 Mar 2025 15:07:06 +0000
Message-ID: <20250307150708.3222813-20-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250307150708.3222813-1-peter.maydell@linaro.org>
References: <20250307150708.3222813-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42d.google.com
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

From: JianChunfu <jansef.jian@hj-micro.com>

Use a similar terminology smmu_hash_remove_by_sid_range() as the one
being used for other hash table matching functions since
smmuv3_invalidate_ste() name is not self explanatory, and introduce a
helper that invokes the g_hash_table_foreach_remove.

No functional change intended.

Signed-off-by: JianChunfu <jansef.jian@hj-micro.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Message-id: 20250228031438.3916-1-jansef.jian@hj-micro.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/smmu-internal.h       |  5 -----
 include/hw/arm/smmu-common.h |  6 ++++++
 hw/arm/smmu-common.c         | 21 +++++++++++++++++++++
 hw/arm/smmuv3.c              | 19 ++-----------------
 hw/arm/trace-events          |  3 ++-
 5 files changed, 31 insertions(+), 23 deletions(-)

diff --git a/hw/arm/smmu-internal.h b/hw/arm/smmu-internal.h
index 843bebb185d..d143d296f34 100644
--- a/hw/arm/smmu-internal.h
+++ b/hw/arm/smmu-internal.h
@@ -141,9 +141,4 @@ typedef struct SMMUIOTLBPageInvInfo {
     uint64_t mask;
 } SMMUIOTLBPageInvInfo;
 
-typedef struct SMMUSIDRange {
-    uint32_t start;
-    uint32_t end;
-} SMMUSIDRange;
-
 #endif
diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
index e5ad55bbae7..e5e2d09294d 100644
--- a/include/hw/arm/smmu-common.h
+++ b/include/hw/arm/smmu-common.h
@@ -142,6 +142,11 @@ typedef struct SMMUIOTLBKey {
     uint8_t level;
 } SMMUIOTLBKey;
 
+typedef struct SMMUSIDRange {
+    uint32_t start;
+    uint32_t end;
+} SMMUSIDRange;
+
 struct SMMUState {
     /* <private> */
     SysBusDevice  dev;
@@ -219,6 +224,7 @@ void smmu_iotlb_inv_iova(SMMUState *s, int asid, int vmid, dma_addr_t iova,
                          uint8_t tg, uint64_t num_pages, uint8_t ttl);
 void smmu_iotlb_inv_ipa(SMMUState *s, int vmid, dma_addr_t ipa, uint8_t tg,
                         uint64_t num_pages, uint8_t ttl);
+void smmu_configs_inv_sid_range(SMMUState *s, SMMUSIDRange sid_range);
 /* Unmap the range of all the notifiers registered to any IOMMU mr */
 void smmu_inv_notifiers_all(SMMUState *s);
 
diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
index 8c1b407b824..6e720e1b9a0 100644
--- a/hw/arm/smmu-common.c
+++ b/hw/arm/smmu-common.c
@@ -225,6 +225,27 @@ static gboolean smmu_hash_remove_by_vmid_ipa(gpointer key, gpointer value,
            ((entry->iova & ~info->mask) == info->iova);
 }
 
+static gboolean
+smmu_hash_remove_by_sid_range(gpointer key, gpointer value, gpointer user_data)
+{
+    SMMUDevice *sdev = (SMMUDevice *)key;
+    uint32_t sid = smmu_get_sid(sdev);
+    SMMUSIDRange *sid_range = (SMMUSIDRange *)user_data;
+
+    if (sid < sid_range->start || sid > sid_range->end) {
+        return false;
+    }
+    trace_smmu_config_cache_inv(sid);
+    return true;
+}
+
+void smmu_configs_inv_sid_range(SMMUState *s, SMMUSIDRange sid_range)
+{
+    trace_smmu_configs_inv_sid_range(sid_range.start, sid_range.end);
+    g_hash_table_foreach_remove(s->configs, smmu_hash_remove_by_sid_range,
+                                &sid_range);
+}
+
 void smmu_iotlb_inv_iova(SMMUState *s, int asid, int vmid, dma_addr_t iova,
                          uint8_t tg, uint64_t num_pages, uint8_t ttl)
 {
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index b40acbe0245..1a96287ba9d 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -903,7 +903,7 @@ static void smmuv3_flush_config(SMMUDevice *sdev)
     SMMUv3State *s = sdev->smmu;
     SMMUState *bc = &s->smmu_state;
 
-    trace_smmuv3_config_cache_inv(smmu_get_sid(sdev));
+    trace_smmu_config_cache_inv(smmu_get_sid(sdev));
     g_hash_table_remove(bc->configs, sdev);
 }
 
@@ -1277,20 +1277,6 @@ static void smmuv3_range_inval(SMMUState *s, Cmd *cmd, SMMUStage stage)
     }
 }
 
-static gboolean
-smmuv3_invalidate_ste(gpointer key, gpointer value, gpointer user_data)
-{
-    SMMUDevice *sdev = (SMMUDevice *)key;
-    uint32_t sid = smmu_get_sid(sdev);
-    SMMUSIDRange *sid_range = (SMMUSIDRange *)user_data;
-
-    if (sid < sid_range->start || sid > sid_range->end) {
-        return false;
-    }
-    trace_smmuv3_config_cache_inv(sid);
-    return true;
-}
-
 static int smmuv3_cmdq_consume(SMMUv3State *s)
 {
     SMMUState *bs = ARM_SMMU(s);
@@ -1373,8 +1359,7 @@ static int smmuv3_cmdq_consume(SMMUv3State *s)
             sid_range.end = sid_range.start + mask;
 
             trace_smmuv3_cmdq_cfgi_ste_range(sid_range.start, sid_range.end);
-            g_hash_table_foreach_remove(bs->configs, smmuv3_invalidate_ste,
-                                        &sid_range);
+            smmu_configs_inv_sid_range(bs, sid_range);
             break;
         }
         case SMMU_CMD_CFGI_CD:
diff --git a/hw/arm/trace-events b/hw/arm/trace-events
index f49cae1656e..f3386bd7ae1 100644
--- a/hw/arm/trace-events
+++ b/hw/arm/trace-events
@@ -22,6 +22,8 @@ smmu_iotlb_inv_asid_vmid(int asid, int vmid) "IOTLB invalidate asid=%d vmid=%d"
 smmu_iotlb_inv_vmid(int vmid) "IOTLB invalidate vmid=%d"
 smmu_iotlb_inv_vmid_s1(int vmid) "IOTLB invalidate vmid=%d"
 smmu_iotlb_inv_iova(int asid, uint64_t addr) "IOTLB invalidate asid=%d addr=0x%"PRIx64
+smmu_configs_inv_sid_range(uint32_t start, uint32_t end) "Config cache INV SID range from 0x%x to 0x%x"
+smmu_config_cache_inv(uint32_t sid) "Config cache INV for sid=0x%x"
 smmu_inv_notifiers_mr(const char *name) "iommu mr=%s"
 smmu_iotlb_lookup_hit(int asid, int vmid, uint64_t addr, uint32_t hit, uint32_t miss, uint32_t p) "IOTLB cache HIT asid=%d vmid=%d addr=0x%"PRIx64" hit=%d miss=%d hit rate=%d"
 smmu_iotlb_lookup_miss(int asid, int vmid, uint64_t addr, uint32_t hit, uint32_t miss, uint32_t p) "IOTLB cache MISS asid=%d vmid=%d addr=0x%"PRIx64" hit=%d miss=%d hit rate=%d"
@@ -59,7 +61,6 @@ smmuv3_cmdq_tlbi_nh(int vmid) "vmid=%d"
 smmuv3_cmdq_tlbi_nsnh(void) ""
 smmuv3_cmdq_tlbi_nh_asid(int asid) "asid=%d"
 smmuv3_cmdq_tlbi_s12_vmid(int vmid) "vmid=%d"
-smmuv3_config_cache_inv(uint32_t sid) "Config cache INV for sid=0x%x"
 smmuv3_notify_flag_add(const char *iommu) "ADD SMMUNotifier node for iommu mr=%s"
 smmuv3_notify_flag_del(const char *iommu) "DEL SMMUNotifier node for iommu mr=%s"
 smmuv3_inv_notifiers_iova(const char *name, int asid, int vmid, uint64_t iova, uint8_t tg, uint64_t num_pages, int stage) "iommu mr=%s asid=%d vmid=%d iova=0x%"PRIx64" tg=%d num_pages=0x%"PRIx64" stage=%d"
-- 
2.43.0


