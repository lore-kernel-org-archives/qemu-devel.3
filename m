Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0266EEA84E
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 20:47:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqdYF-0000u1-AB; Thu, 12 Feb 2026 15:44:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1vqdYD-0000sq-Tb; Thu, 12 Feb 2026 15:44:37 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1vqdYC-0007nj-CF; Thu, 12 Feb 2026 15:44:37 -0500
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61C9x5LZ483862; Thu, 12 Feb 2026 20:44:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=zMNphC1yBqjauBkyP
 aKpyyRX7aIz36E8YVyOJ1Xsj0w=; b=pCXVsS5H6Lts18o9pG70bN6bqySAyFN4S
 3WUX85EgC1JsZ/aufyUi0epfqzVvy2f06TfPs9FPsnDdcyU5jW9OMmLoQ9ds7s9Z
 HRS0KshHwyIR+PPC1wzkMQWd64s824XSU2QyCDAU45TgQNNGQrOkx036GWTm2BuN
 VUK5RDadiFrsKNscvzfzY+8pNTqVPQV3HGLuUb9hhxJoGlQkzUNZ4+1AveDMGBM2
 LjgifKZjCYtIm4JGYSv8d/cNBZz9J7ZyvnJoWOw0dvuXl/M3+AKYR7+JpAbQ2Qx6
 BgSpJl/lQkBngzRUpihlSRVbSuYMHjh0wqrQUKLK0+kjc3pbWJrvw==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c696wg4mv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Feb 2026 20:44:32 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61CHn0NF012623;
 Thu, 12 Feb 2026 20:44:31 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4c6h7km154-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Feb 2026 20:44:31 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 61CKiUdn38470326
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 12 Feb 2026 20:44:30 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F331358054;
 Thu, 12 Feb 2026 20:44:29 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 447095804E;
 Thu, 12 Feb 2026 20:44:28 +0000 (GMT)
Received: from fedora-workstation.ibmuc.com (unknown [9.61.112.15])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 12 Feb 2026 20:44:28 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: thuth@redhat.com, berrange@redhat.com, richard.henderson@linaro.org,
 jrossi@linux.ibm.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: david@kernel.org, walling@linux.ibm.com, jjherne@linux.ibm.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com, zycai@linux.ibm.com, alifm@linux.ibm.com,
 brueckner@linux.ibm.com
Subject: [PATCH v8 18/30] pc-bios/s390-ccw: Rework zipl_load_segment function
Date: Thu, 12 Feb 2026 15:43:39 -0500
Message-ID: <20260212204352.1044699-19-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260212204352.1044699-1-zycai@linux.ibm.com>
References: <20260212204352.1044699-1-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=YeCwJgRf c=1 sm=1 tr=0 ts=698e3bb0 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8
 a=wVZWP19Ib8Popp5rDVAA:9
X-Proofpoint-GUID: Obr_NfKCpdUPlW6O4wJlBZwHucvhm4OX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEyMDE1NyBTYWx0ZWRfX51WwH/JhRoDR
 9o+8NRgrL6NqpiGSwaHgfAKKJEiOPgebW7t6O2o/7kgBHADoageoA/m7UiN4yl5uOV+W8C1PNRO
 LaDoridXcSTtLL/UgCkOtARVecFIz4vl06eZZTJeGbAiWXookJwxXlHsBd0mXpPKP0y3r/RCNzQ
 V+2BtmT0IxoMVQYND0X7yKlhwTRmphe7sWtfO1aUG/AKKf9LN/bCdEqFE45Wqcm4SYPjH++LwE4
 ehv9O5jhxUcid4lvdJ++D/nr5E9iAGatPCcCBRwUV6VnKYhjI7oVoLJ/TMtdMAlOVxU4KIXCImr
 5LceB0EJoPDIoy+8oNt69bHUWfIkBL1S1ka7ZKWeEz2VRO9IDw/zxsrfYgj44GO3pMLWOrLD/Jx
 yvRDxFHwfG8WLdyMpzMsCXVWsfWRTKLgB+/FB3bHvr6qzOPqmkKTvGtGap1lIyzpRZEYpKIDdEO
 39q4Bm3MNfcrJGwCLMw==
X-Proofpoint-ORIG-GUID: Obr_NfKCpdUPlW6O4wJlBZwHucvhm4OX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-12_05,2026-02-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 bulkscore=0 malwarescore=0 phishscore=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602120157
Received-SPF: pass client-ip=148.163.156.1; envelope-from=zycai@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Make the address variable a parameter of zipl_load_segment and return
segment length.

Modify this function to allow the caller to specify a memory address
where segment data should be loaded into.

seg_len variable is necessary to store the calculated segment length and
is used during signature verification. Return the length on success, or
a negative return code on failure.

Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 pc-bios/s390-ccw/bootmap.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/pc-bios/s390-ccw/bootmap.c b/pc-bios/s390-ccw/bootmap.c
index 22801ca746..9a03eab6ed 100644
--- a/pc-bios/s390-ccw/bootmap.c
+++ b/pc-bios/s390-ccw/bootmap.c
@@ -613,19 +613,22 @@ static int ipl_eckd(void)
  * IPL a SCSI disk
  */
 
-static int zipl_load_segment(ComponentEntry *entry)
+/*
+ * Returns: length of the segment on success,
+ *          negative value on error.
+ */
+static int zipl_load_segment(ComponentEntry *entry, uint64_t address)
 {
     const int max_entries = (MAX_SECTOR_SIZE / sizeof(ScsiBlockPtr));
     ScsiBlockPtr *bprs = (void *)sec;
     const int bprs_size = sizeof(sec);
     block_number_t blockno;
-    uint64_t address;
     int i;
     char err_msg[] = "zIPL failed to read BPRS at 0xZZZZZZZZZZZZZZZZ";
     char *blk_no = &err_msg[30]; /* where to print blockno in (those ZZs) */
+    int seg_len = 0;
 
     blockno = entry->data.blockno;
-    address = entry->compdat.load_addr;
 
     debug_print_int("loading segment at block", blockno);
     debug_print_int("addr", address);
@@ -668,10 +671,12 @@ static int zipl_load_segment(ComponentEntry *entry)
                 puts("zIPL load segment failed");
                 return -EIO;
             }
+
+            seg_len += bprs->size * (bprs[i].blockct + 1);
         }
     } while (blockno);
 
-    return 0;
+    return seg_len;
 }
 
 static int zipl_run_normal(ComponentEntry **entry_ptr, uint8_t *tmp_sec)
@@ -687,7 +692,7 @@ static int zipl_run_normal(ComponentEntry **entry_ptr, uint8_t *tmp_sec)
             continue;
         }
 
-        if (zipl_load_segment(entry)) {
+        if (zipl_load_segment(entry, entry->compdat.load_addr) < 0) {
             return -1;
         }
 
-- 
2.52.0


