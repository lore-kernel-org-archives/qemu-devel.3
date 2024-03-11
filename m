Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC266C5475B
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 21:56:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjnbf-0002wn-2I; Mon, 11 Mar 2024 17:54:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rjnbQ-0002tj-AS
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 17:54:36 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rjnbM-0003Ba-I9
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 17:54:36 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 42BD9aGk009722; Mon, 11 Mar 2024 14:54:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :content-transfer-encoding:content-type:mime-version; s=
 proofpoint20171006; bh=TyAq8jGJPXGONJOdso4TLpyyA94NLlLZDKZsk/3QN
 EQ=; b=eTIUGq8Dxumdf0AVWLWvBu0enF1pomy/njmQwHNo1Plz58YdaCC98gUbp
 ZScb3eRDORlJwclbRsMyBu+KeB8th9e0Gp54qjxqo8zXaK0GMagcm/d4QHfS2idF
 DJQojiEnxmGQ5DYtn0KAa+r487VcdCFCUoG1cyRomRGzGMhqgZvH81Jx8GcLqoEZ
 WH7lNdkSi21ASuv8+byzkBc+N4/WduOswhD1dCXdD4IDS0zk+ulfqsUi5Dwt91sO
 hsCQh+hqDBg5k2iwOYNYLTOp9V6sTiY5MVc24zghG5nUsEmrkrrHgm9G5QJxCpUk
 7sUH1rhBH/ZaUqon17yAg/0kVI66g==
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3wrqygmc7y-3
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 11 Mar 2024 14:54:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SZHWV4m/ruIYIYudeG0YIEYiG7cpAdoF99Rva6h4tqL/McwHOjo7Dzk7Mwdk1BSZzNtnRdXYGq/4M37ZE8uu3t9FaqBhJmaPcH22Hm9J4Zef8VNrcXhae0K0QKkWolMonlzeUV4eoPjhCc5fqyWuM1Yf1beKlK69pmgiywxsevTtjsY+WP0hLoajR5oBvwX16cjb7D6b5zM64J98C1mwaXAu9gG+PigFTJ/hqvtffeSKLV9w8Z7W/ncOekD/h16TUtpETZiwnnIXBQ1nG+h1Kel2j43PBO8e+qpl3FMNZh7Tpan+C4iXX5I7IRqAzNbz2KaWOB4qQmyTdy2dr/IEcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TyAq8jGJPXGONJOdso4TLpyyA94NLlLZDKZsk/3QNEQ=;
 b=oGJvJDTZbiihaEy8mivwUx6/L2N1BEy4PaX6ky20Hl6RKINT9if6pzfxDTirvdyxrjTxKV/NdwzUKp5hN9QTdJ5dtg2fUXBbB0MmEj2FRCHrtJlSM7kN/OsCVJuCqqzj0OQIFnAdyFRXYXe9XQoBSda89UX+Ihw1ppxJv+QrWOU2fTQ3FQiM/LD5aCyH9jt36RrYx/BxOT2lqU8Ol1xwErB5LZ1bCaPNW+qNMDTbx2D6F1UY5F4WImTN8iyQQMX6TMy5APhpMHo4T5cbUETQXAiUpcpK/N0hadb5yo7uFutaHW8QnpS07rhytecofpJ5hrviOJmmXzuhxkb6+7s/mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TyAq8jGJPXGONJOdso4TLpyyA94NLlLZDKZsk/3QNEQ=;
 b=S1RYjo6NnodUXA+KkXPwHfk7PKv7guFMXBzGvncH/Teog6ph/Aw+T/MiKnKHqGiVxC6wBQmFnfs6u3Vcd1y8Azn5hNMvhoRhXUepwK8NceCcr5WuK49HHu/ZHJ7NeAk5wOJqg+4demKRIwZ/7alOtj6EaBxoGSs+KulNnH99NtSxE0bp5MiJqTo++7ysHyifOl9SmXtPFu1sT+6+beFbmChGTMuBm4BTarOkantE2Is5Hdii0ZYXGRCHsVXhiuSOWgyhxaGRIm3O+rpq13acVm0QPY0RYvXoraj08IL7FZgXkIuIaBcBq3RaYNsMT5TNyUTL0mTE5VTXHD+TxBLG0g==
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com (2603:10b6:a03:55f::16)
 by BY5PR02MB6849.namprd02.prod.outlook.com (2603:10b6:a03:20c::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Mon, 11 Mar
 2024 21:54:26 +0000
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0]) by SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0%7]) with mapi id 15.20.7362.035; Mon, 11 Mar 2024
 21:54:26 +0000
