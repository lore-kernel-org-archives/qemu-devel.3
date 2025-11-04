Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43811CCFA00
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 08:23:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGCJl-00030Y-Ko; Tue, 04 Nov 2025 03:23:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jan.kiszka@siemens.com>)
 id 1vGCJh-0002yS-Qp; Tue, 04 Nov 2025 03:23:01 -0500
Received: from mail-westeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c201::1] helo=AM0PR83CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jan.kiszka@siemens.com>)
 id 1vGCJd-0000nf-Uh; Tue, 04 Nov 2025 03:23:01 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EdMxKHfk0uFK7LxCPohMDnwvX80/9Esc/SfYhxnm69oQLV6kUCYUO06YxJUnAO231i4c5E5JD5UYW3hfELu/baB5ylhlTn+Qi1EMF8fyJX+YxZi9wFmKF4QfsOwtOUeSaIzwGvbbSxpBBuVHkIWup8j1Fvc7VroSP4Yr/WsTXR3zsvM04dgbEC3rGrR+ZFUYdmnzOdmxDhGEiwPDRGk5bnNiASOdTDWFROKXI6TEXgpiapcXMzQskTuDtuGqhlLcsKsXTGgeae2R+/ab6JGarmfVUC4r6bf5lWE9ATgwpsT78EOa9/5E8WRCPOhi4VZLzoLBMUML6HkGPaP+gHbiUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jBK4sm64MSAGqZaQCKJX66b4t9wqQR37v1ty9NPNgzA=;
 b=EyNJHwyLJUgu6P1FNrBLGDGh39DBFleg2g3wE96Hhmg8+v2iUXNzuQ6Ul1KWmhuPQAYbNSXCvRcGVyImeQdCLKhl9dnlnFVt3F1Vr9jUcRwe8x8FKd1oavxMAioGEnHURBe3XYwhY/JFKGz3njyBTAVx7YeXCnF0DN+fYphCHZ0vd8I9gAfsClvj/7PbzA4hIf3bvSrB+QBH+c5ylbcAzPPhohYdwP4zBI4vINSB2+13z2Em/VsrMQLH65wrWHE79GRoWxuBq5QMzGLW4wvOW5jZzJOkJx64TplUfcf5PqbsdPP3/BsI2vXRoyse8Wb1ZeG+a1lLqdeIQ0x0qoFyBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jBK4sm64MSAGqZaQCKJX66b4t9wqQR37v1ty9NPNgzA=;
 b=gpkhWfyBPYblEmwu0olVIssuJcdZiVmDyLdvrJmoKoo8FLE5H3MfjNa4daR9FRzglgrvJkHQVF28AzutxziBqvdDed4pWPbGaM2VADKEB11UwyEy7t1kSBElroEWkdabyC1NzFwjN0wsZotcAq56UAIboDvhhdcgNmyF8vYLYnGvqqSvgBIl+GpKg0+GjwQpEebRlAxNO6CAA40ULt8H1OU8C7wm+6LqOa87cokvLQNTQb6ZiX1M1IcTXe4NIGjjd9BIAZZWjQtysim7cfyqIpbo66xVXO1CTH5iQ0IOksncjlMpSNciRJl6vsFEMJgxws0lRiX/1td+DaYuZXg3yA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS1PR10MB5261.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4a5::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 06:34:30 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9275.015; Tue, 4 Nov 2025
 06:34:29 +0000
Message-ID: <9b8a47a1-a2f0-4299-a35e-0d2272ba7818@siemens.com>
Date: Tue, 4 Nov 2025 07:34:28 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/6] hw/sd/sdcard: Add basic support for RPMB partition
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>
Cc: Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Jan_L=C3=BCbbe?= <jlu@pengutronix.de>,
 Jerome Forissier <jerome.forissier@linaro.org>
References: <cover.1760702638.git.jan.kiszka@siemens.com>
 <091d69e0e15b951f6110938c8ebffc988204f52c.1760702638.git.jan.kiszka@siemens.com>
 <66a62dd7-e4b7-407a-8402-8b9b5b08833e@linaro.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <66a62dd7-e4b7-407a-8402-8b9b5b08833e@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0435.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d1::14) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS1PR10MB5261:EE_
