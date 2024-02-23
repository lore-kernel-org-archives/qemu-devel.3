Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B57D5C54798
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 15:38:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdXcG-0002Xf-IJ; Fri, 23 Feb 2024 10:37:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rdXQd-0007Jv-26
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 10:25:35 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rdXQZ-00033x-Oa
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 10:25:34 -0500
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 41NBN8iM030719; Fri, 23 Feb 2024 07:25:28 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :content-transfer-encoding:content-type:mime-version; s=
 proofpoint20171006; bh=FT6h2purXtdvxYBTixoMMzyI4TT5v+l7QFkYsidJr
 Z4=; b=llth3KedzwDWCmBM9Fedc0ngPHpLbT7xgq+58zNpaE/1JqvA6V26s+xiB
 UaCqErKO3GFRJxMtaAyiolVvmpM4Cd363tzGrS7VlZIXoymHe/vAVa4gUbSF9jAK
 Nq5imIzE9DZUSWJCFlQi5y5cgsuIRZsm/JpjNjWwsfBJxzHldauyhqZXGZjaSSdE
 9Y1CUHDw/soXi25V72k3ADKggScWjCEbL/EYqrhXVuDwfj4eiUz+AFS2CFXtLn6p
 8SbNUjBDMBJyGFXwat+I8T7MfycdEtAMxEQ+0CkFjhpdNOT3o0rHj+mP1/eC7pgn
 Ob3JT4PPzk/IEd3WYL8Mti146ExOg==
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3wd21u7wrn-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 23 Feb 2024 07:25:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ThVdz2+NzwKP1sPdsgRFGPQ2/GLHDNw8Nf+I7etVpgqE902B+U5+nMpse/uI5N34nFE/g97Pg0zbsShLFjIQK/Xuz+xVeJK4MT0iT1xblPhP+CePCNq9mWR0AKHkdh0FJcZ6rwC6O/TEIzE5uvNhbZ4kFt8exkjY4Pz4DuCFe9M/tH8DJ9N5SqknV+dtGYh3Jt1QnYNilHakUB2H/IPcn5yzYrarUNzsrdQwo6GlEfojKrl2K//GWCqBXb2oNLd83G5k70LpELpKNkfT8Rfrsg2GFI2Pf3PAcKb1QUleWcS1RvnQTFZ2KaB8c5yAtYNiXR54Tri96yrhXGzYBstGwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FT6h2purXtdvxYBTixoMMzyI4TT5v+l7QFkYsidJrZ4=;
 b=OQswG4cB00Qkxid9F0HmsOlC9a4f5CUqGlltEHX8UHMEQQ7PRu++BaXmS2BdYuClXOxXpE2UYOEYDfEuXhO8VVfu2GfNdrhTrHX8w3CG3R05Rm2SqpNE/MZtVizYMkSlNkkYF3lSpK4Q+HiMF4r8DF9SfVyMkAHha/UbAGKCsjGjokHjhhPkUN5bMhdSDEwPYQVy1faQGYep10iyi/LsdFGByengC2GaPVd8iEcSwXLrwn7AoCGNDcXWpcZ5In6yOUPXqY58ZMjxPNnW1e3WYOTa3cVpL8SEzj19Trz4WjFm/A8vAuyGtnvbuPty84uvcK3/Wo4Lp6gSjVtKqJNIfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FT6h2purXtdvxYBTixoMMzyI4TT5v+l7QFkYsidJrZ4=;
 b=JFS5Xguq6+fnjsenJ3TVR8fMOcbpcArHdySGK6Gv/dGt8KS0MHr47h+Do2b8VrA66XJKuzlWGSAER28T25oqKULHdufkNRIFqNjrSTnScL4mlngwpvRCANt6Xwm7rhhDXBhO5h7sRwMPtprXnTndASfGHvIQAbBrnzfvr3dGoEYwLWTsqPn3xgCdWAtsdBppg9JrFf/O9CoTNHhFG+IQW5JxmHNTmXt9jmX54LMLUf18+y7X0wvWAIFnLMQ8s6ACf/duRXYK5J92BMepvgpWj8bjFwXRe05kUiLZtKfu9RdeqrBLLfVtNinCEAuVM7o4RjVictZKDxsuRYQKHG4uNA==
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com (2603:10b6:a03:55f::16)
 by DM6PR02MB6794.namprd02.prod.outlook.com (2603:10b6:5:214::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.24; Fri, 23 Feb
 2024 15:25:27 +0000
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0]) by SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0%7]) with mapi id 15.20.7316.023; Fri, 23 Feb 2024
 15:25:27 +0000