From: Het Gala <het.gala@nutanix.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, thuth@redhat.com, lvivier@redhat.com,
 pbonzini@redhat.com, peterx@redhat.com, farosas@suse.de,
 Het Gala <het.gala@nutanix.com>
Subject: [PATCH v5 8/8] Add negative tests to validate migration QAPIs
Date: Mon, 11 Mar 2024 21:53:58 +0000
Message-Id: <20240311215358.27476-9-het.gala@nutanix.com>
X-Mailer: git-send-email 2.22.3
In-Reply-To: <20240311215358.27476-1-het.gala@nutanix.com>
References: <20240311215358.27476-1-het.gala@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH2PEPF0000385C.namprd17.prod.outlook.com
 (2603:10b6:518:1::6a) To SJ2PR02MB9955.namprd02.prod.outlook.com
 (2603:10b6:a03:55f::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR02MB9955:EE_|BY5PR02MB6849:EE_
X-MS-Office365-Filtering-Correlation-Id: 939489ae-321f-46ee-80b4-08dc4215d006
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4sw0xJmAy+Fe68TpvggXKER3eOkosYrV1lJtCWRXigh7vgULP2nkVhnxwAT80gq/ebNEKbGA512TnqlwVjVC1SbmIh8l2MTJ+3Fmj8tJsvqE3x3RXc/Tj8T4f0PElflSBf9pRtWVSpmd0Kqrfwte8u2lJ68AC2q+qdeB1mGPLrInt9TR774C6k1RoPggvfgmgD4Ouzgk6wEGMJ4MFugM7AHXY9iNZOeBiGAPalXI4bm0bGem5RJDLN5SUp1v9yS5MMG88C7p4HAyUB6T8vmsZ1dvC/8cvjs0Wktna6QKblObx1KR1gf6NyCPeksrI3daiGNp6BQe+czg4HCrSvphFUuoFwltMN2dtMgp6qlaj1gik46SIQubIF/pGksPPU9xGJL8DUpngxWjPfpZ3KZhJj71eELvmCv1/uOFjxlFKZZCDRh01fOmrBNNMfytSgu8Zc+SDt/7jJsvyFMdbRnruu+8Fmu6E6vrxp+zKxFOuxAZ5AVb7gAeLlw3ps2/BwcN+gSWQoMifIVOqlZvi2Wwan4SgcJeY4URhz+5deS/2CyJxnoAGsrH0eXnXnSdJ90dabSsvlOnQggltc3C/FsKE9ax3T9FT5SxfWNNLI4SlZbALEC50jA6sLwQQlHHoGOAqCfUa+xo22XNIoJbeDU8WK8PVa/3atJmoXjyzUmzybVhVSf1XSawJJ6KGZWsc67B1KZ5ykdknllnl8/8aOfO2s3WCnxE0EJLrt+wAS3J7Ps=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR02MB9955.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(52116005)(1800799015)(376005)(38350700005); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?egq1rsH5vxwdgDGeModpJgmMKcfARNtdC9OnHIRQhOb2VjH75is6mxgiQ11U?=
 =?us-ascii?Q?zwx33ByH2b8c+s6WE0MFtK4ECiisGqe5lAqDGRBo8oik6zQsXp4X3BBRdPTQ?=
 =?us-ascii?Q?r94nciAErKYBn8wPkA4xSyjP6VmRnelUGKSvQRKviVi9cDX08tNyft5V5uLU?=
 =?us-ascii?Q?mNBQ3BhDImhEoCWMdohDOwE3wtHsc4hcTxYIeeLefBZ2CMk7HXHViyTJJ985?=
 =?us-ascii?Q?aJGGQXomxv9mju9jCXBjpRdWdj9HlaKPzUOPIOTU0Hl/32gXlXr6tAYEWVV/?=
 =?us-ascii?Q?onBpJX8Dhd//snINywdfgcRzn59azxVotFG67ZjZ24mFKvFagefWIHrCLLyx?=
 =?us-ascii?Q?JCBTd3dD/E+R0mP5RiQE0wZSJqPlP/R3+n7quHXh/8WwBAONXDg0QxLv68dm?=
 =?us-ascii?Q?Bt87bot3P5X/MF8qYsQOxkq33LAssR5hGTPVLKdENuFdLrmYFx894yFObxMZ?=
 =?us-ascii?Q?DIJN/f29NtHRLts3nJdthu/5PuEsvxM21z30XfgS0v9pISHMxf3vDmcTX3x/?=
 =?us-ascii?Q?cHn0hg2zhPtjZtjdCYSymYFTTlxlWJM37iq1KiGK120/KTBnlk943YNhgf+I?=
 =?us-ascii?Q?FTxHOI9rvJk9bqRdin3zkT9QHmVPxmEWCqoa99W7s6emYz+/YLt8R3x7K8E/?=
 =?us-ascii?Q?ZFaskphmqZZXfzQk7nPlP5PnPXIGB76RMNemHcenmyZMNEp1y8ziXsMuXFTt?=
 =?us-ascii?Q?T5uUOAYLbIw4GLeb9zh5JgMt3mbd0S/0DltwaYWg3WjTv2WBnOk0qus9nHX0?=
 =?us-ascii?Q?tt4Vbqmx/A28jO2i8xZYzWZpQ6SgNo32Pvo9m5UKQlIeYdUCaAk7Yyf0oJ2P?=
 =?us-ascii?Q?/Iq8LoW9XEGmhE91L4BeWE7WII8Eovoj7mhx2Q6nlwEWS6yFB+3hSiAu2lnx?=
 =?us-ascii?Q?9jHrIwBB7csvepJLTLdGmKhlJ1vYqfSSCcgGlbhnBJSIfhPCRde230m/qGbG?=
 =?us-ascii?Q?WZ9Rz8ukOBKPv8Tj1FvR/E+7H53Ky1vwCS5ka2IGfzPCf8dOAjhTJ/hpH9w2?=
 =?us-ascii?Q?RH+khGklKmtOJRzx7l42ubT1SyTnQSZbe1dCLnmpnu8Jegtn4E3WN6uMvOXl?=
 =?us-ascii?Q?sgt3pK92925Jzuft5CtgCI9qga/81yGMfiU3D2G3WuWO2Jh33iPuA7WzX6oH?=
 =?us-ascii?Q?15FCBS9GiK/EnNgwaJduK47MTW5EanYLCzOLBm4emsmO/rvfi25H+/a52FEl?=
 =?us-ascii?Q?RKxmPaPZEFDtqZMoslB2aaFWA5mwdZoWlsLZruzDQxVvj3Cbl/K6a9jhvWnE?=
 =?us-ascii?Q?cyxvIXc/kdO+3b6MFf6oNqWKorKqkNc5kqdTml6vy3n+AI5bIEtH3m6Pm2ii?=
 =?us-ascii?Q?sMcDhV0rUr2oS5WOd1F7nM3KCOrf6jFQ6bUjJe/6CSmROR4sial6yrbkzza6?=
 =?us-ascii?Q?4DkDVCeXe1iKoqqhFwK9Knd6TdOasMks/0yFV5MiiAW4AHcOIrAV8V5dJZ+y?=
 =?us-ascii?Q?ST9MH09KuAkcVIKA8qt9J0IGIgL2gs69bHnLIyf/NFhFf+6LzbXQ9DpQj6hJ?=
 =?us-ascii?Q?w42LfCtlUDc0ruvefo//kXpPAxew0m+q8pwwB6x12/cIG1e+tvoWYvBFKx0L?=
 =?us-ascii?Q?EoUV519SpEgDwMIrmEyw1z4JbAZ81NxIaOeIqp4vO+k/1Ft9k6P1NbOpv4xJ?=
 =?us-ascii?Q?JA=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 939489ae-321f-46ee-80b4-08dc4215d006
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR02MB9955.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 21:54:23.2771 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GZ0tnDF9m/jsTdQKXzG/QohgYPD4hPyIYgyFvTasxzxpPbbsjSsCvy+2HkIwQblUTnV2omtTMD+V4mM+Ny3keQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6849
X-Proofpoint-ORIG-GUID: eNSSeGAzt4QnFBgSCEpBtk277xYBThGg
X-Proofpoint-GUID: eNSSeGAzt4QnFBgSCEpBtk277xYBThGg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-11_11,2024-03-11_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12; envelope-from=het.gala@nutanix.com;
 helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.029,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Migration QAPI arguments - uri and channels are mutually exhaustive.
Add negative validation tests, one with both arguments present and
one with none present.

Signed-off-by: Het Gala <het.gala@nutanix.com>
Suggested-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/migration-test.c | 53 ++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 392d5d0b62..9e3146d23f 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -2608,6 +2608,55 @@ static void test_validate_uuid_dst_not_set(void)
     do_test_validate_uuid(&args, false);
 }
 
