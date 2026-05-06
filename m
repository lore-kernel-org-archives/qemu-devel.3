Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 856E4CD342C
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 07:44:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKWvB-0000QL-3I; Wed, 06 May 2026 03:43:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wKWv9-0000Q2-19
 for qemu-devel@nongnu.org; Wed, 06 May 2026 03:43:51 -0400
Received: from mail-qk1-x742.google.com ([2607:f8b0:4864:20::742])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wKWv7-00052S-7O
 for qemu-devel@nongnu.org; Wed, 06 May 2026 03:43:50 -0400
Received: by mail-qk1-x742.google.com with SMTP id
 af79cd13be357-8c70b5594f4so76865785a.1
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 00:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778053427; x=1778658227; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=7IgINgqhvcKXkDLzUwnKNApzrzTavNit7ECvB7toQsQ=;
 b=EUKLutl+JEECXcrBEfBG70ISrGxd7sBEs93CjKkUGwSGt0sBGNOeI4dVqWL0CqFBv7
 uZKS+eQbFl+GrIzqzuxMZCKG5M4cJzd14//MHa/x1zHQFBd9sYBwmkktef9bYpzt1a1L
 khnL1UpWWZiWc3SPgbuoTl9RZTwHilIewfUWNDDz1h4FczC4ZXizkhu7+/EP9+cXl3rh
 N6QRquiYxIf7X1ag0zfa5dihLOgs/6/pCYqaY5fZqGIXC3aG7LzbX2VHR7nzBnJBg+VD
 IKvAiu3zILWS6/+l9XtyuM7O8vqkqPuYEMtcemMtWDJKiEG4Kor7BTIcydIupXYbZE9/
 yDSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778053427; x=1778658227;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7IgINgqhvcKXkDLzUwnKNApzrzTavNit7ECvB7toQsQ=;
 b=BHIefL0I6ihSkeYmELOUddjrutzHUOFBAERtjCUrDq1AQnWPhGasWzxnbB4jLry2qV
 Zl97kcLfXEQG7Mf2F1LD/CXpTcusnlPxXPwBdx6+g5VUXfFpbkM8difHVzB6uxj7ZIGg
 Ke0pF0qIFoH7wiEkoa9KVCHIu6M7ZhkIFkywiDmoZEXPGJN4IgWlwySSU/GPiO8lMJCI
 f9ZOSxDV2fm1FOaM8kRSGrWLvQGXuC19FF33ZDrSJQRUvyMFLn07bYdyJ8OuZ9L+jWjB
 /BHus0rfZD3WJxTkuXvNZse15Ko11SFH7w2WSvNGxc7vnGbcxbpv2khmIvDCha1nrzMd
 ILUQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/+OpK2/lr6cWIru2a86mblCGrXvMPEGbXpXfCqehRq7YjtvvK0cJ3p31DUFxp/P0AljJOTtoawlL26@nongnu.org
X-Gm-Message-State: AOJu0YyeYVDmQ/m+yHyJjxjPppbhG2Qm5P2c2lN8wKcok1tio9vEdYI6
 9+lCEVEIHkiJeWl6eh4AlVJmnLJCWmiXF00ILhH0hOWI5qdsJz1U96CM
X-Gm-Gg: AeBDiev4rJkXy9F+tcN/A11WuxoO3WX0PQrlKe9aKYqzAPvFfx+7BY+S1m698G4THSf
 Xvt5r7XfPTdnMWVpdXiPvtlgx434d9d5jxbzxPn6Ix8ilspcPBteHGnAQD+tlE4ABudlUIgUEji
 2E67Oig6gpQQh8X4XPLWrYtarbaMv3k4hRKtbnT5wRVgBrhAo30f5wFfLi5ks5tnw7oWhF1F5aR
 UhnfHZwgU1dwNzsOakQRpH0pdEXWAoHYns+4/2v9RyrkP6/fh8HenuSpSJEK2C94JgHXh9stK/i
 tlL4JXYORiETiLprvelvNtR+a2gauJheSYZQxFVyfJRq12yYOv9YdnJVPCWit6eB9XYJwh0oSxe
 I26UOMgmwqwvfq79CzryCDB5gLLC5ZgCijjevz+79aR0rpxyr/Pxsl5N/Kw+cOTrYQja97CVuKW
 j8HSQowXQwM7m45jyoGaklIvATI8pdJM047AIaj8iaJegj+V7p0xeUF0B/MC0JrO65zbB/+3+Ra
 HpwVOKhWIU=
