Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B7A9D3B7F0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2024 08:29:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFUSL-0004uQ-BF; Mon, 25 Nov 2024 03:28:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1tFUSK-0004uD-1B
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 03:28:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1tFUSH-0001qB-Hg
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 03:28:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732523302;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kTTquZBRghUyEt/d8fUM9BAOnGyMtDCD3/9+3IwE1mk=;
 b=ejIv5fVADG43NebStudSPJdHaRezb3/gGgkd2U4IR5S3OSgbti2E1QNsMbh5VtzuG2acV8
 FQO4xmYL0+cKzovGUYgIJwSFJMBUwRQyzEMfkhO8XxGjgFjIuRjjWZ9Ck/IwzXpB/B70se
 J1RRuPhMj9vtyKTtRp9kg64Y8FZzjVw=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-527-KCFORbWUNhaYMg4g1NIi7w-1; Mon, 25 Nov 2024 03:28:20 -0500
X-MC-Unique: KCFORbWUNhaYMg4g1NIi7w-1
X-Mimecast-MFC-AGG-ID: KCFORbWUNhaYMg4g1NIi7w
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-2ea2dc1a51fso4196009a91.2
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2024 00:28:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732523299; x=1733128099;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kTTquZBRghUyEt/d8fUM9BAOnGyMtDCD3/9+3IwE1mk=;
 b=e8eNQbTAtV5ve7sRzpt7gMPGFro+J2+lysSkah5N8fuaueKspVrvWBQv7tk8xaOmjD
 Uv/dlCBabK4mkf1XWCsPMO1uCmSaescKSdXBzfvZovUhaNAfYRjFUtS57X4+HG0clZ4X
 /npeYx2eHSQURinPiiRa/rDl12bcEm2/YTh6QyyiI6cHECvHjqg5xVXcJJFDejfYcRLy
 J1JJvoPe+Nsan2Mks8kOGzVQ0TK3vvuv+rpcC8qCAbbyi8sJihad5H9pyJG/4yMyb1nR
 GXMjHLRtILMg+UDm6ryel4//HB1cIMBx7KJxQv4/5kS/W6/+ABw317YeXgLF0kW02FTg
 lzUQ==
X-Gm-Message-State: AOJu0Yy6CYMxK0Baq6904eAMM3zNhyVNmolZQgwVv0ClKXW0hpTLXsyw
 4nmSncMSazcpJbarsCtoNVXJJKV2b8z33Sa2GZLUyNhnvv3a2IRrIZykQSb6IIe+dHh5wykS5JO
 htdf0G/OvYvWv5QwMWP4dHmz7mG+zgLOn1Te+s9cuKvkBbM+VQ17TL7++LiVrN1gmFyhlMmvYr8
 mCU0wQG6g6vsXgNteQMAxxGvV3zXM=
X-Gm-Gg: ASbGncvK2Pid7uPW9+Yi19N8QVpL/soEAHGwX4EMnyLDaVgD2qBQP/MG+gKWTPmlDYD
 Kv1Kmo0rDVq8PCWIjQzYecGsnVrg22DXv
X-Received: by 2002:a17:90b:4c4b:b0:2ea:b2a5:933e with SMTP id
 98e67ed59e1d1-2eb0e024b84mr16367766a91.7.1732523299370; 
 Mon, 25 Nov 2024 00:28:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEyQZe5njMakZDxWiIsr6oysMMn2z5ddOSCaWQQmB6lnoS29XpoVOjhORMVZClZGwTscg/QG1u6WM8BscXQWME=
X-Received: by 2002:a17:90b:4c4b:b0:2ea:b2a5:933e with SMTP id
 98e67ed59e1d1-2eb0e024b84mr16367742a91.7.1732523299039; Mon, 25 Nov 2024
 00:28:19 -0800 (PST)
MIME-Version: 1.0
References: <20240912145335.129447-1-aesteve@redhat.com>
 <20240912145335.129447-2-aesteve@redhat.com>
 <abfd06b7-ad85-454b-a973-6c939c4588e3@redhat.com>
