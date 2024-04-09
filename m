Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CD1FC67861
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 23:10:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruKbQ-0000FP-NC; Tue, 09 Apr 2024 19:10:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <horenchuang@bytedance.com>)
 id 1ruKbO-0000Em-UD
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 19:10:06 -0400
Received: from mail-yb1-xb2d.google.com ([2607:f8b0:4864:20::b2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <horenchuang@bytedance.com>)
 id 1ruKbM-00067B-HL
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 19:10:06 -0400
Received: by mail-yb1-xb2d.google.com with SMTP id
 3f1490d57ef6-dcc6fc978ddso5000256276.0
 for <qemu-devel@nongnu.org>; Tue, 09 Apr 2024 16:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1712704203; x=1713309003; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CBQMpIqEurG8MF/tPT1PXk9SqhO/wjdruY1OsEdLqVc=;
 b=b4FBEeVaazQ/1hw03PJMTI4YPxc66AagVrnJDgK2fJJ2WLf2X9R34rb4UdEt+8VsI+
 HMlJ59ytkUUDIs0zdr4bNefBZtDzQOz/Hr218jjStXSqD52V0OevaGF0CU0QZkw/kz94
 GlRiL/p4RNLOe3M9LF/hJxW3w85vEBVcCSadC0hlVDOLX8YybhYRQYcB9BCFxrISi/Hs
 8VQ/SzxQ4UX2jXENWOmrMA5u5f3pIOnOoGoZ06/A2ADthMXCWiQNcWQt1Zf7vzq2N5vr
 x4ctIo1Zx8ELuZtrXQ2UWoZKWHqkbjeGermXWENpPdSIkbIjz1JswpoAD6/uuP5sUjCD
 AUaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712704203; x=1713309003;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CBQMpIqEurG8MF/tPT1PXk9SqhO/wjdruY1OsEdLqVc=;
 b=KyiWhDtnT4Ifvq2UwsQX+rt1g+osOinHHbadOn2LFdFOlYeebuRGDkAKm1aiuv8hOW
 u+F9CfWBof73FfKhQuSkHIXkNXqTvdZLpnT/VMZM12oqvv5zWSJiJjEemKplYKh4Ds6l
 DXcJ2G7fD3Cio0iUHXBQeC6h6MQu0RUoGet5d84GeiwNUKtGvfgtVrKMR6fWYiHisnkN
 Z5XWZJiiSRA7L5UXL4IOO4aY1ogZNx6FrigUUxDyrLS8J+QF1bdwy5vdhro48Mxs/lB3
 VPKEFyJSw9yDaW37EjnUIiZCsicdG9yCtO+oW0GhlpguiZzqmGGOD8SlLN5iTUhMCmc+
 w5yA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUcdg8DR0M2vE3Ou0deWaGOqAIzkq1W2geObO+fchmXkwD/hjouZAOIdxtxnv/5oKyhZNYklec0O/f7GStpTovS6lVrJEo=
X-Gm-Message-State: AOJu0YxOoNyeuDk7mF2u4BK4nvkTR+aTIKFRddMeXmtImX4B1qq1MU7C
 wqONSfRsEMc+ppsu+BBRER9JjYNF1CUD2H4kvOl965bFD/AUfwOg+wKRJZRx8jBWZrWaEczJDNB
 xh8xkLzCP7yu26wMxvYXXPYqM+OGgzXA/KpgFGA==
X-Google-Smtp-Source: AGHT+IGKj70giI0uSMILbO3VPM9mbHT4HM6rigAIadI6TUaytzdkRQBEfqv4b6oKHX4IAAJuxwSf30E0yhjaCwWCgiY=
X-Received: by 2002:a25:f306:0:b0:de0:cd0f:e9ac with SMTP id
 c6-20020a25f306000000b00de0cd0fe9acmr2372195ybs.31.1712704202827; Tue, 09 Apr
 2024 16:10:02 -0700 (PDT)
MIME-Version: 1.0
References: <20240405000707.2670063-1-horenchuang@bytedance.com>
 <20240405000707.2670063-2-horenchuang@bytedance.com>
 <20240405145624.00000b31@Huawei.com>
 <CAKPbEqrTvY4bsRjc=wBWpGtJM5_ZfH50-EX4Zq2O_ram9_0WbQ@mail.gmail.com>
 <20240409145018.e2d240f9a742cc15ff7bc11e@linux-foundation.org>
In-Reply-To: <20240409145018.e2d240f9a742cc15ff7bc11e@linux-foundation.org>
From: "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>
Date: Tue, 9 Apr 2024 16:09:52 -0700
Message-ID: <CAKPbEqqWLrD-bJiyE9Yc0CYLh_8_uMtf+9nD_eenXh3S=Ro=pQ@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v11 1/2] memory tier: dax/kmem: introduce
 an abstract layer for finding, allocating, and putting memory types
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, "Huang,
 Ying" <ying.huang@intel.com>, 
 Gregory Price <gourry.memverge@gmail.com>, aneesh.kumar@linux.ibm.com,
 mhocko@suse.com, 
 tj@kernel.org, john@jagalactic.com, Eishan Mirakhur <emirakhur@micron.com>, 
 Vinicius Tavares Petrucci <vtavarespetr@micron.com>,
 Ravis OpenSrc <Ravis.OpenSrc@micron.com>, 
 Alistair Popple <apopple@nvidia.com>,
 Srinivasulu Thanneeru <sthanneeru@micron.com>, 
 SeongJae Park <sj@kernel.org>, Dan Williams <dan.j.williams@intel.com>, 
 Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 nvdimm@lists.linux.dev, 
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
 "Ho-Ren (Jack) Chuang" <horenc@vt.edu>,
 "Ho-Ren (Jack) Chuang" <horenchuang@gmail.com>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2d;
 envelope-from=horenchuang@bytedance.com; helo=mail-yb1-xb2d.google.com
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

On Tue, Apr 9, 2024 at 2:50=E2=80=AFPM Andrew Morton <akpm@linux-foundation=
.org> wrote:
>
> On Tue, 9 Apr 2024 12:00:06 -0700 "Ho-Ren (Jack) Chuang" <horenchuang@byt=
edance.com> wrote:
>
> > Hi Jonathan,
> >
> > On Fri, Apr 5, 2024 at 6:56=E2=80=AFAM Jonathan Cameron
> > <Jonathan.Cameron@huawei.com> wrote:
> > >
> > > On Fri,  5 Apr 2024 00:07:05 +0000
> > > "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com> wrote:
> > >
> > > > Since different memory devices require finding, allocating, and put=
ting
> > > > memory types, these common steps are abstracted in this patch,
> > > > enhancing the scalability and conciseness of the code.
> > > >
> > > > Signed-off-by: Ho-Ren (Jack) Chuang <horenchuang@bytedance.com>
> > > > Reviewed-by: "Huang, Ying" <ying.huang@intel.com>
> > > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawie.com>
> > >
> > Thank you for reviewing and for adding your "Reviewed-by"!
> > I was wondering if I need to send a v12 and manually add
> > this to the commit description, or if this is sufficient.
>
> I had added Jonathan's r-b to the mm.git copy of this patch.

Got it~ Thank you Andrew!

--=20
Best regards,
Ho-Ren (Jack) Chuang
=E8=8E=8A=E8=B3=80=E4=BB=BB

