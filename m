Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0E1FEA3F2A
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 09:18:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpjsg-0004jA-7b; Tue, 10 Feb 2026 04:18:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vpjsa-0004ha-JR; Tue, 10 Feb 2026 04:17:59 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vpjsT-0005fc-Dv; Tue, 10 Feb 2026 04:17:54 -0500
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61A6wU6i2617322; Tue, 10 Feb 2026 01:17:08 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=2fmPb+3ihh6Jpek9s34znQMU7C0IdgxuPc4vT6Nrl
 7A=; b=xn0d8ZnzadcsV4Gtz7z7kEH6M1UjQXwgHVSs7+r2mPhYLlXTwrUghrc1x
 4cUq81We+9k2mZddb61C/mpTY8Y+xEeTnI8Ba9tMVQ/qoWMSaSnUaHHKvg3pbzjo
 aGc7Hw6X0vRpXcczq/8Nz75rekv9ol7A5z5RqxUkHwpTHmC6hlZdWGR1PvqWiffS
 jeJ52gjScJYar4iAxnSegn6l74VTu0LvoMP+npbzImjQ+8Vx1BZk+tspgmO/7aDj
 8l1cVas40y8LKcqKfClZAvJ2FL2qS1d0Bg28g0oeSvaRN4LKfgEPxjO3pkJnW+Nf
 AADrNh36DhevdSEX8esSwI0kwIhPA==
Received: from sn4pr0501cu005.outbound.protection.outlook.com
 (mail-southcentralusazon11021133.outbound.protection.outlook.com
 [40.93.194.133])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4c6268e1a2-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 10 Feb 2026 01:17:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lB2QTz2RV839CRL0erjseTSHefOaK1dG22OlZqcmbnI4DSAExAoIDm3QNvHnwpLvfKiaJkvk0ZPZwlXDBXUptN8iKBOp8VdggKqTxsPO9zNSkqbUuGzHp0B+zSE4kfBKiGHgHGDmLqy+NMx5ig7Mmnud2QmBU6WuVR//XbuOP9ZcIL15ISC6GGaZzSfqyto1Y7yewSSWWa2PtBtxppmZLzgIZC6tdoPhsnOaoLMinzxsYzrrWbX8gwQqFC66YSzy4G3mpEmY0QUsNt3cgQSWqTBDfq0S4uJ7cA/y8AV5jabb8Va/hI4Nm5ucqm7B6dybN++WjocbhpMA2GNVkZuX2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2fmPb+3ihh6Jpek9s34znQMU7C0IdgxuPc4vT6Nrl7A=;
 b=EGSOCI1jsrVMlfdyWVzp4ngp7KX0v+MVf7Rrn72vui6r9IQ9kmFhVr69DyocbxeF2c0hSS+ilw/z8ygOcC0JIuZYs9T9JKoTA3HNYs2MTk6vQxmb5QtSbJetIYXZ/zlFr7ElfiUrx5fu+bT7tx/cOLs5WOVgjYcXTv0F0dDJX8oIryN3gH97TxMAa5udyXSVoSFTuIVCvhhDcYc+jOLxkXF/V0jFKCm5mKu08wEmiCIya7IwWkpL3k85ziLH/0DJOWBeitNn4cYiOx/3d5c5B9rIOziK3+swUbuezRUv+FtVSbnC5FYWp2L8tdje4Qz3jYRDUTn3ywtHDDHQ3kCEkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2fmPb+3ihh6Jpek9s34znQMU7C0IdgxuPc4vT6Nrl7A=;
 b=cKKe8Y4xJ/z4mCmFX/wwjOjJ+JlWpPpudK3thzL/AeOepY0udqi0bP0sX47jzlsKxqy4YR9Gv63EaLip/xmr0WL0Kd3fpAEJhb/mDpPeFJo6QDrJ0SbkDZGhVfkQBUjZ7/hTat6LuHtXVn3SyTuUfi4qLbNl8veISvK0dsinI17OPtzg2niiDgN1tqjOlL43JtAX+4z+dkGMnyiYFetB2SNGyXDsti7hZFlYi9R8t0/5lXcBCp9pSiDDuqmUfyV3gtQzvbU6027BOuS0uVTceIiKaJa2t02QKBDurG8s0RJNGd/qLkArGwb8SMxzt24I8hORrifluO4sEVuoz3d17w==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by SJ0PR02MB8611.namprd02.prod.outlook.com (2603:10b6:a03:3f7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Tue, 10 Feb
 2026 09:17:05 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%7]) with mapi id 15.20.9587.017; Tue, 10 Feb 2026
 09:17:05 +0000
Message-ID: <252463cd-374d-4afe-b7b9-d5f32d5238b7@nutanix.com>
Date: Tue, 10 Feb 2026 09:16:56 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/20] hw/i3c: Add bus support
To: Jamin Lin <jamin_lin@aspeedtech.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 "nabihestefan@google.com" <nabihestefan@google.com>,
 Joe Komlodi <komlodi@google.com>, Patrick Venture <venture@google.com>,
 Titus Rwantare <titusr@google.com>