In-Reply-To: <abfd06b7-ad85-454b-a973-6c939c4588e3@redhat.com>
From: Albert Esteve <aesteve@redhat.com>
Date: Mon, 25 Nov 2024 09:28:07 +0100
Message-ID: <CADSE00+Yg+ufOT1NQ+8H7DSaE0zCFrWbn-yTajx72G0BZdUw9g@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] vhost-user: Add VIRTIO Shared Memory map request
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 slp@redhat.com, hi@alyssa.is, mst@redhat.com, jasowang@redhat.com, 
 stefanha@redhat.com, Stefano Garzarella <sgarzare@redhat.com>,
 stevensd@chromium.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=aesteve@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.93,
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

On Tue, Sep 17, 2024 at 12:08=E2=80=AFPM David Hildenbrand <david@redhat.co=
m> wrote:
>
> On 12.09.24 16:53, Albert Esteve wrote:
> > Add SHMEM_MAP/UNMAP requests to vhost-user to
> > handle VIRTIO Shared Memory mappings.
> >
> > This request allows backends to dynamically map
> > fds into a VIRTIO Shared Memory Region indentified
> > by its `shmid`. Then, the fd memory is advertised
> > to the driver as a base addres + offset, so it
> > can be read/written (depending on the mmap flags
> > requested) while its valid.
> >
> > The backend can munmap the memory range
> > in a given VIRTIO Shared Memory Region (again,
> > identified by its `shmid`), to free it. Upon
> > receiving this message, the front-end must
> > mmap the regions with PROT_NONE to reserve
> > the virtual memory space.
> >
> > The device model needs to create MemoryRegion
> > instances for the VIRTIO Shared Memory Regions
> > and add them to the `VirtIODevice` instance.
> >
> > Signed-off-by: Albert Esteve <aesteve@redhat.com>
> > ---
> >   hw/virtio/vhost-user.c                    | 122 +++++++++++++++++++++=
+
> >   hw/virtio/virtio.c                        |  13 +++
> >   include/hw/virtio/virtio.h                |   5 +
> >   subprojects/libvhost-user/libvhost-user.c |  60 +++++++++++
> >   subprojects/libvhost-user/libvhost-user.h |  52 +++++++++
> >   5 files changed, 252 insertions(+)
> >
> > diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> > index 00561daa06..338cc942ec 100644
> > --- a/hw/virtio/vhost-user.c
> > +++ b/hw/virtio/vhost-user.c
> > @@ -115,6 +115,8 @@ typedef enum VhostUserBackendRequest {
> >       VHOST_USER_BACKEND_SHARED_OBJECT_ADD =3D 6,
> >       VHOST_USER_BACKEND_SHARED_OBJECT_REMOVE =3D 7,
> >       VHOST_USER_BACKEND_SHARED_OBJECT_LOOKUP =3D 8,
> > +    VHOST_USER_BACKEND_SHMEM_MAP =3D 9,
> > +    VHOST_USER_BACKEND_SHMEM_UNMAP =3D 10,
> >       VHOST_USER_BACKEND_MAX
> >   }  VhostUserBackendRequest;
> >
> > @@ -192,6 +194,24 @@ typedef struct VhostUserShared {
> >       unsigned char uuid[16];
> >   } VhostUserShared;
> >
> > +/* For the flags field of VhostUserMMap */
> > +#define VHOST_USER_FLAG_MAP_R (1u << 0)
> > +#define VHOST_USER_FLAG_MAP_W (1u << 1)
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
> > +    /* Flags for the mmap operation, from VHOST_USER_FLAG_* */
> > +    uint64_t flags;
> > +} VhostUserMMap;
> > +
> >   typedef struct {
> >       VhostUserRequest request;
> >
> > @@ -224,6 +244,7 @@ typedef union {
> >           VhostUserInflight inflight;
> >           VhostUserShared object;
> >           VhostUserTransferDeviceState transfer_state;
> > +        VhostUserMMap mmap;
> >   } VhostUserPayload;
> >
> >   typedef struct VhostUserMsg {
> > @@ -1749,6 +1770,100 @@ vhost_user_backend_handle_shared_object_lookup(=
struct vhost_user *u,
> >       return 0;
> >   }
> >
> > +static int
> > +vhost_user_backend_handle_shmem_map(struct vhost_dev *dev,
> > +                                    VhostUserMMap *vu_mmap,
> > +                                    int fd)
> > +{
> > +    void *addr =3D 0;
> > +    MemoryRegion *mr =3D NULL;
> > +
> > +    if (fd < 0) {
> > +        error_report("Bad fd for map");
> > +        return -EBADF;
> > +    }
> > +
> > +    if (!dev->vdev->shmem_list ||
> > +        dev->vdev->n_shmem_regions <=3D vu_mmap->shmid) {
> > +        error_report("Device only has %d VIRTIO Shared Memory Regions.=
 "
> > +                     "Requested ID: %d",
> > +                     dev->vdev->n_shmem_regions, vu_mmap->shmid);
> > +        return -EFAULT;
> > +    }
> > +
> > +    mr =3D &dev->vdev->shmem_list[vu_mmap->shmid];
> > +
> > +    if (!mr) {
> > +        error_report("VIRTIO Shared Memory Region at "
> > +                     "ID %d unitialized", vu_mmap->shmid);
> > +        return -EFAULT;
> > +    }
> > +
> > +    if ((vu_mmap->shm_offset + vu_mmap->len) < vu_mmap->len ||
> > +        (vu_mmap->shm_offset + vu_mmap->len) > mr->size) {
> > +        error_report("Bad offset/len for mmap %" PRIx64 "+%" PRIx64,
> > +                     vu_mmap->shm_offset, vu_mmap->len);
> > +        return -EFAULT;
> > +    }
> > +
> > +    void *shmem_ptr =3D memory_region_get_ram_ptr(mr);
> > +
> > +    addr =3D mmap(shmem_ptr + vu_mmap->shm_offset, vu_mmap->len,
> > +        ((vu_mmap->flags & VHOST_USER_FLAG_MAP_R) ? PROT_READ : 0) |
> > +        ((vu_mmap->flags & VHOST_USER_FLAG_MAP_W) ? PROT_WRITE : 0),
> > +        MAP_SHARED | MAP_FIXED, fd, vu_mmap->fd_offset);
> > +
>
> I'm sorry, but that looks completely wrong. You cannot just take some
> RAM memory region/ RAMBlock that has properly set flags/fd/whatssoever
> and map whatever you want in there.
>
> Likely you would need a distinct RAMBlock/RAM memory region per mmap(),
> and would end up mmaping implicitly via qemu_ram_mmap().
>
> Then, your shared region would simply be an empty container into which
> you map these RAM memory regions.

Hi, sorry it took me so long to get back to this. Lately I have been
testing the patch and fixing bugs, and I am was going to add some
tests to be able to verify the patch without having to use a backend
(which is what I am doing right now).

But I wanted to address/discuss this comment. I am not sure of the
actual problem with the current approach (I am not completely aware of
the concern in your first paragraph), but I see other instances where
qemu mmaps stuff into a MemoryRegion. Take into account that the
implementation follows the definition of shared memory region here:
https://docs.oasis-open.org/virtio/virtio/v1.3/csd01/virtio-v1.3-csd01.html=
#x1-10200010
Which hints to a memory region per ID, not one per required map. So
the current strategy seems to fit it better.

Also, I was aware that I was not the first one attempting this, so I
based this code in previous attempts (maybe I should give credit in
the commit now that I think of):
https://gitlab.com/virtio-fs/qemu/-/blob/qemu5.0-virtiofs-dax/hw/virtio/vho=
st-user-fs.c?ref_type=3Dheads#L75
As you can see, it pretty much follows the same strategy. And in my
examples I have been able to use this to video stream with multiple
queues mapped into the shared memory (used to capture video frames),
using the backend I mentioned above for testing. So the concept works.
I may be wrong with this, but for what I understood looking at the
code, crosvm uses a similar strategy. Reserve a memory block and use
for all your mappings, and use an allocator to find a free slot.

And if I were to do what you say, those distinct RAMBlocks should be
created when the device starts? What would be their size? Should I
create them when qemu receives a request to mmap? How would the driver
find the RAMBlock?

BR,
Albert.

>
> --
> Cheers,
>
> David / dhildenb
>


