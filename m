Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97D35CCD185
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 15:56:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7FSZ-0000ic-0r; Fri, 10 Oct 2025 11:55:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v7FSK-0000TQ-MK
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 11:54:58 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v7FSF-0003S6-AO
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 11:54:55 -0400
Received: by mail-wm1-x344.google.com with SMTP id
 5b1f17b1804b1-46e34bd8eb2so21533495e9.3
 for <qemu-devel@nongnu.org>; Fri, 10 Oct 2025 08:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760111682; x=1760716482; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/aXLcoLzq/EtXQgkLnc5mib33pRtkKDIUYLimSAGgTU=;
 b=kcW9lulL3w3NyFuFNAOSKlIM/6gLSK8fGptcnq6wmSAbHD3LQltzv7hWGMS7GV1eql
 vndPPfU2kv/pgYvnAlsrWMH4cxYyt97ngu6N5loT31gm6JLZacilFHDMm9R0oB6cRxSb
 8lftMm3VINCmKdLMdh4yTT4gDb+EjYWpJvG0TXT0vxpAUrmTRcXWxzLMnGBc6r+dXLyx
 VffIoJEgEGtCo4r9iMosmi18CqlEC/lyJgTuYxB5MGAfwxyoIx4/IGwVPykOjKLDFaDe
 Ukj39FQRth/vDWXiVybGkriIVp/u3qQKe3H26kHzAXZsZp1hBDMtIdHA2twej4Q4VAdE
 K1Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760111682; x=1760716482;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/aXLcoLzq/EtXQgkLnc5mib33pRtkKDIUYLimSAGgTU=;
 b=Z7Z3+tqqh9dQMfROtInL8yk17WMbzKnvVv50cLY2ktsJzs1DElpgbQsInJwZ7awHif
 RCexgjx5xiQZxVJjGQt1NAEPal1jX+TRRqW9J66rUl1UL0k4QrV1dDkYxYMW+m59k40C
 6PjHZWm81taa6I9lOsVPqNDnbIIyFoV4OgQlFdK0KHKeCERubxpQtaGhU4UCFzhpPjNA
 aMe3/jnaGbDTM+c9WbREGv6iadlcH7TPs3nmRsEZEqx9/P5Lm04/Ml3iDhRqIbE1bcKq
 7UKRPt7dZE7NOXcOL5WW5tP5r03UVISLdlKK2eM+Ca2sjZYD0sJLUZ5YarhCGvMQyRdM
 y+Ew==
X-Forwarded-Encrypted: i=1;
 AJvYcCUS+SkRbA0FUyWhHCjUvgAU8jOPW5xnAKa1IMTajzPrRBy9DZ4WQFtkm91jbGdRuScG5McxMbZTXULm@nongnu.org
X-Gm-Message-State: AOJu0YyblonToUwRDsfQvYRJVnzfKKQ9F39AVBTlRjh891NSZoZpZIg7
 IbvIVsaddHyrYJd8yDDGbY4RxFZTaIoeUKXSRhuSizVPTq4cTR47ww/fKhlR99t4hB4=
X-Gm-Gg: ASbGnctXMO4qWWW1921fHJWCGURfGUd1dGdqgjNwdB4/BJ1Hwdd51jAQIeaBads8JWv
 aO/oMssBcuk5VxakyIztrtJElI9Zw6SCGwr9nzBC/9Kd4glWu1AOPipQXG41jetS38H0t921rIC
 pjGeGPETFkC/hS+73DaILfdtO409FgpREEAyoPQy4Eh5OmRAPBd127Kwt2HquEEcZG/L+RvszmE
 cZ8lCyYV9LZYj3b5XI3qX36wILTRhivOQwrkAhqkB+mz248CJZJpNSQ/uQu1UYI1lijYwoYqFk1
 k6aw//q+Yz+AqBpq8204vgRgz3Wzf9hUHtSkJOBVGNzbWb7sOT4UseMGGHrYeCSkGU9yNfJ0rjl
 2ANRJLkt+7eVH5onDkQn5MNgrk3GMBrxCP8Wcu7pfpEeSOqUrOIcnr7yzpm0r4oxReb1rrY8hZQ
 QQXNCVIa2wsrrv
X-Google-Smtp-Source: AGHT+IGSRceBdGvGWc7QOtmqYguLNeH80pyud/aDuDhsSdl5DenPzm8648q92FagQZjVhRDXLQ7xAw==
X-Received: by 2002:a05:600c:4688:b0:45c:b540:763d with SMTP id
 5b1f17b1804b1-46fa9b18258mr86837585e9.33.1760111681739; 
 Fri, 10 Oct 2025 08:54:41 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fab64aed8sm61023705e9.10.2025.10.10.08.54.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Oct 2025 08:54:41 -0700 (PDT)
