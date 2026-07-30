Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43806C5516D
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2026 21:49:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpYb4-0002ws-1H; Thu, 30 Jul 2026 17:47:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1wpYb2-0002pB-IL; Thu, 30 Jul 2026 17:47:20 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1wpYb0-0002PU-Mc; Thu, 30 Jul 2026 17:47:20 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66UJlxwL3942881; Thu, 30 Jul 2026 21:47:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=E8XTKI+fNmObdf8Ys
 8iYS/LIRD6OhStQr5ax8dMJbrw=; b=OO6Qv27/0sA8dLo4Qnfz+PbYwEzjqxLp0
 DnE9BRrqb7fCa3Fu78BDjZ71AH3ot9l4wtrXshvIRuEKEofnsWE08PJCwyaq6bxC
 UU4W2zgHYQLMtghhY2Mef3ofoF8wqAJ/z1YPm4Og0jBt50SXZeHaR91IP46AkQIE
 6kEXDxBQzFVY4gmagMYfR/wg2FHK2oTix41mSCbh86SIHVrz02ocST2rlsif4YCM
 4y8e3S6foO//NQxDqpiVHHn6OnAMNF6CGYR2toxi4jLRs3E27QJ27IPDNnM4eMRJ
 QX2R+uosQUCVUoEHs/3Ueqj5U8ke3xcLhaB4ylJJuSK6YL04eNh/w==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuw7t258-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 30 Jul 2026 21:47:14 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66ULfWJt002695;
 Thu, 30 Jul 2026 21:47:13 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8yhn6tr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 30 Jul 2026 21:47:13 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66ULlCEr11338298
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 30 Jul 2026 21:47:12 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 39C3E58061;
 Thu, 30 Jul 2026 21:47:12 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 589D35805D;
 Thu, 30 Jul 2026 21:47:10 +0000 (GMT)
Received: from fedora-workstation.ibmuc.com (unknown [9.61.77.192])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 30 Jul 2026 21:47:10 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: jrossi@linux.ibm.com, cohuck@redhat.com, berrange@redhat.com,
 richard.henderson@linaro.org, david@kernel.org, walling@linux.ibm.com,
 jjherne@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, mjrosato@linux.ibm.com, iii@linux.ibm.com,
 eblake@redhat.com, armbru@redhat.com, zycai@linux.ibm.com,
 alifm@linux.ibm.com, brueckner@linux.ibm.com,
 pierrick.bouvier@oss.qualcomm.com, jdaley@linux.ibm.com
Subject: [PATCH v17 21/34] pc-bios/s390-ccw: Rework zipl_load_segment function
Date: Thu, 30 Jul 2026 17:46:10 -0400
Message-ID: <20260730214624.2328883-22-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260730214624.2328883-1-zycai@linux.ibm.com>
References: <20260730214624.2328883-1-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: YmH3pL_PA49cV8ItqLOuJ4aURjCs1F3q
X-Proofpoint-ORIG-GUID: YmH3pL_PA49cV8ItqLOuJ4aURjCs1F3q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDE1NCBTYWx0ZWRfXy8hcVPl8iWXH
 g1V3/m+06/qeE9bQjCJLeHQKMqsqDp57jleY+of8JKrtVvc17t5aP8yvbab1NXBVbAzmXlgefcz
 NeQRKumk4IMKhC2U6GFM0TAjC5h90Nyb7M7IMPwcnAC8zcngwAE+AlbXhV56U7As3hN1YOUMx1j
 ajIsEKzn+qIAD1do3FCcKI5Rh37xCDowAEedrPozl1npP/0dQFDdtCEjptt4jTYutplk8E/xSrp
 6tCuXI801g9y4UR6UfgX52kCMSHuskAwASvveeVq/XVte2yl9/I3GZyOYtZYlBLZKfcdQMyxueA
 ZgrPSuT+i2HQUrhZBF0G8QBcmYRQ2c4ObJ5POABCC7vj2NpZW/D18CKYmNnqW7r/fZXU5brueth
 ZwNHG2EUkc3hVnjN2+0viQq4oHqPq9V2Xa0vLY9J770chOXRNXKU6sqdfNsmzwpASc2YpHif26P
 Bxz7pZ2ILH5HVrsFJww==
