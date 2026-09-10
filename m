Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAFFBC88E41
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 21:31:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4mHS-0000nJ-Is; Thu, 10 Sep 2026 17:26:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4lJU-0002KQ-8L
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 16:24:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4lJ7-00085B-35
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 16:23:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789071603;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PDrhF8GFxx7xPnASxg3T8JG+Bhc76LAfLhogtUAUv9Y=;
 b=i0toPnbGEz1FN/EnR4vPWn6YPBr6+WoGk6hMJ92/pdjVY+Jg4plqaEvLXL5aOaY9XztHAO
 qWpFgZsOJt0IkYbpIZ7MfgDtuwGgHMBkKbYpK16PZTOsv0Y/oH/jNsKW1qLRHuK7+JCRFx
 fQEq+HvmhQpXl8iZ3NEraA5gjVsVwu8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-DwJAN87sMwmrNjtATGOavQ-1; Thu, 10 Sep 2026 16:13:54 -0400
X-MC-Unique: DwJAN87sMwmrNjtATGOavQ-1
X-Mimecast-MFC-AGG-ID: DwJAN87sMwmrNjtATGOavQ_1789071233
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-49564d4b849so500465e9.3
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 13:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789071233; x=1789676033; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=PDrhF8GFxx7xPnASxg3T8JG+Bhc76LAfLhogtUAUv9Y=;
 b=LgeGEGTd8XjsVuuYK2H5UO+P8sQAZwjk8aNWuvrS2vUMs/WuY5FC0o8IlxsFIAxXj/
 +cIydKe1paXvbx8sWmreBmyvXzfxNzPHUgnykH+3VZuJIOLLe7UdWfonLcg2uGNwG82N
 POlsVoixIsE8O+BK+rqK+qPFvMFXZKnfXZukQf85lY4wNCuZH8vgeavIY7TitQZJ3h5L
 SqZff7BXZGUi8JaXwGgsXX+JiA1zGRel+ZoY/p5yKrWFUZwrPIsIBLWdykvTXNpPFhpM
 /L0/NnifTpagrCUw8e1rLnHQ/4wS2oEQKQQbeGq87Xtgm5jB2rAWBgDsc6ezEApXeQ3Y
 iLTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789071233; x=1789676033;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=PDrhF8GFxx7xPnASxg3T8JG+Bhc76LAfLhogtUAUv9Y=;
 b=QcSjYhREx9L343DCb4OV/tvSG6pn7u0AjZd44+1XynEc4HYfTxhbw50bvZABr0s4KG
 GxT+aF/ju6klO9Mz1gfvgy/SIHwDY/I8sfesjE0croxmY8coEgnUqufwO+FuzcqXdeFs
 DWc3ZYvHTiD1O1Nsb6yv+uz/yzMqzkOBd5mRktlxyBsr6NwLqr4UlTmQKxjaJ9qvs9Bd
 KJlDBK2D4PktivJow3TX0ZPdUxzjxoljCkv/Akr2ZD9FIFo6lfxBo+vrSX4UcY08tRKv
 ol7HpyaVmQ6nGCeaTeAP02WIEYkQAC0CC1cSUcRGoW3pKprV5Ze9VCedlbTZp8neBp8D
 b7JA==
X-Gm-Message-State: AFuF++keHG7TXMCfsZ5SDvUm6z6GGXBBazaQkEA0J0uTzF5oMz9LI7w6
 CMzLeIyri6XR+EdzrC8JV44ZDFx9pmH3kjx8tEmjtSQVGKE0TgaEFhm9uNUJ1yPRiNuA0MCBOqo
 s+54Owv9/9PJNkeguWLVxLNOVVu1gEgxK5hnxLkQk18eOZkLzEkNpj83UI+yL3Ytwp0v4QJD8ih
 bl7OJKffjqp8pS1PvhBgyEfkZ0mzScbF3E5A==
