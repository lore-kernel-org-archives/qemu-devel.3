Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22D27CD4F3C
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 01:24:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOmi4-0001U8-Q6; Sun, 17 May 2026 21:23:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wOmi2-0001T5-Oj
 for qemu-devel@nongnu.org; Sun, 17 May 2026 21:23:54 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wOmi1-0003Wh-8H
 for qemu-devel@nongnu.org; Sun, 17 May 2026 21:23:54 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-bce386d5b85so258655566b.1
 for <qemu-devel@nongnu.org>; Sun, 17 May 2026 18:23:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779067431; cv=none;
 d=google.com; s=arc-20240605;
 b=PPJlRiMZYIeFBFUzZelN16pK1jxV4hDiGBNjl/GhytS1/rVMBx5wYyKXuytIadVad5
 JUhlc06/7L9hdlQq7kC6CFg9nxAuIHmpcEbIW9JZfHfnFVZ6Vmr86axRa4hbMsTaanoU
 9J6Ck2vtJ/y6GWS0Mn60x2EmhcDaV+/ZlNQiq8oxxwJBwIkESkkDCMb7ibThdADJzqbN
 MRV2TFO5fI6UiU6ATC3T20oDV1FBJztuW0LrwkzgFLrnIHmjRv2VJIhxe2YyBIFL9GyE
 8QEHZQDETQHS0EN1QgFwKBspYwd45VWYONAUrLvuckVXIxlwP/qJxEULSYUqE03Iu0Er
 Q3Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=L6x2/KE/Ff9HALcvjvAvRWSEqJV18mdqQgCNhtCBB4s=;
 fh=CXwePVPAEerRKZHZnrWTzdAYO4TaouveGW3zeIx1o5Y=;
 b=HH7CGZzrwYbCXndh80B7VyDglRRFs32V++k3Bz16TsbcRnxhbnRXk002RAKPbs1UAt
 fQVldDiOj/owpgZIbwTkUeZ8gx4eMAWhHwPJ++vJzJQa5OVQGwmBzsxC9LxH3pi3AnUh
 +ftQEW+IpWGHoZm3mJXMmqEjwgIBbA5XlD41Pjo2oA8GB+bzqinhmr4L1apPUO+tVEln
 kaSU0hso6dvtYllKKVbTjpkcInbkdLDk/3F72WZ5AFq7gR3WanJhe/rNTpyc8fsoaA3E
 jmkdBNKBE7ZCd7ydHL9mY2w0N4xXsGDYDAZpYLIttLVe2UDq5HmIfEeX0X238y5lMXb1
 WB3Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779067431; x=1779672231; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L6x2/KE/Ff9HALcvjvAvRWSEqJV18mdqQgCNhtCBB4s=;
 b=nFOFR0yDuYrhNbgEjl8qOuhBECzwWG91XayfmAfJAh5Odm0xWHK8KiubiniD9Z/8xi
 PjY+519EYtBm/QcEhVAW+5KFauH3FlHcvXsl2yIlXAytenNDVNqTztWeB3jp2MjrLfTz
 7X8k+vES06moi038mC9pRrZEoEabGjQkQpdFQBopH2KmLN8rnYVtGTo37r8eypMrnmWh
 4GHW13BX0pNaMAaqMeCtv/Fzwk6Sbo/GV5pJfunEDjq9DejDRIf32Hx+dg4tF2ZB/Y/D
 6GxER+q8O6TMLnbTJBn5ZLhWD1FWOhsGvJEKZ/BosAGMpggkH9d5GBP65K98N6VVqHF+
 B1Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779067431; x=1779672231;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=L6x2/KE/Ff9HALcvjvAvRWSEqJV18mdqQgCNhtCBB4s=;
 b=qt0CFGDFDNRy4LQFACuB+AxG2G/SMjXWajtj3wEh65Exk/epN9BxNjrxlpZawgFrE6
 EVFUGhpPyH5iTB9XcW4nG2O5qBMuZaDtSYY9nTkXAviGAaeksxtsTgXT6i2bfdIBushV
 J5GXwHOBuDXklnffNmWlaoSsgwmIFPMpHwzI1soTv5K3th7hYL6j/A7d02F0/cjZBH5E
 w9Y3Jg81ZA63o+EaNU4u9D2L6VWU1vG5aqGJqyPp2ZKS5TKH7hiwZdEq2WqERmRLCCn7
 wBsh1FOh1MGeAb5RrJik3wUwYuch6pkNW6ogaX3J9U8CsFfxHc3srj0NsxoGc9KwGGzz
 uz3A==
