Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90DCDC5AD7B
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2026 19:00:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtVD1-0001c7-7U; Mon, 10 Aug 2026 14:58:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mikail.sadic@ibm.com>)
 id 1wtVCv-0001Z4-OF; Mon, 10 Aug 2026 14:58:45 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mikail.sadic@ibm.com>)
 id 1wtVCt-0003Ua-N8; Mon, 10 Aug 2026 14:58:45 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67AGVocX2111767; Mon, 10 Aug 2026 18:57:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=UrFuDFzpdhvLqMbSp
 8uSpjVRXqP7RXty94LVtAtZMR8=; b=L5BFQt0qKjV1f8dNwgL+37rWYXmDVaFfu
 4FS+N80PfyUCEwRX0bgMyBGHZWxmSIcxj4CHiuqTVjUTbrzwdb/tK7zwpR96UAml
 wsun+2tMBjyyCIaqy+/BJu+j9FuFuqzKvuvnTPv6AEaR4Eaxe+HZVJZDyhNSKbPu
 zjY+A34mz7qh/qRp5pkiI8WqevhO1pJGGQenP//IrkZ6A1dTWb4sWsVFpHamqX40
 iN30HBz0ypeJUpXsSEO+Spuy8i8Fj24wZfcSu6RtlbuVbpuRiyD6zZiwZ03XJswA
 e0mxOjo5cqui8Pg0Wdr2H3kM50QW2WH74fO5GZ5Rq5SFfOLW077vw==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvq99m4b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 10 Aug 2026 18:57:54 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67AIun5l020368;
 Mon, 10 Aug 2026 18:57:53 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxf5vx5gn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 10 Aug 2026 18:57:53 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67AIvqYv64225576
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 10 Aug 2026 18:57:52 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 16CF75805C;
 Mon, 10 Aug 2026 18:57:52 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3034658051;
 Mon, 10 Aug 2026 18:57:51 +0000 (GMT)
Received: from IBM-MFS.ibm.com (unknown [9.61.24.176])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 10 Aug 2026 18:57:51 +0000 (GMT)
From: Mikail Sadic <mikail.sadic@ibm.com>
To: clg@kaod.org, peter.maydell@linaro.org
Cc: Mikail Sadic <mikail.sadic@ibm.com>, pbonzini@redhat.com,
 ninad@linux.ibm.com, titusr@google.com, jeuk20.kim@samsung.com,
 philmd@mailo.com, steven_lee@aspeedtech.com, leetroy@gmail.com,
 jamin_lin@aspeedtech.com, kane_chen@aspeedtech.com,
 andrew@codeconstruct.com.au, joel@jms.id.au, calebs@linux.ibm.com,
 milesg@linux.ibm.com, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH v3 1/8] fsi/cfam: Add common CFAM base class
Date: Mon, 10 Aug 2026 13:57:39 -0500
Message-ID: <20260810185748.1253-2-mikail.sadic@ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260810185748.1253-1-mikail.sadic@ibm.com>
References: <20260810185748.1253-1-mikail.sadic@ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: 2VYSnMgLRYntnwQ5tkr6wTo4qKwLT2lt
X-Authority-Analysis: v=2.4 cv=PbDPQChd c=1 sm=1 tr=0 ts=6a7a1f33 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=0vKXlNE1Mb1R75NS9r0A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDE1OCBTYWx0ZWRfX/UkgkQeUCdLc
 3fT64bpZxfhqbIU3JSgX4FkdMNOOM4pXIviYZiEacny69kful/fbIpqH3Xf/frJGagxGnPD2Cya
 NaXEf65foALS8P89t5IMqqB1R33qh5Ff/XZPmrfNGdk9vAp5+f0U5Vg5tCbalL5yug+XaGPTcLo
 37p/vx5yrkaexAmq7fEod4Bq1S4KH3xkhFNXVSOVecVnVaS2cRvdLYXNN9qQL9fQHrMGFOMn0CV
 wqkwrIaPxIgWrvQDPOz8X7iTdRFeW7sJqljVDzB5wk7VPvrRaAR8Hjd9T1dIaVaDDwt3SXoaZe8
 /hoiJbZ9GJSujWoqk15hOu3AMQtyZVwzwiB5aRjKDgWyINCHbeKxTtt8Mxhq1rnHqPiFENoRaO2
 a0M9fqPILiqsMewTRJZfNajt67+Xgs2iCXUySO30/vGlMb+RTVAn2fIJI0GJsrCpJ1vmTijEv5r
 Zy0d/n+GDYvytyXO17A==
