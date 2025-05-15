Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F02B9C3DA6D
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 15:49:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFanR-0001Wy-MY; Thu, 15 May 2025 11:46:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uFamN-0008JU-7b
 for qemu-devel@nongnu.org; Thu, 15 May 2025 11:45:56 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uFamH-0006WC-La
 for qemu-devel@nongnu.org; Thu, 15 May 2025 11:45:50 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54FBNZKY014714;
 Thu, 15 May 2025 08:45:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=CXd2NeK/ET6uD8gmkhbk2vh4nYzQVltKbqv/Wx4cy
 uA=; b=vtgM3K+FjPraJmyKPEPqC8t1WSMQndMH+lE6fSZUlf6nRjHNzz9pqAZ7r
 9vapgwNOOWg/7S/j5NekbNlrMOGwYdzlWbCKgxgaEkra0fJNXs9pZgs8gKAaxFw6
 UQqwrPS0FtxPtf5hWFtvEdVNw34SwBUjMZIHxGKCnFXK6R2H+3eE4RskwoLSVXOr
 Noq4TolyeRNEqXJYB4vI+E4NZpFrLStXjEYNmqDw69uersGgnFbtQoNpd2KH09D9
 kNMMJ5MrZbsosPWG2EBhQUr4PAghffVuvq5r9xzmVTogRNaUSBhaNt1PV5diKO62
 V+DlNXpm/FYXt0dP6DnMqMXHdgOfg==
Received: from bn1pr04cu002.outbound.protection.outlook.com
 (mail-eastus2azlp17010022.outbound.protection.outlook.com [40.93.12.22])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 46mbd0we36-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 May 2025 08:45:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LQdzPx9ODJqwkmGO1eDay/bf72ArxeUXW9db+PZBj+Wo/04NWTygbXsNb4JoLDX8XVqRIlhlGYEs4h2VQFvH4lmdMQKTkl7NFQwudySBiVS7GT02rVAP0+8TDZEgJXoHefvJ6Hczt/5AP8VK8ppnA24z1xpt8UPsXJTNdYCPhDONfNaQCJ4HC32yELg82sOzz1qqh5D67K70as7cDgO3xNoKoYC87UUfF/8OnE5KuRwjJLdAREWuThkKTjHW1rcFwLFo2ZFPnQ+SSeaBadzbtDaKylr12Prww3o5hcTfAAL6hpnbssoO27zIGLYanZqFVOgNlXMXRCe1FTd0GMY0Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CXd2NeK/ET6uD8gmkhbk2vh4nYzQVltKbqv/Wx4cyuA=;
 b=ot9E6sBBCOurFE70FvoN6/xaYFdFiW1Q+pkl528E6AlEabi83w8vQICEVipVM2/8rbrZ07fwtU92a7AmucNsqID3GRLl6gUvhfOWB1aYLHltOk8QXg/UudchCkrcCf0wB7+l6WAYCOC1hhMaj3bAe/QO5F6PYj97TgQp1IRMxrrZ6m6v4uG1Eie3B0sVTP+UB/AlEiYpCeFWnu9r1UWGGa1H4o3ELpKKaJN9HWUqxFSpr7e4SsESTn6njJk7ZEs90Mbz0a7dfb9oYzE5Sul6A4pgYxaNQvLZXAh24kaLpPtd+qJAt4JpyM9L5ADjAbyzNH6vJkk3UoRUV80ci879Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CXd2NeK/ET6uD8gmkhbk2vh4nYzQVltKbqv/Wx4cyuA=;
 b=FdOQ4jUv/+wWixcpqjjcMD97K7lpMDlKT9U+FSYfTQxveq6NLwVBWeKBY+/vpTAkguFreqebt0KUoA7lfxFll/cGcp7xP1tvlT6au1tVJ3tL8yIcZSR0Mu08eA4nqDr2h4Lg/ztRYRQcZxulrbkh5WzziqckjNfZaruoEs1h4zysfudzDF22ipoD8E7oDHkGTBxkz9MIEztUdPsT2bKjSFmTPhfKq0ItXFb5ClM6dEtZSLWWlwwhRtRoIIFMkJdlpCrZzJVAmXGNfGaLf4/6XjxcyDxs5aM6nWluPJt2LwsFmVFOdYftG5KTYKO6vRFMulBH1RYQtOjclVFr0vBSvQ==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by PH0PR02MB8470.namprd02.prod.outlook.com (2603:10b6:510:10e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.17; Thu, 15 May
 2025 15:45:24 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%6]) with mapi id 15.20.8722.024; Thu, 15 May 2025
 15:45:24 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Levon <john.levon@nutanix.com>,
 John Johnson <john.g.johnson@oracle.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>
