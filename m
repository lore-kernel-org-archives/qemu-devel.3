Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06C80C61DCB
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 15:04:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzy7C-0002Qy-FG; Fri, 28 Aug 2026 11:03:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wzy7B-0002Qk-H6
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 11:03:33 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wzy79-0008IH-Kf
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 11:03:33 -0400
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67SDUSPM3069614; Fri, 28 Aug 2026 08:03:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=4DbXG/hwvh6OhoT/IRHcWVOadOWpqZT6bCKBvzYid
 9Y=; b=SIbEAkQ8Hw3nyZaKgO65n16ZRVxHKWW01h1pML05B5ysFWp0wTpteFJKB
 lAFWl6a2ampNw3raMhBbrxnbxvS5aL8c/OBlYAPlcD3MCGARQGzjXgT1/mnZU5pz
 eXynzlb5qBQpz97kw1cc2+ZTJiDGLtPbk8wbhZ9Y70UJFskJYyFHX3YdWKvcJxVy
 W2M0FMWpoer6GLksLO9WazWne2hkE+8vw6GOo4Tb5iwScjIzGJGQzmdM/pspry3G
 VZd2rTzuUOPh2AHRzFCaJsXCg0CIsBQPUHO0szOFCyvsmMuOgDmBFTsGBLuLVJnn
 5aRspLoqRelCzVtmbPO1OjSAgkauQ==
Received: from ch1pr05cu001.outbound.protection.outlook.com
 (mail-northcentralusazon11020084.outbound.protection.outlook.com
 [52.101.193.84])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4gad5ccmw6-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 28 Aug 2026 08:03:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dHFetjH28NjcJejqizn76hYF2XS0/iOihScqtf/sn5vnB88gjcDJsoew0FI+kICIgslLYNjUDqiArrMfB9zcrlrWQLORNkpJ8teSrY9j4vtKdu4Mxg0x97KZAieEsG3UkyLf6vAXDsaVYIwG1SkhMtRqFfUU0aXEHkk1mLTWa5jLmBYivU6yuSrpk3DpZoErL5X4btutLYs0L18f+uL+obHiQQxD8yLozV4i8MoH7V4e/B0n2M9I2mfEXmK0VGuwv1+lIUjpwiY5xKMT4Dlm+kbWC4R6qu/HlC4ry1Y+6XOvkejse3mZdwiQ/m/jQMdkkiZdr6+aJE17trNSeYb8qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4DbXG/hwvh6OhoT/IRHcWVOadOWpqZT6bCKBvzYid9Y=;
 b=EW48njCR7d5wnrLGIGG0FQKZVkQBD1vOVxX/Jg3epqUm2+aXDF20JZfq5z+RCSgbNSrmgWUTjYwEi/CdTVYNbEjK/NobSXbcgkKLXNYYbmVq2NmYaMya/36+BUvP4QRawdNv9DMz6v9aXtp0OTwOiz6ecuAZejhhTE02KGGye6tEwNVzWyNGdwb3w9mUkNG+4Vd2AO1nYRspZw06aFaazOn7DbN4yLzwPeoTuxQO/PWP4jvn5wIxmGSO+xldknNLeIN8s27WQk1GpGu8056dzKVuYTWQ1kkl8fuNZWutSzn4dwd20jNr6MzVN3FGM26WhGCNv5Auqx/5lYCUv1oNdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4DbXG/hwvh6OhoT/IRHcWVOadOWpqZT6bCKBvzYid9Y=;
 b=wJUVYycqK9quKgL8yCpQ8WlYlMEBlXatlrZ0QCRSpFx9wPlAVkJl+Zc5yxYqA1zi/bIfQmg9dOnvnurSqezdMZcl9OGcWroNLhOy0gPe0v48IZe9Yu7us41XYGBaxYT2g4hkJLxjRq9z+wAGBOrMpnfZRORqDq4P7ehc/qHCn2WPXXjl0Rr963kMwsVDXfb3R9RExwfqrm2K9tWwu/6uHxhMJyVIi7B13Sspnpk6mdXFPEWnNAUD/goegcdF9PvqpgXRBpo3zN4ISbWw5YGELtYTUGbs1WXt42YJjP9DS98rksLtiucXr6KLJZnxvk6yby7WfoGqrR9muvdgX1uDIA==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by DS0PR02MB11917.namprd02.prod.outlook.com (2603:10b6:8:42d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.11; Fri, 28 Aug
 2026 15:03:26 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0360.008; Fri, 28 Aug 2026
 15:03:26 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, richard.henderson@linaro.org, mst@redhat.com,
 mtosatti@redhat.com, marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v2 3/8] qom/object.c: introduce object_property_set_alias()
 function
