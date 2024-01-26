Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D348C47DDB
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jan 2024 03:42:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTD5J-0004iL-Ul; Thu, 25 Jan 2024 22:40:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ninad@linux.ibm.com>)
 id 1rTD5I-0004gp-Ac; Thu, 25 Jan 2024 22:40:52 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ninad@linux.ibm.com>)
 id 1rTD5G-0003Ow-Ac; Thu, 25 Jan 2024 22:40:52 -0500
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 40Q2vjDU029460; Fri, 26 Jan 2024 03:40:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=a2wggvB55ioieQw9s+/RcZCAlxFYQ0oPy11QRdH48+8=;
 b=h8wGbCT5QOj0zrDC57f6q8M38gzwWgi846ruJw06H/ERU17fmx+aJ1zk5WbTf1pBis41
 4QDl6azbPqhTathND+YYNEqi7Dhsgt20QCVUPFgWTUovN7e9Z8qYGOh+020PPJoovLAe
 PJCBYuMO4Szi1iNDWq822uVKiyB3ZOikHcLGKE+s+7MO1tTHxaFIYiH5UZY/VYXxSLG9
 H0aDd/T1mTiV8Cv1lUyH7GOr+1QtXNfkpMLE10Y0uye03WCwHeOM82P3LWaWw7GdaCxs
 XC9lKAkfVj2+O4vguPyandI/uW3ieskCaj4DvcNsLBYJk/iWKM/970saWrjLLW+vz3xR 4w== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vv4dm8ysu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 26 Jan 2024 03:40:33 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40Q3cC1Q004260;
 Fri, 26 Jan 2024 03:40:32 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vv4dm8ysj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 26 Jan 2024 03:40:32 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 40Q2ZIeE025268; Fri, 26 Jan 2024 03:40:31 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3vrtqkr4p0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 26 Jan 2024 03:40:31 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 40Q3eUAt21627626
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 26 Jan 2024 03:40:30 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 79BCB58043;
 Fri, 26 Jan 2024 03:40:30 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 39DCB5805E;
 Fri, 26 Jan 2024 03:40:30 +0000 (GMT)
Received: from gfwa153.aus.stglabs.ibm.com (unknown [9.3.84.127])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 26 Jan 2024 03:40:30 +0000 (GMT)
From: Ninad Palsule <ninad@linux.ibm.com>
To: qemu-devel@nongnu.org, clg@kaod.org, peter.maydell@linaro.org,
 andrew@codeconstruct.com.au, joel@jms.id.au, pbonzini@redhat.com,
 marcandre.lureau@redhat.com, berrange@redhat.com, thuth@redhat.com,
 philmd@linaro.org, lvivier@redhat.com
Cc: Ninad Palsule <ninad@linux.ibm.com>, qemu-arm@nongnu.org,
 Andrew Jeffery <andrew@aj.id.au>
Subject: [PATCH v11 04/11] hw/fsi: Introduce IBM's fsi-slave model
Date: Thu, 25 Jan 2024 21:40:19 -0600
Message-Id: <20240126034026.31068-5-ninad@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240126034026.31068-1-ninad@linux.ibm.com>
References: <20240126034026.31068-1-ninad@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: pDNLoGFVTBXr22HLibtw4_QGuzewalLm
X-Proofpoint-GUID: 4rh-MKs5CA4-ZEdOJ5D7gsf3BX7Y-x1M
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_14,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0
 priorityscore=1501 malwarescore=0 impostorscore=0 lowpriorityscore=0
 adultscore=0 spamscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0
 clxscore=1015 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401260024
Received-SPF: pass client-ip=148.163.158.5; envelope-from=ninad@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This is a part of patchset where IBM's Flexible Service Interface is
introduced.

The FSI slave: The slave is the terminal point of the FSI bus for
FSI symbols addressed to it. Slaves can be cascaded off of one
another. The slave's configuration registers appear in address space
of the CFAM to which it is attached.

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
Signed-off-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
---
 include/hw/fsi/fsi.h | 19 ++++++++++
 hw/fsi/fsi.c         | 87 +++++++++++++++++++++++++++++++++++++++++++-
 hw/fsi/trace-events  |  2 +
 3 files changed, 106 insertions(+), 2 deletions(-)

diff --git a/include/hw/fsi/fsi.h b/include/hw/fsi/fsi.h
index 50e8f5c888..6e11747dd5 100644
--- a/include/hw/fsi/fsi.h
+++ b/include/hw/fsi/fsi.h
@@ -7,7 +7,14 @@
 #ifndef FSI_FSI_H
 #define FSI_FSI_H
 
+#include "exec/memory.h"
 #include "hw/qdev-core.h"
+#include "hw/fsi/lbus.h"
+#include "qemu/bitops.h"
+
+/* Bitwise operations at the word level. */
+#define BE_BIT(x)           BIT(31 - (x))
+#define BE_GENMASK(hb, lb)  MAKE_64BIT_MASK((lb), ((hb) - (lb) + 1))
 
 #define TYPE_FSI_BUS "fsi.bus"
 OBJECT_DECLARE_SIMPLE_TYPE(FSIBus, FSI_BUS)
