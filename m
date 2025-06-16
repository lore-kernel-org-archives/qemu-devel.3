Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D136C71155
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Jun 2025 15:34:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRBqJ-0003nn-0q; Mon, 16 Jun 2025 11:33:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1uRBq2-0003kY-6K
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 11:33:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1uRBpw-00007S-No
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 11:33:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750088005;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=THRR8qBJw5VixrhxJ5ZIyHzHDfcWQVIdJlY5d1pvG/M=;
 b=CpP/9zzrFXjNkfcF+Ms1MXva+RL2eAtkAQRv2F/usUOpE2cfyPCL/R1GT2XCohDoiOePrj
 kS+Pco4EtgvGAyWUMDnzC23NlZV7YUpLj82mnrKGzo68QNajn0kG3uSkw/1j7qWSwKXQa4
 bopJJIl9buZuQy9rrCQtvEaFxW8BM3o=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-T-7-ECdIOsmYn300tbr3Gg-1; Mon, 16 Jun 2025 11:33:23 -0400
X-MC-Unique: T-7-ECdIOsmYn300tbr3Gg-1
X-Mimecast-MFC-AGG-ID: T-7-ECdIOsmYn300tbr3Gg_1750088003
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-31315427249so4359158a91.1
 for <qemu-devel@nongnu.org>; Mon, 16 Jun 2025 08:33:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750088002; x=1750692802;
 h=content-transfer-encoding:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=THRR8qBJw5VixrhxJ5ZIyHzHDfcWQVIdJlY5d1pvG/M=;
 b=atvivQrrSGaJz8qHGeaQqrsQWwVNai7nBb1o7s8l9LyXmWM+Y9BuAMa/sAy6zz6A+h
 QMTBlakvWvEQB8hBqQbEPkDj057Sg7G/jbxECsgUjxc5vHNH+72coV/Vs45ThG8jD4bG
 YmVG7l+eIAQLhjvr9oZUzpHInCjoaTM0iEJW79a+7ymfpaZHKQE7NAH3OeAyF9KWBeo/
 kQMsZ3pmN1fHB3xSHnIkUXxj3ZMeXmnmtk5253ZXI8lX/HsmvHL2aVn0EagFZ/0o0UsZ
 TLX8g8mojGZUtrS2mo2i8DBDmQ8wYxjggRqzcNFFGWY8puKi4Bq+A5Gc4VAbRf/SGHuV
 EbhQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWgzYLV3UFZYqGnsc7wBAjt9CTu54lbQ2aO9a6mfv7ISEJsCZvXmTD3++fBqIqJiCWr0/p3Eu5MxHdc@nongnu.org
X-Gm-Message-State: AOJu0YyA1a44CiXwIWLK0fpOpevG1P2DtoYsFCb2JoBA+65qoQoJVUQG
 b5vneoHMzcpkFlV4Pff7MxSkvTAkWfR+x9ZiHR1mIwkrCghfImEweGL+nT2JMuXLecU5qqc63e/
 NX7kKNWY0iYRmp8nNDyYuDBWmvx1axaDac9ysJGu1q5m+S5SuZcPUDZbdFMZjFNzs4S+IpPAqvb
 xPxsu5OzFtaqbJRH9Q/2oclDg2Xm5vb5w=
X-Gm-Gg: ASbGncs/Q8UnyzKGgC4aWlaphzEGbfmVu7Fx4XvCX8v6Lj56EwmDxfvOq15JkgVnK2n
 dBAyY3NGyTndcPHS7GED6CjP1qc05o+SwxcePWZklKkCUHD+jICy6lvnnBmBujBUM+Bs3aM9+cl
 /RY2I=
X-Received: by 2002:a17:90b:4986:b0:311:b3e7:fb38 with SMTP id
 98e67ed59e1d1-313f1d5882amr14432923a91.19.1750088002156; 
 Mon, 16 Jun 2025 08:33:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFq0eyQXo842f0nEvUHp22DUSyTGSqbOJdhXsIyMIG7wV7ZuoAewYfgbEx4awry+VXgB95mTtSNs6Ejjv/OkAU=
X-Received: by 2002:a17:90b:4986:b0:311:b3e7:fb38 with SMTP id
 98e67ed59e1d1-313f1d5882amr14432882a91.19.1750088001510; Mon, 16 Jun 2025
 08:33:21 -0700 (PDT)
MIME-Version: 1.0
References: <20250609144729.884027-1-aesteve@redhat.com>
 <20250609144729.884027-2-aesteve@redhat.com>
 <20250612161856.GB224651@fedora>
 <CADSE00LrrTNYLKnGqUNSH_HqtPA4n0t6Qq1JA5b1=mUQ2XO0iA@mail.gmail.com>
