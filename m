Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA3F2CAC599
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Sep 2025 13:11:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyrsk-0002T2-6a; Wed, 17 Sep 2025 09:07:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1uyrpn-0005wU-AB; Wed, 17 Sep 2025 09:04:36 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1uyrpk-0005xw-AR; Wed, 17 Sep 2025 09:04:31 -0400
Received: from h205.csg.ci.i.u-tokyo.ac.jp (h205.csg.ci.i.u-tokyo.ac.jp
 [133.11.54.205]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 58HCuN6w008967
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 17 Sep 2025 21:56:46 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=5Zk0Ocd+QwOh+s35lDkbenDI0KEEnwyHPaEenyfugGE=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Date:Subject:Message-Id:To;
 s=rs20250326; t=1758113806; v=1;
 b=wEKO9sNxGPBX8w4kyKsEykeTFzHjov4MPkIsIUG+KOHhBAyrzgfFwYHAPOu7U1Cv
 2Dgx0JTk3yFxQ3KaPQDheJ13tPZUF30uml5QbOlwSEYBqiXXy5JbJf5ldcewt+gJ
 IDVoHgHf46gpPx5ljbUvIaQFqITzsSFJYXrnRh0EzlANvUFX8Zx54KQAycMG0c7d
 G4cVcmDIQoYIuvSSd2zbaI+0ALgVK0AMVk22SC0laW9jQ51s7WZ0RVMrnqHMzWvs
 c+FometxxqeREWqQdNxlHHQvNWJg2wDbPap/ggFBwRwh1YLAky7uY4/TMmL23BUO
 yAwStcwFUKmjixKxuNJqUg==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Wed, 17 Sep 2025 21:56:30 +0900
Subject: [PATCH 18/35] hw/pci-host: QOM-ify AddressSpace
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250917-qom-v1-18-7262db7b0a84@rsg.ci.i.u-tokyo.ac.jp>
References: <20250917-qom-v1-0-7262db7b0a84@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20250917-qom-v1-0-7262db7b0a84@rsg.ci.i.u-tokyo.ac.jp>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, Eric Auger <eric.auger@redhat.com>,
 Helge Deller <deller@gmx.de>,
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?utf-8?q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Ninad Palsule <ninad@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Jason Wang <jasowang@redhat.com>, Yi Liu <yi.l.liu@intel.com>,
 =?utf-8?q?Cl=C3=A9ment_Mathieu--Drif?= <clement.mathieu--drif@eviden.com>,
 Nicholas Piggin <npiggin@gmail.com>, Aditya Gupta <adityag@linux.ibm.com>,
 Gautam Menghani <gautam@linux.ibm.com>, Song Gao <gaosong@loongson.cn>,
 Bibo Mao <maobibo@loongson.cn>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Fan Ni <fan.ni@samsung.com>, David Hildenbrand <david@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
 Beniamino Galvani <b.galvani@gmail.com>,
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>,
 Jan Kiszka <jan.kiszka@web.de>, Laurent Vivier <laurent@vivier.eu>,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>, BALATON Zoltan <balaton@eik.bme.hu>,
 Bernhard Beschow <shentey@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Fam Zheng <fam@euphon.net>,
 Bin Meng <bmeng.cn@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Peter Xu <peterx@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 Max Filippov <jcmvbkbc@gmail.com>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, qemu-riscv@nongnu.org, qemu-s390x@nongnu.org,
 qemu-block@nongnu.org, kvm@vger.kernel.org,
 Alex Williamson <alex.williamson@redhat.com>,
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
X-Mailer: b4 0.15-dev-179e8
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Make AddressSpaces QOM objects to ensure that they are destroyed when
their owners are finalized and also to get a unique path for debugging
output.

The name arguments were used to distinguish AddresSpaces in debugging
output, but they will represent property names after QOM-ification and
debugging output will show QOM paths. So change them to make them more
concise and also avoid conflicts with other properties.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
 hw/pci-host/astro.c       | 3 +--
 hw/pci-host/designware.c  | 5 ++---
 hw/pci-host/dino.c        | 4 ++--
 hw/pci-host/gt64120.c     | 2 +-
 hw/pci-host/pnv_phb3.c    | 4 ++--
 hw/pci-host/pnv_phb4.c    | 4 ++--
 hw/pci-host/ppc440_pcix.c | 2 +-
 hw/pci-host/ppce500.c     | 2 +-
 hw/pci-host/raven.c       | 2 +-
 9 files changed, 13 insertions(+), 15 deletions(-)

diff --git a/hw/pci-host/astro.c b/hw/pci-host/astro.c
index bb6b7d05582f..19f6a7ac88f4 100644
--- a/hw/pci-host/astro.c
+++ b/hw/pci-host/astro.c
@@ -835,8 +835,7 @@ static void astro_realize(DeviceState *obj, Error **errp)
     memory_region_init_iommu(&s->iommu, sizeof(s->iommu),
                              TYPE_ASTRO_IOMMU_MEMORY_REGION, OBJECT(s),
                              "iommu-astro", UINT64_MAX);
-    address_space_init(&s->iommu_as, NULL, MEMORY_REGION(&s->iommu),
-                       "bm-pci");
+    address_space_init(&s->iommu_as, OBJECT(s), MEMORY_REGION(&s->iommu), "as");
 
     /* Create Elroys (PCI host bus chips).  */
     for (i = 0; i < ELROY_NUM; i++) {
diff --git a/hw/pci-host/designware.c b/hw/pci-host/designware.c
index d67211c9bc74..a542f6e9b1b1 100644
--- a/hw/pci-host/designware.c
+++ b/hw/pci-host/designware.c
@@ -706,9 +706,8 @@ static void designware_pcie_host_realize(DeviceState *dev, Error **errp)
                        UINT64_MAX);
     memory_region_add_subregion(&s->pci.address_space_root,
                                 0x0, &s->pci.memory);
-    address_space_init(&s->pci.address_space, NULL,
-                       &s->pci.address_space_root,
-                       "pcie-bus-address-space");
+    address_space_init(&s->pci.address_space, OBJECT(s),
+                       &s->pci.address_space_root, "as");
     pci_setup_iommu(pci->bus, &designware_iommu_ops, s);
 
     qdev_realize(DEVICE(&s->root), BUS(pci->bus), &error_fatal);
diff --git a/hw/pci-host/dino.c b/hw/pci-host/dino.c
index b78167fd2fcd..d213478c86ce 100644
--- a/hw/pci-host/dino.c
+++ b/hw/pci-host/dino.c
@@ -434,14 +434,14 @@ static void dino_pcihost_realize(DeviceState *dev, Error **errp)
     memory_region_add_subregion(&s->bm, 0xfff00000,
                                 &s->bm_cpu_alias);
 
-    address_space_init(&s->bm_as, NULL, &s->bm, "pci-bm");
+    address_space_init(&s->bm_as, OBJECT(s), &s->bm, "as");
 }
 
 static void dino_pcihost_unrealize(DeviceState *dev)
 {
     DinoState *s = DINO_PCI_HOST_BRIDGE(dev);
 
-    address_space_destroy(&s->bm_as);
+    object_unparent(OBJECT(&s->bm_as));
 }
 
 static void dino_pcihost_init(Object *obj)
