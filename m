Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8587CD98C5
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2026 19:11:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYqAE-0007Wi-1e; Sun, 14 Jun 2026 15:06:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYqAB-0007Vz-5v
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:06:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYqA8-0001iT-JZ
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:06:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781463987;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NG9quG3Y658i2mi88rtVLcLBN8uSecldu1LwBLoJdEA=;
 b=BDiaZXrn15W8M9yb8gsL1azdi7yNvXxNwwtjlmNLAFEypWXZ0Q9UnDuJxotnd+C6yNTsCS
 NShT/FmnJbwPKlYpI8zxVMPgYxfMYCwdRVDu8ELskhNupbRKe+pslY299KDtEFFDQ+Y9wo
 JNqufNEKcTNBdQstyk2I3kVw5uwxp+w=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-685-Nog-KKdZNXimMYNNky-fJA-1; Sun, 14 Jun 2026 15:06:26 -0400
X-MC-Unique: Nog-KKdZNXimMYNNky-fJA-1
X-Mimecast-MFC-AGG-ID: Nog-KKdZNXimMYNNky-fJA_1781463985
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-46011aa5000so1114792f8f.3
 for <qemu-devel@nongnu.org>; Sun, 14 Jun 2026 12:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781463985; x=1782068785; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=NG9quG3Y658i2mi88rtVLcLBN8uSecldu1LwBLoJdEA=;
 b=Zz59lsmxLGVrHdggANCloeAI3wotCFBbBaQLCeIq70jgvoG/NmjSnew6BR8rbraaws
 4sl0efrTmtHwQePxpCf2xK+6S0OOuA6lhPL6K6n9Xvuiu8nT7fTfOrYhQKR4zOOaHchW
 Wd4INgz5GyKXzGA4I+1qtHqSdk84wZb04vt1tzxu3gW55yUmsvCxCzKUstjEN0IXeK5J
 +mXcUmikiCiZ8uhezjSeDi/oXktB4jwyRN47NExH0O+pzpJpmpvKlqVgXDxabsIzyPOC
 DxbWINqyvIsy7GD+IrpfW4pcxHaOlALU08TT8lRvj6ujGhRB9R7osvCk3LcLEIlgZR+N
 pqeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781463985; x=1782068785;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NG9quG3Y658i2mi88rtVLcLBN8uSecldu1LwBLoJdEA=;
 b=lPMFOF6YCH/SMN+ApxRdBf86DPUXXn2lDWK1Pp947BNHX+suf9YrPrtlin0r3WJFFy
 Tf9smTAxNI4djuS9U+XMWNsAlMUCZqdMFvfAp48VoAmaUP2T0GuKOpRf78fZaQbkjrXc
 p8Rsbf7zHTkOBxCXo7YexrUKiJu6L3UtZxnX6neeUAjRsVQXhHFRRJ0HjNkyLBtBMPfi
 90rjJMESm1LCAmrJK3gMJW/dqOHXoBPpWHkFFErcvVjUR76Ykumq9N47yFHGiUqmw3L9
 zHknhWgmrTsL4AIYBa4QCBuqPMThCvmfjp59FohOu/E2H62uMqEvdT/dZg6okxQgu1lc
 KRSA==
X-Gm-Message-State: AOJu0Yy4cBLEWPVXgEvvFxzp2KmLp+bcdS/6L0kCY7JZZvQI6EfShb6+
 BR3CeIg1hNotouNOx2zf3ZiqidCPsEZg4vPuO1Bg+bY7Xn7Sbm+opJL/OOOXi3koYOHZbeGKvg8
 UE9woFWB9pkoze/a/13loHKW1aGC2O4TRbcrRIb5+jq2fWrsmx5JWm0lHgDnwcVBRCHtpXJShFp
 PGPGi3xTJmHBsTI8Y+o8ap4IUd+8m3U62Z/Q==
