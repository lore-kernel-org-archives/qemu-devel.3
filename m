Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82FBDC9EC90
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 13:31:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfHvL-0005u9-Oz; Mon, 12 Jan 2026 08:25:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vfHuV-0004Pl-Bj
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 08:24:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vfHuR-0003sZ-UB
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 08:24:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768224279;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rjXeXMZ86tZhJ3ZpZduWO5G2uNfiO8bwCXFTIf0upHQ=;
 b=AUcKBIyEAx6SQ4UKQR1UlFMrjdlkFCl2I5jDOkdLP1TfeyDosUz99n0O7V54wZPgD3MMBq
 uWoohJWxR/jc/LGroJa1OZZ7TcbE9KRiTkCjv7b0xG5rmYV54VlltS/h3uL3jvSry9bUNY
 r/2rXTctRyLTh5g9NLF4Z7WNbj4WmdY=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-354-BctkYDoGOO2zoB7Tivujag-1; Mon, 12 Jan 2026 08:24:38 -0500
X-MC-Unique: BctkYDoGOO2zoB7Tivujag-1
X-Mimecast-MFC-AGG-ID: BctkYDoGOO2zoB7Tivujag_1768224277
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-34ab8aafd24so3273116a91.0
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 05:24:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768224277; x=1768829077; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rjXeXMZ86tZhJ3ZpZduWO5G2uNfiO8bwCXFTIf0upHQ=;
 b=cSLZSO/X4hetq0xurt8Q32qO7XBo3b21dB+QvgPvD0OuLGHl3Zl2dmfeNtNbsdTlrA
 EgpXD19tTrAoqScwjIi3WDd45+nstghs3eKqMv8S04sjLvEj/23AzRjPP8K5NVgpkrji
 vFoIFYheojeXERtmQ43To2rdO+tAs9qWS9jgZRR6NNdKiMspW1hma5cd5RFaC24P61u2
 eIa11BzZLdMm82yMmNkzhFR6iaH08rWoIndleX98o0kLohpR9SrMCXXVzhMT/3MPwz2s
 0KVRfaGTBFV0ZXtrgJIjfIFzlY1bxp6OSiGEkw7JG+pO9N0d5Eue0gYGV3bj3lfcx7X/
 lH1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768224277; x=1768829077;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rjXeXMZ86tZhJ3ZpZduWO5G2uNfiO8bwCXFTIf0upHQ=;
 b=wKWvqLurSzS6I6onHk5GiQwRsEGqUwvt9CPtRlo8fwiJLb/DUqY8Z1kse98YDAsUnY
 yiVW+8n8qzRsz0uJ1cCEO0GdFsqcZU5wfNen7djeona5uixE4uXRvZzY/SaLe482cGVJ
 fxeTjmq1433FMLH2TNc6dv7fEELhyyTwWjBpFHQXNKYAmAWqemkqN4/89Y2AsR91HX7q
 zZDeATpQpO/84VI4ZTpE6O7DkhYYANZTMAhgzkEVcnBfHQDVYohvhPhLnco6wPMGO45s
 +0QTA1gGvLDn9IaPXt1TUXaV/iXeGw1rpou3nOcS2b9YY+87czRoYqWAdH1hBSzi4YdZ
 JWwA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWfGdv/SmHPkB5y8u+b0c3mMOKjTwXkq6y7b5zHf2zXdDweSxdkBIi4sRuybh8DdyNpNN8lYcu8RLPQ@nongnu.org
X-Gm-Message-State: AOJu0YwVbXy7F4Paz1+gAvYfmpp+j+8FaRapEEx09PK2jxJAJfbln/GE
 zoLdZSx3mxClqc1sLYNHvg6rxl/g+mt2yXRMcf/yOBBmE2zf4v9UsueDVVRC8QVrWqzWlNSXT3X
 hfF9n071TjzoA33MHom8/yFwCnAO0HaQoQgtOXINP3BFBvRBwuKs1jv16
X-Gm-Gg: AY/fxX5Aylpl+bQITg/WaNYeVqYDmGdD/ywkoduckINsXCq/GCi91K4dDJzCs98adoh
 bxJXrZGdfsiVnbXh7v47iQxLLJFVBqZ/jdOYwoPEfDSVNrbnRfm5LYuberU1Zt0Ke8TcCz767jp
 oFF3c7QvkjW5cSjBoGKL5dkEn0rWfZS6UYQIE9u+uyivEabTODIj2p3aJkS6U/q7rR34uT9PqwH
 nSYFh+Qp8lzykU/Xz/pLm1PVWd8l+ND3TnU1P9BQXjXWLMljgy2o2wurHgzyIsiaMthu/OOs/uZ
 GZ+X+xcBYOyASUB0gzWl/sTQ3TxC/7FvR8SbAE7yA16/gqN39xwOosnKME4O4j8mFaQdcCkUbjq
 YCfsz1bhfw9iEIEZk8T1LtQ3EywCph3TGwqesYFsJIqQ=
X-Received: by 2002:a17:90b:17d0:b0:34c:2aac:21a7 with SMTP id
 98e67ed59e1d1-34f5f84a915mr21324728a91.7.1768224276857; 
 Mon, 12 Jan 2026 05:24:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IElmC/CBbXoaNLz/l4K3fsk8Y1ZuefU0GwEfLzGMVbNUZWHvSDM+jXF+iAXoZ1qlDsUp4jVVA==
X-Received: by 2002:a17:90b:17d0:b0:34c:2aac:21a7 with SMTP id
 98e67ed59e1d1-34f5f84a915mr21324707a91.7.1768224276457; 
 Mon, 12 Jan 2026 05:24:36 -0800 (PST)
Received: from rhel9-box.lan ([110.227.88.119])
 by smtp.googlemail.com with ESMTPSA id
 41be03b00d2f7-c4cc05cd87asm17544771a12.15.2026.01.12.05.24.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Jan 2026 05:24:36 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: Bernhard Beschow <shentey@gmail.com>
Cc: Ani Sinha <anisinha@redhat.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH v2 27/32] ppc/openpic: create a new openpic device and
 reattach mem region on coco reset
Date: Mon, 12 Jan 2026 18:52:40 +0530
Message-ID: <20260112132259.76855-28-anisinha@redhat.com>
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
index 9aafef5d9e..4fd70d4b32 100644
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


