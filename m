Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D990F513E1
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 22:45:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyHPG-0002BZ-Ie; Thu, 05 Mar 2026 17:42:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1vyHPD-00020A-NJ; Thu, 05 Mar 2026 17:42:56 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1vyHPC-0007AH-0f; Thu, 05 Mar 2026 17:42:55 -0500
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 625KEaPT2123727; Thu, 5 Mar 2026 22:42:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=QmQndQisAyVrNbCsy
 fcu/C+f9/NEDnmg14SBc4obgQQ=; b=Rkm0f9n99TPTXDp5Fw+H6nCQUp77U4mlw
 8lLMGJKCHasfANTEN9wZdymUW3GyOyCH2eHsc8PUFWOpsFP82aZ2gk2Bt1Geq7e3
 L1PbzUZ/45UsBdodKUuho0jCGVBzyEXNbFKyJj7/YGuwXhC4+No7TOrCxzdt+340
 jjqecv3hB+y/pCtJkhUxAxlUhXKP9GSK3JurjJQx3bfNbgj8BDU8dGzu1HEjaVqL
 BxT2k04aNuYo0vhAyqgYPuUfKrD3dnSe1l826eF+/lhfsp7+P1UvGbyqChfx4nhu
 1sVn67O3xMramb9T2kPb/JplIem8nj7Eym5n6OAUy89in6yRT5ZZA==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ckskd5xdd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 05 Mar 2026 22:42:30 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 625J36C5027658;
 Thu, 5 Mar 2026 22:42:29 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cmcwjn4m3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 05 Mar 2026 22:42:29 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 625MgR2Q31720172
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 5 Mar 2026 22:42:27 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2674458057;
 Thu,  5 Mar 2026 22:42:27 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E652E58058;
 Thu,  5 Mar 2026 22:42:25 +0000 (GMT)
Received: from fedora-workstation.ibmuc.com (unknown [9.61.36.214])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  5 Mar 2026 22:42:25 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: thuth@redhat.com, berrange@redhat.com, jrossi@linux.ibm.com,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, pierrick.bouvier@linaro.org,
 david@kernel.org, walling@linux.ibm.com, jjherne@linux.ibm.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com, zycai@linux.ibm.com, alifm@linux.ibm.com,
 brueckner@linux.ibm.com, jdaley@linux.ibm.com
Subject: [PATCH v9 26/30] hw/s390x/ipl: Handle secure boot with multiple boot
 devices
Date: Thu,  5 Mar 2026 17:41:41 -0500
Message-ID: <20260305224146.664053-27-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260305224146.664053-1-zycai@linux.ibm.com>
References: <20260305224146.664053-1-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: hJUYUEQSXSfAcooRDAn-D2EckIvCOWj_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA1MDE5NCBTYWx0ZWRfX28ahaAOq3Oaw
 dbp5bZQ/3dCpIXLFzn0W/iDJBHmo0udLWYdKn7xcU9jwSD5Lea/ruPqklWxlxku192dmi5UjxGw
 DeDBEF5trxx9ON0Jb2GBjPsNFJoMDC3Gp8bkRZUH5q3H9UgNYeWgKpSi+plCI91fx55zWM7wE2C
 vbb4cnvB9oi6e59d898gV7vAsDSy1IGsHiq1hEnS0wlX/icHnRZdsllMy+8V8FcD6+jBoaXn/uH
 7qcVkVrgwVaCa204gx0LqeKvpXHmvNRFeCkrHTE1WRZqFqtIMN3Y+x+JPw2Y98oOcBV5y/XIePn
 /m9oTJ8JdAbUJyxmSP42C400YHLkEbXNJE2blohOhz0RZTdPakCqVM44iT4sKQQUj57JXX63Bx0
 Oeo4t89bHmzP31m/XyKBnwq5RNsIbThZYnW6xgOLTzMjeKve5pOw/3b3QM2GEKoufC2iCI90YVV
 8aehhWP+mejP2zNQ9Tw==
X-Authority-Analysis: v=2.4 cv=H7DWAuYi c=1 sm=1 tr=0 ts=69aa06d6 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8
 a=Q8-XYP680VqNmkEzHFAA:9
X-Proofpoint-ORIG-GUID: hJUYUEQSXSfAcooRDAn-D2EckIvCOWj_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-05_06,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603050194
Received-SPF: pass client-ip=148.163.156.1; envelope-from=zycai@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.892, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.622,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
index f8dd50f69d..e46e655ef1 100644
--- a/hw/s390x/ipl.c
+++ b/hw/s390x/ipl.c
@@ -445,6 +445,58 @@ static bool s390_secure_boot_enabled(void)
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
@@ -502,31 +554,8 @@ static bool s390_build_iplb(DeviceState *dev_st, IplParameterBlock *iplb)
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
index 1678ede8fb..6633a2cbaf 100644
--- a/pc-bios/s390-ccw/main.c
+++ b/pc-bios/s390-ccw/main.c
@@ -276,9 +276,6 @@ static void ipl_boot_device(void)
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


