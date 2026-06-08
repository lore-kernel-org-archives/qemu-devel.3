Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 697B2CD8C9D
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 16:12:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWcZw-0007FP-GF; Mon, 08 Jun 2026 12:11:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wWcZo-0006zg-Kr
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 12:11:51 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wWcZl-0001Ic-KX
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 12:11:47 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-bf1141c26ecso567967566b.0
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2026 09:11:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780935103; cv=none;
 d=google.com; s=arc-20240605;
 b=Zs2XSOfWRuYPiCCR+LgAdozmuso0l+6zvws8ElsnJlwzeexEVaIUo0/M0vKOnX4t+z
 lhRdgPX+u+z36e7Hz81rEqHON+HsrY2M0mXbaVZiN9jYMawxA69gqGG7LJhcWmDBoK7B
 FSgoEgCo0hyKBx3sNYU3eDHr2NXunzeNCfWrSQynD2UiX66Abr+6blfBpep3pcDftuI2
 lLrxolR7rkjEMXHOh6kj7kpjPr5ZKn0SnvuhbOVh64lRE9dUJsgT8e4CxVyj3V52beY4
 8790lHNyo3Exte0NW0Twvpt47R/9iERQFdiIUm6bY8s3CGcyb41Rv/J7pJqtFIVebWzA
 nP/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=mb7X/0HHleI60MgeHsluNqVdU8t3PIEaJe3bEgirxyU=;
 fh=pKySv2xcbjaCYxZIv8yzgUGbkvgT4ofnF4GNuybRbac=;
 b=B+leduQjxLNKpr9xbPR1eJze7irE1kKuXyYl9rA6etEor6HAyQGG7MikMwr1SKusv3
 tfOMUlB9ZHgbyk5JWDYT2OOKsoiAycew5NNtABObylPBf+GkFnKUjBu3JfLdSuBYQpad
 MP3vcUom6GHBGeSF8BFFERgbqfKqil8kvM/OMeFzAvHT3Sw42tyoNU9ddHGYIeYGG0H3
 WehQp+k/CkQjQOmjvsYuzSdHh0aTzUNvdWVpfkyDZEfl4ezJ+XxvUmF2ffgGZZKk/h7H
 aYqmd0abshqOlvzIEzUzayRjZKF7SQnxlQFyu+v8t+udaCsc9Xd2bgh1C9aL+LnLZA6M
 ZqyA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780935103; x=1781539903; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mb7X/0HHleI60MgeHsluNqVdU8t3PIEaJe3bEgirxyU=;
 b=fPrf3STMQb3i3S3Rp8ht5Q4Q4nBNUnvkqXKGmQsC6npFYRb8JXmU+ASPtm3zKh19/g
 uK1LGIipvotXNDcg2ht7hU4ByxZJj/TgK3eUvF9iWqcyVw3I1uqqqVXiVhh6b5RPoX56
 txH1PcJAqYGKvMo4vSTHFZ9ObfI2CPAUvHQ1wbvp2Xa/3PSs3SW0stAIoUCywDFzdT8+
 UCxIh1XCDpcYfAXUXabO7tCvGWUwNt7A7jpZL1pGMsRwf3H6W0/EnbWElW9TfgOV7gUn
 Nh4B/Npw8oPhq5Ue10rqs3GoNfPjEvdMKJFDDE03Xe3bX5QrsbvTUCUaJDcYZSpvHGHD
 bKLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780935103; x=1781539903;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mb7X/0HHleI60MgeHsluNqVdU8t3PIEaJe3bEgirxyU=;
 b=UvnZ6NPccV1ZFYON9rJ4cDLinJPyTpbbrQuW3GeQ3d7TXryH40xv20Wl+c4DwT256n
 nEJOfGPRDw6J93ciGppiQpiKd6LH0X9viGGnojnLpSsY13DXHwaD4f4DPAH31bCv0fnc
 z02R8Fg+efvj3SqFXdQwkwndVPauNdSAfLHTjVwInocPgrp2IK4f8AeZO/Hc9BijqlOz
 DQyQviVdZFcJkeN1+AXkjuvLh3fv5b1pe0edMNaI0z6PTSaV38IkMS0Rw/7H2Dxa3Ir7
 tJDm09ycKsy09xJ4IVVpUvEH0WgPZ/Rrqe4vH7N6ktVneZC2qePXyAHR1f0+ymjT+ZMI
 UoPA==
X-Gm-Message-State: AOJu0YywrCU+9RsMGAcfoDa7ZNGBNUvMq5FrN1Ji1Sb3Sq5epY/lD6vO
 2bZUV0EDbeYDcLOUzg2UB0lPmYan9YpvOFD0ojTmXYF6B4DdC1jOS0foxDabj3hP9KGhGkJQLMS
 4dyLu6WC255v16hh1MW4D9kyHn7HFr1kPFAzlDB6i3Q==
