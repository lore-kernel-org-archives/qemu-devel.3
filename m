Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 220D0C43458
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2026 23:04:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wigkM-0000Jq-IE; Sat, 11 Jul 2026 19:04:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=645f258d4=graf@amazon.de>)
 id 1wigkL-0000Ec-8o; Sat, 11 Jul 2026 19:04:33 -0400
Received: from pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com
 ([44.246.77.92])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=645f258d4=graf@amazon.de>)
 id 1wigkJ-0002rm-BW; Sat, 11 Jul 2026 19:04:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1783811071; x=1815347071;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=n8EvPM4JcXpYSayZRgeREEgwZhhcy95t1AHvCdmHV5k=;
 b=ppeGZFPhPUrC+/IXk1gsd29Hxi3rU67TEUXxv6lF0Rb5S/qN5pKM0t79
 +9nO1EX4+ayFz9akYUmPQ/GFyguxq2PZ4M42EEg3BWAf8xv41+c4VOtkl
 wXlyCeKqmO5ZsfHb+i03nrJ79fjbBFpu8I4DUNMo+lQrIUdDzBiAbqyyV
 GTdE3C8AJeslA8v6nYM3z9CWXzjoUfke8pbjZmBnDdM6Q2C6ATRzarBOE
 prY7VdZ/48QYY9f0gWGY4FbcpSDfZ8mzt7bn9ZH5IZP4oH62uzKOJ5ckX
 Y3hr/DdRa9vMzRuISru/F5HE/FCbTrfcZmVF2miySQ9q+Ro34Zxqs20yM A==;
X-CSE-ConnectionGUID: gGF/P07gQXO38gsa/uetTA==
X-CSE-MsgGUID: WPW6qZGbQ8CPqgEEH4HNBw==
X-IronPort-AV: E=Sophos;i="6.25,154,1779148800"; d="scan'208";a="23493364"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
 by internal-pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2026 23:04:27 +0000
Received: from EX19MTAUWA001.ant.amazon.com [205.251.233.236:11463]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.31.54:2525]
 with esmtp (Farcaster)
 id dba23c15-67d5-4a9c-a7ed-a62a6bafc7ff; Sat, 11 Jul 2026 23:04:27 +0000 (UTC)
X-Farcaster-Flow-ID: dba23c15-67d5-4a9c-a7ed-a62a6bafc7ff
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 11 Jul 2026 23:04:27 +0000
Received: from ip-10-253-83-51.amazon.com (172.19.99.218) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 11 Jul 2026 23:04:18 +0000
From: Alexander Graf <graf@amazon.com>
To: <qemu-devel@nongnu.org>
CC: <qemu-arm@nongnu.org>, <qemu-ppc@nongnu.org>, <qemu-riscv@nongnu.org>,
 <qemu-s390x@nongnu.org>, Song Gao <17746591750@163.com>, Aditya Gupta
 <adityag@linux.ibm.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, Farhan Ali
 <alifm@linux.ibm.com>, Alistair Francis <alistair.francis@wdc.com>, "Alistair
 Francis" <alistair@alistair23.me>, Antony Pavlov <antonynpavlov@gmail.com>,
 Markus Armbruster <armbru@redhat.com>, Artyom Tarasenko
 <atar4qemu@gmail.com>, BALATON Zoltan <balaton@eik.bme.hu>, Felipe Balbi
 <balbi@kernel.org>, Christian Borntraeger <borntraeger@linux.ibm.com>, "Brian
 Cain" <brian.cain@oss.qualcomm.com>, Hendrik Brueckner
 <brueckner@linux.ibm.com>, Chao Liu <chao.liu@processmission.com>, "Huacai
 Chen" <chenhuacai@kernel.org>, =?UTF-8?q?Cl=C3=A9ment=20Chigot?=
 <chigot@adacore.com>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Helge Deller <deller@gmx.de>, Dorjoy Chowdhury <dorjoychy111@gmail.com>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>, Alexandre Iooss
 <erdnaxe@crans.org>, Eric Farman <farman@linux.ibm.com>, Francisco Iglesias
 <francisco.iglesias@amd.com>, Gaurav Sharma <gaurav.sharma_7@nxp.com>,
 "Gautam Gala" <ggala@linux.ibm.com>, Harsh Prateek Bora
 <harshpb@linux.ibm.com>, =?UTF-8?q?Herv=C3=A9=20Poussineau?=
 <hpoussin@reactos.org>, Jan Kiszka <jan.kiszka@web.de>, Max Filippov
 <jcmvbkbc@gmail.com>, Joel Stanley <joel@jms.id.au>, Jared Rossi
 <jrossi@linux.ibm.com>, Tyrone Ting <kfting@nuvoton.com>, Frederic Konrad
 <konrad.frederic@yahoo.fr>, "Laurent Vivier" <laurent@vivier.eu>, Manos
 Pitsidianakis <manos.pitsidianakis@linaro.org>, Bibo Mao
 <maobibo@loongson.cn>, "Mark Cave-Ayland" <mark.cave-ayland@ilande.co.uk>,
 Glenn Miles <milesg@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 "Michael Rolnik" <mrolnik@gmail.com>, "Michael S . Tsirkin" <mst@redhat.com>, 
 "Niek Linnenbank" <nieklinnenbank@gmail.com>, Nicholas Piggin
 <npiggin@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, Halil Pasic
 <pasic@linux.ibm.com>, "Paolo Bonzini" <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@mailo.com>, "Pierrick Bouvier" <pierrick.bouvier@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>, Sai Pavan Boddu
 <sai.pavan.boddu@amd.com>, Samuel Tardieu <sam@rfc1149.net>, Bernhard Beschow
 <shentey@gmail.com>, Stafford Horne <shorne@gmail.com>, Sergio Lopez
 <slp@redhat.com>, "Subbaraya Sundeep" <sundeep.lkml@gmail.com>, Thomas Huth
 <th.huth+qemu@posteo.eu>, "Ran Wang" <wangran@bosc.ac.cn>, Hao Wu
 <wuhaotsh@google.com>, =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?=
 <berrange@redhat.com>
