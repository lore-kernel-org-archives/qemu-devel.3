Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B74ADC02183
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Sep 2024 08:04:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1spNlE-00028U-8g; Sat, 14 Sep 2024 04:04:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.mao@hotmail.com>)
 id 1spNlC-00027X-H4; Sat, 14 Sep 2024 04:04:02 -0400
Received: from mail-sy4aus01olkn20831.outbound.protection.outlook.com
 ([2a01:111:f403:2819::831]
 helo=AUS01-SY4-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.mao@hotmail.com>)
 id 1spNl9-0003az-KN; Sat, 14 Sep 2024 04:04:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PpW7JlL8j25DnIhuiDLBNekC1q++xuZI7EAUMCLSmIiMt0mmumgCI3SFnr1gGgCa/CbBytVYf7TxUESY6HkmRlBuIdDIDsMod/u1l2mi28On0MD9CauKssZs88n8PtpL49Wm0n/c3sGFM5PgftnsQIjiq1KofG66V0fpqLzt7ebcRivJ5dhBG4VPzx2QnNONjuLhkWs24OM7GjsjB8xxX06pGasg/MvkkUSunmvxAaNm3rNEhkzWs327v46i59wGm9YpCSYnwjmmlyjzuTChV3ClAD0aGihEG+E1XnGfAC0rbCO/xppQIwib+bqqMujK2/6UUYcDX+p6IfxZU4GfTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RM26O8kcI2NswNvkKVK0yYbdzztlH8oRPM064kH2Lb0=;
 b=Jk100LruFhwD89PQ1iXUNJOqgnLMpOpfeagXvLRQANe/fs+7zwLkQ0elHSNgWpgqqTzNilETgw+NZ1WyI0Y4GyYCdbbXf9d27FHBRal/FxswjnxpY9wyVydh7CXCYJrZ3DgB9x+vCSSesjJg9fy96FHzS0piE6wOxiRk6/PXJkXoOMPx/HKcyTmFv/P9z7jzmQME3ezZGnCnNdeJYL5W07bfFH9fOpXTs/JEJYCSs3HyblWaHxvrY4cpKL6RNLY8asfVDlhENTjFT4ZcgEChYZKZF/tyWTj+ujfzf53r1ZeFvUKRGCGIos04yxh12zNGEf20XgKxUAGBj6Dx1FAaSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RM26O8kcI2NswNvkKVK0yYbdzztlH8oRPM064kH2Lb0=;
 b=OJbBLKYWd6OJqaDryHsocHShRQD0xAyknO5xxi8lSfYuZrUURrQhQrJJqGxyAV3RENxrlFYCP6/53iNnxuw2u0FD1x72muRvt5tgrf2r1C4FTdP+tTJAI4hcIq+D7L39Nf3aoPpx+bJr1fa/BaL+yyZuZKLHHswJgyfd2jgGaLmXqBsXIf3S11DywmEzf5Uzh9g0VCZ6D3CtNtcc8wb9+H1d555vpS1XLRpe2wlezSdAXe5W/Fd2dMrd3OmKoayDkgaKgByKLsk5rBkzepdXZ+bEKjKHFXTUsN91n/WK1dFrEMLk2j6Ux7JOyLCM2IIvmsHa6JdlJbrRgJSD41KkYw==
