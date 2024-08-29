Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09ACFC7114C
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2024 00:06:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjSg7-0000Zz-QA; Wed, 28 Aug 2024 20:06:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sjSg3-0000Lr-Kt
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 20:06:16 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sjSg0-0004Os-Ok
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 20:06:15 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-7142a93ea9cso76245b3a.3
 for <qemu-devel@nongnu.org>; Wed, 28 Aug 2024 17:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1724889971; x=1725494771;
 darn=nongnu.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=N9S4TtZA+cJNX2N3kwZCY8f3O/bcxdb69X2c5iAlaK4=;
 b=yXUpRjoMFwiFn26tYUwL5xinc9zkAQFsKpgq0Da4VPqVaTOz78Bw9lrE9R13B55q/q
 KWF+oIkh1zNU8oVlw00hngKowGqN43h8SrvNSv8U5P/YcxfRmDnNhzTqppkAaEq5AhHz
 z4IC2vmjwbjSh8CJmYScjnTQIC/ik4GpoybjyjM/U7QNr2VnfAXDkjNO+AS7mzb7PXLC
 vHVaaJ5X6TkpF+YrszQQBM5rCHpRBYnW+jkO0uR8xYIkXWhOCukMYl2BhP4rVMGMolMW
 018GPNE8D+SXXYOusrGSZ3RLIRmUdLgLjCUbLwBHPPSS9jvGEgt25pu5wGJSrtOq1rd3
 3ahA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724889971; x=1725494771;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=N9S4TtZA+cJNX2N3kwZCY8f3O/bcxdb69X2c5iAlaK4=;
 b=qB1fLYs/6YUVz0Cu/4D3qseWDf+VzsVmOEBtrFUCMWnFMBnmJ9vqsSEuC3gtNbWxc5
 Co82SPRU+K1CiUVOK5t0NuVkew0mhEhyVTzZagr7KWnRATDAvfSS83c0m9atajooSJ5V
 kp9vPiE+iCWTIB3NWNDNWNuMo7xVxgTHghf+0SvUrvYpETB28YgcrRFUT7kwJdVMhOT9
 71HtNZGR17pxMn7V9mBe8d+7MfDwsi8SdCxeHX5bbJwfhf7FR9eYtd4OjmUeNNIyPtr4
 gzZpFDcz8Tbxo/JZAqPEy95YyZyfcMZcWjVkxTMYg+h9QojRVB39X/ZWhKmyBBlDl6b4
 3ItQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVzFUIcpWBj63q8kU6Iy2v54f17tHG0/gIa+3mR7dyP7/et6j0dRGlpcpna1oYc6a+eqqTfoU0WfqlQ@nongnu.org
X-Gm-Message-State: AOJu0YwcvB5uLQ7Sr+6QOfQxVhVnawrA4yiYd1X+s7fuOZjD/wp+/9zn
 jWGPpzwKTJKKOHbinhXxawilvpoICOkXcurHMc7HF9Qgi2Gw1iTRJr+zMEa/7QA=
X-Google-Smtp-Source: AGHT+IGhAyxQOPZRII5FUrRHmKfJCevV2ItfAmMw0npZmhlAKFC/MzN+ICXfyGjpPvta1r6LrtfOKQ==
X-Received: by 2002:a05:6a21:8cc5:b0:1ca:cd6d:3a26 with SMTP id
 adf61e73a8af0-1cce1015ca6mr850941637.27.1724889970727; 
 Wed, 28 Aug 2024 17:06:10 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-715e5576a4dsm46833b3a.17.2024.08.28.17.06.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2024 17:06:10 -0700 (PDT)
Date: Wed, 28 Aug 2024 17:06:08 -0700
From: Deepak Gupta <debug@rivosinc.com>
To: Alistair Francis <alistair23@gmail.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, palmer@dabbelt.com,
 Alistair.Francis@wdc.com, laurent@vivier.eu, bmeng.cn@gmail.com,
 liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, jim.shu@sifive.com,
 andy.chiu@sifive.com, kito.cheng@sifive.com
Subject: Re: [PATCH v11 16/20] target/riscv: implement zicfiss instructions
Message-ID: <Zs+7cCW04Y7beKJw@debug.ba.rivosinc.com>
References: <20240828174739.714313-1-debug@rivosinc.com>
 <20240828174739.714313-17-debug@rivosinc.com>
 <CAKmqyKOF0XGhSH5-vNKqFXhX=XB9p5STRAsm6kNaph=7i-7=3A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKmqyKOF0XGhSH5-vNKqFXhX=XB9p5STRAsm6kNaph=7i-7=3A@mail.gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=debug@rivosinc.com; helo=mail-pf1-x436.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Thu, Aug 29, 2024 at 10:01:30AM +1000, Alistair Francis wrote:
