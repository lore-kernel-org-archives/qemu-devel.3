Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAB59CA101F
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Sep 2025 02:16:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uuiSG-0004BL-Hl; Fri, 05 Sep 2025 22:15:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1uuiS9-00047n-4u; Fri, 05 Sep 2025 22:14:57 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1uuiRz-0006fu-2C; Fri, 05 Sep 2025 22:14:56 -0400
Received: from [10.40.4.92] (93-51-222-138.ip268.fastwebnet.it [93.51.222.138])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 5862Btnc041566
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Sat, 6 Sep 2025 11:13:32 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=z0YH0QMtBFBQG+CaXT27uewgJWSh8xAMHDbxqOUFkk0=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Date:Subject:Message-Id:To;
 s=rs20250326; t=1757124824; v=1;
 b=dUG7IxeSwdaFRl5BCwStf6XW+NsPZGVu+YAteuNfU0uUew8NQaMg9rCIMpGpmgbR
 wA462bZlG4iL140bRfgT9k0Q+n9sUH+G5PhWIW7gbcMDBCz05HTVhgAOvlqsS0b4
 sFC8u0iWySBTXFqR91zNWYiIRoIyhCrtOKkp62RoTeHNNYpeNP2ajqkZgnutOYGB
 /dqCenir3UpnOoWcNkY1T1zH/wm3jsQlAaT54CtbNA7kYcA1Eubbtft/FW5MOXPs
 Lh9BeP0o2dI9fxDR781DStOueVFQLJm6VejfBIU7PH21LDdD335GrHNCniBtKw7F
 wKzK8hGGKQcO5WsbwuEUVA==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Sat, 06 Sep 2025 04:11:16 +0200
Subject: [PATCH 07/22] hw/pci-host/raven: Fix AddressSpace exposure timing
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250906-use-v1-7-c51caafd1eb7@rsg.ci.i.u-tokyo.ac.jp>
References: <20250906-use-v1-0-c51caafd1eb7@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20250906-use-v1-0-c51caafd1eb7@rsg.ci.i.u-tokyo.ac.jp>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>,
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-block@nongnu.org, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>, Jesper Devantier <foss@defmacro.it>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 John Levon <john.levon@nutanix.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 Yanan Wang <wangyanan55@huawei.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>,
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Rikalo <arikalo@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>,
 =?utf-8?q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
X-Mailer: b4 0.14.2
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

raven-pcihost is not hotpluggable but its instance can still be created
and finalized when processing the device-list-properties QMP command.
Exposing such a temporary instance to AddressSpace should be
avoided because it leaks the instance.

Expose instances to the AddressSpace at their realization time so that
it won't happen for the temporary instances.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
 hw/pci-host/raven.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/hw/pci-host/raven.c b/hw/pci-host/raven.c
index f8c0be5d21c351305742a696a65f70f87b546b0c..82f245c91cf267cdc6a518765a8c31d06eac7228 100644
--- a/hw/pci-host/raven.c
+++ b/hw/pci-host/raven.c
@@ -233,6 +233,20 @@ static void raven_pcihost_realizefn(DeviceState *d, Error **errp)
     MemoryRegion *address_space_mem = get_system_memory();
     int i;
 
+    address_space_init(&s->pci_io_as, &s->pci_io, "raven-io");
+
+    /* CPU address space */
+    memory_region_add_subregion(address_space_mem, PCI_IO_BASE_ADDR,
+                                &s->pci_io);
+    memory_region_add_subregion_overlap(address_space_mem, PCI_IO_BASE_ADDR,
+                                        &s->pci_io_non_contiguous, 1);
+    memory_region_add_subregion(address_space_mem, 0xc0000000, &s->pci_memory);
+    pci_root_bus_init(&s->pci_bus, sizeof(s->pci_bus), DEVICE(d), NULL,
+                      &s->pci_memory, &s->pci_io, 0, TYPE_PCI_BUS);
+
+    address_space_init(&s->bm_as, &s->bm, "raven-bm");
+    pci_setup_iommu(&s->pci_bus, &raven_iommu_ops, s);
+
     /*
      * According to PReP specification section 6.1.6 "System Interrupt
      * Assignments", all PCI interrupts are routed via IRQ 15
@@ -276,14 +290,12 @@ static void raven_pcihost_initfn(Object *obj)
 {
     PCIHostState *h = PCI_HOST_BRIDGE(obj);
     PREPPCIState *s = RAVEN_PCI_HOST_BRIDGE(obj);
-    MemoryRegion *address_space_mem = get_system_memory();
     DeviceState *pci_dev;
 
     memory_region_init(&s->pci_io, obj, "pci-io", 0x3f800000);
     memory_region_init_io(&s->pci_io_non_contiguous, obj, &raven_io_ops, s,
                           "pci-io-non-contiguous", 0x00800000);
     memory_region_init(&s->pci_memory, obj, "pci-memory", 0x3f000000);
-    address_space_init(&s->pci_io_as, &s->pci_io, "raven-io");
 
     /*
      * Raven's raven_io_ops use the address-space API to access pci-conf-idx
@@ -292,15 +304,6 @@ static void raven_pcihost_initfn(Object *obj)
      */
     s->pci_io_non_contiguous.disable_reentrancy_guard = true;
 
-    /* CPU address space */
-    memory_region_add_subregion(address_space_mem, PCI_IO_BASE_ADDR,
-                                &s->pci_io);
-    memory_region_add_subregion_overlap(address_space_mem, PCI_IO_BASE_ADDR,
-                                        &s->pci_io_non_contiguous, 1);
-    memory_region_add_subregion(address_space_mem, 0xc0000000, &s->pci_memory);
-    pci_root_bus_init(&s->pci_bus, sizeof(s->pci_bus), DEVICE(obj), NULL,
-                      &s->pci_memory, &s->pci_io, 0, TYPE_PCI_BUS);
-
     /* Bus master address space */
     memory_region_init(&s->bm, obj, "bm-raven", 4 * GiB);
     memory_region_init_alias(&s->bm_pci_memory_alias, obj, "bm-pci-memory",
@@ -310,8 +313,6 @@ static void raven_pcihost_initfn(Object *obj)
                              get_system_memory(), 0, 0x80000000);
     memory_region_add_subregion(&s->bm, 0         , &s->bm_pci_memory_alias);
     memory_region_add_subregion(&s->bm, 0x80000000, &s->bm_ram_alias);
-    address_space_init(&s->bm_as, &s->bm, "raven-bm");
-    pci_setup_iommu(&s->pci_bus, &raven_iommu_ops, s);
 
     h->bus = &s->pci_bus;
 

-- 
2.51.0


