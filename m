Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D631CCA0EF8
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Aug 2025 14:48:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1up6Zd-0004dx-2l; Thu, 21 Aug 2025 10:47:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1up6ZX-0004as-5g
 for qemu-devel@nongnu.org; Thu, 21 Aug 2025 10:47:24 -0400
Received: from mail-yb1-xb2b.google.com ([2607:f8b0:4864:20::b2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1up6ZU-0000Qc-3i
 for qemu-devel@nongnu.org; Thu, 21 Aug 2025 10:47:22 -0400
Received: by mail-yb1-xb2b.google.com with SMTP id
 3f1490d57ef6-e94e40fd4f1so1084623276.2
 for <qemu-devel@nongnu.org>; Thu, 21 Aug 2025 07:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755787638; x=1756392438; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bvHFQDqOHDR2ImKQftowTJ1dNGFZDFpNaySfWl1A+4w=;
 b=JWbjs+amOAGXaMe7OCPFX97lDNDuZ+PFrgjt3dwMJiu1idt1yNDOzyC/mk3FGBT+/s
 FojJXwJz7CH+66vyljpcCSPkwByqwQT3vicP4B7z1erLAGoyrfjG5CC0da8FAEygI61q
 yA+DmV3mKa6ytVkbiI9b9g7kue7wYffzgLumpE/ExBmkAeEyY8f70OwvK4x6QFexGYqg
 IBh/StfrvyxJEzcp4pM74aPefOJf05+JGon0N9rwtY3+YK/AbkNOqAEHsCy9EqjYi3yg
 NSWqg1nP8Nj7XloAIZOiRl20aYScdhp/MfT/GSZe+dv/FJ6mQSHF41E1KVPQT7BaJ6dQ
 Gr3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755787638; x=1756392438;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bvHFQDqOHDR2ImKQftowTJ1dNGFZDFpNaySfWl1A+4w=;
 b=L1rRcn/k9Fa0B1ZvcIQHMknl0d5Yf503PvnPDYS+G472sQHPVANFFxK5PsOELcWPgT
 ulaHJc8XR54JGUpHQt9/8aujuNQ8V8ho8IhmeOkWFiMN/ktv84nq3fzLz7dJi/BGmGeN
 VBmhymvSyiBXUEx1Y+iN7sVwJNM9sUKm8WDgO2D3/LX3EBuWZ8Uz92lkExaioFWkzXuI
 UptRi7uiYMM5gszi3DjdUxIzFS2Rmkg4exhvBSlqPZvwH1NM+1pSb5l3kOcNTPAqWDLZ
 7zEuRTGLBPQArGUOFhITf4BbFpgr4+Ohd+/cc/eIO5qowJPxfKI6GiDWsvti09PDLKXh
 ++8g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVjMSJQJCV5SQYXKEjyCgBVFHhMh86jC1rbEFwK9HuAXUKr8a+MI6nWKUeouF2k3+d8fgAHM8EBX0ji@nongnu.org
X-Gm-Message-State: AOJu0Yy9XsGJdXIMngwb4jqbR5mGdARaUgHUKKQA7pNm0iIJ/7KmRfxn
 RCQj3yWfbqWwoc8/Nevm/XS2wYh5RNYwkDLx6YZHMH/Vk9b/5RpKyEoJNjCbxgg4pdt3sCvt7GO
 wW0vSptBWS8q5jeH40TMJZaqcqHAQVqmHsdjXuSc9Fw==
X-Gm-Gg: ASbGnctdf8CWzrkhQ8gpvB4BZr9a/o/oJEYaFN0dM72MeElHqAtoBfmUwATJx+9xX+b
 swAa8gUgHr57BAosUnyzJBWjqjZ/anwj7jPc+AlEln2RVjQ+P6lmz/Y3Yap/m776yXURaNRbEuc
 YiuDFQXpJDhQg/D2teCapp5W+PFIYSvGF8fxCYqr1/m5nBt4daLMBNZamCDbwTyULyNwMfZNHSn
 kOVDeB6
X-Google-Smtp-Source: AGHT+IEQxvug7Y8254CH1eh9VKqmbINJ8ESgNsBpTbzoZQdSGrQwap6M7SQN4SKKmMjLLMM6kJnFCYj/X6rpdt0+ndo=
X-Received: by 2002:a05:6902:1890:b0:e94:e1e5:377d with SMTP id
 3f1490d57ef6-e9509b9f87emr3508019276.51.1755787638120; Thu, 21 Aug 2025
 07:47:18 -0700 (PDT)
MIME-Version: 1.0
References: <20250110-san-v8-0-57a5a1be1bcf@daynix.com>
 <20250110-san-v8-2-57a5a1be1bcf@daynix.com>
 <CAFEAcA-aTYebu-5s4AeBfE3oLQfxTwCpeosoj0TU8E_XPu_ZDg@mail.gmail.com>
 <CAFEAcA-ygHuA5BH+oftCGDKZOh8CHbiUKE4v=-iXvCaKzG4kHQ@mail.gmail.com>
 <aKctCjv8newNIX71@x1.local>
In-Reply-To: <aKctCjv8newNIX71@x1.local>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 21 Aug 2025 15:47:06 +0100
X-Gm-Features: Ac12FXzCfTRnLnffB-OdHJs-cXDH3-_5Hq0F0kEeeD52QfMDe1Yeyts9R-0jgPY
Message-ID: <CAFEAcA8DV40fGsci76r4yeP1P-SP_QjNRDD2OzPxjx5wRs0GEg@mail.gmail.com>
Subject: Re: [PATCH v8 2/2] memory: Do not create circular reference with
 subregion
To: Peter Xu <peterx@redhat.com>
Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Eduardo Habkost <eduardo@habkost.net>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Yanan Wang <wangyanan55@huawei.com>, John Snow <jsnow@redhat.com>, 
 BALATON Zoltan <balaton@eik.bme.hu>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, 
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Alexey Kardashevskiy <aik@ozlabs.ru>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>, 
 David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, 
 qemu-devel@nongnu.org, qemu-block@nongnu.org, qemu-ppc@nongnu.org, 
 devel@daynix.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2b.google.com
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

On Thu, 21 Aug 2025 at 15:28, Peter Xu <peterx@redhat.com> wrote:
> > On Thu, 21 Aug 2025 at 13:40, Peter Maydell <peter.maydell@linaro.org> wrote:
> > > In memory_region_unref_subregion(), subregion->container is NULL.
> > >
> > > This is because in memory_region_del_subregion() we do:
> > >
> > >     subregion->container = NULL;
> > >
> > > and then after that we call
> > >     memory_region_unref_subregion(subregion);
> > > which dereferences subregion->container.
> > >
> > > Won't this always SEGV ?

> Peter, could you try the v3 version patch 8/9 instead?
>
> https://lore.kernel.org/all/20240708-san-v3-8-b03f671c40c6@daynix.com/
>
> I still prefer that one, and I hope that one doesn't have this issue.

That one fails like this:
qemu-system-arm: ../../system/memory.c:1799: memory_region_finalize:
Assertion `!mr->container' failed.

See the discussion on v2 (which was the same for this patch):
https://lore.kernel.org/all/CAFEAcA9KTSjwF1rABpM5nv9UFuKqZZk6+Qo4PEF4+rTirNi5fQ@mail.gmail.com/

thanks
-- PMM

