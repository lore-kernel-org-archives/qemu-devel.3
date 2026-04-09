Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42F73F364B5
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2026 19:47:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAvLb-0002m9-LL; Thu, 09 Apr 2026 15:47:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wAvLZ-0002l3-Vj
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 15:47:25 -0400
Received: from mail-vk1-xa2a.google.com ([2607:f8b0:4864:20::a2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wAvLY-00089x-8P
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 15:47:25 -0400
Received: by mail-vk1-xa2a.google.com with SMTP id
 71dfb90a1353d-56adf76631cso582746e0c.1
 for <qemu-devel@nongnu.org>; Thu, 09 Apr 2026 12:47:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775764041; cv=none;
 d=google.com; s=arc-20240605;
 b=ZJX2Kn3wN8CWHHIfq/YlnH21PwkyptR5lfjLCob6Fsygf57oTkJyyRs44JravioEbu
 YmJKo0f0+DvG0MEvn9jDH1f2cu2uYP6KSm6dgYLhu57XUz2siE2Y4WpKr7cRPjwuKqhz
 zm4QRe6hKcVPl02OZ4vt2QccxWlvxoM7ililF0/8RsIvW32n4Q4KPQQGpRZ7J2u4yh5h
 Rb0aoqZNv345GnvinV04pN3vaT7nJqItyQlzRdiAVJW+gRtr+oHL0m04fHyEpgBIce8e
 te9QEj1XfiMeT2HJkbTzgv1/nXJZKyc2DkepAlXAaUeYnQO3POmo+IcqyYCddGotDTGR
 cnKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ivK1ujKgo5AEue5SL9zh2aD9+EPBEhfFsm44MC3WiWI=;
 fh=6WPaczp89kVEvyqQhTtoSourPaOeS62pIBkgOKSIhVk=;
 b=fujKhwXL8GQB9uWByn9JrdE83usEYLrNJxGbc2I+tOzOVqmBQWnTXOMNCCgyTnQhbj
 16kPgiQuQeJN9cxDyVpEJQaIIZQdnaLQCJEjo4u62xM8GAO6cTNjejtnuIl2/jrUYda1
 wGbm/mcpaXskdFpHKbRmK1hpy6jZ+6+0MeenVHRg4C0PaOPbcKo4hcybqEMjQAVttY9D
 HpRhCbXw+byWSk3u/j51rJbz488Cw60apNrGBvSiTQ3lDA3xge9kFAFMZYYS1GjYcWMt
 SCA5KGyVrHvcxTQOnCkn4BdzC/jK+3hahmxdcuJ5iPD2QEO3xLMNVvCszm0ilQ+Q3WBQ
 u9nw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775764041; x=1776368841; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ivK1ujKgo5AEue5SL9zh2aD9+EPBEhfFsm44MC3WiWI=;
 b=f30kPg8Fyv4Yj8L5JJ2e/7KoWCiDuFxXu96YPdDfjFtlE2aQ2QdiyAGDBasGxvWEsd
 6YIDDkY9xjTJ2WIRiNxfmvDdTRpEhUv3/26LUH0Q0zYeZ74vgJZHHG6zrbCAw7KX+FTO
 uakOUlNPdAkd4n3FWaetasV47E0kve+l0vALiEVYRQ/6UbpkQkRHoAyB19LA7CIx8NKT
 ZPnlzQPj1nvDLC0z6oPPMQ6cdmjXKbaXSPZjRFVart/xTyxe9lCypn6T5KM0u5JuIKPF
 C6Qkp4ep37TZbDCFDSy88NLpqALv+qbWwQlOJyA0HFeqT5LmFxUsML3yhXvhdCtNkzHW
 t/4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775764041; x=1776368841;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ivK1ujKgo5AEue5SL9zh2aD9+EPBEhfFsm44MC3WiWI=;
 b=OfuvHSSPsq5XVcHKTYa0qR7mQPFJ2QUniuw2H9A3qM0v6lRpzPeXH8pYizM87zam/T
 sNmdMCb9zAcP1Rl4wP+abqRbVoUOuhFBfnr8rbC5msiDsLBe5LLK2M7LaFNdoYAeVvVp
 cGS2HJ9dUW3NnSj1ab9XnwbQi38FV1oFN2VWv21/MQX/0p7Z1WiLD6ndB42CpaedAQVW
 W/5YJCHog5yAQ9nDfTKNhy3FYkzoAqwaFWG0yGEl3swFR7Z/K9mWuxmbmLABpynfb2Z4
 qctAj+mBXiNwSUSNBCTju6bL8sSJUUNgx81VX1lLwKxLDjqu+Zs8wLdSjIIu4yc9iQhV
 VXiw==
X-Gm-Message-State: AOJu0YwBb8xYfBOJ0XbTG+0fJz4fmav3hopPOAIl8wtM8DaK7OcXXZpz
 2iZjSuZJANWTT639oMvcAkUvDK1UyUvheTExc2ellbGvXRebLOwljGsC1glGCDJLgKh/Jy0ouWI
 fopEL5TLpY05HgmnxhKP3uyQKxHVi/es=
X-Gm-Gg: AeBDietAtl2oLSrKDlSw0DbeRL71GayZk3OlTVHPTHRJ2T8o701OR3BjIetUr/hO3fC
 9WVi8aIyRomI+Wof0kx8HJE8m5vgJMBwmrcTIbOZ3GJS3FeF1SfNRwtJYHX6aqeh/HhBAxKJ7WM
 FXRLe8VeOArfCI8u86ujrOsheSDRYfhPru6ZFWYBFWz1MR2DJ8JMCu1ycpHZTr1bqbOyt4FMquk
 0a6eKT4TyS0h3EIUO907TEcjdtpiQ4jWPfcabc+z1Hc2whXH+gOXDyNIm7xl40raUmRc7FOlZR4
 w0Ibz9v0+InBs6wK6ouUDjSsnO6qXIwCT86J90lbAbkWUgnvy0mI+SaPHlcNfYLQCnu7TA==
X-Received: by 2002:a05:6102:f8d:b0:609:4182:f135 with SMTP id
 ada2fe7eead31-609ff2d5780mr142444137.11.1775764040657; Thu, 09 Apr 2026
 12:47:20 -0700 (PDT)
MIME-Version: 1.0
References: <20260408184228.44242-1-james.hilliard1@gmail.com>
 <CAFEAcA_Jt3SmuTiLWxuVQuktAG=M5C-Ux7OYKcGwPUBSETegew@mail.gmail.com>
In-Reply-To: <CAFEAcA_Jt3SmuTiLWxuVQuktAG=M5C-Ux7OYKcGwPUBSETegew@mail.gmail.com>
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 9 Apr 2026 13:47:08 -0600
X-Gm-Features: AQROBzAveNF3jHCkKmrLcl8en688esMJcyx_6L0bcXM1S2ry44_fjm-xrIwTM8c
Message-ID: <CADvTj4rMoQi-ic=q=TJ5Dz6_GhHhR=JNhMoRhfKCFAuZzhUpzw@mail.gmail.com>
Subject: Re: [PATCH] linux-user/mips: keep k0 in sync with CP0_UserLocal
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2a;
 envelope-from=james.hilliard1@gmail.com; helo=mail-vk1-xa2a.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Thu, Apr 9, 2026 at 10:17=E2=80=AFAM Peter Maydell <peter.maydell@linaro=
.org> wrote:
>
> On Wed, 8 Apr 2026 at 19:43, James Hilliard <james.hilliard1@gmail.com> w=
rote:
> >
> > MIPS glibc startup expects the thread pointer to be live in both
> > CP0_UserLocal and k0. linux-user already updates CP0_UserLocal for
> > cpu_set_tls() and TARGET_NR_set_thread_area, but it leaves gpr[26]
> > unchanged.
> >
> > A guest can therefore successfully execute set_thread_area() and still
> > reach __pthread_initialize_minimal() with k0 =3D=3D 0, faulting on the
> > first TLS-relative store.
> >
> > Make cpu_set_tls() synchronize k0 with CP0_UserLocal, and route the
> > MIPS set_thread_area syscall through cpu_set_tls() so all guest TLS
> > updates follow the same path.
>
> Where does the kernel do this? Looking at the mips set_thread_area()
> https://elixir.bootlin.com/linux/v6.19.11/source/arch/mips/kernel/syscall=
.c#L87
> it looks like it sets CP0_UserLocal plus the tp_value field in the
> thread_info struct; and I can't immediately see anywhere where it
> would read either CP0_UserLocal or tp_value and put it into k0.

So this seems to be something used by the vendor SDK for Octeon1
but not Octeon2 and Octeon3 targets, kinda strange/annoying.

I also found this:
https://lists.gnu.org/archive/html/qemu-devel/2011-08/msg02026.html

It's in the Octeon vendor kernel here looks like:
https://github.com/MarvellEmbeddedProcessors/Octeon-Linux-kernel-4.14/blob/=
5c48e5031fbd86361e8185f6c530ffcfa5c9a60d/arch/mips/kernel/syscall.c#L94-L96

> I also couldn't find the MIPS glibc code that uses k0, but I
> didn't look very hard there as I don't know my way around the
> glibc sources -- do you have a pointer to it on that end?

From Octeon SDK glibc/ports/sysdeps/mips/nptl/tls.h:
/* Note: rd must be $v1 to be ABI-conformant.  */
# if !_MIPS_ARCH_OCTEON
# define READ_THREAD_POINTER() \
    ({ void *__result;                                  \
       asm volatile (".set\tpush\n\t.set\tmips32r2\n\t"                  \
             "rdhwr\t%0, $29\n\t.set\tpop" : "=3Dv" (__result));          \
       __result; })
# else /* OCTEON */
/* The Kernel stores the value of "rdhwr v1,$29" in k0 ($26) register. And
   it is the Kernel's responsibility to always have the correct value in
   k0.  Replacing rdhwr instruction with k0, as this instruction needs to
   be emulated by the Kernel.  */
# define READ_THREAD_POINTER() ( { register void *__result asm
("$26"); __result; } )
# endif /* OCTEON */

