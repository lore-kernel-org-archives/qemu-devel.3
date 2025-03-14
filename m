Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38820C28B2F
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Mar 2025 08:16:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tt0Ca-0002h3-Bi; Fri, 14 Mar 2025 04:15:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tt0CV-0002fb-V3
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 04:15:28 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tt0CT-0003d6-Qc
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 04:15:27 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-224100e9a5cso38018625ad.2
 for <qemu-devel@nongnu.org>; Fri, 14 Mar 2025 01:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1741940124; x=1742544924;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rjRbWqEK1cRNvpLX1XN8SPfUVIwyJOinGMyrefKKi4M=;
 b=tFj4e9ho/pAIFqHS7lMNwqsS2fmW4BF+78jaFTXR+j0q2XadOp8xIbZ4c9xdWmSIAe
 P18Js/sasY7Ycwp3egiKCm8fUi3pKH/L/iIJUqyWxhLsXchLdh2Xt5F7usuPbPK2H83A
 qLVyH2yhhl2b7M5TPJrbcG2vViScwY3weczdKLXhrTRdzjNu6/ieBUIEfxiApXtrdo8w
 moeAMMZbqqLwU5O4qBKhPGIiVD4cqjtmZQNqr7WhtC+55Q57eFpLboIqJYpONvCeDpjs
 oISpIk5sqa+vWI4XgN0ZNXblYXMNTzon9rBW/e4wvPjQ/98iZrU86spQwpmTaJ0d5dlZ
 lIGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741940124; x=1742544924;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rjRbWqEK1cRNvpLX1XN8SPfUVIwyJOinGMyrefKKi4M=;
 b=T7TP+ihTfDjsxU1kCRZ+tOsY30022nzELkdvja6ceQunG8e4bpxI/tvgX40sN3Dn79
 bZXiFLHUl08gpna03AM09uBbyvgMOKJvyGuEIl4D6QUAK2tatP34NBF3fwrmIcVsWkMJ
 zGziXFP4F15qUdRiweRG2KmJVVIAAzqfYq4TLHn7WlTNAf+YXOGEP5+zmxdb011pDbkE
 +dz+2YY8ZXqjQVkK/2trvz08AZCPwtF9+vz7SrHqS1vLLbYgUcks+ZQU1Zm42+qL57jd
 RnZ6LBsCS3ATPYpWMfJhkY6PFjVJHSdX9SWWnnqTCRpNaQqoxjCQ6DH+M23Uxp5p+z8x
 94pA==
X-Gm-Message-State: AOJu0Yyvl2jxRqtXHhK1Q3TvhQmfguN7/gyNA7h606pXspbYaWj6ZMKW
 wtaw/nZzl9KCDXg5Q9LpCUx8a9NYSZg4V1w5s0T23Jh0uxBD7p+0Vls/Az3EXj4=
X-Gm-Gg: ASbGncvDswmMuoXIpB+MjZf3AF6Vhzk3vS7mC0F2E7ko8Mq6wmjRmudtf2aZyyNAJ4g
 w28+xgPuuvsBJvXWRyv53m/gwGw4zQN5sEL2ADdEqL4wi9sNk6zYpygAhHwrfDBvA6mQ3bLbka8
 aC9vym5pKVxZ7LXtr1uoxCHTXwBd/6t2ntV7EFY3bBttcTJt+O2cYgWPQJSKZWg2vQalu/bq17z
 8efP0WFFM/bKC/WEer5MOxofhb/NKYxBwghBZT9YSwhwfUfW+6RXzwb17TIY8uDLY0xtDh+nRzg
 7iIVXMl3af+B4h53sK8F5Ra5OruH4o2lpEFAy6QhCoavu3pfmNd6+bdu68jk752IyYA0
X-Google-Smtp-Source: AGHT+IHLJBZdYdFgM6rW6PBQFWZGuO3ZNhs55tYJv1ageWIwPVVD5JU7HWKct5h3DD81oRWm9ehsCA==
X-Received: by 2002:a05:6a00:2386:b0:72f:590f:2859 with SMTP id
 d2e1a72fcca58-7372239bc8amr2028605b3a.13.1741940123934; 
 Fri, 14 Mar 2025 01:15:23 -0700 (PDT)
