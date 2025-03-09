Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D91AEC28B30
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Mar 2025 17:55:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trKqE-0006hM-DT; Sun, 09 Mar 2025 13:53:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trKq7-0006UR-B6
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 13:53:27 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trKq5-0004v7-Ks
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 13:53:27 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43cf257158fso2695485e9.2
 for <qemu-devel@nongnu.org>; Sun, 09 Mar 2025 10:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741542804; x=1742147604; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=VYqLhM0eCuZK6VK66V4exZsfZkF9DDNQ854u48Rikns=;
 b=htnfk65vP2H3E82gPYtJl12zyGPTAvgB9Iec41h+wR0E3DP+PvmoAM7URWlX7UgZ7g
 UOV+VocbpxuFS7Dt0irUg3UX4I1JeB0YSXns/C6HaUwj5p14BNOGYqbUT87+Z7rr6/BJ
 IUtzHS7nsaDPE9DM7ViAUXdQ5HOlpP3FV3+tREkjmODH8N4G9F6WymTKpRpF7G7pCKWQ
 SIKSI8guMmsUW99G5XY9pZCOJyejfHsm9n5BlUxJK4OzHAzFfuVscI8R0W0I5bj7v2mb
 QyJ7VA+w7ctgOOzomdczrb9QWgJgXv7/AP6lFqHcoIwCbBGbVoHBGgHcJ6EJixFdvBm0
 ztUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741542804; x=1742147604;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VYqLhM0eCuZK6VK66V4exZsfZkF9DDNQ854u48Rikns=;
 b=XpKUNHS6AKPsK+1NKDCTL8ZY5W5XkcD53DQSov6iZaXaX6JgcMDSm+jo3f9aotW7WJ
 7pj2IrfULBnviH2U3XeBY9ChTrygFkJnkgY9AY9N4VXyoNFcAAPtpjqAZtM9YUdHNauy
 pYM60ElLKa4Pct3sVbRDfnwGvdL4nNAMMEZQgR9YS1T7/JgSo6x4522uZNMjqqojNmLH
 1IpJ60UikoALKvusm2KJgCJAuj6vwL2eQ7AI2Eb4X+X8C0PbwT6290w7AFlkqx03+Et3
 sbItfS9Hut4TrHdEkQSwAYuy3grckj9OK4gYryCr9x6phZwxHgzNoe6rahKG0Xo/nGji
 yDzQ==
X-Gm-Message-State: AOJu0YwuIhJU17qgM6/Zce923/vNZgVfnekn8EU/y7Bbx576ft2OkirH
 kx9Yz+MSQW/Y0teY9HwjnlbRnZVIusUjeB5+jo2dpwV3sy4rE365GjcWvamXnAfyfzg+6gORHim
 CEoE=
X-Gm-Gg: ASbGncvIEk04COodk/NQ2TN/NYwPhHWnrWYcm1z1JOdou0u1fzxdOzygPf/RjvcnFPj
 8iZqKvEnzosgMEyg8/I8dS6RGUSzS9IQNYYRoTbu7TDwLCW+1xdFC66lRhWqk6tzx9dhfJbB4f0
 9BJ2Vo21HGRXJr7xfT7jAknKOeRZ1QAVXsp/6dMfIPVB8oCQ4/Ewvj6V1MHuK4UINvfHbqhoj1a
 avCX6VM2LpJ9gCRk2p2pE1jLaVy+4zjdJpHdG1qcFaCMGqF1pkiTV7zGSqtB9RJL51S6MYS8bGg
 nD7vUvLqS/4fmvIxevYmcCYIBLoaHOGaJJzWjEi7hRssLb7Pfv9ptdwOQ8/BHYsWseZQtV2ZVMx
 59FHT9lOKVdGr5umFFRiALDHqBiyJ/A==
X-Google-Smtp-Source: AGHT+IERzlV2NbuLCX9CaV34k1NURL9HMRXD83XkqgGLh/cMqB1mp3cPtg0LvxSLtDLmFzT6vxdNXA==
X-Received: by 2002:a05:600c:1987:b0:439:a6db:1824 with SMTP id
 5b1f17b1804b1-43c601e13d4mr75978475e9.16.1741542803658; 
 Sun, 09 Mar 2025 10:53:23 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bdd8b0425sm121283065e9.3.2025.03.09.10.53.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 09 Mar 2025 10:53:23 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 16/38] cpus: Introduce SysemuCPUOps::has_work() handler
Date: Sun,  9 Mar 2025 18:51:45 +0100
Message-ID: <20250309175207.43828-17-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250309175207.43828-1-philmd@linaro.org>
References: <20250309175207.43828-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

SysemuCPUOps::has_work() is similar to CPUClass::has_work(),
but only exposed on system emulation.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20250125170125.32855-4-philmd@linaro.org>
---
 include/accel/tcg/cpu-ops.h      | 2 +-
 include/hw/core/sysemu-cpu-ops.h | 4 ++++
 hw/core/cpu-system.c             | 4 ++++
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/include/accel/tcg/cpu-ops.h b/include/accel/tcg/cpu-ops.h
index 2e3f1690f12..f60e5303f21 100644
--- a/include/accel/tcg/cpu-ops.h
+++ b/include/accel/tcg/cpu-ops.h
@@ -141,7 +141,7 @@ struct TCGCPUOps {
      *
      * This method must be provided. If the target does not need to
      * do anything special for halt, the same function used for its
-     * CPUClass::has_work method can be used here, as they have the
+     * SysemuCPUOps::has_work method can be used here, as they have the
      * same function signature.
      */
     bool (*cpu_exec_halt)(CPUState *cpu);
diff --git a/include/hw/core/sysemu-cpu-ops.h b/include/hw/core/sysemu-cpu-ops.h
index 0df5b058f50..dee8a62ca98 100644
--- a/include/hw/core/sysemu-cpu-ops.h
+++ b/include/hw/core/sysemu-cpu-ops.h
@@ -16,6 +16,10 @@
  * struct SysemuCPUOps: System operations specific to a CPU class
  */
 typedef struct SysemuCPUOps {
+    /**
+     * @has_work: Callback for checking if there is work to do.
+     */
+    bool (*has_work)(CPUState *cpu);
     /**
      * @get_memory_mapping: Callback for obtaining the memory mappings.
      */
diff --git a/hw/core/cpu-system.c b/hw/core/cpu-system.c
index c10e3c9ba64..601335fd764 100644
--- a/hw/core/cpu-system.c
+++ b/hw/core/cpu-system.c
@@ -33,6 +33,10 @@
 
 bool cpu_has_work(CPUState *cpu)
 {
+    if (cpu->cc->sysemu_ops->has_work) {
+        return cpu->cc->sysemu_ops->has_work(cpu);
+    }
+
     g_assert(cpu->cc->has_work);
     return cpu->cc->has_work(cpu);
 }
-- 
2.47.1


