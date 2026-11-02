Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB73606A327
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 13:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=GFD8pKBt;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=AZQ95hAM
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNs77-0001wB-Jw; Mon, 02 Nov 2026 08:30:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1xNs6w-0001oK-4F
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 08:30:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1xNs6t-0001Nl-63
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 08:30:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793626201;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w3xb9KNV8Q+mg/P2ABtbnKok637xmHiivsbYsBaLFjs=;
 b=GFD8pKBtH646OaKH/1lYZnnVaCM8N1C1kojYFYrJ61pdQTHZUMsd/Au72kZEXEUzLXBRVp
 zKu+V1+QL7dcK0wtqbIrQ6P8PbkiJlFo0ML9FIbj47TxH2n/BYtsrU/4TzE8ULUNJWUwXm
 7E24Vr48olcppbtRtj/t4NNVhu0qNVQ=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-450-Evm7ViiwNUWotqlPy9fx8g-1; Mon, 02 Nov 2026 08:29:59 -0500
X-MC-Unique: Evm7ViiwNUWotqlPy9fx8g-1
X-Mimecast-MFC-AGG-ID: Evm7ViiwNUWotqlPy9fx8g_1793626199
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-3ade5b3ae97so2552012a91.1
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2026 05:29:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793626198; cv=none;
 d=google.com; s=arc-20260327;
 b=a+IuQphgaodGDz9iYspBuIeMS5UOmaPaX+hQJoovsMzdLDV+1Wd2CoXnhs0iL6MXVg
 lwF+N3/sJI5FIPtkJCHZZMPMnnBZWTrHNZgNOemSajMcwApDF2ZsL+2R4rksgysoYM1K
 FYuarLcPfLONpi77yBOfHCXuSUETsf1l1VUroCzxRzfVvnh6lFnsIwNztYdS3ZVUwtzI
 FSY+wsstjuzGUaaLoTIaIenkO/1AmrlbLFntpV93hvCH46km0mGSr7Ai1kG8ujuhhYre
 r5wkw/Tmthzqel0KPGFy+7/qGxlqJCoO6Ug3rPGwSwun6O1BHuNfM636C+91XcUaEG4I
 OiUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=w3xb9KNV8Q+mg/P2ABtbnKok637xmHiivsbYsBaLFjs=;
 fh=PbRjv5tYea0s8pzu68CJJSWeonCRJ/BmoFu++GPo9Uw=;
 b=oYZKS8mPh4HbiIDm45dagWHG9HZ6g2woXzHIf7DyvfGxWxnWtdYyw+i2W5OPY/HVGX
 M4932UVH9jKBSfp4A0ks6E2UNBpI6eweuAzD/+b054IErT7TK/7lXXW/+uctsgQ2BhKT
 eUNsbVWNvcN8KwY7ySCaEvCwIPiyGyp0OV2eSlFzB/DiiAExQDmxK9uou3wwJebdQy0h
 nxZS5TeM6fYVFQpUk9ePrOvxAqosMguXjYOeAmALKDRVUN6bLOiWXmtGlhbbNMsaVExm
 K6Sr5wehaabailZjlKQ+2p5ahZRhZR0/Tm5AVlMFtQhyuqm7uO5VgxduiMf8USXCu/1F
 iO0w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793626198; x=1794230998; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=w3xb9KNV8Q+mg/P2ABtbnKok637xmHiivsbYsBaLFjs=;
 b=AZQ95hAMhOPf4ZQ6L74QnFAxH8lcR9g6r7/vggs2pPeQpHTmb94CodGJg7MO7z43Ov
 Z5GK00+woQizEu+9HOGYxQbOqrKfuh0e4E1Mro/ie9BpqfjOTw49L410LwwXbgVuzB1w
 0rw7z341l3IsdgkOGZQYeRm0/CI+2ThLzfLJH1mxdwYAlepeJFsYN923fw7Uk7OFr58f
 vMWp8B3DruBkbPRpYT0DsJ0tpWVtxGdZXTpS6AV3+lfR02CMyP/rVWtgkdnAheEV0+HN
 2O9hWShXfUkFf6QYQI0H7yAccefqEUASA5bU9WFmff7gAnDKWj3A/pSGzZJyKBHGV/HT
 dnUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793626198; x=1794230998;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=w3xb9KNV8Q+mg/P2ABtbnKok637xmHiivsbYsBaLFjs=;
 b=tZNuY3/4nh4HmXuIythjaaLennl13QbYtT2fkKbWWt2GMB/tceSd4i2bLzopNBZW+Y
 pHhGE9Kfg+LAkWKhmt8e4jITNyL4wBAZlwUyxTBQ2qy+gR09nOSk7rUmt3Qcz0o/V0V4
 tf0B/ceudjxXY8XMGfB7+aw77miUAGKJj0QhiDvmLGnSDCj0fiPCvoybNpBzhW+rNtsb
 CWQnXqjJLDOSOsgukgj1Lr8cPPS34OgA81lrDb1ohjAv0tp8fjSpDlMocHaV25aEVdqA
 lkUDflfD2QHuvhd6ihAnCaER36J3oedoMdbQYkqO3Ttf1KSIT7BARF+TMR8q+m0Wrfpv
 JXnQ==
