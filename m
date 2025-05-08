Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5F21C3ABC9
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 22:52:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDA67-00058c-4z; Thu, 08 May 2025 18:52:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1uDA64-0004zS-FO; Thu, 08 May 2025 18:52:08 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1uDA62-0006eL-Bu; Thu, 08 May 2025 18:52:07 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 548KDjWb011721;
 Thu, 8 May 2025 22:52:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=3FOFgdjRp7kya3N1W
 NxexhxVEjbh7gDOZYMMOb6TLyQ=; b=jJi20tBptmMUqw9RSfqiJaI2uez2y/2nP
 x6C/mZ9ZscjMf7dKecCZrq7nB995vgIM1hwrj4Qrl9ScX6aghKTPhvHPKUgQ7Vxr
 F74GFE8XJrOb+E33tQrlzH5roPAZSI2P7qa3K7wLmgEg+LtL1YPR1azziAv7kqyx
 Ztc+NkE269GbWQXUu86E6TpBOYATdhrzaymLUGFeMCx1+7BA8b+ECN84IkEL68yI
 MAIiGyBokBnl8q6e3CfquSJjXRU6d/z/nEossA94nLNHMMPMV+vogNcsfdFRRlJ/
 Yo3DiUXU5CIWMA1pY3/+1hSzKw9Pb3jmDuo9jA4xsbWrqex2RB1Tw==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46gu2t3av0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 08 May 2025 22:52:04 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 548MZGr4014137;
 Thu, 8 May 2025 22:52:03 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 46dypkyuyx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 08 May 2025 22:52:03 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 548Mq2L129360856
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 8 May 2025 22:52:02 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4CFAE58055;
 Thu,  8 May 2025 22:52:02 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D3A0B5804B;
 Thu,  8 May 2025 22:52:00 +0000 (GMT)
Received: from fedora-workstation.ibmuc.com (unknown [9.61.11.238])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  8 May 2025 22:52:00 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: thuth@redhat.com, richard.henderson@linaro.org, david@redhat.com,
 pbonzini@redhat.com
Cc: walling@linux.ibm.com, jjherne@linux.ibm.com, jrossi@linux.ibm.com,
 fiuczy@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, iii@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, zycai@linux.ibm.com
Subject: [PATCH v2 23/25] pc-bios/s390-ccw: Handle secure boot with multiple
 boot devices
Date: Thu,  8 May 2025 18:50:39 -0400
Message-ID: <20250508225042.313672-24-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250508225042.313672-1-zycai@linux.ibm.com>
References: <20250508225042.313672-1-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=NLnV+16g c=1 sm=1 tr=0 ts=681d3594 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=OWglaXZkh0GZWmb_D2oA:9
X-Proofpoint-ORIG-GUID: pqS1QwN0wOsePKmbLQSH_PilABWZQwqh
X-Proofpoint-GUID: pqS1QwN0wOsePKmbLQSH_PilABWZQwqh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA4MDIwNSBTYWx0ZWRfX32Lxd/OwX+li
 cH/SVmz3QQsUP7m5Qh7SOvvgBPn/zS4UzA/hMIyI2TcfgdO0JfT3H6cUAUGf8ZgTsG6LSh23e6T
 nXpeKCrPtT45tL4vLryFPb+DCF4tm51JJr+He28vlQLqu/01GGV5dem4wzRCnkbRVQCBJKMv3HJ
 Wj4NyzlwbjSSVwINNJ1cYdvh0wrI9EpLL7mEX/SmmbvM/VSwoSsnC8c0d/ARFN2is6/r9CrrDj0
 OVy0uaaUsJXteBMjC45Hx7PDi1RrB29t8L7lPoiUUDDlyt+cfkCwHKM6OvvRlNwkUTBzbd0TjL2
 ZvowITJSMd7KCbWBObQi79Hnj35YrKHPVh6UCq0P7c4kpOwV3rHN5k4YSxXcqYR+ciTwmpWJo3q
 rfb3DmmmLpi0bs5epvlYmVUaAutvma5x1xGAGZSUResYN2lhEkMw6ojZHnj2R5PsN1B39SUr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-08_07,2025-05-08_04,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0
 mlxlogscore=999 phishscore=0 mlxscore=0 impostorscore=0 clxscore=1015
 lowpriorityscore=0 spamscore=0 malwarescore=0 priorityscore=1501
 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
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
index 395d52c65c..bff9c75c49 100644
--- a/pc-bios/s390-ccw/bootmap.c
+++ b/pc-bios/s390-ccw/bootmap.c
@@ -1323,23 +1323,35 @@ ZiplBootMode zipl_mode(uint8_t hdr_flags)
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
@@ -1350,10 +1362,6 @@ void zipl_load(void)
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


