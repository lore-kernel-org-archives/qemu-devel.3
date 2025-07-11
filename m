Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A9DDC83F1A
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 21:18:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaL2O-00010Z-Vx; Fri, 11 Jul 2025 17:12:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1uaL2G-0000sO-LK; Fri, 11 Jul 2025 17:12:00 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1uaL2E-00033K-Ii; Fri, 11 Jul 2025 17:12:00 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56BGD0qw031955;
 Fri, 11 Jul 2025 21:11:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=badmWIDvNZ0CgJWq6
 OnkkKFdMeWnFY3otH34/m924sc=; b=AbuiZz3MOcsP2OMSDgyyjnHwbU2Ca1CsE
 ADT5fP+EkniqCAHwfBlmIFkulsCiQ410wsmUON7kB8W550JRb47gU5DnVQMcOHhH
 jHnrIkjItnqHgjzbwU+eSTBBDXSG17psnL7JW5U6pNN3xwegn7VYt9706HItEl16
 owvYp8ramuKzc4fu8MExZVVz+O+kyumTD9D52tSlGP9X8yLD50siTp4+xiH5TGn4
 MaZj1L+zTRFq67+ygKW6U6QyM0hxY4+kkcEXd/VvMXumqmFL0TFPreUz8Snn5nLZ
 BFS0Hb5KLjKjPAjE8u+uJvbAfeF4VffVrP3yurtI/Ay1qQO+R6xcw==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47u5x819rf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 11 Jul 2025 21:11:55 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56BJkiIL002847;
 Fri, 11 Jul 2025 21:11:54 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47qfvmvee8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 11 Jul 2025 21:11:54 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 56BLBrKI25625146
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 11 Jul 2025 21:11:53 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 143B158059;
 Fri, 11 Jul 2025 21:11:53 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9597958060;
 Fri, 11 Jul 2025 21:11:51 +0000 (GMT)
Received: from fedora-workstation.ibmuc.com (unknown [9.61.25.251])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 11 Jul 2025 21:11:51 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: thuth@redhat.com, berrange@redhat.com, richard.henderson@linaro.org,
 david@redhat.com, pbonzini@redhat.com, jrossi@linux.ibm.com,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: walling@linux.ibm.com, jjherne@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, zycai@linux.ibm.com
Subject: [PATCH v4 26/28] pc-bios/s390-ccw: Handle secure boot with multiple
 boot devices
Date: Fri, 11 Jul 2025 17:11:02 -0400
Message-ID: <20250711211105.439554-27-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250711211105.439554-1-zycai@linux.ibm.com>
References: <20250711211105.439554-1-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=LfI86ifi c=1 sm=1 tr=0 ts=68717e1c cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Wb1JkmetP80A:10 a=VnNF1IyMAAAA:8 a=OWglaXZkh0GZWmb_D2oA:9
X-Proofpoint-GUID: xwHlqoiArRDxUKw8Wgk4zz7uyvHQ1v6O
X-Proofpoint-ORIG-GUID: xwHlqoiArRDxUKw8Wgk4zz7uyvHQ1v6O
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzExMDE1NiBTYWx0ZWRfX3XJIEUtBJ0ps
 ZnqdFyqaU8nLp3GiMPnZUFi/DD6/chYtBpEHXk1MOueKky9v8PPD3NPtlbdRj53CZCpFEYm8/CQ
 uSGw5fdTPPP78KmoJHlXH1hUTu1qu0ud0WPiXHZ99LGZyoOTwacsOxZcPU9Hg0pSgPGMFu5Gbcr
 faqrTBW7TdtPN0VpGVWkI3eviOLWYjrNPDknBGw+JEjzK5n97YUtkEUib4676b8+h1Fd8h0zUBY
 Z9lyW8ekyveK1NCh3UVkSDaFAQrMjZ7D1B9zoVEO+gJakK5P21/1KqntYpkJ8Q8Q9X51JG1Lyio
 hEu118ZLrcHDeo4gVWpKtpVyx7zPSY6HHL/mj0VGHbsNoSxMfNHWnLb3DfMgeCYksBDJWQcOL+W
 vexfFsQJoxw5odbRBnqIVKWLUvJ9helFd60gxWlYzs5rCLJgHYUAaqJveh+uwV3dEfi4YWM5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_06,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 clxscore=1015
 mlxlogscore=999 malwarescore=0 lowpriorityscore=0 spamscore=0
 impostorscore=0 bulkscore=0 adultscore=0 phishscore=0 suspectscore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507110156
