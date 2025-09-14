Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0488CAC582
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Sep 2025 12:26:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uxlmQ-0002SF-BK; Sun, 14 Sep 2025 08:24:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jan.kiszka@siemens.com>)
 id 1uxlmE-0002RK-0w; Sun, 14 Sep 2025 08:24:18 -0400
Received: from mail-westeuropeazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c201::3] helo=AS8PR04CU009.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jan.kiszka@siemens.com>)
 id 1uxlm8-0007KW-S1; Sun, 14 Sep 2025 08:24:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=in1oMiC98od3xYqjG1RZqXYwVyCtLSoe1oL4Ic2Crj6F8N3Y4VSzIf9BgVMXXs1aPZP+a4MaNOnBYuuA+Om7DKX1ntOXE3FAL+Pl8IFERxUEFxsam3gfED08WUQra83XI5gFayZS4V8xGoHeOF3E2m14Bc9UsbGBYgUykzesH+tUYGYsGtqj6a6gXMaJCe5wuB4AkHGW2ejM71buRMW7PFhmQ+Jg/iBqLudlG5G1WNRaiVi1iPHhZXR4DmJsB0jRhll31O84kMhykBbiFijzr9z7iQxASyChwVVz6EqikRkIsS7QH2rYqQDWjRklBT58qF3Kc7KRhpKqtbtuTWCndw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yCQV3cfivSLJzCUecf4W8ttY3S2YmHq2XuM0H+7cr4o=;
 b=zIBEuHgUswX5nM05ZTb43P0tYXP/Pv7YvKVd045etTcSUxLoU7H/mk0FKzRg3L4+nvzKPvo/Wh51HwEb2nDYv/pHyFP5WFi2zUJkYwFcnprkpEeyS9BTUVrSALlFV1yJXgnJBp6dgmOV6Qnj4xFPVJ1RT8wVXkwk1MuA8+OlxFYXbLb/PgW16uDK23/zOMeSm6lYLzbD2Djs2DMrW1oq0+AU/cb2bt5tFXygpH1WaEJQv+ijVorXmJCA89Ha58TRLeWmZwSnooWhZUw1VTDyRhNAA5vLfZ2HJLrFl272VmaPIyoY3x2hQGVCLBOxRnQ1SUFcmgjw2/PLU6oNE9jw2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yCQV3cfivSLJzCUecf4W8ttY3S2YmHq2XuM0H+7cr4o=;
 b=rpvj4Q7TY8+qzOIcgqJdoBQRDikKGuOc0iG2JY3oC0c3NoWlz43WX9K4pzvfCkVxrXNfjT+2/KA2VkYLOK39Sd0PMoI2bss7o2PaxQ/O0M6RaSxFZaDLhKlSog7+8xte4B38gxByUndcSDkPx+Z5BMLA//pqJgp6j5H8nQ1lo8/6PAGA6so3sMyLVWsVRCKPQLCSVEgmsPq1748raojhTBJgkndCS5XGUlH197G30hdo6aI8vCEMO8Ny4X9+nHThHEsOsxJ7Skj2Aypl//3Rxn60tnN1NCdMhZu9GLKAglh0nuijC4Q86YPz7o9uGZ8QnWwJMRGV/4iRfVm93nW2Ig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15)
 by DU4PR10MB8780.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:55f::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.19; Sun, 14 Sep
 2025 12:23:53 +0000
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286]) by GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286%6]) with mapi id 15.20.9094.021; Sun, 14 Sep 2025
 12:23:52 +0000
Message-ID: <ce1ddb62-319c-4385-a3f8-c1fd36081457@siemens.com>
Date: Sun, 14 Sep 2025 14:23:43 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/8] scripts: Add helper script to generate eMMC block
 device images
