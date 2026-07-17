Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28690C4451B
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 13:51:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkixW-0004St-W2; Fri, 17 Jul 2026 09:50:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbassey@redhat.com>)
 id 1wkiwo-0004FH-Ii
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 09:49:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbassey@redhat.com>)
 id 1wkiwm-0001Xt-Uh
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 09:49:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784296187;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f7fEN9p3YFcRJxQVbUrtqGwOhTf7ACd7FeDVIrSzydk=;
 b=eJG+B2Cgsjd5821Bgs99yyH734CVHGorJJCOtkkHa227PvF9CcA7FnboLXE96gkCRFo85C
 qgCvl0FqWSyeS+EIGkp2DBaVobCKMrNGrO3+kIgN6ZVjCcoSLqIXydIfe+TtLc9ZHmb+0w
 gHnBT2VHmMs9RC24Op8tDsD1D7WigYE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-203-__mWVRIUOaqKbISoLkJP-Q-1; Fri, 17 Jul 2026 09:49:46 -0400
X-MC-Unique: __mWVRIUOaqKbISoLkJP-Q-1
X-Mimecast-MFC-AGG-ID: __mWVRIUOaqKbISoLkJP-Q_1784296185
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-49547298689so5745895e9.1
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 06:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784296185; x=1784900985; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=f7fEN9p3YFcRJxQVbUrtqGwOhTf7ACd7FeDVIrSzydk=;
 b=YBsp6Y8tOJ1XqF0Ah9Nk9k4n+G6DnmYC4PslaXzHwfrzqdD6wJ8m3BNaWvfLUqXvPO
 1VqlgQFcLQ0Lc8shb5AepNJQ67O/ky5cicYaih3629O5iL1+r5rBUT0FBIetXoMs5Eqs
 ufoYjUJZkhM9JPihVrMHNbtAElY9FOmHsiaKny8+HaZ0SULB4ul5vuBzoLb//XPQHJLS
 zJ19pkDYcw1KnkrqBKgrYDNxFCxBD+IWUf0JiahrfhFKjZtT4gTJ7hESywGpd7GXD82I
 RMIDhbJbqgZ7JLf14N+zySzyTpTctWwYaEb1VzIdb4M4yuUNh436vOOdYHFyRzuVyUmD
 haYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784296185; x=1784900985;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=f7fEN9p3YFcRJxQVbUrtqGwOhTf7ACd7FeDVIrSzydk=;
 b=pNSEj2NP1uQPcyqnIfqpwzqzRjDsVIP0wJCTYHEg6tGB4Edt0sgkeyQyAaV7QGurLf
 lcZAO/66b+PzOFgksUWUrCfIl+gPGtAckn0zg1WoppP+Iz8jhPI5j1IFbHJeEBLxLCSb
 0lLqXnhEPXzKotfK4lK/G7smah4vPAoWqtcKpjynJ1Ev203WWjcAmmEGwW2SpOCGxbkq
 g+jeJplmu1VX9/zuDSaHas1rRq8fe9prMTq1VAhpHj/zQ1Fjws47QhenF6fIcPHqMd9E
 CyX3LFJV0y9x4IUhnjxWiXwh3vm41J0nsGM/6NcYdILAiSaIITjjdmS2SbN6Cifd5EOw
 PZCQ==
X-Gm-Message-State: AOJu0Yzrn8QWBzZuEbxVMZXn7sTukqO0Cr5VPwZDuGV7jHYnJWiu/BsJ
 5Pf7wLwzfGFkPmjb7w8XGjGe85AMRK4BHR8cAKGD61iT9rDz2/lzr1o9Cx0yjr+H9Aydojz7GmC
 KyOkfsZmR7MQW6BxwUeYKvNQIabvQgUY2sDGO7V2Mcz7gmGbWcqKuAjp47tPcNHpNbHpoJmsMFW
 /xNwuXEbiI1MsUP7yLZvuIEElqAypVxHkUuss91R1GPZ+x
X-Gm-Gg: AfdE7cnXFgPJ8fpb9t4s1Em11rirBNyeN33G1sGDGEWhyvlJrA005kXBShYhNriZ2AZ
 9a+0SZulInsDPbWESWh1+R4p7m3wY1LLOrOBQTdCr03+eSYGyCau3Y7ifAu/83stuiAoma3M7tL
 WMZfmTGbR0KVtcqneloPi2Wxa3MspPvTUnkvSzzTUqwOFB/nVDlPd4T9Ef52Wd8cajCHttGLm13
 XK+8LTOvqX/utb4V5b+6qLbceRyniHzZlWVACvRuz9XZpGly0p+qo+7exkfrC/L4acbJjsq07HT
 2aGr77dSfIPA6sWhRvgjdZ6YZyB5Q/bIn4ZAxb2SvC+GJtfJFP1BvCcxqTBfphA+lkJZ7OPYWQb
 1nb4tUCwauDxHwPpSuh6rzihZf+KluEj2n13pJHv9nb6/Wpk08+Vmw4HgIRgJukiucrW+BdJOn9
 WgVYUZKnYSdw==
X-Received: by 2002:a05:600c:1554:b0:495:3de8:33a6 with SMTP id
 5b1f17b1804b1-4954a3dc7bcmr33652195e9.16.1784296185021; 
 Fri, 17 Jul 2026 06:49:45 -0700 (PDT)
X-Received: by 2002:a05:600c:1554:b0:495:3de8:33a6 with SMTP id
 5b1f17b1804b1-4954a3dc7bcmr33651715e9.16.1784296184487; 
 Fri, 17 Jul 2026 06:49:44 -0700 (PDT)
Received: from fedora (cst-prg-27-253.cust.vodafone.cz. [46.135.27.253])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4954ba2abd0sm30049525e9.15.2026.07.17.06.49.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jul 2026 06:49:43 -0700 (PDT)
From: Dorinda Bassey <dbassey@redhat.com>
To: qemu-devel@nongnu.org
Cc: mhrica@redhat.com, mst@redhat.com, sgarzare@redhat.com,
 manos.pitsidianakis@linaro.org, marcandre.lureau@redhat.com,
 stefanha@redhat.com, pbonzini@redhat.com, aesteve@redhat.com,
 Dorinda Bassey <dbassey@redhat.com>
Subject: [PATCH v4 1/3] vhost: Fix SHMEM_MAP transaction ordering and
 resulting deadlock
Date: Fri, 17 Jul 2026 15:49:18 +0200
Message-ID: <20260717134920.265128-2-dbassey@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260717134920.265128-1-dbassey@redhat.com>
References: <20260717134920.265128-1-dbassey@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: permerror client-ip=170.10.129.124;
 envelope-from=dbassey@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_PASS=-0.001,
 T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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
The unmap handler keeps the original ordering: reply before delete, so
the backend is unblocked before the transaction commit.

Fixes: b52e1896e764 ("vhost-user: Add VirtIO Shared Memory map request")
Suggested-by: Albert Esteve <aesteve@redhat.com>
Reviewed-by: Albert Esteve <aesteve@redhat.com>
Tested-by: Albert Esteve <aesteve@redhat.com>
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