Date: Fri, 28 Aug 2026 16:01:59 +0100
Message-ID: <20260828150313.1883999-4-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260828150313.1883999-1-mark.caveayland@nutanix.com>
References: <20260828150313.1883999-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA9PR03CA0019.namprd03.prod.outlook.com
 (2603:10b6:806:20::24) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|DS0PR02MB11917:EE_
X-MS-Office365-Filtering-Correlation-Id: 231b047f-52f9-4ad6-b351-08df05158361
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|10067099003|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: F2FQCngD3NaUvpC+hcpxouhUhdNf79fJD45DLirFlyf+X+PFGvLuyYzuUvVfAUBsNvXz5eZ45YpsSVhDQwP/EzwS99QEx+O0ItJsyg7pqM/YT4KRIyqAxVeX3cfimJyRs/tYHsv60dTxIXtzUSApYSA1gQiBiItl3RTwmvLP+O6dDgdN/c8TWX59UuScRC+m0w3TITe49ZDtlA+k0kSHbQy+2qwsEBQCCG3hbXG625BNJzHcvmqYGOfrgIXreBnBFHjnW0dKAvXTTjj6/xhDXcuCa1HnL5fAmW6Ev+MrHr6Nq1K/prtyIP1UFLuG4sggRflmFLFeRuq20Rp51C55udliu6/wUh+PYkWzsAFoRG34gfJ0AO5PCcywB9VDkk5erYKk6YcptjyiDjXxy3c6HlhPMMwR3TjENMh7qUxw3jDxmsblt4fqNFpNxqaiyuWX4tQ0op6c+RdqBmRz2Y73BgXXtZ0VQ5Ghz8l0jj+Jj6SDp/KJY/MHeiQpiuub6b3BZU8h5oCiP6fZ5fRbzH19MSv+6Czo0nZY6Clb77TEMlOBxqgJ22loxzATRi5TRfHCQpBaMH5oMq324zQEBDReqiPFJEhZz7drQ2K9IWSzDJzdfhi7cAgS5ycEUEzmeJhsPXoJN5t76XdlhcG3kbLGUNZKhzQa6zwxqwGVhvZ0JYA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(10067099003)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?a0Kiz6Cx3naux1sc35PF2drcmcD94cJWgj4FkcdmAh0wl+ujptgD41xDoRtt?=
 =?us-ascii?Q?Vh1ryafBeOjgQpDHGPjh/GTndvAHDeuC/zdFmiSyYjGl0awPuBphh3egxgka?=
 =?us-ascii?Q?UM9cFffwUCepQsskMHqijacT2R4if7GunzjE82nO8SCO1bd/LDVz6s/W61UR?=
 =?us-ascii?Q?K3Ggh04oWNdYWE+UJdo9mSB3+HJjwcgrErYFTwxxhwxxosLFRqt0HaXTnNH7?=
 =?us-ascii?Q?itsZskk6rq5t9Fqi1Cs2i3VL6kZhc+nfqIoKJ1j7hhAFD72SGZscWW8fTrAa?=
 =?us-ascii?Q?id2tBL07tC01fHIav8NAyFwkd0mcJkyLZCTNsRjgB5Yfh+5Gofc/Je4r46yp?=
 =?us-ascii?Q?VsY4hslwdO6owjqK/wpfhlWx8K/SzuJjTTWQl7NWC/kxLltBggyitW0TBHiy?=
 =?us-ascii?Q?hrYNj74fYStlNRIs9qJfgHd49ekCH6JAASPzYTCd71cew1wIxFFgdFtP9Gtr?=
 =?us-ascii?Q?zMzkRh/ntzEyl6Xbz7PSCo+ViK07MGICK/HfN7k+0Rc98vkVQDFMjHuH65mt?=
 =?us-ascii?Q?4ix4DaHVtPbVJhQeduYNHCcHeYZk6TE0jy8trlf4k4cYiwQc5FaknFwLmTTA?=
 =?us-ascii?Q?a+Fs4c+z4zorfH54kbewzTcsWXEKZYMz6u4csvOAp7FZpLYRuKC4fpOM6FS5?=
 =?us-ascii?Q?OFcJBXd40Jy7PyIKqgAcgpRLm78h/cuQJvZVb4ce6dIRMACh6qwOv7DyMgKx?=
 =?us-ascii?Q?XqQrj9O7R6vxyelFHYTadIm/UefaIEBg0k+GEqSiZEDQ0h3NPpEY+TbsIzmF?=
 =?us-ascii?Q?Xbs74o4ytypKQXH7bpQzYcSRaciQguh86rtBfXJSVFXZH/erLiihaCAF0rcl?=
 =?us-ascii?Q?W6Tr4x9oRxXya52PvlfLBh+PSkaTmTybypd5k1mdXg+yHqi8TSjkn9GVjz4v?=
 =?us-ascii?Q?czzwHyhqYlIQ99HDzDhAFNwY/+E08nTOTlk7swZGZPBW/KrRQY4X/+qcV1+Q?=
 =?us-ascii?Q?xvunoDeJvGgIxPL4Iq2KR5cIXVSjv4QHIMT+UZDMzog2DdG+OY2wdJbqG+IO?=
 =?us-ascii?Q?xZKVqCAK+FaAUTKXroHVXhEfVYiJd4tQ+l34hftYmc0bHh/I5yV/PLbhigkT?=
 =?us-ascii?Q?eC3vaIForxYrAFVwCjfqpJdSctUkAgaSfx/wrU+Of8B5QUcbtozlWZLMx8F9?=
 =?us-ascii?Q?D09+n3TfFhixradHjbuqfll+X7fA7qQdJ5zPH5w6tJcgt+/blUFDoDOyBeQD?=
 =?us-ascii?Q?w3c8yTOv1+7vwMtGu+qpP4o56KLNP5bFSOtIeKJHcIv/6StzShci+7qYeRpW?=
 =?us-ascii?Q?/3qHHy94fmTLHT4THOuqGPIOKqAZ/sDyDx85H0ZmNgAkpEZJ/eyS+wD1U2yc?=
 =?us-ascii?Q?ENvddna6ym89yYwvblbhE8x3uIKfzu26YndLBmxYUh8TRu/UpnnH95uY9wid?=
 =?us-ascii?Q?LgkkM7hvlbryR9IaOSHpF9wfsJtWyBpPKmsum0YQ3H2JQdU2/2oIQvUqU8eN?=
 =?us-ascii?Q?EFUivisQZ1BNE1Y81qrSH2j4UJ2ZJwf5WhLUJ8hPcpU+zowH3E1HotoU64gs?=
 =?us-ascii?Q?3nNFsG7Ip7MKRaBPRaabUFvpFVumvEatgKIlg2S/9BsU+w3J8Ib3K0/R/NPG?=
 =?us-ascii?Q?N+idwtWnr6DBCH2QS+wC38kX/KrrW3Ye/OLNfOeimaDjCZW3kdq+2x8SrBUJ?=
 =?us-ascii?Q?IqFCZ6e8/Sv25T+W+LI8x7z0QaxBe9FVhBDjTeY6JRxb7z7qiBmAQ9fQUpzs?=
 =?us-ascii?Q?LK9/bOjpS80ebzxRgxPKK1MAcZX+0BrwCPm7F2/K2IUVr6/JEhLB3F3KuWjX?=
 =?us-ascii?Q?HE4BEKTT5Qf1GuyhES1hpRwCmxyLCbM=3D?=
