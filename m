Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 580B6C79F82
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 16:37:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3yoj-0004yF-VY; Tue, 08 Sep 2026 12:37:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x3yof-0004wk-18
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 12:37:01 -0400
Received: from mail-yw1-x1132.google.com ([2607:f8b0:4864:20::1132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x3yoc-0007gy-Sg
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 12:37:00 -0400
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-87f4e914a45so1731377b3.2
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2026 09:36:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788885416; cv=none;
 d=google.com; s=arc-20260327;
 b=opv0SH0I9X/nbhp/TT7zXqAKm/ejMRjjbJknq8jEiqzgRgruYD/wbbIQeuSvSLHMgv
 yqk5wd5sz/0paE4+0ESK0+YFPovrpAVJHLH9vHE9eWAxnn4dYPbIT+uG8gwcUoZ6u6C4
 ABlI+y95jWW6BXlGUuuDWs7VO6zPyRBVXJYk9t6KSznu9HpBV/kNxN8Vsezt2ag5UxRO
 8ewyQCXoutrtT1V2/vIaJHyeQj2tfTIbMdbxoFaJMtw8wgWjj4ROZdMEjrPmwC4bMNws
 PQXsQIpJLBuf3FTaQLp6HB6q9W96lAG/7BiTX0xCa+PBDFT92OP0PtAnJSalhYwJcW0g
 QRCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=kMPKmW94kgwgZAVojH9WCIQcTTie/zF3f2l+Liv315U=;
 fh=NDHjwRBaYkyWqybCUFU1a7Y37t6iyQpwF43YHk9Tp64=;
 b=J+VAmGfuJeO0PXpxIstaW9QhTkQmoi7At0nf1gCG+iEY/8mH2ZBKl7gjajoXTIr82b
 UONuvBKv8amIPrdlKB73zKaQocBtcsh1hW3iXo67pJgW99oOrGFEOpQn4GYEfpADGcqy
 eMlPOgzGaqIVAJ+Vh3FJu0mQxaQdpkOHPh+Xs/UuaWbH5SF3HfmGd5U6XqlAXU0LypMU
 j+fZv69dR36luTLPS3X2Khnc+oFxaM0e3E9Ig1c6qvdaXJqnCjbICnbA0q6FjPox5xUW
 pct1J6II8kRdaqWG9bcmyZsgAQMnicW4I4n0JUZ0jQYlz0/RSs3LRoEFOA9Zm2MEOGot
 1Ckg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788885416; x=1789490216; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=kMPKmW94kgwgZAVojH9WCIQcTTie/zF3f2l+Liv315U=;
 b=zsCVhYX9ZZzKV5iveZ9koHG8YJmq0ATKiCeqGAjmYbgMfYgC8fgMGrRUb2fTeycegF
 aEN0Xp2vknF52DMgIK9bqvw5F5+hpZqua8erb6I0+stvMuTw1tBS074b8Rh74ledlB+k
 ssDWvp0RsrsPt46yiAXuCiIZw6dA5/nBwYcVD5uzsx4WA8ZxnNiW2Nx052UenlYtVJpd
 3AIK2SkS5zUbnz6jhEiqduZWOt3Pnh1bV3qFV401WnnJNBd2u8CzI9lDYgH7LmnYDO0a
 HbeRkTegQJVvvsZoQ+SK/Zu+2bQlNMzWPsfNU/XyeVDeLit4KzInKQSVQ8mfwZdkRk+0
 mAFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788885416; x=1789490216;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=kMPKmW94kgwgZAVojH9WCIQcTTie/zF3f2l+Liv315U=;
 b=XjHr22u2kPfsdNPcFUqoKIYu17TQCNXmgdabUtxbL4LN+GbpxcaP+zyNMubtmMD8xj
 TVr6N7MAMfdfTJZi73f+mN66ifXXvbUWL3HaMMZOWyQTmB2rCjRGbALlUAY2fOf5ceXg
 RJejf+0eRHjZoMHOwgDyUPWNf6Mmd/k2qRUVmSuXS4ayeXyPUdKklmk8aerQZIDdDgRy
 sL9gmu2db87UExiYdLIGrrVO/5HIwhrYHatnamcar1nVT/pwYasIBc3aMt4jrXQ+0o0+
 8DA+x9pyLaI2jJBNzhLnAI46mIhez+bZU7fEtKqOTJHFfI2EMC4ADmPsgTAqF4YAC4u0
 6IGQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBw6dGb9nLmbh4bHEKZYarWjar0xnZQUFqb6+2B36cBB4BdUvZj+syh4CwrsV7gG+EzVQNN7d36cCiD3@nongnu.org
X-Gm-Message-State: AFuF++nmCvOH4c2aAIAopfpkckkWqUmm0wn53m0UwEL8aJDseMX+KJrp
 L0RD0xif2ia912581G1tb0Lf0zV0UJfj2bU85W6AVtG0tiAmyTEADZJOjadJYgISdubEzDEmBki
 GjRZVWu429HMUpXqoqW1a65A4/vCFsE8VuEiEulDo0w==
X-Gm-Gg: AYBFou0wM6ptLKiuK1qIN0Q+hOXNq2JexYS66ucQDQOLdsGlekhXkGjxqKPwh0l/ttW
 5mLbypspdTgcd62SfwylYVG1NjYe4n9OjHg+2S8aB5Lxm6MTCwBvgCCfdLQ77nZtWI1AIkPXK6E
 fNZcDBYoyIRmrnN3i8ksQmUyXxtbKHO1+VCHolScvX8Eef2ccvvETqtdyuAy5WwZqLWjbSXyXhD
 0xi/2LKRIlrRVAio7/UJ/y7CRgVxlP2LDqnEjkNM3ZL/g/UCoujVII31IrQP5oXD7TbDace94AA
 l6vPSdbeO2Q5Nw0pBz+PyLzOosrfg7rpCY71VthPSiaYalm4e4/KCsw56ut022Qm1Kt7SeELnBb
 991m5CI4CRIRfnuVPXY+/CSWAkqLB
X-Received: by 2002:a05:690c:2601:b0:873:5ddf:d872 with SMTP id
 00721157ae682-8735ddfda3bmr77509427b3.61.1788885415642; Tue, 08 Sep 2026
 09:36:55 -0700 (PDT)
MIME-Version: 1.0
References: <20260906222926.3714852-1-brian.cain@oss.qualcomm.com>
 <CAFn=p-bQeHAw6KQW2xpKki+a9WMHrQctKXosRG5NHhJ+46jETA@mail.gmail.com>
In-Reply-To: <CAFn=p-bQeHAw6KQW2xpKki+a9WMHrQctKXosRG5NHhJ+46jETA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 8 Sep 2026 17:36:43 +0100
X-Gm-Features: AcwNN1WaZnz7sYUkSUlFQpif_Ksxxd_BUXDD07S8sET9sweFKTeNv-A0Pciv_ww
Message-ID: <CAFEAcA93ZB7duwjS6xuuK_RnJUzrEDPa7V=uaY-v34Z2rdZJrQ@mail.gmail.com>
Subject: Re: [PATCH] docs: bump sphinx_rtd_theme pin to fix --enable-docs build
To: John Snow <jsnow@redhat.com>
Cc: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org, 
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1132;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1132.google.com
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

On Tue, 8 Sept 2026 at 17:34, John Snow <jsnow@redhat.com> wrote:
>
> On Sun, Sep 6, 2026 at 6:29=E2=80=AFPM Brian Cain <brian.cain@oss.qualcom=
m.com> wrote:
> >
> > pythondeps.toml and docs/requirements.txt pin sphinx=3D=3D7.2.6 alongsi=
de
> > sphinx_rtd_theme=3D=3D1.2.2, but 1.2.2 requires sphinx<7 on PyPI.
> >
> > A fresh install of the docs group silently downgrades Sphinx to 6.2.1 t=
o
> > satisfy that cap, which then fails Sphinx's own >=3D7.2.6 runtime check
> > in docs/meson.build.
> >
> > sphinx_rtd_theme=3D=3D2.0.0 is the first release that drops the sphinx<=
7 cap
> > and resolves cleanly against sphinx=3D=3D7.2.6.
>
> Thank you for catching this and writing a very targeted fix.
>
> I did not notice the silent downgrade as I have sufficiently modern
> releases on my base system which our build system happily used
> instead, and none of our CI tests noticed. I'll have to invest some
> time to ensure this is tested somewhere for the future.
>
> >
> > Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
>
> Reviewed-by: John Snow <jsnow@redhat.com>
>
> (I did not test this, but based on the failure logs I saw and the PyPI
> version constraints for Sphinx, I believe this fix is appropriate.
> Peter, would you be so kind as to take this patch directly as a build
> fix? I am taking today off as a sick day and don't want a build
> failure to linger.)

Sure, I can do that. (Though I haven't seen much complaining, so
I expect most people, like you and me and the CI, have the sphinx and
rtd-theme installed on the host and dodged the bug :-))

-- PMM

