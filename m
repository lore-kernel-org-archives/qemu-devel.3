Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DB26E7717F
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 23:55:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLt1H-0003zQ-2T; Thu, 12 Dec 2024 18:54:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1tLt1F-0003ye-2S; Thu, 12 Dec 2024 18:54:57 -0500
Received: from mail-dm6nam10on2061e.outbound.protection.outlook.com
 ([2a01:111:f403:2413::61e]
 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1tLt1D-0005PM-31; Thu, 12 Dec 2024 18:54:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yuX8MsS+L5qUS4FrhBXJQP7YLqVcpRKT9Nc9XJRu/XMaa0KbLBv4grgs/qQUSw+oCsFYyGjLXuhKTreEcx1oq8Mu+IrpEC+3OqTc+BtruKCwl4yQ/ULR9X95RYUQzl5BK9SFxst+t0tgDsH71m8Zq/uHOujwOLyN/NQPZ8qqbbtz/YJzWzTFwkdXGJnGmuzN1NMSlhp0rGsBfJnBOMWU0LHS95WiOvnyVzZvLeb0XEihNzWN9tYND6iXFT/DKlgPmqvNPow1SHQe1nqpVyYaU4nQaEygR2kQwDjgpPbWE2d0qDkCAao2v75kYav4ZJfxxZEYF3C2BeZ0Vn73FcfFNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ffPVugoxrRaPzo7oV2er53hwQeEkgge9a74vAcrvuP4=;
 b=YX5Q2Im+KhqV7p1wmogfa+GG1srQBQHi5gT9S//Ke9P/UhDdvb9H8kifrz4eplHXmm42MPKrsvcrYwGAT3eJ7ef6yNecxwjqLEk2Paxox0qtx+b0aS2v2kRWNDZnOS1fA5eQ2BJZmr/9L2braTw6UhBQOsFoDo+pEOKl49BWp0Qx/ClSsJvxCz49EDqJf6y2GMR8ojCApCFwxBwdQRc/pM67UxsCUOSNbtt2NWrbraDGo2zMKkEToAXrWTPYvA1WDKq11bGN4u9wpI1SVXHPZ0wzjK6sC1hLXNZFF4SS3iOR2lSKrIE/drD8EvHe8br7+W7sEeoOMGJUPtf89FpZFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ffPVugoxrRaPzo7oV2er53hwQeEkgge9a74vAcrvuP4=;
 b=FQq5nGt65SaE/x+OKaELSZNI0LlLAgjk9J5Xq76FVA3QwfPYaOCmV4xSIckc0EtMztJIoeuL2VnWc0SSU1qZPx7DDsIB8shMVj0VkguKlRJQD9mYIhALTpnkwuXtTa9N/numsbdbFcFcXROJp8z8Wr7oYJSHkKvKJHOgXJa58h5Jgc9PFgWCqHQjfeXGMQkRhRuPSfZOSpJIH/T35OFAZcfrWgdcThVYjp0jYc9THElIks2QVe8QSX2TGO3G+LqRs0r4xO5sHcg1S2aoCgInAAJT+E2etJ+nvJnvbLDmU/Tn6WsqRJBDv0UA6sXnt5IGRUAUfMuRKhPr3N1myNiY3g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB6838.namprd12.prod.outlook.com (2603:10b6:806:266::18)
 by SA1PR12MB6893.namprd12.prod.outlook.com (2603:10b6:806:24c::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Thu, 12 Dec
 2024 23:54:44 +0000
Received: from SN7PR12MB6838.namprd12.prod.outlook.com
 ([fe80::529d:478:bc5d:b400]) by SN7PR12MB6838.namprd12.prod.outlook.com
 ([fe80::529d:478:bc5d:b400%6]) with mapi id 15.20.8251.008; Thu, 12 Dec 2024
 23:54:44 +0000
Message-ID: <1d4cf9bb-ae4b-4c4e-9b33-23c4eda96d92@nvidia.com>
Date: Thu, 12 Dec 2024 15:54:41 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/5] hw/arm/virt: Add support for user-creatable
 nested SMMUv3
From: Nathan Chen <nathanc@nvidia.com>
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, eric.auger@redhat.com,
 peter.maydell@linaro.org, jgg@nvidia.com, ddutile@redhat.com,
 linuxarm@huawei.com, wangzhou1@hisilicon.com, jiangkunkun@huawei.com,
 jonathan.cameron@huawei.com, zhangfei.gao@linaro.org,
 Nicolin Chen <nicolinc@nvidia.com>
References: <20241108125242.60136-1-shameerali.kolothum.thodi@huawei.com>
 <ZzPd1F/UA2MKMbwl@Asurada-Nvidia>
 <2a61079f-a919-43b1-906a-bae8390bf733@nvidia.com>
Content-Language: en-US
In-Reply-To: <2a61079f-a919-43b1-906a-bae8390bf733@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0P220CA0020.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::26) To SN7PR12MB6838.namprd12.prod.outlook.com
 (2603:10b6:806:266::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB6838:EE_|SA1PR12MB6893:EE_
X-MS-Office365-Filtering-Correlation-Id: 19545750-0cba-410c-7ee7-08dd1b085a0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YldvWEtzZW5aTnpvWGZVWnVrWUdjMU1jZ1BtUjRndmQ5aURPVWZFWUhidVJ0?=
 =?utf-8?B?WjIxL2hXU3BINURBMldTVnVKOGFpR1JTdXVobVlrTG13VWFtTHZML090c0c0?=
 =?utf-8?B?OFJ5WXMyeURKbklyOU9DTnpXZU9yb1R3NENxZGQrWVZEcEJXTEZRNTBRV1pO?=
 =?utf-8?B?TEdWd2FIS3NSemZnZjhQNW5hZlhnZnBxNTl1OTRiSEswLzE2ZmNrSXhTWnQv?=
 =?utf-8?B?UExaSkw4OUN0Y0VPazNoVjl6ZnNkTUVMUmxBekJpbnVvc2FlWVRaOUJReVZi?=
 =?utf-8?B?TWpvSERRdXZWNWJXcmtFa3F1endyM0p0QlBDMllNSzVhSHBOVTA4RnU5QkhF?=
 =?utf-8?B?QlBVeFBIUVg2MTRKRVRQc0VJSFRwUi9YcXE4TzBZbzFvZE1GN1pKRE5ycjVw?=
 =?utf-8?B?REVHdzFsb3NxT25jZmFlaXBRNFQ4aS9MeXdRTmVidDJJVWpQeTJ5c0k0OEo1?=
 =?utf-8?B?NlNCc1VtNnpxY2tRemlWang1WVpNZDVvTnN5UjYyL0wrYWhIQkxVcVA4WHVk?=
 =?utf-8?B?NTRoNE4wTXlVZ2FoT2M0WGk2ZnMwY2FBK2Nma21qM29CaFBYcEFab2U2VGNo?=
 =?utf-8?B?blROUGVzS0MvY25MWm5RQUpuMXpiQmV1Z3FtTTBScER2aTNjZjNXeVFwc1Ri?=
 =?utf-8?B?MlRFNWFJazZ6WkhqM2c2Qndqc0NwUmh3NUxxcHQ5SUJlTHFXOUVaeGNIRVN2?=
 =?utf-8?B?L3ZVY3d5NzFldkpnTmNFaDRmdk9LNmtiSWtRR0FoLzdHRUs5U25CTGY3cjhj?=
 =?utf-8?B?SWV3ZXVHbU5iTXd6dUpCV0FUYjI4WVlmRFdaT2d2WEVTUXEyU2NZeDhZQUxZ?=
 =?utf-8?B?aUhFQ3NGQmZoSUI5MVlrTkhFL0xwMmRzNGZWc2M2cC93bklLUnVuRmczSDh4?=
 =?utf-8?B?ZHU2THRnWEw1T1RnVThhSXo0cFFRZWl3aXJtdHFzdnpFZUlIK1F2QmZiNFRp?=
 =?utf-8?B?VGdTamVmWDVkamNTNTQrNC9HS0ZuQ0xuamoxeTV0K2MxWkxIVERyS3NVM29F?=
 =?utf-8?B?Y1Q5YmUrWlB2bzViMGE1b0hScXc4MTQ2ai9qOUUvNVdnbHBNTSs3Mm9Md210?=
 =?utf-8?B?S2VsY0hiWHBDcVFpaVlZaVNFQ1psa3hXa245RU5ZbWxzajJnN2wxN05MdWQ0?=
 =?utf-8?B?VUxtZUplcy8rM3RlbWR2by9iVDJWZ2Jjbkg5RnFTRTVrcWFZV2JzWkR6SjVh?=
 =?utf-8?B?MUcwNlppdGRZc1RWOXFtNjIvZHh1WjNGcWpVZXIvdW8vb01MeWxseHA2RFZK?=
 =?utf-8?B?akR6b1pCMCtTM2xXRUFtUlh0MW5HaWRGVlkrcmRqSFhaZ3lxcVBCazZuMkpI?=
 =?utf-8?B?Mi94NkFUR0pKYkd3bHdXeHhsS2E3VnFLaHJsanV6NVlyaWNqd2ppQ1o2ZEhn?=
 =?utf-8?B?UXlta1NDdzloNlMvS1VsbDZ0MWlnWWtFZmNDd3hRR2dLNzBqbk02K09kKzB2?=
 =?utf-8?B?azBJeUxyd1VGVHVvQ2NBYXB4dGUydXlqQVdHeXBsUDI0Ni9wZndRaHhRUzB1?=
 =?utf-8?B?RWR5UWhJYzdiUGFycnZ1alkwNWl3MEJCRTNoNnpJdjhjZ0tnSDJRUjNoY2ZT?=
 =?utf-8?B?bThjVk00VmQ2K29lem1wVVVjdUE0WVA1bHpnWEhLNDJhYnN1NW9RYkV1QU91?=
 =?utf-8?B?Uk14MTRzWGVhRzI5REV1aVdTcUVTKzJtbHZNbUFJc1N1WXZ2Y3VxMFVpNmNG?=
 =?utf-8?B?ZzMrSkhSdDB2ZTIrM1pIeXQyeVRRT1R0VERMSlM3Y0J3UW9BY0xqMk5VcEpT?=
 =?utf-8?B?c0RSZ3BpZTBnYSt1czZIL3FCZGovS1ZpRjcvd2RsNS9peERkQnE2amkya0Yv?=
 =?utf-8?B?VjZ0UEJuOVdyRDY4d2JiUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR12MB6838.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MGRiYkpqdFZOSDcrVWx5QlVxbGtxT1A2NFRvK1phOWtnSU5jaU9STFlBalpR?=
 =?utf-8?B?ZE5QMjV2azVLN0RUS1NYUDV4cTdjL29ERkpWZzlCRmRtYWd6R0ZOK2xGWnhy?=
 =?utf-8?B?anVlUVFrNDczTnFjbVRjbW5Edncrc290Z3pqS0FwRzN6NklsNFBPKzZvOW9E?=
 =?utf-8?B?YjdPTXhhWFBGQm1wLys2TUk0WjRxS0h4MWxVZ1VuVkJidEw4RkgrcUczcWVm?=
 =?utf-8?B?cEtzRTdXc0h3eGFyUlV5ajQ0Zy9VMjhNc2FoS0FhOENBaUVBbEpMOUhrb2hE?=
 =?utf-8?B?MGg1bGpoTExBYWFjdkxsbTl1M2VHTkJBVnBsbmxvQS9LNk5aUXltNFBPU1pt?=
 =?utf-8?B?N1pCMEVEOCsyL1RhemRabStzb3FWYytEekROM25lZWpQZ3Z1OWNqdVN1QUUw?=
 =?utf-8?B?TXF5NUd4TmZoMU5mZVZmSkI3YXd3eURKVnZlcE1RVWRtZDE4a3djZ3BjelFt?=
 =?utf-8?B?cVJ4dWRWTmJlN05JUU5mZXFHWmJ1dlh5N3JXemdRYmo2TmNUa0F2dlpuYTMw?=
 =?utf-8?B?ZVp5YStXQ25kRmZtbC9KKzRBZmREeGV4UlR6Wno1aFNVNFVLb0FoTVJxVHNG?=
 =?utf-8?B?M1A2cmhhaU1vVU5ZQVJQZEZOQUFleHdOOG1UUjJWZVpFZytZK3dsNk5ieEZa?=
 =?utf-8?B?T0tSVVhRSStDYUtYS3FCTHZ3dEkzSHBlY0FsZHppQjhHN2E5V3VDcUdNMUIw?=
 =?utf-8?B?aHRuNGsrTGRVWU4xKy9XUkNqZ3BaY29MbXZMeTVSM2l1dTRud050SDFkMHZv?=
 =?utf-8?B?M2o4Z1l2L0NOemJVdlhlNFRIaTNyak5RRjFBTFpvWFR2WnNWQzQvQ1AyZFBr?=
 =?utf-8?B?KzlqSWkxMnNwaVlEVmw2S1pCcDJGSE1RM3BCVUUrR3JEZ2dOdDlqZzhPejZk?=
 =?utf-8?B?WlpSZi80V0xXSDRUbzdhbGV3VnVKNC80dkZNRmhFUG9yUVBGRzNsSFB1ZVVr?=
 =?utf-8?B?YTdEVWQ4ckovT3lRUUd1am1qTVN5WDhrZDdHZURYVFFVc3ZYdHNnR3hISGQv?=
 =?utf-8?B?Rk9Ba1dGck5UeEZEd1M2SVBJUTBtNTd3TEV4bU5EUC96WUdhNzhNUm82aTVv?=
 =?utf-8?B?eHhlZ250c293S2l2VFUzbEJuUC9Zekd3aVN1TThlZERneFc0RldXVFZtaFh0?=
 =?utf-8?B?OVBvR1pmUzl1ZDEvVGQ1ZXRKeFVLOUI0MFdCYXFhZFVLa1ozT0FrbVpsSEpm?=
 =?utf-8?B?akJzRWNLeDRTUjlQUjlsNHNXNUVnRGN5VDhLR1p2OU0waFNSNXZJNy9zUEhn?=
 =?utf-8?B?a1Zyc2VVdXA2RENtSmR6cGl1S0ZRcllTOGIxS3YwZ2txMGhteWZqUGRWeFNo?=
 =?utf-8?B?U2MzZXp4ZjNZL2N2Y3FUa3kyZTBRK0pFck92dmNHdjlwWmVqVnhwN3hsSmYy?=
 =?utf-8?B?UkhrdVdFYmEwditTdlZkMERhUThkdlZmUHUvejhhSU0zS3E0WGtZTlBTU0hO?=
 =?utf-8?B?Y0U3dnVrNG1ONUxNQzk0SEtQNWVJR3czanhNWitVZURWMUJKMVJoc1YxaHcz?=
 =?utf-8?B?MUVFZ2lBY2pGbWprZGI4eXJaV3pVSCtTdmtyMUVsY0xxVWdDRVF5cUxtSVRl?=
 =?utf-8?B?NFlkd0pIdnFady9JTzV1d2JwNFp4WW0vdzdUS3Y2RzJkMEVTeWphRzVPUC8z?=
 =?utf-8?B?L0pRR1hNSERMQUZPN1B4NSsrZDNoQlF2VE9oOUs4YW0zZlhUUGJuM0xMUEtz?=
 =?utf-8?B?MnJycU1lZzJ1Nmk4aVpxOStlUzJSQ0dQVWhib3Jxb0lkNG02TzZqM1lnVDVh?=
 =?utf-8?B?ZEFYck14UDI1TnBpMjhBZGVtaVpITzZ2TkV6Z0NIa1hZaTlnNitCMnREbnZY?=
 =?utf-8?B?b3BMenE1UWRqTnJLRU82Yi9VWUdjWU16WGhRK3VMNjhqenBGTDBSeXF3Wlo0?=
 =?utf-8?B?dTNlQ0JQdVhaVkFlTmxsd0xTYWl1Y3VkUVpMREpxRnhBYzhqbFN2NjhDaVZ4?=
 =?utf-8?B?b1dqMDBWY0NFK1ZqcmRlem15ZVdWakdlY0tLbXhDUTNoUEtGSm80MzhBTmE1?=
 =?utf-8?B?UEdhNit3WDRvN3RJRGEwYnkyYzdzdFBXaUczakk5emFpcm5pR3NDR3Q2Y1g2?=
 =?utf-8?B?Rm9wNDJNUnUzUjNub01zcVViYXhWMXVwVHRXZlhIakM0bjh5d1M2RlloZmlD?=
 =?utf-8?Q?Pn1KlwFhCZFy0AhD2OCywS7G5?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19545750-0cba-410c-7ee7-08dd1b085a0c
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB6838.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 23:54:44.2708 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: heKgfhh0xIUAOVfmZdMLWSSE2GUYMu231aeNpsm410oYBNF3QreG4c9FFzC0FJWDFxdCy0qQv4asELvHsuLv9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6893
Received-SPF: softfail client-ip=2a01:111:f403:2413::61e;
 envelope-from=nathanc@nvidia.com;
 helo=NAM10-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.496,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Shameer,

Could you share the branch/version of the boot firmware file 
"QEMU_EFI.fd" from your example, and where you retrieved it from? I've 
been encountering PCI host bridge resource conflicts whenever assigning 
more than one passthrough device to a multi-vSMMU VM, booting with the 
boot firmware provided by qemu-efi-aarch64 version 2024.02-2. This 
prevents the VM from booting, eventually dropping into the UEFI shell 
with an error message indicating DMA mapping failed for the passthrough 
devices.

Thanks,
Nathan

