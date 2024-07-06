Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E4D6C2BD09
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jul 2024 10:38:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQ2nG-0001gC-PV; Sat, 06 Jul 2024 06:37:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sQ2nG-0001fg-7l
 for qemu-devel@nongnu.org; Sat, 06 Jul 2024 06:37:26 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sQ2nB-0005VD-KL
 for qemu-devel@nongnu.org; Sat, 06 Jul 2024 06:37:25 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-57cc30eaf0aso1440655a12.2
 for <qemu-devel@nongnu.org>; Sat, 06 Jul 2024 03:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720262240; x=1720867040; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jO7DcIhp8P3W4A9GauU7XoEyeM4bVuSO9a4fuZ4GKyY=;
 b=JSuZo3HXHD6gne+ww+quFyfaNTsmfcG0WOXD6hIMDGi0lV6dt19zAM7Us2Fcd8Zxmo
 6jjrxmrbMEVtnQjaLfPnw3W7vxA7W9vq/Vm07jp9KoAFuks77sihz16p7CAISjZdAcaO
 XhZEprVjLSgYCovE2sO9cpLBpBqNFyoGhj+DqFekkrbR2g3FmVi9iWA2ivuSRBP1SGLC
 Vq8IdCXU+ZhB+e+P+BicfH3bTeFH2cwr67VM9I1L5SnVlQMUxqoVwvUSto6K3+9Ph3a3
 CaigCfAI9KgcVtsdy2kj9TYd+MYqRTI09SH0/AJa8GJjMhkbrP7/S2DKzDB6G4XXwzNy
 vTTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720262240; x=1720867040;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jO7DcIhp8P3W4A9GauU7XoEyeM4bVuSO9a4fuZ4GKyY=;
 b=pNMMHZ2qQKmWBqZWVsZwYHUTZRol3PiAgL5xk3B/t7MappZiM4RpaGa6IuN5G4CdUW
 GV0DhilCxaJp4rsoPC0F9/l/4n3XfnTrinXyIuW7FAKjmkM+bgaM/csa7ALwXIiMmqIp
 VCbvXFXKKnrmWxyyOCqEkjpRClWffWSQwdTKhR7Vd03pSBUQiPEt8tXaiwoJiFAiuw/8
 Ozk05U5mih303BPb2M8sEx0k1z1XJSIDs0/L1jV1mk56Zipt69CWpwK99yrbqU9byb3J
 BljrPgA9fb7seJR3auCvJmO1zlOtgl1/n3MkoHsAmSSS/JvBvqpN6fWmp/AzKzlZMW8c
 SMiA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWUo2dtVi/VIipuPR9a4Lyu66fu4lN7IETNuWbsWXnfFUBs8z69vvfJ49ntSR1TrrefLHuhEXqvx+SwqKJ+UowsNeunJ4g=
X-Gm-Message-State: AOJu0YxQ0sjLW3EiJU7geJMzr4Lzq6Tt25DIIh/yS8bh28HKvnqhdZ4B
 Al9GGIblZY/z+CO2SZTYlYmyTHc681rG6SQm4OBYmi4FXPDVks4fFG2Xfmiqg82DmBC8bagQEOc
 HC86RZl0rKyTY3So6ThdCewRwZF6vvDhY6wHHOQ==
X-Google-Smtp-Source: AGHT+IEM6EhVPQWW/Bu5/ZBxJjhyIt6G2UvJRo0YwCyYjUiSuXHVcVUy0W6yueEJk8SoGJYPhBrReiULrrPRzSSJmm4=
X-Received: by 2002:a05:6402:5ce:b0:587:2dd1:4b6c with SMTP id
 4fb4d7f45d1cf-58e5b898deemr6577488a12.30.1720262239550; Sat, 06 Jul 2024
 03:37:19 -0700 (PDT)
MIME-Version: 1.0
References: <20240627-san-v2-0-750bb0946dbd@daynix.com>
 <20240627-san-v2-6-750bb0946dbd@daynix.com>
 <CAFEAcA-Zmc0BQgUiqEgzCvVGWyiPt9bo+Xt90n4wxhJ3_D91fA@mail.gmail.com>
 <Zn98p6CUV0KnIo50@zatzit>
 <CAFEAcA_LN8i66KUkxrgg=CUKJNYM=s9pTYv6w5QQ7PSU1Q3=bg@mail.gmail.com>
 <D2H7KBZF8OA4.3EKIA8NHHJ3MJ@gmail.com> <ZodPOTAcLo1XF4MB@zatzit>
 <D2HBUN5N504E.27WH86Z4HPTKW@gmail.com> <ZoeAutfGIAaNEFBC@zatzit>
In-Reply-To: <ZoeAutfGIAaNEFBC@zatzit>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 6 Jul 2024 11:37:08 +0100
Message-ID: <CAFEAcA-QyGWNqS5saqGMc9f4WVS5mg8+YjUfOczovaT6duZAvQ@mail.gmail.com>
Subject: Re: [PATCH v2 06/15] ppc/vof: Fix unaligned FDT property access
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>, 
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Yanan Wang <wangyanan55@huawei.com>, John Snow <jsnow@redhat.com>, 
 BALATON Zoltan <balaton@eik.bme.hu>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Alexey Kardashevskiy <aik@ozlabs.ru>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, 
 qemu-devel@nongnu.org, qemu-block@nongnu.org, qemu-ppc@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Fri, 5 Jul 2024 at 06:13, David Gibson <david@gibson.dropbear.id.au> wrote:
