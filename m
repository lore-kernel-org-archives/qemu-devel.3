Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 759A8CA0EEB
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Aug 2025 16:04:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1up7la-0000J8-Fk; Thu, 21 Aug 2025 12:03:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.hofhammer@epfl.ch>)
 id 1up7lN-00005c-9s
 for qemu-devel@nongnu.org; Thu, 21 Aug 2025 12:03:44 -0400
Received: from
 mail-switzerlandnorthazon11020113.outbound.protection.outlook.com
 ([52.101.186.113] helo=ZRAP278CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.hofhammer@epfl.ch>)
 id 1up7lL-00012q-AH
 for qemu-devel@nongnu.org; Thu, 21 Aug 2025 12:03:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WQpmUgoVDY3w0UMg0BxCKq5Ja0jbbt1RTH1SbHCKR3SCZpyUY43P1ofN1fspm2f/NRYF/vQ6ebjOXITl2UMZnizEJCqByq/uDOHEjd+vPLJ03Sxoxan5c/rIxW0AH3fcavq+ms5miPooxtPzeYOvzMK87MWimdtlRGLvnHYueVXfAgscQAOVzVqgHFrQkoTvYGSASPDn/5jLE8DfTnzmHw5pgqsrqvNwgS5nMETnRsQ6w3GjwIVvi96xb89Yfzx64k4RVOoI4i9fKzzz1aALupZtW3XGtSHxjLtdQ8+B5QV4G5mt5thP4ja0bGvjOHNQFdUaTUPdkKPfNEONpDVmQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zx5MzP+CGw8kUcUHla1D0+AVSPFi6V6G5ND4Ift8ZBI=;
 b=NfNMZhz+bCK21/cTaW6Bibu6eXfWL/vUBFQyBeKFz2tbi2aNMmHkDcTzdMKgJXiFsKOac892WV40oePMNwQh/R3GfuekFFaeWe4/8Ucvww7VmhJ21KeXeZPZanbQBoFhU24fw2oCS6X6AS2t0DerOqNitEYZyJQNTx1Eqpvg04kOQ0y3CwdrtwVDWZSLWRie9el6snG8jyK/gdMc0/zx8yWq0q14z3y71CY1b5ApRjgzCvlHy1ct9cRCS1W6qwDkffRn6ziQ3tujZ5DjOqWaFo9ld3AyweEXCK6oiEvDP0j0Lhg2sE8tAXz93TDOlNlHNGJRmiAntXWU2RiQ+oLrQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epfl.ch; dmarc=pass action=none header.from=epfl.ch; dkim=pass
 header.d=epfl.ch; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epfl.ch; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zx5MzP+CGw8kUcUHla1D0+AVSPFi6V6G5ND4Ift8ZBI=;
 b=og9GcDADkf4DitEFNgdCTHB5fuH/O+SpQ7U5LWQ/rwr7cISBMUzmGyrMHQO6qjobJKSIJPkeg+GzRBmcP2Stu/JH5GaGdU14C1w3XQdrmQXTVl7P0mC5upUES4UT0f7oNxsUvpYC8DLLAiaD2lO1qj4yipgnyzZFhgqYZT0Dcr8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=epfl.ch;
Received: from ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM (2603:10a6:918::220)
 by ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM (2603:10a6:918::220) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Thu, 21 Aug
 2025 15:58:32 +0000
Received: from ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 ([fe80::781a:c3f2:3706:82d]) by ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 ([fe80::781a:c3f2:3706:82d%4]) with mapi id 15.20.9031.023; Thu, 21 Aug 2025
 15:58:30 +0000
Message-ID: <729dbc9c-d2ca-4c39-ae87-699780092996@epfl.ch>
Date: Thu, 21 Aug 2025 17:58:29 +0200
User-Agent: Mozilla Thunderbird
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Warner Losh <imp@bsdimp.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <205e6753-53a4-4739-99ed-26344403a437@epfl.ch>
 <87tt2n5az1.fsf@draig.linaro.org> <aJItXiCESEAPDzec@redhat.com>
