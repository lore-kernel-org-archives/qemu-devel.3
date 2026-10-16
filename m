Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C83F7CCA46C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 14:24:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHiqp-0005Dg-C3; Fri, 16 Oct 2026 10:24:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xHiol-0002hE-Ke
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 10:21:56 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xHioh-0006iJ-VA
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 10:21:55 -0400
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69GE58qj3551722; Fri, 16 Oct 2026 07:21:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=7wm8uo+H49sktKaMqKuuL2u6+/dMUEYN+P4+MkpQf
 Kk=; b=J/ogjivdRZTBu4UWvb36VWwVIB4+Nb2Ybv5zPPmBlyolsmywEGDcFCfLq
 HbvsfBRFNVUrg6sxCvLVaRaURwFJlOj5V1mGIcfKB/ZELThlcGO+r1A96utJwhDS
 MZELg0v5MDbCWftRb118zf+gtJjUseYk65V6u8WQYwauhvIGfWzRnaKhTf8JsBDa
 AIu/cJwtPvtYhfzFZaY3wsFYHuwj+4qWNWQKVtM1byPU9jJCshUJlCfCS6UaMKfg
 uIUHWld/o862ZhdOQgFwrIHqYfCZN7KOR/U84mJbJPAxTQ/A6X6VGNvMLNgjdl8s
 YQQDskGVxQAV4bCwqq5Zk0cNzdbvA==
Received: from bl2pr02cu003.outbound.protection.outlook.com
 (mail-eastusazon11021136.outbound.protection.outlook.com [52.101.52.136])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4hbmjc04x2-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 16 Oct 2026 07:21:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j5TgSb3bAmf8XW9YFkdXfORzdgb63mnvN5wHtPw1jAwvmVpKcNqZw86oHvbLNh4eqLTvd/YTJyLNV5Fyk2Zxty++YW/spW+gRxBWwZ6WB4tx76/fvLb1mnYkapNVWfgEvX/nd2UG/ZbcCI7M1sTmOKY3txE7pEDbeanRvN4l+PHmsBPcDQclV80+xoB9RMO6DrV+Dcf5tZlpSM2hMnXduwZvQhf5TYxMYdBmTyiu54mdtpJw4EN7BkVzVFe4b63zBpHaRkP/jLS0ofkBnrXkMemfthSZx0AoyT1jUkWbXZ9jW9tQZwwBrSp6/H/fqtt62y2oixvpXGvhdQe9Y0XRdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7wm8uo+H49sktKaMqKuuL2u6+/dMUEYN+P4+MkpQfKk=;
 b=h/IzCudwVqVesqmTmBDFuuVzplccrTV88pIKeWWSaVY14zuMRuurwVfiNdn4bRUFz0dRJfKw04p0QGZkEa27fxSl3Wa7MUYe9edDkrsUOOBbucIkYZJWoN+t+oCnjmFKYd76Qh4u09WXHqtuWRn8IsRIcKkMY2MWiE3T8VzkB8xpCuY11qrE982cCXp+zmwU6FvIoCI7uIx3VaM49seRp04aUW7+IRRlAhLc+7QhlaU2XRtI/vW//wsIymMFTZ3asoT82b+04xesXQnGGwkcnJKGrMX+dbagKUMGWMYtKyHEU+iJHbDsrOqk+SRtyvTCXIICz1Wc+QlYY54QTy8OiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7wm8uo+H49sktKaMqKuuL2u6+/dMUEYN+P4+MkpQfKk=;
 b=UE8se7vzaoge487CALbsKNnVea6zMYuJhom1LIrPDE5SZ2tvMWlMlR6uycnQLOpocyYe7PVdNKyhY+9EviO9FsCwijKWmsTNuLyVwUxKkDXLw8fGc++tvzS/ekadRWb6ijQxsWbKIkgr0pCOfHANXiJz+4CSg30C0tqeGfKW+Mxf364jQkjyIqkicn61WVZutrjz96z9Lq5qFm1/gCOps8oTQoN9MVhRIYIvM0O/9maNJ3GDjyT9OlnzJFwVusxtmsWB7XMivICQxo9ls7jS+kp0JlHOdHqjgKCMGQtC2F04jwmlnuFHsXM7kmsdMqb3+OFvN6j8yDT9h1L07PO7dg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nutanix.com;
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by DSVPR02MB11424.namprd02.prod.outlook.com (2603:10b6:8:352::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Fri, 16 Oct
 2026 14:21:26 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%4]) with mapi id 15.21.0522.016; Fri, 16 Oct 2026
 14:21:26 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, richard.henderson@linaro.org, mst@redhat.com,
 sstabellini@kernel.org, anthony@xenproject.org,
 edgar.iglesias@gmail.com, qemu-devel@nongnu.org,
 xen-devel@lists.xenproject.org
