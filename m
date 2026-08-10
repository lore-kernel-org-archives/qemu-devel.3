Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08C05C5B572
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2026 19:00:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtVCg-0001Xs-SN; Mon, 10 Aug 2026 14:58:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mikail.sadic@ibm.com>)
 id 1wtVCe-0001WX-U4; Mon, 10 Aug 2026 14:58:28 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mikail.sadic@ibm.com>)
 id 1wtVCc-0003Sk-9K; Mon, 10 Aug 2026 14:58:28 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67AGVfuC2154231; Mon, 10 Aug 2026 18:57:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=sYF/s/U4LgaUiXPbN
 j1yXqxFesF3T/zSzYSIj81WkTA=; b=fznVtr8dFXP9nO4+DK4RgoxJeh8ROOhk6
 RKEoA7uVRLapnZth8dQNd9aM85WwjrImNEhP+LmOoKrCMI/myhV89lNwV04JJeBi
 wMpQUlGS+gCbPi/g6Jd2CjbJaVfV5JH4ZsE4XNl8dytSBZz15w5+za2usREt7yuJ
 93HvzZwgdDEumBNZhdsr1+Ug6WlLAuIqffu8OBW3vJmXuGpUu0IKAI4BMT2FCfIG
 uKslkROqtPTArbX6BQVZJFOfq63kOYBdvBAiqUP1TcLclyBsIwsTrxTyR+WfSuk8
 CmmVNaOyewNec6Yk6dLJvL5EkWxiYViA1TKt4kPbpOcj5hxbDAvMQ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvm9hngn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 10 Aug 2026 18:57:55 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67AIuL6c019212;
 Mon, 10 Aug 2026 18:57:54 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxg9gx00n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 10 Aug 2026 18:57:54 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67AIvrdR22217466
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 10 Aug 2026 18:57:53 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DD3F35805E;
 Mon, 10 Aug 2026 18:57:52 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2F35258051;
 Mon, 10 Aug 2026 18:57:52 +0000 (GMT)
Received: from IBM-MFS.ibm.com (unknown [9.61.24.176])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 10 Aug 2026 18:57:52 +0000 (GMT)
From: Mikail Sadic <mikail.sadic@ibm.com>
To: clg@kaod.org, peter.maydell@linaro.org
Cc: Mikail Sadic <mikail.sadic@ibm.com>, pbonzini@redhat.com,
 ninad@linux.ibm.com, titusr@google.com, jeuk20.kim@samsung.com,
 philmd@mailo.com, steven_lee@aspeedtech.com, leetroy@gmail.com,
 jamin_lin@aspeedtech.com, kane_chen@aspeedtech.com,
 andrew@codeconstruct.com.au, joel@jms.id.au, calebs@linux.ibm.com,
 milesg@linux.ibm.com, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH v3 2/8] fsi/cfam: Add CFAM-S model
Date: Mon, 10 Aug 2026 13:57:40 -0500
Message-ID: <20260810185748.1253-3-mikail.sadic@ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260810185748.1253-1-mikail.sadic@ibm.com>
References: <20260810185748.1253-1-mikail.sadic@ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDE1OCBTYWx0ZWRfX3ItgxrhfK1n7
 czdZI9Wz0IGO09RG0YbKHM1eUb/LHBE6D3gRymlv+1OzqUPYD2GSjAdlNjo6NCuvGtYMAfvKoLJ
 lsPO+tD+SGxpm30Jj2nzpXeVLLTUyIC8bLi57NA5k0bcVDrtesIkwTHngHog+0y0ZDj7SiIZEft
 TWg7/stDXoaX4DvIVGKbkNLw5taISGGyMtf7ASRu/F9F9la7Raza037lMl7vKiTXDhsjI3i1Iar
 MK/3zr8fIv05GQNd+Zrxypv89hldhELNUran8AIqsahhVabCvGDbJciau7vHtAAjOc9DIvWl7LV
 KNVIxxAqyhH/ZT+GE4KsZGecymSqGc3Beqt9OMCcB2bIRehOHCJAO4TWJDAyLzFuvtMrQpOnJtj
 Ju+fEXjIkHTpMxCfxQH+wx8Figb3bm4prFRZk8YxvCGVVBzJqVnev5DM85KxhRhWOmM/7yqLRRt
 4h8E3Q5wm22L2+zFPjQ==
