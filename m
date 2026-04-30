Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B005FF8873
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 17:33:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIV7s-0000Hh-Um; Thu, 30 Apr 2026 13:24:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wIV7p-0008Oo-LU
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 13:24:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wIV7n-0004tk-JS
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 13:24:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777569870;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XzkvcbiWP5MOo9vAJOAasVb4pDl+/ni1HFtBLV+7Xec=;
 b=C2TkZQK/mfkRvVsmr0rtNcePxPfy7//smITvkgVkHn2d2Zsz7QJZnX9qJh2SVqjzo7fhM/
 7T83YmDf+yY2oqSzOYKfANomxJ3rzZ5IhWMWCX1BaI1Ub03gkxd5LSWjKnJu8dWCFxJby7
 o9ezqCLVv49h2KEL1N8Zsdryiiw+fPI=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-691-lqc0s5CsN76z2e8VvrKgJg-1; Thu, 30 Apr 2026 13:24:29 -0400
X-MC-Unique: lqc0s5CsN76z2e8VvrKgJg-1
X-Mimecast-MFC-AGG-ID: lqc0s5CsN76z2e8VvrKgJg_1777569869
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-8eacc2008b2so224529285a.3
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 10:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1777569868; x=1778174668; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XzkvcbiWP5MOo9vAJOAasVb4pDl+/ni1HFtBLV+7Xec=;
 b=K83DfbDGqamy5DTRlrcN4nTz0sG0poo9A7/lDaOGr6CXzE+bBMQsuGuGcHDpIlg8qT
 5KiiFojU1E//qa/8nCo9jB1kDsZrzPU9a+ErQv4uKo7Ld3/lQZqtWbMJ4iyp2cf+Vic2
 kr+YcB8XqCK1ran0bCMZncIvQlGdO3LjPqjKx5ZS2w0nuYL9cnc5IRVyAlfa7p/jtwa/
 /ZF+uSSdohO8AA/RlHYwzMO3T2ZLb599eQmyKJdRkhgXLikHuam26jvEGyp+POd0AHPs
 kAZNxrHvymgn2n3pxI8fiYP1ysKf4NV+rT0b9ND4rgTFSjSy3awXUtQET0HsaEMNMz/V
 T5MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777569868; x=1778174668;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XzkvcbiWP5MOo9vAJOAasVb4pDl+/ni1HFtBLV+7Xec=;
 b=CSq+kahp4tYpHz8zzCfCk2maz+T+oUCMOA5HqTyNxihA69trYKbAMutuUv5vwd3zkC
 EgebeiuDEoLrnY3vjFicEd3nrk/XsSHxTk1y1VXKQpOw9BDeVgoc4cS6cbGhFoglPo5D
 JxiVozXRIpC4uciOawd8HMwphAgjJcil3AqzLNy2tqFLCEnjcM6+IFRMBORWJbscRfDa
 yHvkis9VN9bxhd9gPW/VpG3o+zhSBnga8vCey2CcAUYHF1XD9GGpNxjXX2a8piZgm1/Q
 a3JbKjpfGHN6EYW5JcyMmQITh4OXQ8omsS18AhdOCvK74BIA6coNUNs42Wv8uHN1HzSH
 tYow==
X-Gm-Message-State: AOJu0Yza/gp37T+kb/N/ikuizBkHtTYuKeGno0d5Ns8dTDuSKRvGClyr
 SWqqz4G70+9B+i3ZPsQC2lJxy+G+CYeBQjg53z2rVaRboOdxmv7ffZBH2/7Jwnf1RRTFvEngZdQ
 9hxZF2ElsYH/tUvRLYSD7b3sSodXmIhcvGrtz1IDVqGRoFt24XhC9+GDasQ9BxCytETWDA6+tQt
 Hb9J0ijk2yv3AWznuJMNu5MW/uD1QhbBJuseH1emlK
