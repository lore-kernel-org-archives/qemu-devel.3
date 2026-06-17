Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FA3CCD98E4
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 09:48:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZmrj-00067r-Sc; Wed, 17 Jun 2026 05:47:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>) id 1wZmri-00067Y-9o
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 05:47:22 -0400
Received: from mail-eastusazlp170120007.outbound.protection.outlook.com
 ([2a01:111:f403:c101::7] helo=BL0PR03CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>) id 1wZmrg-0002j6-Io
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 05:47:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TZsJ8hrDv5+6WqIuyf1a17N+Qx1fyUytYUbopP9F2mmfgME0ba2QUZKo4DTf3lHqxYihuTkif4djPbBv3pxhzI/Y9gTYaU8tYa3N4etpor3qSbKogjpWdE4BfbKfNPra6Si2ESILjtGkZLDQ3Q2L2ntN24cSDB6/TkYeqVuTaMoqMfOjhX8xgGaJ0ZXmBazLQMJI8mlr0iG0TWS1NaoEbhgzBZwrnrXSBR90ogfEkAruN+0JNvPG1DfXsEUSOnru/TVk+XDt6eKed/KHdNOdFJoPWuXq1GH16jBTngrm2qq/dz37LLDm3hPC3JWxyoO5D7LaNEB2AqWIQhCDnyzMOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DvZoxpAGCYlSYFrF7QVT+aV/CmzBLiIsn/+HxehBK1s=;
 b=fpEQC3ctXFxjDJ96uMDjGVfbooV0/tYRMQkBAxfdDqWGtkmzX1YzZm1Q3ZWfThjS4wtuPaj9plIWGNBYBiYe/WTc4HZ5Lrez+vOlRZ3LRipC8zcSyiIOvL8qnERqUlzDwt7bsrEy3wx/YZeFiIOy8S52DuJqWemNS18H3r2SZvIURIQshPUgY4gqn3XmBW9nsiO7Q2LnBT9z3j49Fx+qM4K39ZzDlH0+xGCcRzeY/NWu6Nlxjsetgo6LILUcgUnflPbDIImKLpNOLHeIWgr5PxGYjAPHYaO/pXwCFekUDgtop1zaCPtloL+FB4kmVHoUiYDXUP/2XoRv+kmnE1FtEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axiado.com; dmarc=pass action=none header.from=axiado.com;
 dkim=pass header.d=axiado.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DvZoxpAGCYlSYFrF7QVT+aV/CmzBLiIsn/+HxehBK1s=;
 b=eXwstscJzHeBdgw/UCuUX4ySuKYDkdeesZeSAWjqyTpjqZvX+bVW6/mDGP1MjAiNwFjZo/tOG/P1Vx82HNr/hXC9c4wknK491amyeHzXah7exlJ2a+kO54Fwn8uOWK1BCdCF1OlJFAZ/Aevc1Mma0HJbA1Qt6IzKKzOsqBH3kgSB3SI9Y6TQAn9rVJ2eW6fmDGJ2upnrJkOKNRO8g5Qs4UQuwkVHy2CF965z0WHlmB8Qe8R/U9fS6T/jzcF6SfS5XouRevqbB5cS2OYranNyy0w5I5OTXkk2eX8IqpMz9KBnIp5ISbHVYTDbize4jjL4uTjFoXKS6gGdkXJOAqd9Aw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received: from SJ0PR18MB4479.namprd18.prod.outlook.com (2603:10b6:a03:37f::19)
 by EAYPR18MB988350.namprd18.prod.outlook.com (2603:10b6:303:2bf::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Wed, 17 Jun
 2026 09:47:15 +0000
Received: from SJ0PR18MB4479.namprd18.prod.outlook.com
 ([fe80::eaf4:3aec:73e:d5ba]) by SJ0PR18MB4479.namprd18.prod.outlook.com
 ([fe80::eaf4:3aec:73e:d5ba%3]) with mapi id 15.21.0139.009; Wed, 17 Jun 2026
 09:47:14 +0000
Message-ID: <3855010c-ce56-42ed-b752-e3bc374abe97@axiado.com>
Date: Wed, 17 Jun 2026 17:47:11 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/6] Add Axiado SoC AX3000 and EVK board
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
References: <20260617085030.2586072-1-kchiu@axiado.com>
Content-Language: en-US
From: Kuan-Jui Chiu <kchiu@axiado.com>
In-Reply-To: <20260617085030.2586072-1-kchiu@axiado.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TPYP295CA0001.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:9::18) To SJ0PR18MB4479.namprd18.prod.outlook.com
 (2603:10b6:a03:37f::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR18MB4479:EE_|EAYPR18MB988350:EE_
X-MS-Office365-Filtering-Correlation-Id: 55d906de-2c62-4275-f5f6-08decc556944
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|22082099003|18002099003|3023799007|56012099006;
X-Microsoft-Antispam-Message-Info: dHNKX7uHvEbRc+QjhTFPuUxlgzLTznA42ro/nv0sNp/4tYxFIhzoBIY4gvLIA7kWyNB7qJYyaMwgxVs2QvbJiSvJQjR3D628NA8jCkpMjJhSPIvHIH0P6DawHqHsUcL4qm2C7ifhqFsjQa/smtTMnzD/i5N99jfvgm7ZW0V1UNFoY87Qkx+6dw/y9akUMJ9bdTAtIJKbQ4ZWjzlAacb3fG1wZ5P8G5C8X9XdqSpxeBJhMvGu2Fpr7dDZveG0va+AqajUhL9vG4P+brWtfkJKID6LaobHkeR1qG4LP7AVqeYf+judsMet43ixdi9jOYd0x526AokqUjZkXKOlPKee4my850X0hFUUWQ5XCHSUxE3Sjl5qbECbcHmGZwKQkio9ZlJi6/ssiQNa8jKZpe/QxEoEU738TnhtysFhG0wDmOjzscg3zvZneda2urNypakgddgv190EkvWqDYT28XNI5oxC9rrx4oSjZAOuB0hlB0fbXd4JKu3w6r8d42iMg7a46OH6N4jl57x/aNG+jCUV53nw/vGCkmFb0ntjXzEGOZEmVGYJHbgHz/DsS29e1jbODl8Wm+ZhbpR1bZGu9vxLAVYJeqIRmw4aE+PCZOkYC4Vk8hAGqsFV69QBvLgGMMRpcV6I8lOcL7BaGmF5tclNng==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR18MB4479.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(22082099003)(18002099003)(3023799007)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bDg5OEsxWnpkTlV3SnltYTBZQ3VpWGdjUUc0d1F4TVRFK1FkWnZwdHJXbjht?=
 =?utf-8?B?NFJmVjV2UzYvZ2NLbEhkZjNmYUN1M1djbVE5a0hBdDdrREFFcWJiS0pJNlFZ?=
 =?utf-8?B?akxKb1JxZ0xCd0tRNnZTQWZSVkdxWU00bjhqYnBzNjhDLzJPekxCVlRpc05n?=
 =?utf-8?B?OEVCbVpJWm54UkFkZDRpMUZENWJ5ZGs3ZnBVZHFvQkhhQW9BTTdIVEpqZ21I?=
 =?utf-8?B?VEdqQ1hFNVE5ZDZQOXpFRmJZcTBkQVNJUU1kVnA0dVJRODhqNG1DQlFFMnUr?=
 =?utf-8?B?Ni9ZVXAwRmxDd1Z6Y3JxR0FqdHp6SGIzMFlKbmNPL1dLallVMldrVlR4UEgr?=
 =?utf-8?B?SzlTY01VVkdnc0lxZVRqWXlXRElLbkk0QkhSbDVaMEYxRUxwcXNKZXc5MnA0?=
 =?utf-8?B?OCtJbHRmL2pJMDFreE8vVjFYZTBPM1hCYlB5VWVSMzQvd3hzSGlRWTN2YnE4?=
 =?utf-8?B?NTNXbE5td2hiM0hoSlhpMFJ4SFVVVGhnbzh4dWFTemo5SnFFR0hLN0gvWUtS?=
 =?utf-8?B?dUtCczZQaG9GZllzY3hDd2RaODRpOXE4b0IySHJ2SStyMDFkZklDcmRxK3ov?=
 =?utf-8?B?bUJBV2NiZUF2N3lteGpoSlBrbVhDa2hXTzZhU1dodkF5OFpKRHZtazFDR0pz?=
 =?utf-8?B?S1J6eC9HUG9kcjFnc0w5YldGWVNwWmtjWUpDVmdVUkU5Y092THRuQk1pT0RD?=
 =?utf-8?B?dlpEUjF0dXd1K3dXUkJjVGVYMHpndEJZcW4wTWJvNUhaTzAyd0FEcld4OGRy?=
 =?utf-8?B?NnFab3RKVE9nZEpTSHM1eERMMU8wbkhMZ1UwZmFkK29WRlZwbS9zUWFxL1Fu?=
 =?utf-8?B?Yml3NE5rOW5yQytuakQ0enhxdHNjNDJOcUJwa3dZSHdvU2hWSkh6U2psYjhU?=
 =?utf-8?B?T29hc2xmUnljb01hczlaQXpFTm1SWm8wR0FZL3lPc2RYK05nZHN6Sk4xaXZN?=
 =?utf-8?B?UjBhdkY2TC85SHllaXdXeFgrelJZc21BK0s4Y0NrZTAvQzRZYXdQazY2T2t6?=
 =?utf-8?B?SmlWVjdHVXZxcXVzK0VtOE5wME84Syt0Mzd3cERYMkpPVnhQOHVVY2diZkVU?=
 =?utf-8?B?bUtqVktxaHVDTG40VzVMSjFxazFVRG4rUTlIRHViZjZkeWROR2NHUXlLL0JC?=
 =?utf-8?B?ajdSWVA3RFN2RTErRCtTeDB2VWRIRkdxOUhsSnhJc1ZvY2F3NHdCOXVGOStt?=
 =?utf-8?B?Q2x4M0lkSFZKNXExQ05pTlVFcFpMSzFWazBnb3RZWVI5OXYyV0FMcmxuZFZB?=
 =?utf-8?B?RnZpa0R2cDBlVXNzb1Z2UW5yQVhSV1NweVFTNklvbUpyeXZzQVoycG8xMm9F?=
 =?utf-8?B?RW9RWVh5ZEZiblhjRkk4anRrdkpOVkI1UEY0Z3d4Z0ltTVJYdDlWWG9UZ0Mr?=
 =?utf-8?B?bnIzQnBLZCtrOWJDei80MWdjd0crVTcxZkYra2s3Z0FncVB6UTFoVERhTzFG?=
 =?utf-8?B?UjBrOFpUdmhtbHRJMXBvM3JoMXZDa2xKSVZrMnNVbG56YzQwYThGWkhNcHFM?=
 =?utf-8?B?Mk1WOEV2V2NaK1BFbHJBWFZWWWcwMzY1ekdaVm9LYTk5OUdVYWMyZ1RmWGRp?=
 =?utf-8?B?cGpCY290RlIxS2FQZyttRFdyVWFnUDBBQVNBMUg4SnRBWWw3Q3ZHZzJMZEcy?=
 =?utf-8?B?blRCTzVQT0JsVWtJdkR2WEJ4N29UUDBYZm5sdkhKVEkyeTJNa2l6RDVwRFpi?=
 =?utf-8?B?cmlTNUdjR3pjdWZ6NG1HUzcyQ3V2Mmt6VFBSSGdNa2ZIZjdKSENWdS84dWFY?=
 =?utf-8?B?SkkvdXB6MnhVV3hNSjQvajg5OERCQksyRzg4ajRDaDM3T0p4VTBpZEtkNkh4?=
 =?utf-8?B?Tm92NlNPQW5BRCs5NUhRSmpjQ0dudVl3cmdpK2xrZklRcSt5MG5vVGNCSkFK?=
 =?utf-8?B?M2tBWk9ZdGNmdHJHbWFoZW91WFg0MTJUUlZPSHNzREtEZXE2eEl4ZkVGQTlD?=
 =?utf-8?B?dFVFbGpQR3owSDNRbnM5S28wRklkbk9VeXpQeE4vZTFvOFhkS2hxQ2hXdGMz?=
 =?utf-8?B?Um0vdElvbHlWc0dWOVEzWXdpdXVkTk9yOXowMFRDbGY0WGIzMjlrTlFJZXp5?=
 =?utf-8?B?bkVEN0VlNGtSMmlObUwwWHUrRzMvZDV6MHlRa21LMTVMTW0wZ056bkZqWldt?=
 =?utf-8?B?a00vSmVNRUY5NkcyTFlPeGFaMzhibWN2MXQ4Q0tNd0lMdEZiUWVaT3NpTkt1?=
 =?utf-8?B?RXBjc2ZMTlpWUEZLNEVlaEFXaXlQazUrN3l5ZXdER3JhKzNQTmx2dG5XS3cr?=
 =?utf-8?B?aG5SRGNLZjAyRjl5dGV5TUtSS0NJaHNaY05XY2JuZ2lhM1NrQVNQMWFrbkhj?=
 =?utf-8?B?ZFYxYmxuenF5UytRQXZWWFhhcmp3SDRJbGJJRDd0aklESmpjTDkwUT09?=
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55d906de-2c62-4275-f5f6-08decc556944
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR18MB4479.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 09:47:14.6281 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m5IcBH959tWcP0TeeKAPds08fHlsXpjVab2JIuY7rjNlPOaL4YVG+avahA2Ww/CS1c42zjoQGhz/uMXyyPPGXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EAYPR18MB988350
Received-SPF: pass client-ip=2a01:111:f403:c101::7;
 envelope-from=kchiu@axiado.com;
 helo=BL0PR03CU003.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Please ignore this patch set , I will add more fixes in v5

Kuan-Jui Chiu 於 2026/6/17 下午 04:50 寫道:
> This patchset introduces Axiado SoC AX3000 and a EVK SCM3003 for emulation
> The model for Axiado SoC AX3000 supports
>    4 Cortex-A53 CPUs
>    Arm Generic Interrupt Controller v3
>    4 Cadence UARTs
>    1 SDHCI controller with PHY
>    8 Cadence GPIOs
>
> Verified the machine "axiado-scm3003" with following command
>
> qemu-system-aarch64 \
>      -m 4G \
>      -machine axiado-scm3003 \
>      -device loader,file=u-boot.bin,addr=0x3C000000,cpu-num=0 \
>      -nographic \
>      -serial null \
>      -serial null \
>      -serial null \
>      -serial mon:stdio \
>      -drive if=sd,file=obmc-phosphor-image-evk-axiado-qemu.wic,format=raw
>
> Refer Axiado website for more product information
> https://axiado.com/products/
>
> Changes in v4:
>    1. Remove ERRP_GUARD from axiado_sdhci
>    2. Optimize ISR update function of cadence_gpio with logical operation
>
> Changes in v3:
>    1. Add a new patch for Axiado SD host controller
>    2. Fill in valid/impl parameters of MemoryRegionOps in
>       ax3000-soc/cadence_gpio/axiado_sdhci
>    3. Follow C99 standard to declare variable in for-loop
>    4. Remove comment "TBD" from empty function
>    5. Define marco for bit definition in axiado_sdhci
>    6. Move object_initialize_child() to instance_init() from realize() in
>       axiado_sdhci
>    7. Remove callback of get_default_cpu_type() from ax3000-soc and set
>       type of CPU to A53
>    8. Update the command to run "axiado-scm3003" in QEMU
>
> Changes in v2:
>    1. Move axiado-* to ax3000-* in hw/arm and include/hw/arm
>    2. Add axiado_sdhci to support AXIADO_SDHCI
>    3. Move implementation for eMMC PHY device to axiado_sdhci
>    4. Use UNIMP to create dummy device "timerctrl"
>    5. Add cadence_gpio to support CADENCE_GPIO
>    6. Enable Cadence GPIO controllers on AX3000 SoC
>
> Kuan-Jui Chiu (6):
>    hw/arm: Add Axiado SoC AX3000
>    hw/sd: Add Axiado SD host controller with eMMC PHY
>    hw/arm: ax3000-soc: Enable Axiado SD host controller
>    hw/arm: Add Axiado EVK SCM3003
>    hw/gpio: Add Cadence GPIO controller
>    hw/arm: ax3000-soc: Enable Cadence GPIO controllers
>
>   MAINTAINERS                    |   9 +
>   hw/arm/Kconfig                 |  14 ++
>   hw/arm/ax3000-boards.c         |  47 ++++++
>   hw/arm/ax3000-evk.c            |  27 +++
>   hw/arm/ax3000-soc.c            | 267 ++++++++++++++++++++++++++++++
>   hw/arm/meson.build             |   6 +
>   hw/gpio/Kconfig                |   3 +
>   hw/gpio/cadence_gpio.c         | 292 +++++++++++++++++++++++++++++++++
>   hw/gpio/meson.build            |   1 +
>   hw/gpio/trace-events           |   5 +
>   hw/sd/Kconfig                  |   4 +
>   hw/sd/axiado_sdhci.c           | 114 +++++++++++++
>   hw/sd/meson.build              |   1 +
>   include/hw/arm/ax3000-boards.h |  28 ++++
>   include/hw/arm/ax3000-soc.h    |  99 +++++++++++
>   include/hw/gpio/cadence_gpio.h |  55 +++++++
>   include/hw/sd/axiado_sdhci.h   |  21 +++
>   17 files changed, 993 insertions(+)
>   create mode 100644 hw/arm/ax3000-boards.c
>   create mode 100644 hw/arm/ax3000-evk.c
>   create mode 100644 hw/arm/ax3000-soc.c
>   create mode 100644 hw/gpio/cadence_gpio.c
>   create mode 100644 hw/sd/axiado_sdhci.c
>   create mode 100644 include/hw/arm/ax3000-boards.h
>   create mode 100644 include/hw/arm/ax3000-soc.h
>   create mode 100644 include/hw/gpio/cadence_gpio.h
>   create mode 100644 include/hw/sd/axiado_sdhci.h
>

