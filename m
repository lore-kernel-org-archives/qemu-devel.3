Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29E08EF8FEF
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 14:36:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxnKz-0003UH-9F; Wed, 04 Mar 2026 09:36:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vxnKu-0003Sr-08
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 09:36:28 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vxnKr-0002Zw-TB
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 09:36:27 -0500
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 624C3I933249100; Wed, 4 Mar 2026 06:36:21 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=KcKZPBDPoeOCetOCHSC1G1MjAluNVxNjRbLL6Cs3/
 mA=; b=hdH38cdHlAqpp43txGWvUdf/GjDjmQog+kX/nOsRycEEM+nJla2sXory/
 1JjNJis+ZYJ0/4h15Uxo21ZJ7MV1vGLilr15SI6eb8+WJ+jeJJiY67LDViAI2fFj
 TE3+kxVVH3bYMcF3qu1czmvekS5BSuYtTBrcwhP/pPgDDRaMnYIjDgQuW6rQq3Ee
 b9KOV14aPAvnfLj5t8Rk/HEd+DholwNa8ZLAbhKk9LzzUr3nvF3ePPzcyMEZgunq
 EwEe/TN6HYzT8HG4ZWRUBSKRyqEYMcaQ0HT+726HJ4fSwocgQdmKexjQ/qb5/yI7
 rhp8yX711y2igPtRAV6oEChLZSq8Q==
Received: from sj2pr03cu001.outbound.protection.outlook.com
 (mail-westusazon11022086.outbound.protection.outlook.com [52.101.43.86])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4cpmd0rbmq-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 04 Mar 2026 06:36:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n2iuvDIvKyXREykHSqYJcHmrVNlONQD1yiJQTMVZHe2qjY8gaQPRBgLLdTCrK9gMI2fef3mGuG27tBPNJCIrgFjXPAaSdcTroJFKYBZ2Q8IPOAjK4IXJoIR9k0k8tufSkpSQLZnR6ve4QhB4/IKgjl188ykjX+hFBeXirzvtp7jJ6BkSDJwaZFeJxw7JmSPw+4PCvxs5J77Iq70Zqo/5gDipyFPc6rRww2q9A2XjlNpWySWuQbVGenBRS1KIG1sSU7O4z7yyNI7H8RN/k3jM2giPc2i7cZU0PimMCdwmJTN34/4kIISnJCisXkI17AuFHQ2Vigrw/aqGPFU2zuXcqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KcKZPBDPoeOCetOCHSC1G1MjAluNVxNjRbLL6Cs3/mA=;
 b=NTpMICz+0LBc/DtVJ9AAQbiwXDJeiaXXnIVG82++zlX5XnStehCVhW1d2Z17zD7MxKHzwKYvuHZviuzYXniUATflFxAzQKQc9ViFaIQ/RM7H2+fHGG+/EHRgH4BISegWcrTUynAkduTssvD3Y8syvNB3R0Vi02TIiGIsNGZms5DeH5GiUB7qNdEWpP1gPNOGVUmbYXRX3JC3r1BtzY5RA8fc1M4bHsPKdf4SNgSgiV8OLwGEAJ76Ly/dOOpXD7JwoJ680X9U7Tu4SXj47Bx3dytY+J14EGDNAcUtpQngSsM7JqWE0dRX7Ugt4BnlXqHSP7W29LEyZdPsY+LDpKxzmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KcKZPBDPoeOCetOCHSC1G1MjAluNVxNjRbLL6Cs3/mA=;
 b=xxXDipBL7lMX5jkFLYNrfKmQRSPqJjRQOV3cTAejJzacrtTl2bHfTEmMwGteYDVEKk7aYZXclBCJLhLtJsaIiPpyBr8xW/vpE3Jms5ooYGH6CEIYianA48cskCXEDKkgjqPWJijJQ/q+Ug5DyYcjEZrWlWZ4mxQHnLkoETcuQHMZQHvlgIDByGZPLeyFSZaRIzGC9FOTQNG9yGbwWW7uPSfsu8CdXwEEIpdhPliDqouAFAx4iUJRxHo41uUG47a29YId5FGKchpYPzHxKDYPiYZHcRmAcNePzX8GOOuKgrQxs//S6Q5h5sTOTdME0oGrKgirRnoPGlKF+zBJ/s9jCA==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by DM6PR02MB7036.namprd02.prod.outlook.com (2603:10b6:5:25c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.17; Wed, 4 Mar
 2026 14:36:18 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%4]) with mapi id 15.20.9678.016; Wed, 4 Mar 2026
 14:36:18 +0000
