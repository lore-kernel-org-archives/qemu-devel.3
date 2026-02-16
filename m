Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62A6BEF5860
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 09:34:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vruz7-0001ZY-KT; Mon, 16 Feb 2026 04:33:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vruz6-0001Yy-3w
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 04:33:40 -0500
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vruz4-0001iY-8T
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 04:33:39 -0500
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61FKM9Pc3704504; Mon, 16 Feb 2026 01:33:36 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=/QY6e+lKpPvZX/lMcE37MoYeta+pG/XUlSAE45mOm
 UM=; b=GgfrXbxzBHoVKe7fPx3vKDukR/c7jYtmzawdmT1U7s2oiMUnV2o8m5Upv
 iHo1K7AuH9QnCqe/B2x0HhCkhmMMN3KeCGQbE/693Rg0vJtejmw99/u0JidZ7S37
 Wgp2s94T405KTQ1CJcS2eopqPKw6wQNXPa8PlI3Yhd66ucSy1AnCtZOLxlP63LU8
 1S7L/UXDp0iXRaeaOeA3SPlcvFuvwTwSw6RhXpmXovfj4FOI/f8k1jcYwwdHu/Sl
 0s02hfYHPFwLAjGpOqiAlwVjEtQK0N8r+0/+q3N12nIKtf9SfII7gZyUG6oelGDy
 GxP8GvDvYzUocaqxbkPm8Ly+EGpeg==
Received: from sa9pr02cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11023141.outbound.protection.outlook.com
 [40.93.196.141])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4caqf8u2rt-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 16 Feb 2026 01:33:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nvuwujRGdnVisyDBn/asEgYe0NGSbkQMCa3+wvApASOZ0v5vcYb/hcJmXoAQa3ypw1fjSh8Lud/JaMBUGrtnOmbcMVlluFZwE/i1s21ZJIov5bbT82aKvUjliLhXEzzCuLsMz6+iphsFexmHzAQstu0fyogQtYqYv5F6R5N7QW5pOnKNYcu8KkWwIvOnQh0rqIlS7mBMJZ7yTP6gWj5BwhRjT3DVysRp2pYVwuZYUpjT2VUqvcMNjPpSeZlmr5RFcCJADGTjllqZ2jR2PRdkjGYVpmEcihs5AZOi9X+D0hNKivt27G90BeD2RPaye4wDgx1ZlzL3kOTa9wuqcno4Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/QY6e+lKpPvZX/lMcE37MoYeta+pG/XUlSAE45mOmUM=;
 b=HucJ+0gdVIdf90YyRSC1FGFivb9U0qcQe3+jjwmBwhUnTPyWNb+/5QayVAGiXGzLXxU88DAGR3rqeAqlxmDLIMqLGZZsM7wuLnffm0aN2hblsWQYlbiE4/OrcAvmy349fU2mzJhyV0EKlF4s49vuhK0fjI85cEceZvY0OS85gCpZ6C5qSlyYrdJ3aCRi2mWRxCaZgn2i7rpUt4yJovAL58ehDQvIwZJYxWwTiMAAWuLkhh/xpvpSvfQ1ovWPI1lc11qK0LBdcKtfNyJnTh3nMU2BzGLzPW33/4fIT2EIfSazMk8kslRSLadmWIbvOyzKdVYDfOC8NtnCGGftbLSGIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/QY6e+lKpPvZX/lMcE37MoYeta+pG/XUlSAE45mOmUM=;
 b=gdheV3mLM44t3os3t/kDxDVJunj25THApoCXQ9RO+wgyAMkUm45DjrZzXeSUQmUhpdUcK8gz6QjrWEzgJVdtPU7Ggb9E3zF5qcPBMbYyhU/9Si0VgFz6QqpXPAEfwC8dTqAje+6F9ZPS9eAyQrvGHJhsaIrW2I+oviOFGvdS9dX+/AtDG/2etx9Dbz5nrpNvKu3qInvkS5JR4O55/ESa5ZDKNHUuAH+sCFf3D3gjxR/2CHo1b3lWvEcrD2dezU9pY+FSMOuFKXnq0MWYgzJsjEQpsm21w2JnU9qpiN9VkrGhYKCbJ6kvc4z29ypDnJeWbqVYOWGTWOblmIZEF8Fitg==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by CO6PR02MB7761.namprd02.prod.outlook.com (2603:10b6:303:ab::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.14; Mon, 16 Feb
 2026 09:33:34 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%7]) with mapi id 15.20.9611.012; Mon, 16 Feb 2026
 09:33:34 +0000
