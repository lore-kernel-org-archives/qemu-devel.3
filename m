Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F789C2D0CD
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 13:14:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHjGm-0004K1-3a; Wed, 21 May 2025 09:14:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uHjGh-0004IY-3e
 for qemu-devel@nongnu.org; Wed, 21 May 2025 09:13:59 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uHjGe-0000NA-Bt
 for qemu-devel@nongnu.org; Wed, 21 May 2025 09:13:58 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54L54siG012800;
 Wed, 21 May 2025 06:13:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=proofpoint20171006; bh=Tv3AzObfUlTH4JD
 YgQjQYrHdJOTzHHLU1lpY336gwf0=; b=f4cU7igjCxRoDg2aWJLDBQvQyp9hLXc
 F8avYCFQ0+ZONvljb+asUKSLU7taw6zBHLOLstBwRmNTpZs7kW7uH5ydbe7ARqtS
 oxoD5tBqPGmwineOoCcsANPSdhVRcvkMOD1qYkr0hgkbx1apC4U1+Snkhg0CwJwe
 rpuIZg7LRAL29VCLXIvKxabxXePT2Mm442WU81F0gLEQQYyqAOXut7Vhnel6kMuE
 i3ENtm31aYH1HLTX7eAzakFhUFRQPWgVra/iRkGRnVVDwsrwzjExtVmLolJLo2af
 1ridQrAe22WgY9DG+aiskUKYLOxNXN4p5FNRWOxC1+gjQSN9N4kl3/Q==
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2174.outbound.protection.outlook.com [104.47.58.174])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 46rwgj2gfr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 21 May 2025 06:13:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jf05xM77YvIShQquek7fA7fGaV1qRvyivGl0tU6ZnjrdZKo7T+RWqJKa1VGz3bUVorJLEZCEFOBOmw/HFhXgh18fKbKDFtrUg1TLjua2pSjD/d4z9VbpGkJR75E2vLyJaS0m417/H2dAJHHe3AbjoyLGE9nbtKG6un9EnF8P8l3sxX75q/10wf+/Qj/UqNt93sB9Wlk+qmaYp14keEHtKMgROiDAXWaiin41oAkSQ/87sTU7AXWSj7YpT32GoiX1DZK/mk4fglo5wl/zdghnWtxzcRezt1PGrR+Wm+peXaYXog7GbGSOp0SBHnsu9GWhvXvVf2tcgpFiJUa3Py/u/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tv3AzObfUlTH4JDYgQjQYrHdJOTzHHLU1lpY336gwf0=;
 b=ibwI/Gde1Mpb9x6dpWL1Np2V2eNd3ykWx/srXpfwYc7tVffxsghZpuWkFnxouPCN9Xrxr1sNcjsCIPuOaJ5xwfNFlFCYtplkVX10XYq4pZqP9e8YckklUK9+HY5hHDM9PfpIYteEzeGKOOGAs2nQHKKI1Ny/we8oeCLCC1mDW1VHYwwyD8bIo1mKLaeDkeztvTqTfKd/qt/6fnRaalnv/iuohdqTz0sA6gp1iq1/9DgiUUwyS5RqbhwA90+bb3lWohCNl5ILua4VqNJnPXUMISw7kjaTkUOCEKS6GURCcNar5BO0tBpJiGydPk+NiONlAQq+NynGYzKfBmybTzOqfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tv3AzObfUlTH4JDYgQjQYrHdJOTzHHLU1lpY336gwf0=;
 b=eszusqvlHCqVznb4JkNT39vxWGMScUCRlT7vQB1cFdS8X/2wWUS0I4jpUaWebaZzTpysfJrwDEC+Pbb7DYPqpfIUMzJZMt9vz2gjSJFGwuFjQo3yl4K2+rn3lKXOEoqos4+riI6aCYFTG8tKpVg1SHqnVdhKw/KultZCSGUtYWYxt8VULNv1ctSWI+COARtJ1YMlflVXpbW06/IB8CPw6v25d7CcxKt9ScNv1TzpNCwZT8M/Z157WEtWIJzNufvpQ8EuEtlARk4Wd5+TWUOymVit8tMjATi0Q7uMuEcznGMvZHeXKS7uctb3a/nVOuwOt3Fpr9sjwindovNNi2UkYA==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by CH2PR02MB6869.namprd02.prod.outlook.com (2603:10b6:610:5e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.16; Wed, 21 May
 2025 13:13:49 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%6]) with mapi id 15.20.8769.016; Wed, 21 May 2025
 13:13:49 +0000
