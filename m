Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3525BCA0EED
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Aug 2025 15:42:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1upTtb-0001AB-LP; Fri, 22 Aug 2025 11:41:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1upTtU-00019o-NX
 for qemu-devel@nongnu.org; Fri, 22 Aug 2025 11:41:33 -0400
Received: from mail-yb1-xb2e.google.com ([2607:f8b0:4864:20::b2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1upTtM-0002gt-KP
 for qemu-devel@nongnu.org; Fri, 22 Aug 2025 11:41:32 -0400
Received: by mail-yb1-xb2e.google.com with SMTP id
 3f1490d57ef6-e94e6c6150eso2399819276.3
 for <qemu-devel@nongnu.org>; Fri, 22 Aug 2025 08:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755877277; x=1756482077; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=I1ZhQgi/AphyZW1302/6oH7vVHGZK5GMnmcfmT3ZWOI=;
 b=qGprZYmx7y45KNgE/ZciIpoV08ihbsetBIITUg0NQksGMlIUCeeONPDqkW5jS7itc8
 j9pazTL6MSGWPuRcAdFsLLAXT8v2nDv7Tc3Y7Lhkx17eTLFy9j9NefIRkW9xoIbi4HrJ
 K7O8/FqR+7Tco1bFOqp0/gCvOEFGFyBDCaVOJnVXCtcZgoZKEn0dCTzR9nWhUZM5aA+4
 vUnmO+JyvXY9c9CO/curIV1IroVz7gSccy5N3JPNmQkCPcVzxdUx8zi4vGzwTPYlyfK9
 +8sHylEgdxFiDTlzvz+mkk9CCoGRIqSMSZJfBMv7wFyFAkVgZXFOVc5Lynubdig0njOU
 LbXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755877277; x=1756482077;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=I1ZhQgi/AphyZW1302/6oH7vVHGZK5GMnmcfmT3ZWOI=;
 b=mQlBkFvtL2zS3UECXXbTAbqbajzW1VDgxOlF48Z3KuHAUOVagYjQKwpoJUBuy+8h3Q
 J3juQO+kXcOoARSgTBKUmHcfsHqyqPY0edELbA88NhYkwnNwLS+iFnZQMNwVmOtfd5CT
 BWCPYGBBJrexqfXXYQP0zPFIXLCLZs2zm4fZNtTQuVcuWVWwuhWUT3FvJmvh15ZlapRF
 Pj7GKDXxUQVpbQPli+H4ClxuGWMUWJvn1/8nt7vUFVDuosNDgwpTv0yXGaC0gvpAB/BR
 qsODTb1+T5y/TydtGQ1Mch6pTMVd7RCo/90BHcfy49L7PfgHOTILG/sAevBrPnetThIN
 bhAQ==
X-Gm-Message-State: AOJu0YyRknbNWm72KxM387EDI52f7ra+ieRNfW8rBSzE0saaUbFEftpN
 OP1ysLZtjM82EPVRNJWBbs5aTiMYhG72QN2lBMNmDiNgYz3hYF0VV9EZ+y2hUWAmOSyDv/WDOwh
 /DaWXLY+Cv6afYLfabjNkUhOnQNR49d1C0uu2JHcm2g==
X-Gm-Gg: ASbGncuek9A3bVoCCWDOQQu0PgkLD8K8UdvdZDnwev9JnaZjc3B1RQ4HMvuMyaSmX+0
 mhjH/N3QsWGL2ZJDanleJFBh7jezJN6a9tqM5+t4VmeSeOzbY4CmNuhBjIXND1F1CuLbJFTktl2
 Zw/kvg0zLdUWQpJXBNOBK0+yH+OBZ2u041uToODjYR+FXzxnJUM8sYx9ujG5Byyj/k7igV2d9Is
 5zhSUfYTl0F+7Tpu9o=
X-Google-Smtp-Source: AGHT+IEm5XydLy2xXZLZy9Xo155ysVofmOZ3yFnsU6psFBKId0GHdm1zWL77jo6IfZBY01Sd9+1deN6S/0wK3jBoFBE=
X-Received: by 2002:a05:6902:c0f:b0:e94:d144:d464 with SMTP id
 3f1490d57ef6-e951c1f8857mr4064995276.0.1755877276484; Fri, 22 Aug 2025
 08:41:16 -0700 (PDT)
MIME-Version: 1.0
References: <20250716095432.81923-1-luc.michel@amd.com>
 <20250716095432.81923-14-luc.michel@amd.com>
 <CAFEAcA-x_CYWPM2TeGSTLjCj==3JY_uyvfFmR=nLi4pRLw-P2Q@mail.gmail.com>
 <aKMrBdNhtqHVHRYw@XFR-LUMICHEL-L2.amd.com>
 <CAFEAcA8eop95ojfZw3YbDrWfrv1fZ5QYSmwx_oDThxMCiMMeDg@mail.gmail.com>
 <aKV21WpfZ8u054zc@XFR-LUMICHEL-L2.amd.com>
 <CAFEAcA-HoghnZLWZLX7zBD=-_mztTQoZLReQRgS5TRE91eRbxg@mail.gmail.com>
 <aKiKlKGYlc0vMPwE@XFR-LUMICHEL-L2.amd.com>
In-Reply-To: <aKiKlKGYlc0vMPwE@XFR-LUMICHEL-L2.amd.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 22 Aug 2025 16:41:04 +0100
X-Gm-Features: Ac12FXxKIWDtmMuTl36wZNHvqRg4zc4JWIxO_SFadLXDEa8FH5soRM9xr6wZswg
Message-ID: <CAFEAcA9AtKx9eu-fZDCnYOziUzUFPwFeYKZ8URTbrY9uVahL1g@mail.gmail.com>
Subject: Re: [PATCH 13/48] hw/arm/xlnx-versal: VersalMap: add support for
 OR'ed IRQs
To: Luc Michel <luc.michel@amd.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 Francisco Iglesias <francisco.iglesias@amd.com>,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Alistair Francis <alistair@alistair23.me>,
 Frederic Konrad <frederic.konrad@amd.com>, 
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On Fri, 22 Aug 2025 at 16:19, Luc Michel <luc.michel@amd.com> wrote:
>
> On 14:55 Thu 21 Aug     , Peter Maydell wrote:
> > On Wed, 20 Aug 2025 at 08:19, Luc Michel <luc.michel@amd.com> wrote:
> > > > It would be helpful if you could run "make check" under
> > > > the clang leak sanitizer with your patches added, to see
> > > > if it complains about anything. (Unfortunately it will
> > > > definitely complain about at least some pre-existing
> > > > leaks, I suspect.)
> > > Yes I did that before sending my series and fixed all my leaks. As you
> > > say there are some existing ones, mainly in the register API (IIRC it
> > > does create an object that is not correctly parented).
> >
> > Yeah, register_init_block() seems to be broken in two ways:
> >  (1) it calls object_initialize() rather than
> >      object_initialize_child(), so the objects won't
> >      be automatically unreffed; but it doesn't manually
> >      unref them in register_finalize_block() either
> >  (2) the TYPE_REGISTER objects are a subclass of TYPE_DEVICE,
> >      but the code never calls realize on them. This means that
> >      if you fix point (1) then you trip the assert in
> >      qdev_assert_realized_properly_cb() which checks that
> >      every TYPE_DEVICE in the QOM tree was realized...
> >
>
> I'm willing to address this in a follow-up series.

That would be great; the leaks have been around for ages, so
there's no huge rush about trying to fix them, and they're the
"object was going to stay around for the life of the simulation
anyway" kind of leak where the major reason to squash them is
just that they clutter up the output when you run ASAN...

The "need to realize the objects" part is a bit awkward, because
the current API assumes you can just call one function in your
instance_init, and I guess we'd need to turn this into "provide an
init and a realize", or else insist that you only call
register_init_block() in realize methods...

There's also basically the same problem in xlnx-versal-canfd.c
canfd_populate_regarray() which seems to be rolling its own
version of register_init_block(), and doing it with at least
one extra bug. (Maybe that could be refactored to use
register_init_block() ?)

thanks
-- PMM

