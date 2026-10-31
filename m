Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB9C606A31E
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Oct 2026 08:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmx.de header.i=deller@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=fVbk0m+B
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xN4TM-0001sw-VU; Sat, 31 Oct 2026 04:29:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1xN4Sc-0001kz-QF
 for qemu-devel@nongnu.org; Sat, 31 Oct 2026 04:29:10 -0400
Received: from mout.gmx.net ([212.227.17.22])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1xN4SY-0001tP-Pd
 for qemu-devel@nongnu.org; Sat, 31 Oct 2026 04:29:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1793435344; x=1794040144; i=deller@gmx.de;
 bh=Dw3LFXM0YgxvGWIPZNyqdOMim8Mx0acSGBmMO99krzk=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
 References:MIME-Version:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=fVbk0m+B5UNAb5XGipCgwf5NEAuavCEMyiZz1cV2b9s05AXEpGHLB607ZfTe21PJ
 D6T+1GsY9UGGwC9hsWHadGmf8Joc+90iW8Tou7xes5nXMjsZyLTm5cnknNKA5T4v0
 iznp5Fi7s7sF6x+WEXXNioWB1TdJEd5Lm8Tm+pN8svDpHQLg9BrwZHv4TLwvLh+TF
 5PksIyty2WzJcFnGxm3y9SBGtQ9+//C93EtyxErCGx2bPacWulNhpO1b8VHoYgwaK
 XuqFL1V0GutSJTBuvEaMbhi9DTZ8hU7xAeOtEvLSzkFvMR97nVE8dSVvJc9OK8fkB
 /ut4zO04ejzuwT9Qzg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mlw3X-1wfAw71OU7-00cOWM; Sat, 31
 Oct 2026 09:29:04 +0100
From: Helge Deller <deller@gmx.de>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>, Fabiano Rosas <farosas@suse.de>,
 "Kirill A . Korinsky" <kirill@korins.ky>,
 Keith Monahan <keith@techtravels.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL v3 10/10] target/hppa: Map CPUs at same addresses as on
 physical machines
Date: Sat, 31 Oct 2026 09:28:50 +0100
Message-ID: <20261031082850.439293-11-deller@gmx.de>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261031082850.439293-1-deller@gmx.de>
References: <20261031082850.439293-1-deller@gmx.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Csc+kIhQGsPL7zIwfs6ChBEJ43WN2hEeyWmYJJyGMjuZKvTesVO
 iMvrFGJ0xGvq0K1Uta28loimq7zFvy1EPjrflRmvMG1dx7KSHez9htNXXafk887o6Xo0kiL
 p7sY0anOQkO2qlKy7NSNd2vpJ+0riiSEAgzqUqojMWbozTdBoB6B8V0kZmKZQBGn/YVmc1E
 LcJf7q3edq2k/eNWAzHVw==
UI-OutboundReport: notjunk:1;M01:P0:8LbfAlIdjwg=;E4iGne1UCoPnQulkDXFtMsw33hA
 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
 4457Az9cIPN4+lvZF5g==
Received-SPF: pass client-ip=212.227.17.22; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

SeaBIOS version 27 allows to use random addresses for CPU_HPA, so drop
the hardcoded CPU_HPA which was used until now for all machines, and use
individual addresses which correspond to the CPU HPA on the physical
machines.

Signed-off-by: Helge Deller <deller@gmx.de>
=2D--
 hw/hppa/machine.c | 23 +++++++++++++----------
 target/hppa/cpu.h |  1 +
 2 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index e403ae5fc9..f23936fc5b 100644
