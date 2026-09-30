Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBF89CA5FC1
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 18:17:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xByrW-0001RV-Ga; Wed, 30 Sep 2026 14:17:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <asrinivasan@tenstorrent.com>)
 id 1xByrU-0001R5-3y
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 14:17:00 -0400
Received: from mail-yx2-x11.google.com ([2607:f8b0:4864:41::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <asrinivasan@tenstorrent.com>)
 id 1xByrS-0003zj-BX
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 14:16:59 -0400
Received: by mail-yx2-x11.google.com with SMTP id
 956f58d0204a3-66e4aa8d882so6504249d50.0
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 11:16:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790792215; cv=none;
 d=google.com; s=arc-20260327;
 b=cEvw2xcDm2U8PjnrRhtp9CQ5DDaSEDuzqi8iG3OZ+87yoLwZZNS5JpYmMd0Vamom3C
 h4VXWT05u2w8F/44P+KlMuxPv4CzWKx/k4yF8VcHtrtCDVZBAytf5ESKptKVMmJYCPnE
 G6Tfu3Db8MBza5VE/CYnslo1z5umDIptArWNd5nMAuIA/f4+XCUCHdHqnMqDX7urT+3O
 bsgmTOWKNJMgKVtyuqso62nOLVxa0KgstQAtZqYZ9RWQvhucQVoeFNx+rsQ6BOgPcs7+
 n00r3kn40F6TTSDrAma3NNCQN7NqdRm2Y29DpTNAoIT5JB+fof+8QUgujmG+Sr3zep2a
 V/xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=MtbdXEpG8DpaQ+xxNi+ilmVVIet5CY6WzvlJ0BSki0w=;
 fh=T7GZKU3pqGfZDaVHTkyCxWlgssTqcxXKF3+qSko7WPo=;
 b=LPizgwY8DLLqd0Jtq/hMTynoUk/9ItMNrc9FCBL0H00lXiHhJ1cQEM9SaPk994JXKy
 KbFkoolxp6OBkYtOC18MEqzeW/FxLBLk9avwsCOOKLxBeQBfmta9AVEoO9o+7d5AIfdt
 ixpEGJkHyURzVvog9ip9lINYmCKERgyQs4guwkI5+ShrgxObgKBKx+j/3dwMl87KUGLV
 9BGS3S+LMJ/Rt+DlixAEbUCwPFn1gh2vB1pafkQBKl0QCDXHrS+Vbb9hfukutul4akmH
 crKXt4jo5DIK4cjI3y/4fyNiBga8sbizlzgQF9jeo6ghhg2h9hH+DsrOiJ5LnXwAfMx+
 IH6A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tenstorrent.com; s=google; t=1790792215; x=1791397015; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=MtbdXEpG8DpaQ+xxNi+ilmVVIet5CY6WzvlJ0BSki0w=;
 b=O472e8n1m3IirnpuBVAE5KQLFWlkqAoQVsW7wCg4+4J/5KbatOcumGJiMO5KJcQnxu
 EBMqUsb7in9MoAA5L37j+Rum2nUH11ECno0R1ysmT8JE4dhV8OfGYkWyn9WIZOY8rG03
 l1CYvSp7bH2L5wiA+kTvkl/yNePr629I+HI0kfpe8LvzWYo3eRg80Q8BsdTMZh+peNIh
 tsJz7lPko9kos0tGJixKv3xNwUYFySg0mPkQDzViHYZOJW0gRVQAtVbS51XNOpYBuaif
 ZP6GSXAxQbN/DNI/JK9Q5V/I8U0FlJahBd3HEK7lwJKH6UASutEC0mk+bbyKXsFhoeit
 5KGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790792215; x=1791397015;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=MtbdXEpG8DpaQ+xxNi+ilmVVIet5CY6WzvlJ0BSki0w=;
 b=uluxYvszemKj8LOlKTdCIPew1ct9Oec3tQ1ZuAGBrlodKr79PHO+ZznKimY/i3dYDl
 jyJ8cKOjWaRgHA0l/RMg3SXnc/9GSYOf0EcfO7g62Ntqt/DRVSk1+tPn6F4MVdgX/ank
 qa/tWRBLH4TB6+Kvg8wOBTrSBCQpUH0yuhiBWdkxtrdyA4SWBd9gEPLpPYyIyrGNUVTK
 h3aiLoIORSFlsFEaalmXlzmbOPEvxsYjKn+2mUWa8hRAwfqW96Diw+9T/jFRsRFPMW14
 3rWRPLLLTOPzB9DQq4gFtBCmlXn/xzBZxQNrt/a1b4Cw3GZ04wLWNoiUViZRxrLA3fGE
 Aldg==
X-Gm-Message-State: AFq9FYI7Hp9Koh8u0dMGWACsshi/8kYcT/8zKiyQ/SScZD1W54lg1G0d
 t9r5jElCff2dUvOV4ujSO+3/EPnlP7qgyFUfw230rYyI9Sj8dAHCwWW/8EMl/Xkyl20Y+6AxM17
 HOwWRP61Irv6lvKwU7t0rN0q745fRrg5VLNSkC+r1mA==
X-Gm-Gg: AYBFou3wnj6vtwsKJwBadjcd7SdO0+ICoOPQs85O0c12TUoT2HAS1rJxvVM51vqa8SD
 ig/fZCX992wAjfxGqFHRjklPrkJUPpBmOuLuFG1Ei00LehNdKR0aTSiU9SmkxYriw3VM0anQXtZ
 LMrgJrKpsqY96nQ3Odnknfy0Pz5fPkJBWRKO8jseDWF3d76ou8PbX0g4F8P3IluFEo6O2MkPqiM
 +Fxi1qhWqWZ7i1+QST6eS2U2GhVno48JceRZz1BMOFO55mVHuFjrH4I7I7GZ8rZro+rJACX7zNC
 UeMbJO6f1fRUWvh3gNO876lwAPDBauyc4N0X4PXLGBcG/v/NS973joOgIzNWw3ZfD8WEE7Rr37a
 8Ttl1c3+9Sg==
X-Received: by 2002:a05:690e:1697:b0:671:1ad6:5639 with SMTP id
 956f58d0204a3-676834acb33mr1425827d50.40.1790792215314; Wed, 30 Sep 2026
 11:16:55 -0700 (PDT)
MIME-Version: 1.0
References: <20260904-atlantis_prcm-v3-0-8bf20795a381@oss.tenstorrent.com>
 <20260904-atlantis_prcm-v3-3-8bf20795a381@oss.tenstorrent.com>
 <CACPK8Xdyg7ZsXzDTAGz6u2wSDPRSsW8mE5yu3+ze_X-Zqiju7g@mail.gmail.com>
In-Reply-To: <CACPK8Xdyg7ZsXzDTAGz6u2wSDPRSsW8mE5yu3+ze_X-Zqiju7g@mail.gmail.com>
From: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
Date: Wed, 30 Sep 2026 13:16:43 -0500
X-Gm-Features: AclHuK8HCsY0u4is9O7VVlqWlONufxyxdQXW1fXvR1Udje6JaPg-oEHtZNM_2jg
Message-ID: <CAEev2e-jEBr_HE0gRmmBfYqsaf6LuLxK-d+6brD_Zm4CBm21hw@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] hw/riscv/tt-atlantis: Update UART and I2C to use
 clk from PRCM
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
Received-SPF: pass client-ip=2607:f8b0:4864:41::11;
 envelope-from=asrinivasan@tenstorrent.com; helo=mail-yx2-x11.google.com
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

