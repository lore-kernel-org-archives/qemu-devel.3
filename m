Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CA9DC88E6F
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 08:35:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkI3s-0007Yd-Ro; Mon, 26 Jan 2026 03:35:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vkI3j-0007UM-EW
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 03:34:58 -0500
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vkI3e-00052J-5q
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 03:34:53 -0500
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-64b92abe63aso8670288a12.0
 for <qemu-devel@nongnu.org>; Mon, 26 Jan 2026 00:34:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769416480; cv=none;
 d=google.com; s=arc-20240605;
 b=PrbbERRsW4o6lwDLomG2v/ZexH4RCaouXZ63FPf7j241e7bza9hMFUGHyJ5eUkhJP0
 iHlQioU0llGy2Cwzm73lr0zf5Q0fTLVAeFGCUaUTFsnIkOsfH9F5oolkRVUb9/Iy7m/F
 JfjLct+qfACXZckhalFDXeFwmrElv2Io+Zqxkut04O3Dt2KAxO+SpRDasxe3a9jnka25
 R/XX7sdHbcvXk0KwIakjtJEegorqX8CXYUJn88w3Qkuglhcb07wy+Y99bRoQkdMV2hW9
 IAMEB/Noe3paIbNQHWopATqrXG8I5TF7u4/rDlllUN84afShxoF+jeWkjeUQDYOX7+Ab
 5isA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=4WaAUg615YDe5MZ5SihLXAqXTIq1unnYqTXdXS19mdk=;
 fh=AMHjAAIreceBwoHfQdFz3eiXQHXOUNgH8A7tcGIok3Y=;
 b=UXhtFXZUf5nyDVCM0TwUkTUmtY/wSKn4p3/UJc7r0yCQ82rq/xh/LprbeyUpHKNo8C
 0kq+wyo4FssgZLWp89X12d+9sLi+4Ix8pm++hQ1SxAxXzXATQ5UQVXraJU8BpHtEQmyj
 j9H1VNkmMwhyDE/ovpgBo/8EHDuNXV6MdeWaSSJZos43fpMdqSjIxuFGwCM/XlC0D+Vm
 p9QcPLM51MBDKCZOwqTNGO3vgWTPdjdllkpU/GaiQN3qFaGEWlgL6zs1lV45Cdx7Yg4k
 mPeJXGn9QplGlE+EpgoqVDV2jFASxKB6VWSjq6GrulYuRSA/HW/0GgsopK1UpT7oXDeN
 tbhw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769416480; x=1770021280; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4WaAUg615YDe5MZ5SihLXAqXTIq1unnYqTXdXS19mdk=;
 b=oFavd+5jRVvavEd7N0gniyPNGRpKBKMUV27Z8d4UOhEHhzG6XMTJ0jLeJD8jE1FFHP
 DfeB7e4SbD7fUO8sE0dI8StI92IEl/uBCcsz5bcWdTfirjuEQhukmS5p12IbVgXSxuOa
 3kugrpRkW/9In+Sbb4psyueEOiibz6KxmqcKh6BBRch8wpxRcEQYoQkyn7cdeoQPTaU3
 TGSMS8OxeRxA2Yj0Kx+Z5OxfyFighI+zcd9WX6nho1rzt7b5Aud9vhRFq3Ttgwg329Gs
 dbJB0xMO4zXTPWvskUQ+TCG5jxtlPrjkqJu+PVX64VF7aIFoI9AiL6PMiz8JwNj2D3dk
 YuLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769416480; x=1770021280;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4WaAUg615YDe5MZ5SihLXAqXTIq1unnYqTXdXS19mdk=;
 b=Khpmt7BUf9T+CqQ2xI8lo1y90JJs7nl36YaqVdXJbOEzmYf8lAX2spBGRu5XHfIfGw
 ySnMbAS/LobWIYQifwcSQcQVfz3v61sAPmdewS62L0TwSJtm/nmpXDbKLoeQA1FJ9zld
 FUpMEYs0/N1BgtPJfUPRlyJLrRrF6tj+Q00ixsx+X4TfbXimicyO44yK5vZ6KEJaBSYA
 z7gh8dVnhMvaPy7MJWbzoO3T9P1Oy3ctc00SCgs7WDqf01d57hhALv+fhn9LKMstsmXI
 B+2y+ci1UmIfZYOdSNleFj7AOEgXkYSluEDaMa4+SCS7NfcERUHwZ4Ep/qU8E7UzaVWy
 mN5w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVro4RuutNledULu6v0avBWlUNJrRza2QsBjdzGxj4WoV/gW6n8RfbZiSKOlbDe7E18jMcPViRfnACa@nongnu.org
