Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57AD7D64073
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2024 17:40:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9Swd-000404-CA; Fri, 08 Nov 2024 12:38:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t9Swb-0003xf-9k
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 12:38:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t9SwZ-0007b2-Fv
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 12:38:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731087526;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9ZIMW9G3sjeI4/2YX7Y1lN1LwS43Mhgyg0W5crtvJQo=;
 b=BA4N/rm2u59ZDpEG+nGElgcciSk4dx7OTzga62NBk11TlWSA+z/fvXG7AErn0M6wnwzhyO
 on2V3mOY/gY8L37EKfrJEXVywuHibUS+4p1sHiDacMxQhUwafxDviMKSdAhr77bDluZfOP
 BuDYvecyhLqDmNuLtto2G5YcOrDnrcA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-GcLW3L9RNqi6rd0auE4awQ-1; Fri, 08 Nov 2024 12:38:45 -0500
X-MC-Unique: GcLW3L9RNqi6rd0auE4awQ-1
X-Mimecast-MFC-AGG-ID: GcLW3L9RNqi6rd0auE4awQ
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-37d4a211177so1164264f8f.0
 for <qemu-devel@nongnu.org>; Fri, 08 Nov 2024 09:38:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731087524; x=1731692324;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9ZIMW9G3sjeI4/2YX7Y1lN1LwS43Mhgyg0W5crtvJQo=;
 b=sx6N7Z5M+o2YlFPLypOKWrbkU6Hs3OGrCLo1di9cBvY2nagVUQWqz5L92a8Z7JlMSl
 8KttYqo3WMPxiGUnfN+BLFmTztxE/4s2md9XRSE93D+HMCHEwKKQkbXZqqEVIpivgJwL
 TKHsAe/EWKnLWxSOqiLyompoN/uKbbWQnWB0adFsRHHzRScZHvDcrdCGCMlUM5tODf7U
 DyD6WEpH8TkQzQ2DZ8WvBNbSFQyxs08fEJ6XJP2o9bfRRasaoiYX1oRfJNz3ZCL5IpuC
 bMVAfDg6Z9M0ojjFz1dqZT1p5wtnJNKz3uEO/y4A1TOLJE1ib8f387Z6D/VkrM7fAL6K
 rUhg==
X-Gm-Message-State: AOJu0YzwltGz6GngU69ulMvW2R2jTf1Z8M1H1a4a2RXaEtcv557Nn/vO
 +dDTy2UAWyLQkJXGRdxzsWFxazxGSvYhdwISMkiKpnpO4hraZddVR+W5jlvMf+0Mvj4uRRglvcU
 RFmv/Sl4qaq3Lv9eKT2+YI8ECbOnddZmbCXe8DswsRMJ00c/ABMJcxeCMKBMMDh+u14LLPv11nO
 BMCfKFi+SzW9m2IYJOOE1QQeMek2IUa4j/Uz7JNHQ=
X-Received: by 2002:a05:6000:1569:b0:37c:d2f0:7331 with SMTP id
 ffacd0b85a97d-381f1839aa8mr3196963f8f.0.1731087524245; 
 Fri, 08 Nov 2024 09:38:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFhGJcSaRqciiaNVKMg0EQCNyW/DKTtyrS2OAyPHgzj1mb0XaZIKay8rbT8rIU5KibEQwAjMA==
X-Received: by 2002:a05:6000:1569:b0:37c:d2f0:7331 with SMTP id
 ffacd0b85a97d-381f1839aa8mr3196935f8f.0.1731087523745; 
 Fri, 08 Nov 2024 09:38:43 -0800 (PST)
Received: from [192.168.10.47] ([151.49.84.243])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381ed9ea6b5sm5578887f8f.84.2024.11.08.09.38.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Nov 2024 09:38:42 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Phil Dennis-Jordan <phil@philjordan.eu>,
 Roman Bolshakov <r.bolshakov@yadro.com>
Subject: [PULL 07/13] i386/hvf: Integrates x2APIC support with hvf accel
Date: Fri,  8 Nov 2024 18:38:22 +0100
Message-ID: <20241108173828.111454-8-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241108173828.111454-1-pbonzini@redhat.com>
References: <20241108173828.111454-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Phil Dennis-Jordan <phil@philjordan.eu>

