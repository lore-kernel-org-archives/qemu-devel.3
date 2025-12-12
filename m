Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D5A3D49232
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Dec 2025 15:06:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vU4i6-0002ii-SZ; Fri, 12 Dec 2025 10:05:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vU4i4-0002Wf-6J
 for qemu-devel@nongnu.org; Fri, 12 Dec 2025 10:05:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vU4i1-00065w-5f
 for qemu-devel@nongnu.org; Fri, 12 Dec 2025 10:05:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765551928;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=An7ksy++b8pjEaWmUyibgQbRoj3a44CDnsQt2f4omE0=;
 b=XvIHtSAK2m5X91VogQ0MLSFTUxivRExG2Vz+dTJoC4k3ilOit5Yuum0+24u22yJDrFVBZT
 r9hmaQDS0c1kGrDyGmwajHHYKZRASjZhkgJ3xpzjvcwcs5BFModrnKO9b+eS2VCJcio4ud
 gmt+vpolSNm1oBDU/Jsw2SmAK6eafNg=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-193-hTCN029VPEGH7dqKmMJ2SQ-1; Fri, 12 Dec 2025 10:05:27 -0500
X-MC-Unique: hTCN029VPEGH7dqKmMJ2SQ-1
X-Mimecast-MFC-AGG-ID: hTCN029VPEGH7dqKmMJ2SQ_1765551926
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-c0c65e5f688so519182a12.1
 for <qemu-devel@nongnu.org>; Fri, 12 Dec 2025 07:05:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765551926; x=1766156726; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=An7ksy++b8pjEaWmUyibgQbRoj3a44CDnsQt2f4omE0=;
 b=qTKhQwveBFek5NfYsMjjJA8CVjM38BvPFzeUgugVylqCSAA3xf0btspFgitMqzvBWm
 j7YMyPbkpibglnnJC2mFGCzPavS74tYkoEI8cNcW4bJu3SW4GZsoU1ISdg1Ejf35Dbv/
 6A20aE5eOuoFUgHmJER0tDC5B8OFS/WRmLzTivMFYJ39oiu+OAKyElzGomlITqJzlvtf
 4v36ELkzwO26M8dpPzkVYwXSRiUgwJYAD+iFZLGoo6ffIOvyy+Kgtwovjl5J2zqESEpY
 VKicT9n22nHTl4n1SaAaHte4Ul4O6GUxubhkoSWXbMk7qahP4RA7ZaTKGUasvSvhuU+A
 amNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765551926; x=1766156726;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=An7ksy++b8pjEaWmUyibgQbRoj3a44CDnsQt2f4omE0=;
 b=u4j1BAhw7xtgCeT5euDcliz2qpM2XEtaSrm6YP1recWcCKuO7uqKdDNbByaNlLgaQP
 vS1Qr44DDVDM08asfUaJ0Gr2jX32LSy0OZVCrUyEPMGURQF8NeFr0s25Jv3RUJ1G2/g+
 yBmxwwYHtZt35EQ6AXX1qFKJkg+Qi+xLbExX+mAM8+YbSw+kMYlYJFgrKp4uSBt6qQSF
 UiAYS8u5P19XSFX49/cq3nICgtM1+boOrif49H6rFaROdWi9qHF5wVxQlGEQisEDC3Xc
 /duD1sVQCwRNKfLEavTaJFl0iiNQVmp/y7QXtBl+wMgbii+0YvAxyOAqKk0qt7buanj8
 W7uA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVJd2Vtojr+Rf9wPwrGNzLugPAk1lheRq32y3XY+FQLaHWtKDEVqmUgHW9WvuX65mAtTYEb8lAdZRT3@nongnu.org
X-Gm-Message-State: AOJu0YxHFZjhUw94sPg2k9bHlSmCOn79FPElGmW0D4TqUfd0npz38Tk3
 LsqFLTOF2b/2RXa8chwimQN0eaH74ZXDTvPrrgQtaAUgLhvZ8/XGTaGilwEhsRXEv8tFXq6hqFG
 qzEzHF7uo2Y+7hEXJmuK02Gu4xIZXLrr9HStBoMOZGH3prS/wGsL5TAeg
