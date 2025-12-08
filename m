Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 313DED3B7E2
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Dec 2025 21:35:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vSire-0007ie-6h; Mon, 08 Dec 2025 16:33:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1vSirW-0007dv-Mc; Mon, 08 Dec 2025 16:33:42 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1vSirU-0000mE-KC; Mon, 08 Dec 2025 16:33:42 -0500
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5B8Cmnn2022275;
 Mon, 8 Dec 2025 21:33:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=c6aDpv9jGAGanmV4g
 6+hrSmhZLsJmay/DNzjc8cQ9OM=; b=sMTDXuJbAR5YvmkY7qH734b2JlAEpNhZ4
 /f0A9WZqR2wxltp4D4ZXP1WRhZ1mIrJF9jmt2kkwVkqcizCtJ302DRnFiiS/0cz/
 L9ygcQKJHFDk6KaiG2ARdRF6NAtqduuUKE1Bi6oP5cyLxHElPXkdl7iCa9+lLuS7
 Vd6YwAGB29brOf2I+08qIbXVYSgwbTwIBUngzMy3e40SxX0zQ7FIJSogEb2fGOn/
 n+hqG8g5VyRxbXN4BgGt4CZ6l33B+93VMyhJsJPRZBc4YaV+n6OAIaKcfo2c5126
 1nn/fiki1zkNXAG890tETCI0dKjc9wPwnakEkHKcy2K9INyuOvrqg==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4avc0jsup6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 08 Dec 2025 21:33:38 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5B8ITc6Z012432;
 Mon, 8 Dec 2025 21:33:37 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4aw0ajqnpk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 08 Dec 2025 21:33:37 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5B8LXK3129229766
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 8 Dec 2025 21:33:20 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AD55758059;
 Mon,  8 Dec 2025 21:33:35 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 02EBA5805B;
 Mon,  8 Dec 2025 21:33:34 +0000 (GMT)
Received: from fedora-workstation.ibmuc.com (unknown [9.61.66.246])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  8 Dec 2025 21:33:33 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: thuth@redhat.com, berrange@redhat.com, richard.henderson@linaro.org,
 david@redhat.com, jrossi@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, brueckner@linux.ibm.com
Cc: walling@linux.ibm.com, jjherne@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com, zycai@linux.ibm.com, alifm@linux.ibm.com
Subject: [PATCH v7 24/29] pc-bios/s390-ccw: Handle true secure IPL mode
Date: Mon,  8 Dec 2025 16:32:41 -0500
Message-ID: <20251208213247.702569-25-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251208213247.702569-1-zycai@linux.ibm.com>
References: <20251208213247.702569-1-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Cf8FJbrl c=1 sm=1 tr=0 ts=69374432 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=YZg3iBzERQu5FGnwKEMA:9
X-Proofpoint-ORIG-GUID: Ai1vGU38YFrVl_7AGk76EiXBiB_xdk3U
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA2MDAxNiBTYWx0ZWRfXxS28BrEjRDGV
 uCS01QZn9o1MeBp6LrYZiGaRQJpwR20jHHFkKSaW4lMIfQbAe1uNVYku5I6nB4XGzsftuQzwcRq
 QdHSgNeNx+y1f5crOIcdUjrohUvhyruNy/vZ+rwz7PeOpXRQ1wOlabl8+/yXmQIPQ0qE7AgE/+8
 eKU28IHYidV8ObaJwRpgpjajAxZeiEe/UkeY7QZMLQJ+rGNHjy8Rzm6DaSXsp9F1fvNnwRXfs90
 p7OiIeXWEgTrtN1NFbLf804Cacd/ZDcsXQoSSTvdG6zLEvrqc4eFy34om1QOuKkdhggIhvODXeC
 ksg4vW3/15J8XbkpiwGTpUq1LfPNfy5cXUULeHYX2OgE9F0D5g7Xo0BmdggDqt0cAbwSBKpc5lV
 AXdgY63QGsAArtf0/NTK76+Pw9cvGQ==
X-Proofpoint-GUID: Ai1vGU38YFrVl_7AGk76EiXBiB_xdk3U
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-06_02,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 malwarescore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2512060016
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
 docs/system/s390x/secure-ipl.rst | 13 +++++++++++++
 pc-bios/s390-ccw/bootmap.c       | 19 ++++++++++++++++---
 pc-bios/s390-ccw/main.c          |  7 ++++++-
 pc-bios/s390-ccw/s390-ccw.h      |  2 ++
 pc-bios/s390-ccw/secure-ipl.c    |  4 ++++
 pc-bios/s390-ccw/secure-ipl.h    |  3 +++
 6 files changed, 44 insertions(+), 4 deletions(-)

