Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F999EE499B
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 11:58:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soLyr-0000w0-7S; Wed, 11 Sep 2024 07:57:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1soLyf-0000vJ-8h
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 07:57:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1soLyZ-0004Lt-Mo
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 07:57:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726055852;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bmAba6EueYskIdyvw0KZcJMw2Se9uua+39d/u6tvIwM=;
 b=JPeiw4J42pOJC9E/KsHjSPugf0I3ulxWVMk6x8g9AbBE1Gh3XvHDpCD34Hay7JDCVkF4/s
 fSNlW+cw7E9UEvsV6GSwPSUevUfKPPkWGXuCsnns1XaV9VPU1VDTva7aI2Q4GWEwY8mg3B
 JaUP1IK5xeBw6jbxB8TMRvTsvzpzKh4=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-37-bnXRSzK0NPmTgodzzK0F3Q-1; Wed, 11 Sep 2024 07:57:28 -0400
X-MC-Unique: bnXRSzK0NPmTgodzzK0F3Q-1
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-718d51f33a6so5145517b3a.2
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 04:57:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726055847; x=1726660647;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bmAba6EueYskIdyvw0KZcJMw2Se9uua+39d/u6tvIwM=;
 b=vBMaFbqQnDtGabR2UxnfDDiBSQLb4oz2dmysPaGA18nh1kE5ZYlHyngu0IkNUSJhCA
 WmDyqtICbfnr0O57fFLN5XfGqlockuYWhRAS58NAnape24lM+7CgEBiEiCv4g/pKctf1
 GhKspHie/78Sygslrt6p8DqmAYrleuQmHEZbZkbdf3YNEkdynph/pCyfoqQmDt8uXpHt
 5Qf1+70WdJJFpZGe+xo9lB7V017PdIeB0hQlGJf7kpEQ9/g7vkTGaTPHiCda/q31iRc5
 +dhzNFevFNYWgYMYMkSVmuPdtv1Ycl1XP5NgZ3akDsyhHL7z/mIATrAb3C6vbQosqGJk
 av+Q==
X-Gm-Message-State: AOJu0Yzz35mxpF3dFF4NvtmsU825Wzw0o5GlVkd3YV7cEVP1fminUvXP
 iJiCuXg7NfrfVhJXdhNjc/MCWH2mtA8TZusOJprw+M9HmWF7n0uRTnf8AiBrRcx4vtphkkLDpFn
 xD08kMVE70S9N4Fa8b5EvyNEyy1WSgYpbLMrKNovgfF5HqxF4gqXl/xzv1oY4KUz6S84qo1zPOZ
 gpqF5be435RpOzf8AQbVs/uIS/5kY=
X-Received: by 2002:a05:6a00:66e1:b0:714:3acb:9d4b with SMTP id
 d2e1a72fcca58-718d5ee03c7mr17038639b3a.18.1726055847193; 
 Wed, 11 Sep 2024 04:57:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFXYNlyBOMoA6vjnIaDG6jU6H/vpsc1qvnpcDlaJMUWvwk3Q45M5XB2pFKuTR5ldnFSxv1WORSUQbm7yFp6vKg=
X-Received: by 2002:a05:6a00:66e1:b0:714:3acb:9d4b with SMTP id
 d2e1a72fcca58-718d5ee03c7mr17038603b3a.18.1726055846662; Wed, 11 Sep 2024
 04:57:26 -0700 (PDT)
MIME-Version: 1.0
References: <20240628145710.1516121-1-aesteve@redhat.com>
 <20240628145710.1516121-2-aesteve@redhat.com>
 <20240711074510.GC563880@dynamic-pd01.res.v6.highway.a1.net>
 <CADSE00+HWkP9FQTuA-xNtExS-FSieh7DJ4D3zzrtJi3a6=PP1Q@mail.gmail.com>
 <CADSE00JWvq7HYibVymewoKwuo1T1-W6ZJ1fJEB3ofiS1iOyf1w@mail.gmail.com>
 <20240905164525.GF1922502@fedora>
In-Reply-To: <20240905164525.GF1922502@fedora>
From: Albert Esteve <aesteve@redhat.com>
Date: Wed, 11 Sep 2024 13:57:15 +0200
Message-ID: <CADSE00JgC5fyax-foLqo__6ejupBuSaKU4tDbJ-9aJF1VhS5kA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/5] vhost-user: Add VIRTIO Shared Memory map
 request
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, jasowang@redhat.com, david@redhat.com, 
 slp@redhat.com, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000009a6b8b0621d6b12a"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=aesteve@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

--0000000000009a6b8b0621d6b12a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 5, 2024 at 6:45=E2=80=AFPM Stefan Hajnoczi <stefanha@redhat.com=
> wrote:

> On Tue, Sep 03, 2024 at 01:54:12PM +0200, Albert Esteve wrote:
> > On Tue, Sep 3, 2024 at 11:54=E2=80=AFAM Albert Esteve <aesteve@redhat.c=
om>
> wrote:
> >
> > >
> > >
> > > On Thu, Jul 11, 2024 at 9:45=E2=80=AFAM Stefan Hajnoczi <stefanha@red=
hat.com>
> > > wrote:
> > >
> > >> On Fri, Jun 28, 2024 at 04:57:06PM +0200, Albert Esteve wrote:
> > >> > Add SHMEM_MAP/UNMAP requests to vhost-user to
> > >> > handle VIRTIO Shared Memory mappings.
> > >> >
> > >> > This request allows backends to dynamically map
> > >> > fds into a VIRTIO Shared Memory Region indentified
> > >> > by its `shmid`. Then, the fd memory is advertised
> > >> > to the driver as a base addres + offset, so it
> > >> > can be read/written (depending on the mmap flags
> > >> > requested) while its valid.
> > >> >
> > >> > The backend can munmap the memory range
> > >> > in a given VIRTIO Shared Memory Region (again,
> > >> > identified by its `shmid`), to free it. Upon
> > >> > receiving this message, the front-end must
> > >> > mmap the regions with PROT_NONE to reserve
> > >> > the virtual memory space.
> > >> >
> > >> > The device model needs to create MemoryRegion
> > >> > instances for the VIRTIO Shared Memory Regions
> > >> > and add them to the `VirtIODevice` instance.
> > >> >
> > >> > Signed-off-by: Albert Esteve <aesteve@redhat.com>
> > >> > ---
> > >> >  docs/interop/vhost-user.rst               |  27 +++++
> > >> >  hw/virtio/vhost-user.c                    | 122
> ++++++++++++++++++++++
> > >> >  hw/virtio/virtio.c                        |  12 +++
> > >> >  include/hw/virtio/virtio.h                |   5 +
> > >> >  subprojects/libvhost-user/libvhost-user.c |  65 ++++++++++++
> > >> >  subprojects/libvhost-user/libvhost-user.h |  53 ++++++++++
> > >> >  6 files changed, 284 insertions(+)
> > >> >
> > >> > diff --git a/docs/interop/vhost-user.rst
> b/docs/interop/vhost-user.rst
> > >> > index d8419fd2f1..d52ba719d5 100644
> > >> > --- a/docs/interop/vhost-user.rst
> > >> > +++ b/docs/interop/vhost-user.rst
> > >> > @@ -1859,6 +1859,33 @@ is sent by the front-end.
> > >> >    when the operation is successful, or non-zero otherwise. Note
> that
> > >> if the
> > >> >    operation fails, no fd is sent to the backend.
> > >> >
> > >> > +``VHOST_USER_BACKEND_SHMEM_MAP``
> > >> > +  :id: 9
> > >> > +  :equivalent ioctl: N/A
> > >> > +  :request payload: fd and ``struct VhostUserMMap``
> > >> > +  :reply payload: N/A
> > >> > +
> > >> > +  This message can be submitted by the backends to advertise a ne=
w
> > >> mapping
> > >> > +  to be made in a given VIRTIO Shared Memory Region. Upon receivi=
ng
> > >> the message,
> > >> > +  The front-end will mmap the given fd into the VIRTIO Shared
> Memory
> > >> Region
> > >> > +  with the requested ``shmid``. A reply is generated indicating
> > >> whether mapping
> > >> > +  succeeded.
> > >> > +
> > >> > +  Mapping over an already existing map is not allowed and request
> > >> shall fail.
> > >> > +  Therefore, the memory range in the request must correspond with=
 a
> > >> valid,
> > >> > +  free region of the VIRTIO Shared Memory Region.
> > >> > +
> > >> > +``VHOST_USER_BACKEND_SHMEM_UNMAP``
> > >> > +  :id: 10
> > >> > +  :equivalent ioctl: N/A
> > >> > +  :request payload: ``struct VhostUserMMap``
> > >> > +  :reply payload: N/A
> > >> > +
> > >> > +  This message can be submitted by the backends so that the
> front-end
> > >> un-mmap
> > >> > +  a given range (``offset``, ``len``) in the VIRTIO Shared Memory
> > >> Region with
> > >>
> > >> s/offset/shm_offset/
> > >>
> > >> > +  the requested ``shmid``.
> > >>
> > >> Please clarify that <offset, len> must correspond to the entirety of=
 a
