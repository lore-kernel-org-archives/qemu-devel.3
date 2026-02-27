Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9151FFD5307
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 07:26:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvsEL-0005ca-SW; Fri, 27 Feb 2026 02:25:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vvsEK-0005bs-Mo
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 02:25:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vvsEI-0004TY-VK
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 02:25:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772177142;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=dqdWfZa9w4qvLo9QVPtCB4DXn7FhhJj33gbvY7/gVO0=;
 b=JCn9C8A1cqLJme8jZy3rvRfMHfnWSlL/LmYYhsPvBwO73COwWuJ8qOW+qZlIn7MIU+FUoM
 Ypq4ednIO1SR8t5Mp82w9ZWrIqoT8/sMmPm91k0x7Nc4onWeX8ecadrwWg4Ug0XuKsmqke
 9uovRWSa93qDXRgoPFzdmcC+m2fKeJo=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-497-OjCD6sStPJajODjSFFv_ZQ-1; Fri, 27 Feb 2026 02:25:40 -0500
X-MC-Unique: OjCD6sStPJajODjSFFv_ZQ-1
X-Mimecast-MFC-AGG-ID: OjCD6sStPJajODjSFFv_ZQ_1772177139
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-35620e2faf0so1166835a91.3
 for <qemu-devel@nongnu.org>; Thu, 26 Feb 2026 23:25:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772177139; x=1772781939; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=dqdWfZa9w4qvLo9QVPtCB4DXn7FhhJj33gbvY7/gVO0=;
 b=MX5iaNa0ZqZy1EpVLpyVsh/RVtwBQd7PEAWB4nWFh0wYjEPhVxRcpJ+k2874n2L5GT
 lublDKUKZVMgJcIxt2ZoUeWOYR835CTgKq8P6lRl67CDF1AnH59pAZqY8g6QOZju0Mxl
 VepGNe0B947Dgs/h3KHlCnlXUhGVcmBECXVy/AsPICQP3dkhARke2rCaGK+IqoDPKXGO
 3EklTu/iWyXCTD8ZsyUzw6thCOBCtod1D08uB3hmHgNQ+79P6eBeQqKQnIoh5q6bDcKi
 UepyguJzylfvBv4RoyyoHWb3uH8h0GoKMvVRhnXBbQg2lduG9zgHsc/aaFsjvkPDyBzx
 vpFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772177139; x=1772781939;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dqdWfZa9w4qvLo9QVPtCB4DXn7FhhJj33gbvY7/gVO0=;
 b=FmPVjeuKFuYmGtYJ16bzsD1pnMgGLYk/bjjFJI5cu+SM0WQ8ep8SmS//i37Jdhc1JU
 LS6F1VtP26It7olHvfup3mIF3E4q85kibaJxR6SzIb/ewDAtTNvCprLivs/oS2r9gByJ
 lkWoyjWEd0y5FZn4aIxFhTRW5LtWaGiITqCKpUPFJXdBjicnav2T/mCoILlK59gyhKGg
 2rv+edOahBuCy/0SUOsCFJ2H1xv6ltnH1Esjsyn2B2kUAIyscu7XVv+2357X8Pt/TIAf
 QQHrtA5fJXYOP2bJ9NxfBBaTtX0ekDkI7rVdWQuO/HOTbw3LWaVtcevCmGflHH3Bx14d
 BxCw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUpo+DleTi+eyNA7zFuHAh2UMUZqbS+K5IBj/bGf0f5lWMyTxB/wLIPGVFgElXSU4nOgx6tRp+1lz4w@nongnu.org
X-Gm-Message-State: AOJu0YxgAy/0LenfjeSgs8DtAQI1nLBw1M9Qm5iOmAGL/V3g1qQSkEXY
 mRBsGzV7AjK1PBqKSnTIJKtiPcLv4W4r1l7KZ8n0FVGu3UcZy4SR5Ijp/eKQp+6iQuP3ml9uM67
 9WClN7s0kMSXR/zJknnaWNuiTk1EfFLAC6oskS+3vAAh/q9y/Y+CHLzo5
X-Gm-Gg: ATEYQzwJ394+ArbHO1cZknZU9YtKdNAot/MnvEbFkn/87GCTo0gC1N5R78Fj9SSziEM
 007J33s6tgFssEuzeQfdAzXL1S78fvNQdcv1LXDNkUjzXW1LWGFglUJtDqyUGgDW0v/9rkhpryX
 dK5Z393y3aSUchxdhdNQd95kdkQTkOgXRg+0ZjERlqfQYJ4GBFrr+kgSMCcloEN6GLEzy9j1r93
 hS/VbEBOlyIpqzfVdgjyV9pcl9abG0ild2CnE1W/8T2qobIzIhG2Dq6qlVg+vJYYL91u6sAbQeg
 PckMxyfEKGSHOX551If3G30d/CzMBaxaEBWImtXrLMT+mubVHSBZd/l3bIV+l5S8/ro+MqKbYtC
 KdfNQCGNkPQmIXh5Uw7/Ej57a8f0XHvMO5XP4537+yeP9kylp0FyrUBg=
