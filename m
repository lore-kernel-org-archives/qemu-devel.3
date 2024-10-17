Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A95E5D2F7E5
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2024 04:38:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1IGM-0001wb-Ck; Thu, 17 Oct 2024 00:37:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t1IGJ-0001w0-Bm; Thu, 17 Oct 2024 00:37:23 -0400
Received: from mail-ua1-x92f.google.com ([2607:f8b0:4864:20::92f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t1IGH-0005Ew-Gf; Thu, 17 Oct 2024 00:37:22 -0400
Received: by mail-ua1-x92f.google.com with SMTP id
 a1e0cc1a2514c-85019a60523so185848241.1; 
 Wed, 16 Oct 2024 21:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729139840; x=1729744640; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PM0x8O7RZaLDKopDysbc7AcphoVmmWbHmQ/0ADR9soo=;
 b=j1TOhIcZrRmKMc8dzgBt8DKhr548Ed4aoHxKxiaS+L6Y9PzVT2ulPLcbkZXuSAI3s8
 FkaElec/EGAlgyDH8mAV7paeAwPN/bWXF/jZjG+RW/VED9EkzgBXitoYodXHdOcGtVSf
 BQgFNfNbQmibDgAN+TS6szH2ytSn6M6o3BIM879zsnJUioqbX9TQhOtP1Zv5pZ0tsQct
 6y+OBDK2GBlXKjUaH0msx+bXZ+g0N4Wu/bPkt5r1jcLwWKR0Nkti3/SYg16GT6Wim9vE
 Sfked8zTNXnZZhHN42WKWEYap1K+LpgMVID4G1bQJts6HrGrx7FKg5xRNtfHxQ4xm7SU
 IVng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729139840; x=1729744640;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PM0x8O7RZaLDKopDysbc7AcphoVmmWbHmQ/0ADR9soo=;
 b=hbPjYIsOdfizVItpnrXA/VwKpXx5Ur6EQidxQ2e8iPd+ClxVlkBwhhJGzKfFFUKOtb
 LZbrGqzNrP86lHosZF77KxkS6ZPWZ+mfEPAjQAw2SjNyRbTEv/jogxBi099/d9dXa1px
 RjBaEcXNJmPPl670c2ScPzG8zmBcZ3m/tb9vfelur5uVK2j10yqVu34PEiN1Pzm2/Fdo
 fDPvdHrqo4vehAOH2cjlkFwW4IABD6RaWIihksNL716GkLFHIYzFIGnkUG5D2G18yEPM
 SGqRtnwliP6SkJjFpeSDTsDEtUcNLeRBjalPJf2kiOE/ZZYgiBVKRle7vaBc2bEeLz3G
 /yOw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU57+eXCGB7O36nF+mslFwteLWKuK0iifZZlsYjdpQl8rFfJUmwjqoX9yCgEAuHNn/SaJiLSuNgZ1M+Jw==@nongnu.org,
 AJvYcCUw2ZyN7M5fXON9uT4r9/ZvjutegVN/SC/4n2n6VkWD5p/hvogkfva8FafH5gW+9oJ1YwfYCCKxYIPK@nongnu.org
X-Gm-Message-State: AOJu0YyTrYeotC7DkGazgXJKnh7kzTFWJd9J77k6APJX63lhb4fddgTT
 AtTf+GqyYkgtVsjOTugC8zrdt+eglQMS3B3DyfRb2TMUfVYae52GWWbQJwJew+OWIi9RDQTyjGM
 Sce9eJA4uKtO4GTdi9YcAwW1r6oA=
X-Google-Smtp-Source: AGHT+IHiiQSITe3FxNEdlWNdH/PKP8TgfEDP6XYZKGVNQEvLlzumHu1yqFUifIwcOsX1kOpfHhwWafOdinVY8pAITRU=
X-Received: by 2002:a05:6102:a48:b0:4a3:ad8f:4fd9 with SMTP id
 ada2fe7eead31-4a5b5a70714mr5228894137.29.1729139839877; Wed, 16 Oct 2024
 21:37:19 -0700 (PDT)
MIME-Version: 1.0
References: <20240925115808.77874-1-cleger@rivosinc.com>
 <20240925115808.77874-3-cleger@rivosinc.com>
 <CAKmqyKPrHtsjAnc8kX__BeHvxoMvm+MmYLWSgh5TKdx0FE8o9A@mail.gmail.com>
 <Zwlz8LUEGB4Fa611@ved-XPS-8940>
In-Reply-To: <Zwlz8LUEGB4Fa611@ved-XPS-8940>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 17 Oct 2024 14:36:54 +1000
Message-ID: <CAKmqyKMtJK_2yoUoudVoZorW=A5fX=m5RvG_vvHNHj45nQy_hw@mail.gmail.com>
Subject: Re: [PATCH v2 2/8] target/riscv: Implement Ssdbltrp sret, mret and
 mnret behavior
To: Ved Shanbhogue <ved@rivosinc.com>
Cc: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>, 
 qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bin.meng@windriver.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Atish Patra <atishp@rivosinc.com>, 
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::92f;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x92f.google.com
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

On Sat, Oct 12, 2024 at 4:52=E2=80=AFAM Ved Shanbhogue <ved@rivosinc.com> w=
rote:
>
> Alistair Francis wrote:
> >> When the Ssdbltrp extension is enabled, SSTATUS.SDT field is cleared
> >> when executing sret. When executing mret/mnret, SSTATUS.SDT is cleared
> >> when returning to U, VS or VU and VSSTATUS.SDT is cleared when returni=
ng
> >> to VU from HS.
> >
> >I don't see mret being mentioned in the spec. Where do you see that
> >V/SSTATUS.SDT should be cleared?
> >
>
> Ssdbltrp specifies:
>     In S-mode, the SRET instruction sets sstatus.SDT to 0,
>     and if the new privilege mode is VU, it also sets
>     vsstatus.SDT to 0. However, in VS-mode, only vsstatus.SDT
>     is set to to 0.

I cannot find this

$ git show --shortstat
commit ef2ec9dc9afd003d0dab6d5ca36db59864c8483c (HEAD -> main, tag:
riscv-isa-release-ef2ec9d-2024-10-16, origin/main)
Author: Andrew Waterman <andrew@sifive.com>
Date:   Wed Oct 16 12:09:41 2024 -0700

   Remove future tense from description of now-ratified text (#1685)

2 files changed, 8 insertions(+), 15 deletions(-)

$ grep -r sstatus.SDT | grep SRET
src/hypervisor.adoc:if the new privilege mode is VU, the `SRET`
instruction sets `vsstatus.SDT`

What am I missing here?

Alistair

>
>     The MRET instructions sets sstatus.SDT to 0, if the new
>     privilege mode is U, VS, or VU. Additionally, if it is
>     VU, then vsstatus.SDT is also set to 0.
>
> Smdbltrp specifies:
>     The MRET and SRET instructions, when executed in M-mode,
>     set the MDT bit to 0. If the new privilege mode is U, VS,
>     or VU, then sstatus.SDT is also set to 0. Additionally,
>     if it is VU, then vsstatus.SDT is also set to 0.
>
>     The MNRET instruction sets the MDT bit to 0 if the new
>     privilege mode is not M. If it is U, VS, or VU, then
>     sstatus.SDT is also set to 0. Additionally, if it is VU,
>     then vsstatus.SDT is also set to 0.
>
> regards
> ved

