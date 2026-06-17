Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA19ECD98E4
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 10:47:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZnnF-0004yx-Rh; Wed, 17 Jun 2026 06:46:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wZnn8-0004vZ-EF
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 06:46:43 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wZnn6-0006jn-PS
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 06:46:42 -0400
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65H8Xjwc1038455; Wed, 17 Jun 2026 03:46:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=OaD/z36+woaxWsEpjsSVjAaDbaqc2uceSF/QErEda
 qQ=; b=gUsb/1OfeNKfqAWiBqEbb241hSxVVP8SQTl00DGHhM9auce7wPXFZIs1/
 QdNtDVw5lOPopwrQKXtW8H/WzmbaT2KtOfz4scx3FCQHQiOhNPOGm2kiFnot+H4p
 I703/rfXXZJSOWxLVjNMlVXDEX8wsZHbhqwERyYT9EQjRVJYsULPpW2c8H2uEQls
 NL6GCxCR1wcq0fMPIABH4V+wFXbp/2Ob8GPSXQHxX4CSfDmgQjgLq8+1XEdrabNm
 VldjDfwEjnOFOPN/8BqkkNFMDGLfCaVpDHQF8nTGqE4x8LKxskWyvPZZuWPsacZD
 djTMi9UYNaWko2klGkyFh6+FAGogA==
Received: from ph0pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11021132.outbound.protection.outlook.com [40.107.208.132])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4euefxhgwu-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 17 Jun 2026 03:46:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QGOJ74qQWzem8iueR6vytzzwYbKtzlueJcdFv68NmHBwMAwq3Pq6/pTZwF+kzQuO0gRvcgKqi89DRsxyg2iLiOTe3rstHfqOkp1L4kcYYTdYPUl2kAJ0wsxyy8q/WNhsOY6TtvsI1l8qfDcAfSJ3tSlNugqGqkSnKhmnLEJJTHQXHhmgVt/9I7PhbnaTVL5dbsJB7M0UlUEsOQebIKuh+pDpXHbVSE1h5AZG2jHmKi7cpd4S7P0anXQocDn7lZUOOGTwmIRCieFQuxweV7/tH0f4Fhz0jXqT6kwe3jm6njZkIm8x9lR2i5DhMxnfg5W8GJlG7rWB3fam3dBdvSWjtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OaD/z36+woaxWsEpjsSVjAaDbaqc2uceSF/QErEdaqQ=;
 b=nDuADEx6XWB4Dqot6AplBqrRToW1/aBBUv6aTl4fwQrbU9A9AEOiwuA3cc4fhC7zf595JqRVCQjVXAvcFU+/SKPpvBiu1Pcj1YDSc8KH2ljLgXk5IGVaqdcze8J66v4dN8367PlzmlyNKYPSLmJINmFRXEaXyT+cnAA8W6cfNkGJez08noswEVzwftSuH7K4pTSuFvABBw7Q2i5egcHbqfjezUyi2JuqmDDICzHeiPoyukuBITyF4rytnBhvZP0nFIEewHNcUl7386G4NLhtXw10VoXNMgrm7u7Sr7mjkKkaDBAWTyvz/8+XIB/nrYWjC7ynJvZTx5uqpUfDaLnovw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OaD/z36+woaxWsEpjsSVjAaDbaqc2uceSF/QErEdaqQ=;
 b=VCdKf47D+7r7JeZnk/6hNhsiMxmIN7rSEwcLvjjh5E8T4xKFS6AiWsRfz8wHE+TaUjFrAms2sJdsJ48R7fUL3yagt5GeztGSsJQLcoZk9LdYxpyVO78MM6DsMWjkMA6AyGY9QMO2r6sZ6rmCXs+f7qe+xQU6SlfzDIFKqZZQwFXVIuGnpPqbZOaKr3cDTBItmCVqj4tElIlXk/f7NZg3dHXLKdgitk6weqNA+MlD8MQ0dUnQCRxjs4LgtSHk4ABIzmjoXROmabW9A3ZuN1jCecbg97vHiHnofD/er7XCczIZ5P4QEQZaj91idD/ZdiYREFV8+05iYno1Cy45V/kvvw==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by PH0PR02MB8374.namprd02.prod.outlook.com (2603:10b6:510:102::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.13; Wed, 17 Jun
 2026 10:46:19 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0139.009; Wed, 17 Jun 2026
 10:46:19 +0000
Message-ID: <c4868d35-9437-4a3c-b235-8a854abcf707@nutanix.com>
Date: Wed, 17 Jun 2026 11:46:14 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 5/7] system: add qemu_irq_new / qemu_irq_new_child /
 qemu_irq_new_array
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@mailo.com>, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Xu <peterx@redhat.com>, =?UTF-8?Q?Herv=C3=A9_Poussineau?=
 <hpoussin@reactos.org>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Aurelien Jarno <aurelien@aurel32.net>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <20260616155554.264412-1-berrange@redhat.com>
 <20260616155554.264412-6-berrange@redhat.com>
 <CAFEAcA9QUMgAz894D-jEx-Q8=Esi8fnhivAyKtekqHukEcuibQ@mail.gmail.com>
 <ajF7hxZP4a76yxxg@redhat.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <ajF7hxZP4a76yxxg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PR1P264CA0144.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:346::8) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|PH0PR02MB8374:EE_
