Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C46D9EFD205
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 08:05:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vv9tC-0005DH-T9; Wed, 25 Feb 2026 03:04:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.hofhammer@epfl.ch>)
 id 1vv9t0-0005C7-1W
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 03:04:46 -0500
Received: from
 mail-switzerlandnorthazlp170100000.outbound.protection.outlook.com
 ([2a01:111:f403:c213::] helo=ZRAP278CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.hofhammer@epfl.ch>)
 id 1vv9sx-0000eE-52
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 03:04:45 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZR6T9FrVCWcrZ7BU92uXBmtrGVbIpSJ4sSxEZFqk97NS2ZP3vUV6HE8UIAU9ccfVRUMrXKG/ncIeKE/bq5Pr0f75gLyigiI1X8AQ9tXbvYQxVM98NbIAaU2QZ+DHHqdBOxYPyRunUr9nk5zDkkXjRJi8R8jrZqs1hJ6xfQ1xwcc3O9hi8HOXIQpEM9SkV5e6ayr7vvHFhUEb/nRYsxARSMzmcIvEDcNcGkgfZb3H9LmkPKqQt7S30mJ2zRbZD62SIwanCxs3ccQ0BCfiW4ukkTo60Tz30YXAuCb/uvoVtzumsoummfyAPBxe6VEZgNw8jzd8HrJ2JK+BnvVIl/k2Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yh3q3DJaWbtvPL9hzoYAuvtiKUf8lKW17hKRtw/4n04=;
 b=bqAo/dMpizpLykjQeCdeq2HH318HOOm8d33BkHHfrjuOz3qGVOBpHDXXCEjM9klQWGS3WCJ/kigcxqlSW2qwNrzjonwnvAryJwyI6d5crku5Wlg5Ggxg0N+zZlUrbg4GGPAomHIuAfmh/xiqVBAfVMkUrIRG0Ixn9usOivbomVyxWZfmf0BWuEBIhL6bxvymeZ6HFl7JP2GifwrU+x/wzjCHGm8ljYnfAvogDQaYcPAPx6/Wwx+RjUvu0MYFWvuRSdzEbWdf2DpZTcU8OfGiMEMkmFVAYAAPXwWm259zXUZt2ztuFPVeRr3bi2h27r4vcrq9NJDIsvODwpLrOOMAlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epfl.ch; dmarc=pass action=none header.from=epfl.ch; dkim=pass
 header.d=epfl.ch; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epfl.ch; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yh3q3DJaWbtvPL9hzoYAuvtiKUf8lKW17hKRtw/4n04=;
 b=mYy8F8m9P042k/mM/D1UthJnXfS0hrICr+A0Tm6YPfuAXbwEnFD0dofguVS259ulPXK4hQsxzQRQMY8dbG3MD/Sm8AjuseS3vP1zp/xnKs590ly6r/krQhXWup1zIyFT2Xkq/jK4QCGrPZdOLjtoe1nlzUYVK9ID3Ko77XyEf00=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=epfl.ch;
Received: from ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM (2603:10a6:918::220)
 by ZR3P278MB1238.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:73::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.23; Wed, 25 Feb
 2026 08:04:29 +0000
Received: from ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 ([fe80::80ea:3d03:40bf:998c]) by ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 ([fe80::80ea:3d03:40bf:998c%6]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 08:04:29 +0000
Message-ID: <1b6eef52-d6d0-4b11-a91c-6d8b43f4e3f8@epfl.ch>
Date: Wed, 25 Feb 2026 09:02:56 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/7] linux-user: make syscall emulation interruptible
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, richard.henderson@linaro.org, laurent@vivier.eu,
 imp@bsdimp.com, berrange@redhat.com
References: <909b0a4f-9759-4e27-bba8-997ae2f41bd6@epfl.ch>
 <8096590c-bf13-4e5e-8167-ab38a37180bc@epfl.ch>
 <538ada16-07b8-403c-b1fa-f42db7cfc195@linaro.org>
Content-Language: en-US
From: Florian Hofhammer <florian.hofhammer@epfl.ch>
In-Reply-To: <538ada16-07b8-403c-b1fa-f42db7cfc195@linaro.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
 micalg=sha-256; boundary="------------ms020407030705050204060908"
