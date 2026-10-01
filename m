Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4565ECA5FC5
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 01:37:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xC5it-0003Iw-7l; Wed, 30 Sep 2026 21:36:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <asrinivasan@tenstorrent.com>)
 id 1xC5ik-0003IB-91
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 21:36:27 -0400
Received: from mail-yx2-x0e.google.com ([2607:f8b0:4864:41::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <asrinivasan@tenstorrent.com>)
 id 1xC5ii-0006XZ-EV
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 21:36:26 -0400
Received: by mail-yx2-x0e.google.com with SMTP id
 956f58d0204a3-672f4b7091dso3211192d50.0
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 18:36:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790818583; cv=none;
 d=google.com; s=arc-20260327;
 b=a4HDhlPmWAJz3F1pA74UMgzsGQgvNfUp1KAV234pCZ9/VQsv7NESF8DTExxdYiFzJ8
 6785ohVdWIzCswgHHMoMqwkzTQx4w6RmBt9BZpMhnF+/E6g2wIMw+EcI/Ugm3b8km2DV
 OPB4RVm4UvnYpKyGMfWrpUQ0h4RQx0BvPYTdBCdujiqY6z/dkjPP3r2oCaQw1qpC6O0m
 Nw+kzKyO+uBMeMnkYfiF69K/abqvQQb4SdiNgbC7j0ZzXlAIx2p+Jn32Xc5yyeOhzllf
 hvi4vdemd4J0BkJ4tmK3XuQVWFSMXdcyt9ksxmH5djfMFSpoe0KbMPThkHE5FNcIOh+V
 yU8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=c5+WRzKeSa4ILuYSJKrW5kATAypTCy+ubYGDv/Vfxd4=;
 fh=T7GZKU3pqGfZDaVHTkyCxWlgssTqcxXKF3+qSko7WPo=;
 b=A7D9sdV3ZhN1TG3jvg7TLM1yktu/VkyMnoj87a0zxEASB0knFG+fqvLkkbFUufdaSV
 s6b7FFebzG105L/nZuKh6Sy1KJylsyn1yynqsVey5D2rXpdLbSYInX1jJlzkUlJpJCbQ
 gBrOOWOXi8e/ZmwNSxuJf/OkfO2kFO+Y/2cHiZkp2njeZbOFpDn8VZMEZhEaWQPi0zx+
 fegNxG3wj/92K0W+LDiP5n0jDwKfePPJte3LjNlorO+2p0lpH5ulHDGgt83Qx5VGT+pg
 pPa74Od5Br4HYIulwhmB+gFYZCk1/mbrHyhb7/gQTqeppYPGHsZFmVEFsa7fGrHPLiOX
 TJeQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tenstorrent.com; s=google; t=1790818583; x=1791423383; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=c5+WRzKeSa4ILuYSJKrW5kATAypTCy+ubYGDv/Vfxd4=;
 b=D5fnh5f/0qCsxXXg4sH+0cwo7LgYw69cMXhSmiN1zwR7X250WfovNZWTy/e1Elt/G8
 QPOvXWHm2coAXjyzeoedHhwUirUyhz5D+s+7boaPP3XhgHy29bQJy3RLVEVY6CDmc3W4
 QDkZ8XF4nyRjsNid7MjLVkhbwbXv8nbf+rx+Gr/blT5BdZY5s/6SYd6DGwJvwJg4GhKb
 IcEJYhe3mYSLZhB28gDnEefm/KElc3c/fyFtqL/ttKQqxi9YtpL9W8WK0DSI8TXTiM/f
 AWE1qry3Z/2tciss8eeBO8PKIfLt1H9rvU44H234+hZwHU8jDvZUVULmuduPBrcjcbdI
 q3VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790818583; x=1791423383;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=c5+WRzKeSa4ILuYSJKrW5kATAypTCy+ubYGDv/Vfxd4=;
 b=T9OLcuOngVv6outAYCZ/gf1dLH9RlaUEesAGhshwxsHhSQHv3H6qG0iEfm33QERs1j
 G6qH9Lahv2NYqnWe3Q5BVYQo5f/bfJJGhkXrKPVpDPGQceeO7x6HLoDbh0HJrV2YR1U8
 HYBibqgQd7wSXcwL9E2DI4sva3HjmVJHSMG7b4oVVRvQ9R/B+qYbX0GutX+9QtQKo87X
 kowTrFJznzE9zhXX6gEnTfguNBHrCYEBanXfQd/dVqmkMlJQcD8AAKmXvPy1P1thPd5g
 GC3lP2idlhy8xkvp4gFSZIy9kYqrsAD9fJiNJOxIz2EaIwozP0lBHTrKUpuXs0WT5ieQ
 NDKQ==
X-Gm-Message-State: AFq9FYIZAvKw/su6vJatPEeGRxq1JQOkq8quFZd4mmRWeqmMkF/qQYUP
 OSfWRHkhMB1JuqSUnZQAxZOL0XAhHRPtSPgDO5Zg73OJPuBWx1Yp7OPWmc/U+wDsRlLka2FaNrN
 IBM5kin548mhHLFz0fl0P2mzhpOW8aZPsY9UlRJoxag==
X-Gm-Gg: AYBFou2qRGYMv7GrUnkL9rUIbBRK+FRyKpPxc5da7rCdE80jLJ5glDATzh8otHdPhGs
 Kizsl8eGLAbth8cNsr8RfUI27zMvuBIfutO4peW2Q8QCT5PqOYqnNJFG6haB+RXp0T3313olmAH
 kj8o/H6ni9l2/fWQp6mq+vtArIcOF1GUS55ROPLSDnBhWB09FZd4sazXjc1FzZH/HMWVTNGBqu4
 00ZHL8E5cGjWgccrFpNh0/PC+o5GCNXLs18AGkcCdOUFUHJgS9IEpKpo/9eJAi1ixx0RlKw0AAs
 dbAjAZGw30AS5l/CIKttujc5zYy0bZuiMi9MjdobOkSfSUi4QEuZfMzv6IA7fAFe4PryQYe+F6c
 3vjntfWv4RaIuzABAqFWeCjtNWnCZmp02vZLRKL/uhg==
X-Received: by 2002:a05:690e:450c:20b0:674:19d3:f974 with SMTP id
 956f58d0204a3-67690e1a2demr492579d50.14.1790818582590; Wed, 30 Sep 2026
 18:36:22 -0700 (PDT)
MIME-Version: 1.0
References: <20260904-atlantis_prcm-v3-0-8bf20795a381@oss.tenstorrent.com>
 <20260904-atlantis_prcm-v3-1-8bf20795a381@oss.tenstorrent.com>
 <CACPK8Xdfq5_tTqCfQfwi3tLimbG5YNO8_H39TY67TArPV1Ls1w@mail.gmail.com>
 <CAEev2e-m1JU6qFQ71xHLxGEo1ju4RTEHZG7zGOmB+EWZN3kQWg@mail.gmail.com>
In-Reply-To: <CAEev2e-m1JU6qFQ71xHLxGEo1ju4RTEHZG7zGOmB+EWZN3kQWg@mail.gmail.com>
From: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
Date: Wed, 30 Sep 2026 20:36:10 -0500
X-Gm-Features: AclHuK-pzfQSMN0nmmjnPGj5gSByYoCMolJXDUdHYel39IjgYbKs5utNwlAZDIA
Message-ID: <CAEev2e_DKv_bBHo6YFzMTG2QfRdPsnmhY3gfjUUUhghoSfeYng@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] hw/misc: Add Tenstorrent Atlantis PRCM model
To: Joel Stanley <joel@jms.id.au>
Cc: qemu-devel@nongnu.org, Nicholas Piggin <npiggin@gmail.com>, 
 Michael Ellerman <mpe@kernel.org>,
 Portia Stephens <portias@oss.tenstorrent.com>, qemu-riscv@nongnu.org, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu@processmission.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:41::e;
 envelope-from=asrinivasan@tenstorrent.com; helo=mail-yx2-x0e.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, Sep 30, 2026 at 1:41=E2=80=AFPM Anirudh Srinivasan
