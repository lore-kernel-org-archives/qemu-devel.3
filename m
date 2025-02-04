Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 306D1C02194
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 13:52:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfJM9-0001rm-OY; Tue, 04 Feb 2025 08:52:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tfJM5-0001ow-Af
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 08:52:45 -0500
Received: from mail-yb1-xb2e.google.com ([2607:f8b0:4864:20::b2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tfJM3-0005RW-NF
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 08:52:45 -0500
Received: by mail-yb1-xb2e.google.com with SMTP id
 3f1490d57ef6-e455bf1f4d3so5140485276.2
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2025 05:52:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738677162; x=1739281962; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AEt9zpjV/6Hv9xyAVx5tPHw0X+ZSVILNpYvtBnw7BQs=;
 b=oqFHRNkjowLrlg8beNuLwANcl3JUIwPWjLrYRrp+1Vv+IUqledIa/OBD4gnEKm4bLO
 ZgD8MNjfGOgA0On06Wq9rSVUGbN5S/i7igt4MtG9GfO/oJjftQcesa7TYu/ZZRMhulsn
 NTwDmzvZBDCHKJGQlbwvHEkx3bYsqBdghbvJHlVUKi6vVfrnGgdO0TmFpSIm3tP2n/m2
 rX/D5zReRmYxhd95hBu0EMpl1vBv+ZiBztkGO2L/6wqPFNO5cZdxHTl5kPx4yi0IOnVt
 1g6re37d8fE8C/sD7a9ZDOthUhAIAYDVDD1giofj9epqhT9ejSzz8VEEzNjb/MjnSkR7
 aX/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738677162; x=1739281962;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AEt9zpjV/6Hv9xyAVx5tPHw0X+ZSVILNpYvtBnw7BQs=;
 b=L9CjvByq78Z2xh/P5LN/tI7nv3ojyI/omB7tXK7qfo1QlONvSYQMjpOUnfxranPCPJ
 IMw5icLW4SHUpKH45uD93qPTnG+oA8iaTyEMda2vis/QxJA2gZyrr7WxmH22KD8JOzUc
 d8YUn4n6OxtHhSgLCdFinXreOPH+SAWvsLNiZA38X8PCFWJtxJxm8zpZpoXHVFvRRAFV
 eZ3t9bqyxWdn4Z7hxPqS9BGDUY9yvyqx0kFTy/xtAKqbhzm2+PESkmbSUXrcBzJbx6mE
 aLQFiFH0Bzz1UCs/vEl8E499k+DTgwQdiBpiRCOHGepoN6wF0wMTWNaVPnLAnEr9gJFO
 UblQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU0OH2cO/5/Ci2fG+mE/vM6DbhsBuNvlJ4NHCo3Jvx1M94RcIN7riD7Rp4vqdTVkkuR4ZULBTXSZ4Xa@nongnu.org
X-Gm-Message-State: AOJu0Yx1utfaWqndRqTQcy87OWlCC8c5ASbpMvbiiCiqJ01twipBJh75
 bUlTz+A18wD58F/B7fEHeBJcZE9GBlohQx9S1XyzXXHiy1b7WAL58JQo2iwWHnmGWnnKGnr4Tw3
 VByRIMQBQYOuCfhsSvguiU+yxXGMKGuUwYVxl6w==
X-Gm-Gg: ASbGnctmfnNQ3TQRz74AyZzVAnKULLnKC4IIx+Km6cd4DuF69Xe9Yf8dmOkEygwofmL
 IAtkPY8dNJbTi3BePS6v065t2MhL7sFneO5LZeXHTDCodBiJMg2c9fDZ4viMUQvlrqkP5ZNzTmQ
 ==
X-Google-Smtp-Source: AGHT+IHQXPYJSIMuCmFGo7dQDddUknGPE21E1gfS0v88FTV3Fov4MWB07GEI8UjqwiRW0KOX1aXVeSNLQVrHLMRhugU=
X-Received: by 2002:a05:6902:144c:b0:e57:4b14:6fdb with SMTP id
 3f1490d57ef6-e58a4baaa4fmr19228443276.34.1738677162289; Tue, 04 Feb 2025
 05:52:42 -0800 (PST)
MIME-Version: 1.0
References: <20250204002240.97830-1-philmd@linaro.org>
 <20250204002240.97830-12-philmd@linaro.org>
 <CAFEAcA-3JJ1tZAXsik5hAonuSO9sCqDF1xqPQVhAeN-XwAAhDw@mail.gmail.com>
 <e32a54f2-ef46-4964-89d4-a8969b6d1b05@linaro.org>
 <Z6HklNsu0Mzgh7bC@redhat.com>
 <CAFEAcA9m8g=K-0RU31kswbNSKWnUqA78KxNkcXEAqR=BhWc9bA@mail.gmail.com>
 <8616891b-9747-4388-99dc-d6e53e090001@linaro.org>
In-Reply-To: <8616891b-9747-4388-99dc-d6e53e090001@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 4 Feb 2025 13:52:30 +0000
X-Gm-Features: AWEUYZn_3CWAUkZUH3JDPbb5GNmT6y-tdyOl6D97qpiklq3Pf2FHRLFyCyi0i6s
Message-ID: <CAFEAcA9weFzHW+kL8W0GD26A+QTWpC7Baf9-=Oc3t2yw77=RCA@mail.gmail.com>
Subject: Re: [PATCH v2 11/12] hw/arm/raspi: Deprecate old raspiX machine names
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 qemu-devel@nongnu.org, BALATON Zoltan <balaton@eik.bme.hu>, 
 Laurent Vivier <lvivier@redhat.com>,
 Ovchinnikov Vitalii <vitalii.ovchinnikov@auriga.com>, 
 Jared Mauch <jared+home@puck.nether.net>, Fabiano Rosas <farosas@suse.de>, 
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 devel@lists.libvirt.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2e.google.com
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

On Tue, 4 Feb 2025 at 13:40, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org=
> wrote:
>
> On 4/2/25 12:13, Peter Maydell wrote:
> > On Tue, 4 Feb 2025 at 09:57, Daniel P. Berrang=C3=A9 <berrange@redhat.c=
om> wrote:
> >> IMHO we can have distinct machines for each model, but
> >> *NOT* have further machines for each RAM size within a
> >> model.
> >
> > Yes, this was what I was intending to suggest. Apologies
> > if I was confusing with what I said the previous time round.
>
> OK, let's see if we understand each other correctly as developer,
> before explaining to users, taking the 4B model as example.
>
> The 4B come in 4 physical variants, depending on the amount of
> DRAM: 1G, 2G, 4G and 8G.
>
> We can not allocate 2G on 32-bit hosts, so to have a reproducible
> guest behavior on 32/64-bit hosts, it makes sense to takes the
> model with 1G of DRAM as default for the 'raspi4b' machine.

At the moment we create the 1GB version on 32-bit hosts and
the 2GB version on 64-bit hosts. I dunno that that's ideal,
but I think it's probably best not to change that at this point.

> If an user specify -m 2G ... 8G, we can adapt the 'board_rev'
> register to expose the corresponding amount of ram. Now, how /
> where to tell the users 1/ the default is 1G, and 2/ they can use
> 2/4/8G?

In the documentation: docs/system/arm/raspi.rst .

-- PMM

