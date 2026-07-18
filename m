Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB550C44521
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jul 2026 22:01:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlD5u-0006oj-36; Sat, 18 Jul 2026 18:01:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=65292d44c=graf@amazon.de>)
 id 1wlD5h-0006PT-3t; Sat, 18 Jul 2026 18:01:05 -0400
Received: from pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com
 ([52.42.203.116])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=65292d44c=graf@amazon.de>)
 id 1wlD5f-00059H-9R; Sat, 18 Jul 2026 18:01:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1784412059; x=1815948059;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=1pkQn3/9x2L+GgRgyaJRqVz1nB5NSwMUxiFMHCcRqjw=;
 b=ehIQX96DZlXzAAT4gHS7ONRLHzkWrY0bkrx+591Wu42sJ0d+Fyt0iGe3
 c9eaBWv56WceLcWPk7zJaGw1/CCnpZy4CGaGik7mOAAYo2J2QRGCxN8aj
 zgaeYnqf58xmx4eTcInJPtnqI9117EKykjpQWXiQUk0o/auUJzaO7vijb
 Z93yMuKO55dRxpK8jMcdXWUsZ099CfTlQsw/TVQv95ORrcBXDBvVJsF5c
 9Ay/frEMEZ/uAlxbjP0Ohkv8bHghTFqJ4PBw7+ELtCzk6hCZ8N/f5t3kg
 P7fQ4DXnDKXXFTXy/SAx0foeodSg57lTiJr2oSfPxsyiBu1+cIhAzsODN w==;
X-CSE-ConnectionGUID: SXK0AEsGQciEcg918FNbGA==
X-CSE-MsgGUID: 6uxgIRAjQ4S7TPehJ52yCQ==
X-IronPort-AV: E=Sophos;i="6.25,171,1779148800"; d="scan'208";a="23940288"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
 by internal-pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2026 22:00:56 +0000
Received: from EX19MTAUWB002.ant.amazon.com [205.251.233.48:9848]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.11.151:2525]
 with esmtp (Farcaster)
 id ec2b0a44-07e9-4f8c-b20b-7e10147a0876; Sat, 18 Jul 2026 22:00:56 +0000 (UTC)
X-Farcaster-Flow-ID: ec2b0a44-07e9-4f8c-b20b-7e10147a0876
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 18 Jul 2026 22:00:55 +0000
Received: from ip-10-253-83-51.amazon.com (172.19.99.218) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 18 Jul 2026 22:00:46 +0000
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
Subject: [RFC PATCH v2 086/137] pci: Remove *_orphan() creator variants
Date: Sat, 18 Jul 2026 21:36:01 +0000
Message-ID: <20260718213652.37673-87-graf@amazon.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260718213652.37673-1-graf@amazon.com>
References: <20260711223707.42139-1-graf@amazon.com>
 <20260718213652.37673-1-graf@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [172.19.99.218]
X-ClientProxiedBy: EX19D036UWC003.ant.amazon.com (10.13.139.214) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Received-SPF: pass client-ip=52.42.203.116;
 envelope-from=prvs=65292d44c=graf@amazon.de;
 helo=pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com
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

All boards create their PCI devices with an explicit QOM parent
now.  Drop pci_new_orphan(), pci_new_multifunction_orphan(),
pci_create_simple_orphan(), pci_create_simple_multifunction_orphan()
and the internal pci_new_internal() they wrapped.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
AI-used-for: code (refactoring)
Signed-off-by: Alexander Graf <graf@amazon.com>
---
 hw/pci/pci.c         | 35 -----------------------------------
 include/hw/pci/pci.h |  5 -----
 2 files changed, 40 deletions(-)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index ca5882ba59..5ef9dfa8b7 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -2388,16 +2388,6 @@ static void pci_qdev_realize(DeviceState *qdev, Error **errp)
     pci_dev->msi_trigger = pci_msi_trigger;
 }
 
-static PCIDevice *pci_new_internal(int devfn, bool multifunction,
-                                   const char *name)
-{
-    DeviceState *dev;
-
-    dev = qdev_new_orphan(name);
-    qdev_prop_set_int32(dev, "addr", devfn);
-    qdev_prop_set_bit(dev, "multifunction", multifunction);
-    return PCI_DEVICE(dev);
-}
 
 static PCIDevice *pci_new_child_internal(Object *parent, const char *id,
                                           int devfn, bool multifunction,
@@ -2440,36 +2430,11 @@ PCIDevice *pci_create_simple(Object *parent, const char *id,
     return dev;
 }
 
-PCIDevice *pci_new_multifunction_orphan(int devfn, const char *name)
-{
-    return pci_new_internal(devfn, true, name);
-}
-
-PCIDevice *pci_new_orphan(int devfn, const char *name)
-{
-    return pci_new_internal(devfn, false, name);
-}
-
 bool pci_realize_and_unref(PCIDevice *dev, PCIBus *bus, Error **errp)
 {
     return qdev_realize_and_unref(&dev->qdev, &bus->qbus, errp);
 }
 
-PCIDevice *pci_create_simple_multifunction_orphan(PCIBus *bus, int devfn,
-                                           const char *name)
-{
-    PCIDevice *dev = pci_new_multifunction_orphan(devfn, name);
-    pci_realize_and_unref(dev, bus, &error_fatal);
-    return dev;
-}
-
-PCIDevice *pci_create_simple_orphan(PCIBus *bus, int devfn, const char *name)
-{
-    PCIDevice *dev = pci_new_orphan(devfn, name);
-    pci_realize_and_unref(dev, bus, &error_fatal);
-    return dev;
-}
-
 static uint8_t pci_find_space(PCIDevice *pdev, uint8_t size)
 {
     int offset = PCI_CONFIG_HEADER_SIZE;
diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index 9c6bcc0b96..d6191fc529 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -1098,13 +1098,8 @@ PCIDevice *pci_create_simple_multifunction(Object *parent, const char *id,
 PCIDevice *pci_create_simple(Object *parent, const char *id,
                              PCIBus *bus, int devfn, const char *type);
 
-PCIDevice *pci_new_multifunction_orphan(int devfn, const char *name);
-PCIDevice *pci_new_orphan(int devfn, const char *name);
 bool pci_realize_and_unref(PCIDevice *dev, PCIBus *bus, Error **errp);
 
-PCIDevice *pci_create_simple_multifunction_orphan(PCIBus *bus, int devfn,
-                                           const char *name);
-PCIDevice *pci_create_simple_orphan(PCIBus *bus, int devfn, const char *name);
 
 void lsi53c8xx_handle_legacy_cmdline(DeviceState *lsi_dev);
 
-- 
2.47.1


