Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16AC1C54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 08:15:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rm895-0002Oz-Gx; Mon, 18 Mar 2024 04:14:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <olaf@aepfle.de>)
 id 1rm893-0002NX-Cs; Mon, 18 Mar 2024 04:14:57 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.221])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <olaf@aepfle.de>)
 id 1rm891-0003L1-Fh; Mon, 18 Mar 2024 04:14:57 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1710749690; cv=none;
 d=strato.com; s=strato-dkim-0002;
 b=U8XPXAX5nNH0Ow2UeMvN4hmQWdt1O0JthA1Zn8dpKhn+ilu/cZ8WzuDucM9O8bv0s2
 6vMm90arPaMFY7JzlqIm71CRJVAAGkSjW/DbNg8cwnSnBiV786zR16xgVtMYIX/2LzAZ
 TAbMS8iUAnYDUrlcATs4jjwWNmJQN5b714hLyF2d9YrbJ7MLMD+bJp9cNV69naXY11nT
 c5fQWxJkuvkdpkGDo+/d3utv6y5USHp4NfUp7XuuHTHGaYvxhNMUoxgVfe3phM1HlDtM
 eodKxDY9FTbGugZlpAgzBjb2ztW073EKWT7qqDMpi3U9DHRBXvhmFxwp0EaX9WBMngHz
 i/eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1710749690;
 s=strato-dkim-0002; d=strato.com;
 h=References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
 From:Subject:Sender;
 bh=aB5JtzWUCB4K9dAVzX213ZjUL2cozuT0dstO0lWsREY=;
 b=ltQEUbr9GaoU9iNefCQ7qcFh7dW/rimR/ZtvlCICKVovV6nhQinlW9tG/zofG2EAVs
 WtcOdZNyVEum87P32t80lEdT6XeVmN81aF38+RvSL4e8OLW5+H9YEt7qJgiLHEw8bEU1
 OaX+O2wvYLRtrgT/shVFtooDTzYDDEZOxZgtGPMF83EJt4tfNZ0WE0Uyd8HfFPnqxnKh
 p+b6tkKAw+aeim2bzNiDCtUQmStk5PYkra72pNy2YKNSOZiLbjS0MqMzxteGFx6gj5xB
 ABUf5rHyZUj2pA4SKQ9YM4k7dPajf3Pli03LHhUvphQdp3dx2b958yxwedNVSoNIlYDf
 FR0Q==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1710749690;
 s=strato-dkim-0002; d=aepfle.de;
 h=References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
 From:Subject:Sender;
 bh=aB5JtzWUCB4K9dAVzX213ZjUL2cozuT0dstO0lWsREY=;
 b=W/t0vJU2U9B2XhUVRi/NmSfbCUoolF/pMBe1c3FLNNgX3mgrxWREzrexUPS63gH2nt
 A2+Rwi5XdG7bVcUcQifA5P6r2qMz6OJJzbi+cUQdcHO6Nz3A6QppkDPfTJ87iQKbi+gs
 2fKAXxaT+Z4o97Yc/iBqm6SAsLkbiFxk5822lv+ZVHhK5gkjpDbCJTxQDVbZFsJCXUWA
 LY7iay1yhNlHYBOwoOw3A11+TOx9W9cPxpzznAHo9b8OTRM1bEzDalcu8L6pkDUwa16f
 sYOBKMuUkk0pLhCg/NjIbAtTn6bRuiu6P2oIRaCsfFQt871sspKM8TV9cXwJBqEJ4aq/
 IQgw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1710749690;
 s=strato-dkim-0003; d=aepfle.de;
 h=References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
 From:Subject:Sender;
 bh=aB5JtzWUCB4K9dAVzX213ZjUL2cozuT0dstO0lWsREY=;
 b=1GI9TK7oQg3SBkh8D8khCl4GQL8+l2t4lazfZK/FsA/nhgFrQiCUakdIKll+yWvLon
 JEWrnpqMYW4psQt0FjBg==
