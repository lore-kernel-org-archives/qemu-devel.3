Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84BC6CAC59A
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Sep 2025 23:23:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uz1Tl-0005nD-Ow; Wed, 17 Sep 2025 19:22:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1uz1TV-0005bV-IJ; Wed, 17 Sep 2025 19:22:11 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1uz1TT-0002Tl-H9; Wed, 17 Sep 2025 19:22:09 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58HJE3pj027583;
 Wed, 17 Sep 2025 23:22:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=4x+WT6lb7CEAsIr3q
 iRPURO1S0J07qNcICn0EVTg6Kk=; b=G0ssJL0L5+XrlKTAk1Izf+uF540Wk8MMA
 7hrcPxOsV/OzKNJj+9BgqeQFW3UDLrGcbxHExl3VGeLGX3ryA3yzoqqJfNH16hm3
 scvv2X2DnpBfXROqo9J/ljxKtKDpp76Nni/zoXtyNLQLVvatZlbxWAUZ00f7wUco
 8pVdt5S1NXQxxzymNHhYlLvLGi51jgKiKyNnu+YVk3Ou2J/6Q2KC1RIlB3rP4QzN
 cqv4lMjfFEx09x9ZQ/99jMiQPsdZLCL6+E6WcnI/Sk73HT/H4SRqXxgvekz8C0ub
 Xrs1wrR6FwQo4+YBLWDjK5JymYUEMX4TZGvdujynfO0KA9sf+iELA==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 497g4p6v0v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 17 Sep 2025 23:22:04 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58HKtYo2022347;
 Wed, 17 Sep 2025 23:22:03 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 495kxpuu8h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 17 Sep 2025 23:22:03 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 58HNM2J926411650
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 17 Sep 2025 23:22:02 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 63EF958065;
 Wed, 17 Sep 2025 23:22:02 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5B4435805A;
 Wed, 17 Sep 2025 23:22:01 +0000 (GMT)
Received: from fedora-workstation.ibmuc.com (unknown [9.61.34.172])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 17 Sep 2025 23:22:01 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: thuth@redhat.com, berrange@redhat.com, richard.henderson@linaro.org,
 david@redhat.com, jrossi@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Cc: walling@linux.ibm.com, jjherne@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com, zycai@linux.ibm.com, alifm@linux.ibm.com
Subject: [PATCH v6 25/28] pc-bios/s390-ccw: Handle secure boot with multiple
 boot devices
Date: Wed, 17 Sep 2025 19:21:27 -0400
Message-ID: <20250917232131.495848-26-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250917232131.495848-1-zycai@linux.ibm.com>
References: <20250917232131.495848-1-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwNCBTYWx0ZWRfXzQ+e/Zf8OZwp
 5ufVK0A5oVoApmB8G0P6HSlhVgWwK5Q1OUg2OsU5iiqSmSPZaTMsVLinVnwEUzUwR63J6T3jszw
 yl24IXTTg/5elFT4GyJTHbFU1E0pHqpXhyK+Of5bymyTg+pVYOTzDfoPMBXNdiHlQiEFJH1g8JD
 HSKDFH4vdMZ/6kM6l4mwI88Ciubyq8yM6Fre9tQMnIjWNimNjoHkLvMkBdyy9cBRsLTXbB+7BEk
 wiwJ1B4vRsmL/kr6iyRK2mVqhz8BsHsUxtYkjLQQVtIZggiTDD43w8PMLawqXWsDJ1kcpuwHVG0
 +J+4+hWC6mVvRO5k6PNCkwIyPat2Gq+CSaktU1sh/dY/XzGiKqAQadJfNkoI4wPWnxIDygfZMrQ
 TTB6uvOb
