Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71146CCA471
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 11:26:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4HQa-0005qm-Ry; Thu, 02 Oct 2025 07:24:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1v4HQW-0005pO-Oq
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 07:24:48 -0400
Received: from mail-yw1-x112f.google.com ([2607:f8b0:4864:20::112f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1v4HPy-0005sL-Hx
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 07:24:47 -0400
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-71d6051afbfso10389357b3.2
 for <qemu-devel@nongnu.org>; Thu, 02 Oct 2025 04:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1759404245; x=1760009045; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZQFtcZm6r9kvDS7NJVXcadf9exSbBR0ILepPkO9eeJ8=;
 b=TA+/Pt6e7HN7jD//MvB0Puu2Mfs5wuXiwsvHK6uNrwzS1KLEICjLxJkqZRCgh0gxCX
 sn8SJnNfhj7tI7nSRYS3lVcYe6Y8gBFIHmd1QMHRKfIRJ1SnhK9JgK3Oej1QiyQoJ++7
 PpyY8SlDATCbfr3nM/FAtwqHIm6mlTmp3DACVQ6URgUL6a8OTlZHzj0f/bw/C1adI+y6
 zOu+dAyYbk1MdiCAZ8IejE6QYAW5dR7x8ZyirDX7RTgeKKirbCow3fZAZCOMCMDnYUd8
 5R8Me0U0oVPeeiTf++HTd0gpRbISpy1xXd5VwovdXL4HeLLEaCbIyPpfTapm1+LqIztx
 7zYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759404245; x=1760009045;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZQFtcZm6r9kvDS7NJVXcadf9exSbBR0ILepPkO9eeJ8=;
 b=mdaMnrHXTvGbOHHHkKqUdvJ9TWr8FHK2alGyyoo0LA97+ltY0PTUY0v+Q+BKHPUWYU
 pSlvberSsAYXg+olHQnpR6hDP2SlJTgccjRkA8IttLHC6QIHvFC+fM6mrKRwbuXpis8/
 ESo4gsxAxQ10mfbwLCit1rbbmhuSv7nGBzolgjSbZkK+G89lxtfSlcMwtVgfRd8vVIea
 Jo+n1c8h8vp6KX0mqFc15fgMx7EX2rZxHmiG9vU0JVgl87tkcCD0oXLx/6UoyK8bsZQT
 4yx/eZsJq1UGm7H2qgw0/N/c4avLMfpm7OK3yPC0G6ir+K3EHBHH66Ry58C/GUopace+
 ofPw==
X-Gm-Message-State: AOJu0YxHV0Fr5lL2TR6qGwRE1TtMLXE9nSlHcPaVOnz5AGK6CSI0ngUm
 HBQOT7hfZodLY0Mvm5ylAWoi/z2SDcErt5Iwrq9gLtTtGRS3KAm0TUWMvMaT3eY0HaI4MwaTHH6
 365ULuaA=
X-Gm-Gg: ASbGnctNgqeVAePQJts9U0mFpT2mv9YmftWCBbNX/sjBJGCqKT0j204RWwItUaX66aI
 WPHFEi2oyGJ+Jn2nea9VT/DxHvAqffa4vw//ouB1Pu/S8sFmf5zPUAXbX9/GyJKBjMmXvo0w7A0
 i2vRKzE4DcuEkjXow4b/DsPKorwtgpKX3NcxiJICZvjlAiyJJIG4nPA1Ii3kNIy5MSjs9AclTYi
 QYdzcx7ccj6jqe06fJNt1wwIRsVZswEr7fhRU6WjON//c1xCE/Tb1pWKnOIJ9NDtu4HGiJjnwRj
 +jKd44EhGKgOp2rQEDgb8jks4McsSdK0FbFccmXDiHtvlYoBTlPOlo7+UY7Zr6nXIiqHoTh8lVo
 6ecYhdEmP/Uqn9zxRs1mh50Z7SSrpyEkcsD10eDF0+QIO70h1nA3rja3zP/rIi77+UEWfOmU8Tz
 Q=
X-Google-Smtp-Source: AGHT+IFqkXTWZUzYRH+SaTXMmIBl2FUwCQEyTTxFveNB3HcRw7xrQuaoJm5FdhkBvVAkG5URCPwpfA==
X-Received: by 2002:a05:690c:4b82:b0:76b:84cc:a06b with SMTP id
 00721157ae682-77f6f411401mr99977297b3.53.1759404245535; 
 Thu, 02 Oct 2025 04:24:05 -0700 (PDT)
Received: from grind.dc1.ventanamicro.com
 ([2804:7f0:bcc0:b174:a9af:8146:7deb:fbf3])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-77f81c068f6sm7331627b3.5.2025.10.02.04.24.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Oct 2025 04:24:05 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com,
 richard.henderson@linaro.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH 10/17] hw/riscv/rv-trace-messages.c: add encoded trap message
Date: Thu,  2 Oct 2025 08:23:28 -0300
Message-ID: <20251002112335.2374517-11-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251002112335.2374517-1-dbarboza@ventanamicro.com>
References: <20251002112335.2374517-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::112f;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-yw1-x112f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

The trap message consists of a Format 3 Subformat 1 e-trace message.

According to the Efficient Trace for RISC-V spec, section "Format 3
thaddr, address and privilege fields", the 'thaddr' will be zero if:

- we can't infer the EPC after an uninferable PC discontinuity (like traps).
  This doesn't happen in our current TCG backend - we'll always know the
  trap EPC in riscv_cpu_do_interrupt();

- a second interrupt/exception happens while the handler of the first
  trap hasn't exited. This also doesn't happen in TCG given that we do
  not emulate a multi-insn pipeline model, i.e. we'll only retire one
  insns at a time.

This means that we'll always send trap packets with 'thaddr' set to 1,
thus we're hardcoding it in the message helper.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 hw/riscv/rv-trace-messages.c | 94 ++++++++++++++++++++++++++++++++++++
 hw/riscv/rv-trace-messages.h |  5 ++
 2 files changed, 99 insertions(+)

diff --git a/hw/riscv/rv-trace-messages.c b/hw/riscv/rv-trace-messages.c
index 215135dd47..3e9466633d 100644
--- a/hw/riscv/rv-trace-messages.c
+++ b/hw/riscv/rv-trace-messages.c
@@ -35,6 +35,24 @@ typedef struct RVTraceSyncPayload {
 } RVTraceSyncPayload;
 #define SYNC_PAYLOAD_SIZE_64BITS 9
 
+/*
+ * Format 3 subformat 1 without 'time' and 'context' fields
+ */
+typedef struct RVTraceTrapPayload {
+    uint8_t format:2;
+    uint8_t subformat:2;
+    uint8_t branch:1;
+    uint8_t privilege:3;
+    uint8_t ecause:6;
+    uint8_t interrupt:1;
+    uint8_t thaddr:1;
+    uint32_t addressLow;
+    uint32_t addressHigh;
+    uint32_t tvalLow;
+    uint32_t tvalHigh;
+} RVTraceTrapPayload;
+#define TRAP_PAYLOAD_SIZE_64BITS 18
+
 static void rv_etrace_write_bits(uint8_t *bytes, uint32_t bit_pos,
                                  uint32_t num_bits, uint32_t val)
 {
@@ -92,3 +110,79 @@ size_t rv_etrace_gen_encoded_sync_msg(uint8_t *buf, uint64_t pc,
 
     return HEADER_SIZE + SYNC_PAYLOAD_SIZE_64BITS;
 }
+
+/*
+ * Note: this function assumes thaddr = 1.
+ */
+size_t rv_etrace_gen_encoded_trap_msg(uint8_t *buf, uint64_t trap_addr,
+                                      TracePrivLevel priv_level,
+                                      uint8_t ecause,
+                                      bool is_interrupt,
+                                      uint64_t tval)
+{
+    RVTraceTrapPayload payload = {.format = 0b11,
+                                  .subformat = 0b01,
+                                  .branch = 1,
+                                  .privilege = priv_level,
+                                  .ecause = ecause};
+    RVTraceMessageHeader header = {.flow = 0, .extend = 0,
+                                   .length = TRAP_PAYLOAD_SIZE_64BITS};
+    uint8_t bit_pos;
+
+    payload.addressLow = extract64(trap_addr, 0, 32);
+    payload.addressHigh = extract64(trap_addr, 32, 32);
+
+    /*
+     * When interrupt = 1 'tval' is ommited. Take 8 bytes
+     * from the final size.
+     */
+    if (is_interrupt) {
+        header.length = TRAP_PAYLOAD_SIZE_64BITS - 8;
+    }
+
+    rv_etrace_write_header(buf, header);
+    bit_pos = 8;
+
+    rv_etrace_write_bits(buf, bit_pos, 2, payload.format);
+    bit_pos += 2;
+    rv_etrace_write_bits(buf, bit_pos, 2, payload.subformat);
+    bit_pos += 2;
+    rv_etrace_write_bits(buf, bit_pos, 1, payload.branch);
+    bit_pos += 1;
+    rv_etrace_write_bits(buf, bit_pos, 3, payload.privilege);
+    bit_pos += 3;
+
+    rv_etrace_write_bits(buf, bit_pos, 6, payload.ecause);
+    bit_pos += 6;
+
+    if (is_interrupt) {
+        rv_etrace_write_bits(buf, bit_pos, 1, 1);
+    } else {
+        rv_etrace_write_bits(buf, bit_pos, 1, 0);
+    }
+    bit_pos += 1;
+
+    /* thaddr is hardcoded to 1 for now */
+    rv_etrace_write_bits(buf, bit_pos, 1, 1);
+    bit_pos += 1;
+
+    rv_etrace_write_bits(buf, bit_pos, 32, payload.addressLow);
+    bit_pos += 32;
+    rv_etrace_write_bits(buf, bit_pos, 32, payload.addressHigh);
+    bit_pos += 32;
+
+    /* Skip trap_addr if is_interrupt  */
+    if (is_interrupt) {
+        goto out;
+    }
+
+    payload.tvalLow = extract64(trap_addr, 0, 32);
+    payload.tvalHigh = extract64(trap_addr, 32, 32);
+
+    rv_etrace_write_bits(buf, bit_pos, 32, payload.tvalLow);
+    bit_pos += 32;
+    rv_etrace_write_bits(buf, bit_pos, 32, payload.tvalHigh);
+
+out:
+    return HEADER_SIZE + header.length;
+}
diff --git a/hw/riscv/rv-trace-messages.h b/hw/riscv/rv-trace-messages.h
index aeafea8849..f3e38b571f 100644
--- a/hw/riscv/rv-trace-messages.h
+++ b/hw/riscv/rv-trace-messages.h
@@ -21,5 +21,10 @@ typedef enum {
 
 size_t rv_etrace_gen_encoded_sync_msg(uint8_t *buf, uint64_t pc,
                                       TracePrivLevel priv_level);
+size_t rv_etrace_gen_encoded_trap_msg(uint8_t *buf, uint64_t trap_addr,
+                                      TracePrivLevel priv_level,
+                                      uint8_t ecause,
+                                      bool is_interrupt,
+                                      uint64_t tval);
 
 #endif
-- 
2.51.0