X-MS-Office365-Filtering-Correlation-Id: 14ab7581-2a90-4901-aa14-08de1b6c3524
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Zyt1azljbGF4MFA0VjREekJyL3RlS2NDejB1TmlUTWp2bEIyZm5QSTA0cXF0?=
 =?utf-8?B?YzJFMVo1VjQ4V001R1cvT3lxQ0loQXpHNGsrSWppSStlRmhOTGhiZ2RyVFg0?=
 =?utf-8?B?bmdKRmdmWVIyWWZ3TXIrQjlEd0gxVVpSeWVrVU8xY0FqZ2FNWlRuN1JBT00r?=
 =?utf-8?B?MDlLWms5cExDdlpxOVdHeDY3eDFCSW5XZ24rMi9TQjFqWStXRThobGRYalNR?=
 =?utf-8?B?TFNOdVZsWHBwUFBHK3dSRHMyNXluMXQ0WklkMGxmSWpQVE81VFJtMTVmNDFY?=
 =?utf-8?B?YnVTM2w4N2FDbWxDQjZKUmdMeGpIc3d2VXZZQVZWeDkrZTYyMEY1SFkydCti?=
 =?utf-8?B?cllaMk5vYlhxN2prclhVcnE4c0ZPTTdIVDlRQmVBampPNlNXWENscDFpZmVp?=
 =?utf-8?B?NnN2Y0tPcSt0TGVXRFBwUmhRUHYvaHo0Mm1qV0ZTUjA0SnJ6SHJQNWxYSW03?=
 =?utf-8?B?N3dMbXcvc1piWUZ5NEFQcWgzcjRVS0cwbmxJOFk1aDBUSjNua2VOMnlkTm5l?=
 =?utf-8?B?d0w3bzVRWlBIRENKT3dFRXM5K21mS0NOR280cmtqMkVXWU5DZ0tWem9NZUV2?=
 =?utf-8?B?NlBzTXpqTWJmL1E5MWF4YU5vUEJnc05Zcm83U3JZaUR0K2NkMHJnblgzWkpo?=
 =?utf-8?B?cU1uZlJKZnZJbDZzMVpPSnR5UllkRGp1ZW9PYzI1SStKYy9kajhUVmRwVVdH?=
 =?utf-8?B?V2JnU2NVM21BdzNKRUZzSHZqTGFpMzdEdkV3OFpLaFNlbXF3QjJsZHlsMXk0?=
 =?utf-8?B?YVczUy9iQ2lHaTlYUDJNdEVpZ3lObXJDUVllZHFKZVQ2QmxWN0pzQS9iUHcy?=
 =?utf-8?B?Z3MxdkRBTldCelFGTVFqVFN2eWI0NzBWMzlxODRjMUQwN0JTL0Rub1VSQ3FS?=
 =?utf-8?B?eS9wZ2tpT3FOYnBLY2dabFRKYVBiUjJrUmtaTG1qWWx5QmtxaDZPWEl3RGl2?=
 =?utf-8?B?TGZnUFFScXZ5V05DbWY0VzU1N0xVRHV6SEc1d2ViSDhLWVlvM20rU3BWakh2?=
 =?utf-8?B?SUtKaU9EWWcwL2wwdXkzbmIxYkpHbzFDUEJRQTlQeWd2a0Y1cUFWdTEybWxR?=
 =?utf-8?B?VWxGNHRNcXVGK2FTZjJiMHk0N0tGZjh3MElLQnBqaUJUcWZJRlk3T1JGb2Fx?=
 =?utf-8?B?VlRIVWJBdTZsNThnNk9UMHJ3MHB3YmNFWldNMU5GMS8yUWFzdnVYUXExV0FD?=
 =?utf-8?B?UWJOcml0ZlJkU3poTVFXNTdKQ2FzZjJjMDFoWUlHcnZ4dXpPOHREVXUyNzlE?=
 =?utf-8?B?OW1oYitPTXl6QjZuV2NEdVRFcVhmOW5QVEh6WjVlVUMvdXZjdjQ4eEpJd2g0?=
 =?utf-8?B?TWpOcEx6WGF4M2g2L1I2WDBTbU5USXZiT1VXY21rTXVZVk5jNzRadmFJZnVm?=
 =?utf-8?B?NGtmRHRGZVhoTGthMG9LSm85SGtzc1FWUTZiVkdJaEFSY0VFTkdRRmYrN0FD?=
 =?utf-8?B?RzFxbS92RDljM25EK3k0OWttL3JUL05mdTJoWWxIRzB2dEZ0Q1N4RnhwQVB4?=
 =?utf-8?B?R0hOVTgvcXpWNDRONHQ2dW9iL0VrdmJRSllwSXA4WllHTlBBd1M1cTkyMjJE?=
 =?utf-8?B?SlFBS1NjWisxR0ZkMlhZdFczSHloUzdncnoyb2Vuek5YMnNqK29HUGJIUnNz?=
 =?utf-8?B?RXc2UXRtZlFUQ28rYndNcm5naXYwb2ExbG5lWWZyS2ROK2tLdHBFZjkzZ3NF?=
 =?utf-8?B?WkFSMk45bkVFUStLVExNOUlSQXByT2JlSTcwMEROWVJaMkhXOVBQS3VyVTlS?=
 =?utf-8?B?RmJVd1FmWUdMWHV6OW5WOWhwVllDMGJNM2xTVHFlLzU4a2kzcEpxZnVFV3Rx?=
 =?utf-8?B?TVNsU2sveWM3RmxiZ3dIMHRqWnFHWWpMYUV6c09nM0h2TWZsYUx2RGg5SW1t?=
 =?utf-8?B?OEVhaXZjNm4xdTFGUEw3Z0lncWRLUytvczJCbTZpRGgxWndQeU9ENVhDbjIr?=
 =?utf-8?Q?oAIQjyb5bfHgpY7qY3pWIrURG1n7LAr6?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UzJBVFBxc0lmeS81Qm5oU1Qrd2JEZWF3SGtvMmdJYm0xNTUyZHFSVWZQMHZJ?=
 =?utf-8?B?K2hTV0x3eG9kejdCYjloWHFBUk1Nc1hVNFZYV042bTRIcXJZU2owRHF5Wklu?=
 =?utf-8?B?WkdsbUJSR0tmUVMvaUwrVnlOZlpNZ2phdHE3WXpvYSs3MUgvSjAzNnVQYmJZ?=
 =?utf-8?B?VEp1cmhPSTRUWTdTRmUydUJoRWxZRE1KR1lRY05zbDQrazFaT2s1c2ZYWmxm?=
 =?utf-8?B?SkZrZnV0TUt5YzBNdER3WFgzdlV6NWduaGJUMnltZGh3NHk0MjRWcU0zcS9m?=
 =?utf-8?B?a0J4ckJtT0tWRjVCSzhYY3ZwQ05PWWhMVFJZV2dnL1daVHNJY2pOUVB3UDV3?=
 =?utf-8?B?VnJwWFlGS2VBZWExVXYvOHB2TzlvMlFMeERmRUpTbzBNL0dPNjBOWC95ZXlQ?=
 =?utf-8?B?NmxQM0w5NEV5dS9QdWZpQm9JbVVkUXZtT1c0NHRZazFaR2F2MHdyZ0JIV1FP?=
 =?utf-8?B?eDBTZkJlODZqNEg0NGVXYnJOeGVHN21HanNWcUNoeGpSb1JWb3oxZDBmOWdV?=
 =?utf-8?B?cTFWQlN6UEo1Y2lPcDhsTFBNK2tCaVgrT0UrUU0yQWVYRFlNalZFcjB1dzMz?=
 =?utf-8?B?NGc4S3ZrUkRPZkQvWlk4YklqKzdSYXJXcmwwbXEyQXd4eGNaQ0xCYXpSKzZO?=
 =?utf-8?B?ZHBLSTAxTUdqY0dRVXdubHFYQkdNOFk5UkVQZExrdFFuanVmMjhXZTR6Vmxk?=
 =?utf-8?B?Q1liZHpmNDJSRDI0VHZ0S3lWM1FLRllCcnFROEVOL1R4V0d4YUQ3YUVwNlR6?=
 =?utf-8?B?WCtKUzdldHhMSkNJUUFwVzVTZFJFQ2luOUp2amR0K2J1bTZsZjJrSHIvQ1hF?=
 =?utf-8?B?R2UxTXJ3WEx6RW5tWmxzQ1poQlhJVmtaZzB6VzVldk52TTVEOVRCNWZBYWZh?=
 =?utf-8?B?L1l5ek90WFZ1L0tkV0FYb1JtU0lmSGs0NkJTOTZ1dkREZklnWDBMVll6RHh1?=
 =?utf-8?B?VENIeDVPN3pDc2RxenFlM2l3TklkMXhTMkVxY3pQekc3RzBRU2t2N1pISjBS?=
 =?utf-8?B?b01aSjRqMmFhNEsyWXQ1VUJpY2E1REt0THhPbFc3dklPWG1VOVFlSURML0lm?=
 =?utf-8?B?Y0xncXlWWDZTRWFlbDlYWldGL2xBaXpYeDZ0VVJEbmpqU2kyWnpUcDhtOEVZ?=
 =?utf-8?B?Nk5pNk1RSHVUdHdWZ3R2TjhTZVB6elR2MmZ4Q0tMeXRUQ0Y2YlVaS3JRcmpI?=
 =?utf-8?B?REFCOFhMTThsUDdDNXRWdDg0bHdieUM0OE5XdU9OZ2UzbDk5bEQ2WnJhT0FY?=
 =?utf-8?B?d2JBMlg4dUpLVlArMHdBZFFndTcvQ0dmcDZKUUNoS1dLM1p3ZjlEV0NZNmd0?=
 =?utf-8?B?aTlkamFyM2dKQWlFZldNYWtFVFpVb1FtRjFoVmttemlEWTBZYzdaNk1DVkpU?=
 =?utf-8?B?MEc4S1V3RGxpc1ZMYy9NU0tVSlc2Zk4yQXAyalJhaTFhSGJsb21mR3ZkM3Ur?=
 =?utf-8?B?M05jSG5wZmo4YWM5UkVrbS9ISFV3MlNVWkkvYm05dmdmdWlZN05ScHdIYXFW?=
 =?utf-8?B?UHE4S09rSzBadngrZ0Nqa09PWWFjTUJKMk5zYWV1WmFBTHhOV0lNK2JUMDBp?=
 =?utf-8?B?eHY3QjFoeGhCS3VLVVNTSTJQS3BBR3dHemZKK3FKVWgxR01YWnBBdlZRdGNZ?=
 =?utf-8?B?dkJHQmlHUFdWOVk2aEJjR013MGhqU0tycVU2RHhsUmxaYXo4NjY4M3o0L3dM?=
 =?utf-8?B?clBqL3lyejV2YVd4N3pGVzZRWmcvOHhsbmhuR1hSa1FIdVlLQVFkNDNVS3J0?=
 =?utf-8?B?NmJxVWZXUG9hU2tHN2ppeVIzQVVuSzBIUzdMWjlQN2I1L0Q1U2g4R3M3WmZo?=
 =?utf-8?B?MFhmZjZ3L3ZZOUNpQmxzSTJXYXorV05XSnF6ZkNaTkdZeHFRZWQvd3Ivdksz?=
 =?utf-8?B?OWY2dVBZZ0xXTjJKWmV0NUpjeFNQRk5LMzRhM1FNUnY4MkJCakNRNmh1L3dR?=
 =?utf-8?B?a1IrZWI2YzZJbXhtS2U5aC90R3JPTWFLclJFdmk1Wk1GWmN2elRpNlMyWnk4?=
 =?utf-8?B?VjBJNlFUcXd1dVJZb09OTXp2VFNMVjdRREgyMGRrQ2NmbldITUtaWVVZOWNh?=
 =?utf-8?B?VlpyS1FYWGsxOGtZY3FrRmFDbWtVdjRoNFJwUkgwK04zNGhlNzc1bWpRNnll?=
 =?utf-8?B?VzBnNHlQa1FHbUdGUVpNblprWGZsQXdMZGp5aDlsR0hiUlQxeWUrODN1cWJk?=
 =?utf-8?B?U0E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14ab7581-2a90-4901-aa14-08de1b6c3524
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 06:34:29.7151 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gs97gT7sZSqSmxDXv5+rrdfQdE32GdlEf3HNfCQBpSUQ4AmXaj5qNcBPAOQXXQE9tVtpatIpvYkbXcAYqkwvNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB5261
Received-SPF: pass client-ip=2a01:111:f403:c201::1;
 envelope-from=jan.kiszka@siemens.com;
 helo=AM0PR83CU005.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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

