Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FF5CF55455
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 03:51:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vv5vE-0007OF-8C; Tue, 24 Feb 2026 22:50:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vv5vC-0007Nq-CM
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 22:50:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vv5vA-00088B-RP
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 22:50:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771991444;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8EBAMm0+61u9Fn6aJibmSGLnXTBDJJJE91zdBC7Xh+k=;
 b=QiopEwZ5+hNnkmC+hfA2kti7s2l7Ye3s4PETJ5g4IM6HLY5JPhDJPlUvmUS8DQ7t53MrQK
 Y5SARM6xo0m+PYH3s3CpxZgGt5jRFg2+ffc0oTiaJV3F/GXf93/xIS7Gkec/P8gwhHV5sc
 heqx0Tn525L7pN30xoLdrzJ4t6/PbcA=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-194-Kfe-F1u6Pi-fbrCqdigUow-1; Tue, 24 Feb 2026 22:50:42 -0500
X-MC-Unique: Kfe-F1u6Pi-fbrCqdigUow-1
X-Mimecast-MFC-AGG-ID: Kfe-F1u6Pi-fbrCqdigUow_1771991442
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-c6e1dab2235so3739970a12.3
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 19:50:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771991442; x=1772596242; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8EBAMm0+61u9Fn6aJibmSGLnXTBDJJJE91zdBC7Xh+k=;
 b=FfT5SKQxlsUn0BLfHl9/MTx8ussKV9UmRJYgCCK5abr2VrY91aPV0mWCPNaPQh27BT
 QYh8WK1pksSYeT9h9pGoG9KJ4rC44j0KBZ74KVrlQQ3fL/6K1KMu8h+9rsIcLjXOthZX
 wAdlpRLRbSsA69QFauMhk5Hb7D0h/fIpZKugd5r7hMfdlAogckjpPDBJBRnnf8d/62NB
 xebljrtByS9+XrkGx8nIuJW+YXXiCtDJuQ2CJcwhE03a46XleZiZXBOCA0Zxq/PRE0bR
 nkEV4IgcYPAd2/QyNltSJu7Xq/UmtwsYZYnwUBg4f/qPIltM7JluDsAPcOqy+R0uUh2J
 HvxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771991442; x=1772596242;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8EBAMm0+61u9Fn6aJibmSGLnXTBDJJJE91zdBC7Xh+k=;
 b=Z7+agdShsQmQw7qn5FAJ5Ua5eO6UcYDvdH/fRFl+aOY8yXQLPhIuriadMACubDIkC+
 qB+DsfeEetvaw4mlBB+bVXKOVGUadlGWFqzUPNPQ3H9w2U6shIQWHQB2JVFtdV9EsEi5
 v8ik3z+4Xjjg+NrIftuvh5xgwjMUA5B5bzTPM1GfR2yyuESOWfq2seUuiFwakonFaOJx
 WBhhPKDcsq3Lnyzy+xX0JzW1x7QtAFQ0pnFYdCEDVt8/ZYt3NJA3ANZ1aF1MhBSBAl/C
 eH/xgjOhE0AZYySFfjeHl/rwPdXXcRT+TVVw192uOpkqExyRFqzj+WdRpVabP2f2O6E+
 Quhg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXquh3glhcNW5yZPhz8O/rVZD8XphtSg4tVAkG+bgG3ekBrTfA8lawi+Cs0CMvB25agAK6FH/kEIJNa@nongnu.org
X-Gm-Message-State: AOJu0YxcsihP66vYtXVMdVTAB5LrolXlnbji/qCj0XILfamN/es75/T6
 a3wtGg3scUiGeRvW9EIaFNtDaitbmzhiSOGR+qlH0rKqvP8N41mwluwP9NzsUfx2Mj0c9aOi/b3
 HNbiZEchBwTMhDpQ+aLEfBxpSfr7RQHRlC9wjOqFVmwfFYEp/FsSD8lRm
X-Gm-Gg: ATEYQzyfRxeXJT627hwOXWC+PTp1ZPBQOH0wf1mBlivmQZv4ErlkIGNNeFBoY6nVWnj
 mTEK80bRRHElwQXA2fAiyQuuZ79eEHqcRg/PhxkVC3myFzfcXTjjgTgpCp0YLQOwY7KlCp6ljat
 8aHo03YEmo4frPq8MAlpuDuIWmzHBmf7c2N6bY/YWnMx1YX5JNa+wPfZMKIrOlS6/ggC4C9gL7V
 nhGNUHFBW9tQgSaja+SVFbRImnBm8e1ltl8tA/wv0jO8ZrNOj/fp/T+Kj+Q6Bz/i52h5vDsS5ci
 KdPeyduyj+PQf/D0AvAuEVkJXee8D9Sp8kTcp2S45cmM3Y4hpvKz68e8oEBO8fsFyQCVjmDuB86
 yrVebxrHSnJu/6JZrRyEDT3fgNU74078CkSAN0xd12u3PlMbRfe8Fcz4=
X-Received: by 2002:a05:6a20:9e49:b0:38d:fc34:c88d with SMTP id
 adf61e73a8af0-39545fab8admr11806018637.55.1771991441762; 
 Tue, 24 Feb 2026 19:50:41 -0800 (PST)
X-Received: by 2002:a05:6a20:9e49:b0:38d:fc34:c88d with SMTP id
 adf61e73a8af0-39545fab8admr11805987637.55.1771991441314; 
 Tue, 24 Feb 2026 19:50:41 -0800 (PST)
