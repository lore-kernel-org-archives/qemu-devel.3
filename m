Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B72F0CA5FC4
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 19:26:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBzwg-0004R2-TE; Wed, 30 Sep 2026 15:26:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stian@itx.no>) id 1xBz6M-000740-I5
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 14:32:24 -0400
Received: from itx-kvm-14.itxnorge.no ([91.189.121.228] helo=mx.itxnorge.no)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stian@itx.no>) id 1xBz6K-0006F2-0y
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 14:32:22 -0400
Message-ID: <63d84da88caec4176900e535116d64b1c4cffffb.camel@itx.no>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=itx.no; s=mx.itx.no;
 t=1790793127;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=BaliE61Q7qWWqf6EFlB32vfYas0ixoEDrxrJk/bs7o8=;
 b=ZuNhIpLnkYhKoNf1kQBFCr7VXNoOH8WXu3vRR6dWmaET+UYK1h8KrxsIRfHMpVecM/29CI
 FTIu0HB0D4LiI52inhXELFVjsN9XZy/Mg470+yUTyPrbY9uO+oVNIARRUSbB5uudIXIYts
 yB61OlhkSq4Ul//k8vD3QkYmq6indAo=
Subject: [RFC] target/sparc: crypto instructions for Linux kernel testing
From: Stian Halseth <stian@itx.no>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Artyom Tarasenko
 <atar4qemu@gmail.com>, Richard Henderson <richard.henderson@linaro.org>, 
 Eric Biggers <ebiggers@kernel.org>
Date: Wed, 30 Sep 2026 20:32:06 +0200
Content-Type: multipart/signed; micalg="pgp-sha512";
 protocol="application/pgp-signature"; boundary="=-UP3dd7TkzxHZV1f+Ak5p"
MIME-Version: 1.0
Received-SPF: pass client-ip=91.189.121.228; envelope-from=stian@itx.no;
 helo=mx.itxnorge.no
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 30 Sep 2026 15:26:25 -0400
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


--=-UP3dd7TkzxHZV1f+Ak5p
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi all,

QEMU doesn't implement the SPARC crypto instructions, so the kernel's
crypto tests cannot execute optimized SPARC code.

See this issue[1] raised by Eric Biggers.

I became involved in this after submitting a patch[2] for native SPARC
XTS support. Since the kernel devs currently have no way of testing
this, outside of real hardware, the motivation is to make this possible
with the help of QEMU.

I've done some reading into the QEMU code, and might be able to
contribute an implementation.

Before investing time in it, I would appreciate some feedback from the
maintainers.

I'm thinking about adding a "crypto" CPU feature to sun4u=A0which enables
the missing instructions.

Why sun4u and not sun4v? Because it would allow a direct -kernel image
boot without the OpenSPARC firmware, which QEMU doesn't ship.

This would mean adding SPARC T4(+) instructions on sun4u CPU models.
This combo does not really exist, so I want to know if that is
acceptable, or if you would rather have this done differently.

Since the kernel currently learns about the instructions from the sun4v
machine description's hwcap-list, a small kernel patch would be
required to read a hwcap-list property from the OF CPU node instead.
OpenBIOS could set that property for a CPU that has the feature.

If this is not desirable, it can also be implemented for sun4v with
OpenSPARC firmware. Kernel developers would need that firmware and a
boot disk image, since niagara cannot boot with -kernel.

I have a T4-1 and a T7-1 (M7) to check the instructions against.

[1] https://github.com/sparclinux/issues/issues/77
[2] https://lore.kernel.org/all/20260929211218.4194135-1-stian@itx.no/

Looking forward to hearing your thoughts,
Stian Halseth


--=-UP3dd7TkzxHZV1f+Ak5p
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTK1ph9OaYoND1R57zoeAEuJe36VgUCar1VpgAKCRDoeAEuJe36
VrwQAP9sat6lFxxMRkxa/lCVOjjZw6yvB7EuUIVF0prDXeaaxAEAtcCSNw1RBoTg
juipzU44PiMsI91kxBHv/hdWn1jj1wU=
=ta6A
-----END PGP SIGNATURE-----

--=-UP3dd7TkzxHZV1f+Ak5p--