X-Gm-Gg: AeBDievHYP48hIhWGMDIUAEoa2nttakZ07b5t4hHg6Sez4QsKNpniuBZKz514/TgGbi
 v1Bb5jTaOD+YdmjqTSYi0UNvFRrD8Hx6AlSRu02fX4SD8wzTH3QYPjBoFA5sunR/ivCPehn5A8k
 ega6nbi3yBWR5BsXezvbm7W7zEYOI5WVD13HoCP3ruT7bam8VJfLidcDnXwqvCL8Fi65kEi9uCQ
 2/v5Li4WDlNNnH7Cat+Gx+LNWe9kTmWVug6kQNKn9FQxX/gYvQgzODo3HeITR5qxtpaIIMXDMGO
 DKa2kf6sAcWL+iYdYWyXaSRcAXjV33hJx2mZqqaYoFCb1vb5f2x8qvow4C7KIAqgN+pGEpOEhXs
 9+ACtkUW7rel3RYsYwAkSRXe68MqEUPGpe1jRcs73Wu+MIcQbfk0UpTLyGUf/oHovUFf9JWzpmo
 7ev/CJZOJcXrxtJnsjzedeyPtYKvfN3k7Zyws=
X-Received: by 2002:a05:620a:4107:b0:8cd:b317:a0b3 with SMTP id
 af79cd13be357-8fa86fa786fmr600894485a.24.1777569868299; 
 Thu, 30 Apr 2026 10:24:28 -0700 (PDT)
X-Received: by 2002:a05:620a:4107:b0:8cd:b317:a0b3 with SMTP id
 af79cd13be357-8fa86fa786fmr600886785a.24.1777569867674; 
 Thu, 30 Apr 2026 10:24:27 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8fbb430fed8sm22495485a.41.2026.04.30.10.24.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 10:24:26 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PULL 45/58] target: i386: HLT type that ignores EFLAGS.IF
Date: Thu, 30 Apr 2026 19:21:51 +0200
Message-ID: <20260430172204.1006673-46-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260430172204.1006673-1-pbonzini@redhat.com>
References: <20260430172204.1006673-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Mohamed Mediouni <mohamed@unpredictable.fr>

The TLFS says:

> A partition which possesses the AccessGuestIdleMsr privilege may trigger
> entry into the virtual processor idle sleep state through a read to the
> hypervisor-defined MSR HV_X64_MSR_GUEST_IDLE. The virtual processor will
> be woken when an interrupt arrives, regardless of whether the interrupt
> is enabled on the virtual processor or not.

Meanwhile, Windows 24H2+ calls this MSR anyway without the privilege being set.

