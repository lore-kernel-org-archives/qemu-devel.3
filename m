Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06177F433CD
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 00:17:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDAQ4-0003Ic-NN; Wed, 15 Apr 2026 20:17:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wDAQ2-0003II-Bc
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 20:17:18 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wDAQ0-0003Eg-Mr
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 20:17:18 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-b9e00649769so451728166b.3
 for <qemu-devel@nongnu.org>; Wed, 15 Apr 2026 17:17:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776298635; cv=none;
 d=google.com; s=arc-20240605;
 b=ODktnlOhgYRlE3U0Fsn0wPRGFah40e9fQvDWyjZc+XQzEJfWx9MRkZHHhbH8zhOQtI
 9IY0OpqdZ06wEY0iH+lt1QOWylQPnpf9GN+N13/hnmHxp5x/kdCoqzY9HAphEmOeXH2g
 zNNpoyWql+JrQKHGAc5p400SX2H36SbrN2t8yPhBuMFI05STQTPyXlOZpBnQSTpRUiGr
 D4H8GRDiILsZQjglqtansrIBQAJ8Kjc602+Lm847FW05NQhDIJI43ST17kCPUcljgu/Z
 eYoKV9LvwSRFTlYmqI/4SwU6EilbLLY/fJEgaHpeBB65tid+tSveIRFn4fgPRkDBuzi8
 q7+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=mcbOg68yttaqURDn2If0DJhKbrCknjQGSBUQttd01mU=;
 fh=ECBz6U0tu6q70ZdKKpS1JHd+/WXNYToi6haWKa2Zu0g=;
 b=inM0BvrAcCgnKU+vy9nRAOt5TDtELCBz7biMu6iOfyBCfSJmtBmvFa7r/nV5uJ9/Tp
 dHUYF4M/wxKok+EargWrFpU9yqTcFc2W2UvTArwZYzbvV1qTmsJNf1QXkmrVpmHKuYeu
 5lRneck1xOHpVPFFR4IIinJpbCxK6hxE+5S9+mKx0M3MXRVGDd+imgQG73lJGKGSkG17
 /Rf3c4+WQJFz6ftbms33Xxeg3GGNfp2AEyQVFXArcAEbCEBEXgrYCSzhu7TchPT1bPn7
 Kut4UpxSG6azoqudilnlGWDiUUdqYPwJraPyuHfWD2ehAcE9AUN+AuKQmoRB1ch0NBZ6
 H8rg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776298635; x=1776903435; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mcbOg68yttaqURDn2If0DJhKbrCknjQGSBUQttd01mU=;
 b=o2bwcskF1/l1EbBVlTq1UWtlWB68WWI0Qj36+Gy2lp41mwl3awdpItg9uRAOvCpn3j
 LDVQGze444ItcwFFe5cbLOfzzT6KmRDmIbdcNtBO9GDGYBpjBV1Ndx5HMWTyYal46R64
 SPkes92SmmFFN0njHCzUB/5Nuf3fho7k/vOV5/RODrpIGJAYI/0j9Fc8ka9gXSAhrrpv
 87c96dEAkI+tgr4kxxIFMSZu3cE2Z/Q//ygpxDDfn4tnYqHa+yFyJ2rI1XJAcWs6Sz+1
 7Ri7HNsyML9+JSpd+A50lO3u2/RPDO/j6xOIYbf+OXYFtuZWaXSyAvOwbRzUHaPgeITe
 33Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776298635; x=1776903435;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mcbOg68yttaqURDn2If0DJhKbrCknjQGSBUQttd01mU=;
 b=bTJzSaGMGfOj6kr+lm5sQoXtw70gWXYitUdSQusTtZettXjn/kFoaUJF6PaZWLC77I
 hapRvhXWkDHvBcup0zmblKH8EUaQhEfUcgGvFUPwPt4K0DM+HK8N5cn2MBi+1B6L8B/E
 QgGC+pqDrOCUl/C5llQ/jpGOhNwloSlBw7c0xnNOW35gFnCdZW71hFiC4O0rcWamXevI
 8So1/rtFsVAZHxjC+alsUvPkIUzH9CA13zTzproJLLGuQ8zKtd9LGyf7dpJ3G64fZcef
 DPZU8e/UZK+QwapEVZi+XiaBxLrWpN8nwtlvqUAIVQu/rJzxlLd45lzAHBhsentwHvhA
 aFzA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8VMAgQeVXWCjTxb9M56Var4zCchLhV/VHDDuK45ZMTrmpOkSmDaQ+vs7QbYsLGZPKec68ZKbsMYVLe@nongnu.org