Subject: [PATCH v2 12/27] i8259_common.c: use i8259/i8259_common prefix for
 functions
Date: Fri, 16 Oct 2026 15:19:18 +0100
Message-ID: <20261016142031.1204281-13-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261016142031.1204281-1-mark.caveayland@nutanix.com>
References: <20261016142031.1204281-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0132.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::17) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|DSVPR02MB11424:EE_
X-MS-Office365-Filtering-Correlation-Id: b081d4af-9d6b-46b5-1cd5-08df2b90c34f
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|22082099003|10067099003|18002099003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: 6J/TG061G/2Og8vvbzOPvbLMYwhw57cMd3mio4M+z9DHkpblpVyTGpKOaaAaJeJA1gFUOPxrMCMHPH8Ee+fCN5Fj6YUX7REqAqZ/F7nxOPv/nQsRSEGK4L2fTFSNutlRncdP1ewnf7iJ0wnkxbzZZT3qsIWnjdJmOwYpcQTZB4hQrJFJzNBSk8zr776iHGM4aID+O0kt6k4Cf34xoQo+hA53KXFFBZbdCR481HK8EiB8t/lQ0UD6q1fwNmx3hkNDcdLpED2stjfV+aDa4FgxRbAWXX1XmT7GNZpUY54+ZRDay5wHvUee953laCmyOF1I5tgNmrsM3XxYSlRA5zJDszzu0wGhPeVr1oS3qU1P7hiy1opHMZjPsGJZ8p6X/JfowOCDtpvGxx+W0Fq7VKX0RWQr8/6guZRN48Y7Wn9ZpBADIKhOcOhREJY3p/83w/mFq4uDKUFjSfdwBGZ2kxs00L4jIOn3daoFct0fZnhIBLjWAyh59tHSaTa7qtYg7+rzKNQ+x+EUndLAxF1SZeDw3wTG4mLA/4dPIYqfRyFZr3pigb3ZqSPz7+mZNQ2C9fHYEEXDK6xo8J+25HdDGdteSoaUacEKx+LVylUaaoxQNwn3R4+9+8zqn5m+0MSJk/RBypCkzngA2VpGIvPX0pVuKYSkyqk2O8kCZz4IUmwSrzw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(22082099003)(10067099003)(18002099003)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?whHHokDE7/7DBpY3oMtS4z9QBZf+XiU8oZShBVguabV7B5fG417/KKStXQ6M?=
 =?us-ascii?Q?6QjKyPI4xfHsLZh2IUSAQG5253x287XNcscJvrhlaALA/eaeBlR+cBc84XNB?=
 =?us-ascii?Q?VDfP5YqbawsuJUwo9niDToLB63OgOc4O7kNXZ80ysDM7aA0DBGZzMzoNzBYJ?=
 =?us-ascii?Q?piHDlT34KJ96wkonNp3mH375j07Rpiv+obwKmjvsv1FoCZMShtWvlg/ckm8s?=
 =?us-ascii?Q?Ple/RQUXAJb83TXGSFo9laLozZG4nIVtvR30rehvirco2hbMUU3TeFWAbYgH?=
 =?us-ascii?Q?mWbRw+0VXcIusPBWOdeFMUvmmn7RpN728+du9C5z1eHZl9U/MaJ6iTDsyrlF?=
 =?us-ascii?Q?mVL04r99jbU5QjPAOQ31BPHKJj16285Xt2l8uxvBYZ/aQ/I+0jXnWmu+6hWY?=
 =?us-ascii?Q?iM6UZrZLrr+muTFwK52r0EHxMF3xCaDbCcxWmAadjbAi/6ysABckfMsdIJEJ?=
 =?us-ascii?Q?82/iCvI71z+GAk/7ozLgIEI1spon/H6jJS+jZuUy9XqKL4eKf/NDrqNAiAkS?=
 =?us-ascii?Q?1UgF/a0NXUxx4FMOyDF3D6wmEUMWwKmooSY4mEup2rHYIFTbD0FuBWr4XKNB?=
 =?us-ascii?Q?tcqeHFufsRe5wsHwYtYZdMVP/KpeNNvYdwUBjoU36IjClc6yu14gCubJEYYc?=
 =?us-ascii?Q?KjCUtTVkc/JLQM/9QDxJu/994NhD4mBM7B+3X89KwkrrgaaMfkI4P3TbyyeU?=
 =?us-ascii?Q?LPGg+48eY24du3eXQYcKB/LjC8DcsSmZUQrt5MB2ojTytbtH8XdVnybkfWZU?=
 =?us-ascii?Q?5eccLw4bu1K7uwKy/Eoo2sL/5FuTGSaixt1dJZBptmEmEcKTEF9+AMBqyJOn?=
 =?us-ascii?Q?xJiL7ASt/awrqYqdH1Ck5uRbIQur+HG5XpEeKGSMmJaWLZQ69rEOIolFQgij?=
 =?us-ascii?Q?Hfb4hZGVh/Lk4J3ANK8dRMXReLwtWTEI4PKKqDoxURfXJmeHWdCqlmvlJbYn?=
 =?us-ascii?Q?1u3VNiOZTZBlr4nxC1vbe/mSnztEnCrrE3cwQUIdrfc4qCJCOKPBsqZcmF06?=
 =?us-ascii?Q?MDEvD1k8nMf244z0CI2fwKlRjfY/MLK8lOSOENEil7nhTygWCEi093NMhl9o?=
 =?us-ascii?Q?wqYCqTB7YngAhDIPmxxUS8dygbh8F/ldaez6mFs11EXWHNHygUmQ14MR9f+p?=
 =?us-ascii?Q?Ja8cIv+OUlXhvZXHjM38mREnrW+wHNQiinklHWpad3jmB0Yr4teZ+egKnd5Y?=
 =?us-ascii?Q?vcZe5cot4P7Yf23H5tkF7tqjNSlUh4RRHe3ejO1kY4St7Kpi4SmRliSPn82T?=
 =?us-ascii?Q?xMLtx9+ss22fkG4n8S91Lsnoojal5ii06hVnlgITwo4tBczDX/CY26Y3YxXN?=
 =?us-ascii?Q?GD+9HHfwfaZCshy6nXWzMBALK9NS4w1Q7re/8w9pjkYVM7q4yDLjnmWhkrcI?=
 =?us-ascii?Q?KdVNwBcOCNGt/tjSkgaghFI133Sg63B3gdY2jcl+sWdgKnYVshaThRZSvicQ?=
 =?us-ascii?Q?UualU/lCavbjMxRGGknHNcFyQqktcYJcxbu+GIzbKsoJMVUz0jDMdnKfVGTF?=
 =?us-ascii?Q?0JzUUncvfs9ldyqwJHfyr1exl3UQwy6QzOFTP06Vkn6/h0l1HyS330jEImxX?=
 =?us-ascii?Q?sSxRx/LWl8yYwumECS1U9LOl1ZVLULOtArgMAJijI/gRkTl25vrF34VFISjU?=
 =?us-ascii?Q?f8eqG3+wyklEiF/Mt9H3Oz3Gbjhg2qHL6oUqH1EvL11uqrm0fjxFnUSsosp/?=
 =?us-ascii?Q?V8vLiqYJGx911mPQ/0JXdAp4ONWA6nYH23ezshlTK3SIRZrAHITe54wcDjDJ?=
 =?us-ascii?Q?DlLJZMH60LrEAJrZOR1Q10uXTIm+/tI=3D?=
