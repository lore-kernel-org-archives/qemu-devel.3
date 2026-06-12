Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95B59CD98CF
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2026 16:56:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wY5BH-0003uU-Dg; Fri, 12 Jun 2026 12:56:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1wY5BF-0003u9-OA
 for qemu-devel@nongnu.org; Fri, 12 Jun 2026 12:56:29 -0400
Received: from mail-westeuropeazon11023140.outbound.protection.outlook.com
 ([52.101.72.140] helo=AM0PR02CU008.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1wY5BD-00044J-T5
 for qemu-devel@nongnu.org; Fri, 12 Jun 2026 12:56:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=peulTM+J6FZ6kCobf7+n5ePKKA+KUCuNmBVu5tDrx1OYBl5CPozrPdj7AvsEhHcSHI1SMOMlwJuliHZI+/jlQllLmHq0bOj3nozRO1bOhXjAfHb0Vur+IDNm/yaKbx1CuKzyektPqBg6lEpPpXTUUexHWJhSMHjqW3t91KwYqNHb0EeiUkSmQ/ahyQ8h3EBO0N2Ze6JEm9sVTaUUsJgRTxMmFdYsoXBIt+XG/UFf7X2CBNqFAoDnomHIm58GNILyq2FT5UNs6FoDXqwZPQ6xYP2MySlyZwT646aRp0Zecnt73ukfqGrvVc4zjyknmirc9pHpMd29oqF45qUUv9QLBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l7alPozeLzAN/DwEt8wzKQzaI2aDJHA52sHdzvZDKOY=;
 b=Ox768pZUcWt357bJ7+Srq7FQaWnarQZms3TkZ503LNp20rHE0BlrKONa3jjXIwykn73DT2BAyQrt0Zu2h8TQW3pCerhWpyoVpIih/fkG/IoxP4H3nGXXK6AtNo40rP0iu3CgKu+5Iex9fRLO4/deRFuYdmAgWPNeFYFB1KC28r/Vx9Xg2gwd3mf04OjQky+Df5XOxWs/EC6Lut3VMs7u4Oih9xJRIc2oYJz4JvPGtEQVDx7t4B2obDRSktR8mBKyPJOws2xL+ZegjVt+bZbu7Sm/JTtGzx2usb3dEJiEENbNko/uDFDE+wmLuANdGGWi9mji/slMK7HTcYE2qbzzQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l7alPozeLzAN/DwEt8wzKQzaI2aDJHA52sHdzvZDKOY=;
 b=zcgmcYYXafGGaIp6DVUCw33Hk2eZWHTzG8d1NF8Y5nzrYgrnQRPlCnQazHEGTxB88l26hOSSsPEN1PW5wYmiV1C+hmdx5gh0Q5AD7YcfoFQW/ePTB1MhmGKla1+XxT7H+EdelgjlwuXmCEeNumzbUEO9j3Hyey+WJydenSBFQyPGCF+A0AM9HDXEHli8pYzmuKIid18eCfu2a3Es93E6YFvs5I6KgcIgimY2IB28BtypyJoizFZKlLJK40CuXj7iaVccENgkSRuNLDm3WBkNe9boEilJ7XaNRjREtmWZn1sq3Oh5t/rxlMGoamk17+bT9omKq/Oytk41e3WvDd6BOA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by PAWPR08MB9097.eurprd08.prod.outlook.com
 (2603:10a6:102:330::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.18; Fri, 12 Jun
 2026 16:51:22 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%5]) with mapi id 15.21.0113.013; Fri, 12 Jun 2026
 16:51:22 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, sgarzare@redhat.com, farosas@suse.de, peterx@redhat.com,
 maciej.szmigiero@oracle.com, bchaney@akamai.com, mark.kanda@oracle.com,
 den@openvz.org, andrey.drobyshev@virtuozzo.com
Subject: [PATCH 1/5] migration: emit SETUP notification before CPR
Date: Fri, 12 Jun 2026 19:51:06 +0300
Message-ID: <20260612165110.431376-2-andrey.drobyshev@virtuozzo.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260612165110.431376-1-andrey.drobyshev@virtuozzo.com>
References: <20260612165110.431376-1-andrey.drobyshev@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR0202CA0021.eurprd02.prod.outlook.com
 (2603:10a6:803:14::34) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|PAWPR08MB9097:EE_
