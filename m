Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EFADCCD195
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 14:22:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9Oqa-0003bz-Ij; Thu, 16 Oct 2025 10:20:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1v9OqW-0003aQ-9v
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 10:20:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1v9OqE-0001tQ-Gr
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 10:20:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760624426;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dbrDXg/W6Q2eGmoYaLgPi61zMam+X14T3VjW1n7EA+0=;
 b=HLcQ3cunSBvn8RNgefeKcrLXzDWuU4bLAGBwvXo0rLbfbt1JKUfq69qLj+Z5YlEYrMnYMp
 AV8YxVh/7pdmG/7pPkcp/+8ThjSbPqKr6YBMZYYPu4qT4nfEHAS5npmal2yD2CmazUsmrN
 qAkeUZQPmj52lgjJz7EPbc9n6BeQ6Xo=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-538-QDWGf54UOymyqZxk2C0wHA-1; Thu, 16 Oct 2025 10:20:23 -0400
X-MC-Unique: QDWGf54UOymyqZxk2C0wHA-1
X-Mimecast-MFC-AGG-ID: QDWGf54UOymyqZxk2C0wHA_1760624422
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-269af520712so11052105ad.2
 for <qemu-devel@nongnu.org>; Thu, 16 Oct 2025 07:20:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760624422; x=1761229222;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dbrDXg/W6Q2eGmoYaLgPi61zMam+X14T3VjW1n7EA+0=;
 b=e0NMKtbXU3FslUmS4ArDAu2V4K1WlBnFKyZDRqPOK2ctffybp/+Wdc/Cn4AsRpD46s
 T6tMj5ANA8rMY5wQkaIdI+cQtnuplpqiz1FyZqM/959Fmkx/+QuXt/ecJuvoEkyrhFwj
 dCdZDp4nzYX4uRY2FwGWXJzhHGUUE2yuwrmzW5V1XIGezy7ocnz3NPhylJhOH346DQ65
 TWapgQSjxdPt+7p2GQfZW1/VbKhPnOPTQ+7PlxKKATTEY/NeUROvaPPWLXc7jcUzv77i
 XgoY0AeZYKNoGsrxV3+h/XyXAjCbp26kJVoWe07etrt3rU+xqaxvsLXnmFl/irR91Vci
 O++g==
X-Gm-Message-State: AOJu0Yy7ADJ+EGOMRaLMXUUuQG1Xb9pCdruB6QXFs963/kHENrmg7MOD
 DYkzq3xegeqdEfbP3JEJ50HUClE32GZDwTxp0n8xLOZbBqqLXTPj61jOdgjQ01EFEwMb4Gjgy8O
 7hepvH1RDvzxWonxDaQ3AzajarM926M2vDBcjv/wMDZKGeo5vgG03BGBnsBoMd3mEuEtjcNE7hA
 oInrGkmlYRrTsiwDKTk3KFZ4Ov7nRy0W0=
X-Gm-Gg: ASbGncs/zUOhSQAVKp9vWvAjQBxN/A6GMHQgtHXV020RznpvfkfKIM1GkAhLCtH1Evj
 /xxGZVNJX7HXYgDOw+iOxiuLQBdS3wtMGbYQj1IvbpBAYuS/dQ8gPDwaEZ96FqqXmFsn8bAUWvd
 yxjZRLvzfSO89VSFd+FHh9tdsfWZx5KXWX1ckShzRTSZLigrstAec=
X-Received: by 2002:a17:903:2f8f:b0:26c:87f9:9ea7 with SMTP id
 d9443c01a7336-290cba42a18mr1347655ad.59.1760624421595; 
 Thu, 16 Oct 2025 07:20:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHP+ZggkodUn1Om6vuZKVgpT6KK8zR5C9y95ExQoAF7wunFpkh8LXw3Q49Sc3wKEsFfWsRRF5x7reZnqlixiyk=
X-Received: by 2002:a17:903:2f8f:b0:26c:87f9:9ea7 with SMTP id
 d9443c01a7336-290cba42a18mr1347145ad.59.1760624420891; Thu, 16 Oct 2025
 07:20:20 -0700 (PDT)
MIME-Version: 1.0
References: <20251015085930.1517330-1-aesteve@redhat.com>
 <20251015085930.1517330-2-aesteve@redhat.com>
 <t463fw.3mc67qnkdgiyh@linaro.org>
 <CADSE00+P+eHhMHvi84=3QZE6e5Og-C8tCYz2WcmHoYUYOmf9iA@mail.gmail.com>
 <t46bp2.1d2hl63prsacu@linaro.org>
 <CADSE00J+xuaNGbrdR1_GnD8cnMej2Tkznjuy2M7VPathA0vNCQ@mail.gmail.com>
 <CAAjaMXZAa=couK4nzn50XoFa8KYsHg_CiHzATu6gu3X+nyUANQ@mail.gmail.com>
In-Reply-To: <CAAjaMXZAa=couK4nzn50XoFa8KYsHg_CiHzATu6gu3X+nyUANQ@mail.gmail.com>
From: Albert Esteve <aesteve@redhat.com>
Date: Thu, 16 Oct 2025 16:20:09 +0200
X-Gm-Features: AS18NWDZ49-6ToyhAXoaRu6sRaraYwJeqmJhflJNiqiU7bD0vkUc-UqB0GS9Ut8
Message-ID: <CADSE00+1tB+voOammyivrRHSXC61fEYzBMQjJnfMBLqSt3Byzg@mail.gmail.com>
Subject: Re: [PATCH v9 1/7] vhost-user: Add VirtIO Shared Memory map request
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org, stevensd@chromium.org, jasowang@redhat.com, 
 Paolo Bonzini <pbonzini@redhat.com>, hi@alyssa.is,
 Laurent Vivier <lvivier@redhat.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, david@redhat.com, 
 Fabiano Rosas <farosas@suse.de>, "Michael S. Tsirkin" <mst@redhat.com>,
 stefanha@redhat.com, 
 Stefano Garzarella <sgarzare@redhat.com>, slp@redhat.com, dbassey@redhat.com
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
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Thu, Oct 16, 2025 at 3:54=E2=80=AFPM Manos Pitsidianakis
<manos.pitsidianakis@linaro.org> wrote:
>
> On Thu, Oct 16, 2025 at 4:43=E2=80=AFPM Albert Esteve <aesteve@redhat.com=
> wrote:
> >
> > On Wed, Oct 15, 2025 at 2:51=E2=80=AFPM Manos Pitsidianakis
> > <manos.pitsidianakis@linaro.org> wrote:
> > >
> > > On Wed, 15 Oct 2025 15:29, Albert Esteve <aesteve@redhat.com> wrote:
> > > >On Wed, Oct 15, 2025 at 11:52=E2=80=AFAM Manos Pitsidianakis
> > > ><manos.pitsidianakis@linaro.org> wrote:
> > > >>
> > > >> On Wed, 15 Oct 2025 11:59, Albert Esteve <aesteve@redhat.com> wrot=
e:
> > > >> >Add SHMEM_MAP/UNMAP requests to vhost-user for dynamic management=
 of