X-Received: by 2002:a05:620a:2886:b0:8da:4c20:50f0 with SMTP id
 af79cd13be357-902e2941fa9mr945397685a.8.1778053427106; 
 Wed, 06 May 2026 00:43:47 -0700 (PDT)
Received: from ZEVORN-PC.localdomain ([162.244.208.119])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8fc2667d5cesm1499234385a.0.2026.05.06.00.43.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 00:43:46 -0700 (PDT)
Date: Wed, 6 May 2026 15:43:29 +0800
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Alistair Francis <alistair23@gmail.com>
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Christoph Muellner <christoph.muellner@vrull.eu>,
 Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, Chao Liu <chao.liu@zevorn.cn>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Conor Dooley <conor@kernel.org>, Peng Jiang <3160104094@zju.edu.cn>
Subject: Re: [PATCH v6 1/5] target/riscv: add thead-c908 cpu support
Message-ID: <afrm70wKcCb3Ubsm@ZEVORN-PC.localdomain>
References: <cover.1776438369.git.chao.liu.zevorn@gmail.com>
 <e1a977e38c934a7f383530067230a6201b8ccc60.1776438369.git.chao.liu.zevorn@gmail.com>
 <CAKmqyKMipoe-YHVo5VGekUGG4uFJ7CEktipsOCSrSx=6b9=REA@mail.gmail.com>
 <aeWJKa4edHt6Djv3@ZEVORN-PC.localdomain>
 <CAKmqyKPWeYaELDhW7cBj_De10rN003ztGDHb0de3Jn=ef41wOw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKmqyKPWeYaELDhW7cBj_De10rN003ztGDHb0de3Jn=ef41wOw@mail.gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::742;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-qk1-x742.google.com
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

On Fri, May 01, 2026 at 02:02:04PM +1000, Alistair Francis wrote:
> On Mon, Apr 20, 2026 at 1:38 PM Chao Liu <chao.liu.zevorn@gmail.com> wrote:
> >
> > On Mon, Apr 20, 2026 at 09:49:50AM +1000, Alistair Francis wrote:
> > > On Sat, Apr 18, 2026 at 1:13 AM Chao Liu <chao.liu.zevorn@gmail.com> wrote:
> > > >
> > > > From: Chao Liu <chao.liu@zevorn.cn>
> > > >
> > > > The C908 processor is based on the RV64GCB[V] instruction
> > > > set, compatible to RVA22 Profile and implements the XIE
> > > > (XuanTie Instruction Extension) technology.
> > > >
> > > > Signed-off-by: Chao Liu <chao.liu.zevorn@gmail.com>
> > > > Suggested-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
> > > > Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> > > > Reviewed-by: Conor Dooley <conor@kernel.org>
> > >
> > > As Connor pointed out, he didn't add his Reviewed-by, instead he
> > > commented about a missing extension [1]. On top of that I don't see
> > > any instances of `Reviewed-by: Conor Dooley <conor@kernel.org>` in the
> > > QEMU tree, so I assume there are none on the mailing list as well.
> > > Which makes a copy and paste error seem less likely.
> > >
> > > I do see that Connor's reply was sent from his conor@kernel.org address,
> > > but manually stitching together a `Reviewed-by` and address seems
> > > unlikely to happen by accident. Although it does seem like the type of
> > > thing an LLM would do (see below).
> > >
> > Sorry, when I first started contributing to QEMU, I wasn't familiar with
> > mailing list conventions. I had been under the impression that whenever a
> > reviewer left comments, it was appropriate to carry a Reviewed-by tag into
> > the next revision. No one pointed this out at the time, but that was
> > clearly my oversight. My apologies to Alistair and Conor for the trouble
> > caused.
> 
> In future, only add tags that people specify. Please copy them
> directly or use b4, patchew or a similar tool to apply the tags.

