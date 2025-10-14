Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EAB5CCD192
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 13:38:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8fDn-0005RE-Mn; Tue, 14 Oct 2025 09:37:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v8fDl-0005OX-Mn
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 09:37:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v8fDh-00012E-8e
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 09:37:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760449059;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mcXOtGCJG85v6h4eMGG6AGwj7Or+cs6XO5lrd3qjyfQ=;
 b=Ka5W+fmTUGm+XjghkkiHo/QwVLOOkwuFdaE6uZxwRbym8GDLck18QZzzPZN6RzjiUu8dDA
 EmhOsd5utRYrrYdU5ITcl/19YClKXK6L5Z94SbqF8mo1xTa3g+nSf403aPGhH+vaYvklgV
 3pib2vuslSBrFTkP5fpuucCN8W/tmy4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-440-szmnl48DMgSBxFmrs8FZmg-1; Tue, 14 Oct 2025 09:37:38 -0400
X-MC-Unique: szmnl48DMgSBxFmrs8FZmg-1
X-Mimecast-MFC-AGG-ID: szmnl48DMgSBxFmrs8FZmg_1760449057
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-46e3dcb36a1so41257335e9.2
 for <qemu-devel@nongnu.org>; Tue, 14 Oct 2025 06:37:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760449056; x=1761053856;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mcXOtGCJG85v6h4eMGG6AGwj7Or+cs6XO5lrd3qjyfQ=;
 b=CQQUW2oCzJ92m5U2SAeB9OgFrUtbp3bJLXsPLIStoIJHPLTHsb3tFPcXQ/oovYIjB4
 gmJFWq0qLYbdzmgOzUa+H1dBumnO6jYtLTnGtUvhBuC2Ux6PJf5XjpMH1iDhIvtNuXXc
 /SL11ZF60ZBBeQ2ijpQDkB9RRXfFH3U3/fiGpbFgyCpYSvt4TPx7JJ5BawaI2AMN5yjN
 HW5XjH373MKlmYQ6CFd47Aj0owYQEgFytqZLJ1gs/6OfYRkX3GnhCV5KE0sqon/FRFRY
 Y3EWY9g+eAZgz3u24vPbaeFPTZUrNdQzWZZScbp8WN+iXkphrnG+tvFqPCTVmTowJqrN
 lRtA==
X-Gm-Message-State: AOJu0YwYxE5wOdVK5NeCyLNDMdbrYhuc9Q9xpTPDm/jIRIspPENrj4CT
 SFDsvJAFotOG65XcmD6YwxirsuT8dh5E3eSaQ8Zuo33l6j21Czk+LO+9atuoyOHu7n80sMioO5z
 bw77lMuZoNfTJnygkuyg5AK4lnjJskI5YB53NXNoHsPyHxBXhLDJHcE2Mp+gaNwP/FFzOjxcvfJ
 VrsKto8L9I7Hf9cYoqayokQNYVK905DjlmrX8/BdDB
X-Gm-Gg: ASbGncv1FzAYxpBt1UD4rCeypFePWnaprPGswMeDvPvak6uQiihwEXK4E+qrUftGibp
 fNtju7QQKmmcEwtmIKyQF1xajUzHbLcjJbKBgV/6q5HqBfpAGt0BRvnTt8ho/U2NR7feYjWrius
 M9vb8kdgJ5tTs1wKr1/3S1bP6tF44nAGV9CIajx6dmGKToCxBFgBEkYL3QxS1n6TYB1hBR5qmto
 ZfhW7QLzAeTmL/LTXXBMn4iOhpkyQ0DsR0nZnA+H7JN832rJYiH7sGqc4ZSHitdBA4Fry1lQBpj
 NU3Fo5eY10yqu6SBd6WotMbbqgiAM3Ea5kkf4X3hHL2IXbELLJkPz7CyCSfDd2AkNr7itrAeFUa
 E7QGt8KbwF4TS8V6a6ZCjciYjgH3a/OKWT7/9VrlmDMU=
