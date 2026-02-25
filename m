Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8E56F55452
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 03:54:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vv5wR-0003sb-Ce; Tue, 24 Feb 2026 22:52:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vv5wP-0003ki-3f
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 22:52:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vv5wN-0008Ed-3J
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 22:52:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771991518;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ampkMXpvZM0Uh9Dio1wYKLx68wPyoO/FMFpvVez+X64=;
 b=bwerOYFkJzKjeudnaRkewPBmzU5jN45ocCJwaJm0eOtDSwk57p5cJY6MQgpkE4Qrlqu98G
 i8SDy1VslDamgYuPWYlchhxVo2lvBBJLrwB3FRDBJadniyQxQ3oXdhZPsqR9FkAGBNr3vx
 9bTAaZW9bPQeyfBEXuHdNLxmAwDAJrs=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-468-9Rmu0fscPLGiKXNs1uh8cw-1; Tue, 24 Feb 2026 22:51:54 -0500
X-MC-Unique: 9Rmu0fscPLGiKXNs1uh8cw-1
X-Mimecast-MFC-AGG-ID: 9Rmu0fscPLGiKXNs1uh8cw_1771991514
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-354c0234c1fso5708641a91.2
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 19:51:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771991514; x=1772596314; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ampkMXpvZM0Uh9Dio1wYKLx68wPyoO/FMFpvVez+X64=;
 b=t5/xpXNzvEODGIS4YIFg2qh/ejOU1slqs/3RIMNDtTzyq6Xpk+4oltXvNUHzIJA4jM
 rBI1a6PGaa7NtYqSMvphc3C3Sy8KjYUZeFKz5oc2IcEOLrmeUSQp8s96eB6D02XcO86A
 rMTmvWvghRCLrDsC9K5fjtD6ZdAPs0YXBuZEyMSu8pY9a1udcf0sbaVgxC/R/TIoSGpE
 b6q2C5L7obLXK/lceD6d+Xo2dc4vUgSNHm1EzrMix7+YCumSiEKvEnBFmA8ppvgYca71
 TodnOW/WDKEspp7JJtOqlnf7/9Lo+vBczx71E7ls8P+2Iv0uiDsKS4yL5NbgEJRtQfK4
 xFkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771991514; x=1772596314;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ampkMXpvZM0Uh9Dio1wYKLx68wPyoO/FMFpvVez+X64=;
 b=PIrT3i2/BshprY8vpcSZqDTSTQyHndPBy2wNG55OoYoMCyIrX53tACEvQuW1HXDHvN
 JGWPmnjoc37Qua56gJOIydbVFFrBRBv92Fq4Iz2tuyqkrZvkBWF/HLgc4UU/YIG6Z65t
 gRZVcZJ4TelBOHZfpgdba8PjEwEye6venDAXAdmcVB+YjPoYqXOVwTDImULyEuxuB+1C
 gxqj+mprptB09tvVvcWboUmPBqFrFaNFJzBqyneTbccg1s9gUKeIbTeWQCV/SLAj7myy
 Wc8/MiE68MG2zdXveCJj4iq5yMSveTuOOJpH7SohHqCKlkp5e4zKgIyKPyKqtZ8bgk9k
 nHXA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVXvDGWkJsH1eft3xY0SrJEfwd4qyVZ9irllUewkeHCx4kRimkG3QpmNSJnL8J8wpaM4zqqDwlgL10r@nongnu.org
X-Gm-Message-State: AOJu0Yw94hya2Jv+YOAXURthm0AqccIbP/vT7lPd/0WICe07lEzpfprm
 Ecnd1A8cZN29WkFIRWDQTBX+GeUA43C6x2sfUaM4FOmDAUeq559MMa4DVZDeYh4wGzv5I9VP5yc
 x6XInpxmzWi8uEZqSgHv/LIGElsU4CiD/pNf3yOYLOdbj3dwKMEDFbttL
X-Gm-Gg: ATEYQzz1oTYmaLPbydSD5JZIbVLcoCPTlCIiMccdMPg1TXmfpIY8QQFSwyVnXUZN8hX
 q5kbU7B5bHQtRHxfcJRYXZSiifdBNJqna9dSsffS8mSjl4O2AWSqAtJhljnDplyNLdQ8iq3Ca19
 krTCYZPEpoqEIHG6QYmWga4RZZh1tqbki0rRQBjbXjm5MgxagaPVxw0smEP5cDTkkzFPHMT/Fft
 e4pEKG0ovEKo7F4lihMUauu0GlI0zm6TctmlzIdM40Ri6wI2qhqZzAhyvkqS4U3Uh6vg8mRlRpT
 SMk5NMe8TusIczds7ccRfMoGFiDTQQAjFIGYTq+7MIZCOCuWtsZy7MQW1+y1lBRgXVw1etjRC+Z
 SdtBdoDfHG2LCU22kw0c8mRXj9K4rAuSGEyGI+3X5ufwbWsFnPt1HNIo=
X-Received: by 2002:a05:6a20:3c89:b0:364:be7:6fe9 with SMTP id
 adf61e73a8af0-3959f2f33b9mr1066196637.32.1771991513569; 
 Tue, 24 Feb 2026 19:51:53 -0800 (PST)
X-Received: by 2002:a05:6a20:3c89:b0:364:be7:6fe9 with SMTP id
 adf61e73a8af0-3959f2f33b9mr1066175637.32.1771991513199; 
 Tue, 24 Feb 2026 19:51:53 -0800 (PST)
Received: from rhel9-box.lan ([122.176.129.56])
 by smtp.googlemail.com with ESMTPSA id
 98e67ed59e1d1-359018838b2sm1186006a91.5.2026.02.24.19.51.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Feb 2026 19:51:52 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Cc: Ani Sinha <anisinha@redhat.com>, kraxel@redhat.com, ani@anisinha.ca,
 qemu-devel@nongnu.org
Subject: [PATCH v6 31/35] kvm/clock: add support for confidential guest reset
Date: Wed, 25 Feb 2026 09:19:36 +0530
Message-ID: <20260225035000.385950-32-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260225035000.385950-1-anisinha@redhat.com>
References: <20260225035000.385950-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.358, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.659,
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


