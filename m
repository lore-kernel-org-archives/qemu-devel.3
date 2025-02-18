Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 455D4C021AD
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2025 20:19:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkU3M-0008UE-Nv; Tue, 18 Feb 2025 15:18:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <keithp@keithp.com>) id 1tkU3K-0008Ti-Su
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 15:18:46 -0500
Received: from home.keithp.com ([63.227.221.253] helo=elaine.keithp.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <keithp@keithp.com>) id 1tkU3I-0003YW-MN
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 15:18:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=keithp.com; s=mail;
 t=1739909921; bh=Z9vRF4BtyceR0nKjcKtOmiTTz2Xpzfq5Js2JtC1ywtg=;
 h=From:To:Subject:In-Reply-To:References:Date:From;
 b=EFbiAkEa3pHP//G5HgXC7aAiQHUajwj/JcnfrFMCEtrdoRWm4dkrLSgk1ryj4hlej
 7N/+jSO2GDt454xT0EwMKpWE9YUnD+/+dV35vLesI5EH32SJ74iEtkDs+OaZFLhygd
 kOUPbGxSTASISmvf01hSim1tSkHArc9bNSzOx7mD6BQgqR11Bi4U+Rh2mQXRI3q818
 rjaZEq9nLU4rZt0BNdO5NOe0T06dUZFYybU70B+bkoU2y6d67nGsCU3kae6q81886y
 DD+TeagTQFJ2pZDKGDQmfmlC1LQHhXP/N+guJSmL8u1wOpkMdu5NxP/IHEdYwNUQ8v
 rPCifdxW5CiUw==
Received: from localhost (localhost [127.0.0.1])
 by elaine.keithp.com (Postfix) with ESMTP id E3ACE3F20D3C;
 Tue, 18 Feb 2025 12:18:41 -0800 (PST)
X-Virus-Scanned: Debian amavis at keithp.com
Received: from elaine.keithp.com ([127.0.0.1])
 by localhost (elaine.keithp.com [127.0.0.1]) (amavis, port 10024) with LMTP
 id cs2c27tjwsIQ; Tue, 18 Feb 2025 12:18:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=keithp.com; s=mail;
 t=1739909920; bh=Z9vRF4BtyceR0nKjcKtOmiTTz2Xpzfq5Js2JtC1ywtg=;
 h=From:To:Subject:In-Reply-To:References:Date:From;
 b=ssFwvUJY+p4t4AaHlgMGarfBHwAqu9UcuGcV1ZiKRH4/w2HqkA0y03hkz17J8fUgL
 aOe/xBwfiwSfkB2scea80qaNUEAuke0gkMtmAuadXo2HegvL2TxU5WiEeeaF6nf7Vc
 BEfgjbKNA8imxBwtUxPsNjtjIdPr5PIrW8ThKwAuwp0sb0gujREYjc4Woc2ng7WDSQ
 JwM23pfr7FYRBsUTPSeq3fd1eTeD+maxALunw1zH/yHSCCWuW6Z/H96yZlkI4BAPyO
 ADZyiy3RJNSWHPOkkzi02HusJfnRT+OGGs0VhBdvfPC7PEGfQhNeY5TW8huVjGpjkp
 /UG3f8iEiuAPg==
Received: from keithp.com (koto.keithp.com [192.168.11.2])
 by elaine.keithp.com (Postfix) with ESMTPSA id D38CD3F20C61;
 Tue, 18 Feb 2025 12:18:40 -0800 (PST)
Received: by keithp.com (Postfix, from userid 1000)
 id C0E191E60096; Tue, 18 Feb 2025 12:18:40 -0800 (PST)
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 4/5] target/rx: Load reset vector from memory after
 first run
In-Reply-To: <87seobypvv.fsf@keithp.com>
References: <20250215021654.1786679-1-keithp@keithp.com>
 <20250215021654.1786679-5-keithp@keithp.com>
 <f7c1e671-f114-40a6-a02b-575bde2de4c4@linaro.org>
 <87seobypvv.fsf@keithp.com>
Date: Tue, 18 Feb 2025 12:18:40 -0800
Message-ID: <87pljfypjz.fsf@keithp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha256; protocol="application/pgp-signature"
Received-SPF: pass client-ip=63.227.221.253; envelope-from=keithp@keithp.com;
 helo=elaine.keithp.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Keith Packard <keithp@keithp.com>
From:  Keith Packard via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


> > By delaying the load of the reset vector to the reset_exit phase,
> > you can always load from rom.

> I'm not sure how -- the ROM image is discarded when it gets loaded into
> read-only memory. If loaded to read-write memory, I bet it would
> stay around.

Ah, but by delaying until after cpu_reset has finished, I can always
load it from target memory. I bet that's what you meant, and yes it
works fine.

=2D-=20
=2Dkeith

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEw4O3eCVWE9/bQJ2R2yIaaQAAABEFAme06yAACgkQ2yIaaQAA
ABF0mw/9HdjL9k4PCj8cgOU4lST+Rr0l/uzxzCqEyizA7RctazZBn3UYMHIU1pzZ
HACzX2xqErTYZBlFMEKeeMYX3ply3NyMYVq84AQq5tiN94zNjXi2Yf2gAQYCRABr
hrPBIIeVoJ+lHG8NAzw/eYTUjTk8tPzP/4iG2hv9nOrl+6HzphK1734M67OAZMw2
KgHvHCLFVMWTIrAN/rSaumC/tbSJUPwXjeP3dduWbvJNYVK2DGTaaXXNi0a8eH1F
LJAuoNLm9TlvEDSaZdZ7ZsPgGuTo+1IFgoK+FQWEjlHKlOqbyRn9EH7dZpaFh1NV
MrQ1No+CA2zYxvSkZywGQtplMDR7FxAOyJj2Qjmq8yz/Y0Vi/mI2/ULN53alRz4O
o3eue0YDAbc+ndySE9KN0JAGppXPYgw2Pxlz0u3JmOCV5wR5r3zEV8n6WV1z+/9H
vfTVPzcWPe2nxyWlu1qW55kXmJ585WUNKf+p/NlGKwclhxOe7aZ7ye0+3JAoyAqd
SzZwl7ch08oPUARmlIlMG0icngw2/+aIRoo5F7wJQAedpP2ZhsrnF/n1u76hj1gw
1cy9YRWYLMRr5yjvAjD4J5pBymn5/AwKsC3tRQw1zWEU/VjpSNzyVrdTXvOMOiKa
s3Tic4cDg40FpFm+6CRb6al1DLSMu+Ni6vfprAIa3A7Q+18OqY8=
=otL6
-----END PGP SIGNATURE-----
--=-=-=--

