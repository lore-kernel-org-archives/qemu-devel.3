Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA96BC43458
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2026 23:11:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wigrB-0004wv-5o; Sat, 11 Jul 2026 19:11:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=645f258d4=graf@amazon.de>)
 id 1wigr3-0004lW-Je; Sat, 11 Jul 2026 19:11:34 -0400
Received: from pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com
 ([52.26.1.71])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=645f258d4=graf@amazon.de>)
 id 1wigqt-0004oT-4g; Sat, 11 Jul 2026 19:11:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1783811479; x=1815347479;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=pDDCIg5+J6t1aKjwBKaum3v23g0Lhipp3/n7uMQNZGw=;
 b=hJpE+RmkCl2pBFvYs7s2BOgs2ldwxUHMVZkU6r5B1vnKoTXu/KwU5sNd
 OawZVq1kBi6OAKOgwZbFr87S3D0OIniz7ubAnfBs77EORrbdSx4rLVELp
 ZOHWLPUpnebQMNn6n/M39fQ3sNgUO6mb/gbVvWYqkyuyXRXvHigEnnSek
 YWpJkJH0U6a6smnwXdne0qczyPEc6CLZj9oiZWaeUtrC0CZxzz324F079
 V2pB2ITtt+KMKytc81VLMCIQvPnUW6t934wGRvZzR7cygSadEpo/Jh+kY
 Vb9SDZuj7cA8ZV3COLbmVTCsprwpr3fa/ZVrizq7lV8D0cGAQ4zoz2Si2 w==;
X-CSE-ConnectionGUID: v0vWqlHxT1++gg9sKfbu6Q==
X-CSE-MsgGUID: ZD7y+3XFRlmA7tCWGGe9LA==
X-IronPort-AV: E=Sophos;i="6.25,154,1779148800"; d="scan'208";a="23522651"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
 by internal-pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2026 23:11:15 +0000
Received: from EX19MTAUWC001.ant.amazon.com [205.251.233.53:15565]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.58.33:2525]
 with esmtp (Farcaster)
 id d00aa24b-fc60-4e21-b454-ed90061296a0; Sat, 11 Jul 2026 23:11:14 +0000 (UTC)
X-Farcaster-Flow-ID: d00aa24b-fc60-4e21-b454-ed90061296a0
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 11 Jul 2026 23:11:14 +0000
Received: from ip-10-253-83-51.amazon.com (172.19.99.218) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 11 Jul 2026 23:11:05 +0000
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
Subject: [RFC PATCH 129/134] hw: Parent board-created CPUs under the machine
Date: Sat, 11 Jul 2026 22:37:02 +0000
Message-ID: <20260711223707.42139-130-graf@amazon.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260711223707.42139-1-graf@amazon.com>
References: <20260711223707.42139-1-graf@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.19.99.218]
X-ClientProxiedBy: EX19D045UWC002.ant.amazon.com (10.13.139.230) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Received-SPF: pass client-ip=52.26.1.71;
 envelope-from=prvs=645f258d4=graf@amazon.de;
 helo=pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com
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

A number of boards create CPUs via object_new(cpu_type) followed
by property setting and qdev_realize(NULL), rather than through
cpu_create().  These CPUs currently fall into /machine/unattached
via the device_set_realized() fallback.  Parent them explicitly
under the machine (or the CPS/SoC container that owns them) as
"cpu[*]", matching the naming convention used by cpu_create().

The subsequent object_unref() and qdev_realize_and_unref() calls
are converted to plain qdev_realize() (or dropped) since the
parent's child<> property now holds the reference.  Error paths
switch to object_unparent().

The transient introspection object_new() in hw/arm/virt.c
machvirt_init() (probing pa_bits) is deliberately left as-is;
it is unref'd immediately without being realized.

  hw/arm:       integratorcp mps3r realview sbsa-ref versatilepb
                vexpress virt xilinx-zynq
  hw/hexagon:   hexagon_dsp virt
  hw/i386:      x86-common xen-pvh
  hw/loongarch: virt
  hw/mips:      cps
  hw/ppc:       e500 spapr (cpu-core)
  hw/riscv:     cps microblaze-v-generic
  hw/s390x:     s390-virtio-ccw
  hw/sparc:     leon3 sun4m
  hw/sparc64:   sparc64

