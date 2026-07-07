Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0188C43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 23:58:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whFew-0001z7-Ub; Tue, 07 Jul 2026 19:57:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1whFee-0001ro-Qs; Tue, 07 Jul 2026 19:56:44 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1whFeZ-0002kQ-1s; Tue, 07 Jul 2026 19:56:44 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 667MmVIo920726; Tue, 7 Jul 2026 23:56:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=7DEsHgDQ8qYO/RbaH
 2jDxgq0RdhnuicsuS/DuVijqOE=; b=LFvWqCr/0VNdmwm8y/9PTwqRgurq1sdKy
 ttRUQhGjb7oVcVReKiM5vYXWdUnAmetDjMwY9HjprxhbOsG9PI201clyotRdc4lX
 TshxjQC6jI806GQ38Iuf2eu50fSB8hiZDA9hrt1dZVwjs8byL6dySHIXJJPzH9+Y
 HXPzTpQeAhhNoxlv30d+9UDKyjj1SpZqALqxjSGNEwSfOsWzKY3tEkF2tcBqn++2
 1bbjS9cRF8+nTBTqlgA31f5S7zZeKImYuCihqZWjWhpG8TyuJBEalCK6losIOdNO
 LqyrRDABZwg7SrVVacVxmH3+/bx12Id+nJk+T61MPexn4hx0MXaxw==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6sp3swc3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 07 Jul 2026 23:56:22 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 667Nnc0B016098;
 Tue, 7 Jul 2026 23:56:21 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f7cvw5bcb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 07 Jul 2026 23:56:21 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 667NtkI928770846
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 7 Jul 2026 23:55:46 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 79FF158052;
 Tue,  7 Jul 2026 23:56:20 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 042D45805A;
 Tue,  7 Jul 2026 23:56:20 +0000 (GMT)
Received: from fedora-workstation.lan (unknown [9.61.116.2])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  7 Jul 2026 23:56:19 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH v16 28/33] hw/s390x/ipl: Set IPIB flags for secure IPL
Date: Tue,  7 Jul 2026 19:56:02 -0400
Message-ID: <20260707235615.2513487-8-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260707231132.2492104-1-zycai@linux.ibm.com>
References: <20260707231132.2492104-1-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=KsJ9H2WN c=1 sm=1 tr=0 ts=6a4d9226 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8
 a=MUQpW0jNMHjpGy_Q9scA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDIzMyBTYWx0ZWRfX8uR+ghAkScr+
 XfK5aFrSzM0Ipb5Gl271QElxqvqMVtIriHPw3izj/5btlFBT3S0dFIjbUsp41ieXJaFzNJ3e+IT
 0GkAFEYULDvQ93miZ8zBf9N7H3R9uK8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDIzMyBTYWx0ZWRfX39ErQWoZLQoN
 JLws+Gxl193jqULL5cPewU1NO7Jv6/6WI1LfKRe9cG1JPmUmuJaY5yrU4w5TtSAO0N7FlNk1HQT
 eefhl+EuJVGOdFpmiVTet+jn/85MOdCc5n/FR8OxARk2obOOoo8ztz1+drafE83oz4a5ANmMx3v
 oR+yJFJp8jwXhuIjiDIVMykTFOkeOXcca6FfvQVuK4DBFRo/mXTJ6kJpiIT6pboSi4wtRk3sdb0
 CodYToWqzHZVVESdUBZJgNKlZ+raFzDehTBWMdjbo92r6yQ+jNSkTrbC1ge1R40zzWf+2my0us+
 eBK8BTuicpIfsjbdt4Bvm1LdDSWWiRBdDI7pN1m3Rauhl58gYaoFwcgqmG+CCDJx4UVo4tYPcCX
 gLuwvX8wElh2gIE1wZjc1CmxhPmNoGN0Km3dmB7MCV2kKF2rpOW9Z2Ima6hwLVCAYpUnWaJR+Zo
 UoVGnXDHryR7WOtdIXQ==
X-Proofpoint-ORIG-GUID: 3CKYdNN9chYXFIyN3lSmhR7mKIXFqNAF
X-Proofpoint-GUID: 3CKYdNN9chYXFIyN3lSmhR7mKIXFqNAF
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
2.54.0


