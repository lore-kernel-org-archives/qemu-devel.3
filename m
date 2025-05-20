Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FE87C3DA6D
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 15:10:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHOWl-0003LE-Tc; Tue, 20 May 2025 11:05:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uHOWk-0003KM-49
 for qemu-devel@nongnu.org; Tue, 20 May 2025 11:05:10 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uHOWg-0002fI-Gf
 for qemu-devel@nongnu.org; Tue, 20 May 2025 11:05:09 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54K7UjtK019012;
 Tue, 20 May 2025 08:05:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=/6thz8mv5WudgYGT/kAXdl+hYA4wu+ATfm2j8D4Vx
 lo=; b=ziiqXKxEBmgOhtp2nUydGZZ/Btp99co5CID6gYwK5o3Ua4H+TPu9Fvo59
 1VQa7pvzrAw6TgeGsaqsw8j16FjWhbpJz/7cczIFEjPG5PPzWvsryl3FWSp11DY1
 HziwXKVY9u4p3tY5O3PRJpxrNoo9YzCEaWkbn0hXmhdeJHoNwUksgHWyBW28wRTm
 ch12yqm3+8/vR8B1JnJT3JGCoVHXlbqa3Trz+E3SxQOhjN2wzSjAGHqp/oh9ZxBk
 pmwMtsIfbcpfzOKTCwNOYUOwbHyZwEY/XlPgBEaWwE7u9PwzKtR6VjP/GWgORbaO
 r+lMiEsdIRvtJD6qQUb1CQT7W5e4g==
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2174.outbound.protection.outlook.com [104.47.58.174])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 46pshhebwy-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 20 May 2025 08:05:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YFqu3j0+xte3+fN9N1X0ZH0J3iQjYqHlfM2ULRORxHXunH8dk3oxPml0zfHt2sMbscsLR1XkuGsbkErWoidPnaSOpOTidhqUKav6xZbXuNNzDaCj8Ph6qJGpTpIfFgE/UbHjWlYBTT3zNNleexa9C2CD8dLeVzqnb8GYsJD9TYLCIVOeb+vpAnCqMUxOJNjXIumMyA6XmlG4q1y3UdOUwwQRft3p0aB8wD7tKhKdFK65TpBAP3VQ3RvjSBRKnawdE7zJaqTEayTKDpv+d4fXhDqpE2pHu/rgYQnU3XefTVQhIzB5kKQalqbKoNw5v0vjwIO5JmE/cU/TmsMHb6dFFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/6thz8mv5WudgYGT/kAXdl+hYA4wu+ATfm2j8D4Vxlo=;
 b=YpOQymsf4BMNhOFBOVy5k7XIrdzXg13zsDPPjD0usjfhH2JqxlXOvNygsZysgHMQ/Eo5YIhVx37Y7NktRn2mUEQpnwdGfX19rDdMtngI534AAcfjOrZMo6N+BcsBfPSh85avhjgXKN1Oc/SZoMuZair/OwXBhssHw2dvx0MmcBDtCKzLcphQ95NTPiDIt0wt4ksyX1uOP4Y5fGF8tKo0AOx2T4s3mobck0wFjMHNZVBiLpVpPCzSgtn+nRlDtPw9s9QzULwVBzlwdsvB0lWy0iKnSwU27G/NHDQ8pkhEtHtv16viqGgxGtYOlMwS1j53Uh6JwQEgVaVU33Q12GG3oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/6thz8mv5WudgYGT/kAXdl+hYA4wu+ATfm2j8D4Vxlo=;
 b=yzff6775TIdJbcX5QUsKIa+cPW4McqMQmiiz7zLie4ExMuOIuDan4QpU/MLSDLJwgRjODjSLMUUDHzlD8WD8c79t8wFuN3hGRhb4Xo/qjYdFRsCMJWNAR1d/Y9P/ELaZ71P4md2U3WHLCvItj2rB62tIU1fO8LwmvxFWi6Ngj+5wD1QxCyScHeBLYxV6BoKEbneXVKhrIynt4jqjWdGSZwUd9zfxxfzNjHd1yQnC1Df/IJd1RGns5APClvfsQBwc9mEJHsbRZI7UK1JGekJTRNlSyzqf/hNHeyUSirseoOcdlXl3D71smi+TtwhFNnd8NUtccbU8IkSjtPet/hjhQA==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by SA1PR02MB8462.namprd02.prod.outlook.com (2603:10b6:806:1f6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.23; Tue, 20 May
 2025 15:05:02 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%6]) with mapi id 15.20.8769.016; Tue, 20 May 2025
 15:05:02 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Levon <john.levon@nutanix.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 John Johnson <john.g.johnson@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>
