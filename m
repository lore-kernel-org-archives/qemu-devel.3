Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2FE3C54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 16:22:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk4rv-0003Kf-Up; Tue, 12 Mar 2024 12:20:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rk4ru-0003KD-Gm
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 12:20:46 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rk4rs-0000jZ-Va
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 12:20:46 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 42CDUwRs012926; Tue, 12 Mar 2024 09:20:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :content-transfer-encoding:content-type:mime-version; s=
 proofpoint20171006; bh=UcXjmmQKyF9Gv4JJ8NiRj8iz+yLNYuK0TF5QsuoPQ
 6w=; b=XhCyfX0xJc6oehh3YGZLFNGb6gimi+0Warh730CC5ZvtyuAX23nFkQZxG
 M1K/PZ9zdDpm3TZct+FUy6AzOeHDWzPmq4lt4AM4yD3Yy95xRlYVDcyk1502PYWk
 2wDyL3h2QAExbblQ7smABFRMvMwHCge0JGTzToSp+cQSybCAc6w20dTsWnNe9Smp
 oIf6vQQahdmh3Bb3wQlZGMpcHX3CFPeN2f7PZOHFTDmoM5ol3/HrBVeYDfl9vnId
 vGFUxwV/F+Rp1K4qUmEbGhlSvQfJCtqT52uyoYlX5jRJKRCtExrkW5VIkjhIci0/
 8mIJbwwBFHYn2lW3G1RO55LMQFZvw==
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3wrr63pa3e-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 12 Mar 2024 09:20:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aIG+CtPenaJC9b9HWTTR1hcE6hRNnFotTeyXA5csLLJTVVp6uyGxfIrRR3kTHwlKFZ7co9K0HsudhRLfWZItMzcMlswzMfXmhYfinIg5fkTuk0SJ8d5+PhMtAiOz2fAwaWS6PWq8sVrEXUamIQfN/utnF4xiV8WtI5Ip4v3Gp4NxiJqNpmgg9dK/toMIj7sbGwp3mBV0d18vDGz4feHNQPnQac/eKrTdd5Kesv+pw+yDl7HYnTUZyTJw6TeezNYSEHZaz2hm30TA1dO4BXYV3rjQ2Jj963HLyOxSSacqwQzLHBprX+o4JjQ394M97C5XTG+yBqZHs5buNcwdQwoNlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UcXjmmQKyF9Gv4JJ8NiRj8iz+yLNYuK0TF5QsuoPQ6w=;
 b=N39vSA58ZKSRMbcvAhuLDNAGW7+fOEi5u3YG0Y6SQQ4b4PM4BgB90m28hlhgYZqvMgtVCX98ilQOMDLuqLykdoI7MaqHuLg5yH7p+nA4ekBbxtkN3kIyqfkEYnGQRDx0Jm/Q0tgUdYxufX+HSxMRHdc+LKAYK3q2PdcootFucUa9MxerTOKkP8fyvSCoIbuQs5yRI+J6fWbZUcE/vRFxt+lY3BgxZqfv0aw2IXWlebEol1g1HQL4FO8upyW64T3LK3I2tK/b1qbyWcr/MFczO0ZnOoVnMvXos0yHZLLLvA03TvSn7HiwEGLhzo/U5lNu7JkW7oLDZzet0Kp5mWp1qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UcXjmmQKyF9Gv4JJ8NiRj8iz+yLNYuK0TF5QsuoPQ6w=;
 b=Qsy7UHPorXjjfELfvvG088fHvbgXj2SeKgAtqIMPaA6szypCPmj5bT/MRWaYy1kjo27bEaTFZJvuJGL5dlVhSOLDRRrNaf/8uaXNxkbjyJi0ehnrCG4glOE6cQaB2mIfcMOK+QBPr3VEZKdpHk42Imqe9oueLUDpMUuAu/Ei+GAvwiUxsNjf3vEqvCRYPuiilCAIlvhdYPQVwv4RseFPMU8lSPAgl2cT4007F2qYHmIMUhDt0+iw3kag7KW/ttPiGS1GDwZM9d6g6MjorXt3vF9OUkS/fMR3crCmytU0yhP7WOt5JO6zgm+pyprf0p346hFqnMVHn4WwHhoMcViYJg==
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com (2603:10b6:a03:55f::16)
 by CO6PR02MB7570.namprd02.prod.outlook.com (2603:10b6:303:a7::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Tue, 12 Mar
 2024 16:20:42 +0000
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0]) by SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0%7]) with mapi id 15.20.7362.035; Tue, 12 Mar 2024
 16:20:42 +0000
