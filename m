Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4EC6C5DF97
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 12:56:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzD7t-0008BF-Kq; Wed, 26 Aug 2026 08:53:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1wzD7p-000872-B7; Wed, 26 Aug 2026 08:53:05 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1wzD7m-0002tH-Np; Wed, 26 Aug 2026 08:53:04 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67QCW03T4057167; Wed, 26 Aug 2026 12:53:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=B+zJ/y9zmnEaCZ4hr
 EDqAli++ruRnNrcMBTWtG0Nl3A=; b=NQRRaQaRDk0ZifE9tuVhxeATsBSE+XzyO
 cZl9nSq/bNW/p1oESImUJ1wTfJGHXWbh/y2q/uSMBRdUzNXQ5FTC27ujiydMGGW8
 D1dNouTi0ZnYu4V5jeOcEczkfhMGsBefOa99ksvHLu4Sm+jgsb6J8BlE3kL1d2dh
 PPUjfLYtfePuoQt8kmqsLQTR8hWzsuX/fpN+bD/z2e0ai4JGfdybU9g+Cr5ZP02s
 OKcUz9niFDkefBiCSmQ1pVUC9/cIG02DzDSGXNJ6mH5KUCugrVfDbFUXKYUoTf+t
 EzwaJarNcHD6qWndaEJNT2YWXcueVB7aK2jx6srvM7ls4dwgfzevQ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73dxec2e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Aug 2026 12:53:00 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67QCfHx4018813;
 Wed, 26 Aug 2026 12:52:59 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7raght19-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Aug 2026 12:52:59 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67QCqwK231523374
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 26 Aug 2026 12:52:58 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 213055805D;
 Wed, 26 Aug 2026 12:52:58 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3ED2E58059;
 Wed, 26 Aug 2026 12:52:57 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com.com (unknown
 [9.61.78.161]) by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 26 Aug 2026 12:52:57 +0000 (GMT)
From: Eric Farman <farman@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Matthew Rosato <mjrosato@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Zhuoying Cai <zycai@linux.ibm.com>,
 Collin Walling <walling@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>
Subject: [PULL 34/37] docs/specs: Add secure IPL documentation
Date: Wed, 26 Aug 2026 08:52:09 -0400
Message-ID: <20260826125213.1901252-35-farman@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260826125213.1901252-1-farman@linux.ibm.com>
References: <20260826125213.1901252-1-farman@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDEwNCBTYWx0ZWRfX/ME3ehtAhlir
 55vYqcQLIAYR+sxFwfapB/eH2ohXdk0Zh/BmnPk6w+g613JuIUXewopBHxgXUpkVHGi5wNHjqOW
 rBLk5TaSGBpBKDc7C92yLoZSEZ4EXhk=
X-Authority-Analysis: v=2.4 cv=AYuB2XXG c=1 sm=1 tr=0 ts=6a8ee1ac cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=bKBM-sKadDDPLvLHMR0A:9
X-Proofpoint-ORIG-GUID: 1Oyy-2Q8-BJVcaRivkVaRT8-CHoQKkB9
X-Proofpoint-GUID: 1Oyy-2Q8-BJVcaRivkVaRT8-CHoQKkB9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDEwNCBTYWx0ZWRfX5Pqhe0cLbgT+
 UGEO7cMi7CnbaixsSm2KzoRr8uAY8xKu8nnGIKxlLV27h9a5utvZ7yKI5QSz2jDGB0mRMNaUDWe
 tOtP10t+z1QZKom8gWpTUkzah1FA1bsDiBBMXih604gTAJueje7AmASxeH3v8WMjesZB8LmH7ZF
 avYiNXUoMAuzEuV2PdAz3tW3ZF/DFvGFsw3Eq3tUBKqcBwhMLcc87h6+8GgflY8M4MkKqHiBgtP
 6m1nSOHWZcBs7q5NBc5bDdTIAWjA4CQQ7mgh6G6EnFfJjYvumfERIj0nzr/eCUIkceZc2aDqU7B
 nMiesHyYDcys91PzYNhC7I5dFTwI9qojCRFQa74c5JMY+9AcMkDmIe/62SqnidMcXWaxHv4pYOx
 6Uq3GD+Q8xYkSmct8QWogJgW4zN7DUPnT8YbmL7kANGj9c1IG17pBBw6RSJgLci3yqfTm0PHHyJ
 8DyiRJTmlT0txdcb6bw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_03,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1015 adultscore=0 bulkscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608260104
Received-SPF: pass client-ip=148.163.158.5; envelope-from=farman@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Zhuoying Cai <zycai@linux.ibm.com>

Add documentation for secure IPL

Signed-off-by: Collin Walling <walling@linux.ibm.com>
Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20260730214624.2328883-33-zycai@linux.ibm.com
Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 docs/specs/s390x-secure-ipl.rst | 55 +++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/docs/specs/s390x-secure-ipl.rst b/docs/specs/s390x-secure-ipl.rst
index 7a603eb956..82b21600af 100644
--- a/docs/specs/s390x-secure-ipl.rst
+++ b/docs/specs/s390x-secure-ipl.rst
@@ -1,5 +1,60 @@
 .. SPDX-License-Identifier: GPL-2.0-or-later
 
+s390 Secure IPL
+===============
+
+Secure IPL (a.k.a. secure boot) enables s390-ccw virtual machines to
+leverage qcrypto libraries and z/Architecture emulation to verify the
+integrity of signed kernels. The qcrypto libraries are used to perform
+certificate validation and signature-verification, whereas the
+z/Architecture emulation is used to ensure secure IPL data has not
+been tampered with, convey data between QEMU and guest code, and set up
+the relevant secure IPL data structures with verification results.
+
+To find out more about using this feature, see
+:doc:`documentation </system/s390x/secure-ipl>`.
+
+Note that "guest code" will refer to the s390-ccw BIOS unless stated
+otherwise.
+
+Both QEMU and guest code work in cooperation to perform secure IPL. The Secure
+Code Loading Attributes Facility (SCLAF) is used to check the Secure Code
+Loading Attribute Block (SCLAB) and ensure that secure IPL data has not
+been tampered with. DIAGNOSE 'X'320' is invoked by guest code to query
+the certificate store info and retrieve specific certificates from QEMU.
+DIAGNOSE 'X'508' is used by guest code to leverage qcrypto libraries to
+perform signature-verification in QEMU. Lastly, guest code generates and
+appends an IPL Information Report Block (IIRB) at the end of the IPL
+Parameter Block (IPLB), which is used by the kernel to store signed and
+verified entries.
+
+The logical steps are as follows:
+
+- guest code reads data payload from disk (e.g. stage3 boot loader, kernel)
+- guest code checks the validity of the SCLAB
+- guest code invokes DIAG 508 subcode 1 and provides the payload
+- QEMU handles DIAG 508 request by reading the payload and retrieving the
+  certificate store
+- QEMU DIAG 508 utilizes handler qcrypto libraries to perform
+  signature-verification on the payload, attempting with each cert in the store
+  (until success or exhausted)
+- QEMU DIAG 508 returns:
+
+  - success: index of cert used to verify payload
+  - failure: error code
+
+- guest code is expected to respond to this operation by:
+
+  - success: retrieves cert from store via DIAG 320 using returned index
+  - failure: reports with warning (audit mode), aborts with error (secure mode)
+
+- guest code appends IIRB at the end of the IPLB
+- guest code kicks off IPL
+
+More information regarding the respective DIAGNOSE commands and IPL data
+structures are outlined within this document.
+
+
 s390 Certificate Store and Functions
 ------------------------------------
 
-- 
2.55.0