On 03.11.25 16:08, Philippe Mathieu-Daudé wrote:
> Hi Jan,
> 
> On 17/10/25 14:03, Jan Kiszka wrote:
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> The Replay Protected Memory Block (RPMB) is available since eMMC 4.4
>> which has been obsoleted by 4.41. Therefore lift the provided
>> EXT_CSD_REV to 5 (4.41) and provide the basic logic to implement basic
>> support for it. This allows to set the authentication key, read the
>> write counter and authenticated perform data read and write requests.
>> Those aren't actually authenticated yet, support for that will be added
>> later.
>>
>> The RPMB image needs to be added to backing block images after potential
>> boot partitions and before the user data. It's size is controlled by
>> the rpmb-partition-size property.
>>
>> Also missing in this version (and actually not only for RPMB bits) is
>> persistence of registers that are supposed to survive power cycles. Most
>> prominent are the write counters or the authentication key. This feature
>> can be added later, e.g. by append a state structure to the backing
>> block image.
>>
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>> ---
>>   hw/sd/sd.c             | 206 +++++++++++++++++++++++++++++++++++++++--
>>   hw/sd/sdmmc-internal.h |  21 +++++
>>   hw/sd/trace-events     |   2 +
>>   3 files changed, 221 insertions(+), 8 deletions(-)
>>
>> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
>> index 305ea251cb..918fe9f79f 100644
>> --- a/hw/sd/sd.c
>> +++ b/hw/sd/sd.c
>> @@ -117,6 +117,20 @@ typedef struct SDProto {
>>       } cmd[SDMMC_CMD_MAX], acmd[SDMMC_CMD_MAX];
>>   } SDProto;
>>   
> 
>   #define RPMB_STUFF_LEN      196
> 
>> +#define RPMB_KEY_MAC_LEN    32
>> +
>> +typedef 
> 
> QEMU_PACKED (better safe than sorry).
> 
>> struct {
>> +    uint8_t stuff_bytes[196];
>> +    uint8_t key_mac[RPMB_KEY_MAC_LEN];
>> +    uint8_t data[256];
>> +    uint8_t nonce[16];
>> +    uint32_t write_counter;
>> +    uint16_t address;
>> +    uint16_t block_count;
>> +    uint16_t result;
>> +    uint16_t req_resp;
>> +} RPMBDataFrame;
>> +
>>   struct SDState {
>>       DeviceState parent_obj;
>>   @@ -140,6 +154,7 @@ struct SDState {
>>         uint8_t spec_version;
>>       uint64_t boot_part_size;
>> +    uint64_t rpmb_part_size;
>>       BlockBackend *blk;
>>       uint8_t boot_config;
>>   @@ -172,6 +187,10 @@ struct SDState {
>>       uint32_t data_offset;
>>       size_t data_size;
>>       uint8_t data[512];
>> +    RPMBDataFrame rpmb_result;
>> +    uint32_t rpmb_write_counter;
>> +    uint8_t rpmb_key[32];
>> +    uint8_t rpmb_key_set;
> 
> Matter of style:
> 
>        struct {
>            uint32_t write_counter;
>            uint8_t key[RPMB_KEY_MAC_LEN];
>            uint8_t key_set;
>            RPMBDataFrame result;
>        } rpmb;
> 
>>       QEMUTimer *ocr_power_timer;
>>       uint8_t dat_lines;
>>       bool cmd_line;
>> @@ -506,7 +525,9 @@ static void emmc_set_ext_csd(SDState *sd, uint64_t
>> size)
>>       sd->ext_csd[205] = 0x46; /* Min read perf for 4bit@26Mhz */
>>       sd->ext_csd[EXT_CSD_CARD_TYPE] = 0b11;
>>       sd->ext_csd[EXT_CSD_STRUCTURE] = 2;
>> -    sd->ext_csd[EXT_CSD_REV] = 3;
>> +    sd->ext_csd[EXT_CSD_REV] = 5;
>> +    sd->ext_csd[EXT_CSD_RPMB_MULT] = sd->rpmb_part_size / (128 * KiB);
>> +    sd->ext_csd[EXT_CSD_PARTITION_SUPPORT] = 0b111;
>>         /* Mode segment (RW) */
>>       sd->ext_csd[EXT_CSD_PART_CONFIG] = sd->boot_config;
>> @@ -834,7 +855,8 @@ static uint32_t sd_blk_len(SDState *sd)
>>   /*
>>    * This requires a disk image that has two boot partitions inserted
>> at the
>>    * beginning of it, followed by an RPMB partition. The size of the boot
>> - * partitions is the "boot-partition-size" property.
>> + * partitions is the "boot-partition-size" property, the one of the RPMB
>> + * partition is 'rpmb-partition-size'.
>>    */
>>   static uint32_t sd_part_offset(SDState *sd)
>>   {
>> @@ -848,11 +870,13 @@ static uint32_t sd_part_offset(SDState *sd)
>>                                    & EXT_CSD_PART_CONFIG_ACC_MASK;
>>       switch (partition_access) {
>>       case EXT_CSD_PART_CONFIG_ACC_DEFAULT:
>> -        return sd->boot_part_size * 2;
>> +        return sd->boot_part_size * 2 + sd->rpmb_part_size;
>>       case EXT_CSD_PART_CONFIG_ACC_BOOT1:
>>           return 0;
>>       case EXT_CSD_PART_CONFIG_ACC_BOOT2:
>>           return sd->boot_part_size * 1;
>> +    case EXT_CSD_PART_CONFIG_ACC_RPMB:
>> +        return sd->boot_part_size * 2;
>>       default:
>>            g_assert_not_reached();
>>       }
>> @@ -891,7 +915,7 @@ static void sd_reset(DeviceState *dev)
>>       }
>>       size = sect << HWBLOCK_SHIFT;
>>       if (sd_is_emmc(sd)) {
>> -        size -= sd->boot_part_size * 2;
>> +        size -= sd->boot_part_size * 2 + sd->rpmb_part_size;
>>       }
>>         sect = sd_addr_to_wpnum(size) + 1;
>> @@ -979,6 +1003,34 @@ static const VMStateDescription sd_ocr_vmstate = {
>>       },
>>   };
>>   +static bool vmstate_needed_for_rpmb(void *opaque)
>> +{
>> +    SDState *sd = opaque;
>> +
>> +    return sd->rpmb_part_size > 0;
>> +}
>> +
>> +static const VMStateDescription emmc_rpmb_vmstate = {
>> +    .name = "sd-card/ext_csd_modes-state",
>> +    .version_id = 1,
>> +    .minimum_version_id = 1,
>> +    .needed = vmstate_needed_for_rpmb,
>> +    .fields = (const VMStateField[]) {
>> +        VMSTATE_UINT8_ARRAY(rpmb_result.key_mac, SDState,
>> RPMB_KEY_MAC_LEN),
>> +        VMSTATE_UINT8_ARRAY(rpmb_result.data, SDState, 256),
>> +        VMSTATE_UINT8_ARRAY(rpmb_result.nonce, SDState, 16),
>> +        VMSTATE_UINT32(rpmb_result.write_counter, SDState),
>> +        VMSTATE_UINT16(rpmb_result.address, SDState),
>> +        VMSTATE_UINT16(rpmb_result.block_count, SDState),
>> +        VMSTATE_UINT16(rpmb_result.result, SDState),
>> +        VMSTATE_UINT16(rpmb_result.req_resp, SDState),
>> +        VMSTATE_UINT32(rpmb_write_counter, SDState),
>> +        VMSTATE_UINT8_ARRAY(rpmb_key, SDState, 32),
>> +        VMSTATE_UINT8(rpmb_key_set, SDState),
>> +        VMSTATE_END_OF_LIST()
>> +    },
>> +};
>> +
>>   static bool vmstate_needed_for_emmc(void *opaque)
>>   {
>>       SDState *sd = opaque;
>> @@ -1045,6 +1097,7 @@ static const VMStateDescription sd_vmstate = {
>>       .subsections = (const VMStateDescription * const []) {
>>           &sd_ocr_vmstate,
>>           &emmc_extcsd_vmstate,
>> +        &emmc_rpmb_vmstate,
>>           NULL
>>       },
>>   };
>> @@ -1067,6 +1120,105 @@ static void sd_blk_write(SDState *sd, uint64_t
>> addr, uint32_t len)
>>       }
>>   }
>>   +static void emmc_rpmb_blk_read(SDState *sd, uint64_t addr, uint32_t
>> len)
>> +{
>> +    uint16_t resp = be16_to_cpu(sd->rpmb_result.req_resp);
>> +    uint16_t result = be16_to_cpu(sd->rpmb_result.result);
>> +    unsigned int curr_block = 0;
>> +
>> +    if ((result & ~RPMB_RESULT_COUTER_EXPIRED) == RPMB_RESULT_OK &&
>> +        resp == RPMB_RESP(RPMB_REQ_AUTH_DATA_READ)) {
>> +        curr_block = be16_to_cpu(sd->rpmb_result.address);
>> +        if (sd->rpmb_result.block_count == 0) {
>> +            sd->rpmb_result.block_count = cpu_to_be16(sd-
>> >multi_blk_cnt);
>> +        } else {
>> +            curr_block += be16_to_cpu(sd->rpmb_result.block_count) -
>> +                sd->multi_blk_cnt;
>> +        }
>> +        addr = curr_block * 256 + sd_part_offset(sd);
>> +        if (blk_pread(sd->blk, addr, 256, sd->rpmb_result.data, 0) <
>> 0) {
> 
> Would be nice to re-use sd_blk_read(), but I notice we want to read the
> frame data to then copy the whole message into sd->data.
> 
>> +            fprintf(stderr, "sd_blk_read: read error on host side\n");
> 
> Although a pre-existing pattern in this file, no new fprintf(stderr)
> please. Better use the Error* API, otherwise error_report().
> 
>               error_report("sd_blk_read: read error on host side");
> 
>> +            memset(sd->rpmb_result.data, 0, sizeof(sd-
>> >rpmb_result.data));
>> +            sd->rpmb_result.result =
>> cpu_to_be16(RPMB_RESULT_READ_FAILURE |
>> +                (result & RPMB_RESULT_COUTER_EXPIRED));
>> +        }
>> +    }
>> +    memcpy(sd->data, &sd->rpmb_result, sizeof(sd->rpmb_result));
>> +
>> +    trace_sdcard_rpmb_read_block(resp, curr_block,
>> +                                 be16_to_cpu(sd->rpmb_result.result));
>> +}
>> +
>> +static void emmc_rpmb_blk_write(SDState *sd, uint64_t addr, uint32_t
>> len)
>> +{
>> +    RPMBDataFrame *frame = (RPMBDataFrame *)sd->data;
>> +    uint16_t req = be16_to_cpu(frame->req_resp);
>> +
>> +    if (req == RPMB_REQ_READ_RESULT) {
>> +        /* just return the current result register */
>> +        goto exit;
>> +    }
>> +    memset(&sd->rpmb_result, 0, sizeof(sd->rpmb_result));
>> +    memcpy(sd->rpmb_result.nonce, frame->nonce, sizeof(sd-
>> >rpmb_result.nonce));
>> +    sd->rpmb_result.result = cpu_to_be16(RPMB_RESULT_OK);
>> +    sd->rpmb_result.req_resp = cpu_to_be16(RPMB_RESP(req));
>> +
>> +    if (!sd->rpmb_key_set && req != RPMB_REQ_PROGRAM_AUTH_KEY) {
>> +        sd->rpmb_result.result = cpu_to_be16(RPMB_RESULT_NO_AUTH_KEY);
>> +        goto exit;
>> +    }
>> +
>> +    switch (req) {
>> +    case RPMB_REQ_PROGRAM_AUTH_KEY:
>> +        if (sd->rpmb_key_set) {
>> +            sd->rpmb_result.result =
>> cpu_to_be16(RPMB_RESULT_WRITE_FAILURE);
>> +            break;
>> +        }
>> +        memcpy(sd->rpmb_key, frame->key_mac, sizeof(sd->rpmb_key));
>> +        sd->rpmb_key_set = 1;
>> +        break;
>> +    case RPMB_REQ_READ_WRITE_COUNTER:
>> +        sd->rpmb_result.write_counter = cpu_to_be32(sd-
>> >rpmb_write_counter);
>> +        break;
>> +    case RPMB_REQ_AUTH_DATA_WRITE:
>> +        /* We only support single-block writes so far */
>> +        if (sd->multi_blk_cnt != 1) {
>> +            sd->rpmb_result.result =
>> cpu_to_be16(RPMB_RESULT_GENERAL_FAILURE);
>> +            break;
>> +        }
>> +        if (sd->rpmb_write_counter == 0xffffffff) {
>> +            sd->rpmb_result.result =
>> cpu_to_be16(RPMB_RESULT_WRITE_FAILURE);
>> +            break;
>> +        }
>> +        if (be32_to_cpu(frame->write_counter) != sd-
>> >rpmb_write_counter) {
>> +            sd->rpmb_result.result =
>> cpu_to_be16(RPMB_RESULT_COUNTER_FAILURE);
>> +            break;
>> +        }
>> +        sd->rpmb_result.address = frame->address;
>> +        addr = be16_to_cpu(frame->address) * 256 + sd_part_offset(sd);
>> +        if (blk_pwrite(sd->blk, addr, 256, frame->data, 0) < 0) {
>> +            fprintf(stderr, "sd_blk_write: write error on host side\n");
> 
>                error_report("sd_blk_write: write error on host side");
> 
>> +            sd->rpmb_result.result =
>> cpu_to_be16(RPMB_RESULT_WRITE_FAILURE);
>> +        } else {
>> +            sd->rpmb_write_counter++;
>> +        }
>> +        sd->rpmb_result.write_counter = cpu_to_be32(sd-
>> >rpmb_write_counter);
>> +        break;
>> +    case RPMB_REQ_AUTH_DATA_READ:
>> +        sd->rpmb_result.address = frame->address;
>> +        break;
>> +    default:
>> +        qemu_log_mask(LOG_UNIMP, "RPMB request %d not implemented\n",
>> req);
>> +        sd->rpmb_result.result =
>> cpu_to_be16(RPMB_RESULT_GENERAL_FAILURE);
>> +        break;
>> +    }
>> +exit:
>> +    if (sd->rpmb_write_counter == 0xffffffff) {
>> +        sd->rpmb_result.result |=
>> cpu_to_be16(RPMB_RESULT_COUTER_EXPIRED);
>> +    }
>> +    trace_sdcard_rpmb_write_block(req, be16_to_cpu(sd-
>> >rpmb_result.result));
>> +}
>> +
>>   static void sd_erase(SDState *sd)
>>   {
>>       uint64_t erase_start = sd->erase_start;
>> @@ -1180,6 +1332,19 @@ static void emmc_function_switch(SDState *sd,
>> uint32_t arg)
>>           break;
>>       }
>>   +    if (index == EXT_CSD_PART_CONFIG) {
>> +        uint8_t part = b & EXT_CSD_PART_CONFIG_ACC_MASK;
>> +
>> +        if (((part == EXT_CSD_PART_CONFIG_ACC_BOOT1 ||
>> +              part == EXT_CSD_PART_CONFIG_ACC_BOOT2) && !sd-
>> >boot_part_size) ||
>> +            (part == EXT_CSD_PART_CONFIG_ACC_RPMB && !sd-
>> >rpmb_part_size)) {
>> +            qemu_log_mask(LOG_GUEST_ERROR,
>> +                          "MMC switching to illegal partition\n");
>> +            sd->card_status |= R_CSR_SWITCH_ERROR_MASK;
>> +            return;
>> +        }
>> +    }
>> +
>>       trace_sdcard_ext_csd_update(index, sd->ext_csd[index], b);
>>       sd->ext_csd[index] = b;
>>   }
>> @@ -2378,6 +2543,7 @@ static bool sd_generic_read_byte(SDState *sd,
>> uint8_t *value)
>>     static void sd_write_byte(SDState *sd, uint8_t value)
>>   {
>> +    unsigned int partition_access;
>>       int i;
>>         if (!sd->blk || !blk_is_inserted(sd->blk)) {
>> @@ -2427,7 +2593,13 @@ static void sd_write_byte(SDState *sd, uint8_t
>> value)
>>           if (sd->data_offset >= sd->blk_len) {
>>               /* TODO: Check CRC before committing */
>>               sd->state = sd_programming_state;
>> -            sd_blk_write(sd, sd->data_start, sd->data_offset);
>> +            partition_access = sd->ext_csd[EXT_CSD_PART_CONFIG]
>> +                    & EXT_CSD_PART_CONFIG_ACC_MASK;
>> +            if (partition_access == EXT_CSD_PART_CONFIG_ACC_RPMB) {
>> +                emmc_rpmb_blk_write(sd, sd->data_start, sd-
>> >data_offset);
>> +            } else {
>> +                sd_blk_write(sd, sd->data_start, sd->data_offset);
>> +            }
>>               sd->blk_written++;
>>               sd->data_start += sd->blk_len;
>>               sd->data_offset = 0;
>> @@ -2510,6 +2682,7 @@ static uint8_t sd_read_byte(SDState *sd)
>>   {
>>       /* TODO: Append CRCs */
>>       const uint8_t dummy_byte = 0x00;
>> +    unsigned int partition_access;
>>       uint8_t ret;
>>       uint32_t io_len;
>>   @@ -2553,7 +2726,13 @@ static uint8_t sd_read_byte(SDState *sd)
>>                                     sd->data_start, io_len)) {
>>                   return dummy_byte;
>>               }
>> -            sd_blk_read(sd, sd->data_start, io_len);
>> +            partition_access = sd->ext_csd[EXT_CSD_PART_CONFIG]
>> +                    & EXT_CSD_PART_CONFIG_ACC_MASK;
>> +            if (partition_access == EXT_CSD_PART_CONFIG_ACC_RPMB) {
>> +                emmc_rpmb_blk_read(sd, sd->data_start, io_len);
>> +            } else {
>> +                sd_blk_read(sd, sd->data_start, io_len);
>> +            }
>>           }
>>           ret = sd->data[sd->data_offset ++];
>>   @@ -2805,7 +2984,7 @@ static void sd_realize(DeviceState *dev, Error
>> **errp)
>>           blk_size = blk_getlength(sd->blk);
>>       }
>>       if (blk_size >= 0) {
>> -        blk_size -= sd->boot_part_size * 2;
>> +        blk_size -= sd->boot_part_size * 2 + sd->rpmb_part_size;
>>           if (blk_size > SDSC_MAX_CAPACITY) {
>>               if (sd_is_emmc(sd) && blk_size % (1 << HWBLOCK_SHIFT) !=
>> 0) {
>>                   int64_t blk_size_aligned =
>> @@ -2844,13 +3023,23 @@ static void sd_realize(DeviceState *dev, Error
>> **errp)
>>                             "The boot partition size must be multiples
>> of 128K"
>>                             "and not larger than 32640K.\n");
>>       }
>> +    if (sd->rpmb_part_size % (128 * KiB) ||
>> +        sd->rpmb_part_size > 128 * 128 * KiB) {
>> +        char *size_str = size_to_str(sd->boot_part_size);
>> +
>> +        error_setg(errp, "Invalid RPMB partition size: %s", size_str);
>> +        g_free(size_str);
>> +        error_append_hint(errp,
>> +                          "The RPMB partition size must be multiples
>> of 128K"
>> +                          "and not larger than 16384K.\n");
>> +    }
>>   }
>>     static void emmc_realize(DeviceState *dev, Error **errp)
>>   {
>>       SDState *sd = SDMMC_COMMON(dev);
>>   -    sd->spec_version = SD_PHY_SPECv3_01_VERS; /* Actually v4.3 */
>> +    sd->spec_version = SD_PHY_SPECv3_01_VERS; /* Actually v4.5 */
>>         sd_realize(dev, errp);
>>   }
>> @@ -2867,6 +3056,7 @@ static const Property sd_properties[] = {
>>   static const Property emmc_properties[] = {
>>       DEFINE_PROP_UINT64("boot-partition-size", SDState,
>> boot_part_size, 0),
>>       DEFINE_PROP_UINT8("boot-config", SDState, boot_config, 0x0),
>> +    DEFINE_PROP_UINT64("rpmb-partition-size", SDState,
>> rpmb_part_size, 0),
>>   };
>>     static void sdmmc_common_class_init(ObjectClass *klass, const void
>> *data)
>> diff --git a/hw/sd/sdmmc-internal.h b/hw/sd/sdmmc-internal.h
>> index ce6bc4e6ec..c4a9aa8edf 100644
>> --- a/hw/sd/sdmmc-internal.h
>> +++ b/hw/sd/sdmmc-internal.h
>> @@ -118,9 +118,30 @@ DECLARE_OBJ_CHECKERS(SDState, SDCardClass,
>> SDMMC_COMMON, TYPE_SDMMC_COMMON)
>>   #define EXT_CSD_PART_CONFIG_ACC_DEFAULT         (0x0)
>>   #define EXT_CSD_PART_CONFIG_ACC_BOOT1           (0x1)
>>   #define EXT_CSD_PART_CONFIG_ACC_BOOT2           (0x2)
>> +#define EXT_CSD_PART_CONFIG_ACC_RPMB            (0x3)
>>     #define EXT_CSD_PART_CONFIG_EN_MASK             (0x7 << 3)
>>   #define EXT_CSD_PART_CONFIG_EN_BOOT0            (0x1 << 3)
>>   #define EXT_CSD_PART_CONFIG_EN_USER             (0x7 << 3)
>>   +#define RPMB_REQ_PROGRAM_AUTH_KEY       (1)
>> +#define RPMB_REQ_READ_WRITE_COUNTER     (2)
>> +#define RPMB_REQ_AUTH_DATA_WRITE        (3)
>> +#define RPMB_REQ_AUTH_DATA_READ         (4)
>> +#define RPMB_REQ_READ_RESULT            (5)
>> +#define RPMB_REQ_AUTH_CONFIG_WRITE      (6)
>> +#define RPMB_REQ_AUTH_CONFIG_READ       (7)
>> +
>> +#define RPMB_RESP(__req__)              ((__req__) << 8)
>> +
>> +#define RPMB_RESULT_OK                  (0)
>> +#define RPMB_RESULT_GENERAL_FAILURE     (1)
>> +#define RPMB_RESULT_AUTH_FAILURE        (2)
>> +#define RPMB_RESULT_COUNTER_FAILURE     (3)
>> +#define RPMB_RESULT_ADDRESS_FAILURE     (4)
>> +#define RPMB_RESULT_WRITE_FAILURE       (5)
>> +#define RPMB_RESULT_READ_FAILURE        (6)
>> +#define RPMB_RESULT_NO_AUTH_KEY         (7)
> 
>> +#define RPMB_RESULT_COUTER_EXPIRED      (0x80)
>> +
>>   #endif
> 
> If you are OK, I'd like to squash:
> 
> -- >8 --diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> diff --git a/hw/sd/sdmmc-internal.h b/hw/sd/sdmmc-internal.h
> index c4a9aa8edf6..c115f472efe 100644
> --- a/hw/sd/sdmmc-internal.h
> +++ b/hw/sd/sdmmc-internal.h
> @@ -144,2 +144,3 @@ DECLARE_OBJ_CHECKERS(SDState, SDCardClass,
> SDMMC_COMMON, TYPE_SDMMC_COMMON)
>  #define RPMB_RESULT_NO_AUTH_KEY         (7)
> +
>  #define RPMB_RESULT_COUTER_EXPIRED      (0x80)
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index f8883860fb1..ac8f6b94746 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -119,8 +119,10 @@ typedef struct SDProto {
> 
> +#define RPMB_STUFF_LEN      196
>  #define RPMB_KEY_MAC_LEN    32
> +#define RPMB_DATA_LEN       256     /* one RPMB block is half a sector */
> 
> -typedef struct {
> -    uint8_t stuff_bytes[196];
> +typedef struct QEMU_PACKED {
> +    uint8_t stuff_bytes[RPMB_STUFF_LEN];
>      uint8_t key_mac[RPMB_KEY_MAC_LEN];
> -    uint8_t data[256];
> +    uint8_t data[RPMB_DATA_LEN];
>      uint8_t nonce[16];

You left the nonce length without a constant now.

> @@ -133,2 +135,5 @@ typedef struct {
> 
> +QEMU_BUILD_BUG_MSG(sizeof(RPMBDataFrame) != 512,
> +                   "invalid RPMBDataFrame size");
> +
>  struct SDState {
> @@ -191,3 +196,3 @@ struct SDState {
>      uint32_t rpmb_write_counter;
> -    uint8_t rpmb_key[32];
> +    uint8_t rpmb_key[RPMB_KEY_MAC_LEN];
>      uint8_t rpmb_key_set;
> @@ -1019,3 +1024,3 @@ static const VMStateDescription emmc_rpmb_vmstate = {
>          VMSTATE_UINT8_ARRAY(rpmb_result.key_mac, SDState,
> RPMB_KEY_MAC_LEN),
> -        VMSTATE_UINT8_ARRAY(rpmb_result.data, SDState, 256),
> +        VMSTATE_UINT8_ARRAY(rpmb_result.data, SDState, RPMB_DATA_LEN),
>          VMSTATE_UINT8_ARRAY(rpmb_result.nonce, SDState, 16),
> @@ -1137,5 +1142,6 @@ static void emmc_rpmb_blk_read(SDState *sd,
> uint64_t addr, uint32_t len)
>          }
> -        addr = curr_block * 256 + sd_part_offset(sd);
> -        if (blk_pread(sd->blk, addr, 256, sd->rpmb_result.data, 0) < 0) {
> -            fprintf(stderr, "sd_blk_read: read error on host side\n");
> +        addr = curr_block * RPMB_DATA_LEN + sd_part_offset(sd);
> +        if (blk_pread(sd->blk, addr, RPMB_DATA_LEN,
> +                      sd->rpmb_result.data, 0) < 0) {
> +            error_report("sd_blk_read: read error on host side");
>              memset(sd->rpmb_result.data, 0, sizeof(sd->rpmb_result.data));
> @@ -1197,5 +1203,5 @@ static void emmc_rpmb_blk_write(SDState *sd,
> uint64_t addr, uint32_t len)
>          sd->rpmb_result.address = frame->address;
> -        addr = be16_to_cpu(frame->address) * 256 + sd_part_offset(sd);
> -        if (blk_pwrite(sd->blk, addr, 256, frame->data, 0) < 0) {
> -            fprintf(stderr, "sd_blk_write: write error on host side\n");
> +        addr = be16_to_cpu(frame->address) * RPMB_DATA_LEN +
> sd_part_offset(sd);
> +        if (blk_pwrite(sd->blk, addr, RPMB_DATA_LEN, frame->data, 0) <
> 0) {
> +            error_report("sd_blk_write: write error on host side");
>              sd->rpmb_result.result =
> cpu_to_be16(RPMB_RESULT_WRITE_FAILURE);
> @@ -3027,3 +3033,3 @@ static void sd_realize(DeviceState *dev, Error
> **errp)
>      }
> -    if (sd->rpmb_part_size % (128 * KiB) ||
> +    if (!QEMU_IS_ALIGNED(sd->rpmb_part_size, 128 * KiB) ||
>          sd->rpmb_part_size > 128 * 128 * KiB) {
> ---
> 
> And on top, if you don't mind (but can do that later):
> 
> -- >8 --
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index ac8f6b94746..71f396cb4d6 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -195,4 +195,6 @@ struct SDState {
> -    RPMBDataFrame rpmb_result;
> -    uint32_t rpmb_write_counter;
> -    uint8_t rpmb_key[RPMB_KEY_MAC_LEN];
> -    uint8_t rpmb_key_set;
> +    struct {
> +        uint32_t write_counter;
> +        uint8_t key[RPMB_KEY_MAC_LEN];
> +        uint8_t key_set;
> +        RPMBDataFrame result;
> +    } rpmb;
> @@ -1024,11 +1026,11 @@ static const VMStateDescription
> emmc_rpmb_vmstate = {
> -        VMSTATE_UINT8_ARRAY(rpmb_result.key_mac, SDState,
> RPMB_KEY_MAC_LEN),
> -        VMSTATE_UINT8_ARRAY(rpmb_result.data, SDState, RPMB_DATA_LEN),
> -        VMSTATE_UINT8_ARRAY(rpmb_result.nonce, SDState, 16),
> -        VMSTATE_UINT32(rpmb_result.write_counter, SDState),
> -        VMSTATE_UINT16(rpmb_result.address, SDState),
> -        VMSTATE_UINT16(rpmb_result.block_count, SDState),
> -        VMSTATE_UINT16(rpmb_result.result, SDState),
> -        VMSTATE_UINT16(rpmb_result.req_resp, SDState),
> -        VMSTATE_UINT32(rpmb_write_counter, SDState),
> -        VMSTATE_UINT8_ARRAY(rpmb_key, SDState, 32),
> -        VMSTATE_UINT8(rpmb_key_set, SDState),
> +        VMSTATE_UINT8_ARRAY(rpmb.result.key_mac, SDState,
> RPMB_KEY_MAC_LEN),
> +        VMSTATE_UINT8_ARRAY(rpmb.result.data, SDState, RPMB_DATA_LEN),
> +        VMSTATE_UINT8_ARRAY(rpmb.result.nonce, SDState, 16),
> +        VMSTATE_UINT32(rpmb.result.write_counter, SDState),
> +        VMSTATE_UINT16(rpmb.result.address, SDState),
> +        VMSTATE_UINT16(rpmb.result.block_count, SDState),
> +        VMSTATE_UINT16(rpmb.result.result, SDState),
> +        VMSTATE_UINT16(rpmb.result.req_resp, SDState),
> +        VMSTATE_UINT32(rpmb.write_counter, SDState),
> +        VMSTATE_UINT8_ARRAY(rpmb.key, SDState, 32),
> +        VMSTATE_UINT8(rpmb.key_set, SDState),
> @@ -1130,2 +1132,2 @@ static void emmc_rpmb_blk_read(SDState *sd,
> uint64_t addr, uint32_t len)
> -    uint16_t resp = be16_to_cpu(sd->rpmb_result.req_resp);
> -    uint16_t result = be16_to_cpu(sd->rpmb_result.result);
> +    uint16_t resp = be16_to_cpu(sd->rpmb.result.req_resp);
> +    uint16_t result = be16_to_cpu(sd->rpmb.result.result);
> @@ -1136,3 +1138,3 @@ static void emmc_rpmb_blk_read(SDState *sd,
> uint64_t addr, uint32_t len)
> -        curr_block = be16_to_cpu(sd->rpmb_result.address);
> -        if (sd->rpmb_result.block_count == 0) {
> -            sd->rpmb_result.block_count = cpu_to_be16(sd->multi_blk_cnt);
> +        curr_block = be16_to_cpu(sd->rpmb.result.address);
> +        if (sd->rpmb.result.block_count == 0) {
> +            sd->rpmb.result.block_count = cpu_to_be16(sd->multi_blk_cnt);
> @@ -1140 +1142 @@ static void emmc_rpmb_blk_read(SDState *sd, uint64_t
> addr, uint32_t len)
> -            curr_block += be16_to_cpu(sd->rpmb_result.block_count) -
> +            curr_block += be16_to_cpu(sd->rpmb.result.block_count) -
> @@ -1144,2 +1146 @@ static void emmc_rpmb_blk_read(SDState *sd, uint64_t
> addr, uint32_t len)
> -        if (blk_pread(sd->blk, addr, RPMB_DATA_LEN,
> -                      sd->rpmb_result.data, 0) < 0) {
> +        if (blk_pread(sd->blk, addr, RPMB_DATA_LEN, sd-
>>rpmb.result.data, 0) < 0) {
> @@ -1147,2 +1148,2 @@ static void emmc_rpmb_blk_read(SDState *sd,
> uint64_t addr, uint32_t len)
> -            memset(sd->rpmb_result.data, 0, sizeof(sd->rpmb_result.data));
> -            sd->rpmb_result.result =
> cpu_to_be16(RPMB_RESULT_READ_FAILURE |
> +            memset(sd->rpmb.result.data, 0, sizeof(sd->rpmb.result.data));
> +            sd->rpmb.result.result =
> cpu_to_be16(RPMB_RESULT_READ_FAILURE |
> @@ -1152 +1153 @@ static void emmc_rpmb_blk_read(SDState *sd, uint64_t
> addr, uint32_t len)
> -    memcpy(sd->data, &sd->rpmb_result, sizeof(sd->rpmb_result));
> +    memcpy(sd->data, &sd->rpmb.result, sizeof(sd->rpmb.result));
> @@ -1155 +1156 @@ static void emmc_rpmb_blk_read(SDState *sd, uint64_t
> addr, uint32_t len)
> -                                 be16_to_cpu(sd->rpmb_result.result));
> +                                 be16_to_cpu(sd->rpmb.result.result));
> @@ -1167,4 +1168,4 @@ static void emmc_rpmb_blk_write(SDState *sd,
> uint64_t addr, uint32_t len)
> -    memset(&sd->rpmb_result, 0, sizeof(sd->rpmb_result));
> -    memcpy(sd->rpmb_result.nonce, frame->nonce, sizeof(sd-
>>rpmb_result.nonce));
> -    sd->rpmb_result.result = cpu_to_be16(RPMB_RESULT_OK);
> -    sd->rpmb_result.req_resp = cpu_to_be16(RPMB_RESP(req));
> +    memset(&sd->rpmb.result, 0, sizeof(sd->rpmb.result));
> +    memcpy(sd->rpmb.result.nonce, frame->nonce, sizeof(sd-
>>rpmb.result.nonce));
> +    sd->rpmb.result.result = cpu_to_be16(RPMB_RESULT_OK);
> +    sd->rpmb.result.req_resp = cpu_to_be16(RPMB_RESP(req));
> @@ -1172,2 +1173,2 @@ static void emmc_rpmb_blk_write(SDState *sd,
> uint64_t addr, uint32_t len)
> -    if (!sd->rpmb_key_set && req != RPMB_REQ_PROGRAM_AUTH_KEY) {
> -        sd->rpmb_result.result = cpu_to_be16(RPMB_RESULT_NO_AUTH_KEY);
> +    if (!sd->rpmb.key_set && req != RPMB_REQ_PROGRAM_AUTH_KEY) {
> +        sd->rpmb.result.result = cpu_to_be16(RPMB_RESULT_NO_AUTH_KEY);
> @@ -1179,2 +1180,2 @@ static void emmc_rpmb_blk_write(SDState *sd,
> uint64_t addr, uint32_t len)
> -        if (sd->rpmb_key_set) {
> -            sd->rpmb_result.result =
> cpu_to_be16(RPMB_RESULT_WRITE_FAILURE);
> +        if (sd->rpmb.key_set) {
> +            sd->rpmb.result.result =
> cpu_to_be16(RPMB_RESULT_WRITE_FAILURE);
> @@ -1183,2 +1184,2 @@ static void emmc_rpmb_blk_write(SDState *sd,
> uint64_t addr, uint32_t len)
> -        memcpy(sd->rpmb_key, frame->key_mac, sizeof(sd->rpmb_key));
> -        sd->rpmb_key_set = 1;
> +        memcpy(sd->rpmb.key, frame->key_mac, sizeof(sd->rpmb.key));
> +        sd->rpmb.key_set = 1;
> @@ -1187 +1188 @@ static void emmc_rpmb_blk_write(SDState *sd, uint64_t
> addr, uint32_t len)
> -        sd->rpmb_result.write_counter = cpu_to_be32(sd-
>>rpmb_write_counter);
> +        sd->rpmb.result.write_counter = cpu_to_be32(sd-
>>rpmb.write_counter);
> @@ -1192 +1193 @@ static void emmc_rpmb_blk_write(SDState *sd, uint64_t
> addr, uint32_t len)
> -            sd->rpmb_result.result =
> cpu_to_be16(RPMB_RESULT_GENERAL_FAILURE);
> +            sd->rpmb.result.result =
> cpu_to_be16(RPMB_RESULT_GENERAL_FAILURE);
> @@ -1195,2 +1196,2 @@ static void emmc_rpmb_blk_write(SDState *sd,
> uint64_t addr, uint32_t len)
> -        if (sd->rpmb_write_counter == 0xffffffff) {
> -            sd->rpmb_result.result =
> cpu_to_be16(RPMB_RESULT_WRITE_FAILURE);
> +        if (sd->rpmb.write_counter == 0xffffffff) {
> +            sd->rpmb.result.result =
> cpu_to_be16(RPMB_RESULT_WRITE_FAILURE);
> @@ -1199,2 +1200,2 @@ static void emmc_rpmb_blk_write(SDState *sd,
> uint64_t addr, uint32_t len)
> -        if (be32_to_cpu(frame->write_counter) != sd->rpmb_write_counter) {
> -            sd->rpmb_result.result =
> cpu_to_be16(RPMB_RESULT_COUNTER_FAILURE);
> +        if (be32_to_cpu(frame->write_counter) != sd->rpmb.write_counter) {
> +            sd->rpmb.result.result =
> cpu_to_be16(RPMB_RESULT_COUNTER_FAILURE);
> @@ -1203,3 +1204,3 @@ static void emmc_rpmb_blk_write(SDState *sd,
> uint64_t addr, uint32_t len)
> -        sd->rpmb_result.address = frame->address;
> -        addr = be16_to_cpu(frame->address) * RPMB_DATA_LEN +
> sd_part_offset(sd);
> -        if (blk_pwrite(sd->blk, addr, RPMB_DATA_LEN, frame->data, 0) <
> 0) {
> +        sd->rpmb.result.address = frame->address;
> +        addr = be16_to_cpu(frame->address) * 256 + sd_part_offset(sd);
> +        if (blk_pwrite(sd->blk, addr, 256, frame->data, 0) < 0) {
> @@ -1207 +1208 @@ static void emmc_rpmb_blk_write(SDState *sd, uint64_t
> addr, uint32_t len)
> -            sd->rpmb_result.result =
> cpu_to_be16(RPMB_RESULT_WRITE_FAILURE);
> +            sd->rpmb.result.result =
> cpu_to_be16(RPMB_RESULT_WRITE_FAILURE);
> @@ -1209 +1210 @@ static void emmc_rpmb_blk_write(SDState *sd, uint64_t
> addr, uint32_t len)
> -            sd->rpmb_write_counter++;
> +            sd->rpmb.write_counter++;
> @@ -1211 +1212 @@ static void emmc_rpmb_blk_write(SDState *sd, uint64_t
> addr, uint32_t len)
> -        sd->rpmb_result.write_counter = cpu_to_be32(sd-
>>rpmb_write_counter);
> +        sd->rpmb.result.write_counter = cpu_to_be32(sd-
>>rpmb.write_counter);
> @@ -1214 +1215 @@ static void emmc_rpmb_blk_write(SDState *sd, uint64_t
> addr, uint32_t len)
> -        sd->rpmb_result.address = frame->address;
> +        sd->rpmb.result.address = frame->address;
> @@ -1218 +1219 @@ static void emmc_rpmb_blk_write(SDState *sd, uint64_t
> addr, uint32_t len)
> -        sd->rpmb_result.result = cpu_to_be16(RPMB_RESULT_GENERAL_FAILURE);
> +        sd->rpmb.result.result = cpu_to_be16(RPMB_RESULT_GENERAL_FAILURE);
> @@ -1222,2 +1223,2 @@ exit:
> -    if (sd->rpmb_write_counter == 0xffffffff) {
> -        sd->rpmb_result.result |= cpu_to_be16(RPMB_RESULT_COUTER_EXPIRED);
> +    if (sd->rpmb.write_counter == 0xffffffff) {
> +        sd->rpmb.result.result |= cpu_to_be16(RPMB_RESULT_COUTER_EXPIRED);
> @@ -1225 +1226 @@ exit:
> -    trace_sdcard_rpmb_write_block(req, be16_to_cpu(sd-
>>rpmb_result.result));
> +    trace_sdcard_rpmb_write_block(req, be16_to_cpu(sd-
>>rpmb.result.result));
> ---
> 
> Regards,
> 
> Phil.

Let me pick up and test those changes for v6.

Thanks,
Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

