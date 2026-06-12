Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFCD8CD98CE
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2026 16:51:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wY56Z-0001dH-6Q; Fri, 12 Jun 2026 12:51:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1wY56V-0001cM-OJ
 for qemu-devel@nongnu.org; Fri, 12 Jun 2026 12:51:37 -0400
Received: from mail-northeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c200::1] helo=DB3PR0202CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1wY56Q-0000Xb-Ji
 for qemu-devel@nongnu.org; Fri, 12 Jun 2026 12:51:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bF7zPWA8EOE1I/yw7U3hWA0SbMYaP1X6q7iJ+iit1UbGCxlB7haaDkrZELWHnhmFKqyzctKMGkffWz/Ctr0q5/NNFj9bgpKTI5T+tCfzkF2GQ4gUVwr7BhBHU+F58YGSlUS1grmtKrmkQoGF11IwRylK2zEhgDKLwDrZjeZQ3WBnMu3c2fajIxeGpGrv5n/r+8UwXs3OS4x5VB/soEsm9g3ysSjOWKqDxMsCvBPZOxIlaDuxHfg7zRzyIlFycsFwBaDyO1ddnuaT1pUqoo0FoeJJ6KDS0h4vMS7ZHxHa0+aOcPunV1bxnIX4LMcY82lML8vb+wqFUUJPjmMOe/mhrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eDZj37Zu2ivERaK+LvIolt+6x6ueCESby+SKChOjqtA=;
 b=aljqES1lzQjfpDW7vYXJhNUNBRplSBZhxcLU/f5NFQbMpBi6BJnoXRmq68C3EX60Pyt/WzVDthONi2RpOsIT46+6YXyhiV/aH0FuY6vF6LrotUCwA6EriQvyp2No/WRfmGC+qwmSGZ5sqzf9EbJsyxLvjXZeW+EnT8M1DFUoXW8NsTi1Q3IUYDmN7aTaJrQBqixPr/D1hJGmb635qT+cF0EyNOyVE1gxmRZZ+yH8dqJEIz5RglvHP/iG9i9jj2L7kxHTd4nJNXiqV76dM7kjLk64zyJQ3G3+YcuWt1RcQGfe4BwQpFRebSBqrsQrDtv3uPF2buskPZiSDmlo2OvlGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eDZj37Zu2ivERaK+LvIolt+6x6ueCESby+SKChOjqtA=;
 b=kXl/64GIQG5YC+RVYTIdt6v8T2j8CLkpm2g4xCoJFirBv3b5iQ1LdHMc/a+hkccwB/k8yuQY1j+fpOhxUGehhkkBfqCeilWO8iIgAwTKD/6vG4/wXgPn2wtnOd3EC+CrmWlyaPUP3IXzgXipVSg94olPDHXHKvzNCeD+tWwi2MxS+jH2jsFUv4MgLmsDPD6HkZAmSBqAc9U6E8MPkBiemHkOljrL8e4j0HQWyvgG/W1AjlmULX0mwYR5XQSWPN1SzLEyoZPhc5FrL/GFdTx21ERvA8vXkhaueQukm4lyE4VNkCwyg/G2fTxmBQXRDoscMm0SdXWxfuk5eLIEcAwsuQ==
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
Subject: [PATCH 2/5] migration: stop VM earlier for CPR
Date: Fri, 12 Jun 2026 19:51:07 +0300
Message-ID: <20260612165110.431376-3-andrey.drobyshev@virtuozzo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 627f853b-95b0-49be-27f2-08dec8a2d566
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|52116014|1800799024|56012099006|22082099003|18002099003|38350700014;
X-Microsoft-Antispam-Message-Info: tbnra3yqjkxJ2a1QatVWhV+bboAh43I+PiAsgLuC921L4iMcOU71+g1Z/B4cR0tC+3P1SyHsWHT09c6ZupYmT7XMQBG7qX9Dsv6L9fjrYzCUEf2LpfeoMQeY0tZt6hPxyRQFG5zm8e4AlGrq1KOIXQFgs9QQneOnUrXKZgb5DSG5gqpNF6pbTO3CZ90cdb8U/zpedlg/pdM/v33PABMxSEK3rREwBblfNZ95U7N2zqBAzg8EgPyrNEu96On4dShE6hobSJwiBFwTr3h9VE3gGma45BZLK95sEm88bdd5ZTweNK7IphXt9KIoUql9cEivWYPkffzwwFZUcfFtJ1KDqHdYYtoNDypAcsw5gvsP+ri50GFQAb24AJuYeVcgsXA3ykqcddif8x086xDv26kgTysbAzna5N4+hwOhzOaEo6PgixKrpkw2T+CykGpeFVFnw7MIx3U8cmgk2kdnXLEY5eWIeBbmJkKq/nmE4VfGYl6pQLMJZQ2SYuV61QE0WkHdakVjA8t1o1+CQTkev1uIj8DcuRJpCtzTna9MG4XN6/Xb74DF9VdiGm8S8e0hpIjfAoqYJiHFCsr/mp7Z51mEcxyl0p5rZVJZrvXQ21y6umJxT4lKHkhiAJNtpGZQOu2FRwm5V6ogrPENt0TC8Aek8FVOgqIPmaO9E7eFRLmeV/ESMvvNyMw1WpwqP9MzhbLl2mcwNw0nYgbGvIev8yjkkfLF0x/Ie4u2+VUMg7CZi3uzxsgkZGyrzzqVxoqFxC/J
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(52116014)(1800799024)(56012099006)(22082099003)(18002099003)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aFK5ya6OTipsfAds3bb6rmc+QqTThd/TfLSN4PxxVXgoHiPvL2U3u4ziFsuj?=
 =?us-ascii?Q?kixd3QvxYwFt7lr+yegplIotAPYTsr0no9+0S/qp6dAggGVfTjZTHjo/oMUt?=
 =?us-ascii?Q?4wf/4ShxYYSqMxSosbdJ/9b8hrHGEV1DM3AS9p4WBX0zsMEexcPFd9ARiXND?=
 =?us-ascii?Q?BvwCQlrkAmfFIGfX0br0phNAlcvTC2A4G1JV/94q/40bMED1eRtf8BhQaM3v?=
 =?us-ascii?Q?ssjsv726d0GrOlPxPHc3Co8/ywpIMFLuKiNBn3xtTKbBLVGMVTJr2CSa6/qz?=
 =?us-ascii?Q?Goyx4rjjvxo2ZueyvgVK110IdChGspI0LRSgRkEsRTBZvoaZ+/Mwz68QipuI?=
 =?us-ascii?Q?qOiQGRb6a2bcd5me7Y5nvICXghySHoVRdIM4hB2rdLPE+nrrVd/c0oeKSbiN?=
 =?us-ascii?Q?jZuNPGV51nH5g3ClSp5SS1W5niKBidvTHkHtS2MLaU+JZ2q6oMWyfFfitJ9K?=
 =?us-ascii?Q?yle+CeXAP3+8WHg6x/cNhsqJCW8emeg6eBFRVSGlN6jaf0sWu1CbTwekUJ74?=
 =?us-ascii?Q?rAWab8bN0PxaQhWzVP/aZyEmJ+LF7mT/NnAa1it6kbREFK4NMaZqSqsqVW3U?=
 =?us-ascii?Q?RCaGFQqoFlaRPhUGzQkstcbvSeXy2V7RHlA6xYRvOVbejjjj980YAq7eoMPL?=
 =?us-ascii?Q?DDZpfq+h07UMzBNXlRTTCJmV9LuIwftzFbLJ3KgkXIm5H4BcCilD330QAgtj?=
 =?us-ascii?Q?0kFRyVNbfQuLhZMwYlGMAtMb0BmAWr0i9mLePsJh/+0tVixHFDF7CzCw3EeI?=
 =?us-ascii?Q?fhJRThdVEa9cf9Z7uvmAHcYLf5xGI2dE4NBsxb5ZTlI4JtfyxPVa2RDt31+D?=
 =?us-ascii?Q?AZGB5/kLkQRBwbGfBFylCpWf6BK+dEv7a56+HSxgSQo75l/YAbxcMIv9Q5lg?=
 =?us-ascii?Q?Yjh7nOPbe0q8Oae82VlgGVY9wa/1zuswxlqScjzgsjE0oNqb/FuJct+DVxE9?=
 =?us-ascii?Q?HLxNEwv38ynu7qC4wdmrpeFjfGvPwjIJnN3t+P5sb5jVZs/lMFOqazbwkbkm?=
 =?us-ascii?Q?8gX3GGIM1Wy2w5jqsB1aLCsFpiwofM94vAo/7UREItgc1S0gXmyfIaQsSB1B?=
 =?us-ascii?Q?nNAsxTs5eGJWWqVcaIRlZ3IXOvdQeChT4TumihTs1PwzVeovyMV0l4O4/8fM?=
 =?us-ascii?Q?9bMnbCUd1f0HrJyXCbAiW1M51xxPOLXab2zGkw2jzBEiyHuXVgmG50SFUDFP?=
 =?us-ascii?Q?p9TH0skMrjj7MSw2jQ0Rm9GEjf3QHK1xxXpdPGkTyoDC4y87ifmsf9Y8tQgk?=
 =?us-ascii?Q?w3jnUygDyOEfVLdDo1N04G+/z+m0yRpNo6+yb+ApLjDdtwrCh66BNb/Vb5n3?=
 =?us-ascii?Q?/JKc1Heh88qX4M6EQW6ObA08RZutq6GU/cQ2Be1+dyvCGW+liSHOzznsJc9J?=
 =?us-ascii?Q?Kq4yvamySl5dDYEswz8q3hEEjP0TUH2b23A2hR+LMGfReIyvdCcLvCXA8vqc?=
 =?us-ascii?Q?revPhhJS9LRjhb/hAqMlG7PMkF6edqqT4U5Cr4oTuDZZMqbpKKQOrALxKYa/?=
 =?us-ascii?Q?230XA48d3zcYAfotW4Z9RsT/eGkGs5p963iI8FaOSySRRKpxl2vZm0ijQW3n?=
 =?us-ascii?Q?CNG0fIpoy5hJz5S8Yi3oAgD23ThsGCGTqfwhBvHQlGflDR1UDpewmEyR5JGZ?=
 =?us-ascii?Q?rEU9Z11alMGRc79Ayy3BMDCC6YBPqeIPnaMRTGWArx/OM5iBAejHH2XEvZNZ?=
 =?us-ascii?Q?VaUNe6rcTrtRNKsUyCIzl71c5A1Pig1oyqejRyNHsWvr7pUF+PXquDx39Sbp?=
 =?us-ascii?Q?156+YnWTelZKn0p8OkpYsoPcC+kZhow=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 627f853b-95b0-49be-27f2-08dec8a2d566
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 16:51:22.4630 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K11MnJzGREeZ1oP1yro+FXKwG3x8AvIdPlzxXlxmVMimhQdAb7yCU1WoyP7rxIhcSrBaMV4l5WHip493SQjNrNYIi6Mvqee1VcCG7VCq0ng=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB9097
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