Subject: [PATCH 26/27] vfio-user: add coalesced posted writes
Date: Thu, 15 May 2025 16:44:11 +0100
Message-ID: <20250515154413.210315-27-john.levon@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250515154413.210315-1-john.levon@nutanix.com>
References: <20250515154413.210315-1-john.levon@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P190CA0010.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:219::15) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|PH0PR02MB8470:EE_
X-MS-Office365-Filtering-Correlation-Id: 40db95c5-fa9a-4031-419b-08dd93c78201
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?mqMxpjufUpFgB5ooDKTD8sKQjoT3EYOcxyHQ270hc3uxkEChs4m1wjgmBEQx?=
 =?us-ascii?Q?NjgTAtbNQ311YwlHy9/Mi0hUXVFsod/4yPKB+lsdF/CfOim9hNK7LuBJWXrP?=
 =?us-ascii?Q?lFjD2hM0Z4zm540p4NbuTkJKgdt2k86Rs+/O00k7JJg56yAFgn48hkPJYCDM?=
 =?us-ascii?Q?3/HLgI9mLkhfTV2e63s9fpTSRDsQilWshjkhaN7FCUVos2zyxWLfVxLjX5d/?=
 =?us-ascii?Q?n5g8hbjILd2/ZDIRwMk6PPif9ilispcvyz0OeKDpCReClpOuH56MtoHDMDks?=
 =?us-ascii?Q?uXqrSwN32pO4grB2NN2R4/c4pvnSdYdcQBwXxZOwekVb59hozI3mFYDqLuDj?=
 =?us-ascii?Q?qJajzp38oOfPXHX2ShBDJBFqSiFMTtydg2lFSFbolyTQ++UjdJkgfpB+EEVG?=
 =?us-ascii?Q?b3FSF6NXi/NtxYPdYPCk08F8g/gRGjlc81t4uKxpUYYbazJvCKYSRfk1OBHY?=
 =?us-ascii?Q?98F69UmO9p8t7wjfI59fO0qF6xRCDIDyN/H05SiDjDgkk7A52AeBbN4HqzgO?=
 =?us-ascii?Q?dPPEJNT0qQBRLK71YMqGinQI8N0uZ91absdDZplJiICQZb0UgWzK/XXd21wK?=
 =?us-ascii?Q?gFKlpJ0aS+IXMGHrknYds50TQFQyPf4Uz+ngLbnKkRQjTsKnIWIzsAWWPAG5?=
 =?us-ascii?Q?C0/lWFWpVJ2Zrq27oikfeJGsX67FoXZ3naiMeyAmOJ71ANZodu0D/tAyjMYF?=
 =?us-ascii?Q?5cBGurTLH4WRJIQO0VdB9RyzdNWW6XDTF1HTuNeWg7bWmRLvuOmoEZxYvY5/?=
 =?us-ascii?Q?Wo3xm10fct29YeiI768+IGrGENyv669sd5Qh5FUwAb+iGsGMCaKGZDpfAN3w?=
 =?us-ascii?Q?mNz/cl/XItGY2lVIRihTo7iXcwlQLmmQjmpmqxUe/FAV/yVfp0+loVjxXjQx?=
 =?us-ascii?Q?UaZM9xDOhwc4da2JEh1Lx9oMFyT4xsqFi8JElf7jUMXSecca7VEu3Qt5LVNY?=
 =?us-ascii?Q?EY/AbIW7A6koi0uH5+V6YXlnOUbT+TMwWBxIyyDkVOCaZKpNPh3YHbd6trAj?=
 =?us-ascii?Q?bZ2DARZ+tLdYtuHdUxhwaHODkIAjtSDnhZbWn/GA4oBbRu1yIh6iLN7clai8?=
 =?us-ascii?Q?A28XxkSLcqqAWJx7xGH98M3Z7tT350tM1BtIJxTHf7VR/pIgpvGgHVDUb28k?=
 =?us-ascii?Q?6n0c0+Uxzb/OWo06I1s9c51golMaUWnwP/SzgpbsKHZCc1OBDWuid6MW2Wb7?=
 =?us-ascii?Q?hn2Tzqtj0tUeyKDQBv22GhILf37FQfFRHL7xlkO9ngPQU1vts/s477XBusEt?=
 =?us-ascii?Q?1uwdyH8EhaU9wBSYXJzTCJXEx3Ol02pJJ/a9QbV5cr8hSBAlJ2NsR7jV4fnD?=
 =?us-ascii?Q?hRjFTjiExqMkst+BJvKNtY4qVYoWu7U7V9VzLSw3R0l3pvh3XPw2O8SSgk+C?=
 =?us-ascii?Q?yO/xpnoifuDmwxnarXixAFSNaOdN5cKl3wiOshahBhMOd/E0xQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pEYR/KdT25ssWuJPS3aE7FjT7MdS+hcyZaQNWHk9n7GA8LTxn/a2cMCABmlW?=
 =?us-ascii?Q?J9gEHSRw/SXhAJowprgWgxAZv3XQpJl8OQlLYBUWfSzkrhnoXqO/bwk6GblV?=
 =?us-ascii?Q?BxpeX0g6BTo8VZTfyMgqH5A67tZYRx7AsT+YMWkPYbtgfnEOxonCBFuQo7am?=
 =?us-ascii?Q?F2J+mNNGqC5leMMsRgPeB1eCT97kfgVFGGccFnz8zOMLCsMDZyJL+JwEp+EL?=
 =?us-ascii?Q?PF00t57WY8Cx7j2FR+BifXwbXsDCXdYxqwQUrh9Cr5xdcNcT79Ad5D182eli?=
 =?us-ascii?Q?o6x55qV8njzsaQ1S/MFZjpyoevO5mXQqOxWI0QpYzRJVXHCzGQVicw+D8UOh?=
 =?us-ascii?Q?i9tkHPOcbjds0qhEckXFxmirzP3phfqKIhsoO38gn4DGWqANfMOyQFDRYH50?=
 =?us-ascii?Q?tYrnSpskVhxHUKzz1WrTKxN2Mfe60IBdUwJFbl8cUyTXV3Z+46v1K48h4bv7?=
 =?us-ascii?Q?zTM3FI2sBpyeFwmNw54tVxlSDLb/Nv2Eb4WUhpYEdoy8KH5qOy41jOpbsQd2?=
 =?us-ascii?Q?RsnlYxyaxQNIqDMbo5CrS9Oz9ayZh4C9qJH5QvVEsAwve9zUuLPdLfpxWXk3?=
 =?us-ascii?Q?2Wm7UE4jXpqZEfY01/oR2gB6weLa2jYwplbQfyVxzSt8XJ/iE7y7HI7LXIJ0?=
 =?us-ascii?Q?J5QApdSHzaCBJKsSwUzXbJJMwNbzspYzyQKxMoyrbsT+vvNrQoPdgV9lhQQQ?=
 =?us-ascii?Q?ktJkx5lChl/gQ1JVlBG5CDDbhZLKbXlaJYZ4ZNEJZqDQ+X/k//jls2A0Ldhh?=
 =?us-ascii?Q?CsUFIUv9dngyv9PTiUA2ICiraezYLag6xTuckqacjDbpHiWSbEPvbR92a2A6?=
 =?us-ascii?Q?5k7OWDjYkEOO1+FowzYpqWNSv5YET+G60D2fGGVlKVpGGE0A/eW0A/VMok4R?=
 =?us-ascii?Q?3BeB11zSZTqYUi6iGOF7rgjVz8Ng94d2h+SqQ+8DeYjQeugOxWchs7IZiUj5?=
 =?us-ascii?Q?NUOcxdWJzaBiuYKhbSkqb9hv1XJjBUIVptGssGadMY8R6GwZZJ+nc/FlabSX?=
 =?us-ascii?Q?QGdsmWzeGmVLOLv63OfVNJDU63tT9ZLHcw6itcpMvuG2/x5S91DgwEJQ/Dew?=
 =?us-ascii?Q?xP7h1se10hb7C2mLnO/fk1Rf5mZtZeUYce1nstrSbburtUnqyOtl3RMl/bH0?=
 =?us-ascii?Q?Gp6Q+MrWyYenvvGr24MgDOHX/+xpv3D7Y8G7vFMCo+xmZA/ZAuXTCEH4SFuR?=
 =?us-ascii?Q?VVOydMpdOfl0TJ4i/M8XdeQ4pm37tFQzMP1kPGFBUOp1f+c5/+suSVk9D/8B?=
 =?us-ascii?Q?QjLhRSdDJyyRriITl59Ez4uWK6o3Xea9kkKa/etBhStzP8A2LuEw8SmaDZ4t?=
 =?us-ascii?Q?2IJ4tLBV50/LnajohNdl5M8XSUppfLnTcr+t/yJUxsNw0oK9NVOajkgTPhK+?=
 =?us-ascii?Q?RaCnV5qgsMWT/6M7727ql2rsJhWIs/W3y/z6o016kgm/hd2lkUVKH6S4EedK?=
 =?us-ascii?Q?Aezg4XeHKEFLMG/81dsqDRpfPc9kmt9TP+FGh3uFO1iGJ1GmfBKtVLsIt0Rs?=
 =?us-ascii?Q?YWVV4tXJGNvN5+J7XKUg2sgHej6z3UHhgkK3SrPP4xjof5jPdlgEdP95EfYU?=
 =?us-ascii?Q?jOJVXIYe9frIkqc2aOjME31YzCGvmZnNwcgN8T2J?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40db95c5-fa9a-4031-419b-08dd93c78201
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2025 15:45:24.6974 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E1V/jvoNLtcmr6olSffqqOnUs/KeR15bMHJedD1pfhqE64pNM0HUbCSsPsSLU8voCaMdGl5OD/axTcPUrRbzvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB8470
X-Proofpoint-ORIG-GUID: cL9egMB7G3occNn61QgjbTElbDBYZVWh
X-Proofpoint-GUID: cL9egMB7G3occNn61QgjbTElbDBYZVWh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE1MDE1NiBTYWx0ZWRfX7KLO9870q5rs
 buPQNXkoi4Au4QhDnbvlCdAfa7JkHk39lMxISl/HQJGVdAVvcRYWJExRfEwJuB9R5vn9OcMuHV8
 vVEALS11jgPhJVI2YBGYPw1FNwgsQayVvf5U4AHtaiDXz9ZvicdLHl1k42hWlhu6q/2G+2NrKy/
 VsgaPIvGGFxz+WpOWVErmbVD7BB3kaQJcuWtdOOHQJIfE5nGQarS3x9qvz6bFwZVq/81bo5tCWf
 Yuxt/2tZZhpxT+xf1dnqVr+KBou+EeoxXjO+VYMR5w9weaDtF/WcjikifX61ayMGM7kAmR8IS8j
 i4ox1ULVj2mZsKBFssRPXqkg5ZO0POia7pyMGvx33Qxa5JshrYCM/caIJiOFG645p/RTsnMVBY8
 d5aMMhScIpgJQtHoHKmF4Fgi6nWqlR/R+czFSVRNxnmIk9DkqG43haXRpYzTbNIJPKL6qAHL
