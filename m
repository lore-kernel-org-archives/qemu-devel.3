Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD3ADC0218E
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jan 2025 17:07:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbjaO-0002c7-B7; Sat, 25 Jan 2025 12:04:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tbjZC-0001Oe-AC
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 12:03:32 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tbjZA-0000e1-8E
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 12:03:29 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4361e89b6daso19837935e9.3
 for <qemu-devel@nongnu.org>; Sat, 25 Jan 2025 09:03:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737824606; x=1738429406; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Rdb0ypEDsi4ZAVccAGxZ8eIstaDxtSjHIYFijJWmmFk=;
 b=gZN9ro+aReynZHixvB9jO1ExtoYZBPAhnne97zNXiTCY9OrZ3py1Sb0wsdk8uV3SeV
 lp6EElrAkqpbZRpff6NcAv/7WfjbbaFilnMpWCDJjSeNGVq6xKOG9b4iUc9N+ZowRpfF
 nNjuOtpeyXFX5dBWNbiKu2F4K6oz+CEfTNjwhBtjljJIl0ImHd8As+FK7DoT60OcmJ+b
 2piTUhG4CQXwlcG3KQLUISI4zyY+5f1e5WCl8ey+PbByPDCyZ7oteQPZ+JyNcITmD0K4
 hU1oV7ex4x5RI3deucWWtwncyRsSEYyIMIFXWQQ+7X5JZeUj+sGxZPclgAoyRB1eDlGy
 lTKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737824606; x=1738429406;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Rdb0ypEDsi4ZAVccAGxZ8eIstaDxtSjHIYFijJWmmFk=;
 b=ukogzRxZ4zWlaMutYj+u1uDx4wA8CwTazcqUXYxeRIDyookIpIqCP/BTEGBTH6+In7
 vD8N5O+nTGrz11FLuQz17IQtTXkl+eSOmoduB1E1ZyzHgO4vl1hojGb7dolgJ+WIz3G/
 qXmESwzbwetxczQa3bkipnpjLn0lhCOSLwFZJPTXp4z/ngSK39237DFj9C06jKhH5WVv
 bs9EYGEIj/r8TwcwUtOhLYRbXNGXxXZNGQkaR+Mp8rxNDoZKvCNxyagTk88tQD/DH7dn
 bX/TLBoRuqrBuDeO355cW8zLcisvJG3bBcjGCudYMHn5+e1MKQy+WagMkW9H6/PRiPVh
 tZtQ==
X-Gm-Message-State: AOJu0YxupJIJOEF1kT8rxTW+5ZjlNeM7UfrzZ62KTis9zjboO8CM5Lf3
 YaOiHAteknPJPa5/SMO0aYMPkOQiQQZLYrIgu8W9Bl9Qd27Q5kpCV3NXRXe4opX5S5gYnSYUx/5
 ZuII=
X-Gm-Gg: ASbGncuT+i4+BTFQu6i+Fz+UvU4W5Rw6MSTwtGvuQlhhkmleh2pV4bSerpcxW8KW5TS
 C9bi5o1i6SEuTM75MzOXqhhOTHhtOajfsbv7B4LylmQhaL8mryuei36nURPZVfmQ0irjtOMNqK0
 IeSngfeF//E7t1W2NNkrkyUC8dYCAN7T9+OWCyX+U71zV/dZ8Vq0P1RC4vuxfGmIILusr4qg5hD
 N6gWgiP71d5by2+c/7mQe8l6nhqdJ/eTqxur6iSRFfRkBd33rrgTRwvoOZwUlRC7LaxNz1zOSU6
 8tPwayIEMZdyOCM2w2yHDNdGaNX+IxpUFamIuuaa8h6wo1clRN2PgKU=