Subject: [PATCH v2 15/29] vfio-user: implement message send infrastructure
Date: Tue, 20 May 2025 16:04:04 +0100
Message-ID: <20250520150419.2172078-16-john.levon@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250520150419.2172078-1-john.levon@nutanix.com>
References: <20250520150419.2172078-1-john.levon@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM9P193CA0021.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:21e::26) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|SA1PR02MB8462:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d0833f7-85ff-4101-d355-08dd97afb211
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?mHC4y3JlJHAJGwIj4qsqYPchPLotH7snnw0LpP+4Z47+gSBEHK7JXtekqSKS?=
 =?us-ascii?Q?EpB2uIx+UDnLhT5IhWgfilikAiI9GIcr24NVFCV3/EgNB8Bwk5tnTn8VP6sT?=
 =?us-ascii?Q?eAdhzwjCBjcxJMj/8+33l0H5ECWbw8oQTdiMrFDoQKYJ7HqyTo9Q5J1hKS7Q?=
 =?us-ascii?Q?LZlzWAR6lqm1QBgj6AkSTOkXoPhmSqLlFSbNUEBSHSZj1PbWW5YYzid5qgw6?=
 =?us-ascii?Q?9Wlmlr9TFlrRKz1A4MK05XddP0hseRxRPZUtPYViaXVlADEAm/IYd1gzvfam?=
 =?us-ascii?Q?u1UpdWVO8BK3IpvO5E8h0xfbMcmERygZkIBhBQB3Qom7LssRVwAEUdJa8hgm?=
 =?us-ascii?Q?tkWf0VLT23AXsdfjboziGtceZ/kf29V3Rqcbcj7EXcvtGIrZYh4gjvfEZMsv?=
 =?us-ascii?Q?Y49tZbvXeQ0nFo1g36h+Y/mzV3VEAMlKk90jA0KFVscoa/jVg2xu6viBLa5f?=
 =?us-ascii?Q?pIm8rh/kjwG6zrOSESRP38AKqxt+gu/A2HFzfpj0iNMp3IPcUJk6ayP+hwJ8?=
 =?us-ascii?Q?YqkZP3sEzS6qDF8KJKaQJGy1sWjnK4EM6ZbOSb6UTeV0ss3qTsUMSmufOKYs?=
 =?us-ascii?Q?WMh5xJzg8PJvrMe/VMAWud1MrMhn29Fh2qd6KX+vQA2qXYt6vaNeQeQpKcxF?=
 =?us-ascii?Q?rmiJfSp2NzQThhEo00/vqc9OWGkFp4Ot0XGcF53X5E8otFYyKFstHlBLXer4?=
 =?us-ascii?Q?PvoPtjo/Tme660+vE83MeIt3c3dvWJSUx+r6AAXwHaEHHXT6iohQCyCLv92v?=
 =?us-ascii?Q?Dv0PwKdZJMjkAlbYSa5zZ8PveZVjktit2Su0xJru8XuogQLsQGt7HqRyNaFh?=
 =?us-ascii?Q?dmIRrfFi4ld3Tkh19rR7j2mmGYU7zfdtwcDlWVCZcc5yvGbVfC67glK38NWG?=
 =?us-ascii?Q?Vt4EKTeH1gwc7+axuhp4s+fzwpWQF/piOzkAJa0/Yy43OjxipKatxLpQcgQR?=
 =?us-ascii?Q?Ba3bbzablO+cTIO/OBSlTdRHdpRaIo3+ao7EiF8kuChn/T4BNAa/hdrRoKw0?=
 =?us-ascii?Q?knrGiab5pmQRWwKepz798o0Kw4V+70WdkUSJ6dVw+tmSx0aNLgGuHRNDjOGC?=
 =?us-ascii?Q?v5oSsqd7dKzouWpsigBeRZ9GdeM6XNv/UK7Dx4NFflgbstzZ0u+dCzpmmwxK?=
 =?us-ascii?Q?LeihsD7hhZzBXbM9Quf0Wswvap0uNQjfUlCzQSzrOcLA1bJ2ouHQcn61myRL?=
 =?us-ascii?Q?SFxLOht/QGFi5lqWPxUPVt8Rb4vPd5Zk/CHKzPaK1i47lOplPY0pDxpzGN5v?=
 =?us-ascii?Q?pLHcARp8fn5CQdhIn+J3sZ9n1lr9Btp5gdOLl25nPRY0cgfjC9iSl+5JnQJM?=
 =?us-ascii?Q?G0fCkwzXfPd0ILBG4pI3+BZ/QkBrESlwcBr0pxJphshl4aiI0XxZ580CtWrZ?=
 =?us-ascii?Q?h1P8ECrlhn3w0+ODqdGZp6HfLzPrx/d299mnGbERSZ1lRxB3jpr27JbJW1hG?=
 =?us-ascii?Q?//2x/brmyoc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Q09kOhqqQjITyWL5hDQfJ50+VOiUzXqclChXBdjjR4FHiChA+joDq4IAG2kJ?=
 =?us-ascii?Q?2pq/svmn/o+m7PGBgu7558khqYzedxhIAfNpqWPtlJQ2kvdOGLFp7MMugysK?=
 =?us-ascii?Q?dLTWT/NyIcnOyiriOPFi62g4xoLKEEo/pG6V+YfXrOwxFsi/7+6VgQUA1+ga?=
 =?us-ascii?Q?DehYbrs5zd8o4xYyhny9ddemmr4t/Um2AHGmOwftH2ACuK6A4pz2wrtQl1P0?=
 =?us-ascii?Q?1taQe/k4QKx7Oz70zdYDCL3VO0ZNREgKNYtwPTTHRKsp0wdiH7tw2gSJk0CQ?=
 =?us-ascii?Q?FXqkbjawq1prdUwMCw75/46BhSW4KAxEj58+/WGq/jMRaL2789Rg9Azt6AKq?=
 =?us-ascii?Q?lC188WA5sIHaJJ0lNK7ihRbXraeQpqbaMjQeK4+e7giJn2U08lCH8p988LNi?=
 =?us-ascii?Q?VCxBgQhpXxrMQraMvYzIiiHr+CVwe0PpeDxttUOG5HxiBEwUw8xTRiC20kav?=
 =?us-ascii?Q?mqIKu9AvDz0+XA2yRlwHXGZXVPp1lDLiMyEUkTjkddXXShj9IPRCcHCUPeMv?=
 =?us-ascii?Q?eURxQUzAK1hgsYKKAFJsleZSa18KAFIU/+Tc+Udk+r7OTzKuaevP0WmauvmW?=
 =?us-ascii?Q?WqxciKiODhuIOz17oo6XexKJXWeXgwO/nPn1DkoAHO0ZZkwnElqBTOJ5z9TQ?=
 =?us-ascii?Q?aGQiCMD7AR2hkiXqnFc8Ih5HZzH+nDQy68j5ZXEh3Zw1Y178ulnxdUeDMJpo?=
 =?us-ascii?Q?V8JBBEL/0lhAv5Xanxz/C0XRJtAIl/WvTEjYGd3liNw5N0ZYUtI6UucWGjSZ?=
 =?us-ascii?Q?UClLpLAbXLQj6v4y4DCkn56Z0cjP9g1aISysIWMZcsi2cQ5L3vIPMfeWniFO?=
 =?us-ascii?Q?qW7FwYE0OLkr2QmJo9YU/SIFfLLuvx+H6/3Rg+M5Y94nrTZ4eTp/42bv2FJt?=
 =?us-ascii?Q?jI6vr5n3HqGKyHxz0vOCGSd33+e4h060XNeETSkvmr8UJXeXnf8TMNnvAbo0?=
 =?us-ascii?Q?kwkpIWGQIK6Gfa2dwbJZAuJNl6jJYXB6SyggMDrJHdqwH4G6rQpc/aOLvHiQ?=
 =?us-ascii?Q?l3FZxv+ARWvMLB0IM92pbtGJ0L+k3pgYnLhKIvaSeHO8hDxNEfV88FY5G7Ev?=
 =?us-ascii?Q?LQ7c6oPleC2L/QyZrsBzbNYpdvz77LC018SaBO788Lbx9omklBZ77RaKomCi?=
 =?us-ascii?Q?6sLTLClzLg4/MykWGl8fWhZ+OuSxNWsT1JBOminvzLY/bluUdF4YpQCRiNGt?=
 =?us-ascii?Q?EXzRnF6uURZviD7+a7N7q3s+cnPfbRTAkjsMqfh6j4GYZlxSocBqgy5hgR7N?=
 =?us-ascii?Q?m5Wv5Jhfp1v4rKIqQBzqgI4oSX05fxMXXYqqjwi3ovooXgughL1P6Slzcnhy?=
 =?us-ascii?Q?M8Nx7LkdUzOTJFiy0p5nsgGqlH3t0+pvwuUJrj683kS6z98VOqS0A+MPjvUT?=
 =?us-ascii?Q?mPBWX1XOWlhE8c8uiZLZAPti8GboTckfRR4Jc6ODl1FA/7eYsDZDEZEM7B1V?=
 =?us-ascii?Q?ZxmATgstP4QK2TivXvKHRP2U2k2moYXRugSwBvotML7ugb/7+NCwIQWa8lUk?=
 =?us-ascii?Q?QezJ/YgkkqfB9lHbzN57IDq84JXxFmjci/5LbNMuvQJBFdS1cKeFRfjGByoa?=
 =?us-ascii?Q?pTCBBPh5XLeOkz7LSj6tuLH5foOcbahTG45d4xnM?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d0833f7-85ff-4101-d355-08dd97afb211
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2025 15:05:02.1984 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sdHSBA83RHp2hGPtdLiV8RSYYVM20lHaK/Bj7f8GJhLBmE6LInZ1BPU9f4IwYA62tAJMvUjDAyODT29U1OosTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR02MB8462
X-Proofpoint-GUID: MJcSBucSAXwF9ySeQCGHJuIgDmytng0K
X-Authority-Analysis: v=2.4 cv=SoaQ6OO0 c=1 sm=1 tr=0 ts=682c9a1f cx=c_pps
 a=qvBKVd3KFl3zkoLf5jvq7Q==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=dt9VzEwgFbYA:10
 a=0kUYKlekyDsA:10 a=yPCof4ZbAAAA:8 a=64Cc0HZtAAAA:8 a=UnscCpd6-9sbi9RN3AUA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIwMDEyMiBTYWx0ZWRfX9zg61XqQmIPq
 ftjBTnfScROibV94G8s45k/4WH1Y4OszeTCyY8bhGymKoBXpgYMXVB4YKE7joQaVGsybXn9I0DM
 WXXGT+jIRE9UjqmIDWqS8x2WCLTd3B1Hl3k5zW7w3vxZCR+sYrdtYKemjXVleeSXeh4ZbOo8hBe
 BEW5oESr+IVpcY3d3FEb8NG8TgYO9nHyWeeX46dRoaIWEdgfiuFqHMFBBek1m5VuyFrbKBniLiJ
 PDPk9NEQJ3D/efl9Q5rjX++9KOPejbSzZ+tCDzxrIB/0nHhZxoqC6w7ALtL2ulTIb4D96z/nd50
 969HRXv3Dwzn8OeL3JbXx3VRnimbXbh629PZ9R0oSZ8O3ISbeGHpVnN3s8i3TGJMfGYq0vuVCa5
 bZzRXUTi4yLBey16PbgbCyvTbzSTkS86DCtxngDzVTT/vTu5qLCLU5iJe0sMBT1qnUcTQj7z
