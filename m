Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45D07EA854C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 00:36:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzObc-0006KG-UL; Sun, 08 Mar 2026 20:36:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1vzObZ-0006Ik-MN; Sun, 08 Mar 2026 20:36:17 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1vzObY-0001eG-3p; Sun, 08 Mar 2026 20:36:17 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6288fWlR056775; Mon, 9 Mar 2026 00:36:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=BhdJhlYa3DDQsC77r
 SkdST00mb5d/j7+VpRBoa3woZM=; b=F0XxjmdN3ET6u2wTQaEiF5zZ4TTnFatCQ
 l5TT2bVAEltea/N33yRlytpXQ72nfUuoqLZKzeYvLHESgB6m+Uep5X6LlDHXkimy
 PszhD4evexEEr00IIZlA80ep6qMmq69c12i7R1e7ilct/3S0aK/tBly0bCT+ksdF
 2/jHn6Xg7StUFfjqh6B/0G5N7a9AgHr3wcTjgtxmyCHH53PLpATrmMFbA2HBD2Mx
 lsM66jmeaN/Y80M7psARZHArEyMX76D+mVDO7qv0/qwjVgrqxYiNSJktSfoNAHrv
 h+9KuUGDXYZk0dcRdD4/SFeD4j6U8iBmgyDei1tkUQc4cy0rQfzvw==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4crcvr4ema-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Mar 2026 00:36:14 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 628M6D5P023239;
 Mon, 9 Mar 2026 00:36:14 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cryukawex-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Mar 2026 00:36:14 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6290aC5Q64225740
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 9 Mar 2026 00:36:13 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A11D058054;
 Mon,  9 Mar 2026 00:36:12 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8B46C58052;
 Mon,  9 Mar 2026 00:36:11 +0000 (GMT)
Received: from t15.ibmuc.com (unknown [9.61.180.105])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  9 Mar 2026 00:36:11 +0000 (GMT)
From: jrossi@linux.ibm.com
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, thuth@redhat.com,
 mst@redhat.com
Cc: jjherne@linux.ibm.com, alifm@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, jrossi@linux.ibm.com, zycai@linux.ibm.com
Subject: [PATCH v5 04/15] s390x: Remove duplicate definitions of IPL types
Date: Sun,  8 Mar 2026 20:35:50 -0400
Message-ID: <20260309003601.242634-5-jrossi@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260309003601.242634-1-jrossi@linux.ibm.com>
References: <20260309003601.242634-1-jrossi@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDAwMyBTYWx0ZWRfX81X1AbvDxAAb
 MS/0tYEPIPvydroq0DQlkP9CK81ZCuiPehS7XtWNoB8g/7aytcfpcW5mSJAPjUZpxRHlX9pEDSS
 IbiHS2dTdZknaQ5VSNWlxYxITFCMyohHabYPNvVcT21ETBTcgJ62tvEO2vNiCF7BzRAs/LVzvk/
 VH+tVm+5QHgko0wIFD9px7YxX8pwFUGpTyh7RcSLT/+nbPoW5t0c0V0vPVxynNPar4cXLO0bN/3
 TTo7NkqpzYy7iXVuaVo2bpy2Gtu6uHGQptYdFLjoDbq6qTU9SWPgXBUiCzYeP2CuP3yJelXB/CK
 aZJcPfr1cUlBRdfDmMIPm+SMhtpELSa3c55VNiNXlhPzLqKi9xb+HTNBvGqi9GsF9XJznKRD5+k
 PTFCy9OLKkkFmml9f/ZDddeYRGj5D21RkAXdG1OLnO3Y+21L4fsLkhByxctfcHoUyWO4pPZXUun
 CVGWYok3mIDnAoakFEg==
X-Proofpoint-GUID: 2q7tF9r-JU_0ggz-bIU9MrWxfepLIQNE
X-Proofpoint-ORIG-GUID: 2q7tF9r-JU_0ggz-bIU9MrWxfepLIQNE
X-Authority-Analysis: v=2.4 cv=QoFTHFyd c=1 sm=1 tr=0 ts=69ae15fe cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8
 a=IO535qWdJy4Oo3HXDe8A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-08_07,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 priorityscore=1501 phishscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 malwarescore=0 suspectscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2603090003
Received-SPF: pass client-ip=148.163.158.5; envelope-from=jrossi@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Because the IPL type is determined by the IPLB, and because an IPLB is not
strictly necessary, the IPL type is set to a default value if not otherwise
specified.  A default IPL type is required so future functionality may add
IPL new bus and/or device types that dictate specific behavior during IPL.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
---
 hw/s390x/ipl.h              |  5 -----
 include/hw/s390x/ipl/qipl.h | 10 ++++++++++
 pc-bios/s390-ccw/iplb.h     |  4 ----
 pc-bios/s390-ccw/main.c     | 14 ++++++++++----
 pc-bios/s390-ccw/virtio.h   |  1 +
 5 files changed, 21 insertions(+), 13 deletions(-)

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
index 8e2c99bee1..2e9261904f 100644
--- a/pc-bios/s390-ccw/main.c
+++ b/pc-bios/s390-ccw/main.c
@@ -149,7 +149,7 @@ static bool find_subch(int dev_no)
     return false;
 }
 
-static void menu_setup(void)
+static void menu_setup(VDev *vdev)
 {
     if (memcmp(loadparm_str, LOADPARM_PROMPT, LOADPARM_LEN) == 0) {
         menu_set_parms(QIPL_FLAG_BM_OPTS_CMD, 0);
@@ -162,11 +162,13 @@ static void menu_setup(void)
         return;
     }
 
-    switch (iplb.pbt) {
+    switch (vdev->ipl_type) {
     case S390_IPL_TYPE_CCW:
     case S390_IPL_TYPE_QEMU_SCSI:
         menu_set_parms(qipl.qipl_flags & BOOT_MENU_FLAG_MASK,
                        qipl.boot_menu_timeout);
+        /* fall through */
+    default:
         return;
     }
 }
@@ -190,6 +192,7 @@ static void css_setup(void)
 static void boot_setup(void)
 {
     char lpmsg[] = "LOADPARM=[________]\n";
+    VDev *vdev = virtio_get_device();
 
     if (have_iplb && memcmp(iplb.loadparm, NO_LOADPARM, LOADPARM_LEN) != 0) {
         ebcdic_to_ascii((char *) iplb.loadparm, loadparm_str, LOADPARM_LEN);
@@ -198,7 +201,10 @@ static void boot_setup(void)
     }
 
     if (have_iplb) {
-        menu_setup();
+        vdev->ipl_type = iplb.pbt;
+        menu_setup(vdev);
+    } else {
+        vdev->ipl_type = QEMU_DEFAULT_IPL;
     }
 
     memcpy(lpmsg + 10, loadparm_str, 8);
@@ -216,7 +222,7 @@ static bool find_boot_device(void)
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


