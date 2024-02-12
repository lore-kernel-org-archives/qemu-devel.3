Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CDB6C4829B
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Feb 2024 11:51:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZUpx-0005dP-5b; Mon, 12 Feb 2024 06:51:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ross.lagerwall@citrix.com>)
 id 1rZUpv-0005d2-48
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 06:50:59 -0500
Received: from mail-sn1nam02on2068.outbound.protection.outlook.com
 ([40.107.96.68] helo=NAM02-SN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ross.lagerwall@citrix.com>)
 id 1rZUpt-0003eO-8J
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 06:50:58 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xv7JQRbfXmqzizc150AkliZzwpV6jCoCNsqZ3iaR0+dUdy1nqBolPW2FfeTdAmAV6fhDzLTNqqKpPlOxn8gXiPpreurCBvonyC+0vmtSIJeOiivHeHN7DGmj1V5YuowQPYC7ooUP75yEl/h+S7IQpCgc660GlbgY3e5cgUwUAGKap/CWDRKdyt5xjb9ZW9LZdqLw1ALQlxxdPCa3QwtKCVkzTty1SvixMP8qA4fsm4JwewZO8S4sd9V+h41/byFBL+7kUaUlHclX7cXKJKzvmBuCrr8MJGG4fWUjMdSf8msOr8FDfTsNJL952nPQMBnOprL0nwcnXlo0cINl6h0Dng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LFcY0SL5EkHZ8WvjvMazWc2z/s9DQLSODD18fh5f+XM=;
 b=aLd0BgOLwFpwV0ZTkDECV/6MEOPgwj6BUgjGr9A1dHBl6MVputENey9F/9gYsgPlaBR9nBDkyFKybCGFYZ3MffMacWDGyKqJrjDYBLa04t67Nv3eSDT9zTfWQ1ukfwFVxzXRb8UQApFNkcD9F25YgNtUVHDDAE3yK3K5TYSMM4i6OI/qP2jvQwuGCiCZSi5FCJBsLyhgHmjPbRrPs28CsL7fVUe2y2Q0YmYDNB9yXTC6MchA7N6KgzzIWeOO8gxgBpE1eiqECLapJuJnbnXyWEFOZqk2pM6Cjxx0U3+Lo1eAr0tyf2/Qu5vHDK0ypc2KHeUgv790kY2vDgqyLOO/Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 162.221.159.70) smtp.rcpttodomain=redhat.com smtp.mailfrom=citrix.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=citrix.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LFcY0SL5EkHZ8WvjvMazWc2z/s9DQLSODD18fh5f+XM=;
 b=p9Wk6QlZXZGB3+nUa6/sW3+hlhLMct5xJaL26vm+VgnX7CpqOpiHaDs33NZUc2vVpeLLg0xgoawCnJYxOuMDZVKv0HS/FAyTh1TCSYx5Q0TAjGYwudsnIMzAD2kjo9FmT9FFMZ7D79fN+IRVL8XysyLjQQP1e2aMiEDG0IzrNvU=
Received: from MW4PR04CA0097.namprd04.prod.outlook.com (2603:10b6:303:83::12)
 by PH0PR03MB7083.namprd03.prod.outlook.com (2603:10b6:510:29f::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.33; Mon, 12 Feb
 2024 11:45:50 +0000
Received: from CO1PEPF000042AA.namprd03.prod.outlook.com
 (2603:10b6:303:83:cafe::49) by MW4PR04CA0097.outlook.office365.com
 (2603:10b6:303:83::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.38 via Frontend
 Transport; Mon, 12 Feb 2024 11:45:50 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 162.221.159.70) smtp.mailfrom=citrix.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=citrix.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 citrix.com discourages use of 162.221.159.70 as permitted sender)