Message-ID: <c578ab0a-d8b8-4474-8d5b-538a26a85c85@nutanix.com>
Date: Wed, 4 Mar 2026 14:36:14 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] hw/char/serial-isa.c: declare IRQ as shared in ACPI
 IRQ descriptor
To: Igor Mammedov <imammedo@redhat.com>
Cc: mst@redhat.com, anisinha@redhat.com, pbonzini@redhat.com,
 marcandre.lureau@redhat.com, marcel.apfelbaum@gmail.com,
 qemu-devel@nongnu.org
References: <20260227134611.1229390-1-mark.caveayland@nutanix.com>
 <20260227134611.1229390-5-mark.caveayland@nutanix.com>
 <20260304122251.217cd93b@imammedo>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <20260304122251.217cd93b@imammedo>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH3P221CA0021.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:1e7::10) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|DM6PR02MB7036:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b93ab07-2538-4d3d-d143-08de79fb658d
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: WTocAhUWMqeLKe8Np/Tw46GypkVHU1KWUgCvswSmqik3XvkvrzrAt9KVeFbGhAe4zK7PyoNwKjUIUKiEC65mbz09zhXOYt8GnqIh9eA8jVGw0QRhCXlQZEU1cxTDGdi70NGa5SnnZCy2eSMz1SCB34sA1XlVTyVIIh/37rKK23aC/HHnI0hKOt67Iax2FzTNOAsZvEOAgGtVtqBvv8qNCgbVTqYwxqF3jbM9etvA1FPeMBdfxrNMYqFtLklg4jGgQCvJkLsj1AgjtckvqFJNPPfwbP33OGvfu0LHXK/QhhFzEAB/rWh4t25Jwvci2Cg7L7yxlW/e2JPAqW8UQaP5k5p10LrQ0qBtV4Cj9m19Ghc0vJFLQJmOxr1jEDHAaueuWdXmXlr6nQmF6b+1+1Rm4yQpkXkd0ovj4Sg71Z0u9NfKys0FwPOGSn3WG4N+WN4GB2+7FrloFmWplpROcQAy0U2d3FVnbeD02P5ZhaSQRwHTbrnw9PB1m+XJMNKSF4o4JKOYXFYDYqlnbsfO9Sf0iBEfPrBeey/ZHQhhBbrY24m9jkmuUiPcxGopicLcALxQXI6BnVShGVWBgK8G50NNdDJirPpoJmBc0CIDBvU8m6UZW1sttR/Tl6g4DB6CbtoYB1DquAdsiEVDHAc9eIvw89pb7cvOuPNQTRD1f0ws8HD9TsZ54X+6d2ZLrUnllwm7dw351W67znXRzfJFZs50I5a9XiRxzeBxPm+oS+JwW30=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QzM0dEx5VW5PdmY3RmRGUGt1a2w4UEc5T0pyT3pUY3lEekhEUGN6WCtuMnpG?=
 =?utf-8?B?UTFZY0xkNHJqTWlzVzNsUzdYeTdhVEh5ZVBINzFNUzYxMittL285SnFhRWhl?=
 =?utf-8?B?V2tNYlA1bjVlNUdWM3AzL1VmVnh1UCsvdG9WcGpLMTd5eTdYeEpnc1BVbzRS?=
 =?utf-8?B?c3lsYWNDZFZ5R2VZbTc0K0FvcGRKcDVMdlZPWUc2ZHBlOHBQOWhLbnZKTXln?=
 =?utf-8?B?ZTVYeUU0ZkFOdVZ4SU5kRVU2dEF1SVpsQ2lQSHlPVUkwSkhLek5BT3RidzhM?=
 =?utf-8?B?VytxZXEwMHQ3bVVyU05mTDFUZ0JpSVZhZGRMUFFha2s1RnptMGF2TFAyN0JK?=
 =?utf-8?B?dXVjOWQwZEt2dEQ1UHZVTGUybTUvSGUzdVpKR1cyRjJ0Q1laSE85OUFEYlZ1?=
 =?utf-8?B?ZmZPayt3WkJkekx5V3JWTVlkSy8zTEd2SmNBb0FoVnEzQWk5aDN2a29kS3Bp?=
 =?utf-8?B?d0VGeHdjVWdtOG0zUEZ1dzhNRW4rOHYyZnlLbnNrTE9jNm0xRld0dVJBZllS?=
 =?utf-8?B?dE9qUFZqSnltbnFGZSszQnVYYjJwUjVpQnVCSk1rb1BSMmVBSXppU09TNzRE?=
 =?utf-8?B?UC9xSmkrbHEyREs3blVJcTRlWFdleGwrd3N0bnpDQ01KaG5hbmNMZVAxR3FV?=
 =?utf-8?B?VEZtSUhlbnVjTmpiVFpzdVNkTGllNHgxV0hUNGp1czRHTnU4VWJMV01ML3lm?=
 =?utf-8?B?ZVdRYUF1VEJvOW1tSVZVVkZVaHZDaU1FVjUyNThpQncxc2pDMTIrRzdaWHZN?=
 =?utf-8?B?dzU2ZlBDTDZSQlBHTkNPRTVGNC9NTmdxY0R6ZUk4R1E2NStSRG81VmZxTWRp?=
 =?utf-8?B?d1ZoSFJZcjFHVjFuOUFxVEFXdDR1NmtwVjN3cktOeFM1empZaCtselhnZ2c0?=
 =?utf-8?B?WHVLU1B6anVwYzZneVpXWStHcFJrelZZbUQ5dmUzY3NQSEMwMGI0YkRjVmwv?=
 =?utf-8?B?SEUxMEFNTUc3QlpCdi9pRm04cmk1ZGE4Wmo0Z1FUV2pyM0NUZlJYSDlDOVdW?=
 =?utf-8?B?NmJPOStHd0JzdFlQK3pFM2t0TGpnaFJvaW5QYTVTcVpuVld1L2lJUGxLby9p?=
 =?utf-8?B?SmJwZm5Sc2hqTWlCUTRUQnhDMUVDRWJ5Q3I5Z2txbWxCbVZHalJzUnluVVZw?=
 =?utf-8?B?UFRNL2hEWm5iSUlZR1c3WnBRNmpKR2JzUFp3MDBGOG5CUnY1QWdURmhBNjh3?=
 =?utf-8?B?emZldUc4T3NrdHA3Z0ZkcnFLd1h3ZTVncTl5ZUFXMDQ5WXMyeUNYTlIrbkM3?=
 =?utf-8?B?NEsrcUFRS3NvWDBycFpnZUpIaDBOaXFsR25wajdLYVA0SjhMbmw3NERxM2pm?=
 =?utf-8?B?cDdTcGVUaWgrUE9GTGRlV1FRak1CcEJBdXdUR1FtUTJtNTdoTXMzdWU4UzBN?=
 =?utf-8?B?bklEb095VmQ1aWlITlZLVjZ0VDJvWjV0T3hiL05GV0VyWWpkYkZRMzR1cGxz?=
 =?utf-8?B?SEpzSVI3NDIyVWxRV3ArVHpNd0x4MzVUU0xnZXNrejR4aVR5T3IvYUU5UHQv?=
 =?utf-8?B?SWxGNFViRmRYQ3FvOGNSNnhpTENRWkgwdFhCMnZDaDREUURnWjhXYmdTWDRX?=
 =?utf-8?B?L2wwY3lIbG5LU2N0YVd4KytJem9Cdy85ZGNVWlhmV1pka0Rsa29HOVNEd3Ri?=
 =?utf-8?B?eUNkYzRjQkdXdmszZVBxa0dZc0J5L3c0WWN3eFF2dE1EYXBTMlp6T3hHU2ti?=
 =?utf-8?B?aC95VEoxNlExUHNzRGNoMzJMZWxQUm9hQ2h1N0krbEljd3NXMnJLTDVvcFgy?=
 =?utf-8?B?VEQza2ZMcWZrRHlydG1hUTZtRkNiT1JxcFI1cEE5ZFNDQ3hJakw4U0F2SHN5?=
 =?utf-8?B?UDNWT3prRTh5VXgyOTRRK2ZNRWdTcDI5NlRjOFJVL3NsWW5SZU5yN291bG1Z?=
 =?utf-8?B?MUZXK0Y3WmkwRWdXY2JNOFJsc2RGQVpJS2s4cDZRS1BNQzZvaUM4MGVUWVVR?=
 =?utf-8?B?WWFaVTJJK3Z3RVh6b3FBM2Q0VFAxUnFRNXU4N3pmNkE4TzFvdGk0U0JsSjEy?=
 =?utf-8?B?bmo2TGw3VkJ6V0d6WW1xMWZPVjFoTmt1UmVRLzZocWt3UTRmZFg1c3J2NThp?=
 =?utf-8?B?M0xpVXpETFlKQWdaUnVPY0dPSG9INlpQcURZL2VxdWxvWm4rc1F6SXorN2Jh?=
 =?utf-8?B?QXZsbWhvakhUTGpSRXJnTlZjUHdhNjNBb1ljK2pFbjluWWpsczhLZFlVbUZP?=
 =?utf-8?B?R2NZd1RveThkQWxTT3NPNEs2Z2NQaHk1eTlJNUZpUDc1Z2JRTGVjL01RZTZT?=
 =?utf-8?B?WTA1OXptSmtJc21uRWIxZ20vdFV4dFNQZjNvUURFOUFuelE3dHFkaTNmQU5O?=
 =?utf-8?B?aks4OFJ6MDJkcHhSRTZ2WW9qYjQ2aDROTzQ1c21oY1RMekhrRldkVVhXYllX?=
 =?utf-8?Q?tSUwFz13+cRAvMHc=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b93ab07-2538-4d3d-d143-08de79fb658d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2026 14:36:18.5486 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IkLO0YmgEAGWTX2lUCvs2SC82NnL3lOrMmAgv8RpUry840X9YK14fKyxPYHZkZDgoQ4fNVjRk4h2Tsl4cu0TvEWqTxB4rjO0eNKgfkGU/ko=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB7036
