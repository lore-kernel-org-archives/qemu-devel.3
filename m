Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CDB3CAC5A7
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 13:58:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v13Vi-0002QC-8v; Tue, 23 Sep 2025 09:56:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1v13Uu-0000CK-87; Tue, 23 Sep 2025 09:56:03 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1v13Ur-0004IY-3C; Tue, 23 Sep 2025 09:55:59 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 58N6wA1q4104506; Tue, 23 Sep 2025 06:55:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=Q5utNIIA3K4tEjbBGrodIidpkhki8qpho91kt8e7m
 rU=; b=RYr3gO8xDXk6iilEbZs12yLdseogsBNsAycGRJ6AafLLLx2mDyG6qaI/2
 kKrxWu1gOIdp8OV7zgFuq96uaGkGzM+IBR5qam4oN0YVX+5H10m/vT8mVqQxL9Wp
 EBU+Grf8718sQMDOo1pUmffsdwI1VZn4oFW6S4TNyTPaLhD+H8V8EVCq2rmpbgAq
 5i9aM7SVKXJ/Qi1QrriDhF8iFIalnQ9IaNE4b+ZtHSkuiw1D9E90rW6YW2cYqguf
 x6HfM2ZzztQbp0DG1Q4RgEfKorFy3BAmZTDQcJsvzxumpWYgvyTSDOE4Gwb13KrX
 MiXkge1q0xTaXDDV2ARKBDrKXAz7A==
Received: from ph7pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11020138.outbound.protection.outlook.com [52.101.201.138])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 49bb1fa8av-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 23 Sep 2025 06:55:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hodrcUHc1oYBA3NUDkVPoq0nQK/KygEqNVzEH0qsrSFP6HhKdjV0GKHpZ8WhBEAKxiwIqCMaufJoIyPJ1VulOQ6TO4TY1Q5fn7rtdR+EVeJuK5fQ3L+SCqFR8j/nD6gg+hrV1Q5YwJXoqvtRZY5owKWtLzM1u4gTECyoqrmUZE7ACs10MRy8j1XU38LoTs/hBAlKaMo19ggYh1Qqky3cBEJN6ddTRnt0q4KjMzD4DX5/M/lN3PEWmb8N+zIfEyVHEgKUSpXwW7z8K8xyvCHjLPi7NogZ1dm7zhxEcdZlT+9TKRt0C6GpQPv9CH8ULMnMZ3xjq0A0XJpHskoZojUxcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q5utNIIA3K4tEjbBGrodIidpkhki8qpho91kt8e7mrU=;
 b=Wul9+E4icP8g/7UrpPyR5GoJjUdca5IGy5XSK0O6uIuGBvLEwEsFREjCJUlZLeHS4w2nX+8Qhqk+1MzZlh4rbH1mZDG3TlKj91NZebqt30qlS606nKPcREBn7IuQtMoTfAGF4kRjZvbj6y4IQfLyMkFLXa2cXEF89tOaRsklK0HFNjjKyhUFcCIMu3wFDYET4Qir9FrBWQk4qj47zfe/73xz6gRqeUUSCkG2uc01EtVWUm8PurLLrUHWesmuqlMZ6uGqJwV4ZSptDzVtsKdKS0j934lcV1HJWhyc6ont512LZPrLzWOeA1D4H6n53NTFwKroyv5N5hPIyVgA2R4o7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q5utNIIA3K4tEjbBGrodIidpkhki8qpho91kt8e7mrU=;
 b=ZI90GgAK2Qc8y5KldkXETCABb2u5TbVzxcqExzKereLnZfdHdVvl6T1uJIXbF3zbUAP0zXtaF/zJS2vNXiWedReUPekwiBprrcbqB6ZxrVDFt/UBtyt9TLIcUwmmCPfZGwTnePf0diDDndht3jXvE0o5QwM2V8E8Awm72F7Nt/ECPsZQOnhn0AEuIzCflkXk4JE3VZVfeLm0itiWZKZFJLoXA2UXgJBSW2U8WTOSYzjN89TR/C8RYe4GWJ1VdsJtk0wlwkKi2lQJpgDEPwTO7lEWhy3FXb+lRGeq8DboqaE9nFjkzDoiYr21DtiomhkvL8PCr5EZbB+SsW+dDSWOBA==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by SJ0PR02MB7742.namprd02.prod.outlook.com (2603:10b6:a03:320::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Tue, 23 Sep
 2025 13:55:18 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%3]) with mapi id 15.20.9160.008; Tue, 23 Sep 2025
 13:55:18 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: npiggin@gmail.com, harshpb@linux.ibm.com, mjrosato@linux.ibm.com,
 farman@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 thuth@redhat.com, richard.henderson@linaro.org, david@redhat.com,
 iii@linux.ibm.com, john.levon@nutanix.com, thanos.makatos@nutanix.com,
 clg@redhat.com, alex.williamson@redhat.com, steven.sistare@oracle.com,
 qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH 22/27] vfio/pci.c: rename vfio_pci_nohotplug_dev_info to
 vfio_pci_nohotplug_info
