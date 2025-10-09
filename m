Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6420BCCD183
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 08:44:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6mFZ-0005zt-95; Thu, 09 Oct 2025 04:43:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1v6mFW-0005zU-75
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 04:43:46 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1v6mFQ-0003Xy-EU
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 04:43:45 -0400
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5997l1QP029590; Thu, 9 Oct 2025 01:43:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=ZLQrv10lkBaj4kEY8df1XBw+EChqFmRSz79AAy8V3
 Yc=; b=omt7L6EbBe3fAMTjYheA+S7EQG/k3VmHbEg2IXDAugTyAGcGIhp6n08/P
 2cGQ45FuqXbq/vPSnS8crNxTOQBt3y2L/xvxRIjch8Y+EVRK8J6L0CfTuy/VRtXC
 84k9u/eXmGXCK7Gwu+njkWvoePdzPbxhlwvX53MqYDu6V78PgRgFXKHJTDMT3Y6g
 d3LSv7q47nf+D4ROfKQRC/vEoGgwh838Nbg42jJeiVBPwoQumYMrpRHFwL2GR6Vo
 yile3jmLCUc2DUoleTOhTjH8eBC3NPhCx02DsAKxmJIe+3mnx6ST0jZlpWo+S0IS
 F8FVLQ095brTYmUPUS5vaABBEIdLw==
Received: from mw6pr02cu001.outbound.protection.outlook.com
 (mail-westus2azon11022072.outbound.protection.outlook.com [52.101.48.72])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 49nx1usd8x-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 09 Oct 2025 01:43:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QCho7crizC/bcOyUBXHCkRoYiLX6S10pSdXRtaF9MPsn36+3bMjtO0S23Dgo+M9A4s2+y2qpbkguyIU20PwnKpq2QZycxs799qRXp9gwwfkrRSv2YhGnGHrDfzHCThoMxggX2cNVlPflsVzcvxO2ZU+vRbfgDaaG8L0h4pGhjNOZ7Yf99kuHGib3PyTstkdGN4w+1XlqKvUmRYhZkzo6mV8KmL9Jo3jC6u3Of/SkIlGdr+1BQP9ACaUcvfMGK6gYou1DiTRwaVwnMuDJk+ZkSEBUhO+vhMdU+7pGfEhRmw6uk5lm1pKx9DkqtH8MHC2UVDBHk2IAlDRbzFt6GqpVhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZLQrv10lkBaj4kEY8df1XBw+EChqFmRSz79AAy8V3Yc=;
 b=rUJUD3JaJFKxmLlGwkrxYcB3jRoH9uhKLGo+E4BtCmTd5XdIDWmkFXKPBiIaohj5ql3by/nniW0b2CsPm0DG5D+ifaKnbh3gguL0kCOUv/3fW6UtboGGf736/pRrMUGlmc+PTEgKdMtl4Pp08n64nXBeCZerFVvAv5W+MLFcRODLiWY/C+oNO8dqO8jM9FDDrIj+18mwJ8mVwep8NyFYxv/JcprNg+Bi85ErFTavmlSYnyJFlTDzkopyN62qxuQG/+JdT3NtWYGn+1MTH74mBHm3ptGfXb4yogshvS10e2tCEaTclCB2X9c5A6GDwMSrx0p69L97vg3UBEtyGWCwEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZLQrv10lkBaj4kEY8df1XBw+EChqFmRSz79AAy8V3Yc=;
 b=IBFH45COO4dw2/MR/rKe03vqsPmfzRfp7VeeH+abaK3D/Lkl2Zmoo0s/g7ttIxftowkBnoa8V8qwDJhwMe+addaPn4NBkA8S55dQ5MznHiEEZU/ke0LPpSJYHxIPwKJ8uQkN74b5qxfUoVFbTA1Lq/IDJfz2+HckeWqyoBZDEZMh7u/+0n6ECYOm+wEiyL3hdGhPWyfD3qidUfBJnz4HJsVpetFG71votUM9XbZSKAnmJF7ZwCkvJoRldtIMibf2MjZnnnZ0FUDOBW7WpAfmWoQSVCR8ORbkz9xxl+uzv35Nk21TS5ihYt9cn1tZQ4NDpKABn7fwJxb+gzj+kNiVbw==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by CYXPR02MB10193.namprd02.prod.outlook.com (2603:10b6:930:dd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Thu, 9 Oct
 2025 08:43:20 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%3]) with mapi id 15.20.9203.009; Thu, 9 Oct 2025
 08:43:20 +0000