For CPR-style migration, we need the VM to stop earlier on, before
cpr_state_save() fires.  That is to prevent the race between source I/O
and target device init, as well as make sure VHOST_RESET_OWNER and
VHOST_SET_OWNER are fired in the right order (cpr-transfer case).  Thus,
for CPR case migration, let's move the stop to qmp_migrate(), directly
before launching cpr_state_save().

This patch is a rework of the change originally proposed by Steve and
Ben at [0].

[0] https://lore.kernel.org/qemu-devel/20260128-cpr-tap-v4-0-48e334d4216b@akamai.com

Originally-by: Steve Sistare <steven.sistare@oracle.com>
Originally-by: Ben Chaney <bchaney@akamai.com>
Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 migration/migration.c | 73 +++++++++++++++++++++++++++++++++----------
 1 file changed, 56 insertions(+), 17 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 3c70467d314..c02f1da8b0e 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1380,10 +1380,13 @@ static void migration_cleanup(MigrationState *s)
 
     /*
      * FAILED notification should have already happened.  Notify DONE if
-     * migration completed successfully.
+     * migration completed successfully.  On a failed/canceled path,
+     * resume VM for the CPR case.
      */
     if (!migration_has_failed(s)) {
         migration_call_notifiers(MIG_EVENT_DONE, NULL);
+    } else if (migrate_mode_is_cpr()) {
+        vm_resume(s->vm_old_state);
     }
 
     yank_unregister_instance(MIGRATION_YANK_INSTANCE);
