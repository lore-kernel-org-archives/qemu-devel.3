Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A732CCCFA00
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 08:23:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGCJf-0002vr-Ak; Tue, 04 Nov 2025 03:22:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jan.kiszka@siemens.com>)
 id 1vGCJd-0002uW-8V; Tue, 04 Nov 2025 03:22:57 -0500
Received: from mail-westeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c201::1] helo=AM0PR83CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jan.kiszka@siemens.com>)
 id 1vGCJa-0000nf-9T; Tue, 04 Nov 2025 03:22:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IFTN8ppuQccrcwk+rFJJBi+nbc1o7QAy/OIDxTinA7GnLdM4kT7anEsbdDPAmLENsmS5DcKG9cQNDrhjQKKHmgf4YEj/KMZ5S3xDGUcP6xlbeVBYUInj6QQ9dBHgIToMd9DB1HBa4U15a7MTmDdvC6PpcPwtN42n3nJjrjtVLYsbYiT+Aw1vehaeB7VLXUhxhsuzgVnYl4x4ahoqWQxymphOhwIRGhWzsVvCipUElubpvgSNO6ASodciEF8KPwYK6sIEaUo/Cj9U7Y/HjQ3KscJg9rsoiXIw67Yom9r2VvJzRbro7lzXXnbWwLL+ORRT07ubKIhY6KZxvrEZBceWNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SDQn7I2+Aj0AmX71RUDxbXCfyYCl0rIOAqy0Wx0LybA=;
 b=fJSykFFT3+3I/4rUYU05hAosWv8EdlWBNdkp93OXddfgtB63CRWrCuLnkrywBqiwvDW/TUWUb6+rdSnGopRqMJUHMwdPtDvcOF0bZlXhcunhjrqZW5QbvtYKCroZ7AmAmyEXtoH+mW5N8IAIV4MCF3/w59sdx3/1nZhG7ca75quoF2byQkANdLgkoZdkw+3X5RhUp7eRoQWxnfofKZrtealL8i9mvb9pnuDYVEwcnmTBkgoivjycs//wos2DAIDhabxtHyoz61vMEVOb1vRRTYkXFdIgEHVH7UhWx5+i52d0Tz31jewgz+Ng7IwDsSzUnBUa8yvKmnnWgKo5p4FoFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SDQn7I2+Aj0AmX71RUDxbXCfyYCl0rIOAqy0Wx0LybA=;
 b=h6YDxwR7okPvCtmDSkpi/f/R69PpOadBAQ46/53Ngtn334orO3s9nVxdT/oNmZ8/FR2f2mdxYLa0O5cKoqZjYKKLBKoSOP0C26H7DGMcaAn/omZVt/POxmnJ4GxRYJcQ2N6AruFhZ2Hx1wNbgAdPLFIN82DIplYV59zfwZpM2qj8EWLgsGJwiNDNz+AWF1vCPRDwmRYem7u4D+z5dHdJJ5BlvtTLH7ro8SqHHMMV9uvf8mLB/BBXnM1k3RYhJpZ8jOCPuziIWEq7trIUWeDLY54na9LzB1WwEsadSQyB9+6OLYBbGXnBMubkZIBULs+o6IGrB4UVdTS0IIJZcaM++w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS1PR10MB5261.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4a5::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 06:43:09 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9275.015; Tue, 4 Nov 2025
 06:43:09 +0000
Message-ID: <79abc402-7a80-4595-b43d-49cbc37bf7dc@siemens.com>
Date: Tue, 4 Nov 2025 07:43:08 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/6] hw/sd/sdcard: Handle RPMB MAC field
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>
Cc: Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Jan_L=C3=BCbbe?= <jlu@pengutronix.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <cover.1760702638.git.jan.kiszka@siemens.com>
 <30efd95ad5fc54b6afac9d6a0d260c174a6718d2.1760702638.git.jan.kiszka@siemens.com>
 <40ccc01c-0ad0-499b-b2e2-4b5bbcce957d@linaro.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <40ccc01c-0ad0-499b-b2e2-4b5bbcce957d@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0435.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d1::14) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS1PR10MB5261:EE_
