Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77A27C3DA61
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2024 07:53:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWWnu-0007Q1-Oi; Wed, 24 Jul 2024 03:52:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manish.mishra@nutanix.com>)
 id 1sWWnq-0007Ne-6X
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 03:52:50 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manish.mishra@nutanix.com>)
 id 1sWWnm-0001tK-66
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 03:52:49 -0400
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46O0svqC025873;
 Wed, 24 Jul 2024 00:52:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint20171006; bh=2kCx+e8OofmsL
 +R+eOYRYFugEzk7I5ZAEnVjy95/0bo=; b=SIdZWH2OHbIjK74SVx4Cy+aU86hY9
 NZXF86r/ANUCs8IA4Tg8NgM+KbvA0NNJ4Db07i4b5+cVJIeDsLyA3ognX97jOuG3
 lmzxfIgJmKhmx1g/+tjejKq1J9IANJ+iWtX7AVEgTbm53bI1UrYnTMQ3sDR5oPmF
 jpBnl83QyPmz1s6OsjlN91cJ50KDWWWEVnU5yPvXAgktWGhwd/jAWJfHXs40SAar
 Ogo4WWh4RFCiYCMlrKX4N4veI8COOSJtLJt/jUjGsyCenxMNsdqIsIboTzYzf88k
 m6LK5MR6/K8W2/ydzZix1HwRPGZSUyQsTL4e+PBJ/TEXpHphOh4kbM50A==
Received: from bn1pr04cu002.outbound.protection.outlook.com
 (mail-eastus2azlp17010003.outbound.protection.outlook.com [40.93.12.3])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 40je8qsun4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 24 Jul 2024 00:52:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rhUtBmtVPZbUVGqFI4jJaO1m3uFZepPv9PzTM9nbCb8GwA7l1DW67SY4sT/TsdK18CTihI513ZwhpmJJwRLQY61QDM+o7F4y4YqcQvdAyhzXWSrM5sXV387aPkpwsIYyXva+uHnnM2ghU2/PDPeK1HUe4zv37mC30LZzzRcQC28xRDCTzO68rHgpcL0vjwBrRiQrx4KFnUvkoscJqK1zrl6QCOVwK/L5Eyn/NkP0a+oHDsTX0bV4ffIa4cVIyI5rbmMRRSq+4/3ie6InDYAfJYeLaffLWEhxj8t+0KjxQcp8567mdLto4EKaJpiYYUhdOp9pc8ccGf0mztnpeeTRNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2kCx+e8OofmsL+R+eOYRYFugEzk7I5ZAEnVjy95/0bo=;
 b=maAk8faPh4S8MMz2EHSNi9yXe135sLs4E2SXis/NgK8Ad6uq67MNsN3YTlLRx4d3Vlwzh3vDHUcE0xZVsRBN9MqcWsw4bpeO0z3DnmqqQfZk6kwK/L4em2Z+fpwOw6YomReesShS04qxGKz0X+/vrLTF36yxNqJN81nXUBZJiuc5YoZRoRq4H31ZDiqLKHUO9BS1OfemR+dTRGzWMBHmDEIeA3mdAG9FNgigwWxghDPPPg2D+2ga8VWVAz2NQTYv/smGOTzn/vgxyBBNB7hsgadWE2xVXChwmi/8nYM7butyV5Vi30SJVtN1zzNwfFRjsjFUZltADwde+dlfCdJVpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2kCx+e8OofmsL+R+eOYRYFugEzk7I5ZAEnVjy95/0bo=;
 b=eWbXaN/lqFDjrhd/rzS0qs3f1UXLgi4IxRb7K1P+Bbp6/+a9EMhiIve8BIU1UAGmBysCf34OeOqUNkDJGfMcfgR5DKvGIYlhxiVNEIsQf8T9RPCZMUVLxBokrJ6kSKemVYbudzFyhSVTYhjPZMIe+4MNudMMh+oZR9avWf+/ib/2ZAG1DYUhlZsKBc4RXTYk8xPpMSgS1JTmbfJar3V+fwjNaiIjz/oBq5prY2EkG+JjPADqCIGKhG1gqBPHVMnjVrABzy3UcV6bJbOez+oMTwYMRSk+dSbYNSPbD0gmJvPL2M2/VqGhfED5NCdiBqeH/8nWBig1wjgK4zCelisPYg==
