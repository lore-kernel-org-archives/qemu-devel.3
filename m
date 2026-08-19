Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0424C5DF7D
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 01:03:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwUiA-0002lp-67; Tue, 18 Aug 2026 21:03:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1wwUi9-0002lH-2t
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 21:03:21 -0400
Received: from mail-lf1-x130.google.com ([2a00:1450:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1wwUi7-0004qO-6X
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 21:03:20 -0400
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-5b00d083818so1595120e87.1
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 18:03:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787101397; cv=none;
 d=google.com; s=arc-20260327;
 b=UomLoXClVCGZohRQX9FTVwrqfX24mINEKLkWy8mTcgMhbLXpYG09QdeoC3p5CEkMRt
 e9+gKnaTlp2L4p3o9DdWESBv4R5Gwa25TYbNu52OMACYUR/qNd85256YIADWDxTcRJ81
 s9APK0s111JUD+rZFtX/S+hyB0jDLqEV8wx9YputCZ7bYQL6yBYQn+d4cYHrdmngRqtL
 vegK34ZQ+GY84XYfRZ7f64enXiz7JPK9ePDenpZvDwN6gMh7GRQ8y6e4KePAJ1dD6VVB
 8VJR1l9A+SVPdC0X8oUbvbexSuaQKfBEChlRvcDGcLw145zxww2t0BVkZjlwwu5s7/Uk
 MLKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=tcyXj3slw+9LNaA+Q+y/YGlDuPCA73toAqaQW+276AU=;
 fh=8UOH4AHvZC4rFsZAQeMwwmDe4armg/T3iUxfBxUk76o=;
 b=sZ0GeGxoBQm/7RKvP+2LxnYopn28TOOBzFbrfQ7iENoLXRL0hWxAz0+KYqaWyxIeo5
 xp0UcSAk3YAb/LNaPrxDVneGbz88RVlv724mVkc9o1O3DTkPmG6Fkcs029Vz2EoHkxdy
 MJEv4zccUrKOliK67RKg5pzpkOU/F9ijZAopKUyhyPTBTqAfv/GMW3pr0b1SAiPCgvTN
 gsLTGpvB0jd9rTSQ8lYrGm4tHgtTSOkttF4uHfz9oWf79XCoNGikjRtT+aqC0NT4r206
 F3mcHlw2mYyOplNXmuc7rEGBB44d9xlTBIB5mHd1OAp2Ik5CiL9Ed9bbI2n/M5F8hj2q
 6jiA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787101397; x=1787706197; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=tcyXj3slw+9LNaA+Q+y/YGlDuPCA73toAqaQW+276AU=;
 b=fyLU1cSGRnXYS8vPs6z2ihR7Wd1EAHDIuCCRRp0DQWLfxMGsXdCFrshigsud7zs/Nc
 YcyV96DBUFe4H5EA86VGKvZL6yztD0rRTuixY9/L4VY92L8AA3kmnKw0RP78W7AOREvx
 Xm8j2lWmE5ZFsE400sEO2zfptsJU7g76Nv9QaYyfJuRS0pLYjbHlyuIXnbI8LtwZUIC7
 NFKLXrkFGd5sOMPst8txzVc233RAGNOjUrsJFQbSlfHP0Xw5wskVZlczX6UChOmM7cd5
 YiLQfpHTwQapX+jZw8O1lSQTHHBJfVjPpq+CGFJWlm8fTdn9If2bKVq5SESbsLFrgr9b
 0LIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787101397; x=1787706197;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=tcyXj3slw+9LNaA+Q+y/YGlDuPCA73toAqaQW+276AU=;
 b=GRIPbBcZjFbrTVENA3a9kS4b6AF6ztSB/0XQjfP02Ew1GTTodeie7D9Q7H9C1JWIVH
 niDcYQbPFHlWbAqmntfD71GNoI1M1GISQ16ss5yAEQLGyXmN9NKUND0mb3ZjU28A+vAq
 Ct33bIXs7MslEMkJHt3yTETNUch1VhWa5s3WjWw4CsqiKUScCsPoeHKfIU4fskrwcC8s
 WOtzYaT6Rfawd8yygh0e7px1LSgaN+NhcExGZ7MVpwYUWxa/xdzd9WsIR1iaHgl7Ad3s
 Q+Ijfy0GTTNXWSrbpA/JU3uTFol8vUuPJQ7eNRWtO9bqxJwEZ0e1eTSpMLW+as477ZaZ
 Ltfg==
X-Gm-Message-State: AOJu0Yyjig/J5MMnr1O0F7JjlenRN/Lg4sL9sHLnG3XyspFJM1mxnLzo
 4Y/ZPnaQqDHRY7ONdc8f+7nlL3/emYUMlBDLIWx1JAtn+oHqfrcluZLaQMeEdI+rdBigy/ErPio
 zcNCDuUxOJyY980mzWXNB5Lh+olTu7Sk=
X-Gm-Gg: AR+sD128cWZxF9bSCOFM39EZfG+EXFquLCrH/vmXdHf0vBfaPix6gwwbrDBrYgHZ+J+
 BUVqwSVWXEmcxq12TJdB2XNrCqC9S7beMDkOGm6iVu6TWkLynaYmG5ioE5F+5uM6yFzanxrdab/
 DRQuO7GiQNUdYvfB8UWQCOXm1HpmAysWuw7//3wNHc0wr8QaI3SAaIK0JPNzmtM1jTPcSF+iUk4
 ygIzIiBU17I9eOb7+bsTf2QSDKEwzDkoBj5CjwvfA58gkOvbXXlOp+L1yIoEGs4oE/iRFwF2KmD
 ZLvRU4W0JiMcGXwhvKp9UiO4/YKFlhjp2HqMEaVLXACvBPeLiWO5oDWO8F7IlkR4Wmjb30dxIEU
 g3lg=
X-Received: by 2002:a05:6512:3d25:b0:5ae:d72d:1000 with SMTP id
 2adb3069b0e04-5b478654fbbmr242523e87.1.1787101396766; Tue, 18 Aug 2026
 18:03:16 -0700 (PDT)
MIME-Version: 1.0
References: <20260818174247.649526-1-mattst88@gmail.com>
 <20260818174247.649526-5-mattst88@gmail.com>
 <06475A33-3AC6-4D58-83D3-0176D0880E20@unpredictable.fr>
In-Reply-To: <06475A33-3AC6-4D58-83D3-0176D0880E20@unpredictable.fr>
From: Matt Turner <mattst88@gmail.com>
Date: Tue, 18 Aug 2026 21:03:03 -0400
X-Gm-Features: AcwNN1UOG3mSxjykVw7c1QTsR0jCDI7wnPEDVvgL1x2NlP2OQF-28N2J9mUgE7k
Message-ID: <CAEdQ38HOp5ze-6dU9NpVePk=F2w6vK4pNoabnpwHO778HY3BDQ@mail.gmail.com>
Subject: Re: [PATCH 4/8] RFC: tcg: probe the TB jump cache inline instead of
 calling a helper
To: Mohamed Mediouni <mohamed@unpredictable.fr>
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org, pbonzini@redhat.com, 
 philmd@mailo.com, zhao1.liu@intel.com, laurent@vivier.eu, deller@gmx.de, 
 pierrick.bouvier@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::130;
 envelope-from=mattst88@gmail.com; helo=mail-lf1-x130.google.com
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

On Tue, Aug 18, 2026 at 6:27=E2=80=AFPM Mohamed Mediouni
<mohamed@unpredictable.fr> wrote:
>
>
>
> > On 18. Aug 2026, at 19:42, Matt Turner <mattst88@gmail.com> wrote:
> >
> > Every indirect branch that cannot use goto_tb ends in
> > tcg_gen_lookup_and_goto_ptr(), which calls helper_lookup_tb_ptr(). For =
an
> > emulated compiler that is 8.4 billion helper calls in a single translat=
ion
> > unit: 24.6% of all TB exits take this path, because jsr/ret/jmp have a
> > register destination and because goto_tb is restricted to same-page
> > targets.
>
> Hi,
>
> In your testing set, how many of those indirect branches were returns?

Instrumenting things, here is the breakdown:

                      count   of jsr-family  of all indirect dispatches
RET               3408529228    46.7%          40.5%
JSR               3377155399    46.3%          40.1%
JMP                514369861     7.1%           6.1%
JSR_COROUTINE              0       0%             0%
jsr-family total  7300054488                   86.7%

Total indirect dispatches were 8422264155 (8.4 billion). The other
13.3% are non-jsr `DISAS_PC_UPDATED` exits.

So returns are just under half, and calls and returns together are 93%
of the indirect branches. The workload is almost entirely call/return
pairs, which supports the return-stack idea rather than against it.
But at the series tip the inline probe hit rate is 99.60% (8388942817
fast / 33321338 slow), so a return-stack would be competing with an
already-cheap path.

> I=E2=80=99ve been (very slowly...) hacking on something adjacent for bein=
g able
> to leverage hardware return stacks, although it showed an exceedingly lar=
ge
> amount of issues - especially around the maintaining coherency edge cases=
...

Hah, I started by going down the hardware return stacks route initially as =
well!

> Your patch gets a lot of the way there on the perf side without a number
> of the issues associated with that.
>
> >
> > The helper itself is already tight, but each call pays for a call frame=
,
> > the can_do_io store, the get_tb_cpu_state() indirect call through
> > TCGCPUOps, curr_cflags(), and a breakpoint check, before it gets to the
> > jump cache probe that almost always hits (95.8% for this workload).
> >
> > Emit the probe inline instead. The destination PC is already in a TCG
> > temp, and the flags and cflags the destination must match are constants=
 at
> > translation time, so the fast path is a hash, three guarded loads and a
> > goto_ptr. Only a miss calls the helper, which still owns filling the ca=
che.
> >
> > Two details matter for the generated code. The flags and cflags guards =
are
> > folded into a single aligned 64-bit load and compare, since the fields =
are
> > adjacent. And each path emits its own goto_ptr rather than branching to=
 a
> > shared one: a temp live across the label is spilled and reloaded on eve=
ry
> > dispatch, which cost 6.3% on its own.
> >
> > Measured with qemu-alpha running an emulated alpha gcc 16.2.0 compiling
> > the SQLite 3.45.1 amalgamation (255k lines, -O2) on an x86-64 host, LTO
> > build, on top of the preceding three patches:
> >
> >    before: 1,402,816,253,499 instructions
> >    after:    890,713,633,237 instructions   -36.51%
> >
> >    before: 115.75s wall clock
> >    after:   84.44s wall clock               -27.05%
> >
> > The gap between the two is the point at which this stops being a
> > straight-line win: the helper call was highly predictable work that the
> > host pipelined well, so removing it retires far fewer instructions than=
 it
> > saves time. IPC falls from 2.48 to 2.15 across this patch for that reas=
on.
> >
> > Despite emitting more code, this also reduces instruction cache pressur=
e,
> > because a dispatch no longer jumps into qemu's .text and evicts transla=
ted
> > code:
> >
> >    before: 11,476,318,964 L1-icache-load-misses
> >    after:   6,990,186,701 L1-icache-load-misses   -39.1%
> >
> > The mechanism is visible directly in a profile: helper_lookup_tb_ptr()
> > falls from 30.97% of samples to 0.42%, and qemu's own .text falls from
> > 38.9% to 5.4%, with the balance moving into generated code.
> >
> > Combined with the three preceding patches, against an unmodified LTO
> > build, 1,647,901,588,726 instructions fall to 890,713,633,237, or -45.9=
5%.
> > The emulated compiler produces byte-identical output throughout.
> >
> > Open issues, hence RFC:
> >
> > - The flags/cflags guards use the *current* TB's values as constants. T=
hat
> >  assumes the CPU flags feeding get_tb_cpu_state() cannot change within =
a
> >  TB, and that curr_cflags() cannot change under a running TB (gdb
> >  attaching to enable single-step would). Both need to be established or
> >  the values need to be loaded at runtime.
> > - tcg/tcg-op.c has no business including accel/tcg/tb-jmp-cache.h or
> >  knowing the CPUJumpCache layout. The probe likely belongs in accel/tcg
> >  with a small emit helper exported from tcg/.
>
> I don=E2=80=99t think that one is a problem.

I think you're right. I've updated the commit message.