To: Jerome Forissier <jerome.forissier@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <cover.1756019920.git.jan.kiszka@siemens.com>
 <c8ee22c72a87c6bd8d9495995868cb22a633de41.1756019920.git.jan.kiszka@siemens.com>
 <891712cb-0dee-482f-888c-2649ae2d4ca9@linaro.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <891712cb-0dee-482f-888c-2649ae2d4ca9@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0106.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:bb::10) To GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:76::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR10MB6186:EE_|DU4PR10MB8780:EE_
X-MS-Office365-Filtering-Correlation-Id: d663e767-abf9-42b4-034e-08ddf389908a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WFVTdE5XU1k4cDQ5SDRmUTQ0WnhhMmtHWjRIcHNONDJReXQzTm5VdjlONktB?=
 =?utf-8?B?NU1rTXJsUjhEUzlSM0VwcjNUZUYralBXdldDNFZ2amJCNmFjUDdNS0ZJRWJa?=
 =?utf-8?B?Wm5lL0Y3SlRvYzdwZWFLYkJNOER6Mm11alRkZjc5Q0RHbzdJVTFoRVFOWkp1?=
 =?utf-8?B?bzJNdWZ1NHFxakxvdXBTYlE0WVVtQ3hmaFlwelN1QjVTSnhvdzh0OVN0MmNi?=
 =?utf-8?B?WWs2MHJiMVRSaDVYUzgyT2FCRUFQbE1KYWhaMDRmZzJLcU5hZldsdXY3TS92?=
 =?utf-8?B?OUR0c3dac2k2RWFOTVlXSWhxaEZzbk9wZ3dqaEw4K2gwcjR0aWt5U2Y0WUxX?=
 =?utf-8?B?RzVoczh5OWxwODI2OFAvbDgzcjZFcnlNemN6REYrZkFpZVRrQmVvcTJMNEE5?=
 =?utf-8?B?UmdPUUM4RDdKTTB1SGhjSlZQZkVDb3U5ZlFjSFZ4bEJ4bk5ubS9BNHA4WUYz?=
 =?utf-8?B?SDZRYStMNEdCb3Ruck5jZVVwa2p2V2hCNEQ2cjBsOVRNTjQrL1dZTWpQL3J3?=
 =?utf-8?B?Qm10RkhQTDJGenZQdzJHTFJ6Z1BSb1FHc0pTUWhrQ3B4NjAwUnQxOTI5WURy?=
 =?utf-8?B?WHhiMHR6b0hmVUVrUkxNaGt6K3I3djRXdDdEWDM4RkxjcnpPMThiOFdYaTNk?=
 =?utf-8?B?ZHlzUUhlMXExUC90Ym4vRXBxSXQzbEwyS2xSUTBCcXJZbG5XM0d0K2c1SDNS?=
 =?utf-8?B?OGtFME81T2RVelJObTkrb0VHc0VyQTBacXY2M1prSkNKbDZwTnh4cUQ4bzlD?=
 =?utf-8?B?Y2w3dWI2WTNKYXJJWDB5S3ROcjZUdCtNb29zUXJZWTZSUmtpaXo4RjFmMm53?=
 =?utf-8?B?Z3RZQytWYTE3L042Y1lQN0ZaWjBUMlRUZ0hDSDM4bU5Fd3FQSE9FQ2E2ZVRG?=
 =?utf-8?B?N2FOaUdRVXlqZk5yU21FbGh2V2hxdEFFRUY2eTlBT0hBNitGOHg0c3JGSGx2?=
 =?utf-8?B?WXVzOEVEM0U5Vm5CTVJmam0xZDJQcDgxV3M1WDE5Vkk4akduTDZlT3lsVFk2?=
 =?utf-8?B?Qk1TbEZpRHBWRmVUa2F0akltSnRPSDdXZ3Q4M0p0aGpUaE9pa2JVM2lMZXNN?=
 =?utf-8?B?Z25zZnRXZTE3bmxpcEdmVWlPMWpaYWgzMXowTnNxaUh0TkIrREo0eS9hbnF0?=
 =?utf-8?B?K1A1dkozVmprcDJLNWUzbktSTGtkQ2pRTk9mby9iZjRXblQ1NkJpUTVSaHl6?=
 =?utf-8?B?WGJzMHY5ZVowU1h4bHlQOUhTQkJFaUw2Rzh4ZnVpUjlwczVISWw5ajNhQmNp?=
 =?utf-8?B?OUhyYjRhOGhhUnpsRjdUVU02Z1k5cm5sUDllQnk5MExyRlU3T24yMXkrYXNQ?=
 =?utf-8?B?bmRDMUtyRlJRcy92Y0lIaG9ZalZ3RjE2bGtGNHlLYjl5bTZFUHFHNlJPMzFW?=
 =?utf-8?B?UEVXQVVwN2JMZWZvWVNMaG5vVU1rQ0dBenRqc3hnUlhVbWNBbnhJdXgwZlA2?=
 =?utf-8?B?T0VWb0lKQXFsbzVrQW5Ydm4reEY5MXV4VnpvNG1xOHI3YVFLM3ByejkzL1g1?=
 =?utf-8?B?S0lIVm5lMVBQYUxoaVgvU3padXdLaDh6VEh0b0wxRENvY0xRUVkvYTZOVisy?=
 =?utf-8?B?UU1RNlZVY3oxREhVcXhSL1J2Y2hXRUtLKy9ES1NaeWc1aTVZcXVTSDcwSGY5?=
 =?utf-8?B?bkhCS3MrNEg3MDBMTndOd3Y4Q2xDekJVYUR1aTlMMFB1czVoOHZRWXRVM3JB?=
 =?utf-8?B?SXIxUVRkd1BFZWZrNFZna2c4bzQ5SGdXL3VtUVQxb0V4S3hGZU83aUUxbDFY?=
 =?utf-8?B?K1pza205ZkdoU1hodnpwbjkwbGx1UmZNaTFUNEprNDVycGNTRjNDL0ZYck5t?=
 =?utf-8?B?bUlhUWVJSjMrYkNFbUhNMWFUYjc2U2tkNFMrK2dlb2xZeUhUL2k1NFFWYTN0?=
 =?utf-8?B?YTduNkYrNHZ2VzRLamJ4YkZhYXNEYTVzQWx4Qzh3Z2tHdmF0REw3Sy83YW14?=
 =?utf-8?Q?O6Q+4T1PqlI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aTF6VVY0MVlqYlZGZTRRcStsZ3M4V1VmdkxyUFJFU1NDNHE1cDJuVXZDd1ll?=
 =?utf-8?B?OFk3VmJ3V2FJcFVMWXE0dm50MjlFSzVVNklJbnlpcEVadVFXVjFJT2F0WitH?=
 =?utf-8?B?RS94ZWZaQWJYWEtDVkI4UUdqSUNBMVR5RTFJWUhWZFQ4aTlzU25MbHpkam8w?=
 =?utf-8?B?cmt5RGszdVN6TmpPK0lIT0s1RWtXK1d6SnIwOVlwTm9hbFNiWjFLcDFiNEtv?=
 =?utf-8?B?VE90M2lobUdQdEFXWm1TYjdsZHphSzVRTHJJd0llK05UajFEdGdiUU1vYkJm?=
 =?utf-8?B?NFRLcDJXSUc2VzNwdUE2N2VLSDljWE52b2ZkbE54c2J5TVF4MkE0a1BadERp?=
 =?utf-8?B?bTlnWCtFRmd0VE9GUEtqOEtkWjk3ZWg5WHp1cGhwK2ZCNVVKS3BJbHdlcklO?=
 =?utf-8?B?cHFPb0VNZXY4RElnOVRxQ3dXYjhaQkJ1MFF5WG5nY1NxY3J3NDBvMTlXdytV?=
 =?utf-8?B?NENoWndSaHM0WkprRWVwbzVFTXpXR1FPYm9KaUxlTXFxYkJsdmlqSXgvOXZU?=
 =?utf-8?B?eWFTcmo1aUtxazEzYXlzME1XbUxLT0ZNRVNxOW5SaFVjMjZQV0tBWTBkbjQx?=
 =?utf-8?B?N2ljWFFoZVROd2hwbjRNTk9MS0VhY3ppWFRxbC94bVQ2dzRBdmJVQ3ZKNWxl?=
 =?utf-8?B?ajlSWWMxWFRLdVhtdTdwazQyL0dQUVVZMVZnd3NhQU9ySkpJQ0gxZTR3R0pR?=
 =?utf-8?B?V3lDeFpmSmlpeFQvSkhiUTFadjFpZ1VkWHNydkRPOCtSUkw0WVBoOHdEeVBY?=
 =?utf-8?B?NldDellPWWxHZ0xhUXJuM1B3b01xRUlCYVM1ak5Gemp5OE9rZWlKZ3BZbXZF?=
 =?utf-8?B?ZnJRMXRqell0VzBGRU9MVWgyN1hKbXRTbnBnaWFKdzkrbURXRUlzY3NOQW1R?=
 =?utf-8?B?V1o4bzM5NzNHSXVGWTNWaWlJR1VmQUpHWkxRT1ZkSUVkNjI5UFpXVWdiMjI0?=
 =?utf-8?B?U3ZGVGhLeS80aS95Tm9PREtmZ2s1RnJKTDNPSGtHQ2NVUHBCdjNYdGc1MTBW?=
 =?utf-8?B?a0QzRDREc2RVOXVib0s2QklIcnFxR1UrbVhudVZVanRlbFZaNjVQR2U4RjJ3?=
 =?utf-8?B?bkFMRnRndVF0ZnVwZkJTVHZTSk9BVkNIbU9BMnNWbHdaT2duaUVWUTkvS2xn?=
 =?utf-8?B?bjV5WmJjRUYxcCtiSklSWER2dzU5VWdBL1p4WmwzRFgrSHQ1ejJsdmtidkJk?=
 =?utf-8?B?a0FuekRpWG96MVN2eU9EZGs2UlZoczliQk1SdG9MZGZ0OUdyeVdzdGRkTXI4?=
 =?utf-8?B?Yy9NT0xidWUzOE9ZYnlGM25lVFdtbTUzZzJmb2h4ZFZYVitKbmovYzBpNThy?=
 =?utf-8?B?ZERwdE1mOWplRnQ2VTJOWXlsWjNaVWxIOTNoOGk5azNKc09kRFZxdjlNbTlh?=
 =?utf-8?B?Z1Rycmdacm9UVnIzSWhLQU1ZVSsxZ1RMZG02cWViRFVVS1JXZFhnQTlieitV?=
 =?utf-8?B?RjlQL2VJcHRGREhIUnhFcEZSMUJuMUpZUnJMSXI2a2J0WjMxQ0NYSnBMTFpR?=
 =?utf-8?B?TFd4QlZONmtXckNHcUJnUFRwL3N4cDFlRUNWZGJROEhUbzBDNFhFVEpPa3Za?=
 =?utf-8?B?ZXpzczRkQjNQenFiR3dsdm0rSmRkeFRCRG1WMzlGVnEyTTZsQ05HL1ByMEFV?=
 =?utf-8?B?VC9WVmM0WWdabVRLbS9QUUxXanJ1WlREenoxcmZFbEEwZWpmQkI4UWlqT0Rq?=
 =?utf-8?B?VzVPZUt2Smo4QUZReVRoUnlabnlzWGhYVmJqRkZWY1M1SjFNcHROc1NCclJO?=
 =?utf-8?B?MTVkZmRXa0pVVVZmOHp5QkhOTEFhYVQrSXZmNVFjZjk4QVhxMVMralRNR0Z6?=
 =?utf-8?B?cHh1enJ2NGsvdU9JZTc3bFFIMjBaOVpIU0IrNUNFeW1YUVlYVy9OeUQzZG5W?=
 =?utf-8?B?L3h3UHpHdjk1NHpCdXkzRlBmOHovN2Z6SytvRVBJOTN6RzJ4QkdOZXNjc1lB?=
 =?utf-8?B?V2t6dlFUTmsydHhib1kwVGpBTWZBY2NOTVkxWFpGTCtWSE0zZTZ2MXJxcEdz?=
 =?utf-8?B?VFNsUkJjendiMSsxRkpXN3haSGFhd3RaQndQVjB6dFVJaCs0dkZkWVRsRENB?=
 =?utf-8?B?T0JjSzd1OTVpb29jN21XcXhCMS9wSjNTRGhZTHpOMnBPdGNUeExud1RYZVNJ?=
 =?utf-8?Q?pIFnXf150Rz9xO8HxXDKhN8Q+?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d663e767-abf9-42b4-034e-08ddf389908a
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2025 12:23:52.7632 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WYKU4AKjmL7taXLJ8oYU4d4E1Pz3A5L4Ja0beHlm87XK+qANWxlhxEkZqkjRbkFpyRZ7qH2WQoDD5Kvf4hvH/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB8780
Received-SPF: pass client-ip=2a01:111:f403:c201::3;
 envelope-from=jan.kiszka@siemens.com;
 helo=AS8PR04CU009.outbound.protection.outlook.com
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=0.91, SPF_HELO_PASS=-0.001,
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

