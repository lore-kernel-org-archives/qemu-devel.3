Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C056C5475B
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 21:55:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjnbh-0002zL-Ma; Mon, 11 Mar 2024 17:54:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rjnbS-0002uZ-Rr
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 17:54:39 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rjnbO-0003Bw-9m
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 17:54:38 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 42BIALur029947; Mon, 11 Mar 2024 14:54:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :content-transfer-encoding:content-type:mime-version; s=
 proofpoint20171006; bh=lpeZyO/AkWR3UvydOmRQiK24k2sCcPECdlmaeXVTW
 E4=; b=zqw6KyOdlKDqkRwkHMKCHeeREtBdxcTmHAYuYpMNz5XMCDaLbgqs2vXBR
 MIdj+7/hNoWkipZuxLDGOIgSiRRCZRj0zy3etCXn7xS0Rk+pz0pR9xXqDhTj6zRw
 Bv5Djt54nmzSmxR8YYDIqIE2O4p4HCrFMQ9jH3SzQkeYlS2pE0xJaoFUP6zgpey3
 dnYHBYu2bUiMApxcUXaBXTtiHY1Yk2Q1hBokI59ObWO+/Az1ky1ytELFfoRJ669o
 YjY9wA4hP/7kg29RY63khGR3IxafVzxewxJrd13ufi2XitGpRJn7tUwFGy7wpqnd
 g3zB53HeqsXInnkhjJl+NLpmj+tsQ==
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3wrqqhm8d5-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 11 Mar 2024 14:54:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FeRGjfA0uWKziDezsnd87aQwuarIErm8vfjCbYMW7GEFqbowkY93mT6RThZh2MyGBjHXB0zue+ThPhmkAPqlN08GnCBqw2/CRn3lgk5HjKQ9yvTDfwVWlrq3L76A6uNZ/xUUCISOuweI3NiKJ/BxNGlIjZIyXmlFpF/5Gx8mmTZyjKlGWBbNiOPkzWYtaiGn4OpH45eZDTZM6z5u++N9i0zwGr1G8JPAqkoITltwY7OF2nahAJ99CLRS61fscfE21A4xyEWD/1fkXfoQJjhPNUIeOHLDjbIfhuE9VAq0MA4+lm8rYPyA//vitmGsrVvugiQpFQcnvKFQInj7QrncOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lpeZyO/AkWR3UvydOmRQiK24k2sCcPECdlmaeXVTWE4=;
 b=UebrxFeJ+tuw4RSt/wUcwUcle81KZRR9oot3202FdVQXtCl5gZOSQaKfwXvfhBpNdBRPYyWG7n4JRdk3zFmFmyZnLckoabjh6L9nmo2GLZFE3yIJl04F0iGdU8RV6FgXO05wZsmeraFNPffmb4Vffzzofyt05LopMqvc7KLNfZY3tpPr0T2y+1TQ9aKmCnYxAq4zypga8FaIlC78BTtY4VyEeQJqYoKDRnB76SWm9OvRRF9hCrihueKNq1WVdGBQKjpNFdwcAAbEvBI1YxoZjngP1O5v03a79Ex7cAZwHYLVm6eKDerQzDlSig/179Nuo95zhvpwCu9/ox+2+t2oXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lpeZyO/AkWR3UvydOmRQiK24k2sCcPECdlmaeXVTWE4=;
 b=ahclRB44zGiRkzKyuyHP9DTLcJJ34YlT680alFk+SUFidC2RkgH0tXYEH18k72aTohiGS5vUOdWpZMSSFOgH1NMloC2loopTXXrOQsk3SZSebybGw4moDg0oppVDLbZAtzQypNAJzo4YFHxpETeevkPKModM9gXIgKbYgsb85Hw3KxKvasJSDvnb9SOQmNYEHtDfKGaXop2e+g30JKgJBkSzpIJLgSjhjLGjIH4f7k86zq8B2evADSl8+KppyjKyKOPEEEDejaDZYTo+aJdDSDqiuOlM5hdUDcf8iKx5lXLUOChvNmpLTbSKYKcKKmhTwDaJsbfuo5ByYR756PavuQ==
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
Subject: [PATCH v5 6/8] Add channels parameter in migrate_qmp
Date: Mon, 11 Mar 2024 21:53:56 +0000
Message-Id: <20240311215358.27476-7-het.gala@nutanix.com>
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
X-MS-Office365-Filtering-Correlation-Id: ea809c61-7a75-4203-58e2-08dc4215cd90
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l94ld/Hyeo/dEK9FJgMaONsp+Se56sHadbl8MAA2MvD/mWSgc7oYEBALBk/QpH1wNhF8jtqp//T6qYwo6/4hj1Shg3hAc+8Aptj9gOHbmqwHr1sJ+zpRxWcwdipXS3eV8ObrX7ZPxDWSkOlAAYjZ5GusVEGtTJNjxmlaUuxhUF7QgEW3rJw5HN0/rXWvfFSk/tkqPwCrDlxcxZKz8D9cjZrNUL746uauedP/OpM+LiLyGRPGv2nY4hiRtH9XrvXh1hMe28dAfrea5O5mxONkOfV0NlhHMCzVcFxdlRHzbb2eqaA180nf2r4yml9BhKdRECrzUx2rzxX/pTxeZ62P+SS4YyQcXYbatxIYy6fgognMy1d/bxWHIBPflSbuPRGFpFGwEfMEXgeaBM9ovDzSQ2CoCb/T0xS4gzCzh1i4X7RzjWBUJTBpgTOmqbKllvOpYrr8zHsqvEJLSbJLsg2rsiUTQ6INQiuk0xd8wgpSCckdBqRPXteTfswFmANKZq2rlxoU80v1BAQEHnH7mRKRvl+I1DvnZCaSaruSmepfsq6VqZkE18eQS3hRTHJugHFFL7ARmAs/W8xBlvs3F3dqOh8FS6EQsuSA+XD4LupMSpCbqEa0USoAmAZKJ0snhlhV8m/g+S4fYCqgTbKminIYUUghw4ebpuCZ8UQ3Jd5FqLopZRKhMp8XMNZ5qa/E3vidNxRGNDeWChKWU1qAjopa8Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR02MB9955.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(52116005)(1800799015)(376005)(38350700005); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LMY4/MNMXSZ9s+om/yC95zPOSbSDMxoPw8dDZrvTvnOjX6xJQPaA/4SrWZQI?=
 =?us-ascii?Q?SDfe3SDsHots/EYhbMKbOFRq9jtjq26UAKEUW6HC1KklrainZ+jNz0r7cfqQ?=
 =?us-ascii?Q?2MtlxTDPwJcwKWLLJum5/q/Eg8UBetPbHV4AaCMUZJA4yTmE9RGBqFQ6ytnn?=
 =?us-ascii?Q?gKmkgnTj04wi5HCmUhamJSodwh7RmKQMdoOZG2uiZwPb+C5LXnC1izqtZmPJ?=
 =?us-ascii?Q?KPQSDZH38zBxMtbRgGOMcwYGurQwZMwV7KMJ6svKHohtbJsz8SR4PI0Ist2q?=
 =?us-ascii?Q?41RUuijmz8L4Cd/bt5mHeaqPg2mKgQKPxBcF2p7coC1dwxG3JRKGtnIDoNXj?=
 =?us-ascii?Q?mDaP1FoYXXPi5dkKAYtx48uBs2ZIUZJ3mQd82v6HMSSkuUr2n+HpMp+I1og0?=
 =?us-ascii?Q?mLzVZ1F0akBP3NVJpfcNcG16A59T/MB8yxb81OlCWrFXPW/fkTHKgXayV9RV?=
 =?us-ascii?Q?0rTOPdW3aJi0eTRDln8JcrxWBs7y+wdyaar3LzzWZDK7u0jORlxGTPrJrb7q?=
 =?us-ascii?Q?kIQSm9NHYq1RDt7/0skL7E/bhRetyBdJdlQfcIh+Bzj1Ky1usT002I3uZ8aV?=
 =?us-ascii?Q?33Jqg21JYna/fpS97WYTGXhDb7ETusepizGiTrZy+9D6JNdpG7BaC3OSpLmO?=
 =?us-ascii?Q?5IFKfzr4MADXoL31c/3dzX/tYyN/XCM1G4phBbMU+8pxJs5ItqRmptw3FJS8?=
 =?us-ascii?Q?iRukeJ4I1sVqEUH8PBK2cu01hMJ1OH806eTmOx8GXrbUGHKgRiyoQH0h/NAH?=
 =?us-ascii?Q?26Ew8kMHAfC3BQkUvuIecouODoC00BL3PcpkND9K9ZyALI8aoY4t9zUPWH2K?=
 =?us-ascii?Q?huRVIT3KqD8z7C+2Q1YYuSvfHANfbrkXGkzgYTe7wq82+PPfEl2QHOBuYGT3?=
 =?us-ascii?Q?rsyz91UEughVA24lfxthyfyX3eSvow/65aGJ9SaaJcO4bunqosKyqS2FsoeS?=
 =?us-ascii?Q?xEkKIqALr9LnGPfFpKJdsIWZkJsR56oD9It1tXyYlRSGcyFklHynoWzj0A24?=
 =?us-ascii?Q?2kXnzKYiifg7pSWptMrnpqsldZ/tLhqOVbCkUxLal93mfyREgvQPftRNgfpj?=
 =?us-ascii?Q?vNyc4i0FyaFimUcJ+csK1xhFQWYW1/R1FawALvHyAgfFc2NXKtQEvqO6pjiK?=
 =?us-ascii?Q?RBTlalWwUf/ea6gelXoDb+tG9QymWJsoJaJjPpK8HR7QGljFBgPPHugQn+D5?=
 =?us-ascii?Q?eyBA9egpTFtBWGHqw5t3NHyCgE7iJdKhg8fZUhvY54XKYbaC3BCtdJ11+K6S?=
 =?us-ascii?Q?TMfK7VKMGnAWZszXyRPPo/HTj/AhVUb7OCx+GZ9VwOBPtWu4B4pt0YwWmymd?=
 =?us-ascii?Q?NhppaR0DVhvWxNWAXsbBf2pUbfr9Ek8fFrsqLcaUZJg7HmYum2iGOHMjop7x?=
 =?us-ascii?Q?XvCzANdmih7JfcOVt4JVVBl1jhr/Liz8fTtmLfo3QeCAeclSogy7qHz0rfK1?=
 =?us-ascii?Q?A/4NX26+oETtFcEPyjBtz5e8fkj4DyQ29IavChTPl/sgIDaUWmaBHyHeCV2g?=
 =?us-ascii?Q?t3O1zLYYb4meD/+yTfizwtvMMeXTJ96Fi11uDq2m90WeE3IpOit0F6BAgbbd?=
 =?us-ascii?Q?1p+agukXspf7mQoIQV/2ZOp53wyUzapqnTiQDF+vnFJCspYwWKFLPYO0fqBd?=
 =?us-ascii?Q?Dg=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea809c61-7a75-4203-58e2-08dc4215cd90
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR02MB9955.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 21:54:19.1415 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GMKiZIWOjBGIx1w4Etnm6XNy+6EQbYPotviWq4dxEVre+GaotALPXUJ5ROd9PuTulk4MgLIQ8rVFoGuKRZNNdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6849
X-Proofpoint-ORIG-GUID: yagGChd_c8I4QIenWthMlWrRXvk6soTE
X-Proofpoint-GUID: yagGChd_c8I4QIenWthMlWrRXvk6soTE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-11_11,2024-03-11_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68; envelope-from=het.gala@nutanix.com;
 helo=mx0a-002c1b01.pphosted.com
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

