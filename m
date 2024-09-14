Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD6B8C02191
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Sep 2024 11:37:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1spR4u-0002AC-Ah; Sat, 14 Sep 2024 07:36:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.mao@hotmail.com>)
 id 1spR4s-00028b-Qd; Sat, 14 Sep 2024 07:36:34 -0400
Received: from mail-sy4aus01olkn20813.outbound.protection.outlook.com
 ([2a01:111:f403:2819::813]
 helo=AUS01-SY4-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.mao@hotmail.com>)
 id 1spR4r-0005gF-4E; Sat, 14 Sep 2024 07:36:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=itUxlNpCU72UJOEABAkImr4Gvq9D3D5ZG3RTErHjiU/IRqiuG3VwmvIWCdU17DEoWI+bV2Djr83gmGi40krW0CBsaX9z65VcwgTKqNCJ7+aPpv1vdzp512Kv+2CLJHBpWsRIKAUbeeM4+ci6+CxSCXGKWR+TEWeLh/a4lxOyWDki2D3DSRtnlkQ7I1FCxsqJ4Y9hrBdryRdmTIHIqS2D1gIDU7VqW8JaMx8mRXMuj9rtA+rhvJfatvISpQTUeYxnn45ZmYOp2lq9aYEjN6mqJbgGOxJ0gKlyvRWpVWwBO6m6WlDUOs1EDxwhtOQOT0NEGEku0u9vIaz/VQHX9r9rZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8HWkc9NKCkmUjprmgEeSAxd+QEjohSYZtT2oI1bs3NQ=;
 b=Aw6z9NbuqJyns4YzK4Lg3jaZokpbKs7w/b3vikzYU9r8AbASwy+G9k3Lhnj6GEHpeHYavClLMuPsJDjPniF7d5NJTZG3Oc3K7Kcv9eWlWBgPO2NFXIbhRqaaWQs0b99S00fsvQcTo8MBQx6UCSmjA3RSdqclLo820Nct2PVSj5am8Qnz5oGQzSp52ZbtNy5Rh6bfF2XA8zivONKnfOYZ1pO/dm4ePr2pAu9Do7dstYvqHtVLFJRf2lHNb+InUbbP/e9a97ZmRso6W0gMaQK0eCCxD3GE8DtT1UL6q948MCRCrSHQ23E3cs5y0aEPMQVtAX1sj2OCLozBF8u/JwKZ6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8HWkc9NKCkmUjprmgEeSAxd+QEjohSYZtT2oI1bs3NQ=;
 b=KCsaYdsY+3ZPOjdSuCRrHihhaVHdNSjpIDYs3DKSVyv5FUPneod0ptPgAm+WFenI28uZCAq1wOK9umTJvbd17xgCP0Mjf0oZFu8Aasb+tXb1ZIUkHOImkrBkkQghqTjlyrHfCymYMMien0aPrj9J3jpOm2oOAG5BzK6mzoy5rEw5Vv3XFTeq9wwWF3XYWBuvoFWmnvQCZVmHyUsGJtqk5y7jdib/WzI+93JwqFZ7O1UfENkEnQvXIBPq0IOJcieqg6xLBdxhSWP452sjHnD6J8LxzT8O7RHIi8jNvmSBSbnj3xZrcZ/vLEEbP8K9DXMOzBayQunbRQ8xO+9+XLq8jw==
Received: from SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:282::22)
 by SY8P300MB0202.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:267::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.21; Sat, 14 Sep
 2024 11:36:24 +0000
Received: from SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
 ([fe80::aea3:2365:f9e8:5bd]) by SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
 ([fe80::aea3:2365:f9e8:5bd%2]) with mapi id 15.20.7962.021; Sat, 14 Sep 2024
 11:36:24 +0000
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
 <SY0P300MB102661760C7F4AC73EDBB70F95662@SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM>
