Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F16DECCA46C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 13:57:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHiRQ-000593-WA; Fri, 16 Oct 2026 09:57:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xHiRP-00058d-8l
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 09:57:47 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xHiRM-0003m8-Nf
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 09:57:46 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69GABbps2741207; Fri, 16 Oct 2026 06:57:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=R2XJd+bzf7a5y0OLUtZYoxG8U9doHLHY9o2PABFAv
 1Y=; b=z3KyA7uwIiLAyjP2uEh2IfdrRrZBwWFRPkDVEPPPfwTrqjw8X60L9ihr3
 FbnW/O7jtd5s+Tgu1UxUmRo40KPRV0psOYwzl/HKjADbsTNecOAcm5nR9jzMxOj2
 uLziYrKOzZTwzvGEEYsx5h0kVLybBn10YYQNfXairg/I/BzdbdVFR4RCWdAowOvi
 hpIol2WTWMI4J3ePsOoKqqHAPQJl3m6RLWpBwpd14l8TmwEs5PM0GzpwBNqFzCH3
 9KaM28Q2MLoPLFm5Z48ofuAOX0dyFjqX5/wtPCpWCa+RATiye7ckVDVRDLzx1Ja2
 0ZQz9+GZSEjICvLCMZBdIJZGilDxQ==
Received: from byapr05cu005.outbound.protection.outlook.com
 (mail-westusazon11020088.outbound.protection.outlook.com [52.101.85.88])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4haxj936j4-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 16 Oct 2026 06:57:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=etR5PrpKRnvjG9jQw9Y0d8ysZsA6rMQFjCx+YXjg5rfcLNxewRlDhwORfoBYJuChLWesQ8qkGu/01mTmQr/u2iAVYnqSpIo8nvJabqqViQpE10qfNM1fIqElR/+t6HmpGPQZoeGuQVAK+pSCYoQ/EYtSY6WxGmoWMtI9Pli1H3R2CF6zV0BQYXWurfdjhjC6yIWCJ4qQNmnqMRo27E8HSPjEagvAwvAHyN8a4I886dpN2pJ/X8w6Q39GF6ULtUNQngiEc2C+vii2MvlDW6TGFUkXca3eJ8a4glVk028ulEIEmTLmDijPlFE8YQX4x3n5DwRYyyMHDL6kO6rok3N7YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R2XJd+bzf7a5y0OLUtZYoxG8U9doHLHY9o2PABFAv1Y=;
 b=xM/13Dm3GnSMqpHCpgPgN3AcsRubIsrbCcAFtmn2dsJdZGZJEU6cmLcnIxZMZpRg6lbqivwUYwhQmv4GmmJKE4v8l6HnGswQrEDWvSGj0/EBivd6wZYoXNW9I6N/NArOHTA325ZhuMxs4g7xXfApYwyJ8KpDuO6gSooUdagCKRkt/ZfmW/SyHZQTb5cVoOgF+glpRL37ezccVNPIp84bNOXDk9KCr0okohfXU55V4BxJ8uJMu4Zwzrpx34rZFwvYZzmAPBfgPuQp+3uOaR5bqBR+R6vK+S7p11VeRH6skXjtlwguFVmiS5ViNvejK1RsqzHsfLWlCDWsAdKG9r7DkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R2XJd+bzf7a5y0OLUtZYoxG8U9doHLHY9o2PABFAv1Y=;
 b=BfJ5ZARezjwi7wk3RDXEpW2FAMG+xWJHSYonvEFwj1nRSQ5xTkH6IqU7gmVg0RD3i2xTjosGxbx3ttQevN3aKqdj2TDBALmHNSxHpz5VpDZdHASAh0puLjk/tF02lI4zwp1k4SY+AW4BijrDDefnB6NK5B/BrdENjyTIafR7ibdisuppQNYuki4zu/RcllC2FOiuYQ/ycn7g2thWvlXe2khBp3F7rXWJE6evJRl3XUwinxZZvposUIjyg2WKt7NTmvysaPE8QSq9IRRpPY+rZKPQ84zaxFTLZjEn9S1trWnSUOANCWtIAsKqkNhK3SCKJNjYAIqRyAE9XCpKJXpqdw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nutanix.com;
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by CO6PR02MB8836.namprd02.prod.outlook.com (2603:10b6:303:147::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Fri, 16 Oct
 2026 13:57:35 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%4]) with mapi id 15.21.0522.016; Fri, 16 Oct 2026
 13:57:35 +0000