Subject: [RFC PATCH 104/134] hw/remote: Give memory regions an explicit owner
Date: Sat, 11 Jul 2026 22:36:37 +0000
Message-ID: <20260711223707.42139-105-graf@amazon.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260711223707.42139-1-graf@amazon.com>
References: <20260711223707.42139-1-graf@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.19.99.218]
X-ClientProxiedBy: EX19D043UWC001.ant.amazon.com (10.13.139.202) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Received-SPF: pass client-ip=44.246.77.92;
 envelope-from=prvs=645f258d4=graf@amazon.de;
 helo=pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001, T_SPF_PERMERROR=0.01,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

remote_machine_init() passes OBJECT(machine). remote_sysmem_reconfig()
runs in the multi-process remote and creates system-memory subregions
on behalf of the machine; use qdev_get_machine() as owner.
dma_register() in the vfio-user server creates DMA windows for a
VfuObject; use it as owner.

No functional change intended.

Assisted-by: Kiro
Signed-off-by: Alexander Graf <graf@amazon.com>
---
 hw/remote/machine.c       | 2 +-
 hw/remote/memory.c        | 3 ++-
 hw/remote/vfio-user-obj.c | 2 +-
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/hw/remote/machine.c b/hw/remote/machine.c
index e8e9cf259f..09154fa122 100644
--- a/hw/remote/machine.c
+++ b/hw/remote/machine.c
@@ -37,7 +37,7 @@ static void remote_machine_init(MachineState *machine)
     system_io = get_system_io();
 
     pci_memory = g_new(MemoryRegion, 1);
-    memory_region_init(pci_memory, NULL, "pci", UINT64_MAX);
+    memory_region_init(pci_memory, OBJECT(machine), "pci", UINT64_MAX);
 
     rem_host = REMOTE_PCIHOST(qdev_new(OBJECT(s), "remote-pcihost",
                                        TYPE_REMOTE_PCIHOST));
diff --git a/hw/remote/memory.c b/hw/remote/memory.c
index 8195aa5fb8..3f8fe54bac 100644
--- a/hw/remote/memory.c
+++ b/hw/remote/memory.c
@@ -12,6 +12,7 @@
 
 #include "hw/remote/memory.h"
 #include "qapi/error.h"
+#include "hw/core/qdev.h"
 
 static void remote_sysmem_reset(void)
 {
@@ -42,7 +43,7 @@ void remote_sysmem_reconfig(MPQemuMsg *msg, Error **errp)
     for (region = 0; region < msg->num_fds; region++, suffix++) {
         g_autofree char *name = g_strdup_printf("remote-mem-%u", suffix);
         subregion = g_new(MemoryRegion, 1);
-        memory_region_init_ram_from_fd(subregion, NULL,
+        memory_region_init_ram_from_fd(subregion, qdev_get_machine(),
                                        name, sysmem_info->sizes[region],
                                        RAM_SHARED, msg->fds[region],
                                        sysmem_info->offsets[region],
diff --git a/hw/remote/vfio-user-obj.c b/hw/remote/vfio-user-obj.c
index 87fa7b6572..685d4c2baf 100644
--- a/hw/remote/vfio-user-obj.c
+++ b/hw/remote/vfio-user-obj.c
@@ -324,7 +324,7 @@ static void dma_register(vfu_ctx_t *vfu_ctx, vfu_dma_info_t *info)
 
     subregion = g_new0(MemoryRegion, 1);
 
-    memory_region_init_ram_ptr(subregion, NULL, name,
+    memory_region_init_ram_ptr(subregion, OBJECT(o), name,
                                iov->iov_len, info->vaddr);
 
     dma_as = pci_device_iommu_address_space(o->pci_dev);
-- 
2.47.1


