Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABD69C79FB7
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 13:40:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4IXG-0006lT-HV; Wed, 09 Sep 2026 09:40:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1x4IXE-0006kj-49; Wed, 09 Sep 2026 09:40:20 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1x4IXB-0006lw-8O; Wed, 09 Sep 2026 09:40:19 -0400
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 689AmhQM1512826; Wed, 9 Sep 2026 06:39:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=K1HadlLkqPXWoFovNIuBelmLqfde/1yl2hodT/wiz
 9c=; b=S0a/N+6P69MvlqhEWXlKwg2rmc5xr0xHJ0IeYGsdK5nFXGwYHVUGiCe/x
 YXVcWFiOSPGl6j2Fyfk+XqaVT0fczAViDZNhgpCsHdxFPl1n7h79q28FzB2Cgqw1
 qXzXfqVfVvOVg24842zRtxBqrhJqROnx5BOtraO/ZH0gsWdC9OVdk+nAO7/ii909
 iNheT/m6KUmKhmn815CewOdrSd3GJzypRFxzisRuooJQ/xqSovqnnQyVjPW2ki98
 GPKhQlt7CCCedu6cFl5xGlOyHEsVcLaBJaqWsB/AR5AkCR/2WzRyMja9yOuitbp8
 vWE13ODJc4fzrxRblvzfw+Bwk37Lw==
