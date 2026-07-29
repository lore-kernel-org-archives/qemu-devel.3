Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E37EC53200
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2026 12:21:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wp3Hb-0008Mk-IH; Wed, 29 Jul 2026 08:21:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wp3Ha-0008Mc-GH
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 08:21:10 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wp3HY-0005D4-RS
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 08:21:10 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-38759bcd877so825432a91.2
 for <qemu-devel@nongnu.org>; Wed, 29 Jul 2026 05:21:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785327667; cv=none;
 d=google.com; s=arc-20260327;
 b=G+H5SxLlgWoKU0RTWBiemhn/aVRRwiyc7i/XP/Xu49CP+4PdHBRN740TIleXNGHYAS
 7nxt+mWyw8bv8ZOUud273O+BZYCO7u6+DTyGnQybbybXhwlGF0PCD09IIYHm1ldQoxCU
 GLhscWNhU8DuarlSmBE0TdPxDwUS6gBq9XxT6zIjaTnd7AaTrKjb/EtYCAusKKvALZsc
 8geG0HgTlpRrxQD3un/GhFgcAewRG0gVtHisfXd8ylXtubzlg7pPPNzI18MOffrbbA+Z
 EeGFyJYIFDhN4aH1+nCP/04eWf5bcZp24G/1xmyJVU9TvIyebfRiVtNZ4lI+ejzIRu+G
 Hxww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=/CjZAWrOvvjth8yaEPiA4Tm38uoIQWLY6jTi/wC+V/c=;
 fh=4SjtnPNCiaaaeFhaON8mG3x72oBiAheHsDAZtPcqOYc=;
 b=E52bHuVmDAwS8h/5GF5BkgQxwrCkMlFohZXSipNmwUEpoMarJmG7dv5/bKEvVgRVsM
 zjMnKmSfo1YlXXOQA5lnK+S85/DrbKtJut7GJeRlbBysiUkkX8Uz8X2+htnW7fqkOjUm
 3pOI3pv7dz+mJmNDc0S+MKFZZq8petNfZ+Ismd9BULEVhdqF4agTooMEtOl5AYl8e/u6
 fnJc42+RVQKFpS0Tk/d8FZe0bXSATYIS/2QnqdWPCgi/6ar2FXJd9y3QFWKoXvhXNuNS
 JQTMz+MwBba5ghfkUP990ePGU6W2xzsQUzyeQfjnddS0L93GNbXlL+Xh5fmbWaBZbc6S
 O8NA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785327667; x=1785932467; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=/CjZAWrOvvjth8yaEPiA4Tm38uoIQWLY6jTi/wC+V/c=;
 b=s6VmVRNq+/UbtjKihvnpIIw7naoA9r9Fd0zx5J69mMPNWkIfnF4KdKawlKbCnbaY6c
 xYj4NHiAqbPwJ5ZGjRh62SzIgJBWZtXOvmoJ2SIwVRqCyLIcRCJaVVHz2A5grAFn81gR
 4x7Wl3W+wbErAIDICeXx/18+D48eaCflhLr9HoB4DYY11PAo9t2j1p7zj9yl5TtJLRLR
 p6hpibspWzBy5ZhD0/BqFPAkuP0r0+Jyc942oDtDTViVC/ELHsPKaclsXXVp8Bc/ki3l
 Rv+Id8WjKgyPw+OJ2twpDw9QdjF/8E6+oi5GBe1mMbb62cFf+wt+e5hDLb41Xt9Fx5Os
 rLcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785327667; x=1785932467;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/CjZAWrOvvjth8yaEPiA4Tm38uoIQWLY6jTi/wC+V/c=;
 b=Z8mqX5B7DfVr29LSIktJYMmkQKryclTTn4u+hL7o1KQlwy1II1PxXEeEae2VztkvaI
 8K8xcsJi64Y9xxCvXqksq9Kcpo8eXEDLJoYnBbVwk/kW774t777LcCyMWZkZzZ0qj1+K
 ksCuGMRHvlVzeghTcTCCxvk5EyzqygZkOc7Dpu5Sd3jszpj5yh/dwppczSh6HEoz4JW/
 wY22Wvncry3aLGWKZWpFIyfk3sG2wQyLDHt3tEJeZwbOF0VM3cA/56pe33XbMfMrzerB
 Zg7Q13h0zUcAR+SwiPYoWXWZ99iqeZuNDWbo0P/sjg6ymHX2WrOXuve8Xli+u02x8NZL
 MzGg==
