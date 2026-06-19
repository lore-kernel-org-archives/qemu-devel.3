Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDA22CD4F26
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2026 10:56:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waWsl-0007kI-1X; Fri, 19 Jun 2026 06:55:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1waWsj-0007k3-Ss
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 06:55:29 -0400
Received: from mail-northeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c200::1] helo=DB3PR0202CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1waWsh-0003Ts-Tm
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 06:55:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MTzMpo5Qr+aN5kn1VhS2vEzW0ByMP5bFMFp/ryXnXopzhgM/oniu92359A1sTHZTcxtVXxw8r2DwKkQbP89i72I7bdkfXgOlIh3u+XCznpfc1km9HYKsHGevx7Mj080cRutTg4PvpBpdbE50FuQLAZmyoinHaxmaRIHGdfzc025uRcXIcWqoa9R6obbU/KOXOgh0zOU56d0Rs7qi1MyPrbf58AunerO9LhDdorm6jeVoy5TDUuzUKa+M8FT+r0lPfwbKKsM2e6MVzfkU9nmqW0nK5i7KDQ7Yv0soyQOY8TLEce1ZhT8j9MYhwfZIqnKpP0ecP6Jp2XQ30zZdVTKJGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WtWc0sD33i3nyv2i0nmxUFZDE06JDErH+p3msnaWq8w=;
 b=E5OMTuwLLw72v3uW7siE4okxITjsF8nx2OPUalb6hjoDAV5UIWmC3qO0sk67ht2Q9oSaZHVNfaAQ8rcO4eXTWRtZmG6G67bseesSuHtFMsZ7bZhNFd5Id6OO3rdL7wVYQRWxMpMiGFg+llYv1Ec3XedUGsH1yrHAJnWgyb3AoBCh0Lx0M303Z3IF1hq3+Xy8T03kVeOfX15Gps+oDgtdq+UqxkCeO/knI1T71tT6+6ByQi/gRwbTnB/Kb41Uv4TfyMYYPdbB90/G6uORJXvXAmWcQzdKMCE8HbuJeqPToxGBGGN6e8zBFO2l4wZrIA1cw1o0xkpi6Yj0+NpBXDTZSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WtWc0sD33i3nyv2i0nmxUFZDE06JDErH+p3msnaWq8w=;
 b=kkRtAciAIEQg8gku3TddW1me8LG5XpmlTJOshpTfl0YU2VllgWAXyTxUmoAVnTI8q/LDgmEq9XwC5WNSfLkfyEihQ7t6wuKip/XcqPdewZodq8MX7g/xHvaXd5NBAqSSdMmxqeWW03aEeJUieY8mze3OypISxwWLgvrw6nVp1TMc/QSV5MYrPMXYHHyZNdhMcqrtS8etb8Qh3s7V7ZBTbKayGXkZqSr33aa7SUZ7Q4RYVBQ2bdK1/VyuoT3KDKchszEfVQqQhTlWnUPapYIuFitvIO9mUTtWVKeEp3MHsB9XnqnmWIEh2ff/5bJwu6F6vbRUox88IOiYP3F19DBJ7w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by PAXPR08MB6576.eurprd08.prod.outlook.com
 (2603:10a6:102:15a::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Fri, 19 Jun
 2026 10:55:23 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%5]) with mapi id 15.21.0139.011; Fri, 19 Jun 2026
 10:55:23 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, sgarzare@redhat.com, farosas@suse.de, peterx@redhat.com,
 dongli.zhang@oracle.com, maciej.szmigiero@oracle.com, bchaney@akamai.com,
 mark.kanda@oracle.com, den@openvz.org, andrey.drobyshev@virtuozzo.com
