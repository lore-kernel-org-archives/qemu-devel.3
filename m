Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4197BC2D0D1
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 06:51:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLdXF-0004I0-5t; Mon, 24 Jun 2024 02:50:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1sLdXD-0004H2-O3
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 02:50:39 -0400
Received: from mail-il1-x12f.google.com ([2607:f8b0:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1sLdXB-0000YE-OP
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 02:50:39 -0400
Received: by mail-il1-x12f.google.com with SMTP id
 e9e14a558f8ab-375af3538f2so17017115ab.3
 for <qemu-devel@nongnu.org>; Sun, 23 Jun 2024 23:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1719211836; x=1719816636; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DAVzGjK5sXVJtAfTUtSFPiGGD39VHhVvUhPK0ce9O5k=;
 b=HBWa8I2JOXxVGwZor9AlqDyiKFHgoO/7cAg7l8R7Z1bWGMAERlilJhn+rxJdq49V9H
 sDeslvohdTN88lUa0h57YRs/B+PgVD+IRzosFFJq5mryae1I2VZnW7EXeRtQjVu71825
 DsylUWZzJVs2Xoqmq2K1+36vBcIwx0+sb0smMZdjqcZMJXEdExWy2Xvg3E/o5SrKhNVj
 2f4RbXZXKDOqWvb3QxRr5G+a0MUOicv+LDVDF1/nCf7Tm4hPITN4Zlf3oZ33Is/rNt8O
 O31Frx56l6b4Ega8ka2bToN3n1ECnC3xME9t4lFyHt3t4oMwE7h2NmIhS4QdPy+RrzUD
 e0TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719211836; x=1719816636;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DAVzGjK5sXVJtAfTUtSFPiGGD39VHhVvUhPK0ce9O5k=;
 b=QG+CH15CUJ5/Cwn6jsGKWAvjSlTZL6keFo9HtU/boXhLG+h607mPRILPgOaRbNT3ir
 BnMKBVe01O+7bYowHZibzZnrdVcPmNOyLxUN+1Yq35LcEt2qUZ+wJL1GocDChBNJa/Eb
 Jh+hy5XR4gmYpmpHAYQrTTJVKH5d+dbnoxn/aw4sGhlCULF5dHuRV8fm7iRwMYAhlcvq
 1Xf2t780WO61bk7z9qsZVFxnVnTzyg9wl7kgltssduJ+r0IgEDZB/dAXhfXDBDXbxj0w
 ySeT6bNwPp13ES7XpWj4LXhnSkjORKjII2ysrTXIGwYJXfJcpNCFCu3H3373h130/mhO
 iqow==
X-Forwarded-Encrypted: i=1;
 AJvYcCVNuuix8P2W8Qh3bPeRKxy6W9O1Jloiz7VqCk6G4GMjRvvH9ley7l0RHi9TUV+8FdvUI/Z6OGvAmMdB0L7H9Iii0yQKBkY=
X-Gm-Message-State: AOJu0Ywua3Y/yg/HvqnOgOMAzJW4Yfttv/NxWuWdCVBt1oixgXmfVvaL
 4sPaoXBYHvThLQfydHWOIzHE4JvvMUIYBR+kbtQ9Juth6aQmUD20D7RIQXwfkXE=
X-Google-Smtp-Source: AGHT+IFK84K+t5FbFNmPUplQoLxz/WDi+H1e5Q1PQc1DEeNFVBO8NOv5QZ9NDa3MkWN9pdyOBl97fw==
X-Received: by 2002:a92:c266:0:b0:375:da02:b7ef with SMTP id
 e9e14a558f8ab-3763f5d9cf2mr41569845ab.19.1719211836043; 
 Sun, 23 Jun 2024 23:50:36 -0700 (PDT)
Received: from [100.64.0.1] (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-716b4a72f9fsm4093779a12.48.2024.06.23.23.50.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 23 Jun 2024 23:50:35 -0700 (PDT)
Message-ID: <f4c6e859-f4dc-49be-8c1d-cc817116bb05@sifive.com>
Date: Mon, 24 Jun 2024 14:50:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 4/5] target/riscv: rvv: Provide group continuous
 ld/st flow for unit-stride ld/st instructions
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
References: <20240613175122.1299212-1-max.chou@sifive.com>
 <20240613175122.1299212-5-max.chou@sifive.com>
 <acbf0fae-51be-4aa1-ba79-94345ecfbb21@linaro.org>
Content-Language: en-US
From: Max Chou <max.chou@sifive.com>
In-Reply-To: <acbf0fae-51be-4aa1-ba79-94345ecfbb21@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::12f;
 envelope-from=max.chou@sifive.com; helo=mail-il1-x12f.google.com
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

On 2024/6/20 12:38 PM, Richard Henderson wrote:

> On 6/13/24 10:51, Max Chou wrote:
>> The vector unmasked unit-stride and whole register load/store
>> instructions will load/store continuous memory. If the endian of both
>> the host and guest architecture are the same, then we can group the
>> element load/store to load/store more data at a time.
>>
>> Signed-off-by: Max Chou <max.chou@sifive.com>
>> ---
>>   target/riscv/vector_helper.c | 160 +++++++++++++++++++++++++----------
>>   1 file changed, 117 insertions(+), 43 deletions(-)
>>
>> diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
>> index 793337a6f96..cba46ef16a5 100644
>> --- a/target/riscv/vector_helper.c
>> +++ b/target/riscv/vector_helper.c
>> @@ -457,6 +457,69 @@ GEN_VEXT_ST_ELEM(ste_h, uint16_t, H2, stw)
>>   GEN_VEXT_ST_ELEM(ste_w, uint32_t, H4, stl)
>>   GEN_VEXT_ST_ELEM(ste_d, uint64_t, H8, stq)
>>   +static inline uint32_t
>> +vext_group_ldst_host(CPURISCVState *env, void *vd, uint32_t byte_end,
>> +                     uint32_t byte_offset, void *host, uint32_t esz,
>> +                     bool is_load)
>> +{
>> +    uint32_t group_size;
>> +    static vext_ldst_elem_fn_host * const fns[2][4] = {
>> +        /* Store */
>> +        { ste_b_host, ste_h_host, ste_w_host, ste_d_host },
>> +        /* Load */
>> +        { lde_b_host, lde_h_host, lde_w_host, lde_d_host }
>> +    };
>> +    vext_ldst_elem_fn_host *fn;
>> +
>> +    if (byte_offset + 8 < byte_end) {
>> +        group_size = MO_64;
>> +    } else if (byte_offset + 4 < byte_end) {
>> +        group_size = MO_32;
>> +    } else if (byte_offset + 2 < byte_end) {
>> +        group_size = MO_16;
>> +    } else {
>> +        group_size = MO_8;
>> +    }
>> +
>> +    fn = fns[is_load][group_size];
>> +    fn(vd, byte_offset, host + byte_offset);
>
> This is a really bad idea.  The table and indirect call means that 
> none of these will be properly inlined.  Anyway...
>
>> +
>> +    return 1 << group_size;
>> +}
>> +
>> +static inline void
>> +vext_continus_ldst_tlb(CPURISCVState *env, vext_ldst_elem_fn_tlb 
>> *ldst_tlb,
>> +                       void *vd, uint32_t evl, target_ulong addr,
>> +                       uint32_t reg_start, uintptr_t ra, uint32_t esz,
>> +                       bool is_load)
>> +{
>> +    for (; reg_start < evl; reg_start++, addr += esz) {
>> +        ldst_tlb(env, adjust_addr(env, addr), reg_start * esz, vd, ra);
>> +    }
>> +}
>> +
>> +static inline void
>> +vext_continus_ldst_host(CPURISCVState *env, vext_ldst_elem_fn_host 
>> *ldst_host,
>> +                        void *vd, uint32_t evl, uint32_t reg_start, 
>> void *host,
>> +                        uint32_t esz, bool is_load)
>> +{
>> +#if TARGET_BIG_ENDIAN != HOST_BIG_ENDIAN
>> +    for (; reg_start < evl; reg_start++) {
>> +        uint32_t byte_off = reg_start * esz;
>> +        ldst_host(vd, byte_off, host + byte_off);
>> +    }
>> +#else
>> +    uint32_t group_byte;
>> +    uint32_t byte_start = reg_start * esz;
>> +    uint32_t byte_end = evl * esz;
>> +    while (byte_start < byte_end) {
>> +        group_byte = vext_group_ldst_host(env, vd, byte_end, 
>> byte_start, host,
>> +                                          esz, is_load);
>> +        byte_start += group_byte;
>> +    }
>
> ... this is much better handled with memcpy, given that you know 
> endianness matches.
Thanks for the suggestion.
I'll try to replace the original implementation of the table and 
indirect calls by handled with memcpy at the next version.

Max.
>
>
> r~

