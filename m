Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D563C71155
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Jun 2025 14:02:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRAPB-0004d6-UQ; Mon, 16 Jun 2025 10:01:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shalini@linux.ibm.com>)
 id 1uRAP0-0004Rc-RB; Mon, 16 Jun 2025 10:01:34 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shalini@linux.ibm.com>)
 id 1uRAOx-0002ii-BK; Mon, 16 Jun 2025 10:01:34 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55G8kg2A001010;
 Mon, 16 Jun 2025 14:01:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=TvaKeCJ9wkuFXOPoD
 +ecHwOPzz4cDiIzrRBppoJJWik=; b=X1al+yhOUGernp6yYGK/YGPskN3O2eCcE
 apn6Qhrw6xtaNHM1xWT0k0Fhf40g+i3R6EJxF36eVZIDXYDL0osivW1CmfnvqIn+
 iuhphSEyRDLxSP1vCFE2QYrsl79omwA0v00zWI4+Y0rT8tWXZolcwDaa3WS5+IKP
 bgrTc7KnuFKPF6s+V2cOkL5jFVekWemNv7ckOU3nI+mv1HDdIgfR20SznkyOY2iG
 rENrUBIO1nHe3BvtYZRVa6lrfiGrHt+ZcxkzIXbTL7YT0eYujA8htLLqgEi0h/Xi
 p8vw+OdVmBAyhiK1PF679yUNdOxb3XlhwmnHfe3mDAQeBUS+hSi1w==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 478ygn26c3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 16 Jun 2025 14:01:29 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55GCM72T027540;
 Mon, 16 Jun 2025 14:01:28 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 479ksypgp6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 16 Jun 2025 14:01:28 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 55GE1ODP35848660
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 16 Jun 2025 14:01:25 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DBC9220043;
 Mon, 16 Jun 2025 14:01:24 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9CBA620063;
 Mon, 16 Jun 2025 14:01:24 +0000 (GMT)
Received: from a46lp68.lnxne.boe (unknown [9.152.108.100])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 16 Jun 2025 14:01:24 +0000 (GMT)
From: Shalini Chellathurai Saroja <shalini@linux.ibm.com>
To: qemu-s390x mailing list <qemu-s390x@nongnu.org>,
 Thomas Huth <thuth@redhat.com>
Cc: Daniel Berrange <berrange@redhat.com>,
 qemu-devel mailing list <qemu-devel@nongnu.org>,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>,
 Hendrik Brueckner <brueckner@linux.ibm.com>,
 Shalini Chellathurai Saroja <shalini@linux.ibm.com>
Subject: [PATCH v6 2/3] hw/s390x: add Control-Program Identification to QOM
Date: Mon, 16 Jun 2025 16:01:06 +0200
Message-ID: <20250616140107.990538-3-shalini@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250616140107.990538-1-shalini@linux.ibm.com>
References: <20250616140107.990538-1-shalini@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE2MDA4NyBTYWx0ZWRfX0RyuGllT7W8r
 AB76JJVoDnNMQXSWExPPzMeRWVx0GDiN6NTXVkK37rW6Jie7UAjbIGEHfhBS003x7y1RtgGoeUK
 3RgTkjwq/ExbizaUqbKKcCkvvPGlfHWgZ93x0L4LLT82GiDzHr/n3J8S9Z3eEoMRcrLs65FhXXb
 F9VKfKeib2uJvZOsLCI/tVEpa97Yr3vLQhIbr5rVq/Gwm4rGbCl76tPSFYmeaAm6mgSOqJXFISa
 Ylj4o8apXI9BWFkK8jRJDCsU7sXG3ZPUzyw+keznz1Jsbv+dd5mRncGfwp/cd5uWUmbIWg4p9fJ
 Ogl04qvgHx8x2xNQMT6Br1C90nlLixOiCRVVg6+tGA7iEtfhZdyBqZJp4U2xtaenn//OSWQEFE5
 ge+LHSPBKcIGyf+XE1Kpi9+ijFCaeDlamUq+K90c7oteF3peFqKkTY7H2F8F10Xt05AhkTc0
