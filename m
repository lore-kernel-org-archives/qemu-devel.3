Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B05FC3ABAC
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 09:34:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAmmV-0005Lm-RF; Fri, 02 May 2025 05:34:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uAmmO-0005KZ-Io
 for qemu-devel@nongnu.org; Fri, 02 May 2025 05:34:00 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uAmmE-0007EU-5w
 for qemu-devel@nongnu.org; Fri, 02 May 2025 05:34:00 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 541MZQbV018501;
 Fri, 2 May 2025 02:33:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=0y6PXTkd19QXdeEDOe3dvKEXphQ4dZB6NKpPf/aY7
 J8=; b=oyFmqXyHqWMEd944Pp3mJkfBydUKw1TP7afbttY7HCBi7t+erRHsDoXqi
 CPLZOc+95z9bf7LQFCcQiuZCG6xkOcPA5E+3Rpwv+YzDAoksSxLiaabKtNlWhpVB
 PNJRosqaduS0zF8L1VaBj4jOIcIR7SuZ91/jxlL1WaJdVCdTsGMyAifIpO0+2m9S
 9YNCoOX41SEVuNAc5bHUykZiELgWCzb2D79WkklYd/J8gvyEiHNPgsX3Za2DrZjv
 43kp6YbBSMNbLWCXVcOd81b5kxQhEm+eevZxTvITpeP2HThhXl3DS6AyEhWisUb3
 Zfc9AEZpwcFrvqYxjEDPdpE7YA/kw==
Received: from nam04-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam04lp2041.outbound.protection.outlook.com [104.47.74.41])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 468xjk5a53-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 02 May 2025 02:33:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pxFCw7fqxuyJV1r+wIFejfFuunoYH2o88bhn3cOuvQFGzFWxqD5w8jGyvwtC/1nzL16+ptPIyG8fFnRgHtWP1RhiwX/0VaBobRLz8FWwrnt9xMj4d3PgfSrzXF8R6U/eduFwkRCoNnpNgf2J1M9h6TnIQFEfA39ZISnqYaRkc2pdB/ot4JAV8yqnJRtyWPEaTdpa5vuH1MpUY8LNey0YGFwsNcNiPjSH0kkrL7WNggLQXlLRif3XbwdMolsRE3XiVW4sk6xwv08UCePRRYcTGpWSTpRLcTNRyHd36shVMxI6FVYH0dE0Z+8rM4qiYw5XoN+nnIDqG2czZboEfAEMUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0y6PXTkd19QXdeEDOe3dvKEXphQ4dZB6NKpPf/aY7J8=;
 b=A0PunsbqYRREfo+FtDiEvAdugB/aOlleRLUHZWlFeoOoPeHbrtW3rrPk52Csk4/xhUBGeHIdm4WFEdM9QZzaWOdJvyUFFGTb9F7/iv4bkIyhptUC9q7FEAOQ2DdnVG7yAjcrqJG0mPZMnP+a5AeF+yL+jpDdEGgOCrMo0CATmuQsYITugZbYhsVM3loLRJTKpy/JjVamMwwrRj6TJhipRJ7Z4GOGUCA1VFinTJkEezoL8aAxIdovVDljPNyBTEY+XTR4+UmsG6IZo/hkRs0CVVZIkQL6/7i4xJlpH2Bv1YhNTRyO+LwayMxpYbmmYVOXTAVCRLu2cxQjZIquUzjoTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0y6PXTkd19QXdeEDOe3dvKEXphQ4dZB6NKpPf/aY7J8=;
 b=LmYU+kT8Eq2Vsf+YTxrwF6N2WutFVq5k1FsBn2roFv3j6NMXhCyXPMoUqiA9FZtNvUdStHvGNx0/vf8/6VGef2CfHkz+Xxe5EJn/xKWiaSALtUPzicEokBjex/xpQbMWOF2ByV2w2A/WbkjGcMuSlFuqQ32b0AShDjhZ9iKOpy+YYI/tVfnemfaegvyZn91xxdrwPA7M2SEkae9F/V4VDzE8ZRLQH9sYLHdcuSMRt2s1WfJ4Qm1IjrOKKO7CEd/YhTw0HzLaTNz5hZq1VLqdUPu3hVpKjIHZdg3Ruxk/WDm/XAHTDYBLqzeS22JDvssAeISx5cOXbtdHCizKh5oePg==
