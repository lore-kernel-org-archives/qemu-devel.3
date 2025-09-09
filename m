Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A06C6CA0FED
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Sep 2025 15:12:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uw00a-0003VZ-WF; Tue, 09 Sep 2025 11:11:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uw00P-0003O6-4v; Tue, 09 Sep 2025 11:11:37 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uw00G-00023q-3H; Tue, 09 Sep 2025 11:11:36 -0400
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 589BWiSe3337571; Tue, 9 Sep 2025 08:11:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=RRt23kCklZABg49DsI/k4dYLlR8EvFH9JwBCY8/R4
 2k=; b=ytYPA0l0gV8nBdGkHz+D180YyTDgBS+ZXpuOKK7xPT3cX8qlLRO777xgv
 GSQ6kFjQa8PX/M2C3DS1fQEC2c23lWLohxZ0tAqoKfnR4R5E+ACbs8tL2wFP0omA
 8YLTdpKzdnabyfE5Ys1vHdsT4Wm/rjo7y1aLJmH0TpNiKCwYtP5FrCSwD/gB/4hQ
 DTDYGQlyahk2GJNfeiZDAPhDy/D4vmf/7PjB3bG47xARjFS7/x33S0/7ipfqDixu
 HzjUMwTIsJywD5CBzMMgsXSW4OnNiYdTKARgX4uOVrVO3fNmxeQsbqpQWp+sth1N
 VOxJ+hsC0lNR5Ub4oebmpUqLmouFQ==
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2093.outbound.protection.outlook.com [40.107.94.93])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 492bgu1muq-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 09 Sep 2025 08:11:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X2o9UYUCv5hE0NSK9RKpBM6Otyb32EKzxDz0UMImoplAdp7GPBDXCmB5y2a9cq0ySsNJ0grVUNpzcGq9W0UTYyKLeO0ytoK33VBfr5D1auB0dE3jxcz+ZoNgOAHd9fyh301coYY+/UlgqUmHFMFwZQsNOO2TI7trA+TitkX2T7obPLW7H/+dNG5qZWg0mjE7+JMr2Gt7sgvJnG/U6+9Z2tnavz+LE/6e6PZZijPpELq5P3PqcHoXYQhXLyKoNVEqJpBP5ykZ2/qffM/+dHK5xXakrNxAbsuaZ/G69ZDmt6PoAbGVKbZuV5At39sNEujGkoT19UcXkQ1jl3v+A0MsxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RRt23kCklZABg49DsI/k4dYLlR8EvFH9JwBCY8/R42k=;
 b=tW6TuTywYvJY/lFsrmgFdxTKXsJ8xG86NM/SUqFnWuDiegSKdfhmhdrPDY+shSQjH09CHZxnvW+AmfhYlr957Lve8LyeqCbbotRi+dKmahOokbwca8UZHQ8A/o2Y85UQe09DcttJ18G5+4sIdbemxEStAPMf0qXKZZ2aWoxckYbKNSE/nuiePJn/km9niyiS6effZVmXB1uVPOsMJvKjvIezVhQ4EsNip0GAQscvX/4HPpDqspleidbNDJAo3O6HFQ/y3lpbhc6tfIriv3NrUDU7pRIH2WZ0RWOoPbDCTDAgm3KSUn6xcya97twVLFi7kmpA3Cd17biXXIVUBRBkcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RRt23kCklZABg49DsI/k4dYLlR8EvFH9JwBCY8/R42k=;
 b=hJFeaPSilb35CCjhCfFn4dvL2NI0XtMLnfAoE+zW/vIR1aslThihX7i9ZFcp5barceQ+/HScmN15KwieAhDPPQbfeWDMsZOQr/8y6k5CHRZ2iLk6E/hTpSa/4+Lx6Cx8GMCy40OfvQ5N2Q048d+SI7KERpJ9WkMbHYhKsd5LdXbu4CwC4XbOaMigPIbyfrNTLpRuQrxf5L7iwcd3Pdfx6IkCWq2I4EohLGW2OprIlOgpA+nor4ZVtoCskWIERc5MTtZE5VDslCMLJWF7tTV9S5CEBqKzQeXRISnPmskjCVCj7Q4oJV7p8urU+/EVbsjrgBde0b5YUXcIZBT1tjFGlw==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by SA3PR02MB10976.namprd02.prod.outlook.com (2603:10b6:806:47e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 9 Sep
 2025 15:11:04 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%3]) with mapi id 15.20.9094.021; Tue, 9 Sep 2025
 15:11:04 +0000
