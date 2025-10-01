Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEA57CCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 15:17:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3ySE-00044D-Qb; Wed, 01 Oct 2025 11:09:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3ySB-0003zM-2y
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 11:09:16 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3yQB-0000pB-Qf
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 11:09:13 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3ee1221ceaaso5882462f8f.3
 for <qemu-devel@nongnu.org>; Wed, 01 Oct 2025 08:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759331224; x=1759936024; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vgQ08Zha+dXWvHaKOFenolXy22Pp5EZeas9Q+KB02QI=;
 b=ekzFgUUrd7+S3S5edsupqlcrD2zz6ZIr4Lf2Qfmxb2J566SY6IxX8Uy/B2vCyCAt+P
 jSPTEN53sY+Z3D+v1YDIoG2F9MyCvG6ThVcVYxXLbJvtljFR4oGyBg6SJg0n8Hluks8u
 IwLEH2Tk6AvSi6nPww5vJb1UQdSfWeZoCnSQJ6TuSs6L0EGwOHeP14mDUVn649xxFFo5
 8Dlj6nWsNZ6gphdHwWK3d4Mj78I5Equm4UelAMB7zaOSNHO2YfEx1BLmi/c8o2A0vu4r
 6j78EP1JYAZkW0Z6SygXnPZxbJUDUd5ffaTLa1vUlmnCthod7YmBvgRy7gokucOQZFPc
 Xe/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759331224; x=1759936024;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vgQ08Zha+dXWvHaKOFenolXy22Pp5EZeas9Q+KB02QI=;
 b=RFzMqHOjoLIqM6EDFxERKdob8DD0CAaNWX87qSQDGg7c4MFUu1JnIWUWxNmTXy9H00
 OoQlWyecC6kZHunTaGk+ZmDBthWybloA2AGUJCknJQAf+3/DmlCaSBF464WEVH5tTHCR
 nCbeP/G+/nJpIxUjOuxTengHYih7Pm7mz5hyH+1MzWWyDLCoFjRkaY+ktzIwCjeQiz2k
 mkDLhHhzpzgj66zGFR611wNqc7p0GfzmOLffn8tO3ENFQbs2U3yN5Ib4EpKxa0qOuRhF
 R4cKUlWoXpRURgGDXsiW5hgM+xlR6RZ0i1O5FjOq3Ob2wqNfSIUbkoDx8e0Bv9mHql8y
 0oKg==
X-Gm-Message-State: AOJu0Yxol2f2syjuu/i1cg9gmpUMFe9FXdifilMjf1t19zQ/I0jkvJht
 iNavgZzCDcSqkzVt8yR7DZbKuYdax1afQV8mx6ahbtwCs3VuOlNps3eATQNByN+7jJwc1kXNzS9
 XXzsw8bskOQ==
X-Gm-Gg: ASbGncvuZXU9K5nzkTRp9j1rBHzco/XcxDU/ooSBAbGROOvkiwHKqoH1FmKS2iXF2sw
 +QCJIqQQShoOSCx217JCa/z14wwt8VpBmoYYVEYUGNPZnFebUwHAlF8QCr4vPuLG1QYkzPcQHQx
 sffXGWal9nl2unxz5j40130qcj3fUnhukAqYISfjPi6ZNXwB2KWiosK460kaDKMDxx2uA8+0RLS
 dgGdwYxOQkLVJEoXg24GdL9DTUa/hwqzWSxtgkYbhljzhdrWlLaZSZU8uG+728ovQR+yOtDpROp
 H3IWuRutuEvhHLS0XMgiw8xi1mGYB5+9r9JeLiqbXcEGu7Wf0ndTLFsnvkJ1l2/sAQRu88rhXqG
 sQlYAn7CwxiLiO6U5o9KDDXj3qwL4/5013ReagwYHL5je39g/RmWAz4go2hdq6jEQ6p1Z6GERkn
 79YjudK5wiFCbs0QwbiQGI
X-Google-Smtp-Source: AGHT+IEjdpZ2834rluXf5iwDh+H9vUyraYk5BuB0JLOoL1WZYeHIRGIrzHWJ1PTFW3scGqxOi3KLVQ==
X-Received: by 2002:a05:6000:2306:b0:3ec:42ad:597 with SMTP id
 ffacd0b85a97d-42557816db8mr2563412f8f.37.1759331223476; 
 Wed, 01 Oct 2025 08:07:03 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fb72facf9sm28220004f8f.13.2025.10.01.08.07.02
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 01 Oct 2025 08:07:02 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-s390x@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>, qemu-riscv@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH 18/22] target/s390x: Get cpu first addr space with
 cpu_get_address_space()
Date: Wed,  1 Oct 2025 17:05:23 +0200
Message-ID: <20251001150529.14122-19-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251001150529.14122-1-philmd@linaro.org>
References: <20251001150529.14122-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

In order to remove the convenient CPUState::as field, access
the vcpu first address space using the cpu_get_address_space()
helper.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/s390x/cpu-system.c      |  4 +++-
 target/s390x/mmu_helper.c      |  9 +++++----
 target/s390x/tcg/excp_helper.c | 10 ++++++----
 target/s390x/tcg/mem_helper.c  |  6 ++++--
 4 files changed, 18 insertions(+), 11 deletions(-)

