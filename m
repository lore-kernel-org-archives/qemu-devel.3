Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9E4CCCD19A
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 12:14:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9jL1-0005e8-WD; Fri, 17 Oct 2025 08:13:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1v9jKy-0005dr-Tb
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 08:13:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1v9jKk-00056b-NW
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 08:13:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760703191;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/oDqgWVHWZoEXRB8GgEmFMcQ/H1zY6XAWMo16/1F0L0=;
 b=J4mXSe6Y6L5VzXs/Gdf1HCrkz0kLx/tRaJzYZU2jXIIYjpravPGVfJDmxoX00LeaBgcfF+
 JgNxXo+bMYRLBF7ODelaPueRrGF50JfK1+sCLAx/2OPv4uBlTcIcerjA9vEPpPSHOsQXGy
 WZaAdMyJNTcMzhRJTvZwKt/m32Lzxn8=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-80-4tkQLVfdOhSrab_hRn_E3g-1; Fri, 17 Oct 2025 08:13:10 -0400
X-MC-Unique: 4tkQLVfdOhSrab_hRn_E3g-1
X-Mimecast-MFC-AGG-ID: 4tkQLVfdOhSrab_hRn_E3g_1760703189
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-8900dedd50aso258932785a.0
 for <qemu-devel@nongnu.org>; Fri, 17 Oct 2025 05:13:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760703189; x=1761307989;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/oDqgWVHWZoEXRB8GgEmFMcQ/H1zY6XAWMo16/1F0L0=;
 b=Rl3zhjSXHwWcM5UNZP8l7e9B/tjUzP7nJtZS87yBZzIYZaiRpMqdeu2mmpB3HmzQYr
 QNbOvDA45HAMFZ/QeWTq58P/GulV6r7yGvM9Qx3pElZgKx+Q6IvW7Md7rpBl+0+mSwoV
 J/W2Y7ih0ASJ8dwCjzjJe/a+7XYtOuHT0LVIp5kOnuLPSN01Dml2WsbN1JVI3foXWXKZ
 i+A9+lKyWtoERQ05+jwR+fh31SNvjDAPV57c0EIMeIDTHknhvsdX8UB9igGMY9d7Jsh3
 F2HA5xiLyGXeaat0YGHwwHI5QsrKM3UyotHWETT0GaGCvbDyT8nchvtm+38XAyWUcP8E
 ziOw==
X-Gm-Message-State: AOJu0Yy4dNfpABJt49lLjBKdFh6yjyOctRaEmqxsX6IPoBSN9vXod2qp
 TcK59dYxmCElqv0CEgfLXgVckrzlWpCAAM9uqXEmphMI2xDCYS6MRNFT0heg452QBKxypmrVwz/
 2onqsSWQvpmm5KWvyJ3Oh7iq+vP0Nm1USMEd98i3N9HXS0eUm9S6avink
X-Gm-Gg: ASbGncsFzqzA5ly3BtgH1sYn/pnOoA4FV4dXIpNOSgtonSMDl/JU2DiyBRMf39gOU+H
 VN8LhEGF+TzXrR3vK8JZy91H+WkX/Pc5kmP7VNQRTEtNc29s8Bla+tUY8b7gGDFUnAt9SDegAyf
 WzNMVhNSy3xgVQvrBF7cEDDWM6GmNBJxjWhH8WKygEE0OM7VKom1PeFswWM/CIqcnYk8gl9x4FN
 GOByGo4vKdYFconuWNUbZX7G0Gxv+VZg4Ioe5nPZg5Df5ozxDEJb4tmqp0jCRz0J+Ru+cD2fyx5
 BKQkyKe/1MZl+D9wOFztOCURJbrOAs23y19l3TRBjHQ6Esv2Qe78ulI+Ph3LuPxZUej2sAT0bHC
 GHcaXOhIb8h4HkTMYyeq6xids28dGIr9W63qUn15K2U/BxW7xs5Y=
