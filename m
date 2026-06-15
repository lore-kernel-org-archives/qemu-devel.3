Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A395CD98C5
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 09:29:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZ3cr-0004f1-7z; Mon, 15 Jun 2026 05:29:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZ3cm-0004eA-98
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 05:28:56 -0400
Received: from mail-yx1-xb12e.google.com ([2607:f8b0:4864:20::b12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZ3cj-0002cP-Fe
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 05:28:56 -0400
Received: by mail-yx1-xb12e.google.com with SMTP id
 956f58d0204a3-6605c3453f2so3257750d50.1
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 02:28:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781515732; cv=none;
 d=google.com; s=arc-20240605;
 b=XcuE2h+uJYhLTPSLg8xUuF8HCNPPpKR6Rl707yLxZcvAr4DcIWbWJuGOf82SC5SbJb
 CbDp18S4RR820nVKzpNvB/uDrcMieQiFRuqTfGTePrC9sTe6GE+ZWKdF3VkVS0cWKKz0
 XkrpHbCZQJI6QgPETGbdov7jwj1Lc0pk33njNf0A1vKtb+sF6ApoX3NMzpEs593pRorT
 +TCD+EWWV12K0tNx+8AyOFUEsKBA1Thp6PTE0GYVx7a+CRBMwjtvhbFt/OI83hVVSqOE
 DZOrt5XZWKOVrZVN+TeXA5lJl63403x2eEbzXSn5YNklOoE8vqWHThQD4fqfQqpobp0O
 P46w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=4h7z8wlbabOPsROrERBqjgdjxedmv9sWmTQBMTR5gyk=;
 fh=LyQa8shZvNYklF8aX21nwzMsd8+upEAtdbQoW1W+gVA=;
 b=Hw6wP/UdaR1lfkSBTV8cxVAk4Y+V6LSrFQ21gDsPZA2b/aeBB8XpsZ2Heu1Ww0h74Y
 O9EzkNBs7jqm4Em94SuD2C4H404oR2zcyW59UKfAu70Xnx7ANym90aIoSJ8b3GPRzyYO
 /f/rW0+wAW+QNnCkPali/eOYaLDAw//aKdCQULzEyHctJw2UV/qip7QId/7U1Gl7MLd7
 7HggK5tx2i2kIAX6cre1IbvKtXj6r3iLQC0CyWBcBpYfeCjuS2Xr0IOznBeWnZrapHlF
 h1tvxoYX/mA4UocPjunDFzWfaHARNHe1bWKVelA6whNw7fRCHs0KKP5B9vbOuiAwc2dc
 VkHw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781515732; x=1782120532; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4h7z8wlbabOPsROrERBqjgdjxedmv9sWmTQBMTR5gyk=;
 b=T9rJWt/6Nccx64mv9ugHg60E7DTUfUc+ikir4/1s69/7U8pBoznbbjEx5jXF+cHsrI
 GT4kTKp72TZbVu2HSbIgSXdsWmRuXoqaUwcBb1WAK7aESmULe5+ySwuMiLpeqOcWAUmO
 lTdZmU4MuTLQRphgohsdOlgsCyxMq7YeU0HETVXLJ8vNX44a5zBLXlne0jp6WIDPM9Nf
 CQa0f/bv1/CyhaABpnyQu1wcJ9MYdIW33i347xutH/WrcV6vCu2gu0xZ8kxs3NYNBPCM
 OqVh3sm2TYXT3z+7UzT3GEIX8bOh3tTQgVJpfQYovQwzMqMB/ejR9of9rqMP4FEfISCp
 qnfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781515732; x=1782120532;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4h7z8wlbabOPsROrERBqjgdjxedmv9sWmTQBMTR5gyk=;
 b=JUbgPwk1kVWMBivygvbfhEP69ex5/e3ur6PmKC26PmF4ZHG4uxZ6KpXFMsSqCZsJaY
 qR3kouWlmZrtvarMAbvp2y98JFBiYcojnDeXj0yi1Ldl3+6gcITK1IuUgOijwb6NXujy
 y7+Ut1RO0h05iJbBkVGVc4Enl4pcXEYKJfdEjWNYWdKIkn4pZ8ac0vNOZ1ZYBuNu3siR
 rBgbzC+daOeBKzql8sCPuPdVlLcLFe8OdHN7jqocsXEV/6Wr4u0oGFEvlbnoX857yfhN
 HBWiWNUR9gAKE8hHNgPasAQf/1G5619+vcXtB5AU635yhfxGqiK/mslD+nP1Dswkd41b
 VvoA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+WqtaKn7S2V9W25+9kJxARmgxdiABASifRuFzA1FU/Dr4fcm/2U3J+z5phZigEe4x0NNCipy1lzrkQ@nongnu.org
X-Gm-Message-State: AOJu0YwnXsYoR+GcuuPlRpGDKikdwfYKt/Z20TvHUMg9TlJpDVz6DoW6
 u7FogDWiw9ud8YjdOP7SdRKaGiozY6PJy1FRRGHl/qPVX5+Lt3N/kkrO5F4ITs8LYjthoLrAvJD
 BEgHrJyVp4FNlIkCNdNCDEp777NTsTTj0rSAjB7tKIA==
X-Gm-Gg: Acq92OHU1Jobj3rWRLZyRevkLDEByz2ox++FP+B4P+mLso49dMP8UJQqLwQJTEBnRHy
 Fs5uD8Rbv41i2u1FVXHPMkUlZ0oA1o82ed+8qm7v/RDsLf1C1UgAerSlE/aYnrb1BdGM97a4I1G
 znijIpEqphjInazwK43A3jFfI6hdoQVVzV1SJTUkvrO4Pc7hFZZJdodMeRkcJ/5OLZ0J1EBWFaX
 NIYmFmsVWwNEn7tmL01fPyzSoKaFunZ19Whqas2qc0BFMBDob94coAwvvQmVePGxqHnzVrru+EZ
 Nra6MQMvfqGQQPBETZ53LETEtS4Px16Pkg48Fkq5IJbN1wK/Rh/h0L5TSVaulDuP2Tc=
X-Received: by 2002:a53:c146:0:b0:660:60a9:2b33 with SMTP id
 956f58d0204a3-6628500a341mr6854412d50.53.1781515732085; Mon, 15 Jun 2026
 02:28:52 -0700 (PDT)
MIME-Version: 1.0
References: <20260615-embedded-v1-0-bb0c65bf126c@rsg.ci.i.u-tokyo.ac.jp>
 <20260615-embedded-v1-2-bb0c65bf126c@rsg.ci.i.u-tokyo.ac.jp>
 <ai-z14dMCK33_pis@redhat.com>
 <CAFEAcA_nFiQyXyCuvwUrJ+-0fhmGoMfswK-+KsZbxahAGatTXw@mail.gmail.com>
 <ai-5M6FF7CoJc_re@redhat.com>
In-Reply-To: <ai-5M6FF7CoJc_re@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 15 Jun 2026 10:28:40 +0100
X-Gm-Features: AVVi8CdPDOOgY6peJmpRd_1gRW_mhJwrpEF89DFQaVrdM0fasteTMnuqucjkq8E
Message-ID: <CAFEAcA_52oFGv7cC11jbpj9pwBq-x2O-R_aOGkYzaRWW7t-K2g@mail.gmail.com>
Subject: Re: [PATCH 2/2] qom: Manage references to embedded child objects
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-devel@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, 
 qemu-rust@nongnu.org, Peter Xu <peterx@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>, 
 Alberto Garcia <berto@igalia.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12e.google.com
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

On Mon, 15 Jun 2026 at 09:35, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
>
> On Mon, Jun 15, 2026 at 09:31:36AM +0100, Peter Maydell wrote:
> > On Mon, 15 Jun 2026 at 09:13, Daniel P. Berrang=C3=A9 <berrange@redhat.=
com> wrote:
> > > Do we know how many examples we have of embedding objects inside
> > > another ?
> >
> > It is an extremely common pattern for device and SoC model
> > implementations; we've been recommending it for years.
> >
> > > I would much prefer if we forbid the embedding of objects. It is
> > > horrible design practice to have some QOM objects which can be
> > > freed via reference count and some which cannot.
> >
> > That would be a very large amount of code to rewrite to the
> > new paradigm. I don't object inherently ("you have pointers to
> > your child objects" works better when they might be implemented
> > in Rust and might play better with being able to create
> > machines and wire them up on the command line); I'm just
> > noting how much work it would be if you wanted to make
> > embedding forbidden.
>
> Would it be a more tractable problem to "fix" object structure only
> incrementally as they gain a need to be managed/reference from
> Rust code, or does the Rust usage already implicitly extend too
> broadly

At the moment we have exactly 2 Rust devices. You can see the
workaround we ended up with for the PL011 in commits 5b87a07e768
and cc3d262aa93a4, where we pad out the C device struct and
assert on the Rust side that its version isn't any bigger.

For that particular problem we could say "you need to refactor
all users of device X to not embed it before creating the Rust
version". There is I think only one embedded use of the PL011
(I was actually expecting more). This does have the awkward
effect that anybody wanting to do a "rewrite device in rust"
is now forced into "do a big refactor of some old C code they
don't care about". We would also need to actually document and
provide some good examples of "this is how we think we should
be writing device models that have child objects now".

But embedded MemoryRegions are enormously common, and devices
that embed other devices that embed MemoryRegions are also
pretty common. So I don't know how much of a gradual approach
you could take for the issue descibed in this patch.

thanks
-- PMM

