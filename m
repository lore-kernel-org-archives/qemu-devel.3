Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8031C5DF7D
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 11:17:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxNEa-0006i1-Ki; Fri, 21 Aug 2026 07:16:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wxNEZ-0006hE-49; Fri, 21 Aug 2026 07:16:27 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wxNEX-0002De-9n; Fri, 21 Aug 2026 07:16:26 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67L9Q9091873693; Fri, 21 Aug 2026 04:16:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=xNmtFRoQQFNvOoKR63Ahz4aTn5W38c50rvX1NNi++
 Fk=; b=yhKXvWa+p1K7zy4G0wyv7suwAz+sicUaFjiWfwgeqfOr124xgeYe5Bhgn
 sKTeuiUXHRHHk1RvScjFqkcn7AL+x6M/Pzau7S5aF/C+UTaZzgtbUtBNLSnonX5j
 cn1C5zDxuqhtl+vLOpfag84yYC5MECUXfnjYEVtqVrVXcbVFQYavQYJfmu6dTuA+
 YQyx86UCGci0inoKkfohehYYlK+77BttGYtZ3Ks7V4kfSxq0bYqYlcQa6Cyox5oo
 mSPSQgqgMGyc7/kersCIR3yQJwtArZEVmZOODyAO6/mOnOEG3Yi+w5TQZHL08552
 poN8ofoJTT8UkyH/bjVJJ+4X/Wh6w==
