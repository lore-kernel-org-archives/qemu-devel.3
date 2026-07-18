Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21E19C4451B
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jul 2026 21:42:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlCm7-0005Cl-G5; Sat, 18 Jul 2026 17:40:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=65292d44c=graf@amazon.de>)
 id 1wlCls-00055Q-5Z; Sat, 18 Jul 2026 17:40:34 -0400
Received: from pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com
 ([44.245.243.92])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=65292d44c=graf@amazon.de>)
 id 1wlClp-0002N7-Ml; Sat, 18 Jul 2026 17:40:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1784410829; x=1815946829;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=5B7c7y3Mo/XDrIc6yu/29JncGzXitN8v+W3KAxOTJLg=;
 b=cnn3vRgNEdBRZXFSVJeNzOQyl6a8IDAkxHeSe9RMRBoU/Sv1aCjKPv5f
 Z9dV4AtS7G51Ciep51Eq+lNZBOZbduNh27xhrmuE+ncxURCZjpMov0d52
 lBMKfIiMoG0gFq1qfC0pTKjS8YhsyC5dlortrmEFAbgTY+FuU6CQy2P5T
 972oyuRzgPt1K8Besx2sf6fju8At+5iV9dfXQ8Z2gpSbph/zxGitoHC9X
 nDJEPX/sFgn6g0dPn6eL7lNschCDD44oA7veqIy28Ky2UbezVRDyzBpSJ
 xQ4446uJ9gRyGXmrzX6uaOGHnkuEItASgQGxqglwmZDPBAEHqMphXNVZr Q==;
X-CSE-ConnectionGUID: ac1KS6urSTeO3anGmoOUQA==
X-CSE-MsgGUID: tqu7biUERGOeU9TmDcWQRA==
X-IronPort-AV: E=Sophos;i="6.25,171,1779148800"; d="scan'208";a="23422528"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
 by internal-pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2026 21:40:26 +0000
Received: from EX19MTAUWC001.ant.amazon.com [205.251.233.53:5810]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.11.151:2525]
 with esmtp (Farcaster)
 id 8e0543be-3d6b-4a09-a96c-9dbfc03f38cc; Sat, 18 Jul 2026 21:40:26 +0000 (UTC)
X-Farcaster-Flow-ID: 8e0543be-3d6b-4a09-a96c-9dbfc03f38cc
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 18 Jul 2026 21:40:25 +0000
Received: from ip-10-253-83-51.amazon.com (172.19.99.218) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 18 Jul 2026 21:40:16 +0000
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
Subject: [RFC PATCH v2 012/137] hw/xtensa: Give onboard devices a QOM parent
Date: Sat, 18 Jul 2026 21:34:47 +0000
Message-ID: <20260718213652.37673-13-graf@amazon.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260718213652.37673-1-graf@amazon.com>
References: <20260711223707.42139-1-graf@amazon.com>
 <20260718213652.37673-1-graf@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.19.99.218]
X-ClientProxiedBy: EX19D035UWB001.ant.amazon.com (10.13.138.33) To
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

Convert the *_orphan() device-creation calls in hw/xtensa to the new
parented API introduced earlier in this series, so every onboard
device gets a stable path in the composition tree instead of landing
in /machine/unattached with an unstable device[N] name.

The parent for each device is the object that owns its lifetime: the
machine for board-created devices, the containing device for
composite children.  Names follow existing QOM conventions.

Per-site rationale (reviewers: dispute the modeling here):

  file:line       | parent           | name     | rationale
  sim.c:66        | OBJECT(machine)  | "cpu[*]" | SMP CPUs created by board init(); machine owns them
  virt.c:64       | OBJECT(ms)       | "pcie"   | GPEX PCIe host is a fixed onboard device of the virt machine; create_pcie() already receives MachineState
  xtfpga.c:176    | OBJECT(machine)  | "flash"  | onboard CFI flash; thread an Object *parent argument through the static xtfpga_flash_init() helper from board init()
  xtfpga.c:253    | OBJECT(machine)  | "cpu[*]" | SMP CPUs created by board init()

Link: https://lore.kernel.org/qemu-devel/87jyr3w9tc.fsf@pond.sub.org/
AI-used-for: code (refactoring)
Signed-off-by: Alexander Graf <graf@amazon.com>
---
 hw/xtensa/sim.c    |  2 +-
 hw/xtensa/virt.c   |  4 ++--
 hw/xtensa/xtfpga.c | 13 ++++++++-----
 3 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/hw/xtensa/sim.c b/hw/xtensa/sim.c