X-Proofpoint-ORIG-GUID: MJcSBucSAXwF9ySeQCGHJuIgDmytng0K
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-20_06,2025-05-20_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=john.levon@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.487,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Add plumbing for sending vfio-user messages on the control socket.
Add initial version negotation on connection.

Originally-by: John Johnson <john.g.johnson@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: John Levon <john.levon@nutanix.com>
---
 hw/vfio-user/protocol.h   |  62 +++++
 hw/vfio-user/proxy.h      |   9 +
 hw/vfio-user/pci.c        |  18 +-
 hw/vfio-user/proxy.c      | 494 ++++++++++++++++++++++++++++++++++++++
 hw/vfio-user/trace-events |   2 +
 5 files changed, 583 insertions(+), 2 deletions(-)

diff --git a/hw/vfio-user/protocol.h b/hw/vfio-user/protocol.h
index 6300c681e7..74ea2a94e6 100644
--- a/hw/vfio-user/protocol.h
+++ b/hw/vfio-user/protocol.h
@@ -53,4 +53,66 @@ enum vfio_user_command {
 #define VFIO_USER_NO_REPLY      0x10
 #define VFIO_USER_ERROR         0x20
 
+
+/*
+ * VFIO_USER_VERSION
+ */
+typedef struct {
+    VFIOUserHdr hdr;
+    uint16_t major;
+    uint16_t minor;
+    char capabilities[];
+} VFIOUserVersion;
+
+#define VFIO_USER_MAJOR_VER     0
+#define VFIO_USER_MINOR_VER     0
+
+#define VFIO_USER_CAP           "capabilities"
+
+/* "capabilities" members */
+#define VFIO_USER_CAP_MAX_FDS   "max_msg_fds"
+#define VFIO_USER_CAP_MAX_XFER  "max_data_xfer_size"
+#define VFIO_USER_CAP_PGSIZES   "pgsizes"
+#define VFIO_USER_CAP_MAP_MAX   "max_dma_maps"
+#define VFIO_USER_CAP_MIGR      "migration"
+
+/* "migration" members */
+#define VFIO_USER_CAP_PGSIZE            "pgsize"
+#define VFIO_USER_CAP_MAX_BITMAP        "max_bitmap_size"
+
+/*
+ * Max FDs mainly comes into play when a device supports multiple interrupts
+ * where each ones uses an eventfd to inject it into the guest.
+ * It is clamped by the the number of FDs the qio channel supports in a
+ * single message.
+ */
+#define VFIO_USER_DEF_MAX_FDS   8
+#define VFIO_USER_MAX_MAX_FDS   16
+
+/*
+ * Max transfer limits the amount of data in region and DMA messages.
+ * Region R/W will be very small (limited by how much a single instruction
+ * can process) so just use a reasonable limit here.
+ */
+#define VFIO_USER_DEF_MAX_XFER  (1024 * 1024)
+#define VFIO_USER_MAX_MAX_XFER  (64 * 1024 * 1024)
+
+/*
+ * Default pagesizes supported is 4k.
+ */
+#define VFIO_USER_DEF_PGSIZE    4096
+
+/*
+ * Default max number of DMA mappings is stolen from the
+ * linux kernel "dma_entry_limit"
+ */
+#define VFIO_USER_DEF_MAP_MAX   65535
+
+/*
+ * Default max bitmap size is also take from the linux kernel,
+ * where usage of signed ints limits the VA range to 2^31 bytes.
+ * Dividing that by the number of bits per byte yields 256MB
+ */
+#define VFIO_USER_DEF_MAX_BITMAP (256 * 1024 * 1024)
+
 #endif /* VFIO_USER_PROTOCOL_H */
diff --git a/hw/vfio-user/proxy.h b/hw/vfio-user/proxy.h
index 0105479d02..33e8a4d83b 100644
--- a/hw/vfio-user/proxy.h
+++ b/hw/vfio-user/proxy.h
@@ -40,6 +40,7 @@ typedef struct VFIOUserMsg {
     uint32_t id;
     QemuCond cv;
     bool complete;
+    bool pending;
     enum msg_type type;
 } VFIOUserMsg;
 
@@ -59,6 +60,12 @@ typedef struct VFIOUserProxy {
     struct QIOChannel *ioc;
     void (*request)(void *opaque, VFIOUserMsg *msg);
     void *req_arg;
+    uint64_t max_xfer_size;
+    uint64_t max_send_fds;
+    uint64_t max_dma;
+    uint64_t dma_pgsizes;
+    uint64_t max_bitmap;
+    uint64_t migr_pgsize;
     int flags;
     QemuCond close_cv;
     AioContext *ctx;
@@ -81,6 +88,7 @@ typedef struct VFIOUserProxy {
 
 /* VFIOProxy flags */
 #define VFIO_PROXY_CLIENT        0x1
+#define VFIO_PROXY_FORCE_QUEUED  0x4
 
 typedef struct VFIODevice VFIODevice;
 
@@ -89,5 +97,6 @@ void vfio_user_disconnect(VFIOUserProxy *proxy);
 void vfio_user_set_handler(VFIODevice *vbasedev,
                            void (*handler)(void *opaque, VFIOUserMsg *msg),
                            void *reqarg);
+bool vfio_user_validate_version(VFIOUserProxy *proxy, Error **errp);
 
 #endif /* VFIO_USER_PROXY_H */
diff --git a/hw/vfio-user/pci.c b/hw/vfio-user/pci.c
index 894130b575..391864412c 100644
--- a/hw/vfio-user/pci.c
+++ b/hw/vfio-user/pci.c
@@ -22,6 +22,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(VFIOUserPCIDevice, VFIO_USER_PCI)
 struct VFIOUserPCIDevice {
     VFIOPCIDevice device;
     char *sock_name;
+    bool send_queued;   /* all sends are queued */
 };
 
 /*
@@ -81,6 +82,14 @@ static void vfio_user_pci_realize(PCIDevice *pdev, Error **errp)
     vbasedev->proxy = proxy;
     vfio_user_set_handler(vbasedev, vfio_user_pci_process_req, vdev);
 
+    if (udev->send_queued) {
+        proxy->flags |= VFIO_PROXY_FORCE_QUEUED;
+    }
+
+    if (!vfio_user_validate_version(proxy, errp)) {
+        goto error;
+    }
+
     vbasedev->name = g_strdup_printf("VFIO user <%s>", udev->sock_name);
 
     /*
@@ -92,9 +101,13 @@ static void vfio_user_pci_realize(PCIDevice *pdev, Error **errp)
     if (!vfio_device_attach_by_iommu_type(TYPE_VFIO_IOMMU_USER,
                                           vbasedev->name, vbasedev,
                                           as, errp)) {
-        error_prepend(errp, VFIO_MSG_PREFIX, vbasedev->name);
-        return;
+        goto error;
     }
+
+    return;
+
+error:
+    error_prepend(errp, VFIO_MSG_PREFIX, vdev->vbasedev.name);
 }
 
 static void vfio_user_instance_init(Object *obj)
@@ -145,6 +158,7 @@ static const Property vfio_user_pci_dev_properties[] = {
     DEFINE_PROP_UINT32("x-pci-sub-device-id", VFIOPCIDevice,
                        sub_device_id, PCI_ANY_ID),
     DEFINE_PROP_STRING("socket", VFIOUserPCIDevice, sock_name),
+    DEFINE_PROP_BOOL("x-send-queued", VFIOUserPCIDevice, send_queued, false),
 };
 
 static void vfio_user_pci_dev_class_init(ObjectClass *klass, const void *data)
diff --git a/hw/vfio-user/proxy.c b/hw/vfio-user/proxy.c
index 4a654d7597..0bc12da865 100644
--- a/hw/vfio-user/proxy.c
+++ b/hw/vfio-user/proxy.c
@@ -16,14 +16,19 @@
 #include "hw/vfio-user/proxy.h"
 #include "hw/vfio-user/trace.h"
 #include "qapi/error.h"
+#include "qobject/qdict.h"
+#include "qobject/qjson.h"
+#include "qobject/qnum.h"
 #include "qemu/error-report.h"
 #include "qemu/lockable.h"
 #include "qemu/main-loop.h"
 #include "system/iothread.h"
 
+static int wait_time = 5000;   /* wait up to 5 sec for busy servers */
 static IOThread *vfio_user_iothread;
 
 static void vfio_user_shutdown(VFIOUserProxy *proxy);
+static int vfio_user_send_qio(VFIOUserProxy *proxy, VFIOUserMsg *msg);
 static VFIOUserMsg *vfio_user_getmsg(VFIOUserProxy *proxy, VFIOUserHdr *hdr,
                                      VFIOUserFDs *fds);
 static VFIOUserFDs *vfio_user_getfds(int numfds);
@@ -31,9 +36,16 @@ static void vfio_user_recycle(VFIOUserProxy *proxy, VFIOUserMsg *msg);
 
 static void vfio_user_recv(void *opaque);
 static int vfio_user_recv_one(VFIOUserProxy *proxy);
+static void vfio_user_send(void *opaque);
+static int vfio_user_send_one(VFIOUserProxy *proxy);
 static void vfio_user_cb(void *opaque);
 
 static void vfio_user_request(void *opaque);
+static int vfio_user_send_queued(VFIOUserProxy *proxy, VFIOUserMsg *msg);
+static void vfio_user_send_wait(VFIOUserProxy *proxy, VFIOUserHdr *hdr,
+                                VFIOUserFDs *fds, int rsize);
+static void vfio_user_request_msg(VFIOUserHdr *hdr, uint16_t cmd,
+                                  uint32_t size, uint32_t flags);
 
 static inline void vfio_user_set_error(VFIOUserHdr *hdr, uint32_t err)
 {
@@ -52,6 +64,35 @@ static void vfio_user_shutdown(VFIOUserProxy *proxy)
                                    proxy->ctx, NULL, NULL);
 }
 
+static int vfio_user_send_qio(VFIOUserProxy *proxy, VFIOUserMsg *msg)
+{
+    VFIOUserFDs *fds =  msg->fds;
+    struct iovec iov = {
+        .iov_base = msg->hdr,
+        .iov_len = msg->hdr->size,
+    };
+    size_t numfds = 0;
+    int ret, *fdp = NULL;
+    Error *local_err = NULL;
+
+    if (fds != NULL && fds->send_fds != 0) {
+        numfds = fds->send_fds;
+        fdp = fds->fds;
+    }
+
+    ret = qio_channel_writev_full(proxy->ioc, &iov, 1, fdp, numfds, 0,
+                                  &local_err);
+
+    if (ret == -1) {
+        vfio_user_set_error(msg->hdr, EIO);
+        vfio_user_shutdown(proxy);
+        error_report_err(local_err);
+    }
+    trace_vfio_user_send_write(msg->hdr->id, ret);
+
+    return ret;
+}
+
 static VFIOUserMsg *vfio_user_getmsg(VFIOUserProxy *proxy, VFIOUserHdr *hdr,
                                      VFIOUserFDs *fds)
 {
@@ -92,6 +133,7 @@ static void vfio_user_recycle(VFIOUserProxy *proxy, VFIOUserMsg *msg)
     msg->hdr = NULL;
     msg->fds = NULL;
     msg->complete = false;
+    msg->pending = false;
     QTAILQ_INSERT_HEAD(&proxy->free, msg, next);
 }
 
@@ -386,6 +428,54 @@ err:
     return -1;
 }
 
+/*
+ * Send messages from outgoing queue when the socket buffer has space.
+ * If we deplete 'outgoing', remove ourselves from the poll list.
+ */
+static void vfio_user_send(void *opaque)
+{
+    VFIOUserProxy *proxy = opaque;
+
+    QEMU_LOCK_GUARD(&proxy->lock);
+
+    if (proxy->state == VFIO_PROXY_CONNECTED) {
+        while (!QTAILQ_EMPTY(&proxy->outgoing)) {
+            if (vfio_user_send_one(proxy) < 0) {
+                return;
+            }
+        }
+        qio_channel_set_aio_fd_handler(proxy->ioc, proxy->ctx,
+                                       vfio_user_recv, NULL, NULL, proxy);
+    }
+}
+
+/*
+ * Send a single message.
+ *
+ * Sent async messages are freed, others are moved to pending queue.
+ */
+static int vfio_user_send_one(VFIOUserProxy *proxy)
+{
+    VFIOUserMsg *msg;
+    int ret;
+
+    msg = QTAILQ_FIRST(&proxy->outgoing);
+    ret = vfio_user_send_qio(proxy, msg);
+    if (ret < 0) {
+        return ret;
+    }
+
+    QTAILQ_REMOVE(&proxy->outgoing, msg, next);
+    if (msg->type == VFIO_MSG_ASYNC) {
+        vfio_user_recycle(proxy, msg);
+    } else {
+        QTAILQ_INSERT_TAIL(&proxy->pending, msg, next);
+        msg->pending = true;
+    }
+
+    return 0;
+}
+
 static void vfio_user_cb(void *opaque)
 {
     VFIOUserProxy *proxy = opaque;
@@ -447,6 +537,119 @@ static void vfio_user_request(void *opaque)
     }
 }
 
