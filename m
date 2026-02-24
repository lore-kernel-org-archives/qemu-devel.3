Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CF9DE9B25B
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 12:23:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vurRK-0002nw-FI; Tue, 24 Feb 2026 07:22:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vurRE-0002nJ-6J
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 07:22:53 -0500
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vurRB-0008WE-KY
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 07:22:51 -0500
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61O70A5f1447183; Tue, 24 Feb 2026 04:22:44 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=sc6fvtX/urSu3l4nA+qfYjPecciSSvqq4PhnLEtxP
 a8=; b=caIWfIvoOQnPNHwaDNFBppbScSJYtopFoDRZJ/DzaxDgupbXpYe0fNSOW
 9+8DehVWG5M+4EZKcxoMmGZpYPEJE6HX5ZnY4V2ouRd5VMB3PHRCfk8Ahi8JgoP1
 CMB3oVMYOT1yHrSXPxttd40Ia/Yoy0Btjohe9KqtBaXpKAV9hSH9W87QgU1ra8pf
 JwbtuMeOkNKjoOO5i2/77tZxkbQd1RWUL97FYOYV0AYkl+F0LSJuKLecX9XJqbDA
 GmHAq+qsgwcyiVY7M6JtqTghH1p8lL3Qa7eMlFlAzIhyS4prhcPi+VqKltvl2nnw
 7tEOdySOXZg5v7ru6e9qFKmvrabkg==
Received: from sa9pr02cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11023103.outbound.protection.outlook.com
 [40.93.196.103])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4cfbpjpw5f-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 24 Feb 2026 04:22:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qj/axl8bIZxdg0501gUsN+XqZeJhKlsmLtnpBXVF7HDQ1etmMS5+hqvFQOTZ4xTA0OI1WdLAMgg6uBJw1vbDrDyy03q59gixj7ejzTOn8+59yVYpAV5nG/a9W/eJTHakbctJMc+WHw87JHLguobXRtK0AuOrggdl8E8DUMRNCJbEuRC0FsaP2RuXz5XBwwvAx1qQmXofNfbh/u0s15KyuEVIeNAHY1g47COzd3PXhCqHNPHXnlZe8ja/mBS5cRMZgJJG+FJwaS08HX4RaBLflcv+fASzfH579J91gcKuxGZ7QLc8qOO7xhQXqA9oS+7WVDSGMc0ziO8/GsbU6W1Hdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sc6fvtX/urSu3l4nA+qfYjPecciSSvqq4PhnLEtxPa8=;
 b=abeHP/qoEUalgH1oyHAjKC2IymcfKjsFVyQIrbHomQyh0cMrhMoEKn0pf0YwgvIz74gn2tf4VDdq7dppiDNiouqcbm19nrJdHbN6p8qszFPVZBMonJjIZNd6bCv/yjVye1ONJ3cKAE8waPt9KLMOqJ46JOu/ncq9zdRFRCBAe3ptBYJ4vdGVgabGPNoXWw2Yqhmgs3jGMkFw4SFV4/QpDmu19J9sHnxVENngx/G9vON9stVL2y5P9VN374eL+0TPUfmaKPJEqu/AgnIgLP58ILR/jMgwHb11DEnRPhMXKA2MYQBCm3io9YdcbnGKK4BR6NO12JkKX9caS8jGAXj7AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sc6fvtX/urSu3l4nA+qfYjPecciSSvqq4PhnLEtxPa8=;
 b=V/XgIEOMRXoNNM/T5kL7P4BLCO0KArVx3XGg/VP3uTW41F6hnfoxd+7xe+svmNiwtwEWrEbeRE0GUe3tRBcNu8KJZjD8pfXT3S32Tn4RVEin/HIJHTv6DD0fsoxJGg92IeHqzyojN32EpIH/efO32njn2th+F3g5uIgYTHRxd18XZA6Sqrng9UBZOGYsGN05/fqwy+OpQdl2dPFzTYnWoQ/Vsa9hmlJyBJVL0pFer3uyFcZuudtt1nWNgF/a0MLVuCraa2xwgzniVVFnvLyUnWKYW+Z6jhuau+XqUnLX2SUczcb84iiNnowkbqiE04hOH1x4RViM91phVudVXdswDQ==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by MWHPR02MB10427.namprd02.prod.outlook.com (2603:10b6:303:284::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.19; Tue, 24 Feb
 2026 12:22:42 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%4]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 12:22:42 +0000