Received: from rhel9-box.lan ([122.176.129.56])
 by smtp.googlemail.com with ESMTPSA id
 98e67ed59e1d1-359018838b2sm1186006a91.5.2026.02.24.19.50.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Feb 2026 19:50:41 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>, kraxel@redhat.com, ani@anisinha.ca,
 kvm@vger.kernel.org, qemu-devel@nongnu.org
Subject: [PATCH v6 10/35] kvm/i386: implement architecture support for kvm
 file descriptor change
Date: Wed, 25 Feb 2026 09:19:15 +0530
Message-ID: <20260225035000.385950-11-anisinha@redhat.com>
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

When the kvm file descriptor changes as a part of confidential guest reset,
some architecture specific setups including SEV/SEV-SNP/TDX specific setups
needs to be redone. These changes are implemented as a part of the
kvm_arch_on_vmfd_change() callback which was introduced previously.

Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 target/i386/kvm/kvm.c        | 49 ++++++++++++++++++++++++++++--------
 target/i386/kvm/trace-events |  1 +
 2 files changed, 39 insertions(+), 11 deletions(-)

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 83657fe832..8679e7d3fa 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -3407,12 +3407,30 @@ static int kvm_vm_enable_energy_msrs(KVMState *s)
 
 int kvm_arch_on_vmfd_change(MachineState *ms, KVMState *s)
 {
-    abort();
+    int ret;
+
+    ret = kvm_arch_init(ms, s);
+    if (ret < 0) {
+        return ret;
+    }
+
+    if (object_dynamic_cast(OBJECT(ms), TYPE_X86_MACHINE)) {
+        X86MachineState *x86ms = X86_MACHINE(ms);
+
+        if (x86_machine_is_smm_enabled(x86ms)) {
+            memory_listener_register(&smram_listener.listener,
+                                     &smram_address_space);
+        }
+        kvm_set_max_apic_id(x86ms->apic_id_limit);
+    }
+
+    trace_kvm_arch_on_vmfd_change();
+    return 0;
 }
 
 bool kvm_arch_supports_vmfd_change(void)
 {
-    return false;
+    return true;
 }
 
 int kvm_arch_init(MachineState *ms, KVMState *s)
@@ -3420,6 +3438,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
     int ret;
     struct utsname utsname;
     Error *local_err = NULL;
+    static bool first = true;
 
     /*
      * Initialize confidential guest (SEV/TDX) context, if required
@@ -3489,16 +3508,17 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
         return ret;
     }
 
-    /* Tell fw_cfg to notify the BIOS to reserve the range. */
-    e820_add_entry(KVM_IDENTITY_BASE, 0x4000, E820_RESERVED);
-
+    if (first) {
+        /* Tell fw_cfg to notify the BIOS to reserve the range. */
+        e820_add_entry(KVM_IDENTITY_BASE, 0x4000, E820_RESERVED);
+    }
     ret = kvm_vm_set_nr_mmu_pages(s);
     if (ret < 0) {
         return ret;
     }
 
     if (object_dynamic_cast(OBJECT(ms), TYPE_X86_MACHINE) &&
-        x86_machine_is_smm_enabled(X86_MACHINE(ms))) {
+        x86_machine_is_smm_enabled(X86_MACHINE(ms)) && first) {
         smram_machine_done.notify = register_smram_listener;
         qemu_add_machine_init_done_notifier(&smram_machine_done);
     }
@@ -3545,16 +3565,23 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
                 return ret;
             }
 
-            ret = kvm_msr_energy_thread_init(s, ms);
-            if (ret < 0) {
-                error_report("kvm : error RAPL feature requirement not met");
-                return ret;
+            if (first) {
+                ret = kvm_msr_energy_thread_init(s, ms);
+                if (ret < 0) {
+                    error_report("kvm : "
+                                 "error RAPL feature requirement not met");
+                    return ret;
+                }
             }
         }
     }
 
     pmu_cap = kvm_check_extension(s, KVM_CAP_PMU_CAPABILITY);
-    kvm_vmfd_add_change_notifier(&kvm_vmfd_change_notifier);
+
+    if (first) {
+        kvm_vmfd_add_change_notifier(&kvm_vmfd_change_notifier);
+    }
+    first = false;
 
     return 0;
 }
diff --git a/target/i386/kvm/trace-events b/target/i386/kvm/trace-events
index 74a6234ff7..2d213c9f9b 100644
--- a/target/i386/kvm/trace-events
+++ b/target/i386/kvm/trace-events
@@ -6,6 +6,7 @@ kvm_x86_add_msi_route(int virq) "Adding route entry for virq %d"
 kvm_x86_remove_msi_route(int virq) "Removing route entry for virq %d"
 kvm_x86_update_msi_routes(int num) "Updated %d MSI routes"
 kvm_hc_map_gpa_range(uint64_t gpa, uint64_t size, uint64_t attributes, uint64_t flags) "gpa 0x%" PRIx64 " size 0x%" PRIx64 " attributes 0x%" PRIx64 " flags 0x%" PRIx64
+kvm_arch_on_vmfd_change(void) ""
 
 # xen-emu.c
 kvm_xen_hypercall(int cpu, uint8_t cpl, uint64_t input, uint64_t a0, uint64_t a1, uint64_t a2, uint64_t ret) "xen_hypercall: cpu %d cpl %d input %" PRIu64 " a0 0x%" PRIx64 " a1 0x%" PRIx64 " a2 0x%" PRIx64" ret 0x%" PRIx64
-- 
2.42.0


