Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A703CCA470
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 07:53:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6lR4-0008WU-M5; Thu, 09 Oct 2025 03:51:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v6lR1-0008VT-7w
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 03:51:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v6lQt-0004R4-VE
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 03:51:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759996281;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=011a463v1dGyOKFiUiQNsEioHBlxgPsH4SJpYihX+aE=;
 b=FP272V5wBGyYUaMTHUA569UQJ4D8Zhr6Y3Wu1ri1IqnsM6qkT3KugQT2yySlUONhOU7fTt
 G+KmdYzDyAlMIS7oPt0AIlJwf8cfc2udxs7px2Qx+zdSYQyzOs51ok/YozO5a0kCBjILt3
 A/c442PhwLeW8kfh16D7uww7KQ2L86E=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-kuK76CgJMcGP2fzHODBE0g-1; Thu, 09 Oct 2025 03:51:15 -0400
X-MC-Unique: kuK76CgJMcGP2fzHODBE0g-1
X-Mimecast-MFC-AGG-ID: kuK76CgJMcGP2fzHODBE0g_1759996271
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3ee13e43dd9so433447f8f.1
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 00:51:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759996270; x=1760601070;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=011a463v1dGyOKFiUiQNsEioHBlxgPsH4SJpYihX+aE=;
 b=C58sz5brJQ7ya8jhYqyLthzLyEWTm6NMoPzPxTPcD7/MJRMMTNQklBZwFphQaonMR2
 LUHn314DRvqtc5f08jEZsT0WSuX/bhgneYDYHXpi3o4bEJ+rg47LgDsbMkTe6RYMB06j
 hOCltwlsIDJNhKfN1DSN8svKIvXvtZ7aKF6f5V/d57PF4HreXJp9pjL1B/nSp0J8eoCt
 mVxhBreIn8Dre7S8hcmJmwhrPWk7a48cXMQZXqGVxA6brcU9afFiJs0FMjmeqKCrmL9W
 6pA13HZxMSQOb+OqcwRHhsGaot6hpnjx7By5uRCpEQwOZ59/uQ2tjR/venNO2X7iW3iR
 u23A==
X-Gm-Message-State: AOJu0YxTZryvl18ntE+iBR9jqE+sAFc8vIGpOutJVfXkjOmqjZFk2EWM
 zg6C4GWTyk2YKG0m7LE+8d0KPFjNLcdMj3MNkF/jNzV17D2BdgMIKYLsDb7pGDbXom/Tu52+2sc
 R94baGDOpdvEntORiw8iJyCemcXHDqaiQxqvJge8klSNvilZqMYWgwxHZvG2wj+phpsKohNyCQc
 H+LpCgxRKQ3lqsTXG6WUqq87zbb64B3tAr7HGt3TuoYy0=
X-Gm-Gg: ASbGncvYsC3m5pLFJC7FkYlJSw53p6invLzYi0lsYYxzOP92kMaW+jJ1vXAlz4nqvge
 wXBNuYx5ucLn7ygPJ/6MW9mc7TCVX0YwYbV5kMm/jz7z5LLhxnyCmWWDO1iEdB8Zc8cd95SF8v3
 EYWeju+5GawU4ry8f9pVPM10zU8RJqqPllpE4roIlCTPh101WBs8y7svMoZy+Vx63RYPFjDEya3
 SF/ABEz3Eo/NEZJEcc927wYWj2cDS7R6m14LnAw3QcKI4jD5xgkOo6Z/Bw/NxiGKQ2cKgmizrIP
 N5oFD5yCyJDECM2Wkc7RFTgKwJXSY/eTJ/7Vl8LS2E2reYR+uuj9J1J488w4KXXEwAABq4nv4QN
 dK3f09ZuY7KH3tC3H8mUhYz0LZY9c7/LPvCNf5TouIktf+z5k
X-Received: by 2002:a05:6000:2289:b0:3ec:dd2f:eeb8 with SMTP id
 ffacd0b85a97d-4266e8e6e5bmr3986789f8f.62.1759996269836; 
 Thu, 09 Oct 2025 00:51:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEiVOo4Adpp90D8E3NCR16dXXLIfwzrHxaEqIGYPIOhHQ3slyw776nG3DTi9lHnbCxfH2RSVQ==