Add the infrastructure to support it on the generic QEMU side.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Link: https://lore.kernel.org/r/20260422214225.2242-22-mohamed@unpredictable.fr
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.h           |  9 +++++++++
 target/i386/cpu.c           | 10 ++++------
 target/i386/hvf/x86hvf.c    |  4 ++--
 target/i386/whpx/whpx-all.c |  5 ++++-
 4 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 6401028e70d..c14237967b5 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -225,6 +225,7 @@ typedef enum X86Seg {
 #define HF2_NPT_SHIFT            6 /* Nested Paging enabled */
 #define HF2_IGNNE_SHIFT          7 /* Ignore CR0.NE=0 */
 #define HF2_VGIF_SHIFT           8 /* Can take VIRQ*/
+#define HF2_HYPERV_HLT_SHIFT     9 /* Hyper-V HV_X64_MSR_GUEST_IDLE */
 
 #define HF2_GIF_MASK            (1 << HF2_GIF_SHIFT)
 #define HF2_HIF_MASK            (1 << HF2_HIF_SHIFT)
@@ -235,6 +236,7 @@ typedef enum X86Seg {
 #define HF2_NPT_MASK            (1 << HF2_NPT_SHIFT)
 #define HF2_IGNNE_MASK          (1 << HF2_IGNNE_SHIFT)
 #define HF2_VGIF_MASK           (1 << HF2_VGIF_SHIFT)
+#define HF2_HYPERV_HLT_MASK     (1 << HF2_HYPERV_HLT_SHIFT)
 
 #define CR0_PE_SHIFT 0
 #define CR0_MP_SHIFT 1
@@ -3085,6 +3087,13 @@ static inline bool ctl_has_irq(CPUX86State *env)
     return (env->int_ctl & V_IRQ_MASK) && (int_prio >= tpr);
 }
 
+static inline bool x86_cpu_interrupts_enabled(CPUX86State *env)
+{
+    return ((env->eflags & IF_MASK) &&
+            !(env->hflags & HF_INHIBIT_IRQ_MASK)) ||
+           (env->hflags2 & HF2_HYPERV_HLT_MASK);
+}
+
 #if defined(TARGET_X86_64) && \
     defined(CONFIG_USER_ONLY) && \
     defined(CONFIG_LINUX)
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 7ea80f07c7c..efe7ba014d3 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -10617,14 +10617,12 @@ int x86_cpu_pending_interrupt(CPUState *cs, int interrupt_request)
                    (((env->hflags2 & HF2_VINTR_MASK) &&
                      (env->hflags2 & HF2_HIF_MASK)) ||
                     (!(env->hflags2 & HF2_VINTR_MASK) &&
-                     (env->eflags & IF_MASK &&
-                      !(env->hflags & HF_INHIBIT_IRQ_MASK))))) {
+                     x86_cpu_interrupts_enabled(env)))) {
             return CPU_INTERRUPT_HARD;
         } else if (env->hflags2 & HF2_VGIF_MASK) {
-            if((interrupt_request & CPU_INTERRUPT_VIRQ) &&
-                   (env->eflags & IF_MASK) &&
-                   !(env->hflags & HF_INHIBIT_IRQ_MASK)) {
-                        return CPU_INTERRUPT_VIRQ;
+            if ((interrupt_request & CPU_INTERRUPT_VIRQ) &&
+                x86_cpu_interrupts_enabled(env)) {
+                return CPU_INTERRUPT_VIRQ;
             }
         }
     }
diff --git a/target/i386/hvf/x86hvf.c b/target/i386/hvf/x86hvf.c
index bb480311b0f..16b810f3c2e 100644
--- a/target/i386/hvf/x86hvf.c
+++ b/target/i386/hvf/x86hvf.c
@@ -405,9 +405,9 @@ bool hvf_inject_interrupts(CPUState *cs)
         }
     }
 
-    if (!(env->hflags & HF_INHIBIT_IRQ_MASK) &&
+    if (x86_cpu_interrupts_enabled(env) &&
         cpu_test_interrupt(cs, CPU_INTERRUPT_HARD) &&
-        (env->eflags & IF_MASK) && !(info & VMCS_INTR_VALID)) {
+        !(info & VMCS_INTR_VALID)) {
         int line = cpu_get_pic_interrupt(env);
         cpu_reset_interrupt(cs, CPU_INTERRUPT_HARD);
         if (line >= 0) {
diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 11c9d8729fa..bc8d673c31a 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -1630,11 +1630,14 @@ static vaddr whpx_vcpu_get_pc(CPUState *cpu, bool exit_context_valid)
 
 static int whpx_handle_halt(CPUState *cpu)
 {
+    X86CPU *x86_cpu = X86_CPU(cpu);
+    CPUX86State *env = &x86_cpu->env;
+
     int ret = 0;
 
     bql_lock();
     if (!(cpu_test_interrupt(cpu, CPU_INTERRUPT_HARD) &&
-          (cpu_env(cpu)->eflags & IF_MASK)) &&
+          x86_cpu_interrupts_enabled(env)) &&
         !cpu_test_interrupt(cpu, CPU_INTERRUPT_NMI)) {
         cpu->exception_index = EXCP_HLT;
         cpu->halted = true;
-- 
2.54.0