X-Google-Smtp-Source: AGHT+IHufRuDMzWIND9qAvZ+/yVS47S6POZn6N0YcOAXn0EO9klK345dLDz9u5aM+yL+2pUVstmmwg==
X-Received: by 2002:a05:600c:34d0:b0:434:fbda:1f44 with SMTP id
 5b1f17b1804b1-4389142e805mr294675485e9.19.1737824606342; 
 Sat, 25 Jan 2025 09:03:26 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd54c0ecsm67553925e9.30.2025.01.25.09.03.25
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 25 Jan 2025 09:03:25 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 24/24] cpus: Remove CPUClass::has_work() handler
Date: Sat, 25 Jan 2025 18:01:25 +0100
Message-ID: <20250125170125.32855-25-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250125170125.32855-1-philmd@linaro.org>
References: <20250125170125.32855-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Remove CPUClass::has_work along with cpu_common_has_work()
and simplify cpu_has_work(), making SysemuCPUOps::has_work
handler mandatory.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/core/cpu.h            |  3 +--
 include/hw/core/sysemu-cpu-ops.h |  2 +-
 cpu-target.c                     |  8 ++++++++
 hw/core/cpu-common.c             | 12 ++++++------
 hw/core/cpu-system.c             |  7 +------
 5 files changed, 17 insertions(+), 15 deletions(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index d64c823e768..42795f12290 100644
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
@@ -151,7 +150,6 @@ struct CPUClass {
     ObjectClass *(*class_by_name)(const char *cpu_model);
     void (*parse_features)(const char *typename, char *str, Error **errp);
 
-    bool (*has_work)(CPUState *cpu);
     int (*mmu_index)(CPUState *cpu, bool ifetch);
     int (*memory_rw_debug)(CPUState *cpu, vaddr addr,
                            uint8_t *buf, int len, bool is_write);
@@ -1154,6 +1152,7 @@ G_NORETURN void cpu_abort(CPUState *cpu, const char *fmt, ...)
 
 /* $(top_srcdir)/cpu.c */
 void cpu_class_init_props(DeviceClass *dc);
+void cpu_exec_class_post_init(CPUClass *cc, void *data);
 void cpu_exec_initfn(CPUState *cpu);
 bool cpu_exec_realizefn(CPUState *cpu, Error **errp);
 void cpu_exec_unrealizefn(CPUState *cpu);
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
diff --git a/cpu-target.c b/cpu-target.c
index 98e9e7cc4a1..778f622b07a 100644
--- a/cpu-target.c
+++ b/cpu-target.c
@@ -230,6 +230,14 @@ void cpu_class_init_props(DeviceClass *dc)
     device_class_set_props(dc, cpu_common_props);
 }
 
+void cpu_exec_class_post_init(CPUClass *cc, void *data)
+{
+#ifndef CONFIG_USER_ONLY
+    /* Check mandatory SysemuCPUOps handlers */
+    g_assert(cc->sysemu_ops->has_work);
+#endif
+}
+
 void cpu_exec_initfn(CPUState *cpu)
 {
     cpu->as = NULL;
diff --git a/hw/core/cpu-common.c b/hw/core/cpu-common.c
index 886aa793c04..eae621f942f 100644
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
@@ -304,7 +299,6 @@ static void cpu_common_class_init(ObjectClass *klass, void *data)
 
     k->parse_features = cpu_common_parse_features;
     k->get_arch_id = cpu_common_get_arch_id;
-    k->has_work = cpu_common_has_work;
     k->gdb_read_register = cpu_common_gdb_read_register;
     k->gdb_write_register = cpu_common_gdb_write_register;
     set_bit(DEVICE_CATEGORY_CPU, dc->categories);
@@ -319,6 +313,11 @@ static void cpu_common_class_init(ObjectClass *klass, void *data)
     dc->user_creatable = false;
 }
 
+static void cpu_common_post_class_init(ObjectClass *klass, void *data)
+{
+    cpu_exec_class_post_init(CPU_CLASS(klass), data);
+}
+
 static const TypeInfo cpu_type_info = {
     .name = TYPE_CPU,
     .parent = TYPE_DEVICE,
@@ -328,6 +327,7 @@ static const TypeInfo cpu_type_info = {
     .abstract = true,
     .class_size = sizeof(CPUClass),
     .class_init = cpu_common_class_init,
+    .class_post_init = cpu_common_post_class_init,
 };
 
 static void cpu_register_types(void)
diff --git a/hw/core/cpu-system.c b/hw/core/cpu-system.c
index 7b16bda2250..32d09757169 100644
--- a/hw/core/cpu-system.c
+++ b/hw/core/cpu-system.c
@@ -25,12 +25,7 @@
 
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
-- 
2.47.1


