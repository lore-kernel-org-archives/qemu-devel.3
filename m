Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDB2AD49236
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Dec 2025 15:06:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vU4iB-00031z-7C; Fri, 12 Dec 2025 10:05:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vU4i6-0002el-9x
 for qemu-devel@nongnu.org; Fri, 12 Dec 2025 10:05:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vU4i4-00066z-JI
 for qemu-devel@nongnu.org; Fri, 12 Dec 2025 10:05:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765551931;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mS/vx07yZORkzPU1XCvWFJrvu5SKrWNQ/OXc6sVUDww=;
 b=ETLWRRJ+GtRD0zzo2XwKmB9NTtMFOkPUr7RI3RtwninZenHCVYqciQapPjnXsGNP/sSEZu
 Kpx2qJXL8JKBZ10mi5kDjgbP9k6qufItADF/3gzurjDwSg4EjVbr8hV0LOiIxJq3dDkdtM
 N74Bdm7l//ls2zHV89Vhuq9Ow1vwj1U=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-99-RjGO_f2PPp64uyWNfe3NdQ-1; Fri, 12 Dec 2025 10:05:30 -0500
X-MC-Unique: RjGO_f2PPp64uyWNfe3NdQ-1
X-Mimecast-MFC-AGG-ID: RjGO_f2PPp64uyWNfe3NdQ_1765551929
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2982b47ce35so15039865ad.2
 for <qemu-devel@nongnu.org>; Fri, 12 Dec 2025 07:05:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765551929; x=1766156729; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mS/vx07yZORkzPU1XCvWFJrvu5SKrWNQ/OXc6sVUDww=;
 b=fVsxd5NJqmTWzuEDSkMifB8Ly+cDidkWpKyH8uGQCgmppvGL9RoDO7mm4eRhNQzzo1
 ZqkmVAf+cNKklRxcZzRH57HJ3BqoDbOVsSqPJGDykGcDzmNyH49sVrmqSBU30lczVaaX
 Y9B4Xi0OLN4b3gx3xXDe3g2qV3Ufx2Q671zcRiMJcIMXQJkyHVZHxsbn2G5168AjtH71
 ZcvRLDNu/tmtsEnqS7v8VOYsrtVFUEu1LcBLdxGFDucdUo9izaGk9ZuqU65UtUXwWn3p
 Zosh3SnTESQcnyZkiiRUl59pGBnsk+wspULMD4+cGbzVf4JIJ/uZONfRV1dZP+vcWtEm
 FimA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765551929; x=1766156729;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mS/vx07yZORkzPU1XCvWFJrvu5SKrWNQ/OXc6sVUDww=;
 b=ndO2Kj77+CmGc9g7P5RK1v9pGFt3PWImfvChdwQ36uIGkmL+FVN6I5PZ3+5OnFfBbV
 jYYHbSRjvxwwtMZgUhyQoP0TA9brRoPKfMP8onW7Ui7A1sif9e4/etBeIV9+FV8YWA9Q
 nqHRcAY78UYNGNeESCpfYJTBYCaCManEl1JnUkd7exsf8DyrWymnbk+e+NpLi35e5KgL
 NIkfHoShqwZvXOl8TzLwBQ72am8MFWRrWGnIlpdJGttD99XgN8pV6UOn4/xHKh6D47FD
 1BrQhgKb/yRYsTbHFspANQPNZnkKW3tUsU1KbgmpzBwxzLh5yWkk8jDBSR6gxhYHHU3N
 yihw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUuXly+bSLaaPPYuvAGa+Xk4DKgnz3OGEUbPn89MvUu58E/B1mGiIHwihQ6PO+zpuEmhd5QiFWdsp3Z@nongnu.org
X-Gm-Message-State: AOJu0YwM7MgUTzKmJtmgmC/BRJYOhT/Qn0Owjcptapqj6iRoEP1ipcVx
 w74pM7Z/6mO3UxJhuA7Wu2nxDucqhNJ1d2HPL08kSprHylR6hjfLASVdlAwm7zpd/n0dq8i+LgK
 WpJR9BObmjaTdG+H6E5QuQZxicwnx4F5AweKbnXgrhe+49BPmj31JUorq
