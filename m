Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A29F2C54EFC
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 11:52:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woJrk-000508-TF; Mon, 27 Jul 2026 07:51:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@linux.ibm.com>)
 id 1woJra-0004xN-5g; Mon, 27 Jul 2026 07:51:20 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@linux.ibm.com>)
 id 1woJrY-0003cW-E7; Mon, 27 Jul 2026 07:51:17 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66RAIbgK1960009; Mon, 27 Jul 2026 11:51:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=zCCqF9QkeF7m5UQsN
 ya4VUGxJR0nDrFUU2qwq7p3eSo=; b=cUpc/3x+aDiG/HvEl6DRLhC49l6NQiA7w
 bnVECX2JDo7dZ7A0RqYvlpLM1UXnANlDb4PgW5hCkO6XnrcQT2rUQij/955KT1//
 UEFGeP62/qe+ySAuCDPY3K0x30/KA6JMj6LoF7QT6ksO1PslEo6KpRGgxK2bx3Sa
 ctwboDuR7c8uITbNQGdR06V09CpFid8uGs4wDqmH7S4b71rc1hrX1XH/K2GaDb+E
 zpV12oe+rIEnm73n2AWp0OMggR3fQyM+J7yUEaOI0SZzCfQlr7VT1k29GXK1hJIb
 G/AQNdmhB5gBvT4GwoGI+nJaS9U8a8/ZSCHhonXAILsZvs3ShJJiw==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuwcqdbq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 27 Jul 2026 11:51:13 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66RBfMx6005889;
 Mon, 27 Jul 2026 11:51:12 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8yh551x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 27 Jul 2026 11:51:12 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66RBpB9A18022942
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 27 Jul 2026 11:51:11 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 34EEF5803F;
 Mon, 27 Jul 2026 11:51:11 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A15C158064;
 Mon, 27 Jul 2026 11:51:08 +0000 (GMT)
Received: from b35lp69.lnxne.boe (unknown [9.87.84.240])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 27 Jul 2026 11:51:08 +0000 (GMT)
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
Subject: [PATCH 5/5] pc-bios/s390-ccw: bound zipl menu strlen and replace VLA
 in zipl_print_entry
Date: Mon, 27 Jul 2026 13:50:52 +0200
Message-ID: <20260727115052.24289-6-borntraeger@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260727115052.24289-1-borntraeger@linux.ibm.com>
References: <20260727115052.24289-1-borntraeger@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: tbqra_HqRr4Wq6XzxM1vD5Ab-sOQP1bF
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDExNiBTYWx0ZWRfX9171Q8V2LSYS
 90BuQ/fwXi7nKbCxZAnyusfEXIZ1WDPtmIv8F8uzNRqXhi1uV1sKX+ApMfKmri66k6vYbF675Fg
 34Ia/Pyr1lNLzWCxFXNLqosEYkGsVHk=
X-Authority-Analysis: v=2.4 cv=E/z9Y6dl c=1 sm=1 tr=0 ts=6a674631 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=OmDNG2-DsvkCiAtxb_cA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDExNiBTYWx0ZWRfXy2RBPrMuq7eX
 YeATD1XWcMKm/jcfLRy6cAEdY+aoD4xrPFpOSLfyTbXwfOZ32yR7C++HfnE9SFq114LVUmMaEBz
 kdnlHFeG3ETixijPQT8aM5cAsaDTHHWSvDwOnYJjq/i7b761cxGFzsU0RyJzdkeJ835oPKz4+Ov
 BmK/S4DrAZ8cTeFkt6GpqSFR5Fec4CXQMBZm1leLeusY72vRWZ6amRJt3dx2//jBFMlh3WOfei6
 Xl5mAuVq6E9WMqbWRV3hcs7s3s7OzQ8V8Fyc0UISy5Vp1U70pSUEN1iWSF5uL5BUTA/bI8CXwpU
 Dh5pdE9qHFA7gYBPKX0X++2UbtFt8UCvgjr8VB9fX4PoplET9hjHr3SrFNKyGUKziEnd6X8MXFs
 EEBHt6uW3r3tq9ilKCaoZyy/YKJfi0VVohgrpx5ziv5jch09K2n4vEwQdWSpdjOwSWn4C1pFc1X
 I1ez9+K9cu7Mq9ELY5A==
X-Proofpoint-GUID: tbqra_HqRr4Wq6XzxM1vD5Ab-sOQP1bF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_03,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 spamscore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607270116
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

menu_get_zipl_boot_index() calls strlen() on a pointer into the middle
of _s2 with no upper bound, so a stage-2 image whose blocks contain no
NUL bytes causes strlen() to walk beyond _s2. The resulting length
is then used to size a stack VLA in zipl_print_entry(), risking a stack
overflow.

Fix by:

- Implementing strnlen(), a bounded version of strlen().

- Adding a menu_data_end parameter to menu_get_zipl_boot_index() and
  replacing both strlen() calls with strnlen() bounded by the remaining
  buffer space. The loop guard also checks that the pointer has not
  reached menu_data_end. For robustness, the function returns 0
  (boot default) if somehow menu_data is initially >= menu_data_end.

- Replacing the VLA char buf[len + 2] in zipl_print_entry() with a fixed
  ZIPL_ENTRY_MAX + 2 (82-byte) buffer and truncating len before use.

- Passing s2_end (_s2 + sizeof(_s2)) as menu_data_end at the one call
  site in eckd_get_boot_menu_index(), so the bound is exactly the end of
  the buffer.