index 17245a0388..ad1439a0b4 100644
--- a/hw/xtensa/sim.c
+++ b/hw/xtensa/sim.c
@@ -63,7 +63,7 @@ XtensaCPU *xtensa_sim_common_init(MachineState *machine)
     int n;
 
     for (n = 0; n < machine->smp.cpus; n++) {
-        cpu = XTENSA_CPU(cpu_create_orphan(machine->cpu_type));
+        cpu = XTENSA_CPU(cpu_create(OBJECT(machine), "cpu[*]", machine->cpu_type));
         env = &cpu->env;
 
         env->sregs[PRID] = n;
diff --git a/hw/xtensa/virt.c b/hw/xtensa/virt.c
index e31b783b91..6b1271d0d5 100644
--- a/hw/xtensa/virt.c
+++ b/hw/xtensa/virt.c
@@ -61,8 +61,8 @@ static void create_pcie(MachineState *ms, CPUXtensaState *env, int irq_base,
     qemu_irq *extints;
     int i;
 
-    dev = qdev_new_orphan(TYPE_GPEX_HOST);
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+    dev = qdev_new(OBJECT(ms), "pcie", TYPE_GPEX_HOST);
+    sysbus_realize(SYS_BUS_DEVICE(dev), &error_fatal);
 
     /* Map only the first size_ecam bytes of ECAM space. */
     ecam_alias = g_new0(MemoryRegion, 1);
diff --git a/hw/xtensa/xtfpga.c b/hw/xtensa/xtfpga.c
index 0ee7350945..07b791b9bf 100644
--- a/hw/xtensa/xtfpga.c
+++ b/hw/xtensa/xtfpga.c
@@ -168,12 +168,13 @@ static void xtfpga_net_init(MemoryRegion *address_space,
     memory_region_add_subregion(address_space, buffers, ram);
 }
 
-static PFlashCFI01 *xtfpga_flash_init(MemoryRegion *address_space,
+static PFlashCFI01 *xtfpga_flash_init(Object *parent,
+                                      MemoryRegion *address_space,
                                       const XtfpgaBoardDesc *board,
                                       DriveInfo *dinfo, int be)
 {
     SysBusDevice *s;
-    DeviceState *dev = qdev_new_orphan(TYPE_PFLASH_CFI01);
+    DeviceState *dev = qdev_new(parent, "flash", TYPE_PFLASH_CFI01);
 
     qdev_prop_set_drive(dev, "drive", blk_by_legacy_dinfo(dinfo));
     qdev_prop_set_uint32(dev, "num-blocks",
@@ -183,7 +184,7 @@ static PFlashCFI01 *xtfpga_flash_init(MemoryRegion *address_space,
     qdev_prop_set_bit(dev, "big-endian", be);
     qdev_prop_set_string(dev, "name", "xtfpga.io.flash");
     s = SYS_BUS_DEVICE(dev);
-    sysbus_realize_and_unref(s, &error_fatal);
+    sysbus_realize(s, &error_fatal);
     memory_region_add_subregion(address_space, board->flash->base,
                                 sysbus_mmio_get_region(s, 0));
     return PFLASH_CFI01(dev);
@@ -250,7 +251,8 @@ static void xtfpga_init(const XtfpgaBoardDesc *board, MachineState *machine)
     for (n = 0; n < smp_cpus; n++) {
         CPUXtensaState *cenv = NULL;
 
-        cpu = XTENSA_CPU(cpu_create_orphan(machine->cpu_type));
+        cpu = XTENSA_CPU(cpu_create(OBJECT(machine), "cpu[*]",
+                                    machine->cpu_type));
         cenv = &cpu->env;
         if (!env) {
             env = cenv;
@@ -315,7 +317,8 @@ static void xtfpga_init(const XtfpgaBoardDesc *board, MachineState *machine)
 
     dinfo = drive_get(IF_PFLASH, 0, 0);
     if (dinfo) {
-        flash = xtfpga_flash_init(system_io, board, dinfo, TARGET_BIG_ENDIAN);
+        flash = xtfpga_flash_init(OBJECT(machine), system_io, board, dinfo,
+                                  TARGET_BIG_ENDIAN);
     }
 
     /* Use presence of kernel file name as 'boot from SRAM' switch. */
-- 
2.47.1