> > >> valid mapped region.
> > >>
> > >> By the way, the VIRTIO 1.3 gives the following behavior for the
> virtiofs
> > >> DAX Window:
> > >>
> > >>   When a FUSE_SETUPMAPPING request perfectly overlaps a previous
> > >>   mapping, the previous mapping is replaced. When a mapping partiall=
y
> > >>   overlaps a previous mapping, the previous mapping is split into on=
e
> or
> > >>   two smaller mappings. When a mapping is partially unmapped it is
> also
> > >>   split into one or two smaller mappings.
> > >>
> > >>   Establishing new mappings or splitting existing mappings consumes
> > >>   resources. If the device runs out of resources the FUSE_SETUPMAPPI=
NG
> > >>   request fails until resources are available again following
> > >>   FUSE_REMOVEMAPPING.
> > >>
> > >> I think SETUPMAPPING/REMOVMAPPING can be implemented using
> > >> SHMEM_MAP/UNMAP. SHMEM_MAP/UNMAP do not allow atomically replacing
> > >> partial ranges, but as far as I know that's not necessary for virtio=
fs
> > >> in practice.
> > >>
> > >> It's worth mentioning that mappings consume resources and that
> SHMEM_MAP
> > >> can fail when there are no resources available. The process-wide lim=
it
> > >> is vm.max_map_count on Linux although a vhost-user frontend may redu=
ce
> > >> it further to control vhost-user resource usage.
> > >>
> > >> > +  A reply is generated indicating whether unmapping succeeded.
> > >> > +
> > >> >  .. _reply_ack:
> > >> >
> > >> >  VHOST_USER_PROTOCOL_F_REPLY_ACK
> > >> > diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> > >> > index cdf9af4a4b..7ee8a472c6 100644
> > >> > --- a/hw/virtio/vhost-user.c
> > >> > +++ b/hw/virtio/vhost-user.c
> > >> > @@ -115,6 +115,8 @@ typedef enum VhostUserBackendRequest {
> > >> >      VHOST_USER_BACKEND_SHARED_OBJECT_ADD =3D 6,
> > >> >      VHOST_USER_BACKEND_SHARED_OBJECT_REMOVE =3D 7,
> > >> >      VHOST_USER_BACKEND_SHARED_OBJECT_LOOKUP =3D 8,
> > >> > +    VHOST_USER_BACKEND_SHMEM_MAP =3D 9,
> > >> > +    VHOST_USER_BACKEND_SHMEM_UNMAP =3D 10,
> > >> >      VHOST_USER_BACKEND_MAX
> > >> >  }  VhostUserBackendRequest;
> > >> >
> > >> > @@ -192,6 +194,24 @@ typedef struct VhostUserShared {
> > >> >      unsigned char uuid[16];
> > >> >  } VhostUserShared;
> > >> >
> > >> > +/* For the flags field of VhostUserMMap */
> > >> > +#define VHOST_USER_FLAG_MAP_R (1u << 0)
> > >> > +#define VHOST_USER_FLAG_MAP_W (1u << 1)
> > >> > +
> > >> > +typedef struct {
> > >> > +    /* VIRTIO Shared Memory Region ID */
> > >> > +    uint8_t shmid;
> > >> > +    uint8_t padding[7];
> > >> > +    /* File offset */
> > >> > +    uint64_t fd_offset;
> > >> > +    /* Offset within the VIRTIO Shared Memory Region */
> > >> > +    uint64_t shm_offset;
> > >> > +    /* Size of the mapping */
> > >> > +    uint64_t len;
> > >> > +    /* Flags for the mmap operation, from VHOST_USER_FLAG_* */
> > >> > +    uint64_t flags;
> > >> > +} VhostUserMMap;
> > >> > +
> > >> >  typedef struct {
> > >> >      VhostUserRequest request;
> > >> >
> > >> > @@ -224,6 +244,7 @@ typedef union {
> > >> >          VhostUserInflight inflight;
> > >> >          VhostUserShared object;
> > >> >          VhostUserTransferDeviceState transfer_state;
> > >> > +        VhostUserMMap mmap;
> > >> >  } VhostUserPayload;
> > >> >
> > >> >  typedef struct VhostUserMsg {
> > >> > @@ -1748,6 +1769,100 @@
> > >> vhost_user_backend_handle_shared_object_lookup(struct vhost_user *u,
> > >> >      return 0;
> > >> >  }
> > >> >
> > >> > +static int
> > >> > +vhost_user_backend_handle_shmem_map(struct vhost_dev *dev,
> > >> > +                                    VhostUserMMap *vu_mmap,
> > >> > +                                    int fd)
> > >> > +{
> > >> > +    void *addr =3D 0;
> > >> > +    MemoryRegion *mr =3D NULL;
> > >> > +
> > >> > +    if (fd < 0) {
> > >> > +        error_report("Bad fd for map");
> > >> > +        return -EBADF;
> > >> > +    }
> > >> > +
> > >> > +    if (!dev->vdev->shmem_list ||
> > >> > +        dev->vdev->n_shmem_regions <=3D vu_mmap->shmid) {
> > >> > +        error_report("Device only has %d VIRTIO Shared Memory
> Regions.
> > >> "
> > >> > +                     "Requested ID: %d",
> > >> > +                     dev->vdev->n_shmem_regions, vu_mmap->shmid);
> > >> > +        return -EFAULT;
> > >> > +    }
> > >> > +
> > >> > +    mr =3D &dev->vdev->shmem_list[vu_mmap->shmid];
> > >> > +
> > >> > +    if (!mr) {
> > >> > +        error_report("VIRTIO Shared Memory Region at "
> > >> > +                     "ID %d unitialized", vu_mmap->shmid);
> > >> > +        return -EFAULT;
> > >> > +    }
> > >> > +
> > >> > +    if ((vu_mmap->shm_offset + vu_mmap->len) < vu_mmap->len ||
> > >> > +        (vu_mmap->shm_offset + vu_mmap->len) > mr->size) {
> > >> > +        error_report("Bad offset/len for mmap %" PRIx64 "+%"
> PRIx64,
> > >> > +                     vu_mmap->shm_offset, vu_mmap->len);
> > >> > +        return -EFAULT;
> > >> > +    }
> > >> > +
> > >> > +    void *shmem_ptr =3D memory_region_get_ram_ptr(mr);
> > >> > +
> > >> > +    addr =3D mmap(shmem_ptr + vu_mmap->shm_offset, vu_mmap->len,
> > >>
> > >> Missing check for overlap between range [shm_offset, shm_offset + le=
n)
> > >> and existing mappings.
> > >>
> > >
> > > Not sure how to do this check. Specifically, I am not sure how previo=
us
> > > ranges are stored within the MemoryRegion. Is looping through
> > > mr->subregions
> > > a valid option?
> > >
> >
> > Maybe something like this would do?
> > ```
> >      if (memory_region_find(mr, vu_mmap->shm_offset, vu_mmap->len).mr) =
{
> >         error_report("Requested memory (%" PRIx64 "+%" PRIx64 " overalp=
s
> "
> >                      "with previously mapped memory",
> >                      vu_mmap->shm_offset, vu_mmap->len);
> >         return -EFAULT;
> >     }
> > ```
>
> I don't think that works because the QEMU MemoryRegion covers the entire
> range, some of which contains mappings and some of which is empty. It
> would be necessary to track mappings that have been made.
>
> I'm not aware of a security implication if the overlap check is missing,
> so I guess it may be okay to skip it and rely on the vhost-user back-end
> author to honor the spec. I'm not totally against that because it's
> faster and less code, but it feels a bit iffy to not enforce the input
> validation that the spec requires.
>
> Maintain a list of mappings so this check can be performed?
>
>
Ok, I prefer to aim for the better solution and see where that takes us.
So I will add a mapped_regions list or something like that to the
MemoryRegion struct in a new commit, so that it can be reviewed
independently. With the infrastructure's code in the patch we can decide if
it is worth to have it.

Thank you!


> >
> > >
> > >
> > >>
> > >> > +        ((vu_mmap->flags & VHOST_USER_FLAG_MAP_R) ? PROT_READ : 0=
)
> |
> > >> > +        ((vu_mmap->flags & VHOST_USER_FLAG_MAP_W) ? PROT_WRITE :
> 0),
> > >> > +        MAP_SHARED | MAP_FIXED, fd, vu_mmap->fd_offset);
> > >> > +
> > >> > +    if (addr =3D=3D MAP_FAILED) {
> > >> > +        error_report("Failed to mmap mem fd");
> > >> > +        return -EFAULT;
> > >> > +    }
> > >> > +
> > >> > +    return 0;
> > >> > +}
> > >> > +
> > >> > +static int
> > >> > +vhost_user_backend_handle_shmem_unmap(struct vhost_dev *dev,
> > >> > +                                      VhostUserMMap *vu_mmap)
> > >> > +{
> > >> > +    void *addr =3D 0;
> > >> > +    MemoryRegion *mr =3D NULL;
> > >> > +
> > >> > +    if (!dev->vdev->shmem_list ||
> > >> > +        dev->vdev->n_shmem_regions <=3D vu_mmap->shmid) {
> > >> > +        error_report("Device only has %d VIRTIO Shared Memory
> Regions.
> > >> "
> > >> > +                     "Requested ID: %d",
> > >> > +                     dev->vdev->n_shmem_regions, vu_mmap->shmid);
> > >> > +        return -EFAULT;
> > >> > +    }
> > >> > +
> > >> > +    mr =3D &dev->vdev->shmem_list[vu_mmap->shmid];
> > >> > +
> > >> > +    if (!mr) {
> > >> > +        error_report("VIRTIO Shared Memory Region at "
> > >> > +                     "ID %d unitialized", vu_mmap->shmid);
> > >> > +        return -EFAULT;
> > >> > +    }
> > >> > +
> > >> > +    if ((vu_mmap->shm_offset + vu_mmap->len) < vu_mmap->len ||
> > >> > +        (vu_mmap->shm_offset + vu_mmap->len) > mr->size) {
> > >> > +        error_report("Bad offset/len for mmap %" PRIx64 "+%"
> PRIx64,
> > >> > +                     vu_mmap->shm_offset, vu_mmap->len);
> > >> > +        return -EFAULT;
> > >> > +    }
> > >> > +
> > >> > +    void *shmem_ptr =3D memory_region_get_ram_ptr(mr);
> > >> > +
> > >> > +    addr =3D mmap(shmem_ptr + vu_mmap->shm_offset, vu_mmap->len,
> > >>
> > >> Missing check for existing mapping with exact range [shm_offset, len=
)
> > >> match.
> > >>
> > >> > +                PROT_NONE, MAP_PRIVATE | MAP_ANONYMOUS | MAP_FIXE=
D,
> > >> -1, 0);
> > >> > +
> > >> > +    if (addr =3D=3D MAP_FAILED) {
> > >> > +        error_report("Failed to unmap memory");
> > >> > +        return -EFAULT;
> > >> > +    }
> > >> > +
> > >> > +    return 0;
> > >> > +}
> > >> > +
> > >> >  static void close_backend_channel(struct vhost_user *u)
> > >> >  {
> > >> >      g_source_destroy(u->backend_src);
> > >> > @@ -1816,6 +1931,13 @@ static gboolean backend_read(QIOChannel *io=
c,
> > >> GIOCondition condition,
> > >> >          ret =3D
> > >> vhost_user_backend_handle_shared_object_lookup(dev->opaque, ioc,
> > >> >                                                               &hdr=
,
> > >> &payload);
> > >> >          break;
> > >> > +    case VHOST_USER_BACKEND_SHMEM_MAP:
> > >> > +        ret =3D vhost_user_backend_handle_shmem_map(dev,
> &payload.mmap,
> > >> > +                                                  fd ? fd[0] : -1=
);
> > >> > +        break;
> > >> > +    case VHOST_USER_BACKEND_SHMEM_UNMAP:
> > >> > +        ret =3D vhost_user_backend_handle_shmem_unmap(dev,
> > >> &payload.mmap);
> > >> > +        break;
> > >> >      default:
> > >> >          error_report("Received unexpected msg type: %d.",
> hdr.request);
> > >> >          ret =3D -EINVAL;
> > >> > diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> > >> > index 893a072c9d..9f2da5b11e 100644
> > >> > --- a/hw/virtio/virtio.c
> > >> > +++ b/hw/virtio/virtio.c
> > >> > @@ -2856,6 +2856,16 @@ int virtio_save(VirtIODevice *vdev, QEMUFil=
e
> *f)
> > >> >      return vmstate_save_state(f, &vmstate_virtio, vdev, NULL);
> > >> >  }
> > >> >
> > >> > +MemoryRegion *virtio_new_shmem_region(VirtIODevice *vdev)
> > >> > +{
> > >> > +    MemoryRegion *mr =3D g_new0(MemoryRegion, 1);
> > >> > +    ++vdev->n_shmem_regions;
> > >> > +    vdev->shmem_list =3D g_renew(MemoryRegion, vdev->shmem_list,
> > >> > +                               vdev->n_shmem_regions);
> > >>
> > >> Where is shmem_list freed?
> > >>
> > >> The name "list" is misleading since this is an array, not a list.
> > >>
> > >> > +    vdev->shmem_list[vdev->n_shmem_regions - 1] =3D *mr;
> > >> > +    return mr;
> > >> > +}
> > >>
> > >> This looks weird. The contents of mr are copied into shmem_list[] an=
d
> > >> then the pointer to mr is returned? Did you mean for the field's typ=
e
> to
> > >> be MemoryRegion **shmem_list and then vdev->shmem_list[...] =3D mr w=
ould
> > >> stash the pointer?
> > >>
> > >> > +
> > >> >  /* A wrapper for use as a VMState .put function */
> > >> >  static int virtio_device_put(QEMUFile *f, void *opaque, size_t
> size,
> > >> >                                const VMStateField *field, JSONWrit=
er
> > >> *vmdesc)
> > >> > @@ -3264,6 +3274,8 @@ void virtio_init(VirtIODevice *vdev, uint16_=
t
> > >> device_id, size_t config_size)
> > >> >              virtio_vmstate_change, vdev);
> > >> >      vdev->device_endian =3D virtio_default_endian();
> > >> >      vdev->use_guest_notifier_mask =3D true;
> > >> > +    vdev->shmem_list =3D NULL;
> > >> > +    vdev->n_shmem_regions =3D 0;
> > >> >  }
> > >> >
> > >> >  /*
> > >> > diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio=
.h
> > >> > index 7d5ffdc145..16d598aadc 100644
> > >> > --- a/include/hw/virtio/virtio.h
> > >> > +++ b/include/hw/virtio/virtio.h
> > >> > @@ -165,6 +165,9 @@ struct VirtIODevice
> > >> >       */
> > >> >      EventNotifier config_notifier;
> > >> >      bool device_iotlb_enabled;
> > >> > +    /* Shared memory region for vhost-user mappings. */
> > >> > +    MemoryRegion *shmem_list;
> > >> > +    int n_shmem_regions;
> > >> >  };
> > >> >
> > >> >  struct VirtioDeviceClass {
> > >> > @@ -280,6 +283,8 @@ void virtio_notify(VirtIODevice *vdev, VirtQue=
ue
> > >> *vq);
> > >> >
> > >> >  int virtio_save(VirtIODevice *vdev, QEMUFile *f);
> > >> >
> > >> > +MemoryRegion *virtio_new_shmem_region(VirtIODevice *vdev);
> > >> > +
> > >> >  extern const VMStateInfo virtio_vmstate_info;
> > >> >
> > >> >  #define VMSTATE_VIRTIO_DEVICE \
> > >> > diff --git a/subprojects/libvhost-user/libvhost-user.c
> > >> b/subprojects/libvhost-user/libvhost-user.c
> > >> > index a879149fef..28556d183a 100644
> > >> > --- a/subprojects/libvhost-user/libvhost-user.c
> > >> > +++ b/subprojects/libvhost-user/libvhost-user.c
> > >> > @@ -1586,6 +1586,71 @@ vu_rm_shared_object(VuDev *dev, unsigned ch=
ar
> > >> uuid[UUID_LEN])
> > >> >      return vu_send_message(dev, &msg);
> > >> >  }
> > >> >
> > >> > +bool
> > >> > +vu_shmem_map(VuDev *dev, uint8_t shmid, uint64_t fd_offset,
> > >> > +             uint64_t shm_offset, uint64_t len, uint64_t flags)
> > >> > +{
> > >> > +    bool result =3D false;
> > >> > +    VhostUserMsg msg_reply;
> > >> > +    VhostUserMsg vmsg =3D {
> > >> > +        .request =3D VHOST_USER_BACKEND_SHMEM_MAP,
> > >> > +        .size =3D sizeof(vmsg.payload.mmap),
> > >> > +        .flags =3D VHOST_USER_VERSION,
> > >> > +        .payload.mmap =3D {
> > >> > +            .shmid =3D shmid,
> > >> > +            .fd_offset =3D fd_offset,
> > >> > +            .shm_offset =3D shm_offset,
> > >> > +            .len =3D len,
> > >> > +            .flags =3D flags,
> > >> > +        },
> > >> > +    };
> > >> > +
> > >> > +    if (vu_has_protocol_feature(dev,
> VHOST_USER_PROTOCOL_F_REPLY_ACK))
> > >> {
> > >> > +        vmsg.flags |=3D VHOST_USER_NEED_REPLY_MASK;
> > >> > +    }
> > >> > +
> > >> > +    pthread_mutex_lock(&dev->backend_mutex);
> > >> > +    if (!vu_message_write(dev, dev->backend_fd, &vmsg)) {
> > >> > +        pthread_mutex_unlock(&dev->backend_mutex);
> > >> > +        return false;
> > >> > +    }
> > >> > +
> > >> > +    /* Also unlocks the backend_mutex */
> > >> > +    return vu_process_message_reply(dev, &vmsg);
> > >> > +}
> > >> > +
> > >> > +bool
> > >> > +vu_shmem_unmap(VuDev *dev, uint8_t shmid, uint64_t fd_offset,
> > >> > +               uint64_t shm_offset, uint64_t len)
> > >> > +{
> > >> > +    bool result =3D false;
> > >> > +    VhostUserMsg msg_reply;
> > >> > +    VhostUserMsg vmsg =3D {
> > >> > +        .request =3D VHOST_USER_BACKEND_SHMEM_UNMAP,
> > >> > +        .size =3D sizeof(vmsg.payload.mmap),
> > >> > +        .flags =3D VHOST_USER_VERSION,
> > >> > +        .payload.mmap =3D {
> > >> > +            .shmid =3D shmid,
> > >> > +            .fd_offset =3D fd_offset,
> > >>
> > >> What is the meaning of this field? I expected it to be set to 0.
> > >>
> > >> > +            .shm_offset =3D shm_offset,
> > >> > +            .len =3D len,
> > >> > +        },
> > >> > +    };
> > >> > +
> > >> > +    if (vu_has_protocol_feature(dev,
> VHOST_USER_PROTOCOL_F_REPLY_ACK))
> > >> {
> > >> > +        vmsg.flags |=3D VHOST_USER_NEED_REPLY_MASK;
> > >> > +    }
> > >> > +
> > >> > +    pthread_mutex_lock(&dev->backend_mutex);
> > >> > +    if (!vu_message_write(dev, dev->backend_fd, &vmsg)) {
> > >> > +        pthread_mutex_unlock(&dev->backend_mutex);
> > >> > +        return false;
> > >> > +    }
> > >> > +
> > >> > +    /* Also unlocks the backend_mutex */
> > >> > +    return vu_process_message_reply(dev, &vmsg);
> > >> > +}
> > >> > +
> > >> >  static bool
> > >> >  vu_set_vring_call_exec(VuDev *dev, VhostUserMsg *vmsg)
> > >> >  {
> > >> > diff --git a/subprojects/libvhost-user/libvhost-user.h
> > >> b/subprojects/libvhost-user/libvhost-user.h
> > >> > index deb40e77b3..7f6c22cc1a 100644
> > >> > --- a/subprojects/libvhost-user/libvhost-user.h
> > >> > +++ b/subprojects/libvhost-user/libvhost-user.h
> > >> > @@ -127,6 +127,8 @@ typedef enum VhostUserBackendRequest {
> > >> >      VHOST_USER_BACKEND_SHARED_OBJECT_ADD =3D 6,
> > >> >      VHOST_USER_BACKEND_SHARED_OBJECT_REMOVE =3D 7,
> > >> >      VHOST_USER_BACKEND_SHARED_OBJECT_LOOKUP =3D 8,
> > >> > +    VHOST_USER_BACKEND_SHMEM_MAP =3D 9,
> > >> > +    VHOST_USER_BACKEND_SHMEM_UNMAP =3D 10,
> > >> >      VHOST_USER_BACKEND_MAX
> > >> >  }  VhostUserBackendRequest;
> > >> >
> > >> > @@ -186,6 +188,24 @@ typedef struct VhostUserShared {
> > >> >      unsigned char uuid[UUID_LEN];
> > >> >  } VhostUserShared;
> > >> >
> > >> > +/* For the flags field of VhostUserMMap */
> > >> > +#define VHOST_USER_FLAG_MAP_R (1u << 0)
> > >> > +#define VHOST_USER_FLAG_MAP_W (1u << 1)
> > >> > +
> > >> > +typedef struct {
> > >> > +    /* VIRTIO Shared Memory Region ID */
> > >> > +    uint8_t shmid;
> > >> > +    uint8_t padding[7];
> > >> > +    /* File offset */
> > >> > +    uint64_t fd_offset;
> > >> > +    /* Offset within the VIRTIO Shared Memory Region */
> > >> > +    uint64_t shm_offset;
> > >> > +    /* Size of the mapping */
> > >> > +    uint64_t len;
> > >> > +    /* Flags for the mmap operation, from VHOST_USER_FLAG_* */
> > >> > +    uint64_t flags;
> > >> > +} VhostUserMMap;
> > >> > +
> > >> >  #if defined(_WIN32) && (defined(__x86_64__) || defined(__i386__))
> > >> >  # define VU_PACKED __attribute__((gcc_struct, packed))
> > >> >  #else
> > >> > @@ -214,6 +234,7 @@ typedef struct VhostUserMsg {
> > >> >          VhostUserVringArea area;
> > >> >          VhostUserInflight inflight;
> > >> >          VhostUserShared object;
> > >> > +        VhostUserMMap mmap;
> > >> >      } payload;
> > >> >
> > >> >      int fds[VHOST_MEMORY_BASELINE_NREGIONS];
> > >> > @@ -597,6 +618,38 @@ bool vu_add_shared_object(VuDev *dev, unsigne=
d
> > >> char uuid[UUID_LEN]);
> > >> >   */
> > >> >  bool vu_rm_shared_object(VuDev *dev, unsigned char uuid[UUID_LEN]=
);
> > >> >
> > >> > +/**
> > >> > + * vu_shmem_map:
> > >> > + * @dev: a VuDev context
> > >> > + * @shmid: VIRTIO Shared Memory Region ID
> > >> > + * @fd_offset: File offset
> > >> > + * @shm_offset: Offset within the VIRTIO Shared Memory Region
> > >> > + * @len: Size of the mapping
> > >> > + * @flags: Flags for the mmap operation
> > >> > + *
> > >> > + * Advertises a new mapping to be made in a given VIRTIO Shared
> Memory
> > >> Region.
> > >> > + *
> > >> > + * Returns: TRUE on success, FALSE on failure.
> > >> > + */
> > >> > +bool vu_shmem_map(VuDev *dev, uint8_t shmid, uint64_t fd_offset,
> > >> > +                  uint64_t shm_offset, uint64_t len, uint64_t
> flags);
> > >> > +
> > >> > +/**
> > >> > + * vu_shmem_map:
> > >> > + * @dev: a VuDev context
> > >> > + * @shmid: VIRTIO Shared Memory Region ID
> > >> > + * @fd_offset: File offset
> > >> > + * @shm_offset: Offset within the VIRTIO Shared Memory Region
> > >> > + * @len: Size of the mapping
> > >> > + *
> > >> > + * The front-end un-mmaps a given range in the VIRTIO Shared Memo=
ry
> > >> Region
> > >> > + * with the requested `shmid`.
> > >> > + *
> > >> > + * Returns: TRUE on success, FALSE on failure.
> > >> > + */
> > >> > +bool vu_shmem_unmap(VuDev *dev, uint8_t shmid, uint64_t fd_offset=
,
> > >> > +                  uint64_t shm_offset, uint64_t len);
> > >> > +
> > >> >  /**
> > >> >   * vu_queue_set_notification:
> > >> >   * @dev: a VuDev context
> > >> > --
> > >> > 2.45.2
> > >> >
> > >>
> > >
>

--0000000000009a6b8b0621d6b12a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br clear=3D"all"><div><div dir=3D"ltr" c=
lass=3D"gmail_signature"><div dir=3D"ltr"><p style=3D"color:rgb(0,0,0);font=
-family:RedHatText,sans-serif;font-weight:bold;margin:0px;padding:0px;font-=
size:14px"><br></p></div></div></div></div><br><div class=3D"gmail_quote"><=
div dir=3D"ltr" class=3D"gmail_attr">On Thu, Sep 5, 2024 at 6:45=E2=80=AFPM=
 Stefan Hajnoczi &lt;<a href=3D"mailto:stefanha@redhat.com">stefanha@redhat=
.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1=
ex">On Tue, Sep 03, 2024 at 01:54:12PM +0200, Albert Esteve wrote:<br>
&gt; On Tue, Sep 3, 2024 at 11:54=E2=80=AFAM Albert Esteve &lt;<a href=3D"m=
ailto:aesteve@redhat.com" target=3D"_blank">aesteve@redhat.com</a>&gt; wrot=
e:<br>
&gt; <br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; On Thu, Jul 11, 2024 at 9:45=E2=80=AFAM Stefan Hajnoczi &lt;<a hr=
ef=3D"mailto:stefanha@redhat.com" target=3D"_blank">stefanha@redhat.com</a>=
&gt;<br>
&gt; &gt; wrote:<br>
&gt; &gt;<br>
&gt; &gt;&gt; On Fri, Jun 28, 2024 at 04:57:06PM +0200, Albert Esteve wrote=
:<br>
&gt; &gt;&gt; &gt; Add SHMEM_MAP/UNMAP requests to vhost-user to<br>
&gt; &gt;&gt; &gt; handle VIRTIO Shared Memory mappings.<br>
&gt; &gt;&gt; &gt;<br>
&gt; &gt;&gt; &gt; This request allows backends to dynamically map<br>
&gt; &gt;&gt; &gt; fds into a VIRTIO Shared Memory Region indentified<br>
&gt; &gt;&gt; &gt; by its `shmid`. Then, the fd memory is advertised<br>
&gt; &gt;&gt; &gt; to the driver as a base addres + offset, so it<br>
&gt; &gt;&gt; &gt; can be read/written (depending on the mmap flags<br>
&gt; &gt;&gt; &gt; requested) while its valid.<br>
&gt; &gt;&gt; &gt;<br>
&gt; &gt;&gt; &gt; The backend can munmap the memory range<br>
&gt; &gt;&gt; &gt; in a given VIRTIO Shared Memory Region (again,<br>
&gt; &gt;&gt; &gt; identified by its `shmid`), to free it. Upon<br>
&gt; &gt;&gt; &gt; receiving this message, the front-end must<br>
&gt; &gt;&gt; &gt; mmap the regions with PROT_NONE to reserve<br>
&gt; &gt;&gt; &gt; the virtual memory space.<br>
&gt; &gt;&gt; &gt;<br>
&gt; &gt;&gt; &gt; The device model needs to create MemoryRegion<br>
&gt; &gt;&gt; &gt; instances for the VIRTIO Shared Memory Regions<br>
&gt; &gt;&gt; &gt; and add them to the `VirtIODevice` instance.<br>
&gt; &gt;&gt; &gt;<br>
&gt; &gt;&gt; &gt; Signed-off-by: Albert Esteve &lt;<a href=3D"mailto:aeste=
ve@redhat.com" target=3D"_blank">aesteve@redhat.com</a>&gt;<br>
&gt; &gt;&gt; &gt; ---<br>
&gt; &gt;&gt; &gt;=C2=A0 docs/interop/vhost-user.rst=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 27 +++++<br>
&gt; &gt;&gt; &gt;=C2=A0 hw/virtio/vhost-user.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 122 ++++++++++++++++++++++<br>
&gt; &gt;&gt; &gt;=C2=A0 hw/virtio/virtio.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 12 +++<br>
&gt; &gt;&gt; &gt;=C2=A0 include/hw/virtio/virtio.h=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A05 +<br>
&gt; &gt;&gt; &gt;=C2=A0 subprojects/libvhost-user/libvhost-user.c |=C2=A0 =
65 ++++++++++++<br>
&gt; &gt;&gt; &gt;=C2=A0 subprojects/libvhost-user/libvhost-user.h |=C2=A0 =
53 ++++++++++<br>
&gt; &gt;&gt; &gt;=C2=A0 6 files changed, 284 insertions(+)<br>
&gt; &gt;&gt; &gt;<br>
&gt; &gt;&gt; &gt; diff --git a/docs/interop/vhost-user.rst b/docs/interop/=
vhost-user.rst<br>
&gt; &gt;&gt; &gt; index d8419fd2f1..d52ba719d5 100644<br>
&gt; &gt;&gt; &gt; --- a/docs/interop/vhost-user.rst<br>
&gt; &gt;&gt; &gt; +++ b/docs/interop/vhost-user.rst<br>
&gt; &gt;&gt; &gt; @@ -1859,6 +1859,33 @@ is sent by the front-end.<br>
&gt; &gt;&gt; &gt;=C2=A0 =C2=A0 when the operation is successful, or non-ze=
ro otherwise. Note that<br>
&gt; &gt;&gt; if the<br>
&gt; &gt;&gt; &gt;=C2=A0 =C2=A0 operation fails, no fd is sent to the backe=
nd.<br>
&gt; &gt;&gt; &gt;<br>
&gt; &gt;&gt; &gt; +``VHOST_USER_BACKEND_SHMEM_MAP``<br>
&gt; &gt;&gt; &gt; +=C2=A0 :id: 9<br>
&gt; &gt;&gt; &gt; +=C2=A0 :equivalent ioctl: N/A<br>
&gt; &gt;&gt; &gt; +=C2=A0 :request payload: fd and ``struct VhostUserMMap`=
`<br>
&gt; &gt;&gt; &gt; +=C2=A0 :reply payload: N/A<br>
&gt; &gt;&gt; &gt; +<br>
&gt; &gt;&gt; &gt; +=C2=A0 This message can be submitted by the backends to=
 advertise a new<br>
&gt; &gt;&gt; mapping<br>
&gt; &gt;&gt; &gt; +=C2=A0 to be made in a given VIRTIO Shared Memory Regio=
n. Upon receiving<br>
&gt; &gt;&gt; the message,<br>
&gt; &gt;&gt; &gt; +=C2=A0 The front-end will mmap the given fd into the VI=
RTIO Shared Memory<br>
&gt; &gt;&gt; Region<br>
&gt; &gt;&gt; &gt; +=C2=A0 with the requested ``shmid``. A reply is generat=
ed indicating<br>
&gt; &gt;&gt; whether mapping<br>
&gt; &gt;&gt; &gt; +=C2=A0 succeeded.<br>
&gt; &gt;&gt; &gt; +<br>
&gt; &gt;&gt; &gt; +=C2=A0 Mapping over an already existing map is not allo=
wed and request<br>
&gt; &gt;&gt; shall fail.<br>
&gt; &gt;&gt; &gt; +=C2=A0 Therefore, the memory range in the request must =
correspond with a<br>
&gt; &gt;&gt; valid,<br>
&gt; &gt;&gt; &gt; +=C2=A0 free region of the VIRTIO Shared Memory Region.<=
br>
&gt; &gt;&gt; &gt; +<br>
&gt; &gt;&gt; &gt; +``VHOST_USER_BACKEND_SHMEM_UNMAP``<br>
&gt; &gt;&gt; &gt; +=C2=A0 :id: 10<br>
&gt; &gt;&gt; &gt; +=C2=A0 :equivalent ioctl: N/A<br>
&gt; &gt;&gt; &gt; +=C2=A0 :request payload: ``struct VhostUserMMap``<br>
&gt; &gt;&gt; &gt; +=C2=A0 :reply payload: N/A<br>
&gt; &gt;&gt; &gt; +<br>
&gt; &gt;&gt; &gt; +=C2=A0 This message can be submitted by the backends so=
 that the front-end<br>
&gt; &gt;&gt; un-mmap<br>
&gt; &gt;&gt; &gt; +=C2=A0 a given range (``offset``, ``len``) in the VIRTI=
O Shared Memory<br>
&gt; &gt;&gt; Region with<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; s/offset/shm_offset/<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; &gt; +=C2=A0 the requested ``shmid``.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Please clarify that &lt;offset, len&gt; must correspond to th=
e entirety of a<br>
&gt; &gt;&gt; valid mapped region.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; By the way, the VIRTIO 1.3 gives the following behavior for t=
he virtiofs<br>
&gt; &gt;&gt; DAX Window:<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt;=C2=A0 =C2=A0When a FUSE_SETUPMAPPING request perfectly overla=
ps a previous<br>
&gt; &gt;&gt;=C2=A0 =C2=A0mapping, the previous mapping is replaced. When a=
 mapping partially<br>
&gt; &gt;&gt;=C2=A0 =C2=A0overlaps a previous mapping, the previous mapping=
 is split into one or<br>
&gt; &gt;&gt;=C2=A0 =C2=A0two smaller mappings. When a mapping is partially=
 unmapped it is also<br>
&gt; &gt;&gt;=C2=A0 =C2=A0split into one or two smaller mappings.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt;=C2=A0 =C2=A0Establishing new mappings or splitting existing m=
appings consumes<br>
&gt; &gt;&gt;=C2=A0 =C2=A0resources. If the device runs out of resources th=
e FUSE_SETUPMAPPING<br>
&gt; &gt;&gt;=C2=A0 =C2=A0request fails until resources are available again=
 following<br>
&gt; &gt;&gt;=C2=A0 =C2=A0FUSE_REMOVEMAPPING.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; I think SETUPMAPPING/REMOVMAPPING can be implemented using<br=
>
&gt; &gt;&gt; SHMEM_MAP/UNMAP. SHMEM_MAP/UNMAP do not allow atomically repl=
acing<br>
&gt; &gt;&gt; partial ranges, but as far as I know that&#39;s not necessary=
 for virtiofs<br>
&gt; &gt;&gt; in practice.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; It&#39;s worth mentioning that mappings consume resources and=
 that SHMEM_MAP<br>
&gt; &gt;&gt; can fail when there are no resources available. The process-w=
ide limit<br>
&gt; &gt;&gt; is vm.max_map_count on Linux although a vhost-user frontend m=
ay reduce<br>
&gt; &gt;&gt; it further to control vhost-user resource usage.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; &gt; +=C2=A0 A reply is generated indicating whether unmappin=
g succeeded.<br>
&gt; &gt;&gt; &gt; +<br>
&gt; &gt;&gt; &gt;=C2=A0 .. _reply_ack:<br>
&gt; &gt;&gt; &gt;<br>
&gt; &gt;&gt; &gt;=C2=A0 VHOST_USER_PROTOCOL_F_REPLY_ACK<br>
&gt; &gt;&gt; &gt; diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-us=
er.c<br>
&gt; &gt;&gt; &gt; index cdf9af4a4b..7ee8a472c6 100644<br>
&gt; &gt;&gt; &gt; --- a/hw/virtio/vhost-user.c<br>
&gt; &gt;&gt; &gt; +++ b/hw/virtio/vhost-user.c<br>
&gt; &gt;&gt; &gt; @@ -115,6 +115,8 @@ typedef enum VhostUserBackendRequest=
 {<br>
&gt; &gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 VHOST_USER_BACKEND_SHARED_OBJECT_ADD=
 =3D 6,<br>
&gt; &gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 VHOST_USER_BACKEND_SHARED_OBJECT_REM=
OVE =3D 7,<br>
&gt; &gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 VHOST_USER_BACKEND_SHARED_OBJECT_LOO=
KUP =3D 8,<br>
&gt; &gt;&gt; &gt; +=C2=A0 =C2=A0 VHOST_USER_BACKEND_SHMEM_MAP =3D 9,<br>
&gt; &gt;&gt; &gt; +=C2=A0 =C2=A0 VHOST_USER_BACKEND_SHMEM_UNMAP =3D 10,<br=
>
&gt; &gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 VHOST_USER_BACKEND_MAX<br>
&gt; &gt;&gt; &gt;=C2=A0 }=C2=A0 VhostUserBackendRequest;<br>
&gt; &gt;&gt; &gt;<br>
&gt; &gt;&gt; &gt; @@ -192,6 +194,24 @@ typedef struct VhostUserShared {<br=
>
&gt; &gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 unsigned char uuid[16];<br>
&gt; &gt;&gt; &gt;=C2=A0 } VhostUserShared;<br>
&gt; &gt;&gt; &gt;<br>
&gt; &gt;&gt; &gt; +/* For the flags field of VhostUserMMap */<br>
&gt; &gt;&gt; &gt; +#define VHOST_USER_FLAG_MAP_R (1u &lt;&lt; 0)<br>
&gt; &gt;&gt; &gt; +#define VHOST_USER_FLAG_MAP_W (1u &lt;&lt; 1)<br>
&gt; &gt;&gt; &gt; +<br>
&gt; &gt;&gt; &gt; +typedef struct {<br>
&gt; &gt;&gt; &gt; +=C2=A0 =C2=A0 /* VIRTIO Shared Memory Region ID */<br>
&gt; &gt;&gt; &gt; +=C2=A0 =C2=A0 uint8_t shmid;<br>
&gt; &gt;&gt; &gt; +=C2=A0 =C2=A0 uint8_t padding[7];<br>
&gt; &gt;&gt; &gt; +=C2=A0 =C2=A0 /* File offset */<br>
&gt; &gt;&gt; &gt; +=C2=A0 =C2=A0 uint64_t fd_offset;<br>
&gt; &gt;&gt; &gt; +=C2=A0 =C2=A0 /* Offset within the VIRTIO Shared Memory=
 Region */<br>
&gt; &gt;&gt; &gt; +=C2=A0 =C2=A0 uint64_t shm_offset;<br>
&gt; &gt;&gt; &gt; +=C2=A0 =C2=A0 /* Size of the mapping */<br>
&gt; &gt;&gt; &gt; +=C2=A0 =C2=A0 uint64_t len;<br>
&gt; &gt;&gt; &gt; +=C2=A0 =C2=A0 /* Flags for the mmap operation, from VHO=
ST_USER_FLAG_* */<br>
&gt; &gt;&gt; &gt; +=C2=A0 =C2=A0 uint64_t flags;<br>
&gt; &gt;&gt; &gt; +} VhostUserMMap;<br>
&gt; &gt;&gt; &gt; +<br>
&gt; &gt;&gt; &gt;=C2=A0 typedef struct {<br>
&gt; &gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 VhostUserRequest request;<br>
&gt; &gt;&gt; &gt;<br>
&gt; &gt;&gt; &gt; @@ -224,6 +244,7 @@ typedef union {<br>
&gt; &gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 VhostUserInflight infl=
ight;<br>
&gt; &gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 VhostUserShared object=
;<br>
&gt; &gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 VhostUserTransferDevic=
eState transfer_state;<br>
&gt; &gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VhostUserMMap mmap;<br>
&gt; &gt;&gt; &gt;=C2=A0 } VhostUserPayload;<br>
&gt; &gt;&gt; &gt;<br>
&gt; &gt;&gt; &gt;=C2=A0 typedef struct VhostUserMsg {<br>
&gt; &gt;&gt; &gt; @@ -1748,6 +1769,100 @@<br>
&gt; &gt;&gt; vhost_user_backend_handle_shared_object_lookup(struct vhost_u=
ser *u,<br>
&gt; &gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 return 0;<br>
&gt; &gt;&gt; &gt;=C2=A0 }<br>
&gt; &gt;&gt; &gt;<br>
&gt; &gt;&gt; &gt; +static int<br>
&gt; &gt;&gt; &gt; +vhost_user_backend_handle_shmem_map(struct vhost_dev *d=
ev,<br>
&gt; &gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Vhos=
tUserMMap *vu_mmap,<br>
&gt; &gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int =
fd)<br>
&gt; &gt;&gt; &gt; +{<br>
&gt; &gt;&gt; &gt; +=C2=A0 =C2=A0 void *addr =3D 0;<br>
&gt; &gt;&gt; &gt; +=C2=A0 =C2=A0 MemoryRegion *mr =3D NULL;<br>
&gt; &gt;&gt; &gt; +<br>
&gt; &gt;&gt; &gt; +=C2=A0 =C2=A0 if (fd &lt; 0) {<br>
&gt; &gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot;Bad fd f=
or map&quot;);<br>
&gt; &gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EBADF;<br>
&gt; &gt;&gt; &gt; +=C2=A0 =C2=A0 }<br>
&gt; &gt;&gt; &gt; +<br>
&gt; &gt;&gt; &gt; +=C2=A0 =C2=A0 if (!dev-&gt;vdev-&gt;shmem_list ||<br>
&gt; &gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 dev-&gt;vdev-&gt;n_shmem_re=
gions &lt;=3D vu_mmap-&gt;shmid) {<br>
&gt; &gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot;Device o=
nly has %d VIRTIO Shared Memory Regions.<br>
&gt; &gt;&gt; &quot;<br>
&gt; &gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0&quot;Requested ID: %d&quot;,<br>
&gt; &gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0dev-&gt;vdev-&gt;n_shmem_regions, vu_mmap-&gt;shmid);<=
br>
&gt; &gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EFAULT;<br>
&gt; &gt;&gt; &gt; +=C2=A0 =C2=A0 }<br>
&gt; &gt;&gt; &gt; +<br>
&gt; &gt;&gt; &gt; +=C2=A0 =C2=A0 mr =3D &amp;dev-&gt;vdev-&gt;shmem_list[v=
u_mmap-&gt;shmid];<br>
&gt; &gt;&gt; &gt; +<br>
&gt; &gt;&gt; &gt; +=C2=A0 =C2=A0 if (!mr) {<br>
&gt; &gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot;VIRTIO S=
hared Memory Region at &quot;<br>
&gt; &gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0&quot;ID %d unitialized&quot;, vu_mmap-&gt;shmid);<br>
&gt; &gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EFAULT;<br>
&gt; &gt;&gt; &gt; +=C2=A0 =C2=A0 }<br>
&gt; &gt;&gt; &gt; +<br>
&gt; &gt;&gt; &gt; +=C2=A0 =C2=A0 if ((vu_mmap-&gt;shm_offset + vu_mmap-&gt=
;len) &lt; vu_mmap-&gt;len ||<br>
&gt; &gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 (vu_mmap-&gt;shm_offset + v=
u_mmap-&gt;len) &gt; mr-&gt;size) {<br>
&gt; &gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot;Bad offs=
et/len for mmap %&quot; PRIx64 &quot;+%&quot; PRIx64,<br>
&gt; &gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0vu_mmap-&gt;shm_offset, vu_mmap-&gt;len);<br>
&gt; &gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EFAULT;<br>
&gt; &gt;&gt; &gt; +=C2=A0 =C2=A0 }<br>
&gt; &gt;&gt; &gt; +<br>
&gt; &gt;&gt; &gt; +=C2=A0 =C2=A0 void *shmem_ptr =3D memory_region_get_ram=
_ptr(mr);<br>
&gt; &gt;&gt; &gt; +<br>
&gt; &gt;&gt; &gt; +=C2=A0 =C2=A0 addr =3D mmap(shmem_ptr + vu_mmap-&gt;shm=
_offset, vu_mmap-&gt;len,<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Missing check for overlap between range [shm_offset, shm_offs=
et + len)<br>
&gt; &gt;&gt; and existing mappings.<br>
&gt; &gt;&gt;<br>
&gt; &gt;<br>
&gt; &gt; Not sure how to do this check. Specifically, I am not sure how pr=
evious<br>
&gt; &gt; ranges are stored within the MemoryRegion. Is looping through<br>
&gt; &gt; mr-&gt;subregions<br>
&gt; &gt; a valid option?<br>
&gt; &gt;<br>
&gt; <br>
&gt; Maybe something like this would do?<br>
&gt; ```<br>
&gt;=C2=A0 =C2=A0 =C2=A0 if (memory_region_find(mr, vu_mmap-&gt;shm_offset,=
 vu_mmap-&gt;len).mr) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error_report(&quot;Requested memory (=
%&quot; PRIx64 &quot;+%&quot; PRIx64 &quot; overalps &quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 &quot;with previously mapped memory&quot;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 vu_mmap-&gt;shm_offset, vu_mmap-&gt;len);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EFAULT;<br>
&gt;=C2=A0 =C2=A0 =C2=A0}<br>
&gt; ```<br>
<br>
I don&#39;t think that works because the QEMU MemoryRegion covers the entir=
e<br>
range, some of which contains mappings and some of which is empty. It<br>
would be necessary to track mappings that have been made.<br>
<br>
I&#39;m not aware of a security implication if the overlap check is missing=
,<br>
so I guess it may be okay to skip it and rely on the vhost-user back-end<br=
>
author to honor the spec. I&#39;m not totally against that because it&#39;s=
<br>
faster and less code, but it feels a bit iffy to not enforce the input<br>
validation that the spec requires.<br>
<br>
Maintain a list of mappings so this check can be performed?<br>
<br></blockquote><div><br></div><div>Ok, I prefer to aim for the better sol=
ution and see where that takes us.</div><div>So I will add a mapped_regions=
 list or something like that to the</div><div>MemoryRegion struct in a new =
commit, so that it can be reviewed</div><div>independently. With the infras=
tructure&#39;s code in the patch we can decide if</div><div>it is worth to =
have it.</div><div><br></div><div>Thank you!</div><div>=C2=A0</div><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px=
 solid rgb(204,204,204);padding-left:1ex">
&gt; <br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ((vu_mmap-&gt;flags &amp; V=
HOST_USER_FLAG_MAP_R) ? PROT_READ : 0) |<br>
&gt; &gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ((vu_mmap-&gt;flags &amp; V=
HOST_USER_FLAG_MAP_W) ? PROT_WRITE : 0),<br>
&gt; &gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 MAP_SHARED | MAP_FIXED, fd,=
 vu_mmap-&gt;fd_offset);<br>
