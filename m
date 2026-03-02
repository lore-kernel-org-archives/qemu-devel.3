Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A78EED58E7E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 08:57:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwyzZ-000737-Pu; Mon, 02 Mar 2026 03:51:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwyxQ-0003Nc-No
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:48:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwyxP-0002Gd-5x
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:48:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772441330;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AHNaxLarWljLka2XaII0MzS1ca+rKXfEhW8B8+QmmuU=;
 b=bd+UXGsSDxejzWkEKhauLBPQkde3UItnls8unXaeDEq4F/+ducLprDoPV6RdjdmqhDvXE2
 B4lBSr0PXaCSA8yjwyR8Ms+qSeg4ZdqWOgPcMjjR7Z1h+Nax2WUZAufaTNB6ZD/2AXQ6aJ
 tuUct7ACCFQbM+N86r+Ok4xiwRxC6m4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-9T7iuVU0PsuJChBSrUrUgw-1; Mon, 02 Mar 2026 03:48:43 -0500
X-MC-Unique: 9T7iuVU0PsuJChBSrUrUgw-1
X-Mimecast-MFC-AGG-ID: 9T7iuVU0PsuJChBSrUrUgw_1772441322
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-48372facfedso37394335e9.0
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 00:48:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772441321; x=1773046121; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AHNaxLarWljLka2XaII0MzS1ca+rKXfEhW8B8+QmmuU=;
 b=VS5aIJFtyqRTD8pSiOyNAmynHBP16R7JMJbtkJegXyD143mOa8+cLX7PrE9M425TxS
 pAEVHG3GpJSRyejhzAS6uWxaJZSwrWNlxfgTmOjaj7pXuWhXWclglZrW1+SGn2CLmRFU
 dHs+TEVDDsTkphDlJXRZES5OOIadWa9a5ePe/2C+sFCJAICXSaih4PCQX4ScAgv65jyM
 hv5z/kCiUmm3JJU1yBuDWP2xIr3zsnBBA+cs0xTCloWtpc4UfOR0TgnFmcnmxTLjaDvk
 E5PrliTlMrcmJyTFgDkCDEUhGkLkpns+2RdYsQWlgT/MUsCTkabEurxoT5XjLe9AQJYO
 eIqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772441321; x=1773046121;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=AHNaxLarWljLka2XaII0MzS1ca+rKXfEhW8B8+QmmuU=;
 b=HxKTCRJWdI76/eUdGWmoebm9D/ql3zzCWUFhoYyQeDgSHWV5pWHJ0hao2b2M0fmkcr
 3NXzCsa3judY0WmSjKp9TjmpmKz/TUvH7pgM+FwLUzQHBso1cZl8XUB01HGkl03P4poK
 E1yk8zhYboLT//NZqB6nkL/txjdpcpmd3sUb0yQwvvD81nBZh8S2A0rhwwWdA7OPWCbh
 f52r2nM0Id8zBgdJhEe7upTH98ilCysJ7r8ofxptiMBkNqavHgE54QQ4jCKqP9DhCTz0
 pf18BC4yrxyP6/8EM48mQb7Al/ZfIe8bwp3on93A0mrLks5sfowj86LLokNd+arD1/Aa
 FVsg==
X-Gm-Message-State: AOJu0YyCAcKYJfHZaSdgczGBkzq1fLK1XULj70dc6cWfT0L1Ym0sCfV2
 slS2/kzLlGDlX1hxbXPxMzHOIWwyg3JVNY/WufLMjCQtRUAiG///Gcgmdzf0+uZHXrgh+SFsuq7
 vkkRo2uLjya/gz6lVAyxqNtdP4zUUD5JYFpC9tasXn3tfLpeoVZT/S7i3z1Y0GHdmSRkVj/V1yP
 /aVGnO8KH83czFQdFtN3t3ouz0iUxcL7H2NLkPmEPK
X-Gm-Gg: ATEYQzwgHdAE9b0fvSTC1aLoNiXLa2SLrpfHuHMDQ7R1fmf4lYCk4552SA1noltXhlc
 irvbwQcLiQGtfzN6/hBDKeWHxUgEehsh75Fr8QnSgcR253vIhEejpYh5spx4DaoSTr8jeRuJMZZ
 SGHOkwuOT9xzOCqi5lKt/t4eUJWOxGBe/Kxhd4X8Q5cCwP/9T4agRwlqv97AkD/uJNraNhxHkN6
 jF0dqgHgC6KbDunCTjhj2qfEyFnDdYLuiczj9IRxXJjZgipeQ9+6q63xdE18W40JKDyLCq4Cnhu
 /Wqu7yKVgL405XznHMaJgcF2BwrFraragd6rYOiAwOBwYY76y9giO8+UaO609yIzu/x4sHRMcAh
 Pk1r68tvx6xbX+A5/imoYEBQi4epxWkEvL4Vm3hO8JyU2d2oI38uKh5PGH6RFk81gsT4St7YLFw
 BdmnH8pko9Vz9ofZdBwiMViUdWEUU=
