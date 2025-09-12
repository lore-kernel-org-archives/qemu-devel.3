Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96434CAC587
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Sep 2025 02:13:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwtHe-0002zo-Pl; Thu, 11 Sep 2025 22:13:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wilfred.opensource@gmail.com>)
 id 1uwtHG-0002jo-HZ
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 22:12:48 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wilfred.opensource@gmail.com>)
 id 1uwtHD-00059P-9O
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 22:12:41 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-24cb39fbd90so12453875ad.3
 for <qemu-devel@nongnu.org>; Thu, 11 Sep 2025 19:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757643158; x=1758247958; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7X1NXROzc/g77GSGWSORFJMpwrHccEZJKoS5nOctawY=;
 b=OxIVxmOAKYxKGQbXzOpy6u1EfW6sYHbvAaNGttzMZbIzH0oRYwExlue/E3Z5XvqxqC
 1PXLy3XwICiZITcvBUauT8edhrE6Y1tA32khz7aAhjk9rIeI/gJqI+Gwrd1yscJeDIN6
 9Tki9P6R+v/xugj3F1o5fHWCkLkzefoAX/27asQflWvtfO0qrS7lm8YwO7VSE1ZkDvLT
 REIEIfRlbBi70J7XgYtXAd0VsH2wHTwbu7xQSq+4UqMnkcjE+zzcu/8DjBeCoBD9zhqA
 j9W+QODZK1nqrvC7Za0ntSnurJSsVRosUcGlzjP+8et64dlBHeS4KmX5Rve89V2zk1he
 zPRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757643158; x=1758247958;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7X1NXROzc/g77GSGWSORFJMpwrHccEZJKoS5nOctawY=;
 b=s5gs6/z+MLwTiIXlZpzmabRvwiOTI0/Xw9HReW2uAnvMX1o8Q8NuWrawbPKy+P8Mxb
 yU2oEma8d00/UsJD+dZ8Lcqotxm5N9q/BiY92iWeWhiotRg026ebndW3Ctpe8YeE/fk/
 Gh0qH16vjzG9BXjT2qtE/S2XknGacUebBUhe71pHUlg5HrJYygQcH/H+Sxz/ppouEFWu
 OcAMD/d4CoIvaIIbwc/SJ0k3YJv/exzKW3in4etFRQRUR56IDxedfR+PwzRtclsvcJg9
 h4BBi7MLZUOAKKDpj1GpzzCSgamHS2NS138ryxgMxDWrubrvhmDULIKo9DtM4FqqqWFV
 cLjw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUXhmzsEbXE5JnQbjAQByghUFcHg9SK9M9LuBJikf0AI5nlC2n1zegO4C/qN7EQPUsLdgzSfZSnzvAk@nongnu.org
X-Gm-Message-State: AOJu0YxlY0khhGVLf+2s17rxJVVQVCjBAI/fzPCboknjHpOUVxgAKB2X
 KNpBHxSwlfvZuTyeHxPNpHyTsLFYOhGWu8a0if921vXaZyPJDaP0W6og
X-Gm-Gg: ASbGncupL7qnnZ97HM7lUqmIQXfamXyw+pqgXMu5d59v0nhjRrZGBIEhcnp5LFNLW1c
 E44fgAltFkrGalrWSMSN4kj55nuUoLFWK+EF+P4Kzztq/FOgvM/bBsOp86wJB7c/A84B030AlJV
 6jOO2qLj+ATI6X3NCsW5Pg04Ra+CxF3pwJU/+zL0+KgallGNJyDoDGj+eK49cHCzADHVNJWsjH9
 VlLes5nCQhcveaNAyJislWfS/0jXuzxm4pg+KJtmmfdmbB+m6n2RTp3bdK2VYCDs4wBOvpbOo9W
 EYEVzWUjSC6MBZqXjGSlaPChfJGastYtDWQEaTG2jZkcDrYAoUFgYRDz1oxM/wlPjZoyIEyqCCN
 N4i7MfKTLe4O+HOFzdGcOQN4OtH7Usd0=
X-Google-Smtp-Source: AGHT+IGUtt0LUte+Nzwrqy+qzPqAjY7qxu7c99nuebal7JqTuzrgEPio04mXdV9wHLdcFy9vgItr6w==
X-Received: by 2002:a17:902:cf06:b0:25c:19b4:7ae3 with SMTP id
 d9443c01a7336-25d2576ecc6mr15454975ad.24.1757643157657; 
 Thu, 11 Sep 2025 19:12:37 -0700 (PDT)
