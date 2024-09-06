Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9B54CE7AA3
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 13:01:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smYZy-0006Q7-IT; Fri, 06 Sep 2024 09:00:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1smYZs-0006OU-Rr
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 09:00:41 -0400
Received: from mail-oa1-x33.google.com ([2001:4860:4864:20::33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1smYZq-0005Ra-M6
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 09:00:40 -0400
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-277dd761926so1274366fac.2
 for <qemu-devel@nongnu.org>; Fri, 06 Sep 2024 06:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725627635; x=1726232435; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vAJF1KwQJf+R2jYhoqU+fu1WrW3GdudCXD7CcOGRIGg=;
 b=FuIg4I82tEuujN3OuLGRlByRGd8C9VPyFMyBfjwY/5kYlSSHRSzAdJtEDppM4zBfBD
 c+xJcP8p/5XSpBHRdj23i0nsZPzFwQAtwC3BiIThN47VVDPXa21TAjF/jE9NkVxFLXNg
 J+dhf5ovdN5Cw7vSycTwYeKhrTggl80UlyiKdgCCVppy0FECVlf1Al1S1CMRh13KpMbf
 6FQZjOzAYzimPomML1HMpwE3zeDGOd44cS/NQTpt6iCxcBF+6nKJ6R3B4BTpzFloT2uu
 VX+QujbWKHt5g9I6EZ7fWwNnrMhZSlJt6zbEYMGgHKo1/SF40CYy5YzkElhQ9P+/ZgS/
 dp2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725627635; x=1726232435;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vAJF1KwQJf+R2jYhoqU+fu1WrW3GdudCXD7CcOGRIGg=;
 b=vNaqoWBLoE2UKH3Xhna8RZUHHrnAdIzJeaJ/eLesiHsKvJ0q5JTzTGurbbYXXeQJ7d
 XUt55ffZbuH+HQnaBQV2UW0gTvs2/aXj/nKny7Gyq/VGhkTeACI7Gh1YKmxa0+NSESNz
 ngZ1hB8b2xAvnrHpXFY9/d6TYXURVks/VhuK8Z2qt6+erLCGh7j2JP+eMFifKIdtcCSc
 EC56/LxWjvtpQSeT+O0b4G4lCTJkblvXNMcB6e4ItjCMYT80Q9mEmzjMbQ+fdcLuxlyA
 MG9s6r9/CP7cV3RWJ+HmteiS2pVhcnNWqHcgCo/qlnocbvXjz784lYdZrUH1V2ZaJ7rm
 v/JQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXVjvunZ8c2NMasTNVWOYLXVMAkVNmeHPZGktQYsmTXIkmIJvAPmHFC8QTPPYfpHZbA+YPzauNRGS1z@nongnu.org
X-Gm-Message-State: AOJu0Yxh+59NmD0x92X2/m9xH4eVWPd7GSWLbkhjSWTrYTlm4dowoh0I
 gsdSHxegF7ImH5fiMnW5zx9lnb7/D6xSgci7dYWLv+SvqJIn7gFwRFoknoG0f+e9MdF3uSvJMOM
 a1Vu265xRxY2+bTYhTuQcJaABQUE=
X-Google-Smtp-Source: AGHT+IHiqkSQGRxsPkO4qdG/WpDiPrvsf7vrL5MZQli6KUGErbWLwbU8C9tcPUEcykhbUuzJvSunwSzFWZUrWs9mmcs=
X-Received: by 2002:a05:6870:9a96:b0:268:2189:f0d with SMTP id
 586e51a60fabf-27b82fc5ab6mr2749490fac.33.1725627634521; Fri, 06 Sep 2024
 06:00:34 -0700 (PDT)
MIME-Version: 1.0
References: <20240628145710.1516121-1-aesteve@redhat.com>
 <87bk34i4dy.fsf@alyssa.is>
 <CAD=HUj7av_8Epkd0Fe0eWR7Z4bZMTuvTNgqzYoQcOzFQ82wvOg@mail.gmail.com>
 <20240712014407-mutt-send-email-mst@kernel.org>
 <CAD=HUj7iDbwnojq5a68s6B3S8z4vtpCa=B=9+ZBVYZV50zG+5g@mail.gmail.com>
 <20240905155643.GD1922502@fedora>
 <CAD=HUj4+it29pQnOhvvTE+QtizKR4Yu5VQPOHkF+scj2JmNJ-A@mail.gmail.com>
In-Reply-To: <CAD=HUj4+it29pQnOhvvTE+QtizKR4Yu5VQPOHkF+scj2JmNJ-A@mail.gmail.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Fri, 6 Sep 2024 09:00:21 -0400
Message-ID: <CAJSP0QXNh3=3r89PjOQZxcPrFXUAhoBbgH7vmUxHH1eyj75cxw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/5] vhost-user: Add SHMEM_MAP/UNMAP requests
To: David Stevens <stevensd@chromium.org>
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Alyssa Ross <hi@alyssa.is>, 
 Albert Esteve <aesteve@redhat.com>, qemu-devel@nongnu.org, jasowang@redhat.com,
 david@redhat.com, slp@redhat.com,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2001:4860:4864:20::33;
 envelope-from=stefanha@gmail.com; helo=mail-oa1-x33.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Fri, 6 Sept 2024 at 00:19, David Stevens <stevensd@chromium.org> wrote:
>
> On Fri, Sep 6, 2024 at 12:56=E2=80=AFAM Stefan Hajnoczi <stefanha@redhat.=
com> wrote:
> >
> > On Tue, Jul 16, 2024 at 10:21:35AM +0900, David Stevens wrote:
> > > On Fri, Jul 12, 2024 at 2:47=E2=80=AFPM Michael S. Tsirkin <mst@redha=
t.com> wrote:
> > > >
> > > > On Fri, Jul 12, 2024 at 11:06:49AM +0900, David Stevens wrote:
> > > > > On Thu, Jul 11, 2024 at 7:56=E2=80=AFPM Alyssa Ross <hi@alyssa.is=
> wrote:
> > > > > >
> > > > > > Adding David Stevens, who implemented SHMEM_MAP and SHMEM_UNMAP=
 in
> > > > > > crosvm a couple of years ago.
> > > > > >
> > > > > > David, I'd be particularly interested for your thoughts on the =
MEM_READ
> > > > > > and MEM_WRITE commands, since as far as I know crosvm doesn't i=
mplement
> > > > > > anything like that.  The discussion leading to those being adde=
d starts
> > > > > > here:
> > > > > >
> > > > > > https://lore.kernel.org/qemu-devel/20240604185416.GB90471@fedor=
a.redhat.com/
> > > > > >
> > > > > > It would be great if this could be standardised between QEMU an=
d crosvm
> > > > > > (and therefore have a clearer path toward being implemented in =
other VMMs)!
> > > > >
> > > > > Setting aside vhost-user for a moment, the DAX example given by S=
tefan
> > > > > won't work in crosvm today.
> > > > >
> > > > > Is universal access to virtio shared memory regions actually mand=
ated
> > > > > by the virtio spec? Copying from virtiofs DAX to virtiofs sharing
> > > > > seems reasonable enough, but what about virtio-pmem to virtio-blk=
?
> > > > > What about screenshotting a framebuffer in virtio-gpu shared memo=
ry to
> > > > > virtio-scsi? I guess with some plumbing in the VMM, it's solvable=
 in a
> > > > > virtualized environment. But what about when you have real hardwa=
re
> > > > > that speaks virtio involved? That's outside my wheelhouse, but it
> > > > > doesn't seem like that would be easy to solve.
> > > >
> > > > Yes, it can work for physical devices if allowed by host configurat=
ion.
> > > > E.g. VFIO supports that I think. Don't think VDPA does.
> > >
> > > I'm sure it can work, but that sounds more like a SHOULD (MAY?),
> > > rather than a MUST.
> > >
> > > > > For what it's worth, my interpretation of the target scenario:
> > > > >
> > > > > > Other backends don't see these mappings. If the guest submits a=
 vring
> > > > > > descriptor referencing a mapping to another backend, then that =
backend
> > > > > > won't be able to access this memory
> > > > >
> > > > > is that it's omitting how the implementation is reconciled with
> > > > > section 2.10.1 of v1.3 of the virtio spec, which states that:
> > > > >
> > > > > > References into shared memory regions are represented as offset=
s from
> > > > > > the beginning of the region instead of absolute memory addresse=
s. Offsets
> > > > > > are used both for references between structures stored within s=
hared
> > > > > > memory and for requests placed in virtqueues that refer to shar=
ed memory.
> > > > >
> > > > > My interpretation of that statement is that putting raw guest phy=
sical
> > > > > addresses corresponding to virtio shared memory regions into a vr=
ing
> > > > > is a driver spec violation.
> > > > >
> > > > > -David
> > > >
> > > > This really applies within device I think. Should be clarified ...
> > >
> > > You mean that a virtio device can use absolute memory addresses for
> > > other devices' shared memory regions, but it can't use absolute memor=
y
> > > addresses for its own shared memory regions? That's a rather strange
> > > requirement. Or is the statement simply giving an addressing strategy
> > > that device type specifications are free to ignore?
> >
> > My recollection of the intent behind the quoted section is:
> >
> > 1. Structures in shared memory that point to shared memory must used
> >    relative offsets instead of absolute physical addresses.
> > 2. Virtqueue requests that refer to shared memory (e.g. map this page
> >    from virtiofs file to this location in shared memory) must use
> >    relative offsets instead of absolute physical addresses.
> >
> > In other words, shared memory must be relocatable. Don't assume Shared
> > Memory Regions have an absolute guest physical address. This makes
> > device implementations independent of the guest physical memory layout
> > and might also help when Shared Memory Regions are exposed to guest
> > user-space where the guest physical memory layout isn't known.
>
> Doesn't this discussion contradict the necessity of point 1? If I'm
> understanding things correctly, it is valid for virtio device A to
> refer to a structure in virtio device B's shared memory region by
> absolute guest physical address. At least there is nothing in the spec
> about resolving shmid values among different virtio devices, so
> absolute guest physical addresses is the only way this sharing can be
> done. And if it's valid for a pointer to a structure in a shared
> memory region to exist, it's not clear to me why you can't have
> pointers within a shared memory region.

The reason is that VIRTIO has a layered design where the transport and
vring layout deal with bus addresses but device types generally do not
(except for specific exceptions like memory ballooning, etc).

A device's virtqueue requests do not contain addresses (e.g. struct
virtio_net_hdr). The virtqueue interface hides the details of memory
organization and access. In theory a transport could be implemented
over a medium that doesn't even offer shared memory (I think people
have played with remote VIRTIO over TCP) and this is possible because
device types don't know how virtqueue elements are represented.

