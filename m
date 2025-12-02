Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A846BCFD376
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Dec 2025 10:43:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQNqL-0007Nf-2G; Tue, 02 Dec 2025 05:42:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vQNqJ-0007NF-5j
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 05:42:47 -0500
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vQNqH-0002rq-9y
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 05:42:46 -0500
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5B244Q1I1715415; Tue, 2 Dec 2025 02:42:40 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=6ZV7B6ah93Z1aY2PtV5O4yg4CqPz8AKGoRcbGHe/+
 Ns=; b=uFkAcYF3lZXpghKGRfkRp7kfSsleGf1ojJbN0JLv3OwR/8XneeVowgWkU
 CzJ4htON/xUceGVrrIFC8bahiJA/JyXH2YGAy+CwVp37p4mY9mRkviKfbWtqoNNG
 rJSHNRNECKxPlmpFNjz2TRiEzM2tTzAUwlsfou6Z8H4xtZ4XjLoASmrgZ009hmhr
 zQq+J9x/FS2a1oHNhNvmoOmHoyz4s+FCJi0CWetv0LgKDO0YnUXB0BBxO3/dywHj
 nSlhdv4KdLo5zkNaLX+vjRDZjpP3xb2Ep3lRnGTPs8ATCDKqTUe+Ry58Hd/Grt2t
 yrOPtWPVsWQKR8A5Dq7iOkCuSSs3A==
Received: from sj2pr03cu001.outbound.protection.outlook.com
 (mail-westusazon11022085.outbound.protection.outlook.com [52.101.43.85])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4asrrxrrx5-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 02 Dec 2025 02:42:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sPMm6V0nP284aJz3DH4r9DKqeVt3AtX5bKWtEvov1UPc+pFeZpRsivEFLnBOe2gwldnjIMxSBKOSoMcQ/HtPEn/YVi2ZXBrdNiZ4ZcBtjLSxJtA3PLT3GFKcEl5Sg7rtGpchcZMnzIBfqa9FM2DATUnOIyht/jWi5/IyFvkovlxilaODdZs5R04uXyJim5piawk3MAl8vZx/otzVkltMl9ujRSDSER6Jz40+WbwPKye8D5Uq7B6Y0aDFyuv/M/WHS05uKWcViKbJftT4+epQ0vEMZCcU8QbpSy/RK1nZ1jt9FB1hIZvrn+ijmN6XEbaKo5TP3ZdghM2DNNpcGH/6xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6ZV7B6ah93Z1aY2PtV5O4yg4CqPz8AKGoRcbGHe/+Ns=;
 b=tRF0jwSCu2U8d2goiOQwBtYqJ+lHw9SJiCLtN0/6qodJzqk4pUJF+HrwBPSTg9BxZ+fvQmiczeUCfz+54haXVvm1MG6YurN4IARciJsT6Jh7V9dXO7zvA9O0j6/zOdczRfQpfIbYohI5gVW36RN4GVy2Kjq6qZr5hOFHRitpBkLgzNnbCAGvmoHWqxCqiBi1yql8UnhbSn+ykQEEiIYD3tQ3WnKdrpqRnUweT56k9JMdH1cEnpja5oAFhtf5zp/+3w3iwQQOw5dI+wflFTTnqjBhBKGsLISP3ON53Q3YF0EwBPG8CB9PQtC+905Rfuz3f/6r/7VfUWKH5kixjsXU5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ZV7B6ah93Z1aY2PtV5O4yg4CqPz8AKGoRcbGHe/+Ns=;
 b=r7c+c/MFNvquUfuIMryen0msKCVhrYLwBtfImkciNfzCOyq/KwFLlF7owt74ktP13KTnpIvfYdqyxzS581mccbhxBYzbNfc8v0KYZYIK8ww19R+1u9MBS/8/OlCoCwbgpDoq3U6bMN2Wens1MjgbY/eyzpkof6/db+ysMcoDIGI331H7uJdWwom33SBidQxDDwit0f8iUM5R3y2Z/1KgX1eCK3nkOLfIEafbQyBiU0Vuifr/ZDxRv+3zSDa9mnmT6VOHKx0yil34d07s5CvglAQTaHFJ7EWR+vgX4tMP22EazuIYgbBmk86r7OCW1nr4CF8rbJ82I8xVV0lsR/jCKg==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by MN2PR02MB7024.namprd02.prod.outlook.com (2603:10b6:208:205::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Tue, 2 Dec
 2025 10:42:37 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%3]) with mapi id 15.20.9388.003; Tue, 2 Dec 2025
 10:42:36 +0000
