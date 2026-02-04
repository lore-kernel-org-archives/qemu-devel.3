Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FD12E9538D
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 11:44:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnbIZ-0000Sw-5n; Wed, 04 Feb 2026 06:43:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vnbIX-0000Sm-NB
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 06:43:53 -0500
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vnbIV-0003X5-6O
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 06:43:53 -0500
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6145lIEn3065722; Wed, 4 Feb 2026 03:43:49 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=VmQnpepXKXt0NWo/6XvMWNQeGog2OYu5Wk29OViNu
 WY=; b=022obisNc+JuoQQZDvbb9CkGCjMGswKClF1bArGi8tVzt7hodHXBtsPUO
 Z6nYs5GZqkIEwZ/ahI/be1E4bJP0vJ2I0Qdp21yKE/a6aEzlhzF8Dye2A+HGXkLq
 6JkaYWKsTj3EglrDHz15DLIDHo8GmoN8Czk5Gx5Ynl2rbo0MVNkSjNQy3Efzhxis
 OkzZs6l8M9FeNvcYIr8jPEjxPy9IzCL4cpdJa5pfhbosuhdsjwShbu1wwQLEslOO
 Q0kuFNRF8MCkAdDSRA0X+ysCrOqH9W64d2udFbSfAH+DjfpsjLZn5UzTXbgH5CFA
 W5YEnCmW4MHmpF8/koFptQj+JEpVQ==
Received: from bn1pr04cu002.outbound.protection.outlook.com
 (mail-eastus2azon11020075.outbound.protection.outlook.com [52.101.56.75])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4c3aydkwh8-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 04 Feb 2026 03:43:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a2mJlFQnoivEKu/dJT5Vc5LpvYuML1vgmDg8c6eI+DWUBq65DpK4G/wBpD++Xq91dMkIwK5xKFHFV+p4sCAF3xhKssahQRTyO7ojbk5/lrNgULBlUp4Kt/iGn3Ds1tuop0RHLxN5qLjkNQnzw5CToQtzlW4YeQpaXyrkfufNjGQsNj45OhjbgEbDibDkbEB3WLiCfhy36hBUIoAE+OEOmZtVygXYjQ/gb4J/S3aA+Zbk8Gq/wwVQw7j+GOkd8X4Z06HNNlupKXdtU4rck30CxiLuKSOX7RSFV1WH6+yjv7hAFsDPUBcRWJmTxVzJkRGg2Dgzxa7M9ltEDumnuNpm7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VmQnpepXKXt0NWo/6XvMWNQeGog2OYu5Wk29OViNuWY=;
 b=IvBBQwYzq8PlgGunAajvj4ubUrEIIhy/wW/FCoPmH20IXgIPlVF9FKOFX4p/HCnBaJSSY+VB7lOI8+1RWCZnS++JRw5Q3SNEnFZRilwm3SoSrNh9lhD8BKv/PdbPdXTvSjSE7t/PRW/cAe3IkcyYTqT8ObKeal2FsGVfap1wV074ldKJ1dwZ+ItV7rd1Lj3neJa2SRqV1L4d4jYobAgzmQEmOamn0wfzb+6V68a+YuhRYRw9UUvMU+JkNcOkwAUxUb8gpTciUWzRFn4Cz8fTk3OutXIFLjqWdrt8vXjulxGWnXxN0xIVo5AtMwrfOnQYeaW9J6nr6X/plm9TZ8sVhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VmQnpepXKXt0NWo/6XvMWNQeGog2OYu5Wk29OViNuWY=;
 b=j7O19729AlThgL7CIM2DUEfrzxe7kr89OZ8svLjsq6PzaUePVxtQ8PZadI0B5TGxy3NaFmHCZ8bzEsx2R2KlKiDt0DcZ33Ji0eKRXe2TPzc4UmOuSsGKsrsPZWRgQNSO5zXNXcukqV9xMAmHnJlu9ErsibcSXgTR72VynX/dHv4uxqwbMbKfcBB07JLhEHetJQsi6+gPEJmENAOc3Fg7s+3Kz9fPLWYcWYCIFR3Xa1HV2yg9HU4xEx03jm7WCVzCxP55XG97ewy1loT81DGgBHQxbDrAY7m6vSoO+peKCTzQT+XPdmWA2eSpp5sXIuGT+xnyfyNDn4z/hljomRnvlA==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by DS7PR02MB10889.namprd02.prod.outlook.com (2603:10b6:8:269::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.12; Wed, 4 Feb
 2026 11:43:47 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%6]) with mapi id 15.20.9587.010; Wed, 4 Feb 2026
 11:43:47 +0000
Message-ID: <afc50b46-5559-45f8-8abc-59ee56908cec@nutanix.com>
Date: Wed, 4 Feb 2026 11:43:43 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 31/37] audio: make AudioBackend truly abstract
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>
References: <20260123074945.2563196-1-marcandre.lureau@redhat.com>
 <20260123074945.2563196-32-marcandre.lureau@redhat.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <20260123074945.2563196-32-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR10CA0014.namprd10.prod.outlook.com
 (2603:10b6:806:a7::19) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|DS7PR02MB10889:EE_
