Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6106ECD1296
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2024 11:16:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruVvx-0007Y4-5I; Wed, 10 Apr 2024 07:16:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1ruVvu-0007Ua-3g
 for qemu-devel@nongnu.org; Wed, 10 Apr 2024 07:16:02 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1ruVvr-00019d-IJ
 for qemu-devel@nongnu.org; Wed, 10 Apr 2024 07:16:01 -0400
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 439LGv17021052;
 Wed, 10 Apr 2024 04:15:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :content-transfer-encoding:content-type:mime-version; s=
 proofpoint20171006; bh=7qHqbJfn5gnM90KtpxfzGdSaq2WuFSsucG9/+bwPk
 wA=; b=t5TytN9nBzgjSGkmzNL7yxvieVvv27nQu4p8BRPQc/wD/l/IY65wkJ+8d
 GKthnIinzpdztDtmnGLRmp3h+RGrqTT50+T1Awd8qElnB6ssigZmEiuZDAExYUG9
 kg5BvxgyZ4bh574ysF6Ayri3sTNaYfhRgGHheDS/GBmHsBIbvPXYXKan+hxamKNr
 gWaUDcPRFd7P7IaBsMRvrNwyoErgffmwDzc0oTf3jZ03bGh3eLIYjrzsIixi0Ync
 plFpLSmDbdf2rK2M8kMyjCtgHA2Fqb4UEzBTbUOGwe4s/nxqv2aW28FoyTbNJwJL
 o9P2M+hpgcx7eCM5ldB4uuC/qzLRA==
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3xd1qtahad-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 10 Apr 2024 04:15:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oKktYPfeUs908Og5RVKjNcTVWMXFumPEvuuEN9GSq2aD4nRlgV4bo47Nd5EQtgLbeZxRFTQJ94VFY3oL290tj6etZTnGl79WuTMJ6oXpLtcK4pgElTXS7r6iSI87xmCQ2jzhB4as7CfxxVQKQs5zkypSsAop07C7VLhhDMS0NDDRyJnG0AWpRK3rh27ULyP3tk66ZDPNxtucOMxBEYp9/PIcmKVt34fSDm0KUV0ptIEgFDBCfaTwhsIHMYVJ2GzGu2/LNlZEytK/zioQ9jMkznYwp2lI+4RBr2yxrAyq9p6vJlb7goFBm+ODoPUa8SWjWpUAwrwaH02Uto6Ef81GMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7qHqbJfn5gnM90KtpxfzGdSaq2WuFSsucG9/+bwPkwA=;
 b=f5x0dAOoMAAZa3iTgDYH7QrC/56NxXHKKe7nWiXd7bnfiDSDq7AhF51ZvY+aEJX/sbYtC08jtjCbqv2qXB+FKFJiqiAAHzUOK1vTS4nBQ9NvkOubrEJB2smytX66j+JPS7OdxJ1INyF+X1rFktnLqt9vp81DYSKMj/L4ynT17TyjTzTn3iBqtTDjV4R6bXe++zeRLxPE25ZF46AkD/jepxmGhjynZKvAKoVjYHq9IHZkxzIb1uDCVx1SAzAfcW9ey5aTupYitSqvccmHPKErJ7EXobBDFHmZ3lEw1Du9RkF2wzLGSmKGKYCcZEuBWiv/hPqwtO7l7a2Tz9TplV1UwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7qHqbJfn5gnM90KtpxfzGdSaq2WuFSsucG9/+bwPkwA=;
 b=c6APTveJTUJe03h2vf5cJCkjOm0AgJxNvfKNQJC1Go/pMfrTe7joRwaT61xITowB+6Fo/YmjsNMxDSdKuH3qpgk+GXeEsXTXSr5q6GZ/n4hyjnhald2Cq/2RLeR3H0Pbt0k3q0j12IJMWqwUzc7NtPi59NQXKv0jnbBMreRiJcM4DZzdRUYUrekHwMVPneIg9yv7HWUqAvToa2HaYKSk9dHB/Eq4TSeuN5QUSS2IHjyUbNKU5uEnc6EiA4CBBgxodljZEx/sYtd9hHDpk+sDyZioLRsSVFzFO4RnHgRzSSBiqrxvEUigjsWQDlV1mxfct45niV0WW4wH7ntgMhLiGw==
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com (2603:10b6:a03:55f::16)
 by CH2PR02MB6791.namprd02.prod.outlook.com (2603:10b6:610:ab::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 10 Apr
 2024 11:15:55 +0000
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0]) by SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0%7]) with mapi id 15.20.7409.053; Wed, 10 Apr 2024
 11:15:55 +0000
