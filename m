Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F0E3E81A40
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 16:17:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vs1H1-0004TV-DW; Mon, 16 Feb 2026 11:16:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ross.lagerwall@citrix.com>)
 id 1vs0iY-0003uq-HG
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 10:40:58 -0500
Received: from mail-centralusazon11010050.outbound.protection.outlook.com
 ([52.101.61.50] helo=DM1PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ross.lagerwall@citrix.com>)
 id 1vs0iU-00008p-48
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 10:40:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZQvoEdwbcMVAgTEbuPgI6wxRDRn8TTBpJoEOnnR5H7Pt+ooI6sd+I93E9SGxzTEC6Vjg78Vg7zm3iOILMitdtE2/t/e4McSUdbzXc5sTwW6BoIKKPbxtX9jWA5oABwqK9ZWqoIu9mT5KTfDdrTaLoeGMvg/mNkP1tFWOFxtzcIZJvH68bsFIiO0F+V1haNSIPKMGZiYvQYwCgTZQUAu6m6iCiECQtvrzGjqjENaB0BpULp80mGeERqDK6cvO5x7rWp7tLVEhxXjg/zCTEZXfp5J8gb3A4UOiGfSnpOSpNEnA13Ma6/G2R7XPkEKjGVdx33BXTqix6gOiNWY06rhv2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vs5cIUPWYKztTnAi9VooG6CwTy8tVAnx/+bVqGPjFhs=;
 b=UvilZ69SVcn08eDqyaxQuM8KSKyOU0/uQeUTDal3jiMLk+eqzGXglEORVeVHBQ9fH0frxrtIzv4OrKucIg3MaCic8NjvhI0T7DfumEgcETmnbT0dGtIky0dam6kEveuvEeRqJUzkg8gGH52lf1jXTpWM00VlexAuJDxOzvRg1RGtA3GvJ9paNQlMOhSLlE9sXSWQJm0TZAS0a+aeRVhbil41P/Q10Z9X0sR25x3I3KaGv9KhGLWRDNujWaFcRn6teHauUVdYSYwhCEWaH81nO5N7Chnx5i883M0dQ7BW/fCLSkKZejx3eNzEWSy2QDGfGT5fNwDloO3WKhzah6nZbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=citrix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vs5cIUPWYKztTnAi9VooG6CwTy8tVAnx/+bVqGPjFhs=;
 b=VWNLp8wOjvOPVZ+dmJ9FoGOr0dC65RGMRbdCxxD00CPiP741DMOWuH56rWSPFSYBHqoPmFEIeucWIjSXojJ8AsyCErtHusS59Vu49QSbeHdE2RMSrYAMtM+LEsghLEuEqhd5py7NlJ3pAcTDFzAiMZCAbDvjX+VnBTACGSlT8Hg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
Received: from CH8PR03MB8274.namprd03.prod.outlook.com (2603:10b6:610:2ba::5)
 by PH0PR03MB6480.namprd03.prod.outlook.com (2603:10b6:510:b0::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Mon, 16 Feb
 2026 15:35:48 +0000
Received: from CH8PR03MB8274.namprd03.prod.outlook.com
 ([fe80::ebe2:32c1:d2be:a096]) by CH8PR03MB8274.namprd03.prod.outlook.com
 ([fe80::ebe2:32c1:d2be:a096%6]) with mapi id 15.20.9611.013; Mon, 16 Feb 2026
 15:35:48 +0000
Message-ID: <7fa61eb0-9d7e-4a2f-b54f-df310f859641@citrix.com>
Date: Mon, 16 Feb 2026 15:34:44 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] xen-hvm: Emit RTC_CHANGE upon TIMEOFFSET ioreq
To: Anthony PERARD <anthony@xenproject.org>
Cc: qemu-devel@nongnu.org, Stefano Stabellini <sstabellini@kernel.org>,
 Paul Durrant <paul@xen.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
References: <20260108135406.1879210-1-ross.lagerwall@citrix.com>
 <aZMwlMwYufj6LCrU@l14>
