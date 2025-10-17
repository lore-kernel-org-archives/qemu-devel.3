Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B94B5CCD19A
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 09:30:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9gmU-00019B-BQ; Fri, 17 Oct 2025 05:29:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1v9gmR-00018z-TB
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 05:29:47 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1v9gmO-0003xz-HH
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 05:29:47 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-63bea08a326so2303660a12.3
 for <qemu-devel@nongnu.org>; Fri, 17 Oct 2025 02:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760693381; x=1761298181; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x/RxCML2UdImHruQ7rY70bSmxjaRAs74F42HmXmlbjU=;
 b=TuDzHpUkunL1+VzpoCIUK0dZUY8cSuWqDhkXFvEOAz65GKZRJIqmexXCJoDOgTZ8PZ
 XtS9PgWRQEJ6Cj7Q0EINkALydflS/nAIneIsb8KeFbFCQ+OLg/GdwvmPAmkrg1EK21Eb
 pShfqQOIZqpZwEyxAB9XCZidZ3nw1VFRAYnRBGbOERhdTK6VVLhuS5QBGiZFuVcp2pAT
 SOKmnVnCXe8GAN/4n9KwUtnrMrKPMtpZuQjkuOahWabm+zMUlaYcIaWpe9f3jBzY6SPw
 lj1efH2CqicTClbs9um1NWQ3paQPa9BUmbXnRRyjVeFcSh2j8LBCracSu7i5XsPLwCsR
 g/fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760693381; x=1761298181;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x/RxCML2UdImHruQ7rY70bSmxjaRAs74F42HmXmlbjU=;
 b=MBHfZRrozZkgSnf/6gAzk8LYPitOfUIcpHJMWkI69XSz+xAX/Ucd5tpGb0nEveQlhf
 bPOcoAIeF3y5mXANTXtLaDBIf+zmqj7a5/6r5enWp+PVtkhBGUPsniD8FwhLGSH2qKsA
 WSVsM3xuixpXTNCsjCRC56gZQq8qWSHASM5MyKWkO10KsoYvU0oH1tfJ6JMC2GCokC4t
 aswPRswwFpCEaGyX6DZNcMZZp+18f+EFfhNExdiILY23re64aBtgAaWgjsbADI5MNkc6
 4XVLnGdUVpbd7PbQMnZHLdQHtIOLIWGPZ730AdoFeAp7sb/31UvQV+xENZ682aymslYk
 2dTg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWRDYhledNEKHtadF3fZtgGzWqkZ3O6Y9oRyq2+89AMNPHjg3j+ubRD/iO1xHWA4GZmUzGz3377nyY3@nongnu.org
X-Gm-Message-State: AOJu0YzjNaAu7yog4iEmXrjGlxnm14f8ug2TDI81pEwP2nBChM7Ze18i
 0XNn9OdjwGtuosBz+zMICdSCM4bYo1vHC/NqwEVwwqdGyAvJvorFTHOS55OPCqCfb8a4oQg7Tli
 8VPYsYwtYsDtDO+JFuM8QCeInVCQ/GUbmTqD46ftaNQ==
X-Gm-Gg: ASbGnctnzm3+/PjIRrqFRYOo3xYYERsoUI1Qry+ADyjLg2sKezenrTYJfb96RV58kxX
 1qropgjhHrAACAjh39cdb9i41uRgOxJnvGKw7IsWGEu5pzvG/Hu2bdLBfUVGDAyjkeXsEYur3Fr
 VWziIRYD9QSxby7IZEsLirpkbRTSUljWtlO1LxmVvi8tl4+Wk6w5tScSLXM/1kbMZdAKzz2CZRj
 kpcjTSnYXohHw1GQtXCKtceGwN/n1po5WVveZoeHAGPD2JHtbVtziPov7Idlw==
X-Google-Smtp-Source: AGHT+IGqWsEmRYynWoDnF4AvsDnMBOPYNaeBpN5hF0EfPG1FptJjd7ixygyFWqOUbszMsA8BKrvWSoV7kn+BkaUkkb4=
X-Received: by 2002:a05:6402:40cc:b0:63c:32a6:e9ff with SMTP id
 4fb4d7f45d1cf-63c32a6ee79mr752482a12.8.1760693381534; Fri, 17 Oct 2025
 02:29:41 -0700 (PDT)
