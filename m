Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 243FACD4840
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 18:03:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMUyU-0007mS-4g; Mon, 11 May 2026 14:03:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wMUyS-0007m1-Do
 for qemu-devel@nongnu.org; Mon, 11 May 2026 14:03:24 -0400
Received: from mail-yx1-xb131.google.com ([2607:f8b0:4864:20::b131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wMUyQ-0004sj-KG
 for qemu-devel@nongnu.org; Mon, 11 May 2026 14:03:24 -0400
Received: by mail-yx1-xb131.google.com with SMTP id
 956f58d0204a3-6587cee8b57so4933435d50.2
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 11:03:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778522601; cv=none;
 d=google.com; s=arc-20240605;
 b=VvE7kEKb/OjD7NWRJ78vPMC++jm1HU71XBuvwnC3irMlb2+kMPxf4uluu/oxd3Ib0T
 4eeCgow8Xs8LOg6PyuFIaeD7xgT8o+AKvYZfSgN7KsKoGbci7MeWbTmZO2KftbC+mxUC
 DkM9f78qR+4hJvtQnXcrMqYYR6kmRzPmL7ETY45Qh4OmA491+adKeXVFogZBpCbIxETR
 +gxJCLKSrnyR8g/fiJsAdLHCnBFX+T6zwDwVm6zjYBz3MHcsYPaVwh5ZluJtpFrHoml5
 RpAKmKD78KAfpkREctUR5ErR88m2tA87bgGyQ7hcd5Z8DOfi2N6obCHVBmj+sBiCZzP6
 RdOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Hjr3DF+VRICYio52f8Kesr9yiR5N06OIx3qPy2x8ZOU=;
 fh=D9TiOsAcOSpRlHrkA38ELZyIVSvZmg48LLzTtJLYv+0=;
 b=B7KX3W5kxWTApaO1sYAUdlzx98aXy0KcSm6vtdLVCsgYb2EmisMaDMfOquye5BUK7y
 Q7lTfMEktAD9RivTWvV/xU++B6EPnl/br5nC8B1apV4D0RkWcQyuUsy9vso7+/riStKJ
 w06nD8sqcjDEUSGA4hLtS3FuMXQZiOpHUcxzBYBzCajhRBs7ZDPs2X8wkpxMMkg6bPfI
 Y3ZzRuMkWrfE5u1cj3bri9DCl3NLCpYIHO+sqdvv2gR/ofyUVA/wiCwGTols9BIkd2Xi
 uLC+k6IbNMpl17JpR3YA4Ukj54PEyJOVnsukyMxdm5ZaOPjqd6yfp2UTpyqmWkTOYceP
 rjng==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778522601; x=1779127401; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Hjr3DF+VRICYio52f8Kesr9yiR5N06OIx3qPy2x8ZOU=;
 b=xQ+jZBy+3jmdY/AylH+tt4+0djS5iltsCkaeLBEN45zTqevFG560TnbG8e8aWgCm21
 5kjp121ORGeADDrk+9dPmSHWGpAl3V2bM7RG+zmBnbv7a4NEYxdBKYI8e50n42mBSamh
 KrD9ZCsRlNcjFiQguDHhhnV83bBBRjotfuO8WKoXot58VdaaZKoyRSF5tfytMIJRnxkt
 pauCaExATQ6KcDRYLYfXrH/KmrXYySWDf475u2eqPitMOQYtqXzI18KBRWLaEPi9vy1v
 LCmIoRKOHfO+WHCuAGxOwyTPn2MtfCdFjSiF8AUOkX1n5b2/csTYSUvGEBBtIHVWOvDP
 yDCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778522601; x=1779127401;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Hjr3DF+VRICYio52f8Kesr9yiR5N06OIx3qPy2x8ZOU=;
 b=GFo5xuUaRrMzw3RTpmPGSX5J9q6ePxW6BCzsmIZ4KFZ94QAer1rgctqxhcE04nTtMN
 Cx0z6bB5WxLD0843U+1U9aaM9mYHFL3+tHg1MlHB4Cg07fMI5SHS4DtjTq2Tdu7iCyca
 8w5jmkQf4QhrbmFvaYKFlvGbj1sELb/1b8bPQIeLcax/GI3KdMktcwgSAbi3+4MAKrwF
 40cer87NRLkdBT8dPmLauJSpe2d661H0E+PtSR1jq1Zl3svSGeAA+kfSZvTfPQRM17Od
 0ZNNXYT3lT+2mrgT/sSMNtmokb/BJnnotJq2/a/juPqgx9aZJw14HPffT1b5Dueb9fIf
 3o5g==
X-Gm-Message-State: AOJu0Yy7IYzGrgJlT9hog+7rKPWCqbDAF4Y65w0rb4plniFyIH3sVf/R
 fRRxgsSG9HbpI+otLBhodLdpRUupj4j+tJwmEFKqqfqWzZHf+c/dWCtGroTx9iNL6gIpiIDG23Z
 W0TfcXLakoc3D6qGk/Z4XxBSNON5m2Ostur9XkEE2LBT+slkl3lTZ
X-Gm-Gg: Acq92OE7lSc5Hv/dAypAyK0dQw+0cGw4VNl/YWlfqFLJqOkGOWDoiESUZxXHrBkleHU
 pt7ExcDtFllQVU1vu6LwJey3EYpLfHWr3Qd09p8x96VtGk1aTvCAjSAoFx2P97v9v6zIAi4JpcG
 dllk0dhmaCK0P6/xjkJqXsNWORGhRtZRcmOqbVYPx0etFRVenXu2cna2K3LolgiuqBd99QrL+gN
 Skp4WlYz67GWLCl0KuGbVX47zqQthRdIZMXI2+3yP8enkUvXH+vyAShQ4PE9NDXGmKzCbhAfrD7
 TOkX7EYDZ96ZxHIiMv63QSF7EhkNvPJRpiIDCVbQOX7JVxeb9xDRj4qj2wwAKf0HiOo=
X-Received: by 2002:a53:de0c:0:b0:656:30a1:70f3 with SMTP id
 956f58d0204a3-65c798d3827mr19647273d50.14.1778522601207; Mon, 11 May 2026
 11:03:21 -0700 (PDT)
MIME-Version: 1.0
References: <20260511152019.1316898-1-peterx@redhat.com>
 <CAFEAcA_Hk5EnPWK3Ho1fQVeN0o+2VFjjjz+1sZQk2f3f_CRmWg@mail.gmail.com>
 <agIWHJExoRQqfcNT@x1.local>
In-Reply-To: <agIWHJExoRQqfcNT@x1.local>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 11 May 2026 19:03:08 +0100
X-Gm-Features: AVHnY4K-XJbsuYU9Y80LmLd3Z5XbKW6rKZpbR7q7Pmo1YW-ZBkdoZGrDC8fS7EU
Message-ID: <CAFEAcA-Tup_NPTTi3x0xk_thyku8yN3qNGvzJRt8A0_vJbQZ7g@mail.gmail.com>
Subject: Re: [PATCH v2] migration: Fix possible division by zero on calc
 expected downtime
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Juraj Marcin <jmarcin@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b131;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb131.google.com
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

On Mon, 11 May 2026 at 18:47, Peter Xu <peterx@redhat.com> wrote:
>
> On Mon, May 11, 2026 at 04:47:22PM +0100, Peter Maydell wrote:
> > On Mon, 11 May 2026 at 16:20, Peter Xu <peterx@redhat.com> wrote:
> > >
> > > Commit dd4fe8844b changed the reporting of expected downtime behavior, so
> > > that the value will be calculated on-demand.  One side effect on the change
> > > is QEMU will allow the calculation to happen anytime even if there's no
> > > transfer happening for a short while.
> > >
> > > PeterM reported an ubsan report from clang when running migration-test with
> > > aarch64 binary on x86_64 hosts.  I can also reproduce if I run the test
> > > concurrently so some of the src QEMU may not get chance to push any data,
> > > causing mbps to be 0:
> > >
> > > ../migration/migration.c:1051:12: runtime error: -nan is outside the range of representable values of type 'long'
> > >
> > > Fix it by properly handle both Inf and Nan.  One note is we can't use
> > > ">"/">=" check here otherwise we cannot cover Nan.
> > >
> > > Link: https://lore.kernel.org/r/CAFEAcA-MYH6C39xO0OLx4-M5pKurJpurwRsMqZe9q=W-NShAbw@mail.gmail.com
> > > Reported-by: Peter Maydell <peter.maydell@linaro.org>
> > > Fixes: dd4fe8844b ("migration: Calculate expected downtime on demand")
> > > Signed-off-by: Peter Xu <peterx@redhat.com>
> > > ---
> > >  migration/migration.c | 18 +++++++++++++++++-
> > >  1 file changed, 17 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/migration/migration.c b/migration/migration.c
> > > index b6f78eb3ac..e4103cd3f0 100644
> > > --- a/migration/migration.c
> > > +++ b/migration/migration.c
> > > @@ -1044,12 +1044,28 @@ static bool migrate_show_downtime(MigrationState *s)
> > >  /* Return expected downtime (unit: milliseconds) */
> > >  int64_t migration_downtime_calc_expected(MigrationState *s)
> > >  {
> > > +    double expected_ms;
> > > +
> > >      if (mig_stats.dirty_sync_count <= 1) {
> > >          return migrate_downtime_limit();
> > >      }
> > >
> > > -    return mig_stats.dirty_bytes_last_sync /
> > > +    expected_ms = mig_stats.dirty_bytes_last_sync /
> > >          migration_get_switchover_bw(s) * 1000;
> > > +
> > > +    /*
> > > +     * This "<" check covers two cases where we want to fallback to
> > > +     * INT64_MAX, the 1st case is obvious, but the 2nd is not:
> > > +     *
> > > +     * (1) when expected_ms is Inf, or anything too big for int64_t
> > > +     * (2) when expected_ms is Nan (division by zero), evaluation of this
> >
> > This should say "zero divided by zero" -- general division by
> > zero gives Inf, and it's only 0 / 0 that runs into NaN.
> >
> > > +     *     if clause will be FALSE
> > > +     */
> > > +    if (expected_ms < (double)INT64_MAX) {
> >
> > This works, but maybe we should write it out
> >       if (isnan(expected_ms) || expected_ms < (double)INT64_MAX) {
>
> I agree using isnan() is better than comment. Though code in the patch for
> the next line here is:
>
> +           return (int64_t) expected_ms;

Oops, yes, I got the sense of the condition wrong.

> Do you think below should work?
>
>     expected_ms = ...;
>
>     /* For isnan() (0/0) case, we can return anything; return MAX too */
>     if (isnan(expected_ms) || expected_ms >= (double)INT64_MAX) {
>         return INT64_MAX;
>     }

Yes, this will work. But I think rather than "return anything"
we ought to say why what we're returning is a sensible value
for the use case we have. How about:

/*
 * If we haven't been able to transfer any data, the result here
 * could be NaN (for 0 / 0) or infinity (something else / 0).
 * Return INT64_MAX as our best approximation to "this will
 * take forever to complete". If the problem is transient
 * (e.g. we just haven't started to transfer yet) we'll
 * recalculate to a more accurate figure later.
 */

?

-- PMM

