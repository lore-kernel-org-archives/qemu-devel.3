Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A7A3D3EE92
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Jan 2026 16:53:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vixvC-0005E5-VG; Thu, 22 Jan 2026 11:52:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vixv9-0005BG-TN
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 11:52:35 -0500
Received: from mail-yx1-xb134.google.com ([2607:f8b0:4864:20::b134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vixv8-000632-8p
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 11:52:35 -0500
Received: by mail-yx1-xb134.google.com with SMTP id
 956f58d0204a3-64931bbf70cso1185902d50.0
 for <qemu-devel@nongnu.org>; Thu, 22 Jan 2026 08:52:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769100753; cv=none;
 d=google.com; s=arc-20240605;
 b=befyr9Z0eOmiZOt1MpN3pVJlKKTfH1me6sOwOZrQdrjKtSEm3/aXw/u03OUJ4V9uZC
 p7IwagJXAZUd/6re9WsA6rDtTznDB88scF3zFkP3Bkp7elMzKP1A7QfgNHr6izlYrwBH
 hUzSyO9Rhb8nxmKRrQuymNBkY0lk2fw5bJHtLx/4YqWDsf0HG+YCcONtBJJcBH8tUU3W
 N/GGLt5R/HG1DJ8dHCT7ymVnjePREUpDZkPtjPNUv+oZ2B0h73gO8V66/t4HIhn/Qm8a
 qFPdQE8tFRJyZS3bbe8VfygXj3iv7gQ93wlCYmcfAVwMv4v8WyrzUKh+FQreGpkdB48S
 rOjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=qsZVW/IEZ7ENetSDJ6avqXo1llawnJIyHHSluA1/2n4=;
 fh=EwlT8Aht73btCDvtCDEGxjVyR0cABMrND/OMC3pGdmc=;
 b=IJBKXCRWNtRQBFKLW2Gc+tmZYoy+oOq3PayeFFTWrBAreZgZSNYc2ZhpTSgP7BvY9b
 hmtDlu6ExgCL49nYFTpAajBXQzj9/PiIvrCB6j1yjwXO7Ak1RsG5xnO+cEOoIn0VIKBf
 hwUABL/SsnA1oH+AxlvFbwPEjqBdOng90UK0wpXuriywK0xGYjB8xUFKaAWwElr4omge
 PyfMmRVYh7D8I40B8rEnifQt5jTbLmesWxGCW64ArJGCTFYyM6tl4/icopugGQJKnlNF
 jgQJFTEO98hW2KZszj9W3EKB6u5VmGWCuUrncSQzCXIl+DKySQ9B+oQ61em9lxC0xXGL
 5rpw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769100753; x=1769705553; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qsZVW/IEZ7ENetSDJ6avqXo1llawnJIyHHSluA1/2n4=;
 b=NCThAzKfRe2rCLRoyeEIwKoyuriRmWatnPwc/79BScggnGpLw4JsMmXCTFU66Ayt93
 bUtY1khXjZGfi5dWBboCO08iomzmNN8hrIko8lVht7Nlpr31Q1fiCKk+mVN5SC1+7h08
 outnPgaj2HRWiXg/mmphiPjDgj8XYxXj3aSdqjerECDDQBsiDC/Sy1xkYEyt8WeL7z7y
 U4OmtoiLgUDO+e4nRhFvcAx3kCKgp9ukMExniMtNI3x9q/f7qDqvkoP+owS/rmTDF0/h
 vl8J9AlsTIJ991/Qu6h1bhzjFPffxM7D33lpINlLNUblMVDRVDY3dHufgOacc/RU4Nqs
 t72w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769100753; x=1769705553;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qsZVW/IEZ7ENetSDJ6avqXo1llawnJIyHHSluA1/2n4=;
 b=u2PHmM3zL7kwrf3D6JWj7zZFCE0G3F3iktFFYXhjX8qSaL8mdhfUcsnxirwm4nQKN8
 sRempmgRq3/U+r8GHZN0G+p2GIaIKa+4WUOpQlsS3lQG5baaZUPxx7mDMZ8NrTxPD6py
 DLR6PvLQgItC7GjQ9iK1ubLPA+mRU5l+C8u/WG6cqvqkAE7lETGs34D1S+5Qseo4xJ/e
 JbvMH0VlTK2tLxjsYsOi4lQUtnfAwaHwnVgiiN+d+AvLlb05rF4m/H9A9g5t3pownRd0
 IPKtP8HeCq7f3XGoL8EDiZM7Z+JQRSARFW0WitL3+ymSB1wAAvuljjjcfcA6eRkOwU/u
 KpjA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWzT1HbVVIMYC5h6apWRm9pPeGX5nZNQVjeeBxFMYxVnXAR81kOenPnClXucFSy1A0O7Egn3BpKCEIR@nongnu.org
X-Gm-Message-State: AOJu0Yw0Xu843TCrPh1z8wD+whYBOA/ybAuvrByKVFJ089B1xCtIG1hd
 rQP15SxB0IfNJvaKbqFwEL7Ixvgf5iDGA9+tdw+UtLb+tRxKf5pWiqyFGWZuyAdHmJ/vrAXTas6
 noONn9pMgVPJOf2okk0hRZPLxQc07vHp8cxSKznzpLg==
X-Gm-Gg: AZuq6aLvDL88cT084HWN0Q5yBYDvnGDL9Fxgr1TWywccQ4lQfJSdAN3x60D9PchUTed
 u7EiT5/eeRO/E0/oqSrWyU91D+a7OUi4ZMhrc1cKdPMUEgReFhmXOuDasvCTD6cxAzVasT26n3r
 DVJjLBno1BZC0Qc3oQqwW9xXkMbzKd1uG4NEntZchJiYwy7Yhoffhc7C5p7d+MoE1hdx+iLliJW
 kV4KvKz6bYb+F5c+rEqQ5K4TjCjdEQ1T42m2fnvJiWGz9VzASRgrpMVUxMbmjOKWj/jBQ==
X-Received: by 2002:a05:690c:4986:b0:794:3be:f956 with SMTP id
 00721157ae682-79439a0c42dmr2323457b3.69.1769100752859; Thu, 22 Jan 2026
 08:52:32 -0800 (PST)
MIME-Version: 1.0
References: <20260115-sme2-hvf-v2-0-2eca481bd7ee@linaro.org>
 <20260115-sme2-hvf-v2-2-2eca481bd7ee@linaro.org>
 <2c3bb870-0321-4799-b7ca-65b2772ddf2c@linaro.org>
 <CAAjaMXabRsOX0OVXN202ev3A1sKqMmbDoeY6n7Z-EhmZWmL9Cg@mail.gmail.com>
In-Reply-To: <CAAjaMXabRsOX0OVXN202ev3A1sKqMmbDoeY6n7Z-EhmZWmL9Cg@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 22 Jan 2026 16:52:20 +0000
X-Gm-Features: AZwV_QjvNF304hk13w96i1-MPw2CpXaJV7RH5m-YdyJFlzFxyvaIKYFuJJKmbLQ
Message-ID: <CAFEAcA9oZ=rhUbw8WK5nUPAvs0TEPCJB8t8ReeViv=0b=_x-sQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] hvf/arm: expose FEAT_SME2 to guest if available
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 Alexander Graf <agraf@csgraf.de>, Mads Ynddal <mads@ynddal.dk>,
 qemu-arm@nongnu.org, Mohamed Mediouni <mohamed@unpredictable.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b134;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb134.google.com
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

On Tue, 20 Jan 2026 at 10:02, Manos Pitsidianakis
<manos.pitsidianakis@linaro.org> wrote:
>
> On Tue, Jan 20, 2026 at 11:50=E2=80=AFAM Philippe Mathieu-Daud=C3=A9
> <philmd@linaro.org> wrote:
> >
> > On 15/1/26 12:20, Manos Pitsidianakis wrote:
> > > Starting from M4 cores and MacOS 15.2 SDK, HVF can virtualise FEAT_SM=
E2.
> > >
> > > Reviewed-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> > > Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> > > ---
> > >   target/arm/cpu.c     |  4 +++-
> > >   target/arm/cpu64.c   | 13 ++++++++++++-
> > >   target/arm/hvf/hvf.c | 25 +++++++++++++------------
> > >   3 files changed, 28 insertions(+), 14 deletions(-)
> > >
> > > diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> > > index caf7980b1fc5244c5c2f130e79ba869456c20c88..7f4ebfdf61217db607549=
5119c1b642bc2abf295 100644
> > > --- a/target/arm/cpu.c
> > > +++ b/target/arm/cpu.c
> > > @@ -1577,7 +1577,9 @@ void arm_cpu_finalize_features(ARMCPU *cpu, Err=
or **errp)
> > >            * assumes it, so if the user asked for sve=3Doff then turn=
 off SME also.
> > >            * (KVM doesn't currently support SME at all.)
> > >            */
> > > -        if (cpu_isar_feature(aa64_sme, cpu) && !cpu_isar_feature(aa6=
4_sve, cpu)) {
> > > +        if (!hvf_enabled()
> >
> > In my experience "if(!accel)" is bug prone, maybe change to explicit "i=
f
> > (tcg_enabled() || kvm_enabled()"?
>
> Shouldn't we list all accelerators instead of just tcg/kvm then?

This "turn off SME if no SVE" check is principally trying to
avoid users hitting a bug / missing feature in TCG where
it will assert on startup when the guest tries to write to
SMCR_EL1 (see the backtrace in f7767ca3017's commit message),
because we accidentally coded in assumptions that any guest
with SME also has SVE. We turned it off for all accelerators
because (a) at the time there weren't any others which had
SME support and (b) we didn't do the investigation to figure
out if any of those bogus assumptions were in code that's
not TCG-specific. (In our defence, it was just prior to
a QEMU release :-))

To the extent that those accidental assumptions are in code
that you can hit with HVF, we need to fix them before we
can enable SME-no-SVE in HVF. To the extent that they're TCG
specific, the only accelerator we really need to turn
this off for is TCG. As the comment notes, right now
KVM doesn't support SME so it's impossible to get here
with SME in the feature registers.

If the core code is OK for hvf to enable SME-no-SVE,
then it should also be OK for any other accelerator
except TCG.

I don't think hvf can get to the smcr_write() function
which is the specific failure we saw with TCG, but
I think that it ought to be possible to end up calling
sve_vqm1_for_el() if you use the gdbstub with hvf
accel, get the guest into streaming SME mode (PSTATE.SM
set), and then read the "svg" register that gdb uses to
expose the vector granule.

If giving the SME registers a good workout with the
gdbstub interface all seems to work fine, then I think
we can adjust this condition to be "if tcg_enabled && ...".

thanks
-- PMM

