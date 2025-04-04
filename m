Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76507C36010
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 23:57:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0qu4-00015r-4y; Fri, 04 Apr 2025 19:56:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0qtt-000134-9P
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 19:56:41 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0qtr-000053-59
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 19:56:40 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-43cfa7e7f54so16114485e9.1
 for <qemu-devel@nongnu.org>; Fri, 04 Apr 2025 16:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743810997; x=1744415797; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k0WtysXePaC6MggJt0xgGe2wh6ZQlPxmWahlUJgeA/0=;
 b=zuCvqywiT6A1BD/TJJF6zO+Rsns9Y3NQX7WRwuyrSGHmzzXg7lIaDmcgucKskETS94
 OpClxPgU6VKYH4eWcw+q1CCLVA9DwJb6hYMCLDCGlIcWl6m3Nsno5Mmd3PaoHfvhk+TQ
 1IKk4RJEEPzmKhJsLxx/lq9zYKZ0k8GFubJNnHjtdxveRhcXY7lirkjAvwjvluVv8i3z
 6ZvErNzNdEymJ0lQ4W7HcVbaNKgUgcZxTSdHdQLI50qKh6Gkx85A65oQmESAps5gOW9G
 dP+BjfCI7D46RiUdGNA1hcw1U/DzzfVaCBao2FyYnkijJzoS2QWhVQmoyUowq8qJ+45o
 3Syg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743810997; x=1744415797;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k0WtysXePaC6MggJt0xgGe2wh6ZQlPxmWahlUJgeA/0=;
 b=IypKPQ+mUOcE6yjW+bZqnCP240iRO0tttmvsVZrP5iW8DYHbhwhyErI7YJDVP8Qxfj
 7bYS9jVqv8mWu4MkqHlnfDZuTgwgsGjAWMEV6z1WTRh4+Yk0VUnS7XAZKi1iQHUsxG5v
 98jSCtEwFmA6SZGdkQcWpvnrg5f6Y5b02NhU1xwr8PWcy2TQ5oB46LniKjAIyGb400cE
 K/wMEOLfuW0PKhmdormZG9J28CkHWArgmHeRnsRTz1hFW4hdjOSSkGZi5RXy11iSnA2x
 lWRQOM1sij6ILWD67jUMBQQMpSoOiI8u/mwBHguKVdoVvL2XtTb76Jik0JodQxRGloko
 qYBg==
X-Gm-Message-State: AOJu0Yz0C8X+x0zZ7PgNWvdWknMgShKt0IgW5bnQV9EM10ezlu+eISLl
 tAXQwjZqT0/NGuBBnWHDbPHjmDJ4LRBcpIokGWm2E0akoesl9oWuT2zOmOLsYZnOJ4aZI29h2nC
 G
X-Gm-Gg: ASbGnctQwgPew19qOmMHa3j158tLYYm/2RKAb7pACbnE42k469eZVuwmcceXqBMr/Gf
 c2JXtyYVN5NuAjcbIhMUQ8QuRUdJ5v3Vu5K+a3uNlO34b7b8Z2lINDz0lnAu24ciZT8MDAz3JDW
 bNJwmH0Y8gZCORpHyG3ROL46Argxd/EuzwbCbrTqgyUgKpck6rnOHQsMun+aqj/DFrEO+Bo+tQ3
 0VXkZKNQ7EP5Fn+3TjW2QwJnBl2Pjee5o+dSACVtzzLO6/3xaiS3cIB0wE1OYhvHN0FGY+4Y+2X
 9CZY0tOWjD+/hrTJ34JcX2xiR//qB0c3Xe+ifUgmx0kJ27PW9Z948wQ4EWRrjqSix2O28yanABn
 kPSYkqslX48t+rYxxOUKIc4xm
X-Google-Smtp-Source: AGHT+IEQGpuTMEFKSsAIp1EsmUrYxD+gxpKGfrEbyXwuMH6QSnLQ7Ghu6hStdtzGKVYOjv35fluXjg==
X-Received: by 2002:a05:600c:1827:b0:43d:174:2668 with SMTP id
 5b1f17b1804b1-43ebeda3c57mr60554575e9.0.1743810996925; 
 Fri, 04 Apr 2025 16:56:36 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec1630ddesm61448235e9.5.2025.04.04.16.56.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 04 Apr 2025 16:56:36 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>, qemu-s390x@nongnu.org,
 Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>, Paolo Bonzini <pbonzini@redhat.com>,
 Riku Voipio <riku.voipio@iki.fi>, Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.1 2/2] tcg: Convert TARGET_HAS_PRECISE_SMC to
 TCGCPUOps::has_precise_smc field
Date: Sat,  5 Apr 2025 01:56:24 +0200
Message-ID: <20250404235624.67816-3-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250404235624.67816-1-philmd@linaro.org>
References: <20250404235624.67816-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

Instead of having a compile-time TARGET_HAS_PRECISE_SMC definition,
have targets set the 'has_precise_smc' field in the TCGCPUOps
structure.