X-Proofpoint-ORIG-GUID: aP_OFh-TPG5Rhov69IisQKd0TiM6u1zA
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDE1OCBTYWx0ZWRfXzHlQax9PVAKQ
 V/JdKST890/ILnd/sER8PKqwWD29w5dz93fbf5dNk0ye5s8CPV+gjB/ZaF0iyOP4f24ICjW7TGT
 94EHeg0EJRj1/b46uBA4+YMmbxvN1g4=
X-Authority-Analysis: v=2.4 cv=IfK3n2qa c=1 sm=1 tr=0 ts=6a7a1f34 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=NEAV23lmAAAA:8 a=VnNF1IyMAAAA:8
 a=GLtLAL1jAtWljCBMQDYA:9
X-Proofpoint-GUID: zGXiNsGtnctVRx7JBsbEtKLsIKVbBcQR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_04,2026-08-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608100158
Received-SPF: pass client-ip=148.163.156.1; envelope-from=mikail.sadic@ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add TYPE_FSI_CFAM_S, derivative of CFAM, as a second type on the common
CFAM base class. The base class builds the register slot, the config
table region, the FSI responder and the local bus, so the CFAM-S supplies
only its config table (chip ID with major 9, an FSI responder and a v1
mailbox), its slot offsets and the mailbox engine. Its realize chains the
base one and adds the one thing that is new: the slot is aliased across
the four slave-ID views, so enumeration and normal access reach the same
registers.

The v1 mailbox is a local bus engine added in lbus.c next to the
scratchpad which the CFAM-S just instantiates.

Sharing the base config table implementation means the CFAM-S also
honors the SID_BREAK sequence and word-only config access.

FSIMasterState gains a cfam_s field. fsi_master_init() creates both the
cfam and cfam-s children, realize hooks them into the OPB-to-FSI aperture.

Signed-off-by: Mikail Sadic <mikail.sadic@ibm.com>
---
 docs/specs/fsi.rst          | 15 ++++++
 include/hw/fsi/cfam-s.h     | 40 ++++++++++++++++
 include/hw/fsi/cfam.h       | 10 ++++
 include/hw/fsi/fsi-master.h |  2 +
 include/hw/fsi/lbus.h       | 11 +++++
 hw/fsi/cfam-s.c             | 91 +++++++++++++++++++++++++++++++++++++
 hw/fsi/fsi-master.c         |  7 +++
 hw/fsi/lbus.c               | 69 ++++++++++++++++++++++++++++
 hw/fsi/meson.build          |  2 +-
 hw/fsi/trace-events         |  2 +
 10 files changed, 248 insertions(+), 1 deletion(-)
 create mode 100644 include/hw/fsi/cfam-s.h
 create mode 100644 hw/fsi/cfam-s.c

diff --git a/docs/specs/fsi.rst b/docs/specs/fsi.rst
index f7d86d3e37..fb7a3669ef 100644
--- a/docs/specs/fsi.rst
+++ b/docs/specs/fsi.rst
@@ -120,3 +120,18 @@ from the BMC. (see the `pdbg source repository`_ for more details)
 
 .. _pdbg source repository:
    https://github.com/open-power/pdbg
