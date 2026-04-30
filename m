Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2E07FF8873
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 17:31:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIV7j-0007LB-MC; Thu, 30 Apr 2026 13:24:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wIV7B-0005iJ-0Z
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 13:23:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wIV77-0004hI-9v
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 13:23:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777569827;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2Wc1TGXWRaRkTUOIeFKCA6LN9gc3pqEx/i8/Vgj91Ac=;
 b=ALtNdupFkdCBIHBhL8fWnfpGB3kVjt98kYQHIR+p7qnnpKAwcpXXgP3Gg8ndvJll8gECk0
 v1LBNL2l7sMmffuwqXtUQECdg1StvRiBkT6gqcWEk8WTX3fTR5LkoIA7Fv0j1b8m1nrwil
 KsyHd2PIpFZ067AwJdoDgITXW6vacVc=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-70-D8M8DYexMFWaKioY8wHQRw-1; Thu, 30 Apr 2026 13:23:46 -0400
X-MC-Unique: D8M8DYexMFWaKioY8wHQRw-1
X-Mimecast-MFC-AGG-ID: D8M8DYexMFWaKioY8wHQRw_1777569826
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-50fb6d713ddso19730641cf.1
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 10:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1777569825; x=1778174625; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2Wc1TGXWRaRkTUOIeFKCA6LN9gc3pqEx/i8/Vgj91Ac=;
 b=WY6Jz2+XEbDuEK2SBeh9/p/TEYNkvXBfvU/+NhUzHh2b4fkKB2czvWunNKjuzv79iY
 b4wRY9S6N5LcsYrukKQm5NRjXVRqH4qpaU+JprP4o7X3tdsnw1dr5VVautdc5/ndDiWl
 PJJkT17xKsF7vTcWjLZFJi/KvZeDqVemViRyqL0bPmiMxh9bYyygDjtl5n70AR/P3xaV
 d28do2H/ZsudYmweoIVEB3a0ATdaj1/vDNUzkewg935OOvUyJIef/NeY+3jz62eum95G
 0I+UydwPX/nlJkhBryoR0PwvJkW9AnQDZJV8VbOtclRRCtsrDDn0cuPNefwVEG9T22RZ
 6ASw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777569825; x=1778174625;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2Wc1TGXWRaRkTUOIeFKCA6LN9gc3pqEx/i8/Vgj91Ac=;
 b=VOlILwCtPYxGMEwPCdOXRo6N8LXnc3ygkQJth/gc/xkxsFHqAp1OTeGxKIKZhHHDE6
 +PpXKbcaX2Qg86qGzWFBAF6voElUAdgLZgShJjrpPjuJ3IU9E0iL9HW0Q5IMp4aJJLkf
 +9N/7VQMCZyjbJGqUSsVIZjMRVDpeeNiHKVzQ+OZoi0XCHM9EXAPN79f0nKfXJf2bghh
 zemuDvmPw6zckS+EUdjwBtrv35i1JZaCZtBaRObPrhiJ+vW8Qxp3e20BWStGKKHkXH+O
 4k0JZylfbDEr6W6CIsKF52+odfoa3VYd3lipXdrHsMmTlUFoGeq0gstl25mgUABkm58P
 EK9g==
X-Gm-Message-State: AOJu0YxJtmHd7GtvVTngMnplWE3zb/cih+bVVHh6n3B8a7Yi5BSL9pOL
 n+QhdT8f3bt7kGsBzeyMyHUS4MqjJA71W9gdJF4mDNkqGPWGOFvLkf5mr4H315zAcKS6TrmSaY2
 gmLoAK8Qh57Q4k5/HOwkVHz3FX79U4JbvWPoGESI0Ol9fr7fWvrKxbx0YnloqwBfWn/jWArDNNH
 yG86wGS80tGzJQ7/nO8G0jTyaW/GOYz3fm3pmWagZu
X-Gm-Gg: AeBDievB+NRA8wXf9e/j3n5GkyINwaj5Hlvxi1EtbQMZylpnPPRHcD0LmnKS8xNho9a
 opKw3tl6K8fCt6ZtstPDz23v1I9MS9bM66mrc/rjvyQWU/Zu3CyRoW1QugBVASyPHYIrpC6h2io
 tF8PRm0PkeU/oJ41gjvnJHOXSyxd5BNJQYZ+2GAugVJFQrX1drdsKJK9Flz3xFnAiajnmau7gVF
 h8O025U8fjenwtmlJeXgqDnYDrtjTGAkNGfHhmULh95Yf+AoKyj7VS9/Jtpaly+c3qp8/mxMCVi
 iJGEkV5sPCcsYn2i+GFweiI0t1B5G/vFJF9MdtyauJQKeNYn+LQZy6OjBXTGrwZ8wVxuLIKee+1
 jCh1rF78ifWkh265v7IV9PO1Ai6QGeN2MgDz0hRfHkhapSpHGPEzOKvq+mouQ+3qn8usQVNwqeC
 QgDR35gpn+tuLVGUYrwhRXqxAsR4nlVFe+KSo=
