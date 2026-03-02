Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 204F1C624C6
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 08:51:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwytp-0002lI-5O; Mon, 02 Mar 2026 03:45:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwytN-0001pe-EU
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:44:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwytJ-0001aH-J7
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:44:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772441076;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gjvR+OkxZ7HxwHV/I2EnmhZdobN9zycIS9gtCz8oxR4=;
 b=ODLkCdHTlAclPUapwhNJZG3sHMyuqVosoM4E/LAX05vcq00KMy22S62DDN8UA2obifkAhJ
 5e9EA/90h5PESsFItS+5vegmYYueZULgJ9FyTE6GVoUHP7W4tQngLHp8VMIyj2zkQqj+mA
 tkTsSPd0Td56/ee2Wk84mnfC35t6ou8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-21-uMud_eDiMnqAN_3mmg3EeA-1; Mon, 02 Mar 2026 03:44:29 -0500
X-MC-Unique: uMud_eDiMnqAN_3mmg3EeA-1
X-Mimecast-MFC-AGG-ID: uMud_eDiMnqAN_3mmg3EeA_1772441068
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4836ff58111so42862925e9.1
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 00:44:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772441067; x=1773045867; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gjvR+OkxZ7HxwHV/I2EnmhZdobN9zycIS9gtCz8oxR4=;
 b=GZw/BcbNxpue2jC4Yvlz2s+D8d8gMaPadJTY8xEeIZBUIalb9OEu3W1uZqBc6CVRy0
 HCvYIH7Ky5NLponUnVuKVJ5Ar1vvyX2PGNQJ5FLkzOdgj7TWBe+aFV7PC5LbBqLhWwK1
 xFQiREBkojSdLWQk2wCb6dS56Oq1mXo3LraUT0/zvirhVBggfwx9F77ARVZMF9xv3w7t
 2jtHTNchOn8/+JtDz35Y/GZq7UlSoeT/4uI/wC+w4ApPj4Bfv6Hf1RMKrJ5mXKAHpjFo
 lJx6OJbCFBix66vqkqAgM5ojxwSjTB5axZOwwe346UNUmGc10gsmfDceFf+MQYWy/0eN
 l2kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772441067; x=1773045867;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gjvR+OkxZ7HxwHV/I2EnmhZdobN9zycIS9gtCz8oxR4=;
 b=fsBcCNoqtZ9WQvFQ7o55FemH/oiEKYuqVVD29R0wSqyLQrQyEpWowNpHLVNtE+v88r
 5LYVvz8q8czM2ZKDbFI8VSqrRQeIS5ZnUYKKT2XTKT7Fw3muB4msjMlBe8rdEs/b1vnl
 ObOWIW0wPCO+cRwpQW4wtyI956Rgv22uBmdE3zXia+UAeG3Rel2maeQrMBKTbPwWdle3
 AH/Lv73wwEm7KS2XTkv8cC3tDmChEy8roG9PN3ilbfBpLqGClQ4qc0E9H39PRd03WN7t
 bY1Yr4orxplJgECkU4mXU9s1PWCwd5KXahT4+5fp1iZBTMjgeve/7VYudlB7FNYwJe3Y
 us9A==
X-Gm-Message-State: AOJu0Yy8z4tGHKxu8PAoeI3ps7O2r/ZWAZMKt5d/Q24wPQxI8WuGuR1X
 eJOUMV99dzXgVHZUDgmmFTGZ0oKyAWlmjMfyzyNfUsMraG/eCUvElaBShkQMIRJrYaohdyXs5Tz
 9mYhwH+gBVoNan93P0vMM9XfVtWDP8h4zZugJfPm5WHLmIFeCn8ftyyJ4E04lKES6z3JhIASNPL
 AIXP6VFgB8JPb6upruCEA8hTBBPiq61BP96zk1himi
