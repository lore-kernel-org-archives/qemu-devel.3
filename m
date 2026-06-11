Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E7D4CD98CE
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 14:09:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXg5w-0007Qf-SB; Thu, 11 Jun 2026 10:09:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wXg5n-0007Of-Mh; Thu, 11 Jun 2026 10:09:12 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wXg5b-00037N-ML; Thu, 11 Jun 2026 10:09:01 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65BCXYoh032751; Thu, 11 Jun 2026 07:08:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=ZwHemaALdM0olFDs3fzSABo+c8ke7N8orZcjwGvrt
 cU=; b=ykYvYumme8SIP+an5FiOrMA4HRSKXZU6HV0tMxtnKHrHm03v37dwn2TvX
 rfzTC1ySWSX8kNtMc4gKY7MOgX3HsU/OzWPwBToOxLxsDL27HMAk0y1GTqevzV+o
 AmM3Pph9z4ITQlOfq8dZdk5UACcZIIeM08bM7oHQtTk8g7RDkcjv25GUxmB+37au
 dQ5DjTi1mGoKwBqsWqtwtIePdNZbOgXkNaGzniDFTwd9AEXJFhyC7Dk7c4CUWQHe
 gaPBDKtmK38xzkcd2Sgl6iWnf392LN1Em4xoeMQMW8IS8fAmDPs3kwSoJc3hmtIk
 StFIzDKMTj5TPpys6j560jch1Os0w==
Received: from sn4pr2101cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11022109.outbound.protection.outlook.com
 [40.93.195.109])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4eqe5kt9r7-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 11 Jun 2026 07:08:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HwOxJDRRX4AREVd+5qauADG0l0sgk+KdaNczNgPKSz+GelDVG+Z6TZfNQi4X5zMtwQr+Go758MDvLBDHf61JsnUL1skgk//zZjTceoX5Jyg3nXdB+V767tebM1FLDffuL0tx16I8TGB84wzrdzPE82XU1etse0Prt/iZLsiGjwx+rf33OUQczA3qauw2LOBRZCuyn4gzhD3tSTqylPrwhHJbIQu9KglPQZbck9pYAgwbfApYzHV3mNIQXifSXqegfYmrcdP+ArJDlvPhH58wBVngMdfR98V/ZazBxWjEUju/GABKIoiK11bXDkwKF0VBc8UbRmxBpn/hFrvnbeoyzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZwHemaALdM0olFDs3fzSABo+c8ke7N8orZcjwGvrtcU=;
 b=O8syV9M0ssLMKUWO7qelhLvF+pvz6rvk0h7rNddJwJwKjrujVewSM9jOPzDu5fNwkL43GJMb4BTeKOoOcPEtxEM8Zth+fteBEo0eNdD3EZrynVtcx9TSRmC9spkC4j5OoouW53hSLmsgIWZR8BWBsg8kn1VGX/4k8DjMy80u+TsMhl9wml8qA+MSWqVl1Hc5pHbBWDlYjmYVyybfM2G6tM2Ua10hePkwDJLiVNqJ5Zs2UCgq3IHLgp/Z94EZc1iQTt0WIMzczgbhCHrmua/68JrQYZdZ+bxOVH+k1cRSDl7a2ixSBIprL1DRk59Xy8LSbyxVBpospH+oPH1SDOryoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZwHemaALdM0olFDs3fzSABo+c8ke7N8orZcjwGvrtcU=;
 b=YME7R7q3UQpmwDWZzZ6OJupcZegBm7H4XwFgow/4XTX0uJKu9vlTiJfqlbrtPiHfBU2W1X/m9fJuIBgddFPMVqr5IjnyuSlzasv13taZ98dij7UcD3OX4HHcJf8yxD5ZSq4oUAUZAHhjYk9aoyQ1ADg4HS/0Mvk5cLa8R+LvfchtQYUW4JWPv7NF5xyERuIOsQNwwwsxWKXz7Kfm2OLhVZN00qMy9iCiektZmIgb5jwJu8cGX5ejWGmpcM++Esu4Wxi7xwRL5+09PyHomPfDV4y0ypSAwCeTAqeq8sZka5zVUaTdv2bmnO76AlELCj5HAHcjoAvAgXoBCzpXV1qkdA==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by SA1PR02MB8510.namprd02.prod.outlook.com (2603:10b6:806:1f9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.13; Thu, 11 Jun
 2026 14:08:47 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0113.013; Thu, 11 Jun 2026
 14:08:47 +0000
Message-ID: <e375fdb7-b4c6-4b02-b2ea-2bce06e4c025@nutanix.com>
Date: Thu, 11 Jun 2026 15:08:41 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/10] qom: Allow default values for instance properties
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>, Eric Blake
 <eblake@redhat.com>, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Sana Sharma <sansshar@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Juraj Marcin <jmarcin@redhat.com>, qemu-rust@nongnu.org,
 Markus Armbruster <armbru@redhat.com>
