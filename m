Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CA2CC71157
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Jun 2025 11:31:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRqyO-0001De-Uw; Wed, 18 Jun 2025 07:28:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uRqyN-0001D5-SS
 for qemu-devel@nongnu.org; Wed, 18 Jun 2025 07:28:55 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uRqyM-0002VM-6c
 for qemu-devel@nongnu.org; Wed, 18 Jun 2025 07:28:55 -0400
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55I812Co027364;
 Wed, 18 Jun 2025 04:28:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=2yFNSjTsdtfNcVmJlhnwsIUAE/r1iYUfJVDqIrUtU
 IA=; b=MezhHCSwcQQUmAaNgOQlL4lRpHn2vqQiCtqJww1OJtRx2d8wdSYoBLeyu
 iuo/sa8pzUW5QrH+CL5ixRsG/UvN2PxIf4/iysBqBw5P5hcxAmGdr7GdO/DTGVk+
 KKUJh8JsnmkNwhcpmDHYyZJC6QjvsGeLQMVJh4HJ/NM5uPP97UEr0xmIEJ+ZEBjN
 H8yIv220glw7YtGA9Q0owZO91ZQcd2V/Y6OD+rPDtP4+pTL1pTrvuY6TybQ2cx59
 LnQ6sPp1tGC+RPBF0D6PH1TTzWfwzMzSWaKTInScV++hXU9iC3WVrbBxGl/qHt6K
 rJeH+UUPKvoEHZTWqxEERjd5YECcQ==
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2100.outbound.protection.outlook.com [40.107.92.100])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 479508h33q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 18 Jun 2025 04:28:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FQVty2a7bRsohCH8YN+NMTevqGh4Ij24/uov/upiMBxkhXvB4B+VpDPUYJVEclrseBWIuCFHTexN/qD3ibdOtOZ45ns+cOIq/SeiQ42cED7TfU8k4KuWjQ/IP+Gp4LiGv+XcfpCI1ScaKw4vE0FJNMwrl2T7brvyKGkPhg7+RMepGs3YNAsW+ZA2w/YFYDbc8da8BARH9/qaNRFJ/yhOGqYh6+fVHzRyrNlFGoiHkjSYskFdso2LFlXC2Tw4vw2brjKI/nobQdwoTIZbmxkePHQt6MIZYHW76cLP7NUBlUE57t9UxfpXJ6zb+WrECHG0nVf+qGYHeuDAPGY0jzjajA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2yFNSjTsdtfNcVmJlhnwsIUAE/r1iYUfJVDqIrUtUIA=;
 b=UUlGCoocm8QwWID7sFU0ULN4l7eEAd4M79LDYqh13XsnctI0EF622JRgZlnTQj6M+hpFbjb4nszyjEohaaCLBbE9Jj/jLtTBvZTBo0Krd4FdxWyZE0EFunt/YniMFccHYCfBmJKIkclkhatbf8wd9G5JPePYc4y0Dk1nvXRZwiL8vwzfc6+y6RUI7A1U1Ucbg7vDzxVkC1GzjGaYB1AkcOZYJQDISXZI1+x+5HA21Ftw9ruqgERUftuy1tW/1mlokkVPeRx1PF7ui8TREBscR7zelS26ZhcQdcpcHFDDysIiS7uGfr+K/QvHnInSp7Etf2cJL1KkPOi3AchD2EAdRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2yFNSjTsdtfNcVmJlhnwsIUAE/r1iYUfJVDqIrUtUIA=;
 b=Dh/Xh5na0hv14BJv5uLDKeRmN1uJ8tLDAQviaUpFyajICv+jcw2sPHC3JewMG0FtjMZ3ofITJdY718b3tYz9qKTUi0SbeITTAcLUHYLHOvoL8Bbpnp6OBuug+s4ckSB4uHs/0dcA0C0kkQaMOiLvFb3MpVwtnnrTP1pvQyDjerfhZcpHn9K99lFp73UCh9c9QjBcVL5iKKWQJaf2rI6UAR2OSPg250nuCRq/pEu5EkohBxTWktlbYPVVgZsCIGKe5LLXKcyblISrOSwg+Kt7Xd28f7ZaGyyF9/jwdp/IOWlh1drSNlZjVqND3mkDBjF9Em2duvFEenCGD0GUUrPbtQ==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by IA0PR02MB9632.namprd02.prod.outlook.com (2603:10b6:208:3de::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.20; Wed, 18 Jun
 2025 11:28:46 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%3]) with mapi id 15.20.8835.027; Wed, 18 Jun 2025
 11:28:46 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 eduardo@habkost.net, imammedo@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v2 04/12] hw/i386/pc_piix.c: remove SGX initialisation from
 pc_init_isa()
