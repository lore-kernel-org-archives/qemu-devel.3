Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CCC2C27C52
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 07:19:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEORp-0003JG-UV; Tue, 04 Jun 2024 03:19:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sEORo-0003Ii-54
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 03:19:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sEORm-0005e8-Ec
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 03:19:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717485545;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jd1l2qesW2ZIZOnZQq5rLZIMm8vL0i3PnwLlc9wF0HE=;
 b=aZGB/hjyP+6ZeapqcoLTRbLarwWO9j9lF9j4QIsHeC+pNNc4vxCLgli/VNr3JxKoGKePNo
 Y+Cr/cd7xLRaXo74ptJidhTYWV7TYKxzkntV169PlEizcTRnKH3uk0DZz1HTHcFw8mWwlJ
 F/F+ApIXUT+c8XERQV34Kg3OIlYbHY0=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-172-qKODYWeuMCy_Ew_yBHChpQ-1; Tue, 04 Jun 2024 03:19:01 -0400
X-MC-Unique: qKODYWeuMCy_Ew_yBHChpQ-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-57a4d24a479so625961a12.2
 for <qemu-devel@nongnu.org>; Tue, 04 Jun 2024 00:19:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717485539; x=1718090339;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jd1l2qesW2ZIZOnZQq5rLZIMm8vL0i3PnwLlc9wF0HE=;
 b=Wl0fiimJ7ObZW9rZ1zCZsxRWQZC6LFGSOZWX/2lUCaMmmwHgTLNsQ2KaRIy8wDodRj
 Nfsxbyv5akaI/qBfRVSUYc1ord5wL+iC0bDSGVZZQQO5o/aCSyF5liMOAwDKqZgLN1aW
 VHLz+U8yTbm/Zb1fgkLe8tJqUtUz9/wjOQkQTAP69Ctka+1im9HHkFCS3JtmWeLukLjd
 FrzwiDaiuzM3m3ib5IxmQcXEWjHjav8210ZtVksdZvFFgjaZZlzfUk/hv6hEPJRTr3HK
 UepM6ZtmEHlkzd2RgHSVqnJRB9Geu/IIcJkSvKEnSNfUVilq84o8R9EtMbZU8c1OucX6
 SjbA==
X-Gm-Message-State: AOJu0YxPdBoWBjqYZviLdqS+Geomzp8tEdY/s3wSswdii9JOs9LJH3Ey
 RnOl7pPJSrmHtRxiY6aCKi9MuVfV3akaitYqhhgt4wfPWO0/290frJGvFD5ZsQGc9Ajqt2neeWc
 DAXXoQ9Fos0p95OTcor7aHATof4npnjYvzHduLfegUuJJOdOlz0S/g/Gw8fY7riraI9OcADgXOd
 yGoj7YGUaUJMIqM11XEwr+NUSrpwYZwKYpfoWv
X-Received: by 2002:a50:9b19:0:b0:56e:238e:372c with SMTP id
 4fb4d7f45d1cf-57a3653a3d7mr6317057a12.26.1717485539453; 
 Tue, 04 Jun 2024 00:18:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEO0u2buUys//GDCQkPASoTC85cdAxlXiBbEDw9TLP/QXn/YYBULWdqRoYv2d33dS4yPgCfKw==
X-Received: by 2002:a50:9b19:0:b0:56e:238e:372c with SMTP id
 4fb4d7f45d1cf-57a3653a3d7mr6317043a12.26.1717485538985; 
 Tue, 04 Jun 2024 00:18:58 -0700 (PDT)
Received: from avogadro.local ([151.81.115.112])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57a81f1dbd9sm633269a12.93.2024.06.04.00.18.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Jun 2024 00:18:57 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PATCH 07/11] target/i386: fix INHIBIT_IRQ/TF/RF handling for VMRUN
Date: Tue,  4 Jun 2024 09:18:29 +0200
Message-ID: <20240604071833.962574-8-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240604071833.962574-1-pbonzini@redhat.com>
References: <20240604071833.962574-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From vm entry to exit, VMRUN is handled as a single instruction.  It
uses DISAS_NORETURN in order to avoid processing TF or RF before
the first instruction executes in the guest.  However, the corresponding
handling is missing in vmexit.  Add it, and at the same time reorganize
the comments with quotes from the manual about the tasks performed
by a #VMEXIT.

Another gen_eob() task that is missing in VMRUN is preparing the
HF_INHIBIT_IRQ flag for the next instruction, in this case by loading
it from the VMCB control state.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/sysemu/svm_helper.c | 46 +++++++++++++++++++++--------
 target/i386/tcg/translate.c         |  5 ++++
 2 files changed, 38 insertions(+), 13 deletions(-)

diff --git a/target/i386/tcg/sysemu/svm_helper.c b/target/i386/tcg/sysemu/svm_helper.c
index 922d8964f8e..9db8ad62a01 100644
--- a/target/i386/tcg/sysemu/svm_helper.c
+++ b/target/i386/tcg/sysemu/svm_helper.c
@@ -254,6 +254,13 @@ void helper_vmrun(CPUX86State *env, int aflag, int next_eip_addend)
                                                   control.intercept_exceptions
                                                   ));
 