&gt; &gt;&gt; &gt; +<br>
&gt; &gt;&gt; &gt; +=C2=A0 =C2=A0 if (addr =3D=3D MAP_FAILED) {<br>
&gt; &gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot;Failed t=
o mmap mem fd&quot;);<br>
&gt; &gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EFAULT;<br>
&gt; &gt;&gt; &gt; +=C2=A0 =C2=A0 }<br>
&gt; &gt;&gt; &gt; +<br>
&gt; &gt;&gt; &gt; +=C2=A0 =C2=A0 return 0;<br>
&gt; &gt;&gt; &gt; +}<br>
&gt; &gt;&gt; &gt; +<br>
&gt; &gt;&gt; &gt; +static int<br>
&gt; &gt;&gt; &gt; +vhost_user_backend_handle_shmem_unmap(struct vhost_dev =
*dev,<br>
&gt; &gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 VhostUserMMap *vu_mmap)<br>
&gt; &gt;&gt; &gt; +{<br>
&gt; &gt;&gt; &gt; +=C2=A0 =C2=A0 void *addr =3D 0;<br>
&gt; &gt;&gt; &gt; +=C2=A0 =C2=A0 MemoryRegion *mr =3D NULL;<br>
&gt; &gt;&gt; &gt; +<br>
&gt; &gt;&gt; &gt; +=C2=A0 =C2=A0 if (!dev-&gt;vdev-&gt;shmem_list ||<br>
&gt; &gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 dev-&gt;vdev-&gt;n_shmem_re=
gions &lt;=3D vu_mmap-&gt;shmid) {<br>
&gt; &gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot;Device o=
nly has %d VIRTIO Shared Memory Regions.<br>
&gt; &gt;&gt; &quot;<br>
&gt; &gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0&quot;Requested ID: %d&quot;,<br>
&gt; &gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0dev-&gt;vdev-&gt;n_shmem_regions, vu_mmap-&gt;shmid);<=
br>
&gt; &gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EFAULT;<br>
&gt; &gt;&gt; &gt; +=C2=A0 =C2=A0 }<br>
&gt; &gt;&gt; &gt; +<br>
&gt; &gt;&gt; &gt; +=C2=A0 =C2=A0 mr =3D &amp;dev-&gt;vdev-&gt;shmem_list[v=
u_mmap-&gt;shmid];<br>
&gt; &gt;&gt; &gt; +<br>
&gt; &gt;&gt; &gt; +=C2=A0 =C2=A0 if (!mr) {<br>
&gt; &gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot;VIRTIO S=
hared Memory Region at &quot;<br>
&gt; &gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0&quot;ID %d unitialized&quot;, vu_mmap-&gt;shmid);<br>
&gt; &gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EFAULT;<br>
&gt; &gt;&gt; &gt; +=C2=A0 =C2=A0 }<br>
&gt; &gt;&gt; &gt; +<br>
&gt; &gt;&gt; &gt; +=C2=A0 =C2=A0 if ((vu_mmap-&gt;shm_offset + vu_mmap-&gt=
;len) &lt; vu_mmap-&gt;len ||<br>
&gt; &gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 (vu_mmap-&gt;shm_offset + v=
u_mmap-&gt;len) &gt; mr-&gt;size) {<br>
&gt; &gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot;Bad offs=
et/len for mmap %&quot; PRIx64 &quot;+%&quot; PRIx64,<br>
&gt; &gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0vu_mmap-&gt;shm_offset, vu_mmap-&gt;len);<br>
&gt; &gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EFAULT;<br>
&gt; &gt;&gt; &gt; +=C2=A0 =C2=A0 }<br>
&gt; &gt;&gt; &gt; +<br>
&gt; &gt;&gt; &gt; +=C2=A0 =C2=A0 void *shmem_ptr =3D memory_region_get_ram=
_ptr(mr);<br>
&gt; &gt;&gt; &gt; +<br>
&gt; &gt;&gt; &gt; +=C2=A0 =C2=A0 addr =3D mmap(shmem_ptr + vu_mmap-&gt;shm=
_offset, vu_mmap-&gt;len,<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Missing check for existing mapping with exact range [shm_offs=
et, len)<br>
&gt; &gt;&gt; match.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 PROT_NONE, MAP_PRIVATE | MAP_ANONYMOUS | MAP_FIXED,<br>
&gt; &gt;&gt; -1, 0);<br>
&gt; &gt;&gt; &gt; +<br>
&gt; &gt;&gt; &gt; +=C2=A0 =C2=A0 if (addr =3D=3D MAP_FAILED) {<br>
&gt; &gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot;Failed t=
o unmap memory&quot;);<br>
&gt; &gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EFAULT;<br>
&gt; &gt;&gt; &gt; +=C2=A0 =C2=A0 }<br>
&gt; &gt;&gt; &gt; +<br>
&gt; &gt;&gt; &gt; +=C2=A0 =C2=A0 return 0;<br>
&gt; &gt;&gt; &gt; +}<br>
&gt; &gt;&gt; &gt; +<br>
&gt; &gt;&gt; &gt;=C2=A0 static void close_backend_channel(struct vhost_use=
r *u)<br>
&gt; &gt;&gt; &gt;=C2=A0 {<br>
&gt; &gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 g_source_destroy(u-&gt;backend_src);=
<br>
&gt; &gt;&gt; &gt; @@ -1816,6 +1931,13 @@ static gboolean backend_read(QIOC=
hannel *ioc,<br>
&gt; &gt;&gt; GIOCondition condition,<br>
&gt; &gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D<br>
&gt; &gt;&gt; vhost_user_backend_handle_shared_object_lookup(dev-&gt;opaque=
, ioc,<br>
&gt; &gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0&amp;hdr,<br>
&gt; &gt;&gt; &amp;payload);<br>
&gt; &gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; &gt;&gt; &gt; +=C2=A0 =C2=A0 case VHOST_USER_BACKEND_SHMEM_MAP:<br>
&gt; &gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D vhost_user_backend_=
handle_shmem_map(dev, &amp;payload.mmap,<br>
&gt; &gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fd ? fd[0] : -1);<br>
&gt; &gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; &gt;&gt; &gt; +=C2=A0 =C2=A0 case VHOST_USER_BACKEND_SHMEM_UNMAP:<br>
&gt; &gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D vhost_user_backend_=
handle_shmem_unmap(dev,<br>
&gt; &gt;&gt; &amp;payload.mmap);<br>
&gt; &gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; &gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 default:<br>
&gt; &gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot;Rec=
eived unexpected msg type: %d.&quot;, hdr.request);<br>
&gt; &gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D -EINVAL;<br>
&gt; &gt;&gt; &gt; diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c<br>
&gt; &gt;&gt; &gt; index 893a072c9d..9f2da5b11e 100644<br>
&gt; &gt;&gt; &gt; --- a/hw/virtio/virtio.c<br>
&gt; &gt;&gt; &gt; +++ b/hw/virtio/virtio.c<br>
&gt; &gt;&gt; &gt; @@ -2856,6 +2856,16 @@ int virtio_save(VirtIODevice *vde=
v, QEMUFile *f)<br>
&gt; &gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 return vmstate_save_state(f, &amp;vm=
state_virtio, vdev, NULL);<br>
&gt; &gt;&gt; &gt;=C2=A0 }<br>
&gt; &gt;&gt; &gt;<br>
&gt; &gt;&gt; &gt; +MemoryRegion *virtio_new_shmem_region(VirtIODevice *vde=
v)<br>
&gt; &gt;&gt; &gt; +{<br>
&gt; &gt;&gt; &gt; +=C2=A0 =C2=A0 MemoryRegion *mr =3D g_new0(MemoryRegion,=
 1);<br>
&gt; &gt;&gt; &gt; +=C2=A0 =C2=A0 ++vdev-&gt;n_shmem_regions;<br>
&gt; &gt;&gt; &gt; +=C2=A0 =C2=A0 vdev-&gt;shmem_list =3D g_renew(MemoryReg=
ion, vdev-&gt;shmem_list,<br>
&gt; &gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vdev-&gt;n_shmem_re=
gions);<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Where is shmem_list freed?<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; The name &quot;list&quot; is misleading since this is an arra=
y, not a list.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; &gt; +=C2=A0 =C2=A0 vdev-&gt;shmem_list[vdev-&gt;n_shmem_regi=
ons - 1] =3D *mr;<br>
&gt; &gt;&gt; &gt; +=C2=A0 =C2=A0 return mr;<br>
&gt; &gt;&gt; &gt; +}<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; This looks weird. The contents of mr are copied into shmem_li=
st[] and<br>
&gt; &gt;&gt; then the pointer to mr is returned? Did you mean for the fiel=
d&#39;s type to<br>
&gt; &gt;&gt; be MemoryRegion **shmem_list and then vdev-&gt;shmem_list[...=
] =3D mr would<br>
&gt; &gt;&gt; stash the pointer?<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; &gt; +<br>
&gt; &gt;&gt; &gt;=C2=A0 /* A wrapper for use as a VMState .put function */=
<br>
&gt; &gt;&gt; &gt;=C2=A0 static int virtio_device_put(QEMUFile *f, void *op=
aque, size_t size,<br>
&gt; &gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const VMStateField =
*field, JSONWriter<br>
&gt; &gt;&gt; *vmdesc)<br>
&gt; &gt;&gt; &gt; @@ -3264,6 +3274,8 @@ void virtio_init(VirtIODevice *vde=
v, uint16_t<br>
&gt; &gt;&gt; device_id, size_t config_size)<br>
&gt; &gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 virtio_v=
mstate_change, vdev);<br>
&gt; &gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 vdev-&gt;device_endian =3D virtio_de=
fault_endian();<br>
&gt; &gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 vdev-&gt;use_guest_notifier_mask =3D=
 true;<br>
