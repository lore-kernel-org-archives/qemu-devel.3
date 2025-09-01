Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F301CA1000
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 03:50:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usvYG-0002Z1-IX; Sun, 31 Aug 2025 23:49:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wilfred.opensource@gmail.com>)
 id 1usvYD-0002Xz-JY; Sun, 31 Aug 2025 23:49:50 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wilfred.opensource@gmail.com>)
 id 1usvYB-0005iP-Eq; Sun, 31 Aug 2025 23:49:49 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2445824dc27so34707335ad.3; 
 Sun, 31 Aug 2025 20:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756698585; x=1757303385; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BaNp85xhBro5vjsl2MiptN5C04jXQ9rmCRsrEDehNZ8=;
 b=Y9RlGgYOPNTFXzYsEWbgmoD/9n+Q19jauTq737tm6dif7EekRGFIxAmIGk8YRz1rAI
 zACGn0hlfa1a9I7ci/uv2aEO8xCkSabyFJaxulj9u0JbTd3EKgbJ73ppZfp7VCSrw2Kl
 Y2hdUsKtAuJJCMJW8Lc6gy66rYbCzzaY3UzkDSGlxaImUAy3yZHBO52njRhZzEs92+yi
 bjCC3K9jk/OnQJr2zmKC+/CRbmBmTCShvIkaTBZoy9erUMBI+03BsORn3dtuIoUj2Q+v
 X5vM/UW6SNtmxLQSyXpe5Sg5s0nJTfFW0qhgJ4jXK8BM4/i2DqcOobQL9BCig79KXf5e
 S5rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756698585; x=1757303385;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BaNp85xhBro5vjsl2MiptN5C04jXQ9rmCRsrEDehNZ8=;
 b=UjkXQwb4PGq6sVBCmT7RfHuEcMaxuAZZn4F6yox+bXAPm70k3Z80nAj6QCPAuT3euX
 1FkNvqbsOVvsGOSYiq8pzlzDktlJo56Fj65bF88xYxo9OZNk7JLJUNFsJZRtpLJLaitk
 WNthY+BDTm/svtHjfcDVzlf4Uaf8+7i8+f55KCmxzAhzKLIEwmK/3GtTrw6zMdwPxMyn
 imfpXC9uONcuE+af0KkITW4KxjHLGoBfVVnVDqwmngeCIaMSh6T/AyQCJ2wFiCuKNjzi
 ilQo4R1K0azi4j+4w9C6JILudaU4VIu0laXfI6trxfEl+fA4wbs68/2Liys0CoRbFuVq
 0xQw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVaB3mTTh13TN1qs4AIs6jg2NpqdfbAfs2ZONPv+3nZNcK/aNVBcrGuzqLW+sCSjbLbbEhhyEfKFZGG@nongnu.org,
 AJvYcCWu6p9hOvDyRm5Xg5UZApGvGYSrX8KDNuPc9J9/oTLYIBubJuoyh3Rtj/11Qs92QDDncPUkPCvHNN20Uw==@nongnu.org
X-Gm-Message-State: AOJu0YynplOPcG3s90bU9HtNQQPkh6nspXyK2tVlQpi9NuZy1pUM83bv
 ieEZnqNRNw7xH51jGtH32r4HcMtivW51L6y9qfMqSpJRAbQlK17SWp5C
X-Gm-Gg: ASbGncsymxh7w23LjClE86WtzmqzxrRlpLNcqFubgmCE3lEYnHR9HHJ/iSuQtAnTYf2
 yzjNXE1IJJX5yeLCCduICO9VxvbvHDi8uyZ6e3viGg3odKbNCB7yVMkppVhYo6JagtgWssO7AsN
 Hey4k62AMFDCOpExJWa7G0AziSeNWcYPe8hCfMf57CD+yi/3Hg7sj4GRbTT6TyEdOezP03D1zTm
 YW8RutKhyWYVlm4rLhdmPtM9C2uttT2FaqtLYW1wplBesGChOCnTcwkM7Xr3loHW7/QTeDtGRSr
 fmhKv5kTfFWjiD+jTcLTH3m62b3rF6hXdq+zVjJsbZeU+dY6SGzV7za7IBZSvZvDWYWakzlXrHR
 g8CwJTOA9I93UyUkILdBjGRuwd4PQ0qW0vpLa
