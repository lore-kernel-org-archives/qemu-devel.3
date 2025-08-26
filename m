Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60A6CCA0EFA
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Aug 2025 05:48:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqmWr-0000iP-25; Tue, 26 Aug 2025 01:47:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wilfred.opensource@gmail.com>)
 id 1uqmWo-0000hp-Ls; Tue, 26 Aug 2025 01:47:30 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wilfred.opensource@gmail.com>)
 id 1uqmWh-0007HC-Nr; Tue, 26 Aug 2025 01:47:30 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2468e7c7b30so27661265ad.0; 
 Mon, 25 Aug 2025 22:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756187237; x=1756792037; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1nsEJMdFt1tNRfqfp3bEJq0v/9zje2N3ec0X3FuUg8Q=;
 b=fPOPkokBsG/zrJXil2F0seZPEd1rpisns2fBLmgNIx/Lq1f9NFeTWqGto+qhIGyor9
 fopFmNF5ruqXjdd+CTiS3UJHd5Oj7wjdMmQjRt1Xwq1Vmcsel4ul2W5lDQ0qndfXYqUC
 wYleRjrCZpMN8FLlHxJTUXgt0bzOTidS3cITPOudimIOVmpa6vdmvPhdYy6JltMomdC5
 86larE/mDjQtxF5bPQdXgCfYQcnpaLBYhnjyms/PxGFVV30lv3eml820YRjLjLnLruW2
 KmwNvKomn5IHkj4rHQXISCeCQcoOzOJbwzV7wU/6WZKOwG7LTDf77QG2T6gSP6Eb9HbW
 e2Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756187237; x=1756792037;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1nsEJMdFt1tNRfqfp3bEJq0v/9zje2N3ec0X3FuUg8Q=;
 b=qYeUdFPcAaOpgZtR8JEHkKRw5vSFvYd4xCe0vk1bfHAncfp+oriqMUKF4oXrew5Pcs
 zX5X+g1vvswnMJBHzSzF8o0KN43F0mZmMsJrbEU/4XHluwBEK1HBbWcwPBydPzTXNULd
 Pk0qlAV9n61Mh8Oq5TEzW2va9NgmagJ3lAfCZJp705R+BUw1LEDVlzO4EdpHHBN1N2Gk
 +ctL+diPBnw3DJ5NeX9WzsYdGmUngFEoJaGaxIwwECmNUKEyEHhJfHZFceUh8yXc+OXc
 zBgwt6FkDFy4SRCrqzsiQZ+MoK1HeXE6sqtfuoit0OBHmifGb7r2LLFW/ilelvPdeD1b
 qwKA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVFqNhNOtTRwTrpUttPgaMkZ+lN1rDEV4BjJ+7cR1lQXLSSPokM036hW+sBWpbVXqvouHaDcsdJ1n3rBg==@nongnu.org,
 AJvYcCXEzFFpcKkQmY//uG9v0/JSndtGDqZ9Ggo7kNsEDdZD8iugLXPqtqflwmv1xN1uyUSLR3tcRRoCX9yG@nongnu.org
X-Gm-Message-State: AOJu0Yw5laVcrWFFZUtwVKyKqIUqxicUo1HE3u3FMVOkVuvt3FklneRn
 uLv0g0SUI9U60VDhlWPX9FFyL6+e1VCX7d97+zGB5TluXJsksQ9IQqS7
X-Gm-Gg: ASbGncuzyc4GZzJHEgCUxPLQN7OMI0OxUSYZ1iaaNy9pL9FsZwt3M1cVO4TOnkqqtmo
 o86/WP59I2LVxC1t/5QuD1V1QoOyBzU1zQ/7nFdkx1uD9dFQ9HUVhmtP/dtsQRiDb5Wbj0xdmcj
 0vrpbo73sJUX/SMnSU9zAlH5f4zhworRwdtpkGPABbj3ebwHg7cYAQ8q/3xJ0t1pYcCslhyYp2e
 BVGQ/xG5zePpObHK0hOsmqh0NP+ltzlQm3B0hD7yGKWFx5tun6HAdgdyXfXrTQTEtVLUcQtBfxp
 0Aq1TGipyMjXL3Icndr0Qoxu9FT1JBRH2tiw/e2Rn0Z+QG38B7+NROt3zwK8MshU9DBosZ8l60M
 BREOK8eDTOeQp0jG5XfgmY+5pmw==
X-Google-Smtp-Source: AGHT+IFz5fHUIc3smiudz3ULlyoWrSKkEwLWXH2oY1dzzbE8O9f40TRvT0prr88zOT2wH29ir+w6XA==
X-Received: by 2002:a17:902:f707:b0:246:2733:940d with SMTP id
 d9443c01a7336-2462ee542abmr195030645ad.15.1756187236589; 
 Mon, 25 Aug 2025 22:47:16 -0700 (PDT)
