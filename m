Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32AA5C54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 21:56:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjnbf-0002yS-5c; Mon, 11 Mar 2024 17:54:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rjnbQ-0002ti-A8
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 17:54:36 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rjnbM-0003Bf-Et
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 17:54:36 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 42BD9aGm009722; Mon, 11 Mar 2024 14:54:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :content-transfer-encoding:content-type:mime-version; s=
 proofpoint20171006; bh=UcXjmmQKyF9Gv4JJ8NiRj8iz+yLNYuK0TF5QsuoPQ
 6w=; b=QqzTPN/Pb+RQXuvu/xF7wictbHFbVVDqkRqYXrkPacFcH3alednE6eodi
 84DU8JibghWSmyB0n5Rrt6maQTN1YLOAI61PeE3f34RN6l8YOG1owhBAWLoXV3L9
 ZAP4Jze26trX+6RA2RXmFPrQCh4mtcxvNoWNwTgs9t7QmhU04WmoWYcR+a7nG+Be
 nx7YyGewJEVkWCs5ji+5SmJ7rLh36GcPMhJnN8hGRwigRyKJBZd7EtAwbz8Fnq2Y
 t3IdmG0ma9d0MWna8tIHRsI+w4TkPQeulcYvOSFeQQixIaOC5yzr4pO5yaB6jSHj
 E1xEN3dCENhwLu/t1Dl+a7awKDc9g==
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3wrqygmc7y-5
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 11 Mar 2024 14:54:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N9y9M4H2+oyHtyRAfZd/YtunWY5jrnksPYX89p+//8SHqt0TssSJ2DPHpW+ch5J+tG+byUdn3vpMoxOoB7wG0Z+5qejB0QQrmHC+6gdWNNj4Tr+o/0fP62M9QE++tkrAD/lktbl/l8be2DnabbNQj8yx+Aq37nfu24nHf/51IDs/YB3eIMuI8Mit6GOEzsuu7r/oc/IOIP/gOdpkiCbErVWLYZn8m/i5S8mmbBTUAcdBrdnvsvJ0x4vS4ySuTeP03mfvclDxzx31kPlmyHsw+CnBq5b4oEVYimP26Cb2jW44HrVN7MDMzCekKcn1AbrvmsvY95CHyXWKKJ3Ul6CFpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UcXjmmQKyF9Gv4JJ8NiRj8iz+yLNYuK0TF5QsuoPQ6w=;
 b=YO/1dfKV3Ut2ti1ns7uU1aawbfPUEbLICrzWQLKRG3f/B/lC73LJMgrfDAVzjBf7B9qchLwjsW7hHUCefLiIi6JsmlrOE5eNj94lJpt1+AQ+32EdrBfU8ZzjMJz3dCDpRtytxcGhtw3bZBgyyGa3mTSF8CS8Awd1T04K/VYsErUPYu20r5tclqsW2sEXsadwf4kjOZJcSS5MYveP/8+0QgBcL0maQlwjc6KI8kajhoEb8o8gTxDVDiMLyY6v+8lZxRBu0C0c1rd0TDq8m/RS8qsREe4PbSqHkZtjDf4lG/oRM8hM+Ww9Ew+L4Fb1zqye4mpbnyGAZXYry/KptEtA+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UcXjmmQKyF9Gv4JJ8NiRj8iz+yLNYuK0TF5QsuoPQ6w=;
 b=T8soDD06GfrqM/z240iBJFSpWCidjvMPN25WSXkPf5n9j3dA+CXnLVj8fyonxmOVV4haUseXkd98QiZt2I7L8krCVG18YnmRcc9Gt6MluKbZzgE5yEsBkgHL0H9VMPi/ihg9mvxLBioWqXNaFGCOx+VcBUM7V/DTAO0UepqT/XEhyClHaqhf2nTBtb6bR5kAFNxxR4wvZQAh/Bql2mPrjY57negywbOFE/LohfnBEjAcnuCEIs20ZEJ/dPbjHuHdioYX4GbKIpgKvL6rSaAla6EM2bC13RJ2LRsUfopn+zy1qqPUF/MKiw7zfhzoOJwjq82zBBbOxwlwMxyMCTzhfA==
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
Subject: [PATCH v5 7/8] Add multifd_tcp_plain test using list of channels
 instead of uri
