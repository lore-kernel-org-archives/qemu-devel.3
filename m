Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4CF9C44507
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 10:34:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkfsz-0003KU-Jt; Fri, 17 Jul 2026 06:33:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbassey@redhat.com>)
 id 1wkfsv-0003Je-OW
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 06:33:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbassey@redhat.com>)
 id 1wkfsr-0001QZ-J7
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 06:33:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784284407;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Jf30dL8Lh4Vek0qz4aE62PpGyRERpDruf5mfOsXxdLI=;
 b=JDf3fgQRLPJ0I+0TlUztxQBlsdcZSulX3HnwPeb89NdtAMSNtncZ8Jb4vJvylz/KrN+ZEM
 aopl7W6sSx1pnDTwB6jp8Mr1Ao7Drx0zFjNkLlPyHaJCSUrEy7ykmMb3ea7JqYXTqLN6L+
 WZkJpvXLpSWUJ3MukoBwNo3yO7ZsLBQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-346-ZEHkV15jOZuz-pkywX5wEg-1; Fri, 17 Jul 2026 06:33:25 -0400
X-MC-Unique: ZEHkV15jOZuz-pkywX5wEg-1
X-Mimecast-MFC-AGG-ID: ZEHkV15jOZuz-pkywX5wEg_1784284404
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-47f2ed7cc45so5104744f8f.2
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 03:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784284404; x=1784889204; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Jf30dL8Lh4Vek0qz4aE62PpGyRERpDruf5mfOsXxdLI=;
 b=ZL3by/EZTU+FRnfKJ80YOWjrS5zGnVeWi7Vmws9m4DXlMnIK0fjbA7piq63owhGoyZ
 4RgI+wlNIwYmdGhgi7P/MsAs+w2gZvvHrqoQE8N/0OdwObHgyUh8yMxoD43xlKBDWh4o
 kdu4IuufUTPGopY4p+fGgRHey2/6LNRU2NJKflhPEQUkVM+7NwQkpepgjRz3jI/uED2O
 0Bz68sY7gLU7einAgMicMqiPRsqrTNxt6FdAIQQyC6FkrKdoq1zv+TV0C7q6sPDtH8PF
 HSS2DtanKPmO09LDGTJLNuhRR5VgLQJolW1DGT0pldq8EYRyRDdZfKahKDSeGvDzj25P
 F9nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784284404; x=1784889204;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Jf30dL8Lh4Vek0qz4aE62PpGyRERpDruf5mfOsXxdLI=;
 b=nSfuxxWkKIljZ9eH/AH8ZdcZR0LXnJmnrGORYNE1PXSva1o3xEZk/dQDHFxBWUf/tW
 NbEuho8bDFziL+Fnpn97DQcm6O0SKoAAZ2cmz5f6kmERcx8nCnBKW61NjVXa1ocq8HkP
 2TFaNCFb2z0XwAEQkmYRPFY1a9s8fHRyzBasRPO9HM25vRuZD/YvRqT80Uu3LhCK3nS/
 heRtS7uQr9ZRYOoDF8gd3FBy9KaUlhj2VN54HU5jEMWHdMXwRxvVwk2tFVOdWBLg8AZ6
 BNuvoJgLi+BXKRFwbT0y6Hq5vFp2SPmA1dGQ5DWV9nWRymD8v3Dssf3VYaIAAD10W/Y0
 jh1A==
X-Gm-Message-State: AOJu0Yw+wwia7eUofEDCO3eF/5AY8pUOwxxYGM1Tg3agMN6ybZt7EhQG
 DPzT6mWFZqtzwq6Nfpe6qKgeNQO3tirExp2xYCRFOuZCe7Xm6/NNtfQWz95fDCidVWuc9iRXfeX
 cwFDLXTNp1A+t7iLOBSSIa9wv0pZdHlnyNpicn1Yz7XCY0IfzCp8/Pn1GmN6P/reZSrZw6cjd/f
 fkzwwu725XXAm+AEOPSS+sESEE/xjrXQ/L4io95ZtxlAGS
X-Gm-Gg: AfdE7clqvdxa7ZCAm1ljDTWQzywwqHWLwzIjrEU45MwqNG+iWN21Cob3oCcGr66FzAx
 T0r/iDYCjDjw8NwghaMjLQQsBBguGvMAptKM+7gOuJPYou5rrbr5XCPKyolNhNTyKXlBVywLPCJ
 cD69iDDM+BEMg0ePS28w9mdOF0epTKCzMk57ObFNlqxYzh8cPxgsal7WgbxHQwqnMC90f7PsQa4
 ga6Qt1S5FgNzN0xKg2XRU1wxreGMu52eRr2t9674bGQvW8lRhNI5q7AAKaB4k5X+KLk9e0mBB0i
 dZOk2BP3zhrjzOVumxujSzKyvObvPxQuA69gLQO8H3gXzBxFlFxjJrL0VfBF9+Xha/Poua+1WuS
 y+0C/YxaBUPUVdwHOIk9tibNfB4C2qZGHAHa3mqEzciQ7UnHl58Kx34wkEd0GcMsuwLgrx2/Rhx
 sHYWPsEi0=
