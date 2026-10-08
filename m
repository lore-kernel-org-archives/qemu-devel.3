Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31DA5CA600C
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2026 16:40:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xErAe-0002nX-7e; Thu, 08 Oct 2026 12:40:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gromero@redhat.com>)
 id 1xErAc-0002hI-Nk
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 12:40:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gromero@redhat.com>)
 id 1xErAb-0007yn-4E
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 12:40:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791477636;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=43g9C1RPFzAiuQZ1xBBbot1se3n7VApX0Cnv5nQBlxw=;
 b=IbLNGQ4uBaZ/Ox7YxjY5RVjm8tBxeguSSkGRyRN1ZoIshsuW5hhLbV4M7FtEsaGuuKD2ID
 TMg7q9DQ+VfDvFVbuT5cEOFK+TSqY15U73dYxPmVBt3reveLtd/VhVT+gXxNWJAM80HDQk
 fI4YM5Xu4PsSlfShKswEBuXuMjJ9IMU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-374-hxKTWxTAOWSRMIpMMuDm3g-1; Thu, 08 Oct 2026 12:40:33 -0400
X-MC-Unique: hxKTWxTAOWSRMIpMMuDm3g-1
X-Mimecast-MFC-AGG-ID: hxKTWxTAOWSRMIpMMuDm3g_1791477632
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-48af4a0bd0fso3087050f8f.2
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2026 09:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1791477632; x=1792082432; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=43g9C1RPFzAiuQZ1xBBbot1se3n7VApX0Cnv5nQBlxw=;
 b=biDnW0w2GO4BpXMBPm9v5qCEBWYCR11SipLWY4w0QjUN3HLqRJyL4WeVNd0S0QuE+s
 fT7+QbgpDpLwjnrAQD/IhRk08nKdimC6WIsLz3TMVFgdGPkBtjgwbgtqzhOn2kZlpVl2
 mw7kGLfFU0uc96X+N8HLJ2PTUtwPkJriqkEN2AQjBS+yEtV2lEqkp9aFdzRFWZxJHJDs
 qSciOh7cgdU7gNdSyZHYnx+AktLWLPknZfrxMRAGEehBXf1C5yoiGO4qAAA7PSw59xPR
 ECYtAbAbcRHZiLTnXEWOqnK8LuUCUTjYgwFbWKS6boazjl6d/uw/0+Cp9NUwSHsR+lCU
 CMWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791477632; x=1792082432;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=43g9C1RPFzAiuQZ1xBBbot1se3n7VApX0Cnv5nQBlxw=;
 b=GSCkEwNNuziwaH0xDt5HCccnfZcyipcGd2JW4K1fQRWTieeDMKWAlzzZgDQycFkvK+
 4KyitB2+3s84ygC0/9nJwxYr1ZOlKUunEoWibQpJ7ES35b616J/flr7UoJ5ncJLKigS1
 pKA+UYSmJgvXyEWM45DbF48VclhEXlAIU6vusnhOO5LtzCfyknf+Py54WngnoAhMiJl9
 2jtzYMGfwV0+Henx+k66dlNQ6h9LuoRq/a3Hg9m1YdSQ2DvDAb24ANhnyXD+4XpeK1Gc
 8XzCNvBXxn+BDQ48ULt1wsK4WhRWId3rYbnbx3X5k3KJEv4/a2mstRF+ZW/Pih2T59tA
 qCmA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxNjv2UyEq1YcrS9TF4RRsbIZjFJ3EozbdijKYNoeuiv27AtRMGGfbsE2o1niWJeD96MWzT+5iHye0S@nongnu.org
X-Gm-Message-State: AFq9FYJ+tIZDVH0gjJTnUJVwpFhVNI1ploc0kQi96tpQ/3LtamTqq+XV
 460Y/FvbMdjS4X1LO1FnlbNkF6vBbshiP5yLlc3Kfk9ac6ypsavfwZMzFCDPTZQkrvA6PmS9r/E
 wbDzun63jlxU+nro5jw+zD1tQmLPMlXT52KgFJokmUAR8W8jPkcVxbcBD
X-Gm-Gg: AYBFou19hjTscBjwv3KmagXc5uN31zYUD7kHtxVt91fUk2a09bZx0U4rO3evmosiiuD
 qU2/DAh8GS8KYeypIB4dgs1hYnQDFu/l1Yy11FqsjPs5C73ntnHdiqICbiHxRAL2PHERAFtSJRs
 n3QumSAFCVm8oq9N7VqJKbg75KagapXKzOkOVxe18f/mz9PHL+3eV0CKZJTHtbsJ71nre4yC9JW
 NZDashA97Z3K2naAgM7xRTns9I1iP7bTtQdDaB7Namd79wCivC2QpDCPrOTKkKxBcx5TPQ9beNz
 ZPw+sTant53fhh0yFwvu9BNfSvQtloXcRQO2BJTWqL2yv6CNtNGjCQSDGw==
