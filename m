Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE2B2C54FC6
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 04:19:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smQQc-00023n-3K; Fri, 06 Sep 2024 00:18:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stevensd@chromium.org>)
 id 1smQQa-00023I-V2
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 00:18:32 -0400
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stevensd@chromium.org>)
 id 1smQQW-0000pG-HC
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 00:18:32 -0400
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-535be093a43so1857697e87.3
 for <qemu-devel@nongnu.org>; Thu, 05 Sep 2024 21:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1725596306; x=1726201106; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dAK6vkQpWPe17/Fko+ir6F9GCq0rnozh/alsNYeYKj8=;
 b=BaJG4FmXXIeioBl3aCxhSditoJmmAdfqSje6Bu6sQeLURKTESLYsXPGQypdE8rTndp
 f7upumGTI8745sncI8VCNQG/oC8pg5lqRsE0uT1Oyngwoow5z5Oxcoj42lavIKOUU0g5
 ewpyqp2TpMW5qD9t9cO1kL1ZhHvVxiGm6P0as=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725596306; x=1726201106;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dAK6vkQpWPe17/Fko+ir6F9GCq0rnozh/alsNYeYKj8=;
 b=KSfcxqRD/65m6bBeG8+4LkBgZr51hiaPtVZCk2EqkeLuGk0uHcpHEGqpR3ejLmf9PU
 79ZADmoUP5njAoSRjIvZgDeyJ5+60p2E26SUL3BTH+CvG0Ozs9wOMaAIEa9mS4QuqWgA
 lk8VXeglJAeUP63X5nTCyGKeMRBhmFeS55DQx5rPkS6dWEqUrd9/a1RxCuadtnqrN0DB
 S7i4XYAst9Ch4ADSPfqWi3uHVc2ZDKX9DUx5wuZpTrLj1Nvd6fy1cOaT0eekrnTT9Znr
 iqTc/luhCrTpulHsp6G4k54w7tpHsHx3U1I39q+z74pVIYyjaEsdAShyg4b8B1afpiWw
 K8wQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVAMfLesNR9DtJ9IxENZCtsTv0AF5LWmXVNs9G5PUtjfr50IN5oNJ4aX48TX/1PnZybmEnnl3vI5v0e@nongnu.org
X-Gm-Message-State: AOJu0YxSae9gphwJSxnEE96f02zwOI6pUVfvQI0EzRF43pCwTOzoij/i
 7iwBt11J9ePUjStNB4jHyoVwtkg2kpoez281DPuBKZKuu3BjbLmE6Tg9364gKitrw8rQjAfr+kE
 4hDIWRTgl1jlfj7Nh/5ZaFmYB6e/gT8hBkUjl
X-Google-Smtp-Source: AGHT+IGxOiqZMGJ/LWTdS5YWYndMK0l5KOsHuxlXcofMabBe6zaUNgQBxMbiPmCBfFcV2ahC3nw9uBePsY/9a4uIV8I=
X-Received: by 2002:a05:6512:3d1b:b0:536:5530:af46 with SMTP id
 2adb3069b0e04-53658813100mr565152e87.52.1725596305428; Thu, 05 Sep 2024
 21:18:25 -0700 (PDT)
MIME-Version: 1.0
References: <20240628145710.1516121-1-aesteve@redhat.com>
 <87bk34i4dy.fsf@alyssa.is>
 <CAD=HUj7av_8Epkd0Fe0eWR7Z4bZMTuvTNgqzYoQcOzFQ82wvOg@mail.gmail.com>
 <20240712014407-mutt-send-email-mst@kernel.org>
 <CAD=HUj7iDbwnojq5a68s6B3S8z4vtpCa=B=9+ZBVYZV50zG+5g@mail.gmail.com>
 <20240905155643.GD1922502@fedora>
In-Reply-To: <20240905155643.GD1922502@fedora>
From: David Stevens <stevensd@chromium.org>
Date: Fri, 6 Sep 2024 13:18:14 +0900
Message-ID: <CAD=HUj4+it29pQnOhvvTE+QtizKR4Yu5VQPOHkF+scj2JmNJ-A@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/5] vhost-user: Add SHMEM_MAP/UNMAP requests
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Alyssa Ross <hi@alyssa.is>,
 Albert Esteve <aesteve@redhat.com>, 
 qemu-devel@nongnu.org, jasowang@redhat.com, david@redhat.com, slp@redhat.com, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=stevensd@chromium.org; helo=mail-lf1-x133.google.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Fri, Sep 6, 2024 at 12:56=E2=80=AFAM Stefan Hajnoczi <stefanha@redhat.co=