X-Authority-Analysis: v=2.4 cv=KKlaDEFo c=1 sm=1 tr=0 ts=68260c25 cx=c_pps
 a=tQsPtMi3p37jOgXbkrwZvw==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=dt9VzEwgFbYA:10
 a=0kUYKlekyDsA:10 a=yPCof4ZbAAAA:8 a=64Cc0HZtAAAA:8 a=pwxC0n7aooic8zlvp-IA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-15_06,2025-05-15_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=john.levon@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
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

Add new message to send multiple writes to server in a single message.
Prevents the outgoing queue from overflowing when a long latency
operation is followed by a series of posted writes.

Originally-by: John Johnson <john.g.johnson@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John Levon <john.levon@nutanix.com>
---
 hw/vfio-user/protocol.h   | 21 ++++++++++
 hw/vfio-user/proxy.h      | 12 ++++++
 hw/vfio-user/device.c     | 40 +++++++++++++++++++
 hw/vfio-user/proxy.c      | 84 +++++++++++++++++++++++++++++++++++++++
 hw/vfio-user/trace-events |  1 +
 5 files changed, 158 insertions(+)

diff --git a/hw/vfio-user/protocol.h b/hw/vfio-user/protocol.h
index 8f589faef4..f747e70e50 100644
--- a/hw/vfio-user/protocol.h
+++ b/hw/vfio-user/protocol.h
@@ -42,6 +42,7 @@ enum vfio_user_command {
     VFIO_USER_DMA_WRITE                 = 12,
     VFIO_USER_DEVICE_RESET              = 13,
     VFIO_USER_DIRTY_PAGES               = 14,
+    VFIO_USER_REGION_WRITE_MULTI        = 15,
     VFIO_USER_MAX,
 };
 
