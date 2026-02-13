Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE01AEDF16D
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Feb 2026 14:46:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vquR6-0007hd-35; Fri, 13 Feb 2026 09:46:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vquR3-0007hT-PT
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 09:46:22 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vquR0-0000iK-T4
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 09:46:21 -0500
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61D9Mvnj752444; Fri, 13 Feb 2026 06:46:14 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=1S8iaEs63hLmSwcGPy+VsFEo0ZQ0OHYqkLmp0dsBK
 wA=; b=a+ibsXUdsbN1gpOiMy+h0FVaWLwmo1A8zDNHrMQh9LRwqFKxeaCYY18qM
 +e+wUlkjhI2e9IuPqH3tzlfMmaDRiHWoNBzrpQqaO26ZHLKQNqd/kmLpdSoppYaq
 cxo32/F6mtvXIKUi0ORYVXJF8vl1RvuGDsactw4tX+DobXQt8Ub78dwUWW0L0WnW
 BsEcuPokFiDIg7TmZrwWYoiYj6M+r78tzODicVjo6r9tuLSkG7xUYLAYBf1vkoLh
 KBw5rypT1a7QwframJq/8aBHcDZ1c+fr/txLANqplIsXTtTRQOCcIhXIxI1cTdcL
 CHC6OvbZAqOUb6E4dk6naCtL0LNqw==
Received: from bl0pr03cu003.outbound.protection.outlook.com
 (mail-eastusazon11022076.outbound.protection.outlook.com [52.101.53.76])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4c8ctc984k-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 13 Feb 2026 06:46:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mbjDsnSlXdhdwFiCSIzac0T0YyEqDo+4y/aBm9CQaq0mvfeWOC1nQGNha++3N0wJHjxB0i6g+YSf7cy0F3heBN89+0daj3gw2bd3h7YUY9xdqSrz8Q0TIp4fboPkLVvykOaiOr9+A1S5QVTEh/zaZg5dvhW+4XoliJYp97v85dj7Ylbj1hqIY2CweQgVEzDTAdPfti8dhnGK9F7sPLWwuTWx5TsvTnu1KBIFQBasUUNUwhAyrhon0XUsVG8J9poAtxpx9Lc/SeheRhvyOPnny4e1TojPxbm7uUBkCnwF/f8pnDBRlNW4i1PLLQF26zi9iXv3twIOekW8VFUpt0ilUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1S8iaEs63hLmSwcGPy+VsFEo0ZQ0OHYqkLmp0dsBKwA=;
 b=kwNDcqScWtoAC5Y4yPMbW8qhkIDtfOsiJxLu1JiqL7RC4QnF/RiiT3o2OG9by0pFoi0vQGOtlWKcAmUxCgh60bpsMCYq4p7XuDto9DdY6yi7RtXUJbtXoclSEG7kdklvFgWWnH5w/qDbNwl6c9SyI9Rc8FVqKLNjv/U2H+DsVwJxPqs8LeqMR8VgfUd/gBHuW8s1yHtHHlYUQoVIxc93rtnLBV6f5Q9JFknM/sbN2eT9yw7KV73/uSbUg94mNSL8ev/eOmnLw3xJXphFSBxa9nPN4usftDV3Y4wincWbflhLUkyUIuB9K/C7433AWDsOw09mWSlhJPagawJGsSSuvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1S8iaEs63hLmSwcGPy+VsFEo0ZQ0OHYqkLmp0dsBKwA=;
 b=vK5aOsep5vGC0OuIY5en0sqcivYHQ46t7AuQo+myzBUZJEsfyP42hchJ3ZUADQLkre4bA0BA09O6t4+XZOLzJq6y0N700WJPfQ+vgw6lMaZmjm5K5MRKzddM1oIIrCagzi2VUi6FrCgjG/QCz3jUDTX9Blis9PxZ3gp5QwR+3Lln5VBIEL3E936oLES89fPWO4ivh0PLYsckSj9biNeYO+eMYRmvHg/Dujb+Mn1i5+Ru5ZpEEhdpujX8Fth1R8H2sJnGgz1S47rkxyeG0hxfgcyPfJFHq8zHq5Jr/0d9qS2TpuKXjSWw3iaCJR2Xah1lXNBouYDqTxKuCngEr6K9ew==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by CYXPR02MB10226.namprd02.prod.outlook.com (2603:10b6:930:da::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Fri, 13 Feb
 2026 14:46:07 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%7]) with mapi id 15.20.9611.012; Fri, 13 Feb 2026
 14:46:07 +0000
