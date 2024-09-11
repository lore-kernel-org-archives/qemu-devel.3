Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35462EE49BC
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 15:10:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soOmA-0008Dx-6D; Wed, 11 Sep 2024 10:57:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1soOjm-0007AS-OC
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 10:54:33 -0400
Received: from mail-oa1-x2a.google.com ([2001:4860:4864:20::2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1soOjj-0007LX-BI
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 10:54:30 -0400
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-27051f63018so3673530fac.3
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 07:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726066466; x=1726671266; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R6hGB0vw7ZUbECqaNkS6H7FihAxNqyKbWTvXGArpq6U=;
 b=gernRcD/noecKJd2MeqfkdZOSSmnKwV2vmSfDtt1L0haBxccCGc1m840TFR623YsCD
 AwkCLUH/PPhz3UrGUblF5sQw8hkOsAqPqvzEPIoknmPWk1wv1cloc7miU/UCNAwjyXQH
 UDra3PMcZGDxMHZ41x+cntzCeXYeU7kG4OPq/avnNbCNgjdG2O5S4CGDAC3gJGhkW4kt
 aHKbAQdpPEDBleM5FQLSP/ls5OhSyBCCxb2KLwQHuytVPNos4Jv0h3aWZQztHkTgXz9X
 vwO+7x0Yw3/LRWmpMa8J7/b5qb2vEB03Oucq4SVBiIvr2Och/90TNJYPd9g4MXdp0+jJ
 30bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726066466; x=1726671266;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R6hGB0vw7ZUbECqaNkS6H7FihAxNqyKbWTvXGArpq6U=;
 b=fxXqZC1KKrFGlwbrEzognGfarekhp0TPa5X7kZYM3IaqS56uCeE7MQqY+arFCE+XHk
 hCX8LXDVJhamv9UWO4aLKNqM3+tLQLqP6m8unmsHRqt/hJmjSqwOsWeK0jSzdzqQvIwx
 t62C7Trx2vNSk2jyDqYjQNTPVJhH+0nIUJnb2Kgqn2K/EdNlFEsoFpTHtpsAnPQMyHcc
 pQvyggpbj2hqyKBZJXmFgjaGb3NoQ0n5e6SLi5VYXW4ZGJnAOiiTmdQ/5s/NLSaCuTPr
 53G5FpWlTBxG6JN03GgIy8wqwV0mhIQhgCwFYJ45T0WcrUw5yiukajnFvzf3sP3g8Dyx
 +FVg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV7ypoZeiLDExUXabNkL6kKT3Qi17foANA/w5Aw9UdkrurmjLFKkEhlfSZkSKqpaqCk7/fZfclIU2+b@nongnu.org
X-Gm-Message-State: AOJu0YzkQ7zE1qPk/LWCxH2HdErBDhX7cBrCCUd2HxxukanXgLXMxuF4
 51CYgU1+VHM4gw3ESV1ypqHPi2/ZASDOC1BJJRCkYzHbmd9BoAp737DsTfWweWPSa8YrAkOpGhW
 C4m/rJ5U3gANuy2tsnJKCqHgfyxs=
X-Google-Smtp-Source: AGHT+IGnTlKtakcBVdyJDFHvbBGXgCkPGU7Ctq50CXhC+sMHYd0ux4Lcr+vcvRess5fJwoFtcJle7BJhGPhIMYykbdg=
X-Received: by 2002:a05:6870:5494:b0:254:bd24:de83 with SMTP id
 586e51a60fabf-27b82e5d798mr18543680fac.12.1726066465380; Wed, 11 Sep 2024
 07:54:25 -0700 (PDT)
MIME-Version: 1.0
References: <20240628145710.1516121-1-aesteve@redhat.com>
 <20240628145710.1516121-2-aesteve@redhat.com>
 <20240711074510.GC563880@dynamic-pd01.res.v6.highway.a1.net>
 <CADSE00+HWkP9FQTuA-xNtExS-FSieh7DJ4D3zzrtJi3a6=PP1Q@mail.gmail.com>
 <CADSE00JWvq7HYibVymewoKwuo1T1-W6ZJ1fJEB3ofiS1iOyf1w@mail.gmail.com>
 <20240905164525.GF1922502@fedora>
 <CADSE00JgC5fyax-foLqo__6ejupBuSaKU4tDbJ-9aJF1VhS5kA@mail.gmail.com>
In-Reply-To: <CADSE00JgC5fyax-foLqo__6ejupBuSaKU4tDbJ-9aJF1VhS5kA@mail.gmail.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Wed, 11 Sep 2024 10:54:13 -0400
Message-ID: <CAJSP0QVineYfzF1CURq02oy9r4HvAQZF0ow4Gx7CowGUMcng9Q@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/5] vhost-user: Add VIRTIO Shared Memory map
 request
To: Albert Esteve <aesteve@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org,
 jasowang@redhat.com, david@redhat.com, slp@redhat.com,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2001:4860:4864:20::2a;
 envelope-from=stefanha@gmail.com; helo=mail-oa1-x2a.google.com
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

On Wed, 11 Sept 2024 at 07:58, Albert Esteve <aesteve@redhat.com> wrote:
> On Thu, Sep 5, 2024 at 6:45=E2=80=AFPM Stefan Hajnoczi <stefanha@redhat.c=
om> wrote:
>>
>> On Tue, Sep 03, 2024 at 01:54:12PM +0200, Albert Esteve wrote:
>> > On Tue, Sep 3, 2024 at 11:54=E2=80=AFAM Albert Esteve <aesteve@redhat.=
com> wrote:
>> >
>> > >
>> > >
>> > > On Thu, Jul 11, 2024 at 9:45=E2=80=AFAM Stefan Hajnoczi <stefanha@re=
dhat.com>
>> > > wrote:
>> > >
>> > >> On Fri, Jun 28, 2024 at 04:57:06PM +0200, Albert Esteve wrote:
>> > >> > Add SHMEM_MAP/UNMAP requests to vhost-user to
>> > >> > handle VIRTIO Shared Memory mappings.
>> > >> >
>> > >> > This request allows backends to dynamically map
>> > >> > fds into a VIRTIO Shared Memory Region indentified
>> > >> > by its `shmid`. Then, the fd memory is advertised
>> > >> > to the driver as a base addres + offset, so it
>> > >> > can be read/written (depending on the mmap flags
>> > >> > requested) while its valid.
>> > >> >
>> > >> > The backend can munmap the memory range
>> > >> > in a given VIRTIO Shared Memory Region (again,
>> > >> > identified by its `shmid`), to free it. Upon
>> > >> > receiving this message, the front-end must
>> > >> > mmap the regions with PROT_NONE to reserve
>> > >> > the virtual memory space.
>> > >> >
>> > >> > The device model needs to create MemoryRegion
>> > >> > instances for the VIRTIO Shared Memory Regions
>> > >> > and add them to the `VirtIODevice` instance.
>> > >> >
>> > >> > Signed-off-by: Albert Esteve <aesteve@redhat.com>
>> > >> > ---
>> > >> >  docs/interop/vhost-user.rst               |  27 +++++
>> > >> >  hw/virtio/vhost-user.c                    | 122 ++++++++++++++++=
++++++
>> > >> >  hw/virtio/virtio.c                        |  12 +++
>> > >> >  include/hw/virtio/virtio.h                |   5 +
>> > >> >  subprojects/libvhost-user/libvhost-user.c |  65 ++++++++++++
>> > >> >  subprojects/libvhost-user/libvhost-user.h |  53 ++++++++++
>> > >> >  6 files changed, 284 insertions(+)
>> > >> >
>> > >> > diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-use=
r.rst
>> > >> > index d8419fd2f1..d52ba719d5 100644
>> > >> > --- a/docs/interop/vhost-user.rst
>> > >> > +++ b/docs/interop/vhost-user.rst
>> > >> > @@ -1859,6 +1859,33 @@ is sent by the front-end.
>> > >> >    when the operation is successful, or non-zero otherwise. Note =
that
>> > >> if the
>> > >> >    operation fails, no fd is sent to the backend.
>> > >> >
>> > >> > +``VHOST_USER_BACKEND_SHMEM_MAP``
>> > >> > +  :id: 9
>> > >> > +  :equivalent ioctl: N/A
>> > >> > +  :request payload: fd and ``struct VhostUserMMap``
>> > >> > +  :reply payload: N/A
>> > >> > +
>> > >> > +  This message can be submitted by the backends to advertise a n=
ew
>> > >> mapping
>> > >> > +  to be made in a given VIRTIO Shared Memory Region. Upon receiv=
ing
>> > >> the message,
>> > >> > +  The front-end will mmap the given fd into the VIRTIO Shared Me=
mory
>> > >> Region
>> > >> > +  with the requested ``shmid``. A reply is generated indicating
>> > >> whether mapping
>> > >> > +  succeeded.
>> > >> > +
>> > >> > +  Mapping over an already existing map is not allowed and reques=
t
>> > >> shall fail.
>> > >> > +  Therefore, the memory range in the request must correspond wit=
h a
>> > >> valid,
>> > >> > +  free region of the VIRTIO Shared Memory Region.
>> > >> > +
>> > >> > +``VHOST_USER_BACKEND_SHMEM_UNMAP``
>> > >> > +  :id: 10
>> > >> > +  :equivalent ioctl: N/A
>> > >> > +  :request payload: ``struct VhostUserMMap``
>> > >> > +  :reply payload: N/A
>> > >> > +
>> > >> > +  This message can be submitted by the backends so that the fron=
t-end
>> > >> un-mmap
>> > >> > +  a given range (``offset``, ``len``) in the VIRTIO Shared Memor=
y
>> > >> Region with
>> > >>
>> > >> s/offset/shm_offset/
>> > >>
>> > >> > +  the requested ``shmid``.
>> > >>
>> > >> Please clarify that <offset, len> must correspond to the entirety o=
f a
>> > >> valid mapped region.
>> > >>
>> > >> By the way, the VIRTIO 1.3 gives the following behavior for the vir=
tiofs
>> > >> DAX Window:
>> > >>
>> > >>   When a FUSE_SETUPMAPPING request perfectly overlaps a previous
>> > >>   mapping, the previous mapping is replaced. When a mapping partial=
ly
>> > >>   overlaps a previous mapping, the previous mapping is split into o=
ne or
>> > >>   two smaller mappings. When a mapping is partially unmapped it is =
also
>> > >>   split into one or two smaller mappings.
>> > >>
>> > >>   Establishing new mappings or splitting existing mappings consumes
>> > >>   resources. If the device runs out of resources the FUSE_SETUPMAPP=
ING
>> > >>   request fails until resources are available again following
>> > >>   FUSE_REMOVEMAPPING.
>> > >>
>> > >> I think SETUPMAPPING/REMOVMAPPING can be implemented using
>> > >> SHMEM_MAP/UNMAP. SHMEM_MAP/UNMAP do not allow atomically replacing
>> > >> partial ranges, but as far as I know that's not necessary for virti=
ofs
>> > >> in practice.
>> > >>
>> > >> It's worth mentioning that mappings consume resources and that SHME=
M_MAP
>> > >> can fail when there are no resources available. The process-wide li=
mit
>> > >> is vm.max_map_count on Linux although a vhost-user frontend may red=
uce
>> > >> it further to control vhost-user resource usage.
>> > >>
>> > >> > +  A reply is generated indicating whether unmapping succeeded.
>> > >> > +
>> > >> >  .. _reply_ack:
>> > >> >
>> > >> >  VHOST_USER_PROTOCOL_F_REPLY_ACK
>> > >> > diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
>> > >> > index cdf9af4a4b..7ee8a472c6 100644
>> > >> > --- a/hw/virtio/vhost-user.c
>> > >> > +++ b/hw/virtio/vhost-user.c
>> > >> > @@ -115,6 +115,8 @@ typedef enum VhostUserBackendRequest {
>> > >> >      VHOST_USER_BACKEND_SHARED_OBJECT_ADD =3D 6,
>> > >> >      VHOST_USER_BACKEND_SHARED_OBJECT_REMOVE =3D 7,
>> > >> >      VHOST_USER_BACKEND_SHARED_OBJECT_LOOKUP =3D 8,
>> > >> > +    VHOST_USER_BACKEND_SHMEM_MAP =3D 9,
>> > >> > +    VHOST_USER_BACKEND_SHMEM_UNMAP =3D 10,
>> > >> >      VHOST_USER_BACKEND_MAX
>> > >> >  }  VhostUserBackendRequest;
>> > >> >
>> > >> > @@ -192,6 +194,24 @@ typedef struct VhostUserShared {
>> > >> >      unsigned char uuid[16];
>> > >> >  } VhostUserShared;
>> > >> >
>> > >> > +/* For the flags field of VhostUserMMap */
>> > >> > +#define VHOST_USER_FLAG_MAP_R (1u << 0)
>> > >> > +#define VHOST_USER_FLAG_MAP_W (1u << 1)
>> > >> > +
>> > >> > +typedef struct {
>> > >> > +    /* VIRTIO Shared Memory Region ID */
>> > >> > +    uint8_t shmid;
>> > >> > +    uint8_t padding[7];
>> > >> > +    /* File offset */
>> > >> > +    uint64_t fd_offset;
>> > >> > +    /* Offset within the VIRTIO Shared Memory Region */
>> > >> > +    uint64_t shm_offset;
>> > >> > +    /* Size of the mapping */
>> > >> > +    uint64_t len;
>> > >> > +    /* Flags for the mmap operation, from VHOST_USER_FLAG_* */
>> > >> > +    uint64_t flags;
>> > >> > +} VhostUserMMap;
>> > >> > +
>> > >> >  typedef struct {
>> > >> >      VhostUserRequest request;
>> > >> >
>> > >> > @@ -224,6 +244,7 @@ typedef union {
>> > >> >          VhostUserInflight inflight;
>> > >> >          VhostUserShared object;
>> > >> >          VhostUserTransferDeviceState transfer_state;
>> > >> > +        VhostUserMMap mmap;
>> > >> >  } VhostUserPayload;
>> > >> >
>> > >> >  typedef struct VhostUserMsg {
>> > >> > @@ -1748,6 +1769,100 @@
>> > >> vhost_user_backend_handle_shared_object_lookup(struct vhost_user *u=
,
>> > >> >      return 0;
>> > >> >  }
>> > >> >
>> > >> > +static int
>> > >> > +vhost_user_backend_handle_shmem_map(struct vhost_dev *dev,
>> > >> > +                                    VhostUserMMap *vu_mmap,
>> > >> > +                                    int fd)
>> > >> > +{
>> > >> > +    void *addr =3D 0;
>> > >> > +    MemoryRegion *mr =3D NULL;
>> > >> > +
>> > >> > +    if (fd < 0) {
>> > >> > +        error_report("Bad fd for map");
>> > >> > +        return -EBADF;
>> > >> > +    }
>> > >> > +
>> > >> > +    if (!dev->vdev->shmem_list ||
>> > >> > +        dev->vdev->n_shmem_regions <=3D vu_mmap->shmid) {
>> > >> > +        error_report("Device only has %d VIRTIO Shared Memory Re=
gions.
>> > >> "
>> > >> > +                     "Requested ID: %d",
>> > >> > +                     dev->vdev->n_shmem_regions, vu_mmap->shmid)=
;
>> > >> > +        return -EFAULT;
>> > >> > +    }
>> > >> > +
>> > >> > +    mr =3D &dev->vdev->shmem_list[vu_mmap->shmid];
>> > >> > +
>> > >> > +    if (!mr) {
>> > >> > +        error_report("VIRTIO Shared Memory Region at "
>> > >> > +                     "ID %d unitialized", vu_mmap->shmid);
>> > >> > +        return -EFAULT;
>> > >> > +    }
>> > >> > +
>> > >> > +    if ((vu_mmap->shm_offset + vu_mmap->len) < vu_mmap->len ||
>> > >> > +        (vu_mmap->shm_offset + vu_mmap->len) > mr->size) {
>> > >> > +        error_report("Bad offset/len for mmap %" PRIx64 "+%" PRI=
x64,
>> > >> > +                     vu_mmap->shm_offset, vu_mmap->len);
>> > >> > +        return -EFAULT;
>> > >> > +    }
>> > >> > +
>> > >> > +    void *shmem_ptr =3D memory_region_get_ram_ptr(mr);
>> > >> > +
>> > >> > +    addr =3D mmap(shmem_ptr + vu_mmap->shm_offset, vu_mmap->len,
>> > >>
>> > >> Missing check for overlap between range [shm_offset, shm_offset + l=
en)
>> > >> and existing mappings.
>> > >>
>> > >
>> > > Not sure how to do this check. Specifically, I am not sure how previ=
ous
>> > > ranges are stored within the MemoryRegion. Is looping through
>> > > mr->subregions
>> > > a valid option?
>> > >
>> >
>> > Maybe something like this would do?
>> > ```
>> >      if (memory_region_find(mr, vu_mmap->shm_offset, vu_mmap->len).mr)=
 {
>> >         error_report("Requested memory (%" PRIx64 "+%" PRIx64 " overal=
ps "
>> >                      "with previously mapped memory",
>> >                      vu_mmap->shm_offset, vu_mmap->len);
>> >         return -EFAULT;
>> >     }
>> > ```
>>
>> I don't think that works because the QEMU MemoryRegion covers the entire
>> range, some of which contains mappings and some of which is empty. It
>> would be necessary to track mappings that have been made.
>>
>> I'm not aware of a security implication if the overlap check is missing,
>> so I guess it may be okay to skip it and rely on the vhost-user back-end
>> author to honor the spec. I'm not totally against that because it's
>> faster and less code, but it feels a bit iffy to not enforce the input
>> validation that the spec requires.
>>
>> Maintain a list of mappings so this check can be performed?
>>
>
> Ok, I prefer to aim for the better solution and see where that takes us.
> So I will add a mapped_regions list or something like that to the
> MemoryRegion struct in a new commit, so that it can be reviewed
> independently. With the infrastructure's code in the patch we can decide =
if
> it is worth to have it.

Great. MemoryRegion is a core struct that's not related to vhost-user.
I don't think anything else needs a mappings list. Maybe add the
mappings list to shmem_list[] elements instead so that each VIRTIO
Shared Memory Region has a mappings list? Each element could be a
struct with a MemoryRegion field and a mappings list.

Stefan

>
> Thank you!
>
>>
>> >
>> > >
>> > >
>> > >>
>> > >> > +        ((vu_mmap->flags & VHOST_USER_FLAG_MAP_R) ? PROT_READ : =
0) |
>> > >> > +        ((vu_mmap->flags & VHOST_USER_FLAG_MAP_W) ? PROT_WRITE :=
 0),
>> > >> > +        MAP_SHARED | MAP_FIXED, fd, vu_mmap->fd_offset);
>> > >> > +
>> > >> > +    if (addr =3D=3D MAP_FAILED) {
>> > >> > +        error_report("Failed to mmap mem fd");
>> > >> > +        return -EFAULT;
>> > >> > +    }
>> > >> > +
>> > >> > +    return 0;
>> > >> > +}
>> > >> > +
>> > >> > +static int
>> > >> > +vhost_user_backend_handle_shmem_unmap(struct vhost_dev *dev,
>> > >> > +                                      VhostUserMMap *vu_mmap)
>> > >> > +{
>> > >> > +    void *addr =3D 0;
>> > >> > +    MemoryRegion *mr =3D NULL;
>> > >> > +
>> > >> > +    if (!dev->vdev->shmem_list ||
>> > >> > +        dev->vdev->n_shmem_regions <=3D vu_mmap->shmid) {
>> > >> > +        error_report("Device only has %d VIRTIO Shared Memory Re=
gions.
>> > >> "
>> > >> > +                     "Requested ID: %d",
>> > >> > +                     dev->vdev->n_shmem_regions, vu_mmap->shmid)=
;
>> > >> > +        return -EFAULT;
>> > >> > +    }
>> > >> > +
>> > >> > +    mr =3D &dev->vdev->shmem_list[vu_mmap->shmid];
>> > >> > +
>> > >> > +    if (!mr) {
>> > >> > +        error_report("VIRTIO Shared Memory Region at "
>> > >> > +                     "ID %d unitialized", vu_mmap->shmid);
>> > >> > +        return -EFAULT;
>> > >> > +    }
>> > >> > +
>> > >> > +    if ((vu_mmap->shm_offset + vu_mmap->len) < vu_mmap->len ||
>> > >> > +        (vu_mmap->shm_offset + vu_mmap->len) > mr->size) {
>> > >> > +        error_report("Bad offset/len for mmap %" PRIx64 "+%" PRI=
x64,
>> > >> > +                     vu_mmap->shm_offset, vu_mmap->len);
>> > >> > +        return -EFAULT;
>> > >> > +    }
>> > >> > +
>> > >> > +    void *shmem_ptr =3D memory_region_get_ram_ptr(mr);
>> > >> > +
>> > >> > +    addr =3D mmap(shmem_ptr + vu_mmap->shm_offset, vu_mmap->len,
>> > >>
>> > >> Missing check for existing mapping with exact range [shm_offset, le=
n)
>> > >> match.
>> > >>
>> > >> > +                PROT_NONE, MAP_PRIVATE | MAP_ANONYMOUS | MAP_FIX=
ED,
>> > >> -1, 0);
>> > >> > +
>> > >> > +    if (addr =3D=3D MAP_FAILED) {
>> > >> > +        error_report("Failed to unmap memory");
>> > >> > +        return -EFAULT;
>> > >> > +    }
>> > >> > +
>> > >> > +    return 0;
>> > >> > +}
>> > >> > +
>> > >> >  static void close_backend_channel(struct vhost_user *u)
>> > >> >  {
>> > >> >      g_source_destroy(u->backend_src);
>> > >> > @@ -1816,6 +1931,13 @@ static gboolean backend_read(QIOChannel *i=
oc,
>> > >> GIOCondition condition,
>> > >> >          ret =3D
>> > >> vhost_user_backend_handle_shared_object_lookup(dev->opaque, ioc,
>> > >> >                                                               &hd=
r,
>> > >> &payload);
>> > >> >          break;
>> > >> > +    case VHOST_USER_BACKEND_SHMEM_MAP:
>> > >> > +        ret =3D vhost_user_backend_handle_shmem_map(dev, &payloa=
d.mmap,
>> > >> > +                                                  fd ? fd[0] : -=
1);
>> > >> > +        break;
>> > >> > +    case VHOST_USER_BACKEND_SHMEM_UNMAP:
>> > >> > +        ret =3D vhost_user_backend_handle_shmem_unmap(dev,
>> > >> &payload.mmap);
>> > >> > +        break;
>> > >> >      default:
>> > >> >          error_report("Received unexpected msg type: %d.", hdr.re=
quest);
>> > >> >          ret =3D -EINVAL;
>> > >> > diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
>> > >> > index 893a072c9d..9f2da5b11e 100644
>> > >> > --- a/hw/virtio/virtio.c
>> > >> > +++ b/hw/virtio/virtio.c
>> > >> > @@ -2856,6 +2856,16 @@ int virtio_save(VirtIODevice *vdev, QEMUFi=
le *f)
>> > >> >      return vmstate_save_state(f, &vmstate_virtio, vdev, NULL);
>> > >> >  }
>> > >> >
>> > >> > +MemoryRegion *virtio_new_shmem_region(VirtIODevice *vdev)
>> > >> > +{
>> > >> > +    MemoryRegion *mr =3D g_new0(MemoryRegion, 1);
>> > >> > +    ++vdev->n_shmem_regions;
>> > >> > +    vdev->shmem_list =3D g_renew(MemoryRegion, vdev->shmem_list,
>> > >> > +                               vdev->n_shmem_regions);
>> > >>
>> > >> Where is shmem_list freed?
>> > >>
>> > >> The name "list" is misleading since this is an array, not a list.
>> > >>
>> > >> > +    vdev->shmem_list[vdev->n_shmem_regions - 1] =3D *mr;
>> > >> > +    return mr;
>> > >> > +}
>> > >>
>> > >> This looks weird. The contents of mr are copied into shmem_list[] a=
nd
>> > >> then the pointer to mr is returned? Did you mean for the field's ty=
pe to
>> > >> be MemoryRegion **shmem_list and then vdev->shmem_list[...] =3D mr =
would
>> > >> stash the pointer?
>> > >>
>> > >> > +
>> > >> >  /* A wrapper for use as a VMState .put function */
>> > >> >  static int virtio_device_put(QEMUFile *f, void *opaque, size_t s=
ize,
>> > >> >                                const VMStateField *field, JSONWri=
ter
>> > >> *vmdesc)
>> > >> > @@ -3264,6 +3274,8 @@ void virtio_init(VirtIODevice *vdev, uint16=
_t
>> > >> device_id, size_t config_size)
>> > >> >              virtio_vmstate_change, vdev);
>> > >> >      vdev->device_endian =3D virtio_default_endian();
>> > >> >      vdev->use_guest_notifier_mask =3D true;
>> > >> > +    vdev->shmem_list =3D NULL;
>> > >> > +    vdev->n_shmem_regions =3D 0;
>> > >> >  }
>> > >> >
>> > >> >  /*
>> > >> > diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virti=
o.h
>> > >> > index 7d5ffdc145..16d598aadc 100644
>> > >> > --- a/include/hw/virtio/virtio.h
>> > >> > +++ b/include/hw/virtio/virtio.h
>> > >> > @@ -165,6 +165,9 @@ struct VirtIODevice
>> > >> >       */
>> > >> >      EventNotifier config_notifier;
>> > >> >      bool device_iotlb_enabled;
>> > >> > +    /* Shared memory region for vhost-user mappings. */
>> > >> > +    MemoryRegion *shmem_list;
>> > >> > +    int n_shmem_regions;
>> > >> >  };
>> > >> >
>> > >> >  struct VirtioDeviceClass {
>> > >> > @@ -280,6 +283,8 @@ void virtio_notify(VirtIODevice *vdev, VirtQu=
eue
>> > >> *vq);
>> > >> >
>> > >> >  int virtio_save(VirtIODevice *vdev, QEMUFile *f);
>> > >> >
>> > >> > +MemoryRegion *virtio_new_shmem_region(VirtIODevice *vdev);
>> > >> > +
>> > >> >  extern const VMStateInfo virtio_vmstate_info;
>> > >> >
>> > >> >  #define VMSTATE_VIRTIO_DEVICE \
>> > >> > diff --git a/subprojects/libvhost-user/libvhost-user.c
>> > >> b/subprojects/libvhost-user/libvhost-user.c
>> > >> > index a879149fef..28556d183a 100644
>> > >> > --- a/subprojects/libvhost-user/libvhost-user.c
>> > >> > +++ b/subprojects/libvhost-user/libvhost-user.c
>> > >> > @@ -1586,6 +1586,71 @@ vu_rm_shared_object(VuDev *dev, unsigned c=
har
>> > >> uuid[UUID_LEN])
>> > >> >      return vu_send_message(dev, &msg);
>> > >> >  }
>> > >> >
>> > >> > +bool
>> > >> > +vu_shmem_map(VuDev *dev, uint8_t shmid, uint64_t fd_offset,
>> > >> > +             uint64_t shm_offset, uint64_t len, uint64_t flags)
>> > >> > +{
>> > >> > +    bool result =3D false;
>> > >> > +    VhostUserMsg msg_reply;
>> > >> > +    VhostUserMsg vmsg =3D {
>> > >> > +        .request =3D VHOST_USER_BACKEND_SHMEM_MAP,
>> > >> > +        .size =3D sizeof(vmsg.payload.mmap),
>> > >> > +        .flags =3D VHOST_USER_VERSION,
>> > >> > +        .payload.mmap =3D {
>> > >> > +            .shmid =3D shmid,
>> > >> > +            .fd_offset =3D fd_offset,
>> > >> > +            .shm_offset =3D shm_offset,
>> > >> > +            .len =3D len,
>> > >> > +            .flags =3D flags,
>> > >> > +        },
>> > >> > +    };
>> > >> > +
>> > >> > +    if (vu_has_protocol_feature(dev, VHOST_USER_PROTOCOL_F_REPLY=
_ACK))
>> > >> {
>> > >> > +        vmsg.flags |=3D VHOST_USER_NEED_REPLY_MASK;
>> > >> > +    }
>> > >> > +
>> > >> > +    pthread_mutex_lock(&dev->backend_mutex);
>> > >> > +    if (!vu_message_write(dev, dev->backend_fd, &vmsg)) {
>> > >> > +        pthread_mutex_unlock(&dev->backend_mutex);
>> > >> > +        return false;
>> > >> > +    }
>> > >> > +
>> > >> > +    /* Also unlocks the backend_mutex */
>> > >> > +    return vu_process_message_reply(dev, &vmsg);
>> > >> > +}
>> > >> > +
>> > >> > +bool
>> > >> > +vu_shmem_unmap(VuDev *dev, uint8_t shmid, uint64_t fd_offset,
>> > >> > +               uint64_t shm_offset, uint64_t len)
>> > >> > +{
>> > >> > +    bool result =3D false;
>> > >> > +    VhostUserMsg msg_reply;
>> > >> > +    VhostUserMsg vmsg =3D {
>> > >> > +        .request =3D VHOST_USER_BACKEND_SHMEM_UNMAP,
>> > >> > +        .size =3D sizeof(vmsg.payload.mmap),
>> > >> > +        .flags =3D VHOST_USER_VERSION,
>> > >> > +        .payload.mmap =3D {
>> > >> > +            .shmid =3D shmid,
>> > >> > +            .fd_offset =3D fd_offset,
>> > >>
>> > >> What is the meaning of this field? I expected it to be set to 0.
>> > >>
>> > >> > +            .shm_offset =3D shm_offset,
>> > >> > +            .len =3D len,
>> > >> > +        },
>> > >> > +    };
>> > >> > +
>> > >> > +    if (vu_has_protocol_feature(dev, VHOST_USER_PROTOCOL_F_REPLY=
_ACK))
>> > >> {
>> > >> > +        vmsg.flags |=3D VHOST_USER_NEED_REPLY_MASK;
>> > >> > +    }
>> > >> > +
>> > >> > +    pthread_mutex_lock(&dev->backend_mutex);
>> > >> > +    if (!vu_message_write(dev, dev->backend_fd, &vmsg)) {
>> > >> > +        pthread_mutex_unlock(&dev->backend_mutex);
>> > >> > +        return false;
>> > >> > +    }
>> > >> > +
>> > >> > +    /* Also unlocks the backend_mutex */
>> > >> > +    return vu_process_message_reply(dev, &vmsg);
>> > >> > +}
>> > >> > +
>> > >> >  static bool
>> > >> >  vu_set_vring_call_exec(VuDev *dev, VhostUserMsg *vmsg)
>> > >> >  {
>> > >> > diff --git a/subprojects/libvhost-user/libvhost-user.h
>> > >> b/subprojects/libvhost-user/libvhost-user.h
>> > >> > index deb40e77b3..7f6c22cc1a 100644
>> > >> > --- a/subprojects/libvhost-user/libvhost-user.h
>> > >> > +++ b/subprojects/libvhost-user/libvhost-user.h
>> > >> > @@ -127,6 +127,8 @@ typedef enum VhostUserBackendRequest {
>> > >> >      VHOST_USER_BACKEND_SHARED_OBJECT_ADD =3D 6,
>> > >> >      VHOST_USER_BACKEND_SHARED_OBJECT_REMOVE =3D 7,
>> > >> >      VHOST_USER_BACKEND_SHARED_OBJECT_LOOKUP =3D 8,
>> > >> > +    VHOST_USER_BACKEND_SHMEM_MAP =3D 9,
>> > >> > +    VHOST_USER_BACKEND_SHMEM_UNMAP =3D 10,
>> > >> >      VHOST_USER_BACKEND_MAX
>> > >> >  }  VhostUserBackendRequest;
>> > >> >
>> > >> > @@ -186,6 +188,24 @@ typedef struct VhostUserShared {
>> > >> >      unsigned char uuid[UUID_LEN];
>> > >> >  } VhostUserShared;
>> > >> >
>> > >> > +/* For the flags field of VhostUserMMap */
>> > >> > +#define VHOST_USER_FLAG_MAP_R (1u << 0)
>> > >> > +#define VHOST_USER_FLAG_MAP_W (1u << 1)
>> > >> > +
>> > >> > +typedef struct {
>> > >> > +    /* VIRTIO Shared Memory Region ID */
>> > >> > +    uint8_t shmid;
>> > >> > +    uint8_t padding[7];
>> > >> > +    /* File offset */
>> > >> > +    uint64_t fd_offset;
>> > >> > +    /* Offset within the VIRTIO Shared Memory Region */
>> > >> > +    uint64_t shm_offset;
>> > >> > +    /* Size of the mapping */
>> > >> > +    uint64_t len;
>> > >> > +    /* Flags for the mmap operation, from VHOST_USER_FLAG_* */
>> > >> > +    uint64_t flags;
>> > >> > +} VhostUserMMap;
>> > >> > +
>> > >> >  #if defined(_WIN32) && (defined(__x86_64__) || defined(__i386__)=
)
>> > >> >  # define VU_PACKED __attribute__((gcc_struct, packed))
>> > >> >  #else
>> > >> > @@ -214,6 +234,7 @@ typedef struct VhostUserMsg {
>> > >> >          VhostUserVringArea area;
>> > >> >          VhostUserInflight inflight;
>> > >> >          VhostUserShared object;
>> > >> > +        VhostUserMMap mmap;
>> > >> >      } payload;
>> > >> >
>> > >> >      int fds[VHOST_MEMORY_BASELINE_NREGIONS];
>> > >> > @@ -597,6 +618,38 @@ bool vu_add_shared_object(VuDev *dev, unsign=
ed
>> > >> char uuid[UUID_LEN]);
>> > >> >   */
>> > >> >  bool vu_rm_shared_object(VuDev *dev, unsigned char uuid[UUID_LEN=
]);
>> > >> >
>> > >> > +/**
>> > >> > + * vu_shmem_map:
>> > >> > + * @dev: a VuDev context
>> > >> > + * @shmid: VIRTIO Shared Memory Region ID
>> > >> > + * @fd_offset: File offset
>> > >> > + * @shm_offset: Offset within the VIRTIO Shared Memory Region
>> > >> > + * @len: Size of the mapping
>> > >> > + * @flags: Flags for the mmap operation
>> > >> > + *
>> > >> > + * Advertises a new mapping to be made in a given VIRTIO Shared =
Memory
>> > >> Region.
>> > >> > + *
>> > >> > + * Returns: TRUE on success, FALSE on failure.
>> > >> > + */
>> > >> > +bool vu_shmem_map(VuDev *dev, uint8_t shmid, uint64_t fd_offset,
>> > >> > +                  uint64_t shm_offset, uint64_t len, uint64_t fl=
ags);
>> > >> > +
>> > >> > +/**
>> > >> > + * vu_shmem_map:
>> > >> > + * @dev: a VuDev context
>> > >> > + * @shmid: VIRTIO Shared Memory Region ID
>> > >> > + * @fd_offset: File offset
>> > >> > + * @shm_offset: Offset within the VIRTIO Shared Memory Region
>> > >> > + * @len: Size of the mapping
>> > >> > + *
>> > >> > + * The front-end un-mmaps a given range in the VIRTIO Shared Mem=
ory
>> > >> Region
>> > >> > + * with the requested `shmid`.
>> > >> > + *
>> > >> > + * Returns: TRUE on success, FALSE on failure.
>> > >> > + */
>> > >> > +bool vu_shmem_unmap(VuDev *dev, uint8_t shmid, uint64_t fd_offse=
t,
>> > >> > +                  uint64_t shm_offset, uint64_t len);
>> > >> > +
>> > >> >  /**
>> > >> >   * vu_queue_set_notification:
>> > >> >   * @dev: a VuDev context
>> > >> > --
>> > >> > 2.45.2
>> > >> >
>> > >>
>> > >

