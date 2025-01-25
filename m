Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21D8DC0218C
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jan 2025 16:12:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbiiM-0006Rw-6n; Sat, 25 Jan 2025 11:08:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tbihT-0005iE-QB
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 11:08:02 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tbihQ-0000r4-O0
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 11:07:59 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-43622267b2eso31632395e9.0
 for <qemu-devel@nongnu.org>; Sat, 25 Jan 2025 08:07:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737821273; x=1738426073; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5jEVe+YJcTp7UAkGQALuSFnfsOHF6JbuBlxYoBxiLJI=;
 b=emGWG8f+wSEEV1snF87Hselcan53i0B9UvyG/dkNohGE3oR05W5oqp5z6G+gvVwiN/
 TblnoxW1KNLA2Gloe2VjBxj1QJMPHGsG5OuvGVsZ2RCaF1rWUWoz0tkWCHtXkVNZV80v
 M5j15cFKKJg8CdUpPeUsFIltplN6hJqfVxneabffXF161GhZn0Mt+YgeGJkD3Sae+LsD
 yfomMMwwz0lJ0/bifvcrXtnvSi47C8sWnDI6IwPquRITo+xDo6phJdPGV9snsCbp62Pv
 Mf2C/kNqz+rxtK1xthdySyZYWtoGo+HGe6UoOHBDKWPbzV0KK89fBpTE9b6rwPiECTMi
 DZ+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737821273; x=1738426073;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5jEVe+YJcTp7UAkGQALuSFnfsOHF6JbuBlxYoBxiLJI=;
 b=E1RAHCGGjW2J7D/FEn+MUTbzOTvjulXK7Io4h5L6FS+TBGV8IRx272C73rxewLqKBP
 03cFrltuI9o4sriNHHP4+/46cLLmEyn5mvtHBjg84XBPevkjVbmOOe/H2z6ZDXjDVJFd
 /uxu6TkymfnYHcSK1OPEXQvx/c4Ov7GaqF8oUMr4Xizbhd72eOFtuo8NwCUVRxiWIho2
 93sUvJ138XK2mnX0b4KlWXpDuC6r00bX0IQInvaEl0HJhLa9niwjec38aZReTq6M+W81
 CNiVN2xTzMkMamZJng76nWh7ugKy3wYv3xFR7NsvOwqS43FiEbYzGzvAXMllEqtgcpAa
 HLqQ==
X-Gm-Message-State: AOJu0YxZN7SlPszphpPvj+2bCYphM/mZV7Sfzq20JM9s/QLrwcLkF74Z
 0HVOOWh0wmjA9jZnpkv7vmvDcpzPH4uu8p0h4OCgDYrpzjba7+BhJ9i84zw5Zpa7G67hJ05WTBG
 YwCk=
X-Gm-Gg: ASbGncsfS+/l3i+kBhAlsnnT9vFfWWTgyS+EPUsjryNC2CQ0wSNtM/UnycXcsp+/+ee
 sTljSwB+R1YZIH6+zZBMSanVTSiNiUvURWV37Qog0xundPMJsy91Bt0EXoLnPyT2lPg0ORh10t7
 yCKIRPaicTsfE/1FrrrLW/IiWGHtnpxUTC40a4rBtwmu6/YKRbdUtoacSPYV9rtViAHd//Mv7pK
 KL19oVJpKXVb4jAE9wc9wLjrdCSQDXKCcaIyi1TZmK0cYRIdYzkYIscaUmcbaHGr61SRiXrmMfX
 MPw3QdWHTN99nnaHIzPystdYSXd75A3Kj80eDSjX4RM9rk3Lw0ySUAiKDbLq
X-Google-Smtp-Source: AGHT+IGCVz+8vLHTQ7faHu4eYfs+0l264fo5YbCyoXqqRWKlC/E8YZYnLrUuQ7EPleNJ67eJ3gy9zQ==
X-Received: by 2002:a05:600c:524c:b0:432:7c08:d0ff with SMTP id
 5b1f17b1804b1-4389143768fmr316253995e9.23.1737821273389; 
 Sat, 25 Jan 2025 08:07:53 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd501c38sm63952545e9.11.2025.01.25.08.07.51
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 25 Jan 2025 08:07:52 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 24/24] cpus: Remove CPUClass::has_work() handler
Date: Sat, 25 Jan 2025 17:05:52 +0100
Message-ID: <20250125160552.20546-25-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250125160552.20546-1-philmd@linaro.org>
References: <20250125160552.20546-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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
 include/hw/core/cpu.h            | 2 --
 include/hw/core/sysemu-cpu-ops.h | 2 +-
 cpu-target.c                     | 4 ++++
 hw/core/cpu-common.c             | 6 ------
 hw/core/cpu-system.c             | 7 +------
 5 files changed, 6 insertions(+), 15 deletions(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index d64c823e768..2bcad4b16bf 100644
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
index 98e9e7cc4a1..15aa8afef55 100644
--- a/cpu-target.c
+++ b/cpu-target.c
@@ -217,6 +217,10 @@ void cpu_class_init_props(DeviceClass *dc)
 {
 #ifndef CONFIG_USER_ONLY
     ObjectClass *oc = OBJECT_CLASS(dc);
+    const CPUClass *cc = CPU_CLASS(OBJECT_CLASS(oc));
+
+    /* Check mandatory SysemuCPUOps handlers */
+    g_assert(cc->sysemu_ops->has_work);
 
     /*
      * We can't use DEFINE_PROP_BOOL in the Property array for this
diff --git a/hw/core/cpu-common.c b/hw/core/cpu-common.c
index 886aa793c04..c933de1416c 100644
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


