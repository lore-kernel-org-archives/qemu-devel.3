Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56E03C25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 13:34:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCJRZ-0003cH-GO; Wed, 29 May 2024 09:34:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <oleg.sviridov@red-soft.ru>)
 id 1sCHAj-0005NF-5P; Wed, 29 May 2024 07:08:45 -0400
Received: from red-soft.ru ([188.246.186.2] helo=gw.red-soft.ru)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <oleg.sviridov@red-soft.ru>)
 id 1sCHAf-0005iq-Mb; Wed, 29 May 2024 07:08:43 -0400
Received: from localhost.localdomain.biz (unknown [10.81.100.51])
 by gw.red-soft.ru (Postfix) with ESMTPA id 7B8713E1A85;
 Wed, 29 May 2024 14:08:36 +0300 (MSK)
From: Oleg Sviridov <oleg.sviridov@red-soft.ru>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Oleg Sviridov <oleg.sviridov@red-soft.ru>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Jason Wang <jasowang@redhat.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH] hw/net: prevent potential NULL dereference
Date: Wed, 29 May 2024 14:07:18 +0300
Message-ID: <20240529110804.3636963-1-oleg.sviridov@red-soft.ru>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-KLMS-Rule-ID: 1
X-KLMS-Message-Action: clean
X-KLMS-AntiSpam-Lua-Profiles: 185580 [May 29 2024]
X-KLMS-AntiSpam-Version: 6.1.0.4
X-KLMS-AntiSpam-Envelope-From: oleg.sviridov@red-soft.ru
X-KLMS-AntiSpam-Rate: 0
X-KLMS-AntiSpam-Status: not_detected
X-KLMS-AntiSpam-Method: none
X-KLMS-AntiSpam-Auth: dkim=none
X-KLMS-AntiSpam-Info: LuaCore: 20 0.3.20
 743589a8af6ec90b529f2124c2bbfc3ce1d2f20f, {Tracking_arrow_text},
 {Tracking_from_domain_doesnt_match_to}, 127.0.0.199:7.1.2; red-soft.ru:7.1.1;
 d41d8cd98f00b204e9800998ecf8427e.com:7.1.1, FromAlignment: s
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

Pointer, returned from function 'spapr_vio_find_by_reg', may be NULL and is dereferenced immediately after.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Oleg Sviridov <oleg.sviridov@red-soft.ru>
---
 hw/net/spapr_llan.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/net/spapr_llan.c b/hw/net/spapr_llan.c
index ecb30b7c76..f40b733229 100644
--- a/hw/net/spapr_llan.c
+++ b/hw/net/spapr_llan.c
@@ -770,6 +770,10 @@ static target_ulong h_change_logical_lan_mac(PowerPCCPU *cpu,
     SpaprVioVlan *dev = VIO_SPAPR_VLAN_DEVICE(sdev);
     int i;
 
+    if (!dev) {
+        return H_PARAMETER;
+    }
+
     for (i = 0; i < ETH_ALEN; i++) {
         dev->nicconf.macaddr.a[ETH_ALEN - i - 1] = macaddr & 0xff;
         macaddr >>= 8;
-- 
2.44.0


