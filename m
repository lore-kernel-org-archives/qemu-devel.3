Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5F4FCAC583
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Sep 2025 06:03:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwaNu-0001Tz-Fp; Thu, 11 Sep 2025 02:02:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wilfred.opensource@gmail.com>)
 id 1uwaNt-0001PL-4X
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 02:02:17 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wilfred.opensource@gmail.com>)
 id 1uwaNp-0000bp-Uo
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 02:02:16 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-772301f8a4cso499002b3a.3
 for <qemu-devel@nongnu.org>; Wed, 10 Sep 2025 23:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757570532; x=1758175332; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GdC3nvafAzNHaUljJ+HTo3g+rlPelEIsbEjpQ/CG1p0=;
 b=c2qQRJ1qVPWFCGVDxZBYXZzgQKZAb6+zA8IM9jSxqH3lr20h8dD/DwdI0+WKoIYTZq
 7s6bgyAlrDlT8S8WfAAg8+UUe/g2bbMZQAtPi9U3eq7/kaLy4Hd78h6ctUGFA5hXMTj1
 14FTcnjbfcy3l/c5TiXlD2NaiJW64miO71OWvG/8S+4d6rxk3zcwT5RyaPl5CiYq0sW8
 Qhc5Wn3YealU4P2b1wf9I1HTDlrOeQaDhf0epDpwsp+/fSM0jiGF4etHLb/sdG00/Y3j
 fg8m9WFzq2CaqDvWDiI6jH5O/RZpFP4MeQMrwfIJBdt0+aF/CitBA1qiZce6QcOC5f5A
 uIyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757570532; x=1758175332;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GdC3nvafAzNHaUljJ+HTo3g+rlPelEIsbEjpQ/CG1p0=;
 b=jOq6I87MIQmpMW6GseMOMrBfs0472ORkT7H102x6Gz4BgjnLU6fahJesVc86tzzsDk
 4kG0elmkv1UtXrmQzR2d/GTG/GpY+DwGazbvB9MzW5sLI4aLYGPVLG4QPwFqDgKpXAKy
 94xKFO7xyI6rZXwB4sqHMk+s7ceGZknrNkljxnKVN7Z7m+py1niUUXRuW5AaetPDNlrO
 3OO7CNF1vXH+MxXBdA0ORDkpwy3VPITKRb96HLFb9sNnJz+45JicYvOaFuO06t2AaNRn
 Hq3B765I4NsYYzolO5g84JNFlNHGuaqVdSNFh5/dK5cf3p/7eiPuTeYzUjaIxOiVNz++
 m+Kw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV0x+rPmifxdYQ/U0a3w9uU2Z/sKeIvsc5x2MUpqGDlNdLPP3zvsW1epYi7C6cHd0Gx16yUNfZe0vMo@nongnu.org
X-Gm-Message-State: AOJu0Yy1crOga4O7//ep8hCOiCLpD0yk6UF4zXKOdO/xwMSoHUuehyvk
 rYtoGYtx+hcASz9Sbd6Wa/21S2IbIwen3PEPJAT7ARdP4KjGi9nEyEhR
X-Gm-Gg: ASbGncvpmiv8VklFBqS9kWtwv7UXjF17umsLKOofwlikE8ThqgXH7cyMejYYgOpGT0z
 XodXyvgBGSgeLW21cDL159rxxcA1YNH7yKOMbHSGDGfAXTFDAGcaDc39opyV5Kvhy8VrEBFFwkb
 FXR253WUePM7gff7VqYch32DvzeSSc9qBDgFgG+P8xo5rU2hULN/DFaIYCmTHwUBGDW26L3CtAL
 pquvhs5/BJ2WSeY5kGCNVy+uevAgvCUJI6QrkPCjlrIxP6jIxf987NNArYtVJX7t5uPdqzeYocb
 6RSty/LF3x2OkRs6cm3X2etrK1jDweQS1KPAbLsBV2FQDWIU6d00mVLOqtjdpzt0pR29oaBtFIu
 2UZIWSRq6PaPC2R/oF0ba++ZH/Kf6wjxaLOK/kB9ogQ==
X-Google-Smtp-Source: AGHT+IFvRF4XwTEO6UaU6QZpr4uMmqK5PXidAFq8PpYJp71YaKawvrCuVYurwAKWxUnFCt7cNcbSlg==
X-Received: by 2002:a05:6a00:1810:b0:772:8436:df3 with SMTP id
 d2e1a72fcca58-7742df03360mr25765218b3a.24.1757570532025; 
 Wed, 10 Sep 2025 23:02:12 -0700 (PDT)
