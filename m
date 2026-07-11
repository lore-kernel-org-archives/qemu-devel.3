Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAFEBC43458
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2026 22:57:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wigci-0001L1-M2; Sat, 11 Jul 2026 18:56:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=645f258d4=graf@amazon.de>)
 id 1wigch-0001Jj-Ah; Sat, 11 Jul 2026 18:56:39 -0400
Received: from pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com
 ([35.83.148.184])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=645f258d4=graf@amazon.de>)
 id 1wigcf-00019T-Fe; Sat, 11 Jul 2026 18:56:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1783810597; x=1815346597;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=E9dRs0FfS2zHvxRHxP6oqDuGETedFCsJ5GMIpWF1/Fw=;
 b=Usr6BjO6opDSrasA42RNCOgl2JZNhrUhhTRY8ACv1xp9ca2zMjVRk4BI
 gCVsu2vT6w5HjD/4IyNg3aVQk6YCtP5xzKW8mOyGadc41Qw6+glTMRLet
 ADTYfqOfJ99GZ7kDQ4oiVlWsH4JMd9N81SQ/5U2Sok1L5Ou0TKr66nuym
 xh4l6eOgqrlEfvuxWlK5+/w4H45WUCvwYz2vT2ZPurIo1eYP4o6r1GsSs
 P8wVxmZSXjLsp+q8onxT12rF6I5Uksox8QsMGtBcr6qxItLcXbCRmm1L3
 75w9lvmpn9Ls1RUtbgDGnXkFul0824AB+pq+tPIkTatnDGb4vMLWDgKVs Q==;
X-CSE-ConnectionGUID: zD9FUu7zR3Ov7S2RzixzMQ==
X-CSE-MsgGUID: E09Toe5xTimzPC48FDhyqA==
X-IronPort-AV: E=Sophos;i="6.25,154,1779148800"; d="scan'208";a="23287747"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
 by internal-pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2026 22:56:33 +0000
Received: from EX19MTAUWC001.ant.amazon.com [205.251.233.53:2093]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.31.54:2525]
 with esmtp (Farcaster)
 id 78730497-ad64-435f-a383-db7843ba4d0c; Sat, 11 Jul 2026 22:56:33 +0000 (UTC)
X-Farcaster-Flow-ID: 78730497-ad64-435f-a383-db7843ba4d0c
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 11 Jul 2026 22:56:33 +0000
Received: from ip-10-253-83-51.amazon.com (172.19.99.218) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 11 Jul 2026 22:56:24 +0000
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
Subject: [RFC PATCH 074/134] hw/i386/pc: Give pcspk a QOM parent
Date: Sat, 11 Jul 2026 22:36:07 +0000
Message-ID: <20260711223707.42139-75-graf@amazon.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260711223707.42139-1-graf@amazon.com>
References: <20260711223707.42139-1-graf@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.19.99.218]
X-ClientProxiedBy: EX19D043UWA001.ant.amazon.com (10.13.139.45) To
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

pcspk was created in pc_machine_initfn() as an orphan and manually
unref'd in pc_machine_finalize() when the machine was never realized
(e.g. -M pc,help).  Making it a child<> of the machine at creation
time lets the QOM property teardown in object_property_del_all()
handle that lifecycle for free, so pc_machine_finalize() and its
open-coded refcount juggling can go.

The realize path switches from isa_realize_and_unref() to plain
qdev_realize() because the reference is now held by the parent's
child<> property, not the caller.

Assisted-by: Kiro
Signed-off-by: Alexander Graf <graf@amazon.com>
---
 hw/i386/pc.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 0c89310ab7..a00d53b582 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1128,7 +1128,7 @@ void pc_basic_device_init(struct PCMachineState *pcms,
         }
         object_property_set_link(OBJECT(pcms->pcspk), "pit",
                                  OBJECT(pit), &error_fatal);
-        isa_realize_and_unref(pcms->pcspk, isa_bus, &error_fatal);
+        qdev_realize(DEVICE(pcms->pcspk), BUS(isa_bus), &error_fatal);
     }
 
     if (pcms->vmport == ON_OFF_AUTO_AUTO) {
@@ -1640,7 +1640,7 @@ static void pc_machine_initfn(Object *obj)
     pcms->default_bus_bypass_iommu = false;
 
     pc_system_flash_create(pcms);
-    pcms->pcspk = isa_new_orphan(TYPE_PC_SPEAKER);
+    pcms->pcspk = isa_new(obj, "pcspk", TYPE_PC_SPEAKER);
     object_property_add_alias(OBJECT(pcms), "pcspk-audiodev",
                               OBJECT(pcms->pcspk), "audiodev");
     if (pcmc->pci_enabled) {
@@ -1648,15 +1648,6 @@ static void pc_machine_initfn(Object *obj)
     }
 }
 
-static void pc_machine_finalize(Object *obj)
-{
-    PCMachineState *pcms = PC_MACHINE(obj);
-
-    if (pcms->pcspk && !qdev_is_realized(DEVICE(pcms->pcspk))) {
-        object_unref(OBJECT(pcms->pcspk));
-    }
-}
-
 static void pc_machine_reset(MachineState *machine, ResetType type)
 {
     CPUState *cs;
@@ -1795,7 +1786,6 @@ static const TypeInfo pc_machine_info = {
     .abstract = true,
     .instance_size = sizeof(PCMachineState),
     .instance_init = pc_machine_initfn,
-    .instance_finalize = pc_machine_finalize,
     .class_size = sizeof(PCMachineClass),
     .class_init = pc_machine_class_init,
     .interfaces = (const InterfaceInfo[]) {
-- 
2.47.1