X-RZG-AUTH: ":P2EQZWCpfu+qG7CngxMFH1J+3q8wa/QLpd5ylWvMDX3y/OuD5rXVisR5ABaIaxjsvWV3+5zoB6xJde0knZVA/JvNMMXDFQ=="
Received: from sender by smtp.strato.de (RZmta 50.2.2 AUTH)
 with ESMTPSA id 6fe76102I8EnAYf
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
 (Client did not present a certificate);
 Mon, 18 Mar 2024 09:14:49 +0100 (CET)
Date: Mon, 18 Mar 2024 09:14:41 +0100
From: Olaf Hering <olaf@aepfle.de>
To: =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@gmail.com>
Cc: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org, qemu-stable
 <qemu-stable@nongnu.org>
Subject: Re: Regression in v7.2.10 - ui-dbus.so requires -fPIC
Message-ID: <20240318091441.54272fbf.olaf@aepfle.de>
In-Reply-To: <CAJ+F1CJyhEYhXewLV4SOGNfgiA3V2kfotVqYgcGEckvO4XLp7A@mail.gmail.com>
References: <20240314220038.1aaae79f.olaf@aepfle.de>
 <4b803768-09df-4b6c-a745-f0158543310d@tls.msk.ru>
 <20240316231945.7bcfac09.olaf@aepfle.de>
 <a9e4fac5-2a1e-4d15-afa5-bae42756ec42@tls.msk.ru>
 <CAJ+F1CJyhEYhXewLV4SOGNfgiA3V2kfotVqYgcGEckvO4XLp7A@mail.gmail.com>
X-Mailer: Claws Mail (olh) 20240223T214820.cce9f45c hat ein Softwareproblem,
 kann man nichts machen.
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/zG=9/E=uwtByW9iCMJTVBVj";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=81.169.146.221; envelope-from=olaf@aepfle.de;
 helo=mo4-p00-ob.smtp.rzone.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001, SPF_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

--Sig_/zG=9/E=uwtByW9iCMJTVBVj
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Mon, 18 Mar 2024 11:35:54 +0400 Marc-Andr=C3=A9 Lureau <marcandre.lureau@gm=
ail.com>:

> Alternatively, we could always build with pic: true (or pic:
> enable_modules), but that's not ideal either.

I'm sure that unconditionally building with -fPIC has no downsides in this =
context.


Olaf

--Sig_/zG=9/E=uwtByW9iCMJTVBVj
Content-Type: application/pgp-signature
Content-Description: Digitale Signatur von OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE97o7Um30LT3B+5b/86SN7mm1DoAFAmX39/EACgkQ86SN7mm1
DoBGjQ//aMrEw9IVyhElBhDsxHWQ+qfcTDpY10/WAe3h/5C20c2dwzYOl0bqwhGs
ALHA+sC8Uin+Oni4JCzA9uf7CF47lgZYL2H/fojM36J7fc8x+g/dAOk6HL/vPl1s
w0WslvZNiUX2np+PjznQPlF1nRP1e5tPfdY3JyY89CR/iHRJQLIIdKQQdEOHsSxs
/YF5mH/uXZfyj4gBkEcqDKqDHmy2cc0fEkjapyrnEpAB4WrE45P8OQaqCPTIYFrU
351bLvXU7xO1T3AEYbIFT/d2LrL5JXG4ho7aMctSBVicSnZ6+sBlX0Gwy1mpjz3R
3P4cW2MOUVfO5K0qKD+oRtKkQczN4xx6vY5NdybnMo1rjrWORfq41BUc1othCOpK
OkEwVX1HXFciT/N21Aww9h+MT4W7uyHUiXPBH4RW/n62kkgvsdRrJ+10S7vGKjvf
kUANqaKkztOPZNQLPb/Lp6mJgWNa6JcaJJslnOj8ZMRZN1wg6OwisszGakay9Ezo
fnYci8pFwJzMFvy5dNEN2Dut4c3OOkK++JC0K9W55p38xbmfxQlKhPrLtf6tgqqt
Jurr8ugYNoH1gT7GS4z6p1ZhslU52RO+6LjnI+9piDQ8xyEK4ducdyrrdg7h9MQS
hXAn9GtaXLsxJPxElSuEEsLXs9rHU+Z4tXzuYznZCllsAUU8khA=
=KPYj
-----END PGP SIGNATURE-----

--Sig_/zG=9/E=uwtByW9iCMJTVBVj--