X-Received: by 2002:a05:620a:1999:b0:85b:475e:594d with SMTP id
 af79cd13be357-890708f1b81mr398519385a.46.1760703189381; 
 Fri, 17 Oct 2025 05:13:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IELmNCn8ZDx/1njJFYWcYPCbCghS8eXjM+EKrndFDtFLriHfDkBCMWAeyp8pRHpFYqWUgs8Aw==
X-Received: by 2002:a05:620a:1999:b0:85b:475e:594d with SMTP id
 af79cd13be357-890708f1b81mr398513085a.46.1760703188659; 
 Fri, 17 Oct 2025 05:13:08 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-153.retail.telecomitalia.it.
 [79.46.200.153]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-88f3861af0dsm413339385a.54.2025.10.17.05.13.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Oct 2025 05:13:08 -0700 (PDT)
Date: Fri, 17 Oct 2025 14:12:38 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Albert Esteve <aesteve@redhat.com>
Cc: qemu-devel@nongnu.org, 
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, hi@alyssa.is,
 stefanha@redhat.com, david@redhat.com, 
 jasowang@redhat.com, dbassey@redhat.com, stevensd@chromium.org, 
 Laurent Vivier <lvivier@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 slp@redhat.com, manos.pitsidianakis@linaro.org
Subject: Re: [PATCH v10 1/7] vhost-user: Add VirtIO Shared Memory map request
Message-ID: <5eyt46m7aausn2b26cgtjxhqwt7f6iia3wj7c2kkjaxjjic64p@dyhbrjq32djr>
References: <20251016143827.1850397-1-aesteve@redhat.com>
 <20251016143827.1850397-2-aesteve@redhat.com>
 <nl5smdnd5neyuqykpwkruq2onc32hq7jbgbylv33xq4rrsksvc@hk6u3b33iws3>
 <CADSE00+2PU0auFOMaSpgH3dgQ9UgYp+nsAusuQa=ZXbd=JLreQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADSE00+2PU0auFOMaSpgH3dgQ9UgYp+nsAusuQa=ZXbd=JLreQ@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
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

