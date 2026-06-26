Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93CA2CDE008
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 10:20:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wd3ep-0002Pl-TZ; Fri, 26 Jun 2026 06:19:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wd3en-00029F-TE
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 06:19:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wd3el-0005PQ-RJ
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 06:19:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782469171;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xjXgKIQvuuURFsFo6ZsMyVnrW+K5pqB6u7N2zlmowN4=;
 b=YgUQNyEC+1GsAboSmbdf2I1K15GfLrrmCacLS2S+OJcE7Oc52g9yR5J9kQIpOlTkuNejP5
 58Vld5Ai7+iPqiBKdcp+8dlLi4Ucl9XSVUpQ+OEQhKK8iKaiwJ4MGlzs/SZ83awyaRu8Tu
 pU8COuvI0FWxLo0VK6B3875CzvPIPLo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-gRs9yvj4PISvNcU168YRuw-1; Fri, 26 Jun 2026 06:19:29 -0400
X-MC-Unique: gRs9yvj4PISvNcU168YRuw-1
X-Mimecast-MFC-AGG-ID: gRs9yvj4PISvNcU168YRuw_1782469168
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4924d5231daso6079155e9.0
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 03:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782469168; x=1783073968; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xjXgKIQvuuURFsFo6ZsMyVnrW+K5pqB6u7N2zlmowN4=;
 b=WQCcQeRHGOVexs3A9ZuRS1QoP3WzkVcLp/Q/QT3ieJqqlw9KsD3icvlmCdHZJfxI5T
 C2r6k+c3tiOpA69piwWa9DLYM2YjHVI2uceHyb75YWQ+x0ZtQPmTdPQgfATBorrOUmrn
 k/ivUCXl88SCjkETtcFo2beCl8FG3RDdE3LT/FWsNjatyCDcoxOI1hc1ksRraF2MZKAi
 frghdKHWnb8inMNN2IGSUNY6G5tOLUWgDLGravAl/22QWNqXkkb7Loe7WcnwTxswAvjJ
 0F84piakoL5my+f2P0CPE4wA+lyfm7RPBkn5yyj9a6TObLo1V6AXRRq7oNzsr2UPRB+9
 laKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782469168; x=1783073968;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xjXgKIQvuuURFsFo6ZsMyVnrW+K5pqB6u7N2zlmowN4=;
 b=QrXsAeaH3ZtrE7oK2dhlfpaRX3C+mccd0o9+PeFun3qddM9JQI4dV7So/7zEo3nU6E
 T77bb8Pd47WIPc2TTYgC0NkxP7BSp5mi/lcZz+MbItSdHevol7ae/UcBrfrdbnRXdpxf
 Mc/wgNI9RASS/Jny5Dw5MVBOsknpsq4iHoAXYSZ43Bz8Q0LosOqP1t2j54gq4jiRMYmc
 cES6BBKUU8y+x4/exfT7IG01+Zz+IiZdzaLzh08mAQFdj97KNo9D/9HLlKakQEZ433L8
 ThmArMou71CgKBPgDnloNjLoKZdTYSI27DO8yktOgyKJMQbSCaSqs2pe2sQs/UmOwQFc
 eIqg==
X-Gm-Message-State: AOJu0YxjOD2BPvxP+z/NSUwN5pZIBHHcStdc0qzoAYDICdf0Zy3196gN
 PPmKkH7FV66CE5GBT3P0qZItmRBLQzfA93AHu9fAjOs84iMsUb5g+4MLbCPY5Od1poqkginFghQ
 Q5xKD9gbaMczatC9zfW50JCKkjfzDdJqB8gOHyQr9rm7ilRFHuFurhaIXkNBmGCWOeYTNl/SgQM
 UmxQ/ohQcVKg5xeMvi8gI0mbiSyBGqmn9qQQl4wirJ
X-Gm-Gg: AfdE7clOTee16MJmKKS2dKsbLj0L6uYF2jGoY00ME8kCyr8Bwe3+O6RQ97q12RRvhTO
 XlqItnsj1XCKPJqnkxFOA+RFENXnFFxEg8rhuM8nrd1lmYugFHkC/MvzqAoUigigORcLAG7Vpgb
 u6lhnK102mgVfL2jH8ab13H1q4O04vvsKfpSb8h2Q8JbjP2N7GMHlSN0cNxyxecBmR/nG8eEMbq
 4Z1XzvZX0EOgmjJIbln20UoRk54bz3jxlZoyS0VuhtfHqGkHOi/j1QAKOymXMBgtOOHNoakiRm/
 t3lM5+1WdkWSMnAaC3OtF+JhQztz45y4DF6c6O2u71wtJu0kwFFN9zqHbedl0r+YVt0R0B9LD6r
 inQW4mMHeI+88vqOTgpsPQ297AO55eUlNwi4DsaufQxfbPZixpIJcUvAyDAJ6ZsgEaYTQOpWz9y
 ikzdJZjrop2YqIMkuv
