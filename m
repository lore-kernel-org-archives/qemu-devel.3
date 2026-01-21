Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 122BBC44503
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Jan 2026 11:14:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viWA5-0003Tk-Kb; Wed, 21 Jan 2026 06:14:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1viWA4-0003SO-Iy
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 06:14:08 -0500
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1viWA2-00037q-Ll
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 06:14:08 -0500
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 60L9QlpJ987630; Wed, 21 Jan 2026 03:14:04 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=proofpoint20171006; bh=DKIsa2VK+xZ7c6M
 YMnN2KPrKDM4QXppGTczITzoQ1XI=; b=PummlQ51PNrmUvixlHp3zJnEGFh4fej
 yN0UyoehtXT9otyQ++NMOf54HNdaO+NV/jHNQUMo56DTfw6jnMumFVKv0fkrtxnS
 fSk+9kdcc3aS5W7KvjnBGr4JLd3AsKcyy+G7W/+LLJER3qIxwpVLxtfOOoNz+zeo
 +DcCwB8GwrjOe3Mq6NyR3LYfKcuBoKBzDRsdhyiBACDtc8qbivXVv/OLOQUJKVPt
 +AebbVMK1TMI/yyjJB5Z7Gj2oiiVPu/c5XqF5xCaDSDqRI1dcYi7gRnFf1JWau18
 sshAQZAFVaEXdtQKydOk83HAKL9rptAo+RAlQk24Y/oyRV5MDZYVP+g==
Received: from mw6pr02cu001.outbound.protection.outlook.com
 (mail-westus2azon11022101.outbound.protection.outlook.com [52.101.48.101])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4btc9ban1x-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 21 Jan 2026 03:14:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h16KgHM3FNtPdu1NacVxEhf9SO6DzY9HZx/49OvvHlvdtC6C6q3afbcrGlCj7R6i0GdFfSIBQ4bek3nEdYNQXvKLVOZUkO6GOfZmGX/9KaMDP5zSAUetouhJuAlmva1eA0Dm33iHXB/2fV04LDxdYA9dHGxOvGnRrEMkjVe/lxuDbio5T3lS3kj9sLoX5ScXOkOSWkXCMQuXZQJiXPr8EyE9uxPqWVEf9etNCdCZWmxcN7e8njdAACACjV1Ct0L4NQv7/FebUUzl8R+rGTrN0rl0oVIQn8FhnyQy8uccbThkyiCyj0CurgsfGFuRPurbD9Kzh3v2Vj/AjKBCs55kfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DKIsa2VK+xZ7c6MYMnN2KPrKDM4QXppGTczITzoQ1XI=;
 b=dM/4JQCZNUue2Hmkj/mMN83WTYtC2zW63lwLEpwVq2BufRRtKVNN58MQ4J2dUXjLgDGKZvtdiDJeBY0rdZ8EHw3qig9CWARo9Mj5I8w9tVHRaSrL9Guzy7WJxW019V6o5meUnVTlN1ZgBECP3m/xdIg9ojlV16tAML2nlm2qrKD1o5SwpAupQaZSGn+RSudKXYNxteonMHkKKxziFgcYf1eUB/BiTrj33WEChFJw20iSmRx+ZDDabrPemCSa9gjO3Oa6d1NwuyIvEdE5xdueFPcDwGFmqIzEX/uo6y+BKMlTj43CpklKg9cUV6zVn9VeMi76YYC2YS6/G9N0WMa93w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DKIsa2VK+xZ7c6MYMnN2KPrKDM4QXppGTczITzoQ1XI=;
 b=ZdIEdjyQIphRXUSZPcCPGcUO0bZFZuAhD6BgdZlnbhf87ROazyyS2CYb7eeST8JXm2CV4dWu5y3zDsYv7+wqqw7PNr1K7HYu2sPFHNyTtnB97Ae/adgCncNY2ejesEtWjZgzqbtp+xg/5FQWWyjD9JB6qxa/jxuFeg7MBC2cL/UUZxKExJoPfuQ01mXr0YW+/dYlj5zTTidftPDaIhqbHEOTgZjOrv+kt89LLi3V70c70JW/1vVII0oySBqX6XBnd5rRC6izJnFoR+kiQ3y+7ELl3ZOdWN7wB5ivhyJbmyevzF9J+2N2xgothvmfvUlySZVoqQs6Q4xK8t+dDL/3nA==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by CO1PR02MB8571.namprd02.prod.outlook.com (2603:10b6:303:15b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 11:14:01 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::dbc1:9766:c58d:4887]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::dbc1:9766:c58d:4887%6]) with mapi id 15.20.9542.008; Wed, 21 Jan 2026
 11:14:01 +0000
