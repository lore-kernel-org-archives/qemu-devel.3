Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D89D0E77184
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 22:35:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOP5w-0007FF-D0; Thu, 19 Dec 2024 17:34:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tOP5u-0007Et-2O
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 17:34:10 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tOP5q-0002xL-7A
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 17:34:08 -0500
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BJKecd1001286;
 Thu, 19 Dec 2024 22:33:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=mUnX19o8ZpH9C988LXN3OlpP9FWfZMzITTuwtJeLp+A=; b=
 SsXzK1n8aYQU9iE725Q93FXKe1VQLsXEvj+2enJ6HbhTpiJl5XlyT8qu0bnRPF7b
 jaFMDiAaqXjGyjcYGBpQSsSsBaSkiwywMPHZFFRAyoz/GM9/WdQ49Im4lf1wlK+Q
 9rh7zzKWrMjCooKqVyC0pOfkYS6QVWzTqjWGf7JRyPgVbejpvb4KEzEpJRJ7Frik
 xSkVnsDjsEduo7MCRMn32R9MfAHhfifbFn09NaezcHju33V7t1UGS18IK47QX4C0
 unmO2+CpJIt27VoKktCdZlh8923gV5HrwyEyXDB4kXSAneI/Thgf89Dgyew4xPtW
 g0Edw0Op8vF23ndWvxBKyg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43h0xb49vx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 19 Dec 2024 22:33:59 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 4BJLFVT3006430; Thu, 19 Dec 2024 22:33:58 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2046.outbound.protection.outlook.com [104.47.58.46])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 43h0fcnmba-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 19 Dec 2024 22:33:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wd5rW/146de2KvrZqEYK5TTLksHMRO/lK0p604zc3oEOYvODV3jTv+z00Js5F13HHwjn0N8YAhd27NfBhzoi04EriVhftlvpPI7Eocim8qIGgdlhqfKNUVAP+9F6XTWZieAo9N3vBu1TGIx4MWxe7fheKnLjSgGg4O6TF566X1U29U4jsiztuk/1W6I72776R0VoGf93IYQ3T4sIb9+57krDaDNeH8d1aT6xf4C55VjsSqVwBzPLoLq+y8FeNiOBJ/c87PvFjPVvap3LZUK+WU4w5MyjfLbVHSIiZjIVZWmecGrLUqPUVPmAp9V/vnt5YEufsUtSMhRHbABNPUquLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mUnX19o8ZpH9C988LXN3OlpP9FWfZMzITTuwtJeLp+A=;
 b=uu9ckmr44d4upsqnmBqKNMVmaX5Wb60hc8aWESw/VR3QLEgxeMil2949gw7M3d4R8Fd8hX2l0tRarNHDRJhLuQHk65UDbGEclr8+F860UHgxr4XX41iY0kkQC91zSkZM2gKuMHMbf98jpJ9r6/9uKc1qnlnEuFMtX1tWqk6TAI+5BUsm7id/1A5xQaae8GvCKrWNsfY7fadBmGfNl2652QqiI4myTsTnJlvrrigdF2DJBFWYVEO/UcsgACikoZJhgw6EcSsfywytHMn+0R8p4G9ExZKnwwWl/mGWFhfCls1fIb3EYzvuKY7dWLiLtIoOjEifonVTb2gXi+7Z9C4kww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mUnX19o8ZpH9C988LXN3OlpP9FWfZMzITTuwtJeLp+A=;
 b=xmKtknz2Z1coxiF9+0kHBEGFnDT07qDNvGy1qZYWxE/JS97AKGNa5cMxewIFTo1qAU+whoBBdu2UjGDUOxsmddFWays6lYcCoHeOQwSqk4SCHZT4bED+rn1PxjTQkaWWttfFez68YM1aoYLNkAxuAlPqTT8vVTvWMKEioOFI0nQ=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by IA1PR10MB7515.namprd10.prod.outlook.com (2603:10b6:208:450::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.16; Thu, 19 Dec
 2024 22:33:56 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%3]) with mapi id 15.20.8272.005; Thu, 19 Dec 2024
 22:33:55 +0000