X-Received: by 2002:a05:600c:1990:b0:46e:1b89:77f1 with SMTP id
 5b1f17b1804b1-46fa9aa1c74mr161430125e9.9.1760449056321; 
 Tue, 14 Oct 2025 06:37:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHT6gVzJVpjGdhx2u0HyF0oGE3u9zULzZ+ZaeFhJKibdFmf6I2v4AbpO6pGPx1wkcPX4ifKQQ==
X-Received: by 2002:a05:600c:1990:b0:46e:1b89:77f1 with SMTP id
 5b1f17b1804b1-46fa9aa1c74mr161429865e9.9.1760449055793; 
 Tue, 14 Oct 2025 06:37:35 -0700 (PDT)
Received: from [192.168.10.48] ([151.61.22.175])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fab3d2c1asm153624005e9.1.2025.10.14.06.37.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Oct 2025 06:37:34 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 YiFei Zhu <zhuyifei@google.com>, qemu-stable@nongnu.org
Subject: [PULL 09/28] i386/cpu: Prevent delivering SIPI during SMM in TCG mode
Date: Tue, 14 Oct 2025 15:36:54 +0200
Message-ID: <20251014133713.1103695-9-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251014133540.1103268-1-pbonzini@redhat.com>
References: <20251014133540.1103268-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

[commit message by YiFei Zhu]

A malicious kernel may control the instruction pointer in SMM in a
multi-processor VM by sending a sequence of IPIs via APIC:

CPU0			CPU1
IPI(CPU1, MODE_INIT)
			x86_cpu_exec_reset()
			apic_init_reset()
			s->wait_for_sipi = true
IPI(CPU1, MODE_SMI)
			do_smm_enter()
			env->hflags |= HF_SMM_MASK;
IPI(CPU1, MODE_STARTUP, vector)
			do_cpu_sipi()
			apic_sipi()
			/* s->wait_for_sipi check passes */
			cpu_x86_load_seg_cache_sipi(vector)

A different sequence, SMI INIT SIPI, is also buggy in TCG because
INIT is not blocked or latched during SMM. However, it is not
vulnerable to an instruction pointer control in the same way because
x86_cpu_exec_reset clears env->hflags, exiting SMM.

Fixes: a9bad65d2c1f ("target-i386: wake up processors that receive an SMI")
Analyzed-by: YiFei Zhu <zhuyifei@google.com>
Cc: qemu-stable@nongnu.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/intc/apic.c                      | 2 --
 target/i386/helper.c                | 4 ++++
 target/i386/tcg/system/seg_helper.c | 1 +
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/hw/intc/apic.c b/hw/intc/apic.c
index 6d7859640c2..c7680338563 100644
--- a/hw/intc/apic.c
+++ b/hw/intc/apic.c
@@ -646,8 +646,6 @@ void apic_sipi(DeviceState *dev)
 {
     APICCommonState *s = APIC(dev);
 
-    cpu_reset_interrupt(CPU(s->cpu), CPU_INTERRUPT_SIPI);
-
     if (!s->wait_for_sipi)
         return;
     cpu_x86_load_seg_cache_sipi(s->cpu, s->sipi_vector);
diff --git a/target/i386/helper.c b/target/i386/helper.c
index 651041ccfa6..72b2e195a31 100644
--- a/target/i386/helper.c
+++ b/target/i386/helper.c
@@ -621,6 +621,10 @@ void do_cpu_init(X86CPU *cpu)
 
 void do_cpu_sipi(X86CPU *cpu)
 {
+    CPUX86State *env = &cpu->env;
+    if (env->hflags & HF_SMM_MASK) {
+        return;
+    }
     apic_sipi(cpu->apic_state);
 }
 
diff --git a/target/i386/tcg/system/seg_helper.c b/target/i386/tcg/system/seg_helper.c
index 38072e51d72..8c7856be81e 100644
--- a/target/i386/tcg/system/seg_helper.c
+++ b/target/i386/tcg/system/seg_helper.c
@@ -182,6 +182,7 @@ bool x86_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
         apic_poll_irq(cpu->apic_state);
         break;
     case CPU_INTERRUPT_SIPI:
+        cpu_reset_interrupt(cs, CPU_INTERRUPT_SIPI);
         do_cpu_sipi(cpu);
         break;
     case CPU_INTERRUPT_SMI:
-- 
2.51.0


