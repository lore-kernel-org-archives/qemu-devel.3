Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82896C5B549
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Jun 2025 21:59:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMw88-0003Ys-I3; Wed, 04 Jun 2025 17:58:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1uMw7T-0002rZ-0Z; Wed, 04 Jun 2025 17:58:01 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1uMw7M-000726-UC; Wed, 04 Jun 2025 17:57:54 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 554DXchd032383;
 Wed, 4 Jun 2025 21:57:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=IW/6sFvnXmMIBU7ET
 pFsg6RdgUmjWVojWCAbcWLG5yI=; b=sCdxhGCMwE2r0OxriUbWkqTQ/wcjsfr5u
 wOUWJx4HGMYDqiR3pWfFXxJ12QZGhjFJ6JSPaii4hO+MSrvtRQBIvvP8lcOp/nvY
 wz5yvZatlpNHgbddZMz2cF3Gk7/xyfC1FIuurNZb0U34GusTvwVjZewI2LU6+vm2
 eAG0dQHLWmMyj4KIQz9EGW1OgKx8qbtW8/Q1D4zlFrJtgOLK2Sb3eLERPQb4uhGE
 fTpNBPr8uXZWWv7hHg/byFJMboRBWjkssupxQxHDdCoU9wH/gX5OOJjBxw6jalcP
 NwfgoQRlhzzG2YCb7tC7CAABV64MwJiFsajmv6PIRK8ZGUKR+/DeQ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 471geyw6kt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Jun 2025 21:57:51 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 554JU20b022517;
 Wed, 4 Jun 2025 21:57:50 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 470c3tj1ru-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Jun 2025 21:57:50 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 554LvmvR26411496
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 4 Jun 2025 21:57:48 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AEDFD58054;
 Wed,  4 Jun 2025 21:57:48 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3DFA058045;
 Wed,  4 Jun 2025 21:57:46 +0000 (GMT)
Received: from fedora-workstation.ibmuc.com (unknown [9.61.31.211])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  4 Jun 2025 21:57:46 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: thuth@redhat.com, berrange@redhat.com, richard.henderson@linaro.org,
 david@redhat.com, pbonzini@redhat.com
Cc: walling@linux.ibm.com, jjherne@linux.ibm.com, jrossi@linux.ibm.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, farman@linux.ibm.com,
 iii@linux.ibm.com, eblake@redhat.com, armbru@redhat.com,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org, zycai@linux.ibm.com
Subject: [PATCH v3 19/28] pc-bios/s390-ccw: Refactor zipl_load_segment function
Date: Wed,  4 Jun 2025 17:56:47 -0400
Message-ID: <20250604215657.528142-20-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250604215657.528142-1-zycai@linux.ibm.com>
References: <20250604215657.528142-1-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: l9obETDuPu4c7dFOJqNcXECjcQqF3UIE
X-Proofpoint-ORIG-GUID: l9obETDuPu4c7dFOJqNcXECjcQqF3UIE
X-Authority-Analysis: v=2.4 cv=X4dSKHTe c=1 sm=1 tr=0 ts=6840c15f cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=6IFa9wvqVegA:10 a=VnNF1IyMAAAA:8 a=7R-l5uqnDSfc7LOOSFgA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA0MDE3NSBTYWx0ZWRfX2GGywrXQO9AI
 +zU315td82wYTMqa+4nQ81qMMt1m9OZxkzQk4pUhFUeEzfDWWGccVh8gqo86QxNfNO3hvCrkif9
 nBPLhggzbMDq7z6WmAZWJrU9+ZdX3NVNbOXcjIWflukkduKc+2oNrroatB5ifQd9VkiY5Wfj+9l
 B5DS83pZiYjDoRkIexoQl3c99l4RDHOlVD3TfKrunnJ/zhYO6B9kkfjUT5B0E6eiES5nqZyZyfN
 AfPhNqM2T6B3dIrlfiQOZlP+le573Z+LQ75j8zTvUQx4dALhUJSmE54G7ZbeNByOljn2urCSTQ/
 7zqPlX4mif9DaEImu5rC3gy/Cwblc2Im5Xt2xMuj4BcBGI6ARUWqrXYKlbQ8WaMB390UU0vzSpL
 o151a5xyIpSKURnGkHryHZA8/TFtdalgDO8YTfXT6UsqMXtlnoQpQ1l6TEd2dT7H9/8Q4h4Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-04_04,2025-06-03_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 clxscore=1015 phishscore=0 bulkscore=0
 malwarescore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506040175
Received-SPF: pass client-ip=148.163.158.5; envelope-from=zycai@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
index ced5190888..2513e6c131 100644
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
+            comp_len += bprs->size * (bprs[i].blockct + 1);
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


