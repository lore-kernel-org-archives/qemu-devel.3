Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE891C3ABAC
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 09:10:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAmPH-00045N-Gg; Fri, 02 May 2025 05:10:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uAmPG-00044K-5m
 for qemu-devel@nongnu.org; Fri, 02 May 2025 05:10:06 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uAmPE-0000Gc-2o
 for qemu-devel@nongnu.org; Fri, 02 May 2025 05:10:05 -0400
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54250bsk006806;
 Fri, 2 May 2025 02:09:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=nj0EoA/d06r0vKxdWTVPJQpmMuQ8e/SDYTHlFV0+j
 20=; b=muHzL1k4RvSi8eDbBSx0QQjycd8JtPAei7yoswa0cfDIW+13wjh09IelT
 mdMkXt3uIifkyHO3+o25dFT4Mn3cj1nT70v1k4xwijS6rIuP0j0pnZWKpstN8hxf
 mqqZoA6+CtYkcFu44vtO/7avl7OoH06j65CxF5GzuPPBDUp+Y2klPm6sl8Q2yT2F
 mMzy89QLxj8iUvUx5me6ec7TxdDaRmibhrwo3fE0QaeGJR0dkTWkXl10KZbk5Sq3
 g4vjqPSvaM5i8Oh3NOVDxvTF2OflxwrdGLDpi4NETxvBdheRkINbx/DwaRNrEJf/
 eb9E/lDh9TdFY66KPIO3fSWeETV2Q==
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2043.outbound.protection.outlook.com [104.47.70.43])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 46b9g65wx3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 02 May 2025 02:09:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VnoNcZyiRTqSBS3Hq2FEOTpHUt0ccoJqYTaVkIL8e9tEIursESd9Dg+/UTiZbCw3iO6VQPIjS8/hykel3pghM+R0WHqlMC9rJ45lepGVsIEBjA21c7f6G8mqc5tCn6qLNFWnje342wmhPK9HpyGa7gztsO2FTHOr3fs6dU8NRSGysRncBQ5nmgvdV6FfsBPrJk3v9m2OPNUQf/1zySHv2xCYkz2mFqgwowF/h8mheRtuOqG96BQM2nNwzSUix6KEistjxY9t/bAOJ/EhHqLm9hr3JXbW0ALWP53xvBQPUoyO0tQuZQ8GSKzFv5CrKZ4WIrRAIfbwHJrV8ZCCF4Onpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nj0EoA/d06r0vKxdWTVPJQpmMuQ8e/SDYTHlFV0+j20=;
 b=UrGLygoVPJNTQzUcw3UIwKkprHPF8MH/ewkq2SHFGbJ1yQdC6Gplkv32tkjsJfyfwbQwvNNhshXSn3Pr4a2CR6vhPqK0ZEesKBe983VxGan/UCAD2cBv/nQRHfN7WlXqnBt2PnqRzVvXuGzP4yw7Mpn+X5UhuqBsFX0qMuANBXQxbxdprPiTlmZmpYDXds7lNxiwGCYT0v/AMVrv+Iret0rZSQecD3O8O3BnGebtWwlIZCnb1HGbwfWdakDtb2zf1yobjmeN2smOmSS7+K80jLSrPWo15/2cGN/aqKYggwyowqCTNuXyKYvPhiprp+8v0aB/OgnYkidM0Ly9F4LMdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nj0EoA/d06r0vKxdWTVPJQpmMuQ8e/SDYTHlFV0+j20=;
 b=nDLxeY7V9oWtv8eJsMKZjvG7fi11kHC10Rb9eheyh7shSDxaFfMnIDLeDoNBb9NNz7vH5HEce/85Qrv2RHcEuf1eCKwrBCchCJPUnJ2YOM1neO1dWXwlcBWVOBIYO15WGJDYN/q3uIhe1dXJNPade3ne6hHTB2xwmFScNedFQqbKgAByzkAzIBYfLC6tDFii0Grbfw2KwZW3nOK3UQSz9SW4tLIZ8YL21CLV4CUAgD3aIcfAGX7DatnPeCAANlhM/Lkc4ZkvnA8DkJxSzEYLUrbqbZS0hEAhLmVJaAaSWTJwNfgHT1/Jk4WyMR0X0bxRQc0orH3VLDtLQOBW7Xz5HA==
