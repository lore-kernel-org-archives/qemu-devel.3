Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F9A6C43458
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2026 22:50:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wigWf-0005lH-Hr; Sat, 11 Jul 2026 18:50:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=645f258d4=graf@amazon.de>)
 id 1wigWa-0005c9-QZ; Sat, 11 Jul 2026 18:50:22 -0400
Received: from pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com
 ([35.155.198.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=645f258d4=graf@amazon.de>)
 id 1wigWX-0007zt-9r; Sat, 11 Jul 2026 18:50:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1783810217; x=1815346217;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=9+ZWoiPeSK+V+fUDC1op6eSwsiQAvI3DMHq1T5ncZAg=;
 b=S+GXgKlh/lUvYp2L+jRzuORIU6RxM/QpVcPqO2uLVBAMoRI6dU7CuCdy
 4zOl2E7hB1NC8QWeQI2YbvnYFyCbEKZX2EuRazR0FMeHfBOuPuUlPzOqZ
 355VJgThi1pxSDeqthzyVtQ5sBGj+612Na45qYlY3Ahuq3bhsrzQa340p
 3hWv1aM6wcvG5OKalD0pM+LPQp6j4HNlxJ6HU7H1fkaKAdvegEwFMB7lV
 d87kZRIiF3f+YAiOgePJbPj0dcoQKe+a1ZQvW12yGrPV99ghsKmbUVw+H
 UUn4rvXmyZhW6pXurUcjz6qgicv97rz7dQDMjZ9/0yv+jAx1CM6FdevNP Q==;
X-CSE-ConnectionGUID: mYGCbRdHT1y5rNezT8juIw==
X-CSE-MsgGUID: EeExzj97TuaASucCQ3sxSw==
X-IronPort-AV: E=Sophos;i="6.25,154,1779148800"; d="scan'208";a="23390492"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
 by internal-pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2026 22:50:13 +0000
Received: from EX19MTAUWB001.ant.amazon.com [205.251.233.51:21678]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.11.68:2525]
 with esmtp (Farcaster)
 id 23676f4b-82d6-43cc-bd47-5278b23dcc33; Sat, 11 Jul 2026 22:50:12 +0000 (UTC)
X-Farcaster-Flow-ID: 23676f4b-82d6-43cc-bd47-5278b23dcc33
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 11 Jul 2026 22:50:12 +0000
Received: from ip-10-253-83-51.amazon.com (172.19.99.218) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 11 Jul 2026 22:50:04 +0000
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
Subject: [RFC PATCH 050/134] hw/pci: Give onboard devices a QOM parent
Date: Sat, 11 Jul 2026 22:35:43 +0000
Message-ID: <20260711223707.42139-51-graf@amazon.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260711223707.42139-1-graf@amazon.com>
References: <20260711223707.42139-1-graf@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.19.99.218]
X-ClientProxiedBy: EX19D041UWB001.ant.amazon.com (10.13.139.132) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Received-SPF: pass client-ip=35.155.198.111;
 envelope-from=prvs=645f258d4=graf@amazon.de;
 helo=pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com
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

Convert the *_orphan() device-creation calls in hw/pci to the new
parented API introduced earlier in this series, so every onboard
device gets a stable path in the composition tree instead of landing
in /machine/unattached with an unstable device[N] name.

The parent for each device is the object that owns its lifetime: the
machine for board-created devices, the containing device for
composite children.  Names follow existing QOM conventions.

Per-site rationale (reviewers: dispute the modeling here):

hw/pci/pci.c:2121 | pci_new_orphan | ORPHAN-JUSTIFIED | - | pci_init_nic_in_slot() is a public helper called from board init in hw/{riscv,sh4,ppc,mips}; parenting requires threading Object* through include/hw/pci/pci.h and 5 callers; deferred to caller-side patches
hw/pci/pci.c:2132 | pci_create_simple_orphan | ORPHAN-JUSTIFIED | - | pci_vga_init() is a public helper called from board init in hw/{i386,ppc,mips,alpha}; parenting requires threading Object* through include/hw/pci/pci.h and 11 callers; deferred to caller-side patches
hw/pci/pci.c:2134 | pci_create_simple_orphan | ORPHAN-JUSTIFIED | - | pci_vga_init() public helper; deferred (see :2132)
hw/pci/pci.c:2136 | pci_create_simple_orphan | ORPHAN-JUSTIFIED | - | pci_vga_init() public helper; deferred (see :2132)
hw/pci/pci.c:2138 | pci_create_simple_orphan | ORPHAN-JUSTIFIED | - | pci_vga_init() public helper; deferred (see :2132)
hw/pci/pci.c:2140 | pci_create_simple_orphan | ORPHAN-JUSTIFIED | - | pci_vga_init() public helper; deferred (see :2132)
hw/pci/pci.c:2396 | qdev_new_orphan | ORPHAN-JUSTIFIED | - | pci_new_internal() is the implementation body of pci_new*_orphan() transitional API
hw/pci/pci.c:2443 | pci_new_multifunction_orphan | ORPHAN-JUSTIFIED | - | API definition (transitional _orphan wrapper)
hw/pci/pci.c:2448 | pci_new_orphan | ORPHAN-JUSTIFIED | - | API definition (transitional _orphan wrapper)
hw/pci/pci.c:2458 | pci_create_simple_multifunction_orphan | ORPHAN-JUSTIFIED | - | API definition (transitional _orphan wrapper)
hw/pci/pci.c:2461 | pci_new_multifunction_orphan | ORPHAN-JUSTIFIED | - | API definition body of pci_create_simple_multifunction_orphan()
hw/pci/pci.c:2466 | pci_create_simple_orphan | ORPHAN-JUSTIFIED | - | API definition (transitional _orphan wrapper)
hw/pci/pci.c:2468 | pci_new_orphan | ORPHAN-JUSTIFIED | - | API definition body of pci_create_simple_orphan()
hw/pci/pcie_sriov.c:174 | pci_new | OBJECT(dev) | "vf[*]" | pcie_sriov_pf_init(): VFs are children of the PF PCIDevice; already uses qdev_realize(); drop extra object_unref() on error path since parent child<> holds the only ref

Link: https://lore.kernel.org/qemu-devel/87jyr3w9tc.fsf@pond.sub.org/
Assisted-by: Kiro
Signed-off-by: Alexander Graf <graf@amazon.com>
---
 hw/pci/pcie_sriov.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/pci/pcie_sriov.c b/hw/pci/pcie_sriov.c
index a69a41cdde..eb1707bb41 100644
--- a/hw/pci/pcie_sriov.c
+++ b/hw/pci/pcie_sriov.c
@@ -171,13 +171,12 @@ bool pcie_sriov_pf_init(PCIDevice *dev, uint16_t offset,
     dev->exp.sriov_pf.vf = g_new(PCIDevice *, total_vfs);
 
     for (uint16_t i = 0; i < total_vfs; i++) {
-        PCIDevice *vf = pci_new_orphan(devfn, vfname);
+        PCIDevice *vf = pci_new(OBJECT(dev), "vf[*]", devfn, vfname);
         vf->exp.sriov_vf.pf = dev;
         vf->exp.sriov_vf.vf_number = i;
 
         if (!qdev_realize(&vf->qdev, bus, errp)) {
             object_unparent(OBJECT(vf));
-            object_unref(vf);
             unparent_vfs(dev, i);
             return false;
         }
-- 
2.47.1


