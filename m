Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0CD5C369D9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 11:29:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uA5c3-0008WF-7Y; Wed, 30 Apr 2025 07:28:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1uA5by-0008Vi-PD; Wed, 30 Apr 2025 07:28:22 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1uA5bv-00029v-Ol; Wed, 30 Apr 2025 07:28:22 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5e8be1c6ff8so2236501a12.1; 
 Wed, 30 Apr 2025 04:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=jms.id.au; s=google; t=1746012494; x=1746617294; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=LVa3YGDj/E1kBeDxbPLDNCVCnHYwLw/UNBTD+VzzjLs=;
 b=TmND7TSwXAKB0gx25AaKBUfMylYABjindaJrly8rSwK3aVfR5Ixc6bn37i5mvY93wH
 Y7HDBGlOrcHb/gwYDm8Y4mS0F2AADL+PAfnQFKXHYjBbIcQvoJ0LUjPOzQ2u+P9Q4GVH
 5hke3GL9I6Lae+EfLZyDXj5WZGl0YI7+3TJ90=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746012494; x=1746617294;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LVa3YGDj/E1kBeDxbPLDNCVCnHYwLw/UNBTD+VzzjLs=;
 b=HtM7jRuw2jX1vWNvlW43/GEPQeMEtK6XJ9+agHLkfNLzqoybTjuBhyT+ogIg23z9hG
 Op3gXDgLOkHagm7Z+HR/xPKajDS/dXrJE8QnY6TTkzA//czIYvbvQQD5INzadDZjfm0B
 Ab2padalOfmiGZfVF8lQFRC5YTRGHO3W/VjnW+jyXPgvKA8VT0L4lA11uHBv99lfnFRB
 mpdprYBCjju8DEBnd0aZwXGuJRSAbccs+5ZdaRxz3eSu6HfK4PuB61RNPOso0fehx6QI
 /clPJAgBQyfCXx797AeiTPN9nc/4VbrW32hlyzkM3kCNKcFjNyChbtcaPRmd7IbDvSiA
 cCMg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUOtA/rlSzDAIER9KM87T3dFlW1YinVKfaLR8QCYP3taXamwi9iH0CUYD8+vJ4JbF3AhGHCtDOOfdr/@nongnu.org
X-Gm-Message-State: AOJu0YzvOja1Mtb5l/060vUXdcWUvB1KYta9cX0h+V5knGViMzStXI/i
 GlPoFoTe3iuFUZjV62B3pLxrsmvq5Pch3E7vfOGEfe3VkR6zxpit5IECykCxj7pbuk3Vr+AYXjG
 1t3j9VPj+EvArHBlgLyZSjbd1SyQ=
X-Gm-Gg: ASbGncv3vifsoNG1A25f8xoLCz/PAgHMI4ouiuGX2yV3i8b5izw8kwf9QmaEVFlSMzc
 cIW/SxV4uJaX0D1skjilQ4IoArJX8rekLH2inp9gBuxDYxod4Udw6ALgYrQpk1Wj4GrWp5opoPr
 n5q8IkXoMsBrEfteoVinwAfA==
X-Google-Smtp-Source: AGHT+IGCOkFGd/x1CSuEIdoH2xnPAeAtcuGQ0gCVP/TtcGXH9wSeb8SKkAmArDXBWR8wgtrCCeKq4mTeH3IJf7u7VsA=
X-Received: by 2002:a17:907:6d0b:b0:ac1:df32:ac27 with SMTP id
 a640c23a62f3a-acedc79d656mr300561566b.53.1746012494213; Wed, 30 Apr 2025
 04:28:14 -0700 (PDT)
MIME-Version: 1.0
References: <20250423110630.2249904-1-dbarboza@ventanamicro.com>
 <20250423110630.2249904-10-dbarboza@ventanamicro.com>
 <CACPK8Xei9L_82YV7+wPmTacEh2MNLFticOEny_6kSM9miCAt2w@mail.gmail.com>
 <d404d535-fc04-43ac-a7a7-2f216cad993c@ventanamicro.com>
 <45b9b66d-1aa7-47da-9458-04ab726d5aae@ventanamicro.com>
In-Reply-To: <45b9b66d-1aa7-47da-9458-04ab726d5aae@ventanamicro.com>
From: Joel Stanley <joel@jms.id.au>
Date: Wed, 30 Apr 2025 20:58:00 +0930
X-Gm-Features: ATxdqUFxslx806NASeu219TBnPAq6jGGVTUJsQSzmU7_Smc9HYYofrQpmXqoxYs
Message-ID: <CACPK8Xe5Aqm-7vjTGk6rUPZp50beue6wZeH_EqTQ50TDmNkzqA@mail.gmail.com>
Subject: Re: [PATCH 9/9] hw/riscv/virt.c: remove 'long' casts in fmt strings
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=joel.stan@gmail.com; helo=mail-ed1-x532.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001,
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

On Wed, 30 Apr 2025 at 02:41, Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
>
>
> On 4/29/25 9:40 AM, Daniel Henrique Barboza wrote:
> > Joel,
> >
> > I'll make these changes in this patch to be consistent with what we've
> > been discussing:
> >
> > - change addr to hwaddr
> > - use HWADDR_PRIx instead of PRIx64
> >
> > i.e. this diff:
> >
> > diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> > index 1eae84db15..0020d8f404 100644
> > --- a/hw/riscv/virt.c
> > +++ b/hw/riscv/virt.c
> > @@ -303,12 +303,13 @@ static void create_fdt_socket_cpus(RISCVVirtState *s, int socket,
> >   static void create_fdt_socket_memory(RISCVVirtState *s, int socket)
> >   {
> >       g_autofree char *mem_name = NULL;
> > -    uint64_t addr, size;
> > +    hwaddr addr;
> > +    uint64_t size;

Size should be a hwaddr too. This would be consistent with how
MemMapEntry describes the base/size pairs.

> >       MachineState *ms = MACHINE(s);
> >
> >       addr = s->memmap[VIRT_DRAM].base + riscv_socket_mem_offset(ms, socket);
> >       size = riscv_socket_mem_size(ms, socket);
> > -    mem_name = g_strdup_printf("/memory@%"PRIx64, addr);
> > +    mem_name = g_strdup_printf("/memory@%"HWADDR_PRIx, addr);
> >       qemu_fdt_add_subnode(ms->fdt, mem_name);
> >       qemu_fdt_setprop_cells(ms->fdt, mem_name, "reg",
> >           addr >> 32, addr, size >> 32, size);
> >
> >
> > I did this change and applied your "hw/riscv/virt: device tree reg cleanups" series on top
> > of it, and there are no conflicts. No change needed in your side.
>
> It seems I was wrong. The v2 will conflict with your patch 03. I think a rebase from
> your series can't be avoided ...

If you want to pick them up as part of your series, and send them as a
big patch set then that's fine with me.

Otherwise I'll wait until we've got yours staged and send a new version out.

Thanks!

Joel

