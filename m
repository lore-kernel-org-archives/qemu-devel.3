Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25596CD98C5
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2026 19:10:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYqAP-0007d0-OR; Sun, 14 Jun 2026 15:06:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYqAL-0007Z2-VC
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:06:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYqAI-0001lC-M9
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:06:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781463998;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=t42E1gvfXHbcdWrJGb73splz5VVQusgkDd/EZry/Ttg=;
 b=A99TvxXsjl/t0z81FvQmuDzdT5nNI/H/Ms0yqaMes58JtZl3SsgtzfI88XQBD6CoCO37mn
 l1KhlEVYKCnoPxCF6c6Y2oZk4Ctpqu1DQn1gExlHcw6HuuZUfyMVUSnli6cckcXC3YjxlL
 WTaO4NDE0/+j0jwztU7KUQvpdVIYnoc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-550-Le1UZl6xOrqDlA6OaaGhNA-1; Sun, 14 Jun 2026 15:06:36 -0400
X-MC-Unique: Le1UZl6xOrqDlA6OaaGhNA-1
X-Mimecast-MFC-AGG-ID: Le1UZl6xOrqDlA6OaaGhNA_1781463995
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-45ef4931de5so2131874f8f.1
 for <qemu-devel@nongnu.org>; Sun, 14 Jun 2026 12:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781463995; x=1782068795; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=t42E1gvfXHbcdWrJGb73splz5VVQusgkDd/EZry/Ttg=;
 b=E5Uo42Tq8pj+3BikIeCRfJf5YgLRSYQyClK4NMhJFPOOlnKFj1oDmWtmAzkb/3i/nn
 +WDprWzWkgiKp4bSnmV6jpA2w6f5dekI+pps2AHWHTsFbz7ci159HGPQxoenxVCMpGah
 otIUNfBqkm85ZO+NyzcMZVGLscL+9eUD3Il1Ox8v0RdRpVyHka0HVRzKf+UlR0TUr8VI
 CtEr8A2hhxldT0cK0O0Wdbed5QtZz40NDWUPzkv3NZvtXyQvUl6M/qPU3iFPPy0JjTWT
 YBFZ+KxKMbcibuY4Bx2UIovs+0TjJP/YT4tSozF+t2uvCUT+umZ0kBV15Z5059AGEPF1
 7Psg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781463995; x=1782068795;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t42E1gvfXHbcdWrJGb73splz5VVQusgkDd/EZry/Ttg=;
 b=r/kDODG7t3/zzvIHi3jVaLYUTKnEuAomwj2Lb92WL3orrGlTVfiFCMxYQ95DT6IEic
 /bv2YwA4wrYWuPRXKswa5uxEHcCDlWyCGcmC3x1Ehsc3VbhrUlAtBGUja92uuWhuXmo+
 5ztFX067EM6QjxrejW6W1i+XmoBeSfASFJHdQlhLOxKtaCaN55hLPFE5ddU4B9Sk+m9p
 NLMjlsDgDEKJeAxMtMapodsEXd1JMEYaK7dypWu5rEHF8MkLUmPq8lhyg3Mx14Y+kWPq
 h2C+6wkqH1ZuL1OPmCMyMt7Z2iY9n1cl3e01YP4Bp2Yri+N5bgbbnT+gGr3+AxX8iCUP
 9VNQ==
X-Gm-Message-State: AOJu0YyjozT/mALkrWyTIzzUIPTOmyMwPCxlbxx34jvdNQuMvOE7YGH/
 iN5aIuU2yagwJUxSThbnhUQvemaoxcezlt2rEsXlPZQweZjDIyhf7ZHLW3DKwZNqqEWaoxKFWTI
 wKpM8WEzpNTq5XYSaBdIOlu7zA45sUzGT86ZCpJmygewcGC4wJm03KgeM5tfirAbAhhibu8czmT
 aPg8BNM+lb0pv3RkYovSUHtmljEldEcFytsw==
