Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5F05C83F0A
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 11:03:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXHgA-0007LG-3Z; Thu, 03 Jul 2025 07:00:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXHdE-0004la-DM
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 06:57:37 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXHdC-0001rf-MM
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 06:57:32 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-45348bff79fso55545805e9.2
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 03:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751540249; x=1752145049; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LFRxRvBg/Kw+lCEJUMnsPGlqNMegEysmKneUwCu7PxI=;
 b=gGutHCgBqi7gIefGuBOkXImK5uPbwBjnynCMpi9upDQhez4DdhcBl/VVNE5od69by3
 Z9WWf6TIiKvF14HVg0yc062ksRAFWetE62mocBTUmq0RJT3uGzi26fsw7BxcQoS+ntDc
 Qf6DINCZUdcDqox6VNUBd+qAj4jAdGdxrW7LEuc1sgowfsURGRkq4fQ3PRHklOa4TUOy
 qyXwWLoPBCoWEAwQ+5nXCeZpeu8ZE7RlL89CnmAEHR1aCfzc/CvnxzIuwPANHw59Wuzq
 QBZXGEngi2RBjCg9+nqHo4jyGX99Y6Oky1EvmrtHst29SoNUU7brikRFgJSiPC2ubke4
 Vz/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751540249; x=1752145049;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LFRxRvBg/Kw+lCEJUMnsPGlqNMegEysmKneUwCu7PxI=;
 b=Ad19o6Q0N1crS0IAxcWct/hdik9jyg6bYSUWZBEVfbKehjNJFtczqrlSk8xsmZhMeF
 XinGNNL1OoWIK8Q5kfsWbW36VhVPK87DSBwqr7R396uDeoriAUVky1I7TZdWmKpNQEEv
 ED6G4RWedDCHvZunIWGnaqmWc9wduFEw8Jv7KZoMwnNy52BMM+6hgQxHA6Rdq1GVYVg2
 oJJVOu3fZaf7u2ZwXSw7bs3C9HNVBVbaHuwoG06avhCiGYaA2M6M5+HYVz28equFEc9O
 RLRuChFBWpMCWcLvnZZsAsKr/4cQ8hvfnTbdpUMg9++hcb+NTxd+IWxS6a6DbEqFTdQF
 OFgQ==
X-Gm-Message-State: AOJu0YzI8QQaUqnyNKPk84jIfQL+iKlp3iPMd2XJEoncz+gfO3+ORt34
 swXvex3Y57y+RnbvpOuol8D19btho7Th17cTPDayjBfEdsKXBGxnyLflxcKk6BON6actpTqYlMJ
 pP8J20lE=
X-Gm-Gg: ASbGncs9mKZ4rDGd0B5KaPnqZRSwyR+WD2AA4XySi1VTrORXjeDdb8rhq033x4PNCCf
 A2gZx2sGJqeWogmSquP/qH7zgEkCjUgsK5+nU3oUg4nA+Xr994eN7g407zg/7abd995djbLq9C1
 K40TilC85DRzXIXsIXGs2k9MyFMGN+T99B2640YFdiH6FaWHJp4FplRIRagslSwJ9c9EcWW/aP3
 cGa6F9YYHkcc+XiFUXUUXQ3Zj4t5Zg+0iYdK6cJiHAI8kdZRniniewcaNq5JpM8Cxc/7ovD8Ltl
 sw8kev0ts4dCIIOXOldAIqKIqN6YjRCi9SVn+J5MutgESNvZKoppaErCzQUayDpR/1qDXxfHyz6
 N02m3DsEdE9E=
X-Google-Smtp-Source: AGHT+IGbW0znf+hbz18B0RsM2MuWbTAgJCt01aIieGYP5RHDzWd9uLU880IDur91SfMRbbEPcg0G+g==
X-Received: by 2002:a05:600c:4f84:b0:450:d37c:9fc8 with SMTP id
 5b1f17b1804b1-454a3e1a96amr68969665e9.13.1751540248698; 
 Thu, 03 Jul 2025 03:57:28 -0700 (PDT)
Received: from localhost.localdomain ([83.247.137.20])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454a9bde8c8sm23739305e9.31.2025.07.03.03.57.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Jul 2025 03:57:28 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, kvm@vger.kernel.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v5 20/69] accel: Move cpu_common_[un]realize() declarations to
 AccelOpsClass
Date: Thu,  3 Jul 2025 12:54:46 +0200
Message-ID: <20250703105540.67664-21-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250703105540.67664-1-philmd@linaro.org>
References: <20250703105540.67664-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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


