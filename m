Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33789EDF04A
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 06:29:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqQBL-0001xW-7U; Thu, 12 Feb 2026 01:28:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vqQAf-0000Wj-K2
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 01:27:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vqQAe-0005N8-42
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 01:27:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770877642;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ampkMXpvZM0Uh9Dio1wYKLx68wPyoO/FMFpvVez+X64=;
 b=EAHInAtMfLUqLNU60tFKgQkAMG7PEI1+kHgdqzg4vJs0WtSEAh4lECZoHMb9eePqhcS3KO
 JbJnek5B2oT4Y97JqNgD5uD3xZrKcOhyIXD7Snz4rvSzrxkATMsPZam9dSHlT8r915PAlL
 z4lYGZ53N9oWwUsq5xky8Wunhbj4JYs=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-294-ul1nktETPOCk9CrqhzWFfg-1; Thu, 12 Feb 2026 01:27:21 -0500
X-MC-Unique: ul1nktETPOCk9CrqhzWFfg-1
X-Mimecast-MFC-AGG-ID: ul1nktETPOCk9CrqhzWFfg_1770877640
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-354bc535546so5947833a91.3
 for <qemu-devel@nongnu.org>; Wed, 11 Feb 2026 22:27:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770877640; x=1771482440; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ampkMXpvZM0Uh9Dio1wYKLx68wPyoO/FMFpvVez+X64=;
 b=kUnNFuxZdVe+YcJhZAmfxiabz+UT5yea43Dk47tw9n8F0SglIquhsREk/Dc8w53/ti
 yYDl53usb3k5THgMNxgzEGQ6Yh7snLDQGrkp1gzY5Dy/V7V+s0T4d8NV1QPJrAcAxUUT
 /vQlwAIfC9aodDl7THLPmmHCcHwO+V1f9rUxQJl/3KX0sEkXhlQ2TGCcXrSvFu3AhCxl
 bVClEBlwM7BKrxTqdlK0OLpaDHMKdvsP+S7VYs4FdCpruIxVOCKMiOhyFawHVrv79mAz
 c8IaiB2MXSJcMqyPYHkrib3/PkRba0XAfCEmqVJEUPtm2uangNx7DDuoDdCpkd5L/Ayp
 UgBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770877640; x=1771482440;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ampkMXpvZM0Uh9Dio1wYKLx68wPyoO/FMFpvVez+X64=;
 b=JUqH7vI6mfno8WP43u9x9h9E7bNluu4hpxKG6T5ixPVBbFgVT+b25zs+8ajjvm2Opv
 GOxNvmbbzH0xnfWojNYo/rmv2osginqNiLE9/YP409nnUapaz3j39tLF3mIKfKM1Fe85
 dE59Ky8ZQOrq0BP2BIPYKzY7i48t30W+pBdoKZkAMPM+Ogqd7lQtcyhKUPkUjQakt3A9
 E8cFVomdEjej/sCgcNXRmOfYSh+RQ5G2vEGHyWLJe6Tho4XfY3JfdZhbX/KYZUW5MZHA
 j8KLRUuVxu9eYGHgibS+Ej+H9HnufI8antud3S646G/frBfa0nYzJ4wbnhleMdJrmr5z
 JKDg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXV/Y0x7FzSNwB5o9axdnSZeoHukKvLdo35+JLWHAUw7L9WkbZrH1pQqnMJCWclNmtr5lFoTmhkyabQ@nongnu.org
X-Gm-Message-State: AOJu0YzSo4xnP+V1mQzS13US91w7fkL8c/kEKlLrLsu/K5rhW8vXLZJT
 wREB4O/EuK+63qQ/x9qhmNGHrad/ZHJAYoLCthGEMStUs6p9KQB2bhL/FfrEMOQmcsTe8ZGhmTa
 A+ZCr6QdXSwGz4Ik560HadgJwad/afSBuDn8ejqspH/wbBZBYeq8BVs/7
X-Gm-Gg: AZuq6aIQElMcD7LFvIbK+piTart4rWtBcuiiBuj8g8p+rbJUQiK/oJ2qCQ19px2L60g
 ya1R97DiXIE4vFuTGvOUQd5FQLpfO3I+Krte9Yl602ssAh446CX09SzA0dxKh9gWI3yqOdEOfCF
 4zS0pIhI8IfudgVziipagd1+MiZ9psJCHC5zIjfFly0ioFiVh2szcCB3WgfQRIMSP2j5RJFDQI1
 ushv8kggzrXmPXKfGbv9GXeX4RVnfOUYgdlCjmx7ugYfYYjcYinHuaK89pYyFZkZQ9VGl++vCjl
 QY5xSDjqiYUyuRg6tVnLYJPOjCxYSaxlPkR24wDnZ+1xt+R0Dy+01jtYTPkTcbMw0iMUwSuRERg
 XN4nzwGQR9jQHS9hMt+zeolR9bG5up2BxgjZK4XcRFTxWzcPJQzFgFSk=
X-Received: by 2002:a17:90b:520e:b0:341:8491:472a with SMTP id
 98e67ed59e1d1-3568f2e017fmr1860998a91.4.1770877639783; 
 Wed, 11 Feb 2026 22:27:19 -0800 (PST)
X-Received: by 2002:a17:90b:520e:b0:341:8491:472a with SMTP id
 98e67ed59e1d1-3568f2e017fmr1860982a91.4.1770877639375; 
 Wed, 11 Feb 2026 22:27:19 -0800 (PST)
Received: from rhel9-box.lan ([122.164.27.113])
 by smtp.googlemail.com with ESMTPSA id
 98e67ed59e1d1-3567e7d95d8sm4894122a91.2.2026.02.11.22.27.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Feb 2026 22:27:19 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Cc: kraxel@redhat.com, Ani Sinha <anisinha@redhat.com>, qemu-devel@nongnu.org
Subject: [PATCH v4 29/31] kvm/clock: add support for confidential guest reset
Date: Thu, 12 Feb 2026 11:55:13 +0530
Message-ID: <20260212062522.99565-30-anisinha@redhat.com>
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

Confidential guests change the KVM VM file descriptor upon reset and also create
new VCPU file descriptors against the new KVM VM file descriptor. We need to
save the clock state from kvm before KVM VM file descriptor changes and restore
it after. Also after VCPU file descriptors changed, we must call
KVM_KVMCLOCK_CTRL on the VCPU file descriptor to inform KVM that the VCPU is
in paused state.

Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 hw/i386/kvm/clock.c | 59 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/hw/i386/kvm/clock.c b/hw/i386/kvm/clock.c
index aba6842a22..10d34254f0 100644
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
2.42.0


