Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB237C54E58
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 10:51:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhorH-0006Xl-46; Wed, 06 Mar 2024 05:50:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rhorG-0006X0-Bv
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 05:50:46 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rhorB-0000Fk-Ns
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 05:50:45 -0500
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 42601jJJ011994; Wed, 6 Mar 2024 02:50:40 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :content-transfer-encoding:content-type:mime-version; s=
 proofpoint20171006; bh=o2ws0Em9vr7PlgVGm38ILlY4cAvCIHtkLoLc6XZQ5
 us=; b=EvMmvUsxg2uT6D5cAQUZbgjnHMu5Op/N08CwLVBf9y/OhAnjhc1ABj6i6
 BKhrR/ALAjTfOzNbBSsYH2nEMFyrUx853JfrzDeMSRKt7PObynalBTfafeWN/YyT
 m9J8c4JKU3iO6jlHNvrE1zyTbpcAkoz6dEqvOgCZwhmpEYT02+VSFoVaVGXadXMm
 YAch2fU1Zx2md9MebQ5HvKlxRidr1BbyXu77vFIn8w3MeSQd79ARaEWUca8HAM2/
 AJolSB6z5bbuU98Fi4GcF+QG2bTU1kcuw+1K486OG8v4nuyx0eoxhvac7sG0+eVh
 4LzNEeMTb3f74rGw03UdrbrHZqK0g==
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3wm1avrpjb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 06 Mar 2024 02:50:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GYGfZN+Y+/YCMG+/bq4hF26leLvdARq8FT5FE7rBIxygviUZ8T1O2otHHJjc4+zY8wWbpD7sTZgbeu4bfyRTuSCONBDDYbit4EDW8A+ZlcLaicDwmQgjLX9oP4fq0RPpecxtjgOTIaj4tNnszGjC7fv0vtxPz0DBL+xW7LJ+HycD7NW7gZTlZOs626FT0kN1uCRqzxfiTR6yZFOOnktWOmAB/4GDmfcDzZOCe4zI8bRBHPoC92zajsBffoxEg1h4hn30lxh65eKqHyV3jJcWYIrsTOwQlk20WWRNPaLR/Ma4eDU2Aw6dCO0VzniM2ULVUlsAKqU7UOlMMIFI/HjBFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o2ws0Em9vr7PlgVGm38ILlY4cAvCIHtkLoLc6XZQ5us=;
 b=F+cJL/EG0BGUHcpncSIaSiOTs08hz6de+o4zAwJ3K/U1mSQ6f6bc5HMxOlPAiNuIaTATSukrRDw52cddFiYD9sp+XBt8lPYPX3zDvBG7gEwLOvrqYPlmHA4WPVfzVEl+wvzsNpO/W8FqF7VZK6lfLGAdMNkx6vxAXaSEElD5AFqKHD3JAzWEPAek9b4dY9yFKNHYsS21GB4W1IWlxqvCq64tlnXv7XtmvFXCbYMaEcO7npX3Ayl6jMasWYFVu/JpGqpGWJU6PuCndV5sf8oS3OHpjv3wd/DeD86pcrJSmSq6up7DOscpG4519LL1xpqDFHAryk0+WDbEfN7BfcWd5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o2ws0Em9vr7PlgVGm38ILlY4cAvCIHtkLoLc6XZQ5us=;
 b=Kr87qYhqZZt/oN4VjbazU9JPq2M/Iu8XOfSLjA1fWVSHunskEqp6PCSsYiVfld2rQiVXtX24hpudoZv9ba4ubOv/9VxGdeqvfrYQvdLCsByssq+et93E6hkNGavk0gi6SJasYtJEc0FQfBg7bAwvckgGBShLCu2yO1j8XBTLjA6p0u/9/dJeTXmEWtgL+BygUNunMguaru4rG3PYULR5KhBY/sZYWNDX09KdRY5xwDrZxdGVlzIqb4ddDha7II7o1fVbJKTJvRJn+fzNLJSZSZFSPHrBQqkP4BU2uM6w/vPE2F+w6AW+gGCWIwC8zlfVFXc/RIV7ht/+c2HgLqSQfg==
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com (2603:10b6:a03:55f::16)
 by DS0PR02MB9617.namprd02.prod.outlook.com (2603:10b6:8:f3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.41; Wed, 6 Mar
 2024 10:50:38 +0000
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0]) by SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0%7]) with mapi id 15.20.7362.019; Wed, 6 Mar 2024
 10:50:38 +0000