X-Gm-Gg: Acq92OFk4ar4wha/emdRk5sZEKmp1r79Lcbb++mtii3XIZSUCZNrVJSxsCYqg/dErf6
 NzaEhXzptFhft9wJuzboZaP+3/fCEBMbO0S83x3YIpB3mcyOQDpXpIfu74E2TGtUxvBufV84EdG
 pA2ZLS8KXmzgIqeFJ0W1qNVtGS1HQlEuimYykoXumSZNHSr/Hl5QIoNpHy/FRQfopwkbLiDLaAg
 dvFACAkr85pbAKeYN/GbxeOx2QdOtJqNXFEmZKjscuR7qcMzldt5ktAzljpPEOoAOVtoeLPKf11
 2PTFeDqmMm42pflPzFZDxBoWmXZweRL06Il8NThkVt6bmdki7WxpKUuy4K9EExRmvuJYyc7Aazj
 gzjimjkv3/CZu5iK/KNzZPWvBQgGaHSIqjEDmpC7YmvE=
X-Received: by 2002:a05:6000:2287:b0:45e:e936:5e30 with SMTP id
 ffacd0b85a97d-4606f21804dmr13761442f8f.6.1781463995258; 
 Sun, 14 Jun 2026 12:06:35 -0700 (PDT)
X-Received: by 2002:a05:6000:2287:b0:45e:e936:5e30 with SMTP id
 ffacd0b85a97d-4606f21804dmr13761393f8f.6.1781463994631; 
 Sun, 14 Jun 2026 12:06:34 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f2e6a8fsm27235280f8f.37.2026.06.14.12.06.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jun 2026 12:06:34 -0700 (PDT)
Date: Sun, 14 Jun 2026 15:06:32 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Yi Liu <yi.l.liu@intel.com>, Xudong Hao <xudong.hao@intel.com>,
 Jason Wang <jasowang@redhat.com>,
 =?utf-8?Q?Cl=C3=A9ment?= Mathieu--Drif <clement.mathieu--drif@bull.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 020/106] intel_iommu_accel: Switch to VTDAccelPASIDCacheEntry
 for PASID bind/unbind and PIOTLB invalidation
Message-ID: <4101df1201fa60eb3a0932485881453661a2edbf.1781463125.git.mst@redhat.com>
References: <cover.1781463125.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1781463125.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

This patch switches from VTDAddressSpace to VTDAccelPASIDCacheEntry for
handling PASID bind/unbind operations and PIOTLB invalidations in
passthrough scenarios. VTDAccelPASIDCacheEntry was introduced to cache
PASID entries for passthrough devices and is now ready to propagate
PASID bind/unbind operations and PIOTLB invalidations to the host.

Unlike the previous approach, VTDAccelPASIDCacheEntry supports both
IOMMU_NO_PASID (rid_pasid) and other valid PASIDs, so this switch drops
IOMMU_NO_PASID limitations that existed in the prior PASID bind/unbind
and PIOTLB invalidation path. For IOMMU_NO_PASID of passthrough devices,
VTDAddressSpace continues to handle shadow page modifications to the
host, but no longer manages PASID bind/unbind operations or PIOTLB
invalidations for passthrough scenarios.

Co-developed-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Tested-by: Xudong Hao <xudong.hao@intel.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20260527054658.1021096-16-zhenzhong.duan@intel.com>
---
 hw/i386/intel_iommu.c         |  17 +----
 hw/i386/intel_iommu_accel.c   | 131 +++++++++++++++++-----------------
 hw/i386/intel_iommu_accel.h   |   2 +-
 include/hw/i386/intel_iommu.h |   2 -
 4 files changed, 68 insertions(+), 84 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 0b341f741e..31addb98e4 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -86,8 +86,6 @@ static void vtd_pasid_cache_reset_locked(IntelIOMMUState *s)
         VTDPASIDCacheEntry *pc_entry = &vtd_as->pasid_cache_entry;
         if (pc_entry->valid) {
             pc_entry->valid = false;
-            /* It's fatal to get failure during reset */
-            vtd_propagate_guest_pasid(vtd_as, &error_fatal);
         }
     }
 }