X-Gm-Gg: Acq92OFAts5N19+DnH2IFrWVTugZQ+NsHJttHIN1+WYLFUMH+ooI7Q62pYDR/95dehT
 qPgy50suuFOQ7A8HZVT750xnH+EGJ8KkLYjkBtR96eevlbBGz42AA7NVAKYzYT1GhjddF5VERl1
 AqfDxSoQ6MHIOiqgmldYwDmwLAbVaYmSlCpcyyM/w8GsOXUGzDLw7FKNumiWXT5bNqtZMcvhK+b
 Q6BFkrztWJOoaDoQJ71J/YE1yJfdsObYmnTNsZ3CuvHxI25Xt+6YfnavShAzMBrZWSoKD3vmWbI
 ThZ89qw4AZdb6ffBCV+m2oyWgGtC9uNlLScGB4pOv+TxJB/lIGZtLGW6vr4KmaGQrqZpVanR58n
 wvHMsWi5NFsC7Kx+nOsnqe+Qad46ZuIxTfUds8nWZP0Q=
X-Received: by 2002:a05:6000:25fa:b0:45e:f5b6:7bf9 with SMTP id
 ffacd0b85a97d-46074b84e56mr8779308f8f.31.1781463984723; 
 Sun, 14 Jun 2026 12:06:24 -0700 (PDT)
X-Received: by 2002:a05:6000:25fa:b0:45e:f5b6:7bf9 with SMTP id
 ffacd0b85a97d-46074b84e56mr8779274f8f.31.1781463984112; 
 Sun, 14 Jun 2026 12:06:24 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f26392esm26626507f8f.3.2026.06.14.12.06.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jun 2026 12:06:23 -0700 (PDT)
Date: Sun, 14 Jun 2026 15:06:21 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Yi Liu <yi.l.liu@intel.com>, Xudong Hao <xudong.hao@intel.com>,
 Jason Wang <jasowang@redhat.com>,
 =?utf-8?Q?Cl=C3=A9ment?= Mathieu--Drif <clement.mathieu--drif@bull.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 016/106] intel_iommu_accel: Handle PASID entry addition for
 pc_inv_dsc request
Message-ID: <c93b82e7dde2e9c26ab743e80d19050bde988fdf.1781463125.git.mst@redhat.com>
References: <cover.1781463125.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1781463125.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
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

From: Zhenzhong Duan <zhenzhong.duan@intel.com>

Structure VTDAddressSpace includes some elements suitable for emulated
device and passthrough device without PASID, e.g., address space,
different memory regions, etc, it is also protected by vtd iommu lock,
all these are useless and become a burden for passthrough device with
PASID.

When there are lots of PASIDs used in one device, the AS and MRs are
all registered to memory core and impact the whole system performance.

So instead of using VTDAddressSpace to cache pasid entry for each pasid
of a passthrough device, we define a light weight structure
VTDAccelPASIDCacheEntry with only necessary elements for each pasid. We
will use this struct as a parameter to conduct binding/unbinding to
nested hwpt and to record the current bound nested hwpt. It's also
designed to support IOMMU_NO_PASID.

VTDAccelPASIDCacheEntry is designed to only be used in intel_iommu_accel.c,
similarly VTDPASIDCacheEntry should only be used in hw/i386/intel_iommu.c

When guest creates new PASID entries, QEMU will capture the pc_inv_dsc
(pasid cache invalidation) request, walk through each pasid in each
passthrough device for valid pasid entries, create a new
VTDAccelPASIDCacheEntry if not existing yet.

IOMMU_NO_PASID of passthrough device still need to register MRs in case
guest does not operate in scalable mode. So for IOMMU_NO_PASID, we have
both VTDPASIDCacheEntry and VTDAccelPASIDCacheEntry.

Co-developed-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Tested-by: Xudong Hao <xudong.hao@intel.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20260527054658.1021096-12-zhenzhong.duan@intel.com>
---
 hw/i386/intel_iommu.c          |   3 +
 hw/i386/intel_iommu_accel.c    | 156 +++++++++++++++++++++++++++++++++
 hw/i386/intel_iommu_accel.h    |  13 +++
 hw/i386/intel_iommu_internal.h |   8 ++
 4 files changed, 180 insertions(+)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 88e0c58c08..8e034efdfc 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -3181,6 +3181,8 @@ static void vtd_pasid_cache_sync(IntelIOMMUState *s, VTDPASIDCacheInfo *pc_info)
     g_hash_table_foreach(s->vtd_address_spaces, vtd_pasid_cache_sync_locked,
                          pc_info);
     vtd_iommu_unlock(s);
+
+    vtd_accel_pasid_cache_sync(s, pc_info);
 }
 
 static void vtd_replay_pasid_bindings_all(IntelIOMMUState *s)
