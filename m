Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4EF4CAC5BB
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Oct 2025 19:23:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5UGY-0006Wc-0a; Sun, 05 Oct 2025 15:19:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1v5UFy-0004tj-5v
 for qemu-devel@nongnu.org; Sun, 05 Oct 2025 15:18:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1v5UFv-0006hL-Ie
 for qemu-devel@nongnu.org; Sun, 05 Oct 2025 15:18:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759691931;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5Fg8f/5q/T+Nvc5JsmIqdVO9saXZfQkqf6SsdokQXeo=;
 b=btEx6MG8ZZG9gJmDFr921roqi2oM1ZG9x6ACtX2/uxpJ2JhHQLW7BTwls20Fe5ESYRPVc2
 XzKlCjF8TVXrKzn0gBBmZSm/8c8pVO7QwZjxC4Nizfz19Hu6uYwa2TKbi60QaB0LlK2LxP
 9ToXUxur9jwJU4+bQTTucdaNqfY0Sps=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-14-jfHLh8PePD6vhj6hQ_F3pA-1; Sun, 05 Oct 2025 15:18:49 -0400
X-MC-Unique: jfHLh8PePD6vhj6hQ_F3pA-1
X-Mimecast-MFC-AGG-ID: jfHLh8PePD6vhj6hQ_F3pA_1759691928
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-46e4cc8ed76so16595185e9.1
 for <qemu-devel@nongnu.org>; Sun, 05 Oct 2025 12:18:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759691928; x=1760296728;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5Fg8f/5q/T+Nvc5JsmIqdVO9saXZfQkqf6SsdokQXeo=;
 b=jv3eI5ftoOoePbcE9Ah+CwaS26DWqawYZGAAPapx89R9iwWMa+9W39GwjUG2aQJYm5
 Yj+c6fZbnYONNoSl8J8jkWv/bD2B/xxE/OZIh4g/8TgKUwXBVN+pCnZf6DrzbbUemfJh
 hTKcAzlOQI/ZvsC432vlR6z9SXZFEZ3sMuS3lX1yGJdVBlNvGUaFxgH0iEuNGVfaxZ0E
 ybaKcEb3DkufVX0qhfpGAz41P+eDHFJYtFy+u4NkPCnoX9Jvhhp3i5zWhQlWAUkR/m/s
 Up2mkTk5GTjQvZvFIcoipaxZHMkK+btP1tEA3a5AX7wBCvDqeGuWDPOg5zwnT4+BpHOC
 36gA==
X-Gm-Message-State: AOJu0Yx9BazlNAvAnd6u6wyjWoRwSrAO3vX9AXKOp+KtOnG8uutRIYQ9
 sQCNL4871U5RE1nr6qnaVTgIALe+mrOvYf4ZsfJ2zsEFkLsCww/w8wnldMnLN3aprRJ5FJSj0mB
 LAk4a7gamVodwXXgo8EFacW8MzhVl3fgkzpaEvS0ew+SzDyGJikszgy0PT/vtQQ3rMUmjrGA1MK
 cAbPHKmsKkgapfIDchPLxwqGmcaTY7GGajpw==
X-Gm-Gg: ASbGncvMvCLFCZ7d+sAZTL/d3/AEfxaYx3pFb5KujuFwXU8zTR6M+EfCfd8XFO8XHjb
 dQ5//kPZElqDPI//M8GDmbFJeAIL3QnuHT1wNvsnuvenEqiqGHMdlLjYDlCZYd6ja7A+xFvwayv
 ydUa+MaD+alFjpNIBmRwYz7N3rqxeC/v1GGQ9L5WxSknmwgpVC+uZ5VgUR+s06JVpoYChBEy8/5
 A8GRDTEgthhuzrqUVCKP+7zFPVg6RvL0hOssgCdlCM8HAz0O/H00JJNiKo8XXRsF7Q2wNaPDW/y
 CSyOUgusLckyrQaEM1AQMGLr+EBl/8+VPM2mxJU=
