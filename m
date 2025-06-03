Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78694C61CE5
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 13:58:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMS8p-0002tX-K5; Tue, 03 Jun 2025 09:57:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shalini@linux.ibm.com>)
 id 1uMS8m-0002sw-OR; Tue, 03 Jun 2025 09:57:20 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shalini@linux.ibm.com>)
 id 1uMS8f-0004Lh-PP; Tue, 03 Jun 2025 09:57:20 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5537Jicl019326;
 Tue, 3 Jun 2025 13:57:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=OQmINx8T3y9xOi+1k
 ApS0skKtU1RofciDPRKO0qlAMc=; b=aT/Fzt1GRzAvg4nSAO2Qh+RtT5ydil1Bt
 J+jW8iQcNrFrXJG90uhl/V23E9QWlehDpk8PGdnQbIKA1yRkJH6VObXIsSYCsQEC
 ZaDB2dm5joEo7CRaVwDuSEGCI3kq0BSzsH9V2+a+KQlKKOcdXVCy+22wvloyx0Bh
 2mfjDDC8qqOryvxVigdrSnn9ExmmmQVsZTebsVXzQ9ZX+X/w7EICRuOJepSlp3MW
 tdLEUmjikhZMO4TZulDDe7JZzBUg0sZ5RDb7hw3EK2fozJR3vu3E8mnbfagbO4O5
 Yb7ODhjuXZ+UIC8N3vz2AhWoHirrouHFoCMrzbVRsQUHZAfewIy6A==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 471geymuth-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 03 Jun 2025 13:57:09 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 553DrGL5024754;
 Tue, 3 Jun 2025 13:57:08 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 470dkmb0s2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 03 Jun 2025 13:57:08 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 553Dv4SA30081384
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 3 Jun 2025 13:57:04 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 21E052004D;
 Tue,  3 Jun 2025 13:57:04 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CF46F20049;
 Tue,  3 Jun 2025 13:57:03 +0000 (GMT)
Received: from a46lp68.lnxne.boe (unknown [9.152.108.100])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  3 Jun 2025 13:57:03 +0000 (GMT)
From: Shalini Chellathurai Saroja <shalini@linux.ibm.com>
To: qemu-s390x mailing list <qemu-s390x@nongnu.org>,
 Thomas Huth <thuth@redhat.com>
Cc: Daniel Berrange <berrange@redhat.com>,
 qemu-devel mailing list <qemu-devel@nongnu.org>,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>,
 Hendrik Brueckner <brueckner@linux.ibm.com>,
 Shalini Chellathurai Saroja <shalini@linux.ibm.com>
Subject: [PATCH v5 2/3] hw/s390x: add Control-Program Identification to QOM
Date: Tue,  3 Jun 2025 15:56:54 +0200
Message-ID: <20250603135655.595602-3-shalini@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250603135655.595602-1-shalini@linux.ibm.com>
References: <20250603135655.595602-1-shalini@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 5zy2rH2IyQo85sEJHyGayRdRaD9bzvSs
X-Authority-Analysis: v=2.4 cv=DYMXqutW c=1 sm=1 tr=0 ts=683eff35 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=6IFa9wvqVegA:10 a=VnNF1IyMAAAA:8 a=QWFg5UiSIRAATzpd3y4A:9
X-Proofpoint-GUID: 5zy2rH2IyQo85sEJHyGayRdRaD9bzvSs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjAzMDExNyBTYWx0ZWRfX6c0pF7j5wDeW
 I4AGZHcebOeWoqhX29fBjvTSQ23CNyIV2RRrpl9vAp9TRuRGjfJBQU7aUmpDhrjEn+zgowyoBpV
 7PKxAZzvFIRGbx91WusK4MvzORryI9Q08TUFtudfovvtGnak+pw6oXlHhf2ezxTnS0ISNOo9Jhn
 iowAPXgR1JK1uE4Q8sNLsWO3Ph7t9JC9l1nyAwBx1uS2Sj+LIY9fGhJXoiRr0yzhz/VVB9RBhdS
 MmW+42EwqVqfFfY5vYEc32Gu7Wc05ZJ+wE7ThAWZ0J+iwZ8EzXAu/YofLvbEm0Zzm/a6zx9odtM
 x95LNcJiP1Y5VqSRMsKu0DzWZD+eDXyiGbWfIreEAZs8YvZntamyTYQRVbeXc3QevHhxO8GyhYX
 +6n3GstcB4GZG/Ti3rHcZrLvojV9MBzTb0321YSwdeRUdBW6xrOZcC1QEu2pBLS6PS0nA3Qh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-03_01,2025-06-02_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 lowpriorityscore=0 suspectscore=0 spamscore=0 mlxscore=0
 priorityscore=1501 clxscore=1015 phishscore=0 mlxlogscore=999 adultscore=0
 malwarescore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506030117