m> wrote:
>
> On Tue, Jul 16, 2024 at 10:21:35AM +0900, David Stevens wrote:
> > On Fri, Jul 12, 2024 at 2:47=E2=80=AFPM Michael S. Tsirkin <mst@redhat.=
com> wrote:
> > >
> > > On Fri, Jul 12, 2024 at 11:06:49AM +0900, David Stevens wrote:
> > > > On Thu, Jul 11, 2024 at 7:56=E2=80=AFPM Alyssa Ross <hi@alyssa.is> =
wrote:
> > > > >
> > > > > Adding David Stevens, who implemented SHMEM_MAP and SHMEM_UNMAP i=
n
> > > > > crosvm a couple of years ago.
> > > > >
> > > > > David, I'd be particularly interested for your thoughts on the ME=
M_READ
> > > > > and MEM_WRITE commands, since as far as I know crosvm doesn't imp=
lement
> > > > > anything like that.  The discussion leading to those being added =
starts
> > > > > here:
> > > > >
> > > > > https://lore.kernel.org/qemu-devel/20240604185416.GB90471@fedora.=
redhat.com/
> > > > >
> > > > > It would be great if this could be standardised between QEMU and =
crosvm
> > > > > (and therefore have a clearer path toward being implemented in ot=
her VMMs)!
> > > >
> > > > Setting aside vhost-user for a moment, the DAX example given by Ste=
fan
> > > > won't work in crosvm today.
> > > >
> > > > Is universal access to virtio shared memory regions actually mandat=
ed
> > > > by the virtio spec? Copying from virtiofs DAX to virtiofs sharing
> > > > seems reasonable enough, but what about virtio-pmem to virtio-blk?
> > > > What about screenshotting a framebuffer in virtio-gpu shared memory=
 to
> > > > virtio-scsi? I guess with some plumbing in the VMM, it's solvable i=
n a
> > > > virtualized environment. But what about when you have real hardware
> > > > that speaks virtio involved? That's outside my wheelhouse, but it
> > > > doesn't seem like that would be easy to solve.
> > >
> > > Yes, it can work for physical devices if allowed by host configuratio=
n.
> > > E.g. VFIO supports that I think. Don't think VDPA does.
> >
> > I'm sure it can work, but that sounds more like a SHOULD (MAY?),
> > rather than a MUST.
> >
> > > > For what it's worth, my interpretation of the target scenario:
> > > >
> > > > > Other backends don't see these mappings. If the guest submits a v=
ring
> > > > > descriptor referencing a mapping to another backend, then that ba=
ckend
> > > > > won't be able to access this memory
> > > >
> > > > is that it's omitting how the implementation is reconciled with
> > > > section 2.10.1 of v1.3 of the virtio spec, which states that:
> > > >
> > > > > References into shared memory regions are represented as offsets =
from
> > > > > the beginning of the region instead of absolute memory addresses.=
 Offsets
> > > > > are used both for references between structures stored within sha=
red
> > > > > memory and for requests placed in virtqueues that refer to shared=
 memory.
> > > >
> > > > My interpretation of that statement is that putting raw guest physi=
cal
> > > > addresses corresponding to virtio shared memory regions into a vrin=
g
> > > > is a driver spec violation.
> > > >
> > > > -David
> > >
> > > This really applies within device I think. Should be clarified ...
> >
> > You mean that a virtio device can use absolute memory addresses for
> > other devices' shared memory regions, but it can't use absolute memory
> > addresses for its own shared memory regions? That's a rather strange
> > requirement. Or is the statement simply giving an addressing strategy
> > that device type specifications are free to ignore?
>
> My recollection of the intent behind the quoted section is:
>
> 1. Structures in shared memory that point to shared memory must used
>    relative offsets instead of absolute physical addresses.
> 2. Virtqueue requests that refer to shared memory (e.g. map this page
>    from virtiofs file to this location in shared memory) must use
>    relative offsets instead of absolute physical addresses.
>
> In other words, shared memory must be relocatable. Don't assume Shared
> Memory Regions have an absolute guest physical address. This makes
> device implementations independent of the guest physical memory layout
> and might also help when Shared Memory Regions are exposed to guest
> user-space where the guest physical memory layout isn't known.

Doesn't this discussion contradict the necessity of point 1? If I'm
understanding things correctly, it is valid for virtio device A to
refer to a structure in virtio device B's shared memory region by
absolute guest physical address. At least there is nothing in the spec
about resolving shmid values among different virtio devices, so
absolute guest physical addresses is the only way this sharing can be
done. And if it's valid for a pointer to a structure in a shared
memory region to exist, it's not clear to me why you can't have
pointers within a shared memory region.

It definitely makes sense that setting up a mapping should be done
with offsets. But unless a shared memory region can be dynamically
reallocated at runtime, then it doesn't seem necessary to ban pointers
within a shared memory region.

-David

