Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60382CC6B1A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 11:01:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGwj0-0008EO-4j; Wed, 14 Oct 2026 07:00:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xGwiz-0008EG-0R
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 07:00:45 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xGwix-00025N-28
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 07:00:44 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69EAYIpM3386605; Wed, 14 Oct 2026 04:00:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=KBYwAnvbdjNZHrkxbLQynUxu0Z0J9UzLCBTZRqdFF
 5c=; b=ZCvj6MyY5YRo75xXDgkwaGWKjbXwUd3k50Y/6wkxdA9UHJynPvx8SIq3M
 AcfsTSVFAmSfDQB0fxuqb4joz9Wqq1lBh/m7eenU1UFIW152MrbeKw+gb0K1TvdK
 OVpbir4G4v8dWnrwnW4vPdFrHSIFVXbZGMpDPH1q3RSyjkRp2As6+qfxRXLlBPdN
 9mJGb+aaMpqps7EJf5xr5z8WlTLHFUgNN3OK0tvpam1MWbmYbOGEOhMeVbpGaTJZ
 oyhBhGlmy/UeDwUD9NIQ4DklO2ObW10kW0xxwK0JENGiWMb9IzJUXSKo2eOmns3I
 bm4II56aNcl3ym2+ILd+aryf+1+dA==
Received: from bl2pr02cu003.outbound.protection.outlook.com
 (mail-eastusazon11021136.outbound.protection.outlook.com [52.101.52.136])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4ha83mr1ux-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 14 Oct 2026 04:00:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g4bWWI57XD9154dtvNxnToPF3bQynN+iuZxOwZgHDmfkgwwEvxpHz+JvWlu6S6GSTCNi8bNmx0KYBc5BYZGf1Mb4+fbgm9vZTqLvpld8JmKfbygzUgfbXmGF9iui11JZTO7lAvZuScfql0faAXT6fc8MF19Lr3j25vbBl/JSaCWLiOITW94l7DjndBT8A6oiWjBGestw9frKBmAke2q6VBZwWZZ18Jy5g2UMOsn2WEZrAgDc0HNS9oqAW8qa9uFCyMeWVSlUlF2hAEZuK9PEHvlkxFukXKwi2bQMI6RWKPF9sHpcFWtx0E2aS8DFTLD/vCjI0UMpZjQn5eLDcNhwIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KBYwAnvbdjNZHrkxbLQynUxu0Z0J9UzLCBTZRqdFF5c=;
 b=HwHiKPNKC4AmWnJdBPpfSbXhO4spWR0gYzbhA/HeJ3VvuIjyAFanMJFUNsRgA6MklziFw4aC0oct5VWfgEoKId0o1FYlAWYB7otbLb0tiIDhZy0GpTF59lzBnOCCGM03wAPFLyQQTCkuBFuSiXX0WGrlmEITaQQGxqs95vWJJxba2Vi9Zj2J2e/QL5aTRafbP4XVAGE1ZnoqPYCxfzalCzm55xqjk7ai1Aq2zX1+LCb72GQM8V5uBhB4+mSlXMg5+GxH+IeV+3og9HWdikjUiCpKyhJqH+bGECs88PiaCW6aMSSHzZ9CxDUJR00NhAx1yI7lsZAmSWSzMsxITShdfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KBYwAnvbdjNZHrkxbLQynUxu0Z0J9UzLCBTZRqdFF5c=;
 b=BZPlhfzlms1Fj6R89nM/H4nFV0BY09r8rX7pksyfymY8PW2ZCAlvNUktpBzX4dbElLpsuGe2welHFZcK91YvnRNqxS5VEY48t0UtSwywEG5QixohA2Bgm5Rx8mw5Xj+dXgDGIDvWUlop7ZpD3Psp9vIwyxEM0Cp56HK8vy1qmHClf63BNlHw3dVshmyAL3dgf3zrtcniC5cSFsg5P3koiiBBllgxNbTQgGkAQtpcz4rtnqeXgAvIK75+7acaCXtHcQHRVL1Xl3FYLSMMsQsTF2I+VLat+pSYBY3X2szuY+x5rh/5l1eDxKMk1uCi4TOLCht8C+UFpaB20Ah5owcHEg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nutanix.com;
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by SA0PR02MB7209.namprd02.prod.outlook.com (2603:10b6:806:da::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Wed, 14 Oct
 2026 11:00:27 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%4]) with mapi id 15.21.0522.012; Wed, 14 Oct 2026
 11:00:27 +0000