Received-SPF: pass client-ip=148.163.156.1; envelope-from=zycai@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

The current approach to enabling secure boot relies on providing
-secure-boot and -boot-certificates options, which apply to all boot
devices.

With the possibility of multiple boot devices, secure boot expects all
provided devices to be supported and eligible (e.g.,
virtio-blk/virtio-scsi using the SCSI scheme).

If multiple boot devices are provided and include an unsupported (e.g.,
ECKD, VFIO) or a non-eligible (e.g., Net) device, the boot process will
terminate with an error logged to the console.

Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
---
 pc-bios/s390-ccw/bootmap.c  | 28 +++++++++-----
 pc-bios/s390-ccw/main.c     | 74 ++++++++++++++++++++++++++++++++++---
 pc-bios/s390-ccw/s390-ccw.h |  1 +
 3 files changed, 88 insertions(+), 15 deletions(-)

diff --git a/pc-bios/s390-ccw/bootmap.c b/pc-bios/s390-ccw/bootmap.c
index b2a0fb2201..da4318313e 100644
--- a/pc-bios/s390-ccw/bootmap.c
+++ b/pc-bios/s390-ccw/bootmap.c
@@ -1301,23 +1301,35 @@ ZiplBootMode zipl_mode(uint8_t hdr_flags)
     return ZIPL_NORMAL_MODE;
 }
 