X-Proofpoint-GUID: 3tXKP5O4iQSBIApxccklD4cIAFrj6X06
X-Proofpoint-ORIG-GUID: 3tXKP5O4iQSBIApxccklD4cIAFrj6X06
X-Authority-Analysis: v=2.4 cv=VOHQXtPX c=1 sm=1 tr=0 ts=69a84364 cx=c_pps
 a=4aRk0r0zml5r3XTsplXTjQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=y4UcunY2MAxhM4LwGdWI:22
 a=XYAwZIGsAAAA:8 a=64Cc0HZtAAAA:8 a=K6uf3r2GCE9uHVRiVjIA:9 a=QEXdDO2ut3YA:10
 a=O8hF6Hzn-FEA:10 a=E8ToXWR_bxluHZ7gmE-Z:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA0MDExOCBTYWx0ZWRfX9CqDjAAdljA6
 TiUSGNcJ19hIo3HZxvZSbHmABQNBYpyU+FFbXsTbs9ZRFTHpqfbtRTEODBpiHiJDCsfJwKRKavQ
 6UdqFwqpHtV5Yam9lpIbkBvuv91Nk2tNeeGGb9n9fmqrH/J0yCVUapjXVZCHoT9UUgunyZb7Kgb
 4QbHh0n9sVRAYJUzFW6bTZy8C1AdefGgjMtfi5b+LD8SYxn00WTiCSTC5r0ke83zfEz2SZz1Fa/
 8JnLUsAA78ZTn/n4DXrSPcbBovz/D02J4CjxBGFPYHE6/N1MQOgSVmlOnFDFd7BDucrrZLXmMXW
 b4eMB3EhKvyE0IYPT0gEGDGNFuhM7posaj5CNkj0DFUCXfsFVSVHgy0JdQWZ7P7Ob5qFMJwAVbI
 Nyoo3vFsLYWN6cWS0whAze4CEcojoa3zl+Ntq8rvqqTdijHx7es7W60OiUGudqiG1oAR2It9So9
 +IvpZJhMcXxc78KZfsA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-04_06,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.703,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=1.386, SPF_HELO_NONE=0.001,
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