Message-ID: <65eae46e-a764-4fe9-b604-2095183227bb@oracle.com>
Date: Thu, 19 Dec 2024 17:33:49 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 16/19] tests/qtest: defer connection
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <1733145611-62315-1-git-send-email-steven.sistare@oracle.com>
 <1733145611-62315-17-git-send-email-steven.sistare@oracle.com>
 <Z2Q_zIlZs9CWHL04@x1n>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <Z2Q_zIlZs9CWHL04@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR11CA0108.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::49) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|IA1PR10MB7515:EE_
X-MS-Office365-Filtering-Correlation-Id: 249d1e4a-293f-4aa2-a3b0-08dd207d3907
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UGVZeHQ4VzVoYldnSFVYVTVxSXlpYjN5VHUzOGRlM28vWW5VSjlVakVUYlNn?=
 =?utf-8?B?a1Z5bFEvRWprUjB0Vjg1bVFxVE5VYXg0YlBpWXV2cGJFdE5QTk1EK2lrRlJD?=
 =?utf-8?B?NzkxRDVHK3hLdUk2ZUEwekZpVW0xcnl0Q0wwMmdEVythU3NxUDdHcDEzeHdt?=
 =?utf-8?B?Q2JuWUhlazFIcEdmUnlwdEtZT1pNblZRMHNUWG1xNjBqVTZ3eTJuN3hRR0FD?=
 =?utf-8?B?UGZjSGJqMzFzNVgwNHM5bzFUcXlneElhZGRId3cycW9qc1RPTmFzQ2twL3Va?=
 =?utf-8?B?dlRXVWQ3VXNnc3YwdWk2czBsTkxsUDRjVytPMTVia2MxWnpFMDdXNFdkSHBQ?=
 =?utf-8?B?S29XcVZjM2VPVXVqU2habkJoWmwzUnRJR3hHQzNyU2NWRGdaRFVkOVdPRjVk?=
 =?utf-8?B?UVdiY0lTOTk2MngxN3hOb2Y2cm01NjhyZk1sVkJtQnhzWUdHWjJMYVgvZzVs?=
 =?utf-8?B?WGVqMWRvZElkL0JWYnpWWTh6dDJoa3NUeTZ6VmlkK1VHZUU5aC9VOUVRQklh?=
 =?utf-8?B?ME1jbGR6bSt4cnFJMFpPclNJdFVqR25oR0VoTWt4dHV2dzcvRmtxS3Zac2Va?=
 =?utf-8?B?MU5XSFJuV2tKR3RjUGJXdStUUS9PcU80WmF2V0dvWjMxRGk3RjB2M0hDL2x3?=
 =?utf-8?B?WHcySC9GbmxZUE9CdkcybWZObkdxTUJUV3lLU25MQVpraW9ZeGxVNWNvM2dU?=
 =?utf-8?B?Z011Y2JEMGVYSkh2VGtlZElidFBScE52NnYrcUVTdG1QQmxYVXF3bExjUzJW?=
 =?utf-8?B?MzFoVFN0T2FIb015UXZNRmpSb0NZaVU4M2cwRXdHY2ZTMFkra0JZby9Udkxh?=
 =?utf-8?B?Z2h2a2Q5OTFxVmlBOFVBNzV1bUxhaHRFbzZyUzU1dm9WRmJXdUI4am0zOXVq?=
 =?utf-8?B?OHlUWmhtMTFCQWJKYTQ0Nmd5S3gwVEhEN1JRWGplbi9kR3hvbE43MXBzYzZV?=
 =?utf-8?B?dlNJQ2ZqRWQzWkNJNGJZd3FpTEJjQWxVUG45Wi9NbjhmVEtrTHZ4eWdScW5k?=
 =?utf-8?B?NUszeXZhVk9TZWFtY1dMR1BzTlU3bUIwcnZ3RFFFT2h5Y20yeDZScWFSRGsr?=
 =?utf-8?B?dnMxOGszSGFSZDdrM0Nydmg4WnVFYWFTS0Q2ckhRRHV3Slc3eUtKdTV1WGtS?=
 =?utf-8?B?a1R4TVRmVEl0Um1DVDBHUVhGVUw5dmR0Yk5sa2pqU0toZndDSXFxeDAxMENM?=
 =?utf-8?B?ZEZURmdHaTRzZWZHaXR2MGFoZmtMeC9PNWdhRXE1eENSTzJLQzZMbkRuVFQv?=
 =?utf-8?B?WjZNY2xFTjZONVJZdW51ZmtleTV0UWt1cldFLzdRcTRaOXhqK1F4ZHZBcndW?=
 =?utf-8?B?VXZLUEo0dkdvVFdlVVNvbUtMV0ZyWExmSTdJU2pUSzVtQ0tMZHBvVFBtODlp?=
 =?utf-8?B?MGRRYlhsRklMZXVQSGhZYS8vTkQ0QnprM2U3UUg2MUtud2ROSkt1Wlk5L24r?=
 =?utf-8?B?cEZ4blFTYXhiS1FyOXhxb1M2TDMxd1VaU1R4ZnpyOEIxL2t5d3VjMitOMzla?=
 =?utf-8?B?YWc1WWxlTFRuMi94S0EweXR1MERxS0toYXRGTDIxS1FQZ1AxSFczUnkzQXdY?=
 =?utf-8?B?RTcvcUxaV2lydzFmQUE4b0NjdmJ6YXlRbG1heUNLRFE5SjU4TzZQcXJMU0Fz?=
 =?utf-8?B?VTh4cXpnVnFJLzB0ZHhhc1ZiNnNsckVRVm1RSUJBbE5DeC8xeVczSHJlZ2xF?=
 =?utf-8?B?b0lEQWtPaUQ1bFpWNjF0aStyZlpubUxSREtiNWdSRlZmRCswb0NTL3F1a0xK?=
 =?utf-8?B?QmZWdlozQkJ4TEtUR1h1eVR6c2N6UUVkUkhncEt2bE1SOXBRaEkrb04rSjVL?=
 =?utf-8?B?QXdVYURKQjVxaVJGWFJ3YVNvZnY4RzRzQXpzVk1yTDZZQkZQVXdBaktnREdP?=
 =?utf-8?Q?pZa/GUJh3j/XO?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7416014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZG5TRHp3NXk0ekEzRGZDbGdKZ3ZKMXp4U1c0MEFzTVBvSkZpSzRCYnIxbEdF?=
 =?utf-8?B?cHhIVU9McEc1cnRmR1JyVCs5NUtEZFQ4RllSSFBZSkdSTkNCVmw5OXhlWDVv?=
 =?utf-8?B?ZWo4Z3U1ZXdWa2xtdEZ2ZWFjMGQweW9aR2MycmZPRFAxR0hObmZWdTR3L1hx?=
 =?utf-8?B?RnlFNzVTS215Nyt0TjdIbDUwV3dhem02TEx2YUs5ODk2RnZUbmRyRXJCaWx5?=
 =?utf-8?B?NXd5ZU9uZk5WeVlzNTBUWG14NWlKMUNiWGpBMkFOYlRrRzg2RlZLS25QdTEz?=
 =?utf-8?B?L0ZtaDZhLzgzSnJrQ01NTWZkZ201UEdnVStEeFNubXBKeFVLODJ2Ui9YdXBz?=
 =?utf-8?B?YlBGTW94dlhNRG9TN3FuK25HT28remFhNVowUWsrQ2h1ZTB0VXhjZ1lGSStn?=
 =?utf-8?B?cGE5cTBSbnF2eXpISVVnV3Z0Mm5jazNmQ3lLYk1HMEJGVjlZTTNjSWliWWZT?=
 =?utf-8?B?RVpxTU9mY3lJQlE2ZnRlYTE4cS9zaExNeTgzTDJCMGdJbFFPa283L2o5Zy9t?=
 =?utf-8?B?MTZkeXc2QzBuT01MU3Y5NXZLZkFWbmhKcjB3N2g4ZlR0aWh4M1hHVHFyU2JB?=
 =?utf-8?B?NWx3dDQ4YkMyR2YxWURvaUovSzFoZFg2RVBkRE5ZMnVBaUpxSXVsNitrS3dl?=
 =?utf-8?B?TmRaSnBKMnByQ2FHU2tVR1RCb1d2aDB0YjJ4aHdqWVhMcG5IR1RCYUo4OGV2?=
 =?utf-8?B?cUNCZGZMOEJMbFFqdHowTStQWHpQTDZRZk5leWVPNjdvNTkzT2NDTlJZSUhE?=
 =?utf-8?B?Y2psclpWSCtNdnAva0hjbnozRlY2Tk04K1VaK3MzdWp2eUVwc3NvVlp0T3Nz?=
 =?utf-8?B?MWdKNUJIYlROZkhwTnI3UVFTNjVxSFczQkF5d0RJbm5xSjc1UHhzMzlEZlBq?=
 =?utf-8?B?bDNCWGEzd1B5bms5a3JLWFBkVTdUb0R4L2doTjE5T0c3Qys2eVRTTkx4Rmd1?=
 =?utf-8?B?OGxpTXRvbGEvQTV5UzA1ck5oZmFFcldkbHgyMmlhYVBpaTR3ZnorT0loUHVt?=
 =?utf-8?B?enlTTVNMQnN2LzRwWWFQMjkyeWllUGtGWlpZcURyMXdQRUdLa0hGT3VhL2hK?=
 =?utf-8?B?ZllFTWpQenhQZlBzU3orZmhEdXRPMnFUMXlDYXhsRjdaSFFBTjBUQ3JIRGRL?=
 =?utf-8?B?d2k3YlNhYk5qSWRPdzY1SEdaeEh5ZzErNlcvVFBqUTRtelozNzFaQTlZNXBh?=
 =?utf-8?B?NG9XRklSNGRweTNMeEZ3RFE5Vlp4VFdibFVxUElJbmRsOUVVOTR1ZGdGNFUx?=
 =?utf-8?B?L3hrcnR5RjdhNW1vOGduSnhSSEFjMDB1WGpoTlBTQ2c4d0pkUmNRb2F2dVFT?=
 =?utf-8?B?cXFDdm9KQUtlWS9QZ0srbzNYSzROV3RxZXpUTjJWTjE3YnRvdFc2S2hEVnFV?=
 =?utf-8?B?TDlKV1FnZjVDVW9LbGFNWWRkdVlyRnhEdDQxOHF4QmRUblR0aERNWE9nVjJy?=
 =?utf-8?B?Q0JUcVQ0TFAyeWVxeUNmM3YzcXhFM1djTkFZOGpmMnNuWGJZY1BxSDlaRldk?=
 =?utf-8?B?VHgxaE5YWFRSWURkcDlaUmZ0SUp2bHJLNkFSVFRXTTdhTjN5eDd2SVZlWWlX?=
 =?utf-8?B?SGt6c2tPZTRoME01cWR1eEVTL0t3UEE2WVp6aDAvRXY5bjlSSGRnRmV5MzRx?=
 =?utf-8?B?RGIvbkpwV2haMHkxa2dmUnJoWjhlR3J6ckhkdUs4cktxaTFvY0RYQUFmbWor?=
 =?utf-8?B?YUdUTFBSUVFEaHQrVlo2c2JLYyt6d1ZIMDZYRWhPdVNUSnNQLzBqa2plVExj?=
 =?utf-8?B?SCs0OXFjSG0xZENjZ3JONzNtQnoyN2NHV0N2STY2a0FzRWFTdnJxcHBibnR4?=
 =?utf-8?B?T3daK08zdEtFeFB5bW8wd1pxbWhIVTFoNW9yV0x6aW1xT01TRkIrRFBXNUE5?=
 =?utf-8?B?TldCdmVrc2RUaW5PNUg2U0JRZ0JoWlVNVmEwWVVUNTdsY3JCNnZUMW90OURn?=
 =?utf-8?B?bjgwYWdCTVdmSTBQdmxBN09xSE9uYmtGME9qVzUvYXJQZllxcDAyUWkxdjhw?=
 =?utf-8?B?b1BnWjBNQTVNVS8zemNkZGEvWm1teml2T1BzcDRNU1NUSFlhRWQ5K29LRzdU?=
 =?utf-8?B?K3ZCT3Fza2lzY1hPejFJTjFGT0VjTlcyUXNjYXhWV1FqUnFkeFA2N0dzYzVJ?=
 =?utf-8?B?aVZGOU40emVoMC91WlpiVUdGNmkyV1pFd2JEeGNzdmp5bXlPYnBVeWhYTDFW?=
 =?utf-8?B?dEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: HD6BFVAn+c04kINynJ2xYx4SCiJC3O85cr+2DW5wQVgBF2CUNTsvbW4zbqutwyqQ4Lm2OvEiUKr4/FQA0BjKaxXC37iPykzA4mar+u5d9d8EIjRt8cxQ7pNujGt1WM68emfi52yov4og2WQe6CqedfSOdz7FnPv4xkxTCzlby+d2SgphgzC3IBcnX1IjpsqCQp49VnKzXchbXlqutzQ2T52r7tj/uLXzt50trHEMi4cAj0233HUTeZSiZFe0NkBo/3U+gtKtf9wGpAVAn/vKWtqKss9h2dEzT8Ydu+5lsCeZM9hLsA3EQmVbGBuFsOyUmcmJrWUn6WRGpKd5peYO+D/MXD23AibSggSONr2U3Tsk4EXA4SFQa0gOHzSwuC8YtAnR3DwpK1ujdJjWUn7EOwAFkGA9KrqlKcPMJ/wTvrtdn5E3TGNS+Z7QSS2s6Gp32TUx/NRNT6DU/xZDcwUBsJu6rokSpIqrsiGO8nTaKH/9+S2QeyJS6eQJLgR/hhoZlMoEmwi8UIXwylh68jb6dxdlhcfnhghoM0URhSf/Ohjcr/gTrjgW952RgiyDGdb2lsEM2X5WoSfJFLKZZPBTEnQtEDjOuhu6t8O4NFeYgtk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 249d1e4a-293f-4aa2-a3b0-08dd207d3907
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2024 22:33:55.8561 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ar8UOsSfbyol4CK2oAN+4XiSbOtq9h2I0d5FE88kgK+Dq7bCumrL8kydWwuqjXqxRB3ZkTvg4aJWqRSKv+tiDtY/mFbyWQc11tFzR5zYqgk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7515
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-19_11,2024-12-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 phishscore=0
 malwarescore=0 bulkscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2412190178
