Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1227C43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 02:44:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgZJJ-0003Uj-3u; Sun, 05 Jul 2026 22:43:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>) id 1wgZJF-0003UR-HH
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 22:43:50 -0400
Received: from mail-eastusazon11022134.outbound.protection.outlook.com
 ([52.101.53.134] helo=BL0PR03CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>) id 1wgZJC-0008W1-0D
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 22:43:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UFH0LKR0fqjwFlqkdkP5AwWiCeMDVQ670kI6Fm84K7fg2hQMJuxCNUkDX4jK45LOVu4IgltBN+RNvAgVv/zIcahbdKlOylAQh09olmGa9sVZAsOsHvwgnGuG2ydsq6+3Simc8oPpIYKLDVZ9v0H0PzT21esJ8tMqwWmJwzGZqR5FuByN+ZKaVr2ifSS0puGTi7U1d4iXSQTihD1wViVDXlDxK6FCvpXx2MibdnHSJ+apveJwFtne1bzQ2fWpVHBkwYKqmm9sUjj2TUagktnbosV9qJEdjjVdbc/ggBboNJNdK3SPdM9nZ8GcOWnsYGRb36wMNT6f1zjwZQUN76MeQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9iE0dTHhixEQu5HwakuOvvAygHncIej410krVnycaaA=;
 b=HpFvSBexeqiSvjsqZZaH8WyK8uRePnxWNBFKffwHYh21E45MJnjxVlb+bdW1fUcBvqF5kKVc5TyfYoDdZBy4F+cjBAfcApWNSFt9V0ZgcYjosNVTj4mYkKJRrgKUM3uTP2N4KTiQ7ZI/qerA05JEDFlOwWG37KU3G2AX8HWkncY7Gp+yyHa40RIqxzD456o4qqJKeiyj622YlXNyrlyOoD3/uU+4Nupcx6nSy9SAPf12atKk5EURMKv4ibSiwdF1qXBFaQZwmVVVfluva9+bgrAZBfUP8+elnJzUCPdnuizesu17EScyEoH6dAT9RZGZ0/ZPNSIQJkdDrC5n+6xLwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axiado.com; dmarc=pass action=none header.from=axiado.com;
 dkim=pass header.d=axiado.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9iE0dTHhixEQu5HwakuOvvAygHncIej410krVnycaaA=;
 b=f6Uw03HYJJyK5F9wVhLEfJ1pBzqnHaJ3/9vbswZu9XI2yeDmGncFvj9cB/UqAu1v6zzkrZxdRzCmv3toNzSK60zrIaQmgNzb/Kf75zATWgtpEZ23TiGHIXIbHOVEeoJXF5Kh6KQGGAsQu64c2ocxosO/a+jnVuI4tAH+y53Q+9AjYLXXXD2nisBoID75E0JzXixk5HPd52e/R0w8hphxl4x8V11VTP7iyc5u7eV+U2hA8vg9zenyBmrQViCX4arAYncBewVwqn4w3ApztthyE26TQWeQYp1HIl9a5vKPtvBIE5VY4TG2mJBzuKmvKVQMevJir6qYDmc9cAGxAzwtUw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received: from SJ0PR18MB4479.namprd18.prod.outlook.com (2603:10b6:a03:37f::19)
 by BL1PPFFAF0BBFFE.namprd18.prod.outlook.com
 (2603:10b6:20f:fc04::dd2) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.13; Mon, 6 Jul
 2026 02:38:41 +0000
Received: from SJ0PR18MB4479.namprd18.prod.outlook.com
 ([fe80::eaf4:3aec:73e:d5ba]) by SJ0PR18MB4479.namprd18.prod.outlook.com
 ([fe80::eaf4:3aec:73e:d5ba%3]) with mapi id 15.21.0181.012; Mon, 6 Jul 2026
 02:38:40 +0000
Message-ID: <ae7c1ca5-2268-4b19-8ca8-188974497955@axiado.com>
Date: Mon, 6 Jul 2026 10:38:37 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/8] Add Axiado SoC AX3000 and EVK board
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, philmd@oss.qualcomm.com
References: <20260622060507.83195-1-kchiu@axiado.com>
 <CAFEAcA9aPwGf9acMvBMON+mNU+uyvMs33wrmAXxoTFR80vi-rQ@mail.gmail.com>