Received: from fedora ([159.196.5.243]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-25c3ad3349fsm32853205ad.104.2025.09.11.19.12.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Sep 2025 19:12:37 -0700 (PDT)
From: Wilfred Mallawa <wilfred.opensource@gmail.com>
To: Alistair Francis <alistair.francis@wdc.com>
Cc: Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 Jesper Devantier <foss@defmacro.it>, Stefan Hajnoczi <stefanha@redhat.com>,
 Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Wilfred Mallawa <wilfred.mallawa@wdc.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Klaus Jensen <k.jensen@samsung.com>
Subject: [PATCH v7 5/5] hw/nvme: connect SPDM over NVMe Security Send/Recv
Date: Fri, 12 Sep 2025 12:11:52 +1000
Message-ID: <20250912021152.46556-6-wilfred.opensource@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250912021152.46556-1-wilfred.opensource@gmail.com>
References: <20250912021152.46556-1-wilfred.opensource@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=wilfred.opensource@gmail.com; helo=mail-pl1-x633.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: Wilfred Mallawa <wilfred.mallawa@wdc.com>

This patch extends the existing support we have for NVMe with only DoE
to also add support to SPDM over the NVMe Security Send/Recv commands.

With the new definition of the `spdm-trans` argument, users can specify
`spdm_trans=nvme` or `spdm_trans=doe`. This allows us to select the SPDM
transport respectively. SPDM over the NVMe Security Send/Recv commands
are defined in the DMTF DSP0286.

Signed-off-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Klaus Jensen <k.jensen@samsung.com>
---
 docs/specs/spdm.rst         | 10 +++++++--
 hw/nvme/ctrl.c              | 45 ++++++++++++++++++++++++++++---------
 include/hw/pci/pci_device.h |  2 ++
 3 files changed, 44 insertions(+), 13 deletions(-)

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
index ad52e8f569..7928e9b0a9 100644
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
@@ -9250,9 +9262,14 @@ static void nvme_exit(PCIDevice *pci_dev)
         g_free(n->cmb.buf);
     }
 
+    /* Only one of the `spdm_socket`s below should have been setup */
+    assert(!(pci_dev->doe_spdm.spdm_socket > 0 && n->spdm_socket >= 0));
     if (pci_dev->doe_spdm.spdm_socket > 0) {
         spdm_socket_close(pci_dev->doe_spdm.spdm_socket,
                           SPDM_SOCKET_TRANSPORT_TYPE_PCI_DOE);
+    } else if (n->spdm_socket >= 0) {
+        spdm_socket_close(pci_dev->doe_spdm.spdm_socket,
+                          SPDM_SOCKET_TRANSPORT_TYPE_NVME);
     }
 
     if (n->pmr.dev) {
@@ -9307,6 +9324,8 @@ static const Property nvme_props[] = {
                      false),
     DEFINE_PROP_UINT16("mqes", NvmeCtrl, params.mqes, 0x7ff),
     DEFINE_PROP_UINT16("spdm_port", PCIDevice, spdm_port, 0),
+    DEFINE_PROP_SPDM_TRANS("spdm_trans", PCIDevice, spdm_trans,
+                           SPDM_SOCKET_TRANSPORT_TYPE_PCI_DOE),
     DEFINE_PROP_BOOL("ctratt.mem", NvmeCtrl, params.ctratt.mem, false),
     DEFINE_PROP_BOOL("atomic.dn", NvmeCtrl, params.atomic_dn, 0),
     DEFINE_PROP_UINT16("atomic.awun", NvmeCtrl, params.atomic_awun, 0),
@@ -9382,7 +9401,9 @@ static void nvme_pci_write_config(PCIDevice *dev, uint32_t address,
 {
     uint16_t old_num_vfs = pcie_sriov_num_vfs(dev);
 
-    if (pcie_find_capability(dev, PCI_EXT_CAP_ID_DOE)) {
+    /* DOE is only initialised if SPDM over DOE is used */
+    if (pcie_find_capability(dev, PCI_EXT_CAP_ID_DOE) &&
+        dev->spdm_trans == SPDM_SOCKET_TRANSPORT_TYPE_PCI_DOE) {
         pcie_doe_write_config(&dev->doe_spdm, address, val, len);
     }
     pci_default_write_config(dev, address, val, len);
@@ -9393,7 +9414,9 @@ static void nvme_pci_write_config(PCIDevice *dev, uint32_t address,
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