> > > >> >VIRTIO Shared Memory mappings.
> > > >> >
> > > >> >This implementation introduces VirtioSharedMemoryMapping as a uni=
fied
> > > >> >QOM object that manages both the mapping metadata and MemoryRegio=
n
> > > >> >lifecycle. This object provides reference-counted lifecycle manag=
ement
> > > >> >with automatic cleanup of file descriptors and memory regions
> > > >> >through QOM finalization.
> > > >> >
> > > >> >This request allows backends to dynamically map file descriptors =
into a
> > > >> >VIRTIO Shared Memory Region identified by their shmid. Maps are c=
reated
> > > >> >using memory_region_init_ram_from_fd() with configurable read/wri=
te
> > > >> >permissions, and the resulting MemoryRegions are added as subregi=
ons to
> > > >> >the shmem container region. The mapped memory is then advertised =
to the
> > > >> >guest VIRTIO drivers as a base address plus offset for reading an=
d
> > > >> >writting according to the requested mmap flags.
> > > >> >
> > > >> >The backend can unmap memory ranges within a given VIRTIO Shared =
Memory
> > > >> >Region to free resources. Upon receiving this message, the fronte=
nd
> > > >> >removes the MemoryRegion as a subregion and automatically unrefer=
ences
> > > >> >the VirtioSharedMemoryMapping object, triggering cleanup if no ot=
her
> > > >> >references exist.
> > > >> >
> > > >> >Error handling has been improved to ensure consistent behavior ac=
ross
> > > >> >handlers that manage their own vhost_user_send_resp() calls. Sinc=
e
> > > >> >these handlers clear the VHOST_USER_NEED_REPLY_MASK flag, explici=
t
> > > >> >error checking ensures proper connection closure on failures,
> > > >> >maintaining the expected error flow.
> > > >> >
> > > >> >Note the memory region commit for these operations needs to be de=
layed
> > > >> >until after we reply to the backend to avoid deadlocks. Otherwise=
,
> > > >> >the MemoryListener would send a VHOST_USER_SET_MEM_TABLE message
> > > >> >before the reply.
> > > >> >
> > > >> >Signed-off-by: Albert Esteve <aesteve@redhat.com>
> > > >> >---
> > > >> > hw/virtio/vhost-user.c                    | 213 ++++++++++++++++=
++++++
> > > >> > hw/virtio/virtio.c                        | 207 ++++++++++++++++=
+++++
> > > >> > include/hw/virtio/virtio.h                | 136 ++++++++++++++
> > > >> > subprojects/libvhost-user/libvhost-user.c |  70 +++++++
> > > >> > subprojects/libvhost-user/libvhost-user.h |  54 ++++++
> > > >> > 5 files changed, 680 insertions(+)
> > > >> >
> > > >> >diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> > > >> >index 36c9c2e04d..8a4385a5ad 100644
> > > >> >--- a/hw/virtio/vhost-user.c
> > > >> >+++ b/hw/virtio/vhost-user.c
> > > >> >@@ -115,6 +115,8 @@ typedef enum VhostUserBackendRequest {
> > > >> >     VHOST_USER_BACKEND_SHARED_OBJECT_ADD =3D 6,
> > > >> >     VHOST_USER_BACKEND_SHARED_OBJECT_REMOVE =3D 7,
> > > >> >     VHOST_USER_BACKEND_SHARED_OBJECT_LOOKUP =3D 8,
> > > >> >+    VHOST_USER_BACKEND_SHMEM_MAP =3D 9,
> > > >> >+    VHOST_USER_BACKEND_SHMEM_UNMAP =3D 10,
> > > >> >     VHOST_USER_BACKEND_MAX
> > > >> > }  VhostUserBackendRequest;
> > > >> >
> > > >> >@@ -192,6 +194,23 @@ typedef struct VhostUserShared {
> > > >> >     unsigned char uuid[16];
> > > >> > } VhostUserShared;
> > > >> >
> > > >> >+/* For the flags field of VhostUserMMap */
> > > >> >+#define VHOST_USER_FLAG_MAP_RW (1u << 0)
> > > >> >+
> > > >> >+typedef struct {
> > > >> >+    /* VIRTIO Shared Memory Region ID */
> > > >> >+    uint8_t shmid;
> > > >> >+    uint8_t padding[7];
> > > >> >+    /* File offset */
> > > >> >+    uint64_t fd_offset;
> > > >> >+    /* Offset within the VIRTIO Shared Memory Region */
> > > >> >+    uint64_t shm_offset;
> > > >> >+    /* Size of the mapping */
> > > >> >+    uint64_t len;
> > > >> >+    /* Flags for the mmap operation, from VHOST_USER_FLAG_MAP_* =
*/
> > > >> >+    uint64_t flags;
> > > >> >+} VhostUserMMap;
> > > >> >+
> > > >> > typedef struct {
> > > >> >     VhostUserRequest request;
> > > >> >
> > > >> >@@ -224,6 +243,7 @@ typedef union {
> > > >> >         VhostUserInflight inflight;
> > > >> >         VhostUserShared object;
> > > >> >         VhostUserTransferDeviceState transfer_state;
> > > >> >+        VhostUserMMap mmap;
> > > >> > } VhostUserPayload;
> > > >> >
> > > >> > typedef struct VhostUserMsg {
> > > >> >@@ -1768,6 +1788,186 @@ vhost_user_backend_handle_shared_object_l=
ookup(struct vhost_user *u,
> > > >> >     return 0;
> > > >> > }
> > > >> >
> > > >> >+/**
> > > >> >+ * vhost_user_backend_handle_shmem_map() - Handle SHMEM_MAP back=
end request
> > > >> >+ * @dev: vhost device
> > > >> >+ * @ioc: QIOChannel for communication
> > > >> >+ * @hdr: vhost-user message header
> > > >> >+ * @payload: message payload containing mapping details
> > > >> >+ * @fd: file descriptor for the shared memory region
> > > >> >+ *
> > > >> >+ * Handles VHOST_USER_BACKEND_SHMEM_MAP requests from the backen=
d. Creates
> > > >> >+ * a VhostUserShmemObject to manage the shared memory mapping an=
d adds it
> > > >> >+ * to the appropriate VirtIO shared memory region. The VhostUser=
ShmemObject
> > > >> >+ * serves as an intermediate parent for the MemoryRegion, ensuri=
ng proper
> > > >> >+ * lifecycle management with reference counting.
> > > >> >+ *
> > > >> >+ * Returns: 0 on success, negative errno on failure
> > > >> >+ */
> > > >> >+static int
> > > >> >+vhost_user_backend_handle_shmem_map(struct vhost_dev *dev,
> > > >> >+                                    QIOChannel *ioc,
> > > >> >+                                    VhostUserHeader *hdr,
> > > >> >+                                    VhostUserPayload *payload,
> > > >> >+                                    int fd)
> > > >> >+{
> > > >> >+    VirtioSharedMemory *shmem;
> > > >> >+    VhostUserMMap *vu_mmap =3D &payload->mmap;
> > > >> >+    VirtioSharedMemoryMapping *existing;
> > > >> >+    Error *local_err =3D NULL;
> > > >> >+    int ret =3D 0;
> > > >> >+
> > > >> >+    if (fd < 0) {
> > > >> >+        error_report("Bad fd for map");
> > > >> >+        ret =3D -EBADF;
> > > >> >+        goto send_reply;
> > > >>
> > > >> Apologies if I missed something obvious, but won't going to send_r=
eply
> > > >> at this point cause memory_region_transaction_commit() to be calle=
d?
> > > >> Maybe we should have two cleanup labels, depending on whether
> > > >> memory_region_transaction_begin() has been called yet?
> > > >
> > > >You are right, this is not good, at transaction_depth 0 it would fai=
l
> > > >an assertion within memory_region_transaction_commit().
> > > >
> > > >Not sure another cleanup label will work, though, as the transaction
> > > >commit has to go after the reply. Maybe we can make the reply within
> > > >the handler optional (leveraging the REPLY_MASK flag). But that will
> > > >need to be tuned when this patch lands:
> > > >https://lists.gnu.org/archive/html/qemu-devel/2025-10/msg03632.html
> > > >
> > > >Or just a simpler solution like this would do?
> > >
> > >
> > > Yes this looks like enough. The another cleanup label alternative I
> > > meant would be to do:
> > >
> > > +send_reply_no_commit:
> > > +    if (hdr->flags & VHOST_USER_NEED_REPLY_MASK) {
> > > +        payload->u64 =3D !!ret;
> > > +        hdr->size =3D sizeof(payload->u64);
> > > +        if (!vhost_user_send_resp(ioc, hdr, payload, &local_err)) {
> > > +            error_report_err(local_err);
> > > +            return -EFAULT;
> > > +        }
> > > +    }
> > > +    return 0;
> > > +send_reply:
> > > +    if (hdr->flags & VHOST_USER_NEED_REPLY_MASK) {
> > > +        payload->u64 =3D !!ret;
> > > +        hdr->size =3D sizeof(payload->u64);
> > > +        if (!vhost_user_send_resp(ioc, hdr, payload, &local_err)) {
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
> > >
> > > But this is not much prettier. (In rust this would be trivial with a =
MR
> > > transaction RAII object...)
> >
> > I tried this solution too and it fails with `Illegal instruction (core
> > dumped)`. I am not sure why, the logic should be basically the same.
> > It has me puzzled.
> >
> > So... I'll use the boolean variable solution. That one seems to work fi=
ne.
>
> Sounds like you're hitting the abort, because `send_reply_no_commit`
> is first, and it runs on success (it should be after `send_reply`).
> Oops :)

Ah right! I was so centered on the goto's that I didn't see that the
success run doesn't go through them. I spent more time that I'd like
to admit trying to see where it went south.
Well, thanks! Then I'll switch and go with the label solution instead :)

>
> >
> > >
> > > >
> > > >diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> > > >index c39cf52dbc..46126eed3b 100644
> > > >--- a/hw/virtio/vhost-user.c
> > > >+++ b/hw/virtio/vhost-user.c
> > > >@@ -1824,6 +1824,7 @@ vhost_user_backend_handle_shmem_map(struct vho=
st_dev *dev,
> > > >     VirtioSharedMemoryMapping *existing;
> > > >     Error *local_err =3D NULL;
> > > >     int ret =3D 0;
> > > >+    bool transaction_started =3D false;
> > > >
> > > >     if (fd < 0) {
> > > >         error_report("Bad fd for map");
> > > >@@ -1864,6 +1865,7 @@ vhost_user_backend_handle_shmem_map(struct vho=
st_dev *dev,
> > > >     }
> > > >
> > > >     memory_region_transaction_begin();
> > > >+    transaction_started =3D true;
> > > >
> > > >     /* Create VirtioSharedMemoryMapping object */
> > > >     VirtioSharedMemoryMapping *mapping =3D virtio_shared_memory_map=
ping_new(
> > > >@@ -1889,14 +1891,18 @@ send_reply:
> > > >         hdr->size =3D sizeof(payload->u64);
> > > >         if (!vhost_user_send_resp(ioc, hdr, payload, &local_err)) {
> > > >             error_report_err(local_err);
> > > >-            memory_region_transaction_commit();
> > > >+            if (transaction_started) {
> > > >+                memory_region_transaction_commit();
> > > >+            }
> > > >             return -EFAULT;
> > > >         }
> > > >     }
> > > >
> > > >-    memory_region_transaction_commit();
> > > >-
> > > >-    return 0;
> > > >+    /* Only commit if we started a transaction */
> > > >+    if (transaction_started) {
> > > >+        memory_region_transaction_commit();
> > > >+    }
> > > >+    return ret;
> > > > }
> > > >
> > > >>
> > > >> >+    }
> > > >> >+
> > > >> >+    if (QSIMPLEQ_EMPTY(&dev->vdev->shmem_list)) {
> > > >> >+        error_report("Device has no VIRTIO Shared Memory Regions=
. "
> > > >> >+                     "Requested ID: %d", vu_mmap->shmid);
> > > >> >+        ret =3D -EFAULT;
> > > >> >+        goto send_reply;
> > > >> >+    }
> > > >> >+
> > > >> >+    shmem =3D virtio_find_shmem_region(dev->vdev, vu_mmap->shmid=
);
> > > >> >+    if (!shmem) {
> > > >> >+        error_report("VIRTIO Shared Memory Region at "
> > > >> >+                     "ID %d not found or uninitialized", vu_mmap=
->shmid);
> > > >> >+        ret =3D -EFAULT;
> > > >> >+        goto send_reply;
> > > >> >+    }
> > > >> >+
> > > >> >+    if ((vu_mmap->shm_offset + vu_mmap->len) < vu_mmap->len ||
> > > >> >+        (vu_mmap->shm_offset + vu_mmap->len) > shmem->mr.size) {
> > > >> >+        error_report("Bad offset/len for mmap %" PRIx64 "+%" PRI=
x64,
> > > >> >+                     vu_mmap->shm_offset, vu_mmap->len);
> > > >> >+        ret =3D -EFAULT;
> > > >> >+        goto send_reply;
> > > >> >+    }
> > > >> >+
> > > >> >+    QTAILQ_FOREACH(existing, &shmem->mmaps, link) {
> > > >> >+        if (ranges_overlap(existing->offset, existing->len,
> > > >> >+                           vu_mmap->shm_offset, vu_mmap->len)) {
> > > >> >+            error_report("VIRTIO Shared Memory mapping overlap")=
;
> > > >> >+            ret =3D -EFAULT;
> > > >> >+            goto send_reply;
> > > >> >+        }
> > > >> >+    }
> > > >> >+
> > > >> >+    memory_region_transaction_begin();
> > > >> >+
> > > >> >+    /* Create VirtioSharedMemoryMapping object */
> > > >> >+    VirtioSharedMemoryMapping *mapping =3D virtio_shared_memory_=
mapping_new(
> > > >> >+        vu_mmap->shmid, fd, vu_mmap->fd_offset, vu_mmap->shm_off=
set,
> > > >> >+        vu_mmap->len, vu_mmap->flags & VHOST_USER_FLAG_MAP_RW);
> > > >> >+
> > > >> >+    if (!mapping) {
> > > >> >+        ret =3D -EFAULT;
> > > >> >+        goto send_reply;
> > > >> >+    }
> > > >> >+
> > > >> >+    /* Add the mapping to the shared memory region */
> > > >> >+    if (virtio_add_shmem_map(shmem, mapping) !=3D 0) {
> > > >> >+        error_report("Failed to add shared memory mapping");
> > > >> >+        object_unref(OBJECT(mapping));
> > > >> >+        ret =3D -EFAULT;
> > > >> >+        goto send_reply;
> > > >> >+    }
> > > >> >+
> > > >> >+send_reply:
> > > >> >+    if (hdr->flags & VHOST_USER_NEED_REPLY_MASK) {
> > > >> >+        payload->u64 =3D !!ret;
> > > >> >+        hdr->size =3D sizeof(payload->u64);
> > > >> >+        if (!vhost_user_send_resp(ioc, hdr, payload, &local_err)=
) {
> > > >> >+            error_report_err(local_err);
> > > >> >+            memory_region_transaction_commit();
> > > >> >+            return -EFAULT;
> > > >> >+        }
> > > >> >+    }
> > > >> >+
> > > >> >+    memory_region_transaction_commit();
> > > >> >+
> > > >> >+    return 0;
> > > >> >+}
> > > >> >+
> > > >> >+/**
> > > >> >+ * vhost_user_backend_handle_shmem_unmap() - Handle SHMEM_UNMAP =
backend request
> > > >> >+ * @dev: vhost device
> > > >> >+ * @ioc: QIOChannel for communication
> > > >> >+ * @hdr: vhost-user message header
> > > >> >+ * @payload: message payload containing unmapping details
> > > >> >+ *
> > > >> >+ * Handles VHOST_USER_BACKEND_SHMEM_UNMAP requests from the back=
end. Removes
> > > >> >+ * the specified memory mapping from the VirtIO shared memory re=
gion. This
> > > >> >+ * automatically unreferences the associated VhostUserShmemObjec=
t, which may
> > > >> >+ * trigger its finalization and cleanup (munmap, close fd) if no=
 other
> > > >> >+ * references exist.
> > > >> >+ *
> > > >> >+ * Returns: 0 on success, negative errno on failure
> > > >> >+ */
> > > >> >+static int
> > > >> >+vhost_user_backend_handle_shmem_unmap(struct vhost_dev *dev,
> > > >> >+                                      QIOChannel *ioc,
> > > >> >+                                      VhostUserHeader *hdr,
> > > >> >+                                      VhostUserPayload *payload)
> > > >> >+{
> > > >> >+    VirtioSharedMemory *shmem;
> > > >> >+    VirtioSharedMemoryMapping *mmap =3D NULL;
> > > >> >+    VhostUserMMap *vu_mmap =3D &payload->mmap;
> > > >> >+    Error *local_err =3D NULL;
> > > >> >+    int ret =3D 0;
> > > >> >+
> > > >> >+    if (QSIMPLEQ_EMPTY(&dev->vdev->shmem_list)) {
> > > >> >+        error_report("Device has no VIRTIO Shared Memory Regions=
. "
> > > >> >+                     "Requested ID: %d", vu_mmap->shmid);
> > > >> >+        ret =3D -EFAULT;
> > > >> >+        goto send_reply;
> > > >> >+    }
> > > >> >+
> > > >> >+    shmem =3D virtio_find_shmem_region(dev->vdev, vu_mmap->shmid=
);
> > > >> >+    if (!shmem) {
> > > >> >+        error_report("VIRTIO Shared Memory Region at "
> > > >> >+                     "ID %d not found or uninitialized", vu_mmap=
->shmid);
> > > >> >+        ret =3D -EFAULT;
> > > >> >+        goto send_reply;
> > > >> >+    }
> > > >> >+
> > > >> >+    if ((vu_mmap->shm_offset + vu_mmap->len) < vu_mmap->len ||
> > > >> >+        (vu_mmap->shm_offset + vu_mmap->len) > shmem->mr.size) {
> > > >> >+        error_report("Bad offset/len for unmmap %" PRIx64 "+%" P=
RIx64,
> > > >> >+                     vu_mmap->shm_offset, vu_mmap->len);
> > > >> >+        ret =3D -EFAULT;
> > > >> >+        goto send_reply;
> > > >> >+    }
> > > >> >+
> > > >> >+    mmap =3D virtio_find_shmem_map(shmem, vu_mmap->shm_offset, v=
u_mmap->len);
> > > >> >+    if (!mmap) {
> > > >> >+        error_report("Shared memory mapping not found at offset =
%" PRIx64
> > > >> >+                     " with length %" PRIx64,
> > > >> >+                     vu_mmap->shm_offset, vu_mmap->len);
> > > >> >+        ret =3D -EFAULT;
> > > >> >+        goto send_reply;
> > > >> >+    }
> > > >> >+
> > > >> >+send_reply:
> > > >> >+    if (hdr->flags & VHOST_USER_NEED_REPLY_MASK) {
> > > >> >+        payload->u64 =3D !!ret;
> > > >> >+        hdr->size =3D sizeof(payload->u64);
> > > >> >+        if (!vhost_user_send_resp(ioc, hdr, payload, &local_err)=
) {
> > > >> >+            error_report_err(local_err);
> > > >> >+            return -EFAULT;
> > > >> >+        }
> > > >> >+    }
> > > >> >+
> > > >> >+    if (!ret && mmap) {
> > > >> >+        /* Free the MemoryRegion only after reply */
> > > >> >+        virtio_del_shmem_map(shmem, vu_mmap->shm_offset, vu_mmap=
->len);
> > > >> >+    }
> > > >> >+
> > > >> >+    return 0;
> > > >> >+}
> > > >> >+
> > > >> > static void close_backend_channel(struct vhost_user *u)
> > > >> > {
> > > >> >     g_source_destroy(u->backend_src);
> > > >> >@@ -1836,6 +2036,19 @@ static gboolean backend_read(QIOChannel *i=
oc, GIOCondition condition,
> > > >> >         ret =3D vhost_user_backend_handle_shared_object_lookup(d=
ev->opaque, ioc,
> > > >> >                                                              &hd=
r, &payload);
> > > >> >         break;
> > > >> >+    case VHOST_USER_BACKEND_SHMEM_MAP:
> > > >> >+        /* Handler manages its own response, check error and clo=
se connection */
> > > >> >+        if (vhost_user_backend_handle_shmem_map(dev, ioc, &hdr, =
&payload,
> > > >> >+                                                fd ? fd[0] : -1)=
 < 0) {
> > > >> >+            goto err;
> > > >> >+        }
> > > >> >+        break;
> > > >> >+    case VHOST_USER_BACKEND_SHMEM_UNMAP:
> > > >> >+        /* Handler manages its own response, check error and clo=
se connection */
> > > >> >+        if (vhost_user_backend_handle_shmem_unmap(dev, ioc, &hdr=
, &payload) < 0) {
> > > >> >+            goto err;
> > > >> >+        }
> > > >> >+        break;
> > > >> >     default:
> > > >> >         error_report("Received unexpected msg type: %d.", hdr.re=
quest);
> > > >> >         ret =3D -EINVAL;
> > > >> >diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> > > >> >index 153ee0a0cf..37070e7951 100644
> > > >> >--- a/hw/virtio/virtio.c
> > > >> >+++ b/hw/virtio/virtio.c
> > > >> >@@ -3086,6 +3086,181 @@ int virtio_save(VirtIODevice *vdev, QEMUF=
ile *f)
> > > >> >     return vmstate_save_state(f, &vmstate_virtio, vdev, NULL, &e=
rror_fatal);
> > > >> > }
> > > >> >
> > > >> >+VirtioSharedMemory *virtio_new_shmem_region(VirtIODevice *vdev, =
uint8_t shmid, uint64_t size)
> > > >> >+{
> > > >> >+    VirtioSharedMemory *elem;
> > > >> >+    g_autofree char *name =3D NULL;
> > > >> >+
> > > >> >+    elem =3D g_new0(VirtioSharedMemory, 1);
> > > >> >+    elem->shmid =3D shmid;
> > > >> >+
> > > >> >+    /* Initialize embedded MemoryRegion as container for shmem m=
appings */
> > > >> >+    name =3D g_strdup_printf("virtio-shmem-%d", shmid);
> > > >> >+    memory_region_init(&elem->mr, OBJECT(vdev), name, size);
> > > >> >+    QTAILQ_INIT(&elem->mmaps);
> > > >> >+    QSIMPLEQ_INSERT_TAIL(&vdev->shmem_list, elem, entry);
> > > >> >+    return elem;
> > > >> >+}
> > > >> >+
> > > >> >+VirtioSharedMemory *virtio_find_shmem_region(VirtIODevice *vdev,=
 uint8_t shmid)
> > > >> >+{
> > > >> >+    VirtioSharedMemory *shmem, *next;
> > > >> >+    QSIMPLEQ_FOREACH_SAFE(shmem, &vdev->shmem_list, entry, next)=
 {
> > > >> >+        if (shmem->shmid =3D=3D shmid) {
> > > >> >+            return shmem;
> > > >> >+        }
> > > >> >+    }
> > > >> >+    return NULL;
> > > >> >+}
> > > >> >+
> > > >> >+static void virtio_shared_memory_mapping_instance_init(Object *o=
bj)
> > > >> >+{
> > > >> >+    VirtioSharedMemoryMapping *mapping =3D VIRTIO_SHARED_MEMORY_=
MAPPING(obj);
> > > >> >+
> > > >> >+    mapping->shmid =3D 0;
> > > >> >+    mapping->fd =3D -1;
> > > >> >+    mapping->offset =3D 0;
> > > >> >+    mapping->len =3D 0;
> > > >> >+    mapping->mr =3D NULL;
> > > >> >+}
> > > >> >+
> > > >> >+static void virtio_shared_memory_mapping_instance_finalize(Objec=
t *obj)
> > > >> >+{
> > > >> >+    VirtioSharedMemoryMapping *mapping =3D VIRTIO_SHARED_MEMORY_=
MAPPING(obj);
> > > >> >+
> > > >> >+    /* Clean up MemoryRegion if it exists */
> > > >> >+    if (mapping->mr) {
> > > >> >+        /* Unparent the MemoryRegion to trigger cleanup */
> > > >> >+        object_unparent(OBJECT(mapping->mr));
> > > >> >+        mapping->mr =3D NULL;
> > > >> >+    }
> > > >> >+
> > > >> >+    /* Close file descriptor */
> > > >> >+    if (mapping->fd >=3D 0) {
> > > >> >+        close(mapping->fd);
> > > >> >+        mapping->fd =3D -1;
> > > >> >+    }
> > > >> >+}
> > > >> >+
> > > >> >+VirtioSharedMemoryMapping *virtio_shared_memory_mapping_new(uint=
8_t shmid,
> > > >> >+                                                            int =
fd,
> > > >> >+                                                            uint=
64_t fd_offset,
> > > >> >+                                                            uint=
64_t shm_offset,
> > > >> >+                                                            uint=
64_t len,
> > > >> >+                                                            bool=
 allow_write)
> > > >> >+{
> > > >> >+    VirtioSharedMemoryMapping *mapping;
> > > >> >+    MemoryRegion *mr;
> > > >> >+    g_autoptr(GString) mr_name =3D g_string_new(NULL);
> > > >> >+    uint32_t ram_flags;
> > > >> >+    Error *local_err =3D NULL;
> > > >> >+
> > > >> >+    if (len =3D=3D 0) {
> > > >> >+        error_report("Shared memory mapping size cannot be zero"=
);
> > > >> >+        return NULL;
> > > >> >+    }
> > > >> >+
> > > >> >+    fd =3D dup(fd);
> > > >> >+    if (fd < 0) {
> > > >> >+        error_report("Failed to duplicate fd: %s", strerror(errn=
o));
> > > >> >+        return NULL;
> > > >> >+    }
> > > >> >+
> > > >> >+    /* Determine RAM flags */
> > > >> >+    ram_flags =3D RAM_SHARED;
> > > >> >+    if (!allow_write) {
> > > >> >+        ram_flags |=3D RAM_READONLY_FD;
> > > >> >+    }
> > > >> >+
> > > >> >+    /* Create the VirtioSharedMemoryMapping */
> > > >> >+    mapping =3D VIRTIO_SHARED_MEMORY_MAPPING(
> > > >> >+        object_new(TYPE_VIRTIO_SHARED_MEMORY_MAPPING));
> > > >> >+
> > > >> >+    /* Set up object properties */
> > > >> >+    mapping->shmid =3D shmid;
> > > >> >+    mapping->fd =3D fd;
> > > >> >+    mapping->offset =3D shm_offset;
> > > >> >+    mapping->len =3D len;
> > > >> >+
> > > >> >+    /* Create MemoryRegion as a child of this object */
> > > >> >+    mr =3D g_new0(MemoryRegion, 1);
> > > >> >+    g_string_printf(mr_name, "virtio-shmem-%d-%" PRIx64, shmid, =
shm_offset);
> > > >> >+
> > > >> >+    /* Initialize MemoryRegion with file descriptor */
> > > >> >+    if (!memory_region_init_ram_from_fd(mr, OBJECT(mapping), mr_=
name->str,
> > > >> >+                                        len, ram_flags, fd, fd_o=
ffset,
> > > >> >+                                        &local_err)) {
> > > >> >+        error_report_err(local_err);
> > > >> >+        g_free(mr);
> > > >> >+        close(fd);
> > > >> >+        object_unref(OBJECT(mapping));
> > > >> >+        return NULL;
> > > >> >+    }
> > > >> >+
> > > >> >+    mapping->mr =3D mr;
> > > >> >+    return mapping;
> > > >> >+}
> > > >> >+
> > > >> >+int virtio_add_shmem_map(VirtioSharedMemory *shmem,
> > > >> >+                         VirtioSharedMemoryMapping *mapping)
> > > >> >+{
> > > >> >+    if (!mapping) {
> > > >> >+        error_report("VirtioSharedMemoryMapping cannot be NULL")=
;
> > > >> >+        return -1;
> > > >> >+    }
> > > >> >+    if (!mapping->mr) {
> > > >> >+        error_report("VirtioSharedMemoryMapping has no MemoryReg=
ion");
> > > >> >+        return -1;
> > > >> >+    }
> > > >> >+
> > > >> >+    /* Validate boundaries against the VIRTIO shared memory regi=
on */
> > > >> >+    if (mapping->offset + mapping->len > shmem->mr.size) {
> > > >> >+        error_report("Memory exceeds the shared memory boundarie=
s");
> > > >> >+        return -1;
> > > >> >+    }
> > > >> >+
> > > >> >+    /* Add as subregion to the VIRTIO shared memory */
> > > >> >+    memory_region_add_subregion(&shmem->mr, mapping->offset, map=
ping->mr);
> > > >> >+
> > > >> >+    /* Add to the mapped regions list */
> > > >> >+    QTAILQ_INSERT_TAIL(&shmem->mmaps, mapping, link);
> > > >> >+
> > > >> >+    return 0;
> > > >> >+}
> > > >> >+
> > > >> >+VirtioSharedMemoryMapping *virtio_find_shmem_map(VirtioSharedMem=
ory *shmem,
> > > >> >+                                          hwaddr offset, uint64_=
t size)
> > > >> >+{
> > > >> >+    VirtioSharedMemoryMapping *mapping;
> > > >> >+    QTAILQ_FOREACH(mapping, &shmem->mmaps, link) {
> > > >> >+        if (mapping->offset =3D=3D offset && mapping->mr->size =
=3D=3D size) {
> > > >> >+            return mapping;
> > > >> >+        }
> > > >> >+    }
> > > >> >+    return NULL;
> > > >> >+}
> > > >> >+
> > > >> >+void virtio_del_shmem_map(VirtioSharedMemory *shmem, hwaddr offs=
et,
> > > >> >+                          uint64_t size)
> > > >> >+{
> > > >> >+    VirtioSharedMemoryMapping *mapping =3D virtio_find_shmem_map=
(shmem, offset, size);
> > > >> >+    if (mapping =3D=3D NULL) {
> > > >> >+        return;
> > > >> >+    }
> > > >> >+
> > > >> >+    /*
> > > >> >+     * Remove from memory region first
> > > >> >+     */
> > > >> >+    memory_region_del_subregion(&shmem->mr, mapping->mr);
> > > >> >+
> > > >> >+    /*
> > > >> >+     * Remove from list and unref the mapping which will trigger=
 automatic cleanup
> > > >> >+     * when the reference count reaches zero.
> > > >> >+     */
> > > >> >+    QTAILQ_REMOVE(&shmem->mmaps, mapping, link);
> > > >> >+    object_unref(OBJECT(mapping));
> > > >> >+}
> > > >> >+
> > > >> > /* A wrapper for use as a VMState .put function */
> > > >> > static int virtio_device_put(QEMUFile *f, void *opaque, size_t s=
ize,
> > > >> >                               const VMStateField *field, JSONWri=
ter *vmdesc)
> > > >> >@@ -3212,6 +3387,7 @@ void virtio_reset(void *opaque)
> > > >> > {
> > > >> >     VirtIODevice *vdev =3D opaque;
> > > >> >     VirtioDeviceClass *k =3D VIRTIO_DEVICE_GET_CLASS(vdev);
> > > >> >+    VirtioSharedMemory *shmem;
> > > >> >     uint64_t features[VIRTIO_FEATURES_NU64S];
> > > >> >     int i;
> > > >> >
> > > >> >@@ -3251,6 +3427,14 @@ void virtio_reset(void *opaque)
> > > >> >     for (i =3D 0; i < VIRTIO_QUEUE_MAX; i++) {
> > > >> >         __virtio_queue_reset(vdev, i);
> > > >> >     }
> > > >> >+
> > > >> >+    /* Mappings are removed to prevent stale fds from remaining =
open. */
> > > >> >+    QSIMPLEQ_FOREACH(shmem, &vdev->shmem_list, entry) {
> > > >> >+        while (!QTAILQ_EMPTY(&shmem->mmaps)) {
> > > >> >+            VirtioSharedMemoryMapping *mapping =3D QTAILQ_FIRST(=
&shmem->mmaps);
> > > >> >+            virtio_del_shmem_map(shmem, mapping->offset, mapping=
->mr->size);
> > > >> >+        }
> > > >> >+    }
> > > >> > }
> > > >> >
> > > >> > static void virtio_device_check_notification_compatibility(VirtI=
ODevice *vdev,
> > > >> >@@ -3574,6 +3758,7 @@ void virtio_init(VirtIODevice *vdev, uint16=
_t device_id, size_t config_size)
> > > >> >             NULL, virtio_vmstate_change, vdev);
> > > >> >     vdev->device_endian =3D virtio_default_endian();
> > > >> >     vdev->use_guest_notifier_mask =3D true;
> > > >> >+    QSIMPLEQ_INIT(&vdev->shmem_list);
> > > >> > }
> > > >> >
> > > >> > /*
> > > >> >@@ -4085,11 +4270,24 @@ static void virtio_device_free_virtqueues=
(VirtIODevice *vdev)
> > > >> > static void virtio_device_instance_finalize(Object *obj)
> > > >> > {
> > > >> >     VirtIODevice *vdev =3D VIRTIO_DEVICE(obj);
> > > >> >+    VirtioSharedMemory *shmem;
> > > >> >
> > > >> >     virtio_device_free_virtqueues(vdev);
> > > >> >
> > > >> >     g_free(vdev->config);
> > > >> >     g_free(vdev->vector_queues);
> > > >> >+    while (!QSIMPLEQ_EMPTY(&vdev->shmem_list)) {
> > > >> >+        shmem =3D QSIMPLEQ_FIRST(&vdev->shmem_list);
> > > >> >+        while (!QTAILQ_EMPTY(&shmem->mmaps)) {
> > > >> >+            VirtioSharedMemoryMapping *mapping =3D QTAILQ_FIRST(=
&shmem->mmaps);
> > > >> >+            virtio_del_shmem_map(shmem, mapping->offset, mapping=
->mr->size);
> > > >> >+        }
> > > >> >+
> > > >> >+        /* Clean up the embedded MemoryRegion */
> > > >> >+        object_unparent(OBJECT(&shmem->mr));
> > > >> >+        QSIMPLEQ_REMOVE_HEAD(&vdev->shmem_list, entry);
> > > >> >+        g_free(shmem);
> > > >> >+    }
> > > >> > }
> > > >> >
> > > >> > static const Property virtio_properties[] =3D {
> > > >> >@@ -4455,9 +4653,18 @@ static const TypeInfo virtio_device_info =
=3D {
> > > >> >     .class_size =3D sizeof(VirtioDeviceClass),
> > > >> > };
> > > >> >
> > > >> >+static const TypeInfo virtio_shared_memory_mapping_info =3D {
> > > >> >+    .name =3D TYPE_VIRTIO_SHARED_MEMORY_MAPPING,
> > > >> >+    .parent =3D TYPE_OBJECT,
> > > >> >+    .instance_size =3D sizeof(VirtioSharedMemoryMapping),
> > > >> >+    .instance_init =3D virtio_shared_memory_mapping_instance_ini=
t,
> > > >> >+    .instance_finalize =3D virtio_shared_memory_mapping_instance=
_finalize,
> > > >> >+};
> > > >> >+
> > > >> > static void virtio_register_types(void)
> > > >> > {
> > > >> >     type_register_static(&virtio_device_info);
> > > >> >+    type_register_static(&virtio_shared_memory_mapping_info);
> > > >> > }
> > > >> >
> > > >> > type_init(virtio_register_types)
> > > >> >diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virti=
o.h
> > > >> >index d97529c3f1..cee807e236 100644
> > > >> >--- a/include/hw/virtio/virtio.h
> > > >> >+++ b/include/hw/virtio/virtio.h
> > > >> >@@ -99,6 +99,46 @@ enum virtio_device_endian {
> > > >> >     VIRTIO_DEVICE_ENDIAN_BIG,
> > > >> > };
> > > >> >
> > > >> >+#define TYPE_VIRTIO_SHARED_MEMORY_MAPPING "virtio-shared-memory-=
mapping"
> > > >> >+OBJECT_DECLARE_SIMPLE_TYPE(VirtioSharedMemoryMapping, VIRTIO_SHA=
RED_MEMORY_MAPPING)
> > > >> >+
> > > >> >+/**
> > > >> >+ * VirtioSharedMemoryMapping:
> > > >> >+ * @parent: Parent QOM object
> > > >> >+ * @shmid: VIRTIO Shared Memory Region ID
> > > >> >+ * @fd: File descriptor for the shared memory region
> > > >> >+ * @offset: Offset within the VIRTIO Shared Memory Region
> > > >> >+ * @len: Size of the mapping
> > > >> >+ * @mr: MemoryRegion associated with this shared memory mapping
> > > >> >+ * @link: List entry for the shared memory region's mapping list
> > > >> >+ *
> > > >> >+ * A QOM object that represents an individual file descriptor-ba=
sed shared
> > > >> >+ * memory mapping within a VIRTIO Shared Memory Region. It manag=
es the
> > > >> >+ * MemoryRegion lifecycle and file descriptor cleanup through QO=
M reference
> > > >> >+ * counting. When the object is unreferenced and its reference c=
ount drops
> > > >> >+ * to zero, it automatically cleans up the MemoryRegion and clos=
es the file
> > > >> >+ * descriptor.
> > > >> >+ */
> > > >> >+struct VirtioSharedMemoryMapping {
> > > >> >+    Object parent;
> > > >> >+
> > > >> >+    uint8_t shmid;
> > > >> >+    int fd;
> > > >> >+    hwaddr offset;
> > > >> >+    uint64_t len;
> > > >> >+    MemoryRegion *mr;
> > > >> >+    QTAILQ_ENTRY(VirtioSharedMemoryMapping) link;
> > > >> >+};
> > > >> >+
> > > >> >+struct VirtioSharedMemory {
> > > >> >+    uint8_t shmid;
> > > >> >+    MemoryRegion mr;
> > > >> >+    QTAILQ_HEAD(, VirtioSharedMemoryMapping) mmaps;
> > > >> >+    QSIMPLEQ_ENTRY(VirtioSharedMemory) entry;
> > > >> >+};
> > > >> >+
> > > >> >+typedef struct VirtioSharedMemory VirtioSharedMemory;
> > > >> >+
> > > >> > /**
> > > >> >  * struct VirtIODevice - common VirtIO structure
> > > >> >  * @name: name of the device
> > > >> >@@ -168,6 +208,8 @@ struct VirtIODevice
> > > >> >      */
> > > >> >     EventNotifier config_notifier;
> > > >> >     bool device_iotlb_enabled;
> > > >> >+    /* Shared memory region for mappings. */
> > > >> >+    QSIMPLEQ_HEAD(, VirtioSharedMemory) shmem_list;
> > > >> > };
> > > >> >
> > > >> > struct VirtioDeviceClass {
> > > >> >@@ -298,6 +340,100 @@ void virtio_notify(VirtIODevice *vdev, Virt=
Queue *vq);
> > > >> >
> > > >> > int virtio_save(VirtIODevice *vdev, QEMUFile *f);
> > > >> >
> > > >> >+/**
> > > >> >+ * virtio_new_shmem_region() - Create a new shared memory region
> > > >> >+ * @vdev: VirtIODevice
> > > >> >+ * @shmid: Shared memory ID
> > > >> >+ * @size: Size of the shared memory region
> > > >> >+ *
> > > >> >+ * Creates a new VirtioSharedMemory region for the given device =
and ID.
> > > >> >+ * The returned VirtioSharedMemory is owned by the VirtIODevice =
and will
> > > >> >+ * be automatically freed when the device is destroyed. The call=
er
> > > >> >+ * should not free the returned pointer.
> > > >> >+ *
> > > >> >+ * Returns: Pointer to the new VirtioSharedMemory region, or NUL=
L on failure
> > > >> >+ */
> > > >> >+VirtioSharedMemory *virtio_new_shmem_region(VirtIODevice *vdev, =
uint8_t shmid, uint64_t size);
> > > >> >+
> > > >> >+/**
> > > >> >+ * virtio_find_shmem_region() - Find an existing shared memory r=
egion
> > > >> >+ * @vdev: VirtIODevice
> > > >> >+ * @shmid: Shared memory ID to find
> > > >> >+ *
> > > >> >+ * Finds an existing VirtioSharedMemory region by ID. The return=
ed pointer
> > > >> >+ * is owned by the VirtIODevice and should not be freed by the c=
aller.
> > > >> >+ *
> > > >> >+ * Returns: Pointer to the VirtioSharedMemory region, or NULL if=
 not found
> > > >> >+ */
> > > >> >+VirtioSharedMemory *virtio_find_shmem_region(VirtIODevice *vdev,=
 uint8_t shmid);
> > > >> >+
> > > >> >+/**
> > > >> >+ * virtio_shared_memory_mapping_new() - Create a new VirtioShare=
dMemoryMapping
> > > >> >+ * @shmid: VIRTIO Shared Memory Region ID
> > > >> >+ * @fd: File descriptor for the shared memory
> > > >> >+ * @fd_offset: Offset within the file descriptor
> > > >> >+ * @shm_offset: Offset within the VIRTIO Shared Memory Region
> > > >> >+ * @len: Size of the mapping
> > > >> >+ * @allow_write: Whether to allow write access to the mapping
> > > >> >+ *
> > > >> >+ * Creates a new VirtioSharedMemoryMapping that manages a shared=
 memory mapping.
> > > >> >+ * The object will create a MemoryRegion using memory_region_ini=
t_ram_from_fd()
> > > >> >+ * as a child object. When the object is finalized, it will auto=
matically
> > > >> >+ * clean up the MemoryRegion and close the file descriptor.
> > > >> >+ *
> > > >> >+ * Return: A new VirtioSharedMemoryMapping on success, NULL on e=
rror.
> > > >> >+ */
> > > >> >+VirtioSharedMemoryMapping *virtio_shared_memory_mapping_new(uint=
8_t shmid,
> > > >> >+                                                            int =
fd,
> > > >> >+                                                            uint=
64_t fd_offset,
> > > >> >+                                                            uint=
64_t shm_offset,
> > > >> >+                                                            uint=
64_t len,
> > > >> >+                                                            bool=
 allow_write);
> > > >> >+
> > > >> >+/**
> > > >> >+ * virtio_add_shmem_map() - Add a memory mapping to a shared reg=
ion
> > > >> >+ * @shmem: VirtioSharedMemory region
> > > >> >+ * @mapping: VirtioSharedMemoryMapping to add (transfers ownersh=
ip)
> > > >> >+ *
> > > >> >+ * Adds a memory mapping to the shared memory region. The Virtio=
SharedMemoryMapping
> > > >> >+ * ownership is transferred to the shared memory region and will=
 be automatically
> > > >> >+ * cleaned up through QOM reference counting when virtio_del_shm=
em_map() is
> > > >> >+ * called or when the shared memory region is destroyed.
> > > >> >+ *
> > > >> >+ * Returns: 0 on success, negative errno on failure
> > > >> >+ */
> > > >> >+int virtio_add_shmem_map(VirtioSharedMemory *shmem,
> > > >> >+                         VirtioSharedMemoryMapping *mapping);
> > > >> >+
> > > >> >+/**
> > > >> >+ * virtio_find_shmem_map() - Find a memory mapping in a shared r=
egion
> > > >> >+ * @shmem: VirtioSharedMemory region
> > > >> >+ * @offset: Offset within the shared memory region
> > > >> >+ * @size: Size of the mapping to find
> > > >> >+ *
> > > >> >+ * Finds an existing memory mapping that covers the specified ra=
nge.
> > > >> >+ * The returned VirtioSharedMemoryMapping is owned by the Virtio=
SharedMemory
> > > >> >+ * region and should not be freed by the caller.
> > > >> >+ *
> > > >> >+ * Returns: Pointer to the VirtioSharedMemoryMapping, or NULL if=
 not found
> > > >> >+ */
> > > >> >+VirtioSharedMemoryMapping *virtio_find_shmem_map(VirtioSharedMem=
ory *shmem,
> > > >> >+                                          hwaddr offset, uint64_=
t size);
> > > >> >+
> > > >> >+/**
> > > >> >+ * virtio_del_shmem_map() - Remove a memory mapping from a share=
d region
> > > >> >+ * @shmem: VirtioSharedMemory region
> > > >> >+ * @offset: Offset of the mapping to remove
> > > >> >+ * @size: Size of the mapping to remove
> > > >> >+ *
> > > >> >+ * Removes a memory mapping from the shared memory region. This =
will
> > > >> >+ * automatically unref the associated VhostUserShmemObject, whic=
h may
> > > >> >+ * trigger its finalization and cleanup if no other references e=
xist.
> > > >> >+ * The mapping's MemoryRegion will be properly unmapped and clea=
ned up.
> > > >> >+ */
> > > >> >+void virtio_del_shmem_map(VirtioSharedMemory *shmem, hwaddr offs=
et,
> > > >> >+                          uint64_t size);
> > > >> >+
> > > >> > extern const VMStateInfo virtio_vmstate_info;
> > > >> >
> > > >> > #define VMSTATE_VIRTIO_DEVICE \
> > > >> >diff --git a/subprojects/libvhost-user/libvhost-user.c b/subproje=
cts/libvhost-user/libvhost-user.c
> > > >> >index 9c630c2170..034cbfdc3c 100644
> > > >> >--- a/subprojects/libvhost-user/libvhost-user.c
> > > >> >+++ b/subprojects/libvhost-user/libvhost-user.c
> > > >> >@@ -1592,6 +1592,76 @@ vu_rm_shared_object(VuDev *dev, unsigned c=
har uuid[UUID_LEN])
> > > >> >     return vu_send_message(dev, &msg);
> > > >> > }
> > > >> >
> > > >> >+bool
> > > >> >+vu_shmem_map(VuDev *dev, uint8_t shmid, uint64_t fd_offset,
> > > >> >+             uint64_t shm_offset, uint64_t len, uint64_t flags, =
int fd)
> > > >> >+{
> > > >> >+    VhostUserMsg vmsg =3D {
> > > >> >+        .request =3D VHOST_USER_BACKEND_SHMEM_MAP,
> > > >> >+        .size =3D sizeof(vmsg.payload.mmap),
> > > >> >+        .flags =3D VHOST_USER_VERSION,
> > > >> >+        .payload.mmap =3D {
> > > >> >+            .shmid =3D shmid,
> > > >> >+            .fd_offset =3D fd_offset,
> > > >> >+            .shm_offset =3D shm_offset,
> > > >> >+            .len =3D len,
> > > >> >+            .flags =3D flags,
> > > >> >+        },
> > > >> >+        .fd_num =3D 1,
> > > >> >+        .fds[0] =3D fd,
> > > >> >+    };
> > > >> >+
> > > >> >+    if (!vu_has_protocol_feature(dev, VHOST_USER_PROTOCOL_F_SHME=
M)) {
> > > >> >+        return false;
> > > >> >+    }
> > > >> >+
> > > >> >+    if (vu_has_protocol_feature(dev, VHOST_USER_PROTOCOL_F_REPLY=
_ACK)) {
> > > >> >+        vmsg.flags |=3D VHOST_USER_NEED_REPLY_MASK;
> > > >> >+    }
> > > >> >+
> > > >> >+    pthread_mutex_lock(&dev->backend_mutex);
> > > >> >+    if (!vu_message_write(dev, dev->backend_fd, &vmsg)) {
> > > >> >+        pthread_mutex_unlock(&dev->backend_mutex);
> > > >> >+        return false;
> > > >> >+    }
> > > >> >+
> > > >> >+    /* Also unlocks the backend_mutex */
> > > >> >+    return vu_process_message_reply(dev, &vmsg);
> > > >> >+}
> > > >> >+
> > > >> >+bool
> > > >> >+vu_shmem_unmap(VuDev *dev, uint8_t shmid, uint64_t shm_offset, u=
int64_t len)
> > > >> >+{
> > > >> >+    VhostUserMsg vmsg =3D {
> > > >> >+        .request =3D VHOST_USER_BACKEND_SHMEM_UNMAP,
> > > >> >+        .size =3D sizeof(vmsg.payload.mmap),
> > > >> >+        .flags =3D VHOST_USER_VERSION,
> > > >> >+        .payload.mmap =3D {
> > > >> >+            .shmid =3D shmid,
> > > >> >+            .fd_offset =3D 0,
> > > >> >+            .shm_offset =3D shm_offset,
> > > >> >+            .len =3D len,
> > > >> >+        },
> > > >> >+    };
> > > >> >+
> > > >> >+    if (!vu_has_protocol_feature(dev, VHOST_USER_PROTOCOL_F_SHME=
M)) {
> > > >> >+        return false;
> > > >> >+    }
> > > >> >+
> > > >> >+    if (vu_has_protocol_feature(dev, VHOST_USER_PROTOCOL_F_REPLY=
_ACK)) {
> > > >> >+        vmsg.flags |=3D VHOST_USER_NEED_REPLY_MASK;
> > > >> >+    }
> > > >> >+
> > > >> >+    pthread_mutex_lock(&dev->backend_mutex);
> > > >> >+    if (!vu_message_write(dev, dev->backend_fd, &vmsg)) {
> > > >> >+        pthread_mutex_unlock(&dev->backend_mutex);
> > > >> >+        return false;
> > > >> >+    }
> > > >> >+
> > > >> >+    /* Also unlocks the backend_mutex */
> > > >> >+    return vu_process_message_reply(dev, &vmsg);
> > > >> >+}
> > > >> >+
> > > >> > static bool
> > > >> > vu_set_vring_call_exec(VuDev *dev, VhostUserMsg *vmsg)
> > > >> > {
> > > >> >diff --git a/subprojects/libvhost-user/libvhost-user.h b/subproje=
cts/libvhost-user/libvhost-user.h
> > > >> >index 2ffc58c11b..6a2d0f9fae 100644
> > > >> >--- a/subprojects/libvhost-user/libvhost-user.h
> > > >> >+++ b/subprojects/libvhost-user/libvhost-user.h
> > > >> >@@ -69,6 +69,8 @@ enum VhostUserProtocolFeature {
> > > >> >     /* Feature 16 is reserved for VHOST_USER_PROTOCOL_F_STATUS. =
*/
> > > >> >     /* Feature 17 reserved for VHOST_USER_PROTOCOL_F_XEN_MMAP. *=
/
> > > >> >     VHOST_USER_PROTOCOL_F_SHARED_OBJECT =3D 18,
> > > >> >+    /* Feature 19 is reserved for VHOST_USER_PROTOCOL_F_DEVICE_S=
TATE */
> > > >> >+    VHOST_USER_PROTOCOL_F_SHMEM =3D 20,
> > > >> >     VHOST_USER_PROTOCOL_F_MAX
> > > >> > };
> > > >> >
> > > >> >@@ -127,6 +129,8 @@ typedef enum VhostUserBackendRequest {
> > > >> >     VHOST_USER_BACKEND_SHARED_OBJECT_ADD =3D 6,
> > > >> >     VHOST_USER_BACKEND_SHARED_OBJECT_REMOVE =3D 7,
> > > >> >     VHOST_USER_BACKEND_SHARED_OBJECT_LOOKUP =3D 8,
> > > >> >+    VHOST_USER_BACKEND_SHMEM_MAP =3D 9,
> > > >> >+    VHOST_USER_BACKEND_SHMEM_UNMAP =3D 10,
> > > >> >     VHOST_USER_BACKEND_MAX
> > > >> > }  VhostUserBackendRequest;
> > > >> >
> > > >> >@@ -186,6 +190,23 @@ typedef struct VhostUserShared {
> > > >> >     unsigned char uuid[UUID_LEN];
> > > >> > } VhostUserShared;
> > > >> >
> > > >> >+/* For the flags field of VhostUserMMap */
> > > >> >+#define VHOST_USER_FLAG_MAP_RW (1u << 0)
> > > >> >+
> > > >> >+typedef struct {
> > > >> >+    /* VIRTIO Shared Memory Region ID */
> > > >> >+    uint8_t shmid;
> > > >> >+    uint8_t padding[7];
> > > >> >+    /* File offset */
> > > >> >+    uint64_t fd_offset;
> > > >> >+    /* Offset within the VIRTIO Shared Memory Region */
> > > >> >+    uint64_t shm_offset;
> > > >> >+    /* Size of the mapping */
> > > >> >+    uint64_t len;
> > > >> >+    /* Flags for the mmap operation, from VHOST_USER_FLAG_MAP_* =
*/
> > > >> >+    uint64_t flags;
> > > >> >+} VhostUserMMap;
> > > >> >+
> > > >> > #define VU_PACKED __attribute__((packed))
> > > >> >
> > > >> > typedef struct VhostUserMsg {
> > > >> >@@ -210,6 +231,7 @@ typedef struct VhostUserMsg {
> > > >> >         VhostUserVringArea area;
> > > >> >         VhostUserInflight inflight;
> > > >> >         VhostUserShared object;
> > > >> >+        VhostUserMMap mmap;
> > > >> >     } payload;
> > > >> >
> > > >> >     int fds[VHOST_MEMORY_BASELINE_NREGIONS];
> > > >> >@@ -593,6 +615,38 @@ bool vu_add_shared_object(VuDev *dev, unsign=
ed char uuid[UUID_LEN]);
> > > >> >  */
> > > >> > bool vu_rm_shared_object(VuDev *dev, unsigned char uuid[UUID_LEN=
]);
> > > >> >
> > > >> >+/**
> > > >> >+ * vu_shmem_map:
> > > >> >+ * @dev: a VuDev context
> > > >> >+ * @shmid: VIRTIO Shared Memory Region ID
> > > >> >+ * @fd_offset: File offset
> > > >> >+ * @shm_offset: Offset within the VIRTIO Shared Memory Region
> > > >> >+ * @len: Size of the mapping
> > > >> >+ * @flags: Flags for the mmap operation
> > > >> >+ * @fd: A file descriptor
> > > >> >+ *
> > > >> >+ * Advertises a new mapping to be made in a given VIRTIO Shared =
Memory Region.
> > > >> >+ *
> > > >> >+ * Returns: TRUE on success, FALSE on failure.
> > > >> >+ */
> > > >> >+bool vu_shmem_map(VuDev *dev, uint8_t shmid, uint64_t fd_offset,
> > > >> >+                  uint64_t shm_offset, uint64_t len, uint64_t fl=
ags, int fd);
> > > >> >+
> > > >> >+/**
> > > >> >+ * vu_shmem_unmap:
> > > >> >+ * @dev: a VuDev context
> > > >> >+ * @shmid: VIRTIO Shared Memory Region ID
> > > >> >+ * @fd_offset: File offset
> > > >> >+ * @len: Size of the mapping
> > > >> >+ *
> > > >> >+ * The front-end un-mmaps a given range in the VIRTIO Shared Mem=
ory Region
> > > >> >+ * with the requested `shmid`.
> > > >> >+ *
> > > >> >+ * Returns: TRUE on success, FALSE on failure.
> > > >> >+ */
> > > >> >+bool vu_shmem_unmap(VuDev *dev, uint8_t shmid, uint64_t shm_offs=
et,
> > > >> >+                    uint64_t len);
> > > >> >+
> > > >> > /**
> > > >> >  * vu_queue_set_notification:
> > > >> >  * @dev: a VuDev context
> > > >> >--
> > > >> >2.49.0
> > > >> >
> > > >>
> > > >
> > >
> >
>


