Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2F25D4922D
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Dec 2025 15:08:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vU4j2-0005Ev-ND; Fri, 12 Dec 2025 10:06:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vU4iX-0004Ue-GD
 for qemu-devel@nongnu.org; Fri, 12 Dec 2025 10:06:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vU4iT-0006QZ-H5
 for qemu-devel@nongnu.org; Fri, 12 Dec 2025 10:06:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765551956;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A4vnbj5L7X5BAm2SsE/iQx+vqw+O4ovyAazkVrIup+Q=;
 b=GdWRp5ktQZnEE0KSGMs72CQtVWFODkhL0QIbRdyFNnIloxuuzgG1h1LXX6O4fTtCpd2PyO
 3vmUjEYDYYTqnlsQhKkKmP634r71FsOJGZMZj3N+LsyvT5djAsPlp7A5ZF/IXtA1/NdA8N
 NNLSxGQZQLEB9fbZfj/8aTUiDt09tcQ=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-cFxeZ7kNPe-UTwYfbLd1RA-1; Fri, 12 Dec 2025 10:05:50 -0500
X-MC-Unique: cFxeZ7kNPe-UTwYfbLd1RA-1
X-Mimecast-MFC-AGG-ID: cFxeZ7kNPe-UTwYfbLd1RA_1765551949
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-295592eb5dbso25017855ad.0
 for <qemu-devel@nongnu.org>; Fri, 12 Dec 2025 07:05:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765551949; x=1766156749; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A4vnbj5L7X5BAm2SsE/iQx+vqw+O4ovyAazkVrIup+Q=;
 b=I/Y1uruQj+Pz7g8gYwogdrOTy3S5RahS+JrQ3kmcq7xET1Ejd3PyWpanDYQitgCZnR
 4zLu2G1s7ixME3UHvxjOEOtkX1dJDP0/7PYqbX/bzrf9l9wubeFkqchqq7A/PqOxZoeK
 W68i+Clx+9ONL6JZZb3VXUE4ukxHEzYv/RaFXkeOoQ5aRfLEJyMU2QUUSMNndH6EgC/R
 6jybjYW/4QK/hOHBi8LhCInq6vS69k+gpLKM2dNQrVfgYvQfeFhF8r8LbKpuhqgDQBbi
 ZL+qtaZPJU3NMJXhWbfgHTk48a9ZVm8cd0iPpHuobPt5A7GEEmKi81x88w7f0hOvdrvX
 XK7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765551949; x=1766156749;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=A4vnbj5L7X5BAm2SsE/iQx+vqw+O4ovyAazkVrIup+Q=;
 b=Lw/d+AAKpPiX0PO3+94YOswN6Y/Gc8DUxL48wm5fZ2tG4p03Q7FcZcfq72WQ6l5dI8
 POm9SjUfV43D65WHKa9qYS+36+yHf2jS4cgQCGqA4flY4anWRg+chErAKrWgLmjsuUql
 bMg6CF8e8OGHnx/n1UvUdpDP1pVSHXeoUQ+aw3hcY2YKOXjKuRLgomFWI6kddeUNcCN+
 8hE8d8vnxbR9WV4JC+FewrPbfl+go87SD7TZh0w5HmQ4Smtq8JbTxzCOlfEhB/znO0rL
 RyIzzw9n6oNfZd5ceztMwzzNMUg3fOAckS098IW8KpQTZMvGViuG5Xqr0o7me63tVSBl
 5rdA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQHcmMLB1n0fZdo9okGSQfDlOaN9vjjiZJrHif89FTyEQPzbl0e4GfwqWkL+qEANZahHQv8ujElHu8@nongnu.org
X-Gm-Message-State: AOJu0YzT7ifRG1mkp+D34/Gj36cmCCh/PvuyoF3dAfaNwvflPtwpGEys
 UveqDMhpeXacGOLsfPoh2zj+8MOA5DK4V1OTsAiJCh67HV+Qrq3B53d/+gmnvvWNtz2Zxv6Dp2v
 +J4RDSFFWYjjxfySkdXkJyQZyigWbay7XGP91+WiAIGbJeidGMDp1zbLX
