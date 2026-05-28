Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29EC2CD5BD5
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 09:18:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSWsL-000131-3E; Thu, 28 May 2026 05:18:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wSWsF-0000rk-Sc
 for qemu-devel@nongnu.org; Thu, 28 May 2026 05:17:56 -0400
Received: from mail-yx1-xb12c.google.com ([2607:f8b0:4864:20::b12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wSWsE-0001uz-5P
 for qemu-devel@nongnu.org; Thu, 28 May 2026 05:17:55 -0400
Received: by mail-yx1-xb12c.google.com with SMTP id
 956f58d0204a3-660456349d9so145613d50.3
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 02:17:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779959873; cv=none;
 d=google.com; s=arc-20240605;
 b=dD5D4bcKaslWlmNYBb9hR5oV1d4SK5Rc7WEtZd2+e+1/Chc2oLIXDXixkuXMKfhF77
 zkeiQ/H2uEEFvm0WimAxlIIsei3b8HuYSj3tMIEUsAULdrOPMFXoaQfao2t/WZVEseAt
 l3Vf9zaV0bRjyOHNSGo5Q4c/oMxKhqvf5XTWz2vzGLSrj+so+hJ8svnAp9x0+IpWFRfI
 NmWnjnIj3RRoDOOgyGgMAyB6Km1PkozgSzsfVelyvHsSOmtyFtXUOMcHThB+HDrUhAM2
 99KA1+X9uN5V44DQ68iXocJ/YxXxzd4EPNY9w3RbZavSpxSu8g6kORSsRtRxXSPCdxMz
 ZPtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=+BZipBpjvnBsXT09usZPYGe5z3DQXqqT8jDo94YrMeE=;
 fh=fD/PYjNhjfxxDV0+uWiNo3knrDuQ4nXVn9VEWNTtgCU=;
 b=fKjJALKRX+zACSB8MK9cpvWq8hrEyp2wuTWppNSxhdrns5DUsZRPW64DIguJuwhGAc
 +fYsfSS6G4uoy8lFXlBgIt+p8JYP+5tcra+IS4wv9kfn87ngRRGJnnrnLQFD+QsPD9LZ
 KSQHVhTKgdo4ekjxN+xVsAhNjshjU2jUjsPkI+WxsHFK8J6DnyhbQu5LZz7SaJsBLbqc
 pI/1doYEjCmg1Ln+m3YQf3OqlTlJdbklg5e6EB7egqXmAFHHM/jkQ28md0Blksm5lU4m
 Fc4TrddEZ46OedRifY2OFLtG4rp6gy6H7E6mxViQaPxs39Mggc9wdCYxfOXgnDYSE0zx
 R07A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779959873; x=1780564673; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+BZipBpjvnBsXT09usZPYGe5z3DQXqqT8jDo94YrMeE=;
 b=lqswIzhAaets/SqmT3USErgfFR4GlKDAUjlU66ciI2ruBq6SzusaZWjriqPHCogyEq
 7nt/w9r4kV3nrON5m5vF+YEachIFarQYUo+AYFMoXGeOrXGmDhC/qmmM85a81a+khP0t
 hcf9SoYa/8mpIqZjD7VFckxBm1OVppWqmW/+lsCf2IJm5/beZK+odq3F6DV3hiD2rTtB
 TSaCpw5rBdybYPFKvWrwJegm2Rc9jcLn/4bijCpIiauiWdXeAMkn/RxAMvg/+QETr784
 6+P9/jOrIrSYPyYJ4GMz8E0Oo9JaPl+kbQQNVurx6sNwfKP93K1n3tc4XkAHrYLCTVbm
 hcZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779959873; x=1780564673;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+BZipBpjvnBsXT09usZPYGe5z3DQXqqT8jDo94YrMeE=;
 b=n8I5ej76UhjXbEaU/sACbTV2CwSpVcc+yhVXR/bv1mEn/Hui4fZNKUdJTPf1HvpNtJ
 aqKBXeb1szs5FC8d5mHi8ggdn1enO6Tl7RnTeiMgu3j9EwaLnUqYz+/lRPeYsfMAGgUx
 ZU7g43cGeppaxLyNHHTj8RG4dXl7rKAR4Zg0sVlyCggAff0XTBFkEL4rGkvzXMtTDA43
 pwzWRPRkX3rzrsY2EqLvCeivWNBlMh3jHA6Ei6LUMGDhTnDrSwYRrdKj+I5qpSr+14qT
 YhLsl/i27/oeM959GmV7PCRHW57wyd8KwFY3s4noa0CG6zmfEAlZl2ZbEZL6dFPmKTYx
 5Tww==
X-Gm-Message-State: AOJu0YxTvxq9jrSgFihC0wn5sr1vbHddCQNnprLS1Bjt0/fOiJ4IcK5a
 BmEsBNmAd0sNPpCMZgvgBztU6nQrqBnm6h8ii+jX7v/K2H76g1Mrv9f3igAL0mZ1KDAul24TinI
 RNwD+BYnX8kUuWEEOmjWRZe2rE5bBv3Y/ZIgbWbLq5Q==
X-Gm-Gg: Acq92OGmq7eUs5+9VeFWcFWmqAQ/lHdr0j6OAOIMqU1i00epv28aCOSVp1576CtS+aH
 GoPJYuFpiVpletliePaiWESMha/K0gMi1HL42CkHaGks/2b5NfrL8buHPwjOH6ivh6MOh191YXQ
 s1b8QkoTycwP5zqBEvHTdLQADFlmgipCCgapU3RBmZdE0vnmgZ9E72xn7Vm6qDvjOVj8x0OBCcx
 izunIqrBEqaJxt0cJBPM66uOfaVTSkYz3Iy5cfZK1MkHVt4vxKhGxb6KsuuAAu5uRW76yofFjQU
 1WokBKACuBrIAjH+SYTA4OR0negVAh1T3ux8gemiNaAcHvhnxf7rKbaBzRXzIuhlSJJ7IJydNZ2
 MqA==
X-Received: by 2002:a05:690e:1306:b0:657:eeac:6ba2 with SMTP id
 956f58d0204a3-65f3f48186dmr19463682d50.46.1779959872611; Thu, 28 May 2026
 02:17:52 -0700 (PDT)
MIME-Version: 1.0
References: <20260527175705.152301-1-christian.barry@usp.br>
In-Reply-To: <20260527175705.152301-1-christian.barry@usp.br>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 28 May 2026 10:17:40 +0100
X-Gm-Features: AVHnY4KWH4MvTMUhzLxy1dB-ftoU7D35r3H2ac72n_hiU4LJCD90u04xoNJ0zIA
Message-ID: <CAFEAcA_t_Rx1CupetKR=aC1U6skFYmo_2oG-PyVYdwfJmb5X6Q@mail.gmail.com>
Subject: Re: [PATCH] disas: sparc: Fix integer overflow in compare_opcodes()
 for loop
To: Christian Barry <christian.barry@usp.br>
Cc: qemu-devel@nongnu.org, Artyom Tarasenko <atar4qemu@gmail.com>,
 qemu-trivial@nongnu.org, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 Eduardo Augusto Cavalcanti <eduardoaugustoabc@ime.usp.br>
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

On Wed, 27 May 2026 at 20:56, Christian Barry <christian.barry@usp.br> wrote:
>
> From: Christian Barry <christian.barry@usp.br>
>
> Replaced left-shift of a literal 1 by i inside of two for loops in compare_opcodes() with a call to BIT(i). This makes it so 1 is interpreted as an unsigned long int, preventing overflows.
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/2618
>
> Signed-off-by: Christian Barry <christian.barry@usp.br>
> Co-developed-by: Eduardo Augusto Cavalcanti <eduardoaugustoabc@ime.usp.br>
> Signed-off-by: Eduardo Augusto Cavalcanti <eduardoaugustoabc@ime.usp.br>
> ---
>  disas/sparc.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/disas/sparc.c b/disas/sparc.c
> index 5689533ce1..6fc057e3a2 100644
> --- a/disas/sparc.c
> +++ b/disas/sparc.c
> @@ -27,6 +27,7 @@
>     see <http://www.gnu.org/licenses/>.  */
>
>  #include "qemu/osdep.h"
> +#include "qemu/bitops.h"
>  #include "disas/dis-asm.h"
>
>  /* The SPARC opcode table (and other related data) is defined in
> @@ -2515,7 +2516,7 @@ compare_opcodes (const void * a, const void * b)
>       another, it is important to order the opcodes in the right order.  */
>    for (i = 0; i < 32; ++i)

The loop boundary is 32, so i is at most 1.

>      {
> -      unsigned long int x = 1 << i;
> +      unsigned long int x = BIT(i);

The loop boundary is 32, so i is at most 31. QEMU uses the
-fwrapv compiler option, so "1 << 31" is well defined,
even though it shifts into the sign bit. It's worth noting
in the commit message that we are not actually fixing any
bug here, we are merely placating somebody's static analyzer.

>        int x0 = (match0 & x) != 0;
>        int x1 = (match1 & x) != 0;
>
> @@ -2525,7 +2526,7 @@ compare_opcodes (const void * a, const void * b)
>
>    for (i = 0; i < 32; ++i)
>      {
> -      unsigned long int x = 1 << i;
> +      unsigned long int x = BIT(i);
>        int x0 = (lose0 & x) != 0;
>        int x1 = (lose1 & x) != 0;

If we're going to bother to change this not-a-bug, it would
be  better to do it the way that upstream binutils did it,
as noted in the gitlab issue: using "1ul".

-- PMM

