Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BF1CC3601E
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Apr 2025 15:11:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2tYT-0000zw-8h; Thu, 10 Apr 2025 11:11:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shalini@linux.ibm.com>)
 id 1u2tY0-0000ye-Pm; Thu, 10 Apr 2025 11:10:32 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shalini@linux.ibm.com>)
 id 1u2tXy-0003cj-7t; Thu, 10 Apr 2025 11:10:32 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53AC2QqC025411;
 Thu, 10 Apr 2025 15:10:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=OS790P1GxEG2J+4R1
 C5LH0MFBeD9dytgF4BBMqmC1Js=; b=eKu2b4Pk+Yo1uwfR/W+cYGSWctkvhH0YU
 +Z4Zqtq+pvlwIWg1a/RGh4P3HcMV3ALZ0GsJQbBhHi8JXm7LlAOVBCIZ1cOC45Pc
 hAuMCxcPI5GZa9jMo8vMX84Ot7YF2ItQ9BzQQCx0ZpumVCqLXbd2APw5XD2EAs5U
 sBIXl+WIHkIcqW8AbATAY/kBnlC15m+hvkcmopnbm6pswYOO+xC6eX2S73SrBE3S
 pErpTicSEkEjyqUd123iaL01yOoO4a1KvXyqGQv3jXpdivz3aT5H2Ckz3shSP2aJ
 d6zLjrZUrLnqvKD+ssjMv5ezI8oGiLuzRrnDOOjelN/Vb+Z55CPvg==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45ww2xeg9y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 10 Apr 2025 15:10:28 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53ADOKVY025522;
 Thu, 10 Apr 2025 15:10:23 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45ugbm6gdn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 10 Apr 2025 15:10:23 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 53AFAJ9x34406956
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 10 Apr 2025 15:10:19 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2CF782004B;
 Thu, 10 Apr 2025 15:10:19 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DD08E20040;
 Thu, 10 Apr 2025 15:10:18 +0000 (GMT)
Received: from a46lp68.lnxne.boe (unknown [9.152.108.100])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 10 Apr 2025 15:10:18 +0000 (GMT)
From: Shalini Chellathurai Saroja <shalini@linux.ibm.com>
To: qemu-s390x mailing list <qemu-s390x@nongnu.org>,
 Thomas Huth <thuth@redhat.com>, Daniel Berrange <berrange@redhat.com>
Cc: qemu-devel mailing list <qemu-devel@nongnu.org>,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>,
 Hendrik Brueckner <brueckner@linux.ibm.com>,
 Shalini Chellathurai Saroja <shalini@linux.ibm.com>
Subject: [PATCH v4 2/4] hw/s390x: add Control-Program Identification to QOM
Date: Thu, 10 Apr 2025 17:09:32 +0200
Message-ID: <20250410150934.1331433-3-shalini@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250410150934.1331433-1-shalini@linux.ibm.com>
References: <20250410150934.1331433-1-shalini@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: AA4waU8bezGuSfW3RAkBst7yQ0payhvR
X-Proofpoint-ORIG-GUID: AA4waU8bezGuSfW3RAkBst7yQ0payhvR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-10_03,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 bulkscore=0
 impostorscore=0 mlxscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 spamscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504100109
Received-SPF: pass client-ip=148.163.158.5; envelope-from=shalini@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Add Control-Program Identification data to the QEMU Object
Model (QOM), along with the timestamp in which the data was received.

Example:
virsh # qemu-monitor-command vm --pretty '{
"execute": "qom-get",
"arguments": {
"path": "/machine/sclp/s390-sclp-event-facility/sclpcpi",
"property": "control-program-id" }}'
{
  "return": {
    "timestamp": 1742390410685762000,
    "system-level": 74872343805430528,
    "sysplex-name": "PLEX ",
    "system-name": "TESTVM  ",
    "system-type": "LINUX   "
  },
  "id": "libvirt-15"
}

Signed-off-by: Shalini Chellathurai Saroja <shalini@linux.ibm.com>
---
 hw/s390x/sclpcpi.c                | 39 +++++++++++++++++++++
 include/hw/s390x/event-facility.h |  9 +++++
 qapi/machine.json                 | 58 +++++++++++++++++++++++++++++++
 3 files changed, 106 insertions(+)

diff --git a/hw/s390x/sclpcpi.c b/hw/s390x/sclpcpi.c
index 13589459b1..dcc8bd3245 100644
--- a/hw/s390x/sclpcpi.c
+++ b/hw/s390x/sclpcpi.c
@@ -18,7 +18,10 @@
   */
 
 #include "qemu/osdep.h"
+#include "qemu/timer.h"
 #include "hw/s390x/event-facility.h"
