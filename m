Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 170DEC982D8
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 13:48:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7YwE-00033N-HS; Fri, 18 Sep 2026 09:47:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1x7YwA-00032f-P9
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 09:47:34 -0400
Received: from mail-westeuropeazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c201::6] helo=AM0PR02CU008.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1x7Yw8-0003Df-Os
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 09:47:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RBPGO2KWXXJiZLRziFQe3qXiWufIXpEi359Rf1xfWSqbjSmXhdPw6XcVH79UwAy0dX8ts1VpnJe88LzKSjSdTsTSG6A5RO5UFBr0/ly+u6on42Ar7+XEJvfPRbLuCnJiF2iqxkaF607kQyW6xc0A0I2rywvBkne7dp0cxra+B1xYLYvMKkhv4tLjQIvU3yABI6qVg9DwafAcBR4iUkdZkbxbTm+ReoEaL6R5oGgldYb5pdOvYF8V+v+mW/z0/2cmwkOd3LD8lokZX3hfjRWHDz0WhXOMpTYJ/jc404xpppmjmbncd9UQoS+1vEdRLFL+zp48RsB6TF5Cad58Bm45og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qh12CtVAVL9lQ0ICmhFjXMynrjuk0p8D6nzg+2i5aro=;
 b=GO3NPad5ELoyDPq2mSqUPGD6l6JA59dl2SiPqZR0RohmNAj5FSQCkSqp7F+uATX1dmm5TmV6ntYDIdQAf24prC6A9d51J4OABsd1z65mG2AxnYRRCjvpm8IZ3R9uvaf9XjWSuMFXgrgZk6MB/5T9B4lViyaahcBYamrVC+13fOx6E0OkZkjcDIvUbmw5+qY1460hSW2MUiV0ZQEBTYZftwovn0ojAMPYqCYFJhCwO3pwdvTQJTV36MQF/WNfQ5I/XxVwvj2CHOTxmHohSbpjxvtQPORqY3Hiy29R1yTtxVk7dITiIxh0MFn04Vtx/6XbbISMED8Rs2VavTOlANk/Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qh12CtVAVL9lQ0ICmhFjXMynrjuk0p8D6nzg+2i5aro=;
 b=zJDz2yZ+7MlmW6GigwKEgbi+4SOeng8Ae7rO1bRAatTg8cS9KaaD6OLqSdZlJvdIOGmLGhlKow6lI46+TAGQ0pDVGw05eQ9DOCv03Qysh7biaCrq4qbxXVFJbJPsy5Bgqi9MfRv2NQvBRHm/FEpXKQQOWXK8hkJucUS6WAFiBZrtO2Cl3lW5ooXqzzSdjQ1v7OVJEZLQ1aBHP/NYLgIKTX8rLalANneHS7/RTchd3iTRCTyuxi25NKC5CLzCDd2vAFtNdBsh74N0BqUn1JwsLN59datNMQMpiYDkyP3CNG0CqJDQCd6fm+26o9dlmz+KxnoxWBdDO1Z7RiYT2XFZlA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by DB4PR08MB7933.eurprd08.prod.outlook.com
 (2603:10a6:10:37b::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.5; Fri, 18 Sep
 2026 13:47:19 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0428.008; Fri, 18 Sep 2026
 13:47:19 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Fri, 18 Sep 2026 16:46:55 +0300
Subject: [PATCH v7 04/16] tests/qtest/migration: add test for snapshot
 rejection in CPR modes
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260918-up-vsock-vhost-v5-v7-4-6ef9ef033c35@virtuozzo.com>
References: <20260918-up-vsock-vhost-v5-v7-0-6ef9ef033c35@virtuozzo.com>
In-Reply-To: <20260918-up-vsock-vhost-v5-v7-0-6ef9ef033c35@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: farosas@suse.de, bchaney@akamai.com, mark.kanda@oracle.com, 
 philmd@oss.qualcomm.com, vsementsov@yandex-team.ru, 
 andrey.drobyshev@virtuozzo.com, maciej.szmigiero@oracle.com, 
 dongli.zhang@oracle.com, mst@redhat.com, clg@redhat.com, peterx@redhat.com, 
 den@openvz.org, sgarzare@redhat.com
X-Mailer: b4 0.16.0
X-ClientProxiedBy: VI1PR07CA0292.eurprd07.prod.outlook.com
 (2603:10a6:800:130::20) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|DB4PR08MB7933:EE_
X-MS-Office365-Filtering-Correlation-Id: efdcdf79-1822-44bd-bc9b-08df158b5bad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|7416014|52116014|366016|56012099006|10067099003|22082099003|18002099003|38350700014;
X-Microsoft-Antispam-Message-Info: J4AlxPaS31gXB3lLM8aM+H6qwPtpPulum72c/YAcriguCyfQkc4gi+H0MAVVVJmZlC/do2UDQaO7LsqrVQRsqTW0hcV9vrmGt2u1XCK+0Ad+R51nymgTmz5noWj8X33bvafnBV/Em5m2l9utabR8kS+WEsh4V9YV7GRj/aSozbXnfQIJWaUaJyYe9cRJjKZE82MD/DwtO4lEZa8zqqwag06rWpIVIZB7Idqz2kahQ4OaoCiGTiM9crLIJwWqIf7NwJhmHmM6mxsDZmC6TmkwwLrf0wvBTGV0sRNlX8GXfPJl7N4nc+RUr48QTdwSZCmQzxb/XBc46VdRW/3afCi1hjtQveVl4Lfy2KuqQvxPVrIjYOn/re4AoAKAS4qjGq8UmZfPk8H7j/a8dGNbUNOjsG58xQ4Z4kkeV1nC5nhejYBHoiUhD230A3uGcfqgk20fF8usb90JLAlVZ9n/E4ShsOGRQACG2pJ5RIzmlD6+9Xf3T5uk96k6ZXSrKHXYezmoyDT2Nw9KljhRoAowseKmkL5WbL2MPGMgdBIFwRO5jwex/yrjuaB+TmXqFucJvUOca4E74nHPOxmmI6wvraT5m5dQC3jfRJTq3H4Q4IXPKyDO1AXnX+MndkX3C9y5ugqRkWtpGhdsbcghVx9xDvF1ete0H2fiQ8evoIJtfq0dPzW0tBZgSyDuzBG3jWDz/jiRbk8hds0GX0XVrj8sCbZCoQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(7416014)(52116014)(366016)(56012099006)(10067099003)(22082099003)(18002099003)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bDJUYllNdmJxS0duQ1pyQ0ZwYTh4bkMrb01JbEtNVzdBVDBEbkJLaXVOc0k1?=
 =?utf-8?B?TjN0QWpXcVd5NG9qQU53NnNJaG9PQTIwT0xDOXVtRndyekl3aFBDa1J1K3JK?=
 =?utf-8?B?SU1KZjN6aVBhQkxYcEFKazFBN0hUSEVYZVc2d2lQUEJURGdpZnRwRUdsc0lD?=
 =?utf-8?B?dkRuQUd5RTMrdlhUNHlxQzd4WGtRNnp4QWc1cm9CcGkxZXAxOW1rT2FFSWNi?=
 =?utf-8?B?SVUyVU4xeDhTOTFyVFdiL3Njck05NFB3Yjdqb0JOSFVUSDgwNGxYM1NMNGV4?=
 =?utf-8?B?OXdHZWluUmI1UDc3RE1rSEVSTUdmbnQ2NXdKSDE2bDJEeXJxbXhwMW1BdWNZ?=
 =?utf-8?B?R1BBR3hFdUNOT0RBaFVZZVdkT0s1ekpMMzhHSWMxQlVqUlNsazVaNFFjK0lo?=
 =?utf-8?B?WGZITGlHeTZPa1VzcDB2bkZkWFV6cWc0VDBwTlVQK29UZndsNEtMcEJTbmhC?=
 =?utf-8?B?WklmWVJLNTA2Tytra0Zhdi9nSktVcHJ5SUM5NGR5VEJ2QWVmcTBKTG5UWk5Y?=
 =?utf-8?B?ZGNBSFhEdzNid2toOWVzbzUxODBkRHdOVTRydlkyUlVkbkxTOUVPV2tJalgv?=
 =?utf-8?B?RU5reXprR1AvclU4Z3AyRTZkL3AySDFzNVgvcW9nQVdoQnpzV24yL2dMVHJ6?=
 =?utf-8?B?SEZxMzN5WThVeGwwTGhVS3BwaDlWT0N3K1NrYXFaTjJVSmg5YWhLdHV1LzA2?=
 =?utf-8?B?aUh6Z2lXZG1xRTBFUFlEdGprOHBQQ2x4K1kzRG1uemIyZnJxV3NvWG9TV0c2?=
 =?utf-8?B?akJPSFFPV01FY0piVFI3WkZmbExZdW1kM3ErcG5nYnAwR0c3T3Jka2RCamp2?=
 =?utf-8?B?RENrWFFZcjZSYnBJSUswc3RYRkNrWW5pdFNybEZIeGlqcHRxTVpTeWZrdGdy?=
 =?utf-8?B?N3d4enp2TXMwclpYd2pkRTYxYlY2aDJzeVBnNFk2R3E0RHZacVFKNHVpZ0RZ?=
 =?utf-8?B?UlRVRkJRYjA4Q3lLcEFSbFM1R1dOUktFdy9PTDRoQWd2SXdHNjFUVllSRmJm?=
 =?utf-8?B?aStBVjcyWEFZQ0JFSkpNN1J0Um04endlNWlVaVVjOXdkdzBPVW0yd1FGM3hF?=
 =?utf-8?B?L05xaHhvNTRjL0RkRjYvRDF4OUlKa2xYYllIMUwxNVcwNEVEdDVOdGhKWTlm?=
 =?utf-8?B?MEJ2bzBJQTFOVXZuaS9ERFd1Y2FkdUFDdWdDM1hreUt4TFFiUjkreUVkdFRy?=
 =?utf-8?B?RXZDVHZHdnJwU0tRdHA2dTlFVTJzMXltOTZBQVczK3ZuTW9RMlY2dEpMT3o2?=
 =?utf-8?B?bkdNd3RoTG9YQ0l2UzlLaVBCR0ZUOHFxaklmY3hOVXJLMm9sTDVNYitkV1Fa?=
 =?utf-8?B?eHJrVEpGN204M1ErMzNZRmJIZmNsemZ1eVpGS0JMS2lsNmNRTWtyMmpwWGhO?=
 =?utf-8?B?M1RNaElUSE1kekNEWTNCTTNtS01XY2xybjdzV0tzanJvYzcvbXRkN1JxaVdh?=
 =?utf-8?B?ZXVlYWhpelNkc0E5NHNtNUoyZWx3VEJtUFNXL2duZFBsVVdjc3lxazQ1UHZH?=
 =?utf-8?B?SlB6bGd3ZkNvbmNOd2hmYkthbVJ3bTBGU0YzeG9SalJvbHVKc3pmRld4T0k0?=
 =?utf-8?B?OGhvY3FWU0FpL0JvTDl5Z3FnYVB5ZXlEeHllWkpwY2JTVTZuTHVrdXVrUXkw?=
 =?utf-8?B?Q3JOSEgzT05aZmJjVWZweEtFV0RqUzBZMm9zYkd2cTN3eDU2QkNWZzljZXBP?=
 =?utf-8?B?VUhXclhIdXQ2bDJ1V0Npd3hNeTZpeGJkYTBhUU8rZzNRa25vK0pwMndOQTFD?=
 =?utf-8?B?QjBicDlqaXVXQVpNelUyWG9CandNNFpOVjlQOHZ2RzMzTEx6WFlSdm9mdUN5?=
 =?utf-8?B?RkgybGRnUER0ZHhMV2R6N2o1cmhRejFUeXhXZ04weWhCMW9ITXhYZWEvV0tQ?=
 =?utf-8?B?L1dIV1VaOHE0RVJ2ek55OUVHRXF5TUk3cDI1bjdkbHpYZEM3QlZUTE5vN3pj?=
 =?utf-8?B?YStKYjdaZjZpL3M5djNTc1IxaE9Ha0ZmTHFJd1gxRHpqTzQ0VHBnN0J6UENJ?=
 =?utf-8?B?Q0FaZEdNNXpHdGdBWTRSN0xsS0t4Z3BySmh4OWhWOWVkSDZtYm1MYzhLdTJW?=
 =?utf-8?B?bkRwaDc1QmxCOVlBeU5rQ1pwNXdHV2VUVUxyenRnb01tRkxaTitSSUpJdElC?=
 =?utf-8?B?NmpSeGpDUmh5Z0VEcHphbFFWZEdQWVNoTHQrKys2VllLMUdvMHhoMy8wWWJG?=
 =?utf-8?B?V01ZVVRCNm9Rc0s2eWYrTVdWSWp5em1RVzRzVlZMN3ZsaUZrYWE2bmtiVGYy?=
 =?utf-8?B?ZFBSNDR3SXdKdDhzeStNM2lMYXVYbCtMa1I4NW5KN0hrNXFEVW8wME1TajN2?=
 =?utf-8?B?cUdXSzk2RUYvdjJsWDR6andTdFJ0R1JNUFdrQzBXQlN6QncyUGhlUm95SFhW?=
 =?utf-8?Q?jTAJbLHgLljAeA2E=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efdcdf79-1822-44bd-bc9b-08df158b5bad
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 13:47:19.4820 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BMLdfyk8Ki3edtgnOtVlgOrp8gtnUS/TOK60cIukaFwhwC60v9FVlgMWJ7LuFQl6XK/kjA+lobnBNS21+9y2e8ch/2UFCqXq6oXACPKWjiA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR08MB7933
Received-SPF: pass client-ip=2a01:111:f403:c201::6;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=AM0PR02CU008.outbound.protection.outlook.com
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

Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 tests/qtest/migration/cpr-tests.c | 36 +++++++++++++++++++++++++++++++++++-
 1 file changed, 35 insertions(+), 1 deletion(-)

diff --git a/tests/qtest/migration/cpr-tests.c b/tests/qtest/migration/cpr-tests.c
index 0bec753b4ab..a5255193101 100644
--- a/tests/qtest/migration/cpr-tests.c
+++ b/tests/qtest/migration/cpr-tests.c
@@ -290,11 +290,45 @@ static void test_mode_exec(char *name, MigrateCommon *args)
     test_cpr_exec(args);
 }
 
+/* Snapshots must be refused while a CPR migration mode is set */
+static void test_mode_no_snapshot(char *name, MigrateCommon *args)
+{
+    static const char *const modes[] = {
+        "cpr-reboot", "cpr-transfer", "cpr-exec",
+    };
+    QTestState *vm = qtest_init("-nodefaults");
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
+    /* Back in normal mode the mode check no longer fires */
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
 
-    /* no tests in the smoke set for now */
+    migration_test_add("/migration/mode/no-snapshot", test_mode_no_snapshot);
 
     if (!env->full_set) {
         return;

-- 
2.47.1