Since so far we only emulate one target architecture at a time,
add a static 'tcg_target_has_precise_smc' variable, initialized
just after calling TCGCPUOps::initialize() in tcg_exec_realizefn().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/accel/tcg/cpu-ops.h |  8 ++++++++
 include/exec/poison.h       |  1 -
 target/i386/cpu.h           |  4 ----
 target/s390x/cpu.h          |  2 --
 accel/tcg/cpu-exec.c        | 13 ++++++-------
 target/i386/tcg/tcg-cpu.c   |  1 +
 target/s390x/cpu.c          |  1 +
 7 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/include/accel/tcg/cpu-ops.h b/include/accel/tcg/cpu-ops.h
index 0e4352513d1..a76cfe49df8 100644
--- a/include/accel/tcg/cpu-ops.h
+++ b/include/accel/tcg/cpu-ops.h
@@ -28,6 +28,14 @@ struct TCGCPUOps {
      */
     bool mttcg_supported;
 
+    /**
+     * has_precise_smc: guest CPU has precise-SMC semantics
+     *
+     * Guest support for precise self modifying code even if the
+     * modified instruction is close to the modifying instruction.
+     */
+    bool has_precise_smc;
+
     /**
      * @guest_default_memory_order: default barrier that is required
      *                              for the guest memory ordering.
diff --git a/include/exec/poison.h b/include/exec/poison.h
index 413dfd16f24..011aa2378d7 100644
--- a/include/exec/poison.h
+++ b/include/exec/poison.h
@@ -36,7 +36,6 @@
 #pragma GCC poison TARGET_HAS_BFLT
 #pragma GCC poison TARGET_NAME
 #pragma GCC poison TARGET_BIG_ENDIAN
-#pragma GCC poison TARGET_HAS_PRECISE_SMC
 
 #pragma GCC poison TARGET_LONG_BITS
 #pragma GCC poison TARGET_FMT_lx
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 16d76df34b2..5a2e4a8103f 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -35,10 +35,6 @@
 
 #define XEN_NR_VIRQS 24
 
-/* support for self modifying code even if the modified instruction is
-   close to the modifying instruction */
-#define TARGET_HAS_PRECISE_SMC
-
 #ifdef TARGET_X86_64
 #define I386_ELF_MACHINE  EM_X86_64
 #define ELF_MACHINE_UNAME "x86_64"
diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index 90f64ee20cc..ee59039879b 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -35,8 +35,6 @@
 
 #define ELF_MACHINE_UNAME "S390X"
 
-#define TARGET_HAS_PRECISE_SMC
-
 #define MMU_USER_IDX 0
 
 #define S390_MAX_CPUS 248
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index cfe3b93e1e3..d410a4780b3 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -1065,19 +1065,17 @@ int cpu_exec(CPUState *cpu)
     return ret;
 }
 
+static bool tcg_target_initialized;
+static bool tcg_target_has_precise_smc;
+
 bool target_has_precise_smc(void)
 {
-#ifdef TARGET_HAS_PRECISE_SMC
-    return true;
-#else
-    return false;
-#endif
+    assert(tcg_target_initialized);
+    return tcg_target_has_precise_smc;
 }
 
 bool tcg_exec_realizefn(CPUState *cpu, Error **errp)
 {
-    static bool tcg_target_initialized;
-
     if (!tcg_target_initialized) {
         /* Check mandatory TCGCPUOps handlers */
         const TCGCPUOps *tcg_ops = cpu->cc->tcg_ops;
@@ -1088,6 +1086,7 @@ bool tcg_exec_realizefn(CPUState *cpu, Error **errp)
         assert(tcg_ops->translate_code);
         assert(tcg_ops->mmu_index);
         tcg_ops->initialize();
+        tcg_target_has_precise_smc = tcg_ops->has_precise_smc;
         tcg_target_initialized = true;
     }
 
diff --git a/target/i386/tcg/tcg-cpu.c b/target/i386/tcg/tcg-cpu.c
index a0258f4739e..2254fc2d739 100644
--- a/target/i386/tcg/tcg-cpu.c
+++ b/target/i386/tcg/tcg-cpu.c
@@ -130,6 +130,7 @@ static const TCGCPUOps x86_tcg_ops = {
      * The x86 has a strong memory model with some store-after-load re-ordering
      */
     .guest_default_memory_order = TCG_MO_ALL & ~TCG_MO_ST_LD,
+    .has_precise_smc = true,
     .initialize = tcg_x86_init,
     .translate_code = x86_translate_code,
     .synchronize_from_tb = x86_cpu_synchronize_from_tb,
diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index 41cccc1e692..845b2515aeb 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -351,6 +351,7 @@ static const TCGCPUOps s390_tcg_ops = {
      * store-after-load re-ordering.
      */
     .guest_default_memory_order = TCG_MO_ALL & ~TCG_MO_ST_LD,
+    .has_precise_smc = true,
 
     .initialize = s390x_translate_init,
     .translate_code = s390x_translate_code,
-- 
2.47.1


