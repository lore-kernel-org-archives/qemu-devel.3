Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68E31C44500
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 12:43:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh58X-00067m-87; Tue, 07 Jul 2026 08:42:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <C.Koehne@beckhoff.com>)
 id 1wh58W-00067X-1N
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 08:42:52 -0400
Received: from mx07-0090a401.pphosted.com ([66.159.244.62])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <C.Koehne@beckhoff.com>)
 id 1wh58T-0004fz-Mf
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 08:42:51 -0400
Received: from pps.filterd (m0463074.ppops.net [127.0.0.1])
 by mx07-0090a401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6674vEbf191614; Tue, 7 Jul 2026 12:42:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=beckhoff.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=mail2022r; bh=CAZsAfkiORhACbbOSS8Al4J8
 x1/zgu9fOpLttpTPoXQ=; b=gKaGcKScIsoUBQWprYl8AQGhw0u/NcdjRYsMATqk
 pajfeqoi1pq0whfR4Wuv5snOOGz6iofjXfa3eU3j+NbaVt5s3EOTwtr86xoNcHpf
 nzHlKF9IsxCpTibXvoVpeaJY9gdeAy5LCuy0ytKDE2VkaHJeqyiRv5VkC6GeL/rN
 GU9wvVRwIpRcNpy1RzTPeorVw1h6CfcSyIumY5qQspzBpIlvzBfas97YywsSQJAM
 GxVW0gyJtkEtI/rngvJJO8f6AakomCekRz8PaMoA+tk0FFAtcvjn06RA37aK6IHB
 i4nE77NUPbVCYb2mjib0mIo++56Wmuh5U6npp4dbuhnh5Q==
Received: from ex10.beckhoff.com ([62.159.14.12])
 by mx07-0090a401.pphosted.com (PPS) with ESMTPS id 4f7fkt4ych-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 07 Jul 2026 12:42:43 +0000 (GMT)
Received: from ex10.beckhoff.com (172.17.2.111) by ex10.beckhoff.com
 (172.17.2.111) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Tue, 7 Jul
 2026 14:42:41 +0200
Received: from ex10.beckhoff.com ([fe80::ab7f:9a91:d220:441b]) by
 ex10.beckhoff.com ([fe80::ab7f:9a91:d220:441b%12]) with mapi id
 15.02.2562.043; Tue, 7 Jul 2026 14:42:41 +0200
From: =?utf-8?B?Q29ydmluIEvDtmhuZQ==?= <C.Koehne@beckhoff.com>
To: "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: =?utf-8?B?WWFubmljayBWb8OfZW4=?= <Y.Vossen@beckhoff.com>
Subject: Re: [PULL 08/21] hw/misc/zynq_slcr: Add logic for DCI configuration
Thread-Topic: [PULL 08/21] hw/misc/zynq_slcr: Add logic for DCI configuration
Thread-Index: AQHdAlZYgQY+snQzDkeSwQPj2+oZmrZh2NqAgAAdIwA=
Date: Tue, 7 Jul 2026 12:42:41 +0000
Message-ID: <e6a5de30cd451e820007513b869a87bf5fe4890d.camel@beckhoff.com>
References: <20260529114723.42040-1-peter.maydell@linaro.org>
 <20260529114723.42040-9-peter.maydell@linaro.org>
 <CAFEAcA-880g8FVk1SZ8eH7-cAkzh2oyH7OFV2LBG68=CcFE=JQ@mail.gmail.com>
 <CAFEAcA_Lg3ebEiefKmf1K_RHY4NozezGese2rFf2w6af3oPccQ@mail.gmail.com>
In-Reply-To: <CAFEAcA_Lg3ebEiefKmf1K_RHY4NozezGese2rFf2w6af3oPccQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-originating-ip: [172.17.0.1]
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="=-+hOKFDcU7wpxfJSG9XA2"
MIME-Version: 1.0
X-Authority-Analysis: v=2.4 cv=Vo4Txe2n c=1 sm=1 tr=0 ts=6a4cf443 cx=c_pps
 a=ZkhbYXbYXnnsONUOWLo3Bg==:117 a=ZkhbYXbYXnnsONUOWLo3Bg==:17
 a=xqWC_Br6kY4A:10 a=LK_TxX5vjfYA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=a9bgyBvlNMQzFU9Z5g25:22 a=PpDwSNkculO1Pa3iPHCZ:22
 a=zd2uoN0lAAAA:8 a=KKAkSRfTAAAA:8 a=Cmw_MBCVAAAA:8 a=LoRRrZhI9vVAXCTCaycA:9
 a=QEXdDO2ut3YA:10 a=WfFYhIbffbJ_wg4ibogA:9 a=FfaGCDsud1wA:10
 a=cvBusfyB2V15izCimMoJ:22 a=ZJSrCmYe3mwGoKZA4Vko:22