Received-SPF: pass client-ip=148.163.156.1; envelope-from=shalini@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Add Control-Program Identification (CPI) data to the QEMU Object
Model (QOM), along with the timestamp in which the data was received
as shown below.

virsh # qemu-monitor-command vm --pretty '{"execute":"qom-list",
"arguments":{"path":"/machine/sclp/s390-sclp-event-facility/sclpcpi"}}'
{
  "return": [
    [...]
    {
      "name": "system_level",
      "type": "uint64"
    },
    {
      "name": "system_name",
      "type": "string"
    },
    {
      "name": "system_type",
      "type": "string"
    },
    {
      "name": "timestamp",
      "type": "uint64"
    },
    {
      "name": "sysplex_name",
      "type": "string"
    }
  ],
  "id": "libvirt-14"
}

Example CPI data:
virsh # qemu-monitor-command vm --pretty '{"execute":"qom-get",
"arguments":{"path":"/machine/sclp/s390-sclp-event-facility/sclpcpi",
"property":"system_type"}}'
{
  "return": "LINUX   ",
  "id": "libvirt-18"
}
virsh # qemu-monitor-command vm --pretty '{"execute":"qom-get",
"arguments":{"path":"/machine/sclp/s390-sclp-event-facility/sclpcpi",
"property":"system_name"}}'
{
  "return": "TESTVM  ",
  "id": "libvirt-19"
}
virsh # qemu-monitor-command vm --pretty '{"execute":"qom-get",
"arguments":{"path":"/machine/sclp/s390-sclp-event-facility/sclpcpi",
"property":"sysplex_name"}}'
{
  "return": "PLEX    ",
  "id": "libvirt-20"
}
virsh # qemu-monitor-command vm --pretty '{"execute":"qom-get",
"arguments":{"path":"/machine/sclp/s390-sclp-event-facility/sclpcpi",
"property":"system_level"}}'
{
  "return": 74872343805430528,
  "id": "libvirt-21"
}
virsh # qemu-monitor-command vm --pretty '{"execute":"qom-get",
"arguments":{"path":"/machine/sclp/s390-sclp-event-facility/sclpcpi",
"property":"timestamp"}}'
{
  "return": 1748866753433923000,
  "id": "libvirt-22"
}

Signed-off-by: Shalini Chellathurai Saroja <shalini@linux.ibm.com>
---
 hw/s390x/sclpcpi.c                | 47 +++++++++++++++++++++++++
 include/hw/s390x/event-facility.h |  5 +++
 qapi/machine.json                 | 58 +++++++++++++++++++++++++++++++
 3 files changed, 110 insertions(+)

diff --git a/hw/s390x/sclpcpi.c b/hw/s390x/sclpcpi.c
index 935fa87acd..ec711e2291 100644
--- a/hw/s390x/sclpcpi.c
+++ b/hw/s390x/sclpcpi.c
@@ -15,7 +15,9 @@
   */
 
 #include "qemu/osdep.h"
+#include "qemu/timer.h"
 #include "hw/s390x/event-facility.h"
