Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AF9FD3B7ED
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Dec 2025 21:36:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vSiri-0007lT-L1; Mon, 08 Dec 2025 16:33:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1vSirc-0007h6-Hw; Mon, 08 Dec 2025 16:33:49 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1vSirW-0000md-Ig; Mon, 08 Dec 2025 16:33:44 -0500
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5B8DFi4m001504;
 Mon, 8 Dec 2025 21:33:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=aIcWBliuHD29rS09B
 XpaWF67wzhqIhfOikH6E78NIzo=; b=IsxAaBaQSVQ51nNYayQTa08hWM6C9zKM3
 ZMSrFWbYNNSZZfA4jAH5bcwL8nKUogghqOB8ZBqdFlwfels3KbZk+w37eycpgcXo
 Y7RM51+F4JMhrUHGhoSoTwBgIw0UBX1nDydXnX84M+uIJ1m/M9stp1WXF9kT0QG9
 9X/cqzCPYOwngstkhsFjvSH2G1jNWNhQVvZArNBUchSpXgKS9RDSS7AU3y6Kwx1m
 ETuY54uT7+GTk7qu8agXQW2RLzDhsTacVu9vTt7wj3AptyocwMvTM17+oD8W9qvt
 fWUIHajk6GWmpvQ0YWrBWO8bnYnasc016JS5NEqdg03tJjS4DflTA==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4avc7bsuk6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 08 Dec 2025 21:33:40 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5B8Ia02b012902;
 Mon, 8 Dec 2025 21:33:38 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4aw0ajqnpr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 08 Dec 2025 21:33:38 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5B8LXbDE22872828
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 8 Dec 2025 21:33:37 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8D5865805C;
 Mon,  8 Dec 2025 21:33:37 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D514458059;
 Mon,  8 Dec 2025 21:33:35 +0000 (GMT)
Received: from fedora-workstation.ibmuc.com (unknown [9.61.66.246])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  8 Dec 2025 21:33:35 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: thuth@redhat.com, berrange@redhat.com, richard.henderson@linaro.org,
 david@redhat.com, jrossi@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, brueckner@linux.ibm.com
Cc: walling@linux.ibm.com, jjherne@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com, zycai@linux.ibm.com, alifm@linux.ibm.com
Subject: [PATCH v7 25/29] pc-bios/s390-ccw: Handle secure boot with multiple
 boot devices
Date: Mon,  8 Dec 2025 16:32:42 -0500
Message-ID: <20251208213247.702569-26-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251208213247.702569-1-zycai@linux.ibm.com>
References: <20251208213247.702569-1-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: HoIbMpsT5v_pm96O3HTsJrmujlXsNIk1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA2MDAyMCBTYWx0ZWRfX2yNiuPbyUVds
 MBq2kanFlhkCarsB/zmds6PFfdaNcHcKcH6+NffGWbQoRbQerQUIGI5L/U26UUDCK/pvPKg3Hx/
 qpbwmRTu6iqajHmG7pf71tYuQuGODzSnpnmX4MTsjc5KjTDAEOaTI3fl12jR1N9/cwb1/JUHIKq
 hOuX+1uHVt4ALx0qY7oKzY8LibC+btdms7brJd4VEMk/yJ4JgmaOyEKLMm6nBI/cyOxBjNmlISE
 XZJhJRHqJYSZ1ooqOm+YJRqlQTN6ciqVi6gL0oCjrETqU0LkgcEzaxNC1gXnERvlNd5zDLBIzxA
 mIhQhwemaWcAeV5M4pwCpq66uhd8Er83RF7xOCnYLkuEK9Lt31Ba5lR88Fz1tVmTwgAJSuII4W/
 XtM83Wn3ef/HLc81ChacWxr2CQ+HRw==
X-Proofpoint-GUID: HoIbMpsT5v_pm96O3HTsJrmujlXsNIk1
X-Authority-Analysis: v=2.4 cv=FpwIPmrq c=1 sm=1 tr=0 ts=69374434 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=OWglaXZkh0GZWmb_D2oA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-06_02,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 malwarescore=0 phishscore=0 clxscore=1015 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2512060020
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
 pc-bios/s390-ccw/bootmap.c  | 31 +++++++++-------
 pc-bios/s390-ccw/main.c     | 73 ++++++++++++++++++++++++++++++++++---
 pc-bios/s390-ccw/s390-ccw.h |  1 +
 3 files changed, 86 insertions(+), 19 deletions(-)

diff --git a/pc-bios/s390-ccw/bootmap.c b/pc-bios/s390-ccw/bootmap.c
index cc9a8cec6a..e3c12697e0 100644
--- a/pc-bios/s390-ccw/bootmap.c
+++ b/pc-bios/s390-ccw/bootmap.c
@@ -1139,25 +1139,35 @@ ZiplBootMode zipl_mode(uint8_t hdr_flags)
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
@@ -1168,11 +1178,6 @@ void zipl_load(void)
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
index 5cea9d3ac7..7ce4761d34 100644
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
+        panic("Passthrough (vfio) CCW device does not support secure boot!");
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
+    QemuIplParameters qipl_copy;
+
     if (boot_mode == ZIPL_BOOT_MODE_UNSPECIFIED) {
         boot_mode = zipl_mode(iplb->hdr_flags);
     }
@@ -281,14 +316,38 @@ static void ipl_boot_device(void)
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
+
+    memcpy(&qipl_copy, &qipl, sizeof(QemuIplParameters));
+    memcpy(iplb_copy, iplb, sizeof(IplParameterBlock));
+
+    while (have_iplb_copy) {
+        if (have_iplb_copy && find_boot_device()) {
+            validate_secure_boot_device();
+        }
+        have_iplb_copy = load_next_iplb();
+    }
+
+    memcpy(&qipl, &qipl_copy, sizeof(QemuIplParameters));
+    memcpy(iplb, iplb_copy, sizeof(IplParameterBlock));
+
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
-            panic("Passthrough (vfio) CCW device does not support secure boot!");
-        }
-
         dasd_ipl(blk_schid, cutype);
         break;
     case CU_TYPE_VIRTIO:
@@ -338,6 +397,8 @@ void main(void)
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
2.51.1