X-Gm-Gg: Acq92OEFaVixHcyptgZLusDjSXOXifXNdU+DuRP0Wvzp0FsHKJLjTiaSTURL9DltQRZ
 KRUQzSD2AFYhAC+BVO6i34DDXr6++CcN00s1ZW0elF4azuaHMBU/JnVT08KCul6e+nCi1yQF1Wk
 btfKV+HZDYEHJxrk5rJdRetha/9ftN3p2WNJhpZVQp86u3ZP6FgYImjybe3UUZhRipg0AyAcmu4
 qKlKv4XMK5G/8YLhnSXe2wdU3QBeICR7I2tS+NIhSZHWYMlcm0nys36E/ivT1Ka/5dgrXL/SC2a
 g+I0avrqz5NsjY54Teno32cFyfMKsMiSDxqkH/95bPw96Hi2H0MrSSJ00OPi50fP9Kqn1gB28Xt
 XJw==
X-Received: by 2002:a17:906:4fcd:b0:bda:e47:70c7 with SMTP id
 a640c23a62f3a-bf37018943dmr750952766b.12.1780935102743; Mon, 08 Jun 2026
 09:11:42 -0700 (PDT)
MIME-Version: 1.0
References: <20260529174639.451353-1-peter.maydell@linaro.org>
 <20260529174639.451353-4-peter.maydell@linaro.org>
 <d6f30fab-eb87-45e7-bc5b-bd1f97afead8@mailo.com>
 <CAFEAcA8uLpCA2kCzqM2jii+jigd-mRYgpVCfb=qvwZH4SU9Gzg@mail.gmail.com>
 <d9abaa0e-abf2-4eef-9292-171b55588f4b@oss.qualcomm.com>
In-Reply-To: <d9abaa0e-abf2-4eef-9292-171b55588f4b@oss.qualcomm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 8 Jun 2026 17:11:28 +0100
X-Gm-Features: AVVi8CcVqTPxvPyd3XU_krhff2YEDZx-bRty171du_uAM2BxE1I2OjPWjEmEoek
Message-ID: <CAFEAcA8iD_SPwbHr5+OgyoR9C-R6+y5SuQmPO3QFUunfA_Og6Q@mail.gmail.com>
Subject: Re: [PATCH 3/5] hw/nvram/fw_cfg: Enforce standard layout for x86
 fw_cfg I/O ports
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Sergio Lopez <slp@redhat.com>,
 Song Gao <gaosong@loongson.cn>, 
 Bibo Mao <maobibo@loongson.cn>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu.zevorn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x629.google.com
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

On Mon, 8 Jun 2026 at 17:02, Philippe Mathieu-Daud=C3=A9
<philmd@oss.qualcomm.com> wrote:
>
> On 8/6/26 11:12, Peter Maydell wrote:
> > On Wed, 3 Jun 2026 at 08:08, Philippe Mathieu-Daud=C3=A9 <philmd@mailo.=
com> wrote:
> >>
> >> On 29/5/26 19:46, Peter Maydell wrote:
> >>> The fw_cfg_init_io_dma() function allows the caller to specify the
> >>> base port number of the selector/data register and the base port
> >>> number of the DMA address register separately. No caller actually
> >>> uses this: they all pass in base + 4 for the dma_iobase.
> >>>
> >>> To reduce the risk of unnecessary variation in what different x86
> >>> machine types use as their fw_cfg register layout, remove the
> >>> dma_iobase argument from fw_cfg_init_io_dma(), and have the function
> >>> always use the same "DMA port is base port + 4" layout.
> >>>
> >>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> >>> ---
> >>>    hw/i386/fw_cfg.c          |  3 +--
> >>>    hw/i386/microvm.c         |  3 +--
> >>>    hw/i386/pc.c              |  3 +--
> >>>    hw/nvram/fw_cfg.c         |  8 ++++----
> >>>    include/hw/nvram/fw_cfg.h | 17 +++++++++++++++--
> >>>    5 files changed, 22 insertions(+), 12 deletions(-)
> >>
> >>
> >>> diff --git a/include/hw/nvram/fw_cfg.h b/include/hw/nvram/fw_cfg.h
> >>> index 45a3747908..be3fb5f8aa 100644
> >>> --- a/include/hw/nvram/fw_cfg.h
> >>> +++ b/include/hw/nvram/fw_cfg.h
> >>> @@ -305,8 +305,21 @@ bool fw_cfg_add_file_from_generator(FWCfgState *=
s,
> >>>                                        Object *parent, const char *pa=
rt,
> >>>                                        const char *filename, Error **=
errp);
> >>>
> >>> -FWCfgState *fw_cfg_init_io_dma(uint32_t iobase, uint32_t dma_iobase,
> >>> -                                AddressSpace *dma_as);
> >>> +/**
> >>> + * fw_cfg_init_io_dma:
> >>> + * @iobase: x86 port number which is the base of the fw_cfg port ran=
ge
> >>
> >> s/x86/ISA/?
> >
> > This is specifically x86, because we use this where we're
> > wiring fw_cfg up to the x86 in/out port instructions. There's
> > no ISA-bus version of fw_cfg. Anything other than x86 should
> > be using the memory-mapped fw_cfg.
>
> But this "x86 port number" is really a address on the ISA I/O bus.
>
> Maybe make explicit we want this method restricted to x86 instead?

I do, which is why I say "x86 port number".

> "ISA port number which is the base of the fw_cfg port range (restricted
> to x86 targets)."

This seems more confusing to me because it brings ISA into it.
We don't care about ISA or not ISA, we only care that this is
an x86 I/O port. It happens that on the PC the x86 I/O ports
can be handled by ISA cards, but it's not relevant here.
In particular, the fw_cfg device is not an ISA device.

thanks
-- PMM

