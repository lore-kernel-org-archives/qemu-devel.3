Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D674C43458
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2026 23:06:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiglt-0003OX-4a; Sat, 11 Jul 2026 19:06:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=645f258d4=graf@amazon.de>)
 id 1wiglr-0003GP-32; Sat, 11 Jul 2026 19:06:07 -0400
Received: from pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com
 ([44.245.243.92])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=645f258d4=graf@amazon.de>)
 id 1wiglp-0003UL-A0; Sat, 11 Jul 2026 19:06:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1783811165; x=1815347165;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=/5yU84d9UxtZFYQr9HaVFk2ROo63f4rXE8S2/8205jM=;
 b=qWxf6vxHe7MbwGx11kBsj04eiOzS7aEL7e2Ylry66n7+SfyNKU/YhAxX
 6YnRDlzzO7q4FnhfffSq++RZA9dqyvDwPW1r6URfxWeY4Zhc9ABuPQMEG
 Xrd0kCsPUuZNI9rDBND8rfj6HtIwxzJNdI9PZmH7fWRNYYxFF2M3As+oF
 Y1Yy7LCqsEdEonBEZ0P5I5pzJtnA6qyFeV8NnGXdBIljq02EI6bTpnljM
 4pCMr+/P05bSYiY3kOXmZgFPPO0cxQXwPfV4bgI0zWvdR03aV6LPqhplr
 dm/7bkDFNe7iJdwtJBnfCBXBoyK8jJOKAFp0QrUzu7TWZ86E6vvoeUREi w==;
X-CSE-ConnectionGUID: O06q8DiUQL6x+iY7qOKIFA==
X-CSE-MsgGUID: 7dv5OYryQkWkyK3dkhlzgw==
X-IronPort-AV: E=Sophos;i="6.25,154,1779148800"; d="scan'208";a="22997816"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
 by internal-pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2026 23:06:01 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.234:3160]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.58.33:2525]
 with esmtp (Farcaster)
 id 51fd3cc1-a2df-44d4-b696-324a6010a1e5; Sat, 11 Jul 2026 23:06:01 +0000 (UTC)
X-Farcaster-Flow-ID: 51fd3cc1-a2df-44d4-b696-324a6010a1e5
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 11 Jul 2026 23:06:01 +0000
Received: from ip-10-253-83-51.amazon.com (172.19.99.218) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 11 Jul 2026 23:05:52 +0000
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
Subject: [RFC PATCH 110/134] hw/pci, hw/usb,
 system: Give allocated IRQs an owner and name
Date: Sat, 11 Jul 2026 22:36:43 +0000
Message-ID: <20260711223707.42139-111-graf@amazon.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260711223707.42139-1-graf@amazon.com>
References: <20260711223707.42139-1-graf@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.19.99.218]
X-ClientProxiedBy: EX19D046UWA004.ant.amazon.com (10.13.139.76) To
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

Convert pci_allocate_irq() and the qtest interceptor to the parented
qemu_allocate_irq() form so the IRQ objects land under the device
that owns their lifetime instead of /machine/unattached.

hw/usb/vt82c686-uhci-pci.c drops the IRQ set up by the base UHCI
class before installing its own; switch that from object_unref() to
qemu_free_irq() so it unparents the now-parented IRQ before freeing
it.

  hw/pci/pci.c pci_allocate_irq()  | OBJECT(pci_dev) | "intx-irq"
  system/qtest.c qtest intercept   | OBJECT(dev)     | "qtest-icpt[*]"
  hw/usb/vt82c686-uhci-pci.c       | OBJECT(s)       | "isa-irq"

Assisted-by: Kiro
Signed-off-by: Alexander Graf <graf@amazon.com>
---
 hw/pci/pci.c               | 2 +-
 hw/usb/vt82c686-uhci-pci.c | 4 ++--
 system/qtest.c             | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 9ba7bfd977..d92092b233 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -1869,7 +1869,7 @@ qemu_irq pci_allocate_irq(PCIDevice *pci_dev)
     int intx = pci_intx(pci_dev);
     assert(0 <= intx && intx < PCI_NUM_PINS);
 
-    return qemu_allocate_irq_orphan(pci_irq_handler, pci_dev, intx);
+    return qemu_allocate_irq(OBJECT(pci_dev), "intx-irq", pci_irq_handler, pci_dev, intx);
 }
 
 void pci_set_irq(PCIDevice *pci_dev, int level)
diff --git a/hw/usb/vt82c686-uhci-pci.c b/hw/usb/vt82c686-uhci-pci.c
index b58b61e609..d8c9e98061 100644
--- a/hw/usb/vt82c686-uhci-pci.c
+++ b/hw/usb/vt82c686-uhci-pci.c
@@ -22,8 +22,8 @@ static void usb_uhci_vt82c686b_realize(PCIDevice *dev, Error **errp)
     pci_set_long(pci_conf + 0xc0, 0x00002000);
 
     usb_uhci_common_realize(dev, errp);
-    object_unref(s->irq);
-    s->irq = qemu_allocate_irq_orphan(uhci_isa_set_irq, s, 0);
+    qemu_free_irq(s->irq);
+    s->irq = qemu_allocate_irq(OBJECT(s), "isa-irq", uhci_isa_set_irq, s, 0);
 }
 
 static UHCIInfo uhci_info[] = {
diff --git a/system/qtest.c b/system/qtest.c
index f38feaac89..5ef99f9f23 100644
--- a/system/qtest.c
+++ b/system/qtest.c
@@ -346,7 +346,7 @@ void qtest_set_command_cb(bool (*pc_cb)(CharFrontend *chr, gchar **words))
 static void qtest_install_gpio_out_intercept(DeviceState *dev, const char *name, int n)
 {
     qemu_irq *disconnected = g_new0(qemu_irq, 1);
-    qemu_irq icpt = qemu_allocate_irq_orphan(qtest_irq_handler,
+    qemu_irq icpt = qemu_allocate_irq(OBJECT(dev), "qtest-icpt[*]", qtest_irq_handler,
                                       disconnected, n);
 
     *disconnected = qdev_intercept_gpio_out(dev, icpt, name, n);
-- 
2.47.1