X-Authority-Analysis: v=2.4 cv=SKFykuvH c=1 sm=1 tr=0 ts=6a6bc663 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8
 a=uL_FI9FW9AP7juJAwn4A:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDE1NCBTYWx0ZWRfX9/GXRcAlczpf
 JBw/kdAN3JI9/Cp9cBXMp7PgADotE8smWhBXI1pHJaD25jygfGL9GzgM1YSJYhwGKh9hRB5Xkv3
 QGk7mfssg7olNzydO6jiNu/GrRrU2Y4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_06,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607300154
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

Change zipl_load_segment() to accept explicit blockno and address
parameters instead of ComponentEntry pointer and return segment length.

Modify this function to allow the caller to specify a memory address
where segment data should be loaded into.

seg_len variable is necessary to store the calculated segment length and
is used during signature verification. Return the length on success, or
a negative return code on failure.

Remove static qualifier and add function declaration to bootmap.h to
make it accessible to other modules.

Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Collin Walling <walling@linux.ibm.com>
Reviewed-by: Jared Rossi <jrossi@linux.ibm.com>
---
 pc-bios/s390-ccw/bootmap.c | 14 ++++++--------
 pc-bios/s390-ccw/bootmap.h | 13 +++++++++++++
 2 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/pc-bios/s390-ccw/bootmap.c b/pc-bios/s390-ccw/bootmap.c
index 2cf5c9eee3..4dab0fd15c 100644
--- a/pc-bios/s390-ccw/bootmap.c
+++ b/pc-bios/s390-ccw/bootmap.c
@@ -613,19 +613,15 @@ static int ipl_eckd(void)
  * IPL a SCSI disk
  */
 
-static int zipl_load_segment(ComponentEntry *entry)
+int zipl_load_segment(block_number_t blockno, uint64_t address)
 {
     const int max_entries = (MAX_SECTOR_SIZE / sizeof(ScsiBlockPtr));
     ScsiBlockPtr *bprs = (void *)sec;
     const int bprs_size = sizeof(sec);
-    block_number_t blockno;
-    uint64_t address;
     int i;
     char err_msg[] = "zIPL failed to read BPRS at 0xZZZZZZZZZZZZZZZZ";
     char *blk_no = &err_msg[30]; /* where to print blockno in (those ZZs) */
-
-    blockno = entry->data.blockno;
-    address = entry->compdat.load_addr;
+    int seg_len = 0;
 
     debug_print_int("loading segment at block", blockno);
     debug_print_int("addr", address);
@@ -668,10 +664,12 @@ static int zipl_load_segment(ComponentEntry *entry)
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
 
 static int zipl_run_normal(ComponentEntry **entry_ptr, const uint8_t *tmp_sec)
@@ -687,7 +685,7 @@ static int zipl_run_normal(ComponentEntry **entry_ptr, const uint8_t *tmp_sec)
             continue;
         }
 
-        if (zipl_load_segment(entry)) {
+        if (zipl_load_segment(entry->data.blockno, entry->compdat.load_addr) < 0) {
             return -1;
         }
 
diff --git a/pc-bios/s390-ccw/bootmap.h b/pc-bios/s390-ccw/bootmap.h
index 95943441d3..40580600b5 100644
--- a/pc-bios/s390-ccw/bootmap.h
+++ b/pc-bios/s390-ccw/bootmap.h
@@ -113,6 +113,19 @@ typedef struct ScsiMbr {
     ScsiBlockPtr pt;   /* block pointer to program table */
 } __attribute__ ((packed)) ScsiMbr;
 
+/**
+ * zipl_load_segment
+ * @blockno: block number of the first BPRS describing the segment.
+ * @address: guest physical address at which to load the segment.
+ *
+ * Walks the BPRS chain starting at @blockno, loading each data block
+ * into guest memory at @address.
+ *
+ * Returns: length of the segment on success,
+ *          negative value on error.
+ */
+int zipl_load_segment(block_number_t blockno, uint64_t address);
+
 #define ZIPL_MAGIC              "zIPL"
 #define ZIPL_MAGIC_EBCDIC       "\xa9\xc9\xd7\xd3"
 #define IPL1_MAGIC "\xc9\xd7\xd3\xf1" /* == "IPL1" in EBCDIC */
-- 
2.55.0