Received: from DM5PR02MB3356.namprd02.prod.outlook.com (2603:10b6:4:61::16) by
 SA1PR02MB9846.namprd02.prod.outlook.com (2603:10b6:806:38a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.23; Fri, 2 May
 2025 09:09:41 +0000
Received: from DM5PR02MB3356.namprd02.prod.outlook.com
 ([fe80::72bd:6790:f9e7:f241]) by DM5PR02MB3356.namprd02.prod.outlook.com
 ([fe80::72bd:6790:f9e7:f241%3]) with mapi id 15.20.8699.012; Fri, 2 May 2025
 09:09:41 +0000
Message-ID: <6b7ae7e9-3184-468a-8bc0-dd816bf80547@nutanix.com>
Date: Fri, 2 May 2025 10:09:36 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/16] hw/i386/pc: Remove pc_compat_2_6[] array
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Igor Mammedov <imammedo@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Cl=C3=A9ment_Mathieu--Drif?= <clement.mathieu--drif@eviden.com>,
 Yi Liu <yi.l.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Amit Shah <amit@kernel.org>, Zhao Liu <zhao1.liu@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Sergio Lopez <slp@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Yanan Wang <wangyanan55@huawei.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Ani Sinha <anisinha@redhat.com>, Thomas Huth <thuth@redhat.com>
