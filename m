Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27D26FF8864
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2026 04:03:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIf5I-0006X6-Db; Fri, 01 May 2026 00:02:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wIf5H-0006TK-2V
 for qemu-devel@nongnu.org; Fri, 01 May 2026 00:02:35 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wIf5E-0005Qj-W0
 for qemu-devel@nongnu.org; Fri, 01 May 2026 00:02:34 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-ba51e69988aso264820866b.0
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 21:02:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777608151; cv=none;
 d=google.com; s=arc-20240605;
 b=VxDEudIheS8Zm71RFnLlar7j5rPVSUjcRXIL3SFGHWj+45CPFj4JzKv/i14d5AOtN9
 1YeV9VpoWyVIF9nQtf7y/9OwMq1iUKQK3yey3WGzjyGcRycC6Ysla4H2HbOZ84GL80fE
 JWTkmkwCmWNef62Fg8V93ktkOK7GbarubLCppGYT57p1uDTD+oU29WIPCi9ixaVSv2gR
 H2MtooXPaIkZxd/Kl7MjAEhEGmiGob/P+K/NeVPgFS9s7KWlI6tkeX6gzRqxufxdatOb
 MwRHpXCIsJJmxBVe/9LvsQVLsL2WXg0o1fOX8l/qJZcaCMUDw2Dg7rtSSwcBl2IOimJz
 gVEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=oSAPUnh+brlFly6jCWJieYL2zgNaNfnZI0wG5LhXnJY=;
 fh=mQuR0tWT+Rgl63KUpotfvTWBkNe40Y9gCTg1gHDVAeQ=;
 b=JJQjrnPyOKoZPraAnAYRfsyRHMK9tdOTxrq4xgYWOb+KLHFZzKmgOwHOI/zepn3uEU
 UQFS18pc1ZAu7fLRJUrarlZCL+D4POjliMDF7vQ0puqMWZk7b/yvRmU6t0d2YSjpq1ew
 19vaTyXlQ1w0K8qVY1tvuGMXKJgrMYXovO9idufcGk5JBhR7OvRti64q4Cvy5xPJgEaU
 SgCeE98LdsVKdzvOKCOFtxfw7JenbyDFkDklUUvKh8HpeyKrO0HMNlQiLcA/eZPYNi/2
 TKdlf1SailOmmMNLbd9ytYo+r+5yMTLx6yMW4mYwBl/NKHb8MdgrN1If9JhYQl5A8RHS
 a4iQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777608151; x=1778212951; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oSAPUnh+brlFly6jCWJieYL2zgNaNfnZI0wG5LhXnJY=;
 b=RSZkxhWnNs9T/gCl+ALtyzNW4XK/1L8x9GMBp5+Jy4abo2+JGcQwMwa2zG4oQjIq+u
 fXzr9EYlUEEVk57rBYhA+2e5J5k01mwh5VoTTwjUquecqA9bowYop2tGrSQGMEAxWNTC
 DUeN26ZxXPiBsbaSuItmEK6YYjXngxVq+9nEUhkMz4d3Bw4J05M9BLHhq1THGr/30YwK
 +rWUIFtrG0iCgk9bjWk4SMU1pwWXu/muZ+xWlFg9VG0H6yFwpa2Xrb1+g2ls74HediC2
 A0YlXYfeJtV6S8bPLjfe98b2lJBzr889i17THyT0rKyu8AKOuRmqfV2yXTLVx0OaqHL5
 w7bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777608151; x=1778212951;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=oSAPUnh+brlFly6jCWJieYL2zgNaNfnZI0wG5LhXnJY=;
 b=LGLULKMtUMV1WLsOQ42ma7anr91bn2eM9IQH77SWCwSUTBWNKhS+kMhFu+Jddg3nPe
 OKo4dAp4vcNHnYTwhEOgVgrDW9vqfr7vvna3T7/9dhtV1czy/gc1UMCDnAuxy5CWl/OA
 +IVp6+akT0NVpCpWshdJQAivStMR9h808LtZYbj5tyt3Yciemoy3N/u97VkqpjR4GC1e
 Lqvhhh7qtGlLme5vjTBqCESHInKyaMaMe87mQpQqWeXx0OeChhijstFodXFGo/F8Y2o0
 IRob+NhCN1tbkmOFUwSt1ICQMDiwSV7zlv1Css+mMZw3j32qC6wJRmhwmXyCAl2kTv5x
 gKVQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9Hzf2mA04FSF9sJhIywZUcWiwvLaq7iHxvfNllz2aQIo9hhKStd0DOO1g+WH4bRqWBJ9cOgj/quoVb@nongnu.org