X-Received: by 2002:a05:6000:2f83:b0:476:504f:7a8 with SMTP id
 ffacd0b85a97d-47f6233ee55mr2759533f8f.55.1784284404440; 
 Fri, 17 Jul 2026 03:33:24 -0700 (PDT)
X-Received: by 2002:a05:6000:2f83:b0:476:504f:7a8 with SMTP id
 ffacd0b85a97d-47f6233ee55mr2759483f8f.55.1784284403923; 
 Fri, 17 Jul 2026 03:33:23 -0700 (PDT)
Received: from fedora (cst-prg-95-48.cust.vodafone.cz. [46.135.95.48])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f63ed2313sm2523298f8f.23.2026.07.17.03.33.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jul 2026 03:33:23 -0700 (PDT)
From: Dorinda Bassey <dbassey@redhat.com>
To: qemu-devel@nongnu.org
Cc: mhrica@redhat.com, mst@redhat.com, sgarzare@redhat.com,
 manos.pitsidianakis@linaro.org, marcandre.lureau@redhat.com,
 stefanha@redhat.com, pbonzini@redhat.com, aesteve@redhat.com,
 Dorinda Bassey <dbassey@redhat.com>
Subject: [PATCH v3 1/3] vhost: Fix SHMEM_MAP transaction ordering and
 resulting deadlock
Date: Fri, 17 Jul 2026 12:32:59 +0200
Message-ID: <20260717103301.228974-2-dbassey@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260717103301.228974-1-dbassey@redhat.com>
References: <20260717103301.228974-1-dbassey@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: permerror client-ip=170.10.133.124;
 envelope-from=dbassey@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001, T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

Commit the memory region transaction before sending the SHMEM_MAP reply
so the KVM memory slot exists before the guest can access the mapped
region.

This moves the commit to while the backend is still blocked waiting for
the reply, which can trigger ADD_MEM_REG back to the backend and
deadlock. Filter shmem mapping regions out of vhost_section() by
checking the MR owner type to prevent this.

The explicit transaction begin/commit wrapping is dropped since
virtio_add_shmem_map() already commits via memory_region_add_subregion().

Fixes: b52e1896e764 ("vhost-user: Add VirtIO Shared Memory map request")
Suggested-by: Albert Esteve <aesteve@redhat.com>
Signed-off-by: Dorinda Bassey <dbassey@redhat.com>
---
 hw/virtio/vhost-user.c | 20 ++------------------
 hw/virtio/vhost.c      | 10 ++++++++++
 2 files changed, 12 insertions(+), 18 deletions(-)

diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 517cc4ca716..01468f7441a 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -1977,8 +1977,6 @@ vhost_user_backend_handle_shmem_map(struct vhost_dev *dev,
         }
     }
 
-    memory_region_transaction_begin();
-
     /* Create VirtioSharedMemoryMapping object */
     VirtioSharedMemoryMapping *mapping = virtio_shared_memory_mapping_new(
         vu_mmap->shmid, fd, vu_mmap->fd_offset, vu_mmap->shm_offset,
@@ -1986,7 +1984,7 @@ vhost_user_backend_handle_shmem_map(struct vhost_dev *dev,
 
     if (!mapping) {
         ret = -EFAULT;
-        goto send_reply_commit;
+        goto send_reply;
     }
 
     /* Add the mapping to the shared memory region */
@@ -1994,22 +1992,8 @@ vhost_user_backend_handle_shmem_map(struct vhost_dev *dev,
         error_report("Failed to add shared memory mapping");
         object_unref(OBJECT(mapping));
         ret = -EFAULT;
-        goto send_reply_commit;
-    }
-
-send_reply_commit:
-    /* Send reply and commit after transaction started */
-    if (hdr->flags & VHOST_USER_NEED_REPLY_MASK) {
-        payload->u64 = !!ret;
-        hdr->size = sizeof(payload->u64);
-        if (!vhost_user_send_resp(ioc, hdr, payload, &local_err)) {
-            error_report_err(local_err);
-            memory_region_transaction_commit();
-            return -EFAULT;
-        }
+        goto send_reply;
     }
-    memory_region_transaction_commit();
-    return 0;
 
 send_reply:
     if (hdr->flags & VHOST_USER_NEED_REPLY_MASK) {
diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index af41841b529..e5c219be095 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -636,6 +636,16 @@ static bool vhost_section(struct vhost_dev *dev, MemoryRegionSection *section)
 {
     MemoryRegion *mr = section->mr;
 
+    /*
+     * Skip shmem mapping regions, they are managed via SHMEM_MAP/UNMAP.
+     * Including them triggers ADD_MEM_REG during the SHMEM_MAP transaction
+     * commit, deadlocking the backend.
+     */
+    if (object_dynamic_cast(memory_region_owner(mr),
+                            TYPE_VIRTIO_SHARED_MEMORY_MAPPING)) {
+        return false;
+    }
+
     if (memory_region_is_ram(mr) && !memory_region_is_rom(mr)) {
         uint8_t dirty_mask = memory_region_get_dirty_log_mask(mr);
         uint8_t handled_dirty;
-- 
2.52.0


