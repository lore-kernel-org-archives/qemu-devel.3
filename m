Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41551CA1013
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Sep 2025 10:28:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvZ5C-0002vh-E9; Mon, 08 Sep 2025 06:26:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uvZ59-0002up-8p
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 06:26:43 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uvZ4y-00039E-5Y
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 06:26:42 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-afcb7ae31caso705967566b.3
 for <qemu-devel@nongnu.org>; Mon, 08 Sep 2025 03:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1757327185; x=1757931985; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dHK/jEohPDLexJ1AX8b+BF56O/scjTSCjWar3EBr5e8=;
 b=kzM9YvHEXEhGdk6i6vgJwfNcJdEIAhlqGPDuJAen/cdiHIBgFV3YbV0DYpdabjc3MT
 ObDG5lPgl1gcPnhITnAxqNguIvw45Al41XBe+/RNJ6DLnI0yptLe5VygnPUmOmEdrJSW
 mUzXSgSHcXZETG3a5DzhgIu32oZZ9e1J+kv/ZLxEGVuAHb//SkyuIIPaiAMzB0Mn6mZ4
 K/ylwknBfXUUVZtmEogPZITYp+aJBeelZMHV9cs9uy3pUAgAEwHPJtY1xd5PJ42UEd8U
 HLfwx8JYSbiFTeipiSfyZ/RuW2twUTs+/eQAbxjGouYYzoVqgBaXmVznGOYPi+U8LolM
 DRhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757327185; x=1757931985;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dHK/jEohPDLexJ1AX8b+BF56O/scjTSCjWar3EBr5e8=;
 b=w/UBkHtB6LjeXVwr68Hb5kddZN8zrDgEA//+CoZZvQPJaDmN6tppnzF7kdc/ouExQs
 LrA9oFo6wk7s121nUDGjPxNCP2YrKTCJITWJ0kZKDUNSra3vFOUFxpwfTrEIqVz1AyFm
 4si1ZIf7nWxdIyrTubroR5QYqNujov5awXbqMruW0eqXGdhIGhwpbD2jw6XQ1PEJAG/k
 ckuaq9OiCCoEPDccY/vxsVeot4RSgupM+2+hhVmvZOYiIaAETymv37RiTQQWW29f0yNc
 B4U72plS5DtBUuaBRNS73QX1Z/eQpf3GZrMZzTKus9qLc/kljBK3Qj4OZx1MfhNaI7l+
 9O2g==
X-Gm-Message-State: AOJu0YzqTzN6vTNwNA7GAac68MnKw9K1CCQUokjv8YB5bCGaS3ZTF0HE
 2L8UL23yvUNI+ln47pre0SMidJwBF7WM+0OSFfdLAZ17U3LWirsviBaAPi/5EvyRuuENuGqNyZc
 xTIt5MNLIKcHN2ho79UB/6Am/JVFXPzCq64e1R1RJUQ==
X-Gm-Gg: ASbGncupEuNRp4Q1+qlVwzwSjth0JOnjaAvndFsXZqT2v2m41PFna6GvgONOZ0hsyeJ
 MPRNHzaxOAz/byzBGa2k0CyQiSWQlek/DBZch4pEtMiGFycwvHWv4SzHnprGkj4TJJRo6AS4+lb
 lPZWsaHr29ezJExNN866OBc27eInRIfzTSWdEG3HAf+bx4eICBItHMVzfaBRwQF9iEFkUnNGr57
 HqEeJnrw5za7YRSxvxoz8eaBz6lEw==
X-Google-Smtp-Source: AGHT+IFR8eoeE1eKXmTE2+iEI4lYQrEAuGAbeECHppnVwqCgBFP+qat/2T4q1UJnIYARpRr0J/RbQS04UhVZmQ5orWA=
X-Received: by 2002:a17:907:6088:b0:afe:78c2:4d4a with SMTP id
 a640c23a62f3a-b04b1542fbbmr675934766b.34.1757327185061; Mon, 08 Sep 2025
 03:26:25 -0700 (PDT)
MIME-Version: 1.0
References: <8076a298-1cd9-4c90-a64c-f65004753975@redhat.com>
 <CAAjaMXaPM0qrCwrMY_n531R4d5X3h+GjRHKzjHLeY3FprT5_TA@mail.gmail.com>
 <ee80babd-6e48-483b-93d8-849539c0f378@redhat.com>
In-Reply-To: <ee80babd-6e48-483b-93d8-849539c0f378@redhat.com>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Mon, 8 Sep 2025 13:25:59 +0300
X-Gm-Features: Ac12FXy_mSXQs71g1vi6-wKrzQensJBeodHtNSDHmCVSYEJ1VljXKy-ikpt7Ogo
Message-ID: <CAAjaMXY4auReucQ_BCZWppBg-nCcNLydzaYi3gXaqASXicwz9g@mail.gmail.com>
Subject: Re: Rust high-level pre/post migration callbacks
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Zhao Liu <zhao1.liu@intel.com>,
 qemu-rust@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x630.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Mon, Sep 8, 2025 at 1:19=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com> =
wrote:
>
> On 9/8/25 12:02, Manos Pitsidianakis wrote:
> > Hi Paolo,
> >
> > I'm not familiar with how migration works under the hood, but this
> > data transformation design looks very clean and neat to me.
>
> Thanks!
>
> >> Using it is very easy, you can just declare your state like:
> >>
> >>       regs: Migratable<Mutex<MyDeviceRegisters>>
> >
> > Hm it's a shame we cannot do this with a trait since it requires state
> > storage for migration_state.
>
> Yeah, but a Box is just a single pointer.  We need to have an actual
> location in memory for the C code to retrieve the pointer.

Oh yeah I got that. I was talking about needing to introduce new
wrapper types for fields.

>
> > A suggestion: we could declare a "mirror" struct to hold
> > `migration_state` with a Derive macro. This is what the `rkyv` crate
> > does with its `Archive` derive macro and trait
> > <https://docs.rs/rkyv/latest/rkyv/trait.Archive.html>
>
> Nice!  I'm not familiar with rkyv but it does look very similar.
>
> When I tried to clean up the HPET (create HPETRegisters, and replace use
> of raw pointers with self_cell to implement self-referential structs),
> migration was the big mess, so I hope that this design will fix both
> that and Mutex<>.  And indeed having a derive macro is very similar to
> what I came up with one day later :) while thinking about how HPET could
> use it in practice.
>
> Probably the derive macro would require some changes to the trait, but
> the basic idea remains the same.

Yes exactly. You could store the migration data in another struct
(e.g. `FooDeviceMigrationState`) and use it as a conduit between the
device and C migration logic.

>
> Paolo
>

