Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6444C3ABBE
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 22:53:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDA64-0004z6-E7; Thu, 08 May 2025 18:52:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1uDA61-0004s3-SZ; Thu, 08 May 2025 18:52:06 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1uDA60-0006de-48; Thu, 08 May 2025 18:52:05 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 548LgUuG031920;
 Thu, 8 May 2025 22:52:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=GCYx5K2oa2OzWqGFr
 Qf+TZsdF6UJpCPyDEDILxgrTqg=; b=ntQjvFZavjs0BqCGpRE7e5Rnct/dSxs4P
 5bROurzE7m3Sy3P6BbOih8SrDfQ7AmqPVyDNzDKTZlvE+zMVjbP1Ymq6tDB2XvNQ
 Z1FhfouA+XcG0ZF18Rno+Zne/+Qaq5gSngmooHlgMMMNbdU9Mcwi5oV9V380EY6B
 jBctpGWcRtwkFK5rkKRH+Zzs5Mcdev1XN6jCMwck+TLEkDnyZxBpo7J4SDOa26+X
 G4IsQVD380e8gFt9zCZt5Kd3eKQftumWLUULr5pyksOpXjnI5qjDThcVrX+/brlY
 nkgsMWEPy/Xh1B5n8ndw4M4+XBx+Q09zrcfalPMP6a3D0yP8Qvstw==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46h4rw87yv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 08 May 2025 22:52:02 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 548KMkLc025783;
 Thu, 8 May 2025 22:52:01 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46dwv0888r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 08 May 2025 22:52:01 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 548Mq0ci27001484
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 8 May 2025 22:52:00 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1CAF558055;
 Thu,  8 May 2025 22:52:00 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A43125804B;
 Thu,  8 May 2025 22:51:58 +0000 (GMT)
Received: from fedora-workstation.ibmuc.com (unknown [9.61.11.238])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  8 May 2025 22:51:58 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: thuth@redhat.com, richard.henderson@linaro.org, david@redhat.com,
 pbonzini@redhat.com
Cc: walling@linux.ibm.com, jjherne@linux.ibm.com, jrossi@linux.ibm.com,
 fiuczy@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, iii@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, zycai@linux.ibm.com
Subject: [PATCH v2 22/25] pc-bios/s390-ccw: Handle true secure IPL mode
Date: Thu,  8 May 2025 18:50:38 -0400
Message-ID: <20250508225042.313672-23-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250508225042.313672-1-zycai@linux.ibm.com>
References: <20250508225042.313672-1-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=QIxoRhLL c=1 sm=1 tr=0 ts=681d3592 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=HAb4tJrf35NjsZj3bCIA:9
X-Proofpoint-GUID: kT5_GbvJfLMHo98KchAJZFGq5GSlLUjP
X-Proofpoint-ORIG-GUID: kT5_GbvJfLMHo98KchAJZFGq5GSlLUjP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA4MDIwNSBTYWx0ZWRfXwa/1sucOoy2o
 sGLRLFCEjrrZ3m8rJHdcPmktyUE3/WrnyYdb0/NUHvd7rbHIupLaSZ7EwjLAZ+uJO3R9yASPYSU
 zdl89RNRIUpKJu4etYUBLqkHGhyFo1gySOZUfppbpG/osEOvuwthScgLWnm4v9t6mcaxmqvDxc9
 /+biqfKviU/0+FbOFZ5CQbhwm0lAtRCX5fL73IxIbSPiD6bK0zl6DBO49WegjnM92Qib+0bnTAv
 CKoGdz+7Q851rp8W10lZMjBhiR3Q4eCWo/odmyI4Ary9/qtC/Z9kbpK5t4NnEi6kx2vYeYkOFOF
 zHPPgyJW+7dQ9KDlFqsseXxNgiYIc2S/r+CKLuGJDNprNoGIWOk+bjQa4w+gSNH8ozFpx7QoCXi
 P8Bd2jjRariAltKc///mxCNo0cppuiSEUQqp+grXI+EEEiXwrnKFcHJNWyjPyMQDMxqiF+ry
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-08_07,2025-05-08_04,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 mlxscore=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015
 malwarescore=0 bulkscore=0 adultscore=0 mlxlogscore=859 spamscore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505080205
Received-SPF: pass client-ip=148.163.158.5; envelope-from=zycai@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
 pc-bios/s390-ccw/bootmap.c    | 16 +++++++++++++---
 pc-bios/s390-ccw/main.c       |  6 +++++-
 pc-bios/s390-ccw/s390-ccw.h   |  2 ++
 pc-bios/s390-ccw/secure-ipl.c |  5 +++++
 pc-bios/s390-ccw/secure-ipl.h |  2 ++
 5 files changed, 27 insertions(+), 4 deletions(-)

