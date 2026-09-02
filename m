Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F0ACC624D0
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 10:20:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1i4N-00083G-33; Wed, 02 Sep 2026 06:19:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mcascell@redhat.com>)
 id 1x1i4M-00082s-1W
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 06:19:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mcascell@redhat.com>)
 id 1x1i4J-0005lt-Hx
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 06:19:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788344385;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L+xHRTSUtSXfvI1sCTk/nMv+IJ2+RWhUzWYuNM6MC7g=;
 b=GF/Sp4aQ4mcVf59SKoZIG27+Owq+WzU4h4On0DstZLFsUZtaEv0QdDgBKoZRxrnVrPt78R
 N5PZUnO5LFyrM9qA10BXrHjpsi5HU3ergn3iJfnuxMsS3Pa9VHH+2kP2bWnDcTOv8xnKpo
 FLYICZIPvBEVpKG/qvREN8B4tzRCs/I=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-673-UvGvobDUOTSdFMz498iD9g-1; Wed, 02 Sept 2026 06:19:44 -0400
X-MC-Unique: UvGvobDUOTSdFMz498iD9g-1
X-Mimecast-MFC-AGG-ID: UvGvobDUOTSdFMz498iD9g_1788344383
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2d6df0a1e18so17292005ad.1
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2026 03:19:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788344383; cv=none;
 d=google.com; s=arc-20260327;
 b=tCQ1SML2rEDWbQS5vEwgfmhyWH4zgPPjwRXXR/zJsvQGu4KtK2jo1uSR1WoELxTEfA
 DoYsUJ8Nb2wA/VgIJIHad11GPXS+jH6+JmAfw2NoOuFBJo1+XeUDSbjtbxk0dRHOEJyy
 12gdbXwGsKNB5/XtDbLm+6E42YH1TmyAu6/IshX+YrHc41hx6nFBJMLMg7WWobtyW+CR
 ANCR9Ex53w/FIe4sPkjnDwevPTFFnnlUl1bGBIj6kP1eYdYZkuC5TBcfUoA7aMF81Fg7
 IIoxEIb1jtVi6gHWczEEy4lD910tkDap8YM8V6dxlLgfRVdsBzqaYxILVQ7ZgSW/aEna
 3S6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=L+xHRTSUtSXfvI1sCTk/nMv+IJ2+RWhUzWYuNM6MC7g=;
 fh=09aG2iX2qdhRO67llXhiFinqKlB3CXkxiBO6zIa8yI4=;
 b=qxZ7kLnZOkXYQhiRwvWEiJpPqNlzcI7kOLZ8xKqDmWz+f2Td+fQJBIKGWrAkDook/N
 5vgEhiba4ZfcBIougk5wuMrviv0YkGC89X5qKYFvV+G0K+sH+ObGMem9sOkXGyJc+zJK
 cq3KRC5KFPz2Yvku4uKjxUHjDcRj039skVep4M42OlbYzLiXVwVZE+IoH79fTXtXFcAr
 otxY5l3cpfs99vkO0jJflLr1WSA5nKl1xBt2vxK6X1w0lfEr3sORiOvFFwwoiPm0dDjp
 AtDDYAoNH8dHo1we5eiUzK8pB78hGqNp+zGszrGbxpyNGfinMmswFt4gfhsoDS+oxKu8
 iIMg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788344383; x=1788949183; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=L+xHRTSUtSXfvI1sCTk/nMv+IJ2+RWhUzWYuNM6MC7g=;
 b=tMqAbaNycHB31ASOdnGP0U0oVUIfdi3EQqItVH7sCR2JPVLQFzWj1lpz5SBbhAkcmi
 NdG1YXHniTFJv3dNO2uL7t76bQBCbBy+TkGDoNIuDRCbvv3KjxU2CONfZ6guBc26ONsu
 wUAOudZAS+iHpLjEGxNuJYU4xT2y9MIDlptKcBmUjHEot/S1QmesccjM3oqUM2caab/w
 /9FGjWp+9OX3V2PUCpe1iXb6RGo29Gi5WkDsoOZEoghaAVtPIF+9Pbznc6tXZLDlFuN+
 TfYUvKjP0KIWlsg0Sg3PpF57Y6HB39UmEu7J3htgDhc+2G0PklMF6SYVS+u5F5frH5xH
 MVxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788344383; x=1788949183;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=L+xHRTSUtSXfvI1sCTk/nMv+IJ2+RWhUzWYuNM6MC7g=;
 b=Tbl46p0mWHBwKE1A0qOffCLXSYz7bHwAnFRPBxYj4JIWdb0zlDqi/CnZsz3CY0Km2T
 Fhz4WhfMPtf6+wZ29tZKeqaohWvu5cjC+MzBgHa1LJnJjIOHD+xubYHC11+NVqq56UCE
 2sNTMhMFluOhbLdDyN4PIa3ERgFsw3baUgDKT655K97jnCqebJto1Ubvpn51NAFzBbam
 c45lF/wf/DVgnpfRmV6ObYKTLZP990XK4XQ+ud4QZNu3EBb4y4+STVm7SzoDtk98T4UZ
 guC5N7QWe00FLrgOKFEJtH07+91+dpTkA91gXYPY33al+J5RNXRjWC757SefSBxj9aQv
 d0HQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwXhzxDa1RPU61xkA3UkLnmpR/+zsy22HNlv5RwrQmwMAgn8bRn0kQlykuMc4pWJ9t4AW87dncljCIf@nongnu.org
