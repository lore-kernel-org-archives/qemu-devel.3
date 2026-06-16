Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6693CD98E1
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 14:52:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZV8o-0004Wh-78; Tue, 16 Jun 2026 10:51:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZV8l-0004WO-2R
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 10:51:47 -0400
Received: from mail-yx1-xb135.google.com ([2607:f8b0:4864:20::b135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZV8i-0006jN-Vd
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 10:51:46 -0400
Received: by mail-yx1-xb135.google.com with SMTP id
 956f58d0204a3-66067da0638so2451705d50.0
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 07:51:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781621502; cv=none;
 d=google.com; s=arc-20240605;
 b=AuLTXzKj3dK4TztV7UCiDDh3yVTLChLEvYa4tty1a//1mBbBJaaCLlM9MX1JoXN/WN
 J9endM4fNDhn2kd9z7kQ31O/ysSQ/q6ZCi7MLS7N+VjSlpfZmRRkXdYalF/wGo/d4hZZ
 zWpviWOlrCD/VjIHn6KPkbIErKksbmfkum/Jh7olHnPfCeBZJuEot70BTr4GUwT9kxUW
 UUJ9UcU3xQFCywFkzjDPHHkUtL/HHRnVNhUoRr6qRamIUWjrTPgI4dP+IeppI90DV0IX
 A6qEt2SZGJLjsG5udpBPoggvGV+h6MF8I8ZVmI+o3DGrYLuefbugnk+1HzAjUibos+DA
 +o8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=VSX1HRHle/avCp1jehNCQxn3fzJYzZGZcPx0Ur1AmDc=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=jjH7Q1UNVnbvExDSYaF9CeZSxuaHR1sOrqkZ22dCZNJzPQ417MHG50p8SiDj5Jt2S+
 OcxJiP4VNDylerRmmSMpjZ/X6LULnbfpzkuWyGP8EMq3JET/0lyt0YQPu/KJuPkGbPgj
 Yd6jRC1PX8IAgtoTl/SPgqgzbjaRXK5TGaeu9jyZWsGdXAUgLi3mc24id/sSGko2paf9
 J9MDCkhwIieOJkTS0z3KSjkt76swFJ1JkWr4qIyiIj5qmt34i5PznOaEA4B8ieqqmP7r
 6dt3eYMPTPNikBVgIhggtEJVwzVvaT3I2+7hNc2JqNkCUG4ZGuRRswwopNg8GWongoRK
 SPFQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781621502; x=1782226302; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=VSX1HRHle/avCp1jehNCQxn3fzJYzZGZcPx0Ur1AmDc=;
 b=cw3grTv3M2nb5L8vgpaqsHIoG8bnqw7YyYHLPW3wPA3Rh2j6mwk25y4Vmz6mkdM3Xv
 ZGR+2io7iaNWWDFJ8f0zAr5tHetot/N/SNlnBeTVQKY5+JrnvYCYfxnzgQCnMB85AAYq
 y3/DbWl9s79CryO1krYgtgUX484/4Au0/xULrLTsJ0fV0oAUKIeqHZjiZhenmuoU5ctB
 PBJ12e/DCNag+Fy+jZxs1SAQZNs+hM5526Q6YVlmNSb1vd7Om6C656A97JTah0JgNATL
 85OwKdyxAsYMDe2aS87l/wnAw+dCzdFu/hpddcBy7DkESRrDPvpokb6qDvRQPDHqHcy6
 dqwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781621502; x=1782226302;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VSX1HRHle/avCp1jehNCQxn3fzJYzZGZcPx0Ur1AmDc=;
 b=ADfw35QqP62+nRVJOm7r8rMk87Y5aMhBenWzoQ3iqd6f/xdbVCUEgaatBfh5/PqH22
 z1Nqo7JkskUeN87r/RnkvhrhMs90REJbGKI/zSgMslje2Y1/yBoSlY0ZYWUbL2jYNL9G
 S8zj6RjjIHI5hFIfmsONsSVLpFQTP0UT64NL2HWDnBP+4NQeM9Re6JV1NASlkpVD7uUo
 TgaymGZON0VybnEIBUYSBSAvuoOFfoHTXphhn22Q0XaATIZHzTknG8q7zrwhKvqEvhEs
 3ev/i+gmC1NYp+Gz+BzoLiI/NARIQZIF2ztyYhwwehFphW6EeraBolOqmwWTGpf1JpZx
 reFg==
X-Gm-Message-State: AOJu0Yz+75xFlQACQvBAJq5T9e0jCa2zdJxBWBH/Tx4hDa96gGDaaiOT
 iXB1D5zUGiesIix92ILztqUtiy96dTgrKSai6p43C+Cn8NchW8v+ZfGXKhBop7CPIH0r71PYuSV
 GD/kAKdJ7iDU/Z1SP6ev7Y+OAo5f4AcwArwDb3rXVAg==
X-Gm-Gg: Acq92OHet6XKk3ALxvTWLgi0uVljdeOvsyH2CWf1Igkca0arsZDcIlFiiy8zfEDUlCU
 p45UMGB6tUOgRmrZRk0jKGycgtBawzHGX3jtsD4+gTZy3PXXHRWYPy4n0qBRVzFcXr2y5BS7ICx
 qKGFFc/WGKxUbIfkPw8p3tLgdicCU8ltRVPxlHtCOHuc34RDfDudaW+DPFVf5lRdpPOyZBzqXA6
 XL07dcxABW4t0UZwrZzDHzRmB4ASmaqknzf1w5ZCpeo/E2b2GUYs+mwvCVR5QKznTpBpGlXL47W
 oNVV/nZ3eQggrBer7CjFpWFjPyE9m1E1lcKd834V+J4okkeH9dbxjVbd8F/GjJHNC6E=
X-Received: by 2002:a05:690e:4384:b0:660:6441:d041 with SMTP id
 956f58d0204a3-662850c23camr11461140d50.39.1781621501960; Tue, 16 Jun 2026
 07:51:41 -0700 (PDT)
MIME-Version: 1.0
References: <20260604234852.573178-1-richard.henderson@linaro.org>
 <20260604234852.573178-25-richard.henderson@linaro.org>
In-Reply-To: <20260604234852.573178-25-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Jun 2026 15:51:30 +0100
X-Gm-Features: AVVi8Cf0JIJvSbrcKV0ZemvnSq0VbYHiCUaiEVOog7oOQbJPebQuS3BH9TCWd2c
Message-ID: <CAFEAcA-0VgXH7bZgbc730ZgHZ02ZR-jm300izcPDabgBCHAY=A@mail.gmail.com>
Subject: Re: [PATCH 24/25] target/arm: Implement FEAT_SSVE_AES
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b135;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb135.google.com
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

On Fri, 5 Jun 2026 at 00:53, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Enable FEAT_SVE_AES instructions in streaming mode.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/cpu-features.h      |  5 +++++
>  linux-user/aarch64/elfload.c   |  1 +
>  target/arm/tcg/cpu64.c         |  1 +
>  target/arm/tcg/translate-sve.c | 20 +++++++++++---------
>  docs/system/arm/emulation.rst  |  1 +
>  5 files changed, 19 insertions(+), 9 deletions(-)

As far as this patch goes,
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

but I was briefly confused by something in our pre-existing code for
these insns:

> @@ -8174,15 +8174,17 @@ TRANS_FEAT(SDOT_zzzz_2s, aa64_sme2_or_sve2p1, gen_gvec_ool_arg_zzzz,
>  TRANS_FEAT(UDOT_zzzz_2s, aa64_sme2_or_sve2p1, gen_gvec_ool_arg_zzzz,
>             gen_helper_gvec_udot_2h, a, 0)
>
> -TRANS_FEAT_NONSTREAMING(AESMC, aa64_sve2_aes, gen_gvec_ool_zz,
> -                        gen_helper_crypto_aesmc, a->rd, a->rd, 0)
> -TRANS_FEAT_NONSTREAMING(AESIMC, aa64_sve2_aes, gen_gvec_ool_zz,
> -                        gen_helper_crypto_aesimc, a->rd, a->rd, 0)

We mark all of these as aa64_sve2_aes(), which we define as
    return FIELD_EX64_IDREG(id, ID_AA64ZFR0, AES) != 0;

But the Arm ARM calls the feature defined by AES >= 0 "FEAT_SVE_AES",
not "FEAT_SVE2_AES". I think this is because we implemented this
before the Arm ARM split out separate official feature names for
the sub-parts of SVE2, and we happened to choose something that
is almost but not quite the same as the official one.
(cf commit bc980d66308 adding the extra names to the docs).
The name we have has slight potential to confuse, because there
is also a FEAT_SVE_AES2 (for AES >= 3), which we don't implement yet.

Do you think it's worth updating our feature function names to
match the official architecture names, or shall we just leave it be?

-- PMM

