Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51205CD13D3
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 17:28:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIV7n-0007pv-9J; Thu, 30 Apr 2026 13:24:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wIV7i-0007Gd-9v
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 13:24:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wIV7f-0004s3-PV
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 13:24:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777569862;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cqWwjTx+0ttmQaI1B24B0fZSc2nNrkhkxV8siWtbPhw=;
 b=itc5Svt8fP2fXpbGjozF15vpnTg95CRTbRlIMJ13MXtEivjbMrahGQZv8CscSBeDCUnq8W
 FgA8QghuCq5MKNBDO9JFuhYdHNlfBK/sd+00f8bioUrWN+Vkr0WZ6AW5S5D9Jz5sxmn38N
 fJdknlWxn20aDXMMoIcFkl24ttFLPKI=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-583-z7QRvY3yMT6i-0l2pctvHw-1; Thu, 30 Apr 2026 13:24:20 -0400
X-MC-Unique: z7QRvY3yMT6i-0l2pctvHw-1
X-Mimecast-MFC-AGG-ID: z7QRvY3yMT6i-0l2pctvHw_1777569860
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-8acb26fbbb2so19372036d6.2
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 10:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1777569859; x=1778174659; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cqWwjTx+0ttmQaI1B24B0fZSc2nNrkhkxV8siWtbPhw=;
 b=Rm17YPoD359XWTK8lR04obCr5k7gXnduXgn1hcj6qHIKqoR2vYSg+lnNeqJAu40W0G
 gEsnyhckP0lBgCG8cPkCaEWEamPG0pcaLEVOjQIXdH9uZC6WKikrsDMpO5+CYEg8gMJw
 pbZ5qdzUeaNKjksCtAjyD481bDUnakqdRE01hOiW6bXyEOZz/3b+GEbkPEmpfoetpMHS
 HoSCi4VoYt8J1TxuFZCz6aQI92Bhq8xwam0YtaD0yNFam/ta/+6rQgYXS1W4GXW15t+y
 wB8qFkej5kaMl+vkERPevESIEBcuwdn8pHGfEZTFWPrFgcAZ0XZYE2WVjULjxLnVYypE
 MGSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777569859; x=1778174659;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cqWwjTx+0ttmQaI1B24B0fZSc2nNrkhkxV8siWtbPhw=;
 b=BbOzOXwSp5AkyYyfdQXxvkCocvVOJCye8eYVoCJjGC8vC7l3x51esJcPNqOduVEeT8
 k8xcPw1OV6rX51+EaoUo9TOmlLw9If+UypEEtQlkuZ935Sfuq7Tlzp1tEGqAS6ZqKy+0
 DVJLi++h9So/2Iw9/dxvyeIGfzlpwqXtfmqkuYLO/L2K6TtGPT8X9xxNPhXSfHsJXjEx
 b5CsIGnwBCWV31Wzdkg95ewpDlhl2qA/2IGQXRc0KzHrNICINi3uLnQR7Fp2mutkNMQd
 YuiapJ261aTVN6sbSgSoYqvlPTETnddRqWrMtr9zZrTlInTXrhPfNncYZMdGfY1cU73+
 mXhA==
X-Gm-Message-State: AOJu0YynztzWPn5HcTkl16mfn6PJX7OmCw4RbNuhASOdntw5c/2hFDXM
 s5NnMG56bIskPa9FCnE6ldYgN0R54VFEWigzkSy0prVpmtnBSO8q9Z/onwwX2Zc9oHytywp5E4l
 i0hO+q77mk5Ing7Qdxd9Ywx5PQ8k7twXXrFH+FPYUq0aCd7ZZkMV1VpDrKPHsKJ/uJlvB/verbp
 44C9xaZvjTjJDlB4zPbQI4EOo7ycl6GQUT5bL8/Rkx
X-Gm-Gg: AeBDiesYJXCoizxdx9IU5QIm0au7/tejTO3HFnjFTs9q5SzO9sHnh50BR6ImdTOuGA1
 J3mC5j1Jji3I2TiJawAzhRpPZJhe2uWT2j7IRbe1d6UXtvOyJ9+e8DLE9+q8uwTeiam5ouDT3s7
 FPefRjonktPc0U7E9KOlqNbrTv/x8etPyzIFaxa62TynUVf3dnK8NLLyLilFp1zFvlfoKgN/jvx
 TPrvNmGUBQljIoloS1+WAlBwP5Ows1p7VMVc8xaxXl1BF/Qefo3i8c20Ihwsl+Z7dtok8u+ofdT
 QUE5yhhbTaX+QK5pV61xlTmy/NFJ5kfuiCu9o0CzXZx8wSbEWKqrah90vF9ADT7FtpQOcGhoUU1
 et24NY1VI2kUkm0XJlv0Bf+JYTRs7WVOp8m1pTKRJvb1n+OCWIZV9zpCn0zDjUpJ8vRqmSc8Akb
 8hpyHPWXEKVWSVNcSA0tgTYRYShT2hIQaCRLc=
X-Received: by 2002:a05:622a:199d:b0:50d:863d:b50e with SMTP id
 d75a77b69052e-5102ab1c200mr54010491cf.3.1777569859301; 
 Thu, 30 Apr 2026 10:24:19 -0700 (PDT)
X-Received: by 2002:a05:622a:199d:b0:50d:863d:b50e with SMTP id
 d75a77b69052e-5102ab1c200mr54009721cf.3.1777569858579; 
 Thu, 30 Apr 2026 10:24:18 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-5103d1c6bb7sm649231cf.5.2026.04.30.10.24.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 10:24:17 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PULL 42/58] target/i386: emulate, hvf: rdmsr/wrmsr GPF handling