X-Proofpoint-GUID: McZZpSsKNLFbrpBu53FKprINJmIytycA
X-Proofpoint-ORIG-GUID: McZZpSsKNLFbrpBu53FKprINJmIytycA
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1.116,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 12/19/2024 10:46 AM, Peter Xu wrote:
> On Mon, Dec 02, 2024 at 05:20:08AM -0800, Steve Sistare wrote:
>> Add an option to defer making the connecting to the monitor and qtest
>> sockets when calling qtest_init_with_env.  The client makes the connection
>> later by calling qtest_connect_deferred and qtest_qmp_handshake.
>>
>> A test cannot specify port=0 for a deferred connection, because qmp_migrate
>> cannot query for the assigned port, because the monitor is not connected
>> yet.  However, even if the test does not specify port=0, qmp_migrate ->
>> migrate_set_ports unconditionally queries connection parameters.
>> Modify migrate_set_ports to only query when port=0.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> 
> Looks mostly good, nitpicks inline..
> 
>> ---
>>   tests/qtest/libqtest.c          | 80 +++++++++++++++++++++++++----------------
>>   tests/qtest/libqtest.h          | 19 +++++++++-
>>   tests/qtest/migration-helpers.c | 19 +++++-----
>>   tests/qtest/migration-test.c    |  4 +--
>>   4 files changed, 80 insertions(+), 42 deletions(-)
>>
>> diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
>> index 817fd7a..31c4032 100644
>> --- a/tests/qtest/libqtest.c
>> +++ b/tests/qtest/libqtest.c
>> @@ -75,6 +75,8 @@ struct QTestState
>>   {
>>       int fd;
>>       int qmp_fd;
>> +    int sock;
>> +    int qmpsock;
>>       pid_t qemu_pid;  /* our child QEMU process */
>>       int wstatus;
>>   #ifdef _WIN32
>> @@ -442,18 +444,19 @@ static QTestState *G_GNUC_PRINTF(2, 3) qtest_spawn_qemu(const char *qemu_bin,
>>       return s;
>>   }
>>   
>> +static char *qtest_socket_path(const char *suffix)
>> +{
>> +    return g_strdup_printf("%s/qtest-%d.%s", g_get_tmp_dir(), getpid(), suffix);
>> +}
>> +
>>   static QTestState *qtest_init_internal(const char *qemu_bin,
>> -                                       const char *extra_args)
>> +                                       const char *extra_args,
>> +                                       bool defer_connect)
> 
> Suggest to stick with positive logic naming.
> 
> That is, s/defer_connect/do_connect/ or similar, then invert the values in
> callers.