X-Gm-Gg: AY/fxX4yGK+fd7M0ESw23sc8NiKQRTw77uDD5jyHOS9hi2wt6A+7ustokYVJ09GxgzR
 PhaijdLcSsn0avdp+/6bI/4H9wOYoutqEnMyoCFCDcs0BijHb5ETBppyWTy3u1LZuNbafRB7Nbd
 5FDN76EJzFKiqNnvz44LlVc7jWsHCgutAT05WsA24lTppdtRAqZ2Ralaq/SnR/oeE2dKf2WxNoq
 B5p1wh/r7e1pALUecsJd4ExS1d0GFG8NvI0qf8YBUdnf+ChsyB/NdUDpHyn6Nn1BjfYtxZ8dfYB
 IR9GlfBce35HUq/cJ7hgSH3yXZhK7nQdxxkTNRGiP+Wfqxjv3Ayc5BFfrb+WlVSiqdtQk4K2ZIg
 E4Mr5pcHLdO4DlgrATLXY0zwOHSAx4uTQMv5tveGKSS4=
X-Received: by 2002:a17:903:3c6d:b0:298:360:1662 with SMTP id
 d9443c01a7336-29eee9f1ad5mr54292355ad.1.1765551925751; 
 Fri, 12 Dec 2025 07:05:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHoKR/S5A//jCh7WGyYiKpZMMZpKIKyrpZfPWPfiXIIh/IS0nvD0Lt12QdEA3Iftgc084U4/Q==
X-Received: by 2002:a17:903:3c6d:b0:298:360:1662 with SMTP id
 d9443c01a7336-29eee9f1ad5mr54291715ad.1.1765551925072; 
 Fri, 12 Dec 2025 07:05:25 -0800 (PST)
Received: from rhel9-box.lan ([122.172.173.62])
 by smtp.googlemail.com with ESMTPSA id
 d9443c01a7336-29ee9d38ad1sm57046655ad.29.2025.12.12.07.05.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Dec 2025 07:05:24 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: Alex Williamson <alex@shazbot.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Cc: vkuznets@redhat.com, kraxel@redhat.com, pbonzini@redhat.com,
 qemu-devel@nongnu.org, Ani Sinha <anisinha@redhat.com>
Subject: [PATCH v1 19/28] hw/vfio: generate new file fd for pseudo device and
 rebind existing descriptors
Date: Fri, 12 Dec 2025 20:33:47 +0530
Message-ID: <20251212150359.548787-20-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20251212150359.548787-1-anisinha@redhat.com>
References: <20251212150359.548787-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
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
List-Id: <qemu-devel.nongnu.org>
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
index 23d13e5db5..ad9e9c9ead 100644
--- a/hw/vfio/helpers.c
+++ b/hw/vfio/helpers.c
@@ -109,12 +109,66 @@ bool vfio_get_info_dma_avail(struct vfio_iommu_type1_info *info,
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
@@ -136,6 +190,7 @@ int vfio_kvm_device_add_fd(int fd, Error **errp)
         .attr = KVM_DEV_VFIO_FILE_ADD,
         .addr = (uint64_t)(unsigned long)&fd,
     };
+    KVMVfioFileFd *file_fd;
 
     if (!kvm_enabled()) {
         return 0;
@@ -152,6 +207,11 @@ int vfio_kvm_device_add_fd(int fd, Error **errp)
         }
 
         vfio_kvm_device_fd = cd.fd;
+        /*
+         * If the vm file descriptor changes, add a notifier so that we can
+         * re-create the vfio_kvm_device_fd.
+         */
+        kvm_vmfd_add_change_notifier(&kvm_vfio_vmfd_change_notifier);
     }
 
     if (ioctl(vfio_kvm_device_fd, KVM_SET_DEVICE_ATTR, &attr)) {
@@ -159,6 +219,11 @@ int vfio_kvm_device_add_fd(int fd, Error **errp)
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
@@ -171,6 +236,7 @@ int vfio_kvm_device_del_fd(int fd, Error **errp)
         .attr = KVM_DEV_VFIO_FILE_DEL,
         .addr = (uint64_t)(unsigned long)&fd,
     };
+    KVMVfioFileFd *file_fd;
 
     if (vfio_kvm_device_fd < 0) {
         error_setg(errp, "KVM VFIO device isn't created yet");
@@ -182,6 +248,15 @@ int vfio_kvm_device_del_fd(int fd, Error **errp)
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