Date: Wed, 21 Jan 2026 11:13:57 +0000
From: John Levon <john.levon@nutanix.com>
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Cc: clg@redhat.com, thanos.makatos@nutanix.com, qemu-devel@nongnu.org
Subject: Re: [PATCH 1/2] vfio-user: fix VFIO_PROXY_USE_MULTI constant value
Message-ID: <aXC09XEXhjpHnA4W@lent>
References: <20260121110055.2333711-1-mark.caveayland@nutanix.com>
 <20260121110055.2333711-2-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260121110055.2333711-2-mark.caveayland@nutanix.com>
X-Url: http://www.movementarian.org/
X-ClientProxiedBy: LO2P265CA0056.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:60::20) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|CO1PR02MB8571:EE_
X-MS-Office365-Filtering-Correlation-Id: be26b848-2f2e-4c64-99ca-08de58de2ddd
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4aT5DUA963YANgtirvi/gdCuvcMxKl+cHugw0xG3IejKACD4VgC5Z5lQJMD3?=
 =?us-ascii?Q?/byJu7cJSKmvB95RIv0e/u+f5TSoyuUqOIc8FuM053UBwSJESP5wTT7YPxCf?=
 =?us-ascii?Q?NQtdHLfq+j9uVD5w55240x+Mk+qgSq+WppGi86u0U7bxlVfhzZT2sPVh+NoT?=
 =?us-ascii?Q?ZxxJrpk/6aI1C+/ePlEjWWiUmPR0j8UK18/aYxqzmyhE6ggZlEZlKSBoMYLG?=
 =?us-ascii?Q?0NO9cUpSmSMfRf3flIFe4R+vdyaLTEXRmD49p5Tv04ptKg4QDY2O5ADXlbKz?=
 =?us-ascii?Q?yykCYBuktHjDjESj1W5rHEwq00j81Yz8jfJaMOcSoM2/hxQsZotvaOHLIOMi?=
 =?us-ascii?Q?54xWO90MtcvQE+AcW/Eu1YKqjduqSQLzyRKEQBSbVS7IOGyVmeLLDVFOd4fw?=
 =?us-ascii?Q?VQzV4XFKx1yDyQI35n3sxxccHNe6As2kvKV6CNkKg5LZac0ov9XpEwVt4hct?=
 =?us-ascii?Q?PxPSY51SlBAzDgbAkQuZg99Gz5MsUfsPMRcGvmb4OPqhJTKPbFaEewsLZpXA?=
 =?us-ascii?Q?2EbrY8/IEKa3Ot0DO5tVwDrjiLuWy77OYShl+mbDWwHyObzkjSObGetJkaWg?=
 =?us-ascii?Q?+UCZi2LDM5QNF0hf6+gah9sjYfb53gS2UQfwrcEPHJXmj6uXqdwzNK6Fsp4I?=
 =?us-ascii?Q?O0WfNnccNy4KLFqfOCZznjK5CDfz/3arNVXCw0UFjc6+vnLX9QYBR2do0+Hi?=
 =?us-ascii?Q?DDsl2SlrtLuotDI3MktfWRUzJ1t3aUiiRtdw4VmUT80xe8L7cOmlc0c4ja6m?=
 =?us-ascii?Q?tq5tUFXa2xq6/KHnw5I/1iF52BpguVoz5l7rM8OA9cFT5ctZXTsATO/RAiyE?=
 =?us-ascii?Q?4ihVA6neiVRb+jN32BRN5qpXBMVsdCAwtzGiyfeD45a1X6/NTrD2/1O+GA6c?=
 =?us-ascii?Q?Yltvsn9X/d1V3+KGsRQ0bfx0hM0ipg8CxHhcKDVuKRmg32Jj0jRw/gSdvMvt?=
 =?us-ascii?Q?CvUVb2lKRbsQih2HZLqBcsKvc+X6pRKggGXu6Gt/GzWJ/Vc73nhL1Xog1rOO?=
 =?us-ascii?Q?hImxZ5y5BYbjliaqhO+GXUWbls60gAGAPxeDFQAwLbefR+ph0CzIFlp45H/s?=
 =?us-ascii?Q?9Oz+otMsV8/V6NWw62IpxM+C88dAHD+WU9O0cEUf4g5xteyP1rfd5e9Vvx5z?=
 =?us-ascii?Q?AINlchl8U2xj+lx9/4U28livQpIDtqovrUFc+Uw7rwvKxYZLx+HXumE3IF5M?=
 =?us-ascii?Q?KUKoZUyO5wSfoJDB+7cDpyF5BmK9n1dWP68F4Px12xQ9eDzziNu2CgZNVtrt?=
 =?us-ascii?Q?GO74uzhPlSecV95oOC+ZGXmLq9lH8WqgePSIEwwOKOWXeA2ao/R+nVFE71iS?=
 =?us-ascii?Q?5iYJ63RPHE3KcPtekkJVJm8u84bDXPP0PzG+cKU0IXnBJEUVBzW5+uQFLhwG?=
 =?us-ascii?Q?w4JLIxRX5d0B3dHjMOZc4vP8aXfMfKSr7OXfnp7AQfogsOrrzLT4LO0ZNu6y?=
 =?us-ascii?Q?9ZZAQ6NkJJwxvmaAhlgcPxsCGlOs/NGm2qUpK5pPlfsjfbn2WVlSYnhmln8m?=
 =?us-ascii?Q?bXrL/gFN5afPYOeQF9Ma7B6SzduK6tncpl+qUta5ag8tGjwBxzgqBUMwM41U?=
 =?us-ascii?Q?vNCDcGoLtUXJmjUh1YI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QkqaiRyrtmjZUo+WEoT8ydy6ZfniNoX6pJ3oqp5mWsxs27bwgJD6I7iFqH4H?=
 =?us-ascii?Q?lav/HwDEgANyrqfXaBGaCoKfDAMKgzBNEgp2X862JQB2N0W/vr+VP+e6sd1y?=
 =?us-ascii?Q?NzcUwCnbHbXU+kR23ebGSYWPpbcSOqVe4XPSEDEqMfiSYhEy9AmxmrCV5wi4?=
 =?us-ascii?Q?zm4qDqbxhC79GaTax50W4dam3jMwbRWvg2dPBelvud0pEtkqlGsdJV0Lgf96?=
 =?us-ascii?Q?ky0MiltcX5IrQ2sRdpp+3tolMP4W2WobQdEg6WgFCb1ePaNEC8nXFtFBzbgi?=
 =?us-ascii?Q?xEmp6UqfnPlIBOuX5HT8H8RNvsgMJIncvlxAEplRRCifh/Lces5/7B4Ke+Fg?=
 =?us-ascii?Q?sKTlzrMSvLS2IdvqWYpqSLqJB7jvQmxnKmO0fBx7PepbiGY5mlsARdSCJTCe?=
 =?us-ascii?Q?1SGU7COFWV4SApp/OIo1E6AsvlZZfr0X9S1gqquT1ZpazLxGGuDpkpEul/0J?=
 =?us-ascii?Q?tdNXv245f8Tmg0EaYPZPCSVluN7SUme3gbvmQ+ylLUOfM4C//xrtSPaMI5YV?=
 =?us-ascii?Q?1HNzJLAHd6PhMa6C7fFKNX4V69l35haaEnzW4d1Uz8RmCsjKNhdktwGFD+OR?=
 =?us-ascii?Q?YdbFzzrVfEV9qqq8n2fbXhXAPo0sRDtmRv8Ln+esryV3ewpBTWA0Rs9rScxF?=
 =?us-ascii?Q?s1gLVqUWx2tmxVb0xcbn6Abhx9rOtpW6AqKq1Hlhj59st6b9fUcSkgLSjOwO?=
 =?us-ascii?Q?Vh2bsM5AAE34nPNQTDdy4FzrM2gSRb8iXZbS+nZJzTIbFvTGlBH4PO7mrVjK?=
 =?us-ascii?Q?+Wv8Px4jQQZ++QlM1kPWC3JnePssQ6Vrm5qcY8ZnD5KGIRvbGdW6UwoDBRfN?=
 =?us-ascii?Q?ceE/S5j1uJ8kCPX25DHlfsvvnYNl+ZDbhNk1eNUEQStcflPzk5dyPFD013RB?=
 =?us-ascii?Q?im/8Hqvly17L3Kzw7pMPs0Ywf0iZSAb3wvaann+Sv51AhnHw7Zyx2B0vzo+w?=
 =?us-ascii?Q?8iHxsCRsneFprnrZOR2N4YC1gEItuFUsK/mXciF+ihi3+nkmiBU1UPap3vNn?=
 =?us-ascii?Q?xYo3RuZvqfGXNP5s2HNXVxjCwWXENn9p7Yf6WDgTkmhfnpa7SCyPaePP5MRO?=
 =?us-ascii?Q?7V242AR9SC1XLdKbQFgZHxWQM01G7j0qwv++0qa5ADTiY3Pt2+Dp8a2+8Xhz?=
 =?us-ascii?Q?FEB6HDFqMMZ+j2HsVMOhYH5IEWaiMasNwuZ+yhVjTgf11ol+dkGf1SEUkaMn?=
 =?us-ascii?Q?t9lvWt2Kx0wxRKePgxLFtTEGzXpRF8ev7mxW22RYcP/4jbeP9IVr8AGW1ddk?=
 =?us-ascii?Q?QkVuV///aIoJrCgtTScIlucdlFDW/YBE1KiCR+WB4rp093sqBPuR/VhWYlxZ?=
 =?us-ascii?Q?mo7QCUEoU1recwRbNPxwCPMQSiPfc9G8RgfuMWxCuy28wmiRuhO4rqpvf8c/?=
 =?us-ascii?Q?dgjJsFFryCmGStYhc6qCcnDlwJ5pMyQ7Dc3iJ/YNRJkCjL1c7z7SgBlqEgYj?=
 =?us-ascii?Q?0iegL5RrAQWj1gRsy0Q/rZgObwzOnGM+gymcZtvkLQ2e8YsSyv9PKOmgwuPg?=
 =?us-ascii?Q?xbIN3gH2w2j/zUOxAr6zR1XnHPLX+Eeh+nbKTZM9da9FFunT/+XWC73kE6t3?=
 =?us-ascii?Q?4WKwginP/CSIb+dAV3X9IA4ooptUZJmT5MxenHt7gHP/dWHg53R3+wYIAH8x?=
 =?us-ascii?Q?HoVdkOpC3EZZHqIGuy5TSq/uYTlSU+20+tEuOlhvfMETesI9bii+ak202TOf?=
 =?us-ascii?Q?r/QKgs9gTx99MJWFllqtUoUD1qGesjH2lFv/JELopJAz24RXZ/IDaxcNq6k6?=
 =?us-ascii?Q?fN9eOOzFrQ=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be26b848-2f2e-4c64-99ca-08de58de2ddd
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 11:14:01.5986 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ttWLvLqkMTxGz3Wj9J2pBwxd8Zy60oB1//ZSUefNVoXe34vuHsUWoYyOcZsLQwNGQ3hwbYy3np5LK1WHuYaSQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR02MB8571
X-Authority-Analysis: v=2.4 cv=ZZQQ98VA c=1 sm=1 tr=0 ts=6970b4fb cx=c_pps
 a=RIagabVaACGLwgNc4eEF4A==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=vUbySO9Y5rIA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=64Cc0HZtAAAA:8 a=FaM6rFO3zl8dvMblsCkA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: 0_GDM-bimHCPcIT1V-mYwBG_t5LK2CKP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIxMDA5NCBTYWx0ZWRfX6gtZEwG6llqG
 SnePaSJDe6yy1X28f2AZQ0bhHNMb7RLx5a8J4xeaus5w73X+OgVrWjN8Hfr3baEILvIQKP/24t6
 oZO3HvNGT3vk9Ll8yTXzEpamtatb+1Svki4MIJESYVcb2z0/Pz0nZkaFv/NTDlS/iph4k1+RO1N
 pFapU6IZH4Idu5888JKWpfZc40RMA9bWJMQMQwGI9ztIniAp8E/NFUYlAqOXLKli0KEqgh0xJSY
 b6OkmtB6FNRr/+okWdZLAiQRqaG9N8gQGLbJDa8sP2/EtQVxUfFbNxlc1hZ/AMp7LN/uIdHIdFm
 lq/I/2wWGG8fzU5l6YVCgcgGWE1otzWLwrX6zEGndd6aTNShcvYBX8VSyLWd9anJxcBZt2ptpTO
 XhaeIxE3EMwAQU6mx0XWVgCxZzRxBcvLEjXfSZsyZjq/eF8wLGuO5RLsHfHng1ivcp7UIX5WJ/P
 hzUzxNalp6fLoXv6Uaw==
