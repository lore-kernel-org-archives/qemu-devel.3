Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C7D3CD128A
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Mar 2024 12:47:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rqBdS-0005YO-Be; Fri, 29 Mar 2024 08:47:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <artem.chernyshev@red-soft.ru>)
 id 1rqAap-0001Nk-Ln
 for qemu-devel@nongnu.org; Fri, 29 Mar 2024 07:40:21 -0400
Received: from red-soft.ru ([188.246.186.2] helo=gw.red-soft.ru)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <artem.chernyshev@red-soft.ru>) id 1rqAag-0004Jq-Gf
 for qemu-devel@nongnu.org; Fri, 29 Mar 2024 07:40:13 -0400
Received: from localhost.biz (unknown [10.81.100.48])
 by gw.red-soft.ru (Postfix) with ESMTPA id F2DD13E1AB8;
 Fri, 29 Mar 2024 14:39:54 +0300 (MSK)
From: Artem Chernyshev <artem.chernyshev@red-soft.ru>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Artem Chernyshev <artem.chernyshev@red-soft.ru>,
 Paul Durrant <paul@xen.org>, "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-devel@nongnu.org,
 Oleg Sviridov <oleg.sviridov@red-soft.ru>
Subject: [PATCH] hw/xen_evtchn: Initialize flush_kvm_routes
Date: Fri, 29 Mar 2024 14:39:39 +0300
Message-Id: <20240329113939.257033-1-artem.chernyshev@red-soft.ru>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-KLMS-Rule-ID: 1
X-KLMS-Message-Action: clean
X-KLMS-AntiSpam-Lua-Profiles: 184489 [Mar 29 2024]
X-KLMS-AntiSpam-Version: 6.1.0.4
X-KLMS-AntiSpam-Envelope-From: artem.chernyshev@red-soft.ru
X-KLMS-AntiSpam-Rate: 0
X-KLMS-AntiSpam-Status: not_detected
X-KLMS-AntiSpam-Method: none
X-KLMS-AntiSpam-Auth: dkim=none
X-KLMS-AntiSpam-Info: LuaCore: 14 0.3.14
 5a0c43d8a1c3c0e5b0916cc02a90d4b950c01f96,
 {Tracking_from_domain_doesnt_match_to}, localhost.biz:7.1.1;
 d41d8cd98f00b204e9800998ecf8427e.com:7.1.1; red-soft.ru:7.1.1;
 127.0.0.199:7.1.2, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KLMS-AntiSpam-Interceptor-Info: scan successful
X-KLMS-AntiPhishing: Clean, bases: 2024/03/29 10:56:00
X-KLMS-AntiVirus: Kaspersky Security for Linux Mail Server, version 8.0.3.30,
 bases: 2024/03/29 08:22:00 #24505801
X-KLMS-AntiVirus-Status: Clean, skipped
Received-SPF: pass client-ip=188.246.186.2;
 envelope-from=artem.chernyshev@red-soft.ru; helo=gw.red-soft.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 29 Mar 2024 08:46:49 -0400
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

In xen_evtchn_soft_reset() variable flush_kvm_routes can
be used before being initialized.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Oleg Sviridov <oleg.sviridov@red-soft.ru>
Signed-off-by: Artem Chernyshev <artem.chernyshev@red-soft.ru>
---
 hw/i386/kvm/xen_evtchn.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/i386/kvm/xen_evtchn.c b/hw/i386/kvm/xen_evtchn.c
index a5052c0ea3..07bd0c9ab8 100644
--- a/hw/i386/kvm/xen_evtchn.c
+++ b/hw/i386/kvm/xen_evtchn.c
@@ -1097,7 +1097,7 @@ static int close_port(XenEvtchnState *s, evtchn_port_t port,
 int xen_evtchn_soft_reset(void)
 {
     XenEvtchnState *s = xen_evtchn_singleton;
-    bool flush_kvm_routes;
+    bool flush_kvm_routes = false;
     int i;
 
     if (!s) {
-- 
2.37.3