X-Gm-Message-State: AOJu0YzxhYJ1FabE4ASWJyKOL4buvGjgaEBrAdcnUvNSApa6ug4bruJx
 hWmaQxtvQVmba00mCJLLrN02J7zCK/wNpX08w2mkQC6S/BknCZ+U2aGupq3aWqkUkrIeWcF8vN6
 pIXXebKC7m/tsM+5d69K3mIafnlWgkIfUxACHD8yP1Q==
X-Gm-Gg: AZuq6aKKFYOJOowkrKXfhpZzr7T4t6RqCI3byfyEWkWCi/JjKwlcbhKP4csII48J73f
 m+B557hdV+AjBjB0L4tTmfKiX9LNzjSEkiuJ4pl8KZPmK1keW4t1C0DX6PvSTobev1VCOVg8DIu
 +M8V0gxSschTeN5rFs0zPEgEdbCyCRUV6VuPy8zrlGIKFyoKiulUFE+M1PLSA1ARfSVf1BJzy9k
 yKm8zkGWMMrIyQyvxpwhOV7AhUZ2VdkipKh3Kg60w8LB3KYVyIkhhvTJvvV9AIBFbbWlqGGzPTa
 SQVGvZlLEW08TcXJSzurxtTgHJOu0ynvyO7N
X-Received: by 2002:a17:907:980a:b0:b87:5c45:b884 with SMTP id
 a640c23a62f3a-b8d2e6eba39mr297062766b.31.1769416480168; Mon, 26 Jan 2026
 00:34:40 -0800 (PST)
MIME-Version: 1.0
References: <20260115-sme2-hvf-v2-0-2eca481bd7ee@linaro.org>
 <20260115-sme2-hvf-v2-2-2eca481bd7ee@linaro.org>
 <2c3bb870-0321-4799-b7ca-65b2772ddf2c@linaro.org>
 <CAAjaMXabRsOX0OVXN202ev3A1sKqMmbDoeY6n7Z-EhmZWmL9Cg@mail.gmail.com>
 <CAFEAcA9oZ=rhUbw8WK5nUPAvs0TEPCJB8t8ReeViv=0b=_x-sQ@mail.gmail.com>
In-Reply-To: <CAFEAcA9oZ=rhUbw8WK5nUPAvs0TEPCJB8t8ReeViv=0b=_x-sQ@mail.gmail.com>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Mon, 26 Jan 2026 10:34:14 +0200
X-Gm-Features: AZwV_QgQZ5V7YA0BUIYlHACKT8EhtDWS5L0oqZZKBabFd03g63P7FXLHRChLp7Q
Message-ID: <CAAjaMXZLG2aBtStRhyvmdENj1Z+Mx05BmDgyYUoYrc_ZnHwyVQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] hvf/arm: expose FEAT_SME2 to guest if available
To: Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 Alexander Graf <agraf@csgraf.de>, Mads Ynddal <mads@ynddal.dk>,
 qemu-arm@nongnu.org, Mohamed Mediouni <mohamed@unpredictable.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x533.google.com
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

