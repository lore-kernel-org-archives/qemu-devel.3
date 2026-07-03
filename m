Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D17FC43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 17:06:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfhHO-0001FR-VE; Fri, 03 Jul 2026 13:02:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1wfhH1-0008FC-V6; Fri, 03 Jul 2026 13:01:57 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1wfhGy-0003MI-RH; Fri, 03 Jul 2026 13:01:55 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 663GIcDS3382914; Fri, 3 Jul 2026 17:01:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=gBHr+IlvuTOTuLwle
 grAoznZYuaxIyK7Qqeyi0dAHNI=; b=MuaunqfrZeUkOSqs3+xnUBTdu00QOujYU
 K/ofxwhxrtbKkYo9aX7/aWwzp05XAk0keUIohX2UBqWQvv/tiicLOGldsWuM/f0B
 ujRUZiOVr702ZwCXz78iMILYlpO4iccaz9Uu4BqO+BhIVa0NI3ehSisn6+PPi672
 0spXU6dSy6+EvCDMZT80Z5TvooTsHwEL9upzU7sdGUnC21A5iGtRioBT88KUGgEr
 uG44Mu/qHBtkdlaXHrduym5ZyY3SW1Uk1lb9t8y/oOwLSRCZN2cIPUj+VHza1plU
 vJStPSSSvQsnZOB1kckiC8qrtcMQhOXIh0OExkV37Yn+UjC5xd6Zg==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26pegae6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 03 Jul 2026 17:01:48 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 663GnlUK020290;
 Fri, 3 Jul 2026 17:01:47 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f2u2gsk8x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 03 Jul 2026 17:01:47 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 663H1kWF26935968
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 3 Jul 2026 17:01:46 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 834F65805A;
 Fri,  3 Jul 2026 17:01:46 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A84BF58054;
 Fri,  3 Jul 2026 17:01:43 +0000 (GMT)
Received: from fedora-workstation.lan (unknown [9.61.75.28])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  3 Jul 2026 17:01:43 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: jrossi@linux.ibm.com, cohuck@redhat.com, berrange@redhat.com,
 richard.henderson@linaro.org, david@kernel.org, walling@linux.ibm.com,
 jjherne@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, mjrosato@linux.ibm.com, iii@linux.ibm.com,
 eblake@redhat.com, armbru@redhat.com, zycai@linux.ibm.com,
 alifm@linux.ibm.com, brueckner@linux.ibm.com,
 pierrick.bouvier@oss.qualcomm.com, jdaley@linux.ibm.com
Subject: [PATCH v14 22/33] pc-bios/s390-ccw: Introduce ZiplBootMode enum for
 IPL mode selection
Date: Fri,  3 Jul 2026 13:00:19 -0400
Message-ID: <20260703170032.1893204-23-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260703170032.1893204-1-zycai@linux.ibm.com>
References: <20260703170032.1893204-1-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: S5oaGpsPx9E3JDAIkcPNddhtmqLhT_yA
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDE2NyBTYWx0ZWRfX7d72borlG9IX
 GIkD6XkO/H/YOBkB/c/bMEDtFdabEZ32JBhXqMtb5WiT16MU2+p1RyFJcbjH5ACkrtu0M7jMSAa
 UZ2cYVNoTQ2K+fMg1ZFIeEX5WZF/ewo=
X-Authority-Analysis: v=2.4 cv=edsNubEH c=1 sm=1 tr=0 ts=6a47eafc cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=OEmD_Q5Wy55prwwHBkMA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDE2NyBTYWx0ZWRfX1IzTNhIIlzus
 3zV4+4380RoKQa6K58Fob2iPPqMvF5IQ0HHWTzFCTM8X6FJM4ebY0744nucEzu43+mRqm7dlZo8
 6oSU4Fs2eSdHlo9N4SMQs9eH1Ce765jgKNp/ac5pCIF3LOUS6ss9VPz9zxB+w19Mz2H81VoWsRa
 hHqze+RPMdTOs9H7UWM1ybrOyFO6Ks8oMTh3Wd55evqweQliWb1XYsnr5Kf1tNC6XfhDjRBeVKc
 /b8YaYHYJaRtNEZ9dMScwGrz3O0L7XbsJeqjCRRRtyDjs0NHdG07UO3Awv0QeGjMfmruTC8+dNx
 SJ11qIcpXnHWkWK1DPeukNzbJP1bVoRzbwe1xzF2QujItNJixJ7WU/749cBja0KyWQhCtEaQlpL
 sL4yRXdU8Nt5jkqTMDPTCh/TxvvB1pUYNc85tFYf2gBaf5igQRU+TJ6TrekGH4h2i/IBe0cnZhd
 GPoMNlwodTT8zuPDjkw==
X-Proofpoint-ORIG-GUID: S5oaGpsPx9E3JDAIkcPNddhtmqLhT_yA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 adultscore=0 impostorscore=0 bulkscore=0
 spamscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030167
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

Add ZiplBootMode enumeration to support multiple IPL boot configurations.
Boot modes differentiate between normal boot and secure IPL operations,
enabled based on boot certificates specified via the boot-certs option.

Normal Mode: IPL when no certificates are provided. No signature
verification is performed.