X-MS-Office365-Filtering-Correlation-Id: 17045109-f207-49b2-b0c5-08dec8a2d51d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|52116014|1800799024|56012099006|6133799003|22082099003|18002099003|38350700014;
X-Microsoft-Antispam-Message-Info: +a4fut81PBG+tbk8nZXf+rErfVLCodavJTw+qLHer75yrN9eBfN+2Rc/pYH6SPk+XXcLJVv8/YVmVUNVYZaQYM4IBcrui9NIbG8xBQrpPDZugku7GLp7fqUAJZhBoBui16LAPQkKiJvS7Y03vKqG7/FgddXhMSY0fTVD6XKVJdWahS71G7Z4reKGE3lOjNafY88JeJxaP6nMw6LWUyiEb9U/dAGdnZJlhPRYm1GL9FCu76oAFT200CwTIqX7NommRB/tELudEAXyylX7JOMG4Jdu/4U+C6krBaJCS2MOHhDFDccexSe+WdPJHKjiAvfm8qJ22K/+w34VC93j2boK7bmYsdQegvl26y8qHpUnpaMCcxk0D666GMrburfT18H8r3VdWKXFqG//8V2PipFga55xktkD8B3bJHn3PsAHXlgWaFA4yzK4eNyCxvtPsJJJGVa0NfwlMHKy1uqdXTBa7wVomGDlezhDWe7niiT7FWMv2xYtC5IPtD3GlQx9pSX1GEvwddZ88LBjCSEtsyus3DjG1rxMcW1pxNSh1VGFnIg9cDJD2ABSFAmorLzGZMLpQehHoi5sA9atoSEWZieILBFKBUzZXgTli+fysvybFb1q3aJ7RgsYCqQuYYFtlp7keyPOfdPZW1TxNviRaV+ItkdcrL1fLyYz0uVeqh18HUcwVGfhS8dgoLEAUuhlWBxEBggLjgdXRWQwj3EW4zJracun04zda8Xh64CZ4Y4U7BLgN5pjTErmzfXxOLXXg33Z
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(52116014)(1800799024)(56012099006)(6133799003)(22082099003)(18002099003)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fC+jLnvn0ZkDogiJWIm1D6Etaa+bhhJcDjA6G83BmriTwHI0Ud2y7LM0Wc1Z?=
 =?us-ascii?Q?/irf9RvnovvX/UMqsOCtCgIc06smWtiyu5i3CZ+iR4pXu6zy1w3rF1L6RKsz?=
 =?us-ascii?Q?QCwkbwQhTCEFsGfgoc7G8YbHdxxIdFoVqnSNWmp2ZATOuJgZxUY43UjKWgbr?=
 =?us-ascii?Q?8/bAKH5PThxKiHHX+8KneRZaIW+VdbqqjNBwVGNgE82Gdbm5GlHyAHsTOYLY?=
 =?us-ascii?Q?JjpYPYu3iOj5m1nGMgSaV4chui5LZcWxZ+PDOiMROtaM17IsQtZbI241Do/f?=
 =?us-ascii?Q?3hpxixuBNQi8/bFhupY+o4Ecuz+QHu+AuBYvcv3byXPut8Yb+Z22WUCROQn9?=
 =?us-ascii?Q?Sivz5ZtYRLjpnJf4gdt6z2JBzeUbb1W0LvQzXp/AaLJLyWWJ1Q6pjKlSjQow?=
 =?us-ascii?Q?1qYg8Pd4CyPy4fi3R0V8wrckGLQW3W4/rtVgbQoARg0c1mGaZ+zqk16DcGGY?=
 =?us-ascii?Q?2fx4Gh1oTobWmGghYLDrdURHYeBylAgLvbG06RrbVZ6+QJb9wvk3GTOcQ1/y?=
 =?us-ascii?Q?wgv/oOPL50cLoDhJm/uYv+cwSL6YlcxZ8zcpTsGlCcQIWK4sFtGrtPeAooE0?=
 =?us-ascii?Q?v1UINbtNKniGfS9MEFWvhkw+0kf9hoP8B5bhnOl09OB1HY8iRloDa3VgO2Po?=
 =?us-ascii?Q?8hLWpv56Z+7cioJzePLSueIim6U6KGEevPHJkXTuuF+MucZqcThpBbLMBKTi?=
 =?us-ascii?Q?XwUJA+Sa8IBPau50/+/NEHimmP6SZ3u74tcAiJKLFv1Scab1KwsnYw+yF1hS?=
 =?us-ascii?Q?G1C6x8rXYCtKCagrxoLoXQ0q8p+vPPNZFijM09Pu1F1PiXhybqL3mDF1nI45?=
 =?us-ascii?Q?H8/5r56KQoWtnlEBRB1VoeHgLkPHeFG4JSdf5+UuQFFD/YhcH3/OP/Zqmc9K?=
 =?us-ascii?Q?SUGUXjDDs3bxMBQo+Xj6R5te34VIdoSVT045+aDZjb0dnFSKZQ79NaK6g+CJ?=
 =?us-ascii?Q?dEqe7HdtWB9p0a0PokVgJivrgY6jmXWVhQMJzc6+UjsJR7yTtj2Vd0WyTHuU?=
 =?us-ascii?Q?pGCVrh31kCcTrwn3TM9gapEFS8cfAA2C/c5aSIoxPmd04o98Uvr9zzBCQJBl?=
 =?us-ascii?Q?hHg7pnMOIIj7TWfX9natE/hvO0vLocq8QCXibtH8WMXeaCAZ6A+0bE/ffpm/?=
 =?us-ascii?Q?7F2LDU2s2ZGX0nUClEjumRUMlpZCSNgSNvkoS1sRBo0RuhAam3II+0ReKPXy?=
 =?us-ascii?Q?5LDQ5j0ryP+BKZb7pSEgBzSYgFpBTdjR/2jCQlKNG1YSdZDpGv1NrXqqUrFs?=
 =?us-ascii?Q?dJmfTCXPzP9nzMqXmUyPIvm3lpOxxlmMfC2WWoetksbRnmehlM2j2t/lrM+U?=
 =?us-ascii?Q?wiRLwceXs2rqz0lGYH3+1JofAZp6R4c6hlSXCqwRISJof0xTHWjpefZg3duE?=
 =?us-ascii?Q?MaaNDZOG4rbnQi02Txjb6i+tvhir9F+Er4IzFiL8mL89EBocCWnZ5gl4y4Uj?=
 =?us-ascii?Q?W99NQpmdWw6mqh/lkQ4EAwFOIY/d+XjcHq8aKJdnP86j8oFiJ3kxGr4q/XEV?=
 =?us-ascii?Q?MEPqaUYvkD+lObtdL83uawM/w+6JlsEhnvKwdK0xMehO2zL2O1qTeqHwBMHn?=
 =?us-ascii?Q?R+yb4mjMv1amGxIRSFPe20xyy6VmkgQuJuvdm3bY2+bLRKXBj/kDSTP6BEO9?=
 =?us-ascii?Q?EYnfyvhvQwMp+T5/167aZA4fM02jK/dECA8iFQEyKJdXO0H3mYWkHW9Ge0sC?=
 =?us-ascii?Q?b60o69X5mBpZglxhjXOGB/agBBGK/wab6EhZCF+zhLEMQtj64oGbF1eWZIfy?=
 =?us-ascii?Q?JaYSpTwDT/80FVMa2mzc/N7IKXirfzY=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17045109-f207-49b2-b0c5-08dec8a2d51d
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 16:51:21.9818 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UxBVDFiUUxuHrOUP21jWUKDki+GgWcKw+z3M+b2DlZJ7Xc/iBwFn/siSMAY+qmARLqOveuzmgwzG9w4Z8okVqx4Kbq65oD871ldirhKBy5Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB9097
Received-SPF: pass client-ip=52.101.72.140;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=AM0PR02CU008.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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
 migration/migration.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 074d3f2c697..3c70467d314 100644
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
@@ -2117,6 +2130,11 @@ void qmp_migrate(const char *uri, bool has_channels,
      */
     Error *local_err = NULL;
 
+    /* Notify before starting migration thread and before starting CPR */
+    if (migration_call_notifiers(MIG_EVENT_SETUP, &local_err)) {
+        goto out;
+    }
+
     if (!cpr_state_save(cpr_ch, &local_err)) {
         goto out;
     }
@@ -3893,11 +3911,6 @@ void migration_start_outgoing(MigrationState *s)
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


