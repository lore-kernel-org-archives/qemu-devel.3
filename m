Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95D5AD25938
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 05:19:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkbSi-0007uF-Re; Tue, 27 Jan 2026 00:18:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vkbSV-0007Mc-74
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 00:17:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vkbST-0000Af-KB
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 00:17:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769491064;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sIxPRkcXYN+jvBabI3Le3pQDAeITVcKP3DhgLvFqdx4=;
 b=H393JED/KYpFrVeZDGd5ug1llcw70M7URa9xcFyEASf4L/8vn3Z0lC2jc7wUBVtQG3yzYO
 ggDExnmocYjkQBFhdIGb/TPZfp0PNTkC9C2Eax2CFQf20ZEaie3JByXUoOoYLg7hS4eUB1
 02o1qFoLt6x/jscssM+CtoeFiw4tnVE=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-1okVMy4CPvCno2vgGjQh1g-1; Tue, 27 Jan 2026 00:17:42 -0500
X-MC-Unique: 1okVMy4CPvCno2vgGjQh1g-1
X-Mimecast-MFC-AGG-ID: 1okVMy4CPvCno2vgGjQh1g_1769491061
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-352b6ad49ddso3497115a91.0
 for <qemu-devel@nongnu.org>; Mon, 26 Jan 2026 21:17:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1769491061; x=1770095861; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sIxPRkcXYN+jvBabI3Le3pQDAeITVcKP3DhgLvFqdx4=;
 b=YtkbWPcIgmROkVSDwHtfsQs6SlVtt0YhHx7VDv1ipv2KT60kdCVcUEZIVlCu8aJtzX
 AgVOYwAQ4TL49mDd7xUEJCaWwtmhSArXgLgl86+MMH/cvNHCFRl+uJAYc0vDjO3m788o
 NLwAuPap8PEj9X61RvPWeH0hETaDEEbRNKbU9po2YfkTGuRqX71IDJ25g7bvGreo9W+S
 pgakUcPUoSAJoEMOOjmfLBIaCLFv4FqmVzDjWWBxi6Wx/FkMuq269Azv79DG2SRa8FHk
 mGByN7iS+TbSQ5jSX8JnT8zaUmbwMCK/s04iT+t6OERjlhJS2qNb6dHPLpsJEkyrgU7b
 DnlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769491061; x=1770095861;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=sIxPRkcXYN+jvBabI3Le3pQDAeITVcKP3DhgLvFqdx4=;
 b=rASxBYfq/RDT0gH2tBlHIO8gWrrVT8Wj5XqC6LlJAhMNFSGxp1FCdkbnvTAMs5uM4n
 TXlSz0c9OO5GqnGbJgGS5qwQmvsi0QZnDAIZa/2OGJv5eQ7tfi4/sSHLQVwahbWBnVXC
 xeErRxWSqEzqD4qfs6qSmaZ8RKtpgHhGgNB3QwrozdqoSPl+TT+OPBLrZPWssjQENtYt
 Fl6fEGSbAaiZYLwzJOJW3Lq3akpnbArwS2RYneFyiXO7o32tDydDIoHtpl4TRJcAmzJh
 m/NV9LQxHteEP1w41f5/ucBsM7PYl9F/99yYh65XFGzqU6SeUP14qkS+j0PE9OT+Tpq7
 hRnQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVK6w49trDVsHOGvLWsIt3N/5GbLbuTT4xsxE7oPaIFA2mmThodjddm+lzxhcKlPUz24nIC06P1hO2r@nongnu.org
X-Gm-Message-State: AOJu0YypgFnz0Ei+AtO/MOvIv6VebiR+vJUCPMh1qvj+PN/tdTD/As9r
 Zkm0nSEKWx1WsjAGQtuCWlwOk5hbv286WrvYNeoViLkqKpywyMSWZ+GKAVFl+77UTkBDEanko+s
 vJW6MQDXCbScoj11lSStTYNFSqmKuqoIjjcFInW1Le+eu8uzk5qh06SKH