References: <20260609172514.2037645-1-peterx@redhat.com>
 <20260609172514.2037645-10-peterx@redhat.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <20260609172514.2037645-10-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CY5PR13CA0011.namprd13.prod.outlook.com (2603:10b6:930::16)
 To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|SA1PR02MB8510:EE_
X-MS-Office365-Filtering-Correlation-Id: 55d29c77-4b54-4b3e-2cc8-08dec7c2f4ac
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|23010399003|4143699003|56012099006|6133799003|5023799004|3023799007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: XMss2vizbnPoODf9JC1mBkYUdnIkLYPDBbeGf33ovY9F81puIVe9I/S4I3X8OQLQPDJBtygD1sdi8JbaEjvKEaM5Y5oJDKctUyfXStLXtu8MtD/fx0QSkBWzAB3kfK7t8vK7m0RostPsPn8POlmtIq3RewNpLSaON7VmT7+f4QJvLCj5x2st3/AkMDrbm8Bg70o7r5VF7R3weEY1YIMV68sohTDqH9nNgXRTGTOhI2nvhtRSXfVzlQHUf29lhJ7iawT5pZXSZnAElxWPIHIZ4+raohuphptQHOEadN5eH2GksVm261Q3w2GvtcJKVs8t+OZzWLEIMAOX3kFBQlcOjfEFYU1ASvq20eRXYOHfXREaHUyumKPOq6PFVNh4Znh+NpQKGr5fzqZtYJ0gFhaY8/CGgO9MnR/rSt1cSvv+7MLqk3XWdwWnIU+oVR4MHff37MQhOJLxuhnLhm7//CU3PTJfOvTCur9EnGBkxWZi8yXUmAlndnAAokh/JBl7wcOdMRhkraTFyMRSnPYj7/Zb0v9PR51dxub2hbvWNPMZ8ChXqHyy/L2m/yGnlo9zmAcHzNNOezTRCThM4wrBnsw1rfX6T9hHgvbIT/LDUQx/PzYKuX9mwxQREnES2B2c6qWqqEaXRm26YJuVX3vsMf02AH9ro7pU8iVa4n+TZpa+oikm/XQ9iADlu6wcVJOBYd7R
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(23010399003)(4143699003)(56012099006)(6133799003)(5023799004)(3023799007)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U2grQUFPYStFaDZLaVY3Uk0xNXozK3RocE11a0RRSlBhSEFTbzZyWStkSUxv?=
 =?utf-8?B?d01SVEt4QjBKZ0tPWEtiMWxsbDRkdmhtdlA3bHY5eHBkdTdKYTlRUmdnWm8v?=
 =?utf-8?B?dnJ4L3BGaWM2emdFcG93ay9oRDk0eWhybDVhYVJhbTlkaXJZTmVvaVJFWk12?=
 =?utf-8?B?dWhhQXd4QVpOUTFvRk5HQjliTWFGWEFqVmZtUjdEM1JhR25WNkpjTy9rTTdm?=
 =?utf-8?B?a0E3U3BDSHBUWTNRV09Qa2hvem9aQUtzenJVeC9tcldad2JibzNmbnBQUTlM?=
 =?utf-8?B?YU5CbkRlekk2Yk1zNzMwejZrcE1Tai9BQ1p6c2cralArMkJ4L0w1T2NYSFRG?=
 =?utf-8?B?L3VDRGVLMGcyOGpSSFFmOFc0RE8xU0VITWg0WHdLWWZyVVZIRFBmdUVKQWZ4?=
 =?utf-8?B?WGx1K0t3cHV5Vm90L1hrQW5XL1N5UDZjZitvbUozTUxObTJtZXRSWW5xeE5y?=
 =?utf-8?B?bXVSVWRVZE5CK3piQWZvUkpIRkVBU1FuRFNsa2J0aDJZS0QvN1dTUURmempI?=
 =?utf-8?B?YnpKMWVjWWhPR3p3NWtRWTZhd2k4L1k2RXdzNjFYOWUxMndneWp5bDFMSmFM?=
 =?utf-8?B?Lzg3eUxseXBsUEFnYTR4c2ZyV0FqSlFVRjY4MXFSNnIyMTI4dUFnNzZsamd5?=
 =?utf-8?B?YjM3SXB0RmFyWVY3VUJwejRvbC9iYmJsTG9BUzg1WTd1UWFwZU4wVHhFYUEz?=
 =?utf-8?B?RGkwK3QwOFd6YklCT1RkYWJiU1lkQzdRTXJCVjJoTUh4SmpXK3l2bHQrWkRk?=
 =?utf-8?B?WnBsSVNPSWF1OWF0VEhXMjVRUlA2aEpXNGV5cC9qR2RCZldSSzVNaUNkTXJr?=
 =?utf-8?B?MEZqcDlnMVJRaUpCaldKeFpyMVJQTk9FSkZvVHJRYUJ3cWhTWVg2dUdXdGlp?=
 =?utf-8?B?eXFpcTNjSTlzWXN0aWtwNllFdkZHUEpaWHBxR1F4bjdsWmFXUHhGcElxL21I?=
 =?utf-8?B?SVdsUDVHSm1Kb3JaV2E5c2M5cFhSMEFIVTdRS0UxSWtFeGVJQk1DYXppRVAw?=
 =?utf-8?B?cHFVSEVlOWZiSktpYWtSZzFXdDExVXhUMzJsWVM4MTNIWGpiUHBQVS9yVmdq?=
 =?utf-8?B?aDFQMTlmNnBSbFJEbFJpdTByOGJVYUw4Qk92SldWcGVKNW9XMTlzVi9rZlF0?=
 =?utf-8?B?THRQclJ2S3gyRERjMjJDSDRZMEJ4SGNPdHZIdDdRNEs4bVRNRjBEYkFVY1Ny?=
 =?utf-8?B?UUJYa3ZSbkRBSUVEWkxyMnpnUUd1V2EzS1RGSHFhYWR4M0JxUVM0ME5Mb01G?=
 =?utf-8?B?RmZkOUVqYXh2emFwVHpzTXNjenIza0RCVzljUm5RNEdiM21saTJNS2hHcW9T?=
 =?utf-8?B?TzdmTHlpVnV4OE41QXNhRzdpd296Q0JQK1dCRWYrUFJjRjJiVzVCWEZlMFZw?=
 =?utf-8?B?NFg3VnRDYnk4Y3FiSFFmeXZKbnZsR0YvUGNwN3FEczMvbXhndG85OFVwQnVQ?=
 =?utf-8?B?cHM4UW0yODBMR285bkhXbCtnOVJZM005RUxNdlc3emtNSTdqWkFmc2FraTlX?=
 =?utf-8?B?VjJkRVdBUkhhWDZKZVFzQWpOVE4xZTFZWlNteGI2aFFoUk51MHpPRlRLVm1N?=
 =?utf-8?B?NFUxRmZsZ3hDMDRCSGFrOTJUTmhpN3NDa0E4ZkF3RHlqMGRrQU04a3BCSVQy?=
 =?utf-8?B?R213N1BaNEdIaVRlSXpIS1FVWEU3V29sZXZhODZITjVFcERaT0xQNkdSKyth?=
 =?utf-8?B?S3RWbEZ0WklDSm92TnRJYWkwRGp4VmYxNSsrekZuMFk0RFkrczV4ZWQrZnlm?=
 =?utf-8?B?VU16akR5anhKZStYSE83L0tNN1Zla2dTc1E5TFZESTV3Z1RSYzRsR3VCQ3M5?=
 =?utf-8?B?ZFprRWZzWWFEUldmNERPUEVET2FJZWNPd3luUWpETnhlekxvTWNVYURkSXJj?=
 =?utf-8?B?MmVmdTNrakNsQjg5aU9IcmhBWlJnemtvdk14QVZkeW80dGVKb0pwcFhid21o?=
 =?utf-8?B?RlhtMGtRYkhycDIzSEFoZnNLUWZxRkN1K3BwRm13Q1haRDVDUzcwTnpRMzZv?=
 =?utf-8?B?aVk1V3h0ZGpCTXk1UUZ3MGZXT2dBQktmL3RCWDdPZi9xV3NHMWR0YzVqOUpr?=
 =?utf-8?B?RVFCM2xVakZydTZUVm9WWlVsZHJVamYvc2t0RTRsanN5ZEp3YTVwOXpJOUdx?=
 =?utf-8?B?MnQyUzFHbFR4aG41Z0MzWXpsWURaQ2ZEd1NieWNpVmsyb2FwT0xXT2tNOHFF?=
 =?utf-8?B?ZHY3TWVuR1MxalRHc2xSWEM0UFBiTm83SndYV2lpVVFXbXpvZjRqUitDM1U0?=
 =?utf-8?B?RkhPWnhOT0EzQVNOV3ZLN0htcXJYSU5LM3A1SFE3dkJNSmlvT2ZWMmlIeGhL?=
 =?utf-8?B?YzBxV1RoNmppYmZOQll2ZUxjZFRYdEZFbVg5MDRvWVNFdHdpNGdBK0hzTkFk?=
 =?utf-8?Q?y6OSvIAizJBtFank=3D?=
