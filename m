Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA85BE7BD83
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 10:23:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vrvkc-0004Dm-6E; Mon, 16 Feb 2026 05:22:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vrvka-0004DD-36
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 05:22:44 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vrvkX-0005mz-77
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 05:22:43 -0500
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61FMGvke041856; Mon, 16 Feb 2026 02:22:36 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=8KkmfLKyox2oVIKG/gSaeS9rPenCIzvwt9pGsBagw
 so=; b=gtt1iL3oMecxnvqrM5bb6t9hF3I1jgaCFj75YVJT455tnKWavgWQMpeDT
 IdwKOp/aJfzOkyMBGuGC8GRzC1us+4wlUQbtWY5vjKhTbCCC6lkzVxqgHMCevDvh
 TJ+otvEgKKQGx0yJcleola59TwoO/00T1WbVoCU47YeUWeYad4A1gvqx1tFp7E2v
 JBluGlvM2OhfCpIWs+FQEztANcS2z6aedWWFZOQYAOArYBmu7/FEiBdQMX1H0vlH
 36l3M2lcI6Lc3AOrHyzD3G6jZklpcpkDD2Ra7E4gaZWPCPmUbg9sUyNXRZeUJepP
 i/EaIdkZuCZn7w6iVBXAgZhLnWFqw==
Received: from mw6pr02cu001.outbound.protection.outlook.com
 (mail-westus2azon11022082.outbound.protection.outlook.com [52.101.48.82])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4cap8wk86v-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 16 Feb 2026 02:22:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BIlWy5dA0HZr6i3oPqCqN3bYhJmsA/wRuQfgVpCKE7xP4Pc2nE8SPNxmHpz0VDA5fblkgIoYxlsxTHpJPdZAY1DmuojNgPlEWB9+tjdQ8wjZIt8g7h6HKfdiYj+guChRkTaq5r6LkL6wpt3Iq5xbzyZMzd9HlEQEQB2h1iL/MxM9jBtWidlO1h7V834sBTBbhJP+DoWfR7vizRbVK+zzFvCJnzmEw0yMQ7hKp0i6+2Gxwac4pR+AW6d45bvo8kjXyywD+lRtxRH98hiCiKB9m0pnQvaLQmItkwsExPNM1NnJpP7fnCNO9zi3GVaYQPC1av6zK0EOZA+qaw3wcpR+Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8KkmfLKyox2oVIKG/gSaeS9rPenCIzvwt9pGsBagwso=;
 b=Pd6uXo75+BUpEir0JIKSTp8bJ569kYZyEmh18NULGVMRu2z2V3J3llFeiWY4uZs32Ut3PA+Y4MqomMPlWPxX1iv5XzlAGtBva7LkHBFkqjIx2eYEdZ46laWC09GCclyV+qxBkLv5sKw2Et+Z56gKhkGnj/NXo0s4Wl7+oHBUHH2PT2aj0zIU8dbnrqtgaItd2w+k42knBySSyFjc1vxqOwCMl6t9lFXvQxULp9ixvuVU3IVVUjedwSGItTPpfbzH+lDaTglq4eZYXS1jnNoBtKqgRwmAagdQVPdXUXG4bnDHOckz4Z6aHwKBIIfF1xnGtEkpj9NlDNz7LWDx3WRENw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8KkmfLKyox2oVIKG/gSaeS9rPenCIzvwt9pGsBagwso=;
 b=dzESw+2F0Wa7yZJtDbI/4H6hS1dulhff5ifhFMD9feGspP2JuHh+zyjKnqWQm48zgdAneQz4qiBPGuAnTyIJgqf4pehVpwOwfGsd1+kaHdGx3bRN9xC7RSPZGKylxHF4u/LcVOqxVz1TzHffKNLWgdGfrR4KjrBP3khlfN1+IiXPmsDsSvrWFfr5adEGzRkCInj+vdp/3CAPAPBkDvelPimJG3SQfNubEUVBo63/tXPi9JeakEzVcfh3AxmzproWe80rH+mk616BCayddsUJi9I9xegoJPTYjGTckOOMDrUCP5uq2+PZ/i51bOLAN6k1fvalIYFcO2gjFmNREaeJaQ==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by IA3PR02MB10352.namprd02.prod.outlook.com (2603:10b6:208:533::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.13; Mon, 16 Feb
 2026 10:22:35 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%7]) with mapi id 15.20.9611.012; Mon, 16 Feb 2026
 10:22:34 +0000
