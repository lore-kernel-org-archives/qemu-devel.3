Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2922FF885E
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 10:49:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHJWB-0006i3-6a; Mon, 27 Apr 2026 06:48:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wHJVb-0006Zt-NL
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 06:48:17 -0400
Received: from mail-yx1-xb129.google.com ([2607:f8b0:4864:20::b129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wHJVS-0003Mz-Pu
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 06:48:07 -0400
Received: by mail-yx1-xb129.google.com with SMTP id
 956f58d0204a3-6501547d7edso9077051d50.0
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 03:47:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777286877; cv=none;
 d=google.com; s=arc-20240605;
 b=hPwNneLNnPtWuh/LNWlTAIMca34IWKiEO2YgtpdmJPRKVvCli45rKwS6UABqmb6QdX
 83DDK5nd65/ibx9gIBoxQFqoPvjoRhPkXpeA52vXxaQWPzo7yRPnm0B3+FS3/vq1obIS
 zayaOUyLhr8SIUPNWhk8wYPpyE6HdJuL0w/EJJtzRErutz0vZVOPJlNOOVs5oh85MU/J
 Jsfl/sHgfwmCAQ5kFFXBR+fIV5+3CGjtaP0HCVu8MldJKjeTNQexzD87KHRMctLLSD6a
 a1EmNyMmlnrBqlzkIyq3JxEBp/3kXUmSgrwRGkaA73xyQ158fl1ZFFYtq7ynfHQl03Vi
 GHxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=z0t2lMK8mMOQqjFYJtMIq0BWSHEnCJiR8+4AnCrJmw0=;
 fh=VSqTVVfQp1MunVN6rCpKZcCVR27qUbf99rkOEABMANY=;
 b=Eh2aov2WsJ5ebjt4F3K4lVkip9i34/CIBCOSapVYvhu9bXJtLPSCVYM0vFW1NL6BEl
 w0v9/4IOlg3m2w5AQK8QCY0Mbs502dSglZPrm2h1nklxGHv7fnWdyjG5frlug0TEAOQM
 3KNQF6MIqmS0PYmVJUJPtD1WDKhZ2zvYGT15rRLgsDEIyc//mIAGCdWHCugJK7aOkl7s
 Whwyvo0uRJhELj3azhDjE6VKzjt1tpnWJj/jgnDXl+DZwXh9vThaKofoGefGDKOQB1Cs
 FCkz0fQKFrYsQRXl0GarlfchXfV2JYlM4EQlvUH1ztkI7gsIhSnIf8LGpz+FcCGRmk1b
 uyPw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777286877; x=1777891677; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z0t2lMK8mMOQqjFYJtMIq0BWSHEnCJiR8+4AnCrJmw0=;
 b=F3xHqwLkjDDIxAMxHtdqtKpMc5ffB7PCAIqKro4Nq+I5LZUuJURQoah9q64vu9WZSR
 RGbZpIY8/43/t84J8bV31SJ8NstPENsQlF5FfF/XbS09n5CJSau69IcQ2Ny3eG7px2DP
 YK3s5pW7PIbJlJzXVyHF8DfAi+lulIN48Iolrsbg9kibiTe9ogyqIltwQ9CDOkZVrE8w
 DcRyl/wRCTiXrVA1azvTaw/yAe3RFSdQFVqZEQ6UQH0BUHK2Aokdbm3wRHdvCq+Qcun/
 g5uUHqvzXfITYDvXTY89KaAQBTDM3C1euVtGzUuLIZacbC7zTrecE2q0E9A2QTXHmbu5
 YRCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777286877; x=1777891677;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=z0t2lMK8mMOQqjFYJtMIq0BWSHEnCJiR8+4AnCrJmw0=;
 b=V0GOJcCLDu3yPsY0ukC2n2IkqDu0hJvQF75qpMnyNdcBMVUGuoYn5k0uGTfnxnsQCs
 OZdzxj0KBUTs/HeBdOUiPpTMfqP5doeOAHskGqI2GSTssA9ybR0RKHGHxIheUsrupR+q
 2uIpuQB+UJkct5XQrC19gHM4lTQSVSNYMLxPIcFFtCS5Np9+pBuCSUlJsQom7h+n2/vF
 AuFiWdjRmKz9IGd1VDyMxcE3ixXzKqKt7i6LHKS0tHtwOS7GvGDx1ilAJG/y0+jE3WiS
 lKK5z8TUErtcNiWH5VmNC8XYl1Y9bKJqw8ebt4GrJYP+Qig73weatLsjc8syF6uwLUeb
 ceqQ==
X-Gm-Message-State: AOJu0YylM/+N3Anl1E6WAni3owiAZEcaAwJn3Kogz7/E/zKUCRtY/8JW
 aQiAh4wlAy50wd5WbjGXlohdYALKnToCjm73HRabd6+U1NLA0y+qCp3IdQtqMnFxfYMt3JSvxN+
 03DbUULqyNsB/WBX3QeJWHJe4pHNYwA9XStNeYprkWg==
X-Gm-Gg: AeBDievulANUOOb9s0XRYsf1FCICp2NsAXTjP/oqO2dHgbFhKfxVe/yAbymUaxl+yKp
 K67wHcLQSWYS5dpuKXFDvfsetA3lo9GvtnJWzcC++TWvo2dDMXTWBcJ7fP2ETz2OZjEOc6qI/ia
 s16tF2YSrul7/OblQbPJ43EDJYB9lBBTWCrV+pmXpVDPnmoky0lwSbc/+5OOAxDHfi+lp6rQ0E8
 zGpeJ6vkuMfGzxlSrQoaFct/CNisgq5vQanrOWlXHqDs9FGcJvqt5PtxJl5RlSLG+w74suT/1/K
 hEWr5ith/mWcFJS+petdT8X7JXm4ScFaQX7GHfftmLC1+Qsyc1yXFF1s+V20WI0hPcgeXux8Vig
 aefca2ZOVCsr5
X-Received: by 2002:a05:690e:1905:b0:657:1da9:7b36 with SMTP id
 956f58d0204a3-6571da98231mr10668146d50.17.1777286876891; Mon, 27 Apr 2026
 03:47:56 -0700 (PDT)
MIME-Version: 1.0
References: <20260422125250.1303100-1-alex.bennee@linaro.org>
 <87y0ic43v1.fsf@draig.linaro.org>
In-Reply-To: <87y0ic43v1.fsf@draig.linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 27 Apr 2026 11:47:44 +0100
X-Gm-Features: AQROBzAuWfBl6vKMDHcIkxAyChVzQ7RDQMDZuaOHzbl4_ymulHU4IgwrU8kBqe4
Message-ID: <CAFEAcA_R-B7QHzSPmR+qhdn_ZRj=hx45Z4WrWaDmjnOpPn=b7w@mail.gmail.com>
Subject: Re: [PATCH v3 00/32] target/arm: fully model WFxT instructions for
 A-profile
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Pedro Barbuda <pbarbuda@microsoft.com>, 
 Alexander Graf <agraf@csgraf.de>, Paolo Bonzini <pbonzini@redhat.com>, 
 Mohamed Mediouni <mohamed@unpredictable.fr>, kvm@vger.kernel.org,
 qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b129;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb129.google.com
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

On Fri, 24 Apr 2026 at 19:20, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:
>
> > This series fully models the behaviour of WFxT instructions. We
> > already had support for WFE for M-profile but we left off A-profile as
> > it has more potential sources of wake-ups. The main one is the event
> > stream which includes events from significant bits of the timer
> > ticking over.
> >
> > The series starts with some refactoring of the syndrome register
> > helpers to use registerfields. We then expand the WFIT trap handling
> > to report the register used. We then implement the event stream events
> > for SEV, global monitor and the timer related ones before enabling WFE
> > for A-profile and then finally WFET.
> >
> > Note on AI usage. As an experiment I previously posted an RFC series
> > with the help of Gemini. This series however is a ground up
> > re-implementation which takes some different approaches on modelling
> > the event stream. In particular rather than running multiple timers we
> > use the same wxft timer and just compute if the timeout or timer event
> > will come first.
> >
> > v2
> >   - I've kept the tests separate, see:
> >
> >     Message-ID: <20260417164328.1009132-1-alex.bennee@linaro.org>
> >     Date: Fri, 17 Apr 2026 17:43:20 +0100
> >     Subject: [PATCH 0/7] tests/tcg: more capabilities for aarch64-softm=
mu tests
> >     From: =3D?UTF-8?q?Alex=3D20Benn=3DC3=3DA9e?=3D <alex.bennee@linaro.=
org>
> >
> >   - tweaks to global monitor behaviour
> >   - STLR/STL will also trigger events to avoid deadlocks
> >   - see under the --- in the patches for details
> >
> > v3
> >   - fixed the WFE exception handling
> >
> > Alex.
> >
> > Alex Benn=C3=A9e (32):
> >   target/arm: migrate basic syndrome helpers to registerfields
> >   target/arm: migrate system/cp trap syndromes to registerfields
> >   target/arm: migrate FP/SIMD trap syndromes to registerfields
> >   target/arm: migrate eret trap syndromes to registerfields
> >   target/arm: migrate SME trap syndromes to registerfields
> >   target/arm: migrate PAC trap syndromes to registerfields
> >   target/arm: migrate BTI trap syndromes to registerfields
> >   target/arm: migrate BXJ trap syndromes to registerfields
> >   target/arm: migrate Granule Protection traps to registerfields
> >   target/arm: migrate fault syndromes to registerfields
> >   target/arm: migrate debug syndromes to registerfields
> >   target/arm: migrate wfx syndromes to registerfields
> >   target/arm: migrate gcs syndromes to registerfields
> >   target/arm: migrate memory op syndromes to registerfields
> >   target/arm: migrate check_hcr_el2_trap to use syndrome helper
> >   target/arm: use syndrome helpers in arm_cpu_do_interrupt_aarch32_hyp
> >   target/arm: use syndrome helpers to set SAME_EL EC bit
> >   target/arm: make whpx use syndrome helpers for decode
> >   target/arm: make hvf use syndrome helpers for decode
> >   target/arm: use syndrome helpers in merge_syn_data_abort
> >   target/arm: use syndrome helpers to query VNCR bit
> >   target/arm: remove old syndrome defines
> >   target/arm: report register in WFIT syndromes
>
> Peter,
>
> Do you think you could take the patches up to here so I don't need to
> hold the re-factoring patches in the tree?

Sure; applied 1-23 to target-arm.next.

-- PMM

