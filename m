Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E824CD1296
	for <qemu-devel@archiver.kernel.org>; Sun,  7 Apr 2024 13:22:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtSSx-0004w2-Ug; Sun, 07 Apr 2024 09:21:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rtSSr-0004vD-Py
 for qemu-devel@nongnu.org; Sun, 07 Apr 2024 09:21:42 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rtSSq-00008n-4c
 for qemu-devel@nongnu.org; Sun, 07 Apr 2024 09:21:41 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 437AJGvx022867;
 Sun, 7 Apr 2024 06:21:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :content-transfer-encoding:content-type:mime-version; s=
 proofpoint20171006; bh=SQxOhctoSNZJj+crDdeSEHkwbqLj9hMVQL8X3PuN7
 Ew=; b=qfTU8Yft1b5Yv5vgH03OXQkMZkdZw5mjwx7Mv5qnrSiFt7g/5nlVF1pZU
 u8tg683a+vmwLaZ5NTDQXSjDwkALcy8WwVTNskzrZCAhIu7RSvWfdhGfJHS1e1We
 H9q8qSFLEHbTTeUVrSzmW3OcpSSHWq73ZQ2VI2ZD3bBhV6L/q9oPjD2OVRi+fQew
 CZp4NpBVP+6ZJcD2BPxhdVnPeEwaWNK0DUxC+tqJ1s1yfyqbRRaPcLSsox74NMz9
 waujVfLl8U2bp/iTuWG8P2+4I6GQUArz/v0xsQybH1Xjh7bkG+xTY+VdJC4rSMue
 jAMZEpbswI/ij147jMk/w6d+ZNaRg==
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3xbsm9856c-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 07 Apr 2024 06:21:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YsKvStcr67+OiReapQtQ48ydstyUyApaY8dfH9cJkXWd/ktNmJOYMPcNjqYKrARvvf/DodqbbAKqJFL7dMTimMthKQW8XAqKt9ogochZv07mOzpeOUmB/qORglpFz7HAlWnYBBvoc9emwK9ClP00s0LoeAMB4ck4Yswc3M0zgJSVsHTBmdpcIdUFnmrETLlUvujTcCVXLs6Ty4qwVAjAsbL+gWCCDOw4qYx8TeB9URwhgBwsrG9juEfvUibL6pqi4o+/4sxB6vUhcotnc2LYi9PdGINyJHj2f3DBjOam/olu+seZ1+OflvkYzLCI50tAeVdZanh1lvddizci4LOA5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SQxOhctoSNZJj+crDdeSEHkwbqLj9hMVQL8X3PuN7Ew=;
 b=E36E4ZvHt4lJ1V9Dhz0WgDHKa3l/u0ikQa3f7FK/OaCYe06PAyAiQk01t1ysmYppxksmV5uT0KcFx/TtfOjCA+BwQ+CzYlaJWE7tL4PstZgMHhy6h9nBGRBWiDqqtzglqgHLBXm6q9AGV16BOV6Oae8DivspPzRZdA8QZ4jNT5T5Kes2ijS/eF44GONSR8RF93TXzEYqRJMXwpQoXIOIGOjOxoTreVx3CkPjWQHBcfaI4Xicdl52nmPOcHK9zGQZnRRkSdUD3kd8d0alJ1A8xAaMFLy6QUuEm7T55KlCFvKoxmKjLfrNr7Xf/ZEsWEtYSxQyJ8JNydU+tq/41PY6gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SQxOhctoSNZJj+crDdeSEHkwbqLj9hMVQL8X3PuN7Ew=;
 b=uVkVEsYiMqalrZ2gAOxJe/BgMTFAsWrVAk1dtoiYe2xnZN4+n1tPD89keaZbT5tUjdmHgbY1ia1lSOkNaUAoARKtCDVfblbU/yjzH3MS13zfU52NWtw1rwYB13wNc9zsflfP12y81jJ07Za4lRCzRq4xLCaZ0U+QcLvjLYEQxUNhy4N15mMkNhGcU7wzNdAq2pe6M2T9MQDiuFk/T3O4wXE6PyOpp2q0yYor5WMeek8IGknwWtZ54062HpMCBk/jg8mNv0cD7VUYLH18BFupHvbntC9pYvpDqOqXzqCwsQFrgY+PEgce5TQrxU+CGMenOHrALHeI9fPFr4BMxF3vTA==
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com (2603:10b6:a03:55f::16)
 by SJ0PR02MB8625.namprd02.prod.outlook.com (2603:10b6:a03:3f8::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Sun, 7 Apr
 2024 13:21:35 +0000
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0]) by SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0%7]) with mapi id 15.20.7409.053; Sun, 7 Apr 2024
 13:21:35 +0000
