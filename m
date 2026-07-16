Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35BB6C44501
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 13:25:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkM5d-0005Lt-FA; Thu, 16 Jul 2026 09:25:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbassey@redhat.com>)
 id 1wkM5b-00059W-2k
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 09:25:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbassey@redhat.com>)
 id 1wkM5X-0005Bi-3z
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 09:25:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784208318;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XYtTJL5eAFZnnWuFKWoGFz19hddL8Efr2YkMuA32iDk=;
 b=AHh5rJY+v3LMKGh+TTha8Qou3iqHE8sFjMGgigWGa3dwq0bB35ojchsXSDN4rDh3szZm2x
 wFCM+zT+w0LumRoBX7AyM7e2wMB50u16gG7v3t7omdMVLKobP5/WQjqNpOompMl+idAPYv
 1YfLBiu/IKO1NYa/assIvGX2atqCAOE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-194-JZDx0cIaNkuSvuAFMens1A-1; Thu, 16 Jul 2026 09:25:16 -0400
X-MC-Unique: JZDx0cIaNkuSvuAFMens1A-1
X-Mimecast-MFC-AGG-ID: JZDx0cIaNkuSvuAFMens1A_1784208316
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-49244130073so68912985e9.1
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 06:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784208315; x=1784813115; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XYtTJL5eAFZnnWuFKWoGFz19hddL8Efr2YkMuA32iDk=;
 b=Nu4c/icPcF9L/W96TNGx+wzFpJbZwzsbwHSHfow7By/L3R/gu3jhPsX4ocir2YXH0m
 mJOE7EJqCq/0rxMUuurbQ/3j6l4IqQ2DKvELuv4DXIQoxSYQjYMEfYZ/4uHi0pzl40sl
 9ijukMdqByKA9bSJEGIn9ncWllOrAp8kFtMPWZ7fS18RL/fLoZpbgt3EuLw6dMzoqWUA
 qvnhn2dyBWa9ccmZZ1rSyDHbUBHX4aKoKKJhS2RMU0aKJNcCS15TE8sRNPF4Fh1IOX4G
 y3Bk/kBeyebyKrt8eO6cf7f8FnCFOXtt41TgKxZIQNOe33A6xBPH40VlT3eoBTnrRvOz
 9EcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784208315; x=1784813115;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=XYtTJL5eAFZnnWuFKWoGFz19hddL8Efr2YkMuA32iDk=;
 b=LFe6pkwNv7y4MqYn33E+3jmT6+MNTDBsFzJ4I/EXEZQnrZXHofTgYyi1T/7dDvb3FU
 Lk4ITVS8hcr0WBruM7c5mk43muw5T/3dpcooZbKj16Jbq9NnT3DlrWUsrwrkNGVMi9Dd
 ReDQ8mqXbxKxkv3NTfX2wU7wzrec9MG83qyvJgW4csa1XyALKkt98mRpyalYJXtoeCCk
 b5gZL5baUVJ4MrB/2SgEn+NOSc1YX6pWKUbX6M8N94bHNRo5GF8FXE7eN7lQWr/QDru5
 wHS84PiUz9h8dYDE2rqwx63S9sY9iVMB8BrMa87yAwTqq/I33oFTH3zkK4HBloGDn08I
 d7dw==
X-Gm-Message-State: AOJu0YwFvuncTSJaZ9901i3cvOcLafs7FRQayI7v8HjRxFfdoU8zBJ5r
 tBVkiCbAdjhe+vsC9/zb5jogz4grOaKu0Elf0uWZfg7KXBuv5axBH0KYiKXRF8NPZwaXn1a2Y6e
 mi/SUYsKzDxykV2ZkBZBzPlhXgGu9pTLSzaK2KF/DnmDp/rIrpRJn6R9yGg7B4m90+s3WnHmI1H
 mlQ0KpcvXAaLVDgrAy8Jg5urGaIQfZ+H/X35dtTzhMBVBD
X-Gm-Gg: AfdE7cnULi0AWwNdwl5mF90VrGeH+zAhAed7lOsH2ivnc8Rva5fTW1ft7QK6MTBSavY
 VjQlHE0Q+ig5PO7h2GRQ9tgjATtGXpZripNRmynF7tCnswWiOraT3at68FjyrDYV3+zJ1SBSZUX
 GvLUMxNbJ89GCs1HJ1Zjs9DmcmdMKt0YxDyL8AeUM/zTgs2Rza98QVISRXiAayuPoygFsR8fjO1
 Mgy+TBB1+oaZtz7pAC5qu0KjT311k2ObcLHRNDXUe2JkQzq3LV0mtylm9NgEMuvis9OgVVwUKCg
 TuRzicCC7QmXHGUQ1tPgbWP28alCNqVFD6VtmCoSRPtUn+6tiQHfKF2iYblVnPsFqaR+BZAJh8f
 RrN12/rrlKwBPGhxdprpfWw==
