Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D26AED1627D
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2024 14:41:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0MFz-0001gG-8j; Mon, 14 Oct 2024 10:41:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t0MFx-0001g6-TB
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 10:41:09 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t0MFw-0003Zz-F2
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 10:41:09 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5c948c41edeso3959339a12.1
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2024 07:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728916867; x=1729521667; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=XMgCf0sT5dkpmffIYhDgNL76U3QGMHL0IyhNZM3l5VU=;
 b=JzAKjRVGLgKAFcq++HXBMYKEyxsaaM0DLrR4VXQi6iDs87kt4XpDlsPoDcNO0H+esq
 fpqV5uc0oIQlBuT7Fpofb80tiOpET4s7YS2G3eJrLo1B2XSFXBduXhMrLBGS2yllrhfS
 WP9R+hO3Wh/aMosLflaMHfpxKGadv5EHI2iiPJSuWn90GG45wnaGsrohrsphAcnNWdc3
 qPQJUX8Yidbd+MS2uFEaMNwmzc2OahyE0QpAlkl9QrTOjeOAI0lyO9dH6FUlFv+GCkVR
 KcfUsrA+Y2kWwGbcw5m8/18hpD9JFln/8KO2/bdgJA+epaIA/UFi8syMKyGF3CdO24lA
 zcHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728916867; x=1729521667;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XMgCf0sT5dkpmffIYhDgNL76U3QGMHL0IyhNZM3l5VU=;
 b=wUriamYjZGxR7l4rn6BB6hr7l16dAWw6KeolAqryTzFE53gBj5m2wp1bWlKIOKHcRU
 wz+7JsKLMCDtWpBUEJK5d26g73umABDAYBqZcRLibkm1HSVJ1goUgQDaFv2XeoVizT01
 uDiPUzMD+KD/Jv8Z3SsvK6DMLCtVrDlIuOTKRev00RCqrR7BhOhdf8Lr3TM7/KGauxnK
 2akezniEWaCX7WHJ3X+1yXHfsNfCWtHoFdaILj9xHAIJzDRUxssxkjSW41JMsWx8ZJF+
 dCvuoGRWrqPZvQoSZ+qaznbKMRdkULzgUrk6AgRjx39P2vje3+yRb5i07EgUb4/iSrau
 xTZQ==
X-Gm-Message-State: AOJu0YzQotvJ9G+uFc3dbjS5M0Ya3MUzcNc/HguoenZ9v1AI5tMHOqJC
 nDFs47oAOYjOVJdqNkKG0+e1CJiM3SMV8jhS2Su8TVVnG37gJ8vUZQosejCHy5eBrs/9n608ikq
 OOmCP2NMd0xUfA/Unm2U3Ga2DB0VuwWPGXWF4UA==
X-Google-Smtp-Source: AGHT+IFJ5EQOEWj7QVP8rieFlL61+TTgEY1OQT3gS8TAEARhh9WCpQxotLpwFTzJtVT0UwYcYwoeF+MrQ+2E1zRnhgs=
X-Received: by 2002:a05:6402:234c:b0:5c9:6047:7467 with SMTP id
 4fb4d7f45d1cf-5c96047762fmr5919547a12.8.1728916866817; Mon, 14 Oct 2024
 07:41:06 -0700 (PDT)
MIME-Version: 1.0
References: <20241014143640.196735-1-pbonzini@redhat.com>
 <CAFEAcA_GgntHgo9tP70L1tHVhxXcsgJ0hne-sqHHH2-B+E4oCQ@mail.gmail.com>
In-Reply-To: <CAFEAcA_GgntHgo9tP70L1tHVhxXcsgJ0hne-sqHHH2-B+E4oCQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 14 Oct 2024 15:40:56 +0100
Message-ID: <CAFEAcA80D0D1Yjb6d8TkLi6zmP2gX8NSF_j3uenZrN=tfv9KoA@mail.gmail.com>
Subject: Re: [PATCH] meson: check in main meson.build for native Rust compiler
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x534.google.com
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

On Mon, 14 Oct 2024 at 15:38, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Mon, 14 Oct 2024 at 15:36, Paolo Bonzini <pbonzini@redhat.com> wrote:
> >
> > A working native Rust compiler is always needed in order to compile Rust
> > code, even when cross compiling, in order to build the procedural macros
> > that QEMU uses.
> >
> > Right now, the check is done in rust/qemu-api-macros/meson.build, but this
> > has two disadvantages.  First, it makes the build fail when the Meson "rust"
> > option is set to "auto" (instead, Rust support should be disabled).  Second,
> > add_languages() is one of the few functions that are executed even by
> > "meson introspect", except that "meson introspect" executes both branches
> > of "if" statements!  Therefore, "meson introspect" tries to look for a
> > Rust compiler even if the option is disabled---and then fails because
> > the compiler is required by rust/qemu-api-macros/meson.build.  This is
> > visible for example if the compilation host has a stale
> > scripts/meson-buildoptions.sh and no rustc installed.
> >
> > Both issues can be fixed by moving the check to the main meson.build,
> > together with the check for the cross compiler.
> >
> > Reported-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> >  meson.build                      | 3 ++-
> >  rust/qemu-api-macros/meson.build | 2 --
> >  2 files changed, 2 insertions(+), 3 deletions(-)
>
> Missing Signed-off-by: line ?

Oh, and is there any better order in which to apply this
patch and your other fix, or does it not matter?

-- PMM

