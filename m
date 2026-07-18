Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6364C4450A
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jul 2026 22:06:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlDB8-0002ET-8D; Sat, 18 Jul 2026 18:06:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=65292d44c=graf@amazon.de>)
 id 1wlDB4-0001ky-Li; Sat, 18 Jul 2026 18:06:34 -0400
Received: from pdx-out-005.esa.us-west-2.outbound.mail-perimeter.amazon.com
 ([52.13.214.179])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=65292d44c=graf@amazon.de>)
 id 1wlDB2-0006Fa-QV; Sat, 18 Jul 2026 18:06:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1784412392; x=1815948392;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=XlKYJHYIZUhyMDU2fWk1xdpYp67/NUuYdfIoCtufLrc=;
 b=el2ijtnHRM70MsjEoboAK+CQit86ez1ETNegz9beC+y5G+0pI7BW7u1h
 XxM9NG/6o5jsjXiJVYl7agumacdj5AQUkPNrwMKYhgbOyWzgOLOyuqfeu
 vfWoGl6R1SM0kFvpScjUViRGTEkhNA9JWbay2n+lbfJlFduW/G3FEtiF2
 iW/QchcSkagbpA3S6keNXQ7It9kAaFkPk+ot9pKMj6nAaAn9deFz2T2BN
 jLkYk1fmuXNX+j81ZWH8dB0F5/iyDwz+sSCp0BT5V3EH1PZwdnJo0dnhE
 0B0k4ilR0shg+bF1iy2Cc7E8lXCqytEPMkCG8xN2fyT+3mwOy5kzBJMRx w==;
X-CSE-ConnectionGUID: P2eaODHESdqpjVqeKVB4JQ==
X-CSE-MsgGUID: BuKzLw8bQZyLmomT7EkOWA==
X-IronPort-AV: E=Sophos;i="6.25,171,1779148800"; d="scan'208";a="23904486"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
 by internal-pdx-out-005.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2026 22:06:28 +0000
Received: from EX19MTAUWA001.ant.amazon.com [205.251.233.182:24708]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.48.250:2525]
 with esmtp (Farcaster)
 id 77fc81c3-d29e-4682-887e-b70683a9c011; Sat, 18 Jul 2026 22:06:28 +0000 (UTC)
X-Farcaster-Flow-ID: 77fc81c3-d29e-4682-887e-b70683a9c011
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 18 Jul 2026 22:06:28 +0000
Received: from ip-10-253-83-51.amazon.com (172.19.99.218) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 18 Jul 2026 22:06:18 +0000
From: Alexander Graf <graf@amazon.com>
To: <qemu-devel@nongnu.org>
CC: <qemu-arm@nongnu.org>, <qemu-ppc@nongnu.org>, <qemu-riscv@nongnu.org>,
 <qemu-s390x@nongnu.org>, Song Gao <17746591750@163.com>, Aditya Gupta
 <adityag@linux.ibm.com>, Alexey Kardashevskiy <aik@ozlabs.ru>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Farhan Ali
 <alifm@linux.ibm.com>, Alistair Francis <alistair.francis@wdc.com>, "Alistair
 Francis" <alistair@alistair23.me>, Antony Pavlov <antonynpavlov@gmail.com>,
 Markus Armbruster <armbru@redhat.com>, Artyom Tarasenko
 <atar4qemu@gmail.com>, BALATON Zoltan <balaton@eik.bme.hu>, Felipe Balbi
 <balbi@kernel.org>, =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?=
 <berrange@redhat.com>, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Hendrik Brueckner
 <brueckner@linux.ibm.com>, Chao Liu <chao.liu@processmission.com>, "Huacai
 Chen" <chenhuacai@kernel.org>, =?UTF-8?q?Cl=C3=A9ment=20Chigot?=
 <chigot@adacore.com>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Helge Deller <deller@gmx.de>, Dorjoy Chowdhury <dorjoychy111@gmail.com>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>, Alexandre Iooss
 <erdnaxe@crans.org>, Eric Farman <farman@linux.ibm.com>, Fabiano Rosas
 <farosas@suse.de>, Francisco Iglesias <francisco.iglesias@amd.com>, "Gaurav
 Sharma" <gaurav.sharma_7@nxp.com>, Gautam Gala <ggala@linux.ibm.com>, "Harsh
 Prateek Bora" <harshpb@linux.ibm.com>, =?UTF-8?q?Herv=C3=A9=20Poussineau?=
 <hpoussin@reactos.org>, Jan Kiszka <jan.kiszka@web.de>, Max Filippov
 <jcmvbkbc@gmail.com>, Joel Stanley <joel@jms.id.au>, Jared Rossi
 <jrossi@linux.ibm.com>, Tyrone Ting <kfting@nuvoton.com>, Frederic Konrad
 <konrad.frederic@yahoo.fr>, Laurent Vivier <laurent@vivier.eu>, "Manos
 Pitsidianakis" <manos.pitsidianakis@linaro.org>, Bibo Mao
 <maobibo@loongson.cn>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Glenn Miles <milesg@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Michael Rolnik <mrolnik@gmail.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, Nicholas Piggin
 <npiggin@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, Halil Pasic
 <pasic@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 "Pierrick Bouvier" <pierrick.bouvier@oss.qualcomm.com>, Richard Henderson
 <richard.henderson@linaro.org>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>,
 Samuel Tardieu <sam@rfc1149.net>, Bernhard Beschow <shentey@gmail.com>,
 Stafford Horne <shorne@gmail.com>, Sergio Lopez <slp@redhat.com>, "Subbaraya
 Sundeep" <sundeep.lkml@gmail.com>, Thomas Huth <th.huth+qemu@posteo.eu>, "Ran
 Wang" <wangran@bosc.ac.cn>, Hao Wu <wuhaotsh@google.com>
Subject: [RFC PATCH v2 105/137] hw/remote: Give memory regions an explicit
 owner
Date: Sat, 18 Jul 2026 21:36:20 +0000
Message-ID: <20260718213652.37673-106-graf@amazon.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260718213652.37673-1-graf@amazon.com>
References: <20260711223707.42139-1-graf@amazon.com>
 <20260718213652.37673-1-graf@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.19.99.218]
X-ClientProxiedBy: EX19D036UWB002.ant.amazon.com (10.13.139.139) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Received-SPF: pass client-ip=52.13.214.179;
 envelope-from=prvs=65292d44c=graf@amazon.de;
 helo=pdx-out-005.esa.us-west-2.outbound.mail-perimeter.amazon.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_LOW=-0.7,
 SPF_HELO_NONE=0.001, T_SPF_PERMERROR=0.01,
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

RAMBlock idstrs are unchanged: the owners added here are Machine
or SysBus devices, and memory_region_register_ram() maps both to
dev=NULL for qemu_ram_set_idstr().

AI-used-for: code (refactoring)
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


