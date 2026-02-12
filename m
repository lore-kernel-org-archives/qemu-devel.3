Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D369FEDF04B
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 06:29:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqQAp-0000wo-T0; Thu, 12 Feb 2026 01:27:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vqQAb-0000Sg-9W
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 01:27:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vqQAX-0005MJ-0h
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 01:27:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770877636;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bSI26ec30q+LRwqH4eGYpPIQO82uWHXpsee53xL/4Nc=;
 b=b/ARzrE7l+46ak0fmlFtevNCNnlnXFrUGmL/vJKg3U+i7nqm4EhaSjxvQgD0s2pKkmlpsG
 CNpAyj9uvTMoJRkgcHOhKChzRy6JlFE6hqCT4lG82ubAO3uvsPiQEh45k7LylTYr6wHm1O
 aO6ap2v5GxrpvITK8VteyaDU1RU6L0U=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-bJRNQtlPOy6jLNPszDNqMw-1; Thu, 12 Feb 2026 01:27:14 -0500
X-MC-Unique: bJRNQtlPOy6jLNPszDNqMw-1
X-Mimecast-MFC-AGG-ID: bJRNQtlPOy6jLNPszDNqMw_1770877634
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2a863be8508so78266305ad.2
 for <qemu-devel@nongnu.org>; Wed, 11 Feb 2026 22:27:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770877633; x=1771482433; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bSI26ec30q+LRwqH4eGYpPIQO82uWHXpsee53xL/4Nc=;
 b=LuPjpmT67Hv8r/EBhzfQEa1EVsuIBvXSDSUqU4r6GosgYTVMxiIkhVsx+Z5GMzjD+z
 TUrdytJWiQ5QZCmHZJH34jzXX3wmPJs9We07SZE9F64E35Zc07nkYDBGI5Si0+Amw3j5
 E5pLVYcQ7mRaIy8MwZ3kfx/BvX0iyGRUsUXuLTDfPGACvyaT+d8Mgv41l0K8KsiQcFFG
 q5+K5Mm0aIGN2vFwV3U4BzZRlAq6jCNJvXqyzIQRcMXOHjVoYhbNQaQJ7v6vAeBxeBJW
 7ALy6aJVpEiYiZyQrpocBcWB1LV4kPkyrd71qwqxE/tuCZJWaymC9Oi2sL7SYjNBX8P7
 yTxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770877633; x=1771482433;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bSI26ec30q+LRwqH4eGYpPIQO82uWHXpsee53xL/4Nc=;
 b=TmkyOGDIMELGkVaVmrU3JtRtPpqqvWJDY/Y9YzFpWoeSHPMMFsHRgUWQG1Gu582n8B
 O22tuzfysLkqlq95f51tspIw4usgxc31Vp+PF0vsvHlyshzfCgVHP2u0n2qHTOzzP4oz
 Qr/zPsXj4pVIlLaTtiAlj9XPLSqwOdRZ+xdP85dP0MjEn1QZGHv+7TjtahzpHDb2IcIp
 5zuSffe/wki3qoBT3UK+j+8vifgHXT5qu7fYINoAyN6SPaYMGVtwPbbAZIUk/D1fBmv2
 OJeIhrHfcrZ/eUf5sTW+dxljBQ8PWXod5+FahBfSlR07F38v7vy2/l+Z1QqKiZooaPzv
 MelA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVBDn799CCYmzEIJxwQRFiqVtZxARrNodi/M67tUUgubp1+DqijCnAInif9Nh9pF5R2xso9amr7OAo4@nongnu.org
X-Gm-Message-State: AOJu0YyHROF/uIaAiY7wAsnzKbs+8GRrWc1NOsjigQ6sX/ALr1Q94hZl
 KJ/U8aUIELVOBPmnADy7nDAL8kRJow2ck05wVV6w3AQBDD55bKmyjp10VcMzQsCSJKng+PpAUm8
 n9m+AZORXhx/QokYl4NDyQAIL0mWrOvnXHMypgIfCoqI6WsgyaxAivm5L
X-Gm-Gg: AZuq6aKl5T+JqnRbIZp2t1kokPoC4V/fh/B42ozcXPAf5jFhNUzZX8UJsByrwN1zwOO
 5X4pj3bHQFz5+CduJmVXC7hri0ZDRZcMmVKBMBXkr/pqxcgSdnisz5MgJFW0YDf3kod+o7f8Spm
 esexZlAc7K9POQDY1xqzs+CZMqg1+oojCkD6NRjK28N6/xV7/fMOStxJIKPYUyFgflc9DlTB/GJ
 Ob27Yn1zzAIYmKx1LG79RvCINTeaRabg4jpH70t6UIbbGr/fllgXnlNdlJOjyVMVjFJC0Io2PXW
 RkYWaaFswYcD1O/4znRJ9bOzKdmYxiqsp1+qX7tfZPBWzs1MzuWFVXd12r+bWXDXVPAjCCcj0BM
 l0b0UOL5JwpSXNp8M9KY9NPZtMkZ7lMkWhoXIVi5Sf0oh/RvYjMjtSMM=
