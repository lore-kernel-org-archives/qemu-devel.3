Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8BD0C44501
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2026 22:58:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wigeE-0004Hy-5W; Sat, 11 Jul 2026 18:58:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=645f258d4=graf@amazon.de>)
 id 1wigeD-0004Cu-8r; Sat, 11 Jul 2026 18:58:13 -0400
Received: from pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com
 ([44.245.243.92])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=645f258d4=graf@amazon.de>)
 id 1wigeB-0001QT-CD; Sat, 11 Jul 2026 18:58:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1783810691; x=1815346691;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=zNqLOx2x0I9gZElFzToX/WDwD+3MyIg002yqWRyyMKE=;
 b=DQyuHtcIPwrLO5qk8M+VeVMXjC2ALmM4CPp9lpUAxrXw6igQCWAjQgfn
 jTM1291dPJcYUVWi+m3Mq+UIuBmOomqI4rc8zrJUDGVkcTXPMKKBBxkNy
 Gyj5BdQ+Nt/8N8BNo5Ngfm8v/T+WTiWVf+DYFCIwEMNc60jP4B01nyUZ1
 jdqL/iaIqYMjU/JhIiPiRebWr8CCNyQClckGppWKZ9C2woIVZ41HGX33Z
 iNL/QiFbNJsX4rJPUoqmVhCHI7vxCaj/xTr2gtLigYRU5OJzOnP2mtfD5
 fvKOpBPBoECn7baJGJVQDRVdVYFfRSabBC/gwf8idzV6sNz19YlVUT/YU w==;
X-CSE-ConnectionGUID: OUYYIaILTuSOvJTRPR+sIg==
X-CSE-MsgGUID: VekgXWuRSZ6Ypbmk+wdovQ==
X-IronPort-AV: E=Sophos;i="6.25,154,1779148800"; d="scan'208";a="22997667"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
 by internal-pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2026 22:58:08 +0000
Received: from EX19MTAUWC001.ant.amazon.com [205.251.233.53:8221]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.31.54:2525]
 with esmtp (Farcaster)
 id 4e9f9928-008a-42bb-b64d-d988d99267b3; Sat, 11 Jul 2026 22:58:08 +0000 (UTC)
X-Farcaster-Flow-ID: 4e9f9928-008a-42bb-b64d-d988d99267b3
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 11 Jul 2026 22:58:08 +0000
Received: from ip-10-253-83-51.amazon.com (172.19.99.218) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 11 Jul 2026 22:57:59 +0000
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
Subject: [RFC PATCH 080/134] hw/nitro: Give the vsock bridge a QOM parent
Date: Sat, 11 Jul 2026 22:36:13 +0000
Message-ID: <20260711223707.42139-81-graf@amazon.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260711223707.42139-1-graf@amazon.com>
References: <20260711223707.42139-1-graf@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.19.99.218]
X-ClientProxiedBy: EX19D036UWC003.ant.amazon.com (10.13.139.214) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Received-SPF: pass client-ip=44.245.243.92;
 envelope-from=prvs=645f258d4=graf@amazon.de;
 helo=pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com
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

nitro_vsock_bridge_create() was using qdev_set_id() to slot the
bridge under /machine/peripheral.  The bridge is a board-owned
singleton created from nitro_machine_init(), so make it a plain
child of the machine and drop the qdev_set_id() indirection.

The heartbeat device that hangs off the bridge is already a child<>
of it, so the composition tree becomes:

  /machine/nitro-vsock (nitro-vsock-bridge)
  /machine/nitro-vsock/heartbeat (nitro-heartbeat)

Assisted-by: Kiro
Signed-off-by: Alexander Graf <graf@amazon.com>
---
 hw/nitro/machine.c                 | 2 +-
 hw/nitro/nitro-vsock-bus.c         | 9 ++++-----
 include/hw/nitro/nitro-vsock-bus.h | 2 +-
 3 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/hw/nitro/machine.c b/hw/nitro/machine.c
index 6b61de911f..e522eae5ba 100644
--- a/hw/nitro/machine.c
+++ b/hw/nitro/machine.c
@@ -194,7 +194,7 @@ static void nitro_machine_init(MachineState *machine)
                         MEMTXATTRS_UNSPECIFIED, eif_data, eif_size);
 
     if (defaults_enabled()) {
-        NitroVsockBridge *bridge = nitro_vsock_bridge_create();
+        NitroVsockBridge *bridge = nitro_vsock_bridge_create(OBJECT(machine));
         DeviceState *dev;
 
         /* Nitro Enclaves require a heartbeat device. Provide one. */
diff --git a/hw/nitro/nitro-vsock-bus.c b/hw/nitro/nitro-vsock-bus.c
index f7540eaa54..2c4b66931f 100644
--- a/hw/nitro/nitro-vsock-bus.c
+++ b/hw/nitro/nitro-vsock-bus.c
@@ -20,7 +20,6 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "monitor/qdev.h"
 #include "hw/core/sysbus.h"
 #include "hw/nitro/nitro-vsock-bus.h"
 
@@ -46,12 +45,12 @@ void nitro_vsock_bridge_start_enclave(NitroVsockBridge *bridge,
     }
 }
 
-NitroVsockBridge *nitro_vsock_bridge_create(void)
+NitroVsockBridge *nitro_vsock_bridge_create(Object *parent)
 {
-    DeviceState *dev = qdev_new_orphan(TYPE_NITRO_VSOCK_BRIDGE);
+    DeviceState *dev = qdev_new(parent, "nitro-vsock",
+                                TYPE_NITRO_VSOCK_BRIDGE);
 
-    qdev_set_id(dev, g_strdup("nitro-vsock"), &error_fatal);
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+    sysbus_realize(SYS_BUS_DEVICE(dev), &error_fatal);
 
     return NITRO_VSOCK_BRIDGE(dev);
 }
diff --git a/include/hw/nitro/nitro-vsock-bus.h b/include/hw/nitro/nitro-vsock-bus.h
index 064260aa41..36f4dde78f 100644
--- a/include/hw/nitro/nitro-vsock-bus.h
+++ b/include/hw/nitro/nitro-vsock-bus.h
@@ -50,7 +50,7 @@ struct NitroVsockDeviceClass {
 /*
  * Machine helper to create the Nitro vsock bridge sysbus device.
  */
-NitroVsockBridge *nitro_vsock_bridge_create(void);
+NitroVsockBridge *nitro_vsock_bridge_create(Object *parent);
 
 /*
  * Find the Nitro vsock bridge on the sysbus.
-- 
2.47.1


