Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD6EFCA0FED
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Aug 2025 20:32:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ur0Jw-0002UU-Of; Tue, 26 Aug 2025 16:31:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1ur0Js-0002Qa-U6; Tue, 26 Aug 2025 16:31:06 -0400
Received: from mail-qt1-x830.google.com ([2607:f8b0:4864:20::830])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1ur0Jk-0006YP-Lv; Tue, 26 Aug 2025 16:31:04 -0400
Received: by mail-qt1-x830.google.com with SMTP id
 d75a77b69052e-4b1098f9ed9so44242631cf.0; 
 Tue, 26 Aug 2025 13:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756240252; x=1756845052; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qS1kyiVRtTyTgXCTqqt4GbfxdfCiL3EvwaL+Mr9BWCg=;
 b=hh8IvwYoY6Mb0lIpHUeSMWX/eX8MSbYOqRkeukTY8DahaEoYsoo7GolYl4T5MxiU/g
 3uX0YTGvxN8Z/8cuaoHk/6gFsZ9fzG9p1sXowV9CIOjMTfC6UBQfsfVbgAtBuj+jEW0j
 nCs6fEgKD/Hw4sfVC9Wba8Wl5VLN0rcx1e8GmknuvkbvwSxt1e5kV0wMVYzMjlwWEYlZ
 1iz4w8LqryWCgz5Qy7nm/HYgr+/U+pmMPubAi6jNZIJCqq1XEsmYXVxy5sKvbknaNNDS
 0WuHVfLQx1Jd+nK22fmwRu/XG3dLbP8Dr4HHN1zAwCxjBV6/AosNxWu218E7BnUk+9X8
 3cpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756240252; x=1756845052;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qS1kyiVRtTyTgXCTqqt4GbfxdfCiL3EvwaL+Mr9BWCg=;
 b=smtZxCLrpGwg5CYmSDmE/s9YevM03s4GmpWW6cGgL8mh9kXxPL1zd2Tt8rGHgfWs/6
 3A1uKmW5ZGJ23TH6Xk6gnSjWv2iJwdrFnwq5x3m3YjtU7SZ82pI3kk/JykPErh/QTrcU
 3lRgIr/cNM6cl36fNo6s9XSyF/ogt3vjiS4+H4iWn1uN6MyVEORoQuU61fE3ctvWM3si
 +z/HXiq4H+vKqLutXOM4WsmNxKEuKMccIKpkxdwCo+6RdbsBd9uPzXDodsHK1Fw6W+nW
 OwBiG/jIBD1HtzFdkZdrtMbGIW7v2IQbEbWe7qNQeLjSXDjJ7Ot/wbNflqwz42o/slR0
 j7Fw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVoVYSfoLerGp9WqOjULPu0HoTPdKImJ3aJs0YOSDA97WJokY6uM2I+HTWmFyX4JADa47zj2xVy2qk=@nongnu.org
X-Gm-Message-State: AOJu0YxLs/6XR+36EF91/f9J+qa0Ek5dB/HJXLUO5FFnunoPjJo1SIyy
 5k5WXrEFWdgccfGXpIiZC5Ly8M5MYnpkAlKEz2Z7c2eTOtnDCQkoG8jTsdTYNknURwT/a1hgQea
 IkqmyeZ5bLaDUTGYmL1v/kUHZZUyLB1RPylXL
X-Gm-Gg: ASbGncsYqQBhQLyMTmqUsvrxZDsAHoFxWp69GFnwupnK0Hnv+NOpyGuxNzdaEFz7Vvy
 LoAqAPF6IpWlvCr7/MuhEiCv+pRRr+WU+7XTaXoQs03uPx0/ErA1b4Tq1AxlBuzOMYNpxWuKmCu
 mbcage+/Ju5ZSHdPkkn9oWAw7hC1VJB58+eog2Mb0/zZb0SbZ4rOBjMBeAyxJqrqWKsHU8hgoXs
 ZbZrchJUr0PrI3AGu68lNZFnRV/OisTfMl1IfRunV8KAd8ggPE=
X-Google-Smtp-Source: AGHT+IGcMh3Oj3vWvoUG1O9IPz86/voArCZ4Z3VAaT8oRCdCy9KnhE+hcfsPIozMd5vORz1lNyMD7b1kUPEpxFwKDRY=
X-Received: by 2002:a05:622a:5588:b0:4b0:8633:f979 with SMTP id
 d75a77b69052e-4b2aab1fb13mr197006771cf.42.1756240252002; Tue, 26 Aug 2025
 13:30:52 -0700 (PDT)
MIME-Version: 1.0
References: <20250826140449.4190022-1-marcandre.lureau@redhat.com>
 <20250826140449.4190022-15-marcandre.lureau@redhat.com>
 <d65f6de8-744a-4c85-a85b-695bb3893868@redhat.com>
In-Reply-To: <d65f6de8-744a-4c85-a85b-695bb3893868@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 27 Aug 2025 00:30:40 +0400
X-Gm-Features: Ac12FXytJZyjGyk5KoyksasxTaYq7fPe9joXfVGZaNyu6C7t9LiDI03uJyz2smg
Message-ID: <CAJ+F1C+BWMZxvoP=Bz343xspM-wfxAWw+bYYoCdgxxS55d3WHA@mail.gmail.com>
Subject: Re: [RFC 14/18] rust: rename qemu_api_macros -> qemu_macros
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 qemu-rust@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::830;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x830.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Hi

On Tue, Aug 26, 2025 at 6:55=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com>=
 wrote:
>
> On 8/26/25 16:04, marcandre.lureau@redhat.com wrote:
> > From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >
> > Since "qemu_api" is no longer the unique crate to provide APIs.
>
> In addition to renaming, maybe you can re-export the macros from the
> appropriate crate?
>
> derive(Object) -> qom
> derive(Wrapper) -> common
> derive(TryInto) -> common
> derive(Device) -> hwcore
>
> That is, keep a single qemu_api_macros crate for the implementation but
> allow using the nicer #[derive(qom::Object)].
>

Good idea! working on it


--=20
Marc-Andr=C3=A9 Lureau

