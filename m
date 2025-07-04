Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8B69C83F03
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 10:20:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXdSQ-0006KH-MQ; Fri, 04 Jul 2025 06:15:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXdSC-0006HO-CW
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 06:15:37 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXdSA-0006gj-3M
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 06:15:35 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3a52874d593so625291f8f.0
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 03:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751624132; x=1752228932; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=eEidoVZ/Dc4n7iZhpqZa1LMyUM4NhBQ2iC14GxUB49g=;
 b=UTdwjtIsjya1X1BPjAeR1RcEvTGsEAPF7N+fsiiir+uON5d6eMtIh6zd77CelKgA2p
 4ZV7C+/S+RsC8pfluMIattz/3H+Dao/+TORjexZZUwu60dVptLL7hFBnoMIEW3IBqoMl
 51F99fVuKcWcqJvQphQ74pp4F3Gcu8JRtC2PrSHqHeq6jxw83D0gmZIHX9J6JU8b0fGR
 neYgegtE88FK4X1d46EO6iLfGDiBZSm2mQxtuW/MN6ypSe0qCfdmWV+2Nnrk9gvCFa6M
 PVNcimVA0LzDS3SKXgcTbT9pTeuiJY2ZPjWst0OuCKfBM81UgQeaRYJQxP2dTU9lPpcw
 GBvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751624132; x=1752228932;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eEidoVZ/Dc4n7iZhpqZa1LMyUM4NhBQ2iC14GxUB49g=;
 b=shR0sghkehssQRAthaARPrnXmonq3gmRowi+twi/Cz/TGeaaruUsDnVVihp35WC4eS
 3XiPf537tJmQPg1BAEZT05I1f5OROzcw2Rn2MNpB1/tBihVNJQV8vLaMsywbPNRJWUQe
 20EzF9qgHQKf7bJpMfi4FsdNV3FkljzmAsH7+GbjZfj61ARfkXtUnNOiz2cfdZd2kqGn
 gEMRdptZCgMdWV+95vHHvw4yjGCHWqKhy76xid/vvOYdfrSofyYPirhrHyagaAHq/k1u
 uKLjEN/zUd7TvFp7FNtgdRSgEEOF1kvYMcFFDzFJx03oSj5kDTWkZQQfjWY8iswRNZpW
 RBaQ==
X-Gm-Message-State: AOJu0YxfebOMkFFgcgUt1Enq8fr0RWzUs1EEW8HxBRTzUliqS8sVd2mh
 RLz4Y1fWNETfVRxbHvfZJVuqEKxlonNyGp7jTmos1MEghnJfNv89VujEmchEapvjC1kXwj+Av1C
 kKm45BIg=
X-Gm-Gg: ASbGnctuGIBkTYrdTVBtNP/NsiRztL/sljZw5DZ9zM8vsOLlQn3bT/YnW+SjiHK+pzi
 NKzNJKKcckYwYplAkAkByZ7H8W8+boBAYS8ME6QUkOQ4Un2FMT0cnZF2I2u8v8C78M577FRRGh5
 /VTOahUjodAucKtFgETQRt2Dg0wcd+gEBbV5S4J3m4M8ygbWnX5AxShCn9lF4+Yl3RQk+ohKKVX
 jQJjzszP7GcMYF2dKOeyrpn9E2CKZmaCGdI6h2pFQM+w4HMZW1tP5C7pxusSyrXBecJpRdEWUoR
 xnFIo1BIzV2yKp2JACjMLCmUZ9Yv2Pm2uhKTkC/n5O534nf6gXpLJ5QEKbXCqSpTP1DKi6dMBCT
 qBcbziax41DKNL/O82UTushPY2FqOM/3nQAus
X-Google-Smtp-Source: AGHT+IHHxRXWTZ2lR1sFbL2iReoXvIxP5CnW+EOO/roWHDEbc1yTObIVtQUdYyLKl2UzUlCXcW83Ng==
X-Received: by 2002:a05:6000:4287:b0:3a5:2cf3:d6ab with SMTP id
 ffacd0b85a97d-3b49661d6a6mr1737608f8f.39.1751624131663; 
 Fri, 04 Jul 2025 03:15:31 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454b1628ebcsm22590175e9.14.2025.07.04.03.15.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 04 Jul 2025 03:15:31 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 12/31] accel/hvf: Replace @dirty field by generic
 CPUState::vcpu_dirty field
Date: Fri,  4 Jul 2025 12:14:13 +0200
Message-ID: <20250704101433.8813-13-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250704101433.8813-1-philmd@linaro.org>
References: <20250704101433.8813-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

