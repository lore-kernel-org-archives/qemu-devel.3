Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAFEFCD98D2
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 23:54:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZdbL-0008S9-9E; Tue, 16 Jun 2026 19:53:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1wZdbI-0008RG-UM
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 19:53:48 -0400
Received: from mail-yw1-x1133.google.com ([2607:f8b0:4864:20::1133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1wZdbG-0006fm-AV
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 19:53:48 -0400
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-7dd3f176f84so50919967b3.0
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 16:53:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781654025; cv=none;
 d=google.com; s=arc-20240605;
 b=cyfiraarlR6N234fbjoiQNWzrE+yFFkhcw0VOvlGoY9jFKymbuBDPRQRGu0Q2P5X/E
 kLHM5Uu0B3mKfgQzsKBgGq44iTL31vDcPvfOI4tadjzcVk2czd7vzP09v0b310eeuTFu
 mw0Kvf5yJhhPvX3sOrQOL7mZGll/2kMixiShzCel+Cj19/EYpre4/+NHEzmQ6DpHzZn4
 q4Tr9s8NQd2pPb7W4AaN3xBoSG81nSJxXw7l20YbqMLdsClgFyWbGdtY2ljQbrOtBUta
 hXrjx8jv5t3ISZLM5frD6RWYp2XOfME1nGL5PLTeWbmsEu0cWpwhmZBkuwGOgzwTJZHg
 LCvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=3uyaD0H+P51kA/CNyr779LEJ13leNm6JvFsygQeaYEE=;
 fh=wTC9xWqV/VwFjaOXl+IbV7w3e8aKHG3gq+rXuyfkzaE=;
 b=Uyi0nXMi5axB+4TqQMoNUNeMV6Wzt6ouLCmHa2iqzxfscwaS7r6KasIpmMINjzVLP6
 fgqwIV2jaBGFJA0eDoD50GaspW7IfiPln96A2CGcwFVJUnj38BUHN9OUwUc/J7ocPb4F
 etsWIntDUbK48Tcz+xjYCH6b6aRFbp9XfIZETfWp684NcenOJk9A4/bZvGvDrF7ntLIe
 dZu5n3ih9GFRzO6Awxp+gNJLuMtiQ3ZJsepqUtarccICHnOombMG5gLhuVu4DgPdW9ff
 1UbWUrW52/Q+Ee3BrMaNhY65lwiGc2z4gKFRwyPo0PVir55+0aR2C1b0+1kF09ORXlDs
 GGjg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=jms.id.au; s=google; t=1781654025; x=1782258825; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3uyaD0H+P51kA/CNyr779LEJ13leNm6JvFsygQeaYEE=;
 b=ctkNPnaQpQzgh+2viHAxkCylTCuGYtDgl2XuDa/6NY+KG2qezNV7EMkxjCLbR24xFA
 xCxcd/sMwMSsX/TabFKCTHn4qzIAiHbor0AEVVjCgkPanFv8TTiCLRbBo10TGjlY4o2v
 KhRsQr25dCAk3iGMp/xs5VGU2+tf9c50uMKcg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781654025; x=1782258825;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3uyaD0H+P51kA/CNyr779LEJ13leNm6JvFsygQeaYEE=;
 b=BUIOKTu2yEsgTL+8c9oOrt/luc0zNe+bdOjGbrlQTYD2z7X5EwMP9cTPGffLtF6BhD
 iuZ25eq7je6SrrNGw6ijfiBEyugl26qji10ALnL9lsuBMCn0R0LAvM2jLz5C+rqZU7Yn
 EzY6XLFn67kTnfptmISeMugX6ADku6Li8PTSfLGghPIeDhSq9lgpSLkfPXFWUapLbiHe
 LW4fyRW/56nTA1SlYNh7zcdfLhaJ0lvslXdyRnCgTSOE4xRv66dqZqGA8Vakgc4drKw1
 5A/h0c9gll8zY30uW1IFAswLrDuwUtDHzUjtUrm0f1onfGCLsK7nlLbpXYEz0gz5MQph
 fMwQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+u/ayU1Et5ndbyxPmi3RqegkEDPEW2Fgx1fr2wTbtWmn1wrJ+A+WuSo9G9g1/H+bbMOYn32LJc9g+S@nongnu.org
X-Gm-Message-State: AOJu0YwdqIhmBVdlhjcHOBOwuH5+46gntnJziOjKqN8QRkBk2Q3LXKQr
 9GsOT5r8iW3krAJ2RILr3BviEWiJGpuZjl78WeSc0GkkNyueAtOuF02X1UtJIPf+i6azEnjIMsQ
 3kmLj5nfApbk61+H/7fxXPztMuEVVYeE=
X-Gm-Gg: AfdE7clalm63VWACYDQgc+lSZ7FAyxu78CA0UY/IZLx7v/ubiEgYO1RLXeKOt7aX3cf
 IRMMCq/mVo9vNbxhpt6OE7oz7PONecYIJniSRDf8rY9uCjIB1LVN4ZF+iM7QHfDUyUNRimHgpVq
 JUDRY0oMGQKA2weaQ8iJ2lOExpbusjJ47wZX1BJhw+GzPcsbQNSHXXWv0zj+Ad0S/NVJGMmML7V
 AypuCG9ygJex2WN+KimY9+v8p58F2d/YIFFBSojes2DCWeRVe+ajPiIl42A+uB6Nz5c+ogmSyfF
 XvPrm3sfcj7N4GEr8QwRLdiIj1Fl6OOI5Mn5aaa6UwSt/lFoAErze1kfzX/1Mm+VxJCl13K6deE
 YIOaLt5jjUt4uZ145TLBWO4k5
X-Received: by 2002:a53:c0cf:0:b0:65e:4ac9:272e with SMTP id
 956f58d0204a3-662cbd1f291mr977534d50.50.1781654024771; Tue, 16 Jun 2026
 16:53:44 -0700 (PDT)
MIME-Version: 1.0
References: <20260603065859.592063-1-joel@jms.id.au>
 <20260603065859.592063-8-joel@jms.id.au>
 <CAKmqyKP0VxQj0apsuVOrCeaP0KVHy5VfdqH-Nn9_99Vc76Ru_w@mail.gmail.com>
In-Reply-To: <CAKmqyKP0VxQj0apsuVOrCeaP0KVHy5VfdqH-Nn9_99Vc76Ru_w@mail.gmail.com>
From: Joel Stanley <joel@jms.id.au>
Date: Wed, 17 Jun 2026 09:23:33 +0930
X-Gm-Features: AVVi8CcFJ3G0RX6JPO1K2-FuV6xVNUm69iRE_OsHDmYuZfclUjLd1CAoD8fziiA
Message-ID: <CACPK8Xdow4U7qJ73BFneyzxo6U1RK1kLnY=UkdQzskY7H=oqOQ@mail.gmail.com>
Subject: Re: [PATCH v8 07/12] hw/riscv: Add Tenstorrent Atlantis machine
To: Alistair Francis <alistair23@gmail.com>
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Nicholas Piggin <npiggin@gmail.com>, 
 Andrew Jones <andrew.jones@oss.qualcomm.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, 
 Michael Ellerman <mpe@kernel.org>, Joel Stanley <jms@oss.tenstorrent.com>, 
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>, 
 Portia Stephens <portias@oss.tenstorrent.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1133;
 envelope-from=joel.stan@gmail.com; helo=mail-yw1-x1133.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Mon, 15 Jun 2026 at 15:15, Alistair Francis <alistair23@gmail.com> wrote=
:
>
> On Wed, Jun 3, 2026 at 5:04=E2=80=AFPM Joel Stanley <joel@jms.id.au> wrot=
e:

> > +static void load_fdt(TTAtlantisState *s)
> > +{
> > +    MachineState *ms =3D MACHINE(s);
> > +    char **node_path;
> > +    Error *err =3D NULL;
> > +
> > +    ms->fdt =3D load_device_tree(ms->dtb, &s->fdt_size);
> > +    if (!ms->fdt) {
> > +        error_report("load_device_tree() failed");
> > +        exit(1);
> > +    }
> > +
> > +    qemu_fdt_add_path(ms->fdt, "/chosen");
> > +
> > +    /* Clear memory nodes and update with the specified RAM size */
> > +    node_path =3D qemu_fdt_node_unit_path(ms->fdt, "memory", &err);
> > +    if (err) {
> > +        warn_report_err(err);
> > +    } else {
> > +        for (int i =3D 0; node_path[i]; i++) {
> > +            qemu_fdt_nop_node(ms->fdt, node_path[i]);
>
> Should we print a warning here to the user that we are doing this? I
> would be confused (and annoyed) if QEMU deleted my memory regions and
> I didn't know

The code is the same for the arm machines; they silently update the
device tree when provided one. I agree with you though, I will add a
warning.

I added this as in testing the device tree was larger than what the
machine had, which Linux happily tries to use and crashes during boot.
I can see the argument for not touching the device tree at all but on
balance I decided helping the user out is the right thing to do. If
users complain I'm happy to change it.

> > +static void tt_atlantis_machine_done(Notifier *notifier, void *data)
> > +{
> > +    TTAtlantisState *s =3D container_of(notifier, TTAtlantisState, mac=
hine_done);
> > +    MachineState *machine =3D MACHINE(s);
> > +    hwaddr start_addr =3D s->memmap[TT_ATL_DDR_LO].base;
> > +    hwaddr mem_size;
> > +    target_ulong firmware_end_addr, kernel_start_addr;
> > +    const char *firmware_name =3D riscv_default_firmware_name(&s->soc)=
;
> > +    uint64_t fdt_load_addr;
> > +    uint64_t kernel_entry;
> > +    RISCVBootInfo boot_info;
> > +
> > +    /*
> > +     * A user provided dtb must include everything, including
> > +     * dynamic sysbus devices. Our FDT needs to be finalized.
> > +     */
> > +    if (machine->dtb =3D=3D NULL) {
> > +        finalize_fdt(s);
>
> Was expecting a finalise here :)

Desensitized.

> > +    /* DDR */
> > +
> > +    /* The high address covers all of RAM, the low address just the fi=
rst 2GB */
> > +    lo_ram_size =3D s->memmap[TT_ATL_DDR_LO].size;
> > +    hi_ram_size =3D s->memmap[TT_ATL_DDR_HI].size;
> > +    if (machine->ram_size > hi_ram_size) {
>
> What if machine->ram_size is less then s->memmap[TT_ATL_DDR_HI].size?
> You will still allocate s->memmap[TT_ATL_DDR_HI].size instead of what
> the user asked for. You then report what the user asked for in the DT,
> so there is a bunch of wasted memory.
>
> Memory is expensive these days, we can't waste it
>
> Also, if the user asks for 2GB or less, you shouldn't create ram.high at =
all

Good catch. There's an even better bug; ram.high and ram.low are
aliases into the machine ram region and they are always sized to their
default maximum, regardless of the machine ram size.

address-space: memory
  0000000000000000-ffffffffffffffff (prio 0, container): system
    0000000000000000-000000007fffffff (prio 0, ram): alias ram.low
@tt_atlantis.ram 0000000000000000-000000007fffffff
    0000000100000000-00000010ffffffff (prio 0, ram): alias ram.high
@tt_atlantis.ram 0000000000000000-0000000fffffffff
memory-region: tt_atlantis.ram
  0000000000000000-00000000ffffffff (prio 0, ram): tt_atlantis.ram

They should be sized to the configured size.

The device tree is okay because it sets the region based on the
configured ram size, and Linux politely doesn't write outside of that.

In hardware the high region is where the ram lives and low is an alias
of the first 2GB. I'll fix up the modelling to match, and set the
sizes appropriately.

> Otherwise looks good

Thanks for the review.

Cheers,

Joel