Message-ID: <fd3762ea-247c-44a8-89ee-1b70bbed80ab@nutanix.com>
Date: Mon, 16 Feb 2026 10:22:30 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 34/43] audio: rework DEBUG_POLL
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@gmail.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>
References: <20260127182516.289834-1-marcandre.lureau@redhat.com>
 <20260127182516.289834-35-marcandre.lureau@redhat.com>
 <d094a131-9ef7-4c49-b037-76583b3b48e0@nutanix.com>
 <CAMxuvay8QBghas9-vmf_2mqL2aDj9byFOmK+G1G1562E5KLvKQ@mail.gmail.com>
 <1de4cd68-b623-440a-b88d-e91e5a739979@nutanix.com>
 <CAJ+F1CKxHjovOPWu2GmyRL9n3F8cyE+Gcx1UBUqT6aJfsOrd5Q@mail.gmail.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <CAJ+F1CKxHjovOPWu2GmyRL9n3F8cyE+Gcx1UBUqT6aJfsOrd5Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P123CA0053.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1::17) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|IA3PR02MB10352:EE_
X-MS-Office365-Filtering-Correlation-Id: f21fad77-3730-4566-d122-08de6d454d0f
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eVdna1liSlFuMnZRcnpHR3hRMXRIVTkveHBtaS9mNWdKY091dmliL3A3RmVv?=
 =?utf-8?B?UlNzc01IdUxnVFZtcVlFVXdPQ05YV0NiVkN5OXRpck55VHJnZHlmRXRpa0pl?=
 =?utf-8?B?eUw2YW9DaFozWmpLYUNhdXVVbldSQzlTOHFHYU9HSCtzb1QyYVRKN3JiK2xy?=
 =?utf-8?B?d1phdXhOelVEanNIYm1Tb1ozc29Od1lpdk5oYzRuZ2pxV3hjOUVaRnZySmdY?=
 =?utf-8?B?eldZTGp4RytzVzFXNTlFSU5PdnIwLzlwT2ZOSGgyTEZMZVpOVXNRY3lDc2lu?=
 =?utf-8?B?Q21xQy9jcncwbnp5Y0p5M0hUNjdXdDhCSXcvUEY0S3A5NFVsVGt3KzV0RlNX?=
 =?utf-8?B?V0hWeEZpUEwyUmRiSGI5aUtzOUhMeVdXL1NjTjM0WW96R2ZqLzEvd1dwb01m?=
 =?utf-8?B?WVlHcHAwUzdzT2lLUTl6WGdJRU5EalU4Qi9pVW1xM2RSdjAwK1l6OTdGSmtP?=
 =?utf-8?B?eXVMY25FRDFKYTNwcTJKRTEzdmZrckZjRFZBRWhTVC9EcWNyUjFsMlJVRkQr?=
 =?utf-8?B?WXd5NWE4bVY1QXhVc2JrWkR2bFJhNWpXUTkrUWpOeTlvSk5uTC9PMnF4NE0r?=
 =?utf-8?B?UU80NWVNVXpNM01rWUM4RjVJVERrc0tob1NhVnFuWmlPdTlnUTJlT2hQbGQx?=
 =?utf-8?B?WDBKWFYyYmNMTmZ5ODUxeFY1anRpbFpMcTIrbHhtU2RGbUIwVW0yZWpVVGN0?=
 =?utf-8?B?WG8vZnpwaE1rYk42UVFnc2ZBZzhycjRici80bVNUQTk2bDFCQlozcTljQUFF?=
 =?utf-8?B?UytqUFg1L0xGU296S05nVnJNcGFmTnVZNGdHN0dJeWpDeUlxOU1oRWx0OWg1?=
 =?utf-8?B?T2E0SVpJVGNuaUlXQkhNK3JEaXRlWU10SE4ra2pjM1piYnYyREZ2RGR0OG1F?=
 =?utf-8?B?UklvUWNTaXR0b0k4V2xhV0svbWhiczRRQnlST0l2WGR0ZXFMRzU0d2JyWXZn?=
 =?utf-8?B?OHIrTWV4ZUIvYVh1Vk9KNStybWs0OUhiK2E5QWtSbStvc1pWd1EwMUtxNEJ0?=
 =?utf-8?B?VVlkYUgxMVhNbVIrN01KbzN3YkJqdDJqRmsvaHM1NlJxTVVVVHhaQW9FaWQ4?=
 =?utf-8?B?SkdYTytqc2w3OE9EUmg0VnRYbm80c01nS2NwNDZ0ZFVMM0ZWQ3pubWFOSEU2?=
 =?utf-8?B?RUQvWk9aT0dxeDFDYnEyUEQ0Nzd4bGp2cVpjWm5xaHJrQVNvNnpIWjdNYXA0?=
 =?utf-8?B?Z1UzZi9NM1BJVHVBMkxBQXhBNXZGVCtVVnh6ckN3MzJlY1pLcEhMNzAvOEVu?=
 =?utf-8?B?cm55SXlDakQvaXVwanpSTGF3NWd2OWxTVzJaODdRRUdIUUlZZnhNblFYbkdH?=
 =?utf-8?B?eVhJZm1tclpONlhZMURGcVVIKzhOS0V1OFl3VlpPZjVRWEdpVWN3ZStxbjdY?=
 =?utf-8?B?VWlHTm9qbXBuUDh4WjVWSEFQWU9HcmJ6ZXFHNGhEbm4waGdacGVkVkFaUS9h?=
 =?utf-8?B?WVBkK3QwZEtGYUs2enNuc0FRKytPMzRKMHNvcXdRRFVnNEd6aUcyVXpycDVJ?=
 =?utf-8?B?RFpsMmhJcXRWbjYvNURUcWtOVFdDcEF0UmZ3WHJXaGdjVFlYQ2NMQ08vTTJx?=
 =?utf-8?B?V3k1b2tUd3ZEQjdWM2JwYWhGU0FQVjRqd3JMRllkZTcwdXIveEZDdWpNUGFy?=
 =?utf-8?B?ZWxxTGpuclRUQmtJcyt2djJ0Qmc5emwrSUZoTGVpWkxTNWJxTjZ2ZVhaS0xy?=
 =?utf-8?B?YW01OFFRU0RwNjU4ZTdtVmZJSm9aL1l4Z1JYb004azFwMitFZkRvcnloeXVR?=
 =?utf-8?B?TVh5OVg0YzFMMVRLNm1oN3FXVjNmQVN4cXE4R1VCVUlvNS9HOTdWdmF6Zkpk?=
 =?utf-8?B?aHkxMXBLd2xPc25zZjRTV2ZWWWxlSUQ0YStWWE5CMDJtdTNYZ2t6OExUUDNo?=
 =?utf-8?B?Q3NCb3RZNTVHY2d4SHFNSklwcG1ZelU2QStVWk9ZRGZWMFJVV2cvbXBIa1RG?=
 =?utf-8?B?bHd5SWcvR3pnaEF0QUN5NDNFZWFITUpJODlndndBMFBvQzdXMDI1Q21aaG5z?=
 =?utf-8?B?UU9NQkYxR3Rvdis2ZU95bG1BaEFUOVVDbXRoY3U5cDV2ZFhPQ2tLT2Y2bDM0?=
 =?utf-8?B?cmM1S09ieFphY2R3eUhiT2JEcHU2TDc2MUplVy93RHdRbS9EejVKbzd6dkE3?=
 =?utf-8?Q?k3CM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TGxOMDBCZFo4cjlxbWxoaytkUm5GLzAzckhoclpudnlSSDBGc090cUVEdlJQ?=
 =?utf-8?B?Uy9OSkZ0L1NOOXI3L3ViQmR5amk1ZzZiMkZGZ25yNXlqWktSb0phdVJJZFRn?=
 =?utf-8?B?WG9jZVNqMWJsM3lTdG1majhBTEIwQXh3SmI5QUQyS0xSc2JEUEMxU0VLUlhY?=
 =?utf-8?B?djR6QUNPaSt1ZXZ3dDdCYjVValhrK0Z1YS8yL3g2ZWxrNTJxRzh0SFFTMVk2?=
 =?utf-8?B?TXpwTG5jZENpWXlTWXRoZ05VTjd6VHN0NDFmalgrODJPTThROTJiZmdjNUlF?=
 =?utf-8?B?akRTUmdZV3N5dHpocFpEODV3Yjg3WG83b3hNQitsL0ZiVm4xZGJVZmpSM2Zu?=
 =?utf-8?B?YmE2TSt3UHlET3VDSmVQYVR0ZlJPZXE0QUR3YzlMUFByZlBrQVFUWDNGczBm?=
 =?utf-8?B?Vkp5cXBDSTdLWmo4bG5udjJnNGJqRU1qcE1qQWtTcnJaTlg0Z0FaRmRCWjJJ?=
 =?utf-8?B?VEtPTjlub1hjN1h3MzVLMkNmem1GR0hRc1l4ZHBsTkwzbUE0WGYwVkVoZ3Vj?=
 =?utf-8?B?NU5Ia3ZkeEVTc1VvbU1qV1pJS1JmcVJXS1ZOWGhvOUNJT2tYUjdoZ2x1UHZw?=
 =?utf-8?B?SEpqaUZXUXRZb1V5dUw5R0x6dHI1ZkUzeVpYT09qOE1zVWRDTWdWN2haeU5H?=
 =?utf-8?B?RlRRbkR6UkR4RjNoV3psWlR6aTdJUm1xSk43d0pBM1VYbnJ0MC9WM25lMmpR?=
 =?utf-8?B?bGNoLzc3TU1mRHl2VEJmcDJveWJNRm9hL2NSeDYwMkZickVLckRrZ0UxTnB0?=
 =?utf-8?B?TXoyVlJhZk00UWxxbmFISWNnWUdxQXZ3UzF4aS8yaXVlU2tHOWNNN0c3bTk4?=
 =?utf-8?B?V1gxNDNxaDhFRkNUcTgrN3BPRjAzODZIN1hydnd6WkJleXBRbFlIRGRtd0hB?=
 =?utf-8?B?aXNSMU81c0ZXWE5xZENibCtkdCs4L0d3RG83dzhmRzRHL09PUThvTFhaWmJq?=
 =?utf-8?B?QVhOOTlsajJGTm9WdzBuTnFKSGVBbTljWmRjZk93UFdzUlg3bTlSSVJOdUlj?=
 =?utf-8?B?WFFmRkVxb2pzVnV5SmJuVklndFh4QUdyQjVSdERlc3k4UnY3cHhFT0dhaW9V?=
 =?utf-8?B?YnM1dS9WY1g3eElVOHlJWHp1TmZxbFVVNDVBNjA1QWtVUzR5OWJFVndJK2px?=
 =?utf-8?B?SjMxNzA5QVhSeUxENTJ4bVJnVXZnR1IvQ0pWRlQ3cFFqcHRhYlRLc29pcDF5?=
 =?utf-8?B?VmRLbENFZHo1Tkc3Tld3KzZSSTRuamdSUllqcEhFU3NqSHEwK0RpQ0dNWnNt?=
 =?utf-8?B?WHJJRC93bGFFc0g3ZnVMTzJUa0lQa2JsLzlHdkN6Njh6TEJTOFlaTkNKNk5j?=
 =?utf-8?B?Tmd5STc1QUMvSkliemI3UkdQUEZWUkx5VFh4WnhxOTFweGVhSHEwRXp4TndG?=
 =?utf-8?B?OEk0SDQ1TllFWWxjZzZyRURqSTllK1hjSXJEQ3lMNDI5ZzQ5Wlg4VkdFZUZx?=
 =?utf-8?B?eUZERWc1SHMzWjF0NDdpRGJpNlhBRjJaNWkzdVBzQ2JjNTBvYVR3Qnd6WDBD?=
 =?utf-8?B?KzB1aWZvYnVvWDdwaEl4bGNPenZkMCtQSm1LeVNZVXlWdGM2dkFvdTVJUVBn?=
 =?utf-8?B?bFAwQXhmbEVEL3B0ZVBLRU1YYzJvWXZWYk1XdkdyNDIzQkFnb2ExSUJnNFk0?=
 =?utf-8?B?disvSWRwRm94UGJsZjVtOGtkRGdQVGQ5TURNVEFiTFJFM0FEcG1uL3NxWS9N?=
 =?utf-8?B?aCttNVRHS0VpYmh2bXcwdkVvTmpwL2lBWmRDQnNIRk5SM1E4QkU1K1ZwV21m?=
 =?utf-8?B?NEduU1F5SWJpaDlCS1VkUEhUdVlvaWtnT2ZYVXMrUDZucEVZalR3VnNSYjJN?=
 =?utf-8?B?MS8vNDZEVDZJRmhzTlg1VXAwektnWFAzZ1VINXlDaEdQZUk5UDZvUGczRlY2?=
 =?utf-8?B?OGk0QVNtOEJFOVBiMnRTa1h1M1hNZWxsY0IrRGdlQldOdmVYNDBNYVdaVHY0?=
 =?utf-8?B?MHlIb2JVT0xCWCtrUUhiOU53VnRjZHE1Vml0YWRma2hkVlAyRkpKSVFXTEsv?=
 =?utf-8?B?THZlU2duK3E5Wlo3bDlRM09zUG9BenNsMkVUVlJBOStIamRTS0V2YlFkeDY3?=
 =?utf-8?B?QnNGdzNURzI2NE1PT210N0VpWW9CczFMZlZSejJxSjRYQ3lnb3UvSUVkaVVu?=
 =?utf-8?B?a0gwbi9zcWtvbG9tbmw5WE1yZmErNmpRdDY5elRNRHdheStiMzlVWDhqZy84?=
 =?utf-8?B?M0M5Vng3TElpVWNMdjRudlcxUUxiS1ZtVFVGbmd6WUhMNlV5eXgrVGNhVGtr?=
 =?utf-8?B?cVB1WnB0bW9wYlJYdlJiekdRdE53Rk8rdE5MOFJKcFY1MXJ0WW9oWnE1T0JZ?=
 =?utf-8?B?MlNjM1JxYUU3V1dwRHJHUkNldDQzQXp0ZTV5WXhCMi90VzNjRjN6TlVDZG1B?=
 =?utf-8?Q?3UM6llnpXSd7Ojy4=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f21fad77-3730-4566-d122-08de6d454d0f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2026 10:22:34.9020 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j5Z1PUFO+1u8oJ88odAlfyumzibXah7IZ0LvzV4kRJ52Hy2bdE3e77HErSweMTTibeojg5iayQgXL3kIwrCI35EHeHQP3TIOsuUUmT8+tPk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR02MB10352
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE2MDA4NyBTYWx0ZWRfXxKS0bxv+K1jR
 zvSaYKJCaTOkxyR5qDNqX0INyUSrNkR286FuktmbIB6ZoDnINYLwhIu+nRMKbPMHd1aZgtxVont
 FyZ+Sw4Y2oegP/ukh9nEDmpmaAIua0UPFegasuw/G505ix2NkaZIZ91IBx8kZa6c9DjcUv4BtxT
 9sNwEJPu/6xz75dKgkbVSytwxdp52ap+vl4ZZNka+Esjb02UpnzrwKced4aBxhwVxKZDjng9tw/
 YQsXna+bUXbuA4+5ghiNjj60WVV+woCvlwcOeknkci2sNu2TuJ6Adsmwf5o+2sYIjzdmDEeamSW
 RD6/8hoGW4pD6SzQk3sFvS57jX5ppvgcDmtStUeb9cnb60XqxCF1AIzUJkfOhs5prMR3iSpNRlQ
 MdlmLbd//LjTeAcSw/y4soPhdhjORXwCx4vDbzRdeZ+yTJB3c8mcwYBU7K4R1aBP++VjNDb0AKQ
 PUFNYETuKbMMpquzp0g==