+    env->hflags &= ~HF_INHIBIT_IRQ_MASK;
+    if (x86_ldl_phys(cs, env->vm_vmcb +
+                offsetof(struct vmcb, control.int_state)) &
+                 SVM_INTERRUPT_SHADOW_MASK) {
+        env->hflags |= HF_INHIBIT_IRQ_MASK;
+    }
+
     nested_ctl = x86_ldq_phys(cs, env->vm_vmcb + offsetof(struct vmcb,
                                                           control.nested_ctl));
     asid = x86_ldq_phys(cs, env->vm_vmcb + offsetof(struct vmcb,
@@ -815,8 +822,12 @@ void do_vmexit(CPUX86State *env)
     env->hflags &= ~HF_GUEST_MASK;
     env->intercept = 0;
     env->intercept_exceptions = 0;
+
+    /* Clears the V_IRQ and V_INTR_MASKING bits inside the processor. */
     cs->interrupt_request &= ~CPU_INTERRUPT_VIRQ;
     env->int_ctl = 0;
+
+    /* Clears the TSC_OFFSET inside the processor. */
     env->tsc_offset = 0;
 
     env->gdt.base  = x86_ldq_phys(cs, env->vm_hsave + offsetof(struct vmcb,
@@ -836,6 +847,15 @@ void do_vmexit(CPUX86State *env)
     cpu_x86_update_cr4(env, x86_ldq_phys(cs,
                                      env->vm_hsave + offsetof(struct vmcb,
                                                               save.cr4)));
+
+    /*
+     * Resets the current ASID register to zero (host ASID; TLB flush).
+     *
+     * If the host is in PAE mode, the processor reloads the host's PDPEs
+     * from the page table indicated the host's CR3. FIXME: If the PDPEs
+     * contain illegal state, the processor causes a shutdown (QEMU does
+     * not implement PDPTRs).
+     */
     cpu_x86_update_cr3(env, x86_ldq_phys(cs,
                                      env->vm_hsave + offsetof(struct vmcb,
                                                               save.cr3)));
@@ -843,12 +863,14 @@ void do_vmexit(CPUX86State *env)
        set properly */
     cpu_load_efer(env, x86_ldq_phys(cs, env->vm_hsave + offsetof(struct vmcb,
                                                          save.efer)));
+
+    /* Completion of the VMRUN instruction clears the host EFLAGS.RF bit.  */
     env->eflags = 0;
     cpu_load_eflags(env, x86_ldq_phys(cs,
                                   env->vm_hsave + offsetof(struct vmcb,
                                                            save.rflags)),
                     ~(CC_O | CC_S | CC_Z | CC_A | CC_P | CC_C | DF_MASK |
-                      VM_MASK));
+                      RF_MASK | VM_MASK));
 
     svm_load_seg_cache(env, MMU_PHYS_IDX,
                        env->vm_hsave + offsetof(struct vmcb, save.es), R_ES);
@@ -888,19 +910,17 @@ void do_vmexit(CPUX86State *env)
 
     env->hflags2 &= ~HF2_GIF_MASK;
     env->hflags2 &= ~HF2_VGIF_MASK;
-    /* FIXME: Resets the current ASID register to zero (host ASID). */
 
-    /* Clears the V_IRQ and V_INTR_MASKING bits inside the processor. */
 
-    /* Clears the TSC_OFFSET inside the processor. */
+    /* FIXME: Checks the reloaded host state for consistency. */
 
-    /* If the host is in PAE mode, the processor reloads the host's PDPEs
-       from the page table indicated the host's CR3. If the PDPEs contain
-       illegal state, the processor causes a shutdown. */
-
-    /* Checks the reloaded host state for consistency. */
-
-    /* If the host's rIP reloaded by #VMEXIT is outside the limit of the
-       host's code segment or non-canonical (in the case of long mode), a
-       #GP fault is delivered inside the host. */
+    /*
+     * EFLAGS.TF causes a #DB trap after the VMRUN completes on the host
+     * side (i.e., after the #VMEXIT from the guest). Since we're running
+     * in the main loop, call do_interrupt_all directly.
+     */
+    if ((env->eflags & TF_MASK) != 0) {
+        env->dr[6] |= DR6_BS;
+        do_interrupt_all(X86_CPU(cs), EXCP01_DB, 0, 0, env->eip, 0);
+    }
 }
diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 77ed9c1db47..a9c6424c7df 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -3745,6 +3745,11 @@ static void disas_insn_old(DisasContext *s, CPUState *cpu, int b)
             }
             gen_update_cc_op(s);
             gen_update_eip_cur(s);
+            /*
+             * Reloads INHIBIT_IRQ mask as well as TF and RF with guest state.
+             * The usual gen_eob() handling is performed on vmexit after
+             * host state is reloaded.
+             */
             gen_helper_vmrun(tcg_env, tcg_constant_i32(s->aflag - 1),
                              cur_insn_len_i32(s));
             tcg_gen_exit_tb(NULL, 0);
-- 
2.45.1


