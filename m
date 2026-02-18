Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7698AE9A047
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 11:46:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsfzE-0005ZY-Q2; Wed, 18 Feb 2026 06:44:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vsfyh-0004LW-RO
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 06:44:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vsfyg-0008FN-6Z
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 06:44:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771415061;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ampkMXpvZM0Uh9Dio1wYKLx68wPyoO/FMFpvVez+X64=;
 b=OblQk9wnRNfRb1tSjsID7OnL4IY1Kf0cPAsJecMLpiWPd0HeOK/OEitke7nSkT7wNxglLj
 XPfgaY0jtpuXMqm7zt6PZKf0EZFFHYBL9Aam9aHH8vfjnGtpduIVVBxioA7pPSrFGdqh2g
 y8+jqru6ehv9BNjTjepIRevr2VwMSU4=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-pn--tvHNMgWLULHWhS-CoQ-1; Wed, 18 Feb 2026 06:44:19 -0500
X-MC-Unique: pn--tvHNMgWLULHWhS-CoQ-1
X-Mimecast-MFC-AGG-ID: pn--tvHNMgWLULHWhS-CoQ_1771415059
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2a8fc061ce1so300799355ad.0
 for <qemu-devel@nongnu.org>; Wed, 18 Feb 2026 03:44:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771415059; x=1772019859; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ampkMXpvZM0Uh9Dio1wYKLx68wPyoO/FMFpvVez+X64=;
 b=QTE5LJiVUiQ0ThqlmORHzv0TtWegP/NIOC6PZOVUnFEMs/IsgL3t/P9A4H/QufDAp8
 hrlDrQP7wUiP33dSnG6t0ROh/gHdWzBQjYXRMRK94PX+b/iqP7sTlFSjYIXDdQCeqloo
 XAN+DgzAZbQuOjRbEnK70Yf/l1fP+EW7mkVNHWXpw9OLXdKlW7kUqv8P3jmQRnEfX4J0
 6rXfiSiRFvhmykzuRXA0onmzpTS5pXanF/DHloQxIZ1JvslMyPGXvpSrTFt4Nw33s1cr
 ebowGOaGftH7tuAt87U/m8zqJOjgKjdXn4PB8/ieXoGvwLG5+KEVsS4bq5ybkv6rOTt7
 PKfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771415059; x=1772019859;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ampkMXpvZM0Uh9Dio1wYKLx68wPyoO/FMFpvVez+X64=;
 b=NXB1n/KGMN3giVOYjdLIPPopr7yRy9q4XquiBUkg9suYNtldGtCPBwJ2uTsrD0mPMS
 VoXhf332+9fDXJElgJXhlF9bOgEWq1W3nti3o0u/KeMKv86JS5ShW5jon5mlcKkY6UQu
 JxX2XM/Xwufl1yvX/87BgF6/3D2FsRDmOsDxVNPLXQ/NJfJYwc0RsbR8Srm5r/kkXcJP
 b3wLsXRvZyrbst8HQgwdUI9QcDYBr4QeuGX2tQGdr9UncNMCISpqKVrTYNVeR7F9pLHI
 u7/dH5RJKh33XITpCYUeKpaK4cWPN2SEamgQhMDnmy69MBYrg+/zc/zbURvXRsKahlX0
 a5Yw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVNYEIYl9Uz0A9deHkDWWsAhmQYEAzS8JUjhyr7QQOM0gbRcoYMt8EnFBsIaWDZrVOLmGSBxj7BxVIU@nongnu.org
X-Gm-Message-State: AOJu0YxXg40Fcu/ne536h405vx1FVI/jf5dWpp2yFm7wOrHjvUp5Xs9F
 dq05kRkXOsFTm7JSUMAn42RKrRaD1ybrEZiVhMq3IcDUEDRhpScJqNQrMI24Lo5iKFIXY3QFHcU
 1S/M0NBEiCqF6bSXGUgnFobFwyWHkFQSqw6X8OOi463EptuRlzViilnX3
X-Gm-Gg: AZuq6aIipv18UZEiQkuXo23faELasDhA3xyoR9qStqdQZzPGaj5dD6WmtelXn4ZY62G
 QhE5zYd/Hc15yw5IjBzbCYmYNaEnfJVEVtpij5CWt822CXNi+pY46DXajL1buRzgofuxZ9kQVAt
 bpstOR2T1/8Ajc9khrH8cIjE1OFGuuiykWcoPsOnAd7T8oCJRozErPOgGH27TQqwlZ93ml4Py+9
 a9X45A3OZH3drAiGJe839KvxELfaym/tsAEtN0cftpA6IMywrCmXPFg36XsWsCwYl0+W4De0zsY
 VzYjFmxvyUL9MeLtRs1xe1IyYvAwgDc8caPHoNcIbb5sl4fjEpv/f3frjNNkBUWrKOsr0YYI6o4
 +4VNl0He16/6vY6GfyMPj7ImjOm9387qKJggSAwnVDgtc6gHWtRDZ
X-Received: by 2002:a17:902:f68a:b0:2aa:f9d7:689c with SMTP id
 d9443c01a7336-2ab4cfa78a0mr167225765ad.22.1771415058895; 
 Wed, 18 Feb 2026 03:44:18 -0800 (PST)
X-Received: by 2002:a17:902:f68a:b0:2aa:f9d7:689c with SMTP id
 d9443c01a7336-2ab4cfa78a0mr167225625ad.22.1771415058526; 
 Wed, 18 Feb 2026 03:44:18 -0800 (PST)
Received: from rhel9-box.lan ([117.99.83.54])
 by smtp.googlemail.com with ESMTPSA id
 d9443c01a7336-2ad1aaeab38sm127803425ad.82.2026.02.18.03.44.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Feb 2026 03:44:18 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Cc: Ani Sinha <anisinha@redhat.com>, kraxel@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v5 30/34] kvm/clock: add support for confidential guest reset
Date: Wed, 18 Feb 2026 17:12:23 +0530
Message-ID: <20260218114233.266178-31-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260218114233.266178-1-anisinha@redhat.com>
References: <20260218114233.266178-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.043,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