Received: from DM5PR02MB3356.namprd02.prod.outlook.com (2603:10b6:4:61::16) by
 CH3PR02MB9939.namprd02.prod.outlook.com (2603:10b6:610:1a1::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8699.24; Fri, 2 May 2025 09:33:29 +0000
Received: from DM5PR02MB3356.namprd02.prod.outlook.com
 ([fe80::72bd:6790:f9e7:f241]) by DM5PR02MB3356.namprd02.prod.outlook.com
 ([fe80::72bd:6790:f9e7:f241%3]) with mapi id 15.20.8699.012; Fri, 2 May 2025
 09:33:29 +0000
Message-ID: <073c8187-fccf-4e92-a706-77d7b0303675@nutanix.com>
Date: Fri, 2 May 2025 10:33:23 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 14/16] hw/virtio/virtio-pci: Remove
 VirtIOPCIProxy::ignore_backend_features field
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
 <20250501183628.87479-15-philmd@linaro.org>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <20250501183628.87479-15-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM9P195CA0026.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:21f::31) To DM5PR02MB3356.namprd02.prod.outlook.com
 (2603:10b6:4:61::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR02MB3356:EE_|CH3PR02MB9939:EE_
X-MS-Office365-Filtering-Correlation-Id: 012278b6-3da7-415f-d739-08dd895c6578
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|10070799003|366016|1800799024|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VGF6ZjlValRuZTdHQStHeEk0cy8yMG1wbUtYUUI4UmFSWUhrT0lpZktzb2Fp?=
 =?utf-8?B?eDdFdTBKQWszQ2kzVkdQVHE3d3QvVXJKd0pUdjB6SFp5V09xaXQyWDEwZU5m?=
 =?utf-8?B?MW11TE9NckVPcWVwV0pKYUlMQ1F5STZHY3czNDZwcms0R1A3Mnpva3pRc0tK?=
 =?utf-8?B?K0pkakdVNFkvd3pwZkZTbnh0VnhMbGVIemVsY3RxeTlhVit5V2lHd1dabkp6?=
 =?utf-8?B?M3p6VjlIdS9mWEZ1Tjk4cXNYOUYzUjVnK09VcjBEZXM2K2s4WjJ6UVpsVC9m?=
 =?utf-8?B?TVIxaDJkQkJqeUZyTmJCTk5CYmJ1YmJJVjVvUERlN0s5Ky9Yd0xIejRLK3Rw?=
 =?utf-8?B?bWg3WDRuMXJ1NVJCbW5JellVS3hnUnIzem5kcFhEUllGQUVGdEMvM3ArQytL?=
 =?utf-8?B?WUtCbHF0QWhkMElPbnpIMjRJWkJDK0ZvaHJZbm9MMXNSdlh2VFFWeVZ3MUVY?=
 =?utf-8?B?UnBkQ3JEM2lrb2tueFAxbkIrZTUzK0Z2cSt5ZFlyakh6MEFjSmZqSnQrdjhY?=
 =?utf-8?B?a1h1eVd6ME5OZWR0L0tyTFkxS2dKZ0cxRS9SRFZEUC9KUmV4S0dpcUZDOHpk?=
 =?utf-8?B?UVhEblBScXpJNVRFbWh5MHhiYkF5bldQVHZoRFdyTmFKN3hOSTFIcU9kTEw3?=
 =?utf-8?B?cVV3YTRPNFFmVitrVFhYY0VmT3ZIRGd2blViaUZTZldsNnA3ZHM0aDd6ZDVP?=
 =?utf-8?B?bFlDTk96RzhuK3E0eU1SM2hscmpFTmJUSTRMcFIyVlNxaC9vRDZxTlhFbG9E?=
 =?utf-8?B?bEJsazVicHhOcGhMZGJJanVBMTlkWDB3RHBFZUZELzJHRmJsc3Y5ZzBHcERS?=
 =?utf-8?B?ZHZrVVllVW4veCtEbTYzdUVNOGNvYk11dHErWit4Y0ZTQUR5T3hvM1dQVENH?=
 =?utf-8?B?aDlLUU9KWkd6NzM5amtZcnJ6RmlmaEpXWWFiM2hjSFBvWnpPeEhuL2VYc05p?=
 =?utf-8?B?MHdscFdBWU1OSVJCWmUycDRWbTdPS3paeTZHVk9vNkdCL0xQQ1E4Z0NpWTRu?=
 =?utf-8?B?Mkt2SUp5a05oSGVSV2MwMEdXQjdNajhXcUNxaGh2Y0MvNUkwSEFYa281QUh5?=
 =?utf-8?B?bVFra3BIQVFGblVic0FoSEhxRWQwTjh4SDVBK0ZlWFUrQTlPRkNwNWxMR1Nv?=
 =?utf-8?B?N3ZxZjQ1S2h3N2M5aFZmdEFwMGJnVVFQM3IwbWQrVjlhUlVJb3VtYld0Yy9i?=
 =?utf-8?B?R2hkbFVIRzg4aEliaFdGQXZsTzNEaklHbDJtNzY3bGZsOVRvOEZ1RloxeFdq?=
 =?utf-8?B?bWJSKzYvalVFNG5lcXp5RmRRVCtPOWdVUG91ZVRsZU8vMVFlc3ZEdDQ2Z3JZ?=
 =?utf-8?B?THNpSFVQYVpOQkpJY0RDQlRQb0tsMXNaK3M0ZnBlZ1V3cDUyTTV3bU9yM3Zz?=
 =?utf-8?B?NTlYYjdZeE9ucFhBRHkwRzNFVExNVDBNdUdtSkxMTGFkVHdzRnhyZXRsY0R1?=
 =?utf-8?B?UVA2Rkd6Ti9qc0NYM2RaTWd6eWNrVTgwb2VmZjA2dys3U25lMHI4RHVEbTVV?=
 =?utf-8?B?MTIyQS9WNmJhVG1UY1lqVGZvUlpSaWYyZC8xaTVtS2JxN2t4YmdmaHVKL0c3?=
 =?utf-8?B?V05Memdjc1kyQkJxL2Jwa3FyVUdqeHlHTnpVWUhTZTdXWDZzeXg2WWV6L2NY?=
 =?utf-8?B?am9oYVhtREI2MXVEc2Y0SkVETWg3ZlhhZ1kwZW83eUpnUkZ3dWFZSEVVUHJl?=
 =?utf-8?B?ZEsyRkVpV0RRUHU4aUpzMk1UVTFab2JFbEx0czJZclpSU0txVVpJbklSczhK?=
 =?utf-8?B?c3NHWHV5elNTdkxsbS8zaHg0NUUyRWltcVJaVFlpdit2ZUIzWGh2cVRGQlE3?=
 =?utf-8?B?dVVHZ0pPenl4VUNQYjIvTDU2SkxZcWxvQnV2OUJCVkg2ZnUyOWt5T1puRmd6?=
 =?utf-8?B?REoyZ1lVRzJXdHlleW9NRXE3RFVtZDBiNDlVTGlXcDI5YzF5R2t6RG9aM2Vh?=
 =?utf-8?Q?qDixkJA2zNg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR02MB3356.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(10070799003)(366016)(1800799024)(7053199007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ejFCcTV6bld2QVRrakFpVWxMU3A1VDdWWmYyL0dtMzlqemtOYS9GR0dZZHg1?=
 =?utf-8?B?RnJiSDZKWVNHanBCZUZXRk0ranFyVDJ5dHp5U2luU01IOUFUYlgya0VKWFlw?=
 =?utf-8?B?dHlwcWJOWWF4M0VUQ2NsUXAzbWN1ekY1ekNwZVFvTFI3cTNENHBOY0M2cWxI?=
 =?utf-8?B?UWllRGxJOHFEaDd4aTNOcDFPMjVRM3BremVFTkJSeFZRSkhISkhrcCtXYmRL?=
 =?utf-8?B?TUJjaHFwRXdmRXlhNFFjVnFHb3Bid296OTFoNTh6TGM4cmlBa3oxSlF1Ty9j?=
 =?utf-8?B?TTM5UU1wcWlJcGJXandBdXoxRGh2WHNGcUVmeGg4RTRGMEJ6VVl2VGdZU3Iv?=
 =?utf-8?B?WWxCc3F6OHNiTUtMR0k4c09xNDZ2SWR0eVZOVEp0ZzJlc01KMGYxQ0tBUWtB?=
 =?utf-8?B?M2dTVGxCUU02ZEQxS0JKWmJuZlkwN3ozUHhwcDZKTDlHb1hVQjl6S3dsZ1Zr?=
 =?utf-8?B?aklZNENiVUFiZ2QzcVZxVVhKam1MNFg4NUZpVFNYUmVwemN3MHFnbTJQUHBD?=
 =?utf-8?B?TG5SUVpuZ205K1V6aVhDdXFKWEdNWnFQbXVCbllqUEtRTDF6WlVoVy9lcW5V?=
 =?utf-8?B?U0FTTjlNbVJ2Q3lEMTdubjhkMFhlSGRWMWhLL3RpdEVxNTdid0R5dG9ZcDJD?=
 =?utf-8?B?MVVGcUZkQU54RjlLRVVsVWwvZG9ENW9iaXd6aVh2SXhQOURFK200RnczbkhL?=
 =?utf-8?B?bEdpWDcwTlB2YklSQllvNTV5Z3AvcUtURnZSU0JPVkZUWTlXY3pQLzhBTTF5?=
 =?utf-8?B?VkNDN1FlN2VzZ2VPRm9EQWRSQnZ0MktVaERvcDNWT095ZDc2K2ozdm5CM3RH?=
 =?utf-8?B?d2xBQ05DKzJ6TGpxMHo5N0F0RW80NXVCYVJBM1pjQmNxOUl2cEorSXJDMzZs?=
 =?utf-8?B?QlYza0JxRzF6VXBUbllnbkJwOTlQSnNNdGZGWUIzTm5uZTlzdzlZK0JlRFpq?=
 =?utf-8?B?aEY4Mnc0VEhhV0YvcFM3K3JEaGozOHBCc05NdDRRYUdLYWhsQ1c5N29CZUVV?=
 =?utf-8?B?OUtlTHhkRnRBTTlVYW03T0RqbnEwMDlXVll2dW5WcXcwL2hGY3h1RWRYOVpZ?=
 =?utf-8?B?d0hhWlBlcnl2anhpaHQwNFJqNjJ3K0hpQkZ1Kzgxd2htWmpBdkVwQU9BTWhG?=
 =?utf-8?B?bXE5SnhjalQvdWx6bm9sNUZ1S0tFdUFaSTFBaHJsRXB1QldJS3V1Ni9IcHFT?=
 =?utf-8?B?MFprUmUxZitHZlZWaVlHY1pkcU04a2JhdkVrY1dJRGZqd0lrTDd1T2hHaGla?=
 =?utf-8?B?VmRUaVdrRFNEcXZuT1dFaXVSUUJhL0ZJTkYzWU95MFM2VTRNdDdPQ0tqWXNx?=
 =?utf-8?B?L2hGNE9SNy9KNDdIRTZVUHRLeUxhbmJWc1J4R3NWY1Q4aWxzR3JtVjVwR1hm?=
 =?utf-8?B?aUZlQUFPUm1INk5TR1NNbk5TZkNDUURObVVRamI4RXlQcUNtQmJyeHYzcXM2?=
 =?utf-8?B?cGViVDZZUDNrWkVYTkdvSXhXV0VOaGtWUmdHbXgwU2pFSmw4azBlcTNsc0hv?=
 =?utf-8?B?TUMvOHQxM2RqTHd2RVlHYm45eGsvQ3M5RDZ1WHh5VUNKdENDMlhEd3hMMEE4?=
 =?utf-8?B?WUdCV3p3N3BLb2hNaXFWVFBPK0o5Y2pMT0laQy9uNENWa01QbnA2SzBvOVFW?=
 =?utf-8?B?YWFKL0hMQURGcVB1UXdYbG1WYzhrZUN6RStRQVJ2RVdrckVNRThTMXdxOGJD?=
 =?utf-8?B?MzJGdGc1bkYzWDloTnRhekN3NjhWOWgyNWdmWWdMaFFHZmQwQXJiT2M5OThQ?=
 =?utf-8?B?TDZHWHB5cHJTV1NtWDdOSU5tank5bHdrWXhFMVEyZFQ4MXhMTDl1QXVGcUNh?=
 =?utf-8?B?N3hiYnU0dWFhK2F5c2ZiTTlDS0RwOFpLQmwzcmZocGNNUTZDVDZET3ZUb2la?=
 =?utf-8?B?MUplSTB4UUxldkpqK1VITWw2SzRMeE04cUlBMlFlNmR6OHk5c3J2eWFQSzBK?=
 =?utf-8?B?K0M2QUEyVnB1cVB5SUNoREdoVHFyZm1BeEdzc1lLeUFGOUhRVXFqN1JHVUNH?=
 =?utf-8?B?dG5CbTJ0Y2ZDZDRjbkNkOE9EeW9BbU8ySFdSMVl0am95QXZIQ1IvTlg0WHhp?=
 =?utf-8?B?OHFnaWE5OUZBQWlpMFBCaDJCdkdZTDc4YXlxRkRIaDIycWFiaHRjN1RRYlhU?=
 =?utf-8?B?MzFiOEVXaUNCYXI4UnBsVU5jVmkwNlUvL0Y0UmVQWFE1OVJyNTA0cG9qejBO?=
 =?utf-8?B?UWhkaXQ1RUhEanhuZkt1UjErMDRFYkZBaXVJL0xPQWgwZmc0L096MlJJZTJM?=
 =?utf-8?B?a1VXOHhPdzJoeHU3MVo5S0FVUDF3PT0=?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 012278b6-3da7-415f-d739-08dd895c6578
X-MS-Exchange-CrossTenant-AuthSource: DM5PR02MB3356.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2025 09:33:29.0845 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mp26goK7rZUiOO0pUNKDW8GN/HdUtEQ+hq4qcXYijZeImPHYIyTEbRstFlgduWVj/j/nUW1z6t9Hlk7Z7JTyhbYOrT7PAWWVUpio1cH84iQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR02MB9939
X-Proofpoint-GUID: uU7EFLv3SFRcYOE5sk1ArkTB-CNXCLzD
X-Proofpoint-ORIG-GUID: uU7EFLv3SFRcYOE5sk1ArkTB-CNXCLzD
X-Authority-Analysis: v=2.4 cv=RcyQC0tv c=1 sm=1 tr=0 ts=6814916b cx=c_pps
 a=+bMTgItWFAhHnRFiF+AwZg==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=dt9VzEwgFbYA:10 a=0kUYKlekyDsA:10 a=KKAkSRfTAAAA:8 a=64Cc0HZtAAAA:8
 a=wC6RDQ3ZBgF3A3Nc3-sA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTAyMDA3NCBTYWx0ZWRfX6CsAab0IU9O4
 IQjmUCXIh9wCcSWWbiqTkZOKFpEzFmqhXEInHjqsBJIfGJND9Kpi4BwbvVLvrEJB0Hh18+uW53a
 w9N5pWaKCI/X7Lue9fsnF6blvQ8STwMm3qVCFkiHtPxBeeEXt+OVRAyaARgJaZHWbJQnWSWIghE
 DYBwQ+2g0TLixz4NH0Q0A0t2IscNmsqVs8PlIV0RD0BCdZkIHcPGOI/X/vMDZqo6vO5y7ARVVC5
 7iPTL+Nfmu/hD3uS6l02Qsa4cTV/5prsNZwP3X7AE75wJ/3DSMpzCpV0Nll1kfWKNN6BH69OM1E
 jV9IJF9xXmD2YxuaQklb2g27r7kXonhdRXDcajbM7qIBrhip9ZMvPVGeY/rYhj02e8vSZnvCTEv
 yCAkDHZET6BnvLvyC0IdXnTUPN8/onOZ6l5sbZOG3FvgTiFJH2QwqVkVghwpKkFEtXT2WAyY
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

> The VirtIOPCIProxy::ignore_backend_features boolean was only set
> in the hw_compat_2_7[] array, via the 'x-ignore-backend-features=on'
> property. We removed all machines using that array, lets remove
> that property, simplify by only using the default version.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/hw/virtio/virtio-pci.h | 1 -
>   hw/virtio/virtio-pci.c         | 5 +----
>   2 files changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/include/hw/virtio/virtio-pci.h b/include/hw/virtio/virtio-pci.h
> index f962c9116c1..9838e8650a6 100644
> --- a/include/hw/virtio/virtio-pci.h
> +++ b/include/hw/virtio/virtio-pci.h
> @@ -149,7 +149,6 @@ struct VirtIOPCIProxy {
>       int config_cap;
>       uint32_t flags;
>       bool disable_modern;
> -    bool ignore_backend_features;
>       OnOffAuto disable_legacy;
>       /* Transitional device id */
>       uint16_t trans_devid;
> diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> index 8d68e56641a..7c965771907 100644
> --- a/hw/virtio/virtio-pci.c
> +++ b/hw/virtio/virtio-pci.c
> @@ -1965,8 +1965,7 @@ static void virtio_pci_device_plugged(DeviceState *d, Error **errp)
>        * Virtio capabilities present without
>        * VIRTIO_F_VERSION_1 confuses guests
>        */
> -    if (!proxy->ignore_backend_features &&
> -            !virtio_has_feature(vdev->host_features, VIRTIO_F_VERSION_1)) {
> +    if (!virtio_has_feature(vdev->host_features, VIRTIO_F_VERSION_1)) {
>           virtio_pci_disable_modern(proxy);
>   
>           if (!legacy) {
> @@ -2351,8 +2350,6 @@ static const Property virtio_pci_properties[] = {
>                       VIRTIO_PCI_FLAG_MODERN_PIO_NOTIFY_BIT, false),
>       DEFINE_PROP_BIT("page-per-vq", VirtIOPCIProxy, flags,
>                       VIRTIO_PCI_FLAG_PAGE_PER_VQ_BIT, false),
> -    DEFINE_PROP_BOOL("x-ignore-backend-features", VirtIOPCIProxy,
> -                     ignore_backend_features, false),
>       DEFINE_PROP_BIT("ats", VirtIOPCIProxy, flags,
>                       VIRTIO_PCI_FLAG_ATS_BIT, false),
>       DEFINE_PROP_BIT("x-ats-page-aligned", VirtIOPCIProxy, flags,

Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>


ATB,

Mark.


