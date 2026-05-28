Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73E60CD5BD1
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 07:53:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSVYf-0007Fb-Dn; Thu, 28 May 2026 03:53:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wSVYc-0007F2-UL
 for qemu-devel@nongnu.org; Thu, 28 May 2026 03:53:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wSVYa-0000tC-KK
 for qemu-devel@nongnu.org; Thu, 28 May 2026 03:53:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779954811;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=saNLl/QX5GzCjju0wrJCn/8EnGznkwycq2wS+zkdAQ0=;
 b=fRu+YCof2nrw+LkBtuQlPXhxUJsql0Mq4JYXqutiepxaC/dSnOUhnWAOzVh3/8RKVpKMHM
 dain0063KgbIFFpS8tnJ4O03cn1VE7JQruzRywZfopbee+cU00WjiJnDeDh8drjf4knmGP
 kQjfuArIktgcYYskFxgU4mmLxjvv7iU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-175-Yy8_z6d0P4O3LtDpvJavyw-1; Thu, 28 May 2026 03:53:30 -0400
X-MC-Unique: Yy8_z6d0P4O3LtDpvJavyw-1
X-Mimecast-MFC-AGG-ID: Yy8_z6d0P4O3LtDpvJavyw_1779954809
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-45ea38c03a1so6207203f8f.1
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 00:53:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779954809; cv=none;
 d=google.com; s=arc-20240605;
 b=eyTgc10qAhU12CW+OWAAqMK6QQEuANUm94NcQqwqd8/UalS6pVkUtmnui/w/xuS3TW
 Sj7DPj8dqh2S0MVICUj6/ofaIItLgzobHr5i1rAmhjdI9aD/KPMAcHlLpBT7iZjZwVT1
 cGHiHXC4YXUadJ/8f2DK4SxhtS2iu5zAtEGbFjsdUdnbr9uByz5jmPgVm9XKuJltygQ/
 c3MXZb5p+MYcRxJvpCpr7c6Z79/iORAxaqLBJoP3h3uKuVghOIhMD17RZKlG0SDBxf82
 8QvIyGGf0b1x2B80puYPOWgw0HX2L1SDuF3gvainfWE8AKtM4gipRm+hC3+oMUyHgDbR
 UxTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=saNLl/QX5GzCjju0wrJCn/8EnGznkwycq2wS+zkdAQ0=;
 fh=ZDSuhQo3pjEYSHSezNcziOY21RHpP42dPRjscILSidw=;
 b=KLMBysUa2Ic4xKco+V93IttRZGs6ROYNCHtTMvpkIzksxn+7IgIcOx1TsMU9euZ1bI
 X8gBCQ0A9vpHPFzUpGfmVZGBBncdJ5j/wCXGs2D5mQFIGWOT+vFnk4XI396kVlQfBDOT
 peIU4o11hg1AsSj/T9TVCwuJSTIThntSrr0xO5CCYs2pszWVJEoQGi71ukg9Vd7Hn9Cx
 1xRl1woaGAUjeDEVetV7ziBf72dNyhyTrCtp9xZlDuw4Aa6Pr7w2Ra8CFLae2fbtISEx
 voaYR4/5x9gvrFBOVOkKdMPXJTybH+E4TXQUOj6WxhNpbx0MxPdMUj5c2kSdqAgbVC4u
 xLTg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779954809; x=1780559609; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=saNLl/QX5GzCjju0wrJCn/8EnGznkwycq2wS+zkdAQ0=;
 b=GzrCo2vuRBdapQVGtNkxn92LArf6ObbcrjXDih8qLUeQ2HHpQQzMdOwlm+XkZe5rSL
 7gcqBhLutUPtQsoNidptHy1OH/nsmqSah2NQ/SL7fbfxz9VPSjyHbmftBwl2xTAbsb63
 IIRQC+66Oga/2I1s07H8NN2mcEDv9kHfsSpp6z8fR2iEO2H2s/VBYdRrZjYsYtbIyhvm
 l0qy6/YRiZqc2sa5EEJfDGqs1r4HhNyuiWmxZ9WzIavvg8Jrc3jGJwNtd1vNMqsyL5TA
 LalRvG6Mm5Atw3chdq66AaN4HAO7RgYxtc9LCTmYIEIpFBneqmVI1QsaY6iKFAag7+uS
 AuSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779954809; x=1780559609;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=saNLl/QX5GzCjju0wrJCn/8EnGznkwycq2wS+zkdAQ0=;
 b=KVvEUDdyCtY806b/GpaPxOCr0n+S0XPH2TgR8EUNwWDS6nog7AtU2jdCJgBB4CLLj/
 RUOi3a6WCWjnMbWoKLJqqqNgoj35iYn8PD5GGoP7OAEWBCyOo/bCid8ZAzop7YvvIOWP
 eXT+tQ06G5iNVJtoRE01FpKGvaGsbsxWcnHCUZOqqVLDf/2zHsPICWAMQLlE8GhV2nY2
 VRQY4+ebzGLe+95YmyGFtkrYSOAbYq8doEiIGdpyHhtVJSBrPU80EybkRLiIlKYCc3Dx
 fzW9m2ODX/5D2ZZcTfDYPA8bYq1zo87D9tHt/D8BbUHmYlmLF1mEpLYnfJp0h+1QSyxc
 QnSg==