X-Proofpoint-GUID: 0_GDM-bimHCPcIT1V-mYwBG_t5LK2CKP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-21_01,2026-01-20_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=john.levon@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.087,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On Wed, Jan 21, 2026 at 10:59:45AM +0000, Mark Cave-Ayland wrote:

> The constant value should represent the next bit in the VFIOProxy flags which
> is 0x10 and not 0x16.
> 
> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> ---
>  hw/vfio-user/proxy.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/vfio-user/proxy.h b/hw/vfio-user/proxy.h
> index 61e64a0020..b09fd886f1 100644
> --- a/hw/vfio-user/proxy.h
> +++ b/hw/vfio-user/proxy.h
> @@ -94,7 +94,7 @@ typedef struct VFIOUserProxy {
>  #define VFIO_PROXY_CLIENT        0x1
>  #define VFIO_PROXY_FORCE_QUEUED  0x4
>  #define VFIO_PROXY_NO_POST       0x8
> -#define VFIO_PROXY_USE_MULTI     0x16
> +#define VFIO_PROXY_USE_MULTI     0x10
>  
>  /* coalescing high and low water marks for VFIOProxy num_outgoing */
>  #define VFIO_USER_OUT_HIGH       1024

Reviewed-by: John Levon <john.levon@nutanix.com>

thanks
john