Thanks for the review, way batter than manually tagging people :)

> 
> >
> > I made the same mistake on earlier patches as well:
> >
> > https://lore.kernel.org/qemu-devel/8b29b86a9af84edba54cc53aec017224478312bf.1745894489.git.lc00631@tecorigin.com/
> > https://lore.kernel.org/qemu-devel/501e578a4ef28515ccdefcbc82defc04363855ca.1746001489.git.lc00631@tecorigin.com/
> >
> > There is also a slightly different case where I added a Reviewed-by tag:
> >
> > https://lore.kernel.org/qemu-devel/07a97219e3f7e342c668d6772acc4c0a8eb4d4f3.1744709888.git.lc00631@tecorigin.com/
> >
> > There the R-b came from an internal colleague who reviewed the patch on
> > our side before it was sent upstream.
> >
> > Is that also against community convention?
> 
> No, internal colleagues are ok. Generally they provide little insight
> though. Your colleague would be better off engaging with the community
> as then the comments can be seen by everyone, that helps build trust
> between developers.
> 
You're right, we'll move more internal discussions to community
channels, so other developers can stay informed.

> >
> > > > Reported-by: Peng Jiang <3160104094@zju.edu.cn>
> > >
> > > I'm not sure how this can be Reported-by, it's not a bug fix. What was
> > > reported? It seems like the Reported-by appeared in v3 [2] and wasn't
> > > in v2 [3], yet I don't see anything reported.
> > >
> > This patchset is the project-phase output of a non-profit QEMU open-source
> > training camp we run in China; so far the camp has trained about 2000
> > participants. Peng Jiang is one of the members, and his task was bringing
> > up OpenSBI/RustSBI + Linux on the QEMU k230 board. For the specific
> > details, see:
> >
> > https://github.com/rustsbi/rustsbi/issues/160
> >
> > The Reported-by in v3 was added as a form of encouragement, since he
> > found several bugs during that bring-up work.
> 
> A Signed-off-by or Tested-by would probably be more appropriate then.
> Reported-by indicates that they found and reported a bug
> 
Peng Jiang tested the patchset, so Tested-by fits better. I will fix it
in the next version.

> >
> > Given this situation, should I also drop Peng Jiang's Reported-by tag?
> >
> > After the camp concluded, I asked him to report any further issues to the
> > upstream list directly himself — for example in v4:
> >
> > https://lore.kernel.org/qemu-devel/651b1d38.63ab7.19be50b4721.Coremail.3160104094@zju.edu.cn/
> >
> > > The extra and unexplained `Reviewed-by` (especially using an odd
> > > address as mentioned above) really points to this being LLM generated.
> > > Especially considering that your reviews are LLM generated (those are
> > > fine). Unfortunately that means I will need to decline the commits
> > > according to the QEMU Code Provenance rules [4]. Note that it isn't
> > > just the Code Provenance policy, it is also now really difficult to
> > > trust these patches knowing that stray `Reviewed-by` tags could be
> > > hallucinated and not caught before being submitted.
> > >
> > That said, I should clarify that no LLM assistance was used in developing
> > this patchset.
> 
> Ok, good to know :)
> 
> >
> > Finally, thanks to Alistair for the patient review. I'll be more careful
> > about these details in future contributions to avoid adding review burden
> > on maintainers/reviewers.
> 
> Thank you
> 
> Alistair