X-Exchange-RoutingPolicyChecked: EbN3aG8YX0caHlDO1j0ZJlSD+/DIj0QIb8yEzXpGKu9gs9qXZ1j+xHbGWkknrFR3ZFBKNobSU8WG8K/XJn9g/+u75XRxMY86O50RK01mlc3qPwV6tyW++0U+NEtY4VsOykUZf1iqKyiOJ50dJhn1kEsUjJuCz/akA0Z1wsLO2dLlczgVgjqo5xFObTFZSO0jz8Th+HroKtX3OoSA4/oirW0FTgUwj3gNByhK3t41v/pcRIHgAOOLLzfBinU26FgbJvZUaS4XVk4r3MV+plhrtJR/nHYHEZYH2aZypL4fPv+0N7NgkOCAnmQDvu2bydCaD3XUytdVtu4PtVAJEAkz8w==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 231b047f-52f9-4ad6-b351-08df05158361
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 15:03:26.7421 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L3RiWEZ71p730hE3+ApVm1hXl1aWYv0m52LT2YvT/4N2Mbt+r5PPfOs/nvi00tFbE4AljEqZNCFCiJx/XFzgmCqO4+uz3LyVBeE9PpTtisY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR02MB11917
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDEzMSBTYWx0ZWRfXz6fibZdqyywp
 AoWKQWvA4jCWsvzWIhtyCMXYLg5DsML39+QqK3h7RcDPSe7v8Z52RIdxLQIr4SYyFMDT61kgruK
 OwCEQICF288/qG70qEUVQMsGN250GSA=