X-Received: by 2002:a05:6000:2289:b0:3ec:dd2f:eeb8 with SMTP id
 ffacd0b85a97d-4266e8e6e5bmr3986764f8f.62.1759996269330; 
 Thu, 09 Oct 2025 00:51:09 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.36.217])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fa9c07992sm82926675e9.5.2025.10.09.00.51.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Oct 2025 00:51:08 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Magnus Kulke <magnuskulke@linux.microsoft.com>
Subject: [PULL 19/35] target/i386/mshv: Implement mshv_store_regs()
Date: Thu,  9 Oct 2025 09:50:09 +0200
Message-ID: <20251009075026.505715-20-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251009075026.505715-1-pbonzini@redhat.com>
References: <20251009075026.505715-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Magnus Kulke <magnuskulke@linux.microsoft.com>

Add support for writing general-purpose registers to MSHV vCPUs
during initialization or migration using the MSHV register interface. A
generic set_register call is introduced to abstract the HV call over
the various register types.

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
Link: https://lore.kernel.org/r/20250916164847.77883-14-magnuskulke@linux.microsoft.com
[mshv.h/mshv_int.h split. - Paolo]
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/system/mshv.h       |   1 +
 include/system/mshv_int.h   |   2 +
 target/i386/mshv/mshv-cpu.c | 116 +++++++++++++++++++++++++++++++++++-
 3 files changed, 117 insertions(+), 2 deletions(-)

diff --git a/include/system/mshv.h b/include/system/mshv.h
index bbc42f4dc3a..8b1fc20c80d 100644
--- a/include/system/mshv.h
+++ b/include/system/mshv.h
@@ -18,6 +18,7 @@
 #include "qemu/accel.h"
 #include "hw/hyperv/hyperv-proto.h"
 #include "hw/hyperv/hvhdk.h"
+#include "hw/hyperv/hvgdk_mini.h"
 #include "qapi/qapi-types-common.h"
 #include "system/memory.h"
 #include "accel/accel-ops.h"
diff --git a/include/system/mshv_int.h b/include/system/mshv_int.h
index fb80f69772b..731841af929 100644
--- a/include/system/mshv_int.h
+++ b/include/system/mshv_int.h
@@ -61,6 +61,8 @@ void mshv_remove_vcpu(int vm_fd, int cpu_fd);
 int mshv_run_vcpu(int vm_fd, CPUState *cpu, hv_message *msg, MshvVmExit *exit);
 int mshv_load_regs(CPUState *cpu);
 int mshv_store_regs(CPUState *cpu);
+int mshv_set_generic_regs(const CPUState *cpu, const hv_register_assoc *assocs,
+                          size_t n_regs);
 int mshv_arch_put_registers(const CPUState *cpu);
 void mshv_arch_init_vcpu(CPUState *cpu);
 void mshv_arch_destroy_vcpu(CPUState *cpu);
diff --git a/target/i386/mshv/mshv-cpu.c b/target/i386/mshv/mshv-cpu.c
index 5069ab7a22f..9ead03ca2d8 100644
--- a/target/i386/mshv/mshv-cpu.c
+++ b/target/i386/mshv/mshv-cpu.c
@@ -32,12 +32,124 @@
 
 #include <sys/ioctl.h>
 