+
+CFAM-S model
+------------
+
+The CFAM-S is a derivative of the CFAM. Both are modelled on a common CFAM
+model that builds the register slot, the configuration table, the FSI
+responder and the local bus; each supplies its own configuration table, slot
+layout and engines. The CFAM-S supports a limited set of engines: an FSI
+responder and a version 1 mailbox.
+
+The configuration table advertises the responder and the mailbox engines.
+The responder is backed by the FSI slave control registers; the mailbox
+provides a small block of scratch registers. The register block is exposed
+through each slave-ID view so that enumeration and normal access reach the
+same registers.
diff --git a/include/hw/fsi/cfam-s.h b/include/hw/fsi/cfam-s.h
new file mode 100644
index 0000000000..041607d5ce
--- /dev/null
+++ b/include/hw/fsi/cfam-s.h
@@ -0,0 +1,40 @@
+/*
+ * IBM Common FRU Access Macro - S variant (CFAM-S)
+ *
+ * Copyright (C) 2026 IBM Corp.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#ifndef FSI_CFAM_S_H
+#define FSI_CFAM_S_H
+
+#include "system/memory.h"
+#include "hw/fsi/cfam.h"
+#include "hw/fsi/fsi.h"
+#include "hw/fsi/lbus.h"
+
+#define TYPE_FSI_CFAM_S "cfam-s"
+OBJECT_DECLARE_TYPE(FSICFAMS, FSICFAMSClass, FSI_CFAM_S)
+
+/* The register slot is visible in each of the four slave-ID views */
+#define CFAM_S_WINDOW_SIZE (4 * FSI_CFAM_SLOT_SIZE)
+
+struct FSICFAMS {
+    /* < private > */
+    FSICFAMCommon parent;
+
+    /* parent.mr aliased across the slave-ID views */
+    MemoryRegion window;
+    MemoryRegion slot_alias[3];
+
+    FSIMbox mbox;
+};
+
+struct FSICFAMSClass {
+    /* < private > */
+    FSICFAMCommonClass parent_class;
+
+    DeviceRealize parent_realize;
+};
+
+#endif /* FSI_CFAM_S_H */
diff --git a/include/hw/fsi/cfam.h b/include/hw/fsi/cfam.h
index bdf579b4fe..a9cd7b7f63 100644
--- a/include/hw/fsi/cfam.h
+++ b/include/hw/fsi/cfam.h
@@ -35,6 +35,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(FSICFAM, FSI_CFAM)
 #define ENGINE_CONFIG_TYPE_PEEK       (0x02 << 4)
 #define ENGINE_CONFIG_TYPE_FSI        (0x03 << 4)
 #define ENGINE_CONFIG_TYPE_SCRATCHPAD (0x06 << 4)
+#define ENGINE_CONFIG_TYPE_MBOX_V1    (0x14 << 4)
 
 /* Valid, slots, version, type, crc */
 #define CFAM_CONFIG_REG(__VER, __TYPE, __CRC)   \
@@ -44,6 +45,15 @@ OBJECT_DECLARE_SIMPLE_TYPE(FSICFAM, FSI_CFAM)
      (__TYPE)                 |   \
      (__CRC))
 