Fixes: f7178910845a ("s390-ccw: print zipl boot menu")
Signed-off-by: Joshua Daley <jdaley@linux.ibm.com>
---
 pc-bios/s390-ccw/bootmap.c  |  4 +++-
 pc-bios/s390-ccw/helper.h   | 10 ++++++++++
 pc-bios/s390-ccw/menu.c     | 23 ++++++++++++++++++-----
 pc-bios/s390-ccw/s390-ccw.h |  2 +-
 4 files changed, 32 insertions(+), 7 deletions(-)

diff --git a/pc-bios/s390-ccw/bootmap.c b/pc-bios/s390-ccw/bootmap.c
index ed6e8cbbc7..81512265ce 100644
--- a/pc-bios/s390-ccw/bootmap.c
+++ b/pc-bios/s390-ccw/bootmap.c
@@ -61,6 +61,7 @@ static uint8_t _s2[MAX_SECTOR_SIZE * 3] __attribute__((__aligned__(PAGE_SIZE)));
 static void *s2_prev_blk = _s2;
 static void *s2_cur_blk = _s2 + MAX_SECTOR_SIZE;
 static void *s2_next_blk = _s2 + MAX_SECTOR_SIZE * 2;
+static void *s2_end = _s2 + sizeof(_s2);
 
 static inline int verify_boot_info(BootInfo *bip)
 {
@@ -308,7 +309,8 @@ static int eckd_get_boot_menu_index(block_number_t s1b_block_nr)
                 }
             }
 
-            return menu_get_zipl_boot_index(s2_cur_blk + banner_offset);
+            return menu_get_zipl_boot_index(s2_cur_blk + banner_offset,
+                                            s2_end);
         }
 
         prev_block_nr = cur_block_nr;
diff --git a/pc-bios/s390-ccw/helper.h b/pc-bios/s390-ccw/helper.h
index 8e3dfcb6d6..d9b7da444a 100644
--- a/pc-bios/s390-ccw/helper.h
+++ b/pc-bios/s390-ccw/helper.h
@@ -45,4 +45,14 @@ static inline void sleep(unsigned int seconds)
     }
 }
 
+static inline size_t strnlen(const char *s, size_t maxlen)
+{
+    size_t len = 0;
+
+    while (len < maxlen && s[len]) {
+        len++;
+    }
+    return len;
+}
+
 #endif
diff --git a/pc-bios/s390-ccw/menu.c b/pc-bios/s390-ccw/menu.c
index b6a9a56d46..af96a83de9 100644
--- a/pc-bios/s390-ccw/menu.c
+++ b/pc-bios/s390-ccw/menu.c
@@ -16,6 +16,7 @@
 #include "s390-ccw.h"
 #include "sclp.h"
 #include "s390-time.h"
+#include "helper.h"
 
 #define KEYCODE_NO_INP '\0'
 #define KEYCODE_ESCAPE '\033'
@@ -26,6 +27,9 @@
 #define ZIPL_TIMEOUT_OFFSET 138
 #define ZIPL_FLAG_OFFSET    140
 
+/* Max printable chars for a zipl boot menu entry */
+#define ZIPL_ENTRY_MAX 80
+
 #define TOD_CLOCK_MILLISECOND   0x3e8000
 
 #define LOW_CORE_EXTERNAL_INT_ADDR   0x86
@@ -179,9 +183,13 @@ int menu_get_boot_index(bool *valid_entries)
 /* Returns the entry number that was printed, or -1 on invalid entry */
 static int zipl_print_entry(const char *data, size_t len)
 {
-    char buf[len + 2];
+    char buf[ZIPL_ENTRY_MAX + 2];
     const char *p;
 
+    if (len > ZIPL_ENTRY_MAX) {
+        len = ZIPL_ENTRY_MAX;
+    }
+
     ebcdic_to_ascii(data, buf, len);
     buf[len] = '\n';
     buf[len + 1] = '\0';
@@ -196,7 +204,7 @@ static int zipl_print_entry(const char *data, size_t len)
     return atoi(p);
 }
 
-int menu_get_zipl_boot_index(const char *menu_data)
+int menu_get_zipl_boot_index(const char *menu_data, const char *menu_data_end)
 {
     size_t len;
     int entry;
@@ -212,13 +220,18 @@ int menu_get_zipl_boot_index(const char *menu_data)
         timeout = zipl_timeout * 1000;
     }
 
+    if (menu_data >= menu_data_end) {
+        return 0;
+    }
+
     /* Print banner */
     puts("s390-ccw zIPL Boot Menu\n");
-    menu_data += strlen(menu_data) + 1;
+    len = strnlen(menu_data, menu_data_end - menu_data);
+    menu_data += len + 1;
 
     /* Print entries */
-    while (*menu_data) {
-        len = strlen(menu_data);
+    while (menu_data < menu_data_end && *menu_data) {
+        len = strnlen(menu_data, menu_data_end - menu_data);
         entry = zipl_print_entry(menu_data, len);
         menu_data += len + 1;
 
diff --git a/pc-bios/s390-ccw/s390-ccw.h b/pc-bios/s390-ccw/s390-ccw.h
index 1e1f71775e..f6030a6071 100644
--- a/pc-bios/s390-ccw/s390-ccw.h
+++ b/pc-bios/s390-ccw/s390-ccw.h
@@ -76,7 +76,7 @@ void jump_to_low_kernel(void);
 
 /* menu.c */
 void menu_set_parms(uint8_t boot_menu_flag, uint32_t boot_menu_timeout);
-int menu_get_zipl_boot_index(const char *menu_data);
+int menu_get_zipl_boot_index(const char *menu_data, const char *menu_data_end);
 bool menu_is_enabled_zipl(void);
 int menu_get_enum_boot_index(bool *valid_entries);
 bool menu_is_enabled_enum(void);
-- 
2.53.0


