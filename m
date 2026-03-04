Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB746EF8FE6
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 13:31:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxmK7-0004qS-Uf; Wed, 04 Mar 2026 08:31:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1vxmK1-0004qC-Ag
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 08:31:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1vxmJy-0004CE-IZ
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 08:31:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772631084;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J+abW1rnwihJA93PwhwGM8xJe+0CxH7JQm70jadlRuQ=;
 b=MUO6XHNEA1q+w06S1ZUICGqzinF80uuqed4hH/1Z4EJTukooHaylfp44s4IJ1znvbiDwLZ
 0UJPtn23FtaI+ypQDhGHKGwZbQx79Xie6P6nGIqBVlgbbcuFqMPxheeniA+WVoQn+2kQqY
 bsK8yqebTlyw5BlRK4i0YxXeTzMLDoo=
Received: from mail-yx1-f70.google.com (mail-yx1-f70.google.com
 [74.125.224.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-676-VioKdXCDOfucM92z6KyBVQ-1; Wed, 04 Mar 2026 08:31:23 -0500
X-MC-Unique: VioKdXCDOfucM92z6KyBVQ-1
X-Mimecast-MFC-AGG-ID: VioKdXCDOfucM92z6KyBVQ_1772631083
Received: by mail-yx1-f70.google.com with SMTP id
 956f58d0204a3-64cb3951982so9847256d50.3
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2026 05:31:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772631083; cv=none;
 d=google.com; s=arc-20240605;
 b=MnyvoZHgg8yM5+GXCR8HbcR32DOGC5VXQGF0nGQpNL1NjycVijofkda+zq5xt1ttEZ
 05Dq3uOqjdbZWDURfwAqn3zMQE+XhtBKOLZ4zXJ4dHoF2DXNzAHiDtPy+CfPrrCF0MBs
 J1FW2UC/PAyzFFPamqb4hT6xWnDsqIZx3WA5zXw+LEMS5f4t0VbTGAHgO4Te16d07RVo
 pUJKhWWUDm889dJsRZhpJ2uIsVolo2yvuat9jmXotYImrYWSFBgCaXsRdJ8ejsmF1lA6
 il/Hz+/HwQUgzDBMCou9YM3rvULv08W93SWCNIQixiZOfFSnwQgjObaaeTsJT/TO944p
 KMDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=J+abW1rnwihJA93PwhwGM8xJe+0CxH7JQm70jadlRuQ=;
 fh=4ut0VWvdeFwSfmTm/Ki/2jEZaA5lSfo5qoMDWVqAkBs=;
 b=Fs/DVc8Eeq0XLYsQa+bfwjVKUexK1gFwsLzWoIPHcbxZWk54snk0yubjKQbFnVdrmm
 FtqjPMDYyaeyO7bqjbKGVaLKt48zkd/Yjf0oXqxMxB9gMxou8vQFF37BfQ71AzH0NWMv
 3CzCs3ZSxW7H2z3zwCMC4tGD4BciXGjjavlp0VG9ZLgB+sdFLM2Txv2LgG4EBo52pRVp
 72GJ+ZQ+d62U7gYM5wF6icLhsYy6fTwzTIqDIl0PVr9ibOTLRyeF+AL4G8mMlisZ4DDy
 +zlPRrcDjN6azyrmOnyaEkDHMWKvMi1kMOAS2rC6XJv0m+5LKC5EMYn8Ur4fgQjm4J1F
 p24g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772631083; x=1773235883; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J+abW1rnwihJA93PwhwGM8xJe+0CxH7JQm70jadlRuQ=;
 b=jQ1YcXDkLZrqSxPVCMGAu5dC9bGgKTUEi8vJ1Vr/YOUPmxxmFXnVIv7+Sg4N43Mtjt
 U5UNds3DJfYZx5PpakpPlS8sKc3AbhiLxmEyLAtjhc8gOdbIjQRxSzQp13D+T7YrgDpu
 PFNvJ5Wv3MuKsDQuIffN84/T6abmGF8xYTg6mXa6X3tFrfAkfRhEsPVWc+FpFDuCR7Ea
 BbVvsur4fgcgMTPxSTa5Z3cc51HwaIJa/EkUpO61Voj+GVKiX6+mvFu3OUIfMhgqQVSK
 7/uc1dHCUlVRUNAxQSCsGlzSyccCRyK8B9iD+YSQAOZ/EM6qKby136Ly+ZnS+sIG2EPO
 Dv2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772631083; x=1773235883;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=J+abW1rnwihJA93PwhwGM8xJe+0CxH7JQm70jadlRuQ=;
 b=NAM27qw1EBkifq+bu6wi088hQXF17iBbyVCn21I87hc8MnD7LTIU8CD9fB+tVBmx0J
 5n69+fCOd3chRbN0T/z3O8IrQ0IkHYzwnTUWsHaxrjPhnZXznROiq95ZKUIEvDdh5+MU
 R12lPvT4VUfo7pxqFCUX0BIvUg8e+rZEz4q/V4qSJJi2XiSSwLYOr1E3gPK4tKKZUnQh
 uDS2E7H+Gd09h8jAmFiQAh7M+c7mMVMYfPYPi/Z7710BRXMxOVC5zG0MvYuBLOsCubJx
 cs4i6ox2iQhOZHOetyZ/Mf6q5dZQ0ikbHLl4Z3/1gNEOWdsbROJ8KlNrkBLVOSR9b0kQ
 yEcw==
X-Gm-Message-State: AOJu0YwjgOXp0X4o+P/U8289Zz7Fs2YpMHVTLQgJj3TMo4UwbUtXQs12
 EnnINtk5sZ4Vf8pjGPSYIBOq98fA5z6S28RDyW6NoOD1WVFqZr89+7+MXK0lFt0Gnv2FJr2AwDk
 YM8U0aJ2MWcYKqJMX6iKniP3KwdG1EH9BK9E2DeLQjUZwFfpaHwbYjPZ5foZl7hjDG29Felc5Nn
 kHJEyBjvD65GnyoVWlUR6u0LORzhLiNWA=
X-Gm-Gg: ATEYQzwYvaCQUFOaHt9p2FAaQ/tdTCIjRZ2ik7kwyqdZ4GBRe/RzqKO3taC1y430GnX
 ZK4mdubxYes+5tm+uZdDw2oa8AoLYfUWTRe6algWvM43cpL3OvIlbNYPhDn96fJpC2aJTIKNSwd
 lfffDT2e1rOBn1Mf3rpMVvuxcTpQX9I9fZIxKn1neg8BQNHXcpQFztYWZGLWdsAy8j22bNJ2c6l
 g==
X-Received: by 2002:a05:690e:b4d:b0:63f:b4d8:1f32 with SMTP id
 956f58d0204a3-64cf9b4dbadmr1468578d50.20.1772631082707; 
 Wed, 04 Mar 2026 05:31:22 -0800 (PST)
X-Received: by 2002:a05:690e:b4d:b0:63f:b4d8:1f32 with SMTP id
 956f58d0204a3-64cf9b4dbadmr1468555d50.20.1772631082162; Wed, 04 Mar 2026
 05:31:22 -0800 (PST)
MIME-Version: 1.0
References: <20260219130334.787858-1-aesteve@redhat.com>
 <20260219130334.787858-2-aesteve@redhat.com>
 <aagsazxNYDriNgDZ@sgarzare-redhat>
In-Reply-To: <aagsazxNYDriNgDZ@sgarzare-redhat>
From: Albert Esteve <aesteve@redhat.com>
Date: Wed, 4 Mar 2026 14:31:09 +0100
X-Gm-Features: AaiRm52u_yUEbLKhBTGPDgDw0E9-QjzEepgtXw1-xNyuiF5Vi13ehUJzti4VyrY
Message-ID: <CADSE00JwOSxPx3K87bcJXsARg4CPv6b3LLnRdJYHziVxs-qPJA@mail.gmail.com>
Subject: Re: [PATCH v13 1/7] vhost-user: Add VirtIO Shared Memory map request
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, mst@redhat.com,
 dbassey@redhat.com, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 stefanha@redhat.com, manos.pitsidianakis@linaro.org, jasowang@redhat.com, 
 Laurent Vivier <lvivier@redhat.com>, slp@redhat.com, hi@alyssa.is,
 stevensd@chromium.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=aesteve@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 13
X-Spam_score: 1.3
X-Spam_bar: +
X-Spam_report: (1.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.703, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.386,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Mar 4, 2026 at 2:08=E2=80=AFPM Stefano Garzarella <sgarzare@redhat.=
com> wrote:
>
> On Thu, Feb 19, 2026 at 02:03:28PM +0100, Albert Esteve wrote:
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
> > hw/virtio/vhost-user.c                    | 269 ++++++++++++++++++++++
> > hw/virtio/virtio.c                        | 201 ++++++++++++++++
> > include/hw/virtio/virtio.h                | 135 +++++++++++
> > include/system/memory.h                   |  13 ++
> > subprojects/libvhost-user/libvhost-user.c |  70 ++++++
> > subprojects/libvhost-user/libvhost-user.h |  54 +++++
> > 6 files changed, 742 insertions(+)
> >
> >diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> >index 63fa9a1b4b..5d3841d58b 100644
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
> >@@ -1771,6 +1799,196 @@ vhost_user_backend_handle_shared_object_lookup(s=
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
>
> Any reason about not using `memory_region_size(&shmem->mr)` ?

Nope, that would be better, I will change it.

>
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
> >+    return 0;
> >+
> >+send_reply:
> >+    if (hdr->flags & VHOST_USER_NEED_REPLY_MASK) {
> >+        payload->u64 =3D !!ret;
> >+        hdr->size =3D sizeof(payload->u64);
> >+        if (!vhost_user_send_resp(ioc, hdr, payload, &local_err)) {
> >+            error_report_err(local_err);
> >+            return -EFAULT;
> >+        }
> >+    }
> >+    return 0;
> >+}
> >+
> >+/**
> >+ * vhost_user_backend_handle_shmem_unmap() - Handle SHMEM_UNMAP backend=
 request
> >+ * @dev: vhost device
> >+ * @ioc: QIOChannel for communication
> >+ * @hdr: vhost-user message header
> >+ * @payload: message payload containing unmapping details
> >+ *
> >+ * Handles VHOST_USER_BACKEND_SHMEM_UNMAP requests from the backend. Re=
moves
> >+ * the specified memory mapping from the VirtIO shared memory region.
> >This
> >+ * automatically unreferences the associated VhostUserShmemObject, whic=
h may
> >+ * trigger its finalization and cleanup (munmap, close fd) if no other
> >+ * references exist.
> >+ *
> >+ * Returns: 0 on success, negative errno on failure
> >+ */
> >+static int
> >+vhost_user_backend_handle_shmem_unmap(struct vhost_dev *dev,
> >+                                      QIOChannel *ioc,
> >+                                      VhostUserHeader *hdr,
> >+                                      VhostUserPayload *payload)
> >+{
> >+    VirtioSharedMemory *shmem =3D NULL;
> >+    VirtioSharedMemoryMapping *mmap =3D NULL;
> >+    VhostUserMMap *vu_mmap =3D &payload->mmap;
> >+    Error *local_err =3D NULL;
> >+    int ret =3D 0;
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
> >+        error_report("Bad offset/len for unmmap %" PRIx64 "+%" PRIx64,
> >+                     vu_mmap->shm_offset, vu_mmap->len);
> >+        ret =3D -EFAULT;
> >+        goto send_reply;
> >+    }
> >+
> >+    mmap =3D virtio_find_shmem_map(shmem, vu_mmap->shm_offset, vu_mmap-=
>len);
> >+    if (!mmap) {
> >+        error_report("Shared memory mapping not found at offset %" PRIx=
64
> >+                     " with length %" PRIx64,
> >+                     vu_mmap->shm_offset, vu_mmap->len);
> >+        ret =3D -EFAULT;
> >+        goto send_reply;
> >+    }
> >+
> >+send_reply:
> >+    if (hdr->flags & VHOST_USER_NEED_REPLY_MASK) {
> >+        payload->u64 =3D !!ret;
> >+        hdr->size =3D sizeof(payload->u64);
> >+        if (!vhost_user_send_resp(ioc, hdr, payload, &local_err)) {
> >+            error_report_err(local_err);
> >+            return -EFAULT;
> >+        }
> >+    }
> >+
> >+    if (!ret && shmem && mmap) {
> >+        /* Free the MemoryRegion only after reply */
> >+        virtio_del_shmem_map(shmem, vu_mmap->shm_offset, vu_mmap->len);
> >+    }
> >+
> >+    return 0;
> >+}
> >+
> > static void close_backend_channel(struct vhost_user *u)
> > {
> >     g_source_destroy(u->backend_src);
> >@@ -1844,6 +2062,21 @@ static gboolean backend_read(QIOChannel *ioc, GIO=
Condition condition,
> >         ret =3D vhost_user_backend_handle_shared_object_lookup(dev->opa=
que,
> >                                                              &payload.o=
bject);
> >         break;
> >+    case VHOST_USER_BACKEND_SHMEM_MAP:
> >+        /* Handler manages its own response, check error and close conn=
ection */
> >+        reply_ack =3D false;
> >+        if (vhost_user_backend_handle_shmem_map(dev, ioc, &hdr, &payloa=
d,
> >+                                                fd ? fd[0] : -1) < 0) {
> >+            goto err;
> >+        }
> >+        break;
> >+    case VHOST_USER_BACKEND_SHMEM_UNMAP:
> >+        /* Handler manages its own response, check error and close conn=
ection */
> >+        reply_ack =3D false;
> >+        if (vhost_user_backend_handle_shmem_unmap(dev, ioc, &hdr, &payl=
oad) < 0) {
> >+            goto err;
> >+        }
> >+        break;
> >     default:
> >         error_report("Received unexpected msg type: %d.", hdr.request);
> >         ret =3D -EINVAL;
> >@@ -3021,6 +3254,41 @@ static int vhost_user_check_device_state(struct v=
host_dev *dev, Error **errp)
> >     return 0;
> > }
> >
> >+static int vhost_user_get_shmem_config(struct vhost_dev *dev,
> >+                                       int *nregions,
> >+                                       uint64_t *memory_sizes,
> >+                                       Error **errp)
> >+{
> >+    int ret;
> >+    VhostUserMsg msg =3D {
> >+        .hdr.request =3D VHOST_USER_GET_SHMEM_CONFIG,
> >+        .hdr.flags =3D VHOST_USER_VERSION,
> >+    };
> >+
> >+    if (!virtio_has_feature(dev->protocol_features,
> >+                            VHOST_USER_PROTOCOL_F_SHMEM)) {
> >+        *nregions =3D 0;
> >+        return 0;
> >+    }
> >+
> >+    ret =3D vhost_user_write(dev, &msg, NULL, 0);
> >+    if (ret < 0) {
> >+        return ret;
> >+    }
> >+
> >+    ret =3D vhost_user_read(dev, &msg);
> >+    if (ret < 0) {
> >+        return ret;
> >+    }
> >+
> >+    assert(msg.payload.shmem.nregions <=3D VIRTIO_MAX_SHMEM_REGIONS);
>
> Is this `assert()` too much?
> This means that a bad vhost-user backend can crash QEMU, so not sure
> it's really what we want, I'd return an error.

I guess I was doing the same as in `vhost_user_get_config`, which also
asserts the max size. But I agree, returning an error is reasonable in
this case.

>
> >+    *nregions =3D msg.payload.shmem.nregions;
> >+    memcpy(memory_sizes,
> >+           &msg.payload.shmem.memory_sizes,
> >+           sizeof(uint64_t) * VIRTIO_MAX_SHMEM_REGIONS);
> >+    return 0;
> >+}
> >+
> > const VhostOps user_ops =3D {
> >         .backend_type =3D VHOST_BACKEND_TYPE_USER,
> >         .vhost_backend_init =3D vhost_user_backend_init,
> >@@ -3059,4 +3327,5 @@ const VhostOps user_ops =3D {
> >         .vhost_supports_device_state =3D vhost_user_supports_device_sta=
te,
> >         .vhost_set_device_state_fd =3D vhost_user_set_device_state_fd,
> >         .vhost_check_device_state =3D vhost_user_check_device_state,
> >+        .vhost_get_shmem_config =3D vhost_user_get_shmem_config,
> > };
> >diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> >index 3dc9423eae..2f608f33ae 100644
> >--- a/hw/virtio/virtio.c
> >+++ b/hw/virtio/virtio.c
> >@@ -3111,6 +3111,173 @@ int virtio_save(VirtIODevice *vdev, QEMUFile *f)
> >     return ret;
> > }
> >
> >+VirtioSharedMemory *virtio_new_shmem_region(VirtIODevice *vdev, uint8_t=
 shmid, uint64_t size)
> >+{
> >+    VirtioSharedMemory *elem;
> >+    g_autofree char *name =3D NULL;
> >+
> >+    elem =3D g_new0(VirtioSharedMemory, 1);
> >+    elem->shmid =3D shmid;
> >+
> >+    /* Initialize embedded MemoryRegion as container for shmem mappings=
 */
> >+    name =3D g_strdup_printf("virtio-shmem-%d", shmid);
> >+    memory_region_init(&elem->mr, OBJECT(vdev), name, size);
> >+    QTAILQ_INIT(&elem->mmaps);
> >+    QSIMPLEQ_INSERT_TAIL(&vdev->shmem_list, elem, entry);
> >+    return elem;
> >+}
> >+
> >+VirtioSharedMemory *virtio_find_shmem_region(VirtIODevice *vdev, uint8_=
t shmid)
> >+{
> >+    VirtioSharedMemory *shmem, *next;
> >+    QSIMPLEQ_FOREACH_SAFE(shmem, &vdev->shmem_list, entry, next) {
> >+        if (shmem->shmid =3D=3D shmid) {
> >+            return shmem;
> >+        }
> >+    }
> >+    return NULL;
> >+}
> >+
> >+static void virtio_shared_memory_mapping_instance_init(Object *obj)
> >+{
> >+    VirtioSharedMemoryMapping *mapping =3D VIRTIO_SHARED_MEMORY_MAPPING=
(obj);
> >+
> >+    mapping->shmid =3D 0;
> >+    mapping->offset =3D 0;
> >+    mapping->len =3D 0;
> >+    mapping->mr =3D NULL;
> >+}
> >+
> >+static void virtio_shared_memory_mapping_instance_finalize(Object *obj)
> >+{
> >+    VirtioSharedMemoryMapping *mapping =3D VIRTIO_SHARED_MEMORY_MAPPING=
(obj);
> >+
> >+    /* Clean up MemoryRegion if it exists */
> >+    if (mapping->mr) {
> >+        /* Unparent the MemoryRegion to trigger cleanup */
> >+        object_unparent(OBJECT(mapping->mr));
> >+        mapping->mr =3D NULL;
> >+    }
> >+}
> >+
> >+VirtioSharedMemoryMapping *virtio_shared_memory_mapping_new(uint8_t shm=
id,
> >+                                                            int fd,
> >+                                                            uint64_t fd=
_offset,
> >+                                                            uint64_t sh=
m_offset,
> >+                                                            uint64_t le=
n,
> >+                                                            bool allow_=
write)
> >+{
> >+    VirtioSharedMemoryMapping *mapping;
> >+    MemoryRegion *mr;
> >+    g_autoptr(GString) mr_name =3D g_string_new(NULL);
> >+    uint32_t ram_flags;
> >+    Error *local_err =3D NULL;
> >+
> >+    if (len =3D=3D 0) {
> >+        error_report("Shared memory mapping size cannot be zero");
> >+        return NULL;
> >+    }
> >+
> >+    fd =3D dup(fd);
> >+    if (fd < 0) {
> >+        error_report("Failed to duplicate fd: %s", strerror(errno));
> >+        return NULL;
> >+    }
> >+
> >+    /* Determine RAM flags */
> >+    ram_flags =3D RAM_SHARED;
> >+    if (!allow_write) {
> >+        ram_flags |=3D RAM_READONLY_FD;
> >+    }
> >+
> >+    /* Create the VirtioSharedMemoryMapping */
> >+    mapping =3D VIRTIO_SHARED_MEMORY_MAPPING(
> >+        object_new(TYPE_VIRTIO_SHARED_MEMORY_MAPPING));
> >+
> >+    /* Set up object properties */
> >+    mapping->shmid =3D shmid;
> >+    mapping->offset =3D shm_offset;
> >+    mapping->len =3D len;
> >+
> >+    /* Create MemoryRegion as a child of this object */
> >+    mr =3D g_new0(MemoryRegion, 1);
> >+    g_string_printf(mr_name, "virtio-shmem-%d-%" PRIx64, shmid, shm_off=
set);
> >+
> >+    /* Initialize MemoryRegion with file descriptor */
> >+    if (!memory_region_init_ram_from_fd(mr, OBJECT(mapping), mr_name->s=
tr,
> >+                                        len, ram_flags, fd, fd_offset,
> >+                                        &local_err)) {
> >+        error_report_err(local_err);
> >+        g_free(mr);
> >+        close(fd);
> >+        object_unref(OBJECT(mapping));
> >+        return NULL;
> >+    }
> >+
> >+    mapping->mr =3D mr;
> >+    return mapping;
> >+}
> >+
> >+int virtio_add_shmem_map(VirtioSharedMemory *shmem,
> >+                         VirtioSharedMemoryMapping *mapping)
> >+{
> >+    if (!mapping) {
> >+        error_report("VirtioSharedMemoryMapping cannot be NULL");
> >+        return -1;
> >+    }
> >+    if (!mapping->mr) {
> >+        error_report("VirtioSharedMemoryMapping has no MemoryRegion");
> >+        return -1;
> >+    }
> >+
> >+    /* Validate boundaries against the VIRTIO shared memory region */
> >+    if (mapping->offset + mapping->len > memory_region_size(&shmem->mr)=
) {
> >+        error_report("Memory exceeds the shared memory boundaries");
> >+        return -1;
> >+    }
> >+
> >+    /* Add as subregion to the VIRTIO shared memory */
> >+    memory_region_add_subregion(&shmem->mr, mapping->offset, mapping->m=
r);
> >+
> >+    /* Add to the mapped regions list */
> >+    QTAILQ_INSERT_TAIL(&shmem->mmaps, mapping, link);
> >+
> >+    return 0;
> >+}
> >+
> >+VirtioSharedMemoryMapping *virtio_find_shmem_map(VirtioSharedMemory *sh=
mem,
> >+                                          hwaddr offset, uint64_t size)
> >+{
> >+    VirtioSharedMemoryMapping *mapping;
> >+    QTAILQ_FOREACH(mapping, &shmem->mmaps, link) {
> >+        if (mapping->offset =3D=3D offset && mapping->len =3D=3D size) =
{
> >+            return mapping;
> >+        }
> >+    }
> >+    return NULL;
> >+}
> >+
> >+void virtio_del_shmem_map(VirtioSharedMemory *shmem, hwaddr offset,
> >+                          uint64_t size)
> >+{
> >+    VirtioSharedMemoryMapping *mapping =3D virtio_find_shmem_map(shmem,=
 offset, size);
> >+    if (mapping =3D=3D NULL) {
> >+        return;
> >+    }
> >+
> >+    /*
> >+     * Remove from memory region first
> >+     */
> >+    memory_region_del_subregion(&shmem->mr, mapping->mr);
> >+
> >+    /*
> >+     * Remove from list and unref the mapping which will trigger automa=
tic cleanup
> >+     * when the reference count reaches zero.
> >+     */
> >+    QTAILQ_REMOVE(&shmem->mmaps, mapping, link);
> >+    object_unref(OBJECT(mapping));
> >+}
> >+
> > /* A wrapper for use as a VMState .put function */
> > static int virtio_device_put(QEMUFile *f, void *opaque, size_t size,
> >                               const VMStateField *field, JSONWriter *vm=
desc)
> >@@ -3237,6 +3404,7 @@ void virtio_reset(void *opaque)
> > {
> >     VirtIODevice *vdev =3D opaque;
> >     VirtioDeviceClass *k =3D VIRTIO_DEVICE_GET_CLASS(vdev);
> >+    VirtioSharedMemory *shmem;
> >     uint64_t features[VIRTIO_FEATURES_NU64S];
> >     int i;
> >
> >@@ -3276,6 +3444,15 @@ void virtio_reset(void *opaque)
> >     for (i =3D 0; i < VIRTIO_QUEUE_MAX; i++) {
> >         __virtio_queue_reset(vdev, i);
> >     }
> >+
> >+    /* Mappings are removed to prevent stale fds from remaining open. *=
/
> >+    QSIMPLEQ_FOREACH(shmem, &vdev->shmem_list, entry) {
> >+        while (!QTAILQ_EMPTY(&shmem->mmaps)) {
> >+            VirtioSharedMemoryMapping *mapping =3D QTAILQ_FIRST(&shmem-=
>mmaps);
> >+            virtio_del_shmem_map(shmem, mapping->offset,
> >+                                 memory_region_size(mapping->mr));
> >+        }
> >+    }
> > }
> >
> > static void virtio_device_check_notification_compatibility(VirtIODevice=
 *vdev,
> >@@ -3599,6 +3776,7 @@ void virtio_init(VirtIODevice *vdev, uint16_t
> >device_id, size_t config_size)
> >             NULL, virtio_vmstate_change, vdev);
> >     vdev->device_endian =3D virtio_default_endian();
> >     vdev->use_guest_notifier_mask =3D true;
> >+    QSIMPLEQ_INIT(&vdev->shmem_list);
> > }
> >
> > /*
> >@@ -4110,11 +4288,25 @@ static void virtio_device_free_virtqueues(VirtIO=
Device *vdev)
> > static void virtio_device_instance_finalize(Object *obj)
> > {
> >     VirtIODevice *vdev =3D VIRTIO_DEVICE(obj);
> >+    VirtioSharedMemory *shmem;
> >
> >     virtio_device_free_virtqueues(vdev);
> >
> >     g_free(vdev->config);
> >     g_free(vdev->vector_queues);
> >+    while (!QSIMPLEQ_EMPTY(&vdev->shmem_list)) {
> >+        shmem =3D QSIMPLEQ_FIRST(&vdev->shmem_list);
> >+        while (!QTAILQ_EMPTY(&shmem->mmaps)) {
> >+            VirtioSharedMemoryMapping *mapping =3D QTAILQ_FIRST(&shmem-=
>mmaps);
> >+            virtio_del_shmem_map(shmem, mapping->offset,
> >+                                 memory_region_size(mapping->mr));
> >+        }
> >+
> >+        /* Clean up the embedded MemoryRegion */
> >+        object_unparent(OBJECT(&shmem->mr));
> >+        QSIMPLEQ_REMOVE_HEAD(&vdev->shmem_list, entry);
> >+        g_free(shmem);
> >+    }
> > }
> >
> > static const Property virtio_properties[] =3D {
> >@@ -4480,9 +4672,18 @@ static const TypeInfo virtio_device_info =3D {
> >     .class_size =3D sizeof(VirtioDeviceClass),
> > };
> >
> >+static const TypeInfo virtio_shared_memory_mapping_info =3D {
> >+    .name =3D TYPE_VIRTIO_SHARED_MEMORY_MAPPING,
> >+    .parent =3D TYPE_OBJECT,
> >+    .instance_size =3D sizeof(VirtioSharedMemoryMapping),
> >+    .instance_init =3D virtio_shared_memory_mapping_instance_init,
> >+    .instance_finalize =3D virtio_shared_memory_mapping_instance_finali=
ze,
> >+};
> >+
> > static void virtio_register_types(void)
> > {
> >     type_register_static(&virtio_device_info);
> >+    type_register_static(&virtio_shared_memory_mapping_info);
> > }
> >
> > type_init(virtio_register_types)
> >diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
> >index 27cd98d2fe..40d881ca09 100644
> >--- a/include/hw/virtio/virtio.h
> >+++ b/include/hw/virtio/virtio.h
> >@@ -99,6 +99,45 @@ enum virtio_device_endian {
> >     VIRTIO_DEVICE_ENDIAN_BIG,
> > };
> >
> >+#define TYPE_VIRTIO_SHARED_MEMORY_MAPPING "virtio-shared-memory-mapping=
"
> >+OBJECT_DECLARE_SIMPLE_TYPE(VirtioSharedMemoryMapping, VIRTIO_SHARED_MEM=
ORY_MAPPING)
> >+
> >+/**
> >+ * VirtioSharedMemoryMapping:
> >+ * @parent: Parent QOM object
> >+ * @shmid: VIRTIO Shared Memory Region ID
> >+ * @fd: File descriptor for the shared memory region
>
> `fd` is not there anymore.

True. Thanks!


>
> The rest LGTM. I think we can eventually fix them later, so don't want
> to block this, but if you need to resend, please fix them.

Since I will send a follow up to fix the feature ID, I will update
with your comments. Thanks for reviewing!

>
> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
>


