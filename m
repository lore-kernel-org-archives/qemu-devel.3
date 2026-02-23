Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF24EEC110E
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 17:19:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuZaJ-0000dk-Jl; Mon, 23 Feb 2026 12:19:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adamhet@scaleway.com>)
 id 1vuZaG-0000dQ-Nw
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 12:19:01 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <adamhet@scaleway.com>)
 id 1vuZaE-0003Au-0A
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 12:19:00 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-43638a3330dso3889838f8f.0
 for <qemu-devel@nongnu.org>; Mon, 23 Feb 2026 09:18:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=scaleway.com; s=google; t=1771867135; x=1772471935; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=26u4wdZEurQqzy8HQlEYLxXXChO8F/C4CHKbjyTE1vA=;
 b=WsjDdw2YqCO1GCzBlhVCR0LkzmF61GBjsQMNEDV2E0N5619m0rC6udKrO2JHsjF9bu
 tHJO2ew5SazxPrlcWsPuFbQ1bjKCsU7pQ6vp6xAEOYa3uXJIyx7+ovb1LoXgn30nRfjM
 KM0SZHNSYV3//sV8Ounu1g/ypCieHQtQW6LV9bVik4KHwwFpF6NTmlkc0CfGxA8PuvO3
 C+Pztr6qglZv9UZXOJEHeRB5pLlSHSgZn18O4Nk8E4f9K6/QURjTf1lrN2j0zB/vsacn
 8evX3L5PEQyGyOLbwW9KNR9HnE4L0C1y87Blku+JK7Rm0Sek1rogGbjF9j7h9EJe/HES
 HGdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771867135; x=1772471935;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=26u4wdZEurQqzy8HQlEYLxXXChO8F/C4CHKbjyTE1vA=;
 b=ldCdCbWPEJ0TGkUHZoJA8KNdmqoRf0MZLtHEr4R9KzBMLPZJ94WRGyatlSCDLDXi4W
 6dH5pd9XLhOHJoGxTDqOgNiKEc5kbOkUYC9zSySer6XpsfjPjTfDoD9CKkaKkBXQQtCM
 Tc/qU3J305gJojQ7axuDsBG6TXRI6w66G8Hzc08il5gc5DMCEHKKqmEEfirbuarVjIYM
 vLp8KBnrXUqGZRQ3qzu6ibgCWiLsz0hGaIMQ0OcwnuFVYd6pfitnOhw/gVkzc/TU56HV
 J4WK0VFvSAAKJ1FzhU/6E8Z+0SndzLRa5p3kszsDnEBsegKXevyafmDFE6TWevY3VHP5
 kX8g==
X-Gm-Message-State: AOJu0YzJjp+2aEZ7hkHaKAc7rDjE1oyo0Y0CjxYksUuldMdUowMIYp2D
 CAKN/jS6v6dQPu5UYuSPX4wqXJmWc8BJRPOKeW0VG49Zlb4c2DVAS09RjECJM8kngYs=
X-Gm-Gg: ATEYQzzUC/IhfqAjR8e0P2OtpNi10p0y1e6wKu07vdmHwBe1djeJmzBH4GTBEKBU0DX
 CqEBFz1qUlR01NPI1P7jKBrOIhyOE4rlgRB00LMKGuzOIJmchbAMCedI6efvpRYehqgg/oyRFzi
 M2p6xQm2gEeihQ990j8QqREbj3LTnm1C+Lvqg5M+S5yCAsyd5GCPyLOkpJ5nA/2006Lu+Ua44bB
 d2BD3zolOnUYapeEBuK3SOPxTw/tB5qFS4rHlU61MlIhwfUwZTz/NR3Lazx/Hgir19Xh/PFkm2M
 PsHotKg1JhRyw8RNYeIq12thoupKDTWj/dt36T0IIaVyy3kzGFo9Qn48SdAFixqg2gq9wID0cSK
 lJAI1jjniPtIu2aeIyjzA8n2C7fO17wQd9sp68aa4f/+3N6WXMg43XpObl1cF5q3EUeJm8LC4S/
 SM675q6QZDelJejy/zcDf/k6Raot7BUm2PIeTscb2768fY9Ige
X-Received: by 2002:a05:6000:250a:b0:435:930a:658e with SMTP id
 ffacd0b85a97d-4396f185229mr18321877f8f.53.1771867135165; 
 Mon, 23 Feb 2026 09:18:55 -0800 (PST)
Received: from localhost (710304585.box.freepro.com. [130.180.219.188])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43970d54c5csm20349421f8f.38.2026.02.23.09.18.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Feb 2026 09:18:54 -0800 (PST)
Date: Mon, 23 Feb 2026 18:18:50 +0100
From: Antoine Damhet <adamhet@scaleway.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH 2/2] block/curl: add support for S3 presigned URLs
Message-ID: <aZwXB5uY1a9cWlvg@wellsley>
References: <20260212162730.440855-1-adamhet@scaleway.com>
 <20260212162730.440855-3-adamhet@scaleway.com>
 <878qcroio8.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="s5ko24dehyyebxgk"
Content-Disposition: inline
In-Reply-To: <878qcroio8.fsf@pond.sub.org>
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=adamhet@scaleway.com; helo=mail-wr1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


--s5ko24dehyyebxgk
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 2/2] block/curl: add support for S3 presigned URLs
MIME-Version: 1.0