Date: Thu, 30 Apr 2026 19:21:48 +0200
Message-ID: <20260430172204.1006673-43-pbonzini@redhat.com>
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

In that case, the instruction pointer mustn't be incremented.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Link: https://lore.kernel.org/r/20260422214225.2242-34-mohamed@unpredictable.fr
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/emulate/x86_emu.h |  4 ++--
 target/i386/hvf/hvf-i386.h    |  4 ++--
 target/i386/emulate/x86_emu.c | 10 ++++++----
 target/i386/hvf/hvf.c         |  9 +++++++--
 4 files changed, 17 insertions(+), 10 deletions(-)

diff --git a/target/i386/emulate/x86_emu.h b/target/i386/emulate/x86_emu.h
index a8d4c93098d..b985240b90e 100644
--- a/target/i386/emulate/x86_emu.h
+++ b/target/i386/emulate/x86_emu.h
@@ -31,8 +31,8 @@ struct x86_emul_ops {
     target_ulong (*read_cr) (CPUState *cpu, int cr);
     void (*handle_io)(CPUState *cpu, uint16_t port, void *data, int direction,
                       int size, int count);
-    void (*simulate_rdmsr)(CPUState *cs);
-    void (*simulate_wrmsr)(CPUState *cs);
+    bool (*simulate_rdmsr)(CPUState *cs);
+    bool (*simulate_wrmsr)(CPUState *cs);
     bool (*is_protected_mode)(CPUState *cpu);
     bool (*is_long_mode)(CPUState *cpu);
     bool (*is_user_mode)(CPUState *cpu);
diff --git a/target/i386/hvf/hvf-i386.h b/target/i386/hvf/hvf-i386.h
index 8c42ae6b013..b91c17e2fc2 100644
--- a/target/i386/hvf/hvf-i386.h
+++ b/target/i386/hvf/hvf-i386.h
@@ -19,8 +19,8 @@
 uint32_t hvf_get_supported_cpuid(uint32_t func, uint32_t idx, int reg);
 
 void hvf_handle_io(CPUState *, uint16_t, void *, int, int, int);
-void hvf_simulate_rdmsr(CPUState *cpu);
-void hvf_simulate_wrmsr(CPUState *cpu);
+bool hvf_simulate_rdmsr(CPUState *cpu);
+bool hvf_simulate_wrmsr(CPUState *cpu);
 
 /* Host specific functions */
 int hvf_inject_interrupt(CPUArchState *env, int vector);
diff --git a/target/i386/emulate/x86_emu.c b/target/i386/emulate/x86_emu.c
index c2da1a133f3..c6ea8542902 100644
--- a/target/i386/emulate/x86_emu.c
+++ b/target/i386/emulate/x86_emu.c
@@ -792,15 +792,17 @@ void x86_emul_raise_exception(CPUX86State *env, int exception_index, int error_c
 
 static bool exec_rdmsr(CPUX86State *env, struct x86_decode *decode)
 {
-    emul_ops->simulate_rdmsr(env_cpu(env));
-    env->eip += decode->len;
+    if (!emul_ops->simulate_rdmsr(env_cpu(env))) {
+        env->eip += decode->len;
+    }
     return 0;
 }
 
 static bool exec_wrmsr(CPUX86State *env, struct x86_decode *decode)
 {
-    emul_ops->simulate_wrmsr(env_cpu(env));
-    env->eip += decode->len;
+    if (!emul_ops->simulate_wrmsr(env_cpu(env))) {
+        env->eip += decode->len;
+    }
     return 0;
 }
 
diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index cdc8bd19504..2d1a943b96c 100644
--- a/target/i386/hvf/hvf.c
+++ b/target/i386/hvf/hvf.c
@@ -536,7 +536,7 @@ void hvf_store_regs(CPUState *cs)
     macvm_set_rip(cs, env->eip);
 }
 
-void hvf_simulate_rdmsr(CPUState *cs)
+bool hvf_simulate_rdmsr(CPUState *cs)
 {
     X86CPU *cpu = X86_CPU(cs);
     CPUX86State *env = &cpu->env;
@@ -557,6 +557,7 @@ void hvf_simulate_rdmsr(CPUState *cs)
         ret = apic_msr_read(cpu->apic_state, index, &val);
         if (ret < 0) {
             x86_emul_raise_exception(env, EXCP0D_GPF, 0);
+            return 1;
         }
 
         break;
@@ -639,9 +640,10 @@ void hvf_simulate_rdmsr(CPUState *cs)
 
     RAX(env) = (uint32_t)val;
     RDX(env) = (uint32_t)(val >> 32);
+    return 0;
 }
 
-void hvf_simulate_wrmsr(CPUState *cs)
+bool hvf_simulate_wrmsr(CPUState *cs)
 {
     X86CPU *cpu = X86_CPU(cs);
     CPUX86State *env = &cpu->env;
@@ -657,6 +659,7 @@ void hvf_simulate_wrmsr(CPUState *cs)
         r = cpu_set_apic_base(cpu->apic_state, data);
         if (r < 0) {
             x86_emul_raise_exception(env, EXCP0D_GPF, 0);
+            return 1;
         }
 
         break;
@@ -668,6 +671,7 @@ void hvf_simulate_wrmsr(CPUState *cs)
         ret = apic_msr_write(cpu->apic_state, index, data);
         if (ret < 0) {
             x86_emul_raise_exception(env, EXCP0D_GPF, 0);
+            return 1;
         }
 
         break;
@@ -746,6 +750,7 @@ void hvf_simulate_wrmsr(CPUState *cs)
          g_hypervisor_iface->wrmsr_handler(cs, msr, data);
 
     printf("write msr %llx\n", RCX(cs));*/
+    return 0;
 }
 
 static int hvf_handle_vmexit(CPUState *cpu)
-- 
2.54.0


