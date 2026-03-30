Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFABD1061B0F
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2026 15:40:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7EjA-0005LS-5D; Mon, 30 Mar 2026 11:40:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w7Ej8-0005LA-GC
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 11:40:30 -0400
Received: from mail-yx1-xb131.google.com ([2607:f8b0:4864:20::b131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w7Ej7-0006xh-2H
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 11:40:30 -0400
Received: by mail-yx1-xb131.google.com with SMTP id
 956f58d0204a3-64edf260b49so9702240d50.0
 for <qemu-devel@nongnu.org>; Mon, 30 Mar 2026 08:40:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774885227; cv=none;
 d=google.com; s=arc-20240605;
 b=PeZS8jOJmLlA9jVkfS3UAIOCuCLOcwN12u15sx9QJFEgkpmWvGT1cAUOyD6o1Yh2EM
 7R4KO1k5t8ywhaT6kMgUlQSwHlf1MtCm8MNupgtWM1vB/8C5HWJLpsmest+kHjF2vFeU
 SGn3SEYsSwfil5FyXV3eG+pSwYmWHIH6nUX02Gx7nkXVlpUbq5Qsm+JzhHmqeDGZh0Pw
 9+fI4FrGlMij51Y8ytTO/LqR+D5U17CEN+Y6bBf4My/V9jPFjhyX/WdiPCCr2VBn1l7W
 p7S/HHdPOJ+1fcKsDpfbIWOxZadg/A3IeVHHznM9/wAvkWclYhDtlEdklAT3KiW4vlFV
 jBZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=gwMoNYx7XqCupf0wgFywTAemi/u52uuO8DtCFotpwj4=;
 fh=j0m/KHqzOQ6CKKktQSBLLiVo/M7SZnjHIyl4bugXt+Y=;
 b=Om2f4lKTv8Cm00M6yZ/1I/04zx1xBhxfFfEd079XbtR/cYRo23TNphm2CCLaCsCLzC
 WUmqtnLYtxGtBrFzMfxKgcbykQNOIaTgVAYCxsMsyB4O3XzhnWcMPIl2I7K/YkA8vG36
 h93f6UyNgczXmNrgcgNxiEWWIHv8UFefspNfROGsxrzap3i7zq0m559OCliOAedkoWGD
 Eyj40G07++Ky4gIW4D1EN0qb2RuJLaGZc1SpVd7m7o7W5TN6NnWMxFq9QLcnAAoNuCBm
 0nO9RifzTaO7AiR3ruDFaV8ifMdYVw7ukztg4i9fxOIpQyNMQ41u54HYZ488VyHxZXJc
 byFw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774885227; x=1775490027; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=gwMoNYx7XqCupf0wgFywTAemi/u52uuO8DtCFotpwj4=;
 b=sjgpvWaa/D96cm21JNYg1yLlrSDJW/PuD9jL3OEZi2rOD/A9IxVQKkFJSdg3iUSBa+
 YIW9aTqj3xNc38sJKgyAnPAoM0tRf4PA5/IWiW0Jxj9A4cVMdQoVKeAqobAwFN4eH2VV
 y/HFMahQE8wisiZKBAPuF5bCNljtbNmx6VIuD/Wv7hVBKwJEdJZtfsq3PdVsXB6cuIsY
 fVPhK+f7ee13thtydY4lrYLYi2sFGnyl1GIi1qnU28ZlLwSCdbTozugf7JAfNRr4brRW
 8jVUWvrF+q+Hl8FaSHBSmEDCkfV1Dzgfw/9dvKtsDCiZ4j7CisptrrJIzMMPcT/JWfP9
 smYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774885227; x=1775490027;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gwMoNYx7XqCupf0wgFywTAemi/u52uuO8DtCFotpwj4=;
 b=h2vdrfeqbLHYOxaPoymzjlDfjuc5oBGPJooQ7XwJ6csVFzF4Ydo9Y8wOS7BIJasCET
 jHgn1Wm3Stah3Pvcb8JQXhf30I9AEeSnSSy1OmWOeYmLUbxERUoo/vUu92Z5Fjq8FMRE
 CkAvsWPGTKSZDyEuNhk5es+r+OshisNIy/9iXo7gWYp8IfeRc2397pjDcbU8fc+GZJ4t
 05iTM2+Ldv9iTwvPfbjz6YHBQuV0Fwi9QpPTQ2g98TghzSH7H7cN9K0c/Zl/GAroXGkG
 XW/KFuY+l+YMQRxYPQ2/NUud1S0nsVC6YDU+NUN8k0O3+VulfuDzgA9U2vKERvX/l+yk
 Xxzw==
X-Gm-Message-State: AOJu0YwHjhSpLXCqodhvAFjBJJmA3Q6gZAhIPVvsgXOkD45e/0Rr09LH
 LGts1eiGKwcR4B5EbX5LfSoxG91Wl8GBasnXU28qSGACcXhAqpjxsztTHB6GNGKd8905K2RBqlY
 X/3ArpI5aWjzpdNJcrAh0u53vTG8HtYgc+j5Sgf4Ijg==
X-Gm-Gg: ATEYQzxRGBzJK9g4aKNdA3lyRvyrX4ScWEtnebfGS86WTpjK0yeF/jYGILJUGE8RTKs
 OE1s3BE9MWBALeVCtfI47UBoMZZbYSkKsLzLmAZztUPCD7NKeHQ7QNLt30IexQND78sIakmwg1S
 oddCdgLfENeUkwOxLhn74zjVR1HiYMMsJrg1NyLQLuRFHVOV4mC5GYCig+bme9A9Pqg/T6aIHkY
 XF4YOyXdu2thExZDPVvpc3i1cd01vBdJAxsR3TfMYDvDWbkJId+bbAOuMuc9emgzcjb9DRqzWKM
 prGCxo9w5JXhOJ3FcG4XGTniWFp9Py7Nvob5OeQuuVMoY+xyJz/A9PzdbzNjXnYRSiJtMpJs8OR
 ncw==
X-Received: by 2002:a53:ac82:0:b0:650:1ac4:85fe with SMTP id
 956f58d0204a3-6501ac48718mr3747472d50.30.1774885227397; Mon, 30 Mar 2026
 08:40:27 -0700 (PDT)
MIME-Version: 1.0
References: <20260321135624.581398-1-npiggin@gmail.com>
 <20260321135624.581398-2-npiggin@gmail.com>
In-Reply-To: <20260321135624.581398-2-npiggin@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 30 Mar 2026 16:40:15 +0100
X-Gm-Features: AQROBzAfyXEy6fXUZKP3Ys0sKkKYK6w2WJiQq4sBx3EKr3LH6WFoEraDA1OV6W4
Message-ID: <CAFEAcA8bZq6L658mS1_=YaW2iKu+uzBCK6cLx=+t2vgXazgOBg@mail.gmail.com>
Subject: Re: [PATCH 1/3] linux-user: sigaltstack lock_user_struct missing
 unlock
To: Nicholas Piggin <npiggin@gmail.com>
Cc: qemu-devel@nongnu.org, Warner Losh <imp@bsdimp.com>,
 Kyle Evans <kevans@freebsd.org>, Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b131;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb131.google.com
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

On Sat, 21 Mar 2026 at 13:56, Nicholas Piggin <npiggin@gmail.com> wrote:
>
> lock_user_struct is missing a corresponding unlock.
>
> (bsd-user does correctly unlock in the equivalent code.)
>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---


> @@ -1140,11 +1135,17 @@ abi_long do_sigaltstack(abi_ulong uss_addr, abi_ulong uoss_addr,
>
>      if (uss_addr) {
>          target_stack_t *uss;
> +        target_stack_t ss;
>
>          if (!lock_user_struct(VERIFY_READ, uss, uss_addr, 1)) {
>              goto out;
>          }
> -        ret = target_restore_altstack(uss, env);
> +        __get_user(ss.ss_sp, &uss->ss_sp);
> +        __get_user(ss.ss_size, &uss->ss_size);
> +        __get_user(ss.ss_flags, &uss->ss_flags);
> +        unlock_user_struct(uss, uss_addr, 0);
> +
> +        ret = target_restore_altstack(&ss, env);

Why do we need to change to copying the entries out of the
stack here? Does something not work if we do the
unlock_user_struct() after the call to
target_restore_sigaltstack() ?

>          if (ret) {
>              goto out;
>          }

thanks
-- PMM