On Tue, Feb 17, 2026 at 09:53:11AM +0100, Markus Armbruster wrote:
> Antoine Damhet <adamhet@scaleway.com> writes:
>=20
> > S3 presigned URLs are signed for a specific HTTP method (typically GET
> > for our use cases). The curl block driver currently issues a HEAD
> > request to discover the backend features and the file size, which fails
> > with 403.
> >
> > Add a 'force-range' option that skips the HEAD request and instead
> > issues a minimal GET request (querying 1 byte from the server) to
> > extract the file size from the 'Content-Range' response header. To
> > achieve this the 'curl_header_cb' is redesigned to generically parse
> > HTTP headers.
> >
> > $ $QEMU -drive driver=3Dhttp,\
> >              'url=3Dhttps://s3.example.com/some.img?X-Amz-Security-Toke=
n=3DXXX',
> >              force-range=3Dtrue
> >
> > Enabling the 'force-range' option without the backend supporting it is
> > undefined behavior and untested
>=20
> "Undefined behavior" suggests it could do anything, even destroy data.
> I hope that's not the case.  What is the case?
>=20
> What is "the backend"?  The web server specified with @url?

Undefined behavior was probably too strong of a wording. I have done way
more tests and have a clearer picture of what happens:

The web server for @url will respond with `HTTP 200` and try to send the
whole file. Since we specified `CURLOPT_NOBODY` to the libcurl it stops
reading the socket after the headers and justs shuts it down. The
`force-range` mode is transparent for the user even if it can wastes a
few TCP packets.

I'll rewrite the commit message to reflect the actual behavior of the
option in the v2.

>=20
> >                                 but the libcurl should ignore the body
> > and stop reading after the HTTP headers then we would fail with the
> > expected `Server does not support 'range' (byte ranges).` error.
> >
> > Signed-off-by: Antoine Damhet <adamhet@scaleway.com>
> > ---
>=20
> [...]
>=20
> > diff --git a/qapi/block-core.json b/qapi/block-core.json
> > index b82af7425614..ff018c2d6bfb 100644
> > --- a/qapi/block-core.json
> > +++ b/qapi/block-core.json
> > @@ -4582,12 +4582,17 @@
> >  # @cookie-secret: ID of a QCryptoSecret object providing the cookie
> >  #     data in a secure way.  See @cookie for the format.  (since 2.10)
> >  #
> > +# @force-range: Don't issue a HEAD HTTP request to discover if the
> > +#     backend supports range requests and rely only on GET requests.
> > +#     This is especially useful for S3 presigned URLs.  (since 11.0)
>=20
> Unlike the commit message, this doesn't mention the need for "the
> backend" (whatever that may be) supporting it.

Will rephrase "the  backend" with "the http server". Should I document
the behavior of the http server missing the range requests here or is
the current description sufficient ?

>=20
> > +#
> >  # Since: 2.9
> >  ##
> >  { 'struct': 'BlockdevOptionsCurlHttp',
> >    'base': 'BlockdevOptionsCurlBase',
> >    'data': { '*cookie': 'str',
> > -            '*cookie-secret': 'str'} }
> > +            '*cookie-secret': 'str',
> > +            '*force-range': 'bool'} }
> > =20
> >  ##
> >  # @BlockdevOptionsCurlHttps:
> > @@ -4605,13 +4610,18 @@
> >  # @cookie-secret: ID of a QCryptoSecret object providing the cookie
> >  #     data in a secure way.  See @cookie for the format.  (since 2.10)
> >  #
> > +# @force-range: Don't issue a HEAD HTTP request to discover if the
> > +#     backend supports range requests and rely only on GET requests.
> > +#     This is especially useful for S3 presigned URLs.  (since 11.0)
> > +#
> >  # Since: 2.9
> >  ##
>=20
> @force-range is is duplicated between BlockdevOptionsCurlHttp and
> BlockdevOptionsCurlHttps.  @cookie and @cookie-secret is already
> duplicated before the patch.  Time to factor out a common base type?

This would be only on the QAPI ? looking something like:

```
 { 'struct': 'BlockdevOptionsCurlHttps',
-  'base': 'BlockdevOptionsCurlBase',
-  'data': { '*cookie': 'str',
-            '*sslverify': 'bool',
-            '*cookie-secret': 'str',
-            '*force-range': 'bool'} }
+  'base': 'BlockdevOptionsCurlHttp',
+  'data': { '*sslverify': 'bool' } }
```

? Would you rather see this in a separate commit or is the same patch OK
?

--=20
Antoine 'xdbob' Damhet
Engineer @scaleway

>=20
> >  { 'struct': 'BlockdevOptionsCurlHttps',
> >    'base': 'BlockdevOptionsCurlBase',
> >    'data': { '*cookie': 'str',
> >              '*sslverify': 'bool',
> > -            '*cookie-secret': 'str'} }
> > +            '*cookie-secret': 'str',
> > +            '*force-range': 'bool'} }
> > =20
> >  ##
> >  # @BlockdevOptionsCurlFtp:
>=20

--s5ko24dehyyebxgk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEArm1WbQx2GmOsfF83AmjLzzljz4FAmmci/YACgkQ3AmjLzzl
jz6K6wf/ZxOyaAZLokOcekJJixi3eo+BmLer/1VR5KNSCyL/1QPI+2xAw9F6Z2Ce
hiwGjl4Bf/85Q1b+RpG7Y9wAsbKmPRPBYa0i3tXICDGkYenIdl1xYQwDwRyoKOLl
8lO9n1JsitGFEa5Dfx7OHL8Qf2MYjgsbf4mSd6UXaOJV/sViSclSXHuNobm7LoVZ
iWVkjCcQDBhRXTB1rDCjgqGxS573t0TCBBAWGMDSpjTjMRmCO0x4oq2IdaPK9oT9
xuuGVVs5DKL1HFBDtPac/tiWq5GoTEYuGZcDbnwxDCvcbbJNPiRmaWmXxDqgN4fQ
1bHWb6TUkdc8qi+ay9fWnxPBES/+xA==
=yVqm
-----END PGP SIGNATURE-----

--s5ko24dehyyebxgk--

