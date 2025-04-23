Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54C52C369CB
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 09:43:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7Wd2-0008Ax-MP; Wed, 23 Apr 2025 05:42:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u7Wc7-0005HI-Nt
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 05:41:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u7Wc5-0008O2-At
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 05:41:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745401312;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rf3WOwpBMy3VnijFsEl6zZ2nGHJDtSnWrh1lZgVXQU0=;
 b=PV5B1NYREc3VecxNzZkWoYrDJli/MUITJfJjRz0KwDin62Kq8QE40T3XuvMiB3GFl/mFVp
 nEyGVnFYqFReC0cIAm725xoy82VPMxmIXG9ukJDk8Z4VvCfxd5mKv77unLRsHpVt6aWrc2
 IDGXOkmVBOkqnh56oeNfwtPvRM2IZ/8=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-bGiSZowSP_6YTvNQ4AY8uA-1; Wed, 23 Apr 2025 05:41:50 -0400
X-MC-Unique: bGiSZowSP_6YTvNQ4AY8uA-1
X-Mimecast-MFC-AGG-ID: bGiSZowSP_6YTvNQ4AY8uA_1745401309
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-5e5c1bb6a23so749563a12.0
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 02:41:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745401308; x=1746006108;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rf3WOwpBMy3VnijFsEl6zZ2nGHJDtSnWrh1lZgVXQU0=;
 b=PoGwuUtPOXcjZqdgMYZM8a6i7+wMyu9kPoMcuKUqkif5uGEcPa8OGQDLdI1H0zWkEa
 0MKqUKf7cuukSm0+6wbfSIFYZWBXdrClj288zGgT/p7dK7e1DKcD68x5e2mnSCRl3/dE
 13E3lhzmsKhHg2aOzwoQYGMS76ShHAHjGErJEaKfVJZNyXkQfiGeNWglUoIE8pOzfTuj
 N/ti+llrw+SK7A22n2LqezrADJL9ro3uLBXzRUVqYyDGT+WqwEeN6D0EO6Ia3kSvY2Gp
 2YAa+Xuh9XzR3JKTedeejlQS2hGxkXG97ZiQHpowspSvCX2SrIICvFL0kvI8ykeKShC8
 n6TQ==
X-Gm-Message-State: AOJu0YzdXrzuZzj3pxOb5faguUfEVWRFcTSJxfTPljKG1r8pIaCiGCrr
 0GKaaSSmPtoHj++jmm1auw0bxCIji1TXnYyue9UctBaUXSwj+P4ESR3Q5KAtYdiorJDzFmzNLtM
 UL/KHZfMbefMnVQsOt76aozAyx7VadoDIkOUMSL3SI5Xxl/48MxLYMEA8B7QhXjQYYMSS8OhSFi
 83c8XDn5Ll6TgN5VvjpXLfOsaA5Te1XSB5Bpc7
X-Gm-Gg: ASbGncs35+KcgVY/5ic/H/3HhaP9meOGNcwBl1xdZ67qjDWMeQBnClaXYK5QvwRn1Yh
 HjVNN6EDhw2HKwIHARBQ7x+gm/+Au+VNzPi4plXsGyzefZU33PnXzZcBBaEU6uA00HXrQxHZ8Bz
 hajBouTQPW+pZ/MyopPdnXIyVpRTqaLwoFZOzSb/huTGwx2MQB/3HKwgO5RfwfJCOPsA7XLCqOn
 JRSUnGNItNzjFEB+oF5QwdAN5o0rU9iTwqL1Lfk8g7L0IGRzxQDTp/uF0Oa/z0OnPHa5GY/Arrq
 zO5VROCpR7WTLBGF
X-Received: by 2002:a05:6402:2695:b0:5e4:d52b:78a2 with SMTP id
 4fb4d7f45d1cf-5f6cf481c32mr1839635a12.15.1745401308079; 
 Wed, 23 Apr 2025 02:41:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH0a2JVa/5PyAmpbziD9AUD6Xtk5+F3xYuJBiZCdKxFzDR4AbQRY3g5cvZtu26iPtWxTK0EMg==
X-Received: by 2002:a05:6402:2695:b0:5e4:d52b:78a2 with SMTP id
 4fb4d7f45d1cf-5f6cf481c32mr1839604a12.15.1745401307545; 
 Wed, 23 Apr 2025 02:41:47 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.233.241])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5f625833ef1sm7066794a12.51.2025.04.23.02.41.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 02:41:45 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Wei Liu <liuwe@linux.microsoft.com>
Subject: [PULL 19/34] target/i386/hvf: provide and use simulate_{wrmsr,
 rdmsr} in emul_ops
Date: Wed, 23 Apr 2025 11:40:49 +0200
Message-ID: <20250423094105.40692-20-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250423094105.40692-1-pbonzini@redhat.com>
References: <20250423094105.40692-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.411,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Wei Liu <liuwe@linux.microsoft.com>

Change the first argument's type to be CPUState to match other hooks.

