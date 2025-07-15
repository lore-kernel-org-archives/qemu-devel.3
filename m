Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00194C83F17
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 13:31:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubfkE-0000Me-87; Tue, 15 Jul 2025 09:30:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1ubfDy-0008SQ-P5; Tue, 15 Jul 2025 08:57:35 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1ubfDv-0008Kl-1B; Tue, 15 Jul 2025 08:57:34 -0400
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56F83Phe015231;
 Tue, 15 Jul 2025 05:57:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=proofpoint20171006; bh=UlihoZieX8JfQ41
 neyYf4J4yFm6x5S7suBbjY9WKjMY=; b=WxXBBLID8/Vvu+MYoN1sRlkYY7Q+oQL
 fe9Mk7hLT0r6yRtprt9dSHv//MA5XlcSs73WwNIir9TDDlFSobJ3nUJUPvDniqsJ
 7J9Ha3A6cZaDa8x+7knsglHsWOn9dwU02CAVqtdc8+5zadxJk6yz931ZOy6u1IGf
 W2B0YSj5ScxHtuwwVZX7RFqrBGcuAmwo1P93TsJSjZ/3IYlOSHYFsPp73YEqIsiz
 jWxobIwifaAC8UY6SiTCU4qZWN4lJj3QD54aoYfSKH/Nkgp/TpGxahpKmNmeWkF/
 v0+b8m/51KFmqOcV5WAxU0mYd1esu8T0M1mqslb3XNSdN38YXcyGocw==
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2102.outbound.protection.outlook.com [40.107.243.102])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 47ukmapb2f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 15 Jul 2025 05:57:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FpWf64Vi61+UJdsyY2SX1IWWY5XIy2rysfSdY9MW6CS8UaHIaWOPPYUEUTbzZn9AJwroVIVSlvq4/fDOg2t63HQL9xbwfNF33tIEiycQeZ30euSOjuMwZUk0fQbAs86X6UMQ6Iw/YhBYajUttOAHFEKecev0cT4oVoXb5SNfN3rcJuhYSdwr4MMhTi3f7G8GiN/9278n6pawGlgQjpavdbBA/V+3hfwmv/WLHH/XiAM15wVXxwLWO9OX5MKTYs7uAkCvLq6pZCa7s4nQyT84sQvkm9npWtfsylvXCO5nYwieuNQra9bUKtVeB/n+BDYardgGf4MotvJvF9PFW/cOXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UlihoZieX8JfQ41neyYf4J4yFm6x5S7suBbjY9WKjMY=;
 b=QdXhPfiheDWq5zFYhIidpDl4bXKZlINcj9PHFwzyEXCI2vGyXUSpLEv5TAfj9KXLmvcge080sIceHAAwEZ6QPb25qrhEHe9GuReraCOT4zKcruXEt2Hr8X/zkQJNHULNqny23sukVB4rFDPszKYJ8e3m8huDflSpTDmiAOgJxLOJ1MvaSTom1PFrx2EjK7y/b4I96SJzh+XRdou9Blewxcnc6OpHGNctpV6zzqDixxI+eeldeVLw31Y5XC40nI8IBimhXsyKpTJLrg6EJP9v0rHoualFAdhmgow9y02kiqr+NqQ8p5CPtWH4BahEBPU/K2hlN+kTwsVpWZ2J433Gkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UlihoZieX8JfQ41neyYf4J4yFm6x5S7suBbjY9WKjMY=;
 b=PaEB3SRgfC5CD9QpSYeyDOB+3PPYWxl4UYZ5sCx8eQ68jLNCnaLgNsFhkC+5RMlCW7GrhkO1VvP2Tp4u8TtZYrC4DIB5wcy8/rpLP0SdNPkAckJAY2USomVCqb43tOuDUvzv1DtJV5+PkO7zoL6Hmtuyi1Klg/VTEXz0jdZGEuRpyryhkclJ7WBjOOPQy/kRbHGIhexV2U5lERTWMXGYesN33leAPMEMNl65B6tNiCjmNmOGoipi/TvT25mXGQIkWc/oYvSTJL6v0M/NGdyKtTjEGvPO8O+SbhgURKkyfyE6IPHmVSEESng5Xuoj0IPF5gsv7fcXCF3SuW8tK3Ssbg==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by BY5PR02MB7011.namprd02.prod.outlook.com (2603:10b6:a03:23c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.33; Tue, 15 Jul
 2025 12:57:19 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%7]) with mapi id 15.20.8922.028; Tue, 15 Jul 2025
 12:57:19 +0000
