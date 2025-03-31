Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19BFFC3600B
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Mar 2025 14:02:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzFho-0007G6-3W; Mon, 31 Mar 2025 10:01:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shalini@linux.ibm.com>)
 id 1tzFhj-0007Eo-EU; Mon, 31 Mar 2025 10:01:32 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shalini@linux.ibm.com>)
 id 1tzFhg-0002z8-Md; Mon, 31 Mar 2025 10:01:31 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52V8hr0T029367;
 Mon, 31 Mar 2025 14:01:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=TEU03YAzqAwt6bXIx
 teVjovSLEeYTfXGzJZ9yTp0LRk=; b=TV3uPJIIhl3LAdMbOsC6OcgyWDGO5mG8O
 9TQCDqfPzFO3JmyWDmp937ZxeFsRsOZe/TAAIkuGUMO32YT9KsbQFyo4X5sDh3AQ
 y+ht2wHmBs9CmP+B78ETp18iYc7oFG0axZH0nAVIlWgTW6yzIAvRp5Iup7n9pxD5
 jSYP9FpSG9olKakBMgkVmjzgMF6Ifc5LLZBzGMH6fljrsbhr1truISRMGpNZsrgn
 bMKgJPTPIvWNysAfXrwGpphOkpPzGWVU5D4H/jF8l04uCafg7nt06KjQDnmoRy3q
 mjtVQDK/wez/Nm0vq/xMdEwVhdzSBa0LRng1xXnSGOg4Y5hrPKfKw==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45qa4wv0vy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 31 Mar 2025 14:01:24 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52VA554m014568;
 Mon, 31 Mar 2025 14:01:24 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45pvpkwy7v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 31 Mar 2025 14:01:24 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 52VE1K2B18809164
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 31 Mar 2025 14:01:20 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1553220043;
 Mon, 31 Mar 2025 14:01:20 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E0CE020040;
 Mon, 31 Mar 2025 14:01:19 +0000 (GMT)
Received: from a46lp68.lnxne.boe (unknown [9.152.108.100])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 31 Mar 2025 14:01:19 +0000 (GMT)
From: Shalini Chellathurai Saroja <shalini@linux.ibm.com>
To: qemu-s390x mailing list <qemu-s390x@nongnu.org>,
 Thomas Huth <thuth@redhat.com>, Daniel Berrange <berrange@redhat.com>
Cc: qemu-devel mailing list <qemu-devel@nongnu.org>,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>,
 Hendrik Brueckner <brueckner@linux.ibm.com>,
 Shalini Chellathurai Saroja <shalini@linux.ibm.com>
Subject: [PATCH v3 1/4] hw/s390x: add SCLP event type CPI
Date: Mon, 31 Mar 2025 16:00:38 +0200
Message-ID: <20250331140041.3133621-2-shalini@linux.ibm.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250331140041.3133621-1-shalini@linux.ibm.com>
References: <20250331140041.3133621-1-shalini@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 1bnmy-D0rlY78GQkLpqL2ZkNr5j0VZiH
X-Proofpoint-ORIG-GUID: 1bnmy-D0rlY78GQkLpqL2ZkNr5j0VZiH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-31_06,2025-03-27_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0
 priorityscore=1501 mlxscore=0 suspectscore=0 lowpriorityscore=0
 clxscore=1015 mlxlogscore=999 phishscore=0 malwarescore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503310100
Received-SPF: pass client-ip=148.163.158.5; envelope-from=shalini@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Implement the Service-Call Logical Processor (SCLP) event
type Control-Program Identification (CPI) in QEMU. This
event is used to send CPI identifiers from the guest to the
host. The CPI identifiers are: system type, system name,
system level and sysplex name.

System type: operating system of the guest (e.g. "LINUX").
System name: user configurable name of the guest (e.g. "TESTVM").
System level: distribution and kernel version, if the system type is Linux
(e.g. 0x50e00).
Sysplex name: name of the cluster which the guest belongs to (if any)
(e.g. "PLEX").

