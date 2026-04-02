Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E14BD6AAE7
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2026 22:17:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8QKx-0001ol-OE; Thu, 02 Apr 2026 18:16:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1w8QKN-0000sG-Eg; Thu, 02 Apr 2026 18:15:56 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1w8QKL-0004r7-OV; Thu, 02 Apr 2026 18:15:51 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 632CtFnL3518860; Thu, 2 Apr 2026 22:15:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=O1GjkwGOYVwOKFtKL
 83QQvCA3EfyKBCMMY/G69CcJn0=; b=IEVyGgIX6NTHyeXmsDgAhi54hfa4W2tqm
 ipxXphNPcyCMbw1S9Ll79PuKy+LlXGCLlLWJrfsuCtTo819v0IT5Y6AC3rNo5Ml7
 nCMyTKzQVxzb06e2eQ3oOa/M+2aRIudnPHL1p9lEhYIOVBORnaQenPZns5RDMnm2
 Ga5Zl7dp+qaPa2RPLXqIXKfZZlY7BClPpR6tjeId2OTVYtFhQVfIgVBbYZSzAGRj
 /OMfypfq7tYHT+oTtomFQIUamFJFPGi5+LdRCgbLxneD/WhfVSczm8S20SOCiYWH
 +Ze6mpM8GP3TZR6gj+bFyETZ8V6ShN9vSBKtuUOlhaeYAsjULYU5Q==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d66q3esav-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 02 Apr 2026 22:15:46 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 632JqSAQ005947;
 Thu, 2 Apr 2026 22:15:45 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d6spyc10n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 02 Apr 2026 22:15:44 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 632MFhcq66388436
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 2 Apr 2026 22:15:43 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 94AFF5806B;
 Thu,  2 Apr 2026 22:15:43 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3616058072;
 Thu,  2 Apr 2026 22:15:42 +0000 (GMT)
Received: from fedora-workstation.ibmuc.com (unknown [9.61.183.185])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  2 Apr 2026 22:15:42 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: jrossi@linux.ibm.com, cohuck@redhat.com, berrange@redhat.com,
 richard.henderson@linaro.org, pierrick.bouvier@linaro.org,
 david@kernel.org, walling@linux.ibm.com, jjherne@linux.ibm.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com, zycai@linux.ibm.com, alifm@linux.ibm.com,
 brueckner@linux.ibm.com, jdaley@linux.ibm.com
Subject: [PATCH v10 24/30] hw/s390x/ipl: Set IPIB flags for secure IPL
Date: Thu,  2 Apr 2026 18:14:46 -0400
Message-ID: <20260402221453.1602899-25-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260402221453.1602899-1-zycai@linux.ibm.com>
References: <20260402221453.1602899-1-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: DzguUSVh4QcFQ-W9VrwoXXcsvC4e016q
X-Authority-Analysis: v=2.4 cv=frzRpV4f c=1 sm=1 tr=0 ts=69ceea92 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8
 a=MUQpW0jNMHjpGy_Q9scA:9
X-Proofpoint-ORIG-GUID: DzguUSVh4QcFQ-W9VrwoXXcsvC4e016q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDE5NSBTYWx0ZWRfX9bdOaF4Unze4
 2l0bK3dnB9rykmZCF+L2M6/o/sZpDbXM+KPbYkAC1pRYHC9eaIFVDCofYuPm/Y+EsFAZJ+QB52g
 VwgMChN7RXh6ByCo5rNTaW3QJUSvt3LUjHxyOOWo8cyHmswWcdYAayDIWfKXk5HJjclQ8Kxf5vL
 L2lzd+GgFtHM/fQRR4eayNHIbk17leE3Rh7SzKBlgRbOP/gb3hFSYYOboVI0+OCFm2WwRQB/qa4
 mqhtmEKkJ+PHdcTxIJ/0H+FF6p5P+KKqzgcgU323+ZUx3C7gPAzKh66pNogpM7G7KMD1bRL/n8G
 t/iG2ZOxPuIxNK3owaZEnZzJukD2QaMJvDclHdSaa+V7Rv0fbNGXbNN/BN9G5JbU7I8s8qcflEn
 NhQOVBM7WpErOiynRNlfhK3K5Pvnqj4ZpcmFwpHxt7bkBZoypNpDzpHVeT9D4H6+G0GBAIU+RBM
 /ep46jedJ9Hwcg6drPw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_04,2026-04-02_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 adultscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604020195
Received-SPF: pass client-ip=148.163.156.1; envelope-from=zycai@linux.ibm.com;
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

If `-M secure-boot=on` is specified on the command line option, indicating
true secure IPL enabled, set Secure-IPL bit and IPL-Information-Report
bit on in IPIB Flags field, and trigger true secure IPL in the S390 BIOS.

Any error that occurs during true secure IPL will cause the IPL to
terminate.

Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 hw/s390x/ipl.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
index f4311f6d62..67e8231c76 100644
--- a/hw/s390x/ipl.c
+++ b/hw/s390x/ipl.c
@@ -468,6 +468,11 @@ static bool s390_has_certificate(void)
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
@@ -524,6 +529,18 @@ static bool s390_build_iplb(DeviceState *dev_st, IplParameterBlock *iplb)
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
@@ -533,7 +550,7 @@ static bool s390_build_iplb(DeviceState *dev_st, IplParameterBlock *iplb)
          *
          * Results of secure boot will be stored in IIRB.
          */
-        if (s390_has_certificate()) {
+        else if (s390_has_certificate()) {
             iplb->hdr_flags |= DIAG308_IPIB_FLAGS_IPLIR;
             iplb->len = cpu_to_be32(S390_IPLB_MAX_LEN);
         }
-- 
2.53.0


