Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5345CCA9ED0
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 10:29:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGDHU-0007mV-FU; Mon, 12 Oct 2026 06:29:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xGDH1-0007cD-55
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 06:28:51 -0400
Received: from mail-francesouthazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c207::3] helo=MRWPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xGDGz-0005FA-DC
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 06:28:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eAAlS+B0a19J0iK9kh9aq1leMgCDDWAbEHnXBwDWE8lRGkCBpFw1G4oXsYuPvliaR0YOhPSVPziTw8A6BiciWR3njsVRwO49a94jXuMnk7hijKpToStcC/Omcste3tiXPZbNNJmB5C50eRb5GjBIkn7VRjlyvVCX9SqTHqLEOOAF56ya+BH5FKMMsgYQrGhoOG6Ih8l7gpiZDz9dl8+SDxb7aTRJmXAliYoXIK4y0wecw6VNeopyMh0hipmOqDsuvAXwPcNPq+CLGkgt/KOhsbg1wvkHNUduDGJ642wc7DYQTMR3Cc2MO5q1tPAVq5Ja/vyEtTCiYjkYnJpF3Ah/eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=De18djxtHE2E9HKgY8x4Fskcmy6Hm5lIvLp+NNMBlUg=;
 b=IX+PjO2vEGaCaG4ysxasnorun6HUuKfe3YbTEVk23VK69bnaeVo2VoOWvOiZl8Exrg5mgnSI2iBEG8U59dHVUkgtdh266BOsoXxjU289D58bkUa9Zie+5CA9x3URzEy0qWvFdXTQCJIYo83SkoLLyqzo9NuCVDtoQvZfPhAE1NBRFBtFW97WRKv2lxLtx0fVjx1C4OIM67CTozdbGraZtec24TD/rXy37rIAWa9I9xAj/IdV3vNiWCMg4nzm/yh45iSTyIurCbO0/6GBjF36j6BeIHts1y1qZLs0wUKGqxc0IixJCtad+c0yfb8YwHKG9wMl69udJl+p3c2O5UYz+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=De18djxtHE2E9HKgY8x4Fskcmy6Hm5lIvLp+NNMBlUg=;
 b=AQLnm9oZp0DZ8mkZupnC1GKPWHXAjHbHts5hdu9+erTLYk47MP44RQvXZUVQdRCGRbAuchgDne1LBWj6UZnPd9AtIIc+COAwXYw367rG0ACtEhpBVL99Gvp17FsPAOs7Q2aLIJp1Pt3rTgtv4WkBnlEvtZvEAd6rxUJRilA1rmwR5Px2l5X5KKNbU29AjBOpo44mBCcWWLdXo7PTUaKUTh8Jp3uW8NOtk2+OEavPUvuFKnpr3SMzuBLVHhCYD+pauDWnSupsK0oSuLa8GYBwOHZtbSITzJTcMP1hg+4lirih6RremUwYR4/jvbmVuV9vrpKuIwQjCJf1Mnm4hyoDWg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by AM0PR08MB5523.eurprd08.prod.outlook.com
 (2603:10a6:208:17f::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.11; Mon, 12 Oct
 2026 10:28:35 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0522.008; Mon, 12 Oct 2026
 10:28:35 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Mon, 12 Oct 2026 13:28:13 +0300
Subject: [PATCH v16 05/22] tests/qtest/migration: add test for snapshot
 rejection in CPR modes
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261012-up-vsock-vhost-v5-v16-5-36c38bd15ffc@virtuozzo.com>
References: <20261012-up-vsock-vhost-v5-v16-0-36c38bd15ffc@virtuozzo.com>
In-Reply-To: <20261012-up-vsock-vhost-v5-v16-0-36c38bd15ffc@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: odaki@rsg.ci.i.u-tokyo.ac.jp, bchaney@akamai.com, mst@redhat.com, 
 maciej.szmigiero@oracle.com, sgarzare@redhat.com, mark.kanda@oracle.com, 
 vsementsov@yandex-team.ru, clg@redhat.com, den@openvz.org, 
 dongli.zhang@oracle.com, farosas@suse.de, andrey.drobyshev@virtuozzo.com, 
 peterx@redhat.com, dwmw2@infradead.org, philmd@oss.qualcomm.com
X-Mailer: b4 0.16.0
X-ClientProxiedBy: VI1PR03CA0043.eurprd03.prod.outlook.com
 (2603:10a6:803:50::14) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|AM0PR08MB5523:EE_
X-MS-Office365-Filtering-Correlation-Id: b1d0d367-d8d2-4da1-9974-08df284b923a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|52116014|1800799024|23010399003|366016|10067099003|22082099003|18002099003|261009223027099003|56012099006|38350700014;
X-Microsoft-Antispam-Message-Info: w8aP4b88/EYBG3BkmEdT/Q1AWxUEJ3yh3LE74DdJutwF4cLIRe9Q1zcNvPWebHmOj1xZSBqlDwELUrkCIOsq2GcRi10IRWIKPiLQsyVAJCxE7fQN+OW8q+7/9ocrqA3mKZeuQ8bevsoRjNb+YGBoFouwIrQ711pVHJZ4j2baLfHrKDRb0ABfFZ3ls3+0k2SMFr8i9A3mHRatTPKt7a96Vg9bY9PdtfmZpWZqSBvFTkLbbRLlNwrrbp/0IqYJWivRziRLv7C+gz3EFEsG1bhxcPF6ts+VByFcgW+X7LCw4oYYmLFKzlAFgpGsAwF/KVTnE96jIycatq220To70eUlP41584KFQd8eTajcw+96d5gEri+kjIvr+dn0beOO9Y1CNd9Q8/QhbFXVPFfpeUGvofu2Z1j/3jW0X8g4XWQgaOXrYhkte5H9q1+P/eTf+UAygdEXbTIE4py2Fb/tUldhD2Y82UZ7X5RnpfPKz28YyzBa2ffSXif52qBEAesKkaXswziWgRHPkYvm26DQed5HNvNBUAVlqMtzShWJ84dKk4UxuGvWF9GxWZWU78wPHolwq/LkhV0a3QzUfQMH0Yt4cdGH10VHhdrCL192RfKIK8QtG1My6xX7fnAAzfugUxKODNzHPjfPAYvaKEfYbiZm8xNRtnYveLY2gFIaF6/iRsNyTLFpUjXBcEVdEY6En+jfFUBo61YnYqUCp/n/q5w4NQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(52116014)(1800799024)(23010399003)(366016)(10067099003)(22082099003)(18002099003)(261009223027099003)(56012099006)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ry9DbFYyN0lFMy9XeU9XN21rTGFWay9zUmF1MlFPWEFVTWd2TGx0V002cFEv?=
 =?utf-8?B?L1l0MHk0NkpHTjFwOWtSU1RhSWNPQ0loeVJ3dzh6VkhsdElPcDJROVRKRWxy?=
 =?utf-8?B?MUNxdGwwTUZmOWdmd0R0N09lZVpYdEljN0tKUXh4V0tJbXdmOHZCUnhpRUVa?=
 =?utf-8?B?Z1B6VFNCa2V4Skk4QW5UVGM5dWhWK05ibFEwZGtpaWNUZHhFUW9MeHVadXBU?=
 =?utf-8?B?QkNVbWdaUitwZ1d1cUFHR3lHWHdJUWU2YTVTMlczaUF4dmtiODhmNUVvSlBH?=
 =?utf-8?B?YXhEU3RaR01pczllTXlrb2lLUUdHcTFVeWZ3UDZmVTZJNkg5bGY4SFJEQ3pQ?=
 =?utf-8?B?bU1xVytlVEpPWTdkNnIrc2dWSStGcnJEb0g1aXdhSWVhazhhOFh0N2R0Rktn?=
 =?utf-8?B?M25pd3NQak15OEkwR1Awbld6RWcyekRXN1Y0d2JJZ2V1eTd5cXpvTXJwZjM3?=
 =?utf-8?B?SDQvcGF1L3lzU0F4STU2aVVmajVpbFNSYTlvYXZmWFNlRHI1TG9xazJGakJB?=
 =?utf-8?B?bnJxMDJnMFdPYm42TmdENUF0WUpoaGgwTU1PaVBlVE9CY0RFZ1lDR1hoZU1U?=
 =?utf-8?B?dVYvVVpSNWZqV1NMZjlQUk4xRGpHYzlWWVpJYlg4c0NpZlBOVXdNVWFqSzM1?=
 =?utf-8?B?ejA5K0lnbG5LOUVmSWFBOGpyS09Fd0dtMS9vYzdoUXpkdlpwOFdoUUlZMzdV?=
 =?utf-8?B?Y0YzYWZlcXlndDFpY1F3N0p4aUg2Q1V5dGpuZUp2SUJ0UmF5V0swdytkemdv?=
 =?utf-8?B?bDZiUnQwbnJ2YWRtWnR3Q1dNcTJvZUYzcmZXU3JBUWdBeUw3aWNZUWY3djdq?=
 =?utf-8?B?Y1ZBc3kxOS9rY2ZCZzNlWEcyQXV1cDJsc09ORmNHNUE5S0NFZS82V3gvTHdK?=
 =?utf-8?B?dzNTbGNXRTRzQlRFbmRWYmR6MUVzeGFIdWNoUEYrU2NwdmVLSUdZaHVGTURR?=
 =?utf-8?B?aTcwWktnZFJPbjAyQ3hhbGR1eDBNSWlsQzdyYUh0SGdFYW1qQVJ5a2JXUm5S?=
 =?utf-8?B?VlVFWkNXSWtqSG9YeVQzdndQN0EyZzRXT21zN24zRThuYVZNQXorYXlvYjlM?=
 =?utf-8?B?UTVGNnFwcTJobC90WllaWlNZTTUzN3F4QW9ZSmNpdjE1UW02cmpRbElmZVZw?=
 =?utf-8?B?ZmNvNXUvQUpwaGhlM3NOMHVKa1lLWU9iSnM4NU5BcDl1ZE5nL2dxbzBNWlY1?=
 =?utf-8?B?QTlHY2RXTmhKMU9hc3FjTy9GNVgxVk9zZ25CWXBWMjFMc3YxL2Y3c3JZaE00?=
 =?utf-8?B?QUdOT0hDTDl1cEZsV0FZSEg3NElKNkRuOE03RGYzaDdXS09JaUNlcUJPQXB4?=
 =?utf-8?B?WFZvVEhxbVRLaW5WdDBHYTA4WXlDOWRwSXM3RlhPaE4wTEtGeGtmNUZXblE2?=
 =?utf-8?B?eHNoa3A4TUhTQjV2NlVUMWRYRXlFWExQRHV4U3NZOW82TkpxQXVyNHh3TENm?=
 =?utf-8?B?dkxFaGtodmNjbi9yWEJ2a0pZRFRzcURDMU9ZS1hWeHlVUDdReGVWQ2taVWNy?=
 =?utf-8?B?YnI0VUVGNTd5QkZWR0o1QURMM1FVSXlmMmxKb3BGemt3bXVNaFFUeVNjbXQ5?=
 =?utf-8?B?NjQva01FVkNnSFNSRDNxL3M2eWtjZE9NeUEzTEE5Y0IxMG1RS0lGeWVlM3hV?=
 =?utf-8?B?N29ZQlk3T3pPaUREbnQvRElBL1pWQ1NMZVo0MXAvSDBEODk3Y1U3aXAwL2pO?=
 =?utf-8?B?eHJSam8zamQ2MzRMQnB0b2FndHorMjF6VEk5Skg4WVl2c0RkRGVqcWcyajBX?=
 =?utf-8?B?dCs0TGNJNWZlNWpld0MyMzNtak53UUpRaXltNDdFK3p4bWVMaFdDaHZyMkZk?=
 =?utf-8?B?UkNNT0srQStaQnlYMkwxZG5XRzM4RTEwdENUZEM0VVA2bkxxUFFNQnpweStJ?=
 =?utf-8?B?SnpEYVFBQnB6Y3RwbzU3aVNPVnFkRVNxS0dhVk1rVVYwb1hZQ05Wdm1RS0VM?=
 =?utf-8?B?ZDNQc1hjaktYQURMUSs3Nll5VUZRMTJUK1l3d3RGVkVId1JsTURzalVXQ3dD?=
 =?utf-8?B?OHlQeVlGNXJ0YmVZeDkyMi9DdEY3UTAzMGJxblpLakVoUFlwWnZvc1Mrb3pT?=
 =?utf-8?B?b1gzUDYrSEZ1emUyckJkYXJyQStwMDJCeXI2ZEJhQU5WS2lEUzNJd2FyaWd6?=
 =?utf-8?B?eUkxTkZ4bHlud2lKM1NiYTJEOGgzL3JVUi9JVUdIRTM1WWlDZXM1dHpGMHlq?=
 =?utf-8?B?WThGcGZuUjFSa3lRa3lpUDRFZXRPTjI0bkR3MjNRSGp1U2FzVjFQV0FMVlBS?=
 =?utf-8?B?ajFnZXRyLyt0cDlZYlI3cDhrN2xzZEs5MnQ0TEoxTDcwbGhrTStHNkNqdjhz?=
 =?utf-8?B?TjRKWVg0d1NTMWJ6NDlsM0pnSkpnKzRDWTJ5eXhtVUgxTTJVQXFmT0JRdldz?=
 =?utf-8?Q?6hHDouF1KGo7oBZk=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1d0d367-d8d2-4da1-9974-08df284b923a
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 10:28:35.1852 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rLKxkEjWXBTDYeOcKgKQHp23NISA3C9T54iPg2wNvTiXFANSkWrG1Zvv3Bnk9zdO8gqfAWNAAWD9t7frRdax+SYnYVkOHghgp/Br2o06LIg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB5523
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