X-Gm-Gg: AY/fxX6FtUnovm80dZeV8d8sa0p1mMKCv6twHBsB3auMoP24ILQjrX5+vxl01VbAQSC
 T90u4oM/xY6A+XBwEdJlJj2SEo8F4NpLXyaaLVQfJt5yfaR2uj/CrLLXtoLKexynl6r2Zd7Uvs/
 of7rRxkfCy2Ht4PmXXGmRNUGVSZOF4uP/xVh8L1dLvKBa4upLGYImzef4sgcDQ//8bJVZ+worPm
 7vq+AjlaNomMgbnER6Lrz2tVKIi+0H7IpbOCmowHTizW3xNMLfjyFVCjP8oFBCiSv9jH2/b1aPy
 R2QhkkeuFwlyDjOtioeCQ3ZRnQhnPoeaAKZsMCPauVVUeGkleTnWmYJQxPhKbhjXLTVd2i+ryRt
 BD3vr5SQIn58O1b7y48nq7elTV4W/7tZbdR0dpxIlroA=
X-Received: by 2002:a17:902:ce0b:b0:297:ddb6:ef81 with SMTP id
 d9443c01a7336-29f23b456cemr27551815ad.16.1765551948333; 
 Fri, 12 Dec 2025 07:05:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEfAXYymCrcmJjczDyXrFRejWflzv3WP2N8ZZ8Jsj8XU3fNyM0JbSLVcod5dbiyzRghA0MAow==
X-Received: by 2002:a17:902:ce0b:b0:297:ddb6:ef81 with SMTP id
 d9443c01a7336-29f23b456cemr27551305ad.16.1765551947655; 
 Fri, 12 Dec 2025 07:05:47 -0800 (PST)
Received: from rhel9-box.lan ([122.172.173.62])
 by smtp.googlemail.com with ESMTPSA id
 d9443c01a7336-29ee9d38ad1sm57046655ad.29.2025.12.12.07.05.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Dec 2025 07:05:47 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: Bernhard Beschow <shentey@gmail.com>
Cc: vkuznets@redhat.com, kraxel@redhat.com, pbonzini@redhat.com,
 qemu-devel@nongnu.org, Ani Sinha <anisinha@redhat.com>, qemu-ppc@nongnu.org
Subject: [PATCH v1 25/28] ppc/openpic: create a new openpic device and
 reattach mem region on coco reset
Date: Fri, 12 Dec 2025 20:33:53 +0530
Message-ID: <20251212150359.548787-26-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20251212150359.548787-1-anisinha@redhat.com>
References: <20251212150359.548787-1-anisinha@redhat.com>
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
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

For confidential guests during the reset process, the old KVM VM file
descriptor is closed and a new one is created. When a new file descriptor is
created, a new openpic device needs to be created against this new KVM VM file
descriptor as well. Additionally, existing memory region needs to be reattached
to this new openpic device and proper CPU attributes set associating new file
descriptor. This change makes this happen with the help of a callback handler
that gets called when the KVM VM file descriptor changes as a part of the
confidential guest reset process.

Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 hw/intc/openpic_kvm.c | 108 ++++++++++++++++++++++++++++++++----------
 1 file changed, 83 insertions(+), 25 deletions(-)

diff --git a/hw/intc/openpic_kvm.c b/hw/intc/openpic_kvm.c
index 673ea9ca05..1b7a1d0d00 100644
--- a/hw/intc/openpic_kvm.c
+++ b/hw/intc/openpic_kvm.c
@@ -49,6 +49,7 @@ struct KVMOpenPICState {
     uint32_t fd;
     uint32_t model;
     hwaddr mapped;
+    NotifierWithReturn open_pic_vmfd_change_notifier;
 };
 
 static void kvm_openpic_set_irq(void *opaque, int n_IRQ, int level)
@@ -114,6 +115,83 @@ static const MemoryRegionOps kvm_openpic_mem_ops = {
     },
 };
 