Content-Language: en-US
From: Florian Hofhammer <florian.hofhammer@epfl.ch>
Autocrypt: addr=florian.hofhammer@epfl.ch; keydata=
 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
 5hMMZIzTI4AtIcgA3xe4Ew==
Subject: Re: New capabilities for plugins
In-Reply-To: <aJItXiCESEAPDzec@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV0P278CA0046.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:29::15) To ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:918::220)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZRH2PFAD84B9AF9:EE_
X-MS-Office365-Filtering-Correlation-Id: a8200454-868e-4637-e2da-08dde0cb92ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|366016|1800799024|19092799006|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?c3NtSFo0WDhybGdKUVE4MitYWFhHTFEvVTBidzhnZzI1NllwQyswTzNJVEpk?=
 =?utf-8?B?RFdQUGxGMUdrQUI2NVExTkRyVGdkaUNabnRYbTFmVGdhaDJMdTBaUytidUo0?=
 =?utf-8?B?UEQwb002NXIvRklzK1JqTUJQQjdxMzdYRVpIYlJhbExNanhkUVVFRFhJM3RD?=
 =?utf-8?B?eGcyZTgvR05hK1JTd2p0c3BMSitMWXdld0F3TGdyWVpkRmw4dlpyQ0g3cUll?=
 =?utf-8?B?OEI3c2E5NDFHR29uSkpLZUJVb2lYRnlmOWExSHZvYlFqM3h4aUU0TWxSUEhh?=
 =?utf-8?B?ckVwVkhrb1dhNXV3cHQrdFB3b1Fnd2dYVGFvSCtVSVVqUHVmYmI0QUVmaTla?=
 =?utf-8?B?d0tubjFCcXFaVFZqUUlkZEcveVd4OTQ1YVlCMlRTUXIzc1VhVFV3elpPZG9O?=
 =?utf-8?B?SS9zL2lyOHRlS2JuUXNKQTZFVDlOaGM1akJKL0FOK04rTWltQVlqSFpVT1Rk?=
 =?utf-8?B?MmhYRHNJTWpBeXd5Tll4NGtkZEhIdGJCV2JINVB2M2daSExyQndTT2dFclVv?=
 =?utf-8?B?MElKZThCMHhjMWtadjZURUcyekxmbWh5RDdjcTNkUjkrQWY4YTBueEdKYnhP?=
 =?utf-8?B?U2lZamhXcnVyaXFvTFo3b01uNzFHVHpiUDllMk9aSlJHYTZHZHdWYjNsWTFt?=
 =?utf-8?B?dUNnTzVZWTVjeks0ZEFLRWd3Wit1dlV1TWdQb0FISnJQYVdvR0ZCQ1d1bmNu?=
 =?utf-8?B?dDVjOE9NYkR1N0VuR3JJYW9SMU04M29CRFJGakNVV3lXOWlyUndFaVNjcWI0?=
 =?utf-8?B?NGo5MzJPT2FyRS95SFd3ZzFqcTloSnJwQTBZRVgzanVMVkV5MFo4WGlva0Fk?=
 =?utf-8?B?aHdEUUhoZ2d4RDlKZWtIblJ2VlBvNlhvZXB0a2cyY0JTRjY0N1lEMmVkclJk?=
 =?utf-8?B?a0tPVTBSTm1jUzk2SVB4NjBJTjZMYW5hSUJuVUtBVThXUkcwMDJOcUhtZ1hr?=
 =?utf-8?B?SHQ4M1VIMFBKam5IZHpNaURaQnNoMHRVQXZWVWQ5UlowVGF5N20vS2dpNisw?=
 =?utf-8?B?cmNsSDVad1pETDFVQnJGSUREM3lzK0poUVdMWWNrUWNFYnJQS2NlVzF6dndm?=
 =?utf-8?B?aVVaaGhxeFkrRDErb3pNVDVQREJPLzREYXpvcVM0MzZmeU9iS01WQzlTMTVY?=
 =?utf-8?B?QkNmVVRja3cvSzQ0VFNHMnRORHVCWnduODM3VDJ6M1Frd25NRnljZEI2aHdP?=
 =?utf-8?B?cjZRRS9GbzdxZkIydzBRd1lCUms2TGxWUi9WcVVJNkwxWmM0UGljcDVEWUZQ?=
 =?utf-8?B?TFFXOW5WNm91cFNlRGVZaTcyQjMrNkhnMjNTL093aWNwRnJ2ekNpNEJRQkRy?=
 =?utf-8?B?bHRNN0pUZlVleC81RldWNWN2dStSU28rUTdaNnVROXdIaVRCT21jczd4QjZt?=
 =?utf-8?B?ZmtjSG5aQU5RWlVPWlBCZUN0M3NIcG9USzhoZ0J6TFB0L0s5ZVRaMHlTZXBT?=
 =?utf-8?B?ckV4UitpaUVGVmxkek9KWjhWaC83eW9TZmxscXRLQUZPQnpML1I1WnhqSEI0?=
 =?utf-8?B?eTNKZEJpbXY0b1BLUDc5MTdKQ2lSTmllVzBkYmhIL0FHZDgrdmxIS0UxbjlY?=
 =?utf-8?B?R3UyRGoyMmlSWDNqeGw4TmNlZEdEUGFWWEx6UzFoeDJNSjZuM2QwVFhrRUxM?=
 =?utf-8?B?Mzl4NHM2RGpFY3NEM1JhV3hUbFRIaEl6L0gyUSt2TlRqSmwwZDBoUml3Nk14?=
 =?utf-8?B?NDI5ajVNU0hLdXAzZmIrUmtVc1c5VFViYk5VUFl6V1JvWm5kR21zWkV2YzNl?=
 =?utf-8?B?WFlkNGNZeGZyYUdWUmlvRWN6bmxKVWh2a2FGRTdjK3dGR2ZrV0h1YUE0WHZ1?=
 =?utf-8?B?MFhHd0pmVGJ1UmdOcWJnN3Y3Z3U1Syt2Qi95N3UvSklsTDg5TnZOcTd0VEdY?=
 =?utf-8?B?QkE1ditraTBxNlhPdnFJOUZJc0R6WkJGT1EyckRVbkRDRXlOZTNCNnM2bW4r?=
 =?utf-8?Q?drj3dIo4WxA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(19092799006)(376014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YXZWYVdVT2FzTTVGQXNzZnVyQi9jek1nMFF6ckUxcS9VUVhsSnpsSDdycnNa?=
 =?utf-8?B?Qy8xbUhJVTVFRmdmcGVRSnUxRkZFOXZHRnJ0MHVLdit4TmlOMlRua2p5dlFV?=
 =?utf-8?B?OHBUZ3BHM1VvWVRRNzY1MGRiaWVaamxMeXFpeFh5SHRJUXQvZ245ZGVhUW9R?=
 =?utf-8?B?NitISWdqQVgwelZQMCt3d0hWaTFJMmRRWnpNOGkwZm5hV0FFRXRFTGYyN1Nh?=
 =?utf-8?B?Ty93YVBwZnFvT0xGQncvL1R3L01SVXZSSWdxN25EVU9lcUxNdnp4NXQrQXpz?=
 =?utf-8?B?V1M2ZDk0dHZwOFZMbmJlSVBRaXVZc1EwZVpRMHJGY1MwN1hRTURiU3htS3hY?=
 =?utf-8?B?ZFh2QS80d3VXQUJkYk5UQjRwYk9USFA1SituYzlwQXU1ZENub3ZEU0kxUEE5?=
 =?utf-8?B?OHdsYzFxV09wajVmZnIvUzk4a1V6YmgxcVJpOXMyS1lKQm5OdFpxd0pSTjRM?=
 =?utf-8?B?ZE9hZ1J1QjhVMThRVFBCaXp6cUIzUER1eG8yRU5wUVpFUG5mUy9MVHY2T3Nn?=
 =?utf-8?B?cCtCK3ZzM3pieGEvS2d6WnQ1UGZEOW12M01CQ1ZqSVZvTFMzdlJLSjlGdHQr?=
 =?utf-8?B?V3k3M09EVHA4c280L1h0SnBKdE5tdjZ3UkxMRWRpeS9vcWJ1dS9oeDRjK2Yy?=
 =?utf-8?B?Zkt3RlpMMjJxMHd5UmVuVTNlMzVySjRKOXJwRkphQnh1OTlUd1JLU0NrOXBT?=
 =?utf-8?B?YVZiL1crL0JDenRaalJzYm5LSERKS09ia3Z2NmZNRzg5QytPYnQ3MXdad1Ax?=
 =?utf-8?B?R2dkdXZBd1pzdG01eHh5RFFVdDUwdXRWR0YvUGNEL2pkWGd1WnlERmhmcHFs?=
 =?utf-8?B?Ry93SzFQNlZwTXdXbXdXNW1LNUI0QTNvMk96d0pEc3l0ZFVKTXJyekYwc1k2?=
 =?utf-8?B?YXI4cG41dm9wakdvM0VVZEluUkJBK2lhLzRWd3dLOXVkNFRZQXZkeG1CT0N2?=
 =?utf-8?B?VUNCWWJZUFhsamFHVUpIMFdVTzlmY09DNjBEeitvaGxFL2NPOVRhTjRuRFov?=
 =?utf-8?B?MW5yZWVBa05PMHBJMUtYc1pJOW9CSjVwV3ViL2pZcml1OEFCRDlUYWNGUlh2?=
 =?utf-8?B?Yno2enpCWmJCZG9WMmpzQTdrMThTbHFEc0FKQVFIUk9qTlZ0emRybnhwWFY5?=
 =?utf-8?B?aGxJNXJnSE9YSnFLNGNNRm1TeERQYlY4YXhtcnlwNzE3YXkyVU9WRXpuMnp0?=
 =?utf-8?B?VTdtNWRlK3ErUUpjQXJVR28rRGF2cHNFWWk2cHlBZFNXMzg0YUlWRHdCMzFX?=
 =?utf-8?B?dnk4S21OaEJDRENjc2Vxd3h2RG9EZmxOcHdYZkVvaE1HUG5IMHc4NkE5eUJJ?=
 =?utf-8?B?cG5jZFpTNGhBcFpncWNoTmcwU3VCR2wyQXhwYUFQMW9OaDBqemhUbzM5blBl?=
 =?utf-8?B?ODV1SVNMUmgxMTBFcGxJWEJaOW5jU0VyVWhEL01LRU16bm01UjVCWGN6Q2N3?=
 =?utf-8?B?ZmJzakxIRWhQZ0FHYXZqRUlGekJma21uYkY3bEM3SStWL3k2Z1pNU1c3dG1C?=
 =?utf-8?B?QzJTWitKOW9IQnZPN0lNS1U4SDhkODg0ck9CaDZPNTBaZ0RNVGdTYXFtRk1M?=
 =?utf-8?B?c3RqU21jWVF0Rjg1Rk9yNTY3UFIzUTBaVHphckJoZ2k5Z041VEE4YldHKzJS?=
 =?utf-8?B?SWVsWmpUOGI1L0hqUFNLY01TTVpOZHBJbWpSZllKdk50c09rUWl1Q2dJV2l3?=
 =?utf-8?B?NFJ2VFV2Tk5wRE9ldGJqcjZqSmZ5UDR0cy9Ydyt3dW5QeXkxN0l2emo4cEtp?=
 =?utf-8?B?dERPSEtEUDZ4eUNVVHpMbExrL1BhQ1pTVkJWcXo1elFSem9zVFhaNHVZV2dU?=
 =?utf-8?B?ZGNBK2ZsK0hVcnhSdmJ4dGpZNnQ1alVIZ0ZaemdSOVpNMWFYR21SMlFqQjRR?=
 =?utf-8?B?QTh0SFpjWU0rZmh2WmpGdTRKOURxUkYvYkhqSzQ4Sk44cWhCZ0p6d3NWVllT?=
 =?utf-8?B?aDR1NGl2dWFFZFBIdHR2cWI0a0REVEhmZDd6bjBGWGhwenF5dzA2NnBVL0J1?=
 =?utf-8?B?ZVF0bU9HQXBXeXU1alN1LzdTVko3VzRJUkdIMG5sb1NSeTgzSWxjaXoxQ1FX?=
 =?utf-8?B?WWRNZE1UckZKRkRQdVFWdG1xK3lMWnBvSlVob05WUXhBY1RRMEM3YVg2YTZY?=
 =?utf-8?B?K3dtODl3RzRUQzJpdHdpdVRSUU1rNXdwU0I4U2Jzb1NTV0ZjMkNsQitOOWlp?=
 =?utf-8?B?Z2c9PQ==?=
X-OriginatorOrg: epfl.ch
X-MS-Exchange-CrossTenant-Network-Message-Id: a8200454-868e-4637-e2da-08dde0cb92ff
X-MS-Exchange-CrossTenant-AuthSource: ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 15:58:30.8195 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f6c2556a-c4fb-4ab1-a2c7-9e220df11c43
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZEa3t4qPeI8j7uB445i6QdSqoUUd6gxuvw2inB7CzYr/4TZocxjbHHZ+KI430ThvEsWVy4y1/76nkBUYiTMdfgWvfhx0aDnTBp25qCLk1aQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZRH2PFAD84B9AF9
Received-SPF: pass client-ip=52.101.186.113;
 envelope-from=florian.hofhammer@epfl.ch;
 helo=ZRAP278CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Daniel,

My apologies for the late reply, I've been out of office the past two
weeks.

> Yeah, this sounds like it is potentially going a step too far in enabling
> fully out of tree extension of core QEMU functionality.
> 
> If something conceptually is in scope of the core QEMU codebase, then
> IMHO, our plugin system should aim to avoid enabling external
> implementations as far as is practical.  That was easy when plugins
> were limited to observability, but the more we enable in terms of
> state modification the wider pandora's box is opened.
> 
> Where to draw the line is a hard problem.

As I'm new to the QEMU mailing list (not to tinkering with QEMU /
implementing things in or on top of QEMU, though), I'm not fully
familiar with the requirement of preventing out of tree extensions
(or at least certain functionality in such plugins).