<asrinivasan@oss.tenstorrent.com> wrote:
>
> On Wed, Sep 30, 2026 at 1:59=E2=80=AFAM Joel Stanley <joel@jms.id.au> wro=
te:
> >
> > On Sat, 5 Sept 2026 at 00:18, Anirudh Srinivasan
> > <asrinivasan@oss.tenstorrent.com> wrote:
> > >
> > > This device present in Tenstorrent Atlantis has registers that contro=
l
> > > clocks, reset and other misc functionality in the SoC. This commit ad=
ds
> > > models for the RCPU, HSIO, PCIE, MM and 2 DDR PRCMs.
> > >
> > > Co-developed-by: Portia Stephens <portias@oss.tenstorrent.com>
> > > Signed-off-by: Portia Stephens <portias@oss.tenstorrent.com>
> > > Signed-off-by: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
> >
> > Reviewed-by: Joel Stanley <joel@jms.id.au>
> >
> > > ---
> > >  MAINTAINERS                        |   2 +
> > >  hw/misc/meson.build                |   1 +
> > >  hw/misc/trace-events               |   4 +
> > >  hw/misc/tt_atlantis_prcm.c         | 446 +++++++++++++++++++++++++++=
++++++++++
> > >  include/hw/misc/tt_atlantis_prcm.h |  51 +++++
> > >  5 files changed, 504 insertions(+)
> > >

> >
> > >
> > > +    }
> > > +
> > > +    if (data & PLL_EN) {
> > > +        s->regs[pll_reg_offset] |=3D BIT(PLL_LOCK_BIT);
> > > +    } else {
> > > +        s->regs[pll_reg_offset] &=3D ~BIT(PLL_LOCK_BIT);
> > > +    }
> > > +}
> > > +
> > > +static const MemoryRegionOps tt_atlantis_prcm_ops =3D {
> > > +    .read =3D tt_atlantis_prcm_read,
> > > +    .write =3D tt_atlantis_prcm_write,
> > > +    .endianness =3D DEVICE_LITTLE_ENDIAN,
> > > +    .valid.min_access_size =3D 4,
> > > +    .valid.max_access_size =3D 4,
> > > +};
> > > +
> > > +static const MemoryRegionOps tt_atlantis_prcm_rcpu_ops =3D {
> > > +    .read =3D tt_atlantis_prcm_read,
> > > +    .write =3D tt_atlantis_prcm_rcpu_write,
> > > +    .endianness =3D DEVICE_LITTLE_ENDIAN,
> > > +    .valid.min_access_size =3D 4,
> >
> > Are we sure? Do byte accesses trap on hardware?
>
> The spec defines that all the registers are 32-bit wide and uses word
> addressing. All software that's gonna be using this region also assume
> so and do read words only. Don't think it's worth accounting for this
> weird edge case.

On double checking, the hardware seems to allow byte reads, so I'll
update min_access_size to 1.

>
> >
> > > +    .valid.max_access_size =3D 4,
> > > +};
> > > +

