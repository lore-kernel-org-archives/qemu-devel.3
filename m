Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8623BC624DE
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 08:17:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2P6a-0005Pt-Tm; Fri, 04 Sep 2026 04:17:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1x2P6Z-0005Pc-JZ
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 04:16:59 -0400
Received: from mail-yw1-x112d.google.com ([2607:f8b0:4864:20::112d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1x2P6Y-0000y2-5N
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 04:16:59 -0400
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-867a943b149so13431387b3.1
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 01:16:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788509817; cv=none;
 d=google.com; s=arc-20260327;
 b=jWQ/ARJBQwm3puNic2ErT5gY+hNzSk8NRgs2yK6EfJ4lPg7Jv6M0vlesNYMA7EbLgo
 fGoxZeq91O+gR7Z80rohnGFgzgCLtb5ZXee3D5r0qCeDSk5z0uBMaH3/y/IHFabAO2FC
 VIqXNr2XSd/YIIlqUbNgPXQDywVFO9aEZEYujtz2QQtjxOdXcZMgrkA98IbK96VoaR2a
 6VYemzQfwf1EC/bfxoKucAVpgbaiHt0iX5iaWqXi84Scryl44gi0g8E+TXRNOuWWatqk
 2RaC5AVtrYVNF3mCXIh6Xh+HPO2GRMQRxWBQ0Qh4lZfOOeb/1c7JQerfqxrWEf+9XH1q
 VNhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=gDPorsHeR8rwd1cihZpzORhaWPZhCy76UXygT/KQXMc=;
 fh=ZF7jCY669HysMP18HcFkfmHdyUOvKtASQdJ99ECflHs=;
 b=PyxsQ06V7UETWj4PZAdrNUvpD+lZjhBFwGHS0kVbUZJvNB9k5s2vzK5EdsBHZk6IQP
 6QstYmihAxBCcMxjlV5zD76LtLXYCbsPhgsR4SV0FZcAxsZsTjYRuadGiX2b1P/BX7io
 xYwAGERtcVjYx8RzwB/PPW0UCDkTbfbnLyzCkBH5/S/UYMxUGbdSgq2qAa8Po8S5hYBZ
 yiCftHyk/Dj763p2O9vKgdruan8UpmeswOT691n8COS+siD8/EOKbqtpyhVnYBJ+DuQB
 y3xZ4LO+lMGjaJBCGiKudAViJVyZc7FSAtP39lcZWtk1uSFakjU5nbStNsWPBjBQa+9q
 Hh6A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788509817; x=1789114617; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=gDPorsHeR8rwd1cihZpzORhaWPZhCy76UXygT/KQXMc=;
 b=ABjER+Heab9BbNELpxs+dAodAPAP25TyX7yCSrIgHuM/bJmMXN3Vev3IH/8lKO7kiX
 ruBjyuS218uQzk7y5/uNS72PcsYFgHEMBHzI9QG+BUmIiIZTV7Pf0d7z3I1yGNqAM3u0
 LGR5J7mVEsZX7D6GsGFtkbOurRhoIE9T0IwdX0fnGARYSHlHIx5/cstK1e6fsDU+fHeI
 wbI2Td3Cwv2uKtyL0ioSdxdVNwa3ymJXsUo8aIS05H+lHe/IS625mEoTisM3D8PnGI9W
 sElB98nXr8HnUQkDM2XVDYQIvcNe0dr+5tMZFuUWn6SHN36+xVrCy5bfkHIfQD4ZrGGt
 e+Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788509817; x=1789114617;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=gDPorsHeR8rwd1cihZpzORhaWPZhCy76UXygT/KQXMc=;
 b=Mw8IrjcqlLvHov+EOqnmY1lD6Pk1J1EBueRu1NvoeTmBc1Oj7jqgYES5kvza7dNCw9
 9Des683PUY7WhhmEovX62+G/wrxgg+mD2fS6dicddY1vcNpNOTr9QpXBHYK1Iysv4lNq
 MQ2czc66keG1JyubDwSEC+E3TlM5yxOg4zJzlitnXgoksQjgosIolfBZnC+4k3kr8AIp
 MypSzhunmqBK2s9n/bpIaVvK6CsX8Cnm+7QUnvTxLx5uwO+Xmi36PsdnyY6kLiAZyt3V
 TBzftwuxk72DFAS5NGAKbc/4yEdrkAqEByEGmXGmlTnx2nzAB18HvKiMOFkcfvMXbd2D
 U4Rg==
X-Gm-Message-State: AFuF++k+j9Ma4/58E7tDVT9kFTdQlPTypiH3oziVTtnE+yLdrysTVOfd
 Xo7aICi24mLiJ53lBNvdZNAQ/kzthWSYuwlxecofKvWmThMuf/3iUYz3vLC5h1mLo5pa0JtHy7m
 ryMtJ+iqgJmKx0ROHyHSKj4yavYhCg84=
X-Gm-Gg: AYBFou1cvL4yBdPCozNLh2bzLrRc44CSad1Bv/FBXRD6Nw4QrvL61ortifNmbtekkUg
 u/hsMppBh65NYhEE3wE1Z5/gVeTk5U1zfx0XtTnfkRoGgqaLcfiHuluiFovgrHdIlZKOzLgjNvN
 ZDc9ugsRP5iVjujsBRGZcQPEGT3C2xKbgGGdsnRrsDtg5gbjd1TC9yH+KEdiohxN23R2lJ/uV0S
 45ISwU8SiWCF4QlX/AKhxKZsywOVx+z7FZrtIIJRUMi4Hy0ihEW5Ry2oqLeJViV+iI1W8qiaM9M
 UBYyRbehxU55W5BWa7l/anBfmetfGqCFo9OIQahE3eSq
X-Received: by 2002:a05:690c:e18c:10b0:86e:8abd:702a with SMTP id
 00721157ae682-8712820ca33mr18839077b3.32.1788509816874; Fri, 04 Sep 2026
 01:16:56 -0700 (PDT)
MIME-Version: 1.0
References: <20260825084224.1827672-1-bin.meng@processmission.com>
In-Reply-To: <20260825084224.1827672-1-bin.meng@processmission.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Fri, 4 Sep 2026 16:16:44 +0800
X-Gm-Features: AcwNN1XiSJddNETTzkEQT6JpaW3cKF2BAyu3yXWlFnhs5mvZSsxHoGdWh3XDnds
Message-ID: <CAEUhbmU+BQ=MErMdF1t8BHp-Xzwc2PbFY6pN3wtAgYKbO7jdaQ@mail.gmail.com>
Subject: Re: [PATCH] hw/net: cadence: Honor subword lanes in the GEM registers
To: Bin Meng <bin.meng@processmission.com>
Cc: QEMU <qemu-devel@nongnu.org>, Alistair Francis <alistair@alistair23.me>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Jason Wang <jasowangio@gmail.com>, 
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112d;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yw1-x112d.google.com
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

On Tue, Aug 25, 2026 at 4:43=E2=80=AFPM Bin Meng <bin.meng@processmission.c=
om> wrote:
>
> The GEM MMIO callbacks ignored the low address bits and access size.
> Byte reads therefore always returned lane zero, causing guest driver
> that reads the station address byte by byte to turn four unique MAC
> addresses into the same value. Partial writes had the corresponding
> lane-selection problem.
>
> Extract the requested little-endian read lane and merge partial writes
> with the current register value. Preserve the existing read-clear,
> write-clear, and command side effects, including dynamic queue
> pointers.
>
> Fixes: e9f186e514a7 ("cadence_gem: initial version of device model")
> Signed-off-by: Bin Meng <bin.meng@processmission.com>
>
> ---
>
>  hw/net/cadence_gem.c | 94 ++++++++++++++++++++++++++++----------------
>  1 file changed, 60 insertions(+), 34 deletions(-)
>

Ping for review?

