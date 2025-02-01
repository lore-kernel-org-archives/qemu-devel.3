Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B74EC02194
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2025 13:52:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1teDuL-0001Mv-P7; Sat, 01 Feb 2025 08:51:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1teDuK-0001ME-5N
 for qemu-devel@nongnu.org; Sat, 01 Feb 2025 08:51:36 -0500
Received: from mail-yb1-xb30.google.com ([2607:f8b0:4864:20::b30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1teDuI-0004KW-OI
 for qemu-devel@nongnu.org; Sat, 01 Feb 2025 08:51:35 -0500
Received: by mail-yb1-xb30.google.com with SMTP id
 3f1490d57ef6-e545c1e8a15so3000717276.1
 for <qemu-devel@nongnu.org>; Sat, 01 Feb 2025 05:51:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738417893; x=1739022693; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4i+PvaK5XV2ufIOu1FAplCz/JMuNjmtNoAHIltZ7WPw=;
 b=GrcTA0nWxcgfCVyY9VLDKd6mvXK5wf1UlYRAmc9HODW4KbxuZL0YYjcKbpgivhqd3/
 RuhxLZt0Y5wF0bTxkMVN3ua8LN04DXCEjprte5nHcSeMXsyKRMDIi3xzYVEFaFJ3qUFi
 5wQTSQ8LcYrwxGrUVRSsFMaKKpQzhlM6JrL+so5reiTYuoSAdkFbdBygN7fT6rQbm2NQ
 hcQ54FtWcutE4OXi4PFcIKOJrre8MA+/LoYf23CVHLig2ScJSduGNzFf+sjLeuFRm9z9
 i3xR0am1zRDUPqpqQX+xA998ONF9KlMjYQFIGPkdt/lecMuZPpHJjEiLVyO+3FkkyGGc
 gevQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738417893; x=1739022693;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4i+PvaK5XV2ufIOu1FAplCz/JMuNjmtNoAHIltZ7WPw=;
 b=ekDKpcBUExkb4iGwY2W7k4fM26UlBTHtESMqI91SJm0TVKfviUi8MNbJ6fiq6G+3Hs
 YyNk1KU5l4fHvPjEzs8/12OtaSkk61zCV1qHdLqQMFOPG3/ccTllfpU0FBKkO1xW7+8g
 Zt4R3AUCibG5DbQ/qqryreONKchfZEazH6wMGJhf3qXdPpRkRnbrqdLrLSxjRMb1Yd8r
 x5gmWgsEK8B/ZkfOApwcdwUbX/CXN1WsUdwdLRL9Y58m3XEh6UQEBVzk9v4gOKSjb2Tt
 0A3yk9qqGDnBPofmzO7A73n5TXNAdH0FLyX7wnx3iHufrfx1E75OR2RWn+OcZYjubveF
 u0LQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUAawQwxgXdm84/upmNWp1fZD4AOU/dSWu1VtZf4exmbcJQ0phqfnkmp2hNZNcYxV6gChaXGyY5NKxE@nongnu.org
X-Gm-Message-State: AOJu0YxPhYY6wlgjEVRqofh2IJQW2Kxqzvd5raIvepfmqti83WYwTDge
 5c5Han8LZ36vZ/NEQiOauub/gD2Q56Z7gl4EBwks9wObdbn9u3KauAH5jIuzwd7M5UB3RDWnDAw
 Q9hoaV6PNHyjmLZzXkn45eMOZO69SLRIIyzHVTw==
X-Gm-Gg: ASbGncvHa8k1c6B6a67NO6S46qJBzTSfG2jfz3D0MPr1zEE8q9A/hVpTmO85qgkF4rC
 RCk/JbaYjLVitZsZi3cH54HkYLjVZB9ABor5trM3AnBRpiKaavyEoPqbSNJodKv9fdUoiSwtNNw
 ==
X-Google-Smtp-Source: AGHT+IHKZxudV7gohSODJaUkzrhqSeOmNEAlobEJqXzWqq67WQyxyAs3eIQ46BK0cmQIhMWjxAN8TL9uh+MDtaWVNVw=
X-Received: by 2002:a05:6902:2783:b0:e5a:e88e:b2d5 with SMTP id
 3f1490d57ef6-e5ae88eb501mr2274374276.9.1738417893051; Sat, 01 Feb 2025
 05:51:33 -0800 (PST)
MIME-Version: 1.0
References: <20250201091528.1177-1-philmd@linaro.org>
 <90d87f0e-56a3-8966-614c-364f3e726d61@eik.bme.hu>
In-Reply-To: <90d87f0e-56a3-8966-614c-364f3e726d61@eik.bme.hu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 1 Feb 2025 13:51:21 +0000
X-Gm-Features: AWEUYZnQ-7-wNeES8-b6WVpvSE5aD01NRDmR10nIvwaYjT8vzrteghAQ85mB9mU
Message-ID: <CAFEAcA_mBXO20NhYRHJCgkB0h8uYQQhBMdwVW376R4u-qh51nA@mail.gmail.com>
Subject: Re: [PATCH 0/7] hw/arm/raspi4b: Add models with 4GB and 8GB of DRAM
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org, Jared Mauch <jared+home@puck.nether.net>,
 qemu-arm@nongnu.org, devel@lists.libvirt.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b30;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb30.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Sat, 1 Feb 2025 at 12:57, BALATON Zoltan <balaton@eik.bme.hu> wrote:
>
> On Sat, 1 Feb 2025, Philippe Mathieu-Daud=C3=A9 wrote:
> > - Deprecate the 'raspi4b' machine name, renaming it as
> >  'raspi4b-1g' on 32-bit hosts, 'raspi4b-2g' otherwise.
> > - Add the 'raspi4b-4g' and 'raspi4b-8g' machines, with
> >  respectively 4GB and 8GB of DRAM.
>
> IMHO (meaning you can ignore it, just my opinion) if the only difference
> is the memory size -machine raspi4b -memory 4g would be better user
> experience than having a lot of different machines.

Yes, I think I agree. We have a way for users to specify
how much memory they want, and I think it makes more sense
to use that than to have lots of different machine types.

thanks
-- PMM

