Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D597C369A4
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Apr 2025 16:18:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2Bdu-0006pa-Kp; Tue, 08 Apr 2025 12:17:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1u2BJ9-0005dR-B5; Tue, 08 Apr 2025 11:56:19 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1u2BJ5-0005yv-AQ; Tue, 08 Apr 2025 11:56:13 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 538CRbeT029640;
 Tue, 8 Apr 2025 15:56:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=aP70PiCRGh8Szwjr6
 XxBcB7QN57iBHEy4Hyed5JBrLc=; b=sSjsJh2nUDME0Dg1Bl/fs25/uR68oOn10
 e8c81o/WtXxsYL0iEGIUNZLO/nPX9X86huAvxoLHizpqkMQ5YG+cDSBM+FA6+lHN
 qnuh7vgWaUoKWz3PH+bnAXjM/l63Ll/gss6j1ZL4Aidi0CYRhDDBZuSQmz7bCzfd
 YTG4LC6HYjrnO7itTrWRyxwR+qYB7LNoalugwch7JS9E2wder3/QRoUt5jK5+4w8
 CMKfojR3O7M+E3YvVdqig4xSzGCfKmkT4pbmbt8kmScZk7oHvRFRKWLvrldM66aK
 vbkl6FGebTkk3NeRg/nRwjBmESnDieEuBM3S8phVM4nnqaswPoGMQ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45vv6a3any-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 08 Apr 2025 15:56:08 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 538FMZYA024577;
 Tue, 8 Apr 2025 15:56:07 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 45ueutbjkc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 08 Apr 2025 15:56:07 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 538Fu6Vx26739224
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 8 Apr 2025 15:56:06 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0D2BA58055;
 Tue,  8 Apr 2025 15:56:06 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7BFE45804E;
 Tue,  8 Apr 2025 15:56:04 +0000 (GMT)
Received: from fedora-workstation.ibmuc.com (unknown [9.61.125.94])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  8 Apr 2025 15:56:04 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: thuth@redhat.com, richard.henderson@linaro.org, david@redhat.com,
 pbonzini@redhat.com
Cc: walling@linux.ibm.com, jjherne@linux.ibm.com, jrossi@linux.ibm.com,
 fiuczy@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, iii@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, zycai@linux.ibm.com
Subject: [PATCH v1 22/24] pc-bios/s390-ccw: Handle true secure IPL mode
Date: Tue,  8 Apr 2025 11:55:24 -0400
Message-ID: <20250408155527.123341-23-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408155527.123341-1-zycai@linux.ibm.com>
References: <20250408155527.123341-1-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 4qsuOZz3UhsVt2wvCA-JFfmrv2cS994X
X-Proofpoint-GUID: 4qsuOZz3UhsVt2wvCA-JFfmrv2cS994X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-08_06,2025-04-08_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0
 lowpriorityscore=0 spamscore=0 priorityscore=1501 adultscore=0
 clxscore=1015 suspectscore=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504080107
Received-SPF: pass client-ip=148.163.156.1; envelope-from=zycai@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 08 Apr 2025 12:17:35 -0400
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

When secure boot is enabled (-secure-boot on) and certificate(s) are
provided, the boot operates in True Secure IPL mode.

Any verification error during True Secure IPL mode will cause the
entire boot process to terminate.

Secure IPL in audit mode requires at least one certificate provided in
the key store along with necessary facilities. If secure boot is enabled
but no certificate is provided, the boot process will also terminate, as
this is not a valid secure boot configuration.

Note: True Secure IPL mode is implemented for the SCSI scheme of
virtio-blk/virtio-scsi devices.

Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
---
 pc-bios/s390-ccw/bootmap.c  | 25 ++++++++++++++++++++-----
 pc-bios/s390-ccw/iplb.h     |  7 +++++++
 pc-bios/s390-ccw/main.c     |  6 +++++-
 pc-bios/s390-ccw/s390-ccw.h |  2 ++
 4 files changed, 34 insertions(+), 6 deletions(-)

diff --git a/pc-bios/s390-ccw/bootmap.c b/pc-bios/s390-ccw/bootmap.c
index 4bc6311802..a22061e1ad 100644
--- a/pc-bios/s390-ccw/bootmap.c
+++ b/pc-bios/s390-ccw/bootmap.c
@@ -757,6 +757,10 @@ static void valid_sclab_check(SclabOriginLocator *sclab_locator,
         comps->device_entries[comp_index].cei |= S390_IPL_COMPONENT_CEI_INVALID_SCLAB;
 
         /* a missing SCLAB will not be reported in audit mode */
+        if (boot_mode == ZIPL_SECURE_MODE) {
+            print_func(is_magic_match, "Magic is not matched. SCLAB does not exist");
+        }
+
         return;
     }
 
@@ -1164,7 +1168,11 @@ static int zipl_run_secure(ComponentEntry *entry, uint8_t *tmp_sec)
     int addr_range_index = 0;
 
     void (*print_func)(bool, const char *) = NULL;