Message-ID: <e5c210e9-50cb-4434-b3c1-79409c5ad6c3@nutanix.com>
Date: Tue, 9 Sep 2025 16:10:57 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/22] vfio/pci.h: use QOM casts where appropriate
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, npiggin@gmail.com,
 danielhb413@gmail.com, harshpb@linux.ibm.com, mjrosato@linux.ibm.com,
 farman@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 thuth@redhat.com, richard.henderson@linaro.org, david@redhat.com,
 iii@linux.ibm.com, john.levon@nutanix.com, thanos.makatos@nutanix.com,
 alex.williamson@redhat.com, steven.sistare@oracle.com,
 tomitamoeko@gmail.com, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
References: <20250715093110.107317-1-mark.caveayland@nutanix.com>
 <20250715093110.107317-16-mark.caveayland@nutanix.com>
 <47404bbe-dd6a-436a-83f5-5eb235d0c40a@redhat.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <47404bbe-dd6a-436a-83f5-5eb235d0c40a@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR07CA0009.eurprd07.prod.outlook.com
 (2603:10a6:208:ac::22) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|SA3PR02MB10976:EE_
X-MS-Office365-Filtering-Correlation-Id: abd0ba9c-dc82-4b8c-dc41-08ddefb31827
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|366016|376014|10070799003|1800799024|921020; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Q0k1eVhlVnZiNU4zSkZ2NVJITDF4YXc1cFhhTUNkM2xSYkxZRGVRTnR5d1pq?=
 =?utf-8?B?Y0pCdXBtT3hHdS91R1YrMWp3a1NSZ0t4UWFlSHcvTW9vQ1IvUGI3VkJ6Q0pK?=
 =?utf-8?B?MmJaV2FwQlJyajBZMkErVmMyL3R3YjNLWVpNUU8zOHdETnpJemlDU0FzYlBR?=
 =?utf-8?B?OUpMUmhrcFVFTEhwVGdhTWdxYUs4akszWHlmZnJwLzdGTzNjV2lraGRma0or?=
 =?utf-8?B?OG5oY2ZadzFMdHMrYmtSSEpxeU9UZk94YkI4czJqcWxyMFk3Wk1NY1ZabjUx?=
 =?utf-8?B?UHlKcCtoeVNVMlpTYlFrVE9VQmsvT1lWQSs5QU9mWW1HOHhtL3ZMQ1dVa291?=
 =?utf-8?B?YWh4NFV6UEVBdHBmby9mdGo4Y1F5aXQ4MkJMbjhHU3JGYi9xZklLU2ordnIw?=
 =?utf-8?B?Nm9pa3hqWTdqckZuODU2TU5oNHcxb2dveFk5cWtnYkdGeXhoYkloaDZldTJO?=
 =?utf-8?B?TmRhZ1l0OVN0V1pzNTgrdnRuRlVpS2s5Z0ZUL3pxNVBOOU12Yk0xWHdaNXEx?=
 =?utf-8?B?NHAzQXh0dTloSzN1cndzTkVCVGR2NGswcWswZnd5bFExOHVaaFRyQTl1RVcv?=
 =?utf-8?B?OFNRbmloRS9WaElPR1NFSzNDcFFwbFpNcG90TWFyM05ub0lhKytVRFZ5ckg3?=
 =?utf-8?B?b2Y4QU5MaWg3TStHR2w3Y0pVVk5GcHZMNGp0ZCtwZzBHR0dKMEtUQlZWK3Fl?=
 =?utf-8?B?aGt2TDJaUEsvU3JHZ3VPd1NZS3hvQm9lZmNBcm53UE82ekdWUkljSGR1Ty9t?=
 =?utf-8?B?UDdTelpjbVhKZ3djUzN1ZnIzd2RneGQ5clpCbkY2ckhlMUMzQUVTY3NGWnh1?=
 =?utf-8?B?dlVTTHR4RjNLeEw3ckVrc3k2dnR5bmdndUJMRG5hdXowMExSQmVNSEFRNUNi?=
 =?utf-8?B?SkdvcnRmUURIN2Zibk9Pc2ZVSUpXNFdrSHhKd3ZySWVrTEYwUjVFVTdnVURu?=
 =?utf-8?B?QWZabnNRNHJ0cG82eHVOODJVTXFyZ0w2cDNmdjhpM014ZHFNYUczODZzQUNG?=
 =?utf-8?B?cGhqWk5GQ2VSNlhGYXBlZW5wTFk1Y3J4aDFQUnVnZUM0dDVDb2FSZHY5aHZE?=
 =?utf-8?B?clFieDczK0h4U2FTSE96bHVjV0hBakl6Yng5cDdFYzBJbFc3ekorZkhZOGVZ?=
 =?utf-8?B?QldGbGFZME9sVjhXUHQ1VE5haXJMTXpuODBtMWJNMFVmVU1URlFacUpNQ3Vl?=
 =?utf-8?B?eDd5cWRaNEVHNVgxMVNnWkc4aFJHK3ZveWhiWGt4V1QrUzBmajJnUUx2cGF2?=
 =?utf-8?B?dElIeVo4VFVVczhNYlNxMmQ4OUVTSlU2QTkrWEFjOE11MU9CeDZKUzVDNHdE?=
 =?utf-8?B?N25aU1Q2RDBKb0ZNNXRQbTArd002djJZbUgzSVdaa1BRQU10dzNWRHlVdTF5?=
 =?utf-8?B?eGU4WGxSdDBnaVJPWUZjQ3gxdmpNdUJFSEk2OW96empnbkJ4c1FWNk1EcnVT?=
 =?utf-8?B?VExLN1ZhTnVtSkdnN3FaUEg0U3k2U2ZtbnFCZHRDVlVZd20rcGRCL255QS9D?=
 =?utf-8?B?QTY3TnBSejA1WmZUZ1U1NWpxRG1qVlc1NzhvbUFVcWRQT0Q4YjNLUkFMU1hM?=
 =?utf-8?B?NnNESXp0RnVDZ2RpYjR0aVVub09zcTFrTDRSaDZEaGF2WWdyNDF5UlFtK01W?=
 =?utf-8?B?SCtpemlQUVpJWlFSSWhIOE1sOVhsMHVYSXNRY2UvdU1tUGhuNjFVUU5GeExI?=
 =?utf-8?B?a3FrR3Z3UzdobUt5K0t6MWNYV2Ntc1RDMndiNUU5MDdyMDY4a1dRRDBhbkh4?=
 =?utf-8?B?Q21vNW1WaEliL1NFeE85STVBOXVtZEpScGprTUhLUHlhNW1UTEtYL0krWkhx?=
 =?utf-8?B?YnEzTUhZZERHQnVRN1liS1IvdytlVnY2SFlmenB1R1Z5VmgzM0V3TmcyUXdo?=
 =?utf-8?B?MnZ0dFptRzVmUGxiNzFjdjYvaUlLTUhNMUxOSzNwKzYwUVFVUjRTNjd0Ulk3?=
 =?utf-8?B?Z2d5dHN1Tnh2aUlGRGRmSERQVVRUWlZWTDRZYjVKZm1rakZyZkhPYzdBaFZ5?=
 =?utf-8?B?Y0VtRTVvOXZBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(366016)(376014)(10070799003)(1800799024)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NjdTa3JGMndEcFJZRnczL3RVZDhGcUJsZzhaOW0vYkhETVgyU2lYS3p3VEpU?=
 =?utf-8?B?emREdE5ud25ESWIrZkJ0cSsxUzZGREMrYmEwSExiNnlVTHlKUWtCazdrOUdL?=
 =?utf-8?B?REdudENGOUZxY0p0cktIUDgxUVg0QmpkOU5abWh4dFZMeW1lOVM4RnJGNGw5?=
 =?utf-8?B?QkZJTy9WbjVFcmVlUlIwWkUrSnBEUGxyVDRlM0VIelBrS3h1cE9DRHlxVnln?=
 =?utf-8?B?cmdxeVRZdG5JYmY4aTh6VHdTMHBUQkRWZ3Z4VEN5YmY5aUhXcXBFQW14VjM3?=
 =?utf-8?B?MWkreTRDNGFxbUk5ZTd6cjZQZjhkNTVIVEh3VFdOY29CQk0va0JleEVjcXN6?=
 =?utf-8?B?b2c4UFNrREpyaFdoV3NpMlk4ZWlMRndVV2JJS1F5TzJkemVhWWQvek9TSnBT?=
 =?utf-8?B?LzFLU0pOaXFiSGc3SHRKQVFPNGd2QWxHQkhmeldWN1hKbE9FdGFja09NNDNm?=
 =?utf-8?B?dnNvNWJPdDBRbE5Fa0FQU3cwdHpTM01oL2czbnNiT1o1WVNpYzN1Rk93VHRt?=
 =?utf-8?B?b0NCd0R5WnVVMUpjSy9kUUVpb0NXd0ZNYWtCUWpDMWhid0NwQndvNHBpNHcv?=
 =?utf-8?B?OE9vSTloOWJZbmhxY2NkeDh2TU1acWxFTlUvQmVRWkRLY0FlYk4vLzEybHRz?=
 =?utf-8?B?ZlVFL0loMnluYlA5YXh5NWgvR2h5RTdVdUhyMDNEVXR2WUZJd1Q3YllNUHY0?=
 =?utf-8?B?YTFTV2JrM29BMlJYQjFtcGVKVVhNRU1PNmk0dWdZczNzSTBIV01BaXZIU05X?=
 =?utf-8?B?akhTaU00WGo4K2xFbEloZmYwT2VHNDJVM3hUQStYK1lvb2JqVmFnRnc3VlVL?=
 =?utf-8?B?L0NTMGwzVkV1RlNILzZTS2F1RytROFZOL25hdnZsMW9YT1dnVjBqYndwSjc5?=
 =?utf-8?B?eEZEM0V0VGVtZmNrZFBmTVMvcnlRc2MwbmtXampFb1B5b09HY3R4NFNpOGpr?=
 =?utf-8?B?SnhTS05OQzVHVUQ0aFJaMVk1RHFWa1piVXp4enNFQ085aUphTEsvQ2x3T2ph?=
 =?utf-8?B?amJaRUxOa1FHL0NLbXhsejdOU2JJK2VKdXZXZGs0ZGZBWDZmOTluMHVxNkVy?=
 =?utf-8?B?Y3hsNms5Qk9VUm1WZ2lwWjFSMUszT1V1MUdaRmRGVlV4WHFUNlcrQ1RXTEgz?=
 =?utf-8?B?RGNvSWlvUzZ4Z1hxRFFWNmdBZ25kS1pQbUxaY293SCsxZ0M2dFBMaU9rZUxp?=
 =?utf-8?B?MENDS3NTNFZTajAra1pTVjN1YTQ2SGl2ZHkvenIvUHkwVm13TVplS3ZlQk5P?=
 =?utf-8?B?clJNcU5ERFBOK0dwbWVlYnlrYkJJSnRYVlVWREJVbVo4Tng3YlR4OTloQ1Uw?=
 =?utf-8?B?QTZiME5RaU45NnR6VSthRXRhbFo3eEY0em13V0lySGNIRVBPa3RMUm9iUU5H?=
 =?utf-8?B?QzNYcVR4S1pieHVtODRtR1RTS0I3aXJXenBRZ2sxbzgwRlREeVViVmhpRjJk?=
 =?utf-8?B?SmVBcVNvaVVCVW5mYlNQSzc5MW54S1ZEblBpcVo5UTI0OENNR01EMWZySHll?=
 =?utf-8?B?UlYvdktlNmpVbVZtbkNqK29OK1dHYnQ2ZDJzTkVRSWxLd2Z0VlhZdGRyMXdm?=
 =?utf-8?B?d3pPSUNhdURzWjA4b3U4a0FtMEwvZGxnRG5YMmVyRUdBWE43YzNVUkNabloz?=
 =?utf-8?B?ZTgwdlR0Wm5TL1I4U29SODJUNUNMeTQvaUFGRVBydTBUd0RqRFlaUlJwcVY4?=
 =?utf-8?B?UVFtZmV5M3JUSVNQWU9oNUQwM2pYSWp1aEpNVkRkSEFxRUh1bFFwNEg4TXFl?=
 =?utf-8?B?Y3F5YUtOeVdhN1RkVDcwaU9NYSs4dHJhNzNBTGJuSS9lWjBqUmlHMENia1pV?=
 =?utf-8?B?bTVuVVJhY1BVdEJHSGw3SXE1c1E5Vyt1MFJ6SGFrQ1JXUzZ4dlg4N25nbkFY?=
 =?utf-8?B?VDhJMkJ3Tm9xMzVqWW55K2tsTEdESlVqVmQrejhLcXBKaThHZVlqemRiMms1?=
 =?utf-8?B?a2cvZE1KNXJPSm1ydmJCSGdNd09ndHlrTzczNmFUTFpsUFJGcGx1cmxLUlcx?=
 =?utf-8?B?eXB4RTAvYWpGaGxpZG5QbGVoNEx2ZVVsNmNvT1Z6b1RRaFYwalF4Y2hJVmln?=
 =?utf-8?B?eVVKVEQ3RWY0WHJkQ3hHVitnRnlKZkVjaU9PZHh0RDM2YWEyVlphQ0RaZWkv?=
 =?utf-8?B?Q0h1VGlFWVhhTDZRemhNdDBsbTNMbzBMaW5zQ1l0T2EwdHdBMWwrZFprczRN?=
 =?utf-8?B?a1E0T05wdldnTXZLTURvR1VqQm1rOEdHN1loSEJhTk02bk5ZeXM4N3pYWUlx?=
 =?utf-8?B?Y2o5RGVFNGdKODlaS1ZFQSt6YXVRPT0=?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abd0ba9c-dc82-4b8c-dc41-08ddefb31827
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 15:11:04.3716 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fWCzm/jbV2o8VWXwErPV+ledeHThPuBkfG3fp0CE+3ZWwUyOTZtMWmpXCqLNJG84BAC0wP7xsHIgz4OTBX5qzLNKz69fxjKYNtgQcu9p6JM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR02MB10976
X-Proofpoint-GUID: UheeZsDqEBiH-5qE3HLUxdIGYr8ECWxK
X-Proofpoint-ORIG-GUID: UheeZsDqEBiH-5qE3HLUxdIGYr8ECWxK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA5MDE1MCBTYWx0ZWRfXzti0dmmab9q6
 WXQ7EVln0pL0jw8Nyq3gBvEK2AkUXwmJXVNyfSQDMiNVrLoTiIWwCF8qrKWX6TmSZ0dML9Asfs2
 yNX0EbOWC4pTSzCrpzuGUB1LPy2M3BSTLYTX7TqPTZr+rjtcu72d8D0SbkKzQrFujHMLPuvR4Cg
 /XOpHafFGpSBEM2RrjU9dMFI1aV/wUX+e8CpKGV5dlzDPQDHk+pywFvMXStrcETM6hdpG0XxSSj
 gdl8AiPKNZAENszrpWjqU9TEQZd+xbdobTiNbv3r1A++qHD0I25uKnWU3vNO0GDT/zNkrAMv3wa
 EKxQ34q+h0gUdlTF5mtGdOf2kcRmaNPsOQQ+1W/3khisVJ2QtzxAUfNABwh3NQ=
