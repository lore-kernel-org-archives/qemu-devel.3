Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CA19C3064D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 14:11:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOeCN-0007i9-8P; Tue, 02 Jul 2024 10:09:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOeC4-0005oG-D3
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 10:09:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOeBv-0008IO-Sa
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 10:09:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719929345;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KfDnOZZL3lNpO7yBVqmvfyK4tBARWzqdyh5lLLcyyUM=;
 b=E1W/nnz+3kttYcLNF9/yp4nvvqE/HUcUe5h5uEMJGmA3VUxIUNjbrOqiM9xISIppEpLojD
 O4k1lnhXjtMqC50/bS0g6wI3Zm34jmb92OhBHzk2AEWSU8qVa69yoVsYB4BVGg4/dHX8KV
 fi8Fxwc6xxwWbq+bve+TPmgfYtMSOgU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-346-OhSw-WNBONiO6wG7VEiaQg-1; Tue, 02 Jul 2024 10:09:03 -0400
X-MC-Unique: OhSw-WNBONiO6wG7VEiaQg-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-362a0c1041dso2338960f8f.1
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 07:09:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719929340; x=1720534140;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KfDnOZZL3lNpO7yBVqmvfyK4tBARWzqdyh5lLLcyyUM=;
 b=OU6Ge4e4+sUoK3jaYguUD3YxqiTnqkcibALcGawGCNWZJkukwMr2XLkzn73S0vBIuZ
 lOL56a4flnWT7OD5wMK0M1ubJuNHVr+6iOwfd0q6IsWOj7ar36zioM8tmSzkuUiltgWV
 aOwckVb6kPegbu/6WbyQjzEcH0wtOzEYtF2VbQwDH+2zpVHfp3O6Z0UBBESrsph+o8do
 UUtkcmf2n51vSls6uhYK71gqZu0pLlVEtBWt1q/NT2Ax0+Y5PT9P1fjBq1lbgFTFYuDO
 FxuDbJnBUvpnfR3e2yktUW1Dm0FNcVPWTxS0NJLhn7CVLCF0Ac1Ez2pI0mEYQH/EVwUo
 C77Q==
X-Gm-Message-State: AOJu0YzbPbm0aOMaKuApvlUUkxiT6y6O0KxjKQC58RS2Zk9DvGPbwOoE
 S+0Px2TXOt48gjvt/T6IKHYk6hIMwWuzh3u1ycdco1K8B8LFGXqhaMzZKXH6o4Q9xJynceGtuQT
 ges9A0ukPwERc7rO8RhLEaFcwMguBPwFAa9yJYdEqCi0D4H/N/iQtFNwVAo8OpfLZ4lu2jYP4Kd
 bzQxgT+0QW/QjnRjrB49gAY0rN2KFwCw==
X-Received: by 2002:a05:6000:234:b0:362:8749:9639 with SMTP id
 ffacd0b85a97d-367756bc8demr4859055f8f.35.1719929340618; 
 Tue, 02 Jul 2024 07:09:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGO02rM1hBFYg6EYT/Jdc+yGp4nt4ds6H99z14/p9F8/p0HN6JoytdrYvA8axaGKbuFql8Ang==
X-Received: by 2002:a05:6000:234:b0:362:8749:9639 with SMTP id
 ffacd0b85a97d-367756bc8demr4859028f8f.35.1719929340059; 
 Tue, 02 Jul 2024 07:09:00 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f5:eadd:8c31:db01:9d01:7604])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a0e12e2sm13311036f8f.50.2024.07.02.07.08.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 07:08:59 -0700 (PDT)
Date: Tue, 2 Jul 2024 10:08:57 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jiqian Chen <Jiqian.Chen@amd.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>
Subject: [PULL 39/91] virtio-pci: implement No_Soft_Reset bit
Message-ID: <5d98e18823af6d5230fca8098a7ee966aaedeb29.1719929191.git.mst@redhat.com>
References: <cover.1719929191.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1719929191.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Jiqian Chen <Jiqian.Chen@amd.com>

In current code, when guest does S3, virtio-gpu are reset due to the
bit No_Soft_Reset is not set. After resetting, the display resources
of virtio-gpu are destroyed, then the display can't come back and only
show blank after resuming.

Implement No_Soft_Reset bit of PCI_PM_CTRL register, then guest can check
this bit, if this bit is set, the devices resetting will not be done, and
then the display can work after resuming.

No_Soft_Reset bit is implemented for all virtio devices, and was tested
only on virtio-gpu device. Set it false by default for safety.

Signed-off-by: Jiqian Chen <Jiqian.Chen@amd.com>
Message-Id: <20240606102205.114671-3-Jiqian.Chen@amd.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/virtio/virtio-pci.h |  5 +++++
 hw/core/machine.c              |  1 +
 hw/virtio/virtio-pci.c         | 29 +++++++++++++++++++++++++++++
 3 files changed, 35 insertions(+)

