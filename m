Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C57AC61DC2
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 12:56:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzD7f-0007vy-Kv; Wed, 26 Aug 2026 08:52:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1wzD7c-0007tZ-QC; Wed, 26 Aug 2026 08:52:52 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1wzD7Z-0002m5-EY; Wed, 26 Aug 2026 08:52:52 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67QCVw9A4002747; Wed, 26 Aug 2026 12:52:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=e1sXAYyTQLQ/leqkz
 K9GWXtFnfkXNsBbgEXq2UaguPk=; b=HcJjYZqrY6GcP4HDodfDPhRShHYdED5qf
 ACmRBrqs7uGKS/M/oQOJAmOFu21nDodDf9Ma7TPnWWhysXljypMAMgEHjO/nTsCy
 21fTbNgHwmjOI9OA+4i6TtbULkhHhwIAiWGaOSsRV2mrLL6uJBH0oes6wHHpsdAG
 vELc+N7tiSMQDM+S3hxzX0SxoPIiGgwgSgTn2Z6ih3K4Ozu+YfS9oZLTMEuyfr83
 0z1FS28zV68uiI3n/FBG8k2/fNvG8oiRRgjNV9H9SZ87n4TROWWouJcoA+6AwlO1
 jskY6Q1uIPyAmZfCGqPaqzrlQdqNr2JAkdMvqVtlY8nyYu84bVNUA==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73g4xpeq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Aug 2026 12:52:47 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67QCfHm6006710;
 Wed, 26 Aug 2026 12:52:46 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7pfwa2tu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Aug 2026 12:52:46 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67QCqjGq54722940
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 26 Aug 2026 12:52:45 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 38EA25805E;
 Wed, 26 Aug 2026 12:52:45 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 170E358059;
 Wed, 26 Aug 2026 12:52:44 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com.com (unknown
 [9.61.78.161]) by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 26 Aug 2026 12:52:43 +0000 (GMT)
From: Eric Farman <farman@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Matthew Rosato <mjrosato@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Zhuoying Cai <zycai@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, Collin Walling <walling@linux.ibm.com>,
 Jared Rossi <jrossi@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>
Subject: [PULL 23/37] pc-bios/s390-ccw: Rework zipl_load_segment function
Date: Wed, 26 Aug 2026 08:51:58 -0400
Message-ID: <20260826125213.1901252-24-farman@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260826125213.1901252-1-farman@linux.ibm.com>
References: <20260826125213.1901252-1-farman@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: UJDugn4_1-4UfurLVai7EaYjNnGa5Z3O
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDEwNCBTYWx0ZWRfX649NERo6TMGZ
 EZl3Eq2xPJFx9LjA0d9xcLSINzKUFjozmMCqg/qDalbFHGo6LNG5GN3jT5jZVDR4L1GiIlsWMxf
 hMaohaAMXlb2iv4x+7sfkZSVHhvhIOk=
X-Proofpoint-GUID: UJDugn4_1-4UfurLVai7EaYjNnGa5Z3O
X-Authority-Analysis: v=2.4 cv=JZyMa0KV c=1 sm=1 tr=0 ts=6a8ee19f cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8
 a=uL_FI9FW9AP7juJAwn4A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDEwNCBTYWx0ZWRfX2cdnERQK/0OL
 1JZRHM5mW1uqZXGLdok9VZXuyG7tPh1/5/X0mlN9eiZai6wb25fsFjhci7uPqIcOhquunqnsx3w
 FlTOcBEsk6NDISIEYbVt7hVSGFgX1tuJ/uLkxCD/E9AOmDYx+/d+783+eFcYua6WdidPpSD7eGF
 IW/us0Y23V/4/jQAm46UvANgPzDYWBLEg54xHr1P5LmnF9ki4chQDF8fIC0bThe+d6arHjeUu9C
 y/+AocYC64YXOfR3r7wK3SFvnd8zEUgkWgMmxlryElAE/wuICPWxujMq5PXyGie2Zjmv8RHyhaY
 L+mGwe9JcdF2n0B9xe2OgvXUyVcK0N439pxFzT6tf0Q4tbFXrjKtgv82iiqoCX4CBlvJ70HvAuo
 x+BzByA51hNiuNikxeWc7cerHh3BVT9MhMoFowmRQYrdhRs6r09uj0GAM1Idthuy+K6s82Xy54M
 dpHIl1pZUswJSD7PSIA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_03,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 adultscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260104
Received-SPF: pass client-ip=148.163.156.1; envelope-from=farman@linux.ibm.com;
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

From: Zhuoying Cai <zycai@linux.ibm.com>

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
Link: https://lore.kernel.org/qemu-devel/20260730214624.2328883-22-zycai@linux.ibm.com
Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 pc-bios/s390-ccw/bootmap.c | 14 ++++++--------
 pc-bios/s390-ccw/bootmap.h | 13 +++++++++++++
 2 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/pc-bios/s390-ccw/bootmap.c b/pc-bios/s390-ccw/bootmap.c
index 21c219ca94..38e98aab68 100644
--- a/pc-bios/s390-ccw/bootmap.c
+++ b/pc-bios/s390-ccw/bootmap.c
@@ -615,19 +615,15 @@ static int ipl_eckd(void)
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
@@ -670,10 +666,12 @@ static int zipl_load_segment(ComponentEntry *entry)
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
@@ -689,7 +687,7 @@ static int zipl_run_normal(ComponentEntry **entry_ptr, const uint8_t *tmp_sec)
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


