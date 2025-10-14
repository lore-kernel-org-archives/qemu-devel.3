Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23121CCD192
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 13:53:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8fSO-0004el-KA; Tue, 14 Oct 2025 09:52:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1v8fSL-0004eX-DY
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 09:52:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1v8fSC-0003RE-UG
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 09:52:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760449954;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lD2es8MZUgi+VM7rCreJP9dEy4HJN0CAA5TotZCP0xE=;
 b=JMluiuFM0aKjXJqwua0DUOWwRyj1DomfMaBc1LWWmp/f0CZ8xAB/ApIt7unUBxAbEnEhF4
 PiDwVRbl9jHdvRRM6Zu3YxWVweSaFaeQLapquITsdoNMu3avP8R43ifT87vhDGQWQ3z1P2
 xZPypd+WpvrhF3vCd4HTSFzxvzUSo/4=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-262-NqVU3orYMsKNVej-IX-niQ-1; Tue, 14 Oct 2025 09:52:33 -0400
X-MC-Unique: NqVU3orYMsKNVej-IX-niQ-1
X-Mimecast-MFC-AGG-ID: NqVU3orYMsKNVej-IX-niQ_1760449952
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-286a252bfc2so88860475ad.1
 for <qemu-devel@nongnu.org>; Tue, 14 Oct 2025 06:52:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760449952; x=1761054752;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lD2es8MZUgi+VM7rCreJP9dEy4HJN0CAA5TotZCP0xE=;
 b=VI48PBONMaW/Fy0NbsyJ7r0GlstRUxtvic1Qhs8PatWVlXnwB/EeevOpAVuQARYPnD
 wlPz43CQ/l0pv9BLiahlTr48VHubB8D3C4FMVpcO6pB5+BsTDeq3HPaEieXlrYpV5QDl
 +Q6IcSWF62stpiLYzLiv2k0E/KvF/WnJrRgI57nSqOkHs8P8N6ErwmqeTox9oF84oPZA
 y3plAPMSCJGbkrL9bb/fJ138yVKYzKaYxRiwshNollsUvTmMdZkaqDQyajW/0ms8WBey
 L8KYDen2IY8pvLb65WByX+bfE6ings5xgiBPY2S+MwGy0//RDBElNxFP57OB33DQAcWl
 yPfg==
X-Gm-Message-State: AOJu0YxQGUbgK5MxXc/pcXC1xapFCx41gxt09qJmLuv5xex2BMuNqgE5
 tB2fRGvUNgrsOEZTXVaPWxBTYR9eFOXkfHEx+FPnvqvKBuXxrourfGdclrM43YyAoK+OPZiQuwB
 WDjGUKiSiw1X+y2b0sk+Ny4yQUr3hXXhA9M8QEbGt9mJiZZhpTm2HchWI+82VsUR3K4mCQrd7jT
 ObnarPDXfluvFdd0FDhuK+/wNGHzKHK5c=
X-Gm-Gg: ASbGncv3iY/yTz8NuvEYDTOhD89akBajzMC9YB3tb6OUjVZiRyoIHCEYc95oOzGMiOH
 t1nvYf++1l87H/QudWM+xtiuNYI09LKMc06W6ZxdB5OWFkgzSoZQBbQ8btH8QPog2dAatldCrUZ
 q9EXdDgZcGa+ER8OCL
X-Received: by 2002:a17:903:247:b0:27c:3690:2c5d with SMTP id
 d9443c01a7336-28ec9b31e5fmr366873855ad.0.1760449951270; 
 Tue, 14 Oct 2025 06:52:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF6XDc8nGgu2ZNVo9neJpLqKgpuHz79zxwDA2gs6Pc+CnG7vvWieWHTilZtF138u8G8up5djB5zJeSw3gRPp8o=
X-Received: by 2002:a17:903:247:b0:27c:3690:2c5d with SMTP id
 d9443c01a7336-28ec9b31e5fmr366873205ad.0.1760449950539; Tue, 14 Oct 2025
 06:52:30 -0700 (PDT)
MIME-Version: 1.0
References: <20250910115420.1012191-1-aesteve@redhat.com>
 <20250910115420.1012191-2-aesteve@redhat.com>
 <20250929183951.GD81824@fedora>
In-Reply-To: <20250929183951.GD81824@fedora>
From: Albert Esteve <aesteve@redhat.com>
Date: Tue, 14 Oct 2025 15:52:17 +0200
X-Gm-Features: AS18NWC0A8ImeucLcOQTYCnPhgCIqXPMEpy2MMn4T7TuWZhdrGjq3MOMcZek-0Q
Message-ID: <CADSE00KrKkMr0q7FKT5=FFFjiZ4=A1=pO=QKyni1eZKeZ4PGZw@mail.gmail.com>
Subject: Re: [PATCH v8 1/7] vhost-user: Add VirtIO Shared Memory map request
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, stevensd@chromium.org, dbassey@redhat.com, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 mst@redhat.com, slp@redhat.com, 
 hi@alyssa.is, Fabiano Rosas <farosas@suse.de>,
 Stefano Garzarella <sgarzare@redhat.com>, jasowang@redhat.com, 
 david@redhat.com, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=aesteve@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Sep 29, 2025 at 8:39=E2=80=AFPM Stefan Hajnoczi <stefanha@redhat.co=