@@ -4751,6 +4753,7 @@ static bool vtd_dev_set_iommu_device(PCIBus *bus, void *opaque, int devfn,
     vtd_hiod->devfn = (uint8_t)devfn;
     vtd_hiod->iommu_state = s;
     vtd_hiod->hiod = hiod;
+    QLIST_INIT(&vtd_hiod->pasid_cache_list);
 
     if (!vtd_check_hiod(s, vtd_hiod, errp)) {
         g_free(vtd_hiod);
diff --git a/hw/i386/intel_iommu_accel.c b/hw/i386/intel_iommu_accel.c
index 05b927f303..d2653f22ee 100644
--- a/hw/i386/intel_iommu_accel.c
+++ b/hw/i386/intel_iommu_accel.c
@@ -259,6 +259,162 @@ void vtd_flush_host_piotlb_all_locked(IntelIOMMUState *s, uint16_t domain_id,
                          vtd_flush_host_piotlb_locked, &piotlb_info);
 }
 
+static void vtd_accel_fill_pc(VTDHostIOMMUDevice *vtd_hiod, uint32_t pasid,
+                              VTDPASIDEntry *pe)
+{
+    VTDAccelPASIDCacheEntry *vtd_pce;
+
+    QLIST_FOREACH(vtd_pce, &vtd_hiod->pasid_cache_list, next) {
+        if (vtd_pce->pasid == pasid) {
+            if (vtd_pasid_entry_compare(pe, &vtd_pce->pasid_entry)) {
+                vtd_pce->pasid_entry = *pe;
+            }
+            return;
+        }
+    }
+
+    vtd_pce = g_malloc0(sizeof(VTDAccelPASIDCacheEntry));
+    vtd_pce->vtd_hiod = vtd_hiod;
+    vtd_pce->pasid = pasid;
+    vtd_pce->pasid_entry = *pe;
+    QLIST_INSERT_HEAD(&vtd_hiod->pasid_cache_list, vtd_pce, next);
+}
+
+/*
+ * This function walks over PASID range within [start, end) in a single
+ * PASID table for entries matching @info type/did, then create
+ * VTDAccelPASIDCacheEntry if not exist yet.
+ */
+static void vtd_sm_pasid_table_walk_one(VTDHostIOMMUDevice *vtd_hiod,
+                                        dma_addr_t pt_base, int start, int end,
+                                        VTDPASIDCacheInfo *info)
+{
+    IntelIOMMUState *s = vtd_hiod->iommu_state;
+    VTDPASIDEntry pe;
+    int pasid;
+
+    for (pasid = start; pasid < end; pasid++) {
+        if (vtd_get_pe_in_pasid_leaf_table(s, pasid, pt_base, &pe) ||
+            !vtd_pe_present(&pe)) {
+            continue;
+        }
+
+        if ((info->type == VTD_INV_DESC_PASIDC_G_DSI ||
+             info->type == VTD_INV_DESC_PASIDC_G_PASID_SI) &&
+            (info->did != VTD_SM_PASID_ENTRY_DID(&pe))) {
+            /*
+             * VTD_PASID_CACHE_DOMSI and VTD_PASID_CACHE_PASIDSI
+             * requires domain id check. If domain id check fail,
+             * go to next pasid.
+             */
+            continue;
+        }
+
+        vtd_accel_fill_pc(vtd_hiod, pasid, &pe);
+    }
+}
+
+/*
+ * In VT-d scalable mode translation, PASID dir + PASID table is used.
+ * This function aims at looping over a range of PASIDs in the given
+ * two level table to identify the pasid config in guest.
+ */
+static void vtd_sm_pasid_table_walk(VTDHostIOMMUDevice *vtd_hiod,
+                                    dma_addr_t pdt_base, int start, int end,
+                                    VTDPASIDCacheInfo *info)
+{
+    VTDPASIDDirEntry pdire;
+    int pasid = start;
+    int pasid_next;
+    dma_addr_t pt_base;
+
+    while (pasid < end) {
+        pasid_next = (pasid + VTD_PASID_TABLE_ENTRY_NUM) &
+                     ~(VTD_PASID_TABLE_ENTRY_NUM - 1);
+        pasid_next = pasid_next < end ? pasid_next : end;
+
+        if (!vtd_get_pdire_from_pdir_table(pdt_base, pasid, &pdire)
+            && vtd_pdire_present(&pdire)) {
+            pt_base = pdire.val & VTD_PASID_TABLE_BASE_ADDR_MASK;
+            vtd_sm_pasid_table_walk_one(vtd_hiod, pt_base, pasid, pasid_next,
+                                        info);
+        }
+        pasid = pasid_next;
+    }
+}
+
+static void vtd_accel_replay_pasid_bind_for_dev(VTDHostIOMMUDevice *vtd_hiod,
+                                                int start, int end,
+                                                VTDPASIDCacheInfo *pc_info)
+{
+    IntelIOMMUState *s = vtd_hiod->iommu_state;
+    VTDContextEntry ce;
+    int dev_max_pasid = 1 << vtd_hiod->hiod->caps.max_pasid_log2;
+
+    if (!vtd_dev_to_context_entry(s, pci_bus_num(vtd_hiod->bus),
+                                  vtd_hiod->devfn, &ce)) {
+        VTDPASIDCacheInfo walk_info = *pc_info;
+        uint32_t ce_max_pasid = vtd_sm_ce_get_pdt_entry_num(&ce) *
+                                VTD_PASID_TABLE_ENTRY_NUM;
+
+        end = MIN(end, MIN(dev_max_pasid, ce_max_pasid));
+
+        vtd_sm_pasid_table_walk(vtd_hiod, VTD_CE_GET_PASID_DIR_TABLE(&ce),
+                                start, end, &walk_info);
+    }
+}
+
+/*
+ * This function replays the guest pasid bindings by walking the two level
+ * guest PASID table. For each valid pasid entry, it creates an entry
+ * VTDAccelPASIDCacheEntry dynamically if not exist yet. This entry holds
+ * info specific to a pasid
+ */
+void vtd_accel_pasid_cache_sync(IntelIOMMUState *s, VTDPASIDCacheInfo *pc_info)
+{
+    int start = IOMMU_NO_PASID, end = 1 << s->pasid;
+    VTDHostIOMMUDevice *vtd_hiod;
+    GHashTableIter hiod_it;
+
+    if (!s->fsts) {
+        return;
+    }
+
+    switch (pc_info->type) {
+    case VTD_INV_DESC_PASIDC_G_PASID_SI:
+        start = pc_info->pasid;
+        end = pc_info->pasid + 1;
+        /* fall through */
+    case VTD_INV_DESC_PASIDC_G_DSI:
+        /*
+         * loop all assigned devices, do domain id check in
+         * vtd_sm_pasid_table_walk_one() after get pasid entry.
+         */
+        break;
+    case VTD_INV_DESC_PASIDC_G_GLOBAL:
+        /* loop all assigned devices */
+        break;
+    default:
+        g_assert_not_reached();
+    }
+
+    /*
+     * Loop all the vtd_hiod instances to sync the "pasid cache" per the
+     * guest pasid configuration.
+     *
+     * VTD translation callback never accesses vtd_hiod and its corresponding
+     * cached pasid entry, so no iommu lock needed here.
+     */
+    g_hash_table_iter_init(&hiod_it, s->vtd_host_iommu_dev);
+    while (g_hash_table_iter_next(&hiod_it, NULL, (void **)&vtd_hiod)) {
+        if (!object_dynamic_cast(OBJECT(vtd_hiod->hiod),
+                                 TYPE_HOST_IOMMU_DEVICE_IOMMUFD)) {
+            continue;
+        }
+        vtd_accel_replay_pasid_bind_for_dev(vtd_hiod, start, end, pc_info);
+    }
+}
+
 static uint64_t vtd_get_host_iommu_quirks(uint32_t type,
                                           void *caps, uint32_t size)
 {
diff --git a/hw/i386/intel_iommu_accel.h b/hw/i386/intel_iommu_accel.h
index e5f0b077b4..c9b1823745 100644
--- a/hw/i386/intel_iommu_accel.h
+++ b/hw/i386/intel_iommu_accel.h
@@ -12,6 +12,13 @@
 #define HW_I386_INTEL_IOMMU_ACCEL_H
 #include CONFIG_DEVICES
 
+typedef struct VTDAccelPASIDCacheEntry {
+    VTDHostIOMMUDevice *vtd_hiod;
+    VTDPASIDEntry pasid_entry;
+    uint32_t pasid;
+    QLIST_ENTRY(VTDAccelPASIDCacheEntry) next;
+} VTDAccelPASIDCacheEntry;
+
 #ifdef CONFIG_VTD_ACCEL
 bool vtd_check_hiod_accel(IntelIOMMUState *s, VTDHostIOMMUDevice *vtd_hiod,
                           Error **errp);
@@ -20,6 +27,7 @@ bool vtd_propagate_guest_pasid(VTDAddressSpace *vtd_as, Error **errp);
 void vtd_flush_host_piotlb_all_locked(IntelIOMMUState *s, uint16_t domain_id,
                                       uint32_t pasid, hwaddr addr,
                                       uint64_t npages, bool ih);
+void vtd_accel_pasid_cache_sync(IntelIOMMUState *s, VTDPASIDCacheInfo *pc_info);
 void vtd_iommu_ops_update_accel(PCIIOMMUOps *ops);
 #else
 static inline bool vtd_check_hiod_accel(IntelIOMMUState *s,
@@ -49,6 +57,11 @@ static inline void vtd_flush_host_piotlb_all_locked(IntelIOMMUState *s,
 {
 }
 
+static inline void vtd_accel_pasid_cache_sync(IntelIOMMUState *s,
+                                              VTDPASIDCacheInfo *pc_info)
+{
+}
+
 static inline void vtd_iommu_ops_update_accel(PCIIOMMUOps *ops)
 {
 }
diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
index ee59df09f8..9307825017 100644
--- a/hw/i386/intel_iommu_internal.h
+++ b/hw/i386/intel_iommu_internal.h
@@ -615,6 +615,7 @@ typedef struct VTDRootEntry VTDRootEntry;
 #define VTD_CTX_ENTRY_LEGACY_SIZE     16
 #define VTD_CTX_ENTRY_SCALABLE_SIZE   32
 
+#define VTD_SM_CONTEXT_ENTRY_PDTS(x)        extract64((x)->val[0], 9, 3)
 #define VTD_SM_CONTEXT_ENTRY_RSVD_VAL0(aw)  (0x1e0ULL | ~VTD_HAW_MASK(aw))
 #define VTD_SM_CONTEXT_ENTRY_RSVD_VAL1      0xffffffffffe00000ULL
 #define VTD_SM_CONTEXT_ENTRY_PRE            0x10ULL
@@ -645,6 +646,7 @@ typedef struct VTDPIOTLBInvInfo {
 #define VTD_PASID_DIR_BITS_MASK       (0x3fffULL)
 #define VTD_PASID_DIR_INDEX(pasid)    (((pasid) >> 6) & VTD_PASID_DIR_BITS_MASK)
 #define VTD_PASID_DIR_FPD             (1ULL << 1) /* Fault Processing Disable */
+#define VTD_PASID_TABLE_ENTRY_NUM     (1ULL << 6)
 #define VTD_PASID_TABLE_BITS_MASK     (0x3fULL)
 #define VTD_PASID_TABLE_INDEX(pasid)  ((pasid) & VTD_PASID_TABLE_BITS_MASK)
 #define VTD_PASID_ENTRY_FPD           (1ULL << 1) /* Fault Processing Disable */
@@ -710,6 +712,7 @@ typedef struct VTDHostIOMMUDevice {
     PCIBus *bus;
     uint8_t devfn;
     HostIOMMUDevice *hiod;
+    QLIST_HEAD(, VTDAccelPASIDCacheEntry) pasid_cache_list;
 } VTDHostIOMMUDevice;
 
 /*
@@ -767,6 +770,11 @@ static inline int vtd_pasid_entry_compare(VTDPASIDEntry *p1, VTDPASIDEntry *p2)
     return memcmp(p1, p2, sizeof(*p1));
 }
 
+static inline uint32_t vtd_sm_ce_get_pdt_entry_num(VTDContextEntry *ce)
+{
+    return 1U << (VTD_SM_CONTEXT_ENTRY_PDTS(ce) + 7);
+}
+
 int vtd_get_pdire_from_pdir_table(dma_addr_t pasid_dir_base, uint32_t pasid,
                                   VTDPASIDDirEntry *pdire);
 int vtd_get_pe_in_pasid_leaf_table(IntelIOMMUState *s, uint32_t pasid,
-- 
MST


