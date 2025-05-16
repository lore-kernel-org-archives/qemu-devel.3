Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FAA1C2D0CD
	for <qemu-devel@archiver.kernel.org>; Fri, 16 May 2025 00:19:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFinQ-0000Tw-1a; Thu, 15 May 2025 20:19:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1uFinM-0000Mx-OD; Thu, 15 May 2025 20:19:24 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1uFinL-0003mc-6u; Thu, 15 May 2025 20:19:24 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-22e09f57ed4so29290865ad.0; 
 Thu, 15 May 2025 17:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747354761; x=1747959561; darn=nongnu.org;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hcEpbrgKz+z5rCppmwWWiRSIveucPcoU54Tu0pkXkfs=;
 b=FaYk7zHgDBlVJpzgkSNk1wHl+cVXWQUrFuzInFI9q05QoO6OPhZDJcOqM7i9Ewnibz
 kI5XIff1kXOoDYaUhyEJ0L7r/lJjGg3nX4abl2ioJBf4ma9Ug6s1RrGKNZ4Vc4ixDhSN
 I8DzVzS5hr7ZvSsKWJQVQX4pPGY/e77laxHEfnGgz969LbgqKi0CuT14r4Crrx8IKIS2
 OrNPPbNUyaGxvaPVKeaB0FIO7/Pt0fgHs9BhS7ZzvJvZHTE+elVwTipGIPzHfr/l2CMJ
 gDN3R2PfcLIv2NNDLxrMDTEpUS7XispWG3nvaa3xcFHnDCSe/qUgYzAImcuFx8brd/UV
 niNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747354761; x=1747959561;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=hcEpbrgKz+z5rCppmwWWiRSIveucPcoU54Tu0pkXkfs=;
 b=uxBBwgqYLvgbCKd++esRqzIVXcYVXAqLF4qIZJ2c2daPCmJUm2A7sJ8k6R09Zgw+gA
 18Hfx1XbAPz+NwnX5+gLdSOPOHNWq2eB9Uh/SzgK+a6S1ji0ACt5Q+rJDCZ0ycjrZosi
 2pqFojTsew3SxDe8tz8Sm3u++30I3oBo+MxDVgHqvAmEgPopdyGMJjxeNx2/V5FdSRxm
 5w1/R5QTllnvAJp6FVAD/o6vHPfUn1wVgYiBXRE36fzD2ZqtV4DD24PFWySNxCfWoXvm
 3U2q1UcunCaOZcQm4QPO69e/S0jaSwAEKxY/aCuu/WtbM/1uWnk5SxEexUTedsk8cu1W
 OsbQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVeC9RbmHf2CpWv/t2HzqHMYyFl0UQZaGZJVGo2pChQj9KY2YehSoSde/3z0YLNUUljhftJ4kfv8A==@nongnu.org
X-Gm-Message-State: AOJu0YwvuWMfflbjIOa8Zq35Q2jDQO74vB0/dyAsPfWm1Z2Ee0jZlazR
 qh5KjCYbcnXJOUhqp5H5cNMh9GGuYgU5xpV4RVhHjmHb5TOzkUq8P7QC
X-Gm-Gg: ASbGncvMhVhSduKp0jXHZpu6diYTla0mhaPB1xzyud7KO/Wlv+EUHOMnzEBz8UauBxh
 xCeDQuOU4bhXY6lGI+2RlqDE/4PzQFSCH3flHzghJohWM4YxqeHdBRxXUmMGuknQ+510qiKEyQg
 6VI9sygDhf4xxzdyRPZBVh7sDe/NO1FQBVsl1Yv1mOX5goNvprJ7dxRCmdTWMMmi0Sk8OvpKWtl
 xGMOXOmowyEi9pv6vtGEHy1TD2JfIDvmtK0vRNgRQiemzMq/cZTIlFT1fu7WIwgn2hkqbejjHKj
 rZU6/TfBX7e+IBTOve7MRoDh7pjxV2CjAIIddAoLTBqUVm8=
X-Google-Smtp-Source: AGHT+IEDoeHACMBvKtu/5ZlfN5JNEcKFwMZ3gnI2w3lroLOOfFdsmk4HqHSHfQ4/irWR2iX0leKXBg==
X-Received: by 2002:a17:903:194f:b0:22e:4b74:5f5f with SMTP id
 d9443c01a7336-231b39acf72mr64180585ad.17.1747354761316; 
 Thu, 15 May 2025 17:19:21 -0700 (PDT)
Received: from localhost ([118.209.229.237]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-231d4adbfd6sm3585475ad.67.2025.05.15.17.19.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 May 2025 17:19:20 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 16 May 2025 10:19:15 +1000
Message-Id: <D9X5KD69WQTN.2MNE92SJKUJOZ@gmail.com>
Subject: Re: [PATCH 24/50] ppc/xive2: Improve pool regs variable name
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Nicholas Piggin" <npiggin@gmail.com>, <qemu-ppc@nongnu.org>
Cc: <qemu-devel@nongnu.org>, =?utf-8?q?Fr=C3=A9d=C3=A9ric_Barrat?=
 <fbarrat@linux.ibm.com>, "Glenn Miles" <milesg@linux.ibm.com>, "Michael
 Kowal" <kowal@linux.ibm.com>, "Caleb Schlossin" <calebs@linux.vnet.ibm.com>
X-Mailer: aerc 0.19.0
References: <20250512031100.439842-1-npiggin@gmail.com>
 <20250512031100.439842-25-npiggin@gmail.com>
In-Reply-To: <20250512031100.439842-25-npiggin@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x633.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Mon May 12, 2025 at 1:10 PM AEST, Nicholas Piggin wrote:
> From: Glenn Miles <milesg@linux.ibm.com>
>
> Change pregs to pool_regs, for clarity.
>

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

> [npiggin: split from larger patch]
> Signed-off-by: Glenn Miles <milesg@linux.ibm.com>
> ---
>  hw/intc/xive2.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
>
> diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
> index 968b698677..ec4b9320b4 100644
> --- a/hw/intc/xive2.c
> +++ b/hw/intc/xive2.c
> @@ -1044,13 +1044,12 @@ again:
> =20
>      /* PHYS updates also depend on POOL values */
>      if (ring =3D=3D TM_QW3_HV_PHYS) {
> -        uint8_t *pregs =3D &tctx->regs[TM_QW2_HV_POOL];
> +        uint8_t *pool_regs =3D &tctx->regs[TM_QW2_HV_POOL];
> =20
>          /* POOL values only matter if POOL ctx is valid */
> -        if (pregs[TM_WORD2] & 0x80) {
> -
> -            uint8_t pool_pipr =3D xive_ipb_to_pipr(pregs[TM_IPB]);
> -            uint8_t pool_lsmfb =3D pregs[TM_LSMFB];
> +        if (pool_regs[TM_WORD2] & 0x80) {
> +            uint8_t pool_pipr =3D xive_ipb_to_pipr(pool_regs[TM_IPB]);
> +            uint8_t pool_lsmfb =3D pool_regs[TM_LSMFB];
> =20
>              /*
>               * Determine highest priority interrupt and
> @@ -1064,7 +1063,7 @@ again:
>              }
> =20
>              /* Values needed for group priority calculation */
> -            if (pregs[TM_LGS] && (pool_lsmfb < lsmfb_min)) {
> +            if (pool_regs[TM_LGS] && (pool_lsmfb < lsmfb_min)) {
>                  group_enabled =3D true;
>                  lsmfb_min =3D pool_lsmfb;
>                  if (lsmfb_min < pipr_min) {