Received: from fedora ([159.196.5.243]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-77607c54a71sm795381b3a.102.2025.09.10.23.02.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Sep 2025 23:02:11 -0700 (PDT)
From: Wilfred Mallawa <wilfred.opensource@gmail.com>
To: Alistair Francis <alistair.francis@wdc.com>
Cc: Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 Jesper Devantier <foss@defmacro.it>, Stefan Hajnoczi <stefanha@redhat.com>,
 Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, Jonathan Cameron <jonathan.cameron@huawei.com>,
 Wilfred Mallawa <wilfred.mallawa@wdc.com>
Subject: [PATCH v6 5/5] hw/nvme: connect SPDM over NVMe Security Send/Recv
Date: Thu, 11 Sep 2025 16:00:31 +1000
Message-ID: <20250911060031.124683-6-wilfred.opensource@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250911060031.124683-1-wilfred.opensource@gmail.com>
References: <20250911060031.124683-1-wilfred.opensource@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=wilfred.opensource@gmail.com; helo=mail-pf1-x42e.google.com
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

From: Wilfred Mallawa <wilfred.mallawa@wdc.com>

This patch extends the existing support we have for NVMe with only DoE
to also add support to SPDM over the NVMe Security Send/Recv commands.

With the new definition of the `spdm-trans` argument, users can specify
`spdm_trans=nvme` or `spdm_trans=doe`. This allows us to select the SPDM
transport respectively. SPDM over the NVMe Security Send/Recv commands
are defined in the DMTF DSP0286.

Signed-off-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
---
 docs/specs/spdm.rst         | 10 ++++++--
 hw/nvme/ctrl.c              | 46 ++++++++++++++++++++++++++++---------
 include/hw/pci/pci_device.h |  2 ++
 3 files changed, 45 insertions(+), 13 deletions(-)

diff --git a/docs/specs/spdm.rst b/docs/specs/spdm.rst
index f7de080ff0..dd6cfbbd68 100644
--- a/docs/specs/spdm.rst
+++ b/docs/specs/spdm.rst
@@ -98,7 +98,7 @@ Then you can add this to your QEMU command line:
 .. code-block:: shell
 
     -drive file=blknvme,if=none,id=mynvme,format=raw \
-        -device nvme,drive=mynvme,serial=deadbeef,spdm_port=2323
+        -device nvme,drive=mynvme,serial=deadbeef,spdm_port=2323,spdm_trans=doe
 
 At which point QEMU will try to connect to the SPDM server.
 
@@ -113,7 +113,13 @@ of the default. So the entire QEMU command might look like this
         -append "root=/dev/vda console=ttyS0" \
         -net none -nographic \
         -drive file=blknvme,if=none,id=mynvme,format=raw \
-        -device nvme,drive=mynvme,serial=deadbeef,spdm_port=2323
+        -device nvme,drive=mynvme,serial=deadbeef,spdm_port=2323,spdm_trans=doe
+
+The `spdm_trans` argument defines the underlying transport type that is emulated
+by QEMU. For an PCIe NVMe controller, both "doe" and "nvme" are supported. Where,
+"doe" does SPDM transport over the PCIe extended capability Data Object Exchange
+(DOE), and "nvme" uses the NVMe Admin Security Send/Receive commands to
+implement the SPDM transport.
 
 .. _DMTF:
    https://www.dmtf.org/standards/SPDM
diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index ad52e8f569..8a610f57f2 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -8947,19 +8947,31 @@ static bool nvme_init_pci(NvmeCtrl *n, PCIDevice *pci_dev, Error **errp)
 
     pcie_cap_deverr_init(pci_dev);
 
-    /* DOE Initialisation */
+    /* SPDM Initialisation */
     if (pci_dev->spdm_port) {
-        uint16_t doe_offset = n->params.sriov_max_vfs ?
-                                  PCI_CONFIG_SPACE_SIZE + PCI_ARI_SIZEOF
-                                  : PCI_CONFIG_SPACE_SIZE;
+        switch  (pci_dev->spdm_trans) {
+        case SPDM_SOCKET_TRANSPORT_TYPE_PCI_DOE:
+            uint16_t doe_offset = n->params.sriov_max_vfs ?
+                                    PCI_CONFIG_SPACE_SIZE + PCI_ARI_SIZEOF
+                                    : PCI_CONFIG_SPACE_SIZE;
 
-        pcie_doe_init(pci_dev, &pci_dev->doe_spdm, doe_offset,
-                      doe_spdm_prot, true, 0);
+            pcie_doe_init(pci_dev, &pci_dev->doe_spdm, doe_offset,
+                          doe_spdm_prot, true, 0);
 
-        pci_dev->doe_spdm.spdm_socket = spdm_socket_connect(pci_dev->spdm_port,
-                                                            errp);
+            pci_dev->doe_spdm.spdm_socket =
+                spdm_socket_connect(pci_dev->spdm_port, errp);
 
-        if (pci_dev->doe_spdm.spdm_socket < 0) {
+            if (pci_dev->doe_spdm.spdm_socket < 0) {
+                return false;
+            }
+            break;
+        case SPDM_SOCKET_TRANSPORT_TYPE_NVME:
+            n->spdm_socket = spdm_socket_connect(pci_dev->spdm_port, errp);
+            if (n->spdm_socket < 0) {
+                return false;
+            }
+            break;
+        default:
             return false;
         }
     }
@@ -9250,11 +9262,17 @@ static void nvme_exit(PCIDevice *pci_dev)
         g_free(n->cmb.buf);
     }
 
+    /* Only one of the `spdm_socket` below would have been setup */
     if (pci_dev->doe_spdm.spdm_socket > 0) {
         spdm_socket_close(pci_dev->doe_spdm.spdm_socket,
                           SPDM_SOCKET_TRANSPORT_TYPE_PCI_DOE);
     }
 
+    if (n->spdm_socket >= 0) {
+        spdm_socket_close(pci_dev->doe_spdm.spdm_socket,
+                          SPDM_SOCKET_TRANSPORT_TYPE_NVME);
+    }
+
     if (n->pmr.dev) {
         host_memory_backend_set_mapped(n->pmr.dev, false);
     }
@@ -9307,6 +9325,8 @@ static const Property nvme_props[] = {
                      false),
     DEFINE_PROP_UINT16("mqes", NvmeCtrl, params.mqes, 0x7ff),
     DEFINE_PROP_UINT16("spdm_port", PCIDevice, spdm_port, 0),
+    DEFINE_PROP_SPDM_TRANS("spdm_trans", PCIDevice, spdm_trans,
+                           SPDM_SOCKET_TRANSPORT_TYPE_PCI_DOE),
     DEFINE_PROP_BOOL("ctratt.mem", NvmeCtrl, params.ctratt.mem, false),
     DEFINE_PROP_BOOL("atomic.dn", NvmeCtrl, params.atomic_dn, 0),
     DEFINE_PROP_UINT16("atomic.awun", NvmeCtrl, params.atomic_awun, 0),
@@ -9382,7 +9402,9 @@ static void nvme_pci_write_config(PCIDevice *dev, uint32_t address,
 {
     uint16_t old_num_vfs = pcie_sriov_num_vfs(dev);
 
-    if (pcie_find_capability(dev, PCI_EXT_CAP_ID_DOE)) {
+    /* DOE is only initialised if SPDM over DOE is used */
+    if (pcie_find_capability(dev, PCI_EXT_CAP_ID_DOE) &&
+        dev->spdm_trans == SPDM_SOCKET_TRANSPORT_TYPE_PCI_DOE) {
         pcie_doe_write_config(&dev->doe_spdm, address, val, len);
     }
     pci_default_write_config(dev, address, val, len);
@@ -9393,7 +9415,9 @@ static void nvme_pci_write_config(PCIDevice *dev, uint32_t address,
 static uint32_t nvme_pci_read_config(PCIDevice *dev, uint32_t address, int len)
 {
     uint32_t val;
-    if (dev->spdm_port && pcie_find_capability(dev, PCI_EXT_CAP_ID_DOE)) {
+
+    if (dev->spdm_port && pcie_find_capability(dev, PCI_EXT_CAP_ID_DOE) &&
+        (dev->spdm_trans == SPDM_SOCKET_TRANSPORT_TYPE_PCI_DOE)) {
         if (pcie_doe_read_config(&dev->doe_spdm, address, len, &val)) {
             return val;
         }
diff --git a/include/hw/pci/pci_device.h b/include/hw/pci/pci_device.h
index eee0338568..88ccea5011 100644
--- a/include/hw/pci/pci_device.h
+++ b/include/hw/pci/pci_device.h
@@ -4,6 +4,7 @@
 #include "hw/pci/pci.h"
 #include "hw/pci/pcie.h"
 #include "hw/pci/pcie_doe.h"
+#include "system/spdm-socket.h"
 
 #define TYPE_PCI_DEVICE "pci-device"
 typedef struct PCIDeviceClass PCIDeviceClass;
@@ -166,6 +167,7 @@ struct PCIDevice {
 
     /* SPDM */
     uint16_t spdm_port;
+    SpdmTransportType spdm_trans;
 
     /* DOE */
     DOECap doe_spdm;
-- 
2.51.0