X-Gm-Gg: AYBFou2uGkOWzNADrWz6W2rNDU0dkTnYOLy+EY8LmyQMsDP3BZq+ZN/XDkXSmJHFkcA
 Iro4LKQaKZHZ6vQQxSVdCvU4AdKOSiZ+fpcmL/irSR+L8QPeehT2r0nFtNGcAe6lsMKPAHtIIYn
 POX5A/XbGknGhjfgC/ZaYa7WLJ4mS+lgzQPZbITjK+g4V2R5QL26ScrR+rzWzCqdRgJhCnvKOdc
 VhgwRtG6iH+0l5Oms8GWj75Zwet7HdRAksPbXKTsKWCbbTHs9KAY5ZEksmOtAj5DiMa1QHnPRfx
 vHx19Iev+eAqL+YgbQ8lXQfi65CiEmC5JghIyNqeXinh3UncdeHozFXH9wrHbg2SlcjZXqFqoPG
 3PQsGNsGnKmJmjT6MQnSXAO8=
X-Received: by 2002:a05:600d:864d:10b0:499:bf8c:cfd1 with SMTP id
 5b1f17b1804b1-49e61983764mr5917505e9.2.1789071232651; 
 Thu, 10 Sep 2026 13:13:52 -0700 (PDT)
X-Received: by 2002:a05:600d:864d:10b0:499:bf8c:cfd1 with SMTP id
 5b1f17b1804b1-49e61983764mr5917075e9.2.1789071231989; 
 Thu, 10 Sep 2026 13:13:51 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49d26be3e0asm100957055e9.1.2026.09.10.13.13.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 13:13:51 -0700 (PDT)
Date: Thu, 10 Sep 2026 16:13:49 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Feifan Qian <bea1e@proton.me>,
 Albert Esteve <aesteve@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PULL 57/90] vhost-user: Reject SHMEM_MAP when no KVM memory slot is
 left
Message-ID: <45623631fdf38e6a725bc2487ce22a04f04c40ae.1789071043.git.mst@redhat.com>
References: <cover.1789071042.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1789071042.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Feifan Qian <bea1e@proton.me>

Each SHMEM_MAP request creates a separate RAM MemoryRegion that
consumes a KVM memory slot. Once all KVM slots are in use, processing
another SHMEM_MAP request would make the KVM memory listener fail while
registering the new region.

Shared memory mappings are filtered out of the vhost memory table
(vhost_section() skips TYPE_VIRTIO_SHARED_MEMORY_MAPPING regions), so
they never count against the negotiated vhost-user slot limit; only
the KVM slot budget applies. Reject the request with ENOSPC before
changing the memory topology when KVM has no free slot left.

Also validate each vhost memory table against the slot limit negotiated
with the backend before sending regions via SET_MEM_TABLE or
ADD_MEM_REG.

Fixes: b52e1896e764 ("vhost-user: Add VirtIO Shared Memory map request")
Signed-off-by: Feifan Qian <bea1e@proton.me>
Reviewed-by: Albert Esteve <aesteve@redhat.com>
Acked-by: Stefano Garzarella <sgarzare@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <HXrBMZ9Gx9L-VxdMEr26ORPUYQn99p4rgEYVkeMHA4-5M49Ax3_mx1euIWe7uj33nl5mZ19sZeUDyksqxKT7H1WPxWhYtxdomofcVTyMTjo=@proton.me>
---
 hw/virtio/vhost-user.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index fac02a1ffc..f737a05d07 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -1126,6 +1126,13 @@ static int vhost_user_set_mem_table(struct vhost_dev *dev,
             dev, VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS);
     int ret;
 
+    if (mem->nregions > u->user->memory_slots) {
+        error_report("vhost-user memory table has %u regions, "
+                     "but the backend supports only %d",
+                     mem->nregions, u->user->memory_slots);
+        return -ENOSPC;
+    }
+
     if (do_postcopy) {
         /*
          * Postcopy has enough differences that it's best done in it's own
@@ -1980,6 +1987,17 @@ vhost_user_backend_handle_shmem_map(struct vhost_dev *dev,
         }
     }
 
+    /*
+     * Each SHMEM mapping becomes a separate RAM MemoryRegion and thus
+     * consumes a KVM memory slot. Reject the request before changing the
+     * memory topology if no slot is left.
+     */
+    if (kvm_enabled() && !kvm_get_free_memslots()) {
+        error_report("No free KVM memory slots for shared memory mapping");
+        ret = -ENOSPC;
+        goto send_reply;
+    }
+
     /* Create VirtioSharedMemoryMapping object */
     VirtioSharedMemoryMapping *mapping = virtio_shared_memory_mapping_new(
         vu_mmap->shmid, fd, vu_mmap->fd_offset, vu_mmap->shm_offset,
-- 
MST