X-Received: by 2002:a05:600c:c16e:b0:475:ddad:c3a9 with SMTP id
 5b1f17b1804b1-483c99348c5mr202711665e9.13.1772441320774; 
 Mon, 02 Mar 2026 00:48:40 -0800 (PST)
X-Received: by 2002:a05:600c:c16e:b0:475:ddad:c3a9 with SMTP id
 5b1f17b1804b1-483c99348c5mr202711195e9.13.1772441320229; 
 Mon, 02 Mar 2026 00:48:40 -0800 (PST)
Received: from [192.168.10.48] ([151.95.144.138])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bd6f3124sm395292325e9.1.2026.03.02.00.48.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2026 00:48:38 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PULL 086/102] hw: i386: vapic: enable on WHPX with user-mode irqchip
Date: Mon,  2 Mar 2026 09:47:32 +0100
Message-ID: <20260302084749.474955-20-pbonzini@redhat.com>
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

Alleviate a performance bottleneck on legacy Windows guests.

In my test setup, this makes Windows XP boot times be 20x faster
than they're otherwise.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Link: https://lore.kernel.org/r/20260226181930.53170-4-mohamed@unpredictable.fr
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/i386/vapic.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/hw/i386/vapic.c b/hw/i386/vapic.c
index 670a50524d6..41e5ca26dfd 100644
--- a/hw/i386/vapic.c
+++ b/hw/i386/vapic.c
@@ -16,6 +16,7 @@
 #include "system/cpus.h"
 #include "system/hw_accel.h"
 #include "system/kvm.h"
+#include "system/whpx.h"
 #include "system/runstate.h"
 #include "system/address-spaces.h"
 #include "hw/i386/apic_internal.h"
@@ -229,7 +230,8 @@ static int evaluate_tpr_instruction(VAPICROMState *s, X86CPU *cpu,
         return -1;
     }
 
-    if (kvm_enabled() && !kvm_irqchip_in_kernel()) {
+    if ((kvm_enabled() && !kvm_irqchip_in_kernel())
+        || (whpx_enabled() && !whpx_irqchip_in_kernel())) {
         /*
          * KVM without kernel-based TPR access reporting will pass an IP that
          * points after the accessing instruction. So we need to look backward
@@ -549,7 +551,7 @@ static int patch_hypercalls(VAPICROMState *s)
     cpu_physical_memory_read(rom_paddr, rom, s->rom_size);
 
     for (pos = 0; pos < s->rom_size - sizeof(vmcall_pattern); pos++) {
-        if (kvm_irqchip_in_kernel()) {
+        if (kvm_enabled() && kvm_irqchip_in_kernel()) {
             pattern = outl_pattern;
             alternates[0] = outl_pattern[7];
             alternates[1] = outl_pattern[7];
@@ -679,16 +681,25 @@ static void vapic_write(void *opaque, hwaddr addr, uint64_t data,
         }
         break;
     case 1:
-        if (kvm_enabled()) {
+        if (kvm_enabled() || (whpx_enabled() && !whpx_irqchip_in_kernel())) {
             /*
              * Disable triggering instruction in ROM by writing a NOP.
              *
              * We cannot do this in TCG mode as the reported IP is not
              * accurate.
+             *
+             * Oddly enough, KVM increments EIP _before_ the execution
+             * of the instruction is finished.
              */
             pause_all_vcpus();
-            patch_byte(cpu, env->eip - 2, 0x66);
-            patch_byte(cpu, env->eip - 1, 0x90);
+            if (!kvm_enabled()) {
+                patch_byte(cpu, env->eip, 0x66);
+                patch_byte(cpu, env->eip + 1, 0x90);
+            }
+            else {
+                patch_byte(cpu, env->eip - 2, 0x66);
+                patch_byte(cpu, env->eip - 1, 0x90);
+            }
             resume_all_vcpus();
         }
 
@@ -705,7 +716,8 @@ static void vapic_write(void *opaque, hwaddr addr, uint64_t data,
         break;
     default:
     case 4:
-        if (!kvm_irqchip_in_kernel()) {
+        if ((kvm_enabled() && !kvm_irqchip_in_kernel())
+          || (whpx_enabled() && !whpx_irqchip_in_kernel())) {
             apic_poll_irq(cpu->apic_state);
         }
         break;
-- 
2.53.0


