Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68B1DCAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 05:55:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6N8F-0006mQ-2O; Wed, 08 Oct 2025 01:54:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1v6N8B-0006kv-K8
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 01:54:31 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1v6N88-00089X-Ft
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 01:54:31 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-b00a9989633so127758566b.0
 for <qemu-devel@nongnu.org>; Tue, 07 Oct 2025 22:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1759902865; x=1760507665; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=30SYGnV6rr/1DL2FwcNm4Ept28ZlcKuTF/L766rGHFI=;
 b=DVrC7el6J4/vZiQEvKsj4UFCZ+NoXearKqKgdQNCW3BlMLXYd/E26JJw5k31jJhQFx
 m/TOJmJZjntGPJd/XR3dJlLz27ycudMtAubC5mS9xTMNIqw/ZsNRM2TNI/higyJe6Dfk
 MojGDqJDQgf1yQ7KBeqnXEhsbh7mpsKoLWb0nDN0ZFoDfSQ2QMDXqUmaYSvF9yzfXZpY
 7JJ8ARRhYq05OfXnnJKHk9EEmdWciGI65Nw76lQlkQ2f/KhH4cdr2OuJmMj+xYso5fXN
 WGj1cTo3yIehYzil8WNw2K6j+9hiQXF7Xm7+vTl5aWoEu/n8bECnofUj/Yh517/Vij+8
 21Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759902865; x=1760507665;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=30SYGnV6rr/1DL2FwcNm4Ept28ZlcKuTF/L766rGHFI=;
 b=w/KHd+/c3MyeEko8aTX2nCvvEv7yl1iDnRItip7R8R8BFC923wZ1BoXUCpvANg48Cg
 QN6OAZejLq/oo+Q8RpaufZABHBYKKa+WKtdU9s9zkZRcrOJlbBqlw1QTzpGJ3cg3taSJ
 stS+AQ6aR+e16Soj3Fmpt9G4e+0czfMPWHGRQG6WtqecQJwCxwBkzS7isyJBbaB1Ft78
 tY98P+d8PZhnL5x2Rj5wCRZysOZ1vg1RLVvixcrFBSo2S5rsg18aGeDbJVlXg8NfT1Ci
 2/AuEDyXEvD7ztKFgTKDBJ0HvP65C32ovmczdBqnTEz6/d7Ubdw6QmufJq3nhJgTxn8Q
 ODVQ==
X-Gm-Message-State: AOJu0YxT2PG5m5y6RKXiNHJ3RY0OTQQW+opV8qVUNaMS9y3iAILEV00Y
 yT1cw8jEoojeUkikl0cl+BoXa8wAG6punFzdmFmffgiKqNpovHNcAkXV0+DyTjbzNVauVL6KKrK
 5At77tQs9pQJ7Q0p5KyFGwqA/1NX0lhECxX7vBQ8BzQ==
X-Gm-Gg: ASbGnctgRDBKnrKidwkBmMBoxxi2xX8Get+lHdP7Ocv5dwxevNBHHRLhE2u8etycdYA
 22ra68RRP40bR6lPbrAgSTa7hG8Vg86GhFySeaW5+9DaBXQNBqfBimiFSa7SfcnLbPLXuID00Uj
 23Ixor5WAxFR5EaumBA8g+dIq9oMO+Oqqom1lHQ/UovkIzjWvfiKvYbnlfAoJbFymEg+J6si8Pf
 8NSCZ8iAsl5zUlFt2d5T8kR/uJye27JBw==
X-Google-Smtp-Source: AGHT+IHq238jjnkUrgXpZJB21i4vG9d3o98D3ZVjosrTpyjY8/c9jFJj9R1GE9Y+c/NzhvFDYneVDd7Ycx6Ty2dxPqA=
X-Received: by 2002:a17:906:f5a1:b0:b04:4579:486e with SMTP id
 a640c23a62f3a-b50bf3b6a8dmr231272066b.28.1759902865053; Tue, 07 Oct 2025
 22:54:25 -0700 (PDT)
MIME-Version: 1.0
References: <20250417105249.18232-1-jim.shu@sifive.com>
 <20250417105249.18232-5-jim.shu@sifive.com>
 <e7616702-8a7b-4617-8433-236a1086bdf9@ventanamicro.com>
