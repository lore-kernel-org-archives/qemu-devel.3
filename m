Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29C1FECD99C
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 20:02:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vo5VZ-0006sa-Hx; Thu, 05 Feb 2026 14:59:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1vo5VT-0006pC-7p
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 14:59:18 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1vo5VQ-000386-M9
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 14:59:14 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-4359a316d89so1095515f8f.0
 for <qemu-devel@nongnu.org>; Thu, 05 Feb 2026 11:59:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770321551; x=1770926351; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YNa6k84+p4NLUcl3AM/SAA8NkXll7Iajqtfasejwd8w=;
 b=cDiVPx7b7HuXo0k+KLaLGPOo36XxNfSNyBsWBXoyFz+ISc0suoZreLPeA766Rh7FtY
 kIru1nhayRHrpCfLu2aQLVTwVIvfdzSgGTs/SV55IVUwd6kRBagtRGB4bkB+pjQ42tZZ
 44zQX/TlecYaAdrYHPBQbJUp8NA/kEQ9rT4myvRWh1Z4a4AuYZ0aN2ulkEMvjnwJ29yr
 4htefsBDtI9YufL6qvfaw6C4kVBgZJanYIfvoC5F8TzZTeK7JGWa4KEVthSmJPYbTDHS
 uCG4y7CKQZw5F7sj7Skmu+5xKYSMh9y1UDYJ14b9039jJW86PrL/xjjSJfole3GB+Q1u
 9A2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770321551; x=1770926351;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YNa6k84+p4NLUcl3AM/SAA8NkXll7Iajqtfasejwd8w=;
 b=kXJ2COrm4lQ7uI5A1L4IA9kXG9efiaImv5JLFXebw5v/0pgpdA5faPWnig4OH/zg+9
 SZoVJKxlk3Er42xNKAa9WIUqyPMmcWrpFSmtamp7V+PsPHVbevBOE744vEs0mmWlCuZ6
 Dttjf7VuYME6c95GZ8FpTl7Qr3nWIrF4PUZ7pxBDmn9mTD8tLlbqULDdyIYZN1jmWnq1
 X+V7xnKjQrCn+FV3ZdM8iD+GqmYwDjBwrdAQIzuvHeJdRPNAa96b9e98lzrN41owx5m1
 cNSEirbcw2sDBKlzReL95/Yc8dAe8pNrVWG1yhmbsh28H1vvvf6GFWyeX/P2AaWt8O3H
 GUpw==
X-Gm-Message-State: AOJu0Ywe+06FenVF8n3ht/kjYPhXHboNbaEeYZl5AQy5aU3Z9I0ErAAI
 FTs8zlpsaLbOvr1GkuAmgVNCv+R4+74cGN7Pwu7eCRuVxul6TI9pulFKzjDYRJPBVoY=
X-Gm-Gg: AZuq6aIadpLzulQa3gFwliBruEx9kqWkYatID9F65i4+AfyoDGsYYtgTY+CgL8YMc3j
 rVDfjLdDmH0mF7ERlspcNrVxPY0NStuMsnJNUn5nF08o5dGBqx9PBXPtkVoeZQ+jjI8SXYGP9uI
 71+W9CAN4liKWu4W3FzIwNAoo9xukmh7h8cm2jlRUZlTYjInXR2yttTR/33s+SyYzVbSwMVGvSQ
 +MNphBFpnhoGIRKJfjY2iq+FdGDpkuagDqO2yh6yeBL/UPEPLEd05EbDFQJZoJH90qwJhktCor3
 mJ22QwWg2JW8bdSUHnuwnD2rx6lbjVLM25h19EQpcZqIQq0MXb4oB2nXXiP9x2L+hF3nwUKjnH0
 HMH7wYw5eULjqXl/5nsRqY9Xe/wP3hcQ0HKr58H7Tou3dKTNGZF4dWa4uZF1w6phcn1Ix/EyzxO
 Vdj/gUHnJ605XCmDasEJs=
X-Received: by 2002:a05:6000:2386:b0:433:2f55:7cab with SMTP id
 ffacd0b85a97d-4362934bff8mr746555f8f.37.1770321550643; 
 Thu, 05 Feb 2026 11:59:10 -0800 (PST)
Received: from thinkpad-t470s.. ([93.140.16.93])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-436297450b4sm514079f8f.34.2026.02.05.11.59.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Feb 2026 11:59:10 -0800 (PST)
From: Ruslan Ruslichenko <ruslichenko.r@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org, artem_mygaiev@epam.com,
 volodymyr_babchuk@epam.com, takahiro.nakata.wr@renesas.com,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 francisco.iglesias@amd.com, Ruslan_Ruslichenko@epam.com,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>
Subject: [PATCH 18/29] hw/core: Implement Remote Port ATS logic and cache
 management