Support for x2APIC mode was recently introduced in the software emulated
APIC implementation for TCG. Enabling it when using macOS’s hvf
accelerator is useful and significantly helps performance, as Qemu
currently uses the emulated APIC when running on hvf as well.

This change wires up the read & write operations for the MSR VM exits
and allow-lists the CPUID flag in the x86 hvf runtime.

Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
Link: https://lore.kernel.org/r/20241105155800.5461-2-phil@philjordan.eu
Reviewed-by: Roman Bolshakov <r.bolshakov@yadro.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/hvf/x86_cpuid.c |  2 +-
 target/i386/hvf/x86_emu.c   | 31 +++++++++++++++++++++++++++++++
 2 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/target/i386/hvf/x86_cpuid.c b/target/i386/hvf/x86_cpuid.c
index 492e8bfc809..3f16b0f363d 100644
--- a/target/i386/hvf/x86_cpuid.c
+++ b/target/i386/hvf/x86_cpuid.c
@@ -77,7 +77,7 @@ uint32_t hvf_get_supported_cpuid(uint32_t func, uint32_t idx,
         ecx &= CPUID_EXT_SSE3 | CPUID_EXT_PCLMULQDQ | CPUID_EXT_SSSE3 |
              CPUID_EXT_FMA | CPUID_EXT_CX16 | CPUID_EXT_PCID |
              CPUID_EXT_SSE41 | CPUID_EXT_SSE42 | CPUID_EXT_MOVBE |
-             CPUID_EXT_POPCNT | CPUID_EXT_AES |
+             CPUID_EXT_POPCNT | CPUID_EXT_AES | CPUID_EXT_X2APIC |
              (supported_xcr0 ? CPUID_EXT_XSAVE : 0) |
              CPUID_EXT_AVX | CPUID_EXT_F16C | CPUID_EXT_RDRAND;
         ecx |= CPUID_EXT_HYPERVISOR;
diff --git a/target/i386/hvf/x86_emu.c b/target/i386/hvf/x86_emu.c
index 38c782b8e3b..be675bcfb71 100644
--- a/target/i386/hvf/x86_emu.c
+++ b/target/i386/hvf/x86_emu.c
@@ -663,6 +663,15 @@ static void exec_lods(CPUX86State *env, struct x86_decode *decode)
     env->eip += decode->len;
 }
 
+static void raise_exception(CPUX86State *env, int exception_index,
+                            int error_code)
+{
+    env->exception_nr = exception_index;
+    env->error_code = error_code;
+    env->has_error_code = true;
+    env->exception_injected = 1;
+}
+
 void simulate_rdmsr(CPUX86State *env)
 {
     X86CPU *cpu = env_archcpu(env);
@@ -677,6 +686,17 @@ void simulate_rdmsr(CPUX86State *env)
     case MSR_IA32_APICBASE:
         val = cpu_get_apic_base(cpu->apic_state);
         break;
+    case MSR_APIC_START ... MSR_APIC_END: {
+        int ret;
+        int index = (uint32_t)env->regs[R_ECX] - MSR_APIC_START;
+
+        ret = apic_msr_read(index, &val);
+        if (ret < 0) {
+            raise_exception(env, EXCP0D_GPF, 0);
+        }
+
+        break;
+    }
     case MSR_IA32_UCODE_REV:
         val = cpu->ucode_rev;
         break;
@@ -777,6 +797,17 @@ void simulate_wrmsr(CPUX86State *env)
     case MSR_IA32_APICBASE:
         cpu_set_apic_base(cpu->apic_state, data);
         break;
+    case MSR_APIC_START ... MSR_APIC_END: {
+        int ret;
+        int index = (uint32_t)env->regs[R_ECX] - MSR_APIC_START;
+
+        ret = apic_msr_write(index, data);
+        if (ret < 0) {
+            raise_exception(env, EXCP0D_GPF, 0);
+        }
+
+        break;
+    }
     case MSR_FSBASE:
         wvmcs(cs->accel->fd, VMCS_GUEST_FS_BASE, data);
         break;
-- 
2.47.0


