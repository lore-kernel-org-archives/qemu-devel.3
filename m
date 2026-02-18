Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72D04E9A047
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 11:45:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsfym-0004GM-FD; Wed, 18 Feb 2026 06:44:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vsfyW-0003wO-Du
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 06:44:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vsfyI-0007vV-7t
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 06:44:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771415036;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P6CIgFqyYot5rxLSuNCk9EOjkct/6qK4uQFmgPOAy0w=;
 b=S3KAvhYWckxAhl4xOv04iaM6sXI3JY2j/Od8F6vQ0eXUVygxDe7tRSsB47qPjWWdZXNem0
 Up/c0ci6z6MtAy4hAi41mOqcjWkdrIzotfbrZKcEoOc+lhJJuOGq68/IPMvbBmqKR9MOEF
 us+UUZwmZXrwhnaq/dI1q3cEAumB7LI=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-231-JbQpo2AjMQW_zYwRQktxAQ-1; Wed, 18 Feb 2026 06:43:54 -0500
X-MC-Unique: JbQpo2AjMQW_zYwRQktxAQ-1
X-Mimecast-MFC-AGG-ID: JbQpo2AjMQW_zYwRQktxAQ_1771415034
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2aad5fc5b2fso57019725ad.1
 for <qemu-devel@nongnu.org>; Wed, 18 Feb 2026 03:43:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771415034; x=1772019834; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P6CIgFqyYot5rxLSuNCk9EOjkct/6qK4uQFmgPOAy0w=;
 b=gtUCbW4RmUt/bukcn3qOWY1ySjl8czM9L72KV3O8nG0ADHZ47l/FRwzOBnJzROdkYV
 l08pQQGz87KOT2GX1tw2zb2q5IA89uL0e1LZD9czM40OXF8VHtNf4y65TpWS4jkYmYRt
 br/sKgU9vWKD/Rilc+X+uci9OHwQAzfxw2dpNkBwJGZzDwiJHZOZrOANVxvGPLsBeEL8
 K0LwvHPfWhAqy2Ic8h0CDoJlbYmG/4pM3AOyXSDg7RedjWNQ8NbFE6rli0J+ygdK6Bl7
 JbyK7Auz31VGRYnDdhOKBHkD0rBMVVbXf/7CjDH+S15A1dbRpb6ELGR6VUtRnD1UCL+0
 +Chw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771415034; x=1772019834;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=P6CIgFqyYot5rxLSuNCk9EOjkct/6qK4uQFmgPOAy0w=;
 b=PtiSWxBM+6I5CfMgq+CNGMxZrqCS+MGMqoVzWrvGqzXFR5SCqu4jrdyaA/evdZSxp4
 I8TKg08cFxVr6UYZsixPfWW1E51QNt2t7LHRtkMT2jAqYDa9eHY4E8j0FnRv1RK5jcp7
 hLAxBGUznh7FmFKJgewlXqwkoP/lGP1/7vwn9JXnmjWrup38Tqh/J7PNRg3NCxv8Oaxz
 FWyOEva+1oPZeDYihr42PJAajsEFt+H5TMnMtjrQYNdPRgKe32/0WgH0kZtShwd4Re1E
 hin7nyJrpa4NcQsQ6opm7YsrBi31PPLvxf7OF96RrtNk857HDMdypJyvMwheiHEowukE
 jJvg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXG2DILuIr1hS4kQPagazUEthYkRrO1QBsfctSP744TmtRPTNdlb7IPBIxDrF3qyaELtPAMd+DBAk4v@nongnu.org
X-Gm-Message-State: AOJu0YwI7gRvPUZ+4IOk7v5ukNn5xBGIHAkonC4Obmno9ucnX87lJr4x
 siXYZfN8FezyNDDctA9WvWG0YojAlbO8yjT2N5tM7KoN2oxfL2kHQMhhQC6ESNXTjolQUmo0XEG
 2wX0MRt0skgjGl4JgF01h7Y60gtRYJIoavYbt7mZnQ0cGk8yu+musQOrA