Date: Tue, 15 Jul 2025 14:57:08 +0200
From: John Levon <john.levon@nutanix.com>
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Cc: npiggin@gmail.com, danielhb413@gmail.com, harshpb@linux.ibm.com,
 mjrosato@linux.ibm.com, farman@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, thuth@redhat.com,
 richard.henderson@linaro.org, david@redhat.com, iii@linux.ibm.com,
 thanos.makatos@nutanix.com, alex.williamson@redhat.com, clg@redhat.com,
 steven.sistare@oracle.com, tomitamoeko@gmail.com, qemu-ppc@nongnu.org,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH 08/22] vfio-user/container.h: update VFIOUserContainer
 declaration
Message-ID: <aHZQJJeSZpE0yZdG@lent>
References: <20250715093110.107317-1-mark.caveayland@nutanix.com>
 <20250715093110.107317-9-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250715093110.107317-9-mark.caveayland@nutanix.com>
X-Url: http://www.movementarian.org/
X-ClientProxiedBy: AM0PR10CA0028.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:17c::38) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|BY5PR02MB7011:EE_
X-MS-Office365-Filtering-Correlation-Id: e3caed37-7c9b-492f-0339-08ddc39f21aa
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TtegdmwWRpD7781kA6UN0rawWy9uoZCvCnYsYn9oqaeNKDhchhjRoQ5KkZug?=
 =?us-ascii?Q?qyOG3qyxpKf0j1icc8aX3gO6+sqz/rPpWHDW4zf21A08Vbgn+qBiBmHOEnz6?=
 =?us-ascii?Q?LtkFOgiNJP/wCLpR6Awj0KnmerzSjq5r+kSrzAKuRy02yskHca3zE/d6Eh48?=
 =?us-ascii?Q?QdgpC1QwZOwQ6efwmW2P3NO/Ms0zQvjEBHt+WexOivx4+juwGdLhT/L/UMxF?=
 =?us-ascii?Q?y+sRt6OM7JzLfqzmgQW8re/EdxUjPwCXxgL00oTcr3tMXHbBfLOfbhBEEAVu?=
 =?us-ascii?Q?JIj9JXmw5Y5FC8hMSgVMeyVASaOjmQI5gulDltMj2TxjCpPq75705vC9fnku?=
 =?us-ascii?Q?a4nc6NJo6uyB75Ni4Zpq9fIS3CWF5I+MQDhV8Iw9c3PrxtS1hkbABBNNrgiX?=
 =?us-ascii?Q?9CCb5zQQ8XLISAJR5pKOskX68a3UpDX5x5DVb68yL+VLtSiTPedbd/15dnA9?=
 =?us-ascii?Q?21ppw7JCGFcoWTlLUmC6M2QyGvSYw1QsChQkvsngZecOk4J+3jcvNYe+PXwZ?=
 =?us-ascii?Q?qIXbkBbrRh2rvMuUCEaxGn7dtEu9IuVF4GngGGcSjSrtZsAP53RT3xZn3q0V?=
 =?us-ascii?Q?w19PnTZH5EsiScBeB0zMHYymdTMEbqtMfW9Fo9wmSR/6w6ZwVdu61ppPv8CA?=
 =?us-ascii?Q?qrvU0MHYl6NoVoOh0Obqd2xoO0g6vakxYA3X19qNvvmCgL05K9e7erbew8CA?=
 =?us-ascii?Q?mk28mTJML4nVf7m8fzOWvOLt7WoqkNsYFMmBo2J1dqX54x2S6VjlpGy0/Zad?=
 =?us-ascii?Q?fMY0+FLZDdo15CH9aNTA2N45KM1idyEUirI7NTL66fK3QErNSlmuVeZFYBN7?=
 =?us-ascii?Q?mN1aZOzq0FVH9d2rRqNo2qAwFQZ/gBx6QRjklcv+KYndzjBtJQVAnTmJVzvT?=
 =?us-ascii?Q?Hde4vIzQ/Lr/gGrLdQWSdvAXZstf6xbLpwATik0E/k2v6pPZbOVFe9+gBMf4?=
 =?us-ascii?Q?iHCj7e4K/R/qCzu8wi8v+EGiKZdV/Eal5RRH8AUNqVp0zwK3HDouzQtr4JV5?=
 =?us-ascii?Q?gjTev2t0w3ljwBuOKRM492yFDa4U9ZXTdKKnR4y4KYyCQ1G4Tr9Y6e1xnLPg?=
 =?us-ascii?Q?JK1mrZT33svfysojp05OLGBEEVyPGTcgwMgC9nwoo+ph+qZa/X1ySpr/EuE5?=
 =?us-ascii?Q?dXQaQPwFBejZICvPXmQV69Se+6jRntPHlnH/JiGIChMTmtFuxlRSBj1mSobD?=
 =?us-ascii?Q?I1tDaSObJd81spJnz7jYxRKlwS0xOmiekd7c4cDQwwQKme3GCdc9NA7BKWUH?=
 =?us-ascii?Q?37FKIuSnsn1lsklOkaloAU0ztLeMEDwy9RPYHLH13u0UKxgSVAtQIDL1IC3p?=
 =?us-ascii?Q?gelNvZF04OMexPdBt4FgJVaed4jcjnl/ALR/tWgsWpLsVTbHH270qOfcLQzK?=
 =?us-ascii?Q?Mbgx7VlZYroSdCkcxe51y6s0hrVb0R94TMJv5Kf2Ue6MTEWZqfeojlO+hGvp?=
 =?us-ascii?Q?0g4XeOKwfEc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?U2pMVU78Ctcdxow3kEAaG4SvmWRfr7nvYLsccHGA9MsKuvFQbX5wgaeE+gtV?=
 =?us-ascii?Q?6RSy7IKnXkLtZq8c4fK31rWLx++MT3lU8gMdI45sqqD10jIGLqDE7iWoj50g?=
 =?us-ascii?Q?0A030gT1R2YVN2m0hDtEqIzVrSs2gtbmg6ZQOTUVwHTUIyg92vyFE993WBVK?=
 =?us-ascii?Q?6GniTK/mKoqb6hBsXmwJXRgjFIVHhrsFMnfeuIYi+Hp0JYtm4JZ/XoTUb58R?=
 =?us-ascii?Q?9T2MVA+BBKNJ9w4KAIGpjCfO82kDQVfVOUshgxCIsjoy+az7ghD1P8h++S0R?=
 =?us-ascii?Q?d9gDCbgtV4VoPrEA6ypOzu3B/yLt8SmtWaH6A9PL/EdrwLTuycUaZaZNqtzP?=
 =?us-ascii?Q?VZOQ6s1g6JgJgFsn2/zHo1kVeV4m3lwotGvnNabj2oKYnYWMe21EhUcWIZk+?=
 =?us-ascii?Q?QxA5O7MsvMl7w9N3GlRbaxQd7GDbysmWDy3qybkuo++V/qYkA7VUeXSIv3Ld?=
 =?us-ascii?Q?ms795koNhiRg/izvwWxRw6vw39sAxxsgUfq30YSiAWIqxbglDNknmhye1ujO?=
 =?us-ascii?Q?x4ykiHEE85c32TzSnV50UwDjXVReAXsYIiOJ/YqiH8Ps2Y5W/iDx5iEeMETv?=
 =?us-ascii?Q?kfHLPow1w+0N0oLn2BiU2+F2g9DtWtekHfrs8ldDF/qhnfOsTlIlb1yf4zE1?=
 =?us-ascii?Q?dNkWw6lFUjjqfEW/Fd5luxCl4AGxrXv123qWwLxpVlKhKCpNBpcfcjSvi3wN?=
 =?us-ascii?Q?Nt7SvqctbT6xOvfhQnUx6bBML5amCuqTUfcyp/CGW7GlIfbLOuSp7/xXb5Rv?=
 =?us-ascii?Q?rFGwWC4lPy4qktuizM1mBjrC8GgzJZHhN6+zrQQ046x916Xc8Hoy5UPMesh2?=
 =?us-ascii?Q?Ve/BTH0emzAvXDgXktAR2g//NfSrzTZ/DnxosaTg4cNCzb3QHC857JFVmxcF?=
 =?us-ascii?Q?DgbgzsjuPq4mf1LSrzDUkD7Vxo5YH1k5IhKMsEKGt6R/tH9KjUjx5Dd5t1Hx?=
 =?us-ascii?Q?UUx9klPmf8XqPR9VttZrnVUzezcYMADiuiM3fG8SIPczmBcnZ1tIpvdN8lSF?=
 =?us-ascii?Q?Y573S9dpl2Ks8DSy2N3ILsjPpPtWbocwTfXwRbnF+mPMsOP4ej6y3mzJw9em?=
 =?us-ascii?Q?HPBuHsoWDSwfRKEr1GtrFOQPiDFKLaxR2ESz34ok6x8GxiaB4oVa134cK6wq?=
 =?us-ascii?Q?jr0wXj1zlIWMu1yzVINt82XqcedDsFcQ6R5c+Vb0D20i9zaHHRi8z+MhCaW1?=
 =?us-ascii?Q?y1kvNfN+4Scp2Mxg5V9X1A7sOl44keTHevp1fBN8nQJRFQq69pVulsaLC4NA?=
 =?us-ascii?Q?MYU+yWKc3Vw0/E2cLTS1G/L5vP0N1hi9r0m+3M3CPb0WT9A1aR1Y7eEmKcIV?=
 =?us-ascii?Q?IfNYuMzcYp1+3gunXsQuXbmmRSCAhy8IWYgb4qKX0eAfBsS1952IcXZtXw8d?=
 =?us-ascii?Q?BE1Gpy+8hrjyebiUJif8RhBeOVaDs4cXv5JODevQTKGqhLFUj8wgHFC6H5O9?=
 =?us-ascii?Q?IQ1iVJ6zD8NInzHq7Kgb7WR6YJL+Zsf+I3yzxLU5N/0AZE4jIi5dqUfNHKQi?=
 =?us-ascii?Q?ahCrE2ocBSbJ9jvRwbD5AqD4TEusZrhHbwLKfTtK0e8MBj7CKd09RS+2DXd6?=
 =?us-ascii?Q?xWBxpZjtofhQdDywJBi3kKhhMXAc65bN/q/X7f/i0GvvSp2NXvaKNjf9wlAe?=
 =?us-ascii?Q?QA=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3caed37-7c9b-492f-0339-08ddc39f21aa
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 12:57:19.0377 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tReHBsBsoVmkQJtZWMn7VBmdbNM3aDqD8FVBzDiD/reXJVF6ZnbVSxnpV2GiqMfI0MHLYmzu8wZyKcmgOFVQdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB7011
X-Proofpoint-ORIG-GUID: iDLT6VJiy14CUpgHobtonGbswGrQUCFk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDExOSBTYWx0ZWRfX2lMwqL4bxrZE
 P3oWOs/d0nnr+ZxroOV1yGGHl6CaFm20GyTkz3KpBdQ5YdxV6rT/NqJ6cH/nfX+k7p20uywa2IZ
 bOUV2u6O+CqQW//4X5DXLK8YmZnjnT+axRrNYyET/pUnyLQLSJpP2mkIqEowCrT1qat4JUZOljU
 RW26+auacAbvJbPQZi7zsZrczgkNph6+bdUi/KLv2FnW/PUOFJ1NTKO5HQxYA67evnDhzZInxKK
 sH9My7qfyndwg29yrV1rDxT2AgVBnB4ZqzNJdYF6f3JSYt/vubzxk+llQebQJBDYhacUJU/G1vA
 ZPE8zGFHdaCCGDx/yIBDBGJwBxlVxemdNMyhBfKabyqum8qG3K7+R1jJM/8aa8M/shYV9JdIGBB
 LKlaRVRNEqq2L1cK+Oa+YXOmtBLByKss30EJo3QhoJeyVVp+k0z+KxsGP8GLZjgRekXqRe5N