References: <20250501183628.87479-1-philmd@linaro.org>
 <20250501183628.87479-5-philmd@linaro.org>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <20250501183628.87479-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM8P190CA0001.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:219::6) To DM5PR02MB3356.namprd02.prod.outlook.com
 (2603:10b6:4:61::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR02MB3356:EE_|SA1PR02MB9846:EE_
X-MS-Office365-Filtering-Correlation-Id: 0760c440-ef63-4add-e2c5-08dd895912b7
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|10070799003|1800799024|366016|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WFBPMVpGVnIzWm81TTlreWRUaEdZVUZpV0VSWHFUNmNOVXJ2Uklmbm1ra1oy?=
 =?utf-8?B?R1NjdjFFamRIckJCd1VQS2tBWlBIeE95UXphZXNyRFpPYk4xZU00YkpkSjkx?=
 =?utf-8?B?V0VtV0hnZGZOMjY4cy83STlsaVlnWHQzWnZ2V2xPU24rNDVlc2svcnQ4ejlz?=
 =?utf-8?B?a0ZZMk5qcWlPck8yTEluZGNmb09oVmdLMVpqU1ZDTk9ORlR1VW9TbUVUWmd4?=
 =?utf-8?B?NmFoY0JwY3plbFNZZXMxd0pRSlYySUZZREF3UEhxNnhGbWlwMU9CNkFOdFkx?=
 =?utf-8?B?eW8rSzN6T21jUlQzVnlYa3VoV3RZSElSQkJFdXZ6a21TY0xvMzNtOVBiTWI0?=
 =?utf-8?B?dDBuU01ZS2ViUTIvbGwrdVlPaWtGWU0xSGNrb2V0aXZpYjRLR1VLcldpempP?=
 =?utf-8?B?dVBCZjNyenNBQ0YxWjZqcTVhY0tZd1dTYTd2cWxETEpyNzcwemJVQVpzOTNm?=
 =?utf-8?B?WjJ0bEd0S1ZHRU1VNERCcDZpVGpFbU9nUjBCRmQ0eHkyWlNBdUZEYkY2MmU0?=
 =?utf-8?B?TkZzcDFtRXBKNWwwWkdycERHVUk2U3g5VG50WTVjOTI3TS9SWS9XeG1QTDBR?=
 =?utf-8?B?NFQxeFU5ZnMya0tac1R3cjhFaVJwSzkyRVFvbXlVVk9BR2dKU3ArczRxd0Yw?=
 =?utf-8?B?czMvbjZQSjgyQjF3OEc5elhGYlI0Y1hGbnNoS05sb1hDalZ2bldwcTNTRzlE?=
 =?utf-8?B?b01sUzJnMDhLSzNsL3ExMmxqNkxrZWxQendxMjNKOVZyMGI0V3lDbVVYWmcr?=
 =?utf-8?B?ekhZMjNjZGFWQ0hzbFlaTlZybUthMzhmNFBFalpyQmJqTDM3c0FwR0pYc1FX?=
 =?utf-8?B?VExUZUo0TE81bW1JZExvaUU0ckY1ODVDTUEwY0MzZk1hWDVCWm42Z2dYODV3?=
 =?utf-8?B?RzA2bHpqMVR0M1ZQSlRUSm1SVW9GRHUvRzdsc1k4NStMeURKcXpwOUluUWVC?=
 =?utf-8?B?OE5jK1k3VnN5OHp5YXhPYW9rMHlQMzN4eElqOVFHajhxSDFtU1NmVEd0VlFl?=
 =?utf-8?B?OWVkZE4yVWc0RkRMNGo4c2xyQUxXTkdFUE5kS05kalF6Nk1DMUxOV21ham5B?=
 =?utf-8?B?dFdhTnhyQnNOeDJsaC9GMDRCSnUwVC9qOVpTNTkveWZ4S0MrMk1PNFVkTVJ3?=
 =?utf-8?B?dlpoZ2NKZ3J1QUI3UGVuS3VqMFdLNmZVZEgySXlQdXJ1REVMQzR4bVFPaTUx?=
 =?utf-8?B?OUZkcDNScUUramIvM0Q5cHcxL25LaElNZWhoczJGSVVjTlBJdGNPeEF3cWZH?=
 =?utf-8?B?M1BEK1psWW00YmtNUmtUUjRhbWg0MmxhS0ZkTy9jQUhueENuVzhsUUZzQjNL?=
 =?utf-8?B?R3RhU0tvdmVxRE9GWjJLMDdSd1lxa296Yi9CcmtaSmcrZlJQckdwUTlYbzQw?=
 =?utf-8?B?T1J3ZW1IZnJLYjlPZlI1bXlRdkxrMjNuM1g5L3VNK1BxcUxQeFljeU9lVm0x?=
 =?utf-8?B?emlJQ1N0dk1MbktuVThHWG1nTTRrdk9MeGNJUFI4YUdtQnQzcEcxMkFFbWJJ?=
 =?utf-8?B?bzhnOHI1cXRCYWdvd2VJamhYL0JkTEN5SjVaLzFnbjdMdnJZUzJ6WnlxdFpt?=
 =?utf-8?B?bWxNbXpLOWd0YU0xdkMxT00zS3E5UXFhVmtPS1VoSG5QNXR4RGZvQkc0SERI?=
 =?utf-8?B?R0k4WXRScy9tUUJwUCttYUFNT0VTM0toalNFY2VTa3hqdlJrbEZCeTBQVUJh?=
 =?utf-8?B?bkdUcW45V1cvRFErZ3BkZUNyeDlrbmIyMXM5TXMvYUZrc2FGTXV4U01TT3Vj?=
 =?utf-8?B?cWJybWNUdnoyT0taaE5hY1VucWFZOFlxeTJORTUzOHVtR1FRczNRUkdzeWMy?=
 =?utf-8?B?ZlFLOVVqaVJDeDhWN2s2MWdmdms1WTVyVnBXOFlqRElkaFhKQi82SFhqMnFY?=
 =?utf-8?B?SjdWejVlUnVhZkFMWFRnWHZxT2ZhRjhXaER3NTEwQ2ZiSWFIdzMrZ3d0K2sz?=
 =?utf-8?Q?fSabKlW9C6E=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR02MB3356.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(10070799003)(1800799024)(366016)(7053199007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MTJYc3p2cGJkNHJuOTYyd3A2NDY4bW5GVHF2Vm1naVFFZ09tUE9VcjZEY1I0?=
 =?utf-8?B?UFJhM1dITVpoajdTUnlnLy96OFRyNHl1bXkwcFFiT2pZQURTY3AzTzRoM1Ev?=
 =?utf-8?B?ZGMzRXRCRkRFNGhoRTVCZVBpN1pHOHB6NXBnWVdQeC9pd2xmZitkVGpkbkpt?=
 =?utf-8?B?c3FtMi9wNkt3Tk5sUFZSNGNyMDdjZjVRT1JML3Z0N0tZRzRRaWIrWlBRK3hr?=
 =?utf-8?B?bFNNYlR6aGw2L2Q0QjVidEVaYVhvWVFNeFlyUXdqWTJrbWhmVVV2Zyt2a04z?=
 =?utf-8?B?YkNFSHlnVUs4aWlna0QxZ0JDQlV6aDVjYjYrUVdOWjFnaE51QWR4bmgzTWFl?=
 =?utf-8?B?R1VJNGhqcCtHYVhwM2xCQWRmMjJ6UjlUbWVqWWd6SWh5VVJPYmw5M3kzdWtL?=
 =?utf-8?B?WDRrLy9QcjhTNHFWK2dNYmFVQWtqWXlIN2JrczRSY0E0elczQWF4eDhmV25B?=
 =?utf-8?B?bVh5cnU2WkI5VEJmUVZDMzd3Ulo0MXF1YzhYV255SW1TWmY5RUM3Q01TMFV2?=
 =?utf-8?B?MUVCZUFYUzdTaTlUWUh1Y0IxVUJhWFI4UlBPNWJkd2k3cUlnaVZBdmlaeXRM?=
 =?utf-8?B?bnZKL1F3NmNZOWZCZDNlYXhsdWRWWEFWWkk4ZHhDVWRqQWNRdHIvSVpzTG5S?=
 =?utf-8?B?R0ljNU0yV3lNVElNZXVhQTdPNUxRMExtenhwUU1rNlNGTm9DRWgrUzFCNk9J?=
 =?utf-8?B?ZU9kcER1L3hES0psTDZrVGxvTWdRNndSNEZJVEE3TkxJRGg1YVB5MG11dnEx?=
 =?utf-8?B?TkNmSmtxY1ozN3RHTDBLeW9nZEhxQk5JVkZQQkFCYWZvbU9NeDFwc1lPRDFU?=
 =?utf-8?B?WlNFdURVNVFST2o1Mm90Qi9Ha3NneEFseFZvT3ZrSjZjQXV0QllKM0d2YzdJ?=
 =?utf-8?B?RGUvZVUrcVZSSjl3VldWMFlCWWxuWVdUNXhMR3U5WGN5MFFTa0xEQlFFWEU0?=
 =?utf-8?B?d3grQzBaMG04WFRleDk3M2FMREYzUVlQeVFSQjduYlhCb3BQNnI4dnNTRE5N?=
 =?utf-8?B?cTRRU3RDdFpLRjBPWlhmT2haZGc1L3dMYXNjSmRCVmJGZi85MVFHZCtNZTM3?=
 =?utf-8?B?L1NWYmYzTEVXam1Dc3pnQ1B0UHh0MGxhc3NkL2haL255dm1FOUllZ1BjK2lY?=
 =?utf-8?B?bnNyVDRFNGpqK1VxUUw5ZDRsRTBlSnlPcnZERG43bnhJRkxHV2ZKRzRJNkdC?=
 =?utf-8?B?MUw5YzhlMk51ZG1Sam94aC9OTkVMYWhNWjcyZjQ1S3pjL0FQZTJVaTBubUV0?=
 =?utf-8?B?WFNUY3hEcE5CSytHNmgrMmVJaTlXTDZZVUtqRm5rVEtYNGdrL0FVWENzQTBG?=
 =?utf-8?B?NVczRXgrZ2w2VTM3WEsvYWtud1YzZkovMUNrL0ZFcnVtSGVQMENCb1RZVit6?=
 =?utf-8?B?MGp0b2dWL2F5OUlFT0FVaDgveHZPM1VFeUtDTDVNNXk2L2Z5SURRUmpMNjA3?=
 =?utf-8?B?bjVhTHV1ZmZGdDQrSkNSMzhpcGNIUjU4cjl1MGNDRXRHczMwY2pqWGhpMm5q?=
 =?utf-8?B?VjVqT29HR0N0RDR5ZS9aQSt1Q2o3K0YycCtPcm9qWFJoZkpjaFVWSXZseXpN?=
 =?utf-8?B?UEdzdlRCWXBINDF6TWxSczhZQW5LZzBzL1k1MWxzWWVKUzl4ZjM4bXQxOTEx?=
 =?utf-8?B?eGUvNWpRd0o5Szc1eGduZnNtVzlMMU1EUGo0dEd2MXI0ZmtVTFJxOU9ZN0wy?=
 =?utf-8?B?ZFNRakxqNlJ3YWhoVGs4RUJVRHRpS1ljUVNqYTk4TzlQMUxQT1pvdm40WHp4?=
 =?utf-8?B?VlBVdURxa3o1ZUs2MmlBekVFQ1NhR00rWHErcCs0SitTc0U2WkpPVkNGVVkv?=
 =?utf-8?B?MGkyTUpvY2JWOUxZR1dXcGloWVVRZ1VudFkrSVU5Q0l6OU9MdWYrRG0vRVBv?=
 =?utf-8?B?dDhSK0lVNjh0T015K1MzcFNtR0FrS1JKc3lyeGxSeTlMbkw0V1BpVW5KdUtW?=
 =?utf-8?B?Q0FXK3lEWjUvS1ZlRWxxUjFUSTlBOEhBN3pUdFROVHVmMHFpUGtDZmZkc0NP?=
 =?utf-8?B?enltLzc2azU4MkRyZGQ4VEpBQVhHZmN0cjlDc2hCSUF3SnFqYzRiWm92bXpX?=
 =?utf-8?B?TkJua2FjYklheFlBdUcwY0c2eVVsRERCYmx1WnlLS0NYeVIzc2p2Z1ZxSnk5?=
 =?utf-8?B?QWFhMTU3U25jTVNQWGVadjNHSHgxbzlDT1NTMjI1aC9kcmN2LzFnV2trNGRt?=
 =?utf-8?B?NDFLMzNlbXp5NWFPQVpDMk9Pd2hwdUVXdXg1T1ZUR2sxNU1BbmpPanNjMTN6?=
 =?utf-8?B?SnJKWGdtcjB1RVI0N2RIMlp3eE5RPT0=?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0760c440-ef63-4add-e2c5-08dd895912b7
X-MS-Exchange-CrossTenant-AuthSource: DM5PR02MB3356.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2025 09:09:41.7667 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u/l6FySmz9ucLEJi7RITN8clR8zgQgv8GIjrHsuwTNzwk7LA0uZrfuKNdSf9QwI8ZN5JSFU+B999RhiajLqO07pcBMCWkZBEzfh/V2D0Zk0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR02MB9846
X-Authority-Analysis: v=2.4 cv=GolC+l1C c=1 sm=1 tr=0 ts=68148bd8 cx=c_pps
 a=GoGv2RwMe+/7w9MjyR+VRg==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=dt9VzEwgFbYA:10 a=0kUYKlekyDsA:10 a=KKAkSRfTAAAA:8 a=64Cc0HZtAAAA:8
 a=_Spef7VVIuDBvoLkSCEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: lUVG2Hz-eCyOa80YiNygu0hCxkiHDYSF
X-Proofpoint-ORIG-GUID: lUVG2Hz-eCyOa80YiNygu0hCxkiHDYSF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTAyMDA3MSBTYWx0ZWRfX0WfZP0oWAVfY
 JD3dmbOdyd3twMLtBlDidNRNBzsd5l6Sjq71hNE3SnLlww20DNgK3/E5xpI96vC2Ytp76VBTTCs
 2l5KmBkkIbEwmqFte86JDWC9fTtKG6LxJwC8q2/+Yk8MhXjQ9Siev/op3pBGXnBFAFoL/3RZp0o
 0cxn3k3bW7aa0tKfFldXNAuezaXRuxzeGnmRWQMVB/kauahB8CXvkhLszgcpsKXOXiy0GuOvFnP
 iK6QF3sf/MiA78UOEmSuM1pbXyxlW7JUqx3dixsPQLbCOF42zExB4H/wP3TNOilbpGwRpMrdnLi
 B7fqE2TWD5AaR4r+gm07v5qt6m/HFGPzgEOy+tIwVXo049CXjVvCZyY7VVO7N3ngfxz8PvSW417
 PgMaoGJ7xX6rSD64kiBuqK/FS6tRWyTWXTlOQYdrCrkObGEBbKTupzLpja+60tUHZzYbyu9u
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-01_06,2025-04-30_01,2025-02-21_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.644,
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

On 01/05/2025 19:36, Philippe Mathieu-Daudé wrote:

> The pc_compat_2_6[] array was only used by the pc-q35-2.6
> and pc-i440fx-2.6 machines, which got removed. Remove it.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/hw/i386/pc.h | 3 ---
>   hw/i386/pc.c         | 8 --------
>   2 files changed, 11 deletions(-)
> 
> diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> index a3de3e9560d..4fb2033bc54 100644
> --- a/include/hw/i386/pc.h
> +++ b/include/hw/i386/pc.h
> @@ -292,9 +292,6 @@ extern const size_t pc_compat_2_8_len;
>   extern GlobalProperty pc_compat_2_7[];
>   extern const size_t pc_compat_2_7_len;
>   
> -extern GlobalProperty pc_compat_2_6[];
> -extern const size_t pc_compat_2_6_len;
> -
>   #define DEFINE_PC_MACHINE(suffix, namestr, initfn, optsfn) \
>       static void pc_machine_##suffix##_class_init(ObjectClass *oc, \
>                                                    const void *data) \
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 49632b69d29..7573b880905 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -251,14 +251,6 @@ GlobalProperty pc_compat_2_7[] = {
>   };
>   const size_t pc_compat_2_7_len = G_N_ELEMENTS(pc_compat_2_7);
>   
> -GlobalProperty pc_compat_2_6[] = {
> -    { TYPE_X86_CPU, "cpuid-0xb", "off" },
> -    { "vmxnet3", "romfile", "" },
> -    { TYPE_X86_CPU, "fill-mtrr-mask", "off" },
> -    { "apic-common", "legacy-instance-id", "on", }
> -};
> -const size_t pc_compat_2_6_len = G_N_ELEMENTS(pc_compat_2_6);
> -
>   /*
>    * @PC_FW_DATA:
>    * Size of the chunk of memory at the top of RAM for the BIOS ACPI tables

Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>


ATB,

Mark.


