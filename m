Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D87E0CD128A
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Apr 2024 23:07:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrQje-0001Jn-VS; Mon, 01 Apr 2024 19:06:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <horenchuang@bytedance.com>)
 id 1rrQjd-0001It-Dg
 for qemu-devel@nongnu.org; Mon, 01 Apr 2024 19:06:37 -0400
Received: from mail-yb1-xb2c.google.com ([2607:f8b0:4864:20::b2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <horenchuang@bytedance.com>)
 id 1rrQjb-0003Gy-1K
 for qemu-devel@nongnu.org; Mon, 01 Apr 2024 19:06:37 -0400
Received: by mail-yb1-xb2c.google.com with SMTP id
 3f1490d57ef6-dcc4de7d901so3592709276.0
 for <qemu-devel@nongnu.org>; Mon, 01 Apr 2024 16:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1712012791; x=1712617591; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O8nGCphDC2lDqE/CSbphHfkuC3TvEewjmAtLy2kdkps=;
 b=N5IQHIHU5b4lGqrh5KnLbk+l7R5z/49NdCLs6qNVWGmZZdzbzfX6BgpGEDVT+MzCM8
 RJ/T8f2l9Ght0HJlKMrrY2ycmrWzxjrfNZetcrWLnsWJZ34Heu7Sz46VCmHcEO54F/62
 Kz4pR4YLp2DRT2grD+R14VQVeey9p6WwFwK9byrajqOgJQuvk157Z2xx/Mtdy9oGwm4+
 5JCTOiEglhXbYwu/MYcAX2heTTmQRgMr/aUdqK7KkNw3tjnYljeZvoPU7Ujyqgh3gqg7
 nyQWoOsDanj41NAYwVlDuadGzQwCkM1dYI1hbs7hOVQSNQHu0tDgDEBHU2KXc5DL73FX
 E2lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712012791; x=1712617591;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O8nGCphDC2lDqE/CSbphHfkuC3TvEewjmAtLy2kdkps=;
 b=mS5BM4kNH5e194iKwbxjrMdNLrK45YFsL95FO08BRh9joDPb6OX/c2ABz08Xi7h9d6
 WtADCl0FDli6em+4IN5dNlkCXjlOa1UKJLWO6x+YXbnoHmnhlM8INJaVJF0k5v0mvFez
 MCrz+ZlF43J5/u7dRXhFwrJBNKvXAIxR6LoJ+qLUF/rZuGPbVCjXIpkb+oOWBR/TZO5u
 opRMfv1yaJaYj67j/vNc3ciYM29y382cbWLhAp4ondntCn3hwOpRRDE2SlU56ltRRlwH
 9yHk+esr0Te4sYBFbkj98fKbzzxxvskSzJUtRWDBTqRXhJz+sJco6dWJP6cNNUdV5EZ7
 AdcA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXCa7KLG8fmTHZF2891TU9p2dk6tsI+u/ERYMYJ7BTFeuuZhigMlE/ocEmPv473BA5sT0ytwkTMJofrekNvng1N1FtqbP0=
X-Gm-Message-State: AOJu0Yz8LarKgJ3PCRK9rO+a+OMRiqoQ7zCdx/bLXJ36P8Cw92u7HS96
 xcaNwZu5yXmDtb7BA6CqKFcj4oRK9GuFS/kmcWr4JCt4RQk9vzNiEJuwGKcUkcV9QB+uMLYTNY6
 EY1HAUKS5X1j819kMsP60CCXNs0gD4lm+oqqMgg==
X-Google-Smtp-Source: AGHT+IHzFkHkXRaCjC8Uy5FTEb4BrGRIOAJ4uvIAnoieQDU096hzOpi7JP+GKKrquqv5tMmb8A6yVyiIs7YwfEUYlA0=
X-Received: by 2002:a25:bb51:0:b0:dcf:30d9:1d7b with SMTP id
 b17-20020a25bb51000000b00dcf30d91d7bmr9194408ybk.45.1712012791583; Mon, 01
 Apr 2024 16:06:31 -0700 (PDT)
MIME-Version: 1.0
References: <20240329053353.309557-2-horenchuang@bytedance.com>
 <20240331190857.132490-1-sj@kernel.org>
 <CAKPbEqo3_zHF98SRoAz4L-CCGpEm8wN1P2RgPLa_q63e1qeGxQ@mail.gmail.com>
In-Reply-To: <CAKPbEqo3_zHF98SRoAz4L-CCGpEm8wN1P2RgPLa_q63e1qeGxQ@mail.gmail.com>
From: "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>
Date: Mon, 1 Apr 2024 16:06:21 -0700
Message-ID: <CAKPbEqpsE8aqH0t6iKmuLkhjFX2CfRK70K5U0eC1VvAyk8ofKg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v9 1/2] memory tier: dax/kmem: introduce an
 abstract layer for finding, allocating, and putting memory types
