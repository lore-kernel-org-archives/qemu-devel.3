Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D07AC021B5
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2025 12:06:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmXDI-00066R-IR; Mon, 24 Feb 2025 07:05:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shalini@linux.ibm.com>)
 id 1tmXDF-000655-4P; Mon, 24 Feb 2025 07:05:29 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shalini@linux.ibm.com>)
 id 1tmXDA-00030e-7L; Mon, 24 Feb 2025 07:05:28 -0500
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51O2DYmo013713;
 Mon, 24 Feb 2025 12:05:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=IZ9m4h+k3Y0KIvsL+
 srVOnlsrghDUcpGtkD4CFcD8j8=; b=O605mz4IqDI5GplQnGGnPfK/5PyUScLkV
 IQrNgfVG7OivKCDzhdERwmnZ9z9SlIffF9A6EQUZXaev08xUKbmkV0cuyJQ0sfKq
 34Em5/e5tDZa8y1Eoc5ei6J3xGZMF3epOL8ZIveGpM93AMxz6FhK/I/I8qIqzNjT
 bKxUHf4RucL2Y2HGC4ZtfWbdcumx/JIl5e9tZ7A4Hf7JRK+GfsmlKYH4TyyXTOA5
 CDfsWaRV/Ag/OT87MOqSkq8amFQDNTpfO73wdlgfEs01TvepP5N74jWZd7ImJfMZ
 lIPyuXIwdYsob2OMpuE5XfpaPR+O8x6/ONZT3hoArbMlBrjMRVWpQ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 450fm026np-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 24 Feb 2025 12:05:22 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51O9UFuS002578;
 Mon, 24 Feb 2025 12:05:21 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 44yu4jept7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 24 Feb 2025 12:05:21 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 51OC5IWQ18416008
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 24 Feb 2025 12:05:18 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 47C3A2004B;
 Mon, 24 Feb 2025 12:05:18 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1F93920049;
 Mon, 24 Feb 2025 12:05:18 +0000 (GMT)
Received: from a46lp68.lnxne.boe (unknown [9.152.108.100])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 24 Feb 2025 12:05:18 +0000 (GMT)
From: Shalini Chellathurai Saroja <shalini@linux.ibm.com>
To: qemu-s390x mailing list <qemu-s390x@nongnu.org>,
 Thomas Huth <thuth@redhat.com>
Cc: qemu-devel mailing list <qemu-devel@nongnu.org>,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>,
 Hendrik Brueckner <brueckner@linux.ibm.com>,
 Shalini Chellathurai Saroja <shalini@linux.ibm.com>
Subject: [PATCH qemu v2 2/3] hw/s390x: add SCLP event type CPI
Date: Mon, 24 Feb 2025 13:04:48 +0100
Message-ID: <20250224120449.1764114-2-shalini@linux.ibm.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250224120449.1764114-1-shalini@linux.ibm.com>
References: <20250224120449.1764114-1-shalini@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: c8Zll3K7-vK73nDrKSexj6nrLiCpAEUr
X-Proofpoint-GUID: c8Zll3K7-vK73nDrKSexj6nrLiCpAEUr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-24_05,2025-02-24_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 adultscore=0
 lowpriorityscore=0 suspectscore=0 spamscore=0 priorityscore=1501
 mlxlogscore=999 impostorscore=0 malwarescore=0 bulkscore=0 clxscore=1011
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502240088
Received-SPF: pass client-ip=148.163.158.5; envelope-from=shalini@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Implement the SCLP event type Control-Program Identification
(CPI) in QEMU. This event is used to send CPI identifiers,
which provide information about the guest OS to the host.

Save the information obtained from the SCLP CPI event to the
QOM along with the timestamp in which the data was received.

Example:
virsh # qemu-monitor-command vm --pretty '{
"execute":"qom-get","arguments": {
"path": "/machine", "property": "s390-control-program_id"}}'
{
  "return": {
    "timestamp": 1711620874948254000,
    "system-level": "0x50e00",
    "sysplex-name": "SYSPLEX ",
    "system-name": "TESTVM  ",
    "system-type": "LINUX   "
  },
  "id": "libvirt-15"
}

Signed-off-by: Shalini Chellathurai Saroja <shalini@linux.ibm.com>
Reviewed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
---
 hw/s390x/event-facility.c         |  12 +++-
 hw/s390x/meson.build              |   1 +
 hw/s390x/sclpcpi.c                | 105 ++++++++++++++++++++++++++++++
 include/hw/s390x/event-facility.h |   3 +
 4 files changed, 120 insertions(+), 1 deletion(-)
 create mode 100644 hw/s390x/sclpcpi.c