+/* As above, for the last entry in a table: NEXT is clear */
+#define CFAM_CONFIG_LAST(__VER, __TYPE, __CRC)  \
+    (0x00010000               |   \
+     (__VER)                  |   \
+     (__TYPE)                 |   \
+     (__CRC))
+
+#define CFAM_CONFIG_CHIP_ID_MAJOR(__MAJOR) (((__MAJOR) & 0xf) << 8)
+
 struct FSICFAMCommon {
     /* < private > */
     FSISlaveState parent;
diff --git a/include/hw/fsi/fsi-master.h b/include/hw/fsi/fsi-master.h
index 87c11ec3dc..dc51c96840 100644
--- a/include/hw/fsi/fsi-master.h
+++ b/include/hw/fsi/fsi-master.h
@@ -11,6 +11,7 @@
 #include "hw/core/qdev.h"
 #include "hw/fsi/fsi.h"
 #include "hw/fsi/cfam.h"
+#include "hw/fsi/cfam-s.h"
 
 #define TYPE_FSI_MASTER "fsi.master"
 OBJECT_DECLARE_SIMPLE_TYPE(FSIMasterState, FSI_MASTER)
@@ -26,6 +27,7 @@ typedef struct FSIMasterState {
 
     uint32_t regs[FSI_MASTER_NR_REGS];
     FSICFAM cfam;
+    FSICFAMS cfam_s;
 } FSIMasterState;
 
 
diff --git a/include/hw/fsi/lbus.h b/include/hw/fsi/lbus.h
index 1b894509fe..582d7169d6 100644
--- a/include/hw/fsi/lbus.h
+++ b/include/hw/fsi/lbus.h
@@ -40,4 +40,15 @@ typedef struct FSIScratchPad {
         uint32_t regs[FSI_SCRATCHPAD_NR_REGS];
 } FSIScratchPad;
 
+#define TYPE_FSI_MBOX "fsi.mbox"
+OBJECT_DECLARE_SIMPLE_TYPE(FSIMbox, FSI_MBOX)
+
+#define FSI_MBOX_SCRATCH_NUM 5
+
+struct FSIMbox {
+    FSILBusDevice parent;
+
+    uint32_t scratch[FSI_MBOX_SCRATCH_NUM];
+};
+
 #endif /* FSI_LBUS_H */
diff --git a/hw/fsi/cfam-s.c b/hw/fsi/cfam-s.c
new file mode 100644
index 0000000000..7a6047944f
--- /dev/null
+++ b/hw/fsi/cfam-s.c
@@ -0,0 +1,91 @@
+/*
+ * IBM Common FRU Access Macro - S variant (CFAM-S)
+ *
+ * A CFAM flavor built on the common CFAM model (see cfam.c). It supports an
+ * FSI responder and a v1 mailbox, and exposes its register slot in each
+ * slave-ID view of the link.
+ *
+ * Copyright (C) 2026 IBM Corp.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "qemu/units.h"
+#include "hw/fsi/cfam-s.h"
+#include "hw/fsi/fsi.h"
+
+/* Slot layout: 0x000 config table, 0x400 responder, 0x800 mailbox */
+#define CFAM_S_RESPONDER_BASE 0x400
+#define CFAM_S_MBOX_BASE      0x800
+
+/* Config table: chip ID with major 9 (the CFAM-S), then the engines */
+static const uint32_t cfam_s_config[] = {
+    ENGINE_CONFIG_NEXT | CFAM_CONFIG_CHIP_ID_MAJOR(9) | 0xd,
+    CFAM_CONFIG_REG(0x1000, ENGINE_CONFIG_TYPE_FSI, 0xb),
+    CFAM_CONFIG_LAST(0x1000, ENGINE_CONFIG_TYPE_MBOX_V1, 0x3),
+};
+
+static bool fsi_cfam_s_realize_engines(FSICFAMCommon *cfam, Error **errp)
+{
+    FSICFAMS *cfam_s = FSI_CFAM_S(cfam);
+
+    object_initialize_child(OBJECT(cfam_s), "mbox", &cfam_s->mbox,
+                            TYPE_FSI_MBOX);
+    return fsi_cfam_add_engine(cfam, DEVICE(&cfam_s->mbox), 0, errp);
+}
+
+static void fsi_cfam_s_realize(DeviceState *dev, Error **errp)
+{
+    ERRP_GUARD();
+    FSICFAMS *cfam_s = FSI_CFAM_S(dev);
+    FSICFAMCommon *cfam = FSI_CFAM_COMMON(dev);
+    FSICFAMSClass *sc = FSI_CFAM_S_GET_CLASS(dev);
+
+    sc->parent_realize(dev, errp);
+    if (*errp) {
+        return;
+    }
+
+    memory_region_init(&cfam_s->window, OBJECT(cfam_s),
+                       TYPE_FSI_CFAM_S ".window", CFAM_S_WINDOW_SIZE);
+    memory_region_add_subregion(&cfam_s->window, 0, &cfam->mr);
+
+    /* Alias the slot into the other three slave-ID views */
+    for (int i = 0; i < ARRAY_SIZE(cfam_s->slot_alias); i++) {
+        memory_region_init_alias(&cfam_s->slot_alias[i], OBJECT(cfam_s),
+                                 TYPE_FSI_CFAM_S ".slot-alias", &cfam->mr, 0,
+                                 FSI_CFAM_SLOT_SIZE);
+        memory_region_add_subregion(&cfam_s->window,
+                                    (i + 1) * FSI_CFAM_SLOT_SIZE,
+                                    &cfam_s->slot_alias[i]);
+    }
+}
+
+static void fsi_cfam_s_class_init(ObjectClass *klass, const void *data)
+{
+    FSICFAMSClass *sc = FSI_CFAM_S_CLASS(klass);
+    FSICFAMCommonClass *cc = FSI_CFAM_COMMON_CLASS(klass);
+
+    device_class_set_parent_realize(DEVICE_CLASS(klass), fsi_cfam_s_realize,
+                                    &sc->parent_realize);
+
+    cc->config = cfam_s_config;
+    cc->config_nr = ARRAY_SIZE(cfam_s_config);
+    cc->responder_offset = CFAM_S_RESPONDER_BASE;
+    cc->lbus_offset = CFAM_S_MBOX_BASE;
+    cc->realize_engines = fsi_cfam_s_realize_engines;
+}
+
+static const TypeInfo cfam_s_types[] = {
+    {
+        .name = TYPE_FSI_CFAM_S,
+        .parent = TYPE_FSI_CFAM_COMMON,
+        .instance_size = sizeof(FSICFAMS),
+        .class_size = sizeof(FSICFAMSClass),
+        .class_init = fsi_cfam_s_class_init,
+    },
+};
+
+DEFINE_TYPES(cfam_s_types)
diff --git a/hw/fsi/fsi-master.c b/hw/fsi/fsi-master.c
index d82df1c094..82991b1005 100644
--- a/hw/fsi/fsi-master.c
+++ b/hw/fsi/fsi-master.c
@@ -8,6 +8,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qemu/log.h"
+#include "qemu/units.h"
 #include "trace.h"
 
 #include "hw/fsi/fsi-master.h"
@@ -113,6 +114,7 @@ static void fsi_master_init(Object *o)
     FSIMasterState *s = FSI_MASTER(o);
 
     object_initialize_child(o, "cfam", &s->cfam, TYPE_FSI_CFAM);
+    object_initialize_child(o, "cfam-s", &s->cfam_s, TYPE_FSI_CFAM_S);
 
     qbus_init(&s->bus, sizeof(s->bus), TYPE_FSI_BUS, DEVICE(s), NULL);
 
@@ -131,6 +133,11 @@ static void fsi_master_realize(DeviceState *dev, Error **errp)
 
     /* address ? */
     memory_region_add_subregion(&s->opb2fsi, 0, &s->cfam.parent.mr);
+
+    if (!qdev_realize(DEVICE(&s->cfam_s), BUS(&s->bus), errp)) {
+        return;
+    }
+    memory_region_add_subregion(&s->opb2fsi, 2 * MiB, &s->cfam_s.window);
 }
 
 static void fsi_master_reset(DeviceState *dev)
