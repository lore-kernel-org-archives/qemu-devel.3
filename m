Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C85B1CCF2D4
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 03:48:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIeM2-0002DS-Pq; Sun, 18 Oct 2026 23:48:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>)
 id 1xIeLy-0002DA-UD; Sun, 18 Oct 2026 23:48:02 -0400
Received: from mail-southcentralusazlp170130001.outbound.protection.outlook.com
 ([2a01:111:f403:c10c::1] helo=SA9PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>)
 id 1xIeLw-00087W-I9; Sun, 18 Oct 2026 23:48:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PntV88HMM5RMilTdN/ORr29/yFC3olGgIFDjwJ/Mlpp9kGANnI1id51bYHgXKjH/cFdkHHkxd+efpEFkK3S7X8cVBxbKn20B3eGyOIw2Ml7GunasyrRkV1yCYv6yiJcUHhgVfM4/hRdOsR0ujebrKrwsqGAhOHa/1Rz/aJrebOoyJENbPmyfEAQn/Tmyvp32Gj9BfUhUsPMERxms0+6G0SyS8tpiLxTW/Q0A5ld5ljj1A0/PS+1yKMlwceLKq7W4Wu7qmhqiAyaNdaYKOcNyrxTxanRMOChapnrw7807UvppXBSaJTvJgV1rZJwoUPfd+V8okBlru6ieEXkO8Q894g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MbO0u78AssI2UOR4T8/te8Ybnw43aUdxLPxabfZlxuE=;
 b=S/fCgLzAv8kyqWsPiogoGlDO44o3m8cw8yJr3HD+zT7I0JiPUdnywcitr4KZEg5JjYjk69/tq7wdL8kTQmyecrnuPX/VtdGNGsygltLXt73nGjMQ+i0xm1625X9ft09xCabGXYmL4wEaQYhCKk/bdnWsShKRpin3Ul1WBG/gxkorusHakpI3rhs728/o4YM24U27q7Rj4mItlq7wDXFdzcV6Yfqj75qefPXB4u8GcGbvEJAnvOQIiVPbOAmY28Vg0TJMDjbuSxCMqEd6G03lKX/1aUKV0AIUVqUGmpECCo1sfg8SHgm77Gyv5Gx7gPeeORwAx/BJkdrafPbqpZlm2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axiado.com; dmarc=pass action=none header.from=axiado.com;
 dkim=pass header.d=axiado.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MbO0u78AssI2UOR4T8/te8Ybnw43aUdxLPxabfZlxuE=;
 b=kkiywwR5DqrecJh924S9BI3Jd3qDF46cIstXodmVznqFsc6BCHVuvPrYAicoVSplA60dHYQ7iG0kn0bqAEMlEz390Erd2mDa5650rtdkctgB1FH0AmGWPanIWEIF8TVK9aKYeZhuyh4Mex2Uz+SFQV43L7wTMnF3vD6yLH+XPHiAzv1KI9KxzO5SJuwaMXS3jfY076PjHi2fLBgvZJ3+52GeiJkXYE2HmIazk7NwmwBdNM87e9R8doAldRL5KAGdQJH5W7F9K/TNNB01lhT+bKf7Xp+yN1TKp1ZO4fSJNctoM3sI8Ov8HBaknxn3Qb/uTZWM5QMob3Tnt0GgqbXbFQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received: from SJ0PR18MB4479.namprd18.prod.outlook.com (2603:10b6:a03:37f::19)
 by MN0PR18MB5845.namprd18.prod.outlook.com (2603:10b6:208:4c1::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 03:47:55 +0000
Received: from SJ0PR18MB4479.namprd18.prod.outlook.com
 ([fe80::eaf4:3aec:73e:d5ba]) by SJ0PR18MB4479.namprd18.prod.outlook.com
 ([fe80::eaf4:3aec:73e:d5ba%6]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 03:47:55 +0000
Message-ID: <679bb17d-0df5-47b8-9ddf-89f3bbf0dfce@axiado.com>
Date: Mon, 19 Oct 2026 11:47:50 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 00/13] Add Axiado SoC AX3005 and EVB
From: Kuan-Jui Chiu <kchiu@axiado.com>
To: mark.caveayland@nutanix.com, philmd@oss.qualcomm.com,
 163wangjack@gmail.com, peter.maydell@linaro.org, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
References: <20260911051532.2378501-1-kchiu@axiado.com>
 <348cfd20-66fd-42ed-b338-79dd39df6324@axiado.com>
Content-Language: en-US
In-Reply-To: <348cfd20-66fd-42ed-b338-79dd39df6324@axiado.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TP0P295CA0011.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:2::17) To SJ0PR18MB4479.namprd18.prod.outlook.com
 (2603:10b6:a03:37f::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR18MB4479:EE_|MN0PR18MB5845:EE_
X-MS-Office365-Filtering-Correlation-Id: 5bad5bed-ab80-4446-bd4e-08df2d93c219
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|13003099007|4143699003|56012099006|261009223027099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: skd3eKQpSga3HMkgyzyAaR2qDCqBseAR4ToYjshJhgzyzq2MtwcMsDw3nafmqoZa51qW9DwG8WQd8KW87XRKS87/6SG5g9PB1nLRnns1cqtj8oKvakf++gBev442+eB/1hWWasDV4MA+HguRVEBnP8VIx4yccDk87XC76BoqZ9SdjE1Rw+8SPxpDTRhHf4SFQHo1BWC+mka5JszOMIsqZmG8N6AEJwQzmjJzURLzTIXXHeJgTOkhF3mvfne74T+2kbh5Cx575wCMP6z0hC+LtQK7NMEmdHE/Gx13lZJV2t7lKivUldUUiZx7+w3AzART9/G1NnPl9/h4NoAA74XU/zDH6zIXG5PvC/268xspAR0W60yV51aCj9X2VOzmR7+ySv7RUMvEauK2sGqSljNLlf/IYcawwaK736ZJDgfc+4Fysth0P25qIs56TSCCiOOQ0OfnwvabOhc0fqSKwSqJMFarlKMn81Dv2dvSBcvOzdPbxdV8bf1MuXmGQbxGmSAlv8jDh84uWRJChVgPGTruzJG9/UhB3RPUI2g3F5bdrD4TKcSIwWJSFlNxpj9rhy9aoupjll21BMaCQ6D7XXKvdekI7GwiHJmT3iwUK1bZUG8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR18MB4479.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(13003099007)(4143699003)(56012099006)(261009223027099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dkc1K1NSeDhyUm5zTEUrQ3ViYktNU29WTlRienVDbWVKelh2THVjNWtrTFZW?=
 =?utf-8?B?eDJWeDNTZTVmOFBuOUlQS2NkNDdvOWorOGlEVEdxeTdvU3d1UDJDcUluQUZC?=
 =?utf-8?B?UFlIOXVhSXFVcWViVzhhOTh0Q0NRTThLOXNtTEEzSE1hYnIrYzhRZ0srRjFp?=
 =?utf-8?B?emJ1bkg1cjBZRTkzbkVVVjdqdGs1Yi9HY2hDRlVpb3ZHRkh5RFRselBpbm00?=
 =?utf-8?B?ZXd0cU5kYTVDTUluSHFwR0twZVBXdXV0MWVmeG5hQUxjNTVRMHJhMmFubS9j?=
 =?utf-8?B?eE9WM2kzbVNFdEFFTTBWQmJTdHd0dWE2azN6MDdYcGpWM2lrVmdKZmN3N3RV?=
 =?utf-8?B?aWMyZytFckxOV1BHZHdQenYwWTRRNStCVmhWaHI2ZGVqRWJsS3RudDhjTUtK?=
 =?utf-8?B?Snh6Y0JLVHhBcmxsS1RoR0R5aW9FVTFXU0FEY1JmLzB2MmhRZDAxcWRsYUwy?=
 =?utf-8?B?WEJDS1lLVEQ3WmdsSHNoSlhFWXRiajBySGpEUFRsV0t4UkswUVEzdzNEQmRY?=
 =?utf-8?B?K0xiaTRKT3p6aWV2K2REM0RPUWttazRFYXlmTGx1UEI4NWZ6MGVxQlQ4aHhW?=
 =?utf-8?B?ZEcxckM4cDdFZTNKN0pQVS9FRWcvaFZBTTRzSFplY2NCWDlaNGtpWWZuakgv?=
 =?utf-8?B?OG5zY3BJT3Nxci9jYitweFQwc3cvcUVZdCtvb1NtVHkzemhvSFRyNFpjYmM0?=
 =?utf-8?B?c1BSMUpRTU1XUzBVN2VJWGpjanN6SWFmSStJOSszNG9hTmJvelZqMVR3NDhw?=
 =?utf-8?B?U2VzOW1XU3REZVlPL3JKUndUdXV4RUdld1U3SmJQdGVXdE0rYzBNZm1CN1Zm?=
 =?utf-8?B?ODFtZXB0SjNCTy80MzhydXZiNEpqU2x3QWw0OWZVL2laMUg1VzdhL2o1WWQx?=
 =?utf-8?B?THhiRjJxQmx1Z3BwTGhIbEo3WlR5THZ6YUEzVlVDMUxoSitqMlQvdDREaTJR?=
 =?utf-8?B?Qnc1Q25nM2xnWkplVnprWmxIV2ZFSklMSWI1bUNKak5kUFZzRVFXZEJXdHZz?=
 =?utf-8?B?L2I5Mk9JNXI5bW8vcUxRUFhIOHI1ZDdydjN1NjlObVAxTEN4ZVAxS25EWGlu?=
 =?utf-8?B?cjdJUDF4aWZyRW1OTXlDQkRlTjd2czBUSnlvWDBZWEcrRjlJNnV3VytxUFZY?=
 =?utf-8?B?Z3J2blA4OFFxODBGajRpVmgxVVlISG56dE5BUUMvRFR3bEJGeEVPODVUcGpk?=
 =?utf-8?B?TXRPdEFNQklISTl4TGtZSWxOTUdOckEwV2VIdXRnd08zOXhJUjRxRFRwQjJx?=
 =?utf-8?B?eEx3TE9VdnNmWnlBNDlwTG56dVJ2cDNSM0lMbDFGOXNkeHMrOGFDZEhFSDJN?=
 =?utf-8?B?Q1JQRWxSTHFvUVRxRjhUaHdRMU9CbmVWamVGZjNIV0dpWnQycFFzQXdJWnpn?=
 =?utf-8?B?R2FBRW5jdDVHeU9oQStqUUZnYXRpdVFYSUFqT1V0d0c4VVE1WjZUY3hUSlpz?=
 =?utf-8?B?NE94Y0tyM0xuYXZCWU1qc3VIWms4bHRGRVlQQUJQT1hQQnI0VkhXbWx4MERL?=
 =?utf-8?B?RFU1aFNWT3ljaWEwaXh0T2k5d2x2c2s2K2pvZ1dEbFc2L0lJTTBUMGRXVFVS?=
 =?utf-8?B?MnNCcXZUbTduU0lKbDBIaWJnWkVtRWk0azVBOTl6b2lpSlVJOFRLbzRucDAy?=
 =?utf-8?B?UENLNE1zMGtic2hvYkgzYnJUdHBLMDRBNWw2RDhLdDJOSVpsdmJsN2U3dzFZ?=
 =?utf-8?B?MWtIc0trcTdNTHlZRmUwUkdISlh3ODEvRzhSb0xpSDRuaWsxR0h1L29FZFV1?=
 =?utf-8?B?RDNFd3hLQ0h1MlE0eUhwbkN3NTlCbWdWdUExQ2ZmTlpITVZvMFlYTDM3clAz?=
 =?utf-8?B?dHFwSGlGSm9pYzFFM25GbVVVSU50Zys5NkhEM1lVeHQ2S3o2UE1DNW9WakhB?=
 =?utf-8?B?TGdsQUhmQW54SDdWWURpc1dSVkZNN3JvYTc3SW5ScFoyMDlubmI3eFEyelB5?=
 =?utf-8?B?SXZoa254eTczTmtmd2dyazdVN1JXQjJjbWxnSEFLekZlYW1DK21wRnBsZWNC?=
 =?utf-8?B?NExubThKTkFnSUJ0anE5d2podDV0U3RrcldmdFdPSHZrYkQ4a2FPZnFCa1hM?=
 =?utf-8?B?TXdlMnlqcWZwUjE3VUN1eEEvWUUxZ05kaUNmbHE1a0xEK1ZHUVp2Q0dlR1FL?=
 =?utf-8?B?SS80MmdnUDV4N2dwb3VRdzh1SnBWSmhPTUhhU2hqR0ZvK20yVGVJcHJra2s5?=
 =?utf-8?B?KzdYeGh5QndlZWFyWm15WDdqM2U3d29wN1NKcTE5am56dFhqa05UOXBzeFNK?=
 =?utf-8?B?dFkraFplSThSOU1rV2xRTkQwVDF6VDRhQk5xemtwZWV2TGFYMkFXUEtqVXVP?=
 =?utf-8?Q?WnjFSU/4ZtSFgV3CNs?=
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bad5bed-ab80-4446-bd4e-08df2d93c219
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR18MB4479.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 03:47:55.0921 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dzQ6i2nnj1vKOvtweT7K8Twy2DRN0jZi7zqgoQy2Znln9gWeoLVy2OmF66LX+wAZ58FFNAJPWcwqBtEdcvzcNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR18MB5845
Received-SPF: pass client-ip=2a01:111:f403:c10c::1;
 envelope-from=kchiu@axiado.com;
 helo=SA9PR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, URIBL_SBL=1.623 autolearn=no autolearn_force=no
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

Hi reviewers

Please help to review this patch set
[v7] Add Axiado SoC AX3005 and EVB | Patchew 
<https://patchew.org/QEMU/20260911051532.2378501-1-kchiu@axiado.com/>

Kuan-Jui Chiu 於 2026/9/29 上午 11:19 寫道:
> Hi reviewers
>
> Please help to review this patch set
> [v7] Add Axiado SoC AX3005 and EVB | Patchew 
> <https://patchew.org/QEMU/20260911051532.2378501-1-kchiu@axiado.com/>
>
> Kuan-Jui Chiu 於 2026/9/11 下午 01:15 寫道:
>> This patchset introduces Axiado SoC AX3005 and evaluation board for 
>> emulation
>> The model for Axiado SoC AX3005 supports
>>    4 Cortex-A53 CPUs
>>    Arm Generic Interrupt Controller v3
>>    9 Cadence UARTs
>>    1 SDHCI controller with PHY
>>    8 Cadence GPIOs
>>
>> Refer Axiado website for more product information
>> https://axiado.com/products/
>>
>> and minor changes for the compatibility with existing AX3000 SoC model
>>
>> Test plan:
>> 1. Verified the machine "ax3005-evb" with following command
>>
>> qemu-system-aarch64 \
>>      -machine ax3005-evb \
>>      -device loader,file=bl31.bin,addr=0x88300000 \
>>      -device loader,file=tee-raw.bin,addr=0x88400000 \
>>      -device loader,file=u-boot.bin,addr=0x80000000 \
>>      -device loader,file=fitImage,addr=0x80100000 \
>>      -device 
>> loader,file=obmc-phosphor-image-evk-ax3005-qemu.squashfs-xz,addr=0x80B00000 
>> \
>>      -device loader,cpu-num=0,addr=0x88300000 \
>>      -device loader,cpu-num=1,addr=0x88300000 \
>>      -device loader,cpu-num=2,addr=0x88300000 \
>>      -device loader,cpu-num=3,addr=0x88300000 \
>>      -nographic \
>>      -serial null \
>>      -serial null \
>>      -serial null \
>>      -serial mon:stdio \
>>      -drive 
>> if=sd,file=obmc-phosphor-image-evk-ax3005-qemu.wic.qcow2,format=qcow2
>>
>> 2. Run QEMU test suite
>> make check
>> Ok:                360
>> Fail:              0
>> Skipped:           21
>>
>> make check-functional
>> Ok:                31
>> Fail:              0
>> Skipped:           6
>>
>> Changes in v7:
>>    1. Add patch ("hw/arm/ax3000-soc: Revise variables accodring to 
>> QEMU idioms")
>>       to revise the name of the first member in struct and remove 
>> redundant
>>       typedef keyword
>>    2. Add Prasad Bolisetty into maintainer list
>>    3. Fix typo
>>
>> Changes in v6:
>>    1. Drop patch ("hw/sd/axiado_sdhci: Add header guard") since it 
>> had been
>>       merged
>>    2. Remove redundant machines-qom.h
>>
>> Changes in v5:
>>    1. Add patch ("hw/char/cadence_uart: Add BXRS register 
>> definition") to add
>>       BXRS register into CADENCE UART model and add new property to 
>> control this
>>       feature.
>>    2. Drop patch ("hw/char/cadence_uart: Reserve MMIO with dynamic 
>> size")
>>    3. Add patch ("hw/arm/ax3000-soc: Enable BXRS support of CADENCE 
>> UART") to
>>       enable BXRS support in Ax3000 SoC
>>    4. Add patch ("hw/char/cadence_uart: Reduce the size of MMIO to 
>> 0x80") to
>>       change the MMIO size to 0x80 from 0x1000.
>>    5. Add patch for Ax3000 SoC
>>       ("hw/arm/ax3000-boards: Add modify_dtb for discontiguous 
>> memory") to fix
>>       memory issue while -dtb option is applied
>>    6. Add patch for Ax3000 SoC
>>       ("hw/arm/ax3000-boards: Remove redundant pointer from struct") 
>> to create
>>       SoC instance during init() and remove redundant pointer from 
>> struct
>>    7. Add document for Axiado SoCs and EVKs
>>    8. Add functional test for Axiado SoCs and EVKs
>>
>> Changes in v4:
>>    1. Add patch ("hw/char/cadence_uart: Reserve MMIO with dynamic 
>> size") which
>>       allow other models to revise the MMIO size of Cadence UART
>>    2. Change the MMIO size of Cadence UART to 512 KiB in 
>> Ax3000/Ax3005 SoC to
>>       resolve the overlapping region issue
>>    3. Add memory guard in Ax3000/Ax3005 EVK to check the memory size 
>> specified by
>>       -m option and set the default_ram_size to the RAM size 
>> supported by Axiado
>>       SoC
>>
>> Changes in v3:
>>    1. Remove patch ("hw/arm/ax3000-soc: Add missing class_size to 
>> TypeInfo")
>>       because it was fixed by commit 4f50d637e2
>>       ("hw/arm/ax3000-soc: fix heap overflow from missing class_size")
>>
>> Changes in v2:
>>    1. Add patch "hw/arm/ax3000-soc: Add missing class_size to TypeInfo"
>>       to fix incorrect class size
>>    2. Add missing class_size "Ax3005SoCClass" to ax3005_soc_types
>>
>> Kuan-Jui Chiu (13):
>>    hw/char/cadence_uart: Reduce the size of MMIO to 0x80
>>    hw/char/cadence_uart: Add BXRS register definition
>>    hw/arm/ax3000-soc: Enable BXRS support of CADENCE UART
>>    hw/arm: Rename ax3000-boards as axiado-boards
>>    hw/arm/ax3000: Specify SoC name in header and variable
>>    hw/arm/ax3000-boards: Add memory guard
>>    hw/arm/ax3000-boards: Add modify_dtb for discontiguous memory
>>    hw/arm/ax3000-boards: Remove redundant pointer from struct
>>    hw/arm/ax3000-soc: Revise variables accodring to QEMU idioms
>>    hw/arm: Add Axiado SoC AX3005
>>    hw/arm: Add Axiado Ax3005 EVB
>>    docs/system/arm: Document Axiado boards
>>    tests/functional/aarch64: Add functional test for Axiado EVKs
>>
>>   MAINTAINERS                                   |   6 +
>>   docs/system/arm/axiado.rst                    | 128 ++++++++++
>>   docs/system/target-arm.rst                    |   1 +
>>   hw/arm/ax3000-boards.c                        |  71 +++++-
>>   hw/arm/ax3000-evk.c                           |   4 +-
>>   hw/arm/ax3000-soc.c                           |   5 +-
>>   hw/arm/ax3005-evk.c                           | 115 +++++++++
>>   hw/arm/ax3005-soc.c                           | 226 ++++++++++++++++++
>>   hw/arm/meson.build                            |   6 +-
>>   hw/char/cadence_uart.c                        |  17 +-
>>   include/hw/arm/ax3000-soc.h                   |  13 +-
>>   include/hw/arm/ax3005-soc.h                   | 102 ++++++++
>>   .../arm/{ax3000-boards.h => axiado-boards.h}  |  10 +-
>>   include/hw/char/cadence_uart.h                |   4 +-
>>   tests/functional/aarch64/meson.build          |   4 +
>>   tests/functional/aarch64/test_ax3005_evb.py   | 140 +++++++++++
>>   .../functional/aarch64/test_axiado_scm3003.py |  62 +++++
>>   17 files changed, 889 insertions(+), 25 deletions(-)
>>   create mode 100644 docs/system/arm/axiado.rst
>>   create mode 100644 hw/arm/ax3005-evk.c
>>   create mode 100644 hw/arm/ax3005-soc.c
>>   create mode 100644 include/hw/arm/ax3005-soc.h
>>   rename include/hw/arm/{ax3000-boards.h => axiado-boards.h} (71%)
>>   create mode 100755 tests/functional/aarch64/test_ax3005_evb.py
>>   create mode 100755 tests/functional/aarch64/test_axiado_scm3003.py
>>

