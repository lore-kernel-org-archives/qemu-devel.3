Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCF1BE8FDD5
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Dec 2025 09:52:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZQuo-0002aI-Cw; Sat, 27 Dec 2025 04:48:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQug-0002JS-B6
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:48:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQuW-0006u8-Ag
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:48:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766828911;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XzIiipLLrfD4vcpRpCLjIkg7cFdHY3lI2WYxF9LZKpA=;
 b=F3q04x2e9vEf4d0qEDTRjzwK8mxNYe/T8xhuwE9ZF9SBXSjifN3gS5Vr2Lij/WNwnf23Y+
 9ZgUbwSeOw7aBm7GbHxPKtgotWUOzvA5Xm7XaON3ebCK5yAeGd8FGw9OamQxIAdW1KTm12
 d3cS8uau41yh9HPBTHTZOg7t0g9OQeU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-CxuLkgyKMe6sa63Fix0MaQ-1; Sat, 27 Dec 2025 04:48:29 -0500
X-MC-Unique: CxuLkgyKMe6sa63Fix0MaQ-1
X-Mimecast-MFC-AGG-ID: CxuLkgyKMe6sa63Fix0MaQ_1766828909
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-4325ddc5babso2696484f8f.0
 for <qemu-devel@nongnu.org>; Sat, 27 Dec 2025 01:48:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766828908; x=1767433708; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XzIiipLLrfD4vcpRpCLjIkg7cFdHY3lI2WYxF9LZKpA=;
 b=pSDSSNdr06WqyK70H6xfLZqMOSrGJWDNt3bszWDUU0FyGVvW/06pNk1VatThbMrWoh
 xa7jH8yVsl9u28DdENLz3bG/m6SSejuscvBO1oFL/ltr8M/EZhKeD9ZoyrCp6KMmPmaX
 T7ovjFhqSCl8qJK8A8u9FbRuvHwzr59Aj19JloeJXS/8IlJWOc5CQsgP7FzlZyJPmjNG
 oCQv8HqRuVS+4rCc55VhgAr2aAxCS1M9NnnAZbKBmKDUg+8tfKf22KrgPE9h1FClKs5w
 f6JjdAGG1t6rGPWBTRrG9K9OjXXJQylQmQ1kvD7vsJwoLYdjdGiUEJhDvK+oR8UdFCRn
 vkHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766828908; x=1767433708;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XzIiipLLrfD4vcpRpCLjIkg7cFdHY3lI2WYxF9LZKpA=;
 b=se2i/Y3QKN3PLsO+reUHtjEEBJNon1mNGUHxCzg9b2NI26idyYGgwfIr3QCR2iA4UO
 LlBBXUnpIZ6uUHyDXn+q1TnEREQ1W3pD6z/WlsV26RmFa/qZOMV/mMbyjArSLeeivi+g
 V7qYzvD5c1FNg6gjYtNAsG4nfqqs09RkuiBNcqPY9cMJahqR2AZq26yAjNWJe/aHFxzG
 enFD6Ku5lO8D4IS8o1Fw6ZZsZqIcwCfTdhKXvuiXrSon+Vr6kjqrJgb+jM/vAGZ3xSYp
 IIsb7HJ9FB1V5S+vGQbh7PGunHTwrah3QVr6O5rI/eJ9/qSii7k2lDYu2SFB1EqGr8Ik
 Ajdw==
X-Gm-Message-State: AOJu0Yx9KfEsaMufCgz33RYJwIbIxN/hhueXopq5RvF4yLIquJBTV9c6
 OwhwD/M0XxfueO7gup5SiNdFuBsNkfyqx8OKyKxTqi5CmRZ7wmM6fm0Guuo4etf0n4CRHOZSL0F
 RyfUc5EE4TFt2gc0AhKXpp7DnPTflKW2z5CtOfqj2Vme6d/zNcg/Gov1+uHn/L0uYrnhStBA6jn
 +pxlMHTNGXKjsYfx7YliExBbN5GOojsMHSx3VcCuhP
X-Gm-Gg: AY/fxX7tZrNvPyNTABTB0OxyrL1nB4SVNTINvl55nZOZmLCXbkvFgcXykrChpSwHJc1
 crfUaJ9XyLrO+nY8yi8m/NTAV1eIT9pY1FY90ZjUVBqnPz5bpZybxI/m7hZFGE29o6fwWBNYLGF
 ZHF2TPtWzNcOD4WUZTt9r+wUt3aNtNYvpnNeYo+9dwbr113NvvEMXFbNCqlLLLjo6LmNNgmls9B
 fkd/MbAIhnwAYMfSmo30L2U8oAmknAyuYvuTqWM8pFl+LceERBXa/CEumgh1BGZ299YDOeESHm+
 IpYJNc5b8gch55+tmIaNDpFMVHUmwOkmu0wk5s0kmwL+Y8KOyFRYWYgvKUnPBBdIuxbObFMzZ0x
 rHmxUdwQE5G5Fei7BaShOsllG/73eQIAQNtCqXJczi3j9AS0kg8bh56v6BLoWuwLAsZ4t6DozZ3
 isLWEINsffsUG/nRY=