Date: Wed, 18 Jun 2025 12:27:09 +0100
Message-ID: <20250618112828.235087-5-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250618112828.235087-1-mark.caveayland@nutanix.com>
References: <20250618112828.235087-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR03CA0051.eurprd03.prod.outlook.com (2603:10a6:208::28)
 To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|IA0PR02MB9632:EE_
X-MS-Office365-Filtering-Correlation-Id: 57b168c2-f5c8-41b0-5bb3-08ddae5b49e8
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|1800799024|366016|376014|10070799003;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jUBoVE0OxI7ymPlJa6hZKe9pBMqmHDBog0orgolb5YWTBgtSmgFqkJSXIA1n?=
 =?us-ascii?Q?UMYoMYQYQYdj9LwoAsHT9aU+zi+B3C2DohLqdcTtSReemp6IDIyF+FohwOvI?=
 =?us-ascii?Q?qm3a3KEoTyP3sDudyZ5SzEuFZptgKVDp2Rmiy5sDM9a+tqKGkxb/fAUwFoCL?=
 =?us-ascii?Q?TtIO36ZMsMmR5niBT44nQ+wfzBra2hRQm1RflMz++FhgPCCZ/n6ybv97d5K8?=
 =?us-ascii?Q?/nIdnE99W9t43oa4FPqFlS6BlInl+k7JF5EI4YFFZqhxMyceQ2GznN3miLWa?=
 =?us-ascii?Q?lh5EFPNtNrO3ehtLpj/tn1oZ1FgQYLuQbUe3IwQRMunm5xPioVIEZU5YLJC4?=
 =?us-ascii?Q?wCM4N50s6GiWioIxQucB8m9YFPGhyUdgmgjMhzBP4ub24TizKqLpZOAC+0/0?=
 =?us-ascii?Q?XGcYC1bYcm9M/tk9x6n4WR80lLOwlBa31Roo9RYGLCC4ZY/bsXxPYY9tq4Bz?=
 =?us-ascii?Q?inqTB6DhnjJjjTTTQTw3n+emFhlxyfHEvx/Kr4aJp9kNjT0YbPVbnxIcJtlt?=
 =?us-ascii?Q?LFQZJKQAThAsS2EAujAotu66iJKOEbtMtpWwn48zbYrCE4BltYk9EN+VjxaB?=
 =?us-ascii?Q?LMotLvbKI266rp6rU9Z0tzDZZu7NFqPdtL2n97xKmTeB0+ia9flbPeqvSEKQ?=
 =?us-ascii?Q?4HRADvD1woAIQm6IvpAtoTEJbrGneFmcgH2grDJpUG4oXEtkHoziAli/BEO/?=
 =?us-ascii?Q?dd9FrKMKaCUh7DxoejNR8PuuHeGWHP/Y5m74oYvLtYfafO5sT/ZTWZhiZ1o5?=
 =?us-ascii?Q?bNFFUwo/3/keQgK5Lk6OluJ9/aB+dc1Rs+WCp8P39ymBKQe7BlMjbMZvEfmG?=
 =?us-ascii?Q?2cRN/ATdhyx9c1/H0Latl5/JznyHVoV9o9Db7v5gjBpw8/pjnZFEcGMO98EJ?=
 =?us-ascii?Q?Y16H7kJ9ZYIF/dB8sz7x7GgVQqhAwRSMVyQUFxppMdau68rBP6+YCgEGGCPK?=
 =?us-ascii?Q?oDHhSgCITtb7KDkzHtmsFZolVpx7Aw/Cp0QlpJ6WD1vXH75hoQAIC7k+06JF?=
 =?us-ascii?Q?Db/MNYvizrlaVF0ACQV9dMylkRYM4e5v8UQYsj3UJQmfOEhDznCvkHCW38vk?=
 =?us-ascii?Q?fs+k5epy8oGPhP8zKagLzDzKj349cVtOWEAYpBXxfMsKTxGVLc8B9ZXpcBm+?=
 =?us-ascii?Q?0UW942ZYVk3Hrg9voKN4VvMTnE4DhtSe0a0FXNi2Frk81L1950HJ/SL/DBCh?=
 =?us-ascii?Q?7B5jSu/n3OEz9h8h1OMZ18kL8wWlmwYp0TO3VRwtP9TOkFIJP67QFKDbvqHx?=
 =?us-ascii?Q?c9ZT/iEdaWCIfdHRQnhPQrr+TL1P+c3YQaMqnjwtBz2zYKshh7/xO3q/0A0/?=
 =?us-ascii?Q?IF7r99mCA4juj0aRl8ztzLDgxbsvAJ/NOTWTU3KNLZairOywavJlx2zFDmXq?=
 =?us-ascii?Q?RWPkQmMoUegNfTYmY1+5HtkBvsqkYuDy631oyxFxkNzKbnElZI0bwuOjFz/Z?=
 =?us-ascii?Q?5rUW9Fa38wA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(10070799003); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MqLk6dz8xQFn1eALWGz4TzyRnsP1zNibTbDLZ/1BhAJx1qkK/Bpast+h37j/?=
 =?us-ascii?Q?5dd2cnC9qEMWEkHvkKhpD7gE6s4X3GiiOsJ4qleEKknHwa14XpArpT3UT1Am?=
 =?us-ascii?Q?HuOPKNFZ1Qb8fhZAyn3a23vDJJddntohrkktAFLSHfG8R0zJ90nfqcaVlaF3?=
 =?us-ascii?Q?lUyJo4IhUzaG9v6Eq4RSIZV5mnthnRCLYYACxNhyk7PTq9g86gNB4YL1eQY1?=
 =?us-ascii?Q?8lRkOFsBZtgkQ/laoRqIYTsE1YGLddoxZPQrY7E0GlxznVD6Dnh9WIzbTaKd?=
 =?us-ascii?Q?+pRF2OkS5KGRz72a7yi+AP4n/vlD7QGqY2hX1ZtfxhBb8Q6UqYourLVL4gfY?=
 =?us-ascii?Q?lO4Xua7BravFgTT4uiKHcDsytYlVTfMD96X48hWROYhCyDhHejiDKEIwsU4L?=
 =?us-ascii?Q?EGcLPz3Arh3ksfxowKDjccQFcURBw3nNIZKD6urEZfpLjZFTV7dkPrdSreLJ?=
 =?us-ascii?Q?DtZKFdd04y0VUkv88KTOKElYnXha7U045xz1vHp61dgclCHk9P83TI5flAvp?=
 =?us-ascii?Q?DbvIWfHFghZZjieLIml7LHiMpAi81kIuZnzCyl6AhNDGxiIG83UKKeWHhepD?=
 =?us-ascii?Q?NWNelxAcLWrImOimPxFO5Bi/zPB4+TL2vb8EH1p/DmUKwj9MhkV64DGTdJX5?=
 =?us-ascii?Q?NVKBN1nJL7l5vcAl9sAEYW0Z2kzw4v+ubRJ9qEs0lNK516ClJTPE+l/POi6Q?=
 =?us-ascii?Q?SdO6vtx/pWfvPIKrY+tj1Ic3q51SFWMegb5Ar0waM1/PEA7DAIfzIdYonJKE?=
 =?us-ascii?Q?58UnAHLBk42znQVguZzWj+czx5udaomZXjH+SaxzNuvhoACNB/0KUMxYkoGs?=
 =?us-ascii?Q?jseuzJV/0gt0hyR5h6nyhBgcYU8Frk18Uy1EZw8pNBKvD5zoKG0CVH4wAMJ/?=
 =?us-ascii?Q?Zk92dSMufBnAviVnDPqrOGLhhcFh54Tk+VZrzC6nQeSR+TsxlQZcUpMxGFqe?=
 =?us-ascii?Q?7LmJBbtx6bjHkIGXEOuXs7fc3411PDqyjuRBjiOCMKVviP5gIqR3WhTglnpK?=
 =?us-ascii?Q?464lShBm+ZQcleuCFuEy9RpoRmUseKy2kdeoROLM81bdkfPQap2uR/My9JkA?=
 =?us-ascii?Q?0wqTUNTdd91Bma0f7vpM2gjuFwT5uEH/IgatvEf0tqNbsTBkeDy2l9r0NSbO?=
 =?us-ascii?Q?YddOLLNj19kU1L8rzamHImCVMsltjMCKsD7OPuJFyqmTmWlXD6HJCFpjU6xQ?=
 =?us-ascii?Q?bhQULkhbnEqOemHg09Z0VZFofqIc4H0o+aUe6jVPE+GYpxwRyhfTVGj7eCHV?=
 =?us-ascii?Q?hmTaiAwyU1DW/irLCbPCfMlcH1gV83UgIA0KH4GpA3jxtjs4cgCw2E+LHJIf?=
 =?us-ascii?Q?ZqTIvvJ+5P7v4A+YcceaRSYrPiZ3tdDHqgcwTz6sh3w4hxCfVUkEk+60Jsdz?=
 =?us-ascii?Q?No2wbMxtMehFJ0mgi42wkODJ1yYNAJKEoMkzhEADGD7hOyTZHgZSESgkKA7R?=
 =?us-ascii?Q?oSVWMCpnyH4WSinV55ljNupLgW5gMvva5nsrVedSiVpixkjJCLuU1pT9K/eG?=
 =?us-ascii?Q?/Lvzsn7oLplDGHeR01XBlEMcz4KCxdeqAOH9uW78kE3jpZhnwBV+gRo3whXQ?=
 =?us-ascii?Q?E0AITfZKIBGwhBjVJ/74j6VKpOtqRYYHqvfi630OitedxjNPx+gRKwxVH5jG?=
 =?us-ascii?Q?QUybDsyv3o/PP/Dxty2H3KOKhVIvecQnLUzjLLR8sc1lDRbQ+hYq+c7sRz4Z?=
 =?us-ascii?Q?eSL3QQ=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57b168c2-f5c8-41b0-5bb3-08ddae5b49e8
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2025 11:28:46.2410 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QIkoagPy2ucP+KXh76w/Hh1ICeKhmQW42grR3DErqZOzd6cp4dNxGZ+eMx9W2230HAVUMF9VNQLEHqlmpykslsgwUiKCGK05owtPihZQ5/k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR02MB9632
X-Authority-Analysis: v=2.4 cv=HaIUTjE8 c=1 sm=1 tr=0 ts=6852a2f2 cx=c_pps
 a=NE+w6TL7qZ80L3NA32co+A==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=6IFa9wvqVegA:10 a=0kUYKlekyDsA:10 a=64Cc0HZtAAAA:8
 a=rnFr0Qxienu5vtaJ29UA:9
