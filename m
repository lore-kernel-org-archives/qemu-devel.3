Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12E95CAC59F
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Sep 2025 23:23:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uz1Tk-0005lJ-EC; Wed, 17 Sep 2025 19:22:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1uz1TU-0005at-Ez; Wed, 17 Sep 2025 19:22:09 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1uz1TS-0002TW-FL; Wed, 17 Sep 2025 19:22:08 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58HIC2Cd001506;
 Wed, 17 Sep 2025 23:22:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=HWqdAsJPhLqaInWuF
 78u6cqXP9tvvNnaUajTlBE2mQs=; b=Jqx90vR9BSYqZFL22HSGxfKtkxdYxEytU
 ER3JWAZxrHZ6tpWtaXNANlnvOi0MfcGY13oGeTknLrUMWhlvehuRk6k/maZvR8ov
 /eA57PMiSPf8/hlX4o16yiW0H7T6MN/xGOqv+tY47xEzNBRKxvAjWsX5PkUZ7yX1
 XN3Tk1oSaQ/wS66UfbVfW8gckZ1ZECOien1Us2wlrL+3cccMtXa7dlKiIUf4nUr2
 xH8QRqxtUWkIGTZZ3XDEih/cv+Lx8WEW9fZlMmr03Jgw0Ga2wiS3GMc1l4olf/OQ
 R8Er1fUHRHqgDYJNFbJxJOn3YShLkeDE6+u5BuNMKcTVCRhIrybGQ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 497g4hpuwg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 17 Sep 2025 23:22:04 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58HK8q5Q005963;
 Wed, 17 Sep 2025 23:22:02 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 495jxuc1nc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 17 Sep 2025 23:22:02 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 58HNM1fZ59244834
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 17 Sep 2025 23:22:01 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4138658062;
 Wed, 17 Sep 2025 23:22:01 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2B4765805C;
 Wed, 17 Sep 2025 23:22:00 +0000 (GMT)
Received: from fedora-workstation.ibmuc.com (unknown [9.61.34.172])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 17 Sep 2025 23:22:00 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: thuth@redhat.com, berrange@redhat.com, richard.henderson@linaro.org,
 david@redhat.com, jrossi@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Cc: walling@linux.ibm.com, jjherne@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com, zycai@linux.ibm.com, alifm@linux.ibm.com
Subject: [PATCH v6 24/28] pc-bios/s390-ccw: Handle true secure IPL mode
Date: Wed, 17 Sep 2025 19:21:26 -0400
Message-ID: <20250917232131.495848-25-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250917232131.495848-1-zycai@linux.ibm.com>
References: <20250917232131.495848-1-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: rS2MYD6dR1qYPx74_FAQGSmBA_j6ydZo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwNCBTYWx0ZWRfX2bRlhC0hOXDo
 08aFOjV05OgU95gpcd9LHNMKg++d8kxiLP30DdE8/hKrIZZLSbegiA7LfCI2Ci7eh1CfehxxcIT
 taLQZbL8Wj9UDULZX/HW9vsAlJ1O4x2ySFG3tPyg0pn5yo3OUWzfgbd9DsvMtnbW97cQApJH9ZR
 1foCLOZ8x4vak1xxQnCAJcQZRGz8iG5wEPnCLzPNeH2aWJke7mQ8P2oN1LQPQjGMdNisOq3IYm6
 bR7Vw+F3YuWRXhIQvHI+kteP9siNFGhTkL4u4FVaQAZHzwXIFbmBmSmISGCsHSgg2W0S4NgoQsv
 CBbsQa5WAsQiKTAnbr3xwSFah+/JBXP/W4XSKqPtE2vhwM/Mq38QpMBJONLiyRGchQGBlFo97DZ
 QD/dnt6z
X-Proofpoint-GUID: rS2MYD6dR1qYPx74_FAQGSmBA_j6ydZo
X-Authority-Analysis: v=2.4 cv=co2bk04i c=1 sm=1 tr=0 ts=68cb429c cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=YZg3iBzERQu5FGnwKEMA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 priorityscore=1501 suspectscore=0 adultscore=0
 phishscore=0 malwarescore=0 spamscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509160204
