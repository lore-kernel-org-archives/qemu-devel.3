Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF1DFCA101F
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Sep 2025 03:48:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uy0C7-0005C7-VH; Sun, 14 Sep 2025 23:48:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uy0C5-0005AC-L7
 for qemu-devel@nongnu.org; Sun, 14 Sep 2025 23:47:57 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uy0Bx-00011B-M2
 for qemu-devel@nongnu.org; Sun, 14 Sep 2025 23:47:55 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-b04ba58a84fso486341966b.2
 for <qemu-devel@nongnu.org>; Sun, 14 Sep 2025 20:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757908061; x=1758512861; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ziZbYMkrakVTHBgCTSp3Po5rLoN7EPWmZP2D6hFs6Cs=;
 b=WCAV3hLfvRJw6vDPZNhA7TerAKRY8t8HfEgQi4WAj2TWB4HzXahPWwUkY4r04lbkKO
 b7tB5F62QWI7N2QfKlbvpbWL2EoeDGcvk03UI6ZFd1ulXg9wh0xhcvol/AqPL/SwS9x+
 ShHgbLGkBTnixR7aqw1qqBcCjSAohzU2I8b811iCbnZ4BA29ns19iiDqUoi3lkn3TQIk
 1ctWC+tlpIQoB2DqNnwhSCrFqY4s6JJZD8tLiRVir3qO6CH7BbTEXLxGK3aCEIwRH93t
 SR3V91/Rb1Nc0jLGt12KSxiM1ic4mL0EbgFj3PN8V3zDj/euLJ41PZojiDo0yxFL8lbZ
 tXhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757908061; x=1758512861;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ziZbYMkrakVTHBgCTSp3Po5rLoN7EPWmZP2D6hFs6Cs=;
 b=MzblaAfpn+IfOtLKrKWmWg57HyskFCKhEkgBieeEe8a+RO8T8SkfFOveAdJjfD/FK5
 sIcAWWRd3VA+EU2SneZG+TK/OXyFEwEUjGvaR/hzY/s6kc9LeGJrOElU8/54OXcm86ED
 4/p4FfFbFvJemDpVJM0ptOH+gncAcMmTSW4oU6SMrETtKF43pb9vlyt7U6bUG1/ulhPk
 zUWg1kJRrNSrVYKH8BvCypUTYjYrX/nHfI5Z2//q7T+s+zM6lVXSMxmkZyLmMrLTgnc6
 n9MPSDy2vQVwH4HKNPdQLCa9A+QmS07xqwCXL7OqEMRa25UVZNjlSlq4K24uuG9azkCN
 anXw==
X-Gm-Message-State: AOJu0Yx+w4leoW4PHHS6ahifhSUV2ONFYkC5SJ8vTLDy70z7+ibz2aPO
 TRLXeTtP+e42mh5/AZr2LC3MkTor0H6e9Ks0LZx1RseO3GLlUsbNeq3hxSG808Fv5kps/Tk6XEq
 c23BS7Ak9H3Hqf+tzrVguXps4BtMbHXQ=
X-Gm-Gg: ASbGncs3u+NYYBSwrDccnGmW7FdsM2LuaCE6hLtWc19K8x6eAEpgocuMSUtULJF0Ibp
 hVtV6BOqqDdK7+AGzi2qqR8DpXRmoCxuYXRqbgra29a78LpNdLLtyTjHrlloG50PnkugIUAD89L
 NviudMLIg1zcfiVjUgAVll89NgmQzrvnczNsFOWA3d9YJwemF84MpVS/lOmtv8Z3RyMLMD1sFj9
 kmMGqH1+inR1PhhKJN77tWpdzmkl0MpnMujem1H3xpy4GzA
X-Google-Smtp-Source: AGHT+IEA6UEC7jigoREOBHAv9KqnZMJ/zCvnXiob1yzY6Ah4xohJ8cuZ4TD442LaGhbvMUU4JmuYrGe2vVkZPsVfeWA=
X-Received: by 2002:a17:907:869f:b0:af9:5ca0:e4fe with SMTP id
 a640c23a62f3a-b07c396ea42mr1137610766b.56.1757908060726; Sun, 14 Sep 2025
 20:47:40 -0700 (PDT)
MIME-Version: 1.0
References: <20250911160647.5710-1-frank.chang@sifive.com>
 <20250911160647.5710-4-frank.chang@sifive.com>
In-Reply-To: <20250911160647.5710-4-frank.chang@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 15 Sep 2025 13:47:14 +1000
X-Gm-Features: Ac12FXwnoO9-wA4Ts3cS7E9iTkbK6BdcM-H6NmN1yPr7fozg5WBE9u0l2iPDbBU
Message-ID: <CAKmqyKPhD7s5bD8UnMixd76fa-A-F0RFgF3RNy2fnLqBH8y59g@mail.gmail.com>
Subject: Re: [PATCH 3/4] hw/char: sifive_uart: Remove outdated comment about
 Tx FIFO
To: frank.chang@sifive.com
Cc: qemu-devel@nongnu.org, Alistair Francis <Alistair.Francis@wdc.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 "open list:SiFive Machines" <qemu-riscv@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x62e.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Fri, Sep 12, 2025 at 2:08=E2=80=AFAM <frank.chang@sifive.com> wrote:
>
> From: Frank Chang <frank.chang@sifive.com>
>
> Since Tx FIFO is now implemented using "qemu/fifo8.h", remove the comment
> that no longer reflects the current implementation.
>
> Signed-off-by: Frank Chang <frank.chang@sifive.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/char/sifive_uart.c | 6 ------
>  1 file changed, 6 deletions(-)
>
> diff --git a/hw/char/sifive_uart.c b/hw/char/sifive_uart.c
> index 401f869680d..baef0bd9c28 100644
> --- a/hw/char/sifive_uart.c
> +++ b/hw/char/sifive_uart.c
> @@ -28,12 +28,6 @@
>
>  #define TX_INTERRUPT_TRIGGER_DELAY_NS 100
>
> -/*
> - * Not yet implemented:
> - *
> - * Transmit FIFO using "qemu/fifo8.h"
> - */
> -
>  /* Returns the state of the IP (interrupt pending) register */
>  static uint32_t sifive_uart_ip(SiFiveUARTState *s)
>  {
> --
> 2.49.0
>
>