On Wed, Sep 30, 2026 at 2:07=E2=80=AFAM Joel Stanley <joel@jms.id.au> wrote=
:
>
> On Sat, 5 Sept 2026 at 00:18, Anirudh Srinivasan
> <asrinivasan@oss.tenstorrent.com> wrote:
> > @@ -265,7 +265,8 @@ static void create_fdt_cpu(void *fdt, TTAtlantisSoC=
State *s,
> >  }
> >
> >  static void create_fdt_uart(void *fdt, const MemMapEntry *mem, int irq=
,
> > -                            int irqchip_phandle)
> > +                            int irqchip_phandle, uint32_t clk_parent_p=
handle,
> > +                            uint32_t clk_phandle)
> >  {
> >      g_autofree char *name =3D g_strdup_printf("/soc/serial@%"HWADDR_PR=
IX,
> >                                              mem->base);
> > @@ -275,7 +276,8 @@ static void create_fdt_uart(void *fdt, const MemMap=
Entry *mem, int irq,
> >      qemu_fdt_setprop_sized_cells(fdt, name, "reg", 2, mem->base, 2, me=
m->size);
> >      qemu_fdt_setprop_cell(fdt, name, "reg-shift", 2);
> >      qemu_fdt_setprop_cell(fdt, name, "reg-io-width", 4);
> > -    qemu_fdt_setprop_cell(fdt, name, "clock-frequency", 3686400);
>
> The downside of this is we no longer boot with a Linux build that
> lacks the PRCM driver, like the old build that is used for functional
> testing in the tree.
>
> I suggest we keep clock-frequency along side the clocks node. New
> kernels with the PRCM driver use the clock phandle and calculate the
> clock. Old kernels keep booting.
>
> The other option is to drop this patch entirely for now, and revisit
> later. I'd prefer keeping clock-frequency along side.

Will add clock-frequency back.

>
> > +    qemu_fdt_setprop_cells(fdt, name, "clocks", clk_parent_phandle,
> > +                           clk_phandle);
> >      qemu_fdt_setprop_cell(fdt, name, "interrupt-parent", irqchip_phand=
le);
> >      qemu_fdt_setprop_cells(fdt, name, "interrupts", irq, 0x4);
>
> > @@ -314,8 +318,8 @@ static void create_fdt_i2c(void *fdt, const MemMapE=
ntry *mem, uint32_t irq,
> >      qemu_fdt_setprop_sized_cells(fdt, name, "reg", 2, mem->base, 2, me=
m->size);
> >      qemu_fdt_setprop_cell(fdt, name, "interrupt-parent", irqchip_phand=
le);
> >      qemu_fdt_setprop_cells(fdt, name, "interrupts", irq, 0x4);
> > -    qemu_fdt_setprop_cell(fdt, name, "clocks", clk_phandle);
> > -    qemu_fdt_setprop_cell(fdt, name, "clock-frequency", 100000);
>
> This should stay, it's the bus frequency.

Okay, I thought this was a substitute/alternative to the clocks
property (similar to the UART), so I removed it. Will add it back.

>
>
>   clock-frequency:
>     description: Desired I2C bus clock frequency in Hz
>     enum: [100000, 400000, 1000000, 3400000]
>     default: 400000
>
> (or we omit it, and default to 400kHz. Your call).
>
> > +    qemu_fdt_setprop_cells(fdt, name, "clocks", clk_parent_phandle,
> > +                           clk_phandle);
>
> This looks good.
>
> >      qemu_fdt_setprop_cell(fdt, name, "#address-cells", 1);
> >      qemu_fdt_setprop_cell(fdt, name, "#size-cells", 0);
> >  }

