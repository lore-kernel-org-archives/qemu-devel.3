Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E700CA0FED
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Sep 2025 05:18:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uuOp3-0001Gc-IV; Fri, 05 Sep 2025 01:17:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uuOp1-0001G6-8J
 for qemu-devel@nongnu.org; Fri, 05 Sep 2025 01:17:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uuOoy-0006kU-Gp
 for qemu-devel@nongnu.org; Fri, 05 Sep 2025 01:17:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757049428;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vkpgVcfz6oR1kCFOVA9xEFfmrqict1Ne7GVKoL3AeFo=;
 b=e2CxLCStJopOI78ddkKGjwIWD3Ql/uBrzs9w5dYDljfPQlcYHohVnKkKeTamNU038I/ii4
 ZiLu8TUFn8+1SVEf9qinqfDI32uku43DsiwGujN/gPiIGn7pK3yE9KOq7m8zcRrtoQvkjY
 HdwBaK/Jrk/PKPLJhOJ/QXgOxzk3lUA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-128-un7yXF2wP1yucPpOjFrw-A-1; Fri, 05 Sep 2025 01:17:06 -0400
X-MC-Unique: un7yXF2wP1yucPpOjFrw-A-1
X-Mimecast-MFC-AGG-ID: un7yXF2wP1yucPpOjFrw-A_1757049425
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-45b9ca27a11so12636555e9.1
 for <qemu-devel@nongnu.org>; Thu, 04 Sep 2025 22:17:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757049425; x=1757654225;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vkpgVcfz6oR1kCFOVA9xEFfmrqict1Ne7GVKoL3AeFo=;
 b=eOzLoJMWJEYzb+3JVQuleOSN8z6uKdPTiRuLRBdeLjuUxMmiG1cpSEXsSkXzb3rHji
 cNg5POxrab1robqO4C8VqKwMSA6gJfAUBfXrxn/EG0Hm+k27JwgKcARdIJyLp6gzqNWm
 Dh0sabXP8Ws757HUQ3dseD5xtvpp7zEJ3C75iYKGB381QOg98rrMurgRDPGkgiklSLeM
 PUtUIRLlKXU1LaR4w1yadnidb5zi643eJJtSPiLU79B+jcgXg3j6UtURRz5vaJXucXC8
 zPueNVdcgSXnDT3JxHKMbVGefCQvuxXkZV1ldQ6vrJL0cTa0PO9GMxYJwrcEQx5CLdCE
 Js/Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXVeoFJgccsG5AAqhlbMs7IInxf1/co2tSAFh2HcBirSM4egEzbNGIO/gpOB2XLntQh/9ayOnpgcTaE@nongnu.org
X-Gm-Message-State: AOJu0YyF7kmg3MqssHIQoHbB2au1c3MiYZ0HjkeFeN6tvjoq91N5Vn8i
 iQFhYSPh6ikZ6zULK3DpCFszKKUR+QRUNTkOZJENG+Zti9J71uNJzjrndNREw5k1scpRRQipFcg
 zgNySa0/rTclAqsajrPeJMLrg4dcM+4+1TDunuQHL4FM5FqNRpv23INd0rbojKCEjgHL3r7oKAC
 TjktXHIp8SrDSCcyq8eWqcxKR9nEPADBM=
X-Gm-Gg: ASbGnctDXfX/sI44q1VrldzGDF3s6Y9OW2c/wAuRrX0gIEfmvv96GFg5lBPNkvkrZPn
 TbrIGaq6qQWUf/Vw7vcEUUyzzeOG6BwHxBWcQjgxnWEf+lPTIZVlE32ZuC1BnpPZrAbfycpBVTW
 KjaE7/9mwcOt5+LJ02WWEFK8h21cW3KW7+/ZZo+vRS+JL7o8K7sRTRKF+HGmLMOOSaUkEl4qXjW
 dcIZK0nPNwkeG6FwyJOQQ==
X-Received: by 2002:a05:6000:2312:b0:3e0:34f4:31f9 with SMTP id
 ffacd0b85a97d-3e30033c90amr1293649f8f.1.1757049425392; 
 Thu, 04 Sep 2025 22:17:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGOAWH+CuX8XMUtbyIDDN9bhG1xLGWNoa+LDlpuEBl+PUcPMnbeVhmZp57j1fmJqmEuc9N2KDRi6ota5YMJiI8=
X-Received: by 2002:a05:6000:2312:b0:3e0:34f4:31f9 with SMTP id
 ffacd0b85a97d-3e30033c90amr1293635f8f.1.1757049425031; Thu, 04 Sep 2025
 22:17:05 -0700 (PDT)
MIME-Version: 1.0
References: <20250506152927.222671-1-pbonzini@redhat.com>
 <20250506152927.222671-2-pbonzini@redhat.com>
 <CAJ+F1CKZr2PZbXvi8OZ9O=QaGv4WUmLPofBzqDv4VAV64y9EnA@mail.gmail.com>
 <1546553e-a21a-4a0a-8bcc-6c4e23ff35e2@redhat.com>
 <CAJ+F1CL+TxyRN0P2njCBRLigKe1tO1CyNOuCP1L5LHwE5FMEsQ@mail.gmail.com>
In-Reply-To: <CAJ+F1CL+TxyRN0P2njCBRLigKe1tO1CyNOuCP1L5LHwE5FMEsQ@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 5 Sep 2025 07:16:53 +0200
X-Gm-Features: Ac12FXyiRMMjkNld7HVxq_yf7u9cCU1d5NsYkZimpR5kOrj7DmMlItt-H_DonhU
Message-ID: <CABgObfY87q19jxOw_tv86dzBkd1AbhjKN6rNqjeh+yFguYizhA@mail.gmail.com>
Subject: Re: [PULL 01/30] lcitool: use newer Rust for Debian and Ubuntu
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Big-endian MIPS is already deprecated in preparation for Trixie. Until
it's removed we can keep that target, or all cross-build testing as
you suggested, on Bookworm.

Paolo

On Thu, Sep 4, 2025 at 9:39=E2=80=AFPM Marc-Andr=C3=A9 Lureau
<marcandre.lureau@gmail.com> wrote:
>
> Hi
>
> On Wed, Sep 3, 2025 at 5:59=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com=
> wrote:
> >
> > On 9/3/25 15:54, Marc-Andr=C3=A9 Lureau wrote:
> > > Hi Paolo
> > >
> > > On Tue, May 6, 2025 at 7:30=E2=80=AFPM Paolo Bonzini <pbonzini@redhat=
.com> wrote:
> > >>
> > >> On Debian, the rustc-web package provides a newer Rust compiler (1.7=
8)
> > >> for all architectures except mips64el.
> > >
> > > Unfortunately, rustc-web is not compatible with the cross/multiarch
> > > packages (it will remove all libstd-rust-dev:*).
> > >
> > > Should we switch to rustup in the meantime for debian cross-compilati=
on testing?
> >
> > We should just switch to Trixie, which however needs some work in lcito=
ol.
> >
>
> Trixie no longer supports mips:
> https://www.debian.org/releases/trixie/release-notes/issues.html?utm_sour=
ce=3Dchatgpt.com#mips-architectures-removed
>
> Can we simply drop it from our CI too, or do we want to keep
> cross-build testing on debian 12?
>
>
> --
> Marc-Andr=C3=A9 Lureau
>


