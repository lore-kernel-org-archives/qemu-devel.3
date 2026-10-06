Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79E70CA5FF1
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 08:44:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEN1q-0000jl-OW; Wed, 07 Oct 2026 04:29:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xEHhP-00061D-Bf
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 22:48:29 -0400
Received: from mail-northeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c200::1] helo=DB3PR0202CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xEHhG-00042F-J8
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 22:48:01 -0400
Received: from MIWPR08MB285920.eurprd08.prod.outlook.com
 (2603:10a6:290:aa::21) by DBBPR08MB6155.eurprd08.prod.outlook.com
 (2603:10a6:10:1f5::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Wed, 7 Oct
 2026 01:08:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rne8CMKbidci2X4RAahmx8DyfJ2Nln07OAjrcofCdSLIfnyVLcKT3BGR8gCgKcLr3oe5awepfYrP+95p+Oq4nTm4pV8n1TD32jUKCTLiFP3OBmmkupT/yzmNABZX91ZXB/vsTyc9GprkTn3lUXXKUTK3XYbcR1aDE6LtYg3Bte5y7DHB0sIAI30CpJ5DPHPRWFucVJROjl8j/yNx24/+IxZHoYwKItA5oG8YKlsj4JJT16d132l+PnFufsxky7lBNwVv3ezWxrPbgbIE1WMa+uwVufWCk1bKNNAwjABbVeqUnoZ/DEHVmqqvS8v1WTP2PxB+k9jmekbhXsGX+jx52A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=De18djxtHE2E9HKgY8x4Fskcmy6Hm5lIvLp+NNMBlUg=;
 b=KMSWuEGbzVlDXxbh85S+ZQab4L++n7R0v8HQ0xdxbnQree/ZmdwV1sbyyyFuW37GuxjXx/TfN7T8naec60zHJ2JnxBFwfyvq0Jk7kNpz0PNFbjcHKdtHZA52zVXQDl7qDpTLdiI5TXu8xKvT2m06K6pN+V2SlVh1fPwLLI9XB5J6Z0CZJfcFci/uGOXaKyVNA9s+UbYqBxDuOL2EP/DVt4lJeCu+bAlaNwT1LN8beufKQ/YkWErea6SE/ry6pYO8n+rJWjTKB24MPWM2d15Yv4HVa5xFz0xwCqZASb/11ArTbsPI6ND4KB7TWl0JVUc/gW01x0efZxVo+EH8G3E5dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=De18djxtHE2E9HKgY8x4Fskcmy6Hm5lIvLp+NNMBlUg=;
 b=b4+mU4OJ+fFUaQP/JSBhQHLPdBUMJYXF9KOyQbp3sEU0/rN8ktMhS/58CnMUl3kniknzdxLP+dezmqQf+Ecyp1MAgUNkM/AWXQ3fDG8/kjL13GaNhgZfZxQvl05D9N5TYuJr9DZK3UR/cYWppDpgQa+QoIM+3/iTEdS6X8t5rsx/ktoE3t/6R+K8jnGmncwitUsoLM5apiP/kPlDoRs9iiTxBr2g3y9KYZPwuno/QeZezxkfUqecIV2MdDwzjBSfUa9vzXcE8eG55DZlDKIJ78pyO02pkaxozjXEkwpnx0+Br4q6yACR5RQ7VAu335r8MCHGljjP0ZTnKwi6yyFyrQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by MIWPR08MB285920.eurprd08.prod.outlook.com
 (2603:10a6:290:aa::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Tue, 6 Oct
 2026 13:58:52 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0496.010; Tue, 6 Oct 2026
 13:58:51 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Tue, 06 Oct 2026 16:58:28 +0300
Subject: [PATCH v13 05/22] tests/qtest/migration: add test for snapshot
 rejection in CPR modes
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261006-up-vsock-vhost-v5-v13-5-2ea78fd1b7ed@virtuozzo.com>
References: <20261006-up-vsock-vhost-v5-v13-0-2ea78fd1b7ed@virtuozzo.com>
In-Reply-To: <20261006-up-vsock-vhost-v5-v13-0-2ea78fd1b7ed@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, maciej.szmigiero@oracle.com, peterx@redhat.com, 
 odaki@rsg.ci.i.u-tokyo.ac.jp, dwmw2@infradead.org, dongli.zhang@oracle.com, 
 bchaney@akamai.com, den@openvz.org, farosas@suse.de, 
 andrey.drobyshev@virtuozzo.com, clg@redhat.com, mark.kanda@oracle.com, 
 vsementsov@yandex-team.ru, philmd@oss.qualcomm.com, sgarzare@redhat.com
X-Mailer: b4 0.16.0
X-ClientProxiedBy: VI6PEPF00000229.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:808:1::8f3) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|MIWPR08MB285920:EE_|DBBPR08MB6155:EE_
X-MS-Office365-Filtering-Correlation-Id: da2ccb5c-7344-4de1-44b6-08df23b1f3d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|52116014|7416014|23010399003|38350700014|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: S43YzkBcbFXL+wjJwu/ny+RkxkE+H8Ol8ZRze77/8LLIVCuusBd4tYhI7yMG3QSGO+eFxCuaTQ9BVwioaq5AjT4jsrBje54ce6uqWbj303LlyITrxtg97domGBQeT0Y8KXeriiR7Y3kJCX7Xm+ZuCh+bL8w1s4b6cNaim7wczKjPCSeE4BYHIY9I13R57F1O2rS3LJIC4//ign12sowUbzCmWlWF+D5VOTtQUnbUC+QLa93PCfLGMvqYirjvbw8F3+qr55W3G374tQJXk0+lIWOM8C+aUAkpShnqX2V46+6OxBMCHsAYjtEJwggK5tlVxKYIbAxc0sj12rZbq8m4Tm7sL+L51Lj47ckQNfpcUBALtazGEHSfX0xB8ZsMPBxnYu61rqFlD6sEEbh4JmxHLT4GmVeLhj2PjIiBkqF95T6JBYD4zuMpFh5rGpeGm2QhmITxwayxEFbD9HU3hvHfTlVejj99r+1MJOVvOzDBM+bzCGDfu8Ww+sZwnYMW39IGEaGWWjdhBz2LiCEoS2ZFE50UOq+NLgSWYjLPrbZkVyxmakcfXbQb88++pPyxP4LvYr5d/L3wjgOpDQ2KStea75P9THKS+L1mcceQDp7ELM+HxKNDFRWH7Eije6HhdgZT2dse4d6z4AOC63YmtgLHUKlK1L2QISxry4JYr35o8jjbpnGzmm4B1684oPg6Cs3y87/HkTg/L0wUGqMbUl7fFA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(52116014)(7416014)(23010399003)(38350700014)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bG50aFcwV1lqeFc4Wno5aEx4aFFoOG5wZkxhcmxvMTVXd1NmWkdhQUJZWW9H?=
 =?utf-8?B?b0RRaCsrQzZhSlk5SHBIbDgwb0h4R2l4NU1BVzVCeHhFWVp1OWg1TVJ6UUc2?=
 =?utf-8?B?SWFjR1dLa0JXV1B6SDlHTFQ1aFdSa05HMDlyZlY3bkU4YXR3WUdTcjNBU0Y4?=
 =?utf-8?B?NzNVanpTajAxU3Nzc1dkeUV5b2tCUDBPMDNZZUVkbzlJdFF3R1hKSFBRMGtB?=
 =?utf-8?B?Z3FydmR0NmFqQUp1MjBwaS9OK3Rlbjh5ZWFPZ2EzQzNkL0JCb3J5c0owaDUy?=
 =?utf-8?B?ckxQeTYveEd2ZGsxNC9udCtldEpXSUNVSlhJT2cyajhLdnVhQ1dtdFVzdms5?=
 =?utf-8?B?dkFadUkvbm9WTWpnemN0VGxzcEFLYjQ0cjhZNUhtS3p0aGQ0dTZEQnYwek9q?=
 =?utf-8?B?YXZlSnJxeTlLK2h4VFhiWjRvSkJSZ0NKNityY2d5S1ZqQTUxc2VCWHE0ajEy?=
 =?utf-8?B?UHVsOUw1RGlZV2NVNTZJTk1Hb2d6UEpoT3c3NXgzcGY3b0dTSFZ5RnJTazF0?=
 =?utf-8?B?cjNKK0hjZnk5WjA3TjF4ODJsd1g5UzNEMlExNC9vZFBIUTgxR2xXVnovQ3JM?=
 =?utf-8?B?VkpFbkk2RTIvQWw0YVNUa0NXNVFrU2RjWnhlanloeGZrWGdkWmozamhLeEN5?=
 =?utf-8?B?RnBFaXRZMktlZWpZTkc3SG5GSHpTYno2VjZMc3A2WFl1NVp2NEdDVkkzd0Rw?=
 =?utf-8?B?SjhlNkE5WXZaZ0dEam4rTWNpN2xIYjBvSkJZNUZIZXJwRFYrYXllenZ0cTA1?=
 =?utf-8?B?VUI0WGhLelBIWXZyMkFlZE42WHNvKzMxeXRlOGhFN0p3WHFxM29ZMzd2ZVJ0?=
 =?utf-8?B?cWJzd3JKT0RVcHVaWDVTQUF6Mlk0anZ1NjNHc01BLzg2bVljNjdUM1F2bUJ1?=
 =?utf-8?B?czFiY2tudVRnOER6czYzY0M0SWo0WVNkNXBkTWg4Um5Oalc1TUEvaGU5ZjU0?=
 =?utf-8?B?dVJSYnBXOUtLVjFUU0JqT3plMFZiUmxEVUd0b1V1NVllVm5RYVRuemhJeG5U?=
 =?utf-8?B?QWxMdGQ4dk15OWExUVNKVU1VNk4zanFFaDV3NEtWbGcrYzlaMVBlbnh4Vitz?=
 =?utf-8?B?cElyemFOaWo2dUdQN1hsOU9TN09WYVU4TVlmekRxYTArTXBUak9oWXFKd0Rp?=
 =?utf-8?B?SVB0OHNUaWswbzBKLzEvN3pkUlpDNVYraUpaSGhWb3BPTWc4MmVFcHlhSWdT?=
 =?utf-8?B?SWZ6K1Vqb2p6Q0tiUkhHYjNoTDB3NjhGRVI4Zmd1K0RqUEI1ZnA2dEQwU05E?=
 =?utf-8?B?WlZxSUcycm02NFRUakFLL2NhSXlvSVRmOGxRWkEzakdMbWlGdlNLSTAzMjQ1?=
 =?utf-8?B?Q1FjY3JxOGFSaVQ5SXdrdXI1TElaWStVaU4wQTJRTTlzQUpSY0RUZGRaR1l3?=
 =?utf-8?B?U2xCdDNmVGMxeHF1WTlsbjR4bm5MdFkrM1NmeFJQZ2hCSm9QenpVMnFEZlNu?=
 =?utf-8?B?eUp6N004c0hKMEJwcFFSU1NXcHp4WUhaV1VmeTZNa2Z2eHlFazZaU2xXc0pu?=
 =?utf-8?B?eXlBak55dG1pOUZOaXpZQm9vMWtTU1I3WDEvYXlTcXdiUUdmYk5lVTBReGk2?=
 =?utf-8?B?NnhnVSs0RDgxbTVwQWZSSmY4YWxjVjB2MHAvZllPWk1QcUs3cXRBT1RxVVRh?=
 =?utf-8?B?Sm5JZDF1cUd2RkQ3WXJEZEp1RSsrcjdHUExhVVBBSzl3MXQ0TUYwejhJUSt0?=
 =?utf-8?B?VGVkelVBY21KRlFsWkVxNEpTZDlVV1pTUG9nTUtQWnhpMFM3eUxyV1N4bVVD?=
 =?utf-8?B?UTNqR24xOHpsZkZlZHpyaXIxQ2xJZGVKTXZQUVU3Q0F3aW9yTnVFVzVTelZj?=
 =?utf-8?B?d1QxUDFYRmpTbmJsV1kvbUJsUVZFM29hVFVpSkJ4UkI3dUZ6NituZHoyT21I?=
 =?utf-8?B?R0xlRzV6Rkk0Mk9RbFdoeUcyU2hHY1VxcWdkb0syVWg1NlFidlJFeHFNMFhR?=
 =?utf-8?B?U0FHUDFORlRHVlhnZmpITzdjRjBqdVRPeURWZjNOQU9XVEdQVS91OGMrZ1JS?=
 =?utf-8?B?K1Mxc1BzMFBPZ0UrWXFlUDNybDRvVGE1NExqZ29qUlM4UlArL25qdklJQ1Iv?=
 =?utf-8?B?WmFwcy9VeC9lRk1OdHBkdXYweElac1NkTzVIWHUyM0IyNXNya3ZEbWovRmxZ?=
 =?utf-8?B?eXV1UHA1NG1qbjBJOCtZNmY0ZFdiRGJ6d2lXbEJpVmQvaUVvWnJhbjdsSVYy?=
 =?utf-8?B?MG83b2NKKzNQazA4QkVzMjZVdDRVUE8wdXlCb2dRcEhpOVgrRVZOUWJDV09C?=
 =?utf-8?B?ZHAwd2YvelZvTlFnL1F1Sm55Ym1BU1lrQXdIUG1DTjFkelNpRW9QL0tqcE5j?=
 =?utf-8?B?S1Z6U3crTjY2ZjJuWGhpZDdlZUhydTQvTFhQMExwKzFsd1ZQbllEOStUdmtD?=
 =?utf-8?Q?iHX+YjIREGJGgYig=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: da2ccb5c-7344-4de1-44b6-08df23b1f3d7
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 13:58:51.8313 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +lEhOAhfShPFglnavo0tOMDRkE/o36PbMfzeUunyNyOa3QfqBilqFEBGNT81MdBWUxaEqKjggpvQ0iYWhDe5DI8YU0YJYnAPMDXwc9wT3jw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MIWPR08MB285920
X-OriginatorOrg: virtuozzo.com
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

Snapshots are refused whenever a CPR migration mode is set.  Add a test
which sets each of the CPR modes in turn and checks that 'savevm' and
'loadvm' fail with the corresponding error, then switches back to
'normal' mode and checks that the error is gone.

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 tests/qtest/migration/cpr-tests.c | 40 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/tests/qtest/migration/cpr-tests.c b/tests/qtest/migration/cpr-tests.c
index 0bec753b4ab..05c2ac1336d 100644
--- a/tests/qtest/migration/cpr-tests.c
+++ b/tests/qtest/migration/cpr-tests.c
@@ -290,6 +290,44 @@ static void test_mode_exec(char *name, MigrateCommon *args)
     test_cpr_exec(args);
 }
 
