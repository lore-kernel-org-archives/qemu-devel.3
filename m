Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9C17CA0EE4
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Aug 2025 18:08:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umypX-0004nm-Ti; Fri, 15 Aug 2025 14:07:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1umypW-0004mh-2o
 for qemu-devel@nongnu.org; Fri, 15 Aug 2025 14:07:06 -0400
Received: from mail-yb1-xb36.google.com ([2607:f8b0:4864:20::b36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1umypU-0000lw-8E
 for qemu-devel@nongnu.org; Fri, 15 Aug 2025 14:07:05 -0400
Received: by mail-yb1-xb36.google.com with SMTP id
 3f1490d57ef6-e9321ed5e5eso1447326276.3
 for <qemu-devel@nongnu.org>; Fri, 15 Aug 2025 11:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755281222; x=1755886022; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RhikmQwDDIYVmPEkyOKvfVc6L9/rN3K5YGSsXvDjuO4=;
 b=csyXDIUemcLS+LKb41mAXFIfDg9ZwzUsd2L+TaBL7jkjRUc5B0VJF5Hw2/d0CO/eHZ
 WPnc6da6o0lEmuGQN/VaWjEMwyzR9d5ExmToJ4KuZo5k3b2Elw16vcyS9jqDv8c93ybe
 mTSDtzMl3xWd1K9c8dA6fphnrx0YR+JCUXpk/9pzOh/uBY674td4Ckeyngj6vXC71s1B
 Yv7lUPuuNwkenUZpQ7qi7GxRfX2MIpNfKA+vi+yBCQ8sf0rChUKzhyX2il4XybkdxCTx
 mrxKbYTe8ZG8gc3esPAw+wJ89/jbLH7xosjXp2Dzs6sOxpBFDcL4Bq3g8meny37W++JW
 rYCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755281222; x=1755886022;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RhikmQwDDIYVmPEkyOKvfVc6L9/rN3K5YGSsXvDjuO4=;
 b=u4/36fpRkaSHPFz8ef0Wb5ugwdonKJ5mk1rqOyQtEORLr+o6EXedwswISeWBE2SqEr
 ctvO2a9QrpZGqAwr14dFM3uvc72WVKVVF4tHRe8GKSAbwS7Kw34Tt9G/4bosHXQq8X6A
 doBqRiA0VFH/kzdP0oW6oAtzlfcGve0ryTWLULtYLCs/hzQ7DQxKWignWDoIxS9Omd9w
 pHg9F9n5asSpDLJwdCyK52cbXYKvosxFZXr9p19024pwNiuawVUWZ7ikNs0L+LR+HRTG
 P1dgw2mqyQ5D/2zzq5ne77p3Xb6Tp6UGmVa2g+qucdEB+OrifEv/azODM3En/nac062Q
 Ebzw==
X-Gm-Message-State: AOJu0YzyODAjub+HR78vKpfANMbqJsW2isYz8nS1EBxkqhjD8XWqSASW
 YZ3GjXZ93Xe+EdAc9EYmikXR51QWR4RqTVGickpQxMMTYvPFRc2nvkwSw9awk8TfBhKoWZOFPx8
 uYqwSKO2ausnDP94asMNMV5OkzEbInJodh0gu4AaNZA==
X-Gm-Gg: ASbGncuH/GCcHO5PfTgJ8tyah2ov+RxD7lJf5dKHTXB/YhR8BiZ1W3ZiRXdDpdFHT1I
 ovuePBX3g68TeA7sr1gXHgKid+8blrL8Cl8JdyZG8c4pT7WeOrdmpqPK2byGA3buu34vCKQ3Tl+
 sZNWrpr9AqeJmBjaXzqGG2qRvvE2apQl7PSBa+q22x2u9gwSEF893fGZQ2Anj0mu5xBSM1akGP+
 Oi9g9I2x35PReQnib8=
X-Google-Smtp-Source: AGHT+IHSLxPf5G+GX0YzK3h0logrDUGBXlfy1J6opL/BLqAumjqi38vuYsIeWB5oK+MLptsdRyXw+QMvpvwUkx1dGV0=
X-Received: by 2002:a05:6902:188c:b0:e93:37a0:dca3 with SMTP id
 3f1490d57ef6-e9337a0e5d8mr3152534276.47.1755281222556; Fri, 15 Aug 2025
 11:07:02 -0700 (PDT)
MIME-Version: 1.0
References: <20250815090113.141641-1-corvin.koehne@gmail.com>
In-Reply-To: <20250815090113.141641-1-corvin.koehne@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 15 Aug 2025 19:06:50 +0100
X-Gm-Features: Ac12FXzTal8gWfbDSF2X4HwabUYteAr0EMiFM8Qq2yetuJFIvP3UuLIRS4HoetA
Message-ID: <CAFEAcA9y-0-Oe5beVObe+SZqmByRSOYkCaKM1FDjeo0jdxjjCQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/14] hw/arm: add Beckhoff CX7200 board
To: =?UTF-8?Q?Corvin_K=C3=B6hne?= <corvin.koehne@gmail.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Corvin_K=C3=B6hne?= <c.koehne@beckhoff.com>, 
 qemu-arm@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>, 
 =?UTF-8?Q?Yannick_Vo=C3=9Fen?= <y.vossen@beckhoff.com>, 
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b36;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb36.google.com
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

On Fri, 15 Aug 2025 at 10:01, Corvin K=C3=B6hne <corvin.koehne@gmail.com> w=
rote:
>
> From: Corvin K=C3=B6hne <c.koehne@beckhoff.com>
>
> Hi,
>
> Beckhoff has build a board, called CX7200, based on the Xilinx Zynq A9
> platform. This commit series adds the Beckhoff CX7200 as new board varian=
t to
> QEMU.
>
> The emulation is able to successfully boot an CX7200 image. The image inc=
ludes
> some self tests executed on every boot. Only the cache self test fails du=
e to
> QEMU emulating the cache as always being coherent. The self tests include=
 f.e.:
>
> * Network
> * Flash
> * CCAT DMA + EEPROM [1]
> * TwinCAT (Beckhoff's automation control software [2])
>
> [1] https://github.com/beckhoff/ccat
> [2] https://www.beckhoff.com/en-us/products/automation/
>
> YannickV (14):
>   hw/timer: Make frequency configurable
>   hw/timer: Make PERIPHCLK period configurable
>   hw/dma/zynq-devcfg: Handle bitstream loading via DMA to 0xffffffff
>   hw/arm/zynq-devcfg: Prevent unintended unlock during initialization
>   hw/dma/zynq: Ensure PCFG_DONE bit remains set to indicate PL is in
>     user mode
>   hw/dma/zynq-devcfg: Simulate dummy PL reset
>   hw/dma/zynq-devcfg: Indicate power-up status of PL
>   hw/dma/zynq-devcfg: Fix register memory
>   hw/misc: Add dummy ZYNQ DDR controller
>   hw/misc/zynq_slcr: Add logic for DCI configuration
>   hw/misc: Add Beckhoff CCAT device
>   hw/block/m25p80: Add HAS_SR_TB flag for is25lp016d
>   hw/arm: Add new machine based on xilinx-zynq-a9 for Beckhoff CX7200
>   docs/system/arm: Add support for Beckhoff CX7200

This patchset is on my list to review. As an initial request,
for a new board could we have a test in tests/functional/
please? This is basically a simple test that downloads
a guest image from some public stable URL, runs it on QEMU,
and checks for some output on the UART that indicates
that it succeeded. (You can do more complex things like
sending commands to the guest if you want/need to, but
"does it basically boot" is the minimum bar here.)
The other files in tests/functional/ should hopefully
serve as examples you can pattern your test on.

thanks
-- PMM