On Thu, Jan 22, 2026 at 6:52=E2=80=AFPM Peter Maydell <peter.maydell@linaro=
.org> wrote:
>
> On Tue, 20 Jan 2026 at 10:02, Manos Pitsidianakis
> <manos.pitsidianakis@linaro.org> wrote:
> >
> > On Tue, Jan 20, 2026 at 11:50=E2=80=AFAM Philippe Mathieu-Daud=C3=A9
> > <philmd@linaro.org> wrote:
> > >
> > > On 15/1/26 12:20, Manos Pitsidianakis wrote:
> > > > Starting from M4 cores and MacOS 15.2 SDK, HVF can virtualise FEAT_=
SME2.
> > > >
> > > > Reviewed-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> > > > Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> > > > ---
> > > >   target/arm/cpu.c     |  4 +++-
> > > >   target/arm/cpu64.c   | 13 ++++++++++++-
> > > >   target/arm/hvf/hvf.c | 25 +++++++++++++------------
> > > >   3 files changed, 28 insertions(+), 14 deletions(-)
> > > >
> > > > diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> > > > index caf7980b1fc5244c5c2f130e79ba869456c20c88..7f4ebfdf61217db6075=
495119c1b642bc2abf295 100644
> > > > --- a/target/arm/cpu.c
> > > > +++ b/target/arm/cpu.c
> > > > @@ -1577,7 +1577,9 @@ void arm_cpu_finalize_features(ARMCPU *cpu, E=
rror **errp)
> > > >            * assumes it, so if the user asked for sve=3Doff then tu=
rn off SME also.
> > > >            * (KVM doesn't currently support SME at all.)
> > > >            */
> > > > -        if (cpu_isar_feature(aa64_sme, cpu) && !cpu_isar_feature(a=
a64_sve, cpu)) {
> > > > +        if (!hvf_enabled()
> > >
> > > In my experience "if(!accel)" is bug prone, maybe change to explicit =
"if
> > > (tcg_enabled() || kvm_enabled()"?
> >
> > Shouldn't we list all accelerators instead of just tcg/kvm then?
>
> This "turn off SME if no SVE" check is principally trying to
> avoid users hitting a bug / missing feature in TCG where
> it will assert on startup when the guest tries to write to
> SMCR_EL1 (see the backtrace in f7767ca3017's commit message),
> because we accidentally coded in assumptions that any guest
> with SME also has SVE. We turned it off for all accelerators
> because (a) at the time there weren't any others which had
> SME support and (b) we didn't do the investigation to figure
> out if any of those bogus assumptions were in code that's
> not TCG-specific. (In our defence, it was just prior to
> a QEMU release :-))
>
> To the extent that those accidental assumptions are in code
> that you can hit with HVF, we need to fix them before we
> can enable SME-no-SVE in HVF. To the extent that they're TCG
> specific, the only accelerator we really need to turn
> this off for is TCG. As the comment notes, right now
> KVM doesn't support SME so it's impossible to get here
> with SME in the feature registers.
>
> If the core code is OK for hvf to enable SME-no-SVE,
> then it should also be OK for any other accelerator
> except TCG.
>
> I don't think hvf can get to the smcr_write() function
> which is the specific failure we saw with TCG, but
> I think that it ought to be possible to end up calling
> sve_vqm1_for_el() if you use the gdbstub with hvf
> accel, get the guest into streaming SME mode (PSTATE.SM
> set), and then read the "svg" register that gdb uses to
> expose the vector granule.
>
> If giving the SME registers a good workout with the
> gdbstub interface all seems to work fine, then I think
> we can adjust this condition to be "if tcg_enabled && ...".

gdb had a disastrous workout, because it turns out it also assumes SME
must have SVE:


  (gdb) target remote localhost:1234
  Remote debugging using localhost:1234
  ../../gdb/aarch64-tdep.c:3068: internal-error:
aarch64_pseudo_register_type: bad register number 160
  A problem internal to GDB has been detected,
  further debugging may prove unreliable.
  Fatal signal: Abort trap: 6

"register number 160" corresponds to pseudoregister regnum
AARCH64_SVE_V0_REGNUM. Looking at gdb/aarch64-tdep.c, it seems they
are only supported by checking against `tdep->has_sve ()` [0]

Peter: So what do we do on the QEMU side? Merge it and wait till
upstream gdb fixes it to check for bugs?

[0]: https://sourceware.org/git/?p=3Dbinutils-gdb.git;a=3Dblob;f=3Dgdb/aarc=
h64-tdep.c;h=3Df1bdce453db27dffeb42f10fcd44a408f706afb2;hb=3DHEAD#l3116



--=20
Manos Pitsidianakis
Emulation and Virtualization Engineer at Linaro Ltd