Subject: [PATCH v2 1/5] migration: emit SETUP notification before CPR
Date: Fri, 19 Jun 2026 13:55:10 +0300
Message-ID: <20260619105514.128812-2-andrey.drobyshev@virtuozzo.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260619105514.128812-1-andrey.drobyshev@virtuozzo.com>
References: <20260619105514.128812-1-andrey.drobyshev@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VIVP296CA0089.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:35b::8) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|PAXPR08MB6576:EE_
X-MS-Office365-Filtering-Correlation-Id: 49cb91da-252f-433c-ce54-08decdf1434b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|52116014|376014|7416014|22082099003|56012099006|18002099003|6133799003|38350700014;
X-Microsoft-Antispam-Message-Info: hARlm8zCh9LhkhkxhUgaM1+UvsS9uYkUwpuCASgWTWKgCPoWtJxzIMp0BbVOijAjlcAOW8IP0o7vj4ixWUyTJAB0LzrAkqkID85CSjfLTY2mrSKR4+y8pbuLosy8QICXchkBPx0BijuGPChHGQ4aVURhjFYFVJGT3pO9In8v9zZL1Or/6W2zx31hfAI7vDc/yTsBgDGwO8P12xf1vNcUcB+SEPD8E4xfirP1RgrutmnyJVhI9RF7l8FlOlRxaIg8UoBwavH8+qYj+98/z+0g3oeVonHHlZW8HghELzk1c49M90mI+w8GHEEuDqlJuX/Un8Dyg6pDhtKHE3YLEzZysMTa+T8e/dNPUSPZG9E8sGYCyY5XSAj4qQKnQKQysZ3lzrGeysKpr2jyDZSOjjcwyk2WO/PUodYIqswQ5XGoA7rxatxXWaxjay7FIgo+8a0BkNJJnxY1VJ9NJeGfj1OelEpxC7/T6W9W2/uHEonE5uaWqczf+z/8wHk6HrvOSVqPLBxt2iTV5OLyFyA70VAnsW2bVlkKcnWs0g3oQPMO1mHyFXka5O+UQRAG+IiDihRek0V2S3dpBdcdampmOYJBDyuJYj3AOCzd55bNOEaeSVPBcSvN3e2mw/tNLDrMMb7PnJg01kqQQp7QImh2H/q4gXOMAn5Myi5AhRKR0G3aRyLwrbPbryu5x8HI6RMncrfPKFWjPo31ByYg/9lbQbQwWtLlhgvc5ZujF5/AF2Uz8l4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(52116014)(376014)(7416014)(22082099003)(56012099006)(18002099003)(6133799003)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dA/AMutrZLdyMy8r8pXVgET+vZENz2PlE7QkmsGTkpBh5cppHbnSBFQhFZC/?=
 =?us-ascii?Q?rguyAjkh5q6TXhcXj7FaiRpz8t5adAAnUQoEmXxuche05dArJIV01ys/SSfF?=
 =?us-ascii?Q?gEFrSQDpiTUyUbnVzBNV/V+XtG6HriUawu7P/zBN7LfH2z/oyfTZ+z6XMvP/?=
 =?us-ascii?Q?9GoY2l4zikBmsux2zmZhkOdnO7tHijVdvDVOQ9CwSM7Wsn2VEXewPsUz6tCr?=
 =?us-ascii?Q?9ZXwjeQFHS+FJVFFVdj+SPgnXvDs+LJp0tR6NS0JJSw+c776w7YAR+lG7eax?=
 =?us-ascii?Q?kN1aGqMvfHmuzrZSb26p5StoMclAlvGa6zrDc3tiKBzB3L4gM2tfZ42c+ZDM?=
 =?us-ascii?Q?TbqBHp1OufoYE5hcVQr1uP6rgLVCQLYkmmiZ2UuHIkJ0ZoBt4XX6OzjbQx5o?=
 =?us-ascii?Q?RURJnPjX76I/fuGfr0mcjnRCjfW5MS+1GhbL1NHlCdfyFTRZt9VxzB2fFHqh?=
 =?us-ascii?Q?Djch6ntgb8VyxEJkLAMrdC0X1xoUYx0uGv4oZ0uhZVJIPKjf2g3qtq3wNXOG?=
 =?us-ascii?Q?vz99v9m9MdohJAT9bOFfNkTLoAE9BflZH1TKr6/Si3ixs4uFI0xABSvGJ7Bh?=
 =?us-ascii?Q?TS91JoXmuTRgOtkbC72G14LB+c3YuawjUJry58WjYe3B3aC6T36P56RMBC+v?=
 =?us-ascii?Q?zmlyJFKiynGcrYhqU3NmirXeQDsrguZck/At+GgkjnDExH0Mi8Fa2lTXb9B9?=
 =?us-ascii?Q?pz6P4MS3wn7wf00apSc3RAgNau8skQUYfPtcn5OfFiYJAjPZyTMQc3zKfvhy?=
 =?us-ascii?Q?YK1jz+M/GukNn3Nu0a8baXs2FejwJHNMZzawxenO2bW8w/8C1CWP5EgxYnXX?=
 =?us-ascii?Q?hMxxr3Y39RMPlUYguNA3X3c9+1Yj0cPKK1000ZRwRW8Wwqusj9FHQLzuPFaN?=
 =?us-ascii?Q?cu6kPMg920OdYiFYBvMgc8GjTzSAWQ+DqX1kT8ZEpaVtDevl8UUFyYoUqD1+?=
 =?us-ascii?Q?eAzhTjvNJQVmJBnAp/sYIyBLaNEInqL0+aIJp0dQq5JGN/QdhViO4Dk7CIGv?=
 =?us-ascii?Q?gcyY3poP4zI07FYtqSYEt8iDxOSDpRySI2Z1rWzO/8pj9387SMDdZZj3penx?=
 =?us-ascii?Q?EnzhkmCkXb5n+uc+IjMwEY0w68Ge3FrMJccPQ14D0WViqYL5flg3ymvnwD2y?=
 =?us-ascii?Q?6D3uEYawdSWpfetIi6vzKn/pakJRZsGWsFwm5jAb7uvd89dv/Emz8G2GceeC?=
 =?us-ascii?Q?QGMS+fmbV2gUgyHR3ZXSAwe33SS4IbDk+7F144NhP/3Nz5bjQrA8uWWYS1zg?=
 =?us-ascii?Q?9mP8s/iZx1g+NkDcy9XV2DHdUvGu35iatar58dnYKJlXDdSI4mMrCUpBbDTI?=
 =?us-ascii?Q?AIgwtEuWFuqTaya46uHeUTykSUvG4kRQGfCIS+V4u+Q39rUd7dMEYLF1Kq5C?=
 =?us-ascii?Q?CoWyiFYi0QmsqWogFcFF77lKjRjZl/VwMWRnCDNA2ZClIwIQbFGI0dEbjfni?=
 =?us-ascii?Q?zi2OawjWLQpjvnvTTFvyFVsaR6zJlAOSMyDIAmkkl9ZUlJJuylkBe8Vmkk/1?=
 =?us-ascii?Q?ugbfpWS7rIzefZ8WtaQx3KstMFTcPbQ9+IeLMn5X6D7RtZ9G9a0VOltNUzHH?=
 =?us-ascii?Q?aBwW320W8oxAJ28LlP5l3ViZELYcYhifuQGBc2A+LahO0X3CNZ8QwEp3M1YG?=
 =?us-ascii?Q?uwU6pCF+/njzskxvqKOaufP4Ms6TvIiIrBfUZ+xEUfgKVDkjKGVyzJtnyxQK?=
 =?us-ascii?Q?pMLinHlwdJTlwdmZrTa56+2hIqgKb6D9NZ78XlQrCmGIg8D2UCPbMBSwX4OA?=
 =?us-ascii?Q?zjwFUi1xyGAPTbhSIp72NdHciCXfjyM=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49cb91da-252f-433c-ce54-08decdf1434b
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2026 10:55:23.4092 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FN0eKoxwSw+SLkOPZPZzF0GZklhzzpIaYSPRnaY4RUgFLGl8yWv0KWBvrlw864K+V8Co9G1Qpf9yg/JR91JRz8TJ7tYhjbtZZbVBSuSNxK0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB6576
Received-SPF: pass client-ip=2a01:111:f403:c200::1;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=DB3PR0202CU003.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

