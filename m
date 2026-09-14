Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C88D6C88E50
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 08:45:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x62Jl-0001Sq-Dg; Mon, 14 Sep 2026 04:45:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1x62Ji-0001SA-0f
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 04:45:35 -0400
Received: from mail-northeuropeazon11020120.outbound.protection.outlook.com
 ([52.101.84.120] helo=DB3PR0202CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1x62Jg-0006Wy-4D
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 04:45:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bQw5c8eMVYamEl2WLTKMMfAkq9wjaJsdN/xFDq7u7H3ZxOqp8a2uZZIB945GM9p2bFYzdWjNiaEsBtE2SivJFAC/SP9SZsudZWDqXL2H+sFsUX4BFs/aOYPIMVEBKaI85iWQDrfi/MJj9UaKLZE8CVP+ZcE5pzztbh24vmg9dRehy1kT6FDxdl62RY8vVnxN47QiqjlVB6r556mTCOf+pqdGvt7FTh1xlCjlKPItHliPDSSAIaVhEQLPy0bwKD3imqaSu4uIAguvF3/zrAIuRGwEWyrggV8e/Z1n53TmI4hd3rhbY4pE98otrm2fbsvvPe2YQUz31JITtplvAkySYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qh12CtVAVL9lQ0ICmhFjXMynrjuk0p8D6nzg+2i5aro=;
 b=sCg4xEHzF/wWwPe3auunfLWN68uvKPgaIfevYvV3qs9pI12ad/2YJE15j2Hr7g5ApFjngLW7emTg/zA3BxrbqAGzHKMaXaMhGE+Bg6jgOP1Avt32QrxG+l2zd55uwiYY1RbcuC+304EkAAbv0ju8SfhJpwSJfUrfRgNPv32qY/zQn5oP62E27O9U+IIFYDAD+7MY7vByxnk/SPGbNCmg1ekfJyb18Kv2aPOc0eeRzAPUcsgoopZVGGec/2yihUAQRKHCMzP3gV2dsxf3tNCe5hqIYhHjDbE8XdIpEa14+QUGW8wtCSSUKl55BURxbpgfTvPkuPr75QeplQtcpF4cug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qh12CtVAVL9lQ0ICmhFjXMynrjuk0p8D6nzg+2i5aro=;
 b=pH1yYkOUfqxgCRmIWHKcllApmre7lCyWIQKwqM5F+8gra2upJ8Ff4U5wvHwVSfgYGWuAaW9BQbM75xk+Zuzvx8huRcbSjkoY5iTOv5wMs6FRBy/3+1+M6OmsPuj0tTT9LGgThDWYH1qDWsCNh/7dVQn7ZwYOeMGyWDlrFTUG/XL27qKtkBKYsdnygOWFoxMKN7PtkmfRDVHcTis9fS2PTgWZRss0SGbMROiGCp/XZRoExnaQDfOss9562Bosn47jn3cK3WxSN7Acf3ezcw6zDE3ZK0VZ1Hj8X7dwH2opHdjS2XOPEkgC7C3PF3jiP22DLUG7za25gTKqtB2ND0qPRg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by GVXPR08MB10916.eurprd08.prod.outlook.com
 (2603:10a6:150:1f7::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.7; Mon, 14 Sep
 2026 08:40:24 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0428.004; Mon, 14 Sep 2026
 08:40:24 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Mon, 14 Sep 2026 11:37:35 +0300
Subject: [PATCH v5 04/14] tests/qtest/migration: add test for snapshot
 rejection in CPR modes
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260914-up-vsock-vhost-v5-v5-4-d17423589f48@virtuozzo.com>
References: <20260914-up-vsock-vhost-v5-v5-0-d17423589f48@virtuozzo.com>
In-Reply-To: <20260914-up-vsock-vhost-v5-v5-0-d17423589f48@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, philmd@oss.qualcomm.com, maciej.szmigiero@oracle.com, 
 bchaney@akamai.com, mark.kanda@oracle.com, den@openvz.org, farosas@suse.de, 
 peterx@redhat.com, clg@redhat.com, andrey.drobyshev@virtuozzo.com, 
 sgarzare@redhat.com, dongli.zhang@oracle.com
X-Mailer: b4 0.16.0
X-ClientProxiedBy: VIXP296CA0028.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:36e::13) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|GVXPR08MB10916:EE_
X-MS-Office365-Filtering-Correlation-Id: 45bc47a9-8f45-4181-5813-08df123bd0b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|52116014|23010399003|1800799024|366016|10067099003|22082099003|18002099003|56012099006|38350700014;
X-Microsoft-Antispam-Message-Info: yZ7hLURfS0Qk6n3qC/wPekJejXnrnSxr9qz+OMJVMzFxy39VmilaCwbaanlw1eeFRe0B/JwAKPSknJBWyVlVYVVsRg7wjoapR8grjfxINaqtaYCWDas5tER6xFiU3pUmJd+ltv96+k7lKsZhpjT55iJgSNaGuh6EW17qEOCYFt6MlfFiGUuw4/u37KZUYhwYBmsNBSDVRYorceefIAQs7z0N/Lj0ddwK+02YrpewmXLBqYA4FDlBj+wEvSzbiABn07QcIRWfVSF5bExrQSAUrAYT5s1YGc435t7BENNml2kd7PPWCVNDz/Z99K1dugUdLfvrFfbVLL09pN+fYYpGtICNlTgGLnOnnkPTqq7HkPpXYVlK9Slyk2LREg/zvDrfTsukpkpSNa2ZzwcGI9vA9cpZzzCIMsZHl9CM9kzaJKNRiA9KC3eZFqcs+xGQoJ8ZipVNYns+RDXB1VVE/y5sZ0yrZ+SLNv3yXc2SleLs/3r09WnfRi1CUlorU7s0ICCXbOmIQEvqBdDmoYWUQIwjGAR4DR6vy1aOUV66uw5e+xyTJunL9FSXii5HtJyVXnaUczaWKDaGHxJOLZ3hXSsJq/xSjvZbXMKWiYLXY0iPliHInZY8ICOpaFBAiAEjWKinOhWYZv2EkuaBLCdVjAYph23lu/qZtFskzswTcK3BQNGaRHlOLSPF/FmitXA5EiSwSmeaF5sHp0H/8+r3vcw2zA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(52116014)(23010399003)(1800799024)(366016)(10067099003)(22082099003)(18002099003)(56012099006)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cU5KTjk1WHQ5UVhYSkEwUllEQ0plRFFSSzZ2TkZLQjZKczZqcUhPcFdMRUd2?=
 =?utf-8?B?QkdmSzJEOXp1OE50UEE2eW43dk5uYWxyTW1xaEUwSTVoYTRmeVdnNmplRkpu?=
 =?utf-8?B?bDg0VVVXaGNJMXJyUC9aUEdvMk1LUnB2SzMraVVEWDAvU0I4Sk1lQVpZbGhS?=
 =?utf-8?B?VjFXQlE3RDgzVTcvNWNVZk9nRmUwYVYxV3IyTTBKcUtOQUJYRFY5Yk1EWVZT?=
 =?utf-8?B?SGFrNWhiMlZyeVA3ZFdMNWxqN3lSTDFNMmZuKzgvNURPcUhVT3VQR3hTaWVO?=
 =?utf-8?B?cTIrTDVHQlpqaFN4SlMvQWJsOG5WbFovVTcvV21ORGduUDdlR2dRUk9jUHMx?=
 =?utf-8?B?MmpsQmtrcHNtVXZjeEVmMjlDMGQwL2tIZWtHdVoxMzVnaXVXQURDWTVJTUE2?=
 =?utf-8?B?R2VqWGJMVEZJMjZWRHV6a3BUNXVtR0g0dnVmdXJCTjJXb0QydXVkaE1Uajhm?=
 =?utf-8?B?bThKOTlZN21yTG1LcmhzaUFESS90Q3hLOEMxeGlZSG92THdJdW1NVDh1Q2I3?=
 =?utf-8?B?M0twOFZ0RWxYVTROMXI2S21Pbm9sdVBzMUxab2huWEt4bCtaYTh6VmwzTzRC?=
 =?utf-8?B?Q3p0bkgzNFIxSE5WYVFoSy81RjhvSG90UHBLaEdkZUNZdzg0bnlDOEgweDB1?=
 =?utf-8?B?K0hyeFJmVG5qNEZ0NElQSDM5RkhKVjlrTzZWRzhDUVJyM1FWczdTL0FDd0Fk?=
 =?utf-8?B?VFRyNFhQdGFRYkZBY1VNYnhBTHc0SzNudlptbnFQSG50NFhscW54ZEtaQlJH?=
 =?utf-8?B?bHU3RzZHUXNJdklIYUdXbjk1T3MzRklpL2RHZ0NvQXYzVzhhOFNoZGF4ODhO?=
 =?utf-8?B?ck55ZHVXOVQ5TEtnU25zQy9talRiVTFTUEREbkNhckQ0NlZGblhGdlppaTAw?=
 =?utf-8?B?Vm4rS3JMNEpQK2pNbzJYR1diMmV1cTY4NUthOVVueGVtWXFFNG56Rm1oSEdl?=
 =?utf-8?B?TStwcDRQSzc2cmN1TEZkYTlPbUsrNXAwNnUrWFoyc2d5endzd3ZiWTJrV0xz?=
 =?utf-8?B?bkFQMEdPbnZZbVJrdDR3MFduUi9teXFkZjBidVY4R1NlczAwY0NZbXZ3dnNR?=
 =?utf-8?B?Y0Z3SXFYUGtQTVVaZ0JZbUxrcDhuZ3pQdGQyTTdvMm5mK2tvUGRBbzJJb1gv?=
 =?utf-8?B?SU15TXFzTDhreWx5YmdyUmhybm4wcXRnRGR0REprV1E1ZzMrd28zVCtyWDBk?=
 =?utf-8?B?SlR1SXp0NDA4TXQwRmhqZE8xQWdIRU1tc2lPQzgyRW5IWUFBWTQ5dVpoeUtK?=
 =?utf-8?B?am84K2JyejYvQzBiT0VTZ3lZakF2L0N3ZDdYYXZpek9kQkNjTHFzUnVwNXdI?=
 =?utf-8?B?S2pXbVdDY3RndC9IbmdNK1dsOGFZeDcySVQxeGpqNnZWOTZ2bnhUajBVM2VN?=
 =?utf-8?B?N1pya28yWXFSN2k2b2tJcURGSUpsQm4rRzBNR0JmMjBkMUNYSjdpRmJYUEh5?=
 =?utf-8?B?WnhNVldaNE5IemJaK0xrMTF3MFBXRVpYNFo0VDdvT0Z0blFPN0lSNlRUcW53?=
 =?utf-8?B?NkJqOVErb3Z2cithenZTb0ZXb0tLd25SS3RLTDlvM0t2cE1na1NZUXNNaTdC?=
 =?utf-8?B?cVBCZmpGVDBFZkxnMGdxd3VnT2V4S1pqZThzRU0yK1JMclltOHQ3MlQ2bG9o?=
 =?utf-8?B?aUpPUlQ5dXpEbjFscVdhUVNxeFBLbFA1a2lHZnhHY1B0S3B5Z1ZWNW1Wcytt?=
 =?utf-8?B?S2JPSGFNdEdKZnZFUUZ2Q1lFeWpFYkhWMllOZWpMMklXZXhuU242MFBoZlM5?=
 =?utf-8?B?NUhGYnZwd05HL1BMNjExOW42alcvaVpZSXQzR1NkRTNFdVZFdDRVSFJKVDR1?=
 =?utf-8?B?MHQ1MzdOMjNXZ0VUdkpmTzdybVNrdXA5c3Qxb1U1dk5tVXJ4WGRqeTUvVTRR?=
 =?utf-8?B?eFdiWkpyTFNYR2twdjdhRi9LU2Y0aW9LdmtmUEVPWktrMmFOcVljbUpuZTZ1?=
 =?utf-8?B?WnRMQVBwRUlkeTVyZjdLN25wMnkvcWhYZjlKSXZHeXVEVnpQSkpUK1pqa3Bl?=
 =?utf-8?B?MG9IbU5CMGVGS2YvaHVTZUlZZnhTRTlLWGl0dVN2Z3oyaEdhaUJjY25aZkxE?=
 =?utf-8?B?UmRWcisvaUxGMjM1QTU3bFZncEhyWERyVE9TbXpvcGsyWmxqTEw1VEcyOXZ5?=
 =?utf-8?B?SHRiZnRFK3MzdzdzeFN6Mi9FOVdWSHJacDJVeTRhTG5KMGRCYXh0RjRHS3ZH?=
 =?utf-8?B?LzlCK1ZZMVVtUlU1WTRKWm5FTU5vYlNQR2hXMTg5ditjWWlVUEVmVTVvRjFO?=
 =?utf-8?B?aEQwT3dBVWVKNEIzcVVyMSt5S1doVnZOQnhsc1NZOG96clhQMURKTE55UWl6?=
 =?utf-8?B?cFdOeXFYcVF6OU5aOXNUckpjeWF5NnNZS3I5S1hMOS9XU3poY0lQQ1pmUzQz?=
 =?utf-8?Q?wUQFe7Dv4jhIwWGk=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45bc47a9-8f45-4181-5813-08df123bd0b7
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 08:40:22.5083 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 04Mpe3Dv2N2hqLRWF3Elw0tLCCR4iaZSonOxeZ1jg60OToZEEczW4O1kOZPyJH+rhaQiS2lNel9BBk1HH3u+Re8QX0oC9pOwVdOG4N6kKMQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR08MB10916
Received-SPF: pass client-ip=52.101.84.120;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=DB3PR0202CU003.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_PASS=-0.001,
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