No need for accel-specific @dirty field when we have
a generic one in CPUState.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Message-Id: <20250703173248.44995-19-philmd@linaro.org>
---
 include/system/hvf_int.h  |  1 -
 accel/hvf/hvf-accel-ops.c | 10 +++++-----
 target/arm/hvf/hvf.c      |  4 ++--
 target/i386/hvf/hvf.c     |  4 ++--
 target/i386/hvf/x86hvf.c  |  2 +-
 5 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/include/system/hvf_int.h b/include/system/hvf_int.h
index 4f6db40c34e..5150c7dd9c9 100644
--- a/include/system/hvf_int.h
+++ b/include/system/hvf_int.h
@@ -62,7 +62,6 @@ struct AccelCPUState {
     bool vtimer_masked;
     sigset_t unblock_ipi_mask;
     bool guest_debug_enabled;
-    bool dirty;
 };
 
 void assert_hvf_ok_impl(hv_return_t ret, const char *file, unsigned int line,
diff --git a/accel/hvf/hvf-accel-ops.c b/accel/hvf/hvf-accel-ops.c
index 2c0715a17f7..395b5a8e1c0 100644
--- a/accel/hvf/hvf-accel-ops.c
+++ b/accel/hvf/hvf-accel-ops.c
@@ -79,15 +79,15 @@ hvf_slot *hvf_find_overlap_slot(uint64_t start, uint64_t size)
 
 static void do_hvf_cpu_synchronize_state(CPUState *cpu, run_on_cpu_data arg)
 {
-    if (!cpu->accel->dirty) {
+    if (!cpu->vcpu_dirty) {
         hvf_get_registers(cpu);
-        cpu->accel->dirty = true;
+        cpu->vcpu_dirty = true;
     }
 }
 
 static void hvf_cpu_synchronize_state(CPUState *cpu)
 {
-    if (!cpu->accel->dirty) {
+    if (!cpu->vcpu_dirty) {
         run_on_cpu(cpu, do_hvf_cpu_synchronize_state, RUN_ON_CPU_NULL);
     }
 }
@@ -96,7 +96,7 @@ static void do_hvf_cpu_synchronize_set_dirty(CPUState *cpu,
                                              run_on_cpu_data arg)
 {
     /* QEMU state is the reference, push it to HVF now and on next entry */
-    cpu->accel->dirty = true;
+    cpu->vcpu_dirty = true;
 }
 
 static void hvf_cpu_synchronize_post_reset(CPUState *cpu)
@@ -150,8 +150,8 @@ static int hvf_init_vcpu(CPUState *cpu)
 #else
     r = hv_vcpu_create(&cpu->accel->fd, HV_VCPU_DEFAULT);
 #endif
-    cpu->accel->dirty = true;
     assert_hvf_ok(r);
+    cpu->vcpu_dirty = true;
 
     cpu->accel->guest_debug_enabled = false;
 
diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 7b6d291e79c..c9cfcdc08bb 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -813,9 +813,9 @@ int hvf_put_registers(CPUState *cpu)
 
 static void flush_cpu_state(CPUState *cpu)
 {
-    if (cpu->accel->dirty) {
+    if (cpu->vcpu_dirty) {
         hvf_put_registers(cpu);
-        cpu->accel->dirty = false;
+        cpu->vcpu_dirty = false;
     }
 }
 
diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index 99e37a33e50..818b50419f4 100644
--- a/target/i386/hvf/hvf.c
+++ b/target/i386/hvf/hvf.c
@@ -733,9 +733,9 @@ int hvf_vcpu_exec(CPUState *cpu)
     }
 
     do {
-        if (cpu->accel->dirty) {
+        if (cpu->vcpu_dirty) {
             hvf_put_registers(cpu);
-            cpu->accel->dirty = false;
+            cpu->vcpu_dirty = false;
         }
 
         if (hvf_inject_interrupts(cpu)) {
diff --git a/target/i386/hvf/x86hvf.c b/target/i386/hvf/x86hvf.c
index 2057314892a..17fce1d3cdd 100644
--- a/target/i386/hvf/x86hvf.c
+++ b/target/i386/hvf/x86hvf.c
@@ -427,7 +427,7 @@ int hvf_process_events(CPUState *cs)
     X86CPU *cpu = X86_CPU(cs);
     CPUX86State *env = &cpu->env;
 
-    if (!cs->accel->dirty) {
+    if (!cs->vcpu_dirty) {
         /* light weight sync for CPU_INTERRUPT_HARD and IF_MASK */
         env->eflags = rreg(cs->accel->fd, HV_X86_RFLAGS);
     }
-- 
2.49.0


