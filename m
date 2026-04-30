Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AD5ACD13DE
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 17:24:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIV7X-0005za-TR; Thu, 30 Apr 2026 13:24:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wIV77-0005eS-NO
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 13:23:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wIV73-0004gv-H5
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 13:23:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777569824;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mLdw2ydMXNFXEHn+CTFQymhvNp7XmbP6JDLR+ftycrQ=;
 b=CHE6oF9VamKW4lOtzQRJJg4AD5Zd+tXbh/jZ9O9nReYHWuHTLcyMgq6gmYtYRCR1GI/fzp
 QxYzMgJ3+ZnTj2+2qftCOWkhY/LS9pmkts5KN0lwp+48I4DMO8JtS4MA80f4IbfRLfKtIW
 1yAc0qmJPUvdb0O9CClxm+OSnFwbnXk=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-513-YuOer2nyMEykLTaSN30oVg-1; Thu, 30 Apr 2026 13:23:43 -0400
X-MC-Unique: YuOer2nyMEykLTaSN30oVg-1
X-Mimecast-MFC-AGG-ID: YuOer2nyMEykLTaSN30oVg_1777569823
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-50edf01172bso28677191cf.2
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 10:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1777569822; x=1778174622; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mLdw2ydMXNFXEHn+CTFQymhvNp7XmbP6JDLR+ftycrQ=;
 b=GRHl9tynTr3geASuxVGsHDyybqJfjE7kwnpVTvTcmZN5gwsOxio+MO6APQUpWr/lVC
 arNSOi8XzSJKuQbCCMBkroaZsyfY4hMdf+tVWp/aCosZzl2pDCC0sGFJseThq0WFOw1j
 DV+Z3O/6M/TAvculR9vnltbABjqdATkMyX12Ee8qYbJo/pLELxoSL7HoJFC8I9NIHlko
 mkS2o59jF35HfRCjBUikjOsXlOhsyVD9xOfWu4yykmNYXwc0kQqgg35VwyA+XZzPaszk
 Wg/GbNjiHwbImadaMscmK4qNy4wrQHKf9wcsVkkuZ8AC2ETUj3Dvzw+f5p6itrrNP2Oq
 rgpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777569822; x=1778174622;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mLdw2ydMXNFXEHn+CTFQymhvNp7XmbP6JDLR+ftycrQ=;
 b=Wkq6lD3+7TpgUe4/e810rA045Ow0YRlag6M9Rj6hPy5aGl6tgN/NiDApwwB2wJcQFm
 492lh2rLqga6we7UsAl5K/4mqO1mQcCR0ToGyigcv9oDggAjbHVM411g+itzvBU+C9OW
 Gb+5JArhR6YXZheJCSuLrQp15j9Q1eMTvIWsnYrlLRTGQa1/jTRNvSmjb9P/1j28VZ93
 eJuGG7W4Cnt1BYXGG24YJtVoFuecgV1inw3eQPgXiuVQ2+FdiIz2MDT77OR1izrQXA2T
 X9dpElKdNFLo3oz72JTXI1LRdNri5XJuldLkv6ulivwte4Adeh42JxycQeerQKGcQvYA
 LYAA==
X-Gm-Message-State: AOJu0Yzd9JXib66lBVqSnRvTfVNFKR0TfOtllkTfrwKMXT1GmcTfaM0U
 8kf2Eq4UGXO2SLcF8is3M+1DCVNM7ZorjOuGpdkzWX6P5eQgn37LDvSWVmgWeyWOQao1fojZ842
 Bmf2AA9QbNkwuE91CnQvgX0a9cttK4ly8QTqZvSy/wCr6pVOxYFDWNp6IT8gQuZ4dafw9gDvozh
 tbuMEzV9rbEw1ImdGKwSjFKesmvL2W+MiaMTBm/VmN
X-Gm-Gg: AeBDietWA0Z4gQ7HtAtek1bfIhAEWAVRw0vT5T1hrHV0H3Bau6pZm5kpXrfP5iyF7bs
 c2gaTdvXCD6DQJnVFB0uZ81w7WO8FsEBm8XECLamdMBnRYFVx0rueDDV0j4A3LBMfTluujtf0/M
 v4IDSuh5wff/EjMH0b8XEmAEjiuZvaRhw022xprVeKBlcJpmYkaFWfjC3ghHkl1ZvjiI7ji62l5
 iYD6KOlSgm4j7CnoIM4EfLpnA/K/xzWPbTBWaaG8E8ksOY3FbudyTI97txV+IYD8ZLyfUqzzVKV
 vKD8XTPt9Cy2X8weRlh6Bzd43veXvM6OwLEhuehnYuj03fI8rQt0Q8+0MUuhY1UybLcd232TzCe
 llTvmmm1wmKupNFZQKDSLfdMojo6Kr0QrI8Co7UNPX16B5lrpoOqcnSWyejbc4Y64FPCUUwrOnG
 enMAWDjFAiJiI47xTnHKsHYS1bloE80EVR23w=
X-Received: by 2002:a05:622a:1649:b0:50b:4778:ac60 with SMTP id
 d75a77b69052e-5102aaf8c62mr52020121cf.10.1777569822110; 
 Thu, 30 Apr 2026 10:23:42 -0700 (PDT)
