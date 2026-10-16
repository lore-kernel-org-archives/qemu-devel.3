Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E6F9CCA464
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 09:07:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHdtj-0001fb-DS; Fri, 16 Oct 2026 05:06:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xHdtg-0001fI-5A
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 05:06:40 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xHdtd-00034J-41
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 05:06:39 -0400
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69FMcKZV1065043; Fri, 16 Oct 2026 02:06:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=wqZO3ODQIkCMzvMj1tQkSWaVwl48sxLNIhAsc30MO
 k4=; b=PmfoQ+yKNmBw3lvvgD1e3vu1dOMGs0QKpQCG31TenhzqyI6ZUgQgN71Nl
 rkBPf8kDKDzC7xshMilb/Klq0KGPk3oi/rY+5BCFOkHOzTXJWutKv3WDSnrLrgoc
 dTxujI+4kyewOCOIDJ7tBJdaPFBbVv6pKuFJ/Algu1zYoljHeoGm+o9f+3VeIqO4
 SfJRaSMYy0oqGHNV5ThzyYiykbYqJO5kQgaf9ZBqMHv68tpUvc6FVM0EsZ3H2FVK
 CL74QQvu+iTDCmFq4bEPIQeugC1sCp6sKEhHpSJXskb57/JmUReRmhJ/NrFM8f7z
 6b/DnNNLPwvz3u5uds36DPjqH1fkw==
Received: from bl2pr02cu003.outbound.protection.outlook.com
 (mail-eastusazon11021074.outbound.protection.outlook.com [52.101.52.74])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4hb7t192wn-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 16 Oct 2026 02:06:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ph94Y2dKvhqhuaYFuNJ8y/o4j5Rk+BdnB5kTidRLCPmczb/Oq1e6TlkQE1tWJYTnwc26Lc+j8Z3GOrWa3rwzFihatGIXyrynyx/Bu7Q5rIicQqBhiHC5kiIWPiH1EV9Uafi1HZdLrOblg74/4bam04fkkIgtjlAU55habfRGY6ghnZQx+fYQEDJeNOo7f/mlnAhZ87w+f826o/f22O0Rkug4Y9H3EuOvP/3Ka3IQRl7cEntUGbKqVC3KQcwsBDo0STW/Pj8h9kpoadpKq1+FPnFTOImu8cyzYTD5L3JEiLM+XQI7pKdMmDFgCY52mei24tFusq+ZPhwbzrrXNvPGGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wqZO3ODQIkCMzvMj1tQkSWaVwl48sxLNIhAsc30MOk4=;
 b=wvFQfXx8XV9Mb48dpvk2DP4X5/8LftTCWV7J9ZmEBwZV9d/NSLwKJwNM01q6R0FpvKHJYzPc7iL5PkWnVLYzULEqturZ5TeGB/DponmtI74C259pK8tz9YdQv5aomJGnZKyf8Tw/02UjsHz3RgotuxieVBe4tOql9cJ62KqNY2DzA74D9gj4/KAdU/k0hWuO/9YtzWH8MS9l3baLOh2HaVo70ppFdgNAGJCaB2Hi1tXbe/FHf1p5KIUkZxjzf4rkjuW8IzCcdsYMzDOFjy9cSXQy7nGzGcW/w9B6F4jKSE0FdagF92S7y3sQgBFJNMzFjPjNnpvSeZPhmDIQUatbIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wqZO3ODQIkCMzvMj1tQkSWaVwl48sxLNIhAsc30MOk4=;
 b=Pf2QUDYY154pecVdknL5awMIspnREapzZ/X8kx8iNeGn+SmAUTC0LRlZhBA35B5dKPNjULgj3nkL8+/7ucHYeGR57ZbiD28KnzVYkd6iJoAeqO8m4LxTguJaBTLe9InfA9qbxVWCEkyw4nbnBQnwWsStwICHOiKtRbFKR+jG/rSRH1X4t7pjL4X7J+H6AYNIZARpHRzaMPqLfWBPW6/5ZByzUsyzvR7wgkAGj9d4iyVoAL9ZazzILpsPUPe19qV+NtcBxc8PsggOSU/iWglqPOD1kPkUhdwz/HMMGYL3i48+iSkT1yLLyrmmD5ZpDSoiLuR0m6uMXU0XxgVsFQoRjw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nutanix.com;
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by BL0PR02MB6529.namprd02.prod.outlook.com (2603:10b6:208:1c3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Fri, 16 Oct
 2026 09:06:24 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%4]) with mapi id 15.21.0522.016; Fri, 16 Oct 2026
 09:06:24 +0000
