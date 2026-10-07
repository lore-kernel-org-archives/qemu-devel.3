Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25FDCCA5FFF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 09:32:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xENwe-0004sB-4v; Wed, 07 Oct 2026 05:28:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xENCI-0001Lc-PD
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 04:40:32 -0400
Received: from mail-francesouthazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c207::3] helo=MRWPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xENCG-0006j4-95
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 04:40:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K+zHYXH4ZC2nMI28c+PDl23KTcfoJuLHzifSI4VTTrnm+GYF7LyZMag5+k+jY6YSeIZ4okn/+oGWSdqtYiVZDN65fld6Iqdtlubq6PZS+h/VEEys5sWRjE6K8GaZzfR6OXDRg8kr9tm7ddbGRqill87TlTzOkS1l8S9J323ShQK5krQnQ5yg7yv0JC9NcZuTSVV4keXR0Dzr+SotiigUtlFTvsKDj088cOR1a7yr4r+vSAdFp4D5op5Bpq9yrTSEmhySNw1zTkXdXaPZ/sAYJFxjzy4Msr3RsYbJpXmUvK1M6TlS7Ie5CTksnuLQQTgirHZVnwAfUSSJw0szq4131A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=De18djxtHE2E9HKgY8x4Fskcmy6Hm5lIvLp+NNMBlUg=;
 b=mFqrCaM1XGD6BNAQoMDcBb8oLIlJsvOwdqjoO7N21MPyqsl3wd0Y92h2ZgzeLCpvwqmrQu7/Zj4YM/oMOLOb62iAD7/6wiWxUcF0JhLHX7UVeGF8PWpqXimSb5DOSZu1OvRsHD/c0xeCh/6gaCAbcBnsHm4VQ91gLXK5dGnptGlkecQlRlFgj/yJSZXi8qfjaPSjLCsgR5L6JOouEpjP0efmc8K905lOqTfytK/1K7aw408CksY2AxRCMLnm8lmYX27eSSBHwIRqU9mNvH63Qt2vVGI33jo6+n9U44AKDdsyHEIJ0f5HfNC9tSVqCvP7oMFmAYAYGe+3enDJI0jwcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=De18djxtHE2E9HKgY8x4Fskcmy6Hm5lIvLp+NNMBlUg=;
 b=Zowr9S7QkKgaAbJJYP+FDgBqjyokZUzTBbKYzq881mKfRT9VExXMMArcdrNZd+2Y4WK+w7a840+dmDO0j4qxZyiWdW6nvaYTuIoQOlj4Zg8HOGY+0jiQphcL8DYbN3I7sSeWPsFUJJnsG0TI9hR08FWgO7WjJuurf6lHeQ76uZ0JDSRY0+kHqssoQmA2i81DHUrewWw0/nmx3GPLYtYDSzQQo8Wdmw4u46wcqiwLYCzKJoUFyTc1J7O2ZnN1khH+snkXm11xoq2THI2M9lvJCP495WIKN198RjK4lNe7CVW7j2TtEL1wFdJUeiBirWZawxs/qR9Ae5Z0xjsMc+YNhA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by AM9PR08MB6292.eurprd08.prod.outlook.com
 (2603:10a6:20b:2d8::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Wed, 7 Oct
 2026 08:40:01 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0496.010; Wed, 7 Oct 2026
 08:40:01 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Wed, 07 Oct 2026 11:39:58 +0300
Subject: [PATCH v14 05/22] tests/qtest/migration: add test for snapshot
 rejection in CPR modes
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261007-up-vsock-vhost-v5-v14-5-e16de9962df0@virtuozzo.com>
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
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|AM9PR08MB6292:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fc28816-7805-49c5-6a35-08df244e933d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|7416014|52116014|1800799024|23010399003|38350700014|56012099006|22082099003|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: NnPjQc3Rgx3JZnEvjeZ0qFwlsslXyfHCC1bktpEfaZCP3Ea22ImC+LbaDXux37LRh1YePJ2J5KLeIz6ChxoD3cHyY863IfGzgdIjNeZYafbVzYN4yFwYNvHbCoudsdPuPNJCsvTDVFQoDb0QT0MSgE+iuebIB+uWDXX3IImiGS1axzAU9RW7uRqcbSYiRozDErmdLF/6nIq+Gwx32GOubm//Kkd+uEj9Rmy5xxY2WmaPv2MqTl6hFMcj0y4XPj5V+waR16Rmcs60fFZjWeVmCgBr+6lnmwz8y7H/Px19ZNQVXdbVobyICNS1AyOczMJkPjAH2hyf4uAfFqXosztfEeITubX6DiGYY6nbXd3ZwZJIFL2zx6RvhhHF8tW9E85yoWX2EVg0eePZbpNUkJ9JI1c5lgF5KvZ4SPRSTyMtkMgsuWpt7n/Zyxw+dCRG8HrDX9VkGEHZQTxxA4YdBuxvx8mn1LC2hpxlJjShpF3zFS02UMTn0qAF/z8sSOkiF9QxHl3ad19qvDoOEG2GRs9X8kifmw/Is22H9KiOtqzMm74FBu4OV/QQkybMhvzBG2eF13BIhUhcpln/WEkeeDtjcLmLRxjwM5yEjaIWF6OSvGD29DHd6Ptm67Q/DaDLgmSaZ9yP25NT6PUB6oNL7L8Us/UBbVCibCPTATUzhCcAcmsCj9mjtq0RBx0Equ2snzAzFXgRkAug5mmpXr7WXHHItQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(7416014)(52116014)(1800799024)(23010399003)(38350700014)(56012099006)(22082099003)(10067099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MWRBcFRlZEx0ZThMYTE5MFdpY1lyUzVmSWJLcHFZVnY1MDJFR3dXdExxQWI2?=
 =?utf-8?B?YVBNWWF5eVlzQmRxa3QvWmNsMUErZUgrZEFyODJaQndQektzOCtSWDBzRWN1?=
 =?utf-8?B?RERxdzhjQm9LUUtaNlRQUUhBQURJM1RQbnRhOTNnOGVmZUI0eHVoL3BRMUlw?=
 =?utf-8?B?ZXBKRVVmWFRDV2p5RlkzM1Z4eERMN2ZPZld0NW9YejE4TTFQUlZBRWsvcU5F?=
 =?utf-8?B?UXByK09WTTZGZWJHUnBiWnJsQStJd01JUjd3bllKSWx3dTlvMXBETDM0cU92?=
 =?utf-8?B?dFIvU05qY1hzWWVWUnovK21veGJuSkx2OVVpRmdJZGFUUTREK2hrekNrcjFu?=
 =?utf-8?B?aEFGMXVkOWMxbWtPRTVjVmRMTHI5WjIxdzBWM3BpaFBYR1NBWHhGRkFtcFdl?=
 =?utf-8?B?eHZmN0xGYS8vVFBMWmJUNkphZEkwU0Q4UmpLdFdJTVB5UHE4UW1DbGphMXhx?=
 =?utf-8?B?VzV5WXdVaDhlRFlxSElmZ1VBVStvMUFDVW5oTVR1MGphTDd5STRmNGhCa1Bn?=
 =?utf-8?B?OE0yanlpaHBIUzZibUZGZTgxejNiakZ6Q1owckkxMlVIa3FKbTErSVNFNUI3?=
 =?utf-8?B?MC9TNmlYUFRYME9KTDZuL2hSdElObDlKN1pRa3lYM1V5bVhWS3Vodi9Hc00z?=
 =?utf-8?B?MVc4M1E1NXArdjVUMjkzNDV0a2ErcFdrS2dpWFV3VmR1Sko1T0VnbXZOMnZU?=
 =?utf-8?B?c3RHME55cDdETkxkOFU0NWZVMDN4T2lvc3NOZlhTcTBZYlhUanhCc0JVMDk3?=
 =?utf-8?B?bWxBanIvek5aZmozYnVPSlNnNDNnS2RlMG1tbkpqSEdxYUlWWld2emNYOVdm?=
 =?utf-8?B?VUQ2OHltb3ZITEdmOS9QMmpCdlVJNjN6R0FwRS80TWppTDNUeEU0ZmZiTW9P?=
 =?utf-8?B?U003c25scG1sMmErRTJ2aVZMTnhMc2JmT2krMHRkdU90anpCblBNYS9EZ3lj?=
 =?utf-8?B?WFBFcU0yVVNPd0NqQTkybS9LdThtcDlaaDNRd1dxTHRhQzloczdlKzNhQUls?=
 =?utf-8?B?dUUyeDRkQTVoZjdHNjhBa1QvaFFpYm9SREQxSjZycjJ0ZWRZVFJ2NzBNb3hx?=
 =?utf-8?B?TjdDN09oT1VHREEvSXM4ZFNMT0RkYW11aDlkZFVhVFdaVDEvc3E2d2NjZDUr?=
 =?utf-8?B?WGNpRk9qT1IxUUJuTHMvbDRJMHh1R1JWU1pjZ0lpYmlFMDhJSGFaaGhJRjE1?=
 =?utf-8?B?YjgvekFFMnAyc2hTZGl6SWlwbU1LUHN5RWhlQnA2MFhhKzduVlZhRTV1REV4?=
 =?utf-8?B?bU9jK0FYS0lFSXNoTUxySzlDeVA5SjJKTmNSVDNrWTQzMWFsZU5qbm15QnUy?=
 =?utf-8?B?SU5xNUYvNE03Y1h0VTAya0N2ekQxQU5VVk1JaFFkNDQyOUEwOGlTSXV4dktr?=
 =?utf-8?B?Rzh5eFdEUllMQ0loNTVLWnlvVFNsdUFyN1VUeFJmR2IwbHRCdmpTNjJjZmd2?=
 =?utf-8?B?TFRueWRFM2FGT0s5b2labDRhdno4M3ZSVzlOWE1CZEdlc2FtUkVyN1hFb3gz?=
 =?utf-8?B?NzY1VUoxK3hlYklzV3JqOWRrOWF4Q1VMUVd3d0FYRi9UNDFlbDY1eTZSU3BS?=
 =?utf-8?B?L2xmQ0FNUVI4bkZXY2hEdHZTZCtYMmRWUERQRis3eEUzQnR0Y1lEVExOSU1k?=
 =?utf-8?B?Z1V5ZUcvK1RsbkxCemFXZ2t5R1VjbFJibkdxanVFZmNTTHpsMTVUS0pqMWZV?=
 =?utf-8?B?MDM2TFhDM2dva2lnM21xbEk5amJuTG1XVTBZK09kSzZENWZnb0VVVXlVNFVK?=
 =?utf-8?B?YURGOEIwYy9YZG1CZzlYTHBHcjRjNVk5WHJWeVArVktkTnQ5MlRKcXhxa1Jy?=
 =?utf-8?B?WGNHTUFRSjI1bU9VcGdDaGVvOU50ZTNzU1hKbVJEcEhBOU1FU3F4cm5RM2VV?=
 =?utf-8?B?MFZpcnlkUTNEc3NqTmdFOWFMTVdxc0pFQnFTbTEwMkQxMGlRTmh0WmpETW93?=
 =?utf-8?B?RHdvMzVLbThTa3daZWhCY2MvajJBZm5jRlNnYVpZNEhkZVljei81NWYvTHpT?=
 =?utf-8?B?aDA0QVk5K2hlT3F2aklBR1dWTkREbXRxencyQ3QxTjRwUitTTVJOcWFOSkxy?=
 =?utf-8?B?ZHowQzhIUzd6b0Q0TlErNTlIeXhBTHFnVUtaTUVNRThqdDZDakd4YXFhTVNj?=
 =?utf-8?B?L1IvRTBtU280R3dtbkh3Lzd2NUNFRkpwQW00VXZabU9YM05XVTBZclhHM1F2?=
 =?utf-8?B?c2dsdk15N1J0OHlXRFhUNHVmVis1RmJsL1pxbitQOFhUU21UakFCTVAyTmpL?=
 =?utf-8?B?QjArQVZpbEtpQXlPbFVqL0h1VWREWGd0QXVVUVJlT2V5TUdFMmcrR1pkcysw?=
 =?utf-8?B?KzU3SFRJdjBIRFNGcy9NWCtJWkNlNy9EZmlrcHgzZDFVVTRFVWVQNnFudGl4?=
 =?utf-8?Q?Da8cNXJRuAcL0KW4=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fc28816-7805-49c5-6a35-08df244e933d
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 08:40:00.7188 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hr9OAG+ZiSDKRQmQ/4pBdVq9D1sPHt9w03uUr4yIptNa4mGqOBt9nEZK3PlXCXKF0STO6PyRNJnJ8DwK2CwKFS2h8DVEsmdHA5gl9J2k1ow=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB6292
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


