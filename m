Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD92EF9EDC9
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 13:04:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFXE1-0001BP-4U; Wed, 22 Apr 2026 09:02:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wFXDy-00019v-SL
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 09:02:38 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wFXDx-00019e-9k
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 09:02:38 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-43d03db7f87so3712760f8f.3
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2026 06:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776862956; x=1777467756; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p/Vl2py7bAr3MMXnnVGwEiFMxjfl+Vi5CKcG3JxQvlI=;
 b=Dc2RpUDRuykvLisdKiHDSrgcXAmYOuI77OCIN6OjX8CZnH9TZR2aKLb8qsZ6srzQdO
 a5SfCe2tRGndmaG+J75FN1fza/SNGxkhmUWn6hUHfIQ/qSJ0NYRw88tCKcv8PT2LN+rM
 7V5hYYlTST/tT8F4JZ0aC0tyWD5nqVQyBjC8cuGmWj+h8Al2feD1RoFkSJQeON5QDfIr
 uHr1USzut3RiN6eSNjIsvAtUH485ETu8Nu/ZJVNzR1CAv21MiOK3v8eCZSnRe6xubmfC
 /vwRkU2k0tShwVy0CkiH/G2jvgwQ2xpLzZ0LZicMvyYfEIvqvBoB/3eXiVe57JTYVwQL
 pI3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776862956; x=1777467756;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=p/Vl2py7bAr3MMXnnVGwEiFMxjfl+Vi5CKcG3JxQvlI=;
 b=kvlHlQWdTIkfvHUOcSNltCSM3NvNQZy4CKpZNjaR5ogYJpskQjgHrEs6kBJbkR141I
 0rc8DssDaCySWFW2NJ8NGpY5UvfPn8Mzk2bHZzyvmt6E/23sHMZFl+d23GpAHVcW7bw3
 j5J6XvqM1mgVpowgMRIcSoTcQDQdgnfiJOYUMdroIKbLEPbpvh8vg8Z8Bw6H6Gu/gnAj
 Gyd6WKYGhCt0pmdlpmIgrAHau2wrss8J4k3NypYTBL5mNd9pShnj+KDly8R6nQRkl5zk
 IxZLKHcNRvMizkhv7fNEBv6ZNRvRC0+JacRrCBbXbqqBSISZfSmKNjdz1EVIfqBXOSWH
 +9sA==
X-Gm-Message-State: AOJu0YyzHI5gr6bjMEa8sU3Am1OQB3vCBc/BeX/vsvnv6LNG1IRS2haF
 HX8G63L69+174HpM2za1MYn9sduugW4ZhMGtv8FgqGFvJylEYFcl/8c/JSfCF4q9F8fowfqKFKq
 9yxGFwkU=
X-Gm-Gg: AeBDieuxpY1GtRs9WvTZQMshMPhXa+Vg0FGYiGGUOoh6wriwhgARNIdZ1AUi4wboU+j
 yrNrtGDiO2jWv8OKueWzEZChDGloVMWh6uXwZ7rbJ9bXBoxvbUvGVUAVWL3MRTnl3wfcP6vCpOn
 v/TsscQcCTugDSAknrGfQW/goDkcqbdvywPDro6IesJ5xipUzghJAhUbW6DxdBUqyfkbunaD+qV
 CpOL/g+hGizmjccB/4AZN37/I7/rDo/r00ib9w9JyHvLzf0wNu30JzBVz19b/i8XQIYiqk+TzyO
 V/DvMeEOCjUT2Q4jeEznR+IR5AhmYV4m5kpHcr0xQbduM3uvh680f3EQ38EK78DVB0FX8zlr7k/
 UBgBWM/+doJY9Dgpj9MI9alNRbgCAjw8UrrGtNjY0mJAV6OMu8SzrPPmvb6+6aKsPs/nVdwSzDn
 Yv5Xp98/WEGTLdDCxEvbOxJUSmu7jQDfOrusUnVJBgQCrg
X-Received: by 2002:a05:6000:1a8d:b0:43b:40ef:5d1a with SMTP id
 ffacd0b85a97d-43fe3db3c24mr34177692f8f.5.1776862955514; 
 Wed, 22 Apr 2026 06:02:35 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e3a174sm50153175f8f.18.2026.04.22.06.02.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2026 06:02:30 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 4906061668;
 Wed, 22 Apr 2026 13:52:53 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pedro Barbuda <pbarbuda@microsoft.com>, Alexander Graf <agraf@csgraf.de>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>, kvm@vger.kernel.org,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v3 28/32] target/arm: hoist event broadcast code into a helper
Date: Wed, 22 Apr 2026 13:52:45 +0100
Message-ID: <20260422125250.1303100-29-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260422125250.1303100-1-alex.bennee@linaro.org>
References: <20260422125250.1303100-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42e.google.com
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

We will shortly call it from more places.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/arm/internals.h     | 19 +++++++++++++++++++
 target/arm/tcg/op_helper.c |  9 +--------
 2 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index dc593f1fec8..089f679ac0a 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -682,6 +682,25 @@ bool arm_is_psci_call(ARMCPU *cpu, int excp_type);
 /* Actually handle a PSCI call */
 void arm_handle_psci_call(ARMCPU *cpu);
 
+/**
+ * arm_broadcast_event: set the event_register for all PEs
+ *
+ * This kicks all PEs which will up which are waiting on the event
+ * register.
+ */
+static inline void arm_broadcast_event(void)
+{
+    CPUState *cs;
+
+    CPU_FOREACH(cs) {
+        ARMCPU *target_cpu = ARM_CPU(cs);
+        target_cpu->env.event_register = true;
+        if (!qemu_cpu_is_self(cs)) {
+            qemu_cpu_kick(cs);
+        }
+    }
+}
+
 /**
  * arm_clear_exclusive: clear the exclusive monitor
  * @env: CPU env
diff --git a/target/arm/tcg/op_helper.c b/target/arm/tcg/op_helper.c
index 655e3f96e78..6a2be85fcaa 100644
--- a/target/arm/tcg/op_helper.c
+++ b/target/arm/tcg/op_helper.c
@@ -474,14 +474,7 @@ void HELPER(wfit)(CPUARMState *env, uint32_t rd)
 
 void HELPER(sev)(CPUARMState *env)
 {
-    CPUState *cs = env_cpu(env);
-    CPU_FOREACH(cs) {
-        ARMCPU *target_cpu = ARM_CPU(cs);
-        target_cpu->env.event_register = true;
-        if (!qemu_cpu_is_self(cs)) {
-            qemu_cpu_kick(cs);
-        }
-    }
+    arm_broadcast_event();
 }
 
 void HELPER(wfe)(CPUARMState *env)
-- 
2.47.3