X-Authority-Analysis: v=2.4 cv=OP0qHCaB c=1 sm=1 tr=0 ts=6992efec cx=c_pps
 a=n37zOek93uUOArlCZH3zig==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=64Cc0HZtAAAA:8 a=20KFwNOVAAAA:8 a=oDGEdQ-fgMcvttDe-sUA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 7VLeBly9kkzTu8s_lQsdDcKr-GP8Bqwm
X-Proofpoint-ORIG-GUID: 7VLeBly9kkzTu8s_lQsdDcKr-GP8Bqwm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-16_04,2026-02-16_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
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

On 16/02/2026 10:10, Marc-André Lureau wrote:

> Hi
> 
> On Mon, Feb 16, 2026 at 10:34 AM Mark Cave-Ayland
> <mark.caveayland@nutanix.com> wrote:
>>
>> On 14/02/2026 10:24, Marc-André Lureau wrote:
>>
>>> Hi
>>>
>>> On Fri, Feb 13, 2026 at 4:50 PM Mark Cave-Ayland
>>> <mark.caveayland@nutanix.com> wrote:
>>>>
>>>> On 27/01/2026 18:25, marcandre.lureau@redhat.com wrote:
>>>>
>>>>> From: Marc-André Lureau <marcandre.lureau@redhat.com>
>>>>>
>>>>> Use more correct GTimer, specific for each backend, with a trace event.
>>>>>
>>>>> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
>>>>> ---
>>>>>     audio/audio_int.h       |  1 +
>>>>>     audio/audio-mixeng-be.c | 25 +++++++++----------------
>>>>>     audio/trace-events      |  1 +
>>>>>     3 files changed, 11 insertions(+), 16 deletions(-)
>>>>>
>>>>> diff --git a/audio/audio_int.h b/audio/audio_int.h
>>>>> index dd5f2220d75..e0ed6af67ed 100644
>>>>> --- a/audio/audio_int.h
>>>>> +++ b/audio/audio_int.h
>>>>> @@ -224,6 +224,7 @@ struct AudioMixengBackend {
>>>>>         Audiodev *dev;
>>>>>
>>>>>         QEMUTimer *ts;
>>>>> +    GTimer *run_timer;
>>>>>         QLIST_HEAD (hw_in_listhead, HWVoiceIn) hw_head_in;
>>>>>         QLIST_HEAD (hw_out_listhead, HWVoiceOut) hw_head_out;
>>>>>         QLIST_HEAD (cap_listhead, CaptureVoiceOut) cap_head;
>>>>> diff --git a/audio/audio-mixeng-be.c b/audio/audio-mixeng-be.c
>>>>> index 343f6ec181e..1b2c1fafa87 100644
>>>>> --- a/audio/audio-mixeng-be.c
>>>>> +++ b/audio/audio-mixeng-be.c
>>>>> @@ -24,13 +24,13 @@
>>>>>     #include "system/replay.h"
>>>>>     #include "system/runstate.h"
>>>>>     #include "trace.h"
>>>>> +#include "trace/control.h"
>>>>>
>>>>>     #define AUDIO_CAP "audio"
>>>>>     #include "audio_int.h"
>>>>>
>>>>>     /* #define DEBUG_OUT */
>>>>>     /* #define DEBUG_CAPTURE */
>>>>> -/* #define DEBUG_POLL */
>>>>>
>>>>>     #define SW_NAME(sw) (sw)->name ? (sw)->name : "unknown"
>>>>>
>>>>> @@ -1269,22 +1269,12 @@ void audio_run(AudioMixengBackend *s, const char *msg)
>>>>>         audio_run_in(s);
>>>>>         audio_run_capture(s);
>>>>>
>>>>> -#ifdef DEBUG_POLL
>>>>> -    {
>>>>> -        static double prevtime;
>>>>> -        double currtime;
>>>>> -        struct timeval tv;
>>>>> -
>>>>> -        if (gettimeofday (&tv, NULL)) {
>>>>> -            perror ("audio_run: gettimeofday");
>>>>> -            return;
>>>>> -        }
>>>>> -
>>>>> -        currtime = tv.tv_sec + tv.tv_usec * 1e-6;
>>>>> -        dolog ("Elapsed since last %s: %f\n", msg, currtime - prevtime);
>>>>> -        prevtime = currtime;
>>>>> +    if (trace_event_get_state(TRACE_AUDIO_RUN_POLL)) {
>>>>> +        /* Convert seconds to microseconds for trace event */
>>>>> +        int64_t elapsed_us = g_timer_elapsed(s->run_timer, NULL) * 1000000;
>>>>
>>>> Not being familiar with g_timer_elapsed() I had a look at the glib docs,
>>>> and it seems that g_timer_elapsed() returns a gdouble as opposed to an
>>>> int64_t?
>>>
>>> yes, as seconds. So it is multiplied by 1000000 to get back usec, as before
>>
>> Sorry I was probably a little bit vague here: the part I was unsure
>> about was what was happening with the conversion from gdouble to int64_t
>> without an explicit cast? I was expecting the compiler to complain.
> 
> It doesnt complain, the multiply is done in double and the decimal
> part is dropped when assigning to int.
> 
> thanks

Fair enough. In that case:

Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>

>>>>
>>>>> +        trace_audio_run_poll(msg, elapsed_us);
>>>>> +        g_timer_start(s->run_timer);
>>>>>         }
>>>>> -#endif
>>>>>     }
>>>>>
>>>>>     void audio_generic_run_buffer_in(HWVoiceIn *hw)
>>>>> @@ -1545,6 +1535,7 @@ static void audio_mixeng_backend_init(Object *obj)
>>>>>         QLIST_INIT(&s->hw_head_in);
>>>>>         QLIST_INIT(&s->cap_head);
>>>>>         s->ts = timer_new_ns(QEMU_CLOCK_VIRTUAL, audio_timer, s);
>>>>> +    s->run_timer = g_timer_new();
>>>>>
>>>>>         s->vmse = qemu_add_vm_change_state_handler(audio_vm_change_state_handler, s);
>>>>>         assert(s->vmse != NULL);
>>>>> @@ -1596,6 +1587,8 @@ static void audio_mixeng_backend_finalize(Object *obj)
>>>>>             s->ts = NULL;
>>>>>         }
>>>>>
>>>>> +    g_clear_pointer(&s->run_timer, g_timer_destroy);
>>>>> +
>>>>>         if (s->vmse) {
>>>>>             qemu_del_vm_change_state_handler(s->vmse);
>>>>>             s->vmse = NULL;
>>>>> diff --git a/audio/trace-events b/audio/trace-events
>>>>> index 4749c54fc04..d66a712e871 100644
>>>>> --- a/audio/trace-events
>>>>> +++ b/audio/trace-events
>>>>> @@ -61,6 +61,7 @@ audio_timer_delayed(int interval) "interval %d ms"
>>>>>
>>>>>     # audio-mixeng-be.c
>>>>>     audio_get_avail(const char *name, size_t live, uint32_t frontend_frames) "%s: get_avail live %zu frontend frames %u"
>>>>> +audio_run_poll(const char *msg, int64_t elapsed_us) "Elapsed since last %s: %" PRId64 " us"
>>>>>
>>>>>     # audio_template.h
>>>>>     audio_open_out(const char *name, int freq, int nchannels, int fmt) "open %s, freq %d, nchannels %d, fmt %d"


ATB,

Mark.