Signed-off-by: Shalini Chellathurai Saroja <shalini@linux.ibm.com>
Reviewed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
---
 hw/s390x/event-facility.c         |  12 ++-
 hw/s390x/meson.build              |   1 +
 hw/s390x/sclpcpi.c                | 133 ++++++++++++++++++++++++++++++
 include/hw/s390x/event-facility.h |   3 +
 4 files changed, 148 insertions(+), 1 deletion(-)
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
index 0000000000..7ace5dd64e
--- /dev/null
+++ b/hw/s390x/sclpcpi.c
@@ -0,0 +1,133 @@
+ /*
+  * SPDX-License-Identifier: GPL-2.0-or-later
+  *
+  * SCLP event type 11 - Control-Program Identification (CPI):
+  *    CPI is used to send program identifiers from the guest to the
+  *    Service-Call Logical Processor (SCLP). It is not sent by the SCLP. The
+  *    program identifiers are: system type, system name, system level and
+  *    sysplex name.  They provide data about the guest operating system.
+  *
+  *    System type, system name, and sysplex name use EBCDIC characters from
+  *    this set: capital A-Z, 0-9, $, @, #, and blank. The system level is a hex
+  *    value. In Linux, the system type, system name and sysplex name are
+  *    arbitrary free-form texts. In Linux, all the control-program identifiers
+  *    are user configurable.
+  *
+  *    System-type: operating system (e.g. "LINUX   ")
+  *
+  *    System-name: user configurable name of the VM (e.g. "TESTVM  ")
+  *
+  *    System-level: distribution and kernel version, if the system-type is
+  *    Linux. On Linux OS, the 8-byte hexadecimal system-level has the format
+  *    0x<a><b><cc><dd><eeee><ff><gg><hh>, where:
+  *    <a>: is one hexadecimal byte, its most significant bit indicates
+  *         hypervisor use
+  *    <b>: is one digit that represents Linux distributions as follows
+  *         0: generic Linux
+  *         1: Red Hat Enterprise Linux
+  *         2: SUSE Linux Enterprise Server
+  *         3: Canonical Ubuntu
+  *         4: Fedora
+  *         5: openSUSE Leap
+  *         6: Debian GNU/Linux
+  *         7: Red Hat Enterprise Linux CoreOS
+  *    <cc>: are two digits for a distribution-specific encoding of the major
+  *          version of the distribution
+  *    <dd>: are two digits for a distribution-specific encoding of the minor
+  *          version of the distribution
+  *    <eeee>: are four digits for the patch level of the distribution
+  *    <ff>: are two digits for the major version of the kernel
+  *    <gg>: are two digits for the minor version of the kernel
+  *    <hh>: are two digits for the stable version of the kernel
+  *    (e.g. 0x010a000000060b00). On machines prior to z16, some of the values
+  *    are not available to display.
+  *
+  *    Sysplex-name: sysplex refers to a cluster of logical partitions that
+  *    communicates and co-operates with each other. Sysplex name is the name of
+  *    the cluster which the guest belongs to (if any). (e.g. "PLEX ")
+  *
+  * Copyright IBM, Corp. 2024
+  *
+  * Authors:
+  *  Shalini Chellathurai Saroja <shalini@linux.ibm.com>
+  *
+  * This work is licensed under the terms of the GNU GPL, version 2 or (at your
+  * option) any later version.  See the COPYING file in the top-level directory.
+  *
+  */
+
+#include "qemu/osdep.h"
+#include "hw/s390x/sclp.h"
+#include "hw/s390x/event-facility.h"
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
+    ControlProgramIdMsg *cpim = container_of(evt_buf_hdr, ControlProgramIdMsg,
+                                             ebh);
+
+    cpim->ebh.flags = SCLP_EVENT_BUFFER_ACCEPTED;
+    return SCLP_RC_NORMAL_COMPLETION;
+}
+
+static void cpi_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    SCLPEventClass *k = SCLP_EVENT_CLASS(klass);
+
+    dc->user_creatable = false;
+
+    k->can_handle_event = can_handle_event;
+    k->get_send_mask = send_mask;
+    k->get_receive_mask = receive_mask;
+    k->write_event_data = write_event_data;
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


