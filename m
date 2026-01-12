Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4D5FC9EC8D
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 13:31:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfHuI-0003YN-L1; Mon, 12 Jan 2026 08:24:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vfHuC-0003Hl-DA
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 08:24:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vfHuA-0003pg-A7
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 08:24:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768224260;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6OtKMk9EaJvQRZjpWzq5Qg2vzLO4X9cnNIqDadzvcaI=;
 b=VzmiL5sVpTTA6m0Ritr8ldGCibXyTM//BgGxvNL/u2BayF5oJ3VyAF5NyeZJNZ4Dwng230
 /3g98Bvf0i5ABeISQwyZ7WMDKbcf6H+oBnVy4XcnylS/62BbBl8UtGO8Y7VXgo80z1hcDB
 4WhNqYFBfA28MxSnI1pmACQ+Ycp2SGU=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-690-lH8XLLOUP3KRX0rTN-Y89A-1; Mon, 12 Jan 2026 08:24:19 -0500
X-MC-Unique: lH8XLLOUP3KRX0rTN-Y89A-1
X-Mimecast-MFC-AGG-ID: lH8XLLOUP3KRX0rTN-Y89A_1768224258
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-81d9b88caf2so2205078b3a.1
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 05:24:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768224258; x=1768829058; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6OtKMk9EaJvQRZjpWzq5Qg2vzLO4X9cnNIqDadzvcaI=;
 b=K7Yg46V+TwWMr3dHXeJPiu1uNOqtdyn0tViqfeDOuWTMyAjgApPC2w3nILyQygRB7P
 y3M/vCarOw+eg9kmjoT973WTalhxCK3XjDWuPovSOtia10bDOcjkM+EOd11KDp9k2YMO
 JBwzB5s+p5HzGvM1Af4G2wLBOIHavJBZgU80IReSAWkYzirhboAbUhh7soT/ZoiT9fHs
 ++QCuAR4RBTLusE87Q3JfGVmASsTd4EmIKgfxqmQnMx6SDWOmJZo5vq7yNjynf00lwnv
 dsTSHXqLqrWSQzW2uTXAeeb0hr2Iv2U7eRws4dWRrxgHPN9AQiursIvtpluKX+WiYX7m
 vv/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768224258; x=1768829058;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6OtKMk9EaJvQRZjpWzq5Qg2vzLO4X9cnNIqDadzvcaI=;
 b=u1HeITBsFxDnWs0jW/yXU7n8Z9pGQBYtWsXceK7mqC+uMuWhO8hRQRj0XLELBPAhO4
 rLLqM81xtqtfwZowBV5sp8qvOAN0tfYrN4V24+ZlSY4TZ0t7d7Q1CcWAxEbLQW01ZpnK
 ILzpYV4Gll+P2j0uEV02qz2VkRdHSC8/SDmrNgxQY0AYDwynD7HDbJlaf/cB5CtMcm32
 Nglzf+ME+ikBkkoFTY8580Db7ZM5SgbQEdwSjaRqRSEELgVB5q/V7B6uQtPIFzgr/PUs
 NWSNfh5JvqQR9ajVpV0Fdx9ao8r+KP9srm8Biac5mcn54GVXJ/u7vVnhitVEEqZhtYeL
 JSvA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWdpxp6H+59Gr1bEcbctH9Mn/T/5225IHDYn3sP8tUUp/ESj1VqViafBtNTiT+l8zkiETI9vw6AdUC0@nongnu.org
X-Gm-Message-State: AOJu0Yw7ZPCpPQEdY9Oo5fJjrBSfuf2RJCo/R8xViHo3BjtIraI/dwX9
 Za5hI7RIyDii6Yl0Tz5WV64W/APjPtk9FIigmLnXaRgVQ1ff/ny6ZmaI7ec/dUF9mClEWAPlP7W
 yx0kAFj+adWlMqPJOQc/NfMoY6UaS4yoHPBwGnx/DmUcs2OYkofW4W6wp
X-Gm-Gg: AY/fxX7A9BP0t5BP0D5C+7/gl9P+Gi183p48MP5WjVgRu6gHTtdbgaL7bNkggcoSaIy
 CrFenUlno5giDSitEEBPBck+bM0xLL+iM0Rsio07ayLBCogEa07V2gRp+2a3XBkkPFKThonYH0a
 CDj0teRre06MfmKx8DNBttH0t5XrZBJ+zpC9vdfJlR9kHzmqJ0nL0NJbbQ2nrhz7V5rJ5U8b14M
 3fA2iVPXhnKTrECPemj2N79htTYkQaLIPHe/yshbbZjaoKyL3wDAoGkj4E3lzvJso8b5LgNYLN6
 8BWqPws9T8OWxgOgjDs+vz9O7HhJ1E6EzHjsTsJ7LrxshgA+CPC+BlPO5JbHDsL1ZLWeBiBn9VY
 3xQSPs4vYCNso+YanjEC2WlN27BH/a23rnrQ+f3aL/YQ=
X-Received: by 2002:a05:6a20:3d90:b0:35d:8c8:8acb with SMTP id
 adf61e73a8af0-3898f91d382mr16603515637.26.1768224258090; 
 Mon, 12 Jan 2026 05:24:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGhzrY1phT29OQoOheEzpgNYe4FyCFGf8cnMiStfGsug2rXDA6rI70z4oy24F7ghntE0gjGnw==