+/*
+ * Messages are queued onto the proxy's outgoing list.
+ *
+ * It handles 3 types of messages:
+ *
+ * async messages - replies and posted writes
+ *
+ * There will be no reply from the server, so message
+ * buffers are freed after they're sent.
+ *
+ * nowait messages - map/unmap during address space transactions
+ *
+ * These are also sent async, but a reply is expected so that
+ * vfio_wait_reqs() can wait for the youngest nowait request.
+ * They transition from the outgoing list to the pending list
+ * when sent, and are freed when the reply is received.
+ *
+ * wait messages - all other requests
+ *
+ * The reply to these messages is waited for by their caller.
+ * They also transition from outgoing to pending when sent, but
+ * the message buffer is returned to the caller with the reply
+ * contents.  The caller is responsible for freeing these messages.
+ *
+ * As an optimization, if the outgoing list and the socket send
+ * buffer are empty, the message is sent inline instead of being
+ * added to the outgoing list.  The rest of the transitions are
+ * unchanged.
+ *
+ * returns 0 if the message was sent or queued
+ * returns -1 on send error
+ */
+static int vfio_user_send_queued(VFIOUserProxy *proxy, VFIOUserMsg *msg)
+{
+    int ret;
+
+    /*
+     * Unsent outgoing msgs - add to tail
+     */
+    if (!QTAILQ_EMPTY(&proxy->outgoing)) {
+        QTAILQ_INSERT_TAIL(&proxy->outgoing, msg, next);
+        return 0;
+    }
+
+    /*
+     * Try inline - if blocked, queue it and kick send poller
+     */
+    if (proxy->flags & VFIO_PROXY_FORCE_QUEUED) {
+        ret = QIO_CHANNEL_ERR_BLOCK;
+    } else {
+        ret = vfio_user_send_qio(proxy, msg);
+    }
+    if (ret == QIO_CHANNEL_ERR_BLOCK) {
+        QTAILQ_INSERT_HEAD(&proxy->outgoing, msg, next);
+        qio_channel_set_aio_fd_handler(proxy->ioc, proxy->ctx,
+                                       vfio_user_recv, proxy->ctx,
+                                       vfio_user_send, proxy);
+        return 0;
+    }
+    if (ret == -1) {
+        return ret;
+    }
+
+    /*
+     * Sent - free async, add others to pending
+     */
+    if (msg->type == VFIO_MSG_ASYNC) {
+        vfio_user_recycle(proxy, msg);
+    } else {
+        QTAILQ_INSERT_TAIL(&proxy->pending, msg, next);
+        msg->pending = true;
+    }
+
+    return 0;
+}
+
+static void vfio_user_send_wait(VFIOUserProxy *proxy, VFIOUserHdr *hdr,
+                                VFIOUserFDs *fds, int rsize)
+{
+    VFIOUserMsg *msg;
+    int ret;
+
+    if (hdr->flags & VFIO_USER_NO_REPLY) {
+        error_printf("vfio_user_send_wait on async message\n");
+        vfio_user_set_error(hdr, EINVAL);
+        return;
+    }
+
+    qemu_mutex_lock(&proxy->lock);
+
+    msg = vfio_user_getmsg(proxy, hdr, fds);
+    msg->id = hdr->id;
+    msg->rsize = rsize ? rsize : hdr->size;
+    msg->type = VFIO_MSG_WAIT;
+
+    ret = vfio_user_send_queued(proxy, msg);
+
+    if (ret == 0) {
+        while (!msg->complete) {
+            if (!qemu_cond_timedwait(&msg->cv, &proxy->lock, wait_time)) {
+                VFIOUserMsgQ *list;
+
+                list = msg->pending ? &proxy->pending : &proxy->outgoing;
+                QTAILQ_REMOVE(list, msg, next);
+                vfio_user_set_error(hdr, ETIMEDOUT);
+                break;
+            }
+        }
+    }
+    vfio_user_recycle(proxy, msg);
+
+    qemu_mutex_unlock(&proxy->lock);
+}
 
 static QLIST_HEAD(, VFIOUserProxy) vfio_user_sockets =
     QLIST_HEAD_INITIALIZER(vfio_user_sockets);