X-Received: by 2002:a05:622a:513:b0:50f:b81e:c655 with SMTP id
 d75a77b69052e-5102afa4e75mr53971391cf.57.1777569825130; 
 Thu, 30 Apr 2026 10:23:45 -0700 (PDT)
X-Received: by 2002:a05:622a:513:b0:50f:b81e:c655 with SMTP id
 d75a77b69052e-5102afa4e75mr53970681cf.57.1777569824459; 
 Thu, 30 Apr 2026 10:23:44 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-5103d1c66edsm771311cf.1.2026.04.30.10.23.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 10:23:43 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PULL 31/58] whpx: i386: use WHvX64RegisterCr8 only when
 kernel-irqchip=off
Date: Thu, 30 Apr 2026 19:21:37 +0200
Message-ID: <20260430172204.1006673-32-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260430172204.1006673-1-pbonzini@redhat.com>
References: <20260430172204.1006673-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

When kernel-irqchip=on, manage TPR as part of the APIC state instead entirely.

This fixes some failure to set state errors.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Link: https://lore.kernel.org/r/20260422214225.2242-10-mohamed@unpredictable.fr
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/whpx/whpx-all.c | 37 ++++++++++++++++++++++---------------
 1 file changed, 22 insertions(+), 15 deletions(-)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index d470c5b9d37..03c146dfb8c 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -95,7 +95,6 @@ static const WHV_REGISTER_NAME whpx_register_names[] = {
     WHvX64RegisterCr2,
     WHvX64RegisterCr3,
     WHvX64RegisterCr4,
-    WHvX64RegisterCr8,
 
     /* X64 Debug Registers */
     /*
@@ -478,8 +477,11 @@ void whpx_set_registers(CPUState *cpu, WHPXStateLevel level)
         vcxt.values[idx++].Reg64 = env->cr[3];
         assert(whpx_register_names[idx] == WHvX64RegisterCr4);
         vcxt.values[idx++].Reg64 = env->cr[4];
-        assert(whpx_register_names[idx] == WHvX64RegisterCr8);
-        vcxt.values[idx++].Reg64 = vcpu->tpr;
+        /* For kernel-irqchip=on, TPR is managed as part of APIC state */
+        if (!whpx_irqchip_in_kernel()) {
+            WHV_REGISTER_VALUE cr8 = {.Reg64 = vcpu->tpr};
+            whpx_set_reg(cpu, WHvX64RegisterCr8, cr8);
+        }
 
         /* 8 Debug Registers - Skipped */
 
@@ -735,11 +737,14 @@ void whpx_get_registers(CPUState *cpu, WHPXStateLevel level)
     env->cr[3] = vcxt.values[idx++].Reg64;
     assert(whpx_register_names[idx] == WHvX64RegisterCr4);
     env->cr[4] = vcxt.values[idx++].Reg64;
-    assert(whpx_register_names[idx] == WHvX64RegisterCr8);
-    tpr = vcxt.values[idx++].Reg64;
-    if (tpr != vcpu->tpr) {
-        vcpu->tpr = tpr;
-        cpu_set_apic_tpr(x86_cpu->apic_state, tpr);
+
+    /* For kernel-irqchip=on, TPR is managed as part of APIC state */
+    if (!whpx_irqchip_in_kernel()) {
+        tpr = vcpu->exit_ctx.VpContext.Cr8;
+        if (tpr != vcpu->tpr) {
+            vcpu->tpr = tpr;
+            cpu_set_apic_tpr(x86_cpu->apic_state, tpr);
+        }
     }
 
     /* 8 Debug Registers - Skipped */
@@ -1745,7 +1750,7 @@ static void whpx_vcpu_pre_run(CPUState *cpu)
 
     /* Sync the TPR to the CR8 if was modified during the intercept */
     tpr = cpu_get_apic_tpr(x86_cpu->apic_state);
-    if (tpr != vcpu->tpr) {
+    if (!whpx_irqchip_in_kernel() && tpr != vcpu->tpr) {
         vcpu->tpr = tpr;
         reg_values[reg_count].Reg64 = tpr;
         qatomic_set(&cpu->exit_request, true);
@@ -1787,12 +1792,14 @@ static void whpx_vcpu_post_run(CPUState *cpu)
 
     env->eflags = vcpu->exit_ctx.VpContext.Rflags;
 
-    uint64_t tpr = vcpu->exit_ctx.VpContext.Cr8;
-    if (vcpu->tpr != tpr) {
-        vcpu->tpr = tpr;
-        bql_lock();
-        cpu_set_apic_tpr(x86_cpu->apic_state, vcpu->tpr);
-        bql_unlock();
+    if (!whpx_irqchip_in_kernel()) {
+        uint64_t tpr = vcpu->exit_ctx.VpContext.Cr8;
+        if (vcpu->tpr != tpr) {
+            vcpu->tpr = tpr;
+            bql_lock();
+            cpu_set_apic_tpr(x86_cpu->apic_state, vcpu->tpr);
+            bql_unlock();
+        }
     }
 
     vcpu->interruption_pending =
-- 
2.54.0