Assisted-by: Kiro
Signed-off-by: Alexander Graf <graf@amazon.com>
---
 hw/arm/integratorcp.c           |  3 ++-
 hw/arm/mps3r.c                  |  4 ++--
 hw/arm/realview.c               |  3 ++-
 hw/arm/sbsa-ref.c               |  4 ++--
 hw/arm/versatilepb.c            |  3 ++-
 hw/arm/vexpress.c               |  3 ++-
 hw/arm/virt.c                   |  4 ++--
 hw/arm/xilinx_zynq.c            |  3 ++-
 hw/hexagon/hexagon_dsp.c        |  5 +++--
 hw/hexagon/virt.c               |  5 +++--
 hw/i386/x86-common.c            |  9 ++++-----
 hw/i386/xen/xen-pvh.c           |  5 ++---
 hw/loongarch/virt.c             |  5 +++--
 hw/mips/cps.c                   |  5 +++--
 hw/ppc/e500.c                   |  5 +++--
 hw/ppc/spapr.c                  |  4 ++--
 hw/riscv/cps.c                  |  5 +++--
 hw/riscv/microblaze-v-generic.c |  3 ++-
 hw/s390x/s390-virtio-ccw.c      | 16 +++++++---------
 hw/sparc/leon3.c                |  3 ++-
 hw/sparc/sun4m.c                |  5 +++--
 hw/sparc64/sparc64.c            |  3 ++-
 22 files changed, 58 insertions(+), 47 deletions(-)

diff --git a/hw/arm/integratorcp.c b/hw/arm/integratorcp.c
index 81c0bce8f9..30a6a940c5 100644
--- a/hw/arm/integratorcp.c
+++ b/hw/arm/integratorcp.c
@@ -598,7 +598,8 @@ static void integratorcp_init(MachineState *machine)
     DriveInfo *dinfo;
     int i;
 
