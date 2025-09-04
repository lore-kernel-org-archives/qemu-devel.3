Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4FDDCA1002
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Sep 2025 05:17:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uu2KP-0002Ei-Rt; Thu, 04 Sep 2025 01:16:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1uu2KO-0002E0-4P; Thu, 04 Sep 2025 01:16:08 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1uu2KL-0005lr-V1; Thu, 04 Sep 2025 01:16:07 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-772301f8ae2so559640b3a.0; 
 Wed, 03 Sep 2025 22:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756962964; x=1757567764; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=cT+t1umi2jRPgpF5oYz6Q+gqfk85yH7ycx4oBjofkrc=;
 b=TxrBLgKmVZaynav6gR8AYdXXFIP5UORCWarVd/jzgWWLljZUDXjqhS2VhsCm2gNsPd
 NWftnrN27u1JayEQ3WsuLU5RDKxlCqsSi1l5ml0GSiVv6RieU5oXRqopIJdHf/w6R94U
 jJaUKEunG6R3GONVIK1TaMpsD3AuPDELrsNW+IsIyJ3IfSm6i6ml5H2ImpcRAnYu3APJ
 Gc7z+zuWwIHIoNdjdXzf+iopbteuDgM2UHnTdh94kTwNEMLbpOKOexS+xwhINuuS44cy
 8K4cgRg9ld0dPj6sUrKiFGcULsgIvSQL7sQBI1Kfm6ZWq0J03pzrlAMmFXEiCqQQTzY9
 Antw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756962964; x=1757567764;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cT+t1umi2jRPgpF5oYz6Q+gqfk85yH7ycx4oBjofkrc=;
 b=Yib5qwWPUoi/p4BaVpCiQ1UlxqG29khh01psnYyUUppa2S0QYusjObYA0nRkOlnB4A
 Arv3WV/XQSD1uP8iNWqiZPh0t5nyC/V6FGJVuGB7x9jmHmClWclVo1HcqzXOMaRhlluQ
 wxHyk9iKDVCM/HzZ+6dznQdVTSAU1dz6My985KiRJVuj8WauMukZDN92PFsWg9/uWVuA
 LSrf0ATN6bha5g9YQK1S8uq7OfzW8rd/t/2Hn5tDfENURawWuc18HtY3IVngfPndftW+
 Q8xgvJa3JmaU2EFCLMcTBmE3qKA8zbaEUbt/tEBvSLGOgigbzumopTE07hBVEPHGQYqk
 QnmA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVgYIc2gRYJt1dZSTWoTQMXrXZQDeoNnTxdrlx8gkF0sMoe6Y+0s2n+gOsQmJHFaRl6aH5PmTkxW9rr@nongnu.org
X-Gm-Message-State: AOJu0Yyn2Z0Av5vxJeNuAnnmRv/WDkppV9RKtmzr4iawfRX0oBPLfigl
 dZKp8IY9J+lmzmdSvuLfU7W+3KE9RuCGhoIUpW0YPYbZQFimca34FBOvxH7z6g==
X-Gm-Gg: ASbGncuT8ieJRPC4QwifhSCJyUn2d2ytWHGocqmm9GnUdHqzw6rfowhOBwpLFUxOKjw
 2fVhkFPv/RGWn6gLB3fMSqfs4WpzrAAAjZDjNFUzalxX/d/DvLVGHyEN1vTaiEzpyDY3ZeJJUDl
 HCVQvuGdVUcydmL0r/GIXpFqFdFC9rxI5ebtyfUM5XlA1OnDxLJwzoFTLgsgLPCMrIxPsPCvnAc
 EUD1rpmFJj9i85KhPOQ0h0E8h4Xesfln0mFnha1b4knXia5TYT8pCyTFaRRKsrEyz8VX5jJ1U5j
 +xWb2gDAMD9/0rwz188g0v6IxbzpkgoDxw8NF7WQUX5gU/I2hEgLdbdDEH7xvwhFhMIkE+a8RYc
 Oe+d0888yx/41rGy7tOKkQ57tSTCQpZc/QCII+Nl6QINMfVia6HrErz1jZ097KK2SwIo7EHhYB5
 Q=
X-Google-Smtp-Source: AGHT+IEllALV5jFgWHcMR5isrIuwS2g8QcD9v0ZcCD7AdAYDCQGPoh7EUAag10mlzpwyefYp+nzGOw==
X-Received: by 2002:a05:6a00:1399:b0:771:e2f7:5a12 with SMTP id
 d2e1a72fcca58-7723e1f0883mr22805744b3a.6.1756962963812; 
 Wed, 03 Sep 2025 22:16:03 -0700 (PDT)
Received: from localhost (123.253.189.97.qld.leaptel.network. [123.253.189.97])
 by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-7722a2d7c42sm18447262b3a.39.2025.09.03.22.16.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Sep 2025 22:16:03 -0700 (PDT)
Date: Thu, 4 Sep 2025 15:16:01 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-devel@nongnu.org,
 Chao Liu <chao.liu@zevorn.cn>, 
 Nicholas Joaquin <njoaquin@tenstorrent.com>,
 Ganesh Valliappan <gvalliappan@tenstorrent.com>
