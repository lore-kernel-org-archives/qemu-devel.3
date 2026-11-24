Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F3A606A6A0
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 23:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=psysTftX
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVzr0-0000cz-Ro; Tue, 24 Nov 2026 18:23:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+8ed7664ba4dc972f2276+8493+infradead.org+dwmw2@desiato.srs.infradead.org>)
 id 1xVzqq-0000ZJ-8Y
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 18:23:06 -0500
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+8ed7664ba4dc972f2276+8493+infradead.org+dwmw2@desiato.srs.infradead.org>)
 id 1xVzqk-0006ZM-Fl
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 18:23:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
 Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
 To:From:Reply-To:Content-ID:Content-Description;
 bh=OFnO+yDa1ZmaA/R14QNLcscazCGJjNcIgEoVI8ugoEQ=; b=psysTftXmhA2M/i2DJl5n05FHQ
 YEihJUcA70x2jaMkwy7shi63x1e+4RR2zpn9A34T+C2xx4UmrkzE41sjhqPOzFbP4rkKS6B6/2EIK
 KIB+0q5IeoWJV+95HQf6PO1/9had2W/fybDhqxoPXMjnGScMoZdLhJ+OKglpSLbSEs+VzjwD9nr0b
 qjO61STD8KCMk3m9fosBpIk4ATbqXltZabXfmQgct2oLJg+jJjOMT3qvju5Lg2P4UBmlI1tbvhGbb
 4pKfhXfHQ5nW/F9oFNTtnNVqsutodaerl05oORbETSyQ26DCWmQ0SGNngFdSqMe1Tuie31OGp8NX2
 cTMZC1EQ==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
 by desiato.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
 id 1xVzqc-00000004eUy-1kfJ; Tue, 24 Nov 2026 23:22:51 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red
 Hat Linux)) id 1xVzqZ-0000000061w-1JuJ;
 Tue, 24 Nov 2026 23:22:47 +0000
From: David Woodhouse <dwmw2@infradead.org>
To: qemu-devel@nongnu.org
Cc: xen-devel@lists.xenproject.org, kvm@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Paul Durrant <paul@xen.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Jason Wang <jasowangio@gmail.com>, Hui Peng <benquike@gmail.com>,
 Mark Syms <mark.syms@citrix.com>, Feifan Qian <bea1e@proton.me>,
 David Woodhouse <dwmw@amazon.co.uk>
Subject: [PATCH v1 03/21] i386/xen: Free Xen vCPU timers when a vCPU is
 destroyed
Date: Tue, 24 Nov 2026 23:22:29 +0000
Message-ID: <20261124232247.23169-4-dwmw2@infradead.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261124232247.23169-1-dwmw2@infradead.org>
References: <20261124232247.23169-1-dwmw2@infradead.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by
 desiato.infradead.org. See http://www.infradead.org/rpr.html
Received-SPF: none client-ip=2001:8b0:10b:1:d65d:64ff:fe57:4e05;
 envelope-from=BATV+8ed7664ba4dc972f2276+8493+infradead.org+dwmw2@desiato.srs.infradead.org;
 helo=desiato.infradead.org
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-21.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: David Woodhouse <dwmw@amazon.co.uk>