X-MS-Office365-Filtering-Correlation-Id: 740a88c8-4b2f-44ee-4a44-08de63e2a833
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V2kvVWZTWmF4VkxWb3hVTTNvVWJjUm44M3RoUHF0UkcvUHpCMEFMYzQ1eG95?=
 =?utf-8?B?SGc3WWJ1N2FtUFdoT2Z5SFgzNy9YWXBaUzUwMGZwYkN5akdXZXdNUVlnd0FJ?=
 =?utf-8?B?RGhrOGZrUk9jUk5LSDc2M3JrdlI2aGlkL0lUWHZ5WmpSZHF2dC8rRTdqRXVq?=
 =?utf-8?B?SENpSFlYNWx2RXBsTGlPeWt5T1RUbVdva014bHc1ZWVKWDNQUnlNRyt4SElY?=
 =?utf-8?B?WGx6RGF6Y0N1aEc5cUNUTlUxZ085ZWcxc0N3eGZYWlY5blB5U2ZMdHFUdTJx?=
 =?utf-8?B?UURzY3NUbzE3REU2QTRMRURhdzBGcFpvdUQ2Q0hWUjJPSGhSeDJhUnJPbVB4?=
 =?utf-8?B?cWNLVGFRWHZzV3pobnFrWUMzQjc1UGVqSStwNHNvdkVBakZJa2Mxam1EbzMy?=
 =?utf-8?B?TmhmUUhta3dqV3p6c2p5aXZDdUtVNEZvN0E2TFJQMkNjcklGbjZwNldhQVE4?=
 =?utf-8?B?UU54cHA3bkREZy9LQlV3bGIzVDBuUnlaNXBKWGZVSjZicjVaeTN1WGlKWVZ2?=
 =?utf-8?B?Vitra0J4ZS9tTi9XbjUrQ1RZTHFHU0ZTTGZqSmtuK2s5YmN0RGF6RnlHenRK?=
 =?utf-8?B?VWZoVVRwVEgxZFFSY3FrbjRETXRLRnNpUnZSWVZIZVM4ZzZaNURKaVYyWXZT?=
 =?utf-8?B?SnI4U0JNSldzWE9UWW55NVdzeWN2ZTZtaFJXbTZPK2JHUEZHcERuQjdsNXdm?=
 =?utf-8?B?TmNCOTNoWTMvSGJVTlNjbjhsa1VHRDdkY05EVENKNGk0eVY4eXlsaFVIVVZZ?=
 =?utf-8?B?RjdKSzVZNzlFOUtRV2l1MkZwUG1LeXVBT0JXcU9uaFV5UFZwdk54MEtjUkNR?=
 =?utf-8?B?UnZVRU1hZkpXTkFDNjBVampGN2Vic0czTjkxenlIL2VQcjlKQkUzd3pwNGdK?=
 =?utf-8?B?SFIrL211akdocUxmQjZXWHVuc2dOTXc5QjhVN3hBemxoYjlwTFU4czUzdDNF?=
 =?utf-8?B?RytWQXhvUmc1bXpCQzhMbjZiZjdpSXZ6Y2lXSzdEN1RPZDFGOVdGdjkyTTJp?=
 =?utf-8?B?bnZBcXNmUWkyaFZmYUJtMXVMRWk4VnZZYnFXTTlwZlNaWmJlcXpTdXFQOGxY?=
 =?utf-8?B?Mkh4eTlyTVUvRTg5YkdqRVoxbVJWUGNCSFIxTWJZNVNiWGVkRVNucGswUjRq?=
 =?utf-8?B?MUxqQTROODBwTCtmclkwNndFcWZ6b3EzejlrNWxHbmlvN1dycTJYS2U1ZnJk?=
 =?utf-8?B?bHpudmNCR2pjQ2trSy9jVUZOQ1RvZithUm9zWUV4dkVBaHA2ZXlRQlE4Rk9j?=
 =?utf-8?B?V2tqR0xlUCs2ajVEd1lraWF0R296YllVeHhCaWxmSWE2RG1qSjQxTWdTamo1?=
 =?utf-8?B?ZjRUT3NtN3g0cFVUNUR6bllmbS92cHR6ZjBVbTd6b3p6NlF1T2kvamplaUlH?=
 =?utf-8?B?dUxtaVYzT1BhNk11dFZMTU5xN3hFczNGdkd2MEY0emY0Q0ttakI1blMrdnVk?=
 =?utf-8?B?N0N3UEZ0dUFxNlpmdmZjR2tMNXBoSFBFUkJNZzNkbll1RHdBQmpiQnl1UGdx?=
 =?utf-8?B?cDdzUmVrSmlBci9WV3RPUGZWQU9sOWJYL3Q4R2xRaWhlbE9ZOVVSUDIzS0sx?=
 =?utf-8?B?dVlKb2g0UDBpSjdkUXh3c2N0VFM2KytjakI3M2xPSnNBY0QrK2l1YUZ4cnUr?=
 =?utf-8?B?OVRMRlhlWStuVnhQV1JSSEdhb2RoV21qdVJZcXJPWjNSRkZiSmhrMFovQ2pD?=
 =?utf-8?B?MjU1Tkl4V1d2NmlVTUR3cHVwTEZBTG1MNmN1OTkzTzlIWW1ycmtPVm51eWFM?=
 =?utf-8?B?R1M2bmRBVVY3a1hnWGtZVVZIWWVMLzB3N09PVzBFWnZkQWVnWWw1OVRFZHh3?=
 =?utf-8?B?a3E4dnlCcnpkb2crc1lZdG5FMHJ5RjdkSzZ6NjMwNUk4YmZDVEpjYXUzcXp6?=
 =?utf-8?B?dWR0UFppZGVtQmJIVnFoNUUzeGNYa1dtaWJxUm9MTVRDK3lBTmlQcVlZaVRz?=
 =?utf-8?B?OTk4WTJLb3NudHo4cVlSVk1LaFI4YjdWTEJZeEI5V0ZBWUFUcXVBdTBWQ3Jt?=
 =?utf-8?B?dkRQS2wvQlQ1aGxEV1RNTXVyb2FsZlRCcVNSZ3MzRHp2aWlIeGo5eXdjcUlU?=
 =?utf-8?B?MEZuRzRxNWRXZk5mMVJwRXZoTnVacFo2RVZKT3dYbWlPVWNDbnJFYzg5cUtx?=
 =?utf-8?Q?chVI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WVFJRm5QbHZDdHlMcHVvaXN3cmIzYmNwSVRGb2w0S2kwdEQxWWxHbmlQeHhW?=
 =?utf-8?B?SEZXMnNMR2Q4d05kQ2RpcnljRUNoTlM1YU4wUit6VE1pU2Rmb0hrNFVwZERh?=
 =?utf-8?B?OWxGV0lpZGR0UmppbUNwb25SQWdmMmpwOW5Kc2xrRGZObWJzWTd1SVVETVZt?=
 =?utf-8?B?T1BIK3ZoNC82cnEwSEZMcUE0WEpxcmxkZHdMTWY2Q1A0aHFEb2QxM043ekFu?=
 =?utf-8?B?WTloZmhnMzFqYUIzamFuZ2k3NCtnaTNFREtrTSs2U1JBYk1uSzgvMmZVVzVi?=
 =?utf-8?B?azVKR3B2SktGT1RXcWZ5VExMWm4zbTZqVDVEODl6YlhBU3hySUZ3cEtMMllF?=
 =?utf-8?B?STdMalduVnRkOVU3VTBjNVp4aWJ6V3ZxNFYwV2tLRTVkdkdjcXBKMDg5UmRZ?=
 =?utf-8?B?VmlUS1BnZFlLSlBZb2lkOUJxWXRicmVoZDdzbXJPS0NNb1Bzdkt2TnNIZGVm?=
 =?utf-8?B?cDloT1FMblFROURYL1RtdGtZcWhQdGZqUzJXS1Vtdk5LbjFFc3Q2ekw5N3hC?=
 =?utf-8?B?WDFjNzRDRkpzbmgyS0FtMGdHSXcxZUViU1N1T1Zwajd5Nk9BVThZd0hJa1lG?=
 =?utf-8?B?aXkzRHl4YXR2ckc4MDF1Vm85L1F4elFUNmNSTEdaUjFyVlJpOHlMdTNyOTNR?=
 =?utf-8?B?UWxnQ0YyY3cwTG55RXNDSFlpUjcyTmhqZE5vc0krMnd3MTFTeTdsSzRGWnZ2?=
 =?utf-8?B?NHRxSnhtUWNYMHdzTXNuamxVZkJ5R0M2YjZMVE1Qb0JHNVp0N3VCUElVTXpB?=
 =?utf-8?B?UmpDS3pnblBYR0tMaCs1bXZ3eGJNTXdqZzZYS2VISkZ5VnFlR0xDYkhLVzlh?=
 =?utf-8?B?Y3lUUFh2VmVWT0ZseTd6V2tDbUl5K1NFT1hLb1NubnFsSW4wWHFBTmRNVHo0?=
 =?utf-8?B?KzlRRHEyYzJLaXczeTNPcVdEYmRiSnlXcmZ6VEt5K3UvK2xTQTZ0QjhRYURS?=
 =?utf-8?B?V0V0MlZqWGZDQ0JRbUlBYkpKQ21lUTNuUkM0UTNVdFNFdXpRbHQwYWZRNkFo?=
 =?utf-8?B?bVFTS0tVYmJZMzl1QmxyUDl5UHhkMzlUUjl4VHVSejRnQlVwL3pKQkJiVE5o?=
 =?utf-8?B?eSt4a0Z5SUNUQWprMklFaTJ4WGxmN3VFUkdjR0FPV3Y2TW9DcDRQdDJwOU9o?=
 =?utf-8?B?WDVKbURpYkp2MUUvR0MrYmJNbXk0OERJUUU1c3lhc0lkVGNDNWRTSXJuWnpi?=
 =?utf-8?B?aDIxNjAzQTNFaG4rRlFqcVkvcC9RaEtCeTFaUzVnM2ZGOW9BVnEzaHd6Q3g5?=
 =?utf-8?B?TmxIak42UU9VUy9LVFdicEVRbE1IYkJiYmh1M3V4Y1c1cVI1WDZnbWZtcElt?=
 =?utf-8?B?S1Qxb2xNckg5REN4REROVk9iZ3J3WTN0K0pndENBZUZwZ1NFd2lvdUVMbEdQ?=
 =?utf-8?B?ajFwc3VlTFFYZDcyRjh2NG92VmFSNTlSUVhZSTBhSXBWbzVqL0psdVNrdTBz?=
 =?utf-8?B?a04vRmFpWFlvdE1sWCtmZEZMWlZoQUxyMVZ6MVpLbFRLRU9WNnZTWTZ3S0NE?=
 =?utf-8?B?SUtzdGpJaXBkakdKR0tCalZ4TzJWczJoY2dPTWVxMGtLNzFPSzFONno5N1U1?=
 =?utf-8?B?MG1sTVFQTXBGR1pudm5LY1ZDN2l5eUs3TjlJNldaWUkvMERKSTQzWFNrejZL?=
 =?utf-8?B?VGpWTld2Y1J6aE5DWjFXZ0pwM2NhbUxKcURLNkZQKzFOblpzQk5rNlV1ak9u?=
 =?utf-8?B?Nmc0SXk5a0R0b3ZCdkQ4UWxLVXVEK0NEUjVNeHYzQTZKTmJOdzdvYXY0T3Uw?=
 =?utf-8?B?YXF4dFBleW55cFV1Wm5nOWRsUThyZVlteTFEdTBtalMzdjVlRHBXdm5Bb1RS?=
 =?utf-8?B?ck9rRXZGS1pyZU05NG5QR1p4VlFvSjJFYjNSRk5EcU9ZTnhxZHFYN0dmblZx?=
 =?utf-8?B?UzA5dkJoQkljb1Bqem93ZnQ2N3RzYmRrZmpOcUljcUVhSGhReElrMXo0VEVY?=
 =?utf-8?B?US9vYi9CM3hJVlRvbEx0OVR1MGk5WndGdk9MRUl6VGdYdWJjOG52Q3pGMUx5?=
 =?utf-8?B?TkY2NkFSdHMydDVUeFpFTVZmejhtRXc5dFRCVDhRbVk0VzhKaHo5MXBYTmtT?=
 =?utf-8?B?Sm5xaHNDRUlRQWNSTHFoMkZWWm40TXdWQnpESTAwK3hmM05BOWVYRDdkeEFp?=
 =?utf-8?B?a1pZZDVzeENnQlJLL25Ka3ZIN1A5TUhzem5aZmZDUWdOcVlFb05sYVZCcmtw?=
 =?utf-8?B?a2VyZVpIREpqbDIvajg0TXRIaENMVlNySWNmQWp0S09QTHl4UUg2Y2ZmV2RZ?=
 =?utf-8?B?MjBaOUJTOFpPYm5kSXVTSnRCa0NXTUkvWkU3UWtCcjRSaENOV0pBaHl6WTBF?=
 =?utf-8?B?bmJ5ZDNpLzcyRDQ4YzZBN0FmbXo5ZFZDWEEwTTJaeE9XT3lEOFA2S2daRVND?=
 =?utf-8?Q?OXb3GQj/Dzj0q42s=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 740a88c8-4b2f-44ee-4a44-08de63e2a833
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 11:43:46.9909 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2JUW2VMCvr4kD+zmXJnZBnY3CTdMk+A1OdwoJAxZ/J1R4EawC8E9uF64kTeMIdpbuKIgofrblcsatAO6EK0dvQEnkTyFG+P0yFf1ukKG+sM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR02MB10889
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA0MDA4OCBTYWx0ZWRfX0QeaPfO3e7xR
 8aqEqhRb2VhbJyyxEjT9BERXGEgsfCzMsme7+MXsaMjDmnB5qIeaG70HszySFDrJZG/dIuB06q9
 TwTNf1vPa27D59RdmSw2mxj02TG43eZ8p/8TL3dvEYbJiktFLqbDcA8j7QBMGgyRU51NJe7uxtG
 JQLKBxKuuxjBZmSdWfhSJn/sIHWnIFmSq1irEsUOTQdMPCld/G3wRrektZtDouG63eY2D6FPtlN
 6m7H+X2BWToea/8OBVwLyWt6pg8NYU+zCd4HJcz8z4IZZjt7ZWSyRHGOV2LzRgwwc+TuuVocn48
 DgO599miNCQOSx5Bp+W0s1cOS+Ol67bd+yb/AmIsc1Vbie1G0OJ+vXj8CnrldD8BYZIctCcc7hk
 B6lXNYiS0FU9mD6ljC7dw2Gw+aFEEeXk3iMg/inLtPRc0oNPxn8jMlCeDC1Y1xfF7w4BjaaB1Z0
 nkZ82TWW58ReHzwQUvA==
