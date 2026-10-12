Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B813DCA9ED1
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 13:49:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGGOf-0004Jx-Vw; Mon, 12 Oct 2026 09:48:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xGGOb-0004Je-Ng
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 09:48:53 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xGGOY-0003St-Uu
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 09:48:52 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4998b5a63e2so19852805e9.1
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2026 06:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791812928; x=1792417728; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=9KMOnTIgzXJ5irf8RQDp+yn0jKO0xSxRv0zm0tDhx9s=;
 b=AWB3lwZR6Ien/OEwWJC4UPXeINlpeF0Br8/KATVge5WU/WfuKuyQCOauq3tJpBEBra
 aQzkByR4tIiPNXRAhvujmZq1otVOkQEWMESb8sthaHydNUqcXLYjyjcEuFp0NoTCoNl3
 DnmHawoiQh/tFBt/Laz+AxZF3+Mekh5QJwd89XdEDF8RLH3LPLm4Xot9TVGKuLn7ZxL0
 PrulSASicFIYdc2QSUaBPOlKLG04iNVU8HUB6pGWHvPoYbH/ZFldZlfqmHtXg3tEZD1f
 YjWvnKPmxdmHa/GohSjXBOOayFecleoZjiDU+e8LNM7ClKLTa0F9xjJoMIkLxm3EI4uY
 bOrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791812928; x=1792417728;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=9KMOnTIgzXJ5irf8RQDp+yn0jKO0xSxRv0zm0tDhx9s=;
 b=qfB1ZaPB3qFzoSRf3hIw6AjXBLvRdVDqycLN86+xY4j49FdFgSwwaTbfLuuAyVopaR
 97l9UzLDRIunKnwuCFlxy2guHUZcDakCPzO4UKFbw4OL23/1JUU4myRA0u25NivywknD
 egH0fXfs9lV3azChamme4DnyCvQApBj7A9E6FPhBmYCt/mvbESiCrRjAVOX6cJFuI3WZ
 sxxtoFDgdfvrwaHzqnlRQ8UhwDbIysmRnp0oq5TqtCguqlSg+D43kQ8vcTTxot6g+oQf
 0qNNrLuWYDcAImU2uyHy+bhxvnDrO2slw1vdEZ+/l63GavClDy9lOVZqKobio0PFTDAE
 bBgw==
X-Gm-Message-State: AFq9FYJjR0eIU4sbq8KNrHu43hvKTXJjAPBdIJBS90/pp8DBragIrF0Y
 h4sIjAxlInRUw3dOYMKbarZ+aDTjKXzfktokuvJLLRDegBGFG2Io/2UVN8G+srTkohs=
X-Gm-Gg: AYBFou0f7e9nMZa/e/Gg7mMv9H4ogH8nkclT6g+8Z0iXSIOW2KHwrdYbyMJeh3YcULC
 qxz7wPJw48Hp0HECoxhL6VLmnAYkWKoH7g5bH/bN1CNYl6ITsuGpfl7a7wv+k30sIW7E7eG2AUs
 +NG17vnx4hfKv5xy8sjyserqB5sz984ZnitatOsuAwK7q9iTions//Pdh6XiPqS8q8OCrOInCSW
 4ZHSXnLJUeVUrEYRH4wZDrreUJIIw2KkdWbEpS4vAY0h6j+0aEOvnkLaOF/g+3DEJvfy/jtRdPt
 odZkugZx0zwJr9hi0sUsxlSFzQhgwU2r3flQnY2YV2Lupa+1+FXYO19MAoxsC4WBPZk7Tt8CbZV
 Fpqj8FQOQ2R64MNgZrd1atu/LoRh5W0OCMH8lLoqOJMK5DS6p6c5BJTCQaj5sg7Cw0hZacAVx/K
 sNxOcLLplM9RoN1D/F57zYT/saxS7yXzAe4VsF4kZPyi9gpNn0MtmE5ZdAwP2sZj6SFPcYaA==
X-Received: by 2002:a05:600c:c165:b0:4a1:706f:b40d with SMTP id
 5b1f17b1804b1-4a18e4988ecmr178045235e9.7.1791812928277; 
 Mon, 12 Oct 2026 06:48:48 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18bea1021sm266193165e9.10.2026.10.12.06.48.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 06:48:47 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 5022E5F8CE;
 Mon, 12 Oct 2026 14:48:46 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org (open list:ARM TCG CPUs)
Subject: [RFC PATCH] target/arm: hold bql when SEV sets the event_register
Date: Mon, 12 Oct 2026 14:48:40 +0100
Message-ID: <20261012134840.1051969-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x334.google.com
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

There is a race in qemu_process_cpu_events and sleeping on halt_cond
where we can miss the setting of the event_register which would cause
arm_cpu_has_work to report we shouldn't sleep. As by definition the
bql has to be held when we go to sleep against halt_cond guard the
kicking of the cpus by the SEV helper with the BQL to ensure things
are properly serialised.

The other places that set event_register are fine as they are either
in the same vCPU context or are already serialised by the BQL.

Also use qemu_cond_wait_bql like the other halt_cond users.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4660
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 system/cpus.c              | 2 +-
 target/arm/tcg/op_helper.c | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/system/cpus.c b/system/cpus.c
index e11a5aab6a6..985732217fb 100644
--- a/system/cpus.c
+++ b/system/cpus.c
@@ -412,7 +412,7 @@ void qemu_process_cpu_events(CPUState *cpu)
             slept = true;
             qemu_plugin_vcpu_idle_cb(cpu);
         }
-        qemu_cond_wait(cpu->halt_cond, &bql);
+        qemu_cond_wait_bql(cpu->halt_cond);
     }
     if (slept) {
         qemu_plugin_vcpu_resume_cb(cpu);
diff --git a/target/arm/tcg/op_helper.c b/target/arm/tcg/op_helper.c
index af56eff9f18..7c1fdab79d7 100644
--- a/target/arm/tcg/op_helper.c
+++ b/target/arm/tcg/op_helper.c
@@ -471,6 +471,9 @@ void HELPER(wfit)(CPUARMState *env, uint32_t rd)
 void HELPER(sev)(CPUARMState *env)
 {
     CPUState *cs = env_cpu(env);
+
+    BQL_LOCK_GUARD();
+
     CPU_FOREACH(cs) {
         ARMCPU *target_cpu = ARM_CPU(cs);
         target_cpu->env.event_register = true;
-- 
2.47.3


