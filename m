Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09F27C5516E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2026 21:48:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpYbP-0004CA-75; Thu, 30 Jul 2026 17:47:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1wpYbF-0003DG-Lh; Thu, 30 Jul 2026 17:47:34 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1wpYbE-0002S1-7f; Thu, 30 Jul 2026 17:47:33 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66UJmCQI3875743; Thu, 30 Jul 2026 21:47:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=tt8zJR/DMoSn4d5k0
 74F/MFcigP6bct9rFrQYTysbHo=; b=mRsHVkHjtE0KAzSn10Wed7vaOb8XLvYeZ
 Y07qbXW1RHxQBmg4C8Y58haUef2iupc2c4plIz0n8sMBwZ7l1j1MrRyn+INtWt0z
 v7QTEFPSl61+6A+weKFNpLAxfXd+DYbQ2viIpTEfN9MkYLgq9Bf+R722uhUg9l44
 2R0AIDknIe8xSoVCJ5pbqUn+bTe5SMThE9PWQcvNhYlxflMvwMhluT09R6HVZy8W
 ms2L46ySU1Yss71X9bin9/SG04cXRJRfAt8Bi89dozkNlQnsQL4BLVkb6JG4JhjU
 W+8LT7DvRoh8mxTQ8hXeui4bEcBpEadlrjSDLGaVjR7Zmiz9vGQtw==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuyjh4f8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 30 Jul 2026 21:47:28 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66ULfQvd025819;
 Thu, 30 Jul 2026 21:47:28 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8fkda5d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 30 Jul 2026 21:47:28 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66ULlRMj58786240
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 30 Jul 2026 21:47:27 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 086D358043;
 Thu, 30 Jul 2026 21:47:27 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 18E705806D;
 Thu, 30 Jul 2026 21:47:25 +0000 (GMT)
Received: from fedora-workstation.ibmuc.com (unknown [9.61.77.192])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 30 Jul 2026 21:47:24 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: jrossi@linux.ibm.com, cohuck@redhat.com, berrange@redhat.com,
 richard.henderson@linaro.org, david@kernel.org, walling@linux.ibm.com,
 jjherne@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, mjrosato@linux.ibm.com, iii@linux.ibm.com,
 eblake@redhat.com, armbru@redhat.com, zycai@linux.ibm.com,
 alifm@linux.ibm.com, brueckner@linux.ibm.com,
 pierrick.bouvier@oss.qualcomm.com, jdaley@linux.ibm.com
Subject: [PATCH v17 28/34] hw/s390x/ipl: Set IPIB flags for secure IPL
Date: Thu, 30 Jul 2026 17:46:17 -0400
Message-ID: <20260730214624.2328883-29-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260730214624.2328883-1-zycai@linux.ibm.com>
References: <20260730214624.2328883-1-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDE1NyBTYWx0ZWRfX75TPsQSiKSJV
 sz60vCMNPLhZp8zk5EYKKVgqaKFXHKZQwh480K0vSNfFoJM7bCjq9DS7BwElBnG6+IQS/6zcw3v
 MOQzbe45shE47wNWBfbMGiymA8nQtx8=
X-Proofpoint-GUID: gEshPhWhnj8TqiLWxj48x8ZlDdDbFCuD
X-Proofpoint-ORIG-GUID: gEshPhWhnj8TqiLWxj48x8ZlDdDbFCuD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDE1NyBTYWx0ZWRfXwodXgkGdKnyW
 iXe/36WlVbW/neMQFNym37HCQF8Zuu6csgqw9dVnMPibr/96KnXVv5SZjTjuQRFZN2LftlCuGYD
 +mvwG6VPveOlvD6TjBRlPufrBUhNmsu67KGUzUQO7ZAOioEw51R5N4qJMYIlnHTNulo2wp0t59K
 jHcDUxhxfpsczwGqHrA5/OApq4oCopACCcP7NwS3We1Qx8g/6Sz1NcnB51ng2fuvKZutNzjqu2S
 VRneYf8919oUObLZAx6WmH+LJdcjD876F/CWNKBrCGB782N8NbvP4hxy3bO4rrwYFBLPgUnPKqL
 rV0QPTalNLX4d4gvHa7KaUghdczRCJ5BU57d7lbfLI1FNrHLTJjLo06ctIiWy8bLqt7CazhySFc
 Xzfbs0qJ8xoCgCasu1bUaqwt3BMuC2bvzj9ktcw6M9tvIVIjapbD0MtqbzlWpiHM34neDGH3jmD
 f5kuU7qLzJeAa7z//0w==
X-Authority-Analysis: v=2.4 cv=X5Vi7mTe c=1 sm=1 tr=0 ts=6a6bc670 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8
 a=MUQpW0jNMHjpGy_Q9scA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_06,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607300157
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

If `-M secure-boot=on` is specified on the command line option, indicating
true secure IPL enabled, set Secure-IPL bit and IPL-Information-Report
bit on in IPIB Flags field, and trigger true secure IPL in the S390 BIOS.

Any error that occurs during true secure IPL will cause the IPL to
terminate.

Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Collin Walling <walling@linux.ibm.com>
---
 hw/s390x/ipl.c | 28 +++++++++++++++++++++++-----
 1 file changed, 23 insertions(+), 5 deletions(-)

diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
index d0dbf47d74..08294af4d0 100644
--- a/hw/s390x/ipl.c
+++ b/hw/s390x/ipl.c
@@ -468,15 +468,30 @@ static bool s390_has_certificate(void)
     return ipl->cert_store.count > 0;
 }
 
+static bool s390_secure_boot_enabled(void)
+{
+    return S390_CCW_MACHINE(qdev_get_machine())->secure_boot;
+}
+
 static void s390_set_secure_boot_flags(IplParameterBlock *iplb,
-                                       bool audit_mode)
+                                       bool secure_boot, bool audit_mode)
 {
-    if (!audit_mode) {
+    if (!secure_boot && !audit_mode) {
         return;
     }
 
     /*
-     * For audit mode, enable the IPL Information
+     * If secure-boot is enabled, then toggle the secure IPL flags (SIPL) to
+     * trigger secure boot in the s390 BIOS.
+     *
+     * Boot process will terminate if any error occurs during secure boot.
+     */
+    if (secure_boot) {
+        iplb->hdr_flags |= DIAG308_IPIB_FLAGS_SIPL;
+    }
+
+    /*
+     * For both secure boot and audit mode, enable the IPL Information
      * Report (IPLIR) flag so that the firmware generates an IPL
      * Information Report Block (IIRB).
      *
@@ -545,7 +560,8 @@ static bool s390_build_iplb(DeviceState *dev_st, IplParameterBlock *iplb)
         s390_ipl_convert_loadparm((char *)lp, iplb->loadparm);
         iplb->flags |= DIAG308_FLAGS_LP_VALID;
 
-        s390_set_secure_boot_flags(iplb, s390_has_certificate());
+        s390_set_secure_boot_flags(iplb, s390_secure_boot_enabled(),
+                                   s390_has_certificate());
 
         return true;
     }
@@ -699,7 +715,9 @@ void s390_ipl_update_diag308(IplParameterBlock *iplb)
          * The kernel does not preserve secure boot flags across a reboot.
          * Re-apply them here based on the current machine configuration.
          */
-        s390_set_secure_boot_flags(&ipl->iplb, s390_has_certificate());
+        s390_set_secure_boot_flags(&ipl->iplb,
+                                   s390_secure_boot_enabled(),
+                                   s390_has_certificate());
     }
 
     update_machine_ipl_properties(iplb);
-- 
2.55.0


