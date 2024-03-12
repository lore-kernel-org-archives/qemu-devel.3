Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8079C54E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 14:30:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk393-00089y-NG; Tue, 12 Mar 2024 10:30:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rk390-00088b-W8
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 10:30:19 -0400
Received: from mail-lj1-x22c.google.com ([2a00:1450:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rk38y-0005jd-DO
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 10:30:18 -0400
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-2d24a727f78so53151fa.0
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 07:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710253810; x=1710858610; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=JG/YXMoKnwQo01L5oBgZCUH9wQP+hUMZv1HkcjW5hIc=;
 b=tSiza8TfHb+sdAeqW3/x3CK/ihlfyEkxPiCM1PMetIcUYYu6sd7s4tcCZqDw3lKt1v
 +5fOLepwRkaLRrJTRn+x80eV7MZ23Gkt/ViBLQbzifP+pDH226ULubpSsQ1+ClUISU3I
 jc64qWBcfl8+vl3OEi0T/12kv+g7hBmCds9mxwJ4XAH3GY7J7/M1NeZhJ5Sv//BC0gB7
 i9WgheYAlyqF31M8ny2Whdji8NPegDFKrnVLDAGAPnWD0KtRorpz2DTjfS8CTWJgXLAB
 kpvGhECfrgzno9+jbaJPp0RyY6Mxyo4de2I5kT4X8ml19kJyUACcKimgT2uCQpzzxeIT
 svyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710253810; x=1710858610;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JG/YXMoKnwQo01L5oBgZCUH9wQP+hUMZv1HkcjW5hIc=;
 b=UAC9uUGzx1et6ax+mrZ0uRyWIW5LyfAGo4VxLbj+jwwPMZVwAI4DcNz1FTFyZoIhPQ
 Mm5eSEWzkq95Frrq0eXSqP1KhcHdHDy5MJmGBHI+gREoSTVKds4P4NAv7LT6wFICrlOv
 gD2D+6KzL5cs8/w0+hOS3217/KZL380Q9GHUHLs2veFueSl9D8wgK9R/iER4ksveWcBf
 +kLrj9dAC0U2aDYS/idszSCE9XNanYRXFdml9xAJWdD8DPzzwKjy6WPBy54RylxdlOZT
 4BNwHNcClVsyXOg7uqH71mhelp241wCk7cfBc7jQgnBvPb0IAxHFzr3Mh6mx+qu401S3
 G5KA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUTKRYmZhAlKV50D2FlqQF0xiECIvArgt0OZl1Qk19Gk2Ds6DZiCvdShkPWXj4mN94eaJhFFUpVVeY6UlB9SuRPQX7oLQQ=
X-Gm-Message-State: AOJu0YxeqhIEhWQuwAEgZuBbkUfVV0NZWUdlDhMxkeX9k9uSFfYu2wJ3
 ocjiOY15vWspd3s1Q+L8cIaINulA9G/5La7pHSrDo0z47cKU1X6Dn03AQIK6sz+R/MqJX6+Jb5j
 +ubsNQ9NvQOIccnWJGjs1cmJxtLR3ns9GJ/IOXQ==
X-Google-Smtp-Source: AGHT+IHHTcNb5kbXcaVd6mYKV3nySbPdwwaM+cWfZWMSuObGdEtOHREi9NugEnIPPwbSV0VyRIU2t8v7xO+pWksMjLk=
X-Received: by 2002:a2e:9256:0:b0:2d4:49f5:1c29 with SMTP id
 v22-20020a2e9256000000b002d449f51c29mr2635903ljg.25.1710253810448; Tue, 12
 Mar 2024 07:30:10 -0700 (PDT)
MIME-Version: 1.0
References: <20240307110318.170319-1-rathc@linux.ibm.com>
 <CZRO4Y67CBPV.2IAKB80EFDKEY@wheely>
 <0c7c6be1-12fb-4267-9d41-bd51637d104a@linaro.org>
 <CZRU903MDUJ1.6S9RSO5A4RDG@wheely>
In-Reply-To: <CZRU903MDUJ1.6S9RSO5A4RDG@wheely>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 12 Mar 2024 14:29:59 +0000
Message-ID: <CAFEAcA8im7S-bsx-hYqgUy4tsc8yXjWQf7Sb-=KnuREyqqC8mw@mail.gmail.com>
Subject: Re: [PATCH] target/ppc: Move floating-point arithmetic instructions
 to decodetree.
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Chinmay Rath <rathc@linux.ibm.com>, 
 qemu-ppc@nongnu.org, qemu-devel@nongnu.org, danielhb413@gmail.com, 
 clg@kaod.org, harshpb@linux.ibm.com, sbhat@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::22c;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x22c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, 12 Mar 2024 at 14:25, Nicholas Piggin <npiggin@gmail.com> wrote:
>
> On Wed Mar 13, 2024 at 12:01 AM AEST, Richard Henderson wrote:
> > On 3/11/24 23:36, Nicholas Piggin wrote:
>
> [snip]
>
> > >
> > > #define FPU_HELPER(name, op, flags_handler)                           \
> > > float64 helper_##name(CPUPPCState *env, float64 arg1, float64 arg2)   \
> > > {                                                                     \
> > >      float64 ret = op(arg1, arg2, &env->fp_status);                    \
> > >      int flags = get_float_exception_flags(&env->fp_status);           \
> > >      flags_handler(env, flags)                                         \
> > >      return ret;                                                       \
> > > }
> > >
> > > static inline void addsub_flags_handler(CPUPPCState *env, int flags)
> > > {
> > >      if (unlikely(flags & float_flag_invalid)) {
> > >          float_invalid_op_addsub(env, flags, 1, GETPC());
> > >      }
> > > }
> > >
> > > static inline void mul_flags_handler(CPUPPCState *env, int flags)
> > > {
> > >      if (unlikely(flags & float_flag_invalid)) {
> > >          float_invalid_op_mul(env, flags, 1, GETPC());
> > >      }
> > > }
> > >
> > > static inline void div_flags_handler(CPUPPCState *env, int flags)
> > > {
> > >      if (unlikely(flags & float_flag_invalid)) {
> > >          float_invalid_op_div(env, flags, 1, GETPC());
> > >      }
> > >      if (unlikely(flags & float_flag_divbyzero)) {
> > >          float_zero_divide_excp(env, GETPC());
> > >      }
> > > }
> >
> > Beware -- GETPC() may only be called from the outermost helper.
>
> Ah, because it's using __builtin_return_address. Good to know.
> Using always_inline and a comment should do the trick then.

The standard way to fix this is that you call GETPC() at the
outermost helper and then pass that value around as an extra
uintptr_t ra argument to called functions that need it.

thanks
-- PMM

