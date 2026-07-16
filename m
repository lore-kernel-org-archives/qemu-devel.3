Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E97D0C4450A
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 13:25:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkM5h-0005fn-5f; Thu, 16 Jul 2026 09:25:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbassey@redhat.com>)
 id 1wkM5f-0005XS-G4
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 09:25:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbassey@redhat.com>)
 id 1wkM5d-0005D7-R9
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 09:25:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784208324;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DkSaJgTRZjIeqKLqjNNxLh08mWonj864Ai8oWoOsAdc=;
 b=g7efAc6fdYY5cQe/wTZWqFf5Ceq9Gb1oSkP5aj2Ml3wcQwFZ5htWnYvyCrgf73s0mJXr49
 nBSIecTaQ31C1TDTu15TrGNnk6TW0N4lF0RtmxrT/7dGjUs6kg3W1b3ml6hy8fEgCdYx1u
 jE4cnQj79xtFxObSdmAxYRd3DF+MAlk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-325-6MT1tnA-NQ253bCyq3FGLQ-1; Thu, 16 Jul 2026 09:25:23 -0400
X-MC-Unique: 6MT1tnA-NQ253bCyq3FGLQ-1
X-Mimecast-MFC-AGG-ID: 6MT1tnA-NQ253bCyq3FGLQ_1784208322
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-472a798fc7cso2350838f8f.1
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 06:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784208322; x=1784813122; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DkSaJgTRZjIeqKLqjNNxLh08mWonj864Ai8oWoOsAdc=;
 b=IS+pmSfbLl/s+qAtSosMJGMQ+YeA1XRcmpNU/GTPsY7jBRANivewvDXJSh+jADVwQs
 bB7R63+KD1tJ5xxY6kiJ0dY0HYpd4ZCozIG394c97fpd1dhdiEWE7xVRoe5LUZAXijA3
 x4RmQWi0DTJoJx8Y914kmMMP6f8qG1QTMMfM2qwNVKYGm5YZ6dU0XaI8cv+UieKG2dWd
 FQgaeO0RHoyETmgggpH/Inwgz2DGVsJWomtQC2JIrbQkvxlKmAT0xiZWuytELSeFqb5F
 C/Z29DetVisSiJTfx3LrESbG3cq7p3YmtrvR6KyZbJuYarYzm36P3TXcQ9DQcKfd/4QN
 WPrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784208322; x=1784813122;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=DkSaJgTRZjIeqKLqjNNxLh08mWonj864Ai8oWoOsAdc=;
 b=o75L5sFOMExXtkJhK9nqTDD7ZJqfwQM9IXU9zySUfw6h6TsZuRYcF138HiGuvjWEdU
 tmEO6HTSZFSCvGimmcTosnY1yRdufMqRwCAsJ/JVutAzgM0L7I5Tz8UCyEQmrd+4iAda
 Z8LHIpaw3dlrZyQqgmhetgk7g0CXAlPHQ/cgnf4oNn+P0Lj7gj4p4jdjxbY1xRIJcYFH
 OUJodC8n7rBawjMrgyRXXd+Ol0YPkN2QPpxlR/3+rQUcxctg3Z5Vx3iA6MaS9jnyf86R
 MNHumImzDCEqOOgp7DRJcaQISSzbXxKrf8nuHXoZ+mFUsi/+uzWfPtA8mupdSyVzzrOc
 BtyQ==
X-Gm-Message-State: AOJu0Yxe7zAtZimVajga0bLbfVOLev9CRZRiBpbcWuJCl65hHGMbbBHx
 q+vTqEbKu8xR5GVnFaEoWGHxPkqBp1+CvyITpSafQ4jfrMp+atka0RKBVINgoQdAf9UyEJkBcxz
 5mwH3SMbTN4E0hhb7KDuktCV7fcdhGJNEeRBd2klNdaFIGd7GwfSVC1of3DlitE/m+DJhECOBth
 BwWfw75nuVgAAEiMNVuqWNO6T9K7RTuk8OdC7OkhJEH5km
X-Gm-Gg: AfdE7cnUy7nYBaza3OS9a+RrDMVXh12fKzo085rlMWPSNdU33vHingqBAlpGUWCpkUm
 SvYFbOTz2CiW5ZlIfe/Ho4pAlaHHL9VI86NLAS031WxAPgjldzyzNLNRrYmyM1kyXvmWDSsAH/Z
 4IZ5C5j488g7M3qhYU7ux9sDm1PMtGlvz9P93+c3mUkBxOx+HsxmKGo8q0F3fCkY9+rwXY7YYua
 QMHC9V9/sV6MZxNy1n5tuCoBhEjNqrzJ87Lqv8P2HKVDNdOzEohIdmtfktDcLQrpzX2Ll321yRJ
 L/O6uhbWEoEp504YwG3CUgPtpI8xwCY6OwPwZ9ipI5JZad4upwmDXsrGTNY+7UDlDXCdl1b0Fte
 Ry1hs/BB8NHEQkNeVevjKIg==
X-Received: by 2002:a05:600c:45c3:b0:495:3e08:ad19 with SMTP id
 5b1f17b1804b1-4953e08adb6mr66789455e9.9.1784208322200; 
 Thu, 16 Jul 2026 06:25:22 -0700 (PDT)
X-Received: by 2002:a05:600c:45c3:b0:495:3e08:ad19 with SMTP id
 5b1f17b1804b1-4953e08adb6mr66788635e9.9.1784208321285; 
 Thu, 16 Jul 2026 06:25:21 -0700 (PDT)
Received: from fedora (cst-prg-95-48.cust.vodafone.cz. [46.135.95.48])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49543e3afc2sm30347885e9.0.2026.07.16.06.25.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2026 06:25:20 -0700 (PDT)
From: Dorinda Bassey <dbassey@redhat.com>
To: qemu-devel@nongnu.org
Cc: mhrica@redhat.com, mst@redhat.com, sgarzare@redhat.com,
 manos.pitsidianakis@linaro.org, marcandre.lureau@redhat.com,
 stefanha@redhat.com, pbonzini@redhat.com, aesteve@redhat.com,
 Dorinda Bassey <dbassey@redhat.com>
Subject: [PATCH 3/3] vhost: Fix SHMEM_MAP transaction ordering and resulting
 deadlock
Date: Thu, 16 Jul 2026 15:23:59 +0200
Message-ID: <20260716132359.96785-4-dbassey@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260716132359.96785-1-dbassey@redhat.com>
References: <20260716132359.96785-1-dbassey@redhat.com>
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

Signed-off-by: Dorinda Bassey <dbassey@redhat.com>
---
 hw/virtio/vhost-user.c |  6 +++---
 hw/virtio/vhost.c      | 10 ++++++++++
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 517cc4ca716..8d0f463aab8 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -1998,17 +1998,17 @@ vhost_user_backend_handle_shmem_map(struct vhost_dev *dev,
     }
 
 send_reply_commit:
-    /* Send reply and commit after transaction started */
+    /* Commit before reply so the KVM memory slot exists before guest access */
+    memory_region_transaction_commit();
+
     if (hdr->flags & VHOST_USER_NEED_REPLY_MASK) {
         payload->u64 = !!ret;
         hdr->size = sizeof(payload->u64);
         if (!vhost_user_send_resp(ioc, hdr, payload, &local_err)) {
             error_report_err(local_err);
-            memory_region_transaction_commit();
             return -EFAULT;
         }
     }
-    memory_region_transaction_commit();
     return 0;
 
 send_reply:
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


