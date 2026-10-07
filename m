Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAC1FCA5FF1
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 09:28:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xENsi-0004eE-PE; Wed, 07 Oct 2026 05:24:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xENCR-0001Sa-1r
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 04:40:50 -0400
Received: from mail-northeuropeazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c200::5] helo=DUZPR83CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xENCO-0006wV-9w
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 04:40:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=duroC7eTNDbigKhl03KR4ULZ+OiSdzrobbRwLrJqj+gYafNEBfRSyNVw9e984oWaLwpRTrNeWmLS7LXa5JzN23itZUD/teTnltoHot/svkBFBRf/Vz/cf2aNWpcpxOB8o+qo/elOXN894a1CTE3UmY4Kg6w56ei/DMcmBrNVEyL3bp3pkq6Uwngr0+EclA/lRhCbSGPuvqiY6wwQvCrtkJYZBjHWJ1bfRaJCJd19Gn52r4SMT3W75qPWvMe3M21zWEThqhkkAZmC8v+1rCdkj4hYSrurdGD56vLlo8IJgOSNqHiBtyjfFGTjYd4WHhp4bH+LHz1Fgr5TybDK7ups4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Q/HDXLoyiC61Uu3uiyDBlQDft7G81VamCAO8Ca1qio=;
 b=dG7uAKxxd2kV/EUAYjjo05Y8caXVClLgyOp61NKc2rZiZd8jrPoGfmtKOOLhWi9vo/OORGRwGizChoVD4plnVxDywMuTyd54gZZ65KJvZrPcCeaLJ0zog4/ppS778v6b+UYzg6zqZ50ekfE91fHg8ESlUIJPkvz4M2LBctoI0ADeRexaYRoxHTXxEESemUkM1b0oKOw06kZUAZnH3sLouzrQTTvNvPK8u5s8gTogw8kOTmN9cg8r+m1e/bAuLlDUXwyBbEhFsL7BjigVR3UR1vVylA3QlF6kvhN8OizS8eKMxsIq9R8u6dp4l/K0PTcEVZRL05BJsuRtsrjUDnTvew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Q/HDXLoyiC61Uu3uiyDBlQDft7G81VamCAO8Ca1qio=;
 b=cgSNTjp6VbXMC3NMTw4WSVOQ4E5/ChQXsNv/RndwD52t65q7sj/0G7XSFUoXSH4MMX3h5eiEfCJ9wZ7AvjCxImJYrsrjeRmnE/XnKczA8rE2xkz7z+M7/P/lIawE+8ql0deUgMJWSp/K2Qh21EHHW2+giHz2qlmKfiE3VH9at0uf6suHce0FaZ/15eHTjJYnTZxBHdX8UsjkjcfVjL3twmAXHOaBYz7jg7+qsmnwfbX//70VtidOBCnydu7+lxMGqvyuQDCszZYhFiVVeiAzL+w9t+InUWAmAQm3dWLWFvLNZndFR/qbsdL9SzBr08mllbU6ejPGxqlqnuG/vj/csA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by DB3PR08MB9058.eurprd08.prod.outlook.com
 (2603:10a6:10:430::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Wed, 7 Oct
 2026 08:40:11 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0496.010; Wed, 7 Oct 2026
 08:40:11 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Wed, 07 Oct 2026 11:40:13 +0300
Subject: [PATCH v14 20/22] tests/qtest/migration: add vhost-vsock tests for
 cpr-transfer and cpr-exec
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261007-up-vsock-vhost-v5-v14-20-e16de9962df0@virtuozzo.com>
References: <20261007-up-vsock-vhost-v5-v14-0-e16de9962df0@virtuozzo.com>
In-Reply-To: <20261007-up-vsock-vhost-v5-v14-0-e16de9962df0@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: dwmw2@infradead.org, mst@redhat.com, vsementsov@yandex-team.ru, 
 farosas@suse.de, peterx@redhat.com, dongli.zhang@oracle.com, den@openvz.org, 
 andrey.drobyshev@virtuozzo.com, mark.kanda@oracle.com, sgarzare@redhat.com, 
 maciej.szmigiero@oracle.com, odaki@rsg.ci.i.u-tokyo.ac.jp, 
 philmd@oss.qualcomm.com, bchaney@akamai.com, clg@redhat.com
X-Mailer: b4 0.16.0
X-ClientProxiedBy: VI6PEPF00000236.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:808:1::8ee) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|DB3PR08MB9058:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d7aa14f-f883-42f9-29d2-08df244e99a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|7416014|376014|23010399003|366016|1800799024|10067099003|260925022911599003|260925021311599003|260925021911599003|56012099006|6133799003|18002099003|22082099003|38350700014;
X-Microsoft-Antispam-Message-Info: lBttW2+9DNhfYMQN88CZvFOqYPsYw7NAuXDF/lR60cHD2ULILmMSGYJ12EPfn7uolFooBDtWASxSS7yRcgDkyQ0/pVoImnMxmk0js4liNlhghrddCg5cGhyIlSpILV/q6lhOWTNCXC839fDk3k+iOYl87RLZHy9VCULBggScxC8/0Z1Bp+1ENLRdXo5FDObLhyPop4hqV+TXD4CDlfuvw6W1D9bLP5ZmzKKU1F5fOXJXS2S5VFi4wcLl2D796GivJfROXo/Vrqc5qOXD1NwUg2x041Hs6rz0Y2vob+z5eQjndpz5dIq0gPDq7jwuiVFDFFKwFUI1HhARnrSO6xAGijENvOODVIOtLxPJlGk0M3ZpwidTgRvouUnS8MJu2bN7GdtCW01eiDQPF8NOsJZ2loFsd9EF+h13jp7BYUOG2Qb/XcDsrYQpimC1mfx73cZ8OO5ySX3QXG4sdvVorULFfvFF94lINQXRVo57Az66CfgWydGvzR2vvoBgbcO6OjYkhRG7U06+pCl1vqpVTrAQfi2MUXIDNnqes/4qovKaViZT/aQMBvtlWdujsw/2OfpkqcnkoYKbIlPRwAG9mYe1gtFbUAd4bSklPu3jYLdBD3e1GMU2wrRhSU6dMxg175wBdVlx1IcLyx3ZF8L2Dqq8RruS8VQ81qXnR0VfEPqO45NCS/Tzto6AXXFueDHn+bcrMxRhMz5bkn9D3nFW/tQZhGomjaDa79BgANqcxfgPfJE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(7416014)(376014)(23010399003)(366016)(1800799024)(10067099003)(260925022911599003)(260925021311599003)(260925021911599003)(56012099006)(6133799003)(18002099003)(22082099003)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UUlKSU1rV3oxQVR3NjQ1UlZyTkc1alh5Wmp5YWxUWmtqUEM0M215R1Z1SWtQ?=
 =?utf-8?B?Zk15c1EyTWVrZ1lpV3BFeGEycWY1eWh5T3E2NWdSb25mY0R0RlludnUrSk4x?=
 =?utf-8?B?dDJ5UXJ6VkhYL3ErYW5zNXZPZ2dVZUlKUXhGOXNKSUFBRFZ5RWt2TXpaQmlr?=
 =?utf-8?B?L2FwYzFSUlFoWHMvT1pHblNpUmxnWkNBUGloNitiQzI2R2ZnaVkxRnVhcUQr?=
 =?utf-8?B?REZFelFIQ3lHYVBzWlRRNjdXMnIzaTJiMXl1L00yRlNEUjhZd04ycFV4ZWZr?=
 =?utf-8?B?WnY2UnF4ajQvVEwxMFVpUGhqck53NVZKQkdKTGlvLzFVZWREVjd3S1lUS1lK?=
 =?utf-8?B?RUhrckkrYWhldXdBS2hKQ0ZUT0JjMWd2eUJ5KzV2SGpHRW13Q201MVBaV0tQ?=
 =?utf-8?B?cEQvYnJPY3VtWjFreEJxZ05TQkoyRURyYlZuSUZRYTQzbS95L2ZkSVhEM2dQ?=
 =?utf-8?B?NncrRGsvZFhVQ09OZmNySFlhV20ySkFBWW9jM3llNmVHQ09iSktRc2p4ODZa?=
 =?utf-8?B?M0g3bFF2SnJ5NTZSa2NZWGEvV1NuN1ZNbzNIbXVZdnp5cE53QVduYXdIdWRC?=
 =?utf-8?B?ditpdjMzV1VwRkp2QS9UYzA0TzViYWZ4a1RVelRxR0dmbjdyUzdMbittdWVm?=
 =?utf-8?B?aHRUVGJaTWVmWm81UE9MZkVvcElCRmdTYUNtU3VxbnpUR2hQZDJSbHFXZDZY?=
 =?utf-8?B?clh5dkJQcHFScjl6VWVkL2hDZjNOTVRtdEFNMEdXL2VRUVhGQ0N1WERRcUEz?=
 =?utf-8?B?UVFxaXc2bFlQaXM2SmpWK0FubTFQN0xaWkpuaHNSdURHRW9oR1UybThRYTNo?=
 =?utf-8?B?M1o3RndwellEOUNONXh1Zm5NTWdxUTV5QjRxR2dLVWxhRS8xTUFNbUp2L2U5?=
 =?utf-8?B?bmQyZExhU21TamVwTVUxTGJzUFNnUGlXNjZBZHU1a0ZhblluUTRPa3FVU0lh?=
 =?utf-8?B?Z01hTDlRNTBQZU9zQjFyWWYzZTdyZ3RhMWJLTmxJOEgxT3BNYTNJcXUrSS95?=
 =?utf-8?B?UjZNYWhCb1NacGpUdFB5ZmJFRkRONWVZVDZsVm9kaktMLzhoWSsvTkVVWWFP?=
 =?utf-8?B?OXg0bVc1bWVrbnFrcGw1VWJ1NnFIQ2lhRGg5TUJQczNMa3FmdFFGZy85TkJO?=
 =?utf-8?B?bXNzM2RpZnZ4alpISGFraUpwcDB3SDBRNXVVcjFiNTdZTy9BeXFDaHF0MjZJ?=
 =?utf-8?B?NTlXZjJPdTdET3hNT29uYnppSm1RMWNUbXdjcHkya3pWT0tKZzZXSWRrRXN6?=
 =?utf-8?B?MHIwTkE5ZzVsNEZNbGJmVkIyWmZ1bFZCU2d4US82cTFoaG5jNW1nSjJBamJh?=
 =?utf-8?B?SmVmb3A4ei9tdmp3ZWZIa2FkYzVGTHBrTlBRVUxPMEFlT1pHa1psVk56N2U5?=
 =?utf-8?B?cGVxMFJrOGFCTUcvaURQZytkOCs4ZTF1QVJxam82QnFqSXpHdnc5NUhMRllY?=
 =?utf-8?B?UTR2ZlV1dytVOXBZMFV1MW1TMWtMZUQycEFwa3RPVVdaWVV3VUUzOXNJRncr?=
 =?utf-8?B?dTJHdEUrUWFWbUFENUF6OTBrVWtkZGxzTnJYNzlyVTc1RjZIZWNRUVdLNllo?=
 =?utf-8?B?T2VWNWZXbUhnR3ZGeVRvUngyWXp2eHNPY0J2SWpybUt1NktSSzk5eXBnZUYy?=
 =?utf-8?B?TmFYTUpzTGs3dEpRdTk1NG5XWDZiQ3Rld0dvT3FkQ2tUQ3Job0lLb05YcUdZ?=
 =?utf-8?B?TTZTTzJLZGhZYWZTL2lxbW1JMEhsMzdnMXdXbDZ5czJaQUhBOHVtUFlIQ3o1?=
 =?utf-8?B?YmpENkFNQ1dvOUtpRlMxR3FQcXlxcDFmNWZ0eWlyYnNFWk9yVXhxSjlhOHIw?=
 =?utf-8?B?TE1aanVyVFc5aU0wZG1sdXR3WUgyQUZNdk9wVU10NnFLa0tJUTZYNXAwMGJt?=
 =?utf-8?B?WTBMb1p6czNzLzVHdDJQM0xjUVA2UUlzeHZYWmJPUlZqN0FWMmt4c29zM01J?=
 =?utf-8?B?aVVhZ3IxUExNRmVxbC9WWVpyWVB4dDdudEJlS2ZPWmdEQ1dKOGdINEpzSFBs?=
 =?utf-8?B?aTMwTUQ0dHUzWFBHRDNyQVoydS9WUHFseGdnajFXSW5oODdBTHdRRjJ5b0xt?=
 =?utf-8?B?ZEdiR0wyYk10YzFOZ01VdEZYQzVxbEtDcEErYi9WeGlqZnRMeUJxeWZ3VEJT?=
 =?utf-8?B?aDFQQklKaVUveDJxbFZZMlA3ZkszMktnSHEvMk12RW5RMWlNK2pGRTkvcVBN?=
 =?utf-8?B?eE5JNFlZSmhvVFRxWnhPcGhVd0taanI1VldHV3B4VGIrOTFwTTlXc0ZHQTBG?=
 =?utf-8?B?NHBSbWtHUmh5TDlRa0JaZVlEd2hUYzhkSmYvdEFQT2pRMktLZzR4OC8zMGd6?=
 =?utf-8?B?cU9ta1I1QnMzOW5YUXBuYkN1Q3U2ck91RzJQVU1seVA1MjcwaWozdVlQSkND?=
 =?utf-8?Q?SZHp4e7/Lekx+M7M=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d7aa14f-f883-42f9-29d2-08df244e99a1
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 08:40:11.4397 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WARFbuxMiN1QhEef1KQ4vPOGDsjNVj6erBfmRTISXfGp4cjxJ/+x2yd4f8TknSgV17NNEYuYDtmgF51MhYTPBQxRMB7lH2EfODg57AmVHbQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR08MB9058
Received-SPF: pass client-ip=2a01:111:f403:c200::5;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=DUZPR83CU001.outbound.protection.outlook.com
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