X-Gm-Gg: AY/fxX5yINSDj3D7R076mYs9D0sl5sxqtLlCeNHjGXhDTVNHahFh0PhamzK7jWGCYOd
 PGuOmmG/i8IIH170o3MHSZNxjcHybS6ywdvKWbO0V0RLhP3fEqxoSXWMQkIBiYjsSQDEf/Izwr9
 6ANZvhoLsdKUlavfalyxYljDD+qr0VvoM3keoC3CTTjCpXLT6k7lcnduOu/gSyLPMr1TuC9K3h0
 wIRnMu3XUnIv9ePSJgIES2driiV/Sb12qtLiOVIGePXinjSjAJoOSs7rpxE7ejIm8XqE4k6BMGn
 zSFKYUN5sctpix6/K666vKKIJOIDmbnICul+bK2jba5uPeVCnlpZtk19PIq84Cu0nyxUys3n5/v
 3pc1n7UwmEsLYaXmHDtr2tELApIkJdnZzXMRcRusaKio=
X-Received: by 2002:a17:903:1251:b0:294:f6e2:cea1 with SMTP id
 d9443c01a7336-29f2403ae65mr20202425ad.38.1765551928950; 
 Fri, 12 Dec 2025 07:05:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEX6h0uUVyeG0IaMQdhmEhCDa0PAkpPXxzaWui+Wd3A9zo5hJ1HkYVIoILmoQBHwBBfoOY0Xw==
X-Received: by 2002:a17:903:1251:b0:294:f6e2:cea1 with SMTP id
 d9443c01a7336-29f2403ae65mr20202145ad.38.1765551928451; 
 Fri, 12 Dec 2025 07:05:28 -0800 (PST)
Received: from rhel9-box.lan ([122.172.173.62])
 by smtp.googlemail.com with ESMTPSA id
 d9443c01a7336-29ee9d38ad1sm57046655ad.29.2025.12.12.07.05.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Dec 2025 07:05:28 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Cc: vkuznets@redhat.com, kraxel@redhat.com, qemu-devel@nongnu.org,
 Ani Sinha <anisinha@redhat.com>
Subject: [PATCH v1 20/28] kvm/i8254: add support for confidential guest reset
Date: Fri, 12 Dec 2025 20:33:48 +0530
Message-ID: <20251212150359.548787-21-anisinha@redhat.com>
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

A confidential guest reset involves closing the old virtual machine KVM file
descriptor and opening a new one. Since its a new KVM fd, PIT needs to be
reinitialized again. This is done with the help of a notifier which is invoked
upon KVM vm file desciptor change during confidential guest reset process.

Some code refactoring is performed so that common operations for init and reset
are moved into a helper function.

Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 hw/i386/kvm/i8254.c | 84 ++++++++++++++++++++++++++++-----------------
 1 file changed, 53 insertions(+), 31 deletions(-)

