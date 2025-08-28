Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 198A8CA0FF7
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 17:16:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urgDb-0004bU-2D; Thu, 28 Aug 2025 13:15:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1urdvC-00046Z-DC
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 10:48:14 -0400
Received: from mail-yb1-xb2a.google.com ([2607:f8b0:4864:20::b2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1urdv4-0001cQ-LE
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 10:48:13 -0400
Received: by mail-yb1-xb2a.google.com with SMTP id
 3f1490d57ef6-e9532a90f71so936148276.0
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 07:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756392481; x=1756997281; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=otB5+cRbz+QfFf0Kz+3spcYY0ElDQPoumduLdGLmsQo=;
 b=hHpf6R9tbRYXQJbeOYp6e+He+3Q5CnOine7TAdd8Ml8cQF+Hnmucp0fkr9i1+oFnIV
 WdEndN7uZlkVo2+xHlHucYDGFfs3mm0p6IRtrBxGCJVB02I2IsuRA9wmX2THgtp9qIza
 5ak1oF8gFqR9hWXMj8dpDamaran774n3aKJVaXhJZx9tUs21M18ojQR94dBMnaJtj13j
 DFjLCgnqSBmgE/Q/ynEaLAddDjfEUd69UkCi3diN3LrRXl9iRtmYS+kAkDUSKuRi3zJU
 pxkNUrcYNektL9tSAdSizuXAJ9sh4cykc8LJOmS6XyqqLbEHim8ASaWkGOgTD/4SpxVG
 /nbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756392481; x=1756997281;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=otB5+cRbz+QfFf0Kz+3spcYY0ElDQPoumduLdGLmsQo=;
 b=lN0XpmmiBBcb6Fcy8XQDTolHbBZH2OZ5T2ZwjTcJ1Hbe4G4ivW1feh0WRQ1/qF0MXF
 FiIU5/W3gSPgwK2ystN7WVKtz8gJgY9+l0jhY0YR7uCg7ZkNXIcj5+BP50sF4uFt2//P
 0JYLKtujrN7SCCFgdDOyZpXdq2JjbzeNEezRyK32ZAuzHFRTewsJgvKGUbzPVfk0AOWR
 X0KF4hv17/JuiI9fnts9EPVzB1xkhxJt5EkF7UCei1xZ21LmvVCcTidPtzrSTP3D2YYe
 mvZtPjAYXg3Eqq9dkvIdMHl4QTe2TQ7OS7V0nNyBylwClnFswXwzvq0zG9YW0PjtYLtO
 nqyQ==
X-Gm-Message-State: AOJu0Yww0YqC5K8W8EPe3u9YfpLvmDq9dNeeTRGj5PMPOgNyfjm60XIB
 fcL33KlImC066uL/+w2yidExjnFTjueZ9t7lFsY7MKPMLQcgh0a3rxNx7AJGI3azW/4B9Yw+OUg
 cZYLCFOjCS6fL1EKlOxJ5tFhEJVpEHoXLxZ8Ylmktiw==
X-Gm-Gg: ASbGncu/84p5WMO9d3rXBLDSTR480G3PBn4UyGAcxypATr9kCcSAtX7+dDKl+WgEGl+
 BMpqRkC0WgS01bFM/UKSyASKY6gW1BN3Y0fuo9uQ0rUUl3Uhh9coGoytrunbNtkklB+MPzSlAo2
 x+cIAuD6G50flF2urhz+bd7Ow3ZPubeOBIcLJ6LTuHhg8WeFJOBg+sXFWrYqkqMDe5EMxjhyfVr
 XaMKFuD
X-Google-Smtp-Source: AGHT+IGoLWGo8TK0PMBaVNuCYJmnNVyEVY4zaFtMjqYUw3TAJMp/whtxYTkIDNu8xjs6OcwscRYx4mQ750QwZp4MVTw=
X-Received: by 2002:a05:690c:620b:b0:721:21ea:844f with SMTP id
 00721157ae682-72121ea849cmr148175517b3.31.1756392481226; Thu, 28 Aug 2025
 07:48:01 -0700 (PDT)
MIME-Version: 1.0
References: <20250828120836.195358-1-richard.henderson@linaro.org>
 <20250828120836.195358-39-richard.henderson@linaro.org>
In-Reply-To: <20250828120836.195358-39-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 28 Aug 2025 15:47:49 +0100
X-Gm-Features: Ac12FXyYyDnjUXvdqTDwcb7eSO6mKW1Mm5XCHAJTs1w4h8Ss2be36Qsr0Jayw48
Message-ID: <CAFEAcA_a-G1hgeefCxdZQMxcGv4=-23fRMM8TifPTuBCJcbKVw@mail.gmail.com>
Subject: Re: [PATCH v3 38/87] linux-user/arm: Expand target_elf_gregset_t
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2a.google.com
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

On Thu, 28 Aug 2025 at 13:10, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Make use of the fact that target_elf_gregset_t is a proper structure.
> Drop ELF_NREG, target_elf_greg_t, and tswapreg.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/arm/target_elf.h | 11 +++++++----
>  linux-user/arm/elfload.c    |  8 +++-----
>  2 files changed, 10 insertions(+), 9 deletions(-)
>
> diff --git a/linux-user/arm/target_elf.h b/linux-user/arm/target_elf.h
> index 94db3738e8..fa8f8af2f3 100644
> --- a/linux-user/arm/target_elf.h
> +++ b/linux-user/arm/target_elf.h
> @@ -8,16 +8,19 @@
>  #ifndef ARM_TARGET_ELF_H
>  #define ARM_TARGET_ELF_H
>
> +#include "target_ptrace.h"
> +
>  #define HAVE_ELF_HWCAP          1
>  #define HAVE_ELF_HWCAP2         1
>  #define HAVE_ELF_PLATFORM       1
>  #define HAVE_ELF_CORE_DUMP      1
>
> -typedef abi_ulong target_elf_greg_t;
> -
> -#define ELF_NREG                18
> +/*
> + * See linux kernel: arch/arm/include/asm/elf.h, where
> + * elf_gregset_t is mapped to struct pt_regs via sizeof.
> + */
>  typedef struct target_elf_gregset_t {
> -    target_elf_greg_t regs[ELF_NREG];
> +    struct target_pt_regs pt;
>  } target_elf_gregset_t;
>
>  #endif
> diff --git a/linux-user/arm/elfload.c b/linux-user/arm/elfload.c
> index 47fe16a1a6..726d3ec25c 100644
> --- a/linux-user/arm/elfload.c
> +++ b/linux-user/arm/elfload.c
> @@ -201,13 +201,11 @@ const char *get_elf_platform(CPUState *cs)
>  #undef END
>  }
>
> -#define tswapreg(ptr)   tswapal(ptr)
> -
>  void elf_core_copy_regs(target_elf_gregset_t *r, const CPUARMState *env)
>  {
>      for (int i = 0; i < 16; ++i) {
> -        r->regs[i] = tswapreg(env->regs[i]);
> +        r->pt.regs[i] = tswapal(env->regs[i]);
>      }
> -    r->regs[16] = tswapreg(cpsr_read((CPUARMState *)env));
> -    r->regs[17] = tswapreg(env->regs[0]); /* XXX */
> +    r->pt.cpsr = tswapal(cpsr_read((CPUARMState *)env));
> +    r->pt.orig_r0 = tswapal(env->regs[0]);

Why is it OK to drop the "XXX" comment here ?

otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

