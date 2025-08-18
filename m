Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7BB7CA0EE4
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Aug 2025 21:44:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uo7eY-000200-KL; Mon, 18 Aug 2025 17:44:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1uo7eJ-0001pn-TA; Mon, 18 Aug 2025 17:44:18 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1uo7eF-0003ol-UH; Mon, 18 Aug 2025 17:44:15 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57ILM17k007399;
 Mon, 18 Aug 2025 21:44:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=1lNRbqTgGXWM0kB6w
 wxpH8QYp6l8X3VtwcawMq1q0Sc=; b=dKL43wCihQ48Vos4fA+gqbyMyrr1+p2Bv
 5t+hlG85+Ecob1+7KrncHfkD8X1BUoK5v5J1Hj0WyiR5LMt735SEKAoJwH74dfWf
 xGKfY8VsufFacW8/2rZ1vjcwtrviX93VlDqPIO4sk9/01nLHAGQsQ8ZOMASJljVw
 OxvFukS/E7Mylbovd/26t8q3XxqLOYFBb8Gkrrs8ORv4OAcF8f4Lfx/uiWjdVpa3
 p/HrdCgV8cUW0U2GSc/pscUWLDXtcQCwPzlAD9IcmigtmoyUq9xUaCo441+Vtk3w
 z1alpKqPqAic9YKkv3G8VSx1BOTqWW+UhxsjfH++etfxFwWmZH+0g==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48jge3ucg1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 18 Aug 2025 21:43:59 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57IJ9uPV002750;
 Mon, 18 Aug 2025 21:43:59 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 48k6hm7cw1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 18 Aug 2025 21:43:59 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 57ILhwUs32637590
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 18 Aug 2025 21:43:58 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E875C58057;
 Mon, 18 Aug 2025 21:43:57 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E68BC58058;
 Mon, 18 Aug 2025 21:43:56 +0000 (GMT)
Received: from fedora-workstation.ibmuc.com (unknown [9.61.98.172])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 18 Aug 2025 21:43:56 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: thuth@redhat.com, berrange@redhat.com, richard.henderson@linaro.org,
 david@redhat.com, jrossi@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Cc: walling@linux.ibm.com, jjherne@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com, alifm@linux.ibm.com, zycai@linux.ibm.com
Subject: [PATCH v5 28/29] docs/specs: Add secure IPL documentation
Date: Mon, 18 Aug 2025 17:43:21 -0400
Message-ID: <20250818214323.529501-29-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250818214323.529501-1-zycai@linux.ibm.com>
References: <20250818214323.529501-1-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=FcM3xI+6 c=1 sm=1 tr=0 ts=68a39e9f cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=2OwXVqhp2XgA:10 a=VnNF1IyMAAAA:8 a=pevZWc-pxkjX5tstIEcA:9
X-Proofpoint-GUID: V8ET2Sv2Xn6m7AaVQ5yvtW63Ht0Rd-D2
X-Proofpoint-ORIG-GUID: V8ET2Sv2Xn6m7AaVQ5yvtW63Ht0Rd-D2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE2MDAxMSBTYWx0ZWRfX14/5qjjK4J6d
 Q5U8HM0AvgWajxp5EHNai1seqTph0NNCy0LlYtkRiZN811SyiKfWqYkZqTWfqs5R8NtlKtAg2II
 dS7qq+M5Ogjt+HuYfQD/iQx1YI3Hahb7tq8aWW2kSjUjRAhDFSzXjZPVjO3+zHGMCTooTLAtBEX
 00x3FoALEG1zUzvNbYEHD3hMfmpXLMQlHjuzTbPhVtuX24PfDnECl//i3+LnPBrNfZ51GX9jmBX
 im2Nim27Kc0NY1urNejn8qe8YtwLIenGlgZY7CfMB8sdJ6pzxhvlVB4sTaf9JzZfEMLoIIDXQop
 RR0+FTQRcyyTTJjwrZpHzhndIKsLbOv9k7EevIds5DN0NAOtetvKSTRbXfMoDHPAnyZef5lEp2h
 OKCN6qL0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-18_06,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 priorityscore=1501 suspectscore=0 adultscore=0
 phishscore=0 clxscore=1015 impostorscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508160011
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
 docs/specs/s390x-secure-ipl.rst | 53 +++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/docs/specs/s390x-secure-ipl.rst b/docs/specs/s390x-secure-ipl.rst
index 72ab901014..dab25cb8c1 100644
--- a/docs/specs/s390x-secure-ipl.rst
+++ b/docs/specs/s390x-secure-ipl.rst
@@ -1,5 +1,58 @@
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
+To find out more about using this feature, see ``docs/system/s390x/secure-ipl.rst``.
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
+  the payload, attempting with each cert in the store (until success or exhausted)
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
2.50.1