X-Exchange-RoutingPolicyChecked: Q5mzRflAAdInlAeN/LzOtTWFtCgHz8OixnxKvVtQNDdzZH82R81JabFOwK0r6RL5xkGa20XJV3VpCx8DZ0YjJNu9aHuCCJrfrXB/wTVr5lduJYcfT46M37FZ/pZBQHxJWF11h3oYiSm7sAu1iAVe7GKs0x8TU/8B9/xN8XsSgZWe1+gTOQKDzw26NzOZ4YdiEUeSeLem/wqj8vsZoJPJddhf2TZeLozgktEPh/UUbVpzq4+zf1mkib1/2YXvAjLp0DzQ/2KFdj6MBlftv2Q4jBf5gbnZb6W/ZivDwT1u2PJ+hUMmpdt0LVpqEJcgHu0G5xArT803w9/Qk9IBiJaa5w==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b081d4af-9d6b-46b5-1cd5-08df2b90c34f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 14:21:26.6435 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 52OWT8buigIxgYyDFQMwPj8EyFrppwTj4ARP8tWVxjoEWQsl1ScvYqWhcx3TVn2B+w8e8WXBqR1oGK7wmNwnWhQoFR4ihAQdvR/RBNQQ3Q4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR02MB11424
X-Authority-Analysis: v=2.4 cv=dasVTnXe c=1 sm=1 tr=0 ts=6ad232e8 cx=c_pps
 a=IN/ktsHfyviFoRwGlsjPrQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=Ap8k9tRZuQ82DLYWQqG7:22
 a=64Cc0HZtAAAA:8 a=KKAkSRfTAAAA:8 a=ox8dIxdxdu1w5TD4ToMA:9
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDA1NyBTYWx0ZWRfX51btV2DwH9hY
 M8zynJTNZG+RS0mBufpa0W+3R5crP3waGo/vLGsZD43SMUN1Rd8KPO2UqaNxOq7MYFF2f7k2wIr
 7h1cea1cDtg179AmWM4PV2585UM+z2BWxt3iPEhuvUnbcjQz0iiwfYAVirSmvqcPIrleN/9aE1P
 L/sifSMTBqr4W/QhuNpf/eP1ACGo9CnI51CRmXReVltHL4Cd7uHDyqG5xU0xJAXFs83XFgG4RFK
 lG8PIELYqTNoLdj1z0w1TtTwQqvv2LH3E9v97RlFFqJ8yuD+ZM1Px+VWdvTE4fNehqXKHmUw5ih
 uMNvfrYT9t1Qw/faWnGoKfwY+Ygzpfwu7ts304em7u9E7thzCa0NclAOMillyK7x8H/45s8VOIK
 uEdBl1kLZOqDqGweQAlhILGAJDTNK8UgICegf4/SOrt3n+L4Sqa+8jJGezSg2E+fG8+qfJXjBLy
 FG3fwHP+n0vvaAtbaoA==
