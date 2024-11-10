Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D187AD12D42
	for <qemu-devel@archiver.kernel.org>; Sun, 10 Nov 2024 15:16:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tA9f2-0007cr-BG; Sun, 10 Nov 2024 10:15:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lists@philjordan.eu>)
 id 1tA9es-0007bF-8c
 for qemu-devel@nongnu.org; Sun, 10 Nov 2024 10:15:29 -0500
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lists@philjordan.eu>)
 id 1tA9eo-0002L5-SA
 for qemu-devel@nongnu.org; Sun, 10 Nov 2024 10:15:22 -0500
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-7eae96e6624so2512754a12.2
 for <qemu-devel@nongnu.org>; Sun, 10 Nov 2024 07:15:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1731251717; x=1731856517;
 darn=nongnu.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bRIElRIkbSkGcDEyJKLsexpTiPct+QzbWRnM08FSXYA=;
 b=Gqn9qmiOdrBf5KMxmEb4PZRgLuL0umL9pPgFRvxTklYu3GNeBAlETxvh0a1YAjGH2/
 Ic2dwb7rzn5piHO1O6Leg6AmUhKCOysECxxFF+FkmFByfahiJjq+D5wt0Kj2RCxoPEBz
 sftDvEm28e2Jv7Bt9iG0GJL8u1j3QjEb4Rso0SK50aPOg7HDp14W1v8+GpiCLYYvNtrv
 70AHzDDCHCAbXocJRNmsm8vJXsNOt1gTGzTeQT/2hDQ5z97JAVGyAcxsZXoR0HCW3LSy
 3fGm3DyuQN1C5INxds8lwoEGopgfD+SbD9IzrbHaLBl9xDt8OnYFb8k7m6cEpacCVcSx
 ZP6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731251717; x=1731856517;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bRIElRIkbSkGcDEyJKLsexpTiPct+QzbWRnM08FSXYA=;
 b=Slrrf/kQinZ1f8bmE3rWMn/JC2f4tHzwpj66uGbG7yz5LKLn8EnogmM7YwBLgs782L
 PyPEWDabTPCyoQ2oqqaJRSQl3E7iVe2YZQWwbmIaGea6a+rw1BIK+8v5TEng3Us2L+8s
 f+PAEgAvLoO2qtK1xd6dRqhfTGhwP0gYQni0U0iQNiYe03lbFNlHZYI06faLJh2LTU9h
 cB6JF8QPbMcg2ZqzHA1jhGHiBtgNt0LndelqAbVZr4U7GvvVZlX8ZzLNTG6mc8HKGicg
 9Oa0PbqCsRWEeywth2/Q5V2ilG+tSTU7Nca06SYUKBvYN1YnCKt5nq/HEPPJh+wTkIvi
 xraw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVe2AsMba3O02lYHA8XxKpmmWJ1DZMfPwigAcubavCEDe5yj6tvWy1meTuhpFsKJSBoTPHBinGiVecD@nongnu.org
X-Gm-Message-State: AOJu0Yw/DhcQHGm7DPLEZcNry07+Drw+z2CkxnlsTfUqtL+V0x8aObHX
 KiGdG+8g/SK0RK91LD5S6AKQ7SSRzZKN6swCouAimwg+tZI1a9e2Iw3RW0a9fqiOXJPVlSKinDY
 sggjm6tKSpH+rxxuB5TqXuOJLodX2MRi1UTOP
X-Google-Smtp-Source: AGHT+IF3qax97AtN+5hD3VD8U+YOt+0KuBpiEI+KIHijgfNTxxY+rlEHjGQSBxSBpu+29rjjRwu4yHikM6Z5uJdD3t0=
X-Received: by 2002:a17:90b:4f43:b0:2e2:e82d:48cf with SMTP id
 98e67ed59e1d1-2e9b1724271mr14520256a91.16.1731251716985; Sun, 10 Nov 2024
 07:15:16 -0800 (PST)
MIME-Version: 1.0
References: <20241108144709.95498-1-phil@philjordan.eu>
 <20241108144709.95498-2-phil@philjordan.eu>
 <9c2e0b96-2125-4041-9f66-116d54accb04@daynix.com>
 <CAAibmn3NbtOEwWLQFOo_UmAGTehOj+dDP04A=-JGMZVK9AYMDw@mail.gmail.com>
 <07ec41b8-922c-4c6a-b550-63fc4481d019@daynix.com>
