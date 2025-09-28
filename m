Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14701CAC5BB
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Sep 2025 19:32:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v2x3T-0002yz-EZ; Sun, 28 Sep 2025 15:27:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1v2x3N-0002qH-C7
 for qemu-devel@nongnu.org; Sun, 28 Sep 2025 15:27:25 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1v2x37-00045r-2t
 for qemu-devel@nongnu.org; Sun, 28 Sep 2025 15:27:24 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58S5UOR2020699;
 Sun, 28 Sep 2025 19:27:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=wjNq/I
 RCuMTddhUx3gl5H5/zbKgdgxQEuTawZmka1yU=; b=XT8yhYl2pCzvtBJELcwmQB
 UsPFxjLK4crwx0oXJbn9xFmAuQvBq5fzff/lcaKmz8QVpKyMoaP0Gv4gr+U2mzwP
 HS59RhshW7re3Kr08IycmPbQwRDKRcl2OeixixFnQ1n2K6nfBnF3xUHzm4xCcYdg
 leRfzlOkaagjaHD2Jo6rMG5iAEeaOy3v1kmkCP70zX63WohS7jq/yTwrHpGvDo6R
 GihcGlb7lrSJ873Z92ds2Q9ceD0zRUxP9XK3lXZNNoFUp50vfplWVSFt+lPrzCK4
 260e1L5FSTafyvW2r8KBgygefChwYGoOka6yZBdO1mipHWQxUnLVO+ODujvI5rtw
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49e7jw6eue-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 28 Sep 2025 19:27:05 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58SH1Qxs020057;
 Sun, 28 Sep 2025 19:27:04 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 49et8ru1cj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 28 Sep 2025 19:27:04 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 58SJR0bZ35848572
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 28 Sep 2025 19:27:01 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DDFED20049;
 Sun, 28 Sep 2025 19:27:00 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DB82520040;
 Sun, 28 Sep 2025 19:26:59 +0000 (GMT)
Received: from li-1901474c-32f3-11b2-a85c-fc5ff2c001f3.ibm.com.com (unknown
 [9.39.17.115]) by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Sun, 28 Sep 2025 19:26:59 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: Glenn Miles <milesg@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 16/27] hw/ppc: Add a test machine for the IBM PPE42 CPU
Date: Mon, 29 Sep 2025 00:56:18 +0530
Message-ID: <20250928192629.139822-17-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250928192629.139822-1-harshpb@linux.ibm.com>
References: <20250928192629.139822-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAyNSBTYWx0ZWRfX7JPFYs3x5mV8
 qknKZgascR00VCPR4qCtYPJWPDC4Jq2YvRJFJTcfRJqrU3+F7ET4j9jFRlLgXhOCbLlJvWPsDBn
 6FBS7Smu2pZpgSUtN4AjvxLpCXw0kB8s5SEllxzKvrduJg8N8h/2Y2WPx/yDlRqGglfDkVws62r
 E31RrYm1nxpJHOZQQd09+mQqwpWDjZTecCZvgbXL6j9+xZ+xj2pz3EvESwKEIs0zVt8TcLex9KS
 1S8GposXfmi/0WH8rBJn24t0S+rEVPQ61mqQywaDoUHmUxEwoKCeqB2GDKnBO2fWLVkUPHBtQWr
 0UeKAvwn+nR5qMJyN3ii/RHy/Fmy7jbimd+UXy0cLXHK68VgOD/RJqvM28EzNt16bt3FQxu3TKe
 RGDHnnbbXWNTFaL0t7gqZ0XmtQaB+A==
X-Proofpoint-ORIG-GUID: 0x8dhZWehSjWMLNCLEzLgK2YvKBnlTDb
X-Proofpoint-GUID: 0x8dhZWehSjWMLNCLEzLgK2YvKBnlTDb
X-Authority-Analysis: v=2.4 cv=GdUaXAXL c=1 sm=1 tr=0 ts=68d98c09 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=f7IdgyKtn90A:10 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8 a=69wJf7TsAAAA:8 a=up-X0YpDAAAA:8
 a=baEZFeJ_IEPpxCD2sBgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=Fg1AiH1G6rFz08G2ETeA:22 a=86FmjZgct7XXK6GGpxvI:22 a=oH34dK2VZjykjzsv8OSz:22
 a=pHzHmUro8NiASowvMSCR:22 a=n87TN5wuljxrRezIQYnT:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-28_08,2025-09-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 phishscore=0 adultscore=0 priorityscore=1501
 malwarescore=0 spamscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270025
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
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

From: Glenn Miles <milesg@linux.ibm.com>

Adds a test machine for the IBM PPE42 processor, including a
DEC, FIT, WDT and 512 KiB of ram.

The purpose of this machine is only to provide a generic platform
for testing instructions of the recently  added PPE42 processor
model which is used extensively in the IBM Power9, Power10 and
future Power server processors.

Signed-off-by: Glenn Miles <milesg@linux.ibm.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Link: https://lore.kernel.org/r/20250925201758.652077-9-milesg@linux.ibm.com
Message-ID: <20250925201758.652077-9-milesg@linux.ibm.com>
---
 MAINTAINERS            |   6 +++
 hw/ppc/ppe42_machine.c | 101 +++++++++++++++++++++++++++++++++++++++++
 hw/ppc/Kconfig         |   5 ++
 hw/ppc/meson.build     |   2 +
 4 files changed, 114 insertions(+)
 create mode 100644 hw/ppc/ppe42_machine.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 7d134a85e6..2ed9eb9353 100644
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
diff --git a/hw/ppc/ppe42_machine.c b/hw/ppc/ppe42_machine.c
new file mode 100644
index 0000000000..f14a91b4e4
--- /dev/null
+++ b/hw/ppc/ppe42_machine.c
@@ -0,0 +1,101 @@
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
-- 
2.43.5