X-Received: by 2002:a05:600c:1d0e:b0:492:5bf9:cbbe with SMTP id
 5b1f17b1804b1-49266899d25mr93099825e9.23.1782469168085; 
 Fri, 26 Jun 2026 03:19:28 -0700 (PDT)
X-Received: by 2002:a05:600c:1d0e:b0:492:5bf9:cbbe with SMTP id
 5b1f17b1804b1-49266899d25mr93099175e9.23.1782469167543; 
 Fri, 26 Jun 2026 03:19:27 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.124.208])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4926c01de4fsm48657995e9.0.2026.06.26.03.19.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2026 03:19:25 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Doru=20Bl=C3=A2nzeanu?= <dblanzeanu@linux.microsoft.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PULL 36/45] target/i386/mshv: use the register page to get registers
Date: Fri, 26 Jun 2026 12:17:39 +0200
Message-ID: <20260626101748.1728079-37-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260626101748.1728079-1-pbonzini@redhat.com>
References: <20260626101748.1728079-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

From: Doru Blânzeanu <dblanzeanu@linux.microsoft.com>

Change the mshv_load_regs to use the register page when it is mmapped
and is valid.
Otherwise use the existing logic that uses ioctls to fetch registers.

When retrieving the special registers, there are some registers that are
not present in the register page: TR, LDTR, GDTR, IDTR, CR2, APIC_BASE.
For this ones we still need to use ioctls to correctly fetch.

Signed-off-by: Doru Blânzeanu <dblanzeanu@linux.microsoft.com>
Reviewed-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Link: https://lore.kernel.org/r/20260428135053.251200-6-dblanzeanu@linux.microsoft.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/mshv/mshv-cpu.c | 117 ++++++++++++++++++++++++++++++++++++
 1 file changed, 117 insertions(+)

diff --git a/target/i386/mshv/mshv-cpu.c b/target/i386/mshv/mshv-cpu.c
index 67dfb3c42ab..ed78fa09934 100644
--- a/target/i386/mshv/mshv-cpu.c
+++ b/target/i386/mshv/mshv-cpu.c
@@ -270,6 +270,15 @@ static int get_xc_reg(CPUState *cpu)
     return 0;
 }
 
