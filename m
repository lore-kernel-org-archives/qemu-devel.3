Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8D76CD4F54
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 19:47:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSggx-0006Cm-6C; Thu, 28 May 2026 15:46:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wSggv-0006Az-5c
 for qemu-devel@nongnu.org; Thu, 28 May 2026 15:46:53 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wSggt-0008IG-EO
 for qemu-devel@nongnu.org; Thu, 28 May 2026 15:46:52 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2bea7176c72so61221105ad.0
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 12:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779997608; x=1780602408; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MO6pZLrkwS2T38Jx0ATewcw29OZ9YKJyGY7pFBDNL+U=;
 b=vNnjLemLHdTvXGt0OCsKn6QxTz9D3IXyFI7Q53XRHgl6n6Zz6WZjvcLvWYHhbczchA
 EmIhrEh0tEQJgZj206ZwanIeYsScOplCz6LBBVtFVoovo7wCePieyh1prpR/JF1Cuhlq
 qiZstefGgyFe/0oe1i/fDSc8SUTrnJRcYnTLcuHZgKCjIOTDpGcGnQ44uEkA2fsPuX9P
 XdV6W+4/JaeLJKaoCbdMNj+a4GQwH+NaYoCEKkaqzVWf6BjTjxD7VHrTQu9TloCrWfam
 TImmbqjNEvIHYahKo5wjTEPyv7F5kVxa5/uNykXQFnfvRwU9HHf7gUq2eK70XxIn2icq
 V7Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779997608; x=1780602408;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MO6pZLrkwS2T38Jx0ATewcw29OZ9YKJyGY7pFBDNL+U=;
 b=CKMn20eQYvcprPk2BapO0FWiFn/bLSqmVzyXdxoIMLgIaiA8dVjgwdaR3igFzV2YVL
 VsmeAxeghYZdWKFTYUc175yG4cT0LCC/dFFn6BwRL9q3HcFH4WbFswq8Wt/aXwMYpJVM
 HIaZ7HEcxuuy2ViXKicrsa63E25LlcizbfIo+dihPV7IwDWGe7iOZjx7/ik6znVXJnRP
 LMziIAySYXwM1KTCEmT9oXyX85/q4Rv2MfMPaQ/AGNt5OMtDTswNPQB3rkDY9BcklJ/k
 MhJnQEbhMl5gI4pp/tnkwr0qkpOHPA7c4BvEwYBZVstETXHoksruAJW0z6edcmv5pZGn
 AeLw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9BAGsm+PriZJzEqldExZ3m9gxfioNAM2Mb5SdfXWQY8pxTMwGAPxgu8kQ+MWPmlxw1b863Ts1CO4gg@nongnu.org
X-Gm-Message-State: AOJu0Yzm1j4CXX7JlLg+EL0cySi0S+ETlLD2NVbYhnyua2IrkQLKmHav
 fkq1FozqPNk89jUcFTyl4IylCP7I7AMY7oBzrL0wIiT3TtORRfjFyjHsHHGzu815EOY=
X-Gm-Gg: Acq92OERBGwxGXYY5zGuzmNXgZDL137jjjhbrecA6O7gKuHjsH5S1OSBmeIAiinCgR5
 2sQ2T0u/vDyLXd8iGdG/PV1jU/IcGCS+QP1RErh99cEfTmLBXeHlBDWZw+i7RgaER70Mv6m0ttF
 UwzxsNxCb74qvRiQhjNSq95peIDVP9XZShh2Qfcpn8k9EQ2TypEM3H61JVWovjc9jjY9x9ufNse
 ng0Cg/uIBQ24H1CMTJ4RksH8WkBTTr9Xu7glZUCCTcoBMCJl4IBp3unOFlx/k2MHGX+UwYSlXqD
 aR7FRSsm3qmyBfF23wTYbndfi+Xreq3WXYxZ4iBChP6FwQAZwLhR0+AF8ykAqkd/c0Xcy+EkaxK
 xmp768GXT/NfEKhNGdJ+FvlsEHpXw1AdSFHMvSMmDvGP9HZh5fZ/KxzoNi+fm2N40HhCPn4oO5N
 7fNCtc04agZvbUHJCvmN1T2bK32tnCOJ4mt8AOky4h6d6sU30=
X-Received: by 2002:a17:903:2405:b0:2bc:dc0b:ab1a with SMTP id
 d9443c01a7336-2bf1ed46a14mr2240805ad.35.1779997607649; 
 Thu, 28 May 2026 12:46:47 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.142.33])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2bf1e7fd976sm1000795ad.59.2026.05.28.12.46.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 May 2026 12:46:47 -0700 (PDT)