@@ -2130,6 +2133,45 @@ void qmp_migrate(const char *uri, bool has_channels,
      */
     Error *local_err = NULL;
 
+    /*
+     * CPR-transfer  ordering:
+     *
+     *   SOURCE                              TARGET
+     *   ------                              ------
+     *                                       cpr_state_load() blocks
+     *   |                                        |
+     *   |  1. migration_stop_vm()                |
+     *   |     VM stopped, devices quiesced       |
+     *   |                                        | Waiting for
+     *   |  2. notifiers (SETUP)                  | FDs from source
+     *   |     vhost_reset_owner() releases       |
+     *   |     device ownership                   |
+     *   |                                        |
+     *   |  3. cpr_state_save() ---- FDs -------> |
+     *   |                                        |
+     *   v                                        v
+     *   postmigrate                         Device init begins
+     *                                       - cpr_find_fd()
+     *                                       - vhost_dev_init()
+     *                                       - VHOST_SET_OWNER
+     *
+     * Step 3 is the synchronization/cut-over point. Target proceeds immediately
+     * upon receiving FDs, so steps 1-2 must complete otherwise:
+     * - Target's VHOST_SET_OWNER fails with -EBUSY (source still owns)
+     * - Race between source I/O and target device init
+     *
+     *  We stop the VM early (before FD transfer) to prevent this race.
+     *  Unlike regular migration, CPR-transfer passes memory via FD (memfd)
+     *  rather than copying RAM, so early VM stop should have minimal downtime.
+     */
+    if (migrate_mode_is_cpr()) {
+        int ret = migration_stop_vm(s, RUN_STATE_FINISH_MIGRATE);
+        if (ret < 0) {
+            error_setg(&local_err, "migration_stop_vm failed, error %d", -ret);
+            goto out;
+        }
+    }
+
     /* Notify before starting migration thread and before starting CPR */
     if (migration_call_notifiers(MIG_EVENT_SETUP, &local_err)) {
         goto out;
@@ -3482,13 +3524,19 @@ static void migration_iteration_finish(MigrationState *s)
          */
         migration_call_notifiers(MIG_EVENT_FAILED, NULL);
 
-        if (runstate_is_live(s->vm_old_state)) {
-            if (!runstate_check(RUN_STATE_SHUTDOWN)) {
-                vm_start();
-            }
-        } else {
-            if (runstate_check(RUN_STATE_FINISH_MIGRATE)) {
-                runstate_set(s->vm_old_state);
+        /*
+         * For cpr the VM resume on failure is centralized in
+         * migration_cleanup(), so don't resume here as well.
+         */
+        if (!migrate_mode_is_cpr()) {
+            if (runstate_is_live(s->vm_old_state)) {
+                if (!runstate_check(RUN_STATE_SHUTDOWN)) {
+                    vm_start();
+                }
+            } else {
+                if (runstate_check(RUN_STATE_FINISH_MIGRATE)) {
+                    runstate_set(s->vm_old_state);
+                }
             }
         }
         break;
@@ -3903,7 +3951,6 @@ void migration_start_outgoing(MigrationState *s)
     Error *local_err = NULL;
     uint64_t rate_limit;
     bool resume = (s->state == MIGRATION_STATUS_POSTCOPY_RECOVER_SETUP);
-    int ret;
 
     if (resume) {
         /* This is a resumed migration */
@@ -3944,14 +3991,6 @@ void migration_start_outgoing(MigrationState *s)
         return;
     }
 
-    if (migrate_mode_is_cpr()) {
-        ret = migration_stop_vm(s, RUN_STATE_FINISH_MIGRATE);
-        if (ret < 0) {
-            error_setg(&local_err, "migration_stop_vm failed, error %d", -ret);
-            goto fail;
-        }
-    }
-
     /*
      * Take a refcount to make sure the migration object won't get freed by
      * the main thread already in migration_shutdown().
-- 
2.47.1