Received: from PH0PR02MB7384.namprd02.prod.outlook.com (2603:10b6:510:12::12)
 by CH0PR02MB8166.namprd02.prod.outlook.com (2603:10b6:610:10b::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.19; Wed, 24 Jul
 2024 07:52:37 +0000
Received: from PH0PR02MB7384.namprd02.prod.outlook.com
 ([fe80::6bd7:e8f0:596a:4842]) by PH0PR02MB7384.namprd02.prod.outlook.com
 ([fe80::6bd7:e8f0:596a:4842%4]) with mapi id 15.20.7784.017; Wed, 24 Jul 2024
 07:52:37 +0000
From: "manish.mishra" <manish.mishra@nutanix.com>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, zhao1.liu@intel.com, pbonzini@redhat.com,
 bob.ball@nutanix.com, prerna.saxena@nutanix.com,
 john.levon@nutanix.com, Manish Mishra <manish.mishra@nutanix.com>
Subject: [PATCH v1] target/i386: Always set leaf 0x1f
Date: Wed, 24 Jul 2024 07:52:26 +0000
Message-Id: <20240724075226.212882-1-manish.mishra@nutanix.com>
X-Mailer: git-send-email 2.22.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0239.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::34) To PH0PR02MB7384.namprd02.prod.outlook.com
 (2603:10b6:510:12::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7384:EE_|CH0PR02MB8166:EE_
X-MS-Office365-Filtering-Correlation-Id: 851c0fa0-4572-46ae-f865-08dcabb59621
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VopE2r2XwdFbQ87zFkWzGnDz0oM16dnZTXvc+UkscdOmrt31zTbx8iSqDGIN?=
 =?us-ascii?Q?UrJHXvJcDw62jEGzyV7aBWmBBjTYkEQlnLOoTYYMUBpXmU+XXX7mE8NYe7p5?=
 =?us-ascii?Q?FmAqlJi0Yj/SWPmxRSq4UwPaxgF9ftNGFw1IOyBWmqMhz4zuOJhOoOaxcf35?=
 =?us-ascii?Q?C1zg2wPz9dnmxYiwnjM6awT0Oo1242En3tcMWmGCFK88KTQb1e98ZzUks9CO?=
 =?us-ascii?Q?FTlD13BQdY+7A9sGX/XUscRO/ITBMcrJfcJqSewN22/L8dR3+hYubd7od9f2?=
 =?us-ascii?Q?rEwr8inrc4Y9qiFh58Eu9Xl+84UbENKgH1L7Ly5g0Xa40IrHzUUubVs3EXJ4?=
 =?us-ascii?Q?Fxj0hsUUlf6wWBc8mI/rXAK9MsBjr7dBftzIaOgLzx8n/N3/dxJEobbSeWta?=
 =?us-ascii?Q?U5Ixqv3dCpCbcqa7eBq3urHfae6r7JwCTiNXh0i7zRNvNOGiA8d8YTzLzyn+?=
 =?us-ascii?Q?yVPY3Ov2EO72L/xFhKHKi5dB9mA0nmyHq+PC+QqibE6ZzDp4T5wPnJWzkHSr?=
 =?us-ascii?Q?aMd+GtZlI1TTnErly+Z/FlmO10dgLC56wahiwdzz9s0HHsi6BforqW4miDLf?=
 =?us-ascii?Q?Y/Y1B6HFB20KLIgZwmv7nIdCGJTB5p8KIYysQ3yT9IN30MgAVbu2+6HVlQE4?=
 =?us-ascii?Q?CLnQfRamEVw1rD6DaDmuDQZr3JO6xXL9Euj6Ul68tIlFWgW7ASDX7bHIxzmy?=
 =?us-ascii?Q?bTeuUP93ZIpBr6o+Cql1p0usfrrvghzgREjYGvrTMsSwiVNWqbrrTT0UmhJ2?=
 =?us-ascii?Q?mjsc0wn8mSPzdgHUxPn5oZ2P8bzCl1eJEK3sFWnzz/xIAH6DOEDAmuJuq92P?=
 =?us-ascii?Q?tnEH0bKhn0HN/SdEThLp4i3S1qKgQ34RKIcALmnFU5Ocvd/UYgyS7d3V9a5E?=
 =?us-ascii?Q?0fN6PN+Rs0fdK1UQN0d/XLDNWXcXcrsd5rGWW+y7sfztnEQ7yvUzdXr+8ZeO?=
 =?us-ascii?Q?JFlOjMkiyg+6u8HrCBy8IjhKRNbDh5jVw0l2xXCpirEdB+IWUTWfTWRxPmqf?=
 =?us-ascii?Q?cgrGuJKGFEeaPUhidPiC3L3NF/YvJK3KeK4pyfXjg5fyPBhp5Wc3yL1ObxUz?=
 =?us-ascii?Q?e6XilWWRk5jMA6TNO9kA4UvRt0nTBmB7v4nDUmddq5U7CWPl4pzO6AZT87EC?=
 =?us-ascii?Q?HFPgoh3ZNlOsnyahogt65eU0p4+a/IuiWFoOevdN4UaY7hlLb2x8qcuy323O?=
 =?us-ascii?Q?zOSLgpRQb3gWz1i1No0K2p0BCmj3bvK6P7JpSh3Ud6Bt1+cVw818N1WuFFhk?=
 =?us-ascii?Q?JbRKWBomxzoR8f8sZfiL+TMkKQmCCmuQBLV2qXh0AUYwdwlA1QMe71/eAFv/?=
 =?us-ascii?Q?2ODUEQM8EAiF6QWToLWchTGoZ6EAHLJcKOiPhom6U4cdU/Hxcq+2Ktwe4YOs?=
 =?us-ascii?Q?dalrgQvznaoJq8EoT5p30Br66oWemZ7ru08T5DiaYX3iFL8WcA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7384.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xYTA5EOZ3l9y+HFitHymWE+fJ1f4NwDQvzMsQiwWM82/oVpdc/5dNy6SgQEm?=
 =?us-ascii?Q?rmPPkOrUZHBIHHEEA2zXWJEI7pSKBP2CNZnQXWpAYdMoBjLac6XFALJxLIwz?=
 =?us-ascii?Q?eYC8P7hXESUjzfMZ+9UUBKIlQwF2AhGZ9Od4lNEnSOAL2advRKE+ZPLdfOPk?=
 =?us-ascii?Q?v+iZbx9Or+IEsMkchFdk9SVTEoFupSPJyK1qKO6Gtmo9ilpvxm12XES23Ge9?=
 =?us-ascii?Q?VYuEiDDoHoxYqB1CbGxlTK0a1vcND9bP+r6ScdOEx/KnjhxIgzCL5NXue7K+?=
 =?us-ascii?Q?Jxq9qaiX9MHotPSW3brAjcQ7UKNYNWNEyvjm0VnJFmAAWJoNC4lnxm8H523L?=
 =?us-ascii?Q?+AI55XqkuRIsZJJEB7FT0+RP1EsVVPga7sBOCHZuUv/HBptrwr0GEzsNPrf/?=
 =?us-ascii?Q?on0hFh5B3K7YNruve/J94CEttuC2Tk7IjpQoibpf56joKokPl84IVbCW6Nj8?=
 =?us-ascii?Q?U5iyH4jJ5U6L70KjYRTDL+LIflS9w0zx5B6st9RWa0XMxVvzlAvv10U0Ho33?=
 =?us-ascii?Q?KH1mZQepyrijuqOvyoZxfDPIMR+Z2QtI9jsjXfFGnkEHR5d1RV8/CdCkn2EK?=
 =?us-ascii?Q?79LiX214XayTSB7chG93ilemXWHu5mpEcrrsohuyBLyLQmfbZJeztQsrNeNK?=
 =?us-ascii?Q?k/2kK+BIwc1iE6wjNqfzoPoRQ2QuirkxA1nyawZzMl35SbJuUM8O8Rh9lJRL?=
 =?us-ascii?Q?asoADbQe+Es/YCmmSfk1k2Ze0RCnVlB18xJ3ZjQvmMlB8Pg+5dvP4302q04H?=
 =?us-ascii?Q?UJibZalVo+RSNnZaOEuxwwZCf147YabFORGfo8sLuwlVz9xFPweWkklobcLD?=
 =?us-ascii?Q?VYQW6RcQq9W+KkJdieclu1N+Slr+ECeZH0BUZt5kwA3zNk5h1kkXuo/5KWAT?=
 =?us-ascii?Q?BAmCs8LyTf9Sf2zssU2kqg7xenuCLFqnVwzc12bQgl8DhraNuGa7e9ytqiu+?=
 =?us-ascii?Q?Ex2LPv46uSrD6JWGdXw2HWTWihKZTuqTco2A/B3rap+cKDMbcM0JByhoWMIS?=
 =?us-ascii?Q?QhY/KF6o43iU210JqoPw3v1pWGvwiIeeezd4+6dYhQa9k4g1czvhYCd23oLT?=
 =?us-ascii?Q?NtYNwf1krsmLuERgZ6h83623Zezd1u+MKn/5O1oRisioyMWODaImufINbybW?=
 =?us-ascii?Q?yLHdtG6xGQuZa+HuVcECziFDa9D2M2dzR/7pp7ncDszUYbgbInCdXFHpVrm/?=
 =?us-ascii?Q?kNsi+rGH+HeC1/48MscuUfAc7T9qvqjANuj4QdzR6nxrmolV3KujBFwa48yy?=
 =?us-ascii?Q?RjKMfKsbEEVfz4LACDrHw5ewhLvqrN1H30SB5dN98pzLCMYnmnmR+A/maESh?=
 =?us-ascii?Q?niHO+GPawRJ+YMYN4iBAPYR52/4o6N09xVWMgVBN769s1eEBHIiDlQEwXKtc?=
 =?us-ascii?Q?JWQPSm20qJI/oo5rvPB7aLRYi5jMvYY5fyeKAJ4Elu02rHqrsXdOFfTF/mCJ?=
 =?us-ascii?Q?2MrB7oDNyV1xHX5p9LM9p/GVr9lC5WmFrTqFN3rJe0FWV5yYzz0StxhQytQ+?=
 =?us-ascii?Q?8mkymTxvWRlATFmAKMTWtyemEd6DeFb7aJCYhV4B2HLbUUcRVq93WHT8b5Uk?=
 =?us-ascii?Q?fnU9IaL7BS0qfZB6ge9Y2ZvliHzstb7sazmHTHOIl61pWs5pzcDnQlKceg/v?=
 =?us-ascii?Q?sA=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 851c0fa0-4572-46ae-f865-08dcabb59621
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7384.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2024 07:52:37.6848 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 835gGdXyt/xgB8g3QXDPOxtaKX+3KfHKXjsyLPxCcur3qYCeIf6eimK6/aafdSMuaZLIppgAaqazWNMUSLZmg3YtLE6rji6g0b1+fNP6tHc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR02MB8166
X-Proofpoint-GUID: AtV8QQwcUKBfk2bbxt-1yB-LidjHqBjR
X-Proofpoint-ORIG-GUID: AtV8QQwcUKBfk2bbxt-1yB-LidjHqBjR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-24_05,2024-07-23_02,2024-05-17_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=manish.mishra@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
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

From: Manish Mishra <manish.mishra@nutanix.com>

QEMU does not set 0x1f in case VM does not have extended CPU topology
and expects guests to fallback to 0xb. Some versions of Windows does not
like this behavior and expects this leaf to be populated. As a result Windows
VM fails with blue screen.

Leaf 0x1f is superset of 0xb, so it makes sense to set 0x1f equivalent
to 0xb by default and workaround windows issue. This change adds a
new property 'cpuid-0x1f-enforce' to set leaf 0x1f equivalent to 0xb in
case extended CPU topology is not configured and behave as before otherwise.

Steps to reproduce this issue:
This requires Windows 10 or 11 VM, with credential guard and HyperV role
enabled. Also this issue shows starting SapphireRapids which raised cpuid
level to 0x20, hence exposing 0x1f to guests.
./qemu-system-x86_64
-drive file=/usr/share/OVMF/OVMF_CODE_4MB.secboot.fd,if=pflash,format=raw,unit=0,readonly=on
-drive file=/usr/share/OVMF/OVMF_VARS_4MB.fd,if=pflash,format=raw
-machine pc-q35,smm=on
-global mch.extended-tseg-mbytes=80
-accel kvm
-m 2G
-cpu SapphireRapids-v1,invtsc=on,vmx=on
-smp 2,maxcpus=240,sockets=120,dies=1,cores=2,threads=1
-hda systest_ahv_win10_cg.qcow2

Signed-off-by: Manish Mishra <manish.mishra@nutanix.com>
---
 hw/i386/pc.c          | 1 +
 target/i386/cpu.c     | 7 +++++--
 target/i386/cpu.h     | 5 +++++
 target/i386/kvm/kvm.c | 4 +++-
 4 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index c74931d577..4cab04e443 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -85,6 +85,7 @@ GlobalProperty pc_compat_9_0[] = {
     { TYPE_X86_CPU, "guest-phys-bits", "0" },
     { "sev-guest", "legacy-vm-type", "on" },
     { TYPE_X86_CPU, "legacy-multi-node", "on" },
+    { TYPE_X86_CPU, "cpuid-0x1f-enforce", "false" },
 };
 const size_t pc_compat_9_0_len = G_N_ELEMENTS(pc_compat_9_0);
 
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 4688d140c2..7b71083bc9 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -6637,7 +6637,8 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
         break;
     case 0x1F:
         /* V2 Extended Topology Enumeration Leaf */
-        if (!x86_has_extended_topo(env->avail_cpu_topo)) {
+        if (!x86_has_extended_topo(env->avail_cpu_topo) &&
+            !cpu->enable_cpuid_0x1f_enforce) {
             *eax = *ebx = *ecx = *edx = 0;
             break;
         }
@@ -7450,7 +7451,8 @@ void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
          * cpu->vendor_cpuid_only has been unset for compatibility with older
          * machine types.
          */
-        if (x86_has_extended_topo(env->avail_cpu_topo) &&
+        if ((x86_has_extended_topo(env->avail_cpu_topo) ||
+             cpu->enable_cpuid_0x1f_enforce) &&
             (IS_INTEL_CPU(env) || !cpu->vendor_cpuid_only)) {
             x86_cpu_adjust_level(cpu, &env->cpuid_min_level, 0x1F);
         }
@@ -8316,6 +8318,7 @@ static Property x86_cpu_properties[] = {
     DEFINE_PROP_BOOL("full-cpuid-auto-level", X86CPU, full_cpuid_auto_level, true),
     DEFINE_PROP_STRING("hv-vendor-id", X86CPU, hyperv_vendor),
     DEFINE_PROP_BOOL("cpuid-0xb", X86CPU, enable_cpuid_0xb, true),
+    DEFINE_PROP_BOOL("cpuid-0x1f-enforce", X86CPU, enable_cpuid_0x1f_enforce, true),
     DEFINE_PROP_BOOL("x-vendor-cpuid-only", X86CPU, vendor_cpuid_only, true),
     DEFINE_PROP_BOOL("x-amd-topoext-features-only", X86CPU, amd_topoext_features_only, true),
     DEFINE_PROP_BOOL("lmce", X86CPU, enable_lmce, false),
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 1e121acef5..49c5641ba8 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2102,6 +2102,11 @@ struct ArchCPU {
     /* Compatibility bits for old machine types: */
     bool enable_cpuid_0xb;
 
+    /* Always return values for 0x1f leaf. In cases where extended CPU topology
+     * is not configured, return values equivalent of leaf 0xb.
+     */
+    bool enable_cpuid_0x1f_enforce;
+
     /* Enable auto level-increase for all CPUID leaves */
     bool full_cpuid_auto_level;
 
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index becca2efa5..a9c6f02900 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -1799,6 +1799,7 @@ static uint32_t kvm_x86_build_cpuid(CPUX86State *env,
     uint32_t limit, i, j;
     uint32_t unused;
     struct kvm_cpuid_entry2 *c;
+    X86CPU *cpu = env_archcpu(env);
 
     cpu_x86_cpuid(env, 0, 0, &limit, &unused, &unused, &unused);
 
@@ -1831,7 +1832,8 @@ static uint32_t kvm_x86_build_cpuid(CPUX86State *env,
             break;
         }
         case 0x1f:
-            if (!x86_has_extended_topo(env->avail_cpu_topo)) {
+            if (!x86_has_extended_topo(env->avail_cpu_topo) &&
+                !cpu->enable_cpuid_0x1f_enforce) {
                 cpuid_i--;
                 break;
             }
-- 
2.43.0