From: Het Gala <het.gala@nutanix.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, thuth@redhat.com, lvivier@redhat.com,
 pbonzini@redhat.com, peterx@redhat.com, farosas@suse.de,
 Het Gala <het.gala@nutanix.com>
Subject: [PATCH v2 3/3] qtest: migration: Start migration with 'channels'
 argument
Date: Fri, 23 Feb 2024 15:25:17 +0000
Message-Id: <20240223152517.7834-4-het.gala@nutanix.com>
X-Mailer: git-send-email 2.22.3
In-Reply-To: <20240223152517.7834-1-het.gala@nutanix.com>
References: <20240223152517.7834-1-het.gala@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH8PR07CA0002.namprd07.prod.outlook.com
 (2603:10b6:510:2cd::9) To SJ2PR02MB9955.namprd02.prod.outlook.com
 (2603:10b6:a03:55f::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR02MB9955:EE_|DM6PR02MB6794:EE_
X-MS-Office365-Filtering-Correlation-Id: fe732d63-0eef-4a0d-9e24-08dc3483a97a
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KBcb/rDcTGniiunxXZCdOKvWHvbGD1bQSGGcPZCAYcQBcei7HT4c893yQEAYWMn71VvwMaD2V6g62UZIoB/CSRAgxvJTYjjMN8/WO7FR+ydbGhTB0vpvOcrIbX0ie1dta7vZxGIpswJ9380jg+1X+OtCEAqwRK3KkbomgEW7IpAOuTpaU0Wsvfh+O0zFirWsRiSiINZDO2pfi9Ee8TL6pwWH8VZD4WKbX12Wqoyc386CxKqSbFSX+x9IlLampIhqQHsJeovqi72OwM+/AWaXQfgCifdcKEp/74w9YxvujTi1NWwBTPqDpdr5lJbXGt2m90gMk5kgi8V8uc6bTaD3BR7U/XQJiL4qhYc8b3WnOGtzMQNkLSlm4rSi/+A84K5M0D1CIMv46bw8I1HUPA99AmucB9r/72J9NL6ua0gfYyjo87ZAySNpWkT71/VsPivlViNLMbrZQPzgy//6wDw0PYsMeleqU0PO5VEnJXB1g2HxnQgbRDqMjQTUUOrR6jUcKsc9lusuXw2EhtNOXlpQXrtYcXZmcOzAK15defEOYK2/fge3HypUau3Nnk55S8cG6KIEC/trwGsiSQ3FqzD341VjRnZoVNe+BiQR0eznJcFUeNxeyiPOO1g2JKe089pB
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR02MB9955.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(38350700005); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pZOuixIQGvoR5oHgmqTzZ/FfbZF/6bX7f+eQNAJ+IJuuoQu68jzsDuv3Qhww?=
 =?us-ascii?Q?M4wwOk0Fhjnd43z315MZkJ0WkM74KT7+Yf8nXz1Qze5VBdSpGC/42AUcDArA?=
 =?us-ascii?Q?Hb2OgZbKuzZwYGVh1q1DONOamQvjFwd15RjLNraN/Oj1cXajV4DEM5juRvBW?=
 =?us-ascii?Q?0M1WnRhCguu6k5KjUbSWQqBg8AL5gv6E2RRgrRHnsfYg4V4eQd2sBK0gqSW3?=
 =?us-ascii?Q?NUx826WyAc/00QaY/5LE+P9NwWyaouCmTEeRiI3UIMMHEIvGTVxgIBmN+0ym?=
 =?us-ascii?Q?yU/pZ2mI8PcePA4Q9JC1AKOqBbM8VkDnYyD9hssUN0lpcuK+GpgTUZ+MDuNe?=
 =?us-ascii?Q?63Hcg5J6SbFQapJcJW9ZEyryq5Bqf3YBrvlwJTYk4Axxkyp5fATNoyHqc2H4?=
 =?us-ascii?Q?Ly1vI5q2Jl97ZZxN5umGqE6LAtzbkKZjfAKzB5Dal2UL8IYYcAoBfZ66WzW+?=
 =?us-ascii?Q?aHohBQNUyA3jjkSe/eQLt7VnfEsJlfZlUapD5CJMMZr9Xwd8b0f4eYZchfMQ?=
 =?us-ascii?Q?e1GFTIIhA1ONzVadDUz3R+QLNBkjsXy1iehgRrx/GnYkqaPVopCqlscxtXpz?=
 =?us-ascii?Q?U0lX+L3sbkk78PNrvmTGJg3jxo0/xvlO4nWgA6/SfoHMOi0MECAzFIpGNGB7?=
 =?us-ascii?Q?XqT5oVJRxeNHWELC8fTBY+5PsjtzFq00z7ijlwdmQK+5ddC9Vt3hh+Sa50/o?=
 =?us-ascii?Q?FFcC7yD/5m+O+SQpCoCv7wLnc3gOVmA1uCagQFzCMCwNp+g2JwWrO/SmbhBY?=
 =?us-ascii?Q?lBfoWqbz2pwW+mrxbaixqguEIrkL1KCwo6fAnpn4FPgEtpbzB06kJ2hllbFv?=
 =?us-ascii?Q?pObIoH98IXvrRQpShYObJfoddGejqNp8Qb+TS03wk7XLWpU5/MPTu/JRGDGk?=
 =?us-ascii?Q?5tre6vDuANrTNCeuGQwkUpR5crmuSANvGBSV03aEfKxALDrUHr7iFhtYW0I7?=
 =?us-ascii?Q?Ql53b5iONwgAfNDwt9KzGPzSpaztSwxQI0lGy6XpBhxD6cdWCP1lIGsyPtHB?=
 =?us-ascii?Q?4hfuky6RmI2ImArjYBdSVDKBvPOzDT4KiavAwG/vlpzlNZqPZjEdjf2pYCje?=
 =?us-ascii?Q?h/YsTtK5+QPJsfoMZjWXDSamzJXATC1LiHOFuKOg/Qpqh669bSxmDbVfikZi?=
 =?us-ascii?Q?uyqadgXhvQBNqjZV6gNuQXsRApI2ZkmSO9+MjixDVrwsL5YedMMqGMZMQnmq?=
 =?us-ascii?Q?7Nktsym4FQIug9/lbq1w0ZI/geZ5XTyHSLVlR1fWWy7JIAk3BH7DoT25PpP/?=
 =?us-ascii?Q?yipV4fwO+3K4hOJ2pRK7QBAPdrMElR+riK0caaCqBNSAmSd3anb1otfKrjI3?=
 =?us-ascii?Q?x9LjEUtpm205r1X1f6DwEYa0oGDLjzHnhuW3ip5NuURyPnJPlGeUnbDEQvob?=
 =?us-ascii?Q?ckjkn31rX8ESTCaA7RfirB54DO03fpsbfbrnyj6vijM4BQC3JABl/BV7TQHs?=
 =?us-ascii?Q?imVTHUxyzJBxPg6kkL0mpBQQHNWahtD9NCeVRVn4TZCpoDjj/ojmraeeh25C?=
 =?us-ascii?Q?PShc3204JlxhJlcDCwEWxC//JQCOzd6I8jRdZjdTsuOsd4Y1TRO6rID23dvE?=
 =?us-ascii?Q?iAWy1gvnqZmEMHUFcBU7Kc13az/On9jT/KRCZInXJzmISwJ6JyMtYaVQWOM2?=
 =?us-ascii?Q?Jw=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe732d63-0eef-4a0d-9e24-08dc3483a97a
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR02MB9955.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2024 15:25:26.9594 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 76RgKqZmOus3xIQLEHzRY7TGMuwrEej1G+RG9jYMdpgtfdIRruXYDmCXXiYHhyQ+tem6Y2prLQx1xfIXf576yA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB6794
X-Proofpoint-ORIG-GUID: Sy2HVvOPPjEvOdXxNVITNEOh2WFf3UfN
X-Proofpoint-GUID: Sy2HVvOPPjEvOdXxNVITNEOh2WFf3UfN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-23_01,2024-02-23_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68; envelope-from=het.gala@nutanix.com;
 helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.066,
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

'uri' and 'channels' arguments are mutually exhaustive in nature for
migration QAPIs. All existing  migration qtests solely use 'uri'
argument and lack 'channels' as the entrypoint for migration QAPIs.

This commit addresses this gap by introducing support for 'channels'
as an alternative entrypoint argument. Additionally, validates the
functionality of MigrationChannelList in the context of establishing
migration connection.

Signed-off-by: Het Gala <het.gala@nutanix.com>
---
 tests/qtest/migration-test.c | 34 +++++++++++++++++++++++++++++-----
 1 file changed, 29 insertions(+), 5 deletions(-)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index c1d9ee6466..f044a3018a 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -1766,6 +1766,7 @@ static void test_precopy_common(MigrateCommon *args)
     QTestState *from, *to;
     void *data_hook = NULL;
     g_autofree char *connect_uri = NULL;
+    g_autofree MigrationChannelList *channels = NULL;
 
     if (test_migrate_start(&from, &to, args->listen_uri, &args->start)) {
         return;
@@ -1804,12 +1805,21 @@ static void test_precopy_common(MigrateCommon *args)
         connect_uri = g_strdup(args->connect_uri);
     }
 
+    if (args->connect_channels) {
+        channels = uri_to_channels(connect_uri);
+    }
+
     if (args->result == MIG_TEST_QMP_ERROR) {
-        migrate_qmp_fail(from, connect_uri, NULL, "{}");
+        migrate_qmp_fail(from, connect_uri, channels, "{}");
         goto finish;
     }
 
-    migrate_qmp(from, connect_uri, NULL, "{}");
+    if (args->connect_channels) {
+        migrate_qmp(from, NULL, channels, "{}");
+    } else {
+        migrate_qmp(from, connect_uri, NULL, "{}");
+    }
+
 
     if (args->result != MIG_TEST_SUCCEED) {
         bool allow_active = args->result == MIG_TEST_FAIL;
@@ -2725,7 +2735,7 @@ test_migrate_precopy_tcp_multifd_zstd_start(QTestState *from,
 }
 #endif /* CONFIG_ZSTD */
 
-static void test_multifd_tcp_none(void)
+static void test_multifd_tcp_none_uri(void)
 {
     MigrateCommon args = {
         .listen_uri = "defer",
@@ -2740,6 +2750,17 @@ static void test_multifd_tcp_none(void)
     test_precopy_common(&args);
 }
 
+static void test_multifd_tcp_none_channels(void)
+{
+    MigrateCommon args = {
+        .listen_uri = "defer",
+        .start_hook = test_migrate_precopy_tcp_multifd_start,
+        .live = true,
+        .connect_channels = true,
+    };
+    test_precopy_common(&args);
+}
+
 static void test_multifd_tcp_zlib(void)
 {
     MigrateCommon args = {
@@ -3640,8 +3661,11 @@ int main(int argc, char **argv)
                                test_migrate_dirty_limit);
         }
     }
-    migration_test_add("/migration/multifd/tcp/plain/none",
-                       test_multifd_tcp_none);
+    migration_test_add("/migration/multifd/tcp/plain/none/uri",
+                       test_multifd_tcp_none_uri);
+    migration_test_add("/migration/multifd/tcp/plain/none/channels",
+                       test_multifd_tcp_none_channels);
+
     migration_test_add("/migration/multifd/tcp/plain/cancel",
                        test_multifd_tcp_cancel);
     migration_test_add("/migration/multifd/tcp/plain/zlib",
-- 
2.22.3


