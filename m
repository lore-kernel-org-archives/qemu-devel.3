Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43025D58E7E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 08:50:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwyxz-0003iD-4g; Mon, 02 Mar 2026 03:49:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwywc-0002zZ-VC
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:48:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwywb-0002BW-7X
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:48:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772441280;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+pnyvYKCMWBnf4Ion4Ex8wWRWvcioehCx+DQUAzs2v8=;
 b=P8bAQ74H6vDYxn+aPQUSSTgca2t9UVnHJelRR06N8HdidxtpvUqZEWht8b1obw1d/+HfNR
 SDNAYEPOFlC5MlYDl9hzT1gxtXe0AR3EcTUl78yJek2ghzKKiwRtloxHJztctvsNtJ/jlg
 U9/h3UvE5GzGW6z7Ojw8ugIP4+BVml4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-319-wivVyqvfMm-P_u_Qjc9UXw-1; Mon, 02 Mar 2026 03:47:59 -0500
X-MC-Unique: wivVyqvfMm-P_u_Qjc9UXw-1
X-Mimecast-MFC-AGG-ID: wivVyqvfMm-P_u_Qjc9UXw_1772441278
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-48379489438so39512645e9.2
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 00:47:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772441277; x=1773046077; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+pnyvYKCMWBnf4Ion4Ex8wWRWvcioehCx+DQUAzs2v8=;
 b=DiQ7gueWdG2pJGaMtO7gkwu5DpFi2S/5fk2aCOsG/OOM2duUeSj/G3UNUJ2HdHjLle
 AIDyI5gsN3zQ/YA2BO6gJwRNQDvHZlIcdqNwbv9lMK7P6fpqVh28aVY9HWq6ih/TtXl0
 QJvIYLlfUGJJhRq6qPadQaLfhJG38OGFtJuQ3wT10JDekBlaOLsQY6D5Q3EXh5TpP60w
 hCaia+xTz0HOjQlZdYpDCDmsYhsYrRgFIt7GCye2ofg/E/9OPolaqkspAl7+paZTHGvm
 zFQBXKTvgXD6nMs+mxZiiCFKUp2Vsm1561XAxEGpQpPtWgaTPu8NrtVh+0QjLTLIBvWj
 HAAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772441277; x=1773046077;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+pnyvYKCMWBnf4Ion4Ex8wWRWvcioehCx+DQUAzs2v8=;
 b=H8LaTvLxlonGFYsD0+USv8G+g6xWXXHsedTJJl4B6u+HAQnkStGjtGadCaO33XYW7k
 5JMXU66gRDMNznziTWleBTWMgjfIBsuKNgGybNefK437s+/VUIOKA4AVqBTYXKHEKruv
 tezitvVy0ljf9hqlX5DtZuYyliL5uZ6sxTEHuDod6qMCzgtyqCOklCJITKSYWT3hA8O8
 ULMcURBzNZ57pQV6PtS3GiqHIkpYDzrnDdul9C+AhRPM0TeM8lrZdvKny8+T6SH5uumh
 wfExfUD2KY6PgaqLEbO5tmTcZSWO04Ms9Gq63VgMrVJOb0yS5q17O2gjRpQSFHJ9wb+y
 X/yg==
X-Gm-Message-State: AOJu0YxKhS+CcxYz8mJMMutBDs06WCYguhrY8IY1hT6Ea0vDbnxj2+PG
 IzFPWFubNc98gCVOtgkA2zNDG+4/GVNPXbAq/FWNkMhcsVuCz9bHyRgKYUb5gw+YwR/1rqOou6I
 D6P5u+8VVpkZcXMalGeT8avdbQ46Bb9qBsQxtUQnAcU0iQtyuCc35y4Wv/qrg6sQ3ePRosOTCKA
 PvbAuIUEYAGcjh5EYWBqA3esJDm3lv4IPVY4A/+Hnr
X-Gm-Gg: ATEYQzx8ZdeYZFlA/4/63bz2E4afpYTDvXO+pEPi1jOfKCVlGCR1wDiXIsMxEoXtrzD
 aP8LE+pJV5l6LOy5OJkoHw1Wj5zjWAQ4OlpSc4cEc0S0qiTn5ARZgeaYivInFh5frWeFuTKVteg
 OQu1v5b1oiuR4MXA0VkUFQFoZSxjHIHfjf9EZR+/THGReHeLhLiqsQRJV2clm5xlubm0inJh3uW
 CIcxTtYO2/EVGBpFZCpGqVoBdIgon/psUfcM4NJrfnOv7w6c85mPfahA114SSQ0TD3M6MN1NVs3
 BSbUH80hxwn43+QG82FW6i2IhmJ8WgHa2dgr9Am9wS2iKMlPtuSVDEdxDi0uv0BZGT5tAMo6Kyz
 Aoe3reEJgoG2JwWP8W6MXAKicEv9qxxDQ/YqGsOK0JiSw5kGAaSui4yYk3cAPa3/U4BYqPVMc3W
 zcPIrU8jP1o1/9p8tNR+s6/oC3eqI=
X-Received: by 2002:a05:600c:c04b:10b0:483:79a6:e7e1 with SMTP id
 5b1f17b1804b1-483c9ba7e28mr143442945e9.7.1772441277156; 
 Mon, 02 Mar 2026 00:47:57 -0800 (PST)
X-Received: by 2002:a05:600c:c04b:10b0:483:79a6:e7e1 with SMTP id
 5b1f17b1804b1-483c9ba7e28mr143442545e9.7.1772441276639; 
 Mon, 02 Mar 2026 00:47:56 -0800 (PST)
Received: from [192.168.10.48] ([151.95.144.138])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483c3b89c99sm270202855e9.15.2026.03.02.00.47.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2026 00:47:55 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>,
	Bernhard Beschow <shentey@gmail.com>
Subject: [PULL 070/102] ppc/openpic: create a new openpic device and reattach
 mem region on coco reset
Date: Mon,  2 Mar 2026 09:47:16 +0100
Message-ID: <20260302084749.474955-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260302084338.473368-1-pbonzini@redhat.com>
References: <20260302084338.473368-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.012, RCVD_IN_VALIDITY_RPBL_BLOCKED=1.188,
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

From: Ani Sinha <anisinha@redhat.com>

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
Link: https://lore.kernel.org/r/20260225035000.385950-30-anisinha@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/intc/openpic_kvm.c | 112 +++++++++++++++++++++++++++++++++---------
 1 file changed, 88 insertions(+), 24 deletions(-)

diff --git a/hw/intc/openpic_kvm.c b/hw/intc/openpic_kvm.c
index fbf0bdbe071..b099da20eb9 100644
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
2.53.0