diff --git a/include/hw/virtio/virtio-pci.h b/include/hw/virtio/virtio-pci.h
index 59d88018c1..9e67ba38c7 100644
--- a/include/hw/virtio/virtio-pci.h
+++ b/include/hw/virtio/virtio-pci.h
@@ -43,6 +43,7 @@ enum {
     VIRTIO_PCI_FLAG_INIT_FLR_BIT,
     VIRTIO_PCI_FLAG_AER_BIT,
     VIRTIO_PCI_FLAG_ATS_PAGE_ALIGNED_BIT,
+    VIRTIO_PCI_FLAG_PM_NO_SOFT_RESET_BIT,
 };
 
 /* Need to activate work-arounds for buggy guests at vmstate load. */
@@ -79,6 +80,10 @@ enum {
 /* Init Power Management */
 #define VIRTIO_PCI_FLAG_INIT_PM (1 << VIRTIO_PCI_FLAG_INIT_PM_BIT)
 
+/* Init The No_Soft_Reset bit of Power Management */
+#define VIRTIO_PCI_FLAG_PM_NO_SOFT_RESET \
+  (1 << VIRTIO_PCI_FLAG_PM_NO_SOFT_RESET_BIT)
+
 /* Init Function Level Reset capability */
 #define VIRTIO_PCI_FLAG_INIT_FLR (1 << VIRTIO_PCI_FLAG_INIT_FLR_BIT)
 
diff --git a/hw/core/machine.c b/hw/core/machine.c
index 655d75c21f..f4cba6496c 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -38,6 +38,7 @@ GlobalProperty hw_compat_9_0[] = {
     {"arm-cpu", "backcompat-cntfrq", "true" },
     {"scsi-disk-base", "migrate-emulated-scsi-request", "false" },
     {"vfio-pci", "skip-vsc-check", "false" },
+    { "virtio-pci", "x-pcie-pm-no-soft-reset", "off" },
 };
 const size_t hw_compat_9_0_len = G_N_ELEMENTS(hw_compat_9_0);
 
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index 5941f1a94d..9534730bba 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -2222,6 +2222,11 @@ static void virtio_pci_realize(PCIDevice *pci_dev, Error **errp)
             pcie_cap_lnkctl_init(pci_dev);
         }
 
+        if (proxy->flags & VIRTIO_PCI_FLAG_PM_NO_SOFT_RESET) {
+            pci_set_word(pci_dev->config + pos + PCI_PM_CTRL,
+                         PCI_PM_CTRL_NO_SOFT_RESET);
+        }
+
         if (proxy->flags & VIRTIO_PCI_FLAG_INIT_PM) {
             /* Init Power Management Control Register */
             pci_set_word(pci_dev->wmask + pos + PCI_PM_CTRL,
@@ -2284,11 +2289,33 @@ static void virtio_pci_reset(DeviceState *qdev)
     }
 }
 
+static bool virtio_pci_no_soft_reset(PCIDevice *dev)
+{
+    uint16_t pmcsr;
+
+    if (!pci_is_express(dev) || !dev->exp.pm_cap) {
+        return false;
+    }
+
+    pmcsr = pci_get_word(dev->config + dev->exp.pm_cap + PCI_PM_CTRL);
+
+    /*
+     * When No_Soft_Reset bit is set and the device
+     * is in D3hot state, don't reset device
+     */
+    return (pmcsr & PCI_PM_CTRL_NO_SOFT_RESET) &&
+           (pmcsr & PCI_PM_CTRL_STATE_MASK) == 3;
+}
+
 static void virtio_pci_bus_reset_hold(Object *obj, ResetType type)
 {
     PCIDevice *dev = PCI_DEVICE(obj);
     DeviceState *qdev = DEVICE(obj);
 
+    if (virtio_pci_no_soft_reset(dev)) {
+        return;
+    }
+
     virtio_pci_reset(qdev);
 
     if (pci_is_express(dev)) {
@@ -2328,6 +2355,8 @@ static Property virtio_pci_properties[] = {
                     VIRTIO_PCI_FLAG_INIT_LNKCTL_BIT, true),
     DEFINE_PROP_BIT("x-pcie-pm-init", VirtIOPCIProxy, flags,
                     VIRTIO_PCI_FLAG_INIT_PM_BIT, true),
+    DEFINE_PROP_BIT("x-pcie-pm-no-soft-reset", VirtIOPCIProxy, flags,
+                    VIRTIO_PCI_FLAG_PM_NO_SOFT_RESET_BIT, false),
     DEFINE_PROP_BIT("x-pcie-flr-init", VirtIOPCIProxy, flags,
                     VIRTIO_PCI_FLAG_INIT_FLR_BIT, true),
     DEFINE_PROP_BIT("aer", VirtIOPCIProxy, flags,
-- 
MST


