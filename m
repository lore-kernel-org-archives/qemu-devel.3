Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E063109C033
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2026 16:46:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5RMN-00057D-67; Wed, 25 Mar 2026 12:45:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w5RMD-0004uY-IV
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 12:45:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w5RM9-0004eu-5l
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 12:45:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774457119;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hdngwf9IxLRWLplWOn/lnOHhD3mhIw/hOaoolbTXnJo=;
 b=UQaxRUGii21usLh1xL51Z8d/IePm0jKXHmOWEjxbqm4+g8Gv3do21Ff+JuUVsiNqoWHnm0
 5toquzYhmtG6ytvx/4UYZoIVnW9LxBuf7NqdIHQCYeBSoMPcjdCJDtUlFFKOWsE/fF1cDo
 irEbIfAD4KTTbFW/iIlrw6XXLBbXiVU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-318-3WSHYkn6OHq158K6NRzR-g-1; Wed, 25 Mar 2026 12:45:18 -0400
X-MC-Unique: 3WSHYkn6OHq158K6NRzR-g-1
X-Mimecast-MFC-AGG-ID: 3WSHYkn6OHq158K6NRzR-g_1774457117
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-48531e8ae62so1942665e9.3
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2026 09:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774457116; x=1775061916; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hdngwf9IxLRWLplWOn/lnOHhD3mhIw/hOaoolbTXnJo=;
 b=RcJPCnnsGmJMAON5WTi0mBx/cKZD6rH8n/9E6NAH+FhW8A721/FdO3/TDlEkmLAwUU
 sRTL7Ak+jlquoWw85L7T/22bf/mjgwEOmbAuborI5XjXfO1MvrELiT6tiRpW7I0pbc4m
 B2FrSRMz9UVrv3aHS+IAFOL6WvaPnDMdoE9TENLb7lP5kW4DMb2XEbMzJUDmrln0lpF3
 afjVPKzOrg7S1nUL4WacP6LtZ4iRBU2BNL9sft+3RQdr+s7O2jlzBilaZak4r1ayMeVn
 ohDlbZksVjIafpiWh/ydCsLG0V5ZCsBuBhQt+W5ymiktSl2Cj8+2EU6T14EO0QJeLsC6
 zjkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774457116; x=1775061916;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hdngwf9IxLRWLplWOn/lnOHhD3mhIw/hOaoolbTXnJo=;
 b=SoOH3CVGl9CfNOk8uX0KqSTYL918fZ1jLcrL6NspqaY6iaXYItjq+7ogTZyxMpoZtm
 L8AZ6ma0Gyh9YZHO8xpoNkSZvPQ+UaPqNMJFk9yvUWu+qvy5F5ld6KRU3C6Q/q2kIb0T
 Uz4ML+tFN18Qcd2i9Fap+dvwhFx4ZtXwqvE444qwmJqK7a1XFWMhegjva9Y5RHUDdN66
 7JswkCI3KZoFswFpPprCQby1AAmlAwVSS1GKkdTMn2V8kj8ltriNbslDtVZ6AghlWz1D
 rpxLXAh5T4B/LLebFzXjQGY1W5lgGTQI/ycH7a6HTGykUvAExfkmeSKqAw1W5WDwx2FJ
 E18Q==
X-Gm-Message-State: AOJu0YybyGpWSUmZONmXW5qb8v7vY2bO1x1Z3i4GjuVEP9Y9vRqFipDf
 mocxUEhZgyNRO1RhrfkP7xfNoNXQtQ2oLhgDemyX06DCyoyzlUww9icIn+vjmbqk4jGVoq2qWH9
 byDPzyQxB8HcrbpUGvhgBQTEfZc2VAocII/3SsGOLr0CYFrzc5YHnSFrJ92uX+8jAWd+93syDVP
 9UtZ1aivxg/76Tb86QV84umtXVG1jHRauf86rj3jzp
X-Gm-Gg: ATEYQzwPWNoh2a5nJyDB00WdRC5XsvXHD9mSpSwRUPynq21Kea0gjm7wPVVA8lfxFpA
 dloOgI0JsbQhxTapOSDknA021Rdupmx5ExhOPINR1nWdl6Z/207ZjBVrbqbUabx3/XxkdzG/UKX
 SmszO3fRibsWtBycRypn2fSTkVZz/N+hHVqamUbb2VWTztSo5Jyj7PPM6QJnuchLkcg75fIJ/n/
 U2X9FFwPuciE8xrGMaEHwarLdi4Nz+hxNdINKhyqwJrPaO+3U6CtTzKdsHl54GVFuYpqeochr6k
 5iC1jPXivotzAfTLFW4RePAsQ5m1PrVj8DwL0VrCtyLdtghKNrBODueooAwkI26PvfwQt+vq7oe
 jWNdZPo35ro969jWzbBn8HJNM7790fAN8kUZet9Sq9amehY8hF9b7EyIR6xBfkoZ8yK5A8bwqEn
 b04I89tQtl9tUGZPI988eZ5HWe
