Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85229C4451B
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jul 2026 21:47:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlCrs-0002Xl-C3; Sat, 18 Jul 2026 17:46:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=65292d44c=graf@amazon.de>)
 id 1wlCrq-0002LV-HN; Sat, 18 Jul 2026 17:46:42 -0400
Received: from pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com
 ([44.245.243.92])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=65292d44c=graf@amazon.de>)
 id 1wlCro-0003LO-IG; Sat, 18 Jul 2026 17:46:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1784411200; x=1815947200;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ylzGdL2hCAzHlWQm4NhQvPDDp5LBcQLJWN3rDbxPs98=;
 b=d3igyu/kj82BSjmpDfY4yhuRKAYo8H6or1kjqMw8qOnV4tARJ1QlGuT/
 SsP9OeFLbU3sIDWf2D3KVmV8IfQRv/RGwDLONHr2j6qQBGZUNRfU6wS8V
 Dsw/SiAAIIhcOO8j/hDaFOCju87TviPwNJriXhJbGO2VfEoS6kO92rjSz
 ed1JzDpsKM0b3TLRIqc8IgKcOpRmP4fbKHJAMjO3oP9xnvcCIKASg9gPw
 KBZoYiI24rEVBnjsL+Lxi3b9AIqmpHP8P+Q3nOaeJXDvSQwfTruarAypg
 haYxgdHokY98vSb4SyDrErYnc1KwUnUGwKBTZQVE83JgjTiXhhudcybhg Q==;
X-CSE-ConnectionGUID: 8qZNF+teT8SVS253cRJK3w==
X-CSE-MsgGUID: LnLpdT4HQ/+orsKmll1oXg==
X-IronPort-AV: E=Sophos;i="6.25,171,1779148800"; d="scan'208";a="23422773"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
 by internal-pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2026 21:46:36 +0000
Received: from EX19MTAUWB001.ant.amazon.com [205.251.233.104:21762]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.0.115:2525]
 with esmtp (Farcaster)
 id f2ddba76-9b18-4e75-9fb9-f9620ae3d41c; Sat, 18 Jul 2026 21:46:35 +0000 (UTC)
X-Farcaster-Flow-ID: f2ddba76-9b18-4e75-9fb9-f9620ae3d41c
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 18 Jul 2026 21:46:35 +0000
Received: from ip-10-253-83-51.amazon.com (172.19.99.218) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 18 Jul 2026 21:46:26 +0000
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
Subject: [RFC PATCH v2 035/137] hw/dma: Give onboard devices a QOM parent
Date: Sat, 18 Jul 2026 21:35:10 +0000
Message-ID: <20260718213652.37673-36-graf@amazon.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260718213652.37673-1-graf@amazon.com>
References: <20260711223707.42139-1-graf@amazon.com>
 <20260718213652.37673-1-graf@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.19.99.218]
X-ClientProxiedBy: EX19D039UWB004.ant.amazon.com (10.13.138.57) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Received-SPF: pass client-ip=44.245.243.92;
 envelope-from=prvs=65292d44c=graf@amazon.de;
 helo=pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com
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

Convert the *_orphan() device-creation calls in hw/dma to the new
parented API introduced earlier in this series, so every onboard
device gets a stable path in the composition tree instead of landing
in /machine/unattached with an unstable device[N] name.

The parent for each device is the object that owns its lifetime: the
machine for board-created devices, the containing device for
composite children.  Names follow existing QOM conventions.

Per-site rationale (reviewers: dispute the modeling here):

hw/dma/i8257.c:654 | isa_new | parent | "dma[*]" | helper already receives Object *parent; collapse existing add_child, keep name; drop _and_unref
hw/dma/i8257.c:663 | isa_new | parent | "dma[*]" | helper already receives Object *parent; collapse existing add_child, keep name; drop _and_unref
hw/dma/rc4030.c:750 | qdev_new | parent | "rc4030" | thread Object *parent from single caller mips_jazz_init(machine); update header + caller; drop _and_unref

Link: https://lore.kernel.org/qemu-devel/87jyr3w9tc.fsf@pond.sub.org/
AI-used-for: code (refactoring)
Signed-off-by: Alexander Graf <graf@amazon.com>
---
 hw/dma/i8257.c         | 10 ++++------
 hw/dma/rc4030.c        |  7 ++++---
 hw/mips/jazz.c         |  2 +-
 include/hw/mips/mips.h |  3 ++-
 4 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/hw/dma/i8257.c b/hw/dma/i8257.c