X-ClientProxiedBy: GV0P278CA0072.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:2a::23) To ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:918::220)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZRH2PFAD84B9AF9:EE_|ZR3P278MB1238:EE_
X-MS-Office365-Filtering-Correlation-Id: 53d18067-a03a-49db-e0bd-08de74448065
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|19092799006|366016|786006|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OExHeEZDMkswbFhpZ0MxY0crY0VUcWQzNm1TV0I2V2NzZ2VFbTNheWdVN2th?=
 =?utf-8?B?UitOVTAySlBYWUF4M1NaSjVTUjNSeHdSZStZN1crOS91Z0U4Wkhoc1FDZjda?=
 =?utf-8?B?RjU4NDZmSUpibXIxK1AwRmMxMjNLeDZRWHFhNVZCL2J2SVpmKy9nNldDakxI?=
 =?utf-8?B?Z3BzaC9BNCtWdUxFMTVJTmRIMDIzNHVWeDFBMSs4aElSZGh6SzdwaGlLQUNJ?=
 =?utf-8?B?WndzYnlQOThaeFpLU0NYUmpoVTNGbS9XY0JMSDJYQVVwYUM2WFExS21Xamhn?=
 =?utf-8?B?c3V5RGNObGk1cHZUL3RxVm1rSlJwN0xUUGc0SDhuWnVoS1llaEs5ZHc5SjRz?=
 =?utf-8?B?OHdYbmY3T3doV2huUUtnWThhTXE5KzFmSHoxRWpuenJTTWJIUUlpNWk4QXow?=
 =?utf-8?B?SWRWUlh0RlN5VVRWbFJXTzBPaGpHYzRRZUZMNFhoSVBvQTI4czNtbzJaWnJW?=
 =?utf-8?B?MGlYM1M2TGNlVEQ4UjhZRndYRUo3NUZORU8yZFFpczAxdDJRbGxyOTU3Umwx?=
 =?utf-8?B?MG9NV2ZPNzJxTDNSRmFldnMrVjB4NURUbGlGYXYwZG5QZkJTem1Kai9LRjNO?=
 =?utf-8?B?bWx0bVQ2YUcyT2lDVmlGWW1JVmt6L3JXZEg5ajM2dXJuRkF2RXFtc3NUNm9q?=
 =?utf-8?B?OW43MjlldS9DUGgxNmJYcW9QUkVCUVY1L056cTh1RFU0eVZ3anI0OCs3cVdu?=
 =?utf-8?B?Y2YxSEJidEZOaEJXem8yQ3ZpV1FOQm11d1RqazdXTmxGcy9vTXB6blJBVk9x?=
 =?utf-8?B?Y3kxSEtqMnduTk4xS3VpeVpoeFBYM09XM3FyaUFRbUp2MTdQTjNnZTgyK3RH?=
 =?utf-8?B?d0FIQzdyVC9KSEp1Z3orL0dDejRhVjBnRVJvd3RtaFhqdHA4aHBsZXNDWmJO?=
 =?utf-8?B?Vm1RVXhmYUY1SjdsS0V4ZHFRbmZoYTZXakVmZ1kzWVk2c0R3RFRwa3RPYnR6?=
 =?utf-8?B?dHpjQWsxN2VjK25xRkJhQ2NEb0F0U3hOSW83K3dvdGVkdVRkSldkc0ZWdmNt?=
 =?utf-8?B?Y3RsR0h2Z2tpRWJ0c0pISk5tQzZNbit3S0pxN1QwRjNqQURiMlg3UDlkakdQ?=
 =?utf-8?B?dzcrbGRPWWpxUC9wdnNmV2NxcnZnR3ByYnh6WmR5UlJTalkxUXlPVjFTWkJy?=
 =?utf-8?B?QnhWRkFWaWJKRTU1SmxpZDkxdVBmNWpxWVc0K0FJeVVXWXBpRERJQlVnello?=
 =?utf-8?B?cVBmSUVsbkV6MlpXaXhGOGY5Y3lRd09TN1VBME81am11N3hNb3BZRk5OMysw?=
 =?utf-8?B?OXRkcTduNWMza3JTYk9PV1ZGei81S2RjYlV2RDBPYzFBUytsdEVVZTdBWVJC?=
 =?utf-8?B?SXpYZkZjc09tT0tKK2FqZWlVd1VrME40R01qR3BpYWJnZEJCUnZaRHI3MkE3?=
 =?utf-8?B?NTZ0VmxFUHpITk0wUUF6K3p1Und3VFcxUms0azQ5Uy9JS2wwSUd3K1N3YkJy?=
 =?utf-8?B?eGUwcjY1eUZiYnIxdmFPMkl1Nkx1ekduV0UybW4ycnpYakl0WmhoVVFxNWpV?=
 =?utf-8?B?bUUrRWoxSFJkdDhPMkVtdjQxdUJIRmZkRnRCcWJabVBpN3k1RVEwaVdhVWFo?=
 =?utf-8?B?ejY0emJqMVNOMWQrM3BuSjd1Mm1DN3AwWHFMZkRMZ2puZFgvQVl2aFZyeHlQ?=
 =?utf-8?B?Y2F3V0UxQWkrWlJhVW5RMURLaSthZzVCL2VhbUwrRHp2ZjNwOThMdkF4M0kx?=
 =?utf-8?B?NjYyYjY1Si9IY04vVjlUcml5aWtYYjBGM1NDQ0dPZC8zdFdacklHcEJFQVN0?=
 =?utf-8?B?blkrSU9HRDBGdmViM0ZoOHZlbmx6RXRiaTRYRkFlLzFwaHVHZDhyTXVMYUlT?=
 =?utf-8?B?WkVZU0NyMVZRYjl4T0dZVG5zUkdra2EwUWZRQ0w5R1lHYzlLNUJFSGpSTS9p?=
 =?utf-8?B?L2J5eGhOaU54SC82NVRnc2Q1Tm5qZEFYUUg1Q3hlZVBSWWpEYjkyT1JBSjAr?=
 =?utf-8?B?VnhnUVJCdTNYL1JOZUh4b0lHMTUwN0h5QTltU2NEcituQVhGY2NYelRNRUVL?=
 =?utf-8?B?RHRDaE1TR09kU20xU2hHK1NUdUE0UzlCSWlXRldBMThTVmQweVg5UGhQS0Vt?=
 =?utf-8?B?WHE5bXNiN0VYeldrdlhWMHJXYW5UOFJrQjdBc2ZQREE4NllUWllBRW9SOUVY?=
 =?utf-8?Q?hqRM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(19092799006)(366016)(786006)(1800799024); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a0IxN2RBa2F6Z3M0Wm91eDMxdDdSTktBUTM4ZlR2a1ByV3JPZHg2TGlob2p2?=
 =?utf-8?B?QlM5SDR4R0IyRVlrWG9ZblF5bUNRN1laSzE5SzJ6SVl1NjNEbkxCRFhXTlFm?=
 =?utf-8?B?WVp4TldKdTRlQUZ2T0xRbTB1ZHZORi83SGp2ZnpMMjM1cVJna282SFM3KzA5?=
 =?utf-8?B?aThJTlFDZThRMFJnY2pzZHcydFU5NUhIZHMzeUNQZVRSZ1NaeVBVTlpNMysv?=
 =?utf-8?B?TUlnYlh6M1M2QjVJOUdSZGtTM2tLajlYMzBCU0pPRmlBT3RwK0Q4cytvOG5K?=
 =?utf-8?B?RGRxckhlT0hIaU5iR2U5NHVVRG5sTDA1VFhIQk1zWnlaME5nWWthVHBld2Jm?=
 =?utf-8?B?K0NUVXovRmtmcnZueFpFMis3U1VOUEE3ZEpHcEpJSHY5Zy9Wa3NXV21aRzRZ?=
 =?utf-8?B?bVBXdno4Um1zMU9lWHFmVGtkVTlVWEp6eTgwQUhPWVhHcVFIUkY3aEszeFBM?=
 =?utf-8?B?RXUyNGl0WCtZQUQ2VlRBT1RiUDBJKzJOTkhhT3ZtRnlZNjFkbVppYkQzSnNv?=
 =?utf-8?B?cUk1V2xhR2lJTFpDSDFoYmt2cWNpM3FGRERqN3laWkVBUkl1Z21sbHNhRThK?=
 =?utf-8?B?ZVAxWDMwb1pLTkd6ZVRlRTN3Vk9ZZituR1YrV2Q0R1ZnWmw4a2RrZTVqWWpZ?=
 =?utf-8?B?T0liVDlreHp2U29RY0xwVWQ2bkptQW55N3Zid21kUTRkQUc1QnJFUzc1cnZ6?=
 =?utf-8?B?WldCMmE0VzVsRVVmOHU0L0RiM2tTbHJDeTZMVlZCZEhKNTNlNnpqQ2xqeFE1?=
 =?utf-8?B?YU1kWGpLRk9DQ0pPQ2tJMzI4OTZBWGZYckhFSU05WE9jeThNRkkxWkpwNnBS?=
 =?utf-8?B?TG14L0EwMldwRjZXR0hOZmtmMWVMY2lDblpCa2NNZUdvQ3pkdkNsdDVyNTJt?=
 =?utf-8?B?M2NJNUpQaklUYnNlQStPeUNCTXp3MmZEN3B4NEwwc3kyK2dkVGQvZEtVM0Y3?=
 =?utf-8?B?RS9lZ1o5clZ5SkhsVlV2ZnBmSURtV2N4ZkphRlAzLysrTXJJL1V1dFk5WGVt?=
 =?utf-8?B?dGxmUXM2R010Mm9oY1ZTdkRVOUIzOXNHNkF1eEJRWFVhWkl6RU5BcFA1ZHlY?=
 =?utf-8?B?SmRjcXdRNVVGN0ltUkRCWFVyV2x2RldXbE1UakxxMUFacXpkZC9nMmRIQ3FT?=
 =?utf-8?B?WklpK25hYnFURXFFWi8yNnJqRlRkaTVJZVlONHREZGhGNzFoWnc2ZVFMWGJZ?=
 =?utf-8?B?YTJZYUhiMmJ4aFN3L2d4cnlnQXl4SWRSZ004RVNiYXhGeUVBM3gzcDRXUHpm?=
 =?utf-8?B?NTRIVTNGS1dIOXdPT1dnYkZCNGZ2ZDcvb2pXc2kzcXZBSGlhVmVmOWlyb0dz?=
 =?utf-8?B?QW9rSXpVbDZTWTlhQnZrTnFNYzd1YjRBWHh5S2pPQU1ETHhKbXZ1VWphQ0t5?=
 =?utf-8?B?V25qcXcvRDBEdkg2eENBc3d4Nk8rUTFFYzFjcnhNV0I4OFE2Uk1LSXpJWFpo?=
 =?utf-8?B?STdYYXhwdSs2Tzd3dFozVjhIWU9jNUtKeHoxbk9NVmpjZEVqUTZFc1dKZTh5?=
 =?utf-8?B?eCs5aG5YdE81QUpxMG9pZndNemVxc0d4em96VTNDVUlkeWJOd2x2UFJoVjZX?=
 =?utf-8?B?YTljNFhXU3ZvSndvOVllN29yaFVLVnhuUDFnQ0trRERJT2F6d3l0cGVjNVZt?=
 =?utf-8?B?OE5PcVRvYUJONTBpaFFtRklPcWZTUHVZekhWQ045MzFjTldwYkMyTTZwMFpM?=
 =?utf-8?B?U0Y5N0pmVGpKRnQ3WGZXbXg2NnQ4c1o1akZ3b3gvcGFDVWNlWnkwKzIxcS9R?=
 =?utf-8?B?NWoxM3ozWUNPWGVyUGU2RnFrc0IzeW9qMFBXNHFLY0tYS0lCZ2JFSHE5NnJo?=
 =?utf-8?B?MnJGdlo0ay9lbHNWTGJVY1NKM2lRMW9aWUNrczkwbFZVTE1xQThWNU5scExx?=
 =?utf-8?B?WG9aNjF6Qk1ua2llTUFuNnBlSmlkYk0xOGsxRjRxOU5jUWNndHd0RklrbUxB?=
 =?utf-8?B?aHJXdHd4MmVGS1lueDVWbzgycDJkRDVOK2xTbytnSXF0dVA5TVUvY294VHNa?=
 =?utf-8?B?c2U0ZERtVmxCQUpyZFdreGVWalE5WXV6eSs5K1lJT005b3Z1RHd2Y3dEekhM?=
 =?utf-8?B?THF1Q3F0NndoTkJIN2ZUUUJ4Z0FCaHZndE96aytYR3hrRE0wdUpPSVlsWGJK?=
 =?utf-8?B?RmhBVUxydmx6MjFKMW5PaHhVN1p5aVBCT3BVVGxJZGEyQk1ISFFRRzM0a2lL?=
 =?utf-8?B?NnUxUVQ0UjNjQndrbGN2eG5icGNSUFBuaGFJZjV3UVhBa3l5YzROV3dXMmlB?=
 =?utf-8?B?V0cxUGo4OGpBRFVaQjQ3TzVFb2ZRSnRlb3NKYmlRWkpWZnBiV2cvWVVTaWVU?=
 =?utf-8?B?TEFNYVNjTzhSeWlGcTZiTGhXYTRhMlJJdUZaTi9KcGN0L3Fxa0RHUT09?=
