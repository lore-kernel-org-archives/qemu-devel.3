Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AD58F433D3
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 01:32:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDBaa-0004Xd-Nu; Wed, 15 Apr 2026 21:32:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wDBaY-0004XH-NQ
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 21:32:14 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wDBaW-0002Gb-J3
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 21:32:14 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-6712fd40860so8352768a12.1
 for <qemu-devel@nongnu.org>; Wed, 15 Apr 2026 18:32:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776303131; cv=none;
 d=google.com; s=arc-20240605;
 b=SN5Xl0i/PI2C4UaSS0/GS2YSRgyYUOstL8OaZX6dm8dosydjWFlleRdpKqwzxS/rea
 RGxdPI/JklHjkBK/AXZsMKbEQahIDd5WC6bQYeP3nXX9MdqisYLPIv5XlH+1DKX8cFz6
 mluiROqGqXi+ZTxH2kE+E863K5cVVFemDtXLNjKgtjvrv3zgmDESfXg306LswqygUkH1
 Pxp3XLV3LvOtCu37E9VWNIeXFz8uqyGdw9xu+p0ytMUbQUW79NR7ctVxbsnvKAvDD60m
 yWScXyhhIDLAJupYNgYna8mns23paEn3U04LqiWr8XIqdEN5iBgLV9oquD5fZyp3NjSt
 G+DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Vg5eUGnQ1xOlACJ2ME3HG4G2lzpBNS4zsRBq9HVp+Cw=;
 fh=iSPtWaYBstHS6oQJttjLuEsQwChunDn2c2vfxgsm5Ck=;
 b=frF1xJ6/N/CAjCQ9qls0DuUBffT5dt8lVXU2fwvENjcZSexgKqjFmrKCOujSwqk4Y7
 md+ZubkJyUD8PpRnFoKBcu3luF0QCtwoA5sBe2aHo/jZdJX7dKGiSZ6nbNMbDiNQIyo4
 zcg4t90yke4HHIegnWLLb3D+9CorhBmwi7q8GWEF3MJ66x+clGCEoW7tmV+lTqB0mphn
 45stwmep+QJgcBKw6c6diBkQU41XvlQ3FLeUySDKHy53A+8YaK7oz910zsTMiTubIafA
 P+cKNluT8HgbQ/N23hEaEYxg7QanMPzOztebNZtxa7JGXsxcpXK6pZPc7DkOTZJIQYq/
 +xEQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776303131; x=1776907931; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Vg5eUGnQ1xOlACJ2ME3HG4G2lzpBNS4zsRBq9HVp+Cw=;
 b=oCCEh634A2Q4EVMzIDXV52br8hOkyB1EuuAgGRFQUYLgqEqC/GKM3f5mB8rLpr7tLE
 V7i1pPmNJlnqZ/KqOr5BUxsUKTvJ9Y0aXDVCBExTcyfs0KgV35qj+n9OCuqVe0WeKuiw
 Px3pDLIgFst5grdusg6Ak8oPhaBn+dER4ZMzLc6yJntMmnwII9wPwCDW/DpCxolv8aRI
 sLT1f3xSElOemtswG80ryRFqRMytEkk7kOeeZaCs62Lk2JMWwDTtrCIgFLwZ3FXCpWWX
 Ak+Gsms8HEDaMn58oufuScyAVp1+lqCC/hLmHuofSDSKIAg0VskIo/jF4jEWmBkMQ96Y
 qvTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776303131; x=1776907931;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Vg5eUGnQ1xOlACJ2ME3HG4G2lzpBNS4zsRBq9HVp+Cw=;
 b=nn+07Ldj1pxPMplF/N9dg9imEaQ7x6tBLmtW+x8cmM5iOW/0Pr35IFqf0LLZd3RnKn
 hlcncElxKRWsiXYkVDS+MxqI85QnH1HTQvYhZxuaB187J8gLpnI/3I+pGHDgepCvoHoi
 cjZ2H/zYASs7mOj9jfdPtO7MnUAWh49mfGnzGhYd5h7b8kHqIme7QPOGH5WlXmgO39pj
 sZMMubXmiDA8UG72IOY/6D0VqM3erwhqjuWkUQ4YKT10doZ31+9cGDIRgGmnssYv4k9L
 ilKKtpMMJxSi2TnCPP83uEILtor3JxL16DzEBcZvMYNvKCL4bWlzGgSS/D7RRX0cwKqM
 zskQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8TiUk1MW0QMNQSX54xfStfR/bO6z1/W8yOHmvmSVoeqDZynx0aBx7Iyu1rvke61qWMjFxo0S8gJELH@nongnu.org
X-Gm-Message-State: AOJu0YxhNLfCydevEfiTfkzFkxhTW3vtRbvZst8FA+lME57LU5gZHxZX
 HeQBOejVmaeEXAg8MEJBWPfvVCHtp27jPqx16mq+oeV2yt9IQaGjNguBhI28kajGEAnviu1zley
 TUl4rQzLWNwbkBKfhquCwVpsoTnItveQ=