diff --git a/hw/s390x/event-facility.c b/hw/s390x/event-facility.c
index 2b0332c20e..c0fb6e098c 100644
--- a/hw/s390x/event-facility.c
+++ b/hw/s390x/event-facility.c
@@ -39,7 +39,7 @@ typedef struct SCLPEventsBus {
 struct SCLPEventFacility {
     SysBusDevice parent_obj;
     SCLPEventsBus sbus;
-    SCLPEvent quiesce, cpu_hotplug;
+    SCLPEvent quiesce, cpu_hotplug, cpi;
     /* guest's receive mask */
     union {
         uint32_t receive_mask_pieces[2];
@@ -436,6 +436,10 @@ static void init_event_facility(Object *obj)
     object_initialize_child(obj, TYPE_SCLP_CPU_HOTPLUG,
                             &event_facility->cpu_hotplug,
                             TYPE_SCLP_CPU_HOTPLUG);
+
+    object_initialize_child(obj, TYPE_SCLP_CPI,
+                            &event_facility->cpi,
+                            TYPE_SCLP_CPI);
 }
 
 static void realize_event_facility(DeviceState *dev, Error **errp)
@@ -451,6 +455,12 @@ static void realize_event_facility(DeviceState *dev, Error **errp)
         qdev_unrealize(DEVICE(&event_facility->quiesce));
         return;
     }
+    if (!qdev_realize(DEVICE(&event_facility->cpi),
+                      BUS(&event_facility->sbus), errp)) {
+        qdev_unrealize(DEVICE(&event_facility->quiesce));
+        qdev_unrealize(DEVICE(&event_facility->cpu_hotplug));
+        return;
+    }
 }
 
 static void reset_event_facility(DeviceState *dev)
