Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E99ABC3600B
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Mar 2025 14:03:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzFiK-0007LI-Ez; Mon, 31 Mar 2025 10:02:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shalini@linux.ibm.com>)
 id 1tzFht-0007HL-HW; Mon, 31 Mar 2025 10:01:41 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shalini@linux.ibm.com>)
 id 1tzFhn-00030d-VZ; Mon, 31 Mar 2025 10:01:40 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52V3811f005616;
 Mon, 31 Mar 2025 14:01:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=pGz7E8dyg/dBFQdT8
 KG0w7LeUQrO6Gdqeeau2u5ger4=; b=LqaRg30cqXj6legcNjL2QlO2zjSZJEHkl
 WN5cnGL52hOAN9ZYGeh34opFBPaP4YAKhnmAZjdGyZHKVtpHy8nhACwMHajPqwF/
 eDM3kBAmWBn2lNG17vtWrmcmY4WxoNR9C45Qg4sF4KsZR0Xd561qAK5w4O+8sp54
 coY1XK1GLb2VWI0o95X6NUH4EFmXv8dvGnOilBBeUOFnDUNCgikXTNtS4lgEGkj9
 0FZLGgh2HYrYcv03f3mk59G+2L1X3xZUUsRzuz9u0i5F5fXQeWHqlZwzf4G49MCM
 4pquFNKhMq9sxWeCftckdkuaPFjW/cNP2VDpTU6tCS8MnXhIQIjPQ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45q7cpvk0f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 31 Mar 2025 14:01:33 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52VDvQRs004829;
 Mon, 31 Mar 2025 14:01:32 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45pujyp6r3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 31 Mar 2025 14:01:32 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 52VE1SN541157098
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 31 Mar 2025 14:01:28 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8567820043;
 Mon, 31 Mar 2025 14:01:28 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 644DC20040;
 Mon, 31 Mar 2025 14:01:28 +0000 (GMT)
Received: from a46lp68.lnxne.boe (unknown [9.152.108.100])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 31 Mar 2025 14:01:28 +0000 (GMT)
From: Shalini Chellathurai Saroja <shalini@linux.ibm.com>
To: qemu-s390x mailing list <qemu-s390x@nongnu.org>,
 Thomas Huth <thuth@redhat.com>, Daniel Berrange <berrange@redhat.com>
Cc: qemu-devel mailing list <qemu-devel@nongnu.org>,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>,
 Hendrik Brueckner <brueckner@linux.ibm.com>,
 Shalini Chellathurai Saroja <shalini@linux.ibm.com>
Subject: [PATCH v3 2/4] hw/s390x: add Control-Program Identification to QOM
Date: Mon, 31 Mar 2025 16:00:39 +0200
Message-ID: <20250331140041.3133621-3-shalini@linux.ibm.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250331140041.3133621-1-shalini@linux.ibm.com>
References: <20250331140041.3133621-1-shalini@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: wmHu0VRHIhI5THlp-UoPffBIekDEH4z0
X-Proofpoint-GUID: wmHu0VRHIhI5THlp-UoPffBIekDEH4z0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-31_06,2025-03-27_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 mlxlogscore=999
 phishscore=0 spamscore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503310100
Received-SPF: pass client-ip=148.163.156.1; envelope-from=shalini@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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
 hw/s390x/sclpcpi.c                | 38 ++++++++++++++++++++
 include/hw/s390x/event-facility.h |  9 +++++
 qapi/machine.json                 | 58 +++++++++++++++++++++++++++++++
 3 files changed, 105 insertions(+)

diff --git a/hw/s390x/sclpcpi.c b/hw/s390x/sclpcpi.c
index 7ace5dd64e..969c15e43d 100644
--- a/hw/s390x/sclpcpi.c
+++ b/hw/s390x/sclpcpi.c
@@ -57,8 +57,11 @@
   */
 
 #include "qemu/osdep.h"
+#include "qemu/timer.h"
 #include "hw/s390x/sclp.h"
 #include "hw/s390x/event-facility.h"
+#include "hw/s390x/ebcdic.h"
+#include "qapi/qapi-visit-machine.h"
 
 typedef struct Data {
     uint8_t id_format;
@@ -99,10 +102,37 @@ static int write_event_data(SCLPEvent *event, EventBufferHeader *evt_buf_hdr)
     ControlProgramIdMsg *cpim = container_of(evt_buf_hdr, ControlProgramIdMsg,
                                              ebh);
 
+    ascii_put(event->cpi.system_type, (char *)cpim->data.system_type, 8);
+    ascii_put(event->cpi.system_name, (char *)cpim->data.system_name, 8);
+    ascii_put(event->cpi.sysplex_name, (char *)cpim->data.sysplex_name, 8);
+    event->cpi.system_level = ldq_be_p(&cpim->data.system_level);
+    event->cpi.timestamp = qemu_clock_get_ns(QEMU_CLOCK_HOST);
+
     cpim->ebh.flags = SCLP_EVENT_BUFFER_ACCEPTED;
     return SCLP_RC_NORMAL_COMPLETION;
 }
 
+static void get_control_program_id(Object *obj, Visitor *v,
+                                   const char *name, void *opaque,
+                                   Error **errp)
+{
+    SCLPEvent *event = (SCLPEvent *)(obj);
+    S390ControlProgramId *cpi;
+
+    cpi = &(S390ControlProgramId){
+        .system_type = g_strndup((char *) event->cpi.system_type,
+                                 sizeof(event->cpi.system_type)),
+        .system_name = g_strndup((char *) event->cpi.system_name,
+                                 sizeof(event->cpi.system_name)),
+        .system_level = event->cpi.system_level,
+        .sysplex_name = g_strndup((char *) event->cpi.sysplex_name,
+                                  sizeof(event->cpi.sysplex_name)),
+        .timestamp = event->cpi.timestamp
+    };
+
+    visit_type_S390ControlProgramId(v, name, &cpi, errp);
+}
+
 static void cpi_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -114,6 +144,14 @@ static void cpi_class_init(ObjectClass *klass, void *data)
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
index f445d2f9f5..39e589ed44 100644
--- a/include/hw/s390x/event-facility.h
+++ b/include/hw/s390x/event-facility.h
@@ -169,10 +169,19 @@ typedef struct ReadEventData {
     };
 } QEMU_PACKED ReadEventData;
 
+typedef struct ControlProgramId {
+    uint8_t system_type[8];
+    uint8_t system_name[8];
+    uint64_t system_level;
+    uint8_t sysplex_name[8];
+    uint64_t timestamp;
+} QEMU_PACKED ControlProgramId;
+
 struct SCLPEvent {
     DeviceState qdev;
     bool event_pending;
     char *name;
+    ControlProgramId cpi;
 };
 
 struct SCLPEventClass {
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
2.47.0


