Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDCCFC54E5D
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 21:55:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjnbS-0002uO-Op; Mon, 11 Mar 2024 17:54:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rjnbO-0002tQ-LT
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 17:54:34 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rjnbM-0003BS-Eg
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 17:54:34 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 42BD9aGi009722; Mon, 11 Mar 2024 14:54:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :content-transfer-encoding:content-type:mime-version; s=
 proofpoint20171006; bh=DtGEwYAi4oVRLd7aOP9RYQF/76jQEVXtPhA+MN7nM
 Qw=; b=QREEDxAww8Kzqcx+tnibQIiBfnxrTYv1wgfVNS3zaaRqbWHUE7LSVUV2w
 mu98cdlqnymp4CXt+eiUsLeG3oVXiVac1icZTLO8sDrhlPS7pBFuC/cjvTWpaBWF
 A/TzAe/yFUtXY2dRV2T8vUGuiwCs0s/1v/1j50h6KYaBsHy9HwjvRIbkL54M/TKI
 ArCzSfoa1IqriFsrPDmm3jTbOICbPjaJ4f/A9l0lVjAFeB0mTpuMHfM53IhMEjwr
 75JcIQ2ivKC2nsqe18gUdTnjognCruiOl8FlPTkuRfWIOup9sP8FuE29tPll1L4t
 LtNnlmq7yC1FmSRgpGbdYpxAUHtrA==
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3wrqygmc7y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 11 Mar 2024 14:54:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YHgIq4VbEhTd1/ZZv8Cz4UVNaXpF4dz5NDhr3+agoTA7ZZPmNwDAbnGXBqGNxYU02Eb1QJQZO9MNEtVLaZoZ2aOluaOC7R8YpLegL5+zoOWRyVqq0msTjiRFxoWsU1HYmHqY59BC2GE4O8G2HWBAyv8Mz90dfmJ06K/A8svbWJ9VACCgqQj0qmXrWblNj+WegRDn6cwtrXBLGyZlqCSzt2DwmkZLTw+VfgO63Tekk8fSu4REZry5EJ3Pr471l6Ob5n70KBHEvBG26bxJasEdtD/ps8XXgPwCN7EceckCrcsAWdm76JMrMQfjJr9IIrj+ieRk+m6hwUiTtPugrwEfRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DtGEwYAi4oVRLd7aOP9RYQF/76jQEVXtPhA+MN7nMQw=;
 b=Yms5ShFPQ/GTlanz/BFlDzPjIgD3QSmbfDJgJdqR3txPIEEM84BZlvOcDSEZ0Kp1hC372CATGi3CWSsnjL0vZl5Pywp9dgRp0UbzItBiZAXEh2xjXGJ/G+EictR4g/q84iySeue3AF+eC2UsdxYNP5u/qkXiy6x0nd1TOHvwl0vnDj8xshYYSOYugmUjPmR6Rwiw4k7Jz8Rx/sXwQQviYfm+YgoNt+RSd1j90ACCH//IPAJtF8tf9CcnjfNpwEPbQTs4oZ21kQVwgZOEYMl52AblXcZugPbWVCjrAofcND6OfYjpjtNycp1oNSS+5vdUh8roMzoMgEwVJ0ULV5BSsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DtGEwYAi4oVRLd7aOP9RYQF/76jQEVXtPhA+MN7nMQw=;
 b=eFYrrMln020oSPPKhhjpNbTAjQK+Qa8F9zji/3chXlHLD2+nbwNjAuHJFQS6eJkSIDBkN0pRXgIcIw81O1AK8Kxf1oszTHyEaRK8ydqgY+RacWkNZ9GoQMRqwb+Yn2VbZhiyxQnNVkkX5PrqpJxeJu01U8Xsuqg58qIyRFX7yWnyJzZRiaGz7ebgyJrJX014UJcyy/qf9LrWOX8mkJagKPfI/YjY4es5JXHUR621CqOkSFssdqyaS7+GqgMl1+QfWYMJ7UJ+U9ZtLAHFOYkVGi6zG/lYbfOzdZqpTlV7ab8Ii7HRjiQIgDyo77YwSC0JZT54lWElK36DcrnKX+FDGg==
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com (2603:10b6:a03:55f::16)
 by BY5PR02MB6849.namprd02.prod.outlook.com (2603:10b6:a03:20c::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Mon, 11 Mar
 2024 21:54:25 +0000
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0]) by SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0%7]) with mapi id 15.20.7362.035; Mon, 11 Mar 2024
 21:54:25 +0000