Message-ID: <db2ca904-5d1c-4c96-8950-d3d943940d64@nutanix.com>
Date: Thu, 9 Oct 2025 09:43:15 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: MMIO through IOMMU from a TCG processor
To: Mark Burton <quic_mburton@quicinc.com>,
 QEMU Developers <qemu-devel@nongnu.org>, peterx@redhat.com,
 eric.auger@redhat.com, zhenzhong.duan@intel.com,
 alejandro.j.jimenez@oracle.com, peter.maydell@linaro.org,
 jasowang@redhat.com, pbonzini@redhat.com, tjeznach@rivosinc.com,
 steven.sistare@oracle.com, clement.mathieu--drif@eviden.com,
 joao.m.martins@oracle.com, ean-philippe@linaro.org,
 jean-philippe@linaro.org, sarunkod@amd.com,
 =?UTF-8?Q?Phil_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <1C343F6E-05E2-4EA0-A338-0C48A97FF263@quicinc.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <1C343F6E-05E2-4EA0-A338-0C48A97FF263@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1P222CA0052.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:2d0::28) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|CYXPR02MB10193:EE_
X-MS-Office365-Filtering-Correlation-Id: 84173920-4fe7-4316-e707-08de070fe5f4
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|10070799003|921020; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dU5uK05rcUdDbW8vdkwvZVJwWVozd2ZRSVYzYXcwVnVWK1ZoeUNBZndNbk14?=
 =?utf-8?B?RnNKZjRKQmpvQjZuVXhPYVF3clFiMmNQeldjOS8vTHNwYkhHYmVWcVBSbGc3?=
 =?utf-8?B?d3dyQ2pUK1d5YUZONWxFamdWcU55aHJaSGdWNEoxdW5BZldYVHkwOFRvbHBj?=
 =?utf-8?B?TVErTXlVRWl0SURRS1poWnpBSTlBN2NqNE8zbnRXV2tWUFNoZ05Eb3NTSEhC?=
 =?utf-8?B?MzJXQnhHL3R3T3VhQWIzbVJPNFl2NDlMaTBBSmRudTg5RlVTeEN6ZGROQUlz?=
 =?utf-8?B?Yi9XMHQ5aEkyVmFleGkzem83aE45OXRqb3o5YVBLZ09JdXlVSlJrOGQ4Wk1i?=
 =?utf-8?B?bnV3TTB5M0FYY3lralJ0NWNtTG9OeGhsaFBMMWZVTlpSMnNmdnJCNzlETnZR?=
 =?utf-8?B?eGJOckszWDZNa2EvY0tlR2o4eGFkTmM4VTNOajFmWHZzdkxPSmtYNEI3cW9s?=
 =?utf-8?B?NDRYL3BVSkt5RGpIWDhCUHFBWTg1NUV4elFKNEc2cUt1Nmd2bXhFOXlhSWdW?=
 =?utf-8?B?bXBGZ2R5ajhqc2VSV3RrcCtYR1BPNVA2SFJONTMxSlJlbUJsdHFaR3pESGJW?=
 =?utf-8?B?eTRlcCtmMnB5QS8wNXFDbmdGVHJHd0lNWElxUmg0WXB0Z3NxVG9TREdWZWQ0?=
 =?utf-8?B?UVlOMHl2cTZRdjdJQWRCMnRoK2lhZldJTWNNQlFxRlBKZjNQU2tVUEpCTnM0?=
 =?utf-8?B?UTdFenRpRFZ6M2N1WVZVVmdPN0tKTDRaOTVhbjdmR2lYN1JhS0hTeSs2Q3lN?=
 =?utf-8?B?Nnl0N3lZS0JmZ29RTjJaYmhLSTVzWVA4MUVNZndMbXcxek9vd3M3NEVqZDZm?=
 =?utf-8?B?TXFnUWswMnpTWFpOOW05OFM5Q01RUi9jTEZONU4zVTMzZTJtSHNBWGtFNFZN?=
 =?utf-8?B?WFRQdE1jeTIyaGpwb3BrM3JSZXU3d2pLeUpIb1djVmdHZUd6OXdQb09HdklP?=
 =?utf-8?B?dE1vWVplOGY3S2Yvc3BxZkcvMll1amsvUTk1ZUFkY256a1VmWTdkT3YwUXU1?=
 =?utf-8?B?YytZM2xLVEZSRm03cTdCcnYwS1V0OHZKZ3pJaEJhaCsvNEZ2L0tXQkNYYlJI?=
 =?utf-8?B?YnJiUFhYY21NdDN3bFBKWWRrMWJRVkdqSzNIVFVoUjl5Q2R5TDUrSnl5Sno3?=
 =?utf-8?B?MGxQa0ZScndIL0pEZXZhSW9RTXZzQkRvemE0U2JncEx3bzFVS0pxd0pzTGNi?=
 =?utf-8?B?a1gvSDc1K3FvRWxUQlZpejB5MkdOM0dZeXdjcHVUMlFJNjhHSEozQ1pqRDIz?=
 =?utf-8?B?aUtoU205YlNpc0g0U3o4VlJiUmJQU3dTTXE3Rm14TndOOXlVenA5TFNLTnpa?=
 =?utf-8?B?Z0w3RHdRZkhOQnhVNVU2T3dTeXVqdFY5blV6ZHpXdkJYQ1FndW5sMjJ1aHJJ?=
 =?utf-8?B?VjdEcVh5WFE4dWJHcDd1eWw5ZDhvTWRKV2RmMUs5VXE2TXNnYm8vNkgxU25a?=
 =?utf-8?B?aG1ZSEVNeFFBQzNhWDdaYjdiSUg0NVFvbGNhc2Izck1JaFdoQTVUVy9GemV6?=
 =?utf-8?B?WnFTNWx2YnBNaklHSEhkQnlJRTdqbGNZdE1NRGZxZk50dG02cUV3MG9nSHow?=
 =?utf-8?B?TWsreHFGM2wzUWFvSFFnNE1NMTd0YytzamtoRm45YkpHVCtFZXU0UVJ4WFU4?=
 =?utf-8?B?MktnUjFDRzQwZ3RhLzBiMXRWQjZQYmVUTTM3bXp1M2dKYnBRb3VubitiNHp6?=
 =?utf-8?B?NlFjUHMwY3BwSzluRkRocUtsQmRzMlROeHpjL1lNcm9zRDMzMi9KRkliWWRC?=
 =?utf-8?B?VGNvUUVmOThKeklPaGhJYlp4ejJNbThNRklpY2NiMURPVlZNZy9rN3krK3BP?=
 =?utf-8?B?NGdEVzFlSlJkdXJicm0veGlJenFuZ0Uxa3VPbjJYUzdCaHUyMW1aYXZyaWxn?=
 =?utf-8?B?azVwZGVqcU51UEg3dnVmbFQ1OUJXNUhZcFVlZ1dZZ3VXczRaVzM0RkVKb3Na?=
 =?utf-8?B?MFdnTHlJUU5FLzdDVDZHUGFxYkppMnJPSDdadVZic3R1MEZrUEdXTDhIY0hv?=
 =?utf-8?B?MWcxMlo3Rmp6ejZVSnh1cmpEUllDcFlFVkF3SkJLOVJVVHR2Wlp3bmh4bkVw?=
 =?utf-8?Q?odJ/uY?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(10070799003)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b3ZKQ1lIbVFzaG91M2JHcFhxMEZ4ejhmbHJGTEVOSmZYZHhaclpmVWM5Z21r?=
 =?utf-8?B?bDBaN0s1N1BNTk4rZ1N1Y0o1ZFJSVlRGZHRKaEJsMXVwNVVDbWlkSFIxVTJy?=
 =?utf-8?B?akZwbmhsdm90TVhXdVRCOXhBM2tQVjBvUjNGcW91SXJBSmpQWlJSTG9nVGZ2?=
 =?utf-8?B?UDJLbmREL05NNDBsVGlUdVg2UVB1MHRCS0NrZHZ2WGhSR0swaW81ZFhYa3R1?=
 =?utf-8?B?c0NKcExhVVBFTmF5Vm5CTkc0MGMxVHJJL0dLZGVOMEQyU2x5K0c1RkpaTU9m?=
 =?utf-8?B?eHZuME85aTFJREdaOEhlN0hhc0gwbXh1amc1NDR3M0h5QWtjeEFmYm5EVFZ1?=
 =?utf-8?B?dzVCVTY3NEd2NGdRMmxrbk9nRG90QzNpc2JVZmVVcGVBUDlRNkFnQmd1NFlk?=
 =?utf-8?B?TXdqNnRvSUxDaFArNmEwYkUvVlZUM3RLK3RIamtUc3R6SlhwQVI1S1hLeVVG?=
 =?utf-8?B?UXVVVUUycjFvOGpBeER5dUxVRStkalJudUttUXArSVRnRW9ZVDc1bmw5Z0g4?=
 =?utf-8?B?Zm5NV2xDTUlBWlJxLzJ1Y3pFRThkSStHcitpcWhZR2ZDVTlwRVRvWlNvOUMz?=
 =?utf-8?B?NWpQSG1kYlJPbXJGNkw3N1MxZlZWNGs3MUxwN0dMc2pGU3FBRS8rRDUwNnM4?=
 =?utf-8?B?UWsvY0RmMG5CRW84M3JYRFNvZE1MNEcyYlZxNndYbFc5QUliMk9xWGxZd1ZH?=
 =?utf-8?B?VWk0R2pYQ3ZPU1hBWEFYRTl6Mk41VDYyTTRUZjNuNmo1SFoxY2xTUDhhQUor?=
 =?utf-8?B?OEFESy9sbVNMcnBrSzNoMUtBejArUktPdG9ad1BzcVd1bmdsR2lzTjFpUUox?=
 =?utf-8?B?ekFlbytialEwTHVFZ1JheGtNczd6S0svQ1BzT0ZYT0grcmhjczV0Y2pPZFVq?=
 =?utf-8?B?Y0FETjgxTGFDSXh0Z1JvZXYzWmJWenlEcWx0OE0xSVE1NThBOWxPTmlSY1JC?=
 =?utf-8?B?SWNiNTF6ZXBISnRER3pvN21HQkE4SjRWWVJHN0xNMnh4NG1sejNiQjF2dndw?=
 =?utf-8?B?cENMR2tTWU9PaUlMZGZqZWJEb2VOS3pteHlKWEJCV0JmaGg4V1lKMFo5Zll3?=
 =?utf-8?B?Q3RJT003eXBLaURYSEVLT1lmTFNpWDFCSEg3UEIzTTNwSXdMUHRNd1hyWUlt?=
 =?utf-8?B?ZmNxaGRyclhRaWZuRWhWbG1DOTk5Z0VMNHY4YUsyeC85dGxzNDhXc0trUVZP?=
 =?utf-8?B?TDhmRlNUdlNVSmx4UXF3ZjlLUDlpeU9FL296RjJjcmJxTGxkU3NJcTRwUDdp?=
 =?utf-8?B?QlpkaFdLUHFwUHJlREU5RjYwQlJIcGZiMFVJQ0dDdjJ4bHB5SWI5NkVyQWhU?=
 =?utf-8?B?NHNXRFYvRTlLUmp0YzIyZUY0Q1puWDROSXo5eTgwMWE1eWNna2MwcFJIeHpG?=
 =?utf-8?B?RlBSdU1ZUnJjMXYyMXZIK0QrOVBzOElwS0JCSHVLS1hEbWQwWTFySHF3Ym9u?=
 =?utf-8?B?SDB6MUtMTWJOM3RzVGJ3QjV2SzVZMTEvRDZqTGx5cXV5UlJMWG5vTGdZNWR3?=
 =?utf-8?B?OWtYZ3E2WXAvRlRSQ1ZFN0ZIbXBSR29LN09ncElxZUZEdmVDTGFKb3d6bFhr?=
 =?utf-8?B?dnR2SVRhRVAwc21IN3NBSFlHWGQycUY5MXd3cFE1OW9pWGttc3dYVUFnRG5i?=
 =?utf-8?B?L2RyeWlMekxLcUR5ZTEwSThJMEZSdTROcHF0MUw1MmR4TGlDOEtDZW9HYkNh?=
 =?utf-8?B?VnBOU1J5Z2I5cmh6L2FIc0V1NVBMMFhjL0o2ei9PZFZZVC91NVYyWTZRajZ3?=
 =?utf-8?B?dFNHN2ZPcGNJZ3hqSzhGVWcvaUMxSGg5VG1JdDNMVm5rbGJ6UjdHUi9Ob0Ru?=
 =?utf-8?B?ajFNVmtGY3ZLSzZMUU9PWklvQ3JpVlgzU3ZibGNPK1Jta2d1ZnFWdnc5eTRG?=
 =?utf-8?B?Vi9qZEZETHdJaW5zZEhKVC95YkJtWFQ1b1prQ1hMdk5qTk9SbzVvQ1RVWGN0?=
 =?utf-8?B?Q1Q0K0pCc014THM5Nm5FVUV3VCs3eG9qOXJQNzRHdmhidE5OUlEwcVpLVHhL?=
 =?utf-8?B?RktZYTN0Mlk3SCswRUpOenRTVklWNEszNldRV2ROdW80Q0c1QlpaMzY5SjE0?=
 =?utf-8?B?NFB3dzNOT3hDdFBDMklKa1QxR0VuUnpxczhTQXQ4WFppMjBsMGZ1bGI1bXYx?=
 =?utf-8?B?OWtnZmM4ODl4UnpBYmtQRVRzUkdHYUQySHVyYks3NmVDOHVLVWpEL0p2UEhq?=
 =?utf-8?B?RFpXb2RXa3BiL3ZyejhRTGMveWlKTUM5ZlBDMGREOFcrQkNySTdSam8rcWNS?=
 =?utf-8?B?SzZvZXdZZVpTbUlhMG5nMUhMSXZRPT0=?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84173920-4fe7-4316-e707-08de070fe5f4
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2025 08:43:19.9182 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y+iUsnGgsHoVmrdc+czrVaU8kL//4y6F8+aCyvMB6Krgm0IYCVoNeXvU7zAoRZsmnpP4N0F3/ep+e6fqsAdLAd18EGjfo+jCwdn+fMVWCFo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR02MB10193
X-Proofpoint-GUID: zdjWm1bn3oJPTvD51uupDe8v7Raoum2h
X-Proofpoint-ORIG-GUID: zdjWm1bn3oJPTvD51uupDe8v7Raoum2h
X-Authority-Analysis: v=2.4 cv=A41h/qWG c=1 sm=1 tr=0 ts=68e775ad cx=c_pps
 a=hro4gVXncoUBxB/Amc69HA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=0kUYKlekyDsA:10
 a=p0WdMEafAAAA:8 a=WILvRPEmedfOU3yOzPkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22 a=poXaRoVlC6wW9_mwW8W4:22 a=Z5ABNNGmrOfJ6cZ5bIyy:22
 a=jd6J4Gguk5HxikPWLKER:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA5MDA0OCBTYWx0ZWRfXweFIunNbIV2U
 E3MHa9X8WGDzDMiW1g7/gGcT8SvsrVfwvjp7Letos7E7mjQyYrz3PebkbtP1fInQpkf8I80aq45
 bbDUow22BmX7XBIwGA9kYdSHAraELcWMcGS9ny2gj4efWqH/bhDSE7OmMV3KETed+6VfKvw60oC
 vOhzAS5ssYpmufpzofAKzGfngUlBt1P9sZ3PrsNGIdOx0SLoNxGrW8Hnrb1ELo7wTtlvGAJEF3x
 WU55QQmfwpFGEg1RulTEcdZ5YLQ9R50oJnHcJMsovGTQ8cjQxYjceeBAzTu81MJNG1Meb1jTFwE
 V15WRziFNC2ozRE6An71gI0XQU67/TncuPawIAbNX7r/9WDBClape/EKcfQwGf2kwDtK/7rGLNG
 1EQq2DJMMVLqmb8eluPYOpeem6HIiw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-09_02,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
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