X-Proofpoint-ORIG-GUID: HyUVYmZ2Vwt-YVCyjraospYL4fYyKj6x
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDEyMyBTYWx0ZWRfX+x/VEh6Fnvrv
 vxJKk1ZaOPC+asWlDJrLbVlU5Aa79sr9ViD2Pv2qRgF3RDZHkcqe9455Do60EeJw1dxhA3DIRMr
 uvSTeclKXOrNYsFsl/mZNy5HKHvfbCo=
X-Proofpoint-GUID: HyUVYmZ2Vwt-YVCyjraospYL4fYyKj6x
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDEyMyBTYWx0ZWRfXwFXK7QUraLXr
 GOKJMjg7Rx0hGSGpHJqsGcg57TXCaFawOU+VNZMygJP6NdUKVBtIPF9/J+qkxtS1MDp27oCBUcE
 WASwMF/p403N6G63Gr8R7ZGlF40LowrwRsvyXBqD9+z5JLijtVo0iY9kVPUDPH5WlHB8/+TCILG
 7XCQWNdHMm6af9wrBNsb8eCVfTCTu6DY8P4cunFU6I6uc0lP8LAmQqU62UdjNDNYWQDWXMv4ouo
 LpDMWlJdLU1CqkeWKUSrbTOT/tUOUOGSMo5bMauGTTUTmmZMF8CimaS73K4G7qyw6gjwSzep1ox
 NyMm/YqkNvPlHoymZgmvkVw2IieQPk9WfJQHPnVsZBIBgzRVjv4xGZS56mo/W2OxBiKAweefQnH
 uWtU8PZAvvOQS1uOngjygt3HXIY5tr2ARZX/C73G7S3OtwkPjKCd7IoWMUhtrLDFiGS1MCSts7i
 DWbWXwvWusigeHDkjwA==
Received-SPF: pass client-ip=66.159.244.62; envelope-from=C.Koehne@beckhoff.com;
 helo=mx07-0090a401.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

--=-+hOKFDcU7wpxfJSG9XA2
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

Hi Peter,

sry, for the late response. I've checked the manual [1]. 0xb70 is the right
offset for R_DDRIOB_DCI_CTRL. Additionally, the correct reset value is 0x20=
 not
0x21. The commit also requires 0x20 as reset value because it tries to dete=
ct a
toggle of the reset bit (bit 0). Do you fix the commit or should we do it?
Thanks for catching!

[1]
https://docs.amd.com/r/en-US/ug585-zynq-7000-SoC-TRM/Register-slcr-DDRIOB_D=
CI_CTRL


--=20
Best regards,
Corvin

On Tue, 2026-07-07 at 11:58 +0100, Peter Maydell wrote:
> Ping -- Corvin, Yannick, please could you suggest the right resolution
> for this bug?
>=20
> thanks
> -- PMM
>=20
>=20
> On Mon, 22 Jun 2026 at 15:49, Peter Maydell <peter.maydell@linaro.org> wr=
ote:
> >=20
> > On Fri, 29 May 2026 at 12:47, Peter Maydell <peter.maydell@linaro.org>
> > wrote:
> > >=20
> > > From: YannickV <Y.Vossen@beckhoff.com>
> > >=20
> > > The registers for the digitally controlled impedance (DCI) clock are
> > > part of the system level control registers (SLCR). The DONE bit in
> > > the status register indicates a successfull DCI calibration. An
> > > description of the calibration process can be found here:
> > > https://urldefense.com/v3/__https://docs.amd.com/r/en-US/ug585-zynq-7=
000-SoC-TRM/DDR-IOB-Impedance-Calibration__;!!PlYMe_wG1g!lthDLWtCQd7a8JMN8G=
4iIPO8hmKqHg5ON9qsiI2YQGx5fTuThS3u5WwV6IeiZCeJf2gNSKMWSZ2wKu91Kb6gVFdpPQ$
> > >=20
> > > The DCI control register and status register have been added. As soon
> > > as the ENABLE and RESET bit are set, the RESET bit has also been togg=
led
> > > to 0 before and the UPDATE_CONTROL is not set, the DONE bit in the st=
atus
> > > register is set. If these bits change the DONE bit is reset. Note tha=
t the
> > > option bits are not taken into consideration.
> >=20
> > Hi; we've just had a Coverity Scan run that went over this code,
> > and it points out an issue:
> >=20
> > > =C2=A0REG32(DDRIOB, 0xb40)
> > > +REG32(DDRIOB_DCI_CTRL, 0xb70)
> >=20
> > These REG32() macros define R_DDRIOB as 0xb40 / 4 =3D=3D 0x2d0,
> > and R_DDRIOB_DCI_CTRL as 0xb70 / 4 =3D=3D 0x2dc...
> >=20
> > > @@ -418,6 +428,8 @@ static void zynq_slcr_reset_init(Object *obj,
> > > ResetType type)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0s->regs[R_DDRIOB + 4] =3D s->regs[R_DDR=
IOB + 5] =3D s->regs[R_DDRIOB + 6]
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=3D 0x00000e00;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0s->regs[R_DDRIOB + 12] =3D 0x00000021;
> > > +
> > > +    s->regs[R_DDRIOB_DCI_CTRL] =3D 0x00000020;
> >=20
> > ...and here in the reset function we are now initializing
> > both s->regs[R_DDRIOB + 12] and s->regs[R_DDRIOB_DCI_CTRL], but
> > those are the same array element (since 0x2d0 + 12 =3D=3D 0x2dc).
> >=20
> > What was the intention here? Which reset value is correct?
> > Should we be resetting some other register where we currently
> > are resetting s->regs[R_DDRIOB + 12] ?
> >=20
> > thanks
> > -- PMM