X-Received: by 2002:a05:6000:2f83:b0:488:8882:d514 with SMTP id
 ffacd0b85a97d-48c72890fe7mr11904348f8f.49.1791477632475; 
 Thu, 08 Oct 2026 09:40:32 -0700 (PDT)
X-Received: by 2002:a05:6000:2f83:b0:488:8882:d514 with SMTP id
 ffacd0b85a97d-48c72890fe7mr11904257f8f.49.1791477631683; 
 Thu, 08 Oct 2026 09:40:31 -0700 (PDT)
Received: from x1 ([151.67.89.12]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48db63ce3f9sm452471f8f.2.2026.10.08.09.40.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2026 09:40:30 -0700 (PDT)
Date: Thu, 8 Oct 2026 18:40:27 +0200
From: Gustavo Romero <gromero@redhat.com>
To: Fuad Tabba <fuad.tabba@linux.dev>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, 
 qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 Will Deacon <will@kernel.org>, Itaru Kitayama <itaru.kitayama@linux.dev>
Subject: Re: [PATCH v2 3/3] tests/tcg/aarch64: Add a test for the 52-bit TTBR
 base address layout
Message-ID: <3dqmrslvb3zrr3ndzmcmy2tv5vqovntordzdjqkp2vn2deklua@qkcedhe4owgv>
References: <20261007080019.350315-1-fuad.tabba@linux.dev>
 <20261007080019.350315-4-fuad.tabba@linux.dev>
 <4ajscli4c4ef7agtizxzdiopjseck5qwa6s4n4mmwwjdrqlnby@xit5l76dxm2w>
 <CA+EHjTxsC8K1Bw6fAMs6APaqVDpup8192dCeJs+vfeh2fN+6Aw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+EHjTxsC8K1Bw6fAMs6APaqVDpup8192dCeJs+vfeh2fN+6Aw@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=gromero@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi Fuad,

On Wed, Oct 07, 2026 at 11:29:11PM +0200, Fuad Tabba wrote:
> Hi Gustavo,
> 
> On Wed, 07 Oct 2026 17:56:30 +0100, Gustavo Romero <gromero@redhat.com> wrote:
> [...]
> > > With a 52-bit OA, walk a two-entry level 0 table through an IPA with
> > > bit 50 set, which stage 2 maps back onto the table, so the walk
> > > succeeds only if TTBR[4] is cleared from bit 4 of the base address.
> > > With TCR.DS or VTCR.DS and a 48-bit OA, check that setting TTBR[5:2]
> > > is a level 0 Address size fault.
> >
> > Maybe move this commit message to ttbr-baddr.c header and just replace it with
> > something like "Add a test for checking if with a 52-bit OA a walk ...".
> 
> Sure, I'll move it to the file header in v3.
> 
> > I like better the test split done in v1. There there are two tests and the
> > changes are clear, helping to understand which parts of the test are related to
> > each fix.
> >
> > So the organization I think is better for this series is:
> >
> > Fix 0
> > Test 0
> > Fix 1
> > Test 1
> 
> Ack.
> 
> [...]
> 
> > > +    /*
> > > +     * 52-bit OA: TTBR[4] is base address bit 50. Through stage 2, the
> > > +     * table at HIGH_IPA | s1_l0 is s1_l0, so the walk succeeds only if
> >
> > I struggled a bit to make sense of this part: "Through Stage 2, the table
> > HIGH_IPA | s1_l0 is s1_l0 ...", not so much for the duplication of s1_l0 in the
> > text but because Stage 2 uses the s2_l* tables. Any chance you could enhance a
> > the explanation here?
> 
> The level 0 table address is an IPA, and the s2_l2_high mapping is
> what brings it back to s1_l0. How about:
> 
>         /*
>          * 52-bit OA: TTBR[4] is base address bit 50, so with it set the
>          * level 0 table is at IPA HIGH_IPA | s1_l0. Stage 2 maps that IPA
>          * onto s1_l0 (through s2_l2_high), so the walk succeeds only if
>          * TTBR[4] does not also offset the two-entry table by 0x10.
>          */

Yep, that's good.

However, I missed one thing that I think is important to mention and that
confused me after a while not looking at these TCG tests:

RAM_BASE is precisely defined as 1 << 30 because the way we link the tests based
on the memory layout defined in tests/tcg/aarch64/system/kernel.ld, right?

That's the bit that also confused me, like, how Stage 2 entries:

s2_l2[RAM_BASE >> 29] = RAM_BASE | S2_BLOCK;
s2_l2_high[RAM_BASE >> 29] = RAM_BASE | S2_BLOCK 

are taking us back to s1_l0. How s1_l0 ends up related to RAM_BASE :)

Hence, I think it's worth mentioning that relationship also in this text. How
about something like:

"RAM_BASE is chosen to match the memory layout defined in kernel.ld. As a
result, s1_l0 resides at an offset from RAM_BASE after linking."

Wdyt?


> Thanks for the review. I'll respin once Richard and Peter have had a look.

np! Sure ;)


Cheers,
Gustavo


