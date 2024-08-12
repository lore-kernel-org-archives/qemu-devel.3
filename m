Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E363C3DA7F
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2024 21:15:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdcNL-0001Ip-VZ; Mon, 12 Aug 2024 17:14:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tavip@google.com>) id 1sdcNJ-0001EJ-PA
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 17:14:45 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tavip@google.com>) id 1sdcNH-0004Hu-AX
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 17:14:45 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-369f68f63b1so2762556f8f.2
 for <qemu-devel@nongnu.org>; Mon, 12 Aug 2024 14:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1723497276; x=1724102076; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mMvb+UqDsd/Tku1WIghTxYcMI1Pxj9JCY1dloGvUNN4=;
 b=nYNhGN9/Z7xxn2cAXJ7i0VO4NmDdrFKaSwTvFyElgU9hp50iBm/42UXSRTbYZpIYtg
 FewQpiet+JvjLe12iMfdj8Gbb5JLD7uyEh7ewv29JdJxo/a1WktsbFp8YjKFUG6sNdef
 wHs/dtA5zy2XuSE8PgfczBzcA0DJDHtn+KNSMYMEmlTnJe5qtN/UIL7mfVhRg2yfR0F4
 jNri+lKK3wvUXTL1rtrjSkV0HBQR2mBke1RMfh7rtfzCTZKXazL1Yb9CbCWJmB3+oTNj
 qPQC9L8xwUYZsb7K5V20D5aw6BzwMzAMXRq4YyItsyJHgPg5uXf71C9kondbSkEepsKN
 B4Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723497276; x=1724102076;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mMvb+UqDsd/Tku1WIghTxYcMI1Pxj9JCY1dloGvUNN4=;
 b=kJL+ua7LNnmtbG6yMqQOgKIXLE5JY5AB9RsbKEI+gnfq4ePUJJZpYgwuxekPEQCP30
 IauxKlSiYYuDjFkwFBmzCm2EbySTQjLG6fNjhL8CbtXVy4KUg+NOgcrSzyRPbqNZZbvA
 7QGghkn3+dvZz7DdPwX3luU6ygZyfnjf3+G3kfFY+pk8jbhhfkSoqhWK2NxscdjOSrwA
 moVp9LaDYeH6APxzGAhY30nvFtLgs04w3GlbTtPuLrgjDGdSDuYrBkw1+n0NrLfbjL7Y
 2laDCAs9tvKb5BGYw1QUn3N00nLyAS+CDCYZu+ClCT1F66jAABHC+ORVJtwI1HeJsFzE
 Z3LA==
X-Gm-Message-State: AOJu0YxuC4kygKng4ANO+fPBYR4TsHatlTE16HOJsroCBgB6vkSBfjY6
 nf7rNDSeuLhd0kavwAB5aYYAMayibtXTdoNhMkg/0xvN94oquMCqo28FlR4ongk5AXtpZ9jy/8D
 9urVasVjdIfDrIGWzupYlYs0plAIrzouCx2E+
X-Google-Smtp-Source: AGHT+IEI/lb3441nKg8VrlmQXZ7GlntoNFJyPGTMbczV9Khc1nhlnD+RGCJQxF9Ns6orFxbnzfY1Y37Ki02HqQmRNBE=
X-Received: by 2002:a05:6000:1803:b0:368:6620:20ec with SMTP id
 ffacd0b85a97d-3716cd23cc6mr1128697f8f.43.1723497276284; Mon, 12 Aug 2024
 14:14:36 -0700 (PDT)
MIME-Version: 1.0
References: <20240805201719.2345596-1-tavip@google.com>
 <20240805201719.2345596-6-tavip@google.com>
 <CAFEAcA8w47gZYV8GBQa3fNf1cBWNtm_k4DAdnOVt4RWBdSrghg@mail.gmail.com>
In-Reply-To: <CAFEAcA8w47gZYV8GBQa3fNf1cBWNtm_k4DAdnOVt4RWBdSrghg@mail.gmail.com>
From: Octavian Purdila <tavip@google.com>
Date: Mon, 12 Aug 2024 14:14:24 -0700
Message-ID: <CAGWr4cSwJPMngzA7DAHRHu7eJkWGhzxuAMB2fbGRnNAx-7AR7g@mail.gmail.com>
Subject: Re: [RFC PATCH 05/23] hw: add register access utility functions
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, stefanst@google.com, 
 pbonzini@redhat.com, alex.bennee@linaro.org, thuth@redhat.com, 
 marcandre.lureau@redhat.com, alistair@alistair23.me, berrange@redhat.com, 
 philmd@linaro.org, jsnow@redhat.com, crosa@redhat.com, bleal@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=tavip@google.com; helo=mail-wr1-x429.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=unavailable autolearn_force=no
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

