Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4836CA0FF7
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 17:42:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urgFi-0001zv-Uu; Thu, 28 Aug 2025 13:17:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1urdbE-000417-Nm
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 10:27:36 -0400
Received: from mail-yw1-x1134.google.com ([2607:f8b0:4864:20::1134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1urdbA-0007NY-2U
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 10:27:34 -0400
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-71d603b62adso8632087b3.1
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 07:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756391249; x=1756996049; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ceWgqZDmgK6WUxWwSzyxXPF6SnSJMUsr98svZ0xKzc0=;
 b=KgT9+eYz8KV/d0jFp4/MSz09hlTKDMSF6KD1yrTz7NsLWUo00zIoEEiKOoKecyXoJm
 Y7p+fOYbH6kwZ67ldRF2q+VLz1U2Bp6xZVeb5rbjQtH7koZgfk5zbdYpnTCMm/UwAiY4
 q6xEpKBxQ319nAKhu4+Iei5nsxhtPrA48jMmGLibXarfsSJMGmaPYj53VVIGotxZXHWG
 lP1SMB5Dz7AMZ0hw3jaqrmLhDu9uEZaJXQJJGRChFqVCDY2eVSPpWP20XAjTvlDaJTIS
 9QULkVSXArmNi/qk6LfywutgEdzPYFZeD6lZ3ccSsUy20joH3kxSCUDpdiNdzWzcwGeO
 99VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756391249; x=1756996049;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ceWgqZDmgK6WUxWwSzyxXPF6SnSJMUsr98svZ0xKzc0=;
 b=oaNzQaZS36FjYRTtAq0CcYeqtBgD4QJNe3771jgcNuj+lJ6fyo46UmxjAbnyMkUZ0e
 jgULVaU3f7kX0XKLkbML5awEMaWpOA9Wlgs+vC79yvSW5mQN/CxdJhNFvozYSPJhdzjk
 IGgDE7ULg4QPZU9klV9Kv37WGGWPW920iy0gkXBVq/9vPJF97ZwTBfOag/iMMksCJk2t
 +NeQx3Cu1I6TIMxlLRnGwZcnzLUcjQBBg1UJnyEsdF+GEnCC1HiEujyS2vdZ/pw2VaCI
 k22/qe4ZJdd6Z8pcxQPjFs5ogFf0AQ9MkZ17ESdxrjjGEc5ngLSJOBlHWZFZEgxtbPZV
 wnog==
X-Gm-Message-State: AOJu0YwfRUQ0m10lHWzxOH0eMPwCINa5CnoyCw8APrkLPD+2+vWKR3EK
 O3y9j7pk4gzAKBsm4CE3A8v5XLrddI4QvSjHJB4dxRjuElTg6milTReXFp6zjOYY/Od+9sLIPhX
 StMLz0BA7tt+bG911O2ujWkp8Uv0W99/zUYl+YZsMIA==
X-Gm-Gg: ASbGncvpT4GBxFL/bfsEops9/aaKEbTqaS9BGvmAa6yoMBXhjM2+YlmYreljZvgg8Vc
 /TlbbunMrABFGXyJhQbqgPhKvQ7/aWylBXWiW2I+fjvVtYzMBDX0fJJbUud5zs3BMQwlDNMd6hY
 oSTSjXZ7OkIJ2nYJG9FGuakrOnriJVo+icbQUamFlcbsmfe2YXHt7LG/Qq33OanhScfyeRaVFCQ
 WOKiz/1
X-Google-Smtp-Source: AGHT+IE7KSpVwQuPeUasnxagB+/0bf86jCGcV66wmKvu8owLuwlniZYANEhPEmIKqMqEmEibmPC/gZnG4BR/IQqcjV8=
X-Received: by 2002:a05:690c:e21:b0:71b:4739:9d67 with SMTP id
 00721157ae682-71fdc2bddafmr242428597b3.4.1756391249319; Thu, 28 Aug 2025
 07:27:29 -0700 (PDT)
MIME-Version: 1.0
References: <20250828120836.195358-1-richard.henderson@linaro.org>
 <20250828120836.195358-13-richard.henderson@linaro.org>
In-Reply-To: <20250828120836.195358-13-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 28 Aug 2025 15:27:17 +0100
X-Gm-Features: Ac12FXznTEb1HQTazp31W7XNpzziji51XHCw3p0SfhZcwZwjSxJQN0rZZNWwWPI
Message-ID: <CAFEAcA8F23qy5DjS8Yi2NwB46oormJggFVK9i0bpgLSumbzgZA@mail.gmail.com>
Subject: Re: [PATCH v3 12/87] linux-user/s390x: Convert target_elf_gregset_t
 to a struct
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1134;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1134.google.com
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

On Thu, 28 Aug 2025 at 13:09, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/elfload.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
>
> diff --git a/linux-user/elfload.c b/linux-user/elfload.c
> index 63376fa1d6..98c17d32e6 100644
> --- a/linux-user/elfload.c
> +++ b/linux-user/elfload.c
> @@ -770,7 +770,9 @@ static void elf_core_copy_regs(target_elf_gregset_t *r, const CPUM68KState *env)
>
>  /* See linux kernel: arch/s390/include/uapi/asm/ptrace.h (s390_regs).  */
>  #define ELF_NREG 27
> -typedef target_elf_greg_t target_elf_gregset_t[ELF_NREG];
> +typedef struct target_elf_gregset_t {
> +    target_elf_greg_t regs[ELF_NREG];
> +} target_elf_gregset_t;
>
>  enum {
>      TARGET_REG_PSWM = 0,
> @@ -780,22 +782,22 @@ enum {
>      TARGET_REG_ORIG_R2 = 26,
>  };
>
> -static void elf_core_copy_regs(target_elf_gregset_t *regs,
> +static void elf_core_copy_regs(target_elf_gregset_t *r,
>                                 const CPUS390XState *env)
>  {
>      int i;
>      uint32_t *aregs;
>
> -    (*regs)[TARGET_REG_PSWM] = tswapreg(env->psw.mask);
> -    (*regs)[TARGET_REG_PSWA] = tswapreg(env->psw.addr);
> +    r->regs[TARGET_REG_PSWM] = tswapreg(env->psw.mask);
> +    r->regs[TARGET_REG_PSWA] = tswapreg(env->psw.addr);
>      for (i = 0; i < 16; i++) {
> -        (*regs)[TARGET_REG_GPRS + i] = tswapreg(env->regs[i]);
> +        r->regs[TARGET_REG_GPRS + i] = tswapreg(env->regs[i]);
>      }
> -    aregs = (uint32_t *)&((*regs)[TARGET_REG_ARS]);
> +    aregs = (uint32_t *)&(r->regs[TARGET_REG_ARS]);
>      for (i = 0; i < 16; i++) {
>          aregs[i] = tswap32(env->aregs[i]);
>      }

This code (which takes a pointer to an entry in an
array of 64-bit integers, casts it to a pointer to
uint32_t, and then stores to that) looks very suspicious
for not handing big-endian hosts correctly. But that's
a separate problem, so for this refactoring

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

> -    (*regs)[TARGET_REG_ORIG_R2] = 0;
> +    r->regs[TARGET_REG_ORIG_R2] = 0;
>  }
>
>  #define USE_ELF_CORE_DUMP
> --
> 2.43.0

