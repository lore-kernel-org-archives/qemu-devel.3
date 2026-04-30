Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 531C3FF8873
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 17:32:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIV7v-0000dQ-Uk; Thu, 30 Apr 2026 13:24:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wIV7s-0000Ml-UF
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 13:24:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wIV7q-0004ui-Su
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 13:24:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777569874;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wyoUkF/bjkIeC5ZoeQHhKzjY0RW68pJmMim6gYvuPMQ=;
 b=cQAgrdeu6G1et/gin36zRolYapu3SMh84Mc3ns6xvVn1rvm1U28wqXiaLhQkNpAa7Zm7JJ
 W4jIJJhRa0AYG9N/Lrm7VSUTtF4LM0ozs4Zy/+kMrlPE3tkpOh7ZC4KjGjNtShv5+vC7Gv
 lpT4CFV/YKg+EJFpalL1qCiiuvDuER4=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-263-KQiAV-vyMyqlUZNOQEICvg-1; Thu, 30 Apr 2026 13:24:32 -0400
X-MC-Unique: KQiAV-vyMyqlUZNOQEICvg-1
X-Mimecast-MFC-AGG-ID: KQiAV-vyMyqlUZNOQEICvg_1777569872
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-8b46c014a26so15280236d6.0
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 10:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1777569871; x=1778174671; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wyoUkF/bjkIeC5ZoeQHhKzjY0RW68pJmMim6gYvuPMQ=;
 b=KWGCEjYPcKsSCJCzfW/U21ZtNNrUGlMm1/3GErqTDyMxre3PustVfu+sOiAKPpHzGz
 Jg97WHksJBWCxLqWVYSS4/vZ+W2hFUQpAVTLL3k4TnMW3I5V6tvkh3zgtd8nCQ97eJb1
 8CMGTulbt7fo7Sn+G64kfKb46KXnRaBdWj1Vg4JXoP89V30RS5mNmDP8jL64hice9YE1
 A1QO/vjuw+H7e4wEx7OHgrEdHGB9l57wyegJ7DV9WOsaoeoVmbC/z30FnlDoNvPCrcqy
 C+fPjYJ5iykfnTzJ4xEm78RvZseEz6UflZPaV0uBfiN2Q6nm9bMzq3wcQNL9FMJXFg2f
 DuYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777569871; x=1778174671;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wyoUkF/bjkIeC5ZoeQHhKzjY0RW68pJmMim6gYvuPMQ=;
 b=ZcL254DW0Y7f50nvVj5edRR389E6+raoAEfHLSWz+OnInviGCj5XbBmm1NWZNlw0+7
 ZELSuvfnRGqDsX9/On405YRxvJ5J5CQTwKI3FT2hhKuSIFG723uSTYrcBYwqmp4IMsID
 f4NlWaeLQ1Nwa7Asyo2X7SaVcvBc4efH4OacI8DiLWJulShmyDKZGwoLkxrGIy+ELhFV
 1aGVdUl1vK5iAY3mpQLkzCAo8E9lXLOUD3LtIoe+BRCHKSYT+dK6k8vyVYt0v4ejuGUf
 yu1VCNBaylpUUw7SpNf8PipDej1k7370JpsXTnpqO6zFoaPjC57HxXZCXxTmubxqE+6X
 DdgA==
X-Gm-Message-State: AOJu0YypU74a1z4pHSclKHOmUyPSCGECXZt0P6OqD8qBhrEH4IvFIK46
 iEAdAPL8BQA6cokH/lwevGAU8P3qkcgFNwCYNfmR0BrL5htsZWuvCqJeY77cfmuvE5i/sOxgzvZ
 GG8632+D1r1+Fbq33cGF/31i+v9zvuUQD4iVPBORZ2eJiZEASZ2KCs/cNGHxbiEKZ4EahKijvLp
 n/nombWTOlD+90X2bCIC3zp4ucxpLnp3OvNPhBwLYf
