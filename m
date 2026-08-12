Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88CEEC5AC67
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 03:05:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtzGw-0002zD-AX; Tue, 11 Aug 2026 23:04:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fritchleybohrer@gmail.com>)
 id 1wtzGu-0002ye-Ns
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 23:04:52 -0400
Received: from mail-lr2-x0b.google.com ([2a00:1450:4864:38::b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fritchleybohrer@gmail.com>)
 id 1wtzGq-0006pg-2G
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 23:04:52 -0400
Received: by mail-lr2-x0b.google.com with SMTP id
 38308e7fff4ca-39ee8acc5c7so1171131fa.0
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 20:04:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786503886; cv=none;
 d=google.com; s=arc-20260327;
 b=TI2Q5Equ5q27PP/CRYNV4CN9peC/8oCCowNfTjP3cuJg8yndI2x7J8Cx733j2Amj1h
 L0WhU2g7XwWMZgL0q5bFacSTCgCo++G8FTHiGFDCq224uW/sjqu9zPO4EJJpMZhQzmZK
 rxRb8FLgoucWpReFZL0wRwjor/vteKCA+S9zkfBP1l/Q96JLzqFvhCUkCqFDCQ4xd4QQ
 ru803p4mYTWWgNEdtrBIeMOcanOuDgYV1WtGACB1tXOaT0iPYxhVoZO7pmSLOT25Nsvb
 e/KRkw0ETyqB3W6Exz+sNReVN4c9Tg1ylBeRxmEmluSAeqOSfss/PjCNLTHTgRVvWbRS
 rrbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ADIm86y87f3vERb8B2WvyHX8T58ORBlrpvLLbjpRZQ8=;
 fh=48CgH78d7s9a+ntV4+3Y372+/U6T6/2Sr+Ni01B/bdE=;
 b=Eo6VIuRSTfDAwe8dQSO8N5Vajxq46V0rDXV8ypZ1aXIbK3iYwxzcpYUOxoIibnBKXh
 THJ2v/cyqJk0ia24WDM/1324uf8Lf9UQu3OnmP2nunHN310hi3D4eYMncCAgLkXYw5/+
 iOm4OeMACW6slBtdnveUPbhwRf0aaV0XkqIQ0oJz+tOfL7BK9qPuN7DgQVD/s209cgO1
 6JRrb/9ZisCF/tTmBenFh7LO+6UWkcYYqzmV5TVcIGaE3Q5NmE5kdq8NS4wS1wZ6W6sy
 E0Gv+4CA+h9gACEnYyx/5kS7xB/w04bK1ekSpP2NzOPYABZ+Yh+WsoFjq0IzXXsbdYOZ
 dZuw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786503886; x=1787108686; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ADIm86y87f3vERb8B2WvyHX8T58ORBlrpvLLbjpRZQ8=;
 b=ASZeQXiyo7Ed4ZVvrcc2cwtl2a/W33GbpdWvb2cgAllLv/7BLeXNh/jAset9aqttbG
 2xH1Z5eSPOkixoaVgmfUyI5OF4TxsE0HhPjb0FmqxrCEFqIfO88cjQXixHw++ccVtM+s
 POBn7U45wlDkJiBVVFKaYLoLZZc6m7GkMzobvpuaL6xinvcHzI80bXyK9uSoU02LnoV6
 K+f3kDS/nsEfGp96LtohZ2azUOfQKrJmmuWOpuyfgksQ70MwD54eItvaJVsZZVqnO2XE
 yClEXjALr0td3Ra8DTeoqAV5TOJynWGMRK8sqL5GSrLH54VJbZE3x7nneGjr4ef5qdoH
 UviQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786503886; x=1787108686;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ADIm86y87f3vERb8B2WvyHX8T58ORBlrpvLLbjpRZQ8=;
 b=djP21kyh9dyMvAbBHwNnhmhy7E3k++BTQfcbhKEQR6BXobJ6MWEvHeV97s+mSKWv1z
 VF4r6EElUHvCFmaWi5t/+BwJ/AH8tn6A86P9rP8uZphCEU+iXy+dmXmOsbzOsaTAoEmz
 W2A0AHsz4y9htrlTYLzZj0pMphyhTDgd+UU+uabAsKd+FOxz7d0ADimP/2C9u3C9etKe
 Yg3evokFsM5UAUXx+G+dq/oE6zxnd5q3GfYUyYqYsOJuhMpoH+jr5MXId21bGXOsyW/5
 uHKeXn7v1kCS1FEiSWL3PbEE97ddseYpNIZH9HXcKKXG4lghrghKQmxMtQZ7ARVvzGzW
 VQZg==
X-Forwarded-Encrypted: i=1;
 AHgh+RouVBtmLD6GBIdVB7bj6qZkA3d7ayz0VHTEMTwarH7LEAefVSZWsYf0AcfDidpG9yGVop+1H38064VY@nongnu.org
X-Gm-Message-State: AOJu0YxkxeZw+mdHQNU0BZtLLgy9o9Sa2Y2BzWUP6GnAL5ttsC+jf0CD
 lnlD+cAokb+Zq+pNgMbdobPc6GcbkjZSGjpHIMqNAn6NiCR7UVpF3/46GW3DvNOB+IgW/z13djX
 ECo4AwKypxOi+qKng1Vsx65XKGHVXOqU=
X-Gm-Gg: AR+sD10l18sbcbx5mGzXkOl25TOryvpJmDzTpvwoWpaNp8/zsdp0x+9lUTV0s1IYDrz
 cn1QSTIrgvrng6vCLItujuGjQyWi7S2dzFhDylclFwGfd3Dhs4Mv4HJOonZ6XJJ2C779CI0dIzt
 QkwWaOb9fXvqc8lEw8aVLYrdhcVzLZaNc+VCFBXxLSXKwEXzT7zz/vkio1gJJLSsrtxJVrLj6WR
 PxLQxuo9Le2eFCuUPtt/R06pd94f0eaFSCxQq/sEFtz3nRkdqdy0yIuU13OO2FZ/yqNcFPUTXDh
 MimqrFKSatlkhGxwgMPV3+8ZxbFxycHYc8LuS3LorUhxRw==
X-Received: by 2002:a05:6512:39c4:b0:5b1:5f9a:96bf with SMTP id
 2adb3069b0e04-5b44e92168bmr205172e87.8.1786503884795; Tue, 11 Aug 2026
 20:04:44 -0700 (PDT)
MIME-Version: 1.0
References: <20260724030145.14778-1-fritchleybohrer@gmail.com>
 <20260727084203.881580-1-fritchleybohrer@gmail.com>
 <718ed7010d214630379023daabb2fb804f7be73f.camel@alistair23.me>
 <anvbH7pv95iO5PaR@ChaodeMacBook-Pro.local>
In-Reply-To: <anvbH7pv95iO5PaR@ChaodeMacBook-Pro.local>
From: Zephyr Li <fritchleybohrer@gmail.com>
Date: Wed, 12 Aug 2026 11:04:33 +0800
X-Gm-Features: AUfX_myxWpAoC8xV7PLxqOaxFR5qiO7oAlnef2Pe9kr89oxEZHRwcARU_ef9K5k
Message-ID: <CAN4PorWHVtMESQGrfnrC=3t8OA87jxCXn4EHmey1CAj+jk3_Jg@mail.gmail.com>
Subject: Re: [PATCH v2] target/riscv: preserve vl on element-zero fault
To: Chao Liu <chao.liu@processmission.com>
Cc: Alistair <alistair@alistair23.me>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, 
 palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com, 
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com
Content-Type: multipart/alternative; boundary="0000000000007171530658d0d9dd"
Received-SPF: pass client-ip=2a00:1450:4864:38::b;
 envelope-from=fritchleybohrer@gmail.com; helo=mail-lr2-x0b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--0000000000007171530658d0d9dd
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks Chao.

I have sent v3 to rebase onto current master and regenerate the malformed
v2 submission. There are no functional changes from v2, so Chao's
Reviewed-by still applies.

Thanks,
Zephyr

On Wed, Aug 12, 2026 at 10:52=E2=80=AFAM Chao Liu <chao.liu@processmission.=
com>
wrote:

> On Wed, Aug 12, 2026 at 05:41:00AM +0800, Alistair wrote:
> > On Mon, 2026-07-27 at 16:42 +0800, Zephyr Li wrote:
> > > A unit-stride fault-only-first load must leave vl unchanged when
> > > element
> > > zero raises a synchronous exception. Keep the shortened value in a
> > > local
> > > bound until all loads complete, and only then update the
> > > architectural vl.
> > >
> > > Add a bare-metal RVV regression test which faults vle32ff.v on
> > > element zero
> > > and checks that vl remains unchanged in the trap handler.
> > >
> > > Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3544
> > > Reviewed-by: Chao Liu <chao.liu@processmission.com>
> >
> > Was this Reviewed?
> I=E2=80=99ve checked v2. The test improvements look good to me and the
> fix is unchanged.
>
> Thanks,
> Chao
> >
> > Alistair
> >
> > > Signed-off-by: Zephyr Li <fritchleybohrer@gmail.com>
> > > ---
> > > Changes in v2:
> > > - Fix commit message formatting.
> > > - Enable vector state in the bare-metal test.
> > > - Use an aligned unmapped address and compare against the vsetvli
> > > result.
> > > - Express the mstatus.VS setting as a field shift.
> > >
> > >  target/riscv/tcg/vector_helper.c          | 23 +++++----
> > >  tests/tcg/riscv64/Makefile.softmmu-target |  5 ++
> > >  tests/tcg/riscv64/test-vle32ff.S          | 57
> > > +++++++++++++++++++++++
> > >  3 files changed, 76 insertions(+), 9 deletions(-)
> > >  create mode 100644 tests/tcg/riscv64/test-vle32ff.S
> > >
> > > diff --git a/target/riscv/tcg/vector_helper.c
> > > b/target/riscv/tcg/vector_helper.c
> > > index e321ca2616..5a310822b7 100644
> > > --- a/target/riscv/tcg/vector_helper.c
> > > +++ b/target/riscv/tcg/vector_helper.c
> > > @@ -686,7 +686,7 @@ vext_ldff(void *vd, void *v0, target_ulong base,
> > > CPURISCVState *env,
> > >            uint32_t desc, vext_ldst_elem_fn_tlb *ldst_tlb,
> > >            vext_ldst_elem_fn_host *ldst_host, uint32_t log2_esz,
> > > uintptr_t ra)
> > >  {
> > > -    uint32_t i, k, vl =3D 0;
> > > +    uint32_t i, k, vl =3D 0, load_vl;
> > >      uint32_t nf =3D vext_nf(desc);
> > >      uint32_t vm =3D vext_vm(desc);
> > >      uint32_t max_elems =3D vext_max_elems(desc, log2_esz);
> > > @@ -752,22 +752,24 @@ vext_ldff(void *vd, void *v0, target_ulong
> > > base, CPURISCVState *env,
> > >          }
> > >      }
> > >  ProbeSuccess:
> > > -    /* load bytes from guest memory */
> > > -    if (vl !=3D 0) {
> > > -        env->vl =3D vl;
> > > -    }
> > > +    /*
> > > +     * Keep a shortened vl local until all loads complete. In
> > > particular,
> > > +     * an exception from element zero must leave the architectural
> > > vl alone.
> > > +     */
> > > +    load_vl =3D vl ? vl : env->vl;
> > >
> > > -    if (env->vstart < env->vl) {
> > > +    if (env->vstart < load_vl) {
> > >          if (vm) {
> > >              /* Load/store elements in the first page */
> > >              if (likely(elems)) {
> > > +                elems =3D MIN(elems, load_vl - env->vstart);
> > >                  vext_page_ldst_us(env, vd, addr, elems, nf,
> > > max_elems,
> > >                                    log2_esz, true, mmu_index,
> > > ldst_tlb,
> > >                                    ldst_host, ra);
> > >              }
> > >
> > >              /* Load/store elements in the second page */
> > > -            if (unlikely(env->vstart < env->vl)) {
> > > +            if (unlikely(env->vstart < load_vl)) {
> > >                  /* Cross page element */
> > >                  if (unlikely(page_split % msize)) {
> > >                      for (k =3D 0; k < nf; k++) {
> > > @@ -780,7 +782,7 @@ ProbeSuccess:
> > >
> > >                  addr =3D base + ((env->vstart * nf) << log2_esz);
> > >                  /* Get number of elements of second page */
> > > -                elems =3D env->vl - env->vstart;
> > > +                elems =3D load_vl - env->vstart;
> > >
> > >                  /* Load/store elements in the second page */
> > >                  vext_page_ldst_us(env, vd, addr, elems, nf,
> > > max_elems,
> > > @@ -788,7 +790,7 @@ ProbeSuccess:
> > >                                    ldst_host, ra);
> > >              }
> > >          } else {
> > > -            for (i =3D env->vstart; i < env->vl; i++) {
> > > +            for (i =3D env->vstart; i < load_vl; i++) {
> > >                  k =3D 0;
> > >                  while (k < nf) {
> > >                      if (!vext_elem_mask(v0, i)) {
> > > @@ -806,6 +808,9 @@ ProbeSuccess:
> > >              }
> > >          }
> > >      }
> > > +    if (vl !=3D 0) {
> > > +        env->vl =3D vl;
> > > +    }
> > >      env->vstart =3D 0;
> > >
> > >      vext_set_tail_elems_1s(env->vl, vd, desc, nf, esz, max_elems);
> > > diff --git a/tests/tcg/riscv64/Makefile.softmmu-target
> > > b/tests/tcg/riscv64/Makefile.softmmu-target
> > > index 82be8a2c91..7ae225bd73 100644
> > > --- a/tests/tcg/riscv64/Makefile.softmmu-target
> > > +++ b/tests/tcg/riscv64/Makefile.softmmu-target
> > > @@ -41,5 +41,10 @@ comma:=3D ,
> > >  run-test-crc32: test-crc32
> > >     $(call run-test, $<, $(QEMU) -cpu rv64$(comma)xlrbr=3Dtrue
> > > $(QEMU_OPTS)$<)
> > >
> > > +EXTRA_RUNS +=3D run-test-vle32ff
> > > +run-test-vle32ff: test-vle32ff
> > > +   $(call run-test, $<, $(QEMU) -cpu rv64$(comma)v=3Dtrue
> > > $(QEMU_OPTS)$<)
> > > +test-vle32ff: CFLAGS +=3D -march=3Drv64gcv
> > > +
> > >  # We don't currently support the multiarch system tests
> > >  undefine MULTIARCH_TESTS
> > > diff --git a/tests/tcg/riscv64/test-vle32ff.S
> > > b/tests/tcg/riscv64/test-vle32ff.S
> > > new file mode 100644
> > > index 0000000000..f510960c05
> > > --- /dev/null
> > > +++ b/tests/tcg/riscv64/test-vle32ff.S
> > > @@ -0,0 +1,57 @@
> > > +/*
> > > + * Verify that a fault-only-first load keeps vl unchanged when
> > > element zero
> > > + * raises a synchronous exception.
> > > + *
> > > + * SPDX-License-Identifier: GPL-2.0-or-later
> > > + */
> > > +
> > > +   .option norvc
> > > +
> > > +   .text
> > > +   .globl _start
> > > +_start:
> > > +   lla     t0, trap
> > > +   csrw    mtvec, t0
> > > +
> > > +   li      t0, (1 << 9)    /* Set mstatus.VS to Initial. */
> > > +   csrs    mstatus, t0
> > > +   li      t1, 4
> > > +   vsetvli t2, t1, e32, m1, ta, ma
> > > +   li      t0, 0x18000000  /* Unmapped gap in the virt memory
> > > map. */
> > > +   vle32ff.v       v1, (t0)
> > > +
> > > +   /* Element zero did not trap. */
> > > +   li      a0, 1
> > > +   j       _exit
> > > +
> > > +trap:
> > > +   csrr    t0, mcause
> > > +   li      t1, 5           /* Load access fault. */
> > > +   bne     t0, t1, trap_fail
> > > +
> > > +   csrr    t0, vl
> > > +   bne     t0, t2, trap_fail
> > > +
> > > +   li      a0, 0
> > > +   j       _exit
> > > +
> > > +trap_fail:
> > > +   li      a0, 1
> > > +
> > > +_exit:
> > > +   lla     a1, semiargs
> > > +   li      t0, 0x20026     /* ADP_Stopped_ApplicationExit */
> > > +   sd      t0, 0(a1)
> > > +   sd      a0, 8(a1)
> > > +   li      a0, 0x20        /* TARGET_SYS_EXIT_EXTENDED */
> > > +
> > > +   .balign 16
> > > +   slli    zero, zero, 0x1f
> > > +   ebreak
> > > +   srai    zero, zero, 0x7
> > > +   j       .
> > > +
> > > +   .data
> > > +   .balign 8
> > > +semiargs:
> > > +   .space  16
>

--0000000000007171530658d0d9dd
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Thanks Chao.<br><br>I have sent v3 to rebase onto current =
master and regenerate the malformed<br>v2 submission. There are no function=
al changes from v2, so Chao&#39;s<br>Reviewed-by still applies.<br><br>Than=
ks,<br>Zephyr</div><br><div class=3D"gmail_quote gmail_quote_container"><di=
v dir=3D"ltr" class=3D"gmail_attr">On Wed, Aug 12, 2026 at 10:52=E2=80=AFAM=
 Chao Liu &lt;<a href=3D"mailto:chao.liu@processmission.com">chao.liu@proce=
ssmission.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddi=
ng-left:1ex">On Wed, Aug 12, 2026 at 05:41:00AM +0800, Alistair wrote:<br>
&gt; On Mon, 2026-07-27 at 16:42 +0800, Zephyr Li wrote:<br>
&gt; &gt; A unit-stride fault-only-first load must leave vl unchanged when<=
br>
&gt; &gt; element<br>
&gt; &gt; zero raises a synchronous exception. Keep the shortened value in =
a<br>
&gt; &gt; local<br>
&gt; &gt; bound until all loads complete, and only then update the<br>
&gt; &gt; architectural vl.<br>
&gt; &gt; <br>
&gt; &gt; Add a bare-metal RVV regression test which faults vle32ff.v on<br=
>
&gt; &gt; element zero<br>
&gt; &gt; and checks that vl remains unchanged in the trap handler.<br>
&gt; &gt; <br>
&gt; &gt; Resolves: <a href=3D"https://gitlab.com/qemu-project/qemu/-/work_=
items/3544" rel=3D"noreferrer" target=3D"_blank">https://gitlab.com/qemu-pr=
oject/qemu/-/work_items/3544</a><br>
&gt; &gt; Reviewed-by: Chao Liu &lt;<a href=3D"mailto:chao.liu@processmissi=
on.com" target=3D"_blank">chao.liu@processmission.com</a>&gt;<br>
&gt; <br>
&gt; Was this Reviewed?<br>
I=E2=80=99ve checked v2. The test improvements look good to me and the<br>
fix is unchanged.<br>
<br>
Thanks,<br>
Chao<br>
&gt; <br>
&gt; Alistair<br>
&gt; <br>
&gt; &gt; Signed-off-by: Zephyr Li &lt;<a href=3D"mailto:fritchleybohrer@gm=
ail.com" target=3D"_blank">fritchleybohrer@gmail.com</a>&gt;<br>
&gt; &gt; ---<br>
&gt; &gt; Changes in v2:<br>
&gt; &gt; - Fix commit message formatting.<br>
&gt; &gt; - Enable vector state in the bare-metal test.<br>
&gt; &gt; - Use an aligned unmapped address and compare against the vsetvli=
<br>
&gt; &gt; result.<br>
&gt; &gt; - Express the mstatus.VS setting as a field shift.<br>
&gt; &gt; <br>
&gt; &gt; =C2=A0target/riscv/tcg/vector_helper.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 23 +++++----<br>
&gt; &gt; =C2=A0tests/tcg/riscv64/Makefile.softmmu-target |=C2=A0 5 ++<br>
&gt; &gt; =C2=A0tests/tcg/riscv64/test-vle32ff.S=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 57<br>
&gt; &gt; +++++++++++++++++++++++<br>
&gt; &gt; =C2=A03 files changed, 76 insertions(+), 9 deletions(-)<br>
&gt; &gt; =C2=A0create mode 100644 tests/tcg/riscv64/test-vle32ff.S<br>
&gt; &gt; <br>
&gt; &gt; diff --git a/target/riscv/tcg/vector_helper.c<br>
&gt; &gt; b/target/riscv/tcg/vector_helper.c<br>
&gt; &gt; index e321ca2616..5a310822b7 100644<br>
&gt; &gt; --- a/target/riscv/tcg/vector_helper.c<br>
&gt; &gt; +++ b/target/riscv/tcg/vector_helper.c<br>
&gt; &gt; @@ -686,7 +686,7 @@ vext_ldff(void *vd, void *v0, target_ulong ba=
se,<br>
&gt; &gt; CPURISCVState *env,<br>
&gt; &gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint=
32_t desc, vext_ldst_elem_fn_tlb *ldst_tlb,<br>
&gt; &gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vext=
_ldst_elem_fn_host *ldst_host, uint32_t log2_esz,<br>
&gt; &gt; uintptr_t ra)<br>
&gt; &gt; =C2=A0{<br>
&gt; &gt; -=C2=A0=C2=A0=C2=A0 uint32_t i, k, vl =3D 0;<br>
&gt; &gt; +=C2=A0=C2=A0=C2=A0 uint32_t i, k, vl =3D 0, load_vl;<br>
&gt; &gt; =C2=A0=C2=A0=C2=A0=C2=A0 uint32_t nf =3D vext_nf(desc);<br>
&gt; &gt; =C2=A0=C2=A0=C2=A0=C2=A0 uint32_t vm =3D vext_vm(desc);<br>
&gt; &gt; =C2=A0=C2=A0=C2=A0=C2=A0 uint32_t max_elems =3D vext_max_elems(de=
sc, log2_esz);<br>
&gt; &gt; @@ -752,22 +752,24 @@ vext_ldff(void *vd, void *v0, target_ulong<=
br>
&gt; &gt; base, CPURISCVState *env,<br>
&gt; &gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }<br>
&gt; &gt; =C2=A0=C2=A0=C2=A0=C2=A0 }<br>
&gt; &gt; =C2=A0ProbeSuccess:<br>
&gt; &gt; -=C2=A0=C2=A0=C2=A0 /* load bytes from guest memory */<br>
&gt; &gt; -=C2=A0=C2=A0=C2=A0 if (vl !=3D 0) {<br>
&gt; &gt; -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 env-&gt;vl =3D vl;<br=
>
&gt; &gt; -=C2=A0=C2=A0=C2=A0 }<br>
&gt; &gt; +=C2=A0=C2=A0=C2=A0 /*<br>
&gt; &gt; +=C2=A0=C2=A0=C2=A0=C2=A0 * Keep a shortened vl local until all l=
oads complete. In<br>
&gt; &gt; particular,<br>
&gt; &gt; +=C2=A0=C2=A0=C2=A0=C2=A0 * an exception from element zero must l=
eave the architectural<br>
&gt; &gt; vl alone.<br>
&gt; &gt; +=C2=A0=C2=A0=C2=A0=C2=A0 */<br>
&gt; &gt; +=C2=A0=C2=A0=C2=A0 load_vl =3D vl ? vl : env-&gt;vl;<br>
&gt; &gt; =C2=A0<br>
&gt; &gt; -=C2=A0=C2=A0=C2=A0 if (env-&gt;vstart &lt; env-&gt;vl) {<br>
&gt; &gt; +=C2=A0=C2=A0=C2=A0 if (env-&gt;vstart &lt; load_vl) {<br>
&gt; &gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (vm) {<br>
&gt; &gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 /* Load/store elements in the first page */<br>
&gt; &gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 if (likely(elems)) {<br>
&gt; &gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 elems =3D MIN(elems, load_vl - env-&gt;vstart);=
<br>
&gt; &gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vext_page_ldst_us(env, vd, addr, elems, n=
f,<br>
&gt; &gt; max_elems,<br>
&gt; &gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 log2_esz=
, true, mmu_index,<br>
&gt; &gt; ldst_tlb,<br>
&gt; &gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ldst_hos=
t, ra);<br>
&gt; &gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 }<br>
&gt; &gt; =C2=A0<br>
&gt; &gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 /* Load/store elements in the second page */<br>
&gt; &gt; -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 if (unlikely(env-&gt;vstart &lt; env-&gt;vl)) {<br>
&gt; &gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 if (unlikely(env-&gt;vstart &lt; load_vl)) {<br>
&gt; &gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Cross page element */<br>
&gt; &gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (unlikely(page_split % msize)) {<br>
&gt; &gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for (k =3D 0; k &=
lt; nf; k++) {<br>
&gt; &gt; @@ -780,7 +782,7 @@ ProbeSuccess:<br>
&gt; &gt; =C2=A0<br>
&gt; &gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 addr =3D base + ((env-&gt;vstart * nf) &l=
t;&lt; log2_esz);<br>
&gt; &gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Get number of elements of second page =
*/<br>
&gt; &gt; -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 elems =3D env-&gt;vl - env-&gt;vstart;<br>
&gt; &gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 elems =3D load_vl - env-&gt;vstart;<br>
&gt; &gt; =C2=A0<br>
&gt; &gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Load/store elements in the second page=
 */<br>
&gt; &gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vext_page_ldst_us(env, vd, addr, elems, n=
f,<br>
&gt; &gt; max_elems,<br>
&gt; &gt; @@ -788,7 +790,7 @@ ProbeSuccess:<br>
&gt; &gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ldst_hos=
t, ra);<br>
&gt; &gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 }<br>
&gt; &gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {<br>
&gt; &gt; -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 for (i =3D env-&gt;vstart; i &lt; env-&gt;vl; i++) {<br>
&gt; &gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 for (i =3D env-&gt;vstart; i &lt; load_vl; i++) {<br>
&gt; &gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 k =3D 0;<br>
&gt; &gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 while (k &lt; nf) {<br>
&gt; &gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!vext_elem_ma=
sk(v0, i)) {<br>
&gt; &gt; @@ -806,6 +808,9 @@ ProbeSuccess:<br>
&gt; &gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 }<br>
&gt; &gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }<br>
&gt; &gt; =C2=A0=C2=A0=C2=A0=C2=A0 }<br>
&gt; &gt; +=C2=A0=C2=A0=C2=A0 if (vl !=3D 0) {<br>
&gt; &gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 env-&gt;vl =3D vl;<br=
>
&gt; &gt; +=C2=A0=C2=A0=C2=A0 }<br>
&gt; &gt; =C2=A0=C2=A0=C2=A0=C2=A0 env-&gt;vstart =3D 0;<br>
&gt; &gt; =C2=A0<br>
&gt; &gt; =C2=A0=C2=A0=C2=A0=C2=A0 vext_set_tail_elems_1s(env-&gt;vl, vd, d=
esc, nf, esz, max_elems);<br>
&gt; &gt; diff --git a/tests/tcg/riscv64/Makefile.softmmu-target<br>
&gt; &gt; b/tests/tcg/riscv64/Makefile.softmmu-target<br>
&gt; &gt; index 82be8a2c91..7ae225bd73 100644<br>
&gt; &gt; --- a/tests/tcg/riscv64/Makefile.softmmu-target<br>
&gt; &gt; +++ b/tests/tcg/riscv64/Makefile.softmmu-target<br>
&gt; &gt; @@ -41,5 +41,10 @@ comma:=3D ,<br>
&gt; &gt; =C2=A0run-test-crc32: test-crc32<br>
&gt; &gt; =C2=A0=C2=A0 =C2=A0$(call run-test, $&lt;, $(QEMU) -cpu rv64$(com=
ma)xlrbr=3Dtrue<br>
&gt; &gt; $(QEMU_OPTS)$&lt;)<br>
&gt; &gt; =C2=A0<br>
&gt; &gt; +EXTRA_RUNS +=3D run-test-vle32ff<br>
&gt; &gt; +run-test-vle32ff: test-vle32ff<br>
&gt; &gt; +=C2=A0 =C2=A0$(call run-test, $&lt;, $(QEMU) -cpu rv64$(comma)v=
=3Dtrue<br>
&gt; &gt; $(QEMU_OPTS)$&lt;)<br>
&gt; &gt; +test-vle32ff: CFLAGS +=3D -march=3Drv64gcv<br>
&gt; &gt; +<br>
&gt; &gt; =C2=A0# We don&#39;t currently support the multiarch system tests=
<br>
&gt; &gt; =C2=A0undefine MULTIARCH_TESTS<br>
&gt; &gt; diff --git a/tests/tcg/riscv64/test-vle32ff.S<br>
&gt; &gt; b/tests/tcg/riscv64/test-vle32ff.S<br>
&gt; &gt; new file mode 100644<br>
&gt; &gt; index 0000000000..f510960c05<br>
&gt; &gt; --- /dev/null<br>
&gt; &gt; +++ b/tests/tcg/riscv64/test-vle32ff.S<br>
&gt; &gt; @@ -0,0 +1,57 @@<br>
&gt; &gt; +/*<br>
&gt; &gt; + * Verify that a fault-only-first load keeps vl unchanged when<b=
r>
&gt; &gt; element zero<br>
&gt; &gt; + * raises a synchronous exception.<br>
&gt; &gt; + *<br>
&gt; &gt; + * SPDX-License-Identifier: GPL-2.0-or-later<br>
&gt; &gt; + */<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0.option norvc<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0.text<br>
&gt; &gt; +=C2=A0 =C2=A0.globl _start<br>
&gt; &gt; +_start:<br>
&gt; &gt; +=C2=A0 =C2=A0lla=C2=A0 =C2=A0 =C2=A0t0, trap<br>
&gt; &gt; +=C2=A0 =C2=A0csrw=C2=A0 =C2=A0 mtvec, t0<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0li=C2=A0 =C2=A0 =C2=A0 t0, (1 &lt;&lt; 9)=C2=A0 =C2=
=A0 /* Set mstatus.VS to Initial. */<br>
&gt; &gt; +=C2=A0 =C2=A0csrs=C2=A0 =C2=A0 mstatus, t0<br>
&gt; &gt; +=C2=A0 =C2=A0li=C2=A0 =C2=A0 =C2=A0 t1, 4<br>
&gt; &gt; +=C2=A0 =C2=A0vsetvli t2, t1, e32, m1, ta, ma<br>
&gt; &gt; +=C2=A0 =C2=A0li=C2=A0 =C2=A0 =C2=A0 t0, 0x18000000=C2=A0 /* Unma=
pped gap in the virt memory<br>
&gt; &gt; map. */<br>
&gt; &gt; +=C2=A0 =C2=A0vle32ff.v=C2=A0 =C2=A0 =C2=A0 =C2=A0v1, (t0)<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0/* Element zero did not trap. */<br>
&gt; &gt; +=C2=A0 =C2=A0li=C2=A0 =C2=A0 =C2=A0 a0, 1<br>
&gt; &gt; +=C2=A0 =C2=A0j=C2=A0 =C2=A0 =C2=A0 =C2=A0_exit<br>
&gt; &gt; +<br>
&gt; &gt; +trap:<br>
&gt; &gt; +=C2=A0 =C2=A0csrr=C2=A0 =C2=A0 t0, mcause<br>
&gt; &gt; +=C2=A0 =C2=A0li=C2=A0 =C2=A0 =C2=A0 t1, 5=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0/* Load access fault. */<br>
&gt; &gt; +=C2=A0 =C2=A0bne=C2=A0 =C2=A0 =C2=A0t0, t1, trap_fail<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0csrr=C2=A0 =C2=A0 t0, vl<br>
&gt; &gt; +=C2=A0 =C2=A0bne=C2=A0 =C2=A0 =C2=A0t0, t2, trap_fail<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0li=C2=A0 =C2=A0 =C2=A0 a0, 0<br>
&gt; &gt; +=C2=A0 =C2=A0j=C2=A0 =C2=A0 =C2=A0 =C2=A0_exit<br>
&gt; &gt; +<br>
&gt; &gt; +trap_fail:<br>
&gt; &gt; +=C2=A0 =C2=A0li=C2=A0 =C2=A0 =C2=A0 a0, 1<br>
&gt; &gt; +<br>
&gt; &gt; +_exit:<br>
&gt; &gt; +=C2=A0 =C2=A0lla=C2=A0 =C2=A0 =C2=A0a1, semiargs<br>
&gt; &gt; +=C2=A0 =C2=A0li=C2=A0 =C2=A0 =C2=A0 t0, 0x20026=C2=A0 =C2=A0 =C2=
=A0/* ADP_Stopped_ApplicationExit */<br>
&gt; &gt; +=C2=A0 =C2=A0sd=C2=A0 =C2=A0 =C2=A0 t0, 0(a1)<br>
&gt; &gt; +=C2=A0 =C2=A0sd=C2=A0 =C2=A0 =C2=A0 a0, 8(a1)<br>
&gt; &gt; +=C2=A0 =C2=A0li=C2=A0 =C2=A0 =C2=A0 a0, 0x20=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 /* TARGET_SYS_EXIT_EXTENDED */<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0.balign 16<br>
&gt; &gt; +=C2=A0 =C2=A0slli=C2=A0 =C2=A0 zero, zero, 0x1f<br>
&gt; &gt; +=C2=A0 =C2=A0ebreak<br>
&gt; &gt; +=C2=A0 =C2=A0srai=C2=A0 =C2=A0 zero, zero, 0x7<br>
&gt; &gt; +=C2=A0 =C2=A0j=C2=A0 =C2=A0 =C2=A0 =C2=A0.<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0.data<br>
&gt; &gt; +=C2=A0 =C2=A0.balign 8<br>
&gt; &gt; +semiargs:<br>
&gt; &gt; +=C2=A0 =C2=A0.space=C2=A0 16<br>
</blockquote></div>

--0000000000007171530658d0d9dd--