@@ -475,6 +678,15 @@ VFIOUserProxy *vfio_user_connect_dev(SocketAddress *addr, Error **errp)
     proxy = g_malloc0(sizeof(VFIOUserProxy));
     proxy->sockname = g_strdup_printf("unix:%s", sockname);
     proxy->ioc = ioc;
+
+    /* init defaults */
+    proxy->max_xfer_size = VFIO_USER_DEF_MAX_XFER;
+    proxy->max_send_fds = VFIO_USER_DEF_MAX_FDS;
+    proxy->max_dma = VFIO_USER_DEF_MAP_MAX;
+    proxy->dma_pgsizes = VFIO_USER_DEF_PGSIZE;
+    proxy->max_bitmap = VFIO_USER_DEF_MAX_BITMAP;
+    proxy->migr_pgsize = VFIO_USER_DEF_PGSIZE;
+
     proxy->flags = VFIO_PROXY_CLIENT;
     proxy->state = VFIO_PROXY_CONNECTED;
 
@@ -572,3 +784,285 @@ void vfio_user_disconnect(VFIOUserProxy *proxy)
     g_free(proxy->sockname);
     g_free(proxy);
 }
+
+static void vfio_user_request_msg(VFIOUserHdr *hdr, uint16_t cmd,
+                                  uint32_t size, uint32_t flags)
+{
+    static uint16_t next_id;
+
+    hdr->id = qatomic_fetch_inc(&next_id);
+    hdr->command = cmd;
+    hdr->size = size;
+    hdr->flags = (flags & ~VFIO_USER_TYPE) | VFIO_USER_REQUEST;
+    hdr->error_reply = 0;
+}
+
+struct cap_entry {
+    const char *name;
+    bool (*check)(VFIOUserProxy *proxy, QObject *qobj, Error **errp);
+};
+
+static bool caps_parse(VFIOUserProxy *proxy, QDict *qdict,
+                       struct cap_entry caps[], Error **errp)
+{
+    QObject *qobj;
+    struct cap_entry *p;
+
+    for (p = caps; p->name != NULL; p++) {
+        qobj = qdict_get(qdict, p->name);
+        if (qobj != NULL) {
+            if (!p->check(proxy, qobj, errp)) {
+                return false;
+            }
+            qdict_del(qdict, p->name);
+        }
+    }
+
+    /* warning, for now */
+    if (qdict_size(qdict) != 0) {
+        warn_report("spurious capabilities");
+    }
+    return true;
+}
+
+static bool check_migr_pgsize(VFIOUserProxy *proxy, QObject *qobj, Error **errp)
+{
+    QNum *qn = qobject_to(QNum, qobj);
+    uint64_t pgsize;
+
+    if (qn == NULL || !qnum_get_try_uint(qn, &pgsize)) {
+        error_setg(errp, "malformed %s", VFIO_USER_CAP_PGSIZE);
+        return false;
+    }
+
+    /* must be larger than default */
+    if (pgsize & (VFIO_USER_DEF_PGSIZE - 1)) {
+        error_setg(errp, "pgsize 0x%"PRIx64" too small", pgsize);
+        return false;
+    }
+
+    proxy->migr_pgsize = pgsize;
+    return true;
+}
+
+static bool check_bitmap(VFIOUserProxy *proxy, QObject *qobj, Error **errp)
+{
+    QNum *qn = qobject_to(QNum, qobj);
+    uint64_t bitmap_size;
+
+    if (qn == NULL || !qnum_get_try_uint(qn, &bitmap_size)) {
+        error_setg(errp, "malformed %s", VFIO_USER_CAP_MAX_BITMAP);
+        return false;
+    }
+
+    /* can only lower it */
+    if (bitmap_size > VFIO_USER_DEF_MAX_BITMAP) {
+        error_setg(errp, "%s too large", VFIO_USER_CAP_MAX_BITMAP);
+        return false;
+    }
+
+    proxy->max_bitmap = bitmap_size;
+    return true;
+}
+
+static struct cap_entry caps_migr[] = {
+    { VFIO_USER_CAP_PGSIZE, check_migr_pgsize },
+    { VFIO_USER_CAP_MAX_BITMAP, check_bitmap },
+    { NULL }
+};
+
+static bool check_max_fds(VFIOUserProxy *proxy, QObject *qobj, Error **errp)
+{
+    QNum *qn = qobject_to(QNum, qobj);
+    uint64_t max_send_fds;
+
+    if (qn == NULL || !qnum_get_try_uint(qn, &max_send_fds) ||
+        max_send_fds > VFIO_USER_MAX_MAX_FDS) {
+        error_setg(errp, "malformed %s", VFIO_USER_CAP_MAX_FDS);
+        return false;
+    }
+    proxy->max_send_fds = max_send_fds;
+    return true;
+}
+
+static bool check_max_xfer(VFIOUserProxy *proxy, QObject *qobj, Error **errp)
+{
+    QNum *qn = qobject_to(QNum, qobj);
+    uint64_t max_xfer_size;
+
+    if (qn == NULL || !qnum_get_try_uint(qn, &max_xfer_size) ||
+        max_xfer_size > VFIO_USER_MAX_MAX_XFER) {
+        error_setg(errp, "malformed %s", VFIO_USER_CAP_MAX_XFER);
+        return false;
+    }
+    proxy->max_xfer_size = max_xfer_size;
+    return true;
+}
+
+static bool check_pgsizes(VFIOUserProxy *proxy, QObject *qobj, Error **errp)
+{
+    QNum *qn = qobject_to(QNum, qobj);
+    uint64_t pgsizes;
+
+    if (qn == NULL || !qnum_get_try_uint(qn, &pgsizes)) {
+        error_setg(errp, "malformed %s", VFIO_USER_CAP_PGSIZES);
+        return false;
+    }
+
+    /* must be larger than default */
+    if (pgsizes & (VFIO_USER_DEF_PGSIZE - 1)) {
+        error_setg(errp, "pgsize 0x%"PRIx64" too small", pgsizes);
+        return false;
+    }
+
+    proxy->dma_pgsizes = pgsizes;
+    return true;
+}
+
+static bool check_max_dma(VFIOUserProxy *proxy, QObject *qobj, Error **errp)
+{
+    QNum *qn = qobject_to(QNum, qobj);
+    uint64_t max_dma;
+
+    if (qn == NULL || !qnum_get_try_uint(qn, &max_dma)) {
+        error_setg(errp, "malformed %s", VFIO_USER_CAP_MAP_MAX);
+        return false;
+    }
+
+    /* can only lower it */
+    if (max_dma > VFIO_USER_DEF_MAP_MAX) {
+        error_setg(errp, "%s too large", VFIO_USER_CAP_MAP_MAX);
+        return false;
+    }
+
+    proxy->max_dma = max_dma;
+    return true;
+}
+
+static bool check_migr(VFIOUserProxy *proxy, QObject *qobj, Error **errp)
+{
+    QDict *qdict = qobject_to(QDict, qobj);
+
+    if (qdict == NULL) {
+        error_setg(errp, "malformed %s", VFIO_USER_CAP_MAX_FDS);
+        return true;
+    }
+    return caps_parse(proxy, qdict, caps_migr, errp);
+}
+
+static struct cap_entry caps_cap[] = {
+    { VFIO_USER_CAP_MAX_FDS, check_max_fds },
+    { VFIO_USER_CAP_MAX_XFER, check_max_xfer },
+    { VFIO_USER_CAP_PGSIZES, check_pgsizes },
+    { VFIO_USER_CAP_MAP_MAX, check_max_dma },
+    { VFIO_USER_CAP_MIGR, check_migr },
+    { NULL }
+};
+
+static bool check_cap(VFIOUserProxy *proxy, QObject *qobj, Error **errp)
+{
+   QDict *qdict = qobject_to(QDict, qobj);
+
+    if (qdict == NULL) {
+        error_setg(errp, "malformed %s", VFIO_USER_CAP);
+        return false;
+    }
+    return caps_parse(proxy, qdict, caps_cap, errp);
+}
+
+static struct cap_entry ver_0_0[] = {
+    { VFIO_USER_CAP, check_cap },
+    { NULL }
+};
+
+static bool caps_check(VFIOUserProxy *proxy, int minor, const char *caps,
+                       Error **errp)
+{
+    QObject *qobj;
+    QDict *qdict;
+    bool ret;
+
+    qobj = qobject_from_json(caps, NULL);
+    if (qobj == NULL) {
+        error_setg(errp, "malformed capabilities %s", caps);
+        return false;
+    }
+    qdict = qobject_to(QDict, qobj);
+    if (qdict == NULL) {
+        error_setg(errp, "capabilities %s not an object", caps);
+        qobject_unref(qobj);
+        return false;
+    }
+    ret = caps_parse(proxy, qdict, ver_0_0, errp);
+
+    qobject_unref(qobj);
+    return ret;
+}
+
+static GString *caps_json(void)
+{
+    QDict *dict = qdict_new();
+    QDict *capdict = qdict_new();
+    QDict *migdict = qdict_new();
+    GString *str;
+
+    qdict_put_int(migdict, VFIO_USER_CAP_PGSIZE, VFIO_USER_DEF_PGSIZE);
+    qdict_put_int(migdict, VFIO_USER_CAP_MAX_BITMAP, VFIO_USER_DEF_MAX_BITMAP);
+    qdict_put_obj(capdict, VFIO_USER_CAP_MIGR, QOBJECT(migdict));
+
+    qdict_put_int(capdict, VFIO_USER_CAP_MAX_FDS, VFIO_USER_MAX_MAX_FDS);
+    qdict_put_int(capdict, VFIO_USER_CAP_MAX_XFER, VFIO_USER_DEF_MAX_XFER);
+    qdict_put_int(capdict, VFIO_USER_CAP_PGSIZES, VFIO_USER_DEF_PGSIZE);
+    qdict_put_int(capdict, VFIO_USER_CAP_MAP_MAX, VFIO_USER_DEF_MAP_MAX);
+
+    qdict_put_obj(dict, VFIO_USER_CAP, QOBJECT(capdict));
+
+    str = qobject_to_json(QOBJECT(dict));
+    qobject_unref(dict);
+    return str;
+}
+
+bool vfio_user_validate_version(VFIOUserProxy *proxy, Error **errp)
+{
+    g_autofree VFIOUserVersion *msgp = NULL;
+    GString *caps;
+    char *reply;
+    int size, caplen;
+
+    caps = caps_json();
+    caplen = caps->len + 1;
+    size = sizeof(*msgp) + caplen;
+    msgp = g_malloc0(size);
+
+    vfio_user_request_msg(&msgp->hdr, VFIO_USER_VERSION, size, 0);
+    msgp->major = VFIO_USER_MAJOR_VER;
+    msgp->minor = VFIO_USER_MINOR_VER;
+    memcpy(&msgp->capabilities, caps->str, caplen);
+    g_string_free(caps, true);
+    trace_vfio_user_version(msgp->major, msgp->minor, msgp->capabilities);
+
+    vfio_user_send_wait(proxy, &msgp->hdr, NULL, 0);
+    if (msgp->hdr.flags & VFIO_USER_ERROR) {
+        error_setg_errno(errp, msgp->hdr.error_reply, "version reply");
+        return false;
+    }
+
+    if (msgp->major != VFIO_USER_MAJOR_VER ||
+        msgp->minor > VFIO_USER_MINOR_VER) {
+        error_setg(errp, "incompatible server version");
+        return false;
+    }
+
+    reply = msgp->capabilities;
+    if (reply[msgp->hdr.size - sizeof(*msgp) - 1] != '\0') {
+        error_setg(errp, "corrupt version reply");
+        return false;
+    }
+
+    if (!caps_check(proxy, msgp->minor, reply, errp)) {
+        return false;
+    }
+
+    trace_vfio_user_version(msgp->major, msgp->minor, msgp->capabilities);
+    return true;
+}
diff --git a/hw/vfio-user/trace-events b/hw/vfio-user/trace-events
index 89d6c11c4c..7a3645024f 100644
--- a/hw/vfio-user/trace-events
+++ b/hw/vfio-user/trace-events
@@ -4,3 +4,5 @@
 vfio_user_recv_hdr(const char *name, uint16_t id, uint16_t cmd, uint32_t size, uint32_t flags) " (%s) id 0x%x cmd 0x%x size 0x%x flags 0x%x"
 vfio_user_recv_read(uint16_t id, int read) " id 0x%x read 0x%x"
 vfio_user_recv_request(uint16_t cmd) " command 0x%x"
+vfio_user_send_write(uint16_t id, int wrote) " id 0x%x wrote 0x%x"
+vfio_user_version(uint16_t major, uint16_t minor, const char *caps) " major %d minor %d caps: %s"
-- 
2.43.0


