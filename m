Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5B8FC3ABAA
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 14:11:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBwWp-0007nL-Tv; Mon, 05 May 2025 10:10:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <C.Koehne@beckhoff.com>)
 id 1uBwWn-0007n2-QT
 for qemu-devel@nongnu.org; Mon, 05 May 2025 10:10:41 -0400
Received: from internet2.beckhoff.com ([194.25.186.210])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <C.Koehne@beckhoff.com>)
 id 1uBwWl-0008D6-IL
 for qemu-devel@nongnu.org; Mon, 05 May 2025 10:10:41 -0400
DKIM-Signature: v=1; c=relaxed/relaxed; d=beckhoff.com; s=mail2022e; 
 t=1746454236; bh=RXQIO0VF494EcwV3h9r7Kn6JBapX4FKBc/dpvYRYiW0=; h=
 Subject:Subject:From:From:Date:Date:ReplyTo:ReplyTo:Cc:Cc:Message-Id:Message-Id;
 a=ed25519-sha256; b=
 8Ke3XUgDaEpNBr2SCRk7iv4zTli1VYskHxPIDDcKF1UfIUhgBjWim0FNoevApUqkB7XFWfh1nBItV/Akz4dXCA==
DKIM-Signature: v=1; c=relaxed/relaxed; d=beckhoff.com; s=mail2022r; 
 t=1746454236; bh=RXQIO0VF494EcwV3h9r7Kn6JBapX4FKBc/dpvYRYiW0=; h=
 Subject:Subject:From:From:Date:Date:ReplyTo:ReplyTo:Cc:Cc:Message-Id:Message-Id;
 a=rsa-sha256; b=
 saWOMKHH7cUnRwNHUdkX1RaLt6AWsRDuVi46bqofugUiJdewnzJTuE8J1Qu7fXFY4fiSDzq7BmRA02yCwxAbEVg4JnOmV5TZdiGXL2ayBcyO3cUhOefuXKyOndboT9jqlYfvmdCrpEiNM0vzG1sIFTm6HKu7UDfTQy0/B8+FjojqPaFfa1y4tC1QtLu0mmZ9oz19VrHEMY3KNH461MiiV7bwXX07x2yVHYU0k3U2RujOkQCwvrdw2vLB7GrOopN2CRQeKI55hp9n6uhIlLGFBZRXXc46tdpoqL/UqgbhimOwPZ4oUmzZ1atFjALYdT8hdElivvkyB9+PiLnH24G9FQ==
Received: from 172.17.6.17 by INTERNET2.beckhoff.com
 (TLS-ECDHE-RSA-WITH-AES-256-GCM-SHA384); Mon, 05 May 2025 14:10:36 GMT
Received: from ex10.beckhoff.com (172.17.2.111) by ex09.beckhoff.com
 (172.17.6.17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 5 May
 2025 16:10:34 +0200
Received: from ex10.beckhoff.com ([fe80::3762:2101:fb4e:8ffa]) by
 ex10.beckhoff.com ([fe80::ab7f:9a91:d220:441b%12]) with mapi id
 15.02.1748.010; Mon, 5 May 2025 16:10:34 +0200
From: =?utf-8?B?Q29ydmluIEvDtmhuZQ==?= <C.Koehne@beckhoff.com>
To: "tomitamoeko@gmail.com" <tomitamoeko@gmail.com>, "clg@redhat.com"
 <clg@redhat.com>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [PATCH 0/9] vfio/igd: Detect IGD by OpRegion and enable OpRegion
 automatically
Thread-Topic: [PATCH 0/9] vfio/igd: Detect IGD by OpRegion and enable OpRegion
 automatically
Thread-Index: AQHbuFgLsPDZ7OqaF0CrzzvIIQeNGLPDjd0AgABZewCAABVegA==
Date: Mon, 5 May 2025 14:10:34 +0000
Message-ID: <7a2efeff96ac8d2bb62d0eb35c35438551eaba32.camel@beckhoff.com>
References: <20250428161004.35613-1-tomitamoeko@gmail.com>
 <92f3d3f6-d90a-4010-b67f-b282ed5f3c91@gmail.com>
 <38a01aeb-858d-4d25-b79b-a31d29118ca9@redhat.com>
In-Reply-To: <38a01aeb-858d-4d25-b79b-a31d29118ca9@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-originating-ip: [172.17.62.149]
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="=-5aVLwWuzRSQuhbr4wG4A"
MIME-Version: 1.0
Received-SPF: pass client-ip=194.25.186.210;
 envelope-from=C.Koehne@beckhoff.com; helo=INTERNET2.beckhoff.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

--=-5aVLwWuzRSQuhbr4wG4A
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2025-05-05 at 14:54 +0200, C=C3=A9dric Le Goater wrote:
> CAUTION: External Email!!
> On 5/5/25 09:33, Tomita Moeko wrote:
> > I forgot adding v2 in subject, sorry for my mistake.
>=20
> That's ok. Just use a v3 in the next spin, if needed.
>=20
> Only one patch, the last, is not reviewed yet. Will there be a v3 ?
>=20
> Thanks,
>=20
> C.
>=20

Sry, somehow missed the last patch. Have reviewed it now.


--=20
Kind regards,
Corvin

--=-5aVLwWuzRSQuhbr4wG4A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEgvRSla3m2t/H2U9G2FTaVjFeAmoFAmgYxtkACgkQ2FTaVjFe
Amp2xw//XwGuOaFxApAxYc259ejuPCpsvBwIv7Lr3BUMMwECJB82ABOa0Yob5Kcu
QXqUbRtUKCsF2rPm7jhyBCe7Hm/4n7ZJHS2bbMg1A9fx97k/S31K7SdealgQfckm
3JFwMALhm1NzxcMq0RSanWu65xmt/Hkom3ik1E7REIM/xuzt/S5PPNgIzOMf/Fnl
buMEAYebEJ3J5kybJ2N4+UdCASiZ+6sVraBZHZ22mIDzb3LiXaLObskdAsyiupXf
Dsu/WLOKRdWm1aVKVGd9Lee+MVkQJOxTjCjQl0EIFD08pMbajszluylMk28SUQp+
9WxssyvrIJ//T8gYPiT2/nvTDvPVC/uVUx0evr2RzTYzxhYRv8yMCxeLYJ3tg3hI
FG0FdOKTMr285ysrEboSNb9Jc8+CRXAaxju30lc0ZDkAByQ1F1CeH/1h3sFpZjZG
DWCeutJ2i5BSGnI3+H4h2W4LQijZe2AE0D15G2mDu+7L8U0mI+UZma4aBKPViEHW
TAVLXBzBciwhRvlKTLyQ2ID754PEVZSzuL45NO4JHLZr/G4Dyk4YvE+yyMf0UrOE
0z2Hi3QkKkBU9mv+nOrkf5hErHpaHNbnBnbIDMygcM/Q+sQ+a7QGedyUV1uo6mDK
aop2PQb8U9cCAovVui4R3kyhodn/AnkXVDh56RjaEPM3eryF8BI=
=4qQX
-----END PGP SIGNATURE-----

--=-5aVLwWuzRSQuhbr4wG4A--


