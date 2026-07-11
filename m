Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8193C43458
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2026 22:45:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wigRt-0005Oc-Hs; Sat, 11 Jul 2026 18:45:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=645f258d4=graf@amazon.de>)
 id 1wigRr-0005Ln-Fi; Sat, 11 Jul 2026 18:45:28 -0400
Received: from pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com
 ([52.34.181.151])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=645f258d4=graf@amazon.de>)
 id 1wigRp-00077s-Bt; Sat, 11 Jul 2026 18:45:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1783809925; x=1815345925;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=pIYExrBVqffjhEmg/kIfnd01/Jqg+0TepAxoq/TOvVc=;
 b=hBBGkDpyyAqlKN3mwvyyI9y11y+xlc70wtDO3CfWSf9BHT66KhQ0YPDQ
 bxcYd+dxXQrhTnXS2hFUFuQx/hd9M4/N+CLx3iWHIkTncXVG3+Ji060kZ
 mi7VBrALI/Q1o+13TlkoywbLZGTg4tzotHTCnWta6R3J1ah5SkUE1Dxij
 GfxLH6qak2TNY+3+l2gf2l+9dI6D+l3MH7a5imRJgia8SGQ56tdRailcQ
 Qhblzn4PNi2cyyaaCQ9LnBciNU9L9yooF/dBlJt/XzIpFFC3IOWOb92DR
 AxhzmF+3h8PmDXivbPLvoUBNiV4Qi54hZBhCNwkH8qJh1GEMULQmdTSW2 w==;
X-CSE-ConnectionGUID: 4WeAthXyRSONiHU8rXEi1g==
X-CSE-MsgGUID: dcBEp1CjSOCDapYOSFOMsg==
X-IronPort-AV: E=Sophos;i="6.25,154,1779148800"; d="scan'208";a="23483294"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
 by internal-pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2026 22:45:20 +0000
Received: from EX19MTAUWA001.ant.amazon.com [205.251.233.236:19708]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.11.115:2525]
 with esmtp (Farcaster)
 id 7e4c701f-53ba-4fb4-884d-d862a854859a; Sat, 11 Jul 2026 22:45:20 +0000 (UTC)
X-Farcaster-Flow-ID: 7e4c701f-53ba-4fb4-884d-d862a854859a
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 11 Jul 2026 22:45:20 +0000
Received: from ip-10-253-83-51.amazon.com (172.19.99.218) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 11 Jul 2026 22:45:11 +0000
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
Subject: [RFC PATCH 031/134] hw/hexagon: Give onboard devices a QOM parent
Date: Sat, 11 Jul 2026 22:35:24 +0000
Message-ID: <20260711223707.42139-32-graf@amazon.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260711223707.42139-1-graf@amazon.com>
References: <20260711223707.42139-1-graf@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.19.99.218]
X-ClientProxiedBy: EX19D032UWB001.ant.amazon.com (10.13.139.152) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Received-SPF: pass client-ip=52.34.181.151;
 envelope-from=prvs=645f258d4=graf@amazon.de;
 helo=pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com
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

Convert the *_orphan() device-creation calls in hw/hexagon to the new
parented API introduced earlier in this series, so every onboard
device gets a stable path in the composition tree instead of landing
in /machine/unattached with an unstable device[N] name.

The parent for each device is the object that owns its lifetime: the
machine for board-created devices, the containing device for
composite children.  Names follow existing QOM conventions.

Per-site rationale (reviewers: dispute the modeling here):

hw/hexagon/hexagon_dsp.c:134 | qdev_new | OBJECT(machine) | "global-regs" | board init helper; collapse existing object_property_add_child()
hw/hexagon/hexagon_dsp.c:141 | qdev_new | OBJECT(machine) | "tlb" | board init helper; collapse existing object_property_add_child()
hw/hexagon/virt.c:132 | qdev_new | OBJECT(vms) | "uart" | board-init helper receives HexagonVirtMachineState*; drop const on vms
hw/hexagon/virt.c:271 | qdev_new | OBJECT(ms) | "global-regs" | board init; collapse existing object_property_add_child()
hw/hexagon/virt.c:277 | qdev_new | OBJECT(ms) | "tlb" | board init; collapse existing object_property_add_child()

Link: https://lore.kernel.org/qemu-devel/87jyr3w9tc.fsf@pond.sub.org/
Assisted-by: Kiro
Signed-off-by: Alexander Graf <graf@amazon.com>
---
 hw/hexagon/hexagon_dsp.c | 12 +++++-------
 hw/hexagon/virt.c        | 16 +++++++---------
 2 files changed, 12 insertions(+), 16 deletions(-)

