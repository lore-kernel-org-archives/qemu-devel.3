Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E270AC28B2F
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Mar 2025 17:58:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trKsc-0003Pn-Hu; Sun, 09 Mar 2025 13:56:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trKrn-000239-Kt
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 13:55:12 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trKrl-0005Jl-4p
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 13:55:11 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-39104c1cbbdso1652394f8f.3
 for <qemu-devel@nongnu.org>; Sun, 09 Mar 2025 10:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741542906; x=1742147706; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=rttxhj1jFn9qxHkwlr9mdzip+R1zeRwNdhCQFUSmpJ8=;
 b=iNqBexw4CgiodzVQp1cFWfG3uN438Z14OMnhOdFpWV8ZcKAlxLdWxNVFRSSijQqNMl
 3y3iPHFT50z+wzTI8PohYmtwwALC0xb370sb6H4kn9H8Qn9Jq83u3hjTtSWvAP34hZ+4
 cqYc4LQOsAAVhvWhb90WTjPbsnWhqdxCTyQgV3Q1UxdnajaasiPwSset6whPjO77HquL
 +SoQI71pM/Q2CJarqzAa05UpR+QsujM0y+MB9YE4wKnoprVWH/Os4b3qEU3MEIwzkFWb
 cc6vRh/IBokPTJwatVe8Smi44FBf1h/lZNZnOr1L352ijM/6Bl8vlc0ZN3RWYGPG3DgA
 1FxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741542906; x=1742147706;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rttxhj1jFn9qxHkwlr9mdzip+R1zeRwNdhCQFUSmpJ8=;
 b=SGzkPC4JyxtSNukHqX5bJwmBoVZ/H7DqPatOzL5nh2taYKVscOBUFU9o6UK8sz3Vrs
 WPNNa90kIiFF7iBnV2ECdnGG0po5Eab39XcKGtqsc8oe8N4QQytGJas82DPjWMiUUk8p
 b3eYebdserijqnI7YvZt7fURcW3uZ8qAfr9y/j7uEl/K/5F+VhkKqUdeJyR85QLlllko
 OlANW5cw8OZG85LuzihwURDUvRFw9H7WYFrzS58nmfhxCEJ0D57Ux0pHT4Gt4VB0e5W1
 BybxHGIadwvAyq8e+FFzKucJbkxYMOd11F49k8ohRVXW2MWIsMAAw7of4rXpdasChaVS
 L8+g==
X-Gm-Message-State: AOJu0YyOfmf2qgZgapC/Sn8pqlw2MpDox6zA+WDFpjTXYBNjsfuULF3E
 EAcTRRp0ZayAueKOzl41x9cU9pWgUumooRelygMADldD3MJxvniG45a/TGR46J6iG+aZI9vEqEn
 C2ww=
X-Gm-Gg: ASbGncusOpw3VycjB4DMclajnqibHeMgXnmet+5zF99huwn4wmPSnv/vBCww4V8KkH0
 fYL/K/sllnTBG50dlaXcPUFrTY1Qz4lrwGtT4u81afbOWJU1YWNN8YMEbCIkmM00mCoejrYzGOy
 G5A199YUPIoPc9S8uLkhP/eqalUm6MR8dWRFAwauuvFViGmF5lylBPk9UH9z77Vzc253peDegdK
 9jQeULR89w1oqsXUPi3ImewP8fzkCJwMmPWmcNC19DdJhRiUfMWnIBgVw4OJWTVMTL71S24DkVM
 NFy9jtpjwJP8qApILW/6dszAqsJlRa7hINkk9lo32AVY5ySryhBY4yxVxQ8hhYW/nEv7f3JzZfF
 lSFifnYvSxS6iAiTcIdk=
X-Google-Smtp-Source: AGHT+IG+g6QZsGSX1LgRHbQr5tSqnSBtfTdKbaJYundzHrqbx33m5rxPIoqCEbNFe8PEKeUACzw35w==
X-Received: by 2002:a05:6000:2ac:b0:390:f400:2083 with SMTP id
 ffacd0b85a97d-39132b5bb58mr7362150f8f.0.1741542906187; 
 Sun, 09 Mar 2025 10:55:06 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912c102b62sm12228799f8f.84.2025.03.09.10.55.05
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 09 Mar 2025 10:55:05 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 37/38] cpus: Remove CPUClass::has_work() handler
Date: Sun,  9 Mar 2025 18:52:06 +0100
Message-ID: <20250309175207.43828-38-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250309175207.43828-1-philmd@linaro.org>
References: <20250309175207.43828-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

All handlers have been converted to SysemuCPUOps::has_work().
Remove CPUClass::has_work along with cpu_common_has_work() and
simplify cpu_has_work(), making SysemuCPUOps::has_work handler
mandatory.

Note, since cpu-common.c is in meson's common_ss[] source set, we
must define cpu_exec_class_post_init() in cpu-target.c (which is
in the specific_ss[] source set) to have CONFIG_USER_ONLY defined.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20250125170125.32855-25-philmd@linaro.org>
---
 include/hw/core/cpu.h            |  3 +--
 include/hw/core/sysemu-cpu-ops.h |  2 +-
 hw/core/cpu-common.c             |  8 ++------
 hw/core/cpu-system.c             | 13 +++++++------
 hw/core/cpu-user.c               |  5 +++++
 5 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index a54dd2cf699..5d11d26556a 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -104,7 +104,6 @@ struct SysemuCPUOps;
  *                 instantiatable CPU type.
  * @parse_features: Callback to parse command line arguments.
  * @reset_dump_flags: #CPUDumpFlags to use for reset logging.
