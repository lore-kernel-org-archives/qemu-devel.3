Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A589DC44501
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2026 23:09:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wigpS-0001tF-Ax; Sat, 11 Jul 2026 19:09:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=645f258d4=graf@amazon.de>)
 id 1wigpO-0001my-4d; Sat, 11 Jul 2026 19:09:46 -0400
Received: from pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com
 ([35.83.148.184])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=645f258d4=graf@amazon.de>)
 id 1wigpM-0004J1-EU; Sat, 11 Jul 2026 19:09:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1783811384; x=1815347384;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=x8e6PZxUhb790ARPbhW5JeHe4VOlr3birYehijCm6Kg=;
 b=YtqVAwxVkDyZdAjYLFeEuiyuuJljhej0uhW1cW6ss4s82hPtM3xRGudG
 rePEEuSyxqRqJrFPo2RU5/eTORh31cKRL9toJUzDqH+dhTFkbfAZ4DlMP
 b31t9fiHxETSn9rgGW9zQoPkbJedJ3rAIM6Ur1lKb6kOti6gMF5GKk45h
 yLMskrfkgein1hst2vKTXwaCOmFAbROYlvH5n2Rav8XdaN4F6QjftK3qy
 iA2FRvn4tHQxJdUZIEyz2CqMrYSawL1pqwN//UoXjyV5F8Y6igpd6h3qM
 f1QaGlMJP6g06UKLbtGohr/ENYDuFcSwQJY49q1QJvcXtOg3jfhHcTMb7 w==;
X-CSE-ConnectionGUID: 1tb6duz1TSOzpqyKN/esAw==
X-CSE-MsgGUID: YFqcqexnR9CUypRdueR7zg==
X-IronPort-AV: E=Sophos;i="6.25,154,1779148800"; d="scan'208";a="23287941"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
 by internal-pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2026 23:09:40 +0000
Received: from EX19MTAUWB001.ant.amazon.com [205.251.233.51:23993]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.42.69:2525]
 with esmtp (Farcaster)
 id 7ec8e06f-56ca-4e7f-b9b6-b85acefa29be; Sat, 11 Jul 2026 23:09:40 +0000 (UTC)
X-Farcaster-Flow-ID: 7ec8e06f-56ca-4e7f-b9b6-b85acefa29be
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 11 Jul 2026 23:09:40 +0000
Received: from ip-10-253-83-51.amazon.com (172.19.99.218) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 11 Jul 2026 23:09:31 +0000
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
Subject: [RFC PATCH 123/134] hw/s390x,
 hw/remote: Parent per-devfn IOMMU objects
Date: Sat, 11 Jul 2026 22:36:56 +0000
Message-ID: <20260711223707.42139-124-graf@amazon.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260711223707.42139-1-graf@amazon.com>
References: <20260711223707.42139-1-graf@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.19.99.218]
X-ClientProxiedBy: EX19D036UWC004.ant.amazon.com (10.13.139.205) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Received-SPF: pass client-ip=35.83.148.184;
 envelope-from=prvs=645f258d4=graf@amazon.de;
 helo=pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_LOW=-0.7,
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

Assisted-by: Kiro
Signed-off-by: Alexander Graf <graf@amazon.com>
---
 hw/remote/iommu.c       | 5 +++--
 hw/s390x/s390-pci-bus.c | 8 +++++++-
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/hw/remote/iommu.c b/hw/remote/iommu.c
index 3e0758a21e..09f79e805c 100644
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
 
diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index 4f0a8a787b..557ecbb977 100644
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
-- 
2.47.1


