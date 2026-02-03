Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F338E87842
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 16:27:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnJF0-0000Ju-QO; Tue, 03 Feb 2026 11:27:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vnJEz-0000Ja-Pl
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 11:27:01 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vnJEx-00038K-QJ
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 11:27:01 -0500
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 613C6F832643057; Tue, 3 Feb 2026 08:26:55 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=FuT7bu5oCnJIDioI4bwJW4dUl9IoQvA6jMv5QDY5C
 3k=; b=iqMgKsjHoZHhWrNdrbgBAO9SZ0j96ONAbp19t72a8j7BbR075+hDbpxzm
 wq0PLHuUu0+Xx02XIwokt+VQLSWe4NKaes5oP6ApvtN83jvfALzOc83kNU0ewALR
 rd85M7SrAqAcUJWxm+pacUiXk0bx5QzJrHjrKR6QNNut+kPdvRfJKYk5XSaUlYkp
 j0T0FncolSB1njE4oCFAJlgiWUzFToiCfkZMs6XlpI77FOEI0n7b3Bo2NN3SzGRF
 VFIxh4iLhcuaE7fYqCy2kTieMjErlOgylEkqqEYqseOdpyDX3pY3xJCPlzKqWMSu
 m5ztyg/ri83PUUjB0aTUWEA+bv3Sw==
Received: from ph0pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11021120.outbound.protection.outlook.com [40.107.208.120])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4c2ympu0qh-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 03 Feb 2026 08:26:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZUHUt+CS9OJkEvje9vD8bVpBnx+MwEsQVkqd7ixq+r3Bk7fGd0PdKtguNQckaKexI0LTFtwtmFMfio+bA1hMgol+cZTdyDu+QH55Z0p6/JEslczkbVXAHLBUG3L7LhflcswqUXdVwOTwM9HVMioZ/Ex/xRMNkW06JyeufIgGzmdIbB1BkzWvoxIuDhXtlLZZmTaK0a6Rf6nSOZg+/pFSjrlb4zpZ9iRERMI1vgITeHtgVdfUD9nOn7WwIZh1bXcwrxQrUjY2ddTe+Y5xV1bVPZ2ql7/eOV1EYom2tVi9TSPUjosjPyXXb3pRwKcdRtjqUB0OkxQt+gGWviPPsj9I+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FuT7bu5oCnJIDioI4bwJW4dUl9IoQvA6jMv5QDY5C3k=;
 b=Jd04fPL5Gw89hcfjbW2g8yZgwhzPqpLuIoSvfoyDADUroCGR1UmiSMOvh0wHDUv0HQKKFzciPeiS+jnhHE1w7IqTEjCRo68ypccXwI+LnVfns6Xml7M72vzgk0zO4iU7ZyT/rxY15ppE15YDKuRCo+CTQ4Y7SlqAFOMbeDF+7NMlTUQUP57Z1998xW3b01ROUx70MOItLd2tg/21LkW1+SI739/l8md78fn1GAHACNuabKdusyvPCIXpkTxiGYy0vpAmP9srmswjSupk5lVcgCeh1cZPNJnjRgJGRhEvQWrWujPWq2d3YA7qSLqVB7XayuIuLRxCKLzvnmHcunAV6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FuT7bu5oCnJIDioI4bwJW4dUl9IoQvA6jMv5QDY5C3k=;
 b=o0UzdMUNuj5VFjYUfbKBa/sLjZfNlQyQlCC8jQ7PUkr/yiFNZvRhkRmvYGKuAxIkcKODmkmIDqXx35ksHkEoj8Z3O6wwU5bId3qi75zw3iBw1619XSF1LIUj36BmI5Dg2emKwf2RY26stiqMoio4NMVY9twIU6p/0biZcLkIyZh2t1xaINf5SnSdxQ8oH7+hQ4xa3jDM0EhpQYEmnaccO2icgrOGtSPJ+ZVXILNyvipa40PL3W8RieQn7kXzwpLFOW8RWfUqnIhv/DClGXef5b6/PaKnOP87SIV8ZBIznSNu9+CnFJ1AjOqpAxzXn1KhaJUS0cXdQJ9E//fUQiGGxw==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by LV4PR02MB11026.namprd02.prod.outlook.com (2603:10b6:408:2e1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 16:26:54 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%6]) with mapi id 15.20.9564.016; Tue, 3 Feb 2026
 16:26:54 +0000