Date: Sat, 14 Sep 2024 19:36:17 +0800
In-Reply-To: <SY0P300MB102661760C7F4AC73EDBB70F95662@SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM>
 (Junjie Mao's message of "Sat, 14 Sep 2024 16:03:40 +0800")
Message-ID: <SY0P300MB1026206D60F2AEC8788BDA1D95662@SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0029.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::8) To SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:282::22)
X-Microsoft-Original-Message-ID: <87ldzuii1a.fsf@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SY0P300MB1026:EE_|SY8P300MB0202:EE_
X-MS-Office365-Filtering-Correlation-Id: f317029b-304b-4036-bb24-08dcd4b1766a
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|19110799003|15080799006|7092599003|461199028|5072599009|8060799006|440099028|3412199025;
X-Microsoft-Antispam-Message-Info: AW7JFsRS3AmwiKg/Uzu54loS+XnbsxE9KcEUbh+JAwbeo2Szg0T5V0iQeAYf4kVMrqGCX2JNO8LeVEi1QUqCeIjiCWCbpjUWxNvjcHaPdaXRtUVYd6FF9qTnrswOAfRBCnDFpHTtObxGbJ3NgPmunb43w+6ve07knfV7pRwoNfhGRxSq+6lgFOUl4ZVSUT/X9Vkm2ZANLrYOVJNJvTLVHWQJRT8YTALDebgxCzl6Ckgedo7UMv85OQjkbYqS4D5j1DtBDyvs/06iP918zW5GPnxeoNTMXzMvEo1MZzt/cTwWXeRYzHAzQwDiZmOWpHIV42rGjwwFs3/Dp07lZSWjqnIHJjWkJKJC3zBSA23HrGxYqceoYQlS6enhPmeUjaNH+q1AB8pF7oQ8nucsQoTJJpvrEDZTxfpfr5oIlyNmectuToarAUS3Cv0vAN/6R6pRWo7XaAMC5Lg1sEnaETof4kTqfx8leJ8J4s7p++sdUS/raUwyJfTUollbLSGE+jIW9Pr0hXUs4w+qjr+0zgRNa0qqkSA6afDJfXWVtMPdAiORKG4wCM7zjn2sFLV7fbdsVDidvm1us2VQZj/ir4OrC9Ma3t/DxmaG4bonROGtze/TngHhoLVfUdSj5v/+2oPRX/DjtopFKm+aU2xAueKXj6LgsrKp6VCHlMnbRnZuIu18NMU185jPYXDVI6qq5GT8AnHfZhiVXTsKSghA5IkWnX8wlL4jj5IsM1w1qkMCGTk=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aSDqIMQCwgRVbg1Nipo/5Iu19wMFSqxEWHyLLQCOl+NDCsWwt9AHckpfQx/Y?=
 =?us-ascii?Q?bCFVtsuUg0iJsP46cypD82fGrrfmEUqgo6E6rq/RxtLJy79i/sARd4OlrBP0?=
 =?us-ascii?Q?RAvl/+03UX1miIRw7BptuA17gX3kQ4cMRvtgj7PP2qykvvmW+qJfA8dQDpQU?=
 =?us-ascii?Q?Rfn7NugD/d3uQM95W2JkmCp2glcpyqWbAr9DLA2sA8wNvrCGPenhc9LTekGK?=
 =?us-ascii?Q?X824lDexvsJNPfj50jas5LhKrjd4BNoon9u61hY/egMmMtMsqIsMXnqAb6bN?=
 =?us-ascii?Q?k1w7BV7P4Ts50i7bpEgGcZCFLGTWC6vRJqLhpwlCBX7oexxqac61dGps2xsb?=
 =?us-ascii?Q?2se9BOfiX0nuWk0KTByzRj2IrxQ2EA9cdyUxZlYU+SANDvM5w1H66vSZfh+p?=
 =?us-ascii?Q?uxjcRFBBDi3AwBX8EZ56fPzKHH/mtc88+f8RPq08C6/Z5aU4eYt8HJ3lEccv?=
 =?us-ascii?Q?2PJchTtQ68GB4l6ASjjm3ZFrmQf1CIzMgxUWc0yN/8K/Iz1rLKy1x5KjU52b?=
 =?us-ascii?Q?aHdvzNf695SOCoedrR8F35+LEG0H3IPrQ4TrT5oTfIK3aQIC76XY2z95penh?=
 =?us-ascii?Q?d8a8AgfczwcL33f8SfVkFOKIpZmfpI+oTCXvcPnQInlscPUZYdoZlnhl/y/+?=
 =?us-ascii?Q?RqpRWbLIDWwEzc6wgYUNBAOKXuvjrFT23fBkBobR6+4XIBYaJziZsVkyVB4K?=
 =?us-ascii?Q?fwWcokhawZLz+vw1MMM5WKgxqRB7zcsQwvO7HEx489D3w1aAJpg/7GivHY27?=
 =?us-ascii?Q?0SkWQ19Bksg+mitRhse53e0t01HwR9Do6EOfOvp9AcXqKcMAV6nJ3FW29V7D?=
 =?us-ascii?Q?AtDKs09ezkCR/uZkCmqNBDF8seTac5Zl+HtX1YieoWRqgaoMgnXKo8lRnuHR?=
 =?us-ascii?Q?Q6m1/v0frvExI+QVyFu+/RNBtCl0rUyVWkeFA8d5pP9BIOdsBP9KAfQKA6OQ?=
 =?us-ascii?Q?AB6UynVQR/pZvV2thiwLgHOD36KaMbFX1QhqRK6ELiKd3Om9uIRJlh1mv2d7?=
 =?us-ascii?Q?mfh1GEPsHNX6XJhZZvT4omPMRIA3R+vXuNLIYG0pq7BubyjnMMfCjRIp+Bg4?=
 =?us-ascii?Q?qYcJY165ryDtv/mJlJaSQnlKKqNbhHlt6CVs7pRRhfuszglNxF/ajytRkOd1?=
 =?us-ascii?Q?DLzqIiztO24nOlt22Tm0VY+dois16S96jYQ6ufhVPnarTBWhfPY13Qs0Q337?=
 =?us-ascii?Q?ro85L945o8ep1K7GdXDpDOgggLY84NOmaQ8sDNYG9ZSWxrSMYJChwmOhO54?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-448bf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: f317029b-304b-4036-bb24-08dcd4b1766a
