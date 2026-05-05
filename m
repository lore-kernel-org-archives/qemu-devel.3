Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03309CD3427
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 20:23:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKMFs-0001LO-9h; Tue, 05 May 2026 16:20:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1wKMFl-00016d-KQ; Tue, 05 May 2026 16:20:25 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1wKMFj-0000Rs-Sn; Tue, 05 May 2026 16:20:25 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 645HRnil2769341; Tue, 5 May 2026 20:20:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=UzFmr+Z1cTX3u+oHg
 Q+RffurjL9ZEVu2B/U9rP1LcBU=; b=oHVjlxEkVVfIj5sNAACOsmayNt8uazvHq
 +NbOXBQZmOSPAMx/SAAWmxfYYfMi4cJOLwgDutp9KjLI//X+h+N8JfSqWP7kjvwS
 CvprEJNWdwWQ5eIkZyqXlVlOq7QoC/2YA9THI1nGy02UJrUrndaiAsFD8oQHfhZf
 LIsoIWxDU9R/TxXwbNgYp6qpJcGPbP+0+E49g+QUe7z2uYQpa+C2ilztnZB20hAW
 82+7bfL0JlPIgCF2qkvoTHxPw8CgBq8y+s15umYkPbL1qWb7TcPmPhIaAP9fnM6F
 TKhMADKJo5cMTXhY1LdkyFsYOTT0rA5YhykzbC7pq5F+MSFhW0XuQ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9w6d6ry-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 05 May 2026 20:20:00 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 645K9RrL002872;
 Tue, 5 May 2026 20:19:59 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dwvkju9xn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 05 May 2026 20:19:59 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 645KJwOB7734018
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 5 May 2026 20:19:58 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 52C005805D;
 Tue,  5 May 2026 20:19:58 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 91B135805B;
 Tue,  5 May 2026 20:19:56 +0000 (GMT)
Received: from fedora-workstation.pok.ibm.com (unknown [9.12.79.241])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  5 May 2026 20:19:56 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: jrossi@linux.ibm.com, cohuck@redhat.com, berrange@redhat.com,
 richard.henderson@linaro.org, david@kernel.org, walling@linux.ibm.com,
 jjherne@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, mjrosato@linux.ibm.com, iii@linux.ibm.com,
 eblake@redhat.com, armbru@redhat.com, zycai@linux.ibm.com,
 alifm@linux.ibm.com, brueckner@linux.ibm.com,
 pierrick.bouvier@oss.qualcomm.com, jdaley@linux.ibm.com
Subject: [PATCH v11 28/32] hw/s390x/ipl: Handle secure boot with multiple boot
 devices
Date: Tue,  5 May 2026 16:19:00 -0400
Message-ID: <20260505201905.997996-29-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260505201905.997996-1-zycai@linux.ibm.com>
References: <20260505201905.997996-1-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=XPQAjwhE c=1 sm=1 tr=0 ts=69fa50f0 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8
 a=Q8-XYP680VqNmkEzHFAA:9
X-Proofpoint-ORIG-GUID: 95mjMQxC87Ic_UBUifsXFoGXKakfv60L
X-Proofpoint-GUID: 95mjMQxC87Ic_UBUifsXFoGXKakfv60L
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDE5NSBTYWx0ZWRfX3vRQgLwvox7P
 JpUkILrtH1b9rgAxahMhgayJh3AHa3+IH4Qluf3FkPhoQdBjobHeWiVApf6LfPXmp0V1CUXpv/y
 NHvfuXhALnvHlzIRjbIkbxkZxuUwvifXfxVfPM/e4np2VaSFmySuA/sdkKP6lRAp9vhZwiNFojv
 liDPRCFMhoUwtOoYZTlPhdOF4HcxJvOeBNQIj+sRRvzjZgIrDtyKXdqsoKwd28Wg5tzYrbsfVYP
 r4cxu7hdjux3/kWhqfqmqnH+fZhzUEJTg/i/QGoy3ajntmCR8l1P39S2Tl8X7GzI8ln6xH3t4ON
 yz55FAKMbLmWLLRCrkUq188t2qPcXoxu1AAZUli6umMUDzMYQ4JULXWDP9NFuuYDI+jfK4xXP2L
 LPFqgS+9UykAizWdX9ybo0exL/l7Dhqvfzl063cPeyqE4lKlFekpMQHmvefPfx6mpR7cQNFRowR
 eWN8bx7mvLyD7xWJ1tg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_02,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605050195
Received-SPF: pass client-ip=148.163.158.5; envelope-from=zycai@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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
index e34179a05f..2db3b704ab 100644
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
2.54.0


