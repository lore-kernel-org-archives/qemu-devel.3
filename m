Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ABF0CD1284
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 11:01:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ru9DW-0006WX-AB; Tue, 09 Apr 2024 07:00:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1ru9DL-0006PH-38
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 07:00:38 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1ru9DE-0003qd-3Z
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 07:00:30 -0400
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4393VrWK009211;
 Tue, 9 Apr 2024 04:00:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 from:to:cc:subject:date:message-id:content-transfer-encoding
 :content-type:mime-version; s=proofpoint20171006; bh=6z2T+CArjn4
 079B7R5z6dNXADtRN+8g8WTi4jEO89q0=; b=brpTyGwr2qw/WMFTSvVDNmoaXK2
 MiZj4uWVsGkhmt1M/7DY/PPmBeYrw1BjKeUSgQMocJK1s+kemHiWK1pN1rp85jRR
 +hM9PFnTKzcELWZL7ya4Miw0Sr7G2o5FFGvU3cM7roMPsCBeMIdQrNfnvJVd6IL/
 Q3uBr/YQb7FQaMaRlf+RH9iCeR6qGeMayRMXFYJQBZK0BaWo2D8NflAj8tudJP0u
 SbFkUqRbeFeGbNINq4ZtYSHhAGcHXq1L1r+AJHy1dvsbVqpMzj57GOT5sM+D9U/4
 L7AgQht660rkbuAFnojn7V0sa9pREE+qfYG47eSH1YB7Wxm2JfbeWy5e+Fw==
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2172.outbound.protection.outlook.com [104.47.58.172])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3xcwua0mm6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 09 Apr 2024 04:00:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SKCgx9DbCD+nC+xDfdGvyhAvc+OUzGTtKVRJhxZE+Tm2zX3gPO6EbwbvbByKRFbVa7rvL6U57OhR6qZOU1enxsk9dD8k6SRwBCXHIaNpJL7gu918ZK/Dnuv1io6JG+gf0SvZdIDi57KO+oEmFn9vW0n6FKngNL3wO4uw1vlQ1pWvxX3vsarMFt4HsTIPNeTvrQDUmhZL6y+uFDuyP+Dk79FDIFnctoxuT311YCOo7Y10MJ8Z5eOiBQvEf0bt/wienCyaAbt9TWDowz8RuM3SjCVRlezsau8QTYV03NYaaS864ffwBlC8c55RLY/3qj7d+JC4Ca7exJzvdW6R7PvE9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6z2T+CArjn4079B7R5z6dNXADtRN+8g8WTi4jEO89q0=;
 b=Tn0BqC+Dk6ga4Ty3ytEMMTj/2zYuBD8YtRjDw6c+HBZzteeEPtKn7poSLIBjxehbmOjF9S8A1C8ueW6sBKaxmrn0iaP/ti68CgIiSjkx3ARvVJ0GPbmUpi5bgC7sxbuPrKoJ7W/4xdfmROHncI6rxOs4WrBr1IeO5pfPeElQ3o9CyiEpWtkJ+gocRFXyD6n6cS9aIPZl+svbB/qsmBzLRSOpNtEsRQ/DpODYAqk526tGWi8lKZup9mjTDISBPR7U9OswLJNyUbhNRbXSnTpNVunKhWy6rdPSzCrYR6to7hVzv/TVevqBHVnEYFUuu10NyIqhiuuK2qSa5w1cchBkDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6z2T+CArjn4079B7R5z6dNXADtRN+8g8WTi4jEO89q0=;
 b=afceXWSJKUHDh7wwGhN0wO8Frh8pbahBouqEM5qPgRJQ71EHlMSKc7mT+r5VA0bYC+rjC52nWSUairk8DkZ/c+5UjzutkeU/Vw4qQmHPRTM1AbNweGRb3TMs7wR9ThDDCrlarUzO57FODaF88cgv7WlpxoskkO6y0VT0YD8b1hw3SIuElICm+QL4kxQ8vzeXRaVn524EXTXGj9rqUuSXx+wjxJeq2jV7r6reiZp6QY8n+Kds5bUls96228hSAjnVQDaemrK6CxpcgPoCzaxX5hWk/m6r1U8IcB0/h8OXzXE4u7aXpkjnr8mfbDEiUxZPBM0Q1cR2FNfoCbndis7lLw==
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com (2603:10b6:a03:55f::16)
 by CYYPR02MB9826.namprd02.prod.outlook.com (2603:10b6:930:c0::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 9 Apr
 2024 11:00:18 +0000
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0]) by SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0%7]) with mapi id 15.20.7409.053; Tue, 9 Apr 2024
 11:00:18 +0000
