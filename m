Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFB8CC9EC90
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 13:29:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfHw3-0006V4-W3; Mon, 12 Jan 2026 08:26:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vfHud-0004Wt-2O
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 08:24:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vfHua-0003u1-6X
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 08:24:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768224287;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R3yLZr09LM7NcHBXvWZBPJETGaPkzhIYY875mEyeZ3w=;
 b=GqV6KkozqJ6LOp3Wj46kwSz5T+Qa3QEYGQi8KRVmYyv0nNmvEYMrU7fKxXJyDLPg4+GEoD
 n3V2YbyvGAPOSPwzyjXxODUMHdPsDiDwo/w1LxBjCfg+5Fh/55N0rgOU3Bj5mDNO6xdH1N
 Ewm1OdcXkPJeIN5ucjtmrwUI/I5BzSI=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-5cN7QkOsNzmnKIvLlXICow-1; Mon, 12 Jan 2026 08:24:46 -0500
X-MC-Unique: 5cN7QkOsNzmnKIvLlXICow-1
X-Mimecast-MFC-AGG-ID: 5cN7QkOsNzmnKIvLlXICow_1768224285
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-81d9b88caf2so2205439b3a.1
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 05:24:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768224285; x=1768829085; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R3yLZr09LM7NcHBXvWZBPJETGaPkzhIYY875mEyeZ3w=;
 b=JIhw07sKRzcgWV+AATZ5DgGTWp90MKLapyjOSanSfNlpB2tbNWY2fDTVAb9VHZ41gq
 HdZ7K4op9APsw0FOWWOj1Sv1RthC/ppFPXdUwV8NXmn5ATraclH/uHdnkXlwyDd/4y+i
 d2aqPJHzSSqOQADETMs7Jqx2RJgZRRqoz4ZgdfrZmNpalxbVKgWCe2xpEfvwMrX2TKqB
 75javuspcILCMc6TWCay9Y+r/2ncPfmqGfgllNn4p8gs1Buj6wptxinRwwoNaAd3yPnD
 0ofsiYmDLA30AM8R+1Phaarph/GYv/cZwMeGC/LMAWfbWM89/xzpo7e5t/H/S0QIiGaO
 2F2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768224285; x=1768829085;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=R3yLZr09LM7NcHBXvWZBPJETGaPkzhIYY875mEyeZ3w=;
 b=BTmBO29Ve0QY209ah43k68T+n7YlslJHMGylMasxgBdndtPK0rNmVVKYEdiObSDuZo
 d9Ujxa+mGSMW9FfkLT6SKopktCEzRtD6DnXUlaFeRDSzU54w52SRorNlXj4WEVNiBbtZ
 JzYMwxT0e+OEuGC+6Di74nJofVWiDbIRwnyypYQmAAFheMqAsrWWaGp0dhL+ylUCr7xc
 rK/y3i1X7M+XRnJQUJkZp6XF/y7r96beGrLo4uxKmkVFBMa7CGLLbkKskF9/uH1LtMui
 uU3fEmRPfs+nopbH+iNqdcmDUkF0jxsmcpblHcLZCVr57S9WbttJVFBInApPScUDVnwz
 Z7Yw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUxi30udMyTZV8IbbIeBV78T/p5ZI/HjbBJH0cc2LIyytD697Z85lP6BAr2+a9mRi7hLEzvGtRxGrZw@nongnu.org
X-Gm-Message-State: AOJu0YwKO39XOSG1AHQ43yxecrD6A1vO7eG9RD+wNNd4dpLurEAJnCYG
 9BXzU+8lb2chLfKSwLZ+KcE3sb9AwIcCvA010rd84XuWm28JBP6sIT3KeZ6Wc5m45IubmaloYmm
 To1FFUWOIb1ompcHt+4W+vMDf9VIe8feqHlRVI0m3ECJ9dG9QGTcZyywv
