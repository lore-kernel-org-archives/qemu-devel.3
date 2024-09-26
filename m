Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42547CDE032
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2024 19:16:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sttxT-0000k7-AS; Thu, 26 Sep 2024 15:15:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sttxR-0000je-41
 for qemu-devel@nongnu.org; Thu, 26 Sep 2024 15:15:21 -0400
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sttxP-0003Zm-Cn
 for qemu-devel@nongnu.org; Thu, 26 Sep 2024 15:15:20 -0400
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-5365cf5de24so1865817e87.1
 for <qemu-devel@nongnu.org>; Thu, 26 Sep 2024 12:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727378117; x=1727982917; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=HI3keaE03KoQpyWY/Ux1MPNCfNTYLMEhuJWsV6MzVFo=;
 b=LlweqClS5n9CZ2lAfBQRL3ctLaZGVASMisuFaTmvuHflmf1wR1UqmsKWbFYkd40ojC
 YVl8UenIRJrFym1BYBc99Wy/M95SsaRwUgPBOLzq5X187gV78Os7Fyhtl1NS3iqT26+5
 T6VPxeUB481tyrwzEe9MOjBEcGQ1/mCAndEBUJgp4ZfRk7zDxZHD9i7NA9F5qb8h4hhT
 fLlALkfNh0ME3JzFuBMKIwR4ptvgKg+79quhhE6S9Q95Ij9NZNQ/QO3cxOOqC1MkTzFz
 VdLgdSHva6CnSDupOCgGrLfLhMUGsjIPrvqbb/a/fo9c/OtyFxJ3M4JqXl0yZOOg0Pfv
 62hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727378117; x=1727982917;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HI3keaE03KoQpyWY/Ux1MPNCfNTYLMEhuJWsV6MzVFo=;
 b=WjuPKAtqvAZ+n0TD0kH2zDqRBLXc0QgChwEUoKGsag1S2X3gctjjmKyu0q4yuIxzNX
 81y0NQmHGZHp59i8phHSKwKkN7LMpttGdsuyaywShfhvLdl3JVw9iVKcZOvPC0t/8/nm
 HRTIO8Pyp+3EosheKqWmHRIHCIInwVqgiCI5eZby/fJ6eQmnWKlhxcvhg13F6A4vrO8C
 3CGoEMH2Vk4ag3FE54efNHlhfXxD22Sqkw1so3aZ50zmlRrtUW0wTmg8OhNMH/X71LVJ
 duI80tMLmFi2ZyBN48U3PK+LOz3d0P99vsLvZNy9IqbPZ1cQtHz65YegXCghbV+QZLZw
 jtRw==
X-Gm-Message-State: AOJu0YzGLWh4YHSkd67ZazykvdSiQbLKMC2Ctrxe4CLJo41rk547ErhB
 EwfyCGHzqlbmQiTot+GtFdusO57mn+TFUYvWiQmTtiEca3k91uuiaoMUniQ/nfLfy0dy+rQ5dDo
 wydfVkV7SJbz09KgHcGugbpLSzED4Lu9OcO6ang==
X-Google-Smtp-Source: AGHT+IFyJ/g6x6a3X5k1tuMQVJxbUrGmnFsL15toJs8aN6FzRNHbsV2YKwVbGAvtx86mNVeIrXVUy96lWfBxa4qU24k=
X-Received: by 2002:a05:6512:138d:b0:536:5364:bc7 with SMTP id
 2adb3069b0e04-5389fcaf8cdmr429028e87.60.1727378116585; Thu, 26 Sep 2024
 12:15:16 -0700 (PDT)
MIME-Version: 1.0
References: <20240926170451.1479647-1-chao.liu@yeah.net>
In-Reply-To: <20240926170451.1479647-1-chao.liu@yeah.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 26 Sep 2024 20:15:05 +0100
Message-ID: <CAFEAcA-r6JTOK2iiJELjBgdx=eWwTp5MNrEdPs3tiHfqR9oYwQ@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] Re: Drop ignore_memory_transaction_failures for
 xilink_zynq
To: Chao Liu <chao.liu@yeah.net>
Cc: qemu-devel@nongnu.org, bin.meng@windriver.com, edgar.iglesias@gmail.com, 
 alistair@alistair23.me
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::12b;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On Thu, 26 Sept 2024 at 18:05, Chao Liu <chao.liu@yeah.net> wrote:
>
> > The ignore_memory_transaction_failures is used for compatibility
> > with legacy board models.
> >
> > I attempted to remove this property from the
> > xilink_zynq board and replace it with unimplemented devices to
> > handle devices that are not implemented on the board.
> >
> > Chao Liu (2):
> >   xilink_zynq: Add various missing unimplemented devices
> >   xilink-zynq-devcfg: Fix up for memory address range size not set
> >     correctly
> >
> >  hw/arm/xilinx_zynq.c      | 44 ++++++++++++++++++++++++++++++++++++++-
> >  hw/dma/xlnx-zynq-devcfg.c |  2 +-
> >  2 files changed, 44 insertions(+), 2 deletions(-)
> >
> > --
> > 2.46.1
>
> Hello, maintainers,
>
> Could you please provide any suggestions or feedback on the set of patches?
> This is my first contribution to the QEMU community,
> and it makes me feel very honored.
>
> Additionally, I have used creat_unimplemented_device() to
> add all the unimplemented devices on the Xilinx Zynq board,
> primarily referencing the Zynq DTS, located at
>
> roms/u-boot/arch/arm/dts/zynq-7000.dtsi.

Hi; this is on my todo list to review, but I think the
big question here is how much testing you have done and
on how big a range of guest software.

The reason that we set ignore_memory_transaction_failures on
this board (and all the others) was that it kept the behaviour
the same as before we added the support for making memory
transactions fail for accesses to nonexistent devices. This
was the safest thing since we didn't have access to that much guest
software to test on all of them. Getting rid of it for this board
is a good thing, but we need to be reasonably confident that
we have implemented all the devices that guests might be
touching. The cross-check against the dts is helpful there,
but so too is running as much real works-on-the-board code
as we can, to check it still boots.

thanks
-- PMM

