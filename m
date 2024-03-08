Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78878C5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 21:01:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rihKO-00042F-9W; Fri, 08 Mar 2024 16:00:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rihKM-000421-Iz
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 16:00:26 -0500
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rihKK-0001Oc-UZ
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 16:00:26 -0500
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 42899ZcU022082; Fri, 8 Mar 2024 13:00:23 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :content-transfer-encoding:content-type:mime-version; s=
 proofpoint20171006; bh=iEA7wFmPt2seJZDwvGZ+5mWSB9WAGWmT63WLXMmsT
 B8=; b=FoiRKLIBHdLj0I5OKqFe9IvOn4/TW6hOfblawbKRv6GGza7jwynsjdQ+2
 wjzktIBXHpgU81hGBcho7TWb4RBhyaXPOTjHlg8cH6XT03L9tuF/3YtTvPzS+xnJ
 l1W/uSVwCefOGfLNcUKR3VG12tIIFTd9K0H1HbZK990bvqrRZbJCgmSXJ05ee2Sp
 OOYOhYIbsRiZycmdTsqM0Nx1E88XenH3QhNT1gtquhf1yQ+TNf0DUF+Btt0n5ZbD
 yPjOYp8rXScurOCqDBdLsEnYELabjrclY0ECw+uHrmxotTFqqynYrlgbnDVnl9FT
 k7D3/lQGlwKeKt4PWV25BKuS/7/dw==
Received: from bl2pr02cu003.outbound.protection.outlook.com
 (mail-eastusazlp17012019.outbound.protection.outlook.com [40.93.11.19])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3wm4h2ex6a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 Mar 2024 13:00:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=icwZS7zgpS0PQp5in6t4y3/5NtsHDR1Ysw1xVuGcwie/Mp8FtqoCu9Zv2rBJdamzQOFXQ4E7iX1iXmzOzliW6fv1m2XtpX0gtIBRtH2pOOGH/mFZhxIF75nMZ2nktqw6y6h6hndXeiBKqQ2c3Eqat8ts6emadIHmSbhp6CVxC9/ADMHlzIWiCdc8b+9yhAGrDyh3D3nJ7vlvdSVCDhfQ1vVI7+08yvrMOitUrUGG6o6A4GyNZTVdzNgMj8YJGarG1b95hDy1tuozUAn4jC/GzOt4LmeHKBXos0fcMLDjzCK+7UxRFy/ry7WGyPZzhU+tWIQPbNGRI/eAewcjZJElrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iEA7wFmPt2seJZDwvGZ+5mWSB9WAGWmT63WLXMmsTB8=;
 b=SIxLq1X0Xe414/pwk1XPZ+/eePmllBTvYH0KZK0a3UaPPMA/d6vX1EgzyXvizKnz6fSU9J2RWRZrSbMDfZC1GylZSy9WVMxBl9+V5dKqmIzeUEX2SVwk8uhkPaOczyonYteAFJrWoySrnkxgo2fqYwuiL1jWdT1Evhnor6z2Cf3jd/hBBedTOt8Go3GjmvQ3o/lVoPhFI2RJmB6KDLdHZNjz088zvA5By/zQ2nuMWfrCpZF7SoXGCBIeY/bXZdbsWyH98hVte8WjPxMRCYXiG7O5H2/nDSfa28Q55okQ97tsgoyNttFGXKDAFnUgTbZk4lqZ/4doD3xQa7M6KybH6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iEA7wFmPt2seJZDwvGZ+5mWSB9WAGWmT63WLXMmsTB8=;
 b=XQQkc4ARHaNVqDeIlLT+Kyfhnm8yf/87pb6/Io22IFpaopBPIuzLl2kRNBcwWxVLG6IeKhqOsNk0v7GmKwZ4af5kB5ftwUynw0F41BqT5HfBHT+nKkWMnQXg5ikq3j/mE6V8OrwRA7e5kHiFUEXJ/kAqkSyRS2J8inNH1in8mjv2NpFA57eyDt4EC63cg2Rh5IA77s6gWeY27wyGh3Fvkjpo6uIz/CMsvQ6OJ3lefJkEijn2rYxbl0OI2IybyoYecvpsmcTIYRqaEkCmWO30wAXDpUElJxLmbYtG3BAeTwDe23IWWrENafODOnmqnlLceAmYCiqkDrKUEmyJlAgdyw==
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com (2603:10b6:a03:55f::16)
 by BY5PR02MB6786.namprd02.prod.outlook.com (2603:10b6:a03:210::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.27; Fri, 8 Mar
 2024 21:00:21 +0000
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0]) by SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0%7]) with mapi id 15.20.7362.019; Fri, 8 Mar 2024
 21:00:21 +0000