Received: from mail.citrix.com (162.221.159.70) by
 CO1PEPF000042AA.mail.protection.outlook.com (10.167.243.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7249.19 via Frontend Transport; Mon, 12 Feb 2024 11:45:50 +0000
Received: from guepitiexch02.citrite.net (10.240.48.56) by
 MIAPEX03MSOL02.citrite.net (10.52.108.224) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.20; Mon, 12 Feb 2024 06:45:49 -0500
Received: from guepitiexch01.citrite.net (10.240.48.55) by
 guepitiexch02.citrite.net (10.240.48.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Mon, 12 Feb 2024 11:45:48 +0000
Received: from lcy2-smtp1.eng.citrite.net (10.27.216.154) by
 smtprelay.citrix.com (10.240.48.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12 via Frontend Transport; Mon, 12 Feb 2024 11:45:48 +0000
Received: from rossla-lxenia.eng.citrite.net ([10.71.11.206])
 by lcy2-smtp1.eng.citrite.net with esmtp (Exim 4.94.2)
 (envelope-from <ross.lagerwall@citrix.com>)
 id 1rZUku-005TMN-8g; Mon, 12 Feb 2024 11:45:47 +0000
To: Paolo Bonzini <pbonzini@redhat.com>
CC: <qemu-devel@nongnu.org>, Ross Lagerwall <ross.lagerwall@citrix.com>
Subject: [PATCH] main-loop: Avoid some unnecessary poll calls
Date: Mon, 12 Feb 2024 11:45:41 +0000
Message-ID: <20240212114541.1440728-1-ross.lagerwall@citrix.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AA:EE_|PH0PR03MB7083:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f02ff1f-186c-4a57-2156-08dc2bc02947
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gAj5fznHehDvceLe/hn10qBJ+R5RKot/RVj0sRhOijFfz7SlP7DNZGj10/v/Vy0Y8rNN/M8en3ocf59Air+QppD2D2468i3zI6wG75w3vRcP0oYrjbyhyPJvytOpg49iKEeR+g6QqTHR+GykBIqkySAwqRBmJgHtD+sYJiQdDUZzB4wrxJqQr9IF91dDptX0QhIienqp4Bf1Wy8dDKsIl3T26EFgb4lCWuRS+uKlJjOIHd4sZUUNfDd5J+f5Uc07QA30HZqqslekJ7uw1L4nn6Xe01Ilmo/xpI2h3t4ZNEkwYIdp6FYPg1deXETB1qzj/YJXNWD4GgUXhk84uAQ8uL98IthradUEa0E/DDY41QKjCkMLRveJuP2Vr8UpAfGWsbHKbZX1EGb3WPMS9zhggPlH4ExhyPgjFfq13iVMGJv+sv2Dz63vakyVTgtlhxFPRWymgjtc0L12QV/JavgMd1xfgTd6MtMldt7FhjANDTKz1/49GOXwzVHor58QLfcgShs2C9uvjp7vV73u8/LXEeGcc+qGGdB/Pyg5NFiWv0+0urtGBRAnvGOB405YwCc31T3hx0n7bvFCWbrwihddKlDKAqr2lfC0SOp4NuIcWQ4=
X-Forefront-Antispam-Report: CIP:162.221.159.70; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.citrix.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(39860400002)(376002)(346002)(136003)(230922051799003)(82310400011)(186009)(64100799003)(451199024)(1800799012)(40470700004)(36840700001)(46966006)(8936002)(4326008)(8676002)(44832011)(5660300002)(9786002)(2906002)(336012)(2616005)(83380400001)(26005)(107886003)(1076003)(36756003)(82960400001)(81166007)(86362001)(356005)(82740400003)(70206006)(54906003)(316002)(6916009)(70586007)(6666004)(478600001)(41300700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2024 11:45:50.4448 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f02ff1f-186c-4a57-2156-08dc2bc02947
X-MS-Exchange-CrossTenant-Id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=335836de-42ef-43a2-b145-348c2ee9ca5b; Ip=[162.221.159.70];
 Helo=[mail.citrix.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB7083
Received-SPF: pass client-ip=40.107.96.68;
 envelope-from=ross.lagerwall@citrix.com;
 helo=NAM02-SN1-obe.outbound.protection.outlook.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Reply-to:  Ross Lagerwall <ross.lagerwall@citrix.com>
From:  Ross Lagerwall via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

A common pattern is seen where a timer fires, the callback does some
work, then rearms the timer which implicitly calls qemu_notify_event().

qemu_notify_event() is supposed to interrupt the main loop's poll() by
calling qemu_bh_schedule(). In the case that this is being called from a
main loop callback, the main loop is already not waiting on poll() and
instead it means the main loop does an addition iteration with a timeout
of 0 to handle the bottom half wakeup, before once again polling with
the expected timeout value.

Detect this situation by skipping the qemu_bh_schedule() call if the
default main context is currently owned by the caller. i.e. it is being
called as part of a poll / timer callback. Adjust the scope of the main
context acquire / release to cover the timer callbacks in
qemu_clock_run_all_timers().

Signed-off-by: Ross Lagerwall <ross.lagerwall@citrix.com>
---
 util/main-loop.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/util/main-loop.c b/util/main-loop.c
index a0386cfeb60c..a2afbb7d0e13 100644
--- a/util/main-loop.c
+++ b/util/main-loop.c
@@ -145,10 +145,16 @@ AioContext *qemu_get_aio_context(void)
 
 void qemu_notify_event(void)
 {
+    GMainContext *context;
+
     if (!qemu_aio_context) {
         return;
     }
-    qemu_bh_schedule(qemu_notify_bh);
+
+    context = g_main_context_default();
+    if (!g_main_context_is_owner(context)) {
+        qemu_bh_schedule(qemu_notify_bh);
+    }
 }
 
 static GArray *gpollfds;
@@ -292,11 +298,8 @@ static void glib_pollfds_poll(void)
 
 static int os_host_main_loop_wait(int64_t timeout)
 {
-    GMainContext *context = g_main_context_default();
     int ret;
 
-    g_main_context_acquire(context);
-
     glib_pollfds_fill(&timeout);
 
     bql_unlock();
@@ -309,8 +312,6 @@ static int os_host_main_loop_wait(int64_t timeout)
 
     glib_pollfds_poll();
 
-    g_main_context_release(context);
-
     return ret;
 }
 #else
@@ -470,15 +471,12 @@ static int os_host_main_loop_wait(int64_t timeout)
     fd_set rfds, wfds, xfds;
     int nfds;
 
-    g_main_context_acquire(context);
-
     /* XXX: need to suppress polling by better using win32 events */
     ret = 0;
     for (pe = first_polling_entry; pe != NULL; pe = pe->next) {
         ret |= pe->func(pe->opaque);
     }
     if (ret != 0) {
-        g_main_context_release(context);
         return ret;
     }
 
@@ -538,8 +536,6 @@ static int os_host_main_loop_wait(int64_t timeout)
         g_main_context_dispatch(context);
     }
 
-    g_main_context_release(context);
-
     return select_ret || g_poll_ret;
 }
 #endif
@@ -559,6 +555,7 @@ void main_loop_poll_remove_notifier(Notifier *notify)
 
 void main_loop_wait(int nonblocking)
 {
+    GMainContext *context = g_main_context_default();
     MainLoopPoll mlpoll = {
         .state = MAIN_LOOP_POLL_FILL,
         .timeout = UINT32_MAX,
@@ -586,7 +583,10 @@ void main_loop_wait(int nonblocking)
                                       timerlistgroup_deadline_ns(
                                           &main_loop_tlg));
 
+    g_main_context_acquire(context);
+
     ret = os_host_main_loop_wait(timeout_ns);
+
     mlpoll.state = ret < 0 ? MAIN_LOOP_POLL_ERR : MAIN_LOOP_POLL_OK;
     notifier_list_notify(&main_loop_poll_notifiers, &mlpoll);
 
@@ -598,6 +598,8 @@ void main_loop_wait(int nonblocking)
         icount_start_warp_timer();
     }
     qemu_clock_run_all_timers();
+
+    g_main_context_release(context);
 }
 
 /* Functions to operate on the main QEMU AioContext.  */
-- 
2.43.0