In-Reply-To: <07ec41b8-922c-4c6a-b550-63fc4481d019@daynix.com>
From: Phil Dennis-Jordan <lists@philjordan.eu>
Date: Sun, 10 Nov 2024 16:15:06 +0100
Message-ID: <CAGCz3vt=jCBU8UpXhcLEXC20mJZ=4Mx0hL4ixzhSPAKF3rV64w@mail.gmail.com>
Subject: Re: [PATCH v8 01/15] ui & main loop: Redesign of system-specific main
 thread event handling
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Phil Dennis-Jordan <phil@philjordan.eu>, qemu-devel@nongnu.org,
 agraf@csgraf.de, 
 peter.maydell@linaro.org, pbonzini@redhat.com, rad@semihalf.com, 
 quic_llindhol@quicinc.com, stefanha@redhat.com, mst@redhat.com, 
 slp@redhat.com, richard.henderson@linaro.org, eduardo@habkost.net, 
 marcel.apfelbaum@gmail.com, gaosong@loongson.cn, jiaxun.yang@flygoat.com, 
 chenhuacai@kernel.org, kwolf@redhat.com, hreitz@redhat.com, philmd@linaro.org, 
 shorne@gmail.com, palmer@dabbelt.com, alistair.francis@wdc.com, 
 bmeng.cn@gmail.com, liwei1518@gmail.com, dbarboza@ventanamicro.com, 
 zhiwei_liu@linux.alibaba.com, jcmvbkbc@gmail.com, marcandre.lureau@redhat.com, 
 berrange@redhat.com, qemu-arm@nongnu.org, qemu-block@nongnu.org, 
 qemu-riscv@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: neutral client-ip=2607:f8b0:4864:20::52f;
 envelope-from=lists@philjordan.eu; helo=mail-pg1-x52f.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NEUTRAL=0.779 autolearn=no autolearn_force=no
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

On Sun, 10 Nov 2024 at 08:10, Akihiko Odaki <akihiko.odaki@daynix.com> wrot=
e:
>
> On 2024/11/10 16:08, Phil Dennis-Jordan wrote:
> >
> >
> > On Sun 10. Nov 2024 at 08:01, Akihiko Odaki <akihiko.odaki@daynix.com
> > <mailto:akihiko.odaki@daynix.com>> wrote:
> >
> >     On 2024/11/08 23:46, Phil Dennis-Jordan wrote:
> >      > macOS's Cocoa event handling must be done on the initial (main)
> >     thread
> >      > of the process. Furthermore, if library or application code uses
> >      > libdispatch, the main dispatch queue must be handling events on
> >     the main
> >      > thread as well.
> >      >
> >      > So far, this has affected Qemu in both the Cocoa and SDL UIs,
> >     although
> >      > in different ways: the Cocoa UI replaces the default qemu_main
> >     function
> >      > with one that spins Qemu's internal main event loop off onto a
> >      > background thread. SDL (which uses Cocoa internally) on the othe=
r
> >     hand
> >      > uses a polling approach within Qemu's main event loop. Events ar=
e
> >      > polled during the SDL UI's dpy_refresh callback, which happens t=
o run
> >      > on the main thread by default.
> >
> >     GTK should also do the same as SDL and requires treatment; I forgot=
 to
> >     note that in previous reviews.
> >
> >
> > Although it=E2=80=98s possible to build Qemu with GTK support enabled o=
n macOS,
> > that UI doesn=E2=80=99t actually work on macOS at all, and apparently h=
asn=E2=80=99t
> > been supported since 2018, see:
> > https://stackoverflow.com/a/51474795 <https://stackoverflow.com/a/51474=
795>
> >
> > I don=E2=80=99t think there=E2=80=99s any point making adjustments to t=
he GTK code by
> > guessing what might be needed if someone did fix that to work with macO=
S
> > at some point.
>
> But there is a GitLab issue saying it "sometimes" crashes, implying it
> works otherwise:
> https://gitlab.com/qemu-project/qemu/-/issues/2539

I spent some time trying to get the GTK GUI working locally on macOS
with no success (with or without the pvg/vmapple patch set) until I
found various info online suggesting it was broken. But I guess I can
add a qemu_main =3D NULL; line to gtk_display_init(). This will retain
the existing behaviour both on other platforms (where qemu_main is
NULL anyway) and if anyone does manage to use it on macOS.