X-Gm-Message-State: AFuF++nUfF20ZKONRCcNIwFRt1aU3y5ZEZ5ZJPAqQke81EZna2qAkee4
 xSVmCmEECvmfsGOHeRe7lNJnv96rzg4Y+/U5Pf6xuXYnGjptRBElk1P3kngP7v1KycgMQg9Jmrn
 exQZyyIF3RW/aRowpA8fDpmvnk60RCDS7qL2+jsLxBnlZXni0xfPXmE7H/jUW9S5WTe0aXSLRqh
 oqiyMCIaQ6rBUUqXst4rlhF23rJzgXiTg=
X-Gm-Gg: AYBFou0j9uBB562gpes2/MCotglWo3YdLzGPKKu1QVxXh108ExB7nKcgs84IUjOQ01n
 DVX4S+G46ENu20rwqIT7ZEGUKfCc4VOYkPi7vWu2TTlAv0euH8EGhuZLQyovYPqgUPEnRf1aah0
 /rurxHDj1XBuhY4ppi8VqkddEL968A/wCUhQWAt4ppIZUivZ4fJSxTsEHk
X-Received: by 2002:a17:902:d4d0:b0:2d7:3f6e:5cb9 with SMTP id
 d9443c01a7336-2daec6248c2mr44154535ad.8.1788344382947; 
 Wed, 02 Sep 2026 03:19:42 -0700 (PDT)
X-Received: by 2002:a17:902:d4d0:b0:2d7:3f6e:5cb9 with SMTP id
 d9443c01a7336-2daec6248c2mr44154075ad.8.1788344382459; Wed, 02 Sep 2026
 03:19:42 -0700 (PDT)
MIME-Version: 1.0
References: <20260831100151.914178-1-den@openvz.org>
 <178817576852.2700790.2039576285438786814.b4-review@b4>
 <41cebb76-bc3c-4f69-82b3-7517122ab2e5@virtuozzo.com>
 <apcRVryHi8EfRVl8@redhat.com>
In-Reply-To: <apcRVryHi8EfRVl8@redhat.com>
From: Mauro Matteo Cascella <mcascell@redhat.com>
Date: Wed, 2 Sep 2026 12:19:31 +0200
X-Gm-Features: AcwNN1V1UJY1Kd9-p00XdgYDnw6aNogknFEbB6Uy4vQxLlB0oZcJjKraS0dvvAM
Message-ID: <CAA8xKjXPHdFh7uB+eOygLz25y=WQFZ=Uwe_WS-1L7yWnw8gN-A@mail.gmail.com>
Subject: Re: [PATCH 0/6] io/channel-websock: fix an unauthenticated crash in
 the handshake
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: "Denis V. Lunev" <den@virtuozzo.com>, marcandre.lureau@redhat.com, 
 "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mcascell@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Sep 1, 2026 at 7:54=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@re=