Message-ID: <345aa187-30b6-4726-87ed-ee49f7ce2fea@nutanix.com>
Date: Fri, 16 Oct 2026 10:06:19 +0100
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
 <CAFEAcA-voNwJRTb2WQuxnvzk5LwBcXahz8HHrW=Yi3WUKeKgBg@mail.gmail.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <CAFEAcA-voNwJRTb2WQuxnvzk5LwBcXahz8HHrW=Yi3WUKeKgBg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0171.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::26) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|BL0PR02MB6529:EE_
X-MS-Office365-Filtering-Correlation-Id: 23282ff1-9e36-43a1-bf91-08df2b64c0b7
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|56012099006|4143699003|261009223027099003|22082099003|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info: n37ktnaQMxNzYt2CUUjB5+PJK93fHOMj2aK47wM+K8ao+paPmrVePiMPuZkXZTs5U13ncE2DDU2+NPnJW5tvzlVDlM3s8gn32I7WY7CDdzwNnmimIfLde2FYhdPEKnCHC8mxknl/R7lRV/Fodtpbo/i0dSMIhhwGIIS39gfH9L7Mt8m9JaJKaq6mz496QENlqquQkap+q+kygYuFTSd+LWYXznfNvxFh58T8VCcaB8AfOe5nKVXC/ck6vW87lm3nhycxwbPwFIcT2e9qpTaCZy5CGcZmPNztDMW8UAtQ/mJGdFSTO7Q/lbn+xFyiXyyxA1vv++0kH3hb0LJ5fZJONBcijgVmKOn0paEJ9/GeqPpOzFw5LcSgf7i7ud7GCu0jsHCSwdYDxP7E8DXtRQMD4QAxyU9G5vLS6PMx7bGllrjnPjPrYDM2ez5uS8OJvmb5i5OyiQj4uz7Htsbvz4qH7zWu8Zw4b1GgmRrNYqZv94jG58N7IPdrNMLLcfb5MpEITZeis2HxqLydc3aWFzIxYR7ML0bURKS56UL+Uxmz4XoH8lP/fHQRMth/99l+tR5AiyFy5v2oYRupczjq52YTLpFV8V2VYWzP7mYYf4aPevzsOiUKsQ9VpJjolpS2X2mFovv9bltngTKBaVl7bKDm2+rnt1u/aqFL2Jl54j01g1k=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(56012099006)(4143699003)(261009223027099003)(22082099003)(18002099003)(10067099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a0ZnNEJ4K2FSQURQNDYvcGlKUXBmSEJHdVBkYko3dzJ5Y0JjdTlSSDQwVTlW?=
 =?utf-8?B?SkdiVjh2Y2w1V2NpYjlodmxGLzFUR2YwRUdoTy9nbW1VZzRPcXdnL3ozOEJG?=
 =?utf-8?B?d3U1Um9aV2tUWXZKT3N2dWlzQ2x4ZituUkVKMnVENldxLy95UWpWZ0djbW50?=
 =?utf-8?B?VUNEZEhiclpqbTFjNVBnQm9WdGNoSEZxTWozb1plbitVODFGR0IwWXpYeFkx?=
 =?utf-8?B?Nk1zSGxMc0VlOWhOcVcrUnVVdThuYS9FbnRTSUpJOUVyQVhxMTZpWkUreXdy?=
 =?utf-8?B?aWFvc3JnMytOUkdRRmhnV0dvTVA5TnMzWlRjeTkwTzllcUhpNGFIdldPRFNq?=
 =?utf-8?B?MGRhYjUxMjBEdUNXcUMwTTVMZGdJeHZkQ1hSWE5GVzF6Q0F5VlZlWm9VWm1u?=
 =?utf-8?B?WDQ0b2RPMzZ5S2h5QzNhQnlGRVBSdEhrY1hvMXhqOWdwcFpNaVIzTlBHVmhw?=
 =?utf-8?B?NzdhU3ZEWDZONnJPK3BkNGJWa3VSYmFDVlhFRjlLZlJuWFhBTHVkSFdSK2JU?=
 =?utf-8?B?TGJYemZHVUZITmQ2eUJ4bFRnWlNwVnBPNXh1eStJUWlQbitFc21SelN6OFlS?=
 =?utf-8?B?UUlzV3dKNGNnTE8xR0c3ZnBtRXZRRUxHYmpiNC9sZUFSWnlKMnJwTmNrOXpy?=
 =?utf-8?B?NVAwUHRIQW5sL3czRWZRTFBYVG5lQW9mYXN2a3lZUHcwYnJ2VExaRVpKT0hh?=
 =?utf-8?B?QmxuTUVKTEs0blNPM01DdlRuTFc5U2VMbzYyM2M5blZmT1FjMWNjVVMyRitL?=
 =?utf-8?B?UlNpd3hGNTJvdEFiYUlsS0JzbVZwMG5vOW9WR3VTSmdibldCbGNNV2NvcUVu?=
 =?utf-8?B?dDVXcFovRmIwc3V4L1JMcFBNUm9BZGhYYlR0WnRTSS9PcC9Wb1AzUTJGMEJq?=
 =?utf-8?B?Q1NLWjlIRHNlSUdacVFsL2ZyZjZuRjRvQ0FhMkM5U2RXQjQ4UUVSTlRHT2Fi?=
 =?utf-8?B?MFJwMENJZGtycmp5QVBJc0FHZVAzVzk3UzNrZzgzYVhaZWNzSysvTU5GZlZU?=
 =?utf-8?B?dzdPTzNJV0VUV0ZxU2FsZ1pmamRXUit4Uy9ZVVpoUUNqd1RMRjdGOG1EZFFN?=
 =?utf-8?B?dUYrYkViZ3FUZEpaeERJd3BxYWc4Z2tRRzJWZHBEMmgzZkdkRWJCb2hKTU8v?=
 =?utf-8?B?Vk8ycUNnUThmYnk2d01tK1lUZnFMcFpDRGlIb2dQNTdGKzhkc2padmZCck9Y?=
 =?utf-8?B?NFRYYTNZSzhFNkZ3UXJMMjhFVTR5L3VHS3VubHAzclE0V1NhV2N4VzJReWlH?=
 =?utf-8?B?eEZBa0tIUzN6TnkrcVFtbGp5bXFqOWd3elo2am1vYUd4MTFvS1dxWUErMXNm?=
 =?utf-8?B?dGpNVlNkY2NnYlIzYnF2ZXZqblZxV0FoY1M1S24yWWNwUkxYME5yRjg2VVkx?=
 =?utf-8?B?R2FYSkZ6SFJQc1d1OG5mb1AzV0I1UUJCcEpJNDFaUjU5UVFBTFBmTmZNQnA5?=
 =?utf-8?B?S1RBcFFHUFkvTFJwNFhrVnNwQmNYM29zY2ZnNGltM05aZkFHZXpkTVA4aCs4?=
 =?utf-8?B?VllGZ3FNOEhzNzFFSm50ZlZNVmdlU2x6VkxjK2pRV0NtaU5EblFjYWo3N212?=
 =?utf-8?B?Y2RKYU5TRFVQRHpmeUhYWFRkamo1RCtxMWhuYm1pcDRSMzZkS2V0WkY5YnRm?=
 =?utf-8?B?WWRJYXhidWhHN1pTWG9TUXl4c05ZUkl1ZEZRMG1wang2cUhpMEVoY2g4RXNC?=
 =?utf-8?B?YlZsdEtKLzdSNGpkbjlmaVMzK1hQdHc3RnEwUjMxZUpncXJKTDFteERUMEsw?=
 =?utf-8?B?ek1IbTBDbnIzeGh5em92d1ZaVTlacFY3ZmVBMGw3NDRseXpVWjI0YmZRejRP?=
 =?utf-8?B?RjdpYmFnOU9OWGFzbDJzSkZNdzdnb0xYbTgxb1ptckhONnhJRW94VldaNUNB?=
 =?utf-8?B?S3hjZzUrTW40ZTFoRFR4ODAvS0hVbU5IRjNXR0lwMHZmSG1JdE9LU3NSMmEr?=
 =?utf-8?B?WXMzcWhlVzN0UmN4L3psNnZrZDVmVUNLdGxYckd0NGhUUjc5RVF2VUxpN3Jq?=
 =?utf-8?B?a1U1Vlp4YmUzRXdyZDI3NWdCZ1dBeHZUVHF4Yjk5anlkRU96a2R3UGZDc2pD?=
 =?utf-8?B?bWFlekdnNXlTTDRFVS9lU0ZTaUlCZ1liOSsxaVZaYXhRZWNqVEN5S0RqeERS?=
 =?utf-8?B?Qy9TOTg5TVZIK0pkeEpLTU9KTEhoVjhvVkRBU2JLK21oTHdQQnJ6cHo4QlBx?=
 =?utf-8?B?TWQyVmJhVEhYRGtGM1loQmNNOUkrS3pEelZZVkQxbTdJaE5VTGh2bTJVTlhl?=
 =?utf-8?B?Zk5hTE81MXdadnlDS1JESm5Xb1dHcFRvZE14TzVNRkd5N2U4ekZxUEFDWGhj?=
 =?utf-8?B?eHRmTjUxYXJVYUNsN2pZZHptcWFrekorMHdvL2hJaFBRWVpoWVFSeTQzanNy?=
 =?utf-8?Q?rSQkWE8bejYYQT2o=3D?=
X-Exchange-RoutingPolicyChecked: JlXi6sZo8HTR23yWqMlrBcCzXQ95HS13zsKvEvkT5j37i29jesFmhQHCb/o8+S3KzM5PmjxMUwqqVxwv4VsZEsmFsZipYwcal9omIZ9L2UV5DUiIAUMlRcrPDfKq4Qnw81Nb6/8V+iI0TZ692e5c27kzmO0txfcUXAqdnHJHvuLtIpI+XvVrNKpi+KG0tRQyjDW9rJn8BEC+t+m+5Sptqhkv2yCk0QUUuurzDKErQuO8tz75cdPAvUpcdV3z5ULak+XCyOQATDMbrLWwq1ifp04vgqeQGef95QA9nz6trGO2/bcBpoYTW1uF+R1JIk+etLdOs3kS/rHZtFNYpCumuQ==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23282ff1-9e36-43a1-bf91-08df2b64c0b7
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 09:06:24.4874 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VhqSsAaMb4s2sfuAqtFYqDjVLn+RGv/rwTY99O4VvdiEx8trdwJQQWWZHnkWpfeidtgq7xtmfjZbYianE5N96y8ct+YaCxyG9/EU9Ho09vc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB6529
X-Authority-Analysis: v=2.4 cv=LsYHWXdc c=1 sm=1 tr=0 ts=6ad1e912 cx=c_pps
 a=b/aSlx19e507fu+kRueGxg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=_-M8LpHI31CeLmyZm6wg:22
 a=KKAkSRfTAAAA:8 a=64Cc0HZtAAAA:8 a=zOK0QRzV0C4MD-MyP_wA:9 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDAzNiBTYWx0ZWRfXxMDU593979+c
 Ggv1vx9yp6YpZVx/hRQtNkERF0jdqlk93zcck9+xFIBREpbk6W0nMTEZLQ65SGtZnVxkfMb6Rql
 dOtq+oT59pfShJn3Vj9DFzS3M8wFiFw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDAzNiBTYWx0ZWRfX5Syw7+l02HBX
 j8xq4/CbIgS1SviCzGFPrA99ExOvSFO+oI1zDIsqEznnAvcahCN29ljTfIblSdudScGzOAQeqME
 4k9c0lMdZ92FZZgeleqoeT3bZvSi6HhmORq7+hDlCVTAKVkDWmOT+FYS+3XRo4MK9MNpot8zC1N
 lUlZQay7qE5JThctQ6NrljBkdJd+d853UuSBIAaAVFWjKTkS2X+VIUfPTrTF1NV/nXHt5A2DjOW
 nAMmIE23lrA9z+l5ekwpR7gxn+EUf9UUIFSZXNm4PuVea1xAOUYN1jjHfOHbxMb7bLky5W7kA2T
 bPhJ2YnEdzXwNPKNLgCO9o0BOyTJF3q4bW98WdC6VMZK0bFvizke7pUbGFbqDCRxH2nmlnBtGBX
 b8SzGCInDa7iYJCSAdK9tAl4zZSbhOYo2l5/2lcpDsKHSuBGfs1z4xU3H56756Khvtyy735PXNu
 NjwmwQCxgsS9BHshTlA==
X-Proofpoint-ORIG-GUID: oIGeMBYcHoPTLMJDunahfV3X9UJ1p9rm
X-Proofpoint-GUID: oIGeMBYcHoPTLMJDunahfV3X9UJ1p9rm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
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

On 15/10/2026 17:22, Peter Maydell wrote:

> On Tue, 13 Oct 2026 at 16:54, Peter Maydell <peter.maydell@linaro.org> wrote:
>>
>> On Wed, 16 Sept 2026 at 11:49, Mark Cave-Ayland
>> <mark.caveayland@nutanix.com> wrote:
>>>
>>> Both the emulated and KVM i8259 implementations store a reference to the
>>> parent_realize function in their respective classes. Start by moving
>>> parent_realize from PICClass to I8259CommonClass and removing PICClass since
>>> it is no longer required.
>>>
>>> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
>>
>> This is one of those things where I think we're not 100% consistent
>> about whether we think the parent_realize field should go in the
>> child class struct or the parent class struct. The name "parent_realize"
>> implies it ought to be in the child struct, though, and I think we
>> do that more often than we put it in the parent class.
> 
> We do, although it's a bit closer than I thought: about 50 callsites
> put the parent_realize pointer in the child class struct; about 25
> put it in the parent class struct. So I think for new code we should
> prefer to follow the child-class-struct version.
> 
> in child's class:
> 
> hw/arm/smmu-common.c:    device_class_set_parent_realize(dc, smmu_base_realize,
> hw/arm/smmuv3.c:    device_class_set_parent_realize(dc, smmu_realize,
> hw/display/macfb.c:    device_class_set_parent_realize(dc, macfb_nubus_realize,
> hw/i386/kvm/i8254.c:    device_class_set_parent_realize(dc, kvm_pit_realizefn,
> hw/i386/kvm/i8259.c:    device_class_set_parent_realize(dc,
> kvm_pic_realize, &kpc->parent_realize);
> hw/input/adb-kbd.c:    device_class_set_parent_realize(dc, adb_kbd_realizefn,
> hw/input/adb-mouse.c:    device_class_set_parent_realize(dc,
> adb_mouse_realizefn,
> hw/intc/arm_gic.c:    device_class_set_parent_realize(dc,
> arm_gic_realize, &agc->parent_realize);
> hw/intc/arm_gic_kvm.c:    device_class_set_parent_realize(dc,
> kvm_arm_gic_realize,
> hw/intc/arm_gicv3.c:    device_class_set_parent_realize(dc,
> arm_gic_realize, &agc->parent_realize);
> hw/intc/arm_gicv3_hvf.c:    device_class_set_parent_realize(dc,
> hvf_gicv3_realize,
> hw/intc/arm_gicv3_kvm.c:    device_class_set_parent_realize(dc,
> kvm_arm_gicv3_realize,
> hw/intc/arm_gicv3_whpx.c:    device_class_set_parent_realize(dc,
> whpx_gicv3_realize,
> hw/intc/arm_gicv5.c:    device_class_set_parent_realize(dc,
> gicv5_realize, &gc->parent_realize);
> hw/intc/i8259.c:    device_class_set_parent_realize(dc, pic_realize,
> &k->parent_realize);
> hw/intc/loongarch_dintc.c:    device_class_set_parent_realize(dc,
> loongarch_dintc_realize,
> hw/intc/loongarch_extioi.c:    device_class_set_parent_realize(dc,
> loongarch_extioi_realize,
> hw/intc/loongarch_extioi_common.c:
> device_class_set_parent_realize(dc, loongarch_extioi_common_realize,
> hw/intc/loongarch_ipi.c:    device_class_set_parent_realize(dc,
> loongarch_ipi_realize,
> hw/intc/loongarch_pch_pic.c:    device_class_set_parent_realize(dc,
> loongarch_pic_realize,
> hw/intc/loongarch_pic_common.c:    device_class_set_parent_realize(dc,
> loongarch_pic_common_realize,
> hw/intc/loongson_ipi.c:    device_class_set_parent_realize(dc,
> loongson_ipi_realize,
> hw/intc/loongson_ipi_common.c:    device_class_set_parent_realize(dc,
> loongson_ipi_common_realize,
> hw/intc/pnv_xive.c:    device_class_set_parent_realize(dc,
> pnv_xive_realize, &pxc->parent_realize);
> hw/intc/pnv_xive2.c:    device_class_set_parent_realize(dc, pnv_xive2_realize,
> hw/intc/spapr_xive.c:    device_class_set_parent_realize(dc, spapr_xive_realize,
> hw/intc/xics_pnv.c:    device_class_set_parent_realize(dc, pnv_icp_realize,
> hw/intc/s390_flic_kvm.c:    device_class_set_parent_realize(dc,
> kvm_s390_flic_realize,
> hw/nubus/nubus-virtio-mmio.c:    device_class_set_parent_realize(dc,
> nubus_virtio_mmio_realize,
> hw/timer/i8254.c:    device_class_set_parent_realize(dc,
> pit_realizefn, &pc->parent_realize);
> hw/virtio/virtio-pci.c:    device_class_set_parent_realize(dc,
> virtio_pci_dc_realize,
> target/alpha/cpu.c:    device_class_set_parent_realize(dc, alpha_cpu_realizefn,
> target/arm/cpu.c:    device_class_set_parent_realize(dc, arm_cpu_realizefn,
> target/avr/cpu.c:    device_class_set_parent_realize(dc,
> avr_cpu_realizefn, &mcc->parent_realize);
> target/hexagon/cpu.c:    device_class_set_parent_realize(dc,
> hexagon_cpu_realize,
> target/hppa/cpu.c:    device_class_set_parent_realize(dc, hppa_cpu_realizefn,
> target/i386/cpu.c:    device_class_set_parent_realize(dc, x86_cpu_realizefn,
> target/loongarch/cpu.c:    device_class_set_parent_realize(dc,
> loongarch_cpu_realizefn,
> target/m68k/cpu.c:    device_class_set_parent_realize(dc, m68k_cpu_realizefn,
> target/microblaze/cpu.c:    device_class_set_parent_realize(dc,
> mb_cpu_realizefn,
> target/mips/cpu.c:    device_class_set_parent_realize(dc, mips_cpu_realizefn,
> target/or1k/cpu.c:    device_class_set_parent_realize(dc,
> openrisc_cpu_realizefn,
> target/ppc/cpu_init.c:    device_class_set_parent_realize(dc, ppc_cpu_realize,
> target/riscv/cpu.c:    device_class_set_parent_realize(dc, riscv_cpu_realize,
> target/rx/cpu.c:    device_class_set_parent_realize(dc, rx_cpu_realize,
> target/s390x/cpu.c:    device_class_set_parent_realize(dc, s390_cpu_realizefn,
> target/sh4/cpu.c:    device_class_set_parent_realize(dc, superh_cpu_realizefn,
> target/sparc/cpu.c:    device_class_set_parent_realize(dc, sparc_cpu_realizefn,
> target/tricore/cpu.c:    device_class_set_parent_realize(dc,
> tricore_cpu_realizefn,
> target/xtensa/cpu.c:    device_class_set_parent_realize(dc,
> xtensa_cpu_realizefn,
> 
> in parent's class:
> 
> hw/input/lasips2.c:    device_class_set_parent_realize(dc,
> lasips2_kbd_port_realize,
> hw/input/lasips2.c:    device_class_set_parent_realize(dc,
> lasips2_mouse_port_realize,
> hw/input/pl050.c:    device_class_set_parent_realize(dc, pl050_kbd_realize,
> hw/input/pl050.c:    device_class_set_parent_realize(dc, pl050_mouse_realize,
> hw/intc/xics_spapr.c:    device_class_set_parent_realize(dc, ics_spapr_realize,
> hw/isa/pc87312.c:    device_class_set_parent_realize(dc, pc87312_realize,
> hw/isa/vt82c686.c:    device_class_set_parent_realize(dc, via_superio_realize,
> hw/pci-bridge/cxl_root_port.c:    device_class_set_parent_realize(dc,
> cxl_rp_realize, &rpc->parent_realize);
> hw/pci-bridge/gen_pcie_root_port.c:
> device_class_set_parent_realize(dc, gen_rp_realize,
> &rpc->parent_realize);
> hw/pci-host/pnv_phb.c:    device_class_set_parent_realize(dc,
> pnv_phb_root_port_realize,
> hw/pci-host/pnv_phb3_msi.c:    device_class_set_parent_realize(dc,
> phb3_msi_realize,
> hw/ppc/pnv.c:    device_class_set_parent_realize(dc, pnv_chip_power8_realize,
> hw/ppc/pnv.c:    device_class_set_parent_realize(dc, pnv_chip_power9_realize,
> hw/ppc/pnv.c:    device_class_set_parent_realize(dc, pnv_chip_power10_realize,
> hw/ppc/pnv.c:    device_class_set_parent_realize(dc, pnv_chip_power11_realize,
> hw/ppc/pnv_lpc.c:    device_class_set_parent_realize(dc, pnv_lpc_power8_realize,
> hw/ppc/pnv_lpc.c:    device_class_set_parent_realize(dc, pnv_lpc_power9_realize,
> hw/s390x/tod-kvm.c:
> device_class_set_parent_realize(DEVICE_CLASS(oc),
> kvm_s390_tod_realize,
> hw/virtio/vhost-user-gpio.c:    device_class_set_parent_realize(dc,
> vgpio_realize,
> hw/virtio/vhost-user-i2c.c:    device_class_set_parent_realize(dc, vi2c_realize,
> hw/virtio/vhost-user-input.c:    device_class_set_parent_realize(dc,
> vinput_realize,
> hw/virtio/vhost-user-rng.c:    device_class_set_parent_realize(dc,
> vu_rng_base_realize,
> hw/virtio/vhost-user-rtc.c:    device_class_set_parent_realize(dc,
> vu_rtc_base_realize,
> hw/virtio/vhost-user-snd.c:    device_class_set_parent_realize(dc,
> vu_snd_base_realize,
> hw/virtio/vhost-user-spi.c:    device_class_set_parent_realize(dc, vspi_realize,
Thanks for the analysis. I agree that it makes sense to put 
parent_realize in the child class as opposed to the parent class, and 
I'll make that change to my current series.

I also realise from this and your previous response that I misunderstood 
exactly what you mean by storing it in the instance...


ATB,

Mark.


