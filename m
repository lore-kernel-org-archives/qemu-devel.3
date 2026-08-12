Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CBD2C5B572
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 17:19:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuCbV-0001Ov-Iz; Wed, 12 Aug 2026 13:19:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1wuCZx-0000CD-Ut; Wed, 12 Aug 2026 13:17:27 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1wuCZs-0000qb-Sk; Wed, 12 Aug 2026 13:17:24 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67CH1dXd4120439; Wed, 12 Aug 2026 17:17:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=CJD1s9Rhsrn5cw+mO
 iPzDVsFYoH6nFn6C8Su43oA/Ro=; b=RrBEjfBpeiAcK0C9hjogS5lX+GypMzprI
 dv7JWmWqdGGW9WbLxDzXa13kJrtqMUXJeOT27GarW80giFP2lAiNnDeP2Hy5LyHu
 SvgDOidPgj5ok3Ve0gjLtkmaLHiotG2CP3ZKvOQaEIduAUWqSW0zk1ZSIg4yKhhU
 6tje7YdKPfEeYlLAxOnM989b71sB/xbYfiC0N1pLmIzs2NEQzFA0IbP/G2OqYW8X
 A2Y8wo0MGnvwoGfVL+mGmIftHp1bx/UwAMQqZjgJelMc4mogERWEyQvue6vJCwkX
 0O2333bzbg8LepRMVUkLOTynzi0tybiT7A8Up6dGkhb7b8Li6lgkw==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvnwavhs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 12 Aug 2026 17:17:18 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67CHBGX6025460;
 Wed, 12 Aug 2026 17:17:18 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxhfy6x8b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 12 Aug 2026 17:17:18 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67CHHHTc32768592
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 12 Aug 2026 17:17:17 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 41CBC58051;
 Wed, 12 Aug 2026 17:17:17 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A0D045805C;
 Wed, 12 Aug 2026 17:17:16 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com.com (unknown
 [9.61.61.74]) by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 12 Aug 2026 17:17:16 +0000 (GMT)
From: Eric Farman <farman@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Matthew Rosato <mjrosato@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Joshua Daley <jdaley@linux.ibm.com>,
 qemu-stable@nongnu.org, Eric Farman <farman@linux.ibm.com>
Subject: [PULL 09/15] pc-bios/s390-ccw: bound zipl menu strlen and replace VLA
 in zipl_print_entry
Date: Wed, 12 Aug 2026 13:17:01 -0400
Message-ID: <20260812171707.1605637-10-farman@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260812171707.1605637-1-farman@linux.ibm.com>
References: <20260812171707.1605637-1-farman@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=RsP16imK c=1 sm=1 tr=0 ts=6a7caa9f cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=69wJf7TsAAAA:8
 a=OmDNG2-DsvkCiAtxb_cA:9 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-GUID: YSqIi20wIH5KE20VvgIGVq7aDSd0ulFN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDEzOCBTYWx0ZWRfX1RGCi9c0lorV
 dA3m2S80O2fXUt0QKeuiwyB0dDbqIpGT2Org2rjauIBDSBvIt5tFwj11yBSK4YFK1//bzkY+mVI
 3vPu7gwLW6g2zBHQyphD3Y0U8VJz269bCSrw1FCza8yonFdZ+BYtWCtZ5gvfjOouqG6fOcjsU60
 1YGCb+Jj/B5JXnfbgOBXux62jbnAp6wq4KnKbtQ+RqR/rx8iJY2o1B2R4kzpOwuNpUbjemj6RH8
 ntwGRqeX70HE36yw8VEd43RPK6hlwtR+LJcvyGqCDp27O9aSgZ0QSvEOB8ADODkgP2ftOTa0ZAJ
 wL2XyzmqTuGW25+W4a8ygs6pB3VK3e4G938olwOxwCLIu9jpQBoyiQbPxSZv1b1WBW0sqfkYViK
 5RzmgNXvyr+YFQHH2N6ReZ+oVHXAssUjPH4se2VwjMLkFbtfWXO8+pSpm91lPXWrRiUx2OVOhNH
 LNSYnKB087/Q1FQaEuQ==
X-Proofpoint-ORIG-GUID: YSqIi20wIH5KE20VvgIGVq7aDSd0ulFN
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDEzOCBTYWx0ZWRfXxi4p3kJFB113
 I4qGUgxkBxDgszHBH2LmfvxOzqXW9Vi6bSw0YBPI6KRo/mKEA2Vu1dIKtBO8UPe02bidb6kTbVG
 S+16OkY9tpR2UPaAN2bj5RlA09p7STg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_05,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120138
Received-SPF: pass client-ip=148.163.158.5; envelope-from=farman@linux.ibm.com;
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

From: Joshua Daley <jdaley@linux.ibm.com>

menu_get_zipl_boot_index() calls strlen() on a pointer into the middle
of _s2 with no upper bound, so a stage-2 image whose blocks contain no
NUL bytes causes strlen() to walk beyond _s2. The resulting length
is then used to size a stack VLA in zipl_print_entry(), risking a stack
overflow.

Fix by:

- Implementing strnlen(), a bounded version of strlen(). s390-ccw uses
  libc from SLOF, which includes strlen() but does not have an
  implementation of strnlen(), so we must implement our own.

- Adding a menu_data_end parameter to menu_get_zipl_boot_index() and
  replacing both strlen() calls with strnlen() bounded by the remaining
  buffer space. The loop guard also checks that the pointer has not
  reached menu_data_end. The function returns 0 (boot default) if
  somehow menu_data reaches menu_data_end before printing any entries.

- Replacing the VLA char buf[len + 2] in zipl_print_entry() with a fixed
  ZIPL_ENTRY_MAX + 2 (82-byte) buffer and truncating len before use.

- Passing s2_end (_s2 + sizeof(_s2)) as menu_data_end at the one call
  site in eckd_get_boot_menu_index(), so the bound is exactly the end of
  the buffer.

Fixes: f7178910845a ("s390-ccw: print zipl boot menu")
Cc: qemu-stable@nongnu.org
Signed-off-by: Joshua Daley <jdaley@linux.ibm.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20260728134704.2924005-2-jdaley@linux.ibm.com
[farman@linux.ibm.com: Per list, add strnlen rationale to commit message
 and added cc stable]
Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 pc-bios/s390-ccw/bootmap.c  |  4 +++-
 pc-bios/s390-ccw/helper.h   | 10 ++++++++++
 pc-bios/s390-ccw/menu.c     | 29 +++++++++++++++++++++++------
 pc-bios/s390-ccw/s390-ccw.h |  2 +-
 4 files changed, 37 insertions(+), 8 deletions(-)

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
index b6a9a56d46..9b81154b0e 100644
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
@@ -212,13 +220,22 @@ int menu_get_zipl_boot_index(const char *menu_data)
         timeout = zipl_timeout * 1000;
     }
 
-    /* Print banner */
+    if (menu_data >= menu_data_end) {
+        return 0; /* Boot default */
+    }
+
+    /* Skip banner */
+    len = strnlen(menu_data, menu_data_end - menu_data);
+    menu_data += len + 1;
+    if (menu_data >= menu_data_end || !(*menu_data)) {
+        return 0; /* No entries, boot default */
+    }
+
     puts("s390-ccw zIPL Boot Menu\n");
-    menu_data += strlen(menu_data) + 1;
 
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
2.55.0