Will do, and will rename qtest_connect_deferred -> qtest_connect.

Thanks for reviewing these last few patches.

>>   {
>>       QTestState *s;
>>       int sock, qmpsock, i;
>> -    gchar *socket_path;
>> -    gchar *qmp_socket_path;
>> -
>> -    socket_path = g_strdup_printf("%s/qtest-%d.sock",
>> -                                  g_get_tmp_dir(), getpid());
>> -    qmp_socket_path = g_strdup_printf("%s/qtest-%d.qmp",
>> -                                      g_get_tmp_dir(), getpid());
>> +    g_autofree gchar *socket_path = qtest_socket_path("sock");
>> +    g_autofree gchar *qmp_socket_path = qtest_socket_path("qmp");
>>   
>>       /*
>>        * It's possible that if an earlier test run crashed it might
>> @@ -485,22 +488,17 @@ static QTestState *qtest_init_internal(const char *qemu_bin,
>>       qtest_client_set_rx_handler(s, qtest_client_socket_recv_line);
>>       qtest_client_set_tx_handler(s, qtest_client_socket_send);
>>   
>> -    s->fd = socket_accept(sock);
>> -    if (s->fd >= 0) {
>> -        s->qmp_fd = socket_accept(qmpsock);
>> -    }
>> -    unlink(socket_path);
>> -    unlink(qmp_socket_path);
>> -    g_free(socket_path);
>> -    g_free(qmp_socket_path);
>> -
>> -    g_assert(s->fd >= 0 && s->qmp_fd >= 0);
>> -
>>       s->rx = g_string_new("");
>>       for (i = 0; i < MAX_IRQ; i++) {
>>           s->irq_level[i] = false;
>>       }
>>   
>> +    s->sock = sock;
>> +    s->qmpsock = qmpsock;
>> +    if (!defer_connect) {
>> +        qtest_connect_deferred(s);
> 
> Now qtest_connect_deferred() itself has nothing to do with the "defer"
> concept.. it is the helper to connect the sockets, so maybe better call it
> qtest_connect_socks(), or similar.
> 
>> +    }
>> +
>>       /*
>>        * Stopping QEMU for debugging is not supported on Windows.
>>        *
>> @@ -515,34 +513,54 @@ static QTestState *qtest_init_internal(const char *qemu_bin,
>>       }
>>   #endif
>>   
>> +   return s;
>> +}
>> +
>> +void qtest_connect_deferred(QTestState *s)
>> +{
>> +    g_autofree gchar *socket_path = qtest_socket_path("sock");
>> +    g_autofree gchar *qmp_socket_path = qtest_socket_path("qmp");
>> +
>> +    g_assert(s->sock >= 0 && s->qmpsock >= 0);
>> +    s->fd = socket_accept(s->sock);
>> +    if (s->fd >= 0) {
>> +        s->qmp_fd = socket_accept(s->qmpsock);
>> +    }
>> +    unlink(socket_path);
>> +    unlink(qmp_socket_path);
>> +    g_assert(s->fd >= 0 && s->qmp_fd >= 0);
>> +    s->sock = s->qmpsock = -1;
>>       /* ask endianness of the target */
>> -
>>       s->big_endian = qtest_query_target_endianness(s);
>> -
>> -   return s;
>>   }
>>   
>>   QTestState *qtest_init_without_qmp_handshake(const char *extra_args)
>>   {
>> -    return qtest_init_internal(qtest_qemu_binary(NULL), extra_args);
>> +    return qtest_init_internal(qtest_qemu_binary(NULL), extra_args, false);
>>   }
>>   
>> -QTestState *qtest_init_with_env(const char *var, const char *extra_args)
>> +void qtest_qmp_handshake(QTestState *s)
>>   {
>> -    QTestState *s = qtest_init_internal(qtest_qemu_binary(var), extra_args);
>> -    QDict *greeting;
>> -
>>       /* Read the QMP greeting and then do the handshake */
>> -    greeting = qtest_qmp_receive(s);
>> +    QDict *greeting = qtest_qmp_receive(s);
>>       qobject_unref(greeting);
>>       qobject_unref(qtest_qmp(s, "{ 'execute': 'qmp_capabilities' }"));
>> +}
>>   
>> +QTestState *qtest_init_with_env(const char *var, const char *extra_args,
>> +                                bool defer_connect)
>> +{
>> +    QTestState *s = qtest_init_internal(qtest_qemu_binary(var), extra_args,
>> +                                        defer_connect);
>> +    if (!defer_connect) {
>> +        qtest_qmp_handshake(s);
>> +    }
>>       return s;
>>   }
>>   
>>   QTestState *qtest_init(const char *extra_args)
>>   {
>> -    return qtest_init_with_env(NULL, extra_args);
>> +    return qtest_init_with_env(NULL, extra_args, false);
>>   }
>>   
>>   QTestState *qtest_vinitf(const char *fmt, va_list ap)
>> @@ -1523,7 +1541,7 @@ static struct MachInfo *qtest_get_machines(const char *var)
>>   
>>       silence_spawn_log = !g_test_verbose();
>>   
>> -    qts = qtest_init_with_env(qemu_var, "-machine none");
>> +    qts = qtest_init_with_env(qemu_var, "-machine none", false);
>>       response = qtest_qmp(qts, "{ 'execute': 'query-machines' }");
>>       g_assert(response);
>>       list = qdict_get_qlist(response, "return");
>> @@ -1578,7 +1596,7 @@ static struct CpuModel *qtest_get_cpu_models(void)
>>   
>>       silence_spawn_log = !g_test_verbose();
>>   
>> -    qts = qtest_init_with_env(NULL, "-machine none");
>> +    qts = qtest_init_with_env(NULL, "-machine none", false);
>>       response = qtest_qmp(qts, "{ 'execute': 'query-cpu-definitions' }");
>>       g_assert(response);
>>       list = qdict_get_qlist(response, "return");
>> diff --git a/tests/qtest/libqtest.h b/tests/qtest/libqtest.h
>> index beb96b1..db76f2c 100644
>> --- a/tests/qtest/libqtest.h
>> +++ b/tests/qtest/libqtest.h
>> @@ -60,13 +60,15 @@ QTestState *qtest_init(const char *extra_args);
>>    * @var: Environment variable from where to take the QEMU binary
>>    * @extra_args: Other arguments to pass to QEMU.  CAUTION: these
>>    * arguments are subject to word splitting and shell evaluation.
>> + * @defer_connect: do not connect to qemu monitor and qtest socket.
>>    *
>>    * Like qtest_init(), but use a different environment variable for the
>>    * QEMU binary.
>>    *
>>    * Returns: #QTestState instance.
>>    */
>> -QTestState *qtest_init_with_env(const char *var, const char *extra_args);
>> +QTestState *qtest_init_with_env(const char *var, const char *extra_args,
>> +                                bool defer_connect);
>>   
>>   /**
>>    * qtest_init_without_qmp_handshake:
>> @@ -78,6 +80,21 @@ QTestState *qtest_init_with_env(const char *var, const char *extra_args);
>>   QTestState *qtest_init_without_qmp_handshake(const char *extra_args);
>>   
>>   /**
>> + * qtest_connect_deferred:
>> + * @s: #QTestState instance to connect
>> + * Connect to qemu monitor and qtest socket, after deferring them in
>> + * qtest_init_with_env.  Does not handshake with the monitor.
>> + */
>> +void qtest_connect_deferred(QTestState *s);
>> +
>> +/**
>> + * qtest_qmp_handshake:
>> + * @s: #QTestState instance to operate on.
>> + * Perform handshake after connecting to qemu monitor.
>> + */
>> +void qtest_qmp_handshake(QTestState *s);
>> +
>> +/**
>>    * qtest_init_with_serial:
>>    * @extra_args: other arguments to pass to QEMU.  CAUTION: these
>>    * arguments are subject to word splitting and shell evaluation.
>> diff --git a/tests/qtest/migration-helpers.c b/tests/qtest/migration-helpers.c
>> index 3f8ba7f..9f39401 100644
>> --- a/tests/qtest/migration-helpers.c
>> +++ b/tests/qtest/migration-helpers.c
>> @@ -127,25 +127,28 @@ migrate_get_connect_qdict(QTestState *who)
>>   
>>   static void migrate_set_ports(QTestState *to, QList *channel_list)
>>   {
>> -    QDict *addr;
>> +    g_autoptr(QDict) addr = NULL;
>>       QListEntry *entry;
>>       const char *addr_port = NULL;
>>   
>> -    addr = migrate_get_connect_qdict(to);
>> -
>>       QLIST_FOREACH_ENTRY(channel_list, entry) {
>>           QDict *channel = qobject_to(QDict, qlist_entry_obj(entry));
>>           QDict *addrdict = qdict_get_qdict(channel, "addr");
>>   
>> -        if (qdict_haskey(addrdict, "port") &&
>> -            qdict_haskey(addr, "port") &&
>> -            (strcmp(qdict_get_str(addrdict, "port"), "0") == 0)) {
>> +        if (!qdict_haskey(addrdict, "port") ||
>> +            strcmp(qdict_get_str(addrdict, "port"), "0")) {
>> +            continue;
>> +        }
>> +
>> +        if (!addr) {
>> +            addr = migrate_get_connect_qdict(to);
> 
> May be good to add a comment above on why the query was done only lazily.
> 
> Meanwhile this chunk of change can be separate; it's relevant to the defer
> idea but still pretty standalone change. Can be one small patch prior to
> this one, IMHO.

Will do both.

> Optional idea, can be for later: if QTestState can have the state showing
> whether the QMP is ready, we could already assert making sure the query
> happens only if the QMP is available.

Good idea, I'll add it now in a small patch.  It already caught bugs as I
flipped defer_connect to do_connect :)

- Steve

>> +        }
>> +
>> +        if (qdict_haskey(addr, "port")) {
>>               addr_port = qdict_get_str(addr, "port");
>>               qdict_put_str(addrdict, "port", addr_port);
>>           }
>>       }
>> -
>> -    qobject_unref(addr);
>>   }
>>   
>>   bool migrate_watch_for_events(QTestState *who, const char *name,
>> diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
>> index 64e1c50..b7001b0 100644
>> --- a/tests/qtest/migration-test.c
>> +++ b/tests/qtest/migration-test.c
>> @@ -844,7 +844,7 @@ static int test_migrate_start(QTestState **from, QTestState **to,
>>                                    args->opts_source ? args->opts_source : "",
>>                                    ignore_stderr);
>>       if (!args->only_target) {
>> -        *from = qtest_init_with_env(QEMU_ENV_SRC, cmd_source);
>> +        *from = qtest_init_with_env(QEMU_ENV_SRC, cmd_source, false);
>>           qtest_qmp_set_event_callback(*from,
>>                                        migrate_watch_for_events,
>>                                        &src_state);
>> @@ -865,7 +865,7 @@ static int test_migrate_start(QTestState **from, QTestState **to,
>>                                    shmem_opts ? shmem_opts : "",
>>                                    args->opts_target ? args->opts_target : "",
>>                                    ignore_stderr);
>> -    *to = qtest_init_with_env(QEMU_ENV_DST, cmd_target);
>> +    *to = qtest_init_with_env(QEMU_ENV_DST, cmd_target, false);
>>       qtest_qmp_set_event_callback(*to,
>>                                    migrate_watch_for_events,
>>                                    &dst_state);
>> -- 
>> 1.8.3.1
>>
> 


