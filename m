Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 131EACCA471
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 01:13:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3lH2-00065T-RU; Tue, 30 Sep 2025 21:04:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@opnsrc.net>)
 id 1v3lGU-0005kQ-E0
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 21:04:18 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <salil.mehta@opnsrc.net>)
 id 1v3lFV-0008Fk-L8
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 21:04:18 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3ee12a63af1so4310323f8f.1
 for <qemu-devel@nongnu.org>; Tue, 30 Sep 2025 18:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=opnsrc.net; s=google; t=1759280587; x=1759885387; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A8WcCIp7AW8otz3wOJdViBKtHh2ab6qkb/xOpXEIFFU=;
 b=YqMa/7f+/5G/wVlrBQdSoL049gw7GfGzw+lLHRsHeHeiTbBZTz3q0AgmyaJfbc3q82
 25hxREWkDYgqzRCpHUtLwko0bweO/nFDNVxsSGX0qAICYwpypP3ggCEeFeJDJtbMOapo
 qfkO+2d/79q/v2cX0CSZOhehxo1P3EAaUJ7dOgmGY3bFZEGihoiV8ss3hO5fKx/Tdc7b
 /kN3dNS6uU2TGXM5wei8vtEFnVkClzXIF+dAoBfe4dD6nebVXWnnTqGd2LVYSLC6YQta
 bdnTeiM6RITY4HQwLjcimMtjxhtw3guLL7xuP8K+WhFfXn5Jb81tCxyy9PGBiK72s6mg
 yc6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759280587; x=1759885387;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=A8WcCIp7AW8otz3wOJdViBKtHh2ab6qkb/xOpXEIFFU=;
 b=DwaSrDzqgJAusGmbxlBTS9CgKb3IXdBesjkbaFNxsROQoKViwf28s/U1kTBq0GpHjS
 DO0aO7JjsOCKuozAcbGBzbOdH74Um7mJHt0X81Y5oz5MLtq7q6KWBwBiQf6+dfsQshNR
 V953/OpSGHUqAc9zUuogO1HhU+fAW72hKrP8fiAz7762y7BV7rE8uzAcz+RsqMdbma4I
 br/RcwMf8u4wJNdWFIBYE1rJbf+noc3dQ+i+m1DcI80qJxtW6kcnsWd01im8/liyFic+
 YrniunTsS5WHGZ64ISiLWF+ght5Gg5GiTrWICMfBwpsLau7LcCfM4V6feMnFG4vie2+Y
 Y1hA==
X-Gm-Message-State: AOJu0YxXpxaUXA/WHQ4MbOKe/RaqOBuTuNUCWtmL0pT81s9iEglhWYue
 poJAjwvLf/0r+YMKbg7xHpGuKrNpfzihkoXMHi5PBIDrWTaD+lXm2DjESTwpV4jAmZ/CgPtGfQI
 I6NheM+CHNw==
X-Gm-Gg: ASbGncvJoOR3d/WtUyAX+rY8I3ipaDSs5bR8JgRuEKj+esJRxIFYTQCwz9sWhyEsLVG
 phUIedn1sy8jq2AYCEd+bVDk2R5kUiQ/sUYR7B0cx3ycdvNtwPmsOQ5YO4UxYuD//67KWQx4ccD
 z83GO2jiMx6qRGVBl7rHq5BXF9tctk5w3rHjOqFJTiZOqub1n6eIugSZ8s1hnS69HKnYc+JR4ec
 bPkeew7JWTB3XIkmCYmjnHtmdbOJ9L7/n5GlOjL5srU6rrPjBgIwwcmGQ1BxjjMph1R247N4IqU
 9i4uVYDAwVPiSoOYChYyvMw7ZvXEvU9TgxLn70OlXmul0GftCV0DbtXNy6gvTQhjOeJ3AbGHSmT
 lqishKyPAd6A6gebdaf7Czo9gZp8rEEUh7E84W0mLjWQ2/egwAbwLNKQDQU2H7wSMNKB+5NHvMu
 OEjb78sNHPxDjDzs8jydiTkELP0/iCbDl2+xSlpmgGdqw=
X-Google-Smtp-Source: AGHT+IGlokWyuAQ2aOYDbWjfOqnwWRIkap8UzDam0XIevWPLN9f+zE+7RFoc9UfCTkN4Aj3PvVw+Vw==
X-Received: by 2002:a05:6000:2407:b0:3ec:db87:e8fa with SMTP id
 ffacd0b85a97d-425577fe66bmr1211377f8f.26.1759280586676; 
 Tue, 30 Sep 2025 18:03:06 -0700 (PDT)