-    cpuobj = object_new(machine->cpu_type);
+    cpuobj = object_new_child(OBJECT(machine), "cpu[0]",
+                                        machine->cpu_type);
 
     /* By default ARM1176 CPUs have EL3 enabled.  This board does not
      * currently support EL3 so the CPU EL3 property is disabled before
diff --git a/hw/arm/mps3r.c b/hw/arm/mps3r.c
index d6c29c1172..dd434eaefd 100644
--- a/hw/arm/mps3r.c
+++ b/hw/arm/mps3r.c
@@ -388,13 +388,13 @@ static void mps3r_common_init(MachineState *machine)
         memory_region_add_subregion_overlap(&mms->cpu_sysmem[i], 0,
                                             &mms->sysmem_alias[i], -1);
 
-        mms->cpu[i] = object_new(machine->cpu_type);
+        mms->cpu[i] = object_new_child(OBJECT(mms), "cpu[*]",
+                                        machine->cpu_type);
         object_property_set_link(mms->cpu[i], "memory",
                                  OBJECT(&mms->cpu_sysmem[i]), &error_abort);
         object_property_set_int(mms->cpu[i], "reset-cbar",
                                 PERIPHBASE, &error_abort);
         qdev_realize(DEVICE(mms->cpu[i]), NULL, &error_fatal);
-        object_unref(mms->cpu[i]);
 
         /* Per-CPU RAM */
         memory_region_init_ram(&mms->cpu_ram[i], OBJECT(mms), ramname,
diff --git a/hw/arm/realview.c b/hw/arm/realview.c
index 99591e7d80..f938367131 100644
--- a/hw/arm/realview.c
+++ b/hw/arm/realview.c
@@ -119,7 +119,8 @@ static void realview_init(MachineState *machine,
     }
 
     for (n = 0; n < smp_cpus; n++) {
-        Object *cpuobj = object_new(machine->cpu_type);
+        Object *cpuobj = object_new_child(OBJECT(machine), "cpu[*]",
+                                        machine->cpu_type);
 
         /* By default A9,A15 and ARM1176 CPUs have EL3 enabled.  This board
          * does not currently support EL3 so the CPU EL3 property is disabled
diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
index c9adc972c1..3b759d9209 100644
--- a/hw/arm/sbsa-ref.c
+++ b/hw/arm/sbsa-ref.c
@@ -783,7 +783,8 @@ static void sbsa_ref_init(MachineState *machine)
             break;
         }
 
-        cpuobj = object_new(possible_cpus->cpus[n].type);
+        cpuobj = object_new_child(OBJECT(sms), "cpu[*]",
+                                        possible_cpus->cpus[n].type);
         object_property_set_int(cpuobj, "mp-affinity",
                                 possible_cpus->cpus[n].arch_id, NULL);
 
@@ -808,7 +809,6 @@ static void sbsa_ref_init(MachineState *machine)
                                  OBJECT(secure_sysmem), &error_abort);
 
         qdev_realize(DEVICE(cpuobj), NULL, &error_fatal);
-        object_unref(cpuobj);
     }
 
     memory_region_add_subregion(sysmem, sbsa_ref_memmap[SBSA_MEM].base,
diff --git a/hw/arm/versatilepb.c b/hw/arm/versatilepb.c
index f68c4765c6..8d93fff207 100644
--- a/hw/arm/versatilepb.c
+++ b/hw/arm/versatilepb.c
@@ -208,7 +208,8 @@ static void versatile_init(MachineState *machine, int board_id)
         exit(1);
     }
 
-    cpuobj = object_new(machine->cpu_type);
+    cpuobj = object_new_child(OBJECT(machine), "cpu[0]",
+                                        machine->cpu_type);
 
     /* By default ARM1176 CPUs have EL3 enabled.  This board does not
      * currently support EL3 so the CPU EL3 property is disabled before
diff --git a/hw/arm/vexpress.c b/hw/arm/vexpress.c
index f877ccf330..986525b9ce 100644
--- a/hw/arm/vexpress.c
+++ b/hw/arm/vexpress.c
@@ -219,7 +219,8 @@ static void init_cpus(MachineState *ms, const char *cpu_type,
 
     /* Create the actual CPUs */
     for (n = 0; n < smp_cpus; n++) {
-        Object *cpuobj = object_new(cpu_type);
+        Object *cpuobj = object_new_child(qdev_get_machine(), "cpu[*]",
+                                        cpu_type);
 
         if (!secure) {
             object_property_set_bool(cpuobj, "has_el3", false, NULL);
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index f2249a0b72..95e087d692 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -3039,7 +3039,8 @@ static void machvirt_init(MachineState *machine)
             break;
         }
 
-        cpuobj = object_new(possible_cpus->cpus[n].type);
+        cpuobj = object_new_child(OBJECT(vms), "cpu[*]",
+                                  possible_cpus->cpus[n].type);
         object_property_set_int(cpuobj, "mp-affinity",
                                 possible_cpus->cpus[n].arch_id, NULL);
 
@@ -3139,7 +3140,6 @@ static void machvirt_init(MachineState *machine)
         }
 
         qdev_realize(DEVICE(cpuobj), NULL, &error_fatal);
-        object_unref(cpuobj);
     }
 
     /* Now we've created the CPUs we can see if they have the hypvirt timer */
diff --git a/hw/arm/xilinx_zynq.c b/hw/arm/xilinx_zynq.c
index 441289e63f..a2dcdd422d 100644
--- a/hw/arm/xilinx_zynq.c
+++ b/hw/arm/xilinx_zynq.c
@@ -222,7 +222,8 @@ static void zynq_init(MachineState *machine)
     }
 
     for (n = 0; n < smp_cpus; n++) {
-        Object *cpuobj = object_new(machine->cpu_type);
+        Object *cpuobj = object_new_child(OBJECT(machine), "cpu[*]",
+                                        machine->cpu_type);
 
         object_property_set_int(cpuobj, "midr", ZYNQ_BOARD_MIDR,
                                 &error_fatal);
diff --git a/hw/hexagon/hexagon_dsp.c b/hw/hexagon/hexagon_dsp.c
index 53dfe6741e..d78a987dca 100644
--- a/hw/hexagon/hexagon_dsp.c
+++ b/hw/hexagon/hexagon_dsp.c
@@ -143,7 +143,8 @@ static void hexagon_common_init(MachineState *machine, Rev_t rev,
     sysbus_realize(SYS_BUS_DEVICE(tlb_dev), &error_fatal);
 
     for (int i = 0; i < machine->smp.cpus; i++) {
-        HexagonCPU *cpu = HEXAGON_CPU(object_new(machine->cpu_type));
+        HexagonCPU *cpu = HEXAGON_CPU(object_new_child(OBJECT(machine), "cpu[*]",
+                                        machine->cpu_type));
         qemu_register_reset(do_cpu_reset, cpu);
 
         /*
@@ -158,7 +159,7 @@ static void hexagon_common_init(MachineState *machine, Rev_t rev,
                                  OBJECT(glob_regs_dev), &error_fatal);
         object_property_set_link(OBJECT(cpu), "tlb",
                                  OBJECT(tlb_dev), &error_fatal);
-        qdev_realize_and_unref(DEVICE(cpu), NULL, &error_fatal);
+        qdev_realize(DEVICE(cpu), NULL, &error_fatal);
     }
 
     rom_add_blob_fixed_as("config_table.rom", &m_cfg->cfgtable,
diff --git a/hw/hexagon/virt.c b/hw/hexagon/virt.c
index fb23cda19f..48f1e35dd3 100644
--- a/hw/hexagon/virt.c
+++ b/hw/hexagon/virt.c
@@ -280,7 +280,8 @@ static void virt_init(MachineState *ms)
 
     cpu0 = NULL;
     for (int i = 0; i < ms->smp.cpus; i++) {
-        HexagonCPU *cpu = HEXAGON_CPU(object_new(ms->cpu_type));
+        HexagonCPU *cpu = HEXAGON_CPU(object_new_child(OBJECT(ms), "cpu[*]",
+                                        ms->cpu_type));
         qemu_register_reset(do_cpu_reset, cpu);
 
         if (i == 0) {
@@ -300,7 +301,7 @@ static void virt_init(MachineState *ms)
         object_property_set_link(OBJECT(cpu), "tlb",
                                  OBJECT(tlb_dev), &error_fatal);
 
-        qdev_realize_and_unref(DEVICE(cpu), NULL, &error_fatal);
+        qdev_realize(DEVICE(cpu), NULL, &error_fatal);
     }
     fdt_add_cpu_nodes(vms);
     clk_phandle = fdt_add_clocks(vms);
diff --git a/hw/i386/x86-common.c b/hw/i386/x86-common.c
index 151a67ee5f..5bbfee737e 100644
--- a/hw/i386/x86-common.c
+++ b/hw/i386/x86-common.c
@@ -55,15 +55,14 @@ static size_t pvh_start_addr;
 
 static void x86_cpu_new(X86MachineState *x86ms, int64_t apic_id, Error **errp)
 {
-    Object *cpu = object_new(MACHINE(x86ms)->cpu_type);
+    Object *cpu = object_new_child(OBJECT(x86ms), "cpu[*]",
+                                        MACHINE(x86ms)->cpu_type);
 
     if (!object_property_set_uint(cpu, "apic-id", apic_id, errp)) {
-        goto out;
+        object_unparent(cpu);
+        return;
     }
     qdev_realize(DEVICE(cpu), NULL, errp);
-
-out:
-    object_unref(cpu);
 }
 
 void x86_cpus_init(X86MachineState *x86ms, int default_cpu_version)
diff --git a/hw/i386/xen/xen-pvh.c b/hw/i386/xen/xen-pvh.c
index ab90c83a83..7aef48ad61 100644
--- a/hw/i386/xen/xen-pvh.c
+++ b/hw/i386/xen/xen-pvh.c
@@ -29,12 +29,11 @@ struct XenPVHx86State {
 static DeviceState *xen_pvh_cpu_new(MachineState *ms,
                                     int64_t apic_id)
 {
-    Object *cpu = object_new(ms->cpu_type);
+    Object *cpu = object_new_child(OBJECT(ms), "cpu[*]",
+                                        ms->cpu_type);
 
-    object_property_add_child(OBJECT(ms), "cpu[*]", cpu);
     object_property_set_uint(cpu, "apic-id", apic_id, &error_fatal);
     qdev_realize(DEVICE(cpu), NULL, &error_fatal);
-    object_unref(cpu);
 
     return DEVICE(cpu);
 }
diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index 580ef0bb3e..b749aafdbe 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -948,13 +948,14 @@ static void virt_init(MachineState *machine)
     /* Init CPUs */
     mc->possible_cpu_arch_ids(machine);
     for (i = 0; i < machine->smp.cpus; i++) {
-        cpuobj = object_new(machine->cpu_type);
+        cpuobj = object_new_child(OBJECT(machine), "cpu[*]",
+                                        machine->cpu_type);
         if (cpuobj == NULL) {
             error_report("Fail to create object with type %s ",
                          machine->cpu_type);
             exit(EXIT_FAILURE);
         }
-        qdev_realize_and_unref(DEVICE(cpuobj), NULL, &error_fatal);
+        qdev_realize(DEVICE(cpuobj), NULL, &error_fatal);
     }
     virt_check_dmsi(machine);
     fw_cfg_add_memory(machine);
diff --git a/hw/mips/cps.c b/hw/mips/cps.c
index 620ee972f8..b997608373 100644
--- a/hw/mips/cps.c
+++ b/hw/mips/cps.c
@@ -74,7 +74,8 @@ static void mips_cps_realize(DeviceState *dev, Error **errp)
     }
 
     for (int i = 0; i < s->num_vp; i++) {
-        MIPSCPU *cpu = MIPS_CPU(object_new(s->cpu_type));
+        MIPSCPU *cpu = MIPS_CPU(object_new_child(OBJECT(s), "cpu[*]",
+                                        s->cpu_type));
         CPUMIPSState *env = &cpu->env;
 
         object_property_set_bool(OBJECT(cpu), "big-endian", s->cpu_is_bigendian,
@@ -87,7 +88,7 @@ static void mips_cps_realize(DeviceState *dev, Error **errp)
         /* All cores use the same clock tree */
         qdev_connect_clock_in(DEVICE(cpu), "clk-in", s->clock);
 
-        if (!qdev_realize_and_unref(DEVICE(cpu), NULL, errp)) {
+        if (!qdev_realize(DEVICE(cpu), NULL, errp)) {
             return;
         }
 
diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
index f3917c0755..a0eb25e956 100644
--- a/hw/ppc/e500.c
+++ b/hw/ppc/e500.c
@@ -941,7 +941,8 @@ void ppce500_init(MachineState *machine)
         PowerPCCPU *cpu;
         CPUState *cs;
 
-        cpu = POWERPC_CPU(object_new(machine->cpu_type));
+        cpu = POWERPC_CPU(object_new_child(OBJECT(machine), "cpu[*]",
+                                        machine->cpu_type));
         env = &cpu->env;
         cs = CPU(cpu);
 
@@ -956,7 +957,7 @@ void ppce500_init(MachineState *machine)
          */
         object_property_set_bool(OBJECT(cs), "start-powered-off", i != 0,
                                  &error_abort);
-        qdev_realize_and_unref(DEVICE(cs), NULL, &error_fatal);
+        qdev_realize(DEVICE(cs), NULL, &error_fatal);
 
         if (!firstenv) {
             firstenv = env;
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 9b6b5e7257..e6c1b7f0b1 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2776,7 +2776,8 @@ static void spapr_init_cpus(SpaprMachineState *spapr)
         }
 
         if (i < boot_cores_nr) {
-            Object *core  = object_new(type);
+            Object *core  = object_new_child(OBJECT(spapr), "cpu-core[*]",
+                                        type);
             int nr_threads = smp_threads;
 
             /* Handle the partially filled core for older machine types */
@@ -2790,7 +2791,6 @@ static void spapr_init_cpus(SpaprMachineState *spapr)
                                     &error_fatal);
             qdev_realize(DEVICE(core), NULL, &error_fatal);
 
-            object_unref(core);
         }
     }
 }
diff --git a/hw/riscv/cps.c b/hw/riscv/cps.c
index b6b30e05e1..2bf506b61a 100644
--- a/hw/riscv/cps.c
+++ b/hw/riscv/cps.c
@@ -63,13 +63,14 @@ static void riscv_cps_realize(DeviceState *dev, Error **errp)
     int harts_in_cluster = s->num_hart * s->num_core;
     int num_of_clusters = s->num_vp / harts_in_cluster;
     for (i = 0; i < s->num_vp; i++) {
-        cpu = RISCV_CPU(object_new(s->cpu_type));
+        cpu = RISCV_CPU(object_new_child(OBJECT(s), "cpu[*]",
+                                        s->cpu_type));
 
         /* All VPs are halted on reset. Leave powering up to CPC. */
         object_property_set_bool(OBJECT(cpu), "start-powered-off", true,
                                  &error_abort);
 
-        if (!qdev_realize_and_unref(DEVICE(cpu), NULL, errp)) {
+        if (!qdev_realize(DEVICE(cpu), NULL, errp)) {
             return;
         }
 
diff --git a/hw/riscv/microblaze-v-generic.c b/hw/riscv/microblaze-v-generic.c
index 0a83932405..f97ce402e6 100644
--- a/hw/riscv/microblaze-v-generic.c
+++ b/hw/riscv/microblaze-v-generic.c
@@ -65,7 +65,8 @@ static void mb_v_generic_init(MachineState *machine)
     qemu_irq irq[32];
     MemoryRegion *sysmem = get_system_memory();
 
-    cpu = RISCV_CPU(object_new(machine->cpu_type));
+    cpu = RISCV_CPU(object_new_child(OBJECT(machine), "cpu[0]",
+                                        machine->cpu_type));
     object_property_set_bool(OBJECT(cpu), "h", false, NULL);
     object_property_set_bool(OBJECT(cpu), "d", false, NULL);
     qdev_realize(DEVICE(cpu), NULL, &error_abort);
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 037cb6eb5e..0625d4a8df 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -56,20 +56,18 @@ static Error *pv_mig_blocker;
 static S390CPU *s390x_new_cpu(const char *typename, uint32_t core_id,
                               Error **errp)
 {
-    S390CPU *cpu = S390_CPU(object_new(typename));
-    S390CPU *ret = NULL;
+    S390CPU *cpu = S390_CPU(object_new_child(qdev_get_machine(), "cpu[*]",
+                                        typename));
 
     if (!object_property_set_int(OBJECT(cpu), "core-id", core_id, errp)) {
-        goto out;
+        object_unparent(OBJECT(cpu));
+        return NULL;
     }
     if (!qdev_realize(DEVICE(cpu), NULL, errp)) {
-        goto out;
+        object_unparent(OBJECT(cpu));
+        return NULL;
     }
-    ret = cpu;
-
-out:
-    object_unref(OBJECT(cpu));
-    return ret;
+    return cpu;
 }
 
 static void s390_init_cpus(MachineState *machine)
diff --git a/hw/sparc/leon3.c b/hw/sparc/leon3.c
index f9ef2758e1..a2781bcc32 100644
--- a/hw/sparc/leon3.c
+++ b/hw/sparc/leon3.c
@@ -278,7 +278,8 @@ static void leon3_generic_hw_init(MachineState *machine)
 
     for (i = 0; i < machine->smp.cpus; i++) {
         /* Init CPU */
-        cpu = SPARC_CPU(object_new(machine->cpu_type));
+        cpu = SPARC_CPU(object_new_child(OBJECT(machine), "cpu[*]",
+                                        machine->cpu_type));
         qdev_init_gpio_in_named(DEVICE(cpu), leon3_start_cpu, "start_cpu", 1);
         qdev_init_gpio_in_named(DEVICE(cpu), leon3_set_pil_in, "pil", 1);
         qdev_realize(DEVICE(cpu), NULL, &error_fatal);
diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
index 51f5468a02..1ae9d834ca 100644
--- a/hw/sparc/sun4m.c
+++ b/hw/sparc/sun4m.c
@@ -787,7 +787,8 @@ static DeviceState *cpu_devinit(const char *cpu_type, unsigned int id,
     CPUSPARCState *env;
     DeviceState *cpudev;
 
-    cpu = SPARC_CPU(object_new(cpu_type));
+    cpu = SPARC_CPU(object_new_child(qdev_get_machine(), "cpu[*]",
+                                        cpu_type));
     env = &cpu->env;
     cpudev = DEVICE(cpu);
 
@@ -795,7 +796,7 @@ static DeviceState *cpu_devinit(const char *cpu_type, unsigned int id,
     object_property_set_bool(OBJECT(cpu), "start-powered-off", id != 0,
                              &error_abort);
     qdev_init_gpio_in_named(cpudev, cpu_set_irq, "pil", MAX_PILS);
-    qdev_realize_and_unref(cpudev, NULL, &error_fatal);
+    qdev_realize(cpudev, NULL, &error_fatal);
     cpu_sparc_set_id(env, id);
     env->prom_addr = prom_addr;
     return cpudev;
diff --git a/hw/sparc64/sparc64.c b/hw/sparc64/sparc64.c
index 16f4aa052b..9092c4193e 100644
--- a/hw/sparc64/sparc64.c
+++ b/hw/sparc64/sparc64.c
@@ -272,7 +272,8 @@ SPARCCPU *sparc64_cpu_devinit(const char *cpu_type, uint64_t prom_addr)
     uint32_t  stick_frequency = 100 * 1000000;
     uint32_t hstick_frequency = 100 * 1000000;
 
-    cpu = SPARC_CPU(object_new(cpu_type));
+    cpu = SPARC_CPU(object_new_child(qdev_get_machine(), "cpu[0]",
+                                        cpu_type));
     qdev_init_gpio_in_named(DEVICE(cpu), sparc64_cpu_set_ivec_irq,
                             "ivec-irq", IVEC_MAX);
     qdev_realize(DEVICE(cpu), NULL, &error_fatal);
-- 
2.47.1