X-Gm-Gg: ATEYQzyzc+DCm8SvS8pkQ3mBYEEICoRACBJScTXMsuNex4A10A4IDQ7hzark3NtwR9Y
 RF1Hck3v2t8nIzkKRqayGz/AAFrI3FZ96VwyVMvF8YdKlRG0aCMiiIahZuiRYhEAD935GdQjxRw
 QLuuejCdBms2eQuS5zOKLB87FykRL4n9VihgDYDiEoTd0l2+zeQHH3AadNM5hHrtlRKJpTwxo7h
 ptXPv2tQ8B9svXPt60JQ50znL1UJvRfLzJocDtOzmU/iXqsWVEONqqB/YJmdT7rcX+tei0U23wG
 LPQsf7MEn/B3X7MBzxLWhLAI/KKzSXrQbZOBPavjFP+tEP+IwodCm089pUxk0MUam1ZjOaK+wlF
 OLLK/1MDBsYFNnqVlvkOQfEnwZ43WXUfkK8rZGluRTLuS/MlBGuWoQOAXykYdg+cXl/DS/CyeKf
 NTjzAKwi1dwxJEEXkpoxYAf+iz6jU=
X-Received: by 2002:a05:600c:630d:b0:483:7903:c3b1 with SMTP id
 5b1f17b1804b1-483c9bedb42mr162623955e9.20.1772441067316; 
 Mon, 02 Mar 2026 00:44:27 -0800 (PST)
X-Received: by 2002:a05:600c:630d:b0:483:7903:c3b1 with SMTP id
 5b1f17b1804b1-483c9bedb42mr162623575e9.20.1772441066769; 
 Mon, 02 Mar 2026 00:44:26 -0800 (PST)
Received: from [192.168.10.48] ([151.95.144.138])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483c3b4410bsm283021895e9.6.2026.03.02.00.44.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2026 00:44:24 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PULL 017/102] whpx: i386: saving/restoring less state for
 WHPX_LEVEL_FAST_RUNTIME_STATE
Date: Mon,  2 Mar 2026 09:42:12 +0100
Message-ID: <20260302084338.473368-18-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260302084338.473368-1-pbonzini@redhat.com>
References: <20260302084338.473368-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.012, RCVD_IN_VALIDITY_RPBL_BLOCKED=1.188,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Optimise vmexits by save/restoring less state in those cases instead of the full state.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Reviewed-by: Bernhard Beschow <shentey@gmail.com>
Link: https://lore.kernel.org/r/20260223233950.96076-17-mohamed@unpredictable.fr
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/whpx/whpx-all.c | 196 +++++++++++++++++++-----------------
 1 file changed, 101 insertions(+), 95 deletions(-)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index c09d9affefa..ab583e922d4 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -422,118 +422,124 @@ void whpx_set_registers(CPUState *cpu, WHPXStateLevel level)
     }
 
     assert(idx == WHvX64RegisterLdtr);
-    vcxt.values[idx++].Segment = whpx_seg_q2h(&env->ldt, 0, 0);
-
-    assert(idx == WHvX64RegisterTr);
-    vcxt.values[idx++].Segment = whpx_seg_q2h(&env->tr, 0, 0);
-
-    assert(idx == WHvX64RegisterIdtr);
-    vcxt.values[idx].Table.Base = env->idt.base;
-    vcxt.values[idx].Table.Limit = env->idt.limit;
-    idx += 1;
-
-    assert(idx == WHvX64RegisterGdtr);
-    vcxt.values[idx].Table.Base = env->gdt.base;
-    vcxt.values[idx].Table.Limit = env->gdt.limit;
-    idx += 1;
-
-    /* CR0, 2, 3, 4, 8 */
-    assert(whpx_register_names[idx] == WHvX64RegisterCr0);
-    vcxt.values[idx++].Reg64 = env->cr[0];
-    assert(whpx_register_names[idx] == WHvX64RegisterCr2);
-    vcxt.values[idx++].Reg64 = env->cr[2];
-    assert(whpx_register_names[idx] == WHvX64RegisterCr3);
-    vcxt.values[idx++].Reg64 = env->cr[3];
-    assert(whpx_register_names[idx] == WHvX64RegisterCr4);
-    vcxt.values[idx++].Reg64 = env->cr[4];
-    assert(whpx_register_names[idx] == WHvX64RegisterCr8);
-    vcxt.values[idx++].Reg64 = vcpu->tpr;
-
-    /* 8 Debug Registers - Skipped */
-
     /*
-     * Extended control registers needs to be handled separately depending
-     * on whether xsave is supported/enabled or not.
+     * Skip those registers for synchronisation after MMIO accesses
+     * as they're not going to be modified in that case.
      */