X-Gm-Gg: AZuq6aJpJBPofBnk9re466CdxEKuBYHHCDTBJVRv+NoJyaVkoV+RvFAijpqSaWgE4qO
 NT4y5btrsS+x3fOrLsI2ddkhto+zl1pRst7XkIF9lA75FkXVzfGsr9Mo2oQr1R5fpZ1/gMArsYj
 bYb+JpXsdmCNrQi+wzQiAeg3L83NECoiG9tOd14qVtJd13eHp7DxAXi/E7SAXYuChliNvXy+N5o
 uekBeFdHCPoWydm6S4LpUu5K+9tdIzwNt2EB0kT34Lq1GBpgP+5WkilckwNx6mcM2TErReWaRDH
 pV95Ev34BZARK59W5WRSMzns8UFh76wu3iUlZBJEjUvz9nyFcBYAlsTsZvUHldzSFt/VFFigW0g
 i2jz8TY/a4h8ZWgBprIDViHY3qig8GYyOaQR/mls7PvS6nn6EYD7V
X-Received: by 2002:a17:902:f652:b0:2a9:5f11:3a34 with SMTP id
 d9443c01a7336-2ad50e99e7amr12699175ad.13.1771415033690; 
 Wed, 18 Feb 2026 03:43:53 -0800 (PST)
X-Received: by 2002:a17:902:f652:b0:2a9:5f11:3a34 with SMTP id
 d9443c01a7336-2ad50e99e7amr12699095ad.13.1771415033276; 
 Wed, 18 Feb 2026 03:43:53 -0800 (PST)
Received: from rhel9-box.lan ([117.99.83.54])
 by smtp.googlemail.com with ESMTPSA id
 d9443c01a7336-2ad1aaeab38sm127803425ad.82.2026.02.18.03.43.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Feb 2026 03:43:53 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: Alex Williamson <alex@shazbot.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>, kraxel@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v5 22/34] hw/vfio: generate new file fd for pseudo device and
 rebind existing descriptors
Date: Wed, 18 Feb 2026 17:12:15 +0530
Message-ID: <20260218114233.266178-23-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260218114233.266178-1-anisinha@redhat.com>
References: <20260218114233.266178-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.043,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Tested-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 hw/vfio/helpers.c | 92 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 92 insertions(+)

diff --git a/hw/vfio/helpers.c b/hw/vfio/helpers.c
index f68f8165d0..e2bedd15ec 100644
--- a/hw/vfio/helpers.c
+++ b/hw/vfio/helpers.c
@@ -116,6 +116,89 @@ bool vfio_get_info_dma_avail(struct vfio_iommu_type1_info *info,
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
+    QLIST_FOREACH(file_fd, &vfio_device_fds, node) {
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
+static struct NotifierWithReturn vfio_vmfd_change_notifier = {
+    .notify = vfio_device_fd_rebind,
+};
+
 #endif
 
 void vfio_kvm_device_close(void)
@@ -153,6 +236,11 @@ int vfio_kvm_device_add_fd(int fd, Error **errp)
         }
 
         vfio_kvm_device_fd = cd.fd;
+        /*
+         * If the vm file descriptor changes, add a notifier so that we can
+         * re-create the vfio_kvm_device_fd.
+         */
+        kvm_vmfd_add_change_notifier(&vfio_vmfd_change_notifier);
     }
 
     if (ioctl(vfio_kvm_device_fd, KVM_SET_DEVICE_ATTR, &attr)) {
@@ -160,6 +248,8 @@ int vfio_kvm_device_add_fd(int fd, Error **errp)
                          fd);
         return -errno;
     }
+
+    vfio_device_fd_list_add(fd);
 #endif
     return 0;
 }
@@ -183,6 +273,8 @@ int vfio_kvm_device_del_fd(int fd, Error **errp)
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


