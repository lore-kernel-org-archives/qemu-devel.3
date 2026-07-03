Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEF8BC43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 17:04:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfhHN-00017B-4Y; Fri, 03 Jul 2026 13:02:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1wfhHJ-0000hl-Vx; Fri, 03 Jul 2026 13:02:14 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1wfhHI-0003QU-4P; Fri, 03 Jul 2026 13:02:13 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 663GJoER3218889; Fri, 3 Jul 2026 17:02:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=txdTEYrvtT1ygS0Xd
 fiIeqSulEJRZdmxymBSb2Ff7T4=; b=Av38PHDfBFrWRekGAfmWXWHoPCbHUmOzT
 EUd3yEOJc8jHMiX8p4RL9K6K5V0a9fLou1nWPoO1X6O25wjtuT63Oi7WQVmJScs2
 V2y2RpOyjwom26XUAXcP7YM7lM4+bUrJXy/h503U1DVXprSTChXapsSw9ctRzNaq
 /mj257xUaMT//PzHxpf7L+D4HsirH0Ce6+kcB120vw6Xxr0LNxSn5ERMpVYb7PgL
 jY0gBXmm51r/H6uWK9Tl5ZM0zByQRM0Ldb3c6Xj9y6dA0hl7exeADcWwSUFbUuIK
 VZWhvSEWcixKAk2MxJATPO3VDMulKTRDwaXgGAssiMpDuNUE1Mx3Q==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26mk7rue-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 03 Jul 2026 17:02:07 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 663Gndgj031499;
 Fri, 3 Jul 2026 17:02:07 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f2uhysgfh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 03 Jul 2026 17:02:07 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 663H1WlW52691230
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 3 Jul 2026 17:01:32 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 70B7458062;
 Fri,  3 Jul 2026 17:02:05 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8D75D58054;
 Fri,  3 Jul 2026 17:02:02 +0000 (GMT)
Received: from fedora-workstation.lan (unknown [9.61.75.28])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  3 Jul 2026 17:02:02 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: jrossi@linux.ibm.com, cohuck@redhat.com, berrange@redhat.com,
 richard.henderson@linaro.org, david@kernel.org, walling@linux.ibm.com,
 jjherne@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, mjrosato@linux.ibm.com, iii@linux.ibm.com,
 eblake@redhat.com, armbru@redhat.com, zycai@linux.ibm.com,
 alifm@linux.ibm.com, brueckner@linux.ibm.com,
 pierrick.bouvier@oss.qualcomm.com, jdaley@linux.ibm.com
Subject: [PATCH v14 28/33] hw/s390x/ipl: Set IPIB flags for secure IPL
Date: Fri,  3 Jul 2026 13:00:25 -0400
Message-ID: <20260703170032.1893204-29-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260703170032.1893204-1-zycai@linux.ibm.com>
References: <20260703170032.1893204-1-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDE2NyBTYWx0ZWRfXwER/ah4YhrAw
 YNAK/lkjNJQ+MMiz3Tg6CSx82tMCH8JAR62QYJdLXqaAs+o679Db5Uwiq4kRm1LerPcMgSFSa5G
 CfFY3r4cQCjgYEIqMr11Xgwxe6HDCaGqC8z/RLHrPnBcvl7K7tiWptT5iH3V/wFPy108JbVGT4B
 4V25KSL8ysilAUFB1qNc8ZPHrLJkz73jXl0amh6BShAlEgDYjzkfBmazN6Gwk9XyaPg6G0Nd5e0
 WUE8YIqIbqu8m7ZWo8FHXBrKDtThHRyoffwke+CHNwGIcStSjR49moVvEGk30XH7pWMrXUNXOas
 AFdRfZQ2IY4gXoWECEzMaCAnzg24ISEVPkuvVb9Ov/xDC1+/wNs1P71bGWqlwB27wajnhHCAM8O
 natVzhtg0pk5pkMDGafYSwkDUI45JD+bYpusnCKW0Zv+o5eJTVSJBM/EnwbzX82M8Pz62ROiZxN
 9YQhOg3XmPFSTEcmb4Q==
X-Proofpoint-GUID: VgPH_Z93OZUOQYs5XOeR2VzEAADmN_t5
X-Authority-Analysis: v=2.4 cv=Z8bc2nRA c=1 sm=1 tr=0 ts=6a47eb0f cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8
 a=MUQpW0jNMHjpGy_Q9scA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDE2NyBTYWx0ZWRfX0XkkLdcaw4KO
 XF+Y7UMFx38XKnoasoqFoiwNcn7i3cUgqM2qwHufRqxBVfNf0ezitjK7QstQihtUe70MRYmGiO2
 3DRz2W52areRyqEImKrVV7+87yuUP7E=
X-Proofpoint-ORIG-GUID: VgPH_Z93OZUOQYs5XOeR2VzEAADmN_t5
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
index cd80e3057c..62a3c60530 100644
--- a/hw/s390x/ipl.c
+++ b/hw/s390x/ipl.c
@@ -467,15 +467,30 @@ static bool s390_has_certificate(void)
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
@@ -544,7 +559,8 @@ static bool s390_build_iplb(DeviceState *dev_st, IplParameterBlock *iplb)
         s390_ipl_convert_loadparm((char *)lp, iplb->loadparm);
         iplb->flags |= DIAG308_FLAGS_LP_VALID;
 
-        s390_set_secure_boot_flags(iplb, s390_has_certificate());
+        s390_set_secure_boot_flags(iplb, s390_secure_boot_enabled(),
+                                   s390_has_certificate());
 
         return true;
     }
@@ -697,7 +713,9 @@ void s390_ipl_update_diag308(IplParameterBlock *iplb)
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
2.54.0


