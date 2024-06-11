Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36F32C27C5E
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2024 13:17:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sH1Mg-0001Vq-An; Tue, 11 Jun 2024 09:16:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sH1Mf-0001VU-26
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 09:16:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sH1Mb-0000io-3H
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 09:16:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718111796;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Q3iOta0LTb+MN26waluU7zrWgUJpiCUq5p0w+f2JU0Y=;
 b=O7JejXbwpX7hUEK+J7WeERAzrSg2MNZkd2+S8/PIIDgoVRAxIwk39YtmFqQm/xRoC5Qepm
 xpxzTqZ8uc4VL88XhAwV9z84NyvDwpN4ORHfP7EsEnQYh4p1PuzYfpwZ8iX080P7lp+brh
 Kb4keGDtuZoD3TumOBxYKbpeKD/iR3Y=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-318-sJDkLDAsOG26hek81NvQcw-1; Tue, 11 Jun 2024 09:16:32 -0400
X-MC-Unique: sJDkLDAsOG26hek81NvQcw-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-35f306b2e66so109572f8f.0
 for <qemu-devel@nongnu.org>; Tue, 11 Jun 2024 06:16:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718111790; x=1718716590;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q3iOta0LTb+MN26waluU7zrWgUJpiCUq5p0w+f2JU0Y=;
 b=r9gtW+yAZNp6VQ+LOip9fuwktF87SXZbbuoPni1l7y/slhhlVlHhBtksZQqmYcbIns
 DE9V8RSRhYliX2KEkNZSncoENXpbW04RHEJ5eWU8rcM6dRSQun1T1bkoVSvI2KRzFLNj
 JApAVcnrD+XzmEmFT6q7nVnsEw2fKFwwHALJ7UpOpseZdyrV4W5nOGnBem0fEe3CmMBF
 hWTRQZN+R+VnwU0XJMiEuR4GG6LeuYlOx4bapKYbYGR74cKOkPYEvb76gVN86B4FPL6Y
 EEbKouLxbAX+vau8xZZSN4CW2zWoiYxG7BAIjdpnB0tNlw28C9eG/4hIuVsZRWzwVv7N
 Z55g==
X-Forwarded-Encrypted: i=1;
 AJvYcCW9/tcVhWLzUuoSDFKgmLtmlyP/XoZgdu7q1Pr2ea7fBye3EzeNtkgFQJUyxZtd7ZL9/C1gp3KVBGIrqcB+Epr2DJCKMss=
X-Gm-Message-State: AOJu0YzKm/u5iF9FNslAN7v/6LOoKgcitE90BkrY/wSBXi0dCurOidwy
 lJOcZJBrnIdLMIDfdrsUo30PqKLDpdi/NZ5MfGNQhBSMRxswrIhTFJXM2wTmwSo1j9ZsM3heQbK
 VRJksrm2QIhdwCwHxWP+c3mN0E+NejTw8pUXuqyghsEwRcWvzMN7wTXe4D4NpGWYB4r23s80wDU
 Azap1e1R58ufkeK0MY/x8XEkjqLQdxC5SIqVU=
X-Received: by 2002:a5d:5551:0:b0:35f:d07:d34 with SMTP id
 ffacd0b85a97d-35f2b2c469amr2151791f8f.27.1718111790696; 
 Tue, 11 Jun 2024 06:16:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFBspUmwYS9fiouYlLEN85gF7qAom66FGtGs5miIV7lLD9DU1wAz33FfdMy6zSaH6ifZJB7x4kmmDLfi3QW0Yg=
X-Received: by 2002:a5d:5551:0:b0:35f:d07:d34 with SMTP id
 ffacd0b85a97d-35f2b2c469amr2151761f8f.27.1718111790345; 
 Tue, 11 Jun 2024 06:16:30 -0700 (PDT)
MIME-Version: 1.0
References: <cover.rust-pl011-rfc-v1.git.manos.pitsidianakis@linaro.org>
 <ZmgJVGMx81aHjg5f@redhat.com>
In-Reply-To: <ZmgJVGMx81aHjg5f@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 11 Jun 2024 15:16:19 +0200
Message-ID: <CABgObfZrEPQ2btoLwbfH4X7wH7Ly74SXzce0cNNuxejRyGsPHw@mail.gmail.com>
Subject: Re: [RFC PATCH v1 0/6] Implement ARM PL011 in Rust
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Mads Ynddal <mads@ynddal.dk>, 
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Zhao Liu <zhao1.liu@intel.com>, Gustavo Romero <gustavo.romero@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Tue, Jun 11, 2024 at 10:22=E2=80=AFAM Daniel P. Berrang=C3=A9 <berrange@=
redhat.com> wrote:
>
> On Mon, Jun 10, 2024 at 09:22:35PM +0300, Manos Pitsidianakis wrote:
> > Hello everyone,
> >
> > This is an early draft of my work on implementing a very simple device,
> > in this case the ARM PL011 (which in C code resides in hw/char/pl011.c
> > and is used in hw/arm/virt.c).
>
> looking at the diffstat:
>
> >  .gitignore                     |   2 +
> >  .gitlab-ci.d/buildtest.yml     |  64 ++--
> >  configure                      |  12 +
> >  hw/arm/virt.c                  |   2 +-
> >  meson.build                    |  99 ++++++
> >  meson_options.txt              |   4 +
> >  rust/meson.build               |  93 ++++++
> >  rust/pl011/.cargo/config.toml  |   2 +
> >  rust/pl011/.gitignore          |   2 +
> >  rust/pl011/Cargo.lock          | 120 +++++++
> >  rust/pl011/Cargo.toml          |  26 ++
> >  rust/pl011/README.md           |  42 +++
> >  rust/pl011/build.rs            |  44 +++
> >  rust/pl011/meson.build         |   7 +
> >  rust/pl011/rustfmt.toml        |  10 +
> >  rust/pl011/src/definitions.rs  |  95 ++++++
> >  rust/pl011/src/device.rs       | 531 ++++++++++++++++++++++++++++++
> >  rust/pl011/src/device_class.rs |  95 ++++++
> >  rust/pl011/src/generated.rs    |   5 +
> >  rust/pl011/src/lib.rs          | 575 +++++++++++++++++++++++++++++++++
> >  rust/pl011/src/memory_ops.rs   |  38 +++
>
> My thought is that if we're going to start implementing devices
> or other parts of QEMU, in Rust, then I do not want to see it
> placed in a completely separate directory sub-tree.
>
> In this example, I would expect to have hw/arm/pl011.rs, or hw/arm/pl011/=
*.rs
> so that the device is part of the normal Arm hardware directory structure
> and maintainer assignments.

I think that's incompatible with the layout that Cargo expects.
rust/hw/arm/pl011/ could be another possibility.

Paolo