diff --git a/hw/fsi/lbus.c b/hw/fsi/lbus.c
index cae29e0658..902f8d8a5e 100644
--- a/hw/fsi/lbus.c
+++ b/hw/fsi/lbus.c
@@ -107,11 +107,80 @@ static const TypeInfo fsi_scratchpad_info = {
     .class_init = fsi_scratchpad_class_init,
 };
 
+/* The mailbox exposes its scratch registers at this offset */
+#define FSI_MBOX_SCRATCH_OFF 0xe0
+#define FSI_MBOX_SCRATCH_END (FSI_MBOX_SCRATCH_OFF + FSI_MBOX_SCRATCH_NUM * 4)
+
+static uint64_t fsi_mbox_read(void *opaque, hwaddr addr, unsigned size)
+{
+    FSIMbox *mbox = FSI_MBOX(opaque);
+
+    trace_fsi_mbox_read(addr, size);
+
+    if (addr < FSI_MBOX_SCRATCH_OFF || addr >= FSI_MBOX_SCRATCH_END) {
+        return 0;
+    }
+
+    return mbox->scratch[TO_REG(addr - FSI_MBOX_SCRATCH_OFF)];
+}
+
+static void fsi_mbox_write(void *opaque, hwaddr addr, uint64_t data,
+                           unsigned size)
+{
+    FSIMbox *mbox = FSI_MBOX(opaque);
+
+    trace_fsi_mbox_write(addr, size, data);
+
+    if (addr < FSI_MBOX_SCRATCH_OFF || addr >= FSI_MBOX_SCRATCH_END) {
+        return;
+    }
+
+    mbox->scratch[TO_REG(addr - FSI_MBOX_SCRATCH_OFF)] = data;
+}
+
+static const struct MemoryRegionOps fsi_mbox_ops = {
+    .read = fsi_mbox_read,
+    .write = fsi_mbox_write,
+    .endianness = DEVICE_BIG_ENDIAN,
+};
+
+static void fsi_mbox_realize(DeviceState *dev, Error **errp)
+{
+    FSILBusDevice *ldev = FSI_LBUS_DEVICE(dev);
+
+    memory_region_init_io(&ldev->iomem, OBJECT(ldev), &fsi_mbox_ops,
+                          ldev, TYPE_FSI_MBOX, 0x400);
+}
+
+static void fsi_mbox_reset(DeviceState *dev)
+{
+    FSIMbox *mbox = FSI_MBOX(dev);
+
+    memset(mbox->scratch, 0, sizeof(mbox->scratch));
+}
+
+static void fsi_mbox_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->bus_type = TYPE_FSI_LBUS;
+    dc->realize = fsi_mbox_realize;
+    device_class_set_legacy_reset(dc, fsi_mbox_reset);
+}
+
+static const TypeInfo fsi_mbox_info = {
+    .name = TYPE_FSI_MBOX,
+    .parent = TYPE_FSI_LBUS_DEVICE,
+    .instance_size = sizeof(FSIMbox),
+    .class_init = fsi_mbox_class_init,
+};
+
 static void fsi_lbus_register_types(void)
 {
     type_register_static(&fsi_lbus_info);
     type_register_static(&fsi_lbus_device_type_info);
     type_register_static(&fsi_scratchpad_info);
+    type_register_static(&fsi_mbox_info);
 }
 
 type_init(fsi_lbus_register_types);