Message-ID: <876b66cd-0ea6-4943-9a0e-c0abf2ad6e26@nutanix.com>
Date: Wed, 14 Oct 2026 12:00:20 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/22] i8259.c: move parent_realize from PICClass to
 I8259CommonClass
To: Peter Maydell <peter.maydell@linaro.org>
Cc: pbonzini@redhat.com, richard.henderson@linaro.org, mst@redhat.com,
 sstabellini@kernel.org, anthony@xenproject.org,
 edgar.iglesias@gmail.com, qemu-devel@nongnu.org,
 xen-devel@lists.xenproject.org
References: <20260916104435.600211-1-mark.caveayland@nutanix.com>
 <20260916104435.600211-6-mark.caveayland@nutanix.com>
 <CAFEAcA9eucRyzG=PR2tpx8ObHkdK6xUmOjQ+-nNbJ2dVHaptOA@mail.gmail.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <CAFEAcA9eucRyzG=PR2tpx8ObHkdK6xUmOjQ+-nNbJ2dVHaptOA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR03CA0009.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::19) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|SA0PR02MB7209:EE_
X-MS-Office365-Filtering-Correlation-Id: 46173ebc-b5be-4608-0704-08df29e25a46
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|56012099006|4143699003|261009223027099003|22082099003|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info: ZGJBoQWpFqccJUT4Ppb8RB4+eirfTMzvJG7otdwjLLdHeNJ89Euwywez+eVLKBCtZAi7YPJ1ntI7o3psMbRBX4RoAyqR2Fu4X49W/bSzUKNU8/waLta+q1HJjUXTmsRNOi2P4CDrig1hua0r/XhWT3MaagtppmRs8JkvFTG+9jitHoqfU6dMAwjP3UMqk4WAbLFCyc+MiXciVqFXbopSsdTSRvpl872JUv81NUunl0CqmY61KCaFk9koy/uEYlseADyE7UKu6PXlKEd2WK61SDQcMrYRCr3E1y4M6j3aHjN78UUTNL2X9iOdKL1zc+PUyBpS/iI8wGR+TG2eeid7BkYvsDDzfNBAaPvJLrSrn9LXaqxr3K+wHlBKv00r3zYExPt7tbtzhuBU7pmZx4mdOH27W8FRbM17KasfesGGwmB6MC7DKPLg13+11Fks/ZaIpCY4M2QQ7eJEQzcaZYBMf7KlWGYjHMtyUIHT0Dc9MyHqeoPLefNsPLgJFlZTdn1gjjgHqKXhxKv/iHgLPSIkiwFmupA+Y0HxaPHZntNB2BTFv9uqVXTa5s9QN+EXdcJB69uRXZrbTotQibkmvEoFXrUGeKHMdx4NdJkvqFcnwg3I21FEiH/wtk+QLHn8b8nRGPrfpJRPp5WZT17Tvg2QYk/bbBdQhgAUyLnq/dXChJ8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(56012099006)(4143699003)(261009223027099003)(22082099003)(18002099003)(10067099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZmRZUUNuSGJHL0FnVnVBWmduYTNtQjRlZjV3RjNPMEt1WFVSWm9pNUxPT3NG?=
 =?utf-8?B?L0s4TjhUMFg0djBxOU14NDY2UlNEcWQ3b3VJSHlFRlBpY2lwTkdGK3Y0NFpU?=
 =?utf-8?B?SmdzNnF2cy8zUWFYUGVRYXJ6Y0l4VmMrTCtoSW5TUzFsczdvU29sSEhMWGpF?=
 =?utf-8?B?TDFZRFE3WGxFY0IrNkZIMzAyZjBpclI4cENFUWVBRTYwL0dhbTlwVDdEaXpJ?=
 =?utf-8?B?VHIwb2FhWERnWDN5UGgyWmVUbUlCRm1rejhZRnpCWEdGYy85VVM0TTJkYU9n?=
 =?utf-8?B?ckFkVksyN2tuK3Vhd2l2ZWJNYWNwUStRczV4VVU5Z1g0cDVaOVF4UG8zNG41?=
 =?utf-8?B?Zkgya0xlRlkyTVUxTTJndFFWMnpnejM4Nm81NGx3OHRDSDVhVHAyaHNXTkM1?=
 =?utf-8?B?dC83N2xGaDRHNTR1NloyT1JnR24wcElXOHdNK2tIMUQ3SnNhT2c1WkpxMjhm?=
 =?utf-8?B?c2k1WXlSNEV0OFBJSzV4U3VtbWI1SHVEQnJaRi9EM3ZRTHZMa3NNQzBWb3FH?=
 =?utf-8?B?RlB3WXNXeGpuYmg4bWRxN21EbnE2cXZHQnNqclhSeGVVclhFYnZ2NFJ3dGFu?=
 =?utf-8?B?WlNWUkdvWlNyeXYvUjRUNlE2ZjFNMSs0VlkrRjFqdGdiQ1FTM1d3dkgrYUs1?=
 =?utf-8?B?aG5FcmpGUUxQa2VUQ1IzNHpteGN5WmdXcHFXa2pCZ1dVMDFHSHVMbXg5VDc1?=
 =?utf-8?B?ZmZpK2VpTWVJQ2QvYzh5V0Nwd29rTFljZ3hjUDJTMmY5YXBOV0o3TjRuWmQy?=
 =?utf-8?B?UndNNjg5bXdxYzk5bUExR0RPMUFQRUZxZW5NL2g4Vm84cVBsZVVCK2x5QVZO?=
 =?utf-8?B?Y0dNbWszZEczUzBtM2FBUkI2OEJySHBOMElaa2FJR014K281c25oRVZrUUxy?=
 =?utf-8?B?bWVzOWdFU0xQV0U4NnFFYzUycWVSeDJMYWMrb2xoNjNTUTJacUVFQ2syVEQ2?=
 =?utf-8?B?TkRNZ2R3TEpTYTZYdEhtYkdleVM0VzExSCtOcXB4U3JKdTNmVVdUQ1ZvY3la?=
 =?utf-8?B?VlU3dGRiSG5DakVPQ3NseklZR3JwbjkrbTlJRFl4UTh2eHR6RnZ3cTFjU3hZ?=
 =?utf-8?B?YjlpRmxNUWUxNm0ybnZnN1hzTUsxcXRsTUl2YU4rTjJEK3lLTGdESXhGRGZr?=
 =?utf-8?B?NW52SkM2bnl5eHIvaGJTUE1rdEgyNEpMaC9ZT3RheVZDR3hQSVZUNXBjTC9a?=
 =?utf-8?B?eTB4VFlYTjUxMHZwM1NZUFRWMnV0OXRiei8rU2hoZFlJUDJEaEEzaVhPa1hz?=
 =?utf-8?B?b0E2QzloSnhsVjVpcDNBRFZDcm9rMmhrRUJXMm9hcDBTeWZDKzR0R1M4NEVx?=
 =?utf-8?B?MElmL3ZpMENIZFRLYXQ4NDRhSDh5Ymlickp5dHBxRHp4TXN2MFV5VkluWU5O?=
 =?utf-8?B?Y2J3TWlQMXZFTDd1RTVqV0lsT25lTGVoc1lWNkVpMlBPRTRJNlJMWXlZYlRX?=
 =?utf-8?B?TTB5bG9kK2xCZmIzaDQvWWFpdVl6VllKU3lJZVpHNGx1S3BhVURSMTdSNjFT?=
 =?utf-8?B?dFJHN3Fyb0VrOEhoS1VodlNtVXJtRXA0SjAwek1Uanh2UldWcUJDRE9rTzAv?=
 =?utf-8?B?ZURHbUNWUmVwMkFkenZRMnV2cXNxb1BaeXZONDR6SEgrMXpwVmMyN1luczlP?=
 =?utf-8?B?N3B2a2c0MkVnQ0Nqblo4MzFpLzkrNysvUHJDdWk2ODVEVDNwQmxOUkFYa3dH?=
 =?utf-8?B?SzFNWEF6VG1aOHBwUUZLbG85M0ZaazhHSEhPczJ4MUgrT0hCTkRDVEJWcHZB?=
 =?utf-8?B?TU9vNXJFcTJ3SnJaYTRsNDRoNXp6ZjdyckIrN09XY0k2RDdUQTFFSUc5eDBh?=
 =?utf-8?B?Z2JFbnJlNkRHYnp5R1lKRE9wQmsxajhSVkxpWXpqUFpscW4ybm85Ly81eUth?=
 =?utf-8?B?b3VqR3E1VGtucnU5SmFGNU9vZW96bCtZRlRQSHRHbnltWGVnSzYzRWhhdnp5?=
 =?utf-8?B?WEpiWWp6UlEvTXg3bllJeHA0VUpnWG4vZk1DWjZYUjRmdU1BRnlBdnVQdlFH?=
 =?utf-8?B?dWtRTit2eXl6VnZhQ1JxUHJPOHdpRDc2aVBjOFNFZkVlMy9KY2ZtVXBuaUU0?=
 =?utf-8?B?T0J1YTZiSDlKdjZzbk9BRjVwUFdQS2tQK2wxOEdCYVEvd2N5MHg2QjF5NTBH?=
 =?utf-8?B?S05iUFljdE1vaVZoaEw0WDFpUlIzdUlEWjRsSDVVUzBpNTU1T1ZnVDJOT3NS?=
 =?utf-8?B?S0hjaUJSbnMwMjJmQld1MTZBU2NnVGlCMldEMlZUK3BCcEdjK1hEMjhKSGlH?=
 =?utf-8?B?MjFVc0dXZ1J4bVd1NVd0djluUDlLZFlnMGxQSDFSOUQ5WkpNL2llWHpMb2ky?=
 =?utf-8?B?end4V0plMVQzOTNFbjArQnBIZXFlWHREa3V1S0hVSzNadll1T3NHTlcvdXhi?=
 =?utf-8?Q?uZX3lOiB9B733pvg=3D?=
X-Exchange-RoutingPolicyChecked: RbPrNdZzokPsxfoE4xoClneC+ueTp4BOLoiQpQk24Q+FCfthhcfww2I17x8hoaASBdMhV6tsG0YliCpXy9mk2z03uAP8EOmP2OTQcCqU+JPER60WoK1zOWGh1QQhZ2tJ/xyYVicArcwIcJUDtsFe2Z7V/y9+pD/2hmKqGIiEZjqXY2EOgrCIJWcWSL+IfMEtAACzjUtYB/v+B0r55dq2tIZ0yIs9BzA1hMA78Js1i/Yr6B/8SHp9lUaahwVg8MtnykukW4SCHwZiDS852Cac52qGqxm3rzNlseJJnwDhCHFZibJ+RSX+ONbtcdDD7YiZbuwl9a1mAWG/n83vHgNS1A==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46173ebc-b5be-4608-0704-08df29e25a46
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 11:00:27.0385 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0xEKrK3SZEXoCaFyx0G3qYt9Z2nU+BDhSJYYcAJaMWV8diXf92DAznul3fhICzi8Q4/JOBRKl8Rs70dwIpr5UBVRIARB+4GGQjmP18JinjI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR02MB7209
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA0MyBTYWx0ZWRfXyK9tZ3oJPo5Y
 Kk1Ri7VXXRv5fd+kC5sCU+MVxuNRuGVULnKRfw0vk1t5c/d37YxaY3yW9plQI0QR7b8C8skP4oL
 wFscrb7qtdgMYmguuN+koRtRUMMQwJI=
X-Authority-Analysis: v=2.4 cv=BroIUoX5 c=1 sm=1 tr=0 ts=6acf60cd cx=c_pps
 a=IN/ktsHfyviFoRwGlsjPrQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=VUi8bpU7OL1Oj2-RSIOF:22
 a=64Cc0HZtAAAA:8 a=AWkEWHTIOsQDqs_bE0YA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA0MyBTYWx0ZWRfX4mB5yBKYqrBj
 zkpcQpITlq6z1EZyycJbv//wstKprYEHXnabH9D5REj3lylTw+okT4tbRuE3aI8F7zFuTP22y0E
 Mo3g2jF/wUlMhOo8JvNgsawZaZTCWN5Tn56G6UW1LgRwciYZaXMbmzizyWatGd0qGBIE7XYqtmV
 oAJulbqnIKI5rR07z/v7Res7hoFhe2aeUgFEHkqwry4fKuVNmWwbK5J0MHoQ20shnu6qmWNklrL
 4vTQ7jKmtzvpZew8E4puz8HPbXIqI6l9gb3i4s04CCp04yJLTm6mHEe9JPgkGDjZDk8q9Y06l1Z
 qRy0z+AIOk0YIYZzJt5yZsg6POJewph5+eWmYbDjbBFt8N32Vr5LcNi3AQNdM/l0nt+7nw2Qaei
 +jZXxrTRsbvoDizgr1HzMKVOOf8Ls6KiU4vWN6IrUoijFaeKc3gJH97bsZSQzY51VE3CmOwh5jW
 5O+vb6OGj36qBQTHLRA==
X-Proofpoint-ORIG-GUID: L4g0Y_Yz4cX-YoZfZ-mr8Wb7Mn1wRLGw
X-Proofpoint-GUID: L4g0Y_Yz4cX-YoZfZ-mr8Wb7Mn1wRLGw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
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

On 13/10/2026 16:54, Peter Maydell wrote:

> On Wed, 16 Sept 2026 at 11:49, Mark Cave-Ayland
> <mark.caveayland@nutanix.com> wrote:
>>
>> Both the emulated and KVM i8259 implementations store a reference to the
>> parent_realize function in their respective classes. Start by moving
>> parent_realize from PICClass to I8259CommonClass and removing PICClass since
>> it is no longer required.
>>
>> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> 
> This is one of those things where I think we're not 100% consistent
> about whether we think the parent_realize field should go in the
> child class struct or the parent class struct. The name "parent_realize"
> implies it ought to be in the child struct, though, and I think we
> do that more often than we put it in the parent class. This also
> makes some kind of separation-of-concerns sense too: it's the child
> that knows (a) that it exists at all and that (b) it wants to have a
> realize method that will mean it needs to chain back to the parent.
> 
> The docs for device_class_set_parent_realize() claim the parent
> realize ptr is stored "usually in the instance structure" which
> I think is just completely wrong.
> 
> I could be persuaded otherwise. As usual with QOM/qdev, I'm
> mostly interested in (a) consistency and (b) documenting what the
> "right thing" is. Realize, reset and unrealize are the three
> methods where QOM's lack of convenient support for "child
> implementation of method will need to chain to parent impl"
> is most awkward.
Yeah it's a tricky one. This patch was really just refactoring what was 
already there, but I'm open to moving it into the instance if you think 
that is better. I agree with your point about the child instance being 
the one that knows it needs to chain back to the parent.

I'll have an experiment and if it looks good, I'll move it to the 
instance in v2.


ATB,

Mark.