Content-Language: en-US
From: Ross Lagerwall <ross.lagerwall@citrix.com>
In-Reply-To: <aZMwlMwYufj6LCrU@l14>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0101.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:191::16) To CH8PR03MB8274.namprd03.prod.outlook.com
 (2603:10b6:610:2ba::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH8PR03MB8274:EE_|PH0PR03MB6480:EE_
X-MS-Office365-Filtering-Correlation-Id: ccac422d-3708-46f5-3360-08de6d710f36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QXcyWVY5VmRaeU5NTkZMOVBGNktiMlRjamU1RGdIWFRqQ3ZFU1Z0cHpJM3ll?=
 =?utf-8?B?S0lYUURIQldnc0U0YXJHVXRDMUt5T2FqdG8wVzJqRHJkeEttUnc4dDU3Vzd3?=
 =?utf-8?B?RS85aDZBQktUTEZUOXpXcENaQnRreE1KMUIwRGx5OEZKMkVwVzh5UDlGZnJD?=
 =?utf-8?B?bzR5UW92WFRYOXZLd3dYd3IzczZoTVViT3FoRDQ3akk4QUtqZGptaURzY0p1?=
 =?utf-8?B?VEtnamM5NW9PazZld1JpY2c0Ri83S3Ztc29qOHVLdjl5Uk5nSDJ6SlczcEJO?=
 =?utf-8?B?WmJaTjdiUHo0NEpjZjdYaTV3UGl3L2ppeFFrWE1yQXM5SVAxRlRWNTdxTVd3?=
 =?utf-8?B?cGcwNlpVcWFXQWFIalhuVVdadEVmMkFBV29sem9UUDREU25ic05PSGFybS8x?=
 =?utf-8?B?WXJ6RzFQOUgwemxzQXRMS1ZzT2krdmJLeDgrd1RobnJBSlQzWEYyb0FPMlU5?=
 =?utf-8?B?cVR0L05qcXY0Ykk3aUdOTjFtVXNDcVFHT3ZicXRvd0JGM1djak1XZXl2RVZM?=
 =?utf-8?B?MWJ3SkRtWStDM3JLV1RZNkxDMGJPVzBwTkNZSU9KTEZGNWNQVTNUUlllOVhQ?=
 =?utf-8?B?OWlVUXo2ajdOanJFTzI3aGdBd0R6RlVLZjBPWTdHVGYxV1g4WmNZTnI5cEU5?=
 =?utf-8?B?ME9jdHZvRjMrN1A2OVlzaDJNNnZYWFJYK1owUXRqMURsckhOSitnaStPeDdU?=
 =?utf-8?B?dHFxVGhuNTg0NmpFUmQ0TVM2L000azBUa3dlZ1U4cERGZE5KVmptMmFQYUpx?=
 =?utf-8?B?ZUEyWGhZKzMySkx2cjV2bHJHazJZR0FoNWVkdlREMThrU0trZHNEejdOUzNF?=
 =?utf-8?B?alUzaU0xUjE5MUVUODBrYmVIbzNQNVlPMzdteG5CdG51ZVo1Ujhuc2dzWUl0?=
 =?utf-8?B?Ykh4YW1yZ1pCK0dhSTNMTnpWUDhFTU9iN0QyNG1iaVJVem9IMjhTYUhNcnJj?=
 =?utf-8?B?Q2VUL0FWYS9qdTZ3VkxXVUtjNTRzQ3FoNW85SEQweGZCUG4zR05ySE5TWUxG?=
 =?utf-8?B?ZE1mZ1loYzV6OEphVXp4WVVnQXZ6RXN2Y3c0UGd2NThPV1loZ1h5RmRqd3Vv?=
 =?utf-8?B?aW1ZZWFUKzd0bEtXN0h1QmQ0NG9XUU9NRzRSSm1XdE5taU11RzZMWE1zTHVV?=
 =?utf-8?B?ZVQxVytVS1FQbExJN1pFS0twbEZRbjFJVkVnWEh1d1VMTXRvazVCZUxOQ1VT?=
 =?utf-8?B?bWpPZkFOa0xTdHFJaFA4cVp4TkZiYzNpQUc3Qm54Rm82Nm16SGFNS3doTUtJ?=
 =?utf-8?B?OGNScjNDTlpkRkg2WjV6Q1hUZm10YWhUVTVneG85TWtaTGF6TUl4MHFvdThB?=
 =?utf-8?B?ZXVBZkw3T3R0c3VKNFlhUW5lQlZMT1RZVWlxMkRLSkdGK1ZNNnNvV3RMQ1RZ?=
 =?utf-8?B?RUhUUHNRVFFjWW1pM3lna0tpK1FnQnBxd0tsSDF3dTdmUFN4aUlJbHBpZ3hW?=
 =?utf-8?B?VmVvVytoRG80Q3BldnFoZ1Bja0hUNW9zZVk1TWpDanRuNnlHMGtHNkJmRGhy?=
 =?utf-8?B?Rzh4eVJBYU13a1BueFRrYmlHdmRacWlKNDFYa2RQeS9zc3FTQ2tOUHQ2RlB3?=
 =?utf-8?B?WmJ5UjkxUmQrdGhSOUJaa3VFemRFdmh0UWhCWitFTTlob0tnR2RRak1uVyt4?=
 =?utf-8?B?eHQ5d0FiS1BMWDdpM3pVUkJGRVkraHhpb2xkNHdUK25uQkt2RDBYeVFIaVdv?=
 =?utf-8?B?bktvbmRKNkVqU2xvcElDTEcwaWg1UmhMVWdGVC9aTWNGcEVxcjN6TE56QTFB?=
 =?utf-8?B?SjF6TkplSkVzWVR2RlEreWkvb0JDQk5mNkxkTHl3d1lva01KMzlxcmtmNzM5?=
 =?utf-8?B?NFVuS0I3ZUYzRGErdnFTV05lNFBIZFdiZmkxUG1SNDk3SnZjWDc2YXg5TEY3?=
 =?utf-8?B?Q3JNV2RqRExKdk03OGhvVG5VMkQwSWZhTFd0TGhzK2lmRDVYSEttU3VadVVz?=
 =?utf-8?B?NmlSOU1YN3ZDclE0NmJ0TXFKb0xUYUhxMXA2aEVvajRjbWY5Qk5WNnhSdTZJ?=
 =?utf-8?B?RHNRSUF0alVqbnRXNTMybXJFbW81TWlqdHIrSHhYNGRPdGZJQWpYM2R2dWE1?=
 =?utf-8?B?ZVN2cEhLMnh5b0tiQjV1V1FDZU16UGljeHB2RkdBek82YlAxNzQ3Wk5BWTNu?=
 =?utf-8?Q?3hCo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH8PR03MB8274.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NFFLendQNGRuRDBpdmpPR2lRdW00UjJjTlJDUzJaWXpXUzgzYXNHQ3YwK0tU?=
 =?utf-8?B?dkpESFU5ODBmSjNZWGRYL0cwWUh2U0R2bm1rT2Z4Zy9BSEdMbUJ0eWVqQ2Qv?=
 =?utf-8?B?bFJTYTIxU1I1Nnp4Z2s0ZTBhOEh0K0JGRW5wMlpKK3g2REVoY3JaZ3Vqc01P?=
 =?utf-8?B?R2tkL2d1bXBvVTg2WVVkT1dJTXBMMW9PVndkd216SmRPTDdFbTcwd1diZytF?=
 =?utf-8?B?QmFtdUlXTytjTEF3aXNjelpKMnBSK2hFVTBXT1V6TjMwUDV0TGNPSXdoWWxX?=
 =?utf-8?B?MTdod29pbXRIMCsrMGtPV1pVNm9hUmJwek5EU0tMMzN1dlRvczcwRlEvbnlH?=
 =?utf-8?B?N1hnbHBpVEVYZWRod0dZRisvT283YVdRdy9DbytPa3BqL0ZkNTEyWG5RVjk2?=
 =?utf-8?B?SFFMZWRoTEx3MVRpclhJNXRsUVRMVVFnTklnMyt0UEpIRzRZRE5hM2hPT2ZU?=
 =?utf-8?B?MnE4OWpWZFYzMFh1N21QSW1pdTU2RUJUdUNHL1VxdG51YUgrcU45bitxVEVK?=
 =?utf-8?B?aXU0anZ2bW9DZ1hwSVZiYkRxUkF6T255SWJ4N09nZkVUV1FFMGl3QUltKzA4?=
 =?utf-8?B?bDQ2Y1BpMm12UWkyQ0Z6c3VYY3U3ZXdHaXZFOU5YZENVc09rdDBHUExIWmJ2?=
 =?utf-8?B?MGZ0YkpEWlMvOUZsWGRsQXN6eUxEM2hCazhIbkdjSEkrMHpzcWRra0lLdFYr?=
 =?utf-8?B?YXJqeUI2ZVZuWDNTR1FtNUZSbnk0Z2dMWjAxdkNVUzVkRjB1VFplaVgwb3NF?=
 =?utf-8?B?N2FEeEs1YjJTMzlQN3ROZTlWMExia2JHWGtkdmRsOUVnK1FpWDYzcXdHUWF2?=
 =?utf-8?B?eW5VVG5lUDFKOWdwUmtHMm1GRGhZQU5mK0U0d01pYys5akxsMkJXWnloSU9u?=
 =?utf-8?B?MWdUY1ViNThkNUZNSGxQaCt1WVhNOFJxNy9PRWYreXlNTzhHR25TNDVSdDdt?=
 =?utf-8?B?OFJZNkhWUlpxbmhQNHpaU1JaS1RZT0c0OWJOVFJWd2l0VlVBbWhZeHc0azhZ?=
 =?utf-8?B?S1FTQ0Y4dVk0WU0yRkZPNVo5T1pjNVJMUWFwdEtNaUxvbXp3YjZnQUtXdXJN?=
 =?utf-8?B?S2NaQUVHclhob293ZHJkR0tkdGZRRThjbUFBY1FyL1NhNHQ5R1BRSTdWcVY3?=
 =?utf-8?B?R21FY2RaRUtqaThuUTM4VEkrekxVN3NtQ0tFUGt6djAybE05MFQ4Nlc0Tm9u?=
 =?utf-8?B?ak0rcm9NRm5VN2ZxQXFybWFhNldzUVdLMG1sK2VJcHpsSlJ6c1NMR3YzdGcz?=
 =?utf-8?B?TlUwZkFhUWl3QUdFb3lDOUFzTnpnOTI4WkNEbXplVmp1MWh3YTdYQ1ltalY2?=
 =?utf-8?B?WTlQdE9nK2RZdFp4TlNablY2c1E1dHdrVG1hRkhQejhiN0VQT0hjY2c2Z3pZ?=
 =?utf-8?B?R1kvQVRHcGdzakVsbGszdG1TY3ZLeENEdEVpM0hPWmhEcDkvR01tWWFvNTUz?=
 =?utf-8?B?NUxGcHJYVlozcSs4a1Z0OU5RZTF0QTVlbUFaVkh3bHM2b1JuNXVmbXE2UFZr?=
 =?utf-8?B?eVZ1b2grajF6SnlOSzdOdjhTdkdRTDcwSUIreTNxUC9oaG1QNjh5TFZwWUh5?=
 =?utf-8?B?QXlsVFF4NDJMRGRSSzdhYXFpbUJ5SEZGU1o1d0lLbTh0OXB0LytOc2dQR1Br?=
 =?utf-8?B?cTg1c2hOTGxLczVkcHByR0ZtUCtkUHJoazNiY3FsZDRCU2JHSGJqWTB4bWtO?=
 =?utf-8?B?bE5tUFhCd0NSbUkwdXo0UXpZUU9mdlY1TUJqRng2N2JIbkJJdzZ0RmRxYkRW?=
 =?utf-8?B?MTdUYldQVjVhM3ZxVHR0dU5mTnRneDV0ckc0RytKYW41d3JobW96UUFDMG41?=
 =?utf-8?B?OVp3dW4xOHRyM1JJUEh3VmVEajFwWWNrOVRLcC9rVlRQNXNoVlJ5KzdrTWx6?=
 =?utf-8?B?NVdXanUyRFBla1FKS01XeTVMWkQ5Q25qNnZJMWhXNms2bi8xT3BIelc0clI1?=
 =?utf-8?B?UllBZXJOUnhoMG5EQzEveHhHSmo5RGVxZEl4azQyTGlTV0VoOGg1U2hCTmww?=
 =?utf-8?B?LytFbGIwd2pPOTRtVzNCandSa3QzVytJZXZtbXU1d3dLV09XaDdnbWVWQnpM?=
 =?utf-8?B?UUh0Y2EzOC9HWmR4SllWWkU5QWZUQ3BqMjVjckdmbFBzT2pKRjF1bUxVWXhP?=
 =?utf-8?B?dGVPL3JlRVFDRVkvNnJIT2Iya3dGeTlXK2NJSGtXTGpEUWc5MFNBVnBlSDY1?=
 =?utf-8?B?a2phdVJiajVud2ZBU0twSWczWXQ1eE9zOWNwQ014cEx3c0RpWDlkZXhyb2hw?=
 =?utf-8?B?VkFZQ1FRajQ3cUtEMDhTMUk0MGw5M0VxTUVRSGY5c29JQkpJSUdlcU52K2g5?=
 =?utf-8?B?UHZhZ2xhZEVZNFVLMnRDSUl0T3RHd0JnRENRSlVPclF3d3RRODlIbjhpNU5E?=
 =?utf-8?Q?bpAfc8A4nK9xwRmQ=3D?=
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccac422d-3708-46f5-3360-08de6d710f36
X-MS-Exchange-CrossTenant-AuthSource: CH8PR03MB8274.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2026 15:35:48.8590 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jioxsT1L/cD/pk+sGSDZmaNwT2aDq3fQIeWwBAgZQv/TP4BSBwyzcAvvPvgUw4XzMQ0wTJiUkMbDhIXixodwHG2QAw4Ug93cABk4h1kR+3U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB6480
Received-SPF: pass client-ip=52.101.61.50;
 envelope-from=ross.lagerwall@citrix.com;
 helo=DM1PR04CU001.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_NONE=0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 16 Feb 2026 11:16:32 -0500
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

On 2/16/26 2:58 PM, Anthony PERARD wrote:
> On Thu, Jan 08, 2026 at 01:54:06PM +0000, Ross Lagerwall wrote:
>> When the guest writes to the RTC, the write is intercepted and emulated
>> by Xen and the time difference is broadcasted as a TIMEOFFSET ioreq.
>> Emit an RTC_CHANGE QMP event when this happens rather than ignoring it
>> so that something can make use of the information (e.g. the toolstack
>> can persist it between VM starts).
>>
>> Signed-off-by: Ross Lagerwall <ross.lagerwall@citrix.com>
>> ---
>>   hw/xen/xen-hvm-common.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/hw/xen/xen-hvm-common.c b/hw/xen/xen-hvm-common.c
>> index 59c73dfaeb59..9b539f5c5c56 100644
>> --- a/hw/xen/xen-hvm-common.c
>> +++ b/hw/xen/xen-hvm-common.c
>> @@ -471,6 +472,7 @@ static void handle_ioreq(XenIOState *state, ioreq_t *req)
>>               cpu_ioreq_move(req);
>>               break;
>>           case IOREQ_TYPE_TIMEOFFSET:
>> +            qapi_event_send_rtc_change((int64_t)req->data, NULL);
> 
> Would you be fine to replace `NULL` by `""`? I've notice a TODO in
> visit_type_str() at
> https://gitlab.com/qemu-project/qemu/-/blob/master/qapi/qapi-visit-core.c#L344
> which is one of the function doing something with that parameter.
> 
> With that, which I can do on commit: Acked-by: Anthony PERARD <anthony.perard@vates.tech>
> 

Sure, fine with me.

Thanks,
Ross