+int zipl_check_scsi_mbr_magic(void)
+{
+    ScsiMbr *mbr = (void *)sec;
+
+    /* Grab the MBR */
+    memset(sec, FREE_SPACE_FILLER, sizeof(sec));
+    if (virtio_read(0, mbr)) {
+        puts("Cannot read block 0");
+        return -EIO;
+    }
+
+    if (!magic_match(mbr->magic, ZIPL_MAGIC)) {
+        return -1;
+    }
+
+    return 0;
+}
+
 void zipl_load(void)
 {
     VDev *vdev = virtio_get_device();
 
     if (vdev->is_cdrom) {
-        if (boot_mode == ZIPL_SECURE_AUDIT_MODE || boot_mode == ZIPL_SECURE_MODE) {
-            panic("Secure boot from ISO image is not supported!");
-        }
         ipl_iso_el_torito();
         puts("Failed to IPL this ISO image!");
         return;
     }
 
     if (virtio_get_device_type() == VIRTIO_ID_NET) {
-        if (boot_mode == ZIPL_SECURE_AUDIT_MODE || boot_mode == ZIPL_SECURE_MODE) {
-            panic("Virtio net boot device does not support secure boot!");
-        }
         netmain();
         puts("Failed to IPL from this network!");
         return;
@@ -1328,10 +1340,6 @@ void zipl_load(void)
         return;
     }
 
-    if (boot_mode == ZIPL_SECURE_AUDIT_MODE || boot_mode == ZIPL_SECURE_MODE) {
-        panic("ECKD boot device does not support secure boot!");
-    }
-
     switch (virtio_get_device_type()) {
     case VIRTIO_ID_BLOCK:
         zipl_load_vblk();
diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
index 3e17550854..ffb87e264b 100644
--- a/pc-bios/s390-ccw/main.c
+++ b/pc-bios/s390-ccw/main.c
@@ -271,8 +271,43 @@ static int virtio_setup(void)
     return ret;
 }
 
-static void ipl_boot_device(void)
+static void validate_secure_boot_device(void)
+{
+    switch (cutype) {
+    case CU_TYPE_DASD_3990:
+    case CU_TYPE_DASD_2107:
+        panic("Passthrough (vfio) device does not support secure boot!");
+        break;
+    case CU_TYPE_VIRTIO:
+        if (virtio_setup() == 0) {
+            VDev *vdev = virtio_get_device();
+
+            if (vdev->is_cdrom) {
+                panic("Secure boot from ISO image is not supported!");
+            }
+
+            if (virtio_get_device_type() == VIRTIO_ID_NET) {
+                panic("Virtio net boot device does not support secure boot!");
+            }
+
+            if (zipl_check_scsi_mbr_magic()) {
+                panic("ECKD boot device does not support secure boot!");
+            }
+        }
+        break;
+    default:
+        panic("Secure boot from unexpected device type is not supported!");
+    }
+
+    printf("SCSI boot device supports secure boot.\n");
+}
+
+static void check_secure_boot_support(void)
 {
+    bool have_iplb_copy;
+    IplParameterBlock *iplb_copy;
+    QemuIplParameters *qipl_copy;
+
     if (boot_mode == 0) {
         boot_mode = zipl_mode(iplb->hdr_flags);
     }
@@ -281,13 +316,40 @@ static void ipl_boot_device(void)
         panic("Need at least one certificate for secure boot!");
     }
 
+    if (boot_mode == ZIPL_NORMAL_MODE) {
+        return;
+    }
+
+    /*
+     * Store copies of have_iplb, iplb and qipl.
+     * They will be updated in load_next_iplb().
+     */
+    have_iplb_copy = have_iplb;
+    iplb_copy = malloc(sizeof(IplParameterBlock));
+    qipl_copy = malloc(sizeof(QemuIplParameters));
+
+    memcpy(qipl_copy, &qipl, sizeof(QemuIplParameters));
+    memcpy(iplb_copy, iplb, sizeof(IplParameterBlock));
+
+    while (have_iplb_copy) {
+        if (have_iplb_copy && find_boot_device()) {
+            validate_secure_boot_device();
+        }
+        have_iplb_copy = load_next_iplb();
+    }
+
+    memcpy(&qipl, qipl_copy, sizeof(QemuIplParameters));
+    memcpy(iplb, iplb_copy, sizeof(IplParameterBlock));
+
+    free(qipl_copy);
+    free(iplb_copy);
+}
+
+static void ipl_boot_device(void)
+{
     switch (cutype) {
     case CU_TYPE_DASD_3990:
     case CU_TYPE_DASD_2107:
-        if (boot_mode == ZIPL_SECURE_AUDIT_MODE || boot_mode == ZIPL_SECURE_MODE) {
-            panic("Passthrough (vfio) device does not support secure boot!");
-        }
-
         dasd_ipl(blk_schid, cutype);
         break;
     case CU_TYPE_VIRTIO:
@@ -337,6 +399,8 @@ void main(void)
         probe_boot_device();
     }
 
+    check_secure_boot_support();
+
     while (have_iplb) {
         boot_setup();
         if (have_iplb && find_boot_device()) {
diff --git a/pc-bios/s390-ccw/s390-ccw.h b/pc-bios/s390-ccw/s390-ccw.h
index bf20efe88e..a26233afac 100644
--- a/pc-bios/s390-ccw/s390-ccw.h
+++ b/pc-bios/s390-ccw/s390-ccw.h
@@ -92,6 +92,7 @@ typedef enum ZiplBootMode {
 extern ZiplBootMode boot_mode;
 
 ZiplBootMode zipl_mode(uint8_t hdr_flags);
+int zipl_check_scsi_mbr_magic(void);
 
 /* jump2ipl.c */
 void write_reset_psw(uint64_t psw);
-- 
2.49.0


