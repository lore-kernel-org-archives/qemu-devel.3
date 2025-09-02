Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CAC4CA1005
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 17:01:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utUO1-0002Ew-W6; Tue, 02 Sep 2025 13:01:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1utUNa-0001Qg-PZ
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 13:01:13 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1utUNV-0006ma-Cg
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 13:01:07 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 582Gb61U3048030; Tue, 2 Sep 2025 10:01:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=S0BVXxZf4roSOWtmt4v2jGkMrrodQ/eGbo/R+5Luk
 J4=; b=iy8+B98KuwPC+iuop4a4bMKj/TZxJaZHQ4cDtuuZOtdo1C0FapP9s82hE
 Z37bP6uWHR9gA89XSikNH3DB6AsSGaMviB8CmWsd8oxQLE+qPrAMC8e71A6ZVMGN
 4VyYIFLf8WDKZWieObAS33anZi+9AsNygv65LQ585PaFaAhiT82lpe3PzuUidEkw
 LUEg0ckQIM2VnnL5AD6QK2DpuMkW/1jCbrbS6Ne0GPvp4GJvnS2N5jT5oIDiZ3aD
 cZ8HGhMnKYopiYLwETLFCr+M7+bvFKQgoQfivoW8e/D3BfEpD7SUk13pg3txM2w2
 u+L7fsPFvbxMZSUvvQW38G5ubgzYA==
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2122.outbound.protection.outlook.com [40.107.92.122])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 48ww8h94qe-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 02 Sep 2025 10:01:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JzJgg5zhPf9kafb+39YXQc3R0gE+wKDPuZHRxAfu9k1C0Lar40y0KY2zDQfRuirZ1gUWJIxFXSijh8w+S6zPk0RAXGxJnDN8UAFz1sqJRgZefDj6KkYyMEqu4eCN/wEpegF84Qj+1U6DfOJlMizCnvPgcaGssuRZuyiIKYVku/X3eRq7ygYgRHr/HbwuO2dKoBz4iBigiz3xwqQvENte5HQbuDntZNoVQg3nPcQtlhvMBoHSerqGkQBF9rzLPYaOsaivcc6tRjpo9gOe2hy5KzxAyY+FBoAxbMP6FcXoFb2kQL31R/Ns5WRYWuixNV5sw1vSLe/NkTE0CzA60dknvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SnuEReQXXVobqqmXpgfKm73SKgwHdNZjoRrPznbwYyY=;
 b=M00JjRFdnakkw44tPCKfNUm4BxsccQn+E+74HTRV2k+TdyhdV+bAbBA3FTEY1JsGtWYb3g+Mh43j/JG7xmfwMy9dQr3tCD5Ka/KnU6mRKMP6uGqEAajA54cvhIxMGkSjX2TbkBwjc+9bvthycxbMeJXO0FuMOFS8BVJekUmCO6sh+JaU3nV/RrUyBuKwnNSdHfNAHDTvArtkwIx3wKiBso0zWLIerIFSHdkksha+tOh8aHR3MOvphCwP/nTozHcIHm/SH4X3Tq6RWi3RRPe9UsebkHa8I2fCQ6CMpxEr3AFIcSm7jDrq4rXz3Sie+AjIhl9MxXR9el5cGF0eCrhw7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SnuEReQXXVobqqmXpgfKm73SKgwHdNZjoRrPznbwYyY=;
 b=oca0jRyi5KeRNvc6HqfyZvyMGYCIm4sDuyB1IgwgCqwpsPQW8CYsejrSY5ZVTLLFV6pHvD2OkExOkP9o+24mWAI3/BDG3a8o7S/H9aVyLjVhdwb2HrwSzXM8jmlkSO+9eVmDlLaF5SsY6KSCV1+wMCzkvzMG2GGch00CB93UKcpA3XKHzqbzaQVU2bKi6eQ4caa4Dn0JpXrw2i2VjCZX8jn1oGms8TmsaL46HKz1tFPgDdSZVkjvXR0SL0I+Cr8w3hUFH+4lnxiY02WybQ4S5O8UrgALrS8yxlawZ9oOwemw5BJXpma0ovA8kINPGaRLUSy5OjOQ72/FDwPNJnvmWw==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by SJ0PR02MB7167.namprd02.prod.outlook.com (2603:10b6:a03:297::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.29; Tue, 2 Sep
 2025 17:01:00 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%7]) with mapi id 15.20.9052.027; Tue, 2 Sep 2025
 17:01:00 +0000