Date: Tue, 23 Sep 2025 14:53:28 +0100
Message-ID: <20250923135352.1157250-23-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250923135352.1157250-1-mark.caveayland@nutanix.com>
References: <20250923135352.1157250-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR02CA0083.eurprd02.prod.outlook.com
 (2603:10a6:208:154::24) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|SJ0PR02MB7742:EE_
X-MS-Office365-Filtering-Correlation-Id: 97de9049-a063-4714-9339-08ddfaa8d442
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|10070799003|366016|1800799024|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2KsqilkAF1mixfTYbJFx2gdEQveinmf+fQE6PUkNprAKRvDuuKdplfu4vzKI?=
 =?us-ascii?Q?mvkZ72k/WE+Abzf+zkqjR4ZJyvKetnee87Bxnbp3jxov6NGbh7ed34AurUO7?=
 =?us-ascii?Q?NWXoi4ZVErew6m/TDi2NDaIi0iDxYnLZ7/zuHvM22HUPlMOHQxiCN9R3aXSI?=
 =?us-ascii?Q?pV3iz/eoY/XQY4n4OGmgj75P3irAjZCfblyFHhaPqdRlNEJascttI71L8a2v?=
 =?us-ascii?Q?Xn/jOtwdwZPBS0le0JoOBog8gSl3SfcnNjjv78Id0uqwNVrK0hgusYBXd6Rl?=
 =?us-ascii?Q?EM+nVN1pBvkgHJG35Ape+qyyG4zaNJaqc/QTPjhSMap4YBYXmt/SmkRXHcSz?=
 =?us-ascii?Q?LuqP9tyPbrBzlYlBPr++WIvJhsH5jZq+RnZXT8BULzEQaecpyzrFPJL2c8ZV?=
 =?us-ascii?Q?xfOTHQDAtGNZCyHaRt5X0y1DDooI5Mu06zFkq+7P82nwRofJJFCRAInmiWM9?=
 =?us-ascii?Q?EwdCay2k/OFGM3RrKkViLQWVekXjbsfdW48mWBCen37tXo1LRM96NZBamXzG?=
 =?us-ascii?Q?njxUnV33jeiI/xo/3I8y5FRkZZBEeO2gfVrUw0EO9gFgAI/9Bih/QCtSiyg4?=
 =?us-ascii?Q?rnVo70VNDqA5fqErsUnBIQXGU28wLz4ku2cuTCcbbtsFYYVS5U001F21yFxE?=
 =?us-ascii?Q?XhvdkCYSIS5/cKbUAtm/gEqLsRmdJ3webw8JVfa2tZkwuJ3Bl0hlKnyDKMgf?=
 =?us-ascii?Q?VPRuv1Z/ICXv2Id0NizeRLTi8d5Q4kjeEVBhl87qtz8cqf2rMRorlPcHLdFx?=
 =?us-ascii?Q?1RQxATrowraLrpxii/9ElSZ/PK/qg4JsWNHtuOcfGY+KV6POgeuHwrIao+hF?=
 =?us-ascii?Q?V0KBcCfW3apKsaOlhoVZlYuVxTa4g3SEf1KwoNZK/5lICkKvcSOBBA22tikV?=
 =?us-ascii?Q?h+PboCbuf4l4cgintEpwGhv1JKdDLzvBH5ipW08m4AMX4FDR9uavIf8msAPw?=
 =?us-ascii?Q?8vxdsgLfHx39DChSsheROce4Vh+xAuCbEklrKsKMHf5NKDhFKHUS0u7WuCvI?=
 =?us-ascii?Q?yLRCHgXf51aBbCj49VsqMbaeMgF7mTSkQMZLAR20tnCZHf2lWA6NBHuWV3bo?=
 =?us-ascii?Q?63AuE2XaBqmnfJDAO8R/WsL4p1MC3jV3PLcyTFUWKYRRruL8tVH7r31uAtCN?=
 =?us-ascii?Q?Afz4J9a5GyyDGW6XBqk9n/s/Gxhvk7b0YIA3vwsSropp8p7O3vZ+sHYVo4hd?=
 =?us-ascii?Q?+FUNJ6tIOCqJBxJrXvsXtj+I3iAAreVZ4XSYRrWJL1rAk/WkXnzXnjpUo8VN?=
 =?us-ascii?Q?kpWFyE01RLsVcJiDr6lp7Ee4Urh1YkR7amkpm6S6uB6MzPcndfs6ur4OlW5j?=
 =?us-ascii?Q?bcnc+dhzTsaRiOO8/qqQ2rqn4PXzKv0RP9R9vThlx4sbP0vgorWuCubKRU3P?=
 =?us-ascii?Q?NLYtp8tA/mSTiXW+HIuf+UFxFfHBTf+tHw/408cUuJUmg0B74rDCKTfJwiQA?=
 =?us-ascii?Q?T4xYroOwWOSwpWGEwL1p6Vl8jNqfHnf7VsSjerECuTa5fBp0EqmbGg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(10070799003)(366016)(1800799024)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xo/xaCOAsvK3Cm81lNhq98RdEPYcrJGRilZwmNz1rGhSbIf4It0MQ642So/k?=
 =?us-ascii?Q?ITnV430XxQqoa90hRvN3sLokr/IbgPgEtpYUo/sVnOb0mKijsMAz+ahCZeYd?=
 =?us-ascii?Q?i+4+wMkWp2OF5OwdoaqO0MuEfDLf52Z+n9si6OwrX+ihtItVtIHIorYDKn9l?=
 =?us-ascii?Q?RdqpxQjkTCP1pGmlWMfr94OKXiGZpRlukOJtrDDbCJdAo21QJ2HL3dtjN1hK?=
 =?us-ascii?Q?55A5719u+hbJjyHFT9BYjH9tZ/xwxZ330HaiS1JqAVxoYFixZD9RpBgYQcmB?=
 =?us-ascii?Q?nRbX/ZZBHBrdE8h/yB1ApWWl9i7gAHK4kyaZxl4HanC+iC1HwLlvH+o18tjX?=
 =?us-ascii?Q?XnUW6tnmKe5kEaqMUMk+5F92jKmj5hICHi/wSo8CF88gIntwBigaZzIjM7jw?=
 =?us-ascii?Q?MaabGIspJpyzZ9Swz8Ol2BIytte5LwWYbgb6mvkfKH8veEucET/gYiwqYNNi?=
 =?us-ascii?Q?7mh1s6Uo8l8pRKKx9Zzv09tn87DD1ahDwfUR0rtONxWrQt8fs7htGXWZobN0?=
 =?us-ascii?Q?rbYxc9SCsIehrDLkEjR3ar5OTzOBzvXeX7YFGaIgefYfGl55MyqMt8R/ZSUR?=
 =?us-ascii?Q?1IkyB6mFIhR0Ndh+flqWi/ux5TekdwPtwJnnv+oJBS7VA/hKg24bQef0KxqR?=
 =?us-ascii?Q?dV7ukzGZrnnhAuobZo2gjMgjVsOT2HCXwCKtsI1TdthKPWVonghk0WFm0vVp?=
 =?us-ascii?Q?4s3gEfVGsvVXV/7LmSOkpXDLGd+6qBgG4sY7P4KSqzxo1ZuRdAbOi8Vo6r9H?=
 =?us-ascii?Q?mvYadqu5+067dhNHn3fAX8pah9kpXuMe1FZ60+1p2BBAWtbeSPMYiEIZTZYe?=
 =?us-ascii?Q?zdUhbCZhaqZ1oc98S07eUC9+jQdopHhOozF1VQpDbpFSoxFlo6Xmz+PrQRsS?=
 =?us-ascii?Q?iCr17BR8226mUdU4EDlcmyRWSFGoAnmUyQgGbGUDJHTfm2Ju50T3qK1oO226?=
 =?us-ascii?Q?JNhrY53f2nOb0P+BQ0CI/+7YRnAgs0f2HtM6SCM3sBNC63Psl8E1VQ6iSG0B?=
 =?us-ascii?Q?uoPHJpph4F2pgrizCM3qWsSXFmjw0gRqNqX1sgRcldJiX0EkTOiasCzTcQDh?=
 =?us-ascii?Q?PSpfnj5gz/Go42fN3G0dzor/yO33OA15ufXj4oEmCqYUIyKUbFrckQgb+PbK?=
 =?us-ascii?Q?21+bcpcskCIapcg35ZHhz4u5H/xU8VF2kvb0uLovrV49Tzbc1QE2iX0xIglE?=
 =?us-ascii?Q?74rFamHCjyXk9RhdBuFDT87Kn/G9keNAfbLytz6Qifa/RPSUeKZqzQbyQ9ot?=
 =?us-ascii?Q?EjvQ6iY+5ZgxFXcrAGEIznsM6iVgxFmgXnlab5z5/TdknwRyI8bjdIsNPEWF?=
 =?us-ascii?Q?lg3nYoHOUqZQCo3sXRK7qFqnatXfff0MnJW0AMju2E8Xw1/8MWXN7P0BIt8C?=
 =?us-ascii?Q?iC5tl1OlCsH8Ga+CEI8uzMB8MeQiqrmRlRJ2CtkWu8nIqS6fnNlITpKRIZK+?=
 =?us-ascii?Q?IZZYLbANHOEVxukey+fNIK8929K8ekiz5Wy7Mt9W2jfM6OwPd5iSeDHPk53f?=
 =?us-ascii?Q?LqBRKc5YUkZg9VlEPyNIGmir7hzQmomAeH6D+uh75JdTQfkO8lDz7UMkrkEH?=
 =?us-ascii?Q?c67Po5KRM46JyKx16UhVq1Iaz/I00AMDcCcpTVBqgfbP64FQvCrCxemjOYOg?=
 =?us-ascii?Q?oquF95Fxx8Xi5nsEjhcEgIKClzSxOE312j4DjAnuEn1NcScq4np/059cPxgR?=
 =?us-ascii?Q?EZ2eUw=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97de9049-a063-4714-9339-08ddfaa8d442
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 13:55:18.0076 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tTGCB9fh9F5I8zJ4+zycLL+48sKzLMjd+Nm+sjmU0uuziYR9osdHJVs0XJg7pGPLDXJh9Wpg/b+oOUNcAybiBL+/nCQTyELoJ+0ao1QGE68=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7742
X-Authority-Analysis: v=2.4 cv=C5PpyRP+ c=1 sm=1 tr=0 ts=68d2a6c7 cx=c_pps
 a=jcumTT0saVzx4HVuorHqQw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10 a=0kUYKlekyDsA:10 a=64Cc0HZtAAAA:8
 a=-an67RP_g-7o1LT8KO4A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIzMDEyOCBTYWx0ZWRfX81Pjb8Bntuh+
 zfl/5h7d6d+P1HbjgsN4di8Pqe6R9RzOGFpEq0U5H0vzVrjPe49J2YLW9qWzCbven0bIW3EqMKW
 LM3fE8o7chvg+5dafVexWik35PPUho8SKPRYDBnBfqTrpEHwF2FTJ92NwdlbJS9Ha+OfZf2pWV3
 wb+esxsG2HBPFz0Cj7iR8yHrOLyrK7D8lCmDzuqoNLAIY+W0TqbOF9DJsZGKcau5z/ZwB+8ojUo
 tuyAZKikZpqaTr/zIDr3e8rlX7ILIHm/xXYlghToTFX+PSt+T7JY9truG68AqlOpeadRXhBXbD9
 kUU29Qm09moXmqnW3U5hrHtiRyavvmDz2R4et3PafUnWyMRfs4MJuM4P2fyGGs=