From: Het Gala <het.gala@nutanix.com>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com, lvivier@redhat.com, pbonzini@redhat.com,
 peterx@redhat.com, farosas@suse.de, prerna.saxena@nutanix.com,
 Het Gala <het.gala@nutanix.com>
Subject: [PATCH v2 0/3] qtest/migration: Fixes around
 multifd_tcp_channels_none migration qtest
Date: Tue,  9 Apr 2024 11:00:08 +0000
Message-Id: <20240409110011.174426-1-het.gala@nutanix.com>
X-Mailer: git-send-email 2.22.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR17CA0009.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::22) To SJ2PR02MB9955.namprd02.prod.outlook.com
 (2603:10b6:a03:55f::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR02MB9955:EE_|CYYPR02MB9826:EE_
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o8Y1c7vNWX6gf0nwe6PXP9T5zAFhvk0bSCSAfXcSck9jhXF0AFqYbntbstGkqwxbGQL1nTGsFox8sjtRTtDXwcwHX88rcELuQWL9Q1O7+1YWCmoiCCw2LwF5yK/m/XAP/+I5FOcLGQ2JlBzoAfNidubKnKEHp/92eKztychAtFG6tWs+31YLDEerV4NvWWQdN5Y68FhhgPzaIuKezB7TIVNTy1xbTzbkexTaJ+MS9hxdXcWQpcQBdj+wnGZp52viJ1OMrcVhQIEcY0lPwh0o35ytD5U4O4xL2kh/R7i2eXwNmO8oLBbDd8d5lI6uQrEOOh6Z8hx1bpZZVvzmyCGVvg+MUN6bX6oH5E2KXOFiFiTAbTkfRSYQYIBLGTEnMxRaw8TpPLppyqlgcBE+F+1sy3RCIXkgM4BKlDLYOe5Dex1zD2tS/ABgg49wAHwn4HMHBQiuWSaL90j1kVEkPAaFLnfGjTQhv8Sn06/FF39hNB3wjMkH4HnRz9OpuRoKyeaQPKPBHg0P6dAjLhIDMnaBs8seQT6p8ERj85wvVN8rr1iHTapdpADmZSV3bbQbZppX4jEaTiwCW6iVOIT7HJIXvoPPM5GIv9BTrZ/izHJ0rULFlj10Nu/mboIcwlLmQgZ/hI1PBH0yLK98DDWZJJz9ddb72dXqiIBPxqGlpRx5rJr1C5V4ReOksKE1msV7LDOla6GYVzm2p6iVm7eZT+wenUwrVVL4n986yv+yTAxziX8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR02MB9955.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(52116005)(376005)(1800799015)(38350700005); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?plJN0WJCNNOHWi6GmZYnjO8W45lZQFIe6nkDYCFJMgKXieF5hxT733g7yzFh?=
 =?us-ascii?Q?HBNICMWEod1Rf2SxaRjHMcGMxbTpX1zZ04K/3CIOqYzAj0lCgAO8SE5CTy5N?=
 =?us-ascii?Q?R9zpG4HonjW2A2+YL0RIf1tdOYOm3UrQ2IjoRT3fx9aUgWGr6BPhEb3JWD0f?=
 =?us-ascii?Q?0kD692jEBGMT169pLJZNr/JFfMolgZHtrIJc9yhWAvaleVq46vQwkQibV//g?=
 =?us-ascii?Q?j177l6fHGT+5JXtjGUyir3bxXLZls68n0Qbq9vPHMV/+8+ya6KuEunWjhIM5?=
 =?us-ascii?Q?9RwElZnVqFVVvm6y80xNa+8qH/GkxbMDGQbMiCJTDHMh8GWSlLna1F3Ly4PM?=
 =?us-ascii?Q?3rds98oPWjI577RscDae2XnbP3Vs+r844OPr6cavqdSbCh9CV6GKOO4T/xkc?=
 =?us-ascii?Q?28F9gvci9HlGEqGksUDXbbHRcMNBaJOk5odQI7E2QtgBrChZyYFez73mkPhr?=
 =?us-ascii?Q?k7jtjqXfJ76V5mJOROXmnY6IheUn5upNkXEbly0WcvaPPwOvaQ48usmT+5hE?=
 =?us-ascii?Q?AzTizyDbEhj99U8ECIVLK2e2iS98uCId2IshOvNPgjOU9VBYO4L+ILAlPbTr?=
 =?us-ascii?Q?DGAzNFgF/Ru2Rn9QsPg6Jxp+qezE6legVCsjyrc3XRg2UUenaOBgkaZJBEes?=
 =?us-ascii?Q?wZPUK29/sT4b4nm0d3VESpvJFPRC8XitRQMRpdKyFMlsnKTtcHi3gVp79OSS?=
 =?us-ascii?Q?ujTK4khSlzz0E1anrbAjWyD9fLBoaWH4Uj2HtxRhKCQze0hrTZQZJEVyeRNI?=
 =?us-ascii?Q?25m14M37BBPSTPLJClNsOoWBnEqsxIJGQKtGF24NcxTgFDztpLhMk5iDysfH?=
 =?us-ascii?Q?+GN/RknS18kdLw+eYUDs00P6VxMlxM7YKt5p7RUFRUH/rAJ1lFwO7JnREwn3?=
 =?us-ascii?Q?DQxf4lw5FHIiaxzu5OhubNG4Mk5598vnpqzXOgltI6YpksWS5/yzXTBwtg+e?=
 =?us-ascii?Q?chhifO6DrLvmQNsbrSEN8mJKawzi+GCu0ZouK9/wnO25AE8KHcF7/mG6AsFD?=
 =?us-ascii?Q?6exDMe6MWYBwMKv9F/ZSQJ3cPU+j8ADjD9s2mivi9sgZHLWgGT7febWPhQyt?=
 =?us-ascii?Q?EnyJ4EB5L7DQKMessehVJdVfs/T7R+sCHE7HHLrrYcZhwApxcczZBxKfWG67?=
 =?us-ascii?Q?EX4OA7PW4DURYY4OiPztPBJfaTyVAR3vVX/KWUg7gI7bLC1otWiLsKHf5eAG?=
 =?us-ascii?Q?jh6rgo/EJVIIFRutmsj+ExaiBYzHrrsXgfIDuSaQDHwK9670XTTNPBQ+Es0i?=
 =?us-ascii?Q?ZxMr9RZmPLredfrPNa1efUeCPz3jQKIo3Jtq8onqOgZo95Zhy5ZvXAAnXNsH?=
 =?us-ascii?Q?/G/O6XnSNsv5qGfMRKcZP/m3hcKt4rQWuTfOEp4CzVI7fhtVRDXN7NFBVcjU?=
 =?us-ascii?Q?HYBi49HUE634Y81I6YFns0NKm2exCLdrn0vklY9BI02PJY3k1IedpbcKiDy5?=
 =?us-ascii?Q?yelppBNAV95Q3ZVUBy2doyQB6uniBzQdV4Dmq9oi+BcYjYsnIFV9GYf95JF3?=
 =?us-ascii?Q?2RVQFqQ4dZYV2M8EkOT2dMO0cPQlE6tg1WSsMfU4c2jvQApTkuURHVHOpJmC?=
 =?us-ascii?Q?4imXUcuxBM1oiEJawJYWAVCvIYeWexBVbixF0DPu?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fa073c1-3c19-4ad4-da5e-08dc58843e2a
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR02MB9955.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2024 11:00:18.2864 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qcQGjNLOsgIXQj1JwnffE1dNs6OTXZhQdtr1hyn+UpiNZkxBWai4KMUhE9hIjtA/yZnEDiEU9f3/+8A2QCfjpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR02MB9826
X-Proofpoint-ORIG-GUID: NUEL6XVTHKRCkKzkyJ3R8P52N0dKgCJJ
X-Proofpoint-GUID: NUEL6XVTHKRCkKzkyJ3R8P52N0dKgCJJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-09_08,2024-04-05_02,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68; envelope-from=het.gala@nutanix.com;
 helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.701,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

With the introduction of new patchset to have 'channels' as the start
argument of migrate QAPIs instead of 'uri' (tests/qtest/migration: Add
tests for introducing 'channels' argument in migrate QAPIs), a few minor
issues got went unnoticed, which were caught while trying to introduce
similar qtests in migration-test.c
Fix multifd_tcp_channels_none qtest to actually utilize 'channels' arg
in migrate QAPIs, fix double freeing of addr Qdict and typos in that
patchset.

This patchset is built on top of (tests/qtest/migration: Add tests for
introducing 'channels' argument in migrate QAPIs) 

Can find the build pipeline at : https://gitlab.com/galahet/Qemu/-/pipelines/1245462266

v1 --> v2:
---------
1. Split the second patch into different patches - One to deal with double
   freeing of Qdict and other to add connect_channels inside
   multifd_tcp_channels_none to actually use 'channels' arg.
2. use 'git commit --fixup' to improve commit message as well as
   to inform on which commit is the fix meant to be.

Het Gala (3):
  fixup! tests/qtest/migration: Add negative tests to validate migration
    QAPIs
  fixup! tests/qtest/migration: Add migrate_set_ports into migrate_qmp
    to update migration port value
  fixup! tests/qtest/migration: Add multifd_tcp_plain test using list of
    channels instead of uri

 tests/qtest/migration-helpers.c | 4 ++--
 tests/qtest/migration-test.c    | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

-- 
2.22.3


