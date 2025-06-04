Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA64DC5B552
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Jun 2025 22:00:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMw8U-00043j-Fd; Wed, 04 Jun 2025 17:59:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1uMw7j-00033E-1A; Wed, 04 Jun 2025 17:58:19 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1uMw7e-00073V-5h; Wed, 04 Jun 2025 17:58:13 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 554DKaDn019794;
 Wed, 4 Jun 2025 21:58:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=RKPxupbymnxEmCGsn
 6+9H8kDjDd9Ydofc8NZHRSwTts=; b=LorMuf0rDKkm4pN1s6q5C5rr6jKFEKvpk
 0f+6mbJPhpuaL2Shwg8HOEOsSbpQ5YiKxRPvBH9bg4MckAzT5OTL6yyr0x0uDm6u
 ZibK9lIlfwMUZgxYN/tgfbH5rjC2Uhls8GggPr7OQ0/DDhirYcat2eTwJTnHxJAY
 g3pDD75RDxywDEc5eqNPzh4T3GAv8vS0M+eYnXx1AiGXmaZLBQgk5UskvdUMbC48
 0z7me4tDPAnwjN786SlWzocogHYYlYWvmf1KZXVGVRdjoP2E+j6R02XK+cfz5oj+
 xaeaycHgfiMTCbqWCopd0g5CCPahURapan7A8aovDuDHJKrHadWZA==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 472fwums2r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Jun 2025 21:58:06 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 554JIwVc019851;
 Wed, 4 Jun 2025 21:58:05 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 470d3p1ut4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Jun 2025 21:58:05 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 554Lw4vR31261294
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 4 Jun 2025 21:58:04 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8674958050;
 Wed,  4 Jun 2025 21:58:04 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6C82158052;
 Wed,  4 Jun 2025 21:58:02 +0000 (GMT)
Received: from fedora-workstation.ibmuc.com (unknown [9.61.31.211])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  4 Jun 2025 21:58:02 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: thuth@redhat.com, berrange@redhat.com, richard.henderson@linaro.org,
 david@redhat.com, pbonzini@redhat.com
Cc: walling@linux.ibm.com, jjherne@linux.ibm.com, jrossi@linux.ibm.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, farman@linux.ibm.com,
 iii@linux.ibm.com, eblake@redhat.com, armbru@redhat.com,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org, zycai@linux.ibm.com
Subject: [PATCH v3 26/28] pc-bios/s390-ccw: Handle secure boot with multiple
 boot devices
Date: Wed,  4 Jun 2025 17:56:54 -0400
Message-ID: <20250604215657.528142-27-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250604215657.528142-1-zycai@linux.ibm.com>
References: <20250604215657.528142-1-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA0MDE3NSBTYWx0ZWRfX2uVM7ITnzdoy
 iyKLfwLpyzfPxj/1pp4OLTfin/yT0x8UCMPxE+rAXbOos1dlmnbxprTWggkB9TkhV7ytAii8V94
 Yms2Ge2LTCxH5+VrZHZ4LMt2CvwVBioyfOb7AG3Db8R/wqIIRzkQjCkcJbCEIXPivzXTqE+chpu
 h3LfkT/ix+pj04y5spuT1YWIkXemyWQ1c/bP/0HJQnbMnDoXR1mWTUl9SFMRrIfNNAegXyPY+b6
 To80fifYJ72YRyU/A6liYhXMU/5oyBpzuLXdHJYiomZvOBWXBBqC28IF8pB2DbuR/s3uYP+e9Og
 dPjRvMhENptrzjHhsICGUndJqDjFFJICBNO1fRRhuE9SGFtxEzH50YG1NBLRO+E5gntk4SPys/q
 I3cujeWW9OGzmUkyvcbcSg8zG2Ag8THrc0xm9l9NNER7fSWrGOEbeJwpnjRe3ymdO0aAMSil
X-Proofpoint-GUID: Sb_iQ4R1UEYl6d9ENFVGp48R83M9VfEi
X-Proofpoint-ORIG-GUID: Sb_iQ4R1UEYl6d9ENFVGp48R83M9VfEi
X-Authority-Analysis: v=2.4 cv=QtVe3Uyd c=1 sm=1 tr=0 ts=6840c16e cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=6IFa9wvqVegA:10 a=VnNF1IyMAAAA:8 a=OWglaXZkh0GZWmb_D2oA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-04_04,2025-06-03_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 suspectscore=0
 bulkscore=0 adultscore=0 phishscore=0 impostorscore=0 malwarescore=0
 priorityscore=1501 mlxlogscore=999 lowpriorityscore=0 spamscore=0
 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506040175
Received-SPF: pass client-ip=148.163.158.5; envelope-from=zycai@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
index 64abf8164d..053d433073 100644
--- a/pc-bios/s390-ccw/bootmap.c
+++ b/pc-bios/s390-ccw/bootmap.c
@@ -1322,23 +1322,35 @@ ZiplBootMode zipl_mode(uint8_t hdr_flags)
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
@@ -1349,10 +1361,6 @@ void zipl_load(void)
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