Message-ID: <df62a62d-092a-4cdb-b160-2102b65d5431@linaro.org>
Date: Fri, 10 Oct 2025 17:54:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 09/18] target/riscv: accessors to registers upper part
 and 128-bit load/store
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: =?UTF-8?B?RnLDqWTDqXJpYyBQw6l0cm90?=
 <frederic.petrot@univ-grenoble-alpes.fr>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: bin.meng@windriver.com, richard.henderson@linaro.org, palmer@dabbelt.com, 
 fabien.portas@grenoble-inp.org, alistair.francis@wdc.com
References: <20220106210108.138226-1-frederic.petrot@univ-grenoble-alpes.fr>
 <20220106210108.138226-10-frederic.petrot@univ-grenoble-alpes.fr>
 <39bc0cef-cda7-43f7-8d9c-870599a6e91d@linaro.org>
In-Reply-To: <39bc0cef-cda7-43f7-8d9c-870599a6e91d@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x344.google.com
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

On 10/10/25 17:05, Philippe Mathieu-Daudé wrote:
> Hi Frédéric,
> 
> (old patch merged as commit a2f827ff4f44)
> 
> On 6/1/22 22:00, Frédéric Pétrot wrote:
>> Get function to retrieve the 64 top bits of a register, stored in the 
>> gprh
>> field of the cpu state. Set function that writes the 128-bit value at 
>> once.
>> The access to the gprh field can not be protected at compile time to make
>> sure it is accessed only in the 128-bit version of the processor 
>> because we
>> have no way to indicate that the misa_mxl_max field is const.
>>
>> The 128-bit ISA adds ldu, lq and sq. We provide support for these
>> instructions. Note that (a) we compute only 64-bit addresses to actually
>> access memory, cowardly utilizing the existing address translation 
>> mechanism
>> of QEMU, and (b) we assume for now little-endian memory accesses.
>>
>> Signed-off-by: Frédéric Pétrot <frederic.petrot@univ-grenoble-alpes.fr>
>> Co-authored-by: Fabien Portas <fabien.portas@grenoble-inp.org>
>> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
>> ---
>>   target/riscv/insn16.decode              |  27 ++++++-
>>   target/riscv/insn32.decode              |   5 ++
>>   target/riscv/translate.c                |  41 ++++++++++
>>   target/riscv/insn_trans/trans_rvi.c.inc | 100 ++++++++++++++++++++++--
>>   4 files changed, 163 insertions(+), 10 deletions(-)
> 
> 
>> +/* Compute only 64-bit addresses to use the address translation 
>> mechanism */
>> +static bool gen_load_i128(DisasContext *ctx, arg_lb *a, MemOp memop)
>> +{
>> +    TCGv src1l = get_gpr(ctx, a->rs1, EXT_NONE);
>> +    TCGv destl = dest_gpr(ctx, a->rd);
>> +    TCGv desth = dest_gprh(ctx, a->rd);
>> +    TCGv addrl = tcg_temp_new();
>> +
>> +    tcg_gen_addi_tl(addrl, src1l, a->imm);
>> +
>> +    if ((memop & MO_SIZE) <= MO_64) {
>> +        tcg_gen_qemu_ld_tl(destl, addrl, ctx->mem_idx, memop);
>> +        if (memop & MO_SIGN) {
>> +            tcg_gen_sari_tl(desth, destl, 63);
>> +        } else {
>> +            tcg_gen_movi_tl(desth, 0);
>> +        }
>> +    } else {
>> +        /* assume little-endian memory access for now */
>> +        tcg_gen_qemu_ld_tl(destl, addrl, ctx->mem_idx, MO_TEUQ);
>> +        tcg_gen_addi_tl(addrl, addrl, 8);
>> +        tcg_gen_qemu_ld_tl(desth, addrl, ctx->mem_idx, MO_TEUQ);
> 
> I am confused by this "assume little-endian access" comment, since
> you set the MO_TE flag (target endianness). I suppose you added the
> comment since the @memop argument is ignored in this code path.
> Maybe you want 'MO_LEUQ' here instead, to select little endianness?

Proposed fix:
https://lore.kernel.org/qemu-riscv/20251010155045.78220-2-philmd@linaro.org/

> 
>> +    }
>> +
>> +    gen_set_gpr128(ctx, a->rd, destl, desth);
>> +
>> +    tcg_temp_free(addrl);
>> +    return true;
>> +}
>> +
>> +static bool gen_load(DisasContext *ctx, arg_lb *a, MemOp memop)
>> +{
>> +    if (get_xl(ctx) == MXL_RV128) {
>> +        return gen_load_i128(ctx, a, memop);
>> +    } else {
>> +        return gen_load_tl(ctx, a, memop);
>> +    }
>> +}
> 

