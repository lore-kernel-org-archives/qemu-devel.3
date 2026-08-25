Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81138C61DB9
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 13:46:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyrRd-0003ia-Ku; Tue, 25 Aug 2026 09:44:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wyrRT-0003fm-M7; Tue, 25 Aug 2026 09:43:55 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wyrRQ-0002TV-KS; Tue, 25 Aug 2026 09:43:54 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67PB0pUc1670641; Tue, 25 Aug 2026 06:43:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=5xoKW7T12/Fp/9X2y1Ap3k2YCEArNQ8+b6TRJQ/Xy
 uU=; b=ruOWsxHeQhBQ3i8c75+JtWQSOr3UXCAPs8a3X1q73e1k325yC8TNtv86Y
 IaIZ4/2/B3AJD+Ck91OcHZbXaRyrxLI7CoxhDLf6xPqDhYZ91cxUGKCxEJq8HpMU
 IhyAL8Q1HdlxBUNEIpYijtTwJ1Jlae5NyuzbO/QF+pD6CLGAe46lxB6jF6G+AJHl
 fxNekz8+xj/J4VSeEN13IWF8rVHYh6HH9WZLTIzf5xIdAL7kRKi+mdGD+5yUQiQw
 4dyy+1+TzHBbp3POgwsKqIUEbQBof153hkX+p2LMKFYFi12XDL/8eizfy6nwa5sq
 TpwNvYffmWyxKYEmBvI0G9IAYpCLA==