In-Reply-To: <e7616702-8a7b-4617-8433-236a1086bdf9@ventanamicro.com>
From: Jim Shu <jim.shu@sifive.com>
Date: Wed, 8 Oct 2025 13:54:13 +0800
X-Gm-Features: AS18NWBJVu2NutkZWnh3GOjCOa3Vh0xHFfuTBSBZ6i7s45ARSPIeq5gy40E8jDA
Message-ID: <CALw707rstv76_oESKHzbeuPakSesWNBXogQoCJN4pHMj_wz7eg@mail.gmail.com>
Subject: Re: [PATCH v2 04/18] exec: Add RISC-V WorldGuard WID to MemTxAttrs
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Michael Rolnik <mrolnik@gmail.com>, 
 Helge Deller <deller@gmx.de>, Song Gao <gaosong@loongson.cn>,
 Laurent Vivier <laurent@vivier.eu>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Aleksandar Rikalo <arikalo@gmail.com>, 
 Stafford Horne <shorne@gmail.com>, Nicholas Piggin <npiggin@gmail.com>, 
 Ilya Leoshkevich <iii@linux.ibm.com>, Thomas Huth <thuth@redhat.com>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>, 
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Max Filippov <jcmvbkbc@gmail.com>, 
 "open list:PowerPC TCG CPUs" <qemu-ppc@nongnu.org>,
 "open list:S390 TCG CPUs" <qemu-s390x@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=jim.shu@sifive.com; helo=mail-ej1-x634.google.com
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

Hi Daniel,

Both '_reserved1' and '_reserved2' fields are only for padding
MemTxAttrs struct to be 8-byte [1], so I remove a 1-byte reserved
field when adding 'world_id' field to it.
Is it ok for you? Or you think it is better to separate them.


[1]
commit 5014e33b1e00d330f13df33c09a3932ac88f8d94
Link: https://lore.kernel.org/r/20250121151322.171832-2-zhao1.liu@intel.com

Thanks!

On Sat, Aug 9, 2025 at 8:34=E2=80=AFPM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
>
>
> On 4/17/25 7:52 AM, Jim Shu wrote:
> > RISC-V WorldGuard will add 5-bit world_id (WID) to the each memory
> > transaction on the bus. The wgChecker in front of RAM or peripherals
> > MMIO could do the access control based on the WID. It is similar to ARM
> > TrustZone NS bit, but the WID is 5-bit.
> >
> > The common implementation of WID is AXI4 AxUSER signal.
> >
> > Signed-off-by: Jim Shu <jim.shu@sifive.com>
> > ---
> >   include/exec/memattrs.h | 8 ++++++--
> >   1 file changed, 6 insertions(+), 2 deletions(-)
> >
> > diff --git a/include/exec/memattrs.h b/include/exec/memattrs.h
> > index 8db1d30464..7a6866fa41 100644
> > --- a/include/exec/memattrs.h
> > +++ b/include/exec/memattrs.h
> > @@ -54,6 +54,11 @@ typedef struct MemTxAttrs {
> >        */
> >       unsigned int pid:8;
> >
> > +    /*
> > +     * RISC-V WorldGuard: the 5-bit WID field of memory access.
> > +     */
> > +    unsigned int world_id:5;
> > +
> >       /*
> >        * Bus masters which don't specify any attributes will get this
> >        * (via the MEMTXATTRS_UNSPECIFIED constant), so that we can
> > @@ -63,8 +68,7 @@ typedef struct MemTxAttrs {
> >        */
> >       bool unspecified;
> >
> > -    uint8_t _reserved1;
> > -    uint16_t _reserved2;
> > +    uint16_t _reserved1;
>
> Is 'reserved2' unused? Not sure why you ended up removing it in this patc=
h.
>
> If it's really unused it's ok to remove it but this should be done in sep=
arate.
>
>
> Thanks,
>
> Daniel
>
>
> >   } MemTxAttrs;
> >
> >   QEMU_BUILD_BUG_ON(sizeof(MemTxAttrs) > 8);
>