X-Received: by 2002:a05:6000:2203:b0:42f:b707:56e6 with SMTP id
 ffacd0b85a97d-4324e5035d1mr24635026f8f.34.1766828907890; 
 Sat, 27 Dec 2025 01:48:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE7R/v75mFl2ZQpRodO9BvtZOVNjKNQx6c50SCp4zWj68HiK+T83bsvAtkF/mXlwJX+Fhc4OA==
X-Received: by 2002:a05:6000:2203:b0:42f:b707:56e6 with SMTP id
 ffacd0b85a97d-4324e5035d1mr24635004f8f.34.1766828907453; 
 Sat, 27 Dec 2025 01:48:27 -0800 (PST)
Received: from [192.168.10.48] ([151.95.145.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4325b6bfe88sm41924278f8f.19.2025.12.27.01.48.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Dec 2025 01:48:26 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Farrah Chen <farrah.chen@intel.com>,
 Zide Chen <zide.chen@intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Yang Weijiang <weijiang.yang@intel.com>, Chao Gao <chao.gao@intel.com>
Subject: [PULL 087/153] i386/kvm: Add save/restore support for
 KVM_REG_GUEST_SSP
Date: Sat, 27 Dec 2025 10:46:52 +0100
Message-ID: <20251227094759.35658-13-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251227091622.20725-1-pbonzini@redhat.com>
References: <20251227091622.20725-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Yang Weijiang <weijiang.yang@intel.com>

CET provides a new architectural register, shadow stack pointer (SSP),
which cannot be directly encoded as a source, destination or memory
operand in instructions. But Intel VMCS & VMCB provide fields to
save/load guest & host's ssp.

It's necessary to save & restore Guest's ssp before & after migration.
To support this, KVM implements Guest's SSP as a special KVM internal
register - KVM_REG_GUEST_SSP, and allows QEMU to save & load it via
KVM_GET_ONE_REG/KVM_SET_ONE_REG.

Cache KVM_REG_GUEST_SSP in X86CPUState.

Tested-by: Farrah Chen <farrah.chen@intel.com>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Signed-off-by: Yang Weijiang <weijiang.yang@intel.com>
Co-developed-by: Chao Gao <chao.gao@intel.com>
Signed-off-by: Chao Gao <chao.gao@intel.com>
Co-developed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20251211060801.3600039-16-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.h     |  3 ++-
 target/i386/kvm/kvm.c | 39 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 37cc218bf3a..458775daaa3 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1979,7 +1979,7 @@ typedef struct CPUArchState {
     uint64_t fred_config;
 #endif
 
-    /* CET MSRs */
+    /* CET MSRs and register */
     uint64_t u_cet;
     uint64_t s_cet;
     uint64_t pl0_ssp; /* also used for FRED */
@@ -1989,6 +1989,7 @@ typedef struct CPUArchState {
 #ifdef TARGET_X86_64
     uint64_t int_ssp_table;
 #endif
+    uint64_t guest_ssp;
 
     uint64_t tsc_adjust;
     uint64_t tsc_deadline;
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index e1a1f0ce9e5..7b9b740a8e5 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -4293,6 +4293,35 @@ static int kvm_put_msrs(X86CPU *cpu, KvmPutState level)
     return kvm_buf_set_msrs(cpu);
 }
 
+static int kvm_put_kvm_regs(X86CPU *cpu)
+{
+    CPUX86State *env = &cpu->env;
+    int ret;
+
+    if ((env->features[FEAT_7_0_ECX] & CPUID_7_0_ECX_CET_SHSTK)) {
+        ret = kvm_set_one_reg(CPU(cpu), KVM_X86_REG_KVM(KVM_REG_GUEST_SSP),
+                              &env->guest_ssp);
+        if (ret) {
+            return ret;
+        }
+    }
+    return 0;
+}
+
+static int kvm_get_kvm_regs(X86CPU *cpu)
+{
+    CPUX86State *env = &cpu->env;
+    int ret;
+
+    if ((env->features[FEAT_7_0_ECX] & CPUID_7_0_ECX_CET_SHSTK)) {
+        ret = kvm_get_one_reg(CPU(cpu), KVM_X86_REG_KVM(KVM_REG_GUEST_SSP),
+                              &env->guest_ssp);
+        if (ret) {
+            return ret;
+        }
+    }
+    return 0;
+}
 
 static int kvm_get_xsave(X86CPU *cpu)
 {
@@ -5446,6 +5475,11 @@ int kvm_arch_put_registers(CPUState *cpu, KvmPutState level, Error **errp)
         error_setg_errno(errp, -ret, "Failed to set MSRs");
         return ret;
     }
+    ret = kvm_put_kvm_regs(x86_cpu);
+    if (ret < 0) {
+        error_setg_errno(errp, -ret, "Failed to set KVM type registers");
+        return ret;
+    }
     ret = kvm_put_vcpu_events(x86_cpu, level);
     if (ret < 0) {
         error_setg_errno(errp, -ret, "Failed to set vCPU events");
@@ -5518,6 +5552,11 @@ int kvm_arch_get_registers(CPUState *cs, Error **errp)
         error_setg_errno(errp, -ret, "Failed to get MSRs");
         goto out;
     }
+    ret = kvm_get_kvm_regs(cpu);
+    if (ret < 0) {
+        error_setg_errno(errp, -ret, "Failed to get KVM type registers");
+        goto out;
+    }
     ret = kvm_get_apic(cpu);
     if (ret < 0) {
         error_setg_errno(errp, -ret, "Failed to get APIC");
-- 
2.52.0


