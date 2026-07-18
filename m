Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3EE4C4450A
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jul 2026 21:46:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlCrh-0001z2-7h; Sat, 18 Jul 2026 17:46:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=65292d44c=graf@amazon.de>)
 id 1wlCrW-0001nx-UJ; Sat, 18 Jul 2026 17:46:23 -0400
Received: from pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com
 ([35.155.198.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=65292d44c=graf@amazon.de>)
 id 1wlCrU-0003Jx-Ru; Sat, 18 Jul 2026 17:46:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1784411180; x=1815947180;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=tcpsK52XFqezXpOlLJQb4X1gXgJtDN+MPTQXfo8z5K8=;
 b=gqSvN/lf9Uk/bVk+RCY3Z5+Rk0IGsXXlELwT0r3rXNtAs1ivoNV/5oSE
 OrptaiWpu4x9OB003I4FfNr+QB/nBtJLEuYGh88rVVchT6z4Rc9GohxVs
 xaqDlrCMAv0Bttyrzig0Ps54GrUN5vbz0kKTpGCwwdtcnOXmWT01h60Uw
 upbhOUnosaka5H5VxU/cuKMyhYXanOo2ITDSoc8y/XG8L6uwV62FH1WTL
 u+Pw8Kpt3vVhpfCyvjQcZFPp1oxGQjD/PQ2QDxETDVY9pOs9+Y6Ui1rdx
 gfObNpO6MOrYOK+aNLXQ9WVC5qBaiQHDVEkuiMKktO/GpuckNr01g8Npx g==;
X-CSE-ConnectionGUID: xmhSenv8T+e8GhNC+Km8sA==
X-CSE-MsgGUID: 1KgPUGwDQHiHnfOc9lmR3g==
X-IronPort-AV: E=Sophos;i="6.25,171,1779148800"; d="scan'208";a="23816486"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
 by internal-pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2026 21:46:17 +0000
Received: from EX19MTAUWB002.ant.amazon.com [205.251.233.48:29621]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.35.17:2525]
 with esmtp (Farcaster)
 id 845e8aec-94d3-454e-9bd4-98384038b8d8; Sat, 18 Jul 2026 21:46:16 +0000 (UTC)
X-Farcaster-Flow-ID: 845e8aec-94d3-454e-9bd4-98384038b8d8
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 18 Jul 2026 21:46:16 +0000
Received: from ip-10-253-83-51.amazon.com (172.19.99.218) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 18 Jul 2026 21:46:07 +0000
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
Subject: [RFC PATCH v2 033/137] hw/display: Give onboard devices a QOM parent
Date: Sat, 18 Jul 2026 21:35:08 +0000
Message-ID: <20260718213652.37673-34-graf@amazon.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260718213652.37673-1-graf@amazon.com>
References: <20260711223707.42139-1-graf@amazon.com>
 <20260718213652.37673-1-graf@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [172.19.99.218]
X-ClientProxiedBy: EX19D039UWB004.ant.amazon.com (10.13.138.57) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Received-SPF: pass client-ip=35.155.198.111;
 envelope-from=prvs=65292d44c=graf@amazon.de;
 helo=pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com
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

Convert the *_orphan() device-creation calls in hw/display to the new
parented API introduced earlier in this series, so every onboard
device gets a stable path in the composition tree instead of landing
in /machine/unattached with an unstable device[N] name.

The parent for each device is the object that owns its lifetime: the
machine for board-created devices, the containing device for
composite children.  Names follow existing QOM conventions.

Per-site rationale (reviewers: dispute the modeling here):

hw/display/sii9022.c:167 | i2c_slave_create_simple | OBJECT(dev) | "ddc" | DeviceClass.realize(); DDC slave owned by sii9022 device
hw/display/sm501.c:1913 | qdev_new | OBJECT(dev) | "ddc" | sm501_init() helper receives realizing DeviceState *dev; drop _and_unref
hw/display/xlnx_dp.c:1349 | qdev_new | obj | "dpcd" | instance_init(Object *obj); collapse existing add_child+unref, keep name
hw/display/xlnx_dp.c:1353 | qdev_new | obj | "edid" | instance_init(Object *obj); collapse existing add_child+unref, keep name

