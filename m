Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 064C8CCD18D
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Oct 2025 13:33:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8IfQ-00042k-CH; Mon, 13 Oct 2025 09:32:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shalini@linux.ibm.com>)
 id 1v8IfM-00040Z-Rq; Mon, 13 Oct 2025 09:32:44 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shalini@linux.ibm.com>)
 id 1v8IfK-0005se-9E; Mon, 13 Oct 2025 09:32:44 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59DDAMPi019051;
 Mon, 13 Oct 2025 13:32:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=RQK9MLjga+hZqSIzn/UHdKK52IFbjEuxbfDWg6J09
 fU=; b=PlhFPj6eEk+NrZ7wwOmdSqYruPlJnfvNJ5xAquSpMfqNAdV1TbhBbb1w1
 NrpBW5eC02SMMtSD3VX2+nnEstwASMnOJb0YIl0W4Q5dcx1tvoaHgiDvLSOYEOJR
 u0NRXDgiTYNrM4EFFXHCHTfF9jElTadQIxBeMBf10TRRee4DDL7dT7gDfC+O1xdM
 feBYxkGPIR7UX85Cg7pnPZ2pLIGZJ+5/7e2Qw8iRq7jgQHUBZzoCcfW98bpJm7AN
 ypqlIjlSIXW1DURmVSia7hdN24FCdFubFyv4sDv5wSbyZv7H8LaFC+m6qbNPrZYc
 XBhyn6fmYJyCyMmusUESW0iBQwloA==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49rfp7kxk2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 13 Oct 2025 13:32:37 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59DBYKZH015466;
 Mon, 13 Oct 2025 13:32:37 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 49r3sj5s96-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 13 Oct 2025 13:32:36 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59DDWXpa36372968
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 13 Oct 2025 13:32:33 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 56B0920088;
 Mon, 13 Oct 2025 13:32:33 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 318E620084;
 Mon, 13 Oct 2025 13:32:33 +0000 (GMT)
Received: from a46lp68.lnxne.boe (unknown [9.152.108.100])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 13 Oct 2025 13:32:33 +0000 (GMT)
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
Date: Mon, 13 Oct 2025 15:32:28 +0200
Message-ID: <20251013133229.110892-1-shalini@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: uSqF8sHTVAWKrgWuBS5RAHIFnGiV0zjX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDEyMDA4NCBTYWx0ZWRfXzVsaBK9Vw1k1
 aaE/5cBvducnKYo4Bt3EJIqwag8H9LXU/GSP8WCwvpZuyYzCIf3cmmTLYpdBpumjcjDI9Ay9zb+
 s0zUCUYyVZm2e1MKb31sRusJUJB3AS6yyZMC1Rol0BvIKKvvxCkaleg92WB+0nhowwy42OCE4nr
 XCnYd0b325Dk7dWhMmZYk92eJjTDM4JN3E0inOHETjuuMIqGgt7JlmxyJQ0A5yNuqebPZ8pE8rn
 4yNjp2ePXfUyWOoZoAHn32TIv9IPmKs8xgcZVFPb4hDqGGyOJ6Yq6C4pnvqjqGSt5LUaRujni8E
 bn/ZzNtH+rYMJdi21deHNaYl0XUE3VKCtvKEE+7NfxamZ/2mMkIy+ow3pxNaEwV0iD3ssGG5YF2
 gY1MGr2sd+LFOHEDNsXfZDdtOmfrkA==
X-Proofpoint-GUID: uSqF8sHTVAWKrgWuBS5RAHIFnGiV0zjX
X-Authority-Analysis: v=2.4 cv=af5sXBot c=1 sm=1 tr=0 ts=68ecff75 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=x6icFKpwvdMA:10 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8 a=sj1EmmPjCSn9LTcTfd8A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-13_05,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 priorityscore=1501 spamscore=0 adultscore=0 suspectscore=0
 bulkscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510120084
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


