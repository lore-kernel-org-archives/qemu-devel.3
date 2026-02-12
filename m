Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9E2EEEA84E
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 20:47:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqdYU-0001Cn-Gz; Thu, 12 Feb 2026 15:44:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1vqdYS-0001C5-Qo; Thu, 12 Feb 2026 15:44:52 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1vqdYR-0008Hz-89; Thu, 12 Feb 2026 15:44:52 -0500
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61CI5kSb328612; Thu, 12 Feb 2026 20:44:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=Nka937iiC45rlorMU
 nLcf3JnebtNciPBq/8ZThOSQjA=; b=VX6Y92hbSlD+lzunh/RBJEiuC7mDjz8jX
 2g28LHNmQmFctmbEniZYVztW2xsobx+EIIWNy4KWkGzYpqvCk+gnP+0FJh6Qmu8u
 BpFA+T9AWt56js0PTlnHk+KoFghmGL9ltQgd2pm0Z9W6PKDnwGwZoEQcJBRahasd
 W/eTsuw6ftub101oI9jRYVTxSxAHNLKLKX/xpdUnTEltu7UbdVo/E+0EnlLVFt+x
 WAzE/1ZRIX+Y3kI4/KLfYVntNCGCMyKtxsSUR52Reb0Hl/fa9iXTJtsOVpLe48Bw
 b7djMFCo0FcLCmVpPHBRgqRbsoQ8V41nr1oJx6h7XH2XrGdFJ1l+g==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c696v5bb8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Feb 2026 20:44:47 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61CHU3ZR001427;
 Thu, 12 Feb 2026 20:44:47 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4c6gqnc4p9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Feb 2026 20:44:47 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 61CKijuq30343844
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 12 Feb 2026 20:44:45 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4F92558054;
 Thu, 12 Feb 2026 20:44:45 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8E4115804E;
 Thu, 12 Feb 2026 20:44:43 +0000 (GMT)
Received: from fedora-workstation.ibmuc.com (unknown [9.61.112.15])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 12 Feb 2026 20:44:43 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: thuth@redhat.com, berrange@redhat.com, richard.henderson@linaro.org,
 jrossi@linux.ibm.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: david@kernel.org, walling@linux.ibm.com, jjherne@linux.ibm.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com, zycai@linux.ibm.com, alifm@linux.ibm.com,
 brueckner@linux.ibm.com
Subject: [PATCH v8 26/30] hw/s390x/ipl: Handle secure boot with multiple boot
 devices
Date: Thu, 12 Feb 2026 15:43:47 -0500
Message-ID: <20260212204352.1044699-27-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260212204352.1044699-1-zycai@linux.ibm.com>
References: <20260212204352.1044699-1-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEyMDE1NyBTYWx0ZWRfXwSUqUGj/w3G2
 NmW2EQyH0LIkjDYwQG81ktLZvQc+r2yI4l9xT6vwnvN8cvcWqrnaMm8Hiez+o9PzJ7v206JOTLQ
 z+Rlt22hYc9H3iHd3G4zMT17rJoVwJzeEJ6IPkqyvZuWSXlxTWfJ2TqsoteJpIFMc5Zaibs+Rkh
 2681VnReh/5zK8Ekxk7aAyI062/35PStJgajMgnS/3ymhHY2oUN3/4iO7m5BJr5f8yk1+xrtYaV
 0s5DdvvHUDbZXI1Jad8vrXpq5B9GEiPWxmI9lhVj/mZMN9HrXiANY11nF3Rw2eVJUUJbx8VdN/7
 E/QDRhWTZ3dAfl6gzuK2aMVrwRsQ5wzR/YtKWDiopVgP4puZjXdinIJMcPvkm4s8KjZik/811Qr
 vg8a5N8QKo/nQpgI87MbJhZFFjAU3Fu6b7f4M4aZ+tvZoAIi25CC+IFrfbwlvuxH3A8xL3Uu2Xw
 n2L8iZQVUoTK3pYn2hA==
X-Proofpoint-ORIG-GUID: 3Q_6DBR8zEd2mkBJkrFHzsJb0DgbB8p_
X-Proofpoint-GUID: 3Q_6DBR8zEd2mkBJkrFHzsJb0DgbB8p_
X-Authority-Analysis: v=2.4 cv=O+Y0fR9W c=1 sm=1 tr=0 ts=698e3bbf cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VnNF1IyMAAAA:8 a=Q8-XYP680VqNmkEzHFAA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-12_05,2026-02-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 phishscore=0 adultscore=0
 malwarescore=0 impostorscore=0 bulkscore=0 clxscore=1015 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602120157
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
2.52.0