m> wrote:
>
> On Wed, Sep 10, 2025 at 01:54:14PM +0200, Albert Esteve wrote:
> > Add SHMEM_MAP/UNMAP requests to vhost-user for dynamic management of
> > VIRTIO Shared Memory mappings.
> >
> > This implementation introduces VirtioSharedMemoryMapping as a unified
> > QOM object that manages both the mapping metadata and MemoryRegion
> > lifecycle. This object provides reference-counted lifecycle management
> > with automatic cleanup of file descriptors and memory regions
> > through QOM finalization.
> >
> > This request allows backends to dynamically map file descriptors into a
> > VIRTIO Shared Memory Region identified by their shmid. Maps are created
> > using memory_region_init_ram_from_fd() with configurable read/write
> > permissions, and the resulting MemoryRegions are added as subregions to
> > the shmem container region. The mapped memory is then advertised to the
> > guest VIRTIO drivers as a base address plus offset for reading and
> > writting according to the requested mmap flags.
> >
> > The backend can unmap memory ranges within a given VIRTIO Shared Memory
> > Region to free resources. Upon receiving this message, the frontend
> > removes the MemoryRegion as a subregion and automatically unreferences
> > the VirtioSharedMemoryMapping object, triggering cleanup if no other
> > references exist.
> >
> > Error handling has been improved to ensure consistent behavior across
> > handlers that manage their own vhost_user_send_resp() calls. Since
> > these handlers clear the VHOST_USER_NEED_REPLY_MASK flag, explicit
> > error checking ensures proper connection closure on failures,
> > maintaining the expected error flow.
> >
> > Note the memory region commit for these operations needs to be delayed
> > until after we respond to the backend to avoid deadlocks.
> >
> > Signed-off-by: Albert Esteve <aesteve@redhat.com>
> > ---
> >  hw/virtio/vhost-user.c                    | 206 +++++++++++++++++++++-
> >  hw/virtio/virtio.c                        | 198 +++++++++++++++++++++
> >  include/hw/virtio/virtio.h                | 136 ++++++++++++++
> >  subprojects/libvhost-user/libvhost-user.c |  70 ++++++++
> >  subprojects/libvhost-user/libvhost-user.h |  54 ++++++
> >  5 files changed, 662 insertions(+), 2 deletions(-)
> >
> > diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> > index 1e1d6b0d6e..4783b1904b 100644
> > --- a/hw/virtio/vhost-user.c
> > +++ b/hw/virtio/vhost-user.c
> > @@ -115,6 +115,8 @@ typedef enum VhostUserBackendRequest {
> >      VHOST_USER_BACKEND_SHARED_OBJECT_ADD =3D 6,
> >      VHOST_USER_BACKEND_SHARED_OBJECT_REMOVE =3D 7,
> >      VHOST_USER_BACKEND_SHARED_OBJECT_LOOKUP =3D 8,
> > +    VHOST_USER_BACKEND_SHMEM_MAP =3D 9,
> > +    VHOST_USER_BACKEND_SHMEM_UNMAP =3D 10,
> >      VHOST_USER_BACKEND_MAX
> >  }  VhostUserBackendRequest;
> >
> > @@ -192,6 +194,23 @@ typedef struct VhostUserShared {
> >      unsigned char uuid[16];
> >  } VhostUserShared;
> >
> > +/* For the flags field of VhostUserMMap */
> > +#define VHOST_USER_FLAG_MAP_RW (1u << 0)
> > +
> > +typedef struct {
> > +    /* VIRTIO Shared Memory Region ID */
> > +    uint8_t shmid;
> > +    uint8_t padding[7];
> > +    /* File offset */
> > +    uint64_t fd_offset;
> > +    /* Offset within the VIRTIO Shared Memory Region */
> > +    uint64_t shm_offset;
> > +    /* Size of the mapping */
> > +    uint64_t len;
> > +    /* Flags for the mmap operation, from VHOST_USER_FLAG_MAP_* */
> > +    uint16_t flags;
> > +} VhostUserMMap;
> > +
> >  typedef struct {
> >      VhostUserRequest request;
> >
> > @@ -224,6 +243,7 @@ typedef union {
> >          VhostUserInflight inflight;
> >          VhostUserShared object;
> >          VhostUserTransferDeviceState transfer_state;
> > +        VhostUserMMap mmap;
> >  } VhostUserPayload;
> >
> >  typedef struct VhostUserMsg {
> > @@ -1768,6 +1788,172 @@ vhost_user_backend_handle_shared_object_lookup(=
struct vhost_user *u,
> >      return 0;
> >  }
> >
> > +/**
> > + * vhost_user_backend_handle_shmem_map() - Handle SHMEM_MAP backend re=
quest
> > + * @dev: vhost device
> > + * @ioc: QIOChannel for communication
> > + * @hdr: vhost-user message header
> > + * @payload: message payload containing mapping details
> > + * @fd: file descriptor for the shared memory region
> > + *
> > + * Handles VHOST_USER_BACKEND_SHMEM_MAP requests from the backend. Cre=
ates
> > + * a VhostUserShmemObject to manage the shared memory mapping and adds=
 it
> > + * to the appropriate VirtIO shared memory region. The VhostUserShmemO=
bject
> > + * serves as an intermediate parent for the MemoryRegion, ensuring pro=
per
> > + * lifecycle management with reference counting.
> > + *
> > + * Returns: 0 on success, negative errno on failure
> > + */
> > +static int
> > +vhost_user_backend_handle_shmem_map(struct vhost_dev *dev,
> > +                                    QIOChannel *ioc,
> > +                                    VhostUserHeader *hdr,
> > +                                    VhostUserPayload *payload,
> > +                                    int fd)
> > +{
> > +    VirtioSharedMemory *shmem;
> > +    VhostUserMMap *vu_mmap =3D &payload->mmap;
> > +    Error *local_err =3D NULL;
> > +    g_autoptr(GString) shm_name =3D g_string_new(NULL);
> > +
> > +    if (fd < 0) {
> > +        error_report("Bad fd for map");
> > +        return -EBADF;
> > +    }
> > +
> > +    if (QSIMPLEQ_EMPTY(&dev->vdev->shmem_list)) {
> > +        error_report("Device has no VIRTIO Shared Memory Regions. "
> > +                     "Requested ID: %d", vu_mmap->shmid);
> > +        return -EFAULT;
> > +    }
> > +
> > +    shmem =3D virtio_find_shmem_region(dev->vdev, vu_mmap->shmid);
> > +    if (!shmem) {
> > +        error_report("VIRTIO Shared Memory Region at "
> > +                     "ID %d not found or unitialized", vu_mmap->shmid)=
;
>
> uninitialized
>
> > +        return -EFAULT;
> > +    }
> > +
> > +    if ((vu_mmap->shm_offset + vu_mmap->len) < vu_mmap->len ||
> > +        (vu_mmap->shm_offset + vu_mmap->len) > shmem->mr.size) {
> > +        error_report("Bad offset/len for mmap %" PRIx64 "+%" PRIx64,
> > +                     vu_mmap->shm_offset, vu_mmap->len);
> > +        return -EFAULT;
> > +    }
> > +
> > +    g_string_printf(shm_name, "virtio-shm%i-%lu",
> > +                    vu_mmap->shmid, vu_mmap->shm_offset);
> > +
> > +    memory_region_transaction_begin();
> > +
> > +    /* Create VirtioSharedMemoryMapping object */
> > +    VirtioSharedMemoryMapping *mapping =3D virtio_shared_memory_mappin=
g_new(
> > +        vu_mmap->shmid, fd, vu_mmap->fd_offset, vu_mmap->shm_offset,
> > +        vu_mmap->len, vu_mmap->flags & VHOST_USER_FLAG_MAP_RW);
> > +
> > +    if (!mapping) {
> > +        memory_region_transaction_commit();
> > +        return -EFAULT;
> > +    }
> > +
> > +    /* Add the mapping to the shared memory region */
> > +    if (virtio_add_shmem_map(shmem, mapping) !=3D 0) {
> > +        error_report("Failed to add shared memory mapping");
> > +        object_unref(OBJECT(mapping));
> > +        memory_region_transaction_commit();
> > +        return -EFAULT;
> > +    }
> > +
> > +    if (hdr->flags & VHOST_USER_NEED_REPLY_MASK) {
> > +        payload->u64 =3D 0;
> > +        hdr->size =3D sizeof(payload->u64);
> > +        vhost_user_send_resp(ioc, hdr, payload, &local_err);
> > +        if (local_err) {
> > +            error_report_err(local_err);
> > +            memory_region_transaction_commit();
> > +            return -EFAULT;
> > +        }
> > +    }
> > +
> > +    memory_region_transaction_commit();
> > +
> > +    return 0;
> > +}
> > +
> > +/**
> > + * vhost_user_backend_handle_shmem_unmap() - Handle SHMEM_UNMAP backen=
d request
> > + * @dev: vhost device
> > + * @ioc: QIOChannel for communication
> > + * @hdr: vhost-user message header
> > + * @payload: message payload containing unmapping details
> > + *
> > + * Handles VHOST_USER_BACKEND_SHMEM_UNMAP requests from the backend. R=
emoves
> > + * the specified memory mapping from the VirtIO shared memory region. =
This
> > + * automatically unreferences the associated VhostUserShmemObject, whi=
ch may
> > + * trigger its finalization and cleanup (munmap, close fd) if no other
> > + * references exist.
> > + *
> > + * Returns: 0 on success, negative errno on failure
> > + */
> > +static int
> > +vhost_user_backend_handle_shmem_unmap(struct vhost_dev *dev,
> > +                                      QIOChannel *ioc,
> > +                                      VhostUserHeader *hdr,
> > +                                      VhostUserPayload *payload)
> > +{
> > +    VirtioSharedMemory *shmem;
> > +    VirtioSharedMemoryMapping *mmap =3D NULL;
> > +    VhostUserMMap *vu_mmap =3D &payload->mmap;
> > +    Error *local_err =3D NULL;
> > +
> > +    if (QSIMPLEQ_EMPTY(&dev->vdev->shmem_list)) {
> > +        error_report("Device has no VIRTIO Shared Memory Regions. "
> > +                     "Requested ID: %d", vu_mmap->shmid);
> > +        return -EFAULT;
> > +    }
> > +
> > +    shmem =3D virtio_find_shmem_region(dev->vdev, vu_mmap->shmid);
> > +    if (!shmem) {
> > +        error_report("VIRTIO Shared Memory Region at "
> > +                     "ID %d not found or unitialized", vu_mmap->shmid)=
;
>
> uninitialized
>
> > +        return -EFAULT;
> > +    }
> > +
> > +    if ((vu_mmap->shm_offset + vu_mmap->len) < vu_mmap->len ||
> > +        (vu_mmap->shm_offset + vu_mmap->len) > shmem->mr.size) {
> > +        error_report("Bad offset/len for unmmap %" PRIx64 "+%" PRIx64,
> > +                     vu_mmap->shm_offset, vu_mmap->len);
> > +        return -EFAULT;
> > +    }
> > +
> > +    mmap =3D virtio_find_shmem_map(shmem, vu_mmap->shm_offset, vu_mmap=
->len);
> > +    if (!mmap) {
> > +        error_report("Shared memory mapping not found at offset %" PRI=
x64
> > +                     " with length %" PRIx64,
> > +                     vu_mmap->shm_offset, vu_mmap->len);
> > +        return -EFAULT;
> > +    }
> > +
> > +    memory_region_transaction_begin();
> > +    memory_region_del_subregion(&shmem->mr, mmap->mr);
> > +    if (hdr->flags & VHOST_USER_NEED_REPLY_MASK) {
> > +        payload->u64 =3D 0;
> > +        hdr->size =3D sizeof(payload->u64);
> > +        vhost_user_send_resp(ioc, hdr, payload, &local_err);
> > +        if (local_err) {
> > +            error_report_err(local_err);
> > +            memory_region_transaction_commit();
> > +            return -EFAULT;
> > +        }
> > +    }
> > +    memory_region_transaction_commit();
> > +
> > +    /* Free the MemoryRegion only after vhost_commit */
> > +    virtio_del_shmem_map(shmem, vu_mmap->shm_offset, vu_mmap->len);
> > +
> > +    return 0;
> > +}
> > +
> >  static void close_backend_channel(struct vhost_user *u)
> >  {
> >      g_source_destroy(u->backend_src);
> > @@ -1833,8 +2019,24 @@ static gboolean backend_read(QIOChannel *ioc, GI=
OCondition condition,
> >                                                               &payload.=
object);
> >          break;
> >      case VHOST_USER_BACKEND_SHARED_OBJECT_LOOKUP:
> > -        ret =3D vhost_user_backend_handle_shared_object_lookup(dev->op=
aque, ioc,
> > -                                                             &hdr, &pa=
yload);
> > +        /* Handler manages its own response, check error and close con=
nection */
> > +        if (vhost_user_backend_handle_shared_object_lookup(dev->opaque=
, ioc,
> > +                                                           &hdr, &payl=
oad) < 0) {
> > +            goto err;
> > +        }
> > +        break;
>
> This looks like a bug fix that is unrelated to this patch. The change
> doesn't look correct though: the vhost-user response is skipped when
> vhost_user_backend_handle_shared_object_lookup() returns non-zero and
> the return value in the payload is replaced with 0 in the -EINVAL and
> vhost_user_get_shared_object() failure cases.

What vhost_user_backend_handle_shared_object_lookup() returns, depends
basically on whether vhost_user_backend_send_dmabuf_fd() succeded or
not to send a reponse. What you described is what determines the
return type in the response. But as the comment states, the response
is sent within the handler. When an error in sending the response
occurs, we want to close the backend channel to be consistent with
other messages. That is what this small fix does. On the other hand,
when the response succeds then the VHOST_USER_NEED_REPLY_MASK flag is
unset and the response here is skipped, going directly to the
fdcleanup. I think the logic is correct.

>
> I suggest dropping this and sending a separate patch (independently from
> this series) that fixes VHOST_USER_BACKEND_SHARED_OBJECT_LOOKUP replies.

I mean, I can do that. It is true that is technically unrelated.

>
> > +    case VHOST_USER_BACKEND_SHMEM_MAP:
> > +        /* Handler manages its own response, check error and close con=
nection */
>
> This comment is not true: the response is only sent in the success case.
> Errors do not result in a response being sent because goto err skips
> vhost_user_send_resp().
>
> Please take a look and ensure that a response is sent in all cases.

OK. True, I mixed other handler's style of early returning with what
should've been the fix for this. I need to set the return type instead
and goto the reply when something breaks.

>
> > +        if (vhost_user_backend_handle_shmem_map(dev, ioc, &hdr, &paylo=
ad,
> > +                                                fd ? fd[0] : -1) < 0) =
{
> > +            goto err;
> > +        }
> > +        break;
> > +    case VHOST_USER_BACKEND_SHMEM_UNMAP:
> > +        /* Handler manages its own response, check error and close con=
nection */
>
> Same here.
>
> > +        if (vhost_user_backend_handle_shmem_unmap(dev, ioc, &hdr, &pay=
load) < 0) {
> > +            goto err;
> > +        }
> >          break;
> >      default:
> >          error_report("Received unexpected msg type: %d.", hdr.request)=
;
> > diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> > index 9a81ad912e..ba5ffa58bd 100644
> > --- a/hw/virtio/virtio.c
> > +++ b/hw/virtio/virtio.c
> > @@ -3045,6 +3045,181 @@ int virtio_save(VirtIODevice *vdev, QEMUFile *f=
)
> >      return vmstate_save_state(f, &vmstate_virtio, vdev, NULL);
> >  }
> >
> > +VirtioSharedMemory *virtio_new_shmem_region(VirtIODevice *vdev, uint8_=
t shmid, uint64_t size)
> > +{
> > +    VirtioSharedMemory *elem;
> > +    g_autofree char *name =3D NULL;
> > +
> > +    elem =3D g_new0(VirtioSharedMemory, 1);
> > +    elem->shmid =3D shmid;
> > +
> > +    /* Initialize embedded MemoryRegion as container for shmem mapping=
s */
> > +    name =3D g_strdup_printf("virtio-shmem-%d", shmid);
> > +    memory_region_init(&elem->mr, OBJECT(vdev), name, size);
> > +    QTAILQ_INIT(&elem->mmaps);
> > +    QSIMPLEQ_INSERT_TAIL(&vdev->shmem_list, elem, entry);
> > +    return elem;
> > +}
> > +
> > +VirtioSharedMemory *virtio_find_shmem_region(VirtIODevice *vdev, uint8=
_t shmid)
> > +{
> > +    VirtioSharedMemory *shmem, *next;
> > +    QSIMPLEQ_FOREACH_SAFE(shmem, &vdev->shmem_list, entry, next) {
> > +        if (shmem->shmid =3D=3D shmid) {
> > +            return shmem;
> > +        }
> > +    }
> > +    return NULL;
> > +}
> > +
> > +static void virtio_shared_memory_mapping_instance_init(Object *obj)
> > +{
> > +    VirtioSharedMemoryMapping *mapping =3D VIRTIO_SHARED_MEMORY_MAPPIN=
G(obj);
> > +
> > +    mapping->shmid =3D 0;
> > +    mapping->fd =3D -1;
> > +    mapping->offset =3D 0;
> > +    mapping->len =3D 0;
> > +    mapping->mr =3D NULL;
> > +}
> > +
> > +static void virtio_shared_memory_mapping_finalize(Object *obj)
>
> The naming is inconsistent, instance_init vs finalize:
>   .instance_init =3D virtio_shared_memory_mapping_instance_init,
>   .instance_finalize =3D virtio_shared_memory_mapping_finalize,
>
> virtio_shared_memory_mapping_instance_finalize() would be consistent.
>
> > +{
> > +    VirtioSharedMemoryMapping *mapping =3D VIRTIO_SHARED_MEMORY_MAPPIN=
G(obj);
> > +
> > +    /* Clean up MemoryRegion if it exists */
> > +    if (mapping->mr) {
> > +        /* Unparent the MemoryRegion to trigger cleanup */
> > +        object_unparent(OBJECT(mapping->mr));
> > +        mapping->mr =3D NULL;
> > +    }
> > +
> > +    /* Close file descriptor */
> > +    if (mapping->fd >=3D 0) {
> > +        close(mapping->fd);
> > +        mapping->fd =3D -1;
> > +    }
> > +}
> > +
> > +VirtioSharedMemoryMapping *virtio_shared_memory_mapping_new(uint8_t sh=
mid,
> > +                                                            int fd,
> > +                                                            uint64_t f=
d_offset,
> > +                                                            uint64_t s=
hm_offset,
> > +                                                            uint64_t l=
en,
> > +                                                            bool allow=
_write)
> > +{
> > +    VirtioSharedMemoryMapping *mapping;
> > +    MemoryRegion *mr;
> > +    g_autoptr(GString) mr_name =3D g_string_new(NULL);
> > +    uint32_t ram_flags;
> > +    Error *local_err =3D NULL;
> > +
> > +    if (len =3D=3D 0) {
> > +        error_report("Shared memory mapping size cannot be zero");
> > +        return NULL;
> > +    }
> > +
> > +    fd =3D dup(fd);
> > +    if (fd < 0) {
> > +        error_report("Failed to duplicate fd: %s", strerror(errno));
> > +        return NULL;
> > +    }
> > +
> > +    /* Determine RAM flags */
> > +    ram_flags =3D RAM_SHARED;
> > +    if (!allow_write) {
> > +        ram_flags |=3D RAM_READONLY_FD;
> > +    }
> > +
> > +    /* Create the VirtioSharedMemoryMapping */
> > +    mapping =3D VIRTIO_SHARED_MEMORY_MAPPING(
> > +        object_new(TYPE_VIRTIO_SHARED_MEMORY_MAPPING));
> > +
> > +    /* Set up object properties */
> > +    mapping->shmid =3D shmid;
> > +    mapping->fd =3D fd;
> > +    mapping->offset =3D shm_offset;
> > +    mapping->len =3D len;
> > +
> > +    /* Create MemoryRegion as a child of this object */
> > +    mr =3D g_new0(MemoryRegion, 1);
> > +    g_string_printf(mr_name, "virtio-shmem-%d-%" PRIx64, shmid, shm_of=
fset);
> > +
> > +    /* Initialize MemoryRegion with file descriptor */
> > +    if (!memory_region_init_ram_from_fd(mr, OBJECT(mapping), mr_name->=
str,
> > +                                        len, ram_flags, fd, fd_offset,
> > +                                        &local_err)) {
> > +        error_report_err(local_err);
> > +        g_free(mr);
> > +        close(fd);
> > +        object_unref(OBJECT(mapping));
> > +        return NULL;
> > +    }
> > +
> > +    mapping->mr =3D mr;
> > +    return mapping;
> > +}
> > +
> > +int virtio_add_shmem_map(VirtioSharedMemory *shmem,
> > +                         VirtioSharedMemoryMapping *mapping)
> > +{
> > +    if (!mapping) {
> > +        error_report("VirtioSharedMemoryMapping cannot be NULL");
> > +        return -1;
> > +    }
> > +    if (!mapping->mr) {
> > +        error_report("VirtioSharedMemoryMapping has no MemoryRegion");
> > +        return -1;
> > +    }
> > +
> > +    /* Validate boundaries against the VIRTIO shared memory region */
> > +    if (mapping->offset + mapping->len > shmem->mr.size) {
> > +        error_report("Memory exceeds the shared memory boundaries");
> > +        return -1;
> > +    }
> > +
> > +    /* Add as subregion to the VIRTIO shared memory */
> > +    memory_region_add_subregion(&shmem->mr, mapping->offset, mapping->=
mr);
> > +
> > +    /* Add to the mapped regions list */
> > +    QTAILQ_INSERT_TAIL(&shmem->mmaps, mapping, link);
> > +
> > +    return 0;
> > +}
> > +
> > +VirtioSharedMemoryMapping *virtio_find_shmem_map(VirtioSharedMemory *s=
hmem,
> > +                                          hwaddr offset, uint64_t size=
)
> > +{
> > +    VirtioSharedMemoryMapping *mapping;
> > +    QTAILQ_FOREACH(mapping, &shmem->mmaps, link) {
> > +        if (mapping->offset =3D=3D offset && mapping->mr->size =3D=3D =
size) {
> > +            return mapping;
> > +        }
> > +    }
> > +    return NULL;
> > +}
> > +
> > +void virtio_del_shmem_map(VirtioSharedMemory *shmem, hwaddr offset,
> > +                          uint64_t size)
> > +{
> > +    VirtioSharedMemoryMapping *mapping =3D virtio_find_shmem_map(shmem=
, offset, size);
> > +    if (mapping =3D=3D NULL) {
> > +        return;
> > +    }
> > +
> > +    /*
> > +     * Remove from memory region first
> > +     */
> > +    memory_region_del_subregion(&shmem->mr, mapping->mr);
>
> There is an identical call in vhost_user_backend_handle_shmem_unmap().
> It looks like memory_region_del_subregion()'s
> assert(subregion->container =3D=3D mr) would fail here when called from
> vhost_user_backend_handle_shmem_unmap().
>
> How does this work?

Uhm. I was sure I tested this and spent some time trying to figure out
the logic. But after all, I have to agree with you and tested again to
make sure. And indeed it fails on that assertion.

So I think the memory_region_del_subregion() that is added in
virtio_del_shmem_map() for this revision is necessary as
virtio_del_shmem_map() is also called from
virtio_device_instance_finalize() (and virtio_reset() with your next
comment).

So what I will try is to remove memory_region_del_subregion() from the
vhost_user_backend_handle_shmem_unmap(), probably I can also remove
the memory_region_transaction_* function calls. That was there for a
few revisions now so I probably overlooked it when doing the latest
changes.


>
> > +
> > +    /*
> > +     * Remove from list and unref the mapping which will trigger autom=
atic cleanup
> > +     * when the reference count reaches zero.
> > +     */
> > +    QTAILQ_REMOVE(&shmem->mmaps, mapping, link);
> > +    object_unref(OBJECT(mapping));
> > +}
> > +
> >  /* A wrapper for use as a VMState .put function */
> >  static int virtio_device_put(QEMUFile *f, void *opaque, size_t size,
> >                                const VMStateField *field, JSONWriter *v=
mdesc)
> > @@ -3521,6 +3696,7 @@ void virtio_init(VirtIODevice *vdev, uint16_t dev=
ice_id, size_t config_size)
> >              NULL, virtio_vmstate_change, vdev);
> >      vdev->device_endian =3D virtio_default_endian();
> >      vdev->use_guest_notifier_mask =3D true;
> > +    QSIMPLEQ_INIT(&vdev->shmem_list);
> >  }
> >
> >  /*
> > @@ -4032,11 +4208,24 @@ static void virtio_device_free_virtqueues(VirtI=
ODevice *vdev)
> >  static void virtio_device_instance_finalize(Object *obj)
> >  {
> >      VirtIODevice *vdev =3D VIRTIO_DEVICE(obj);
> > +    VirtioSharedMemory *shmem;
> >
> >      virtio_device_free_virtqueues(vdev);
> >
> >      g_free(vdev->config);
> >      g_free(vdev->vector_queues);
> > +    while (!QSIMPLEQ_EMPTY(&vdev->shmem_list)) {
> > +        shmem =3D QSIMPLEQ_FIRST(&vdev->shmem_list);
> > +        while (!QTAILQ_EMPTY(&shmem->mmaps)) {
> > +            VirtioSharedMemoryMapping *mapping =3D QTAILQ_FIRST(&shmem=
->mmaps);
> > +            virtio_del_shmem_map(shmem, mapping->offset, mapping->mr->=
size);
> > +        }
> > +
> > +        /* Clean up the embedded MemoryRegion */
> > +        object_unparent(OBJECT(&shmem->mr));
> > +        QSIMPLEQ_REMOVE_HEAD(&vdev->shmem_list, entry);
> > +        g_free(shmem);
> > +    }
> >  }
>
> The semantics across device reset also need to be defined. I think
> mappings should be deleted when the device is reset, but the VIRTIO
> Shared Memory Regions should remain. The reason I think this behavior
> makes sense is that it prevents stale fds remaining open and mapped into
> the guest (e.g. GPU or virtiofs resources). It seems safer than relying
> on the backend to unmap explicitly.

