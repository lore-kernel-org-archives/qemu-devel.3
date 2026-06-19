Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA686CD4F26
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2026 10:56:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waWsp-0007ln-NK; Fri, 19 Jun 2026 06:55:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1waWsn-0007l5-VC
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 06:55:33 -0400
Received: from mail-northeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c200::1] helo=DB3PR0202CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1waWsl-0003Ts-VJ
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 06:55:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d0mZKPMcCJ4e8eH7rpKu5hkIY5Y5foKMtcIUmd/Xq/2WUEFwCqSTfq8LprKcorP3DSbQkzmXlRsLYlJdYR9F8iaeRhn5lT0wOdkvcgMndYCes+EyN34gwdZVx4ByFI5ZvMdGP2oBeYx5hAkOhv3IOkeUnWSxTSJW8/8kmC+tIWOPT0znz3IgvY+Dri9u1WjuBqq+Pfv/euIu2CphuPvGqJI37a6FFZi4jYglRRBDar3j9+OLksdwH9HEaPfR+04to14lFO+rLhvddfx3/0b+k30p6Ko6ij8Ni2coNziQSo6d8w9KjGxkD5YjqIIp054JFU2bOR6BVNcT2/1w3IOPyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XTb+AlUqJw2xnva28g4rxiMmMqlgPFggSMev7UPCQ6Q=;
 b=tS1/e9rtbpGkGdINGc98n7oM59tMLHCOY5ZCLxQVgKj13ncu7g9cUlaAs/TF4AYkGP6wJfjsjiPXOZW4K7rzjHoZD044tuuKLPeyWDs1mzjCs2uCUxXkBtBQOSjPlzrk9MEW01LgK2yQUx7uBo9Nj3jaWNCbt1bW+RSEIxhM4BvQYVf0kVBABrefNhrprmsTswbBvz+LyX2LVt41cbSApvGvjGZHzgiARbX32kojvYf3DEaeslEtJNAXb9F8ODPF7l49lwA1d4pstcd5KQRGtvM2+/RIf8/nDNnKN6pkSh1UN0ffqSRJVqXKsZNwfJuYAcWg7EX/EmCpXFCiy56S8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XTb+AlUqJw2xnva28g4rxiMmMqlgPFggSMev7UPCQ6Q=;
 b=J3UIIUe78c+jbNo0cOQJlDgh7gmh0NVjd3FtPPKRNhBPMwOYqg8fe2L49V4Bvjfuv/ajSNAPa36eK85msCYXWAWcNfTBMEztRKBrfOExXuIxH8UGK4apk3I54Sn5erOjCIg/SpqKlERwCt7uk6TXd7uXrFQSgS4toSf8Gg2m/gGwgb8IbwjbCgr6PQDS/1TBKEVbXlGwoBkpVJiRXjgOd/ui++nvh8rTQYAUDO1k4vhVHtJVIikiYAMzTA4+ONlrzi1/f4/gFGKeBAeC6XXdQftJAzf0NkIsK9PmlNx6+xZpBLNGp0odK7By5o9vxsq6vr7SdnJWhkRlHLY3+A4ITQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by PAXPR08MB6576.eurprd08.prod.outlook.com
 (2603:10a6:102:15a::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Fri, 19 Jun
 2026 10:55:24 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%5]) with mapi id 15.21.0139.011; Fri, 19 Jun 2026
 10:55:24 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, sgarzare@redhat.com, farosas@suse.de, peterx@redhat.com,
 dongli.zhang@oracle.com, maciej.szmigiero@oracle.com, bchaney@akamai.com,
 mark.kanda@oracle.com, den@openvz.org, andrey.drobyshev@virtuozzo.com