X-Proofpoint-ORIG-GUID: 7ILGmcG3-bsqW5U5O9ZVTLng5oK-bFu9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDEzMSBTYWx0ZWRfX+VkntnobLi6k
 yWA5nlnjdscACfOT5BBEknKExe6atmxRpGqOVdOz7negi6wxH5KFTrsDlgPS7HzZ3Z7j2wZX5Wv
 mB8KX3PT1muUHx5EJJHLo5e3y7rjz9gFkzdoXuphVvpTbz8pVkP3Zk/w+nPl0YKlOhi6MfbuUA9
 eiCGiYhB8VHOMap63eFyZ7r7o18ncic+i6bBxL7aa0Bw9mj93a8qD5lZLRM0UnK+Fanhr++NmMs
 pflY2/PDOzS2DfPYZEQHB1xY9ZlKhojil1hzeL2vEFHeeq0uYqAVUdAWTM8wwybEW1Kr8MPmEV1
 QNVffVLmO0No4sITusobV8r2SuMZ4x4BDMOQKSzF+5Gj2Z7qrFLgSH6wlvT1RxI0Du6TeHTjT6Y
 3s44txt4Rv7URkvl1sq6+40kNPfCZcBJ2QG5iIPzicNsAoYFiXxA3UpDr12BThCWK8F4Bm7tbaI
 QvgDg8aZVG8vJBWW2EA==
X-Proofpoint-GUID: 7ILGmcG3-bsqW5U5O9ZVTLng5oK-bFu9
X-Authority-Analysis: v=2.4 cv=Me1cfZ/f c=1 sm=1 tr=0 ts=6a91a340 cx=c_pps
 a=n68PQVbWKEFYfOwbXA7NlQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=Sv0fKeRqtYgA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=Ap8k9tRZuQ82DLYWQqG7:22
 a=64Cc0HZtAAAA:8 a=js4qBuqN0DX5_KR7ZAkA:9 a=+jEqtf1s3R9VXZ0wqowq2kgwd+I=:19
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_04,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

This will be used to set the class alias property for a specific object. Note
that this function is only required for class properties, and will assert at
runtime if an attempt is made to use it on an object alias property.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 include/qom/object.h | 13 +++++++++++++
 qom/object.c         | 19 +++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/include/qom/object.h b/include/qom/object.h
index 1c51944786..30dbb7850b 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -2294,6 +2294,19 @@ object_class_property_add_alias(ObjectClass *klass, const char *name,
                                 const char *target_type,
                                 const char *target_name);
 
+/**
+ * object_property_set_alias:
+ * @obj: the object upon which to set the alias property
+ * @name: the name of the alias property
+ * @target_obj: the object to forward property access to
+ *
+ * Set an alias property on an object to point to @target_obj.  This is only
+ * required for class properties, and will assert at runtime if used on an
+ * object property.
+ */
+void object_property_set_alias(Object *obj, const char *name,
+                               Object *target_obj);
+
 /**
  * object_property_add_const_link:
  * @obj: the object to add a property to
diff --git a/qom/object.c b/qom/object.c
index 873083618a..cdba586a62 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -3208,6 +3208,25 @@ object_class_property_add_alias(ObjectClass *klass, const char *name,
     return op;
 }
 
+void object_property_set_alias(Object *obj, const char *name,
+                               Object *target_obj)
+{
+    AliasProperty *prop;
+    ObjectProperty *op;
+    Object **target_objp;
+
+    op = object_property_find_err(obj, name, &error_abort);
+    prop = op->opaque;
+    assert(prop->flags & OBJ_PROP_ALIAS_CLASS);
+
+    target_objp = object_alias_get_targetp(obj, prop);
+    if (*target_objp) {
+        object_unref(*target_objp);
+    }
+    *target_objp = target_obj;
+    object_ref(*target_objp);
+}
+
 void object_property_set_description(Object *obj, const char *name,
                                      const char *description)
 {
-- 
2.43.0