X-Received: by 2002:a05:6a20:a103:b0:38f:df47:87b2 with SMTP id
 adf61e73a8af0-3944883cb87mr1895470637.53.1770877633583; 
 Wed, 11 Feb 2026 22:27:13 -0800 (PST)
X-Received: by 2002:a05:6a20:a103:b0:38f:df47:87b2 with SMTP id
 adf61e73a8af0-3944883cb87mr1895445637.53.1770877633122; 
 Wed, 11 Feb 2026 22:27:13 -0800 (PST)
Received: from rhel9-box.lan ([122.164.27.113])
 by smtp.googlemail.com with ESMTPSA id
 98e67ed59e1d1-3567e7d95d8sm4894122a91.2.2026.02.11.22.27.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Feb 2026 22:27:12 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: Bernhard Beschow <shentey@gmail.com>
Cc: kraxel@redhat.com, Ani Sinha <anisinha@redhat.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH v4 27/31] ppc/openpic: create a new openpic device and
 reattach mem region on coco reset
Date: Thu, 12 Feb 2026 11:55:11 +0530
Message-ID: <20260212062522.99565-28-anisinha@redhat.com>
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

For confidential guests during the reset process, the old KVM VM file
descriptor is closed and a new one is created. When a new file descriptor is
created, a new openpic device needs to be created against this new KVM VM file
descriptor as well. Additionally, existing memory region needs to be reattached
to this new openpic device and proper CPU attributes set associating new file
descriptor. This change makes this happen with the help of a callback handler
that gets called when the KVM VM file descriptor changes as a part of the
confidential guest reset process.

Reviewed-by: Bernhard Beschow <shentey@gmail.com>
Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 hw/intc/openpic_kvm.c | 112 +++++++++++++++++++++++++++++++++---------
 1 file changed, 88 insertions(+), 24 deletions(-)

diff --git a/hw/intc/openpic_kvm.c b/hw/intc/openpic_kvm.c
index fbf0bdbe07..b099da20eb 100644
--- a/hw/intc/openpic_kvm.c
+++ b/hw/intc/openpic_kvm.c
@@ -49,6 +49,7 @@ struct KVMOpenPICState {
     uint32_t fd;
     uint32_t model;
     hwaddr mapped;
+    NotifierWithReturn vmfd_change_notifier;
 };
 
 static void kvm_openpic_set_irq(void *opaque, int n_IRQ, int level)
@@ -114,6 +115,88 @@ static const MemoryRegionOps kvm_openpic_mem_ops = {
     },
 };
 
+static int kvm_openpic_setup(KVMOpenPICState *opp, Error **errp)
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
+static int kvm_openpic_handle_vmfd_change(NotifierWithReturn *notifier,
+                                          void *data, Error **errp)
+{
+    KVMOpenPICState *opp = container_of(notifier, KVMOpenPICState,
+                                        vmfd_change_notifier);
+    uint64_t reg_base;
+    struct kvm_device_attr attr;
+    CPUState *cs;
+    int ret;
+
+    /* we are not interested in pre vmfd change notification */
+    if (((VmfdChangeNotifier *)data)->pre) {
+        return 0;
+    }
+
+    /* close the old descriptor */
+    close(opp->fd);
+
+    if (kvm_openpic_setup(opp, errp) < 0) {
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
+        error_setg(errp, "%s: %s %" PRIx64, __func__,
+                   strerror(errno), reg_base);
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
@@ -197,36 +280,14 @@ static void kvm_openpic_realize(DeviceState *dev, Error **errp)
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
-        error_setg_errno(errp, errno, "Can't create device %d", cd.type);
-        return;
-    }
-    opp->fd = cd.fd;
+    kvm_openpic_setup(opp, errp);
 
     sysbus_init_mmio(d, &opp->mem);
     qdev_init_gpio_in(dev, kvm_openpic_set_irq, OPENPIC_MAX_IRQ);
@@ -235,6 +296,9 @@ static void kvm_openpic_realize(DeviceState *dev, Error **errp)
     opp->mem_listener.region_del = kvm_openpic_region_del;
     opp->mem_listener.name = "openpic-kvm";
     memory_listener_register(&opp->mem_listener, &address_space_memory);
+    opp->vmfd_change_notifier.notify =
+        kvm_openpic_handle_vmfd_change;
+    kvm_vmfd_add_change_notifier(&opp->vmfd_change_notifier);
 
     /* indicate pic capabilities */
     msi_nonbroken = true;
-- 
2.42.0


