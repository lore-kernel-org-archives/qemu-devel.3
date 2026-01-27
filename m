Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1789D340A1
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 16:19:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vklkH-00041H-S6; Tue, 27 Jan 2026 11:16:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1vklja-0003YY-CL; Tue, 27 Jan 2026 11:16:08 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1vkljX-0000kH-Hb; Tue, 27 Jan 2026 11:16:06 -0500
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60R6m8Un025155;
 Tue, 27 Jan 2026 16:16:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=Rf/LyNJCD2ilTQUbJ
 RdaZXl8SGPKTZ2iPBiK+L4xuSY=; b=Aun0i1+1Bk042IFitJtToyLjlpbjyKFlZ
 WAOY9fMXkRrA0NnjYP0UO+G5Si24WoJ8YEWKdd0GliriuH53jbAAZxpvYMG0jwYL
 XW/O+RdTo4hkR8fiKfig6SZUTr38/71BUMaK0XRKuUqhW+2z2kkXToEiC2R+nDfI
 GJjVXDvpDeMKAwR1r0odP2cF5X5LLam1ZQgaGm5v8Z4TWo0j6+F6kGMggvHeJOZc
 LwMaAJizDQq30ULFt9KSPDYJ88Ewlb4bgIBWUf3uWXzAEVxxe0Pn5FLqrJUh/YEf
 TlP9L8drMVweqz+Q35GhLBoz09AtaQPXaxf3yszQfeT/lyFuNOh5Q==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bvkgmmv46-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 27 Jan 2026 16:16:00 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60RE3P2D019666;
 Tue, 27 Jan 2026 16:15:59 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4bw9dn1b40-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 27 Jan 2026 16:15:59 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 60RGFwjR6816518
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 27 Jan 2026 16:15:58 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 53DF35805C;
 Tue, 27 Jan 2026 16:15:58 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 371DE5805D;
 Tue, 27 Jan 2026 16:15:57 +0000 (GMT)
Received: from t15.ibmuc.com (unknown [9.61.94.134])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 27 Jan 2026 16:15:57 +0000 (GMT)
From: jrossi@linux.ibm.com
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, thuth@redhat.com,
 mst@redhat.com
Cc: jjherne@linux.ibm.com, alifm@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, jrossi@linux.ibm.com, zycai@linux.ibm.com
Subject: [PATCH v3 03/14] s390x: Remove duplicate definitions of IPL types
Date: Tue, 27 Jan 2026 11:15:36 -0500
Message-ID: <20260127161547.459443-4-jrossi@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260127161547.459443-1-jrossi@linux.ibm.com>
References: <20260127161547.459443-1-jrossi@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Gr1PO01C c=1 sm=1 tr=0 ts=6978e4c0 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=zWWk5AeEZ3i7y8Hvs5sA:9
X-Proofpoint-GUID: x7XPyjKGyAnbLxSoADre3vasK5qlU67o
X-Proofpoint-ORIG-GUID: x7XPyjKGyAnbLxSoADre3vasK5qlU67o
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDEyOSBTYWx0ZWRfX/JHrAXOA8xnI
 iUw9RKKLb/k6eY/AcqkEpKPLUj2zj8Umbs8FxBo4Z8tWQTJ4m+hUa1hqe3J0Fl50SWc/FbbHOCB
 BEKlUnNCixHekDTwN9rm6uj43y6PrJt7zvb0XuwlkIKmG2p+yvGkcQ0s/BNg7v/eZbUmMoOBO25
 qhh3lwNydRUKKL0ccJ34DNPpgq4/7aNvUwPN/+Q1kILbjJc9jxiUFQCFNgbiE/siH+crTziiIeq
 uFi6X6efgsTN66Vhlv5pNq5JaHEwD1GjyEuNlDoM0TqiJTk+uH3ZvSy5RcmOQjQr9a3THh20iO2
 myMfhn6NZ28AdrH7at9OT8f+gQBwH3iyiJsE/HF39ghcngYVShQizKf/sBnSKzHmDm0Qd5tuxVH
 5N+qz11lPjpdvcyk+uHaF6eS15bQrLjtln2GPkiD9NjVkue3iJUlxdR0zeV4/Mma8hn6LYXCIKv
 WPCbeRiOfYG0hJvrx2g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_03,2026-01-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 lowpriorityscore=0 suspectscore=0
 impostorscore=0 phishscore=0 malwarescore=0 adultscore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2601150000
 definitions=main-2601270129
Received-SPF: pass client-ip=148.163.158.5; envelope-from=jrossi@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Jared Rossi <jrossi@linux.ibm.com>

Remove the duplicate definitions from hw/s390x/ipl.h and pc-bios/s390-ccw/iplb.h
and add a shared definition.  The new definition is an enum to enforce default
handling in switches.

Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
---
 hw/s390x/ipl.h              |  5 -----
 include/hw/s390x/ipl/qipl.h | 10 ++++++++++
 pc-bios/s390-ccw/iplb.h     |  4 ----
 pc-bios/s390-ccw/main.c     |  9 +++++++--
 pc-bios/s390-ccw/virtio.h   |  1 +
 5 files changed, 18 insertions(+), 11 deletions(-)