- * @has_work: Callback for checking if there is work to do.
  * @mmu_index: Callback for choosing softmmu mmu index;
  *       may be used internally by memory_rw_debug without TCG.
  * @memory_rw_debug: Callback for GDB memory access.
@@ -153,7 +152,6 @@ struct CPUClass {
     ObjectClass *(*class_by_name)(const char *cpu_model);
     void (*parse_features)(const char *typename, char *str, Error **errp);
 
-    bool (*has_work)(CPUState *cpu);
     int (*mmu_index)(CPUState *cpu, bool ifetch);
     int (*memory_rw_debug)(CPUState *cpu, vaddr addr,
                            uint8_t *buf, int len, bool is_write);
@@ -1156,6 +1154,7 @@ G_NORETURN void cpu_abort(CPUState *cpu, const char *fmt, ...)
 
 /* $(top_srcdir)/cpu.c */
 void cpu_class_init_props(DeviceClass *dc);
+void cpu_exec_class_post_init(CPUClass *cc);
 void cpu_exec_initfn(CPUState *cpu);
 void cpu_vmstate_register(CPUState *cpu);
 void cpu_vmstate_unregister(CPUState *cpu);
diff --git a/include/hw/core/sysemu-cpu-ops.h b/include/hw/core/sysemu-cpu-ops.h
index dee8a62ca98..877892373f9 100644
--- a/include/hw/core/sysemu-cpu-ops.h
+++ b/include/hw/core/sysemu-cpu-ops.h
@@ -19,7 +19,7 @@ typedef struct SysemuCPUOps {
     /**
      * @has_work: Callback for checking if there is work to do.
      */
-    bool (*has_work)(CPUState *cpu);
+    bool (*has_work)(CPUState *cpu); /* MANDATORY NON-NULL */
     /**
      * @get_memory_mapping: Callback for obtaining the memory mappings.
      */
diff --git a/hw/core/cpu-common.c b/hw/core/cpu-common.c
index ba0f02e49da..9064dd24f82 100644
--- a/hw/core/cpu-common.c
+++ b/hw/core/cpu-common.c
@@ -134,11 +134,6 @@ static void cpu_common_reset_hold(Object *obj, ResetType type)
     cpu_exec_reset_hold(cpu);
 }
 
-static bool cpu_common_has_work(CPUState *cs)
-{
-    return false;
-}
-
 ObjectClass *cpu_class_by_name(const char *typename, const char *cpu_model)
 {
     ObjectClass *oc;
@@ -259,6 +254,8 @@ static void cpu_common_initfn(Object *obj)
 {
     CPUState *cpu = CPU(obj);
 
+    cpu_exec_class_post_init(CPU_GET_CLASS(obj));
+
     /* cache the cpu class for the hotpath */
     cpu->cc = CPU_GET_CLASS(cpu);
 
@@ -331,7 +328,6 @@ static void cpu_common_class_init(ObjectClass *klass, void *data)
 
     k->parse_features = cpu_common_parse_features;
     k->get_arch_id = cpu_common_get_arch_id;
-    k->has_work = cpu_common_has_work;
     k->gdb_read_register = cpu_common_gdb_read_register;
     k->gdb_write_register = cpu_common_gdb_write_register;
     set_bit(DEVICE_CATEGORY_CPU, dc->categories);
diff --git a/hw/core/cpu-system.c b/hw/core/cpu-system.c
index 601335fd764..aed5076ec78 100644
--- a/hw/core/cpu-system.c
+++ b/hw/core/cpu-system.c
@@ -33,12 +33,7 @@
 
 bool cpu_has_work(CPUState *cpu)
 {
-    if (cpu->cc->sysemu_ops->has_work) {
-        return cpu->cc->sysemu_ops->has_work(cpu);
-    }
-
-    g_assert(cpu->cc->has_work);
-    return cpu->cc->has_work(cpu);
+    return cpu->cc->sysemu_ops->has_work(cpu);
 }
 
 bool cpu_paging_enabled(const CPUState *cpu)
@@ -188,6 +183,12 @@ void cpu_class_init_props(DeviceClass *dc)
     device_class_set_props(dc, cpu_system_props);
 }
 
+void cpu_exec_class_post_init(CPUClass *cc)
+{
+    /* Check mandatory SysemuCPUOps handlers */
+    g_assert(cc->sysemu_ops->has_work);
+}
+
 void cpu_exec_initfn(CPUState *cpu)
 {
     cpu->memory = get_system_memory();
diff --git a/hw/core/cpu-user.c b/hw/core/cpu-user.c
index 1892acdee0f..7176791851b 100644
--- a/hw/core/cpu-user.c
+++ b/hw/core/cpu-user.c
@@ -27,6 +27,11 @@ void cpu_class_init_props(DeviceClass *dc)
     device_class_set_props(dc, cpu_user_props);
 }
 
+void cpu_exec_class_post_init(CPUClass *cc)
+{
+    /* nothing to do */
+}
+
 void cpu_exec_initfn(CPUState *cpu)
 {
     /* nothing to do */
-- 
2.47.1