Subject: [PATCH v2 2/5] migration: stop VM earlier for CPR
Date: Fri, 19 Jun 2026 13:55:11 +0300
Message-ID: <20260619105514.128812-3-andrey.drobyshev@virtuozzo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 4dea8816-ebc5-436c-ff4c-08decdf143a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|52116014|376014|7416014|22082099003|56012099006|18002099003|6133799003|38350700014;
X-Microsoft-Antispam-Message-Info: 711sem4UFSzHrEFK8fdWvjQMgWSW1WPLjbHC6hSmlpQz2nJFkTHjPxCy8kSpPyV44dGtm2CW9q7ivCK+AmN7s8qm5WZEwK5k9igYZBmoLdA1mkAmSv8XYk0mhIxeOiPwBIg68PrS79ybjs7eFkMNpcPxa9cSXSIT2uPXdhcpXaGyl/Im/pxXC68cjPPP0u2AwN/C2Mp7svriQgWl+vA63Jmfm+uKWrxPJSs/kjuk6eHpaJDH1Nl5eV2dCKnSXGVSup0//eqk59bDqe1LhoN3dijqadrxcUdYU1s/M2FONkwv2fZCxq6AV78zdgpPNCN/FT0o17bkeWfdIjimXEHTl1i9MUGtgk5jNEEoX3UAt/wUHzTUeQVPn7esejXRYwL8JDSohyFGM3MpXdltMLhcfTBdw5JkjvhIagia42aja82HY+OoBlWCTXwxteyVUs7US9d1rgW4wSd/AYuuIiJggYRx9KmPiHsYi6UAT5eKCRg36ylg8HaXTAjUW2wy31/Xt+eWqs3E+M+F+LPaPhNtQVbBtbw+Qn2ngFxIWEMTX9msVKgp+DvuTn25Pgxo/FRNJ9f20yjmdvNmo+u1nVSaEFJcNZt/W+YNRIaPSB0qz/SUOfISvR4YK2yzBUMRmbijwmikksPl9B4vkktss+7Jf2+WyXMD4oqnjzKdla0w04/Ev2MC1pi2O1vjzt5NWnN37jNC7mn/e7nMkmhzi0zmm4m5QGUTk7nxPrEnI180O/I=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(52116014)(376014)(7416014)(22082099003)(56012099006)(18002099003)(6133799003)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?guKOwgR4+Y5RW4j5JI8O4SS0xFcs7j1gYjl1U6Nv8P/kfGKhlQms8suU0Mci?=
 =?us-ascii?Q?dbq7dTzj0tW3a7nDt1R+sm/79I7DG8VQmZQd46JuLrmsj8FMZiB8WxSuslkO?=
 =?us-ascii?Q?QBQ+qeV//nvz1Gbw4u1w1fKXMMYm6K7YnTcXYhdsYRQ7VUd9uHaq+Az0+q1P?=
 =?us-ascii?Q?Zs4d8ntILXwyceFebTC2OgFCLCQZA/o52iKm+kohLSzfzIEN603JYXvfjZKS?=
 =?us-ascii?Q?N8dIoG9nacUUceETp+1fNunWHBCOFR8L3kO7UPVc09aSxFDVPQPhM/iG/q3I?=
 =?us-ascii?Q?jW+XrTzLXEK/6b5W9rd22jqfFkltqTIxd3kQCFxoT+Esu9chDFcAIcZTambQ?=
 =?us-ascii?Q?KA28sdt2rsMo1J+5RvDSx4iH1btZ4YZwQY+KDl7+zZkPxbDSuDiKskCHLxLH?=
 =?us-ascii?Q?GyiJyfTeSHtTdOsvwEA26W441EcSYxiMei2hqBj5TCYyKltwBegu7KoPWCSf?=
 =?us-ascii?Q?i9tO0tGnZfN6ky6WWSF4RqysyUcJ+E2gW6KWHDP21bb+Wg7RhoPz+D67xf2j?=
 =?us-ascii?Q?HNN9HZQCDmJEQLRi0pWuvgGkzytot0uL9YsRfZiTYKC97/fQEyl5LjVuX+Y1?=
 =?us-ascii?Q?cPwsiB6NqRXv48iK2IryNIprO1P1J6eLNDlPh+fUL9YBj2ZZECC+3UHNOW3T?=
 =?us-ascii?Q?d+fZzIsbPzX5NJoQmnaitv/8tSdNSgcnrRmWHsY6iXlYi2O37oiZcLHsffHM?=
 =?us-ascii?Q?H/T/JCX+D1STwCVwgeXr9qPSjAJ9FnPm3n6af24ZHSLQPRBOlcDzs0wKarv5?=
 =?us-ascii?Q?y/xe4WIPfOID34TXTyQvVBk5SvFjNwSJhDIRnGeWBMPxyPvvarZvln41pfqK?=
 =?us-ascii?Q?QLQOAdgzWC5t/fLPgxL9JNefNiPebIfTZ5+yEQEQNq1obRvEr+CMNgEN8427?=
 =?us-ascii?Q?zPAOL1jy7TJJC47boyntEKLqTuai4zTAF8SFOf2S4CeJTiymJkn+G63BXxdL?=
 =?us-ascii?Q?5x2PcKr9gFykJ8u71ubPrTNTEmNbY2dovukgm5Q3tdpusKC3XAksle+D7wI5?=
 =?us-ascii?Q?/0jOXcd4d1BnXj/MJelsfx+oseR2N/sffo1SKGfISz3XoBdTrf+wxmMI1DFo?=
 =?us-ascii?Q?I+/vgNXnUfnpxt1Yl7/lhoMtndq82+pib6oDss2T3pu+gcRCXZcEXC8EZdU7?=
 =?us-ascii?Q?DM8FDBm0tw3/NRpMwrbUJmYtYi3osU/Av5znIbISNBM1Hg8P53ZSeJ/ELfxT?=
 =?us-ascii?Q?omo+TsUvu0yyHjvvnSPDCNktFIgJEbl1Dx6Zb0sECj2IjYLp3F5w51eZvova?=
 =?us-ascii?Q?2jBtC2qaIpCLRXlf7/vLoWiPw2cINNeryi6P3sIfvx6qL29sEHxfdazbL+Rc?=
 =?us-ascii?Q?1NqsuLOQQqgLHbuUu7l2LZWBCbb2xqEPtJzjdwdatoQzAOgx0itHLtFxwVIL?=
 =?us-ascii?Q?D4P3YBvwY2gVeEB7zWUKH03Tkc2WByRSQxQ+3utq/zH1wCE53tkF97qk8rdE?=
 =?us-ascii?Q?o6hr8b12eLMrtk2BG08iHGaBGHilm7lKRs1TbJaUurizSmb05phYjLc/lF49?=
 =?us-ascii?Q?HXV8k5c0oQeZWueIlpUIbQC7FJ9ieIGaui/MxS3TGATqjN/yzQAMlQseUx68?=
 =?us-ascii?Q?Bb3bJU62JYHCXjQ15YTfpqxqAjtnUKVlPkSp8W+gDklfwAKbn+Okx6fHfcN3?=
 =?us-ascii?Q?Q2BnfZt6rhmNxaQ6YwCHhYi9oIDrHk0Ve1Dalol443dkzZBcpsxQzLw0am4N?=
 =?us-ascii?Q?2w9aNWPWIbaNMUkh4b0ISrU0L/uoYHkD/qcGmf4fWB+LOqdoIZvsTrbj++zH?=
 =?us-ascii?Q?Wog8Q8pQFK1ybnQ6dZieQb5kvIXR5cQ=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dea8816-ebc5-436c-ff4c-08decdf143a6
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2026 10:55:24.0185 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s0EtluNf4f2Wh4C56x2pwFERAnJvfSZxuiRh8UNkqbFcEAsm50WM1uQLZ7vyon/+VKbqPbnEb0OMbjlU5p1U6jckcjFN7CPkJyOh/NcRDDA=
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