Link: https://lore.kernel.org/qemu-devel/87jyr3w9tc.fsf@pond.sub.org/
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
AI-used-for: code (refactoring)
Signed-off-by: Alexander Graf <graf@amazon.com>
---
 hw/display/sii9022.c |  2 +-
 hw/display/sm501.c   |  4 ++--
 hw/display/xlnx_dp.c | 14 +++-----------
 3 files changed, 6 insertions(+), 14 deletions(-)

diff --git a/hw/display/sii9022.c b/hw/display/sii9022.c
index 0bf49195d7..2accebf193 100644
--- a/hw/display/sii9022.c
+++ b/hw/display/sii9022.c
@@ -164,7 +164,7 @@ static void sii9022_realize(DeviceState *dev, Error **errp)
     I2CBus *bus;
 
     bus = I2C_BUS(qdev_get_parent_bus(dev));
-    i2c_slave_create_simple_orphan(bus, TYPE_I2CDDC, 0x50);
+    i2c_slave_create_simple(OBJECT(dev), "ddc", bus, TYPE_I2CDDC, 0x50);
 }
 
 static void sii9022_class_init(ObjectClass *klass, const void *data)
diff --git a/hw/display/sm501.c b/hw/display/sm501.c
index 1e47e6a32b..56075a0303 100644
--- a/hw/display/sm501.c
+++ b/hw/display/sm501.c
@@ -1956,9 +1956,9 @@ static void sm501_init(SM501State *s, DeviceState *dev,
     /* i2c */
     s->i2c_bus = i2c_init_bus(dev, "sm501.i2c");
     /* ddc */
-    I2CDDCState *ddc = I2CDDC(qdev_new_orphan(TYPE_I2CDDC));
+    I2CDDCState *ddc = I2CDDC(qdev_new(OBJECT(dev), "ddc", TYPE_I2CDDC));
     i2c_slave_set_address(I2C_SLAVE(ddc), 0x50);
-    qdev_realize_and_unref(DEVICE(ddc), BUS(s->i2c_bus), &error_abort);
+    qdev_realize(DEVICE(ddc), BUS(s->i2c_bus), &error_abort);
 
     /* mmio */
     memory_region_init(&s->mmio_region, OBJECT(dev), "sm501.mmio", MMIO_SIZE);
diff --git a/hw/display/xlnx_dp.c b/hw/display/xlnx_dp.c
index e8490d644d..5968466e79 100644
--- a/hw/display/xlnx_dp.c
+++ b/hw/display/xlnx_dp.c
@@ -1341,19 +1341,11 @@ static void xlnx_dp_init(Object *obj)
      */
     s->aux_bus = aux_bus_init(DEVICE(obj), "aux");
 
-    /*
-     * Initialize DPCD and EDID. Once we have added the objects as
-     * child properties of this device, we can drop the reference we
-     * hold to them, leaving the child-property as the only reference.
-     */
-    s->dpcd = DPCD(qdev_new_orphan("dpcd"));
-    object_property_add_child(OBJECT(s), "dpcd", OBJECT(s->dpcd));
-    object_unref(s->dpcd);
+    /* Initialize DPCD and EDID. */
+    s->dpcd = DPCD(qdev_new(obj, "dpcd", "dpcd"));
 
-    s->edid = I2CDDC(qdev_new_orphan("i2c-ddc"));
+    s->edid = I2CDDC(qdev_new(obj, "edid", "i2c-ddc"));
     i2c_slave_set_address(I2C_SLAVE(s->edid), 0x50);
-    object_property_add_child(OBJECT(s), "edid", OBJECT(s->edid));
-    object_unref(s->edid);
 
     fifo8_create(&s->rx_fifo, 16);
     fifo8_create(&s->tx_fifo, 16);
-- 
2.47.1


