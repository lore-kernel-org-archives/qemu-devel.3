Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48EA6C44516
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 09:40:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkf3k-0008Ay-6r; Fri, 17 Jul 2026 05:40:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbassey@redhat.com>)
 id 1wkf3d-0008Aa-2n
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 05:40:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbassey@redhat.com>)
 id 1wkf3b-0002u5-I4
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 05:40:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784281235;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GUzQ/YUsey7xzp/ka81xsK/8+2yW+4aVogZ97KwN09c=;
 b=bR34jQvWmcLMzLxkz7lsMEmBOYBB1iudZzcZmrzYUiAySKDeYe9B2k2PZO8QIRWQ2nWV6D
 A9yDSo63offtbdDTMPVgetiKvmnQxlSFReP/a6FJTG3DJKACom7T8IY/3i/d0o215MdpC5
 tLtT/6iWSpG+GdAgfIxbcTaXAWlP+SA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-284-2hwDOUuyMbqPqqQu2btPTw-1; Fri, 17 Jul 2026 05:40:33 -0400
X-MC-Unique: 2hwDOUuyMbqPqqQu2btPTw-1
X-Mimecast-MFC-AGG-ID: 2hwDOUuyMbqPqqQu2btPTw_1784281233
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-493f75ebec5so51405805e9.1
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 02:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784281232; x=1784886032; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GUzQ/YUsey7xzp/ka81xsK/8+2yW+4aVogZ97KwN09c=;
 b=R5nuk4Mv5X8Qo1hOk+sUWlRlwpTZpa20euHVm6oRXT5gygXeb/0+A3lWWCY6dLt8Je
 lce3JkvQOh1e6SfwddyK6MdKCDE+4TgJKMKKqDS8gWOwZyurwxwDBUmZgkSAMtv/FQkD
 UTlbeIRHNuATDRWSovP3EZ1PESw9gvCQoRRSU81f23Q0WJCiepSv9pQXj2tblftxkzkM
 z5QbV/pdqbkFcBApCnq9oMq0ZOAyVFRkoLhB62WctKdBehUDnTwFuOcH8GsAA4yuCvno
 9Ohf1XDNL8DsgD7ICg/helv0RMwBApYKuOvpqfe+7NjW9Pu/AUya+VxXR3eBSMVUUwn9
 ob3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784281232; x=1784886032;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=GUzQ/YUsey7xzp/ka81xsK/8+2yW+4aVogZ97KwN09c=;
 b=k6j8kmzQ9EJfxgfhzI19mauipVAyRSJ3/83mFUz0jI32fFNxYrrsJmJ0nAdIj4UZeu
 CzzmEfz+FhzfU+FJQMbQN68KqDNpmnS5D9h+gn9lQXBvHuF9vjH8/bZcKNGTr4Gh6VA2
 lKil2/cIn92xQHiOQFtTziFoTADOqertkeu2Hx7x6ud4lrEtPjV8WNm5nx6zEy+mz/Vm
 kGEIJE2DXqC/Q9AYNTvFGmlX3h+5XjpSGq9+VdkfDMKyZTGdTG6+37v+Tu58YwS7q3I1
 +Ze4pAikOILPYObtckzC8C+RjppogtudkAnsMgRuPiwvw6gi15zOUvnzBexzpQTkLwky
 CtBQ==
X-Gm-Message-State: AOJu0YzWgXxDV+e3Ao22AKLZAeD1ihEivjwPhpi4Bo60sQ0D+PH8OY1S
 3ygkvAyBzm/7MTavoiCqfWrzdLaenM4hbnApjQz2FV1E1SZng5U19ZikCTOxKGhF7gRkDGwKr4o
 jAgrqNwM6Sm9QHECk4ptTgPy18FGV8UAD/pPL/n8MIAx/6uR8Tmh6PZIQOfokbBiiGqLJtH/dk1
 HzcfjlB5q0/YxiYM2E/q2CaSv8pPjywK7x/zfyeBEtp1X9
X-Gm-Gg: AfdE7cloDzVugJxrLPY/tm2kw84KD7QMlBoGnyel6MU8gnEymubU/xNgqsqmqj10INt
 x9gDxPVDUIFjZKTal2zLwVHiKoy/P56gLRekLjfQtTV/sSSw6cy2RaJk9/ZRp5ZBFX9LX+7idvP
 aSal6nQYbfvNqiNOiuTaHLFD9xGakaJ6HpRy3HdGbqXCdiA/ciHs9e/8+aNrLVDMNZYSpitCj+Z
 kCkMwuC9f+BFzGYyTieoQejxMIoXxuBhooxjoVB6+fxSaeSfUCf10sFb5pnd716FomO7K/BPlFp
 w+GqgJeDB+Bd00HVceqSybLGeLVnRM4bg/K63i0FENDbu/ymC2I+3DofL7f6vW3pII3dd5796o9
 9qQZLCYYwSjTW3Mzc9Ofryg==
X-Received: by 2002:a05:600c:3baa:b0:493:b730:8d78 with SMTP id
 5b1f17b1804b1-4954a514007mr24390405e9.31.1784281232348; 
 Fri, 17 Jul 2026 02:40:32 -0700 (PDT)
X-Received: by 2002:a05:600c:3baa:b0:493:b730:8d78 with SMTP id
 5b1f17b1804b1-4954a514007mr24389845e9.31.1784281231789; 
 Fri, 17 Jul 2026 02:40:31 -0700 (PDT)
Received: from fedora (cst-prg-95-48.cust.vodafone.cz. [46.135.95.48])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49549a35830sm38356565e9.3.2026.07.17.02.40.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jul 2026 02:40:31 -0700 (PDT)
From: Dorinda Bassey <dbassey@redhat.com>
To: qemu-devel@nongnu.org
Cc: mhrica@redhat.com, mst@redhat.com, sgarzare@redhat.com,
 manos.pitsidianakis@linaro.org, marcandre.lureau@redhat.com,
 stefanha@redhat.com, pbonzini@redhat.com, aesteve@redhat.com,
 Dorinda Bassey <dbassey@redhat.com>
Subject: [PATCH v2 3/3] vhost: Fix SHMEM_MAP transaction ordering and
 resulting deadlock
Date: Fri, 17 Jul 2026 11:39:25 +0200
Message-ID: <20260717093925.214023-4-dbassey@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260717093925.214023-1-dbassey@redhat.com>
References: <20260717093925.214023-1-dbassey@redhat.com>
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