X-Forwarded-Encrypted: i=1;
 AFNElJ9y5ILjDmkj0VZ/rudVqVvxEZuz0TmWjv8RrGWvZKS4EbwW5pHobPwOy7Nm/zhSMXGIfAZF/jANRy0u@nongnu.org
X-Gm-Message-State: AOJu0YxKLIopnNY4girGFJF4ngO54Qq2Rr9ho3Mw8F7SFm2tcwEBhN4o
 0MznGUA4qgYOx8cHWlr1E8fWald3tdmPckYRL2fIQXfPyxCxots5W+rv+9j7+PG7Xa+yBii1akV
 mANYDmsd9t/AOHwBFAwnmIBT9WJNiMX4=
X-Gm-Gg: Acq92OGohOn1U3pMldHwipD2yDql2nJtqDHbSyvlhteaPm5B+wkqIuPb7XFBRjuJ6/E
 2TV+qE9hfZOHYtaGvTRvtRr3X9uc5ceAIFhqQ+6ZqG+aPanv/NdZYacnIaTZiCc9hjrzLH18Axh
 tcwwToOr4yYOn2QsBbfdKGdb8hJci68pWILyZDgzoqlmNc/S+vLCYRtMvH86mKW5bv0UkNCYLmx
 qxu3slj5BC//AHK99kQU++rAYXletVqenPzegwZO4RZ/iPN61WlCMWiIih2pxpKG7fD1ep3SPNH
 mBPhA1nfh8+gstdTyvzysFRj5LTSfWrGBud4Ng==
X-Received: by 2002:a17:907:e849:b0:bd0:6293:bd0a with SMTP id
 a640c23a62f3a-bd5177aa3e1mr650636566b.7.1779067431384; Sun, 17 May 2026
 18:23:51 -0700 (PDT)
MIME-Version: 1.0
References: <20260513023859.518484-1-alistair.francis@wdc.com>
In-Reply-To: <20260513023859.518484-1-alistair.francis@wdc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 18 May 2026 11:23:25 +1000
X-Gm-Features: AVHnY4JhzVYURVfX9-PGElG7jL0BOUgLnaFbxsH1q-dQGqI0IkDSBJ0LFMVTpdA
Message-ID: <CAKmqyKPfv=0NmtbfG477HPddsXZwWwFhF-r46M0cUEwELwDJag@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Mark Microchip PolarFire SoC as Odd Fixes
To: palmer@dabbelt.com, liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com, 
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com, 
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org, conor@kernel.org, 
 sebastian.huber@embedded-brains.de
Cc: Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x62f.google.com
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

On Wed, May 13, 2026 at 12:39=E2=80=AFPM <alistair23@gmail.com> wrote:
>
> From: Alistair Francis <alistair.francis@wdc.com>
>
> Mark the "Microchip PolarFire SoC Icicle Kit" as Odd Fixes and enlist
> Conor and Sebastian as people to help deal with the fixes.
>
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>

Thanks!

Applied to riscv-to-apply.next

Alistair

> ---
> Conor let me know if it should be a different address
>
>  MAINTAINERS | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 952ed683bb..9626eb1ea9 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1751,8 +1751,10 @@ F: target/riscv/xlrbr.decode
>  F: tests/tcg/riscv64/test-crc32.S
>
>  Microchip PolarFire SoC Icicle Kit
> +M: Conor Dooley <conor@kernel.org>
> +M: Sebastian Huber <sebastian.huber@embedded-brains.de>
>  L: qemu-riscv@nongnu.org
> -S: Supported
> +S: Odd Fixes
>  F: docs/system/riscv/microchip-icicle-kit.rst
>  F: hw/riscv/microchip_pfsoc.c
>  F: hw/char/mchp_pfsoc_mmuart.c
> --
> 2.53.0
>