Date: Tue, 2 Sep 2025 18:00:56 +0100
From: John Levon <john.levon@nutanix.com>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>
Subject: Re: [PATCH 3/4] docs/system: drop vhost-user-rng docs
Message-ID: <aLciyCOUIrEwQHOF@lent>
References: <20250902165048.1653323-1-alex.bennee@linaro.org>
 <20250902165048.1653323-4-alex.bennee@linaro.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250902165048.1653323-4-alex.bennee@linaro.org>
X-Url: http://www.movementarian.org/
X-ClientProxiedBy: AS4P191CA0052.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:657::25) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|SJ0PR02MB7167:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d6ab088-29d5-4e14-8979-08ddea424af3
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?whPDkmt6KE6xclnatvJv+UgUf2W/QqW/xqOGiluSxWO24+5xpuWIhRoABU?=
 =?iso-8859-1?Q?u0ja7XFJfRuNcyVOgbvqCwqVUAg0eQa+yokl4yYOkZDFGhNvfhA5IeN90k?=
 =?iso-8859-1?Q?hhb4wrwpgU2phyf450dakH159VKKoxCfa818eEWwCAvrv/e3j/uGvmoHRH?=
 =?iso-8859-1?Q?KzRPR9oeaXMHXsUL1bT2ba4vtVZjeuPoptmlunjEGYKh2Wbd6+594vyHhV?=
 =?iso-8859-1?Q?nbf+37wjf/X4RM/3NHiNiw7lwAf/J00C4gCvxy6zI2bgskO+dRJ12mXbCx?=
 =?iso-8859-1?Q?DaEsMh2gbclzte1gVpEKVmvsfJ44CqUIrQVAUQmvdwpOaoj8rRbjLKNyPA?=
 =?iso-8859-1?Q?DlaY6bNkQ5gRLJtovMhBvDXlhAK1diD4rRpyTlMZvBARy0Vx5iWrxqy2oA?=
 =?iso-8859-1?Q?XKXokA66ctlaKjGJpKFYsBr4/UKh7QPWrPpgOVog3cMMAyEfaWQtCsXYnF?=
 =?iso-8859-1?Q?zBhBMrU0Tn5yQaPVhFqGkKkOVrt8/a8OO+QNRIhIJd0HqTWxbC916WHWHu?=
 =?iso-8859-1?Q?ihMf5yB+nBROHg1BhlaXw8sIHDxEh+E8EgyLDqEldpXY4iFQcUISMsdgdz?=
 =?iso-8859-1?Q?jDunLKuhF+qBqDGxG5tTIVQYu7hmCPjXZdpY1ytoCG4J46LF4UjlLfAncG?=
 =?iso-8859-1?Q?UKnxCg70Fb2sTJtjvEBw7MmuamDpc7G7HqrZkmmjHcUAbzb2gvVIqbBnTY?=
 =?iso-8859-1?Q?EXUkhdi21hyE65irUzh1Ne9Bn+ysx4Y4VPTEXHN45LTNMpyTyRJR9UWYYY?=
 =?iso-8859-1?Q?vYQcp0mxESXl8G+4iaqKTPy8EX81Dlu36JlTx5Ec+sgmckvb8zZDF9pZdQ?=
 =?iso-8859-1?Q?Ffhsqo9/CvuVCV2zaC9svBy7Jvsm+7fVunnhVGvWFjymQZZEbfcuOCB4Oo?=
 =?iso-8859-1?Q?gq63/bhe+WTOoNt0OLE/HuVgAymM0Ze76xbUhGBCBc0GSIUEUY9JOS/uCK?=
 =?iso-8859-1?Q?5foJ1QNUP6v4Hlly5Nw57tB39HSFGBelLWE868w1p50crMqXz6BhM7RtbA?=
 =?iso-8859-1?Q?xYH37SA977dOfPeIUnGAnIOkZBL3Y3rux/F0wdyAVTxFLjcYkfk0DfTmTH?=
 =?iso-8859-1?Q?ohoMCHz+F6oC+eiVJAy0qd4PRVcqEb1yCK1oILvQynoU8YSpufKyGQUYKV?=
 =?iso-8859-1?Q?xxjrsLUP48ebHnl+/juWJ6KeTJx41EGlgMhVIXlF80D7OQ/nKF2KA/aZlf?=
 =?iso-8859-1?Q?hgLWRoE5C7o9y1S6NWpmP/RCyCTKtjJ5GuC0PHgW2M3Wdi+3r2wSnLkdmH?=
 =?iso-8859-1?Q?bEC8J+VXinaMMZMPVrp/VG6QBFsSxLIY559vIyp8O5JvwxY0utPJXeL6bN?=
 =?iso-8859-1?Q?gGaM9vxgwCvcfy1YiNb/dFoNltdxl3rSI202duvunK6oSQrPmFRjvmrH+u?=
 =?iso-8859-1?Q?2DmBv53RJ5mjyTf4c6jfmqnbWS8tTkZu+N6P+GJT8DjSekZcOblL96coTr?=
 =?iso-8859-1?Q?ELXSC84bMdm89EYER1As5xWx0KN8VmwME3VVCBKJTF2V804UwbVp9DWFXk?=
 =?iso-8859-1?Q?4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?JVNHOp/XvRP8pbpN3BGJyc63HEn7JTZz5xZZiVZCXJAURwQac91t7mOqj9?=
 =?iso-8859-1?Q?TD35JQwOSePEs3DNF1FJ4Fq4alAphqFTqVFPuVYzzr9ahpxgmIYwY7axjx?=
 =?iso-8859-1?Q?5Db1h54iiMc7xthz/JCu8UcR8HqGOvEKNukJoZPaaRV4VJ4Q+2vtsWU3GS?=
 =?iso-8859-1?Q?qL+//OkwjTanFjnexjFkqhj9q+m7ADkOvtTymFDHJfVxSlYnFxXjuv1YwA?=
 =?iso-8859-1?Q?jAuB5O4AnCqz9sVZt0ze76guMjMFPmnrG7TEjAUObe+kUBNlA8ocyiSIzK?=
 =?iso-8859-1?Q?b76shQGUv51m271ee8yceIO3ae1WTjc2rN1z6hHI7SeP6QEvSto5HvdpyK?=
 =?iso-8859-1?Q?FRzyzobzEMZhSrHf/mmjBMUbW0H7I5CaCMmvbDztMeBIRKo44bY3CrQCIA?=
 =?iso-8859-1?Q?mYuT8fWjN5NVkg7mbiPcjZCD9EC/L791HMG2A9+TphUlzcJgSaQii0ym7S?=
 =?iso-8859-1?Q?ZZ2wiBUSU0PStd9NGpg83vHnAYuwG36JBUb3SuxTWLRXTAKpKZCaFBA/Us?=
 =?iso-8859-1?Q?nMF1f7BzlgTVPbyXfl4bxZO2Ua/R8jx3N9H0QLr9mkA/gQvYFgWpBvz3kx?=
 =?iso-8859-1?Q?FREd8L0pu2p30WZyF8cbl/FHKw9Uf88wZkadQiESHoMENJ6NqmlxUDfNrU?=
 =?iso-8859-1?Q?3xZBK0gRUaPgh0X5ukno/2XYJmbNwwNigeNn1GuvtNEWPZDQ3PcTj7ZcEQ?=
 =?iso-8859-1?Q?/PIEogjnqyyPcYD2RFbgyLK8zOEhcOt0bkJICMVBz4HiQUCTW3LxWw13cn?=
 =?iso-8859-1?Q?TYHrX/0qxecIsU2OsjbcKVOeEVFtv0y9P6/R2WlUAbVGsQxDVEU5tllCaD?=
 =?iso-8859-1?Q?QN/NEgm9l4FcKtMETtb5zIpdfwDVRCA+5mLyqZoPe7kuX/3rMHadfaJ82n?=
 =?iso-8859-1?Q?aeH0ac2zPqqWdlmKDlfDDJ1v/qHQKwm/vdlylQ9spo2aB5SQbwVtWr89aq?=
 =?iso-8859-1?Q?ak5PQZOnQhDuxyDZ7JHHCeV5uwo/Rshr5GqqoloJI644yl3N9FZkKihIaQ?=
 =?iso-8859-1?Q?N/B3U2C8h5zyVvLcf8ux8wkQUv1dA87XJPK/gf9Zy1ilOb0dImMi/7yaGg?=
 =?iso-8859-1?Q?Svy3iICHvjkd10x2ufpsDQrGWZNzIxJcwbxwwTwtLWyegKVjrERhNMO8FP?=
 =?iso-8859-1?Q?BMxS23aB2wgRvibktr8xXO+uTZR4Je2RGfNL0jpNd9+1iI/J1PZPJhqzFu?=
 =?iso-8859-1?Q?5YO7tTY6ImlK3afEefJ32bZHmwKMUhIxeMmvlm8gOxYvjELCa3G2Le+t3/?=
 =?iso-8859-1?Q?z7b4xEDz4pDgiKyUkZVxoqEK8ohYydZC1jlqg1vdazOd0ngXIHFcvYGLBW?=
 =?iso-8859-1?Q?9Ty2y4xL3GhHRvRmfo0yB+aNTI1xzJTUFe5OHpcJzCGF/gHIPbuww/zNqG?=
 =?iso-8859-1?Q?KbhS2fx+PqL31exuN60/CGePcc1ax2+m5ywhSFSyKyCMQwmnnWDzKuLHIy?=
 =?iso-8859-1?Q?CVF2X14vrO8orpm9NxXNGbuZ/Ft+zgN57RUnaqW3Bi01k5lKT81VrJEwxH?=
 =?iso-8859-1?Q?Y7iKz/ma7qCdqT9s30zr7kmG8NIosDgxOS2Z1dQ0c8PrCgW/ru7GUoEtK5?=
 =?iso-8859-1?Q?F7EBOvNL2OqLdbueScUnHA5L89OrvRqFcixVW7o5vIY1kf9RiK/BZTUjNK?=
 =?iso-8859-1?Q?KIHhOzBz8XhPvoYzsLMxHzOzO8g9M8FHth?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d6ab088-29d5-4e14-8979-08ddea424af3
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 17:01:00.4083 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ySJfyQleHOl5QOu+zjEacMxbXhgDbeS/ItfU4GKTsmnnRWrye7nL/FzqRzz8HIqtfGCZDKTq8QvFOlwmDOHphQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7167
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTAyMDE2OCBTYWx0ZWRfX2VR8u3O3YtWH
 Pg0s7r4fi8K2aG9m1l//WQWxwWhAxyGABFMIhC/TnryHqD+HAOiOBiRE2Gkp5KmZnj9BQpsrhwk
 EQU6wNyZJt8V29IuGORcaDeg2jbRd9lzTjms1EKS7fWwPy6MZ/KhKnhyqTbt8GBg0TOSCXT1HH+
 XS+jpOWRvIuDTvkjOJgA7JVY12P7jVluFE3ltGGwcClTv62xjMRMByBP4BvfyE4iWWKezj69udY
 pD2l+v+AyvlLJmwPKDGgfoMTm+Aj3g4t/sISPPDlkuGw3TtkxvzFg2zFTunPfSz6crx9yXOmH/i
 jwQqqaeabKPtQSXvGa9ciQKrHFnqa1759bF9PoJkFvZJ0s1luKEE60PbL9FQOs=
X-Authority-Analysis: v=2.4 cv=TONFS0la c=1 sm=1 tr=0 ts=68b722cf cx=c_pps
 a=ITavxs4S4at15BTzwWu3Ng==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=yJojWOMRYYMA:10 a=0kUYKlekyDsA:10
 a=KKAkSRfTAAAA:8 a=64Cc0HZtAAAA:8 a=d3oM7ixe-CCtZzQ8SnAA:9 a=3ZKOabzyN94A:10
 a=wPNLvfGTeEIA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: ltFGPO1EXnCrC4ck6QrUUm5oLMS47Cwg
X-Proofpoint-GUID: ltFGPO1EXnCrC4ck6QrUUm5oLMS47Cwg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_06,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=john.levon@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Tue, Sep 02, 2025 at 05:50:47PM +0100, Alex Bennée wrote:

> This is a fairly lightweight document which doesn't add much to the
> general advice in vhost-user. Update the vhost-user docs to point
> directly at the rust-vmm repo.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

Reviewed-by: John Levon <john.levon@nutanix.com>

regards
john