Received: from [157.82.205.237] ([157.82.205.237])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7371167df81sm2486565b3a.110.2025.03.14.01.15.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Mar 2025 01:15:23 -0700 (PDT)
Message-ID: <6959f6ef-c142-49e0-b742-a99da1a26b61@daynix.com>
Date: Fri, 14 Mar 2025 17:15:21 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/arm: Define raw write for PMU CLR registers
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, devel@daynix.com
References: <20250313-clr-v1-1-2cc49df40fe9@daynix.com>
 <CAFEAcA9pu_Y8Ki6TFznViO1UCqqSgHgn2ZKQjbcoKVob3qF5dg@mail.gmail.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CAFEAcA9pu_Y8Ki6TFznViO1UCqqSgHgn2ZKQjbcoKVob3qF5dg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x634.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 2025/03/14 3:34, Peter Maydell wrote:
> On Thu, 13 Mar 2025 at 07:16, Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>
>> PMCNTENCLR_EL0 and PMINTENCLR_EL1 clears written bits so we need an
>> alternative raw write functions, which will be used to copy KVM kernel
>> coprocessor state into userspace.
>>
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>> ---
>>   target/arm/helper.c | 6 ++++--
>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/target/arm/helper.c b/target/arm/helper.c
>> index f0ead22937bf..30883cd3a989 100644
>> --- a/target/arm/helper.c
>> +++ b/target/arm/helper.c
>> @@ -1907,7 +1907,8 @@ static const ARMCPRegInfo v7_cp_reginfo[] = {
>>         .fgt = FGT_PMCNTEN,
>>         .type = ARM_CP_ALIAS | ARM_CP_IO,
>>         .fieldoffset = offsetof(CPUARMState, cp15.c9_pmcnten),
>> -      .writefn = pmcntenclr_write },
>> +      .writefn = pmcntenclr_write,
>> +      .raw_writefn = raw_write },
>>       { .name = "PMOVSR", .cp = 15, .crn = 9, .crm = 12, .opc1 = 0, .opc2 = 3,
>>         .access = PL0_RW, .type = ARM_CP_IO,
>>         .fieldoffset = offsetoflow32(CPUARMState, cp15.c9_pmovsr),
>> @@ -2033,7 +2034,8 @@ static const ARMCPRegInfo v7_cp_reginfo[] = {
>>         .fgt = FGT_PMINTEN,
>>         .type = ARM_CP_ALIAS | ARM_CP_IO | ARM_CP_NO_RAW,
>>         .fieldoffset = offsetof(CPUARMState, cp15.c9_pminten),
>> -      .writefn = pmintenclr_write },
>> +      .writefn = pmintenclr_write,
>> +      .raw_writefn = raw_write },
>>       { .name = "CCSIDR", .state = ARM_CP_STATE_BOTH,
>>         .opc0 = 3, .crn = 0, .crm = 0, .opc1 = 1, .opc2 = 0,
>>         .access = PL1_R,
> 
> Hmm, looking more closely at this, I think this second one should
> not need a raw_writefn, because it's marked as ARM_CP_NO_RAW
> (meaning nothing should try to do a raw write to it).

Good catch; I didn't notice ARM_CP_NO_RAW.

> 
> And the first one is marked ARM_CP_ALIAS, so I'm not
> sure why we would be using it in KVM register sync:
> add_cpreg_to_list() skips ARM_CP_ALIAS (and ARM_CP_NO_RAW)
> registers when we construct the cpreg_tuples[] array that
> defines which sysregs we sync to and from KVM.

The register list is initialized with kvm_arm_init_cpreg_list() for KVM, 
which ignores those flags.

target/arm/cpregs.h explicitly says: "registers marked ARM_CP_ALIAS will 
not be migrated but may have their state set by syncing of register 
state from KVM."

ARM_CP_NO_RAW is still respected for KVM by write_cpustate_to_list() and 
write_list_to_cpustate().

> 
> (We should arguably be consistent about our usage of the
> NO_RAW flag between the pmintenclr and pmcntenclr registers.)

I sent v2 to drop the flag. target/arm/cpregs.h suggests ARM_CP_NO_RAW 
is not a flag for these registers:
 > Flag: Register has no underlying state and does not support raw access
 > for state saving/loading; it will not be used for either migration or
 > KVM state synchronization. Typically this is for "registers" which are
 > actually used as instructions for cache maintenance and so on.

These registers have underlying states and can support raw access.

Regards,
Akihiko Odaki

> 
> thanks
> -- PMM