diff --git a/pc-bios/s390-ccw/bootmap.c b/pc-bios/s390-ccw/bootmap.c
index 24356820ca..395d52c65c 100644
--- a/pc-bios/s390-ccw/bootmap.c
+++ b/pc-bios/s390-ccw/bootmap.c
@@ -933,6 +933,9 @@ static int zipl_run(ScsiBlockPtr *pte)
     entry = (ComponentEntry *)(&header[1]);
 
     switch (boot_mode) {
+    case ZIPL_SECURE_INVALID_MODE:
+        return -1;
+    case ZIPL_SECURE_MODE:
     case ZIPL_SECURE_AUDIT_MODE:
         if (zipl_run_secure(entry, tmp_sec)) {
             return -1;
@@ -1305,9 +1308,16 @@ ZiplBootMode zipl_mode(uint8_t hdr_flags)
 {
     bool sipl_set = hdr_flags & DIAG308_IPIB_FLAGS_SIPL;
     bool iplir_set = hdr_flags & DIAG308_IPIB_FLAGS_IPLIR;
+    VCStorageSizeBlock *vcssb;
 
     if (!sipl_set && iplir_set) {
         return ZIPL_SECURE_AUDIT_MODE;
+    } else if (sipl_set && iplir_set) {
+        vcssb = zipl_secure_get_vcssb();
+        if (vcssb == NULL || vcssb->length == 4) {
+            return ZIPL_SECURE_INVALID_MODE;
+        }
+        return ZIPL_SECURE_MODE;
     }
 
     return ZIPL_NORMAL_MODE;
@@ -1318,7 +1328,7 @@ void zipl_load(void)
     VDev *vdev = virtio_get_device();
 
     if (vdev->is_cdrom) {
-        if (boot_mode == ZIPL_SECURE_AUDIT_MODE) {
+        if (boot_mode == ZIPL_SECURE_AUDIT_MODE || boot_mode == ZIPL_SECURE_MODE) {
             panic("Secure boot from ISO image is not supported!");
         }
         ipl_iso_el_torito();
@@ -1327,7 +1337,7 @@ void zipl_load(void)
     }
 
     if (virtio_get_device_type() == VIRTIO_ID_NET) {
-        if (boot_mode == ZIPL_SECURE_AUDIT_MODE) {
+        if (boot_mode == ZIPL_SECURE_AUDIT_MODE || boot_mode == ZIPL_SECURE_MODE) {
             panic("Virtio net boot device does not support secure boot!");
         }
         netmain();
@@ -1340,7 +1350,7 @@ void zipl_load(void)
         return;
     }
 
-    if (boot_mode == ZIPL_SECURE_AUDIT_MODE) {
+    if (boot_mode == ZIPL_SECURE_AUDIT_MODE || boot_mode == ZIPL_SECURE_MODE) {
         panic("ECKD boot device does not support secure boot!");
     }
 
diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
index 38962da1dd..3e17550854 100644
--- a/pc-bios/s390-ccw/main.c
+++ b/pc-bios/s390-ccw/main.c
@@ -277,10 +277,14 @@ static void ipl_boot_device(void)
         boot_mode = zipl_mode(iplb->hdr_flags);
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
index 85f92685f6..bf20efe88e 100644
--- a/pc-bios/s390-ccw/s390-ccw.h
+++ b/pc-bios/s390-ccw/s390-ccw.h
@@ -83,8 +83,10 @@ int virtio_read(unsigned long sector, void *load_addr);
 void zipl_load(void);
 
 typedef enum ZiplBootMode {
+    ZIPL_SECURE_INVALID_MODE = -1,
     ZIPL_NORMAL_MODE = 1,
     ZIPL_SECURE_AUDIT_MODE = 2,
+    ZIPL_SECURE_MODE = 3,
 } ZiplBootMode;
 
 extern ZiplBootMode boot_mode;
diff --git a/pc-bios/s390-ccw/secure-ipl.c b/pc-bios/s390-ccw/secure-ipl.c
index 6e91ec95a8..7d02622c37 100644
--- a/pc-bios/s390-ccw/secure-ipl.c
+++ b/pc-bios/s390-ccw/secure-ipl.c
@@ -248,6 +248,11 @@ static void valid_sclab_check(SclabOriginLocator *sclab_locator,
         comps->device_entries[comp_index].cei |= S390_IPL_COMPONENT_CEI_INVALID_SCLAB;
 
         /* a missing SCLAB will not be reported in audit mode */
+        if (boot_mode == ZIPL_SECURE_MODE) {
+            zipl_secure_print_func(is_magic_match,
+                                   "Magic is not matched. SCLAB does not exist");
+         }
+
         return;
     }
 
diff --git a/pc-bios/s390-ccw/secure-ipl.h b/pc-bios/s390-ccw/secure-ipl.h
index 713491671f..9a3b3f016b 100644
--- a/pc-bios/s390-ccw/secure-ipl.h
+++ b/pc-bios/s390-ccw/secure-ipl.h
@@ -52,6 +52,8 @@ static inline ipl_print_func_t zipl_secure_get_print_func(ZiplBootMode boot_mode
 {
     if (boot_mode == ZIPL_SECURE_AUDIT_MODE) {
         return &IPL_check;
+    } else if (boot_mode == ZIPL_SECURE_MODE) {
+        return &IPL_assert;
     }
 
     return NULL;
-- 
2.49.0


