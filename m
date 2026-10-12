Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FDBBCA9ED1
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 10:56:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGDhc-0005FD-Vz; Mon, 12 Oct 2026 06:56:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xGDhX-0005Ez-Ou
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 06:56:15 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xGDhV-0000ka-1T
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 06:56:15 -0400
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69C8N3iK2871788; Mon, 12 Oct 2026 03:56:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=9PbDKC4vT+XiL45+78fY0qxlHYofxfvtdk1UEY6yg
 q0=; b=j37p6BzvMvyYEx1lSxQ/FVu/GvyimXW5RrTm+izUPanLwqG0z0pxYbcmZ
 4AyrMQcptV2hUeKuVroNYYnZjuLveAZYTPrroC9QE/rHyS0OldmS527T5pir5ux+
 43MdxhHkLrV+y/g2AM9yZvtpZtrZ97l0k9x/9R0KqhefTpTLCuzJzBa+SV5+0NPo
 zAYF03GxaGGefKY2Skr6R5/FsbT4HXOJTrdg4b6zor/lOrKNskvnK55w0UvUyJrf
 fWiRhxjbiQW4CvUadkgKzLgkv+w0Cm9m8lrRYyXffAhKKBY6XsS2Q1Gk6BAUi641
 OE9VVn9u1QKpdkgGq2GGux4TX0pDA==
Received: from byapr05cu005.outbound.protection.outlook.com
 (mail-westusazon11020106.outbound.protection.outlook.com [52.101.85.106])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4h7mwwk0sw-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 12 Oct 2026 03:56:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wME294+q2s0fVO41xiEIm9KujJ7HWu9zeLEXh7Dn3sVIQv3dpnT/2MAKoTdQEBODs1xENKX/52kbTLD572y9seItShHQ1sR14peFcDX1EauzXvxX6p9DSpgo0UztH/WKIW1xxpKUZEkjvvgDPg0Di+B4U+LiCCHtOnsgaNh+HxQ35qxGLdZYCVh0//e8qutmDiRu8d8reYjKpSux2FEWbBns6jux1XjxJuvUmV2QM0ca8OML/WmJU+8qCt+wDl7/fpykTIgVHVeWkbmmt8dM/OgAD9g5YxoYZTglw7KPrpI4UYOer25yMZ4GUn8aHxjS/Lvmex3oCDsXT5qzA++zeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9PbDKC4vT+XiL45+78fY0qxlHYofxfvtdk1UEY6ygq0=;
 b=B644WgCQ9rJtbwnoXNRw/4lMYAAS1T6qEEhWksjHqemm43sVGfXFgytPm0L8bUx4HIpxxm49vUGVKIdBBI/DkGPVHjRDtGekPAxUjpC6t1PhGWyv4jkvr9MDgr/h93r8nY2SkzA6Fkm4QAC6ZF+iz3ky99RIaNKZWcrjCmTt5fFWXF42XgujAyc8YRHcGpL2Mi54OQ0GEw3bKgnuDtTvCTwBjj7NrIyCcx32YtuWTemyvyYS1kI96xNKAq/u5anRFev8IhK8/7ynyuByScJc0U0itM4LTjCB+deMIQ1x1MYjKquRHBw2O0ZcXgZv7uqdXBOUUSXkNBw2vcYFtqAGhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9PbDKC4vT+XiL45+78fY0qxlHYofxfvtdk1UEY6ygq0=;
 b=IrJgxNRM+U8+47L58RKyAj2Y9iSrOqdZ8RgB77oDqKeJs55ot0waUz8punpJDPynzxP26amcFCYOPcmALipmjREBFh911p7ZbHDi5gkb37QmTkVRg+Wtfa4KD4PkRCQuur696FwK07/24HTG+/xbo8sop3yHDAiHVHzdXu2b+BRsRuLxZ1a0KODHdqmKh5SBl4OGsPZCXzukiqnqiI/6ASspBGbhnUeLt1PG0pPcQ6skBiJbDZ89KlJDnhq0Vjubx+ZcNCgQSEgXXqliL1V6+dMFhKtHaOUOkmWiyuOJqmxkeE7/hfNX92WaFLe84xpCS5sZoC4XXxAOnYEhWXzBcw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nutanix.com;
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by SA2PR02MB7529.namprd02.prod.outlook.com (2603:10b6:806:135::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.21; Mon, 12 Oct
 2026 10:56:04 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%4]) with mapi id 15.21.0496.020; Mon, 12 Oct 2026
 10:56:04 +0000