From: Het Gala <het.gala@nutanix.com>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com, lvivier@redhat.com, pbonzini@redhat.com,
 peterx@redhat.com, farosas@suse.de, prerna.saxena@nutanix.com,
 Het Gala <het.gala@nutanix.com>
Subject: [PATCH 1/2] Fix typo to allow migrate_qmp_fail command with
 'channels' argument
Date: Sun,  7 Apr 2024 13:21:24 +0000
Message-Id: <20240407132125.159528-2-het.gala@nutanix.com>
X-Mailer: git-send-email 2.22.3
In-Reply-To: <20240407132125.159528-1-het.gala@nutanix.com>
References: <20240407132125.159528-1-het.gala@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH8PR22CA0007.namprd22.prod.outlook.com
 (2603:10b6:510:2d1::12) To SJ2PR02MB9955.namprd02.prod.outlook.com
 (2603:10b6:a03:55f::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR02MB9955:EE_|SJ0PR02MB8625:EE_
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XmjCPiHwAeRJmIO0aq5QfIkA87x+Qw47sA7WDS8hMR9PGqHFwYLQTTvrOojdLXOIgtWDmYKG2wSlBzcmzHQQmqZSvlvsdc3a0H3ioKn/mO83bQEDjIhkg5b3U9NCqv6utWy++I1MAiJ4abWq66b4g9QI8fiZMrnBgGNcdpmuMEfQxcehuyL/ON44W2/AO2GL5eEzGN4U/YgSHa5VmXVZ3yhnpLcp6DOym0H4N11MnACdsD535uauod0LI2XQzM151RaTxUJiRclJ6RaABz2DB7K50ixWK28SrdlqTIn0d+Ed/qq0CoFnS+raqlekDHFDbH45OHaEWgY3fricJO3Tnj1UOzZ61oFta6Mos/ljWc/trkpAj4+QUYcLwXGoe1ERZuCh1yFbhnGXQ+IqLFLoctJH6/JWjgc2cp9e3GyaGICKRi3gBKkg1FQMMBehyl2BXU0gVsmbc5EONHGEMRYDwfX9jvTVQBZX5QMMLCK2EvdYTBCZrumlliNJjguLjxKt6kCmCNgzPMoIa45NLcAbXPyO34xWX6nRsMIbV+ASfrIHbNKZvB1pqPY9FpJ9HCKlLYyKxorPibZUzGrz1ZECHVU6XA1JZs0sRDf0YH5kv7oV4yILX5En/BfVtZ6TvkXcG0fnz0N/7tAgLATkHP2dluvtoHqPuFQdTCRIbpB8hm2zbA3eI1asY0UyjY8uYfTRT9yq73fKlZ3hf1u/gNpalcesrbTh4GO3xbijJxQrvgc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR02MB9955.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(52116005)(366007)(38350700005); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?keCNxoYQinzDQ7k2tuXRJ8W6YIScf2+YX9/0a4sGdWp8U3b3G37gJrXt+xxm?=
 =?us-ascii?Q?abXsx3XKGemDmcRP99+7exDKJZsxn6XqJFCitWDlLNWbRFzysEmQ/oKEbyiK?=
 =?us-ascii?Q?lcpXhftX2ctl2b9vOY7vXXaBMGD8wDILHS559CO7RyJza9ukCMNJk+9jt6tu?=
 =?us-ascii?Q?t2Bdc0Nc/DscNXMDJ5HYt0gif3man6uA8NOCOUYIjhxgcGc67RFBhM0rh4/O?=
 =?us-ascii?Q?0N7ygyUL1G/i3vc+xTcvz1/Fs4f5rCw/BYqEiFjitU1J2nQysCLNcTitsGdn?=
 =?us-ascii?Q?rDjmJjtLjhZTu3Z/84LeKiY6RyviO5KLUIuwRprDA+WKd2x5Dxu1FWbxBWMy?=
 =?us-ascii?Q?IRBp1KtkSeV91JwVK+DBGfzJ80yAs7IHKRKywr8wbMN2C6x5GqF2AML7ORCt?=
 =?us-ascii?Q?mBnepo6prHMxCvvlR+LFRuBPyHfNN7Lx2Rrnf2xiqwtgfjexdfihxNq6XQ3Q?=
 =?us-ascii?Q?CxoSTYybv1Vfqey8OC0WnA4X/GwIrIvUl3ynppv8QRAr7dgnVMNCVUTNpzyN?=
 =?us-ascii?Q?oQIvzKkWlPFCczn6emCLB3eMT2RhbX3VU2KqFqX7ywJOHlA3FxKrED+lfvrc?=
 =?us-ascii?Q?cDXBimBldMlC7C1SvavBU+YqQh8UlDxpRUdfCJCVim6HcYk7u6ss0v+U59vY?=
 =?us-ascii?Q?9AlGHwK4kCpN5nurxsepgezbBPZyK6YWvpm4NFjzTnnibv/fVwhDYrHwfTmh?=
 =?us-ascii?Q?7IGbilVhhUZ04SYoQc+h7FBU7vrB64urapP/yKTn1cjuN0lCxRkW0Sa2QuoN?=
 =?us-ascii?Q?4bwQcfLYHWDPXbPmO+hwZwwzVhCUFiu3v7fESRND8vHH0WMFpHSD+t7KsMOM?=
 =?us-ascii?Q?aC5CafVe1pUWI9lkhRgsmV4IiYvz3VaQWZYhwVhkwra33Vfije3PwYrR4VuK?=
 =?us-ascii?Q?8S/Ia25DjFCahDETo6NS7XvWjt6r920Nvy8M6dTpN5GyZM5N438iBkDwleSJ?=
 =?us-ascii?Q?0ENargC+UGadOuQUVbCWRpRo6KhBLwT9Wc8JFm1qSp3KV1TmiC/TmxK5vKAA?=
 =?us-ascii?Q?j0n0qoLDi3ZwW11bDpe/C4gzLhCUixtlKOYVrp2fujme3jX7ZcTo3FwoeNma?=
 =?us-ascii?Q?pkckmLw98OooHNEEIhzlUKhfE9B1aokkPxh/hox+CAIJp9lwfKRwmaiFJT2c?=
 =?us-ascii?Q?x7PaxcSJdxrAAkoIJcSYpf43eAyfFUe/s9EV8ZQUa0xCh9R6TCktvPymNQJe?=
 =?us-ascii?Q?OH620wCLLzAmbeFOzLV2JD3xV+et0rFocN0U5HQXNIBwzlklnK5kI382wXu5?=
 =?us-ascii?Q?zwOOPttB/9qICyhotXQmdtGFai+OYiMOVQEQbkpotttCqWFPeJK7l2o5YYeq?=
 =?us-ascii?Q?hFH8O5bnxKVz4SDiWliF3FFMLMXm2U4ewzplfRKkAb0SkBCSbK38g5uvHBFB?=
 =?us-ascii?Q?s1vchAmobeARel6+chIkuoEjsKkKqwaosf9DOKZc3mnJWQrmipQS/liJP45i?=
 =?us-ascii?Q?lemnFDWEvByH3qLqcV4d3IdaoCqUujUp3aY6aObKXQf424MI0utx8PE6SW1F?=
 =?us-ascii?Q?Xw+TruTMjvwSk2tTX/xYb1kg9GEP1J5Nw73FpoWlVxx2r2yt5Jt+1w8hSO2e?=
 =?us-ascii?Q?6T+wSygnfZPCkL4bayK1vB0AFvsnf+Xl536xcLxV?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ea6e68d-361e-462a-f243-08dc5705a5da
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR02MB9955.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2024 13:21:35.0778 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R0anjs8iZtgyvETyT+p3j48fRPV0MgYyIV1gKPWE6nqwtUmpdaqTzgpoa/xyjR58L66HS0uQNJei+h15GlpJkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB8625
X-Proofpoint-GUID: HQ_TBYoU_LjWHlciv3ndqbHpAS6p2jXD
X-Proofpoint-ORIG-GUID: HQ_TBYoU_LjWHlciv3ndqbHpAS6p2jXD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-07_07,2024-04-05_02,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12; envelope-from=het.gala@nutanix.com;
 helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.355,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Fixes: (tests/qtest/migration: Add negative tests to validate migration QAPIs)
Signed-off-by: Het Gala <het.gala@nutanix.com>
---
 tests/qtest/migration-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index d03a655f83..584d7c496f 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -1724,7 +1724,7 @@ static void test_precopy_common(MigrateCommon *args)
     }
 
     if (args->result == MIG_TEST_QMP_ERROR) {
-        migrate_qmp_fail(from, args->connect_uri, args->connect_uri, "{}");
+        migrate_qmp_fail(from, args->connect_uri, args->connect_channels, "{}");
         goto finish;
     }
 
-- 
2.22.3