Date: Wed, 21 May 2025 14:13:44 +0100
From: John Levon <john.levon@nutanix.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>,
 qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 John Johnson <john.g.johnson@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>
Subject: Re: [PATCH v2 10/29] vfio/container: pass MemoryRegion to DMA
 operations
Message-ID: <aC3RiOpJLos8_-Lw@lent>
References: <20250520150419.2172078-1-john.levon@nutanix.com>
 <20250520150419.2172078-11-john.levon@nutanix.com>
 <6804143b-8dd4-4dba-84dc-c1ca44d3f4a6@redhat.com>
 <c57d9070-37f0-4ba2-958b-be811a2d5778@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c57d9070-37f0-4ba2-958b-be811a2d5778@oracle.com>
X-Url: http://www.movementarian.org/
X-ClientProxiedBy: AS4PR09CA0012.eurprd09.prod.outlook.com
 (2603:10a6:20b:5e0::15) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|CH2PR02MB6869:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c725ae5-ef97-4ee5-1690-08dd98695326
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?QyBeaTY2PhH119OeyL5aEAoJvLsNM3+6ZIedv1lG2ZWzDeMOAdlG5RANv3MA?=
 =?us-ascii?Q?ps5/6HWFyzvmYvrrYW6vOFduyPefw3oCnW47vG0RhHXXDppy2rkqQ3z4gPQ1?=
 =?us-ascii?Q?1lKIubTvVGBX3YgNjhaMfVWk/5q/OLNp4MeWlCqxvfkXlsiXHaMmidkiqWOn?=
 =?us-ascii?Q?q0vRLsjfNsdkTf7krVF2TKT8RRaLKmIFS2M7KXO+zOXTnKnx9DsEzGyR9Sno?=
 =?us-ascii?Q?weDX/ooQPbev8nJZav3sJ0mRnX4/YYYg/kzOUxgq6VATD3jpYTDL5URSDhYd?=
 =?us-ascii?Q?+ri0piSdbfyorr6yDAZVz13frEfziQlbj84wXxFWNJKfi1beW6rFwjb4MTXZ?=
 =?us-ascii?Q?mhlfJLfN/XLa/k9o1Hqw6+CstR58Hj4oPrblAAHuzXjz3003Hk9bXW5Lsnuv?=
 =?us-ascii?Q?4sRYg7IXDWYX/IlolWIDLbdh1cEUdNQjv+YXivvEm6GlnMR41JBADC/rlwZ4?=
 =?us-ascii?Q?MeH2dfF9V9dpDtxElaIlMYS0eXK3toFvhZ0imshlnlZFWG2vlp8CF42dhvW5?=
 =?us-ascii?Q?XiYklPXLxvknHRTT4wogfy8Xan85AQKxD5mWrgBoEGchXXFJcTEieXHXQ02r?=
 =?us-ascii?Q?iLA24gv6ntNKCeabFMUNyf3xz48npZkQvrG8FJtgucsfkeOcoqppoULX8wAi?=
 =?us-ascii?Q?UlZURJzXouK5K7+WxSLJL0O3w02FURQsRdbZj8+aZbDdCeD9cZoING7AoBGU?=
 =?us-ascii?Q?xSKmyRjxc48K5AgXMcxEiW8qrBhoolDsrguN+9mNo12fVi4VhzdfcSGWiU0v?=
 =?us-ascii?Q?wpbC6PUEzAizz9p7xDOsnDTPQo4IN/WrbsS3lVfZWaQrFUZpO6GTtEl2Dgkd?=
 =?us-ascii?Q?lpwnzOJA/NcvcGu4+cu4RUISX8zYU9FYJDcsNTHKHxdVFXwoH012wj13JEEC?=
 =?us-ascii?Q?ifXN8CkxeplpT3emnuunyI+bQmiZ2ywz202JJMuAi0hbvXoSNJXr9Niq7UEQ?=
 =?us-ascii?Q?eATnDfNMPtQmzxheVtrnIeZ9V8irqscKCy+vIffJ0pENkgmiy5arHrdayfGg?=
 =?us-ascii?Q?ZuwDDPMzwC1BBIFkUs2K0jI61o/xnBlEGYam6L6Ex6GUVRYpPIfktPsWzqTw?=
 =?us-ascii?Q?JeL+nB/30J2q82WxT4zkENHZ351e4IWm2AFVtEyfAuMJOm8kIzRs1E+PEkcT?=
 =?us-ascii?Q?vUJHDaZiCB/2lNcUwhdfjiGI2sxWIQZj7EtQ3oNmenjb/W03gLtfbfSkdpQb?=
 =?us-ascii?Q?u2X2dMnV2O63pjs6of4g4WeA+tENjX38eoWoDQZx0vMiVqjkNUF73LnSEJJr?=
 =?us-ascii?Q?q4L0o0q4r5+NNJiYI2/OgsQwIRhwMwo4rPeGl0DPeMl9B/XTdYME950bDNy0?=
 =?us-ascii?Q?YDLBG3gVr7IVt71jObU9+nZOLJfWqtEKF41+PfXWVUiaR+MYtsFDFJAKcrpT?=
 =?us-ascii?Q?YVe67ipREj+k7XUH/FgpV2QL0NSXTifaepKFa9tQjjmPMwkYN8zCvDWfhscy?=
 =?us-ascii?Q?NFTIuThMiHE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qzezoHcIL3lSpBZQxxvs40OYa0YU9e3WaHWqwI8EyRqu77ojhhOmmtI+D9sf?=
 =?us-ascii?Q?wxe+e6snrEid7FMVMea+XwtEUm7XQ+71MCbKJaniq/S4RGvbsub1pWRWroTh?=
 =?us-ascii?Q?UpnNsiMbsNXtZglVgushWp2rVe5c4b1CAk6vIivNKdSIZeW60xLKIgVXgwQh?=
 =?us-ascii?Q?z4194WDZu+hADEghdNjveKcQIY0lFpwOd6Hhz9uds04GUW0RKUIeWZd+QJdG?=
 =?us-ascii?Q?3c3/d29+OuvER/Y6F/gW9WwzsC7HMeawPnBhrGQjh9fwMDLgpieZ+IqUA+S6?=
 =?us-ascii?Q?jnP9YO8PVh+6a2czYVFa9MbMsmCsO8HXmlHXa8d6jXypvpKgFnDzjVSaY+w5?=
 =?us-ascii?Q?F2J1cdSS0SxtNByf2B5o3ga/in8YnwkKUVm9JUCrVrHBscaOlTUhBa7pjtyD?=
 =?us-ascii?Q?8RWuHHBy89QdgnWUajxiLNDHI2VSA1FvtRApKS/cOO1qdXKhVGKqo+J2dkmD?=
 =?us-ascii?Q?gY7vrJC0Ts7l5F5Qggh3NdPFbbjAL+KdByKbmPBu9FMqVcACMcxyGuOW0gZM?=
 =?us-ascii?Q?AkXN5nIjsJzYz3DOC1C5dPaFrLCleMEgbB8VxxwPniVUiqPwzj8S1MeG11dS?=
 =?us-ascii?Q?DuyDbPaBua7tTLIKoojr3nLFQTohQLdvYFw0AQ+JQ8mUwv5vEscJKzU31lVQ?=
 =?us-ascii?Q?+0epJPa1XvVGQWJsdNXP3rKXLHQbvEte77e6QpcH7UPxSAfSTLK3fYPKGz6+?=
 =?us-ascii?Q?xIDFbc6eBD5rHnBQnckghPXafClCcYnRYMyLl7RfV0RQGcYFN/FhEAhAVOc+?=
 =?us-ascii?Q?hFpaRgddxU7zsKc03XVRqCpkugJosf5X+oj4RvNZCq9HQHcsTqqid+EguRDE?=
 =?us-ascii?Q?ad8ukZn2pHGLXQTAb8EaaEaprjDTr0U5jz+47ItwMubIVr09gvMpJNexjoIQ?=
 =?us-ascii?Q?XEPHwFdbXJCaUBwJ6vlQzzueGtKUf0W+BqX+YbmZ1Twxyc8jaY9tDJcixPjv?=
 =?us-ascii?Q?pPou67/tGHRtqxg9w65r5AbxguigAs5dCtgpa846aYaeifJkj53sSLquBVY/?=
 =?us-ascii?Q?nPAjWs5bg/LFwBxeoQ3qnQtCY6IIA8ZiK3tirF4pC9ttlzsUQ6CDyVQu2ptd?=
 =?us-ascii?Q?RRQziJlHD3c/qfJaUkq8Ggs+Drue4g5SWWDZyCptEKtT0vWxeMYDY4WymoX2?=
 =?us-ascii?Q?bp27RlgKlCFDMK8PYewzPwx30T47N4mRokS4izY6qppiU4ZPNNIO/SuNwwc5?=
 =?us-ascii?Q?mMXjLBt5uM7A5aXmFWZzbodrbSLvg6c/V+9swWr2ZI6jPHoZHwbc4DgWjE2J?=
 =?us-ascii?Q?HlkML0WBc6tc/rCoJX6+eFvYYUDtoaMdnt0RQ4spXkvudm6rMyu1JNXcz3nf?=
 =?us-ascii?Q?vPRWLMMM+J19TDV2TptpXg84Wj9CrjnIw4RkkdaFp29dazl+ej2M20NGvnMU?=
 =?us-ascii?Q?eid/Y219C95wPn503EFTPPSOvWN7f41wzS1mpAMK1wdxvhwiaDT+imfSv67q?=
 =?us-ascii?Q?MufyttpQZvnRoHJ3X7VrtRqF4nv+RKHDqSq9WjKKzpCjHWGMa9x+EGx7RUHJ?=
 =?us-ascii?Q?QHtbaK8NRjSBQpcoqgKJnTcX/6HSbhegOKpSmhm0U8WvJfXOw3W49U2spLEy?=
 =?us-ascii?Q?/VBFxduRnflfwJq53rRcjczK/Kc+3ByrOGAhk65K?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c725ae5-ef97-4ee5-1690-08dd98695326
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2025 13:13:49.2181 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: izHBQAa6sz+4NFuEu3uoeHtbzj9IuyiEEaw7yPOe1oy+TZvluzG0ujGCsKVRWuzLeL1wPl9boNjdBAP5C377rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB6869
X-Authority-Analysis: v=2.4 cv=KuVN2XWN c=1 sm=1 tr=0 ts=682dd190 cx=c_pps
 a=qvBKVd3KFl3zkoLf5jvq7Q==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=dt9VzEwgFbYA:10 a=0kUYKlekyDsA:10 a=1KFxolq2i-GBnVsExo0A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIxMDEyOCBTYWx0ZWRfX2mtizR67OOK/
 IucC12zvHxMlf2bBeLYJEy+RDOirevn+s9KJfPkJAmqCihyJpldJkL0T2T1frXxQ0+QHpq1zD/Q
 5O8lNrkDrl9UDWSn6MQFc3rvKBLoeyvGa2/V5deLJ5EoPx2IkERk1+zbBXuRlxB7QgndDUuq0YD
 WHw6hnmCpoQHjG/ObuhYIBms6HPm6r3Bc/CIFu5jUo2pK64ANUSvyGHlSz/B39jAylM6xCkSH9y
 VwXoXnsBek7ZraNQLy1HOY0r3V7T6S5HyxClwoaO2V0bcWVv/Xsm8GkSIuGEHm4LmNfHfRqXKSy
 corqF8d2IMhDpXBLDARexxkdBsp5jY/ZPtxbECi2ELJWc0TeeLP42HwCGOgmjorT0f1MbLhubRE
 uN6Q2+Vt7ZO4/xjPGV8bL878CYFibdWDEpgPU7LGyimAwUlF+htdIO2tQSl+Sv5NEkhVavof
X-Proofpoint-ORIG-GUID: ad_dnVM5mgyJhsXN93-aYBdrxQCyZgmB
X-Proofpoint-GUID: ad_dnVM5mgyJhsXN93-aYBdrxQCyZgmB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-21_04,2025-05-20_03,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=john.levon@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.184,
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

On Wed, May 21, 2025 at 09:00:29AM -0400, Steven Sistare wrote:

> A few nits, iff there is another version of the series.
> 
> I suggest "mrp" be renamed "mr", to be consistent with all other
> MemoryRegion* variables. A MemoryRegion is never passed by value,
> so the "p" is understood.

Sure.

> This comment for @dma_map needs polishing for clarity:
> 
> +     * Map an address range into the container. Note that @mrp will within an
> +     * RCU read lock region across this call.

Will fix

thanks
john