X-Gm-Message-State: AOJu0YxziCOS9sVeafSM0IUNvt2rxG7Tz7wmOsZeWJJWEP77VLPUAZL6
 7IYzyNbZAMYEBcrR3jfO09IQiYrljkWIvf2rG+lQpUn3gbOcFj6gBCedxvty+PZ68BMOyhIj3fn
 +0rKBiu1JhXpAD3MkiOg0m0lbMxgg5W8=
X-Gm-Gg: AeBDievubEPIb3KuJEWu6PhI3oAfbVs/ZAebL4uPr9BxlomyTrENFuXwo8Sxa82rFQb
 5ScrNRiZOYk2wfIjE+W2FlgqR8jvN9CekUDBGAKcsAif2TzU5VK/ZJZo1NVAie/JWwbhxd2O2Oz
 OLZmkyWwI8YHNBuLRNY91eWr/M2w9Ure4RC2OgGFujSAYONokfAgnBhj6JHvlqyJyQMO/RaF/iy
 0y0ePfkevduHuGxhGpJQXOKfxdW48uCDl1S5rwSIBSKXhn9pbEJmuJfqBkih87w+e/TiaMTDArb
 Rmoi99Y04YCmnUMiv2ZLtFLMQFxseh/LBnHztXGVGKX62IQI
X-Received: by 2002:a17:907:a45:b0:bab:182a:1ea4 with SMTP id
 a640c23a62f3a-bbec0dedec7mr61854966b.34.1777608150910; Thu, 30 Apr 2026
 21:02:30 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1776438369.git.chao.liu.zevorn@gmail.com>
 <e1a977e38c934a7f383530067230a6201b8ccc60.1776438369.git.chao.liu.zevorn@gmail.com>
 <CAKmqyKMipoe-YHVo5VGekUGG4uFJ7CEktipsOCSrSx=6b9=REA@mail.gmail.com>
 <aeWJKa4edHt6Djv3@ZEVORN-PC.localdomain>
In-Reply-To: <aeWJKa4edHt6Djv3@ZEVORN-PC.localdomain>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 1 May 2026 14:02:04 +1000
X-Gm-Features: AVHnY4IHT_6p_h81b0S_J-9SAyxipk9kmN3fSxbo3_taImA9JbqdzEa9NNIerNo
Message-ID: <CAKmqyKPWeYaELDhW7cBj_De10rN003ztGDHb0de3Jn=ef41wOw@mail.gmail.com>
Subject: Re: [PATCH v6 1/5] target/riscv: add thead-c908 cpu support
To: Chao Liu <chao.liu.zevorn@gmail.com>
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 Christoph Muellner <christoph.muellner@vrull.eu>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 qemu-devel@nongnu.org, 
 qemu-riscv@nongnu.org, Chao Liu <chao.liu@zevorn.cn>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Conor Dooley <conor@kernel.org>, Peng Jiang <3160104094@zju.edu.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x62b.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Apr 20, 2026 at 1:38=E2=80=AFPM Chao Liu <chao.liu.zevorn@gmail.com=
