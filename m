Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDBBDC2D0CD
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 10:35:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFVp0-0000Nf-HA; Thu, 15 May 2025 06:28:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uFVnh-0005Va-5Q
 for qemu-devel@nongnu.org; Thu, 15 May 2025 06:26:53 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uFVne-0008Gl-Ao
 for qemu-devel@nongnu.org; Thu, 15 May 2025 06:26:52 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-440685d6afcso8448285e9.0
 for <qemu-devel@nongnu.org>; Thu, 15 May 2025 03:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747304805; x=1747909605; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=JgvcooGso6hgHoCAG9dIwH2FprpPy71bhrSzgHgqriY=;
 b=zLMEjU8G1LwbGK5+eE7v2w1Hq9NZGNxG4XfB3zHdZw2/pgcQwkNYD6roWylVn+/5bE
 Ahi9hI+E90LVIihm8Z3zbxX3SA6hN6TmMKhf/vQM/Ous9ndNH9RLc9oln/b4N0rYpUe/
 A4GJjkGWq71nfsuO/cl3kv850N0TOm0y6tr7P4/6rhBMI1kKeP2984I2e8lmgcTfx2Rt
 4YWMhPu/Al66QJi4jwovE0g72cXHBhD8LoopYj9/VQk/bweBZX4ycwH99fMmdPrCpom0
 3112TZwOPBu22saArPzutPSAtUwkaoDtngB/ulSfpNZRLPTg5GG3LkuVPQvPCHI18FI8
 Xd8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747304805; x=1747909605;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JgvcooGso6hgHoCAG9dIwH2FprpPy71bhrSzgHgqriY=;
 b=PA12P6BQoV/NcKSTpIJix7mDjTE6UJ1CkQty99DOBrb98j9poVIjkJOSUDIye2CRpe
 wvyapMIRngi03kR5lejOQhxGJgmZI6mbJbVXJG/lsM9MlYgEBH5tewA9zytAMz2m2VP/
 lvgmVu02N1AuORqYfpcYQtv4dJUZgcnP0Cl7n8HWNBi8J25piBBc6p7N1cotrtdsjLMU
 x4rctBRMaXiO0OUuxinOkduklrNtbr0Go6WBYZGAaz93lOKqPs7XGl8i+oV2bOwR44LX
 h/WVlj8kwVPgh7FlhrSJDNh0UaO3sndlMqXDei+M6uOcnGBY2y1aLj8UujkuX70WcmKp
 0q5A==
X-Gm-Message-State: AOJu0YyS7Bay1PfJEWXVQF9TUm8V7hrqHdDhLdktJ3GEkpm60J3gpl9M
 p4J0dK9k6lG3EReEMJToWeMxZc/Spvc5dHvO/KeglyhLQ4UX1l5hxgyTQgb6U/huj+fpt4cC0sn
 ghWU=
X-Gm-Gg: ASbGncud7tKBvKQzg/j2th5KbuF0m2T2ZJ8tVE1pNJ/fvL6Fp7k7lNnXyZxb39ozyUH
 ll4V85U23cM0J6JO3a7Y8klyWuh+npqwLfGI6k2bj6QJyWWCP2uTPq0rLPlfmOLNzygWMwvA05i
 JR4saUo3dKGcCuRgtffvqZym2HZcmI2jDpfKhBTurPZwiK9m6kPELrIgrxPxkFfdD5cLkKMZpk0
 6aAD1PmewNOFU5JKAIXcbJYmZe9kHfbJodcz1PIRYiXNXl4fvrb9QaO752nEEsIevrbpZHhpmvu
 LQ3Ukn2W7rGg0sinGcjdu0W5KKzOSt9pHqXDvc28NGyNLtv5V1TcDNrP8A==
X-Google-Smtp-Source: AGHT+IEM6LoN2FdIFp7KCIrFL2U13yFPWVjDvbPxg3rYyZHwpcZsLsFHsXAZgmQ3UypKKcQqJ7bqxg==
X-Received: by 2002:a05:600c:3e12:b0:442:dcdc:41c8 with SMTP id
 5b1f17b1804b1-442f96ecf1amr16276215e9.19.1747304805302; 
 Thu, 15 May 2025 03:26:45 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442f396c3a4sm65657855e9.26.2025.05.15.03.26.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 May 2025 03:26:44 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 46/58] target/arm/machine: move cpu_post_load kvm bits to
 kvm_arm_cpu_post_load function
Date: Thu, 15 May 2025 11:25:34 +0100
Message-ID: <20250515102546.2149601-47-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250515102546.2149601-1-peter.maydell@linaro.org>
References: <20250515102546.2149601-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20250512180502.2395029-37-pierrick.bouvier@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/kvm_arm.h |  4 +++-
 target/arm/kvm.c     | 13 ++++++++++++-
 target/arm/machine.c |  8 +-------
 3 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
index b638e09a687..c4178d1327c 100644
--- a/target/arm/kvm_arm.h
+++ b/target/arm/kvm_arm.h
@@ -83,8 +83,10 @@ void kvm_arm_cpu_pre_save(ARMCPU *cpu);
  * @cpu: ARMCPU
  *
  * Called from cpu_post_load() to update KVM CPU state from the cpreg list.
+ *
+ * Returns: true on success, or false if write_list_to_kvmstate failed.
  */
-void kvm_arm_cpu_post_load(ARMCPU *cpu);
+bool kvm_arm_cpu_post_load(ARMCPU *cpu);
 
 /**
  * kvm_arm_reset_vcpu:
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 82668d64385..a2791aa866f 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -938,13 +938,24 @@ void kvm_arm_cpu_pre_save(ARMCPU *cpu)
     }
 }
 
-void kvm_arm_cpu_post_load(ARMCPU *cpu)
+bool kvm_arm_cpu_post_load(ARMCPU *cpu)
 {
+    if (!write_list_to_kvmstate(cpu, KVM_PUT_FULL_STATE)) {
+        return false;
+    }
+    /* Note that it's OK for the TCG side not to know about
+     * every register in the list; KVM is authoritative if
+     * we're using it.
+     */
+    write_list_to_cpustate(cpu);
+
     /* KVM virtual time adjustment */
     if (cpu->kvm_adjvtime) {
         cpu->kvm_vtime = *kvm_arm_get_cpreg_ptr(cpu, KVM_REG_ARM_TIMER_CNT);
         cpu->kvm_vtime_dirty = true;
     }
+
+    return true;
 }
 
 void kvm_arm_reset_vcpu(ARMCPU *cpu)
diff --git a/target/arm/machine.c b/target/arm/machine.c
index 868246a98c0..e442d485241 100644
--- a/target/arm/machine.c
+++ b/target/arm/machine.c
@@ -976,15 +976,9 @@ static int cpu_post_load(void *opaque, int version_id)
     }
 
     if (kvm_enabled()) {
-        if (!write_list_to_kvmstate(cpu, KVM_PUT_FULL_STATE)) {
+        if (!kvm_arm_cpu_post_load(cpu)) {
             return -1;
         }
-        /* Note that it's OK for the TCG side not to know about
-         * every register in the list; KVM is authoritative if
-         * we're using it.
-         */
-        write_list_to_cpustate(cpu);
-        kvm_arm_cpu_post_load(cpu);
     } else {
         if (!write_list_to_cpustate(cpu)) {
             return -1;
-- 
2.43.0


