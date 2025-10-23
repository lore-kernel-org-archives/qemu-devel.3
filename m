Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77733CCD1BC
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 11:45:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBtks-000239-Nw; Thu, 23 Oct 2025 07:45:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vBtkq-0001t2-KD
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 07:45:16 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vBtkn-0001ds-WC
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 07:45:16 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59N9VQmp015962;
 Thu, 23 Oct 2025 11:45:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=f4ju6t
 nbA9LleG/LPghMVR1nyMC4C0tekWOoHQ2wu7Y=; b=Kv0K/khMjh0UXKa37HmR4Q
 NQmetAjx7nuPblXgYWf0abNddzyS3tfLHhjLj2A4Yv7L3H1Zs5GNjrE7HCc5FnsW
 4NPl0BL79No8U5S/cLeYMc4jUYf4Zevw3+nuqCOTB/Hgb8pA2BJAaYuAa3/LwgJq
 iGNniqCVnalFMkyXZtgpPPzfkbl8V3cGjgcLuqfEnlQWk6RkVrfGUfHc/fAZ3/XB
 WZV57cyVL4OhXgE7A2Y3foNEVHxGuEO1ub8OZaFBZ7e8X5GONzd1cJlbDwEccMuy
 36nBh6iyxwpmlGP+Lv7DDRfTx9kw9R4e5K2PfFWj1CplzRrK0Ci5ntk3JvEhCI+A
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v3271wcs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Oct 2025 11:44:59 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59NA6V7n032166;
 Thu, 23 Oct 2025 11:44:58 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49vp7n5eqf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Oct 2025 11:44:58 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59NBiuFr26083736
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 23 Oct 2025 11:44:56 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 786DB20049;
 Thu, 23 Oct 2025 11:44:56 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 968DF20040;
 Thu, 23 Oct 2025 11:44:55 +0000 (GMT)
Received: from li-1901474c-32f3-11b2-a85c-fc5ff2c001f3.ibm.com.com (unknown
 [9.124.221.73]) by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 23 Oct 2025 11:44:55 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 22/32] hw/ppc/pegasos2: Add bus frequency to machine state
Date: Thu, 23 Oct 2025 17:14:09 +0530
Message-ID: <20251023114422.3675018-23-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20251023114422.3675018-1-harshpb@linux.ibm.com>
References: <20251023114422.3675018-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=EJELElZC c=1 sm=1 tr=0 ts=68fa153b cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=f7IdgyKtn90A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=VnNF1IyMAAAA:8
 a=djEQ4dHztmMVuQhaAQsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22 a=oH34dK2VZjykjzsv8OSz:22 a=pHzHmUro8NiASowvMSCR:22
 a=n87TN5wuljxrRezIQYnT:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfXx+dFAVOwHKfR
 NZRjPyuSFJfX9zUcj7jnK2MWpanW2LBp8y9RRzpiSbqfsGb8UGrdr/dbpn7+9GPF4Br1pHRUsmJ
 YuIwKJQFoPXNW9NWQN3/Bd+hwF/zaZjR6yg4ch1+QmEEajgSIY226O4mECV30WABG6dEIVh05X/
 oad8eevXtCNZdiDqRH0oUicm7h1yrypPmoSfezoPYxkVoy2grMRz54t5sMaIjtdbOkqnA3nNukn
 5sjieC0S13RkmTptj1dJwYWJRnqHOfYK5HEEVIZyDbgVCGfc6x7urWolh1m+KUhvOxCjo175Cmx
 kQgzBn2zJ4qc3/YnRdv81DWVyzFiHeH8SM/wvlKQPvAuBBc91xydmc0ItYho2SuP+Z+fWgtdFaP
 gJAhBXRMV4Z98Hk5kEShbfaLSHmRAQ==
X-Proofpoint-GUID: nNEmX0vyE6csLMjZa0myAKjbYB_KYoYZ
X-Proofpoint-ORIG-GUID: nNEmX0vyE6csLMjZa0myAKjbYB_KYoYZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 spamscore=0
 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: BALATON Zoltan <balaton@eik.bme.hu>

Store the bus frequency in the machine state and set it from instance
init method.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Link: https://lore.kernel.org/qemu-devel/b69e21e353b7d7f22a34db5f13443f60f51c7238.1761176219.git.balaton@eik.bme.hu
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
---
 hw/ppc/pegasos2.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/hw/ppc/pegasos2.c b/hw/ppc/pegasos2.c
index f5b56c0e94..7eaefcf9a0 100644
--- a/hw/ppc/pegasos2.c
+++ b/hw/ppc/pegasos2.c
@@ -55,8 +55,6 @@
 #define H_PRIVILEGE  -3  /* Caller not privileged */
 #define H_PARAMETER  -4  /* Parameter invalid, out-of-range or conflicting */
 
