Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FA57C4451B
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jul 2026 22:12:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlDGI-0006s1-9F; Sat, 18 Jul 2026 18:11:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=65292d44c=graf@amazon.de>)
 id 1wlDGG-0006e7-AU; Sat, 18 Jul 2026 18:11:56 -0400
Received: from pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com
 ([52.26.1.71])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=65292d44c=graf@amazon.de>)
 id 1wlDGD-0006tP-6L; Sat, 18 Jul 2026 18:11:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1784412713; x=1815948713;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=KueI85jxNEkbbLG6vVMUGWXIOodLg7ml4f6quy6N39c=;
 b=oloNN3dN+j/2yzTGxH5zn93ePCE/ii6lTy6QR5Qvlnz47IMOPx+VKYhW
 TEqCHd3Z9g1Dvrp60WUK9Mb4hmG2OYMlaCGMzFce/r0GfQTiEReXtfs/O
 D6UlZ/+PFSQUnpZKaXm3ugbgoBvUEl4coSTDNRfa/hKmprkOXyx+Hgjrp
 DMzyF0z2/9CMzQK1C5ihGlm0HIdw9EF+BrLDdma0o8i+oL8e1/jZ+9frA
 Gg7kWLxeCLF427Ts3NVK8IYJZBVk//nPgETnht47mAh4i8IDA5pWDQ85N
 aiNAzJ0R50neNPYDCBS5SQl3HEF7MAseVePExwCPeU2c4nKr5QU8jAgmv A==;
X-CSE-ConnectionGUID: BWY9ITVFT0Wm4GTo7tfUCg==
X-CSE-MsgGUID: vv75u5GOTSGpbipMjQyEcg==
X-IronPort-AV: E=Sophos;i="6.25,171,1779148800"; d="scan'208";a="23945205"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
 by internal-pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2026 22:11:49 +0000
Received: from EX19MTAUWC001.ant.amazon.com [205.251.233.105:9708]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.40.177:2525]
 with esmtp (Farcaster)
 id 803ee3f8-dad3-4d29-8cbc-350ef2785825; Sat, 18 Jul 2026 22:11:49 +0000 (UTC)
X-Farcaster-Flow-ID: 803ee3f8-dad3-4d29-8cbc-350ef2785825
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 18 Jul 2026 22:11:49 +0000
Received: from ip-10-253-83-51.amazon.com (172.19.99.218) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 18 Jul 2026 22:11:39 +0000
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
Subject: [RFC PATCH v2 125/137] hw/s390x,
 hw/remote: Parent per-devfn IOMMU objects
Date: Sat, 18 Jul 2026 21:36:40 +0000
Message-ID: <20260718213652.37673-126-graf@amazon.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260718213652.37673-1-graf@amazon.com>
References: <20260711223707.42139-1-graf@amazon.com>
 <20260718213652.37673-1-graf@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.19.99.218]
X-ClientProxiedBy: EX19D044UWB004.ant.amazon.com (10.13.139.134) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Received-SPF: pass client-ip=52.26.1.71;
 envelope-from=prvs=65292d44c=graf@amazon.de;
 helo=pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com
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

Give the per-devfn S390 PCI IOMMU object a canonical path under the
S390 PCI host state.  s390_pci_iommu_free() already calls
object_unparent(), which was previously a no-op; it now performs
the actual release.

For the multi-process remote IOMMU, replace the raw
object_new(TYPE_MEMORY_REGION) with a proper memory_region_init()
under the RemoteIommu object so the MR gets an owner like every
other MR in the tree.

AI-used-for: code (refactoring)
Signed-off-by: Alexander Graf <graf@amazon.com>
---
 hw/remote/iommu.c       | 7 ++++---
 hw/s390x/s390-pci-bus.c | 9 +++++++--
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/hw/remote/iommu.c b/hw/remote/iommu.c
index 3e0758a21e..52ee9765e6 100644
--- a/hw/remote/iommu.c
+++ b/hw/remote/iommu.c
@@ -52,8 +52,9 @@ static AddressSpace *remote_iommu_find_add_as(PCIBus *pci_bus,
     }
 
     if (!elem->mr) {
-        elem->mr = MEMORY_REGION(object_new(TYPE_MEMORY_REGION));
-        memory_region_set_size(elem->mr, UINT64_MAX);
+        g_autofree char *name = g_strdup_printf("mr-devfn-%02x", devfn);
+        elem->mr = g_new0(MemoryRegion, 1);
+        memory_region_init(elem->mr, OBJECT(iommu), name, UINT64_MAX);
         address_space_init(&elem->as, elem->mr, NULL);
     }
 
@@ -75,7 +76,7 @@ void remote_iommu_unplug_dev(PCIDevice *pci_dev)
 
     address_space_destroy(&elem->as);
 
-    object_unref(elem->mr);
+    object_unparent(OBJECT(elem->mr));
 
     elem->mr = NULL;
 }
diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index 4f0a8a787b..da8406cc4e 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -618,7 +618,13 @@ static S390PCIIOMMU *s390_pci_get_iommu(S390pciState *s, PCIBus *bus,
 
     iommu = table->iommu[PCI_SLOT(devfn)];
     if (!iommu) {
-        iommu = S390_PCI_IOMMU(object_new(TYPE_S390_PCI_IOMMU));
+        char *ch_name = g_strdup_printf("iommu[%02x:%02x.%01x]",
+                                        pci_bus_num(bus),
+                                        PCI_SLOT(devfn),
+                                        PCI_FUNC(devfn));
+        iommu = S390_PCI_IOMMU(object_new_child(OBJECT(s), ch_name,
+                                                TYPE_S390_PCI_IOMMU));
+        g_free(ch_name);
 
         char *mr_name = g_strdup_printf("iommu-root-%02x:%02x.%01x",
                                         pci_bus_num(bus),
@@ -798,7 +804,6 @@ static void s390_pci_iommu_free(S390pciState *s, PCIBus *bus, int32_t devfn)
     address_space_destroy(&iommu->as);
     object_unparent(OBJECT(&iommu->mr));
     object_unparent(OBJECT(iommu));
-    object_unref(OBJECT(iommu));
 }
 
 S390PCIGroup *s390_group_create(int id, int host_id)
-- 
2.47.1


