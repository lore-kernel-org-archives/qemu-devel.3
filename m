Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C0B4D3399E
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2024 16:48:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5Suy-0005sr-Ui; Mon, 28 Oct 2024 12:48:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t5Suu-0005rL-F9
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 12:48:32 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t5Sus-0001z2-Qu
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 12:48:32 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5c9c28c1ecbso6167116a12.0
 for <qemu-devel@nongnu.org>; Mon, 28 Oct 2024 09:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730134109; x=1730738909; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7KnUNLueAKjDgxYCEbUwQTT/VPUr4XHGzj00PvTOp+E=;
 b=q8v9oMMshiB2s24u1h2W9+rU7KXnzhMZGoYy/cMn2yTAlgOQPetqsm7EQoN7cW6KaT
 OvqwBdsoz3dug+Hpv7FzvsqdfGHNvAqJPeVz+siXJPkmu0cLIvR3dLIYmwAeNBUThpAX
 G4gfZy8PCfbMdcbEStH6ta5BH/dqYLTtBKhYWpXRTU/6SCHqaUVypoP13PU17WLKAuAg
 9ULJ6wS9UjBC8CgX0Vc8fndP6kMeaxidKPFkh57snUXL0hMTDKmQB5suHbVqeWXDIN/I
 ENctnRviruasgITUO1ko82PqArpVhOUennfs9Od1SX6QsAR9o8fm6rH6KLYMRML5bJc7
 mdGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730134109; x=1730738909;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7KnUNLueAKjDgxYCEbUwQTT/VPUr4XHGzj00PvTOp+E=;
 b=naz0uzE78z9FSUFbhYXekXIqOSAooDxDMXvBo7hTH+WHFVRzxM4uH66YKSwdlKWfmt
 5IDJWlNH3qWp9BeQbVwIRu0+Tg41Jw6jkrWJpYGwAaB/bGeSiUVo4SVO7OM8GGLzDczt
 7QyGiSEwTTGflxYvWcYYgwkcylR14YNz5gkfjL7mYgCHexiFjALvY8dVUGYFXPhNOJAz
 HhWeLGrpNpxEf0fBMjhNDFzBL84Nz2Nm8Nk5CuXvvFq4pmnQJ7RvPQ3g8mEGYsgXe0Ou
 CO+dScs22SS0NKzIH/1E6L2wrcifNF5uWftNr2IbBk45MZNxuWXg25QcrxzD3lXVOHBw
 afiw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUCtOdHCyjK8MZQJ5HR6Y9cczqsB03rJ2NGF19vjqOrWAuFr9CmTUWA6yVnZ/+fg54FJ0UvcWRa5fxc@nongnu.org
X-Gm-Message-State: AOJu0YxOiUOSnEmQHc6nf3NHDXriU3gyZ8jL5Di0JqO3Tnb+zP9aQ4NR
 sIodarmE4bMSdS9mPEvkWXCFZ9iMolSRVc2Ns7XBneuz9662cE9p0Kvp5KOvZQmkUf4WA4aBoJ3
 rNApe3WNpQ4UL4CfJ35W51J6yUGIx6X9QLT87aw==
X-Google-Smtp-Source: AGHT+IGfJV04ZqowAK9zEadNBVsMz49bjr9g5V5cwHxrCIWiztesrHX+uwsDooy37BW15MpUHvqKweovZtxtaKLQHXA=
X-Received: by 2002:a05:6402:26c9:b0:5cb:69be:db47 with SMTP id
 4fb4d7f45d1cf-5cbbf922bb5mr7338589a12.28.1730134108942; Mon, 28 Oct 2024
 09:48:28 -0700 (PDT)
MIME-Version: 1.0
References: <20241025101959.601048-1-eric.auger@redhat.com>
 <20241025101959.601048-19-eric.auger@redhat.com> <ZxuX4i9NjVRizB72@redhat.com>
 <cb6c8f62-c5dc-416d-865f-fbdf96164dac@redhat.com>
 <Zxub7ol4p8P_sWF8@redhat.com>
 <CAFEAcA_wQu17y0PyQwxw0wuf2H5y2VE5aX16nLP2-u7QUP2ggA@mail.gmail.com>
 <Zx-9WxXkmkMuGIlQ@redhat.com>
In-Reply-To: <Zx-9WxXkmkMuGIlQ@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 28 Oct 2024 16:48:18 +0000
Message-ID: <CAFEAcA9w0mb5bcU8p+fScQony-=oqLmNurGWpnL_sBneQCzxUg@mail.gmail.com>
Subject: Re: [RFC 18/21] arm/cpu: Introduce a customizable kvm host cpu model
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
 cohuck@redhat.com, 
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, kvmarm@lists.linux.dev, 
 richard.henderson@linaro.org, alex.bennee@linaro.org, maz@kernel.org, 
 oliver.upton@linux.dev, sebott@redhat.com, 
 shameerali.kolothum.thodi@huawei.com, armbru@redhat.com, abologna@redhat.com, 
 jdenemar@redhat.com, shahuang@redhat.com, mark.rutland@arm.com, 
 philmd@linaro.org, pbonzini@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52b.google.com
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

On Mon, 28 Oct 2024 at 16:35, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
>
> On Mon, Oct 28, 2024 at 04:16:31PM +0000, Peter Maydell wrote:
> > On Fri, 25 Oct 2024 at 14:24, Daniel P. Berrang=C3=A9 <berrange@redhat.=
com> wrote:
> > > On Fri, Oct 25, 2024 at 03:18:25PM +0200, Eric Auger wrote:
> > > > On 10/25/24 15:06, Daniel P. Berrang=C3=A9 wrote:
> > > > > Also, is this naming convention really the same one that users
> > > > > will see when they look at /proc/cpuinfo to view features ? It
> > > > No it is not. I do agree that the custom cpu model is very low leve=
l. It
> > > > is very well suited to test all series turning ID regs as writable =
but
> > > > this would require an extra layer that adapts /proc/cpuinfo feature
> > > > level to this regid/field abstraction.
> > > >
> > > > In /cpu/proc you will see somethink like:
> > > >  Features    : fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics f=
php
> > > > asimdhp cpuid asimdrdm lrcpc dcpop asimddp
> > >
> > > Right, IMHO, this is the terminology that QEMU must use in user
> > > facing APIs.
> >
> > /proc/cpuinfo's naming is rather weird for historical
> > reasons (for instance there is only one FEAT_FP16 feature
> > but cpuinfo lists "fphp" and "asimdhp" separately).
>
> There's plenty of wierd history in x86 too. In this
> case I might suggest just picking one of the two
> common names, and ignoring the other.
>
> If we really wanted to, we could alias the 2nd name
> to the first, but its likely not worth the bother.

Or we could use the standard set of architectural
feature names, and not have the problem at all, and not
have to document what we mean by our nonstandard names.
(cpuinfo names do actually mostly line up with the
standard names, just not 100%. Similarly gcc/clang command
line options are mostly the architectural feature name.)

thanks
-- PMM

