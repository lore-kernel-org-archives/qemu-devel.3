Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EA45CAC5A7
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Sep 2025 18:31:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzJNb-0007QA-BU; Thu, 18 Sep 2025 14:29:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1uzJNB-0007Jg-37; Thu, 18 Sep 2025 14:28:52 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1uzJN0-0006Yh-NI; Thu, 18 Sep 2025 14:28:42 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58IGTJGp027546;
 Thu, 18 Sep 2025 18:28:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=sn4Gkm
 lHzFMgyAWhSQw+xpB9O2ZB6wwRCJkRZ1DmcIQ=; b=faLSQtTcmPYYS+77Qaawn0
 cU769iv6X4/YNIpMwRywJ/1PVeGgY2giYrSTWx12GBEIkDebXh27wCYcPXO+ydiS
 WcqiDcVL4bX0CwaFMzmfXbwMZgVk4gV/LkNBrGyrlsdoOLVm1aPjeiERAgtSXjHI
 KoO9NkefB6QbZ72VTxZOBxc76JiILY94fFdobZVQUD0AuOm1uCqwXNf9mk24X7ef
 zw9Yzn0wshPr0BYXqF7j4NTk/xki1dECM7Np8mIhLsU2Hycy8QNztE5rB51K9sQj
 Glb2nUM2yYvRL11njC45n9XKsrclJ+m8BwRRNaN6oGjZKPVpb7kJJm1h4LYm+GSA
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 497g4pc794-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 Sep 2025 18:28:34 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58IIDKsf008791;
 Thu, 18 Sep 2025 18:28:34 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 497g4pc78y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 Sep 2025 18:28:34 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58IGZFjp029514;
 Thu, 18 Sep 2025 18:28:33 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 495kb18ct2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 Sep 2025 18:28:33 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 58IISWAs6619680
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 18 Sep 2025 18:28:32 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 01BD458060;
 Thu, 18 Sep 2025 18:28:32 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 36ACF5805D;
 Thu, 18 Sep 2025 18:28:31 +0000 (GMT)
Received: from mglenn-KVM.. (unknown [9.10.239.198])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 18 Sep 2025 18:28:31 +0000 (GMT)
From: Glenn Miles <milesg@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: Glenn Miles <milesg@linux.ibm.com>, qemu-ppc@nongnu.org, clg@redhat.com,
 npiggin@gmail.com, harshpb@linux.ibm.com, thuth@redhat.com,
 rathc@linux.ibm.com, richard.henderson@linaro.org
Subject: [PATCH v5 8/9] hw/ppc: Add a test machine for the IBM PPE42 CPU
Date: Thu, 18 Sep 2025 13:27:15 -0500
Message-ID: <20250918182731.528944-9-milesg@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250918182731.528944-1-milesg@linux.ibm.com>
References: <20250918182731.528944-1-milesg@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwNCBTYWx0ZWRfXzJmgj4FbqqQf
 9dfTVsfrrJzu0j8oYz4D9QiJwR0h/skUcg5jb/1ZliqcYmhp5sZYSYu/qsPwjNOBH6lvoz4D+5I
 tbZljkOvp6EjgsJK16LI5K7sXcDhzCChHaVC0RJMyxPwhGlfqh8B/oKmBfYkrThbqqbVN6NSt0w
 1rPQwhtOJ5u6OGbtcfJ0D4P4Y9AVDxXZeppGQEh316394UWKrRhkNhtykyezS3Cpb9Sa6qXuRGE
 l4Na5JPoLO/cNAv8wKv+dYb5M2MxhvayY/kkI52hsUozoprZfQKLbtci/Nm/IYS428VYf4yDu7W
 MI5OtWd30cSzYZr9mDzQE5FUdi7p3DCtyTtgHvxMetdMV41HR8VeciGnD05l2mcZgCqEqjrQTq1
 4ZFxUDxD
X-Proofpoint-ORIG-GUID: QAPrpnlr4twgvdjFsNnwUTjKf2M4jjLC
X-Proofpoint-GUID: Zxp-LI-Jtlr1rdHTTBHVG-XrZmMVQXOd
X-Authority-Analysis: v=2.4 cv=cNzgskeN c=1 sm=1 tr=0 ts=68cc4f52 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8
 a=69wJf7TsAAAA:8 a=up-X0YpDAAAA:8 a=otBICX0EUfEeupRF_54A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=Fg1AiH1G6rFz08G2ETeA:22 a=86FmjZgct7XXK6GGpxvI:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-18_02,2025-09-18_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 spamscore=0 bulkscore=0 malwarescore=0
 adultscore=0 priorityscore=1501 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509160204
Received-SPF: pass client-ip=148.163.156.1; envelope-from=milesg@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Adds a test machine for the IBM PPE42 processor, including a
DEC, FIT, WDT and 512 KiB of ram.

The purpose of this machine is only to provide a generic platform
for testing instructions of the recently  added PPE42 processor
model which is used extensively in the IBM Power9, Power10 and
future Power server processors.

Signed-off-by: Glenn Miles <milesg@linux.ibm.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
---
 MAINTAINERS            |   6 +++
 hw/ppc/Kconfig         |   5 ++
 hw/ppc/meson.build     |   2 +
 hw/ppc/ppe42_machine.c | 102 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 115 insertions(+)
 create mode 100644 hw/ppc/ppe42_machine.c

