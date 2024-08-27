Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5D83C5472F
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2024 05:48:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sip3w-0002Kh-PL; Tue, 27 Aug 2024 01:48:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sip3q-0002I1-C9; Tue, 27 Aug 2024 01:48:11 -0400
Received: from mail-vs1-xe31.google.com ([2607:f8b0:4864:20::e31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sip3o-000086-Re; Tue, 27 Aug 2024 01:48:10 -0400
Received: by mail-vs1-xe31.google.com with SMTP id
 ada2fe7eead31-498dbd7dc89so1468272137.1; 
 Mon, 26 Aug 2024 22:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724737687; x=1725342487; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=83Q8fXSA6TdJgnQS8v8o0f94vkhYCnhwLS34tBt5gkA=;
 b=bfkClpa5lO9dDnEXrfT41FqioVpuIxEkAt0hTO9gdzYO+3pndMex6z1gv7/OXcVAfH
 L2C3TGiRBus0t/la6P9cOHp3kMTC+h+fGcYoRhOpqQbvyA5fx7jUjaL7Cu3rENLpTzLw
 P5qJ+MSZvg1sXD11JSPiemR/HmGTy/F7GGjGbQufCUZA6hSR+Af2IrEykYA84GDM8vgJ
 crn2ThFo7WIXKUJkuo9ToSPeSyOsggfU0SZuUt3GV2PE4M7YqxGqHyUp0NlpuGaL67nc
 CXzFJjN/QArYBHLPFf68dNPY7LOZ2S95Hj8ZseoRVBxO4JIgiqXMLvr7hXJBkmNcZUyO
 JiJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724737687; x=1725342487;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=83Q8fXSA6TdJgnQS8v8o0f94vkhYCnhwLS34tBt5gkA=;
 b=pCRaJR7kDxFg6KhYI5H+islzVaTf56VvrK1UwicMe5J1yoKcn8UXt/BTFhLlCNohJ0
 IjwVbbknkXnM8qlAJq5OVxdQOxXTlXNEo2/+ktvu500x3S+40a1z96aFm24I3vNRXvey
 GoZgQeKcmQgQOV03/XiJ99IM3JJ17BDIDtItVMSWiM92NVc0tThISLs2Eql6v2rzBvM4
 9V5z/PyCMPBhnmXgHKgEucd9JJSYQGLUjNTxY8/A2d2HjuV6368lbvocqGoVPMfh36gS
 sNRTQYQUdTWipguOLMw34c9mPRwHuGz4sL3erIDsSFetATz9irAqz3FsKRRYdodKBTu0
 zv8Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCV3R2c6rGWgS2Kw/MDS+jE+euATgSmN7T0EgIufIsv/4jci/vPMiqX2mbtaZ3i5y0ECH8ljI0EJZaYo@nongnu.org,
 AJvYcCVxB8erMKsgIPTvxy8sbSRzCTiU+9cbsz+fH6HCTpJ52/qzgZkcHZ6ZESBgZrYzz1biZIYHg9mKYOv7dw==@nongnu.org
X-Gm-Message-State: AOJu0YyUYz6Jyk+oqFabnw6pfaiYhaAmsWuO/8qUBINoJOxLq0otbplG
 TdDba9ZB0ZxBmwNjhTB09OYkY4+/ZtD0Gpg4lUgfk2X1UDgWHbSV0/q708jbZSW8E3nmp4i8/qX
 IBTyYw/tnlOn/PzoTlHm6JcvI1uY=
X-Google-Smtp-Source: AGHT+IFq9RnJA+9gLCY+Cj5UdJmQpr5bG93vBl3ZASBHwdHA+NGy82wPd3EUM0dFgY7EWmF4XKN7hCMujhCrEIGMjWM=
X-Received: by 2002:a05:6102:548f:b0:493:da83:33fa with SMTP id
 ada2fe7eead31-49a3bc83167mr2258288137.21.1724737687116; Mon, 26 Aug 2024
 22:48:07 -0700 (PDT)
MIME-Version: 1.0
References: <20240826152949.294506-1-debug@rivosinc.com>
 <20240826152949.294506-4-debug@rivosinc.com>
 <da021104-6836-4e5b-a8a4-991f975c553c@linaro.org>
 <Zs0jURx7jbgd64jV@debug.ba.rivosinc.com>
 <056740af-1b61-426a-940d-3ca118ebd081@linaro.org>
 <CAKmqyKOni_x8bw_3TfdV=xGg0MX-NPnPgo84dsKojdRqO_j36g@mail.gmail.com>
 <db8fa0c7-5c8b-45ca-a0e2-e660ffe7cd42@linaro.org>
 <CAKmqyKNN28WeR=UsPjnhFZi+W9imeE6v3tHsX5bj_OwdP7XyiA@mail.gmail.com>
 <20467a9c-e12d-4d36-9439-4ae27045077e@linaro.org>
In-Reply-To: <20467a9c-e12d-4d36-9439-4ae27045077e@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 27 Aug 2024 15:47:40 +1000
Message-ID: <CAKmqyKOTVWPFep2msTQVdUmJErkH+bqCcKEQ4hAnyDFPdWKe0Q@mail.gmail.com>
Subject: Re: [PATCH v9 03/17] target/riscv: save and restore elp state on priv
 transitions
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Deepak Gupta <debug@rivosinc.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, 
 palmer@dabbelt.com, Alistair.Francis@wdc.com, bmeng.cn@gmail.com, 
 liwei1518@gmail.com, dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, 
 jim.shu@sifive.com, andy.chiu@sifive.com, kito.cheng@sifive.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e31;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe31.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Tue, Aug 27, 2024 at 2:29=E2=80=AFPM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 8/27/24 14:03, Alistair Francis wrote:
> > On Tue, Aug 27, 2024 at 1:58=E2=80=AFPM Richard Henderson
> > <richard.henderson@linaro.org> wrote:
> >>
> >> On 8/27/24 13:53, Alistair Francis wrote:
> >>> Exposing the *envcfg CSRs to userspace seems tricky as everything is
> >>> currently built with the S/M CSRs removed from user builds.
> >>
> >> It is as simple as moving them out of ifdefs, then initializing them a=
s needed in reset
> >> for CONFIG_USER_ONLY.  That's what we do for Arm.
> >
> > Is that really better though?
> >
> > Then we have these CSRs that are included in the build, so people can
> > write code that checks the CSRs, but they are never actually changed.
> >
> > I guess it simplified the CONFIG_USER_ONLY checks, which is handy and
> > your original point. But it seems like it is clunky that we have these
> > CSRs that are kind of fake
>
> They're not fake.  They're a reflection of how the system-mode kernel con=
figures the
> system-mode user environment.
>
> The u[bf]cfien variables introduced in this patch set are an indication o=
f this.  Within
> this patch set they're always false.  But the intent is to implement the =
(proposed) prctl
> syscalls that will set them to true (on hold waiting for kernel abi to la=
nd upstream, but
> were present in an earlier patch set revision.)
>
> The correct implementation of those syscalls, in my opinion, is to set th=
e corresponding
> [ms]envcfg bits.  Just as linux-user/aarch64/target_prctl.h does for SVE =
et al.

Yeah, that actually does sound better.

That sounds like the way to go then

Alistair