index d1ab17b80d..735d7ca9a7 100644
--- a/hw/dma/i8257.c
+++ b/hw/dma/i8257.c
@@ -651,23 +651,21 @@ void i8257_dma_init(Object *parent, ISABus *bus, bool high_page_enable)
     ISADevice *isa1, *isa2;
     DeviceState *d;
 
-    isa1 = isa_new_orphan(TYPE_I8257);
-    object_property_add_child(parent, "dma[*]", OBJECT(isa1));
+    isa1 = isa_new(parent, "dma[*]", TYPE_I8257);
     d = DEVICE(isa1);
     qdev_prop_set_int32(d, "base", 0x00);
     qdev_prop_set_int32(d, "page-base", 0x80);
     qdev_prop_set_int32(d, "pageh-base", high_page_enable ? 0x480 : -1);
     qdev_prop_set_int32(d, "dshift", 0);
-    isa_realize_and_unref(isa1, bus, &error_fatal);
+    qdev_realize(d, BUS(bus), &error_fatal);
 
-    isa2 = isa_new_orphan(TYPE_I8257);
-    object_property_add_child(parent, "dma[*]", OBJECT(isa2));
+    isa2 = isa_new(parent, "dma[*]", TYPE_I8257);
     d = DEVICE(isa2);
     qdev_prop_set_int32(d, "base", 0xc0);
     qdev_prop_set_int32(d, "page-base", 0x88);
     qdev_prop_set_int32(d, "pageh-base", high_page_enable ? 0x488 : -1);
     qdev_prop_set_int32(d, "dshift", 1);
-    isa_realize_and_unref(isa2, bus, &error_fatal);
+    qdev_realize(d, BUS(bus), &error_fatal);
 
     isa_bus_dma(bus, ISADMA(isa1), ISADMA(isa2));
 }
diff --git a/hw/dma/rc4030.c b/hw/dma/rc4030.c
index ab8aaf7da4..800cdfb42d 100644
--- a/hw/dma/rc4030.c
+++ b/hw/dma/rc4030.c
@@ -743,12 +743,13 @@ static void rc4030_register_types(void)
 
 type_init(rc4030_register_types)
 
-DeviceState *rc4030_init(rc4030_dma **dmas, IOMMUMemoryRegion **dma_mr)
+DeviceState *rc4030_init(Object *parent, rc4030_dma **dmas,
+                         IOMMUMemoryRegion **dma_mr)
 {
     DeviceState *dev;
 
-    dev = qdev_new_orphan(TYPE_RC4030);
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+    dev = qdev_new(parent, "rc4030", TYPE_RC4030);
+    sysbus_realize(SYS_BUS_DEVICE(dev), &error_fatal);
 
     *dmas = rc4030_allocate_dmas(dev, 4);
     *dma_mr = &RC4030(dev)->dma_mr;
diff --git a/hw/mips/jazz.c b/hw/mips/jazz.c
index 5e34a6582d..62f2350d36 100644
--- a/hw/mips/jazz.c
+++ b/hw/mips/jazz.c
@@ -261,7 +261,7 @@ static void mips_jazz_init(MachineState *machine,
     cpu_mips_clock_init(cpu);
 
     /* Chipset */
-    rc4030 = rc4030_init(&dmas, &rc4030_dma_mr);
+    rc4030 = rc4030_init(OBJECT(machine), &dmas, &rc4030_dma_mr);
     sysbus = SYS_BUS_DEVICE(rc4030);
     sysbus_connect_irq(sysbus, 0, env->irq[6]);
     sysbus_connect_irq(sysbus, 1, env->irq[3]);
diff --git a/include/hw/mips/mips.h b/include/hw/mips/mips.h
index cd0ccb4e5d..7fa32eab38 100644
--- a/include/hw/mips/mips.h
+++ b/include/hw/mips/mips.h
@@ -17,6 +17,7 @@ typedef struct rc4030DMAState *rc4030_dma;
 void rc4030_dma_read(void *dma, uint8_t *buf, int len);
 void rc4030_dma_write(void *dma, uint8_t *buf, int len);
 
-DeviceState *rc4030_init(rc4030_dma **dmas, IOMMUMemoryRegion **dma_mr);
+DeviceState *rc4030_init(Object *parent, rc4030_dma **dmas,
+                         IOMMUMemoryRegion **dma_mr);
 
 #endif
-- 
2.47.1


