Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8B3FCD1292
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Apr 2024 21:05:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsUGj-0003TJ-Hb; Thu, 04 Apr 2024 17:05:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <horenchuang@bytedance.com>)
 id 1rsUGh-0003Sl-1M
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 17:05:07 -0400
Received: from mail-yw1-x1132.google.com ([2607:f8b0:4864:20::1132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <horenchuang@bytedance.com>)
 id 1rsUGe-0000kI-9L
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 17:05:06 -0400
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-614b02f8ed6so22803747b3.0
 for <qemu-devel@nongnu.org>; Thu, 04 Apr 2024 14:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1712264702; x=1712869502; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3BEwoI7vaLN7STH+6B1HZ1H40SSE9uFhmcRIVexkA4A=;
 b=GN1CdMq0lsETZiTKKubhh4+CdblUqmJtqgmok/UsHE0Vk7NukDUTWkY4YWLMlmHB3i
 6lAwy70tbomvy9a6NQsPZaJAiF35iT4M75gQjsngpq1LbtLa8STn3DW+mZziapxVQtaM
 94wPpV8Pee0ysF7GNJEcQYy5SGEPAhlEPdVoN/nKJpWQO1h26aHTuGPyiUKJmzgBvP6q
 YmblsCWB9h3z9VfZHs9ba+MW29BRz8SfLf+ofNocY2ctWqCQC+w/TZBmb/RbNxd+lVBR
 TfLclWEEdIFjsIc1K7sycr9o64Pzr8p3+JVsWVnz4is1q42D5GJDiH/BT2ap54W1kZK4
 dmpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712264702; x=1712869502;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3BEwoI7vaLN7STH+6B1HZ1H40SSE9uFhmcRIVexkA4A=;
 b=DoIhWPebutPc2uB623bCnWtC+FZeLViqZifjUREE9hJLEGpzOpPJoo+JegsWdCdcLs
 oeb4BH1EBfF9RNbAxANLYSaG0nhzdDJVptYXg59SodlcSNAr8C//HDF7e+AZ95cofciG
 fAjoHKMoTtEAu2Fi9zM8sBgI5WW418YYgVcWCRzhamyhRn8pf1KKhHqV26IvQ6E8iea1
 +CVIdcUMupquIwjL767YbcYT56lmDrEuvnfjiLM2yIKfX3SwqzftKuP4R6EmVqhbejJ7
 6epw7imvDJktmGkR7Lrczn9SVois1btmEU10wUq/Uw+0IhMaZxAzc2PjVq7XHymvDecM
 B8KA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVWw2oCEY/2ICaFnXW7EDpgCwBR2Dt3/gcxKB5JHtgorOEUQRlGJtSQiXUOVjl4oFwD7QAHv3OHCax0/JvNyWc5srEfoi0=
X-Gm-Message-State: AOJu0YxSkOFWdMmftj/yJ+OLtrf6Qxd7khuBebro4m0wo3W7cTNk+A7p
 mN0+Uz5VZ7q5MEhaP+Bp9A9i6Pnmf4kZQCbhdwaaMzVAbMOMrAq+wqIqXtAKtM6N9v7uXFgKeNq
 HDfhesh8qqEYq9t2WDkwKHBxC76Al5OFXDqHJtw==
X-Google-Smtp-Source: AGHT+IG6KpWakGj8bl6wl0XaCmeiykXs6HQkS3DMCudH9AT087DNiiXeU48IwUZnyWYEgunzOmtd5Z4JvSn2JDWo2cM=
X-Received: by 2002:a25:bc50:0:b0:dcc:5b7e:ddfe with SMTP id
 d16-20020a25bc50000000b00dcc5b7eddfemr549930ybk.4.1712264702360; Thu, 04 Apr
 2024 14:05:02 -0700 (PDT)
MIME-Version: 1.0
References: <20240402001739.2521623-1-horenchuang@bytedance.com>
 <20240402001739.2521623-3-horenchuang@bytedance.com>
 <20240403180425.00003be0@Huawei.com>
 <CAKPbEqoJZe+HWHhCvBTVSHXffGY2ign3Htp4pfbFb4YVJS_Q2A@mail.gmail.com>
 <20240404143733.00004594@Huawei.com>
In-Reply-To: <20240404143733.00004594@Huawei.com>
From: "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>
Date: Thu, 4 Apr 2024 14:04:51 -0700
Message-ID: <CAKPbEqpp-mFv0bnOPtk0hFYVqA5y-e-T3QMWrS19g00Mob6D+g@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v10 2/2] memory tier: create CPUless memory
 tiers after obtaining HMAT info
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: "Huang, Ying" <ying.huang@intel.com>,
 Gregory Price <gourry.memverge@gmail.com>, 
 aneesh.kumar@linux.ibm.com, mhocko@suse.com, tj@kernel.org, 
 john@jagalactic.com, Eishan Mirakhur <emirakhur@micron.com>, 
 Vinicius Tavares Petrucci <vtavarespetr@micron.com>,
 Ravis OpenSrc <Ravis.OpenSrc@micron.com>, 
 Alistair Popple <apopple@nvidia.com>,
 Srinivasulu Thanneeru <sthanneeru@micron.com>, 
 SeongJae Park <sj@kernel.org>, Dan Williams <dan.j.williams@intel.com>, 
 Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
 Andrew Morton <akpm@linux-foundation.org>, nvdimm@lists.linux.dev, 
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Linux Memory Management List <linux-mm@kvack.org>,
 "Ho-Ren (Jack) Chuang" <horenc@vt.edu>, 
 "Ho-Ren (Jack) Chuang" <horenchuang@gmail.com>, qemu-devel@nongnu.org, 
 Hao Xiang <hao.xiang@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1132;
 envelope-from=horenchuang@bytedance.com; helo=mail-yw1-x1132.google.com
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