Received: from SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:282::22)
 by ME0P300MB0581.AUSP300.PROD.OUTLOOK.COM (2603:10c6:220:229::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.22; Sat, 14 Sep
 2024 08:03:48 +0000
Received: from SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
 ([fe80::aea3:2365:f9e8:5bd]) by SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
 ([fe80::aea3:2365:f9e8:5bd%2]) with mapi id 15.20.7962.021; Sat, 14 Sep 2024
 08:03:48 +0000
From: Junjie Mao <junjie.mao@hotmail.com>
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org,  Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?=
 Lureau <marcandre.lureau@redhat.com>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Thomas Huth <thuth@redhat.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Pierrick Bouvier
 <pierrick.bouvier@linaro.org>,  Richard Henderson
 <richard.henderson@linaro.org>,  Gustavo Romero
 <gustavo.romero@linaro.org>,  Alex =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>,  Peter
 Maydell <peter.maydell@linaro.org>,  Junjie Mao <junjie.mao@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>,  John Snow <jsnow@redhat.com>,  Cleber
 Rosa <crosa@redhat.com>,  Beraldo Leal <bleal@redhat.com>,  Wainer dos
 Santos Moschetta <wainersm@redhat.com>,  qemu-arm@nongnu.org
Subject: Re: [PATCH v10 9/9] rust: add PL011 device model
References: <20240910-rust-pl011-v10-0-85a89ee33c40@linaro.org>
 <20240910-rust-pl011-v10-9-85a89ee33c40@linaro.org>
Date: Sat, 14 Sep 2024 16:03:40 +0800
In-Reply-To: <20240910-rust-pl011-v10-9-85a89ee33c40@linaro.org> (Manos
 Pitsidianakis's message of "Tue, 10 Sep 2024 15:35:15 +0300")
Message-ID: <SY0P300MB102661760C7F4AC73EDBB70F95662@SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: SG2PR04CA0152.apcprd04.prod.outlook.com (2603:1096:4::14)
 To SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:282::22)
X-Microsoft-Original-Message-ID: <87tteiirvn.fsf@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SY0P300MB1026:EE_|ME0P300MB0581:EE_
X-MS-Office365-Filtering-Correlation-Id: c899dec5-0b19-44d9-19b5-08dcd493c352
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|19110799003|5072599009|8060799006|461199028|6090799003|15080799006|7092599003|3412199025|440099028;
X-Microsoft-Antispam-Message-Info: AfTQ4gSZA+CIBRnPbtfFjOiG0Q14dgqCkQY04tg3gqjQPS3tOo3V5UaZFkzCbfORRC3rbfmDVmtRC5xYFOBxDX37MdzvvFYDRftz33/cxhu9lVu9+pLFolbqsxVaCHHLT++ysKBnpMxPgc4SGRY0yXGUpGp3Gz+0Vx3ROL7mP/WU3J0ttYewRSj16MJuNUd6oMVd7IrvaQJ7pH3weYBqrrHeNArk+VuekZb3kDvs4UFRubF2m4mOckgYQKp3IWiG/DaF0aFMSgccwU47J7MeVhwjM8O3iQ+Ca+S0vnYV9ozGq2TUIvjsjLSQXWn17WOsqVTbKNCS+hnuskhFpt63Wnf5LtkPxY/+mtf0G+X8VIeYhKZVnhif84BD4OlnI3Txd8orjZSGDgZQgZO3MMOYT1QVLLdgxETJkdHVRL9818mr6Em8SsaFpfaZ44VDHzDHp0shdQkpET+OmczoU332ySO5lTQTUdPV/Wi+AbdjfR5SWaQ7NmBafR6ITRckYJCLzRAI1eVlaJJp9K3k3iS3ktUJtba9Lm1l17cWCXcS0OWpS78jA7ir8rWduhLQywrHXwBeruxgAJgBQ/d5u9osummzjysv6JIS2ggRj0L0asBT5LB/aFHaoxbLJjKfKSjjmEmlSluPEWgFGb5QWycIgEsxCoiDzh/D304ouBpfpciyUbrZLfB8TpRVVinStGvslxTb4vc4KNS84ZOjWgqA9N7Qdc2TUTXSMQNKpGLB4Vsjbp1XhTEwxOYzZDtCz2r870+XkqoASZrAZ80z3r/WMg==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M3M1aTNQbmZDVzZFUlJWaHFXUUJ0ZkZNTExXOVRPbkJuWWx1eCtYU2lTQlBu?=
 =?utf-8?B?UmYyM0owRnUvWUJaRXhoQVdsc0RyWmYvZTNQYlhLV3hiM3JSRG1CbzRoOFRI?=
 =?utf-8?B?MklrcHdLVk0wRjZyeUx2eWQvNExEcXFoY2RNNkxuZ3MxM0lueGZCSk1GNG1h?=
 =?utf-8?B?QUk0S2JHZUh2SDdpL0NwZVFNVDcxbm1iZGNzcUkwTUtBS2lPcStvbXdPdnB3?=
 =?utf-8?B?QnIxQUVnU1A4OXZtYlZEdWJtMmNZMEJMcDJ2a2lqQzB5SzA0Ym94eFRpbC9J?=
 =?utf-8?B?U3FZTmNwYjZoa0VUdWRyMzRjT2wyRithL2pFZzFtbHRITDRaUXMyUWlPSXNG?=
 =?utf-8?B?NmxoNjhvTVVqUzhVa292WWt1YlQ2aDdESHR4SHZoTHIvZjY3bnYrWnlYZXNr?=
 =?utf-8?B?YW5JTFk5dStxdGwvL0dwRWJURGwyelIrU0hlOHQ1NCtBcklZNGgyOWFZaXpU?=
 =?utf-8?B?Q3RlSzg5eTNQcSt1TkJXbEtjU1VkUlZSZEMrUk1HNnk3aU9sNmh6T2h4YlNa?=
 =?utf-8?B?bnFDT0dPaFQ4OHRSL08wWHRZY2t4NUlTRzgwNVpZVStNN3J1dlh3NXhDTW1r?=
 =?utf-8?B?czRwRWM0bnVKdUpzc0Y0akZLc2N4L0xVcHhJb0d2R04vZ005bithcWk0SEZx?=
 =?utf-8?B?Lzl0T2s3cmNtSk9HZDd1TWJxZkFLVkI2SStycVFxeC9ScTN2SWFRdkNqRkpB?=
 =?utf-8?B?Vm1HcTMxOGxwOHVBc3FKSW9HOVZWQVV0QXJPYm1hNko4K2Z6cG8xUEtyMUNa?=
 =?utf-8?B?eGtkSVhVLzB3SXkyTjFyVUJQVkNFcGd3T2xBdmhCQ1lTbVo1aldobkhLaEtp?=
 =?utf-8?B?cTJFaXdqOTQzWWpJYTlIMzE0U1ZwYTdpWHRhODVlNUR5OVlnK0luS3JwTkZl?=
 =?utf-8?B?bGhBbFlLSHZrY2RRcm1ZRkloY2c3MGZubTVEbUY3NEtCL0YzR3BkOHUwMGZF?=
 =?utf-8?B?bzVqVWRzd0NrRGZPZ3B0cGJtakUwLzVWWmNFZWNqRHJQcEFEOGNqejN0ODZk?=
 =?utf-8?B?clAwRVI5cVBXZ2d3RUMvRER2Mnk4WVdsY1lRd1hOSGQvRmdSSVQ4ZXMrYTcv?=
 =?utf-8?B?aUhjRkpGU09ueHBnQTlSSFZQcHdnclc2MktHZ1huQjhMZ1dsYVA5amlFYjRj?=
 =?utf-8?B?dEdnSGJ5MGJhS0NlclprbGcvWlo2Tjg1VGlQbndDenlsc1pFV0dqeFJGMklI?=
 =?utf-8?B?bzJKdCtCazljWHhFZXd0M0tzYzBXUEJ2OWc3VWdzdDFoN1V2UnhVL20xeW9X?=
 =?utf-8?B?a0NQTE9UZDk3OHQrR1V4RVI2RGdOcnV6Zm9TajZCMlc0andtL0ZRRVo0VnRR?=
 =?utf-8?B?NmJXMG44dVlxV3JiT0RwbUd2R1RYRFdjNjJ5NmpsOStzTE4yZkdOWlREZzJN?=
 =?utf-8?B?aldXTVJMSFk5dll2K0hjTWlkM2lUUlEvQi94ZUpTTlkxajZSckEzdE4yL2xN?=
 =?utf-8?B?c3o4RGNWUnBSY0NkVzNXdjM1QWpUVFBnNy9iZ0RZRmkzZ1JqWDBBa0xkU1FD?=
 =?utf-8?B?UVNFKzMyanRtVUNBQ0xqcXVBamdDZHRWUy9DWUhVWHZLMUo0NVQ2VVRzNEx0?=
 =?utf-8?B?Sys0ejNXWjVaWFNFL0xVUEgyRncvZnFUZFU1SjgvbFFtUHFheEJhMVlnS21U?=
 =?utf-8?Q?ARGG6SZn4IirHvKzae4eKott+Sv3vUINyjVL+j9IxoCo=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-448bf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: c899dec5-0b19-44d9-19b5-08dcd493c352
X-MS-Exchange-CrossTenant-AuthSource: SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2024 08:03:48.4541 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ME0P300MB0581
Received-SPF: pass client-ip=2a01:111:f403:2819::831;
 envelope-from=junjie.mao@hotmail.com;
 helo=AUS01-SY4-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Manos Pitsidianakis <manos.pitsidianakis@linaro.org> writes:

> This commit adds a re-implementation of hw/char/pl011.c in Rust.
>
> How to build:
>
> 1. Configure a QEMU build with:
>    --enable-system --target-list=3Daarch64-softmmu --enable-rust
> 2. Launching a VM with qemu-system-aarch64 should use the Rust version
>    of the pl011 device
>
> Co-authored-by: Junjie Mao <junjie.mao@intel.com>
> Co-authored-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Junjie Mao <junjie.mao@intel.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> ---
[snip]
> diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/de=
vice.rs
> new file mode 100644
> index 0000000000000000000000000000000000000000..6bd121b83ae831e838b05d83b=
67c698474b00b4a
> --- /dev/null
> +++ b/rust/hw/char/pl011/src/device.rs
> @@ -0,0 +1,600 @@
> +// Copyright 2024, Linaro Limited
> +// Author(s): Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +
> +use core::{
> +    ffi::{c_int, c_uchar, c_uint, c_void, CStr},
> +    ptr::{addr_of, addr_of_mut, NonNull},
> +};
> +
> +use qemu_api::{
> +    bindings::{self, *},
> +    definitions::ObjectImpl,
> +};
> +
> +use crate::{
> +    memory_ops::PL011_OPS,
> +    registers::{self, Interrupt},
> +    RegisterOffset,
> +};
> +
> +static PL011_ID_ARM: [c_uchar; 8] =3D [0x11, 0x10, 0x14, 0x00, 0x0d, 0xf=
0, 0x05, 0xb1];
> +
> +const DATA_BREAK: u32 =3D 1 << 10;
> +
> +/// QEMU sourced constant.
> +pub const PL011_FIFO_DEPTH: usize =3D 16_usize;
> +
> +#[repr(C)]
> +#[derive(Debug, qemu_api_macros::Object)]
> +/// PL011 Device Model in QEMU
> +pub struct PL011State {
> +    pub parent_obj: SysBusDevice,
> +    pub iomem: MemoryRegion,
> +    #[doc(alias =3D "fr")]
> +    pub flags: registers::Flags,
> +    #[doc(alias =3D "lcr")]
> +    pub line_control: registers::LineControl,
> +    #[doc(alias =3D "rsr")]
> +    pub receive_status_error_clear: registers::ReceiveStatusErrorClear,
> +    #[doc(alias =3D "cr")]
> +    pub control: registers::Control,
> +    pub dmacr: u32,
> +    pub int_enabled: u32,
> +    pub int_level: u32,
> +    pub read_fifo: [u32; PL011_FIFO_DEPTH],
> +    pub ilpr: u32,
> +    pub ibrd: u32,
> +    pub fbrd: u32,
> +    pub ifl: u32,

Some of the fields can be private to the implementation of PL011State.

> +    pub read_pos: usize,
> +    pub read_count: usize,
> +    pub read_trigger: usize,
> +    #[doc(alias =3D "chr")]
> +    pub char_backend: CharBackend,
> +    /// QEMU interrupts
> +    ///
> +    /// ```text
> +    ///  * sysbus MMIO region 0: device registers
> +    ///  * sysbus IRQ 0: `UARTINTR` (combined interrupt line)
> +    ///  * sysbus IRQ 1: `UARTRXINTR` (receive FIFO interrupt line)
> +    ///  * sysbus IRQ 2: `UARTTXINTR` (transmit FIFO interrupt line)
> +    ///  * sysbus IRQ 3: `UARTRTINTR` (receive timeout interrupt line)
> +    ///  * sysbus IRQ 4: `UARTMSINTR` (momem status interrupt line)
> +    ///  * sysbus IRQ 5: `UARTEINTR` (error interrupt line)
> +    /// ```
> +    #[doc(alias =3D "irq")]
> +    pub interrupts: [qemu_irq; 6usize],
> +    #[doc(alias =3D "clk")]
> +    pub clock: NonNull<Clock>,
> +    #[doc(alias =3D "migrate_clk")]
> +    pub migrate_clock: bool,
> +}
> +
> +impl ObjectImpl for PL011State {
> +    type Class =3D PL011Class;
> +    const TYPE_INFO: qemu_api::bindings::TypeInfo =3D qemu_api::type_inf=
o! { Self };
> +    const TYPE_NAME: &'static CStr =3D c"pl011";

Can use crate::definitions::TYPE_PL011 to avoid duplication.

> +    const PARENT_TYPE_NAME: Option<&'static CStr> =3D Some(TYPE_SYS_BUS_=
DEVICE);
> +    const ABSTRACT: bool =3D false;
> +    const INSTANCE_INIT: Option<unsafe extern "C" fn(obj: *mut Object)> =
=3D Some(pl011_init);
> +    const INSTANCE_POST_INIT: Option<unsafe extern "C" fn(obj: *mut Obje=
ct)> =3D None;
> +    const INSTANCE_FINALIZE: Option<unsafe extern "C" fn(obj: *mut Objec=
t)> =3D None;
> +}
> +
[snip]
> +
> +/// # Safety
> +///
> +/// We expect the FFI user of this function to pass a valid pointer, tha=
t has
> +/// the same size as [`PL011State`]. We also expect the device is
> +/// readable/writeable from one thread at any time.
> +#[no_mangle]
> +pub unsafe extern "C" fn pl011_can_receive(opaque: *mut c_void) -> c_int=
 {
> +    unsafe {
> +        assert!(!opaque.is_null());
> +        let state =3D NonNull::new_unchecked(opaque.cast::<PL011State>()=
);

Those two lines can be combined as:

  let state =3D NonNull::new(opaque.cast::<PL011State>()).unwrap();

Alternatively, use debug_assert! if the assertion is only meant to be
active in debug builds.

> +        state.as_ref().can_receive().into()
> +    }
> +}
> +
> +/// # Safety
> +///
> +/// We expect the FFI user of this function to pass a valid pointer, tha=
t has
> +/// the same size as [`PL011State`]. We also expect the device is
> +/// readable/writeable from one thread at any time.
> +///
> +/// The buffer and size arguments must also be valid.
> +#[no_mangle]
> +pub unsafe extern "C" fn pl011_receive(
> +    opaque: *mut core::ffi::c_void,
> +    buf: *const u8,
> +    size: core::ffi::c_int,
> +) {
> +    unsafe {
> +        assert!(!opaque.is_null());
> +        let mut state =3D NonNull::new_unchecked(opaque.cast::<PL011Stat=
e>());
> +        if state.as_ref().loopback_enabled() {
> +            return;
> +        }
> +        if size > 0 {
> +            assert!(!buf.is_null());
> +            state.as_mut().put_fifo(c_uint::from(buf.read_volatile()))
> +        }
> +    }
> +}
> +
> +/// # Safety
> +///
> +/// We expect the FFI user of this function to pass a valid pointer, tha=
t has
> +/// the same size as [`PL011State`]. We also expect the device is
> +/// readable/writeable from one thread at any time.
> +#[no_mangle]
> +pub unsafe extern "C" fn pl011_event(opaque: *mut core::ffi::c_void, eve=
nt: QEMUChrEvent) {
> +    unsafe {
> +        assert!(!opaque.is_null());
> +        let mut state =3D NonNull::new_unchecked(opaque.cast::<PL011Stat=
e>());
> +        state.as_mut().event(event)
> +    }
> +}
> +
> +/// # Safety
> +///
> +/// We expect the FFI user of this function to pass a valid pointer for =
`chr`.
> +#[no_mangle]
> +pub unsafe extern "C" fn pl011_create(
> +    addr: u64,
> +    irq: qemu_irq,
> +    chr: *mut Chardev,
> +) -> *mut DeviceState {
> +    unsafe {
> +        let dev: *mut DeviceState =3D qdev_new(PL011State::TYPE_INFO.nam=
e);
> +        assert!(!dev.is_null());

qdev_new() aborts on error. So the assert! above is unnecessary.

> +        let sysbus: *mut SysBusDevice =3D dev as *mut SysBusDevice;

In C such casts are typically done using the object checker generated by
the DECLARE_INSTANCE_CHECKER macro. With qom_cast_debug the checker is
able to capture casts to wrong types.

As a future work, similar mechanism should be available in Rust for such
casts.

> +
> +        qdev_prop_set_chr(dev, bindings::TYPE_CHARDEV.as_ptr(), chr);
> +        sysbus_realize_and_unref(sysbus, addr_of!(error_fatal) as *mut *=
mut Error);
> +        sysbus_mmio_map(sysbus, 0, addr);
> +        sysbus_connect_irq(sysbus, 0, irq);
> +        dev
> +    }
> +}
> +
> +/// # Safety
> +///
> +/// We expect the FFI user of this function to pass a valid pointer, tha=
t has
> +/// the same size as [`PL011State`]. We also expect the device is
> +/// readable/writeable from one thread at any time.
> +#[no_mangle]