X-Proofpoint-GUID: iDLT6VJiy14CUpgHobtonGbswGrQUCFk
X-Authority-Analysis: v=2.4 cv=UcVRSLSN c=1 sm=1 tr=0 ts=68765031 cx=c_pps
 a=soZXggRKP89Qtlu95z0jTA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=0kUYKlekyDsA:10
 a=64Cc0HZtAAAA:8 a=KR-_r0ClAuQkrcTDTq4A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-15_03,2025-07-15_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=john.levon@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Tue, Jul 15, 2025 at 10:25:48AM +0100, Mark Cave-Ayland wrote:

> Update the VFIOUserContainer declaration so that it is closer to our coding
> guidelines: remove the explicit typedef (this is already handled by the
> OBJECT_DECLARE_TYPE() macro) and add a blank line after the parent object.
> 
> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> ---
>  hw/vfio-user/container.h | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/vfio-user/container.h b/hw/vfio-user/container.h
> index 2bb1fa1343..d5d2275af7 100644
> --- a/hw/vfio-user/container.h
> +++ b/hw/vfio-user/container.h
> @@ -13,10 +13,11 @@
>  #include "hw/vfio-user/proxy.h"
>  
>  /* MMU container sub-class for vfio-user. */
> -typedef struct VFIOUserContainer {
> +struct VFIOUserContainer {
>      VFIOContainerBase bcontainer;
> +
>      VFIOUserProxy *proxy;
> -} VFIOUserContainer;
> +};
>  
>  OBJECT_DECLARE_SIMPLE_TYPE(VFIOUserContainer, VFIO_IOMMU_USER);
>  

Reviewed-by: John Levon <john.levon@nutanix.com>