Message-ID: <6436d9da-091b-463f-b917-c5d001e96ef7@nutanix.com>
Date: Tue, 3 Feb 2026 16:26:51 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/37] scripts/modinfo: add --skip-missing-deps
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
References: <20260123074945.2563196-1-marcandre.lureau@redhat.com>
 <20260123074945.2563196-16-marcandre.lureau@redhat.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <20260123074945.2563196-16-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7PR04CA0032.namprd04.prod.outlook.com
 (2603:10b6:806:120::7) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|LV4PR02MB11026:EE_
X-MS-Office365-Filtering-Correlation-Id: 381dfb7d-080f-4eaa-a8c0-08de63410ae1
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eXdQcE94QzFSTGhhcmhiUEdDUC84dDNUeGdkTUt2a0pjQWpNNWUvZFRZdklW?=
 =?utf-8?B?VzUvZjRhL0FDcG9MQnZkUGgxMExxY0l6dndMdUZoT2NLYXd0S3ZyYUFCaVU3?=
 =?utf-8?B?YmpuODNhbjVzOC9UZHI2SVpBelp4VEFBMkY2anhtZzlSdDNKVEVMZU11bFRD?=
 =?utf-8?B?US9TbUo0Q3g3TjFrMG5ramdCYlBmN0ZnYkdkSnVkLzltU3A4NkgyNUNjQm5H?=
 =?utf-8?B?NFNacWRERlRRREZlMk03aXBZR3ZQS0FvNEtyMmE2dmVrZ2dNMHpyWjB4RGt0?=
 =?utf-8?B?WFNYYnc3VzFUTy9BbTFkSnErWWpIeVo2MUJkK3JibittTmROQ1Z3N0h6eDZ5?=
 =?utf-8?B?dkNLdWFOR2NMN0pUTDBBOVNzQjM1Nm5DSitBdlpvQUErMGZtY1JtU2JuSVBN?=
 =?utf-8?B?ZHc5dHNHYk9ZOWQ1M053TWN0M0dpNU1KRVZkUlNJNURCNlViZ0twQjNqdmNt?=
 =?utf-8?B?d0h5a3VJd2tQL3FBWDU0aWpXT3FpNS9qQkRtZEdmN01zMUlzSjdwSklIeHhz?=
 =?utf-8?B?Mm1mdEd4WHNNTjJJS3R3VVFNVmd4VmtzcFZ1ZnFZZGNyWmJ4UnI2NEtScnRM?=
 =?utf-8?B?bUlHRGdROGdMV1U3MU5CSzJiWVpxRS83WktWNDc4YU01ZEFra1IxZ0Z4Uzc3?=
 =?utf-8?B?MnRHSGpXNFd2QnhoVnBWaWxoK0kzYm45NkJ1T2hxTmM5U0hUeXV3UFhlOW0x?=
 =?utf-8?B?a3dPdWh6bTJHSWViOXQ1RGo5R1ErdlRwQ0tRYVJwaU5VRDBKNnBQV09KNU5B?=
 =?utf-8?B?WlZDeUsrMDM3MTFCdkJXMHdIRHM2RnlZSVMrcDZkR0pUMytDUnlxb3AvVW9S?=
 =?utf-8?B?SENJT3lTTDlXR2ZkZUZZR3JYSHlXQ3ZOK0JZV1JFNGFFYmRZa3Jsd1JVaTJy?=
 =?utf-8?B?aS8wd3dubmwxdGRTSTNqbTVEVC8va0RCNkZBclRsSjM4VC9YZFhDU2VCdzNW?=
 =?utf-8?B?dTFwRmFKeFZWY0lJd0tRNzlTUURYcnN5aWhVVks2RE1DTFlvZmNYTG9VeW1x?=
 =?utf-8?B?dCs1dVpZSnlWaGxGZEd3Z3hFVmpiMkhEU3RRSGNCdXhyNzhiZ01iZHFlaGFC?=
 =?utf-8?B?SjAvRzdvb0xLYnJZazR1QnZsMjRZUit1eE52ZndUdXJXelR5NTU1TVI3bmRw?=
 =?utf-8?B?VGlnY2QzL0Fka25kd2xSVE9Sb3hFNk8vMmcyZUFwSHlhR0RzaVFjaTd2QWVm?=
 =?utf-8?B?b2FmZ0lTU1pQVEtwbWJqZWlsRnZIVVdWaUcxOEF2enBsWWRka3ZPWk5QdXEw?=
 =?utf-8?B?dnR1UjNLQ1hLSmlHYWFJbklHTk0vT3FCMksyTEpRUHhGdDh3R1BQbERFUDFj?=
 =?utf-8?B?ZWZVTWVtV25CdlJNbGxUUGNGT0h6NTNkRmxXK09LbXhieHp4MUcrTUhNOVYw?=
 =?utf-8?B?U3JVdndNUDQxNGpWRGtGMWtJSG9XSDBrcTBCSDhpa2k1a1VVek4rR2VYZ1NE?=
 =?utf-8?B?L0sxT2V2SkdRKytrMFdSWlh6eGdiNlE1N2lSanVESFJvOGZCSzlWb212UFJB?=
 =?utf-8?B?MW1KZlBXSm80dHV5bzJ0ZmZMQnJzeVpkV0lFWXg5bHpGZlBwZ2R5TDVIcHYv?=
 =?utf-8?B?RytRb2g2VnpMb1U3U2dmNE1JQ1FGL2R2L3hzQ1FyQkphbjc3QW42cFdSOUVv?=
 =?utf-8?B?aEdXcUtKVG1TOG5zQUladmx0RkRhZUd3RTNmNWZkQ0NuTC9ITjJyQ2xIRkRk?=
 =?utf-8?B?N3pmazVvakNDRUlGalh1c1QwUTBnY2E1RFpVRVJtSWE3bzFQVnovZ3BjQmZQ?=
 =?utf-8?B?WjRobno3eDU0ajVkRVBPYXAzQ2laNWtHc3B2bUhmdmU5bkVmcXV6cnFyaWNE?=
 =?utf-8?B?dkU0T3QyejdaTjdyQUQ1WWNOWjBRRE03MzEzWDdIWEk4T21JaWN6SFpMY2Uy?=
 =?utf-8?B?OFp5Vnc0RlI1eXZoUXhKdHlzQ2M4TXludjZUTzhYbC9JMk94bGZoU1FTaElR?=
 =?utf-8?B?U3BnVkRPb0FycXIyMDVYSTJCNjlXd0ZWamxQbi9hb2RUNW14SVluWnRNWnR5?=
 =?utf-8?B?ZjhxNmYrd3hua3JGS1JTSWtJbDBHK1R4dk1FV2tnQ3M1Z0VYQ3BURnBDUDNM?=
 =?utf-8?B?My96eWdtTkRCa1ZEMDY5MTExU0RWSi9tblJPZG1HU3lIcE1uK2l5bm1pYlBC?=
 =?utf-8?Q?Xos4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ckdOYkg1aElYeFp1MUpCblhwQVNBM2VidS95TmtwL2ZLVEJDeWc3V3hRMGJv?=
 =?utf-8?B?S2NVTmZBYm1JOXB0RjVjQkFKUEFCQURVbURNc1oyWWhTb3VZVWswb2ZNVFhI?=
 =?utf-8?B?SCt3RjNpdXNWTTFPVllPaUhwNk1VRWxTaWJvUHhreGowK01FdmRXU0xGSlp1?=
 =?utf-8?B?aEFCMFVPM2RMdUZBd0xrN0VCTXpRWUZnajdEb2p1d2NpZ3pCSC9FOEZ5bHNV?=
 =?utf-8?B?MFpMMlYwQ1B2d25LaVFGaGFpU1YvbmN6K2o0Vi9DK1EvUkUwZy9GT2luMm1X?=
 =?utf-8?B?NFppZnNOeW9IWklNZ0Z3QjMzR0wxNzlFNmkzWTZSRVNZRDRmc0oyYnYzNmtl?=
 =?utf-8?B?MzhhYlZXS2FJL0xZOUpKZnhrNEFnUUxHd2pTWFpHWG41WEMrZVN6WnI1eXFT?=
 =?utf-8?B?K2d0ZE11b1dOK3N5VDlZQ0Nmekcxa3RLVGFpMmRPN0FOVFROQ1B5UElVRmxI?=
 =?utf-8?B?dU5vZFJDdjF5bGNYK2p4VUJ3bnpOVGVhd1A2ZnNBL2FURkt6Q3hBT3pPNlRH?=
 =?utf-8?B?cHRYU0N2MXNwSjB3NXd1S2N1VnJHME9wVEdJZFF5ZVpsV09IRHAyZWJGVUZq?=
 =?utf-8?B?N2orZmcvdWdwNHZPZG5pRm9kV0l2K3pUWFU4Nzl0ek1mTllxK0pLanRCb1B6?=
 =?utf-8?B?bGx6L2FETko1KzlqOWY5aTNibDVkZXJGdllTVThvbjJPbjZtclh1cXZJZFVn?=
 =?utf-8?B?T1JVbXNCZG9nS2syWkJqbk9FMzhuRWVIbzBad1MyM3dzSzNaVHNaL1ZzVUlM?=
 =?utf-8?B?V3JZQUZCaFpXM0Z5MzlMWVZrdjJPWmwzTTFkN1FwY2U4NEpJWE55VUMrTWVM?=
 =?utf-8?B?cG41UXpiSFhnV0VKRjh5dVpxRS9EcjNXcGZUVCtjQ0xBSGxxaUJOMVlEZEZL?=
 =?utf-8?B?RjJyQk9INkZjclJQZWdoQ1VKd043UmxVL1JFN2pUNW0vSWV2a2NkQmN6UW5I?=
 =?utf-8?B?d21rUTFKUEJyVytoWlI4T3FrdzFMa09lQmpyakZvNGpyWmg0VEVjWEVnWWZF?=
 =?utf-8?B?eERwR3NPMnE3ZUdCQmsvUVpkMHJHbGIwajdPTG5ERHA0QkNWcjhDUm1XdUs4?=
 =?utf-8?B?cFBEVUtCZWZBOVR5VGpiVUxmUmRNZjBqNzRlM29jT1R1QVQ2Rjg4TG0xaHVG?=
 =?utf-8?B?MWZZQzMxSUorRXBhbUl6SFV0aGZKTncrQkJyYndadkZJSkFZT3FtUmhNMFF6?=
 =?utf-8?B?NjdmTlErcGViV05wa1BWSktVMDQ4Y2RveWIvZmFGeFl0ZzZoVktBTWxYN2ph?=
 =?utf-8?B?OWM0R0FrVzkzWHJublB1bTc5NC9tQ1QwS0dxa2dTcnpWa1Q1YXVsbW1tcUd5?=
 =?utf-8?B?NW5yVkFwSVYrTUN3UUV1RE1jSFE3ZFBLVG9EUzN4bUlIZXhiSExCbmhyYy82?=
 =?utf-8?B?bW80Qks4NzRCNEZVSEd3NmNvaEc4WlRsWlRWeFVjVGJXd1AvRnI2VnNPRUo1?=
 =?utf-8?B?eXdaSFNkSEQzQnlsNjM2dm9nWnViTmVoZFgyMlVYSVhaR0tuWlIrQklvcFVT?=
 =?utf-8?B?aFdacWRLZTJWVDZ0bkVJODNqNUxOUnBwV3c1TUVMZnl1RU1XYTZQR3BKTitq?=
 =?utf-8?B?TVVXSnJselN3dlZYYXhwT05XYmJzc3FTQXpLMUxZbkhkTlNTRUtLT0pkVVhB?=
 =?utf-8?B?Q2NEMnlTUUdkUHRaU0loeVo4NXU3UG5aQXBzNk9veXF1SUdyRnBzZ05wUXFU?=
 =?utf-8?B?dHJzTnpHdW1PemZKb01UblFjQ3dOem03enVXT2g3aHhERE5LS0pxSCtUYVBE?=
 =?utf-8?B?aUg2c0t1Sm8ydkZjZ29PWnRjNFkwNUR6MXVCQ3dCRFFsVDRnREJzY0hraUxO?=
 =?utf-8?B?ZDJob3prWnRTR3FsWGJ0RGR4SmtmbGNNVnFUZ2cwdS94UmwzQzRZZXJIM0Fh?=
 =?utf-8?B?V2o1bmVZTFFCbk82QkxubnAvWFdoZElmWUs5MmRIeURscUkweDh5OXRDZlVW?=
 =?utf-8?B?VGZhcjhNYVNubWVIcHZRQm5rOVZWMndiTFdEbVc3a2VaTjR0dEtXU253SW5t?=
 =?utf-8?B?L0lQVExuSmFzRU1HQmJYNURvaDBlRzk4YysrZWtxMjE0dEJrcTBVcjltSGd1?=
 =?utf-8?B?V1VsRGN3aVlFbjhkOFFJalQraHJDZnBLdTRtUUduV2IzbjlDcWVyZ2dMYVp2?=
 =?utf-8?B?Um1naXg1RCt4NnZKVHJlTjYwSkE3U3dSeFl2QmlOWGY1dUJXZ3U5aCtLYS9R?=
 =?utf-8?B?NFE1QkQzZk9HS2N3bGpZWHkrYlBiVDIwaGJPL1lkZFVUeSt1cmhRbUU4cWc3?=
 =?utf-8?B?dW5BOWRkQndjbnhFY1R4bDJ1UVhMT0ZQU3k4K1oweVVuc3d2VjEwbGZjeTJ3?=
 =?utf-8?B?ckVSSmR5ZFdxQUVVamFSai9iVGE4RldzSkFJWVMvVTl1eXpwUFB1TVRkMzJJ?=
 =?utf-8?Q?nWaT1Ul2TKcIWKuQ=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 381dfb7d-080f-4eaa-a8c0-08de63410ae1
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 16:26:54.1034 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2BLtQKYwCL6G00bSalUNdxbb+uejIOenXYk+pLt2dm9gm6HsCgGvh75+xYlYEtaEsw8yg6v2jp4XozD4zSxv7DeVlY07oDWklwCSL5zJwkg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV4PR02MB11026
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAzMDEzMSBTYWx0ZWRfX93WhmHXNOuJU
 PwrNzcziDwNp76frBrXPKHXJHqF2s4D+YgVuORpOlunp6avMps6mipssJgNZAs2txaz6BICQzRR
 8eFAG1uqjBaAOFoVD+aBUCTs4Y0wGPi8Cob7QsyxnkbB3RDObdD1aP3zaFQEcUzeXPT2g0idxci
 3ZuRWF9zjSUoXdYW96L55gNKLZegQzMtfhajXmg/PCgtMCzqpDu/KibouE5FrCfqmeNyWYwVGr6
 SXGNO/pf3gt5IwrLFa40VxBkVSLFIow9ryP/dKrUU63pr3Mim1k8baalJzK9juglUq+XkrH5JCn
 9PGcUzO2TV/LIpFiI3A2aHkXfcfe5AaV4DejfKtCGlRIlSOBwHRTwANcw7psEyWu/Rr4R/+mqh+
 ZLxE9Vaf9LsDvBrw2Y8PCXFTakunroKWrHhYEpgAvZaM3kUlySI434xLs8v0kFp3uUqrveWJQCd
 ZZiPo5t5t6kwbU6du3g==