@@ -3104,8 +3102,6 @@ static void vtd_pasid_cache_sync_locked(gpointer key, gpointer value,
     VTDPASIDEntry pe;
     IOMMUNotifier *n;
     uint16_t did;
-    const char *err_prefix = "Attaching to HWPT failed: ";
-    Error *local_err = NULL;
 
     if (vtd_dev_get_pe_from_pasid(vtd_as->iommu_state, vtd_as->bus,
                                   vtd_as->devfn, vtd_as->pasid, &pe)) {
@@ -3127,9 +3123,6 @@ static void vtd_pasid_cache_sync_locked(gpointer key, gpointer value,
             vtd_address_space_unmap(vtd_as, n);
         }
         vtd_switch_address_space(vtd_as);
-
-        err_prefix = "Detaching from HWPT failed: ";
-        goto do_bind_unbind;
     }
 
     /*
@@ -3157,20 +3150,12 @@ static void vtd_pasid_cache_sync_locked(gpointer key, gpointer value,
     if (!pc_entry->valid) {
         pc_entry->pasid_entry = pe;
         pc_entry->valid = true;
-    } else if (vtd_pasid_entry_compare(&pe, &pc_entry->pasid_entry)) {
-        err_prefix = "Replacing HWPT attachment failed: ";
-    } else {
+    } else if (!vtd_pasid_entry_compare(&pe, &pc_entry->pasid_entry)) {
         return;
     }
 
     vtd_switch_address_space(vtd_as);
     vtd_address_space_sync(vtd_as);
-
-do_bind_unbind:
-    /* TODO: Fault event injection into guest, report error to QEMU for now */
-    if (!vtd_propagate_guest_pasid(vtd_as, &local_err)) {
-        error_reportf_err(local_err, "%s", err_prefix);
-    }
 }
 
 static void vtd_pasid_cache_sync(IntelIOMMUState *s, VTDPASIDCacheInfo *pc_info)
diff --git a/hw/i386/intel_iommu_accel.c b/hw/i386/intel_iommu_accel.c
index 8308eb00cb..97991fc0d9 100644
--- a/hw/i386/intel_iommu_accel.c
+++ b/hw/i386/intel_iommu_accel.c
@@ -89,24 +89,25 @@ static bool vtd_create_fs_hwpt(VTDHostIOMMUDevice *vtd_hiod,
                                       fs_hwpt_id, errp);
 }
 
