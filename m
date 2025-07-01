Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC14FC7EE30
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 14:49:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWcBj-0007tf-CN; Tue, 01 Jul 2025 10:42:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWcBX-0007eC-I5
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 10:42:12 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWcBU-0006y4-Ci
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 10:42:11 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3a503d9ef59so2661717f8f.3
 for <qemu-devel@nongnu.org>; Tue, 01 Jul 2025 07:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751380924; x=1751985724; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LFRxRvBg/Kw+lCEJUMnsPGlqNMegEysmKneUwCu7PxI=;
 b=t64ScGOKqx7l/2Z3n6TxcfqOIWjiaUOEVOeCw611W05tYQn1y9MnbiRbX/NjZ8V0GX
 UDld39GOOf5BUDJvyVH9KLnddpUMfxPKOTkKYw7jlRGCc8nw4ekhqMc9JtQm7LQpt+8N
 nuqZ1hejEC+KY2JYKwMRYDhRStuggxAu/kP7+fv/TQvFZ8e9VDGsiADQ4pZj8bnsLAZn
 rle1whYJMRAR06iv9oVABKYWp4hyiN4XL1BsZRjutcMM9Fd47BI1p7evwQ2PZUbKJCHO
 VOaP9shzzQU7BoGyDpR+P4UaIxY9mNs7WbeWT3L5dsdeQP1BgblL7xaU/url+PkPcC1w
 ldKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751380925; x=1751985725;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LFRxRvBg/Kw+lCEJUMnsPGlqNMegEysmKneUwCu7PxI=;
 b=oS04UYgtfRv/gDKEI7FElV2bJI8BVRE2kDHzydxmBX+NFywZBkn/DjZIDbZpuyqEaD
 d5EA0xgsWCp5m5iW0iHZfqUzj/t9ukS/KrQz+/vFgC/6sJwPmBPcK27tp5icsG1Nd29+
 gwMCovoXUNZtx0FKFiuLScB/+IUx4DhQaOYP3o8RDWDmanlYlzrywbQzEODmMpKuIXLV
 lNDPkpKfyVGlbOjvgj0JRrR88Fh6/renLP2ktXd+UDcWw2Txt1NWv4up9ezcUyhJOMUV
 25UMJWPEDXvBHWCPtb21IEmgz01IJiSiFxrd7PgBtnbaDDbQV+J0VD4NEYOdXuTKP6rd
 RYXg==
X-Gm-Message-State: AOJu0Ywvb8swZuuy5aX8iJWGMS+1QF8XezBaS2+5M2xYvWDFTOfi2bpX
 w2WKg0E+qEKa/37bt8O9wNQxPhcAPgQCtxnKxbQyeApybuWybOKR0Mh8EmPyQHZrcPWQ8Ux6nmt
 miqG9
X-Gm-Gg: ASbGncvVyz/UlWUlTQl6N6xN8yVQ++xDG9GK4KKGQ8+6RZz/8UGeF4u8nxyDeqCXK1D
 6EEYwrcs4mXL/OzJzJq0LcOy7yGP0x8WIIZxQwPGaiMoKBqL/VomGneqdXO/WDD+W4cmQThFI22
 QMvrx1cukt27iFbalJpHMi6IlZv9zLg/dm6O2VJGMbGB+Ci7AS3sg0kfY5zrjD5vUSgoufFCvNW
 qsx7xkdHF7Ou1UHE+DK9rxGBXGHW8m2wluTx07GeEbGNSaZ5Lj2+aRWeBxLYmCIGYI9Kk6CJpUm
 rbIxfVaWM3ik8+t1lSlKTzD0a/P6I+NN8H87SgfLYtWWNn8/nSVakbhpS4CV2D6BQzqwE83XdBm
 cFen9Cp5akdtV0jHoWm2JTxvZspC/zYEpKILM
X-Google-Smtp-Source: AGHT+IF93A9KwT/lUdcnOGKDkHe1rS81T1pd/gHS1KwzdA1SIql09KPq0erhR6pRIH+B1EWZ+HdpYg==
X-Received: by 2002:a5d:5849:0:b0:3a5:8934:4940 with SMTP id
 ffacd0b85a97d-3a8feb70269mr15510902f8f.50.1751380924437; 
 Tue, 01 Jul 2025 07:42:04 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a88c7ec6aesm13453631f8f.5.2025.07.01.07.42.02
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 01 Jul 2025 07:42:03 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Julian Armistead <julian.armistead@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 19/68] accel: Move cpu_common_[un]realize() declarations to
 AccelOpsClass
Date: Tue,  1 Jul 2025 16:39:27 +0200
Message-ID: <20250701144017.43487-20-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250701144017.43487-1-philmd@linaro.org>
References: <20250701144017.43487-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