Message-ID: <2f3b174c-243d-4988-a3b5-ef4cc20a2494@nutanix.com>
Date: Mon, 12 Oct 2026 11:56:00 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/intc/ioapic: deprecate version property
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: mst@redhat.com, pbonzini@redhat.com, zhao1.liu@intel.com,
 khushit.shah@nutanix.com, qemu-devel@nongnu.org
References: <20260821145104.364283-1-mark.caveayland@nutanix.com>
 <64588f90-a94e-4ae6-b326-58536c714b8a@nutanix.com>
Content-Language: en-US
In-Reply-To: <64588f90-a94e-4ae6-b326-58536c714b8a@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY5PR04CA0007.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::17) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|SA2PR02MB7529:EE_
X-MS-Office365-Filtering-Correlation-Id: d171331b-c4de-4e06-dff0-08df284f68f9
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|4143699003|56012099006|18002099003|22082099003|261009223027099003|4133799003|10067099003;
X-Microsoft-Antispam-Message-Info: JCQT5vtuW+xKqs4jYG0F77INJytVWn5W4/zDY20NzFSABeULeAnIqkgy2RvU4bZurI5plgTrAGlOkxe5BUpoJZrwEIOhK9Sj6LTH72y0+r4wcS8TN4aBWDGRoxizYBPsQnbvg51f6ioAEmBO/IpRZ0avKB+KggiGZgeT2iVT9PVisVF0jNbUszpqe6kbBKbZ7KI+dF5fGVddrNIYJYxM+NeAOUQ1Dssk5kkP2NFhsJo2Ecs4ExCtrLX0XTxbY8RizH3OvDkPTQaBDo4/COU4rJqJCmfPQkPAtw/CXQ94StW6fDDoCMc0lgyWaaQc2YsC26gXnG7si+HTb0LOPKIDvGikx01Fppx5iY4lQiuA4s4d0SpcbWRovkIw3CYJs4+rg+MVTD+z811V6UsEK3ZB39Wzwbink2hbTD5zpe3Bew9G8Oky+2w6lrT6xm0DeBA9swB+ZTtphMUAmEyjxVLQq6R8zhW8D9CUlOsphdYcuFbtFaOIy2RXDGo/ryZEsAlmEs2enNcqDkrfeokOzrl5v1oAWVThoLUeFRESLWP9AcSO85jpC0Nv79EE7n58m8HlcD5v7/R/AgHj2InJnzWXdJBp+e8QMD8sfR/6CbXjk2hmR1Vx0M6Gnh6iiATJYlXF
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(4143699003)(56012099006)(18002099003)(22082099003)(261009223027099003)(4133799003)(10067099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TmFGcUhqQUhjbDJCZnhXN2NWSnFlMm5qNUNnRVVzV3JxWThWRlF3c09OS0RH?=
 =?utf-8?B?b1l3VCtXbmpUTVBOTDRKcU9nTHpHZUhmT1ZET0E5YkxjcmphOUlPL3hXdS9i?=
 =?utf-8?B?aC9qaVJ2N0dkeE9aU2dzNnNNRXkyRVB6Y1FqQ1hGdThrck9YN0NMWUk4bUFJ?=
 =?utf-8?B?QTdQVW02Q09rWG94eHQvbXNtUGUvVXF2RGkvSHFkNThiazdNTUFldlhqejI2?=
 =?utf-8?B?NWRoOEFhV1VIS2x1Qm1iRjFmenVOYkZXOWlxa0kyTkNHRm8vSnowN0d4Q0Nn?=
 =?utf-8?B?Z1ZTSEY1dTJzWGIvRU9FSHNORUs3b2dEUHEyaUprWVUzYi8yc0wya213cnRL?=
 =?utf-8?B?aytKZkt1YU9hV2kyL25sT3FGTzRmaUM2LzZ1bXYzWlowTlg5cEQ3VmFpWlJ3?=
 =?utf-8?B?T2JoUHBBSFBiNTlqZ2F3dzQ5VUZ0bXBTN1N6M1BSWGhGM1IxOWhqRjZJdUNE?=
 =?utf-8?B?MnI2VURWZXBJS1VkblptUitQT2lGV3ZCMWRDb0FrU0lZQXJJcFEvUmxiMHZt?=
 =?utf-8?B?a3BsSkZ6Vyt4RjYzdEtjaXNXMlNVN1FmVVM0M0pTRW5RcGJYRkFGWmhsWHgz?=
 =?utf-8?B?NWF5YTRmZStzU0pwT1p4QlN5enVoRE9BOTZYSTNSMHNLVmpEUTZvbG1zMUs4?=
 =?utf-8?B?MnNwWkhSakNIK2JtQzVFWUVVMEUzVVlIRjhmK01xK1NBQnoyKzFCM2VtQ2tn?=
 =?utf-8?B?cEZKTnJrMXRrakNxZnRYRi8zQWRiUjNxcjFxVXAwNTRIQklZZGI3d3hmZXJ4?=
 =?utf-8?B?ZlZmam5vQjZEV2xVSHRycEV3SFZQZ1N6c0YwREgyM1JlelBGMURKMW0zK1BV?=
 =?utf-8?B?bGE2cHE1Y1BGWnBPYnBmR2E0UUpwdy9XVExYZnZmZmVwYzZwZjlHQVFjdkxY?=
 =?utf-8?B?LzVwZ0ZiZWJqMGN5TjdCbGViN3cvOVNyTmdYMGRsamRaR3BQSkFSZDhpZ09D?=
 =?utf-8?B?b0JTVjhSbUhxSDg3VzRTaGtNTzUwdVRqR1dMWnVkNms1UGdjdTM0RzlaQVZ2?=
 =?utf-8?B?bDN4dkI5QU56Q04vVjMvZ1NoQjIzd1QyWXNQSGxlWHA0VDgzNEQya2FtRmFH?=
 =?utf-8?B?NS95UVRDN0JaWnBrQVphTDREdEM0TVlOeVcwYkVnRFRYaFM4NGpWU2s2am5m?=
 =?utf-8?B?b3ljTmZSQ015Y1JqOFpQMGJlVVRnSXRpbFpDTTE5enRsSmdUUmlYSVhDVlB2?=
 =?utf-8?B?ZUpvZk1TR1d1dGZuNkR0NWVTUVR1bk44aTNnTDB0VzNtSGVnTW4zZUNtb1V2?=
 =?utf-8?B?UUEyN3Jsb3ZkcEw4OXp2V0Q2QU1DUytNT1NSdjZsdmlqQmdBQVdaSzFWbXU0?=
 =?utf-8?B?UXJXNG1TdjFVeWxUdDV0QVh4c2ZEQWRkQWpQYnhXc3FwZlRSdnhaRG9BYlhp?=
 =?utf-8?B?UC95bnozN3ZFMldZSGVOWVFxSlRFT2d3dlM4NVNrT1FzMVhCSXhQUGZKUUdu?=
 =?utf-8?B?T3lTLyt5ZHkzQ3RLaEg2OGtwZDN2Ty9QYzYweCsxSWpUV044Qks4U0x0aTd0?=
 =?utf-8?B?OHdua0NsSjJlck9IVkFoR05OVkFGekM3OHBPTDQzSlVIeUVOY3U5M0QrWUVh?=
 =?utf-8?B?RjNpNDRuaStRWU0vNXJuK1h2U3dFRzFKTitmZjQwM09wZ3p2R21GV2k1SStL?=
 =?utf-8?B?WEJqK2FqcEpTeXo1TzdMdWU4aThaYmo3ajhCUEY1emlWbzZVUjlVN0ZyRm1O?=
 =?utf-8?B?TzBWNEduMUlic0s1cEc5OXY2T2IvSm9pTzQ2bmpHNTRvYVFsTk9HQjFSVHhY?=
 =?utf-8?B?MmlIQkg5UTJudFI3T3V1T09nUko1YjhRTEdDZEgrWUNRdGV2K0J6UkhrN1M3?=
 =?utf-8?B?REN6QXZJdE5WOUpGZ2JQOERvcWhjK3FNcnU4TnN6WFBNd0VIVzkwQnRhVzh0?=
 =?utf-8?B?TkdCY3BYVm9QQmNnSXNFRm1UaFI0eTZCWW8yRzNYS0phTEVUT3pMd0pmNGQz?=
 =?utf-8?B?bWttZkRZWlZzaEpYSHNpMHpmclY0YzRiSkdUT1U5TFRsSTFWaEJqQi9NbzMx?=
 =?utf-8?B?WldwZkRjOEhGYitlWXpSQzM0NlZ2aXdCTk5KZGpMcGZNZm5LMXF6Vjk4UUJF?=
 =?utf-8?B?TWhCdlpycUR6VkgxTkE0N1A3blF0RTk3MUt2cndHSjF3R29kUDlaTjl0R3VU?=
 =?utf-8?B?WWVGdTJrWjdvcERoNXhoNjc1eHg4Sk94SW01TFAwVEtOcnJwTGlaM21YTG5F?=
 =?utf-8?B?TDhaKzBTMWNSYkVTQmVzWEJWWXhQcUFZNW4reEZpdzQ0UnpEOGtqVEZZQ2xw?=
 =?utf-8?B?VXVJdUVJcmwzbGJYbmthbnBkc0V4eGhmNjlVRVJYdjBqZnQ5cnNOcXA3UFFk?=
 =?utf-8?B?U0F5UWdMUSt3TFoxYW9LZDBBYWIwN21ZU0ZQYVlQRENYNE5MeDNjOHhiWkZC?=
 =?utf-8?Q?Nprxn9EH96XDrC8I=3D?=
X-Exchange-RoutingPolicyChecked: u2Lq8HHPvAjzA18UKSCDC1ujed9H+oazFlWuyk+J6wzZwZRXh6BUlvzAbY8mtmp1dvWmpAZOPZgtknqlN6039Di+XxaCqUPhN69Dc6S7dsEPvL3Hqjvt6Z+YLmCHOJQNnUFBcPktdSUKswI+8MW4S0OzVs3RhBn5nWz8wLG0ClLytLb3v1JLjxpdzOccX0PK03M77Xen8ZbjbWbbdNMlQVP0E676UI+LGEOM9Jazlfiq4KWOKIGdYPOLNhg/GdRI8elKdoGMjuxF97YCAQecLHRf/lnadI4C6JM3/yof976GH4/IFEoZwTFKlnuSSuRhYGJ4SxkOgAzxvchQDHU5XA==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d171331b-c4de-4e06-dff0-08df284f68f9
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 10:56:04.1344 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lxxBT87VSel3ww79/p6xq+lQWIAtHGM34xHLZs5x+xksfb02aZVa+b09s/btf6wuKZvFzKOF3BBcILLMQ+FgS1rd9TzXBaS0zgTTevwJH2Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR02MB7529
X-Authority-Analysis: v=2.4 cv=Aol7T+9P c=1 sm=1 tr=0 ts=6accbcc6 cx=c_pps
 a=cFfp9J6W/iLkiH+l/RQb5w==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=1L6crL_YRTbalZ11mEUO:22
 a=RpNjiQI2AAAA:8 a=64Cc0HZtAAAA:8 a=XZfvVDbsn2TsmWtDp7oA:9 a=lqcHg5cX4UMA:10
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=z2U-W3hJrleVIN9YIjzO:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA0MyBTYWx0ZWRfX8i3aLrpR4HOw
 TpE8InqPknk3hqht9n6X0AUpn9gYBwixqhSLm966IpeH8eXGBoPW943MT9Ic83gVEkzReApz5Ui
 fJ3KH5jZiLrLlItpuG7exlE/JOPpBcQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA0MyBTYWx0ZWRfXyZNx20WcZwSr
 39f1RBPVaEDz64uJ3XhAAaWLHJ2s7LKBpSrKX1tMQbxrZt5XhVulu6P0ON/ry4uwXNkQM0/wybe
 A+eTK0/XOQUZZlzrZbPmGJTurDlK3yUi1NpjzUPb8as4h3vKljhFncNZlgv2WNpt9aSRPwup7Ir
 x+intN1NMo8dCLoQzS+H0MhTZcgPP5ZXGyzYQSPVSpjcItUfhieTnwUa59T0yttrGvuHh/4xr/t
 KWeMAMR+Sr6yJN5S1QtPXYLqhmsGDbT4P6v1qkMdG67TeaWyr2bKXPeQzoyxN5+2YSZHmgs6iMG
 wxY4iALis6AXqO9b6yahkSX2TmklbRRUzi/9ZHF6HdNgF+yCpo5qj6bKfKVrT7yCafuIvKowtxE
 P6x6neI0KbnjfNz+sPvLSJ+K1KlMXzf3FNMxVseoRdjuvYV+UCanQPRmorakI08UOlGrgXkbr7a
 JWpfk+rP01CsCGBT+Bw==
X-Proofpoint-GUID: Ers0r0b9gi50EqGM4vBHgT4N6TU2n0bK
X-Proofpoint-ORIG-GUID: Ers0r0b9gi50EqGM4vBHgT4N6TU2n0bK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_03,2026-10-09_01,2025-10-01_01
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

On 16/09/2026 14:45, Mark Cave-Ayland wrote:

> On 21/08/2026 15:49, Mark Cave-Ayland wrote:
> 
>> The version property used to specify the IOAPIC version was originally 
>> set to
>> 0x11 when it was first introduced, but has been set to 0x20 since 
>> v2.8. Since
>> all machines before to v4.2 have now been removed, this parameter is 
>> no longer
>> required so mark it as deprecated pending future removal.
>>
>> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
>> ---
>>   docs/about/deprecated.rst | 10 ++++++++++
>>   1 file changed, 10 insertions(+)
>>
>> Following on from the discussion at https://urldefense.proofpoint.com/ 
>> v2/url? 
>> u=https-3A__lists.gnu.org_archive_html_qemu-2Ddevel_2025-2D05_msg03027.html&d=DwIDAg&c=s883GpUCOChKOHiocYtGcg&r=c23RpsaH4D2MKyD3EPJTDa0BAxz6tV8aUJqVSoytEiY&m=VQIG-iu-1g3JyKdn64SEj6Y6dVqbYfE1Qg5Y_tIeWrwR2OCa24MKUVV00MIY_5Pz&s=zH9Je8Y209R_2E3w533VXDqbRP-uhhuILVcvmoCkXdM&e=
>> it was suggested that the ioapic version property should be 
>> deprecated. A patch to deprecate the
>> property was proposed at https://urldefense.proofpoint.com/v2/url? 
>> u=https-3A__patchew.org_QEMU_20260210032348.987549-2D1-2Dzhao1.liu-40intel.com_20260210032348.987549-2D18-2Dzhao1.liu-40intel.com_&d=DwIDAg&c=s883GpUCOChKOHiocYtGcg&r=c23RpsaH4D2MKyD3EPJTDa0BAxz6tV8aUJqVSoytEiY&m=VQIG-iu-1g3JyKdn64SEj6Y6dVqbYfE1Qg5Y_tIeWrwR2OCa24MKUVV00MIY_5Pz&s=yWQKfxQqB_u6jU-CM9IYW1HqfEV6C3rUvz1pWzavjTc&e=
>> but was never merged.
>>
>> In the context of Khushit's patch at https:// 
>> urldefense.proofpoint.com/v2/url? 
>> u=https-3A__patchew.org_QEMU_20260804091827.3203086-2D1-2Dkhushit.shah-40nutanix.com_&d=DwIDAg&c=s883GpUCOChKOHiocYtGcg&r=c23RpsaH4D2MKyD3EPJTDa0BAxz6tV8aUJqVSoytEiY&m=VQIG-iu-1g3JyKdn64SEj6Y6dVqbYfE1Qg5Y_tIeWrwR2OCa24MKUVV00MIY_5Pz&s=rM6OQKsZNIdWJwPgdGzV6Y5ngrZQIxJecIlXXX8Wr9k&e=
>> it makes sense to formally deprecate the ioapic version property.
>>
>>
>> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
>> index 0c656a968f..bfe7240040 100644
>> --- a/docs/about/deprecated.rst
>> +++ b/docs/about/deprecated.rst
>> @@ -305,6 +305,16 @@ the addition of volatile memory support, it is 
>> now necessary to distinguish
>>   between persistent and volatile memory backends.  As such, memdev is 
>> deprecated
>>   in favor of persistent-memdev.
>> +``ioapic.version=xxxx`` (since 11.2)
>> +''''''''''''''''''''''''''''''''''''
>> +
>> +The ``ioapic`` device ``version`` property configures the IOAPIC 
>> version for x86
>> +machines and is typically set from the command line using
>> +``-global`` as it is an in-built device. It was originally set to 
>> 0x11 but since
>> +version 2.8 all x86 machines have defaulted to using 0x20. As all 
>> machines prior
>> +to v4.2 have now been removed, this property is no longer required. 
>> Deprecate the
>> +``ioapic`` device ``version`` property so that it can be removed in a 
>> future QEMU
>> +release.
>>   RISC-V CPU properties which start with capital 'Z' (since 8.2)
>>   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 
> Ping?
Ping again?


ATB,

Mark.