-    whpx_set_xcrs(cpu);
+    if (level > WHPX_LEVEL_FAST_RUNTIME_STATE) {
+        vcxt.values[idx++].Segment = whpx_seg_q2h(&env->ldt, 0, 0);
 
-    /* 16 XMM registers */
-    assert(whpx_register_names[idx] == WHvX64RegisterXmm0);
-    idx_next = idx + 16;
-    for (i = 0; i < sizeof(env->xmm_regs) / sizeof(ZMMReg); i += 1, idx += 1) {
-        vcxt.values[idx].Reg128.Low64 = env->xmm_regs[i].ZMM_Q(0);
-        vcxt.values[idx].Reg128.High64 = env->xmm_regs[i].ZMM_Q(1);
-    }
-    idx = idx_next;
+        assert(idx == WHvX64RegisterTr);
+        vcxt.values[idx++].Segment = whpx_seg_q2h(&env->tr, 0, 0);
 
-    /* 8 FP registers */
-    assert(whpx_register_names[idx] == WHvX64RegisterFpMmx0);
-    for (i = 0; i < 8; i += 1, idx += 1) {
-        vcxt.values[idx].Fp.AsUINT128.Low64 = env->fpregs[i].mmx.MMX_Q(0);
-        /* vcxt.values[idx].Fp.AsUINT128.High64 =
-               env->fpregs[i].mmx.MMX_Q(1);
-        */
-    }
+        assert(idx == WHvX64RegisterIdtr);
+        vcxt.values[idx].Table.Base = env->idt.base;
+        vcxt.values[idx].Table.Limit = env->idt.limit;
+        idx += 1;
 
-    /* FP control status register */
-    assert(whpx_register_names[idx] == WHvX64RegisterFpControlStatus);
-    vcxt.values[idx].FpControlStatus.FpControl = env->fpuc;
-    vcxt.values[idx].FpControlStatus.FpStatus =
-        (env->fpus & ~0x3800) | (env->fpstt & 0x7) << 11;
-    vcxt.values[idx].FpControlStatus.FpTag = 0;
-    for (i = 0; i < 8; ++i) {
-        vcxt.values[idx].FpControlStatus.FpTag |= (!env->fptags[i]) << i;
-    }
-    vcxt.values[idx].FpControlStatus.Reserved = 0;
-    vcxt.values[idx].FpControlStatus.LastFpOp = env->fpop;
-    vcxt.values[idx].FpControlStatus.LastFpRip = env->fpip;
-    idx += 1;
+        assert(idx == WHvX64RegisterGdtr);
+        vcxt.values[idx].Table.Base = env->gdt.base;
+        vcxt.values[idx].Table.Limit = env->gdt.limit;
+        idx += 1;
 
-    /* XMM control status register */
-    assert(whpx_register_names[idx] == WHvX64RegisterXmmControlStatus);
-    vcxt.values[idx].XmmControlStatus.LastFpRdp = 0;
-    vcxt.values[idx].XmmControlStatus.XmmStatusControl = env->mxcsr;
-    vcxt.values[idx].XmmControlStatus.XmmStatusControlMask = 0x0000ffff;
-    idx += 1;
+        /* CR0, 2, 3, 4, 8 */
+        assert(whpx_register_names[idx] == WHvX64RegisterCr0);
+        vcxt.values[idx++].Reg64 = env->cr[0];
+        assert(whpx_register_names[idx] == WHvX64RegisterCr2);
+        vcxt.values[idx++].Reg64 = env->cr[2];
+        assert(whpx_register_names[idx] == WHvX64RegisterCr3);
+        vcxt.values[idx++].Reg64 = env->cr[3];
+        assert(whpx_register_names[idx] == WHvX64RegisterCr4);
+        vcxt.values[idx++].Reg64 = env->cr[4];
+        assert(whpx_register_names[idx] == WHvX64RegisterCr8);
+        vcxt.values[idx++].Reg64 = vcpu->tpr;
 
-    /* MSRs */
-    assert(whpx_register_names[idx] == WHvX64RegisterEfer);
-    vcxt.values[idx++].Reg64 = env->efer;
+        /* 8 Debug Registers - Skipped */
+
+        /*
+         * Extended control registers needs to be handled separately depending
+         * on whether xsave is supported/enabled or not.
+         */
+        whpx_set_xcrs(cpu);
+
+        /* 16 XMM registers */
+        assert(whpx_register_names[idx] == WHvX64RegisterXmm0);
+        idx_next = idx + 16;
+        for (i = 0; i < sizeof(env->xmm_regs) / sizeof(ZMMReg); i += 1, idx += 1) {
+            vcxt.values[idx].Reg128.Low64 = env->xmm_regs[i].ZMM_Q(0);
+            vcxt.values[idx].Reg128.High64 = env->xmm_regs[i].ZMM_Q(1);
+        }
+        idx = idx_next;
+
+        /* 8 FP registers */
+        assert(whpx_register_names[idx] == WHvX64RegisterFpMmx0);
+        for (i = 0; i < 8; i += 1, idx += 1) {
+            vcxt.values[idx].Fp.AsUINT128.Low64 = env->fpregs[i].mmx.MMX_Q(0);
+            /* vcxt.values[idx].Fp.AsUINT128.High64 =
+                       env->fpregs[i].mmx.MMX_Q(1);
+            */
+        }
+
+        /* FP control status register */
+        assert(whpx_register_names[idx] == WHvX64RegisterFpControlStatus);
+        vcxt.values[idx].FpControlStatus.FpControl = env->fpuc;
+        vcxt.values[idx].FpControlStatus.FpStatus =
+            (env->fpus & ~0x3800) | (env->fpstt & 0x7) << 11;
+        vcxt.values[idx].FpControlStatus.FpTag = 0;
+        for (i = 0; i < 8; ++i) {
+            vcxt.values[idx].FpControlStatus.FpTag |= (!env->fptags[i]) << i;
+        }
+        vcxt.values[idx].FpControlStatus.Reserved = 0;
+        vcxt.values[idx].FpControlStatus.LastFpOp = env->fpop;
+        vcxt.values[idx].FpControlStatus.LastFpRip = env->fpip;
+        idx += 1;
+
+        /* XMM control status register */
+        assert(whpx_register_names[idx] == WHvX64RegisterXmmControlStatus);
+        vcxt.values[idx].XmmControlStatus.LastFpRdp = 0;
+        vcxt.values[idx].XmmControlStatus.XmmStatusControl = env->mxcsr;
+        vcxt.values[idx].XmmControlStatus.XmmStatusControlMask = 0x0000ffff;
+        idx += 1;
+
+        /* MSRs */
+        assert(whpx_register_names[idx] == WHvX64RegisterEfer);
+        vcxt.values[idx++].Reg64 = env->efer;
 #ifdef TARGET_X86_64
-    assert(whpx_register_names[idx] == WHvX64RegisterKernelGsBase);
-    vcxt.values[idx++].Reg64 = env->kernelgsbase;
+        assert(whpx_register_names[idx] == WHvX64RegisterKernelGsBase);
+        vcxt.values[idx++].Reg64 = env->kernelgsbase;
 #endif
 
-    assert(whpx_register_names[idx] == WHvX64RegisterApicBase);
-    vcxt.values[idx++].Reg64 = vcpu->apic_base;
+        assert(whpx_register_names[idx] == WHvX64RegisterApicBase);
+        vcxt.values[idx++].Reg64 = vcpu->apic_base;
 
-    /* WHvX64RegisterPat - Skipped */
+        /* WHvX64RegisterPat - Skipped */
 
-    assert(whpx_register_names[idx] == WHvX64RegisterSysenterCs);
-    vcxt.values[idx++].Reg64 = env->sysenter_cs;
-    assert(whpx_register_names[idx] == WHvX64RegisterSysenterEip);
-    vcxt.values[idx++].Reg64 = env->sysenter_eip;
-    assert(whpx_register_names[idx] == WHvX64RegisterSysenterEsp);
-    vcxt.values[idx++].Reg64 = env->sysenter_esp;
-    assert(whpx_register_names[idx] == WHvX64RegisterStar);
-    vcxt.values[idx++].Reg64 = env->star;
+        assert(whpx_register_names[idx] == WHvX64RegisterSysenterCs);
+        vcxt.values[idx++].Reg64 = env->sysenter_cs;
+        assert(whpx_register_names[idx] == WHvX64RegisterSysenterEip);
+        vcxt.values[idx++].Reg64 = env->sysenter_eip;
+        assert(whpx_register_names[idx] == WHvX64RegisterSysenterEsp);
+        vcxt.values[idx++].Reg64 = env->sysenter_esp;
+        assert(whpx_register_names[idx] == WHvX64RegisterStar);
+        vcxt.values[idx++].Reg64 = env->star;
 #ifdef TARGET_X86_64
-    assert(whpx_register_names[idx] == WHvX64RegisterLstar);
-    vcxt.values[idx++].Reg64 = env->lstar;
-    assert(whpx_register_names[idx] == WHvX64RegisterCstar);
-    vcxt.values[idx++].Reg64 = env->cstar;
-    assert(whpx_register_names[idx] == WHvX64RegisterSfmask);
-    vcxt.values[idx++].Reg64 = env->fmask;
+        assert(whpx_register_names[idx] == WHvX64RegisterLstar);
+        vcxt.values[idx++].Reg64 = env->lstar;
+        assert(whpx_register_names[idx] == WHvX64RegisterCstar);
+        vcxt.values[idx++].Reg64 = env->cstar;
+        assert(whpx_register_names[idx] == WHvX64RegisterSfmask);
+        vcxt.values[idx++].Reg64 = env->fmask;
 #endif
 
-    /* Interrupt / Event Registers - Skipped */
+        /* Interrupt / Event Registers - Skipped */
 
-    assert(idx == RTL_NUMBER_OF(whpx_register_names));
+        assert(idx == RTL_NUMBER_OF(whpx_register_names));
+    }
 
     hr = whp_dispatch.WHvSetVirtualProcessorRegisters(
         whpx->partition, cpu->cpu_index,
         whpx_register_names,
-        RTL_NUMBER_OF(whpx_register_names),
+        idx,
         &vcxt.values[0]);
 
     if (FAILED(hr)) {
@@ -613,7 +619,7 @@ void whpx_get_registers(CPUState *cpu, WHPXStateLevel level)
                      hr);
     }
 