X-MS-Office365-Filtering-Correlation-Id: ef3ac058-466b-4ae1-d7d6-08decc5daa4f
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|23010399003|56012099006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: cj7ZLh7GJvQ2dmFh4Y18w3LkwffADnA0AkcdQpT+vHjR2+sAaKUBXLVPH9bxL1oK3oDgw4qLjWpjMUlWW66CslA5vH9qQTlrc6O39wCHFGzdkF0crSfx1t0I7+PUFzHyhE2t9XUK2U+5hsY9UANKHkbszbwKExQyxtL9L5ZXO0ShRccy+tFVq+zkCBbZ3KFn4CNRy2Q9vUEgZnQr0oDGDZyQQEVK9+AJvexGdfmFeSnth4MFTPWseqSj9sG1n+YBhvpim1vngS9Cb0Ng1YFDSx3SOHoRjsPIm43kbkI43hp4lBvQXMUGERUwvnu7QRCkglnx4uk6sxgt7GgsB6gWiLYbIqKOpSWWOsZFxgUd/YBw12ZCtS0Sdoo8hV5bGzoz2qzrpK5OZWRprBq0vl8BZBw5xCA2sq6Y468EqBTutLa66RVGZeVfB5+vzPyCDUJpguZuGSCqrV2H3zFG9w108ohPBNu5F9O13TeC6tRuEWMnO95neDlwH1ZIqWsqm8WTpPuC1I9XYh9rPxQh+m6iY8GxuPqfi1SqsD14njilTld3t89OTOA7qntvTH9b8KlOoVLHz1q5f5aXT0kScVkVkTOd3phSKJxvZ72qBrAReLocU1jBUhjydGcxeqJGa9ioJqlbG6wq4PQpu3YdL3vkSeBPk9S/Fy0kdKSfBgAMMYhZPnkLIPAlacEZ4CPQy+yD
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(23010399003)(56012099006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dDFrdWU0VittTW1YVXRaRmQzRjI0Y0NqNDE4bXF2bHFhRWVKbXNwSUc5eHIr?=
 =?utf-8?B?cDM5c3l3eW1NcXgzZTJxenJmcTA2OGVVS2J3R0c1YjRnVWpoQ3VUSkhuUFA2?=
 =?utf-8?B?dGdXc05aUVdZZEROWWRKeTU2eFl1ekVNWi9VVXRha1doTDBKbEE5bVhvSlRv?=
 =?utf-8?B?bGhBd1ZKSFUyYzMveEhtMDB3Y09sTkRqRjR0WjA1UzFvMzljQVBqS0c5NlBY?=
 =?utf-8?B?R2V0V1Y0SllQWnEvNEdSMUY0eTVXSHVGSkcxVFhMYjNubHl2QlRnUjFIOTJ5?=
 =?utf-8?B?NURaNkkydXRJNXdHekswZm4zM1grczhuN0ZyZEVlZkdmclBDMFJEdUtvd0pJ?=
 =?utf-8?B?MnUvdW5aZTNENHJaN0Nna3BoN0hIZHdNdkRJbS9XbDJ3ZXVVTTJFTHlGOWkx?=
 =?utf-8?B?eUJIdWdzbzlCdVNwUXBFZndWYitFV1FOZzhwdFlOVnZkTHBMTHVWVm1SRGo0?=
 =?utf-8?B?aHNVMFJLRzNtNVg4Wk5tbGNta1IyWmxrY0g0STkzZ1Rsek9wS3pqSXhxQWZN?=
 =?utf-8?B?cWgxS3JoTUp2OUJqWFJxTEhtWlZJUCtMREFEaFZScXpaWkhBWHpveDByY3pl?=
 =?utf-8?B?TGE1VytRQ0xpV0F5Z0JKR0szcGZJVXdxaWUrMmhaUmpVQ3FrWXdwZktPL28r?=
 =?utf-8?B?by9MckJSR0YzSnF4R2V6ejJOTXp3cW5CcXJoY1ZYd3RyTmhGaFpoZVpML2wr?=
 =?utf-8?B?eDFTSFFoYWd1TkU0elNYd1FiWWg3YUc1NlVRYk90bng4Z2lrUnhBenY3R2pl?=
 =?utf-8?B?dC9reEI5NWJtZmJvTGl1Ykg5UmtNUmwrT3NxNjVWL0hjMWJxVFNja1lEUGRa?=
 =?utf-8?B?bitGK05MbjBQYk9vRCt5UldkM0ZRQUpGcUI1VDR2M0tXMGRveE83cXNwNUNY?=
 =?utf-8?B?VjNzNWFvUTIyb3BaTjJGSVExTTVJMngzaERSa1RPS3BxWXVxdUh5aTkwM3hp?=
 =?utf-8?B?dGd4dW5Razl4NWpwd3Vma2lBbm9RNmFZMnhyMG5iTG5WRG1OMDR1bDc2L0V1?=
 =?utf-8?B?bHZwUGIvU0ZmN1FLTE9QNXluc054dTVybFA0ZlJ5eUpUeUh0VEMxT200V0Ri?=
 =?utf-8?B?aytKeHhJaGZIQnhHdXhNVzdSUFJRZ0JUUlFta1k5VE1ScWVRZ3FIN1BFSVVj?=
 =?utf-8?B?SjB3elF6QzZKS1FUNHdWRG5KK20zMkU0MEtRVk15cVBQeGJxdkxOcHlWTkJy?=
 =?utf-8?B?aFVTYWJXQlFxdGZDVXh5MVdXajJ1MXVnS0M5TVRrY2kwK0hRYlozakc4ZXNx?=
 =?utf-8?B?TUdrVnhuVnIzdlpsWHVsd3psd1RkVnJBQmZWY3FueXRrVVRvWFdVdDlrRUZF?=
 =?utf-8?B?MUNhR0NwSDdUbThnZWFDb00xanlTeFlpaytBTlFxU2h1Szl0eGNCVjhGVmJV?=
 =?utf-8?B?SmdZMmYwRG9pS09OaFFURHVzdVduM0lvWldraFpkZHlQbmQyQTllaDdZZWl6?=
 =?utf-8?B?aFhLYTVtQVZzcGltVENxTGdhZ2F5em1SblpOZ1pybUNmV3FVcW9yMm9pRnhF?=
 =?utf-8?B?djFCbllkU3JFUHVCRXdGTXdGRSszeVJkb2dEaTdRdjgzSzZhcnNLRS9ucGFM?=
 =?utf-8?B?ek96M0V1MEwyMDZYWitsVllTL3dnZlNTb01IQWU2aDRPUEdFM3VJVHIyeWtR?=
 =?utf-8?B?R0FSZXN3ZE5qeEtLV2oyTmNoaXhtTUMybWtNVGIwYkFtY01Ld3JBNUdrWlIx?=
 =?utf-8?B?cUxZTEh3OFlPb3phRzlmUXk0Mk4vYldLZmk5Tm5DTTl3Y1JoOEFGNERNNlJC?=
 =?utf-8?B?NDhRQ1N2d2lCTWNQaXI3T2htVW1aQjhOckFTSWZjN2VjNzJzWFQxdGRZaUNN?=
 =?utf-8?B?T3p6OG00S21NUit6QUVaUHNzb1VTZC9ueGVUY3o4MTJPY3RyOTlNLzl1ekxN?=
 =?utf-8?B?UDRSby85SXVzQ1FxSS9MV2FNQnFvTDcwOWN2TTFpVWdEUGoyQjYxWitMN2F1?=
 =?utf-8?B?S1ltU0ZMYytZL01PcXVNaUh0eXJvT3dkaFlmdEVxVFAvVWsvT3hhUHdrU2M0?=
 =?utf-8?B?T05FTHk0dTNRUmJsbUxGZ21JSURaa1h5VlgrcVRrVDJ1TmF5VWpVeStxSUox?=
 =?utf-8?B?cVEzVVdBVVZyZ1N4TWFvMEw4MTBBc2M1dzUzb2sramh6aEVHbk9nTHk1ampn?=
 =?utf-8?B?YzlIYm9INzZ3L2NwdDdmTzRuYU93c2hPQTJZQ2c4elI0YzBpSEUyaTZQRmlr?=
 =?utf-8?B?elcyN0dTN2ZNWEZDVDBiNnp2MEc2dkJiSm9SaGwzU1VzdlNYbWdkTVpyOUQw?=
 =?utf-8?B?YVE2amlEOS9OaTh4Q0pocHZBZjczRGdjaGU4Q1o1d3FaeW9JSjF0dGhTSzly?=
 =?utf-8?B?dmIvZjdkVWl1bWxaVGVHWE9YSzNpNU9jOVgvOTFBOTdiaWlqaTBSUUlLNkV0?=
 =?utf-8?Q?+buJ7JdC/BgY4l88=3D?=
X-Exchange-RoutingPolicyChecked: P9TheWwwQRcN1EgfknILbLpwPibOjiB6bELrjZjZ79+jLKlc8FdegQerzIdHLcmb39hdoicpSTT+8T+OGlNmEt4MDNhM6s3ofGbcTsc2svj5RJMc6b1Sw+21a+X2R8BLuPHgYCvS6Uy/SHrRyeFL3kwIh+EX7+QXVNa2xXSAvHkgFkppm98coKyZSYSEbEEmEqq0pzpkK7BOpIkKGa706qNM+OQs/a1xXLc8dGuMSbvd67OBJElDM9VkqPvkGkrlGKF3JfAr3EP/kdw4o8xaSXN3umY+mvGb8aK35Kp2Ekob/fdxsXzht3Jy67wnH6Wxmcri2JMXtpOuPQxSeuGq7A==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef3ac058-466b-4ae1-d7d6-08decc5daa4f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 10:46:19.6300 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lLGY8DPLDZRYrEpXOO0Q7Vr+dlYFTrYmcq1eLIbhcjLNT//+mEJE3Cr0153CFmuZ9JApsWs/3lqnk1YhZ4qXUkMc5BuXe45AF97rf+ZvqDo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB8374
X-Proofpoint-ORIG-GUID: TJGas4PeZRRHgUmV4rd6tILvImOdg9Dy
X-Proofpoint-GUID: TJGas4PeZRRHgUmV4rd6tILvImOdg9Dy
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE3MDEwMiBTYWx0ZWRfX8TcR0Mfitdis
 fmUjxJ63vbSA/2BD7IM5akAZXE/WYkHtPyfsfAeFdTWsZLQXHOmXZOPOf5x+P9CatgAyEuuBOcz
 eO54inmKOKIKEtcOIpy6+j6NdZx16ok=
X-Authority-Analysis: v=2.4 cv=VILtWdPX c=1 sm=1 tr=0 ts=6a327afc cx=c_pps
 a=Gq0v4fqhBDE/9EfA5tRQ9A==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=Ap8k9tRZuQ82DLYWQqG7:22
 a=ujj8tIfytTr50BV0wfMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE3MDEwMiBTYWx0ZWRfX/ZH/Mq5RCTSS
 NaC7msI2DT14bLHtyLIIVv97iOwYXRtjOpicUe6fKHPjTBq39gFMR/K8aUztvYaCFjXPzoGN2bG
 LqNIY+GZNMXikbVVFNEkiqu3ZyjJS4IGIa0lqI1XgKHMXh5bzT07PjYwEAJpj04mIf4tvD5iO09
 hNT8IZsJalE1fV2IwgkVuy4pTRmXW4k2d6hZeaLljWCYVvHTKaASuYEkDV+6jKef6WSVUCl4/wv
 1sd1pf90ukZTcmyjLxxhB7BawEdzRRhmkkT0Wp73cfmBG+ykOvNBDu8bdvD7J5mvyGp+pu5S2uG
 FFTXdzx6jdOcurqVyEyfUSRp1nU5NkK5G5ak9VU+imOESfSqMMKQRyT8AnYLI4JlVvxnfGj6TnL
 dcGSY9wvidyQd0NRDiA/0YnX/xgumBdYGOgxGIqOU3OgTQKij7YziYOfFmqij56FbL6SPG1a2R8
 tJy4IuvhD05rBO9GrgA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_01,2026-06-16_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

On 16/06/2026 17:36, Daniel P. Berrangé wrote:

>> Isn't this the same as the existing qemu_allocate_irq() ?
> 
> Doh, I missed the very surprising naming pattern where "qemu_irq" is a
> typedef of 'struct IRQState *'.
> 
>> (I have over the past few years occasionally been trying to get rid
>> of existing uses of qemu_allocate_irq() and its cousin
>> qemu_allocate_irqs(), because they are persistent sources of memory
>> leaks. The function returns a pointer that the caller has to deal
>> with and remember to free, whereas using e.g. qdev_init_gpio_*()
>> makes the new irq objects children of the device they belong to,
>> so they're automatically freed when the device is destroyed.
>> qemu_init_irq_child() similarly.)
> 
> If we think it is best practice to mandate passing in a parent
> object so that every IRQ  is gauranteed to be owned by the QOM
> tree, that's fine with me.

Yes, this feels like the right way forward to me.


ATB,

Mark.