X-Google-Smtp-Source: AGHT+IGieSiM6D0me/v2iTpDKb8rbeuujO/S/dVswi0uy4O2xDoxHvRQKdCl+0w+5EX34ZM7yhp4JQ==
X-Received: by 2002:a17:902:e751:b0:248:a054:e1c4 with SMTP id
 d9443c01a7336-249448f8ad8mr79955915ad.23.1756698585422; 
 Sun, 31 Aug 2025 20:49:45 -0700 (PDT)
Received: from fedora ([159.196.5.243]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-24905da26b9sm89802815ad.93.2025.08.31.20.49.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 Aug 2025 20:49:44 -0700 (PDT)
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
 Wilfred Mallawa <wilfred.mallawa@wdc.com>
Subject: [PATCH v3 5/5] hw/nvme: connect SPDM over NVMe Security Send/Recv
Date: Mon,  1 Sep 2025 13:48:00 +1000
Message-ID: <20250901034759.85042-7-wilfred.opensource@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250901034759.85042-2-wilfred.opensource@gmail.com>
References: <20250901034759.85042-2-wilfred.opensource@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=wilfred.opensource@gmail.com; helo=mail-pl1-x62b.google.com
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
index 557f634016..9e69cd3433 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -8923,19 +8923,31 @@ static bool nvme_init_pci(NvmeCtrl *n, PCIDevice *pci_dev, Error **errp)
 
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
@@ -9226,11 +9238,17 @@ static void nvme_exit(PCIDevice *pci_dev)
         g_free(n->cmb.buf);
     }
 
+    /* Only one of the `spdm_socket` below would have been setup */
     if (pci_dev->doe_spdm.spdm_socket > 0) {
         spdm_socket_close(pci_dev->doe_spdm.spdm_socket,
                           SPDM_SOCKET_TRANSPORT_TYPE_PCI_DOE);
     }
 
+    if (n->spdm_socket > 0) {
+        spdm_socket_close(pci_dev->doe_spdm.spdm_socket,
+                          SPDM_SOCKET_TRANSPORT_TYPE_NVME);
+    }
+
     if (n->pmr.dev) {
         host_memory_backend_set_mapped(n->pmr.dev, false);
     }
@@ -9283,6 +9301,7 @@ static const Property nvme_props[] = {
                      false),
     DEFINE_PROP_UINT16("mqes", NvmeCtrl, params.mqes, 0x7ff),
     DEFINE_PROP_UINT16("spdm_port", PCIDevice, spdm_port, 0),
+    DEFINE_PROP_SPDM_TRANS_NODEFAULT("spdm_trans", PCIDevice, spdm_trans),
     DEFINE_PROP_BOOL("ctratt.mem", NvmeCtrl, params.ctratt.mem, false),
     DEFINE_PROP_BOOL("atomic.dn", NvmeCtrl, params.atomic_dn, 0),
     DEFINE_PROP_UINT16("atomic.awun", NvmeCtrl, params.atomic_awun, 0),
@@ -9358,7 +9377,9 @@ static void nvme_pci_write_config(PCIDevice *dev, uint32_t address,
 {
     uint16_t old_num_vfs = pcie_sriov_num_vfs(dev);
 
-    if (pcie_find_capability(dev, PCI_EXT_CAP_ID_DOE)) {
+    /* DOE is only initialised if SPDM over DOE is used */
+    if (pcie_find_capability(dev, PCI_EXT_CAP_ID_DOE) &&
+        dev->spdm_trans == SPDM_SOCKET_TRANSPORT_TYPE_PCI_DOE) {
         pcie_doe_write_config(&dev->doe_spdm, address, val, len);
     }
     pci_default_write_config(dev, address, val, len);
@@ -9369,7 +9390,9 @@ static void nvme_pci_write_config(PCIDevice *dev, uint32_t address,
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