dhat.com> wrote:
>
> On Mon, Aug 31, 2026 at 01:33:14PM +0200, Denis V. Lunev wrote:
> > On 8/31/26 13:29, marcandre.lureau@redhat.com wrote:
> > >> A client which can reach a VNC websocket port crashes QEMU before it=
 has
> > >> authenticated, by sending an HTTP greeting whose request line holds =
no
> > >> space:
> > >>
> > >>   printf 'stats\r\nx\r\n\r\n' | nc $host $port
> > >>
> > >> Three defects line up to produce it. The greeting is rejected withou=
t
> > >> queueing a response, so the handshake goes on to flush an empty buff=
er.
> > >> A zero length sendmsg() succeeds and returns 0, which
> > >> qio_channel_socket_writev() mistakes for failure and reports as
> > >> QIO_CHANNEL_ERR_BLOCK with errp left unset. The handshake treats eve=
ry
> > >> negative return as fatal and hands that NULL Error to
> > >> error_get_pretty(). Patches 1 to 3 close the three links.
> > >>
> > >> Patch 5 is the same NULL Error on the read side of the handshake, wh=
ere
> > >> ERR_BLOCK is folded into -1. It is reachable for a wss:// client, wh=
ose
> > >> master channel is then a TLS channel: a wakeup carrying only part of=
 a
> > >> record makes gnutls report EAGAIN.
> > >>
> > >> The tests drive the handshake through a channel which reports ERR_BL=
OCK
> > >> on demand, covering both directions. No test reproduces the original
> > >> crash itself, which turns on a stale errno and is not reliably
> > >> reproducible in a unit test. What they pin is that a 400 is emitted =
and
> > >> that ERR_BLOCK no longer reaches error_get_pretty().
> > >>
> > >> Signed-off-by: Denis V. Lunev <den@openvz.org>
> > >> CC: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> > >> CC: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > >>
> > >> Denis V. Lunev (6):
> > >>   io/channel-socket: do not treat a zero length write as an error
> > >>   io/channel-websock: send an HTTP 400 when the greeting has no spac=
e
> > >>   io/channel-websock: handle a blocked write during the handshake
> > >>   tests/unit: add websock handshake test
> > >>   io/channel-websock: do not lose QIO_CHANNEL_ERR_BLOCK while readin=
g
> > >>   tests/unit: cover blocked IO during the websock handshake
> > >>
> > >>  io/channel-socket.c                  |   2 +-
> > >>  io/channel-websock.c                 |  10 +-
> > >>  tests/unit/meson.build               |   1 +
> > >>  tests/unit/test-io-channel-websock.c | 249 ++++++++++++++++++++++++=
+++
> > >>  4 files changed, 260 insertions(+), 2 deletions(-)
> > >>  create mode 100644 tests/unit/test-io-channel-websock.c
> > >>
> > > Patch series lgtm. You cc stable, why didn't you file a CVE?
> > >
> > > Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > >
> > I have calculated the scope and get around 6.2 which is
> > not looking too impressive to spend a time.
>
> In the context of a VNC server enabling websocket. If we assume the
> VNC server has authentication enabled, including the TLS extension
> VeNCrypt, then the deployment can be said to be protecting against
> a malicious client.
>
> The flaws mean the malicious client can inflict a denial of service
> attack on the VM before getting to the VNC authentication step. IMHO
> that is enough to justify a CVE assignment.
>
> CC'ing Mauro to double check my view & assign a CVE if appropriate

Agreed; a pre-auth VNC crash warrants CVE assignment. This is similar
to https://access.redhat.com/security/cve/cve-2025-11234

Please use CVE-2026-84788 for this one.

Thanks,

> With regards,
> Daniel
> --
> |: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
> |: https://libvirt.org          ~~          https://entangle-photo.org :|
> |: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|
>

--=20
Mauro Matteo Cascella
Red Hat Product Security


