Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7486C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2024 08:27:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwe9O-0005WE-BA; Tue, 16 Apr 2024 04:26:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <artem.chernyshev@red-soft.ru>)
 id 1rwe9K-0005VZ-UJ; Tue, 16 Apr 2024 04:26:42 -0400
Received: from red-soft.ru ([188.246.186.2] helo=gw.red-soft.ru)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <artem.chernyshev@red-soft.ru>)
 id 1rwe9I-0007OQ-3Q; Tue, 16 Apr 2024 04:26:42 -0400
Received: from localhost.biz (unknown [10.81.100.48])
 by gw.red-soft.ru (Postfix) with ESMTPA id 483E33E1CE7;
 Tue, 16 Apr 2024 11:26:34 +0300 (MSK)
From: Artem Chernyshev <artem.chernyshev@red-soft.ru>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Artem Chernyshev <artem.chernyshev@red-soft.ru>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, Oleg Sviridov <oleg.sviridov@red-soft.ru>
Subject: [PATCH] hw/nvram: Make (len + offset) check more strict
Date: Tue, 16 Apr 2024 11:26:31 +0300
Message-Id: <20240416082631.2417370-1-artem.chernyshev@red-soft.ru>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-KLMS-Rule-ID: 1
X-KLMS-Message-Action: clean
X-KLMS-AntiSpam-Lua-Profiles: 184729 [Apr 16 2024]
X-KLMS-AntiSpam-Version: 6.1.0.4
X-KLMS-AntiSpam-Envelope-From: artem.chernyshev@red-soft.ru
X-KLMS-AntiSpam-Rate: 0
X-KLMS-AntiSpam-Status: not_detected
X-KLMS-AntiSpam-Method: none
X-KLMS-AntiSpam-Auth: dkim=none
X-KLMS-AntiSpam-Info: LuaCore: 17 0.3.17
 f2153f38d75b12894d9cf445f96cd15c9ef63a9d,
 {Tracking_from_domain_doesnt_match_to}, localhost.biz:7.1.1; red-soft.ru:7.1.1;
 d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;
 127.0.0.199:7.1.2, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KLMS-AntiSpam-Interceptor-Info: scan successful
X-KLMS-AntiPhishing: Clean, bases: 2024/04/16 06:38:00
X-KLMS-AntiVirus: Kaspersky Security for Linux Mail Server, version 8.0.3.30,
 bases: 2024/04/16 06:04:00 #24816272
X-KLMS-AntiVirus-Status: Clean, skipped
Received-SPF: pass client-ip=188.246.186.2;
 envelope-from=artem.chernyshev@red-soft.ru; helo=gw.red-soft.ru
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_VALIDITY_RPBL=1.31,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

In rtas_nvram_fetch() and rtas_nvram_store() if len is equal
to zero, result of a cpu_physical_memory_map() will be NULL. 
It will lead to NULL dereference, since return value using 
without check. It could be avoided by making IF condition 
more strict.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Oleg Sviridov <oleg.sviridov@red-soft.ru>
Signed-off-by: Artem Chernyshev <artem.chernyshev@red-soft.ru>
---
 hw/nvram/spapr_nvram.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/nvram/spapr_nvram.c b/hw/nvram/spapr_nvram.c
index bfd8aa367e..bf0a7d05df 100644
--- a/hw/nvram/spapr_nvram.c
+++ b/hw/nvram/spapr_nvram.c
@@ -79,7 +79,7 @@ static void rtas_nvram_fetch(PowerPCCPU *cpu, SpaprMachineState *spapr,
     buffer = rtas_ld(args, 1);
     len = rtas_ld(args, 2);
 
-    if (((offset + len) < offset)
+    if (((offset + len) <= offset)
         || ((offset + len) > nvram->size)) {
         rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
         rtas_st(rets, 1, 0);
@@ -120,7 +120,7 @@ static void rtas_nvram_store(PowerPCCPU *cpu, SpaprMachineState *spapr,
     buffer = rtas_ld(args, 1);
     len = rtas_ld(args, 2);
 
-    if (((offset + len) < offset)
+    if (((offset + len) <= offset)
         || ((offset + len) > nvram->size)) {
         rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
         return;
-- 
2.37.3


