Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A22EAC02194
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2025 14:37:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgPU2-000243-FZ; Fri, 07 Feb 2025 09:37:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+d214d3087cba0d0cd96e+7838+infradead.org+dwmw2@casper.srs.infradead.org>)
 id 1tgPU0-000235-92; Fri, 07 Feb 2025 09:37:28 -0500
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+d214d3087cba0d0cd96e+7838+infradead.org+dwmw2@casper.srs.infradead.org>)
 id 1tgPTy-00049E-GB; Fri, 07 Feb 2025 09:37:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
 MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
 Content-ID:Content-Description:In-Reply-To:References;
 bh=0iLbiXf0JAInaIYlB0oBe9NqYMClY9KNDWGNrILCnR4=; b=f/FhYyVX1yiyt6eD5J0U0KCy9a
 2LD5NrvXhQWV1JOoysvnvV8f2wYjXSoMrt2v+12QdyTMf+0/ZK9h5BdOAP2UnVv8KX0sl/OO0V21c
 AF67Us2MuwKMNHY9TPuPsuAuzGweux7pjcUvgxkYwy3xiuu4m6jLxsxs5NxG7Yb5Z8dfCF48kJZfS
 Byu0sSzJ3pn7327mk/QE8BD7S41aiqswNlXgcxr8ZgoYiznkNMy47BkAxVj09n2Mse2nSdqyUzkqS
 jJROFyLk4yk+QsA6pzscZbI7gQc+1SCflLvbahat4/zMLrErCEdTk7rAUhheQZrKElkpqsSEsSkMP
 lkMF4WJQ==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
 by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
 id 1tgPTw-00000007yYM-2RIX; Fri, 07 Feb 2025 14:37:24 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.98 #2 (Red Hat
 Linux)) id 1tgPTw-0000000080p-1DMh; Fri, 07 Feb 2025 14:37:24 +0000
From: David Woodhouse <dwmw2@infradead.org>
To: qemu-devel@nongnu.org
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>, Paul Durrant <paul@xen.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 David Woodhouse <dwmw2@infradead.org>, xen-devel@lists.xenproject.org,
 qemu-block@nongnu.org, kvm@vger.kernel.org,
 Sean Christopherson <seanjc@google.com>
Subject: [PATCH 1/2] i386/xen: Move KVM_XEN_HVM_CONFIG ioctl to
 kvm_xen_init_vcpu()
Date: Fri,  7 Feb 2025 14:37:23 +0000
Message-ID: <20250207143724.30792-1-dwmw2@infradead.org>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
Received-SPF: none client-ip=2001:8b0:10b:1236::1;
 envelope-from=BATV+d214d3087cba0d0cd96e+7838+infradead.org+dwmw2@casper.srs.infradead.org;
 helo=casper.infradead.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

From: David Woodhouse <dwmw@amazon.co.uk>

At the time kvm_xen_init() is called, hyperv_enabled() doesn't yet work, so
the correct MSR index to use for the hypercall page isn't known.

Rather than setting it to the default and then shifting it later for the
Hyper-V case with a confusing second call to kvm_init_xen(), just do it
once in kvm_xen_init_vcpu().

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 target/i386/kvm/kvm.c     | 16 +++++---------
 target/i386/kvm/xen-emu.c | 44 ++++++++++++++++++++-------------------
 target/i386/kvm/xen-emu.h |  4 ++--
 3 files changed, 30 insertions(+), 34 deletions(-)

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 6c749d4ee8..b4deec6255 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -2129,6 +2129,8 @@ int kvm_arch_init_vcpu(CPUState *cs)
     if (cs->kvm_state->xen_version) {
 #ifdef CONFIG_XEN_EMU
         struct kvm_cpuid_entry2 *xen_max_leaf;
+        uint32_t hypercall_msr =
+            hyperv_enabled(cpu) ? XEN_HYPERCALL_MSR_HYPERV : XEN_HYPERCALL_MSR;
 
         memcpy(signature, "XenVMMXenVMM", 12);
 
@@ -2150,13 +2152,7 @@ int kvm_arch_init_vcpu(CPUState *cs)
         c->function = kvm_base + XEN_CPUID_HVM_MSR;
         /* Number of hypercall-transfer pages */
         c->eax = 1;
-        /* Hypercall MSR base address */
-        if (hyperv_enabled(cpu)) {
-            c->ebx = XEN_HYPERCALL_MSR_HYPERV;
-            kvm_xen_init(cs->kvm_state, c->ebx);
-        } else {
-            c->ebx = XEN_HYPERCALL_MSR;
-        }
+        c->ebx = hypercall_msr;
         c->ecx = 0;
         c->edx = 0;
 
@@ -2194,7 +2190,7 @@ int kvm_arch_init_vcpu(CPUState *cs)
             }
         }
 
-        r = kvm_xen_init_vcpu(cs);
+        r = kvm_xen_init_vcpu(cs, hypercall_msr);
         if (r) {
             return r;
         }