AccelClass is for methods dealing with AccelState.
When dealing with vCPUs, we want AccelOpsClass.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/qemu/accel.h       |  2 --
 include/system/accel-ops.h |  2 ++
 accel/accel-common.c       | 10 ++++++----
 accel/tcg/tcg-accel-ops.c  |  3 +++
 accel/tcg/tcg-all.c        |  2 --
 5 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/include/qemu/accel.h b/include/qemu/accel.h
index 3c6350d6d63..518c99ab643 100644
--- a/include/qemu/accel.h
+++ b/include/qemu/accel.h
@@ -41,8 +41,6 @@ typedef struct AccelClass {
     AccelOpsClass *ops;
 
     int (*init_machine)(AccelState *as, MachineState *ms);
-    bool (*cpu_common_realize)(CPUState *cpu, Error **errp);
-    void (*cpu_common_unrealize)(CPUState *cpu);
 
     /* system related hooks */
     void (*setup_post)(AccelState *as);
diff --git a/include/system/accel-ops.h b/include/system/accel-ops.h
index d854b84a66a..fb199dc78f0 100644
--- a/include/system/accel-ops.h
+++ b/include/system/accel-ops.h
@@ -34,6 +34,8 @@ struct AccelOpsClass {
     /* initialization function called when accel is chosen */
     void (*ops_init)(AccelClass *ac);
 
+    bool (*cpu_common_realize)(CPUState *cpu, Error **errp);
+    void (*cpu_common_unrealize)(CPUState *cpu);
     bool (*cpu_target_realize)(CPUState *cpu, Error **errp);
     void (*cpu_reset_hold)(CPUState *cpu);
 
diff --git a/accel/accel-common.c b/accel/accel-common.c
index 1d04610f55e..d1a5f3ca3df 100644
--- a/accel/accel-common.c
+++ b/accel/accel-common.c
@@ -102,10 +102,12 @@ bool accel_cpu_common_realize(CPUState *cpu, Error **errp)
     }
 
     /* generic realization */
-    if (acc->cpu_common_realize && !acc->cpu_common_realize(cpu, errp)) {
+    if (acc->ops->cpu_common_realize
+        && !acc->ops->cpu_common_realize(cpu, errp)) {
         return false;
     }
-    if (acc->ops->cpu_target_realize && !acc->ops->cpu_target_realize(cpu, errp)) {
+    if (acc->ops->cpu_target_realize
+        && !acc->ops->cpu_target_realize(cpu, errp)) {
         return false;
     }
 
@@ -118,8 +120,8 @@ void accel_cpu_common_unrealize(CPUState *cpu)
     AccelClass *acc = ACCEL_GET_CLASS(accel);
 
     /* generic unrealization */
-    if (acc->cpu_common_unrealize) {
-        acc->cpu_common_unrealize(cpu);
+    if (acc->ops->cpu_common_unrealize) {
+        acc->ops->cpu_common_unrealize(cpu);
     }
 }
 
diff --git a/accel/tcg/tcg-accel-ops.c b/accel/tcg/tcg-accel-ops.c
index 07b1ec4ea50..95ff451c148 100644
--- a/accel/tcg/tcg-accel-ops.c
+++ b/accel/tcg/tcg-accel-ops.c
@@ -46,6 +46,7 @@
 #include "tcg-accel-ops-mttcg.h"
 #include "tcg-accel-ops-rr.h"
 #include "tcg-accel-ops-icount.h"
+#include "internal-common.h"
 
 /* common functionality among all TCG variants */
 
@@ -212,6 +213,8 @@ static void tcg_accel_ops_init(AccelClass *ac)
         }
     }
 
+    ops->cpu_common_realize = tcg_exec_realizefn;
+    ops->cpu_common_unrealize = tcg_exec_unrealizefn;
     ops->cpu_reset_hold = tcg_cpu_reset_hold;
     ops->insert_breakpoint = tcg_insert_breakpoint;
     ops->remove_breakpoint = tcg_remove_breakpoint;
diff --git a/accel/tcg/tcg-all.c b/accel/tcg/tcg-all.c
index 93972bc0919..ae83ca0bd10 100644
--- a/accel/tcg/tcg-all.c
+++ b/accel/tcg/tcg-all.c
@@ -244,8 +244,6 @@ static void tcg_accel_class_init(ObjectClass *oc, const void *data)
     AccelClass *ac = ACCEL_CLASS(oc);
     ac->name = "tcg";
     ac->init_machine = tcg_init_machine;
-    ac->cpu_common_realize = tcg_exec_realizefn;
-    ac->cpu_common_unrealize = tcg_exec_unrealizefn;
     ac->allowed = &tcg_allowed;
     ac->supports_guest_debug = tcg_supports_guest_debug;
     ac->gdbstub_supported_sstep_flags = tcg_gdbstub_supported_sstep_flags;
-- 
2.49.0


