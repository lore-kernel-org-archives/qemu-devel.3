Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71576C0219B
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2025 10:47:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thnmY-0006tc-5J; Tue, 11 Feb 2025 05:46:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1thnmW-0006tD-GB
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 05:46:20 -0500
Received: from mail-yb1-xb34.google.com ([2607:f8b0:4864:20::b34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1thnmU-0005qC-Ks
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 05:46:20 -0500
Received: by mail-yb1-xb34.google.com with SMTP id
 3f1490d57ef6-e53a91756e5so4558285276.1
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2025 02:46:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739270777; x=1739875577; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6Jzg9kFrFcq2yhGW9QTyXyEEJq+TsTn3Vo6KGuO5uyQ=;
 b=rDVpNrEZCcOsXpWRc4Poqo75ajzWvDJnvwNQ2OOR0LD0BDuU6Xr76l7Q2zkzty5k6F
 Q26LBSoB0TEbrSOzeQndjErx3X7uBbnfFMBU2X2mkD9krpZN3HyVehK69qX0d7uZPDqH
 Cud4Ei5nXn0K6H+tDwxIGT9qY82G/RYNNQ0Ep9DpeYzulrfM2mXLobh/yPIwAOB7s+jZ
 YG1qf+GuJacoPkbm5xuHfwvmaD6zz+iBHQai8/5MGvfAJ1MX3m3boOXwlQGhFTfsDF3U
 7gPsFMylhw7rRvqZmSn4UU7bEgAa52Li3N6hGPycbmK8gm8L1KWJPees2Yshez4ZqhL9
 7BXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739270777; x=1739875577;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6Jzg9kFrFcq2yhGW9QTyXyEEJq+TsTn3Vo6KGuO5uyQ=;
 b=WjCVVrXV5KQO/GvoIFpvXnubZRe5Ou2UMqcc/tcn8OA4UobwSQVR9PLsDoJKZfwUX6
 8ou2DcN4QDNLl4a8zNh2Dez8CZe4T0wuitzR68CsrGtFINV9ErTNc4DfeCp8MyFw/FcH
 PQ0+3TZ7jdh6rJgd4pkOj0QK7UKUaU8VHCG/Oa0A2ItK5GNcEhZHiXGqb1RjOWrH0xaj
 oDwaj2+IJ9MdXc0IplBPSqiBCk5WySZmRPcWJd3FpB9u6h7HYr0DYMYMQUhNb0Xo46r5
 6ORsSOPuIvcL7OYPTRMa3R/WAMK9GSRt2r8gIG89x2TouB/3OM4uqp2e4VuDBk+YKd2r
 +NkQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVs6UMFnMCy6hKX+8qz51yp54Rxmy+2PPa6JdPMGqGxPvPm44Vuvtbcp4Kuq5Frq5hldxtMeU4IMi80@nongnu.org
X-Gm-Message-State: AOJu0Yxic++26pbCC/Nuz0FLCTxn2zos8EYOTOcZgzanuUcSOHvUel/8
 kDJPatLbTZH1epRSaGugS/EoZZTY4MrPmNp8CiI3dMQ3sm7jNu/gd2cMxaBNbWBEkZpZ5j7Tkjq
 cbVqqeisC6SnG1Y/k/hO7QwkFcZiIreAw8Ql2MQ==
X-Gm-Gg: ASbGncuSa5VXkfEOvRyerSyGVyDRGz5wvxjpFbVtv6SZf4l4ref6h4ynw+sdKJARhxL
 C+Xuy0qfvoEnfidkJMEg6DD54zkOixgRsOXhIIzUliY7boIQ48tpWrSSRhFuz2/shXTQF1K7tSg
 ==
X-Google-Smtp-Source: AGHT+IEGmS1Emwkj84o13tV5n6h2v7/6T4+ffzBmwy7LgKyOuHfoySzFS1GRd15vOsyMFY80aVCtEE0I5gt12GeaIuI=
X-Received: by 2002:a05:6902:15c7:b0:e5b:42c7:8f2b with SMTP id
 3f1490d57ef6-e5d93c7e67emr3687348276.2.1739270777168; Tue, 11 Feb 2025
 02:46:17 -0800 (PST)
MIME-Version: 1.0
References: <6866d6b6-24af-4743-8407-26ae2998dd21@gmail.com>
In-Reply-To: <6866d6b6-24af-4743-8407-26ae2998dd21@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 11 Feb 2025 10:46:04 +0000
X-Gm-Features: AWEUYZmXoXVHnHq9LPzS6lynLiO-kLDFUvuKwC-EKkQKjHyDnzJnvPPciByFwsM
Message-ID: <CAFEAcA9B40F21r9RgeDd7k09juy35k9QWewzgkmyNkYVK_K0-g@mail.gmail.com>
Subject: Re: ldrd implementation issue?
To: Stu Grossman <stu.grossman@gmail.com>
Cc: qemu-arm@nongnu.org, QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b34;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb34.google.com
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

(added qemu-devel to the cc list)

On Mon, 10 Feb 2025 at 17:26, Stu Grossman <stu.grossman@gmail.com> wrote:
>
> I've been getting SIGBUS cores with a bunch of user apps running under
> linux 5.15 and qemu-system-aarch64.  These happen to be 32 bit (T32?)
> programs.
>
> All of the cores point at the following instruction:
>
>         ldrd r2,r3,[r2]
>
> where r2 points at four bytes prior to the end of a page.  Eg: 0x10ffc.
>
> The bug appears to be that we get a page fault between the accesses for
> each word.  Prior to the fault, the first register is updated.  Later,
> after the fault is serviced, the instruction is restarted with the index
> register containing the word loaded prior to the fault, which is
> probably not the desired address, resulting in a coredump.
>
> So the conditions for the problem are:
>
>         - the index register must be one of the registers being loaded.
>         - the index register must point at a uint64_t that spans a page
>           boundary.
>
> I understand that the uint64_t spanning a page boundary may not be
> allowed by the arm 32 bit API.  However, the ldrd instruction definition
> allows for four byte alignment.

Yes, you're right; this is a longstanding bug in our LDRD implementation.
The Arm ARM defines in section G1.17.8.3 that if the execution of
an instruction generates a synhcronous Data Abort then the base
register should be restored to its original value if the aborted
instruction is a load and the list of registers to be loaded includes
the base register.

> Note that ldm may have similar issues if the index is one of the
> registers being loaded and the words cross a page boundary.

I believe in LDM we get this correct: in the do_ldm() function
we have a case for 'i == a->rn' which stashes the loaded value
into a TCG temporary, and we don't write that into the actual
register until after we've completed all the loads.

> The fix is to defer the register stores till after both words have been
> read from memory.
>
> Here is my fix:
>
> diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
> index 9ee761fc64..78ad0ed186 100644
> --- a/target/arm/tcg/translate.c
> +++ b/target/arm/tcg/translate.c
> @@ -5006,7 +5006,7 @@ static bool op_store_rr(DisasContext *s,
> arg_ldst_rr *a,
>   static bool trans_LDRD_rr(DisasContext *s, arg_ldst_rr *a)
>   {
>       int mem_idx = get_mem_index(s);
> -    TCGv_i32 addr, tmp;
> +    TCGv_i32 addr, tmp1, tmp2;
>
>       if (!ENABLE_ARCH_5TE) {
>           return false;
> @@ -5017,15 +5017,16 @@ static bool trans_LDRD_rr(DisasContext *s,
> arg_ldst_rr *a)
>       }
>       addr = op_addr_rr_pre(s, a);
>
> -    tmp = tcg_temp_new_i32();
> -    gen_aa32_ld_i32(s, tmp, addr, mem_idx, MO_UL | MO_ALIGN);
> -    store_reg(s, a->rt, tmp);
> +    tmp1 = tcg_temp_new_i32();
> +    gen_aa32_ld_i32(s, tmp1, addr, mem_idx, MO_UL | MO_ALIGN);
>
>       tcg_gen_addi_i32(addr, addr, 4);
>
> -    tmp = tcg_temp_new_i32();
> -    gen_aa32_ld_i32(s, tmp, addr, mem_idx, MO_UL | MO_ALIGN);
> -    store_reg(s, a->rt + 1, tmp);
> +    tmp2 = tcg_temp_new_i32();
> +    gen_aa32_ld_i32(s, tmp2, addr, mem_idx, MO_UL | MO_ALIGN);
> +
> +    store_reg(s, a->rt, tmp1);
> +    store_reg(s, a->rt + 1, tmp2);
>
>       /* LDRD w/ base writeback is undefined if the registers overlap.  */
>       op_addr_rr_post(s, a, addr, -4);
> @@ -5153,19 +5154,20 @@ static bool op_store_ri(DisasContext *s,
> arg_ldst_ri *a,
>   static bool op_ldrd_ri(DisasContext *s, arg_ldst_ri *a, int rt2)
>   {
>       int mem_idx = get_mem_index(s);
> -    TCGv_i32 addr, tmp;
> +    TCGv_i32 addr, tmp1, tmp2;
>
>       addr = op_addr_ri_pre(s, a);
>
> -    tmp = tcg_temp_new_i32();
> -    gen_aa32_ld_i32(s, tmp, addr, mem_idx, MO_UL | MO_ALIGN);
> -    store_reg(s, a->rt, tmp);
> +    tmp1 = tcg_temp_new_i32();
> +    gen_aa32_ld_i32(s, tmp1, addr, mem_idx, MO_UL | MO_ALIGN);
>
>       tcg_gen_addi_i32(addr, addr, 4);
>
> -    tmp = tcg_temp_new_i32();
> -    gen_aa32_ld_i32(s, tmp, addr, mem_idx, MO_UL | MO_ALIGN);
> -    store_reg(s, rt2, tmp);
> +    tmp2 = tcg_temp_new_i32();
> +    gen_aa32_ld_i32(s, tmp2, addr, mem_idx, MO_UL | MO_ALIGN);
> +
> +    store_reg(s, a->rt, tmp1);
> +    store_reg(s, rt2, tmp2);
>
>       /* LDRD w/ base writeback is undefined if the registers overlap.  */
>       op_addr_ri_post(s, a, addr, -4);

Yes, this fix looks correct to me. Can you provide a
Signed-off-by: tag for it? We can't accept it as a patch
without that. (I can do the other administrative tidying
up of it into a commit, but the signed-off-by is what says
you have the legal right and are happy to submit it to QEMU
under our license (LGPLv2.1+ in this case)).

thanks
-- PMM