Message-ID: <ef1aeb7f-d79c-446f-be58-28245b84ccfa@nutanix.com>
Date: Tue, 24 Feb 2026 12:22:38 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] hw/core: Avoid attaching qdevs to /machine/unattached
 if they have a bus
To: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
References: <20260217164049.543975-1-thuth@redhat.com>
 <874ind5da6.fsf@pond.sub.org> <aZ1zsoyKcD1ChK--@redhat.com>
 <CAFEAcA-30xkboF_mt2HD+9TG+j9W7k2FCuSHGSVk9H=gbXnx2A@mail.gmail.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <CAFEAcA-30xkboF_mt2HD+9TG+j9W7k2FCuSHGSVk9H=gbXnx2A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH3P221CA0007.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:1e7::9) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|MWHPR02MB10427:EE_
X-MS-Office365-Filtering-Correlation-Id: 9515eb3a-1b96-46b6-eead-08de739f6887
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YmU0dHhXR2t1aHQ0TkZ6aHNwam9Fb1l3aUdDVlNhUkZ6d3JEemsvSE1BRXFQ?=
 =?utf-8?B?N3p6YUJSM0Y0L0pFQTVKWlVWQWR5d01ZRVR1REhGL1hTaU1Hak96QkVKTXNP?=
 =?utf-8?B?TXFLS3ZreGI1VVdPRkRVTnNtRGFnTFhLb2VVU2JWT29yakRSeG1uVXhEZzNR?=
 =?utf-8?B?cUZMUy9peUl6S0VJMlloNWVpbXg4c0JIZUxXVFd3UnVpK2JqS3VHVmU5RER6?=
 =?utf-8?B?SktrV04rOHdQOU9lcTJITEVZdnVsZS9HbWxMbXBuVFprc0Zzb2RKM2VWbWUy?=
 =?utf-8?B?TERhclJydmJnNmtPRndoUUVJT2JwZHRzcjJtbEJWd0YxbE9TLzMwb2N1c3h4?=
 =?utf-8?B?SCswL08zTU5jOE45RzZ2SGwxTTZING83U2FHZndzaE9vdWZmaHJaazNEQ3FY?=
 =?utf-8?B?RlNIaTZkQ0hSZHhEanFrVW00TzFaV1hnb3VkQVZNOGZDQkxkOEpjTmJiMlk1?=
 =?utf-8?B?ZUVlQnowa25sOUFzOXhvYlFBWW45K0N5UkZBUm5jSEFCVFZobCtrNHNHc2ND?=
 =?utf-8?B?K05IMFdiOVpQeHoxZlByY3J4UER6UDBEcVZRa2VGNkR6RHdqZXVRUjZJSHlI?=
 =?utf-8?B?c0NCazl3dFJYUWVLeWM0cmt0Q0Nla0hLNE9wYjlValJFeEVRc0ZybVFnczRl?=
 =?utf-8?B?OU1MQXJMdmlOMER3ay8rT0E2eEl2Q3AvRkpzemJOUW9KNTQzLy96M0NzUmRD?=
 =?utf-8?B?aE9xREd1Q1UyS3ViN3c3Y2lVZnpWS1dmclgweFd0aThHclU3VkFzMGhxSVZu?=
 =?utf-8?B?RUFYMGd6K3lkSW9xcjh1NktXQjIrdlNvWWxBLzkzSU9GTktVOHY0d1o0UGhC?=
 =?utf-8?B?b1N4UklyclRTcy84bHhpRksyblB4TW5uYTJLZDhSZFg5VlhVOWZFb1ZDWUNY?=
 =?utf-8?B?RmZBSUpCdy81VDJYQnN2UFZhZ3VOOHhFc21YOTV5NEZ2TStjZlVERUxzMkMw?=
 =?utf-8?B?WENDd3NYajVIZTZWbE5HSmpVbkQrRlp0OGszdW02N0RkRytZNk4reDJ0OHRP?=
 =?utf-8?B?bE0xWGJDa3VtdXUzQXVKenRiY3VQNU5OMTdtKys4VjZKS0x6aE9NTTBub29i?=
 =?utf-8?B?RDBrQytHOEZEWnBOcWFrK0dPWDQzWGlrU1U2TGFTS2xKdlNGWUMycUowc3Ew?=
 =?utf-8?B?SXI0UUVUckJBdHR2L1ZQdDlkNGdsN1lYaXdUMUJ0Y0pZaEZWbS92WmJ4Z1ZU?=
 =?utf-8?B?REFnOERJNkdHL3FpKzVQSG5VZVZLZlRXYmpRTEhJNnMvclgwYXV0S2pISVNa?=
 =?utf-8?B?a0FNR3FZbGRreWdLRGpMOXM4OVhjOVY5QmZ0SkE4L3pTR0FONWk3T0JBc3k1?=
 =?utf-8?B?MzV3V3NkVUMwUUtkNFRxb3lQSUVrOWdkTVEyM3p4K01nelVCbXQ1NktaVHo0?=
 =?utf-8?B?VWNqeXJ0K283a2NiQjBKRWFvZGRpV0dyWnRiNHAraFpZeTlhb0JEWE1ScTE0?=
 =?utf-8?B?REFKMmRHdG5FS0tTN1d2aGZjaS80cWhYNy9sYlVQS2kzNFhEV0RXY3ZjUTU5?=
 =?utf-8?B?VTFHZ2NxT1gzNndaNnNNUXdjSjVaa3J4Qnd2RE5pN2g4Wi9qbnRmRm00WVd0?=
 =?utf-8?B?SGdGVVF4aEZjT1dGdTcwNitSVE8weGpNRGhFZW5WWVZjTDhUVlhSaXkzNnFk?=
 =?utf-8?B?bTluSUtmckhFQ2o5ejkxaG4rUGlxQnpxT2d1TUxlVmRzVmRiK3JhakluSWk1?=
 =?utf-8?B?Q3pzdEE1VUZtTk1lWHJ0cDJSeXVMNWpuM0J2N3JLUElVL0h6VUJHQ1hTNExv?=
 =?utf-8?B?STNoWVpjQUhPMkQ4cmo1ckRFdW5oZmRnNHRKdzBEdFdQeUh3VngyY3BwYUx5?=
 =?utf-8?B?dVZSNldZTjM0YzVsNXVOdGNrWXJaVWVHeEVXQ2dEaWtieWF5NU9VdVBLUDVa?=
 =?utf-8?B?Zk5BQ0JYRVVsSms2NythREhxaTJ0U2RsVFJkVlhUVmtDSmRMQ0RuSFpUQ2tu?=
 =?utf-8?B?dnFPVFJybGxjdDFkZDIzWXNxVEoyaWxKNDllRjQ5YjlPYzhQbENUWHRCWnBh?=
 =?utf-8?B?VzFhMXJ0VWZTajRqblJMVnRoaGs2YS9HWGNLR3dVYzVJZW1pYlJHOUE5MTFV?=
 =?utf-8?B?RmtqT1RWR2YwTzNMNnZ5bTRlZTdjalBjeTYxRDI0ME9RUWI2d0tIVkZnVWdY?=
 =?utf-8?Q?z2MQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eGlNV2UrZ28rUGJJcW1yNEJrbllEWjVMYkVxTFhrbnppRExuMGxUWHBncnVX?=
 =?utf-8?B?MmwyNHpSSmhBZVQrZDl3WVVhY3V6S01lRTlZZmtXK0RwQmx5QVQzWlBrdTBz?=
 =?utf-8?B?N2NRYUxGeFhkSGk1enpYcnBTWkV2OUw4SDd3d1lpenp3OWs3NDlOVzFZTlB6?=
 =?utf-8?B?ak1iWE5zd1lkSVlYMmRxRGVSeWE4T1NKZk1EaWw5WGNBZ0J6NGtpdDdQRWlv?=
 =?utf-8?B?Nk03R2lvRzU0bnJBVnNJalBja1FiOStKYzdiam90S0tUWHJ3WkZ4UExXbjM5?=
 =?utf-8?B?Vk55U2xvS2hDSkhCOU9QekZ4a0JrakprSVp1N29tc0FTSGtTVGt3SVFuLzh1?=
 =?utf-8?B?NnVCcTFFbmZtK0JHWE1DMXlwZHRtU3BZQjg3ZURHRkNadHZVOTVSZVZFVVln?=
 =?utf-8?B?eHQwa3BwVXU0ZzRMVDYxQ2EwRjVaR1N0Q3lBUXBzcFF3TW5KWm8zek1GaFJj?=
 =?utf-8?B?c0ZDcVhrR3lnM2NIY3podHprN1kvWHY1Y2tnQmRnM2xsMDcvZlRUL3Y0SmRI?=
 =?utf-8?B?NmhGSzRnUENOWXVmd0YwaGNTcUczdG9FNlU0LzhLVmNVbUZ4V1VnVkEvZE9r?=
 =?utf-8?B?OGRlR3ZlSjRTVjVITGI1c3JCQ0ROeEZPeUpVMEtFMVYvUWhrOHBuZ2w2M0Vi?=
 =?utf-8?B?bmoxMEwvcjl6aDZLYkN6NW5Ld21lT25zOWxrcEllaXhGeXVSK1prM3dTYkUv?=
 =?utf-8?B?WnZQYUJ0MzdRUkw0WkcvNkZLNzk0TUlRRmpGSHJDYm9PeDNEamxwbWdQemhW?=
 =?utf-8?B?WEZFS3ZrRktOakFuQmdmankvWjhVTjlKOUE5VUZUTmlWY2x0N056eC9pSlhp?=
 =?utf-8?B?citKN1E5L1JRVGxYOTVwcG52WWVwNnpHQTBOYk8yOWFnWmhTaWo5VTl1VmFP?=
 =?utf-8?B?N3Y0dGZpbm5CdktvcjBFSEplZUpWam9QeGo2RE4vNHZ4SVRTaWtYVGxzRGRh?=
 =?utf-8?B?ZTBVVGFBVGgxQUJWUFdYbEtKQUQya2hFOXRCcnB3ZHAwMUVOVnhvTG5wVmZW?=
 =?utf-8?B?RFVZY2xkSHVGeDduRDBvVHEyTzdCNDZHb2ZlWG4rSlg4N2t2Wmlic2dsVHBq?=
 =?utf-8?B?SzNuWk5jdENSN1VMa3BpSFZua0ZXeUk3cUVOSFI2NHBUUWk0NDNQTmd6Tzlw?=
 =?utf-8?B?STJLZXozczluK1NEUkVCcE1mRVNIZDFKTmxoMnpwb3lHalpyeTZMaDhMbTdu?=
 =?utf-8?B?Nm96Y2s5eUtrNlExOVhQd0ZHcHBYTmowWm9aTmFmYzFPMnhzb0M2RlVWQVJI?=
 =?utf-8?B?UThqcHZWZXBzdVMwb2V1akd6Uk11bE01NW1UTkNpODR3M0xSY2ZJN1FYajFT?=
 =?utf-8?B?K0pXaUNwWW9WdlltZUg3WnNFVjZRb3oxaFMyUHYzc1dzTm1CMDllbGNIcnQ4?=
 =?utf-8?B?aXgwL1I4eDBrL3RwSFpQZ1RDRm0veGlXZHJSYjFKQUtuUDBJNWtTQ2lxVjBy?=
 =?utf-8?B?dXA3S2pNcGtYNXFrU2REWDMrVTdtRjRZOVhQbmpiMEpZTWhMKzBodmQzaTNO?=
 =?utf-8?B?bXpqUEhiTEhRMzIzajVxdXFSaUpON0pCaTVGa3M2dWdqRUFwZ1IvWFYwTnlZ?=
 =?utf-8?B?VGViTmQ4VE5aNVQxRzkvdytLUnBBY0pxN3RaL0RUV0FZamNOMnZpNnYzc1JS?=
 =?utf-8?B?SE5Xci9YdUVoZDE2S2haMUhZQWNSVGRPSENVZXVTVWRXaEx1OXFwMDRHTCtM?=
 =?utf-8?B?UDNhMlY2NU0rMmFCeEdOdG5hWE9LK3h2bVdPZE9LR1hVQytscEF5eUJDVDI1?=
 =?utf-8?B?SUF3SEw1Z1V2aW1oQXJ2Wm5XV3ZNaThQUFhjblFZK3dqTFZKUFFGU0V2U29O?=
 =?utf-8?B?bWVHL2gwLzJrMnFWcmVNZUdBcnMyWVJucXd4aXdjRE1vb3BCV3hnUkl2ZDBJ?=
 =?utf-8?B?RnlUVlRraW9yN2hpdTBYL1BvTWQ1eXE4MzYyeGsyancvNGk5eHkwWUxtbTI1?=
 =?utf-8?B?Q3hkUEJsbmRaNDFzYTBnTjNNNStmb0NFWTVmRGJ0YUhUeXBCTjVmdHlncWpC?=
 =?utf-8?B?VTJvdk05bDdaODVHVStmekV1VktBd1ZJN2dZRlZxU0pHTUo0SGtvWVV4M0Qx?=
 =?utf-8?B?YWtSUFdXQUk4TmVQQmgvWWtkOGlwQjRtTU9aaUxISFVzZWQzNFdwL2xHaER1?=
 =?utf-8?B?aXVNRVp4SWZ6OWRoY3g5UXJmR3ZMbFBsb2k0dndZZ3hWVjh4M3owb1F3bW1Y?=
 =?utf-8?B?YW5XYU4zdHp2QXErNWNtVjJnU0swSCtJRzBWR3NDY0YzOTgxZDVOWGFFcjIw?=
 =?utf-8?B?d3lZVGh5aUxvOHJJaGl3R2U1VXorY2lTQW9pditaOTQzMWFvSGRmTWl2ZUs1?=
 =?utf-8?B?TVpDRmpERGJNMTIydkd3eVdxNE95bGZ3SlRhRlB2Q0kvM1ZEU3FHNVYzYlBs?=
 =?utf-8?Q?4+dP3zxOplVP6npk=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9515eb3a-1b96-46b6-eead-08de739f6887
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 12:22:42.5351 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gRiupFgFqLsTWUiLLF23mq45bAV1PPGPJaPpI2KRfNY8hJZA678ZIs27PfqSsP4CiaK2BzNPDwTtbLdhylB/j4lVAGZgucRuORHaEWRMYDQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB10427
X-Proofpoint-GUID: OzQKH49_Avm-fC3qc0itgIZfCLzasP85
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI0MDEwMCBTYWx0ZWRfX2ftktpTRAf0h
 Me6r8d790USNGuDn54bOWhU/zF/lLEdESPIkCkGF7bZ+Ea0U5qJfPeQ5/N6F/IA7MW66oCaBjQ1
 WwVNT597IpgAoVgyuDPGB6LPiUzK14G3QZszGIgRGuo6nbjRDOj6V1wxBbYAzahmSsi3Ey5o7cl
 38JW44/DALW6mY500AkbyK6dligGJcVEnN1FlDzPTLvZyjeuQNwBxoAY3Mhd3RcaveYSsM5Z/tu
 IEega3zi1EoFAUI9AHbvwzsCvWePw9NCkahvWDLDhmKxL/kbYzhrnVa0tk41O5R6xpifqOeLdZS
 6JloAIEofgKvRcP5+qXtW3nh+lK5NUjUIW3YtHt03QBLpQc+fAXVYkhUFggw81zxUg3iv7oL+YG
 5/yXMNHHC1ZRws7hWxUZobG2jL2Ed3R8tUcBPB1fxmwFpdv8yMs0wJh5v8shzMzCBvaB0BQ5+mq
 EYAc/mHsfQft9DvECdA==