During a CPR-style migration, we pass additional CPR state via an aux
migration channel (the cpr-transfer case).  That's done in cpr_state_save().
The main bulk of the migration is only sent afterwards - that's why we
call cpr_state_save() early on in qmp_migrate().

Previous patch placed emitting the SETUP event before cpr_state_save(),
since devices must be properly shut down before we send their FDs to CPR
target.  However, for the proper shut down to take place, we should also
stop operating them beforehand, i.e. stop the VM.

Thus the desirable order for cpr-transfer case looks as follows:

  SOURCE                                  TARGET
  ------                                  ------
                                      cpr_state_load() blocks
    |                                        |
    |  1. migration_stop_vm()                |
    |     VM stopped, devices quiesced       |
    |                                        | Waiting for
    |  2. notifiers (SETUP)                  | FDs from source
    |     vhost_reset_owner() releases       |
    |     device ownership                   |
    |                                        |
    |  3. cpr_state_save() ---- FDs -------> |
    |                                        |
    v                                        v
  postmigrate                        Device init begins
                                     - cpr_find_fd()
                                     - vhost_dev_init()
                                     - VHOST_SET_OWNER

So step 3 is the synchronization/cut-over point. Target proceeds immediately
upon receiving FDs, so steps 1-2 must complete successfully.  Otherwise:

  * Target's VHOST_SET_OWNER fails with -EBUSY (source still owns)
  * Race between source I/O and target device init