From: Het Gala <het.gala@nutanix.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, thuth@redhat.com, lvivier@redhat.com,
 pbonzini@redhat.com, peterx@redhat.com, farosas@suse.de,
 Het Gala <het.gala@nutanix.com>
Subject: [PATCH v5 4/8] Add channels parameter in migrate_qmp_fail
Date: Mon, 11 Mar 2024 21:53:54 +0000
Message-Id: <20240311215358.27476-5-het.gala@nutanix.com>
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
X-MS-Office365-Filtering-Correlation-Id: 192b0eb9-ed97-4f62-de35-08dc4215cb9f
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PqZcH7wnql2rh+89w+FAH1GcIsZZZBEq6Cg4ZsPb7mYBaHekwYo714HXmTAZ1PpmssIW3eg9SG7rt66WwdwccSl1o+LlwyBtLQxrz85iOBrdIonJgr6XFW2qBudaYLjt3EqMkZd+SR2BxIitpGF6GCh/vBmngIdkpnH4VzBgUhVJd/O/VWQcN2yJTAj0sb/FsfIQyeoYj3gafPBjEl7AeWjCXCODYeN6TruhUR2cGDiStn1UdQAfdV6BOJ101uVM237eSbkShK0sXwBjW1GfqFMxkZCLYEcyWbuGpRUFtlpSS8kGeaqWwTtofLwFG95asI+V7vrR6+8T2IorhnshEH+KQZ/f0KRbop79pghejBPd8AvRUqRf+k5WCSEgD+HyiQBhoQpPRAAshlp3LBIYdKwUOrfDep0GLsxBAPICqJ5WV+QhhQOgnTI9cUA9//jJef6NfZZ4nxhvXtEhw9pUToj+PwxsdoNl0hM/svtjzCvDZvgbUE/sM+7/gNVxXy/ARbbcdzA5Nm8LRvuytba+GS9xP09b64CDI023+yn2tpA6Y+z5lBYjDumUxUW36XxD8AO401JPx3UXPzY+YIz3mMkzUlTazxMCJwxIuv1e3FpbRthjTf2DE7KXYS/QHua404I/EM+uv4k7BT1nxCAbNRJm66K5VB1DlJOBh2G2GspyCZkICR9oWywhXN6TDVTZaaCJevzlYFXFRL0zL3EY4s1NzhZFCC9rYzVaIKDrxME=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR02MB9955.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(52116005)(1800799015)(376005)(38350700005); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WSqBMshiy/t4lkj3hvNw2xx4jAJ0pJtKCyMy3egufEtUlwpc54M22Vkn2XRl?=
 =?us-ascii?Q?s6kuq0gRaVN2H6a7tFXYoUiKYliS28K1U6IE1W2LmL5F1FA+8zSXY+xQOB3i?=
 =?us-ascii?Q?D+RiWmyJIzqja+QtAqprnRzMlxV53gaDL1+x54MOBYyAHyapnirYzdTtlD5W?=
 =?us-ascii?Q?7H9ajenoYe3rrSd62nUpD4tjGtiJGok6KMoe+Jmvsqfeihw4lOFyXAbkTRsm?=
 =?us-ascii?Q?jUg8Ovsplj/5ebixCWQBNdWGOELySiwxVhoe48WzjnyhVYSxxViecPHfPqeb?=
 =?us-ascii?Q?/hKbwE2v++KQJyjrEsdzOqHGerBcyHNLJ2iEnVKKFyo4QnmDwGj/qUVNJlO/?=
 =?us-ascii?Q?wCujUHGBGQtq4uU22ge8WIbu/PwT41uex9NwMFPjKC6y0zNEbwV2RqOeutcZ?=
 =?us-ascii?Q?5jJYt5VnAYd8m2PHw3Xff/W/R/ZxA/w1Nde9qDuLuL+8saueM3UicTRo7gxo?=
 =?us-ascii?Q?H2oIvcSfguov1esjDZiw+EwpxsqTVuWadqJFPvOTyYDPkjn5TlczNkWeeLwX?=
 =?us-ascii?Q?jt/iJtTESWb4epJ2VjQyyT6RBxGfKIGRGM04yMT7ibExEoFLSTZCIlxzfw5n?=
 =?us-ascii?Q?NDFi+6YiClh2WPaaHRAKqphcZRXAqiJw5MBVuqCgyaE7YUNNe3guqW0gH60X?=
 =?us-ascii?Q?YJxKagvSIBKqYAgvIzERvNx5tEOFFSDcDVUAUzd4ZCt1HO/FZMXGOXL70L1x?=
 =?us-ascii?Q?t2f3BMTw/hMpZyYvr5XoI6d/XgfeirdJP6W/cE3UvphqlKnhqadH7McUedCN?=
 =?us-ascii?Q?YSd1Vkph3YNZcyjeYBgGCFi0v6b3DiwseqzSACTs3xJBERQ7K6dVKqpsfyzW?=
 =?us-ascii?Q?3urgRYzuh2N9zWBt8Ne/85MAUghuQmYGhn/M39fAruLYbF8lfC3KPnnKA7F2?=
 =?us-ascii?Q?OchOMRCO13fQSIaf8mf7wH/9Nam5tPJ03+TnByUHa6FlWBOGHGpE2GXSJuZ+?=
 =?us-ascii?Q?33Z2XuiUbpGbqaIs01O3iCbHNF5HGbUc/5CvIEJT1/UjQcnK7tfnKmp2wH/U?=
 =?us-ascii?Q?bog4IW/3UQyfnMvMQTu0F3c5S2daW+fcke/oxNQ40q8h1zI7BoxclTGDS41F?=
 =?us-ascii?Q?0hCUHaZ39TT3mMo5Zbg386UWNkc5EIhLcUgpSdvC7suAC9FFUGXLzMaWwZ4T?=
 =?us-ascii?Q?iixfD9EyLHuVQ0cD8qUp+dBFc4bfCi5gvnwfVYhpx5W2Oxr+1TCtcH9pQwqv?=
 =?us-ascii?Q?EFPGuV7vL4QbB26RPsJXckDEBkwohEto4nCbOBVmxToRiRokX5h3y9Dk/kpX?=
 =?us-ascii?Q?m+tpqK9CQ+SffGV8JvTWNn9hliPcILRIcqIfWLYxCHzoAn6xC0Y8rC8EvGgc?=
 =?us-ascii?Q?Ysh+LbCeyaLZokG//rR6lHWPFQyaU29VSf18flrGDhFfWV5ClUDperm6Eohe?=
 =?us-ascii?Q?CU0Nt+4cLMCcamMctY38OJzLtuZ4xcb4LUYe4AkIrdpluHHMBd32egh6ck4x?=
 =?us-ascii?Q?+dvVSSiDqWpNBqfhupAtmDc5rvG/8ulIrdlamXsBxAt3HRWJtxJz+IWOJk4y?=
 =?us-ascii?Q?1Dtw/wRbPlh9E4YQ6rL2Ex5YWKZ10waYeiexHoz7FsNVgw42l+8+yw31XNpq?=
 =?us-ascii?Q?Lu5UQxqjdENym862ErEyoQXo3fWPa2fpb2b0yyqkXT76js9V4k+bto9DcnUr?=
 =?us-ascii?Q?8A=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 192b0eb9-ed97-4f62-de35-08dc4215cb9f
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR02MB9955.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 21:54:15.8818 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s5/yXvwqWn1ivIkrunnZmEG/zZO/ylVNFLddntr0tVTTKrwuXkucJCUKP5FUg8rkX+kfoy2Z1se44Xh3L9mfUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6849
X-Proofpoint-ORIG-GUID: c0LeN31-MZih50qu28nxu3H9SX9rG_aZ
X-Proofpoint-GUID: c0LeN31-MZih50qu28nxu3H9SX9rG_aZ
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

