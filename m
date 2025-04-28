Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C794FC369DC
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 14:22:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9PMD-0007Xj-MR; Mon, 28 Apr 2025 10:21:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1u9PM7-0007Wd-GY
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 10:21:11 -0400
Received: from mail-yb1-xb2c.google.com ([2607:f8b0:4864:20::b2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1u9PM2-00086q-0Z
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 10:21:09 -0400
Received: by mail-yb1-xb2c.google.com with SMTP id
 3f1490d57ef6-e637edaa652so3530039276.1
 for <qemu-devel@nongnu.org>; Mon, 28 Apr 2025 07:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745850063; x=1746454863; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/5AV2rcjFxnMYqjywlIgXT36ModyBnbTGwKMojCdUv0=;
 b=q25nekrGQ31xoiADVdapLVmMuZ0iIlLNaVL3dAbLSgIpXqw/uNTUI0bmE8VBiHs4F9
 k/M8zN9b+BvnB0pR6o++47EnSxnC+1mHEb7BMGhiWCSPPbuE+1jr1hS80tbmyDIPIpIx
 7AshQcZMnkn+AsoO5ossQdVlKQrsNom9PeM59d6DR2l8EoJtR7r8m31fRepLH0NPP1xM
 s1y+OL+NOUGFEg5D2YjhjaV6/tXxPSa+IbxOYIWEF/keIpm+7nsHhiMdetr+rF3ccjY8
 2dwqYPu1UJvv62Gfc42XJ9G1zvhHUP0Pz6jC/NIwM0YlR1vMpMAoh0SA5VLJG/ZwvucS
 LOMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745850063; x=1746454863;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/5AV2rcjFxnMYqjywlIgXT36ModyBnbTGwKMojCdUv0=;
 b=Sp9Rb9DRY6C7vhKUvXyvy0koKsEKm4/KTXOhySHKM9EGD6De5i5O1qrBIdUv4h77BB
 4uqWiQC2pww2gSoQXy63vU7dUgUaXSEEGwq3Atc58GwvEe41EAXDZtI6a/zKzdCnuDdS
 gQA4T2CLYW4s4/yMl+M9msiJ/DTAxhoL+uBMB5iwLplWYGIUIYZuWIO8nPDhh5ruo1/L
 LACCopzt8rcKmb/X0cOArfV+QTg1gUMkvdOzyB1G9l/wN5E0eRzNoJ1ZDA7dvNfuR+UP
 M946cp/Jg5O2qtdivgm90H4MJNW4fnZf+wXyY9929tMfhD2mrPUmyXJF8hFFFreroxIr
 1FkQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW+k5nMo4pxey0vbkY1NOGzSg+u11fHFtMwyGZ4/STeW4ftUjnIHOYBJWtIN0wfTOvyAXcYJoMUbS6o@nongnu.org
X-Gm-Message-State: AOJu0Yw7kroEvMNISiUIwLJCG3/VMC8GSSS6ibJPhQmEfzjH/m3+dmPq
 L4h5/NDAR/9VdzR7FQjMUZi4mwsd7psf43rJgfO/PtJGHXllGH1PaucA7Wf2g82pAXtmZyHuNRG
 lOklX8fEjILC68K5Zjx9EFda3/olB007Mz2syig==
X-Gm-Gg: ASbGnctyvL717ehyI/tseSeBqJFQghVLTbVuPNf00oAJBAn8HxjNw/tf2kLpRl8D60i
 e1PzgXNJc+KRqhCj/RywUZnh9nmhbNPPmGYxTuzxXVOgZo8MuLibKMWp7/805KT0AkvWGJ4F0r7
 8qnuOHrIfD/+jOegzAV6yRzic=
X-Google-Smtp-Source: AGHT+IGvbnu5A18NZyy3KoQabDs4CcQPdjJ+h9nkWt+ZyuSf+4N872mHG4NbB2XChGSKt+OBPENw8r4pBA1xgaz6vhQ=
X-Received: by 2002:a05:690c:6d05:b0:702:d54:5794 with SMTP id
 00721157ae682-708541e9ffcmr171135307b3.31.1745850063725; Mon, 28 Apr 2025
 07:21:03 -0700 (PDT)
MIME-Version: 1.0
References: <20250428125918.449346-1-alex.bennee@linaro.org>
 <20250428125918.449346-3-alex.bennee@linaro.org>
 <294fd9b9-6880-477f-a2b4-773f1e5274c8@redhat.com>
In-Reply-To: <294fd9b9-6880-477f-a2b4-773f1e5274c8@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 28 Apr 2025 15:20:52 +0100
X-Gm-Features: ATxdqUGHWS-7X3JRAng4fMhhaz9ExxVdX6hc3tnznIo9BWdMm5kwV2UI-2XE3yA
Message-ID: <CAFEAcA9=YaBw=X+6NUw1D3RPgcSJn0OdmGC2=N=195jjJ7ijRw@mail.gmail.com>
Subject: Re: [PATCH 2/9] gitlab: disable debug info on CI builds
To: Thomas Huth <thuth@redhat.com>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 qemu-devel@nongnu.org, Alexandre Iooss <erdnaxe@crans.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 David Hildenbrand <david@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-arm@nongnu.org, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Peter Xu <peterx@redhat.com>, Mahmoud Mandour <ma.mandourr@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2c.google.com
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

On Mon, 28 Apr 2025 at 15:02, Thomas Huth <thuth@redhat.com> wrote:
>
> On 28/04/2025 14.59, Alex Benn=C3=A9e wrote:
> > Our default build enables debug info which adds hugely to the size of
> > the builds as well as the size of cached objects. Disable debug info
> > across the board to save space and reduce pressure on the CI system.
> > We still have a number of builds which explicitly enable debug and
> > related extra asserts like --enable-debug-tcg.
> >
> > Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> > ---
> >   .gitlab-ci.d/buildtest-template.yml | 1 +
> >   1 file changed, 1 insertion(+)
> >
> > diff --git a/.gitlab-ci.d/buildtest-template.yml b/.gitlab-ci.d/buildte=
st-template.yml
> > index d4f145fdb5..d9e69c3237 100644
> > --- a/.gitlab-ci.d/buildtest-template.yml
> > +++ b/.gitlab-ci.d/buildtest-template.yml
> > @@ -24,6 +24,7 @@
> >       - ccache --zero-stats
> >       - section_start configure "Running configure"
> >       - ../configure --enable-werror --disable-docs --enable-fdt=3Dsyst=
em
> > +          --disable-debug-info
>
> Do we have any jobs that might show stack traces in the console output ?
> build-oss-fuzz comes to my mind, but that uses a separate script, so we
> should be fine there?

If you build with Rust enabled, and the Rust code panics,
then you get a Rust backtrace. But I don't know if that
cares about debug info to get its backtraces: quite
possibly it's an entirely different mechanism.

-- PMM