Hi Jonathan,

Thank you! I will fix them and send a V11 soon.

On Thu, Apr 4, 2024 at 6:37=E2=80=AFAM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> <snip>
>
> > > > @@ -858,7 +910,8 @@ static int __init memory_tier_init(void)
> > > >        * For now we can have 4 faster memory tiers with smaller adi=
stance
> > > >        * than default DRAM tier.
> > > >        */
> > > > -     default_dram_type =3D alloc_memory_type(MEMTIER_ADISTANCE_DRA=
M);
> > > > +     default_dram_type =3D mt_find_alloc_memory_type(MEMTIER_ADIST=
ANCE_DRAM,
> > > > +                                                                  =
   &default_memory_types);
> > >
> > > Unusual indenting.  Align with just after (
> > >
> >
> > Aligning with "(" will exceed 100 columns. Would that be acceptable?
> I think we are talking cross purposes.
>
>         default_dram_type =3D mt_find_alloc_memory_type(MEMTIER_ADISTANCE=
_DRAM,
>                                                       &default_memory_typ=
es);
>
> Is what I was suggesting.
>

Oh, now I see. Thanks!

> >
> > > >       if (IS_ERR(default_dram_type))
> > > >               panic("%s() failed to allocate default DRAM tier\n", =
__func__);
> > > >
> > > > @@ -868,6 +921,14 @@ static int __init memory_tier_init(void)
> > > >        * types assigned.
> > > >        */
> > > >       for_each_node_state(node, N_MEMORY) {
> > > > +             if (!node_state(node, N_CPU))
> > > > +                     /*
> > > > +                      * Defer memory tier initialization on CPUles=
s numa nodes.
> > > > +                      * These will be initialized after firmware a=
nd devices are
> > >
> > > I think this wraps at just over 80 chars.  Seems silly to wrap so tig=
htly and not
> > > quite fit under 80. (this is about 83 chars.
> > >
> >
> > I can fix this.
> > I have a question. From my patch, this is <80 chars. However,
> > in an email, this is >80 chars. Does that mean we need to
> > count the number of chars in an email, not in a patch? Or if I
> > missed something? like vim configuration or?
>
> 3 tabs + 1 space + the text from * (58)
> =3D 24 + 1 + 58 =3D 83
>
> Advantage of using claws email for kernel stuff is it has a nice per char=
acter
> ruler at the top of the window.
>
> I wonder if you have a different tab indent size?  The kernel uses 8
> characters.  It might explain the few other odd indents if perhaps
> you have it at 4 in your editor?
>
> https://www.kernel.org/doc/html/v4.10/process/coding-style.html
>

Got it. I was using tab=3D4. I will change to 8. Thanks!

> Jonathan
>
> >
> > > > +                      * initialized.
> > > > +                      */
> > > > +                     continue;
> > > > +
> > > >               memtier =3D set_node_memory_tier(node);
> > > >               if (IS_ERR(memtier))
> > > >                       /*
> > >
> >
> >
>


--=20
Best regards,
Ho-Ren (Jack) Chuang
=E8=8E=8A=E8=B3=80=E4=BB=BB