X-Proofpoint-ORIG-GUID: OzQKH49_Avm-fC3qc0itgIZfCLzasP85
X-Authority-Analysis: v=2.4 cv=Jf+xbEKV c=1 sm=1 tr=0 ts=699d9814 cx=c_pps
 a=wzqVpK3G+266qiwA4JElng==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=dEe9Ve2bX-KnNSUMM2s9:22
 a=20KFwNOVAAAA:8 a=MYYa9joFotY-RK2XLuMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-24_01,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.358,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.659, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 24/02/2026 11:10, Peter Maydell wrote:

> On Tue, 24 Feb 2026 at 09:48, Daniel P. Berrangé <berrange@redhat.com> wrote:
>> IMHO, it is slightly more subtle - people believe they are already
>> adding children.
>>
>> Consider this code.
>>
>>      port92 = isa_create_simple(isa_bus, TYPE_PORT92);
>>
>> my reading of that is that I'm creating a "port92" device that is a
>> child of "isa_bus". Why would I need to tell QEMU that it is a child
>> for a second time ?
>>
>> If I trace calls through isa_create_simple I get to a call to:
>>
>>     qdev_realize_and_unref(dev, parent, errp);
>>
>> and once I again I'm left wondering why I would need to tell
>> QEMU 'dev' is a child of 'parent' a second time.
>>
>> Of course I know the answer. We need to give a name for the
>> child and it isn't trivial to "do the right thing" to invent
>> an automatic name.
>>
>> Still, overall I'm inclined to largely blame our API designs for
>> not guiding people into doing the right thing.
>>
>>
>> Picking another random unattached set of objects "smbus-eeprom"
>> I again find they've being created with qdev_realize_and_unref.
>>
>> Pick another unattached device 'i8259_init_chip', and again
>> we end up calling into qdev_realize_and_unref()
>>
>>
>> It feels like qdev_realize_and_unref() is a common point of
>> blame in unattached devices. IMHO it ought to be taking a
>> "const char *name" parameter.
> 
> I think that is because this is the function that is used
> in older code that predates the "everything should be in
> the QOM tree" model. Newer code doesn't use it, I think;
> and it's not surprising that old pre-QOM code doesn't do
> anything to put objects into the QOM tree.
> 
> The two patterns are:
> 
>   dev = qdev_new(...);
>   ...
>   qdev_realize_and_unref(dev, bus, errp);
> 
> and
> 
>   object_initialize_child(...);
>   ...
>   qdev_realize(dev, bus, errp);
> 
> This also is somewhat tangled up with the question of whether you want:
> 
>   * call a function which allocates memory and initializes it
>     with an object of this type
>   * I have the memory here, init the object in-place
> 
> If we could come to a definite conclusion on what we want then
> we would probably be in a better position to try to enforce it.