X-Proofpoint-GUID: 0u_bCT4tLOdJGIP2w5C4kBHRxEuLytxp
X-Proofpoint-ORIG-GUID: 0u_bCT4tLOdJGIP2w5C4kBHRxEuLytxp
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDA1NyBTYWx0ZWRfX064D9u/KYzOU
 +Ft0DmQL30uStHFS4B6VDS07oqAgwXMHH6RFk5xKWJ+I6/s266Zwcl/uZ6v9b+SrdeO5PlK8Twe
 QiJ0W3GyNMV8aLo0TP8ap2WLIPojRks=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-16_02,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This ensures consistency with our normal QOM-based naming convention.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/isa/i8259_internal.h |  4 +--
 hw/i386/kvm/i8259.c             |  4 +--
 hw/intc/i8259.c                 |  4 +--
 hw/intc/i8259_common.c          | 49 +++++++++++++++++----------------
 4 files changed, 31 insertions(+), 30 deletions(-)

diff --git a/include/hw/isa/i8259_internal.h b/include/hw/isa/i8259_internal.h
index 71fdd74266..644508a44e 100644
--- a/include/hw/isa/i8259_internal.h
+++ b/include/hw/isa/i8259_internal.h
@@ -70,8 +70,8 @@ struct I8259CommonState {
     MemoryRegion elcr_io;
 };
 
-void pic_reset_common(I8259CommonState *cs);
+void i8259_common_reset(I8259CommonState *cs);
 ISADevice *i8259_init_chip(const char *name, ISABus *bus, bool master);
-void pic_stat_update_irq(int irq, int level);
+void i8259_stat_update_irq(int irq, int level);
 
 #endif /* QEMU_I8259_INTERNAL_H */