X-Gm-Message-State: APuU4Z8zvsyZymP7tVhiXrdTjzSzbE11ioTbNIgTLRf2tWYxHnMgeOkr
 W4fY+8g2B3DhB9+s55Ecw02sgEw9pftC4gXEXG8qiyev/kpZGkol6RYmvMfVUSb0H59RnKKWQxY
 fhMKIPM5u04CqyHzYehsaDU0KfZ2ihf5/R1ZI+lY3qL0SpGhFM/BmORyoAqOupli1+T6np0eCEw
 DfRdUISLH0BuBejnn9WO2pnPLhqGBrgMs=
X-Gm-Gg: AYBFou2FC3aA6rFyc4JsLv88V7dl51XABBiKMRILyUqST2PKOZWk0efCHupbMETGspo
 MZQVbSDBCKr6Uh2vSuF2K/Q7HBcsG8zOJ31XZPJLQ7IES6SKETRVo9dt5i3qoXOvhZbziLeUya0
 LO0Afj/VKvlc3UJtvxwfvMBYkjFJmlmPmlKPnSft5gQE6Mhf1O44VDjDuDiNbaD7rSrGl5kC5B0
 zWiPIU3QJqM8L8UjmMOHSqHxV2ud0CFZ9Re9gols9WTOSNQIP6ji0x5erOBt2NIVuZQlZ8kWbCj
 WQ==
X-Received: by 2002:a17:90b:2751:b0:3a7:96d:feaf with SMTP id
 98e67ed59e1d1-3ae8972a321mr5486632a91.16.1793626198441; 
 Mon, 02 Nov 2026 05:29:58 -0800 (PST)
X-Received: by 2002:a17:90b:2751:b0:3a7:96d:feaf with SMTP id
 98e67ed59e1d1-3ae8972a321mr5486614a91.16.1793626197921; Mon, 02 Nov 2026
 05:29:57 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261001103412.2162829-1-marcandre.lureau@redhat.com>
 <auhhZP8151vP_wSt@redhat.com>
In-Reply-To: <auhhZP8151vP_wSt@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Mon, 2 Nov 2026 17:29:46 +0400
X-Gm-Features: AclHuK_OnmTWf71GaHFLRsbUXYJzgxS7EzHjZ14exC0nCbbX0E9AtGxOsGOYaSQ
Message-ID: <CAMxuvayrvy6SiPSUpQcjRyNPGqNObXdLg3bSgWy+JTmEOZ9iiA@mail.gmail.com>
Subject: Re: [PATCH] RFC: chardev: disconnect backend when frontend closes
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi

On Mon, Nov 2, 2026 at 2:09=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@re=
dhat.com> wrote:
>
> On Thu, Oct 01, 2026 at 02:34:12PM +0400, marcandre.lureau@redhat.com wro=
te:
> > From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >
> > When the guest closes a virtio-serial channel, QEMU notifies some
> > backends (spice, dbus) via their chr_set_fe_open handlers. Backends
> > without such a handler, like socket, keep the connection open even
> > though the frontend is no longer active. This is problematic for
> > stateful protocols, as the peer has no way to know the channel was
> > reset and must handle re-synchronization on its own. Disconnecting
> > gives the peer a clean signal to reset its state.
>
> Do you have a real world example of where this was causing a
> problem ?

I wrote a tool that speaks HTTP over virtio-serial. Unfortunately,
closing the socket/handle on the guest doesn't disconnect the host
client as I expected..

>
> > Add a base-class chr_set_fe_open handler that calls chr_disconnect
> > when the frontend signals close. Subclasses that already override
> > chr_set_fe_open are unaffected. For the socket backend, this tears
> > down the connection and allows reconnection when combined with the
> > reconnect option.
> >
> > Note: this is a behavior change that may break existing setups that
> > rely on the connection staying up across frontend close/reopen cycles.
>
> IIUC, libvirt expects the agent TCP socket to remain open for
> the lifetime of the QEMU process & any premature closure of that
> socket would be considered a bug.

So libvirt has to rely on out-of-band signals to know that the guest
agent disconnected... sigh

>
> > It may be preferable to make this opt-in via a chardev property rather
> > than changing the default.
>
> If we want this feature, making it opt-in looks unavoidable.

I guess that's the easy path indeed - probably a tad late for 11.2

> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  chardev/char.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >
> > diff --git a/chardev/char.c b/chardev/char.c
> > index 7daf87f0363e..58c69db7340e 100644
> > --- a/chardev/char.c
> > +++ b/chardev/char.c
> > @@ -331,12 +331,22 @@ static int null_chr_write(Chardev *chr, const uin=
t8_t *buf, int len)
> >      return len;
> >  }
> >
> > +static void chr_set_fe_open(Chardev *chr, int fe_open)
> > +{
> > +    ChardevClass *cc =3D CHARDEV_GET_CLASS(chr);
> > +
> > +    if (!fe_open && cc->chr_disconnect) {
> > +        cc->chr_disconnect(chr);
> > +    }
> > +}
> > +
> >  static void char_class_init(ObjectClass *oc, const void *data)
> >  {
> >      ChardevClass *cc =3D CHARDEV_CLASS(oc);
> >
> >      cc->chr_write =3D null_chr_write;
> >      cc->chr_be_event =3D chr_be_event;
> > +    cc->chr_set_fe_open =3D chr_set_fe_open;
> >  }
> >
> >  static void char_finalize(Object *obj)
> > --
> > 2.56.0.rc0.29.g47ce80527c56
> >
>
> With regards,
> Daniel
> --
> |: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
> |: https://libvirt.org          ~~          https://entangle-photo.org :|
> |: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|
>