+static int create_open_pic_device(KVMOpenPICState *opp, Error **errp)
+{
+    int kvm_openpic_model;
+    struct kvm_create_device cd = {0};
+    KVMState *s = kvm_state;
+    int ret;
+
+    switch (opp->model) {
+    case OPENPIC_MODEL_FSL_MPIC_20:
+        kvm_openpic_model = KVM_DEV_TYPE_FSL_MPIC_20;
+        break;
+
+    case OPENPIC_MODEL_FSL_MPIC_42:
+        kvm_openpic_model = KVM_DEV_TYPE_FSL_MPIC_42;
+        break;
+
+    default:
+        error_setg(errp, "Unsupported OpenPIC model %" PRIu32, opp->model);
+        return -1;
+    }
+
+    cd.type = kvm_openpic_model;
+    ret = kvm_vm_ioctl(s, KVM_CREATE_DEVICE, &cd);
+    if (ret < 0) {
+        error_setg(errp, "Can't create device %d: %s",
+                   cd.type, strerror(errno));
+        return -1;
+    }
+    opp->fd = cd.fd;
+
+    return 0;
+}
+
+static int open_pic_vmfd_handle_vmfd_change(NotifierWithReturn *notifier,
+                                            void *data, Error **errp)
+{
+    KVMOpenPICState *opp = container_of(notifier, KVMOpenPICState,
+                                        open_pic_vmfd_change_notifier);
+    uint64_t reg_base;
+    struct kvm_device_attr attr;
+    CPUState *cs;
+    int ret;
+
+    /* close the old descriptor */
+    close(opp->fd);
+
+    if (create_open_pic_device(opp, errp) < 0) {
+        return -1;
+    }
+
+    if (!opp->mapped) {
+        return 0;
+    }
+
+    reg_base = opp->mapped;
+    attr.group = KVM_DEV_MPIC_GRP_MISC;
+    attr.attr = KVM_DEV_MPIC_BASE_ADDR;
+    attr.addr = (uint64_t)(unsigned long)&reg_base;
+
+    ret = ioctl(opp->fd, KVM_SET_DEVICE_ATTR, &attr);
+    if (ret < 0) {
+        fprintf(stderr, "%s: %s %" PRIx64 "\n", __func__,
+                strerror(errno), reg_base);
+        return -1;
+    }
+
+    CPU_FOREACH(cs) {
+        ret = kvm_vcpu_enable_cap(cs, KVM_CAP_IRQ_MPIC, 0, opp->fd,
+                                   kvm_arch_vcpu_id(cs));
+        if (ret < 0) {
+            return ret;
+        }
+    }
+
+    return 0;
+}
+
 static void kvm_openpic_region_add(MemoryListener *listener,
                                    MemoryRegionSection *section)
 {
@@ -197,37 +275,14 @@ static void kvm_openpic_realize(DeviceState *dev, Error **errp)
     SysBusDevice *d = SYS_BUS_DEVICE(dev);
     KVMOpenPICState *opp = KVM_OPENPIC(dev);
     KVMState *s = kvm_state;
-    int kvm_openpic_model;
-    struct kvm_create_device cd = {0};
-    int ret, i;
+    int i;
 
     if (!kvm_check_extension(s, KVM_CAP_DEVICE_CTRL)) {
         error_setg(errp, "Kernel is lacking Device Control API");
         return;
     }
 
-    switch (opp->model) {
-    case OPENPIC_MODEL_FSL_MPIC_20:
-        kvm_openpic_model = KVM_DEV_TYPE_FSL_MPIC_20;
-        break;
-
-    case OPENPIC_MODEL_FSL_MPIC_42:
-        kvm_openpic_model = KVM_DEV_TYPE_FSL_MPIC_42;
-        break;
-
-    default:
-        error_setg(errp, "Unsupported OpenPIC model %" PRIu32, opp->model);
-        return;
-    }
-
-    cd.type = kvm_openpic_model;
-    ret = kvm_vm_ioctl(s, KVM_CREATE_DEVICE, &cd);
-    if (ret < 0) {
-        error_setg(errp, "Can't create device %d: %s",
-                   cd.type, strerror(errno));
-        return;
-    }
-    opp->fd = cd.fd;
+    create_open_pic_device(opp, errp);
 
     sysbus_init_mmio(d, &opp->mem);
     qdev_init_gpio_in(dev, kvm_openpic_set_irq, OPENPIC_MAX_IRQ);
@@ -236,6 +291,9 @@ static void kvm_openpic_realize(DeviceState *dev, Error **errp)
     opp->mem_listener.region_del = kvm_openpic_region_del;
     opp->mem_listener.name = "openpic-kvm";
     memory_listener_register(&opp->mem_listener, &address_space_memory);
+    opp->open_pic_vmfd_change_notifier.notify =
+        open_pic_vmfd_handle_vmfd_change;
+    kvm_vmfd_add_change_notifier(&opp->open_pic_vmfd_change_notifier);
 
     /* indicate pic capabilities */
     msi_nonbroken = true;
-- 
2.42.0