diff --git a/hw/i386/kvm/i8259.c b/hw/i386/kvm/i8259.c
index 86b1ffea4e..3a960e48e6 100644
--- a/hw/i386/kvm/i8259.c
+++ b/hw/i386/kvm/i8259.c
@@ -108,7 +108,7 @@ static void kvm_pic_reset(DeviceState *dev)
     I8259CommonState *cs = I8259_COMMON(dev);
 
     cs->elcr = 0;
-    pic_reset_common(cs);
+    i8259_common_reset(cs);
 
     kvm_pic_put(cs);
 }
@@ -117,7 +117,7 @@ static void kvm_pic_set_irq(void *opaque, int irq, int level)
 {
     int delivered;
 
-    pic_stat_update_irq(irq, level);
+    i8259_stat_update_irq(irq, level);
     delivered = kvm_set_irq(kvm_state, irq, level);
     kvm_report_irq_delivered(delivered);
 }
diff --git a/hw/intc/i8259.c b/hw/intc/i8259.c
index 700412df74..97ecb77407 100644
--- a/hw/intc/i8259.c
+++ b/hw/intc/i8259.c
@@ -124,7 +124,7 @@ static void pic_set_irq(void *opaque, int irq, int level)
     int irq_index = cs->master ? irq : irq + 8;
 
     trace_pic_set_irq(cs->master, irq, level);
