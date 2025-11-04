Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A854FCCFA04
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 12:40:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGGKq-0000vs-NR; Tue, 04 Nov 2025 07:40:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jan.kiszka@siemens.com>)
 id 1vGGKl-0000vD-PH; Tue, 04 Nov 2025 07:40:25 -0500
Received: from mail-westeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c201::1] helo=AM0PR83CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jan.kiszka@siemens.com>)
 id 1vGGKi-0005Vi-P4; Tue, 04 Nov 2025 07:40:22 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U+92GtYMTdegHjU+m8XykQVNSnkd9EwMgg4RhdCQhio3h0lo1GS5pnafcEp/07Zs0+FrFcYE4rhhs3DKPeEGPg9L+C3dwAcMtv1J8z60h8haW7F2MRa0wRFI+SCNU8PKqQBETDBNStWgq5x7EZvQdz6nqAReTvaICn6zfCZE36Le1JmldR5WhAennISq3yAHLwyAfrMhLCCw6s+p2i6wsIfNR2HCYEBqBrOtDLXPQtddgMdS0QBvusn7JdEPTfrnaa0hDICPsHZ4SNIAyjdb5a7vAmWGuvWda9ZXE//T6O/iXgbuq7zpHZpA1ADIGWbiX9aNai+j5u9+nM2w8Z9VHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0rxLSQ9QYUV05AK95iEYhF7WFim1urPbiHTTBC8iyTc=;
 b=AQZ/JjJsKvK/sfi/ci5PRPOsDrfYoT93IRj8JoMIHWtAF41sXSzCQ1IG9C0/LQBGxdcnIKqLnW3L3tVmR2gkO4CZtzwFZhb+SQFRpo2Q58/vRQEqA265X40LRquAK2mw/6doiukby26rXSNCcKwwObO+BJYt36x6V8T2QX8TQ7qISX8cRK9InqBGEhhpmuj6pfPkX9QiP2/2bZh7MIgebuxekY1PK2Q68Fmu49194zAfykelOR0gbquBDegLdjWtO9lbXhPdiXC1Zqg5hhiD4HP34Q4tAF8ENfUNbJ9IhgCLfsCr7tuPAMJTJzS/1fRYlr4pY/3U1ZnxBfuYteF19A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0rxLSQ9QYUV05AK95iEYhF7WFim1urPbiHTTBC8iyTc=;
 b=u/ai8B7JXjSk5iKRhWJGCVqjpRDWSQVYz7Q0GijzJ3oKZ/br6FhGuVq6FIXHJEjxsStsvIT0DTBUVlittCuTpeOu2w6yZHQdfMYzcQc5ox2rsPm1hcqpB4GvlJYdvSDK8h9kSgEOVVqIbz0Lu+9OMP58u002AcYhniguaBt6e9uCxlRZNfAWI2uP1Id3hxGsyY+BfVNfzWeDpjf6DlkHNVCddJ2UlnlPu3PthycEdIZ7NtIu0zleOe72LwbaTtIoEqBU4TQU/iWzM8nlPD/t3vDp3pqK4rKlHA8jcRVFzZtWqFiUgOuupyVaogPbxWAqjkjr/IChh+v286Du25jyJw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB7094.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:42e::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Tue, 4 Nov
 2025 12:40:16 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9275.015; Tue, 4 Nov 2025
 12:40:16 +0000
Message-ID: <55f73b5c-a4c5-463b-a507-6617ebde67b0@siemens.com>
Date: Tue, 4 Nov 2025 13:40:14 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/6] scripts: Add helper script to generate eMMC block
 device images
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>
Cc: Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Jan_L=C3=BCbbe?= <jlu@pengutronix.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Eric Blake <eblake@redhat.com>
References: <cover.1760702638.git.jan.kiszka@siemens.com>
 <5c9c6495ad4afc9d11f856bafcb797fed8fccecc.1760702638.git.jan.kiszka@siemens.com>
 <bfd49f9a-0a37-4e1d-b7e2-f0e59943915e@linaro.org>
 <08287450-4889-4329-b21c-87fde274b13f@siemens.com>
 <b4becb69-cf74-4e1b-97f3-52756b8a69d2@siemens.com>
 <dcb21299-f6b1-489b-b952-aafd64dba31a@linaro.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <dcb21299-f6b1-489b-b952-aafd64dba31a@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM8P190CA0022.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:219::27) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB7094:EE_
