Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4A62C25B7E
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 15:44:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCLSd-0005nV-TJ; Wed, 29 May 2024 11:43:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1sCLSc-0005m9-6U; Wed, 29 May 2024 11:43:30 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1sCLSZ-0006xg-5s; Wed, 29 May 2024 11:43:29 -0400
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 44TFg8xo007021; Wed, 29 May 2024 15:43:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc :
 content-transfer-encoding : date : from : in-reply-to : message-id :
 mime-version : references : subject : to; s=pp1;
 bh=DNSDR6Ip26VL8YTQlpGoygzmm3raGtx5zokLcxWbUBE=;
 b=UFWC6lANkwnhKhpuDWQxjwbKgR3jSzOaNUgDDxlWR6EVNLMrZ9Ow5CfVI2KPpAMO4oTO
 ORJ5UY9lLqVLlB8bociWKSyyUwT5jT1I0SErVaxKnugJASEbKw66PoLL5v2cK71b3LUQ
 HDZVyldSkOjFIuCn6ag9qX/+/3w/8EK0E91uSDHlJLM6h+cd0orjHfjjDtpgVTzTeo+L
 AF1txVC4vu/2T7U27QN5AZpchsbbi/udCX1LmYYud96dLTHdZP9AkStV154wGAUek3J5
 aRZkvRd4blMG6PwNXFfEIkwrGnhJZRSwQAa/3CY+xEfVD9aAbUHJ7uk7yEy/sIAvmPh4 lw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ye77y0035-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 29 May 2024 15:43:25 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44TFhOX9008945;
 Wed, 29 May 2024 15:43:24 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ye77y0030-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 29 May 2024 15:43:24 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 44TEv0vX029003; Wed, 29 May 2024 15:43:23 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3ydpaymjjr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 29 May 2024 15:43:23 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 44TFhKkG24052366
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 29 May 2024 15:43:22 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4CBB858063;
 Wed, 29 May 2024 15:43:20 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D38285806F;
 Wed, 29 May 2024 15:43:19 +0000 (GMT)
Received: from t15.ibmuc.com (unknown [9.67.55.69])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 29 May 2024 15:43:19 +0000 (GMT)
From: jrossi@linux.ibm.com
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, thuth@redhat.com
Cc: frankja@linux.ibm.com, nsg@linux.ibm.com, jrossi@linux.ibm.com
Subject: [PATCH 4/5] s390x: Add boot device fallback infrastructure
Date: Wed, 29 May 2024 11:43:10 -0400
Message-Id: <20240529154311.734548-5-jrossi@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240529154311.734548-1-jrossi@linux.ibm.com>
References: <20240529154311.734548-1-jrossi@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Z3-QaJW7xSDMjbETZbrsV8NLVaIUkRKl
X-Proofpoint-ORIG-GUID: WkrOM3rDAwPfV4ZRPrS_zcCJcvQzd_pb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-29_12,2024-05-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0
 impostorscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0 adultscore=0
 mlxscore=0 priorityscore=1501 mlxlogscore=999 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405290108
Received-SPF: pass client-ip=148.163.156.1; envelope-from=jrossi@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Jared Rossi <jrossi@linux.ibm.com>

Add a routine for loading the next IPLB if a device fails to boot.

This includes some minor changes to the List-Directed IPL routine so that the
failing device may be retried using the legacy boot pointers before moving on to
the next device.

Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
---
 pc-bios/s390-ccw/bootmap.h |  5 +++++
 pc-bios/s390-ccw/iplb.h    | 24 ++++++++++++++++++++++
 pc-bios/s390-ccw/bootmap.c | 41 ++++++++++++++++++++++++++------------
 pc-bios/s390-ccw/main.c    | 15 +++++++++-----
 pc-bios/s390-ccw/netmain.c |  4 ++++
 5 files changed, 71 insertions(+), 18 deletions(-)

diff --git a/pc-bios/s390-ccw/bootmap.h b/pc-bios/s390-ccw/bootmap.h
index d4690a88c2..d5061ed6c8 100644
--- a/pc-bios/s390-ccw/bootmap.h
+++ b/pc-bios/s390-ccw/bootmap.h
@@ -366,6 +366,11 @@ static inline void read_block(block_number_t blockno,
     IPL_assert(virtio_read(blockno, buffer) == 0, errmsg);
 }
 
