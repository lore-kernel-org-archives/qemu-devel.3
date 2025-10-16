Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98F68CCD183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 12:27:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9Mvl-0000Hd-Bw; Thu, 16 Oct 2025 08:18:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shalini@linux.ibm.com>)
 id 1v9MvM-0007iu-NP; Thu, 16 Oct 2025 08:17:43 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shalini@linux.ibm.com>)
 id 1v9MvB-0008KY-3S; Thu, 16 Oct 2025 08:17:40 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59GA5mA5010062;
 Thu, 16 Oct 2025 12:17:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=rUN2mvAaJkf3gS7qa2pWkRryVzJSaGT5UZwAai4yB
 N0=; b=den0ZHatUcJf892y8yjFAF9F+OMTZHx1NDDr4j1EN/oVxrrm4drvXu5+d
 5QieeZZCTyZxMYW08xI12sdMWJAcXRZp3pkq+SVr/eBRIFFoygwkxzJloqHRFyKa
 wAQQz98ODLjPdHVUtHIGjIgrFJ3Z9LY5Q37wYyiWHuWMHjCD+ctkPpmelvlnIQ4c
 2ej8pBSL+nLoHU+36m7v3DmrqE1G/g6O0o8Fj5ojNPeHkD2bHRPoUzREQDxv+bQw
 qzuraPAUk8t9KBQekFB/Rly4BEizHBPrZjLb7kZoMtUusJ3EKsmKM+7VvnREZQDo
 f1L22XVnmExG+BrcJ9JYXpnE9OKSw==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49qewuajmj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 Oct 2025 12:17:23 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59G9xaL2003663;
 Thu, 16 Oct 2025 12:17:22 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49r1xy5q8k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 Oct 2025 12:17:21 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59GCHIU037814738
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 16 Oct 2025 12:17:18 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 254592013C;
 Thu, 16 Oct 2025 12:17:18 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 00C262013B;
 Thu, 16 Oct 2025 12:17:18 +0000 (GMT)
Received: from a46lp68.lnxne.boe (unknown [9.152.108.100])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 16 Oct 2025 12:17:17 +0000 (GMT)
From: Shalini Chellathurai Saroja <shalini@linux.ibm.com>
To: qemu-s390x mailing list <qemu-s390x@nongnu.org>,
 Thomas Huth <thuth@redhat.com>
Cc: Sebastian Mitterle <smitterl@redhat.com>,
 qemu-devel mailing list <qemu-devel@nongnu.org>,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>,
 Hendrik Brueckner <brueckner@linux.ibm.com>,
 Shalini Chellathurai Saroja <shalini@linux.ibm.com>,
 Michael Mueller <mimu@linux.ibm.com>
Subject: [PATCH v3 1/2] qapi/machine-s390x: add QAPI event
 SCLP_CPI_INFO_AVAILABLE
Date: Thu, 16 Oct 2025 14:17:07 +0200
Message-ID: <20251016121708.334133-1-shalini@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: dTmeVqB-l8qk-7FQoDZe08YFb73_aGZ3
X-Authority-Analysis: v=2.4 cv=Kr1AGGWN c=1 sm=1 tr=0 ts=68f0e253 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8
 a=sj1EmmPjCSn9LTcTfd8A:9
X-Proofpoint-ORIG-GUID: dTmeVqB-l8qk-7FQoDZe08YFb73_aGZ3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxNCBTYWx0ZWRfX8ujHR2DCHmXh
 GGEJtblt1MFIDf1gTK0fLFdyMXJ9ShJgor7G4Qe+yCdaLk7qIZuTVn2oIW9QY5O81BZ0IDXom3s
 BXf3gpz2yJXQsLwN8FAfvSI/DxXuwtZX37QTrsKOR4abTNd1pOSQPOK4WlIupbkzIZZaPFYmPEH
 wiJfrRDq/V/9ER+4CKXyaNMPdhcnW0NkqXOhbcIU4/ux7OEIQOv4i3BcV5aK0EQENl45/10sNP4
 DNBlV4b9Opzt7tNFOr/YUscyDgjv2fVoEVDRTlqs37DdqYtEVDf0qeGz9VQtGMGhQrUq8uqtk5Q
 x4VDt4cFLTqMRRY9+tksPxtsBVkxREVnBGBorzoHeCYGVwTdGR9G4mv7AfMmYwlCvX7KKNpVKvP
 2qGpckjmJVBGLdUadvP5bk4XeEhHUw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-16_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0 adultscore=0
 phishscore=0 suspectscore=0 malwarescore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510110014
Received-SPF: pass client-ip=148.163.156.1; envelope-from=shalini@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

Add QAPI event SCLP_CPI_INFO_AVAILABLE to notify the availability
of Control-Program Identification data in QOM.

Signed-off-by: Shalini Chellathurai Saroja <shalini@linux.ibm.com>
Suggested-by: Thomas Huth <thuth@redhat.com>
---
 hw/s390x/sclpcpi.c      |  4 ++++
 qapi/machine-s390x.json | 21 +++++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/hw/s390x/sclpcpi.c b/hw/s390x/sclpcpi.c
index 7aa039d510..68fc1b809b 100644
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
+    qapi_event_send_sclp_cpi_info_available();
+
     return SCLP_RC_NORMAL_COMPLETION;
 }
 
diff --git a/qapi/machine-s390x.json b/qapi/machine-s390x.json
index 966dbd61d2..8412668b67 100644
--- a/qapi/machine-s390x.json
+++ b/qapi/machine-s390x.json
@@ -119,3 +119,24 @@
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
+# Features:
+#
+# @unstable: This event is experimental.
+#
+# Since: 10.2
+#
+# .. qmp-example::
+#
+#     <- { "event": "SCLP_CPI_INFO_AVAILABLE",
+#          "timestamp": { "seconds": 1401385907, "microseconds": 422329 } }
+##
+{ 'event': 'SCLP_CPI_INFO_AVAILABLE',
+  'features': [ 'unstable' ]
+}
-- 
2.49.0