Message-ID: <1de4cd68-b623-440a-b88d-e91e5a739979@nutanix.com>
Date: Mon, 16 Feb 2026 09:33:31 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 34/43] audio: rework DEBUG_POLL
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>
References: <20260127182516.289834-1-marcandre.lureau@redhat.com>
 <20260127182516.289834-35-marcandre.lureau@redhat.com>
 <d094a131-9ef7-4c49-b037-76583b3b48e0@nutanix.com>
 <CAMxuvay8QBghas9-vmf_2mqL2aDj9byFOmK+G1G1562E5KLvKQ@mail.gmail.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <CAMxuvay8QBghas9-vmf_2mqL2aDj9byFOmK+G1G1562E5KLvKQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P302CA0043.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:317::16) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|CO6PR02MB7761:EE_
X-MS-Office365-Filtering-Correlation-Id: 04a4d495-83c5-4c0f-8f64-08de6d3e74ae
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cjVzaXR5bFNCVG1zczJYNXdKak1GZEZzcWc4WHVrMFcwMm5Fbjk5ZU1ZZW9R?=
 =?utf-8?B?U1IxSWQ5Nm1uZ3dzTk9MNjF1eFNPNm96T1hpMWtaQUZtUG9sZVJNc2wyeXVB?=
 =?utf-8?B?TjVsN2FyblUrWXhOcTFnbWt0YnpNR3FRTFRHMnpsQUYya04yTUlzZ21iZmc3?=
 =?utf-8?B?SEpWa3hWcGIvOG5HdVJZbU5MOXhld01JMU4wc0Zhc3pqN0NtQnZ0Q0pkSUFq?=
 =?utf-8?B?ZklYZ0JMR012bUdUZ0JtT1BKR2ZaeEo5SWVtZjRiRG1vS3RFQU8vbk1ROURO?=
 =?utf-8?B?eUNaRXUwOVZqcjNkWUo2Q2hDQlhtTGN1clowdXJEWGNKSG5lN25YWnI5em1u?=
 =?utf-8?B?d3BTK0FEZzE5RS9tUkpsZFRZQlRFQmF4Q0ZOM3ArdmxpZmxDUGk3akNvdmVr?=
 =?utf-8?B?dUc1aUFxQ2RRTm5wcCtVM0lKM2YwQ2xNV3hPTG1EWDN1YnVxbkVlSW1tekZF?=
 =?utf-8?B?d0ZaeElQQWVUbjVGL05XMXF2RDdEYllEWnJDTE9oeXp2UU1HVlh4R3NjOENF?=
 =?utf-8?B?Mk5IOTQwWi9RUVdDVXNYc1V0OVc1dGZUcjNOYWFleHBCdGxSTTR5MDY0dEwv?=
 =?utf-8?B?bVBHZGZ3UW1CZVFRNXRGNHdTcVZDSTdGby9zTWhWU2pPNTJxdDRvdTNGbEIw?=
 =?utf-8?B?THpCQW1LMVYrSmlMT2pYSnlhQUtGcm55bU5EUER5M0V6am9NaXhKUHcvUzEw?=
 =?utf-8?B?NkU2TVYxRVVMSkxaMVZicEFKYzdUYlZDQk1pS2VqT3BJSTdqaG0wSkxpMjl5?=
 =?utf-8?B?bFBzSkhDTkVjb0R6WTFCbkFvM0xqL1lEMWd5N1JKa0dWZUJCVm1jL2luNCt5?=
 =?utf-8?B?ZWhPd0xnM3hWMUVpMGlkMStjZHNHcUVIS251N2FWRG5Ub0tGSFgzbFR3L3J5?=
 =?utf-8?B?Yy9ZbVdtNXRheGtMc2xjS1pqektMV3IwV1E1MVpNQ1NGZkFTZFMyUDZtYmQv?=
 =?utf-8?B?Q290VU1NMmdCaW1wNVc2QTVrd1U0UFVqM1Q5TkRFSjFELzVsT251SEN3Qmhp?=
 =?utf-8?B?UDEyQ3BBQUdSRUEyZmV2bW1ray9UTlBlQ3BrTXU5UVdaVEdCYjdaaWtTYUdn?=
 =?utf-8?B?alJOZjJwa0ZpamtLL3I5elhOakl1Y2JlamJhSkZJOExHUllMVjFhMUZXaVRq?=
 =?utf-8?B?NHdaWkdNR2xqZjk3b2NGMnNadkN1dHFReFBFVDRuSk1BNE5SQ1RmSWJSQkJq?=
 =?utf-8?B?TW9NbWtzbXFiRnVlMmtoc2ttWG9YKy9YMWljNVNFSElsSXhWNVdqa2NSN3Bh?=
 =?utf-8?B?N2cwanRrLzRPcklWQWlQeHlFUEQxQW5wc0lrT3hKYWFQNkZkYUZBd01KR1Z4?=
 =?utf-8?B?MVZ0YWhUTGs1SG84YkNQQUxkcEQwejZodlc0eUZsZVNzYzhyZDA3VnFXTml2?=
 =?utf-8?B?TUxCWjdoYWw3K3NHbFlCZUY1OURyMDhsSUovNDI0amFTRDBVSGdzS1JEWWg3?=
 =?utf-8?B?c1Z1WjJHamZLL2RWV291L1FnazBwT0tJb0c4T1U4OUs5Q2t4RmNuelpGZkFx?=
 =?utf-8?B?OFVJdFpyMVdEenF4REpGd1pPbDdmR0l1N3pUelVWVmNmRHJSOHAwcFJRN0F0?=
 =?utf-8?B?Y1diUWd5RWVJY1FMaDVKQWZMZWpRaDZ5dmtGTVJZVHZqSng2ZzVxWGk2ZWZS?=
 =?utf-8?B?SDdMNGwyRGpILzNEWlMrbW5qNWxWRGp3U0pLOUhxU2FVRHZPMndoSjhjQ1Ny?=
 =?utf-8?B?MWtHWmJaNUg4cXhzQmdrVnQ4TDBKamFzNks1RFRka3dDeFpVMXdXSVNRWEhS?=
 =?utf-8?B?dGNxM0RVdUFoYzdwV29nVGJFL0p5VXhCZnduRWdERlVTSkgxa1pZWFoyR3pz?=
 =?utf-8?B?OHFnbzMzdHd1bUV5YmxPKzRPL3k0MHBnWGNoeTRzSWY2SXJBS3l2WlNhc09Q?=
 =?utf-8?B?b0NIY0FNb0tyQWE5OUV0cm9kY2hOVFpQMngvK1o4SDVGbTNhbXBWZFFGcW91?=
 =?utf-8?B?L0ExckxNRkswcE5xMm1PbHdnNWRRZGtZSUNTbHo0ZWliaWQvZmN5MDZlMmlm?=
 =?utf-8?B?UGJ1bklsajNXYUorUXRLRGhGNUpudjZnRjBxZFAxemprRkwwN2Y4bVlVcUM2?=
 =?utf-8?B?bzR2TW5nc1ZQaXg0QmE3ZWlSaUNEN285RWNzc2JsOVhEbFBTYmUvTndZdmUz?=
 =?utf-8?Q?bpeg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UWYxMmZvTjhKK3JjcE9MWjEycGp2SStsSURjemt5RWxxSHNLcmM3SXJzNVpT?=
 =?utf-8?B?cDZXdHZ0dis5ODRrOHZST09CUFRxbFI5RGwyaGJPMXp5SWZDd0I2bzEyTlV5?=
 =?utf-8?B?cnNlRVZSS0hEWFpBdXJHVVR3ZTErdi84MERnVHlGdldoc1lEY1NWQXQ0RmZr?=
 =?utf-8?B?Q0lIK3dLQ0pWYXJyZldjZmVsdENDRW9Ya1dIY1M1WnBOeDN1aG4yaDBmckNp?=
 =?utf-8?B?eU9vdERSVHVSOU5UM0V3Rng2WFhwdUVoTnY5cy9Vcnp5dWVnUmVROC8zK0gr?=
 =?utf-8?B?cWNJMzA2N25vU2JvVWRENDVLbGtXQzF5QW5ES0J0dDZXWUFxUDNhUmU5RG1t?=
 =?utf-8?B?MDA4MTRrVXdaSVhGUWtrWTRPUDZkTzAwSXAvN3owdEJPNlRTQ25sL1hxNTNV?=
 =?utf-8?B?NW1FcUxjNlZOVUx6Zk02SXkzSGRCc1B0ZGdKMnFrQUZyK2VRZmhKaUtnVkwz?=
 =?utf-8?B?S2dadmxvSzEyZThqVXhmdXM2Uno5R3kzdjNTanhPNGZ2Y0RkZUgzaHVPdzM4?=
 =?utf-8?B?dkJrczc3YjVJcmhlbTltQ1FPNVRPR0dwQ1g0MThBSitMYW5HOVZlWFZnYXRU?=
 =?utf-8?B?RmRqajdLTHBZWnJRdk53Sy9NTjNLNUxGeFdmVDNsR21qTTlQMFkxY09SQWpw?=
 =?utf-8?B?MVcxMHMveWhFUVRrcW93U2toV1hLbFdXdm8xNTFUMk1qV0pETVpDc003ZjFW?=
 =?utf-8?B?cXlNa2hjS0ZuOHhQd29Kd0dUMGtMcmVzMEJLQjVyc04xcHVTaG0vWWV4MGdB?=
 =?utf-8?B?a0xvZEltZkVvZmdrNVFmdXdSNTFMSXRBRm84cytKVndlUWhYTmwyZitzQVZw?=
 =?utf-8?B?UmZDdnFJK3VaNnd6VzVnWnhtRFBRdDRQL0xDKzdYK1hVOEp2aHZ2b2dGdDJD?=
 =?utf-8?B?MlBXYXFJY29MdDg4c0JRT0dJTUVKeTlRa3hvelBTNUgwYUpQa0RUZUE0a1Zk?=
 =?utf-8?B?SThwUGZQVzFER0dDakVOd3hyRmJCek0vZ05vV3FBNkd0alB6eDd2WU5QY0xG?=
 =?utf-8?B?bmFiZlo0bnRWWllTVW0xdzhJZ3huUjlMODNpVlBEL0hjVG9lbVZVOHlTR0Ro?=
 =?utf-8?B?c2t0WmNxakFJUitiOFQ4elFDMTFHS1ovY2tvZzBzL1cxR1dZMWEzMy94YmUy?=
 =?utf-8?B?RHVpZnJrVnhoT0J5RUVFQmFRSDNTTXZyVkNQdEMzcnRQRkZTTUZHcFJyQmZG?=
 =?utf-8?B?SEp3RjR5dVdXb1JhQWpzVXdmVWZtRlA3ejVrOFNyZ0RWV3BNUFc1VHNlUHI2?=
 =?utf-8?B?NWs4cDlEZ2Q3dm1FMFRHNENNN3o2Y053MlpCbVRxSXNQelF1VEFDMXovTUtv?=
 =?utf-8?B?aThSeGNLNDdSSU9EM0VTVjVvUUk3QlNoTjBSNU5yL3RITGVFQ3picWRiUnha?=
 =?utf-8?B?VndEQWt3eGJvbENuMzZVVWFmeUd4ekdFMlBPUUJDM3dDaUZDUGRpRzNqU2k0?=
 =?utf-8?B?eUZaRElWSXppclFvb0VxVk5qMkFkMEZNRGlja2hsazFoTi9xRXhwMnpSS3U4?=
 =?utf-8?B?WERMVnN0bW5xYS85cXFkRjNCeG9UNmlONTJ0NEZHc3RuOTU1VnJXSkRjSkg2?=
 =?utf-8?B?c2JWYzViZy9Temo0YnN2L3ozYUo0MDQ0V1dvbmhaL0R6ZjBEU0NHR3UvY2Fl?=
 =?utf-8?B?c2VEblFrYUpBeVFHRDVLZ0FEcFFtT3MzSFpjN3pSMnd2S0tMa0Q4MzNiUkt3?=
 =?utf-8?B?bUFPSDVkL1lINlZVQmZHWFZ6RGwrNUgrT0ZISWJpK1pheUoreW13NHNTN1hX?=
 =?utf-8?B?ZE1iQmJZOXpoTklEZ2s5eDVnQ2E4elRmN2RBVWxhTTI5NmlLWUxlUVQ1NHNV?=
 =?utf-8?B?NkQrNlEzbmFJbUl6aDRtaE0xVGR3SG5lV1RGZVpROW5TUHkxU0JZTjRXWWJD?=
 =?utf-8?B?VlpGb21valhYekl3THIxQUxuV2dUdk5FbVJDUk9UVlNlT3Avd092YUNzaVgr?=
 =?utf-8?B?NXJ1R1B3bGJGaUd2aEJ5NTBqOUdsREZvOUFyOFRBVDhoK0prVlVSMTJJWThi?=
 =?utf-8?B?RGhiVnFmSVUzcThDVnpvcENocWh6RWM0SUtvOHZVaEdlTTg1RkNGY1FCS0k0?=
 =?utf-8?B?b0tQZTZ1YUlzZUU0U29qeGlkT283YWVSQnBWMlhQSm9VWjNDOEFlZXZ6WlVr?=
 =?utf-8?B?OEVZT2M2RlYvNTNtZytZU25aWVQxTzAvZlJxazFBMk9Ia3l2TjBrQldXdW92?=
 =?utf-8?B?anVnbkE2NFJLYldIR3pOT0tSdVFFaXA0dGR6VjRHNVlVWEUvSzBIYkVNckpB?=
 =?utf-8?B?QW5iRFRhVDBBZ2paK2sxY24xeVk1V3JYYytrTGZQWUsraWFEWFZqbXVwelJy?=
 =?utf-8?B?eGEyY2lSMU54Q0VZL1Z5MGpyVkRDTEFiTXNZQjJBMnJaTEQ4b3pPUTVtMUJS?=
 =?utf-8?Q?aItMCGJviqHvXgrM=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04a4d495-83c5-4c0f-8f64-08de6d3e74ae
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2026 09:33:34.7129 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zH+YTT/JOowATpyVxrcmopZ/hzCkQNzfFWkw+Vie6iUY/tV0Alu0BAgc5V4w3xQsKj6Z9dJ0WXxfHID6gD3mQcYxnkP2PyhZ9Ra8lXgroIM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR02MB7761
X-Authority-Analysis: v=2.4 cv=caTfb3DM c=1 sm=1 tr=0 ts=6992e470 cx=c_pps
 a=EFv6KP2OcB+WNypt7onMaw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=64Cc0HZtAAAA:8 a=20KFwNOVAAAA:8 a=3bM2d45DSjLGe-xjgyMA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: z7sEAOyXUYAWa-m25RWoRQ2O_Nji3jZk