X-Proofpoint-ORIG-GUID: JrvSfiMgnZNkXk-Xgb6SZvoR9xa9fVpg
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDE1OCBTYWx0ZWRfX3EJFjF5lsysh
 sq+XlAr81IsUILlVUtRyjQSQRG1mdSooV3049w0dKhGlrlIk6qcDWLp7S8CR07SIAHOFRdfq+BM
 tCA69VDDSPEnxK41r1Fy+u+MdJjMtB4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_04,2026-08-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 impostorscore=0 malwarescore=0 adultscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608100158
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

Prepare a common CFAM parent class for CFAM-S implementation.

Add an abstract TYPE_FSI_CFAM_COMMON with an FSICFAMCommonClass holding
what varies between types: the config table, the offsets of the FSI
responder and the local bus within the register slot, and a
realize_engines() hook for the engines on the local bus. Its realize is
driven by those fields, so one realize serves every type. TYPE_FSI_CFAM
keeps its name and becomes the first derived type, supplying the P9
config table, its slot offsets and the scratchpad engine. The config
table becomes data, still written with the same CFAM_CONFIG_REG()
expressions, which move to the header so a derived type can describe its
own table the same way.

Name the new instance struct without a State suffix and rename
FSICFAMState to FSICFAM to match.

No functional change: same memory map, same config words, same type and
child names. aspeed_fsi-test verified.

Signed-off-by: Mikail Sadic <mikail.sadic@ibm.com>
---
 include/hw/fsi/cfam.h       |  58 ++++++++++++++++-
 include/hw/fsi/fsi-master.h |   2 +-
 hw/fsi/cfam.c               | 125 +++++++++++++++++++++---------------
 hw/fsi/fsi-master.c         |   2 +-
 4 files changed, 130 insertions(+), 57 deletions(-)

diff --git a/include/hw/fsi/cfam.h b/include/hw/fsi/cfam.h
index cceb4bd6f1..bdf579b4fe 100644
--- a/include/hw/fsi/cfam.h
+++ b/include/hw/fsi/cfam.h
@@ -7,18 +7,44 @@
 #ifndef FSI_CFAM_H
 #define FSI_CFAM_H
 
+#include "qemu/units.h"
 #include "system/memory.h"
 
 #include "hw/fsi/fsi.h"
 #include "hw/fsi/lbus.h"
 
+/*
+ * All CFAM flavors present a register slot holding a config table, an FSI
+ * responder and a local bus carrying the engines the config table describes.
+ * That is the common model; each flavor supplies its own table, slot layout
+ * and engines.
+ */
+#define TYPE_FSI_CFAM_COMMON "cfam-common"
+OBJECT_DECLARE_TYPE(FSICFAMCommon, FSICFAMCommonClass, FSI_CFAM_COMMON)
+
 #define TYPE_FSI_CFAM "cfam"
-#define FSI_CFAM(obj) OBJECT_CHECK(FSICFAMState, (obj), TYPE_FSI_CFAM)
+OBJECT_DECLARE_SIMPLE_TYPE(FSICFAM, FSI_CFAM)
 
 /* P9-ism */
 #define CFAM_CONFIG_NR_REGS 0x28
 
