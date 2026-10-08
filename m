Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13802CA600E
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2026 10:27:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xElKP-0003M1-N2; Thu, 08 Oct 2026 06:26:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xElK6-0003I4-Kx
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 06:26:03 -0400
Received: from mail-francecentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c20a::7] helo=PA4PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xElK4-00014o-RQ
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 06:26:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a9rS9/WNORreJXtQsTLYVIqyGBtmczYP49UXeV1wiHPCVMfQ6/xiU2E+wtjJEu2bfrWY1EiStEgeQ9tp6ClFRN3ayULrwrTUdtWnYoZGQP7nwIR1pQU+8lw8DYcT0pom3ZBdIJvWLlOEHD16cUG6XFdCGGgVjxxB3uJvTY1e6ChS+Z7H4DDmNw7NqVVEs5dQXY19P0n7x6g5/tBNT6FEril07/BzCL4mJI5ZzN/0oXQZ860vfRINUCK/GSa3TGwKbmlo27x1oBIRhHtjIexqP06uLwcPyh6AGswDx7vb15fw7ZqTlv9Ck3OsioTXSg8FdMvhLiXT+0hC/sJU5+FPng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Q/HDXLoyiC61Uu3uiyDBlQDft7G81VamCAO8Ca1qio=;
 b=PO4tdzlUCaWlYYD4XmMeE9cPvjWdFBkKoH9lYvndHllHHSt3dfnD6oIA+RhmqjOk4XGEiJG7SUFpAFIZ7V0g0leVbMChbNmGQj22VOZxQvIFdn4NCosdnCPckKboo0s+zQhDfePc7QHddrsis6TJdA5o1wHK2B/UXaShLZXA1+Uh4f413Lh0xLmVSvPBwB0+y/p0q7xiua5MqGnRGXKID286t14HmUQZZpEKNeiU/F5nTjp5l+L8L59SZQQrs1Nif2e9OXCiveswmuSlUC6dv7GqNBeTMboWD52KrRamjpWZg0YSV7jziuH7kOzTwYyeNDF1subPrko63squxp6PBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Q/HDXLoyiC61Uu3uiyDBlQDft7G81VamCAO8Ca1qio=;
 b=dSrH7TUHIgLaipXrp2GCUlpDlnBQGP+YriW7XUWy9+YJc+m0AsLaHgRAUymKPOIv/Kw+JZgnSAC8AuYZkkrGZPKstMuoeHCyL+Ybqar2Od7qJSK3uEHXi64opQYapx4k+UN63h43NaXqpwq07kG+i7OIISbdqdEMmVxNINTn2xVBj2F9GmIci2j+N36QpzjIf+wfwG2vj0G2ktnQ7nksoEhuMFTFxJvrET8JAEgRWZFqZReAERIyYlLZhTt163Pd7sfjtuXJnQfdsXFrkJsCYH6cB/tlM061D5w+La9u7RVNO7q8VkSx/0wuBJDqDurrDkC26CZwGyBOvprrhzOz/Q==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by AS8PR08MB10270.eurprd08.prod.outlook.com
 (2603:10a6:20b:637::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.14; Thu, 8 Oct
 2026 10:25:51 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0496.010; Thu, 8 Oct 2026
 10:25:51 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Thu, 08 Oct 2026 13:25:44 +0300
Subject: [PATCH v15 20/22] tests/qtest/migration: add vhost-vsock tests for
 cpr-transfer and cpr-exec
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261008-up-vsock-vhost-v5-v15-20-301b73b3f843@virtuozzo.com>
References: <20261008-up-vsock-vhost-v5-v15-0-301b73b3f843@virtuozzo.com>
In-Reply-To: <20261008-up-vsock-vhost-v5-v15-0-301b73b3f843@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: andrey.drobyshev@virtuozzo.com, sgarzare@redhat.com, bchaney@akamai.com, 
 den@openvz.org, farosas@suse.de, mark.kanda@oracle.com, 
 maciej.szmigiero@oracle.com, dongli.zhang@oracle.com, dwmw2@infradead.org, 
 peterx@redhat.com, philmd@oss.qualcomm.com, vsementsov@yandex-team.ru, 
 odaki@rsg.ci.i.u-tokyo.ac.jp, clg@redhat.com, mst@redhat.com
X-Mailer: b4 0.16.0
X-ClientProxiedBy: VI1PR10CA0117.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:28::46) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|AS8PR08MB10270:EE_
X-MS-Office365-Filtering-Correlation-Id: b17583b1-4bcc-476e-a17e-08df2526854d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|7416014|52116014|260925021911599003|260925021311599003|10067099003|260925022911599003|56012099006|6133799003|22082099003|18002099003|38350700014;
X-Microsoft-Antispam-Message-Info: NXvIzZq5UsNTvqVNqZbq1IS7tx21uGNZEDQ1yZPH/TU9N+uOzb+kTzmyCzrHTMvSSGl0D1drnlo94QZJlY88HxViR5sQzd1QwZwthBIS3V611deTcRJfiXNvxSv0Q4K2Bn92ek69BeAxVDcAaB+PWnIvyW6viTHXhyG8U1t51D36N+GEv+gGeaxY19vNuc8NqD6PLZrjaqPCEcQoVP+LBCM44hbQKuhq1/xyRB4W/2NcVIjXGlIy000Vx8ZhRC0Nu/0idoss6leAM2m+NDuW5v67kB3Jlv9c4O+mO29s7Yb3fgBWwRh71yRJOtn0q92mInGiOB1vsRprqWD14VJL8xRMrkNgenLfuqYO93PP8w1pKS/3+tWlWx6323+Rq9FjwMa9RW/RLvhIzMreS0NX5qRu1DZjOY9X8fQ0zCbMLTlAGdN0FNnS0CM1PvLk8Iy1AxrYbQIl4h6IpQBti7fRukQz0Kih1Ln44kO2C00kJzysFbGAJXev4w/aCWeAnm+DdUR705YW/3DDGRXbdtHEKyz0d8BK9YKaa2c5IIfP7Vt9fwcjdvcvDh8IUE5LP6AzBTlFhMWLBlUL0LjoT7gkQlxnVCgNF77135o1hG3xFTzemiLBqjZlL/HTz6lN/5qQP5ral2yR9ORLQrOtkj4OuwL1UXFn6NqoDl+/bSBur5UwdGLh13cYKBTq62hnxWqu3ksTzdgtseDzPnx2qicyu/YV7jaPkoA+cPHIpY/rcGA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(7416014)(52116014)(260925021911599003)(260925021311599003)(10067099003)(260925022911599003)(56012099006)(6133799003)(22082099003)(18002099003)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TFlSS3lvYVN3bGdLSDg4dGU4Z0gyZnUwSm5GRHVLK3JHWUhyN3QxZDlHdWRh?=
 =?utf-8?B?NkMrVlhGaWcvQzZoVERjY1RRYXZGTU1vRy9oV0psUVNGamV3L0psREszdW1B?=
 =?utf-8?B?L2cwc1RPKzJSc1JVcDhQdHhYTGhnditDWXg5MVorcWpkbGc5YzUwS3I4T05o?=
 =?utf-8?B?NXVyOXMrV1VNN0hWalk4cTdtVnRQT043Sy9NNDZyaTV3SWpTd0hHeHZWK1VT?=
 =?utf-8?B?eGZhQ2pKMnpzeHU5Q3RSWXR3MUZjbG1wQ01QaVBlTDNtSjR1aTYvMEJtd0l0?=
 =?utf-8?B?TDZNQkFNa0VVQ0hZeTdZd2lyY1hIWW5JYmd2ekVScDdWQVlqK3NNdEF0T2hX?=
 =?utf-8?B?bkJQck1Lb1l6WFVPMGZzVWsrN0VnVmhQd2xkVm9oa2VDamszTFdIRHNjT3Bk?=
 =?utf-8?B?RnZwY0F2ZUJCamxGMU5abXlxQUZUS3d0MkJzUFNOckx2bDdPelhrem95d20w?=
 =?utf-8?B?VkFoN3laTUhzS1k4d3RmVEpST0RsMWdiay9HMFppSXZJWThFUnM4VElFaEN3?=
 =?utf-8?B?VnJsa1BRNzNMRDdnbjlSNTlvdmFsbG5FcmliZ2ZsYnpXSk1WR3FxQjBsaE1x?=
 =?utf-8?B?WGZmcUo4azVlRkUwa0RkTit0OEtjaDd0YnZDVTcySUJhVncrbVZORzJsNWlN?=
 =?utf-8?B?OXBMQTRRUE9OK3EwMGJZcXVJMFJSUGNySHdCdU1hZlkyN2RrMEQ3cHpJenpM?=
 =?utf-8?B?Q0hCblVKbzZkbHl1OXQ3ajVxcC94bUZVN3prblJGQ2VzTFppeGtBYXlTc0wz?=
 =?utf-8?B?Q1prK28yb1VyL251SUVCeTVWY29oUHhSWnBXOFRORnBhaTlZRDdDMndWM1Ev?=
 =?utf-8?B?TWF1VENsTXZuQTQ5TlowelRJZHUybExzRnJlbXpocVVjUjREZUZBeDBraVZS?=
 =?utf-8?B?cVBPZzduZ0wzUjc0NG9iemphOHpaOEM4ME5qRnJvZ2dpYkFyTEF0SGZSZlp0?=
 =?utf-8?B?L1gzUzdxRjRzUTMzbUJOWUlEYWIwVnZpUDlNdnhZMjAxWW1WcERVNWxnRWhK?=
 =?utf-8?B?WG5tTlJzV1F4RHpkUmFFeFp5UXZJdmgyQWttbjhwVlVJcCtuYXpKdklKVjM0?=
 =?utf-8?B?Qnd3UFpVYmlISi9vREh3RHhlQkZHYTliQ3Uzb1ZNRTV3Z0ZKY0tnbXdiT3VS?=
 =?utf-8?B?U0dYdzBUSGhUNGM5MXJwOXhCRHRzdDkraytBZ1JvMlB5VDZaS0hodGZ5YzV3?=
 =?utf-8?B?L0I2R0NmbjlnUXlCdGFjODBQNndudkcyclZLQVVRK0h6WUJLOWJoa3lDdGs3?=
 =?utf-8?B?R3kzZVVtSjFQUm9iTXMvbDVRTmx4OXJ2UHIrNzZuUW1SNVErZGt3T2Q5V3Ar?=
 =?utf-8?B?Y0xKZ3ZVdmxSVm9mWVVuYVdpb0JBbGZpcnY1aEErRUkwc2FHMThiR2ZqM2Yv?=
 =?utf-8?B?S1BZMFpMQW84dDZhaWxBUVliR0laczdoOG5hZVA1bHJOdWVsRHV6anpFUTVp?=
 =?utf-8?B?eHRyY0cwejRxbzUvSUtQT3F4WEJtcDVsZHlJV2FJTEYzaXhOdkkzdlU1d1dS?=
 =?utf-8?B?RUtFY1JOeWZVV2piMGtZbm5udnBlMGQ4dmJPTmRNakNVWDd1SHMwMFRndE0y?=
 =?utf-8?B?eWNvdEN2VDdRVUlqZVo0RUVpMmRlVCsxY0UxU25RREdSWkd4SCtWWFF5VDBx?=
 =?utf-8?B?TW45OEtwdzVPVWhUUGJhSkVNSmF0VFFGcXZyWXNWQWQ2ZXBneHFQTExHOVNG?=
 =?utf-8?B?SExsZ1F2QjdweEtia2FtZ2NIWlZ5WkNGL0xGWDVSSmFic3RJWnVrd2E1a1VT?=
 =?utf-8?B?NklVQ1c1b1ZEV1poNmIvT0VlOTdnOFBiSjVwR3NveC96NklmOGlnQ3JGTDhQ?=
 =?utf-8?B?M2FFZlI3YTByQUVKZ1NIbWFtNnhYT2d0bENtUEhJMUlTT1FLZVMvaGVPTUhk?=
 =?utf-8?B?bFM4SDRMZFNmci85ektDQkt3OExlays1WXArdTg5TkZTdnZYZmJzVjBQbmlZ?=
 =?utf-8?B?ZEFkTTcrTWVuMWZRbnJGdjVyOVhSbVo0ZC9xUlpqTTgzVmZkenE4TDdnYms2?=
 =?utf-8?B?UitHYmlTUklVK0RqNUlZbkM5SnpjWUV2alo4dTVhNHNTYUpmRFdpMmo5Wml2?=
 =?utf-8?B?ZDJ5RHdwV0pxM0NJbWxEcWJCdnVUSUg1cVdnM0l2ZGJDY3lKS1oxbEZEWTZJ?=
 =?utf-8?B?NUZ3akRia0FWUDNHN2tTWHBac0ZBRjJuejNINFNTejNsRk50MUNrNUpFVXNr?=
 =?utf-8?B?Wi9SNTY1cjJSR2hpT2JNWWZtZmQ3Y1ZzTytucGU2ZHVIbVViR1dsaU4wUWFP?=
 =?utf-8?B?SzVKVXFtUUtBWFV0M0xYZGc4MW1JM1ZWOVA0dWlqQkZmZnNiWWF5bDVFOW1P?=
 =?utf-8?B?ZDNvbVZ1dmhJcUgyRjhVNzlKeTl5cFBvdmgxT1BCNjAwWitNUFJ4bHVaMEZV?=
 =?utf-8?Q?X1KSIcZghUisyhpQ=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b17583b1-4bcc-476e-a17e-08df2526854d
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2026 10:25:48.7003 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7DNxfHuE3IHmA7VeEnzXdY8TcfTemb4kfsSn75/+junAAMBToUcWVu3FzrLfSy6LyvkD+rvYAuZx8lzrrZgIaOf7pU21knmpu8yOnF6aksQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB10270
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


