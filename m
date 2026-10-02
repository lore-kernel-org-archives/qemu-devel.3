Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05A61CA5FDD
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 13:04:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCcvv-0001LW-Qz; Fri, 02 Oct 2026 09:04:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xCcuU-0000v4-Jn
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 09:02:50 -0400
Received: from mail-francecentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c20a::7] helo=PA4PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xCcuS-0007Rf-MN
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 09:02:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vj7WShk2j+VO59V+81zInMnfw4aQ07z5AQhf2wI9UAxn/w3LfSG+tV6DavGz+WWVTZ79oQ+FWtke1WHtQS3g8uzOiVCH7hWjb14qLFYbFumeBtT2XZNTm6SOJCX0F/peIumLEWnsp/GSzQlMidPY3Z88sHpbVOTsOxB285+Oi0hcaePqV1Jz5rzwrHB1+hkCWnLH85tqDYTcR8FTyJqVx6BCXmtitx78th1U6n1+kjFmNhyalmKrEQkGnUpnahV7mdcP0EzPnMd965pF9xv+kt/IcueKapObS6fplq34D00dSpjYhyKk7Pod+u9KE0iz9IPTQUEBsbK4eNjZ9Eofgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Q/HDXLoyiC61Uu3uiyDBlQDft7G81VamCAO8Ca1qio=;
 b=fFbgmqvIhQ7MzNN5DXWU81PUBr6R/nRrGwfAtuf/o4xNBeuoTSUzG9rNnKfYfWT1EWTI/p2cDB2yzE0LwSzt9C+loKb/JNXDlyRIu0Abicu/n3kPs9ZlR5WRYT+6ljwDRWM+057PomeOvMPbEZQZJV7o0HDF0QvLXZpQ4Hpi8+ihZw0Qcn3pBgKlPTp0sSO3cW3pu2WStyvDp1YozrD0QPXiqwtQJ6TGmicRcgQcROTo+Tv3z6cm9UL26TTNZcNK7kdnbl/M4zy2eZJ1h5BJf7f3wSirISZlqXMSBaLRz3xNrnujqRQqrTf5twPAKDYnyxZhCXfrak8nZ9jMQCBR+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Q/HDXLoyiC61Uu3uiyDBlQDft7G81VamCAO8Ca1qio=;
 b=Jt6n/13/f6vO1XPz91T4IzjoInhjZOqoPS+ooKx8MWGIcGS2+I8+DwrxWp8X/sJx9KLbXqoEuzDqYU2qlSGTYXwfALCVQMOpCDt9Afq8m8NZBHqPvoBcT9J/RRDYzNN3JU0gKrCcCFzNA+gedNZUv2exns1nr/SE2cAjSmQOXDNBjgBTXGh1KsfOB7igocZxTMx/AtchZlH9hRD/PN+o5jRtpGVJz265+pr1LRYvhQ2qTTfDq4Yf0b5G5/I+abItAjR6tx24MZIt6vO7GAcWTt0nYKT/WT39uceZAs6XAsFJRBr5VPcZchlKZ5+jntwBADNKl9JWmHLjaIF4nUbIfQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by AMCPR08MB11995.eurprd08.prod.outlook.com
 (2603:10a6:20b:76f::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.12; Fri, 2 Oct
 2026 13:02:34 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0472.012; Fri, 2 Oct 2026
 13:02:34 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Fri, 02 Oct 2026 16:02:27 +0300
Subject: [PATCH v11 18/19] tests/qtest/migration: add vhost-vsock tests for
 cpr-transfer and cpr-exec
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261002-up-vsock-vhost-v5-v11-18-18fa09d8273d@virtuozzo.com>
References: <20261002-up-vsock-vhost-v5-v11-0-18fa09d8273d@virtuozzo.com>
In-Reply-To: <20261002-up-vsock-vhost-v5-v11-0-18fa09d8273d@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: farosas@suse.de, andrey.drobyshev@virtuozzo.com, bchaney@akamai.com, 
 dongli.zhang@oracle.com, vsementsov@yandex-team.ru, philmd@oss.qualcomm.com, 
 maciej.szmigiero@oracle.com, mst@redhat.com, dwmw2@infradead.org, 
 mark.kanda@oracle.com, sgarzare@redhat.com, den@openvz.org, 
 odaki@rsg.ci.i.u-tokyo.ac.jp, peterx@redhat.com, clg@redhat.com
X-Mailer: b4 0.16.0
X-ClientProxiedBy: VIUP296CA0042.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:34d::6) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|AMCPR08MB11995:EE_
X-MS-Office365-Filtering-Correlation-Id: ba72fdcd-2773-445c-9cf4-08df20856c74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|52116014|7416014|376014|18002099003|22082099003|38350700014|6133799003|260925021311599003|10067099003|260925022911599003|260925021911599003|56012099006;
X-Microsoft-Antispam-Message-Info: 9SQwjU2y1exJUFsEOeUJI3iDF668CJVbNBP6kG56fdCDrJYmTKW44QdDAWf9lmoDKFONGygvMS+5PDOEDYYFP6S63e63q0M2vTdx/McqG/mJ/XyyHpSmBty+ClGJ+bx0L40Ez0yTdW1vIrvQB0OnXnicwhKXm+yYNSdH5E8c2mhIwuZ1MygAY7tfbVidMEKgd11sjnfNKM5Zt2gnmOgBCjVGYaQoiwwC3vU+x9cfSL1HJtmId3NB+R6/KcaVV2AgOJ9lbsHRJmnVi4hP/2zwvsPJqyxJP0lSBS4lSPIhnohHdY12jlb2Tx8GWxSS7SHTyINixX1zjxYhcdRJ3AU/XVk2I3ANvRdjcM8vHIvEEtE5qRfyv1VCyt0Cd2O+nu1VTn6xmqaNqfauZZLK0725tDpvSfwGCGiO3CJ/b0n7QO17HZX8ecOf/P6U1nHgxNam3ISSMjLRY2xb+X4/FDXxGT61oMb48PKGsmMT86wz/uqC0OtStnI66F+9jIKDP6/W7nUI0NDLez86yA4gZhbGX7DrPBWsXdzD4bqyidh0bBB7RxSBAAjvwYReu2pEdt18AFoYru2Bjk0VFBnkNB39VRE/FUankLz0EHF6ivhnVXZTKx86U0N/xhCR6EeqhfWz6YyyoHz4QZLQz8hEH4JzzMLvN2NCYvZWpHafrRD6FK2cCZ/BwjxraJdytBritMf7qRuW17zKgs3ERrh7hokLz3K3xuQLJ2dsZ/ruMDkoJWY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(52116014)(7416014)(376014)(18002099003)(22082099003)(38350700014)(6133799003)(260925021311599003)(10067099003)(260925022911599003)(260925021911599003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UjE2Tjl0bUd6dUNjUWtCYkwwTUZnZjlNZHBPcWtRK2tadWxxeklVNG5jM055?=
 =?utf-8?B?T3VqMFdWVThVeUdoVTV0ZnlzTkxOT2NyZjVHTkhPUHZZY1hpTEpoVGdQM0lK?=
 =?utf-8?B?YlE1cVVLZ2RhMjRORUY1T0ppUUJwVDdkWlFyRDN3ZDgxS3NqUHEvTGhIT3VU?=
 =?utf-8?B?T1FteFdINFoxR3daRnFKd2gwSFB0c3lkN3dXQ1dPMjNjY05BYkpsSm5ybUM4?=
 =?utf-8?B?SlIvazRrNjF1ZzlpZWNyVXBJazZoUGxJeXVGZkYxMkFHUjBsS0F6QTdvb3hE?=
 =?utf-8?B?dmJtQ1hTZTJROXVkZnJnYy9KbUh5bnROWGNBOGhORGI3NVVSclRHQ0V5dEFJ?=
 =?utf-8?B?d2VNbUZxenhad08xenNaU0NnZUZ0Q2FEUEpYQXMwQ2F5NEdVWEpSUXA3cVQx?=
 =?utf-8?B?WlN3MUQ0czNpU2dEZVZMWGJZaStoNWgxOENQbzFtZEZWUGN6MFBHbVdiaG9k?=
 =?utf-8?B?V3dmalNyWkkyNFFUNHlZQm54a21SZXhBd3pqN0MvZDRHVk1nUjBUV3luNjQ5?=
 =?utf-8?B?NllnalFhQTBMcGJONlMrYnRtMlpRWTh4NEdySlVETVlISDI2RWtVMjNueDlN?=
 =?utf-8?B?QmdWQWgzUjc3T2d6anYzaHptL1RQVVdxZTgyVzNmVGo3bmtheTZod2k3UGxF?=
 =?utf-8?B?N1ZLQzJKK0FuVldiODh6LzNEVjIrZ2J4MlNNZFdJVWpuK20zN2dzWmpMbDVC?=
 =?utf-8?B?QVdjRzA0cDJsdng1b0JlZGJobVh2a250MUNHME1EdjI0SnNNOE1MZWNxREFa?=
 =?utf-8?B?c3l3ZlhGa2pZTG80NndDd3YvSkRBUWRDUE8vUXBIdzVBay9uREpaTkVhUTRK?=
 =?utf-8?B?QjVBWVFQSnA4YWRGcXMzTnlvM2RscmdpVm02ZWpsWTlNVFRVZXRvbUJqa3hy?=
 =?utf-8?B?MkxwTnZZTDNCZkpGZnBEL0k5T01EODRTNklvS3NMd2FvcG0wN0xhYUY5MzI1?=
 =?utf-8?B?V1ArY3ZkeWpDUldNOEdmKzJiNUF6RDZUZjZmNjVPY1Q5bkxnWkFxbjR0VG50?=
 =?utf-8?B?dWUrUXNkTndqYUcycmlaaEtxQTBnbXpqU0lsL0RyN2tHL2xWaEJYRWk2dkRt?=
 =?utf-8?B?aU4rUEZuVjFVc2ozOVhmVndZVVFyc29QN0t0ZVlVOWg1dzR1RnNXdzdMd0d1?=
 =?utf-8?B?S21HZ2xnZWxOUDFwMEFvRHVzV05BV0F5WjQvblhwd1h2UVdYMEQ5Rk5RMFFx?=
 =?utf-8?B?V1B1OVhPVFZBMy96R2JiaVZLdlNpVFl0SGQwTUtmM3VCT2hNQTZkOXJoNGlV?=
 =?utf-8?B?ZzVyRHE3WFNDRVJWcDRJQkJaSC9JVXVmVEFjMWM4TURSYW9LZStHaEpHNzZT?=
 =?utf-8?B?dXNTWGZSbHBGamhJSG0wNWN3bnRPajI3NU5uOFJtUG9TMndXdUdNUzNWSXZH?=
 =?utf-8?B?Sm9hbnduSE9RS3U1VmVEL3NMcDZtWER6eFh3T1BXQ1RwYVZURk41cmJmSFcy?=
 =?utf-8?B?WE8zekZZSi94VFVQbU5leEZpL29sR3RlSHp5dlpCaElObElqeUZMd2dLa3A1?=
 =?utf-8?B?VnhXRW42Tm5FS2VXOEhTOTViRHBTeVZXNDdZR2ZZZ0kvcGU5bE1LRjNodTdo?=
 =?utf-8?B?Slk3WnBzTmNLT2xPTnhGRWNjUGdydG85QTByclYxeEFvdGhOdXJGcVVzRW4v?=
 =?utf-8?B?anFFTk5sOTJQRi93REJsT2hqUU1sWGlqc25NakRiWWFhSDBkQlcxOWNGeTBJ?=
 =?utf-8?B?djNwek9pN2EzZ0NuV0NWTVhPcWYzZ1ptT0dPQTBmQU9JaXpYY1U1QUUyRk9z?=
 =?utf-8?B?RnRSVFFSVk1ZQUNVdXlGV0xML2hQbGhPWnJZVmNDTFVWSDNjbWZhNUorZksx?=
 =?utf-8?B?MHpQWnBpOVRRejlEU0VSVGx0SU1DZ2g3dUpERWRrcm9WYjBHM1hGc1F1cDlF?=
 =?utf-8?B?SUdMZzdEaHYrT0JjOUdxa2JGVFExUzZvckVvNFBGaWRnQy9IV0xLSmVSc2dz?=
 =?utf-8?B?Z1NlN1pwVUR1WC92eGszbnRoL3BCcWpyUlNkRVRxSG1kaGYxWHpKZ0crQ3ls?=
 =?utf-8?B?WGpMbmE4RTR3TzJXY3dMNmtPK1BBYStHUzcyS1hldWkyL2FkSmJPNEtWNS82?=
 =?utf-8?B?Sm5IR3Q5TDA2TnVoVlllV0VBa0VuZWk2YURlRDBhQzdSTGUwbm9FTnlrdlFG?=
 =?utf-8?B?QjNncTFzTzZEWFRBcGlHRmNnc1l6UFFhdGdaa1NUSTNjR1g0VldLY0VaL0VY?=
 =?utf-8?B?T3pDeTZ3L0NFdTNiSWUrODlzUTFrc1I4OU84VndXbStJVUVsbjBSVDExdm9N?=
 =?utf-8?B?d2RjcDBDVzllWWZpa2JORnN4ZDh1R0E2ZlhDbzRBZVlPUzRpbVI3dzVmQW42?=
 =?utf-8?B?dlpHeXF5VFlucGxlSmtPcW9lcWVFZTRmcXdsaDlGNEFocmFRajlzODRRbUpF?=
 =?utf-8?Q?H532N2Q0J2P9U49M=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba72fdcd-2773-445c-9cf4-08df20856c74
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2026 13:02:33.3506 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6Kr/KcqrJDjK+UjdAl3180Nf1ip8VPNxehqy7pR/nn66jLsz+fokuRxI4izedzvGTgSM/K9hErApRpl58Tbp2+h/qfaHJB5LkzJfgxkqGi0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMCPR08MB11995
Received-SPF: pass client-ip=2a01:111:f403:c20a::7;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=PA4PR04CU001.outbound.protection.outlook.com
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

Run the existing cpr-transfer and cpr-exec tests with a vhost-vsock-pci
device attached.  There's no guest involved which is driving the device,
so here we only test the QEMU side of the handoff, i.e. the vhost FD is
preserved, the device ownership is released on the source and re-acquired
on the target.

The tests need /dev/vhost-vsock on the host and a kernel supporting
VHOST_RESET_OWNER for vhost-vsock, they are skipped otherwise.

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 tests/qtest/migration/cpr-tests.c | 93 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 87 insertions(+), 6 deletions(-)

diff --git a/tests/qtest/migration/cpr-tests.c b/tests/qtest/migration/cpr-tests.c
index 05c2ac1336d..3c21b79001e 100644
--- a/tests/qtest/migration/cpr-tests.c
+++ b/tests/qtest/migration/cpr-tests.c
@@ -19,6 +19,13 @@
 #include "qobject/qjson.h"
 #include "qobject/qlist.h"
 
+#ifdef CONFIG_LINUX
+#include <sys/ioctl.h>
+#include <linux/vhost.h>
+#endif
+
+/* We expect this CID to be unassigned on the host */
+#define VHOST_VSOCK_TEST_DEV "vhost-vsock-pci,guest-cid=4000000000"
 
 static char *tmpfs;
 
@@ -101,14 +108,17 @@ static int test_transfer(MigrateCommon *args, const char *cpr_channel,
  * migration, and cannot connect synchronously to the monitor, so defer
  * the target connection.
  */
-static void test_mode_transfer_common(MigrateCommon *args, bool incoming_defer)
+static void test_mode_transfer_common(MigrateCommon *args, bool incoming_defer,
+                                      const char *dev_opts)
 {
     g_autofree char *cpr_path = g_strdup_printf("%s/cpr.sock", tmpfs);
     g_autofree char *mig_path = g_strdup_printf("%s/migsocket", tmpfs);
     g_autofree char *uri = g_strdup_printf("unix:%s", mig_path);
     g_autofree char *opts_target = NULL;
 
-    const char *opts = "-machine aux-ram-share=on -nodefaults";
+    g_autofree char *opts = g_strdup_printf("-machine aux-ram-share=on "
+                                            "-nodefaults %s",
+                                            dev_opts ? dev_opts : "");
     g_autofree const char *cpr_channel = g_strdup_printf(
         "cpr,addr.transport=socket,addr.type=unix,addr.path=%s",
         cpr_path);
@@ -154,12 +164,12 @@ static void test_mode_transfer_common(MigrateCommon *args, bool incoming_defer)
 
 static void test_mode_transfer(char *name, MigrateCommon *args)
 {
-    test_mode_transfer_common(args, false);
+    test_mode_transfer_common(args, false, NULL);
 }
 
 static void test_mode_transfer_defer(char *name, MigrateCommon *args)
 {
-    test_mode_transfer_common(args, true);
+    test_mode_transfer_common(args, true, NULL);
 }
 
 static void set_cpr_exec_args(QTestState *who, MigrateCommon *args)
@@ -276,20 +286,85 @@ static void *test_mode_exec_start(QTestState *from, QTestState *to)
     return NULL;
 }
 
-static void test_mode_exec(char *name, MigrateCommon *args)
+static void test_mode_exec_common(MigrateCommon *args, const char *dev_opts)
 {
     g_autofree char *uri = g_strdup_printf("file:%s/%s", tmpfs,
                                            FILE_TEST_FILENAME);
+    g_autofree char *opts = g_strdup_printf("-machine aux-ram-share=on "
+                                            "-nodefaults %s",
+                                            dev_opts ? dev_opts : "");
     args->uri = uri;
     args->start_hook = test_mode_exec_start;
 
     args->start.only_source = true;
-    args->start.opts_source = "-machine aux-ram-share=on -nodefaults";
+    args->start.opts_source = opts;
     args->start.mem_type = MEM_TYPE_MEMFD;
 
     test_cpr_exec(args);
 }
 
+static void test_mode_exec(char *name, MigrateCommon *args)
+{
+    test_mode_exec_common(args, NULL);
+}
+
+/*
+ * A vhost-vsock device can be handed over across CPR only if the host
+ * exposes /dev/vhost-vsock and its kernel supports VHOST_RESET_OWNER
+ * for it.  Skip the test otherwise.
+ */
+static bool vhost_vsock_cpr_check(void)
+{
+#ifdef CONFIG_LINUX
+    bool set_owner, reset_owner;
+    int fd;
+
+    if (!qtest_has_device("vhost-vsock-pci")) {
+        g_test_skip("vhost-vsock-pci device is not available");
+        return false;
+    }
+
+    fd = open("/dev/vhost-vsock", O_RDWR);
+    if (fd < 0) {
+        g_test_skip("/dev/vhost-vsock is not available");
+        return false;
+    }
+
+    set_owner = ioctl(fd, VHOST_SET_OWNER) == 0;
+    reset_owner = ioctl(fd, VHOST_RESET_OWNER) == 0;
+    close(fd);
+
+    if (!set_owner) {
+        g_test_skip("VHOST_SET_OWNER is not supported for vhost-vsock");
+        return false;
+    }
+
+    if (!reset_owner) {
+        g_test_skip("VHOST_RESET_OWNER is not supported for vhost-vsock");
+        return false;
+    }
+
+    return true;
+#else
+    g_test_skip("vhost-vsock is Linux only");
+    return false;
+#endif
+}
+
+static void test_mode_transfer_vhost_vsock(char *name, MigrateCommon *args)
+{
+    if (vhost_vsock_cpr_check()) {
+        test_mode_transfer_common(args, false, "-device " VHOST_VSOCK_TEST_DEV);
+    }
+}
+
+static void test_mode_exec_vhost_vsock(char *name, MigrateCommon *args)
+{
+    if (vhost_vsock_cpr_check()) {
+        test_mode_exec_common(args, "-device " VHOST_VSOCK_TEST_DEV);
+    }
+}
+
 /* Snapshots must be refused while a CPR migration mode is set */
 static void test_mode_no_snapshot(char *name, MigrateCommon *args)
 {
@@ -354,4 +429,10 @@ void migration_test_add_cpr(MigrationTestEnv *env)
                            test_mode_transfer_defer);
         migration_test_add("/migration/mode/exec", test_mode_exec);
     }
+
+    /* The vhost-vsock handoff doesn't need KVM */
+    migration_test_add("/migration/mode/transfer/vhost-vsock",
+                       test_mode_transfer_vhost_vsock);
+    migration_test_add("/migration/mode/exec/vhost-vsock",
+                       test_mode_exec_vhost_vsock);
 }

-- 
2.47.1


