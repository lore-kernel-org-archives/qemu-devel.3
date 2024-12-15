Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C97DE7717F
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Dec 2024 15:15:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMqLL-0001KU-KK; Sun, 15 Dec 2024 10:15:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMqLJ-0001Jx-7O
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 10:15:37 -0500
Received: from mail-oi1-x235.google.com ([2607:f8b0:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMqLH-0004vj-49
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 10:15:36 -0500
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-3eba50d6da7so635431b6e.2
 for <qemu-devel@nongnu.org>; Sun, 15 Dec 2024 07:15:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734275733; x=1734880533; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=inMSExsqQrxiAZD2iWzrhs/tePAYkCFM/uXdzWL42Ms=;
 b=AuiW4IBv5yoM44wU6o+V4mGAs5oTGNz0enQ67LPCBh+nyJ4qKtIGE+jY86dCYFhA4z
 LXOpLplyda7YpsEHqroPKU5gQ9/Xe3u0iZrXgO8frHDvMxqk2Ujc2pqH988ZeB2sJ8Lh
 kFIitfgQ/VdYhHnr20OQ7dfc3CQC7RFS5oylxXmprgevLeVZliCNcTpqcM+7qS0VK0tT
 L27oDXi0pZ6FMjjRHCfDWqhRLacnbqaEZYaBLH5EgtfqJiiI50sHBcpFGWkDYXPYxIXF
 PrCaKwr4SkwOCzC8lVABLFkw4zTKZDZlj3/glrLMDUNrpzxN1G88Kx9ShUWGgc6fAIRv
 eeJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734275733; x=1734880533;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=inMSExsqQrxiAZD2iWzrhs/tePAYkCFM/uXdzWL42Ms=;
 b=OhZ579KaetbEswC56ferBIWzrEf6NaGE4QRYc6fXqKz4+FFhwO0ZAHTsxEVMsNBnJN
 gHkNCrscyJKtx7+AYsrAAAd0ALuIMlgBbgfdgpP6NZHzj70DZVG+b3OaD/LctK40xsB+
 FRHqAB7eK+YmuGolwj7WXJUvjIEgSux1ve3c6DRG+ibiy7s7G0JiJUZTu47IP+HnCbIR
 JmLW/+YB1DLppjLf+k6zvxBUHnW/Kbxf0rfmLFL2ZE8NXLbexAG8qBERlutfbiXRNIiH
 z+OTL1bpwMAXfyQLfd9zAwyjwdPclTab9m/evUWymE9hqGmq+uo2CNaPf0xoywUcwVFo
 WIkQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXIGjE5y05r2D+btGW6wID++abYM8mzeJthlntwPHM/pIiN82KD+Glylb4i1cgr+Ku+YvE7BxipLxB1@nongnu.org
X-Gm-Message-State: AOJu0YzKinvI9imBlH3uf3Vo/yeNNIrrGsLsz6PeeD1wC1IPxE0JKl/9
 3t7ZFlIkxLOqCmrttJABoHR4lQZzPQynlIyv1kUU43K+6Gppq/J1xWLt1pDskZc=
X-Gm-Gg: ASbGnct/34l+OtGN7+SZE3Tz6pYNjFheTM/dcOlrj9/r7SWdIWkk/Yg4iEOJ+yz70ZP
 cAu1WP0NAfXcE4vQujhlfE2sBGFGRi8ILArjwjShbXDDMaRS4bTO+/M1UHaD9wnJ9Rr9A7FpYiJ
 LddoU7iRUoaZ5QedJB5fz7UjHn6YFzx1y/CTdlSTbdxJH631kEzyLupqaExXO8TdoQwVzEAkJ3O
 HmW+sORsq8U+cZzJ6U85CYdDMBkXempS3AVC3O/u8js1MATtyJba1JkTxGLWltkZfZ6Q3cqWSu8
 HbDPdIzm3TPoVxziBubVPTlhS0qOXAIUEvA=
X-Google-Smtp-Source: AGHT+IGsfHLw69u9UxwwXU4PH/K4wawKFGuQRxZd9110kzAwF5x1Sj/2lJUWoXzzpiKjggTe9af5NQ==
X-Received: by 2002:a05:6808:200b:b0:3e6:61ed:d62 with SMTP id
 5614622812f47-3eba68230a0mr5746878b6e.6.1734275733354; 
 Sun, 15 Dec 2024 07:15:33 -0800 (PST)
Received: from [192.168.4.112] (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3ebb48d2336sm1025452b6e.41.2024.12.15.07.15.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 15 Dec 2024 07:15:32 -0800 (PST)
Message-ID: <a7949663-8ca3-4ca7-8bc8-8c20ce29344c@linaro.org>
Date: Sun, 15 Dec 2024 09:15:30 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/13] target/i386: pull computation of string update
 value out of loop
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20241215090613.89588-1-pbonzini@redhat.com>
 <20241215090613.89588-13-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241215090613.89588-13-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::235;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x235.google.com
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

On 12/15/24 03:06, Paolo Bonzini wrote:
> This is a common operation that is executed many times in rep
> movs or rep stos loops.  It can improve performance by several
> percentage points.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   target/i386/tcg/translate.c | 54 ++++++++++++++++++-------------------
>   1 file changed, 26 insertions(+), 28 deletions(-)
> 
> diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
> index e0f9f7748bc..4b652cc23e1 100644
> --- a/target/i386/tcg/translate.c
> +++ b/target/i386/tcg/translate.c
> @@ -831,16 +831,13 @@ static bool gen_check_io(DisasContext *s, MemOp ot, TCGv_i32 port,
>   #endif
>   }
>   
> -static void gen_movs(DisasContext *s, MemOp ot)
> +static void gen_movs(DisasContext *s, MemOp ot, TCGv dshift)
>   {
> -    TCGv dshift;
> -
>       gen_string_movl_A0_ESI(s);
>       gen_op_ld_v(s, ot, s->T0, s->A0);
>       gen_string_movl_A0_EDI(s);
>       gen_op_st_v(s, ot, s->T0, s->A0);
>   
> -    dshift = gen_compute_Dshift(s, ot);
>       gen_op_add_reg(s, s->aflag, R_ESI, dshift);
>       gen_op_add_reg(s, s->aflag, R_EDI, dshift);
>   }
> @@ -1244,22 +1241,22 @@ static inline void gen_jcc(DisasContext *s, int b, TCGLabel *l1)
>       }
>   }
>   
> -static void gen_stos(DisasContext *s, MemOp ot)
> +static void gen_stos(DisasContext *s, MemOp ot, TCGv dshift)
>   {
>       gen_string_movl_A0_EDI(s);
>       gen_op_st_v(s, ot, s->T0, s->A0);
> -    gen_op_add_reg(s, s->aflag, R_EDI, gen_compute_Dshift(s, ot));
> +    gen_op_add_reg(s, s->aflag, R_EDI, dshift);
>   }
>   
> -static void gen_lods(DisasContext *s, MemOp ot)
> +static void gen_lods(DisasContext *s, MemOp ot, TCGv dshift)
>   {
>       gen_string_movl_A0_ESI(s);
>       gen_op_ld_v(s, ot, s->T0, s->A0);
>       gen_op_mov_reg_v(s, ot, R_EAX, s->T0);
> -    gen_op_add_reg(s, s->aflag, R_ESI, gen_compute_Dshift(s, ot));
> +    gen_op_add_reg(s, s->aflag, R_ESI, dshift);
>   }
>   
> -static void gen_scas(DisasContext *s, MemOp ot)
> +static void gen_scas(DisasContext *s, MemOp ot, TCGv dshift)
>   {
>       gen_string_movl_A0_EDI(s);
>       gen_op_ld_v(s, ot, s->T1, s->A0);
> @@ -1268,13 +1265,11 @@ static void gen_scas(DisasContext *s, MemOp ot)
>       tcg_gen_sub_tl(cpu_cc_dst, s->T0, s->T1);
>       set_cc_op(s, CC_OP_SUBB + ot);
>   
> -    gen_op_add_reg(s, s->aflag, R_EDI, gen_compute_Dshift(s, ot));
> +    gen_op_add_reg(s, s->aflag, R_EDI, dshift);
>   }
>   
> -static void gen_cmps(DisasContext *s, MemOp ot)
> +static void gen_cmps(DisasContext *s, MemOp ot, TCGv dshift)
>   {
> -    TCGv dshift;
> -
>       gen_string_movl_A0_EDI(s);
>       gen_op_ld_v(s, ot, s->T1, s->A0);
>       gen_string_movl_A0_ESI(s);
> @@ -1284,7 +1279,6 @@ static void gen_cmps(DisasContext *s, MemOp ot)
>       tcg_gen_sub_tl(cpu_cc_dst, s->T0, s->T1);
>       set_cc_op(s, CC_OP_SUBB + ot);
>   
> -    dshift = gen_compute_Dshift(s, ot);
>       gen_op_add_reg(s, s->aflag, R_ESI, dshift);
>       gen_op_add_reg(s, s->aflag, R_EDI, dshift);
>   }
> @@ -1303,7 +1297,7 @@ static void gen_bpt_io(DisasContext *s, TCGv_i32 t_port, int ot)
>       }
>   }
>   
> -static void gen_ins(DisasContext *s, MemOp ot)
> +static void gen_ins(DisasContext *s, MemOp ot, TCGv dshift)
>   {
>       gen_string_movl_A0_EDI(s);
>       /* Note: we must do this dummy write first to be restartable in
> @@ -1314,11 +1308,11 @@ static void gen_ins(DisasContext *s, MemOp ot)
>       tcg_gen_andi_i32(s->tmp2_i32, s->tmp2_i32, 0xffff);
>       gen_helper_in_func(ot, s->T0, s->tmp2_i32);
>       gen_op_st_v(s, ot, s->T0, s->A0);
> -    gen_op_add_reg(s, s->aflag, R_EDI, gen_compute_Dshift(s, ot));
> +    gen_op_add_reg(s, s->aflag, R_EDI, dshift);
>       gen_bpt_io(s, s->tmp2_i32, ot);
>   }
>   
> -static void gen_outs(DisasContext *s, MemOp ot)
> +static void gen_outs(DisasContext *s, MemOp ot, TCGv dshift)
>   {
>       gen_string_movl_A0_ESI(s);
>       gen_op_ld_v(s, ot, s->T0, s->A0);
> @@ -1327,14 +1321,14 @@ static void gen_outs(DisasContext *s, MemOp ot)
>       tcg_gen_andi_i32(s->tmp2_i32, s->tmp2_i32, 0xffff);
>       tcg_gen_trunc_tl_i32(s->tmp3_i32, s->T0);
>       gen_helper_out_func(ot, s->tmp2_i32, s->tmp3_i32);
> -    gen_op_add_reg(s, s->aflag, R_ESI, gen_compute_Dshift(s, ot));
> +    gen_op_add_reg(s, s->aflag, R_ESI, dshift);
>       gen_bpt_io(s, s->tmp2_i32, ot);
>   }
>   
>   #define REP_MAX 65535
>   
> -static void do_gen_rep(DisasContext *s, MemOp ot,
> -                       void (*fn)(DisasContext *s, MemOp ot),
> +static void do_gen_rep(DisasContext *s, MemOp ot, TCGv dshift,
> +                       void (*fn)(DisasContext *s, MemOp ot, TCGv dshift),
>                          bool is_repz_nz)
>   {
>       TCGLabel *last = gen_new_label();
> @@ -1399,7 +1393,7 @@ static void do_gen_rep(DisasContext *s, MemOp ot,
>       }
>   
>       gen_set_label(loop);
> -    fn(s, ot);
> +    fn(s, ot, dshift);
>       tcg_gen_mov_tl(cpu_regs[R_ECX], cx_next);
>       gen_update_cc_op(s);
>   
> @@ -1434,7 +1428,7 @@ static void do_gen_rep(DisasContext *s, MemOp ot,
>            */
>           gen_set_label(last);
>           set_cc_op(s, CC_OP_DYNAMIC);
> -        fn(s, ot);
> +        fn(s, ot, dshift);
>           tcg_gen_mov_tl(cpu_regs[R_ECX], cx_next);
>           gen_update_cc_op(s);
>       }
> @@ -1449,23 +1443,27 @@ static void do_gen_rep(DisasContext *s, MemOp ot,
>   }
>   
>   static void gen_repz(DisasContext *s, MemOp ot,
> -                     void (*fn)(DisasContext *s, MemOp ot))
> +                     void (*fn)(DisasContext *s, MemOp ot, TCGv dshift))
>   
>   {
> +    TCGv dshift = gen_compute_Dshift(s, ot);
> +
>       if (s->prefix & (PREFIX_REPZ | PREFIX_REPNZ)) {
> -        do_gen_rep(s, ot, fn, false);
> +        do_gen_rep(s, ot, dshift, fn, false);
>       } else {
> -        fn(s, ot);
> +        fn(s, ot, dshift);
>       }
>   }
>   
>   static void gen_repz_nz(DisasContext *s, MemOp ot,
> -                        void (*fn)(DisasContext *s, MemOp ot))
> +                        void (*fn)(DisasContext *s, MemOp ot, TCGv dshift))
>   {
> +    TCGv dshift = gen_compute_Dshift(s, ot);
> +
>       if (s->prefix & (PREFIX_REPZ | PREFIX_REPNZ)) {
> -        do_gen_rep(s, ot, fn, true);
> +        do_gen_rep(s, ot, dshift, fn, true);
>       } else {
> -        fn(s, ot);
> +        fn(s, ot, dshift);
>       }
>   }
>   

Still not a fan of the repetition.  I think this could easily be

static void do_gen_rep(DisasContext *s, MemOp ot,
                        void (*fn)(DisasContext *s, MemOp ot, TCGv dshift),
                        bool is_repz_nz)
{
     TCGv dshift = gen_compute_Dshift(s, ot);
     TCGLabel *last, *loop, *done;
     target_ulong cx_mask;
     TCGv cx_next;
     bool can_loop, had_rf;

     if (!(s->prefix & (REPZ | REPNZ))) {
         fn(s, ot, dshift);
         return;
     }

     done = gen_new_label();
     can_loop = ...
     everything else.
}

Or, if you prefer, use two functions gen_repz_nz{0,1}.


r~

