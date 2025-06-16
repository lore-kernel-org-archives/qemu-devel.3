Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECBE3C71155
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Jun 2025 14:02:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRAPB-0004cA-IL; Mon, 16 Jun 2025 10:01:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shalini@linux.ibm.com>)
 id 1uRAP0-0004Rb-Pl; Mon, 16 Jun 2025 10:01:34 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shalini@linux.ibm.com>)
 id 1uRAOy-0002j2-NB; Mon, 16 Jun 2025 10:01:34 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55G9e6eg019152;
 Mon, 16 Jun 2025 14:01:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=723T+Pq0HfpZk9DgT
 jAAoBOMZVMsiA3NltSECIUmWfo=; b=Lwqg/WsNQEFWGhS4HzFv6dWxUgK83229M
 d6YL7bIeupqDPBV3mzZLJvHQo3Kigk/a5sIQCwGP1gbYvH22wS4o26KXpkBld4k4
 DWsM7rDn2jtMycBlaFjV86gn9i8CH75qNL5L2RGsgNGm3SXGzIMmMKREtyNykWrR
 KJaZ6s0ztjn3Wn6zc8GXy2TauaBQ/jLsl1/AsRZ7bosXpiGdK4xbk7tRwY7WD5l6
 dMHyVi3QrX8o5Ft+jFvz1F77qT8vIhrQNhRcExp4kOH8EQoSyUnxfG8bAGes87+q
 1u1fowIqfaOPh+YqYNlYoMen0MR6Kj/0Ar8QomwQhR7SbnHZpzDrw==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 478ygn26c9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 16 Jun 2025 14:01:31 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55GAHhN0014436;
 Mon, 16 Jun 2025 14:01:30 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 479p4261ed-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 16 Jun 2025 14:01:30 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 55GE1QKw33686148
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 16 Jun 2025 14:01:26 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9BD382004D;
 Mon, 16 Jun 2025 14:01:26 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5D23720040;
 Mon, 16 Jun 2025 14:01:26 +0000 (GMT)
Received: from a46lp68.lnxne.boe (unknown [9.152.108.100])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 16 Jun 2025 14:01:26 +0000 (GMT)
From: Shalini Chellathurai Saroja <shalini@linux.ibm.com>
To: qemu-s390x mailing list <qemu-s390x@nongnu.org>,
 Thomas Huth <thuth@redhat.com>
Cc: Daniel Berrange <berrange@redhat.com>,
 qemu-devel mailing list <qemu-devel@nongnu.org>,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>,
 Hendrik Brueckner <brueckner@linux.ibm.com>,
 Shalini Chellathurai Saroja <shalini@linux.ibm.com>
Subject: [PATCH v6 3/3] hw/s390x: support migration of CPI data
Date: Mon, 16 Jun 2025 16:01:07 +0200
Message-ID: <20250616140107.990538-4-shalini@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250616140107.990538-1-shalini@linux.ibm.com>
References: <20250616140107.990538-1-shalini@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE2MDA4NyBTYWx0ZWRfX9lMC0JrypPFt
 teJqHJEwX1fTVqI4fieKHSCrxzhmu6SQb4dN3odJV+oI44JBUI4aXMQosHO71i7FbcCRuU2f2lD
 58fb/lMDUSAaa8PtuoKdf42LDZv/fik7F9ITNtrjdwkAqRydl13NaVAQW5d42eULxIbVSh65VdG
 puuXG8xUZYqdy3phrqjEDb4PUO+UEz/KHbdgjk221zRMmTNZ3pdWomcJ5jvXg4+TLIUpgc/NKx3
 rK9q6amgSqe/GE4aCE4xqBBKPHibG69+TDCE8EaZrCOuus3oa/JVphL++PegM8ojlrspTTRW7/j
 S4QupfdlXA4yKlNeeL8p7+zck3l6262VVXmmjI9ywGGkHEHsMqvsqGIJBNSFNZ1lhxnAOo609l8
 tvyrpJMU5fLgeumDhu7EJ5bcuC43Ro0xPKLuVT9Th9uB4oRCNc+Ikjma9iZAOg6SEc2fA7T1
X-Authority-Analysis: v=2.4 cv=fYSty1QF c=1 sm=1 tr=0 ts=685023bb cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=6IFa9wvqVegA:10 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8 a=IYUaZ1EJS4Y0mmBzySsA:9
X-Proofpoint-ORIG-GUID: RftVm_pSE5nfckn9Y62mUVGiqnq_ST6V
X-Proofpoint-GUID: RftVm_pSE5nfckn9Y62mUVGiqnq_ST6V
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

Register Control-Program Identification data with the live
migration infrastructure.

Signed-off-by: Shalini Chellathurai Saroja <shalini@linux.ibm.com>
Reviewed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 hw/s390x/sclpcpi.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/hw/s390x/sclpcpi.c b/hw/s390x/sclpcpi.c
index 352ef0461d..88012f2279 100644
--- a/hw/s390x/sclpcpi.c
+++ b/hw/s390x/sclpcpi.c
@@ -54,6 +54,7 @@
 #include "hw/s390x/event-facility.h"
 #include "hw/s390x/ebcdic.h"
 #include "qapi/qapi-visit-machine.h"
+#include "migration/vmstate.h"
 
 typedef struct Data {
     uint8_t id_format;
@@ -145,12 +146,26 @@ static void get_timestamp(Object *obj, Visitor *v, const char *name,
     visit_type_uint64(v, name, &e->timestamp, errp);
 }
 
+static const VMStateDescription vmstate_sclpcpi = {
+    .name = "s390_control_program_id",
+    .version_id = 0,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT8_ARRAY(system_type, SCLPEventCPI, 8),
+        VMSTATE_UINT8_ARRAY(system_name, SCLPEventCPI, 8),
+        VMSTATE_UINT64(system_level, SCLPEventCPI),
+        VMSTATE_UINT8_ARRAY(sysplex_name, SCLPEventCPI, 8),
+        VMSTATE_UINT64(timestamp, SCLPEventCPI),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static void cpi_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     SCLPEventClass *k = SCLP_EVENT_CLASS(klass);
 
     dc->user_creatable = false;
+    dc->vmsd =  &vmstate_sclpcpi;
 
     k->can_handle_event = can_handle_event;
     k->get_send_mask = send_mask;
-- 
2.49.0