+#include "hw/s390x/ebcdic.h"
+#include "qapi/qapi-visit-machine.h"
 
 typedef struct Data {
     uint8_t id_format;
@@ -58,11 +61,39 @@ static int write_event_data(SCLPEvent *event, EventBufferHeader *evt_buf_hdr)
 {
     ControlProgramIdMsg *cpim = container_of(evt_buf_hdr, ControlProgramIdMsg,
                                              ebh);
+    SCLPEventCPI *e = SCLP_EVENT_CPI(event);
+
+    ascii_put(e->cpi.system_type, (char *)cpim->data.system_type, 8);
+    ascii_put(e->cpi.system_name, (char *)cpim->data.system_name, 8);
+    ascii_put(e->cpi.sysplex_name, (char *)cpim->data.sysplex_name, 8);
+    e->cpi.system_level = ldq_be_p(&cpim->data.system_level);
+    e->cpi.timestamp = qemu_clock_get_ns(QEMU_CLOCK_HOST);
 
     cpim->ebh.flags = SCLP_EVENT_BUFFER_ACCEPTED;
     return SCLP_RC_NORMAL_COMPLETION;
 }
 
+static void get_control_program_id(Object *obj, Visitor *v,
+                                   const char *name, void *opaque,
+                                   Error **errp)
+{
+    SCLPEventCPI *e = SCLP_EVENT_CPI(obj);
+    S390ControlProgramId *cpi;
+
+    cpi = &(S390ControlProgramId){
+        .system_type = g_strndup((char *) e->cpi.system_type,
+                                 sizeof(e->cpi.system_type)),
+        .system_name = g_strndup((char *) e->cpi.system_name,
+                                 sizeof(e->cpi.system_name)),
+        .system_level = e->cpi.system_level,
+        .sysplex_name = g_strndup((char *) e->cpi.sysplex_name,
+                                  sizeof(e->cpi.sysplex_name)),
+        .timestamp = e->cpi.timestamp
+    };
+
+    visit_type_S390ControlProgramId(v, name, &cpi, errp);
+}
+
 static void cpi_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -74,6 +105,14 @@ static void cpi_class_init(ObjectClass *klass, void *data)
     k->get_send_mask = send_mask;
     k->get_receive_mask = receive_mask;
     k->write_event_data = write_event_data;
+
+    object_class_property_add(klass, "control-program-id",
+                              "S390ControlProgramId",
+                              get_control_program_id,
+                              NULL, NULL, NULL);
+    object_class_property_set_description(klass, "control-program-id",
+        "Control-program identifiers provide data about the guest "
+        "operating system");
 }
 
 static const TypeInfo sclp_cpi_info = {
diff --git a/include/hw/s390x/event-facility.h b/include/hw/s390x/event-facility.h
index ef469e62ae..123c4ac49c 100644
--- a/include/hw/s390x/event-facility.h
+++ b/include/hw/s390x/event-facility.h
@@ -199,9 +199,18 @@ typedef struct SCLPEventCPI SCLPEventCPI;
 OBJECT_DECLARE_TYPE(SCLPEventCPI, SCLPEventCPIClass,
                     SCLP_EVENT_CPI)
 
+typedef struct ControlProgramId {
+    uint8_t system_type[8];
+    uint8_t system_name[8];
+    uint64_t system_level;
+    uint8_t sysplex_name[8];
+    uint64_t timestamp;
+} ControlProgramId;
+
 struct SCLPEventCPI {
     DeviceState qdev;
     SCLPEvent event;
+    ControlProgramId cpi;
 };
 
 #define TYPE_SCLP_EVENT_FACILITY "s390-sclp-event-facility"
diff --git a/qapi/machine.json b/qapi/machine.json
index a6b8795b09..cd2bcd2d13 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -1898,3 +1898,61 @@
 { 'command': 'x-query-interrupt-controllers',
   'returns': 'HumanReadableText',
   'features': [ 'unstable' ]}
+
+##
+# @S390ControlProgramId:
+#
+# Control-program identifiers provide data about the guest operating system.
+# The control-program identifiers are: system type, system name, system level
+# and sysplex name.
+#
+# In Linux, all the control-program identifiers are user configurable. The
+# system type, system name, and sysplex name use EBCDIC characters from
+# this set: capital A-Z, 0-9, $, @, #, and blank.  In Linux, the system type,
+# system name and sysplex name are arbitrary free-form texts.
+#
+# In Linux, the 8-byte hexadecimal system-level has the format
+# 0x<a><b><cc><dd><eeee><ff><gg><hh>, where:
+# <a>: is one hexadecimal byte, its most significant bit indicates hypervisor
+# use
+# <b>: is one digit that represents Linux distributions as follows
+# 0: generic Linux
+# 1: Red Hat Enterprise Linux
+# 2: SUSE Linux Enterprise Server
+# 3: Canonical Ubuntu
+# 4: Fedora
+# 5: openSUSE Leap
+# 6: Debian GNU/Linux
+# 7: Red Hat Enterprise Linux CoreOS
+# <cc>: are two digits for a distribution-specific encoding of the major version
+# of the distribution
+# <dd>: are two digits for a distribution-specific encoding of the minor version
+# of the distribution
+# <eeee>: are four digits for the patch level of the distribution
+# <ff>: are two digits for the major version of the kernel
+# <gg>: are two digits for the minor version of the kernel
+# <hh>: are two digits for the stable version of the kernel
+# (e.g. 74872343805430528, when converted to hex is 0x010a000000060b00). On
+# machines prior to z16, some of the values are not available to display.
+#
+# Sysplex refers to a cluster of logical partitions that communicates and
+# co-operates with each other.
+#
+# @system-type: operating system (e.g. "LINUX   ")
+#
+# @system-name: user configurable name of the VM (e.g. "TESTVM  ")
+#
+# @system-level: distribution and kernel version in Linux
+#
+# @sysplex-name: sysplex which the VM belongs to, if any (e.g. "PLEX ")
+#
+# @timestamp: latest update of CPI data in nanoseconds since the UNIX EPOCH
+#
+# Since: 10.0
+##
+{ 'struct': 'S390ControlProgramId', 'data': {
+     'system-type': 'str',
+     'system-name': 'str',
+     'system-level': 'uint64',
+     'sysplex-name': 'str',
+     'timestamp': 'uint64' } }
-- 
2.49.0