+static enum hv_register_name NON_VP_PAGE_REGISTER_NAMES[6] = {
+    HV_X64_REGISTER_TR,
+    HV_X64_REGISTER_LDTR,
+    HV_X64_REGISTER_GDTR,
+    HV_X64_REGISTER_IDTR,
+    HV_X64_REGISTER_CR2,
+    HV_X64_REGISTER_APIC_BASE,
+};
+
 static int translate_gva(const CPUState *cpu, uint64_t gva, uint64_t *gpa,
                          uint64_t flags)
 {
@@ -570,6 +579,106 @@ static void populate_special_regs(const hv_register_assoc *assocs,
     cpu_set_apic_base(x86cpu->apic_state, assocs[16].value.reg64);
 }
 
+static void mshv_get_standard_regs_vp_page(CPUState *cpu)
+{
+    X86CPU *x86cpu = X86_CPU(cpu);
+    CPUX86State *env = &x86cpu->env;
+
+    /* General Purpose Registers  */
+    env->regs[R_EAX] = env->regs_page->rax;
+    env->regs[R_EBX] = env->regs_page->rbx;
+    env->regs[R_ECX] = env->regs_page->rcx;
+    env->regs[R_EDX] = env->regs_page->rdx;
+    env->regs[R_ESI] = env->regs_page->rsi;
+    env->regs[R_EDI] = env->regs_page->rdi;
+    env->regs[R_ESP] = env->regs_page->rsp;
+    env->regs[R_EBP] = env->regs_page->rbp;
+    env->regs[R_R8]  = env->regs_page->r8;
+    env->regs[R_R9]  = env->regs_page->r9;
+    env->regs[R_R10] = env->regs_page->r10;
+    env->regs[R_R11] = env->regs_page->r11;
+    env->regs[R_R12] = env->regs_page->r12;
+    env->regs[R_R13] = env->regs_page->r13;
+    env->regs[R_R14] = env->regs_page->r14;
+    env->regs[R_R15] = env->regs_page->r15;
+
+    env->eip = env->regs_page->rip;
+    env->eflags = env->regs_page->rflags;
+    rflags_to_lflags(env);
+}
+
+static int mshv_get_special_regs_vp_page(CPUState *cpu)
+{
+    X86CPU *x86cpu = X86_CPU(cpu);
+    CPUX86State *env = &x86cpu->env;
+    struct hv_register_assoc assocs[ARRAY_SIZE(NON_VP_PAGE_REGISTER_NAMES)];
+    int ret;
+    size_t n_regs = ARRAY_SIZE(NON_VP_PAGE_REGISTER_NAMES);
+    hv_x64_segment_register seg;
+
+    /* Populate special registers that are in the VP register page */
+    env->cr[0] = env->regs_page->cr0;
+    env->cr[3] = env->regs_page->cr3;
+    env->cr[4] = env->regs_page->cr4;
+    env->efer = env->regs_page->efer;
+    cpu_set_apic_tpr(x86cpu->apic_state, env->regs_page->cr8);
+
+    /* Segment Registers - copy from packed struct to avoid unaligned access */
+    memcpy(&seg, &env->regs_page->es, sizeof(hv_x64_segment_register));
+    populate_segment_reg(&seg, &env->segs[R_ES]);
+    memcpy(&seg, &env->regs_page->cs, sizeof(hv_x64_segment_register));
+    populate_segment_reg(&seg, &env->segs[R_CS]);
+    memcpy(&seg, &env->regs_page->ss, sizeof(hv_x64_segment_register));
+    populate_segment_reg(&seg, &env->segs[R_SS]);
+    memcpy(&seg, &env->regs_page->ds, sizeof(hv_x64_segment_register));
+    populate_segment_reg(&seg, &env->segs[R_DS]);
+    memcpy(&seg, &env->regs_page->fs, sizeof(hv_x64_segment_register));
+    populate_segment_reg(&seg, &env->segs[R_FS]);
+    memcpy(&seg, &env->regs_page->gs, sizeof(hv_x64_segment_register));
+    populate_segment_reg(&seg, &env->segs[R_GS]);
+
+    /* The rest of the special registers that are not in the VP register page */
+    for (size_t i = 0; i < n_regs; i++) {
+        assocs[i].name = NON_VP_PAGE_REGISTER_NAMES[i];
+    }
+
+    ret = mshv_get_generic_regs(cpu, assocs, n_regs);
+    if (ret < 0) {
+        error_report("failed to get non-vp-page special registers");
+        return -1;
+    }
+
+    /* Non-VP page registers - TR, LDTR, GDTR, IDTR, CR2, APIC_BASE */
+    populate_segment_reg(&assocs[0].value.segment, &env->tr);
+    populate_segment_reg(&assocs[1].value.segment, &env->ldt);
+
+    populate_table_reg(&assocs[2].value.table, &env->gdt);
+    populate_table_reg(&assocs[3].value.table, &env->idt);
+    env->cr[2] = assocs[4].value.reg64;
+
+    cpu_set_apic_base(x86cpu->apic_state, assocs[5].value.reg64);
+
+    return ret;
+}
+
+static int mshv_get_registers_vp_page(CPUState *cpu)
+{
+    int ret;
+
+    /* General Purpose Registers  */
+    mshv_get_standard_regs_vp_page(cpu);
+
+    /* Special Registers - makes a hypercall */
+    ret = mshv_get_special_regs_vp_page(cpu);
+    if (ret < 0) {
+        error_report("failed to get special registers for vp page");
+        return -1;
+    }
+
+    return 0;
+}
+
+
 static int get_special_regs(CPUState *cpu)
 {
     struct hv_register_assoc assocs[ARRAY_SIZE(SPECIAL_REGISTER_NAMES)];
@@ -592,8 +701,16 @@ static int get_special_regs(CPUState *cpu)
 
 static int load_regs(CPUState *cpu)
 {
+    X86CPU *x86_cpu = X86_CPU(cpu);
+    CPUX86State *env = &x86_cpu->env;
     int ret;
 
+    /* Use register vp page to optimize registers access */
+    if (env->regs_page && env->regs_page->isvalid != 0) {
+        ret = mshv_get_registers_vp_page(cpu);
+        return ret;
+    }
+
     ret = get_standard_regs(cpu);
     if (ret < 0) {
         return ret;
-- 
2.54.0