From Octeon SDK glibc/ports/sysdeps/mips/tls-macros.h:
# if !_MIPS_ARCH_OCTEON
# define TLS_IE(x)                                      \
  ({ void *__result, *__tmp;                            \
     asm (".set push\n\t.set mips32r2\n\t"              \
          "rdhwr\t%0,$29\n\t.set pop"                   \
          : "=3Dv" (__result));                           \
     asm (LOAD_GP LW " $3,%%gottprel(" #x ")($28)\n\t"  \
          ADDU " %0,%0,$3"                              \
          UNLOAD_GP                                     \
          : "+r" (__result), [tmp] "=3D&r" (__tmp)        \
          : : "$3");                                    \
     __result; })
# define TLS_LE(x)                                      \
  ({ void *__result;                                    \
     asm (".set push\n\t.set mips32r2\n\t"              \
          "rdhwr\t%0,$29\n\t.set pop"                   \
          : "=3Dv" (__result));                           \
     asm ("lui $3,%%tprel_hi(" #x ")\n\t"               \
          "addiu $3,$3,%%tprel_lo(" #x ")\n\t"          \
          ADDU " %0,%0,$3"                              \
          : "+r" (__result) : : "$3");                  \
     __result; })

# else /* OCTEON */
/* On Octeon the kernel stores the value of the thread pointer in the k0 ($=
26)
   register.  */
# define TLS_IE(x)                                      \
  ({ void *__result, *__tmp;                            \
     asm (LOAD_GP LW " $3,%%gottprel(" #x ")($28)\n\t"  \
          ADDU " %0,$26,$3"                             \
          UNLOAD_GP                                     \
          : "+r" (__result), [tmp] "=3D&r" (__tmp)        \
          : : "$3");                                    \
     __result; })
# define TLS_LE(x)                                      \
  ({ void *__result;                                    \
     asm ("lui $3,%%tprel_hi(" #x ")\n\t"               \
          "addiu $3,$3,%%tprel_lo(" #x ")\n\t"          \
          ADDU " %0,$26,$3"                             \
          : "+r" (__result) : : "$3");                  \
     __result; })
# endif /* OCTEON */

>
> thanks
> -- PMM