X-MS-Office365-Filtering-Correlation-Id: 33dc554a-9e33-4cd4-d742-08de1b6d6b1d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OEY2RHBnb24vaGVxK3RHTjZwUWhBcXh6L2ZWcjJQcjhKWndFdmFYakxGSFRY?=
 =?utf-8?B?Sk1kZ0NnZjdnUnBhZEZlQVhxY29lT3k3ZnhlRmM3VkhieXB3VkdtVFN5OWlq?=
 =?utf-8?B?c2l6REhyVHJXMEE1aWgrdnlrN1U3MEZOb2dDNHg5cG1JQ3VPajNmN3FhbzFx?=
 =?utf-8?B?MEhCUG96OGNBeWZmdDkwVE10bk51MEVrbnVoanV1dmxYUDdwNXg1dDhWN1l5?=
 =?utf-8?B?Uk9Oa3kvOFNOSC9XV2hIYzRuU1NDNXV0OGdublhWRkJ1TW50TUdqMmJiQkFu?=
 =?utf-8?B?ZnlkM2R2N3VqRkMvZDlJOXZEcWlITGxMUVVIVzkzMHR3bkl5RFlNZ2ErTTI2?=
 =?utf-8?B?UVE4YTM4UzFURSs0WUxkQVZNWThNRk82eUdQWDBSOG04SkpuUTlOcGxhQUdE?=
 =?utf-8?B?K1RuMG1aNzRXd2RkMkFiV3BKQk1TMTBGVFVscEo2TFBsM0tBcm5yNHUwbTNU?=
 =?utf-8?B?Tm5OeGp5MHRyS3c3V09pOEU4MFFpdjNVWXhKQ3Z4VXVycnpQTVVEcEljZmN2?=
 =?utf-8?B?eVZKMDVyYUhMNWw0aFMxWUxBU0ZWTlI0amVIcWNTWG0rZXJqVFNtYXpGOW80?=
 =?utf-8?B?TFExVGQrTVNHeUczc3h6VnpodHF1Z2VUSEV2T1Q3NHBlZ1RmdUI4SnhGNFNH?=
 =?utf-8?B?emhaQmpCR09tbEZUSnp5bmltL2hIWjVadlY0WWNyUUE0QmswYmgrRkY3SUtx?=
 =?utf-8?B?WElPRVFEZVFyZDZISnBieWlkVStsZlhDZHJpVUpSZmkzV1N2ZW4zTTFVcDZJ?=
 =?utf-8?B?VVFlNGFaQk5GMktEZHhYRmx3SHRGb081aXpEWW50RkpOWWhjMk05dXBqR3Y4?=
 =?utf-8?B?MHE5aFdheGpZTTNqOFhhb0x5UkFJUGpIVStXUStsdFRpUEdicllRYkMzT25k?=
 =?utf-8?B?R1JoY3N1alpJT05lNE8rSkJQQm00L1EvaUZ5NjY1M3hEK2Y4UU5RTUh3NW5T?=
 =?utf-8?B?cUpzbGV6TXR1R0VYVFBDeUc0YUtrSTJ3eS9YaE5vT3dmSXZkOER4b01VQ0Fi?=
 =?utf-8?B?SG1ya0E2disyVWgwNGtRZGpQNjFPUWZTcDlFZ29YajhkWWthTkRES2k5eElq?=
 =?utf-8?B?R1BvVTBUdEJvbW0xRURKd0VyT2lvZC9RTG5FME5LYlJhRWFMUWtEUTNDUFE4?=
 =?utf-8?B?Tm1OMDQyc2p5RXJWclBKWUliU2drWDl3bTZpMFRJeUIvWXVXODVpVEMwS0xQ?=
 =?utf-8?B?bVFwd0gycmdzZXJBMHBsTjFMOG4vM096YkoyVUR2Y1FZSHFBdnQycEgzRUxk?=
 =?utf-8?B?QW9xd3RBMytHMVNQd1ZkRFB6UUhFY3J2ZEljRWhuR2NtZ3kzSGplQzlzWTVx?=
 =?utf-8?B?TU1INDdnMlRXSzBYVWNDTnFlenRpREU5aUdEbjZyMWZ1QUZTbjdra2JWME01?=
 =?utf-8?B?bUJRSHY1emFOY3VVYWpXbnh0K3Uyb0I3S2pUYWd5V09XcTQ5VWJCdFRjZU5Z?=
 =?utf-8?B?eVlXRmJ3V1p3bld2M2ZZNitjVXpMNFluWmZlckFRTjRoYWRVSkF4eTBhZzBs?=
 =?utf-8?B?QWNBMkJ6SEpYcUdSUjNtQndPMUdIb3NldXFPaUUzbGZBNzJ6N2NXRkZQZUpR?=
 =?utf-8?B?TjRERkJCTHBZcGplZ3JCcUJFWVhTNXJZeUVEOEptU3JQTkVKbUhsUEdwNzBF?=
 =?utf-8?B?eG1zUWw2NTQwbWZHRWh3WjRCR05OTklXbmsyb3B1V3FUdDNKeUc1U25SSGk4?=
 =?utf-8?B?QkRmU2FnRThDVmwrRDRUb05PNURESHBGRFRBNDY5U1hnSGl6VVQvZHhKbXNB?=
 =?utf-8?B?WnV3MmtlTTZ5NFNJbHlFUnNLblZ1dXYybGhsSndhTlA5QWp2L3Z5RDB3VXZ4?=
 =?utf-8?B?RGs2TGJYRXM1SGNMSkxNbUE4ZUxqY0h0amRTKzI1TXhnYzRRbW12NTVaWmxx?=
 =?utf-8?B?N0Z6eWZwTzh3ckd6MjhCYi9DRUwyQm9tTEZOaGVUeWt2b21RSVlYV2c2R2k0?=
 =?utf-8?B?OWFqZ2xGZjZSQXRyTnZITTg3Z0pJeXpoUk9qdnp5cFdBdmNDNEJnc3QyaUhx?=
 =?utf-8?B?akpmSnp3Ly9RPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WmNmcWUxMFc2WXJweGNlOFZaNnFSN3dnNFJ3WW9KTExuVGcwSHIxSkoyWEx6?=
 =?utf-8?B?MUtLMlRaREZiZlBmSXEyOVdMNmI5Wk8ySVZMRzkwMW5Zck1xWGtVZFpuSEJv?=
 =?utf-8?B?N1NVY0pTa3dJUDZMMVFDVE9LUG9jdW9lNmQyUmJWdWZVK0JlNkJGcnRMK2cw?=
 =?utf-8?B?alFOQnRkeXBzTGtIT0VqdjU2TThDbERYYWJINTJZbWV3blkraXNBYW5xN09Q?=
 =?utf-8?B?L081WjN1SEU1Uk9uRXhZYVhXR0RuODlYWGdDKzV4TFdnVkJNbFFib1U4WDFu?=
 =?utf-8?B?cFZQazR4aUp5d2NrMEVtSERXYi9Id2xzM2k2ajk5QzdwQlBBNXRUbmd5T1hn?=
 =?utf-8?B?S2szcFlmOTE0SHV3bkVNdnpHakF0d21oS2p2OFRURGtQTXdvbjdOL3ZkT0N3?=
 =?utf-8?B?OGcydnhFLzF6c3J2WitlbUtWazRGK2gyOVVGc3cxRWxtdGJXOTQ3cXhUdTNQ?=
 =?utf-8?B?QTRTbDMxbmZWZUFzL2dBUzF5VFY1TkpNdldCOXM1Vi9WOXpaTTZzNkJpRFZW?=
 =?utf-8?B?Y296WThxZGlyU2lHTWxXR3BNeXZkRUVmZFJiay90K3ZITGJOclVOdU1naUFM?=
 =?utf-8?B?elB0ZC91NnpCWVV2QVFPMzY1a1g4TnBjQnJGU2EvVlJEWGdGVFpHY2ZIN01K?=
 =?utf-8?B?UXBrdFVIRm9xSzBGcW9WZXVqQUFQdXFCR0V4VXdrdkpCekVKMHhqRFBGajR4?=
 =?utf-8?B?R2dKanVjUHNWQkZvRUVhcENWR3pGK215LzRSUkhkajkySTdsSmRXRUxiMFRk?=
 =?utf-8?B?dVNidUhINjFDZlQ1cFB1VWRObW1lNXF5RU4yc3dEUHZ1aDU0SWRyUzM1Qk5l?=
 =?utf-8?B?QXZvRjk1aDlzL0Q3WjFrVlA3WXVlQlc3dzZSUHFSUXBKdEFSMEJVUUI4SkhM?=
 =?utf-8?B?NENSY1NWZlI1S1R5Sms3dXZDRFVtRlFuR2Nra1owN0l4WFV4ZnZTTXg1S3Qy?=
 =?utf-8?B?WnFNWDZUVG5BcDk0SzhQakkyN0NLRjdqeUplRmRCTjllT0NrUjNsejUzVkt5?=
 =?utf-8?B?OGtXWUR5cU9DYjhwaHRPdm1BTjQrNWZlaEJ5YUI5cFp2Tmx4QmhBVkJsQ3N4?=
 =?utf-8?B?MTZ4ejVJNmx1SUtkSnJXMm1QdjdLNDJTd3NNVmkrbmRhL0hoSzJPUWQ2OEJE?=
 =?utf-8?B?Q2FFV3hsWHllNmdSenVpRU9wdHZpQWV0L2xoNlpUUE9BaVp0b0xZVmpMOXNT?=
 =?utf-8?B?WUM0SDI1VFkyTVhiUzY3Q05zc3B4QlpnTUo5WFpUZ0MzTUllcW9mbkNxSDhz?=
 =?utf-8?B?RVgveGdLYW9hbUh6Y05lVEl4cDdXNUhQa2FwUk5HMEFqU0tGZmpqUnRvUG16?=
 =?utf-8?B?TTBhTjRidVVJQS9BZ1NjWjJ1T2pqa1ZEemhTY1hpS0lBVDVwZHdKazdJazZr?=
 =?utf-8?B?K0NQMUJKQnJWbXQxYVEyTURIekNsRXk5YWw1MzhzWlVlc21FaFcxVHp6aHdX?=
 =?utf-8?B?dUJ2UzlDOG8ybHhTSm9kRmNCUW9ZOUlsYUlZMzNUT2Q0QmRTTmJUdTlvWk5W?=
 =?utf-8?B?OWJTd0U1ZlhzZUgzMlYvMEs0bEtJdXN5SUxHSm5SaFFtNk5sR1FURFVUeXVp?=
 =?utf-8?B?VlRuVG5vc0dnYnZJWmhBNVN2MHpKSVFuTlRSZnE2d2ptZVNUNG5jczVjZG56?=
 =?utf-8?B?clYydHBLZ2FDQXBNTGk3UzVoNHY2aTV2Rk04a05FcmVsUUVvSVRtY2dRbVZE?=
 =?utf-8?B?SytYc3JCZWE5eVk1WURuWVowN3RIYm9WT1B0OHJOU0Q2Z0xUQUFCM0d6K1pm?=
 =?utf-8?B?TmVCYUR6YmpWVS8yL3VDaXNyaGZQOHdzK21QQVpNNElNU25xaXQ5WDdVaU5k?=
 =?utf-8?B?QkNBSXA0VTVtSkEvQ1VwbmRDU3lvSXhjZWFab21yNXhoODdRMjc2MjZDZ1RR?=
 =?utf-8?B?RHgyT2UzdnRSaVNUelg0clFMcVFoaGZ4RUNNZWIzblQzei9zRGxuZkVETFJx?=
 =?utf-8?B?b3Y3OVk1dE1CWWpieFVmL254bmRLeW1WMDhualM4NXBVRWFZRUdQaHQyVDJX?=
 =?utf-8?B?SzBYOC9GaW02eDFocGsxZmNmS3lHZ0piTitHR0Jsajl4VW5HVU15SXRUcG02?=
 =?utf-8?B?Z21UOVVHTU9oa3NWU2hoYjAreHl0NUZoNDdQNXkxMXhIOUhEVkxJYTMwVEVU?=
 =?utf-8?Q?icDejaYKpEiDXFz8xbjV8L/V3?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33dc554a-9e33-4cd4-d742-08de1b6d6b1d
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 06:43:09.7659 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: exB9sWcJAN3/UfLFNDI6LPIQF6In0+aNTlbeNh8ZGB0BgdYVkJQjT31LKkEghgCbvWZCSiU1ou7cKVMozLtZaw==
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