=2D-- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -241,11 +241,11 @@ static FWCfgState *create_fw_cfg(MachineState *ms, P=
CIBus *pci_bus,
     fw_cfg_add_file(fw_cfg, "/etc/hppa/power-button-addr",
                     g_memdup2(&val, sizeof(val)), sizeof(val));
=20
-    val =3D cpu_to_le64(CPU_HPA + 16);
+    val =3D cpu_to_le64(cpu[0]->env.cpu_hpa + 16);
     fw_cfg_add_file(fw_cfg, "/etc/hppa/rtc-addr",
                     g_memdup2(&val, sizeof(val)), sizeof(val));
=20
-    val =3D cpu_to_le64(CPU_HPA + 24);
+    val =3D cpu_to_le64(cpu[0]->env.cpu_hpa + 24);
     fw_cfg_add_file(fw_cfg, "/etc/hppa/DebugOutputPort",
                     g_memdup2(&val, sizeof(val)), sizeof(val));
=20
@@ -286,7 +286,8 @@ static DinoState *dino_init(MemoryRegion *addr_space)
 /*
  * Step 1: Create CPUs and Memory
  */
-static TranslateFn *machine_HP_common_init_cpus(MachineState *machine)
+static TranslateFn *machine_HP_common_init_cpus(MachineState *machine,
+                        target_ulong initial_cpu_hpa)
 {
     MemoryRegion *addr_space =3D get_system_memory();
     unsigned int smp_cpus =3D machine->smp.cpus;
@@ -299,6 +300,7 @@ static TranslateFn *machine_HP_common_init_cpus(Machin=
eState *machine)
     /* Create CPUs.  */
     for (unsigned int i =3D 0; i < smp_cpus; i++) {
         cpu[i] =3D HPPA_CPU(cpu_create(machine->cpu_type));
+        cpu[i]->env.cpu_hpa =3D initial_cpu_hpa + i * 0x1000;
     }
=20
     /* Initialize memory */
@@ -321,7 +323,7 @@ static TranslateFn *machine_HP_common_init_cpus(Machin=
eState *machine)
         memory_region_init_io(cpu_region, OBJECT(cpu[i]), &hppa_io_eir_op=
s,
                               cpu[i], name, 4);
         memory_region_add_subregion(addr_space,
-                                    translate(NULL, CPU_HPA + i * 0x1000)=
,
+                                    translate(NULL, cpu[i]->env.cpu_hpa),
                                     cpu_region);
=20
         if (!hppa_is_pa20(&cpu[0]->env)) {
@@ -339,7 +341,7 @@ static TranslateFn *machine_HP_common_init_cpus(Machin=
eState *machine)
         memory_region_init_io(cflush, NULL, &hppa_pci_ignore_ops,
                               NULL, cflush_name, 4);
         memory_region_add_subregion(addr_space,
-                              translate(NULL, CPU_HPA + i * 0x1000 + 0x50=
0),
+                              translate(NULL, cpu[i]->env.cpu_hpa + 0x500=
),
                               cflush);
     }
=20
@@ -347,7 +349,8 @@ static TranslateFn *machine_HP_common_init_cpus(Machin=
eState *machine)
     cpu_region =3D g_new(MemoryRegion, 1);
     memory_region_init_io(cpu_region, OBJECT(cpu[0]), &hppa_io_helper_ops=
,
                           cpu[0], "cpu0-io-rtc", 2 * sizeof(uint64_t));
-    memory_region_add_subregion(addr_space, translate(NULL, CPU_HPA + 16)=
,
+    memory_region_add_subregion(addr_space,
+                                translate(NULL, cpu[0]->env.cpu_hpa + 16)=
,
                                 cpu_region);
=20
     /* Main memory region. */
@@ -626,7 +629,7 @@ static void machine_HP_715_init(MachineState *machine)
     ISABus *isa_bus;
=20
     /* Create CPUs and RAM.  */
-    translate =3D machine_HP_common_init_cpus(machine);
+    translate =3D machine_HP_common_init_cpus(machine, 0xfffbe000);
=20
     if (hppa_is_pa20(&cpu[0]->env)) {
         error_report("The HP 715/64 workstation requires a 32-bit "
@@ -713,7 +716,7 @@ static void machine_HP_B160L_init(MachineState *machin=
e)
     PCIBus *pci_bus;
=20
     /* Create CPUs and RAM.  */
-    translate =3D machine_HP_common_init_cpus(machine);
+    translate =3D machine_HP_common_init_cpus(machine, 0xfff10000);
=20
     if (hppa_is_pa20(&cpu[0]->env)) {
         error_report("The HP B160L workstation requires a 32-bit "
@@ -810,7 +813,7 @@ static void machine_HP_C3700_init(MachineState *machin=
e)
     bool is_C3700 =3D strcmp(mc->name, "C3700") =3D=3D 0;
=20
     /* Create CPUs and RAM.  */
-    translate =3D machine_HP_common_init_cpus(machine);
+    translate =3D machine_HP_common_init_cpus(machine, 0xfffa0000);
=20
     if (!hppa_is_pa20(&cpu[0]->env)) {
         error_report("The HP C3000 workstation requires a 64-bit CPU. "
@@ -893,7 +896,7 @@ static void hppa_machine_reset(MachineState *ms, Reset=
Type type)
         cpu[i]->env.psw =3D PSW_Q;
         /* Firmware uses FP registers before configuring CCR. */
         cpu[i]->env.cr[CR_SCRCCR] =3D 0xc0;
-        cpu[i]->env.gr[5] =3D CPU_HPA + i * 0x1000;
+        cpu[i]->env.gr[5] =3D cpu[i]->env.cpu_hpa;
     }
=20
     /*
diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index da48a78569..7b708a564b 100644
=2D-- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -272,6 +272,7 @@ typedef struct CPUArchState {
     /* Fields up to this point are cleared by a CPU reset */
     struct {} end_reset_fields;
=20
+    target_ulong cpu_hpa;      /* HPA of this CPU */
     target_ulong kernel_entry; /* Linux kernel was loaded here */
     target_ulong cmdline_or_bootorder;
     target_ulong initrd_base, initrd_end;
=2D-=20
2.56.0