+#include "hw/s390x/ebcdic.h"
 
 typedef struct Data {
     uint8_t id_format;
@@ -55,11 +57,42 @@ static int write_event_data(SCLPEvent *event, EventBufferHeader *evt_buf_hdr)
 {
     ControlProgramIdMsg *cpim = container_of(evt_buf_hdr, ControlProgramIdMsg,
                                              ebh);
+    SCLPEventCPI *e = SCLP_EVENT_CPI(event);
+
+    ascii_put(e->system_type, (char *)cpim->data.system_type,
+              sizeof(cpim->data.system_type));
+    ascii_put(e->system_name, (char *)cpim->data.system_name,
+              sizeof(cpim->data.system_name));
+    ascii_put(e->sysplex_name, (char *)cpim->data.sysplex_name,
+              sizeof(cpim->data.sysplex_name));
+    e->system_level = ldq_be_p(&cpim->data.system_level);
+    e->timestamp = qemu_clock_get_ns(QEMU_CLOCK_HOST);
 
     cpim->ebh.flags = SCLP_EVENT_BUFFER_ACCEPTED;
     return SCLP_RC_NORMAL_COMPLETION;
 }
 
+static char *get_system_type(Object *obj, Error **errp)
+{
+    SCLPEventCPI *e = SCLP_EVENT_CPI(obj);
+
+    return g_strndup((char *) e->system_type, sizeof(e->system_type));
+}
+
+static char *get_system_name(Object *obj, Error **errp)
+{
+    SCLPEventCPI *e = SCLP_EVENT_CPI(obj);
+
+    return g_strndup((char *) e->system_name, sizeof(e->system_name));
+}
+
+static char *get_sysplex_name(Object *obj, Error **errp)
+{
+    SCLPEventCPI *e = SCLP_EVENT_CPI(obj);
+
+    return g_strndup((char *) e->sysplex_name, sizeof(e->sysplex_name));
+}
+
 static void cpi_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -73,10 +106,24 @@ static void cpi_class_init(ObjectClass *klass, const void *data)
     k->write_event_data = write_event_data;
 }
 
+static void cpi_init(Object *obj)
+{
+    SCLPEventCPI *e = SCLP_EVENT_CPI(obj);
+
+    object_property_add_str(obj, "system_type", get_system_type, NULL);
+    object_property_add_str(obj, "system_name", get_system_name, NULL);
+    object_property_add_str(obj, "sysplex_name", get_sysplex_name, NULL);
+    object_property_add_uint64_ptr(obj, "system_level", &(e->system_level),
+                                   OBJ_PROP_FLAG_READ);
+    object_property_add_uint64_ptr(obj, "timestamp", &(e->timestamp),
+                                   OBJ_PROP_FLAG_READ);
+}
+
 static const TypeInfo sclp_cpi_info = {
     .name          = TYPE_SCLP_EVENT_CPI,
     .parent        = TYPE_SCLP_EVENT,
     .instance_size = sizeof(SCLPEventCPI),
+    .instance_init = cpi_init,
     .class_init    = cpi_class_init,
 };
 
diff --git a/include/hw/s390x/event-facility.h b/include/hw/s390x/event-facility.h
index e81bc80498..eac7a51100 100644
--- a/include/hw/s390x/event-facility.h
+++ b/include/hw/s390x/event-facility.h
@@ -201,6 +201,11 @@ OBJECT_DECLARE_TYPE(SCLPEventCPI, SCLPEventCPIClass,
 
 struct SCLPEventCPI {
     SCLPEvent event;
+    uint8_t system_type[8];
+    uint8_t system_name[8];
+    uint64_t system_level;
+    uint8_t sysplex_name[8];
+    uint64_t timestamp;
 };
 
 #define TYPE_SCLP_EVENT_FACILITY "s390-sclp-event-facility"
diff --git a/qapi/machine.json b/qapi/machine.json
index 5373e1368c..1f2db68032 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -2279,3 +2279,61 @@
 # Since: 1.2
 ##
 { 'command': 'query-cpu-definitions', 'returns': ['CpuDefinitionInfo'] }
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
+# Since: 10.1
+##
+{ 'struct': 'S390ControlProgramId', 'data': {
+     'system-type': 'str',
+     'system-name': 'str',
+     'system-level': 'uint64',
+     'sysplex-name': 'str',
+     'timestamp': 'uint64' } }
-- 
2.49.0


