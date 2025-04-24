Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4829AC369AB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 15:49:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7yoO-00026r-O6; Thu, 24 Apr 2025 11:48:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adamhet@scaleway.com>)
 id 1u7yoM-00026Y-Gc
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 11:48:26 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <adamhet@scaleway.com>)
 id 1u7yoH-0004LQ-Uz
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 11:48:23 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-39bf44be22fso911710f8f.0
 for <qemu-devel@nongnu.org>; Thu, 24 Apr 2025 08:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=scaleway.com; s=google; t=1745509698; x=1746114498; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=v8Cd8iVvld6DpTkySqnRsbA0b5Vaf4lyvBFloWtErSY=;
 b=imMZnyNSBNe8L1GmlmHnKIy6BxzuOYqMKaHLWJA8KXzWxM+2FDDYeyqPqBY4cwvDoc
 SdRKayhKvif6LyaFgZNVadEKw6dtHlb+SMg8JjNTII0GkX2weJtEKd33eotFDR/or/WZ
 iY9V/F1bjjBC8ioQD8UMH57Gtci/tBsUKruB9a8pYY5wb7XH3/YmYBUCxVxVadK1Ixie
 DBhXjV9r3g5tmKObwF1I6q3ArbEL5PYDWOnV2uds8KYilC2zugAQ+uLLNHbBx+n1O9KS
 4K2skGnsWYs1CHoL5XGwAMnvwN+kuLoF40y6UPnmr+W7Nw6juVqXcLRejkKLl2G5mGlO
 ZEeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745509698; x=1746114498;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v8Cd8iVvld6DpTkySqnRsbA0b5Vaf4lyvBFloWtErSY=;
 b=uKR12dKmim3mXNxde1KhuSb5Fcl3MLra1TrvjJGjigl7i0kYoXa7S6Vs5d8gTJ24D8
 imjNp8MAuzpKaZitbw4ookczjUxcEOFLidqJ9PPFQ4ugfFLNapOfy4wUhv4nHFk5g3RR
 dscrk35JlpvyUVqLjhYYIbTrEAeV6uowhupZuKufAh3Ugb9Jd0aVUI+flRgIpCHtK0iW
 snpw2qOn87WS2c866uAhlTVTgKjR7EPtR8IJHaGnb/NBGkava1LDVAITvhtnKnQGrVMu
 WNvr2bJaHmr5F05baX605Vp/mv6+OI56f8mCBIoirlohQLvmXQGZ3AaxlkHVG+3+ty5V
 WvlQ==
X-Gm-Message-State: AOJu0Yz0SWDALPTsnbxA2fSmnN1bR4veWJU1/GvclG9zqHREN7eZhnwa
 S5EgMA+UrbRMzScvqa+QH1EHZHFGiWOp9D+karJJe/tjsmj9znZ0jHYqKLyJnVE=
X-Gm-Gg: ASbGnctVqSXieIGPIaXYL47L5dFSbBX6fAv22KZro79T8vIVW47LApDx8dFch1jMwoI
 qeqGuwiwQ+ja2dd4NhDHQ4wFpQ2fjgU2ieJk5/Bsy8QVDogQhCUpY4RKA1tZP0c+/i99tBo1tg5
 Xt6NjG/Buhni98D0khfOsG3qUJJE6fDpBZJ1V4HKdBiYf7/TmXL5luyYHdneYlj1d2ubPzb8PrN
 00/ZrU+sKD5PorX8ZxJFQTqmtRNn7ZqTz7bDmgGBsqcA3D6FmBNi8ZsYaV6DQfqbUz8F/dLPa4X
 vaijtTuJ1npmgw0xcC9Y2LYuW0KrtmDMgxn31CwyH7eH6NJNEKsF2N/mtfizFhPK7eSTf61J1D7
 i
X-Google-Smtp-Source: AGHT+IGa4xfW3fctzPUums3gBwN5vIO9yrsfxuNPtMtgquUhQQJJdT/zTIxIHlmLxMeUsq/hlHrkxA==
X-Received: by 2002:a05:6000:420f:b0:391:231b:8e0d with SMTP id
 ffacd0b85a97d-3a06cfa777dmr2852751f8f.39.1745509698117; 
 Thu, 24 Apr 2025 08:48:18 -0700 (PDT)