X-Authority-Analysis: v=2.4 cv=ToDmhCXh c=1 sm=1 tr=0 ts=68c0438a cx=c_pps
 a=SJgGIGtFXOq0oq98/awEGw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=0kUYKlekyDsA:10
 a=64Cc0HZtAAAA:8 a=wsE-6SGPl7DGLiYNd3EA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-09_02,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 08/09/2025 13:41, Cédric Le Goater wrote:

> On 7/15/25 11:25, Mark Cave-Ayland wrote:
>> Use QOM casts to convert between VFIOPCIDevice and PCIDevice instead of
>> accessing pdev directly.
>>
>> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
>> ---
>>   hw/vfio/pci.h | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
>> index 16f092a0c6..c0c3d68742 100644
>> --- a/hw/vfio/pci.h
>> +++ b/hw/vfio/pci.h
>> @@ -206,7 +206,7 @@ static inline bool vfio_pci_is(VFIOPCIDevice 
>> *vdev, uint32_t vendor, uint32_t de
>>   static inline bool vfio_is_vga(VFIOPCIDevice *vdev)
>>   {
>> -    PCIDevice *pdev = &vdev->pdev;
>> +    PCIDevice *pdev = PCI_DEVICE(vdev);
>>       uint16_t class = pci_get_word(pdev->config + PCI_CLASS_DEVICE);
>>       return class == PCI_CLASS_DISPLAY_VGA;
> 
> 
> This patch does not apply anymore. I will drop it.
>  
> Thanks,
> 
> C.

Thanks for the heads-up - I'll take a look and come up with an updated 
version.


ATB,

Mark.