On 04/03/2026 11:22, Igor Mammedov wrote:

> On Fri, 27 Feb 2026 13:44:58 +0000
> Mark Cave-Ayland <mark.caveayland@nutanix.com> wrote:
> 
>>  From Windows 8.1 onwards ISA serial IRQs cannot be shared when ACPI Revision
>> 5.0 is used in the FACP table. The reason for this is that if a 2-byte IRQ
>> Descriptor is used then the interrupt is considered to be high true, edge
>> sensitive, non-shareable. Since legacy serial ports COM1/3 and COM2/4 share
>> an IRQ then if more than 2 serial ports are added, Windows indicates a
>> conflict in Device Manager and these combinations cannot be used together.
>>
>> Add a new 3-byte IRQ Descriptor to the _CRS resource indicating that the
>> ISA serial IRQ is low true, edge sensitive and shareable, along with a
>> corresponding _PRS resource so that the legacy serial ports also appear
>> at a fixed address. This enables all 4 legacy serial ports to be used in
>> Windows without conflict.
> 
> What happens if we just replace aml_irq_no_flags() with aml_irq()
> (without compat knob and _PRS)
> 
> wrt _PRS could you elaborate some more why it's needed and what happens
> if it doesn't exists?

Good question. I based the implementation on the technote from Microchip 
at https://ww1.microchip.com/downloads/en/DeviceDoc/00001879A.pdf and 
found that it worked fine here on Windows 11.

My concern from deviating from the document would be that any changes 
would work fine on Windows 11, but then fail on older versions of Windows.

