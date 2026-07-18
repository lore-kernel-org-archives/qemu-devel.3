Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E269C4451B
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jul 2026 22:13:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlDGz-0008Bp-4g; Sat, 18 Jul 2026 18:12:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=65292d44c=graf@amazon.de>)
 id 1wlDGv-00087L-HT; Sat, 18 Jul 2026 18:12:38 -0400
Received: from pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com
 ([44.246.1.125])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=65292d44c=graf@amazon.de>)
 id 1wlDGt-0006zK-O7; Sat, 18 Jul 2026 18:12:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1784412755; x=1815948755;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=xnm/On1xaTaJ9SUCBNScL0AKQTWPP8CHJWXOZZcV0wo=;
 b=XMjIkbxAGemAq2UtadtOQDcZiEBrJBgDJXv+yCJcG9i6soJUqzXb0efo
 VVvkxEvCNWP4g/XtHyxI+VZOYbDIj2ab3wWBIrT7ADkp+VOI5Z8cbiOtb
 W1NrvzU5vKg/QL50xOs8KJEgmA1H4JXesZz3a4MDakuueMc1xaBm4fDVh
 uA0lZgoUw7NYvUwmmDiVHsNxAolxTcV/DrWvd4wjzm2W6qvZ+qqclaVCN
 nsjQC220jq/I0lkxtK48qkvPc0zb3WDxV6QRvDJYQtQEU5ms04z+jcbMq
 u0vYOZ2a0jC46PXiNiMW+5rQ771Z9l+6r8CCucPtwdrtIuFwjHx/b6O0V Q==;
X-CSE-ConnectionGUID: SDxV6/DoRXS6Kf5vloFqZg==
X-CSE-MsgGUID: S22iSAVNST60ForJXfcsHg==
X-IronPort-AV: E=Sophos;i="6.25,171,1779148800"; d="scan'208";a="23928109"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
 by internal-pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2026 22:12:30 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.234:12881]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.11.151:2525]
 with esmtp (Farcaster)
 id 55d64459-7a11-438f-b674-932ab9137f8c; Sat, 18 Jul 2026 22:12:30 +0000 (UTC)
X-Farcaster-Flow-ID: 55d64459-7a11-438f-b674-932ab9137f8c
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 18 Jul 2026 22:12:29 +0000
Received: from ip-10-253-83-51.amazon.com (172.19.99.218) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 18 Jul 2026 22:12:20 +0000
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
Subject: [RFC PATCH v2 127/137] hw/arm/mps2: Parent the OR-IRQ gates under the
 machine
Date: Sat, 18 Jul 2026 21:36:42 +0000
Message-ID: <20260718213652.37673-128-graf@amazon.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260718213652.37673-1-graf@amazon.com>
References: <20260711223707.42139-1-graf@amazon.com>
 <20260718213652.37673-1-graf@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.19.99.218]
X-ClientProxiedBy: EX19D033UWC003.ant.amazon.com (10.13.139.217) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Received-SPF: pass client-ip=44.246.1.125;
 envelope-from=prvs=65292d44c=graf@amazon.de;
 helo=pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com
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

The mps2 board creates several TYPE_OR_IRQ gates for UART overflow,
per-UART tx/rx, and SPI interrupts.  Parent them under the machine
so they get canonical paths.  The 282/325 pair sit on
mutually-exclusive switch arms, so a single "uart-orgate" name is
sufficient; the loop-created gates use "[*]" auto-indexing.

AI-used-for: code (refactoring)
Signed-off-by: Alexander Graf <graf@amazon.com>
---
 hw/arm/mps2.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/hw/arm/mps2.c b/hw/arm/mps2.c
index 1dec4a5d4d..1032f47cb8 100644
--- a/hw/arm/mps2.c
+++ b/hw/arm/mps2.c
@@ -279,7 +279,7 @@ static void mps2_common_init(MachineState *machine)
         Object *orgate;
         DeviceState *orgate_dev;
 
-        orgate = object_new(TYPE_OR_IRQ);
+        orgate = object_new_child(OBJECT(mms), "uart-orgate", TYPE_OR_IRQ);
         object_property_set_int(orgate, "num-lines", 6, &error_fatal);
         qdev_realize(DEVICE(orgate), NULL, &error_fatal);
         orgate_dev = DEVICE(orgate);
@@ -322,7 +322,7 @@ static void mps2_common_init(MachineState *machine)
         Object *orgate;
         DeviceState *orgate_dev;
 
-        orgate = object_new(TYPE_OR_IRQ);
+        orgate = object_new_child(OBJECT(mms), "uart-orgate", TYPE_OR_IRQ);
         object_property_set_int(orgate, "num-lines", 10, &error_fatal);
         qdev_realize(DEVICE(orgate), NULL, &error_fatal);
         orgate_dev = DEVICE(orgate);
@@ -338,7 +338,8 @@ static void mps2_common_init(MachineState *machine)
             DeviceState *txrx_orgate_dev, *dev;
             SysBusDevice *s;
 
-            txrx_orgate = object_new(TYPE_OR_IRQ);
+            txrx_orgate = object_new_child(OBJECT(mms), "uart-txrx-orgate[*]",
+                                           TYPE_OR_IRQ);
             object_property_set_int(txrx_orgate, "num-lines", 2, &error_fatal);
             qdev_realize(DEVICE(txrx_orgate), NULL, &error_fatal);
             txrx_orgate_dev = DEVICE(txrx_orgate);
@@ -430,7 +431,7 @@ static void mps2_common_init(MachineState *machine)
         Object *orgate;
         int j;
 
-        orgate = object_new(TYPE_OR_IRQ);
+        orgate = object_new_child(OBJECT(mms), "spi-orgate[*]", TYPE_OR_IRQ);
         object_property_set_int(orgate, "num-lines", 2, &error_fatal);
         orgate_dev = DEVICE(orgate);
         qdev_realize(orgate_dev, NULL, &error_fatal);
-- 
2.47.1