X-Gm-Gg: AeBDiesii+cHrSOQ/eCvgWIQQLTDTI4LHJqkKQONm3PcZaODqELWdNpelGB5168J+F7
 6v7EVkHu0mPCsod6yRkQ+bdejrd0c6oOm3hcRK0MVyMV9hdeIN3TX+qBz5Ds8OWm3uHmkdfd0a4
 /aD3Hl/u4PKefI1SZQUPs3oEwSdrvviKgO9wCdJsR2ufGTIiF9ez2gRMH3iVIlq1Nv9rkT2qQj0
 /bkuu2sQ3foWwFSaqurX8ZI/nOVUgY3pvjHR7znDqogA66mL3lJIGnLeWHgzRKJho+mYyZxdTwF
 xi6oiwTzRc7L5bCf4DXAAfcHSCzm0ckgUjMudg==
X-Received: by 2002:a17:907:1c9c:b0:b98:6926:13a5 with SMTP id
 a640c23a62f3a-b9d72ad9e26mr1362495866b.46.1776303130557; Wed, 15 Apr 2026
 18:32:10 -0700 (PDT)
MIME-Version: 1.0
References: <177618728515.4917.14466194789826252277-0@git.sr.ht>
In-Reply-To: <177618728515.4917.14466194789826252277-0@git.sr.ht>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 16 Apr 2026 11:31:42 +1000
X-Gm-Features: AQROBzBrOPEbagzZFE0cMhlGC1RK7OT7Elzk1DyRmHNtWZbaqFoufDwdnLaUKNY
Message-ID: <CAKmqyKOD9=dj5+V8qh0+EhyLMVgeB-DeyYzX2OrVCNyTCmCcig@mail.gmail.com>
Subject: Re: [PATCH qemu v3 00/10] Update opentitan uart (part of supporting
 opentitan version 1)
To: "~lexbaileylowrisc" <lex.bailey@lowrisc.org>
Cc: qemu-riscv@nongnu.org, Alistair Francis <Alistair.Francis@wdc.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu.zevorn@gmail.com>, qemu-devel@nongnu.org, 
 Amit Kumar-Hermosillo <amitkh@google.com>,
 nabihestefan <nabihestefan@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x52a.google.com
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

On Wed, Apr 15, 2026 at 3:22=E2=80=AFAM ~lexbaileylowrisc
<lexbaileylowrisc@git.sr.ht> wrote:
>
> Thanks for the review comments again!
>
> this is the third revision of the patch set that [starts to] update
> the OpenTitan uart to align with earlgrey version 1.0.0. I can't really
> give a specific commit hash, but the there is a branch on the opentitan
> repo which represents this version:
> https://github.com/lowRISC/opentitan/tree/earlgrey_1.0.0

We really need something frozen to point at to say that "this is the
version we are targeting"

>
> I can't give a specifc hash because these changes do miss out two
> important parts of the UART device. The clock manager is not yet present

That's fine, as long as the UART works for hash `abcdefg` then we
should point to that

Alistair

> in upstream qemu, only in the lowRISC fork, so for now it is not
> connected here. The other issue is that the alert handler block is
> missing, and thus the alert test feature of the UART will not work. This
> can only be fixed after the alert handler is also upstreamed. that will
> come later.
>
> as before, the details of the version 1 of the UART are found here:
> https://opentitan.org/book/hw/ip/uart/index.html
> (and this URL is still added to the file header in one of these commits,
> as before)
>
> I have now split up that large commit into logical steps, which included
> splitting out that change that removes the timer. You commented on this
> in the last revision. I have put this commit last because it's not
> strictly required yet. It is a change that is included on our own fork,
> and will be needed when we add the rest of the clock handling from our
> fork. For now though, you can take or leave it as you see fit. I'm happy
> for this patch set to merge with or without it.
>
> I think I fixed all the other comments too, sorry if I missed anything.
> Thanks,
> Lex.
>
>
> -----
> Lex Bailey (they/them)
> lowRISC C.I.C. 7 Hills Road, Cambridge, CB2 1GE, UK. Registered in
> England & Wales 09272283 lex.bailey@lowrisc.org
>
> Lex Bailey (10):
>   Rename ibex_uart to ot_uart
>   ot_uart: move to new reset API
>   ot_uart: update register defs, switch to Fifo8 for tx/rx buffers
>   ot_uart: replace individual IRQ fields with array, add missing IRQs
>   ot_uart: gather similar behaviours togeter in register read and write
>   ot_uart: implement RX fifo and loopback
>   ot_uart: handle break condition
>   ot_uart: update file headers with new authorship and documentation URL
>   ot_uart: add tracing
>   ot_uart: switch from clock driven transmission to reg R/W driven
>     transmission
>
>  MAINTAINERS                  |   1 +
>  hw/char/Kconfig              |   3 +
>  hw/char/ibex_uart.c          | 569 --------------------------
>  hw/char/meson.build          |   2 +-
>  hw/char/ot_uart.c            | 759 +++++++++++++++++++++++++++++++++++
>  hw/char/trace-events         |   8 +
>  hw/riscv/Kconfig             |   1 +
>  hw/riscv/opentitan.c         |   3 +-
>  include/hw/char/ibex_uart.h  |  73 ----
>  include/hw/char/ot_uart.h    |  61 +++
>  include/hw/riscv/opentitan.h |   4 +-
>  11 files changed, 838 insertions(+), 646 deletions(-)
>  delete mode 100644 hw/char/ibex_uart.c
>  create mode 100644 hw/char/ot_uart.c
>  delete mode 100644 include/hw/char/ibex_uart.h
>  create mode 100644 include/hw/char/ot_uart.h
>
> --
> 2.49.1
>

