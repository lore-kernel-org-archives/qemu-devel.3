Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D008BD58E7F
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 08:50:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwyvi-0008Kp-G8; Mon, 02 Mar 2026 03:47:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwyvD-00066H-Ut
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:46:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwyvC-00021q-5d
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:46:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772441193;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KDaYiHSlCecj9I4WEexLBfQYSrCu8gOFeRcdJGMIQVk=;
 b=GfGaStv00b5qJA6nTggphyK6NRIP6E48Jw6DVyMT00c321wY9uSoyc5tWmp0sK3b38KnT6
 2450H8FIOkcLWvRuqXE+oJxs1Qictvdwb0p7QvdReCJ+KKnRlcNdP5Z2VHCucK9rWfXFd9
 vJdzuIZ06SjWRScBs/3lMRViudlVNG0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-114-r9ylfT4pMRacNWunueZDmw-1; Mon, 02 Mar 2026 03:46:32 -0500
X-MC-Unique: r9ylfT4pMRacNWunueZDmw-1
X-Mimecast-MFC-AGG-ID: r9ylfT4pMRacNWunueZDmw_1772441191
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-483a24db6ecso51426485e9.1
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 00:46:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772441190; x=1773045990; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KDaYiHSlCecj9I4WEexLBfQYSrCu8gOFeRcdJGMIQVk=;
 b=GP/2tIjhUPq3OTDbLHnFuQG5hlBIM9YF84BaUNbsS/NHm7BOdGod+gNWrcKHx5ELmn
 PDkv0sYTRJfGVc8ZMYa13qb6yFtdzjG38vqVaq+1Vu30HDCiDlPLjMAU7qf0WcsSRtYw
 zOUfhUhqreyFxV60fImdwmxWhCMyg3YhmAq93gL/HnVXbRAgyzr8+4MfAaSUJ468suy5
 4o3arnXzP1AVdikQSaGLF4N4jV5hZzIu+g5cWtGGl43WGyuVRrR9GjF8qnpn8pSvKeFX
 6mHfruNcP4zYEURQyY2MGjMyASrE4UlNZhkZAq7ykWO1NT890qKdVfjhWXpdTt96kum3
 k/qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772441190; x=1773045990;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KDaYiHSlCecj9I4WEexLBfQYSrCu8gOFeRcdJGMIQVk=;
 b=t/4LkmD+bfSGN4inH3UA/DQEyLM+rCLEkN1jAiTsQUa6wbBsBWgpxv31/6gpOUJprh
 C7PPpTi72eBLvV5zW319JuG8QzXHYqiNMfycPFqF9Np1jwYV8iEDKikBWnzh8pndzNMX
 xH+B0vETvQOSUIihsP3VrPR5kABF2oVqSsqwzv+pm45fzqpyoGCecVj9TNcK2L3Jg5F7
 iZ4nF99g7cnArIPR+Ux/qWZqbVRhR3ch4/W7wVN/4LSuBuWBSXRzJ6OW5Ei8N5N7PhOj
 YfeaywQjbCJhDHbjGQvf6gRS2DlivNQWSXfsG196IeCy5Sm9nEXSC1nkr/ZSFFfD7Ysf
 x+/w==
X-Gm-Message-State: AOJu0YxWXJ95k61aMICGkA3S9E9Xnfrr0c7Iy1t6aU4c4qxfDBPySlMI
 KAe4D8kzlmN29LoHCaqBLAWGhCHXllup1TcxHjS6KS5W9raIljb2sZ4jcRU2wVywIAYPN9r+g9M
 nKZYPoZQ8eYX9/gmFahKRswdlKIVApbUfsE+J2u6sPLEq2nDEbfEr80S0zpCd/Jd+u1rNaBzIYf
 AjUPcTsHK26MvdoEDbUz+diim6yW73xYyOPjMfxgze
X-Gm-Gg: ATEYQzyZ2U9w+tTsAZfGmaCBYpPBIGw09xf1AF4qAME2m6TvnAMKX0w4JrIb3ARVwVB
 ES5W68I0CjCw+GsAIAbzjN2tSW8OYkCCOp63flTPHJk9jdyGdftAI4Zk0LBTecwQHxrcy3Ke27R
 X9TWAuYEsb2tdZ7QC9rP1nu1/a/emw3CegltQI+bVPL66fQVotESYF7eX3fBIXxXElvYs8xtwIE
 /vs77V6AdSwm/htQUDXV6Wjmw7+G0UbjiuJ6t6HVsM4DGYceOTvF5Mf9jlDexLpt0fe4XJJwWar
 y4rvcut8mrDIrSFiyoCcqnjyVr1lpJb7SNyG50XcPQrMqGBiPJuv8i1uE5P8/eGZYXl4OoLq+/4
 HzaWMmsBGlE4de0YeCIDHZxhe6jgBAUSzlKhZg8Aj4Nvhu30esR8vlY2SaiFuUoaUuPd2avd97K
 0kI2UMn7e46Myh99IiN6JWMaGF0mU=
X-Received: by 2002:a05:600c:4e08:b0:483:c12b:fe4a with SMTP id
 5b1f17b1804b1-483c9bc1b64mr196113775e9.11.1772441190147; 
 Mon, 02 Mar 2026 00:46:30 -0800 (PST)
X-Received: by 2002:a05:600c:4e08:b0:483:c12b:fe4a with SMTP id
 5b1f17b1804b1-483c9bc1b64mr196113425e9.11.1772441189554; 
 Mon, 02 Mar 2026 00:46:29 -0800 (PST)
Received: from [192.168.10.48] ([151.95.144.138])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4399c75a523sm25598421f8f.19.2026.03.02.00.46.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2026 00:46:28 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 064/102] hw/vfio: generate new file fd for pseudo device and
 rebind existing descriptors
Date: Mon,  2 Mar 2026 09:42:59 +0100
Message-ID: <20260302084338.473368-65-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260302084338.473368-1-pbonzini@redhat.com>
References: <20260302084338.473368-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.012, RCVD_IN_VALIDITY_RPBL_BLOCKED=1.188,
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

From: Ani Sinha <anisinha@redhat.com>

Normally the vfio pseudo device file descriptor lives for the life of the VM.
However, when the kvm VM file descriptor changes, a new file descriptor
for the pseudo device needs to be generated against the new kvm VM descriptor.
Other existing vfio descriptors needs to be reattached to the new pseudo device
descriptor. This change performs the above steps.

Tested-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Ani Sinha <anisinha@redhat.com>
Link: https://lore.kernel.org/r/20260227072445.406907-1-anisinha@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/vfio/helpers.c | 91 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 91 insertions(+)

diff --git a/hw/vfio/helpers.c b/hw/vfio/helpers.c
index f68f8165d09..00d42d3b98e 100644
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
2.53.0


