Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3174D6AAE7
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2026 22:17:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8QL3-0002bt-3g; Thu, 02 Apr 2026 18:16:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1w8QKl-00017Q-IS; Thu, 02 Apr 2026 18:16:19 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1w8QKi-0004s4-VG; Thu, 02 Apr 2026 18:16:14 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 632EVRIv330917; Thu, 2 Apr 2026 22:15:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=zohZBaQ3Pchg18/Ld
 XvmfXEUQE71vbMUkT+CsS/Yk6Y=; b=Bs3y6Mgf1XXS4GqahhB6JKtLr8bNI6uJ1
 3JG5oiZOpzi1Ibcr7TFu2r+jaWWe+Unb1bX0S4z4Q2NWrYRkveH3/WUzCZJoOuG0
 TQZGe4cjtIUir39XlzNsJpZIpNuZb2kJpsXkvhtnd2n2IXVaUL9lXN3HAOlTQXWV
 x8crbIV4YZJaQ+qTBwgrSy8oXOGyXZs23wjKAhW73ScwGFF5lQH6XXIuG2MzxXln
 nXo0/6atsMbX9fUo1KUoYD8OyzNMxLctoQQnhO9su2vvWZZXkySohvHL4Nf4Pmw2
 G5TT0yf3CmRWTVgDqlv5F8H15/+UJmAmtd0eDk4PizTSO2QwZZ7jw==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d64dgx0s3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 02 Apr 2026 22:15:49 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 632M0qlZ008685;
 Thu, 2 Apr 2026 22:15:48 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d6v11upr5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 02 Apr 2026 22:15:48 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 632MFkcM15729052
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 2 Apr 2026 22:15:46 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 93F9A58056;
 Thu,  2 Apr 2026 22:15:46 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 34EC75805D;
 Thu,  2 Apr 2026 22:15:45 +0000 (GMT)
Received: from fedora-workstation.ibmuc.com (unknown [9.61.183.185])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  2 Apr 2026 22:15:45 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: jrossi@linux.ibm.com, cohuck@redhat.com, berrange@redhat.com,
 richard.henderson@linaro.org, pierrick.bouvier@linaro.org,
 david@kernel.org, walling@linux.ibm.com, jjherne@linux.ibm.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com, zycai@linux.ibm.com, alifm@linux.ibm.com,
 brueckner@linux.ibm.com, jdaley@linux.ibm.com
Subject: [PATCH v10 26/30] hw/s390x/ipl: Handle secure boot with multiple boot
 devices
Date: Thu,  2 Apr 2026 18:14:48 -0400
Message-ID: <20260402221453.1602899-27-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260402221453.1602899-1-zycai@linux.ibm.com>
References: <20260402221453.1602899-1-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDE5NSBTYWx0ZWRfX2g2ppYAr9S7r
 MSzcrpaMDOiGVuQA2wDbfjJN+d6DvRtXgKZFab/Ccdj5/SDuY6Mn0SCtr7W2wzSBzNVplwtAfTe
 5O9Bc3eB1fnPxvAxkCUjJMPoYe5sjmK4mwB/Ru+nbnvkdi1DbLzE2EzLHxhmXnSWFQIxwugyXAX
 RmoTuBg6UQRUhzubwmp5Apq3orzA26dmHTxT9zJlapPpW8/44qbbvbjAZiRK+4ZiK+LJs1T0rhr
 EAb0Xi2/iJod3WmU8X6m1v9wy/h0gqp9LVYhB3jKgMd/taR+getqTBuiku14/krRTHKMUZdV6vu
 pzP+9a0OIw4D93DAsABrgoP+9Hw3F/SBqS8na5MwjpPMYqRq37gFSUpMa2Mx2nnMwNdaOFniQXP
 9TLepuS08BAk3LUg9Sff2elDQcovMUhLew1ge9o0OOQ9NDF2NzGT5OrLiXofL9WBojUxmessvhR
 d7h/LXk/3biJ55LLlKA==
X-Authority-Analysis: v=2.4 cv=QKZlhwLL c=1 sm=1 tr=0 ts=69ceea95 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8
 a=Q8-XYP680VqNmkEzHFAA:9
X-Proofpoint-GUID: lrjRvEbw3T4PCT70nO3KHtwUiC2dBCyM
X-Proofpoint-ORIG-GUID: lrjRvEbw3T4PCT70nO3KHtwUiC2dBCyM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_04,2026-04-02_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 adultscore=0 impostorscore=0 clxscore=1015
 spamscore=0 bulkscore=0 priorityscore=1501 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604020195
Received-SPF: pass client-ip=148.163.158.5; envelope-from=zycai@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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