Date: Thu,  5 Feb 2026 20:58:13 +0100
Message-ID: <20260205195824.2610192-19-ruslichenko.r@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260205195824.2610192-1-ruslichenko.r@gmail.com>
References: <20260205195824.2610192-1-ruslichenko.r@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=ruslichenko.r@gmail.com; helo=mail-wr1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>

Complete the Remote Port ATS implementation by adding the translation
and cache management logic.

This patch implements:
- The logic for ats_translate_address to resolve addresses via the
  QEMU IOMMU translation mechanism.
- A local cache management system to store IOMMU entries for remote
  masters.
- Integration with IOMMU notifiers to handle invalidation requests
  and maintain coherency with the peer.

Signed-off-by: Francisco Iglesias <francisco.iglesias@amd.com>
Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Signed-off-by: Takahiro Nakata <takahiro.nakata.wr@renesas.com>
Signed-off-by: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>
---
 hw/core/remote-port-ats.c | 207 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 205 insertions(+), 2 deletions(-)

diff --git a/hw/core/remote-port-ats.c b/hw/core/remote-port-ats.c
index c0e8150452..1f6c8d7410 100644
--- a/hw/core/remote-port-ats.c
+++ b/hw/core/remote-port-ats.c
@@ -57,14 +57,217 @@ static IOMMUTLBEntry *rp_ats_lookup_translation(RemotePortATSCache *cache,
                                                 hwaddr translated_addr,
                                                 hwaddr len)
 {
-    /* TBD */
+    RemotePortATS *s = REMOTE_PORT_ATS(cache);
+
+    for (int i = 0; i < s->cache->len; i++) {
+        IOMMUTLBEntry *iotlb = g_array_index(s->cache, IOMMUTLBEntry *, i);
+        hwaddr masked_start = (translated_addr & ~iotlb->addr_mask);
+        hwaddr masked_end = ((translated_addr + len - 1) & ~iotlb->addr_mask);
+
+        if (masked_start == iotlb->translated_addr &&
+            masked_end == iotlb->translated_addr) {
+            return iotlb;
+        }
+    }
+
     return NULL;
 }
 