Message-ID: <4d983197-9d34-4e89-a193-b9d55ea2c8b3@nutanix.com>
Date: Tue, 2 Dec 2025 10:42:31 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/5] vfio-user: simplify vfio_user_process()
To: John Levon <john.levon@nutanix.com>, qemu-devel@nongnu.org
Cc: Thanos Makatos <thanos.makatos@nutanix.com>,
 Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>
References: <20251201095621.2786318-1-john.levon@nutanix.com>
 <20251201095621.2786318-2-john.levon@nutanix.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <20251201095621.2786318-2-john.levon@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0538.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:319::8) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|MN2PR02MB7024:EE_
X-MS-Office365-Filtering-Correlation-Id: dc6a3da9-bf04-4b4d-68f4-08de318f81bf
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|366016|10070799003|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?a1hlQk5oQkFPNEZnSXQxTUkwMkIvWHNjVjJhNlBqUGlCcTVmNUtTWTM3TXJD?=
 =?utf-8?B?c25scFFPVk5sNS84Z0F2aElSRGl6QUNHWWtwR1JGM1Z1Ky9zZjlTUHlrSTdE?=
 =?utf-8?B?c3FoczJCWmM2dFkzUU9qNjllMkJENkRzc2VKSVhINmxJbDg4T3IzTGwwY1h5?=
 =?utf-8?B?RnVyd1ZvSEV6ZDNiUy83cDd4SElsMCs5VGRNYTRGcEpKYkF1RllkeW5iS2pl?=
 =?utf-8?B?MG9HN3NoNncvYTRZS3h0V0swN2VvRGUwVjdQYXc4OENmTmJWY1ZCVEZ5MUd4?=
 =?utf-8?B?c01YYzhHQktnK1E2MHpCZlhhYWUxR1BMVVJCT3BrUTdra21nczBYanRsY3kz?=
 =?utf-8?B?SlhYSEdGdjYyeWtPWW9NVy92dUNJNmc5UkVpT0hUS29vQURmai9yNTlFSEhE?=
 =?utf-8?B?ZHlVaGMzckhGTkJpS0JPSGg5MVo3eXNrTmwwcTFXd2VhOFdNL1RRME9xRmV5?=
 =?utf-8?B?a3Y5b2Q0cUtCM1hnaFg2b3d0bGZMT3FGNTUwTGt5Yk1ya1RqMTVSQUJDa1NE?=
 =?utf-8?B?SENmREJQVXNkb0c5alVBSUhGeFMyZ3ZPeExKSHhSQUU2SkFhZ0NuNkFPcHV3?=
 =?utf-8?B?RWNnZnpLTjliL3ZmUGcxV3JKZUU3N1ZSUVgxd1cwQVBmYXVDbGEraUh2YkJ1?=
 =?utf-8?B?dmJXSkNLTUhZTnppdzR0MjZ5dkl5TE5USmgzTHVSQUtqdzJ2OXNiUXZWKzE5?=
 =?utf-8?B?TEFVTVBXYTFrZDltR0NWbG1CMEx1UjhPRlBzcmNQRzlpcGlzZ2s2REpTRUt0?=
 =?utf-8?B?S3RIUlMzZHZXS2hDVUo3d2VhWWlaV1FQdURJb0ZUNDAzMWNzbHdSSE1RRTFT?=
 =?utf-8?B?dm5jc1lGV1B6aEs4WXF5UXBKRit4bmhaWk9CL0M2LzNQaFpweTRRUk0xOXk2?=
 =?utf-8?B?MDljYkMzZzdoRjdXNmIxSGFwUGZhN3pMVFdSbGU3dFhJS2c2d1pvdXhLci9S?=
 =?utf-8?B?SFRMdlJzRTNJSkRGdnJDaWRneEdnM2pNa2E1NW9wVW9nQkJaY05WRllqK2ZE?=
 =?utf-8?B?ZUxZWmpjS3M3em9JaWlCaFc1b0JkMk5EMkxYWUVUcm9zd1c2bUNXVUdIZy9Q?=
 =?utf-8?B?a2tSaW9hMXNlSllvcHpPcWpLRVI5OGZweDVYVlQvNkxwb2hQUGlZdXFiMkZS?=
 =?utf-8?B?dVdocXQvZU9SbCtTSk96c0NSYjk4Q1FmaHpQV3plUHNoMHlPbjlrRklNTUhV?=
 =?utf-8?B?MWp6MkZYL2l6ZkVQNGJQaldPN1RyVUZCQmhZUEdCNkg5STErNzV3ZDlIMUlz?=
 =?utf-8?B?WVlCZGxKOEZIaXBEbzgrL3FSRWk4cHp2MWpOVmV1MEZuTzMwRmt6a2RrdFVX?=
 =?utf-8?B?Rnh3bVdhZmpvSS9aV0tJM3FaOWJBK3R2a3RqSVgzYW4yQldXYW9haDBUa29w?=
 =?utf-8?B?R0RuWVNQUlpDck1MSWdSYk1ENUZJM0g1eXI0L2xhTFNnNEhqWGgybzVXb1Jn?=
 =?utf-8?B?WXFmN281L3BSeUk5WGpYNHJCQ2xSVS8wSWNZYjIzR2V4QTlSbEVNY2ZrbC9r?=
 =?utf-8?B?cEhTNDIrYVZ6RTdFbysyUDMwU0h5TmkxSzhKMk9DbTBPbjdaWkhjd1NwTitU?=
 =?utf-8?B?RFBKN1lPZ2p6SmZFaGNXSytHRkZCbzNScVIzaVFxWE9aYUZOZ21CVVFoSE4v?=
 =?utf-8?B?eUFteFhCVTN1SUxUaTM3bDgzN3FiZDVTU2VKaWoybGlINERXN2h6RjFoYzIx?=
 =?utf-8?B?S2MvSENxSExOUmJRU2JwTExibkM0V1R2MGhEa0Z4c01vd1pud2lubi9Bd1NY?=
 =?utf-8?B?TzJ1Vi9YTHFYQTNCSjdFL3lFR2Jhc0NHK0JadXlKMkVxZzVjWFB0WS9RWXVv?=
 =?utf-8?B?cUc5NlNhNmRBOVgwUWVHbE5hblZOVDBrR0U0SGI2RTVQdUNkWEExYzRBNWpY?=
 =?utf-8?B?bWM5ZjlLYVlvMlNwcWRGTE1tUnRJazVkMzUyZFIxYWF3RjlJemNrM0Q5cW1R?=
 =?utf-8?Q?LshqkO1YkKfmi6wHleLpvZlp+5btupkM?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(10070799003)(376014)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Sk9qZ1I1QlBPcWVQcEJpOFhGQkVvbWZ2cytlVFpYMThEYWxNSnYzSlE5MTFK?=
 =?utf-8?B?SkxUclZPSnJwZTNJVUF1akcvRk5BOStKSEpyU2JFUFJBcFFkazBpdXZoU0kw?=
 =?utf-8?B?UGlXdUtvSFRCMXdMZmphcjhscjhYR29na1ZBMXpYOC9lOVhlYStrMy9LdGxC?=
 =?utf-8?B?Ym9wVWwvdUlrVHlWL1o3akY0Mngzd3dIS1pzTnBtYmlWZmV4ektWUHJTeGdm?=
 =?utf-8?B?MG9sd0VpLzY0LzVaekgrRjRIMCtDK0xYb2J5d2ViTlBuYThhSnRIeHloN3pr?=
 =?utf-8?B?V1RHK2RTZnlmSGlTSTVvYytZWDhLVkJLMkU2cDYxUFZ0WThBY1dTdzBvZFBh?=
 =?utf-8?B?cUdhS2sxWnVaOTI2NW03dnJJY0c1R29tNEJDNFRGS0lKbFlPb3piT1o1bkNW?=
 =?utf-8?B?cEZLK0NucUdXVkdLbmtYdlQyemtycCt4UVVpTGk4YVcvTWJoMlJWdVo4ZzBR?=
 =?utf-8?B?SktaVEVNTEdGbzVzWEV6dVEvU0FwdnFsNUhsc0oxQitxN1BUTjZDaXhteTRh?=
 =?utf-8?B?RTYrTEIxdnp6SFJnR0htMmNpTVR5MUpRUUU1MWRiaWdTVEc2M3p4Sno4YVVC?=
 =?utf-8?B?aE9WNGZsTllDekZzbEJnSmQ5eXVCVVI2bWREbjRmc09pVFpiQ2daQ0MySGU5?=
 =?utf-8?B?My9zb3Z2WFJDa0dxc0ZXYWlVQk5vL3BoK2t4dGZiNTEyUUw0R2trTnI5WFAz?=
 =?utf-8?B?SUpZbUhSTzcyVHQ0STgwWFJBMFdhVnhNM3RtYmFkcVFJNW9acWZHV2c0SW93?=
 =?utf-8?B?djQ3MzVTYW9LOUY1R0pxZzVoYVBPVmtqdzB4RllLaUx1OFAvdXhObURFbmJG?=
 =?utf-8?B?RUtwTE5YSFpZdzB1VmxTVGpOYVI3bEw4SFNxSDNibThMK1JDdWNHb0F6NWxs?=
 =?utf-8?B?V2NJR0t1cXVSUzJXdFpzTmh6UDdTWHI3V1lORDhhY0VVbjdiSEEwbndpUVZJ?=
 =?utf-8?B?cjNrNHZuUitCNm03VVc3RTVRTjNkOHhXN0s0eGJzN0ZJV29GSGk3Z1IzTEI5?=
 =?utf-8?B?a0NGRXZGOVo0bXh3dTd1Q21aN3l2cmtwTU1RbCtEb3kyUEMvYnpNcGpXUGV6?=
 =?utf-8?B?ek4wSlVpZ0VvSXFId3pJY0lSR09tWUw2SkpZb2lhWkJ3cjRlQjVpMkVJTnlV?=
 =?utf-8?B?QkRUSTRBd0RCWUxJRnVub3dYSUxhNXBBQWpxZ0FkakZpWDFLRjVjUHIwVWdV?=
 =?utf-8?B?K2E0VnFPdjF6ZWhwMUwvdWxSdG1WOEZINWczSFgrMVNCVDhJM29DYXdPYU01?=
 =?utf-8?B?a2Z6SnBiYTVxZjBoa1VBeW9zaVVoMHhhaTJHclpsN0NCMnFJckZRaThtSlF1?=
 =?utf-8?B?eHdXT2FVMXltQkhmTU1sUkN6dEF5R1VDNEVPdWUyMUlYandXNm9LTzhZR3dB?=
 =?utf-8?B?U2JremE2clltaENOeGtQMnk2SmczNm1FM3Vlc1VsZW45L1pncGdRamc2cGdN?=
 =?utf-8?B?RldCY05ITjFHMTN6WHdFZDYzS0ZEZWxPY2QxSXFjSEpiY1JqQmE5UFowZkxY?=
 =?utf-8?B?Rmk1NkRyd1ZRWU00aEtqM2F0cVNKQjVZQUZUWk5xUDdoSVFScXBVUkc5YTBU?=
 =?utf-8?B?MWxpcjNBMVQ3L25Vb3BSNkZzR3V2NkUrb3pyWmQ4SFU2cXVFazJ2b0RFOXlS?=
 =?utf-8?B?ZWxHODBsMm9EZXRMK29wQ1RQT2phNEhEcEprZFdEWWpNWWovOXkva1RwblRr?=
 =?utf-8?B?UXJDTHp0TTI4Uk40QjQ2VlFxbmR6YjNMUm5ZODh5YmVUNU5VNStkNGY2a0NR?=
 =?utf-8?B?akZXOCt0bzUzNXczRDExWFV6bE96bEoxSjd3U1IzSVhVS01zdnJGWWtHLzhl?=
 =?utf-8?B?d084alR6MFFUQmtya3dmamY4UDVMR0hMSGhKT3JqL2EzWit3Q2k4Sk9SZnl2?=
 =?utf-8?B?dWJWWWZLL3lRYUhrWFhQWGZoTlE3WXQ4Q3VnenQ4QzFjbjBmVGFIOU5OTmIz?=
 =?utf-8?B?dFdtVXRFWndsSlZaSTYraTM2S2JGRXVpMGRDOTRGTW81NDdnRW5UK0RDR2xE?=
 =?utf-8?B?UlJ1OU1VTUtJb2tFNm1mTlJVdTgzeVFnV1pMZmc1aFRjbjNjamFwOWFSY2xi?=
 =?utf-8?B?UmQwK2dFcS8vSnVMZjMrS09zbFJNWUN3UWFZNHB5UWQ2VnNVM2FuTHdKR0ly?=
 =?utf-8?B?RXhhUWNGZXRicGFVcUJvaHFLTEs2Mi9CM3R5Ym00ZXdUY01nd0g1a1hrU3Nq?=
 =?utf-8?B?UGt2VGR1akRXaGdkeko1V0pET2trQmRVTFNvcGoxUW9XMWVYbEhoVDFIYXQ1?=
 =?utf-8?B?eEVZaVpOK2FmNTVNc2Fhbk1iUHBBPT0=?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc6a3da9-bf04-4b4d-68f4-08de318f81bf
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2025 10:42:36.8470 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N6FcioOYXkJbHacmQO5ttyTpBsmM+bNGJ+FHLUAaVwHX1P6+UXw0Aid/UsTeR969m5rovmVt2axm2AWJtSsWNy7RG2QixRI1D/0d0lnb+/Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB7024
X-Proofpoint-ORIG-GUID: ND9gnh8GjmY8DDJZcx394idYdSKuUvmH
X-Authority-Analysis: v=2.4 cv=HboZjyE8 c=1 sm=1 tr=0 ts=692ec2a0 cx=c_pps
 a=X1VVRxfiHTEfX2nbyi9Czg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=64Cc0HZtAAAA:8 a=AbJxXvL0uaYAXSBtZ6cA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjAyMDA4NiBTYWx0ZWRfX3+ssCXOJC4YE
 6TppUxwMDyKUNPrQtCczNKJhE4wUy5L3IC4Q6lLbDeqfnlFIUBKA6hV82GxxtX2UfVnKZYgQumM
 ec2DGSPGeb1QlsUyMydJHcENl9j2FRB9K8K6z4hL7lzLk9NGZ0Exo0iJO2LHQt8+QOKf6VqqRPj
 lrlyYCZU+2wqHUpXlib6fdqZlqdWXwl3Un151ZATqRWSePcXWvM7W2b3biTYuOfOx1hFTn+G5ux
 oxOyOMLAA98EkqN8rlyEf1vgot7+AJFOeRLr9XI9numbRxkauD5k61fUcDA3oWZbYgEC16dRsbL
 IYzwo99YhOQMmGP+sGHh7cChYdD/SIbr6f3bsRXIs5xZWXAY7BrUdfL7j4kCkcmK25FdsU6055w
 xBzXR9U2TE/Yyi6b7mMXs20IGVzmcA==
