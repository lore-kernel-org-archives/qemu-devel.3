Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5712BCA5FDD
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 13:06:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCcwj-0002ty-U5; Fri, 02 Oct 2026 09:05:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xCcuJ-0000op-DH
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 09:02:38 -0400
Received: from mail-norwayeastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c20f::7] helo=OSPPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xCcuH-0007RG-EU
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 09:02:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ygJ29FORRYp6GWsHL+msWXMR5OLATgRZYraySCGU40kQIflnyM41Yy9/1F0Neq3mJXLWcavVq2D+616MEl7aQ+Q0UCLqJhNxUkqDfKV3jiVCh8dph5IeNS6EG7H9ZB6HTGrW2HZfy7IBiQREt2H6gNinjNdLzQUQwVApisFxMZMzlQBu9Tf2XZAcH9ul0ExwPgAD0J+QSPieWIYBzp/CjdpGJe7/xPs+6beZCpMUUQaokmcRys3HlKrOcY/G8TZfOLP2Rx1Zxa6z97iFqQFPEo5uMIq532M/KfywvBlsv41OJ0RMpg/MZWVEpPJhoTZJBynfBt7k1zDNx6mlnIqt3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=De18djxtHE2E9HKgY8x4Fskcmy6Hm5lIvLp+NNMBlUg=;
 b=ynG8S0PbjWzWvAXBK1D0fFpb+uOrQ/e8E13n6p/U3QkIQYao/rM9jCTd7ZcKyd24gLUAJwHZ1cR374y/4Jjax600w7GPM6zSSre69tA0jrEtAPuRac1M7IxazHd3JOYFD8Wzy14SGbXrae/BaprjGDtfVGCFHG88JCwg28SV5gwCXt4WrWfo1RJQ5Yd8N2wmhYpUBaii3JJZC3n6JT6iSYfFf1KtxKotvMhKm1Uw4XIVWlRXjPU9Ns/A3ZTfEsCJoOw0AT7wggLtr0ByGiqhmWWaVm07x564sZuoo8yx2MS4/g4UXDYgoBUwLe/L60U26pKMZwtql61FWKlwGKKgxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=De18djxtHE2E9HKgY8x4Fskcmy6Hm5lIvLp+NNMBlUg=;
 b=aZXbSDY74rr5mLj0ufAovwoNFkaWRDvulo4V2BxEZWeCa45iRu1XX3vQbxOqWN4aEwjPn5zHl3xJGdF2AltiezENmaxnQOU+ZADl+VkDaSPxnQhePZoWtwUtIG4AFdgET8sbihTfqrUvn++pnEyEo8gzKZ0Gphb+eV3R0lSRzrZ8v/qIge2vJ8gHrjCzzVpVyhZWpkDjjODA5wSZBMQtCAEi2ALUVq7RFIHpQBv4Ltjw7h894vJW98d0ePLNoO1EECK3z0sayX3KMN9rln822xc2kPLJnijSVxzjy2G9dred2ZbROj/UaTAHx3JkMuKKodVva2vA63M1k0AsXYdI5A==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by MIWPR08MB013052.eurprd08.prod.outlook.com
 (2603:10a6:290:e8::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Fri, 2 Oct
 2026 13:02:23 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0472.012; Fri, 2 Oct 2026
 13:02:23 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Fri, 02 Oct 2026 16:02:14 +0300
Subject: [PATCH v11 05/19] tests/qtest/migration: add test for snapshot
 rejection in CPR modes
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261002-up-vsock-vhost-v5-v11-5-18fa09d8273d@virtuozzo.com>
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
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|MIWPR08MB013052:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e08dba6-a5ef-4c46-4bbf-08df2085669a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|7416014|52116014|23010399003|366016|38350700014|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: Q6KKbHSM+m7TiUcG/VR+hJI96GTMNGbdDSY+3HuJG/vcKBeXtKkOvBIqoAKCyFugAHXyWsQtNBtseirHLt8OroqSv3GfBvepxxwa8MeCQ3Bxqv2zto3tflEfnnxtVdZJRhphM/+OuOzGYen6CMh5Y99Fg+jlrrqW3lREn1jz0NKwOJv1ZeJbcsiEiSJQ/O/S5Np2XAGKVcvAy0uadpQBZQZojeW+iXcEnO/HP6xHboLPLuajPmf6mdICWEZFCl7+ME+KIdJrXyLEEyN4l3zUcnkV+fD18KDmDTDwsJKJmI9SNaPYaGoZPLqNvto+W7YgThso3FhG6UH/0S1mbYgz00Mnpt7mY1CHJ+kgNrNdKdQ4WDAaSyUA6IkNfxslFcHmDleFYv2AHqiLabVilWMoBj12O86klbcvMhautCzcWj4ZmvG8z6lZ6GUdVTCBkMPT5jW5qEpGwJXXNFNmzTAJdcSvZA5Y7Ba4UxK7+Cgn9kevcY9RBwT3qTGjJETcopc5iBC6lmy37DV6NGqRIfYPKz/RGiFqaCq2gkl5sMLaK1hvsPK+9/M2jin8Evb6TF8R2qHJPPnEjFr27onWO+DVTUP4zkfLFhB01xPKs2qY6A0GXWqRjYx8gBedrspNRVwpSGC8G79VE8JUPiTI9T9sGzYzzc+EZjz05daCqK4A6tzhZzO+cstam6K+BboxERvU8n4I+syCr5buOhhWXBdeIA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(7416014)(52116014)(23010399003)(366016)(38350700014)(10067099003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TzVqMzEvZ0dsRmJZZXFobG92QS8wWkNIRWlXR044WldMTXhwYXNobEVZOHhj?=
 =?utf-8?B?QkR1K1JJcXVmODZlU1VDbnVXSTlmUDcwQ2s0bWF0Vll0cVJYdzJUU0Y1bTZG?=
 =?utf-8?B?YjYvejB1bjlCdFNjYklxek9WcndScitNY1ZoTXloTCthaEorTmE3a1o3OW4y?=
 =?utf-8?B?KzlqTUtMTndHaTJ1aHpRSjVkVGdmTU5KQW93TGM3ZHE5U3FlQ28waEYvSnlj?=
 =?utf-8?B?TGF5NUc5dmdOSUVuak02YUJSRC9rb1RYVVVDTmxidm5qNEl3SW1UMVZ6NW9p?=
 =?utf-8?B?MG42NHoySWMrRUlHLzNwMVNHYkRqbjVRbloxY1VCYjVkNHFEUXpOQ0JpR1Zp?=
 =?utf-8?B?a2pBRS9hWWxVeHIvSmtZUHphRzkyWkplZmNmbDRtSU0xc2hSeG45L09ha3pk?=
 =?utf-8?B?NGdSekpRWU9hTlFJbXdlTmkzbUhzQjF2K3BBcEU1aUpveXNWRDYxOStJMWNR?=
 =?utf-8?B?dFJrYjUxZ2FUYk1TQ3VOWjN5bEhCZW54OGRicXg4UG1EU1NjYUludHdIOUpl?=
 =?utf-8?B?bnVNS0l3NEZ1dWk5VzB2TVYyN25YODJzMmVRSU9RUmU5eE9yMUFqTEVZU3dh?=
 =?utf-8?B?aVcyaEN6RWh1MUxkN0FsTGg0ckFuYzUybVZGL0Y5R29nQXloUmtiQ3VqK05y?=
 =?utf-8?B?bmNZSkVCRlRmSjFCbTFrVWJUMndUdnR4b3V5V0NBQWZzZElrdmtPeEw0VHBF?=
 =?utf-8?B?TzhEMUI0MzRGYUJ2WUQ5UnVGNDhwc0k2akZOU2xOa2U5WTJWY3lSMFdvVW5J?=
 =?utf-8?B?ZWpXLzN5ZDJjRTA2ZDBheUFrbXNUMmg5bktvMU44cE9JS05IeFdURG80emp4?=
 =?utf-8?B?d2xDalljZDNoZ1RHSVlieEVhdDNjZ3gvVllLWnhESlFDc09oMFhnV1Eybytq?=
 =?utf-8?B?K2lTbDVZZ1QvTkplZnhJUFFaMmtvcUJYblZUM2dJQWJLL0FRODhiNlltYjFX?=
 =?utf-8?B?N29zcnhNOTZ3V1FiUHZoelNTcVEyd0MzTVFlVUJVL3ZJVlpUYisrdjZoeEQz?=
 =?utf-8?B?OGJYcmFHNG1ZRUE2NUsrbGVCaStLMmoxVHd5a3pCcmk5MzJySHRIY2h0VTUx?=
 =?utf-8?B?bWtpRHVDdWJuejlSRjRvN24wcEc4VGhoN3A5aTdNMk1UK3grSnZWSmQ2d25F?=
 =?utf-8?B?cXFLNkY5SjgxcTJ6NTNwYVR0cUdwdmw1dWlQamh3a1NNbHR0bWNHMzVaamlU?=
 =?utf-8?B?WWJoc2hjM1FLTlNWSTBHcExBTmtteG8vcWxiTHY2cnNGUFhaVTcxYTFwNUx0?=
 =?utf-8?B?b1l4Zzg3U1dHY1hrMmt6SURBVkF5cHBRTG44cldsOUJnVEkzRExXZnQ1K3Rp?=
 =?utf-8?B?ZFBOZHpYZWdDZDNCVmZVaE1qZWt0cXEwcHpuZCtuZXBESk84WW4wVFN3WXRa?=
 =?utf-8?B?Vis5REtlajJmcElCSzZQbnc1aXdONk5OdS8rU0xWZXZwUkJzTmZkcXFxSm1J?=
 =?utf-8?B?OG1SYkpEK3ByWFBoUnJwMThsZ0Z5L3B4Vzd2NjFFSDB5WGxEUy9BMGVvWTI0?=
 =?utf-8?B?VWp3SFF5NFhtL2c3dmR5blNiL1BGZE5rVUcyOEJaamZSbGxZdnU4aW0zeDFZ?=
 =?utf-8?B?aFo1czZwczRDMXFFSEpOZTJ6TnJocDhuY21KdmlVM21vOVNQY2ZOdktPSW9z?=
 =?utf-8?B?dGIwK1lJYjA5dGVHdFBjYVlKb1czUTlCWmpRQXgrZ2Z6NkZVb1g4UEd3VGE5?=
 =?utf-8?B?S0c5elRaNmJocVZ1ZitJa3JDTm1UVWZFcmJFMnhRNm9qNjEybjlmNzRJaktX?=
 =?utf-8?B?ZzZnQlRWNE5TeU4zTVRwUmorZE81ZlJxalhlSTBZVW1NcWtvVFd0QWV1MFhu?=
 =?utf-8?B?VTd2NXlYQVVXS1NzQ1EwTUpDL1JMZGFFWkIyRXpucVhZL1hVdkFOcWJZVHN1?=
 =?utf-8?B?aFJZYnZUMnBBb1Jta2RuU3BldGJ1S2NiRlA4RE54U1B6M3RFWGpWaFNDNE42?=
 =?utf-8?B?S1JoUGJPb01jcmhSemQ0Q1B0UFhUOEhhc2dWUnJwMC90R3kxY3BkbWtpcERG?=
 =?utf-8?B?R0tOVmZGdEc0aFZZUzZLdHlwV1d4V1pzMW81T3BWN2NnTCsxYnFzNjZCVHA2?=
 =?utf-8?B?R2lhdUtTMHd3dlUzWmRYSTMzMDQ0aEo5SENEN2VtNDd6b2E2ci8wMFkvMDdp?=
 =?utf-8?B?MXBuZDZkN1RnZ3dYY21RQmdCQm91V0JYYitBMjhBUit6RFlYT2UvWFZIVlBO?=
 =?utf-8?B?V3BKT1lXMUlVbUZVYkw5aWNtL3p5V2Fxd01sQmtCNGNvczJKZE53ekFjeml1?=
 =?utf-8?B?OVNseGJ2SlNQM1UwcEtZZ2ZjZFFFM2d3WGcxSDlORDRhaEw4emwwb01vbldK?=
 =?utf-8?B?NU1NcExMYVdyb0tNK1cvOUltejBJdDFTMVFoSmFLUktrTTBsMjhqWE1xTWRa?=
 =?utf-8?Q?O59sBnOx1zn4R0Fc=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e08dba6-a5ef-4c46-4bbf-08df2085669a
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2026 13:02:23.5867 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iv6GjMHU0Wwdr8UWYSE/qDUS6G2SGLkZ4BXr8HSsrt+8pnpnQeKKMF4sRKEtWwbZ0gwSIk8rLNqZHrMc3kwaFdEYcFuQtA0dgvJsYQS82yo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MIWPR08MB013052
Received-SPF: pass client-ip=2a01:111:f403:c20f::7;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=OSPPR02CU001.outbound.protection.outlook.com
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