Received: from bl2pr02cu003.outbound.protection.outlook.com
 (mail-eastusazon11021118.outbound.protection.outlook.com [52.101.52.118])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4gjdcgv1gw-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 09 Sep 2026 06:39:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n2jhQ6icGxmQoH7tEOtemwW9OvYm87+yI+bSHKH1rf6pnb8eUfmpCAg6/rtJyXqPKTU0ImEt2La/gydTwBI7ldEkQ9IC4SJUju540Ap47qyIUrgpFL2juwZEu6651XXUeLdBUECKktpdp1TnDjrMq7O2N84wu+v/0M/Q3N+ml4riPq5UYtHY+tv4dtxqIUBOu6jrdJ+rk1kARUyjkYLByP6BGGWdhwschOKDVdADNxqi/HipAVmC05MWQt58Oaf2+/yO3YNi/6dYJLnxhGNaWmd8yet4G4FQp62OHXiaK1SXBrzaDtuwJmWo/XUbWseRB6En7h9nw4XvTrJWxKdjpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K1HadlLkqPXWoFovNIuBelmLqfde/1yl2hodT/wiz9c=;
 b=BEojg5IGUm/HhRfgdI1yUI0BySCoZUbWzSGO6PVFiRNTAvw3m4SP6zbkbB/0b+6+zkN0714mf60ekkLICGMyrN7OR6d/rbnKBZO1HYf9ckl/60tZqO/lo7bmtb4iMMdqTzrzxIZAFKU8IioHHl91dy9T21ZoqBEP/GL8qvllXaNndTuRETuKbeZIKx5CBctT1UKlLs6xSwbu31oCikOzlpYrAgSCC7de2VI6Hsl/JvpGaMlZdBJYQKhX3bAk7uYPPb2woylgwGF0Gux8AZ764CioQMD+80eZ4lgbQpRhfQR1UpD/8wNtwjYGeaLjeS5FvKVMJRggTvi4WDhruUIiww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K1HadlLkqPXWoFovNIuBelmLqfde/1yl2hodT/wiz9c=;
 b=x9g5RhUiUDK+1LPVdYnwba5RcwbROs8wZtvkrSUR0wg2APA/FFHMm99Pa1CnKyvu5WI+soKK4o0SAOTo0DEki8ju8j4Ccvw841Kl/t11z/2K10F/1gZeKvBD49myUDV7opLUNSjuDkEu7EkCrkIhJBPPRwjSBuxXMCQRQ+EMwZvvVRd4scl05P6yhlZK2zB/pw0RAuJnl3LkvKteBdP81+Lng+G/0CjxxM5kIZu1mbhUsWXLyO4yn1fD9M7qSwZItlK5vzaGHN8/LNgVcbsGAvRs4QNiRxkntQzVaxuoGwzWN/BtxvNfzND8Zr13uaDnzumeoHX0AC2NyeTjRHrzgA==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by PH0PR02MB7415.namprd02.prod.outlook.com (2603:10b6:510:a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Wed, 9 Sep 2026
 13:39:27 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0406.007; Wed, 9 Sep 2026
 13:39:27 +0000
Message-ID: <fb87ffff-d56e-4c47-8fd4-c30589886d85@nutanix.com>
Date: Wed, 9 Sep 2026 14:39:16 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] hw/arm: Add /machine/labels container for Aspeed
 machines
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>, kane_chen@aspeedtech.com,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>
References: <20260904050424.4049984-1-clg@redhat.com>
 <20260904050424.4049984-2-clg@redhat.com>
 <2f7465ed-9945-48e6-81dd-d7aaafd249ed@nutanix.com>
 <50c3fb43-8965-4cde-a3b8-a01d067991db@kaod.org>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <50c3fb43-8965-4cde-a3b8-a01d067991db@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0169.namprd03.prod.outlook.com
 (2603:10b6:a03:338::24) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|PH0PR02MB7415:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fd68d7d-c2fe-4f40-8239-08df0e77c4df
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|7416014|376014|366016|10067099003|22082099003|18002099003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: M6ZIxq/y9gvRGOU5Mx+1qPenW89XLU4+XM8pZiULCdr4LLX6uaYedbtWTkHAlZH/DAr0Jsh8Xhizz3JUcWbGxTOEm4oP6sZdZT9LNhwhZabVeUiJxhmsG+o+5twzQM368tSJYxN/qjyDwNcn1tEkrCmG9N9ZCb2brgBvIHCQmNNh3RYuuEnQ0c++Rm3YVsb2eFrVjIPWoJuOu1mnShorcJ0wrI5WB6LkqtxmLnEcZNVVmMVcqs+1VVMmdGqcxxWNahuCs2Ugt5aV3UUq2WnaqGHTPvYY0ZBKlSA0t0G/uv+GO7NJCPEbBjPuNg0OOq/HtMGNzQQHQw3O3pb0H21A03P2sv8FPofqd3YvvONcKFR8Rni99nRcLQARj1b2LCI7w0qIvdc7aGbLprfCPGMCtsJD62vkNQbMCeh1IaU3dqbpLCksEp3panjIGpXLvrBI9F87JAwAlHerzJJ3hEjP3c81PBt1Km8QBG7mRCzHbj1u1caJ8WT2grPJ334KP2goiTAyRV6BT9N5ttwx6XuSdncPzxyNU/+OPnMtX9Gci3HKHpa1la2yUrupdHBIqQqCK+EgoqqywtWiQ/XQMftgdbzjniDE1x6UvqUoRTQmo/hFqA0udMqfV9dQfhyCFh8Iz+BgMsLm6W/uXYNVtDFpL4kJr/Au44GJpbZNmbsmeDg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(7416014)(376014)(366016)(10067099003)(22082099003)(18002099003)(4143699003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZmVRS2tlSWJBVkl2RVJ0c1hpUGZTaTdGT2ZLRlMzK2VuWVNZbjJoUXpmY1JQ?=
 =?utf-8?B?Y09VeHR0VkMwaVliMk8yeHJsbTdrMnpNaGQ3cmdCQ2dGTlRhVmcxVVc0QnFw?=
 =?utf-8?B?akFuU1FKUHZzRFJOUUlVMUcrZDY1RWQzL3l4ZERDWkNKUG9vVTBjUzhHaTFk?=
 =?utf-8?B?M0RGdnhBMktGeTNKUW56YWh6M2lGclRSdVVxWDJuQm81ZTFnS3dBcFRhRy8y?=
 =?utf-8?B?MHUzeFdoN3VWbERJbWtKajF1eFlFSUFOTTNvVitTSHI1UDBtT3dlbFQ1dkRO?=
 =?utf-8?B?aWc1dkR6MEV0L2FSdFd2cVdOZWJsSmhmbEFSSCtrMmJiaVg5OVZ5YU0wYUZa?=
 =?utf-8?B?VndWQWxQdXVaVWZmcFBLOWs3dVlUdmNLTmViV3FEZlNuQVREM1MxZ0Q2SWxl?=
 =?utf-8?B?SzlGcloyeVZ1bnIrZEdHOEk2eWR3TVFjOUVLeFNLS1RhWlRKWWpVK05iaU84?=
 =?utf-8?B?UG5YNU90ZWZoNWtUTVhrd0VoVXB2L1ZzZUliVjc4bElTR1NucVhvRllYL3ZH?=
 =?utf-8?B?YVFncDI3V1daVXZ3TlVSQ0VvL3VQa2xxNWVVNHNaM3VqR1d0anRER1duWSt1?=
 =?utf-8?B?UHZIZEx4RXRYK2xUMFRUc2hIQ04vWm9hdlRYMW5DMVlTTXQ1Z3ozOCtNMjc4?=
 =?utf-8?B?REg3aEJITjdabUl1RzFBQ3BXelh4UjJQY1pwVHNRcVo0Zy8rbkFKRXBFaWM2?=
 =?utf-8?B?UTNJTEhkbVN1cnVzaXRMeW00ZFhsckRCY3A5dFZkNXI4dnBzRGNVV2l5TXNR?=
 =?utf-8?B?VitabkJxK0FZZWViNGdpQlFtOUtmZ0xTM1dxYkFSS0JrWHd5NjdKRG5Xc25X?=
 =?utf-8?B?TDNFVmRFS3oxa3pRcXNwbjhYa0I1WDBRNCt2R0pKZytYbjJwQVRoZ0tJTE5V?=
 =?utf-8?B?TW55WTdQM0I0SURZQStUdFQvL0x3SlVzSUg1RzlleDJZM3ltZjRqQmtBSUVn?=
 =?utf-8?B?TmRraEhSVDJaMTJ6Y3pXVW5WZWt4b0NkNnBLUkVhMU9PY1U5Nk9MTmN0QWcy?=
 =?utf-8?B?SUVyTkJRWFEzdkhiMFZJWGhlMkZ6MEJEZFNVZ2R0aTNWMUQ2dURJRXdEejRZ?=
 =?utf-8?B?Ylh4cHBrcUovR2RjOGpYWXVFRWcwcENTY0lTWTkzOFMvazM2M2lmcUtHOXJH?=
 =?utf-8?B?dWNxM0JXaUIvZHdCL1VLeXUxYkZxMlhOK1JTRnR3UEFrNzZ0YVZRaUc1MUNU?=
 =?utf-8?B?MjJkdXV1VmhBUENXSTN2WTUrVDV3VVF5Qk0zUHRPMW5aUjd5a2lIZnNMYm5O?=
 =?utf-8?B?L1ZlZUx2a1NzdkNBRmx6LzN1Q2JPaGhxMXB4MG8xY3RwMUZQb0xrOG5zdllq?=
 =?utf-8?B?bUh3c1NzMDNIS091OWlsWFI4N21abWp4NEdXdDdMV0FIYzhwc1hKbjFlOVM0?=
 =?utf-8?B?Yzd6emEzRWM0NkhPRW8vQ3ZDOXkrUG90QmpuaXBCYVkrckd5ME90ZWxib2oz?=
 =?utf-8?B?OG80NTZMWWUrU0hOZmxMOWFVV0NGOWFONGdETFVVRmhRMDRSdW5BeXBQbmxR?=
 =?utf-8?B?STFHMjBJSTNzOXRIdjFSTlNFeUd0cEorUGdiSUwrRzhHcHNsOWlqUkpSNlpj?=
 =?utf-8?B?ZXNsb2NKdk03RzZnSCtxS24vQnBVL1BlQTRtUHFidTdob3AyNmtGbFU2OFNL?=
 =?utf-8?B?MEp2Ni8vSU9YWURiVllhMEgrcVlZalJxYnhSSXZtK3Z2VWYzQk5Dc3RzWFBE?=
 =?utf-8?B?Q3kwNjZEZFluY29vcnZnQXBZV2NNRGZZR3VxdWVqNE9ubFZZZXV4cFF2UTZY?=
 =?utf-8?B?c3BkT3pDOWtkVlUzK3UvUW9HMjRFR0xHdUNQR0F5RU9UblFvNUxlUmNYQURx?=
 =?utf-8?B?V2dWaWw0djZZMlNaZFZMUUw0UEY3RFI1ZTVEdy8xUEhMb0hZU2lTamt5YjdL?=
 =?utf-8?B?bWpReU9zeFdXNEpaWTA5blJscUhYU2JsSUtBYVhDc2UvdDNDem5La3RSUDYv?=
 =?utf-8?B?UFYzY25pTEFWeWEyTEFmOVMxOUVWakR4MCtMa2E2blpyVHlRcHRqSlg5MUVF?=
 =?utf-8?B?dXc1MTkxemFISkhVK1ZUQ2lEdHd4MjBGOEhTSmpzQkNNY1UvK0J3RW05VEIv?=
 =?utf-8?B?VWtPeEZGMWJSYUxFSkR4bXkvMENUbCtiSWFJdE1Qbjgxdm5yUFdUWDVrTGwr?=
 =?utf-8?B?R2phbHBpSDBrdXRGZEZVMFIvbGR0SFBWK2dwdFMwTC83M3JZRVZkd0pKd0N4?=
 =?utf-8?B?UHM4SmVFRnRQYXRMRlJKU1ZHMHBmU2Y3RUQ2V2ZiOWM0aFZrUGtHWG1Gai9E?=
 =?utf-8?B?RFB5N2ttSy9WWjF3UmRCb05nZVFzZWw4YWFFVlFQVitxeVR6RlFpZmxEbFl6?=
 =?utf-8?B?bUsrTjBNMC9xY3FhdWh6YVAvL2VOSnluVkJwa3ZlZEcxbHRXbnAwcjlSWXBK?=
 =?utf-8?Q?jAXvZQc8J+PH8Pvg=3D?=
X-Exchange-RoutingPolicyChecked: EaQwuGgP2YU4qv+hTsaZd9YX9hGO6yf2h0CwzDR3rI/AyJoF6IxQL5GHaoEliHNkNsGEAMG+8+V678FDhF9fctoeY9yrmA6bnp1HJMMhhn7yysBLFuG5yQI11JzgI18AkdxLNJBHjnjMFXCFfj527yXOnLvqGjd2U3Qf3SrkWqm6Vv4XhCoccq5Oc08ZhxzIn2OM3QP2bfdyQAh0mqYlYsrRXChWlbddEwOtjDJ2zyMrpFtfCYNg9DsIaP9EnRC6HNC/mH1tceSjNTp6p0zcLUBeXo9HV4ByEjfEpZSrUPf3aSrvflRqzDFszJA3EDO/d5dNXSkvbdw8tKgImeFSeA==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fd68d7d-c2fe-4f40-8239-08df0e77c4df
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 13:39:27.7669 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pum0WXI+5RWD7xe3Ao1pHLG+bSUpsTv1wRo2HDHA/FgC701/muvdyeTzKBSTauFGS45bgjVb+6KBx9HlfNXzAOkyABI8jURcZKSzr18W240=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7415
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDE1MyBTYWx0ZWRfX4ybTrTLriOF5
 x4vAJ+NaA5B+ZdoH8IllD+az3KNNDbEczVNuRdqnyrOvq0iFAuU9xh3L7TMWSMDgY4N337s7Rug
 JvkfDPCyx+vlxkiSvZWeQfwDVdmMYX7dns31JqOU52jjPiyKCjUn4SP+w/2VTrcjchLlq3A59YP
 eHZl1UVj0WfqTa9LU7LPpwh9Wtp+U+7YBPMw4vcObezfUEz2orWCuYUs4rpw4MG3EoN/Qahfrqt
 lFqyWryV2nciOWTcqJf3UHvppVQUshhchRubD7nX2SryID1w9QiRpdwVnwveuieTmiFwcg+SugM
 D7VCxllfwKG/LfzRjZ0XB3gF0rYJ0bwnFyyJob95IetfERc1/JMSYnz3eXX1ZhWiBGT4gpVSWHk
 fi+HacLkV2XOOJPBdnvzOLX+UCF1aLTrGeBbjnhGlldA2Y+kDyEltBS53BwAdgOd8P9DZQQgPeL
 W1eqzrqKhElqLLI4XNA==
X-Authority-Analysis: v=2.4 cv=N+QZ0W9B c=1 sm=1 tr=0 ts=6aa16193 cx=c_pps
 a=GSMvsngYcio1OY3xt1HY6A==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=_-M8LpHI31CeLmyZm6wg:22
 a=aow-egSQAAAA:8 a=XoxD_A6Kp8_UevE5QSUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=gFNbaldVC-z-bsjSTzMo:22
X-Proofpoint-GUID: nezW3H-jeQpPcs9ubrQR0YQ1ycMjw3a4
X-Proofpoint-ORIG-GUID: nezW3H-jeQpPcs9ubrQR0YQ1ycMjw3a4
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDE1MyBTYWx0ZWRfX52g0St4EaPpB
 Kvj8RlpXEx4RlGmdWqEIWYQP4iNFZEMx914m/LO17Psx/xg6w/Kkxq6+7QXcvj1H9K8xnPAX4kX
 29DccRhQu4vrvwHGQGRXtfKVJTMvwIM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-09_01,2025-10-01_01
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

On 09/09/2026 12:15, Cédric Le Goater wrote:

> Hello,
> 
> On 9/9/26 12:35, Mark Cave-Ayland wrote:
>> On 04/09/2026 06:04, Cédric Le Goater wrote:
>>
>>> Add a DT-style alias container /machine/labels where board code 
>>> registers
>>> link<> properties pointing to well-known devices. Tests can then resolve
>>> a device with a single QMP call (qom-get /machine/labels/<name>) instead
>>> of walking the bus hierarchy.
>>>
>>> Signed-off-by: Cédric Le Goater <clg@kaod.org>
>>> ---
>>>   include/hw/arm/aspeed.h | 12 ++++++++++++
>>>   hw/arm/aspeed.c         | 10 ++++++++++
>>>   2 files changed, 22 insertions(+)
>>>
>>> diff --git a/include/hw/arm/aspeed.h b/include/hw/arm/aspeed.h
>>> index 245d02e5f757..0b8b40262767 100644
>>> --- a/include/hw/arm/aspeed.h
>>> +++ b/include/hw/arm/aspeed.h
>>> @@ -128,4 +128,16 @@ void 
>>> aspeed_machine_ast2600_class_emmc_init(ObjectClass *oc);
>>>    */
>>>   void aspeed_connect_serial_hds_to_uarts(AspeedMachineState *bmc);
>>> +/*
>>> + * aspeed_machine_add_label:
>>> + * @bmc: pointer to the #AspeedMachineState.
>>> + * @label: the label name for the device.
>>> + * @target: the device object to register.
>>> + *
>>> + * Register a well-known device under /machine/labels/<label> as a
>>> + * read-only link.  Aborts on duplicate label names.
>>> + */
>>> +void aspeed_machine_add_label(AspeedMachineState *bmc, const char 
>>> *label,
>>> +                              Object *target);
>>> +
>>>   #endif
>>> diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
>>> index 1f8d5d3e132d..79b8d55d66da 100644
>>> --- a/hw/arm/aspeed.c
>>> +++ b/hw/arm/aspeed.c
>>> @@ -127,6 +127,14 @@ void 
>>> aspeed_connect_serial_hds_to_uarts(AspeedMachineState *bmc)
>>>       }
>>>   }
>>> +void aspeed_machine_add_label(AspeedMachineState *bmc, const char 
>>> *label,
>>> +                              Object *target)
>>> +{
>>> +    Object *labels = object_resolve_path_component(OBJECT(bmc), 
>>> "labels");
>>> +
>>> +    object_property_add_const_link(labels, label, target);
>>> +}
>>> +
>>>   static void aspeed_machine_init(MachineState *machine)
>>>   {
>>>       AspeedMachineState *bmc = ASPEED_MACHINE(machine);
>>> @@ -137,6 +145,8 @@ static void aspeed_machine_init(MachineState 
>>> *machine)
>>>       DriveInfo *emmc0 = NULL;
>>>       bool boot_emmc;
>>> +    object_property_add_new_container(OBJECT(machine), "labels");
>>> +
>>>       bmc->soc = ASPEED_SOC(object_new(amc->soc_name));
>>>       object_property_add_child(OBJECT(machine), "soc", OBJECT(bmc- 
>>> >soc));
>>>       object_unref(OBJECT(bmc->soc));
>>
>> Thanks for the proposal, Cédric! A few comments from me below:
>>
>> 1) Is there any reason it should be called labels as opposed to aliases? 
> 
> none
> 
>> The aliases name as used in Open Firmware feels more intuitive to me.
> 
> yes. It it just a name. aliases is fine for me unless it introduces
> some confusion with object_property_add_alias().

