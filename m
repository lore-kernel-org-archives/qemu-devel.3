Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0695D58E7E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 08:52:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwyxd-0003S1-Dg; Mon, 02 Mar 2026 03:49:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwywm-00036F-AL
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:48:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwywh-0002C4-DM
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:48:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772441286;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lf9ln4fDB+klofdkPzt3BwiZ9o6T3crhXTHxnN7KCrQ=;
 b=PT2FI+VYK+Hvu0He9fJOTkaSKiBUiQ7uPD4jfcqn2qgY40B8H384XBRAq1pq/P67DdEf+X
 ZqyYjWoPDiBT6sDPjRgraxkAiGXsc19PNeKiqME6TDl+FhJKr8UrAJbCo4Tk3B4DF8x1SM
 y4e75X3HjA1paD6fB9kYxgeVUeL0MOQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-103-WOQBHiACPryIV4WU0iXEvw-1; Mon, 02 Mar 2026 03:48:05 -0500
X-MC-Unique: WOQBHiACPryIV4WU0iXEvw-1
X-Mimecast-MFC-AGG-ID: WOQBHiACPryIV4WU0iXEvw_1772441284
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-483786a09b1so41313415e9.3
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 00:48:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772441283; x=1773046083; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lf9ln4fDB+klofdkPzt3BwiZ9o6T3crhXTHxnN7KCrQ=;
 b=ocJgi3arzWoVUUH2aVQR2BtAhndwv3wdgoWumXY9TPy5VJs7i+OpG4yfQ+CHqrzlHJ
 BNcanCPJyXCMxKzskUCw2+eF7gGkRJvBE9YPaCyqfoH7EsNfMrRvChq9Er5Jhu4ZI+06
 wpqix4OO7N1jR2A7lKi+ZIQiJZPRAMuWCqaFQgR/nw8s29Zs+PO8JEGbhm2Sff+7mWdY
 aEaS6IQ2cp7ZG9Av0+Dtk6Ak7ZkvGROgh4umJi/QYSboOjQ+6zmTvZcJcQUdjhBuHvLB
 GfJkrVIa6AJrkTbw0reAzdkhWpBGjN08CK8GZ3gTYz9c01kpaiU2Xt0gw9TajVp6FCS6
 ZK1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772441283; x=1773046083;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lf9ln4fDB+klofdkPzt3BwiZ9o6T3crhXTHxnN7KCrQ=;
 b=JPTbFJgzDFy7XILCzrfLoaL6hNxmlHLuuYpQVfSB2aMsrnvNX/ogCHy9J0jHpJLw2L
 0Cdudqd9SY0Cgdtp6JigiLqOWBZHOnk4HBm7R3UW5ZwdBJHnAEk2mz+8VcYI55v+56xX
 vARg/qWq2CmWgplv2lS8ysIejHvQA6mj+sHJLv+CTFmDkFB4cKCNFyMnW1Ma9MqQ2Qdn
 qhjTZ2hZQ4ofB3aJKXB4GfZX1QuKe1Gogtf+DXP55EIGsleXKW1bn3Pj762xBFqF4D+b
 RD3IYQbhwmzXkl8prIv1q9XM35yHdBXv30DzlELHm99fFXVr9nz5tYIpMakVjKMqpLbc
 mLFA==
X-Gm-Message-State: AOJu0Yy6YwRU0hUlDy42WiSvvgtiuksEY3qOfqHtG9kHAAxa/VBMxbeS
 Yl/EkfGzRgC8LCIhob+9bfboTmPc0pUHVJTuVXvjZEO4A/Bgkmie6yI1arX7Nr/Zfh4xHg1gsgf
 V3PiSQ8kmMU4tImLBESDP6TmsGGGIYqd4ljJ6o2V7KeH2azoIf+QNjDTaOPnqR3utSuLMl8qa43
 SX7eZDi+/46JbP9v9hN13minTS9ByxkMH5CuRpCfAM
X-Gm-Gg: ATEYQzxTLKrZEAl9cqrmbkpnL1/R97fWInvohMRAo5/AdqReuQ4fbQEaUk7h/61qqsf
 ADi9xlocv+QLPE9Yojwp5K9gKTy+vp+ASftWCpFOEemkLzUkhjz4ZMGze7zat1cV8W4byoiMcXe
 tnAGDPQZPpWG1AnzBYlH9mBg/++5mjJRU5LiqAOKpyPIHm2/gZ0I7/NL1sA8hDVqaeM/qyuK1zN
 8zVKVohJX/sMuJFMS/Ne8QKot1gz9JYYgeZVjQRkAAxhrQbBQr1Cx+8UwoQ2WrU5vWyMe+KJSqS
 9MSdrDqiXyouj1S+bKTqQck71Vq19T07fKcH9V5va3231cEJzEgJQIBp9EF8/XC5meC8oUHULC+
 pETC7uD+kVAX1Wqqzz5hAmnRzt2/U1vByUXdKaSrlAPTRLj7JgYXVfoebiZ4V24nwPwLllH86Za
 DDGwLDAXO3VxVYj0nQRUt50ju0rIg=