-typedef struct FSICFAMState {
+#define FSI_CFAM_SLOT_SIZE   (2 * MiB)
+#define FSI_CFAM_CONFIG_SIZE 0x400
+
+#define ENGINE_CONFIG_NEXT            BIT(31)
+#define ENGINE_CONFIG_TYPE_PEEK       (0x02 << 4)
+#define ENGINE_CONFIG_TYPE_FSI        (0x03 << 4)
+#define ENGINE_CONFIG_TYPE_SCRATCHPAD (0x06 << 4)
+
+/* Valid, slots, version, type, crc */
+#define CFAM_CONFIG_REG(__VER, __TYPE, __CRC)   \
+    (ENGINE_CONFIG_NEXT       |   \
+     0x00010000               |   \
+     (__VER)                  |   \
+     (__TYPE)                 |   \
+     (__CRC))
+
+struct FSICFAMCommon {
     /* < private > */
     FSISlaveState parent;
 
@@ -28,7 +54,33 @@ typedef struct FSICFAMState {
     MemoryRegion mr;
 
     FSILBus lbus;
+};
+
+struct FSICFAMCommonClass {
+    /* < private > */
+    DeviceClass parent_class;
+
+    /* < public > */
+    /* Config table served by the common ops, one word per 4-byte offset */
+    const uint32_t *config;
+    unsigned config_nr;
+
+    /* Layout of the register slot */
+    hwaddr responder_offset;
+    hwaddr lbus_offset;
+
+    /* Realize and map this flavor's local bus engines */
+    bool (*realize_engines)(FSICFAMCommon *cfam, Error **errp);
+};
+
+struct FSICFAM {
+    /* < private > */
+    FSICFAMCommon parent;
+
     FSIScratchPad scratchpad;
-} FSICFAMState;
+};
+
+bool fsi_cfam_add_engine(FSICFAMCommon *cfam, DeviceState *engine,
+                         hwaddr offset, Error **errp);
 
 #endif /* FSI_CFAM_H */
diff --git a/include/hw/fsi/fsi-master.h b/include/hw/fsi/fsi-master.h
index 60ddaa994f..87c11ec3dc 100644
--- a/include/hw/fsi/fsi-master.h
+++ b/include/hw/fsi/fsi-master.h
@@ -25,7 +25,7 @@ typedef struct FSIMasterState {
     FSIBus bus;
 
     uint32_t regs[FSI_MASTER_NR_REGS];
-    FSICFAMState cfam;
+    FSICFAM cfam;
 } FSIMasterState;
 
 
diff --git a/hw/fsi/cfam.c b/hw/fsi/cfam.c
index 54c0b05769..5d4d0622d0 100644
--- a/hw/fsi/cfam.c
+++ b/hw/fsi/cfam.c
@@ -16,19 +16,6 @@
 
 #include "hw/core/qdev-properties.h"
 
-#define ENGINE_CONFIG_NEXT            BIT(31)
-#define ENGINE_CONFIG_TYPE_PEEK       (0x02 << 4)
-#define ENGINE_CONFIG_TYPE_FSI        (0x03 << 4)
-#define ENGINE_CONFIG_TYPE_SCRATCHPAD (0x06 << 4)
-
-/* Valid, slots, version, type, crc */
-#define CFAM_CONFIG_REG(__VER, __TYPE, __CRC)   \
-    (ENGINE_CONFIG_NEXT       |   \
-     0x00010000               |   \
-     (__VER)                  |   \
-     (__TYPE)                 |   \
-     (__CRC))
-
 #define TO_REG(x)                          ((x) >> 2)
 
 #define CFAM_CONFIG_CHIP_ID                TO_REG(0x00)
@@ -36,34 +23,33 @@
 #define CFAM_CONFIG_CHIP_ID_P9             0xc0022d15
 #define CFAM_CONFIG_CHIP_ID_BREAK          0xc0de0000
 
+/*
+ * Config table of the P9 CFAM: the chip ID followed by one entry per engine,
+ * entry n describing the engine at address n * 4. We need to add future
+ * engines from address 0x10 onwards.
+ */
+static const uint32_t cfam_p9_config[] = {
+    CFAM_CONFIG_CHIP_ID_P9,
+    CFAM_CONFIG_REG(0x1000, ENGINE_CONFIG_TYPE_PEEK, 0xc),
+    CFAM_CONFIG_REG(0x5000, ENGINE_CONFIG_TYPE_FSI, 0xa),
+    CFAM_CONFIG_REG(0x1000, ENGINE_CONFIG_TYPE_SCRATCHPAD, 0x7),
+};
+
 static uint64_t fsi_cfam_config_read(void *opaque, hwaddr addr, unsigned size)
 {
+    FSICFAMCommonClass *cc = FSI_CFAM_COMMON_GET_CLASS(opaque);
+    unsigned int reg = TO_REG(addr);
+
     trace_fsi_cfam_config_read(addr, size);
 
-    switch (addr) {
-    case 0x00:
-        return CFAM_CONFIG_CHIP_ID_P9;
-    case 0x04:
-        return CFAM_CONFIG_REG(0x1000, ENGINE_CONFIG_TYPE_PEEK, 0xc);
-    case 0x08:
-        return CFAM_CONFIG_REG(0x5000, ENGINE_CONFIG_TYPE_FSI, 0xa);
-    case 0xc:
-        return CFAM_CONFIG_REG(0x1000, ENGINE_CONFIG_TYPE_SCRATCHPAD, 0x7);
-    default:
-        /*
-         * The config table contains different engines from 0xc onwards.
-         * The scratch pad is already added at address 0xc. We need to add
-         * future engines from address 0x10 onwards. Returning 0 as engine
-         * is not implemented.
-         */
-        return 0;
-    }
+    /* Engines past the end of the table are not implemented */
+    return reg < cc->config_nr ? cc->config[reg] : 0;
 }
 
 static void fsi_cfam_config_write(void *opaque, hwaddr addr, uint64_t data,
                                   unsigned size)
 {
-    FSICFAMState *cfam = FSI_CFAM(opaque);
+    FSICFAMCommon *cfam = FSI_CFAM_COMMON(opaque);
 
     trace_fsi_cfam_config_write(addr, size, data);
 
@@ -109,59 +95,94 @@ static const struct MemoryRegionOps fsi_cfam_unimplemented_ops = {
     .endianness = DEVICE_BIG_ENDIAN,
 };
 
-static void fsi_cfam_instance_init(Object *obj)
+bool fsi_cfam_add_engine(FSICFAMCommon *cfam, DeviceState *engine,
+                         hwaddr offset, Error **errp)
 {
-    FSICFAMState *s = FSI_CFAM(obj);
+    if (!qdev_realize(engine, BUS(&cfam->lbus), errp)) {
+        return false;
+    }
 
-    object_initialize_child(obj, "scratchpad", &s->scratchpad,
-                            TYPE_FSI_SCRATCHPAD);
+    memory_region_add_subregion(&cfam->lbus.mr, offset,
+                                &FSI_LBUS_DEVICE(engine)->iomem);
+    return true;
 }
 
-static void fsi_cfam_realize(DeviceState *dev, Error **errp)
+static void fsi_cfam_common_realize(DeviceState *dev, Error **errp)
 {
-    FSICFAMState *cfam = FSI_CFAM(dev);
+    FSICFAMCommon *cfam = FSI_CFAM_COMMON(dev);
+    FSICFAMCommonClass *cc = FSI_CFAM_COMMON_GET_CLASS(dev);
     FSISlaveState *slave = FSI_SLAVE(dev);
+    const char *type = object_get_typename(OBJECT(dev));
+    g_autofree char *config_name = g_strdup_printf("%s.config", type);
 
     /* Each slave has a 2MiB address space */
     memory_region_init_io(&cfam->mr, OBJECT(cfam), &fsi_cfam_unimplemented_ops,
-                          cfam, TYPE_FSI_CFAM, 2 * MiB);
+                          cfam, type, FSI_CFAM_SLOT_SIZE);
 
     qbus_init(&cfam->lbus, sizeof(cfam->lbus), TYPE_FSI_LBUS, DEVICE(cfam),
               NULL);
 
     memory_region_init_io(&cfam->config_iomem, OBJECT(cfam), &cfam_config_ops,
-                          cfam, TYPE_FSI_CFAM ".config", 0x400);
+                          cfam, config_name, FSI_CFAM_CONFIG_SIZE);
 
     memory_region_add_subregion(&cfam->mr, 0, &cfam->config_iomem);
-    memory_region_add_subregion(&cfam->mr, 0x800, &slave->iomem);
-    memory_region_add_subregion(&cfam->mr, 0xc00, &cfam->lbus.mr);
+    memory_region_add_subregion(&cfam->mr, cc->responder_offset, &slave->iomem);
+    memory_region_add_subregion(&cfam->mr, cc->lbus_offset, &cfam->lbus.mr);
 
-    /* Add scratchpad engine */
-    if (!qdev_realize(DEVICE(&cfam->scratchpad), BUS(&cfam->lbus), errp)) {
+    if (!cc->realize_engines(cfam, errp)) {
         return;
     }
-
-    FSILBusDevice *fsi_dev = FSI_LBUS_DEVICE(&cfam->scratchpad);
-    memory_region_add_subregion(&cfam->lbus.mr, 0, &fsi_dev->iomem);
 }
 
-static void fsi_cfam_class_init(ObjectClass *klass, const void *data)
+static void fsi_cfam_common_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
+
     dc->bus_type = TYPE_FSI_BUS;
-    dc->realize = fsi_cfam_realize;
+    dc->realize = fsi_cfam_common_realize;
+}
+
+static bool fsi_cfam_realize_engines(FSICFAMCommon *cfam, Error **errp)
+{
+    FSICFAM *s = FSI_CFAM(cfam);
+
+    /* Add scratchpad engine */
+    object_initialize_child(OBJECT(s), "scratchpad", &s->scratchpad,
+                            TYPE_FSI_SCRATCHPAD);
+
+    return fsi_cfam_add_engine(cfam, DEVICE(&s->scratchpad), 0, errp);
 }
 