-    if (whpx_irqchip_in_kernel()) {
+    if (level > WHPX_LEVEL_FAST_RUNTIME_STATE && whpx_irqchip_in_kernel()) {
         /*
          * Fetch the TPR value from the emulated APIC. It may get overwritten
          * below with the value from CR8 returned by
@@ -670,7 +676,7 @@ void whpx_get_registers(CPUState *cpu, WHPXStateLevel level)
     env->cr[4] = vcxt.values[idx++].Reg64;
     assert(whpx_register_names[idx] == WHvX64RegisterCr8);
     tpr = vcxt.values[idx++].Reg64;
-    if (tpr != vcpu->tpr) {
+    if (level > WHPX_LEVEL_FAST_RUNTIME_STATE && tpr != vcpu->tpr) {
         vcpu->tpr = tpr;
         cpu_set_apic_tpr(x86_cpu->apic_state, whpx_cr8_to_apic_tpr(tpr));
     }
@@ -756,7 +762,7 @@ void whpx_get_registers(CPUState *cpu, WHPXStateLevel level)
 
     assert(idx == RTL_NUMBER_OF(whpx_register_names));
 
-    if (whpx_irqchip_in_kernel()) {
+    if (level > WHPX_LEVEL_FAST_RUNTIME_STATE && whpx_irqchip_in_kernel()) {
         whpx_apic_get(x86_cpu->apic_state);
     }
 
-- 
2.53.0