The current approach to enable secure boot relies on providing
secure-boot and boot-certs parameters of s390-ccw-virtio machine
type option, which apply to all boot devices.

With the possibility of multiple boot devices, secure boot expects all
provided devices to be supported and eligible (e.g.,
virtio-blk/virtio-scsi using the SCSI scheme).

If multiple boot devices are provided and include an unsupported (e.g.,
ECKD, VFIO) or a non-eligible (e.g., Net) device, the boot process will
terminate with an error logged to the console.

Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 hw/s390x/ipl.c          | 79 ++++++++++++++++++++++++++++-------------
 pc-bios/s390-ccw/main.c |  3 --
 2 files changed, 54 insertions(+), 28 deletions(-)

diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
index 67e8231c76..52f953fd32 100644
--- a/hw/s390x/ipl.c
+++ b/hw/s390x/ipl.c
@@ -473,6 +473,58 @@ static bool s390_secure_boot_enabled(void)
     return S390_CCW_MACHINE(qdev_get_machine())->secure_boot;
 }
 
+static bool s390_validate_secure_boot_device(int devtype, Error **errp)
+{
+    switch (devtype) {
+    case CCW_DEVTYPE_VFIO:
+       error_setg(errp, "Passthrough (vfio) CCW device does not support secure boot!");
+       return false;
+    case CCW_DEVTYPE_VIRTIO_NET:
+       error_setg(errp, "Virtio net boot device does not support secure boot!");
+       return false;
+    default:
+       return true;
+    }
+}
+
+static void s390_apply_secure_boot(IplParameterBlock *iplb, int devtype,
+                                   bool secure_boot, bool audit_mode)
+{
+    Error *local_error = NULL;
+
+    if (!secure_boot && !audit_mode) {
+        return;
+    }
+
+    if (!s390_validate_secure_boot_device(devtype, &local_error)) {
+        error_report_err(local_error);
+        exit(1);
+    }
+
+    /*
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
+     * Report (IPLIR) flag so that the firmware generates an IPL
+     * Information Report Block (IIRB).
+     *
+     * Results of secure boot will be stored in IIRB.
+     *
+     * Extend the IPL parameter block to its maximum length to ensure
+     * sufficient space for the BIOS to populate the IIRB.
+     */
+    iplb->hdr_flags |= DIAG308_IPIB_FLAGS_IPLIR;
+    iplb->len = cpu_to_be32(S390_IPLB_MAX_LEN);
+}
+
 static bool s390_build_iplb(DeviceState *dev_st, IplParameterBlock *iplb)
 {
     CcwDevice *ccw_dev = NULL;
@@ -529,31 +581,8 @@ static bool s390_build_iplb(DeviceState *dev_st, IplParameterBlock *iplb)
         s390_ipl_convert_loadparm((char *)lp, iplb->loadparm);
         iplb->flags |= DIAG308_FLAGS_LP_VALID;
 
-        /*
-         * If secure-boot is enabled, then toggle the secure IPL flags to
-         * trigger secure boot in the s390 BIOS.
-         *
-         * Boot process will terminate if any error occurs during secure boot.
-         *
-         * If SIPL is on, IPLIR must also be on.
-         */
-        if (s390_secure_boot_enabled()) {
-            iplb->hdr_flags |= (DIAG308_IPIB_FLAGS_SIPL | DIAG308_IPIB_FLAGS_IPLIR);
-            iplb->len = cpu_to_be32(S390_IPLB_MAX_LEN);
-        }
-        /*
-         * Secure boot in audit mode will perform
-         * if certificate(s) exist in the key store.
-         *
-         * IPL Information Report Block (IIRB) will exist
-         * for secure boot in audit mode.
-         *
-         * Results of secure boot will be stored in IIRB.
-         */
-        else if (s390_has_certificate()) {
-            iplb->hdr_flags |= DIAG308_IPIB_FLAGS_IPLIR;
-            iplb->len = cpu_to_be32(S390_IPLB_MAX_LEN);
-        }
+        s390_apply_secure_boot(iplb, devtype, s390_secure_boot_enabled(),
+                               s390_has_certificate());
 
         return true;
     }
diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
index 93d22fc77c..7233f3db89 100644
--- a/pc-bios/s390-ccw/main.c
+++ b/pc-bios/s390-ccw/main.c
@@ -304,9 +304,6 @@ static void ipl_ccw_device(void)
     switch (cutype) {
     case CU_TYPE_DASD_3990:
     case CU_TYPE_DASD_2107:
-        IPL_assert((boot_mode == ZIPL_BOOT_MODE_NORMAL),
-                    "Passthrough (vfio) CCW device does not support secure boot!");
-
         dasd_ipl(blk_schid, cutype);
         break;
     case CU_TYPE_VIRTIO:
-- 
2.53.0