> wrote:
>
> On Mon, Apr 20, 2026 at 09:49:50AM +1000, Alistair Francis wrote:
> > On Sat, Apr 18, 2026 at 1:13=E2=80=AFAM Chao Liu <chao.liu.zevorn@gmail=
.com> wrote:
> > >
> > > From: Chao Liu <chao.liu@zevorn.cn>
> > >
> > > The C908 processor is based on the RV64GCB[V] instruction
> > > set, compatible to RVA22 Profile and implements the XIE
> > > (XuanTie Instruction Extension) technology.
> > >
> > > Signed-off-by: Chao Liu <chao.liu.zevorn@gmail.com>
> > > Suggested-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
> > > Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> > > Reviewed-by: Conor Dooley <conor@kernel.org>
> >
> > As Connor pointed out, he didn't add his Reviewed-by, instead he
> > commented about a missing extension [1]. On top of that I don't see
> > any instances of `Reviewed-by: Conor Dooley <conor@kernel.org>` in the
> > QEMU tree, so I assume there are none on the mailing list as well.
> > Which makes a copy and paste error seem less likely.
> >
> > I do see that Connor's reply was sent from his conor@kernel.org address=
,
> > but manually stitching together a `Reviewed-by` and address seems
> > unlikely to happen by accident. Although it does seem like the type of
> > thing an LLM would do (see below).
> >
> Sorry, when I first started contributing to QEMU, I wasn't familiar with
> mailing list conventions. I had been under the impression that whenever a
> reviewer left comments, it was appropriate to carry a Reviewed-by tag int=
o
> the next revision. No one pointed this out at the time, but that was
> clearly my oversight. My apologies to Alistair and Conor for the trouble
> caused.

In future, only add tags that people specify. Please copy them
directly or use b4, patchew or a similar tool to apply the tags.

>
> I made the same mistake on earlier patches as well:
>
> https://lore.kernel.org/qemu-devel/8b29b86a9af84edba54cc53aec017224478312=
bf.1745894489.git.lc00631@tecorigin.com/
> https://lore.kernel.org/qemu-devel/501e578a4ef28515ccdefcbc82defc04363855=
ca.1746001489.git.lc00631@tecorigin.com/
>
> There is also a slightly different case where I added a Reviewed-by tag:
>
> https://lore.kernel.org/qemu-devel/07a97219e3f7e342c668d6772acc4c0a8eb4d4=
f3.1744709888.git.lc00631@tecorigin.com/
>
> There the R-b came from an internal colleague who reviewed the patch on
> our side before it was sent upstream.
>
> Is that also against community convention?

No, internal colleagues are ok. Generally they provide little insight
though. Your colleague would be better off engaging with the community
as then the comments can be seen by everyone, that helps build trust
between developers.

>
> > > Reported-by: Peng Jiang <3160104094@zju.edu.cn>
> >
> > I'm not sure how this can be Reported-by, it's not a bug fix. What was
> > reported? It seems like the Reported-by appeared in v3 [2] and wasn't
> > in v2 [3], yet I don't see anything reported.
> >
> This patchset is the project-phase output of a non-profit QEMU open-sourc=
e
> training camp we run in China; so far the camp has trained about 2000
> participants. Peng Jiang is one of the members, and his task was bringing
> up OpenSBI/RustSBI + Linux on the QEMU k230 board. For the specific
> details, see:
>
> https://github.com/rustsbi/rustsbi/issues/160
>
> The Reported-by in v3 was added as a form of encouragement, since he
> found several bugs during that bring-up work.

A Signed-off-by or Tested-by would probably be more appropriate then.
Reported-by indicates that they found and reported a bug

>
> Given this situation, should I also drop Peng Jiang's Reported-by tag?
>
> After the camp concluded, I asked him to report any further issues to the
> upstream list directly himself =E2=80=94 for example in v4:
>
> https://lore.kernel.org/qemu-devel/651b1d38.63ab7.19be50b4721.Coremail.31=
60104094@zju.edu.cn/
>
> > The extra and unexplained `Reviewed-by` (especially using an odd
> > address as mentioned above) really points to this being LLM generated.
> > Especially considering that your reviews are LLM generated (those are
> > fine). Unfortunately that means I will need to decline the commits
> > according to the QEMU Code Provenance rules [4]. Note that it isn't
> > just the Code Provenance policy, it is also now really difficult to
> > trust these patches knowing that stray `Reviewed-by` tags could be
> > hallucinated and not caught before being submitted.
> >
> That said, I should clarify that no LLM assistance was used in developing
> this patchset.

Ok, good to know :)

>
> Finally, thanks to Alistair for the patient review. I'll be more careful
> about these details in future contributions to avoid adding review burden
> on maintainers/reviewers.

Thank you

Alistair