This same design constraint extends to VIRTIO Shared Memory Regions
because a VIRTIO Shared Memory Region's contents are defined by the
device type, just like virtqueue requests.. I mentioned that it avoids
address translation in device type implementations and also makes it
easy to expose VIRTIO Shared Memory Regions to guest userspace.

(Similarly, putting addresses into the VIRTIO Configuration Space is
also problematic because it exposes details of memory to the device
type. They should be hidden by the VIRTIO transport.)

That explains the intention within the VIRTIO world. The question you
raised was why you're allowed to then pass the address of a VIRTIO
Shared Memory Region to another device instead of passing a <shmid,
offset> pair. The answer is because DMA is beyond the scope of the
VIRTIO spec. If the architecture allows you to expose a buffer that
happens to be located in a VIRTIO Shared Memory Region to another
device, then it's possible to pass that address. The other device may
not even be a VIRTIO device. It just performs a DMA transaction to
read/write that memory. This is happening at another layer and it's a
valid thing to do.

So the answer is that in terms of designing VIRTIO device types,
VIRTIO Shared Memory Region structure layouts or virtqueue request
structs referring to VIRTIO Shared Memory Regions must not use
addresses. But you may be able to pass the address of a VIRTIO Shared
Memory Region to another device for DMA. They don't conflict because
they are at different levels.

> It definitely makes sense that setting up a mapping should be done
> with offsets. But unless a shared memory region can be dynamically
> reallocated at runtime, then it doesn't seem necessary to ban pointers
> within a shared memory region.

On a PCI device the BAR containing the VIRTIO Shared Memory Region can
be remapped at runtime, so the shared memory region can move.

The reason is the same as for why device types don't use address
inside virtqueue request structures: the details of memory are hidden
by the VIRTIO transport and the device type doesn't deal in addresses.

Also, it makes mmapping a VIRTIO Shared Memory Region difficult in
guest userspace because now some kind of address translation mechanism
is necessary (i.e. IOMMU) so that the userspace application (which
doesn't know about physical memory addresses) and the device
implementation can translate memory. Just using offsets avoids this
problem.

Stefan

