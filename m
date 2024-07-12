Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53518C3DA4B
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2024 13:03:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sSFvN-000412-RW; Fri, 12 Jul 2024 09:02:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sSFvG-0003Xo-Ri
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 09:02:55 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sSFvD-0005zh-Q1
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 09:02:50 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-57d05e0017aso2672233a12.1
 for <qemu-devel@nongnu.org>; Fri, 12 Jul 2024 06:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720789366; x=1721394166; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vCFtf2iNIwx1IjbaReYl7YdD1FU8YkHtI7PLgSEDdsY=;
 b=ZjnyPUBd8QN4RpsNNH4u2apbW5o895NKQ75vzGo+64EWcYEkgF8iyFshr9ze4Vbtqj
 ul+Ws0K1EO6PjGWc38eLQ4ubkJu/PR0KBW0lOZVOqtW5oWIzNk2rIrpyeONRTJ64MxgZ
 biT3yqZl77pe1vJs8Aeb1PTTJXXELOpsK05ffG33dc0BCI5D/LvkrZRUIf7WAnJDKZ0n
 AhAvDjLZdgJFFG29nKQS+k4H8NJ17IJYHipLNOFYJmiAO8rfSs+lAmp5U24PWKZZLrg+
 RWRd9cS8SqzBdk+6Ogs+mNKrAVniR/nsYj9Yy5D0O/fV2kA9e2SzOOoLo/NQWYPzQ+Cx
 hMNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720789366; x=1721394166;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vCFtf2iNIwx1IjbaReYl7YdD1FU8YkHtI7PLgSEDdsY=;
 b=mUXSVNxyagBVag9yrU/D5SuQ4ldsvmMl11PJqS/xV4qoFik6S9+Wfcmbb8Av3/KbkG
 wJDQRU2frZwBcfF9TrjgP8xQCgvfcxWvmmZGr33KIIche3Sr5zYOVO9bJlHNG1ieP4XH
 7lfbLHGKhB88MgAA2LMdYw7s8GzmNSp2eJabsWWRrBG39gGg9kLhnWTA1KyvY57C3J0m
 ofufIViqwnLTPswu1YwwkZPY/j/M3Uv+u3EJNtaz9zzlPvXrBXP03oetrpqPeGVfEyPZ
 0VJlX6lQV3ZHQ6YFPjbboQSijmrFYkJOomX6Z61ire0swjouIUHxoKyWktYTW9vvzGfv
 prcw==
X-Gm-Message-State: AOJu0Yx+vfYEvlrLEI64TOW/5cXb3iyF6bHb0FAvARgedFQcC/R3/g1+
 Xocc+vqWVFnfmFpEufAopLZUAkaHl670Na7CnpsbWIA5ykm0ytzJTfA+HZ4aUdCDFLadRgwWwtM
 A38bdK/ONtJ42NV9QE+szMYB9Nvu2aYOfATP4Xw==
X-Google-Smtp-Source: AGHT+IHwECMS0FU7KFn0nd3zulANuUA5a+LSbh6K/GFQZiHhrr8kIsik3feXMXPjEltauh3sU7HKWsePlHlVquyRtHc=
X-Received: by 2002:a05:6402:1911:b0:57c:5b7a:87e7 with SMTP id
 4fb4d7f45d1cf-594ba0cbecemr9114374a12.14.1720789366145; Fri, 12 Jul 2024
 06:02:46 -0700 (PDT)
MIME-Version: 1.0
References: <20240710032814.104643-1-richard.henderson@linaro.org>
 <20240710032814.104643-11-richard.henderson@linaro.org>
In-Reply-To: <20240710032814.104643-11-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 12 Jul 2024 14:02:35 +0100
Message-ID: <CAFEAcA9O+3W=2EewSUDoFOF322G5UUAW5xD+wWasW19F5pO6NQ@mail.gmail.com>
Subject: Re: [PATCH v2 10/13] target/s390x: Use user_or_likely in
 do_access_memset
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-s390x@nongnu.org, 
 qemu-riscv@nongnu.org, balaton@eik.bme.hu, max.chou@sifive.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Wed, 10 Jul 2024 at 04:28, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Eliminate the ifdef by using a predicate that is
> always true with CONFIG_USER_ONLY.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/s390x/tcg/mem_helper.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
>
> diff --git a/target/s390x/tcg/mem_helper.c b/target/s390x/tcg/mem_helper.c
> index 6cdbc34178..5311a15a09 100644
> --- a/target/s390x/tcg/mem_helper.c
> +++ b/target/s390x/tcg/mem_helper.c
> @@ -225,10 +225,7 @@ static void do_access_memset(CPUS390XState *env, vaddr vaddr, char *haddr,
>                               uint8_t byte, uint16_t size, int mmu_idx,
>                               uintptr_t ra)
>  {
> -#ifdef CONFIG_USER_ONLY
> -    memset(haddr, byte, size);
> -#else
> -    if (likely(haddr)) {
> +    if (user_or_likely(haddr)) {
>          memset(haddr, byte, size);
>      } else {
>          MemOpIdx oi = make_memop_idx(MO_UB, mmu_idx);
> @@ -236,7 +233,6 @@ static void do_access_memset(CPUS390XState *env, vaddr vaddr, char *haddr,
>              cpu_stb_mmu(env, vaddr + i, byte, oi, ra);
>          }
>      }
> -#endif

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