Alter migrate_qmp() to allow use of channels parameter, but only
fill the uri with correct port number if there are no channels.
Here we don't want to allow the wrong cases of having both or
none (ex: migrate_qmp_fail).

Signed-off-by: Het Gala <het.gala@nutanix.com>
Suggested-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/migration-helpers.c | 22 +++++++++++++---------
 tests/qtest/migration-helpers.h |  4 ++--
 tests/qtest/migration-test.c    | 28 ++++++++++++++--------------
 3 files changed, 29 insertions(+), 25 deletions(-)

diff --git a/tests/qtest/migration-helpers.c b/tests/qtest/migration-helpers.c
index ed8d812e9d..b2a90469fb 100644
--- a/tests/qtest/migration-helpers.c
+++ b/tests/qtest/migration-helpers.c
@@ -133,10 +133,6 @@ static void migrate_set_ports(QTestState *to, QList *channel_list)
     QListEntry *entry;
     g_autofree const char *addr_port = NULL;
 
-    if (channel_list == NULL) {
-        return;
-    }
-
     addr = migrate_get_connect_qdict(to);
 
     QLIST_FOREACH_ENTRY(channel_list, entry) {
@@ -208,11 +204,10 @@ void migrate_qmp_fail(QTestState *who, const char *uri,
  * qobject_from_jsonf_nofail()) with "uri": @uri spliced in.
  */
 void migrate_qmp(QTestState *who, QTestState *to, const char *uri,
-                 const char *fmt, ...)
+                 const char *channels, const char *fmt, ...)
 {
     va_list ap;
     QDict *args;
-    QList *channel_list = NULL;
     g_autofree char *connect_uri = NULL;
 
     va_start(ap, fmt);
@@ -220,11 +215,20 @@ void migrate_qmp(QTestState *who, QTestState *to, const char *uri,
     va_end(ap);
 
     g_assert(!qdict_haskey(args, "uri"));
-    if (!uri) {
+    if (uri) {
+        qdict_put_str(args, "uri", uri);
+    } else if (!channels) {
         connect_uri = migrate_get_connect_uri(to);
+        qdict_put_str(args, "uri", connect_uri);
+    }
+
+    g_assert(!qdict_haskey(args, "channels"));
+    if (channels) {
+        QObject *channels_obj = qobject_from_json(channels, &error_abort);
+        QList *channel_list = qobject_to(QList, channels_obj);
+        migrate_set_ports(to, channel_list);
+        qdict_put_obj(args, "channels", channels_obj);
     }
-    migrate_set_ports(to, channel_list);
-    qdict_put_str(args, "uri", uri ? uri : connect_uri);
 
     qtest_qmp_assert_success(who,
                              "{ 'execute': 'migrate', 'arguments': %p}", args);
diff --git a/tests/qtest/migration-helpers.h b/tests/qtest/migration-helpers.h
index 4e664148a5..1339835698 100644
--- a/tests/qtest/migration-helpers.h
+++ b/tests/qtest/migration-helpers.h
@@ -25,9 +25,9 @@ typedef struct QTestMigrationState {
 bool migrate_watch_for_events(QTestState *who, const char *name,
                               QDict *event, void *opaque);
 
-G_GNUC_PRINTF(4, 5)
+G_GNUC_PRINTF(5, 6)
 void migrate_qmp(QTestState *who, QTestState *to, const char *uri,
-                 const char *fmt, ...);
+                 const char *channels, const char *fmt, ...);
 
 G_GNUC_PRINTF(3, 4)
 void migrate_incoming_qmp(QTestState *who, const char *uri,
diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index da4b0006c7..bf27766eb0 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -1301,7 +1301,7 @@ static int migrate_postcopy_prepare(QTestState **from_ptr,
     wait_for_serial("src_serial");
     wait_for_suspend(from, &src_state);
 
-    migrate_qmp(from, to, NULL, "{}");
+    migrate_qmp(from, to, NULL, NULL, "{}");
 
     migrate_wait_for_dirty_mem(from, to);
 
@@ -1451,7 +1451,7 @@ static void postcopy_recover_fail(QTestState *from, QTestState *to)
     g_assert_cmpint(ret, ==, 1);
 
     migrate_recover(to, "fd:fd-mig");
-    migrate_qmp(from, to, "fd:fd-mig", "{'resume': true}");
+    migrate_qmp(from, to, "fd:fd-mig", NULL, "{'resume': true}");
 
     /*
      * Make sure both QEMU instances will go into RECOVER stage, then test
@@ -1539,7 +1539,7 @@ static void test_postcopy_recovery_common(MigrateCommon *args)
      * Try to rebuild the migration channel using the resume flag and
      * the newly created channel
      */
-    migrate_qmp(from, to, uri, "{'resume': true}");
+    migrate_qmp(from, to, uri, NULL, "{'resume': true}");
 
     /* Restore the postcopy bandwidth to unlimited */
     migrate_set_parameter_int(from, "max-postcopy-bandwidth", 0);
@@ -1620,7 +1620,7 @@ static void test_baddest(void)
     if (test_migrate_start(&from, &to, "tcp:127.0.0.1:0", &args)) {
         return;
     }
-    migrate_qmp(from, to, "tcp:127.0.0.1:0", "{}");
+    migrate_qmp(from, to, "tcp:127.0.0.1:0", NULL, "{}");
     wait_for_migration_fail(from, false);
     test_migrate_end(from, to, false);
 }
@@ -1659,7 +1659,7 @@ static void test_analyze_script(void)
     uri = g_strdup_printf("exec:cat > %s", file);
 
     migrate_ensure_converge(from);
-    migrate_qmp(from, to, uri, "{}");
+    migrate_qmp(from, to, uri, NULL, "{}");
     wait_for_migration_complete(from);
 
     pid = fork();
@@ -1721,7 +1721,7 @@ static void test_precopy_common(MigrateCommon *args)
         goto finish;
     }
 
-    migrate_qmp(from, to, args->connect_uri, "{}");
+    migrate_qmp(from, to, args->connect_uri, NULL, "{}");
 
     if (args->result != MIG_TEST_SUCCEED) {
         bool allow_active = args->result == MIG_TEST_FAIL;
@@ -1816,7 +1816,7 @@ static void test_file_common(MigrateCommon *args, bool stop_src)
         goto finish;
     }
 
-    migrate_qmp(from, to, args->connect_uri, "{}");
+    migrate_qmp(from, to, args->connect_uri, NULL, "{}");
     wait_for_migration_complete(from);
 
     /*
@@ -1972,7 +1972,7 @@ static void test_ignore_shared(void)
     /* Wait for the first serial output from the source */
     wait_for_serial("src_serial");
 
-    migrate_qmp(from, to, uri, "{}");
+    migrate_qmp(from, to, uri, NULL, "{}");
 
     migrate_wait_for_dirty_mem(from, to);
 
@@ -2548,7 +2548,7 @@ static void do_test_validate_uuid(MigrateStart *args, bool should_fail)
     /* Wait for the first serial output from the source */
     wait_for_serial("src_serial");
 
-    migrate_qmp(from, to, uri, "{}");
+    migrate_qmp(from, to, uri, NULL, "{}");
 
     if (should_fail) {
         qtest_set_expected_status(to, EXIT_FAILURE);
@@ -2651,7 +2651,7 @@ static void test_migrate_auto_converge(void)
     /* Wait for the first serial output from the source */
     wait_for_serial("src_serial");
 
-    migrate_qmp(from, to, uri, "{}");
+    migrate_qmp(from, to, uri, NULL, "{}");
 
     /* Wait for throttling begins */
     percentage = 0;
@@ -2969,7 +2969,7 @@ static void test_multifd_tcp_cancel(void)
     /* Wait for the first serial output from the source */
     wait_for_serial("src_serial");
 
-    migrate_qmp(from, to, NULL, "{}");
+    migrate_qmp(from, to, NULL, NULL, "{}");
 
     migrate_wait_for_dirty_mem(from, to);
 
@@ -2998,7 +2998,7 @@ static void test_multifd_tcp_cancel(void)
 
     migrate_ensure_non_converge(from);
 
-    migrate_qmp(from, to2, NULL, "{}");
+    migrate_qmp(from, to2, NULL, NULL, "{}");
 
     migrate_wait_for_dirty_mem(from, to2);
 
@@ -3331,7 +3331,7 @@ static void test_migrate_dirty_limit(void)
     migrate_dirty_limit_wait_showup(from, dirtylimit_period, dirtylimit_value);
 
     /* Start migrate */
-    migrate_qmp(from, to, args.connect_uri, "{}");
+    migrate_qmp(from, to, args.connect_uri, NULL, "{}");
 
     /* Wait for dirty limit throttle begin */
     throttle_us_per_full = 0;
@@ -3372,7 +3372,7 @@ static void test_migrate_dirty_limit(void)
     }
 
     /* Start migrate */
-    migrate_qmp(from, to, args.connect_uri, "{}");
+    migrate_qmp(from, to, args.connect_uri, NULL, "{}");
 
     /* Wait for dirty limit throttle begin */
     throttle_us_per_full = 0;
-- 
2.22.3