&gt; &gt;&gt; &gt; +=C2=A0 =C2=A0 vdev-&gt;shmem_list =3D NULL;<br>
&gt; &gt;&gt; &gt; +=C2=A0 =C2=A0 vdev-&gt;n_shmem_regions =3D 0;<br>
&gt; &gt;&gt; &gt;=C2=A0 }<br>
&gt; &gt;&gt; &gt;<br>
&gt; &gt;&gt; &gt;=C2=A0 /*<br>
&gt; &gt;&gt; &gt; diff --git a/include/hw/virtio/virtio.h b/include/hw/vir=
tio/virtio.h<br>
&gt; &gt;&gt; &gt; index 7d5ffdc145..16d598aadc 100644<br>
&gt; &gt;&gt; &gt; --- a/include/hw/virtio/virtio.h<br>
&gt; &gt;&gt; &gt; +++ b/include/hw/virtio/virtio.h<br>
&gt; &gt;&gt; &gt; @@ -165,6 +165,9 @@ struct VirtIODevice<br>
&gt; &gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
&gt; &gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 EventNotifier config_notifier;<br>
&gt; &gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 bool device_iotlb_enabled;<br>
&gt; &gt;&gt; &gt; +=C2=A0 =C2=A0 /* Shared memory region for vhost-user ma=
ppings. */<br>
&gt; &gt;&gt; &gt; +=C2=A0 =C2=A0 MemoryRegion *shmem_list;<br>
&gt; &gt;&gt; &gt; +=C2=A0 =C2=A0 int n_shmem_regions;<br>
&gt; &gt;&gt; &gt;=C2=A0 };<br>
&gt; &gt;&gt; &gt;<br>
&gt; &gt;&gt; &gt;=C2=A0 struct VirtioDeviceClass {<br>
&gt; &gt;&gt; &gt; @@ -280,6 +283,8 @@ void virtio_notify(VirtIODevice *vde=
v, VirtQueue<br>
&gt; &gt;&gt; *vq);<br>
&gt; &gt;&gt; &gt;<br>
&gt; &gt;&gt; &gt;=C2=A0 int virtio_save(VirtIODevice *vdev, QEMUFile *f);<=
br>
&gt; &gt;&gt; &gt;<br>
&gt; &gt;&gt; &gt; +MemoryRegion *virtio_new_shmem_region(VirtIODevice *vde=
v);<br>
&gt; &gt;&gt; &gt; +<br>
&gt; &gt;&gt; &gt;=C2=A0 extern const VMStateInfo virtio_vmstate_info;<br>
&gt; &gt;&gt; &gt;<br>
&gt; &gt;&gt; &gt;=C2=A0 #define VMSTATE_VIRTIO_DEVICE \<br>
&gt; &gt;&gt; &gt; diff --git a/subprojects/libvhost-user/libvhost-user.c<b=
r>
&gt; &gt;&gt; b/subprojects/libvhost-user/libvhost-user.c<br>
&gt; &gt;&gt; &gt; index a879149fef..28556d183a 100644<br>
&gt; &gt;&gt; &gt; --- a/subprojects/libvhost-user/libvhost-user.c<br>
&gt; &gt;&gt; &gt; +++ b/subprojects/libvhost-user/libvhost-user.c<br>
&gt; &gt;&gt; &gt; @@ -1586,6 +1586,71 @@ vu_rm_shared_object(VuDev *dev, u=
nsigned char<br>
&gt; &gt;&gt; uuid[UUID_LEN])<br>
&gt; &gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 return vu_send_message(dev, &amp;msg=
);<br>
&gt; &gt;&gt; &gt;=C2=A0 }<br>
&gt; &gt;&gt; &gt;<br>
&gt; &gt;&gt; &gt; +bool<br>
&gt; &gt;&gt; &gt; +vu_shmem_map(VuDev *dev, uint8_t shmid, uint64_t fd_off=
set,<br>
&gt; &gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint64_=
t shm_offset, uint64_t len, uint64_t flags)<br>
&gt; &gt;&gt; &gt; +{<br>
&gt; &gt;&gt; &gt; +=C2=A0 =C2=A0 bool result =3D false;<br>
&gt; &gt;&gt; &gt; +=C2=A0 =C2=A0 VhostUserMsg msg_reply;<br>
&gt; &gt;&gt; &gt; +=C2=A0 =C2=A0 VhostUserMsg vmsg =3D {<br>
&gt; &gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .request =3D VHOST_USER_BAC=
KEND_SHMEM_MAP,<br>
&gt; &gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .size =3D sizeof(vmsg.paylo=
ad.mmap),<br>
&gt; &gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .flags =3D VHOST_USER_VERSI=
ON,<br>
&gt; &gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .payload.mmap =3D {<br>
&gt; &gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .shmid =3D sh=
mid,<br>
&gt; &gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .fd_offset =
=3D fd_offset,<br>
&gt; &gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .shm_offset =
=3D shm_offset,<br>
&gt; &gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .len =3D len,=
<br>
&gt; &gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .flags =3D fl=
ags,<br>
&gt; &gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
&gt; &gt;&gt; &gt; +=C2=A0 =C2=A0 };<br>
&gt; &gt;&gt; &gt; +<br>
&gt; &gt;&gt; &gt; +=C2=A0 =C2=A0 if (vu_has_protocol_feature(dev, VHOST_US=
ER_PROTOCOL_F_REPLY_ACK))<br>
&gt; &gt;&gt; {<br>
&gt; &gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 vmsg.flags |=3D VHOST_USER_=
NEED_REPLY_MASK;<br>
&gt; &gt;&gt; &gt; +=C2=A0 =C2=A0 }<br>
&gt; &gt;&gt; &gt; +<br>
&gt; &gt;&gt; &gt; +=C2=A0 =C2=A0 pthread_mutex_lock(&amp;dev-&gt;backend_m=
utex);<br>
&gt; &gt;&gt; &gt; +=C2=A0 =C2=A0 if (!vu_message_write(dev, dev-&gt;backen=
d_fd, &amp;vmsg)) {<br>
&gt; &gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 pthread_mutex_unlock(&amp;d=
ev-&gt;backend_mutex);<br>
&gt; &gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
&gt; &gt;&gt; &gt; +=C2=A0 =C2=A0 }<br>
&gt; &gt;&gt; &gt; +<br>
&gt; &gt;&gt; &gt; +=C2=A0 =C2=A0 /* Also unlocks the backend_mutex */<br>
&gt; &gt;&gt; &gt; +=C2=A0 =C2=A0 return vu_process_message_reply(dev, &amp=
;vmsg);<br>
&gt; &gt;&gt; &gt; +}<br>
&gt; &gt;&gt; &gt; +<br>
&gt; &gt;&gt; &gt; +bool<br>
&gt; &gt;&gt; &gt; +vu_shmem_unmap(VuDev *dev, uint8_t shmid, uint64_t fd_o=
ffset,<br>
&gt; &gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
uint64_t shm_offset, uint64_t len)<br>
&gt; &gt;&gt; &gt; +{<br>
&gt; &gt;&gt; &gt; +=C2=A0 =C2=A0 bool result =3D false;<br>
&gt; &gt;&gt; &gt; +=C2=A0 =C2=A0 VhostUserMsg msg_reply;<br>
&gt; &gt;&gt; &gt; +=C2=A0 =C2=A0 VhostUserMsg vmsg =3D {<br>
&gt; &gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .request =3D VHOST_USER_BAC=
KEND_SHMEM_UNMAP,<br>
&gt; &gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .size =3D sizeof(vmsg.paylo=
ad.mmap),<br>
&gt; &gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .flags =3D VHOST_USER_VERSI=
ON,<br>
&gt; &gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .payload.mmap =3D {<br>
&gt; &gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .shmid =3D sh=
mid,<br>
&gt; &gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .fd_offset =
=3D fd_offset,<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; What is the meaning of this field? I expected it to be set to=
 0.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .shm_offset =
=3D shm_offset,<br>
&gt; &gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .len =3D len,=
<br>
&gt; &gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
&gt; &gt;&gt; &gt; +=C2=A0 =C2=A0 };<br>
&gt; &gt;&gt; &gt; +<br>
&gt; &gt;&gt; &gt; +=C2=A0 =C2=A0 if (vu_has_protocol_feature(dev, VHOST_US=
ER_PROTOCOL_F_REPLY_ACK))<br>
&gt; &gt;&gt; {<br>
&gt; &gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 vmsg.flags |=3D VHOST_USER_=
NEED_REPLY_MASK;<br>
&gt; &gt;&gt; &gt; +=C2=A0 =C2=A0 }<br>
&gt; &gt;&gt; &gt; +<br>
&gt; &gt;&gt; &gt; +=C2=A0 =C2=A0 pthread_mutex_lock(&amp;dev-&gt;backend_m=
utex);<br>
&gt; &gt;&gt; &gt; +=C2=A0 =C2=A0 if (!vu_message_write(dev, dev-&gt;backen=
d_fd, &amp;vmsg)) {<br>
&gt; &gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 pthread_mutex_unlock(&amp;d=
ev-&gt;backend_mutex);<br>
&gt; &gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
&gt; &gt;&gt; &gt; +=C2=A0 =C2=A0 }<br>
&gt; &gt;&gt; &gt; +<br>
&gt; &gt;&gt; &gt; +=C2=A0 =C2=A0 /* Also unlocks the backend_mutex */<br>
&gt; &gt;&gt; &gt; +=C2=A0 =C2=A0 return vu_process_message_reply(dev, &amp=
;vmsg);<br>
&gt; &gt;&gt; &gt; +}<br>
&gt; &gt;&gt; &gt; +<br>
&gt; &gt;&gt; &gt;=C2=A0 static bool<br>
&gt; &gt;&gt; &gt;=C2=A0 vu_set_vring_call_exec(VuDev *dev, VhostUserMsg *v=
msg)<br>
&gt; &gt;&gt; &gt;=C2=A0 {<br>
&gt; &gt;&gt; &gt; diff --git a/subprojects/libvhost-user/libvhost-user.h<b=
r>
&gt; &gt;&gt; b/subprojects/libvhost-user/libvhost-user.h<br>
&gt; &gt;&gt; &gt; index deb40e77b3..7f6c22cc1a 100644<br>
&gt; &gt;&gt; &gt; --- a/subprojects/libvhost-user/libvhost-user.h<br>
&gt; &gt;&gt; &gt; +++ b/subprojects/libvhost-user/libvhost-user.h<br>
&gt; &gt;&gt; &gt; @@ -127,6 +127,8 @@ typedef enum VhostUserBackendRequest=
 {<br>
&gt; &gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 VHOST_USER_BACKEND_SHARED_OBJECT_ADD=
 =3D 6,<br>
&gt; &gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 VHOST_USER_BACKEND_SHARED_OBJECT_REM=
OVE =3D 7,<br>
&gt; &gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 VHOST_USER_BACKEND_SHARED_OBJECT_LOO=
KUP =3D 8,<br>
&gt; &gt;&gt; &gt; +=C2=A0 =C2=A0 VHOST_USER_BACKEND_SHMEM_MAP =3D 9,<br>
&gt; &gt;&gt; &gt; +=C2=A0 =C2=A0 VHOST_USER_BACKEND_SHMEM_UNMAP =3D 10,<br=
>
&gt; &gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 VHOST_USER_BACKEND_MAX<br>
&gt; &gt;&gt; &gt;=C2=A0 }=C2=A0 VhostUserBackendRequest;<br>
&gt; &gt;&gt; &gt;<br>
&gt; &gt;&gt; &gt; @@ -186,6 +188,24 @@ typedef struct VhostUserShared {<br=
>
&gt; &gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 unsigned char uuid[UUID_LEN];<br>
&gt; &gt;&gt; &gt;=C2=A0 } VhostUserShared;<br>
&gt; &gt;&gt; &gt;<br>
&gt; &gt;&gt; &gt; +/* For the flags field of VhostUserMMap */<br>
&gt; &gt;&gt; &gt; +#define VHOST_USER_FLAG_MAP_R (1u &lt;&lt; 0)<br>
&gt; &gt;&gt; &gt; +#define VHOST_USER_FLAG_MAP_W (1u &lt;&lt; 1)<br>
&gt; &gt;&gt; &gt; +<br>
&gt; &gt;&gt; &gt; +typedef struct {<br>
&gt; &gt;&gt; &gt; +=C2=A0 =C2=A0 /* VIRTIO Shared Memory Region ID */<br>
&gt; &gt;&gt; &gt; +=C2=A0 =C2=A0 uint8_t shmid;<br>
&gt; &gt;&gt; &gt; +=C2=A0 =C2=A0 uint8_t padding[7];<br>
&gt; &gt;&gt; &gt; +=C2=A0 =C2=A0 /* File offset */<br>
&gt; &gt;&gt; &gt; +=C2=A0 =C2=A0 uint64_t fd_offset;<br>
&gt; &gt;&gt; &gt; +=C2=A0 =C2=A0 /* Offset within the VIRTIO Shared Memory=
 Region */<br>
&gt; &gt;&gt; &gt; +=C2=A0 =C2=A0 uint64_t shm_offset;<br>
&gt; &gt;&gt; &gt; +=C2=A0 =C2=A0 /* Size of the mapping */<br>
&gt; &gt;&gt; &gt; +=C2=A0 =C2=A0 uint64_t len;<br>
&gt; &gt;&gt; &gt; +=C2=A0 =C2=A0 /* Flags for the mmap operation, from VHO=
ST_USER_FLAG_* */<br>
&gt; &gt;&gt; &gt; +=C2=A0 =C2=A0 uint64_t flags;<br>
&gt; &gt;&gt; &gt; +} VhostUserMMap;<br>
&gt; &gt;&gt; &gt; +<br>
&gt; &gt;&gt; &gt;=C2=A0 #if defined(_WIN32) &amp;&amp; (defined(__x86_64__=
) || defined(__i386__))<br>
&gt; &gt;&gt; &gt;=C2=A0 # define VU_PACKED __attribute__((gcc_struct, pack=
ed))<br>
&gt; &gt;&gt; &gt;=C2=A0 #else<br>
&gt; &gt;&gt; &gt; @@ -214,6 +234,7 @@ typedef struct VhostUserMsg {<br>
&gt; &gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 VhostUserVringArea are=
a;<br>
&gt; &gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 VhostUserInflight infl=
ight;<br>
&gt; &gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 VhostUserShared object=
;<br>
&gt; &gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VhostUserMMap mmap;<br>
&gt; &gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 } payload;<br>
&gt; &gt;&gt; &gt;<br>
&gt; &gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 int fds[VHOST_MEMORY_BASELINE_NREGIO=
NS];<br>
&gt; &gt;&gt; &gt; @@ -597,6 +618,38 @@ bool vu_add_shared_object(VuDev *de=
v, unsigned<br>
&gt; &gt;&gt; char uuid[UUID_LEN]);<br>
&gt; &gt;&gt; &gt;=C2=A0 =C2=A0*/<br>
&gt; &gt;&gt; &gt;=C2=A0 bool vu_rm_shared_object(VuDev *dev, unsigned char=
 uuid[UUID_LEN]);<br>