X-Received: by 2002:a05:600c:138d:b0:483:361b:deff with SMTP id
 5b1f17b1804b1-483c9bb2c10mr200511835e9.14.1772441283274; 
 Mon, 02 Mar 2026 00:48:03 -0800 (PST)
X-Received: by 2002:a05:600c:138d:b0:483:361b:deff with SMTP id
 5b1f17b1804b1-483c9bb2c10mr200511425e9.14.1772441282741; 
 Mon, 02 Mar 2026 00:48:02 -0800 (PST)
Received: from [192.168.10.48] ([151.95.144.138])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bfbb6d16sm181606995e9.5.2026.03.02.00.47.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2026 00:48:00 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>
Subject: [PULL 072/102] kvm/clock: add support for confidential guest reset
Date: Mon,  2 Mar 2026 09:47:18 +0100
Message-ID: <20260302084749.474955-6-pbonzini@redhat.com>
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

Confidential guests change the KVM VM file descriptor upon reset and also create
new VCPU file descriptors against the new KVM VM file descriptor. We need to
save the clock state from kvm before KVM VM file descriptor changes and restore
it after. Also after VCPU file descriptors changed, we must call
KVM_KVMCLOCK_CTRL on the VCPU file descriptor to inform KVM that the VCPU is
in paused state.

Signed-off-by: Ani Sinha <anisinha@redhat.com>
Link: https://lore.kernel.org/r/20260225035000.385950-32-anisinha@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/i386/kvm/clock.c | 59 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/hw/i386/kvm/clock.c b/hw/i386/kvm/clock.c
index aba6842a22c..10d34254f02 100644
--- a/hw/i386/kvm/clock.c
+++ b/hw/i386/kvm/clock.c
@@ -50,6 +50,9 @@ struct KVMClockState {
     /* whether the 'clock' value was obtained in a host with
      * reliable KVM_GET_CLOCK */
     bool clock_is_reliable;
+
+    NotifierWithReturn kvmclock_vcpufd_change_notifier;
+    NotifierWithReturn kvmclock_vmfd_change_notifier;
 };
 
 struct pvclock_vcpu_time_info {
@@ -63,6 +66,9 @@ struct pvclock_vcpu_time_info {
     uint8_t    pad[2];
 } __attribute__((__packed__)); /* 32 bytes */
 
+static int kvmclock_set_clock(NotifierWithReturn *notifier,
+                              void *data, Error** errp);
+
 static uint64_t kvmclock_current_nsec(KVMClockState *s)
 {
     CPUState *cpu = first_cpu;
@@ -219,6 +225,54 @@ static void kvmclock_vm_state_change(void *opaque, bool running,
     }
 }
 
+static int kvmclock_save_clock(NotifierWithReturn *notifier,
+                               void *data, Error** errp)
+{
+    if (!((VmfdChangeNotifier *)data)->pre) {
+        return 0;
+    }
+    KVMClockState *s = container_of(notifier, KVMClockState,
+                                    kvmclock_vmfd_change_notifier);
+    kvm_update_clock(s);
+    return 0;
+}
+
+static int kvmclock_set_clock(NotifierWithReturn *notifier,
+                              void *data, Error** errp)
+{
+    struct kvm_clock_data clock_data = {};
+    CPUState *cpu;
+    int ret;
+    KVMClockState *s = container_of(notifier, KVMClockState,
+                                    kvmclock_vcpufd_change_notifier);
+    int cap_clock_ctrl = kvm_check_extension(kvm_state, KVM_CAP_KVMCLOCK_CTRL);
+
+    if (!s->clock_is_reliable) {
+        uint64_t pvclock_via_mem = kvmclock_current_nsec(s);
+        /* saved clock value before vmfd change is not reliable */
+        if (pvclock_via_mem) {
+            s->clock = pvclock_via_mem;
+        }
+    }
+
+    clock_data.clock = s->clock;
+    ret = kvm_vm_ioctl(kvm_state, KVM_SET_CLOCK, &clock_data);
+    if (ret < 0) {
+        fprintf(stderr, "KVM_SET_CLOCK failed: %s\n", strerror(-ret));
+        abort();
+    }
+
+    if (!cap_clock_ctrl) {
+        return 0;
+    }
+    CPU_FOREACH(cpu) {
+        run_on_cpu(cpu, do_kvmclock_ctrl, RUN_ON_CPU_NULL);
+    }
+
+    return 0;
+}
+
+
 static void kvmclock_realize(DeviceState *dev, Error **errp)
 {
     KVMClockState *s = KVM_CLOCK(dev);
@@ -230,7 +284,12 @@ static void kvmclock_realize(DeviceState *dev, Error **errp)
 
     kvm_update_clock(s);
 
+    s->kvmclock_vcpufd_change_notifier.notify = kvmclock_set_clock;
+    s->kvmclock_vmfd_change_notifier.notify = kvmclock_save_clock;
+
     qemu_add_vm_change_state_handler(kvmclock_vm_state_change, s);
+    kvm_vcpufd_add_change_notifier(&s->kvmclock_vcpufd_change_notifier);
+    kvm_vmfd_add_change_notifier(&s->kvmclock_vmfd_change_notifier);
 }
 
 static bool kvmclock_clock_is_reliable_needed(void *opaque)
-- 
2.53.0