On 03.11.25 16:18, Philippe Mathieu-Daudé wrote:
> Hi Jan,
> 
> On 17/10/25 14:03, Jan Kiszka wrote:
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> Implement correct setting of the MAC field when passing RPMB frames back
>> to the guest. Also check the MAC on authenticated write requests.
>>
>> This depends on HMAC support for QCRYPTO_HASH_ALGO_SHA256 which is
>> always available via glib - assert this, just to be safe.
>>
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>> ---
>>   hw/sd/sd.c | 81 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 81 insertions(+)
>>
>> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
>> index 918fe9f79f..759e284ac0 100644
>> --- a/hw/sd/sd.c
>> +++ b/hw/sd/sd.c
>> @@ -51,6 +51,7 @@
>>   #include "qemu/module.h"
>>   #include "sdmmc-internal.h"
>>   #include "trace.h"
>> +#include "crypto/hmac.h"
>>     //#define DEBUG_SD 1
>>   @@ -118,6 +119,7 @@ typedef struct SDProto {
>>   } SDProto;
>>     #define RPMB_KEY_MAC_LEN    32
>> +#define RPMB_HASH_LEN       284
>>     typedef struct {
>>       uint8_t stuff_bytes[196];
>> @@ -1120,6 +1122,66 @@ static void sd_blk_write(SDState *sd, uint64_t
>> addr, uint32_t len)
>>       }
>>   }
>>   +static bool rpmb_calc_hmac(SDState *sd, RPMBDataFrame *frame,
> 
> const frame.
> 
>> +                           unsigned int num_blocks, uint8_t *mac)
>> +{
>> +    size_t mac_len = RPMB_KEY_MAC_LEN;
>> +    bool success = true;
>> +    Error *err = NULL;
>> +    QCryptoHmac *hmac;
> 
> Preferably:
> 
>        g_autoptr(QCryptoHmac) hmac = NULL;
> 
>> +    uint64_t addr;
> 
> Maybe better named 'offset'.
> 
>> +
>> +    hmac = qcrypto_hmac_new(QCRYPTO_HASH_ALGO_SHA256, sd->rpmb_key,
>> +                            RPMB_KEY_MAC_LEN, &err);
>> +    if (!hmac) {
>> +        error_report_err(err);
>> +        return false;
>> +    }
>> +
>> +    /*
>> +     * This implies a read request because we only support single-
>> block write
>> +     * requests so far.
>> +     */
>> +    if (num_blocks > 1) {
>> +        /*
>> +         * Unfortunately, the underlying crypto libraries do not
>> allow us to
>> +         * migrate an active QCryptoHmac state. Therefore, we have to
>> calculate
>> +         * the HMAC in one run. To avoid buffering a complete read
>> sequence in
>> +         * SDState, reconstruct all frames except for the last one.
>> +         */
>> +        char *buf = (char *)sd->data;
> Why not plain 'void *'? Ah, qcrypto_hmac_bytes() takes a 'char *',
> odd... [Update, now about to be fixed:
> https://lore.kernel.org/qemu-devel/20251103133727.423041-4-
> berrange@redhat.com/]
> 
> Better safe than sorry:
> 
>            assert(RPMB_HASH_LEN <= sizeof(sd->data));
> 
>> +        memcpy(buf, frame->data, RPMB_HASH_LEN);
> 
> Nitpicking, no need to fill the block we'll overwrite:
> 
>            memcpy(&buf[256], &frame->data[256], RPMB_HASH_LEN - 256);
> 
>> +        addr = be16_to_cpu(frame->address) * 256 + sd_part_offset(sd);
> Personally I prefer the ld/st API, and I'd rather see it used
> consistently within hw/sd/. So (matter of taste):
> 
>            block_index = ldw_be_p(&frame->address);
>            block_offset = block_index * 256 + sd_part_offset(sd);
> 
>> +        do {
>> +            if (blk_pread(sd->blk, addr, 256, buf, 0) < 0) {
>> +                fprintf(stderr, "sd_blk_read: read error on host
>> side\n");
> 
> Although a pre-existing pattern in this file, no new fprintf(stderr)
> please. Better use the Error* API, otherwise error_report().
> 
>> +                success = false;
>> +                break;
>> +            }
>> +            if (qcrypto_hmac_bytes(hmac, buf, RPMB_HASH_LEN, NULL,
>> NULL,> +                                   &err) < 0) {
>> +                error_report_err(err);
>> +                success = false;
>> +                break;
>> +            }
>> +            addr += 256;
>> +        } while (--num_blocks > 1);
>> +    }
>> +
>> +    if (success &&
>> +        qcrypto_hmac_bytes(hmac, (const char*)frame->data,
>> RPMB_HASH_LEN, &mac,
>> +                           &mac_len, &err) < 0) {
>> +        error_report_err(err);
> 
> Ideally Error* should to be propagated to upper layers.
> 
> Here SDCardClass::read_byte() and SDCardClass::write_byte()
> don't expect failure, so OK -- maybe they should ... --.
> 

So, leave it like it is for now?

>> +        success = false;
>> +    }
>> +    assert(!success || mac_len == RPMB_KEY_MAC_LEN);
>> +
>> +    qcrypto_hmac_free(hmac);
>> +
>> +    return success;
>> +}
>> +
>>   static void emmc_rpmb_blk_read(SDState *sd, uint64_t addr, uint32_t
>> len)
>>   {
>>       uint16_t resp = be16_to_cpu(sd->rpmb_result.req_resp);
>> @@ -1142,6 +1204,17 @@ static void emmc_rpmb_blk_read(SDState *sd,
>> uint64_t addr, uint32_t len)
>>               sd->rpmb_result.result =
>> cpu_to_be16(RPMB_RESULT_READ_FAILURE |
>>                   (result & RPMB_RESULT_COUTER_EXPIRED));
>>           }
>> +        if (sd->multi_blk_cnt == 1 &&
>> +            !rpmb_calc_hmac(sd, &sd->rpmb_result,
>> +                            be16_to_cpu(sd->rpmb_result.block_count),
>> +                            sd->rpmb_result.key_mac)) {
>> +            memset(sd->rpmb_result.data, 0, sizeof(sd-
>> >rpmb_result.data));
>> +            sd->rpmb_result.result =
>> cpu_to_be16(RPMB_RESULT_AUTH_FAILURE);
>> +        }
>> +    } else if (!rpmb_calc_hmac(sd, &sd->rpmb_result, 1,
>> +                               sd->rpmb_result.key_mac)) {
>> +        memset(sd->rpmb_result.data, 0, sizeof(sd->rpmb_result.data));
>> +        sd->rpmb_result.result = cpu_to_be16(RPMB_RESULT_AUTH_FAILURE);
>>       }
>>       memcpy(sd->data, &sd->rpmb_result, sizeof(sd->rpmb_result));
>>   @@ -1153,6 +1226,7 @@ static void emmc_rpmb_blk_write(SDState *sd,
>> uint64_t addr, uint32_t len)
>>   {
>>       RPMBDataFrame *frame = (RPMBDataFrame *)sd->data;
>>       uint16_t req = be16_to_cpu(frame->req_resp);
>> +    uint8_t mac[RPMB_KEY_MAC_LEN];
>>         if (req == RPMB_REQ_READ_RESULT) {
>>           /* just return the current result register */
>> @@ -1190,6 +1264,11 @@ static void emmc_rpmb_blk_write(SDState *sd,
>> uint64_t addr, uint32_t len)
>>               sd->rpmb_result.result =
>> cpu_to_be16(RPMB_RESULT_WRITE_FAILURE);
>>               break;
>>           }
>> +        if (!rpmb_calc_hmac(sd, frame, 1, mac) ||
>> +            memcmp(frame->key_mac, mac, RPMB_KEY_MAC_LEN) != 0) {
>> +            sd->rpmb_result.result =
>> cpu_to_be16(RPMB_RESULT_AUTH_FAILURE);
>> +            break;
>> +        }
>>           if (be32_to_cpu(frame->write_counter) != sd-
>> >rpmb_write_counter) {
>>               sd->rpmb_result.result =
>> cpu_to_be16(RPMB_RESULT_COUNTER_FAILURE);
>>               break;
>> @@ -3115,6 +3194,8 @@ static void emmc_class_init(ObjectClass *klass,
>> const void *data)
>>       DeviceClass *dc = DEVICE_CLASS(klass);
>>       SDCardClass *sc = SDMMC_COMMON_CLASS(klass);
>>   +    assert(qcrypto_hmac_supports(QCRYPTO_HASH_ALGO_SHA256));
>> +
>>       dc->desc = "eMMC";
>>       dc->realize = emmc_realize;
>>       device_class_set_props(dc, emmc_properties);
> I'd like to squash on this patch:
> -- >8 --
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index f2260796db8..6e4eeeda157 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -1129,3 +1129,3 @@ static void sd_blk_write(SDState *sd, uint64_t
> addr, uint32_t len)
> 
> -static bool rpmb_calc_hmac(SDState *sd, RPMBDataFrame *frame,
> +static bool rpmb_calc_hmac(SDState *sd, const RPMBDataFrame *frame,
>                             unsigned int num_blocks, uint8_t *mac)
> @@ -1133,5 +1133,5 @@ static bool rpmb_calc_hmac(SDState *sd,
> RPMBDataFrame *frame,
>      size_t mac_len = RPMB_KEY_MAC_LEN;
> +    g_autoptr(QCryptoHmac) hmac = NULL;
>      bool success = true;
>      Error *err = NULL;
> -    QCryptoHmac *hmac;
>      uint64_t addr;
> @@ -1156,9 +1156,12 @@ static bool rpmb_calc_hmac(SDState *sd,
> RPMBDataFrame *frame,
>           */
> -        char *buf = (char *)sd->data;
> +        void *buf = sd->data;
> 
> -        memcpy(buf, frame->data, RPMB_HASH_LEN);
> -        addr = be16_to_cpu(frame->address) * 256 + sd_part_offset(sd);
> +        assert(RPMB_HASH_LEN <= sizeof(sd->data));
> +        memcpy(&buf[RPMB_DATA_LEN], &frame->data[RPMB_DATA_LEN],
> +               RPMB_HASH_LEN - RPMB_DATA_LEN);
> +
> +        addr = be16_to_cpu(frame->address) * RPMB_DATA_LEN +
> sd_part_offset(sd);
>          do {
> -            if (blk_pread(sd->blk, addr, 256, buf, 0) < 0) {
> -                fprintf(stderr, "sd_blk_read: read error on host side\n");
> +            if (blk_pread(sd->blk, addr, RPMB_DATA_LEN, buf, 0) < 0) {
> +                error_report("sd_blk_read: read error on host side");
>                  success = false;
> @@ -1172,3 +1175,3 @@ static bool rpmb_calc_hmac(SDState *sd,
> RPMBDataFrame *frame,
>              }
> -            addr += 256;
> +            addr += RPMB_DATA_LEN;
>          } while (--num_blocks > 1);
> @@ -1177,3 +1180,3 @@ static bool rpmb_calc_hmac(SDState *sd,
> RPMBDataFrame *frame,
>      if (success &&
> -        qcrypto_hmac_bytes(hmac, (const char*)frame->data,
> RPMB_HASH_LEN, &mac,
> +        qcrypto_hmac_bytes(hmac, frame->data, RPMB_HASH_LEN, &mac,
>                             &mac_len, &err) < 0) {
> @@ -1184,4 +1187,2 @@ static bool rpmb_calc_hmac(SDState *sd,
> RPMBDataFrame *frame,
> 
> -    qcrypto_hmac_free(hmac);
> -
>      return success;
> ---
> 
> Regards,
> 
> Phil.

Same story: Will pick it up and test.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