X-Proofpoint-GUID: z7sEAOyXUYAWa-m25RWoRQ2O_Nji3jZk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE2MDA3OSBTYWx0ZWRfX+R+Cd324hRhO
 +0FIYVk8edPfDsNEe2S9+Zr3gociN9M9doaFab77vXxBdofh/RC73fazRkt2QCWP+dzIylfs8sD
 AWQs15f5g3XjRiBH+0tBkd9VPfFWIRtdQGzXVdJJ37ls1gr0aRpnar4TXO9j5gbhbzJaEH8fE3I
 fu3JULx8bPeHvyRWT0F2QSpfw2y1qYOgJXImJeRFINw6x5gp9OST26vMJ9Aaw7YRLVxcvuCFXzx
 6fT06oeCa9k/TgvnOBlT+DDkGKGSXuk1v/z+4IZpcenffgl/6/hYk5i7of+I7Fg/MdS4hbztgGy
 ZaeJqiu44idcuCT15RvNTsZR+1Vl+wJLht2gVx5F0Y7LLuEcrboc+jlxdGpqdx7lKIlIbGeFEdJ
 qOXwA2XeP4ZCvfy6ehjCi6kRrwGBa3KMDlti5MqpORa1sAIK+tqh+NXpcV/WOrvv9GIuCW/Fkka
 iWlq05gT25PwSgfmIBw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-16_03,2026-02-16_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 14/02/2026 10:24, Marc-André Lureau wrote:

> Hi
> 
> On Fri, Feb 13, 2026 at 4:50 PM Mark Cave-Ayland
> <mark.caveayland@nutanix.com> wrote:
>>
>> On 27/01/2026 18:25, marcandre.lureau@redhat.com wrote:
>>
>>> From: Marc-André Lureau <marcandre.lureau@redhat.com>
>>>
>>> Use more correct GTimer, specific for each backend, with a trace event.
>>>
>>> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
>>> ---
>>>    audio/audio_int.h       |  1 +
>>>    audio/audio-mixeng-be.c | 25 +++++++++----------------
>>>    audio/trace-events      |  1 +
>>>    3 files changed, 11 insertions(+), 16 deletions(-)
>>>
>>> diff --git a/audio/audio_int.h b/audio/audio_int.h
>>> index dd5f2220d75..e0ed6af67ed 100644
>>> --- a/audio/audio_int.h
>>> +++ b/audio/audio_int.h
>>> @@ -224,6 +224,7 @@ struct AudioMixengBackend {
>>>        Audiodev *dev;
>>>
>>>        QEMUTimer *ts;
>>> +    GTimer *run_timer;
>>>        QLIST_HEAD (hw_in_listhead, HWVoiceIn) hw_head_in;
>>>        QLIST_HEAD (hw_out_listhead, HWVoiceOut) hw_head_out;
>>>        QLIST_HEAD (cap_listhead, CaptureVoiceOut) cap_head;
>>> diff --git a/audio/audio-mixeng-be.c b/audio/audio-mixeng-be.c
>>> index 343f6ec181e..1b2c1fafa87 100644
>>> --- a/audio/audio-mixeng-be.c
>>> +++ b/audio/audio-mixeng-be.c
>>> @@ -24,13 +24,13 @@
>>>    #include "system/replay.h"
>>>    #include "system/runstate.h"
>>>    #include "trace.h"
>>> +#include "trace/control.h"
>>>
>>>    #define AUDIO_CAP "audio"
>>>    #include "audio_int.h"
>>>
>>>    /* #define DEBUG_OUT */
>>>    /* #define DEBUG_CAPTURE */
>>> -/* #define DEBUG_POLL */
>>>
>>>    #define SW_NAME(sw) (sw)->name ? (sw)->name : "unknown"
>>>
>>> @@ -1269,22 +1269,12 @@ void audio_run(AudioMixengBackend *s, const char *msg)
>>>        audio_run_in(s);
>>>        audio_run_capture(s);
>>>
>>> -#ifdef DEBUG_POLL
>>> -    {
>>> -        static double prevtime;
>>> -        double currtime;
>>> -        struct timeval tv;
>>> -
>>> -        if (gettimeofday (&tv, NULL)) {
>>> -            perror ("audio_run: gettimeofday");
>>> -            return;
>>> -        }
>>> -
>>> -        currtime = tv.tv_sec + tv.tv_usec * 1e-6;
>>> -        dolog ("Elapsed since last %s: %f\n", msg, currtime - prevtime);
>>> -        prevtime = currtime;
>>> +    if (trace_event_get_state(TRACE_AUDIO_RUN_POLL)) {
>>> +        /* Convert seconds to microseconds for trace event */
>>> +        int64_t elapsed_us = g_timer_elapsed(s->run_timer, NULL) * 1000000;
>>
>> Not being familiar with g_timer_elapsed() I had a look at the glib docs,
>> and it seems that g_timer_elapsed() returns a gdouble as opposed to an
>> int64_t?
> 
> yes, as seconds. So it is multiplied by 1000000 to get back usec, as before

Sorry I was probably a little bit vague here: the part I was unsure 
about was what was happening with the conversion from gdouble to int64_t 
without an explicit cast? I was expecting the compiler to complain.

>>
>>> +        trace_audio_run_poll(msg, elapsed_us);
>>> +        g_timer_start(s->run_timer);
>>>        }
>>> -#endif
>>>    }
>>>
>>>    void audio_generic_run_buffer_in(HWVoiceIn *hw)
>>> @@ -1545,6 +1535,7 @@ static void audio_mixeng_backend_init(Object *obj)
>>>        QLIST_INIT(&s->hw_head_in);
>>>        QLIST_INIT(&s->cap_head);
>>>        s->ts = timer_new_ns(QEMU_CLOCK_VIRTUAL, audio_timer, s);
>>> +    s->run_timer = g_timer_new();
>>>
>>>        s->vmse = qemu_add_vm_change_state_handler(audio_vm_change_state_handler, s);
>>>        assert(s->vmse != NULL);
>>> @@ -1596,6 +1587,8 @@ static void audio_mixeng_backend_finalize(Object *obj)
>>>            s->ts = NULL;
>>>        }
>>>
>>> +    g_clear_pointer(&s->run_timer, g_timer_destroy);
>>> +
>>>        if (s->vmse) {
>>>            qemu_del_vm_change_state_handler(s->vmse);
>>>            s->vmse = NULL;
>>> diff --git a/audio/trace-events b/audio/trace-events
>>> index 4749c54fc04..d66a712e871 100644
>>> --- a/audio/trace-events
>>> +++ b/audio/trace-events
>>> @@ -61,6 +61,7 @@ audio_timer_delayed(int interval) "interval %d ms"
>>>
>>>    # audio-mixeng-be.c
>>>    audio_get_avail(const char *name, size_t live, uint32_t frontend_frames) "%s: get_avail live %zu frontend frames %u"
>>> +audio_run_poll(const char *msg, int64_t elapsed_us) "Elapsed since last %s: %" PRId64 " us"
>>>
>>>    # audio_template.h
>>>    audio_open_out(const char *name, int freq, int nchannels, int fmt) "open %s, freq %d, nchannels %d, fmt %d"


ATB,

Mark.


