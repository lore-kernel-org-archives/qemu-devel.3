Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8E12C88E7F
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 16:05:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6VbT-00089Q-F8; Tue, 15 Sep 2026 12:01:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1x6VbR-00084f-OR
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 12:01:50 -0400
Received: from mail-ej2-x10.google.com ([2a00:1450:4864:34::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1x6VbP-0003Si-Om
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 12:01:49 -0400
Received: by mail-ej2-x10.google.com with SMTP id
 a640c23a62f3a-c254f9f7db0so86662566b.3
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 09:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789488096; x=1790092896; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JuywBTKM2C3b3mn1du8c5UdWRdVb6bhBO3Hc/Xe4RIM=;
 b=LzjTj1uWJSNjcKqwxSRyL5GoZWpScHIzTSeMq0uoc/AMgTb1UOPshSnyPnd6zpva8v
 zu3MA0lNvdZmNZgU4Aa4ijQKBzkZMOfOFKLNyGDaAPhmTVZO2VDCJVjq7vvjQt9CuBhb
 aUnACh+hxiHFJOyZLbg0UX74Hf2hcsu6UzMf7l71NreRds6QP4ciehrG4hAoSj72GxcZ
 WgLxmC2jqaHGTZwjiVHCOQNDlq7xYhXROLN+zebXUEkmcz8kgZK2bLwwFPXH5pQcGyuJ
 NvC5g9j05gIpcNM8VAOdySBFBJOcgZJmXjEfdwPBzJ1WnP7bXY/J2ca2crjgxqCrUIoQ
 SGag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789488096; x=1790092896;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=JuywBTKM2C3b3mn1du8c5UdWRdVb6bhBO3Hc/Xe4RIM=;
 b=xMYTA2nJ+Tn67h3HFCTiAeIbQTSoKsc6x0r3P38ev26HpnC12uN88UMVeIVs44Pbbb
 6clvJ5dtpAxSUCO2429abop8Zth1B6Q+p6wPvP7mG0xC/h1PNKqkU4DNEF7dqjUUD7nT
 pHWl3B/SOWft0ovHiqBaf1A8GK1nkN9a4qFJFkVkus8ODQZjidxowJmTSzuZEMhhopfT
 ug40R5exmf3WFFKEr2ZLQCFenNoo5JIYBxd/ljIUs5rmYV6RyGO8V8NznottzOamzu3n
 WPjsbW0xZI1XU2nrZPkExJVvy9M8nLvTJ9I0Y+pXf+dXO6FWguHMusaTY2IePII0Tr7J
 Halw==
X-Gm-Message-State: AFuF++mUavSZnRraJimUnAFvKoL+1CojJi8dWb83uyVzTG9WFJU+mjb6
 SM2i/STFhgpCiGULJPblzgdr0g+DNhNzPdPXJWUb++yz3feUilNRouJCojJTRw==
X-Gm-Gg: AYBFou3PVwJbObhOrxNlXEBK8m8RYB/me+IS4TB2plxzMYXuM3aywdnyYSQIAkLC9dm
 ch9nypMuSw91WTdzX8RiNyRMXr3JstQ7cp4kOijcRjKshkS5wO6qr9Y1VdZC6225h3T0FwXEH4T
 mGPz2LVy+McVPViHymFIQgnf6/Y4J6pnWbGRrtm9Q5bGNJmCnJ8BNdp3DIppYRC2dC+hV66Xlc9
 JKp1prlM0NdvEcN7aHeNAEIsG7ckNGp/BGfGW9uAhu+qc3avumbPhmoUcj9t03UelZ/TrEXkriX
 tXKwAFUiyALTOc+u9xH9DW6iYTz6On6D57oJhk2iYaHJWVFoCpKITyIicRvi1JUMH4azm0udn4+
 q0r1SDoa8IaWU81yJCzkrB1IRt5XDvfxunSJJYvF8rr56LmZR5XD+EI/HjKAwq3SY/Y/BraG95L
 swpZ4LFdq5h9czEbH4ZHnCJtX7FsDsLEMVpLUghd239ECEA0Os/WBT7srPMFj2XX37HtEIICzRY
 O3Iv5cLrqLtCaxhfLvH3yqO87dhfn40IMWLBqh0LUOIbw==
X-Received: by 2002:a17:907:94ca:b0:c24:47b8:ae5b with SMTP id
 a640c23a62f3a-c29d780ce9cmr126218066b.22.1789488096170; 
 Tue, 15 Sep 2026 09:01:36 -0700 (PDT)
Received: from thinkpad-t470s.. (83-131-196-251.adsl.net.t-com.hr.
 [83.131.196.251]) by smtp.googlemail.com with ESMTPSA id
 a640c23a62f3a-c29ddd86344sm3235866b.0.2026.09.15.09.01.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 09:01:35 -0700 (PDT)
From: Ruslan Ruslichenko <ruslichenko.r@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, artem_mygaiev@epam.com, volodymyr_babchuk@epam.com,
 peter.maydell@linaro.org, francisco.iglesias@amd.com,
 edgar.iglesias@gmail.com, berrange@redhat.com, eugene@nuvacore.ai,
 Ruslan_Ruslichenko@epam.com, takahiro.nakata.wr@renesas.com,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>
Subject: [PATCH v2 14/20] hw/core: Implement Remote Port ATS logic and cache
 management
Date: Tue, 15 Sep 2026 18:00:38 +0200
Message-ID: <20260915160044.345788-15-ruslichenko.r@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260915160044.345788-1-ruslichenko.r@gmail.com>
References: <20260915160044.345788-1-ruslichenko.r@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:34::10;
 envelope-from=ruslichenko.r@gmail.com; helo=mail-ej2-x10.google.com
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
index 793f9fc52d..d3c1365c3e 100644
--- a/hw/core/remote-port-ats.c
+++ b/hw/core/remote-port-ats.c
@@ -58,14 +58,217 @@ static IOMMUTLBEntry *rp_ats_lookup_translation(RemotePortATSCache *cache,
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