On 08/10/2025 13:38, Mark Burton wrote:

> All, sorry for the wide CC, I’m trying to find somebody who understands this corder of the code…. This is perhaps a obscure, but I think it should work.
> I am trying to access an MMIO region through an IOMMU, from TCG.
> The IOMMU translation has provided an address space that is different from the CPU’s own address space.
> 
> In address_space_translate_for_iotlb the section is calculated using the address space provide by the IOMMU translation.
>> d = flatview_to_dispatch(address_space_to_flatview(iotlb.target_as));
>>
> Later, we come to do the actual access (via e.g. do_st_mmio_leN), and at this point we pick up the cpu’s address spaces in iotlb_to_section, which is different, and the recorded section therefore seems to be incorrect.
> 
>> CPUAddressSpace *cpuas = &cpu->cpu_ases[asidx];
>> AddressSpaceDispatch *d = cpuas->memory_dispatch;
>> int section_index = index & ~TARGET_PAGE_MASK;
>> MemoryRegionSection *ret;
>>
>> assert(section_index < d->map.sections_nb);
>> ret = d->map.sections + section_index;
> 
> What I don’t fully understand is how this is supposed to work….?
> 
> Have I missed something obvious?
> 
> Cheers
> Mark.

What version of QEMU are you using? I'm wondering if you're getting 
caught out by a variant of this: 
https://gitlab.com/qemu-project/qemu/-/issues/3040.


ATB,

Mark.


