Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32ED4C44520
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 12:17:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlmvn-000312-UK; Mon, 20 Jul 2026 08:17:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1wlmvl-00030K-Mg
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 08:17:09 -0400
Received: from mail-yw1-x112b.google.com ([2607:f8b0:4864:20::112b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1wlmvj-0007FO-4p
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 08:17:09 -0400
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-80a123ef90aso54255487b3.0
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 05:17:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784549825; cv=none;
 d=google.com; s=arc-20260327;
 b=l30LSV0B08KeczdV6DP++gP9sJWRttmi4DH7U7/d0cF/UdRqxNDfYCblRZMrgxEzVo
 MWpNYw6/7P16U0G06jTCu2LozpBruAoHBfW1JetAFrm8jvIBnRXzG6F+1IOOnGUIt/P8
 7kPirT9K4A2VQJvtiSXOIkQn1EcPQ/jr1hhJ2oohqby2QOVn+BBB5kf4Ee6IajCNz0aT
 oU5LfMkusIPA7uPumvj7D/mf4aJJ21IDDF23y827Uu5MxkF4f8ckxRyQbcnNjMQp9AhL
 HDiFDPELEMP3QOnb0Mt52kPbknpOtrtZrrD6aEaLkLd1dpMntVgRzUjTeMVL2ONe1wGz
 EY2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=2IOA3EQpMsgKf87q5t0PZzkh+8jH37WfsmXnXOsuRAw=;
 fh=MObVK6jyoheTNC93lvrqcrncRVan99RdZ2q9B0zA5tk=;
 b=OKKv4X1Pi0kccaeVsPPjA8wWrM8y45/6clFMq7RnAuMvE/Jz1StgDo6oouvnLFvWD3
 zbR/eLTjlxOMaglOCZty+1p3LfAN975Pvpbsd933Nkz+/iqBZcYXnfWD+1wnuwrXUbws
 usLodbVB+FszT0rP0Cw/4JKphfNGbrmN8xhkqfDUa+Uz8NhN4N0NDas+fXmYpUTDpTLW
 vvMwU+fEKSSYOTIcfFaZBUazJ3dHUt1rJc+KteSiVC8Lg0MTqdQdEGWz6H2Tmd/6G+qf
 W8DNWGEaa8aMmfqbr7372e2sGf2mS0C3Hwd2sT5eL69tbZgG5ukcGWRNtcd4DeKc6EGo
 nywQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784549825; x=1785154625; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=2IOA3EQpMsgKf87q5t0PZzkh+8jH37WfsmXnXOsuRAw=;
 b=Vr2b8bk1FjiYshZyV+/SMXaFmWJPoYaBX9uLdmohLtGJH0spAnDwTQH2mvuTDBkf2y
 SsN2YgFomfBd8Cr7iM3ELhx8WkQ35Ppd1Yd+wMTl+lgsZ9dLuAP6wdlPmINROHaUn+/d
 J4sLzUZyHZ/d6Zjd/xf1l9t8AGoxFWWxWk3lI259uQrHTarLv2K3evI81WUOtvebRUQw
 fuTEtEtDaYitwfzQGX2+5NClJfXkNqAAbEFa9CdcU5TcfrDwAC4ApUKcCKJHXuyqNpkl
 4sNwVFsbRm98OhaoF2ERuNQcGcajhEMRT/ciciJm15KozM0y15JDxVLXBKipFMOb/jUd
 uLvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784549825; x=1785154625;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2IOA3EQpMsgKf87q5t0PZzkh+8jH37WfsmXnXOsuRAw=;
 b=kMGGXRQ9KXEHMgrd7Y7KAjcHPggBb3Oq4sF5uBOl+W8qgvYIyGe/K5P3f2KzTtEC0M
 fcifxts3KEOnftThJfDnmI0Mi3Hu6aSFEMRi/13XeJ9Ulkvxcogenu50nvXXIQ4irMs0
 1kAVSouIh7eXHh4MICT8w4vS9JH/KslrR5Xsaupe5Wa55AIV8XCnYi6/rLuayxw7vsT5
 +RGYZkbGZnSL51zizDOwY6B9p+zTZEtTzbvJKyk3VBB/+pt4G69+izzZ//pjHiyknDsc
 nH1b5PKmVXCit64UkGrVsdjfJVwJWnQjlLTvw9l1zounXFvl4jAeA9uqQ2fOurYxqjoG
 9yBw==
X-Gm-Message-State: AOJu0Yx/l5JJuIXsArL7tZJsfsYQsDm3nVs82s4NXpvQv/UOT56DIw4a
 GXQ4dlB8Gq913oHjX4v7FgXK3CqeCBj2WBKnYZI4Ve5m1DX/AR+l30J0aV/JK00p7pQr9jd6V/5
 OEiHs4NoGx7pVnPegwF5zGs6wUuAQADM=
X-Gm-Gg: AR+sD112QslgRT1++5rmvPtasy2i4bjbXS6TOdOBVCpsJ5CKfDpVevs9TLm28Us8i5S
 fZTDp+biQiKwDUn9MNcdyoZ2gaXi3ochYJkyHSBeBBB7zpb6Mgv1m7t44vuIHpJclNZEnggwLeE
 YspvY18cc1QmvI/9NUlwc7VOCYziKMW+i0EpaJ35I2tbjMzIWyPX2l3HPM7oBlmLHS4R/sZAs6k
 zmuknCpPmO1R16fqRbS80htj5lvxC635MgqJJnU7+BUsN1o0KD+s2C0tqBpfEo=
X-Received: by 2002:a05:690c:e3e4:b0:81e:9be5:f7ac with SMTP id
 00721157ae682-81ee2924fc9mr80793957b3.11.1784549825495; Mon, 20 Jul 2026
 05:17:05 -0700 (PDT)
MIME-Version: 1.0
References: <20260719211923.1079282-1-shentey@gmail.com>
 <20260719211923.1079282-3-shentey@gmail.com>
In-Reply-To: <20260719211923.1079282-3-shentey@gmail.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Mon, 20 Jul 2026 20:16:54 +0800
X-Gm-Features: AUfX_mwwWCoHClsnd52569AAMVvYKh2d47Ypj2-umv4vhzdkBmD05qCywjkCaPg
Message-ID: <CAEUhbmWauqho1RQtovBcr6Ln8G+96mnauSpKZ_B4mP4NdNLFYA@mail.gmail.com>
Subject: Re: [PATCH 2/2] hw/sd/sdhci: Extract uSDHC-specific quirk
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>, 
 qemu-block@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112b;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yw1-x112b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Mon, Jul 20, 2026 at 5:19=E2=80=AFAM Bernhard Beschow <shentey@gmail.com=
> wrote:
>
> In Linux, the ESDHC_MIX_CTRL qirk is guarded by esdhc_is_usdhc() while

typo: quirk


> the eSDHC code path uses the standard SDHC interface. Extract the quirk
> into a new `usdhc_write()` function.
>
> Fixes file system corruption on emulated i.MX53 where Linux'
> esdhc_is_usdhc() returns false. The same likely happens on e500 and
> imx25-pdk machines.
>
> Fixes: 75e98bc4f859 ("hw/sd/sdhci: Add TYPE_FSL_ESDHC_BE")
> cc: qemu-stable
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>  hw/sd/sdhci.c | 73 +++++++++++++++++++++++++++++++--------------------
>  1 file changed, 44 insertions(+), 29 deletions(-)
>

Other than that,
Reviewed-by: Bin Meng <bin.meng@processmission.com>

