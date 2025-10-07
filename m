Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2FEFCCA476
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Oct 2025 07:43:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v62Lx-0006eL-W9; Tue, 07 Oct 2025 03:43:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1v62Lx-0006dy-6k
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 03:43:21 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1v62Lv-0006fU-7m
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 03:43:20 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-62f24b7be4fso10741343a12.0
 for <qemu-devel@nongnu.org>; Tue, 07 Oct 2025 00:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=adacore.com; s=google; t=1759822997; x=1760427797; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Hi2+vqVRE+fas/Ib6/fubveYjHYqVt/mgNpODWXzoYc=;
 b=XRqiFzFRoOVX6XpLKKCypgH0uqSHN2fbyBpn7nG3GPE43tWZTap8q9ct9MdM8vBwas
 W/c7b4gfgATKXA5Go0fsbDodle+j1OlEpeyuGGafX7/vfUIsb+0xPwsHLULuoI+jHVfi
 JaJRzaZ0XTjOzGij2/QeROvgUVmmRCiVAZAcF3wdlVk76C8hnbrvLLHgxIyoHpCrMZom
 9fHY3zH9MhF/5k+UhH93uEB5j2dTbJEgjo66y3S43MfT6E7t+gY0dM06QI1pqxy0k+/9
 dEE7w5+4c/TIGV/KmjdNxqZExOeMQXPl2weZkF/cvbpksZgV0EaWG8k1rICEEKC1rS8k
 UhfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759822997; x=1760427797;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Hi2+vqVRE+fas/Ib6/fubveYjHYqVt/mgNpODWXzoYc=;
 b=v7f93MEeYBJ+9CBquUgE2skTwwgQUcijugelb5PuwVpCWPEzyfB5k+QhjXTNbA+sOU
 P4NAg3NTeaPce9I/vFjEoCRvXG+pAcTS+y774DneFADhDM9pEbyuOvyHDartYfxNQ6HZ
 idCsOhWvFSl6S4WhO9QJZufOap89W3Pkx4xGPD3XRg8DgDyzPqEHxkN/ACmi1KTeaDQH
 j9webF/yS7SbMaZlVqg63GqRvEQc/PVuvt1+PDGIEULXbmIQfoswEpypofqwmNGujZXn
 BKKUnr1UhQ8HQWeCXLKb9aW3uu09pZaHhxsqDb8mPZ2onL4Zu6uG6INy16v0CFJ4Wnun
 LN2g==
X-Gm-Message-State: AOJu0YyMtQY6i/0WgEv1C//FfkMtL+e3XkxPA1iGB6OqevprLvYzm+w8
 uGaPf5CvkIWNBMET7vLIaIa9mbm4/tfmAeXw4KhMVh8kUQhxA+y3lFG93D0tAPrnf2FSYd09vb/
 LfUeoCpXqjqmqmiwt/QwMKIMXSgdtk5aB7gYP7TMJpxeu7iBbvgIO6g==
X-Gm-Gg: ASbGncv/TyJReaywaeWDyrDnj5ji+1xp8HBFRp4UJYxgLDaW93DDAMCwBpTu2SlXGiC
 IvdxS7kW+rUXzC2BSoifarTtJb3vUv9tpR0rkhRpJvjJZFtZIYkWpiY7tOptPNZ8jP02dlKdcDz
 oOh8zfqvNx+nFdV9Dg0j2S0xdWYuMTA6Q7lY/FMG16t9jm/EK2tUjlni1eUJLUZxUcrRbDE2+nk
 jXvUn2XLs5CTN2PrD9UhgqH2IfJLUaWT5SuYn7rkg==
X-Google-Smtp-Source: AGHT+IHcrS2SNeoodeVY/JoRFgr5GJopciR2XxRuFsWQyrQeDcNHG/pqpXCoYGwbI0bE3+R5uPtemg9IquU/7H6SHvQ=
X-Received: by 2002:a05:6402:2110:b0:636:66f8:77f6 with SMTP id
 4fb4d7f45d1cf-639348cb71emr15821792a12.5.1759822996592; Tue, 07 Oct 2025
 00:43:16 -0700 (PDT)
MIME-Version: 1.0
References: <20250903075721.77623-1-chigot@adacore.com>
In-Reply-To: <20250903075721.77623-1-chigot@adacore.com>
From: =?UTF-8?Q?Cl=C3=A9ment_Chigot?= <chigot@adacore.com>
Date: Tue, 7 Oct 2025 09:43:05 +0200
X-Gm-Features: AS18NWAuGQ1z_57zbiqkVav3OdMubM9Y1F6fmtOgRMULYsU5g7pBLeRKiKGBL8k
Message-ID: <CAJ307EgN_3MUsnQfCsS9C3ioKUNQSDM5hjXzUYxbn1ewLRv-6w@mail.gmail.com>
Subject: Re: [PATCH 0/5] block/vvfat: introduce "size" option
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, qemu-block@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=chigot@adacore.com; helo=mail-ed1-x52a.google.com
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

On Wed, Sep 3, 2025 at 9:57=E2=80=AFAM Cl=C3=A9ment Chigot <chigot@adacore.=
com> wrote:
>
> The main goal of this series is to introduce a new option "size" within
> the vvfat backend (patch 5). It allows more control over SD cards' size.
> The value for "Number of Heads" and "Sectors per track" are based on SD
> specifications Part 2.
>
> This series also includes minor patches:
>  - patch 1 introduces another option to remove the Master Boot Record
>    (this is mandatory for QNX)
>  - patch 2-4 are minor improvements easing the introducing of "size"
>    option
>
> This was tested on with a aarch64-linux kernel taken from
> functional/aarch64/test-virt and on aarch64-qnx over raspi4b with a
> workaround, not included here (the SD bus must be associated to the EMMC2
> port instead of through GPIOs).

Gentle ping for this series.

TIA
Cl=C3=A9ment

> Cl=C3=A9ment Chigot (5):
>   vvfat: introduce no-mbr option
>   vvfat: move fat_type check prior to size setup
>   vvfat: add a define for SECTOR_SIZE
>   vvfat: move size parameters within driver structure
>   vvfat: add support for "size" options
>
>  block/vvfat.c | 279 ++++++++++++++++++++++++++++++++++++++------------
>  1 file changed, 213 insertions(+), 66 deletions(-)
>
> --
> 2.34.1
>