From: Het Gala <het.gala@nutanix.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, thuth@redhat.com, lvivier@redhat.com,
 pbonzini@redhat.com, peterx@redhat.com, farosas@suse.de,
 Het Gala <het.gala@nutanix.com>
Subject: [PATCH v3 6/7] Add multifd_tcp_plain test using list of channels
 instead of uri
Date: Wed,  6 Mar 2024 10:49:57 +0000
Message-Id: <20240306104958.39857-7-het.gala@nutanix.com>
X-Mailer: git-send-email 2.22.3
In-Reply-To: <20240306104958.39857-1-het.gala@nutanix.com>
References: <20240306104958.39857-1-het.gala@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR21CA0011.namprd21.prod.outlook.com
 (2603:10b6:a03:114::21) To SJ2PR02MB9955.namprd02.prod.outlook.com
 (2603:10b6:a03:55f::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR02MB9955:EE_|DS0PR02MB9617:EE_
X-MS-Office365-Filtering-Correlation-Id: 78a06782-5b2a-4ad7-f3d1-08dc3dcb426e
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HmdGoAIUDHf+fyRulz1fUaT7sw3yVboEzfyaQrUT+8rnesJr67qj4/qvekAYcXfAWf17ClyRqxQgecb72vCWswtPoWemwaBjj+TF8FGdf7RkjdSHtsNAdeiC4F5y1/D6OQiMKdNT5W4g0YeF8yVGEE7NdQ5uJv6Sry3mU60xPUiwrwXAx/vHBznVxzFz1LNG+qtRtnq4pCYEpUwOTjCC/WmS/HQHsqIHLvj7LX+Ao7bqPrDig0etqwonm6afgM2tFfjGelQtQ/wZ6qKQNCUYDeo5FEQFQm5fBhyIK6S2W0NjUWpt9UGvFVzUYko5A1I8N+doZWihpSQ9qG7F5BnMfQ/gBttZL4h7/NlNX2hVoVGxMhFUQJBvVLD2qGFgBtHrUIyYZW3TiZFcEUefu+wc9gjmN/OvXEFZNn3xJw24FzoyUAjFnH2xt0LJgGA1ZJ8rOBqPPAVjyiB2C4Y5qA+GqxNxG1EfAUtYEhSJ884wn5JREIblr+OPZvNdHYXzOg8J5MDokbnBApknLr2BkEHtORe8iPZ95a2VBCuUeLfha7k+NaVFdFbwPsWr2TM/l/UDIZDEIzyhAX9iTBnz2bBE9znIropK6xdrD1V2kDmgrMA6aUUQMjHSj9GQCWFseTHSKxN7OdTe09U/NQaBQ5WbzydcK54NB4E5MEI0W0QWm/o5MZmnKx5qYTSBQrM9MMOqFsLzMbTzvXwkvmxVrKmA+UN3KRQ5L8usULo4a23MfJo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR02MB9955.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(38350700005); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3hyP8EdkrMvYsz9OZH6qPcOKHiWSb6wKDkHjJvboA3HSCcqgVkJvYXWKhj7u?=
 =?us-ascii?Q?LEG2LpK/Az0mcQ2qKbu3W1mX1TQHq5RhbhtxICnOL6AO+5za9s11A31mKhMu?=
 =?us-ascii?Q?If2HCmJ0OOQaX/ir9mB617T4nWUC1/fbOWxyMZnKQJxlAc65uPquyZbeDLNC?=
 =?us-ascii?Q?GsickxtbzUptwWQw/4+eyPccw0Kbr1I22ofvYf5eWrXpzwKWcpsV/vN8raSL?=
 =?us-ascii?Q?VTEQhm5XHU3PXcO27IdrJTTevJXzSLFPtWoDonP5mT4vs32QGyP1ZouhoAZJ?=
 =?us-ascii?Q?2of/qQ58uXdo139tbr5p5Q6F6axODzr8Lehp+f30PtB70+plOjIYLf6NAXC+?=
 =?us-ascii?Q?fEyRKJcrtpNV139hpkp7U0PSQywyFRow2W3fJkBKspqzyp9Or6jh9gKQIuRk?=
 =?us-ascii?Q?mrsGn7pymC8dSCcmS5s0VlBN+VgWevjUcTpDiD8pxeucOCRwaOr4ycXLz5Yn?=
 =?us-ascii?Q?owGver6yhM6MkTfPAZHAiqrnxP3jztp84MhVNOgBUtI/NHjyCC9jhd81FWV8?=
 =?us-ascii?Q?QtJAHhYAA7VF0doW8eTNwlk8INzPxYNH2fg6HyB2an/fZ5aXEHBWvKGHyCgh?=
 =?us-ascii?Q?0Ln7PkwBYYCnFhpjgw9VwbfPkKixFY7p4yXEf5YpgP915KWs0pRMaTEucqOU?=
 =?us-ascii?Q?kW3wb+j6D0O7hr6CIb+sxFNoi8QxugfCTcGNfCXsa7plWvAMyUX1ydq7ljAR?=
 =?us-ascii?Q?OX3lojCVimPEILMCoYqXRsw/h9WUbbps6X7icao7fc59UdHiAMVjo3ANaow8?=
 =?us-ascii?Q?x4j4UtIrza1qiLdkPceC9ox/WvueUQJm2DvR3kD3Po+V304Tn/l1ffV8uHop?=
 =?us-ascii?Q?0DtDvVKzcuklzpugPHyw2EqRc9U1me1piDAeYYSaw2pp2XnEOIcfZ6NJZ1W2?=
 =?us-ascii?Q?cfE0Ndi7KSLqwQTmdRfVbg+UJU6TZZkQHjPH3NpcI0d8Vy67Y6PW4IWymZaO?=
 =?us-ascii?Q?dAGbbRadtmZl5wYqXh9bM50QgLMWQ6GeO7CSK4iugsyfFZ/qWvMdrBhAFsTr?=
 =?us-ascii?Q?fRL6/SSaXCpcYo8aWOkuLd2lH9CQ/O6NzDCByfpkcUA0M9BXZndgiQGHkTLC?=
 =?us-ascii?Q?pSnqlL/DJT9e35rZc2qSONVQJWbxAtGswoa4kb/0z9BMGVhiOZu+2KJK7Gz3?=
 =?us-ascii?Q?2vifu3f3+fDtyNR0ajvkwcc8UvN+6DtQN+fO5+O6UKEGAnyc9gYrjwvSjRGI?=
 =?us-ascii?Q?AHZwu08NhY74EwwR2SdYe55+VkKkdbxZiax1Tzkpy5TpUwDlioIn5g1pgywi?=
 =?us-ascii?Q?PdUIl/I8ISH3EiPf48Qx1/AJT7eKEJ+HRvbep/RM0MLlO1dxCR48hO1Fv5tR?=
 =?us-ascii?Q?M5Kct2D90z8uRLAmKAiONcohXO5AYo7aRSKQtzaJRC0TnjjGw5I3qoiKQUG7?=
 =?us-ascii?Q?SHcAaHhdeVxkC1ZBmqK0S82mHmXBUXDZwbyLnyjkQoZfn6TdRK3jkGLw1m6N?=
 =?us-ascii?Q?KGoNz6M9/D9CPtKjItbT/BP+j0zsSNXBHOkBb4AbqpIB0WOAEVPfG5oDtV/O?=
 =?us-ascii?Q?s90CC7/RhVaGIC7eCVqNHoBrAKnKvsNRkqs94cr/c7fN0JHAB46rb+5q7QfB?=
 =?us-ascii?Q?dNRoacTVrp8oK0orP+f0ncW5Z3BHUqSG23OKq2Ky?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78a06782-5b2a-4ad7-f3d1-08dc3dcb426e
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR02MB9955.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2024 10:50:38.3098 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WdM9YHq4jrI4O5wJb4EJGM9UE7OJJZKopVLyQM5bK/0rUXojIZAaFT6foo9k8s7ITRG2wFtia2lwsMDfe2VH6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR02MB9617
X-Proofpoint-GUID: RlcIS5cMG0JBZpiiXta_r85SETBAnl9c
X-Proofpoint-ORIG-GUID: RlcIS5cMG0JBZpiiXta_r85SETBAnl9c
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-06_06,2024-03-05_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68; envelope-from=het.gala@nutanix.com;
 helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.568,
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

Add a positive test to check multifd live migration but this time
using list of channels (restricted to 1) as the starting point
instead of simple uri string.

Signed-off-by: Het Gala <het.gala@nutanix.com>
Suggested-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/migration-test.c | 29 ++++++++++++++++++++++++++---
 1 file changed, 26 insertions(+), 3 deletions(-)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index f94fe713b2..05e5f3ebe5 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -659,6 +659,12 @@ typedef struct {
      */
     const char *connect_uri;
 
+    /*
+     * Optional: the JSON formatted list of URIs for the src
+     * QEMU to connect to
+     */
+    const char *connect_channels;
+
     /* Optional: callback to run at start to set migration parameters */
     TestMigrateStartHook start_hook;
     /* Optional: callback to run at finish to cleanup */
@@ -2623,7 +2629,7 @@ test_migrate_precopy_tcp_multifd_zstd_start(QTestState *from,
 }
 #endif /* CONFIG_ZSTD */
 
-static void test_multifd_tcp_none(void)
+static void test_multifd_tcp_uri_none(void)
 {
     MigrateCommon args = {
         .listen_uri = "defer",
@@ -2638,6 +2644,21 @@ static void test_multifd_tcp_none(void)
     test_precopy_common(&args);
 }
 
+static void test_multifd_tcp_channels_none(void)
+{
+    MigrateCommon args = {
+        .listen_uri = "defer",
+        .start_hook = test_migrate_precopy_tcp_multifd_start,
+        .live = true,
+        .connect_channels = "[ { 'channel-type': 'main',"
+                            "    'addr': { 'transport': 'socket',"
+                            "              'type': 'inet',"
+                            "              'host': '127.0.0.1',"
+                            "              'port': '0' } } ]",
+    };
+    test_precopy_common(&args);
+}
+
 static void test_multifd_tcp_zlib(void)
 {
     MigrateCommon args = {
@@ -3531,8 +3552,10 @@ int main(int argc, char **argv)
                                test_migrate_dirty_limit);
         }
     }
-    migration_test_add("/migration/multifd/tcp/plain/none",
-                       test_multifd_tcp_none);
+    migration_test_add("/migration/multifd/tcp/uri/plain/none",
+                       test_multifd_tcp_uri_none);
+    migration_test_add("/migration/multifd/tcp/channels/plain/none",
+                       test_multifd_tcp_channels_none);
     migration_test_add("/migration/multifd/tcp/plain/cancel",
                        test_multifd_tcp_cancel);
     migration_test_add("/migration/multifd/tcp/plain/zlib",
-- 
2.22.3


