Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E159C54E6E
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Mar 2024 13:19:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rl7LN-0001jo-8l; Fri, 15 Mar 2024 09:11:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rl7L9-0000jH-7E
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 09:11:15 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rl7L6-0008VV-Cn
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 09:11:14 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a450bedffdfso240670766b.3
 for <qemu-devel@nongnu.org>; Fri, 15 Mar 2024 06:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710508269; x=1711113069; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oFQX8aoXPy4f67f4Z4hL1RP4Zt/8Mcsow7bhGPOckjM=;
 b=kQwSSy5rpT0flCZWWWbRGYuLlc/QRK/FgdbQ27xmWyr8w2G7ZnNyVIYSXZtjJBEyby
 QZtPx2JijZQpSu3QvZtr5F/tjsKzZOhq9cTzX35je+SAmxewa1OAbWcLpKdhz2Kx7mFp
 Tc6xtt8uGxp4M20U7QrBFDb1ZI8k6mIv+AER+9C2UfK8ASMyCkIgOgVyCHcRZJ+p5eOA
 tgnZVpYtlmMtd7NUPSwn6asYgfx0W9G/i9b3JaQPFv9wyHT33xL0xR5VMi10P5Y8BQci
 pXCUZ0/kct3BCAHxcE0JxGwqlBUOKXy+AvFooh9J/UDlpTdsOxXw7tMpAyGjurUBsY1i
 KRIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710508269; x=1711113069;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oFQX8aoXPy4f67f4Z4hL1RP4Zt/8Mcsow7bhGPOckjM=;
 b=B8pKq5wh6ije87PNztwoGtoVVu++QobZpgwTZVLb4dUuCq0Vuq8T9lRWZ55iDQHxAb
 V57iuHaq09g/OD4XcA8vvLxPCS2IZPsM+n4si8Y1W3dyHN2P8Y7hl7lHaeUTXKo+e26Q
 yPr6nYYgdpBpXtFYXr6u6eJFWKHNAV8F0xtvcUusdx64hEirLbtSykixKG7rAwCx7lVY
 4GKLE2HRhK/B4wWQPk1jNEVmXOrSf9glDjj0mbdx3AFGudvfGpRKpAmXIJ4Ud8N9V/2n
 ROgXMhsvZXgQrUipiXGJyL/nD/iS2sT5H/agRLoDbmDcnqhQObMtIjZG3fSErFKn+PgO
 zBfg==
X-Gm-Message-State: AOJu0Yw/MsjPrUK/wqMot3jBKnnvH5g8a20UVtFjFNBGHCRsatQG03DX
 e3Xb1waIDYAwmiEbsz20TFa8Rg7EQFkGQkcasr+83sv5JvNXUt+tTdYO8vMWOlf+eqxcxExSTmW
 G
X-Google-Smtp-Source: AGHT+IF+MuEc059bBpNi8Z/N4PGDT98KYLptzGgGl6UNuatWgPqddtvCqzOiCyAHdP8HEfeppGnxnA==
X-Received: by 2002:a17:906:4a10:b0:a46:8ca9:eb2e with SMTP id
 w16-20020a1709064a1000b00a468ca9eb2emr932738eju.38.1710508269218; 
 Fri, 15 Mar 2024 06:11:09 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.145.26])
 by smtp.gmail.com with ESMTPSA id
 a23-20020a1709066d5700b00a467a129104sm1183953ejt.173.2024.03.15.06.11.06
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 15 Mar 2024 06:11:08 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Markus Armbruster <armbru@redhat.com>
Cc: qemu-riscv@nongnu.org, Anton Johansson <anjo@rev.ng>,
 qemu-s390x@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Claudio Fontana <cfontana@suse.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, qemu-arm@nongnu.org,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: [RFC PATCH-for-9.1 17/21] target/riscv: Use QMP
 generic_query_cpu_definitions()
Date: Fri, 15 Mar 2024 14:09:05 +0100
Message-ID: <20240315130910.15750-18-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240315130910.15750-1-philmd@linaro.org>
References: <20240315130910.15750-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Expose riscv_cpu_add_definition() and use it as add_definition()
handler, then use the QMP generic_query_cpu_definitions() method.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/riscv/cpu.h            |  2 ++
 target/riscv/cpu.c            |  1 +
 target/riscv/riscv-qmp-cmds.c | 11 +++--------
 3 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 3b1a02b944..15fc287680 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -824,4 +824,6 @@ void riscv_cpu_register_gdb_regs_for_features(CPUState *cs);
 uint8_t satp_mode_max_from_map(uint32_t map);
 const char *satp_mode_str(uint8_t satp_mode, bool is_32_bit);
 
+void riscv_cpu_add_definition(gpointer data, gpointer user_data);
+
 #endif /* RISCV_CPU_H */
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index c160b9216b..2da9364335 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -2341,6 +2341,7 @@ static int64_t riscv_get_arch_id(CPUState *cs)
 #include "hw/core/sysemu-cpu-ops.h"
 
 static const struct SysemuCPUOps riscv_sysemu_ops = {
+    .add_definition = riscv_cpu_add_definition,
     .get_phys_page_debug = riscv_cpu_get_phys_page_debug,
     .write_elf64_note = riscv_cpu_write_elf64_note,
     .write_elf32_note = riscv_cpu_write_elf32_note,
diff --git a/target/riscv/riscv-qmp-cmds.c b/target/riscv/riscv-qmp-cmds.c
index d363dc318d..45adc90d3b 100644
--- a/target/riscv/riscv-qmp-cmds.c
+++ b/target/riscv/riscv-qmp-cmds.c
@@ -26,6 +26,7 @@
 
 #include "qapi/error.h"
 #include "qapi/qapi-commands-machine-target.h"
+#include "qapi/commands-target-compat.h"
 #include "qapi/qmp/qbool.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/qobject-input-visitor.h"
@@ -36,7 +37,7 @@
 #include "cpu-qom.h"
 #include "cpu.h"
 
-static void riscv_cpu_add_definition(gpointer data, gpointer user_data)
+void riscv_cpu_add_definition(gpointer data, gpointer user_data)
 {
     ObjectClass *oc = data;
     CpuDefinitionInfoList **cpu_list = user_data;
@@ -55,13 +56,7 @@ static void riscv_cpu_add_definition(gpointer data, gpointer user_data)
 
 CpuDefinitionInfoList *qmp_query_cpu_definitions(Error **errp)
 {
-    CpuDefinitionInfoList *cpu_list = NULL;
-    GSList *list = object_class_get_list(TYPE_RISCV_CPU, false);
-
-    g_slist_foreach(list, riscv_cpu_add_definition, &cpu_list);
-    g_slist_free(list);
-
-    return cpu_list;
+    return generic_query_cpu_definitions(errp);
 }
 
 static void riscv_check_if_cpu_available(RISCVCPU *cpu, Error **errp)
-- 
2.41.0


