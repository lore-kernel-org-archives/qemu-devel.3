Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD328CD128A
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Apr 2024 18:28:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrMNk-0004l1-23; Mon, 01 Apr 2024 14:27:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <horenchuang@bytedance.com>)
 id 1rrMNh-0004km-Qy
 for qemu-devel@nongnu.org; Mon, 01 Apr 2024 14:27:41 -0400
Received: from mail-yb1-xb2c.google.com ([2607:f8b0:4864:20::b2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <horenchuang@bytedance.com>)
 id 1rrMNf-0002tN-D3
 for qemu-devel@nongnu.org; Mon, 01 Apr 2024 14:27:41 -0400
Received: by mail-yb1-xb2c.google.com with SMTP id
 3f1490d57ef6-dd045349d42so3748487276.2
 for <qemu-devel@nongnu.org>; Mon, 01 Apr 2024 11:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1711996053; x=1712600853; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ncAfdDQGFs7+0XI6NTF6RR9ikr8USButMq6raz2KWU4=;
 b=cZEBqsRwBIa4Rjnh9rZRTYbRFA3oAvGxck52qzZJHomm+qYUNeJHba0S4FAqFjOxQP
 7lXIhWvgkhE1zVv+phyq/bMiFu6vja5C7jL70GjAnZZRLSiIzDTvITTHVyxb3+f9qbIl
 oPcxmdS0lQdyr/VSsQEfmEW6Mk8LFbN5Jkh8Q4+KP6FVvnEX+g2nSU/Y2R1DmErr6vWj
 2F0fzjAF5Z9qouoZQOZ7wy+ITT4qtaLxqUzyBDdMzP51wLBzYl2+D8QpZaPBasoJqo+t
 xrsl3RPmBpybMyWnlQ1nWJiBT6IY7rNAsDcjDeKXv65rmH09E7XGp9UhpJT3SSx4jAz4
 tg3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711996053; x=1712600853;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ncAfdDQGFs7+0XI6NTF6RR9ikr8USButMq6raz2KWU4=;
 b=SZjVRskAZl71vqdTaIm6CcTuqczYK4U4w5GR8mdIZFri5N8PGpQRtoajs4LrAWhrdf
 eH6ENMtAlEHRTExNzUsDOG8JDaTIFJjpAbxW6I6ce5xSMD+4uB+/lhm25S5ukbraJMa1
 cR48iuRlobzMX9UA1JNqVw7mxuAKyPiRsDj5H6b83e/azZMScgLtZVlWXdpi0nKYpyZY
 2tIUUN2QIVB0SQRhv3VSjwEkAE7HZuFFNwrr08ocShe2O2oIwXL28DetkhPfDNaSdtnq
 acWZndxaUKPXulaojQQxXU6xhqzQbcA1UBHE96rGIXtcFaG81YtDC1sF+MeDc/9P1TqP
 sJ2A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWHX1lDsX1nEuZkeJPCGzGk799PZSoQVTVrMe20L0tA/Ho6OOOD/vfUn9Mt5d092bqVttDS79JInli2Cg0cpnUQ7LpgwtM=
X-Gm-Message-State: AOJu0YwMoEfRjwCRVRl0FNNJZrZfkbcRCBoquXlNuTNVSlifHfyNzPP+
 v1Apw9+rmbA4l9M6Fy9rjdGs0htLyBGM3GySBkcngwWkFdrtuS/mfKabJK1bqGX/cHW7Ne53xin
 Scy5MJJ+WoFtGJBvbgbRQMHuCKZtqQsnKvvOmGw==
X-Google-Smtp-Source: AGHT+IEI9Qa2iIPgyqtzSTMMD59mn8yy6m6BsMg+kP0/hWrb91+VDm9zCf5PfWZzhMKbAlclVs3f+DNixIvCjL6iyp0=
X-Received: by 2002:a25:ff12:0:b0:dc6:d7b6:cce9 with SMTP id
 c18-20020a25ff12000000b00dc6d7b6cce9mr7881129ybe.57.1711996053583; Mon, 01
 Apr 2024 11:27:33 -0700 (PDT)
MIME-Version: 1.0
References: <20240329053353.309557-2-horenchuang@bytedance.com>
 <20240331190857.132490-1-sj@kernel.org>
In-Reply-To: <20240331190857.132490-1-sj@kernel.org>
From: "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>
Date: Mon, 1 Apr 2024 11:27:23 -0700
Message-ID: <CAKPbEqo3_zHF98SRoAz4L-CCGpEm8wN1P2RgPLa_q63e1qeGxQ@mail.gmail.com>
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

On Sun, Mar 31, 2024 at 12:09=E2=80=AFPM SeongJae Park <sj@kernel.org> wrot=
e:
>
> Hi Ho-Ren,
>
> On Fri, 29 Mar 2024 05:33:52 +0000 "Ho-Ren (Jack) Chuang" <horenchuang@by=
tedance.com> wrote:
>
> > Since different memory devices require finding, allocating, and putting
> > memory types, these common steps are abstracted in this patch,
> > enhancing the scalability and conciseness of the code.
> >
> > Signed-off-by: Ho-Ren (Jack) Chuang <horenchuang@bytedance.com>
> > Reviewed-by: "Huang, Ying" <ying.huang@intel.com>
> > ---
> >  drivers/dax/kmem.c           | 20 ++------------------
> >  include/linux/memory-tiers.h | 13 +++++++++++++
> >  mm/memory-tiers.c            | 32 ++++++++++++++++++++++++++++++++
> >  3 files changed, 47 insertions(+), 18 deletions(-)
> >
> [...]
> > diff --git a/include/linux/memory-tiers.h b/include/linux/memory-tiers.=
h
> > index 69e781900082..a44c03c2ba3a 100644
> > --- a/include/linux/memory-tiers.h
> > +++ b/include/linux/memory-tiers.h
> > @@ -48,6 +48,9 @@ int mt_calc_adistance(int node, int *adist);
> >  int mt_set_default_dram_perf(int nid, struct access_coordinate *perf,
> >                            const char *source);
> >  int mt_perf_to_adistance(struct access_coordinate *perf, int *adist);
> > +struct memory_dev_type *mt_find_alloc_memory_type(int adist,
> > +                                                     struct list_head =
*memory_types);
> > +void mt_put_memory_types(struct list_head *memory_types);
> >  #ifdef CONFIG_MIGRATION
> >  int next_demotion_node(int node);
> >  void node_get_allowed_targets(pg_data_t *pgdat, nodemask_t *targets);
> > @@ -136,5 +139,15 @@ static inline int mt_perf_to_adistance(struct acce=
ss_coordinate *perf, int *adis
> >  {
> >       return -EIO;
> >  }
> > +
> > +struct memory_dev_type *mt_find_alloc_memory_type(int adist, struct li=
st_head *memory_types)
> > +{
> > +     return NULL;
> > +}
> > +
> > +void mt_put_memory_types(struct list_head *memory_types)
> > +{
> > +
> > +}
>
> I found latest mm-unstable tree is failing kunit as below, and 'git bisec=
t'
> says it happens from this patch.
>
>     $ ./tools/testing/kunit/kunit.py run --build_dir ../kunit.out/
>     [11:56:40] Configuring KUnit Kernel ...
>     [11:56:40] Building KUnit Kernel ...
>     Populating config with:
>     $ make ARCH=3Dum O=3D../kunit.out/ olddefconfig
>     Building with:
>     $ make ARCH=3Dum O=3D../kunit.out/ --jobs=3D36
>     ERROR:root:In file included from .../mm/memory.c:71:
>     .../include/linux/memory-tiers.h:143:25: warning: no previous prototy=
pe for =E2=80=98mt_find_alloc_memory_type=E2=80=99 [-Wmissing-prototypes]
>       143 | struct memory_dev_type *mt_find_alloc_memory_type(int adist, =
struct list_head *memory_types)
>           |                         ^~~~~~~~~~~~~~~~~~~~~~~~~
>     .../include/linux/memory-tiers.h:148:6: warning: no previous prototyp=
e for =E2=80=98mt_put_memory_types=E2=80=99 [-Wmissing-prototypes]
>       148 | void mt_put_memory_types(struct list_head *memory_types)
>           |      ^~~~~~~~~~~~~~~~~~~
>     [...]
>
> Maybe we should set these as 'static inline', like below?  I confirmed th=
is
> fixes the kunit error.  May I ask your opinion?
>

Thanks for catching this. I'm trying to figure out this problem. Will get b=
ack.

>
> diff --git a/include/linux/memory-tiers.h b/include/linux/memory-tiers.h
> index a44c03c2ba3a..ee6e53144156 100644
> --- a/include/linux/memory-tiers.h
> +++ b/include/linux/memory-tiers.h
> @@ -140,12 +140,12 @@ static inline int mt_perf_to_adistance(struct acces=
s_coordinate *perf, int *adis
>         return -EIO;
>  }
>
> -struct memory_dev_type *mt_find_alloc_memory_type(int adist, struct list=
_head *memory_types)
> +static inline struct memory_dev_type *mt_find_alloc_memory_type(int adis=
t, struct list_head *memory_types)
>  {
>         return NULL;
>  }
>
> -void mt_put_memory_types(struct list_head *memory_types)
> +static inline void mt_put_memory_types(struct list_head *memory_types)
>  {
>
>  }
>
>
> Thanks,
> SJ



--=20
Best regards,
Ho-Ren (Jack) Chuang
=E8=8E=8A=E8=B3=80=E4=BB=BB