Alter migrate_qmp_fail() to allow both uri and channels
independently. For channels, convert string to a Dict.
No dealing with migrate_get_socket_address() here because
we will fail before starting the migration anyway.

Signed-off-by: Het Gala <het.gala@nutanix.com>
Suggested-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/migration-helpers.c | 13 +++++++++++--
 tests/qtest/migration-helpers.h |  5 +++--
 tests/qtest/migration-test.c    |  4 ++--
 3 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/tests/qtest/migration-helpers.c b/tests/qtest/migration-helpers.c
index 8806dc841e..f215f44467 100644
--- a/tests/qtest/migration-helpers.c
+++ b/tests/qtest/migration-helpers.c
@@ -100,7 +100,8 @@ bool migrate_watch_for_events(QTestState *who, const char *name,
     return false;
 }
 
-void migrate_qmp_fail(QTestState *who, const char *uri, const char *fmt, ...)
+void migrate_qmp_fail(QTestState *who, const char *uri,
+                      const char *channels, const char *fmt, ...)
 {
     va_list ap;
     QDict *args, *err;
@@ -110,7 +111,15 @@ void migrate_qmp_fail(QTestState *who, const char *uri, const char *fmt, ...)
     va_end(ap);
 
     g_assert(!qdict_haskey(args, "uri"));
-    qdict_put_str(args, "uri", uri);
+    if (uri) {
+        qdict_put_str(args, "uri", uri);
+    }
+
+    g_assert(!qdict_haskey(args, "channels"));
+    if (channels) {
+        QObject *channels_obj = qobject_from_json(channels, &error_abort);
+        qdict_put_obj(args, "channels", channels_obj);
+    }
 
     err = qtest_qmp_assert_failure_ref(
         who, "{ 'execute': 'migrate', 'arguments': %p}", args);
diff --git a/tests/qtest/migration-helpers.h b/tests/qtest/migration-helpers.h
index e16a34c796..4e664148a5 100644
--- a/tests/qtest/migration-helpers.h
+++ b/tests/qtest/migration-helpers.h
@@ -33,8 +33,9 @@ G_GNUC_PRINTF(3, 4)
 void migrate_incoming_qmp(QTestState *who, const char *uri,
                           const char *fmt, ...);
 
-G_GNUC_PRINTF(3, 4)
-void migrate_qmp_fail(QTestState *who, const char *uri, const char *fmt, ...);
+G_GNUC_PRINTF(4, 5)
+void migrate_qmp_fail(QTestState *who, const char *uri,
+                      const char *channels, const char *fmt, ...);
 
 void migrate_set_capability(QTestState *who, const char *capability,
                             bool value);
diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 9bb24fd7c5..da4b0006c7 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -1717,7 +1717,7 @@ static void test_precopy_common(MigrateCommon *args)
     }
 
     if (args->result == MIG_TEST_QMP_ERROR) {
-        migrate_qmp_fail(from, args->connect_uri, "{}");
+        migrate_qmp_fail(from, args->connect_uri, NULL, "{}");
         goto finish;
     }
 
@@ -1812,7 +1812,7 @@ static void test_file_common(MigrateCommon *args, bool stop_src)
     }
 
     if (args->result == MIG_TEST_QMP_ERROR) {
-        migrate_qmp_fail(from, args->connect_uri, "{}");
+        migrate_qmp_fail(from, args->connect_uri, NULL, "{}");
         goto finish;
     }
 
-- 
2.22.3