X-Received: by 2002:a05:600c:468e:b0:43c:ec4c:25b4 with SMTP id
 5b1f17b1804b1-46e71102467mr68711075e9.10.1759691927837; 
 Sun, 05 Oct 2025 12:18:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHwTmvbVFdLroY3aGz4reKz3B8s5qBAydnmBV0tUrDRt4asYdmV2FjiRJDcnOU8pQuev3+2pg==
X-Received: by 2002:a05:600c:468e:b0:43c:ec4c:25b4 with SMTP id
 5b1f17b1804b1-46e71102467mr68710855e9.10.1759691927282; 
 Sun, 05 Oct 2025 12:18:47 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1518:6900:b69a:73e1:9698:9cd3])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8f017esm17972123f8f.47.2025.10.05.12.18.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Oct 2025 12:18:46 -0700 (PDT)
Date: Sun, 5 Oct 2025 15:18:45 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Jason Wang <jasowang@redhat.com>, Yi Liu <yi.l.liu@intel.com>,
 =?utf-8?Q?Cl=C3=A9ment?= Mathieu--Drif <clement.mathieu--drif@eviden.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 74/75] intel_iommu: Simplify caching mode check with VFIO device
Message-ID: <d288cb36e421361c66331ade09f02735c6d0959c.1759691708.git.mst@redhat.com>
References: <cover.1759691708.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1759691708.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.43,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Zhenzhong Duan <zhenzhong.duan@intel.com>

In early days, we had different tricks to ensure caching-mode=on with VFIO
device:

28cf553afe ("intel_iommu: Sanity check vfio-pci config on machine init done")
c6cbc29d36 ("pc/q35: Disallow vfio-pci hotplug without VT-d caching mode")

There is also a patch with the same purpose but for VDPA device:

b8d78277c0 ("intel-iommu: fail MAP notifier without caching mode")

Because without caching mode, MAP notifier won't work correctly since guest
won't send IOTLB update event when it establishes new mappings in the I/O page
tables.

Now with host IOMMU device interface between VFIO and vIOMMU, we can simplify
first two commits above with a small check in set_iommu_device(). This also
works for future IOMMUFD backed VDPA implementation which may also need caching
mode on. But for legacy VDPA we still need commit b8d78277c0 as it doesn't
use the host IOMMU device interface.

For coldplug VFIO device:

  qemu-system-x86_64: -device vfio-pci,host=0000:3b:00.0,id=hostdev3,bus=root0,iommufd=iommufd0: vfio 0000:3b:00.0: Failed to set vIOMMU: Device assignment is not allowed without enabling caching-mode=on for Intel IOMMU.

For hotplug VFIO device:

  if "iommu=off" is configured in guest,
    Error: vfio 0000:3b:00.0: Failed to set vIOMMU: Device assignment is not allowed without enabling caching-mode=on for Intel IOMMU.
  else
    Error: vfio 0000:3b:00.0: memory listener initialization failed: Region vtd-00.0-dmar: device 01.00.0 requires caching mode: Operation not supported