From: Het Gala <het.gala@nutanix.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, thuth@redhat.com, lvivier@redhat.com,
 pbonzini@redhat.com, Het Gala <het.gala@nutanix.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: [PATCH v4 7/8] Add multifd_tcp_plain test using list of channels
 instead of uri
Date: Fri,  8 Mar 2024 20:59:50 +0000
Message-Id: <20240308205951.111747-8-het.gala@nutanix.com>
X-Mailer: git-send-email 2.22.3
In-Reply-To: <20240308205951.111747-1-het.gala@nutanix.com>
References: <20240308205951.111747-1-het.gala@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH7PR17CA0011.namprd17.prod.outlook.com
 (2603:10b6:510:324::20) To SJ2PR02MB9955.namprd02.prod.outlook.com
 (2603:10b6:a03:55f::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR02MB9955:EE_|BY5PR02MB6786:EE_
X-MS-Office365-Filtering-Correlation-Id: 70e19de3-39f9-4020-2010-08dc3fb2c4ab
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WBKN+VqYRTkOYT87ljbzjDEkd07jWBP+xR5ZSpp2ytab5K4C0goqYkkUWlYU64NjlEOmcoR9ywvE/ww2XjBk1cfFNfHedjUdrY+gc1bQ4zKdsRQk3nLpZhC/A2eG8sdtdVynJ9CSLGymv7zG6zJmXyl/yWpFVi8GKfI3WaLt4T5KUO0ejR2bd0/akhe5qwz2LIT6HbL9N4+5MP9nDSoYdhdyu7rqqhRt+q7NuQsH+KV6lWKIy9XrK4AUQp3rafuZQUwlbfZMmFCYfOd9QYUlnhr03O1jxJ81e/7utZ6yaDsQMonNTsAUPQ3p9VdHuHiW+FqnY7p8Jtqvw9QqlRc4P9VzU7gTpT3t82AOjdjtMBzXkpZz5pIf/B4zPzvgVjXQ3kwPcj6dMxbujFS2sUdp5ALLBISxpPKaFfpcIc1/9Q8yjuqUE+m3kkMa1nGo9flgCQoTfXQewQ9cYJFdZICCS0UFkt2Vh7EuKpiWHLSAkbeDF4o3W/rGPRh8qJGVbDIux75GB89Vf/ix4IP+jVKtLm9sozw59ft0KQXrWAosAc35BMObNNhGN+buwKbr/wij3W11A2QNy5eGbsALywGLYgITp7+d7rKZjEB/7B+6uht2tgNX89tWvKcuwIHMGa8rwckr9oFp02MoCKpSPOBNakzzhh17nLiCtAjBeakv02UcyskuBL1/isve5woebfrhUdHjUOQ6tD3ex+asZpZr4V+yGkHMIoZERIAAMSGUiic=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR02MB9955.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(52116005)(1800799015)(38350700005); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wM9+K5gmJ4EMKZSoQ8hbvOhSzcz9axL2kpI8I57mH4QHzrvD4ovG1bNjeyU5?=
 =?us-ascii?Q?rcteUo3VwoSXH0JaMt0yrsUedPLE2tu7HAUAgYWeE67m0fxi4ifUb8wRTfel?=
 =?us-ascii?Q?WW2hd0SevQwl6A5gKyMTyzmxlBp2MKbANAkhlQVXmPhqTJ18ybIXkI6SKKPi?=
 =?us-ascii?Q?f/msqkWTYO426L6MY71JaJcmAcdAGbo0lZBAHCT8RHzzbsSHr4OftEAmQx5E?=
 =?us-ascii?Q?pxI9ewZySRpmyiuuAKvxjrzLpqLxhKllVKPdAXQQB+P2kKkJe7ZR6rp/Bh7z?=
 =?us-ascii?Q?yDSZZhIWK6pKrGjZsRHIeDFLHHgoQ7wtpyG8spYoGMGuQIEiHd0lkKgFGVwa?=
 =?us-ascii?Q?99bYYTl1UYs1M7xksd5HcqVPQXtNaFedOomDCJDWdtW6S03tM+2IYBiP8y5R?=
 =?us-ascii?Q?QCB+pIcO9yDV92caPEoO+7xxcdHg2+3yyUGgkafTZ553e+aov12FXHrO5PCA?=
 =?us-ascii?Q?X7RZc3nNG9CXDS9LEopsge/7mRlEWxRa2xzMw1VtYiWByLSiIDh+PC5wZYvm?=
 =?us-ascii?Q?HQq1eEuQ1D7+xftVb5i2cqeLgGgGOP/7SJTzo7ZuU3lJkvXfRkhHChVbFKj9?=
 =?us-ascii?Q?34mfh1pcD39iH/hgiw5KlSMN46QeUB23tFoY5kwlWF+GcXaF00QC1WLo7v7F?=
 =?us-ascii?Q?1dCZNKYLmSNx+oahsl9qUDUdh7sV7DWCIZ8hcBJG0vt8rUToTa367M72GmNH?=
 =?us-ascii?Q?K0p2tcvSY7uwfNi93p79+cXDpYKSnTZXNeSewJOqnUZwL4UkFLHCDQ4T8vVF?=
 =?us-ascii?Q?YFhYZTAAj0iLN7rJGSuDm/8RmSxyBBt80kMe4USMTB2T4rmAuNHaaVNHLiIk?=
 =?us-ascii?Q?CJRJ9n41y3kGg4IMeS+FyE+Z79GYnK1IbaaY5CEjzqtocU6L2F7NMgf2up8J?=
 =?us-ascii?Q?mPB8GuFga3hLegEuU3KXtvSAfj7xgtWnZNIA2WiJFGm0iCUtLWU8vMaN7Dpb?=
 =?us-ascii?Q?4z1871sydPbK0xwgX0uD+OjLEK8a3eQHEtdOI1dGtF6V5KUS7LnTZ/9NFc3U?=
 =?us-ascii?Q?yQ//y2fDgWG7CaiwrWCWXOAw3/UQx4oWf+i8whyVsCYwkdjTNCljlpiXh1Eo?=
 =?us-ascii?Q?n3CexsaPV5ORFOVG9dVxLQIv0mbTNjcZnqESuqMVvKHGp8pkW9xWIC7PLHvd?=
 =?us-ascii?Q?9U7JZO5KTsHCOZMFlGgW6VSCRe2LnLoWi1gBawhNGJmsJGxXa1WlU7FapK01?=
 =?us-ascii?Q?qGAOmqSWrarOk6CpsIow+5CvMPJ3LtgecSptp2DUjMaJapi4hjGMlXkQZLzU?=
 =?us-ascii?Q?l7Vh3YHS1CWtF9HuLATPM23ElKwIZsaWNY5wcEG2ZC19l5sbfvPYvXf9A+0h?=
 =?us-ascii?Q?F7eBvkQ5bh49z9i8qDAoD200Hv7Y73Op9ZT9eAc9/oUE3S9Ad4gV52ge3aBU?=
 =?us-ascii?Q?OgycwjRAd7pJ2c/75FDb4OEq8qTyP8bpGDdU+xI3dYwWtc26yB2N3FIXppcV?=
 =?us-ascii?Q?HYzds/VnWjmuGsu70w/bOC6kt/mhnZSOhLl28QdusIBZHbTv4SM4Wkb3s5Ng?=
 =?us-ascii?Q?d1VmBLb4+VIKEcqlJ9wAIy/xlbqaqHIC4JxYMLyqyv19rCwdAO9Q6cTHDsm+?=
 =?us-ascii?Q?EG0yFoZQ1thBySYeObK82E5qvonUImebK+GS4aIoPDfWMJZcZ0JVKtAwNl9j?=
 =?us-ascii?Q?7Q=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70e19de3-39f9-4020-2010-08dc3fb2c4ab
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR02MB9955.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2024 21:00:21.7312 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +wSESkHI+pmAaKGqvAhjcvcHK9D82efB1YbO5z8kTIeEQQa6uMhj+LPXA3cm4c1bq6ziW81Jr7XqgD3xn6XotA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6786
X-Proofpoint-ORIG-GUID: pNcMYpy0ZOrv8VhqdzYPl6bfWP2GjkNY
X-Proofpoint-GUID: pNcMYpy0ZOrv8VhqdzYPl6bfWP2GjkNY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-08_08,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12; envelope-from=het.gala@nutanix.com;
 helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.572,
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
 tests/qtest/migration-test.c | 30 +++++++++++++++++++++++++++---
 1 file changed, 27 insertions(+), 3 deletions(-)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index b1e5660dbf..6ba3cfd1e4 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -659,6 +659,13 @@ typedef struct {
      */
     const char *connect_uri;
 
+    /*
+     * Optional: JSON-formatted list of src QEMU URIs. If a port is
+     * defined as '0' in any QDict key a value of '0' will be
+     * automatically converted to the correct destination port.
+     */
+    const char *connect_channels;
+
     /* Optional: callback to run at start to set migration parameters */
     TestMigrateStartHook start_hook;
     /* Optional: callback to run at finish to cleanup */
@@ -2744,7 +2751,7 @@ test_migrate_precopy_tcp_multifd_zstd_start(QTestState *from,
 }
 #endif /* CONFIG_ZSTD */
 
-static void test_multifd_tcp_none(void)
+static void test_multifd_tcp_uri_none(void)
 {
     MigrateCommon args = {
         .listen_uri = "defer",
@@ -2759,6 +2766,21 @@ static void test_multifd_tcp_none(void)
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
@@ -3668,8 +3690,10 @@ int main(int argc, char **argv)
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


