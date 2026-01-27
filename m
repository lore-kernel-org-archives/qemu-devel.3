Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93982D25932
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 05:19:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkbSs-0000Gy-JR; Tue, 27 Jan 2026 00:18:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vkbSo-0008U0-7V
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 00:18:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vkbSl-0000Fe-8Q
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 00:18:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769491082;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gU47pROJlf30vx7cUz6NgZ8ND/evzCsZCahJ4DIhgGw=;
 b=QwiIL7/OuksIzLAmuDE95ezawGtjcue1nUb5+Yn7K4lt1Tr1Kkgaioyc6P+hg4uY2X4tqx
 wVeHAZX5ODmcl5n4CVREMhtKigxDso/ctbdXuqphDXG+IawuG/k/RWLkusO3DrV+8NbWZo
 aEOMkFuZN59EAL1lQacA/DCxm8NyRnU=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-70-Qt9wpXLcPNuY-DEsuA6lpA-1; Tue, 27 Jan 2026 00:18:00 -0500
X-MC-Unique: Qt9wpXLcPNuY-DEsuA6lpA-1
X-Mimecast-MFC-AGG-ID: Qt9wpXLcPNuY-DEsuA6lpA_1769491079
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-34c213419f5so3549894a91.2
 for <qemu-devel@nongnu.org>; Mon, 26 Jan 2026 21:18:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1769491079; x=1770095879; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gU47pROJlf30vx7cUz6NgZ8ND/evzCsZCahJ4DIhgGw=;
 b=dxi+iNStKg7XqvVZtK1img/LOd6r39bm46L449mQM28VdBCQ2qRA8ft/lv8FTA8bcF
 uNbUb3EFiMsOpNfYxS6QuS8Un2xUcALYShqIHB8RoWPcJLc0ETJU89JUVZeqN896c8uo
 mKelU5Rfiy2zs601tLvCNr4ooBbvB4QB4vadyC8/trxb9a9CkTnlquHU2w3DEuVv/vjY
 krYl4vghs4LdSD6GNlPC+T/aExmT5e3FUy+fxGzHRxnCazXTfBRVAQAr0GCh2YE25Ymp
 iOnt0fba+BPW7KPyMPXQHnMrqOTilWJErIQesaN7QObJ3VTdFVxVx93FDjP8irrv2FWb
 roRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769491079; x=1770095879;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gU47pROJlf30vx7cUz6NgZ8ND/evzCsZCahJ4DIhgGw=;
 b=gsc3TID8xu3LSjA53E0gHwzPxnkkH2NjiVy4lcphayWW0lKVnt2bvWdWQHBknQRnk9
 4F2lS0OaKt/nCOjcmbG9Gi45Vp3PnbuILM9ackFkUrqZklAhGNMiBP0liZDJX2aDG3VD
 moOvDtMz15ne9gjjuEHo6rDdnZ75OkmeMLNpRphQL58QPpJYQ+cp1P0WiUH6Cenc1yMr
 kXZkLxUJKOnT9VfhKipgJ9LinkPhywb0miSj47tyj6JUTNcH92U4JDXzW2DvV6ZRTrF8
 m4bL08W81Irr7/3pxCpFINqWcCwnlBkDP4i5yXY8PkSFTMVb4QIpkhPe9lyGonFTENiI
 f4Jw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX4GXgkmSTwoE+1+AIrh1+hxFs7H8Udx9+H0S77LedF3hfXkKqtrTFDZEudmOeskYQuz/dICtRn2FhP@nongnu.org
X-Gm-Message-State: AOJu0Yyu6zC8xxBXqYEfGHwDK0swM8+eGoE/UrxB//7U2mAW29IL30tM
 A4Hv8FPhoibwOYxIuJCIYWmEQUWPo72727qMGP/78OfjyzdnbfKiDNFpRAOEl+cSKnR7ll2k/zq
 DyaXSFISadsq1DA3Dyol8dJJ7sHXakI1jCLd2rXV5TBgdclIs1uR/2A2w
X-Gm-Gg: AZuq6aI9QA6PuEYQVbLH2MUnrb7qvklFHNkVbQwtOQMi4W4d4rOrq2pRXOIO8Wwc2ni
 yFR1N6agHoq3UhpY5jDPJweLJosPeCy2NqSNnpcESBzdCMzrBU/eniTMwzolt7XhIFQxIHsorMU
 783V1VKKdwCD/OHSb23viDjZMgFqJEcXBx44fTTDcgKvduLfJzGKPFpgBEsntmfckb8veqZkB1/
 p2kEjiorg4JoVPt4/me79D/4Ji5RZjJWWpK4w03kLhtDFJijf0aVCZls/LskgTrPSJzeXZBcykO
 4aHx7kDcU7MqoxrvKJlIl817fG8h0UJXedbKOlfXzQyap19u9UT5ep3/48nUQBZmC+KjQ4RU3Cr
 8QCz2V/WszToUqbAJ8TXA0T2SNeHHjvJ/qsoH975MvA==
X-Received: by 2002:a17:90a:f950:b0:340:f05a:3ed3 with SMTP id
 98e67ed59e1d1-353fed75832mr957740a91.17.1769491079230; 
 Mon, 26 Jan 2026 21:17:59 -0800 (PST)
X-Received: by 2002:a17:90a:f950:b0:340:f05a:3ed3 with SMTP id
 98e67ed59e1d1-353fed75832mr957706a91.17.1769491078795; 
 Mon, 26 Jan 2026 21:17:58 -0800 (PST)
Received: from rhel9-box.lan ([122.163.48.79])
 by smtp.googlemail.com with ESMTPSA id
 98e67ed59e1d1-353f6230d5dsm1110925a91.17.2026.01.26.21.17.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jan 2026 21:17:58 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: Bernhard Beschow <shentey@gmail.com>
Cc: kraxel@redhat.com, Ani Sinha <anisinha@redhat.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH v3 28/33] ppc/openpic: create a new openpic device and
 reattach mem region on coco reset
Date: Tue, 27 Jan 2026 10:45:56 +0530
Message-ID: <20260127051612.219475-29-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260127051612.219475-1-anisinha@redhat.com>
References: <20260127051612.219475-1-anisinha@redhat.com>
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


