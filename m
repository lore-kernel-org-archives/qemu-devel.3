Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B63AFC43458
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2026 23:00:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiggI-0000ON-5X; Sat, 11 Jul 2026 19:00:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=645f258d4=graf@amazon.de>)
 id 1wiggF-0000CN-Ec; Sat, 11 Jul 2026 19:00:19 -0400
Received: from pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com
 ([44.246.68.102])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=645f258d4=graf@amazon.de>)
 id 1wiggD-0001oJ-Fr; Sat, 11 Jul 2026 19:00:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1783810817; x=1815346817;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=W3qF5JrNQpKUcgE6pM9Of95+SxOs8DVridsvlNgyJYI=;
 b=Vxl9Du87BQmo4IuaPDQn1LMjMkEUwsUV+8gsknDZva3KC8MYC4fHGC4G
 B1RfuJJwWGJ5s3crnXooaBVe+CWmXg9AePvl4OqgA7VQuo5+ZZZcgP5Om
 icPzYVHcfhKHTF9pNeSbVqORwQ600ztIIMix72qSELHF4GBoN2ZDxaim3
 eC01bgtrVajIuH95FMWigRq8A1JAcEEytf038uDCLd/NaQlQIqCfEcpQa
 x5hHSeB5K9WqDcL8tRPAACnIV6iQo9iCLFky7nKzgUfvo3ROD4b4DZteW
 MBjeIqfBJAT5urZGCxQwWY5w3mGpMfzjublIt+CInJl3LQlOAure2In6t A==;
X-CSE-ConnectionGUID: QzFsJrqUSLWjr06QmON4AQ==
X-CSE-MsgGUID: 442XJ18yTGONHpmNgQ/DAw==
X-IronPort-AV: E=Sophos;i="6.25,154,1779148800"; d="scan'208";a="23517318"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
 by internal-pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2026 23:00:13 +0000
Received: from EX19MTAUWC001.ant.amazon.com [205.251.233.53:1044]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.26.212:2525]
 with esmtp (Farcaster)
 id 6cf9bf00-1672-48cd-aacc-9ff9a64fc7f2; Sat, 11 Jul 2026 23:00:12 +0000 (UTC)
X-Farcaster-Flow-ID: 6cf9bf00-1672-48cd-aacc-9ff9a64fc7f2
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 11 Jul 2026 23:00:12 +0000
Received: from ip-10-253-83-51.amazon.com (172.19.99.218) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 11 Jul 2026 23:00:04 +0000
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
Subject: [RFC PATCH 087/134] sysbus: Remove *_orphan() creator variants
Date: Sat, 11 Jul 2026 22:36:20 +0000
Message-ID: <20260711223707.42139-88-graf@amazon.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260711223707.42139-1-graf@amazon.com>
References: <20260711223707.42139-1-graf@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.19.99.218]
X-ClientProxiedBy: EX19D037UWB004.ant.amazon.com (10.13.138.84) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Received-SPF: pass client-ip=44.246.68.102;
 envelope-from=prvs=645f258d4=graf@amazon.de;
 helo=pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com
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

All boards create sysbus devices with an explicit parent now.
Drop sysbus_create_simple_orphan() and
sysbus_create_varargs_orphan().

Assisted-by: Kiro
Signed-off-by: Alexander Graf <graf@amazon.com>
---
 hw/core/sysbus.c         | 29 -----------------------------
 include/hw/core/sysbus.h | 11 -----------
 2 files changed, 40 deletions(-)

diff --git a/hw/core/sysbus.c b/hw/core/sysbus.c
index bbacb07e1a..2974616285 100644
--- a/hw/core/sysbus.c
+++ b/hw/core/sysbus.c
@@ -242,35 +242,6 @@ DeviceState *sysbus_create_varargs(Object *parent, const char *id,
     return dev;
 }
 
-DeviceState *sysbus_create_varargs_orphan(const char *name,
-                                   hwaddr addr, ...)
-{
-    DeviceState *dev;
-    SysBusDevice *s;
-    va_list va;
-    qemu_irq irq;
-    int n;
-
-    dev = qdev_new_orphan(name);
-    s = SYS_BUS_DEVICE(dev);
-    sysbus_realize_and_unref(s, &error_fatal);
-    if (addr != (hwaddr)-1) {
-        sysbus_mmio_map(s, 0, addr);
-    }
-    va_start(va, addr);
-    n = 0;
-    while (1) {
-        irq = va_arg(va, qemu_irq);
-        if (!irq) {
-            break;
-        }
-        sysbus_connect_irq(s, n, irq);
-        n++;
-    }
-    va_end(va);
-    return dev;
-}
-
 bool sysbus_realize(SysBusDevice *dev, Error **errp)
 {
     return qdev_realize(DEVICE(dev), sysbus_get_default(), errp);
diff --git a/include/hw/core/sysbus.h b/include/hw/core/sysbus.h
index 7737c959c5..d3f4332b3c 100644
--- a/include/hw/core/sysbus.h
+++ b/include/hw/core/sysbus.h
@@ -115,15 +115,4 @@ static inline DeviceState *sysbus_create_simple(Object *parent,
     return sysbus_create_varargs(parent, id, type, addr, irq, NULL);
 }
 
-/* Legacy helper function for creating unparented devices.  */
-DeviceState *sysbus_create_varargs_orphan(const char *name,
-                                 hwaddr addr, ...);
-
-static inline DeviceState *sysbus_create_simple_orphan(const char *name,
-                                              hwaddr addr,
-                                              qemu_irq irq)
-{
-    return sysbus_create_varargs_orphan(name, addr, irq, NULL);
-}
-
 #endif /* HW_SYSBUS_H */
-- 
2.47.1