diff --git a/hw/pci-host/gt64120.c b/hw/pci-host/gt64120.c
index 68ad885edbe4..89c4cf0bd5f8 100644
--- a/hw/pci-host/gt64120.c
+++ b/hw/pci-host/gt64120.c
@@ -1198,7 +1198,7 @@ static void gt64120_realize(DeviceState *dev, Error **errp)
     memory_region_init_io(&s->ISD_mem, OBJECT(dev), &isd_mem_ops, s,
                           "gt64120-isd", 0x1000);
     memory_region_init(&s->pci0_mem, OBJECT(dev), "pci0-mem", 4 * GiB);
-    address_space_init(&s->pci0_mem_as, NULL, &s->pci0_mem, "pci0-mem");
+    address_space_init(&s->pci0_mem_as, OBJECT(s), &s->pci0_mem, "as");
     phb->bus = pci_root_bus_new(dev, "pci",
                                 &s->pci0_mem,
                                 get_system_io(),
diff --git a/hw/pci-host/pnv_phb3.c b/hw/pci-host/pnv_phb3.c
index 73592c9cbd3d..554ad034b6f4 100644
--- a/hw/pci-host/pnv_phb3.c
+++ b/hw/pci-host/pnv_phb3.c
@@ -956,8 +956,8 @@ static AddressSpace *pnv_phb3_dma_iommu(PCIBus *bus, void *opaque, int devfn)
         memory_region_init_iommu(&ds->dma_mr, sizeof(ds->dma_mr),
                                  TYPE_PNV_PHB3_IOMMU_MEMORY_REGION,
                                  OBJECT(phb), "phb3_iommu", UINT64_MAX);
-        address_space_init(&ds->dma_as, NULL, MEMORY_REGION(&ds->dma_mr),
-                           "phb3_iommu");
+        address_space_init(&ds->dma_as, OBJECT(phb), MEMORY_REGION(&ds->dma_mr),
+                           "as");
         memory_region_init_io(&ds->msi32_mr, OBJECT(phb), &pnv_phb3_msi_ops,
                               ds, "msi32", 0x10000);
         memory_region_init_io(&ds->msi64_mr, OBJECT(phb), &pnv_phb3_msi_ops,
diff --git a/hw/pci-host/pnv_phb4.c b/hw/pci-host/pnv_phb4.c
index 9db9268358d1..0d7643e36036 100644
--- a/hw/pci-host/pnv_phb4.c
+++ b/hw/pci-host/pnv_phb4.c
@@ -1469,8 +1469,8 @@ static AddressSpace *pnv_phb4_dma_iommu(PCIBus *bus, void *opaque, int devfn)
         memory_region_init_iommu(&ds->dma_mr, sizeof(ds->dma_mr),
                                  TYPE_PNV_PHB4_IOMMU_MEMORY_REGION,
                                  OBJECT(phb), name, UINT64_MAX);
-        address_space_init(&ds->dma_as, NULL, MEMORY_REGION(&ds->dma_mr),
-                           name);
+        address_space_init(&ds->dma_as, OBJECT(phb), MEMORY_REGION(&ds->dma_mr),
+                           "as");
         memory_region_init_io(&ds->msi32_mr, OBJECT(phb), &pnv_phb4_msi_ops,
                               ds, "msi32", 0x10000);
         memory_region_init_io(&ds->msi64_mr, OBJECT(phb), &pnv_phb4_msi_ops,
diff --git a/hw/pci-host/ppc440_pcix.c b/hw/pci-host/ppc440_pcix.c
index 3fe24d70ac30..6500871f48ae 100644
--- a/hw/pci-host/ppc440_pcix.c
+++ b/hw/pci-host/ppc440_pcix.c
@@ -502,7 +502,7 @@ static void ppc440_pcix_realize(DeviceState *dev, Error **errp)
 
     memory_region_init(&s->bm, OBJECT(s), "bm-ppc440-pcix", UINT64_MAX);
     memory_region_add_subregion(&s->bm, 0x0, &s->busmem);
-    address_space_init(&s->bm_as, NULL, &s->bm, "pci-bm");
+    address_space_init(&s->bm_as, OBJECT(s), &s->bm, "as");
     pci_setup_iommu(h->bus, &ppc440_iommu_ops, s);
 
     memory_region_init(&s->container, OBJECT(s), "pci-container", PCI_ALL_SIZE);
diff --git a/hw/pci-host/ppce500.c b/hw/pci-host/ppce500.c
index eda168fb5955..94d5c53f328a 100644
--- a/hw/pci-host/ppce500.c
+++ b/hw/pci-host/ppce500.c
@@ -470,7 +470,7 @@ static void e500_pcihost_realize(DeviceState *dev, Error **errp)
     /* Set up PCI view of memory */
     memory_region_init(&s->bm, OBJECT(s), "bm-e500", UINT64_MAX);
     memory_region_add_subregion(&s->bm, 0x0, &s->busmem);
-    address_space_init(&s->bm_as, NULL, &s->bm, "pci-bm");
+    address_space_init(&s->bm_as, OBJECT(s), &s->bm, "as");
     pci_setup_iommu(b, &ppce500_iommu_ops, s);
 
     pci_create_simple(b, 0, TYPE_PPC_E500_PCI_BRIDGE);
diff --git a/hw/pci-host/raven.c b/hw/pci-host/raven.c
index 5564b51d6755..5bf87bdffa26 100644
--- a/hw/pci-host/raven.c
+++ b/hw/pci-host/raven.c
@@ -214,7 +214,7 @@ static void raven_pcihost_realize(DeviceState *d, Error **errp)
     memory_region_init_alias(mr, o, "bm-system", get_system_memory(),
                              0, 0x80000000);
     memory_region_add_subregion(bm, 0x80000000, mr);
-    address_space_init(&s->bm_as, NULL, bm, "raven-bm-as");
+    address_space_init(&s->bm_as, o, bm, "as");
     pci_setup_iommu(h->bus, &raven_iommu_ops, s);
 }
 

-- 
2.51.0