+static void do_test_validate_uri_channel(MigrateCommon *args)
+{
+    QTestState *from, *to;
+
+    if (test_migrate_start(&from, &to, args->listen_uri, &args->start)) {
+        return;
+    }
+
+    /* Wait for the first serial output from the source */
+    wait_for_serial("src_serial");
+
+    /*
+     * 'uri' and 'channels' validation is checked even before the migration
+     * starts.
+     */
+    migrate_qmp_fail(from, args->connect_uri, args->connect_channels, "{}");
+    test_migrate_end(from, to, false);
+}
+
+static void test_validate_uri_channels_both_set(void)
+{
+    MigrateCommon args = {
+        .start = {
+            .hide_stderr = true,
+        },
+        .listen_uri = "defer",
+        .connect_uri = "tcp:127.0.0.1:0",
+        .connect_channels = "[ { 'channel-type': 'main',"
+                            "    'addr': { 'transport': 'socket',"
+                            "              'type': 'inet',"
+                            "              'host': '127.0.0.1',"
+                            "              'port': '0' } } ]",
+    };
+
+    do_test_validate_uri_channel(&args);
+}
+
+static void test_validate_uri_channels_none_set(void)
+{
+    MigrateCommon args = {
+        .start = {
+            .hide_stderr = true,
+        },
+        .listen_uri = "defer",
+    };
+
+    do_test_validate_uri_channel(&args);
+}
+
 /*
  * The way auto_converge works, we need to do too many passes to
  * run this test.  Auto_converge logic is only run once every
@@ -3674,6 +3723,10 @@ int main(int argc, char **argv)
                        test_validate_uuid_src_not_set);
     migration_test_add("/migration/validate_uuid_dst_not_set",
                        test_validate_uuid_dst_not_set);
+    migration_test_add("/migration/validate_uri/channels/both_set",
+                       test_validate_uri_channels_both_set);
+    migration_test_add("/migration/validate_uri/channels/none_set",
+                       test_validate_uri_channels_none_set);
     /*
      * See explanation why this test is slow on function definition
      */
-- 
2.22.3


