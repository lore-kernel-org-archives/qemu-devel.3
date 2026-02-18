Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F2D4E9A03B
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 11:46:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsfz8-0004hU-7o; Wed, 18 Feb 2026 06:44:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vsfyZ-0003zG-MG
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 06:44:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vsfyW-0007x3-8s
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 06:44:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771415051;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Lc7U1GbS1JHxjc6G1Vv9nRCpYH775c/aB7pSkgG/wFs=;
 b=Vv6AQx+7FPzipL5BqjdS5w+JCSSTM3QXlwRnihfS1FA4BnlWE/4fbIo2/SQB0w+CoOyhUS
 c1eBpLxHpEyKC3+up4q0XZZCBGNDxWDMStE2NxQdhVwZhEEQdmTVS42gLvNk9xJMwuan8C
 cIdWP8mW7t/3UCMlx5K5b89GuXrm3f4=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-426-Lsv1dRo5PZSkPSpkEwDnCA-1; Wed, 18 Feb 2026 06:44:10 -0500
X-MC-Unique: Lsv1dRo5PZSkPSpkEwDnCA-1
X-Mimecast-MFC-AGG-ID: Lsv1dRo5PZSkPSpkEwDnCA_1771415049
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2ab0b2e804cso69692755ad.3
 for <qemu-devel@nongnu.org>; Wed, 18 Feb 2026 03:44:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771415049; x=1772019849; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Lc7U1GbS1JHxjc6G1Vv9nRCpYH775c/aB7pSkgG/wFs=;
 b=t7bPE/PtL6Op3n/XOfREBTs15TYyr6++U6rqkcss0C+S8hOByUZ7ekrg5N6Htpg+oV
 za6ZJwjbR+gKnDFUcJo6pCWODPMSWDBbF1d+TqC87iuie3sjM9PfzFtg+X0szPfrg9PW
 OXj3Ty/XEFOeTg82CLfoWyErrUQToS4LFHSuHzpeaynJN7YIrO5vSHvV1uDUM7YrPDKo
 EEYqGo7nq5lbpp2j1TBAwfQgX03pOJeZnSYOiuMm7kAp+LDkjzS/HWSa9lCBxUZAFG+s
 C8DJCaDm4YwpJgMEDeYP2BN4rzgiaUtuEV9y26IXuZZyd9nfn7m0wBMBAZK5LBoZOhnI
 eV4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771415049; x=1772019849;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Lc7U1GbS1JHxjc6G1Vv9nRCpYH775c/aB7pSkgG/wFs=;
 b=jpilxsBSn5LcYVcu6mPwiIddyf7M1oTXukkp8AnqVfEY1SIAiOePXR1dGZbdzNYf+u
 9lA1h2agHYErhrKSVvHJ96trPhjEUPEJujmR0SYH+I87c4pFyXZGqzo6S/ckI9u5EV1g
 3TpVedMjt/nHnyNVNhVxt6Fa/i0m2gOjaq8QZn/EnjRH4xDLfCvuCzhCnb42lLkGKz0d
 kNBXSwufK0LnZmz8MrOXUP2FEGArV94/6+B9a07xJk7JP+90ygxph6OHSsf3EBPF/3NA
 2QQBSn4x0hKPxUKVQnHL793zP3mzTJ6dKgUXL00LX0Rl8zY6xa/TBntyvjCiKUTGuJ+Z
 PRBg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWw3kEjKXUqBrZYsM6UwfhbbD11cqOUp3A45CzoxwN+kl0j0FSFJi0DKiEsR14wfvIOMX/Xk30nRXtR@nongnu.org
X-Gm-Message-State: AOJu0YxF+4N7+uuOh9s0ZQTHDRRhSdgIMkZ+RaHqd+rt4NkeFY4es5RF
 OBDaAwGxG+CT/mEp/IplyjKwgkeCtJrdcSgpUod5T4KQr+D+RhCJdYCPmA4YH+TdaT7tMuMDQQw
 PO5xeZVG8S091u5oKjRC+Tq/opZW8fXOWRa9mcrZaKTDo/sVnn/dVSenB
X-Gm-Gg: AZuq6aKuHxabSAT6MWcD8X9RTMgQPGtLrZQSDv65nz6Lim1qLUgbWFHpiJuxJc9J2ra
 6zeqw7dltenFSbGDYpj1rZlUcR7J08oEvtwJ1KhoYAXA2f29XkghzskrpDCQLAd+SG6ACoNqwfy
 6KYn+/whT1EartCAVvMZ10fH2Ynd1EV0XqpH2DmcLKSNqFPK+6GCs3o7rFHA/LmqCur0Gvp4B02
 KCWcwBNQhFRyq/BoKx/VgZeoH7OOdQJcTWcf/y7SKFKMlwL6XVEEkLwQlY01HleW85tqDpGwQWN
 8f0Xxbi3w7MeULKgY0rg4GlkNVrGGr42/MZL+8oqNIjik7TQMAPQ4SteZBS632Mn7TRpQaPTqel
 2Qmr520jKbY4qnModmTObi7ucHnRq9oPBRxM1d6jZYhRRMgyLQK6t
X-Received: by 2002:a17:902:cccd:b0:297:cf96:45bd with SMTP id
 d9443c01a7336-2ad50eb31b4mr16065715ad.19.1771415049244; 
 Wed, 18 Feb 2026 03:44:09 -0800 (PST)
X-Received: by 2002:a17:902:cccd:b0:297:cf96:45bd with SMTP id
 d9443c01a7336-2ad50eb31b4mr16065545ad.19.1771415048913; 
 Wed, 18 Feb 2026 03:44:08 -0800 (PST)
Received: from rhel9-box.lan ([117.99.83.54])
 by smtp.googlemail.com with ESMTPSA id
 d9443c01a7336-2ad1aaeab38sm127803425ad.82.2026.02.18.03.44.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Feb 2026 03:44:08 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>, kraxel@redhat.com, kvm@vger.kernel.org,
 qemu-devel@nongnu.org
Subject: [PATCH v5 27/34] kvm/xen-emu: re-initialize capabilities during
 confidential guest reset
Date: Wed, 18 Feb 2026 17:12:20 +0530
Message-ID: <20260218114233.266178-28-anisinha@redhat.com>
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


