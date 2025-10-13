Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BAA0CCD183
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Oct 2025 13:39:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8Ilk-0006sy-JA; Mon, 13 Oct 2025 09:39:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shalini@linux.ibm.com>)
 id 1v8Ili-0006r5-Mt; Mon, 13 Oct 2025 09:39:18 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shalini@linux.ibm.com>)
 id 1v8Ilg-0006eb-0Z; Mon, 13 Oct 2025 09:39:18 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59D87kNu030866;
 Mon, 13 Oct 2025 13:39:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=RQK9MLjga+hZqSIzn/UHdKK52IFbjEuxbfDWg6J09
 fU=; b=YAMIuiS03RBV+WczP/nxU9JRrMxJ9oWw7ACYkEPUpUmE6XsrZDlcQbDhr
 QiiepK5aU0zTPHimyoSShODF8DFZh3JVsQ2zVx5CbZOnzOdsZiaJIt8PUKXgwVUn
 MK4xV73hlKeoKGeso6Q+cIgkyC9VNkRtDVBCAMKjmpHq3pJxLGWC55KddCYBCnYt
 krihFpRpBWtrG47FkjuQrwgA92uZAb8uVDNzvUHzIPmlZ5keK/kB1LUCPxLwgPIF
 RsnNoqBccE9Q32o5CNtHLjiEppRKcHZbURCgq1ArkKos6Q8pgORuuMedCT5LZQls
 /+78gNt/5/x55+0P8OcPspaEQ1+uw==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49qey8h5ju-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 13 Oct 2025 13:39:13 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59DDNxmL003709;
 Mon, 13 Oct 2025 13:39:12 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49r1xxp3sp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 13 Oct 2025 13:39:12 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59DDd8AV46399988
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 13 Oct 2025 13:39:08 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2B801200A7;
 Mon, 13 Oct 2025 13:39:08 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 07DB3200A5;
 Mon, 13 Oct 2025 13:39:08 +0000 (GMT)
Received: from a46lp68.lnxne.boe (unknown [9.152.108.100])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 13 Oct 2025 13:39:07 +0000 (GMT)
From: Shalini Chellathurai Saroja <shalini@linux.ibm.com>
To: qemu-s390x mailing list <qemu-s390x@nongnu.org>,
 Thomas Huth <thuth@redhat.com>
Cc: Sebastian Mitterle <smitterl@redhat.com>,
 qemu-devel mailing list <qemu-devel@nongnu.org>,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>,
 Hendrik Brueckner <brueckner@linux.ibm.com>,
 Shalini Chellathurai Saroja <shalini@linux.ibm.com>,
 Michael Mueller <mimu@linux.ibm.com>
Subject: [PATCH v2 1/2] qapi/machine-s390x: add QAPI event
 SCLP_CPI_INFO_AVAILABLE
Date: Mon, 13 Oct 2025 15:39:01 +0200
Message-ID: <20251013133902.111233-1-shalini@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 0hzWBTbQCcgIcssrPHxFo5iVkqoNPCUX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxMSBTYWx0ZWRfXwK6v1olrZfz6
 DhbhLevKju7y+PFvO2Mb9c1grRfif5vwrb3da72Alz02C3sCC7JNSs3n1QbvitZ5JMKPzpafs+f
 7TnIp/Kkr2r+xs3nI+6a46MOzZrR17RT4qEXs520qwx8Pj0WwtdjWS64N4rAuArxSy05iiYLKPy
 prp/lpkfNrOf1nvv4rj0CDV1+FE5u9jKoICQ9IKJS5ox/Efao5/D0Yq0MGD5pDr2hhfuEoxDwP2
 nID5BNZafTRdlSgVdCpQMoNO+SUq89fMA+xW21h7Y/Ucz4XIjKplpm+/fPBI5Vbmy05ZSTyFCya
 dsMHQ8l/uU3rh4bMClxeGkEM6d5C6ZC4gu4SCcspiB5YAjVO81pN/9aTA1IPZVQ2/t5xBy1+GWB
 DEqiw8hhiis9fpntnpeHP/NJ++MQ6Q==
X-Proofpoint-GUID: 0hzWBTbQCcgIcssrPHxFo5iVkqoNPCUX
X-Authority-Analysis: v=2.4 cv=QZ5rf8bv c=1 sm=1 tr=0 ts=68ed0101 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=x6icFKpwvdMA:10 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8 a=sj1EmmPjCSn9LTcTfd8A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-13_05,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 phishscore=0 bulkscore=0 suspectscore=0
 spamscore=0 malwarescore=0 impostorscore=0 clxscore=1011 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510110011
Received-SPF: pass client-ip=148.163.156.1; envelope-from=shalini@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Add QAPI event SCLP_CPI_INFO_AVAILABLE to notify the availability
of Control-Program Identification data in QOM.

Signed-off-by: Shalini Chellathurai Saroja <shalini@linux.ibm.com>
Suggested-by: Thomas Huth <thuth@redhat.com>
---
 hw/s390x/sclpcpi.c      |  4 ++++
 qapi/machine-s390x.json | 25 +++++++++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/hw/s390x/sclpcpi.c b/hw/s390x/sclpcpi.c
index 7aa039d510..90da61b1c8 100644
--- a/hw/s390x/sclpcpi.c
+++ b/hw/s390x/sclpcpi.c
@@ -54,6 +54,7 @@
 #include "hw/s390x/event-facility.h"
 #include "hw/s390x/ebcdic.h"
 #include "qapi/qapi-visit-machine.h"
+#include "qapi/qapi-events-machine-s390x.h"
 #include "migration/vmstate.h"
 
 typedef struct Data {
@@ -106,6 +107,9 @@ static int write_event_data(SCLPEvent *event, EventBufferHeader *evt_buf_hdr)
     e->timestamp = qemu_clock_get_ns(QEMU_CLOCK_HOST);
 
     cpim->ebh.flags = SCLP_EVENT_BUFFER_ACCEPTED;
+
+    qapi_event_send_sclp_cpi_info_available(true);
+
     return SCLP_RC_NORMAL_COMPLETION;
 }
 
diff --git a/qapi/machine-s390x.json b/qapi/machine-s390x.json
index 966dbd61d2..338653e0b8 100644
--- a/qapi/machine-s390x.json
+++ b/qapi/machine-s390x.json
@@ -119,3 +119,28 @@
 { 'command': 'query-s390x-cpu-polarization', 'returns': 'CpuPolarizationInfo',
   'features': [ 'unstable' ]
 }
+
+##
+# @SCLP_CPI_INFO_AVAILABLE:
+#
+# Emitted when the Control-Program Identification data is available
+# in the QOM tree.
+#
+# @iscpiavailable: is CPI data available in QOM
+#
+# Features:
+#
+# @unstable: This event is experimental.
+#
+# Since: 10.2
+#
+# .. qmp-example::
+#
+#     <- { "event": "SCLP_CPI_INFO_AVAILABLE",
+#          "data": { "iscpiavailable": true },
+#          "timestamp": { "seconds": 1401385907, "microseconds": 422329 } }
+##
+{ 'event': 'SCLP_CPI_INFO_AVAILABLE',
+  'data': { 'iscpiavailable': 'bool' },
+  'features': [ 'unstable' ]
+}
-- 
2.49.0