diff --git a/MAINTAINERS b/MAINTAINERS
index bd417e96f7..6907a87588 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1530,6 +1530,12 @@ F: include/hw/pci-host/grackle.h
 F: pc-bios/qemu_vga.ndrv
 F: tests/functional/ppc/test_mac.py
 
+PPE42
+M: Glenn Miles <milesg@linux.ibm.com>
+L: qemu-ppc@nongnu.org
+S: Odd Fixes
+F: hw/ppc/ppe42_machine.c
+
 PReP
 M: Hervé Poussineau <hpoussin@reactos.org>
 L: qemu-ppc@nongnu.org
diff --git a/hw/ppc/Kconfig b/hw/ppc/Kconfig
index ced6bbc740..7091d72fd8 100644
--- a/hw/ppc/Kconfig
+++ b/hw/ppc/Kconfig
@@ -44,6 +44,11 @@ config POWERNV
     select SSI_M25P80
     select PNV_SPI
 
+config PPC405
+    bool
+    default y
+    depends on PPC
+
 config PPC440
     bool
     default y
diff --git a/hw/ppc/meson.build b/hw/ppc/meson.build
index 9893f8adeb..170b90ae7d 100644
--- a/hw/ppc/meson.build
+++ b/hw/ppc/meson.build
@@ -57,6 +57,8 @@ ppc_ss.add(when: 'CONFIG_POWERNV', if_true: files(
   'pnv_n1_chiplet.c',
 ))
 # PowerPC 4xx boards
+ppc_ss.add(when: 'CONFIG_PPC405', if_true: files(
+  'ppe42_machine.c'))
 ppc_ss.add(when: 'CONFIG_PPC440', if_true: files(
   'ppc440_bamboo.c',
   'ppc440_uc.c'))
diff --git a/hw/ppc/ppe42_machine.c b/hw/ppc/ppe42_machine.c
new file mode 100644
index 0000000000..d7c4a01fb5
--- /dev/null
+++ b/hw/ppc/ppe42_machine.c
@@ -0,0 +1,102 @@
+/*
+ * Test Machine for the IBM PPE42 processor
+ *
+ * Copyright (c) 2025, IBM Corporation.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/units.h"
+#include "qemu/error-report.h"
+#include "system/address-spaces.h"
+#include "hw/boards.h"
+#include "hw/ppc/ppc.h"
+#include "system/system.h"
+#include "system/reset.h"
+#include "system/kvm.h"
+#include "qapi/error.h"
+
+#define TYPE_PPE42_MACHINE MACHINE_TYPE_NAME("ppe42_machine")
+typedef MachineClass Ppe42MachineClass;
+typedef struct Ppe42MachineState Ppe42MachineState;
+DECLARE_OBJ_CHECKERS(Ppe42MachineState, Ppe42MachineClass,
+                     PPE42_MACHINE, TYPE_PPE42_MACHINE)
+
+struct Ppe42MachineState {
+    MachineState parent_obj;
+
+    PowerPCCPU cpu;
+};
+
+static void main_cpu_reset(void *opaque)
+{
+    PowerPCCPU *cpu = opaque;
+
+    cpu_reset(CPU(cpu));
+}
+
+static void ppe42_machine_init(MachineState *machine)
+{
+    Ppe42MachineState *pms = PPE42_MACHINE(machine);
+    PowerPCCPU *cpu = &pms->cpu;
+
+    if (kvm_enabled()) {
+        error_report("machine %s does not support the KVM accelerator",
+                     MACHINE_GET_CLASS(machine)->name);
+        exit(EXIT_FAILURE);
+    }
+    if (machine->ram_size > 512 * KiB) {
+        error_report("RAM size more than 512 KiB is not supported");
+        exit(1);
+    }
+
+    /* init CPU */
+    object_initialize_child(OBJECT(pms), "cpu", cpu, machine->cpu_type);
+    if (!qdev_realize(DEVICE(cpu), NULL, &error_fatal)) {
+        return;
+    }
+
+    qemu_register_reset(main_cpu_reset, cpu);
+
+    /* This sets the decrementer timebase */
+    ppc_booke_timers_init(cpu, 37500000, PPC_TIMER_PPE);
+
+    /* RAM */
+    memory_region_add_subregion(get_system_memory(), 0xfff80000, machine->ram);
+}
+
+
+static void ppe42_machine_class_init(ObjectClass *oc, const void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+    static const char * const valid_cpu_types[] = {
+        POWERPC_CPU_TYPE_NAME("PPE42"),
+        POWERPC_CPU_TYPE_NAME("PPE42X"),
+        POWERPC_CPU_TYPE_NAME("PPE42XM"),
+        NULL,
+    };
+
+    mc->desc = "PPE42 Test Machine";
+    mc->init = ppe42_machine_init;
+    mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("PPE42XM");
+    mc->valid_cpu_types = valid_cpu_types;
+    mc->default_ram_id = "ram";
+    mc->default_ram_size = 512 * KiB;
+}
+
+static const TypeInfo ppe42_machine_info = {
+        .name          = TYPE_PPE42_MACHINE,
+        .parent        = TYPE_MACHINE,
+        .instance_size = sizeof(Ppe42MachineState),
+        .class_init    = ppe42_machine_class_init,
+        .class_size    = sizeof(Ppe42MachineClass),
+};
+
+static void ppe42_machine_register_types(void)
+{
+    type_register_static(&ppe42_machine_info);
+}
+
+type_init(ppe42_machine_register_types);
+
-- 
2.43.0