From: Het Gala <het.gala@nutanix.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, thuth@redhat.com, lvivier@redhat.com,
 pbonzini@redhat.com, peterx@redhat.com, farosas@suse.de,
 Het Gala <het.gala@nutanix.com>
Subject: [PATCH v6 7/8] Add multifd_tcp_plain test using list of channels
 instead of uri
Date: Tue, 12 Mar 2024 16:20:24 +0000
Message-Id: <20240312162025.44212-8-het.gala@nutanix.com>
X-Mailer: git-send-email 2.22.3
In-Reply-To: <20240312162025.44212-1-het.gala@nutanix.com>
References: <20240312162025.44212-1-het.gala@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH7PR10CA0011.namprd10.prod.outlook.com
 (2603:10b6:510:23d::12) To SJ2PR02MB9955.namprd02.prod.outlook.com
 (2603:10b6:a03:55f::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR02MB9955:EE_|CO6PR02MB7570:EE_
X-MS-Office365-Filtering-Correlation-Id: f990b275-2fcc-47f0-6c35-08dc42b05ce6
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: amn30WcNBx4EL7qs7nDq/C6hiVVE7UBhK+ifayp1+FudPkxmZn4i8unpxgbcM6oXZuFzy/jb63n8Z0+XsfGqoOsPM29I/B4jt0LH8iXQ/ER3jKHbv05LssCL+KHOV7lQH9NNpxRR0k5UPv/dHNcC/AdfQj9f3islIoKpqUvJnzImtCKm3FraGndcDOh6hp4M87XEsP1gyOi9SpYOY5W3sdJxjzPjgJ3UYermntJe561RT9MnpJH9XVi7fsC9LiZh4A/06WaHG8f/k8W3eTF7aZ0iBudktaqq84qJG5OaZSe7PMCc3j6PSQ/Aijndsw/izKJMrZrBCTBFH3qnTuBNhsrqx8VIDapZLFKNHkwa84L2aiFGhMx9CBa6k3Y30HzXDyNNK/eRTAHacixpQUamHigq5APAM2Qsp21Yc7gYHuxldEcecbe+7/68fK8tfdoE/Z58UYiQA0uvNc4gSJnk0Sj6cMvyCYCu/58GMA5FJAi58U2mhVXC91mKlYx90BDhnBzb+Wq9hU8/7u3pEy6LrS3WDNow3iCJmDTGBT/egUJ+CGaJNsjGTNfZ0e/d4uqGjQIQXy39vmAHeXRhXK4MvzuqtbePqrKfgp/zCuIUBJXwEKANLGzDzZCwsFZ6EThoAp1FIWcOeWl1bMbkMZrDfdXdVU1jLBKRY6tnqlkItfDhNnwVogPuoyPJ3Jx9/u9q2Vo7Sh7FBtKif1we5UZGfH8VEYJDWAxdwzoI2dWIjVY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR02MB9955.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(52116005)(376005)(38350700005); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?i8knzySP5V7PeVuEZ1GyQdIDu+C0Bq9JCWfAtVP1O7jIl7O/tfAIDgz7fech?=
 =?us-ascii?Q?UmhQQHkzehXlP/EcXa9FYr579wQPI9R5i+8vW5BzyfMNPDOLiNdQLgrH3W+2?=
 =?us-ascii?Q?mAWsGwDMH7B90tX7fPJTGEjD6gzMsgk5qQwLZoo+jJg/hlhBulxyqE1xUlYP?=
 =?us-ascii?Q?opIspICYPMMcrYWptf0AWm11qKBYI48bc8B2WI/rsCKwcoC0NPft4vHsrhHo?=
 =?us-ascii?Q?O0eFv2SziSjE0yBrm61ldsMac7Txe2qj3hq++Fj6AhDvwdsK70wNwWPW+Yl7?=
 =?us-ascii?Q?8atgpc/NUb/uIqUV5EcSS5I96fY3Ee1J9ibvwIxgynEBmuujSVSqrSz0cayV?=
 =?us-ascii?Q?tsgnUx1ieyGOTx9YfPkzny/lPeG3QDBvJKxtWzxmB7y9jWwvdZuPknAwUpX5?=
 =?us-ascii?Q?vTXdF56mFN9DYrIhh4l9veErN554deCrHi3nME3gMyM+lqq/S7NqifvFRZ5U?=
 =?us-ascii?Q?TueD7hnjQ5gdER2IYpUy96v+tBzWA2Ul4Ta76Y2/j88St7+XlD6jUJFJcllA?=
 =?us-ascii?Q?ZPgDo+O3LqhUfO3IoXQ6c3k0nQ0sWAN6SFuKKV2vu89TpQz2DKYaGn+zQ2oR?=
 =?us-ascii?Q?Bspg+ZXPL5IdrhSVFa2klnDgT3OdxIupCZezLupIFFgIGO9PpVghzFP7igtj?=
 =?us-ascii?Q?rbRN/otROuEd1CvArJIfhfz8QkBPLhXTnNTdw17V1+FNq7zrXX/WeCpv8Wu9?=
 =?us-ascii?Q?/U+Bq6DDTnfI19neEL4RmbMdRSRqi6PmstVpKHk2FosYMcGg8w3zWkYNKO7V?=
 =?us-ascii?Q?pE4IoYNiGmMm8XBC8/DCxOHqFZ8zni/N4oP2LC/KYV+NOz/bd633KXYA4m7v?=
 =?us-ascii?Q?gS6t5ScwFpmvE2WDik1rQX0wCwdERo22TDxx8kNYVxl96p4naRlEdN9WAG1F?=
 =?us-ascii?Q?T7+ucsXTXJoTizSIi83dqPkkmPxn9zhSU18fkHfQuG1dmNfqI/u+xmLMd0pO?=
 =?us-ascii?Q?us0SRbjYoeaS57LCvAq0Lo2xUPqnei2RktSnhNWjokJr9a47wj+Hh2eHc0bI?=
 =?us-ascii?Q?KUYWhpKJ+fwhSHPgVeKdu8VK7VUwvzoG9NgJgJ4TmnqnuamZgSa3n5ZMf9Oi?=
 =?us-ascii?Q?s19xJp6Xa926wj2xuX8mpVuq0u3IrjDNzS7Mp8wVrt5Hx3Uj2S6s9Cezjh7W?=
 =?us-ascii?Q?aUfMCy97WRhvmJIPOtQIt6Z5OtfwT5oOlwxfizoNoI5v8EXMuEh3gDxl6mXZ?=
 =?us-ascii?Q?vhD4lilk6bEWKK6BG2PktuQFWFf6iLHbVLk6lmM/wQlDY0Amz4pcD8Mc49wB?=
 =?us-ascii?Q?T2erT8pGowFEa5TBBuSAp0TVajx0UgtFcZunu+TZ12rZEUVEo+XOBocTDgxv?=
 =?us-ascii?Q?J1jxc6qTK4k/nILyQCHScCum7hJ89Zgn75ozdBkcK7O765yoeXawNrvFck+l?=
 =?us-ascii?Q?KdRP2Cn3yhX67gfRB/wfQYke7IxDhSJU0zCg9C8N9IL8SQJ2NBT3mvrEJs9d?=
 =?us-ascii?Q?QTHAYSMFPttvUWcgT42a0GVdXFzbV0AHZQafNhd5Q6ow0cJu6uHLV86wdDEz?=
 =?us-ascii?Q?IWvyVrpDNBHTCHjQ2W18Ri0hgTGfZGd84DMpk3aVyoTuR07TfUy0UegqqClc?=
 =?us-ascii?Q?SfyT8iG2E8aWh7dk417tDREr62TfniCiUEnaU+GRpvqA1eKlnwvMghPI/1f4?=
 =?us-ascii?Q?qg=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f990b275-2fcc-47f0-6c35-08dc42b05ce6
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR02MB9955.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 16:20:42.1750 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gk8NeSx8St4I85NV0gZHqNCqTc9WQkT8A9qw8DQPDajZyGYNNr9PulC3mZM7SZ1+hGERDgkCRYhQZDSYArTpQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR02MB7570
X-Proofpoint-GUID: 7t7UQKIb_nUlwMuuCBj-gw1wxfcD947L
X-Proofpoint-ORIG-GUID: 7t7UQKIb_nUlwMuuCBj-gw1wxfcD947L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-12_10,2024-03-12_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12; envelope-from=het.gala@nutanix.com;
 helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
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