diff --git a/hw/i386/kvm/i8254.c b/hw/i386/kvm/i8254.c
index 14b78f30a8..0b741464d9 100644
--- a/hw/i386/kvm/i8254.c
+++ b/hw/i386/kvm/i8254.c
@@ -52,6 +52,8 @@ struct KVMPITState {
     LostTickPolicy lost_tick_policy;
     bool vm_stopped;
     int64_t kernel_clock_offset;
+
+    NotifierWithReturn kvmpit_vmfd_change_notifier;
 };
 
 struct KVMPITClass {
@@ -60,6 +62,43 @@ struct KVMPITClass {
     DeviceRealize parent_realize;
 };
 
+static void do_pit_initialize(KVMPITState *s, Error **errp)
+{
+    struct kvm_pit_config config = {
+        .flags = 0,
+    };
+    int ret;
+
+    ret = kvm_vm_ioctl(kvm_state, KVM_CREATE_PIT2, &config);
+    if (ret < 0) {
+        error_setg(errp, "Create kernel PIC irqchip failed: %s",
+                   strerror(-ret));
+        return;
+    }
+    switch (s->lost_tick_policy) {
+    case LOST_TICK_POLICY_DELAY:
+        break; /* enabled by default */
+    case LOST_TICK_POLICY_DISCARD:
+        if (kvm_check_extension(kvm_state, KVM_CAP_REINJECT_CONTROL)) {
+            struct kvm_reinject_control control = { .pit_reinject = 0 };
+
+            ret = kvm_vm_ioctl(kvm_state, KVM_REINJECT_CONTROL, &control);
+            if (ret < 0) {
+                error_setg(errp,
+                           "Can't disable in-kernel PIT reinjection: %s",
+                           strerror(-ret));
+                return;
+            }
+        }
+        break;
+    default:
+        error_setg(errp, "Lost tick policy not supported.");
+        return;
+    }
+
+    return;
+}
+
 static void kvm_pit_update_clock_offset(KVMPITState *s)
 {
     int64_t offset, clock_offset;
@@ -166,6 +205,16 @@ static void kvm_pit_put(PITCommonState *pit)
     }
 }
 
+static int kvmpit_post_vmfd_change(NotifierWithReturn *notifier,
+                                   void *data, Error** errp)
+{
+    KVMPITState *s = container_of(notifier, KVMPITState,
+                                  kvmpit_vmfd_change_notifier);
+
+    do_pit_initialize(s, errp);
+    return 0;
+}
+
 static void kvm_pit_set_gate(PITCommonState *s, PITChannelState *sc, int val)
 {
     kvm_pit_get(s);
@@ -241,49 +290,22 @@ static void kvm_pit_realizefn(DeviceState *dev, Error **errp)
     PITCommonState *pit = PIT_COMMON(dev);
     KVMPITClass *kpc = KVM_PIT_GET_CLASS(dev);
     KVMPITState *s = KVM_PIT(pit);
-    struct kvm_pit_config config = {
-        .flags = 0,
-    };
-    int ret;
 
     if (!kvm_check_extension(kvm_state, KVM_CAP_PIT_STATE2) ||
         !kvm_check_extension(kvm_state, KVM_CAP_PIT2)) {
         error_setg(errp, "In-kernel PIT not available");
     }
 
-    ret = kvm_vm_ioctl(kvm_state, KVM_CREATE_PIT2, &config);
-    if (ret < 0) {
-        error_setg(errp, "Create kernel PIC irqchip failed: %s",
-                   strerror(-ret));
-        return;
-    }
-    switch (s->lost_tick_policy) {
-    case LOST_TICK_POLICY_DELAY:
-        break; /* enabled by default */
-    case LOST_TICK_POLICY_DISCARD:
-        if (kvm_check_extension(kvm_state, KVM_CAP_REINJECT_CONTROL)) {
-            struct kvm_reinject_control control = { .pit_reinject = 0 };
-
-            ret = kvm_vm_ioctl(kvm_state, KVM_REINJECT_CONTROL, &control);
-            if (ret < 0) {
-                error_setg(errp,
-                           "Can't disable in-kernel PIT reinjection: %s",
-                           strerror(-ret));
-                return;
-            }
-        }
-        break;
-    default:
-        error_setg(errp, "Lost tick policy not supported.");
-        return;
-    }
-
+    do_pit_initialize(s, errp);
     memory_region_init_io(&pit->ioports, OBJECT(dev), NULL, NULL, "kvm-pit", 4);
 
     qdev_init_gpio_in(dev, kvm_pit_irq_control, 1);
 
     qemu_add_vm_change_state_handler(kvm_pit_vm_state_change, s);
 
+    s->kvmpit_vmfd_change_notifier.notify = kvmpit_post_vmfd_change;
+    kvm_vmfd_add_change_notifier(&s->kvmpit_vmfd_change_notifier);
+
     kpc->parent_realize(dev, errp);
 }
 
-- 
2.42.0