X-Received: by 2002:a05:600c:4f48:b0:485:3d00:efd with SMTP id
 5b1f17b1804b1-48715fbfc42mr67524635e9.7.1774457116122; 
 Wed, 25 Mar 2026 09:45:16 -0700 (PDT)
X-Received: by 2002:a05:600c:4f48:b0:485:3d00:efd with SMTP id
 5b1f17b1804b1-48715fbfc42mr67523955e9.7.1774457115522; 
 Wed, 25 Mar 2026 09:45:15 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b9192e3f9sm1200821f8f.7.2026.03.25.09.45.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2026 09:45:12 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PULL 11/19] target/i386: emulate: indirect access to CRs
Date: Wed, 25 Mar 2026 17:44:45 +0100
Message-ID: <20260325164453.72127-12-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260325164453.72127-1-pbonzini@redhat.com>
References: <20260325164453.72127-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

From: Mohamed Mediouni <mohamed@unpredictable.fr>

Prepare to have on-demand fetch of registers from the backend during
faults.

For x86_64 macOS, copy the function there too.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Link: https://lore.kernel.org/r/20260324151323.74473-9-mohamed@unpredictable.fr
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/emulate/x86_emu.h     |  3 +++
 target/i386/emulate/x86_helpers.c | 27 ++++++++++++++++-----------
 target/i386/emulate/x86_mmu.c     |  8 ++------
 target/i386/hvf/x86.c             | 11 +++++++++++
 4 files changed, 32 insertions(+), 17 deletions(-)