@@ -3245,9 +3241,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
             error_report("kvm: Xen support only available in PC machine");
             return -ENOTSUP;
         }
-        /* hyperv_enabled() doesn't work yet. */
-        uint32_t msr = XEN_HYPERCALL_MSR;
-        ret = kvm_xen_init(s, msr);
+        ret = kvm_xen_init(s);
         if (ret < 0) {
             return ret;
         }
diff --git a/target/i386/kvm/xen-emu.c b/target/i386/kvm/xen-emu.c
index e81a245881..1144a6efcd 100644
--- a/target/i386/kvm/xen-emu.c
+++ b/target/i386/kvm/xen-emu.c
@@ -108,15 +108,11 @@ static inline int kvm_copy_to_gva(CPUState *cs, uint64_t gva, void *buf,
     return kvm_gva_rw(cs, gva, buf, sz, true);
 }
 
-int kvm_xen_init(KVMState *s, uint32_t hypercall_msr)
+int kvm_xen_init(KVMState *s)
 {
     const int required_caps = KVM_XEN_HVM_CONFIG_HYPERCALL_MSR |
         KVM_XEN_HVM_CONFIG_INTERCEPT_HCALL | KVM_XEN_HVM_CONFIG_SHARED_INFO;
-    struct kvm_xen_hvm_config cfg = {
-        .msr = hypercall_msr,
-        .flags = KVM_XEN_HVM_CONFIG_INTERCEPT_HCALL,
-    };
-    int xen_caps, ret;
+    int xen_caps;
 
     xen_caps = kvm_check_extension(s, KVM_CAP_XEN_HVM);
     if (required_caps & ~xen_caps) {
@@ -130,20 +126,6 @@ int kvm_xen_init(KVMState *s, uint32_t hypercall_msr)
             .u.xen_version = s->xen_version,
         };
         (void)kvm_vm_ioctl(s, KVM_XEN_HVM_SET_ATTR, &ha);
-
-        cfg.flags |= KVM_XEN_HVM_CONFIG_EVTCHN_SEND;
-    }
-
-    ret = kvm_vm_ioctl(s, KVM_XEN_HVM_CONFIG, &cfg);
-    if (ret < 0) {
-        error_report("kvm: Failed to enable Xen HVM support: %s",
-                     strerror(-ret));
-        return ret;
-    }
-
-    /* If called a second time, don't repeat the rest of the setup. */
-    if (s->xen_caps) {
-        return 0;
     }
 
     /*
@@ -185,10 +167,14 @@ int kvm_xen_init(KVMState *s, uint32_t hypercall_msr)
     return 0;
 }
 
-int kvm_xen_init_vcpu(CPUState *cs)
+int kvm_xen_init_vcpu(CPUState *cs, uint32_t hypercall_msr)
 {
     X86CPU *cpu = X86_CPU(cs);
     CPUX86State *env = &cpu->env;
+    struct kvm_xen_hvm_config cfg = {
+        .msr = hypercall_msr,
+        .flags = KVM_XEN_HVM_CONFIG_INTERCEPT_HCALL,
+    };
     int err;
 
     /*
@@ -210,6 +196,22 @@ int kvm_xen_init_vcpu(CPUState *cs)
                          strerror(-err));
             return err;
         }
+
+        cfg.flags |= KVM_XEN_HVM_CONFIG_EVTCHN_SEND;
+    }
+
+    /*
+     * This is a per-KVM setting, but hyperv_enabled() can't be used
+     * when kvm_xen_init() is called from kvm_arch_init(), so do it
+     * when the BSP is initialized.
+     */
+    if (cs->cpu_index == 0) {
+        err = kvm_vm_ioctl(cs->kvm_state, KVM_XEN_HVM_CONFIG, &cfg);
+        if (err) {
+            error_report("kvm: Failed to enable Xen HVM support: %s",
+                         strerror(-err));
+            return err;
+        }
     }
 
     env->xen_vcpu_info_gpa = INVALID_GPA;
diff --git a/target/i386/kvm/xen-emu.h b/target/i386/kvm/xen-emu.h
index fe85e0b195..7a7c72eee5 100644
--- a/target/i386/kvm/xen-emu.h
+++ b/target/i386/kvm/xen-emu.h
@@ -23,8 +23,8 @@
 
 #define XEN_VERSION(maj, min) ((maj) << 16 | (min))
 
-int kvm_xen_init(KVMState *s, uint32_t hypercall_msr);
-int kvm_xen_init_vcpu(CPUState *cs);
+int kvm_xen_init(KVMState *s);
+int kvm_xen_init_vcpu(CPUState *cs, uint32_t hypercall_msr);
 int kvm_xen_handle_exit(X86CPU *cpu, struct kvm_xen_exit *exit);
 int kvm_put_xen_state(CPUState *cs);
 int kvm_get_xen_state(CPUState *cs);
-- 
2.48.1