diff --git a/docs/system/s390x/secure-ipl.rst b/docs/system/s390x/secure-ipl.rst
index 675724d324..a03e59ae14 100644
--- a/docs/system/s390x/secure-ipl.rst
+++ b/docs/system/s390x/secure-ipl.rst
@@ -64,3 +64,16 @@ Configuration:
 .. code-block:: shell
 
     qemu-system-s390x -machine s390-ccw-virtio,boot-certs.0.path=/.../qemu/certs,boot-certs.1.path=/another/path/cert.pem ...
+
+Secure Mode
+-----------
+
+When both certificates are provided and ``secure-boot=on`` option is set,
+a secure boot is performed with error reporting enabled. The boot process aborts
+if any error occurs.
+
+Configuration:
+
+.. code-block:: shell
+
+    qemu-system-s390x -machine s390-ccw-virtio,secure-boot=on,boot-certs.0.path=/.../qemu/certs,boot-certs.1.path=/another/path/cert.pem ...
diff --git a/pc-bios/s390-ccw/bootmap.c b/pc-bios/s390-ccw/bootmap.c
index 342772860b..cc9a8cec6a 100644
--- a/pc-bios/s390-ccw/bootmap.c
+++ b/pc-bios/s390-ccw/bootmap.c
@@ -738,6 +738,9 @@ static int zipl_run(ScsiBlockPtr *pte)
     entry = (ComponentEntry *)(&header[1]);
 
     switch (boot_mode) {
+    case ZIPL_BOOT_MODE_INVALID:
+        return -1;
+    case ZIPL_BOOT_MODE_SECURE:
     case ZIPL_BOOT_MODE_SECURE_AUDIT:
         rc = zipl_run_secure(&entry, tmp_sec);
         if (rc) {
@@ -1121,9 +1124,16 @@ ZiplBootMode zipl_mode(uint8_t hdr_flags)
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
@@ -1134,7 +1144,8 @@ void zipl_load(void)
     VDev *vdev = virtio_get_device();
 
     if (vdev->is_cdrom) {
-        if (boot_mode == ZIPL_BOOT_MODE_SECURE_AUDIT) {
+        if (boot_mode == ZIPL_BOOT_MODE_SECURE_AUDIT ||
+            boot_mode == ZIPL_BOOT_MODE_SECURE) {
             panic("Secure boot from ISO image is not supported!");
         }
         ipl_iso_el_torito();
@@ -1143,7 +1154,8 @@ void zipl_load(void)
     }
 
     if (virtio_get_device_type() == VIRTIO_ID_NET) {
-        if (boot_mode == ZIPL_BOOT_MODE_SECURE_AUDIT) {
+        if (boot_mode == ZIPL_BOOT_MODE_SECURE_AUDIT ||
+            boot_mode == ZIPL_BOOT_MODE_SECURE) {
             panic("Virtio net boot device does not support secure boot!");
         }
         netmain();
@@ -1156,7 +1168,8 @@ void zipl_load(void)
         return;
     }
 
-    if (boot_mode == ZIPL_BOOT_MODE_SECURE_AUDIT) {
+    if (boot_mode == ZIPL_BOOT_MODE_SECURE_AUDIT ||
+        boot_mode == ZIPL_BOOT_MODE_SECURE) {
         panic("ECKD boot device does not support secure boot!");
     }
 
diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
index 8aabce115f..5cea9d3ac7 100644
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
             panic("Passthrough (vfio) CCW device does not support secure boot!");
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
index 8733254cfb..bfe021fffe 100644
--- a/pc-bios/s390-ccw/secure-ipl.c
+++ b/pc-bios/s390-ccw/secure-ipl.c
@@ -296,6 +296,10 @@ static bool check_sclab_presence(uint8_t *sclab_magic,
         comps->device_entries[comp_index].cei |= S390_IPL_COMPONENT_CEI_INVALID_SCLAB;
 
         /* a missing SCLAB will not be reported in audit mode */
+        if (boot_mode == ZIPL_BOOT_MODE_SECURE) {
+            zipl_secure_handle("Magic does not matched. SCLAB does not exist");
+        }
+
         return false;
     }
 
diff --git a/pc-bios/s390-ccw/secure-ipl.h b/pc-bios/s390-ccw/secure-ipl.h
index 6ff4f0382c..587a87a27c 100644
--- a/pc-bios/s390-ccw/secure-ipl.h
+++ b/pc-bios/s390-ccw/secure-ipl.h
@@ -58,6 +58,9 @@ static inline void zipl_secure_handle(const char *message)
     case ZIPL_BOOT_MODE_SECURE_AUDIT:
         IPL_check(false, message);
         break;
+    case ZIPL_BOOT_MODE_SECURE:
+        panic(message);
+        break;
     default:
         break;
     }
-- 
2.51.1