diff --git a/target/i386/emulate/x86_emu.h b/target/i386/emulate/x86_emu.h
index 4ed970bd536..a8d4c93098d 100644
--- a/target/i386/emulate/x86_emu.h
+++ b/target/i386/emulate/x86_emu.h
@@ -28,6 +28,7 @@ struct x86_emul_ops {
     MMUTranslateResult (*mmu_gva_to_gpa) (CPUState *cpu, target_ulong gva, uint64_t *gpa, MMUTranslateFlags flags);
     void (*read_segment_descriptor)(CPUState *cpu, struct x86_segment_descriptor *desc,
                                     enum X86Seg seg);
+    target_ulong (*read_cr) (CPUState *cpu, int cr);
     void (*handle_io)(CPUState *cpu, uint16_t port, void *data, int direction,
                       int size, int count);
     void (*simulate_rdmsr)(CPUState *cs);
@@ -45,6 +46,8 @@ void x86_emul_raise_exception(CPUX86State *env, int exception_index, int error_c
 
 target_ulong read_reg(CPUX86State *env, int reg, int size);
 void write_reg(CPUX86State *env, int reg, target_ulong val, int size);
+target_ulong x86_read_cr(CPUState *cpu, int cr);
+
 target_ulong read_val_from_reg(void *reg_ptr, int size);
 void write_val_to_reg(void *reg_ptr, target_ulong val, int size);
 bool write_val_ext(CPUX86State *env, struct x86_decode_op *decode, target_ulong val, int size);
diff --git a/target/i386/emulate/x86_helpers.c b/target/i386/emulate/x86_helpers.c
index ebbf40f2b05..c817015ef92 100644
--- a/target/i386/emulate/x86_helpers.c
+++ b/target/i386/emulate/x86_helpers.c
@@ -206,15 +206,26 @@ bool x86_read_call_gate(CPUState *cpu, struct x86_call_gate *idt_desc,
     return true;
 }
 
-bool x86_is_protected(CPUState *cpu)
+target_ulong x86_read_cr(CPUState *cpu, int cr)
 {
     X86CPU *x86_cpu = X86_CPU(cpu);
     CPUX86State *env = &x86_cpu->env;
-    uint64_t cr0 = env->cr[0];
+
+    if (emul_ops->read_cr) {
+        return emul_ops->read_cr(cpu, cr);
+    }
+    return env->cr[cr];
+}
+
+bool x86_is_protected(CPUState *cpu)
+{
+    uint64_t cr0;
+
     if (emul_ops->is_protected_mode) {
         return emul_ops->is_protected_mode(cpu);
     }
 
+    cr0 = x86_read_cr(cpu, 0);
     return cr0 & CR0_PE_MASK;
 }
 
@@ -245,9 +256,7 @@ bool x86_is_long_mode(CPUState *cpu)
 
 bool x86_is_la57(CPUState *cpu)
 {
-    X86CPU *x86_cpu = X86_CPU(cpu);
-    CPUX86State *env = &x86_cpu->env;
-    uint64_t is_la57 = env->cr[4] & CR4_LA57_MASK;
+    uint64_t is_la57 = x86_read_cr(cpu, 4) & CR4_LA57_MASK;
     return is_la57;
 }
 
@@ -259,18 +268,14 @@ bool x86_is_long64_mode(CPUState *cpu)
 
 bool x86_is_paging_mode(CPUState *cpu)
 {
-    X86CPU *x86_cpu = X86_CPU(cpu);
-    CPUX86State *env = &x86_cpu->env;
-    uint64_t cr0 = env->cr[0];
+    uint64_t cr0 = x86_read_cr(cpu, 0);
 
     return cr0 & CR0_PG_MASK;
 }
 
 bool x86_is_pae_enabled(CPUState *cpu)
 {
-    X86CPU *x86_cpu = X86_CPU(cpu);
-    CPUX86State *env = &x86_cpu->env;
-    uint64_t cr4 = env->cr[4];
+    uint64_t cr4 = x86_read_cr(cpu, 4);
 
     return cr4 & CR4_PAE_MASK;
 }
diff --git a/target/i386/emulate/x86_mmu.c b/target/i386/emulate/x86_mmu.c
index 670939acdba..ba0ebe4268d 100644
--- a/target/i386/emulate/x86_mmu.c
+++ b/target/i386/emulate/x86_mmu.c
@@ -114,8 +114,6 @@ static bool get_pt_entry(CPUState *cpu, struct gpt_translation *pt,
 static MMUTranslateResult test_pt_entry(CPUState *cpu, struct gpt_translation *pt,
                           int level, int *largeness, bool pae, MMUTranslateFlags flags)
 {
-    X86CPU *x86_cpu = X86_CPU(cpu);
-    CPUX86State *env = &x86_cpu->env;
     uint64_t pte = pt->pte[level];
 
     if (!pte_present(pte)) {
@@ -130,7 +128,7 @@ static MMUTranslateResult test_pt_entry(CPUState *cpu, struct gpt_translation *p
         *largeness = level;
     }
 
-    uint32_t cr0 = env->cr[0];
+    uint32_t cr0 = x86_read_cr(cpu, 0);
     /* check protection */
     if (cr0 & CR0_WP_MASK) {
         if (mmu_validate_write(flags) && !pte_write_access(pte)) {
@@ -184,11 +182,9 @@ static inline uint64_t large_page_gpa(struct gpt_translation *pt, bool pae,
 static MMUTranslateResult walk_gpt(CPUState *cpu, target_ulong addr, MMUTranslateFlags flags,
                      struct gpt_translation *pt, bool pae)
 {
-    X86CPU *x86_cpu = X86_CPU(cpu);
-    CPUX86State *env = &x86_cpu->env;
     int top_level, level;
     int largeness = 0;
-    target_ulong cr3 = env->cr[3];
+    target_ulong cr3 = x86_read_cr(cpu, 3);
     uint64_t page_mask = pae ? PAE_PTE_PAGE_MASK : LEGACY_PTE_PAGE_MASK;
     MMUTranslateResult res;
     
diff --git a/target/i386/hvf/x86.c b/target/i386/hvf/x86.c
index 7fe710aca3b..bae2f30fa28 100644
--- a/target/i386/hvf/x86.c
+++ b/target/i386/hvf/x86.c
@@ -143,6 +143,17 @@ bool x86_is_la57(CPUState *cpu)
     return false;
 }
 
+target_ulong x86_read_cr(CPUState *cpu, int cr)
+{
+    X86CPU *x86_cpu = X86_CPU(cpu);
+    CPUX86State *env = &x86_cpu->env;
+
+    if (emul_ops->read_cr) {
+        return emul_ops->read_cr(cpu, cr);
+    }
+    return env->cr[cr];
+}
+
 bool x86_is_long64_mode(CPUState *cpu)
 {
     struct vmx_segment desc;
-- 
2.53.0


