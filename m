Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5F9AD3B7EA
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Dec 2025 21:36:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vSisO-0000oC-H3; Mon, 08 Dec 2025 16:34:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1vSiro-0007on-7F; Mon, 08 Dec 2025 16:34:01 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1vSirl-0000m1-A7; Mon, 08 Dec 2025 16:33:59 -0500
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5B8E7PsA024049;
 Mon, 8 Dec 2025 21:33:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=07TganXm29rqqSZKQ
 xAJcxNQWws4OcRWYfErsj+BkIQ=; b=L0XxgCfjgjeGmSuBAbcHvzLOKn4Si61cq
 nryKop54MhuVcn1uiiuuNHRvhtb2X27Yu/re8yqi4U7Em3Gby7cNLC9qyWYqXrVm
 qlnZx4TM83ny4+Yy0tDBnXKQkAUeEzOEzXBTIVRv0E7jV1AwFFBvl5P44194zrSn
 LGE1kV4eMxHZMpLoJzmLyrWkodkJ/i+FCSBR2V2CzZbB1q20HBiB7ysMwtWlZDss
 rBRsB0EegIklupnfaz4j+g1HwazadIeLX2+1Yaw8z9oLh9VXlb5nAX78wPG+G8yD
 pISkXINhAqlM2O+syelJHHBlmy5VTe66axbwy9Es8Ze0KdQPo8n3w==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4av9wvhmnn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 08 Dec 2025 21:33:35 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5B8I0wl2028123;
 Mon, 8 Dec 2025 21:33:35 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4avy6xqvyk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 08 Dec 2025 21:33:35 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5B8LXXP253936546
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 8 Dec 2025 21:33:34 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CEE5158058;
 Mon,  8 Dec 2025 21:33:33 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 24C875805F;
 Mon,  8 Dec 2025 21:33:32 +0000 (GMT)
Received: from fedora-workstation.ibmuc.com (unknown [9.61.66.246])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  8 Dec 2025 21:33:32 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: thuth@redhat.com, berrange@redhat.com, richard.henderson@linaro.org,
 david@redhat.com, jrossi@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, brueckner@linux.ibm.com
Cc: walling@linux.ibm.com, jjherne@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com, zycai@linux.ibm.com, alifm@linux.ibm.com
Subject: [PATCH v7 23/29] hw/s390x/ipl: Set IPIB flags for secure IPL
Date: Mon,  8 Dec 2025 16:32:40 -0500
Message-ID: <20251208213247.702569-24-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251208213247.702569-1-zycai@linux.ibm.com>
References: <20251208213247.702569-1-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: hFdDHojWbIyXSs8yAKxwfkZHQbFkfDib
X-Proofpoint-ORIG-GUID: hFdDHojWbIyXSs8yAKxwfkZHQbFkfDib
X-Authority-Analysis: v=2.4 cv=AdS83nXG c=1 sm=1 tr=0 ts=6937442f cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=MUQpW0jNMHjpGy_Q9scA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA2MDAwMCBTYWx0ZWRfX7Nq6MOjgxW5Y
 e5mUMtX8VoSD/Fw4kE6TYnnVhQBFhzvdK/S1vVOunVng/rzcApt2D4j+PuphZ0xubGlfTubqPib
 upxXcheUJ/pU0Qdk9A+T55xwP1mwL9KuuDMZ+bDBRbLLphhDfjq3ag7XbCw+GtG2J0qdmk9dklD
 9L2PtEExTgIy0gTQAnZm6c5RwfknVdEQTwA/FFR8hDm4+r85B6/JGDfggN/O4Rvx+dSEZvnZels
 xzLVmvMzabVvncqemdSg1bvYXGkFz7ImCV4c7gSvyd4MoMDgHwv8C939SdhXkRbteegq4aFMKq2
 r5EqMzAy86pfrDbg0T0cu1BE46ah3Uw+8trtXZEntbUyrpAfzVdjWW0E50LMAiAFumNMKrHWIuN
 UcgkOkdR95K10Y1YwDOcPuNiOvmZrA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-06_02,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 priorityscore=1501 spamscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2512060000
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

If `-secure-boot on` is specified on the command line option, indicating
true secure IPL enabled, set Secure-IPL bit and IPL-Information-Report
bit on in IPIB Flags field, and trigger true secure IPL in the S390 BIOS.

Any error that occurs during true secure IPL will cause the IPL to
terminate.

Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
---
 hw/s390x/ipl.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
index a95a1de647..bfac156afe 100644
--- a/hw/s390x/ipl.c
+++ b/hw/s390x/ipl.c
@@ -439,6 +439,11 @@ static bool s390_has_certificate(void)
     return ipl->cert_store.count > 0;
 }
 
+static bool s390_secure_boot_enabled(void)
+{
+    return S390_CCW_MACHINE(qdev_get_machine())->secure_boot;
+}
+
 static bool s390_build_iplb(DeviceState *dev_st, IplParameterBlock *iplb)
 {
     CcwDevice *ccw_dev = NULL;
@@ -496,6 +501,18 @@ static bool s390_build_iplb(DeviceState *dev_st, IplParameterBlock *iplb)
         s390_ipl_convert_loadparm((char *)lp, iplb->loadparm);
         iplb->flags |= DIAG308_FLAGS_LP_VALID;
 
+        /*
+         * If secure-boot is enabled, then toggle the secure IPL flags to
+         * trigger secure boot in the s390 BIOS.
+         *
+         * Boot process will terminate if any error occurs during secure boot.
+         *
+         * If SIPL is on, IPLIR must also be on.
+         */
+        if (s390_secure_boot_enabled()) {
+            iplb->hdr_flags |= (DIAG308_IPIB_FLAGS_SIPL | DIAG308_IPIB_FLAGS_IPLIR);
+            iplb->len = cpu_to_be32(S390_IPLB_MAX_LEN);
+        }
         /*
          * Secure boot in audit mode will perform
          * if certificate(s) exist in the key store.
@@ -505,7 +522,7 @@ static bool s390_build_iplb(DeviceState *dev_st, IplParameterBlock *iplb)
          *
          * Results of secure boot will be stored in IIRB.
          */
-        if (s390_has_certificate()) {
+        else if (s390_has_certificate()) {
             iplb->hdr_flags |= DIAG308_IPIB_FLAGS_IPLIR;
             iplb->len = cpu_to_be32(S390_IPLB_MAX_LEN);
         }
-- 
2.51.1