X-MS-Exchange-CrossTenant-AuthSource: SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2024 11:36:24.2700 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY8P300MB0202
Received-SPF: pass client-ip=2a01:111:f403:2819::813;
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

Junjie Mao <junjie.mao@hotmail.com> writes:

> Manos Pitsidianakis <manos.pitsidianakis@linaro.org> writes:
>
>> This commit adds a re-implementation of hw/char/pl011.c in Rust.
>>
>> How to build:
>>
>> 1. Configure a QEMU build with:
>>    --enable-system --target-list=aarch64-softmmu --enable-rust
>> 2. Launching a VM with qemu-system-aarch64 should use the Rust version
>>    of the pl011 device
>>
>> Co-authored-by: Junjie Mao <junjie.mao@intel.com>
>> Co-authored-by: Paolo Bonzini <pbonzini@redhat.com>
>> Signed-off-by: Junjie Mao <junjie.mao@intel.com>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
>> ---
> [snip]
>> diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
>> new file mode 100644
>> index 0000000000000000000000000000000000000000..6bd121b83ae831e838b05d83b67c698474b00b4a
>> --- /dev/null
>> +++ b/rust/hw/char/pl011/src/device.rs
>> @@ -0,0 +1,600 @@
>> +// Copyright 2024, Linaro Limited
>> +// Author(s): Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +
>> +use core::{
>> +    ffi::{c_int, c_uchar, c_uint, c_void, CStr},
>> +    ptr::{addr_of, addr_of_mut, NonNull},
>> +};
>> +
>> +use qemu_api::{
>> +    bindings::{self, *},
>> +    definitions::ObjectImpl,
>> +};
>> +
>> +use crate::{
>> +    memory_ops::PL011_OPS,
>> +    registers::{self, Interrupt},
>> +    RegisterOffset,
>> +};
>> +
>> +static PL011_ID_ARM: [c_uchar; 8] = [0x11, 0x10, 0x14, 0x00, 0x0d, 0xf0, 0x05, 0xb1];
>> +
>> +const DATA_BREAK: u32 = 1 << 10;
>> +
>> +/// QEMU sourced constant.
>> +pub const PL011_FIFO_DEPTH: usize = 16_usize;
>> +
>> +#[repr(C)]
>> +#[derive(Debug, qemu_api_macros::Object)]
>> +/// PL011 Device Model in QEMU
>> +pub struct PL011State {
>> +    pub parent_obj: SysBusDevice,
>> +    pub iomem: MemoryRegion,
>> +    #[doc(alias = "fr")]
>> +    pub flags: registers::Flags,
>> +    #[doc(alias = "lcr")]
>> +    pub line_control: registers::LineControl,
>> +    #[doc(alias = "rsr")]
>> +    pub receive_status_error_clear: registers::ReceiveStatusErrorClear,
>> +    #[doc(alias = "cr")]
>> +    pub control: registers::Control,
>> +    pub dmacr: u32,
>> +    pub int_enabled: u32,
>> +    pub int_level: u32,
>> +    pub read_fifo: [u32; PL011_FIFO_DEPTH],
>> +    pub ilpr: u32,
>> +    pub ibrd: u32,
>> +    pub fbrd: u32,
>> +    pub ifl: u32,
>
> Some of the fields can be private to the implementation of PL011State.
>

Forgot to mention, all those are minor comments that came to my mind
when I studied your code. Feel free to defer them to future
series. Thanks.

-- 
Best Regards
Junjie Mao