kvm_xen_init_vcpu() allocates the per-vCPU timers with the CPUState as
callback opaque, and nothing freed them on vCPU destruction. So a guest
could arm the periodic timer for a vCPU (VCPUOP_set_periodic_timer
always reaches QEMU; the kernel doesn't handle it) and eject that vCPU
via ACPI hotplug, leaving the armed timer pointing at a freed X86CPU.

Free both timers in kvm_xen_destroy_vcpu(), called from
kvm_arch_destroy_vcpu(). That runs under the BQL, as do the timer
callbacks, so it cannot race an in-flight callback. It *can* race a
timer hypercall from another vCPU — hypercalls don't take the BQL,
which is why xen_timers_lock exists — so clear the pointers under that
lock and have the periodic timer paths return -ENOENT when the timer is
gone, as for a nonexistent vCPU. The singleshot ops act only on the
calling vCPU, so cannot race its destruction.

Also move the timer_del() in do_set_periodic_timer() inside the lock,
where it should have been all along.

Fixes: CVE-2026-123069
Fixes: b746a779264f ("i386/xen: handle PV timer hypercalls")
Reported-by: MyeonghunPak <https://gitlab.com/mhun512>
Closes: https://gitlab.com/qemu-project/qemu/-/work_items/4098
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 target/i386/kvm/kvm.c     |  6 ++++++
 target/i386/kvm/xen-emu.c | 36 ++++++++++++++++++++++++++++++++++--
 target/i386/kvm/xen-emu.h |  1 +
 3 files changed, 41 insertions(+), 2 deletions(-)

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 76528f1123f..302621f30af 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -2556,6 +2556,12 @@ int kvm_arch_destroy_vcpu(CPUState *cs)
     X86CPU *cpu = X86_CPU(cs);
     CPUX86State *env = &cpu->env;
 
+#ifdef CONFIG_XEN_EMU
+    if (cs->kvm_state->xen_version) {
+        kvm_xen_destroy_vcpu(cs);
+    }
+#endif
+
     g_free(env->xsave_buf);
 
     g_free(cpu->kvm_msr_buf);
diff --git a/target/i386/kvm/xen-emu.c b/target/i386/kvm/xen-emu.c
index 7337561b159..67d1379e024 100644
--- a/target/i386/kvm/xen-emu.c
+++ b/target/i386/kvm/xen-emu.c
@@ -276,6 +276,28 @@ int kvm_xen_init_vcpu(CPUState *cs)
     return 0;
 }
 
+void kvm_xen_destroy_vcpu(CPUState *cs)
+{
+    CPUX86State *env = &X86_CPU(cs)->env;
+
+    /*
+     * This runs on the vCPU's own thread with the BQL held, and the
+     * timer callbacks run from the main loop thread also with the BQL
+     * held, so freeing the timers cannot race against an in-flight
+     * callback. It *can* race against a Xen hypercall from another
+     * vCPU targeting this one (hypercalls are handled without the
+     * BQL), so clear the pointers under xen_timers_lock to let those
+     * paths observe the vCPU's demise.
+     */
+    QEMU_LOCK_GUARD(&env->xen_timers_lock);
+
+    timer_free(env->xen_singleshot_timer);
+    env->xen_singleshot_timer = NULL;
+
+    timer_free(env->xen_periodic_timer);
+    env->xen_periodic_timer = NULL;
+}
+
 uint32_t kvm_xen_get_caps(void)
 {
     return kvm_state->xen_caps;
@@ -1079,10 +1101,15 @@ static int do_set_periodic_timer(CPUState *target, uint64_t period_ns)
     CPUX86State *tenv = &X86_CPU(target)->env;
     int64_t qemu_now;
 
-    timer_del(tenv->xen_periodic_timer);
-
     qemu_mutex_lock(&tenv->xen_timers_lock);
 
+    if (!tenv->xen_periodic_timer) {
+        qemu_mutex_unlock(&tenv->xen_timers_lock);
+        return -ENOENT;
+    }
+
+    timer_del(tenv->xen_periodic_timer);
+
     qemu_now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
     timer_mod_ns(tenv->xen_periodic_timer, qemu_now + period_ns);
     tenv->xen_periodic_timer_period = period_ns;
@@ -1120,6 +1147,11 @@ static int vcpuop_stop_periodic_timer(CPUState *target)
 
     qemu_mutex_lock(&tenv->xen_timers_lock);
 
+    if (!tenv->xen_periodic_timer) {
+        qemu_mutex_unlock(&tenv->xen_timers_lock);
+        return -ENOENT;
+    }
+
     timer_del(tenv->xen_periodic_timer);
     tenv->xen_periodic_timer_period = 0;
 
diff --git a/target/i386/kvm/xen-emu.h b/target/i386/kvm/xen-emu.h
index fe85e0b1958..467b9f088ae 100644
--- a/target/i386/kvm/xen-emu.h
+++ b/target/i386/kvm/xen-emu.h
@@ -25,6 +25,7 @@
 
 int kvm_xen_init(KVMState *s, uint32_t hypercall_msr);
 int kvm_xen_init_vcpu(CPUState *cs);
+void kvm_xen_destroy_vcpu(CPUState *cs);
 int kvm_xen_handle_exit(X86CPU *cpu, struct kvm_xen_exit *exit);
 int kvm_put_xen_state(CPUState *cs);
 int kvm_get_xen_state(CPUState *cs);
-- 
2.43.0