&gt; &gt;&gt; &gt;<br>
&gt; &gt;&gt; &gt; +/**<br>
&gt; &gt;&gt; &gt; + * vu_shmem_map:<br>
&gt; &gt;&gt; &gt; + * @dev: a VuDev context<br>
&gt; &gt;&gt; &gt; + * @shmid: VIRTIO Shared Memory Region ID<br>
&gt; &gt;&gt; &gt; + * @fd_offset: File offset<br>
&gt; &gt;&gt; &gt; + * @shm_offset: Offset within the VIRTIO Shared Memory =
Region<br>
&gt; &gt;&gt; &gt; + * @len: Size of the mapping<br>
&gt; &gt;&gt; &gt; + * @flags: Flags for the mmap operation<br>
&gt; &gt;&gt; &gt; + *<br>
&gt; &gt;&gt; &gt; + * Advertises a new mapping to be made in a given VIRTI=
O Shared Memory<br>
&gt; &gt;&gt; Region.<br>
&gt; &gt;&gt; &gt; + *<br>
&gt; &gt;&gt; &gt; + * Returns: TRUE on success, FALSE on failure.<br>
&gt; &gt;&gt; &gt; + */<br>
&gt; &gt;&gt; &gt; +bool vu_shmem_map(VuDev *dev, uint8_t shmid, uint64_t f=
d_offset,<br>
&gt; &gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 uint64_t shm_offset, uint64_t len, uint64_t flags);<br>
&gt; &gt;&gt; &gt; +<br>
&gt; &gt;&gt; &gt; +/**<br>
&gt; &gt;&gt; &gt; + * vu_shmem_map:<br>
&gt; &gt;&gt; &gt; + * @dev: a VuDev context<br>
&gt; &gt;&gt; &gt; + * @shmid: VIRTIO Shared Memory Region ID<br>
&gt; &gt;&gt; &gt; + * @fd_offset: File offset<br>
&gt; &gt;&gt; &gt; + * @shm_offset: Offset within the VIRTIO Shared Memory =
Region<br>
&gt; &gt;&gt; &gt; + * @len: Size of the mapping<br>
&gt; &gt;&gt; &gt; + *<br>
&gt; &gt;&gt; &gt; + * The front-end un-mmaps a given range in the VIRTIO S=
hared Memory<br>
&gt; &gt;&gt; Region<br>
&gt; &gt;&gt; &gt; + * with the requested `shmid`.<br>
&gt; &gt;&gt; &gt; + *<br>
&gt; &gt;&gt; &gt; + * Returns: TRUE on success, FALSE on failure.<br>
&gt; &gt;&gt; &gt; + */<br>
&gt; &gt;&gt; &gt; +bool vu_shmem_unmap(VuDev *dev, uint8_t shmid, uint64_t=
 fd_offset,<br>
&gt; &gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 uint64_t shm_offset, uint64_t len);<br>
&gt; &gt;&gt; &gt; +<br>
&gt; &gt;&gt; &gt;=C2=A0 /**<br>
&gt; &gt;&gt; &gt;=C2=A0 =C2=A0* vu_queue_set_notification:<br>
&gt; &gt;&gt; &gt;=C2=A0 =C2=A0* @dev: a VuDev context<br>
&gt; &gt;&gt; &gt; --<br>
&gt; &gt;&gt; &gt; 2.45.2<br>
&gt; &gt;&gt; &gt;<br>
&gt; &gt;&gt;<br>
&gt; &gt;<br>
</blockquote></div></div>

--0000000000009a6b8b0621d6b12a--


