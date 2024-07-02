Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 183E4C3064D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 15:25:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOfMX-0008Uw-Hw; Tue, 02 Jul 2024 11:24:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sOfMU-0008UD-Ex
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 11:24:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sOfMS-0007qO-NM
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 11:24:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719933839;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k6W/7bz4FU2a2dBYdjgKVFXY9KyO5EeqkZZHe/j9S6c=;
 b=Pqae6w74dvyTYIOqwxex5FBsHI6VmRn+N9DPXC/hn6YXz4gHL8iVHb4YV5EHFiZyaW5NUd
 nAi0Ntavl/qx1exN9rcjDDhA1VRPTY4cNNEir9GTg27XRq5OMA9zfu5YU569aTDmLPZC6O
 nnrQGPbNuKcgyE/hAsSBaLFKrUD7glg=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-4qKsBVcMNx6YDDCzwc6aDw-1; Tue, 02 Jul 2024 11:23:58 -0400
X-MC-Unique: 4qKsBVcMNx6YDDCzwc6aDw-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-52cdd8ca5a8so4426295e87.3
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 08:23:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719933837; x=1720538637;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k6W/7bz4FU2a2dBYdjgKVFXY9KyO5EeqkZZHe/j9S6c=;
 b=MRDlJwnzeYM/hDvoFRG1GnIIQdvQ35LvVTGLEoud9pBOFSZcXO9S+rYnMLh6adG0jI
 M/vXkRgBop13xgZWK0OIU1ypjGQR6NiurmZLY5QxdX/ib0nT2xWi89mdtoBKfZ1mcRx0
 ZtOxLq2qR6vH22bBz1f0SjRcCcS5LAYjfIrSJEb8t6juCsRnU0jcZnkSPkTKl7OnAZ0s
 CtRT28gEQhNLFx+1Ol8jgZUOTkRSGG++eQR+GLpKB5IKscMTzFtohortJTeI0douw30S
 gGHCo5gq+Ccz+47e068e56sPeEQIfmDv3eCAjlB3hHr1hPunNvN3CU4b4z0mnXaS3Wg2
 mW5w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVx4gX4VIgeSE9avIz3e3k1lhyxvZ7FD2CQDClfMxaap9VqH2YCrNCV8ek1uLZ+SBS9PSeUdauP7bxALMKONISr3N6YR+0=
X-Gm-Message-State: AOJu0YzqmTUkoGEB66LA/krziMhwg/YBbOYVTL24qhE9m5NrbhrrnWaN
 IkfytdpGn8D9XgP+opXksjmM62fzoNmI0gVNirXsxC+ScTyL1xb27bqiTBD3vkbBJEONoRo2e9o
 1jAvKwpzecWv0wYlFw0IqXW70Qjx0wQaQnVNiIW2I0z9GDHddRnp0AXX5wYzqL9nkeMRAkfiHir
 L/pyxDnBBZuteDA0ZXUea4YMl93ZY=
X-Received: by 2002:a05:6512:3048:b0:52e:9423:867f with SMTP id
 2adb3069b0e04-52e94238714mr929e87.36.1719933837086; 
 Tue, 02 Jul 2024 08:23:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEXC5f6z6WzBpsZmzAZcin2h9IL0FWRSBxXpp75jdbJlbQC4dOMN1sjRfi91MceDBfSeaRfoy9fq+OUIZs/eHU=
X-Received: by 2002:a05:6512:3048:b0:52e:9423:867f with SMTP id
 2adb3069b0e04-52e94238714mr915e87.36.1719933836711; Tue, 02 Jul 2024 08:23:56
 -0700 (PDT)
MIME-Version: 1.0
References: <rust-pl011-rfc-v3.git.manos.pitsidianakis@linaro.org>
 <e74803e6b570ab36ebc538dd84dc7c4bc2fbe4e7.1718827153.git.manos.pitsidianakis@linaro.org>
 <ZnmkN2PL3r-2sxqe@redhat.com> <g03mb.04m2bqm0mj1q@linaro.org>
In-Reply-To: <g03mb.04m2bqm0mj1q@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 2 Jul 2024 17:23:44 +0200
Message-ID: <CABgObfZP9gksqoUSHDdxwRmadYJpza4EVNd=FoQYQXaO+Nrzww@mail.gmail.com>
Subject: Re: [RFC PATCH v3 1/5] build-sys: Add rust feature option
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9_e?= <alex.bennee@linaro.org>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Zhao Liu <zhao1.liu@intel.com>, Gustavo Romero <gustavo.romero@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, rowan.hart@intel.com, 
 Richard Henderson <richard.henderson@linaro.org>, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Jul 2, 2024 at 4:44=E2=80=AFPM Manos Pitsidianakis
<manos.pitsidianakis@linaro.org> wrote:
> >Normally you'd see either --enable-XXX or --with-XXX and their
> >corresponding --disable-XXX or --without-XXX.
>
> True. As the commit message says, `rust` is a reserved meson feature
> name, so the auto-generated scripts/meson-buildoptions.sh
> has the following args:
>
>   --enable-with-rust
>   --disable-with-rust
>
> I used the same in `configure` even though it's not autogenerated in
> order to keep the two synced. If there's a way to get around this I'd
> prefer it.

With the patch I posted, --with-rust/--without-rust is handled
entirely in configure, Meson gleans the result from the presence of
RUST_TARGET_TRIPLE in config-host.mak.

Paolo