Received: from localhost.localdomain ([90.209.204.182])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fb985e080sm24587426f8f.24.2025.09.30.18.03.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Sep 2025 18:03:06 -0700 (PDT)
From: salil.mehta@opnsrc.net
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	mst@redhat.com
Cc: salil.mehta@huawei.com, maz@kernel.org, jean-philippe@linaro.org,
 jonathan.cameron@huawei.com, lpieralisi@kernel.org,
 peter.maydell@linaro.org, richard.henderson@linaro.org,
 imammedo@redhat.com, armbru@redhat.com, andrew.jones@linux.dev,
 david@redhat.com, philmd@linaro.org, eric.auger@redhat.com,
 will@kernel.org, ardb@kernel.org, oliver.upton@linux.dev,
 pbonzini@redhat.com, gshan@redhat.com, rafael@kernel.org,
 borntraeger@linux.ibm.com, alex.bennee@linaro.org,
 gustavo.romero@linaro.org, npiggin@gmail.com, harshpb@linux.ibm.com,
 linux@armlinux.org.uk, darren@os.amperecomputing.com,
 ilkka@os.amperecomputing.com, vishnu@os.amperecomputing.com,
 gankulkarni@os.amperecomputing.com, karl.heubaum@oracle.com,
 miguel.luis@oracle.com, salil.mehta@opnsrc.net, zhukeqian1@huawei.com,
 wangxiongfeng2@huawei.com, wangyanan55@huawei.com, wangzhou1@hisilicon.com,
 linuxarm@huawei.com, jiakernel2@gmail.com, maobibo@loongson.cn,
 lixianglai@loongson.cn, shahuang@redhat.com, zhao1.liu@intel.com
Subject: [PATCH RFC V6 24/24] tcg: Defer TB flush for 'lazy realized' vCPUs on
 first region alloc
Date: Wed,  1 Oct 2025 01:01:27 +0000
Message-Id: <20251001010127.3092631-25-salil.mehta@opnsrc.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251001010127.3092631-1-salil.mehta@opnsrc.net>
References: <20251001010127.3092631-1-salil.mehta@opnsrc.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=salil.mehta@opnsrc.net; helo=mail-wr1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

From: Salil Mehta <salil.mehta@huawei.com>

The TCG code cache is split into regions shared by vCPUs under MTTCG. For
cold-boot (early realized) vCPUs, regions are sized/allocated during bring-up.
However, when a vCPU is *lazy_realized* (administratively "disabled" at boot
and realized later on demand), its TCGContext may fail the very first code
region allocation if the shared TB cache is saturated by already-running
vCPUs.

Flushing the TB cache is the right remediation, but `tb_flush()` must be
performed from the safe execution context (cpu_exec_loop()/tb_gen_code()).
This patch wires a deferred flush:

  * In `tcg_region_initial_alloc__locked()`, treat an initial allocation
    failure for a lazily realized vCPU as non-fatal: set `s->tbflush_pend`
    and return.

  * In `tcg_tb_alloc()`, if `s->tbflush_pend` is observed, clear it and
    return NULL so the caller performs a synchronous `tb_flush()` and then
    retries allocation.

This avoids hangs observed when a newly realized vCPU cannot obtain its first
region under TB-cache pressure, while keeping the flush at a safe point.

No change for cold-boot vCPUs and when accel ops is KVM.

In earlier series, this patch was with below named,
'tcg: Update tcg_register_thread() leg to handle region alloc for hotplugged vCPU'

Reported-by: Miguel Luis <miguel.luis@oracle.com>
Signed-off-by: Miguel Luis <miguel.luis@oracle.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 accel/tcg/tcg-accel-ops-mttcg.c |  2 +-
 accel/tcg/tcg-accel-ops-rr.c    |  2 +-
 hw/arm/virt.c                   |  5 +++++
 include/hw/core/cpu.h           |  1 +
 include/tcg/startup.h           |  6 ++++++
 include/tcg/tcg.h               |  1 +
 tcg/region.c                    | 16 ++++++++++++++++
 tcg/tcg.c                       | 19 ++++++++++++++++++-
 8 files changed, 49 insertions(+), 3 deletions(-)

diff --git a/accel/tcg/tcg-accel-ops-mttcg.c b/accel/tcg/tcg-accel-ops-mttcg.c
index 337b993d3d..cdb7345340 100644
--- a/accel/tcg/tcg-accel-ops-mttcg.c
+++ b/accel/tcg/tcg-accel-ops-mttcg.c
@@ -73,7 +73,7 @@ static void *mttcg_cpu_thread_fn(void *arg)
     force_rcu.notifier.notify = mttcg_force_rcu;
     force_rcu.cpu = cpu;
     rcu_add_force_rcu_notifier(&force_rcu.notifier);
-    tcg_register_thread();
+    tcg_register_thread(cpu);
 
     bql_lock();
     qemu_thread_get_self(cpu->thread);
diff --git a/accel/tcg/tcg-accel-ops-rr.c b/accel/tcg/tcg-accel-ops-rr.c
index 6eec5c9eee..18e713cada 100644
--- a/accel/tcg/tcg-accel-ops-rr.c
+++ b/accel/tcg/tcg-accel-ops-rr.c
@@ -186,7 +186,7 @@ static void *rr_cpu_thread_fn(void *arg)
     rcu_register_thread();
     force_rcu.notify = rr_force_rcu;
     rcu_add_force_rcu_notifier(&force_rcu);