On 09.09.25 16:25, Jerome Forissier wrote:
> Hi Jan,
> 
> 
> On 8/24/25 09:18, Jan Kiszka wrote:
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> As an eMMC block device image may consist of more than just the user
>> data partition, provide a helper script that can compose the image from
>> boot partitions, an RPMB partition and the user data image. The script
>> also does the required size validation and/or rounding.
>>
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>> ---
>>  scripts/mkemmc.sh | 185 ++++++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 185 insertions(+)
>>  create mode 100755 scripts/mkemmc.sh
>>
>> diff --git a/scripts/mkemmc.sh b/scripts/mkemmc.sh
>> new file mode 100755
>> index 0000000000..5d40c2889b
>> --- /dev/null
>> +++ b/scripts/mkemmc.sh
>> @@ -0,0 +1,185 @@
>> +#!/bin/sh -e
>> +#
>> +# Create eMMC block device image from boot, RPMB and user data images
>> +#
>> +# Copyright (c) Siemens, 2025
>> +#
>> +# Authors:
>> +#  Jan Kiszka <jan.kiszka@siemens.com>
>> +#
>> +# This work is licensed under the terms of the GNU GPL version 2.
>> +# See the COPYING file in the top-level directory.
>> +#
>> +
>> +usage() {
>> +    echo "$0 [OPTIONS] USER_IMG[:SIZE] OUTPUT_IMG"
>> +    echo ""
>> +    echo "SIZE must be a power of 2. If no SIZE is specified, the size of USER_ING will"
>> +    echo "be used (rounded up)."
>> +    echo ""
>> +    echo "Supported options:"
>> +    echo "  -b BOOT1_IMG[:SIZE]   Add boot partitions. SIZE must be multiples of 128K. If"
>> +    echo "                          no SIZE is specified, the size of BOOT_IMG will be"
> 
> the size of BOOT1_IMG
> 

Thanks, fixed.

>> +    echo "                          used (rounded up). BOOT1_IMG will be stored in boot"
>> +    echo "                          partition 1, and a boot partition 2 of the same size"
>> +    echo "                          will be created as empty (all zeros) unless -B is"
>> +    echo "                          specified as well."
>> +    echo "  -B BOOT2_IMG          Fill boot partition 2 with BOOT2_IMG. Must be combined"
>> +    echo "                          with -b which is also defining the partition size."
>> +    echo "  -r RPMB_IMG[:SIZE]    Add RPMB partition. SIZE must be multiples of 128K. If"
>> +    echo "                          no SIZE is specified, the size of RPMB_IMG will be"
>> +    echo "                          used (rounded up)."
>> +    echo "  -h, --help            This help"
>> +    echo ""
>> +    echo "All SIZE parameters support the units K, M, G. If SIZE is smaller than the"
>> +    echo "associated image, it will be truncated in the output image."
>> +    exit "$1"
>> +}
>> +
>> +process_size() {
>> +    if [ "${4#*:}" = "$4"  ]; then
>> +        if ! size=$(stat -L -c %s "$2" 2>/dev/null); then
>> +            echo "Missing $1 image '$2'." >&2
>> +            exit 1
>> +        fi
>> +        if [ "$3" = 128 ]; then
>> +            size=$(( (size + 128 * 1024 - 1) & ~(128 * 1024 - 1) ))
>> +        elif [ $(( size & (size - 1) )) -gt 0 ]; then
>> +            n=0
>> +            while [ "$size" -gt 0 ]; do
>> +                size=$((size >> 1))
>> +                n=$((n + 1))
>> +            done
>> +            size=$((1 << n))
>> +        fi
>> +    else
>> +        value="${4#*:}"
>> +        if [ "${value%K}" != "$value" ]; then
>> +            size=${value%K}
>> +            multiplier=1024
>> +        elif [ "${value%M}" != "$value" ]; then
>> +            size=${value%M}
>> +            multiplier=$((1024 * 1024))
>> +        elif [ "${value%G}" != "$value" ]; then
>> +            size=${value%G}
>> +            multiplier=$((1024 * 1024 * 1024))
>> +        else
>> +            size=$value
>> +            multiplier=1
>> +        fi
>> +        if [ "$size" -eq "$size" ] 2>/dev/null; then
>> +            size=$((size * multiplier))
>> +        else
>> +            echo "Invalid value '$value' specified for $2 image size." >&2
>> +            exit 1
>> +        fi
>> +        if [ "$3" = 128 ]; then
>> +            if [ $(( size & (128 * 1024 - 1) )) -ne 0 ]; then
>> +                echo "The $2 image size must be multiples of 128K." >&2
>> +                exit 1
>> +            fi
>> +        elif [ $(( size & (size - 1) )) -gt 0 ]; then
>> +            echo "The %2 image size must be power of 2." >&2
>> +            exit 1
>> +        fi
>> +    fi
>> +    echo $size
>> +}
>> +
>> +userimg=
>> +outimg=
>> +bootimg1=
>> +bootimg2=/dev/zero
>> +bootsz=0
>> +rpmbimg=
>> +rpmbsz=0
>> +
>> +while [ $# -gt 0 ]; do
>> +    case "$1" in
>> +        -b)
>> +            shift
>> +            [ $# -ge 1 ] || usage 1
>> +            bootimg1=${1%%:*}
>> +            bootsz=$(process_size boot "$bootimg1" 128 "$1")
>> +            shift
>> +            ;;
>> +        -B)
>> +            shift
>> +            [ $# -ge 1 ] || usage 1
>> +            bootimg2=$1
>> +            shift
>> +            ;;
>> +        -r)
>> +            shift
>> +            [ $# -ge 1 ] || usage 1
>> +            rpmbimg=${1%%:*}
>> +            rpmbsz=$(process_size RPMB "$rpmbimg" 128 "$1")
>> +            shift
>> +            ;;
>> +        -h|--help)
>> +            usage 0
>> +            ;;
>> +        *)
>> +            if [ -z "$userimg" ]; then
>> +                userimg=${1%%:*}
>> +                usersz=$(process_size user "$userimg" 2 "$1")
>> +            elif [ -z "$outimg" ]; then
>> +                outimg=$1
>> +            else
>> +                usage 1
>> +            fi
>> +            shift
>> +            ;;
>> +    esac
>> +done
>> +
>> +[ -n "$outimg" ] || usage 1
>> +
>> +if [ "$bootsz" -gt $((32640 * 1024)) ]; then
>> +    echo "Boot image size is larger than 32640K." >&2
>> +    exit 1
>> +fi
> 
> Should we warn if BOOT1_IMG and/or BOOT2_IMG are truncated as a result
> of $bootsz being too small? I can see how providing a larger size can be
> useful to be able to later extend the filesystem, but a smaller size is
> more likely to indicate an error I suppose?