@@ -75,6 +76,7 @@ typedef struct {
 #define VFIO_USER_CAP_PGSIZES   "pgsizes"
 #define VFIO_USER_CAP_MAP_MAX   "max_dma_maps"
 #define VFIO_USER_CAP_MIGR      "migration"
+#define VFIO_USER_CAP_MULTI     "write_multiple"
 
 /* "migration" members */
 #define VFIO_USER_CAP_PGSIZE            "pgsize"
@@ -221,4 +223,23 @@ typedef struct {
     char data[];
 } VFIOUserBitmap;
 
+/*
+ * VFIO_USER_REGION_WRITE_MULTI
+ */
+#define VFIO_USER_MULTI_DATA  8
+#define VFIO_USER_MULTI_MAX   200
+
+typedef struct {
+    uint64_t offset;
+    uint32_t region;
+    uint32_t count;
+    char data[VFIO_USER_MULTI_DATA];
+} VFIOUserWROne;
+
+typedef struct {
+    VFIOUserHdr hdr;
+    uint64_t wr_cnt;
+    VFIOUserWROne wrs[VFIO_USER_MULTI_MAX];
+} VFIOUserWRMulti;
+
 #endif /* VFIO_USER_PROTOCOL_H */
diff --git a/hw/vfio-user/proxy.h b/hw/vfio-user/proxy.h
index 22ed66c54f..ae09b9cc60 100644
--- a/hw/vfio-user/proxy.h
+++ b/hw/vfio-user/proxy.h
@@ -88,6 +88,8 @@ typedef struct VFIOUserProxy {
     VFIOUserMsg *last_nowait;
     VFIOUserMsg *part_recv;
     size_t recv_left;
+    VFIOUserWRMulti *wr_multi;
+    int num_outgoing;
     enum proxy_state state;
 } VFIOUserProxy;
 
@@ -95,6 +97,11 @@ typedef struct VFIOUserProxy {
 #define VFIO_PROXY_CLIENT        0x1
 #define VFIO_PROXY_FORCE_QUEUED  0x4
 #define VFIO_PROXY_NO_POST       0x8
+#define VFIO_PROXY_USE_MULTI     0x16
+
+/* coalescing high and low water marks for VFIOProxy num_outgoing */
+#define VFIO_USER_OUT_HIGH       1024
+#define VFIO_USER_OUT_LOW        128
 
 typedef struct VFIODevice VFIODevice;
 
@@ -122,4 +129,9 @@ void vfio_user_send_async(VFIOUserProxy *proxy, VFIOUserHdr *hdr,
 void vfio_user_send_reply(VFIOUserProxy *proxy, VFIOUserHdr *hdr, int size);
 void vfio_user_send_error(VFIOUserProxy *proxy, VFIOUserHdr *hdr, int error);
 
+void vfio_user_flush_multi(VFIOUserProxy *proxy);
+void vfio_user_create_multi(VFIOUserProxy *proxy);
+void vfio_user_add_multi(VFIOUserProxy *proxy, uint8_t index,
+                         off_t offset, uint32_t count, void *data);
+
 #endif /* VFIO_USER_PROXY_H */
diff --git a/hw/vfio-user/device.c b/hw/vfio-user/device.c
index eb2194c0eb..79375ddc96 100644
--- a/hw/vfio-user/device.c
+++ b/hw/vfio-user/device.c
@@ -10,6 +10,8 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/lockable.h"
+#include "qemu/thread.h"
 
 #include "hw/vfio-user/device.h"
 #include "hw/vfio-user/trace.h"
@@ -296,6 +298,7 @@ static int vfio_user_device_io_region_write(VFIODevice *vbasedev, uint8_t index,
     VFIOUserRegionRW *msgp = NULL;
     VFIOUserProxy *proxy = vbasedev->proxy;
     int size = sizeof(*msgp) + count;
+    bool can_multi;
     int flags = 0;
     int ret;
 
@@ -311,6 +314,43 @@ static int vfio_user_device_io_region_write(VFIODevice *vbasedev, uint8_t index,
         flags |= VFIO_USER_NO_REPLY;
     }
 
+    /* write eligible to be in a WRITE_MULTI msg ? */
+    can_multi = (proxy->flags & VFIO_PROXY_USE_MULTI) && post &&
+        count <= VFIO_USER_MULTI_DATA;
+
+    /*
+     * This should be a rare case, so first check without the lock,
+     * if we're wrong, vfio_send_queued() will flush any posted writes
+     * we missed here
+     */
+    if (proxy->wr_multi != NULL ||
+        (proxy->num_outgoing > VFIO_USER_OUT_HIGH && can_multi)) {
+
+        /*
+         * re-check with lock
+         *
+         * if already building a WRITE_MULTI msg,
+         *  add this one if possible else flush pending before
+         *  sending the current one
+         *
+         * else if outgoing queue is over the highwater,
+         *  start a new WRITE_MULTI message
+         */
+        WITH_QEMU_LOCK_GUARD(&proxy->lock) {
+            if (proxy->wr_multi != NULL) {
+                if (can_multi) {
+                    vfio_user_add_multi(proxy, index, off, count, data);
+                    return count;
+                }
+                vfio_user_flush_multi(proxy);
+            } else if (proxy->num_outgoing > VFIO_USER_OUT_HIGH && can_multi) {
+                vfio_user_create_multi(proxy);
+                vfio_user_add_multi(proxy, index, off, count, data);
+                return count;
+            }
+        }
+    }
+
     msgp = g_malloc0(size);
     vfio_user_request_msg(&msgp->hdr, VFIO_USER_REGION_WRITE, size, flags);
     msgp->offset = off;
diff --git a/hw/vfio-user/proxy.c b/hw/vfio-user/proxy.c
index 13f2407845..dbaa322952 100644
--- a/hw/vfio-user/proxy.c
+++ b/hw/vfio-user/proxy.c
@@ -16,12 +16,14 @@
 #include "hw/vfio-user/proxy.h"
 #include "hw/vfio-user/trace.h"
 #include "qapi/error.h"
+#include "qobject/qbool.h"
 #include "qobject/qdict.h"
 #include "qobject/qjson.h"
 #include "qobject/qnum.h"
 #include "qemu/error-report.h"
 #include "qemu/lockable.h"
 #include "qemu/main-loop.h"
+#include "qemu/thread.h"
 #include "system/iothread.h"
 
 static IOThread *vfio_user_iothread;
@@ -444,6 +446,11 @@ static void vfio_user_send(void *opaque)
         }
         qio_channel_set_aio_fd_handler(proxy->ioc, proxy->ctx,
                                        vfio_user_recv, NULL, NULL, proxy);
+
+        /* queue empty - send any pending multi write msgs */
+        if (proxy->wr_multi != NULL) {
+            vfio_user_flush_multi(proxy);
+        }
     }
 }
 
@@ -464,6 +471,7 @@ static int vfio_user_send_one(VFIOUserProxy *proxy)
     }
 
     QTAILQ_REMOVE(&proxy->outgoing, msg, next);