Exactly this! I think what tends to happen is that we get stuck in 
situations where someone suggests an improvement, but then we get hung 
up trying to work out the corner-cases where it doesn't work and then 
things don't progress.

The approach I believe we need to take is to work out what we want the 
API and QOM tree to look like first, and then work backwards from there.

I tend to be in agreement with Akihiko's argument that we want to 
deprecate in-place initialisation with object_initialize_child() and 
simply use refcounting everywhere because then we don't hit any lifcycle 
issues if something retains a reference to the internal object (memory 
regions!).

The questions I think we need to answer as a starting point:

   1. Which API shall we converge on: qdev or QOM? Can we come up with a
      code sample(s) showing what we want object/device initialisation to
      look lie? Longer term can we unify the QOM and qdev trees?

   2. Should we convert to use external object allocation with
      refcounting?

   3. How do we handle memory regions? With Akihiko's recent refcount
      fixes then Zoltan's memory region changes could work: I don't agree
      with the motivation of simplifying devices as I think it's i)
      subjective and ii) harder to debug if we lose the pointer to the
      memory region, but I can see how it fixes the RCU-thread doing an
      unref after the owner device has already been destroyed issue.

As several people have already pointed out in this thread, we do have a 
poor track record of API conversions but the introduction of memory 
regions shows how this can be done successfully.

Given that we already have multiple ways of doing the same thing, I tend 
to lean against not introducing yet-another-API unless we can come up 
with a long-term strategy for its use. In particular this causes 
problems in review where e.g. one reviewer may want to use QOM to setup 
a device whilst another may want to use qdev which is confusing for 
everyone, including the code submitter.

If we can at least get an answer to 1) then I'd be willing to have a go 
at writing some kind of specification document and put it out for 
feedback...


ATB,

Mark.