X-Received: by 2002:a05:600c:6217:b0:492:4363:e7d6 with SMTP id
 5b1f17b1804b1-49538cc1510mr118204265e9.37.1784208315663; 
 Thu, 16 Jul 2026 06:25:15 -0700 (PDT)
X-Received: by 2002:a05:600c:6217:b0:492:4363:e7d6 with SMTP id
 5b1f17b1804b1-49538cc1510mr118203805e9.37.1784208315306; 
 Thu, 16 Jul 2026 06:25:15 -0700 (PDT)
Received: from fedora (cst-prg-95-48.cust.vodafone.cz. [46.135.95.48])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49543e3afc2sm30347885e9.0.2026.07.16.06.25.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2026 06:25:14 -0700 (PDT)
From: Dorinda Bassey <dbassey@redhat.com>
To: qemu-devel@nongnu.org
Cc: mhrica@redhat.com, mst@redhat.com, sgarzare@redhat.com,
 manos.pitsidianakis@linaro.org, marcandre.lureau@redhat.com,
 stefanha@redhat.com, pbonzini@redhat.com, aesteve@redhat.com,
 Dorinda Bassey <dbassey@redhat.com>
Subject: [PATCH 2/3] vhost-user-gpu: Add shared memory region support
Date: Thu, 16 Jul 2026 15:23:58 +0200
Message-ID: <20260716132359.96785-3-dbassey@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260716132359.96785-1-dbassey@redhat.com>
References: <20260716132359.96785-1-dbassey@redhat.com>
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

From: Matej Hrica <mhrica@redhat.com>

Add a 'hostmem' property to the vhost-user-gpu which enables the shared
memory in the parent object.

Register a container MR in the shmem_list for SHMEM_MAP/UNMAP
operations. A container MR is used so that SHMEM_MAP FD-backed
subregions each get their own KVM memory slot with the correct
backing fd.

Signed-off-by: Matej Hrica <mhrica@redhat.com>
Signed-off-by: Dorinda Bassey <dbassey@redhat.com>
---
 hw/display/vhost-user-gpu.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/hw/display/vhost-user-gpu.c b/hw/display/vhost-user-gpu.c
index 06549c98e07..7e4580aa895 100644
--- a/hw/display/vhost-user-gpu.c
+++ b/hw/display/vhost-user-gpu.c
@@ -655,6 +655,21 @@ vhost_user_gpu_device_realize(DeviceState *qdev, Error **errp)
     }
 
     g->vhost_gpu_fd = -1;
+
+    /*
+     * If shared memory is enabled, register the hostmem region for
+     * SHMEM_MAP/UNMAP operations.
+     */
+    if (virtio_gpu_hostmem_enabled(g->parent_obj.conf)) {
+        VirtioSharedMemory *shmem = g_new0(VirtioSharedMemory, 1);
+        shmem->shmid = VIRTIO_GPU_SHM_ID_HOST_VISIBLE;
+        memory_region_init(&shmem->mr, OBJECT(vdev),
+                           "vhost-user-gpu-shmem",
+                           g->parent_obj.conf.hostmem);
+        memory_region_add_subregion(&g->parent_obj.hostmem, 0, &shmem->mr);
+        QTAILQ_INIT(&shmem->mmaps);
+        QSIMPLEQ_INSERT_TAIL(&vdev->shmem_list, shmem, entry);
+    }
 }
 
 static struct vhost_dev *vhost_user_gpu_get_vhost(VirtIODevice *vdev)
@@ -665,6 +680,7 @@ static struct vhost_dev *vhost_user_gpu_get_vhost(VirtIODevice *vdev)
 
 static const Property vhost_user_gpu_properties[] = {
     VIRTIO_GPU_BASE_PROPERTIES(VhostUserGPU, parent_obj.conf),
+    DEFINE_PROP_SIZE("hostmem", VhostUserGPU, parent_obj.conf.hostmem, 0),
 };
 
 static void
-- 
2.52.0


