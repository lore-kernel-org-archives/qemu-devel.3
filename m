Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA2DBD25937
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 05:21:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkbTf-0001it-Cb; Tue, 27 Jan 2026 00:18:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vkbSv-0000Ut-Jh
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 00:18:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vkbSu-0000Gx-5l
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 00:18:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769491091;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ampkMXpvZM0Uh9Dio1wYKLx68wPyoO/FMFpvVez+X64=;
 b=U13JmB55MUIH/uXmETuzFGm/00rQ90MHZ5wIxhpflumtoz1XFX3yTIy92fQckAH4vepe4u
 mg5x6tr/GZ+Jgc+ozN0gQh5GK39LXOKGz0z3E2tg2yjmuksHIPThm8F7CP8hOk+5ZXVWcl
 lPojOjOwZHk055VpX8x1NJ3I2YNQRAg=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-f4FUNuPHN9efHIyW_eSVNg-1; Tue, 27 Jan 2026 00:18:09 -0500
X-MC-Unique: f4FUNuPHN9efHIyW_eSVNg-1
X-Mimecast-MFC-AGG-ID: f4FUNuPHN9efHIyW_eSVNg_1769491088
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-34c93f0849dso4945604a91.1
 for <qemu-devel@nongnu.org>; Mon, 26 Jan 2026 21:18:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1769491088; x=1770095888; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ampkMXpvZM0Uh9Dio1wYKLx68wPyoO/FMFpvVez+X64=;
 b=S3otqL6fDxErlRNspkVeqaPT0vx437txvFFo3gQoE29BBoxffbBP2xcr6XJYs9eadd
 LH3hhqitAhhLHMrxDmZ3hCnRrqoGM1/Vc0YxtOBBGmb74wRi0gaFjBGKUPye5iCrTxqJ
 7KYP15zplvJd5Qci8ev4E384J9qBqLpmQRYtShC/FrLy+rbPL1pOnH9ip7txZlg57UYt
 Tk0c8QkqGhYnXz5Lf0EFwTfO0mrDxhFHcvlnm8OuA8oPJGb26Wp5NKspChKHV6i1LbOp
 0Tq/ZJLoxPD2QeBY8qtwD90WPeEolIdDwTJKt59YSupJeJxcWqu98Zn35FXP1yRDUFLF
 V4aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769491088; x=1770095888;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ampkMXpvZM0Uh9Dio1wYKLx68wPyoO/FMFpvVez+X64=;
 b=NKMD3S8zL6WbVdW+1CT7kY6C8pfbM4oOS6opB8HZZ3GBgK/Nt8yuTxHYGNf57Ta1DR
 jDsuSmzenHPtBT5LFA1xlqriGxMDNPqmif8PzU8pVITrqMwWha0LxGUqYt8c5+IZa4yi
 Dkn0cOPqyHdguvX35l0eL1aopz0MDnUqGD3ghOy/ohhDq7finpmeRru62q+2aCMYuHfb
 QsbFibhnexBbO5w6kJ4ut4hefFUIvBfta4/rH32cCG/H3uFlS/zrNTelfY6tEhtKQ0Kz
 paaHE//YaiDAsv14KbMPhTkuQo+BRThxQKpo1Mn9kfk6rnZIMSS6v8HLwLaWJCXwefxi
 gXIg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUVsvw788UJj8mh1CuCEwdMtaURgIJZBF8Q1dRCTmVPTJSscShSyvAcpUGE1yzaLewzklQKGUg1044j@nongnu.org
X-Gm-Message-State: AOJu0Yzo96HNB21ksBhRkouLrz3stDOBrv1Qlx4NsVmGKM2zHLZbIaE1
 XY6v4bLKnOB1c0ZDll5mS2+GvxZVo+2rC8jIqWnhSq7aSW+sXJg2Nd/OjrANBSdvr/IdHshEwJh
 kkvyZeCsvuIzvIqPeW4frArkG/FzQpTPAMueg20E4ynz63aQFw6EvNtUu
X-Gm-Gg: AZuq6aKSh1a5e0fTTCCtxsZ4M5O0uSvyVC2B4yGhP+LFny/uCrbQB4xSgDLsOXzB2Ic
 rnCb0z3gy2xtSu+Tmj4exgFC47qUsRQ5EwZCymDd7LRsxnauku6ie9m9jTnh0Sk2Yy+y198+vJo
 an/indnmqOxIsDHAiVxfVQFc0qnNYEhSVKKRCzCGC6sJ3nDCIhPxg9ciad80L1nD9jEFB7kkRRu
 IteI1jmWX3qwp7xzXaxZ0l0ciilFl+0K0fxIU7YNbdm0IWfV25OJDQcPdlDVY4gGqnkg248Zku1
 IEUb45BVWbftJ7Ih4PXxL5XwswGbYeUf77iOoGXOPcPgshfRXNqB7QpY7+dXGTiGxrWmq1uOFAz
 7iP77o+3KbfcDoWgYRlNP/dPtmhDXdmZfvUBZQBwtgA==
X-Received: by 2002:a17:90b:37ce:b0:353:2972:74a4 with SMTP id
 98e67ed59e1d1-353ffaa4138mr479390a91.13.1769491088247; 
 Mon, 26 Jan 2026 21:18:08 -0800 (PST)
X-Received: by 2002:a17:90b:37ce:b0:353:2972:74a4 with SMTP id
 98e67ed59e1d1-353ffaa4138mr479361a91.13.1769491087913; 
 Mon, 26 Jan 2026 21:18:07 -0800 (PST)
Received: from rhel9-box.lan ([122.163.48.79])
 by smtp.googlemail.com with ESMTPSA id
 98e67ed59e1d1-353f6230d5dsm1110925a91.17.2026.01.26.21.18.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jan 2026 21:18:07 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: kraxel@redhat.com, Ani Sinha <anisinha@redhat.com>, qemu-devel@nongnu.org
Subject: [PATCH v3 31/33] kvm/clock: add support for confidential guest reset
Date: Tue, 27 Jan 2026 10:45:59 +0530
Message-ID: <20260127051612.219475-32-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260127051612.219475-1-anisinha@redhat.com>
References: <20260127051612.219475-1-anisinha@redhat.com>
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


