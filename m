Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05D29C43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 02:31:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfTfk-0000K3-Oj; Thu, 02 Jul 2026 22:30:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1wfTfi-0000IH-H7; Thu, 02 Jul 2026 22:30:30 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1wfTfg-0003cX-OC; Thu, 02 Jul 2026 22:30:30 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6631IOml1318156; Fri, 3 Jul 2026 02:30:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=HoF4pYzGVvg9oyphW
 PPU2z5OIuNIfJkuFYbF4tR8TA4=; b=dSzM4P6IPhdnHhK6/YGk1zuLlaMP2nsN0
 ANeyo/7xfq85j7ntZjx6Q+AyPQdiUpBZYN4GASAZ/rQpS07y3pXD0/mJe/xnfPmA
 VOKmWaCb4BbIyjbvWpCEV3+/GdlSh9crCe3Q2IciA+Nu3c6Ke7fjBmWg3pgdAnVE
 Xol6ph0toJUb3RzHYccbeo+X9ST6BbIFJBopDu2fAfqdN/m0/rEelEvRA/iAdOOo
 6lFhT+wsh+wzosAYguwWQn6AUZ9FHQOS57RcTz0bn9Wh6N1NCBIi5ONi4qxzXQQO
 j/fKVR9H77fXywVhxrBqYdSgXbPBx4ZrDKom6JqKkOYYLmOVAOc6Q==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26ped1u2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 03 Jul 2026 02:30:25 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6632Jc4B019072;
 Fri, 3 Jul 2026 02:30:24 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f2uhyph5k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 03 Jul 2026 02:30:24 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6632UNM243319644
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 3 Jul 2026 02:30:23 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4BC185805E;
 Fri,  3 Jul 2026 02:30:23 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4C48258056;
 Fri,  3 Jul 2026 02:30:21 +0000 (GMT)
Received: from fedora-workstation.lan (unknown [9.61.151.121])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  3 Jul 2026 02:30:21 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: jrossi@linux.ibm.com, cohuck@redhat.com, berrange@redhat.com,
 richard.henderson@linaro.org, david@kernel.org, walling@linux.ibm.com,
 jjherne@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, mjrosato@linux.ibm.com, iii@linux.ibm.com,
 eblake@redhat.com, armbru@redhat.com, zycai@linux.ibm.com,
 alifm@linux.ibm.com, brueckner@linux.ibm.com,
 pierrick.bouvier@oss.qualcomm.com, jdaley@linux.ibm.com
Subject: [PATCH v13 21/33] pc-bios/s390-ccw: Rework zipl_load_segment function
Date: Thu,  2 Jul 2026 22:29:19 -0400
Message-ID: <20260703022933.1805010-22-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260703022933.1805010-1-zycai@linux.ibm.com>
References: <20260703022933.1805010-1-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 8sl71eDYCC6F1BkITZe7GjZw4A3OKzu7
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDAyMCBTYWx0ZWRfX6EvUnch2Z+kR
 Mczm7j5jJjDBXvDE1NDsc0KRV7jiV+lgUQZK+GAeBLWb4HmtdHMT/fnpvmMSHHnBefS8TRhrq4o
 h8VONyimJ/pIVOrWyq3gUMu13gFIeBI=
X-Authority-Analysis: v=2.4 cv=edsNubEH c=1 sm=1 tr=0 ts=6a471ec1 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8
 a=uL_FI9FW9AP7juJAwn4A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDAyMCBTYWx0ZWRfX3Bk3/qM8Sdzx
 9PMD0wH71R2T2rCvumypt4WO05ah41JgwLVLmGFB5OISq/nlcumXgr6RV6YUbvdyVCIP9gSmv82
 lNRi7MWs1zmZXNAaYhmFhlHgGJL03b09o67ANw7jt9TWbQQOsFKcPXw4d/Ak4Jbkm5XLdfPDoM1
 As9jr4OBOaiCtIg6ljiLSQZufbfkuavZ5FIYXJk3Eqes9tJYgS44XRfvU54R2yoaUzUXTx0jkHe
 7sf8r/mN38XuCC2ns8od87h6c7+1P2mdPepebrYGF50IDXK55juh4ZCqyNnE4LF8se2z70M7AG7
 7gb6cnKndJ5nh+7XUivjHAZIw++lKadMrV96OOjaPlDki1sCk3mFfvcZvJXBdn/Pbt+YrzS1nAx
 lkdTo/iR0PiHXht/MliIgVDVT3d71A8HimtIstMD5m7VTcYq/6Pmw9wSsvI5GgTzMCciVQ1+aS/
 7cBIsJPFMNi9Hwosqpg==
X-Proofpoint-ORIG-GUID: 8sl71eDYCC6F1BkITZe7GjZw4A3OKzu7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 adultscore=0 impostorscore=0 bulkscore=0
 spamscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030020
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
 pc-bios/s390-ccw/bootmap.c | 18 ++++++++++--------
 pc-bios/s390-ccw/bootmap.h |  2 ++
 2 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/pc-bios/s390-ccw/bootmap.c b/pc-bios/s390-ccw/bootmap.c
index b9ba004cfc..b19981feb1 100644
--- a/pc-bios/s390-ccw/bootmap.c
+++ b/pc-bios/s390-ccw/bootmap.c
@@ -613,19 +613,19 @@ static int ipl_eckd(void)
  * IPL a SCSI disk
  */
 
-static int zipl_load_segment(ComponentEntry *entry)
+/*
+ * Returns: length of the segment on success,
+ *          negative value on error.
+ */
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
@@ -668,10 +668,12 @@ static int zipl_load_segment(ComponentEntry *entry)
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
@@ -687,7 +689,7 @@ static int zipl_run_normal(ComponentEntry **entry_ptr, uint8_t *tmp_sec)
             continue;
         }
 
-        if (zipl_load_segment(entry)) {
+        if (zipl_load_segment(entry->data.blockno, entry->compdat.load_addr) < 0) {
             return -1;
         }
 
diff --git a/pc-bios/s390-ccw/bootmap.h b/pc-bios/s390-ccw/bootmap.h
index 95943441d3..8d61ac383c 100644
--- a/pc-bios/s390-ccw/bootmap.h
+++ b/pc-bios/s390-ccw/bootmap.h
@@ -113,6 +113,8 @@ typedef struct ScsiMbr {
     ScsiBlockPtr pt;   /* block pointer to program table */
 } __attribute__ ((packed)) ScsiMbr;
 
+int zipl_load_segment(block_number_t blockno, uint64_t address);
+
 #define ZIPL_MAGIC              "zIPL"
 #define ZIPL_MAGIC_EBCDIC       "\xa9\xc9\xd7\xd3"
 #define IPL1_MAGIC "\xc9\xd7\xd3\xf1" /* == "IPL1" in EBCDIC */
-- 
2.54.0