On Fri, Oct 17, 2025 at 01:24:52PM +0200, Albert Esteve wrote:
>On Fri, Oct 17, 2025 at 11:23 AM Stefano Garzarella <sgarzare@redhat.com> wrote:
>>
>> On Thu, Oct 16, 2025 at 04:38:21PM +0200, Albert Esteve wrote:
>> >Add SHMEM_MAP/UNMAP requests to vhost-user for dynamic management of
>> >VIRTIO Shared Memory mappings.
>> >
>> >This implementation introduces VirtioSharedMemoryMapping as a unified
>> >QOM object that manages both the mapping metadata and MemoryRegion
>> >lifecycle. This object provides reference-counted lifecycle management
>> >with automatic cleanup of file descriptors and memory regions
>> >through QOM finalization.
>> >
>> >This request allows backends to dynamically map file descriptors into a
>> >VIRTIO Shared Memory Region identified by their shmid. Maps are created
>> >using memory_region_init_ram_from_fd() with configurable read/write
>> >permissions, and the resulting MemoryRegions are added as subregions to
>> >the shmem container region. The mapped memory is then advertised to the
>> >guest VIRTIO drivers as a base address plus offset for reading and
>> >writting according to the requested mmap flags.
>> >
>> >The backend can unmap memory ranges within a given VIRTIO Shared Memory
>> >Region to free resources. Upon receiving this message, the frontend
>> >removes the MemoryRegion as a subregion and automatically unreferences
>> >the VirtioSharedMemoryMapping object, triggering cleanup if no other
>> >references exist.
>> >
>> >Error handling has been improved to ensure consistent behavior across
>> >handlers that manage their own vhost_user_send_resp() calls. Since
>> >these handlers clear the VHOST_USER_NEED_REPLY_MASK flag, explicit
>> >error checking ensures proper connection closure on failures,
>> >maintaining the expected error flow.
>> >
>> >Note the memory region commit for these operations needs to be delayed
>> >until after we reply to the backend to avoid deadlocks. Otherwise,
>> >the MemoryListener would send a VHOST_USER_SET_MEM_TABLE message
>> >before the reply.
>> >
>> >Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
>> >Signed-off-by: Albert Esteve <aesteve@redhat.com>
>> >---
>> > hw/virtio/vhost-user.c                    | 267 ++++++++++++++++++++++
>> > hw/virtio/virtio.c                        | 199 ++++++++++++++++
>> > include/hw/virtio/virtio.h                | 135 +++++++++++
>> > subprojects/libvhost-user/libvhost-user.c |  70 ++++++
>> > subprojects/libvhost-user/libvhost-user.h |  54 +++++
>> > 5 files changed, 725 insertions(+)
>> >
>> >diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
>> >index 36c9c2e04d..890be55937 100644
>> >--- a/hw/virtio/vhost-user.c
>> >+++ b/hw/virtio/vhost-user.c
>> >@@ -104,6 +104,7 @@ typedef enum VhostUserRequest {
>> >     VHOST_USER_GET_SHARED_OBJECT = 41,
>> >     VHOST_USER_SET_DEVICE_STATE_FD = 42,
>> >     VHOST_USER_CHECK_DEVICE_STATE = 43,
>> >+    VHOST_USER_GET_SHMEM_CONFIG = 44,
>> >     VHOST_USER_MAX
>> > } VhostUserRequest;
>> >
>> >@@ -115,6 +116,8 @@ typedef enum VhostUserBackendRequest {
>> >     VHOST_USER_BACKEND_SHARED_OBJECT_ADD = 6,
>> >     VHOST_USER_BACKEND_SHARED_OBJECT_REMOVE = 7,
>> >     VHOST_USER_BACKEND_SHARED_OBJECT_LOOKUP = 8,
>> >+    VHOST_USER_BACKEND_SHMEM_MAP = 9,
>> >+    VHOST_USER_BACKEND_SHMEM_UNMAP = 10,
>> >     VHOST_USER_BACKEND_MAX
>> > }  VhostUserBackendRequest;
>> >
>> >@@ -136,6 +139,12 @@ typedef struct VhostUserMemRegMsg {
>> >     VhostUserMemoryRegion region;
>> > } VhostUserMemRegMsg;
>> >
>> >+typedef struct VhostUserShMemConfig {
>> >+    uint32_t nregions;
>> >+    uint32_t padding;
>> >+    uint64_t memory_sizes[VIRTIO_MAX_SHMEM_REGIONS];
>> >+} VhostUserShMemConfig;
>> >+
>> > typedef struct VhostUserLog {
>> >     uint64_t mmap_size;
>> >     uint64_t mmap_offset;
>> >@@ -192,6 +201,23 @@ typedef struct VhostUserShared {
>> >     unsigned char uuid[16];
>> > } VhostUserShared;
>> >
>> >+/* For the flags field of VhostUserMMap */
>> >+#define VHOST_USER_FLAG_MAP_RW (1u << 0)
>> >+
>> >+typedef struct {
>> >+    /* VIRTIO Shared Memory Region ID */
>> >+    uint8_t shmid;
>> >+    uint8_t padding[7];
>> >+    /* File offset */
>> >+    uint64_t fd_offset;
>> >+    /* Offset within the VIRTIO Shared Memory Region */
>> >+    uint64_t shm_offset;
>> >+    /* Size of the mapping */
>> >+    uint64_t len;
>> >+    /* Flags for the mmap operation, from VHOST_USER_FLAG_MAP_* */
>> >+    uint64_t flags;
>> >+} VhostUserMMap;
>> >+
>> > typedef struct {
>> >     VhostUserRequest request;
>> >
>> >@@ -224,6 +250,8 @@ typedef union {
>> >         VhostUserInflight inflight;
>> >         VhostUserShared object;
>> >         VhostUserTransferDeviceState transfer_state;
>> >+        VhostUserMMap mmap;
>> >+        VhostUserShMemConfig shmem;
>> > } VhostUserPayload;
>> >
>> > typedef struct VhostUserMsg {
>> >@@ -1768,6 +1796,196 @@ vhost_user_backend_handle_shared_object_lookup(struct vhost_user *u,
>> >     return 0;
>> > }
>> >
>> >+/**
>> >+ * vhost_user_backend_handle_shmem_map() - Handle SHMEM_MAP backend request
>> >+ * @dev: vhost device
>> >+ * @ioc: QIOChannel for communication
>> >+ * @hdr: vhost-user message header
>> >+ * @payload: message payload containing mapping details
>> >+ * @fd: file descriptor for the shared memory region
>> >+ *
>> >+ * Handles VHOST_USER_BACKEND_SHMEM_MAP requests from the backend. Creates
>> >+ * a VhostUserShmemObject to manage the shared memory mapping and adds it
>> >+ * to the appropriate VirtIO shared memory region. The VhostUserShmemObject
>> >+ * serves as an intermediate parent for the MemoryRegion, ensuring proper
>> >+ * lifecycle management with reference counting.
>> >+ *
>> >+ * Returns: 0 on success, negative errno on failure
>> >+ */
>> >+static int
>> >+vhost_user_backend_handle_shmem_map(struct vhost_dev *dev,
>> >+                                    QIOChannel *ioc,
>> >+                                    VhostUserHeader *hdr,
>> >+                                    VhostUserPayload *payload,
>> >+                                    int fd)
>> >+{
>> >+    VirtioSharedMemory *shmem;
>> >+    VhostUserMMap *vu_mmap = &payload->mmap;
>> >+    VirtioSharedMemoryMapping *existing;
>> >+    Error *local_err = NULL;
>> >+    int ret = 0;
>> >+
>> >+    if (fd < 0) {
>> >+        error_report("Bad fd for map");
>> >+        ret = -EBADF;
>> >+        goto send_reply;
>> >+    }
>> >+
>> >+    if (QSIMPLEQ_EMPTY(&dev->vdev->shmem_list)) {
>> >+        error_report("Device has no VIRTIO Shared Memory Regions. "
>> >+                     "Requested ID: %d", vu_mmap->shmid);
>> >+        ret = -EFAULT;
>> >+        goto send_reply;
>> >+    }
>> >+
>> >+    shmem = virtio_find_shmem_region(dev->vdev, vu_mmap->shmid);
>> >+    if (!shmem) {
>> >+        error_report("VIRTIO Shared Memory Region at "
>> >+                     "ID %d not found or uninitialized", vu_mmap->shmid);
>> >+        ret = -EFAULT;
>> >+        goto send_reply;
>> >+    }
>> >+
>> >+    if ((vu_mmap->shm_offset + vu_mmap->len) < vu_mmap->len ||
>> >+        (vu_mmap->shm_offset + vu_mmap->len) > shmem->mr.size) {
>> >+        error_report("Bad offset/len for mmap %" PRIx64 "+%" PRIx64,
>> >+                     vu_mmap->shm_offset, vu_mmap->len);
>> >+        ret = -EFAULT;
>> >+        goto send_reply;
>> >+    }
>> >+
>> >+    QTAILQ_FOREACH(existing, &shmem->mmaps, link) {
>> >+        if (ranges_overlap(existing->offset, existing->len,
>> >+                           vu_mmap->shm_offset, vu_mmap->len)) {
>> >+            error_report("VIRTIO Shared Memory mapping overlap");
>> >+            ret = -EFAULT;
>> >+            goto send_reply;
>> >+        }
>> >+    }
>> >+
>> >+    memory_region_transaction_begin();
>> >+
>> >+    /* Create VirtioSharedMemoryMapping object */
>> >+    VirtioSharedMemoryMapping *mapping = virtio_shared_memory_mapping_new(
>> >+        vu_mmap->shmid, fd, vu_mmap->fd_offset, vu_mmap->shm_offset,
>> >+        vu_mmap->len, vu_mmap->flags & VHOST_USER_FLAG_MAP_RW);
>> >+
>> >+    if (!mapping) {
>> >+        ret = -EFAULT;
>> >+        goto send_reply_commit;
>> >+    }
>> >+
>> >+    /* Add the mapping to the shared memory region */
>> >+    if (virtio_add_shmem_map(shmem, mapping) != 0) {
>> >+        error_report("Failed to add shared memory mapping");
>> >+        object_unref(OBJECT(mapping));
>> >+        ret = -EFAULT;
>> >+        goto send_reply_commit;
>> >+    }
>> >+
>> >+send_reply_commit:
>> >+    /* Send reply and commit after transaction started */
>> >+    if (hdr->flags & VHOST_USER_NEED_REPLY_MASK) {
>> >+        payload->u64 = !!ret;
>> >+        hdr->size = sizeof(payload->u64);
>> >+        if (!vhost_user_send_resp(ioc, hdr, payload, &local_err)) {
>> >+            error_report_err(local_err);
>> >+            memory_region_transaction_commit();
>> >+            return -EFAULT;
>> >+        }
>> >+    }
>> >+    memory_region_transaction_commit();
>>
>> Sorry to be late, I did a quick review, my only doubts is here, maybe it
>> was already discussed, but why do we commit after responding to the
>> backend?
>>
>> Should we do it first to prevent the backend from “seeing” something
>> that hasn't been committed yet?
>
>There is a race that leads to a deadlock. hw/virtio/vhost.c has a
>MemoryListener that sends VHOST_USER_SET_MEM_TABLE messages in its
>.commit() callback. If this happens before the reply, the backend will
>not process it as it is stuck waiting for the SHMEM reply, and the
>handler in qemu will not send it as it is waiting for the reply to the
>SET_MEM_TABLE. So we have to delay the transaction commit to
>immediately after the reply.

Okay, I see now that you mentioned that in the commit description, 
great, I should have read it more carefully!
IMO it would be worth adding a comment here, but I definitely won't ask 
you to send a v11 for this! (maybe a followup patch later).

>
>>
>> Also, if vhost_user_send_resp() fails, should we call
>> virtio_del_shmem_map()?
>
>If vhost_user_send_resp() fails, the connection with the backend is
>closed, so the mappings will indeed never be removed unless we reset.
>
>Maybe better than removing the single mapping, would be to loop
>through mappings in the shared memory and clean them all (same we do :
>
>```
>        while (!QTAILQ_EMPTY(&shmem->mmaps)) {
>            VirtioSharedMemoryMapping *mapping = QTAILQ_FIRST(&shmem->mmaps);
>            virtio_del_shmem_map(shmem, mapping->offset, mapping->mr->size);
>        }
>```
>
>But since a backend may utilize more than one shared memory region,
>and we do not know the mapping between a given backend and its shared
>memories, whatever we do will be incomplete (?).

I don't know if this is the right place to do this kind of cleanup, 
maybe further up in the stack.


>I think the only
>solution after this happens is to reset (virtio_reset) to remove all
>mappings from the all shared regions, and re-establish the backend
>channel (is it possible?). Even if the channel cannot be restablished,
>I wouldn't bother just removing one mapping, I would assume it needs a
>reset.

So, in conclusion, we are saying that if we can no longer communicate 
with the backend, there is no point in maintaining a consistent state, 
because we have to reset the device anyway.
Are we already doing this, or should we be doing it?

BTW, I don't want to stop this series, I just found this error path 
strange.

Thanks,
Stefano


