Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97630EDF045
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 06:27:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqQAi-0000SF-77; Thu, 12 Feb 2026 01:27:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vqQA2-0008JO-4M
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 01:26:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vqQA0-0005JO-ER
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 01:26:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770877603;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XewWSAUDjfVoUcn+2YSpUOr5sv9iz8ihTRQjovE/jgc=;
 b=gelOIoP8s4CvnBnGv2sredYWWzwxi9uL26b1pQ3o8px/PgTLrlHdhdRGP6R9yXXiUqzuRC
 GFAju9D2/vX8hTNCiaMc+h9DmhD5INNPtk6qWCD6GWX8QBn2NIZ0iEBopkPr6GI/PUcelc
 PCXZNFRyJqMf7qT3ncef3WrqtNjrZ/w=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-422-eEG7hRiHNUGn7dTw7hTO5Q-1; Thu, 12 Feb 2026 01:26:42 -0500
X-MC-Unique: eEG7hRiHNUGn7dTw7hTO5Q-1
X-Mimecast-MFC-AGG-ID: eEG7hRiHNUGn7dTw7hTO5Q_1770877601
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-354490889b6so13899830a91.3
 for <qemu-devel@nongnu.org>; Wed, 11 Feb 2026 22:26:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770877601; x=1771482401; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XewWSAUDjfVoUcn+2YSpUOr5sv9iz8ihTRQjovE/jgc=;
 b=orzKNXAYx4sEkN7nWhfFcjnf+z+OdAeRvMHGf/PbKr8jyET+FoMyaRDLRuqpSgnCp+
 t8vC1TPqgDaIOkkI0EPZZ7C+VEbE5WqptVFLasmGYeu9FRx+/ukwx91/VtrEruwzKHLz
 O5Jfr4PUevGfuN9NBhhpf90MjT8QQdenDMAhyF+c8crcDMp9NoJ60BPX+acf4EVV9GsL
 Ox1WouuQ3u0Yr8U2RzLgUaEQ+U5Qvf8yLd9btjS2f/ylK7BXkuTranQzimu44UwRXvJC
 omnktd+iXRKlH/YOrHLkyKo02aZBUwJPDeo7U7XFyFLjxU+N08Z8pRWrKopo2QClSbjj
 Lwyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770877601; x=1771482401;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XewWSAUDjfVoUcn+2YSpUOr5sv9iz8ihTRQjovE/jgc=;
 b=gPcLsQ3UzCvaG3UZlUk1RuAULF4QJcOj1ELLHCbDLOUaWGVU9VcFvRWGqk155i37s4
 HWtgePOrzCzTxe3f47ngrzzsl3dJjumZE9e9qhzS4fx0ltmuvcm3VHA8TsrFO2XW6hR+
 kKV/xqv+jG58Zrd+dveVOnNluDqSYZ2deQQHcW4nFqrghyiS4Y/w3A/x7oRGCP1sd/QY
 jSU2unOQSTpUKZ2ORKMkq3XlopB7K5HkfAVSUNTfA+gPzKjBh592AVOs4m/NHwssfFdZ
 hX/uYILIpELwu25Q47VDQkfUQpEgtCbdJ8VZSGFo1r1LeyYD4OaK0Bbrevk8KosHATNQ
 qZ5w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXYpfhK2Wsz/qFVh9S6xSoyMa/xrtKJmKRn7X4SE3a9EtLNaH3kowoU6QCAx/bt48BxjOdbo+gZK8lV@nongnu.org
X-Gm-Message-State: AOJu0YydVt6DvtzP4EAIAvk8iaRYFBQPxfq/69nLauUIxYfB4a5uYf92
 DZUsaQj3Jr8UPIpI0QsXAmRejkH9XO9h5DNR2nfOZehvuU+zGK4RE4kZkVCO7skyl2vuDJM3UH4
 2Rh+BOfI7SN0FGe5yYKIUD4b03KsxZksOFM/4zqJFmmse1o4w8rQfEnAB
X-Gm-Gg: AZuq6aKufV9MXJmnAGoVBDksInsFzLryKrqh3tURBPhR3NN2zPOaKqBKElR3NAxDKB4
 Rmo5B9Rm6Am0y3Va6ALB5cmFd1tcPXW4O7B7ys6MGifHmI5mk+SIZfU2rUnVM5P3x4ExspE3y7u
 e4HoTd/20MJ5BBrWmtjYprsEjCZHuB7Xpim6J7RKtPBoisqZbtmr558cHR+DWyAObotGJdc0sYl
 SgHtMMaTkrLFDTrhKE3MOh9+fJirk87f1iWyrGO8wbI7eJxBkQxVx+EoxQbJSvzc83Ru/Kyno2x
 YB4h0QfB7I4clObeLUWyswcp+7SsEKvTyTxWS4BGynezchr1qNWf48Nr9DBGglCqpNmUsUVPFNa
 +udiUOrwuXeDXM862UnIKmTek/mwNs8uCHN/BHUViKdvm91tHi+gZoFI=
X-Received: by 2002:a17:90b:33cc:b0:340:776d:f4ca with SMTP id
 98e67ed59e1d1-3568f403e39mr1685792a91.26.1770877600994; 
 Wed, 11 Feb 2026 22:26:40 -0800 (PST)
X-Received: by 2002:a17:90b:33cc:b0:340:776d:f4ca with SMTP id
 98e67ed59e1d1-3568f403e39mr1685780a91.26.1770877600641; 
 Wed, 11 Feb 2026 22:26:40 -0800 (PST)