+    proxy->num_outgoing--;
     if (msg->type == VFIO_MSG_ASYNC) {
         vfio_user_recycle(proxy, msg);
     } else {
@@ -571,11 +579,18 @@ static int vfio_user_send_queued(VFIOUserProxy *proxy, VFIOUserMsg *msg)
 {
     int ret;
 
+    /* older coalesced writes go first */
+    if (proxy->wr_multi != NULL &&
+        ((msg->hdr->flags & VFIO_USER_TYPE) == VFIO_USER_REQUEST)) {
+        vfio_user_flush_multi(proxy);
+    }
+
     /*
      * Unsent outgoing msgs - add to tail
      */
     if (!QTAILQ_EMPTY(&proxy->outgoing)) {
         QTAILQ_INSERT_TAIL(&proxy->outgoing, msg, next);
+        proxy->num_outgoing++;
         return 0;
     }
 
@@ -589,6 +604,7 @@ static int vfio_user_send_queued(VFIOUserProxy *proxy, VFIOUserMsg *msg)
     }
     if (ret == QIO_CHANNEL_ERR_BLOCK) {
         QTAILQ_INSERT_HEAD(&proxy->outgoing, msg, next);
+        proxy->num_outgoing = 1;
         qio_channel_set_aio_fd_handler(proxy->ioc, proxy->ctx,
                                        vfio_user_recv, proxy->ctx,
                                        vfio_user_send, proxy);
@@ -1112,12 +1128,27 @@ static bool check_migr(VFIOUserProxy *proxy, QObject *qobj, Error **errp)
     return caps_parse(proxy, qdict, caps_migr, errp);
 }
 
+static bool check_multi(VFIOUserProxy *proxy, QObject *qobj, Error **errp)
+{
+    QBool *qb = qobject_to(QBool, qobj);
+
+    if (qb == NULL) {
+        error_setg(errp, "malformed %s", VFIO_USER_CAP_MULTI);
+        return false;
+    }
+    if (qbool_get_bool(qb)) {
+        proxy->flags |= VFIO_PROXY_USE_MULTI;
+    }
+    return true;
+}
+
 static struct cap_entry caps_cap[] = {
     { VFIO_USER_CAP_MAX_FDS, check_max_fds },
     { VFIO_USER_CAP_MAX_XFER, check_max_xfer },
     { VFIO_USER_CAP_PGSIZES, check_pgsizes },
     { VFIO_USER_CAP_MAP_MAX, check_max_dma },
     { VFIO_USER_CAP_MIGR, check_migr },
+    { VFIO_USER_CAP_MULTI, check_multi },
     { NULL }
 };
 
@@ -1176,6 +1207,7 @@ static GString *caps_json(void)
     qdict_put_int(capdict, VFIO_USER_CAP_MAX_XFER, VFIO_USER_DEF_MAX_XFER);
     qdict_put_int(capdict, VFIO_USER_CAP_PGSIZES, VFIO_USER_DEF_PGSIZE);
     qdict_put_int(capdict, VFIO_USER_CAP_MAP_MAX, VFIO_USER_DEF_MAP_MAX);
+    qdict_put_bool(capdict, VFIO_USER_CAP_MULTI, true);
 
     qdict_put_obj(dict, VFIO_USER_CAP, QOBJECT(capdict));
 
@@ -1228,3 +1260,55 @@ bool vfio_user_validate_version(VFIOUserProxy *proxy, Error **errp)
     trace_vfio_user_version(msgp->major, msgp->minor, msgp->capabilities);
     return true;
 }