References: <20260209091629.823457-1-jamin_lin@aspeedtech.com>
 <20260209091629.823457-3-jamin_lin@aspeedtech.com>
 <d09e6a53-920c-4b27-be21-101c1d5d70ff@nutanix.com>
 <TYPPR06MB82069629434BF0062EFE85E4FC62A@TYPPR06MB8206.apcprd06.prod.outlook.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <TYPPR06MB82069629434BF0062EFE85E4FC62A@TYPPR06MB8206.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0207.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:318::20) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|SJ0PR02MB8611:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a3b6156-1a14-46ce-5e9a-08de68852823
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|921020|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VXQ2RmxWWjlrMFhlNUdnZUFya3pUMnErQ1hEOHFqaTdlazNLOVVnVnNmNnZp?=
 =?utf-8?B?VjB4N2VoWE1la1hmRE9DeCtKZXp0R0NTbkFFLzNzejZtdkJLOWg3WmRKTHRW?=
 =?utf-8?B?Z2V0QmhrUmhXdjBLdXdXeEt6VDhCNnIzS0c2OXZPOXFkVjgrTERJdWswNmdo?=
 =?utf-8?B?OU5RVk9RSmpacFRFNGRyMzJ5NDFUTGF4OUd4cSsxQ05Xa3hIZ0RPUGRxeXlG?=
 =?utf-8?B?Vjg0M2lpSndhZEVHQ3lUSWxNR2EweTFpRC92REhHdDRIdElpQVRxUzR4NDZH?=
 =?utf-8?B?ZkZ1OE1RSU5nRHR5dzBHallPeWlFMVZpK215Y1V5aFpYdlNkWHRCR3FRa1lO?=
 =?utf-8?B?b0NVdW5VdlFWbTZxU2NsaGxnUVpVcDN6Z0VFcVJIWk5SbDdIQm41Um5yUWJk?=
 =?utf-8?B?WVc5c0Z1MnI1dzJ2NkpRTmJ3WE4rcmgzMlFQSCtKUnNTYlo0YkRpWE9mZlBQ?=
 =?utf-8?B?VmZwTWppOU94WG1XZTdua1VPZWF5OTAxSlRzSXNHRzF3Mlk3ODZGMVk2M1VD?=
 =?utf-8?B?dExQTFNBNFB2YUcrSkFYak5uU3FxcUtDWFhrSVJmLzdTMW9WZjRGTTZYb0xZ?=
 =?utf-8?B?Yk1ua0JaSWRLeFJnQjJEbDFjcTRNdjBuSFN4L0Y5U1pCL3JITU4vY04wZTJW?=
 =?utf-8?B?Y200WXJWQWF5cjVaM0tZYzRrTEwrVUUzZ3VvRmtzUHhyU0g2OU1IWnM2bkI3?=
 =?utf-8?B?K2NCK21RdXBlTjlWbWVQMXRWSE1oWVdhU21xVjJnWTJaRU0vbUFxRGhrL25L?=
 =?utf-8?B?SUhqcDJCbUI5MzJoTVEwSkFiQVEyMjRxZTc2MzEycUNScEc5S2xMMWNKV21F?=
 =?utf-8?B?L3hGU0RmRDJmbzREeTNNMFoxUFFjcnZtU0FkSG1IU2Z0TDg1SnVuT0xybjh3?=
 =?utf-8?B?YUVUYXpFSnFGSUo4ckVuckNTbVFPeStHWHl2ZkQvWXVUaHNkN0RDWlNLb1d6?=
 =?utf-8?B?MnMzVXU2WGhKV3ZJakpydTBEZ3ZBQ2RRZFNlcjZaOTFsUlpKYTM4eVNXZG9I?=
 =?utf-8?B?MU1EWmtUeHR1aFkzTThQNFlOVDFobU5CS2FUa3lCYVBRVDhyZWxOZnV1Tm9Q?=
 =?utf-8?B?OURZZXQvbU9sL2w0TkhCTjhEMXZEL0FDUXlNMW0yK3R3eVBUc2N4SDlmOGJK?=
 =?utf-8?B?SUlWVHc4Njg5QWE2eGN3c3dTdWNaRk9rWkRsMEx6WEhSNTM5d0FSb3JyWjJ0?=
 =?utf-8?B?S0ppTHhBS1NJYktOcWJLTXdrYjlWNUoxdjVUR1MvRHp0YmpuV0FSbXF4dmhF?=
 =?utf-8?B?RjZaTkVxdmJRcms3RWJ3TldtTmRzOWtPa3FiSStJQndETWVZV3Z6aWVyY1or?=
 =?utf-8?B?cnZ0QXJQS3U2N1dNVzllRmRqcGFObTM5czFhTlFmd2c3NDVZcXZ6VHdFcTNy?=
 =?utf-8?B?R0FZWFBvM0J1RkNBTEFvMmVvOG92cmxQME1meHI1b09tT01PL3hndGtXT0xl?=
 =?utf-8?B?TnNtRzZyK3NaT0lnclpxWVF5OE03VHpWeUNOWEdQS3hsdEtuWVlaOXY3RjFL?=
 =?utf-8?B?dVZvQy9WUExHWjFGZGFxQWtWMHhpTkk2Qzdqajc0NEtCY0xpL0ZCcktjTEhM?=
 =?utf-8?B?UXhNWHlEWFZxVHZEeS9ONHlPSkFZRlN5ZzdRbDAxdWowNWdnVHVkRVNGT3BB?=
 =?utf-8?B?TzRlNm51QVhsTXVuQ3VBYXVuWG5KRUJSVjRkVklwMWRMSmgrTWNSR21ueS84?=
 =?utf-8?B?Qk9VYmM1Q2NtZlgwRUEzZTYrWnNaN0hHKzBiYWVWTDhMQmNnMW0zZGJkSkIv?=
 =?utf-8?B?WVdtMlFmRVVuOWtpcmVrTUdUZkNYYm9VOGc4QzM0cjlPRzdvOXhaaDcxZzlT?=
 =?utf-8?B?UC9kdk44aW9yOTNYZ25RRk1yeXZJVHE2V0Q2STJZNGdaY09XSGpRQzlULzNJ?=
 =?utf-8?B?a3NpeVA3eHhobjluVlZEUWwybTFwTHg5S0UvNkZ6UndVeWJhQ2dJTkFiVlhR?=
 =?utf-8?B?bk9yQUZscEo0YWp0b0RGbUFRazJWWnBGT3F6eDRzMUN1ZThTK3JJd01wUVg4?=
 =?utf-8?B?WkxFWklDZXZhckk1ME1pRUpNOUhxcE9wZ3cwNE10TkpnL2s4MzJoK1NESFU4?=
 =?utf-8?B?YUlISTlJMVlzWmFCcjM0NmZWYmZrSXh5UWp4dTV6OTcvQ3oyWGFsa09RODhV?=
 =?utf-8?Q?P8gM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(921020)(7053199007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZFJSRmx5RnJCbldMc2dyVGw4TkdSRXY1KzBsQmh6YmF4L2VjRDRHQkZJMGdN?=
 =?utf-8?B?MmJFamdnZHhYTDdnUHJBcVVrUEhnMlEwbWhQUDRIYzJSYjVpRktUQU1meXoy?=
 =?utf-8?B?MXhFVm5xSHFPVlkxNGJqYlV2VXVOYlFkWUIwcmhLbk5SUDgxTXNBdHhXZWNW?=
 =?utf-8?B?eTNuTmY0RXV6QVd2VmdrK0NNaEQvdStkdzFSVDFOaTQwVVlPTm5jY3FSZUJm?=
 =?utf-8?B?V0FJQkhuc0ZhUnFTTitEK2J1M3JtdTluWWVFdXE3OGVDMjRXR0JwYU5CWEVs?=
 =?utf-8?B?dDdLUXN6VE5GbEpNRWYzcG5KdmR5Z0ZZb1Q1QUVYWnBlUjVlQmRqVnorUlFk?=
 =?utf-8?B?anQ0Wmxpa0VuU3lOOURtNlBjdG5qUEpjUElwMnhUR0hKN3NCTUozYWg4dUx5?=
 =?utf-8?B?US9KT0cxMkxJblZDbitOQ2M5K0toejRjRDdvcmRUYmExcUhtTktBVjBnRElR?=
 =?utf-8?B?Wk1ZRXUrMXlKYU00dTNZUUF4Q3BlakhUb0doNkZsYTdzeFprZEY5R1ZNV3BZ?=
 =?utf-8?B?VklRTDMrcko1eGNZWEFBV25nTVd2SEZjRUExMXB4RmpQMmdCYzFDck11OGQx?=
 =?utf-8?B?NFpTczNCWmhiQmlPc1c0NGV4dlBmQjNDNm9RWERRS0JCZzRVRUlxN1V4ZytR?=
 =?utf-8?B?Q2RuNkU5MGs3WEcrRU1xbk9vclVyUjRlMG03SzV0aHJ3WXRGR1hHYTlPREQr?=
 =?utf-8?B?WUQwRGhoaVIycG1kenQzWjVBZ2N5Y0tRV0dlM0hzQUJ3R0sxYlZkaERrQ3RU?=
 =?utf-8?B?MkJ2SEFzRzRrZEtqVWUzS0ppTGFHdEhiTXJjb1IrTVNFVlpHRlRWQ2pLMXlL?=
 =?utf-8?B?cFlHUHNMc2lKcnZCOGVaVXBmRWFWY0VQU3l1a04xRWQwYWNVVEJGTGJmaUhN?=
 =?utf-8?B?TGF3bTRJamtsSFM3Q2lZSm1HUitsK1FkbHYvWXZQLytEdE5nNW5GNUhlVTkz?=
 =?utf-8?B?Z1hFUE4zdUFxNjAveWxBc0xqTEdTWkdnTDVXbmd5SkppVEZSQ3RkSHVVOVJC?=
 =?utf-8?B?djhTa0ZiVlpCZUxORGE3ODlPaUpkODIwalJFR3hYQUVoUExHM2lmSCtEbEJ1?=
 =?utf-8?B?SGVBTnI2MU5ROW5WRzlCcWRwZWNwMUZIcXFYdmh2SWhId3ErMEpHWkgwMkhQ?=
 =?utf-8?B?enhhak0weUdncm5GM0U5MUdjWnhjS2I3RGY1RkU0QUVqWFc3TEFRTVBaWDRr?=
 =?utf-8?B?VUlxVzh4MzY5UmNseWRqNTljcWRlTUcvMm5BeENoMXEwUzdHeXk5ZlE4ZCtk?=
 =?utf-8?B?VkxIS3hsU1lrb3BCZStQcE44UXh2RGs4cDM3c01oZ1VJL0JSeUlHS2ZscjUr?=
 =?utf-8?B?UEJDcXNoQm5UZ0MrZ0I4bFVoQ3hzMWp3cUt6U0tMdzRsVENiMnpDNnNDWDJL?=
 =?utf-8?B?bGpadUZaRVhmSGRrWmpxMjgvWnNFa0Rya2VMZENDSGlGVTdIOUp0SVlWWGlC?=
 =?utf-8?B?eU1LM3R1cHYySmdJQnQ5T0pBWTdpbHJLY3UwSHpvK052T3lMc3hkbHlDLzYv?=
 =?utf-8?B?MlZpUS9rbm5XaXVablE5aWRqZEpvRnUwSk4zbGRyUWhjTlJLcG1HUjRsYzUw?=
 =?utf-8?B?Mk45cEFBU3R0aWcxaUpDb1Qrb1NOZXJHU1FYTHFqUFdQOGtlNDBhL055Qnkv?=
 =?utf-8?B?T0JUQ2wvMkpaSEFpVWdVM3ZRZUFiVFFMMS9QN3Uwakl5U0c5UWFyRFFDMitY?=
 =?utf-8?B?ZjllVnFZdnZNa1UzQnZCOFh5UTUwYU9FZ2VDTmNWSlU0WG96ejBYM0hmNlND?=
 =?utf-8?B?NDhBeWVhREI4aTRlQ1h3dHBKUUpTLzFvdUY2RGljUUpBWFlHKzQ3MmV0ZUdr?=
 =?utf-8?B?Y1VmSlNUVllpWkdQelhHS3diK3UraWpnYTN1MEo0aHVSQnE0a0VmNlBiQ1E3?=
 =?utf-8?B?Ry9qR202dFlMTEkvbnArWWRVZFl2aTd4ZUhWR3NvcGRINmNkcm55bVA3NCtQ?=
 =?utf-8?B?aW03QmNqYmZmMTBCTzFPc1NRenZBUVZiSGg4WUk1VkVYNDEybDFSSjhVZkpv?=
 =?utf-8?B?dGg0UDRwSUl4Z05yYldrOUpjcENFN2FETitKMWVjek5jMlRvb0JCMmU0Mit0?=
 =?utf-8?B?S2hiWUZlZlh0T0hjcVNZSmQ2TFk5SU9MVlNDRWlhRTF4NDlTazA1VElpckk2?=
 =?utf-8?B?K01jWURjRVdxRkR2M2xmbCs2NmsrNzBNMlRKVys0elAxWnZqQ2cwM1lYUFFB?=
 =?utf-8?B?NWFWRDQ2RTZTcXd2eENkUCtlRURSNU1RUVpZUll3NStqaEhwQ0pJQ2hoVW45?=
 =?utf-8?B?UkhvN1ZYU0lIMzVJdlFlcDFSOTUyd2NuWGlDNEN3QXIzMHhGdm4xcU1jK2pa?=
 =?utf-8?B?aUhSNVFvMDNUbU1xS1RRTWtNV2tvYjRQZ1FneVZBVm5yem9BUmV1VDZ5RjQz?=
 =?utf-8?Q?qgRsBzIBqygjI7jQ=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a3b6156-1a14-46ce-5e9a-08de68852823
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 09:17:04.9145 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: di5b9Aj5S+YX7l0NN2jWZYmLOVLo11lWL+5u0jjeNP2p7fpMYpFewcQpCNlgkPr/JULwQWT5WJpP1IsDTb0y4/zE2nVW6oyFvE6Mw6MkJMg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB8611
X-Proofpoint-GUID: ar2A31nd7Yg4eNW2dwWGkxgyw2RxX_Qf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEwMDA3NyBTYWx0ZWRfX5VF4cLmC8w5w
 r4w8wZSJHtn7cYqn40WuGBZQjH2edYi8cra5cFBiV/+KJbpV1D/GxiGOGHpHMO2gEVTyK7s2In7
 axLLXBZ1lmNrkuvqZtu0CmalZn4UEh9RQaXL0jeKThLUEchWa5Vq9SAGIGftyJGX7ukF1ILSZOx
 9opAaJZzuSf01mCtVfOK0NPiOSgjwyr4/qUcrxwFw1fOMvmvbdA+g9IFin9/A0hDXu4aXZHfp6u
 g2SHLmutz4h0QCTR2egFHTyBLdj8TjED4JLgLNoHjK/ahW2aWfMU1234AUuavI+JsL91HZ9EMPg
 iIbIppDnFcNoG0OIZW8jV64cdK9upwxspXY53z+dyeYAC94de8SebJyCg/iS6oqfDJcIa6MMr34
 rsr98pSEWdH3Gc5jUt3bxqsD5xyFYN0cgNoQDHSnZil2IyjTYjuFV+Jl9L5snD8K6IvBDaRUgN6
 YN0tau6HlsNZsk8ocCA==
X-Proofpoint-ORIG-GUID: ar2A31nd7Yg4eNW2dwWGkxgyw2RxX_Qf
X-Authority-Analysis: v=2.4 cv=GNkF0+NK c=1 sm=1 tr=0 ts=698af793 cx=c_pps
 a=ypmqvA/i/yzbxHxvB85sdw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=UXIAUNObAAAA:8 a=1XWaLZrsAAAA:8 a=V2NxCb60AAAA:8 a=va9Kjpggz7EY9lYjEkgA:9
 a=QEXdDO2ut3YA:10 a=a1s67YnXd6TbAZZNj1wK:22 a=3L6qF29SlnrayQqPM2jZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-09_01,2026-02-09_04,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 10/02/2026 05:57, Jamin Lin wrote:

> Hi Mark
> 
>> Subject: Re: [PATCH v4 02/20] hw/i3c: Add bus support
>>
>> On 09/02/2026 09:16, Jamin Lin wrote:
>>
>>> Adds an I3C bus and a target class.
>>> The bus supports:
>>> - I3C data transmission and reception
>>> - CCCs (including ENTDAA)
>>> - IBIs
>>> - legacy I2C transactions
>>>
>>> General usage of the bus is similar to I2C. Users are expected to
>>> initialize a bus via i3c_init_bus, and use the bus returned from the
>>> init function to do transactions on the bus.
>>>
>>> In order to handle IBIs, the controller provides callbacks to handle
>>> receiving an IBI from a target, receiving (optional) additional IBI
>>> bytes from a target, and handling when a target is done with its IBI.
>>>
>>> Similarly, target creation is done via i3c_target_create_simple and
>>> users use the provided I3CTarget to handle transactions.
>>> The target has functions provided that it can use to invoke an IBI and
>>> send additional bytes.
>>>
>>> Along with the send, recv, and event callbacks that are expected of an
>>> I3C target, which are similar to I2C, there is a separate callback for
>>> CCC handling.
>>> This is to help encapsulate CCC handling and keep it separate from
>>> target-specific read/write functionality.
>>>
>>> To avoid repition for required CCCs among I3C targets, there is some
>>> class-level CCC handling added. The CCC is then passed to the target
>>> in case it needs to handle it in some way.
>>>
>>> Signed-off-by: Joe Komlodi <komlodi@google.com>
>>> Reviewed-by: Patrick Venture <venture@google.com>
>>> Reviewed-by: Titus Rwantare <titusr@google.com>
>>> Reviewed-by: Jamin Lin <jamin_lin@aspeedtech.com>
>>> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
>>> ---
>>>    include/hw/i3c/i3c.h | 277 ++++++++++++++++++
>>>    hw/i3c/core.c        | 652
>> +++++++++++++++++++++++++++++++++++++++++++
>>>    hw/i3c/meson.build   |   1 +
>>>    hw/i3c/trace-events  |  16 ++
>>>    4 files changed, 946 insertions(+)
>>>    create mode 100644 include/hw/i3c/i3c.h
>>>    create mode 100644 hw/i3c/core.c
>>>
>>> diff --git a/include/hw/i3c/i3c.h b/include/hw/i3c/i3c.h new file mode
>>> 100644 index 0000000000..455c2a4a4f
>>> --- /dev/null
>>> +++ b/include/hw/i3c/i3c.h
>>> @@ -0,0 +1,277 @@
>>> +/*
>>> + * QEMU I3C bus interface.
>>> + *
>>> + * Copyright 2025 Google LLC
>>> + *
>>> + * SPDX-License-Identifier: GPL-2.0-or-later  */
>>> +
>>> +#ifndef QEMU_INCLUDE_HW_I3C_I3C_H_
>>> +#define QEMU_INCLUDE_HW_I3C_I3C_H_
>>> +
>>> +#include "hw/core/qdev.h"
>>> +#include "qom/object.h"
>>> +#include "hw/i2c/i2c.h"
>>> +
>>> +#define TYPE_I3C_TARGET "i3c-target"
>>> +OBJECT_DECLARE_TYPE(I3CTarget, I3CTargetClass, I3C_TARGET)
>>> +
>>> +typedef enum I3CEvent {
>>> +    I3C_START_RECV,
>>> +    I3C_START_SEND,
>>> +    I3C_STOP,
>>> +    I3C_NACK,
>>> +} I3CEvent;
>>> +
>>> +typedef enum I3CCCC {
>>> +    /* Broadcast CCCs */
>>> +    I3C_CCC_ENEC      = 0x00,
>>> +    I3C_CCC_DISEC     = 0x01,
>>> +    I3C_CCC_ENTAS0    = 0x02,
>>> +    I3C_CCC_ENTAS1    = 0x03,
>>> +    I3C_CCC_ENTAS2    = 0x04,
>>> +    I3C_CCC_ENTAS3    = 0x05,
>>> +    I3C_CCC_RSTDAA    = 0x06,
>>> +    I3C_CCC_ENTDAA    = 0x07,
>>> +    I3C_CCC_DEFTGTS   = 0x08,
>>> +    I3C_CCC_SETMWL    = 0x09,
>>> +    I3C_CCC_SETMRL    = 0x0a,
>>> +    I3C_CCC_ENTTM     = 0x0b,
>>> +    I3C_CCC_SETBUSCON = 0x0c,
>>> +    I3C_CCC_ENDXFER   = 0x12,
>>> +    I3C_CCC_ENTHDR0   = 0x20,
>>> +    I3C_CCC_ENTHDR1   = 0x21,
>>> +    I3C_CCC_ENTHDR2   = 0x22,
>>> +    I3C_CCC_ENTHDR3   = 0x23,
>>> +    I3C_CCC_ENTHDR4   = 0x24,
>>> +    I3C_CCC_ENTHDR5   = 0x25,
>>> +    I3C_CCC_ENTHDR6   = 0x26,
>>> +    I3C_CCC_ENTHDR7   = 0x27,
>>> +    I3C_CCC_SETXTIME  = 0x28,
>>> +    I3C_CCC_SETAASA   = 0x29,
>>> +    I3C_CCC_RSTACT    = 0x2a,
>>> +    I3C_CCC_DEFGRPA   = 0x2b,
>>> +    I3C_CCC_RSTGRPA   = 0x2c,
>>> +    I3C_CCC_MLANE     = 0x2d,
>>> +    /* Direct CCCs */
>>> +    I3C_CCCD_ENEC       = 0x80,
>>> +    I3C_CCCD_DISEC      = 0x81,
>>> +    I3C_CCCD_ENTAS0     = 0x82,
>>> +    I3C_CCCD_ENTAS1     = 0x83,
>>> +    I3C_CCCD_ENTAS2     = 0x84,
>>> +    I3C_CCCD_ENTAS3     = 0x85,
>>> +    I3C_CCCD_SETDASA    = 0x87,
>>> +    I3C_CCCD_SETNEWDA   = 0x88,
>>> +    I3C_CCCD_SETMWL     = 0x89,
>>> +    I3C_CCCD_SETMRL     = 0x8a,
>>> +    I3C_CCCD_GETMWL     = 0x8b,
>>> +    I3C_CCCD_GETMRL     = 0x8c,
>>> +    I3C_CCCD_GETPID     = 0x8d,
>>> +    I3C_CCCD_GETBCR     = 0x8e,
>>> +    I3C_CCCD_GETDCR     = 0x8f,
>>> +    I3C_CCCD_GETSTATUS  = 0x90,
>>> +    I3C_CCCD_GETACCCR   = 0x91,
>>> +    I3C_CCCD_ENDXFER    = 0x92,
>>> +    I3C_CCCD_SETBRGTGT  = 0x93,
>>> +    I3C_CCCD_GETMXDS    = 0x94,
>>> +    I3C_CCCD_GETCAPS    = 0x95,
>>> +    I3C_CCCD_SETROUTE   = 0x96,
>>> +    I3C_CCCD_SETXTIME   = 0x98,
>>> +    I3C_CCCD_GETXTIME   = 0x99,
>>> +    I3C_CCCD_RSTACT     = 0x9a,
>>> +    I3C_CCCD_SETGRPA    = 0x9b,
>>> +    I3C_CCCD_RSTGRPA    = 0x9c,
>>> +    I3C_CCCD_MLANE      = 0x9d,
>>> +} I3CCCC;
>>> +
>>> +#define CCC_IS_DIRECT(_ccc) (_ccc & 0x80)
>>> +
>>> +#define I3C_BROADCAST 0x7e
>>> +#define I3C_HJ_ADDR 0x02
>>> +#define I3C_ENTDAA_SIZE 8
>>> +
>>> +struct I3CTargetClass {
>>> +    DeviceClass parent;
>>
>> This should be parent_class as per our style guidelines as
>> https://urldefense.proofpoint.com/v2/url?u=https-3A__qemu.readthedocs.io_en_v10.0.3_devel_style.html-23qemu-2Dspecific-2Didiom&d=DwIGaQ&c=s883GpUCOChKOHiocYtGcg&r=c23RpsaH4D2MKyD3EPJTDa0BAxz6tV8aUJqVSoytEiY&m=O_wYHXdmSffFkrrBI05nP1IAFzPMwcDr79MrvVQ6t2303Ttja_nwvVF9cGBs7rfp&s=G_w2E1BZUZgpzWjOwB_Xu0wxf4GXcAM6iqY_TDpYUUs&e=
>> s.
>>
> Thanks for the review and suggestion.
> Will fix it.
>>> +    /*
>>> +     * Controller to target. Returns 0 for success, non-zero for NAK or
>> other
>>> +     * error.
>>> +     */
>>> +    int (*send)(I3CTarget *s, const uint8_t *data, uint32_t num_to_send,
>>> +                uint32_t *num_sent);
>>> +    /*
>>> +     * Target to controller. I3C targets are able to terminate reads early, so
>>> +     * this returns the number of bytes read from the target.
>>> +     */
>>> +    uint32_t (*recv)(I3CTarget *s, uint8_t *data, uint32_t num_to_read);
>>> +    /* Notify the target of a bus state change. */
>>> +    int (*event)(I3CTarget *s, enum I3CEvent event);
>>> +    /*
>>> +     * Handle a read CCC transmitted from a controller.
>>> +     * CCCs are I3C commands that I3C targets support.
>>> +     * The target can NACK the CCC if it does not support it.
>>> +     */
>>> +    int (*handle_ccc_read)(I3CTarget *s, uint8_t *data, uint32_t
>> num_to_read,
>>> +                           uint32_t *num_read);
>>> +    /*
>>> +     * Handle a write CCC transmitted from a controller.
>>> +     * CCCs are I3C commands that I3C targets support.
>>> +     * The target can NACK the CCC if it does not support it.
>>> +     */
>>> +    int (*handle_ccc_write)(I3CTarget *s, const uint8_t *data,
>>> +                            uint32_t num_to_send, uint32_t
>>> + *num_sent);
>>> +
>>> +    /*
>>> +     * Matches and adds the candidate if the address matches the
>> candidate's
>>> +     * address.
>>> +     * Returns true if the address matched, or if this was a broadcast, and
>>> +     * updates the device list. Otherwise returns false.
>>> +     */
>>> +    bool (*target_match)(I3CTarget *candidate, uint8_t address, bool
>> is_read,
>>> +                         bool broadcast, bool in_entdaa); };
>>> +
>>> +struct I3CTarget {
>>> +    DeviceState qdev;
>>
>> And this should be parent_obj for the same reason.
>>
> Will fix it.
>>> +    uint8_t address;
>>> +    uint8_t static_address;
>>> +    uint8_t dcr;
>>> +    uint8_t bcr;
>>> +    uint64_t pid;
>>> +
>>> +    /* CCC State tracking. */
>>> +    I3CCCC curr_ccc;
>>> +    uint8_t ccc_byte_offset;
>>> +    bool in_ccc;
>>> +    bool in_test_mode;
>>> +};
>>> +
>>> +struct I3CNode {
>>> +    I3CTarget *target;
>>> +    QLIST_ENTRY(I3CNode) next;
>>> +};
>>> +
>>> +typedef struct I3CNode I3CNode;
>>> +
>>> +typedef QLIST_HEAD(I3CNodeList, I3CNode) I3CNodeList;
>>> +
>>> +#define TYPE_I3C_BUS "i3c-bus"
>>> +OBJECT_DECLARE_TYPE(I3CBus, I3CBusClass, I3C_BUS)
>>> +
>>> +struct I3CBus {
>>> +    BusState qbus;
>>
>> This should be parent_obj.
>>
> Will fix it
>>> +
>>> +    /* Legacy I2C. */
>>> +    I2CBus *i2c_bus;
>>> +
>>> +    I3CNodeList current_devs;
>>> +    bool broadcast;
>>> +    uint8_t ccc;
>>> +    bool in_ccc;
>>> +    bool in_entdaa;
>>> +    uint8_t saved_address;
>>> +};
>>> +
>>> +struct I3CBusClass {
>>> +    DeviceClass parent;
>>
>> This should be parent_class.
>>
> Will fix it.
> Additionally, it appears that the data type should be BusClass, and I will update it accordingly.

Indeed, good spot! FWIW when doing device development I always run my 
local tests on a fresh build passing --enable-asan into configure which 
is really helpful for catching issues such as this.

>>> +    /* Handle an incoming IBI request from a target */
>>> +    int (*ibi_handle) (I3CBus *bus, uint8_t addr, bool is_recv);
>>> +    /* Receive data from an IBI request */
>>> +    int (*ibi_recv) (I3CBus *bus, uint8_t data);
>>> +    /* Do anything that needs to be done, since the IBI is finished. */
>>> +    int (*ibi_finish) (I3CBus *bus);
>>> +};
>>> +
>>> +I3CBus *i3c_init_bus(DeviceState *parent, const char *name); I3CBus
>>> +*i3c_init_bus_type(const char *type, DeviceState *parent,
>>> +                          const char *name); void
>>> +i3c_set_target_address(I3CTarget *dev, uint8_t address); bool
>>> +i3c_bus_busy(I3CBus *bus);
>>> +
>>> +/*
>>> + * Start a transfer on an I3C bus.
>>> + * If is_recv is known at compile-time (i.e. a device will always be
>>> +sending or
>>> + * will always be receiving at a certain point), prefer to use
>>> +i3c_start_recv or
>>> + * i3c_start_send instead.
>>> + *
>>> + * Returns 0 on success, non-zero on an error.
>>> + */
>>> +int i3c_start_transfer(I3CBus *bus, uint8_t address, bool is_recv);
>>> +
>>> +/*
>>> + * Start a receive transfer on an I3C bus.
>>> + *
>>> + * Returns 0 on success, non-zero on an error  */ int
>>> +i3c_start_recv(I3CBus *bus, uint8_t address);
>>> +
>>> +/*
>>> + * Start a send transfer on an I3C bus.
>>> + *
>>> + * Returns 0 on success, non-zero on an error  */ int
>>> +i3c_start_send(I3CBus *bus, uint8_t address);
>>> +
>>> +void i3c_end_transfer(I3CBus *bus);
>>> +void i3c_nack(I3CBus *bus);
>>> +int i3c_send_byte(I3CBus *bus, uint8_t data); int i3c_send(I3CBus
>>> +*bus, const uint8_t *data, uint32_t num_to_send,
>>> +             uint32_t *num_sent);
>>> +/*
>>> + * I3C receives can only NACK on a CCC. The target should NACK a CCC
>>> +it does not
>>> + * support.
>>> + */
>>> +int i3c_recv_byte(I3CBus *bus, uint8_t *data); int i3c_recv(I3CBus
>>> +*bus, uint8_t *data, uint32_t num_to_read,
>>> +             uint32_t *num_read);
>>> +bool i3c_scan_bus(I3CBus *bus, uint8_t address, enum I3CEvent event);
>>> +int i3c_do_entdaa(I3CBus *bus, uint8_t address, uint64_t *pid, uint8_t *bcr,
>>> +                  uint8_t *dcr);
>>> +int i3c_start_device_transfer(I3CTarget *dev, int send_length); bool
>>> +i3c_target_match_and_add(I3CBus *bus, I3CTarget *target, uint8_t address,
>>> +                             enum I3CEvent event); int
>>> +i3c_target_send_ibi(I3CTarget *t, uint8_t addr, bool is_recv); int
>>> +i3c_target_send_ibi_bytes(I3CTarget *t, uint8_t data); int
>>> +i3c_target_ibi_finish(I3CTarget *t, uint8_t data);
>>> +
>>> +/*
>>> + * Legacy I2C functions.
>>> + *
>>> + * These are wrapper for I2C functions that take in an I3C bus
>>> +instead of an I2C
>>> + * bus. Internally they use the I2C bus (and devices attached to it)
>>> +that's a
>>> + * part of the I3C bus
>>> + */
>>> +void legacy_i2c_nack(I3CBus *bus);
>>> +uint8_t legacy_i2c_recv(I3CBus *bus); int legacy_i2c_send(I3CBus
>>> +*bus, uint8_t data); int legacy_i2c_start_transfer(I3CBus *bus,
>>> +uint8_t address, bool is_recv); int legacy_i2c_start_recv(I3CBus
>>> +*bus, uint8_t address); int legacy_i2c_start_send(I3CBus *bus,
>>> +uint8_t address); void legacy_i2c_end_transfer(I3CBus *bus); I2CSlave
>>> +*legacy_i2c_device_create_simple(I3CBus *bus, const char *name,
>>> +                                          uint8_t addr);
>>> +
>>> +/**
>>> + * Create an I3C Target.
>>> + *
>>> + * The target returned from this function still needs to be realized.
>>> + */
>>> +I3CTarget *i3c_target_new(const char *name, uint8_t addr, uint8_t dcr,
>>> +                          uint8_t bcr, uint64_t pid);
>>> +
>>> +/**
>>> + * Create and realize an I3C target.
>>> + *
>>> + * Create the target, initialize it, put it on the specified I3C bus,
>>> +and
>>> + * realize it.
>>> + */
>>> +I3CTarget *i3c_target_create_simple(I3CBus *bus, const char *name,
>>> +                                    uint8_t addr, uint8_t dcr,
>> uint8_t bcr,
>>> +                                    uint64_t pid);
>>> +
>>> +/* Realize and drop the reference count on an I3C target. */ bool
>>> +i3c_target_realize_and_unref(I3CTarget *dev, I3CBus *bus, Error
>>> +**errp);
>>> +
>>> +#endif  /* QEMU_INCLUDE_HW_I3C_I3C_H_ */
>>> diff --git a/hw/i3c/core.c b/hw/i3c/core.c new file mode 100644 index
>>> 0000000000..fb4bfe5aec
>>> --- /dev/null
>>> +++ b/hw/i3c/core.c
>>> @@ -0,0 +1,652 @@
>>> +/*
>>> + * QEMU I3C bus interface.
>>> + *
>>> + * Copyright 2025 Google LLC
>>> + *
>>> + * SPDX-License-Identifier: GPL-2.0-or-later  */
>>> +
>>> +#include "qemu/osdep.h"
>>> +#include "qemu/log.h"
>>> +#include "qapi/error.h"
>>> +#include "trace.h"
>>> +#include "hw/i3c/i3c.h"
>>> +#include "hw/core/qdev-properties.h"
>>> +
>>> +/*
>>> + * In test mode (enabled by ENTTM CCC) we're supposed to send a
>>> +random PID
>>> + * during ENTDAA, so we'll just send "QEMU".
>>> + */
>>> +#define TEST_MODE_PROVISIONED_ID 0x0000554d4551ULL
>>> +
>>> +static const Property i3c_props[] = {
>>> +    DEFINE_PROP_UINT8("static-address", struct I3CTarget, static_address,
>> 0),
>>> +    DEFINE_PROP_UINT8("dcr", struct I3CTarget, dcr, 0),
>>> +    DEFINE_PROP_UINT8("bcr", struct I3CTarget, bcr, 0),
>>> +    DEFINE_PROP_UINT64("pid", struct I3CTarget, pid, 0), };
>>> +
>>> +static const TypeInfo i3c_bus_info = {
>>> +    .name = TYPE_I3C_BUS,
>>> +    .parent = TYPE_BUS,
>>> +    .instance_size = sizeof(I3CBus),
>>> +    .class_size = sizeof(I3CBusClass), };
>>> +
>>> +I3CBus *i3c_init_bus(DeviceState *parent, const char *name) {
>>> +    return i3c_init_bus_type(TYPE_I3C_BUS, parent, name); }
>>> +
>>> +I3CBus *i3c_init_bus_type(const char *type, DeviceState *parent,
>>> +                          const char *name) {
>>> +    I3CBus *bus;
>>> +
>>> +    bus = I3C_BUS(qbus_new(type, parent, name));
>>> +    QLIST_INIT(&bus->current_devs);
>>> +    bus->broadcast = false;
>>> +    bus->in_entdaa = false;
>>> +    bus->in_ccc = false;
>>> +
>>> +    /* I2C init. */
>>> +    g_autofree gchar *i2c_bus_name = g_strdup_printf("%s-legacy-i2c",
>> name);
>>> +    bus->i2c_bus = i2c_init_bus(parent, i2c_bus_name);
>>> +
>>> +    return bus;
>>> +}
>>> +
>>> +bool i3c_bus_busy(I3CBus *bus)
>>> +{
>>> +    return !QLIST_EMPTY(&bus->current_devs); }
>>> +
>>> +static bool i3c_target_match(I3CTarget *candidate, uint8_t address,
>>> +                             bool is_recv, bool broadcast, bool
>>> +in_entdaa) {
>>> +    /* Once a target has a dynamic address, it only responds to that. */
>>> +    uint8_t targ_addr = candidate->address ? candidate->address :
>>> +
>>> +candidate->static_address;
>>> +
>>> +    if (in_entdaa) {
>>> +        if (address != I3C_BROADCAST) {
>>> +            g_autofree char *path =
>>> +                object_get_canonical_path(OBJECT(candidate));
>>> +            qemu_log_mask(LOG_GUEST_ERROR, "%s: I3C Address
>> 0x%.2x sent during "
>>> +                          "ENTDAA instead of a broadcast address\n",
>>> +                          path, address);
>>> +            return false;
>>> +        }
>>> +
>>> +        /*
>>> +         * Targets should only ACK ENTDAA broadcasts if they have no
>> dynamic
>>> +         * address.
>>> +         */
>>> +        return candidate->address == 0;
>>> +    }
>>> +
>>> +    /* Return if our addresses match, or if it's a broadcast. */
>>> +    return targ_addr == address || broadcast; }
>>> +
>>> +bool i3c_target_match_and_add(I3CBus *bus, I3CTarget *target, uint8_t
>> address,
>>> +                              enum I3CEvent event) {
>>> +    I3CTargetClass *tc = I3C_TARGET_GET_CLASS(target);
>>> +    bool matched = tc->target_match(target, address, event ==
>> I3C_START_RECV,
>>> +                                    bus->broadcast,
>> bus->in_entdaa);
>>> +
>>> +    if (matched) {
>>> +        I3CNode *node = g_new(struct I3CNode, 1);
>>> +        node->target = target;
>>> +        QLIST_INSERT_HEAD(&bus->current_devs, node, next);
>>> +    }
>>> +    return matched;
>>> +}
>>> +
>>> +bool i3c_scan_bus(I3CBus *bus, uint8_t address, enum I3CEvent event)
>>> +{
>>> +    BusChild *child;
>>> +    I3CNode *node, *next;
>>> +
>>> +    /* Clear out any devices from a previous (re-)START. */
>>> +    QLIST_FOREACH_SAFE(node, &bus->current_devs, next, next) {
>>> +        QLIST_REMOVE(node, next);
>>> +        g_free(node);
>>> +    }
>>> +
>>> +    QTAILQ_FOREACH(child, &bus->qbus.children, sibling) {
>>> +        DeviceState *qdev = child->child;
>>> +        I3CTarget *target = I3C_TARGET(qdev);
>>> +
>>> +        if (i3c_target_match_and_add(bus, target, address, event)) {
>>> +            return true;
>>> +        }
>>> +    }
>>> +
>>> +    /* No one on the bus could respond. */
>>> +    return false;
>>> +}
>>> +
>>> +/* Class-level event handling, since we do some CCCs at the class
>>> +level. */ static int i3c_target_event(I3CTarget *t, enum I3CEvent
>>> +event) {
>>> +    I3CTargetClass *tc = I3C_TARGET_GET_CLASS(t);
>>> +    trace_i3c_target_event(t->address, event);
>>> +
>>> +    if (event == I3C_STOP) {
>>> +        t->curr_ccc = 0;
>>> +        t->ccc_byte_offset = 0;
>>> +        t->in_ccc = false;
>>> +    }
>>> +    return tc->event(t, event);
>>> +}
>>> +
>>> +/*
>>> + * Sends a START or repeated START and the address for an I3C transaction.
>>> + *
>>> + * This function returns 0 if a device on the bus was able to respond
>>> +to the
>>> + * address, and non-zero otherwise.
>>> + * A non-zero return represents a NACK.
>>> + */
>>> +static int i3c_do_start_transfer(I3CBus *bus, uint8_t address,
>>> +                                 enum I3CEvent event) {
>>> +    I3CTargetClass *tc;
>>> +    I3CNode *node;
>>> +
>>> +    if (address == I3C_BROADCAST) {
>>> +        bus->broadcast = true;
>>> +        /* If we're not in ENTDAA, a broadcast is the start of a new CCC.
>> */
>>> +        if (!bus->in_entdaa) {
>>> +            bus->in_ccc = false;
>>> +        }
>>> +    } else {
>>> +        bus->broadcast = false;
>>> +    }
>>> +
>>> +    /* No one responded to the address, NACK it. */
>>> +    if (!i3c_scan_bus(bus, address, event)) {
>>> +        return -1;
>>> +    }
>>> +
>>> +    QLIST_FOREACH(node, &bus->current_devs, next) {
>>> +        I3CTarget *t = node->target;
>>> +
>>> +        tc = I3C_TARGET_GET_CLASS(t);
>>> +        if (tc->event) {
>>> +            int rv = i3c_target_event(t, event);
>>> +            if (rv && !bus->broadcast) {
>>> +                return rv;
>>> +            }
>>> +        }
>>> +    }
>>> +
>>> +    return 0;
>>> +}
>>> +
>>> +int i3c_start_transfer(I3CBus *bus, uint8_t address, bool is_recv) {
>>> +    trace_i3c_start_transfer(address, is_recv);
>>> +    return i3c_do_start_transfer(bus, address, is_recv
>>> +                                               ?
>> I3C_START_RECV
>>> +                                               :
>> I3C_START_SEND); }
>>> +
>>> +int i3c_start_recv(I3CBus *bus, uint8_t address) {
>>> +    trace_i3c_start_transfer(address, true);
>>> +    return i3c_do_start_transfer(bus, address, I3C_START_RECV); }
>>> +
>>> +int i3c_start_send(I3CBus *bus, uint8_t address) {
>>> +    trace_i3c_start_transfer(address, false);
>>> +    return i3c_do_start_transfer(bus, address, I3C_START_SEND); }
>>> +
>>> +void i3c_end_transfer(I3CBus *bus)
>>> +{
>>> +    I3CTargetClass *tc;
>>> +    I3CNode *node, *next;
>>> +
>>> +    trace_i3c_end_transfer();
>>> +
>>> +    /*
>>> +     * If we're in ENTDAA, we need to notify all devices when ENTDAA is
>> done.
>>> +     * This is because everyone initially participates due to the broadcast,
>>> +     * but gradually drops out as they get assigned addresses.
>>> +     * Since the current_devs list only stores who's currently participating,
>>> +     * and not everyone who previously participated, we send the STOP to
>> all
>>> +     * children.
>>> +     */
>>> +    if (bus->in_entdaa) {
>>> +        BusChild *child;
>>> +
>>> +        QTAILQ_FOREACH(child, &bus->qbus.children, sibling) {
>>> +            DeviceState *qdev = child->child;
>>> +            I3CTarget *t = I3C_TARGET(qdev);
>>> +            tc = I3C_TARGET_GET_CLASS(t);
>>> +            if (tc->event) {
>>> +                i3c_target_event(t, I3C_STOP);
>>> +            }
>>> +        }
>>> +    } else {
>>> +        QLIST_FOREACH_SAFE(node, &bus->current_devs, next, next) {
>>> +            I3CTarget *t = node->target;
>>> +            tc = I3C_TARGET_GET_CLASS(t);
>>> +            if (tc->event) {
>>> +                i3c_target_event(t, I3C_STOP);
>>> +            }
>>> +            QLIST_REMOVE(node, next);
>>> +            g_free(node);
>>> +        }
>>> +    }
>>> +    bus->broadcast = false;
>>> +    bus->in_entdaa = false;
>>> +    bus->in_ccc = false;
>>> +}
>>> +
>>> +/*
>>> + * Any CCCs that are universal across all I3C devices should be handled
>> here.
>>> + * Once they're handled, we pass the CCC up to the I3C target to do
>>> +anything
>>> + * else it may want with the bytes.
>>> + */
>>> +static int i3c_target_handle_ccc_write(I3CTarget *t, const uint8_t *data,
>>> +                                       uint32_t num_to_send,
>> uint32_t
>>> +*num_sent) {
>>> +    I3CTargetClass *tc = I3C_TARGET_GET_CLASS(t);
>>> +    *num_sent = 0;
>>> +
>>> +    /* Is this the start of a new CCC? */
>>> +    if (!t->in_ccc) {
>>> +        t->curr_ccc = *data;
>>> +        t->in_ccc = true;
>>> +        *num_sent = 1;
>>> +        trace_i3c_target_handle_ccc(t->address, t->curr_ccc);
>>> +    }
>>> +
>>> +    switch (t->curr_ccc) {
>>> +    case I3C_CCC_ENTDAA:
>>> +        /*
>>> +         * This is the last byte of ENTDAA, the controller is assigning us
>> an
>>> +         * address.
>>> +         */
>>> +        if (t->ccc_byte_offset == 8) {
>>> +            t->address = *data;
>>> +            t->in_ccc = false;
>>> +            t->curr_ccc = 0;
>>> +            t->ccc_byte_offset = 0;
>>> +            *num_sent = 1;
>>> +        }
>>> +        break;
>>> +    case I3C_CCCD_SETDASA:
>>> +        t->address = t->static_address;
>>> +        break;
>>> +    case I3C_CCC_SETAASA:
>>> +        t->address = t->static_address;
>>> +        break;
>>> +    case I3C_CCC_RSTDAA:
>>> +        t->address = 0;
>>> +        break;
>>> +    case I3C_CCCD_SETNEWDA:
>>> +        /* If this isn't the CCC byte, it's our new address. */
>>> +        if (*num_sent == 0) {
>>> +            t->address = *data;
>>> +            *num_sent = 1;
>>> +        }
>>> +        break;
>>> +    case I3C_CCC_ENTTM:
>>> +        /*
>>> +         * If there are still more to look at, the next byte is the test mode
>>> +         * byte.
>>> +         */
>>> +        if (*num_sent != num_to_send) {
>>> +            /* Enter test mode if the byte is non-zero. Otherwise exit. */
>>> +            t->in_test_mode = !!data[*num_sent];
>>> +            ++*num_sent;
>>> +        }
>>> +        break;
>>> +    /* Ignore other CCCs it's better to handle on a device-by-device basis.
>> */
>>> +    default:
>>> +        break;
>>> +    }
>>> +    return tc->handle_ccc_write(t, data, num_to_send, num_sent); }
>>> +
>>> +int i3c_send_byte(I3CBus *bus, uint8_t data) {
>>> +    /*
>>> +     * Ignored, the caller can determine how many were sent based on if
>> this was
>>> +     * ACKed/NACKed.
>>> +     */
>>> +    uint32_t num_sent;
>>> +    return i3c_send(bus, &data, 1, &num_sent); }
>>> +
>>> +int i3c_send(I3CBus *bus, const uint8_t *data, uint32_t num_to_send,
>>> +             uint32_t *num_sent)
>>> +{
>>> +    I3CTargetClass *tc;
>>> +    I3CTarget *t;
>>> +    I3CNode *node;
>>> +    int ret = 0;
>>> +
>>> +    /* If this message is a broadcast and no CCC has been found, grab it. */
>>> +    if (bus->broadcast && !bus->in_ccc) {
>>> +        bus->ccc = *data;
>>> +        bus->in_ccc = true;
>>> +        /*
>>> +         * We need to keep track if we're currently in ENTDAA.
>>> +         * On any other CCC, the CCC is over on a RESTART or STOP, but
>> ENTDAA
>>> +         * is only over on a STOP.
>>> +         */
>>> +        if (bus->ccc == I3C_CCC_ENTDAA) {
>>> +            bus->in_entdaa = true;
>>> +        }
>>> +    }
>>> +
>>> +    QLIST_FOREACH(node, &bus->current_devs, next) {
>>> +        t = node->target;
>>> +        tc = I3C_TARGET_GET_CLASS(t);
>>> +        if (bus->in_ccc) {
>>> +            if (!tc->handle_ccc_write) {
>>> +                ret = -1;
>>> +                continue;
>>> +            }
>>> +            ret = i3c_target_handle_ccc_write(t, data, num_to_send,
>> num_sent);
>>> +            /* Targets should only NACK on a direct CCC. */
>>> +            if (ret && !CCC_IS_DIRECT(bus->ccc)) {
>>> +                ret = 0;
>>> +            }
>>> +        } else {
>>> +            if (tc->send) {
>>> +                ret = ret || tc->send(t, data, num_to_send, num_sent);
>>> +            } else {
>>> +                ret = -1;
>>> +            }
>>> +        }
>>> +    }
>>> +
>>> +    trace_i3c_send(*num_sent, num_to_send, ret == 0);
>>> +
>>> +    return ret ? -1 : 0;
>>> +}
>>> +
>>> +static int i3c_target_handle_ccc_read(I3CTarget *t, uint8_t *data,
>>> +                                      uint32_t num_to_read,
>> uint32_t
>>> +*num_read) {
>>> +    I3CTargetClass *tc = I3C_TARGET_GET_CLASS(t);
>>> +    uint8_t read_count = 0;
>>> +    uint64_t pid;
>>> +
>>> +    switch (t->curr_ccc) {
>>> +    case I3C_CCC_ENTDAA:
>>> +        if (t->in_test_mode) {
>>> +            pid = TEST_MODE_PROVISIONED_ID;
>>> +        } else {
>>> +            pid = t->pid;
>>> +        }
>>> +        /* Return the 6-byte PID, followed by BCR then DCR. */
>>> +        while (t->ccc_byte_offset < 6) {
>>> +            if (read_count >= num_to_read) {
>>> +                break;
>>> +            }
>>> +            data[read_count] = (pid >> (t->ccc_byte_offset * 8)) & 0xff;
>>> +            t->ccc_byte_offset++;
>>> +            read_count++;
>>> +        }
>>> +        if (read_count < num_to_read) {
>>> +            data[read_count] = t->bcr;
>>> +            t->ccc_byte_offset++;
>>> +            read_count++;
>>> +        }
>>> +        if (read_count < num_to_read) {
>>> +            data[read_count] = t->dcr;
>>> +            t->ccc_byte_offset++;
>>> +            read_count++;
>>> +        }
>>> +        *num_read = read_count;
>>> +        break;
>>> +    case I3C_CCCD_GETPID:
>>> +        while (t->ccc_byte_offset < 6) {
>>> +            if (read_count >= num_to_read) {
>>> +                break;
>>> +            }
>>> +            data[read_count] = (t->pid >> (t->ccc_byte_offset * 8)) &
>> 0xff;
>>> +            t->ccc_byte_offset++;
>>> +            read_count++;
>>> +        }
>>> +        *num_read = read_count;
>>> +        break;
>>> +    case I3C_CCCD_GETBCR:
>>> +        *data = t->bcr;
>>> +        *num_read = 1;
>>> +        break;
>>> +    case I3C_CCCD_GETDCR:
>>> +        *data = t->dcr;
>>> +        *num_read = 1;
>>> +        break;
>>> +    default:
>>> +        /* Unhandled on the I3CTarget class level. */
>>> +        break;
>>> +    }
>>> +
>>> +    return tc->handle_ccc_read(t, data, num_to_read, num_read); }
>>> +
>>> +int i3c_recv_byte(I3CBus *bus, uint8_t *data) {
>>> +     /*
>>> +      * Ignored, the caller can determine how many bytes were read
>> based on if
>>> +      * this is ACKed/NACKed.
>>> +      */
>>> +    uint32_t num_read;
>>> +    return i3c_recv(bus, data, 1, &num_read); }
>>> +
>>> +int i3c_recv(I3CBus *bus, uint8_t *data, uint32_t num_to_read,
>>> +             uint32_t *num_read)
>>> +{
>>> +    int ret = 0;
>>> +    I3CTargetClass *tc;
>>> +    I3CTarget *t;
>>> +
>>> +    *data = 0xff;
>>> +    if (!QLIST_EMPTY(&bus->current_devs)) {
>>> +        tc =
>> I3C_TARGET_GET_CLASS(QLIST_FIRST(&bus->current_devs)->target);
>>> +        t = QLIST_FIRST(&bus->current_devs)->target;
>>> +        if (bus->in_ccc) {
>>> +            if (!tc->handle_ccc_read) {
>>> +                return -1;
>>> +            }
>>> +            ret = i3c_target_handle_ccc_read(t, data, num_to_read,
>> num_read);
>>> +        } else {
>>> +            if (tc->recv) {
>>> +                /*
>>> +                 * Targets cannot NACK on a direct transfer, so the data
>>> +                 * is returned directly.
>>> +                 */
>>> +                *num_read = tc->recv(t, data, num_to_read);
>>> +            }
>>> +        }
>>> +    }
>>> +
>>> +    trace_i3c_recv(*num_read, num_to_read, ret == 0);
>>> +
>>> +    return ret;
>>> +}
>>> +
>>> +void i3c_nack(I3CBus *bus)
>>> +{
>>> +    I3CTargetClass *tc;
>>> +    I3CNode *node;
>>> +
>>> +    if (QLIST_EMPTY(&bus->current_devs)) {
>>> +        return;
>>> +    }
>>> +
>>> +    QLIST_FOREACH(node, &bus->current_devs, next) {
>>> +        tc = I3C_TARGET_GET_CLASS(node->target);
>>> +        if (tc->event) {
>>> +            i3c_target_event(node->target, I3C_NACK);
>>> +        }
>>> +    }
>>> +}
>>> +
>>> +int i3c_target_send_ibi(I3CTarget *t, uint8_t addr, bool is_recv) {
>>> +    I3CBus *bus = I3C_BUS(t->qdev.parent_bus);
>>> +    I3CBusClass *bc = I3C_BUS_GET_CLASS(bus);
>>> +    trace_i3c_target_send_ibi(addr, is_recv);
>>> +    return bc->ibi_handle(bus, addr, is_recv); }
>>> +
>>> +int i3c_target_send_ibi_bytes(I3CTarget *t, uint8_t data) {
>>> +    I3CBus *bus = I3C_BUS(t->qdev.parent_bus);
>>> +    I3CBusClass *bc = I3C_BUS_GET_CLASS(bus);
>>> +    trace_i3c_target_send_ibi_bytes(data);
>>> +    return bc->ibi_recv(bus, data);
>>> +}
>>> +
>>> +int i3c_target_ibi_finish(I3CTarget *t, uint8_t data) {
>>> +    I3CBus *bus = I3C_BUS(t->qdev.parent_bus);
>>> +    I3CBusClass *bc = I3C_BUS_GET_CLASS(bus);
>>> +    trace_i3c_target_ibi_finish();
>>> +    return bc->ibi_finish(bus);
>>> +}
>>> +
>>> +static bool i3c_addr_is_rsvd(uint8_t addr) {
>>> +    const bool is_rsvd[255] = {
>>> +        [0x00] = true,
>>> +        [0x01] = true,
>>> +        [0x02] = true,
>>> +        [0x3e] = true,
>>> +        [0x5e] = true,
>>> +        [0x6e] = true,
>>> +        [0x76] = true,
>>> +        [0x7a] = true,
>>> +        [0x7c] = true,
>>> +        [0x7e] = true,
>>> +        [0x7f] = true,
>>> +    };
>>> +
>>> +    return is_rsvd[addr];
>>> +}
>>> +
>>> +I3CTarget *i3c_target_new(const char *name, uint8_t addr, uint8_t dcr,
>>> +                          uint8_t bcr, uint64_t pid) {
>>> +    DeviceState *dev;
>>> +
>>> +    dev = qdev_new(name);
>>> +    qdev_prop_set_uint8(dev, "static-address", addr);
>>> +    qdev_prop_set_uint8(dev, "dcr", dcr);
>>> +    qdev_prop_set_uint8(dev, "bcr", bcr);
>>> +    qdev_prop_set_uint64(dev, "pid", pid);
>>> +
>>> +    if (i3c_addr_is_rsvd(addr)) {
>>> +        g_autofree char *path =
>> object_get_canonical_path(OBJECT(dev));
>>> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: I3C target created
>> with reserved "
>>> +                      "address 0x%.2x\n", path, addr);
>>> +    }
>>> +    return I3C_TARGET(dev);
>>> +}
>>> +
>>> +bool i3c_target_realize_and_unref(I3CTarget *dev, I3CBus *bus, Error
>>> +**errp) {
>>> +    return qdev_realize_and_unref(&dev->qdev, &bus->qbus, errp); }
>>> +
>>> +I3CTarget *i3c_target_create_simple(I3CBus *bus, const char *name,
>> uint8_t addr,
>>> +                                    uint8_t dcr, uint8_t bcr,
>>> +uint64_t pid) {
>>> +    I3CTarget *dev = i3c_target_new(name, addr, dcr, bcr, pid);
>>> +    dev->address = 0;
>>> +    i3c_target_realize_and_unref(dev, bus, &error_abort);
>>> +
>>> +    return dev;
>>> +}
>>> +
>>> +/* Legacy I2C functions. */
>>> +void legacy_i2c_nack(I3CBus *bus)
>>> +{
>>> +    trace_legacy_i2c_nack();
>>> +    i2c_nack(bus->i2c_bus);
>>> +}
>>> +
>>> +uint8_t legacy_i2c_recv(I3CBus *bus)
>>> +{
>>> +    uint8_t byte = i2c_recv(bus->i2c_bus);
>>> +    trace_legacy_i2c_recv(byte);
>>> +    return byte;
>>> +}
>>> +
>>> +int legacy_i2c_send(I3CBus *bus, uint8_t data) {
>>> +    trace_legacy_i2c_send(data);
>>> +    return i2c_send(bus->i2c_bus, data); }
>>> +
>>> +int legacy_i2c_start_transfer(I3CBus *bus, uint8_t address, bool
>>> +is_recv) {
>>> +    trace_legacy_i2c_start_transfer(address, is_recv);
>>> +    return i2c_start_transfer(bus->i2c_bus, address, is_recv); }
>>> +
>>> +int legacy_i2c_start_recv(I3CBus *bus, uint8_t address) {
>>> +    trace_legacy_i2c_start_transfer(address, true);
>>> +    return i2c_start_transfer(bus->i2c_bus, address,
>>> +/*is_recv=*/true); }
>>> +
>>> +int legacy_i2c_start_send(I3CBus *bus, uint8_t address) {
>>> +    trace_legacy_i2c_start_transfer(address, false);
>>> +    return i2c_start_transfer(bus->i2c_bus, address,
>>> +/*is_recv=*/false); }
>>> +
>>> +void legacy_i2c_end_transfer(I3CBus *bus) {
>>> +    trace_legacy_i2c_end_transfer();
>>> +    i2c_end_transfer(bus->i2c_bus);
>>> +}
>>> +
>>> +I2CSlave *legacy_i2c_device_create_simple(I3CBus *bus, const char
>> *name,
>>> +                                          uint8_t addr) {
>>> +    I2CSlave *dev = i2c_slave_new(name, addr);
>>> +
>>> +    i2c_slave_realize_and_unref(dev, bus->i2c_bus, &error_abort);
>>> +    return dev;
>>> +}
>>> +
>>> +static void i3c_target_class_init(ObjectClass *klass, const void
>>> +*data) {
>>> +    DeviceClass *k = DEVICE_CLASS(klass);
>>> +    I3CTargetClass *sc = I3C_TARGET_CLASS(klass);
>>> +    set_bit(DEVICE_CATEGORY_MISC, k->categories);
>>> +    k->bus_type = TYPE_I3C_BUS;
>>> +    device_class_set_props(k, i3c_props);
>>> +    sc->target_match = i3c_target_match; }
>>> +
>>> +static const TypeInfo i3c_target_type_info = {
>>> +    .name = TYPE_I3C_TARGET,
>>> +    .parent = TYPE_DEVICE,
>>> +    .instance_size = sizeof(I3CTarget),
>>> +    .abstract = true,
>>> +    .class_size = sizeof(I3CTargetClass),
>>> +    .class_init = i3c_target_class_init, };
>>> +
>>> +static void i3c_register_types(void)
>>> +{
>>> +    type_register_static(&i3c_bus_info);
>>> +    type_register_static(&i3c_target_type_info);
>>> +}
>>> +
>>> +type_init(i3c_register_types)
>>
>> These days the DEFINE_TYPES() macro is recommended over writing an
>> explicit registration function.
> Will fix it
> 
> Thanks,
> Jamin
>>
>>> diff --git a/hw/i3c/meson.build b/hw/i3c/meson.build index
>>> ebf20325cb..fb127613fe 100644
>>> --- a/hw/i3c/meson.build
>>> +++ b/hw/i3c/meson.build
>>> @@ -1,3 +1,4 @@
>>>    i3c_ss = ss.source_set()
>>> +i3c_ss.add(when: 'CONFIG_I3C', if_true: files('core.c'))
>>>    i3c_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files('aspeed_i3c.c'))
>>>    system_ss.add_all(when: 'CONFIG_I3C', if_true: i3c_ss) diff --git
>>> a/hw/i3c/trace-events b/hw/i3c/trace-events index
>>> 3ead84eb45..cdf7cb07f6 100644
>>> --- a/hw/i3c/trace-events
>>> +++ b/hw/i3c/trace-events
>>> @@ -5,3 +5,19 @@ aspeed_i3c_read(uint64_t offset, uint64_t data) "I3C
>> read: offset 0x%" PRIx64 "
>>>    aspeed_i3c_write(uint64_t offset, uint64_t data) "I3C write: offset 0x%"
>> PRIx64 " data 0x%" PRIx64
>>>    aspeed_i3c_device_read(uint32_t deviceid, uint64_t offset, uint64_t data)
>> "I3C Dev[%u] read: offset 0x%" PRIx64 " data 0x%" PRIx64
>>>    aspeed_i3c_device_write(uint32_t deviceid, uint64_t offset, uint64_t
>>> data) "I3C Dev[%u] write: offset 0x%" PRIx64 " data 0x%" PRIx64
>>> +
>>> +# core.c
>>> +i3c_target_event(uint8_t address, uint8_t event) "I3C target 0x%"
>>> +PRIx8 " event 0x%" PRIx8 i3c_target_handle_ccc(uint8_t address,
>>> +uint8_t ccc) "I3C target 0x%" PRIx8 " handling CCC 0x%" PRIx8
>> i3c_target_send_ibi(uint8_t address, bool is_recv) "I3C target IBI address 0x%"
>> PRIx8 " RnW=%d"
>>> +i3c_target_send_ibi_bytes(uint8_t byte) "I3C target IBI byte 0x%"
>>> +PRIx8
>>> +i3c_target_ibi_finish(void) "I3C target IBI finish"
>>> +i3c_start_transfer(uint8_t address, bool is_recv) "I3C START with address
>> 0x%" PRIx8 " is_recv=%d"
>>> +i3c_end_transfer(void) "I3C transfer done"
>>> +i3c_send(uint32_t num_sent, uint32_t num_to_send, bool ack) "I3C send %"
>> PRId32 "/%" PRId32 " bytes, ack=%d"
>>> +i3c_recv(uint32_t num_read, uint32_t num_to_read, bool ack) "I3C recv %"
>> PRId32 "/%" PRId32 " bytes, ack=%d"
>>> +legacy_i2c_nack(void) "Legacy I2C NACK"
>>> +legacy_i2c_recv(uint8_t byte) "Legacy I2C recv 0x%" PRIx8
>>> +legacy_i2c_send(uint8_t byte) "Legacy I2C send 0x%" PRIx8
>>> +legacy_i2c_start_transfer(uint8_t address, bool is_recv) "Legacy I2C START
>> with address 0x%" PRIx8 " is_recv=%d"
>>> +legacy_i2c_end_transfer(void) "Legacy I2C STOP"


ATB,

Mark.