Received: from byapr05cu005.outbound.protection.outlook.com
 (mail-westusazon11020134.outbound.protection.outlook.com [52.101.85.134])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4g6aw696ha-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 21 Aug 2026 04:16:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KOayRgdlch58F1aV1u77VcESvUMh3PnwcsqnUQ5qYuUikJ9RO77GWl04avi5mluQtgHcx6pvSleUaq7xdZoichonXsokpXS295qeTrC3jdoOZHpU1Z9+BsQTduIWXRuJgLjnN3jSwhk+ZyHD4o9/qkIJFvydAINrZ6hi5ljykav4wY348lqShAkeoPVoH4Z3hQMzU20ZoU0X8f7BnR8+tXScfrYpUpNwtqUtqSUa0+2MFOE06PWALPgHyv86fvEqVOkb92NDDsBALKwhvyE884eDW1GTkxJlB/LuDm7F+dz4tbkN9xtbcWjck/9hrak6WbVDiRABDHting6opQutYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xNmtFRoQQFNvOoKR63Ahz4aTn5W38c50rvX1NNi++Fk=;
 b=KuE7EABLU4dP+oA3CjxXOdIvuJByyHmNwwDZWIqAnZByW1bF9LFgx5ybzxZc6I6K/3IpUtxcgt5kdNQBZqAfkw50GyyxQNicyhDXlObWy1upgv0+YNXRq1qchVfiXxNh5UzBKXAUr2cqWh5eqh/5LoYPpLxFoYXUZ+COPQhsjdhv/00I27hdiLE0fRHvCJopdgnSiegLLjZzUTWnQq2gTMhK9848a/6s9G6poKR/ufJeI67pNJdIzTUAV09A/DibUXEw4KLkA2bmvvk0yc6mPQ/QacMADuYN4eVMXJaDOBHOSqTR/wjqgGYUjt+wYomiaCQcl2HkD8zW/oAUHcjFfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xNmtFRoQQFNvOoKR63Ahz4aTn5W38c50rvX1NNi++Fk=;
 b=mmLsYXF+ww1+vk4BkboSC/4b+rZm11bxQjITuJervFiqSp2Wotln3xQCVtuih4DxMkooI0lD3ZVZbqyR8O9WUasUXZvLeRNbiQHAAglanCNZW4jdY/LlRlec151jmvrhtMVR3gKfqgwuET1LIRNhgCddpKfdd+XCzTDNHjf/JbBOCuk/XfVUuY2gRl8ZXXXPT1ojQ1317gcdGd+BC1bCSxHlMshlEMUozQLf6XBAJXUZP/Bnt/a1DsemQLjFahJCLg5qlNmwBWovmkmj7Li1NwcuA1fpTue+t6KqDdzKi56WI5zkGKYW3mt/KEarcrjkrVHeRdOZvxcnc8df/2sInQ==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by CY8PR02MB9524.namprd02.prod.outlook.com (2603:10b6:930:6c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 11:16:11 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0339.010; Fri, 21 Aug 2026
 11:16:10 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com, philmd@mailo.com,
 aurelien@aurel32.net, peter.maydell@linaro.org,
 richard.henderson@linaro.org, berrange@redhat.com,
 marcandre.lureau@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org
Subject: [PATCH v4 05/16] qom/object.c: add
 object_class_property_add_uint64_ptr()
Date: Fri, 21 Aug 2026 12:14:17 +0100
Message-ID: <20260821111550.276011-6-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260821111550.276011-1-mark.caveayland@nutanix.com>
References: <20260821111550.276011-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN7PR04CA0164.namprd04.prod.outlook.com
 (2603:10b6:806:125::19) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|CY8PR02MB9524:EE_
X-MS-Office365-Filtering-Correlation-Id: dccf07f5-2d2d-4477-066b-08deff759ae2
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|23010399003|56012099006|18002099003|10067099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info: dzwqT50x1RGBMXiCNoZTJI8ObdrFLhPt+3AqpeOciXYEcN8XwZyqvFvIzsH3eCX0AhDIyJ4RZ1ka9tHi6eKfuKke7h9tL2akm/QtCBnWkojAiGs7aZTbi7wdygKl9lGw5HPhbKapUSR3hyNXWJi4Uts1d/E08wezBsDkw/n8D5EB3nhCxCVQPgkc7p4ER+nkKT3ylQ9qACH2c3dJarsVw3efxbMNni2ozJCDnQBo8Lmdy74ctKyKnIBnv79vX4mGhwTpU9zCdAPHO7K0q+V/zxOrdvZuKGXTM90+Ag6ujlpv04FZnFLWvWBYb/Zz6OkpGwHUfpvroQocqiV/vEr4i+BajmhPRfemTmTCm2xL/BUxEmZQfN7wO57PM8bjynWjN7wPQiYs26KAYMmNJHezQ6JjeYfqlrIn/SNHAiHeuMINuY5tUXaHV4BVp6ig8xJCotktVP+g3kJRICAnpAuEVM4IE7rYE6mkDibqw5rsP5nomxZCpuY/1Oukq/h6j+fPL1UBOt3Q8eccLzrh2Liki+ZndPR7g6XCOHVad2u6oYo+f2AHrjDz/ZQ6ztHDTm346FPDDElM1GTSUbmr9iSeFHeNSpLURfs6eOcR/NhoH1EVL42JZ38B14NOndNUiiEgzooiS5mzY2kHrervHiAAtfQS9QeAYzwRRoNvhjBUNmE4x/YNJwP7kaVDLJT1qo4jhRVq636EFaw9UKdyrkGaRA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(23010399003)(56012099006)(18002099003)(10067099003)(22082099003)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HppImn58bOIlfOmFNOWsoFz35tfEwvxROdYw0UDgYsEtq/wjDlRjo8SqQdKu?=
 =?us-ascii?Q?f0AzKpMVbeaCTy8H7025FI4otEV8PUD58J03FbAtJO6nLjajQTEmxtRIP3x6?=
 =?us-ascii?Q?nfuEzlRpa3+LUURNbJK4fe/T2y52fPRJFkKHAWibzg7lyCbGpqzdvYVTDJXw?=
 =?us-ascii?Q?m0OG2RgBQ187CAhOl5ISbXllCdq0mpshay5WsVEcGrfKjFLkR/pxuVLpalFA?=
 =?us-ascii?Q?Kgs2VvJlndIqYQt3dZdt8sfOx6hUDXkEjTmOhFHUN+1JuXm9uzHWgevj0b36?=
 =?us-ascii?Q?l4TwXIaTYMjJva4vlQwbhKQyxMtIaPgTaJAuveFGpfzsr/3cm07D5Xtb01Mj?=
 =?us-ascii?Q?ATnFhDWC9b3hFOe/rfpy3dAS6GiEb6zo29cLpktTN/ZFCMjNMsCKfuXkfom9?=
 =?us-ascii?Q?skHdJY2hcvG3wzx6D+wyCF3oSBkHU694Lay3e6jAp7HuCwcqtECTXCApCKnk?=
 =?us-ascii?Q?eaVSWIEYJ7DmWPd4F1AAzw2tedRdi/iWW4Tl9Ykkyny4wtDTe8M4sVX5Fs6Y?=
 =?us-ascii?Q?MsQRxEE/xcTVtMPMIQUx68Boqu8E4+1ko3iGEhZAU7aK94KjkLcIxUyU9i5K?=
 =?us-ascii?Q?JxUm+YGH21zuOKTwyD1ESsfFMG91AWR0MVp0ACdH2WZPHw9/xDkq+eRZ11hL?=
 =?us-ascii?Q?IV75WL/ge0lv8rXZn7bzJqVjjliX6UtQfxEkmUe8bBLbnVugCmRKIxB5kJiP?=
 =?us-ascii?Q?LCLwL3QobD9WyElCnArc1wXJ27s2AuVmYoUFrIBYMudomsPfVVDICKrGUt1I?=
 =?us-ascii?Q?/9b/BUFJgfXDav22p/hx4APB45CsxuiIBUTCnkqEbUhPkM91LE7qO4Iqv1Iu?=
 =?us-ascii?Q?Xzr8BMlI2cd6/dKz1IMziMqENntI21/425EJOm+cbtVBHRQdznnPCoUdHZEz?=
 =?us-ascii?Q?nOGcL8S5feCYCOjX43hlPYnfc/fJ5xlGf5SOE8PiCrVFVVIoQ8slTvbiRx+C?=
 =?us-ascii?Q?6IIJWMCb3oERw03cqvqCrovSvM7dkGwi4s1CMIckwELvB93lhMbgMG3dO2pa?=
 =?us-ascii?Q?D6kXV3eywzjMj27Oz/ZIPk7XTTPjeqHZmzq1PbEkiNmTf+acxOEgQEjh0v+H?=
 =?us-ascii?Q?+6UfniGgXYl5y93oekEraHaWANC1sKcj2O2BP+fYfhLPd9K2ErtGpsAu8qsF?=
 =?us-ascii?Q?wBpqhremuqoMEaX3CLS6/lyH1VASnp0ljssHQ+LL0HOVdaXSKPWOvIUn6d6a?=
 =?us-ascii?Q?GtIudVPjhYnChRlXyW/+wd1Zb484gwl2qDTLDlElxiQUIiRB2ZwLI1VgIvzI?=
 =?us-ascii?Q?CIynPAxBX/lS7zpbUCXZrQ7M9+jKbXPy/dEHGo+IZChNW8dcmmqBaUUE4zNM?=
 =?us-ascii?Q?dIihLY5345fIcgyiYhp82hVkwcWsoBI474Pf4fbJ0Q1v0q49jH4tr9fOQxa9?=
 =?us-ascii?Q?1SqN3ztLjJZ4ppE4xTe4XhqM/NPtVHMRGcXPRU9jjM52hkQKpGQw060ePz/B?=
 =?us-ascii?Q?Vdzuv6nxTXpEQzqQoxJlXdX8AewChkvgyd1U+soiiLoQFAACWq+aLdW1f4JB?=
 =?us-ascii?Q?FtmU83/hOJjse4jBVVSExCUCEQ90kyVJH7Lg8mWBW0iVjcCiS4VpsP3WhoxX?=
 =?us-ascii?Q?UDiy0r9HzfeBVQJ8ydl/7FnsxorTlzJYsRuu3JUgUw9DZeWRh9MLqPNQDt+7?=
 =?us-ascii?Q?WdlqHPvNHsI97HkECOhwiRwWTq2Enq9LtdCgWYrcD6nRb7g5/ePZntgGyf5b?=
 =?us-ascii?Q?hYP1I7EvMH9slRf+qbcb7/+4XB2sTUh38W3YfpdOwF9qmy/d86VjjJ2/uRlQ?=
 =?us-ascii?Q?37ZCfcyghEycFCm2couOk8kBQ3TW81Y=3D?=
X-Exchange-RoutingPolicyChecked: mY6xtjLTZufQvZCl88wzHomIpglgoYAeOOS0dOU3ln110gow8QB/hS/GUt8R1X2E6N3To+C3CRBVKiImhcMb4UhhK8uQsilkq5ZXLBzHqyGyfk7xrXb1lHGtjGbTuK1pNIqqHDmpcZ+3ya8U0uqaDfxXnbllaMctRY3kNUoY/5Luy/TgNfRmP+/V/Pz05tOemGTKXrL6yX3yxgGp5v9Tsy83NLd0+UwEtw7/y2FcB0GgAh4ck+Y3wque06N47C8ybaN+JN4NUPOzwbfcrERHyNMHKyk0nzl0ev9udPRmB1nh0wv9c+/YRQoH43iPPS4v+Lu/PiSA7NwHntS+lPLtCA==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dccf07f5-2d2d-4477-066b-08deff759ae2
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 11:16:10.9637 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: THaUXTiYCCh8MWw99cVgJUapCQxOOnAYvDT4XWKY90ruEoVvd0DJ7UeQhfCqafHc/xY2UhjYnhzAJOqNa8gYNNUQ7gK3bd6OJOqUuXgxIuo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR02MB9524
X-Authority-Analysis: v=2.4 cv=PdDPQChd c=1 sm=1 tr=0 ts=6a88337c cx=c_pps
 a=yr4orNQqY5sPVMLupZgypQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=Sv0fKeRqtYgA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=y4UcunY2MAxhM4LwGdWI:22
 a=64Cc0HZtAAAA:8 a=4QfE8SPBBHYfMhEiUa4A:9
X-Proofpoint-GUID: OPsGLZS_5hDeFm5AYD_uDWxLIXAcGBdp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDA4NCBTYWx0ZWRfX1YDceWDC4c1D
 W2dCzMOpzagh0d/tXypu2Yu4sWCyDYPC53osYhHRnfHiTKKmnvmfp1xLMAjkrtIRA7mgCmnvLMD
 /rK4axI/SXKlwYE4pn0FiUO4QpiiA6RWD0clwagDa2lgPV60TCr0mFTX0g9ti8k0BIE0RXUPwGg
 XxY13LaQQXYm/9MlnwjroN4v87Rwt5/SM+ywE+Wsamxgi+OiAzirzOzHp+cLaLD3wM0DerbkLDQ
 3QWuP1Gzc7wteMObIkk9HTlm1Mw42JAG6y8kxDao2Z8Ew3wec1CA+ZVMMYuRk0nYY3Y6O7QKxGA
 gCWyR/Kz39/6cVUIpRy45akO7hmOXFl1y13ZDEuyfIc4sw5lGouOViXWcJ1JCwvf+85qahPmsjJ
 /QO73AE8ctwVMflS8dqGLFprLSay2SqQ9LzybakumgiZYk4b1Pz2icEe0ZIgcddtcdUguCbmUfz
 v+6XumLb+QqMsWe+vgQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDA4NCBTYWx0ZWRfX8HBScNibmubN
 gQt58PtpGv20c4uwB788v6NsgmgzChxhq9APZ7AX94NEL/09cgnKXZdHphmjdmVEEmAuoyM0Gji
 zKw8+S5q4DX/IaOosSrGDCFgW/oDIbs=
X-Proofpoint-ORIG-GUID: OPsGLZS_5hDeFm5AYD_uDWxLIXAcGBdp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_03,2026-08-21_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
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

This adds a class property that references a uint8_t within the object instance
and is intended to be a replacement for object_property_add_uint64_ptr().

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 include/qom/object.h | 18 ++++++++++++++++++
 qom/object.c         | 21 +++++++++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/include/qom/object.h b/include/qom/object.h
index eba675d218..67ccd2b08f 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -2168,6 +2168,24 @@ ObjectProperty *object_property_add_uint64_ptr(Object *obj, const char *name,
                                     const uint64_t *v,
                                     ObjectPropertyFlags flags);
 
+/**
+ * object_class_property_add_uint64_ptr:
+ * @klass: the object class to add a property to
+ * @name: the name of the property
+ * @offset: the offset from the object instance where the uint64 value is
+ *   stored
+ * @flags: bitwise-or'd ObjectPropertyFlags
+ *
+ * Add an integer property in memory.  This function will add a
+ * property of type 'uint64'.
+ *
+ * Returns: The newly added property on success, or %NULL on failure.
+ */
+ObjectProperty *object_class_property_add_uint64_ptr(ObjectClass *klass,
+                                         const char *name,
+                                         ptrdiff_t offset,
+                                         ObjectPropertyFlags flags);
+
 /**
  * object_class_static_property_add_uint64_ptr:
  * @klass: the object class to add a static property to
diff --git a/qom/object.c b/qom/object.c
index a480fdd400..271c2916b7 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -2742,6 +2742,7 @@ static void *object_class_prop_ptr(Object *obj, ptrdiff_t offset)
     OBJECT_CLASS_PROPERTY_SCALAR_SETTER(type)
 
 DEFINE_OBJECT_CLASS_PROPERTY_SCALAR_METHODS(uint8)
+DEFINE_OBJECT_CLASS_PROPERTY_SCALAR_METHODS(uint64)
 
 #undef OBJECT_CLASS_PROPERTY_SCALAR_GETTER
 #undef OBJECT_CLASS_PROPERTY_SCALAR_SETTER
@@ -2911,6 +2912,26 @@ object_property_add_uint64_ptr(Object *obj, const char *name,
                                getter, setter, NULL, (void *)v);
 }
 
+ObjectProperty *
+object_class_property_add_uint64_ptr(ObjectClass *klass, const char *name,
+                                     ptrdiff_t offset,
+                                     ObjectPropertyFlags flags)
+{
+    ObjectPropertyAccessor *getter = NULL;
+    ObjectPropertyAccessor *setter = NULL;
+
+    if ((flags & OBJ_PROP_FLAG_READ) == OBJ_PROP_FLAG_READ) {
+        getter = property_class_get_uint64_ptr;
+    }
+
+    if ((flags & OBJ_PROP_FLAG_WRITE) == OBJ_PROP_FLAG_WRITE) {
+        setter = property_class_set_uint64_ptr;
+    }
+
+    return object_class_property_add(klass, name, "uint64",
+                                     getter, setter, NULL, (void *)offset);
+}
+
 ObjectProperty *
 object_class_static_property_add_uint64_ptr(ObjectClass *klass,
                                             const char *name,
-- 
2.43.0