Hmmm good point. It seems an obvious distinction here, although maybe 
others would find it confusing? I'd be interested to hear other opinions 
here.
>> 2) If there is agreement in this approach, is there any reason why we 
>> shouldn't create /machine/labels (or equivalent) for all QOM trees? I 
>> certainly think it would be a useful addition going forward.
> 
> It is a trivial addition. We would need more maintainers to Ack
> the concept though.

Agreed.

>> 3) Is there any reason why we need to provide the machine object 
>> directly to the aspeed_machine_add_label() function?
> 
> Only because it was selfishly introduced as a Aspeed machine helper !

:)
>>  If possible I think it makes sense to avoid the direct machine 
>> reference, in case the underlying implementation changes i.e.
>>
>>
>>    void machine_add_alias(const char *alias, Object *target)
>>    {
>>       Object *aliases = object_resolve_path("/machine/aliases",  NULL);
>>
>>       object_property_add_const_link(aliases, alias, target);
>>    }
> 
> ok.
>> Even better perhaps we should also generate an error if the alias 
>> already exists to ensure they are always unique i.e.
>>
>>
>>    bool machine_add_alias(const char *alias, Object *target,
>>                           Error **errp)
>>    {
>>       Object *aliases = object_resolve_path("/machine/aliases",  NULL);
>>
>>       if (object_resolve_path_component(aliases, alias)) {
>>           error_setg(errp, "machine alias '%s' already exists");
>>           return false;
>>       }
> 
> I don't think this is useful since object_property_add_const_link()
> should abort in case of duplicate, which would be a modeling error
> anyhow.

Okay I didn't realise that - in that case it will already prevent 
duplicate aliases from being added.

>>       return (object_property_add_const_link(aliases, alias, target) !=
>>               NULL);
>>    }
>>
>>
>> 4) Should we create a page in the documentation explaining which 
>> devices/objects should be included in the alias list,
> 
> Any device in the QOM tree could have an alias. Why would you want
> to limit the possible aliases? a part from dynamic ones.

I was thinking in terms of automatically populating some entries e.g. 
for PCI buses, but from below I see this is not considered a good idea :)

When you say any *device* above, are you thinking of a specific 
restriction to devices, since I can see this would be useful for some 
buses too?
>> which ones are added automatically, 
> 
> That's dangerous. I would say none.

Fair enough. Should we enforce some basic rules e.g. all lower-case, no 
spaces, mandatory index suffix to try and keep things a bit consistent? 
(basically as they would appear in Open Firmware). Perhaps these should 
be enforced programmatically?
>> and what naming conventions should be used for devices e.g. serial0, 
>> net0 for a network device etc.?
> 
> I would leave the choice to the person in charge of the SoC or the
> machine.

Okay.

>> 5) What should happen to aliases for devices that are hot-plugged/hot- 
>> unplugged?
> IMO, aliases are intended for devices "soldered" on the board,
> created by the machine. Devices created via the command line or
> QMP/HMP are excluded.
Makes sense, but I thought I'd ask just in case the inevitable question 
comes up so at least it is documented somewhere ;)


ATB,

Mark.


