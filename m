Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35C08C5AE59
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Jun 2025 00:36:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uLWfe-0001is-Ec; Sat, 31 May 2025 20:35:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <keithp@keithp.com>) id 1uLWfb-0001iT-BP
 for qemu-devel@nongnu.org; Sat, 31 May 2025 20:35:24 -0400
Received: from home.keithp.com ([63.227.221.253] helo=elaine.keithp.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <keithp@keithp.com>) id 1uLWfX-0004UC-GH
 for qemu-devel@nongnu.org; Sat, 31 May 2025 20:35:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=keithp.com; s=mail;
 t=1748738115; bh=vvm9UKc3OQrNToji/RmBnOTOHumREBMqc37QKNKTn2s=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=rbsFo++22ETdndl7VJcnMIac7BKYkXtkxkRkowyQTzmbQNc1tisp8oomC5yUzjW0R
 kG/iFkEhdWtX9jCIIf9l+m6rbTTih3XK/IE3p5bf5qG9nVvWu8na8TwNesu+mWhEln
 p0YNk1UfCOMbbDEPVdl/1iqDkQvZYs2+oeEqJ0KAkoUqj0SXWSLHxfaF0i+5S5nvCm
 MjxtoVwzP5ryqvxAR5D6J0lXEjc19MitpqAWS+RFkxWxyvNAxaKxM41vwBEkhWs8nH
 DUNcoJXzhNKFlxVnYzXPRADazhpTA5ET9Q4t9Zr8QP7h01fV/EfIF7JrmTSg9gJzsQ
 XeoYkRt+Mcesg==
Received: from localhost (localhost [127.0.0.1])
 by elaine.keithp.com (Postfix) with ESMTP id F40423F226AB;
 Sat, 31 May 2025 17:35:14 -0700 (PDT)
X-Virus-Scanned: Debian amavis at keithp.com
Received: from elaine.keithp.com ([127.0.0.1])
 by localhost (elaine.keithp.com [127.0.0.1]) (amavis, port 10024) with LMTP
 id 0Gn7N12Z2GWr; Sat, 31 May 2025 17:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=keithp.com; s=mail;
 t=1748738113; bh=vvm9UKc3OQrNToji/RmBnOTOHumREBMqc37QKNKTn2s=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=LncFyuIftqbema4MsVP270A2iiqJdUSHuPBkUwzcdyoB/T0FL+zllr14JO/Nd0ShB
 AMjTDh+wVUCtq37idKNZBGsAZ8i064WAw8nBaNdb/CFSQ7OhglLBk3ll6CbjIDyEtu
 WXzSintJUshjgUaBS70kvNmdnkdllawI3o0u/8MwHXJNrX1+L9OBVIsG1xD/7noVY7
 cgwoIK23SzcPFRiCFxxsE1JQ2yG5msfnAzn+7N02fx9aFQNt4JkEIYCm0fzHLRbnsa
 U8m6JEoBz83ybcE59aUbkXKM0gbTYDJEERkwqcWOQ90tnjZ+Gv9CZKUvzCJ+aTZUYo
 bwxA20cO3Upsw==
Received: from keithp.com (koto.keithp.com [192.168.11.2])
 by elaine.keithp.com (Postfix) with ESMTPSA id 887933F20B7C;
 Sat, 31 May 2025 17:35:13 -0700 (PDT)
Received: by keithp.com (Postfix, from userid 1000)
 id 51C961E600FB; Sat, 31 May 2025 17:35:13 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 4/4] rx: Support loading of ELF files too
In-Reply-To: <CAFEAcA_5tnaXvGXXp17=LKNkr6+BWcaEBpLj3YxJ8-np1hSAcg@mail.gmail.com>
References: <20250215021654.1786679-1-keithp@keithp.com>
 <20250218212103.2024039-1-keithp@keithp.com>
 <20250218212103.2024039-5-keithp@keithp.com>
 <CAFEAcA_5tnaXvGXXp17=LKNkr6+BWcaEBpLj3YxJ8-np1hSAcg@mail.gmail.com>
Date: Sat, 31 May 2025 17:35:13 -0700
Message-ID: <87r004cn9a.fsf@keithp.com>
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
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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


> Ths code does what it intends to, and I'm not saying we should
> definitely *not* have it. I do think it's worth considering whether
> we need it, given that you can already load an ELF image via the
> generic loader (-device loader).

Also sorry for not getting back to this; we've been busy with other
Zephyr toolchain adventures. Of course, I've lost a lot of state related
to this, but to the best of my memory, I added this change while I was
trying to get the reset logic sorted out; using -kernel made that
easier, but this patch is no longer necessary. So let's drop this one.

=2D-=20
=2Dkeith

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEw4O3eCVWE9/bQJ2R2yIaaQAAABEFAmg7oEEACgkQ2yIaaQAA
ABE/YQ/5Aa+UXzcIao/df1ySHtghKjxlK0EARn1InzEVBHCCVXAObtweLVhg1kXS
IYwFBqr38mEuZKhUDnwvIhAD8svPJWLPkpPgCA30xmWsVHGItJj/FBfhnKCxbceg
Aa/c9vecpd7VkzdMligvoMwxGlhHkdn0sFZDvRxv5+TlIf03cKlnelwtJQ6tckPP
GVEfbzwPuKGFQ94dnkv9yzkDUwfdbGymM4jJokE1U6tc37Kwfw1fSZoAuJ3eHdOP
MBtNzsSyZZOsii3RqxBaQPiqmfgXwXkikzNlPx6ZV8kAeNH1DwxSRNbk0BIUIG8Z
f3KKEG5LQO61yV6IfdX03eR2xB5dhdQtXIPdr5uMbe/g+FOsKWoQiKUXNkqkc2Ry
4jVPNQH5po9/RaLAk2nAhQw13FZkYBon0/AURQ1ZaJsAHHW0u6FCIylT368BZvv4
GaY0m1qoqe6ulhS4wPS9xDSAgqD7CMfDrItqWGTpxcDWMT6lsNg/AiD+XdMDp8jI
7R1B0sp8ljyc4a5I3QclWnmHX3OdAPKPu2mFtgf8we4YR9iVgxQu4PrCEVCDevxm
f7s0Z6ANbTpKV82BgBal3LKAz1QUCsTP4dfPRWCXXZulGIazsGv37CDZvYuLDpy0
9nGESugJY326zGe3/MQkaMm0/bG4VqNCN8Z+GdnIITeVI17EbvY=
=ZFzY
-----END PGP SIGNATURE-----
--=-=-=--

