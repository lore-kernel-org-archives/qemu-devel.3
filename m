Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37674C369DC
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 10:27:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9iAJ-0007ys-74; Tue, 29 Apr 2025 06:26:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1u9iAF-0007sn-E2
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 06:26:11 -0400
Received: from mail-yb1-xb2b.google.com ([2607:f8b0:4864:20::b2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1u9iAC-0006UZ-Bz
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 06:26:10 -0400
Received: by mail-yb1-xb2b.google.com with SMTP id
 3f1490d57ef6-e72cc45d99cso5098988276.3
 for <qemu-devel@nongnu.org>; Tue, 29 Apr 2025 03:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745922366; x=1746527166; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZFu3+tYtMxIGGm84GUWIPNJD6pNOJ4l8XUwZe3/snfg=;
 b=o/RxLzd+riiEJ3G/1Mbmi0HztHfseayIOVUrXxqv9Bn8+KGsrIsQproKFk98ea24PL
 iP3yNmtvNFO152f5/Xh9W4oHcczu9qHLip7RrkZeD6l9tZFYwo7RtscafAFNKkybSehP
 RhJzTIOTiZBtl90t/5Q7I8kdqtGYk4ejG1tJpxQjpDJo/KaVEmbursNIPJyIorrm0olP
 S3ZSV/aC3z3aRPhN71zDO+ItPjAhFJJEIZi6zxN3IjzjZFiVNiv8ZF3PxSExqq60nsr0
 kqAq5TMNNWipa+iGBYTK5bxHcLex/x+H0Be2JDSwAsGqFlR+CWPWtsb+EpI18k5rRt8Z
 Ulgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745922366; x=1746527166;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZFu3+tYtMxIGGm84GUWIPNJD6pNOJ4l8XUwZe3/snfg=;
 b=b4ghugFnX70LD8MdEAuDGPQmQWDlWts1QP8fDLRyIhlBiFilnHmTbnqSXLujEzcXXT
 sRGYKdAKE78TXVMM+Jnx1wwja2UK+7AsT7LsZZBC3gcGBKyJaFuXUaq8SWwSlqTCGYbL
 EpuzF3/iPLNxCgM1a6+nVc80eHq8OOxtXWTKuhiuGozbq0FDYK0uh6g2mfaFCJeg7xtp
 bkh8+RaV8cwh384rkPP4SmYORaMsXmi9Hj/btAoKi1GHE3BwZZv8RqJMHTqxAv8f1xTx
 gFhBgPoMYh5CCcUhmAYI0MWfkm1+W30WTItJfikkJmwh6r5+XnLWe/aKpObnVsQs5KFX
 mBiw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXcsE2T6bEkRLsWaN+ho7IDiyiLinTc/WGFPUNWWhqcTa9CGXadMbX9msw2/wiyB8nPqV57rMbc7bqz@nongnu.org
X-Gm-Message-State: AOJu0Ywl9g9IfcJ60Hp7SJum2egJvsDTSEHbidG+OHNc/TQ7VTt5loS6
 nDZOkfnYJI4zM0wOZIb514hGLEIhyxHvXL5mTQDkFRElgzmkov7FvTh0axfOK1vib9UccMRQOeX
 2KAH/EuaEoykI6fl2dytKqnxmdne3oGJ6XJks+A==
X-Gm-Gg: ASbGncsxdGZu5rhYA/cY1WiAIOlvLbg9Q60CC/AQuN4dCXrxmxHF+JfJAwT5bxH54M4
 l99r1Iq5kfKtvw09ot/GdOfA6n/mtnaVvk99Da8uxJgEb4/5M2hJvZEUlpek0Odaab+b/RNY3Ao
 w+pNhuxIwBc6bNN8A9buod+8w=
X-Google-Smtp-Source: AGHT+IG2L16BxXQcB0XI194mSVjvEIOfp0VQJgFWCNuFDfwXsbqs8V6E8d56LDbXusirUj64wa6i/ogyRIpgrBwu7dM=
X-Received: by 2002:a05:6902:114a:b0:e73:3279:9fd0 with SMTP id
 3f1490d57ef6-e733279baa6mr11153123276.9.1745922366504; Tue, 29 Apr 2025
 03:26:06 -0700 (PDT)
MIME-Version: 1.0
References: <20250317142819.900029-1-peter.maydell@linaro.org>
 <20250317142819.900029-7-peter.maydell@linaro.org>
 <ca432cc8-31a6-4b22-81e7-4c620a9f199f@linaro.org>
In-Reply-To: <ca432cc8-31a6-4b22-81e7-4c620a9f199f@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 29 Apr 2025 11:25:55 +0100
X-Gm-Features: ATxdqUEN5hyxAiqqXPxSLzhZ41T7DLEwqGwN1hsr0Z9Pfxv9qN5BxP_kQxyS2tQ
Message-ID: <CAFEAcA-MYHyvgOs7PMj-36d_BJEybNcWzrjCSmK7io+hNJ7n1w@mail.gmail.com>
Subject: Re: [PATCH for-10.1 6/9] target/arm: Present AArch64 gdbstub based on
 ARM_FEATURE_AARCH64
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Akihiko Odaki <akihiko.odaki@daynix.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2b.google.com
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

On Fri, 25 Apr 2025 at 15:42, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> Hi Peter,
>
> On 17/3/25 15:28, Peter Maydell wrote:
> > Currently we provide an AArch64 gdbstub for CPUs which are
> > TYPE_AARCH64_CPU, and an AArch32 gdbstub for those which are only
> > TYPE_ARM_CPU.  This mostly does the right thing, except in the
> > corner case of KVM with -cpu host,aarch64=3Doff.  That produces a CPU
> > which is TYPE_AARCH64_CPU but which has ARM_FEATURE_AARCH64 removed
> > and which to the guest is in AArch32 mode.
> >
> > Now we have moved all the handling of AArch64-vs-AArch32 gdbstub
> > behaviour into TYPE_ARM_CPU we can change the condition we use for
> > whether to select the AArch64 gdbstub to look at ARM_FEATURE_AARCH64.
> > This will mean that we now correctly provide an AArch32 gdbstub for
> > aarch64=3Doff CPUs.
> >
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> >   target/arm/internals.h | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/target/arm/internals.h b/target/arm/internals.h
> > index a14c269fa5a..a18d87fa28b 100644
> > --- a/target/arm/internals.h
> > +++ b/target/arm/internals.h
> > @@ -1694,7 +1694,7 @@ void aarch64_add_sme_properties(Object *obj);
> >   /* Return true if the gdbstub is presenting an AArch64 CPU */
> >   static inline bool arm_gdbstub_is_aarch64(ARMCPU *cpu)
> >   {
> > -    return object_dynamic_cast(OBJECT(cpu), TYPE_AARCH64_CPU);
> > +    return arm_feature(&cpu->env, ARM_FEATURE_AARCH64);
>
> Unfortunately this doesn't work well: while a Aarch64 CPU is of type
> TYPE_AARCH64_CPU right after being instantiated (not yet QOM realized),
> the features are only finalized during arm_cpu_instance_init():

Thanks for finding this. The problem is that gdb_init_cpu() is
being called as part of the base-class instance init, so the
CPU object isn't fully instantiated yet -- it hasn't even run
the aarch64_max_initfn() function yet. So gdb_init_cpu() ends
up calling CPU-specific methods on a half-instantiated object,
which is why it crashes.

But we do need to move things so they happen after realize,
because up til realize the CPU properties might be changed
(otherwise we give the wrong answer for the aarch64=3Doff case).
Except that part of the CPU subclass realize involves calling
gdb_register_coprocessor(), which needs to happen after we've
set up the core regs for gdb.

I think that moving the call to cpu_exec_realizefn() would
work (this gets called near the start of realize, so before
the subclass realize decides to add more gdb registers).
But I'll have to check whether that would be wrong for
some other architecture, and maybe there's a neater way
to do this.

-- PMM