X-OriginatorOrg: epfl.ch
X-MS-Exchange-CrossTenant-Network-Message-Id: 53d18067-a03a-49db-e0bd-08de74448065
X-MS-Exchange-CrossTenant-AuthSource: ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 08:04:29.5507 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f6c2556a-c4fb-4ab1-a2c7-9e220df11c43
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qGf4GeqC0tgbiNjOUG244Te50NE9Z4JQSPRwyfCjp+yr8+XVex81gOjJGk2Otb9i3ZBmoHhmAMm0S/67bR+XeXcHzvhEWqjRMuVQeqBrB5A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR3P278MB1238
Received-SPF: pass client-ip=2a01:111:f403:c213::;
 envelope-from=florian.hofhammer@epfl.ch;
 helo=ZRAP278CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

--------------ms020407030705050204060908
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 24/02/2026 22:05, Pierrick Bouvier wrote:
> On 2/24/26 7:50 AM, Florian Hofhammer wrote:
>> The syscall emulation code previously wasn't interruptible via
>> cpu_loop_exit(), as this construct relies on a longjmp target that is =
not
>> live anymore in the syscall handling code. Consequently, longjmp() wou=
ld
>> operate on a (potentially overwritten) stale jump buffer. This patch a=
dds an additional
>> setjmp and the necessary handling around it to make longjmp() (and by
>> proxy cpu_loop_exit() safe to call even within a syscall context.
>>
>> Signed-off-by: Florian Hofhammer <florian.hofhammer@epfl.ch>
>> ---
>>   linux-user/aarch64/cpu_loop.c      |  2 +-
>>   linux-user/alpha/cpu_loop.c        |  2 +-
>>   linux-user/arm/cpu_loop.c          |  2 +-
>>   linux-user/hexagon/cpu_loop.c      |  2 +-
>>   linux-user/hppa/cpu_loop.c         |  4 ++++
>>   linux-user/i386/cpu_loop.c         |  8 +++++---
>>   linux-user/include/special-errno.h |  8 ++++++++
>>   linux-user/loongarch64/cpu_loop.c  |  5 +++--
>>   linux-user/m68k/cpu_loop.c         |  2 +-
>>   linux-user/microblaze/cpu_loop.c   |  2 +-
>>   linux-user/mips/cpu_loop.c         |  5 +++--
>>   linux-user/or1k/cpu_loop.c         |  2 +-
>>   linux-user/ppc/cpu_loop.c          |  6 ++++--
>>   linux-user/riscv/cpu_loop.c        |  2 +-
>>   linux-user/s390x/cpu_loop.c        |  2 +-
>>   linux-user/sh4/cpu_loop.c          |  2 +-
>>   linux-user/sparc/cpu_loop.c        |  4 +++-
>>   linux-user/syscall.c               | 16 ++++++++++++++++
>>   linux-user/xtensa/cpu_loop.c       |  3 +++
>>   19 files changed, 59 insertions(+), 20 deletions(-)
>>
>> diff --git a/linux-user/sparc/cpu_loop.c b/linux-user/sparc/cpu_loop.c=

>> index 7391e2add8..f054316dce 100644
>> --- a/linux-user/sparc/cpu_loop.c
>> +++ b/linux-user/sparc/cpu_loop.c
>> @@ -229,7 +229,9 @@ void cpu_loop (CPUSPARCState *env)
>>                                 env->regwptr[2], env->regwptr[3],
>>                                 env->regwptr[4], env->regwptr[5],
>>                                 0, 0);
>> -            if (ret =3D=3D -QEMU_ERESTARTSYS || ret =3D=3D -QEMU_ESIG=
RETURN) {
>> +            if (ret =3D=3D -QEMU_ERESTARTSYS
>> +                    || ret =3D=3D -QEMU_ESIGRETURN
>> +                    || ret =3D=3D -QEMU_ESETPC) {
>>                   break;
>>               }
>=20
> Just a style nit:
> if (ret =3D=3D -QEMU_ERESTARTSYS ||
>     ret =3D=3D -QEMU_ESIGRETURN ||
>     ret =3D=3D -QEMU_ESETPC) {
>=20
>>               if ((abi_ulong)ret >=3D (abi_ulong)(-515)) {
>> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
>> index d466d0e32f..99e1ed97d9 100644
>> --- a/linux-user/syscall.c
>> +++ b/linux-user/syscall.c
>> @@ -43,6 +43,7 @@
>>   #include <linux/capability.h>
>>   #include <sched.h>
>>   #include <sys/timex.h>
>> +#include <setjmp.h>
>>   #include <sys/socket.h>
>>   #include <linux/sockios.h>
>>   #include <sys/un.h>
>> @@ -600,6 +601,9 @@ const char *target_strerror(int err)
>>       if (err =3D=3D QEMU_ESIGRETURN) {
>>           return "Successful exit from sigreturn";
>>       }
>> +    if (err =3D=3D QEMU_ESETPC) {
>> +        return "Successfully redirected control flow";
>> +    }
>>         return strerror(target_to_host_errno(err));
>>   }
>> @@ -14410,6 +14414,18 @@ abi_long do_syscall(CPUArchState *cpu_env, in=
t num, abi_long arg1,
>>           return -QEMU_ESIGRETURN;
>>       }
>>   +    /*
>> +     * Set up a longjmp target here so that we can call cpu_loop_exit=
 to
>> +     * redirect control flow back to the main loop even from within
>> +     * syscall-related plugin callbacks.
>> +     * For other types of callbacks or longjmp call sites, the longjm=
p target
>> +     * is set up in the cpu loop itself but in syscalls the target is=
 not live
>> +     * anymore.
>> +     */
>> +    if (unlikely(sigsetjmp(cpu->jmp_env, 0) !=3D 0)) {
>> +        return -QEMU_ESETPC;
>> +    }
>> +
>=20
> Makes sense, and I guess you found that when running the series test.
>
> Do you need all the new QEMU_FALLTHROUGH introduced here? Is it for rem=
oving warnings?

I think they're not strictly necessary, but if I recall correctly, I had
warnings otherwise.
I can remove them if you prefer but I think making the fallthrough
explicit encodes the intent better.

>=20
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

--------------ms020407030705050204060908
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCC
DD0wggWvMIIEl6ADAgECAhANkOKMSmGXhF5eMl0rsRhvMA0GCSqGSIb3DQEBDAUAMGUxCzAJ
BgNVBAYTAlVTMRUwEwYDVQQKEwxEaWdpQ2VydCBJbmMxGTAXBgNVBAsTEHd3dy5kaWdpY2Vy
dC5jb20xJDAiBgNVBAMTG0RpZ2lDZXJ0IEFzc3VyZWQgSUQgUm9vdCBHMjAeFw0yNDAzMTMw
MDAwMDBaFw0zNDAzMTIyMzU5NTlaMGIxCzAJBgNVBAYTAlVTMRcwFQYDVQQKEw5EaWdpQ2Vy
dCwgSW5jLjE6MDgGA1UEAxMxRGlnaUNlcnQgQXNzdXJlZCBHMiBTTUlNRSBSU0E0MDk2IFNI
QTM4NCAyMDI0IENBMTCCAiIwDQYJKoZIhvcNAQEBBQADggIPADCCAgoCggIBAOfSIeC0vv1x
PQ+dgSxbIIrkaru6skAWJYaGFzmvq4Kq+2wU2jxhcWlJg/JeP5jEkq/LM3pn5aaLao79j+XR
mS7J1ZpJKUODJVoM4s9MQJhTMvo4qS5ZS64g6QR7Obkz3I1Lr3aWeSBmDDEyzue+NKtuWZ1C
xy3RdXo/w5HgRc3l2AercOM3Gt1XonTzEtTbZ/Hwc0Sn9Gz8RmGRK6Ka4hVDl8q/2l110KaV
233Kh5etP0csXS8MIMdVRfRu3sc5hp13DG7lCKzK72a2GEpI8Wpl26G6I1/LMzz/98T+FqjT
qxsdquk7Cj7m2vKGLW1BorpQH7WFGPdJQXJe1hfbfiZACcVdCtl4nAacFacmsiArZBfX7AQG
L7isvHUwwYFEtcApyGW4p2Lt+t8nvU0CANA6BHOpOz1xOP8WmAESbUriIjyuTUf3fJ9oDNCu
rVqhASMJCDaWI3lYX/QAoiAzt6akqbbZxo2ujW7mGGqc0KxqE2csh2T79v7pC8aUtHBfwNrT
R19GnZVxE0eQ7ViIQhR6mpSaUQFA9sG+cmD2G8TnCgYsLa0q8De6F61aCBevQGHNzrbZ3JAM
neveYg/Jy1XxQHDRcvrMfWKe0jjcWbdKYlaGVPm5V1ILwYz7Yv5ewo3NUrxIGJiywe9qPhuJ
SDZs7VehTuI0FxGIsgKzVjgbAgMBAAGjggFcMIIBWDASBgNVHRMBAf8ECDAGAQH/AgEAMB0G
A1UdDgQWBBT3m6JO05fF9DQPQw6Bhc6RkzKv+TAfBgNVHSMEGDAWgBTOw0q5mVXyuNtgv6l+
vVa1lzan1jAOBgNVHQ8BAf8EBAMCAYYwHQYDVR0lBBYwFAYIKwYBBQUHAwQGCCsGAQUFBwMC
MHkGCCsGAQUFBwEBBG0wazAkBggrBgEFBQcwAYYYaHR0cDovL29jc3AuZGlnaWNlcnQuY29t
MEMGCCsGAQUFBzAChjdodHRwOi8vY2FjZXJ0cy5kaWdpY2VydC5jb20vRGlnaUNlcnRBc3N1
cmVkSURSb290RzIuY3J0MEUGA1UdHwQ+MDwwOqA4oDaGNGh0dHA6Ly9jcmwzLmRpZ2ljZXJ0
LmNvbS9EaWdpQ2VydEFzc3VyZWRJRFJvb3RHMi5jcmwwEQYDVR0gBAowCDAGBgRVHSAAMA0G
CSqGSIb3DQEBDAUAA4IBAQA+b8Uw53sDspdZgukU+qzLyyHkcjlxGGhHlP+zrmDLKm1wEFvC
RS2pili3Hy67i8N4N5NUvw5Rg6kv3lxb9S9Rktxk43k+tvm68pl7OxQE55ZjVY87P0lUPGwE
qOOwLLyH02ZQcsfq5p5LrOH90JvmvZ1yy73HS+VpDAqOlytE0NSvTIRqFFkKQGQwfjvtql9Y
flujuNNvJztjBaHKYZsnNSg+J38ojYq4TP3pSg3UdVH0PncVjPQyqxC9xef5Xae92Kbkzol3
x7Nel3A1bwAkalrDMspvTHvey6LfiBksFIqviTnoy7fgjaRAJgHS+RXx/cmuRd3rUAclSVVr
Yu8RMIIGhjCCBG6gAwIBAgIQAggtinx6OJLKM4FVztNyWTANBgkqhkiG9w0BAQsFADBiMQsw
CQYDVQQGEwJVUzEXMBUGA1UEChMORGlnaUNlcnQsIEluYy4xOjA4BgNVBAMTMURpZ2lDZXJ0
IEFzc3VyZWQgRzIgU01JTUUgUlNBNDA5NiBTSEEzODQgMjAyNCBDQTEwHhcNMjUwNTI4MDAw
MDAwWhcNMjgwNTMwMjM1OTU5WjCBrDEOMAwGA1UEYRMFR09WQ0gxCzAJBgNVBAYTAkNIMREw
DwYDVQQHEwhMYXVzYW5uZTE0MDIGA1UECgwrw4ljb2xlIHBvbHl0ZWNobmlxdWUgZsOpZMOp
cmFsZSBkZSBMYXVzYW5uZTEaMBgGA1UEAxMRRmxvcmlhbiBIb2ZoYW1tZXIxKDAmBgkqhkiG
9w0BCQEWGWZsb3JpYW4uaG9maGFtbWVyQGVwZmwuY2gwggEiMA0GCSqGSIb3DQEBAQUAA4IB
DwAwggEKAoIBAQDZkbG07NgfFKDNM3VI4qQdU1fVIGUQnN6BO2zeqoUdytNIzxOX6n7HxM+o
CLa01AnxaL59DXwFTXIg0OVq5ETAoLshUwnkYeWhKZH4Ysoq74QGVFihjrrs41d+8o+ymG2F
cZBMzQ/RO4KzFhmlaZ/E+1d2F7/O3x8LohaFxxBsN0+qonMreRQGx+ialMmbARFJkVuinuB4
3hZ8eRVmXy8A4R8ywakunaCNm15+eIQtptCs3IH5UqPEEOn16ANekWr7z5mZJh3ApxreflA/
iwJKWd/Ljga90TJXjTFc7sNA0RgA78Edqw7BE+D2VUcPMshdhKYNB1BVHZS81anGL7RFAgMB
AAGjggHrMIIB5zAfBgNVHSMEGDAWgBT3m6JO05fF9DQPQw6Bhc6RkzKv+TAdBgNVHQ4EFgQU
ogXJJmzPazWg0eBlf1DbolocD3gwJAYDVR0RBB0wG4EZZmxvcmlhbi5ob2ZoYW1tZXJAZXBm
bC5jaDAUBgNVHSAEDTALMAkGB2eBDAEFAwEwDgYDVR0PAQH/BAQDAgWgMB0GA1UdJQQWMBQG
CCsGAQUFBwMCBggrBgEFBQcDBDCBqQYDVR0fBIGhMIGeME2gS6BJhkdodHRwOi8vY3JsMy5k
aWdpY2VydC5jb20vRGlnaUNlcnRBc3N1cmVkRzJTTUlNRVJTQTQwOTZTSEEzODQyMDI0Q0Ex
LmNybDBNoEugSYZHaHR0cDovL2NybDQuZGlnaWNlcnQuY29tL0RpZ2lDZXJ0QXNzdXJlZEcy
U01JTUVSU0E0MDk2U0hBMzg0MjAyNENBMS5jcmwwgY0GCCsGAQUFBwEBBIGAMH4wJAYIKwYB
BQUHMAGGGGh0dHA6Ly9vY3NwLmRpZ2ljZXJ0LmNvbTBWBggrBgEFBQcwAoZKaHR0cDovL2Nh
Y2VydHMuZGlnaWNlcnQuY29tL0RpZ2lDZXJ0QXNzdXJlZEcyU01JTUVSU0E0MDk2U0hBMzg0
MjAyNENBMS5jcnQwDQYJKoZIhvcNAQELBQADggIBAD3Ne2mHg2ctxRIflrx/T2yBDnQunFhe
SRwBnFIaOvCG05KE9iit2I2sazC5xqdp292spCoP9Qa4MOJg22BFmTnN9XnOjcEv9KFPSMaA
ITLu8CXyewPb0xLET8WqdEe5AravlneZ9/H0ve9Ufhk3wbJPKK5yijcKYmEYH21JBtZ1pnjs
fVEXAETdKkp9LC5sVeYeFk67BbUTPrFl37pha3TynPwJAiXDJFR2uI2JVGESQFyWkeO/bY5T
DCf6VIp3d1p++XoOTVseFE8OqaHZYGN+DgSK4ejT19c/GgjQqoWVK+xSvHEEsoLfOADKcYFN
M0ptGrFYpdRWJO0CKukBUAk8fpriJ/OjhSVQltCpN3pK1DPXnPrXTROXGacb3PNSUyeDlP2/
y0FqpEY7GjwMZMdu+U/rHhMGbDmv/ZBLGwiGzQVmld5je+d8nvZTamE1iBA8Nhmuz6wg6yN1
qx9b7Jn/9yQebxvHddnvz6jw6FDnw2bhq7z88eH3mYZYZ48Fhr8J87horGotEDKTDNHkF1Oe
FSxhIx0a7yoe1I66R5tapkRlNgI5EX53e/npP4ruND5bQFWDI7JGkKrLlAjQR/dNahXXX/Ry
rCfngiHZcAQakPkQrlrZCxMhlIKvDMunATaICyjnHizEC+1qzJsdvJgSC8sOzLxiEjlx3MRe
CswFMYIEezCCBHcCAQEwdjBiMQswCQYDVQQGEwJVUzEXMBUGA1UEChMORGlnaUNlcnQsIElu
Yy4xOjA4BgNVBAMTMURpZ2lDZXJ0IEFzc3VyZWQgRzIgU01JTUUgUlNBNDA5NiBTSEEzODQg
MjAyNCBDQTECEAIILYp8ejiSyjOBVc7TclkwDQYJYIZIAWUDBAIBBQCgggLWMBgGCSqGSIb3
DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI2MDIyNTA4MDI1NlowLwYJKoZI
hvcNAQkEMSIEIAdb3OtnaImUS+Gedlqj32V0NF7YfaNAH+wKLUNDNGFdMIGFBgkrBgEEAYI3
EAQxeDB2MGIxCzAJBgNVBAYTAlVTMRcwFQYDVQQKEw5EaWdpQ2VydCwgSW5jLjE6MDgGA1UE
AxMxRGlnaUNlcnQgQXNzdXJlZCBHMiBTTUlNRSBSU0E0MDk2IFNIQTM4NCAyMDI0IENBMQIQ
Aggtinx6OJLKM4FVztNyWTCBhwYLKoZIhvcNAQkQAgsxeKB2MGIxCzAJBgNVBAYTAlVTMRcw
FQYDVQQKEw5EaWdpQ2VydCwgSW5jLjE6MDgGA1UEAxMxRGlnaUNlcnQgQXNzdXJlZCBHMiBT
TUlNRSBSU0E0MDk2IFNIQTM4NCAyMDI0IENBMQIQAggtinx6OJLKM4FVztNyWTCCAVcGCSqG
SIb3DQEJDzGCAUgwggFEMAsGCWCGSAFlAwQBKjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcw
DQYIKoZIhvcNAwICAQUwDQYIKoZIhvcNAwICAQUwBwYFKw4DAgcwDQYIKoZIhvcNAwICAQUw
BwYFKw4DAhowCwYJYIZIAWUDBAIBMAsGCWCGSAFlAwQCAjALBglghkgBZQMEAgMwCwYJYIZI
AWUDBAIEMAsGCWCGSAFlAwQCBzALBglghkgBZQMEAggwCwYJYIZIAWUDBAIJMAsGCWCGSAFl
AwQCCjALBgkqhkiG9w0BAQEwCwYJK4EFEIZIPwACMAgGBiuBBAELADAIBgYrgQQBCwEwCAYG
K4EEAQsCMAgGBiuBBAELAzALBgkrgQUQhkg/AAMwCAYGK4EEAQ4AMAgGBiuBBAEOATAIBgYr
gQQBDgIwCAYGK4EEAQ4DMA0GCSqGSIb3DQEBAQUABIIBAM9UYLGz/Ye6Z5miwY9f+e2U+7z/
EmXUoCm2f/s+WGueaUuWnwsmu/AtodxX6RdoNnMgzGgujcqWH7erHdjr4JIvD6Maj2R3dLPy
FCFiHKWRYA0V6gLz/x7PRQv/vB/1M9H/Z+Yq5DVKUwRsLvvE7vAl8GmYIoLdQQtRkaPoW56S
w1PublOQYiXeZGkUxRA6C+vr38EXfCiIQ6Ry8Z9AduvraeRISQY9ThW4oQcFXP1rhPhVDmQP
pud9t5iMuFUkeoJN37fE/b4Zuzpmxx7ij52a405zothhmDzpiNsS4FC+HbOzfgYSId6TV4u8
GLLHuDfpsGVLXOsdGCoJRlVOVxEAAAAAAAA=

--------------ms020407030705050204060908--