I personally (of course with a somewhat biased view :)) see features
that allow modifying internal state (such as syscall behavior) as
beneficial or even required for certain dynamic binary analysis use
cases. Currently, the situation in academic research is that researchers
(i.e., typically PhD students) for dynamic analysis use cases fork QEMU
and implement their use case directly in the core logic. Such patches
can of course never be upstreamed, as they're very use-case-specific and
typically don't generalize to the full QEMU functionality (or might even
break / deteriorate other functionality that's not relevant to this
specific use case).
As soon as the corresponding project is considered "done" / "finished",
the code basically just rots and never gets rebased onto newer versions
of QEMU anymore, basically freezing it in time with all current bugs and
without potential future improvements to QEMU's core.

That's why I personally actually really love QEMU's plugin interface: it
allows me to introspect the system state without adding custom hooks
everywhere in the code that might not be portable to newer QEMU
versions! Consequently, my code is reusable either by myself later on or
other researchers with any version of QEMU that supports at least the
specified plugin API version.
However, I often wish to modify QEMU's state as well, such as in the
provided example with modifying syscall return values or skipping
over a syscall altogether.

Do I understand correctly that handling syscalls is considered in scope
of the core QEMU codebase and therefore shouldn't be possible to do via
a plugin? If I understand correctly, as it stands, there's no way to
modify syscall behavior on an emulator-level with QEMU instead of at the
kernel-level via seccomp, eBPF, kernel modules, ...

Best regards,
Florian