+static void rp_ats_cache_remove(RemotePortATS *s, IOMMUTLBEntry *iotlb)
+{
+    for (int i = 0; i < s->cache->len; i++) {
+        IOMMUTLBEntry *tmp = g_array_index(s->cache, IOMMUTLBEntry *, i);
+        hwaddr masked_start = (tmp->iova & ~iotlb->addr_mask);
+        hwaddr masked_end = ((tmp->iova | tmp->addr_mask) & ~iotlb->addr_mask);
+
+        if (masked_start == iotlb->iova || masked_end == iotlb->iova) {
+            g_array_remove_index_fast(s->cache, i);
+        }
+    }
+}
+
+static void rp_ats_invalidate(RemotePortATS *s, IOMMUTLBEntry *iotlb)
+{
+    size_t pktlen = sizeof(struct rp_pkt_ats);
+    struct rp_pkt_ats pkt;
+    RemotePortRespSlot *rsp_slot;
+    RemotePortDynPkt *rsp;
+    size_t enclen;
+    int64_t clk;
+    uint32_t id;
+    hwaddr len = iotlb->addr_mask + 1;
+
+    id = rp_new_id(s->rp);
+    clk = rp_normalized_vmclk(s->rp);
+
+    enclen = rp_encode_ats_inv(id, s->rp_dev,
+                             &pkt,
+                             clk,
+                             0,
+                             iotlb->iova,
+                             len,
+                             0,
+                             0);
+    assert(enclen == pktlen);
+
+    rp_rsp_mutex_lock(s->rp);
+    rp_write(s->rp, (void *) &pkt, enclen);
+
+    rsp_slot = rp_dev_wait_resp(s->rp, s->rp_dev, id);
+    rsp = &rsp_slot->rsp;
+
+    /* We dont support out of order answers yet.  */
+    assert(rsp->pkt->hdr.id == id);
+
+    rp_resp_slot_done(s->rp, rsp_slot);
+    rp_rsp_mutex_unlock(s->rp);
+}
+
+static void rp_ats_cache_insert(RemotePortATS *s,
+                                hwaddr iova,
+                                hwaddr translated_addr,
+                                hwaddr mask,
+                                AddressSpace *target_as)
+{
+    IOMMUTLBEntry *iotlb;
+
+    /*
+     * Invalidate all current translations that collide with the new one and
+     * does not have the same target_as. This means that translated_addresses
+     * towards the same addresses but in different target address spaces are
+     * not allowed.
+     */
+    for (int i = 0; i < s->cache->len; i++) {
+        iotlb = g_array_index(s->cache, IOMMUTLBEntry *, i);
+        hwaddr masked_start = (translated_addr & ~iotlb->addr_mask);
+        hwaddr masked_end = ((translated_addr | mask) & ~iotlb->addr_mask);
+        bool spans_region = masked_start < iotlb->translated_addr &&
+                             masked_end > iotlb->translated_addr;
+
+        if (masked_start == iotlb->translated_addr ||
+            masked_end == iotlb->translated_addr || spans_region) {
+            hwaddr masked_iova_start;
+            hwaddr masked_iova_end;
+
+            /*
+             * Invalidated & remove the mapping if the address range hit in the
+             * cache but the target_as is different.
+             */
+            if (iotlb->target_as != target_as) {
+                rp_ats_invalidate(s, iotlb);
+                g_array_remove_index_fast(s->cache, i);
+                continue;
+            }
+
+            /*
+             * Remove duplicates with a smaller range length since the new
+             * mapping will span over it.
+             */
+            masked_iova_start = (iova & ~iotlb->addr_mask);
+            masked_iova_end = ((iova | mask) & ~iotlb->addr_mask);
+            spans_region = masked_iova_start < iotlb->iova &&
+                            masked_iova_end > iotlb->iova;
+
+            if (masked_iova_start == iotlb->iova ||
+                masked_iova_end == iotlb->iova || spans_region) {
+
+                if ((iotlb->addr_mask + 1) < (mask + 1)) {
+                    g_array_remove_index_fast(s->cache, i);
+                } else {
+                    /*
+                     * The new mapping is smaller or equal in size and is thus
+                     * already cached.
+                     */
+                    return;
+                }
+            }
+        }
+    }
+
+    iotlb = g_new0(IOMMUTLBEntry, 1);
+    iotlb->iova = iova;
+    iotlb->translated_addr = translated_addr;
+    iotlb->addr_mask = mask;
+    iotlb->target_as = target_as;
+    g_array_append_val(s->cache, iotlb);
+}
+
+static void rp_ats_iommu_unmap_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
+{
+    ATSIOMMUNotifier *notifier = container_of(n, ATSIOMMUNotifier, n);
+    RemotePortATS *s = notifier->rp_ats;
+
+    rp_ats_invalidate(s, iotlb);
+    rp_ats_cache_remove(s, iotlb);
+}
+
 static bool ats_translate_address(RemotePortATS *s, struct rp_pkt *pkt,
                                   hwaddr *phys_addr, hwaddr *phys_len)
 {
-    /* TBD */
+    MemTxAttrs attrs = MEMTXATTRS_UNSPECIFIED;
+    IOMMUMemoryRegion *iommu_mr;
+    AddressSpace *target_as;
+    MemoryRegion *mr;
+    int prot = 0;
+
+    RCU_READ_LOCK_GUARD();
+
+    mr = ats_do_translate(&s->as, pkt->ats.addr, phys_addr, phys_len,
+                          &target_as, &prot, attrs);
+    if (!mr) {
+        return false;
+    }
+
+    iommu_mr = memory_region_get_iommu(mr);
+    if (iommu_mr) {
+        int iommu_idx = memory_region_iommu_attrs_to_index(iommu_mr, attrs);
+        ATSIOMMUNotifier *notifier;
+        int i;
+
+        for (i = 0; i < s->iommu_notifiers->len; i++) {
+            notifier = g_array_index(s->iommu_notifiers, ATSIOMMUNotifier *, i);
+            if (notifier->mr == mr && notifier->iommu_idx == iommu_idx) {
+                break;
+            }
+        }
+
+        /* Register a notifier if not found.  */
+        if (i == s->iommu_notifiers->len) {
+            Error *err = NULL;
+            bool ret;
+
+            s->iommu_notifiers = g_array_set_size(s->iommu_notifiers, i + 1);
+            notifier = g_new0(ATSIOMMUNotifier, 1);
+            g_array_index(s->iommu_notifiers, ATSIOMMUNotifier *, i) = notifier;
+
+            notifier->mr = mr;
+            notifier->iommu_idx = iommu_idx;
+            notifier->rp_ats = s;
+
+            iommu_notifier_init(&notifier->n,
+                                rp_ats_iommu_unmap_notify,
+                                IOMMU_NOTIFIER_UNMAP,
+                                0,
+                                HWADDR_MAX,
+                                iommu_idx);
+
+            ret = memory_region_register_iommu_notifier(mr, &notifier->n, &err);
+            if (ret) {
+                error_report_err(err);
+                exit(1);
+            }
+        }
+    }
+
+    if (!(prot & IOMMU_RO)) {
+        pkt->ats.attributes &= ~(RP_ATS_ATTR_exec | RP_ATS_ATTR_read);
+    }
+    if (!(prot & IOMMU_WO)) {
+        pkt->ats.attributes &= ~(RP_ATS_ATTR_write);
+    }
+
+    rp_ats_cache_insert(s, pkt->ats.addr, *phys_addr, *phys_len - 1, target_as);
+
     return true;
 }
 
-- 
2.43.0


