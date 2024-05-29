Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A90AC27C44
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 13:34:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCJRZ-0003cL-Fs; Wed, 29 May 2024 09:34:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <oleg.sviridov@red-soft.ru>)
 id 1sCHc7-0005Zf-H6; Wed, 29 May 2024 07:37:03 -0400
Received: from red-soft.ru ([188.246.186.2] helo=gw.red-soft.ru)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <oleg.sviridov@red-soft.ru>)
 id 1sCHc4-0002vJ-Qo; Wed, 29 May 2024 07:37:03 -0400
Received: from localhost.localdomain.biz (unknown [10.81.100.51])
 by gw.red-soft.ru (Postfix) with ESMTPA id 1EB3E3E19C8;
 Wed, 29 May 2024 14:36:57 +0300 (MSK)
From: Oleg Sviridov <oleg.sviridov@red-soft.ru>
To: Oleg Sviridov <oleg.sviridov@red-soft.ru>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH] hw/s390x: prevent potential NULL dereference
Date: Wed, 29 May 2024 14:36:39 +0300
Message-ID: <20240529113643.3638618-1-oleg.sviridov@red-soft.ru>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-KLMS-Rule-ID: 1
X-KLMS-Message-Action: clean
X-KLMS-AntiSpam-Lua-Profiles: 185581 [May 29 2024]
X-KLMS-AntiSpam-Version: 6.1.0.4
X-KLMS-AntiSpam-Envelope-From: oleg.sviridov@red-soft.ru
X-KLMS-AntiSpam-Rate: 0
X-KLMS-AntiSpam-Status: not_detected
X-KLMS-AntiSpam-Method: none
X-KLMS-AntiSpam-Auth: dkim=none
X-KLMS-AntiSpam-Info: LuaCore: 20 0.3.20
 743589a8af6ec90b529f2124c2bbfc3ce1d2f20f,
 d41d8cd98f00b204e9800998ecf8427e.com:7.1.1; 127.0.0.199:7.1.2;
 red-soft.ru:7.1.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KLMS-AntiSpam-Interceptor-Info: scan successful
X-KLMS-AntiPhishing: Clean, bases: 2024/05/29 09:57:00
X-KLMS-AntiVirus: Kaspersky Security for Linux Mail Server, version 8.0.3.30,
 bases: 2024/05/29 05:10:00 #25335358
X-KLMS-AntiVirus-Status: Clean, skipped
Received-SPF: pass client-ip=188.246.186.2;
 envelope-from=oleg.sviridov@red-soft.ru; helo=gw.red-soft.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 29 May 2024 09:34:10 -0400
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

Pointer, returned from function 's390_ipl_get_iplb_pv', may be NULL and is dereferenced immediately after.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Oleg Sviridov <oleg.sviridov@red-soft.ru>
---
 hw/s390x/ipl.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
index e934bf89d1..2fa6a340a1 100644
--- a/hw/s390x/ipl.c
+++ b/hw/s390x/ipl.c
@@ -706,9 +706,14 @@ int s390_ipl_prepare_pv_header(Error **errp)
 {
     IplParameterBlock *ipib = s390_ipl_get_iplb_pv();
     IPLBlockPV *ipib_pv = &ipib->pv;
-    void *hdr = g_malloc(ipib_pv->pv_header_len);
+    void *hdr;
     int rc;
 
+    if (!ipib_pv) {
+        return -1;
+    }
+
+    hdr = g_malloc(ipib_pv->pv_header_len);
     cpu_physical_memory_read(ipib_pv->pv_header_addr, hdr,
                              ipib_pv->pv_header_len);
     rc = s390_pv_set_sec_parms((uintptr_t)hdr, ipib_pv->pv_header_len, errp);
@@ -722,6 +727,10 @@ int s390_ipl_pv_unpack(void)
     IPLBlockPV *ipib_pv = &ipib->pv;
     int i, rc = 0;
 
+    if (!ipib_pv) {
+        return -1;
+    }
+
     for (i = 0; i < ipib_pv->num_comp; i++) {
         rc = s390_pv_unpack(ipib_pv->components[i].addr,
                             TARGET_PAGE_ALIGN(ipib_pv->components[i].size),
-- 
2.44.0