This prepares for future secure IPL modes requiring signature
verification.

Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
Reviewed-by: Collin Walling <walling@linux.ibm.com>
Reviewed-by: Jared Rossi <jrossi@linux.ibm.com>
---
 docs/system/s390x/secure-ipl.rst | 21 +++++++++++++++++++++
 pc-bios/s390-ccw/bootmap.c       | 16 +++++++++++++++-
 pc-bios/s390-ccw/main.c          |  6 ++++++
 pc-bios/s390-ccw/s390-ccw.h      |  6 ++++++
 4 files changed, 48 insertions(+), 1 deletion(-)

diff --git a/docs/system/s390x/secure-ipl.rst b/docs/system/s390x/secure-ipl.rst
index 88df52ce2f..9d7d33f5ed 100644
--- a/docs/system/s390x/secure-ipl.rst
+++ b/docs/system/s390x/secure-ipl.rst
@@ -18,3 +18,24 @@ Note: certificate files must have a .pem extension.
 .. code-block:: shell
 
     qemu-system-s390x -machine s390-ccw-virtio,boot-certs.0.path=/.../qemu/certs,boot-certs.1.path=/another/path/cert.pem ...
+
+
+IPL Modes
+---------
+
+Multiple IPL modes are available to differentiate between the various IPL
+configurations. These modes are mutually exclusive and enabled based on the
+``boot-certs`` option on the QEMU command line.
+
+Normal Mode
+^^^^^^^^^^^
+
+The absence of certificates will attempt to IPL a guest without secure IPL
+operations. No checks are performed, and no warnings/errors are reported.
+This is the default mode.
+
+Configuration:
+
+.. code-block:: shell
+
+    qemu-system-s390x -machine s390-ccw-virtio ...
diff --git a/pc-bios/s390-ccw/bootmap.c b/pc-bios/s390-ccw/bootmap.c
index d0ac97795d..b724152644 100644
--- a/pc-bios/s390-ccw/bootmap.c
+++ b/pc-bios/s390-ccw/bootmap.c
@@ -729,7 +729,14 @@ static int zipl_run(ScsiBlockPtr *pte)
     /* Load image(s) into RAM */
     entry = (ComponentEntry *)(&header[1]);
 
-    rc = zipl_run_normal(&entry, tmp_sec);
+    switch (boot_mode) {
+    case ZIPL_BOOT_MODE_NORMAL:
+        rc = zipl_run_normal(&entry, tmp_sec);
+        break;
+    default:
+        panic("Unknown boot mode");
+    }
+
     if (rc) {
         return rc;
     }
@@ -1101,12 +1108,16 @@ void zipl_load(void)
     VDev *vdev = virtio_get_device();
 
     if (vdev->is_cdrom) {
+        IPL_assert((boot_mode == ZIPL_BOOT_MODE_NORMAL),
+                   "Secure boot from ISO image is not supported!");
         ipl_iso_el_torito();
         puts("Failed to IPL this ISO image!");
         return;
     }
 
     if (virtio_get_device_type() == VIRTIO_ID_NET) {
+        IPL_assert((boot_mode == ZIPL_BOOT_MODE_NORMAL),
+                    "Virtio net boot device does not support secure boot!");
         netmain();
         puts("Failed to IPL from this network!");
         return;
@@ -1117,6 +1128,9 @@ void zipl_load(void)
         return;
     }
 
+    IPL_assert((boot_mode == ZIPL_BOOT_MODE_NORMAL),
+                "Secure boot with the ECKD scheme is not supported!");
+
     switch (virtio_get_device_type()) {
     case VIRTIO_ID_BLOCK:
         zipl_load_vblk();
diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
index b8f836c682..cd3d0776b0 100644
--- a/pc-bios/s390-ccw/main.c
+++ b/pc-bios/s390-ccw/main.c
@@ -30,6 +30,7 @@ IplParameterBlock *iplb;
 bool have_iplb;
 static uint16_t cutype;
 LowCore *lowcore; /* Yes, this *is* a pointer to address 0 */
+ZiplBootMode boot_mode;
 
 #define LOADPARM_PROMPT "PROMPT  "
 #define LOADPARM_EMPTY  "        "
@@ -303,6 +304,9 @@ static void ipl_ccw_device(void)
     switch (cutype) {
     case CU_TYPE_DASD_3990:
     case CU_TYPE_DASD_2107:
+        IPL_assert((boot_mode == ZIPL_BOOT_MODE_NORMAL),
+                    "Passthrough (vfio) CCW device does not support secure boot!");
+
         dasd_ipl(blk_schid, cutype);
         break;
     case CU_TYPE_VIRTIO:
@@ -390,6 +394,8 @@ void main(void)
         probe_boot_device();
     }
 
+    boot_mode = ZIPL_BOOT_MODE_NORMAL;
+
     while (have_iplb) {
         boot_setup();
         if (have_iplb && find_boot_device()) {
diff --git a/pc-bios/s390-ccw/s390-ccw.h b/pc-bios/s390-ccw/s390-ccw.h
index 1e1f71775e..5420443ad2 100644
--- a/pc-bios/s390-ccw/s390-ccw.h
+++ b/pc-bios/s390-ccw/s390-ccw.h
@@ -69,6 +69,12 @@ int sclp_read(char *str, size_t count);
 /* bootmap.c */
 void zipl_load(void);
 
+typedef enum ZiplBootMode {
+    ZIPL_BOOT_MODE_NORMAL = 0,
+} ZiplBootMode;
+
+extern ZiplBootMode boot_mode;
+
 /* jump2ipl.c */
 void write_reset_psw(uint64_t psw);
 int jump_to_IPL_code(uint64_t address);
-- 
2.54.0