X-Proofpoint-GUID: ND9gnh8GjmY8DDJZcx394idYdSKuUvmH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-01_01,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 01/12/2025 09:56, John Levon wrote:

> It can figure out if it's a reply by itself, rather than passing that
> information in.
> 
> Signed-off-by: John Levon <john.levon@nutanix.com>
> ---
>   hw/vfio-user/proxy.c | 11 ++++-------
>   1 file changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/vfio-user/proxy.c b/hw/vfio-user/proxy.c
> index bbd7ec243d..75845d7c89 100644
> --- a/hw/vfio-user/proxy.c
> +++ b/hw/vfio-user/proxy.c
> @@ -147,8 +147,7 @@ VFIOUserFDs *vfio_user_getfds(int numfds)
>   /*
>    * Process a received message.
>    */
> -static void vfio_user_process(VFIOUserProxy *proxy, VFIOUserMsg *msg,
> -                              bool isreply)
> +static void vfio_user_process(VFIOUserProxy *proxy, VFIOUserMsg *msg)
>   {
>   
>       /*
> @@ -157,7 +156,7 @@ static void vfio_user_process(VFIOUserProxy *proxy, VFIOUserMsg *msg,
>        *
>        * Requests get queued for the BH.
>        */
> -    if (isreply) {
> +    if ((msg->hdr->flags & VFIO_USER_TYPE) == VFIO_USER_REPLY) {
>           msg->complete = true;
>           if (msg->type == VFIO_MSG_WAIT) {
>               qemu_cond_signal(&msg->cv);
> @@ -187,7 +186,6 @@ static int vfio_user_complete(VFIOUserProxy *proxy, Error **errp)
>   {
>       VFIOUserMsg *msg = proxy->part_recv;
>       size_t msgleft = proxy->recv_left;
> -    bool isreply;
>       char *data;
>       int ret;
>   
> @@ -214,8 +212,7 @@ static int vfio_user_complete(VFIOUserProxy *proxy, Error **errp)
>        */
>       proxy->part_recv = NULL;
>       proxy->recv_left = 0;
> -    isreply = (msg->hdr->flags & VFIO_USER_TYPE) == VFIO_USER_REPLY;
> -    vfio_user_process(proxy, msg, isreply);
> +    vfio_user_process(proxy, msg);
>   
>       /* return positive value */
>       return 1;
> @@ -381,7 +378,7 @@ static int vfio_user_recv_one(VFIOUserProxy *proxy, Error **errp)
>           data += ret;
>       }
>   
> -    vfio_user_process(proxy, msg, isreply);
> +    vfio_user_process(proxy, msg);
>       return 0;
>   
>       /*

Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>


ATB,

Mark.