Message-ID: <0857b250-336b-4945-ae5e-6a617216f17b@linaro.org>
Date: Thu, 28 May 2026 12:46:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/i386: apply mod to immediate count of an RCL/RCR
 operation
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Abhigyan Kumar <314abh@gmail.com>, philmd@linaro.org
References: <20260528164600.868982-1-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260528164600.868982-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 5/28/26 09:46, Paolo Bonzini wrote:
> RCR and RCL instructions with a count of 9 are the same as if the
> count was 0, but they generated incorrect code because the can_be_zero
> flag is false.  This causes 0 to underflow into -1 at
> tcg_gen_subi_tl(count, count, 1).
> 
> Fix by absorbind the call to gen_shift_count() into gen_rotc_mod(),
> so that the new function handles both mask and mod.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3452
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   target/i386/tcg/emit.c.inc | 85 +++++++++++++++++++++++---------------
>   1 file changed, 52 insertions(+), 33 deletions(-)
> 
> diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
> index ce636b6c56c..c6b0be1f60d 100644
> --- a/target/i386/tcg/emit.c.inc
> +++ b/target/i386/tcg/emit.c.inc
> @@ -3244,12 +3244,10 @@ static void gen_PUSHF(DisasContext *s, X86DecodedInsn *decode)
>       assume_cc_op(s, CC_OP_EFLAGS);
>   }
>   
> -static MemOp gen_shift_count(DisasContext *s, X86DecodedInsn *decode,
> -                             bool *can_be_zero, TCGv *count, int unit)
> +static void gen_shift_count_1(DisasContext *s, X86DecodedInsn *decode,
> +                              bool *can_be_zero, TCGv *count, int unit,
> +                              int mask)
>   {
> -    MemOp ot = decode->op[0].ot;
> -    int mask = (ot <= MO_32 ? 0x1f : 0x3f);
> -
>       *can_be_zero = false;
>       switch (unit) {
>       case X86_OP_INT:
> @@ -3259,12 +3257,17 @@ static MemOp gen_shift_count(DisasContext *s, X86DecodedInsn *decode,
>           break;
>   
>       case X86_OP_IMM:
> -        if ((decode->immediate & mask) == 0) {
> +        /*
> +         * The caller applied the mask (this is awkward; unfortunately the
> +         * mask must be applied *before* the modulo operation for RCL/RCR,
> +         * and the modulo operation must be before this check for zero).
> +         */
> +        if (decode->immediate == 0) {

Perhaps clearer to pass down mod and perform all of the arithmetic in here.

> +static MemOp gen_shift_count(DisasContext *s, X86DecodedInsn *decode,
> +                             bool *can_be_zero, TCGv *count, int unit)
> +{
> +    MemOp ot = decode->op[0].ot;
> +    int mask = (ot <= MO_32 ? 0x1f : 0x3f);
> +
> +    if (unit == X86_OP_IMM) {
> +        decode->immediate &= mask;
> +    }
> +
> +    gen_shift_count_1(s, decode, can_be_zero, count, unit, mask);

Here you could pass mod = 64, arbitrarily large, so that we could keep the mask 
computation common within gen_shift_count_1.

> -static void gen_rotc_mod(MemOp ot, TCGv count)
> +static MemOp gen_rotc_count(DisasContext *s, X86DecodedInsn *decode,
> +                            bool *can_be_zero, TCGv *count, int unit)
>   {
>       TCGv temp;
> +    MemOp ot = decode->op[0].ot;
> +    int mod = (8 << ot) + 1;
> +    int mask = (ot <= MO_32 ? 0x1f : 0x3f);
>   
> -    switch (ot) {
> -    case MO_8:
> -        temp = tcg_temp_new();
> -        tcg_gen_subi_tl(temp, count, 18);
> -        tcg_gen_movcond_tl(TCG_COND_GE, count, temp, tcg_constant_tl(0), temp, count);
> -        tcg_gen_subi_tl(temp, count, 9);
> -        tcg_gen_movcond_tl(TCG_COND_GE, count, temp, tcg_constant_tl(0), temp, count);
> -        break;
> -
> -    case MO_16:
> -        temp = tcg_temp_new();
> -        tcg_gen_subi_tl(temp, count, 17);
> -        tcg_gen_movcond_tl(TCG_COND_GE, count, temp, tcg_constant_tl(0), temp, count);
> -        break;
> -
> -    default:
> -        break;
> +    /*
> +     * RCx operations are invariant modulo 8*operand_size+1.  For 8 and 16-bit
> +     * operands, this is less than 0x1f (the mask applied by gen_shift_count)
> +     * so reduce further.  Failure to do so results in incorrect shifts
> +     * in gen_RCL/gen_RCR.
> +     */
> +    if (unit == X86_OP_IMM) {
> +        decode->immediate &= mask;
> +        decode->immediate %= mod;
>       }
> +
> +    gen_shift_count_1(s, decode, can_be_zero, count, unit, mask);
> +
> +    if (unit == X86_OP_INT && mod < mask) {

And it would avoid having to have code split across these two functions in odd ways, and 
reusing the switch within gen_shift_count_1.

> +        temp = tcg_temp_new();
> +        if (mod * 2 < mask) {
> +            tcg_gen_subi_tl(temp, *count, mod * 2);
> +            tcg_gen_movcond_tl(TCG_COND_GE, *count, temp, tcg_constant_tl(0), temp, *count);
> +        }
> +        tcg_gen_subi_tl(temp, *count, mod);
> +        tcg_gen_movcond_tl(TCG_COND_GE, *count, temp, tcg_constant_tl(0), temp, *count);
> +    }

Perhaps worth assert(mask < mod * 4), for documentation's sake?


r~

