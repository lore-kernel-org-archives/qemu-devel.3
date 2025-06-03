Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2715C5AE59
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 13:58:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMS8k-0002rA-Ph; Tue, 03 Jun 2025 09:57:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shalini@linux.ibm.com>)
 id 1uMS8h-0002q0-PH; Tue, 03 Jun 2025 09:57:15 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shalini@linux.ibm.com>)
 id 1uMS8e-0004Lo-JY; Tue, 03 Jun 2025 09:57:14 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5535t5HL032519;
 Tue, 3 Jun 2025 13:57:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=lZT+M675yQzwY6sJ3
 bP6ppPy4ZUlcZnaoD9UuowffU8=; b=HKOR+4+T8HMeekmcmEXth1YiKOLCfAOvM
 gRUrh0vjIgyHkTcHMbtCVxLRDak7ANqon9a6w0Re+whg1uWh3lE6F5SWaPU554NV
 mZNa+oc25O4y2EZHkw3xY3f2zK+m4dw3FBTgV1iy7rfL8RPjq68vHDYEV+S7Pk22
 cMXwJ4R1/u9RdxremhFt4UUv06lyLpQqL8YkCW34+sMb6eM0r56bMfol6aIVGBv/
 X9/UGmF4EZOJn3h5Z4qBSq026UZ3JawFJFbbydZtXky9Jqg17CY7yVUuqZrIbZcL
 y7f0jfFpmOHjydyzXAeFdkB6w6mGodnA+XmEoZWKH8F6hQckWChJA==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 471gf04t5t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 03 Jun 2025 13:57:10 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 553A7sx7022518;
 Tue, 3 Jun 2025 13:57:10 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 470c3tba13-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 03 Jun 2025 13:57:10 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 553Dv64v33227420
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 3 Jun 2025 13:57:06 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 850162004B;
 Tue,  3 Jun 2025 13:57:06 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 422DB20049;
 Tue,  3 Jun 2025 13:57:06 +0000 (GMT)
Received: from a46lp68.lnxne.boe (unknown [9.152.108.100])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  3 Jun 2025 13:57:06 +0000 (GMT)
From: Shalini Chellathurai Saroja <shalini@linux.ibm.com>
To: qemu-s390x mailing list <qemu-s390x@nongnu.org>,
 Thomas Huth <thuth@redhat.com>
Cc: Daniel Berrange <berrange@redhat.com>,
 qemu-devel mailing list <qemu-devel@nongnu.org>,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>,
 Hendrik Brueckner <brueckner@linux.ibm.com>,
 Shalini Chellathurai Saroja <shalini@linux.ibm.com>
Subject: [PATCH v5 3/3] hw/s390x: support migration of CPI data
Date: Tue,  3 Jun 2025 15:56:55 +0200
Message-ID: <20250603135655.595602-4-shalini@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250603135655.595602-1-shalini@linux.ibm.com>
References: <20250603135655.595602-1-shalini@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: MITLKln34ki6wPqoi0MNoqH6N0lQUfh1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjAzMDExNyBTYWx0ZWRfXyhFvhZAUcQgy
 wFZvch107WkbmRZOlBCiPISrRat3dT6y0spp4wotn5c0qki+g/LxEYW32Vxjk0DRtjQ7GF1siWo
 /RPl0hcoq7rLXojBZn5mBWm7t4GSSxxxqLEKv5JZQQ92KC3995641FT/gqkd1go198QWdgnRGOP
 +2bsnb2t+4Z1ls0z1TX1CxnWwlKIq0ixPI/YAT9CMnKiMljz4nEgdu4zI4n0DbvhtWCW2n64M59
 fC1rFrEU3biWOB7G95RjV+y5d0V1wVNkwgrrkDAqtdj1HNKf/FDDhBVje286ohTr5kwmG0Y879h
 eXAQU2wAJf3r1PqKATASf+17gU5sTgsiAsVnQpW5VkQjgZky7CltZprMglQCiW19WwoEKnmdTTI
 K0PC6Wi02rcApb1GITfu+2dO78yrwb0HU/aEW+VAD9DqNFT45y2UfDtz0rbzP6exCfz6XECV
X-Proofpoint-ORIG-GUID: MITLKln34ki6wPqoi0MNoqH6N0lQUfh1
X-Authority-Analysis: v=2.4 cv=c+WrQQ9l c=1 sm=1 tr=0 ts=683eff36 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=6IFa9wvqVegA:10 a=VnNF1IyMAAAA:8 a=xxl9de-Fxz7HayD7txoA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-03_01,2025-06-02_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 spamscore=0
 priorityscore=1501 mlxlogscore=999 phishscore=0 adultscore=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506030117
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

Register Control-Program Identification data with the live
migration infrastructure.

Signed-off-by: Shalini Chellathurai Saroja <shalini@linux.ibm.com>
Reviewed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
---
 hw/s390x/sclpcpi.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/hw/s390x/sclpcpi.c b/hw/s390x/sclpcpi.c
index ec711e2291..12664b0a57 100644
--- a/hw/s390x/sclpcpi.c
+++ b/hw/s390x/sclpcpi.c
@@ -18,6 +18,7 @@
 #include "qemu/timer.h"
 #include "hw/s390x/event-facility.h"
 #include "hw/s390x/ebcdic.h"
+#include "migration/vmstate.h"
 
 typedef struct Data {
     uint8_t id_format;
@@ -93,12 +94,26 @@ static char *get_sysplex_name(Object *obj, Error **errp)
     return g_strndup((char *) e->sysplex_name, sizeof(e->sysplex_name));
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


