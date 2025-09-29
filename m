Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51808CAC5B9
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 16:51:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3H5S-000186-ES; Mon, 29 Sep 2025 12:50:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <trini@konsulko.com>)
 id 1v3H5Q-00017b-I3
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 12:50:52 -0400
Received: from mail-oa1-x33.google.com ([2001:4860:4864:20::33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <trini@konsulko.com>)
 id 1v3H5N-0002HK-66
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 12:50:52 -0400
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-3799fc8ada6so996844fac.1
 for <qemu-devel@nongnu.org>; Mon, 29 Sep 2025 09:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1759164645; x=1759769445; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=xVITTbuBxeGx6OIdbQWQyCg9woLTv2+YWViT0NWrw9U=;
 b=EpcCXJruMbq+eiA24ltPcuyOH3pHFpcGqgCGTLv20ViFC+gmMXZV15u4QX0UJApSTP
 XHUarqv+MM3srhD8JW5eTVZ7zW4vmJr1gHG6O5PD36b8WFE2GCWplax01HMyq/zIZV+P
 FSCAzCVmm+urzUnUNGWd+GcAT6a1fRx9/0twY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759164645; x=1759769445;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xVITTbuBxeGx6OIdbQWQyCg9woLTv2+YWViT0NWrw9U=;
 b=LxQQbaqa8QJQNhOQQfV7HJremP5sYETuSCusMWWQ5OVKYECJLnRq+fK0q+wq6m+ohB
 yAbT1qWdTI14WDKrvtv/TawuKREAhBJbUSBTa7pignUANHWIjvBCvwJiEQBGd6ZVTDOo
 MGUNm5D+iaFjvGYdjzb3gOBg2WArmYmVMzfDz4Mak1JgqS7NDgWs6imXYtoelo7ibPt9
 dp/j2QscLKIz1+t3ptDoR7FJHq3WrQ2tyMN2Yrrax/zPY0s1BZDznFVesUjzY4oHFuuv
 JWVIGclpDU4oc5C8QpQEefdMNdDAhUJYYaY/fMEuxcf05zPKDJa008zxzizF7CijjjgR
 nBrw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWDYZRvgXpYAtaih+YaFismjOTXXlrrvDJa9iaheCcwUgH93dCOx+H6q5C/ITwzU+4ToYSe/NHc8Cf5@nongnu.org
X-Gm-Message-State: AOJu0YwoT8Mq9VfNRuQqFnLe+78iihAJjgbH1ZyxmkfXcu2hH8NTgR+b
 WL41aOyzhCw0nc9Pm+A2BQ5kVrxhvEe7bVC9Z2e7XU6q7zKLA36UYjDlEtKAcn/WoMM=
X-Gm-Gg: ASbGncvtmZkc2ZIxp0skbY1tohN37VpFO7koqWnG0W3xWtQaPIPI2lKDF2enTQpilA+
 B/sGo7IVjd7CCEdOe2TQltOtPLzV+0c8d+Ewq1Fzih8P8CIMZXdbLre+caz+xMRyTynuKZq2M/2
 Fze3zrgrKk266a66F7EVEfKN/RL/D09hrYu/NDtP714RjzJpKp+Q2ble+BqN5FhMMs/KBa4MHXi
 UOYmERTjsmxIMST8r6OIX9e4wvfZRk+sYyhLUS1lQdPB/l7DJOnDl/jTnfbPyEI4DEr90V3nWSX
 FAiLxqkPl/1NgaGZ1plXf7eLcl+Nw5k8+/y0l7MEuvrSB3gL4OtbvVjlekpxsi97qNU8WWyx1kD
 Uqa9mrbEzxz364qDlwjCysT0sGK+f/7B+P+NX43tVB7L6rimyy4jX4vf+qAh3NQlbOuo=
X-Google-Smtp-Source: AGHT+IGnTawSTgw3BfyUZ/2B9SWpn0rEQp/X7xGSPUnfAlxtHgopSm9TGFZP3PIYbWLmNtLSU3c52Q==
X-Received: by 2002:a05:6871:691:b0:376:bfb7:18a with SMTP id
 586e51a60fabf-376bfb704femr4711405fac.12.1759164645643; 
 Mon, 29 Sep 2025 09:50:45 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-363a15c108csm3722237fac.6.2025.09.29.09.50.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Sep 2025 09:50:45 -0700 (PDT)
Date: Mon, 29 Sep 2025 10:50:42 -0600
From: Tom Rini <trini@konsulko.com>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: u-boot@lists.denx.de, qemu-devel@nongnu.org
Subject: Re: [RFC PATCH] link principle license to COPYING
Message-ID: <20250929165042.GJ6093@bill-the-cat>
References: <20250929155142.1647606-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="YqbDlfIF4tdO4Ff2"
Content-Disposition: inline
In-Reply-To: <20250929155142.1647606-1-alex.bennee@linaro.org>
X-Clacks-Overhead: GNU Terry Pratchett
Received-SPF: pass client-ip=2001:4860:4864:20::33;
 envelope-from=trini@konsulko.com; helo=mail-oa1-x33.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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


--YqbDlfIF4tdO4Ff2
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 29, 2025 at 04:51:42PM +0100, Alex Benn=E9e wrote:

> Some license scanners are particularly dumb and when combined with
> automatic license scanning for FLOSS accreditation on forges cause
> problems on renewal. As GPL 2.0 applies to the core code link the main
> licence text to COPYING to keep everything happy.
>=20
> This caused issues for the QEMU project recently as we mirror (two!)
> copies of u-boot in our project.
>=20
> Signed-off-by: Alex Benn=E9e <alex.bennee@linaro.org>

Since Daniel Berrang=E9 posted a similar patch 3 days ago, I assume the
gitlab license renewal is coming up quickly.

In principal, I'm fine with this and will apply a patch shortly.

In practice, we've always had to get a human involved at Gitlab to get
our license renewed as we're clearly within the required terms, it's
just that we've also got some further reading people should do.

--=20
Tom

--YqbDlfIF4tdO4Ff2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaNq43wAKCRAr4qD1Cr/k
Cu55AQCHmOMrjFDOG0RcfUGNutZVV+3+e4LXNu/lm/0P5J5R7AEAmG7+T2HefuPo
83fOeiF+BgJr6K15atQpptf267RUGQE=
=YlHs
-----END PGP SIGNATURE-----

--YqbDlfIF4tdO4Ff2--