Subject: Re: [PATCH 2/3] target/risvc: Fix vector whole ldst vstart check
Message-ID: <qyikdqxxiewb7tqykt74gpx5oereckbepyptd3vr4flptmrvoc@midnt5c7agnc>
References: <20250903030114.274535-1-npiggin@gmail.com>
 <20250903030114.274535-3-npiggin@gmail.com>
 <6bff4c9d-1da4-40b3-901a-789923d8ef7e@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6bff4c9d-1da4-40b3-901a-789923d8ef7e@ventanamicro.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Wed, Sep 03, 2025 at 05:13:36PM -0300, Daniel Henrique Barboza wrote:
> Hi Nick,
> 
> ^ typo in the patch subject: s/risvc/riscv

Well I'm off to a fine start :/

> 
> On 9/3/25 12:01 AM, Nicholas Piggin wrote:
> > The whole vector ldst instructions do not include a vstart check,
> > so an overflowed vstart can result in an underflowed memory address
> > offset and crash:
> > 
> >      accel/tcg/cputlb.c:1465:probe_access_flags:
> >        assertion failed: (-(addr | TARGET_PAGE_MASK) >= size)
> > 
> > Add the VSTART_CHECK_EARLY_EXIT() check for these helpers.
> > 
> > This was found with a verification test generator based on RiESCUE.
> > 
> > Reported-by: Nicholas Joaquin <njoaquin@tenstorrent.com>
> > Reported-by: Ganesh Valliappan <gvalliappan@tenstorrent.com>
> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> > ---
> >   target/riscv/vector_helper.c             |  2 +
> >   tests/tcg/riscv64/Makefile.target        |  5 ++
> >   tests/tcg/riscv64/test-vstart-overflow.c | 75 ++++++++++++++++++++++++
> >   3 files changed, 82 insertions(+)
> >   create mode 100644 tests/tcg/riscv64/test-vstart-overflow.c
> > 
> > diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
> > index fc85a34a84..e0e8735000 100644
> > --- a/target/riscv/vector_helper.c
> > +++ b/target/riscv/vector_helper.c
> > @@ -825,6 +825,8 @@ vext_ldst_whole(void *vd, target_ulong base, CPURISCVState *env, uint32_t desc,
> >       uint32_t esz = 1 << log2_esz;
> >       int mmu_index = riscv_env_mmu_index(env, false);
> > +    VSTART_CHECK_EARLY_EXIT(env, evl);
> > +
> >       /* Calculate the page range of first page */
> >       addr = base + (env->vstart << log2_esz);
> >       page_split = -(addr | TARGET_PAGE_MASK);
> > diff --git a/tests/tcg/riscv64/Makefile.target b/tests/tcg/riscv64/Makefile.target
> > index 4da5b9a3b3..19a49b6467 100644
> > --- a/tests/tcg/riscv64/Makefile.target
> > +++ b/tests/tcg/riscv64/Makefile.target
> > @@ -18,3 +18,8 @@ TESTS += test-fcvtmod
> >   test-fcvtmod: CFLAGS += -march=rv64imafdc
> >   test-fcvtmod: LDFLAGS += -static
> >   run-test-fcvtmod: QEMU_OPTS += -cpu rv64,d=true,zfa=true
> > +
> > +# Test for vstart >= vl
> > +TESTS += test-vstart-overflow
> > +test-vstart-overflow: CFLAGS += -march=rv64gcv
> > +run-test-vstart-overflow: QEMU_OPTS += -cpu rv64,v=on
> > diff --git a/tests/tcg/riscv64/test-vstart-overflow.c b/tests/tcg/riscv64/test-vstart-overflow.c
> > new file mode 100644
> > index 0000000000..72999f2c8a
> > --- /dev/null
> > +++ b/tests/tcg/riscv64/test-vstart-overflow.c
> > @@ -0,0 +1,75 @@
> > +/*
> > + * Test for VSTART set to overflow VL
> > + *
> > + * TCG vector instructions should call VSTART_CHECK_EARLY_EXIT() to check
> > + * this case, otherwise memory addresses can underflow and misbehave or
> > + * crash QEMU.
> > + *
> > + * TODO: Add stores and other instructions.
> > + *
> > + * SPDX-License-Identifier: GPL-2.0-or-later
> > + */
> > +#include <stdint.h>
> > +#include <riscv_vector.h>
> 
> The fix in vector_helper.c is fine but this patch (and patch 3) won't execute
> 'make check-tcg'. It complains about this header being missing in the docker
> env.
> 
> To eliminate the possibility of my env being the problem I ran this series in
> Gitlab. Same error:
> 
> 
> https://gitlab.com/danielhb/qemu/-/jobs/11236091281
> 
> /builds/danielhb/qemu/tests/tcg/riscv64/test-vstart-overflow.c:13:10: fatal error: riscv_vector.h: No such file or directory
> 3899
>    13 | #include <riscv_vector.h>
> 3900
>       |          ^~~~~~~~~~~~~~~~
> 3901
> compilation terminated.
> 3902
> make[1]: *** [Makefile:122: test-vstart-overflow] Error 1
> 
> 
> I believe you need to add the Docker changes you made in this patch. Same
> thing for patch 3. And same thing for patch 4 of:
> 
> [PATCH 0/4] linux-user/riscv: add vector state to signal
> 
> Given that you're also using riscv_vector.h in there too. Thanks,

Hmm, thanks. It did work for my local build.

I think the header is provided by the compiler, so I might have
to work out a way to skip the test if the compiler is too old.
GCC13 might have been the first one to support.

I was considering writing .S files for these. Should have done so
if I realized, but nevermind.

Thanks,
Nick