X-Received: by 2002:a05:622a:1649:b0:50b:4778:ac60 with SMTP id
 d75a77b69052e-5102aaf8c62mr52019541cf.10.1777569821398; 
 Thu, 30 Apr 2026 10:23:41 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-5103d1c657bsm601411cf.3.2026.04.30.10.23.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 10:23:39 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PULL 30/58] whpx: i386: kernel-irqchip=off fixes
Date: Thu, 30 Apr 2026 19:21:36 +0200
Message-ID: <20260430172204.1006673-31-pbonzini@redhat.com>
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

This was really... quite broken. After fixing this,
Windows boots with kernel-irqchip=off.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Link: https://lore.kernel.org/r/20260422214225.2242-9-mohamed@unpredictable.fr
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/system/whpx-common.h |  1 +
 target/i386/whpx/whpx-all.c  | 43 +++++-------------------------------
 2 files changed, 7 insertions(+), 37 deletions(-)

diff --git a/include/system/whpx-common.h b/include/system/whpx-common.h
index 04289afd973..3406c20fec0 100644
--- a/include/system/whpx-common.h
+++ b/include/system/whpx-common.h
@@ -4,6 +4,7 @@
 
 struct AccelCPUState {
     bool window_registered;
+    int window_priority;
     bool interruptable;
     bool ready_for_pic_interrupt;
     uint64_t tpr;
diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 73e351d895d..d470c5b9d37 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -22,6 +22,8 @@
 #include "qemu/main-loop.h"
 #include "hw/core/boards.h"
 #include "hw/intc/ioapic.h"
+#include "hw/intc/i8259.h"
+#include "hw/i386/x86.h"
 #include "hw/i386/apic_internal.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
@@ -390,28 +392,6 @@ static int whpx_set_tsc(CPUState *cpu)
     return 0;
 }
 
-/*
- * The CR8 register in the CPU is mapped to the TPR register of the APIC,
- * however, they use a slightly different encoding. Specifically:
- *
- *     APIC.TPR[bits 7:4] = CR8[bits 3:0]
- *
- * This mechanism is described in section 10.8.6.1 of Volume 3 of Intel 64
- * and IA-32 Architectures Software Developer's Manual.
- *
- * The functions below translate the value of CR8 to TPR and vice versa.
- */
-
-static uint64_t whpx_apic_tpr_to_cr8(uint64_t tpr)
-{
-    return tpr >> 4;
-}
-
-static uint64_t whpx_cr8_to_apic_tpr(uint64_t cr8)
-{
-    return cr8 << 4;
-}
-
 void whpx_set_registers(CPUState *cpu, WHPXStateLevel level)
 {
     struct whpx_state *whpx = &whpx_global;
@@ -440,7 +420,7 @@ void whpx_set_registers(CPUState *cpu, WHPXStateLevel level)
     v86 = (env->eflags & VM_MASK);
     r86 = !(env->cr[0] & CR0_PE_MASK);
 
-    vcpu->tpr = whpx_apic_tpr_to_cr8(cpu_get_apic_tpr(x86_cpu->apic_state));
+    vcpu->tpr = cpu_get_apic_tpr(x86_cpu->apic_state);
     vcpu->apic_base = cpu_get_apic_base(x86_cpu->apic_state);
 
     idx = 0;
@@ -711,17 +691,6 @@ void whpx_get_registers(CPUState *cpu, WHPXStateLevel level)
                      hr);
     }
 
-    if (whpx_irqchip_in_kernel()) {
-        /*
-         * Fetch the TPR value from the emulated APIC. It may get overwritten
-         * below with the value from CR8 returned by
-         * WHvGetVirtualProcessorRegisters().
-         */
-        whpx_apic_get(x86_cpu->apic_state);
-        vcpu->tpr = whpx_apic_tpr_to_cr8(
-            cpu_get_apic_tpr(x86_cpu->apic_state));
-    }
-
     idx = 0;
 
     /* Indexes for first 16 registers match between HV and QEMU definitions */
@@ -770,7 +739,7 @@ void whpx_get_registers(CPUState *cpu, WHPXStateLevel level)
     tpr = vcxt.values[idx++].Reg64;
     if (tpr != vcpu->tpr) {
         vcpu->tpr = tpr;
-        cpu_set_apic_tpr(x86_cpu->apic_state, whpx_cr8_to_apic_tpr(tpr));
+        cpu_set_apic_tpr(x86_cpu->apic_state, tpr);
     }
 
     /* 8 Debug Registers - Skipped */
@@ -1775,7 +1744,7 @@ static void whpx_vcpu_pre_run(CPUState *cpu)
      }
 
     /* Sync the TPR to the CR8 if was modified during the intercept */
-    tpr = whpx_apic_tpr_to_cr8(cpu_get_apic_tpr(x86_cpu->apic_state));
+    tpr = cpu_get_apic_tpr(x86_cpu->apic_state);
     if (tpr != vcpu->tpr) {
         vcpu->tpr = tpr;
         reg_values[reg_count].Reg64 = tpr;
@@ -1822,7 +1791,7 @@ static void whpx_vcpu_post_run(CPUState *cpu)
     if (vcpu->tpr != tpr) {
         vcpu->tpr = tpr;
         bql_lock();
-        cpu_set_apic_tpr(x86_cpu->apic_state, whpx_cr8_to_apic_tpr(vcpu->tpr));
+        cpu_set_apic_tpr(x86_cpu->apic_state, vcpu->tpr);
         bql_unlock();
     }
 
-- 
2.54.0


