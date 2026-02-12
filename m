Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAF31EDF04B
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 06:29:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqQAr-0000yq-CW; Thu, 12 Feb 2026 01:27:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vqQAW-0000Ri-PO
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 01:27:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vqQAT-0005M9-Pw
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 01:27:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770877633;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Lc7U1GbS1JHxjc6G1Vv9nRCpYH775c/aB7pSkgG/wFs=;
 b=Gsl7rIn9f/mGs/sB6kSZmpZo6b/EMvb1K/nunuUXPu99NZmsLBJEaCfiCgZRrTHD1TxdBE
 axNpfY0/8Byzo+CN7kUZmxN2MNCH134k+ssPJOPtisHzcaNQ/8FAyu3O2+YbdtCibJZ0ek
 y8bA0BzcQvMyihPEDN0tntVqy/LbuVQ=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-rzUMDyRrMGOsw0DY62gVgA-1; Thu, 12 Feb 2026 01:27:11 -0500
X-MC-Unique: rzUMDyRrMGOsw0DY62gVgA-1
X-Mimecast-MFC-AGG-ID: rzUMDyRrMGOsw0DY62gVgA_1770877631
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-3545dbb7ee6so2365795a91.3
 for <qemu-devel@nongnu.org>; Wed, 11 Feb 2026 22:27:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770877631; x=1771482431; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Lc7U1GbS1JHxjc6G1Vv9nRCpYH775c/aB7pSkgG/wFs=;
 b=KUuCa0Cg8xI6dXjPJNqzRJ+wDHfQdl+/sq/xImyvydXkD7dOwfDVRmGoULzK4LIk7e
 Rd2GQ7V+KP8IjOWE1PQfdmha+xXKbb1OXlF7Egn05XxkOpxRh5gAau1tIcoVoz3kTw2+
 qFVReuu9bDmaYVXW9wMZeiVkqFgA3nzk6Yq+CQO4iE42VdTzA7s8lQH9rqXtKq97Lppd
 VIwRYgmn2qJ2icdlfethGMNCmYNN1WJSJD1cvsQG1eHOCrZhw/yFpTzFHQEsyMtUR4sm
 QHTVYRXPhJlS25be3bQxSbRYl6WRyfTJRTgzmRD5JkBIgViwFZRaxE6Vk+qtKdDrM+H/
 2FEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770877631; x=1771482431;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Lc7U1GbS1JHxjc6G1Vv9nRCpYH775c/aB7pSkgG/wFs=;
 b=fdj4KYXIP1TKSQ8xOBIyBod9KRh5VxrIlovSTfYasQVTXBOglnRIFWyIie/SH9Vwui
 +qPOe3seKLxLcKGxYmyT0k4eYAzJiMWivFjQebDNakYS37ReIy49dhTjgR08KyLKwmfm
 hFNKGIDWVSI0cBsFAhksocFjFkv6txT5xu6APIZt/mpj+1xmh5Ijm/G3BHCQW7KxskUV
 jhoFBAUhI3gWt/vEBuOEw9SbGjELZGejrNrpRbedJATUU1t1IYmUL/GILeuTuSuO35Ko
 JYfVnyaCOm0RYcKQTqeFdMOxO2iJe2dMld392DKbPO7oIJV2X9vxeQavo/uR6Hb4RPP4
 4Viw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVnugi2Fk468IihsGCCRnXJreLaAlozyUb1+kbQgcNK/9IvmtlOQfOOblQ3aKPtOckTQlNdvOg7MPr1@nongnu.org
X-Gm-Message-State: AOJu0YzIPgZrWY/3u/bNu6qXe4WZPrQA4EPJHWDfcQHZxeHS21KqCs+Z
 RsEGwnPQmYyZ+PV761PpSdkXEMZbgjGaHjF9OKvnjX+RNEvO/xwYpyuVh0DKs033eMAyYgfqlkA
 l/vFdrYS4OI88HzW9QqpiyKEUbbUp1eD/WZgrb/QN9B0/Qm35mPQoCmf5
X-Gm-Gg: AZuq6aI9XRMFQ8ukKdi7Vy25BkqcQ+ZfqqKSrzK30y/uk28qWRLAJPROD9AjljqlW69
 6u3iQhC9+3UIeo1iqiuULAY9jwF8+TFd7rL/XPB3lWEhX6DcPI8LGz2lWSW3mkUglKtIl+j+r4b
 /8g2Kz1B5WuUaJEhog1FRYES4X5UgFZAWyxXD4sMXb6Gz1yBjt4HB48HxmrOn+2yQsli9k3QRAx
 GLk+8R3gLlHu/CQCqNTPYAq5d5m52OQcVhoarLK/Sf/Q4beP/qPIqzyj4k1GWdlPskgjSZ8v8/d
 HAsW/BgiPjOpGDFkp3A7mPcNcE+iWmv1aNOMMozKmJVeS7ay59ydYU1VhqmxDUA2waCJ9IaZ3T1
 1HWp76j3PHZsW2FOpCUJklY/sZbG3atVHtd7a/ZZJaaiqYtN0PSFbKiM=
X-Received: by 2002:a17:90a:d2ce:b0:341:2150:4856 with SMTP id
 98e67ed59e1d1-35693d5e966mr1153069a91.17.1770877630752; 
 Wed, 11 Feb 2026 22:27:10 -0800 (PST)