Got it.

>
> >
> >  static const Property virtio_properties[] =3D {
> > @@ -4402,9 +4591,18 @@ static const TypeInfo virtio_device_info =3D {
> >      .class_size =3D sizeof(VirtioDeviceClass),
> >  };
> >
> > +static const TypeInfo virtio_shared_memory_mapping_info =3D {
> > +    .name =3D TYPE_VIRTIO_SHARED_MEMORY_MAPPING,
> > +    .parent =3D TYPE_OBJECT,
> > +    .instance_size =3D sizeof(VirtioSharedMemoryMapping),
> > +    .instance_init =3D virtio_shared_memory_mapping_instance_init,
> > +    .instance_finalize =3D virtio_shared_memory_mapping_finalize,
> > +};
> > +
> >  static void virtio_register_types(void)
> >  {
> >      type_register_static(&virtio_device_info);
> > +    type_register_static(&virtio_shared_memory_mapping_info);
> >  }
> >
> >  type_init(virtio_register_types)
> > diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
> > index c594764f23..8cecb221cb 100644
> > --- a/include/hw/virtio/virtio.h
> > +++ b/include/hw/virtio/virtio.h
> > @@ -98,6 +98,46 @@ enum virtio_device_endian {
> >      VIRTIO_DEVICE_ENDIAN_BIG,
> >  };
> >
> > +#define TYPE_VIRTIO_SHARED_MEMORY_MAPPING "virtio-shared-memory-mappin=
g"
> > +OBJECT_DECLARE_SIMPLE_TYPE(VirtioSharedMemoryMapping, VIRTIO_SHARED_ME=
MORY_MAPPING)
> > +
> > +/**
> > + * VirtioSharedMemoryMapping:
> > + * @parent: Parent QOM object
> > + * @shmid: VIRTIO Shared Memory Region ID
> > + * @fd: File descriptor for the shared memory region
> > + * @offset: Offset within the VIRTIO Shared Memory Region
> > + * @len: Size of the mapping
> > + * @mr: MemoryRegion associated with this shared memory mapping
> > + * @link: List entry for the shared memory region's mapping list
> > + *
> > + * A QOM object that represents an individual file descriptor-based sh=
ared
> > + * memory mapping within a VIRTIO Shared Memory Region. It manages the
> > + * MemoryRegion lifecycle and file descriptor cleanup through QOM refe=
rence
> > + * counting. When the object is unreferenced and its reference count d=
rops
> > + * to zero, it automatically cleans up the MemoryRegion and closes the=
 file
> > + * descriptor.
> > + */
> > +struct VirtioSharedMemoryMapping {
> > +    Object parent;
> > +
> > +    uint8_t shmid;
> > +    int fd;
> > +    hwaddr offset;
> > +    uint64_t len;
> > +    MemoryRegion *mr;
> > +    QTAILQ_ENTRY(VirtioSharedMemoryMapping) link;
> > +};
> > +
> > +struct VirtioSharedMemory {
> > +    uint8_t shmid;
> > +    MemoryRegion mr;
> > +    QTAILQ_HEAD(, VirtioSharedMemoryMapping) mmaps;
> > +    QSIMPLEQ_ENTRY(VirtioSharedMemory) entry;
> > +};
> > +
> > +typedef struct VirtioSharedMemory VirtioSharedMemory;
> > +
> >  /**
> >   * struct VirtIODevice - common VirtIO structure
> >   * @name: name of the device
> > @@ -167,6 +207,8 @@ struct VirtIODevice
> >       */
> >      EventNotifier config_notifier;
> >      bool device_iotlb_enabled;
> > +    /* Shared memory region for mappings. */
> > +    QSIMPLEQ_HEAD(, VirtioSharedMemory) shmem_list;
> >  };
> >
> >  struct VirtioDeviceClass {
> > @@ -295,6 +337,100 @@ void virtio_notify(VirtIODevice *vdev, VirtQueue =
*vq);
> >
> >  int virtio_save(VirtIODevice *vdev, QEMUFile *f);
> >
> > +/**
> > + * virtio_new_shmem_region() - Create a new shared memory region
> > + * @vdev: VirtIODevice
> > + * @shmid: Shared memory ID
> > + * @size: Size of the shared memory region
> > + *
> > + * Creates a new VirtioSharedMemory region for the given device and ID=
.
> > + * The returned VirtioSharedMemory is owned by the VirtIODevice and wi=
ll
> > + * be automatically freed when the device is destroyed. The caller
> > + * should not free the returned pointer.
> > + *
> > + * Returns: Pointer to the new VirtioSharedMemory region, or NULL on f=
ailure
> > + */
> > +VirtioSharedMemory *virtio_new_shmem_region(VirtIODevice *vdev, uint8_=
t shmid, uint64_t size);
> > +
> > +/**
> > + * virtio_find_shmem_region() - Find an existing shared memory region
> > + * @vdev: VirtIODevice
> > + * @shmid: Shared memory ID to find
> > + *
> > + * Finds an existing VirtioSharedMemory region by ID. The returned poi=
nter
> > + * is owned by the VirtIODevice and should not be freed by the caller.
> > + *
> > + * Returns: Pointer to the VirtioSharedMemory region, or NULL if not f=
ound
> > + */
> > +VirtioSharedMemory *virtio_find_shmem_region(VirtIODevice *vdev, uint8=
_t shmid);
> > +
> > +/**
> > + * virtio_shared_memory_mapping_new() - Create a new VirtioSharedMemor=
yMapping
> > + * @shmid: VIRTIO Shared Memory Region ID
> > + * @fd: File descriptor for the shared memory
> > + * @fd_offset: Offset within the file descriptor
> > + * @shm_offset: Offset within the VIRTIO Shared Memory Region
> > + * @len: Size of the mapping
> > + * @allow_write: Whether to allow write access to the mapping
> > + *
> > + * Creates a new VirtioSharedMemoryMapping that manages a shared memor=
y mapping.
> > + * The object will create a MemoryRegion using memory_region_init_ram_=
from_fd()
> > + * as a child object. When the object is finalized, it will automatica=
lly
> > + * clean up the MemoryRegion and close the file descriptor.
> > + *
> > + * Return: A new VirtioSharedMemoryMapping on success, NULL on error.
> > + */
> > +VirtioSharedMemoryMapping *virtio_shared_memory_mapping_new(uint8_t sh=
mid,
> > +                                                            int fd,
> > +                                                            uint64_t f=
d_offset,
> > +                                                            uint64_t s=
hm_offset,
> > +                                                            uint64_t l=
en,
> > +                                                            bool allow=
_write);
> > +
> > +/**
> > + * virtio_add_shmem_map() - Add a memory mapping to a shared region
> > + * @shmem: VirtioSharedMemory region
> > + * @mapping: VirtioSharedMemoryMapping to add (transfers ownership)
> > + *
> > + * Adds a memory mapping to the shared memory region. The VirtioShared=
MemoryMapping
> > + * ownership is transferred to the shared memory region and will be au=
tomatically
> > + * cleaned up through QOM reference counting when virtio_del_shmem_map=
() is
> > + * called or when the shared memory region is destroyed.
> > + *
> > + * Returns: 0 on success, negative errno on failure
> > + */
> > +int virtio_add_shmem_map(VirtioSharedMemory *shmem,
> > +                         VirtioSharedMemoryMapping *mapping);
> > +
> > +/**
> > + * virtio_find_shmem_map() - Find a memory mapping in a shared region
> > + * @shmem: VirtioSharedMemory region
> > + * @offset: Offset within the shared memory region
> > + * @size: Size of the mapping to find
> > + *
> > + * Finds an existing memory mapping that covers the specified range.
> > + * The returned VirtioSharedMemoryMapping is owned by the VirtioShared=
Memory
> > + * region and should not be freed by the caller.
> > + *
> > + * Returns: Pointer to the VirtioSharedMemoryMapping, or NULL if not f=
ound
> > + */
> > +VirtioSharedMemoryMapping *virtio_find_shmem_map(VirtioSharedMemory *s=
hmem,
> > +                                          hwaddr offset, uint64_t size=
);
> > +
> > +/**
> > + * virtio_del_shmem_map() - Remove a memory mapping from a shared regi=
on
> > + * @shmem: VirtioSharedMemory region
> > + * @offset: Offset of the mapping to remove
> > + * @size: Size of the mapping to remove
> > + *
> > + * Removes a memory mapping from the shared memory region. This will
> > + * automatically unref the associated VhostUserShmemObject, which may
> > + * trigger its finalization and cleanup if no other references exist.
> > + * The mapping's MemoryRegion will be properly unmapped and cleaned up=
.
> > + */
> > +void virtio_del_shmem_map(VirtioSharedMemory *shmem, hwaddr offset,
> > +                          uint64_t size);
> > +
> >  extern const VMStateInfo virtio_vmstate_info;
> >
> >  #define VMSTATE_VIRTIO_DEVICE \
> > diff --git a/subprojects/libvhost-user/libvhost-user.c b/subprojects/li=
bvhost-user/libvhost-user.c
> > index 9c630c2170..034cbfdc3c 100644
> > --- a/subprojects/libvhost-user/libvhost-user.c
> > +++ b/subprojects/libvhost-user/libvhost-user.c
> > @@ -1592,6 +1592,76 @@ vu_rm_shared_object(VuDev *dev, unsigned char uu=
id[UUID_LEN])
> >      return vu_send_message(dev, &msg);
> >  }
> >
> > +bool
> > +vu_shmem_map(VuDev *dev, uint8_t shmid, uint64_t fd_offset,
> > +             uint64_t shm_offset, uint64_t len, uint64_t flags, int fd=
)
> > +{
> > +    VhostUserMsg vmsg =3D {
> > +        .request =3D VHOST_USER_BACKEND_SHMEM_MAP,
> > +        .size =3D sizeof(vmsg.payload.mmap),
> > +        .flags =3D VHOST_USER_VERSION,
> > +        .payload.mmap =3D {
> > +            .shmid =3D shmid,
> > +            .fd_offset =3D fd_offset,
> > +            .shm_offset =3D shm_offset,
> > +            .len =3D len,
> > +            .flags =3D flags,
> > +        },
> > +        .fd_num =3D 1,
> > +        .fds[0] =3D fd,
> > +    };
> > +
> > +    if (!vu_has_protocol_feature(dev, VHOST_USER_PROTOCOL_F_SHMEM)) {
> > +        return false;
> > +    }
> > +
> > +    if (vu_has_protocol_feature(dev, VHOST_USER_PROTOCOL_F_REPLY_ACK))=
 {
> > +        vmsg.flags |=3D VHOST_USER_NEED_REPLY_MASK;
> > +    }
> > +
> > +    pthread_mutex_lock(&dev->backend_mutex);
> > +    if (!vu_message_write(dev, dev->backend_fd, &vmsg)) {
> > +        pthread_mutex_unlock(&dev->backend_mutex);
> > +        return false;
> > +    }
> > +
> > +    /* Also unlocks the backend_mutex */
> > +    return vu_process_message_reply(dev, &vmsg);
> > +}
> > +
> > +bool
> > +vu_shmem_unmap(VuDev *dev, uint8_t shmid, uint64_t shm_offset, uint64_=
t len)
> > +{
> > +    VhostUserMsg vmsg =3D {
> > +        .request =3D VHOST_USER_BACKEND_SHMEM_UNMAP,
> > +        .size =3D sizeof(vmsg.payload.mmap),
> > +        .flags =3D VHOST_USER_VERSION,
> > +        .payload.mmap =3D {
> > +            .shmid =3D shmid,
> > +            .fd_offset =3D 0,
> > +            .shm_offset =3D shm_offset,
> > +            .len =3D len,
> > +        },
> > +    };
> > +
> > +    if (!vu_has_protocol_feature(dev, VHOST_USER_PROTOCOL_F_SHMEM)) {
> > +        return false;
> > +    }
> > +
> > +    if (vu_has_protocol_feature(dev, VHOST_USER_PROTOCOL_F_REPLY_ACK))=
 {
> > +        vmsg.flags |=3D VHOST_USER_NEED_REPLY_MASK;
> > +    }
> > +
> > +    pthread_mutex_lock(&dev->backend_mutex);
> > +    if (!vu_message_write(dev, dev->backend_fd, &vmsg)) {
> > +        pthread_mutex_unlock(&dev->backend_mutex);
> > +        return false;
> > +    }
> > +
> > +    /* Also unlocks the backend_mutex */
> > +    return vu_process_message_reply(dev, &vmsg);
> > +}
> > +
> >  static bool
> >  vu_set_vring_call_exec(VuDev *dev, VhostUserMsg *vmsg)
> >  {
> > diff --git a/subprojects/libvhost-user/libvhost-user.h b/subprojects/li=
bvhost-user/libvhost-user.h
> > index 2ffc58c11b..26b710c92d 100644
> > --- a/subprojects/libvhost-user/libvhost-user.h
> > +++ b/subprojects/libvhost-user/libvhost-user.h
> > @@ -69,6 +69,8 @@ enum VhostUserProtocolFeature {
> >      /* Feature 16 is reserved for VHOST_USER_PROTOCOL_F_STATUS. */
> >      /* Feature 17 reserved for VHOST_USER_PROTOCOL_F_XEN_MMAP. */
> >      VHOST_USER_PROTOCOL_F_SHARED_OBJECT =3D 18,
> > +    /* Feature 19 is reserved for VHOST_USER_PROTOCOL_F_DEVICE_STATE *=
/
> > +    VHOST_USER_PROTOCOL_F_SHMEM =3D 20,
> >      VHOST_USER_PROTOCOL_F_MAX
> >  };
> >
> > @@ -127,6 +129,8 @@ typedef enum VhostUserBackendRequest {
> >      VHOST_USER_BACKEND_SHARED_OBJECT_ADD =3D 6,
> >      VHOST_USER_BACKEND_SHARED_OBJECT_REMOVE =3D 7,
> >      VHOST_USER_BACKEND_SHARED_OBJECT_LOOKUP =3D 8,
> > +    VHOST_USER_BACKEND_SHMEM_MAP =3D 9,
> > +    VHOST_USER_BACKEND_SHMEM_UNMAP =3D 10,
> >      VHOST_USER_BACKEND_MAX
> >  }  VhostUserBackendRequest;
> >
> > @@ -186,6 +190,23 @@ typedef struct VhostUserShared {
> >      unsigned char uuid[UUID_LEN];
> >  } VhostUserShared;
> >
> > +/* For the flags field of VhostUserMMap */
> > +#define VHOST_USER_FLAG_MAP_RW (1u << 0)
> > +
> > +typedef struct {
> > +    /* VIRTIO Shared Memory Region ID */
> > +    uint8_t shmid;
> > +    uint8_t padding[7];
> > +    /* File offset */
> > +    uint64_t fd_offset;
> > +    /* Offset within the VIRTIO Shared Memory Region */
> > +    uint64_t shm_offset;
> > +    /* Size of the mapping */
> > +    uint64_t len;
> > +    /* Flags for the mmap operation, from VHOST_USER_FLAG_MAP_* */
> > +    uint16_t flags;
> > +} VhostUserMMap;
> > +
> >  #define VU_PACKED __attribute__((packed))
> >
> >  typedef struct VhostUserMsg {
> > @@ -210,6 +231,7 @@ typedef struct VhostUserMsg {
> >          VhostUserVringArea area;
> >          VhostUserInflight inflight;
> >          VhostUserShared object;
> > +        VhostUserMMap mmap;
> >      } payload;
> >
> >      int fds[VHOST_MEMORY_BASELINE_NREGIONS];
> > @@ -593,6 +615,38 @@ bool vu_add_shared_object(VuDev *dev, unsigned cha=
r uuid[UUID_LEN]);
> >   */
> >  bool vu_rm_shared_object(VuDev *dev, unsigned char uuid[UUID_LEN]);
> >
> > +/**
> > + * vu_shmem_map:
> > + * @dev: a VuDev context
> > + * @shmid: VIRTIO Shared Memory Region ID
> > + * @fd_offset: File offset
> > + * @shm_offset: Offset within the VIRTIO Shared Memory Region
> > + * @len: Size of the mapping
> > + * @flags: Flags for the mmap operation
> > + * @fd: A file descriptor
> > + *
> > + * Advertises a new mapping to be made in a given VIRTIO Shared Memory=
 Region.
> > + *
> > + * Returns: TRUE on success, FALSE on failure.
> > + */
> > +bool vu_shmem_map(VuDev *dev, uint8_t shmid, uint64_t fd_offset,
> > +                  uint64_t shm_offset, uint64_t len, uint64_t flags, i=
nt fd);
> > +
> > +/**
> > + * vu_shmem_unmap:
> > + * @dev: a VuDev context
> > + * @shmid: VIRTIO Shared Memory Region ID
> > + * @fd_offset: File offset
> > + * @len: Size of the mapping
> > + *
> > + * The front-end un-mmaps a given range in the VIRTIO Shared Memory Re=
gion
> > + * with the requested `shmid`.
> > + *
> > + * Returns: TRUE on success, FALSE on failure.
> > + */
> > +bool vu_shmem_unmap(VuDev *dev, uint8_t shmid, uint64_t shm_offset,
> > +                    uint64_t len);
> > +
> >  /**
> >   * vu_queue_set_notification:
> >   * @dev: a VuDev context
> > --
> > 2.49.0
> >