Done, will be part of v4.

> 
>> +if [ "$rpmbsz" -gt $((16384 * 1024)) ]; then
>> +    echo "RPMB image size is larger than 16384K." >&2
>> +    exit 1
>> +fi> +
>> +echo "Creating eMMC image"
>> +
>> +truncate "$outimg" -s 0
>> +pos=0
>> +
>> +if [ "$bootsz" -gt 0 ]; then
>> +    echo "  Boot partition 1 and 2:   $((bootsz / 1024))K each"
>> +    blocks=$(( bootsz / (128 * 1024) ))
>> +    dd if="$bootimg1" of="$outimg" conv=sparse bs=128K count=$blocks \
>> +        status=none
>> +    dd if="$bootimg2" of="$outimg" conv=sparse bs=128K count=$blocks \
>> +        seek=$blocks status=none
>> +    pos=$((2 * bootsz))
>> +fi
>> +
>> +if [ "$rpmbsz" -gt 0 ]; then
>> +    echo "  RPMB partition:           $((rpmbsz / 1024))K"
>> +    blocks=$(( rpmbsz / (128 * 1024) ))
>> +    dd if="$rpmbimg" of="$outimg" conv=sparse bs=128K count=$blocks \
>> +        seek=$(( pos / (128 * 1024) )) status=none
>> +    pos=$((pos + rpmbsz))
>> +fi
>> +
>> +if [ "$usersz" -lt 1024 ]; then
>> +    echo "  User data:                $usersz bytes"
>> +elif [ "$usersz" -lt $((1024 * 1024)) ]; then
>> +    echo "  User data:                $(( (usersz + 1023) / 1024 ))K ($usersz)"
>> +elif [ "$usersz" -lt $((1024 * 1024 * 1024)) ]; then
>> +    echo "  User data:                $(( (usersz + 1048575) / 1048576))M ($usersz)"
>> +else
>> +    echo "  User data:                $(( (usersz + 1073741823) / 1073741824))G ($usersz)"
>> +fi
>> +dd if="$userimg" of="$outimg" conv=sparse bs=128K seek=$(( pos / (128 * 1024) )) \
>> +    count=$(( (usersz + 128 * 1024 - 1) / (128 * 1024) )) status=none
>> +pos=$((pos + usersz))
>> +truncate "$outimg" -s $pos
>> +
>> +echo ""
>> +echo "Instantiate via '-device emmc,boot-partition-size=$bootsz,rpmb-partition-size=$rpmbsz,drive=$outimg'"
> 
> That did not work for me. I had to provide a drive name, not the image path.

Yeah, I already fixed that in v3.

> An also create PCIe and SDHCI devices. That is:
> 
> -device pcie-root-port,id=pcie-root,bus=pcie.0 \
> -device sdhci-pci,bus=pcie-root \

At least for the virt machine, just "-device sdhci-pci" is enough.

> -device emmc,boot-partition-size=$bootsz,rpmb-partition-size=$rpmbsz,drive=mmc0
> -drive if=none,id=mmc0,file=$outimg,format=raw"
> 
> I applied the patches on top of QEMU 10.1.0 if that matters.
> 
> Regards,

Thanks for review and testing!

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