Received: from fedora ([159.196.5.243]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-770401afdaesm9032365b3a.53.2025.08.25.22.47.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Aug 2025 22:47:15 -0700 (PDT)
From: Wilfred Mallawa <wilfred.opensource@gmail.com>
To: Alistair Francis <alistair.francis@wdc.com>
Cc: Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 Jesper Devantier <foss@defmacro.it>, Stefan Hajnoczi <stefanha@redhat.com>,
 Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, Wilfred Mallawa <wilfred.mallawa@wdc.com>
Subject: [PATCH 4/4] hw/nvme: connect SPDM over NVMe Security Send/Recv
Date: Tue, 26 Aug 2025 15:46:30 +1000
Message-ID: <20250826054630.222052-5-wilfred.opensource@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250826054630.222052-1-wilfred.opensource@gmail.com>
References: <20250826054630.222052-1-wilfred.opensource@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=wilfred.opensource@gmail.com; helo=mail-pl1-x629.google.com
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
 docs/specs/spdm.rst         | 10 ++++--
 hw/nvme/ctrl.c              | 62 ++++++++++++++++++++++++++++++-------
 include/hw/pci/pci_device.h |  1 +
 3 files changed, 60 insertions(+), 13 deletions(-)

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
index 442144642d..61feb9b35a 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -8849,6 +8849,23 @@ static DOEProtocol doe_spdm_prot[] = {
     { }
 };
 
+static inline uint32_t nvme_get_spdm_trans_type(PCIDevice *pci_dev)
+{
+    if (!pci_dev) {
+        return false;
+    }
+
+    if (!strcmp(pci_dev->spdm_trans, "nvme")) {
+        return SPDM_SOCKET_TRANSPORT_TYPE_NVME;
+    }
+
+    if (!strcmp(pci_dev->spdm_trans, "doe")) {
+        return SPDM_SOCKET_TRANSPORT_TYPE_PCI_DOE;
+    }
+
+    return 0;
+}
+
 static bool nvme_init_pci(NvmeCtrl *n, PCIDevice *pci_dev, Error **errp)
 {
     ERRP_GUARD();
@@ -8937,19 +8954,31 @@ static bool nvme_init_pci(NvmeCtrl *n, PCIDevice *pci_dev, Error **errp)
 
     pcie_cap_deverr_init(pci_dev);
 
-    /* DOE Initialisation */
+    /* SPDM Initialisation */
     if (pci_dev->spdm_port) {
-        uint16_t doe_offset = n->params.sriov_max_vfs ?
-                                  PCI_CONFIG_SPACE_SIZE + PCI_ARI_SIZEOF
-                                  : PCI_CONFIG_SPACE_SIZE;
+        switch  (nvme_get_spdm_trans_type(pci_dev)) {
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
@@ -9240,11 +9269,17 @@ static void nvme_exit(PCIDevice *pci_dev)
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
@@ -9297,6 +9332,7 @@ static const Property nvme_props[] = {
                      false),
     DEFINE_PROP_UINT16("mqes", NvmeCtrl, params.mqes, 0x7ff),
     DEFINE_PROP_UINT16("spdm_port", PCIDevice, spdm_port, 0),
+    DEFINE_PROP_STRING("spdm_trans", PCIDevice, spdm_trans),
     DEFINE_PROP_BOOL("ctratt.mem", NvmeCtrl, params.ctratt.mem, false),
     DEFINE_PROP_BOOL("atomic.dn", NvmeCtrl, params.atomic_dn, 0),
     DEFINE_PROP_UINT16("atomic.awun", NvmeCtrl, params.atomic_awun, 0),
@@ -9372,7 +9408,9 @@ static void nvme_pci_write_config(PCIDevice *dev, uint32_t address,
 {
     uint16_t old_num_vfs = pcie_sriov_num_vfs(dev);
 
-    if (pcie_find_capability(dev, PCI_EXT_CAP_ID_DOE)) {
+    /* DOE is only initialised if SPDM over DOE is used */
+    if (pcie_find_capability(dev, PCI_EXT_CAP_ID_DOE) &&
+        nvme_get_spdm_trans_type(dev) == SPDM_SOCKET_TRANSPORT_TYPE_PCI_DOE) {
         pcie_doe_write_config(&dev->doe_spdm, address, val, len);
     }
     pci_default_write_config(dev, address, val, len);
@@ -9383,7 +9421,9 @@ static void nvme_pci_write_config(PCIDevice *dev, uint32_t address,
 static uint32_t nvme_pci_read_config(PCIDevice *dev, uint32_t address, int len)
 {
     uint32_t val;
-    if (dev->spdm_port && pcie_find_capability(dev, PCI_EXT_CAP_ID_DOE)) {
+
+    if (dev->spdm_port && pcie_find_capability(dev, PCI_EXT_CAP_ID_DOE) &&
+        (nvme_get_spdm_trans_type(dev) == SPDM_SOCKET_TRANSPORT_TYPE_PCI_DOE)) {
         if (pcie_doe_read_config(&dev->doe_spdm, address, len, &val)) {
             return val;
         }
diff --git a/include/hw/pci/pci_device.h b/include/hw/pci/pci_device.h
index eee0338568..c98dc24001 100644
--- a/include/hw/pci/pci_device.h
+++ b/include/hw/pci/pci_device.h
@@ -166,6 +166,7 @@ struct PCIDevice {
 
     /* SPDM */
     uint16_t spdm_port;
+    char *spdm_trans;
 
     /* DOE */
     DOECap doe_spdm;
-- 
2.51.0