-#define BUS_FREQ_HZ 133333333
-
 #define TYPE_PEGASOS_MACHINE MACHINE_TYPE_NAME("pegasos")
 OBJECT_DECLARE_SIMPLE_TYPE(PegasosMachineState, PEGASOS_MACHINE)
 
@@ -66,6 +64,7 @@ struct PegasosMachineState {
     PowerPCCPU *cpu;
     DeviceState *nb; /* north bridge */
     DeviceState *sb; /* south bridge */
+    int bus_freq_hz;
     IRQState pci_irqs[PCI_NUM_PINS];
     OrIRQState orirq[PCI_NUM_PINS];
     qemu_irq mv_pirq[PCI_NUM_PINS];
@@ -135,7 +134,7 @@ static void pegasos2_setup_pci_irq(PegasosMachineState *pm)
                                 qdev_get_gpio_in_named(pm->nb, "gpp", 31));
 }
 
-static void pegasos2_init(MachineState *machine)
+static void pegasos_init(MachineState *machine)
 {
     PegasosMachineState *pm = PEGASOS_MACHINE(machine);
     CPUPPCState *env;
@@ -158,7 +157,7 @@ static void pegasos2_init(MachineState *machine)
     }
 
     /* Set time-base frequency */
-    cpu_ppc_tb_init(env, BUS_FREQ_HZ / 4);
+    cpu_ppc_tb_init(env, pm->bus_freq_hz / 4);
     qemu_register_reset(pegasos2_cpu_reset, pm->cpu);
 
     /* RAM */
@@ -610,7 +609,7 @@ static void pegasos2_machine_class_init(ObjectClass *oc, const void *data)
     VofMachineIfClass *vmc = VOF_MACHINE_CLASS(oc);
 
     mc->desc = "Genesi/bPlan Pegasos II";
-    mc->init = pegasos2_init;
+    mc->init = pegasos_init;
     mc->reset = pegasos2_machine_reset;
     mc->block_default_type = IF_IDE;
     mc->default_boot_order = "cd";
@@ -629,6 +628,13 @@ static void pegasos2_machine_class_init(ObjectClass *oc, const void *data)
     vmc->setprop = pegasos2_setprop;
 }
 
+static void pegasos2_init(Object *obj)
+{
+    PegasosMachineState *pm = PEGASOS_MACHINE(obj);
+
+    pm->bus_freq_hz = 133333333;
+}
+
 static const TypeInfo pegasos_machine_types[] = {
     {
         .name          = TYPE_PEGASOS_MACHINE,
@@ -645,6 +651,7 @@ static const TypeInfo pegasos_machine_types[] = {
         .name          = MACHINE_TYPE_NAME("pegasos2"),
         .parent        = TYPE_PEGASOS_MACHINE,
         .class_init    = pegasos2_machine_class_init,
+        .instance_init = pegasos2_init,
     },
 };
 
@@ -777,7 +784,7 @@ static void add_pci_device(PCIBus *bus, PCIDevice *d, void *opaque)
     g_string_free(node, TRUE);
 }
 
-static void add_cpu_info(void *fdt, PowerPCCPU *cpu)
+static void add_cpu_info(void *fdt, PowerPCCPU *cpu, int bus_freq)
 {
     uint32_t cells[2];
 
@@ -824,8 +831,8 @@ static void add_cpu_info(void *fdt, PowerPCCPU *cpu)
     qemu_fdt_setprop_cell(fdt, cp, "reservation-granule-size", 4);
     qemu_fdt_setprop_cell(fdt, cp, "timebase-frequency",
                           cpu->env.tb_env->tb_freq);
-    qemu_fdt_setprop_cell(fdt, cp, "bus-frequency", BUS_FREQ_HZ);
-    qemu_fdt_setprop_cell(fdt, cp, "clock-frequency", BUS_FREQ_HZ * 7.5);
+    qemu_fdt_setprop_cell(fdt, cp, "bus-frequency", bus_freq);
+    qemu_fdt_setprop_cell(fdt, cp, "clock-frequency", bus_freq * 7.5);
     qemu_fdt_setprop_cell(fdt, cp, "cpu-version", cpu->env.spr[SPR_PVR]);
     cells[0] = 0;
     cells[1] = 0;
@@ -860,7 +867,7 @@ static void *pegasos2_build_fdt(PegasosMachineState *pm, int *fdt_size)
     }
     qemu_fdt_setprop_string(fdt, "/", "name", "bplan,Pegasos2");
 
-    add_cpu_info(fdt, pm->cpu);
+    add_cpu_info(fdt, pm->cpu, pm->bus_freq_hz);
 
     fi.fdt = fdt;
     fi.path = "/pci@c0000000";
-- 
2.43.5


