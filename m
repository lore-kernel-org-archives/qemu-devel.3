Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F361AC88E77
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 21:02:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6aH6-0001U2-Am; Tue, 15 Sep 2026 17:01:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1x6aGj-0001Mp-Ic
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 17:00:47 -0400
Received: from mail-francesouthazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c207::3] helo=MRWPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1x6aGg-000102-72
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 17:00:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ru+4IffXiSrGMpcIDOpGoUO851e0V42p1yPjtS3uSgeBsS2XtLtEX960aaElc1U6npPHefshLJmbJC4gedRDFQbHSK7BRu0+QdQ2K/uQdcx7X2nYDuaX9jYipp/maC3Yep1vrzZqJLPTmXNEGJsdOwn8APQ+uv4W9hmrw0DYaTwS7c/rO/Rdj+iS7wTLwWXxZUfNRst7bIcM+y7HUHdNmWpxgV+hwRBoAjfsSug1c/incL2RNfLh65jYsj/o3V3i/P0UqRSFnKkwl8emT1r7WuU7cRq9nZxPXVW/inTGrhZ/qL3LYxEmhxY+p6iq2h7VfMdjc/eifzcZODuoUOiZSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qh12CtVAVL9lQ0ICmhFjXMynrjuk0p8D6nzg+2i5aro=;
 b=SVdeGuI1uGnAaPRvk8qJdXZIZUID4Td+aC2Exbbd/O2ICT9KD68JaI5oh1h7Yh1gSuw+XSYXjbQ9Cp5YQ8Ql2ZShC/3rrBOf5o39Zz34hRsKhToffTgFUGHz4eP2GA4IqRbmKcfjHvmlZOUU/n2pxLPh2QAcRgkSdTP7CVMCyJjs5q0TqHFJM3sXyiXudivKedgLdddKD6LIOMM5d5/8C+ESRwIAX+BnJL8DmrvM9eKKI8HgrhUyprC5IMtk1m/zV6xspytEP1+vvDVM/VjZGeAJkAZ4kaAKoot20wbzj7mY+KW+12No5Skeyh2rl6AL2aGsL8dQaKciME7zK6Gz2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qh12CtVAVL9lQ0ICmhFjXMynrjuk0p8D6nzg+2i5aro=;
 b=DJBh74fMwjmcT7xjol009kRAN4ovovxcrWn5PNYSHXOZovSeBygcV/8M6p4a5KX/BVhb+b9Wz/l0D7Ef1Zf+S4d1sRCSco99hxkhDPUS+Dmc9KCqdCO8e3+PK6bDS38x51X5nahdeIyfu9g8TytscVZ5nq2mtCh85+m45KpLZsk7dBd7ZsXUa4+LqDdbw+BHWQJCR+GxirKETgQBWKkBcnH76bkhtO8zVOcemFNDgdB6OeJiCfaNBQKfpAmROgULGtKtxvsZIhEkVATZOv1AUHVVcCOwizCortl1YbeLnCosk8Xegm9cdrgQpdBoSAg5ArF5kUTT+jBWo/maHncR1g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by PAWPR08MB11454.eurprd08.prod.outlook.com
 (2603:10a6:102:50b::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.8; Tue, 15 Sep
 2026 21:00:32 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0428.008; Tue, 15 Sep 2026
 21:00:32 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Tue, 15 Sep 2026 23:59:40 +0300
Subject: [PATCH v6 04/14] tests/qtest/migration: add test for snapshot
 rejection in CPR modes
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-up-vsock-vhost-v5-v6-4-4d31b2dc6afd@virtuozzo.com>
References: <20260915-up-vsock-vhost-v5-v6-0-4d31b2dc6afd@virtuozzo.com>
In-Reply-To: <20260915-up-vsock-vhost-v5-v6-0-4d31b2dc6afd@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: bchaney@akamai.com, mark.kanda@oracle.com, farosas@suse.de, 
 den@openvz.org, clg@redhat.com, sgarzare@redhat.com, 
 philmd@oss.qualcomm.com, maciej.szmigiero@oracle.com, mst@redhat.com, 
 dongli.zhang@oracle.com, peterx@redhat.com, andrey.drobyshev@virtuozzo.com
X-Mailer: b4 0.16.0
X-ClientProxiedBy: VI1PR04CA0053.eurprd04.prod.outlook.com
 (2603:10a6:802:2::24) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|PAWPR08MB11454:EE_
X-MS-Office365-Filtering-Correlation-Id: 22247136-a8e8-4188-2627-08df136c6181
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|52116014|1800799024|376014|23010399003|56012099006|10067099003|22082099003|18002099003|38350700014;
X-Microsoft-Antispam-Message-Info: W5B48jwW10GRmxXM+VxamJzcIdy64Fskp6ioQQIgWOe2QjCJCWw/6jADL6usCEi4krWqFkI1RpYj9gGROq6y2hoNimLu+pTMJJeaaPx0/nzZ1/kFANbHC9hIC+ZZMEgETrm2TsOxcn1JrWgtvxmZF4o1VTAMFYKKH3yZdkh9+KfeK74qtfQbWl5DL6mGkKUNrjlA/+NrZ36yK99+VsBXH7/nsZz63ciwpD86Krb9UvrBqVgp7YeEJyKQJIGVNd8B3f0+l/YO23nHc6sB6A4lhxV3QD6G7hmOkMjgaaHVra6YALOvTd6iYKvWqs7pAHeJkrVh8K86upqUv2YCGaanP8IfOZeQH20apeu39UkKC1SDfEr9Rof41HatqUB2NfyqJPICnTP2KgcbCHKeIb3qy+xmX7LdsJ1Ya0l/rf7Oak+DWNaV99DklP7/oxB2XEbNqLWCtBwnj4AhQkirJMhyoR6m+lB7NyPXvZg/FVS4db4MF57gKShZ2YKwP/njdJPGqe7s5muWU0Fl2INQMDit3XnrtjP9ila55SbK5IKtBmoiQluuGmR5fFysiNDdDU95so+MByvPCnHJr457lfo4f/EE/5uYLPUM3aFxfjTSvbQP9caCFpVuSPdCyzLjlMrZgwEDetZW+2hKfn2rQxsO2l1ptcA5vXm/ivmY7q1IE25xLI3BwCwAyQRLr8LEbWt77kDVGlkgKVBagi8W8n6yyA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(52116014)(1800799024)(376014)(23010399003)(56012099006)(10067099003)(22082099003)(18002099003)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cTd1d1U4T1crNktHSHpwSk1QcUM3N1A5VkVBZWVIV1Z5aDR2Y0gyODNEME1p?=
 =?utf-8?B?eHpSMUwvNjlhcTZab1ArdUVHNk1xeUpEZTFlM0pTa3FFZmZrbElTMVg1bFc1?=
 =?utf-8?B?SkYva2ROUCtBQ05NczI3eDYrZE5aMWR0M3VHd0JRRUorQVNhWUwwWmVtN2Vh?=
 =?utf-8?B?NTFQR3orUFNTczZld1FSZnNTK3BabG81cTlqTlRsS1MxcmV4V1pnVGhIcUNi?=
 =?utf-8?B?UGxXSEdjNHVKcnQ5UzZGNEJZbHIyaFJRaGFFcEZ1VmhTeUNIQXNXWUxrMFlv?=
 =?utf-8?B?Y29aZWl2cytFdDh3Vy9RRFd5WUJMMFR0S0dQQ3ZTUGNFQ1locURFMnFtMWt4?=
 =?utf-8?B?WnY4QlRxU290K1Z4NzVwV0djaTgwaHkzaVZGWjBFSHRqUUdOMnI1cmVvcnFW?=
 =?utf-8?B?ZjZJcXd6RWJsNTNLeDdwb0ZOS3FCMDArSGJlSlN3NkYvUG9YaCsrUVoyUHFO?=
 =?utf-8?B?ZEpqQ2pvWFhvK0x2Y3cyMy9kYkdiZWpkeHkxU0VEdTBlV1Rnd3ozUnkxOVpH?=
 =?utf-8?B?RktISkVGL0lVTFViWVlGY05oVVFvRU8rV3JzamFOcmpLVlR3Z3JUeXhkWGRS?=
 =?utf-8?B?SnR4dUpOYkpnQ3hWR0w1TVpyS01teU5RUW9GVGEvQis4eXgxZmVCQnh4VkxT?=
 =?utf-8?B?bHp0MkJVS1dCY2hEZGJnQkVzWUUyQjZtNzlHVHpWTVdBMFlBc2xkbEZSK0hU?=
 =?utf-8?B?L2h0Wnk1bmZkVGlKVUo1RWJIcElwVlc5cjZGZlViaHcvRTcwVXdvb1FVZG9h?=
 =?utf-8?B?cXBvckJyN0xzOHVMam9NME9UZ2hLdDFjNGhxTXNXby9NbGpNR004cXV2ZDV4?=
 =?utf-8?B?QmtCV3Z4T1l6L1BQSzByOUxYT3c5cDUyRTFSSUl6VGFodEd5bmxyd2poSDhi?=
 =?utf-8?B?WUtiNU1acWFENkpXTUErakpYTXRDSElkd1U2ZWh4YTJzbmlzTTk5RTJmWkJ6?=
 =?utf-8?B?VjN4Ymw2Tit5Q091bU0vL1k4UEgrdUEzUU5yTllyLzBwQkpFbUFnOXh6N3hj?=
 =?utf-8?B?TkVMT1QzY0VpN2Y5T1lrZ0dTMXhuMy94SXVVbnpwS2xmUmlQeHpDY2VrMStU?=
 =?utf-8?B?MmZ5ZiswK0syVjFVK25lNHhNU0VIS01IejRmRmJ5YndtRGRsL0srcEFNVGVj?=
 =?utf-8?B?clZYYUNONzhnVy8vMHNKaWpSRUlDd3IwMGsxT2RmRDFuQWcyNlM2QTZtRXJz?=
 =?utf-8?B?cmszZVlwMEFFOG1tNDhxanZkM0J6aVY0UVFqek9ReHpGNDFxU2gzZVhjTzl4?=
 =?utf-8?B?VWQ5WEt6VVhhUFdwRkwzOXlPU21KWkNDWTRqbEJlcndCakVxdTJvOThoNkdX?=
 =?utf-8?B?RENtYjVXZThxVHRVTmVWNU54THJiYUEvcTlNK0hJUGJtempsREo2cEFQUUZp?=
 =?utf-8?B?UUllbURheWZ4NXNoa2daWDlZL0MyQTJLMGtUNXFlOW04RHU2aWN2QXlxWGNz?=
 =?utf-8?B?azl4L0xWVWd2dEhzYXkzT0lseUFWMENqejAxeE1HOGNkUlBxTjUvejlvU1dX?=
 =?utf-8?B?WCtrM1FWaVhsRUZvQzc5TFkvWmlXeUJZK053ZUZqUzBQUWFPem5iMnhZQmZh?=
 =?utf-8?B?dXNyR1Q3RjJCTGVhajJ4ek42dUFzUklvT0EycmtJZFFtMXg2K0RPeE4wM0pG?=
 =?utf-8?B?SVhUZndzdk9LUFY2RVZ6d3kxMzljZTFzYkxGakVoQW5KUFg4dHBtZkNkMEpq?=
 =?utf-8?B?Myt1WHFiM1dBNElIY1JORHpNTDBzRVFXenV3ejJ2eElqQjUwemQ5MWFpd2Q2?=
 =?utf-8?B?YUd4V3NpQy92OC9PNk41dmYwMFl1d0xZT0VPLzNxcUdUMENJbU9udVROaGtz?=
 =?utf-8?B?VFpsMkx5Z1VCWCtjd1ZpTXpvdlV6NWc4WTRLYnRsRVkrOXA1ZHB5dFlBRFVB?=
 =?utf-8?B?ZWtGRUdoMTM3OHhjc3RZSG4wQzZRZURSZFJsRXlrSjRzSERmT2JZTkNKQmNm?=
 =?utf-8?B?RFNrNHJBTTEwMWdLaGk1TTdmT2lIQ1FVODhkT09tYVBuQlVvNURhakFQWEpY?=
 =?utf-8?B?blc1OFZ4QkxQUmh2enVDbm5LNnI3Sm56akhuMFZmS1l3OTk5c2ZYUW1NL1lQ?=
 =?utf-8?B?aEQ3NGhLVFgrMkRPODJuOXBJM1lORGFaQ3FmdWtYOWQ4OTFqbEFiSDZ1ODcw?=
 =?utf-8?B?dW1NM1JsSzJTZG15NkpiTGswRGx3ZDNLSFNvYW9kdnhCN08xeHMwdkR2ZHFI?=
 =?utf-8?B?Z2ZHZjRoN2hxMHVZYmNWRU0xZ2JQTG1maFptOGJBa0JwMjZJa0hGVk9KT3ZO?=
 =?utf-8?B?aldwRmdJeEJOMFk0WllqYjZOWWNxOVJlRXJZSlBnNWxoWm5zOWNPNzNDc1VZ?=
 =?utf-8?B?eDJPbERkZjk4NDFNaUgveW9qZytZN1RPUjg1cTRZLzNZeGtzNlBueXBPQUht?=
 =?utf-8?Q?rp+LHPlYqQ2EDC10=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22247136-a8e8-4188-2627-08df136c6181
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 21:00:32.4134 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dqx/kXOjkAwhhGpM0ZMqCMLId4GSlIJFD2Pu71ggAPS6dqNbQsMkl5ySWSGWWLhXqdgAphrLijL84UXuesIYr3j2wIbPo8NfWb0VsHeKdFI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB11454
Received-SPF: pass client-ip=2a01:111:f403:c207::3;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=MRWPR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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