X-Authority-Analysis: v=2.4 cv=fYSty1QF c=1 sm=1 tr=0 ts=685023b9 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=6IFa9wvqVegA:10 a=VnNF1IyMAAAA:8 a=gMOc093ePyEJ564YuRcA:9
X-Proofpoint-ORIG-GUID: GFByneYb6mgkW962qC_II1E0CqO7C8ZJ
X-Proofpoint-GUID: GFByneYb6mgkW962qC_II1E0CqO7C8ZJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-16_06,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0
 spamscore=0 mlxlogscore=999 lowpriorityscore=0 adultscore=0 mlxscore=0
 impostorscore=0 bulkscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506160087
Received-SPF: pass client-ip=148.163.158.5; envelope-from=shalini@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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
 hw/s390x/sclpcpi.c                | 74 +++++++++++++++++++++++++++++++
 include/hw/s390x/event-facility.h |  5 +++
 2 files changed, 79 insertions(+)

diff --git a/hw/s390x/sclpcpi.c b/hw/s390x/sclpcpi.c
index a0b175c5d5..352ef0461d 100644
--- a/hw/s390x/sclpcpi.c
+++ b/hw/s390x/sclpcpi.c
@@ -50,7 +50,10 @@
   */
 
 #include "qemu/osdep.h"
+#include "qemu/timer.h"
 #include "hw/s390x/event-facility.h"
+#include "hw/s390x/ebcdic.h"
+#include "qapi/qapi-visit-machine.h"
 
 typedef struct Data {
     uint8_t id_format;
@@ -90,11 +93,58 @@ static int write_event_data(SCLPEvent *event, EventBufferHeader *evt_buf_hdr)
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
+static void get_system_level(Object *obj, Visitor *v, const char *name,
+                             void *opaque, Error **errp)
+{
+    SCLPEventCPI *e = SCLP_EVENT_CPI(obj);
+
+    visit_type_uint64(v, name, &e->system_level, errp);
+}
+
+static void get_timestamp(Object *obj, Visitor *v, const char *name,
+                             void *opaque, Error **errp)
+{
+    SCLPEventCPI *e = SCLP_EVENT_CPI(obj);
+
+    visit_type_uint64(v, name, &e->timestamp, errp);
+}
+
 static void cpi_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -106,6 +156,30 @@ static void cpi_class_init(ObjectClass *klass, const void *data)
     k->get_send_mask = send_mask;
     k->get_receive_mask = receive_mask;
     k->write_event_data = write_event_data;
+
+    object_class_property_add_str(klass, "system_type", get_system_type, NULL);
+    object_class_property_set_description(klass, "system_type",
+            "operating system e.g. \"LINUX   \"");
+
+    object_class_property_add_str(klass, "system_name", get_system_name, NULL);
+    object_class_property_set_description(klass, "system_name",
+            "user configurable name of the VM e.g. \"TESTVM  \"");
+
+    object_class_property_add_str(klass, "sysplex_name", get_sysplex_name,
+                                  NULL);
+    object_class_property_set_description(klass, "sysplex_name",
+            "name of the cluster which the VM belongs to, if any"
+            " e.g. \"PLEX    \"");
+
+    object_class_property_add(klass, "system_level", "uint64", get_system_level,
+                              NULL, NULL, NULL);
+    object_class_property_set_description(klass, "system_level",
+            "distribution and kernel version in Linux e.g. 74872343805430528");
+
+    object_class_property_add(klass, "timestamp", "uint64", get_timestamp,
+                              NULL, NULL, NULL);
+    object_class_property_set_description(klass, "timestamp",
+            "latest update of CPI data in nanoseconds since the UNIX EPOCH");
 }
 
 static const TypeInfo sclp_cpi_info = {
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
-- 
2.49.0