Devices register their own callbacks to MIG_EVENT_* notifications and
process them accordingly.  But some devices, especially during CPR-style
migration, might need to be aware and process SETUP event earlier on.  One
such example is vhost-based devs, as they need to call RESET_OWNER ioctl
before the target (in the cpr-transfer case) tries to call SET_OWNER.

Let's move SETUP notification to an earlier place in qmp_migrate().  Before
this change, SETUP was firing shortly before migration thread creation, and
FAILED notification balancing it was only fired from
migration_iteration_finish() (ran in the thread).  But now by moving SETUP
to earlier we widen the window.  Hence let's also add FAILED to
migration_connect_error_propagate() and the special CPR-related case in
migration_cancel(), to balance things out.

This patch is a rework of the change originally proposed by Steve and
Ben at [0].

[0] https://lore.kernel.org/qemu-devel/20260128-cpr-tap-v4-0-48e334d4216b@akamai.com

Originally-by: Steve Sistare <steven.sistare@oracle.com>
Originally-by: Ben Chaney <bchaney@akamai.com>
Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 migration/migration.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 074d3f2c697..20eff9dbdcb 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1471,6 +1471,13 @@ void migration_connect_error_propagate(MigrationState *s, Error *error)
     migrate_error_propagate(s, error);
 
     if (!resume) {
+        /*
+         * Emit FAILED for every pre-thread failure/cancel that ends up here,
+         * to balance the SETUP sent in qmp_migrate().
+         */
+        if (migration_has_failed(s)) {
+            migration_call_notifiers(MIG_EVENT_FAILED, NULL);
+        }
         migration_cleanup(s);
     }
 }
@@ -1530,6 +1537,12 @@ void migration_cancel(void)
     if (cpr_transfer_source_active(s)) {
         assert(migrate_mode() == MIG_MODE_CPR_TRANSFER);
         assert(setup && !s->to_dst_file);
+        /*
+         * This path bypasses both migration_iteration_finish() and
+         * migration_connect_error_propagate(), so emit FAILED here to balance
+         * the SETUP sent in qmp_migrate(), before the VM is resumed.
+         */
+        migration_call_notifiers(MIG_EVENT_FAILED, NULL);
         migration_cleanup(s);
         /* Now all things should have been released */
         assert(!cpr_transfer_source_active(s));
@@ -2117,6 +2130,12 @@ void qmp_migrate(const char *uri, bool has_channels,
      */
     Error *local_err = NULL;
 
+    /* Notify before starting migration thread and before starting CPR */
+    if (!(has_resume && resume) &&
+        migration_call_notifiers(MIG_EVENT_SETUP, &local_err)) {
+        goto out;
+    }
+
     if (!cpr_state_save(cpr_ch, &local_err)) {
         goto out;
     }
@@ -3893,11 +3912,6 @@ void migration_start_outgoing(MigrationState *s)
     } else {
         /* This is a fresh new migration */
         rate_limit = migrate_max_bandwidth();
-
-        /* Notify before starting migration thread */
-        if (migration_call_notifiers(MIG_EVENT_SETUP, &local_err)) {
-            goto fail;
-        }
     }
 
     migration_rate_set(rate_limit);
-- 
2.47.1