In-Reply-To: <CADSE00LrrTNYLKnGqUNSH_HqtPA4n0t6Qq1JA5b1=mUQ2XO0iA@mail.gmail.com>
From: Albert Esteve <aesteve@redhat.com>
Date: Mon, 16 Jun 2025 17:33:09 +0200
X-Gm-Features: AX0GCFtm2nQeno1HpirOpW7rMmFX4YtZmd_9_pNee6R6qNwFhQSozE2KSS2tRpY
Message-ID: <CADSE00JnPNTzcpxG90Z7WaYLpU8S7Fj0pPnhzyPenzz2-xzYHA@mail.gmail.com>
Subject: Re: [PATCH v5 1/7] vhost-user: Add VirtIO Shared Memory map request
To: Stefan Hajnoczi <stefanha@redhat.com>, David Hildenbrand <david@redhat.com>,
 qemu-devel@nongnu.org, Sergio Lopez Pascual <slp@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Michael Tsirkin <mst@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>,
 Alyssa Ross <hi@alyssa.is>, 
 Jason Wang <jasowang@redhat.com>, David Stevens <stevensd@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=aesteve@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.892,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Sorry I did not reply-all.

Albert Esteve

Principal Software Engineer

Red Hat

aesteve@redhat.com



On Mon, Jun 16, 2025 at 5:28=E2=80=AFPM Albert Esteve <aesteve@redhat.com> =
wrote:
>
>
>
> On Thu, Jun 12, 2025 at 6:19=E2=80=AFPM Stefan Hajnoczi <stefanha@redhat.=
com> wrote:
> >
> > On Mon, Jun 09, 2025 at 04:47:23PM +0200, Albert Esteve wrote:
> > > Add SHMEM_MAP/UNMAP requests to vhost-user to
> > > handle VIRTIO Shared Memory mappings.
> > >
> > > This request allows backends to dynamically map
> > > fds into a VIRTIO Shared Memory Region indentified
> >
> > identified
> >
> > > by its `shmid`. The map is performed by calling
> > > `memory_region_init_ram_from_fd` and adding the
> > > new region as a subregion of the shmem container
> > > MR. Then, the fd memory is advertised to the
> > > driver as a base addres + offset, so it can be
> >
> > address
> >
> > > read/written (depending on the mmap flags
> > > requested) while it is valid.
> >
> > I'm not sure what the last sentence is referring to. Does "driver" mean
> > a QEMU device model or a VIRTIO driver? Neither of these make a lot of
> > sense to me.
> >
> If I remember correctly, I mean the VIRTIO driver. What I was trying to s=
ay, I think, is that in order to access the mmap'd memory from the driver, =
we need the full address+offset and not only the offset.
> > >
> > > The backend can unmap the memory range
> > > in a given VIRTIO Shared Memory Region (again,
> > > identified by its `shmid`), to free it.
> > > Upon receiving this message, the front-end
> > > must delete the MR as a subregion of
> > > the shmem container region and free its
> > > resources.
> > >
> > > Note that commit all these operations need
> > > to be delayed to after we respond the request
> > > to the backend to avoid deadlocks.
> >
> > Rephrased:
> > "Note the memory region commit for these operations needs to be delayed
> > until after we respond to the backend to avoid deadlocks."
> >
> > By the way, what is the reason for the deadlock?
>
> I may not explain it correctly, but I'll try. Maybe @David Hildenbrand ca=
n keep me honest on this one, or correct any misspeak.
>
> So the problem with committing the memory operation after the add_subregi=
on, is that it requires a VIRTIO message and an ACK. But if the VIRTIO devi=
ce that sends the message that requested the mmap is blocked waiting for an=
 ACK to the mmap from the VMM. As a result, it will not process the commit =