X-Received: by 2002:a05:6a20:3d90:b0:35d:8c8:8acb with SMTP id
 adf61e73a8af0-3898f91d382mr16603495637.26.1768224257587; 
 Mon, 12 Jan 2026 05:24:17 -0800 (PST)
Received: from rhel9-box.lan ([110.227.88.119])
 by smtp.googlemail.com with ESMTPSA id
 41be03b00d2f7-c4cc05cd87asm17544771a12.15.2026.01.12.05.24.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Jan 2026 05:24:17 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: Alex Williamson <alex@shazbot.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v2 20/32] hw/vfio: generate new file fd for pseudo device and
 rebind existing descriptors
Date: Mon, 12 Jan 2026 18:52:33 +0530
Message-ID: <20260112132259.76855-21-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260112132259.76855-1-anisinha@redhat.com>
References: <20260112132259.76855-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 hw/vfio/helpers.c | 81 +++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 78 insertions(+), 3 deletions(-)

diff --git a/hw/vfio/helpers.c b/hw/vfio/helpers.c
index c595f860ce..ab13cddfc2 100644
--- a/hw/vfio/helpers.c
+++ b/hw/vfio/helpers.c
@@ -110,12 +110,66 @@ bool vfio_get_info_dma_avail(struct vfio_iommu_type1_info *info,
 #ifdef CONFIG_KVM
 /*
  * We have a single VFIO pseudo device per KVM VM.  Once created it lives
- * for the life of the VM.  Closing the file descriptor only drops our
- * reference to it and the device's reference to kvm.  Therefore once
- * initialized, this file descriptor is only released on QEMU exit and
+ * for the life of the VM except when the vm file descriptor changes for
+ * confidential virtual machines. In that case, the old file descriptor is
+ * closed and a new file descriptor is recreated.  Closing the file descriptor
+ * only drops our reference to it and the device's reference to kvm.
+ * Therefore once initialized, this file descriptor is normally only released
+ * on QEMU exit (except for confidential VMs as stated above) and
  * we'll re-use it should another vfio device be attached before then.
  */
 int vfio_kvm_device_fd = -1;
+
+typedef struct KVMVfioFileFd {
+    int fd;
+    QLIST_ENTRY(KVMVfioFileFd) node;
+} KVMVfioFileFd;
+
+static QLIST_HEAD(, KVMVfioFileFd) kvm_vfio_file_fds =
+    QLIST_HEAD_INITIALIZER(kvm_vfio_file_fds);
+
+static int kvm_vfio_filefd_rebind(NotifierWithReturn *notifier, void *data,
+                                  Error **errp);
+static struct NotifierWithReturn kvm_vfio_vmfd_change_notifier = {
+    .notify = kvm_vfio_filefd_rebind,
+};
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
+    if (kvm_vm_ioctl(kvm_state, KVM_CREATE_DEVICE, &cd)) {
+        error_setg_errno(errp, errno, "Failed to create KVM VFIO device");
+        return -errno;
+    }
+
+    if (vfio_kvm_device_fd) {
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
 #endif
 
 void vfio_kvm_device_close(void)
@@ -137,6 +191,7 @@ int vfio_kvm_device_add_fd(int fd, Error **errp)
         .attr = KVM_DEV_VFIO_FILE_ADD,
         .addr = (uint64_t)(unsigned long)&fd,
     };
+    KVMVfioFileFd *file_fd;
 
     if (!kvm_enabled()) {
         return 0;
@@ -153,6 +208,11 @@ int vfio_kvm_device_add_fd(int fd, Error **errp)
         }
 
         vfio_kvm_device_fd = cd.fd;
+        /*
+         * If the vm file descriptor changes, add a notifier so that we can
+         * re-create the vfio_kvm_device_fd.
+         */
+        kvm_vmfd_add_change_notifier(&kvm_vfio_vmfd_change_notifier);
     }
 
     if (ioctl(vfio_kvm_device_fd, KVM_SET_DEVICE_ATTR, &attr)) {
@@ -160,6 +220,11 @@ int vfio_kvm_device_add_fd(int fd, Error **errp)
                          fd);
         return -errno;
     }
+
+    file_fd = g_malloc0(sizeof(*file_fd));
+    file_fd->fd = fd;
+    QLIST_INSERT_HEAD(&kvm_vfio_file_fds, file_fd, node);
+
 #endif
     return 0;
 }
@@ -172,6 +237,7 @@ int vfio_kvm_device_del_fd(int fd, Error **errp)
         .attr = KVM_DEV_VFIO_FILE_DEL,
         .addr = (uint64_t)(unsigned long)&fd,
     };
+    KVMVfioFileFd *file_fd;
 
     if (vfio_kvm_device_fd < 0) {
         error_setg(errp, "KVM VFIO device isn't created yet");
@@ -183,6 +249,15 @@ int vfio_kvm_device_del_fd(int fd, Error **errp)
                          "Failed to remove fd %d from KVM VFIO device", fd);
         return -errno;
     }
+
+    QLIST_FOREACH(file_fd, &kvm_vfio_file_fds, node) {
+        if (file_fd->fd == fd) {
+            QLIST_REMOVE(file_fd, node);
+            g_free(file_fd);
+            break;
+        }
+    }
+
 #endif
     return 0;
 }
-- 
2.42.0


