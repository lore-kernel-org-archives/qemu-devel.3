Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C48EDC48BF6
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 12:19:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rffNc-0001BM-A0; Thu, 29 Feb 2024 07:19:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <antoine.damhet@shadow.tech>)
 id 1rffNa-0001Aw-Bt
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 07:19:14 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <antoine.damhet@shadow.tech>)
 id 1rffNV-0004ei-OO
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 07:19:14 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-412b88e2f07so5911035e9.3
 for <qemu-devel@nongnu.org>; Thu, 29 Feb 2024 04:19:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=shadow-tech.20230601.gappssmtp.com; s=20230601; t=1709209147; x=1709813947;
 darn=nongnu.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Qmz+ePZSIaD3gPQdf4yxfgfb7mFGCBr9m85jA3dbvRU=;
 b=OjvN0wCDEBEnuT1tW64XHJV+br6DICbAWysJHjrTSepmoAWsKI12qNrqUH8RgAONfS
 yoglJKLgCNWJ7khoUyUzVq3O64rOVVitfg0sI/q32+1I0aR46OazvxxK86x/VsODmBRK
 5SVZdJyvhOGaUts8yHQIWUkWP+7dLdkX4kk+ucY4N5Ku1tpJV0N+zw6rzX+OYdRqLShe
 reamau623qkPOCEPg9KPXlWltvH0pjFAI8WOR8ZSH5E9rmPmM1lUIRBxJPAGMIudtMtk
 al72AxO34OtBFeLnFZEURuOZ9dCabFL+jtMfzWDkLatN0/scuRurQtJpY3x5IiMrYwGo
 ixCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709209147; x=1709813947;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Qmz+ePZSIaD3gPQdf4yxfgfb7mFGCBr9m85jA3dbvRU=;
 b=uceW2j+NX0t6qZeG5RQdlmxOEld6USEOOLZl8CdtbBiwx9kAdnoMdJyJPVqYt1MfIv
 IZLXhMPtM9V/gJc2JVSXHm7bKPKGcAyyHNxoGA2EHPDOxMDrD/7b0JXl6w3pOQ+vx2sT
 iglOLHjDuU3qs/PshOpI4P5aW6ChPA0lU8RZZgUnfUljYMkSBWykh+Pj0CeWG5ZiMXza
 QVQ3UNvRmHs1lXyGqDKvUbxpfkC9zxJ8UyB32+dWLGS55sUCC/LfJwd4QaJ0LMCYWpt+
 1pwND50ki1kRD7c7aeKNWdYzt34laDvq2LLEYiQQ7HjUip6XMz4TH+JZ+v9AmawGoBLM
 9I7g==
X-Gm-Message-State: AOJu0Yy72qEgG/bByOOzzRZgNFa/9kwytQS3/YmNX9SOPikUq88JP5gk
 N+qsCqZi9dG1vxgMergTeBZVpzMITwCpdKlOe/EZcG66sip2ys4gIqKY2wpTulk=
X-Google-Smtp-Source: AGHT+IH5MoTZMSdsY+MRHygzi9LmlAnjPfgQAi3cT52dwRi3hXbMPKKknE8vuRpkbTMhZTefbnFxdw==
X-Received: by 2002:a05:600c:4ecc:b0:412:b586:6d2a with SMTP id
 g12-20020a05600c4ecc00b00412b5866d2amr1591877wmq.7.1709209146482; 
 Thu, 29 Feb 2024 04:19:06 -0800 (PST)
Received: from localhost ([185.123.26.202]) by smtp.gmail.com with ESMTPSA id
 17-20020a05600c229100b00412b2afb2c8sm4980375wmf.26.2024.02.29.04.19.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Feb 2024 04:19:06 -0800 (PST)
From: Antoine Damhet <antoine.damhet@shadow.tech>
X-Google-Original-From: Antoine Damhet <antoine.damhet@blade-group.com>
Date: Thu, 29 Feb 2024 13:19:05 +0100
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, 
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Charles Frey <charles.frey@shadow.tech>
Subject: Re: [PATCH] chardev/char-socket: Fix TLS io channels sending too
 much data to the backend
Message-ID: <mc2qelqxqo3jflmktc2ad5uswcc4yphqmfrn4wuhf2mta2hho4@hgrks3pwq2iz>
References: <20240229104339.42574-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="tmy5tp7mq6famrgh"
Content-Disposition: inline
In-Reply-To: <20240229104339.42574-1-thuth@redhat.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=antoine.damhet@shadow.tech; helo=mail-wm1-x330.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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