diff --git a/hw/s390x/ipl.h b/hw/s390x/ipl.h
index 086e57681c..c542d30ce2 100644
--- a/hw/s390x/ipl.h
+++ b/hw/s390x/ipl.h
@@ -103,11 +103,6 @@ QEMU_BUILD_BUG_MSG(offsetof(S390IPLState, iplb) & 3, "alignment of iplb wrong");
 #define DIAG308_PV_STORE            9
 #define DIAG308_PV_START            10
 
-#define S390_IPL_TYPE_FCP 0x00
-#define S390_IPL_TYPE_CCW 0x02
-#define S390_IPL_TYPE_PV 0x05
-#define S390_IPL_TYPE_QEMU_SCSI 0xff
-
 #define S390_IPLB_HEADER_LEN 8
 #define S390_IPLB_MIN_PV_LEN 148
 #define S390_IPLB_MIN_CCW_LEN 200
diff --git a/include/hw/s390x/ipl/qipl.h b/include/hw/s390x/ipl/qipl.h
index 6824391111..6dc12dd859 100644
--- a/include/hw/s390x/ipl/qipl.h
+++ b/include/hw/s390x/ipl/qipl.h
@@ -20,6 +20,16 @@
 #define LOADPARM_LEN    8
 #define NO_LOADPARM "\0\0\0\0\0\0\0\0"
 
+enum S390IplType {
+    S390_IPL_TYPE_FCP = 0x00,
+    S390_IPL_TYPE_CCW = 0x02,
+    S390_IPL_TYPE_PV = 0x05,
+    S390_IPL_TYPE_QEMU_SCSI = 0xff
+};
+typedef enum S390IplType S390IplType;
+
+#define QEMU_DEFAULT_IPL S390_IPL_TYPE_CCW
+
 /*
  * The QEMU IPL Parameters will be stored at absolute address
  * 204 (0xcc) which means it is 32-bit word aligned but not
diff --git a/pc-bios/s390-ccw/iplb.h b/pc-bios/s390-ccw/iplb.h
index 08f259ff31..926e8eed5d 100644
--- a/pc-bios/s390-ccw/iplb.h
+++ b/pc-bios/s390-ccw/iplb.h
@@ -23,10 +23,6 @@ extern QemuIplParameters qipl;
 extern IplParameterBlock iplb __attribute__((__aligned__(PAGE_SIZE)));
 extern bool have_iplb;
 
-#define S390_IPL_TYPE_FCP 0x00
-#define S390_IPL_TYPE_CCW 0x02
-#define S390_IPL_TYPE_QEMU_SCSI 0xff
-
 static inline bool manage_iplb(IplParameterBlock *iplb, bool store)
 {
     register unsigned long addr asm("0") = (unsigned long) iplb;
diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
index 76bf743900..0446d5de67 100644
--- a/pc-bios/s390-ccw/main.c
+++ b/pc-bios/s390-ccw/main.c
@@ -162,11 +162,12 @@ static void menu_setup(void)
         return;
     }
 
-    switch (iplb.pbt) {
+    switch (virtio_get_device()->ipl_type) {
     case S390_IPL_TYPE_CCW:
     case S390_IPL_TYPE_QEMU_SCSI:
         menu_set_parms(qipl.qipl_flags & BOOT_MENU_FLAG_MASK,
                        qipl.boot_menu_timeout);
+    default:
         return;
     }
 }
@@ -190,6 +191,7 @@ static void css_setup(void)
 static void boot_setup(void)
 {
     char lpmsg[] = "LOADPARM=[________]\n";
+    VDev *vdev = virtio_get_device();
 
     if (have_iplb && memcmp(iplb.loadparm, NO_LOADPARM, LOADPARM_LEN) != 0) {
         ebcdic_to_ascii((char *) iplb.loadparm, loadparm_str, LOADPARM_LEN);
@@ -198,7 +200,10 @@ static void boot_setup(void)
     }
 
     if (have_iplb) {
+        vdev->ipl_type = iplb.pbt;
         menu_setup();
+    } else {
+        vdev->ipl_type = QEMU_DEFAULT_IPL;
     }
 
     memcpy(lpmsg + 10, loadparm_str, 8);
@@ -216,7 +221,7 @@ static bool find_boot_device(void)
     VDev *vdev = virtio_get_device();
     bool found = false;
 
-    switch (iplb.pbt) {
+    switch (vdev->ipl_type) {
     case S390_IPL_TYPE_CCW:
         vdev->scsi_device_selected = false;
         debug_print_int("device no. ", iplb.ccw.devno);
diff --git a/pc-bios/s390-ccw/virtio.h b/pc-bios/s390-ccw/virtio.h
index 06ba4e45ac..391d6ff2f7 100644
--- a/pc-bios/s390-ccw/virtio.h
+++ b/pc-bios/s390-ccw/virtio.h
@@ -238,6 +238,7 @@ struct VDev {
     VirtioGDN guessed_disk_nature;
     SubChannelId schid;
     SenseId senseid;
+    S390IplType ipl_type;
     union {
         VirtioBlkConfig blk;
         VirtioScsiConfig scsi;
-- 
2.52.0