I can try and locate a copy of Windows 8.1 internally if you still think 
that is worth pursuing?

>> Finally add a new x-acpi-shared-irq property to disable the ACPI IRQ descriptor
>> changes for older PC machine types, and add it to the pc_compat_10_2[] array.
>>
>> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
>> ---
>>   hw/char/serial-isa.c | 23 ++++++++++++++++++++++-
>>   hw/i386/pc.c         |  4 +++-
>>   2 files changed, 25 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/char/serial-isa.c b/hw/char/serial-isa.c
>> index a4be0492c5..1662da86bd 100644
>> --- a/hw/char/serial-isa.c
>> +++ b/hw/char/serial-isa.c
>> @@ -28,6 +28,7 @@
>>   #include "qemu/module.h"
>>   #include "system/system.h"
>>   #include "hw/acpi/acpi_aml_interface.h"
>> +#include "hw/acpi/aml-build.h"
>>   #include "hw/char/serial.h"
>>   #include "hw/char/serial-isa.h"
>>   #include "hw/isa/isa.h"
>> @@ -43,6 +44,7 @@ struct ISASerialState {
>>       uint32_t index;
>>       uint32_t iobase;
>>       uint32_t isairq;
>> +    bool acpi_shared_irq;
>>       SerialState state;
>>   };
>>   
>> @@ -92,7 +94,12 @@ static void serial_isa_build_aml(AcpiDevAmlIf *adev, Aml *scope)
>>   
>>       crs = aml_resource_template();
>>       aml_append(crs, aml_io(AML_DECODE16, isa->iobase, isa->iobase, 0x00, 0x08));
>> -    aml_append(crs, aml_irq_no_flags(isa->isairq));
>> +    if (isa->acpi_shared_irq) {
>> +        aml_append(crs, aml_irq(isa->isairq, AML_EDGE, AML_ACTIVE_LOW,
>> +                                AML_SHARED));
>> +    } else {
>> +        aml_append(crs, aml_irq_no_flags(isa->isairq));
>> +    }
>>   
>>       dev = aml_device("COM%d", isa->index + 1);
>>       aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0501")));
>> @@ -100,6 +107,18 @@ static void serial_isa_build_aml(AcpiDevAmlIf *adev, Aml *scope)
>>       aml_append(dev, aml_name_decl("_STA", aml_int(0xf)));
>>       aml_append(dev, aml_name_decl("_CRS", crs));
>>   
>> +    if (isa->acpi_shared_irq) {
>> +        Aml *prs = aml_resource_template();
>> +
>> +        aml_append(prs, aml_start_dependent_function(0, 0));
>> +        aml_append(prs, aml_io(AML_DECODE16, isa->iobase, isa->iobase, 0x00,
>> +                               0x08));
>> +        aml_append(prs, aml_irq(isa->isairq, AML_EDGE, AML_ACTIVE_LOW,
>> +                                AML_SHARED));
>> +        aml_append(prs, aml_end_dependent_function());
>> +        aml_append(dev, aml_name_decl("_PRS", prs));
>> +    }
>> +
>>       aml_append(scope, dev);
>>   }
>>   
>> @@ -117,6 +136,8 @@ static const Property serial_isa_properties[] = {
>>       DEFINE_PROP_UINT32("index",  ISASerialState, index,   -1),
>>       DEFINE_PROP_UINT32("iobase",  ISASerialState, iobase,  -1),
>>       DEFINE_PROP_UINT32("irq",    ISASerialState, isairq,  -1),
>> +    DEFINE_PROP_BOOL("x-acpi-shared-irq", ISASerialState, acpi_shared_irq,
>> +                     true),
>>   };
>>   
>>   static void serial_isa_class_initfn(ObjectClass *klass, const void *data)
>> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
>> index 0dd3fd01d9..c0335b05ba 100644
>> --- a/hw/i386/pc.c
>> +++ b/hw/i386/pc.c
>> @@ -82,7 +82,9 @@
>>       { "qemu64-" TYPE_X86_CPU, "model-id", "QEMU Virtual CPU version " v, },\
>>       { "athlon-" TYPE_X86_CPU, "model-id", "QEMU Virtual CPU version " v, },
>>   
>> -GlobalProperty pc_compat_10_2[] = {};
>> +GlobalProperty pc_compat_10_2[] = {
>> +    { "isa-serial", "x-acpi-shared-irq", "false" },
>> +};
>>   const size_t pc_compat_10_2_len = G_N_ELEMENTS(pc_compat_10_2);
>>   
>>   GlobalProperty pc_compat_10_1[] = {


ATB,

Mark.