X-Gm-Message-State: AOJu0YwtXPRj7HsUTL1KLU8mNK9+KeIwLkixaRQeB/HiZoZ3v5P0RCkO
 egJ3hQO7og76jbXNp4FNsHV4cWfhHDpnsX23mm0TulVXR9DYXV5rav72vodIp6ZW9BXtLTfVSdf
 cF5xQFuKLFo/2YME7wvlL/JgPxWq7DjytAZN0sgzV6Nr5JxoImUdjPVyY/6MBe9hSZDaeCR8nGZ
 BzlzV75af2+5KSYDxlnu21FdHscxQsqQE=
X-Gm-Gg: Acq92OFgqpgFdAGNnBc0oc1hI6QST/7BEiUe6ePU63kelR4ga/gPXl5T/R3QXGgJyYm
 ltEVYrnSMWgghH2xjkIRH0Q6p0qZqj5UK+9jiYZC8B2tpbP6Uq0uNaWKwQLjMfy+VMkA1DVqhpy
 W4075f2r6RUIWamUooMXHHbIqeH0M7dE0Eo766IQX48SsQWx/A2Cd3IKcEsGB6uy9TbJ+iuR1DP
 nLjz87jPh+ci1Ur7BURFF32QIoB0r9vSmohUv7y/Qncm20yRMKpR8EyoGv9iKnNKR7PXetX1iKJ
 SwgUSW78T4Hwqktsuw==
X-Received: by 2002:adf:e011:0:20b0:43f:e9ee:5610 with SMTP id
 ffacd0b85a97d-45eb38b0408mr31932030f8f.43.1779954808801; 
 Thu, 28 May 2026 00:53:28 -0700 (PDT)
X-Received: by 2002:adf:e011:0:20b0:43f:e9ee:5610 with SMTP id
 ffacd0b85a97d-45eb38b0408mr31932000f8f.43.1779954808458; Thu, 28 May 2026
 00:53:28 -0700 (PDT)
MIME-Version: 1.0
References: <20260528073412.551117-1-pbonzini@redhat.com>
 <20260528034301-mutt-send-email-mst@kernel.org>
In-Reply-To: <20260528034301-mutt-send-email-mst@kernel.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 28 May 2026 09:53:12 +0200
X-Gm-Features: AVHnY4JE643ZEyfV7jhFY8AkFTORxKT2VWMf8EKtIcOb84LRZ4SeY7P3NjJpWM0
Message-ID: <CABgObfZwaiu4A2b2EFuFRA4dbWfHrDYEfiq5_-mf+zQpsYfTLQ@mail.gmail.com>
Subject: Re: [PATCH] docs/devel: relax policy on AI-generated contributions
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Warner Losh <imp@bsdimp.com>, Paolo Bonzini <bonzini@gnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, May 28, 2026 at 9:48=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
> > -How contributors could comply with DCO terms (b) or (c) for the output=
 of AI
> > -content generators commonly available today is unclear.  The QEMU proj=
ect is
> > -not willing or able to accept the legal risks of non-compliance.
> > +If you wish to send large amounts of AI-generated changes, or any othe=
r
> > +contribution not in the above categories, please get in touch with the
> > +maintainer beforehand.
>
> To be clear, the implication is that
>         These can be accepted at the discretion of the maintainer

Yes.

> Maybe make it explicit.

Ok.

> > +     AI-used-for: tests, docs
> > +     AI-used-for: code
> > +     AI-used-for: code (refactoring)
> > +     AI-used-for: code (prototype)
> > +     AI-used-for: research
>
> Why include research here when we also explicitly say:
>
>         > +These boundaries do not apply to other uses of AI, such as res=
earching
>         > +APIs or algorithms, static analysis, or debugging, provided th=
e model's
>         > +output is not included in contributions.

I suppose it can still be useful for traceability. I copied it from
Kevin's proposal but I can remove it.

"Research" may also include using a script written by the LLM, which
is encouraged in the first section.

Paolo