>On Thu, Aug 29, 2024 at 3:53 AM Deepak Gupta <debug@rivosinc.com> wrote:
>>
>> zicfiss has following instructions
>>  - sspopchk: pops a value from shadow stack and compares with x1/x5.
>>    If they dont match, reports a sw check exception with tval = 3.
>>  - sspush: pushes value in x1/x5 on shadow stack
>>  - ssrdp: reads current shadow stack
>>  - ssamoswap: swaps contents of shadow stack atomically
>>
>> sspopchk/sspush/ssrdp default to zimop if zimop implemented and SSE=0
>>
>> If SSE=0, ssamoswap is illegal instruction exception.
>>
>> This patch implements shadow stack operations for qemu-user and shadow
>> stack is not protected.
>>
>> Signed-off-by: Deepak Gupta <debug@rivosinc.com>
>> Co-developed-by: Jim Shu <jim.shu@sifive.com>
>> Co-developed-by: Andy Chiu <andy.chiu@sifive.com>
>> ---
>>  target/riscv/cpu_bits.h                       |  2 +
>>  target/riscv/insn32.decode                    | 21 +++++-
>>  target/riscv/insn_trans/trans_rva.c.inc       | 39 ++++++++++
>>  target/riscv/insn_trans/trans_rvzicfiss.c.inc | 75 +++++++++++++++++++
>>  target/riscv/translate.c                      |  5 ++
>>  5 files changed, 140 insertions(+), 2 deletions(-)
>>  create mode 100644 target/riscv/insn_trans/trans_rvzicfiss.c.inc
>>
>>  # *** Zabhb Standard Extension ***
>>  amoswap_b  00001 . . ..... ..... 000 ..... 0101111 @atom_st
>> diff --git a/target/riscv/insn_trans/trans_rva.c.inc b/target/riscv/insn_trans/trans_rva.c.inc
>> index 9cf3ae8019..a2119393a6 100644
>> --- a/target/riscv/insn_trans/trans_rva.c.inc
>> +++ b/target/riscv/insn_trans/trans_rva.c.inc
>> @@ -114,6 +114,25 @@ static bool trans_amoswap_w(DisasContext *ctx, arg_amoswap_w *a)
>>      return gen_amo(ctx, a, &tcg_gen_atomic_xchg_tl, MO_TESL);
>>  }
>>
>> +static bool trans_ssamoswap_w(DisasContext *ctx, arg_amoswap_w *a)
>> +{
>> +    REQUIRE_A_OR_ZAAMO(ctx);
>> +    if (!ctx->bcfi_enabled) {
>> +        return false;
>> +    }
>> +
>> +    TCGv dest = dest_gpr(ctx, a->rd);
>> +    TCGv src1, src2 = get_gpr(ctx, a->rs2, EXT_NONE);
>> +
>> +    decode_save_opc(ctx, RISCV_UW2_ALWAYS_STORE_AMO);
>> +    src1 = get_address(ctx, a->rs1, 0);
>> +
>> +    tcg_gen_atomic_xchg_tl(dest, src1, src2, SS_MMU_INDEX(ctx),
>> +                           (MO_ALIGN | MO_TESL));
>> +    gen_set_gpr(ctx, a->rd, dest);
>> +    return true;
>> +}
>> +
>>  static bool trans_amoadd_w(DisasContext *ctx, arg_amoadd_w *a)
>>  {
>>      REQUIRE_A_OR_ZAAMO(ctx);
>> @@ -183,6 +202,26 @@ static bool trans_amoswap_d(DisasContext *ctx, arg_amoswap_d *a)
>>      return gen_amo(ctx, a, &tcg_gen_atomic_xchg_tl, MO_TEUQ);
>>  }
>>
>> +static bool trans_ssamoswap_d(DisasContext *ctx, arg_amoswap_w *a)
>> +{
>> +    REQUIRE_64BIT(ctx);
>> +    REQUIRE_A_OR_ZAAMO(ctx);
>> +    if (!ctx->bcfi_enabled) {
>> +        return false;
>> +    }
>> +
>> +    TCGv dest = dest_gpr(ctx, a->rd);
>> +    TCGv src1, src2 = get_gpr(ctx, a->rs2, EXT_NONE);
>> +
>> +    decode_save_opc(ctx, RISCV_UW2_ALWAYS_STORE_AMO);
>> +    src1 = get_address(ctx, a->rs1, 0);
>> +
>> +    tcg_gen_atomic_xchg_tl(dest, src1, src2, SS_MMU_INDEX(ctx),
>> +                           (MO_ALIGN | MO_TESQ));
>> +    gen_set_gpr(ctx, a->rd, dest);
>> +    return true;
>> +}
>
>Why aren't these in the rvzicfiss file?

`ssamoswap` encodings are coming from (reserved) AMO encodings (and not zimop)
That's why kept it in trans_rva

>
>Otherwise:
>
>Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
>
>Alistair
>
>> +
>>  static bool trans_amoadd_d(DisasContext *ctx, arg_amoadd_d *a)
>>  {