diff --git a/hw/hexagon/hexagon_dsp.c b/hw/hexagon/hexagon_dsp.c
index 712749cda8..ccd9a06f51 100644
--- a/hw/hexagon/hexagon_dsp.c
+++ b/hw/hexagon/hexagon_dsp.c
@@ -131,18 +131,16 @@ static void hexagon_common_init(MachineState *machine, Rev_t rev,
                            machine->ram_size, &error_fatal);
     memory_region_add_subregion(address_space, 0x0, &hms->ram);
 
-    glob_regs_dev = qdev_new_orphan(TYPE_HEXAGON_GLOBALREG);
-    object_property_add_child(OBJECT(machine), "global-regs",
-                              OBJECT(glob_regs_dev));
+    glob_regs_dev = qdev_new(OBJECT(machine), "global-regs",
+                             TYPE_HEXAGON_GLOBALREG);
     qdev_prop_set_uint64(glob_regs_dev, "config-table-addr", m_cfg->cfgbase);
     qdev_prop_set_uint32(glob_regs_dev, "dsp-rev", rev);
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(glob_regs_dev), &error_fatal);
+    sysbus_realize(SYS_BUS_DEVICE(glob_regs_dev), &error_fatal);
 
-    tlb_dev = qdev_new_orphan(TYPE_HEXAGON_TLB);
-    object_property_add_child(OBJECT(machine), "tlb", OBJECT(tlb_dev));
+    tlb_dev = qdev_new(OBJECT(machine), "tlb", TYPE_HEXAGON_TLB);
     qdev_prop_set_uint32(tlb_dev, "num-entries",
                          m_cfg->cfgtable.jtlb_size_entries);
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(tlb_dev), &error_fatal);
+    sysbus_realize(SYS_BUS_DEVICE(tlb_dev), &error_fatal);
 
     for (int i = 0; i < machine->smp.cpus; i++) {
         HexagonCPU *cpu = HEXAGON_CPU(object_new(machine->cpu_type));
diff --git a/hw/hexagon/virt.c b/hw/hexagon/virt.c
index a7a6a8fbeb..0619f06c41 100644
--- a/hw/hexagon/virt.c
+++ b/hw/hexagon/virt.c
@@ -116,7 +116,7 @@ static int32_t fdt_add_clocks(const HexagonVirtMachineState *vms)
     return clk_phandle;
 }
 
-static void fdt_add_uart(const HexagonVirtMachineState *vms, int uart,
+static void fdt_add_uart(HexagonVirtMachineState *vms, int uart,
                          int32_t clk_phandle)
 {
     char *nodename;
@@ -129,11 +129,11 @@ static void fdt_add_uart(const HexagonVirtMachineState *vms, int uart,
     DeviceState *dev;
     SysBusDevice *s;
 
-    dev = qdev_new_orphan(TYPE_PL011);
+    dev = qdev_new(OBJECT(vms), "uart", TYPE_PL011);
     s = SYS_BUS_DEVICE(dev);
     qdev_prop_set_chr(dev, "chardev", serial_hd(0));
     qdev_connect_clock_in(dev, "clk", vms->apb_clk);
-    sysbus_realize_and_unref(s, &error_fatal);
+    sysbus_realize(s, &error_fatal);
     sysbus_mmio_map(s, 0, base);
 
     nodename = g_strdup_printf("/pl011@%" PRIx64, base);
@@ -268,17 +268,15 @@ static void virt_init(MachineState *ms)
                                 &vms->parent_obj.cfgtable_rom);
     fdt_add_hvx(vms, m_cfg);
 
-    gsregs_dev = qdev_new_orphan(TYPE_HEXAGON_GLOBALREG);
-    object_property_add_child(OBJECT(ms), "global-regs", OBJECT(gsregs_dev));
+    gsregs_dev = qdev_new(OBJECT(ms), "global-regs", TYPE_HEXAGON_GLOBALREG);
     qdev_prop_set_uint64(gsregs_dev, "config-table-addr", m_cfg->cfgbase);
     qdev_prop_set_uint32(gsregs_dev, "dsp-rev", v68_rev);
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(gsregs_dev), &error_fatal);
+    sysbus_realize(SYS_BUS_DEVICE(gsregs_dev), &error_fatal);
 
-    tlb_dev = qdev_new_orphan(TYPE_HEXAGON_TLB);
-    object_property_add_child(OBJECT(ms), "tlb", OBJECT(tlb_dev));
+    tlb_dev = qdev_new(OBJECT(ms), "tlb", TYPE_HEXAGON_TLB);
     qdev_prop_set_uint32(tlb_dev, "num-entries",
                          m_cfg->cfgtable.jtlb_size_entries);
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(tlb_dev), &error_fatal);
+    sysbus_realize(SYS_BUS_DEVICE(tlb_dev), &error_fatal);
 
     cpu0 = NULL;
     for (int i = 0; i < ms->smp.cpus; i++) {
-- 
2.47.1


