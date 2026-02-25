Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89E19F55452
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 03:52:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vv5vx-0001cA-Bi; Tue, 24 Feb 2026 22:51:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vv5vv-0001X6-QM
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 22:51:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vv5vu-0008BW-3x
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 22:51:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771991489;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N2GYk91iN/Cef0bLypCspOTO2fuGrKSH2t08MuJaC6s=;
 b=K1Xi9Rncy+VlcI3n7/b2zPtgC48fOXS6aMV7Rju37oegkBgGg5Dtbk8rXA8WvLIuxbQO9Y
 Ky0x1pMCXs+osFnBZ4PCDrJSXO2m5evxZGqBtZ0HeUJc6kx2hzG+FQeJSymdaRXwF43e/F
 Bzcf6MU8bAaVQWZPhh0MiZNFdcTdUb4=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-hghV9r0FNy-3facoGvivjQ-1; Tue, 24 Feb 2026 22:51:27 -0500
X-MC-Unique: hghV9r0FNy-3facoGvivjQ-1
X-Mimecast-MFC-AGG-ID: hghV9r0FNy-3facoGvivjQ_1771991486
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-c6de06e6c08so4111474a12.3
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 19:51:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771991486; x=1772596286; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N2GYk91iN/Cef0bLypCspOTO2fuGrKSH2t08MuJaC6s=;
 b=Bkn2FVBStgtD4oZt47Y1kcyLDSxEM27ZLX/oWnXgwGCGJYoCaLjcuvznVawQ5YzgV3
 qlPhuf2V6Hu67O45K8PpxDSDd565uaueJ9z/GJaxbPGNKn2q6Pl1WsdWJrsF3vF/w5GP
 LI3aGsJmfACBjS4cdZBbNkrO5Gl4VYpYubVJ+F+y7dVTJB8qfEo3kTChARCPvRNXbEvT
 lKBo2myCJLE8k25LSkBfaPIcTSqP5qPFba0EXAqTo7K7t1wrfBjUmb2XrdAr4D/hCczA
 f0RPlIf62D1mIoeVLKrb4G3gDWPirnVcwFAceIRbrez469fAB1PrjM2fT3Kw4sreoXoW
 IwKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771991486; x=1772596286;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=N2GYk91iN/Cef0bLypCspOTO2fuGrKSH2t08MuJaC6s=;
 b=PPWD3pMg5BUEKF41+iAn9qx9XNP/1pcRjc2oY9cuP4j+KazqsnP2hW7sGrhFpwXJjl
 Z9MYeaHU9AVyomt73o2haAiwu01sUJnh8BIzGZEl1Mr99HxGoq3g766HJH0FPYqvwTvn
 TkaD89JFBSSXwVvrlIr6x83zZDQeau6ayOrFkyLFlCMtcBiVN1VSFf2efpr4FC5ukNKJ
 jfVIkZ6HVB7e8z9Q/VsV0c55kFQy5l0EBtR0kZZU8B4RKRFRX+fPG7FU22hi3RFss/qt
 gOHYWZTl5EXecpJtWAusGd+/ZA6Bkj7J4XtBP/64aoAXb2leBrsJOvg0hJTFSx/uoRQ7
 7LVQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUlZ7mV9ZJ3mP2FBNZVu05LsXscx1cLAPFNHypzy52sEilWgjdxatWDXZWuUj5xr29pKoSLKgOZunov@nongnu.org
X-Gm-Message-State: AOJu0Yxr+rKYEeANL9ogtBpmDYJeRBDuTsJqEB3XTclt3qIIiTK+jPN/
 HIF1U7LepJms9NuF4+RvjHYjDCVPRdDwvAzjFW/RKcQ9ZmaqqRC1K017JENlx0OBnfWGxCbjbEL
 Dottb5iLzbh6KKN6FftNeNsORnCT1r743VBLaOWAVqF3P/Eg/H0hF3kgs
X-Gm-Gg: ATEYQzwgjZGd3CigsuXPszf7rkHq18afAAvY0nc7fT26rQ3CSEQx2ejiU6GkGI7DIlh
 34xhpTOewMI/J0ILocklf6jZII0DGY3/bz9wMbEEb7BNB7nhXr+U3LVhgAByQfa+H7tPvqQ+Cji
 V/g690PJmVZK6GN54EAO+IKHx4yCkkSdCmBvFP3QtTC5lZydmZRQ4aAVE59kwpx9pvqfuTQnPD+
 PpnlPCarngm8JSUgheJpOwQc580x75DoqC8d3jYr4fcA1Oqkubhvur/05cBEoTvdQrC1JaHnuCL
 dGmiQoy4D+JvrZxu4v27LiijQ+GRjTff8x8YMWmf7Okwknxu5jN4d3wOOUWPobvyZ/i50RY88t4
 6WvKCJTDIdj8XtdwYav+iAEGrJJgAfXdnMexcCLHgFnCLiRwOE2rBCLA=
X-Received: by 2002:a05:6a21:6e46:b0:38d:f084:e342 with SMTP id
 adf61e73a8af0-39545f792a7mr12056132637.48.1771991486148; 
 Tue, 24 Feb 2026 19:51:26 -0800 (PST)
X-Received: by 2002:a05:6a21:6e46:b0:38d:f084:e342 with SMTP id
 adf61e73a8af0-39545f792a7mr12056105637.48.1771991485714; 
 Tue, 24 Feb 2026 19:51:25 -0800 (PST)
Received: from rhel9-box.lan ([122.176.129.56])
 by smtp.googlemail.com with ESMTPSA id
 98e67ed59e1d1-359018838b2sm1186006a91.5.2026.02.24.19.51.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Feb 2026 19:51:25 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: Alex Williamson <alex@shazbot.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>, kraxel@redhat.com, pbonzini@redhat.com,
 ani@anisinha.ca, qemu-devel@nongnu.org
Subject: [PATCH v6 23/35] hw/vfio: generate new file fd for pseudo device and
 rebind existing descriptors
Date: Wed, 25 Feb 2026 09:19:28 +0530
Message-ID: <20260225035000.385950-24-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260225035000.385950-1-anisinha@redhat.com>
References: <20260225035000.385950-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.358, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.659,
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