X-Exchange-RoutingPolicyChecked: NrMqUX4pp1STuNFD33TxKXbOgHjlHMIQx7rVFFy2ZM7fTDcBZKV5ococFdfSRpncpKg4ODQaOacj/ciDN8tvLoeFHCSh56n9tIjvxdqRvhl4RGeRadw754XTaG/3VJNYjXCE8Oy2+tclC5+CdEX5iH3I/Tuc7BFInY8B9pvsZ37YOFY463IZAw6Zu3cQjgrNCFnV67TAipPWsHBg7pepeTFEiefsp1jRfOwxi7mIFr7L83bq+GXAk8zrIe/OpIt4TyR3QJIBWKJKlaUG+Gpk8V8NVUnzzo6h4deaDRe1my7JCpBVOgE3eQJikhLSsmymIzkw9hdxY9cVCHjScjnnaQ==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55d29c77-4b54-4b3e-2cc8-08dec7c2f4ac
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 14:08:47.6556 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pyePySlly4tuTI/FQMVsNkw1F3weGws27ymsQCsh1WOLYwSVP3fy8yKl/ueZxtf8vbl6Yee245/ihQDA+PMLZoHKNUXIe5Yr8TlH4un+9l0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR02MB8510
X-Proofpoint-GUID: m9SfCgLktsxyXQ224UhZ7CYhOxxYTP8t
X-Proofpoint-ORIG-GUID: m9SfCgLktsxyXQ224UhZ7CYhOxxYTP8t
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDE0MiBTYWx0ZWRfX66ttWIvtpt59
 1SOj5n4jqS2wKq7pTzpXnaIC5aXiXY76s+K0wXDDKR1lF9OJfAN9lDEr09dLmwvAvUI/3cUyEMu
 jfAshM0/06IFYcwCdfg08OnWVLRBvqTCpGcTxL5OsGNeTfpScjHEYWskoC4f5j9gjENKGctYhlE
 ZhYgdxrw8ZcyQR1E/7N+1rV1DZ7GfVtef8fv1cWvu9Ik+t1kIpXPGrr5e+RRtN0X9nMc8CBO1pr
 QbxDllNBt8/H1inbIy2ho1MoIsWKQ+wkKv9eqox1NYtj2z45AxY/YGbAzJ51bB0jkf4hIAm3S4M
 gei5aJTn6e0Trlv14aEUSKcON0pRI5+6W/vO50GX33N98o9W3uX5+w13LWQygGhxtqy07aswC9W
 vUsAx10kJUsRXH1OorQMkVlgRh5/r/aiAyqSKbR5nauUaFeZ3IexH8vtDiHer1ew5+0amU/w/qe
 VZ5q68HfdOgl5ftv//A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDE0MiBTYWx0ZWRfXxrilkWMP1pgV
 4QSiwmawBoHNzr7p9U9tzHp63sdogDHWyX4dMPJXUCP+OozA72pn1hlBl/jvkThq3Y7ujl56ZBf
 RGD9Vzn310PGUsQxHDcaYwPAQfWTRgg=