+static inline bool read_block_nonfatal(block_number_t blockno, void *buffer)
+{
+    return (virtio_read(blockno, buffer) == 0);
+}
+
 static inline bool block_size_ok(uint32_t block_size)
 {
     return block_size == virtio_get_block_size();
diff --git a/pc-bios/s390-ccw/iplb.h b/pc-bios/s390-ccw/iplb.h
index 16643f5879..3c29d23375 100644
--- a/pc-bios/s390-ccw/iplb.h
+++ b/pc-bios/s390-ccw/iplb.h
@@ -49,4 +49,28 @@ static inline bool set_iplb(IplParameterBlock *iplb)
     return manage_iplb(iplb, false);
 }
 
+/*
+ * The IPL started on the device, but failed in some way.  If the IPLB chain
+ * still has more devices left to try, use the next device in order. Set the
+ * next IPLB and save the current qipl parameters state.
+ */
+static inline bool load_next_iplb(void)
+{
+    IplParameterBlock *next_iplb;
+
+    if (qipl.num_iplbs < 1) {
+        return false;
+    }
+
+    next_iplb = (IplParameterBlock *) qipl.next_iplb;
+    memcpy(&iplb, next_iplb, sizeof(IplParameterBlock));
+    set_iplb(&iplb);
+
+    qipl.num_iplbs--;
+    qipl.next_iplb = qipl.next_iplb + sizeof(IplParameterBlock);
+    memcpy((QemuIplParameters *)QIPL_ADDRESS, &qipl, sizeof(QemuIplParameters));
+
+    return true;
+}
+
 #endif /* IPLB_H */
diff --git a/pc-bios/s390-ccw/bootmap.c b/pc-bios/s390-ccw/bootmap.c
index a2137449dc..69391557fa 100644
--- a/pc-bios/s390-ccw/bootmap.c
+++ b/pc-bios/s390-ccw/bootmap.c
@@ -144,7 +144,10 @@ static block_number_t load_eckd_segments(block_number_t blk, bool ldipl,
     bool more_data;
 
     memset(_bprs, FREE_SPACE_FILLER, sizeof(_bprs));
-    read_block(blk, bprs, "BPRS read failed");
+    if (!read_block_nonfatal(blk, bprs)) {
+        IPL_assert(ldipl, "BPRS read failed");
+        return -1;
+    }
 
     do {
         more_data = false;
@@ -188,7 +191,10 @@ static block_number_t load_eckd_segments(block_number_t blk, bool ldipl,
                  * I.e. the next ptr must point to the unused memory area
                  */
                 memset(_bprs, FREE_SPACE_FILLER, sizeof(_bprs));
-                read_block(block_nr, bprs, "BPRS continuation read failed");
+                if (!read_block_nonfatal(block_nr, bprs)) {
+                    IPL_assert(ldipl, "BPRS continuation read failed");
+                    break;
+                }
                 more_data = true;
                 break;
             }
@@ -197,7 +203,10 @@ static block_number_t load_eckd_segments(block_number_t blk, bool ldipl,
              * to memory (address).
              */
             rc = virtio_read_many(block_nr, (void *)(*address), count + 1);
-            IPL_assert(rc == 0, "code chunk read failed");
+            if (rc != 0) {
+                IPL_assert(ldipl, "code chunk read failed");
+                break;
+            }
 
             *address += (count + 1) * virtio_get_block_size();
         }
@@ -295,13 +304,22 @@ static void run_eckd_boot_script(block_number_t bmt_block_nr,
                " maximum number of boot entries allowed");
 
     memset(sec, FREE_SPACE_FILLER, sizeof(sec));
-    read_block(bmt_block_nr, sec, "Cannot read Boot Map Table");
+    if (!read_block_nonfatal(bmt_block_nr, sec)) {
+        IPL_assert(ldipl, "Cannot read Boot Map Table");
+        return;
+    }
 
     block_nr = gen_eckd_block_num(&bmt->entry[loadparm].xeckd, ldipl);
-    IPL_assert(block_nr != -1, "Cannot find Boot Map Table Entry");
+    if (block_nr == -1) {
+        IPL_assert(ldipl, "Cannot find Boot Map Table Entry");
+        return;
+    }
 
     memset(sec, FREE_SPACE_FILLER, sizeof(sec));
-    read_block(block_nr, sec, "Cannot read Boot Map Script");
+    if (!read_block_nonfatal(block_nr, sec)) {
+        IPL_assert(ldipl, "Cannot read Boot Map Script");
+        return;
+    }
 
     for (i = 0; bms->entry[i].type == BOOT_SCRIPT_LOAD ||
                 bms->entry[i].type == BOOT_SCRIPT_SIGNATURE; i++) {
@@ -319,13 +337,10 @@ static void run_eckd_boot_script(block_number_t bmt_block_nr,
         } while (block_nr != -1);
     }
 
-    if (ldipl && bms->entry[i].type != BOOT_SCRIPT_EXEC) {
-        /* Abort LD-IPL and retry as CCW-IPL */
+    if (bms->entry[i].type != BOOT_SCRIPT_EXEC) {
+        IPL_assert(ldipl, "Unknown script entry type");
         return;
     }
-
-    IPL_assert(bms->entry[i].type == BOOT_SCRIPT_EXEC,
-               "Unknown script entry type");
     write_reset_psw(bms->entry[i].address.load_address); /* no return */
     jump_to_IPL_code(0); /* no return */
 }
@@ -492,7 +507,7 @@ static void ipl_eckd(void)
             /* LD-IPL does not use the S1B bock, just make it NULL */
             run_eckd_boot_script(ldipl_bmt, NULL_BLOCK_NR);
             /* Only return in error, retry as CCW-IPL */
-            sclp_print("Retrying IPL ");
+            sclp_print("LD-IPL failed, retrying device\n");
             print_eckd_msg();
         }
         memset(sec, FREE_SPACE_FILLER, sizeof(sec));
@@ -944,5 +959,5 @@ void zipl_load(void)
         panic("\n! Unknown IPL device type !\n");
     }
 
