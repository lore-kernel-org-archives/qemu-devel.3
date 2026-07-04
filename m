Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62033C43458
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2026 21:43:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wg86j-0007uO-Fn; Sat, 04 Jul 2026 17:41:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1wg86g-0007ro-Pg; Sat, 04 Jul 2026 17:41:02 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1wg86f-0000A7-6M; Sat, 04 Jul 2026 17:41:02 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 664KmFfo2513155; Sat, 4 Jul 2026 21:40:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=ly1ouwdTOS/rCYt3U
 l9zQGS01uaq5uMp9fmypZwaBQw=; b=jznanCuLLX20MewaKJeW3Mfmdp01vTopi
 MMjnHBeR6rAmdRaFNA88yfmkr1hq84FHDOsY7/HZtKBz+WS5Ak50rWrl5ABCKqVp
 S8w6pfU6yfJ3qSH+M0N3FTVDgqETpf44EqC9Dg0JcRJWkZk3HwxCeGryL4uE3oI7
 GYkm1cZUIw+gAr6nlZPens7HuhMDx6jLLHnBfMIowhpiqK0MGvqJ1Ngc2W+kHcqR
 VEqmuxg5pD5Tiq+CzE7jcRMR5DRDep/h/Tp4EBrsgzLRIQkUXtd1k+ppOfayu/Il
 1i+yL2acMqutDk3c+8P8mY8OrRroSHDpKr2qrO466ll6hI7IRXSLg==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6sw4b7p7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 04 Jul 2026 21:40:57 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 664LYg8s019267;
 Sat, 4 Jul 2026 21:40:56 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f2uhyx8gh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 04 Jul 2026 21:40:56 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 664LetoU16384636
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 4 Jul 2026 21:40:55 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6637A58052;
 Sat,  4 Jul 2026 21:40:55 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6D3BB5805F;
 Sat,  4 Jul 2026 21:40:53 +0000 (GMT)
Received: from fedora-workstation.ibmuc.com (unknown [9.61.17.215])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Sat,  4 Jul 2026 21:40:53 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: jrossi@linux.ibm.com, cohuck@redhat.com, berrange@redhat.com,
 richard.henderson@linaro.org, david@kernel.org, walling@linux.ibm.com,
 jjherne@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, mjrosato@linux.ibm.com, iii@linux.ibm.com,
 eblake@redhat.com, armbru@redhat.com, zycai@linux.ibm.com,
 alifm@linux.ibm.com, brueckner@linux.ibm.com,
 pierrick.bouvier@oss.qualcomm.com, jdaley@linux.ibm.com
Subject: [PATCH v15 28/33] hw/s390x/ipl: Set IPIB flags for secure IPL
Date: Sat,  4 Jul 2026 17:39:44 -0400
Message-ID: <20260704213950.2118823-29-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260704213950.2118823-1-zycai@linux.ibm.com>
References: <20260704213950.2118823-1-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: wN5q80r1f_7Cu8-uhE6CjtMQ2JetcXZa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA0MDIyNCBTYWx0ZWRfX56W2wdEtZZtB
 If/x4ox7P3+0NTVIEY3Vb6SslN4bJ6eXvioAlPbvgFyjefZT+pNpB4LRzWJvAOtJvEvAmuX2B4C
 d/cxX173kXOB9F8ltgKE8CD9dV8HLLU8xLblEuh5uQxJXJpCKZ7JXWs7px/2uMWROYYAo7762HH
 FwjHDxZ8X1rj3lgxjbmImp489mSVyDTdU5GA549gi90lTn5/eV39+RPgvdPwZZsck+Gihtls/fs
 YCk3XY2Zoyhkgk5v7D+WOaMnyjGKSuTIjOVgy6+kObo6p91KWOCikiAhL85VUbyYWeZUc9LRAvA
 EVMWoQKt8RSD3k+mG4Io52JxdpCGsVZTyKHvPT/r65Qr4EYOwtLqjbhj2i5Mf//FUgUXcSAMDyR
 W2KZDv4XCH8OeGe1mQkzn0BHYOy7lLKjGFEg6VG5G0KlU/buQuiEA3R2BlghAnmlLKh62LxRCQs
 1vbGfCkAXy7tNUbMtcw==
X-Proofpoint-ORIG-GUID: wN5q80r1f_7Cu8-uhE6CjtMQ2JetcXZa
X-Authority-Analysis: v=2.4 cv=FqQ1OWrq c=1 sm=1 tr=0 ts=6a497de9 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8
 a=MUQpW0jNMHjpGy_Q9scA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA0MDIyNCBTYWx0ZWRfX5XERjpwnSRM9
 fiXbJI6RPdnf2Y6irypp5K/x3NgixsHzzYu4/oWgfVnnVnIOgMaMrmZrpP9rGMbkVq12lMIGVKb
 twjv47FTxG47P/MROvO79A4s+2GFOuE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-04_03,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607040224
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
index ee251d03a8..24d3ce1147 100644
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
@@ -698,7 +714,9 @@ void s390_ipl_update_diag308(IplParameterBlock *iplb)
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