+/* Snapshots must be refused while a CPR migration mode is set */
+static void test_mode_no_snapshot(char *name, MigrateCommon *args)
+{
+    static const char *const modes[] = {
+        "cpr-reboot", "cpr-transfer", "cpr-exec",
+    };
+    QTestState *vm = qtest_init("-nodefaults -machine none");
+    char *out;
+    int i;
+
+    for (i = 0; i < ARRAY_SIZE(modes); i++) {
+        g_autofree char *expected = g_strdup_printf(
+            "Snapshots are not compatible with migration mode %s", modes[i]);
+
+        migrate_set_parameter_str(vm, "mode", modes[i]);
+
+        out = qtest_hmp(vm, "savevm snap");
+        g_assert_nonnull(strstr(out, expected));
+        g_free(out);
+
+        out = qtest_hmp(vm, "loadvm snap");
+        g_assert_nonnull(strstr(out, expected));
+        g_free(out);
+    }
+
+    /*
+     * The check should no longer fire in normal mode.  savevm still fails
+     * (there's no block device for storing the snapshot).  We just check
+     * that it's not the mode error any more.
+     */
+    migrate_set_parameter_str(vm, "mode", "normal");
+    out = qtest_hmp(vm, "savevm snap");
+    g_assert_null(strstr(out, "not compatible with migration mode"));
+    g_free(out);
+
+    qtest_quit(vm);
+}
+
 void migration_test_add_cpr(MigrationTestEnv *env)
 {
     tmpfs = env->tmpfs;
@@ -300,6 +338,8 @@ void migration_test_add_cpr(MigrationTestEnv *env)
         return;
     }
 
+    migration_test_add("/migration/mode/no-snapshot", test_mode_no_snapshot);
+
     /*
      * Our CI system has problems with shared memory.
      * Don't run this test until we find a workaround.

-- 
2.47.1