+static void fsi_cfam_class_init(ObjectClass *klass, const void *data)
+{
+    FSICFAMCommonClass *cc = FSI_CFAM_COMMON_CLASS(klass);
+
+    cc->config = cfam_p9_config;
+    cc->config_nr = ARRAY_SIZE(cfam_p9_config);
+    cc->responder_offset = 0x800;
+    cc->lbus_offset = 0xc00;
+    cc->realize_engines = fsi_cfam_realize_engines;
+}
+
+static const TypeInfo fsi_cfam_common_info = {
+    .name = TYPE_FSI_CFAM_COMMON,
+    .parent = TYPE_FSI_SLAVE,
+    .instance_size = sizeof(FSICFAMCommon),
+    .class_size = sizeof(FSICFAMCommonClass),
+    .class_init = fsi_cfam_common_class_init,
+    .abstract = true,
+};
+
 static const TypeInfo fsi_cfam_info = {
     .name = TYPE_FSI_CFAM,
-    .parent = TYPE_FSI_SLAVE,
-    .instance_init = fsi_cfam_instance_init,
-    .instance_size = sizeof(FSICFAMState),
+    .parent = TYPE_FSI_CFAM_COMMON,
+    .instance_size = sizeof(FSICFAM),
     .class_init = fsi_cfam_class_init,
 };
 
 static void fsi_cfam_register_types(void)
 {
+    type_register_static(&fsi_cfam_common_info);
     type_register_static(&fsi_cfam_info);
 }
 
diff --git a/hw/fsi/fsi-master.c b/hw/fsi/fsi-master.c
index 083a5507ab..d82df1c094 100644
--- a/hw/fsi/fsi-master.c
+++ b/hw/fsi/fsi-master.c
@@ -130,7 +130,7 @@ static void fsi_master_realize(DeviceState *dev, Error **errp)
     }
 
     /* address ? */
-    memory_region_add_subregion(&s->opb2fsi, 0, &s->cfam.mr);
+    memory_region_add_subregion(&s->opb2fsi, 0, &s->cfam.parent.mr);
 }
 
 static void fsi_master_reset(DeviceState *dev)
-- 
2.53.0