Received: from sn4pr2101cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11022143.outbound.protection.outlook.com
 [40.93.195.143])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4g8sya2fw2-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 25 Aug 2026 06:43:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q5PWZIQrmBqa6JgAGTtnQkzQsn4I7RAnWrc+vweLEOiUw10Oaaqp19L8liridod+ZH6vq/ltt+TKYJUv7JeC+ThK/oQtQU5FRPDACUCdUnWMfYDIyWkI0+phvYOiKVN7jBaLtZfzxcGcKO0XB3/v9B3pg8sAbYA39Ke8mpSMi9e6W5hSZELSN1JUdeydcaxX81TrU9qbj6flArORbfA/BSwlg3zBrvbCPvUw4cSzEx+/9qJ/YflFzT1qKyLjHTsfpDL3KMsmWSPGcG/E+xx4tkOhdoCllLDtaF7xnhSD1j7V5mpmsJw67mOhOkBo4SJS85sPmQcqyUxhPpTB41DfRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5xoKW7T12/Fp/9X2y1Ap3k2YCEArNQ8+b6TRJQ/XyuU=;
 b=eDOAAieQ4xu6i/mog/XvxAFU3FsfdAWiPmr6sN8OCTOhWRdBAFyIDc6NSLj0FHCtIjeK8HB1jy0GsBC39coZo5kskiTX71XzcIVBeFIFZQvMSOiN5bwUFfj4larLVor5yDS215aER4WLLUDWMSQbrq9LNG3wXg0DRZ/ZWLXFYjVp7aMJBxP+TZWHD3EKX+WvF6M6hSe3BZBtvJp3Njj/FMB+3PkGVxUFjTcEynx2PAsFJXy5wxkBUQhLksHmRkWC25sO+T/ff7nHzhzjurbI7CT6XFBsDSOtPI6LggChIuiMIBbxoNHAZ8Lffvif5DymvaMDPtY9PmjAW9of8hLIdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5xoKW7T12/Fp/9X2y1Ap3k2YCEArNQ8+b6TRJQ/XyuU=;
 b=wCqGwgYgqBlNco2zXu0nSKYQ9r58YOTZGxMZ5nhTbGqr0CJTiea9jWqJQ9MdyQIws62qkr+5uLpNIbHVsdS0YeJwHZdh5CqF19NJW60lspR5yZAKT3fOj/EPBuP6oSqZiM8fc++s1uh09wwfCmrGZIoaBRf/PaC7cVvV6PYAHEgwws3n6YhojdxjNFC2xQk05FNl6h5PJa2piXXedVgEjIj+8Qp+51XYnedDYCTLWgBJYOLOg7ZmE+iyAiFVpkGM04KHwuxfOy8R6cqDbJ3KzioOJeHE9IXAS0JGhwBPnb3Oexf58Gh25KYfLzXia412Yt1hkdv73mtgUqoP5GPRSg==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by CO6PR02MB7681.namprd02.prod.outlook.com (2603:10b6:303:a4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.7; Tue, 25 Aug
 2026 13:43:37 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0360.005; Tue, 25 Aug 2026
 13:43:37 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com, philmd@mailo.com,
 aurelien@aurel32.net, peter.maydell@linaro.org,
 richard.henderson@linaro.org, berrange@redhat.com,
 marcandre.lureau@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org
Subject: [PATCH v5 05/16] qom/object.c: add
 object_class_property_add_uint64_ptr()
Date: Tue, 25 Aug 2026 14:41:26 +0100
Message-ID: <20260825134320.1039012-6-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260825134320.1039012-1-mark.caveayland@nutanix.com>
References: <20260825134320.1039012-1-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0065.namprd11.prod.outlook.com
 (2603:10b6:806:d2::10) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|CO6PR02MB7681:EE_
X-MS-Office365-Filtering-Correlation-Id: 76b084e6-7ddb-4046-2967-08df02aeddb0
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|23010399003|921020|18002099003|22082099003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: /imXfbuzU7+D5Ob0mSyNDJA7reH6q8CQb1uOUHKh5RitXZ2HkeMSdkf51G8lJnXcDuz19QkvXAJe9ul/jDnh08MO7FiiNMmjsIj5fLcpjYpOwHpSljC2w9iYQKLy131E7zEm1D+H62yhSSNYgtIxvq3YLnhNH7HgwSGFNH5DLWySEd4PD4JuOSq3KX7Y+43PF1Eaf2YiEmNnBtkn5CveVJFz31U66uY309IUsTlZikz63BMzb1p0CDH5x1D4EEU18m8XA+oB3x6GkijU+BkthmNc51ed/AZA23K+dlKIubaAUPkWbOKaoJtxMKVRY7Y1NZiMu8PNha+Ug2IgI1sw6kDbrub0dnHuCOlT+nUVRZC3SMaxjFdPqPylqGRoAHTOPyH1vPEb15k6jiL/lt5MP0n0d+Xwpk5eEq2lPWgtP4QhpvnEMzIao+ZnOXT20qRISLrGW6hm6rxoDNzDf3Q+69fbPa4yt6vNsGCxOjo66de9GZB9+TIFy6K9PDRozSnaD6ssufA49NHzTbfSSiyXwNmxTRYuxOzIVcpyjEOA196UXF8fEh7RWbCeck+uVdcu8VxT1Gsv4qHsx9kjosXcywO2SBRVlL2tEKOomVqHyk9tvY8Ma0PZ/vd76sMGfuD8oQrYH05HJcmiu/JyU2RUFADc2CwlGLcC5UnEi6Fbyjpvc0JA9tI3oKshYXte1FvyP16ZFzQz1xL22S+KQek4VQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(23010399003)(921020)(18002099003)(22082099003)(10067099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RFpYS0g5TzRYUmZxN3lsZkJDRTdNWC94YVJQNythWkxBWURzd05lV3ZuSUln?=
 =?utf-8?B?azRSanIyVDZQQ3AxSGFYOHA4NWlPUmJGaTI1bVFZV0M2emhmVE1XR3JIY1Rl?=
 =?utf-8?B?emhkQXJjRDd6TTFSd2FmUVJaYVFhYlBiT1ErOHZJZzBIc0hrb25tL0FaTStZ?=
 =?utf-8?B?Slk3cjZaUDU1VHFHNnhYV3lieHRtdTRQUTZXSTRRb2sweWRVc0h3WWhaTFFn?=
 =?utf-8?B?RWFiaVR1R1dBcjM5LzZXZU9YZU8wNUp0clhITWxsdHN4czh0eUpOWDJiS0x0?=
 =?utf-8?B?cnVrRVZaanUrRVl0V2ZFaEZZQkZzWUhCem9DZDhsL3Q2QUZNUGkzN2RxNWZ3?=
 =?utf-8?B?UVVHcVI1anZjOEl5MzhsMmJmQ2MvNWNGOGQ3YUg3SENXcWpBMjh6a29sMktG?=
 =?utf-8?B?M0Y0c0FzUEtybC82anBuTjMrZ004SDFpNkxkVVRLS1ltaVlham1GMm1acm1q?=
 =?utf-8?B?aWY2dHR5VVRhaG03YjBVcGoxT0h2VUE2RnJtS2krVGk4UnA0Z2lCZkw3QjRn?=
 =?utf-8?B?UzZ0WHRlOFZKVzF2WUFSNkFIOUJnRDE4b1JVWE5uejJvUWpoblhLWmR6UUsz?=
 =?utf-8?B?T0R2cWxOOGVKeFRpQm5qeThKZzVQUk9DdHlUR3pHR1FEWG4zOEI5VHdpMEtp?=
 =?utf-8?B?NnRCQU1mNm90TEMrcVp5dEpYL2x3Q0YxQkNoNnRaek1EY2s0ME5ocXIrU1pi?=
 =?utf-8?B?MUJRS1VNcERHNytJbjFEbXByNGNJVVVXK3o3eENlZ1FBZTdnNVMvd2RwYW5i?=
 =?utf-8?B?bTVvZm9MbXlSd0JJcXk2Q2wyMSt0MUx6cFdRalAyYjZPZnhCc0dVRXk5L0xH?=
 =?utf-8?B?SkJtRk00OFRuS0h1NUIzVDZOZEd1Y3NlMFZoTythZm9jUitad2p4blZodWdE?=
 =?utf-8?B?OFFtVGM0VUY4TXh4RHhUWWxwVWRTSi9GbXJqYTNpang2TTJTTHRPWkpjTmdT?=
 =?utf-8?B?YTREdGhHcWYxQUJEZ3ZaZTRpai9rMkl3MnZ1dW43TTg5SlBRejk1U2NnN2tm?=
 =?utf-8?B?ZjdWNHQ3NnkvUTVHUC9qNW9oeTR3VDF4UkVqeDRRTWlPNk9wTGlFK2Z1S2tP?=
 =?utf-8?B?VldZMmhvVjgrMldqdHdvTmdobVU5b3FOVDRxemZyUXQ1MklKNEM5NUl2Z0dN?=
 =?utf-8?B?YXBYUWtsMExacFJ5ZVZ3OHNmbE0xUWN6SzlkSkwwZFpNd2kxdUwvY0U3dTJ1?=
 =?utf-8?B?djRqR2JCTFBDMFdBekd5Zmp3QktETTA1R2Q0Nnl4aWxaaDFON3hHVkhldUFp?=
 =?utf-8?B?WHBnSm9EZjlmQ1g2YTg2M2xpRTVvdytiYU9rRjFzVXQ1d2pXcThsMjFVTjEy?=
 =?utf-8?B?RUN6UERZM0xDN25RUTE2TkphKzdsT3o2WDZZTmNGZk84bEpSWGEyaCtITzBX?=
 =?utf-8?B?ZnQ3eExQNWdQdkhWYURXeE9pUVNhL09GNE5aWitZcGx2UkZGVGJ5eitqcCty?=
 =?utf-8?B?Q3Z0Sy8yM20yNHpPNmoraWdtOE9Ha29nZFRVcE41b1N1WTdDRnN3dHlGSEhw?=
 =?utf-8?B?OW1xbE90STYzQVFUWGczTUMrbWdOYmlIZTdhUEtwc1QyeEdYQXBteHgwODhh?=
 =?utf-8?B?TWlhVnE1a1BZeURiWU50SDVhdXlMRkp2SVdLTmJ4QWVzMEttNnFMMnI1TnlR?=
 =?utf-8?B?NkdJMCt0SWgwWUNpZXV0V2ErZ2JiZ3dWY202MjVmMWNvaVNXRFU2ZVZqdWIv?=
 =?utf-8?B?Q0txUkJWVW02TlcrbFFlRHdzUGp2YnRURk9YaE1naWJmZEV6dmYxSmZZT1Zq?=
 =?utf-8?B?V2prYys1MzZtK3F3MXVpU1dHdWlmYTkzZDZrbU8vMW8zdFJsTEpIaTRnQUVa?=
 =?utf-8?B?K2EzQ0Nqeks5ZENZYktjLzdWK2kyRWpubHZGTFhmOHI3c1V2SG8zZjFhRmlQ?=
 =?utf-8?B?WVlaY0JQa01EZkx0a1J3TEZzK3V2UnVNK202OWJkQ21ITVZTMktwUXd3TDdG?=
 =?utf-8?B?Z3pHRy8zL1pQS2M2SmJhc3hDc2Q0SWdWdWxXSHVmZ3ZZUzNvYVNxazVBYXhr?=
 =?utf-8?B?Zm9FZlVnVXcvZis1clJvcFpOcmJVU09nS1NPT0hSbGtJWHBoelk2MTZveG5Y?=
 =?utf-8?B?eC9LdThyK2UwWHZsVHl3UEdKeEFzcDZ1UmFCQnl5UFFvczQzQnRqL3ZCT2Qr?=
 =?utf-8?B?QVBsWnhtRFVuRHZLSXNrZnR3QTV3TlRBTWpPam1TQk16cThSZVgwUHl0aW0r?=
 =?utf-8?B?WXREYlp6K2IrVUd3V2hEQ1ZhSHpKWU5pS0h2YjNpR1ZiMjVkKzRXcUNuOGw5?=
 =?utf-8?B?NXBDWmk5K3hlcFZpMkZBcUgweU1ZZS9odmpQZjNoRkZYVVFVbDUxWVM2eTBq?=
 =?utf-8?B?Z3hYL09VMExRVnZrRCtvendDMENVaEg4UVNEaVhzYzEza2tsM0lWWnh4NmR5?=
 =?utf-8?Q?ckdbCvfX2Rg+LYQY=3D?=
X-Exchange-RoutingPolicyChecked: qkkX8XCgbUXSVyqiuDg7u+yOoeILGqXohfuPaQHPiohBwiGZ/aq/NSootUJRUKGI0HySfdXxMJlpI13X/1wysZ4rmgQPJt0AqFQWHZaJ/GldRVZW+WuuV+bWe/GKXSnHfBAUATIDv4eiZ4QcWsMBzUN95Gj/Qlov+c9DZq0Xj7wLy5dUnqr7xFPPMHBeIQsq5TZMYafFkOMMHLAB8d8vCDEKSUsJuZsfVEiEyvaqHfaGandwn4JF5aRxBNN3OYRcvygHKsdxThaFRhgU5EfeZ6mSJhhB2ylo01EPdPs5L0knduZPNGYpxYbIDh+Xm9f573gdeCTNY+F7VMaa6s1A7Q==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76b084e6-7ddb-4046-2967-08df02aeddb0
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 13:43:37.8366 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k0htBbk9k7+TuotFnIq4gIQXs4ZqPGY8aGtO0e6smi/1GzAujGBOadz5lpJRA/h5d74u05/MpgPPN8GDnHEJtPttRzWpK+l6eapobWEpv3g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR02MB7681
X-Proofpoint-ORIG-GUID: 6W_I0KJhvA-NmnZR1Bz7ZiKpMYtvrBTV
X-Proofpoint-GUID: 6W_I0KJhvA-NmnZR1Bz7ZiKpMYtvrBTV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI1MDExNiBTYWx0ZWRfX/uPxlGcaMEbs
 RyeUz0lsWmur2nDIaJLutWSzQE/BmrF3Bf/P/2k34LzNkunoWJjUXXtan7sfTgDnXwLGsFJtLeY
 vRQuwLaik9c6AyJeAj6AZXV6qJYk3iZdeQka6aB74fX5GsZrCcxLOWsv75Wiv/oIL/dDqRO6TiA
 Kdl3H5bVGOm/8EznkA+LKZiMC+lgZA0o6lagJyFZtPjhSHBONiZSnJy4Ks4k3nxmGUOAQv++Fzr
 MF3ngugWADrs200GyiWdHf7DVxHXAlbg1r1czImOGEQOVKHTZLu3Yw/xHthfl8YGAutMu5PJRbI
 AeSRAKvAX9Juk9yPOi4rhlNXXK5u3TOrcHtSJHdPzaLapkgVaJAHVmyQGIDtj5P/Fl31W4iyTHp
 y6uNDBHfe22AfQS7RwnCOIU+1YeAEyCmKisAq5/0tmX4fPNsYQHiUZm2gYs+KGKereaBhvVI6BN
 WjexbF6e0GqMocGc9pQ==
X-Authority-Analysis: v=2.4 cv=YOqvDxGx c=1 sm=1 tr=0 ts=6a8d9c0b cx=c_pps
 a=ZgU9I8B0O1PKiENeC86Haw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=y4UcunY2MAxhM4LwGdWI:22
 a=64Cc0HZtAAAA:8 a=20KFwNOVAAAA:8 a=4QfE8SPBBHYfMhEiUa4A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI1MDExNiBTYWx0ZWRfX4EDxhOBst5xh
 UmG92K/YKEWD5ZsFS75LEF2VuJ9hnCLq+lFgqWPfx12iynzUxK/DViFdsc3mNuCL8MgokqNgO2F
 JDfPGu+lGG/1CmVNNI7kVZ+/0Th+S/I=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-25_03,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

This adds a class property that references a uint8_t within the object instance
and is intended to be a replacement for object_property_add_uint64_ptr().

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 include/qom/object.h | 18 ++++++++++++++++++
 qom/object.c         | 21 +++++++++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/include/qom/object.h b/include/qom/object.h
index eba675d218..67ccd2b08f 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -2168,6 +2168,24 @@ ObjectProperty *object_property_add_uint64_ptr(Object *obj, const char *name,
                                     const uint64_t *v,
                                     ObjectPropertyFlags flags);
 
+/**
+ * object_class_property_add_uint64_ptr:
+ * @klass: the object class to add a property to
+ * @name: the name of the property
+ * @offset: the offset from the object instance where the uint64 value is
+ *   stored
+ * @flags: bitwise-or'd ObjectPropertyFlags
+ *
+ * Add an integer property in memory.  This function will add a
+ * property of type 'uint64'.
+ *
+ * Returns: The newly added property on success, or %NULL on failure.
+ */
+ObjectProperty *object_class_property_add_uint64_ptr(ObjectClass *klass,
+                                         const char *name,
+                                         ptrdiff_t offset,
+                                         ObjectPropertyFlags flags);
+
 /**
  * object_class_static_property_add_uint64_ptr:
  * @klass: the object class to add a static property to
diff --git a/qom/object.c b/qom/object.c
index a480fdd400..271c2916b7 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -2742,6 +2742,7 @@ static void *object_class_prop_ptr(Object *obj, ptrdiff_t offset)
     OBJECT_CLASS_PROPERTY_SCALAR_SETTER(type)
 
 DEFINE_OBJECT_CLASS_PROPERTY_SCALAR_METHODS(uint8)
+DEFINE_OBJECT_CLASS_PROPERTY_SCALAR_METHODS(uint64)
 
 #undef OBJECT_CLASS_PROPERTY_SCALAR_GETTER
 #undef OBJECT_CLASS_PROPERTY_SCALAR_SETTER
@@ -2911,6 +2912,26 @@ object_property_add_uint64_ptr(Object *obj, const char *name,
                                getter, setter, NULL, (void *)v);
 }
 
+ObjectProperty *
+object_class_property_add_uint64_ptr(ObjectClass *klass, const char *name,
+                                     ptrdiff_t offset,
+                                     ObjectPropertyFlags flags)
+{
+    ObjectPropertyAccessor *getter = NULL;
+    ObjectPropertyAccessor *setter = NULL;
+
+    if ((flags & OBJ_PROP_FLAG_READ) == OBJ_PROP_FLAG_READ) {
+        getter = property_class_get_uint64_ptr;
+    }
+
+    if ((flags & OBJ_PROP_FLAG_WRITE) == OBJ_PROP_FLAG_WRITE) {
+        setter = property_class_set_uint64_ptr;
+    }
+
+    return object_class_property_add(klass, name, "uint64",
+                                     getter, setter, NULL, (void *)offset);
+}
+
 ObjectProperty *
 object_class_static_property_add_uint64_ptr(ObjectClass *klass,
                                             const char *name,
-- 
2.43.0