X-Gm-Gg: AZuq6aL1tw+8zywkm+oQdx/qXai1ywdMER/mTCdvsfgYJrvhaSnqZUcrrPuKIs4ct1D
 E/+InMjh8IxdU7d3ek/cNC3RodcFgz+6jNVud6fUpC16TWnthZNimnzyuwugqPONCKK48GO8ceK
 NBZDoiPGcRyI/GpLmqP/EUduF0RLTJHDU7tc82on9efygnNr+pyYIOlTH2VgOMjzbZeK26iMAot
 W8DBlGMn7f+ZORd8agxiESjM3P6TukpH+fKKFmcNL+vlHLI6TzdayfPwoL4U040ateXyS2++SWl
 b8CyLV2UPX2GO1P5T7BeK42tPUe+Zn5n4YsFSy9QPQcSn24GmOxxLY2SlRiC/Y9jcVaTFFUyI1X
 NMV314fzz4jFGvRz4ORsLC3lYU8J2k2sI/luFTZsr8w==
X-Received: by 2002:a17:90a:d603:b0:341:abdc:8ea2 with SMTP id
 98e67ed59e1d1-353feda9712mr707852a91.37.1769491061121; 
 Mon, 26 Jan 2026 21:17:41 -0800 (PST)
X-Received: by 2002:a17:90a:d603:b0:341:abdc:8ea2 with SMTP id
 98e67ed59e1d1-353feda9712mr707831a91.37.1769491060735; 
 Mon, 26 Jan 2026 21:17:40 -0800 (PST)
Received: from rhel9-box.lan ([122.163.48.79])
 by smtp.googlemail.com with ESMTPSA id
 98e67ed59e1d1-353f6230d5dsm1110925a91.17.2026.01.26.21.17.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jan 2026 21:17:40 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: Alex Williamson <alex@shazbot.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Cc: kraxel@redhat.com, Ani Sinha <anisinha@redhat.com>, qemu-devel@nongnu.org
Subject: [PATCH v3 22/33] hw/vfio: generate new file fd for pseudo device and
 rebind existing descriptors
Date: Tue, 27 Jan 2026 10:45:50 +0530
Message-ID: <20260127051612.219475-23-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260127051612.219475-1-anisinha@redhat.com>
References: <20260127051612.219475-1-anisinha@redhat.com>
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
 hw/vfio/helpers.c | 86 +++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 83 insertions(+), 3 deletions(-)

diff --git a/hw/vfio/helpers.c b/hw/vfio/helpers.c
index f68f8165d0..d467875b4b 100644
--- a/hw/vfio/helpers.c
+++ b/hw/vfio/helpers.c
@@ -110,12 +110,71 @@ bool vfio_get_info_dma_avail(struct vfio_iommu_type1_info *info,
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
@@ -137,6 +196,7 @@ int vfio_kvm_device_add_fd(int fd, Error **errp)
         .attr = KVM_DEV_VFIO_FILE_ADD,
         .addr = (uint64_t)(unsigned long)&fd,
     };
+    KVMVfioFileFd *file_fd;
 
     if (!kvm_enabled()) {
         return 0;
@@ -153,6 +213,11 @@ int vfio_kvm_device_add_fd(int fd, Error **errp)
         }
 
         vfio_kvm_device_fd = cd.fd;
+        /*
+         * If the vm file descriptor changes, add a notifier so that we can
+         * re-create the vfio_kvm_device_fd.
+         */
+        kvm_vmfd_add_change_notifier(&kvm_vfio_vmfd_change_notifier);
     }
 
     if (ioctl(vfio_kvm_device_fd, KVM_SET_DEVICE_ATTR, &attr)) {
@@ -160,6 +225,11 @@ int vfio_kvm_device_add_fd(int fd, Error **errp)
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
@@ -172,6 +242,7 @@ int vfio_kvm_device_del_fd(int fd, Error **errp)
         .attr = KVM_DEV_VFIO_FILE_DEL,
         .addr = (uint64_t)(unsigned long)&fd,
     };
+    KVMVfioFileFd *file_fd;
 
     if (vfio_kvm_device_fd < 0) {
         error_setg(errp, "KVM VFIO device isn't created yet");
@@ -183,6 +254,15 @@ int vfio_kvm_device_del_fd(int fd, Error **errp)
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