--tmy5tp7mq6famrgh
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 29, 2024 at 11:43:37AM +0100, Thomas Huth wrote:
> Commit ffda5db65a ("io/channel-tls: fix handling of bigger read buffers")
> changed the behavior of the TLS io channels to schedule a second reading
> attempt if there is still incoming data pending. This caused a regression
> with backends like the sclpconsole that check in their read function that
> the sender does not try to write more bytes to it than the device can
> currently handle.
>=20
> The problem can be reproduced like this:
>=20
>  1) In one terminal, do this:
>=20
>   mkdir qemu-pki
>   cd qemu-pki
>   openssl genrsa 2048 > ca-key.pem
>   openssl req -new -x509 -nodes -days 365000 -key ca-key.pem -out ca-cert=
=2Epem
>   # enter some dummy value for the cert
>   openssl genrsa 2048 > server-key.pem
>   openssl req -new -x509 -nodes -days 365000 -key server-key.pem \
>     -out server-cert.pem
>   # enter some other dummy values for the cert
>=20
>   gnutls-serv --echo --x509cafile ca-cert.pem --x509keyfile server-key.pe=
m \
>               --x509certfile server-cert.pem -p 8338
>=20
>  2) In another terminal, do this:
>=20
>   wget https://download.fedoraproject.org/pub/fedora-secondary/releases/3=
9/Cloud/s390x/images/Fedora-Cloud-Base-39-1.5.s390x.qcow2
>=20
>   qemu-system-s390x -nographic -nodefaults \
>     -hda Fedora-Cloud-Base-39-1.5.s390x.qcow2 \
>     -object tls-creds-x509,id=3Dtls0,endpoint=3Dclient,verify-peer=3Dfals=
e,dir=3D$PWD/qemu-pki \
>     -chardev socket,id=3Dtls_chardev,host=3Dlocalhost,port=3D8338,tls-cre=
ds=3Dtls0 \
>     -device sclpconsole,chardev=3Dtls_chardev,id=3Dtls_serial
>=20
> QEMU then aborts after a second or two with:
>=20
>   qemu-system-s390x: ../hw/char/sclpconsole.c:73: chr_read: Assertion
>    `size <=3D SIZE_BUFFER_VT220 - scon->iov_data_len' failed.
>  Aborted (core dumped)
>=20
> It looks like the second read does not trigger the chr_can_read() function
> to be called before the second read, which should normally always be done
> before sending bytes to a character device to see how much it can handle,
> so the s->max_size in tcp_chr_read() still contains the old value from the
> previous read. Let's make sure that we use the up-to-date value by calling
> tcp_chr_read_poll() again here.
>=20
> Fixes: ffda5db65a ("io/channel-tls: fix handling of bigger read buffers")
> Buglink: https://issues.redhat.com/browse/RHEL-24614
> Reviewed-by: Daniel P. Berrang=E9 <berrange@redhat.com>

Reviewed-by: Antoine Damhet <antoine.damhet@blade-group.com>
Tested-by: Antoine Damhet <antoine.damhet@blade-group.com>

> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  Sorry if you've got this mail twice - I forgot to CC: qemu-devel when
>  I sent it out the first time ... *facepalm*
>=20
>  chardev/char-socket.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/chardev/char-socket.c b/chardev/char-socket.c
> index 67e3334423..8a0406cc1e 100644
> --- a/chardev/char-socket.c
> +++ b/chardev/char-socket.c
> @@ -496,9 +496,9 @@ static gboolean tcp_chr_read(QIOChannel *chan, GIOCon=
dition cond, void *opaque)
>          s->max_size <=3D 0) {
>          return TRUE;
>      }
> -    len =3D sizeof(buf);
> -    if (len > s->max_size) {
> -        len =3D s->max_size;
> +    len =3D tcp_chr_read_poll(opaque);
> +    if (len > sizeof(buf)) {
> +        len =3D sizeof(buf);
>      }
>      size =3D tcp_chr_recv(chr, (void *)buf, len);
>      if (size =3D=3D 0 || (size =3D=3D -1 && errno !=3D EAGAIN)) {
> --=20
> 2.44.0
>=20

--=20
Antoine 'xdbob' Damhet

--tmy5tp7mq6famrgh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEArm1WbQx2GmOsfF83AmjLzzljz4FAmXgdjYACgkQ3AmjLzzl
jz7UdAf+Pgrff0Wi2sZnkpliLBu7RzPksYJJDzroq8R4r3vlqze7vXGOuey6TLhG
wwFOBHos9gcfdJmkdEYvVIue7eVezhHabBtWPE/bcZb02keRcAzAtOPZrJWLeWSj
EKSmaHbhXZu8wLOoQhOiXsjMb5gRH154cyGF+EhTxiZR6P0tkTwBW2AIeKyDXLWT
LyiR21cO7PwwcFgnbU6j26bb8llQcM4PTVyuCEUZa63/sV6uWKIbSduRasukDYZn
lF5orprwLF+mMYUSizeZu8b9GR/mslX7Enrq7J+87lScev5yKcSZI8evRyk7TCzL
7wEcDbP0SYsZfXt6DjrWAsbqJUGAhQ==
=W39G
-----END PGP SIGNATURE-----

--tmy5tp7mq6famrgh--

