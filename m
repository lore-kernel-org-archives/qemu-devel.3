Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CBF4C3271E
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 05:37:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRmTX-0001AB-5A; Thu, 11 Jul 2024 01:36:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sRmTT-00019X-IY
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 01:36:11 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sRmTR-000430-AY
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 01:36:10 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-58b3fee65d8so567482a12.3
 for <qemu-devel@nongnu.org>; Wed, 10 Jul 2024 22:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720676166; x=1721280966; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=nF+Ec1/UUMdkOf4xrF1BVMjzYZ0NsBz4P4MdTsqs9T4=;
 b=kkxUzWCxYEK3VMhFcEf+IwanyUb17YlE0IDGaF1Exzvv9OM2yAkgoh6Ts32jqWADer
 CvuuQFk/SiRHzWWCPSrJPrj7nK7BzZMu2W3M9r4UafUp/BGNF7U2iiieKA3VHIr++UMR
 9w2+eChkzese4Ul0oO5v0kIN4dsjPS8MvaHBBoZGRSouufA1hs6LnfokYlllSU0hk/QJ
 ukJryMxqu3l4MVmGEH4+biwDenaLrInPzZOhA8i3LbjW/xLmm7tE/plq/BFXJ/7NFUKA
 0K5hXAAdHqQgG84BzaDDEOoBDJucWvasOuP72mp8s1r4UjP+zxqHurUaUut0GAyZG3If
 oL0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720676166; x=1721280966;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nF+Ec1/UUMdkOf4xrF1BVMjzYZ0NsBz4P4MdTsqs9T4=;
 b=Gk1jRso+gn9Mudw65NeGcK8g81wM+ErrQ0auqx61Jq0z5WNsF7ue/Gg2zMkyzG6oFz
 GEvcif5fmnloM5kWx6ZGCIoDeSDAiy/GWj+xiZ6fFWZfktgpxTNshAeLa6L4Yx6f8xFy
 rR2j+ds96ihBP+VurQ0RHBmXlQDJVIq/+Qb0cc59F6GPcgNPNAwnJs5H0V7rW3B+01BU
 G9QGYuadrW15U6Fn6SxdGkEi1MdxfZONL1Pi6K4QSEm336K/R4VzZXpV5I9jU4GMtUkf
 5Debni7QtL9n7KhLpCSVwkNiEdTWkSTyV2cpXeSGbCNOP/6ti2y92fRry/R5517YI+b9
 rq3Q==
X-Gm-Message-State: AOJu0Ywkwe+XAxmi1flogbOY4KVMbkgCbO1sBpjH1IuG/pGtXCX3AMFK
 e3uVO4ytrEuWGxesxQ4i2hHYsFrTzz/LmWPWhwV0HQNzDXsb6siGMeVj2VaFcXJR916WrLQp44L
 Wy6FzoyNHDtqQVI1+zTXMBx5jgiR+LHk2cKdyYA==
X-Google-Smtp-Source: AGHT+IFRWdFg6JyfVjFZ3Tw5rFuuaY+uwHIo6zMIH5ug0pmWcX4h7C/ILOCPBHD7XD8GFRDEbHtOJA+efKUTFIC5UZc=
X-Received: by 2002:a50:cc83:0:b0:57c:61a2:ed47 with SMTP id
 4fb4d7f45d1cf-594bb580772mr4092117a12.24.1720676166307; Wed, 10 Jul 2024
 22:36:06 -0700 (PDT)
MIME-Version: 1.0
References: <rust-pl011-rfc-v2.git.manos.pitsidianakis@linaro.org>
 <0fde311846394e9f7633be5d72cc30b25587d7a1.1718101832.git.manos.pitsidianakis@linaro.org>
 <Zo9duWzshTd30EZd@intel.com>
In-Reply-To: <Zo9duWzshTd30EZd@intel.com>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Thu, 11 Jul 2024 08:35:49 +0300
Message-ID: <CAAjaMXYr4Z9-wjg7K1aZeQHgJMzb9xD72+5FykKTDNxTySwqwg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 3/5] rust: add PL011 device model
To: Zhao Liu <zhao1.liu@intel.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, 
 Mads Ynddal <mads@ynddal.dk>, Paolo Bonzini <pbonzini@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Gustavo Romero <gustavo.romero@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x533.google.com
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

Hey Zhao,

On Thu, 11 Jul 2024 at 07:05, Zhao Liu <zhao1.liu@intel.com> wrote:
>
> Hi Manos and all,
>
> On Tue, Jun 11, 2024 at 01:33:32PM +0300, Manos Pitsidianakis wrote:
> > diff --git a/rust/rustfmt.toml b/rust/rustfmt.toml
> > new file mode 100644
> > index 0000000000..ebecb99fe0
> > --- /dev/null
> > +++ b/rust/rustfmt.toml
> > @@ -0,0 +1,7 @@
> > +edition = "2021"
> > +format_generated_files = false
> > +format_code_in_doc_comments = true
> > +format_strings = true
> > +imports_granularity = "Crate"
> > +group_imports = "StdExternalCrate"
> > +wrap_comments = true
> >
>
> I find it's stiil necessary to strictly limit the width of the lines by
> "error_on_line_overflow = true" [1].
>
> Currently rustfmt defaults the width limitation with "max_width = 100",
> but it has bugs and doesn't always work. For example, the line of
> rust/qemu-api/src/device_class.rs:108 comes to 157 characters and is
> ignored by rustfmt, which doesn't even fit in one line of my screen!
>
> Of course I think it's feasible to manually review and fix similar cases,
> but it's definitely better to have readily available tool that can help
> us rigorously formatted...
>
> [1]: https://github.com/rust-lang/rustfmt/blob/master/Configurations.md#error_on_line_overflow
>
> -Zhao

Thank you for pointing that out, I hadn't noticed it! The problem is
that macro definitions are also macros and macros aren't formatted
because they have to be expanded, IIUC. I agree that a hard error on
an overflow is necessary for readable code.

By the way, my usual go-to workaround for this bug is to format the
macro body outside the macro_rules! { } scope, (rustfmt works even if
the code does not compile) and then put it back in.

Manos