-    tcg_register_thread();
+    tcg_register_thread(cpu);
 
     bql_lock();
     qemu_thread_get_self(cpu->thread);
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 5e02d6749d..254303727b 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -2482,6 +2482,11 @@ virt_setup_lazy_vcpu_realization(Object *cpuobj, VirtMachineState *vms)
     if (kvm_enabled()) {
         kvm_arm_create_host_vcpu(ARM_CPU(cpuobj));
     }
+
+    /* we may have to nuke the TB cache */
+    if (tcg_enabled()) {
+        CPU(cpuobj)->lazy_realized = true;
+    }
 }
 
 static void machvirt_init(MachineState *machine)
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index c9ce9bbdaf..c2d45fb494 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -486,6 +486,7 @@ struct CPUState {
     bool stop;
     bool stopped;
     bool parked;
+    bool lazy_realized; /* realized after machine init (lazy realization) */
 
     /* Should CPU start in powered-off state? */
     bool start_powered_off;
diff --git a/include/tcg/startup.h b/include/tcg/startup.h
index 95f574af2b..f9126bb0bd 100644
--- a/include/tcg/startup.h
+++ b/include/tcg/startup.h
@@ -25,6 +25,8 @@
 #ifndef TCG_STARTUP_H
 #define TCG_STARTUP_H
 
+#include "hw/core/cpu.h"
+
 /**
  * tcg_init: Initialize the TCG runtime
  * @tb_size: translation buffer size
@@ -43,7 +45,11 @@ void tcg_init(size_t tb_size, int splitwx, unsigned max_threads);
  * accelerator's init_machine() method) must register with this
  * function before initiating translation.
  */
+#ifdef CONFIG_USER_ONLY
 void tcg_register_thread(void);
+#else
+void tcg_register_thread(CPUState *cpu);
+#endif
 
 /**
  * tcg_prologue_init(): Generate the code for the TCG prologue
diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index a6d9aa50d4..e197ee03c0 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -396,6 +396,7 @@ struct TCGContext {
 
     /* Track which vCPU triggers events */
     CPUState *cpu;                      /* *_trans */
+    bool tbflush_pend; /* TB flush pending due to lazy vCPU realization */
 
     /* These structures are private to tcg-target.c.inc.  */
     QSIMPLEQ_HEAD(, TCGLabelQemuLdst) ldst_labels;
diff --git a/tcg/region.c b/tcg/region.c
index 7ea0b37a84..23635e0194 100644
--- a/tcg/region.c
+++ b/tcg/region.c
@@ -393,6 +393,22 @@ bool tcg_region_alloc(TCGContext *s)
 static void tcg_region_initial_alloc__locked(TCGContext *s)
 {
     bool err = tcg_region_alloc__locked(s);
+
+    /*
+     * Lazily realized vCPUs (administratively "disabled" at boot and realized
+     * later on demand) may initially fail to obtain even a single code region
+     * if the shared TB cache is under pressure from already running vCPUs.
+     *
+     * Treat this first-allocation failure as non-fatal: mark this TCGContext
+     * to request a TB cache flush and return. The flush is performed later,
+     * synchronously in the vCPU execution path (cpu_exec_loop()/tb_gen_code()),
+     * which is the safe place for tb_flush().
+     */
+    if (err && s->cpu && s->cpu->lazy_realized) {
+        s->tbflush_pend = true;
+        return;
+    }
+
     g_assert(!err);
 }
 
diff --git a/tcg/tcg.c b/tcg/tcg.c
index afac55a203..5867952ae7 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1285,12 +1285,14 @@ void tcg_register_thread(void)
     tcg_ctx = &tcg_init_ctx;
 }
 #else
-void tcg_register_thread(void)
+void tcg_register_thread(CPUState *cpu)
 {
     TCGContext *s = g_malloc(sizeof(*s));
     unsigned int i, n;
 
     *s = tcg_init_ctx;
+     s->cpu = cpu;
+     s->tbflush_pend = false;
 
     /* Relink mem_base.  */
     for (i = 0, n = tcg_init_ctx.nb_globals; i < n; ++i) {
@@ -1871,6 +1873,21 @@ TranslationBlock *tcg_tb_alloc(TCGContext *s)
     TranslationBlock *tb;
     void *next;
 
+    /*
+     * Lazy realization:
+     * A vCPU that was realized after machine init may have failed its first
+     * code-region allocation (see tcg_region_initial_alloc__locked()) and
+     * requested a deferred TB-cache flush by setting s->tbflush_pend.
+     *
+     * If the flag is set, do not attempt allocation here. Clear the flag and
+     * return NULL so the caller (tb_gen_code()/cpu_exec_loop()) can perform a
+     * safe tb_flush() and then retry TB allocation.
+     */
+    if (s->tbflush_pend) {
+        s->tbflush_pend = false;
+        return NULL;
+    }
+
  retry:
     tb = (void *)ROUND_UP((uintptr_t)s->code_gen_ptr, align);
     next = (void *)ROUND_UP((uintptr_t)(tb + 1), align);
-- 
2.34.1


