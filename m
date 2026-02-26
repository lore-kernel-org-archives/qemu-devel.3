Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ADFCFC5926
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 10:49:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvYvL-00027x-HX; Thu, 26 Feb 2026 05:48:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vvYvG-000277-6x
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 05:48:46 -0500
Received: from mail-yx1-xb12c.google.com ([2607:f8b0:4864:20::b12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vvYvD-00007m-Q5
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 05:48:45 -0500
Received: by mail-yx1-xb12c.google.com with SMTP id
 956f58d0204a3-64c9cabfe5dso860626d50.0
 for <qemu-devel@nongnu.org>; Thu, 26 Feb 2026 02:48:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772102922; cv=none;
 d=google.com; s=arc-20240605;
 b=Z7Rj0Cnp/NrRv2WjLimyisvOdnb5A8IgazOVmuhiD4uLpEKLPe+kkiJt8Ksx8aUkk+
 a1ypvfG8URlojJWT8toVRiFCX5mS3rEN4WEf5Y6DJcfcp+FYb14Xcnkc/AB1PxPDIpMe
 llha94RxztK6Wi7bpgEuWziQr9/46Xn4oEaDdLu3V1z9MUyiOcP8WP6OonBBB8E8zIkR
 ZJO7JrM6dSipfq8RplKOPf7LGp5nM5Lc/7N8Xejl7ERkvJIec+cMTHZBZWEflevXUV2H
 07aMD6LGPhnWBAMkjFYjiogOFOaXQ/Volr7TJDC8TBTM8Gj7Po74ecRL2sa0/GSKsgzj
 gKbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=g2ltcvxTAmF77I1gesFS7URxAh0g7MseFZN4w+qgzbg=;
 fh=qDEitYY2TPRRMZ4OARbMiUT09q8rCCMKzcZWPtML1Tk=;
 b=kYq3+Xgx31kpTC6d7moBgF0qE8tEoVsaTinCLRV9thvqvbrMsXm3WgVfspBfTbEYUi
 7p7gOOh3ljBNCQ0MXpk4hgTRB3ZWcIhIVqwKMtnLUdzoCIY3lf8S1QmUUOzLIN2E4uHv
 6SH/HQRqLzMVP+3Ftrx9oF85ry0er35K8SFylr8JLZmIADOuDsDABBqXNdo+8E4i1FRp
 S53Se7m9gaPrI02i+7n1BLGMtGzPgvcUs3DaLac3AiBtUN+3r5LfDL8zBVP1/pQrrjcK
 yX/4kZ0mDSCesAZNVnQsFQE8dJoXP/Wscwn9ZhlsXsab23cg5D/KlKoDTDpNYoIwTk1P
 yHvA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772102922; x=1772707722; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g2ltcvxTAmF77I1gesFS7URxAh0g7MseFZN4w+qgzbg=;
 b=Njzgj7zb+WfDkNngT4dLf0uEoiA24Va0aDSfLMLplFD83b2omSgGzg6iGAVucxH2Ot
 FWXYyJrbkkY7ioc74zJ5QcYrv2KkfoiHpOvqVNMo6LVv2GEw4v/diw4TtQQDLi8FMhzJ
 ZXTNZg2TO9kv+b1JOjIZbQUiAnzJ0UqFhTMe/wgGNgIG5/KdpHWRIDkbiJCS2YppAoT7
 7RmNF5xvKuiVpKQwq3/tZoNN/Oo01erYemFa57GB5Jxs4i3FdwK6J8EFqIfqP15a2t6C
 z6MEGUJaYikN/KsaJ41clOT4v/pir0EYq5YLHcHvSnoNGvkTmqozhLldZOm04yH3cTe2
 WkDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772102922; x=1772707722;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=g2ltcvxTAmF77I1gesFS7URxAh0g7MseFZN4w+qgzbg=;
 b=XIgzfw0g3OdgvyHYDLdsFvglsjHCZ0oORNRRvwtpU0XAb+fBCZiNKcPuTyIxD0Kcn6
 4qQg7NAmAvZBRrkfecPlgpCaYbXb1NR7fZiLPUqhyY5NBeJfWCx1+XoqEWoqSwVsOPev
 CziwnTH6n0s1UNo0mcVZxF9v8B3YNUyuVsHtPDWI4eUHB00Eac/PozwNFK04v6I9xKYt
 nku4/NQowI5pQBGSx9NPV5WlqGqsTW8l4UqBhOD0yLdVNw6dBxPt4bGBYk4Rsrm43R1O
 wRy1TGQcQJDSOil9AJrUJBeDmmKCVbkkh2c70qHAj2UYpSdawTPvCfaDZ10ylsdCDZ5H
 3qQQ==
X-Gm-Message-State: AOJu0YwEE/ft1ooTPM+kCZY5gtcBmCOAHl9d9t2v3ikrzsyro+1dSkqW
 enGcvBGGCF2jS6Nqd3DnjTBAPVPac4s5Yt9DfkB2fADWqqUDrvXqIaK6QXORqDefeT5JPMECZuO
 M7AbHHY3FC3zcipr0oH16zEeVXpsOYNuj5lONqv1Ptg==
X-Gm-Gg: ATEYQzznKEobnw4Echq0lfzzTP7fItg42t9cAPtlmwbwLwq2T1uF3D7S6vUNuqd/907
 P+HDYHPL5n6Auv2KNKkfSVdIIWPZ4kM6rsuyKY8GKUuS4xT4ZZ6yfsVNYu13jHf3/cr2iJoAnIg
 iQT5Q1L2osuKea1FfAO2JUlBq9syv7b7G0Le6zGPtqQW3jSPJO45Kb9oiF6+OV7oXDAGX/Ks4xR
 +rBoBkzrJN/N7czxWaN32GBo0iuzWwIzl0t5lVArG0kO+125vXO97wOB7fKfLtW/v8jckJcKGE9
 Yo5X+r/tMLOxda62UQmYs6TMbJs7g0g3SsiLaDBId7MFYy/x/RfmIqpGsdI90JnF11xHWK2vpRB
 P/w==
X-Received: by 2002:a53:d014:0:b0:646:9ddf:5f2 with SMTP id
 956f58d0204a3-64cb6f25486mr1391056d50.31.1772102922092; Thu, 26 Feb 2026
 02:48:42 -0800 (PST)
MIME-Version: 1.0
References: <20260224154347.344219-1-alex.bennee@linaro.org>
 <20260224154347.344219-4-alex.bennee@linaro.org>
 <CAFEAcA8km4H10ZseUd=D6KWTpHQptUaL0D3dSrg3-LGWY1bcgg@mail.gmail.com>
 <87qzq7ztdv.fsf@draig.linaro.org>
In-Reply-To: <87qzq7ztdv.fsf@draig.linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 26 Feb 2026 10:48:29 +0000
X-Gm-Features: AaiRm50idvpZ8JjyLmNCnolOP9F6qZU4igGPOX7Vi8CUtmePIRyXh9jCxhjWjIs
Message-ID: <CAFEAcA_zJEM7VH3U_2-FAvu=vjnwcY+qjnjzfY9UsCwwd=zqfg@mail.gmail.com>
Subject: Re: [PATCH 3/4] target/arm: pass rd directly to wfit helper
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12c.google.com
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

On Thu, 26 Feb 2026 at 10:33, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> Peter Maydell <peter.maydell@linaro.org> writes:
>
> > On Tue, 24 Feb 2026 at 15:43, Alex Benn=C3=A9e <alex.bennee@linaro.org>=
 wrote:
> >>
> >> If we generate an exception for WFIT we could also fill out the rv/rn
> >> fields of the ISS. To facilitate this pass the register number
> >> directly and read the timeout value in the helper itself.
> >>
> >> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> >> ---
> >>  target/arm/tcg/helper-defs.h   | 2 +-
> >>  target/arm/tcg/op_helper.c     | 4 +++-
> >>  target/arm/tcg/translate-a64.c | 2 +-
> >>  3 files changed, 5 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/target/arm/tcg/helper-defs.h b/target/arm/tcg/helper-defs=
.h
> >> index 5a10a9fba3b..a9a062cf777 100644
> >> --- a/target/arm/tcg/helper-defs.h
> >> +++ b/target/arm/tcg/helper-defs.h
> >> @@ -55,7 +55,7 @@ DEF_HELPER_2(exception_pc_alignment, noreturn, env, =
vaddr)
> >>  DEF_HELPER_1(setend, void, env)
> >>  DEF_HELPER_2(wfi, void, env, i32)
> >>  DEF_HELPER_1(wfe, void, env)
> >> -DEF_HELPER_2(wfit, void, env, i64)
> >> +DEF_HELPER_FLAGS_2(wfit, TCG_CALL_NO_WG, void, env, i32)
> >
> > Why the change to NO_WG ? The code change doesn't remove any
> > writes to globals...
>
> I thought that was the right way round - it doesn't write to any
> globals, but it does read so the helper needs to ensure globals are
> synced before the callback.

The default if you use a DEF_HELPER macro that doesn't specify
flags is "reading and writing to globals is OK" (it's a zero
flags argument). So this change goes from "flags 0" to "flags NO_WG"
and doesn't make any difference to how TCG thinks of its behaviour
w.r.t. reading globals.

I think you're right that the helper doesn't need to be able to write
globals, but making a stricter promise about what the helper does is
something that's a distinct change from adding the rn info to the syndrome.

-- PMM