Date: Mon, 11 Mar 2024 21:53:57 +0000
Message-Id: <20240311215358.27476-8-het.gala@nutanix.com>
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
X-MS-Office365-Filtering-Correlation-Id: f8828664-db69-429f-7178-08dc4215ce7a
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dP7sR3JRPtlpBEDdocINxG+c9+WzjCbpu3KS4JyWbFNukdCygfblivFgzV4dp9EchlYre40bvvaNKES0hEz39UuLROClgnXJC4Z062iHdsYreSROqqGaIRSm0qCBwsTUaE8G0tNnMqEL5CvF859F9gtM9+XYznLKKw9Y/uQF2taJS9vdggavm1rkzOMEF9eVOxLwHeX/PLtxn5rkZ7iwWsn9iKR54i3zSEW5985Eg+r3pe77pyBN+1vfYxF2XFgnPSEx9sasOutpoyHTbXGoIAtlRw0bmKG8B5p3p1NmBSr0bOdEXrdA6fId97WcllJISbsqJd6g33nn0j13br2xjzpO+VfL1hzqHBdDIUQbDcV0rFks7frvpeVkrPTXsBOo21WkQROszgqrPsZWStxf860YqYnBOtsHcUW4X9UROkyqDEUPdcmY8it1tO6AjP8Qq7LMumYh3hupPubnf7svBj8h1WyAYMerRbvW92QythY2ULLzCmt+i3X0FclOUl7wfo40hHAiv0MZ1nf/5G9T81q3TgDl9gN/UvEMzXcud6/SVHAmthmC8zSQWZTw4ZIlpdlqUC4FmK06UAQY1xB9X8ZCrnQWGRUpJDUjaKDhZFWCEM91rTJK1urVjvoxiQhpvmULDzMCWP5nzaLbHPvFTzOmjHslx5uv2RKRwR/KSbzELLT3ZSikH/7Nox94AHCrPJ/ruhhr4aG3+oYIOrf3ZeUtczDTVNk89dEwff+V9bA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR02MB9955.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(52116005)(1800799015)(376005)(38350700005); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QHekCeGzCOhh8spk87E2NWo2idjt+o0pUrcBRfVtS9XfnGJVK9tpSxbBKst0?=
 =?us-ascii?Q?ZBbmq99y1EQcrXd5Hta2Udo1ntOOa/E2cdT1CSo6ULccZfEQemJOTmNZqXKq?=
 =?us-ascii?Q?5pnSHSCVE2Bdj7bVa8QB+9Q4iCOOaKfaLAddPHQD2h4yygXl90Cg/D8/FqJ3?=
 =?us-ascii?Q?IfuZU8pagbUvL6j+NtFX3CgK4rzzNGvGDcKquYcv6DsJfefugLEXDEejQ10D?=
 =?us-ascii?Q?+QZJpmMJI5YIX9J5aRkA39UCRYzHPy+CB2Wv2ura6Lf6zRan5yRtbxorCUr5?=
 =?us-ascii?Q?QdcqV4/nraqAqOyYVih0n+RjQNIIbPAEzHlMhnECwsNNBtDSnLINPIwM1o9p?=
 =?us-ascii?Q?5T0bt6H6f8bHJ1fu8O1bEvEUaoDQ7DCpxnrIeNISCD0VweZPytQRbm0unOXD?=
 =?us-ascii?Q?UKekkaoE/QAaudUxvHJJalzdMeYM/Wj2JFg6+K5GJjLg9VFqbP7Lp6g1eTXq?=
 =?us-ascii?Q?qzX/8/NaIrr43HR30N0v/ogeyYthw6AW6celwvSw6nr2zvRrV94ZKq5kLsIf?=
 =?us-ascii?Q?7nIthu03MwMBIEE+WP5uOxgSqVsVfUgDeLjOa11YQwdjxsuhRMAtDawI1/ha?=
 =?us-ascii?Q?1JTvBbIMHHlvagEhpPX4++ciGHJlJ6u7hyOesabj6PvxsD+4SypAlx7YopO5?=
 =?us-ascii?Q?E/OKsHBifSr3t0eABxW8hWsaBv/e+U4XOVQ1cX/QPWULnCmr3CCJY/VAH//D?=
 =?us-ascii?Q?bdYD+q3iac090O4j3uLEA6CHITNFsGMtS2oorg9MMsUgkBOyb4vxFPEK0/tK?=
 =?us-ascii?Q?kunGIwP7FtMLbKr3D4M28cwf4em8SlusEaZuXe3/o04dQumuRFvcMwpzvqKk?=
 =?us-ascii?Q?PO3zG+YU0KFZVWTrErSbvrrhTSFBcV+y2Fv8aO0AxbbMDbIIM0fonp9kuEow?=
 =?us-ascii?Q?on+DBcwOO7sHsrVoRkybag/xYBjmDODjGO3lYwzfwFtvdSewLXhkgB9w63+p?=
 =?us-ascii?Q?BJkb6LZDtkKTrbVSj1FLM8styvhdDD0fdMHZAwwNZnwgAT2NiqPkFfOypjWh?=
 =?us-ascii?Q?wyE3SGktjwqLbLat7ANfnMO48QChMGf5Q6b9dfl0vVeM74HVBpEqin2OwWs2?=
 =?us-ascii?Q?3UMn8jRrOt/noQX1DsdVjxzcpXbOLKAOQ8YY3AV7IZl9lnWEXAOPezbe1UWR?=
 =?us-ascii?Q?sKii5Cz7H4OenQNfOPrz9cr4b14xBwcveJ7MrITbVcKk0c9OsbsT6ywqFfiG?=
 =?us-ascii?Q?VHtJDjfHIbPIVTPwp85kYmNioucqXwu7E5vbtoCRdjMmptEpv0ZxZd4090T+?=
 =?us-ascii?Q?QaM5c7AtlkeHXJGmzxBihYPFw37SuZwdHaIGwerxWl0efA6JbbOUgkkQw+AT?=
 =?us-ascii?Q?kfpPrIxZmc5Hw5ltMB37Qp4Dt++qYGd+23jCtvpyKIR82z7DfVmMgg1uIuH7?=
 =?us-ascii?Q?g3uItacnKokyTosiieetdKvQQBEkIO4lEIfc7iZNsvtdcjgfEFkUidNPR+Kg?=
 =?us-ascii?Q?qj8ZvZf+PgLS8HZVpk5eDNG7c9TrbDrSKyG0wjFIH5D0U9jg5n+vUnSDtIr7?=
 =?us-ascii?Q?nT0pZCPkK2WS5Z+ovew2tcJ+Nw2SMc2NVlWxwNtLnr9AoFUwTqEtmcrf4Ssy?=
 =?us-ascii?Q?VPPQ89wpbqWFY4Ch08JqT1WeC6dAxWfGWeBtb1dhuZ9FW3Y9NOtr4WpCoffp?=
 =?us-ascii?Q?KQ=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8828664-db69-429f-7178-08dc4215ce7a
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR02MB9955.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 21:54:20.6563 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6bBfjCBNG+fqe9nVh4ROhsngtZW+ysXDdXTh3XWrpDxExvOUAyOQTiKDq1Plc2pEkS7h+BpfbBAqimRNAv2xUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6849
X-Proofpoint-ORIG-GUID: V7D6CH4jVlTXS9F0OSjxcFD3xaRc_g1S
X-Proofpoint-GUID: V7D6CH4jVlTXS9F0OSjxcFD3xaRc_g1S
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

Add a positive test to check multifd live migration but this time
using list of channels (restricted to 1) as the starting point
instead of simple uri string.

Signed-off-by: Het Gala <het.gala@nutanix.com>
Suggested-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/migration-test.c | 30 +++++++++++++++++++++++++++---
 1 file changed, 27 insertions(+), 3 deletions(-)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index bf27766eb0..392d5d0b62 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -655,6 +655,13 @@ typedef struct {
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
@@ -2740,7 +2747,7 @@ test_migrate_precopy_tcp_multifd_zstd_start(QTestState *from,
 }
 #endif /* CONFIG_ZSTD */
 
-static void test_multifd_tcp_none(void)
+static void test_multifd_tcp_uri_none(void)
 {
     MigrateCommon args = {
         .listen_uri = "defer",
@@ -2755,6 +2762,21 @@ static void test_multifd_tcp_none(void)
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
@@ -3664,8 +3686,10 @@ int main(int argc, char **argv)
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