X-Proofpoint-GUID: eJgWzu3RRc_UmNo_j3uzL2vi2m7v82aG
X-Proofpoint-ORIG-GUID: eJgWzu3RRc_UmNo_j3uzL2vi2m7v82aG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-23_03,2025-09-22_05,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

This changes the prefix to match the name of the QOM type.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 hw/vfio/pci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index ec60bc3907..356b3de83a 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -3953,7 +3953,7 @@ static void vfio_pci_nohotplug_class_init(ObjectClass *klass,
                                           "Controls loading of a legacy VGA BIOS ROM");
 }
 
-static const TypeInfo vfio_pci_nohotplug_dev_info = {
+static const TypeInfo vfio_pci_nohotplug_info = {
     .name = TYPE_VFIO_PCI_NOHOTPLUG,
     .parent = TYPE_VFIO_PCI,
     .instance_size = sizeof(VFIOPCIDevice),
@@ -3975,7 +3975,7 @@ static void register_vfio_pci_dev_type(void)
 
     type_register_static(&vfio_pci_device_info);
     type_register_static(&vfio_pci_info);
-    type_register_static(&vfio_pci_nohotplug_dev_info);
+    type_register_static(&vfio_pci_nohotplug_info);
 }
 
 type_init(register_vfio_pci_dev_type)
-- 
2.43.0


