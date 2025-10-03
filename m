Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68A4FCAC5B0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 11:42:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4e9d-00036g-Tx; Fri, 03 Oct 2025 07:40:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wilfred.opensource@gmail.com>)
 id 1v4e9b-00035w-Fo
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 07:40:51 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wilfred.opensource@gmail.com>)
 id 1v4e9P-0006lv-8w
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 07:40:50 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-3381f041d7fso3529846a91.0
 for <qemu-devel@nongnu.org>; Fri, 03 Oct 2025 04:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759491633; x=1760096433; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MeQjU0t3BPQkBBrZIjEXnPEO8iYgoia/KTSQnv1ciFo=;
 b=KJDB3f/MOiUZFCxSF+QDJ0Kl/BApK6CJBtYddDzi1Za4noRdXF2fZqwQDEr97CLtdG
 BsIgT9jWGdbEGQgLpc+dXx6RNPJ9CM3mDBctMtMz95LAl1Gt+P7MWtczaxILvWe7xXvY
 OGcMeJSUjQYSR+RouFp6Wr3u/kXyhFbLq/Wzb8NFUEIsi8kVhroTFz/dBrHQRGV6t2Kj
 +KyueBZr/02RI5s/ZLK5SBd0bGYmOs9MRxw1IHWokzfBxzU59patzW6FYu7j7rN5l1AV
 GHoUQ1X9Y1OQcjiu/E9C5tke7BGAPP0NbLRSfRrG35E8jStc52R0iBsk05zQFPLhEGKL
 Vpsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759491633; x=1760096433;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MeQjU0t3BPQkBBrZIjEXnPEO8iYgoia/KTSQnv1ciFo=;
 b=JvtiWvJ2YozV/gnN8JGHMQHK90q/tfVmwU6jHUXi0Y+2I8ha6bAChKbrK7SwuMhbgv
 pjfRyOMcQAVh8pOVM60q0zIBGgzQwyuGVCTiyL0yuZKZc4q6615Fn4WrMxqdRjIE5MVS
 0lTMBuZUkW5gB6g1vmGHwjvVI1sfvcojwcYzfg0YLezZciEducv01QTW/TLo+zl0/O+2
 eU6XCRJnX01rwbNwNrQhc1QZ6maSQJsyeV/lG6YNZnBNJe4gaYMCPTJT1lwunoJmcNgy
 xA3Bbp9q1vDP9AwB7P5bn4K+Yn4xUtp8bxe7HXqegpZipq5fY7dwoSZAkGBXdV1RU7os
 4UWg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUtDoRHf9uIjN7ML5PlsRLfCoOymo/OgPcPpqEwnT1VD4kLTfWgQMqS7MJpJ1AqC3mHZPUBG+x/sZnI@nongnu.org
X-Gm-Message-State: AOJu0Yz+rS1w4P68kRwEtAlf7vfJgBNWpbuWkTr3JvYiuzVzZhx3CLHv
 PRs7RdzcpfAklIskW+9pxfDNcOJW4V0SHGTEzs5B7h16mMFGZJyuewiP
X-Gm-Gg: ASbGnctPueMYGZaxMWklWSOwx3AMrwYRGZAJei487s8hjr/bBjf8N4XAnpRpdOy8odC
 tcffDNgVxCXbTXQKhlkCFJq6Yc1IYLz9ewzaXgtBFZUEtMlEvbSYAaSb0hIkpvircC90uneCI3Z
 kWvMGBqHZU4mdBnCxQzw6TPn3ghFTON4d2IkiU3AlzLNiapdHHLhmJh0ICh97KpLyCTD8iPPIJf
 Ad7xOmo9kAeW7XycJgF6LmwEaXmCx5FtgexJpd1LZfXOF4uvwVzaFfNcLXE7yBFOcvawBQwwzIz
 KMAzuLYIDrOVQOvdqSaMSodFR8cI0fycR4Q2QxY1aCDpWVHPLLjDHvh3jRZX69ZgXY3VlY3oG2g
 erseIxWTTAKZGoncTw9T7VS8AwoHX7TSnyM97mPijesQuT8qhBUc=
X-Google-Smtp-Source: AGHT+IE3JwbfzPg78uJRMIEc94/bRqYOt0ju1rkXVxky5lZ+y4PcJFLjCdxMaW8igL4aDZ1fQBDZfQ==
X-Received: by 2002:a17:90b:5241:b0:32e:15e9:2cbc with SMTP id
 98e67ed59e1d1-339b50895f1mr7849037a91.5.1759491632773; 
 Fri, 03 Oct 2025 04:40:32 -0700 (PDT)
Received: from fedora ([159.196.5.243]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-339a6ff26f8sm7804995a91.13.2025.10.03.04.40.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Oct 2025 04:40:32 -0700 (PDT)
From: Wilfred Mallawa <wilfred.opensource@gmail.com>
To: Alistair Francis <alistair.francis@wdc.com>
Cc: Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, Wilfred Mallawa <wilfred.mallawa@wdc.com>,
 Klaus Jensen <k.jensen@samsung.com>
Subject: [PATCH v8 5/5] hw/nvme: connect SPDM over NVMe Security Send/Recv
Date: Fri,  3 Oct 2025 21:39:46 +1000
Message-ID: <20251003113945.87962-7-wilfred.opensource@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251003113945.87962-2-wilfred.opensource@gmail.com>
References: <20251003113945.87962-2-wilfred.opensource@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=wilfred.opensource@gmail.com; helo=mail-pj1-x102a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
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


