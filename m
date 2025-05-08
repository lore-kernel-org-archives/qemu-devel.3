Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04BEAC3ABC5
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 22:55:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDA5v-0004fn-Qo; Thu, 08 May 2025 18:52:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1uDA5p-0004Rw-74; Thu, 08 May 2025 18:51:54 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1uDA5n-0006Xa-I6; Thu, 08 May 2025 18:51:52 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 548L3LjV030270;
 Thu, 8 May 2025 22:51:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=7qwp64xzPHETN8wPH
 HPWNrarFZbMmLyADKKXy+sY43A=; b=F44+6SLbgmFLKGuKBG5aOPmkE87DMcRrG
 20y672P1hiix5l7eUw6gzudSCZR0LHr0IVMUzPZPNJTEWMWf93N91M4W9Qt2xisu
 9sxMNn08LLIzM19HAyw07T4e2un+wV9t7Y6ClOLWaBQ/wUZzHLd/pdmZ5X8H/2tU
 l+7MMrD13AKEM0IMzI5zGQG2qF2uNYMuCcKhnDLGXgdmeQi4sPJSynXtdbWLwDlE
 +gbZRggxQdUcXIXxA34jrcmt3m4t6eVfDPhE0We9whVWMTFlhOb0SnIGi43UXPqP
 9tJt7t6h0Mcgs8XbawazIjUM3MRapL/4/F8UoNgmP1JCVSLjymaUQ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46h46krccx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 08 May 2025 22:51:48 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 548KVZ8b025813;
 Thu, 8 May 2025 22:51:47 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46dwv08888-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 08 May 2025 22:51:47 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 548MpkUc30474856
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 8 May 2025 22:51:46 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3FC3E5805B;
 Thu,  8 May 2025 22:51:46 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CAC155804B;
 Thu,  8 May 2025 22:51:44 +0000 (GMT)
Received: from fedora-workstation.ibmuc.com (unknown [9.61.11.238])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  8 May 2025 22:51:44 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: thuth@redhat.com, richard.henderson@linaro.org, david@redhat.com,
 pbonzini@redhat.com
Cc: walling@linux.ibm.com, jjherne@linux.ibm.com, jrossi@linux.ibm.com,
 fiuczy@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, iii@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, zycai@linux.ibm.com
Subject: [PATCH v2 16/25] pc-bios/s390-ccw: Refactor zipl_load_segment function
Date: Thu,  8 May 2025 18:50:32 -0400
Message-ID: <20250508225042.313672-17-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250508225042.313672-1-zycai@linux.ibm.com>
References: <20250508225042.313672-1-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=LaM86ifi c=1 sm=1 tr=0 ts=681d3585 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=7R-l5uqnDSfc7LOOSFgA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA4MDIwNSBTYWx0ZWRfXxEjzblscHhhK
 BnXyQA4eOwrDOekn/FPO5x4viyymKyqxexO+Q6Gb8/4JiNIFQHidi+IJ0opSpIsHGlxoNvw56GJ
 9zDgFyoRItNfs/HuHb0qYMajcUpSITqXO0kEzDj6oi85MXRPSzI3nMKrO2WBkwfzORuIC/rz4Gr
 PoYll7m5BwuDWMsjsJXrkYcujf6OI6vPvicTiOTe7GixAXXDLilBevY94Xhr5+uCvJjRznmlz2K
 L4vHvRNwrJgZwx4EJaEjKy+qWJZxxjVq7GdlV27pKUGKn88qSpxXquoEyWkP19qRhakEgEt3YjS
 v7B4ZLNePXWIU2u3GUm6ZkNZlePywJlzNj8dzyUGxLl44hvQI8pwNR1MtOvLXqe+QimTle/SOB+
 rfs02oLRWhMkIb9rsx3O/1pKM6HSEhMGb+xf8qcvFqCeAlkaXNTVfM80YVSPT7IcU7Y6sCdT
X-Proofpoint-ORIG-GUID: RF2UCGfMrxU4GwEl3lMuxQ0aRPBc_fkh
X-Proofpoint-GUID: RF2UCGfMrxU4GwEl3lMuxQ0aRPBc_fkh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-08_07,2025-05-08_04,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0
 clxscore=1015 bulkscore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 impostorscore=0 spamscore=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505080205
Received-SPF: pass client-ip=148.163.156.1; envelope-from=zycai@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

Make the address variable a parameter of zipl_load_segment and return
segment length.

Modify this function for reuse in the next patch, which allows
loading segment or signature data to the destination memory address.

Add a comp_len variable to store the length of a segment and return this
variable in zipl_load_segment.

comp_len variable is necessary to store the calculated segment length and
is used during signature verification. Return the length on success, or
a negative return code on failure.

Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
---
 pc-bios/s390-ccw/bootmap.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/pc-bios/s390-ccw/bootmap.c b/pc-bios/s390-ccw/bootmap.c
index 485b55f1bf..3dd09fda7e 100644
--- a/pc-bios/s390-ccw/bootmap.c
+++ b/pc-bios/s390-ccw/bootmap.c
@@ -613,19 +613,18 @@ static int ipl_eckd(void)
  * IPL a SCSI disk
  */
 
-static int zipl_load_segment(ComponentEntry *entry)
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
+    int comp_len = 0;
 
     blockno = entry->data.blockno;
-    address = entry->compdat.load_addr;
 
     debug_print_int("loading segment at block", blockno);
     debug_print_int("addr", address);
@@ -662,6 +661,9 @@ static int zipl_load_segment(ComponentEntry *entry)
                  */
                 break;
             }
+
+            comp_len += (uint64_t)bprs->size * ((uint64_t)bprs[i].blockct + 1);
+
             address = virtio_load_direct(cur_desc[0], cur_desc[1], 0,
                                          (void *)address);
             if (!address) {
@@ -671,7 +673,7 @@ static int zipl_load_segment(ComponentEntry *entry)
         }
     } while (blockno);
 
-    return 0;
+    return comp_len;
 }
 
 static int zipl_run_normal(ComponentEntry *entry, uint8_t *tmp_sec)
@@ -685,7 +687,7 @@ static int zipl_run_normal(ComponentEntry *entry, uint8_t *tmp_sec)
             continue;
         }
 
-        if (zipl_load_segment(entry)) {
+        if (zipl_load_segment(entry, entry->compdat.load_addr) < 0) {
             return -1;
         }
 
-- 
2.49.0


