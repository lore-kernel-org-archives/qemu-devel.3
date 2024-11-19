Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 274D1D44145
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2024 11:27:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDMOY-0005De-ST; Tue, 19 Nov 2024 06:27:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1tDMOW-0005Cy-TY
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 06:27:44 -0500
Received: from mail-oi1-x22f.google.com ([2607:f8b0:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1tDMOU-0002ap-E9
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 06:27:44 -0500
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-3e60d3adecbso1533657b6e.2
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2024 03:27:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1732015660; x=1732620460;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nf/RL8MnfTyTlUFJlhAI6o4jCtnqQx6OydAiLPnFHRI=;
 b=KF6J8TQRNFXfaimk8S9vkRk/j5sosKzAhEMLA7JMU43r1fWjSSZqEwrNWvY48fMH3L
 RxOtyzYIkV/FkmUQtjlSPVr40USckbi5RnLax22q5lSlCc2MJY1egZumEVfrnfP7jS7G
 XzjGBdLH/eYhR/rjVE6icFwd0pECA+WJaJ4K9rslI7ZHih/zo4jAtwmkKmQx0dxShBm4
 EMgvZd/GkOoG2XovF06q9Vk1WGuuj9P4x5CLFSoUFeJd4Sq57Mb2oagy4f1KJhsYx1Qz
 gjLvuP1N2xKqr4UZP8EWDanzZSreAujBrd4dUYTKVCIRVH/WakmgfnZSlT+Zc2VmSnNX
 nMIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732015660; x=1732620460;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nf/RL8MnfTyTlUFJlhAI6o4jCtnqQx6OydAiLPnFHRI=;
 b=UPkGEJ0ISr4t3GMLRy0PkloH1FOB8KgwHasWL/I393gZ38o2pwitxe9061MeWL5gTn
 q3sQ2mV3o43r+pnlnAj3ceuieohIr5qo35pS++IZUdevj1Q6wLXl6JvIUmW2pbbg6wkQ
 sZtfqIABRynNSk7u7ydGdCQY0PrzDL8vAk/QkU0+saZRo4EpBCxEHgs7yX8RU/uhJ0mK
 eESF5NYL9cvwOZl4q7u3QxaPjwfaPi9VOsYrtIV1/Rd3za9l2hQz2ADFx2wrhEo3S/ot
 nxwEf0wjePBclFtIRuUZq4gF/Felf47uZfG+wxazbYhQ9ddbwkPWLTZ3beTjAFOJfZw8
 +kZA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXTKv99TBJv+U+QJCvrdwFnQyUU8DJESHRzmudHiR4MP5soXzH+RMwGol7lD7jZtgA7GnsjGW6i6Jyd@nongnu.org
X-Gm-Message-State: AOJu0Yxjj4EVo1XwJIkVwKfx09lxcFoNXhrbvhO+N86GU9duRlFxjDWe
 tGj+hQo9xMsM1urAunL+AVoU2nO2t0UUcgip+yu87QTBp6+sN0so4jOWAnYpRgE=
X-Google-Smtp-Source: AGHT+IFmjNp3+0FWyYKCVJ8Zjg2BYBD9N9WRzDbin7kq3Odfu4gWoDvTwGO0yLWy5ahMbx0Ppr3DcQ==
X-Received: by 2002:a05:6808:2a86:b0:3e7:bcbe:ba07 with SMTP id
 5614622812f47-3e7bcbebaebmr11738200b6e.40.1732015660226; 
 Tue, 19 Nov 2024 03:27:40 -0800 (PST)
Received: from ?IPV6:2a01:e0a:e17:9700:16d2:7456:6634:9626?
 ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7f8c1dcf251sm7456591a12.83.2024.11.19.03.27.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Nov 2024 03:27:39 -0800 (PST)
Message-ID: <7c88eba0-c010-4aef-ad57-ede292129aff@rivosinc.com>
Date: Tue, 19 Nov 2024 12:27:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/9] target/riscv: fix henvcfg potentially containing
 stale bits
To: Alistair Francis <alistair23@gmail.com>
Cc: qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Ved Shanbhogue
 <ved@rivosinc.com>, Atish Patra <atishp@rivosinc.com>, qemu-devel@nongnu.org
References: <20241114091332.108811-1-cleger@rivosinc.com>
 <20241114091332.108811-2-cleger@rivosinc.com>
 <CAKmqyKO+v0AyvTER4a3JMzEN=b+NSa=BYdULt6=cGmmj46b_Jw@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <CAKmqyKO+v0AyvTER4a3JMzEN=b+NSa=BYdULt6=cGmmj46b_Jw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22f;
 envelope-from=cleger@rivosinc.com; helo=mail-oi1-x22f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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



On 19/11/2024 05:16, Alistair Francis wrote:
> On Thu, Nov 14, 2024 at 7:14 PM Clément Léger <cleger@rivosinc.com> wrote:
>>
>> With the current implementation, if we had the current scenario:
>> - set bit x in menvcfg
>> - set bit x in henvcfg
>> - clear bit x in menvcfg
>> then, the internal variable env->henvcfg would still contain bit x due
>> to both a wrong menvcfg mask used in write_henvcfg() as well as a
>> missing update of henvcfg upon menvcfg update.
>> This can lead to some wrong interpretation of the context. In order to
>> update henvcfg upon menvcfg writing, call write_henvcfg() after writing
>> menvcfg and fix the mask computation used in write_henvcfg() that is
>> used to mesk env->menvcfg value (which could still lead to some stale
>> bits). The same mechanism is also applied for henvcfgh writing.
>>
>> Signed-off-by: Clément Léger <cleger@rivosinc.com>
>> ---
>>  target/riscv/csr.c | 40 +++++++++++++++++++++++++++++++++++-----
>>  1 file changed, 35 insertions(+), 5 deletions(-)
>>
>> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
>> index b84b436151..73ac4d5449 100644
>> --- a/target/riscv/csr.c
>> +++ b/target/riscv/csr.c
>> @@ -2345,6 +2345,8 @@ static RISCVException read_menvcfg(CPURISCVState *env, int csrno,
>>      return RISCV_EXCP_NONE;
>>  }
>>
>> +static RISCVException write_henvcfg(CPURISCVState *env, int csrno,
>> +                                    target_ulong val);
>>  static RISCVException write_menvcfg(CPURISCVState *env, int csrno,
>>                                      target_ulong val)
>>  {
>> @@ -2357,6 +2359,7 @@ static RISCVException write_menvcfg(CPURISCVState *env, int csrno,
>>                  (cfg->ext_svadu ? MENVCFG_ADUE : 0);
>>      }
>>      env->menvcfg = (env->menvcfg & ~mask) | (val & mask);
>> +    write_henvcfg(env, CSR_HENVCFG, env->henvcfg);
>>
>>      return RISCV_EXCP_NONE;
>>  }
>> @@ -2368,6 +2371,8 @@ static RISCVException read_menvcfgh(CPURISCVState *env, int csrno,
>>      return RISCV_EXCP_NONE;
>>  }
>>
>> +static RISCVException write_henvcfgh(CPURISCVState *env, int csrno,
>> +                                    target_ulong val);
>>  static RISCVException write_menvcfgh(CPURISCVState *env, int csrno,
>>                                       target_ulong val)
>>  {
>> @@ -2378,6 +2383,7 @@ static RISCVException write_menvcfgh(CPURISCVState *env, int csrno,
>>      uint64_t valh = (uint64_t)val << 32;
>>
>>      env->menvcfg = (env->menvcfg & ~mask) | (valh & mask);
>> +    write_henvcfgh(env, CSR_HENVCFGH, env->henvcfg >> 32);
>>
>>      return RISCV_EXCP_NONE;
>>  }
>> @@ -2435,6 +2441,7 @@ static RISCVException write_henvcfg(CPURISCVState *env, int csrno,
>>                                      target_ulong val)
>>  {
>>      uint64_t mask = HENVCFG_FIOM | HENVCFG_CBIE | HENVCFG_CBCFE | HENVCFG_CBZE;
>> +    uint64_t henvcfg_mask = mask, menvcfg_mask;
>>      RISCVException ret;
>>
>>      ret = smstateen_acc_ok(env, 0, SMSTATEEN0_HSENVCFG);
>> @@ -2443,10 +2450,24 @@ static RISCVException write_henvcfg(CPURISCVState *env, int csrno,
>>      }
>>
>>      if (riscv_cpu_mxl(env) == MXL_RV64) {
>> -        mask |= env->menvcfg & (HENVCFG_PBMTE | HENVCFG_STCE | HENVCFG_ADUE);
>> +        /*
>> +         * Since henvcfg depends on a menvcfg subset, we want to clear all the
>> +         * menvcfg supported feature (whatever their state is) before enabling
>> +         * some new one using the provided value. Not doing so would result in
>> +         * keeping stale menvcfg bits in henvcfg value if a bit was enabled in
>> +         * menvcfg and then disabled before updating henvcfg for instance.
>> +         */
>> +        menvcfg_mask = HENVCFG_PBMTE | HENVCFG_STCE | HENVCFG_ADUE;
>> +        mask |= env->menvcfg & menvcfg_mask;
>> +        henvcfg_mask |= menvcfg_mask;
>>      }
>>
>> -    env->henvcfg = (env->henvcfg & ~mask) | (val & mask);
>> +    /*
>> +     * 'henvcfg_mask' contains all supported bits (both in henvcfg and menvcfg
>> +     * common bits) and 'mask' contains henvcfg exclusive bits as well as
>> +     * menvcfg enabled bits only.
>> +     */
>> +    env->henvcfg = (env->henvcfg & ~henvcfg_mask) | (val & mask);
> 
> Won't `env->henvcfg & ~henvcfg_mask` still contain the stale data?
> `henvcfg_mask` isn't based on the current value of `env->menvcfg`

Hey Alistair,

That's the point, env->henvcfg is cleared with henvcfg_mask which
contains the set of HENVCFG_* and MENVCFG_* "raw" bits so that the new
value that is written does not contain any menvcfg stale bits. "mask"
however is actually masked with menvcfg value to ensure the new bits
that are going to be written won't contain any incoherent bits.

I guess this still needs a few more explanations if that is not clear
enough, sorry for that.

Thanks,

Clément
> 
> Alistair
> 
>>
>>      return RISCV_EXCP_NONE;
>>  }
>> @@ -2469,8 +2490,13 @@ static RISCVException read_henvcfgh(CPURISCVState *env, int csrno,
>>  static RISCVException write_henvcfgh(CPURISCVState *env, int csrno,
>>                                       target_ulong val)
>>  {
>> -    uint64_t mask = env->menvcfg & (HENVCFG_PBMTE | HENVCFG_STCE |
>> -                                    HENVCFG_ADUE);
>> +    /*
>> +     * Same comment than the one in write_henvcfg() applies here, we want to
>> +     * clear all previous menvcfg bits before enabling some new one to avoid
>> +     * stale menvcfg bits in henvcfg.
>> +     */
>> +    uint64_t henvcfg_mask = (HENVCFG_PBMTE | HENVCFG_STCE | HENVCFG_ADUE);
>> +    uint64_t mask = env->menvcfg & henvcfg_mask;
>>      uint64_t valh = (uint64_t)val << 32;
>>      RISCVException ret;
>>
>> @@ -2479,7 +2505,11 @@ static RISCVException write_henvcfgh(CPURISCVState *env, int csrno,
>>          return ret;
>>      }
>>
>> -    env->henvcfg = (env->henvcfg & ~mask) | (valh & mask);
>> +    /*
>> +     * 'henvcfg_mask' contains all menvcfg supported bits and 'mask' contains
>> +     * menvcfg enabled bits only.
>> +     */
>> +    env->henvcfg = (env->henvcfg & ~henvcfg_mask) | (valh & mask);
>>      return RISCV_EXCP_NONE;
>>  }
>>
>> --
>> 2.45.2
>>
>>