+
+void vfio_user_flush_multi(VFIOUserProxy *proxy)
+{
+    VFIOUserMsg *msg;
+    VFIOUserWRMulti *wm = proxy->wr_multi;
+    int ret;
+
+    proxy->wr_multi = NULL;
+
+    /* adjust size for actual # of writes */
+    wm->hdr.size -= (VFIO_USER_MULTI_MAX - wm->wr_cnt) * sizeof(VFIOUserWROne);
+
+    msg = vfio_user_getmsg(proxy, &wm->hdr, NULL);
+    msg->id = wm->hdr.id;
+    msg->rsize = 0;
+    msg->type = VFIO_MSG_ASYNC;
+    trace_vfio_user_wrmulti("flush", wm->wr_cnt);
+
+    ret = vfio_user_send_queued(proxy, msg);
+    if (ret < 0) {
+        vfio_user_recycle(proxy, msg);
+    }
+}
+
+void vfio_user_create_multi(VFIOUserProxy *proxy)
+{
+    VFIOUserWRMulti *wm;
+
+    wm = g_malloc0(sizeof(*wm));
+    vfio_user_request_msg(&wm->hdr, VFIO_USER_REGION_WRITE_MULTI,
+                          sizeof(*wm), VFIO_USER_NO_REPLY);
+    proxy->wr_multi = wm;
+}
+
+void vfio_user_add_multi(VFIOUserProxy *proxy, uint8_t index,
+                         off_t offset, uint32_t count, void *data)
+{
+    VFIOUserWRMulti *wm = proxy->wr_multi;
+    VFIOUserWROne *w1 = &wm->wrs[wm->wr_cnt];
+
+    w1->offset = offset;
+    w1->region = index;
+    w1->count = count;
+    memcpy(&w1->data, data, count);
+
+    wm->wr_cnt++;
+    trace_vfio_user_wrmulti("add", wm->wr_cnt);
+    if (wm->wr_cnt == VFIO_USER_MULTI_MAX ||
+        proxy->num_outgoing < VFIO_USER_OUT_LOW) {
+        vfio_user_flush_multi(proxy);
+    }
+}
diff --git a/hw/vfio-user/trace-events b/hw/vfio-user/trace-events
index 7ef98813b3..64fac9137f 100644
--- a/hw/vfio-user/trace-events
+++ b/hw/vfio-user/trace-events
@@ -11,6 +11,7 @@ vfio_user_get_region_info(uint32_t index, uint32_t flags, uint64_t size) " index
 vfio_user_region_rw(uint32_t region, uint64_t off, uint32_t count) " region %d offset 0x%"PRIx64" count %d"
 vfio_user_get_irq_info(uint32_t index, uint32_t flags, uint32_t count) " index %d flags 0x%x count %d"
 vfio_user_set_irqs(uint32_t index, uint32_t start, uint32_t count, uint32_t flags) " index %d start %d count %d flags 0x%x"
+vfio_user_wrmulti(const char *s, uint64_t wr_cnt) " %s count 0x%"PRIx64
 
 # container.c
 vfio_user_dma_map(uint64_t iova, uint64_t size, uint64_t off, uint32_t flags, bool async_ops) " iova 0x%"PRIx64" size 0x%"PRIx64" off 0x%"PRIx64" flags 0x%x async_ops %d"
-- 
2.43.0