X-Received: by 2002:a17:90b:1d4f:b0:34a:47d0:9a82 with SMTP id
 98e67ed59e1d1-35965cdad17mr1706671a91.23.1772177139152; 
 Thu, 26 Feb 2026 23:25:39 -0800 (PST)
X-Received: by 2002:a17:90b:1d4f:b0:34a:47d0:9a82 with SMTP id
 98e67ed59e1d1-35965cdad17mr1706651a91.23.1772177138777; 
 Thu, 26 Feb 2026 23:25:38 -0800 (PST)
Received: from rhel9-box.lan ([122.176.129.56])
 by smtp.googlemail.com with ESMTPSA id
 98e67ed59e1d1-3593ddd7374sm4369743a91.16.2026.02.26.23.25.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Feb 2026 23:25:38 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: Alex Williamson <alex@shazbot.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>, pbonzini@redhat.com, ani@anisinha.ca,
 qemu-devel@nongnu.org
Subject: [PATCH v7] hw/vfio: generate new file fd for pseudo device and rebind
 existing descriptors
Date: Fri, 27 Feb 2026 12:54:45 +0530
Message-ID: <20260227072445.406907-1-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.306, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.668,
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

Normally the vfio pseudo device file descriptor lives for the life of the VM.
However, when the kvm VM file descriptor changes, a new file descriptor
for the pseudo device needs to be generated against the new kvm VM descriptor.
Other existing vfio descriptors needs to be reattached to the new pseudo device
descriptor. This change performs the above steps.

Tested-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 hw/vfio/helpers.c | 91 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 91 insertions(+)

diff --git a/hw/vfio/helpers.c b/hw/vfio/helpers.c
index f68f8165d0..00d42d3b98 100644
--- a/hw/vfio/helpers.c
+++ b/hw/vfio/helpers.c
@@ -116,6 +116,88 @@ bool vfio_get_info_dma_avail(struct vfio_iommu_type1_info *info,
  * we'll re-use it should another vfio device be attached before then.
  */
 int vfio_kvm_device_fd = -1;
+
+/*
+ * Confidential virtual machines:
+ * During reset of confidential vms, the kvm vm file descriptor changes.
+ * In this case, the old vfio kvm file descriptor is
+ * closed and a new descriptor is created against the new kvm vm file
+ * descriptor.
+ */
+
+typedef struct VFIODeviceFd {
+    int fd;
+    QLIST_ENTRY(VFIODeviceFd) node;
+} VFIODeviceFd;
+
+static QLIST_HEAD(, VFIODeviceFd) vfio_device_fds =
+    QLIST_HEAD_INITIALIZER(vfio_device_fds);
+
+static void vfio_device_fd_list_add(int fd)
+{
+    VFIODeviceFd *file_fd;
+    file_fd = g_malloc0(sizeof(*file_fd));
+    file_fd->fd = fd;
+    QLIST_INSERT_HEAD(&vfio_device_fds, file_fd, node);
+}
+
+static void vfio_device_fd_list_remove(int fd)
+{
+    VFIODeviceFd *file_fd, *next;
+
+    QLIST_FOREACH_SAFE(file_fd, &vfio_device_fds, node, next) {
+        if (file_fd->fd == fd) {
+            QLIST_REMOVE(file_fd, node);
+            g_free(file_fd);
+            break;
+        }
+    }
+}
+
+static int vfio_device_fd_rebind(NotifierWithReturn *notifier, void *data,
+                                  Error **errp)
+{
+    VFIODeviceFd *file_fd;
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
+    QLIST_FOREACH(file_fd, &vfio_device_fds, node) {
+        attr.addr = (uint64_t)(unsigned long)&file_fd->fd;
+        if (ioctl(vfio_kvm_device_fd, KVM_SET_DEVICE_ATTR, &attr)) {
+            error_setg_errno(errp, errno,
+                             "Failed to add fd %d to KVM VFIO device",
+                             file_fd->fd);
+            return -errno;
+        }
+    }
+    return 0;
+}
+
+static struct NotifierWithReturn vfio_vmfd_change_notifier = {
+    .notify = vfio_device_fd_rebind,
+};
+
 #endif
 
 void vfio_kvm_device_close(void)
@@ -153,6 +235,11 @@ int vfio_kvm_device_add_fd(int fd, Error **errp)
         }
 
         vfio_kvm_device_fd = cd.fd;
+        /*
+         * If the vm file descriptor changes, add a notifier so that we can
+         * re-create the vfio_kvm_device_fd.
+         */
+        kvm_vmfd_add_change_notifier(&vfio_vmfd_change_notifier);
     }
 
     if (ioctl(vfio_kvm_device_fd, KVM_SET_DEVICE_ATTR, &attr)) {
@@ -160,6 +247,8 @@ int vfio_kvm_device_add_fd(int fd, Error **errp)
                          fd);
         return -errno;
     }
+
+    vfio_device_fd_list_add(fd);
 #endif
     return 0;
 }
@@ -183,6 +272,8 @@ int vfio_kvm_device_del_fd(int fd, Error **errp)
                          "Failed to remove fd %d from KVM VFIO device", fd);
         return -errno;
     }
+
+    vfio_device_fd_list_remove(fd);
 #endif
     return 0;
 }
-- 
2.42.0