diff --git a/hw/s390x/meson.build b/hw/s390x/meson.build
index 3bbebfd817..eb7950489c 100644
--- a/hw/s390x/meson.build
+++ b/hw/s390x/meson.build
@@ -13,6 +13,7 @@ s390x_ss.add(files(
   's390-skeys.c',
   's390-stattrib.c',
   'sclp.c',
+  'sclpcpi.c',
   'sclpcpu.c',
   'sclpquiesce.c',
   'tod.c',
diff --git a/hw/s390x/sclpcpi.c b/hw/s390x/sclpcpi.c
new file mode 100644
index 0000000000..f2830d2d57
--- /dev/null
+++ b/hw/s390x/sclpcpi.c
@@ -0,0 +1,105 @@
+/*
+ * SCLP event type 11 - Control-Program Identification(CPI):
+ *    CPI is used to send program identifiers from the control-program to the
+ *    SCLP. The program identifiers provide data about the guest instance. It
+ *    is not sent by the SCLP.
+ *
+ *    The program identifiers are system type, system name, sysplex name and
+ *    system level. The system type, system name, and sysplex name use EBCDIC
+ *    ucharacters from this set: capital A-Z, 0-9, $, @, #, and blank. The
+ *    system level is a hex value.
+ *
+ * Copyright IBM, Corp. 2024
+ *
+ * Authors:
+ *  Shalini Chellathurai Saroja <shalini@linux.ibm.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or (at your
+ * option) any later version.  See the COPYING file in the top-level directory.
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/timer.h"
+#include "hw/s390x/sclp.h"
+#include "hw/s390x/event-facility.h"
+#include "hw/s390x/ebcdic.h"
+#include "hw/s390x/s390-virtio-ccw.h"
+
+typedef struct Data {
+    uint8_t id_format;
+    uint8_t reserved0;
+    uint8_t system_type[8];
+    uint64_t reserved1;
+    uint8_t system_name[8];
+    uint64_t reserved2;
+    uint64_t system_level;
+    uint64_t reserved3;
+    uint8_t sysplex_name[8];
+    uint8_t reserved4[16];
+} QEMU_PACKED Data;
+
+typedef struct ControlProgramIdMsg {
+    EventBufferHeader ebh;
+    Data data;
+} QEMU_PACKED ControlProgramIdMsg;
+
+static bool can_handle_event(uint8_t type)
+{
+    return type == SCLP_EVENT_CPI;
+}
+
+static sccb_mask_t send_mask(void)
+{
+    return 0;
+}
+
+/* Enable SCLP to accept buffers of event type CPI from the control-program. */
+static sccb_mask_t receive_mask(void)
+{
+    return SCLP_EVENT_MASK_CPI;
+}
+
+static int write_event_data(SCLPEvent *event, EventBufferHeader *evt_buf_hdr)
+{
+    ControlProgramIdMsg *cpi = container_of(evt_buf_hdr, ControlProgramIdMsg,
+                                            ebh);
+    S390CcwMachineState *ms = S390_CCW_MACHINE(qdev_get_machine());
+
+    ascii_put(ms->cpi.system_type, (char *)cpi->data.system_type, 8);
+    ascii_put(ms->cpi.system_name, (char *)cpi->data.system_name, 8);
+    ascii_put(ms->cpi.sysplex_name, (char *)cpi->data.sysplex_name, 8);
+    ms->cpi.system_level = be64_to_cpu(cpi->data.system_level);
+    ms->cpi.timestamp = qemu_clock_get_ns(QEMU_CLOCK_HOST);
+
+    cpi->ebh.flags = SCLP_EVENT_BUFFER_ACCEPTED;
+    return SCLP_RC_NORMAL_COMPLETION;
+}
+
+static void cpi_class_init(ObjectClass *klass, void *data)
+{
+    SCLPEventClass *sclp_cpi = SCLP_EVENT_CLASS(klass);
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    sclp_cpi->can_handle_event = can_handle_event;
+    sclp_cpi->get_send_mask = send_mask;
+    sclp_cpi->get_receive_mask = receive_mask;
+    sclp_cpi->write_event_data = write_event_data;
+    dc->user_creatable = false;
+}
+
+static const TypeInfo sclp_cpi_info = {
+    .name          = TYPE_SCLP_CPI,
+    .parent        = TYPE_SCLP_EVENT,
+    .instance_size = sizeof(SCLPEvent),
+    .class_init    = cpi_class_init,
+    .class_size    = sizeof(SCLPEventClass),
+};
+
+static void sclp_cpi_register_types(void)
+{
+    type_register_static(&sclp_cpi_info);
+}
+
+type_init(sclp_cpi_register_types)
+
diff --git a/include/hw/s390x/event-facility.h b/include/hw/s390x/event-facility.h
index ff874e792d..f445d2f9f5 100644
--- a/include/hw/s390x/event-facility.h
+++ b/include/hw/s390x/event-facility.h
@@ -25,6 +25,7 @@
 #define SCLP_EVENT_MESSAGE                      0x02
 #define SCLP_EVENT_CONFIG_MGT_DATA              0x04
 #define SCLP_EVENT_PMSGCMD                      0x09
+#define SCLP_EVENT_CPI                          0x0b
 #define SCLP_EVENT_ASCII_CONSOLE_DATA           0x1a
 #define SCLP_EVENT_SIGNAL_QUIESCE               0x1d
 
@@ -35,6 +36,7 @@
 #define SCLP_EVENT_MASK_MSG             SCLP_EVMASK(SCLP_EVENT_MESSAGE)
 #define SCLP_EVENT_MASK_CONFIG_MGT_DATA SCLP_EVMASK(SCLP_EVENT_CONFIG_MGT_DATA)
 #define SCLP_EVENT_MASK_PMSGCMD         SCLP_EVMASK(SCLP_EVENT_PMSGCMD)
+#define SCLP_EVENT_MASK_CPI             SCLP_EVMASK(SCLP_EVENT_CPI)
 #define SCLP_EVENT_MASK_MSG_ASCII       SCLP_EVMASK(SCLP_EVENT_ASCII_CONSOLE_DATA)
 #define SCLP_EVENT_MASK_SIGNAL_QUIESCE  SCLP_EVMASK(SCLP_EVENT_SIGNAL_QUIESCE)
 
@@ -46,6 +48,7 @@ OBJECT_DECLARE_TYPE(SCLPEvent, SCLPEventClass,
                     SCLP_EVENT)
 
 #define TYPE_SCLP_CPU_HOTPLUG "sclp-cpu-hotplug"
+#define TYPE_SCLP_CPI "sclpcpi"
 #define TYPE_SCLP_QUIESCE "sclpquiesce"
 
 #define SCLP_EVENT_MASK_LEN_MAX 1021
-- 
2.47.0