To: SeongJae Park <sj@kernel.org>
Cc: "Huang, Ying" <ying.huang@intel.com>,
 Gregory Price <gourry.memverge@gmail.com>, 
 aneesh.kumar@linux.ibm.com, mhocko@suse.com, tj@kernel.org, 
 john@jagalactic.com, Eishan Mirakhur <emirakhur@micron.com>, 
 Vinicius Tavares Petrucci <vtavarespetr@micron.com>,
 Ravis OpenSrc <Ravis.OpenSrc@micron.com>, 
 Alistair Popple <apopple@nvidia.com>,
 Srinivasulu Thanneeru <sthanneeru@micron.com>, 
 Dan Williams <dan.j.williams@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, 
 Dave Jiang <dave.jiang@intel.com>, Andrew Morton <akpm@linux-foundation.org>,
 nvdimm@lists.linux.dev, 
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
 "Ho-Ren (Jack) Chuang" <horenc@vt.edu>,
 "Ho-Ren (Jack) Chuang" <horenchuang@gmail.com>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2c;
 envelope-from=horenchuang@bytedance.com; helo=mail-yb1-xb2c.google.com
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

Hi SeongJae,

On Mon, Apr 1, 2024 at 11:27=E2=80=AFAM Ho-Ren (Jack) Chuang
<horenchuang@bytedance.com> wrote:
>
> Hi SeongJae,
>
> On Sun, Mar 31, 2024 at 12:09=E2=80=AFPM SeongJae Park <sj@kernel.org> wr=
ote:
> >
> > Hi Ho-Ren,
> >
> > On Fri, 29 Mar 2024 05:33:52 +0000 "Ho-Ren (Jack) Chuang" <horenchuang@=
bytedance.com> wrote:
> >
> > > Since different memory devices require finding, allocating, and putti=
ng
> > > memory types, these common steps are abstracted in this patch,
> > > enhancing the scalability and conciseness of the code.
> > >
> > > Signed-off-by: Ho-Ren (Jack) Chuang <horenchuang@bytedance.com>
> > > Reviewed-by: "Huang, Ying" <ying.huang@intel.com>
> > > ---
> > >  drivers/dax/kmem.c           | 20 ++------------------
> > >  include/linux/memory-tiers.h | 13 +++++++++++++
> > >  mm/memory-tiers.c            | 32 ++++++++++++++++++++++++++++++++
> > >  3 files changed, 47 insertions(+), 18 deletions(-)
> > >
> > [...]
> > > diff --git a/include/linux/memory-tiers.h b/include/linux/memory-tier=
s.h
> > > index 69e781900082..a44c03c2ba3a 100644
> > > --- a/include/linux/memory-tiers.h
> > > +++ b/include/linux/memory-tiers.h
> > > @@ -48,6 +48,9 @@ int mt_calc_adistance(int node, int *adist);
> > >  int mt_set_default_dram_perf(int nid, struct access_coordinate *perf=
,
> > >                            const char *source);
> > >  int mt_perf_to_adistance(struct access_coordinate *perf, int *adist)=
;
> > > +struct memory_dev_type *mt_find_alloc_memory_type(int adist,
> > > +                                                     struct list_hea=
d *memory_types);
> > > +void mt_put_memory_types(struct list_head *memory_types);
> > >  #ifdef CONFIG_MIGRATION
> > >  int next_demotion_node(int node);
> > >  void node_get_allowed_targets(pg_data_t *pgdat, nodemask_t *targets)=
;
> > > @@ -136,5 +139,15 @@ static inline int mt_perf_to_adistance(struct ac=
cess_coordinate *perf, int *adis
> > >  {
> > >       return -EIO;
> > >  }
> > > +
> > > +struct memory_dev_type *mt_find_alloc_memory_type(int adist, struct =
list_head *memory_types)
> > > +{
> > > +     return NULL;
> > > +}
> > > +
> > > +void mt_put_memory_types(struct list_head *memory_types)
> > > +{
> > > +
> > > +}
> >
> > I found latest mm-unstable tree is failing kunit as below, and 'git bis=
ect'
> > says it happens from this patch.
> >
> >     $ ./tools/testing/kunit/kunit.py run --build_dir ../kunit.out/
> >     [11:56:40] Configuring KUnit Kernel ...
> >     [11:56:40] Building KUnit Kernel ...
> >     Populating config with:
> >     $ make ARCH=3Dum O=3D../kunit.out/ olddefconfig
> >     Building with:
> >     $ make ARCH=3Dum O=3D../kunit.out/ --jobs=3D36
> >     ERROR:root:In file included from .../mm/memory.c:71:
> >     .../include/linux/memory-tiers.h:143:25: warning: no previous proto=
type for =E2=80=98mt_find_alloc_memory_type=E2=80=99 [-Wmissing-prototypes]
> >       143 | struct memory_dev_type *mt_find_alloc_memory_type(int adist=
, struct list_head *memory_types)
> >           |                         ^~~~~~~~~~~~~~~~~~~~~~~~~
> >     .../include/linux/memory-tiers.h:148:6: warning: no previous protot=
ype for =E2=80=98mt_put_memory_types=E2=80=99 [-Wmissing-prototypes]
> >       148 | void mt_put_memory_types(struct list_head *memory_types)
> >           |      ^~~~~~~~~~~~~~~~~~~
> >     [...]
> >
> > Maybe we should set these as 'static inline', like below?  I confirmed =
this
> > fixes the kunit error.  May I ask your opinion?
> >
>
> Thanks for catching this. I'm trying to figure out this problem. Will get=
 back.
>

These kunit compilation errors can be solved by adding `static inline`
to the two complaining functions, the same solution you mentioned
earlier.

I've also tested on my end and I will send out a V10 soon. Thank you again!

> >
> > diff --git a/include/linux/memory-tiers.h b/include/linux/memory-tiers.=
h
> > index a44c03c2ba3a..ee6e53144156 100644
> > --- a/include/linux/memory-tiers.h
> > +++ b/include/linux/memory-tiers.h
> > @@ -140,12 +140,12 @@ static inline int mt_perf_to_adistance(struct acc=
ess_coordinate *perf, int *adis
> >         return -EIO;
> >  }
> >
> > -struct memory_dev_type *mt_find_alloc_memory_type(int adist, struct li=
st_head *memory_types)
> > +static inline struct memory_dev_type *mt_find_alloc_memory_type(int ad=
ist, struct list_head *memory_types)
> >  {
> >         return NULL;
> >  }
> >
> > -void mt_put_memory_types(struct list_head *memory_types)
> > +static inline void mt_put_memory_types(struct list_head *memory_types)
> >  {
> >
> >  }
> >
> >
> > Thanks,
> > SJ
>
>
>
> --
> Best regards,
> Ho-Ren (Jack) Chuang
> =E8=8E=8A=E8=B3=80=E4=BB=BB



--=20
Best regards,
Ho-Ren (Jack) Chuang
=E8=8E=8A=E8=B3=80=E4=BB=BB