X-MS-Office365-Filtering-Correlation-Id: b3ad1316-d12b-47b2-49ea-08de1b9f4e68
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dDYyRllEdjk1ZjJSb0pHZWVuSGZPUU83U2gxM2hzMWRLdld0eTJ4UTg5RWE3?=
 =?utf-8?B?WThRUGFickdGeGVDWDdyTXpiU2Y0UVpHSTBvRktpcVFGcEErejhwTVR6MnR0?=
 =?utf-8?B?Y3hNemkzRG11Y1hkNzZicXA5M0hpUHRQQlhvNklVSk1sdWtGZGR1ZS8rYVg5?=
 =?utf-8?B?c25wcHVaclJ4NTRqZ2ZsTForMDZ6U1JwY2NpME1Pclg3Qnl6OGVvbzlwTFJw?=
 =?utf-8?B?MmwzVGoxNSsrZWZoVHUwaWUyNnRSenJvMWJSNlhlUFV1djB4dUFWRTJ3alVq?=
 =?utf-8?B?RlBTMHNzTGFyMmdBRzdNVFdyQ2JhaVd4QTdzWjZPRjZUM09ZQk5JSldpbWFz?=
 =?utf-8?B?aFczRDRDWUwzNS9QM1g2WlBtMS9SNVNkc2JNTFIrTG12Z2dTRzJySnZkaTVV?=
 =?utf-8?B?YURTdmU3SWJjQ09DQkFLQ3hWbjU5RGZSb0pmRVZmd0VFNzlVS3VsNmVpcDZW?=
 =?utf-8?B?TVlPeDFvMXNFMUhadDk3OWdhbnJSWStadkRBT0ZQeDExMFk0WVdFbWV4eU9W?=
 =?utf-8?B?K0ptdU5mRDZETkd3UzJKNnVveC9hSFRyczRrOGNjTnVDR2puemNOWEIxOVA1?=
 =?utf-8?B?ZVllYm1nTkpITjJ2N2VBREd0RDB2T3Q1K3BmZklzOVZkUS93TmoybGROTTZU?=
 =?utf-8?B?bk5FMTB4R200OURxTmZTcmhPWEg0SFlUSmpSY0FBSUlhcTRDN0c4MkNyVGd1?=
 =?utf-8?B?U1plK3RzZ0xTNnU2UGNlNDAyVEViKy9KRDN6QTJnYkxybU83SmxaMWc4Ymto?=
 =?utf-8?B?Sm5Ma0Z6WUVCRDMyYytpbyt6N21DVmh5UkdjR2VxbG9Va0Y1M01yVEsvb0hT?=
 =?utf-8?B?MVVhdnhHQnlITW1LQzFicXl6aHVtdG5scy85MHI4dGpNSitZb08xQy92Si9n?=
 =?utf-8?B?aGU0R1VlRk5oNGJPa1JKUkt6V2xRUTYvUVowd2Y5Qk5LMDJuaU9WMkZVYjhh?=
 =?utf-8?B?U3Z1cHY0Kzg5WGFpR1RJR2hHQ0FlOFlDN080V0NEVmdibFAwbTBSRmdURjNL?=
 =?utf-8?B?cVRFdlVpU1ZQcGFrL3RpZVVFTGxQR1R3SUI1MXZTdk5PYWlxZTJBa3g5eFFj?=
 =?utf-8?B?UzJHMm5yN2ZKTjg1RUNiMXFkeWY5VkxZbkNnSjFaTlp1eXYwOVBycm9mbjNX?=
 =?utf-8?B?Q0JobCtseDE2djlwa3c0MGRJeEZQMzBQeWJVYmJjdlByc3Noemgyanhsa1ZU?=
 =?utf-8?B?RzdNZVBTdUk0dnVOdGZJdXN5a2ZkbnpVQlBMSk5tT01Mb2lyL0RoTnVRMWk2?=
 =?utf-8?B?RjVkOTNzTEdhTDBHZTFFZUJONXVBaDdOYVBIZlcvZmVJb0kvYkxYSXZNbkVz?=
 =?utf-8?B?bW9YeVN5WmpyUTVjWVZTa1V4Q1AwaDZPTjJkSjlWa0s3aWxHRk9uNUExSnlN?=
 =?utf-8?B?cC83czNyVTVBNVNQWHhpZ1RjdllrZEJvWTdtOGhPc1ArWnJBVUNMQm1oY2J2?=
 =?utf-8?B?QnZQVXBpV2l3RUtOYVpPS2lYcnYzS202TlY2dldaYUsrMlNaUStEbWVXSXVY?=
 =?utf-8?B?eUpKam9jOHRJTy91NzNvMkN5RUlncHJuN2FmUDVzaUYyRVhZUzgrZFc0b1Zt?=
 =?utf-8?B?aDk4RkRsN1FGRVJFMWlnM2VIaWJXT0E2Ry9oVXhHbXJtRTE4RnE2aTA1Nzdx?=
 =?utf-8?B?VnlpU2Z1ZDhaLytlb09IOGptVk9ndmYrYWE3VWxQM3I3V3J1dTZnOTRENURy?=
 =?utf-8?B?cElVMzZGSE14Q0dtN1l2N1gwSm5OUTVTZkp1c0c1UldqSmhHWDhjdVBDWFRo?=
 =?utf-8?B?S3o5QVFVSml2NEM2Sm5HQW1hWHhMMzdrTlFTS0RqclZrWUhwanc5Y25wdDda?=
 =?utf-8?B?RWcvVldHUWs5b04yaDhXRTRJcjJUYldUdEVJQ3REQzl4WnQxM3ZndVFlbHV3?=
 =?utf-8?B?eUJnc25KbXZUR3VpSkJJNCtKakk0V3kzNnFVRkVlSUpaZnlWeWtYVzRERFpI?=
 =?utf-8?Q?xRiyz1il+NK45c6Sg3ZhPE8uIlJPrfK1?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MHVCcEFITUw0c2pjSVM5Znp6VGZnUG5IbWYzcElVMlVFclREeEhrSyszVjMy?=
 =?utf-8?B?TnpDN1JqcVpPVkJQKzBQOTBkRG5zUUt3SkF3WGplUUIxTGtIaGNwMzFlNjZD?=
 =?utf-8?B?ekpxTDZjR2lCK2I5MmplZ3lHRGJTdjBTbXAza0xUUE0xcnpBRjRQRDZUcm1I?=
 =?utf-8?B?cTdRNTFkN0U1eGdNcFZONHNyeXNwU0hldnpaMDNFc21aZmt3ZDZ1bVJZbTFR?=
 =?utf-8?B?MDIyc0ZJaEk0dW1ZdHBuSmlMamxzaWFzdFRMSEIrdzV3YVNmUVpyZys1YTFX?=
 =?utf-8?B?MkNHckxORnNhdHZGOWZCVEU0UDgzSnJxa0czZkkyU2E4dWplUlVSUnZFRFNs?=
 =?utf-8?B?bDVCMUtNOWRvVGhPbC8zb29vb1BuN29wMnpMaEhUR2k0Q2pNeE1JdmthS1VH?=
 =?utf-8?B?VTlmYVNad3NsZEpDMjY4WkppeGVyODVWWUR1RmNDSVB1eE9YNEFMODNrdlQv?=
 =?utf-8?B?S3VLdnptcnZsR0RJVkVIRGFzRVdlemxWYTk5YnE2eFkwTEMrQm5Dbm10NWE3?=
 =?utf-8?B?YVBPUlJ4QmN1L3dGYk9kWFpYWFZQajl5anpKYWxIa2NuamM5ZENFdHczVjFB?=
 =?utf-8?B?aWhmZmlEMDY0VHltWVM5eHN4TkNtNWNtdFptaGpmWEJEN1F0ZWdxSjR2N0ZQ?=
 =?utf-8?B?VkxSZFEzSHNhWWpPY3hoWEg5dFQ5d216eTdGRDMxWjlPbWJvcitPWlN3Q1c1?=
 =?utf-8?B?eEEwL0pIRWhjdlNzZDdTaVZKNEZ4WlRJMDJ1Q2NsWC9ieGhSYmI2blJOMEJp?=
 =?utf-8?B?bVVmTjcvd2poYjFmVHJQTnBxMHoxZHEyTzRRMTduR092TkI3dUdjTEhMYjNM?=
 =?utf-8?B?TWp6bXIzekh4eVd6eG43bU50akg5ODZSQTAxemd0VWtCdklWUVNkNlFiSVE2?=
 =?utf-8?B?MnpGM25wVUVuZVN3YXR4QkppU00rZG1SKzZEdTlTWGp2Nm9KekxSV29aN3Rx?=
 =?utf-8?B?RXpPM3dya0NhVlFQTWYxWTRzQkpTWlphZ1R1cStvVzQzNkJONjU2eldIcG1I?=
 =?utf-8?B?enJleXZqc1JwbmMwNGdtTzFacGpYcW1KK1V6WlpxVm5uaXlpQUdiUnhoUHUx?=
 =?utf-8?B?TmxCa0p0a29yaEZPbnMzTlU2T2t2ang3Um02RzU3bHNHWHE0OHFBeCtBbEZr?=
 =?utf-8?B?bXVvc1VkVnF0UVdTVjhIc1dTNmFvdk9ML0lBQ2JnclQrb1RiT243d0swWElj?=
 =?utf-8?B?Z2Fwb0RIOU1vZk80YzdyMUx5REFuS0RpbllMN2ZtZmRxSnBjSnhMN3dtNnVP?=
 =?utf-8?B?UFRFRDRwSHZrWmdXQytXUkJqc2d5dG5Lb1JMV0RUT1JYS3J0YXVSVnlEQ0cr?=
 =?utf-8?B?Um5OcFZWbU1JaGFDTjUvTTYyWTBVc0J0NTNrVEpFMXRLTk1rVllNaERFejdm?=
 =?utf-8?B?NTZqSHdudm9WM0l3YnZQWXNkYnd6cnMvVWlERkVGaloraW5DV2dJaytwNjdr?=
 =?utf-8?B?OWRCVEFuczFuZmx1bmhZOUQ4S050eEIyMHErckJTTitLcXFUay91dE5xSTFy?=
 =?utf-8?B?WmVBbEt4Y2xJQXl6YWhvMkpXRVVTeE1iWnZZT1JaL044ZVZsbnlVQmNETnFM?=
 =?utf-8?B?WkVYa09vQ0c3WU9CeWpBUEE1dnhQdlluTm5XdUZvMnZIQi9FbDRiczcveFZ3?=
 =?utf-8?B?NUhRRlM5b3E5WlpPWUV1YjlHajRRWUZiUjZBRVh4cllBQUV3VnZzUFIxV0V2?=
 =?utf-8?B?WTE3YkdUY1h3a05aL0hJT0hqdzNrZjZveldjSnp2NEJaazVyQjVvSEVjczVZ?=
 =?utf-8?B?N3l5cklLOExERHQ2VitOellsdmNLTGh6NWVFcEFkbUFVUXBQb2N5d0VNLzR6?=
 =?utf-8?B?MDgwaHZ2SHB4eVV1aTdPVVRtbUtST3dGc096aUtWRE5sSHgxOU5PZGFIcy9L?=
 =?utf-8?B?OHlZbW1kSEZTRzQxUmZJOVRxSW1NL3VydFlORmRsaFBOWm1hZktnTXphQXRO?=
 =?utf-8?B?YmhQbW1CYXFIcEhwU3o4TWVUdDROMFpEdGRNV0hvWHlWMlUyWkdxbkR5SER2?=
 =?utf-8?B?NXlscCt2UzNMM0c3bms2K1IzYVBwZjFyeDA5Rmd6TmZnei94blUycm11S2hB?=
 =?utf-8?B?TW5ocXRpTTdVdHRYYTNxemhwU3Y3SndrWFFPNUZvQkJkY0hONk9VTWRJM01q?=
 =?utf-8?Q?q5DHmeKMHpBFCz+mv3VnHPrpl?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3ad1316-d12b-47b2-49ea-08de1b9f4e68
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 12:40:16.4712 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sY+oUHQGHR0LYNs0dMGXGxYZOaM3JoiMo8azZ3jf1tshf7R7eOrHMAzt1C1PVYP2FldK36SGm/9ubSfXg+ZcNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7094
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

