Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F33CD3B7E2
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Dec 2025 21:34:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vSisO-0000oM-EQ; Mon, 08 Dec 2025 16:34:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1vSirz-0008AU-Ri; Mon, 08 Dec 2025 16:34:12 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1vSirw-0000nN-LU; Mon, 08 Dec 2025 16:34:11 -0500
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5B8JMh7J016359;
 Mon, 8 Dec 2025 21:33:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=agWhPWVkEpmMziSjG
 26beBShB4aMwkqUjK3b3fJNEA0=; b=bgBH8WoFUhTABUvpe7wtrMMT9uh6jMIZM
 kK9DtRppb2Jt7/x2u9duEZS8GBul/FBKxd0hHuHHZLVMtFzZTklxIinVn7g89oF2
 TpPj5dL25gKn6Ejlr4a602q3F+h7WW7IZSGVxAZPT81trB5BFcDwR8hA5gqJ/TM8
 XCG0ZivRsHiy+GrtaJ2Bd/nPZBnX3LAJxlbZFj6/w9OlOR2/dAPSm+DsqHP+RtDi
 mArafFhYqqHo7H/GUg5zLZH3n28i9rpRXmVhVC5BGGymZ7jEFciDDmri+yq2ZFY3
 kVyHBFhzFi4Uptd4bYoIObpglDCbPxM/xNYDUUqmQV4FtFaQ8BrDQ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4avc539am3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 08 Dec 2025 21:33:45 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5B8JsjrI026887;
 Mon, 8 Dec 2025 21:33:44 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4aw1h0yfaw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 08 Dec 2025 21:33:44 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5B8LXhAo21758656
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 8 Dec 2025 21:33:43 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 490E75805C;
 Mon,  8 Dec 2025 21:33:43 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8C22758058;
 Mon,  8 Dec 2025 21:33:41 +0000 (GMT)
Received: from fedora-workstation.ibmuc.com (unknown [9.61.66.246])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  8 Dec 2025 21:33:41 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: thuth@redhat.com, berrange@redhat.com, richard.henderson@linaro.org,
 david@redhat.com, jrossi@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, brueckner@linux.ibm.com
Cc: walling@linux.ibm.com, jjherne@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com, zycai@linux.ibm.com, alifm@linux.ibm.com
Subject: [PATCH v7 28/29] docs/specs: Add secure IPL documentation
Date: Mon,  8 Dec 2025 16:32:45 -0500
Message-ID: <20251208213247.702569-29-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251208213247.702569-1-zycai@linux.ibm.com>
References: <20251208213247.702569-1-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA2MDAyMCBTYWx0ZWRfX3y1bMtcPFkNU
 P+tWbczQNMAhI8GBZScofbUBAG3TopvD120k0c0SAkNAMSMgv9SQF0Hn5dY9IA/xkkNC1X95Ncu
 5iWJlX27EDo2CsRvchIBjGFWz1spN0tLOu0Bb1E9Oo768Hz81XeG/v8oihqZp+lLA7hTD44T9O1
 GtyOUqrITA9qVckcVFPatj2WA5MhgxW3Zm7xgL8Sk2nbZSdFrMMATJPl9mNSH5r80QDUUkEbjI4
 +e0q3DJU/FKVkwzYlv/Hm4q0KTP9hq1KvXr8z/uF9OQKdHTgF7bCEJ7xgUafLLlzqauT1l7NWbM
 VsIlnlw+HjNNlTD8fBIl7KAexnwS4ngwL2WNr71Tenes9kshAKiPzcO3wXRhi4ZG8b3v31+R1JQ
 fvqASAH5xyYZIhLMWTyjfrr2JKv4JA==
X-Authority-Analysis: v=2.4 cv=S/DUAYsP c=1 sm=1 tr=0 ts=69374439 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=pevZWc-pxkjX5tstIEcA:9
X-Proofpoint-ORIG-GUID: c-Q2FatsZofNhzH8VbowfUE49uiJ2gq4
X-Proofpoint-GUID: c-Q2FatsZofNhzH8VbowfUE49uiJ2gq4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-06_02,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2512060020
Received-SPF: pass client-ip=148.163.158.5; envelope-from=zycai@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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

Add documentation for secure IPL

Signed-off-by: Collin Walling <walling@linux.ibm.com>
---
 docs/specs/s390x-secure-ipl.rst | 55 +++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/docs/specs/s390x-secure-ipl.rst b/docs/specs/s390x-secure-ipl.rst
index 70388d77d8..45f58ab49d 100644
--- a/docs/specs/s390x-secure-ipl.rst
+++ b/docs/specs/s390x-secure-ipl.rst
@@ -1,5 +1,60 @@
 .. SPDX-License-Identifier: GPL-2.0-or-later
 
+s390 Secure IPL
+===============
+
+Secure IPL (a.k.a. secure boot) enables s390-ccw virtual machines to
+leverage qcrypto libraries and z/Architecture emulations to verify the
+integrity of signed kernels. The qcrypto libraries are used to perform
+certificate validation and signature-verification, whereas the
+z/Architecture emulations are used to ensure secure IPL data has not
+been tampered with, convey data between QEMU and userspace, and set up
+the relevant secure IPL data structures with verification results.
+
+To find out more about using this feature, see
+``docs/system/s390x/secure-ipl.rst``.
+
+Note that "userspace" will refer to the s390-ccw BIOS unless stated
+otherwise.
+
+Both QEMU and userspace work in tandem to perform secure IPL. The Secure
+Loading Attributes Facility (SCLAF) is used to check the Secure Code
+Loading Attribute Block (SCLAB) and ensure that secure IPL data has not
+been tampered with. DIAGNOSE 'X'320' is invoked by userspace to query
+the certificate store info and retrieve specific certificates from QEMU.
+DIAGNOSE 'X'508' is used by userspace to leverage qcrypto libraries to
+perform signature-verification in QEMU. Lastly, userspace generates and
+appends an IPL Information Report Block (IIRB) at the end of the IPL
+Parameter Block, which is used by the kernel to store signed and
+verified entries.
+
+The logical steps are as follows:
+
+- Userspace reads data payload from disk (e.g. stage3 boot loader, kernel)
+- Userspace checks the validity of the SCLAB
+- Userspace invokes DIAG 508 subcode 1 and provides it the payload
+- QEMU handles DIAG 508 request by reading the payload and retrieving the
+  certificate store
+- QEMU DIAG 508 utilizes qcrypto libraries to perform signature-verification on
+  the payload, attempting with each cert in the store (until success or
+  exhausted)
+- QEMU DIAG 508 returns:
+
+  - success: index of cert used to verify payload
+  - failure: error code
+
+- Userspace responds to this operation:
+
+  - success: retrieves cert from store via DIAG 320 using returned index
+  - failure: reports with warning (audit mode), aborts with error (secure mode)
+
+- Userspace appends IIRB at the end of the IPLB
+- Userspace kicks off IPL
+
+More information regarding the respective DIAGNOSE commands and IPL data
+structures are outlined within this document.
+
+
 s390 Certificate Store and Functions
 ====================================
 
-- 
2.51.1