MIME-Version: 1.0
References: <20251016143827.1850397-1-aesteve@redhat.com>
 <20251016143827.1850397-2-aesteve@redhat.com>
 <nl5smdnd5neyuqykpwkruq2onc32hq7jbgbylv33xq4rrsksvc@hk6u3b33iws3>
In-Reply-To: <nl5smdnd5neyuqykpwkruq2onc32hq7jbgbylv33xq4rrsksvc@hk6u3b33iws3>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Fri, 17 Oct 2025 12:29:14 +0300
X-Gm-Features: AS18NWDyLu-2Y1xZWvI4jjvuJmbxdk5sKpMinILQ98Yu-QnlxcRyy4jq6V0SzG0
Message-ID: <CAAjaMXZBZCaRKcPPWStu=a7of-fexBJsDLPMoT-QF3U19fcVUw@mail.gmail.com>
Subject: Re: [PATCH v10 1/7] vhost-user: Add VirtIO Shared Memory map request
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Albert Esteve <aesteve@redhat.com>, qemu-devel@nongnu.org, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, hi@alyssa.is, 
 stefanha@redhat.com, david@redhat.com, jasowang@redhat.com, 
 dbassey@redhat.com, stevensd@chromium.org, 
 Laurent Vivier <lvivier@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, slp@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x529.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Fri, Oct 17, 2025 at 12:22=E2=80=AFPM Stefano Garzarella <sgarzare@redha=