-    print_func = &IPL_check;
+    if (boot_mode == ZIPL_SECURE_MODE) {
+        print_func = &IPL_assert;
+    } else if (boot_mode == ZIPL_SECURE_AUDIT_MODE) {
+        print_func = &IPL_check;
+    }
 
     if (!secure_ipl_supported()) {
         return -1;
@@ -1321,6 +1329,7 @@ static int zipl_run(ScsiBlockPtr *pte)
     entry = (ComponentEntry *)(&header[1]);
 
     switch (boot_mode) {
+    case ZIPL_SECURE_MODE:
     case ZIPL_SECURE_AUDIT_MODE:
         if (zipl_run_secure(entry, tmp_sec)) {
             return -1;
@@ -1692,10 +1701,16 @@ static int zipl_load_vscsi(void)
 int zipl_mode(void)
 {
     uint32_t cert_len;
+    bool secure;
 
     cert_len = request_certificate((uint64_t *)certs_sec, 0);
+    secure = is_secure_boot_on(iplb->hdr_flags);
 
-    return (cert_len > 0) ? ZIPL_SECURE_AUDIT_MODE : ZIPL_NORMAL_MODE;
+    if (secure) {
+        return (cert_len > 0) ? ZIPL_SECURE_MODE : ZIPL_SECURE_INVALID_MODE;
+    } else {
+        return (cert_len > 0) ? ZIPL_SECURE_AUDIT_MODE : ZIPL_NORMAL_MODE;
+    }
 }
 
 void zipl_load(void)
@@ -1703,7 +1718,7 @@ void zipl_load(void)
     VDev *vdev = virtio_get_device();
 
     if (vdev->is_cdrom) {
-        if (boot_mode == ZIPL_SECURE_AUDIT_MODE) {
+        if (boot_mode == ZIPL_SECURE_AUDIT_MODE || boot_mode == ZIPL_SECURE_MODE) {
             panic("Secure boot from ISO image is not supported!");
         }
         ipl_iso_el_torito();
@@ -1712,7 +1727,7 @@ void zipl_load(void)
     }
 
     if (virtio_get_device_type() == VIRTIO_ID_NET) {
-        if (boot_mode == ZIPL_SECURE_AUDIT_MODE) {
+        if (boot_mode == ZIPL_SECURE_AUDIT_MODE || boot_mode == ZIPL_SECURE_MODE) {
             panic("Virtio net boot device does not support secure boot!");
         }
         netmain();
@@ -1725,7 +1740,7 @@ void zipl_load(void)
         return;
     }
 
-    if (boot_mode == ZIPL_SECURE_AUDIT_MODE) {
+    if (boot_mode == ZIPL_SECURE_AUDIT_MODE || boot_mode == ZIPL_SECURE_MODE) {
         panic("ECKD boot device does not support secure boot!");
     }
 
diff --git a/pc-bios/s390-ccw/iplb.h b/pc-bios/s390-ccw/iplb.h
index 42a9e081fe..734d049f42 100644
--- a/pc-bios/s390-ccw/iplb.h
+++ b/pc-bios/s390-ccw/iplb.h
@@ -185,6 +185,13 @@ static inline bool load_next_iplb(void)
     return true;
 }
 
+static inline bool is_secure_boot_on(uint8_t hdr_flags)
+{
+    /* If secure boot is on, SIPL bit and IPLIR bit must be on. */
+    return (hdr_flags & DIAG308_IPIB_FLAGS_SIPL) &&
+           (hdr_flags & DIAG308_IPIB_FLAGS_IPLIR);
+}
+
 static inline uint64_t diag320(void *data, unsigned long subcode)
 {
     register unsigned long addr asm("0") = (unsigned long)data;
diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
index 92004a6f82..6189a5a7ba 100644
--- a/pc-bios/s390-ccw/main.c
+++ b/pc-bios/s390-ccw/main.c
@@ -277,10 +277,14 @@ static void ipl_boot_device(void)
         boot_mode = zipl_mode();
     }
 
+    if (boot_mode == ZIPL_SECURE_INVALID_MODE) {
+        panic("Need at least one certificate for secure boot!");
+    }
+
     switch (cutype) {
     case CU_TYPE_DASD_3990:
     case CU_TYPE_DASD_2107:
-        if (boot_mode == ZIPL_SECURE_AUDIT_MODE) {
+        if (boot_mode == ZIPL_SECURE_AUDIT_MODE || boot_mode == ZIPL_SECURE_MODE) {
             panic("Passthrough (vfio) device does not support secure boot!");
         }
 
diff --git a/pc-bios/s390-ccw/s390-ccw.h b/pc-bios/s390-ccw/s390-ccw.h
index 20d6827a4c..e8ff3f7883 100644
--- a/pc-bios/s390-ccw/s390-ccw.h
+++ b/pc-bios/s390-ccw/s390-ccw.h
@@ -84,6 +84,8 @@ void zipl_load(void);
 
 #define ZIPL_NORMAL_MODE           1
 #define ZIPL_SECURE_AUDIT_MODE     2
+#define ZIPL_SECURE_MODE           3
+#define ZIPL_SECURE_INVALID_MODE  -1
 
 int zipl_mode(void);
 
-- 
2.49.0


