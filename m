Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA20BCD343F
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 14:33:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNtaj-0000Sa-15; Fri, 15 May 2026 10:32:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wNtaV-0000Kb-Iw
 for qemu-devel@nongnu.org; Fri, 15 May 2026 10:32:30 -0400
Received: from mail-yx1-xb129.google.com ([2607:f8b0:4864:20::b129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wNtaT-0003Oj-IE
 for qemu-devel@nongnu.org; Fri, 15 May 2026 10:32:26 -0400
Received: by mail-yx1-xb129.google.com with SMTP id
 956f58d0204a3-651c366f7efso12129327d50.1
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 07:32:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778855544; cv=none;
 d=google.com; s=arc-20240605;
 b=AKT0we5LSaD2DWS1ehFHYtt8gGJbz7PGiiEuiNCTaBCn1DqCXx+jgcghNj3x3Y/yLt
 hmIm4Fjnwqk5DC+tDB9/kqpDEgOppl4QWilEqLNaNpNA7uK78m7rLhqi1LLf/Ne0Qahx
 5kNSFXFxbOw+7O0GB6BosqYN04ckATznsXlCsGVagHVtYeMRfPaZdBJ8AY01w29eL+fp
 5Io9uwoSrdZS3x4qxOLwxFmE51dnA4WNiHlqATAfJn9WAItfILPqspzdW96HOL/ceVCJ
 OwBJGA2z4Wf6kUiUIeskIb9TVWatAhQIZOeojeF92L2ifDZ3J5Pcb6lkSYnmpueMO83b
 09xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=RXyTgHqhRoa+CNH+pq00BtG27itTU8GXgWjNABR3CHQ=;
 fh=aIr4pFmMH2DFneiVLM/JGlMchwrnGhwgQ3rMYXWfLtk=;
 b=WT5KI/8MSr1pYdlGeGHhrb3X5rdzhm5Zum6gd+v7gxGCHuXLgdkqhRJ10bAjnxmr+D
 sV735s6te7K9+02XNgTejzVBcS2kDT1IVr+3J8YodZNxATcd1in7YQ2FQjTZwmeeT6Ym
 Zc7piBYA1cUgEX4z05WtPfYiUpJpYJVmkNfNVQFhUXZfvykKweOAyhc6GnlguayL5CI4
 cYIkDTVtdSWueVMSlLzpZIEDVnzOrkJd1eqjLsAt5VlMXskK3KI0zFpIZIGQyVxKVfGu
 YId/Pb9BPiLbiOQlB1gPJ9OLgcQ+eTyQBAz9HjTspRTjIs8RzJ1ceXIBAU3uxTv9u+N/
 xesw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778855544; x=1779460344; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RXyTgHqhRoa+CNH+pq00BtG27itTU8GXgWjNABR3CHQ=;
 b=EKbsRQLS4C9CjXQ05KvzN8On+Fl/OhDGOivUmzWnRiFyarvzZCpauzXKoj03ZnvYwT
 9OyLROgp1/YVKg68rN+KLJH6TdkM6K7nTan/q14aCxDslkMhT0Nhy1rmnJG68Qtesy7J
 6u6SyUl+7gJ+GNSyz0IxUctGpyAiai2KkDdTaWqaAOPbj2FDua8a/UacpdHRY7CQJrCj
 M8TJrr8SztL/pV1d44yUiWfpjbo6/sIENPck11Bxh+MFxFQHKKPr0vaCE4CKdeDFzgva
 m9sCQ3SJvueSsrrZ/FfCIurOLOImcNcg2M4D9kmRcz8gQwV/jtebdNOceO52+QhEDr6U
 gL2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778855544; x=1779460344;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RXyTgHqhRoa+CNH+pq00BtG27itTU8GXgWjNABR3CHQ=;
 b=RxqIDrxn9HUzzIqOQkV/7RmLO8C0HQHL6BdzwWxbXVlu0t3R1fDECEC/nrsUygyoOW
 fv1znBmyM2AaIZO18LgC7/6ThX5VKaoydo/ewgWEKMEHrK1mjn2m3dTqiZiThMBMdtUu
 kAtXQBVgibyWGrG/4OF2OovSsA1MaX+ugRQK9yKf5rz5lbVdIcGN95g5SYjXf1QE1c8d
 pB47kDn4Rsr3vYdqDFFYkeN3ekC4XZFjPvxwkAZQ2CX6qmS9gqHBU5UGk3Hz3ju4PHFP
 6hsfteZVoBuJivlNppKgc3LmHkFxa4IaSC4GtTkUfmLr4K5XreQWnr4ir5mYUigvH2ZC
 GpuQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8ySIHUHnGIo5qmINQDYVhKD3+P9WVYoEzvXHZc8kwBotOA8oz9IjvozZpy6YtJT7dDR3/PhuyXTk2E@nongnu.org
X-Gm-Message-State: AOJu0Yxcpp7mxhTrQ6FgfK7cDQxqysT1T5ifEKNhiBpcUw7gNqx654j0
 fUX4Ieq1Suss55x462CMMbJPeL4LFPhEuSgEUJmWa30ZRPAms6yFA5XTnj92X4X21bvH2WX3bqg
 UrPKdxV+XKZXdZLbYai2EVuFuDve7Qr5ckIF7YtgY3A==
X-Gm-Gg: Acq92OFuLZpM56Tow8GrTwzOq5ApaKB+bW0ajQh2tzvq7XldLyu7ysunmEz51F/6eZG
 vR1QdNQ4xMvFEXD93IlWW7pu0z1OYP6LeeO7qcAg96LpB6hYzZp2PpVxwTl0r2BB3/gd4WohEYV
 Kwk2cNYkpnG6jAssUj63LQ+V8TRjKbV0IzJGBfPOsYLa7Qh5ZcTqQnj8HmdqnXy3tpPt/m/EtlB
 6vBXuGb3ge+tKVypw6WHGtK0TA+0GRDhOgcF3aZ1pptcSY9t7nCWt4pmqaFj8wYPHV5aDnbw0sC
 yYCD9KniMwpAPfI3mLBEEjWO6LOKkxyS1EaywUAqEQZKUqhq98z0q8oGt9rhSMg8L3i6vaT8156
 tYA==
X-Received: by 2002:a05:690e:1556:20b0:64e:f106:60e5 with SMTP id
 956f58d0204a3-65e2289734cmr3569042d50.52.1778855543766; Fri, 15 May 2026
 07:32:23 -0700 (PDT)
MIME-Version: 1.0
References: <20260515131245.366240-1-peter.maydell@linaro.org>
 <ecc4b7e9-aa28-4951-82e0-5eaa6e98e642@linaro.org>
In-Reply-To: <ecc4b7e9-aa28-4951-82e0-5eaa6e98e642@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 15 May 2026 15:32:11 +0100
X-Gm-Features: AVHnY4Ieo5RV698XXK8sus5pmlCc5Zyq2a0eY_FqNHBtFpSRS0enllMpY7ryhmo
Message-ID: <CAFEAcA_y9y+XTtUH9R437Ju1U=QNr4fzHVS1c0f8q3GSvdZDxQ@mail.gmail.com>
Subject: Re: [PATCH] target/arm: Set debug in attrs in translate_for_debug()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b129;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb129.google.com
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

On Fri, 15 May 2026 at 15:17, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> On 15/5/26 15:12, Peter Maydell wrote:
> > The translate_for_debug method is supposed to return attributes
> > that include the debug flag being set. We forgot this when
> > implementing the method for Arm.
> >
> > Fixes: abefca8e7f957 ("target/arm: Implement translate_for_debug")
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> >   target/arm/ptw.c | 1 +
> >   1 file changed, 1 insertion(+)
> >
> > diff --git a/target/arm/ptw.c b/target/arm/ptw.c
> > index 8706dd59dd..0693d2867e 100644
> > --- a/target/arm/ptw.c
> > +++ b/target/arm/ptw.c
> > @@ -3961,6 +3961,7 @@ static bool arm_cpu_get_phys_addr(CPUARMState *en=
v, vaddr addr,
> >           /* translation succeeded */
> >           result->physaddr =3D res.f.phys_addr;
> >           result->attrs =3D res.f.attrs;
> > +        result->attrs.debug =3D 1;
>
> I missed that because thought we'd set it on success in
> cpu_translate_for_debug(), but we only do it for the fallback
> case. Shouldn't it be safer to set it there instead?

Mmm. The idea of the method was "the implementation
should set the attributes entirely, not set them partially
and then have them adjusted by the wrapper function"; also
it's a bit confusing if the semantics of the wrapper function
aren't the same as the semantics of the method proper. On the
other hand, it is a bit of an easy mistake to make, so the
API as it stands is a bit bug-prone.

> Otherwise I'd expect the bit set in arm_cpu_translate_for_debug().
> not in arm_cpu_get_phys_addr(). WDYT?

I went for arm_cpu_get_phys_addr() because it's this
function that sets ".in_debug =3D true" in the S1Translate
struct it uses, so it matches that it also sets the
attributes to match that.

The arm_cpu_get_phys_addr() function is a bit misnamed
by this point -- it would probably be clearer to name it
translate_for_debug_for_mmuidx() or something similar,
since it's just a helper function that has the same API
as translate_for_debug() but takes the mmuidx to use.

-- PMM