t.com> wrote:
>
> On Thu, Oct 16, 2025 at 04:38:21PM +0200, Albert Esteve wrote:
> >Add SHMEM_MAP/UNMAP requests to vhost-user for dynamic management of
> >VIRTIO Shared Memory mappings.
> >
> >This implementation introduces VirtioSharedMemoryMapping as a unified
> >QOM object that manages both the mapping metadata and MemoryRegion
> >lifecycle. This object provides reference-counted lifecycle management
> >with automatic cleanup of file descriptors and memory regions
> >through QOM finalization.
> >
> >This request allows backends to dynamically map file descriptors into a
> >VIRTIO Shared Memory Region identified by their shmid. Maps are created
> >using memory_region_init_ram_from_fd() with configurable read/write
> >permissions, and the resulting MemoryRegions are added as subregions to
> >the shmem container region. The mapped memory is then advertised to the
> >guest VIRTIO drivers as a base address plus offset for reading and
> >writting according to the requested mmap flags.
> >
> >The backend can unmap memory ranges within a given VIRTIO Shared Memory
> >Region to free resources. Upon receiving this message, the frontend
> >removes the MemoryRegion as a subregion and automatically unreferences
> >the VirtioSharedMemoryMapping object, triggering cleanup if no other
> >references exist.
> >
> >Error handling has been improved to ensure consistent behavior across
> >handlers that manage their own vhost_user_send_resp() calls. Since
> >these handlers clear the VHOST_USER_NEED_REPLY_MASK flag, explicit
> >error checking ensures proper connection closure on failures,
> >maintaining the expected error flow.
> >
> >Note the memory region commit for these operations needs to be delayed
> >until after we reply to the backend to avoid deadlocks. Otherwise,
> >the MemoryListener would send a VHOST_USER_SET_MEM_TABLE message
> >before the reply.
> >
> >Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> >Signed-off-by: Albert Esteve <aesteve@redhat.com>
> >---
> > hw/virtio/vhost-user.c                    | 267 ++++++++++++++++++++++
> > hw/virtio/virtio.c                        | 199 ++++++++++++++++
> > include/hw/virtio/virtio.h                | 135 +++++++++++
> > subprojects/libvhost-user/libvhost-user.c |  70 ++++++
> > subprojects/libvhost-user/libvhost-user.h |  54 +++++
> > 5 files changed, 725 insertions(+)
> >
> >diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> >index 36c9c2e04d..890be55937 100644
> >--- a/hw/virtio/vhost-user.c
> >+++ b/hw/virtio/vhost-user.c
> >@@ -104,6 +104,7 @@ typedef enum VhostUserRequest {
> >     VHOST_USER_GET_SHARED_OBJECT =3D 41,
> >     VHOST_USER_SET_DEVICE_STATE_FD =3D 42,
> >     VHOST_USER_CHECK_DEVICE_STATE =3D 43,
> >+    VHOST_USER_GET_SHMEM_CONFIG =3D 44,
> >     VHOST_USER_MAX
> > } VhostUserRequest;
> >
> >@@ -115,6 +116,8 @@ typedef enum VhostUserBackendRequest {
> >     VHOST_USER_BACKEND_SHARED_OBJECT_ADD =3D 6,
> >     VHOST_USER_BACKEND_SHARED_OBJECT_REMOVE =3D 7,
> >     VHOST_USER_BACKEND_SHARED_OBJECT_LOOKUP =3D 8,
> >+    VHOST_USER_BACKEND_SHMEM_MAP =3D 9,
> >+    VHOST_USER_BACKEND_SHMEM_UNMAP =3D 10,
> >     VHOST_USER_BACKEND_MAX
> > }  VhostUserBackendRequest;
> >
> >@@ -136,6 +139,12 @@ typedef struct VhostUserMemRegMsg {
> >     VhostUserMemoryRegion region;
> > } VhostUserMemRegMsg;
> >
> >+typedef struct VhostUserShMemConfig {
> >+    uint32_t nregions;
> >+    uint32_t padding;
> >+    uint64_t memory_sizes[VIRTIO_MAX_SHMEM_REGIONS];
> >+} VhostUserShMemConfig;
> >+
> > typedef struct VhostUserLog {
> >     uint64_t mmap_size;
> >     uint64_t mmap_offset;
> >@@ -192,6 +201,23 @@ typedef struct VhostUserShared {
> >     unsigned char uuid[16];
> > } VhostUserShared;
> >
> >+/* For the flags field of VhostUserMMap */
> >+#define VHOST_USER_FLAG_MAP_RW (1u << 0)
> >+
> >+typedef struct {
> >+    /* VIRTIO Shared Memory Region ID */
> >+    uint8_t shmid;
> >+    uint8_t padding[7];
> >+    /* File offset */
> >+    uint64_t fd_offset;
> >+    /* Offset within the VIRTIO Shared Memory Region */
> >+    uint64_t shm_offset;
> >+    /* Size of the mapping */
> >+    uint64_t len;
> >+    /* Flags for the mmap operation, from VHOST_USER_FLAG_MAP_* */
> >+    uint64_t flags;
> >+} VhostUserMMap;
> >+
> > typedef struct {
> >     VhostUserRequest request;
> >
> >@@ -224,6 +250,8 @@ typedef union {
> >         VhostUserInflight inflight;
> >         VhostUserShared object;
> >         VhostUserTransferDeviceState transfer_state;
> >+        VhostUserMMap mmap;
> >+        VhostUserShMemConfig shmem;
> > } VhostUserPayload;
> >
> > typedef struct VhostUserMsg {
> >@@ -1768,6 +1796,196 @@ vhost_user_backend_handle_shared_object_lookup(s=
truct vhost_user *u,
> >     return 0;
> > }
> >
> >+/**
> >+ * vhost_user_backend_handle_shmem_map() - Handle SHMEM_MAP backend req=
uest
> >+ * @dev: vhost device
> >+ * @ioc: QIOChannel for communication
> >+ * @hdr: vhost-user message header
> >+ * @payload: message payload containing mapping details
> >+ * @fd: file descriptor for the shared memory region
> >+ *
> >+ * Handles VHOST_USER_BACKEND_SHMEM_MAP requests from the backend. Crea=
tes
> >+ * a VhostUserShmemObject to manage the shared memory mapping and adds =
it
> >+ * to the appropriate VirtIO shared memory region. The VhostUserShmemOb=
ject
> >+ * serves as an intermediate parent for the MemoryRegion, ensuring prop=
er
> >+ * lifecycle management with reference counting.
> >+ *
> >+ * Returns: 0 on success, negative errno on failure
> >+ */
> >+static int
> >+vhost_user_backend_handle_shmem_map(struct vhost_dev *dev,
> >+                                    QIOChannel *ioc,
> >+                                    VhostUserHeader *hdr,
> >+                                    VhostUserPayload *payload,
> >+                                    int fd)
> >+{
> >+    VirtioSharedMemory *shmem;
> >+    VhostUserMMap *vu_mmap =3D &payload->mmap;
> >+    VirtioSharedMemoryMapping *existing;
> >+    Error *local_err =3D NULL;
> >+    int ret =3D 0;
> >+
> >+    if (fd < 0) {
> >+        error_report("Bad fd for map");
> >+        ret =3D -EBADF;
> >+        goto send_reply;
> >+    }
> >+
> >+    if (QSIMPLEQ_EMPTY(&dev->vdev->shmem_list)) {
> >+        error_report("Device has no VIRTIO Shared Memory Regions. "
> >+                     "Requested ID: %d", vu_mmap->shmid);
> >+        ret =3D -EFAULT;
> >+        goto send_reply;
> >+    }
> >+
> >+    shmem =3D virtio_find_shmem_region(dev->vdev, vu_mmap->shmid);
> >+    if (!shmem) {
> >+        error_report("VIRTIO Shared Memory Region at "
> >+                     "ID %d not found or uninitialized", vu_mmap->shmid=
);
> >+        ret =3D -EFAULT;
> >+        goto send_reply;
> >+    }
> >+
> >+    if ((vu_mmap->shm_offset + vu_mmap->len) < vu_mmap->len ||
> >+        (vu_mmap->shm_offset + vu_mmap->len) > shmem->mr.size) {
> >+        error_report("Bad offset/len for mmap %" PRIx64 "+%" PRIx64,
> >+                     vu_mmap->shm_offset, vu_mmap->len);
> >+        ret =3D -EFAULT;
> >+        goto send_reply;
> >+    }
> >+
> >+    QTAILQ_FOREACH(existing, &shmem->mmaps, link) {
> >+        if (ranges_overlap(existing->offset, existing->len,
> >+                           vu_mmap->shm_offset, vu_mmap->len)) {
> >+            error_report("VIRTIO Shared Memory mapping overlap");
> >+            ret =3D -EFAULT;
> >+            goto send_reply;
> >+        }
> >+    }
> >+
> >+    memory_region_transaction_begin();
> >+
> >+    /* Create VirtioSharedMemoryMapping object */
> >+    VirtioSharedMemoryMapping *mapping =3D virtio_shared_memory_mapping=
_new(
> >+        vu_mmap->shmid, fd, vu_mmap->fd_offset, vu_mmap->shm_offset,
> >+        vu_mmap->len, vu_mmap->flags & VHOST_USER_FLAG_MAP_RW);
> >+
> >+    if (!mapping) {
> >+        ret =3D -EFAULT;
> >+        goto send_reply_commit;
> >+    }
> >+
> >+    /* Add the mapping to the shared memory region */
> >+    if (virtio_add_shmem_map(shmem, mapping) !=3D 0) {
> >+        error_report("Failed to add shared memory mapping");
> >+        object_unref(OBJECT(mapping));
> >+        ret =3D -EFAULT;
> >+        goto send_reply_commit;
> >+    }
> >+
> >+send_reply_commit:
> >+    /* Send reply and commit after transaction started */
> >+    if (hdr->flags & VHOST_USER_NEED_REPLY_MASK) {
> >+        payload->u64 =3D !!ret;
> >+        hdr->size =3D sizeof(payload->u64);
> >+        if (!vhost_user_send_resp(ioc, hdr, payload, &local_err)) {
> >+            error_report_err(local_err);
> >+            memory_region_transaction_commit();
> >+            return -EFAULT;
> >+        }
> >+    }
> >+    memory_region_transaction_commit();
>
> Sorry to be late, I did a quick review, my only doubts is here, maybe it
> was already discussed, but why do we commit after responding to the
> backend?
>
> Should we do it first to prevent the backend from =E2=80=9Cseeing=E2=80=
=9D something
> that hasn't been committed yet?

Isn't this protected by the BQL? The commit adds the region to the
flatview and exposes it to the guest's addresspace (this can't fail
IIUC).

>
> Also, if vhost_user_send_resp() fails, should we call
> virtio_del_shmem_map()?

Good point.

> Thanks,
> Stefano