message, it will not send its ACK, and thus the deadlock. The commit will n=
ever finish, because the device is waiting for the mmap operation to finish=
, which is locked on the commit.
>
> >
> > >
> > > The device model needs to create VirtSharedMemory
> > > instances for the VirtIO Shared Memory Regions
> > > and add them to the `VirtIODevice` instance.
> > >
> > > Signed-off-by: Albert Esteve <aesteve@redhat.com>
> > > ---
> > >  hw/virtio/vhost-user.c                    | 150 ++++++++++++++++++++=
++
> > >  hw/virtio/virtio.c                        |  97 ++++++++++++++
> > >  include/hw/virtio/virtio.h                |  29 +++++
> > >  subprojects/libvhost-user/libvhost-user.c |  70 ++++++++++
> > >  subprojects/libvhost-user/libvhost-user.h |  54 ++++++++
> > >  5 files changed, 400 insertions(+)
> > >
> > > diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> > > index 1e1d6b0d6e..9c635fb928 100644
> > > --- a/hw/virtio/vhost-user.c
> > > +++ b/hw/virtio/vhost-user.c
> > > @@ -115,6 +115,8 @@ typedef enum VhostUserBackendRequest {
> > >      VHOST_USER_BACKEND_SHARED_OBJECT_ADD =3D 6,
> > >      VHOST_USER_BACKEND_SHARED_OBJECT_REMOVE =3D 7,
> > >      VHOST_USER_BACKEND_SHARED_OBJECT_LOOKUP =3D 8,
> > > +    VHOST_USER_BACKEND_SHMEM_MAP =3D 9,
> > > +    VHOST_USER_BACKEND_SHMEM_UNMAP =3D 10,
> > >      VHOST_USER_BACKEND_MAX
> > >  }  VhostUserBackendRequest;
> > >
> > > @@ -192,6 +194,23 @@ typedef struct VhostUserShared {
> > >      unsigned char uuid[16];
> > >  } VhostUserShared;
> > >
> > > +/* For the flags field of VhostUserMMap */
> > > +#define VHOST_USER_FLAG_MAP_RW (1u << 0)
> > > +
> > > +typedef struct {
> > > +    /* VIRTIO Shared Memory Region ID */
> > > +    uint8_t shmid;
> > > +    uint8_t padding[7];
> > > +    /* File offset */
> > > +    uint64_t fd_offset;
> > > +    /* Offset within the VIRTIO Shared Memory Region */
> > > +    uint64_t shm_offset;
> > > +    /* Size of the mapping */
> > > +    uint64_t len;
> > > +    /* Flags for the mmap operation, from VHOST_USER_FLAG_MAP_* */
> > > +    uint16_t flags;
> > > +} VhostUserMMap;
> > > +
> > >  typedef struct {
> > >      VhostUserRequest request;
> > >
> > > @@ -224,6 +243,7 @@ typedef union {
> > >          VhostUserInflight inflight;
> > >          VhostUserShared object;
> > >          VhostUserTransferDeviceState transfer_state;
> > > +        VhostUserMMap mmap;
> > >  } VhostUserPayload;
> > >
> > >  typedef struct VhostUserMsg {
> > > @@ -1768,6 +1788,129 @@ vhost_user_backend_handle_shared_object_looku=
p(struct vhost_user *u,
> > >      return 0;
> > >  }
> > >
> > > +static int
> > > +vhost_user_backend_handle_shmem_map(struct vhost_dev *dev,
> > > +                                    QIOChannel *ioc,
> > > +                                    VhostUserHeader *hdr,
> > > +                                    VhostUserPayload *payload,
> > > +                                    int fd)
> > > +{
> > > +    uint32_t ram_flags;
> > > +    VirtSharedMemory *shmem;
> > > +    VhostUserMMap *vu_mmap =3D &payload->mmap;
> > > +    Error *local_err =3D NULL;
> > > +    g_autoptr(GString) shm_name =3D g_string_new(NULL);
> > > +
> > > +    if (fd < 0) {
> > > +        error_report("Bad fd for map");
> > > +        return -EBADF;
> > > +    }
> > > +
> > > +    if (QSIMPLEQ_EMPTY(&dev->vdev->shmem_list)) {
> > > +        error_report("Device has no VIRTIO Shared Memory Regions. "
> > > +                     "Requested ID: %d", vu_mmap->shmid);
> > > +        return -EFAULT;
> > > +    }
> > > +
> > > +    shmem =3D virtio_find_shmem_region(dev->vdev, vu_mmap->shmid);
> > > +    if (!shmem) {
> > > +        error_report("VIRTIO Shared Memory Region at "
> > > +                     "ID %d not found or unitialized", vu_mmap->shmi=
d);
> > > +        return -EFAULT;
> > > +    }
> > > +
> > > +    if ((vu_mmap->shm_offset + vu_mmap->len) < vu_mmap->len ||
> > > +        (vu_mmap->shm_offset + vu_mmap->len) > shmem->mr->size) {
> > > +        error_report("Bad offset/len for mmap %" PRIx64 "+%" PRIx64,
> > > +                     vu_mmap->shm_offset, vu_mmap->len);
> > > +        return -EFAULT;
> > > +    }
> > > +
> > > +    g_string_printf(shm_name, "virtio-shm%i-%lu",
> > > +                    vu_mmap->shmid, vu_mmap->shm_offset);
> > > +
> > > +    memory_region_transaction_begin();
> > > +    ram_flags =3D RAM_SHARED |
> > > +                ((vu_mmap->flags & VHOST_USER_FLAG_MAP_RW) ? 0 : RAM=
_READONLY);
> > > +    if (virtio_add_shmem_map(shmem, shm_name->str, vu_mmap->shm_offs=
et,
> > > +                             vu_mmap->fd_offset, vu_mmap->len, ram_f=
lags,
> > > +                             fd) !=3D 0) {
> > > +        memory_region_transaction_commit();
> > > +        return -EFAULT;
> > > +    }
> > > +
> > > +    if (hdr->flags & VHOST_USER_NEED_REPLY_MASK) {
> > > +        payload->u64 =3D 0;
> > > +        hdr->size =3D sizeof(payload->u64);
> > > +        vhost_user_send_resp(ioc, hdr, payload, &local_err);
> > > +        if (local_err) {
> > > +            error_report_err(local_err);
> > > +            memory_region_transaction_commit();
> > > +            return -EFAULT;
> > > +        }
> > > +    }
> > > +
> > > +    memory_region_transaction_commit();
> > > +
> > > +    return 0;
> > > +}
> > > +
> > > +static int
> > > +vhost_user_backend_handle_shmem_unmap(struct vhost_dev *dev,
> > > +                                      QIOChannel *ioc,
> > > +                                      VhostUserHeader *hdr,
> > > +                                      VhostUserPayload *payload)
> > > +{
> > > +    VirtSharedMemory *shmem;
> > > +    MappedMemoryRegion *mmap =3D NULL;
> > > +    VhostUserMMap *vu_mmap =3D &payload->mmap;
> > > +    Error *local_err =3D NULL;
> > > +
> > > +    if (QSIMPLEQ_EMPTY(&dev->vdev->shmem_list)) {
> > > +        error_report("Device has no VIRTIO Shared Memory Regions. "
> > > +                     "Requested ID: %d", vu_mmap->shmid);
> > > +        return -EFAULT;
> > > +    }
> > > +
> > > +    shmem =3D virtio_find_shmem_region(dev->vdev, vu_mmap->shmid);
> > > +    if (!shmem) {
> > > +        error_report("VIRTIO Shared Memory Region at "
> > > +                     "ID %d not found or unitialized", vu_mmap->shmi=
d);
> > > +        return -EFAULT;
> > > +    }
> > > +
> > > +    if ((vu_mmap->shm_offset + vu_mmap->len) < vu_mmap->len ||
> > > +        (vu_mmap->shm_offset + vu_mmap->len) > shmem->mr->size) {
> > > +        error_report("Bad offset/len for unmmap %" PRIx64 "+%" PRIx6=
4,
> > > +                     vu_mmap->shm_offset, vu_mmap->len);
> > > +        return -EFAULT;
> > > +    }
> > > +
> > > +    mmap =3D virtio_find_shmem_map(shmem, vu_mmap->shm_offset, vu_mm=
ap->len);
> > > +    if (!mmap) {
> > > +        return -EFAULT;
> > > +    }
> > > +
> > > +    memory_region_transaction_begin();
> > > +    memory_region_del_subregion(shmem->mr, mmap->mem);
> > > +    if (hdr->flags & VHOST_USER_NEED_REPLY_MASK) {
> > > +        payload->u64 =3D 0;
> > > +        hdr->size =3D sizeof(payload->u64);
> > > +        vhost_user_send_resp(ioc, hdr, payload, &local_err);
> > > +        if (local_err) {
> > > +            error_report_err(local_err);
> > > +            memory_region_transaction_commit();
> > > +            return -EFAULT;
> > > +        }
> > > +    }
> > > +    memory_region_transaction_commit();
> > > +
> > > +    /* Free the MemoryRegion only after vhost_commit */
> > > +    virtio_del_shmem_map(shmem, vu_mmap->shm_offset, vu_mmap->len);
> > > +
> > > +    return 0;
> > > +}
> > > +
> > >  static void close_backend_channel(struct vhost_user *u)
> > >  {
> > >      g_source_destroy(u->backend_src);
> > > @@ -1836,6 +1979,13 @@ static gboolean backend_read(QIOChannel *ioc, =
GIOCondition condition,
> > >          ret =3D vhost_user_backend_handle_shared_object_lookup(dev->=
opaque, ioc,
> > >                                                               &hdr, &=
payload);
> > >          break;
> > > +    case VHOST_USER_BACKEND_SHMEM_MAP:
> > > +        ret =3D vhost_user_backend_handle_shmem_map(dev, ioc, &hdr, =
&payload,
> > > +                                                  fd ? fd[0] : -1);
> > > +        break;
> > > +    case VHOST_USER_BACKEND_SHMEM_UNMAP:
> > > +        ret =3D vhost_user_backend_handle_shmem_unmap(dev, ioc, &hdr=
, &payload);
> > > +        break;
> > >      default:
> > >          error_report("Received unexpected msg type: %d.", hdr.reques=
t);
> > >          ret =3D -EINVAL;
> > > diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> > > index 5534251e01..208ad11685 100644
> > > --- a/hw/virtio/virtio.c
> > > +++ b/hw/virtio/virtio.c
> > > @@ -3035,6 +3035,92 @@ int virtio_save(VirtIODevice *vdev, QEMUFile *=
f)
> > >      return vmstate_save_state(f, &vmstate_virtio, vdev, NULL);
> > >  }
> > >
> > > +VirtSharedMemory *virtio_new_shmem_region(VirtIODevice *vdev, uint8_=
t shmid)
> >
> > The caller is not responsible for freeing the returned VirtSharedMemory=
.
> > Please add doc comments for the new APIs explaining these things.
>
> Sure, I'll do in the next version.
>
> >
> > > +{
> > > +    VirtSharedMemory *elem;
> > > +    elem =3D g_new0(VirtSharedMemory, 1);
> > > +    elem->shmid =3D shmid;
> > > +    elem->mr =3D g_new0(MemoryRegion, 1);
> >
> > Maybe this will become clear in later commits, but at this point I'm
> > confused about elem->mr's lifecycle:
> > - memory_region_init() is not called?
> You are right? I did not see it. Then, I thought that as it is a containe=
r region it may not need to be initialised. But I checked the memory API do=
cument and indeed it does.
>
> I tested this patch and worked. Not sure why. I will initialise it for th=
e next version.
>
> > - Where is this freed?
> WIthin `virtio_device_instance_finalize`.
>
> > - Does it really need to be allocated on the heap instead of being
> >   embedded as a field within VirtSharedMemory?
> Not sure? It is already a field within `VirtSharedMemory`. How would you =
prefer it to be allocated?
>
> >
> > > +    QTAILQ_INIT(&elem->mmaps);
> > > +    QSIMPLEQ_INSERT_TAIL(&vdev->shmem_list, elem, entry);
> > > +    return QSIMPLEQ_LAST(&vdev->shmem_list, VirtSharedMemory, entry)=
;
> >
> > More concise:
> >
> >   return elem;
> >
> > > +}
> > > +
> > > +VirtSharedMemory *virtio_find_shmem_region(VirtIODevice *vdev, uint8=
_t shmid)
> > > +{
> > > +    VirtSharedMemory *shmem, *next;
> > > +    QSIMPLEQ_FOREACH_SAFE(shmem, &vdev->shmem_list, entry, next) {
> > > +        if (shmem->shmid =3D=3D shmid) {
> > > +            return shmem;
> > > +        }
> > > +    }
> > > +    return NULL;
> > > +}
> > > +
> > > +int virtio_add_shmem_map(VirtSharedMemory *shmem, const char *shm_na=
me,
> > > +                          hwaddr shm_offset, hwaddr fd_offset, uint6=
4_t size,
> > > +                          uint32_t ram_flags, int fd)
> > > +{
> > > +    Error *err =3D NULL;
> > > +    MappedMemoryRegion *mmap;
> > > +    fd =3D dup(fd);
> > > +    if (fd < 0) {
> > > +        error_report("Failed to duplicate fd: %s", strerror(errno));
> > > +        return -1;
> > > +    }
> > > +
> > > +    if (shm_offset + size > shmem->mr->size) {
> > > +        error_report("Memory exceeds the shared memory boundaries");
> > > +        close(fd);
> > > +        return -1;
> > > +    }
> > > +
> > > +    mmap =3D g_new0(MappedMemoryRegion, 1);
> > > +    mmap->mem =3D g_new0(MemoryRegion, 1);
> > > +    mmap->offset =3D shm_offset;
> > > +    memory_region_init_ram_from_fd(mmap->mem,
> > > +                                   OBJECT(shmem->mr),
> > > +                                   shm_name, size, ram_flags,
> > > +                                   fd, fd_offset, &err);
> > > +    if (err) {
> > > +        error_report_err(err);
> >
> > There is an opportunity here to propagate errors to the caller by
> > adjusting the function prototype:
> >
> >   bool virtio_add_shmem_map(..., Error **errp)
> >
> > I don't know if the caller is going to do anything with the error
> > though, so I guess we can leave things as they are for now.
>
> I had some back and forth myself on what can or cannot be propagated. I c=
hanged that prototype a couple times. I will give it another iteration and =
see if it is worth changing again.
>
> >
> > > +        close(fd);
> > > +        g_free(mmap->mem);
> > > +        g_free(mmap);
> > > +        return -1;
> > > +    }
> > > +    memory_region_add_subregion(shmem->mr, shm_offset, mmap->mem);
> > > +
> > > +    QTAILQ_INSERT_TAIL(&shmem->mmaps, mmap, link);
> > > +
> > > +    return 0;
> > > +}
> > > +
> > > +MappedMemoryRegion *virtio_find_shmem_map(VirtSharedMemory *shmem,
> > > +                                          hwaddr offset, uint64_t si=
ze)
> > > +{
> > > +    MappedMemoryRegion *mmap;
> > > +    QTAILQ_FOREACH(mmap, &shmem->mmaps, link) {
> > > +        if (mmap->offset =3D=3D offset && mmap->mem->size =3D=3D siz=
e) {
> > > +            return mmap;
> > > +        }
> > > +    }
> > > +    return NULL;
> > > +}
> > > +
> > > +void virtio_del_shmem_map(VirtSharedMemory *shmem, hwaddr offset,
> > > +                          uint64_t size)
> > > +{
> > > +    MappedMemoryRegion *mmap =3D virtio_find_shmem_map(shmem, offset=
, size);
> > > +    if (mmap =3D=3D NULL) {
> > > +        return;
> > > +    }
> > > +
> > > +    object_unparent(OBJECT(mmap->mem));
> >
> > I'm not 100% confident about the lifecycle of the MemoryRegions in this
> > patch. There is a section in docs/devel/memory.rst with warnings about
> > dynamically destroying MemoryRegions at runtime.
>
> Yes, I remember reading that part. I think I was focused on making it wor=
k, and probably disregarded the warning assuming the MR is not reference an=
ywhere.
>
> >
> > I think a reference count is leaked because
> > memory_region_add_subregion() increments the refcount rather than takin=
g
> > over the caller's refcount.
>
> I did not know that.
>
> >
> > Using memory_region_del_subregion() + memory_region_unref() would be
> > clearer, but may violate the rule in the memory.rst documentation,
> > depending on when this function is called.
>
> To be honest I am not sure what's the best option moving forward. The fea=
ture definitively needs dynamically allocated data structures. Maybe using =
subregions was not he right strategy after all?
>
> Can we have some compromise solution here?
>
> >
> > > +    QTAILQ_REMOVE(&shmem->mmaps, mmap, link);
> > > +    g_free(mmap);
> > > +}
> > > +
> > >  /* A wrapper for use as a VMState .put function */
> > >  static int virtio_device_put(QEMUFile *f, void *opaque, size_t size,
> > >                                const VMStateField *field, JSONWriter =
*vmdesc)
> > > @@ -3511,6 +3597,7 @@ void virtio_init(VirtIODevice *vdev, uint16_t d=
evice_id, size_t config_size)
> > >              NULL, virtio_vmstate_change, vdev);
> > >      vdev->device_endian =3D virtio_default_endian();
> > >      vdev->use_guest_notifier_mask =3D true;
> > > +    QSIMPLEQ_INIT(&vdev->shmem_list);
> > >  }
> > >
> > >  /*
> > > @@ -4022,11 +4109,21 @@ static void virtio_device_free_virtqueues(Vir=
tIODevice *vdev)
> > >  static void virtio_device_instance_finalize(Object *obj)
> > >  {
> > >      VirtIODevice *vdev =3D VIRTIO_DEVICE(obj);
> > > +    VirtSharedMemory *shmem;
> > >
> > >      virtio_device_free_virtqueues(vdev);
> > >
> > >      g_free(vdev->config);
> > >      g_free(vdev->vector_queues);
> > > +    while (!QSIMPLEQ_EMPTY(&vdev->shmem_list)) {
> > > +        shmem =3D QSIMPLEQ_FIRST(&vdev->shmem_list);
> > > +        while (!QTAILQ_EMPTY(&shmem->mmaps)) {
> > > +            MappedMemoryRegion *mmap_reg =3D QTAILQ_FIRST(&shmem->mm=
aps);
> > > +            virtio_del_shmem_map(shmem, mmap_reg->offset, mmap_reg->=
mem->size);
> > > +        }
> > > +        QSIMPLEQ_REMOVE_HEAD(&vdev->shmem_list, entry);
> > > +        g_free(shmem);
> > > +    }
> > >  }
> > >
> > >  static const Property virtio_properties[] =3D {
> > > diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
> > > index 214d4a77e9..331dbcfbe0 100644
> > > --- a/include/hw/virtio/virtio.h
> > > +++ b/include/hw/virtio/virtio.h
> > > @@ -98,6 +98,23 @@ enum virtio_device_endian {
> > >      VIRTIO_DEVICE_ENDIAN_BIG,
> > >  };
> > >
> > > +struct MappedMemoryRegion {
> > > +    MemoryRegion *mem;
> > > +    hwaddr offset;
> > > +    QTAILQ_ENTRY(MappedMemoryRegion) link;
> > > +};
> > > +
> > > +typedef struct MappedMemoryRegion MappedMemoryRegion;
> > > +
> > > +struct VirtSharedMemory {
> > > +    uint8_t shmid;
> > > +    MemoryRegion *mr;
> > > +    QTAILQ_HEAD(, MappedMemoryRegion) mmaps;
> > > +    QSIMPLEQ_ENTRY(VirtSharedMemory) entry;
> > > +};
> > > +
> > > +typedef struct VirtSharedMemory VirtSharedMemory;
> >
> > It would be nice to prefix the type names for namespacing reasons:
> > VirtSharedMemory -> VirtioSharedMemory
> > MappedMemoryRegion -> VirtioSharedMemoryMapping
> >
> > > +
> > >  /**
> > >   * struct VirtIODevice - common VirtIO structure
> > >   * @name: name of the device
> > > @@ -167,6 +184,8 @@ struct VirtIODevice
> > >       */
> > >      EventNotifier config_notifier;
> > >      bool device_iotlb_enabled;
> > > +    /* Shared memory region for mappings. */
> > > +    QSIMPLEQ_HEAD(, VirtSharedMemory) shmem_list;
> > >  };
> > >
> > >  struct VirtioDeviceClass {
> > > @@ -289,6 +308,16 @@ void virtio_notify(VirtIODevice *vdev, VirtQueue=
 *vq);
> > >
> > >  int virtio_save(VirtIODevice *vdev, QEMUFile *f);
> > >
> > > +VirtSharedMemory *virtio_new_shmem_region(VirtIODevice *vdev, uint8_=
t shmid);
> > > +VirtSharedMemory *virtio_find_shmem_region(VirtIODevice *vdev, uint8=
_t shmid);
> > > +int virtio_add_shmem_map(VirtSharedMemory *shmem, const char *shm_na=
me,
> > > +                          hwaddr shm_offset, hwaddr fd_offset, uint6=
4_t size,
> > > +                          uint32_t ram_flags, int fd);
> > > +MappedMemoryRegion *virtio_find_shmem_map(VirtSharedMemory *shmem,
> > > +                                          hwaddr offset, uint64_t si=
ze);
> > > +void virtio_del_shmem_map(VirtSharedMemory *shmem, hwaddr offset,
> > > +                          uint64_t size);
> > > +
> > >  extern const VMStateInfo virtio_vmstate_info;
> > >
> > >  #define VMSTATE_VIRTIO_DEVICE \
> > > diff --git a/subprojects/libvhost-user/libvhost-user.c b/subprojects/=
libvhost-user/libvhost-user.c
> > > index 9c630c2170..034cbfdc3c 100644
> > > --- a/subprojects/libvhost-user/libvhost-user.c
> > > +++ b/subprojects/libvhost-user/libvhost-user.c
> > > @@ -1592,6 +1592,76 @@ vu_rm_shared_object(VuDev *dev, unsigned char =
uuid[UUID_LEN])
> > >      return vu_send_message(dev, &msg);
> > >  }
> > >
> > > +bool
> > > +vu_shmem_map(VuDev *dev, uint8_t shmid, uint64_t fd_offset,
> > > +             uint64_t shm_offset, uint64_t len, uint64_t flags, int =
fd)
> > > +{
> > > +    VhostUserMsg vmsg =3D {
> > > +        .request =3D VHOST_USER_BACKEND_SHMEM_MAP,
> > > +        .size =3D sizeof(vmsg.payload.mmap),
> > > +        .flags =3D VHOST_USER_VERSION,
> > > +        .payload.mmap =3D {
> > > +            .shmid =3D shmid,
> > > +            .fd_offset =3D fd_offset,
> > > +            .shm_offset =3D shm_offset,
> > > +            .len =3D len,
> > > +            .flags =3D flags,
> > > +        },
> > > +        .fd_num =3D 1,
> > > +        .fds[0] =3D fd,
> > > +    };
> > > +
> > > +    if (!vu_has_protocol_feature(dev, VHOST_USER_PROTOCOL_F_SHMEM)) =
{
> > > +        return false;
> > > +    }
> > > +
> > > +    if (vu_has_protocol_feature(dev, VHOST_USER_PROTOCOL_F_REPLY_ACK=
)) {
> > > +        vmsg.flags |=3D VHOST_USER_NEED_REPLY_MASK;
> > > +    }
> > > +
> > > +    pthread_mutex_lock(&dev->backend_mutex);
> > > +    if (!vu_message_write(dev, dev->backend_fd, &vmsg)) {
> > > +        pthread_mutex_unlock(&dev->backend_mutex);
> > > +        return false;
> > > +    }
> > > +
> > > +    /* Also unlocks the backend_mutex */
> > > +    return vu_process_message_reply(dev, &vmsg);
> > > +}
> > > +
> > > +bool
> > > +vu_shmem_unmap(VuDev *dev, uint8_t shmid, uint64_t shm_offset, uint6=
4_t len)
> > > +{
> > > +    VhostUserMsg vmsg =3D {
> > > +        .request =3D VHOST_USER_BACKEND_SHMEM_UNMAP,
> > > +        .size =3D sizeof(vmsg.payload.mmap),
> > > +        .flags =3D VHOST_USER_VERSION,
> > > +        .payload.mmap =3D {
> > > +            .shmid =3D shmid,
> > > +            .fd_offset =3D 0,
> > > +            .shm_offset =3D shm_offset,
> > > +            .len =3D len,
> > > +        },
> > > +    };
> > > +
> > > +    if (!vu_has_protocol_feature(dev, VHOST_USER_PROTOCOL_F_SHMEM)) =
{
> > > +        return false;
> > > +    }
> > > +
> > > +    if (vu_has_protocol_feature(dev, VHOST_USER_PROTOCOL_F_REPLY_ACK=
)) {
> > > +        vmsg.flags |=3D VHOST_USER_NEED_REPLY_MASK;
> > > +    }
> > > +
> > > +    pthread_mutex_lock(&dev->backend_mutex);
> > > +    if (!vu_message_write(dev, dev->backend_fd, &vmsg)) {
> > > +        pthread_mutex_unlock(&dev->backend_mutex);
> > > +        return false;
> > > +    }
> > > +
> > > +    /* Also unlocks the backend_mutex */
> > > +    return vu_process_message_reply(dev, &vmsg);
> > > +}
> > > +
> > >  static bool
> > >  vu_set_vring_call_exec(VuDev *dev, VhostUserMsg *vmsg)
> > >  {
> > > diff --git a/subprojects/libvhost-user/libvhost-user.h b/subprojects/=
libvhost-user/libvhost-user.h
> > > index 2ffc58c11b..26b710c92d 100644
> > > --- a/subprojects/libvhost-user/libvhost-user.h
> > > +++ b/subprojects/libvhost-user/libvhost-user.h
> > > @@ -69,6 +69,8 @@ enum VhostUserProtocolFeature {
> > >      /* Feature 16 is reserved for VHOST_USER_PROTOCOL_F_STATUS. */
> > >      /* Feature 17 reserved for VHOST_USER_PROTOCOL_F_XEN_MMAP. */
> > >      VHOST_USER_PROTOCOL_F_SHARED_OBJECT =3D 18,
> > > +    /* Feature 19 is reserved for VHOST_USER_PROTOCOL_F_DEVICE_STATE=
 */
> > > +    VHOST_USER_PROTOCOL_F_SHMEM =3D 20,
> > >      VHOST_USER_PROTOCOL_F_MAX
> > >  };
> > >
> > > @@ -127,6 +129,8 @@ typedef enum VhostUserBackendRequest {
> > >      VHOST_USER_BACKEND_SHARED_OBJECT_ADD =3D 6,
> > >      VHOST_USER_BACKEND_SHARED_OBJECT_REMOVE =3D 7,
> > >      VHOST_USER_BACKEND_SHARED_OBJECT_LOOKUP =3D 8,
> > > +    VHOST_USER_BACKEND_SHMEM_MAP =3D 9,
> > > +    VHOST_USER_BACKEND_SHMEM_UNMAP =3D 10,
> > >      VHOST_USER_BACKEND_MAX
> > >  }  VhostUserBackendRequest;
> > >
> > > @@ -186,6 +190,23 @@ typedef struct VhostUserShared {
> > >      unsigned char uuid[UUID_LEN];
> > >  } VhostUserShared;
> > >
> > > +/* For the flags field of VhostUserMMap */
> > > +#define VHOST_USER_FLAG_MAP_RW (1u << 0)
> > > +
> > > +typedef struct {
> > > +    /* VIRTIO Shared Memory Region ID */
> > > +    uint8_t shmid;
> > > +    uint8_t padding[7];
> > > +    /* File offset */
> > > +    uint64_t fd_offset;
> > > +    /* Offset within the VIRTIO Shared Memory Region */
> > > +    uint64_t shm_offset;
> > > +    /* Size of the mapping */
> > > +    uint64_t len;
> > > +    /* Flags for the mmap operation, from VHOST_USER_FLAG_MAP_* */
> > > +    uint16_t flags;
> > > +} VhostUserMMap;
> > > +
> > >  #define VU_PACKED __attribute__((packed))
> > >
> > >  typedef struct VhostUserMsg {
> > > @@ -210,6 +231,7 @@ typedef struct VhostUserMsg {
> > >          VhostUserVringArea area;
> > >          VhostUserInflight inflight;
> > >          VhostUserShared object;
> > > +        VhostUserMMap mmap;
> > >      } payload;
> > >
> > >      int fds[VHOST_MEMORY_BASELINE_NREGIONS];
> > > @@ -593,6 +615,38 @@ bool vu_add_shared_object(VuDev *dev, unsigned c=
har uuid[UUID_LEN]);
> > >   */
> > >  bool vu_rm_shared_object(VuDev *dev, unsigned char uuid[UUID_LEN]);
> > >
> > > +/**
> > > + * vu_shmem_map:
> > > + * @dev: a VuDev context
> > > + * @shmid: VIRTIO Shared Memory Region ID
> > > + * @fd_offset: File offset
> > > + * @shm_offset: Offset within the VIRTIO Shared Memory Region
> > > + * @len: Size of the mapping
> > > + * @flags: Flags for the mmap operation
> > > + * @fd: A file descriptor
> > > + *
> > > + * Advertises a new mapping to be made in a given VIRTIO Shared Memo=
ry Region.
> > > + *
> > > + * Returns: TRUE on success, FALSE on failure.
> > > + */
> > > +bool vu_shmem_map(VuDev *dev, uint8_t shmid, uint64_t fd_offset,
> > > +                  uint64_t shm_offset, uint64_t len, uint64_t flags,=
 int fd);
> > > +
> > > +/**
> > > + * vu_shmem_unmap:
> > > + * @dev: a VuDev context
> > > + * @shmid: VIRTIO Shared Memory Region ID
> > > + * @fd_offset: File offset
> > > + * @len: Size of the mapping
> > > + *
> > > + * The front-end un-mmaps a given range in the VIRTIO Shared Memory =
Region
> > > + * with the requested `shmid`.
> > > + *
> > > + * Returns: TRUE on success, FALSE on failure.
> > > + */
> > > +bool vu_shmem_unmap(VuDev *dev, uint8_t shmid, uint64_t shm_offset,
> > > +                    uint64_t len);
> > > +
> > >  /**
> > >   * vu_queue_set_notification:
> > >   * @dev: a VuDev context
> > > --
> > > 2.49.0
> > >


