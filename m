Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F335C43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 17:05:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfhHY-0002Jg-CY; Fri, 03 Jul 2026 13:02:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1wfhHV-00023C-Kv; Fri, 03 Jul 2026 13:02:26 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1wfhHT-0003Vb-W7; Fri, 03 Jul 2026 13:02:25 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 663GJBvp3218109; Fri, 3 Jul 2026 17:02:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=msK2ymhbX4mceiZVL
 8mPqeKiaC1qXvKagqwZM3qszgQ=; b=VSVk+6ksbuxhUV3NYmeSDEB9gm8HBXqC7
 mEwidb8MXcCxorcTrI9sESgUWncqdA7fPuVdd8lOFGm2AcjbtPAL8DmjhL/fAQ13
 V5N1tOfV/9xn+lX0/cp4xBzv0tnfxT3KGH+YLC6X14mSAywLBVNfuq7XL2PpYiju
 fL10olfQ1sssh2jaF05UCRHESDc5Dapfyuc55NqmwxoYWHbiz4LkYnygo0u9wk9o
 JSSjm8RuMf0aTBTt3ftfaVxn23GjAto8pn6k1aj3K+k3Hc0mXzp3kAgZTaDisK8j
 gBc9TJDWCBYUHWwz0b5uSOeSAEkpDIcyVgBxW/+cM9KRBP5dIShKA==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26mk7rvg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 03 Jul 2026 17:02:19 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 663Gnbej001494;
 Fri, 3 Jul 2026 17:02:19 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f2s7whtm9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 03 Jul 2026 17:02:19 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 663H1iQn10945262
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 3 Jul 2026 17:01:44 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1B33C5805A;
 Fri,  3 Jul 2026 17:02:18 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3FB2458062;
 Fri,  3 Jul 2026 17:02:15 +0000 (GMT)
Received: from fedora-workstation.lan (unknown [9.61.75.28])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  3 Jul 2026 17:02:15 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: jrossi@linux.ibm.com, cohuck@redhat.com, berrange@redhat.com,
 richard.henderson@linaro.org, david@kernel.org, walling@linux.ibm.com,
 jjherne@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, mjrosato@linux.ibm.com, iii@linux.ibm.com,
 eblake@redhat.com, armbru@redhat.com, zycai@linux.ibm.com,
 alifm@linux.ibm.com, brueckner@linux.ibm.com,
 pierrick.bouvier@oss.qualcomm.com, jdaley@linux.ibm.com
Subject: [PATCH v14 32/33] docs/specs: Add secure IPL documentation
Date: Fri,  3 Jul 2026 13:00:29 -0400
Message-ID: <20260703170032.1893204-33-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260703170032.1893204-1-zycai@linux.ibm.com>
References: <20260703170032.1893204-1-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDE2NyBTYWx0ZWRfX+wn/yUXXtfAb
 fGj6SlgqHjo4LQzc/qQvkIsu3C6OyfwrjcTIcN0JtdlXS7Zb3H3BCy9pAOajDvPghXWVJDY4c5v
 B7fSI4ACawJxcsUVJ+Anc3jdMuxkGx6pF1VXuxvliuJqCq+goDj5a6Fjhh7xlGzMPZs/j2kd1Kc
 /fRjCdJWSUFBNCu2eH8GFL1q3xBJM5Ds2KnPGpDNFW8zVeglR4dyOhOTF28xlP8xsjIp1tSxUCF
 MDjTIGbkjvHd8h4wcm1xcSeQBM3m3mJm5QzEnCZ36AMV6dc9laWF2+/Tsw6F6J4AfCluZyolI+F
 ppnBReNd50XC3BRmjEQ7hL2LWRKp1Hsln2w93vt6FcZ5Zkdk6zOWMBt1f7X5zat/VKCDCo3myCN
 1Uf3Tzs6L26iCKmX1kjVq66ejpafv3adZrYjmOTzbDlFE8HHCkIXrfYBb6zkX7lOl7UUlV1U/nG
 KiRxkIMnco5YF2BBQmw==
X-Proofpoint-GUID: XjRIBLwTo81nMR_p4Cq1wqJZ6hevNyro
X-Authority-Analysis: v=2.4 cv=Z8bc2nRA c=1 sm=1 tr=0 ts=6a47eb1c cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=bKBM-sKadDDPLvLHMR0A:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDE2NyBTYWx0ZWRfX+ElUR/mBdaTe
 6U/DRRMRCgvsSP+F4JvHqAuYdSSC4nUOr7YT3lh4awx8CQPUF3B/NgunJMd7mApvgtzVPPkLX9s
 /jaai1c1Ep9utfH1WolnAN4smEpNPwk=
X-Proofpoint-ORIG-GUID: XjRIBLwTo81nMR_p4Cq1wqJZ6hevNyro
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 spamscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030167
Received-SPF: pass client-ip=148.163.158.5; envelope-from=zycai@linux.ibm.com;
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

Add documentation for secure IPL

Signed-off-by: Collin Walling <walling@linux.ibm.com>
Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
---
 docs/specs/s390x-secure-ipl.rst | 55 +++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/docs/specs/s390x-secure-ipl.rst b/docs/specs/s390x-secure-ipl.rst
index db60c2262f..9d633413ae 100644
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


