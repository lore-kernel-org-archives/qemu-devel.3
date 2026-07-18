Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98252C44521
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jul 2026 21:59:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlD45-0004Sl-6v; Sat, 18 Jul 2026 17:59:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=65292d44c=graf@amazon.de>)
 id 1wlD44-0004O3-3C; Sat, 18 Jul 2026 17:59:20 -0400
Received: from pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com
 ([44.246.77.92])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=65292d44c=graf@amazon.de>)
 id 1wlD42-0004pe-8a; Sat, 18 Jul 2026 17:59:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1784411958; x=1815947958;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=k3WIk/EB2Iz3AbpRf9OhbfBhFNMJVyqGyAvG9AyoT9o=;
 b=R1UU/e+4d1/kl5M8usm3jSqkFuLgYZEiTEg4fdUjyKnsmgDnxnfyPIju
 iMm2iLKqcTFnJVBl0TnD79jJ2EEJWKlsUXK3OxlC6J+UiNjcgV/ak2/l/
 gTz8UbJxWYqksn9J+Bkuqugp6Up4s/NXSxvJy3brMciZf4WY/7cC3UezI
 vmMiDy9FbKw2knpVIxQjzAkkP+4jVZ7+B/at6/2tceRJI4Yfe7W0WAvUr
 I/eAUir/tz5sAlfWozM3jOgVff3iepXTsl5hxei2sWcS7co0LASUucHne
 1BcHcleOFSrNq9jmjJ7uIuN2FfOTNj0H8zZAO3prBkA5uCG37iHTT7Mvg A==;
X-CSE-ConnectionGUID: E5/s2yI7QNC8T74z2DXnzA==
X-CSE-MsgGUID: jObtm9bARuqLm+SJB9jbMQ==
X-IronPort-AV: E=Sophos;i="6.25,171,1779148800"; d="scan'208";a="23917582"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
 by internal-pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2026 21:59:14 +0000
Received: from EX19MTAUWA001.ant.amazon.com [205.251.233.182:2106]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.29.147:2525]
 with esmtp (Farcaster)
 id 23c42ef8-ba74-4760-948c-f1bcd52317a0; Sat, 18 Jul 2026 21:59:14 +0000 (UTC)
X-Farcaster-Flow-ID: 23c42ef8-ba74-4760-948c-f1bcd52317a0
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 18 Jul 2026 21:59:14 +0000
Received: from ip-10-253-83-51.amazon.com (172.19.99.218) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 18 Jul 2026 21:59:04 +0000
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
Subject: [RFC PATCH v2 080/137] hw/xen: Give xenstore-driven backend devices a
 QOM parent
Date: Sat, 18 Jul 2026 21:35:55 +0000
Message-ID: <20260718213652.37673-81-graf@amazon.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260718213652.37673-1-graf@amazon.com>
References: <20260711223707.42139-1-graf@amazon.com>
 <20260718213652.37673-1-graf@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.19.99.218]
X-ClientProxiedBy: EX19D043UWA001.ant.amazon.com (10.13.139.45) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Received-SPF: pass client-ip=44.246.77.92;
 envelope-from=prvs=65292d44c=graf@amazon.de;
 helo=pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com
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

The XenBackendInfo .create callbacks (vif, console, vbd) create a
XenDevice in response to xenstore hotplug events.  The lifetime
owner is the xen-bridge device that hosts the XenBus, so parent
each device there.  The failure paths already call object_unparent()
so nothing else changes; the reference previously dropped by
qdev_realize_and_unref() is now the parent's child<> property.

AI-used-for: code (refactoring)
Signed-off-by: Alexander Graf <graf@amazon.com>
---
 hw/block/xen-block.c  | 5 +++--
 hw/char/xen_console.c | 5 +++--
 hw/net/xen_nic.c      | 5 +++--
 3 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/hw/block/xen-block.c b/hw/block/xen-block.c
index 9dd69faa02..46d94a9a95 100644
--- a/hw/block/xen-block.c
+++ b/hw/block/xen-block.c
@@ -1074,7 +1074,8 @@ static void xen_block_device_create(XenBackendInstance *backend,
         goto fail;
     }
 
-    xendev = XEN_DEVICE(qdev_new_orphan(type));
+    xendev = XEN_DEVICE(qdev_new(OBJECT(BUS(xenbus)->parent), "vbd[*]",
+                                 type));
     blockdev = XEN_BLOCK_DEVICE(xendev);
 
     if (!object_property_set_str(OBJECT(xendev), "vdev", vdev,
@@ -1099,7 +1100,7 @@ static void xen_block_device_create(XenBackendInstance *backend,
     blockdev->iothread = iothread;
     blockdev->drive = drive;
 
-    if (!qdev_realize_and_unref(DEVICE(xendev), BUS(xenbus), errp)) {
+    if (!qdev_realize(DEVICE(xendev), BUS(xenbus), errp)) {
         error_prepend(errp, "realization of device %s failed: ", type);
         goto fail;
     }
diff --git a/hw/char/xen_console.c b/hw/char/xen_console.c
index cd440b82f4..40449b34e8 100644
--- a/hw/char/xen_console.c
+++ b/hw/char/xen_console.c
@@ -562,7 +562,8 @@ static void xen_console_device_create(XenBackendInstance *backend,
         goto fail;
     }
 
-    xendev = XEN_DEVICE(qdev_new_orphan(TYPE_XEN_CONSOLE_DEVICE));
+    xendev = XEN_DEVICE(qdev_new(OBJECT(BUS(xenbus)->parent), "console[*]",
+                                 TYPE_XEN_CONSOLE_DEVICE));
     con = XEN_CONSOLE_DEVICE(xendev);
 
     con->dev = number;
@@ -610,7 +611,7 @@ static void xen_console_device_create(XenBackendInstance *backend,
         goto fail;
     }
 
-    if (qdev_realize_and_unref(DEVICE(xendev), BUS(xenbus), errp)) {
+    if (qdev_realize(DEVICE(xendev), BUS(xenbus), errp)) {
         xen_backend_set_device(backend, xendev);
         goto done;
     }
diff --git a/hw/net/xen_nic.c b/hw/net/xen_nic.c
index 212281aac7..ff748ae070 100644
--- a/hw/net/xen_nic.c
+++ b/hw/net/xen_nic.c
@@ -619,13 +619,14 @@ static void xen_net_device_create(XenBackendInstance *backend,
         goto fail;
     }
 
-    xendev = XEN_DEVICE(qdev_new_orphan(TYPE_XEN_NET_DEVICE));
+    xendev = XEN_DEVICE(qdev_new(OBJECT(BUS(xenbus)->parent), "vif[*]",
+                                 TYPE_XEN_NET_DEVICE));
     net = XEN_NET_DEVICE(xendev);
 
     net->dev = number;
     memcpy(&net->conf.macaddr, &mac, sizeof(mac));
 
-    if (qdev_realize_and_unref(DEVICE(xendev), BUS(xenbus), errp)) {
+    if (qdev_realize(DEVICE(xendev), BUS(xenbus), errp)) {
         xen_backend_set_device(backend, xendev);
         return;
     }
-- 
2.47.1