-    sclp_print("zIPL load failed.\n");
+    panic("zIPL load failed.\n");
 }
diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
index 3e51d698d7..248ed5a410 100644
--- a/pc-bios/s390-ccw/main.c
+++ b/pc-bios/s390-ccw/main.c
@@ -53,6 +53,12 @@ unsigned int get_loadparm_index(void)
     return atoui(loadparm_str);
 }
 
+static void copy_qipl(void)
+{
+    QemuIplParameters *early_qipl = (QemuIplParameters *)QIPL_ADDRESS;
+    memcpy(&qipl, early_qipl, sizeof(QemuIplParameters));
+}
+
 static int is_dev_possibly_bootable(int dev_no, int sch_no)
 {
     bool is_virtio;
@@ -194,7 +200,7 @@ static void boot_setup(void)
 static void find_boot_device(void)
 {
     VDev *vdev = virtio_get_device();
-    bool found;
+    bool found = false;
 
     switch (iplb.pbt) {
     case S390_IPL_TYPE_CCW:
@@ -221,11 +227,8 @@ static void find_boot_device(void)
 static int virtio_setup(void)
 {
     VDev *vdev = virtio_get_device();
-    QemuIplParameters *early_qipl = (QemuIplParameters *)QIPL_ADDRESS;
     int ret;
 
-    memcpy(&qipl, early_qipl, sizeof(QemuIplParameters));
-
     if (have_iplb) {
         menu_setup();
     }
@@ -242,7 +245,8 @@ static int virtio_setup(void)
         ret = virtio_scsi_setup_device(blk_schid);
         break;
     default:
-        panic("\n! No IPL device available !\n");
+        ret = 1;
+        panic("Unrecognized virtio device type!\n");
     }
 
     if (!ret) {
@@ -296,6 +300,7 @@ static void probe_boot_device(void)
 
 void main(void)
 {
+    copy_qipl();
     sclp_setup();
     css_setup();
     boot_setup();
diff --git a/pc-bios/s390-ccw/netmain.c b/pc-bios/s390-ccw/netmain.c
index 5cd619b2d6..65cee15fef 100644
--- a/pc-bios/s390-ccw/netmain.c
+++ b/pc-bios/s390-ccw/netmain.c
@@ -36,6 +36,7 @@
 #include "cio.h"
 #include "virtio.h"
 #include "s390-time.h"
+#include "iplb.h"
 
 #define DEFAULT_BOOT_RETRIES 10
 #define DEFAULT_TFTP_RETRIES 20
@@ -51,6 +52,7 @@ void write_iplb_location(void) {}
 #define STSI322_VMDB_UUID_OFFSET ((8 + 12) * 4)
 
 IplParameterBlock iplb __attribute__((aligned(PAGE_SIZE)));
+QemuIplParameters qipl;
 static char cfgbuf[2048];
 
 static SubChannelId net_schid = { .one = 1 };
@@ -513,6 +515,8 @@ void main(void)
 {
     filename_ip_t fn_ip;
     int rc, fnlen;
+    QemuIplParameters *early_qipl = (QemuIplParameters *)QIPL_ADDRESS;
+    memcpy(&qipl, early_qipl, sizeof(QemuIplParameters));
 
     sclp_setup();
     sclp_print("Network boot starting...\n");
-- 
2.45.1