-    pic_stat_update_irq(irq_index, level);
+    i8259_stat_update_irq(irq_index, level);
 
 #ifdef DEBUG_IRQ_LATENCY
     if (level) {
@@ -215,7 +215,7 @@ int pic_read_irq(I8259State *s)
 
 static void pic_init_reset(I8259CommonState *cs)
 {
-    pic_reset_common(cs);
+    i8259_common_reset(cs);
     pic_update_irq(cs);
 }
 
diff --git a/hw/intc/i8259_common.c b/hw/intc/i8259_common.c
index 705a28ecbf..31bd663439 100644
--- a/hw/intc/i8259_common.c
+++ b/hw/intc/i8259_common.c
@@ -33,7 +33,7 @@
 static int irq_level[16];
 static uint64_t irq_count[16];
 
-void pic_reset_common(I8259CommonState *cs)
+void i8259_common_reset(I8259CommonState *cs)
 {
     cs->last_irr = 0;
     cs->irr &= cs->elcr;
@@ -53,7 +53,7 @@ void pic_reset_common(I8259CommonState *cs)
     /* Note: ELCR and LTIM are not reset */
 }
 
-static int pic_dispatch_pre_save(void *opaque)
+static int i8259_common_dispatch_pre_save(void *opaque)
 {
     I8259CommonState *cs = opaque;
     I8259CommonClass *info = I8259_COMMON_GET_CLASS(cs);
@@ -65,7 +65,7 @@ static int pic_dispatch_pre_save(void *opaque)
     return 0;
 }
 
-static int pic_dispatch_post_load(void *opaque, int version_id)
+static int i8259_common_dispatch_post_load(void *opaque, int version_id)
 {
     I8259CommonState *cs = opaque;
     I8259CommonClass *info = I8259_COMMON_GET_CLASS(cs);
@@ -76,7 +76,7 @@ static int pic_dispatch_post_load(void *opaque, int version_id)
     return 0;
 }
 
-static void pic_common_realize(DeviceState *dev, Error **errp)
+static void i8259_common_realize(DeviceState *dev, Error **errp)
 {
     I8259CommonState *cs = I8259_COMMON(dev);
     ISADevice *isa = ISA_DEVICE(dev);
@@ -105,7 +105,7 @@ ISADevice *i8259_init_chip(const char *name, ISABus *bus, bool master)
     return isadev;
 }
 
-void pic_stat_update_irq(int irq, int level)
+void i8259_stat_update_irq(int irq, int level)
 {
     if (level != irq_level[irq]) {
         irq_level[irq] = level;
@@ -115,8 +115,9 @@ void pic_stat_update_irq(int irq, int level)
     }
 }
 
-static bool pic_get_statistics(InterruptStatsProvider *obj,
-                               uint64_t **irq_counts, unsigned int *nb_irqs)
+static bool i8259_common_get_statistics(InterruptStatsProvider *obj,
+                                        uint64_t **irq_counts,
+                                        unsigned int *nb_irqs)
 {
     I8259CommonState *cs = I8259_COMMON(obj);
 
@@ -131,11 +132,11 @@ static bool pic_get_statistics(InterruptStatsProvider *obj,
     return true;
 }
 
-static void pic_print_info(InterruptStatsProvider *obj, GString *buf)
+static void i8259_common_print_info(InterruptStatsProvider *obj, GString *buf)
 {
     I8259CommonState *cs = I8259_COMMON(obj);
 
-    pic_dispatch_pre_save(cs);
+    i8259_common_dispatch_pre_save(cs);
     g_string_append_printf(buf, "pic%d: irr=%02x imr=%02x isr=%02x hprio=%d "
                            "irq_base=%02x rr_sel=%d elcr=%02x fnm=%d\n",
                            cs->master ? 0 : 1, cs->irr, cs->imr, cs->isr,
@@ -162,12 +163,12 @@ static const VMStateDescription vmstate_pic_ltim = {
     }
 };
 
-static const VMStateDescription vmstate_pic_common = {
+static const VMStateDescription vmstate_i8259_common = {
     .name = "i8259",
     .version_id = 1,
     .minimum_version_id = 1,
-    .pre_save = pic_dispatch_pre_save,
-    .post_load = pic_dispatch_post_load,
+    .pre_save = i8259_common_dispatch_pre_save,
+    .post_load = i8259_common_dispatch_post_load,
     .fields = (const VMStateField[]) {
         VMSTATE_UINT8(last_irr, I8259CommonState),
         VMSTATE_UINT8(irr, I8259CommonState),
@@ -193,21 +194,21 @@ static const VMStateDescription vmstate_pic_common = {
     }
 };
 
-static const Property pic_properties_common[] = {
+static const Property i8259_common_properties[] = {
     DEFINE_PROP_UINT32("iobase", I8259CommonState, iobase,  -1),
     DEFINE_PROP_UINT32("elcr_addr", I8259CommonState, elcr_addr,  -1),
     DEFINE_PROP_UINT8("elcr_mask", I8259CommonState, elcr_mask,  -1),
     DEFINE_PROP_BIT("master", I8259CommonState, master,  0, false),
 };
 
-static void pic_common_class_init(ObjectClass *klass, const void *data)
+static void i8259_common_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     InterruptStatsProviderClass *ic = INTERRUPT_STATS_PROVIDER_CLASS(klass);
 
-    dc->vmsd = &vmstate_pic_common;
-    device_class_set_props(dc, pic_properties_common);
-    dc->realize = pic_common_realize;
+    dc->vmsd = &vmstate_i8259_common;
+    device_class_set_props(dc, i8259_common_properties);
+    dc->realize = i8259_common_realize;
     /*
      * Reason: unlike ordinary ISA devices, the PICs need additional
      * wiring: its IRQ input lines are set up by board code, and the
@@ -215,16 +216,16 @@ static void pic_common_class_init(ObjectClass *klass, const void *data)
      * code.
      */
     dc->user_creatable = false;
-    ic->get_statistics = pic_get_statistics;
-    ic->print_info = pic_print_info;
+    ic->get_statistics = i8259_common_get_statistics;
+    ic->print_info = i8259_common_print_info;
 }
 
-static const TypeInfo pic_common_type = {
+static const TypeInfo i8259_common_type = {
     .name = TYPE_I8259_COMMON,
     .parent = TYPE_ISA_DEVICE,
     .instance_size = sizeof(I8259CommonState),
     .class_size = sizeof(I8259CommonClass),
-    .class_init = pic_common_class_init,
+    .class_init = i8259_common_class_init,
     .abstract = true,
     .interfaces = (const InterfaceInfo[]) {
         { TYPE_INTERRUPT_STATS_PROVIDER },
@@ -232,9 +233,9 @@ static const TypeInfo pic_common_type = {
     },
 };
 
-static void pic_common_register_types(void)
+static void i8259_common_register_types(void)
 {
-    type_register_static(&pic_common_type);
+    type_register_static(&i8259_common_type);
 }
 
-type_init(pic_common_register_types)
+type_init(i8259_common_register_types)
-- 
2.43.0


