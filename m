Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 592F8C43458
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 20:52:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wf1tH-0003uq-Bi; Wed, 01 Jul 2026 16:50:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1wf1tF-0003s4-FL; Wed, 01 Jul 2026 16:50:37 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1wf1tD-0004Q7-Ua; Wed, 01 Jul 2026 16:50:37 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 661GmxCf1341052; Wed, 1 Jul 2026 20:50:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=OqlrodHPUlapgVnGa
 3tsxgVu7CCkob4jaYlnWD+C2lo=; b=ZMU7isb7qKrflaNy8glmq6b0yL/9EVQgD
 lm7ogWAFTP5vTuVju18A9pj0Fhe1HUAYDbxoEYQ109KqM5LomEyyvLSmiwd5Z/jK
 nEEnke/xG7BGA2lYaO+et0f8VDK5N0VjHb6k736hxqnOVUfHPwOJQLuFOnhmrACT
 fasKrCT0YxAH5VM+19v45ryofcG66CwlJIDo/W9knKFoRB8mqsNskgDGLkOmjP6T
 bSyjPi7Sr8rtcXWTgL6QAgTGC6vEy4hMGfwj4r/AJcLE/k44GcM9DXT3kdMm25xt
 kVZr8fG55NjhJI25lURJMnUT3fzspetEvuxMRVhOGbo0zhcp3eJZA==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26rf66e0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 01 Jul 2026 20:50:32 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 661KnapW001585;
 Wed, 1 Jul 2026 20:50:31 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f2s7w960e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 01 Jul 2026 20:50:31 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 661KoULC27001502
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 1 Jul 2026 20:50:30 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 59EAA5803F;
 Wed,  1 Jul 2026 20:50:30 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5E1FB5804E;
 Wed,  1 Jul 2026 20:50:27 +0000 (GMT)
Received: from fedora-workstation.lan (unknown [9.61.149.234])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  1 Jul 2026 20:50:27 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: jrossi@linux.ibm.com, cohuck@redhat.com, berrange@redhat.com,
 richard.henderson@linaro.org, david@kernel.org, walling@linux.ibm.com,
 jjherne@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, mjrosato@linux.ibm.com, iii@linux.ibm.com,
 eblake@redhat.com, armbru@redhat.com, zycai@linux.ibm.com,
 alifm@linux.ibm.com, brueckner@linux.ibm.com,
 pierrick.bouvier@oss.qualcomm.com, jdaley@linux.ibm.com
Subject: [PATCH v12 21/35] pc-bios/s390-ccw: Rework zipl_load_segment function
Date: Wed,  1 Jul 2026 16:49:07 -0400
Message-ID: <20260701204922.1320349-22-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260701204922.1320349-1-zycai@linux.ibm.com>
References: <20260701204922.1320349-1-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=a4kAM0SF c=1 sm=1 tr=0 ts=6a457d98 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8
 a=uL_FI9FW9AP7juJAwn4A:9
X-Proofpoint-ORIG-GUID: OEgu8W-IHtSsSKYCbYDY705cdfSqe74e
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDIyMiBTYWx0ZWRfX2F0YHhAqEuA4
 kilc799HZ5gMqoDfqZm83+32sf3aSuov0mOgs6MkYRy6bNwSmra+lvHqpsFDLCuXmethMCtCL5E
 7l5spyBb2WmKTo+vlt7ukRHz1v4k+CYVB2DDLfGtkxM2hbj+6nyIPIhRJdglghcKZ+9PX1bLUql
 E+WGur/g1VPiIlM9cXUeMHQe4SqVLGmhmKQ4mKINqlwe2JH38XJG0n7RXZD9rR02vuv0gnCtAtI
 9UjDZk38nxy0DBcUQY7833zyWtWvF9lLLbeUTmTGFk1azLBVs3NOqMfeUiVuRFfc+hQQT4wSr3p
 rYd7rm1UA54VfNX0bZdo6NLMT01zcoWJBBtN8g9bvspIYIglFTAO7D6bWUFz8iULGhvyPoQLr5e
 5HMFi0QkKoU1iDKB54BN69+Cze85IENadXJh+SuhLTjO1ME9S2S4RuojDcFGrSjPyOEisAVdPX/
 2KGQ0t1RxvD72+tx4mA==
X-Proofpoint-GUID: OEgu8W-IHtSsSKYCbYDY705cdfSqe74e
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDIyMiBTYWx0ZWRfX8X9DEuWK6nGz
 SbPmBrEajfh94G+AmcdCT+jeY51h7tpYf+abBVx/ao1Jn9Psk7ffSjusA9Lf30YFEif8ZtR4SB5
 hyDfow72+madLFeaJ5eKhFS7dTagQBg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_04,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0
 spamscore=0 priorityscore=1501 adultscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607010222
Received-SPF: pass client-ip=148.163.158.5; envelope-from=zycai@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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


