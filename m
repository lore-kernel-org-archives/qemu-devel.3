Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38087D16265
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2024 13:45:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0LOG-0004yc-48; Mon, 14 Oct 2024 09:45:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t0LOD-0004pm-23
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 09:45:37 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t0LOA-0004e8-LR
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 09:45:36 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5c9634c9160so2016782a12.2
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2024 06:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728913533; x=1729518333; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/x3jduf9qofInp9xJhR8JL0oMBSpjfQzzIuTQVRDTp0=;
 b=fcbfi80qr07jqGYGaAYqB/Zr9+es8n1aRjiOlg2QbDBnRbhClVlT8R7an9NAFnM47U
 Jrh8D4LfL/78FjzDlJDfSn/9Xzbl9GjHjC0OdWDF1H1OTLKOQ9pIcDZ+KdOOHIE4rgzx
 2LPt53jBRbdtXTYtV3CzUtflG+af9/11xd6/uu6oq5cf2ugfVfLMncnz/vPWEZXI7cso
 kVReIyFXUOx1UMgLpJ185mAip/cOtZxFYlmKgEptpqAwZnZi9UxVGisCcK4fgBTTyc1S
 2BcaWEoTWYdj6C+5ARnI5TrJys35BnqOu/+ym97pfRUoqDCU4TcPS6KJJyPMiIGvBbm2
 MOnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728913533; x=1729518333;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/x3jduf9qofInp9xJhR8JL0oMBSpjfQzzIuTQVRDTp0=;
 b=PfyfoDZ0qbYsZ1MwtrVVjncoauTsRgRJB8YLX4zWou3ddvylW68YGOFyJB+S8ehPyp
 cBUWTlp7jP8mfIsP/hlCsYFq9wr02E/Eal9DnnhuVaHZv25FVAmHVNgdsH/lHh5EO1fH
 kFgMcLy5jeE1lA0Y7Bw06oIk5XKMo92eoCauh6GbnQvZBB5oD/pD866LSCcJzqkl6JPm
 1tZ6TI0v7+24XhePvfXLbFoXhEsZY8PVu/9CimxBLRBecaovUy8YrqvfzzZwIDxqQeL2
 dT5LkXVLTtLj1l55PNOcMlh5PFKikaYMbsyvYxi1+OyXXG4HC64C27CtUQWNID8PsfxR
 oTvQ==
X-Gm-Message-State: AOJu0YzohRgOOPYPI0YV47ms04tEi9rFe32O+C059vChqFRVOjXSqwKb
 LbHKnigP68ApU+qWfZplWWAaLFjG+dbpzGfRt91nR/CQBwAICY6CaU6VAADAfT7QMrwAUDjkHVP
 ugSwrB4M+Zf+ht1+SKqyuVteBevoORlUyA+/VYA==
X-Google-Smtp-Source: AGHT+IETA7qFEvTpdBaB1orEvPun42G2vPrYiyE40r8yKKj3tksVUIqhcBKAoOR6V7lc5KTaGMSqKcBJgPcy2RY7uEE=
X-Received: by 2002:a05:6402:4410:b0:5c8:8668:e564 with SMTP id
 4fb4d7f45d1cf-5c948d79b88mr7929170a12.30.1728913532620; Mon, 14 Oct 2024
 06:45:32 -0700 (PDT)
MIME-Version: 1.0
References: <20241014110113.173946-1-pbonzini@redhat.com>
 <CAFEAcA-8wdDV4fziAj5FqfR2isjdAvLxXZHvqN0=GewDNS9iLA@mail.gmail.com>
 <CAFEAcA_vUxNXRNnWtDd1DeWmC8dDT64VwvB8yswnjp5QzyOt0w@mail.gmail.com>
In-Reply-To: <CAFEAcA_vUxNXRNnWtDd1DeWmC8dDT64VwvB8yswnjp5QzyOt0w@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 14 Oct 2024 14:45:21 +0100
Message-ID: <CAFEAcA9Kjz7BT1erMfaX+Yd7Hb+Cj=s5dPD6RFxxQvR-bGVkeA@mail.gmail.com>
Subject: Re: [PATCH] configure, meson: synchronize defaults for configure and
 Meson Rust options
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x535.google.com
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

On Mon, 14 Oct 2024 at 13:09, Peter Maydell <peter.maydell@linaro.org> wrot=
e:
>
> On Mon, 14 Oct 2024 at 12:45, Peter Maydell <peter.maydell@linaro.org> wr=
ote:
> >
> > On Mon, 14 Oct 2024 at 12:01, Paolo Bonzini <pbonzini@redhat.com> wrote=
:
> > >
> > > If the defaults for --enable-rust ($rust in configure) and Meson's ru=
st
> > > option are out of sync, incremental builds will pick Meson's default.
> > >
> > > This happens because, on an incremental build, configure does not run
> > > Meson, Make does instead.  Meson then gets the command line options
> > > from either coredata.dat (which has everything cached in Python's pic=
kle
> > > format) or cmd_line.txt (slow path when Meson version is upgraded), b=
ut
> > > neither knows about the rust option, and the meson_options.txt defaul=
t
> > > is used.
> > >
> > > This will cause have_rust to be true if rustc is available; and the b=
uild
> > > to fail because configure did not put a RUST_TARGET_TRIPLE in config-=
host.mak.
> > >
> > > When in the Rust pull request I changed the $rust default from auto
> > > to disabled, I should have made the same change to meson_options.txt;
> > > do it now.
> > >
> > > Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> > > Reported-by: Peter Maydell <peter.maydell@linaro.org>
> > > Reported-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> > > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> >
> > This fixes the issue I was seeing with my local
> > incremental rebuild.
> >
> > Tested-by: Peter Maydell <peter.maydell@linaro.org>
>
> ...but this change broke 'make vm-build-openbsd', because
> meson-buildoptions.py fell over with an error from the JSON
> decoder:

This happens also on the macos-14 CI job:

https://gitlab.com/qemu-project/qemu/-/jobs/8078308341

Same
json.decoder.JSONDecodeError: Expecting value: line 2 column 1 (char 1)

error and backtrace.

-- PMM

