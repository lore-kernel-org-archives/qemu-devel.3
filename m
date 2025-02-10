Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04ED3C0219E
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 14:23:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thUgv-0006DW-S5; Mon, 10 Feb 2025 09:23:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1thUgp-0006Cr-4g
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 09:23:12 -0500
Received: from mail-yb1-xb2d.google.com ([2607:f8b0:4864:20::b2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1thUgm-0006po-TM
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 09:23:10 -0500
Received: by mail-yb1-xb2d.google.com with SMTP id
 3f1490d57ef6-e5b296611d1so4324605276.1
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 06:23:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739197387; x=1739802187; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QPvyExTaD3QmjxtU+fytRH974XXHx/8qsCgK4X6TVI4=;
 b=imtihAFZF5X8mH0bmoObS3UG9Zod5pf27IgrjNI1WXYh74RMBs6vQ96tqf0MGtYM+C
 mVG6opDXOpn0r2C/R/derMYigvfikBrE55oKMwy37gIHcs9iheNHzJB+Dy/cI01PM4c9
 V7NWOBkZh8JHxV5CcyLvwHUDaYi/u3/JNWspcJwWKKed8VmJBQgDU+Bf1PcQXsDjrZg4
 mHww8mFhOLxv4W7HkRBFKFxUn1tqTAa1WcOHVBQ3G49o1SM91vlBf7iR/EO0NXBDHKar
 NDXDD99bMHNMQCV3HvvDRpIxwUHsyiItC6Vz/Dj9mi5FG3rUh0M1qGqgK2qNNufMM8za
 8wIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739197387; x=1739802187;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QPvyExTaD3QmjxtU+fytRH974XXHx/8qsCgK4X6TVI4=;
 b=ts7yyYKRu0vN3sr/PfWsnKbZrlcGlpPZjxqJxazs3B7ccTvhDSg7xCgZGBvE+oWvJ7
 P4mWCv1JcWUSAIQAzxIC0x8N/t36qrila6ftbkyJtOh6yctRg6gXKJtsDm7qjbERSVLi
 lABvqUmUqW4dHr9QzOvPphX7Wo20g9katPu1gGylAe3RL5Q9iQHroOKYOTTnQJuHPdC7
 dFYuLWjir2z96etRK0ErqKBregvQBuiEJDVFO4iX7ez07z7ov5ECkvBhYPoud7tdRA8D
 P8iLvVhRPS0ta8QvdasNpD0k58DHQPmFe3YBvhEnM/7xOZmopaPUF2T4MbEHkNKhvW3i
 xwsg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV4BERQVKmVkrhObtJz0vZMzObNNnw7DnktSgUX9IN38Ku5RyVCtS9lCqUc+IYAY9vGwM2PYTxOgeby@nongnu.org
X-Gm-Message-State: AOJu0YwZXFpPsGboNMICMLBQ1+PLM7A6bSrZHGKhVun1BbOjmZsn0SKC
 fQ4CBRZQxG5s2wtC2amA0hZnrZ9166rJslr7ZoYrcwVJBeXTM9WspjFpC6fTOTVq6ulkgL3R17X
 tpfTPVMWBtE+6v09KMg3TTuh5txbzklj1sNm/1/Tmm8lIgc1N
X-Gm-Gg: ASbGncthluZ1TX7gcez/uR7gyYfw3oX5JsBjvxKf4geRdzVLg5U9bu6sB7x4PcLaVcN
 pI58+pPVc/ouF8p7e9iU7PjvBn6oGYrjsLtuNd39NP/wCbAfMGldglcZe6dZfJIHkzYhdmVIj+A
 ==
X-Google-Smtp-Source: AGHT+IHkfHqDmMRDh9R13BLCfdAGB9/GHkKJjC//CmuHBjlvZYeQhY/43HAL1J+kBaUDtRa3gF21XMrIjex7RXMjfr4=
X-Received: by 2002:a05:6902:218f:b0:e5b:4651:b5c6 with SMTP id
 3f1490d57ef6-e5b46c9a8b8mr12117740276.23.1739197387591; Mon, 10 Feb 2025
 06:23:07 -0800 (PST)
MIME-Version: 1.0
References: <20250206142307.921070-1-eric.auger@redhat.com>
 <20250206142307.921070-5-eric.auger@redhat.com>
 <CAFEAcA_LgrBRbafVQ0vLGPd8xG=wsLjWnKTJ2JSEREYUqgRQBQ@mail.gmail.com>
 <7102d470-ac72-4c02-b8bc-20f1379a4843@redhat.com>
 <CAFEAcA-XK5GwT0b_Ff-8fYnWcDgzaE-0Ei-YqDoXv-aXFGNXUQ@mail.gmail.com>
 <Z6ZHTStx_S9ALdxt@x1.local>
 <CAFEAcA8ovoGsQ9oEco88iw3iUy_3kBOUaYHL+oq5VF-i9xg4+A@mail.gmail.com>
 <Z6oJzRCt_fJLfkmQ@x1.local>
In-Reply-To: <Z6oJzRCt_fJLfkmQ@x1.local>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 10 Feb 2025 14:22:56 +0000
X-Gm-Features: AWEUYZnWjovpjjUXcsKu10xZTHp8n_Z7dx_6vwaK5cZSlyL3OIC1egmzqup-5rE
Message-ID: <CAFEAcA9640s-Eu7PHxJ-Xb5X38n-25pnUG+GxymsAWkJf8YfcA@mail.gmail.com>
Subject: Re: [PATCH 4/5] hw/arm/smmuv3: Move reset to exit phase
To: Peter Xu <peterx@redhat.com>
Cc: eric.auger@redhat.com, eric.auger.pro@gmail.com, qemu-devel@nongnu.org, 
 qemu-arm@nongnu.org, mst@redhat.com, jasowang@redhat.com, imammedo@redhat.com, 
 alex.williamson@redhat.com, clg@redhat.com, philmd@linaro.org, 
 zhenzhong.duan@intel.com, ddutile@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Mon, 10 Feb 2025 at 14:14, Peter Xu <peterx@redhat.com> wrote:
>
> On Fri, Feb 07, 2025 at 06:18:50PM +0000, Peter Maydell wrote:
> > On Fri, 7 Feb 2025 at 17:48, Peter Xu <peterx@redhat.com> wrote:
> > >
> > > On Fri, Feb 07, 2025 at 04:58:39PM +0000, Peter Maydell wrote:
> > > > (I wonder if we ought to suggest quiescing outstanding
> > > > DMA in the enter phase? But it's probably easier to fix
> > > > the iommus like this series does than try to get every
> > > > dma-capable pci device to do something different.)
> > >
> > > I wonder if we should provide some generic helper to register vIOMMU reset
> > > callbacks, so that we'll be sure any vIOMMU model impl that will register
> > > at exit() phase only, and do nothing during the initial two phases.  Then
> > > we can put some rich comment on that helper on why.
> > >
> > > Looks like it means the qemu reset model in the future can be a combination
> > > of device tree (which resets depth-first) and the three phases model.  We
> > > will start to use different approach to solve different problems.
> >
> > The tree of QOM devices (i.e. the one based on the qbus buses
> > and rooted at the sysbus) resets depth-first, but it does so in
> > three phases: first we traverse everything doing 'enter'; then
> > we traverse everything doing 'hold'; then we traverse everything
> > doing 'exit'. There *used* to be an awkward mix of some things
> > being three-phase and some not, but we have now got rid of all
> > of those so a system reset does a single three-phase reset run
> > which resets everything.
>
> Right.  Sorry I wasn't very clear before indeed on what I wanted to
> express.
>
> My understanding is the 3 phases reset, even if existed, was not designed
> to order things like vIOMMU and devices that is already described by system
> topology.  That's, IMHO, exactly what QOM topology wanted to achieve right
> now on ordering device resets and the whole depth-first reset method would
> make sense with it.
>
> So from that specific POV, it's a mixture use of both methods on ordering
> of devices to reset now (rather than the order of reset process within a
> same device, provided into 3 phases).  It may not be very intuitive when
> someone reads about the two reset mechanisms, as one would naturally take
> vIOMMU as a root object of any other PCIe devices under root complex, and
> thinking the order should be guaranteed by QOM on reset already.  In
> reality it's not.  So that's the part I wonder if we want to document.

Yeah, I see what you mean. The issue here is that the iommu isn't
actually a parent of the devices that access through it. This is
true both in the "qbus/qdev bus tree" sense (where it is the PCI
controller device that owns the PCI bus that the devices are on)
and also in the QOM tree sense[*] (where usually the iommu and the
PCI controller are both created by the machine or the SoC, I guess?).
Instead iommus are separate devices that control data flow but
aren't in a parent-child relationship with the devices on either
side of that flow. There is a guarantee about reset ordering between
bus parent/child (so the PCI controller resets before it resets
the PCI bus that resets the PCI devices on the bus), but that doesn't
help the iommu.

[*] I have a vague idea that ideally we might want reset to be
QOM-tree based rather than qbus-tree based. But getting there from
here is non-trivial. And maybe what we really want is "objects,
especially SoCs, that create children can define what their reset
tree is, with the default being to reset all the QOM children".
Lots of non-thought-through complexity here ;-)

thanks
-- PMM