X-Authority-Analysis: v=2.4 cv=TuvWQjXh c=1 sm=1 tr=0 ts=6a2ac171 cx=c_pps
 a=o74NBiIPioXkFKZqBywf3Q==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=jxMXjlTPpCISP5mWtjnE:22
 a=20KFwNOVAAAA:8 a=Z49afIFnRL-eqgZTgcMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_02,2026-06-11_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

On 09/06/2026 18:25, Peter Xu wrote:

> ObjectProperty allows default value settings via proper setup of
> prop->init() and prop->defval.  It currently is only supported in class
> properties, not instance properties.
> 
> However, since QOM allows class and instance properties, it should also
> allow instance to add properties during instance_init() and allow the
> default values to be applied properly for this instance only.

Thinking back to the earlier patches, a question that has come up before 
is whether we should require all properties to be class properties? IIRC 
one of the motivations for this move was to allow schema introspection, 
but I don't immediately have a reference to the original discussion.

> Add the logic.  It will be useful for all kinds of pointer based properties
> because pointers are normally not accessble in a class but only when an
> instance is available.  This will be able to achieve similar function as
> what qdev properties have (which works by remembering offsets within a
> structure instead).
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   qom/object.c | 26 ++++++++++++++++++++++++++
>   1 file changed, 26 insertions(+)
> 
> diff --git a/qom/object.c b/qom/object.c
> index fc738549dc..eaef615924 100644
> --- a/qom/object.c
> +++ b/qom/object.c
> @@ -487,6 +487,20 @@ static void object_class_property_init_all(Object *obj)
>       }
>   }
>   
> +static void object_property_init_all(Object *obj)
> +{
> +    GHashTableIter iter;
> +    gpointer key, val;
> +
> +    g_hash_table_iter_init(&iter, obj->properties);
> +    while (g_hash_table_iter_next(&iter, &key, &val)) {
> +        ObjectProperty *prop = val;
> +        if (prop->init) {
> +            prop->init(obj, prop);
> +        }
> +    }
> +}
> +
>   static void object_initialize_with_type(Object *obj, size_t size, TypeImpl *type)
>   {
>       type_initialize(type);
> @@ -498,10 +512,22 @@ static void object_initialize_with_type(Object *obj, size_t size, TypeImpl *type
>       memset(obj, 0, type->instance_size);
>       obj->class = type->class;
>       object_ref(obj);
> +    /*
> +     * A few steps to initialize properties for the objects:
> +     *
> +     * (1) apply default values from class properties when available
> +     * (2) invoke instance_init(), which may add per-instance properties,
> +     *     which may further contain default values
> +     * (3) apply default values from instance properties when available
> +     *
> +     * instance_post_init() should happen at last, after the instance is
> +     * fully initialized.
> +     */
>       object_class_property_init_all(obj);
>       obj->properties = g_hash_table_new_full(g_str_hash, g_str_equal,
>                                               NULL, object_property_free);
>       object_init_with_type(obj, type);
> +    object_property_init_all(obj);
>       object_post_init_with_type(obj, type);
>   }

Nice!


ATB,

Mark.