-static void vtd_destroy_old_fs_hwpt(VTDHostIOMMUDevice *vtd_hiod,
-                                    VTDAddressSpace *vtd_as)
+static void vtd_destroy_old_fs_hwpt(VTDAccelPASIDCacheEntry *vtd_pce)
 {
-    HostIOMMUDeviceIOMMUFD *hiodi = HOST_IOMMU_DEVICE_IOMMUFD(vtd_hiod->hiod);
+    HostIOMMUDeviceIOMMUFD *hiodi =
+        HOST_IOMMU_DEVICE_IOMMUFD(vtd_pce->vtd_hiod->hiod);
 
-    if (!vtd_as->fs_hwpt_id) {
+    if (!vtd_pce->fs_hwpt_id) {
         return;
     }
-    iommufd_backend_free_id(hiodi->iommufd, vtd_as->fs_hwpt_id);
-    vtd_as->fs_hwpt_id = 0;
+    iommufd_backend_free_id(hiodi->iommufd, vtd_pce->fs_hwpt_id);
+    vtd_pce->fs_hwpt_id = 0;
 }
 
-static bool vtd_device_attach_iommufd(VTDHostIOMMUDevice *vtd_hiod,
-                                      VTDAddressSpace *vtd_as, Error **errp)
+static bool vtd_device_attach_iommufd(VTDAccelPASIDCacheEntry *vtd_pce,
+                                      Error **errp)
 {
+    VTDHostIOMMUDevice *vtd_hiod = vtd_pce->vtd_hiod;
     HostIOMMUDeviceIOMMUFD *hiodi = HOST_IOMMU_DEVICE_IOMMUFD(vtd_hiod->hiod);
-    VTDPASIDEntry *pe = &vtd_as->pasid_cache_entry.pasid_entry;
-    uint32_t hwpt_id = hiodi->hwpt_id;
+    VTDPASIDEntry *pe = &vtd_pce->pasid_entry;
+    uint32_t hwpt_id = hiodi->hwpt_id, pasid = vtd_pce->pasid;
     bool ret;
 
     /*
@@ -126,14 +127,13 @@ static bool vtd_device_attach_iommufd(VTDHostIOMMUDevice *vtd_hiod,
         }
     }
 
-    ret = host_iommu_device_iommufd_attach_hwpt(hiodi, IOMMU_NO_PASID, hwpt_id,
-                                                errp);
-    trace_vtd_device_attach_hwpt(hiodi->devid, IOMMU_NO_PASID, hwpt_id, ret);
+    ret = host_iommu_device_iommufd_attach_hwpt(hiodi, pasid, hwpt_id, errp);
+    trace_vtd_device_attach_hwpt(hiodi->devid, pasid, hwpt_id, ret);
     if (ret) {
         /* Destroy old fs_hwpt if it's a replacement */
-        vtd_destroy_old_fs_hwpt(vtd_hiod, vtd_as);
+        vtd_destroy_old_fs_hwpt(vtd_pce);
         if (vtd_pe_pgtt_is_fst(pe)) {
-            vtd_as->fs_hwpt_id = hwpt_id;
+            vtd_pce->fs_hwpt_id = hwpt_id;
         }
     } else if (vtd_pe_pgtt_is_fst(pe)) {
         iommufd_backend_free_id(hiodi->iommufd, hwpt_id);
@@ -142,17 +142,19 @@ static bool vtd_device_attach_iommufd(VTDHostIOMMUDevice *vtd_hiod,
     return ret;
 }
 
-static bool vtd_device_detach_iommufd(VTDHostIOMMUDevice *vtd_hiod,
-                                      VTDAddressSpace *vtd_as, Error **errp)
+static bool vtd_device_detach_iommufd(VTDAccelPASIDCacheEntry *vtd_pce,
+                                      Error **errp)
 {
+    VTDHostIOMMUDevice *vtd_hiod = vtd_pce->vtd_hiod;
     HostIOMMUDeviceIOMMUFD *hiodi = HOST_IOMMU_DEVICE_IOMMUFD(vtd_hiod->hiod);
-    IntelIOMMUState *s = vtd_as->iommu_state;
+
+    IntelIOMMUState *s = vtd_hiod->iommu_state;
+    uint32_t pasid = vtd_pce->pasid;
     bool ret;
 
-    if (s->dmar_enabled && s->root_scalable) {
-        ret = host_iommu_device_iommufd_detach_hwpt(hiodi, IOMMU_NO_PASID,
-                                                    errp);
-        trace_vtd_device_detach_hwpt(hiodi->devid, IOMMU_NO_PASID, ret);
+    if (pasid != IOMMU_NO_PASID || (s->dmar_enabled && s->root_scalable)) {
+        ret = host_iommu_device_iommufd_detach_hwpt(hiodi, pasid, errp);
+        trace_vtd_device_detach_hwpt(hiodi->devid, pasid, ret);
     } else {
         /*
          * If DMAR remapping is disabled or guest switches to legacy mode,
@@ -166,58 +168,32 @@ static bool vtd_device_detach_iommufd(VTDHostIOMMUDevice *vtd_hiod,
     }
 
     if (ret) {
-        vtd_destroy_old_fs_hwpt(vtd_hiod, vtd_as);
+        vtd_destroy_old_fs_hwpt(vtd_pce);
     }
 
     return ret;
 }
 
-bool vtd_propagate_guest_pasid(VTDAddressSpace *vtd_as, Error **errp)
-{
-    VTDPASIDCacheEntry *pc_entry = &vtd_as->pasid_cache_entry;
-    VTDHostIOMMUDevice *vtd_hiod = vtd_find_hiod_iommufd(vtd_as);
-
-    /* Ignore emulated device or legacy VFIO backed device */
-    if (!vtd_as->iommu_state->fsts || !vtd_hiod) {
-        return true;
-    }
-
-    if (pc_entry->valid) {
-        return vtd_device_attach_iommufd(vtd_hiod, vtd_as, errp);
-    }
-
-    return vtd_device_detach_iommufd(vtd_hiod, vtd_as, errp);
-}
-
 /*
- * This function is a loop function for the s->vtd_address_spaces
- * list with VTDPIOTLBInvInfo as execution filter. It propagates
- * the piotlb invalidation to host.
+ * This function is a loop function for the s->vtd_host_iommu_dev
+ * and vtd_hiod->pasid_cache_list lists with VTDPIOTLBInvInfo as
+ * execution filter. It propagates the piotlb invalidation to host.
  */
-static void vtd_flush_host_piotlb_locked(gpointer key, gpointer value,
-                                         gpointer user_data)
+static void vtd_flush_host_piotlb_locked(VTDAccelPASIDCacheEntry *vtd_pce,
+                                         VTDPIOTLBInvInfo *piotlb_info)
 {
-    VTDPIOTLBInvInfo *piotlb_info = user_data;
-    VTDAddressSpace *vtd_as = value;
-    VTDHostIOMMUDevice *vtd_hiod = vtd_find_hiod_iommufd(vtd_as);
-    VTDPASIDCacheEntry *pc_entry = &vtd_as->pasid_cache_entry;
+    VTDHostIOMMUDevice *vtd_hiod = vtd_pce->vtd_hiod;
+    VTDPASIDEntry *pe = &vtd_pce->pasid_entry;
     uint16_t did;
 
-    if (!vtd_hiod) {
-        return;
-    }
-
-    assert(vtd_as->pasid == IOMMU_NO_PASID);
-
     /* Nothing to do if there is no first stage HWPT attached */
-    if (!pc_entry->valid ||
-        !vtd_pe_pgtt_is_fst(&pc_entry->pasid_entry)) {
+    if (!vtd_pe_pgtt_is_fst(pe)) {
         return;
     }
 
-    did = VTD_SM_PASID_ENTRY_DID(&pc_entry->pasid_entry);
+    did = VTD_SM_PASID_ENTRY_DID(pe);
 
-    if (piotlb_info->domain_id == did && piotlb_info->pasid == IOMMU_NO_PASID) {
+    if (piotlb_info->domain_id == did && piotlb_info->pasid == vtd_pce->pasid) {
         HostIOMMUDeviceIOMMUFD *hiodi =
             HOST_IOMMU_DEVICE_IOMMUFD(vtd_hiod->hiod);
         uint32_t entry_num = 1; /* Only implement one request for simplicity */
@@ -225,7 +201,7 @@ static void vtd_flush_host_piotlb_locked(gpointer key, gpointer value,
         struct iommu_hwpt_vtd_s1_invalidate *cache = piotlb_info->inv_data;
 
         if (!iommufd_backend_invalidate_cache(hiodi->iommufd,
-                                              vtd_as->fs_hwpt_id,
+                                              vtd_pce->fs_hwpt_id,
                                               IOMMU_HWPT_INVALIDATE_DATA_VTD_S1,
                                               sizeof(*cache), &entry_num, cache,
                                               &local_err)) {
@@ -241,6 +217,8 @@ void vtd_flush_host_piotlb_all_locked(IntelIOMMUState *s, uint16_t domain_id,
 {
     struct iommu_hwpt_vtd_s1_invalidate cache_info = { 0 };
     VTDPIOTLBInvInfo piotlb_info;
+    VTDHostIOMMUDevice *vtd_hiod;
+    GHashTableIter hiod_it;
 
     cache_info.addr = addr;
     cache_info.npages = npages;
@@ -251,23 +229,36 @@ void vtd_flush_host_piotlb_all_locked(IntelIOMMUState *s, uint16_t domain_id,
     piotlb_info.inv_data = &cache_info;
 
     /*
-     * Go through each vtd_as instance in s->vtd_address_spaces, find out
-     * affected host devices which need host piotlb invalidation. Piotlb
-     * invalidation should check pasid cache per architecture point of view.
+     * Go through each vtd_pce in vtd_hiod->pasid_cache_list for each host
+     * device, find out affected host device pasid which need host piotlb
+     * invalidation. Piotlb invalidation should check pasid cache per
+     * architecture point of view.
      */
-    g_hash_table_foreach(s->vtd_address_spaces,
-                         vtd_flush_host_piotlb_locked, &piotlb_info);
+    g_hash_table_iter_init(&hiod_it, s->vtd_host_iommu_dev);
+    while (g_hash_table_iter_next(&hiod_it, NULL, (void **)&vtd_hiod)) {
+        VTDAccelPASIDCacheEntry *vtd_pce;
+
+        QLIST_FOREACH(vtd_pce, &vtd_hiod->pasid_cache_list, next) {
+            vtd_flush_host_piotlb_locked(vtd_pce, &piotlb_info);
+        }
+    }
 }
 
 static void vtd_accel_fill_pc(VTDHostIOMMUDevice *vtd_hiod, uint32_t pasid,
                               VTDPASIDEntry *pe)
 {
     VTDAccelPASIDCacheEntry *vtd_pce;
+    Error *local_err = NULL;
 
     QLIST_FOREACH(vtd_pce, &vtd_hiod->pasid_cache_list, next) {
         if (vtd_pce->pasid == pasid) {
             if (vtd_pasid_entry_compare(pe, &vtd_pce->pasid_entry)) {
                 vtd_pce->pasid_entry = *pe;
+
+                if (!vtd_device_attach_iommufd(vtd_pce, &local_err)) {
+                    error_reportf_err(local_err, "%s",
+                                      "Replacing HWPT attachment failed: ");
+                }
             }
             return;
         }
@@ -278,11 +269,21 @@ static void vtd_accel_fill_pc(VTDHostIOMMUDevice *vtd_hiod, uint32_t pasid,
     vtd_pce->pasid = pasid;
     vtd_pce->pasid_entry = *pe;
     QLIST_INSERT_HEAD(&vtd_hiod->pasid_cache_list, vtd_pce, next);
+
+    if (!vtd_device_attach_iommufd(vtd_pce, &local_err)) {
+        error_reportf_err(local_err, "%s", "Attaching to HWPT failed: ");
+    }
 }
 
 static void vtd_accel_delete_pc(VTDAccelPASIDCacheEntry *vtd_pce,
                                 VTDPASIDCacheInfo *pc_info)
 {
+    Error *local_err = NULL;
+
+    if (!vtd_device_detach_iommufd(vtd_pce, &local_err)) {
+        error_reportf_err(local_err, "%s", "Detaching from HWPT failed: ");
+    }
+
     QLIST_REMOVE(vtd_pce, next);
     g_free(vtd_pce);
 
diff --git a/hw/i386/intel_iommu_accel.h b/hw/i386/intel_iommu_accel.h
index a2226b28b6..4a9003c92d 100644
--- a/hw/i386/intel_iommu_accel.h
+++ b/hw/i386/intel_iommu_accel.h
@@ -16,6 +16,7 @@ typedef struct VTDAccelPASIDCacheEntry {
     VTDHostIOMMUDevice *vtd_hiod;
     VTDPASIDEntry pasid_entry;
     uint32_t pasid;
+    uint32_t fs_hwpt_id;
     QLIST_ENTRY(VTDAccelPASIDCacheEntry) next;
 } VTDAccelPASIDCacheEntry;
 
@@ -23,7 +24,6 @@ typedef struct VTDAccelPASIDCacheEntry {
 bool vtd_check_hiod_accel(IntelIOMMUState *s, VTDHostIOMMUDevice *vtd_hiod,
                           Error **errp);
 VTDHostIOMMUDevice *vtd_find_hiod_iommufd(VTDAddressSpace *as);
-bool vtd_propagate_guest_pasid(VTDAddressSpace *vtd_as, Error **errp);
 void vtd_flush_host_piotlb_all_locked(IntelIOMMUState *s, uint16_t domain_id,
                                       uint32_t pasid, hwaddr addr,
                                       uint64_t npages, bool ih);
diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
index 95c76015e4..1842ba5840 100644
--- a/include/hw/i386/intel_iommu.h
+++ b/include/hw/i386/intel_iommu.h
@@ -154,8 +154,6 @@ struct VTDAddressSpace {
      * with the guest IOMMU pgtables for a device.
      */
     IOVATree *iova_tree;
-
-    uint32_t fs_hwpt_id;
 };
 
 struct VTDIOTLBEntry {
-- 
MST


