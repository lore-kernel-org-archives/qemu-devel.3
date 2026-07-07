Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F232AC43602
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 23:58:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whFey-00021J-87; Tue, 07 Jul 2026 19:57:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1whFec-0001om-1l; Tue, 07 Jul 2026 19:56:42 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1whFeY-0002kn-S1; Tue, 07 Jul 2026 19:56:41 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 667MmDkn920442; Tue, 7 Jul 2026 23:56:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=mO1xJczG/rfcgg+EA
 8Gt0jcljAPl6ijYegEFkjO8YRg=; b=V0b7iDntOGA/Yhqp0qsXSo83XWd//c43n
 vPkRdwwXUp/yZsGaYP6MKgJxQc0KDsNNpK+SFJ71nFLO1Bq2P6NHvP12KmXQZVa7
 s+RW+RNqIexy+Jgkio30p0VluhlKyA2EGoR1eorVgO8GyTu2fYBqbzpNnIatg5Ux
 opFiTs1MVpjBOndr/k/ayof9wg0F9BeAUrtBxcxkjnHrUZpd0UXBCb00lIWk+qI9
 1gKhR8P5UJGRwsXYfGXUqLh9LgzmENh+wyaLNY5utsVDKgzbYVYcr16DSZNyat+e
 oOJVerWLEQLSFbMiGJHAlWeqHttqx1Oi5wnsxmV7+MpyQre7jQQhg==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6sp3swc7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 07 Jul 2026 23:56:24 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 667NnhvS025618;
 Tue, 7 Jul 2026 23:56:23 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7cgq5cxf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 07 Jul 2026 23:56:23 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 667NuMgh27460098
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 7 Jul 2026 23:56:22 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BF82D5805A;
 Tue,  7 Jul 2026 23:56:22 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 65CFF58052;
 Tue,  7 Jul 2026 23:56:22 +0000 (GMT)
Received: from fedora-workstation.lan (unknown [9.61.116.2])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  7 Jul 2026 23:56:22 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH v16 32/33] docs/specs: Add secure IPL documentation
Date: Tue,  7 Jul 2026 19:56:06 -0400
Message-ID: <20260707235615.2513487-12-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260707231132.2492104-1-zycai@linux.ibm.com>
References: <20260707231132.2492104-1-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=KsJ9H2WN c=1 sm=1 tr=0 ts=6a4d9228 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=bKBM-sKadDDPLvLHMR0A:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDIzMyBTYWx0ZWRfX6dX7ESelfam6
 6ISXNVhmU5EZNytEDUrr4QjXohFrExO1/NwL1wAG6oBmvSHdrUZm50PzfT6yNMER2XfFNr/F2MP
 AaPM8lcswW2ivsLwP75ddLwStz4BKeA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDIzMyBTYWx0ZWRfXwYpc+KZuDUyq
 8Wdnykt+cYDt46IP/ftc3jkJKghjilcRfWZ15m8+8t7w/XHxQINIfQ/A2Uzw3g67KyH3hGve4Ms
 I84xVni+/yQiWohslZ1TXuUYj2uRjDfjeoSo1asuhKtXpuE1UxuXBWgJ1wCijt6q0xXKnA7YQwQ
 LPWNExtcLpVQbzqac0VcPAKgwUUViOdPg7uf34LEVQ4Id8An5rEZ+jbuVOFpX7BcSb3SHXnhu33
 40vmhVWrvvr7zlpdaLNaQEQwC+9xYChH9MgeqKNLtyCfwtP3nrr8LTL9H7XU4csrRRNiKxTSNzz
 fpBBJfQpaTjBQzEy9aNK9ykEqZp+zPSb0w+CqetKk2cqFaknCz1EXgi2jscITWB3eyA963p/1CE
 fo8WIvYgBxHIdK8ptXk6F5Zlbetf3GRHbaOHwoGkHD21bi7/iWFznNd6afYOpKXbrqqlF8VDn2R
 N8VdhnziP6z9G+RtNww==
X-Proofpoint-ORIG-GUID: cOd889UaGTrFVYj7OQiLpPRlyfQwvzYq
X-Proofpoint-GUID: cOd889UaGTrFVYj7OQiLpPRlyfQwvzYq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_06,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 adultscore=0 clxscore=1015
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070233
Received-SPF: pass client-ip=148.163.156.1; envelope-from=zycai@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

Add documentation for secure IPL

Signed-off-by: Collin Walling <walling@linux.ibm.com>
Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
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
2.54.0