Received-SPF: pass client-ip=148.163.156.1; envelope-from=zycai@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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
 docs/system/s390x/secure-ipl.rst | 16 ++++++++++++++++
 pc-bios/s390-ccw/bootmap.c       | 19 ++++++++++++++++---
 pc-bios/s390-ccw/main.c          |  7 ++++++-
 pc-bios/s390-ccw/s390-ccw.h      |  2 ++
 pc-bios/s390-ccw/secure-ipl.c    |  4 ++++
 pc-bios/s390-ccw/secure-ipl.h    |  3 +++
 6 files changed, 47 insertions(+), 4 deletions(-)

diff --git a/docs/system/s390x/secure-ipl.rst b/docs/system/s390x/secure-ipl.rst
index 205de8bc02..579b7b4993 100644
--- a/docs/system/s390x/secure-ipl.rst
+++ b/docs/system/s390x/secure-ipl.rst
@@ -67,3 +67,19 @@ Configuration:
     qemu-system-s390x -machine s390-ccw-virtio, \
                                boot-certs.0.path=/.../qemu/certs, \
                                boot-certs.1.path=/another/path/cert.pem ...
+
+Secure Mode
+-----------
+
+With *both* the presence of certificates in the store and the ``secure-boot=on``
+option, it is understood that secure boot should be performed with errors
+reported and boot will abort.
+
+Configuration:
+
+.. code-block:: shell
+
+    qemu-system-s390x -machine s390-ccw-virtio, \
+                               secure-boot=on, \
+                               boot-certs.0.path=/.../qemu/certs, \
+                               boot-certs.1.path=/another/path/cert.pem ...
diff --git a/pc-bios/s390-ccw/bootmap.c b/pc-bios/s390-ccw/bootmap.c
index 3922e7cdde..3ab89b91fb 100644
--- a/pc-bios/s390-ccw/bootmap.c
+++ b/pc-bios/s390-ccw/bootmap.c
@@ -737,6 +737,9 @@ static int zipl_run(ScsiBlockPtr *pte)
     entry = (ComponentEntry *)(&header[1]);
 
     switch (boot_mode) {
+    case ZIPL_BOOT_MODE_INVALID:
+        return -1;
+    case ZIPL_BOOT_MODE_SECURE:
     case ZIPL_BOOT_MODE_SECURE_AUDIT:
         if (zipl_run_secure(&entry, tmp_sec)) {
             return -1;
@@ -1118,9 +1121,16 @@ ZiplBootMode zipl_mode(uint8_t hdr_flags)
 {
     bool sipl_set = hdr_flags & DIAG308_IPIB_FLAGS_SIPL;
     bool iplir_set = hdr_flags & DIAG308_IPIB_FLAGS_IPLIR;
+    VCStorageSizeBlock *vcssb;
 
     if (!sipl_set && iplir_set) {
         return ZIPL_BOOT_MODE_SECURE_AUDIT;
+    } else if (sipl_set && iplir_set) {
+        vcssb = zipl_secure_get_vcssb();
+        if (vcssb == NULL || vcssb->length == VCSSB_NO_VC) {
+            return ZIPL_BOOT_MODE_INVALID;
+        }
+        return ZIPL_BOOT_MODE_SECURE;
     }
 
     return ZIPL_BOOT_MODE_NORMAL;
@@ -1131,7 +1141,8 @@ void zipl_load(void)
     VDev *vdev = virtio_get_device();
 
     if (vdev->is_cdrom) {
-        if (boot_mode == ZIPL_BOOT_MODE_SECURE_AUDIT) {
+        if (boot_mode == ZIPL_BOOT_MODE_SECURE_AUDIT ||
+            boot_mode == ZIPL_BOOT_MODE_SECURE) {
             panic("Secure boot from ISO image is not supported!");
         }
         ipl_iso_el_torito();
@@ -1140,7 +1151,8 @@ void zipl_load(void)
     }
 
     if (virtio_get_device_type() == VIRTIO_ID_NET) {
-        if (boot_mode == ZIPL_BOOT_MODE_SECURE_AUDIT) {
+        if (boot_mode == ZIPL_BOOT_MODE_SECURE_AUDIT ||
+            boot_mode == ZIPL_BOOT_MODE_SECURE) {
             panic("Virtio net boot device does not support secure boot!");
         }
         netmain();
@@ -1153,7 +1165,8 @@ void zipl_load(void)
         return;
     }
 
-    if (boot_mode == ZIPL_BOOT_MODE_SECURE_AUDIT) {
+    if (boot_mode == ZIPL_BOOT_MODE_SECURE_AUDIT ||
+        boot_mode == ZIPL_BOOT_MODE_SECURE) {
         panic("ECKD boot device does not support secure boot!");
     }
 
diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
index 668660e64d..c5b425209a 100644
--- a/pc-bios/s390-ccw/main.c
+++ b/pc-bios/s390-ccw/main.c
@@ -277,10 +277,15 @@ static void ipl_boot_device(void)
         boot_mode = zipl_mode(iplb->hdr_flags);
     }
 
+    if (boot_mode == ZIPL_BOOT_MODE_INVALID) {
+        panic("Need at least one certificate for secure boot!");
+    }
+
     switch (cutype) {
     case CU_TYPE_DASD_3990:
     case CU_TYPE_DASD_2107:
-        if (boot_mode == ZIPL_BOOT_MODE_SECURE_AUDIT) {
+        if (boot_mode == ZIPL_BOOT_MODE_SECURE_AUDIT ||
+            boot_mode == ZIPL_BOOT_MODE_SECURE) {
             panic("Passthrough (vfio) device does not support secure boot!");
         }
 
diff --git a/pc-bios/s390-ccw/s390-ccw.h b/pc-bios/s390-ccw/s390-ccw.h
index 6d51d07c90..389cc8ea7c 100644
--- a/pc-bios/s390-ccw/s390-ccw.h
+++ b/pc-bios/s390-ccw/s390-ccw.h
@@ -83,9 +83,11 @@ int virtio_read(unsigned long sector, void *load_addr);
 void zipl_load(void);
 
 typedef enum ZiplBootMode {
+    ZIPL_BOOT_MODE_INVALID = -1,
     ZIPL_BOOT_MODE_UNSPECIFIED = 0,
     ZIPL_BOOT_MODE_NORMAL = 1,
     ZIPL_BOOT_MODE_SECURE_AUDIT = 2,
+    ZIPL_BOOT_MODE_SECURE = 3,
 } ZiplBootMode;
 
 extern ZiplBootMode boot_mode;
diff --git a/pc-bios/s390-ccw/secure-ipl.c b/pc-bios/s390-ccw/secure-ipl.c
index cd798c1198..92e3e1e021 100644
--- a/pc-bios/s390-ccw/secure-ipl.c
+++ b/pc-bios/s390-ccw/secure-ipl.c
@@ -287,6 +287,10 @@ static bool check_sclab_presence(uint8_t *sclab_magic,
         comps->device_entries[comp_index].cei |= S390_IPL_COMPONENT_CEI_INVALID_SCLAB;
 
         /* a missing SCLAB will not be reported in audit mode */
+        if (boot_mode == ZIPL_BOOT_MODE_SECURE) {
+            zipl_secure_handle("Magic is not matched. SCLAB does not exist");
+         }
+
         return false;
     }
 
diff --git a/pc-bios/s390-ccw/secure-ipl.h b/pc-bios/s390-ccw/secure-ipl.h
index 87aa6e1465..d7786158c4 100644
--- a/pc-bios/s390-ccw/secure-ipl.h
+++ b/pc-bios/s390-ccw/secure-ipl.h
@@ -58,6 +58,9 @@ static inline void zipl_secure_handle(const char *message)
     case ZIPL_BOOT_MODE_SECURE_AUDIT:
         IPL_check(false, message);
         break;
+    case ZIPL_BOOT_MODE_SECURE:
+        IPL_assert(false, message);
+        break;
     default:
         break;
     }
-- 
2.50.1