diff --git a/target/s390x/cpu-system.c b/target/s390x/cpu-system.c
index f3a9ffb2a27..948dd7bc133 100644
--- a/target/s390x/cpu-system.c
+++ b/target/s390x/cpu-system.c
@@ -63,7 +63,9 @@ static void s390_cpu_load_normal(CPUState *s)
     uint64_t spsw;
 
     if (!s390_is_pv()) {
-        spsw = ldq_phys(s->as, 0);
+        AddressSpace *as = cpu_get_address_space(s, 0);
+
+        spsw = ldq_phys(as, 0);
         cpu->env.psw.mask = spsw & PSW_MASK_SHORT_CTRL;
         /*
          * Invert short psw indication, so SIE will report a specification
diff --git a/target/s390x/mmu_helper.c b/target/s390x/mmu_helper.c
index 4e2f31dc763..358d5463a0a 100644
--- a/target/s390x/mmu_helper.c
+++ b/target/s390x/mmu_helper.c
@@ -42,9 +42,10 @@ static void trigger_access_exception(CPUS390XState *env, uint32_t type,
     if (kvm_enabled()) {
         kvm_s390_access_exception(cpu, type, tec);
     } else {
-        CPUState *cs = env_cpu(env);
         if (type != PGM_ADDRESSING) {
-            stq_phys(cs->as, env->psa + offsetof(LowCore, trans_exc_code), tec);
+            AddressSpace *as = cpu_get_address_space(env_cpu(env), 0);
+
+            stq_phys(as, env->psa + offsetof(LowCore, trans_exc_code), tec);
         }
         trigger_pgm_exception(env, type);
     }
@@ -106,7 +107,7 @@ bool mmu_absolute_addr_valid(target_ulong addr, bool is_write)
 static inline bool read_table_entry(CPUS390XState *env, hwaddr gaddr,
                                     uint64_t *entry)
 {
-    CPUState *cs = env_cpu(env);
+    AddressSpace *as = cpu_get_address_space(env_cpu(env), 0);
 
     /*
      * According to the PoP, these table addresses are "unpredictably real
@@ -115,7 +116,7 @@ static inline bool read_table_entry(CPUS390XState *env, hwaddr gaddr,
      *
      * We treat them as absolute addresses and don't wrap them.
      */
-    if (unlikely(address_space_read(cs->as, gaddr, MEMTXATTRS_UNSPECIFIED,
+    if (unlikely(address_space_read(as, gaddr, MEMTXATTRS_UNSPECIFIED,
                                     entry, sizeof(*entry)) !=
                  MEMTX_OK)) {
         return false;
diff --git a/target/s390x/tcg/excp_helper.c b/target/s390x/tcg/excp_helper.c
index 4c7faeee82b..1db159be131 100644
--- a/target/s390x/tcg/excp_helper.c
+++ b/target/s390x/tcg/excp_helper.c
@@ -53,7 +53,7 @@ G_NORETURN void tcg_s390_data_exception(CPUS390XState *env, uint32_t dxc,
     g_assert(dxc <= 0xff);
 #if !defined(CONFIG_USER_ONLY)
     /* Store the DXC into the lowcore */
-    stl_phys(env_cpu(env)->as,
+    stl_phys(cpu_get_address_space(env_cpu(env), 0),
              env->psa + offsetof(LowCore, data_exc_code), dxc);
 #endif
 
@@ -70,7 +70,7 @@ G_NORETURN void tcg_s390_vector_exception(CPUS390XState *env, uint32_t vxc,
     g_assert(vxc <= 0xff);
 #if !defined(CONFIG_USER_ONLY)
     /* Always store the VXC into the lowcore, without AFP it is undefined */
-    stl_phys(env_cpu(env)->as,
+    stl_phys(cpu_get_address_space(env_cpu(env), 0),
              env->psa + offsetof(LowCore, data_exc_code), vxc);
 #endif
 
@@ -639,10 +639,12 @@ void monitor_event(CPUS390XState *env,
                    uint64_t monitor_code,
                    uint8_t monitor_class, uintptr_t ra)
 {
+    AddressSpace *as = cpu_get_address_space(env_cpu(env), 0);
+
     /* Store the Monitor Code and the Monitor Class Number into the lowcore */
-    stq_phys(env_cpu(env)->as,
+    stq_phys(as,
              env->psa + offsetof(LowCore, monitor_code), monitor_code);
-    stw_phys(env_cpu(env)->as,
+    stw_phys(as,
              env->psa + offsetof(LowCore, mon_class_num), monitor_class);
 
     tcg_s390_program_interrupt(env, PGM_MONITOR, ra);
diff --git a/target/s390x/tcg/mem_helper.c b/target/s390x/tcg/mem_helper.c
index f1acb1618f7..962f31d4cdb 100644
--- a/target/s390x/tcg/mem_helper.c
+++ b/target/s390x/tcg/mem_helper.c
@@ -957,12 +957,14 @@ uint32_t HELPER(mvpg)(CPUS390XState *env, uint64_t r0, uint32_t r1, uint32_t r2)
     return 0; /* data moved */
 inject_exc:
 #if !defined(CONFIG_USER_ONLY)
+    AddressSpace *as = cpu_get_address_space(env_cpu(env), 0);
+
     if (exc != PGM_ADDRESSING) {
-        stq_phys(env_cpu(env)->as, env->psa + offsetof(LowCore, trans_exc_code),
+        stq_phys(as, env->psa + offsetof(LowCore, trans_exc_code),
                  env->tlb_fill_tec);
     }
     if (exc == PGM_PAGE_TRANS) {
-        stb_phys(env_cpu(env)->as, env->psa + offsetof(LowCore, op_access_id),
+        stb_phys(as, env->psa + offsetof(LowCore, op_access_id),
                  r1 << 4 | r2);
     }
 #endif
-- 
2.51.0