On 04.11.25 13:33, Philippe Mathieu-Daudé wrote:
> On 4/11/25 10:26, Jan Kiszka wrote:
>> On 04.11.25 07:30, Jan Kiszka wrote:
>>> On 03.11.25 14:12, Philippe Mathieu-Daudé wrote:
>>>> Hi Jan,
>>>>
>>>> On 17/10/25 14:03, Jan Kiszka wrote:
>>>>> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> 
>>>>> +if [ "$bootsz" -gt $((32640 * 1024)) ]; then
>>>>
>>>> Running on macOS:
>>>>
>>>> scripts/mkemmc.sh: line 165: [: : integer expression expected
>>>> scripts/mkemmc.sh: line 169: [: : integer expression expected
>>>> scripts/mkemmc.sh: line 179: [: : integer expression expected
>>>> scripts/mkemmc.sh: line 191: [: : integer expression expected
>>>> scripts/mkemmc.sh: line 200: [: : integer expression expected
>>>> scripts/mkemmc.sh: line 202: [: : integer expression expected
>>>> scripts/mkemmc.sh: line 204: [: : integer expression expected
>>>>
>>>> $ sh --version
>>>> GNU bash, version 3.2.57(1)-release (arm64-apple-darwin24)
>>>>
>>>> When using dash:
>>>>
>>>> scripts/mkemmc.sh: 165: [: Illegal number:
>>>> scripts/mkemmc.sh: 169: [: Illegal number:
>>>> scripts/mkemmc.sh: 179: [: Illegal number:
>>>> scripts/mkemmc.sh: 191: [: Illegal number:
>>>> scripts/mkemmc.sh: 200: [: Illegal number:
>>>> scripts/mkemmc.sh: 202: [: Illegal number:
>>>> scripts/mkemmc.sh: 204: [: Illegal number:
>>>>
>>>> Should we replace s/[/[[/?
>>>
>>> No, that would be invalid outside of bash. There must be a logical
>>> error.
>>>
>>> How did you invoke the script? What was the value of bootsz then?
>>>
>>
>> I tried with dash from debian trixie, and there is no issue like yours
>> visible.
>>
>> What problem could macOS have here? Will need your help, don't have
>> anything mac-like around right now.
> 
> Don't worry, we can merge v6 code part, and add the script / doc
> during the freeze period.

I will send out v6 then. It passed local testing, and I addressed some
further details.

A colleague with a Mac offered to have look tomorrow on this. It is
always a pain there regarding the subtle differences...

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

