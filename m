Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5730810D14A6
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2026 11:42:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7B0J-0005PH-3C; Mon, 30 Mar 2026 07:41:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w7AzL-0004ks-P3
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 07:41:03 -0400
Received: from mail-yx1-xb12c.google.com ([2607:f8b0:4864:20::b12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w7AzH-00046D-7y
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 07:40:58 -0400
Received: by mail-yx1-xb12c.google.com with SMTP id
 956f58d0204a3-6501d242e3fso1187980d50.0
 for <qemu-devel@nongnu.org>; Mon, 30 Mar 2026 04:40:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774870852; cv=none;
 d=google.com; s=arc-20240605;
 b=YjSWEpbVICEC8FNPhIFy8gTA+eqydGLH5i5Z8Bxc9kgdWvPa3YZ/DzRtuoUw81wUgu
 aFBDz/K4qucXBqZ3978R4lW7a2aWC8K1U9CFn2P9WVUsH6vFzyiLzul5I5c4yywHwEvJ
 HpOvSilVaPZVWOx6+9ddApdOSiekhdmDIXRiH2ejkjMIBJm+cxQfWRSvnQYCcgAWY28V
 49UU4OKq66Uyd7gS5p4BAjsWzNG2e2KsJTnBw05Dn5JxSYZGidjBhA71RLl7Nh4wbAnf
 fG+txsGV61mlyOPtXal760/DpQDOZHAl4cBMDFHLrgzMME6KNwB9PSSoZ4dc61D9M9Il
 iM3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=8m3ChoSkQKNerngdseOyVAs40vZfuyFvV+PEJ67+BMQ=;
 fh=B00/vlsCe9JKVgVvLK07hWGtGxiE41v9oSU0sqCEA24=;
 b=dw/biEroSFiNb52A7yGRbCDh5Uo4XYNZP1Z3T3Vtt8BofSHAPDykQ7To+qmmzcPkfc
 G6JDfdhz5iGTySZKlgKTs8D5Rfpj2pOmRXdlSPo7YL4C8dDzytjP3wO0yLILGgWhNZiw
 42cDe/15BGrFNIQwGs4sp1hCVN1npVGKyuTJBg3QjaxvamuWXUilc3wcFMp0bg8LnsiP
 BIX8OQNvRaD01UyR44VQ+BAXkpWAtBxLQnCLZcMK7sgvTTrxmP+sBvSTV9j8GCRmYhJ4
 Gh86em+jYnjb9OzaITQPimqW3u/pZAtnUJUN+SPWiWXb3y7IzCIHa9S5fwCy2f/BDqfr
 0lng==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774870852; x=1775475652; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8m3ChoSkQKNerngdseOyVAs40vZfuyFvV+PEJ67+BMQ=;
 b=y3DpQFH7mdKdKCBop56tkMyAhlftIH9xmuECG0MlvojjBFcb3iV7qMJ3IbWTAWLhv+
 dkp6s5o1Now6upJMHNYih1C3owXnrQm8KGU4KmamxBlR7oQRSCZnWlbQ44vRm4+ZHJ0g
 M39mUQXvqBulOypRzz++k/TS/22W/BaNoBge6MMO86UGLqqLu0zIgsZSZA6hnYdZcPU1
 ohWH8i1J3jwejy+z/Thhx5akbhf/gIhq3V84FzMe9uQMJSivSBrstuHbSPRsZSQ27hQi
 tIf1EUQO+g3YN3NQ58vN8wEdonNaGCCaaIUucMxvOf80/2f1cAIGTQeLgdmbBkXRfiwg
 v5Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774870852; x=1775475652;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8m3ChoSkQKNerngdseOyVAs40vZfuyFvV+PEJ67+BMQ=;
 b=pJwToenQyBIKE2VYmmYCRcDjpHJG0ItbCkjBtzlXTOZtMElsceyh6hKP55T7HQlc19
 x8VFeIk/8MDoGrk1z+FLpjUzd33CMZIJ+bTwz/QT+N+j1H+BMXcrPOYGAmNRQ4Y7zUdt
 tmG/DhnF7sSekPTjbWeKyMgFufG9Wy68ZIYH2maVQ/n/bR3uoL6iA4n6PSwwSnSYs8sy
 1lXV1DAoqexaOGhU2lg16gelOYQfyAR+3GuGyumEV4ES08pXYpu+XJubMlA8U2l0MCyB
 749oUdnP5RIgjhalBxZcV0tcrCwz1AbuB9VPN+g6FAXWDJ3aL/Rw0bS+Quf8VAv/fzbP
 UY+Q==
X-Gm-Message-State: AOJu0Yw7Ks3yxIB0PdX+WrMO42oUEouFvVYuCAUIgt1o61ov25kqHJUv
 +ZpTojP/jhyKoshUtS2IYneC0oFVejJWopGRowzwOCtXizEdRsVeG5itq7mBy27Z99nowLLM21P
 vRje/m4J/tw48mkTbZRQDYaFoKiwI27IQIlQxH2VoFQ==
X-Gm-Gg: ATEYQzzQPkZuS+4fFXo8+IuEBmNOxxdmXWuwTusD/7atnUOg6USd8gLd5LdswAojB8V
 ruvesID8rM8+ZHNtlYJtsgyugycKb/n8QfUAu+755ObzsJnJDveuUy8Ae8ICQYO1izUWTPUGiqv
 tGPghCsPfUehglTONBz04XyEifvCWNxFVfSIaVmia7o6xaCcmlkF7NMONKkbdcT5YXry12Ur7lM
 yx/2sZWK6VHJShlIIGOzOULE1ZgazzKSK/2vLi95TzgA2YUmp6MXUBP1pdB0qiksnjiee6qmony
 TEd1klKhRRFZqSu4onB7hjdhsnS317AOCA/Mv/ZqkkkFVpCbKatGlRtie7eEBZYLZSg=
X-Received: by 2002:a53:d005:0:b0:650:2257:e065 with SMTP id
 956f58d0204a3-6502257f1d2mr765719d50.48.1774870851443; Mon, 30 Mar 2026
 04:40:51 -0700 (PDT)
MIME-Version: 1.0
References: <20250501212113.2961531-1-richard.henderson@linaro.org>
 <20250501212113.2961531-56-richard.henderson@linaro.org>
In-Reply-To: <20250501212113.2961531-56-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 30 Mar 2026 12:40:40 +0100
X-Gm-Features: AQROBzBjWolb7KWDRHQcHxCD8C10YRQOvwl-1V5lkM-GjPM5sGGSPDm5198INN4
Message-ID: <CAFEAcA8qDz9a21bmrLLrBWa7b5vcDQj82+iSgm-nEzbqD5MjsA@mail.gmail.com>
Subject: Re: [PULL 55/59] include/user: Use vaddr in guest-host.h
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12c.google.com
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

On Thu, 1 May 2025 at 22:31, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Replace abi_ptr and abi_ulong with vaddr.
>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  include/user/guest-host.h | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)

Hi; it looks like this commit (7804c84a56f92) causes regressions
for some target architectures (at least m68k), as reported here:
https://gitlab.com/qemu-project/qemu/-/work_items/3333

The problem is that for a syscall like mlock, we do:

        return get_errno(mlock(g2h(cpu, arg1), arg2));

where arg1 is an "abi_long" corresponding to the syscall argument.

Before this commit, g2h() took the address as an "abi_ptr"
type (which is an unsigned type of 32 bits for 32-bit targets
and 64 bits for 64-bit targets). With this commit we now
declare the address argument as 'vaddr', which is a uintptr_t,
so its width is based on the host, and these days is always a
64 bit unsigned type.

So before, for 32-bit targets, we took the signed 32-bit arg1,
cast it to an unsigned 32-bit value, and then inside g2h_untagged()
cast it to an unsigned 64-bit value to add to guest_base.
Now, we cast the signed 32-bit arg1 directly to an unsigned
64-bit value, which sign extends it, so we get the wrong answer
if the guest address is above 2GB.

Why did we make this change? abi_ptr seems like it is the correct
type here -- we want whatever the pointer type is for the guest
architecture.



> diff --git a/include/user/guest-host.h b/include/user/guest-host.h
> index 8e10d36948..0656f2e356 100644
> --- a/include/user/guest-host.h
> +++ b/include/user/guest-host.h
> @@ -8,7 +8,7 @@
>  #ifndef USER_GUEST_HOST_H
>  #define USER_GUEST_HOST_H
>
> -#include "user/abitypes.h"
> +#include "exec/vaddr.h"
>  #include "user/guest-base.h"
>  #include "cpu.h"
>
> @@ -30,29 +30,29 @@ extern unsigned long reserved_va;
>  extern unsigned long guest_addr_max;
>
>  #ifndef TARGET_TAGGED_ADDRESSES
> -static inline abi_ptr cpu_untagged_addr(CPUState *cs, abi_ptr x)
> +static inline vaddr cpu_untagged_addr(CPUState *cs, vaddr x)
>  {
>      return x;
>  }
>  #endif
>
>  /* All direct uses of g2h and h2g need to go away for usermode softmmu.  */
> -static inline void *g2h_untagged(abi_ptr x)
> +static inline void *g2h_untagged(vaddr x)
>  {
>      return (void *)((uintptr_t)(x) + guest_base);
>  }
>
> -static inline void *g2h(CPUState *cs, abi_ptr x)
> +static inline void *g2h(CPUState *cs, vaddr x)
>  {
>      return g2h_untagged(cpu_untagged_addr(cs, x));
>  }
>
> -static inline bool guest_addr_valid_untagged(abi_ulong x)
> +static inline bool guest_addr_valid_untagged(vaddr x)
>  {
>      return x <= guest_addr_max;
>  }
>
> -static inline bool guest_range_valid_untagged(abi_ulong start, abi_ulong len)
> +static inline bool guest_range_valid_untagged(vaddr start, vaddr len)
>  {
>      return len - 1 <= guest_addr_max && start <= guest_addr_max - len + 1;
>  }
> @@ -62,7 +62,7 @@ static inline bool guest_range_valid_untagged(abi_ulong start, abi_ulong len)
>
>  #define h2g_nocheck(x) ({ \
>      uintptr_t __ret = (uintptr_t)(x) - guest_base; \
> -    (abi_ptr)__ret; \
> +    (vaddr)__ret; \
>  })
>
>  #define h2g(x) ({ \

-- PMM