I don't think #[no_mangle] is needed for functions being exposed to C
via function pointers. The annotated function has external linkage,
while the common practice is to make such callbacks static.

> +pub unsafe extern "C" fn pl011_init(obj: *mut Object) {
> +    unsafe {
> +        assert!(!obj.is_null());
> +        let mut state =3D NonNull::new_unchecked(obj.cast::<PL011State>(=
));
> +        state.as_mut().init();
> +    }
> +}
[snip]
> diff --git a/rust/hw/char/pl011/src/lib.rs b/rust/hw/char/pl011/src/lib.r=
s
> new file mode 100644
> index 0000000000000000000000000000000000000000..541109d4d8f87a70748820cec=
ee24656802a6350
> --- /dev/null
> +++ b/rust/hw/char/pl011/src/lib.rs
> @@ -0,0 +1,586 @@
> +// Copyright 2024, Linaro Limited
> +// Author(s): Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +//
> +// PL011 QEMU Device Model
> +//
> +// This library implements a device model for the PrimeCell=C2=AE UART (=
PL011)
> +// device in QEMU.
> +//
> +#![doc =3D include_str!("../README.md")]
> +//! # Library crate
> +//!
> +//! See [`PL011State`](crate::device::PL011State) for the device model t=
ype and
> +//! the [`registers`] module for register types.
> +
> +#![deny(
> +    unsafe_op_in_unsafe_fn,

Shall we make this builtin lint denied for all crates? That can be done
by adding '-D unsafe_op_in_unsafe_fn' to rustc argument.

> +    rustdoc::broken_intra_doc_links,
> +    rustdoc::redundant_explicit_links,
> +    clippy::correctness,
> +    clippy::suspicious,
> +    clippy::complexity,
> +    clippy::perf,
> +    clippy::cargo,
> +    clippy::nursery,
> +    clippy::style,
> +    // restriction group
> +    clippy::dbg_macro,
> +    clippy::as_underscore,
> +    clippy::assertions_on_result_states,
> +    // pedantic group
> +    clippy::doc_markdown,
> +    clippy::borrow_as_ptr,
> +    clippy::cast_lossless,
> +    clippy::option_if_let_else,
> +    clippy::missing_const_for_fn,
> +    clippy::cognitive_complexity,
> +    clippy::missing_safety_doc,
> +    )]
> +

--
Best Regards
Junjie Mao

