Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3D2AC36002
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Mar 2025 21:32:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twpO5-0002Ga-49; Mon, 24 Mar 2025 17:31:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1twpO1-0002EJ-BR
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 17:31:09 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1twpNz-00066s-Bc
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 17:31:09 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-301918a4e3bso8987521a91.3
 for <qemu-devel@nongnu.org>; Mon, 24 Mar 2025 14:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742851866; x=1743456666; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DZMha2t/FZ5+K9Z9EZOfeX0DoxH1TC8eTZwVsJ1i/ss=;
 b=NWxHJCNPupZPzwVD1lSixplhyZjODvdsj4lFDhAp1onnaGANRS8KtpdWrEkmg/seeG
 5LY7p0bUadmN/IyH9U7s4jQxBw1wObcd2LsZX5cCvxSgnylwJbo6T2R9p7qWD0h/V9WL
 COFdArsZ7+MdS48xfeVhBTobH1JMVP6X9S/ykBhWgpPu8bpwV9+a9psifkl+shbUbaBe
 gSy62wNtJKMt8/vTO1ZWnBL9dy2HDzwtcG+YsuUGHzWY6OzqZdkYMoTIEghEgs/R/ep/
 2fDx38kGB+dnALuyt0qWANAwChkjVJZqYYvWY5g1STsmMMZvXMd7bKizqRdapfDVbupq
 mLjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742851866; x=1743456666;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DZMha2t/FZ5+K9Z9EZOfeX0DoxH1TC8eTZwVsJ1i/ss=;
 b=XGWF0pSZOrlk7i7MpQxSQVT6d75AhsTLkY0o/RLXGZNMM6232w2RgpA1OTK0rPQVOK
 odKpFoOnn3Uw5/b+2VLlhSm2019yzVvtG9SiQwrWdsAGasla/pBgcYotQf8RRHq5NH0r
 rDK8JQkoqeEF5AEmWcDkuCL+iaXEsS4C7//O627VeCBoN7QH0AsxjGfIPB1rWJatMjU4
 TdJifyjdCmrscKdRJzVIP1Bb0V1KMFoATJOIV5uAonNP1oqstB+pLxXPJ1AySCQ9L56/
 Yd3fGnJjgmvsGCxREBEMt6/zFrLdEp74MhCpS/pJKXPHx9MRB0cj8dzFlMEE+SNmU53I
 WSgg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW3rvaCbZYfZpUaS82myqfotWxNPFI/5f6ttdq2BcbKhLSxHq6xEHnA9NHjfYnc+tDYt8pg1XHWLbB+@nongnu.org
X-Gm-Message-State: AOJu0YwE0BFngJEaVI2awB/LQNAxSDmC/DZa1SY/8S/b0EkTJMfxaMzj
 9I1mFgF2x0zl/InfX5vDlcYWIJBAfL404oMNmMtv065HOm3fg989ryap51SHOLM=
X-Gm-Gg: ASbGncvHaKTRJC27fbbq57rOwsTAsfCpExuyaCbAPIG8D1T4KESoGYTivF3LtMQ0o4M
 UNUk0K0I1gOxvmHCaCr+jWh+GZ4MNxsNn6euhd/0/z9BQTE3l4DFB9n5gYuNZPKA/vchCGtvaKy
 JKY0gHJ4ioSOENzhCrdBKU5r6QinK5xYIG4FnuDJZpL5YO3FLO299QyFDw/lG1f40ncP1yho1X8
 1qBDZcRgS6S8ARB7DvHuEHg/jsj027eGudWg7JEO6fKP9TZ01/VA7GHhOXQpsFNO3QWWsGyGiRa
 WzCufdG6PO0iRAZsVUz5mEYifuIzwIAg2TuAjSMeMD9JXVfqFbHLBanZcw==
X-Google-Smtp-Source: AGHT+IEWM9SFBoRyuSSBgmsPzPEyPxIRrWFs5OX1/ahn8aCoiYKj7cEZouWUI2B4dIasMlmRfEjBoA==
X-Received: by 2002:a17:90a:d008:b0:2ff:693a:7590 with SMTP id
 98e67ed59e1d1-3030ff08de9mr28123196a91.33.1742851865643; 
 Mon, 24 Mar 2025 14:31:05 -0700 (PDT)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3036bbe74f4sm58175a91.1.2025.03.24.14.31.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Mar 2025 14:31:05 -0700 (PDT)
Message-ID: <6cce9fd1-d008-4b63-a77f-c091fcd933e0@linaro.org>
Date: Mon, 24 Mar 2025 14:31:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 26/30] hw/arm/armv7m: prepare compilation unit to be
 common
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20250320223002.2915728-1-pierrick.bouvier@linaro.org>
 <20250320223002.2915728-27-pierrick.bouvier@linaro.org>
 <0c9055a3-2650-4802-a28c-e5d79052bc81@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <0c9055a3-2650-4802-a28c-e5d79052bc81@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1029.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 3/23/25 12:48, Richard Henderson wrote:
> On 3/20/25 15:29, Pierrick Bouvier wrote:
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> ---
>>    hw/arm/armv7m.c | 12 ++++++++----
>>    1 file changed, 8 insertions(+), 4 deletions(-)
>>
>> diff --git a/hw/arm/armv7m.c b/hw/arm/armv7m.c
>> index 98a69846119..c367c2dcb99 100644
>> --- a/hw/arm/armv7m.c
>> +++ b/hw/arm/armv7m.c
>> @@ -139,8 +139,9 @@ static MemTxResult v7m_sysreg_ns_write(void *opaque, hwaddr addr,
>>        if (attrs.secure) {
>>            /* S accesses to the alias act like NS accesses to the real region */
>>            attrs.secure = 0;
>> +        MemOp end = target_words_bigendian() ? MO_BE : MO_LE;
>>            return memory_region_dispatch_write(mr, addr, value,
>> -                                            size_memop(size) | MO_TE, attrs);
>> +                                            size_memop(size) | end, attrs);
> 
> target_words_bigendian() is always false for arm system mode.
> Just s/TE/LE/.
> 

Good point.

By the way, what's the QEMU rationale behind having Arm big endian user 
binaries, and not provide it for softmmu binaries?
If those systems are so rare, why would people need a user mode emulation?

Thanks,
Pierrick

> 
> r~