On Mon, Aug 12, 2024 at 8:33=E2=80=AFAM Peter Maydell <peter.maydell@linaro=
.org> wrote:
>
> On Mon, 5 Aug 2024 at 21:17, Octavian Purdila <tavip@google.com> wrote:
> >
> > Add register access utility functions for device models, like checking
> > aligned access and reading and writing to a register backstore.
>
>
> > Signed-off-by: Octavian Purdila <tavip@google.com>
> > ---
> >  include/hw/regs.h | 89 +++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 89 insertions(+)
> >  create mode 100644 include/hw/regs.h
> >
> > diff --git a/include/hw/regs.h b/include/hw/regs.h
> > new file mode 100644
> > index 0000000000..8d0da0629d
> > --- /dev/null
> > +++ b/include/hw/regs.h
> > @@ -0,0 +1,89 @@
> > +/*
> > + * Useful macros/functions for register handling.
> > + *
> > + * Copyright (c) 2021 Google LLC
> > + *
> > + * SPDX-License-Identifier: GPL-2.0-or-later
> > + *
> > + * This work is licensed under the terms of the GNU GPL, version 2 or =
later.
> > + * See the COPYING file in the top-level directory.
> > + */
> > +
> > +#ifndef HW_REGS_H
> > +#define HW_REGS_H
> > +
> > +#include "exec/hwaddr.h"
> > +#include "exec/memattrs.h"
> > +
> > +#define BITS(hi, lo)       (BIT(hi + 1) - BIT(lo))
> > +#define BIT_IS_SET(v, b)   (((v) & BIT(b)) !=3D 0)
>
> To the extent we need these we should be putting them in
> bits.h with the other bit-related operations. (But
> prefer the existing MAKE_64BIT_MASK over adding a
> second macro that evaluates to a mask with a given
> run of bits set).
>

BITS is useful when defining masks from datasheets. Specifically, in
this patch set they are used to define writable bits. While it is
possible to use MAKE_64BIT_MASK, I find it less error prone to use
BITS.

However, it just occurred to me that we might be able to use the SVD
information to derive this. If possible I'll just remove it in v2
(otherwise I will move it to include/qemu/bitops.h).

> > +
> > +/*
> > + * reg32_aligned_access
> > + * @addr: address to check
> > + * @size: size of access
> > + *
> > + * Check if access to a hardware address is 32bit aligned.
> > + *
> > + * Returns: true if access is 32bit aligned, false otherwise
> > + */
> > +static inline bool reg32_aligned_access(hwaddr addr, unsigned size)
> > +{
> > +    if (size !=3D 4 || addr % 4 !=3D 0) {
> > +        return false;
> > +    }
> > +    return true;
> > +}
> > +
> > +/*
> > + * reg32_write
> > + * @base: base address
> > + * @addr: register offset in bytes
> > + * @val: value to write
> > + * @wr_bits_array: RW bitmask array
> > + *
> > + * Update the RW/WO bits of a 32bit register backstore with a given va=
lue
> > + * (discarding updats to the RO bits). The RW/WO bits are encoded in t=
he
> > + * @wr_bits_array with bits set being RW and bits unset being RO.
> > + *
> > + * Usage example:
> > + *
> > + * wr_bits_array[] =3D {
> > + *    [REG1_ADDR/4] =3D 0xFF000000, // MSB byte writable
> > + *    [REG2_ADDR/4] =3D 0xFF,       // LSB byte writable
> > + *    // all other registers are read-only
> > + * };
> > + *
> > + * // backstore is updated to 0x12000000
> > + * reg32_write(&backstore, REG1_ADDR, 0x12345678, wr_bits_array);
> > + * // backstore is updated to 0x78
> > + * reg32_write(&backstore, REG2_ADDR, 0x12345678, wr_bits_array);
> > + */
>
> This seems like it's reimplementing include/hw/register.h
> functionality. I'm not personally a super-fan of that API,
> but I definitely would prefer it if we didn't have more than
> one way to do this.
>

Interesting, I was not aware of this thanks for pointing it out!

It seems a bit heavy to be used just for the write masking part, but
I'll take a closer look at it.

> > +static inline uint32_t reg32_write(void *base, uint32_t off, uint32_t =
val,
> > +                                   const uint32_t *rw_bits_array)
> > +{
> > +    uint32_t *ptr =3D base + addr;
> > +    uint32_t old_value =3D *ptr;
> > +    uint32_t mask =3D rw_bits_array ? rw_bits_array[addr / 4] : 0xFFFF=
FFFF;
> > +
> > +    /* set WO/RW bits */
> > +    *ptr |=3D val & mask;
> > +    /* clear RO bits */
> > +    *ptr &=3D val | ~mask;
> > +
> > +    return old_value;
> > +}
> > +
> > +/*
> > + * reg32_read
> > + * @base: base address
> > + * @addr: register offset in bytes
> > + *
> > + * Returns: 32bit value from register backstore
> > + */
> > +static inline uint32_t reg32_read(void *base, uint32_t addr)
> > +{
> > +    return *(uint32_t *)(base + addr);
> > +}
>
> Pointer type handling looks suspicious here -- if
> the thing we're accessing is really a uint32_t* then
> we should take that; if it isn't then casting it to
> one and dereferencing might be reading unaligned memory.
>

It is used for performing generic accesses to generated structs (patch
3/23) which should be aligned in the way that are used in the patch
set. If we decide to keep it, I'll add a note regarding alignment.

> thanks
> -- PMM