X-Proofpoint-GUID: XFNwAcAqmn9O4u2RG4NF_6r2CVLBW8w7
X-Proofpoint-ORIG-GUID: XFNwAcAqmn9O4u2RG4NF_6r2CVLBW8w7
X-Authority-Analysis: v=2.4 cv=AeC83nXG c=1 sm=1 tr=0 ts=698330f5 cx=c_pps
 a=JPYgw6djPvulOwJF0XPiqQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=20KFwNOVAAAA:8 a=64Cc0HZtAAAA:8
 a=FyXq0C3BlMmEOpRjgo8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-04_02,2026-02-04_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
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

On 23/01/2026 07:49, marcandre.lureau@redhat.com wrote:

> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Add virtual methods to be implemented by concrete classes, like
> AudioMixengBackendClass.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   audio/audio_template.h       |   9 +-
>   include/qemu/audio-capture.h |  13 ---
>   include/qemu/audio.h         |  58 +++++++++--
>   audio/audio.c                | 187 ++++++++++++++++++++++++++++++++---
>   4 files changed, 227 insertions(+), 40 deletions(-)
> 
> diff --git a/audio/audio_template.h b/audio/audio_template.h
> index 33f2ff432eb..a7733f9e1d9 100644
> --- a/audio/audio_template.h
> +++ b/audio/audio_template.h
> @@ -478,7 +478,7 @@ static void glue (audio_close_, TYPE) (SW *sw)
>       g_free (sw);
>   }
>   
> -void glue(AUD_close_, TYPE)(AudioBackend *be, SW *sw)
> +static void glue(audio_mixeng_backend_close_, TYPE)(AudioBackend *be, SW *sw)
>   {
>       if (sw) {
>           if (audio_bug(__func__, !be)) {
> @@ -490,14 +490,13 @@ void glue(AUD_close_, TYPE)(AudioBackend *be, SW *sw)
>       }
>   }
>   
> -SW *glue (AUD_open_, TYPE) (
> +static SW *glue(audio_mixeng_backend_open_, TYPE) (
>       AudioBackend *be,
>       SW *sw,
>       const char *name,
>       void *callback_opaque ,
>       audio_callback_fn callback_fn,
> -    const struct audsettings *as
> -    )
> +    const struct audsettings *as)
>   {
>       AudioMixengBackend *s = AUDIO_MIXENG_BACKEND(be);
>       AudiodevPerDirectionOptions *pdo;
> @@ -569,7 +568,7 @@ SW *glue (AUD_open_, TYPE) (
>       return NULL;
>   }
>   
> -bool glue(AUD_is_active_, TYPE)(AudioBackend *be, SW *sw)
> +static bool glue(audio_mixeng_backend_is_active_, TYPE)(AudioBackend *be, SW *sw)
>   {
>       return sw ? sw->active : 0;
>   }
> diff --git a/include/qemu/audio-capture.h b/include/qemu/audio-capture.h
> index f500b0a7f8c..5bfbdd02985 100644
> --- a/include/qemu/audio-capture.h
> +++ b/include/qemu/audio-capture.h
> @@ -8,19 +8,6 @@
>   
>   #include "audio.h"
>   
> -typedef struct CaptureVoiceOut CaptureVoiceOut;
> -
> -typedef enum {
> -    AUD_CNOTIFY_ENABLE,
> -    AUD_CNOTIFY_DISABLE
> -} audcnotification_e;
> -
> -struct audio_capture_ops {
> -    void (*notify) (void *opaque, audcnotification_e cmd);
> -    void (*capture) (void *opaque, const void *buf, int size);
> -    void (*destroy) (void *opaque);
> -};
> -
>   struct capture_ops {
>       void (*info) (void *opaque);
>       void (*destroy) (void *opaque);
> diff --git a/include/qemu/audio.h b/include/qemu/audio.h
> index e87708e3d1e..4fae48886ba 100644
> --- a/include/qemu/audio.h
> +++ b/include/qemu/audio.h
> @@ -43,6 +43,25 @@ typedef struct audsettings {
>   
>   typedef struct SWVoiceOut SWVoiceOut;
>   typedef struct SWVoiceIn SWVoiceIn;
> +typedef struct CaptureVoiceOut CaptureVoiceOut;
> +
> +typedef enum {
> +    AUD_CNOTIFY_ENABLE,
> +    AUD_CNOTIFY_DISABLE
> +} audcnotification_e;
> +
> +struct audio_capture_ops {
> +    void (*notify) (void *opaque, audcnotification_e cmd);
> +    void (*capture) (void *opaque, const void *buf, int size);
> +    void (*destroy) (void *opaque);
> +};
> +
> +#define AUDIO_MAX_CHANNELS 16
> +typedef struct Volume {
> +    bool mute;
> +    int channels;
> +    uint8_t vol[AUDIO_MAX_CHANNELS];
> +} Volume;
>   
>   typedef struct AudioBackend {
>       Object parent_obj;
> @@ -53,6 +72,35 @@ typedef struct AudioBackendClass {
>   
>       bool (*realize)(AudioBackend *be, Audiodev *dev, Error **errp);
>       const char *(*get_id)(AudioBackend *be);
> +    SWVoiceOut *(*open_out)(AudioBackend *be,
> +                            SWVoiceOut *sw,
> +                            const char *name,
> +                            void *callback_opaque,
> +                            audio_callback_fn callback_fn,
> +                            const struct audsettings *as);
> +    SWVoiceIn *(*open_in)(AudioBackend *be,
> +                          SWVoiceIn *sw,
> +                          const char *name,
> +                          void *callback_opaque,
> +                          audio_callback_fn callback_fn,
> +                          const struct audsettings *as);
> +    void (*close_out)(AudioBackend *be, SWVoiceOut *sw);
> +    void (*close_in)(AudioBackend *be, SWVoiceIn *sw);
> +    bool (*is_active_out)(AudioBackend *be, SWVoiceOut *sw);
> +    bool (*is_active_in)(AudioBackend *be, SWVoiceIn *sw);
> +    void (*set_active_out)(AudioBackend *be, SWVoiceOut *sw, bool on);
> +    void (*set_active_in)(AudioBackend *be, SWVoiceIn *sw, bool on);
> +    void (*set_volume_out)(AudioBackend *be, SWVoiceOut *sw, Volume *vol);
> +    void (*set_volume_in)(AudioBackend *be, SWVoiceIn *sw, Volume *vol);
> +    size_t (*write)(AudioBackend *be, SWVoiceOut *sw, void *buf, size_t size);
> +    size_t (*read)(AudioBackend *be, SWVoiceIn *sw, void *buf, size_t size);
> +    int (*get_buffer_size_out)(AudioBackend *be, SWVoiceOut *sw);
> +    CaptureVoiceOut *(*add_capture)(AudioBackend *be,
> +                                    struct audsettings *as,
> +                                    struct audio_capture_ops *ops,
> +                                    void *cb_opaque);
> +    void (*del_capture)(AudioBackend *be, CaptureVoiceOut *cap, void *cb_opaque);
> +
>   #ifdef CONFIG_GIO
>       bool (*set_dbus_server)(AudioBackend *be,
>                               GDBusObjectManagerServer *manager,
> @@ -69,8 +117,7 @@ SWVoiceOut *AUD_open_out(
>       const char *name,
>       void *callback_opaque,
>       audio_callback_fn callback_fn,
> -    const struct audsettings *settings
> -    );
> +    const struct audsettings *settings);
>   
>   void AUD_close_out(AudioBackend *be, SWVoiceOut *sw);
>   size_t AUD_write(AudioBackend *be, SWVoiceOut *sw, void *pcm_buf, size_t size);
> @@ -78,13 +125,6 @@ int  AUD_get_buffer_size_out(AudioBackend *be, SWVoiceOut *sw);
>   void AUD_set_active_out(AudioBackend *be, SWVoiceOut *sw, bool on);
>   bool AUD_is_active_out(AudioBackend *be, SWVoiceOut *sw);
>   
> -#define AUDIO_MAX_CHANNELS 16
> -typedef struct Volume {
> -    bool mute;
> -    int channels;
> -    uint8_t vol[AUDIO_MAX_CHANNELS];
> -} Volume;
> -
>   void AUD_set_volume_out(AudioBackend *be, SWVoiceOut *sw, Volume *vol);
>   void AUD_set_volume_in(AudioBackend *be, SWVoiceIn *sw, Volume *vol);
>   
> diff --git a/audio/audio.c b/audio/audio.c
> index 6bfec5e1d75..3f09452e300 100644
> --- a/audio/audio.c
> +++ b/audio/audio.c
> @@ -846,7 +846,8 @@ static void audio_timer (void *opaque)
>   /*
>    * Public API
>    */
> -size_t AUD_write(AudioBackend *be, SWVoiceOut *sw, void *buf, size_t size)
> +static size_t audio_mixeng_backend_write(AudioBackend *be, SWVoiceOut *sw,
> +                                         void *buf, size_t size)
>   {
>       HWVoiceOut *hw;
>   
> @@ -857,7 +858,7 @@ size_t AUD_write(AudioBackend *be, SWVoiceOut *sw, void *buf, size_t size)
>       hw = sw->hw;
>   
>       if (!hw->enabled) {
> -        dolog ("Writing to disabled voice %s\n", SW_NAME (sw));
> +        dolog("Writing to disabled voice %s\n", SW_NAME(sw));
>           return 0;
>       }
>   
> @@ -868,7 +869,15 @@ size_t AUD_write(AudioBackend *be, SWVoiceOut *sw, void *buf, size_t size)
>       }
>   }
>   
> -size_t AUD_read(AudioBackend *be, SWVoiceIn *sw, void *buf, size_t size)
> +size_t AUD_write(AudioBackend *be, SWVoiceOut *sw, void *buf, size_t size)
> +{
> +    AudioBackendClass *klass = AUDIO_BACKEND_GET_CLASS(be);
> +
> +    return klass->write(be, sw, buf, size);
> +}
> +
> +static size_t audio_mixeng_backend_read(AudioBackend *be, SWVoiceIn *sw,
> +                                        void *buf, size_t size)
>   {
>       HWVoiceIn *hw;
>   
> @@ -879,7 +888,7 @@ size_t AUD_read(AudioBackend *be, SWVoiceIn *sw, void *buf, size_t size)
>       hw = sw->hw;
>   
>       if (!hw->enabled) {
> -        dolog ("Reading from disabled voice %s\n", SW_NAME (sw));
> +        dolog("Reading from disabled voice %s\n", SW_NAME(sw));
>           return 0;
>       }
>   
> @@ -888,9 +897,17 @@ size_t AUD_read(AudioBackend *be, SWVoiceIn *sw, void *buf, size_t size)
>       } else {
>           return hw->pcm_ops->read(hw, buf, size);
>       }
> +
>   }
>   
> -int AUD_get_buffer_size_out(AudioBackend *be, SWVoiceOut *sw)
> +size_t AUD_read(AudioBackend *be, SWVoiceIn *sw, void *buf, size_t size)
> +{
> +    AudioBackendClass *klass = AUDIO_BACKEND_GET_CLASS(be);
> +
> +    return klass->read(be, sw, buf, size);
> +}
> +
> +static int audio_mixeng_backend_get_buffer_size_out(AudioBackend *be, SWVoiceOut *sw)
>   {
>       if (!sw) {
>           return 0;
> @@ -903,7 +920,15 @@ int AUD_get_buffer_size_out(AudioBackend *be, SWVoiceOut *sw)
>       return sw->hw->samples * sw->hw->info.bytes_per_frame;
>   }
>   
> -void AUD_set_active_out(AudioBackend *be, SWVoiceOut *sw, bool on)
> +int AUD_get_buffer_size_out(AudioBackend *be, SWVoiceOut *sw)
> +{
> +    AudioBackendClass *klass = AUDIO_BACKEND_GET_CLASS(be);
> +
> +    return klass->get_buffer_size_out(be, sw);
> +}
> +
> +static void audio_mixeng_backend_set_active_out(AudioBackend *be, SWVoiceOut *sw,
> +                                                bool on)
>   {
>       HWVoiceOut *hw;
>   
> @@ -949,9 +974,17 @@ void AUD_set_active_out(AudioBackend *be, SWVoiceOut *sw, bool on)
>           }
>           sw->active = on;
>       }
> +
>   }
>   
> -void AUD_set_active_in(AudioBackend *be, SWVoiceIn *sw, bool on)
> +void AUD_set_active_out(AudioBackend *be, SWVoiceOut *sw, bool on)
> +{
> +    AudioBackendClass *klass = AUDIO_BACKEND_GET_CLASS(be);
> +
> +    return klass->set_active_out(be, sw, on);
> +}
> +
> +static void audio_mixeng_backend_set_active_in(AudioBackend *be, SWVoiceIn *sw, bool on)
>   {
>       HWVoiceIn *hw;
>   
> @@ -996,6 +1029,13 @@ void AUD_set_active_in(AudioBackend *be, SWVoiceIn *sw, bool on)
>       }
>   }
>   
> +void AUD_set_active_in(AudioBackend *be, SWVoiceIn *sw, bool on)
> +{
> +    AudioBackendClass *klass = AUDIO_BACKEND_GET_CLASS(be);
> +
> +    return klass->set_active_in(be, sw, on);
> +}
> +
>   static size_t audio_get_avail(SWVoiceIn *sw)
>   {
>       size_t live;
> @@ -1657,12 +1697,97 @@ static const char *audio_mixeng_backend_get_id(AudioBackend *be)
>       return AUDIO_MIXENG_BACKEND(be)->dev->id;
>   }
>   
> +static CaptureVoiceOut *audio_mixeng_backend_add_capture(
> +    AudioBackend *be,
> +    struct audsettings *as,
> +    struct audio_capture_ops *ops,
> +    void *cb_opaque);
> +
> +static void audio_mixeng_backend_del_capture(
> +    AudioBackend *be,
> +    CaptureVoiceOut *cap,
> +    void *cb_opaque);
> +
> +static void audio_mixeng_backend_set_volume_out(AudioBackend *be, SWVoiceOut *sw,
> +                                                Volume *vol);
> +static void audio_mixeng_backend_set_volume_in(AudioBackend *be, SWVoiceIn *sw,
> +                                               Volume *vol);
> +
> +SWVoiceOut *AUD_open_out(
> +    AudioBackend *be,
> +    SWVoiceOut *sw,
> +    const char *name,
> +    void *callback_opaque,
> +    audio_callback_fn callback_fn,
> +    const struct audsettings *as)
> +{
> +    AudioBackendClass *klass = AUDIO_BACKEND_GET_CLASS(be);
> +
> +    return klass->open_out(be, sw, name, callback_opaque, callback_fn, as);
> +}
> +
> +SWVoiceIn *AUD_open_in(
> +    AudioBackend *be,
> +    SWVoiceIn *sw,
> +    const char *name,
> +    void *callback_opaque,
> +    audio_callback_fn callback_fn,
> +    const struct audsettings *as)
> +{
> +    AudioBackendClass *klass = AUDIO_BACKEND_GET_CLASS(be);
> +
> +    return klass->open_in(be, sw, name, callback_opaque, callback_fn, as);
> +}
> +
> +void AUD_close_out(AudioBackend *be, SWVoiceOut *sw)
> +{
> +    AudioBackendClass *klass = AUDIO_BACKEND_GET_CLASS(be);
> +
> +    return klass->close_out(be, sw);
> +}
> +
> +void AUD_close_in(AudioBackend *be, SWVoiceIn *sw)
> +{
> +    AudioBackendClass *klass = AUDIO_BACKEND_GET_CLASS(be);
> +
> +    return klass->close_in(be, sw);
> +}
> +
> +bool AUD_is_active_out(AudioBackend *be, SWVoiceOut *sw)
> +{
> +    AudioBackendClass *klass = AUDIO_BACKEND_GET_CLASS(be);
> +
> +    return klass->is_active_out(be, sw);
> +}
> +
> +bool AUD_is_active_in(AudioBackend *be, SWVoiceIn *sw)
> +{
> +    AudioBackendClass *klass = AUDIO_BACKEND_GET_CLASS(be);
> +
> +    return klass->is_active_in(be, sw);
> +}
> +
>   static void audio_mixeng_backend_class_init(ObjectClass *klass, const void *data)
>   {
>       AudioBackendClass *be = AUDIO_BACKEND_CLASS(klass);
>   
>       be->realize = audio_mixeng_backend_realize;
>       be->get_id = audio_mixeng_backend_get_id;
> +    be->open_in = audio_mixeng_backend_open_in;
> +    be->open_out = audio_mixeng_backend_open_out;
> +    be->close_in = audio_mixeng_backend_close_in;
> +    be->close_out = audio_mixeng_backend_close_out;
> +    be->is_active_out = audio_mixeng_backend_is_active_out;
> +    be->is_active_in = audio_mixeng_backend_is_active_in;
> +    be->set_active_out = audio_mixeng_backend_set_active_out;
> +    be->set_active_in = audio_mixeng_backend_set_active_in;
> +    be->set_volume_out = audio_mixeng_backend_set_volume_out;
> +    be->set_volume_in = audio_mixeng_backend_set_volume_in;
> +    be->read = audio_mixeng_backend_read;
> +    be->write = audio_mixeng_backend_write;
> +    be->get_buffer_size_out = audio_mixeng_backend_get_buffer_size_out;
> +    be->add_capture = audio_mixeng_backend_add_capture;
> +    be->del_capture = audio_mixeng_backend_del_capture;
>   }
>   
>   static void audio_mixeng_backend_init(Object *obj)
> @@ -1862,12 +1987,11 @@ bool AUD_backend_check(AudioBackend **be, Error **errp)
>   
>   static struct audio_pcm_ops capture_pcm_ops;
>   
> -CaptureVoiceOut *AUD_add_capture(
> +static CaptureVoiceOut *audio_mixeng_backend_add_capture(
>       AudioBackend *be,
>       struct audsettings *as,
>       struct audio_capture_ops *ops,
> -    void *cb_opaque
> -    )
> +    void *cb_opaque)
>   {
>       AudioMixengBackend *s = AUDIO_MIXENG_BACKEND(be);
>       CaptureVoiceOut *cap;
> @@ -1937,7 +2061,21 @@ CaptureVoiceOut *AUD_add_capture(
>       return cap;
>   }
>   
> -void AUD_del_capture(AudioBackend *be, CaptureVoiceOut *cap, void *cb_opaque)
> +CaptureVoiceOut *AUD_add_capture(
> +    AudioBackend *be,
> +    struct audsettings *as,
> +    struct audio_capture_ops *ops,
> +    void *cb_opaque)
> +{
> +    AudioBackendClass *klass = AUDIO_BACKEND_GET_CLASS(be);
> +
> +    return klass->add_capture(be, as, ops, cb_opaque);
> +}
> +
> +static void audio_mixeng_backend_del_capture(
> +    AudioBackend *be,
> +    CaptureVoiceOut *cap,
> +    void *cb_opaque)
>   {
>       struct capture_callback *cb;
>   
> @@ -1976,7 +2114,15 @@ void AUD_del_capture(AudioBackend *be, CaptureVoiceOut *cap, void *cb_opaque)
>       }
>   }
>   
> -void AUD_set_volume_out(AudioBackend *be, SWVoiceOut *sw, Volume *vol)
> +void AUD_del_capture(AudioBackend *be, CaptureVoiceOut *cap, void *cb_opaque)
> +{
> +    AudioBackendClass *klass = AUDIO_BACKEND_GET_CLASS(be);
> +
> +    klass->del_capture(be, cap, cb_opaque);
> +}
> +
> +static void audio_mixeng_backend_set_volume_out(AudioBackend *be, SWVoiceOut *sw,
> +                                                Volume *vol)
>   {
>       if (sw) {
>           HWVoiceOut *hw = sw->hw;
> @@ -1992,7 +2138,15 @@ void AUD_set_volume_out(AudioBackend *be, SWVoiceOut *sw, Volume *vol)
>       }
>   }
>   
> -void AUD_set_volume_in(AudioBackend *be, SWVoiceIn *sw, Volume *vol)
> +void AUD_set_volume_out(AudioBackend *be, SWVoiceOut *sw, Volume *vol)
> +{
> +    AudioBackendClass *klass = AUDIO_BACKEND_GET_CLASS(be);
> +
> +    klass->set_volume_out(be, sw, vol);
> +}
> +
> +static void audio_mixeng_backend_set_volume_in(AudioBackend *be, SWVoiceIn *sw,
> +                                               Volume *vol)
>   {
>       if (sw) {
>           HWVoiceIn *hw = sw->hw;
> @@ -2008,6 +2162,13 @@ void AUD_set_volume_in(AudioBackend *be, SWVoiceIn *sw, Volume *vol)
>       }
>   }
>   
> +void AUD_set_volume_in(AudioBackend *be, SWVoiceIn *sw, Volume *vol)
> +{
> +    AudioBackendClass *klass = AUDIO_BACKEND_GET_CLASS(be);
> +
> +    klass->set_volume_in(be, sw, vol);
> +}
> +
>   static void audio_create_pdos(Audiodev *dev)
>   {
>       switch (dev->driver) {

Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>


ATB,

Mark.


