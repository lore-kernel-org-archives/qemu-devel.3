Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ECDBCF45C2
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 18:53:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfN2A-000739-Sa; Mon, 12 Jan 2026 13:52:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vfN15-0006Xv-NE
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 13:51:52 -0500
Received: from mail-yw1-x1132.google.com ([2607:f8b0:4864:20::1132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vfN13-0006eQ-S4
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 13:51:51 -0500
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-78fc3572431so75668997b3.0
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 10:51:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768243908; x=1768848708; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SKuU3V4X7OA5M8UR12NyvIvcENnk+bbJma6esGV5gsQ=;
 b=rbBt/id6yvNRO8j98yzxFzNvI9MYp57pGFD/pDPNLoYlbNahoDI/9gDkzwgEcN6AP1
 mt0Op+M7VchkT4HjYNVW35BFy7gY5ce6X+3JqD7AOAAMww1Ms/o4rSfTnNHUhY0wsAgs
 gaKKYrF+Xb9AXHkXdb0Ovdya9LoMuIB8WkoET9iHR+cPjvmzCCEDT7o6LfJ5ZXf2SOjr
 PXEHp8ukuRknG3PfhyuNiM0YHNSZ2YcZHXn6qJ/B/7C9JIM+r+OhOyT2dZ3X2v6eLgDR
 WsTT1cM+7qtLx4mKeWCu9d2JRaY+K0aZks9fh9fpZDK5Inu72j/XfRic0+62x8RkL6eu
 csig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768243908; x=1768848708;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SKuU3V4X7OA5M8UR12NyvIvcENnk+bbJma6esGV5gsQ=;
 b=UMiu/UCDBgY4plbQsUMGkpOyIfJk9B+b5lJhlj0axe8bi0Gmh0NjxEW9hwVN4JnS+L
 nvGYISh8u0y7It1mzpoRY6bfL75eUh2DjcZo3KyLCdi0dzEUqiefZxOcgrxc5DbQfn1r
 NmefHAkDO2EQBs6Cx4NOLdcZhYgr9XeCA0KlWok8woULap8D4YQo0ms5LkiXTOeFU0cI
 QmsFj0LdybBJ479j+QHPsP10UHxDRNv/BOCITdaqhJqslrwHQixZfKQH91JfGbhfjov8
 XcxZ7BB8xGh+yC9Xs8CvFZ+uU0S64uqkWipVkusQa8m7r2X3EeIeSi6jEr0OgqJ7XveB
 QQJg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXgfUtK48zumDJ0NtJjaKL2Sd1rhcFLFvxIJSkEipZ3sYBsKu9TVTe5/qBUvf12Lj7HD8IhCzkTaa5Q@nongnu.org
X-Gm-Message-State: AOJu0YwGpX7/XEWwOKmqH4tsuQHZr1dSMcutfpg/JizjEm3ZjUH4dtkS
 9CW3F/A4d0bd+qS12VYN2bk9rMqTvdgEoQg0WgsKLoSwKY8aDpU/cupiZIjiCNDK7Od6LuHkOt1
 58vdiyM6239nbWGxtjpvyV3fCGGKiVzWBu9PCp6DYlg==
X-Gm-Gg: AY/fxX4kcH3HYxS5ysmJfyMNTSMozpMY+h7J9IimFGM9mqYyICMcu3BpKwhHOFR5iBc
 43dQH5GJxQd/wck1zYZx7xl0wocrOBCigt0kauUZb6legynIquYYf0LSGBxiOT5nqze6XYWieJV
 Amw8yGFfBG39NBu59+89P4RncE9PEb8Zdz3qmBXL0dlm/H3YGQnjpNMTjMG/QWErY8g/nvX19LU
 obyMRaHxh3LUQck6ZxaXAh8n23SSAuxk549Ao8U+moSH5DZj59nLbW/95v5fWI24BDB7LOX7Vby
 omrq+WzSfcYiN8iroL6P+mQ=
X-Google-Smtp-Source: AGHT+IH977pp4yBiwKwaMxoU9q2pwnpAf/NiX5qX7H5ObDP2nMyMBsDuja8EckvdlGKHxIL0fW941FunMWfNBPEpIVA=
X-Received: by 2002:a05:690e:118e:b0:640:d31d:6ed4 with SMTP id
 956f58d0204a3-64716c67b91mr16359914d50.51.1768243908185; Mon, 12 Jan 2026
 10:51:48 -0800 (PST)
MIME-Version: 1.0
References: <20251231170858.254594-1-peter.maydell@linaro.org>
 <20251231170858.254594-3-peter.maydell@linaro.org>
 <87zf6ww9fg.fsf@draig.linaro.org>
In-Reply-To: <87zf6ww9fg.fsf@draig.linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 12 Jan 2026 18:51:36 +0000
X-Gm-Features: AZwV_QipNNvh7G5GpChcI3gu2u4ViTuIDTs-KKn0PTXEYwXW7HjsTq4nAVSNK2g
Message-ID: <CAFEAcA-YDPYQ7mny_zFjgjWc4W8K18kUVuBgFbQ25sNpsM4Vvw@mail.gmail.com>
Subject: Re: [PATCH 2/4] target/arm: Correctly honour HCR.TID3 for v7A cores
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1132;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1132.google.com
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

On Fri, 2 Jan 2026 at 11:17, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
>
> Peter Maydell <peter.maydell@linaro.org> writes:
>
> > The HCR.TID3 bit defines that we should trap to the hypervisor for
> > reads to a collection of ID registers. Different architecture versions
> > have defined this differently:
> >
> >  * v7A has a set of ID regs that definitely must trap:
> >     - ID_PFR{0,1}, ID_DFR0, ID_AFR0, ID_MMFR{0,1,2,3},
> >       ID_ISAR{0,1,2,3,4,5}, MVFR{0,1}
> >    and somewhat vaguely says that "there is no requirement"
> >    to trap for registers that are reserved in the ID reg space
> >    (i.e. which RAZ and might be used for new ID regs in future)
> >  * v8A adds to this list:
> >     - ID_PFR2 and MVFR2 must trap
> >     - ID_MMFR4, ID_MMFR5, ID_ISAR6, ID_DFR1 and reserved registers
> >       in the ID reg space must trap if FEAT_FGT is implemented,
> >       and it is IMPDEF if they trap if FEAT_FGT is not implemented
> >
> > In QEMU we seem to have attempted to implement this distinction
> > (taking the "we do trap" IMPDEF choice if no FEAT_FGT), with
> > access_aa64_tid3() always trapping on TID3 and access_aa32_tid3()
> > trapping only if ARM_FEATURE_V8 is set.  However, we didn't apply
> > these to the right set of registers: we use access_aa32_tid3() on all
> > the 32-bit ID registers *except* ID_PFR2, ID_DFR1, ID_MMFR5 and the
> > RES0 space, which means that for a v7 CPU we don't trap on a lot of
> > registers that we should trap on, and we do trap on various things
> > that the v7A Arm ARM says there is "no requirement" to trap on.
> >
> > Straighten this out by naming the access functions more clearly for
> > their purpose, and documenting this: access_v7_tid3() is only for the
> > fixed set of ID registers that v7A traps on HCR.TID3, and
> > access_tid3() is for any others, including the reserved encoding
> > spaces and any new registers we add in future.
>
> I'm confused by the naming - especially as searching the Arm doc site
> with the Armv7-A filter didn't show up an HCR register (although it does
> show up in the PDF).

Not sure why it wouldn't show up -- this is the main hypervisor
trap configuration register, and it's always been HCR for AArch32
and HCR_EL2 for AArch64.

> I guess what you are saying is these registers trap from v7a onwards?
> v8/v9 don't change the trapping on this subset of registers.

I tried to lay this out in the commit message, but basically what
we have is that this trap bit is trapping a set of the ID registers.
In v7A it was specified to trap the ID registers that were defined
at that time, but not the encodings that were reserved in the
ID register space. (As ID register space, 'reserved' means RAZ,
not UNDEF as it would elsewhere in the system register space.)
In v8A some new ID registers were defined in what was previously
the reserved space, and so v8A says that TID3 must trap those also
(and that it IMPDEF is allowed to trap the rest of the reserved space).
Finally, FEAT_FGT fixes up the unhelpful IMPDEF variability by mandating
trapping on the whole space, reserved or not.

(Before v7A HCR didn't exist at all and these ID registers never
trap anywhere: since HCR.TID3 in our implementation will always
be 0 on CPUs without EL2, we don't need to special case "doesn't
actually have Hyp mode" in the access functions.)

> > -static CPAccessResult access_aa64_tid3(CPUARMState *env, const ARMCPRe=
gInfo *ri,
> > -                                       bool isread)
> > +static CPAccessResult access_v7_tid3(CPUARMState *env, const ARMCPRegI=
nfo *ri,
> > +                                     bool isread)
> >  {
> > +    /*
> > +     * Trap on TID3 always. This should be used only for the fixed set=
 of
> > +     * registers which are defined to trap on HCR.TID3 in v7A, which i=
s:
> > +     *   ID_PFR{0,1}, ID_DFR0, ID_AFR0, ID_MMFR{0,1,2,3}, ID_ISAR{0,1,=
2,3,4,5}
> > +     * (MVFR0 and MVFR1 also trap in v7A, but this is not handled via
> > +     * this accessfn but in check_hcr_el2_trap.)
> > +     * Any other registers in the TID3 trap space should use access_ti=
d3(),
> > +     * so that they trap on v8 and above, but not on v7.
> > +     */
> >      if ((arm_current_el(env) < 2) && (arm_hcr_el2_eff(env) & HCR_TID3)=
) {
> >          return CP_ACCESS_TRAP_EL2;
> >      }
> > @@ -5845,11 +5854,18 @@ static CPAccessResult access_aa64_tid3(CPUARMSt=
ate *env, const ARMCPRegInfo *ri,
> >      return CP_ACCESS_OK;
> >  }
> >
> > -static CPAccessResult access_aa32_tid3(CPUARMState *env, const ARMCPRe=
gInfo *ri,
> > -                                       bool isread)
> > +static CPAccessResult access_tid3(CPUARMState *env, const ARMCPRegInfo=
 *ri,
> > +                                  bool isread)
> >  {
> > +    /*
> > +     * Trap on TID3, if we implement at least v8. For v8 and above
> > +     * the ID register space is at least IMPDEF permitted to trap,
> > +     * and must trap if FEAT_FGT is implemented. We choose to trap
> > +     * always. Use this function for any new registers that should
> > +     * trap on TID3.
> > +     */
> >      if (arm_feature(env, ARM_FEATURE_V8)) {
> > -        return access_aa64_tid3(env, ri, isread);
> > +        return access_v7_tid3(env, ri, isread);
>
> This seems even more incongruous - we test for v8 but use the v7 helper.

We have two different things we want to do:

(1) always trap if TID3 is set
(2) trap if we are v8 or better and TID3 is set

We want to use function 1 for the set of ID registers that
existed back in v7A -- these are the ones that trap for any
implementation.
We want function 2 for the ID registers that were only defined
in v8A, and for the reserved-ID-register space. These must not
trap on v7A, and either must or are IMPDEF-permitted to trap
on v8A and later.

I have tried to pick function names that make sense for "what
is this doing", and for "if somebody adds a new register here,
make the function they want be the one with a name that seems
most inviting, so they pick the right one, not the wrong one".
So I have access_v7_tid3 for ID registers defined in
v7, and access_tid3 for the rest, including any new ones.
This seemed to me better than picking a function name that
describes the internal implementation of functions 1 and 2,
on the basis that people are a lot more likely to need to
use the functions than look inside them.

If you have suggested names that you think make more sense,
I'm open to them -- since I started by knowing the behaviour
to me the names I ended up with seem more "obvious" to me than
they would to somebody else, and it's the "somebody else" that
I'm trying to help with the naming...

Separately, the implementation of function (2) in this patch
is "if ARM_FEATURE_V8 is set, call function (1) to do the test-TID3,
otherwise return ACCESS_OK to indicate don't-trap". (Inherited
from the existing implementation choice.)

Given that function (1) is only a simple test of
"((arm_current_el(env) < 2) && (arm_hcr_el2_eff(env) & HCR_TID3))"
we could alternatively open-code that check in function (2)
if you think that would be clearer.

thanks
-- PMM

