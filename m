Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D597C53219
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 11:52:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woJrn-00053w-DF; Mon, 27 Jul 2026 07:51:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@linux.ibm.com>)
 id 1woJrX-0004x6-7w; Mon, 27 Jul 2026 07:51:20 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@linux.ibm.com>)
 id 1woJrV-0003c4-Co; Mon, 27 Jul 2026 07:51:14 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66RAImln1844841; Mon, 27 Jul 2026 11:51:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=pO114JuJig7GPSmae
 kx2bsmKmz9EMCnMJdi1KUVBtxk=; b=sSR2RYmmjBQFfAX88PeV9TW9v5okRlfer
 tGvxKW6qgreUgQg8FbxkLW0dQmSm1LTqiJnCLCAngH1L6fKCiAgfdJ0Q8hXR1+kG
 TCqtrcz1GY39MsGteHydFa2X+nyKbwhaDY/t/xlwWN+22rvStg5+gS6pcfuXSanT
 FiGoXmHH47KZL90388NZMj4hUJ43LVzQmUta5oyWu/XITdh9ogrw3JLf+N5Pj0Sl
 QtsSmqWws3VL8q1gb7y/Easnur9cwO0HoS8TOJsAF+niHOu7R0jNKOONv254rFm9
 WcgfwPTIGzCt911mEkKqo7oSn5860vwVaPqICuf+p7bus4aBO5qnw==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuyhycxb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 27 Jul 2026 11:51:10 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66RBfIbJ016254;
 Mon, 27 Jul 2026 11:51:09 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fn9pg511b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 27 Jul 2026 11:51:09 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66RBp86R20316896
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 27 Jul 2026 11:51:08 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 606055805A;
 Mon, 27 Jul 2026 11:51:08 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CB95958056;
 Mon, 27 Jul 2026 11:51:05 +0000 (GMT)
Received: from b35lp69.lnxne.boe (unknown [9.87.84.240])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 27 Jul 2026 11:51:05 +0000 (GMT)
From: Christian Borntraeger <borntraeger@linux.ibm.com>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>,
 Halil Pasic <pasic@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Jason Herne <jjherne@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 Hendrik Brueckner <brueckner@linux.ibm.com>,
 Joshua Daley <jdaley@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Jared Rossi <jrossi@linux.ibm.com>, Zhuoying Cai <zycai@linux.ibm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH 4/5] pc-bios/s390-ccw: bounds-check zipl menu entry index
 before array write
Date: Mon, 27 Jul 2026 13:50:51 +0200
Message-ID: <20260727115052.24289-5-borntraeger@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260727115052.24289-1-borntraeger@linux.ibm.com>
References: <20260727115052.24289-1-borntraeger@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDExNiBTYWx0ZWRfXyhNqmpu3xGtB
 8Vf4PuApjypT1fnGn7cTe2Ie9gEWPKF58XBRoE6UpegkkOzT7U1Eg5z+NePxNVFeEOKc78AmMFt
 +txnDFw6ekocmIWPK4xvT92sKyVoubA=
X-Proofpoint-GUID: IGuIm0YIDJkj0I2SLX0RjrjeOlzQDr0_
X-Proofpoint-ORIG-GUID: IGuIm0YIDJkj0I2SLX0RjrjeOlzQDr0_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDExNiBTYWx0ZWRfXzIgmz2ciDFcs
 UDepXUfLJ2zLGbNzssFHZvv/fyoZf4dKz7Hd5oWs4YDR6aXMeYgztKn2eeJb3Fi0mHore374or/
 fcNOepyL2ngJOODJ1JYFCh/wpGfRtVTuPfq9JHCdLqvlnp+i063qsr8zo0bS3HSwAe4xWONsoxZ
 7z1Zr+ppn/p9HYFgz2aC0HZhj2VTupVnSggVhSD/mc0eYWj9XUkNJDuCmyiSaz0tvF/ROLq4Aen
 eH08GFmUTfYrO97WkZx6tH1IIxx9KCccry3VUTomGnOGlIkRjCEmnoCsjJhHpznxl0l7xoeDxWG
 guepA7NsTgPQ0Jlk+D6sSYTcv0PCFB1Rey/A3ki8659zF0ORTt2gK92PrLsLlSDO1QhU4GSdMil
 NtI7sbJd0ONMnMrXzdpjVAGAKMcl/jAHpJ9gkYH6Y5P6cFiVB3fmLD0UarNLFuigVriRyX/eSB7
 NH56H4/6t294HIQzTcg==
X-Authority-Analysis: v=2.4 cv=X5Vi7mTe c=1 sm=1 tr=0 ts=6a67462e cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=K1TfFEnDoUzuEk3QFlUA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_03,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607270116
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=borntraeger@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
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

From: Joshua Daley <jdaley@linux.ibm.com>

menu_get_zipl_boot_index() iterates NUL-separated strings from the
zipl stage-2 boot-menu block, passes each to zipl_print_entry() which
converts EBCDIC to ASCII and returns atoi(), then writes true into
valid_entries[entry]. valid_entries is a MAX_BOOT_ENTRIES element
stack array, but entry was never bounds-checked, so a crafted on-disk
value could index arbitrarily beyond the array.

Fix this in two places:

- zipl_print_entry() now validates that the first significant character
  (after an optional leading space) is a digit. Entries that fail this
  check return -1 without printing.

- menu_get_zipl_boot_index() skips any entry whose index is outside
  [0, MAX_BOOT_ENTRIES) before writing to valid_entries[].

Fixes: 7385e947fc65 ("pc-bios/s390-ccw: fix non-sequential boot entries (eckd)")
Signed-off-by: Joshua Daley <jdaley@linux.ibm.com>
---
 pc-bios/s390-ccw/menu.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/pc-bios/s390-ccw/menu.c b/pc-bios/s390-ccw/menu.c
index eeaff78f87..b6a9a56d46 100644
--- a/pc-bios/s390-ccw/menu.c
+++ b/pc-bios/s390-ccw/menu.c
@@ -176,18 +176,24 @@ int menu_get_boot_index(bool *valid_entries)
     return boot_index;
 }
 
-/* Returns the entry number that was printed */
+/* Returns the entry number that was printed, or -1 on invalid entry */
 static int zipl_print_entry(const char *data, size_t len)
 {
     char buf[len + 2];
+    const char *p;
 
     ebcdic_to_ascii(data, buf, len);
     buf[len] = '\n';
     buf[len + 1] = '\0';
 
+    p = (buf[0] == ' ') ? buf + 1 : buf;
+    if (!isdigit((unsigned char)*p)) {
+        return -1;
+    }
+
     printf("%s", buf);
 
-    return buf[0] == ' ' ? atoi(buf + 1) : atoi(buf);
+    return atoi(p);
 }
 
 int menu_get_zipl_boot_index(const char *menu_data)
@@ -216,6 +222,9 @@ int menu_get_zipl_boot_index(const char *menu_data)
         entry = zipl_print_entry(menu_data, len);
         menu_data += len + 1;
 
+        if (entry < 0 || entry >= MAX_BOOT_ENTRIES) {
+            continue;
+        }
         valid_entries[entry] = true;
 
         if (entry == 0) {
-- 
2.53.0