From: Het Gala <het.gala@nutanix.com>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com, lvivier@redhat.com, pbonzini@redhat.com,
 peterx@redhat.com, farosas@suse.de, prerna.saxena@nutanix.com,
 Het Gala <het.gala@nutanix.com>
Subject: [PATCH 4/4] tests/qtest/migration: Add postcopy migration qtests to
 use 'channels' argument instead of uri
Date: Wed, 10 Apr 2024 11:15:41 +0000
Message-Id: <20240410111541.188504-5-het.gala@nutanix.com>
X-Mailer: git-send-email 2.22.3
In-Reply-To: <20240410111541.188504-1-het.gala@nutanix.com>
References: <20240410111541.188504-1-het.gala@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH0PR07CA0016.namprd07.prod.outlook.com
 (2603:10b6:510:5::21) To SJ2PR02MB9955.namprd02.prod.outlook.com
 (2603:10b6:a03:55f::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR02MB9955:EE_|CH2PR02MB6791:EE_
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n2Z0wYRto0IUE7yjEw/1bT9rdSQFSIY9RCFjZB5IZ7Ri+AJi+gpj8waLY0gSm44rF8AB95QWdEvRS8GVaHZOiDu5SZVIOyxyg4G27tN79y86A7xN98xQzhgSrFrt9qRaru3fsRrH6MtFwRAgBQ+wM+G5lEHZoPZHMrA45OGATwfU5TUp0I+xLZq+grWox0bXfQhfX0TWtF/E0LcRNLFjpHXI+IsNHP9EPAtcAXPj/SdmOaEhRcBI8tzWmYhpUyM61DGNGsdzKnfjuBDbMH/m77wQ71fERKqdTflqpjmqV05KC6z8NHNAo/IMsoPSDmD8ON6aeKyrbM7OqCFkgMPOLCe7NJgTKWkJtKIDjUgekbRYdKUuZtsRtmjLzxxoZ6D9b24r+KVDmwOJml0S3upa6zOYVemutyznv7cON9YsPlWIwvCUkOnwpnP8i0trHJB4UGkG9ySCU2lhWkusQaVjWfGTrvYz0EuSD26GVtSZSjnYGrkNl9i3giatFszAvn/pWiQjjKY+wl7G4tNg4tmYB8Gd+gl/LWEfu0icdTuQNat5ZIjY2On+ywTukl/4vdqRkBE7Nx9RVpaRgKuJ7YviAme7KljUQmtlSYeNdmqUWCgTp0cCHcAurylXk6hdDY+11iCBHEu3cYwruaa0pirubo6VrHV0JqIt2ubC9R26mLgsiMzEAtWiqeuPyuy964QUPhQ4LWFRENZjyZFycVcvsXji5GYX6FJzFfde5DBN3X0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR02MB9955.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(366007)(52116005)(376005)(38350700005); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/ZN/6ikEUlDGQhiHKUN0DGl2fTKankyEOzqAAfdwTevVR32KAwOC+BjMODiq?=
 =?us-ascii?Q?JGJ7/216xgDkZ6+/2+I/AbTI6N6sEHBy/ttNcSUz4OwTiYgxENscJCjiEc6a?=
 =?us-ascii?Q?PPXclrYNgeCfReqbKKuU6pAAuYaHw5NCVY0J3MHTqu/6+iU4um3wejPZF1t3?=
 =?us-ascii?Q?yYnoLb6bagnxCuqg/kWPnw4GcgGBB2xtv8ejHH9o0ojagUpGQbUQ3zwq7oB3?=
 =?us-ascii?Q?5JzwYdAXyWYJWMG+neUYjGd9ShRTDe6djxZDn1JaxLe4t1yIkaRnX7WEd8Wu?=
 =?us-ascii?Q?xaMN4YRuHiHk7gQbfEJzQPNTlKB9Zb+Dd/5wG9IDpVOAI5O5Hg+j3/YYlhNW?=
 =?us-ascii?Q?6xJdzo35OwTU5n6REk9omjnAKQCqAQiMMPAX5Bd+hKmnUVQRXk/DWkMY2DUB?=
 =?us-ascii?Q?iFYAH4Qy3O4nopaxlDI9a+SAWrkVTUYpzJkj7L2d0qw1ZoFdPQvAWhgN4xAK?=
 =?us-ascii?Q?0HNqZGTqLmzPV3/qP3APUPYwcJ/aVTj3LNjNff6YN59ciROAZYHx+ZS8P8KL?=
 =?us-ascii?Q?0vGAqwhXlujeGwtMWY0PilZvJYIvqgIlHTiRB+/cdTLl284ZtzCZuiBKUv+w?=
 =?us-ascii?Q?PIDs1wI/VT6spOzWGltllr3jwdVqL+5mrs73iBjy1IqLy74NVKTmP1NbI9Qi?=
 =?us-ascii?Q?C0J5BfEpPlu4ZTXICeyK8MALzvFNUzt4nQ8I4LJJjBzmwy5L9vKhHACFZSGH?=
 =?us-ascii?Q?n+cYiFwDhf1eC7yZMgX+XzZQShWap6eGXKM/38BT4w/BznWLmnrOqktPBJyD?=
 =?us-ascii?Q?PZm3Luis4cA7tEMCXsF9SYUZHmotPKg+mXwB2g6dMZ3irkel3tDCbbS3v2+M?=
 =?us-ascii?Q?YK9tMX9xE8tE00HYH3RltOju8u9+sAn8z5c3Pbk+yqIxytOYjwnNm1V6Tzga?=
 =?us-ascii?Q?p0kesAR4CoWymQ7w1gledOMSwWUX9kKpocouBESp0oqlRVaH9rC1c+lJmj2E?=
 =?us-ascii?Q?IKx7H5VBFqjWoWLT9N6kOCcEaZkCbbQV/KXIzDkMSVxLiaDTHDZ5DJx0O23l?=
 =?us-ascii?Q?FhVevVBwlwwskI3uFpNSCMbA8jNTAf6YyKqktE2JzZRzxbho9ZcIuyv8oA2n?=
 =?us-ascii?Q?n6M0/oc/H3snhhg+5TvQcOweD1QPtq58lucWdQEFjvtqd+iYDF1IaJ2gpaT0?=
 =?us-ascii?Q?Z1tY3hQCV0T/4eBhmHr4wbqRUYuJ9np/KPcGAmDbfQIbez2KrT0x3KBjwmR6?=
 =?us-ascii?Q?yWsiLmkr28k4dBUgYfX5XlDx0pf72VHaMKKYOaUh6RZ/8hnQBtmuDbd0rtbp?=
 =?us-ascii?Q?EMaWZ/bPZSYjSIHCeUTJreiJFjiFOJ1fqp+JYDelY1MwmJJ6QohxSCtw5guM?=
 =?us-ascii?Q?mTB5468PZZGH1VSpsOXbGBHX0TxjdKbLDpypAO6LpzQ/H9iPKeHQvBSWpXhZ?=
 =?us-ascii?Q?swifCUjeSNZq8tD/m2CB8Er4QK5DA1AMocGdOpeGe86wujsMVTgtxv6c6TGB?=
 =?us-ascii?Q?+KyAFN7gOwLstby6CxBAsHkkLyP0f6sj7rAPet75wVJAyQd3nJB5yUbsvigR?=
 =?us-ascii?Q?MaXpbKLP2Lv97cQWqwizgIeVBk1IaMmKAfGDb4HNDpB3RUryoqVeeuHomnK2?=
 =?us-ascii?Q?g4s0PLP2Atov++GEmI+55B/vrl3vRAfzCAc4wLzE?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06960f7e-a3c1-46fa-fac2-08dc594f9720
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR02MB9955.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2024 11:15:55.3796 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SAo0oQsskTpZ2xvwNMCgUVslvkuiFz3cSj2wdGxRb7i/s2GBhvVrYTnwhWNHxhfrb7newHHbqyRmbk7siGGoSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB6791
X-Proofpoint-ORIG-GUID: nzbrNd50ToTzni-H3A0R7uTUTZz6Wxbu
X-Proofpoint-GUID: nzbrNd50ToTzni-H3A0R7uTUTZz6Wxbu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-10_04,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68; envelope-from=het.gala@nutanix.com;
 helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.049,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add qtests to perform postcopy live migration by having list of
'channels' argument as the starting point instead of uri string.
(Note: length of the list is restricted to 1 for now)

Signed-off-by: Het Gala <het.gala@nutanix.com>
---
 tests/qtest/migration-test.c | 38 ++++++++++++++++++++++++++++++++++--
 1 file changed, 36 insertions(+), 2 deletions(-)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index fa8a860811..599018baa0 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -1296,13 +1296,17 @@ static int migrate_postcopy_prepare(QTestState **from_ptr,
     migrate_ensure_non_converge(from);
 
     migrate_prepare_for_dirty_mem(from);
-    migrate_incoming_qmp(to, "tcp:127.0.0.1:0", NULL, "{}");
+    if (args->connect_channels) {
+        migrate_incoming_qmp(to, NULL, args->connect_channels, "{}");
+    } else {
+        migrate_incoming_qmp(to, "tcp:127.0.0.1:0", NULL, "{}");
+    }
 
     /* Wait for the first serial output from the source */
     wait_for_serial("src_serial");
     wait_for_suspend(from, &src_state);
 
-    migrate_qmp(from, to, NULL, NULL, "{}");
+    migrate_qmp(from, to, args->connect_uri, args->connect_channels, "{}");
 
     migrate_wait_for_dirty_mem(from, to);
 
@@ -1355,6 +1359,20 @@ static void test_postcopy(void)
     test_postcopy_common(&args);
 }
 
+static void test_postcopy_channels(void)
+{
+    MigrateCommon args = {
+        .listen_uri = "defer",
+        .connect_channels = "[ { 'channel-type': 'main',"
+                            "    'addr': { 'transport': 'socket',"
+                            "              'type': 'inet',"
+                            "              'host': '127.0.0.1',"
+                            "              'port': '0' } } ]",
+    };
+
+    test_postcopy_common(&args);
+}
+
 static void test_postcopy_suspend(void)
 {
     MigrateCommon args = {
@@ -1555,6 +1573,18 @@ static void test_postcopy_recovery(void)
     test_postcopy_recovery_common(&args);
 }
 
+static void test_postcopy_recovery_channels(void)
+{
+    MigrateCommon args = {
+        .connect_channels = "[ { 'channel-type': 'main',"
+                            "    'addr': { 'transport': 'socket',"
+                            "              'type': 'inet',"
+                            "              'host': '127.0.0.1',"
+                            "              'port': '0' } } ]",
+    };
+
+    test_postcopy_recovery_common(&args);
+}
 static void test_postcopy_recovery_compress(void)
 {
     MigrateCommon args = {
@@ -3585,8 +3615,12 @@ int main(int argc, char **argv)
 
     if (has_uffd) {
         migration_test_add("/migration/postcopy/plain", test_postcopy);
+        migration_test_add("/migration/postcopy/channels/plain",
+                           test_postcopy_channels);
         migration_test_add("/migration/postcopy/recovery/plain",
                            test_postcopy_recovery);
+        migration_test_add("/migration/postcopy/recovery/channels/plain",
+                           test_postcopy_recovery_channels);
         migration_test_add("/migration/postcopy/preempt/plain",
                            test_postcopy_preempt);
         migration_test_add("/migration/postcopy/preempt/recovery/plain",
-- 
2.22.3