X-Gm-Message-State: AOJu0YzcXK88jBZ5PlyQ3vO/o3h4J+ZVs+/wt1JkFj8OVd0Zc/oSSQXN
 E9N/p0U7lsQMA208ReEBYF2H10TOgIXrphkrscEMbFqauIQO4W4SVgrPcMTvzF7hp+lfnNZfZlr
 FqTU3gPjZn11PgW+YWKaG9sB3suloHGk=
X-Gm-Gg: AeBDiesmdaDHxEhOWd+Iwj5/3e2+KdbG2Ow+Jyw7GjOn91vUyu9XgbrEam1wmhnrsl8
 lhLr6Yx+y8FbKRJtQJUpHzCnKUh/n20HS/bPxXn6y5TS7PamcNhMpdDtN1yBIu1ggd5jkIPCK+8
 wwOASY8usLwXcV8E3BOry7unrTTfz5nNq9vw4hSglFDUrEm3/Tw3zKlVwcfmsVlcObeBllprk+d
 Z192CVhMs5UemG4Wwhmt4x1T7SQeEBwOBt/0tp4CUbV/whHz2jm24iD1SGS5L+DhG+Bw4bD3E/m
 UTz8PIu07KccNylAhpA2wqfSoPfFAqMBO1ZZAw==
X-Received: by 2002:a17:907:9803:b0:b9e:345b:a900 with SMTP id
 a640c23a62f3a-b9e345baa82mr587624666b.31.1776298634648; Wed, 15 Apr 2026
 17:17:14 -0700 (PDT)
MIME-Version: 1.0
References: <20260415064838.652297-1-joel@jms.id.au>
In-Reply-To: <20260415064838.652297-1-joel@jms.id.au>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 16 Apr 2026 10:16:48 +1000
X-Gm-Features: AQROBzAk_ENYIncnpfyRYu8XeRktvBIo40uqJ_r-Wd4oG7Gl-iwKp44cWyv2mvo
Message-ID: <CAKmqyKPt02n1GmYYHL+RWTdpvkuek9UdQCdH2w6Ji8LJQsu2dg@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] hw/riscv: Boot setup improvements
To: Joel Stanley <joel@jms.id.au>
Cc: Alistair Francis <alistair.francis@wdc.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-devel@nongnu.org, 
 Weiwei Li <liwei1518@gmail.com>, Michael Ellerman <mpe@oss.tenstorrent.com>, 
 Joel Stanley <jms@oss.tenstorrent.com>,
 Nick Piggin <npiggin@oss.tenstorrent.com>, 
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>, qemu-riscv@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x634.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Wed, Apr 15, 2026 at 4:50=E2=80=AFPM Joel Stanley <joel@jms.id.au> wrote=
:
>
> v2: Tweak commit message in patch 4, add Daniel's r-b
>
> The first two patches improve the boot infrastructure for riscv so
> machines with split memory regions can load payloads into the correct
> region.
>
> The second two patches improve usability when attempting to run opensbi
> in less common situations.
>
> This series are prerequisites for the Atlantis machine.
>
> Nicholas Piggin (4):
>   hw/riscv/boot: Describe discontiguous memory in boot_info
>   hw/riscv/boot: Account for discontiguous memory when loading firmware
>   hw/riscv/boot: Warn if a ELF format file is loaded as a binary
>   hw/riscv/boot: Provide a simple halting payload

I have pulled out and applied patch 3 to help, as I know this series
and a few others from you got lost with some mailing list issues I
had.

In future please ping patches if you think they have been ignored,
https://www.qemu.org/docs/master/devel/submitting-a-patch.html#if-your-patc=
h-seems-to-have-been-ignored

Alistair

>
>  include/hw/riscv/boot.h    | 14 +++++++-
>  hw/riscv/boot.c            | 73 ++++++++++++++++++++++++++++++++------
>  hw/riscv/microchip_pfsoc.c |  6 ++--
>  hw/riscv/opentitan.c       |  6 ++--
>  hw/riscv/shakti_c.c        |  6 +++-
>  hw/riscv/sifive_u.c        |  3 +-
>  hw/riscv/spike.c           |  6 ++--
>  hw/riscv/virt.c            |  7 ++--
>  hw/riscv/xiangshan_kmh.c   |  6 +++-
>  9 files changed, 104 insertions(+), 23 deletions(-)
>
> --
> 2.47.3
>
>