X-Gm-Gg: AeBDieuRbwqkH8U+s+IhKvhteAEia2b6p9PFV6mkilsbhYG474LMDkzKOS0yt6Vtf/l
 1oq0cLkJCOVWuvtTcnKkI/FWhNEkg2xK3srYfmlWkJpj0xBMQCSvMP5VQ5GBJocwlxVaoqadAYm
 02cB5NniydL4Ti5YPYaV4OyufLYnHn2bHTWgSRBQEwdxA9qkzvdGNuNklg+McbWIJKXvS8UsWBZ
 7+ykFqVcIkos784aY7QhRgz9O4JQgADRHpItTEqN0gSJ0Xyj2XZV0ROzLt3/oH6NPhR/l9ghC8S
 Rnz8SRjqCkzhPXB3Ol/vhRDikaoKeZQc9oXzG+KLf9UyDRvTwJ0IVcocDZSjXh/fGuDCY9Kp3EW
 LOpedOZqXwAFF05QRkfQdDNUpp4u5VSxkouNJE3CuU++uaKbyb6o5sM0YvOZ/O9lMLo6N4qcPcI
 gQqN7mwFFWYGVJcFJctlJRhunetbRgfI0/4uE=
X-Received: by 2002:a05:6214:3986:b0:8ac:a62a:a451 with SMTP id
 6a1803df08f44-8b3fe727594mr60926886d6.12.1777569870956; 
 Thu, 30 Apr 2026 10:24:30 -0700 (PDT)
X-Received: by 2002:a05:6214:3986:b0:8ac:a62a:a451 with SMTP id
 6a1803df08f44-8b3fe727594mr60926246d6.12.1777569870315; 
 Thu, 30 Apr 2026 10:24:30 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8b3ff4850e5sm22901446d6.49.2026.04.30.10.24.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 10:24:29 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PULL 46/58] whpx: i386: add HV_X64_MSR_GUEST_IDLE when
 !kernel-irqchip
Date: Thu, 30 Apr 2026 19:21:52 +0200
Message-ID: <20260430172204.1006673-47-pbonzini@redhat.com>
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

Add support for an oddball HV_X64_MSR_GUEST_IDLE not-quite-an-HLT
that wakes the vCPU even if EFLAGS.IF is set.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Link: https://lore.kernel.org/r/20260422214225.2242-23-mohamed@unpredictable.fr
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/whpx/whpx-all.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index bc8d673c31a..593a707e219 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -52,6 +52,7 @@
 /* for kernel-irqchip=off */
 #define HV_X64_MSR_APIC_FREQUENCY       0x40000023
 #define HV_X64_MSR_VP_ASSIST_PAGE       0x40000073
+#define HV_X64_MSR_GUEST_IDLE           0x400000f0
 
 static bool is_modern_os = true;
 
@@ -1648,6 +1649,15 @@ static int whpx_handle_halt(CPUState *cpu)
     return ret;
 }
 
+static int whpx_handle_hyperv_guestidle(CPUState *cpu)
+{
+    X86CPU *x86_cpu = X86_CPU(cpu);
+    CPUX86State *env = &x86_cpu->env;
+
+    env->hflags2 |= HF2_HYPERV_HLT_MASK;
+    return whpx_handle_halt(cpu);
+}
+
 static void whpx_vcpu_kick_out_of_hlt(CPUState *cpu) 
 {
     WHV_REGISTER_VALUE reg;
@@ -1851,9 +1861,10 @@ static void whpx_vcpu_process_async_events(CPUState *cpu)
     }
 
     if ((cpu_test_interrupt(cpu, CPU_INTERRUPT_HARD) &&
-         (env->eflags & IF_MASK)) ||
+         ((env->eflags & IF_MASK) || (env->hflags2 & HF2_HYPERV_HLT_MASK))) ||
         cpu_test_interrupt(cpu, CPU_INTERRUPT_NMI)) {
         cpu->halted = false;
+        env->hflags2 &= ~HF2_HYPERV_HLT_MASK;
     }
 
     if (cpu_test_interrupt(cpu, CPU_INTERRUPT_SIPI)) {
@@ -2128,6 +2139,20 @@ int whpx_vcpu_run(CPUState *cpu)
                 }
             }
 
+            /*
+             * Windows and Linux both use this MSR.
+             * Windows 11 25H2 uses it even when not advertised.
+             */
+            if (vcpu->exit_ctx.MsrAccess.MsrNumber == HV_X64_MSR_GUEST_IDLE
+                && !vcpu->exit_ctx.MsrAccess.AccessInfo.IsWrite
+                && !whpx_irqchip_in_kernel()
+                && whpx->hyperv_enlightenments_enabled) {
+                is_known_msr = 1;
+                whpx_bump_rip(cpu, &vcpu->exit_ctx);
+                ret = whpx_handle_hyperv_guestidle(cpu);
+                break;
+            }
+
             /*
              * Linux tries to use it anyway even when not exposed.
              * Ignore the write as the VP assist page is not used.
-- 
2.54.0