Content-Language: en-US
From: Kuan-Jui Chiu <kchiu@axiado.com>
In-Reply-To: <CAFEAcA9aPwGf9acMvBMON+mNU+uyvMs33wrmAXxoTFR80vi-rQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TP0P295CA0054.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:3::18) To SJ0PR18MB4479.namprd18.prod.outlook.com
 (2603:10b6:a03:37f::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR18MB4479:EE_|BL1PPFFAF0BBFFE:EE_
X-MS-Office365-Filtering-Correlation-Id: ef335ed3-a1fc-42ba-f88d-08dedb07b06f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|18002099003|22082099003|4143699003|56012099006|5023799004;
X-Microsoft-Antispam-Message-Info: La6MD4+GCPLd2r+YBhNxcAGE4xCJIjcT75l/tPWIHaKXWN+Jn4/HWYCYN8UzPaV/pbShkuDL7WVywzB/MFYXbOVXl8DBvNUy+qb+NjXLoH7iLs4H8wGD8P/4GemuVDJpP3QZDAHFq3c9vZA8R7Pip768Z1bSOpPWzX9HeWQQpL9dcxG5a295wKEgUoo5bY51X38u+UE9VMks5Dx+uKI/QlYfm93QyHWP7ZHO1MmnpdvAiUVLb1ujN9dLsQps0G1FCmz5SRNQv8NZ5JLgcoVUM8wiwZVI59bx6fiGIW12yhe5AEh2Aail1ByjGvLlEMlM2QmJijmJSdEQgLJJHHcZE+VlAM5Ku3p4/TEqnUXol9a7QXovBUSbrsmt+RhTX9zlLQuBZc+WDXn0G6troR9Xt86/KSUstYKp2wN9v6LrkOlnp0uyQ7h8ygyZOt7Q9lko0nM/LKLbhC1ekRxvaGrG65ZDcEYb7kYI1h54t/z4ydu5zXt5v3PtyboAEb1c/5QELfhq5/0xOKAPoKjJpvI6A4uY7VaazRKkbCqUeBI86b1ZPT12zQ99UCjZ7BwrpiN/LaLaC6YsEg9z+wDRTidNNPFz3j3fZQKK8EnOUsuVkaYCyv382+Qg2x17ElfxZ/R38oi8H6mFIfht5oEFeD2g5aXsckrNvTaSjldgjZrs1Y0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR18MB4479.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(18002099003)(22082099003)(4143699003)(56012099006)(5023799004);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SzJrMTh3S1BFQmZBYmNZSi9WS1dQNnZaZjVmNjJBSUxwalplTC9yWXdaenht?=
 =?utf-8?B?VURBaGFkWmNqYjNKV1lzQ25OTFN5Y2Uwdm5abndYemU0WkVlUkdCWGhQUVZI?=
 =?utf-8?B?NWdTQndac1p4d0NtcDJIUGVYblYvcGFHSDJyeHJyNjIrcC9JdnF5VGZXYW1L?=
 =?utf-8?B?dFREN3U2eGZmTlg3aXI0U1JaaGR0R1hsb3FkMStXNDVvSHNVWEZBRU1SNi9Q?=
 =?utf-8?B?eXJwazF3Y3VkNVNEV2R5bVFVbVRxTVRBWU5XNllSZW5yaExOb1JtZXpLNFhk?=
 =?utf-8?B?Z2E5YVVDYlJqUnVhM3dDSnhBVEp6VkFkVDgrYmpUbm1IZVB1alRiaUFoMXN2?=
 =?utf-8?B?NUl6dEh2MFdySW00dWlmNlJVd1VuNkhkUjY0UzJjOEhlQ1Q2aVc4MWNqaUZK?=
 =?utf-8?B?YUtMOEszSHdHeVE2a0ZzbFIwdHMvSHZxTVVrdlY2RFJKQU1nK2hvUlBtbU9n?=
 =?utf-8?B?aHlBcEtFUGp0eUppNTcvSFd2SHB3QTlxYlpIdy82eVpOUDQ0STdIRkZRS2tn?=
 =?utf-8?B?dGpWV05SVzJ6Q2pzKzd2cGtLVnpQRXErQWtkVEJhU3VHY2M0NzcxQmdQWHJI?=
 =?utf-8?B?anlCelNyZEZhM0RoY3RGTCtXYXlJeEhvUUJVanJnY0ZYc2liZ2lhaUE0dGM1?=
 =?utf-8?B?MHdLc0FtWTNLamVpNGN5VytabkhtUnAySmx2S0tjVGd2dDF0ZmZzUWF5NEV3?=
 =?utf-8?B?citEaXJsQnlPU21jdUNqNXdqWjBEcDdvZllld29DaDlZaGczUm5rK2ozY2xT?=
 =?utf-8?B?R3ZwbytiTFh1QkFCMWtjT2ZqTVQyU2RhUWNiSXJ1bjdRbW1PL0NEQ2Y5U3Zz?=
 =?utf-8?B?M3ZOb2VVcVMxM3c0Nlo1dE5zQTJTbHAzbnFWQnROK0FaOUN3ajB3bGVCZHhV?=
 =?utf-8?B?eGc3N1lzWllheUJuamFkRjZqWlFvQkJ5MDhWcC80ZWIzMjJzUUptcFQyRUFj?=
 =?utf-8?B?b2xGVzhlMDJrZElrZDV4NFdCbWExQlEzZVRUU1hUTlBGQ3RlUFNpanRqR09m?=
 =?utf-8?B?b1czR0dIRFhwZm1Oa2pJRmZrQjRiRjhPT2ZxTXpybkNLM3pSMWRDWkxyUk5E?=
 =?utf-8?B?N1ZnWGNia1hOb3BsMDFGcVdpeGVhNDZYZXNQbGdpR3dIN0ZVMmFoTHVxR1pK?=
 =?utf-8?B?UkhWcWNxZFl6VDNmZ2hKZWc0Q0tBbWFJTzFXZEJWQXZjcUxMNzRjWnVPV1po?=
 =?utf-8?B?VFlUcCsvSlRPVlJKb05kbjVHZGVoLzFueVJVSDN1dmlCcHRLMjQvK1UrL2dJ?=
 =?utf-8?B?NDNLS3pKUVJLV3NZeGozcTJmOVQyYkN6cUlaS055NzZTNURLRnpTNmJSaTNR?=
 =?utf-8?B?UlZLcjdidzNKdzBTczNLNjZVL3lUU3RVMGEzU1RPbTVtNm9QTnhFZVh4aFJ0?=
 =?utf-8?B?MVZCYkdsUnRnZEJSWTQ5cW9GOXFHWWw1RXQ0VE5pcHgwaEJla3V5LzNVWjNx?=
 =?utf-8?B?aHkwTlNBMko0SHFnZVFPOWRwMlNNb0ZiL2FJMWdQNGVoN3AwL3haNTZsVHh6?=
 =?utf-8?B?Vno3OTlDRGc5N1hHUWFadkt2UENHRWcvcnVuNk5xUlVkU0RrMnBXVHpQQVh1?=
 =?utf-8?B?M24xRnFpYkJ0QzU4TGRzUTdWS0Y5N1czeUs5OGpBRXZGV05jVm5nS2dkS2Mw?=
 =?utf-8?B?bHE5bDdpMUl5WnVwWEYvTTlRRWd3OHY0Tk5nRFNHekZMNzlZSmxERHZiZDRW?=
 =?utf-8?B?dEJPWkdzNEZSVWt3TmRxdEgzc0dsRmRHTjdJb1R3bW41T3R4SWRwUEhISlIr?=
 =?utf-8?B?THplTUE0SnVNVk1OMlNTOVBaSFFDN3ljTGdGTDFRcWlYZGZCYjJKUnQ4WDl3?=
 =?utf-8?B?MU56emJJUWlJQ0lVWEdCWVRkU3lETlhyM3RxUlpjY2xObERXbzhySlVyRFEz?=
 =?utf-8?B?QUdibW94ZDZNYUdCcWVrTjRKN3E2NlpZVG0vaVlxdXBCYzA0dXQrMkZBVHhq?=
 =?utf-8?B?UDBLd0MzdkFkcWJIMSs1K3A5anZTVmkzRFJmU0hTY2VTQjAyZGZmbEU4ckpJ?=
 =?utf-8?B?LyszSk11SFpIc0FmcXpEY0N1ZXExL1dGRkV3UXJvdll5dCs4NEJBVEg1K01u?=
 =?utf-8?B?ZzRxQmJza05GRDRIeXYwejJEdkxEM3Y3aWlTMzZBOVNhQXA2WGZEWHloSElZ?=
 =?utf-8?B?SUtwK1hXdWlobzRYQkQ5bDA2L3Q3aFQ0VWZXQnhLWjZqVWZkUWdoWkVZUzRC?=
 =?utf-8?B?YUZqYW9xMVBjWHkrajlKbk85RGtMOXZtb1R0Z3AyaFZoSVdHbTVLaFVqQVVl?=
 =?utf-8?B?b0dON3d2TDNXVHZXa2J5VmJiUGFVTDd2bXYwVVk4NXdxQko3L0dwdzhEbGdJ?=
 =?utf-8?B?aGxTNnFiMTNjTmlGMkI3aHh3YWhRTk9Pa2UwT3Y4ZHI1RDc2cW9NUT09?=
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef335ed3-a1fc-42ba-f88d-08dedb07b06f
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR18MB4479.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 02:38:40.7343 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pFCGJUMQ423K4wjg/VLtA8Q8hdoOpy7h226Cu+Yq8CR/0UFOZlUVdflQZznxBSGAUJC7fgqrx5VZgNAkHzLfuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PPFFAF0BBFFE
Received-SPF: pass client-ip=52.101.53.134; envelope-from=kchiu@axiado.com;
 helo=BL0PR03CU003.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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


Peter Maydell 於 2026/7/3 下午 07:38 寫道:
> CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you recognize the sender and know the content is safe.
>
>
> On Mon, 22 Jun 2026 at 07:05, Kuan-Jui Chiu <kchiu@axiado.com> wrote:
>> This patchset introduces Axiado SoC AX3000 and a EVK SCM3003 for emulation
>> The model for Axiado SoC AX3000 supports
>>    4 Cortex-A53 CPUs
>>    Arm Generic Interrupt Controller v3
>>    4 Cadence UARTs
>>    1 SDHCI controller with PHY
>>    8 Cadence GPIOs
> This causes 'make check' to fail. Please test this kind of
> thing before submission.
>
> Hint: running QEMU without any other arguments crashes:
>   qemu-system-aarch64 -machine axiado-scm3003

Hi PMM

Does you mean this patch set is not buildable or it must be passed 
without any other arguments?

QEMU would crash without -drive argument which SoC created an eMMC 
device by default

If the machine must be able to run without any other argument, I will 
fix it in v7

> thanks
> -- PMM

