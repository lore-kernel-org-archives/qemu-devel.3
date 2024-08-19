Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC866C3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2024 11:47:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sg0qp-0008Aq-H4; Mon, 19 Aug 2024 07:47:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sg0ql-0008A3-Hx
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 07:47:05 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sg0qj-0001mF-IX
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 07:47:03 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5bec4e00978so3355076a12.0
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2024 04:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724068018; x=1724672818; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z7xUVaeYpNcp3nqqDu7OSRJ9tyoFmOSjIZydDdBqto0=;
 b=cJXaOnQYDpA8bjHfgVNx8fJauQkc9EHs/kmllpomaaA45UMTGrgfTrXn18Y8KWR/YT
 vzD3pKydXT52y2dOSl/y4HcG3BkAMuUVfu60YTPtXweTH3SSY6jmJ2sQgiKrf0TSwQg/
 gbebXHgZwjriu0iH6d5duoKzJQw8+QtBNLIcI/8ihS690JXNSVmGAgNdPBDnN3c1Zwxt
 7xlTqGbEHoRnrjidmiwwsZDscbcHh70lIP3oUI8sbAm+k7oOWuMTIBjW49cyMQX9uHLY
 brspDMk7i9wY1t7gri/xAQr1wIbVu0+sGP7yoa3NavtlwOmMPmMN4SyioXQd2K++QOud
 BoKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724068018; x=1724672818;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=z7xUVaeYpNcp3nqqDu7OSRJ9tyoFmOSjIZydDdBqto0=;
 b=RY33tjyYPajM+eXPrYULx8a8f92i/RN+rqMQnp90s4xO18ssvHdgakbpJCEN4kpGTt
 j/hscaRWh2gmJx3YgORzncFHLZ46qSCh+zqNx2mFLKPTIV714vv7ngKos2R6xqmp5oOa
 aU01LTyS/+xs40Hnahuqhnn3Z17Kw/mRKWBGutt0rnHWJ0piYa+q8u91WdLf/cVLXUva
 ywoag2gdKnrnEUN3KF97yVTmVuBLp2AGGVUnsInf76h0LdGIjVR1MFdhJ//5kKo4hIIF
 UIwl+qMlRS50/fhiY8cO2MM2pim0DkGWUMMkXURuDqwAGVvAi404x5Lxa6LXzcfYqb3l
 Q+eA==
X-Gm-Message-State: AOJu0Yxr2Z9owGxVooP/ZNG7inLcncP+T51M6BI6JuiIYQ/IENtm+y4p
 Unkt7fVACg6gkr6UO7UMNlznCI9wflvDZI55r4vTKfzM8o3QqArULTRi5zgCZfLV1WFl+zHHzEt
 a3KJUM69L6BiAfphlwxgKWAiWEe6xSqpV3CcRoph0QtqG3aGq
X-Google-Smtp-Source: AGHT+IHV6xLEhV2D+NuRGuCsv7v2hYP/rYueWxq5iq4N0xDo0hLagPJH7ZL56qQkxzfzPpxysNJpfgcw8YjMOz9jBhY=
X-Received: by 2002:a05:6402:3512:b0:5be:fa58:8080 with SMTP id
 4fb4d7f45d1cf-5befa588190mr2719095a12.3.1724068018180; Mon, 19 Aug 2024
 04:46:58 -0700 (PDT)
MIME-Version: 1.0
References: <20240815144911.1931487-1-alex.bennee@linaro.org>
 <20240815144911.1931487-16-alex.bennee@linaro.org>
In-Reply-To: <20240815144911.1931487-16-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 19 Aug 2024 12:46:46 +0100
Message-ID: <CAFEAcA8+RprE5MQPA1P5WrRcCajeco9ApRyT3p+Va4mbCir6Jw@mail.gmail.com>
Subject: Re: [PULL 15/21] chardev: set record/replay on the base device of a
 muxed device
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Nicholas Piggin <npiggin@gmail.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x534.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Thu, 15 Aug 2024 at 15:53, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> From: Nicholas Piggin <npiggin@gmail.com>
>
> chardev events to a muxed device don't get recorded because e.g.,
> qemu_chr_be_write() checks whether the base device has the record flag
> set.
>
> This can be seen when replaying a trace that has characters typed into
> the console, an examination of the log shows they are not recorded.
>
> Setting QEMU_CHAR_FEATURE_REPLAY on the base chardev fixes the problem.

Hi; Coverity points out a bug in this code (CID 1559470):

> -Chardev *qemu_chr_new_from_opts(QemuOpts *opts, GMainContext *context,
> -                                Error **errp)
> +static void qemu_chardev_set_replay(Chardev *chr, Error **errp)
> +{
> +    if (replay_mode !=3D REPLAY_MODE_NONE) {
> +        if (CHARDEV_GET_CLASS(chr)->chr_ioctl) {
> +            error_setg(errp, "Replay: ioctl is not supported "
> +                             "for serial devices yet");
> +            return;
> +        }
> +        qemu_chr_set_feature(chr, QEMU_CHAR_FEATURE_REPLAY);
> +        replay_register_char_driver(chr);
> +    }
> +}

qemu_chardev_set_replay() assumes it is passed a non NULL
'chr' pointer...

> @@ -693,14 +720,22 @@ Chardev *qemu_chr_new_noreplay(const char *label, c=
onst char *filename,
>      Error *err =3D NULL;
>
>      if (strstart(filename, "chardev:", &p)) {
> -        return qemu_chr_find(p);
> +        chr =3D qemu_chr_find(p);

...but qemu_chr_find() returns NULL if it can't find the
chardev, and we don't catch that here...

> +        if (replay) {
> +            qemu_chardev_set_replay(chr, &err);

...so we will pass it to qemu_chardev_set_replay(), which
dumps core:

$ ./build/x86/qemu-system-arm -icount
shift=3Dauto,rr=3Drecord,rrfile=3Dreplay.bin  -serial chardev:bang -M virt
Segmentation fault (core dumped)

(Compare the non-rr behaviour:
$ ./build/x86/qemu-system-arm  -serial chardev:bang -M virt
qemu-system-arm: -serial chardev:bang: could not connect serial device
to character backend 'chardev:bang'
)

Would you mind sending in a patch to fix this?

>      opts =3D qemu_chr_parse_compat(label, filename, permit_mux_mon);
>      if (!opts)
>          return NULL;
>
> -    chr =3D qemu_chr_new_from_opts(opts, context, &err);
> +    chr =3D __qemu_chr_new_from_opts(opts, context, replay, &err);
>      if (!chr) {
>          error_report_err(err);
>          goto out;

Side note: the "__" prefix is reserved for the system, so
we don't generally use it in QEMU function names. Could
you also submit a patch to rename the __qemu_chr_new()
and __qemu_chr_new_from_opts() functions, please?
(One common pattern for this kind of "function that does
the actual work behind foo()" is to call it "do_foo()".)

thanks
-- PMM