X-Authority-Analysis: v=2.4 cv=RrDI7SmK c=1 sm=1 tr=0 ts=698221cf cx=c_pps
 a=eQAqIyCScLYb0ahyOVIXtg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=20KFwNOVAAAA:8 a=64Cc0HZtAAAA:8
 a=xml-rYyWdjhpFQ6llsIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: l8gB5HN1H_VTQc2MES1c73bvYatzV4oI
X-Proofpoint-ORIG-GUID: l8gB5HN1H_VTQc2MES1c73bvYatzV4oI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-03_05,2026-02-02_01,2025-10-01_01
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

On 23/01/2026 07:49, marcandre.lureau@redhat.com wrote:

> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Add --skip-missing-deps flag that prints warnings for missing
> dependencies but continues without exiting with error code 1.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   scripts/modinfo-generate.py | 94 ++++++++++++++++++++++++++++---------
>   1 file changed, 71 insertions(+), 23 deletions(-)
> 
> diff --git a/scripts/modinfo-generate.py b/scripts/modinfo-generate.py
> index e7d35242414..e231c129196 100644
> --- a/scripts/modinfo-generate.py
> +++ b/scripts/modinfo-generate.py
> @@ -34,7 +34,8 @@ def parse_line(line: str) -> tuple[str, str]:
>               continue
>       return (kind, data)
>   
> -def generate(name: str, lines: list[str], enabled: set[str]) -> Optional[set[str]]:
> +def parse_modinfo(name: str, lines: list[str], enabled: set[str]) -> Optional[dict]:
> +    """Parse a modinfo file and return module metadata, or None if disabled."""
>       arch = ""
>       objs = []
>       deps = []
> @@ -54,21 +55,39 @@ def generate(name: str, lines: list[str], enabled: set[str]) -> Optional[set[str
>                   # don't add a module which dependency is not enabled
>                   # in kconfig
>                   if data.strip() not in enabled:
> -                    print(f"    /* module {data.strip()} isn't enabled in Kconfig. */")
> -                    print("/* },{ */")
>                       return None
>               else:
>                   print("unknown:", kind)
>                   exit(1)
>   
> -    print(f'    .name = "{name}",')
> -    if arch != "":
> -        print(f"    .arch = {arch},")
> -    print_array("objs", objs)
> -    print_array("deps", deps)
> -    print_array("opts", opts)
> +    return {
> +        'name': name,
> +        'arch': arch,
> +        'objs': objs,
> +        'deps': deps,
> +        'opts': opts,
> +        'dep_names': {dep.strip('" ') for dep in deps}
> +    }
> +
> +def generate(modinfo: str, mod: Optional[dict],
> +             skip_reason: Optional[str]) -> None:
> +    """Generate C code for a module."""
> +    print(f"    /* {modinfo} */")
> +    if mod is None:
> +        if skip_reason == "missing_deps":
> +            print("    /* module has missing dependencies. */")
> +        else:
> +            print("    /* module isn't enabled in Kconfig. */")
> +        print("/* },{ */")
> +        return
> +
> +    print(f'    .name = "{mod["name"]}",')
> +    if mod['arch'] != "":
> +        print(f"    .arch = {mod['arch']},")
> +    print_array("objs", mod['objs'])
> +    print_array("deps", mod['deps'])
> +    print_array("opts", mod['opts'])
>       print("},{")
> -    return {dep.strip('" ') for dep in deps}
>   
>   def print_pre() -> None:
>       print("/* generated by scripts/modinfo-generate.py */")
> @@ -86,6 +105,8 @@ def main() -> None:
>       )
>       parser.add_argument('--devices',
>                           help='path to config-device.mak')
> +    parser.add_argument('--skip-missing-deps', action='store_true',
> +                        help='warn if a dependency is missing and continue')
>       parser.add_argument('modinfo', nargs='+',
>                           help='modinfo files to process')
>       args = parser.parse_args()
> @@ -99,27 +120,54 @@ def main() -> None:
>                   if config[1].rstrip() == 'y':
>                       enabled.add(config[0][7:])  # remove CONFIG_
>   
> -    deps = set()
> -    modules = set()
> -    print_pre()
> +    # all_modules: modinfo path -> (basename, parsed module or None, skip_reason)
> +    all_modules = {}
>       for modinfo in args.modinfo:
>           with open(modinfo) as f:
>               lines = f.readlines()
> -        print(f"    /* {modinfo} */")
>           (basename, _) = os.path.splitext(modinfo)
> -        moddeps = generate(basename, lines, enabled)
> -        if moddeps is not None:
> -            modules.add(basename)
> -            deps.update(moddeps)
> -    print_post()
> +        mod = parse_modinfo(basename, lines, enabled)
> +        skip_reason = "kconfig" if mod is None else None
> +        all_modules[modinfo] = (basename, mod, skip_reason)
> +
> +    # Collect all available module names
> +    available = {basename for basename, mod, _ in all_modules.values()
> +                 if mod is not None}
>   
> -    error = False
> -    for dep in deps.difference(modules):
> +    # Collect all dependencies
> +    all_deps = set()
> +    for basename, mod, _ in all_modules.values():
> +        if mod is not None:
> +            all_deps.update(mod['dep_names'])
> +
> +    # Check for missing dependencies
> +    missing = all_deps.difference(available)
> +    for dep in missing:
>           print(f"Dependency {dep} cannot be satisfied", file=sys.stderr)
> -        error = True
>   
> -    if error:
> +    if missing and not args.skip_missing_deps:
>           exit(1)
>   
> +    # When skipping missing deps, iteratively remove modules with
> +    # unsatisfiable dependencies
> +    if args.skip_missing_deps and missing:
> +        changed = True
> +        while changed:
> +            changed = False
> +            for modinfo, (basename, mod, skip_reason) in list(all_modules.items()):
> +                if mod is None:
> +                    continue
> +                if not mod['dep_names'].issubset(available):
> +                    available.discard(basename)
> +                    all_modules[modinfo] = (basename, None, "missing_deps")
> +                    changed = True
> +
> +    # generate output
> +    print_pre()
> +    for modinfo in args.modinfo:
> +        (basename, mod, skip_reason) = all_modules[modinfo]
> +        generate(modinfo, mod, skip_reason)
> +    print_post()
> +
>   if __name__ == "__main__":
>       main()

Acked-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>


ATB,

Mark.