Received: from rhel9-box.lan ([122.164.27.113])
 by smtp.googlemail.com with ESMTPSA id
 98e67ed59e1d1-3567e7d95d8sm4894122a91.2.2026.02.11.22.26.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Feb 2026 22:26:40 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: Alex Williamson <alex@shazbot.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Cc: kraxel@redhat.com, Ani Sinha <anisinha@redhat.com>, qemu-devel@nongnu.org
Subject: [PATCH v4 21/31] hw/vfio: generate new file fd for pseudo device and
 rebind existing descriptors
Date: Thu, 12 Feb 2026 11:55:05 +0530
Message-ID: <20260212062522.99565-22-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260212062522.99565-1-anisinha@redhat.com>
References: <20260212062522.99565-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Normally the vfio pseudo device file descriptor lives for the life of the VM.
However, when the kvm VM file descriptor changes, a new file descriptor
for the pseudo device needs to be generated against the new kvm VM descriptor.
Other existing vfio descriptors needs to be reattached to the new pseudo device
descriptor. This change performs the above steps.

This chnage is untested.

Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 hw/vfio/helpers.c | 94 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 94 insertions(+)

diff --git a/hw/vfio/helpers.c b/hw/vfio/helpers.c
index f68f8165d0..2ff189a53b 100644
--- a/hw/vfio/helpers.c
+++ b/hw/vfio/helpers.c
@@ -116,6 +116,91 @@ bool vfio_get_info_dma_avail(struct vfio_iommu_type1_info *info,
  * we'll re-use it should another vfio device be attached before then.
  */
 int vfio_kvm_device_fd = -1;
+
+/*
+ * Confidential virtual machines:
+ * During reset of confidential vms, the kvm vm file descriptor changes.
+ * In that case, the old vfio kvm file descriptor is
+ * closed and a new descriptor is created agaist the new kvm vm file
+ * descriptor.
+ */
+
+typedef struct KVMVfioFileFd {
+    int fd;
+    QLIST_ENTRY(KVMVfioFileFd) node;
+} KVMVfioFileFd;
+
+static QLIST_HEAD(, KVMVfioFileFd) kvm_vfio_file_fds =
+    QLIST_HEAD_INITIALIZER(kvm_vfio_file_fds);
+
+static void insert_fd_to_list(int fd)
+{
+    KVMVfioFileFd *file_fd;
+    file_fd = g_malloc0(sizeof(*file_fd));
+    file_fd->fd = fd;
+    QLIST_INSERT_HEAD(&kvm_vfio_file_fds, file_fd, node);
+    return;
+}
+
+static void remove_fd_from_list(int fd)
+{
+    KVMVfioFileFd *file_fd, *next;
+
+    QLIST_FOREACH_SAFE(file_fd, &kvm_vfio_file_fds, node, next) {
+        if (file_fd->fd == fd) {
+            QLIST_REMOVE(file_fd, node);
+            g_free(file_fd);
+            break;
+        }
+    }
+    return;
+}
+
+static int kvm_vfio_filefd_rebind(NotifierWithReturn *notifier, void *data,
+                                  Error **errp)
+{
+    KVMVfioFileFd *file_fd;
+    int ret = 0;
+    struct kvm_device_attr attr = {
+        .group = KVM_DEV_VFIO_FILE,
+        .attr = KVM_DEV_VFIO_FILE_ADD,
+    };
+    struct kvm_create_device cd = {
+        .type = KVM_DEV_TYPE_VFIO,
+    };
+
+    /* we are not interested in pre vmfd change notification */
+    if (((VmfdChangeNotifier *)data)->pre) {
+        return 0;
+    }
+
+    if (kvm_vm_ioctl(kvm_state, KVM_CREATE_DEVICE, &cd)) {
+        error_setg_errno(errp, errno, "Failed to create KVM VFIO device");
+        return -errno;
+    }
+
+    if (vfio_kvm_device_fd != -1) {
+        close(vfio_kvm_device_fd);
+    }
+
+    vfio_kvm_device_fd = cd.fd;
+
+    QLIST_FOREACH(file_fd, &kvm_vfio_file_fds, node) {
+        attr.addr = (uint64_t)(unsigned long)&file_fd->fd;
+        if (ioctl(vfio_kvm_device_fd, KVM_SET_DEVICE_ATTR, &attr)) {
+            error_setg_errno(errp, errno,
+                             "Failed to add fd %d to KVM VFIO device",
+                             file_fd->fd);
+            ret = -errno;
+        }
+    }
+    return ret;
+}
+
+static struct NotifierWithReturn kvm_vfio_vmfd_change_notifier = {
+    .notify = kvm_vfio_filefd_rebind,
+};
+
 #endif
 
 void vfio_kvm_device_close(void)
@@ -153,6 +238,11 @@ int vfio_kvm_device_add_fd(int fd, Error **errp)
         }
 
         vfio_kvm_device_fd = cd.fd;
+        /*
+         * If the vm file descriptor changes, add a notifier so that we can
+         * re-create the vfio_kvm_device_fd.
+         */
+        kvm_vmfd_add_change_notifier(&kvm_vfio_vmfd_change_notifier);
     }
 
     if (ioctl(vfio_kvm_device_fd, KVM_SET_DEVICE_ATTR, &attr)) {
@@ -160,6 +250,8 @@ int vfio_kvm_device_add_fd(int fd, Error **errp)
                          fd);
         return -errno;
     }
+
+    insert_fd_to_list(fd);
 #endif
     return 0;
 }
@@ -183,6 +275,8 @@ int vfio_kvm_device_del_fd(int fd, Error **errp)
                          "Failed to remove fd %d from KVM VFIO device", fd);
         return -errno;
     }
+
+    remove_fd_from_list(fd);
 #endif
     return 0;
 }
-- 
2.42.0