diff --git a/hw/fsi/meson.build b/hw/fsi/meson.build
index a18a076552..585d549405 100644
--- a/hw/fsi/meson.build
+++ b/hw/fsi/meson.build
@@ -1,2 +1,2 @@
-system_ss.add(when: 'CONFIG_FSI', if_true: files('lbus.c','fsi.c','cfam.c','fsi-master.c'))
+system_ss.add(when: 'CONFIG_FSI', if_true: files('lbus.c','fsi.c','cfam.c','cfam-s.c','fsi-master.c'))
 system_ss.add(when: 'CONFIG_FSI_APB2OPB_ASPEED', if_true: files('aspeed_apb2opb.c'))
diff --git a/hw/fsi/trace-events b/hw/fsi/trace-events
index 9e286d08d3..42edce6437 100644
--- a/hw/fsi/trace-events
+++ b/hw/fsi/trace-events
@@ -1,5 +1,7 @@
 fsi_scratchpad_read(uint64_t addr, uint32_t size) "@0x%" PRIx64 " size=%d"
 fsi_scratchpad_write(uint64_t addr, uint32_t size, uint64_t data) "@0x%" PRIx64 " size=%d value=0x%"PRIx64
+fsi_mbox_read(uint64_t addr, uint32_t size) "@0x%" PRIx64 " size=%d"
+fsi_mbox_write(uint64_t addr, uint32_t size, uint64_t data) "@0x%" PRIx64 " size=%d value=0x%"PRIx64
 fsi_slave_read(uint64_t addr, uint32_t size) "@0x%" PRIx64 " size=%d"
 fsi_slave_write(uint64_t addr, uint32_t size, uint64_t data) "@0x%" PRIx64 " size=%d value=0x%"PRIx64
 fsi_cfam_config_read(uint64_t addr, uint32_t size) "@0x%" PRIx64 " size=%d"
-- 
2.53.0