X-Proofpoint-GUID: dlTaZqV605XSyuR_Zr073WOflUNT1czi
X-Proofpoint-ORIG-GUID: dlTaZqV605XSyuR_Zr073WOflUNT1czi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE4MDA5NyBTYWx0ZWRfX+5UzeGSlWhKH
 EULI4GIen5xWmXUfqxoV4ur+A6gt8/UXVj1aDXKaFhWkAf6y5a+O4oxUOHFsJwXdmtgp2b4pxPG
 c7wBev3ZIfvgY7dihnFu+CcyeblAYIQj/CM0VvTlBzqOsVqHL7xuIomwH559Pc52tpkFzHoBSY7
 YXGB0Tv/YJ1UpLDz3s3KTG6XbSV67CFsQD4K+lDOnM7SPihO34WAW54ajT4T/Q/lMH2isVFysfP
 kJxiCi5gGH3X8OJMxtokn2qSDWp6GslpXg5Z7fhcWW58qtrdIj6jBe8oYdvVpL9TmkmZJFeuxwk
 xzkK2SlfWpZyCxH7TD9Do3zLw9+iLfqYnN6UpzJbX8ipJoN7FYNUslB+J6xcrt86aP4ycR/YQWI
 IPSVs6t1hm45+dEonSLi9RSv3DiX22EU86t9u1y8NBC6zJDjXcte7TlsmP9px407GQPE2WAh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-18_04,2025-06-18_02,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.895,
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

The Intel SGX instructions only exist on recent CPUs and so would never be available
on a CPU from the pre-PCI era.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 hw/i386/pc_piix.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 2ce3a3463f..d4fb9787cb 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -492,7 +492,6 @@ static void pc_init_isa(MachineState *machine)
         }
     }
 
-    pc_machine_init_sgx_epc(pcms);
     x86_cpus_init(x86ms, pcmc->default_cpu_version);
 
     if (kvm_enabled()) {
-- 
2.43.0