Let's stop the VM early (before FD transfer) to prevent this race.
Unlike regular migration, CPR-transfer passes memory via FD (memfd)
rather than copying RAM, so early VM stop should have minimal downtime.

Since we call migration_stop_vm() from qmp_migrate() (i.e. from the main
thread), we should also balance it out by fallback resume outside of the
migration thread - i.e. resume in migration_iteration_finish() is not
enough.  One good place for this resume op is migration_cleanup().
However, in migration_iteration_finish() resume is gated by successful
block activation, so we additionally traverse the block graph nodes to
make sure activation did take place before doing vm_resume().

This patch is a rework of the change originally proposed by Steve and
Ben at [0].

[0] https://lore.kernel.org/qemu-devel/20260128-cpr-tap-v4-0-48e334d4216b@akamai.com

Originally-by: Steve Sistare <steven.sistare@oracle.com>
Originally-by: Ben Chaney <bchaney@akamai.com>
Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 migration/migration.c | 74 +++++++++++++++++++++++++++++++++----------
 1 file changed, 58 insertions(+), 16 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 20eff9dbdcb..4a854ade503 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1323,6 +1323,24 @@ static void migration_cleanup_json_writer(MigrationState *s)
     g_clear_pointer(&s->vmdesc, json_writer_free);
 }
 
+static bool migration_check_block_active(void)
+{
+    BlockDriverState *bs;
+    BdrvNextIterator it;
+
+    assert(bql_locked());
+    GRAPH_RDLOCK_GUARD_MAINLOOP();
+
+    for (bs = bdrv_first(&it); bs; bs = bdrv_next(&it)) {
+        if (bdrv_is_inactive(bs)) {
+            bdrv_next_cleanup(&it);
+            return false;
+        }
+    }
+
+    return true;
+}
+
 static void migration_cleanup(MigrationState *s)
 {
     QEMUFile *tmp = NULL;
@@ -1381,9 +1399,16 @@ static void migration_cleanup(MigrationState *s)
     /*
      * FAILED notification should have already happened.  Notify DONE if
      * migration completed successfully.
+     *
+     * In case of a failed CPR migration, we want to resume VM.  However,
+     * for a non-CPR migration resume is done in migration_iteration_finish()
+     * and is gated by a successful migration_block_activate().  So in the
+     * failed CPR case we only resume if that prior activation was successful.
      */
     if (!migration_has_failed(s)) {
         migration_call_notifiers(MIG_EVENT_DONE, NULL);
+    } else if (migrate_mode_is_cpr() && migration_check_block_active()) {
+        vm_resume(s->vm_old_state);
     }
 
     yank_unregister_instance(MIGRATION_YANK_INSTANCE);
@@ -2130,6 +2155,26 @@ void qmp_migrate(const char *uri, bool has_channels,
      */
     Error *local_err = NULL;
 
+    /*
+     * For CPR migration the hand-off happens at cpr_state_save() below, which
+     * (for cpr-transfer case) transfers the device FDs to the target.  The
+     * target starts claiming them as soon as they arrive.  Everything the
+     * source must do to release the devices therefore has to happen before
+     * that cut-over - stop the vCPUs and run the SETUP notifiers (which
+     * release device ownership).
+     *
+     * So for CPR case stop the VM here, ahead of the SETUP notifiers and
+     * cpr_state_save().  Since we aren't copying any RAM (it stays in place)
+     * stopping early is cheap.
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
     if (!(has_resume && resume) &&
         migration_call_notifiers(MIG_EVENT_SETUP, &local_err)) {
@@ -3483,13 +3528,19 @@ static void migration_iteration_finish(MigrationState *s)
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
@@ -3904,7 +3955,6 @@ void migration_start_outgoing(MigrationState *s)
     Error *local_err = NULL;
     uint64_t rate_limit;
     bool resume = (s->state == MIGRATION_STATUS_POSTCOPY_RECOVER_SETUP);
-    int ret;
 
     if (resume) {
         /* This is a resumed migration */
@@ -3945,14 +3995,6 @@ void migration_start_outgoing(MigrationState *s)
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