X-Gm-Gg: AY/fxX74Ox3jHLqezq2dRaqAeiDI8rJigD2b1Ia2bNFMPtN372F32/9wEnbnWvY29Ii
 Nl5K3CeBUDI3jB4R9vlagVrk2+JNGxJ2pegJ1XttVZ4kJpO9lwtohzM1GkMm2YGJ0B+8c2/xQqW
 UG15NHCSENooDfqDMej1+YbFvgiGqTjIKh3oma5mjJM4//ZiIkZK9iI3K3OWYKN+cRzPW/NORds
 wP0Zv2yjtuSJ2Pgru7FQRXhMBPt+tRstJrotokrBOt7fl2VPxspLVZZFxD3mlwOLMbkHxTzrkyD
 7m36OdhqyVYvqXMiAVhyzXaweQB04xf7IBwV3O0G5L9eAE1lmPDdIdrJ7zejZGfuw3u6y62gp5q
 SZ+41zFmWDQcQQG5KkK6vhk4J7xIoi8R2eIk9j/ZwNok=
X-Received: by 2002:a05:6a21:6d81:b0:35f:5896:85a4 with SMTP id
 adf61e73a8af0-3898f8f4941mr16340406637.5.1768224285046; 
 Mon, 12 Jan 2026 05:24:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IENZVaQihKztvKwVH4oiegG/ElvAOEgRUUxrkglVrWtZMNggg7a3/AjWI6vJu3QeTLgEewAGA==
X-Received: by 2002:a05:6a21:6d81:b0:35f:5896:85a4 with SMTP id
 adf61e73a8af0-3898f8f4941mr16340385637.5.1768224284679; 
 Mon, 12 Jan 2026 05:24:44 -0800 (PST)
Received: from rhel9-box.lan ([110.227.88.119])
 by smtp.googlemail.com with ESMTPSA id
 41be03b00d2f7-c4cc05cd87asm17544771a12.15.2026.01.12.05.24.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Jan 2026 05:24:44 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Cc: Ani Sinha <anisinha@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v2 30/32] kvm/clock: add support for confidential guest reset
Date: Mon, 12 Jan 2026 18:52:43 +0530
Message-ID: <20260112132259.76855-31-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260112132259.76855-1-anisinha@redhat.com>
References: <20260112132259.76855-1-anisinha@redhat.com>
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

Confidential guests change the KVM VM file descriptor upon reset and also create
new VCPU file descriptors against the new KVM VM file descriptor. We need to
save the clock state from kvm before KVM VM file descriptor changes and restore
it after. Also after VCPU file descriptors changed, we must call
KVM_KVMCLOCK_CTRL on the VCPU file descriptor to inform KVM that the VCPU is
in paused state.

Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 hw/i386/kvm/clock.c | 56 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/hw/i386/kvm/clock.c b/hw/i386/kvm/clock.c
index aba6842a22..fb0f500b7f 100644
--- a/hw/i386/kvm/clock.c
+++ b/hw/i386/kvm/clock.c
@@ -50,6 +50,9 @@ struct KVMClockState {
     /* whether the 'clock' value was obtained in a host with
      * reliable KVM_GET_CLOCK */
     bool clock_is_reliable;
+
+    NotifierWithReturn kvmclock_vcpufd_change_notifier;
+    NotifierWithReturn kvmclock_vmfd_pre_change_notifier;
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
@@ -219,6 +225,51 @@ static void kvmclock_vm_state_change(void *opaque, bool running,
     }
 }
 
+static int kvmclock_save_clock(NotifierWithReturn *notifier,
+                               void *data, Error** errp)
+{
+    KVMClockState *s = container_of(notifier, KVMClockState,
+                                    kvmclock_vmfd_pre_change_notifier);
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
@@ -230,7 +281,12 @@ static void kvmclock_realize(DeviceState *dev, Error **errp)
 
     kvm_update_clock(s);
 
+    s->kvmclock_vcpufd_change_notifier.notify = kvmclock_set_clock;
+    s->kvmclock_vmfd_pre_change_notifier.notify = kvmclock_save_clock;
+
     qemu_add_vm_change_state_handler(kvmclock_vm_state_change, s);
+    kvm_vcpufd_add_change_notifier(&s->kvmclock_vcpufd_change_notifier);
+    kvm_vmfd_add_pre_change_notifier(&s->kvmclock_vmfd_pre_change_notifier);
 }
 
 static bool kvmclock_clock_is_reliable_needed(void *opaque)
-- 
2.42.0