The specialty for hotplug is due to the check in commit b8d78277c0 happen before
the check in set_iommu_device.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20250929034206.439266-3-zhenzhong.duan@intel.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/intel_iommu.c | 40 ++++++----------------------------------
 hw/i386/pc.c          | 20 --------------------
 2 files changed, 6 insertions(+), 54 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 0378551038..6a168d5107 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -87,13 +87,6 @@ struct vtd_iotlb_key {
 static void vtd_address_space_refresh_all(IntelIOMMUState *s);
 static void vtd_address_space_unmap(VTDAddressSpace *as, IOMMUNotifier *n);
 
-static void vtd_panic_require_caching_mode(void)
-{
-    error_report("We need to set caching-mode=on for intel-iommu to enable "
-                 "device assignment with IOMMU protection.");
-    exit(1);
-}
-
 static void vtd_define_quad(IntelIOMMUState *s, hwaddr addr, uint64_t val,
                             uint64_t wmask, uint64_t w1cmask)
 {
@@ -4489,6 +4482,12 @@ static bool vtd_dev_set_iommu_device(PCIBus *bus, void *opaque, int devfn,
 
     assert(hiod);
 
+    if (!s->caching_mode) {
+        error_setg(errp, "Device assignment is not allowed without enabling "
+                   "caching-mode=on for Intel IOMMU.");
+        return false;
+    }
+
     vtd_iommu_lock(s);
 
     if (g_hash_table_lookup(s->vtd_host_iommu_dev, &key)) {
@@ -5244,32 +5243,6 @@ static bool vtd_decide_config(IntelIOMMUState *s, Error **errp)
     return true;
 }
 
-static int vtd_machine_done_notify_one(Object *child, void *unused)
-{
-    IntelIOMMUState *iommu = INTEL_IOMMU_DEVICE(x86_iommu_get_default());
-
-    /*
-     * We hard-coded here because vfio-pci is the only special case
-     * here.  Let's be more elegant in the future when we can, but so
-     * far there seems to be no better way.
-     */
-    if (object_dynamic_cast(child, "vfio-pci") && !iommu->caching_mode) {
-        vtd_panic_require_caching_mode();
-    }
-
-    return 0;
-}
-
-static void vtd_machine_done_hook(Notifier *notifier, void *unused)
-{
-    object_child_foreach_recursive(object_get_root(),
-                                   vtd_machine_done_notify_one, NULL);
-}
-
-static Notifier vtd_machine_done_notify = {
-    .notify = vtd_machine_done_hook,
-};
-
 static void vtd_realize(DeviceState *dev, Error **errp)
 {
     MachineState *ms = MACHINE(qdev_get_machine());
@@ -5324,7 +5297,6 @@ static void vtd_realize(DeviceState *dev, Error **errp)
     pci_setup_iommu(bus, &vtd_iommu_ops, dev);
     /* Pseudo address space under root PCI bus. */
     x86ms->ioapic_as = vtd_host_dma_iommu(bus, s, Q35_PSEUDO_DEVFN_IOAPIC);
-    qemu_add_machine_init_done_notifier(&vtd_machine_done_notify);
 }
 
 static void vtd_class_init(ObjectClass *klass, const void *data)
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index eb36d50589..34b00663f2 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1722,25 +1722,6 @@ static void pc_machine_wakeup(MachineState *machine)
     cpu_synchronize_all_post_reset();
 }
 
-static bool pc_hotplug_allowed(MachineState *ms, DeviceState *dev, Error **errp)
-{
-    X86IOMMUState *iommu = x86_iommu_get_default();
-    IntelIOMMUState *intel_iommu;
-
-    if (iommu &&
-        object_dynamic_cast((Object *)iommu, TYPE_INTEL_IOMMU_DEVICE) &&
-        object_dynamic_cast((Object *)dev, "vfio-pci")) {
-        intel_iommu = INTEL_IOMMU_DEVICE(iommu);
-        if (!intel_iommu->caching_mode) {
-            error_setg(errp, "Device assignment is not allowed without "
-                       "enabling caching-mode=on for Intel IOMMU.");
-            return false;
-        }
-    }
-
-    return true;
-}
-
 static void pc_machine_class_init(ObjectClass *oc, const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
@@ -1760,7 +1741,6 @@ static void pc_machine_class_init(ObjectClass *oc, const void *data)
     x86mc->apic_xrupt_override = true;
     assert(!mc->get_hotplug_handler);
     mc->get_hotplug_handler = pc_get_hotplug_handler;
-    mc->hotplug_allowed = pc_hotplug_allowed;
     mc->auto_enable_numa_with_memhp = true;
     mc->auto_enable_numa_with_memdev = true;
     mc->has_hotpluggable_cpus = true;
-- 
MST