Message-ID: <c2fa2899-ebc2-4cef-873c-8939f378bf22@nutanix.com>
Date: Fri, 16 Oct 2026 14:57:29 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 21/22] i8259_common.c: remove static irq_count and
 irq_level variables
To: Peter Maydell <peter.maydell@linaro.org>
Cc: pbonzini@redhat.com, richard.henderson@linaro.org, mst@redhat.com,
 sstabellini@kernel.org, anthony@xenproject.org,
 edgar.iglesias@gmail.com, qemu-devel@nongnu.org,
 xen-devel@lists.xenproject.org
References: <20260916104435.600211-1-mark.caveayland@nutanix.com>
 <20260916104435.600211-22-mark.caveayland@nutanix.com>
 <CAFEAcA9vm7004bytZqYwXCNj_+VNy1RzKMqG3TDnJkswpNhLUg@mail.gmail.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <CAFEAcA9vm7004bytZqYwXCNj_+VNy1RzKMqG3TDnJkswpNhLUg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR05CA0024.namprd05.prod.outlook.com
 (2603:10b6:a03:254::29) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|CO6PR02MB8836:EE_
X-MS-Office365-Filtering-Correlation-Id: 48dd3b05-83e2-497d-f078-08df2b8d6e2a
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|56012099006|4143699003|22082099003|10067099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: 6EcYbohtM/CvT2NXVy3C+FBE/h2PloIn7DAJDfmLDi4ijCRKKEMS0+/LXfU+Nd/Ua9JH/SXWTxwCHVaqoJWGxC361ImQEITml1KTYk3vdUbvUxL3sm3N4ZiudRohSbhwnola4D48w5EoElHFJ/A1kUmHQPvaWoZ9BhrJqBEwzJlOUrJ7lPwD9Jra2F8bWggK1tCwf+MLknyx2JBk2x9jNURaKbC8Y8wkRL6x9JwPLteSYmH10Jbkxj2MYWPfzE4buC2hkVe1cffnp8m25DkfQawQlATnjTWJ6ClZSeUsyIfYOyf2UjMRHqUhTIZY7TOe3V/02uTquckYRZZ8M4g962FLtDFCcqy0wiShERH43e7lDpuoqzsbG0mKuzJ344QAmEYNacv4gvfB9TUs0lYMzQUCrxu/PjA6LRwGhZySOKbvfGeb3yDXLeVm8rb7yfmVZjYjALlEHZxKXoNotTAoLWt4Bz3Qpfy2yekrGqj2EUrHa+BWh/efNgoNxn5cF4qtjiaRfGIVkdqYSdZEWWj4zXpPmopzGI9RBKf0R6dlhYcHRO8G/Z9ZWw4INl6u8LKScv5ACeTjpF4JxdE4HnzNrnLpalet5CNFNBQRmicn2wacqlTG0osCxLSsDlOfBW9Mn65+v3ozOqI+BdKW8hFLQEDxh43T16JHYd17/VDvNog=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(56012099006)(4143699003)(22082099003)(10067099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MnJPbGp5UUIvN3FKM0NpaFpoRFh0cUdYZXpDOHN3VXFyN1A2a3J6d0hjc1Fp?=
 =?utf-8?B?dmVyNWFCUVAxVENCOXdWZnRJVVRBWDZ4WkJiR3dPMFNndlVJTkczQ3UwTEhs?=
 =?utf-8?B?NFpxT3lhd3RjT0dNQzFPRHpsODRGbzF5Ym5HUkpOV0pMZUp4Y2FNRjZZQ2Fw?=
 =?utf-8?B?RjkyNS9KZVZEUDNTMTJjS3cxTDhVMXlQOUVDZ3Q1UGJ0cGUyVnh0bjlBaVJ0?=
 =?utf-8?B?MzNEbmtEQjNldGxrdVFqWkpDc1V4eCtPOUkyVmdodnFvVzFta21CQWpyOTM2?=
 =?utf-8?B?eXhjRGNLRDc0M3FhZUtCeERMKzEycFVKR1c4bXNIM0hNSHAyK05GeUZSelF2?=
 =?utf-8?B?dXY3cDFQaEMwZDJHc1VKNUxraGM1VFBTYWNFODRCeUpscU95TThRWFI3YTR0?=
 =?utf-8?B?QzRDL0xYTUpxUU1DN2RWRlRKaVRnZEJFRXk2Z0QyUmFhbFJqMEVvQ3FBK1dJ?=
 =?utf-8?B?QmdNaGVWcVFIaEJnTTRaeHQrWndlRExlUGNhL09xeHMxaWxzQXlwUkhrd0lU?=
 =?utf-8?B?TThKN3pEenFRdmlaY2R1QUZpL0d0UENNUm1FL1BCdjQvTHFwL0xubWczbFF1?=
 =?utf-8?B?bk92LzlJQW5maTh5SHpUaWk4ZXU5Tzl4Ry9ycE9uVEl6QzY1ekNJVU91anNn?=
 =?utf-8?B?M3hFb1V2V0tyMnlUdlk4d1RucGFiclhJeG8vQlV2bDhXKzhiN3pDZjEzRHg0?=
 =?utf-8?B?SEloRHdaemxENk0wVkVQVDY3S3NxZ0RXc3BxeDJvdGV6b1pmUEVSb1d4dkpB?=
 =?utf-8?B?dlkrZW50ZTBncjhLZG1QV3VoN2pEYWRiU2x5TS9MREJGTUY5eUcrdEQxRmIz?=
 =?utf-8?B?dlhLbUpLaEVvM1FVRlczZW8xSWJqbHg1MnVReUdBU0lKajQ4T2l1UHBGUHEz?=
 =?utf-8?B?QWlja253SW15RVBmeVRaakVCTnNCTzliR0VoKzczY3pkSis2UU5yUEtOVjJk?=
 =?utf-8?B?eUY1R3c1TTRabU5JMXRMYzE2dWVrV3dkckRUVlNoRS84Lys1K3VMTWtIdVJt?=
 =?utf-8?B?Q2dyVUlCcnNRU2JDMElUVmpVNngybjRCQktidHBiZmtpWXRabXp2NmVlcDk4?=
 =?utf-8?B?THlIZ3JDcVg5R1dPQmRKMU8wL3pOOVJLcDJYRjdja1VLYS9Ka0w1N0RnNlBr?=
 =?utf-8?B?MEZVVW9TYWJkdTk1b3JvajJMUWZxSlMvVG9uaDhuYzhITVorVHY1cVlSTVcv?=
 =?utf-8?B?SkxSQXRkczBVdDRaVFFxL0t3aVRyc1hrVE15a2hXYmxsRWNzRDNNZjBTc2Rj?=
 =?utf-8?B?d2VLcytsNFlXbk9rSG5CaG9jVlRRc1VkZ0VHVTJnNDB2Q2JVanN5WkFYQW1V?=
 =?utf-8?B?NXR0MWt6NFNMZXU3MUxKWVYrZEZRcVREeWRSWU41VzFhT01OSFBkYTlPK1FU?=
 =?utf-8?B?K0xuMGhPQkJpb3RSNGR4alFZeWZxeVYrREFHUXAzSCsyeGh0NUQyc25YSVZX?=
 =?utf-8?B?VHkrdXo1VWdYbXRTbTVaeUIwNzE3SFRTRTBYV1doaWlpSTFLbW83OTRRQlo4?=
 =?utf-8?B?djNld0lTSjBEb083bnpUSkJCb3Zmd2E5RVhXc3R6Y0EzdmEvWGpuMWQ1U0NB?=
 =?utf-8?B?dEdXbXRzRUhaWXFMTUo1KzRBR0ZsRXlXKzRxZklpeXQ5S0hTSStNUTN4TFg1?=
 =?utf-8?B?Vld4ZENUdEQ0MTNBay9xbFZ2Rm1iZkRnSmxiRi8vRFdKWUorQkZLNGdwVGRu?=
 =?utf-8?B?Z0wxYWpFZkFYNG43b1dTelowcUdxaTM0MG5PVHRiRzMzT1RmclhNM2hZbDF5?=
 =?utf-8?B?R3JPUndSaEdKb1dkVDNkQ3lla1B4UER1NlcvQkVPdFFTVzNiSlphNTVQV2ht?=
 =?utf-8?B?UFNQZDE2T01XM01mRnZ3TkZ6K1Q2aVhLRWVUWWhuWE1vMjBoSU9lTXJzaXd5?=
 =?utf-8?B?UEs1OWNEVVhvclE4eHRCcFJJeGVlb1JrM0drcWlhVmc0UmZnWS9MdmRjVFFu?=
 =?utf-8?B?c0xWcURHK0gwSkVIazF1Y0Y0MEF3ckg1bktPSVRGblBSdXgwTVVjYkdWdnU1?=
 =?utf-8?B?WjVHMWFJM0F1WUlNcnlRalp3U1lvMVBhaU54a1FibDBTanRCSkR4WHlQSnhQ?=
 =?utf-8?B?dGZmeEhtaDhEVnB0QU5wL0ZhRmJxa2FOcXhBVHZvR2lWOUpVSFF1TEFoaUdr?=
 =?utf-8?B?TVl1TStyZmF3OGFSbmMvM1RhcTZ2RHZ2eWUvSmxiN3MvVVFxVTBGZ3RvOEpT?=
 =?utf-8?B?WUpGSkZ1WXhDZnFNc1JyTTBjSHJlTWtCYlVoMnhXMFd5QUVSWDQ2SC9nUWJ5?=
 =?utf-8?B?SUNtclcrekMwMWJBYUlMcHZFUE1xMmwvTjNRZHQwd0ZBNFdaanVWTDJzOXZP?=
 =?utf-8?B?R0ltTWFSdnBSRGlSR3hoazVRaHNNSmp4eFdsZHdhMlc4aGZkSGdHbVZaL3h3?=
 =?utf-8?Q?05HkjsvdifJWkPMg=3D?=
X-Exchange-RoutingPolicyChecked: yg8R1DXX9MTVvTOYxmm/AEo0TzDu1VjFGWKWSpdgwZ3nqYgB+TrLs1zHXd0KLpZeXHE9CuXqC/Ai81y65nEzwC07kFK5kNuPxGqxKlRcOIB/JkQisjkz11lXJvQE802lQV0pfKY1VyYVxQrehRZjWgr78JlNYNJtEU25XG9OTuX2SB8Km1PsPZJr/ig9be9yQhqYek1dDEaQCZxo/gP+G9dA0XOcfh3uLXNoWGO+8gSUf/niMisu+sPUiwmNaA8ljecxdI0bWLuz6DRCAtD8lGqryQWpfK90S9IslHO+dXiDoA+zc555tqh02n+2qT+PIgV80X/6wJ8TowiycuaIFA==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48dd3b05-83e2-497d-f078-08df2b8d6e2a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 13:57:35.1287 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bAlio+hyug2SBUox72XezNaWf1+edFSp2sjKPEN4Kh6Y+LP1dMz5VtncQoZgn1rmgwtUb0aZ5zIBoMdToDVOOA6atyNx9BdJ39HMkUljiLA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR02MB8836
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDA1NSBTYWx0ZWRfX9vCOPGsVYIG6
 MVR5x+2+VHW1wnScfIaUjUK7Zo1dVxQJQqLOPwHDOqx32/QdqNpImeTr0qr/cebbHEi7XnaPbMH
 HvlVmIOPI5XXFbi+8k06LkdPXYD1JA8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDA1NSBTYWx0ZWRfXwMuhjlDa9OmQ
 jBnW3YRs1o9Y2/nwetNglb9RFJ8qXoy6Lu7/6dtNmZFBkSJXog5i7X5fB8/nYY4FIhOzucDiKxF
 Mb2U8ADRIBx6W6B46cMG0l+Awa6537efIAKIBpqMyGCvw/u6XfCx8ZOdpMqJcjp1ySSeuTdHh+p
 u692G2ZeZyBHjRd6TxlLLz1uz16BiaUWtiIH6alaTIS82BJXeVHqLzbTcBMMb5ZZgjFyHvLX4M4
 zyNzya4B+wLLkBBhv5Vj6+D1sT3AHR1n5kGOKx5UqktzRrfTew1rJTIKcVFvzqoL+/6AmVjuJY0
 PIBQyFnGmeZziesBWWvv4+8UlQk0TpIjRrhH+ZLDUsmYv/p4Kv3nvLhaNhv9WERJPXXGJE9yN6l
 HFHPx8W7YOI600hP2qwOCyH/fEp4fvrUxU+QoaPSbvHh4QS4adc+vaku18oKu91T19fGPKX3pJI
 kKX3+zX2vQFawpEDD9w==
X-Proofpoint-ORIG-GUID: 05mp9M7gvJ5PIVviIXvo3bxQESBWuDLa
X-Authority-Analysis: v=2.4 cv=ItOL47/g c=1 sm=1 tr=0 ts=6ad22d50 cx=c_pps
 a=RH0axx9bUT6qb0hBLGrbHA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=y4UcunY2MAxhM4LwGdWI:22
 a=64Cc0HZtAAAA:8 a=YTpg2wbwm77mjifCQ_kA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 05mp9M7gvJ5PIVviIXvo3bxQESBWuDLa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-16_01,2026-10-14_01,2025-10-01_01
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

On 13/10/2026 17:29, Peter Maydell wrote:

> On Wed, 16 Sept 2026 at 11:50, Mark Cave-Ayland
> <mark.caveayland@nutanix.com> wrote:
>>
>> Adjust the parameters to i8259_stat_update_irq() to allow passing in pointers
>> to the irq_count and irq_level arrays, and then move the arrays into the
>> corresponding i8259 PIC and KVM PIC devices.
>>
>> Doing this allows the statistics capture logic in i8259_set_irq() that handles
>> incoming cascading interrupts to be removed.
>>
>> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> 
>> diff --git a/hw/i386/kvm/i8259.c b/hw/i386/kvm/i8259.c
>> index 421c9279cd..ca661afc02 100644
>> --- a/hw/i386/kvm/i8259.c
>> +++ b/hw/i386/kvm/i8259.c
>> @@ -30,6 +30,9 @@ struct KVMI8259PICState {
>>
>>       ISABus *isabus;
>>       I8259CommonState i8259[2];
>> +
>> +    int irq_level[ISA_NUM_IRQS];
>> +    uint64_t irq_count[ISA_NUM_IRQS];
>>   };
> 
> 
>> diff --git a/hw/intc/i8259.c b/hw/intc/i8259.c
>> index 3f10777036..ac43995ce4 100644
>> --- a/hw/intc/i8259.c
>> +++ b/hw/intc/i8259.c
>> @@ -49,14 +49,16 @@ struct I8259PICState {
>>       ISABus *isabus;
>>       IRQState i8259_primary_out_irq;
>>       I8259CommonState i8259[2];
>> +
>> +    int irq_level[ISA_NUM_IRQS];
>> +    uint64_t irq_count[ISA_NUM_IRQS];
>> +#ifdef DEBUG_IRQ_LATENCY
>> +    int64_t irq_time[ISA_NUM_IRQS];
>> +#endif
>>   };
> 
> Would it make sense for these two types to have a common base
> class (where the stats stuff could then live)? AIUI they're
> both intending to provide the same interface ("pair of i8259
> devices cascaded together in the way that x86 does it").
I had a go at this, however it didn't really make sense since the fields 
shared were minimal and the complexity of introducing another class into 
the hierarchy didn't seem like a win in this case.


ATB,

Mark.