@@ -16,4 +23,16 @@ typedef struct FSIBus {
     BusState bus;
 } FSIBus;
 
+#define TYPE_FSI_SLAVE "fsi.slave"
+OBJECT_DECLARE_SIMPLE_TYPE(FSISlaveState, FSI_SLAVE)
+
+#define FSI_SLAVE_CONTROL_NR_REGS ((0x40 >> 2) + 1)
+
+typedef struct FSISlaveState {
+    DeviceState parent;
+
+    MemoryRegion iomem;
+    uint32_t regs[FSI_SLAVE_CONTROL_NR_REGS];
+} FSISlaveState;
+
 #endif /* FSI_FSI_H */
diff --git a/hw/fsi/fsi.c b/hw/fsi/fsi.c
index 60cb03f7a2..528323d9cf 100644
--- a/hw/fsi/fsi.c
+++ b/hw/fsi/fsi.c
@@ -5,18 +5,101 @@
  * IBM Flexible Service Interface
  */
 #include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "qemu/log.h"
+#include "trace.h"
 
 #include "hw/fsi/fsi.h"
 
+#define TO_REG(x)                               ((x) >> 2)
+
 static const TypeInfo fsi_bus_info = {
     .name = TYPE_FSI_BUS,
     .parent = TYPE_BUS,
     .instance_size = sizeof(FSIBus),
 };
 
-static void fsi_bus_register_types(void)
+static uint64_t fsi_slave_read(void *opaque, hwaddr addr, unsigned size)
+{
+    FSISlaveState *s = FSI_SLAVE(opaque);
+    int reg = TO_REG(addr);
+
+    trace_fsi_slave_read(addr, size);
+
+    if (reg >= FSI_SLAVE_CONTROL_NR_REGS) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Out of bounds read: 0x%"HWADDR_PRIx" for %u\n",
+                      __func__, addr, size);
+        return 0;
+    }
+
+    return s->regs[reg];
+}
+
+static void fsi_slave_write(void *opaque, hwaddr addr, uint64_t data,
+                                 unsigned size)
+{
+    FSISlaveState *s = FSI_SLAVE(opaque);
+    int reg = TO_REG(addr);
+
+    trace_fsi_slave_write(addr, size, data);
+
+    if (reg >= FSI_SLAVE_CONTROL_NR_REGS) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Out of bounds write: 0x%"HWADDR_PRIx" for %u\n",
+                      __func__, addr, size);
+        return;
+    }
+
+    s->regs[reg] = data;
+}
+
+static const struct MemoryRegionOps fsi_slave_ops = {
+    .read = fsi_slave_read,
+    .write = fsi_slave_write,
+    .endianness = DEVICE_BIG_ENDIAN,
+};
+
+static void fsi_slave_reset(DeviceState *dev)
+{
+    FSISlaveState *s = FSI_SLAVE(dev);
+    int i;
+
+    /* Initialize registers */
+    for (i = 0; i < FSI_SLAVE_CONTROL_NR_REGS; i++) {
+        s->regs[i] = 0;
+    }
+}
+
+static void fsi_slave_init(Object *o)
+{
+    FSISlaveState *s = FSI_SLAVE(o);
+
+    memory_region_init_io(&s->iomem, OBJECT(s), &fsi_slave_ops,
+                          s, TYPE_FSI_SLAVE, 0x400);
+}
+
+static void fsi_slave_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->bus_type = TYPE_FSI_BUS;
+    dc->desc = "FSI Slave";
+    dc->reset = fsi_slave_reset;
+}
+
+static const TypeInfo fsi_slave_info = {
+    .name = TYPE_FSI_SLAVE,
+    .parent = TYPE_DEVICE,
+    .instance_init = fsi_slave_init,
+    .instance_size = sizeof(FSISlaveState),
+    .class_init = fsi_slave_class_init,
+};
+
+static void fsi_register_types(void)
 {
     type_register_static(&fsi_bus_info);
+    type_register_static(&fsi_slave_info);
 }
 
-type_init(fsi_bus_register_types);
+type_init(fsi_register_types);
diff --git a/hw/fsi/trace-events b/hw/fsi/trace-events
index c5753e2791..8f29adb7df 100644
--- a/hw/fsi/trace-events
+++ b/hw/fsi/trace-events
@@ -1,2 +1,4 @@
 fsi_scratchpad_read(uint64_t addr, uint32_t size) "@0x%" PRIx64 " size=%d"
 fsi_scratchpad_write(uint64_t addr, uint32_t size, uint64_t data) "@0x%" PRIx64 " size=%d value=0x%"PRIx64
+fsi_slave_read(uint64_t addr, uint32_t size) "@0x%" PRIx64 " size=%d"
+fsi_slave_write(uint64_t addr, uint32_t size, uint64_t data) "@0x%" PRIx64 " size=%d value=0x%"PRIx64
-- 
2.39.2