This email contains confidential information. If you have received it in er=
ror, you must not read, use, copy or pass on this e-mail or its attachments.
If you have received the e-mail in error, please inform me immediately by r=
eply e-mail and then delete this e-mail from your system. Thank you

Diese E-Mail enth=C3=A4lt vertrauliche Informationen. Sollten Sie sie irrt=
=C3=BCmlich erhalten haben, d=C3=BCrfen Sie diese E-Mail oder ihre Anh=C3=
=A4nge nicht lesen, verwenden, kopieren oder weitergeben.
Sollten Sie die Mail versehentlich erhalten haben, teilen Sie mir dies bitt=
e umgehend per Antwort-E-Mail mit und l=C3=B6schen Sie diese E-Mail dann au=
s Ihrem System. Vielen Dank

Beckhoff Automation GmbH & Co. KG=20
Managing Director: Dipl. Phys. Hans Beckhoff
Registered office: Verl, Germany=20
Register court: Guetersloh HRA 7075

DisclaimerID:x9d5u140


--=-+hOKFDcU7wpxfJSG9XA2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEgvRSla3m2t/H2U9G2FTaVjFeAmoFAmpM9EAACgkQ2FTaVjFe
Amq2/hAAhGhNhxGLGgn6MnrN4QW7DswJNnvFp4efyHjzODnWXiJjudtAHnDzoYbD
43y9VldrkCnGDH1bBt8e1VpdxZmz23y7Dh+KqJKBP4lZu1KsUJ5nJnY4futCJvUs
NkQv7TZ+J6IjkUxVcJFp7YZ9eZAgjnheICx3Lbqt5KoEQ1OEynL1PKnLaAgaZDXi
ezX1YjGmoS18Z8UTxAZuj5oqnlPWm8v+nxOa1X93s6qbpT4UqnIQcLlnLnECIEtb
yfNXuL6bXia48QiqFUXvtdH0UhTbyP1FCfIIapmQHfkVImYRHgoc6RuEM6jCCsDJ
48OcSuERjEX/Q97MMKEyys2Yy/lINKe63CbMuktRa43aIVW7nRA152Sc3dI28s85
VFND19miOF5Uq2neySbDuPdE/jUZzgknpnpabtsFVuW2616yXKC5Reh7LZLwUzJE
uoXjsmG4aDEWNEmCiuSz3AHKtN+ictEnpEdHthnZabn2w8ZleCi3PRwzuzTfLQ1V
x259mWya3hD6J2WNOEq0YmgdWO/DLxqygD5mqqsXLsh3HjdFFWJWU/K+yK6751oc
zIB7+/lPVe5lQ5pDaRu+fK53e+KFziS8OHVLTtmIpAWejSp01dwDYIkgmqv5KdKP
fpATlTu8viqlXUPpisPFGWzg1JZdOjQgYT1tZ2Amx7XUQOfxrck=
=4pBs
-----END PGP SIGNATURE-----

--=-+hOKFDcU7wpxfJSG9XA2--

