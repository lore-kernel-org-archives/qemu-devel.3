Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4213CCD1284
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Apr 2024 17:27:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsQqx-0008LT-Px; Thu, 04 Apr 2024 13:26:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rsQqs-0008L6-2w
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 13:26:14 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rsQqp-0005Nq-Ur
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 13:26:13 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4162c11acf7so5815615e9.2
 for <qemu-devel@nongnu.org>; Thu, 04 Apr 2024 10:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712251570; x=1712856370; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GhoJjn1+S0shgeZiJQ+ETSp/HUQvC+RRpX5HsasrRVA=;
 b=eGngwUlzbGH7v9d1Mn/vhy6HNKd1JNSqfwvL8WDv730/TgXTM2GCydPE7qzobEk9sp
 6IVuj2sYVEzYcVZc1JHt+z6l03FClzSnshlTt5sOI7uCbrwBuMuVUzDTA1VhdKA1F0wC
 BrF2xjo5Fnfm+nuosc0XPS+BzoVEGIfY7pqFc5hlw6GXOD2/uA0fMPwytZvAFSfYGMDj
 UaA+LJsEMvRk/OgjUTU/1bd8F3vtftIcQ4aA5O+rtwSMjUbKq9nFu5PrKXwP9+3gPBM2
 FucGpgTWr/2/kiuMy29twbUglsLCL0BERGIGafMw+ACD/Qpo0cokxGZeUUjJ+O6QEiGk
 mZ7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712251570; x=1712856370;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GhoJjn1+S0shgeZiJQ+ETSp/HUQvC+RRpX5HsasrRVA=;
 b=aIkh3AL/UEmAsKyfBjChLuKUDK7DEJgAP6TAIhaPCfmP5Ka/G5HkBQC8z7pvF931+F
 WPvUUShO0Bi37P8P3wyHvFadj9zhIEQLyI11aLC2qb0r4C3up7s4yPfXrdmdXwbw9lK1
 YoBqwPRpz9yQDsFxij7Q9fmZ+GKfX5kt5MpICrLPd8GNhI0SdOfIyLw6GydqZ/Glu7Cl
 0bX/3ZIKMRm2FA0YLv4jnx+rRSnFJGcgWu49uHpCOUSRvoLVwRQculTHkIjiMD+3OHMO
 MWGEH4yr5SMyJd0zrI6G7F5ZvTu4A+o4XMONSxRv5VUloo7ih8qM4WLSbWpK9ZvJMb9s
 zR7A==
X-Gm-Message-State: AOJu0YzjlSiVlFPycOWzweEZRbH82ipdZKH5DNN7J+qclhEoMzZ7yG23
 /pW+o0hKYwe7QyTS6M0kewP3m9xh7R8ell8QfuBN3h0fraZfddBrtn0xyZHQXtE=
X-Google-Smtp-Source: AGHT+IHuNpkd0CFVnyB7slXWpsCog7FsL0/Z/dFCHFXnhCttfVLiyVMrOjqAjQkEP6dqe0lH1P35pA==
X-Received: by 2002:adf:cb8a:0:b0:33d:dcd4:9d8f with SMTP id
 q10-20020adfcb8a000000b0033ddcd49d8fmr2423242wrh.65.1712251570137; 
 Thu, 04 Apr 2024 10:26:10 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.216.111])
 by smtp.gmail.com with ESMTPSA id
 dw11-20020a0560000dcb00b00341c7129e28sm20653058wrb.91.2024.04.04.10.26.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Apr 2024 10:26:09 -0700 (PDT)
Message-ID: <dc5a8b5f-9251-477f-893e-53cd4a320a07@linaro.org>
Date: Thu, 4 Apr 2024 19:26:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] sh4: mac.l: implement saturation arithmetic logic
To: Peter Maydell <peter.maydell@linaro.org>, Zack Buhman <zack@buhman.org>
Cc: qemu-devel@nongnu.org, Yoshinori Sato <ysato@users.sourceforge.jp>
References: <CAFEAcA-VQ0yZMoFEuYWD2twe129OZHaer+-_49inW1exANKV2w@mail.gmail.com>
 <20240404162641.27528-2-zack@buhman.org>
 <CAFEAcA_duQyCLGyu4f4KwOCEhnEeELDHGqCM9cQtC4d6rF4piQ@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA_duQyCLGyu4f4KwOCEhnEeELDHGqCM9cQtC4d6rF4piQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

Hi Zack,

Cc'ing the maintainer of this file, Yoshinori:

$ ./scripts/get_maintainer.pl -f target/sh4/op_helper.c
Yoshinori Sato <ysato@users.sourceforge.jp> (reviewer:SH4 TCG CPUs)
(https://www.qemu.org/docs/master/devel/submitting-a-patch.html#cc-the-relevant-maintainer)

On 4/4/24 18:39, Peter Maydell wrote:
> On Thu, 4 Apr 2024 at 17:26, Zack Buhman <zack@buhman.org> wrote:
>>
>> The saturation arithmetic logic in helper_macl is not correct.
>>
>> I tested and verified this behavior on a SH7091, the general pattern
>> is a code sequence such as:
>>
>>          sets
>>
>>          mov.l _mach,r2
>>          lds r2,mach
>>          mov.l _macl,r2
>>          lds r2,macl
>>
>>          mova _n,r0
>>          mov r0,r1
>>          mova _m,r0
>>          mac.l @r0+,@r1+
>>
>>      _mach: .long 0x00007fff
>>      _macl: .long 0x12345678
>>      _m:    .long 0x7fffffff
>>      _n:    .long 0x7fffffff
>>
>> Test case 0: (no int64_t overflow)
>>    given; prior to saturation mac.l:
>>      mach = 0x00007fff macl = 0x12345678
>>      @r0  = 0x7fffffff @r1  = 0x7fffffff
>>
>>    expected saturation mac.l result:
>>      mach = 0x00007fff macl = 0xffffffff
>>
>>    qemu saturation mac.l result (prior to this commit):
>>      mach = 0x00007ffe macl = 0x12345678
>>
>> Test case 1: (no int64_t overflow)
>>    given; prior to saturation mac.l:
>>      mach = 0xffff8000 macl = 0x00000000
>>      @r0  = 0xffffffff @r1  = 0x00000001
>>
>>    expected saturation mac.l result:
>>      mach = 0xffff8000 macl = 0x00000000
>>
>>    qemu saturation mac.l result (prior to this commit):
>>      mach = 0xffff7fff macl = 0xffffffff
>>
>> Test case 2: (int64_t addition overflow)
>>    given; prior to saturation mac.l:
>>      mach = 0x80000000 macl = 0x00000000
>>      @r0  = 0xffffffff @r1  = 0x00000001
>>
>>    expected saturation mac.l result:
>>      mach = 0xffff8000 macl = 0x00000000
>>
>>    qemu saturation mac.l result (prior to this commit):
>>      mach = 0xffff7fff macl = 0xffffffff
>>
>> Test case 3: (int64_t addition overflow)
>>    given; prior to saturation mac.l:
>>      mach = 0x7fffffff macl = 0x00000000
>>      @r0 = 0x7fffffff @r1 = 0x7fffffff
>>
>>    expected saturation mac.l result:
>>      mach = 0x00007fff macl = 0xffffffff
>>
>>    qemu saturation mac.l result (prior to this commit):
>>      mach = 0xfffffffe macl = 0x00000001
>>
>> All of the above also matches the description of MAC.L as documented
>> in cd00147165-sh-4-32-bit-cpu-core-architecture-stmicroelectronics.pdf
> 
> Hi. I just noticed that you didn't include a signed-off-by line
> in your commit message. We need these as they're how you say
> that you're legally OK to contribute this code to QEMU and
> you're happy for it to go into the project:
> 
> https://www.qemu.org/docs/master/devel/submitting-a-patch.html#patch-emails-must-include-a-signed-off-by-line
> has links to what exactly this means, but basically the
> requirement is that the last line of your commit message should be
> "Signed-off-by: Your Name <your@email>"
> 
> In this case, if you just reply to this email with that, we
> can pick it up and fix up the commit message when we apply the
> patch.
> 
>> ---
>>   target/sh4/op_helper.c | 31 +++++++++++++++++++++----------
>>   1 file changed, 21 insertions(+), 10 deletions(-)
>>
>> diff --git a/target/sh4/op_helper.c b/target/sh4/op_helper.c
>> index 4559d0d376..ee16524083 100644
>> --- a/target/sh4/op_helper.c
>> +++ b/target/sh4/op_helper.c
>> @@ -160,18 +160,29 @@ void helper_ocbi(CPUSH4State *env, uint32_t address)
>>
>>   void helper_macl(CPUSH4State *env, uint32_t arg0, uint32_t arg1)
>>   {
>> -    int64_t res;
>> -
>> -    res = ((uint64_t) env->mach << 32) | env->macl;
>> -    res += (int64_t) (int32_t) arg0 *(int64_t) (int32_t) arg1;
>> -    env->mach = (res >> 32) & 0xffffffff;
>> -    env->macl = res & 0xffffffff;
>> +    int32_t value0 = (int32_t)arg0;
>> +    int32_t value1 = (int32_t)arg1;
>> +    int64_t mul = ((int64_t)value0) * ((int64_t)value1);
>> +    int64_t mac = (((uint64_t)env->mach) << 32) | env->macl;
>> +    int64_t result;
>> +    bool overflow = sadd64_overflow(mac, mul, &result);
>> +    /* Perform 48-bit saturation arithmetic if the S flag is set */
>>       if (env->sr & (1u << SR_S)) {
>> -        if (res < 0)
>> -            env->mach |= 0xffff0000;
>> -        else
>> -            env->mach &= 0x00007fff;
>> +        /*
>> +         * The sign bit of `mac + mul` may overflow. The MAC unit on
>> +         * real SH-4 hardware has equivalent carry/saturation logic:
>> +         */
>> +        const int64_t upper_bound =  ((1ull << 47) - 1);
>> +        const int64_t lower_bound = -((1ull << 47) - 0);
>> +
>> +        if (overflow) {
>> +            result = (mac < 0) ? lower_bound : upper_bound;
>> +        } else {
>> +            result = MIN(MAX(result, lower_bound), upper_bound);
>> +        }
>>       }
>> +    env->macl = result;
>> +    env->mach = result >> 32;
>>   }
> 
> I haven't checked the sh4 docs but the change looks right, so
> 
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> 
> thanks
> -- PMM
> 