>
> On Fri, Jul 05, 2024 at 02:40:19PM +1000, Nicholas Piggin wrote:
> > On Fri Jul 5, 2024 at 11:41 AM AEST, David Gibson wrote:
> > > On Fri, Jul 05, 2024 at 11:18:47AM +1000, Nicholas Piggin wrote:
> > > > On Thu Jul 4, 2024 at 10:15 PM AEST, Peter Maydell wrote:
> > > > > On Sat, 29 Jun 2024 at 04:17, David Gibson <david@gibson.dropbear.id.au> wrote:
> > > > > >
> > > > > > On Fri, Jun 28, 2024 at 04:20:02PM +0100, Peter Maydell wrote:
> > > > > > > On Thu, 27 Jun 2024 at 14:39, Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
> > > > > > > >
> > > > > > > > FDT properties are aligned by 4 bytes, not 8 bytes.
> > > > > > > >
> > > > > > > > Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> > > > > > > > ---
> > > > > > > >  hw/ppc/vof.c | 2 +-
> > > > > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > > > >
> > > > > > > > diff --git a/hw/ppc/vof.c b/hw/ppc/vof.c
> > > > > > > > index e3b430a81f4f..b5b6514d79fc 100644
> > > > > > > > --- a/hw/ppc/vof.c
> > > > > > > > +++ b/hw/ppc/vof.c
> > > > > > > > @@ -646,7 +646,7 @@ static void vof_dt_memory_available(void *fdt, GArray *claimed, uint64_t base)
> > > > > > > >      mem0_reg = fdt_getprop(fdt, offset, "reg", &proplen);
> > > > > > > >      g_assert(mem0_reg && proplen == sizeof(uint32_t) * (ac + sc));
> > > > > > > >      if (sc == 2) {
> > > > > > > > -        mem0_end = be64_to_cpu(*(uint64_t *)(mem0_reg + sizeof(uint32_t) * ac));
> > > > > > > > +        mem0_end = ldq_be_p(mem0_reg + sizeof(uint32_t) * ac);
> > > > > > > >      } else {
> > > > > > > >          mem0_end = be32_to_cpu(*(uint32_t *)(mem0_reg + sizeof(uint32_t) * ac));
> > > > > > > >      }
> > > > > > >
> > > > > > > I did wonder if there was a better way to do what this is doing,
> > > > > > > but neither we (in system/device_tree.c) nor libfdt seem to
> > > > > > > provide one.
> > > > > >
> > > > > > libfdt does provide unaligned access helpers (fdt32_ld() etc.), but
> > > > > > not an automatic aligned-or-unaligned helper.   Maybe we should add that?
> > > > >
> > > > > fdt32_ld() and friends only do the "load from this bit of memory"
> > > > > part, which we already have QEMU utility functions for (and which
> > > > > are this patch uses).
> > > > >
> > > > > This particular bit of code is dealing with an fdt property ("memory")
> > > > > that is an array of (address, size) tuples where address and size
> > > > > can independently be either 32 or 64 bits, and it wants the
> > > > > size value of tuple 0. So the missing functionality is something at
> > > > > a higher level than fdt32_ld() which would let you say "give me
> > > > > tuple N field X" with some way to specify the tuple layout. (Which
> > > > > is an awkward kind of API to write in C.)
> > > > >
> > > > > Slightly less general, but for this case we could perhaps have
> > > > > something like the getprop equivalent of qemu_fdt_setprop_sized_cells():
> > > > >
> > > > >   uint64_t value_array[2];
> > > > >   qemu_fdt_getprop_sized_cells(fdt, nodename, "memory", &value_array,
> > > > >                                ac, sc);
> > > > >   /*
> > > > >    * fills in value_array[0] with address, value_array[1] with size,
> > > > >    * probably barfs if the varargs-list of cell-sizes doesn't
> > > > >    * cover the whole property, similar to the current assert on
> > > > >    * proplen.
> > > > >    */
> > > > >   mem0_end = value_array[0];
> > > >
> > > > Since 4/8 byte cells are most common and size is probably
> > > > normally known, what about something simpler to start with?
> > >
> > > Hrm, I don't think this helps much.  As Peter points out the actual
> > > load isn't really the issue, it's locating the right spot for it.
> >
> > I don't really see why that's a problem, it's just a pointer
> > addition - base + fdt_address_cells * 4. The problem was in
>
> This is harder if #address-cells and #size-cells are different, or if
> you're parsing ranges and #address-cells is different between parent
> and child node.
>
> > the memory access (yes it's fixed with the patch but you could
> > add a general libfdt way to do it).
>
> Huh.. well I'm getting different impressions of what the problem
> actually is from what I initially read versus Peter Maydell's
> comments, so I don't really know what to think.
>
> If it's just the load then fdt32_ld() etc. already exist.  Or is it
> really such a hot path that unconditionally handling unaligned
> accesses isn't tenable?

The specific problem here is that the code as written tries to
cast a not-aligned-enough pointer to uint64_t* to do the load,
which is UB. The patch submitted fixes that, and personally I
think it would be entirely fine to say that's all we need to do here.

*If* we want to look at the broader question of "why is this
code that's reading something out of an fdt having to do the
pretty low-level action of getting the start address of the
fdt property and then doing pointer arithmetic and then fishing
a value out of it as a 64-bit unaligned load?" then we get into
"do we want to provide a helper function that lets the caller
say 'give me element X from tuple Y'?". But that seems like a
lot of effort for what's basically a single callsite we would
be tidying up...

thanks
-- PMM

