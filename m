Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9286E9A03B
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 11:45:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsfz7-0004YW-Tm; Wed, 18 Feb 2026 06:44:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vsfyc-00049T-CQ
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 06:44:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vsfya-00086K-IQ
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 06:44:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771415055;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bSI26ec30q+LRwqH4eGYpPIQO82uWHXpsee53xL/4Nc=;
 b=ZlebyLqpss/FauBTABzdwWn+CZeTTXEQXtsd4/WlclqnZzjrIUgyg0+VjN+NwRRkbs1FGL
 bRkSV+qo8SVjMZSyFaLMI2LGe/fd/LIVx/4R0FEqgp8VxfrHIC9CkkT+O3fmdGDM7zgvaL
 f1EYt7R5qpM9GEuPHQp5iz//b0a0Krw=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-wnSUkizfPf2BkakxNPRYjg-1; Wed, 18 Feb 2026 06:44:14 -0500
X-MC-Unique: wnSUkizfPf2BkakxNPRYjg-1
X-Mimecast-MFC-AGG-ID: wnSUkizfPf2BkakxNPRYjg_1771415053
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2aaf0dbd073so66409475ad.3
 for <qemu-devel@nongnu.org>; Wed, 18 Feb 2026 03:44:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771415053; x=1772019853; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bSI26ec30q+LRwqH4eGYpPIQO82uWHXpsee53xL/4Nc=;
 b=bCt7/Skf9mTXP6GRVaA5QpqdE3RxEAh4d8uGFo/rKwL4bXgMsM+c1qbwSW37XPyE/A
 lPF+gEqKx5x76BImA47cQLga27wOJ1jAHZlr6TsutOsN6jUgOM3jq40EepRY91eNEiiG
 Bgu8h4vckZdpsJLjyVSqEuiNBtZevhr/nHhE8KFJlnW4hE5eROxHmJU+/eYL8OXKM05J
 iv7+Vd8iZxIFg2EeXrGftJE23q1tFm5qP3htI0RUWNltyeMZFHWI4CEaY/h1zmPg0eQQ
 TtoTzyGypTnbfq8JuHIrTCuHYvQUTgncNfO216BaDFhXz3zdgi77ngjusro0W4K1wy6Q
 3jxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771415053; x=1772019853;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bSI26ec30q+LRwqH4eGYpPIQO82uWHXpsee53xL/4Nc=;
 b=FopEgklEHW3xmIlxeY2RZZ6mGPHMRM+oYo9vRoYMx0zmHIUAVdONuMWP/Mo/lodPTp
 t2b2uVMRpQiyDhFNLxIJtXgdKJl2Lsp8iMJjW3dTEoK/Lvu5UPMNFJdM6q9qN/5VDQmU
 Wvy69OThRYApjHlTUGtppBBhrka/S6bmvKkYY4qDCCyaa/BlIxbE2bh53KN5x6HKDiYB
 /xGhdstHZAn2z3aiJE04+Zz9PB6nb2+E1JLYqTrzcUzhru6Cx7Zdth6zGdSQ7kaeNGD2
 LfsE3O/lbSv99ZYXWMdlshXgxpkDhTKzhb6m59150dFigdRsI5eN5Ay+rwpeVoOuOamA
 BOQA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWpmd31qgtwcdzzBq9fQseEORdfNecJor8utWuZiFbhR6WAe5XXoNsQwXnmYTTiCD/Pto/FMfVLZtOb@nongnu.org
X-Gm-Message-State: AOJu0YzKUAi+LND0EZgHnlWiGJXrq653xwKp3kvjS8rKvBorcgSSZg3q
 M5/MEDJ37KvWll1dWvTrrKgMYTBAim/keB6EdIAlCNW8R2bUU56h2yhPiHbRzXk9DxMIW0JLmr4
 tuOIwsXwZyYrEQhZNqwrDwj6gzFWJsOgqUaPbXb1AKw84W4MbRcf8WrCb
X-Gm-Gg: AZuq6aIA7Z4Fi1v8ZVl0slD/0jmJ9rU5npkzTS9j/RiGavbSLJ2mIGl6b8ub/xNvwB8
 yLG//XQHKLuAz2gTod8paIdvJeXEWYn+081yeR9Pv5u9W6lc71bbqwHyoTU8rejRImh8IprOdgJ
 VLiHDLkE9Ew0T503naDr8PZqhvvDpfMrOuqTg+qBVb73KcV5tV3OsfHVBTwC86UvtQbJ0zZlNKX
 8OoYdCocMcL/cA0CCNbAUDwyzVq9+fmOazRaC/NE65iu8dnXsFiQMiaOgVROQZLYrkbC52uqtHN
 BSYTaQe8alT2oakVB/UOi/aB/JD2bM1Ox+OWSEQ+ErTTw0IT24iSdLwvIdIdMLwtTSSb5GEUjnE
 atApIkDdryhucCA8e6hSkzmE1Ly2ENxiMTmRfbh7fxPvzFqQHHiZt
X-Received: by 2002:a17:903:2452:b0:2a1:3ee7:cc75 with SMTP id
 d9443c01a7336-2ab50560babmr177022695ad.19.1771415052822; 
 Wed, 18 Feb 2026 03:44:12 -0800 (PST)
X-Received: by 2002:a17:903:2452:b0:2a1:3ee7:cc75 with SMTP id
 d9443c01a7336-2ab50560babmr177022595ad.19.1771415052405; 
 Wed, 18 Feb 2026 03:44:12 -0800 (PST)
Received: from rhel9-box.lan ([117.99.83.54])
 by smtp.googlemail.com with ESMTPSA id
 d9443c01a7336-2ad1aaeab38sm127803425ad.82.2026.02.18.03.44.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Feb 2026 03:44:11 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: Bernhard Beschow <shentey@gmail.com>
Cc: Ani Sinha <anisinha@redhat.com>, kraxel@redhat.com, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH v5 28/34] ppc/openpic: create a new openpic device and
 reattach mem region on coco reset
Date: Wed, 18 Feb 2026 17:12:21 +0530
Message-ID: <20260218114233.266178-29-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260218114233.266178-1-anisinha@redhat.com>
References: <20260218114233.266178-1-anisinha@redhat.com>
MIME-Version: 1.0
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
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