Message-ID: <bab9293b-b8a4-42b4-b2ca-46619cc7f37a@nutanix.com>
Date: Fri, 13 Feb 2026 14:46:04 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 23/43] audio/noaudio: remove unused AUDIO_CAP macro
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>
References: <20260127182516.289834-1-marcandre.lureau@redhat.com>
 <20260127182516.289834-24-marcandre.lureau@redhat.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <20260127182516.289834-24-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0313.namprd03.prod.outlook.com
 (2603:10b6:610:118::34) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|CYXPR02MB10226:EE_
X-MS-Office365-Filtering-Correlation-Id: ec66d3a9-f9b4-451f-e00a-08de6b0e9ef5
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?R0hKZnZROHJMN2VqZnlKTGZtWUhBRng5NTl0LzhPK2dtWHowNDZCQzVWQU45?=
 =?utf-8?B?RmUwTnZqdjdCSnF3b05OVFVvaHI4YzVGTS9VSUpHaXBYT3JqR1psTWF6TnMy?=
 =?utf-8?B?VHl5TmlXT3ZpZXFUOVJiS0RvMUdubWJpWkh1bGg0RnI5OWFzOURpUGpOc0tv?=
 =?utf-8?B?SkU4Qi9MVmdUbmZGdlpIcEhKN2R5YWx0YUhWTFpLMzJ4dGs4U3lJc0hKT1hl?=
 =?utf-8?B?NTROMUttUGVRM2xlTnBYU1lnZ0xXSWFBdmdlcytBdEZlWTI0aVpKdU9wc0F2?=
 =?utf-8?B?dWFSeUlpZjVuYndzV285Y0M1Q1lqcUtmTW1tK3ZPZll2QTI1Smt5T1E0b3Ax?=
 =?utf-8?B?SkdxODFzUjNjakVXbzA1M1kvclhnR2hVSW1DcnNBZEw4N3hIK2gwTWxHYTRn?=
 =?utf-8?B?S3VjYnU5OGhEV08vMFVkYUxIUGhONFp6VE5QZHQxTVZ1SjV1M25LZEhwQThl?=
 =?utf-8?B?RmVIaE5GMXZ2ODhtV1FNZ21vUHhrT3creTNjTWxNbm9CLzR3UzVac3ZKcjgz?=
 =?utf-8?B?Q3JxaGtSYVZ4THc3QkI3T1l5cWZTbTNMNU5EbkkrUlRoZFZ3RGNwOERUTG9Y?=
 =?utf-8?B?ZGtkUjBBRzVxWE5HdDNYM2VMbDM5Y0xmMnZIWTRXa0FCZ2YzYVMrOWRvem5x?=
 =?utf-8?B?VXliSHJaT2xhM2hmYUlUc28wSWhqcHNCNlZ3cU5CWlpzK2FuZ1ZYNG5LYWoy?=
 =?utf-8?B?bG9LSm1ZR2ZMQXdzS3lMRFlIcEtVdlFiNU9raG5NWEowNWpnQjhyQmRrWmZo?=
 =?utf-8?B?bkVTOWx2NlByQU5ldHl2T1hFREptSjJiMDlYbGU1NE02TmJIbStVU1JYMjV6?=
 =?utf-8?B?c3prelF3R1VkVS94Zng3UEhrcUp4OUZ6eklhS2l6dWsvL2E5ejF6c1A3ZUFU?=
 =?utf-8?B?MjRwZHcyVUtYOHBuUUg2YnRueVc4REx5emh6Y0VNb3BRbTdpQnBBdlhMckl6?=
 =?utf-8?B?b3JDUy8rMFF2TktncWxYOURBZ1Z5akUzenYvaWNPNGNXZnlFK3FHcUI0L1FR?=
 =?utf-8?B?RC9IdEdKV256MTAxM1NBVHorQmNlQjJKYTkxRFFqaExweGN2a0ZRbjNNVTdk?=
 =?utf-8?B?NDEwdlEzRmlMdUNlZDM3Z1B5NElaZ1pKSGh2ZlJNRzZNSG1EZkY3Y3hIZ0JZ?=
 =?utf-8?B?d3ladFdRM2dnaXk2azhVTG9pVzJVQkVZVCsvbktzMkt5cGJseG9tVjdxdHU2?=
 =?utf-8?B?WS9BUGU2WW9LR1JQWG5hbkU3NTh0cVp1N1QwMTJSdTRHRVI3cThweWt3YUR4?=
 =?utf-8?B?Z0xDcFhiVXN5dXpZazZ4dlpKYUM2a1E3MlMzS1ZyTHRPS3ljS2FQUWNUSWlo?=
 =?utf-8?B?VmhTNnhnS0Rudjd1ZHhxU1M3djBLaVJTOTNOeGl0MmlDTEZEWHBJU1JTOWZY?=
 =?utf-8?B?YnQ5d291Z2xmZVBiQWtQTkxpQzdLaHNmWXM1VHFCSTZsdWxHMUxKN2tNUk5q?=
 =?utf-8?B?anM1ckJrbC91SXB6SDVtVGZ3akg3Z254K3g0YTdybjlKSThLVDJTL0g2Uzh2?=
 =?utf-8?B?NGo4Mmk0NE10UnMrRWlVWGhjVDBBeGlPeUZBQi9pc0J5ZWxtVU5wUzRpK3Fi?=
 =?utf-8?B?RXdMN280WVdzVURGaEVySDR1ZDUrQjZVb0M4TzhGM2hJVmFzRkh4N2NUcFNI?=
 =?utf-8?B?V0FSNFRmY2M2SDBSTUkzd3lTQ1lNSzNQMjBHYjdwTVFKMWFtKzQ5cllFQk02?=
 =?utf-8?B?aFhsckM2YWVPMEdNdDZJaEFYc1IwbGlsRGgxMTZ2WGNGTEJXenV4QnhIVmV5?=
 =?utf-8?B?MlRmaWV2a01WTEp2M0JsSlFJKzBXV0lWME9KNTNmTXZGMlZXZWprV0RPMHBR?=
 =?utf-8?B?NE02eXlSR0paM1NaTHB5K3ExbCtxN0tkUDNDUThoZUhMdlhWUzd5R1owb3Vn?=
 =?utf-8?B?WHpYdXQ2UzltQ3ozamc2dksveTBvYzdIZFJxWHFwQ2EvenFKZlJ4RmxyOXlx?=
 =?utf-8?B?TC85cERqQXZqT2d5WEsvWmpGcDJlMFVIMTQ5NUcrQVZKb3U2MFpUc3NtRUFG?=
 =?utf-8?B?YndrY0ptRnkzTlE4cXV4aXVXaWpGZG5JL1VyL1RWYTVWWDNLa2dBODFlM05z?=
 =?utf-8?B?N1BWQzZrZDBWM080b3B5M0V2Y1R4YmJKSGc3aHdlSmE3ajhFekNOaG1ZcEp1?=
 =?utf-8?Q?m/eE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZFlxQ1dtbzg4c1lPWE1ub1ZTL205NnREdTRWYmVFam5rZ3FpTkNWVmE1NzR4?=
 =?utf-8?B?ZmZSTDhDcDNTMkpKVG4vVjNJLy9mUUNmaGplUCtmN0lEcFJEcXBsWjd2KzFV?=
 =?utf-8?B?TkQxMFdmWG9SaWlrSDg2NWFUSlVpVFNwcUl1ckVaQkxoVVhEYUxCdXpGN2Vl?=
 =?utf-8?B?aGdOVHBGcURTZmdkUi9COVJydW4zYVRmUms0am1tcS9yTVlpMUUxT1JUMnJn?=
 =?utf-8?B?aWVoYVhBb1FUaDZ2OFBSRXFwUW5ueE94dWNaZzJ3ak1MZ3lwZ25ScU9tK1Bq?=
 =?utf-8?B?T1JzQmVBZmYyMXVVdEo4ZFNLWmU3WmxGdFFyTzIyMDRBYlBTc3Y4VGFDak1a?=
 =?utf-8?B?TUNUL3FxZ1BiU0w0bFJtalJUMmlqSk93dlBrRVpza1l3M1czWHJjelIxRW9W?=
 =?utf-8?B?cSs2bnB4WENzRHJDVDd4ODFkYTFwL2hNRkFLVGh6R1BBZS93OWZBMEthL3Nx?=
 =?utf-8?B?WlpZeEhNZ2JHOUdteDJzaVpZd1BIUExrY1ZyaUtmM3hjYmpXc2RreUljeWI3?=
 =?utf-8?B?YlZsVVJEQ1czazRtYTFJZU1yWC9OdS85cEF3K2ZGcHkrR2liang5akl6ZzNX?=
 =?utf-8?B?NndCbU9tVnV5b1hLUEtpS0dySWRQSFF5K2xhUWs1QUgwYVNFdmJaRmpQTGh0?=
 =?utf-8?B?WjlsNW5nOTVsaDJaU1VJZEx5TDh4aFY3aGs4OHhJMy9QTFdJQTk5RkpqV3dK?=
 =?utf-8?B?aU5VVVFwQnMvaS9MVzJHVzJwK0sxSWdaN1VIRnB6cFBhdk1neEFKZkpHa3Ur?=
 =?utf-8?B?ZXhtYUU1UnNhY1lGNXBiYTFLZmwyRlRGOEZ3KzZYUGNzZnpGZi85TXA3ZVRx?=
 =?utf-8?B?YU9ZR1hoVTFWbk5nKy9lbWhLTVVWNUYvbGFtM3dYOHBDbzc0Tm00YXVmUGE0?=
 =?utf-8?B?c1JxaWxOZzZWZnp6b0RQU3AvempaK0k3c1I5MWpkUGJNSVdrL1czeE9DU3dB?=
 =?utf-8?B?ajByRFhRN1lkZUtaK0dDN2JwRy8xWXVzSmsxSDB3UGhsbjBsVTNBQnkrN05p?=
 =?utf-8?B?Tkt6dTRyb2ViVktKYmRkZXFHbXMwZ2ptMkdDNi8rRkljMTZMSEFVaEVVSEdV?=
 =?utf-8?B?ZkcrbXNhK3hValZiYTdGYWZmZkM0cmFHaDhkTkkzSGhIM1h5ZmFKRW1VdFBL?=
 =?utf-8?B?ZEZtUGFxcE9VcERmWkZYcWEyZG1TV1BFSGhJVjlUT0pHUHByOXpGUXBNZ1cx?=
 =?utf-8?B?QlZFaGxhNjlZWUpJOWhHN2FGY0F3WjVNL3dqdXo4QlBEbVcyNlNVLzk0WHdk?=
 =?utf-8?B?Q1JMZzV1a2llbVpvREh3N2RqOFBHVHN0QnQyUDBuNjI0MFo0OTQ0d1JTZDQw?=
 =?utf-8?B?R1VJSktQUkdoWXBZNm9pQ3pzQ0NDT3NRMXBJZnk2N1BmaHJTdFFsQmhVMmhY?=
 =?utf-8?B?U2hkdTh2MWtNL0orcmp5aHpvQlZCUmcrS3I5R3F1TDdqOTh1OG1NdE50MDNS?=
 =?utf-8?B?c2loRVlOV2ROaDZNNUpXUW1JVVNyMkZEdFFWOUV2V2M0TmlnWUMyTHNHQW5S?=
 =?utf-8?B?VGpaaGM2VTRva09mSlRmOHBxMzdXM0ZQYnFZNlhwdy9UV2FsQm4zZG9LL2Nr?=
 =?utf-8?B?WTVwMis1Ti9NNU4zempvUUlUUW9RTFUwd2F5d0FFRHVTeFUvZ0s4aXIwd3hh?=
 =?utf-8?B?SjFJNEhFRHpZb01tL05yai9IcDRQbFRHV1NmQ1VodVk1SHVZdDBYQXFudmwx?=
 =?utf-8?B?Zms3T3Y1QnAvVUxCbU5ncTJ2aTMwUFQ4eU43S1hrQkQvOUlodXJMamVHSmtM?=
 =?utf-8?B?V0dmV0hUT29rd2tUeGpZcFRneWVNcnh4bENjVUtMdjUwN1Vua3pIeWhoVnZ5?=
 =?utf-8?B?RGR3dHNhYlZyUDZzdEVzaDV3dGM5VzNpaE92Q3lWYU9RQUFMUlVQMzIxUlhN?=
 =?utf-8?B?dGdQdjEvSXlERjRrbm50MVRYWnVJa0ZHbURJeUJmYzMvWHNMem1xamRxY1ZU?=
 =?utf-8?B?MHBrQlpCcG5BSnRZOEhHRmo1aEk3OXQ3QUk3M0U2UTBZSCtjbktYQnVTbzFs?=
 =?utf-8?B?RkRzcCtHSUplQnMyWDViWXlBTW93d2wxeWEvMWlYSDJJNXRIY1pOR0UvS29U?=
 =?utf-8?B?WGttOWh1U294RUk1eVgxbXBuaDJhUGd3djFMUWtPRmN3a0dGM1VUSWQ5cVZX?=
 =?utf-8?B?R2xyN21vOXZWTCtURWl4cUNRbDcycEM3dE9qRlIwOWEwZDFCZEQwVFpBV0dS?=
 =?utf-8?B?T01BeGlWUVUzN0NoRjFCQ0gwWXZwUjU3S2hnSW1yd3hqN2JqY3o1YVlES2hj?=
 =?utf-8?B?eU93dHBGWnNSbjFxYjRsakhrU0VHNDRkZk55amVqdStjZVNCR2VXY05VNVF3?=
 =?utf-8?B?TExLTFBUemo5RWFnZ0JjeDNsazdWbERKS2pWVEtZSFEvMmVDa0FMVkZUNXVw?=
 =?utf-8?Q?f62yFn36+NbK313Y=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec66d3a9-f9b4-451f-e00a-08de6b0e9ef5
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2026 14:46:07.4934 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yGDYfxEtGteIFtl02qkOV/gvR5HpHh1qaZf7NIbFFTqXatC9sOWagQQ5Bh2sy5Y736jFCSTtF7Sjw/0vTO1bjjYaR8fEwJTp+WPY3KTaNgo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR02MB10226
X-Authority-Analysis: v=2.4 cv=Yd+wJgRf c=1 sm=1 tr=0 ts=698f3935 cx=c_pps
 a=6LX95kau/ZuHJnH6QujO1g==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=20KFwNOVAAAA:8 a=64Cc0HZtAAAA:8 a=PeSHXsjrkkEgoSEnkh8A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 5nTuXvgXy8YS4OfNVlj4GPUL5sZblNcW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEzMDExNCBTYWx0ZWRfXxIu8iIjoX3Bq
 4xjlb9kF/zL+tvxsDpwr6F3b06cxx6p754Dmqw33qkDxRtA65fuUL+HKgubo9hTfU7DvJrNC53U
 lKva/31IjMTKt02Y0QlKvtSbYiQSmLMyMh6TAEe5WSyLFwNLb8nrykvxIZbNZRPMFxYXxNzioN2
 q4h/Fq1QOdOSEKfC4MTFzE13+iG6paARI9UDpYfnEwo1s8ikrhPIAov7K69Ql54nGjWoqRyatcn
 6v9WYh3Sy4oNfY8TPnMBx8NS8g4yhkL+CcHpyuH/8XeVFWIIdVfmcjW4lakTCftDcaAq6KipnDe
 9RPtOH5UrXj1UYeuk4AqcM0Ls1TGNchlPGjjv8NCJZlH4530w8ppdbiRRuH3bZ67O+/cTx5I/Xo
 OBCCVq2i7F1tOBK5zxlQcziq/5vSQq1IKyPsy9QED2Jnr/k4Ar3wcGkY8nmaAvnMwGZqrk+29Y0
 fa+7fSUjeoNw9/WYgnw==
X-Proofpoint-GUID: 5nTuXvgXy8YS4OfNVlj4GPUL5sZblNcW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-13_03,2026-02-12_03,2025-10-01_01
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

On 27/01/2026 18:24, marcandre.lureau@redhat.com wrote:

> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   audio/noaudio.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/audio/noaudio.c b/audio/noaudio.c
> index 2f4c3a77457..20208c71069 100644
> --- a/audio/noaudio.c
> +++ b/audio/noaudio.c
> @@ -27,7 +27,6 @@
>   #include "qemu/audio.h"
>   #include "qom/object.h"
>   
> -#define AUDIO_CAP "noaudio"
>   #include "audio_int.h"
>   
>   #define TYPE_AUDIO_NONE "audio-none"

Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>


ATB,

Mark.