Signed-off-by: Wei Liu <liuwe@linux.microsoft.com>
Link: https://lore.kernel.org/r/1741377325-28175-8-git-send-email-liuwe@linux.microsoft.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/hvf/hvf-i386.h |  4 ++--
 target/i386/hvf/x86_emu.h  |  2 ++
 target/i386/hvf/hvf.c      | 18 ++++++++++--------
 target/i386/hvf/x86_emu.c  |  4 ++--
 4 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/target/i386/hvf/hvf-i386.h b/target/i386/hvf/hvf-i386.h
index 044ad236ae8..8c42ae6b013 100644
--- a/target/i386/hvf/hvf-i386.h
+++ b/target/i386/hvf/hvf-i386.h
@@ -19,8 +19,8 @@
 uint32_t hvf_get_supported_cpuid(uint32_t func, uint32_t idx, int reg);
 
 void hvf_handle_io(CPUState *, uint16_t, void *, int, int, int);
-void hvf_simulate_rdmsr(CPUX86State *env);
-void hvf_simulate_wrmsr(CPUX86State *env);
+void hvf_simulate_rdmsr(CPUState *cpu);
+void hvf_simulate_wrmsr(CPUState *cpu);
 
 /* Host specific functions */
 int hvf_inject_interrupt(CPUArchState *env, int vector);
diff --git a/target/i386/hvf/x86_emu.h b/target/i386/hvf/x86_emu.h
index 107c1f1ac86..555b567e2c7 100644
--- a/target/i386/hvf/x86_emu.h
+++ b/target/i386/hvf/x86_emu.h
@@ -30,6 +30,8 @@ struct x86_emul_ops {
                                     enum X86Seg seg);
     void (*handle_io)(CPUState *cpu, uint16_t port, void *data, int direction,
                       int size, int count);
+    void (*simulate_rdmsr)(CPUState *cs);
+    void (*simulate_wrmsr)(CPUState *cs);
 };
 
 extern const struct x86_emul_ops *emul_ops;
diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index e4f48a79fb7..8c31d2e0cf7 100644
--- a/target/i386/hvf/hvf.c
+++ b/target/i386/hvf/hvf.c
@@ -252,6 +252,8 @@ static const struct x86_emul_ops hvf_x86_emul_ops = {
     .write_mem = hvf_write_mem,
     .read_segment_descriptor = hvf_read_segment_descriptor,
     .handle_io = hvf_handle_io,
+    .simulate_rdmsr = hvf_simulate_rdmsr,
+    .simulate_wrmsr = hvf_simulate_wrmsr,
 };
 
 int hvf_arch_init_vcpu(CPUState *cpu)
@@ -506,10 +508,10 @@ void hvf_store_regs(CPUState *cs)
     macvm_set_rip(cs, env->eip);
 }
 
-void hvf_simulate_rdmsr(CPUX86State *env)
+void hvf_simulate_rdmsr(CPUState *cs)
 {
-    X86CPU *cpu = env_archcpu(env);
-    CPUState *cs = env_cpu(env);
+    X86CPU *cpu = X86_CPU(cs);
+    CPUX86State *env = &cpu->env;
     uint32_t msr = ECX(env);
     uint64_t val = 0;
 
@@ -611,10 +613,10 @@ void hvf_simulate_rdmsr(CPUX86State *env)
     RDX(env) = (uint32_t)(val >> 32);
 }
 
-void hvf_simulate_wrmsr(CPUX86State *env)
+void hvf_simulate_wrmsr(CPUState *cs)
 {
-    X86CPU *cpu = env_archcpu(env);
-    CPUState *cs = env_cpu(env);
+    X86CPU *cpu = X86_CPU(cs);
+    CPUX86State *env = &cpu->env;
     uint32_t msr = ECX(env);
     uint64_t data = ((uint64_t)EDX(env) << 32) | EAX(env);
 
@@ -900,9 +902,9 @@ int hvf_vcpu_exec(CPUState *cpu)
         {
             hvf_load_regs(cpu);
             if (exit_reason == EXIT_REASON_RDMSR) {
-                hvf_simulate_rdmsr(env);
+                hvf_simulate_rdmsr(cpu);
             } else {
-                hvf_simulate_wrmsr(env);
+                hvf_simulate_wrmsr(cpu);
             }
             env->eip += ins_len;
             hvf_store_regs(cpu);
diff --git a/target/i386/hvf/x86_emu.c b/target/i386/hvf/x86_emu.c
index 3ff41c35d89..aec7a8a3fa8 100644
--- a/target/i386/hvf/x86_emu.c
+++ b/target/i386/hvf/x86_emu.c
@@ -672,13 +672,13 @@ void x86_emul_raise_exception(CPUX86State *env, int exception_index, int error_c
 
 static void exec_rdmsr(CPUX86State *env, struct x86_decode *decode)
 {
-    hvf_simulate_rdmsr(env);
+    emul_ops->simulate_rdmsr(env_cpu(env));
     env->eip += decode->len;
 }
 
 static void exec_wrmsr(CPUX86State *env, struct x86_decode *decode)
 {
-    hvf_simulate_wrmsr(env);
+    emul_ops->simulate_wrmsr(env_cpu(env));
     env->eip += decode->len;
 }
 
-- 
2.49.0