X-Received: by 2002:a17:90a:d2ce:b0:341:2150:4856 with SMTP id
 98e67ed59e1d1-35693d5e966mr1153054a91.17.1770877630409; 
 Wed, 11 Feb 2026 22:27:10 -0800 (PST)
Received: from rhel9-box.lan ([122.164.27.113])
 by smtp.googlemail.com with ESMTPSA id
 98e67ed59e1d1-3567e7d95d8sm4894122a91.2.2026.02.11.22.27.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Feb 2026 22:27:10 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
Cc: kraxel@redhat.com, Ani Sinha <anisinha@redhat.com>, kvm@vger.kernel.org,
 qemu-devel@nongnu.org
Subject: [PATCH v4 26/31] kvm/xen-emu: re-initialize capabilities during
 confidential guest reset
Date: Thu, 12 Feb 2026 11:55:10 +0530
Message-ID: <20260212062522.99565-27-anisinha@redhat.com>
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

On confidential guests KVM virtual machine file descriptor changes as a
part of the guest reset process. Xen capabilities needs to be re-initialized in
KVM against the new file descriptor.

Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 target/i386/kvm/xen-emu.c | 50 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 48 insertions(+), 2 deletions(-)

diff --git a/target/i386/kvm/xen-emu.c b/target/i386/kvm/xen-emu.c
index 52de019834..69527145eb 100644
--- a/target/i386/kvm/xen-emu.c
+++ b/target/i386/kvm/xen-emu.c
@@ -44,9 +44,12 @@
 
 #include "xen-compat.h"
 
+NotifierWithReturn xen_vmfd_change_notifier;
+static bool hyperv_enabled;
 static void xen_vcpu_singleshot_timer_event(void *opaque);
 static void xen_vcpu_periodic_timer_event(void *opaque);
 static int vcpuop_stop_singleshot_timer(CPUState *cs);
+static int do_initialize_xen_caps(KVMState *s, uint32_t hypercall_msr);
 
 #ifdef TARGET_X86_64
 #define hypercall_compat32(longmode) (!(longmode))
@@ -54,6 +57,30 @@ static int vcpuop_stop_singleshot_timer(CPUState *cs);
 #define hypercall_compat32(longmode) (false)
 #endif
 
+static int xen_handle_vmfd_change(NotifierWithReturn *n,
+                                  void *data, Error** errp)
+{
+    int ret;
+
+    /* we are not interested in pre vmfd change notification */
+    if (((VmfdChangeNotifier *)data)->pre) {
+        return 0;
+    }
+
+    ret = do_initialize_xen_caps(kvm_state, XEN_HYPERCALL_MSR);
+    if (ret < 0) {
+        return ret;
+    }
+
+    if (hyperv_enabled) {
+        ret = do_initialize_xen_caps(kvm_state, XEN_HYPERCALL_MSR_HYPERV);
+        if (ret < 0) {
+            return ret;
+        }
+    }
+    return 0;
+}
+
 static bool kvm_gva_to_gpa(CPUState *cs, uint64_t gva, uint64_t *gpa,
                            size_t *len, bool is_write)
 {
@@ -111,15 +138,16 @@ static inline int kvm_copy_to_gva(CPUState *cs, uint64_t gva, void *buf,
     return kvm_gva_rw(cs, gva, buf, sz, true);
 }
 
-int kvm_xen_init(KVMState *s, uint32_t hypercall_msr)
+static int do_initialize_xen_caps(KVMState *s, uint32_t hypercall_msr)
 {
+    int xen_caps, ret;
     const int required_caps = KVM_XEN_HVM_CONFIG_HYPERCALL_MSR |
         KVM_XEN_HVM_CONFIG_INTERCEPT_HCALL | KVM_XEN_HVM_CONFIG_SHARED_INFO;
+
     struct kvm_xen_hvm_config cfg = {
         .msr = hypercall_msr,
         .flags = KVM_XEN_HVM_CONFIG_INTERCEPT_HCALL,
     };
-    int xen_caps, ret;
 
     xen_caps = kvm_check_extension(s, KVM_CAP_XEN_HVM);
     if (required_caps & ~xen_caps) {
@@ -143,6 +171,21 @@ int kvm_xen_init(KVMState *s, uint32_t hypercall_msr)
                      strerror(-ret));
         return ret;
     }
+    return xen_caps;
+}
+
+int kvm_xen_init(KVMState *s, uint32_t hypercall_msr)
+{
+    int xen_caps;
+
+    xen_caps = do_initialize_xen_caps(s, hypercall_msr);
+    if (xen_caps < 0) {
+        return xen_caps;
+    }
+
+    if (!hyperv_enabled && (hypercall_msr == XEN_HYPERCALL_MSR_HYPERV)) {
+        hyperv_enabled = true;
+    }
 
     /* If called a second time, don't repeat the rest of the setup. */
     if (s->xen_caps) {
@@ -185,6 +228,9 @@ int kvm_xen_init(KVMState *s, uint32_t hypercall_msr)
     xen_primary_console_reset();
     xen_xenstore_reset();
 
+    xen_vmfd_change_notifier.notify = xen_handle_vmfd_change;
+    kvm_vmfd_add_change_notifier(&xen_vmfd_change_notifier);
+
     return 0;
 }
 
-- 
2.42.0