+static enum hv_register_name STANDARD_REGISTER_NAMES[18] = {
+    HV_X64_REGISTER_RAX,
+    HV_X64_REGISTER_RBX,
+    HV_X64_REGISTER_RCX,
+    HV_X64_REGISTER_RDX,
+    HV_X64_REGISTER_RSI,
+    HV_X64_REGISTER_RDI,
+    HV_X64_REGISTER_RSP,
+    HV_X64_REGISTER_RBP,
+    HV_X64_REGISTER_R8,
+    HV_X64_REGISTER_R9,
+    HV_X64_REGISTER_R10,
+    HV_X64_REGISTER_R11,
+    HV_X64_REGISTER_R12,
+    HV_X64_REGISTER_R13,
+    HV_X64_REGISTER_R14,
+    HV_X64_REGISTER_R15,
+    HV_X64_REGISTER_RIP,
+    HV_X64_REGISTER_RFLAGS,
+};
+
+int mshv_set_generic_regs(const CPUState *cpu, const hv_register_assoc *assocs,
+                          size_t n_regs)
+{
+    int cpu_fd = mshv_vcpufd(cpu);
+    int vp_index = cpu->cpu_index;
+    size_t in_sz, assocs_sz;
+    hv_input_set_vp_registers *in;
+    struct mshv_root_hvcall args = {0};
+    int ret;
+
+    /* find out the size of the struct w/ a flexible array at the tail */
+    assocs_sz = n_regs * sizeof(hv_register_assoc);
+    in_sz = sizeof(hv_input_set_vp_registers) + assocs_sz;
+
+    /* fill the input struct */
+    in = g_malloc0(in_sz);
+    in->vp_index = vp_index;
+    memcpy(in->elements, assocs, assocs_sz);
+
+    /* create the hvcall envelope */
+    args.code = HVCALL_SET_VP_REGISTERS;
+    args.in_sz = in_sz;
+    args.in_ptr = (uint64_t) in;
+    args.reps = (uint16_t) n_regs;
+
+    /* perform the call */
+    ret = mshv_hvcall(cpu_fd, &args);
+    g_free(in);
+    if (ret < 0) {
+        error_report("Failed to set registers");
+        return -1;
+    }
+
+    /* assert we set all registers */
+    if (args.reps != n_regs) {
+        error_report("Failed to set registers: expected %zu elements"
+                     ", got %u", n_regs, args.reps);
+        return -1;
+    }
+
+    return 0;
+}
+
+static int set_standard_regs(const CPUState *cpu)
+{
+    X86CPU *x86cpu = X86_CPU(cpu);
+    CPUX86State *env = &x86cpu->env;
+    hv_register_assoc assocs[ARRAY_SIZE(STANDARD_REGISTER_NAMES)];
+    int ret;
+    size_t n_regs = ARRAY_SIZE(STANDARD_REGISTER_NAMES);
+
+    /* set names */
+    for (size_t i = 0; i < ARRAY_SIZE(STANDARD_REGISTER_NAMES); i++) {
+        assocs[i].name = STANDARD_REGISTER_NAMES[i];
+    }
+    assocs[0].value.reg64 = env->regs[R_EAX];
+    assocs[1].value.reg64 = env->regs[R_EBX];
+    assocs[2].value.reg64 = env->regs[R_ECX];
+    assocs[3].value.reg64 = env->regs[R_EDX];
+    assocs[4].value.reg64 = env->regs[R_ESI];
+    assocs[5].value.reg64 = env->regs[R_EDI];
+    assocs[6].value.reg64 = env->regs[R_ESP];
+    assocs[7].value.reg64 = env->regs[R_EBP];
+    assocs[8].value.reg64 = env->regs[R_R8];
+    assocs[9].value.reg64 = env->regs[R_R9];
+    assocs[10].value.reg64 = env->regs[R_R10];
+    assocs[11].value.reg64 = env->regs[R_R11];
+    assocs[12].value.reg64 = env->regs[R_R12];
+    assocs[13].value.reg64 = env->regs[R_R13];
+    assocs[14].value.reg64 = env->regs[R_R14];
+    assocs[15].value.reg64 = env->regs[R_R15];
+    assocs[16].value.reg64 = env->eip;
+    lflags_to_rflags(env);
+    assocs[17].value.reg64 = env->eflags;
+
+    ret = mshv_set_generic_regs(cpu, assocs, n_regs);
+    if (ret < 0) {
+        error_report("failed to set standard registers");
+        return -errno;
+    }
+    return 0;
+}
+
 int mshv_store_regs(CPUState *cpu)
 {
-    error_report("unimplemented");
-    abort();
+    int ret;
+
+    ret = set_standard_regs(cpu);
+    if (ret < 0) {
+        error_report("Failed to store standard registers");
+        return -1;
+    }
+
+    return 0;
 }
 
+
 int mshv_load_regs(CPUState *cpu)
 {
     error_report("unimplemented");
-- 
2.51.0