X-Proofpoint-ORIG-GUID: W8u5ptRXRgNMbgupT0f3VKImvXMatmje
X-Proofpoint-GUID: W8u5ptRXRgNMbgupT0f3VKImvXMatmje
X-Authority-Analysis: v=2.4 cv=cNzgskeN c=1 sm=1 tr=0 ts=68cb429d cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=OWglaXZkh0GZWmb_D2oA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 spamscore=0 bulkscore=0 malwarescore=0
 adultscore=0 priorityscore=1501 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509160204
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
 pc-bios/s390-ccw/bootmap.c  | 31 ++++++++-------
 pc-bios/s390-ccw/main.c     | 75 ++++++++++++++++++++++++++++++++++---
 pc-bios/s390-ccw/s390-ccw.h |  1 +
 3 files changed, 88 insertions(+), 19 deletions(-)

diff --git a/pc-bios/s390-ccw/bootmap.c b/pc-bios/s390-ccw/bootmap.c
index 3ab89b91fb..8297f22c3c 100644
--- a/pc-bios/s390-ccw/bootmap.c
+++ b/pc-bios/s390-ccw/bootmap.c
@@ -1136,25 +1136,35 @@ ZiplBootMode zipl_mode(uint8_t hdr_flags)
     return ZIPL_BOOT_MODE_NORMAL;
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
-        if (boot_mode == ZIPL_BOOT_MODE_SECURE_AUDIT ||
-            boot_mode == ZIPL_BOOT_MODE_SECURE) {
-            panic("Secure boot from ISO image is not supported!");
-        }
         ipl_iso_el_torito();
         puts("Failed to IPL this ISO image!");
         return;
     }
 
     if (virtio_get_device_type() == VIRTIO_ID_NET) {
-        if (boot_mode == ZIPL_BOOT_MODE_SECURE_AUDIT ||
-            boot_mode == ZIPL_BOOT_MODE_SECURE) {
-            panic("Virtio net boot device does not support secure boot!");
-        }
         netmain();
         puts("Failed to IPL from this network!");
         return;
@@ -1165,11 +1175,6 @@ void zipl_load(void)
         return;
     }
 
-    if (boot_mode == ZIPL_BOOT_MODE_SECURE_AUDIT ||
-        boot_mode == ZIPL_BOOT_MODE_SECURE) {
-        panic("ECKD boot device does not support secure boot!");
-    }
-
     switch (virtio_get_device_type()) {
     case VIRTIO_ID_BLOCK:
         zipl_load_vblk();
diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
index c5b425209a..228b52a37e 100644
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
     if (boot_mode == ZIPL_BOOT_MODE_UNSPECIFIED) {
         boot_mode = zipl_mode(iplb->hdr_flags);
     }
@@ -281,14 +316,40 @@ static void ipl_boot_device(void)
         panic("Need at least one certificate for secure boot!");
     }
 
+    if (boot_mode == ZIPL_BOOT_MODE_NORMAL) {
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
-        if (boot_mode == ZIPL_BOOT_MODE_SECURE_AUDIT ||
-            boot_mode == ZIPL_BOOT_MODE_SECURE) {
-            panic("Passthrough (vfio) device does not support secure boot!");
-        }
-
         dasd_ipl(blk_schid, cutype);
         break;
     case CU_TYPE_VIRTIO:
@@ -338,6 +399,8 @@ void main(void)
         probe_boot_device();
     }
 
+    check_secure_boot_support();
+
     while (have_iplb) {
         boot_setup();
         if (have_iplb && find_boot_device()) {
diff --git a/pc-bios/s390-ccw/s390-ccw.h b/pc-bios/s390-ccw/s390-ccw.h
index 389cc8ea7c..3009104686 100644
--- a/pc-bios/s390-ccw/s390-ccw.h
+++ b/pc-bios/s390-ccw/s390-ccw.h
@@ -93,6 +93,7 @@ typedef enum ZiplBootMode {
 extern ZiplBootMode boot_mode;
 
 ZiplBootMode zipl_mode(uint8_t hdr_flags);
+int zipl_check_scsi_mbr_magic(void);
 
 /* jump2ipl.c */
 void write_reset_psw(uint64_t psw);
-- 
2.50.1