X-Gm-Message-State: AOJu0YwIRCYBVAUqLe+1LbI+YmDoSe5/RplFPXMbWoK6zgDxchwzjKdg
 /VDPb1L1ijjmQB1viaJ1uB6jUlOefkHDdqenVcA4iOw44GJhBlQ6dZ6QLOWT8ZY0jQopI2K93Im
 VVfZnAFEjpKiPLsWBOqVrpC5uHBKwkLo=
X-Gm-Gg: AR+sD13Ksk61NXIFcHdLU1kxpKgDTkfllW3rTAkqhejeufCk5x6MN+5C2K7h1tAR/KR
 y27dwOYI38B9oWMxGN25ybtsT+Gp6fGldOTEmskC1syPAWhA3he79S4G26j1mM6ooTto6yjQLlm
 kEMPNq0Mbh0S7klYKP80r2GKzsZxTXUnX240KPOIvHp4wDgsZt7V4yI/vSbJA4vBpsWKt2wYzfq
 QPNc0hZYBQfQax78gwY6lTaSd3OyrjPf5r79g0fs0tAMNkzNkfX0aZGQYZoMuMyZ4lNJiZRps4M
 hwFmmzF8iOpJ466sKz38vd/Kg5u/1eIyrk8J7zPwSG9Dq/x3vD2XtkkDLDnjNObh0Si/g5htaaW
 6
X-Received: by 2002:a17:90b:1c92:b0:38e:f6eb:2b38 with SMTP id
 98e67ed59e1d1-38f6a362850mr6295178a91.17.1785327666978; Wed, 29 Jul 2026
 05:21:06 -0700 (PDT)
MIME-Version: 1.0
References: <20260510-qom-qapi-v1-0-48ba6a1a1fa5@redhat.com>
 <878q6us19k.fsf@pond.sub.org>
 <CAJ+F1CJBzrP9WjrO2zf7JEFmUchEFDZcGhc9zgR2XTU-rQZQiA@mail.gmail.com>
In-Reply-To: <CAJ+F1CJBzrP9WjrO2zf7JEFmUchEFDZcGhc9zgR2XTU-rQZQiA@mail.gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Wed, 29 Jul 2026 16:20:54 +0400
X-Gm-Features: AUfX_mxXaFPdZMBr3jd4IpRLcY6PD0Ir6FVecNngWRAFaJCMDmggv41Awn1u3fA
Message-ID: <CAJ+F1CL1rWLeZZVXXUi6p8=-L7q-6HCuZdx39rtk-RRQ=76R5A@mail.gmail.com>
Subject: Re: [PATCH 00/54] qom/qdev: associate properties with QAPI schema
 types
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-pj1-x1034.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Hi

On Wed, Jul 29, 2026 at 2:04=E2=80=AFPM Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
>
> Hi
>
> On Wed, Jul 29, 2026 at 11:29=E2=80=AFAM Markus Armbruster via qemu
> development <qemu-devel@nongnu.org> wrote:
> > > Along the way, a few pre-existing type mismatches in property
> > > definitions are fixed, the "struct tm" RTC property is replaced with =
a
> > > proper QAPI StructTm type etc. Introducing more specific types or a
> > > "typedef" to QAPI could help provide better associated type informati=
ons
> > > than plain "str" in many cases, for example.
> >
> > Examples?
> >
>
> Properties using str_type_info that carry structured values with their
> own validation: macaddr ("52:54:00:12:34:56"), PCI addresses
> ("04:00.0"), netdev names, chardev names, drive names, UUID strings. A
> QAPI "typedef" (or newtype) for e.g. MacAddr, PciDevAddr, UUID could
> let tools know these aren't arbitrary strings (see "hw/nvdimm: convert
> UUID property to QAPI-aware registration" patch).

On a related note, qapi-type for integers are all collapsed to "int"
(and list of). Even though json wire accepts "int", it would be nice
to retain the original type information.

