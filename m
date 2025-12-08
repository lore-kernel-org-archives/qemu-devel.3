Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC013D3B7EA
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Dec 2025 21:36:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vSis1-0008Bv-8W; Mon, 08 Dec 2025 16:34:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1vSirg-0007jz-Mq; Mon, 08 Dec 2025 16:33:53 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1vSirc-0000kR-I0; Mon, 08 Dec 2025 16:33:51 -0500
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5B8HbWqA021630;
 Mon, 8 Dec 2025 21:33:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=ZGtUQz3u27Tl6WiRg
 oUc5gzosfSK1k0Qda/ebvgo2vQ=; b=jcim+3jxHN0lA+7Q6FLIk3tfjwDUOXwwX
 /bBNl2ZMhIZ2eH0miqHC8jmP5/k0NB+UmoYvrmozEQRPnKTk5e1M+473ls33BouO
 q9P30uUeLGbZtp16Ck9FjjGNuLQjXVUwNHh8hblw6+8Jv3SHccs3Lc3Zb4x/2V9u
 DunwNNGT02nzXLPpexBn+VZOHQO7D1sq2B3MWwPr53jjVY0t94JDuiCVJmEPCK2r
 7OOtJDjSnYQV0mkB9rQL4jAIwheStiRL79ybWZ4VYvyJZsiR+SBH19sLALMQvnPs
 CueM9OoN/MIJFMX+RlOJOelPmPLWD7bBnQ3yTWRMjjNppA0UJTTHw==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4av9wvhmn8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 08 Dec 2025 21:33:26 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5B8JdMnj026807;
 Mon, 8 Dec 2025 21:33:26 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4aw1h0yf94-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 08 Dec 2025 21:33:26 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5B8LXOq723069212
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 8 Dec 2025 21:33:24 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 56AAE58059;
 Mon,  8 Dec 2025 21:33:24 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9E97358058;
 Mon,  8 Dec 2025 21:33:22 +0000 (GMT)
Received: from fedora-workstation.ibmuc.com (unknown [9.61.66.246])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  8 Dec 2025 21:33:22 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: thuth@redhat.com, berrange@redhat.com, richard.henderson@linaro.org,
 david@redhat.com, jrossi@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, brueckner@linux.ibm.com
Cc: walling@linux.ibm.com, jjherne@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com, zycai@linux.ibm.com, alifm@linux.ibm.com
Subject: [PATCH v7 18/29] pc-bios/s390-ccw: Rework zipl_load_segment function
Date: Mon,  8 Dec 2025 16:32:35 -0500
Message-ID: <20251208213247.702569-19-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251208213247.702569-1-zycai@linux.ibm.com>
References: <20251208213247.702569-1-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Shcy37rL3ITTK2N_Zj4CR0miXa2zokO7
X-Proofpoint-ORIG-GUID: Shcy37rL3ITTK2N_Zj4CR0miXa2zokO7
X-Authority-Analysis: v=2.4 cv=AdS83nXG c=1 sm=1 tr=0 ts=69374427 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8
 a=wVZWP19Ib8Popp5rDVAA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA2MDAwMCBTYWx0ZWRfX+uHqMYlr4s3g
 mwWooGWvPYXvWXfCqvn1Z9h2xEFOh/xNAzLYXAR/Ol8xOU8KG+TtHr4zEmDk17DocM0FIu+ykoI
 IxyG7bjNy2NJy1QRZO/7E8bHK0wPMEK7AbniF07+0sTgOrCkvCz0PzPoN+HWx4jBVPNLtWQ0JGq
 26fGfzVYnKIFOpskrk1D12kEvHlIoMFaNnZtYz/facuoglMhDPqBMeqMOPiR/oEqY3iZ6kKXkUf
 OBySYGJwz7aYJ+1vDl/4Ywqyb202K+S8ZaLI3jCruloSVRpe4Q0k92Zr/b3YK74Nbg5b/d01q26
 FZeWZqAq/BodvR1fnO9JwLvBv+6XrYB9h0lywMiAyf+g87AD7DvS/xpc26XWvj8JIRPEuHhpSYx
 8kFGsYWdzCV8hDLkbNrX63fjbksplA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-06_02,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 priorityscore=1501 spamscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2512060000
Received-SPF: pass client-ip=148.163.158.5; envelope-from=zycai@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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
2.51.1