Received: from localhost (710304585.box.freepro.com. [130.180.219.188])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a06d4a8120sm2555505f8f.16.2025.04.24.08.48.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Apr 2025 08:48:17 -0700 (PDT)
Date: Thu, 24 Apr 2025 17:48:17 +0200
From: Antoine Damhet <adamhet@scaleway.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH v2] virtio-net: Copy received packet to buffer
Message-ID: <6hrijekkhh53kyckihqv5sbkcfzqry43xt62imjq4j52jk6tqc@zmr4lquiq3k5>
References: <20250424-reapply-v2-1-d0ba763ac782@daynix.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="wfuuiupa7hbrwspt"
Content-Disposition: inline
In-Reply-To: <20250424-reapply-v2-1-d0ba763ac782@daynix.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=adamhet@scaleway.com; helo=mail-wr1-x434.google.com
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


--wfuuiupa7hbrwspt
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2] virtio-net: Copy received packet to buffer
MIME-Version: 1.0

On Thu, Apr 24, 2025 at 06:49:57PM +0900, Akihiko Odaki wrote:
> Commit e28fbd1c525d ("Revert "virtio-net: Copy received header to
> buffer"") reverted commit 7987d2be5a8b, which attempted to remove the
> need to patch the (const) input buffer.
>=20
> Achieve the original goal by copying the header or the entire packet to
> a writable buffer as necessary. Copy the virtio-net header when patching
> it. Copy the entire packet when filling the UDP checksum as required by
> net_checksum_calculate().
>=20
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
> Supersedes: <20250405-mtu-v1-1-08c5910fa6fd@daynix.com>
> ("[PATCH] virtio-net: Copy all for dhclient workaround")
>=20
> This reapplies commit 7987d2be5a8b ("virtio-net: Copy all for dhclient
> workaround"), which was reverted by commit e28fbd1c525d ("Revert
> "virtio-net: Copy received header to buffer""), with a fix in the
> superseded patch. It also renames identifiers according to the
> discussion with Antoine Damhet.
> ---
> Changes in v2:
> - Rewrote the message avoiding archeology as suggested by
>   Michael S. Tsirkin.
> - Link to v1: https://lore.kernel.org/qemu-devel/20250423-reapply-v1-1-6f=
4fc3027906@daynix.com
> ---
>  hw/net/virtio-net.c | 91 ++++++++++++++++++++++++++++-------------------=
------
>  1 file changed, 48 insertions(+), 43 deletions(-)

Reviewed-by: Antoine Damhet <adamhet@scaleway.com>
Tested-by: Antoine Damhet <adamhet@scaleway.com>

--=20
Antoine 'xdbob' Damhet
Engineer @scaleway

--wfuuiupa7hbrwspt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEArm1WbQx2GmOsfF83AmjLzzljz4FAmgKXTsACgkQ3AmjLzzl
jz5VHQf/a33VensWpmkOcphuhP5/9ACPeiNOFcy/+YeNAP50Ill62/MNRX5KTalc
hLeglZVOLMWX3eNd2IH1qKbacRT3S1HPS4BfRPfBD1BU5fTgwSaGATQmRydZC1dm
RKmG1Hy0kFRaNcQ5cZrGojmQkBbwvvXJZJ0wrZgWERD4iMQJ+docTHG/aCwp7n/3
8oqjtZAMXdr2iVSAcYR2mwW9+PTOGKGBjhbqE+nAeG4BGAqSsUw+crqbqf2ZSKha
ePzfssMSdyL+3x/zMxdzQPUF0D0qR4hCCE4qy5KOLwZ6cyDeC5tTWj55w5ao6Y4k
oeTGIMpsfEjHBhq+S2lNZgJUGu3X5w==
=+CN9
-----END PGP SIGNATURE-----

--wfuuiupa7hbrwspt--

