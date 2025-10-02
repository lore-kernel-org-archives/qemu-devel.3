Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69831CAC5B0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 11:33:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4HRX-0006Iv-1P; Thu, 02 Oct 2025 07:25:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1v4HR4-000670-Ay
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 07:25:27 -0400
Received: from mail-yw1-x1135.google.com ([2607:f8b0:4864:20::1135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1v4HQA-0005vN-Ms
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 07:25:16 -0400
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-71d60157747so10734447b3.0
 for <qemu-devel@nongnu.org>; Thu, 02 Oct 2025 04:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1759404261; x=1760009061; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9QlySIVcQz2BhjtBzsIbAtss1aOH9pvU/bNL/Js15TE=;
 b=lpNs6Yq++Y55bj/Hdh6Fe/OsJM06qEQQReeyDJOb+SRsCzAxOrl19E1lJ+nzxHGIo7
 WbmVnwF/fNsrUCc7ua6qRX7j+VAGHkoYM+EU8oGOGsc4OakNOMvoO6JfU2UhStnbcT0m
 f7PdNztelHvCBxfu/RBdofQlvpG38qGuq5RSuEi/rXnivOT0cp9Te9aBLuGbslXH/23X
 8D6MfGn+FX56tA5TjAlY/oXwPDaOz36AveLEYQT/DFQnwpEljBtXDN8YSAEFt6m2AnRs
 9aj9OpYp85euXBqDPyqQVKBQIOiivcxOpcJZI8iLw+0eiY5EBwDfPTeFpwrAuTZBjR58
 pjEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759404261; x=1760009061;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9QlySIVcQz2BhjtBzsIbAtss1aOH9pvU/bNL/Js15TE=;
 b=MGtcUccC/5BE8HrNCaYLu6CgWUO63+HMjBSWnHtpUSNpoq9TbtsXsL98kD5bg3lvbi
 y82R77ggTX86AYZKtn+Yu8y4p32l3MaOjH/EXE1p7pJiqQuSsfmcD29Pm2xnPfY+qKnw
 9u0WgLzpQr5psBAdYSeoT7LY+Ez3sf4YGmHul1Lao/vWWcze8cbJtj/4K3RqSbAXGaQS
 ptAAFJSNWTUAgyILgIROJYn+FQInRf30ZMjCHhOxAdzCtX3bUwa/wQ5dIpa/HONNfwKe
 u142tPCUySse40Pjg/0RcTNgLQPtG0zy6cpO1Jc9FUANbOij5GYYdS1Ry4SOF5DO7K0/
 6ZMw==
X-Gm-Message-State: AOJu0YyokpBY+HaTuOvDFnTbs4k9+tu6YhQ3FDpxsKuKd/rInDCTew26
 yqcDUmKP3AZhh1CdLa5urExVyIewe0C75VfmDPfYy6BfqXCRON61pnd7v4bHYvIOPFrc10ujk2K
 cg/KIjHU=
X-Gm-Gg: ASbGncvVoS+l6lvcoQwNhv+UpCd+u5pn5zZgAJqRvvRnnVELjDYIlDax3IP4GuICv3U
 z5b0TOZFrE2MiGkYvhKQ4F1CHoz6xfEOlH8+nA0phZZHKbnqkbnBUOpgeqoTapBn/zz3kg3UoA0
 ShaGtUX5B+uM1PMpQphZ5yUT0CM5BdaPxj/z8wySdz6pFBKjlg+CottmUiDA5eC9eYpt7bjKizk
 qSDKWpnvJaTDleI1KjfMNGE2/LcdaPY5KUO4tTjDLFBcqGDADeCRCf3dY5ai0Wcvf5DqKcxJDgy
 3TzxLLiH0IrVD9fu7AerUne6te7jjHY6a4+bQnLQKzKRpUMUlDRLXnYIfAxNRkDJfJ1z26upKmQ
 kiZ3q2gXbBJExuGYoNZ4HdI4+7y0l6nSKeAC/7uUcbqap3edwGU7fSaprqPtkkMoMX35XFSWQQU
 I=
X-Google-Smtp-Source: AGHT+IFU2wBjHJS3Dv/GuBnKyU7DVzlZSxs9Yi1kV+lIl2g52P8/clygPYVM/dcLv7ABOi04/y5raQ==
X-Received: by 2002:a05:690c:9302:b0:739:39ba:c195 with SMTP id
 00721157ae682-77f6f1256b6mr71153757b3.6.1759404260965; 
 Thu, 02 Oct 2025 04:24:20 -0700 (PDT)
Received: from grind.dc1.ventanamicro.com
 ([2804:7f0:bcc0:b174:a9af:8146:7deb:fbf3])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-77f81c068f6sm7331627b3.5.2025.10.02.04.24.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Oct 2025 04:24:20 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com,
 richard.henderson@linaro.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH 17/17] hw/riscv/trace: update branch bit in sync messages
Date: Thu,  2 Oct 2025 08:23:35 -0300
Message-ID: <20251002112335.2374517-18-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251002112335.2374517-1-dbarboza@ventanamicro.com>
References: <20251002112335.2374517-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1135;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-yw1-x1135.google.com
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

Now that we have a working branch map update the branch bit in sync
messages by checking if the sync address is a branch address that was
taken (or not).

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 hw/riscv/rv-trace-messages.c |  6 +++---
 hw/riscv/rv-trace-messages.h |  3 ++-
 hw/riscv/trace-encoder.c     | 30 ++++++++++++++++++++++++++++--
 3 files changed, 33 insertions(+), 6 deletions(-)

diff --git a/hw/riscv/rv-trace-messages.c b/hw/riscv/rv-trace-messages.c
index a93b0adfc6..a0a0cbb6ce 100644
--- a/hw/riscv/rv-trace-messages.c
+++ b/hw/riscv/rv-trace-messages.c
@@ -115,11 +115,12 @@ static void rv_etrace_write_header(uint8_t *buf, RVTraceMessageHeader header)
 }
 
 size_t rv_etrace_gen_encoded_sync_msg(uint8_t *buf, uint64_t pc,
-                                      TracePrivLevel priv_level)
+                                      TracePrivLevel priv_level,
+                                      bool pc_is_branch)
 {
     RVTraceSyncPayload payload = {.format = 0b11,
                                   .subformat = 0b00,
-                                  .branch = 1,
+                                  .branch = pc_is_branch,
                                   .privilege = priv_level};
     RVTraceMessageHeader header = {.flow = 0, .extend = 0,
                                    .length = SYNC_PAYLOAD_SIZE_64BITS};
@@ -158,7 +159,6 @@ size_t rv_etrace_gen_encoded_trap_msg(uint8_t *buf, uint64_t trap_addr,
 {
     RVTraceTrapPayload payload = {.format = 0b11,
                                   .subformat = 0b01,
-                                  .branch = 1,
                                   .privilege = priv_level,
                                   .ecause = ecause};
     RVTraceMessageHeader header = {.flow = 0, .extend = 0,
diff --git a/hw/riscv/rv-trace-messages.h b/hw/riscv/rv-trace-messages.h
index 2b371641a4..fd4bb10860 100644
--- a/hw/riscv/rv-trace-messages.h
+++ b/hw/riscv/rv-trace-messages.h
@@ -20,7 +20,8 @@ typedef enum {
 } TracePrivLevel;
 
 size_t rv_etrace_gen_encoded_sync_msg(uint8_t *buf, uint64_t pc,
-                                      TracePrivLevel priv_level);
+                                      TracePrivLevel priv_level,
+                                      bool pc_is_branch);
 size_t rv_etrace_gen_encoded_trap_msg(uint8_t *buf, uint64_t trap_addr,
                                       TracePrivLevel priv_level,
                                       uint8_t ecause,
diff --git a/hw/riscv/trace-encoder.c b/hw/riscv/trace-encoder.c
index 5b8f773b11..39ed8c8d54 100644
--- a/hw/riscv/trace-encoder.c
+++ b/hw/riscv/trace-encoder.c
@@ -394,15 +394,38 @@ static void trencoder_send_message_smem(TraceEncoder *trencoder,
     trencoder_update_ramsink_writep(trencoder, dest, wrapped);
 }
 
+static bool trencoder_addr_is_branch_taken(TraceEncoder *te, uint64_t addr)
+{
+    uint8_t last_branch;
+
+    if (te->branches == 0) {
+        return false;
+    }
+
+    if (te->last_branch_pc == addr) {
+        last_branch = extract32(te->branches, te->branches - 1, 1);
+
+        /* 0: branch taken, 1: not taken*/
+        if (last_branch == 0) {
+            return true;
+        }
+    }
+
+    return false;
+}
+
 static void trencoder_send_sync_msg(Object *trencoder_obj, uint64_t pc)
 {
     TraceEncoder *trencoder = TRACE_ENCODER(trencoder_obj);
     TracePrivLevel priv = trencoder_get_curr_priv_level(trencoder);
     g_autofree uint8_t *msg = g_malloc0(TRACE_MSG_MAX_SIZE);
     uint8_t msg_size;
+    bool is_branch_taken;
 
     trencoder->first_pc = pc;
-    msg_size = rv_etrace_gen_encoded_sync_msg(msg, pc, priv);
+    is_branch_taken = trencoder_addr_is_branch_taken(trencoder, pc);
+    msg_size = rv_etrace_gen_encoded_sync_msg(msg, pc, priv,
+                                              is_branch_taken);
 
     trencoder_send_message_smem(trencoder, msg, msg_size);
 }
@@ -440,6 +463,7 @@ void trencoder_set_first_trace_insn(Object *trencoder_obj, uint64_t pc)
     TracePrivLevel priv = trencoder_get_curr_priv_level(trencoder);
     g_autofree uint8_t *msg = g_malloc0(TRACE_MSG_MAX_SIZE);
     uint8_t msg_size;
+    bool is_branch_taken;
 
     if (trencoder->updiscon_pending) {
         trencoder_send_updiscon(trencoder, pc);
@@ -447,7 +471,9 @@ void trencoder_set_first_trace_insn(Object *trencoder_obj, uint64_t pc)
 
     trencoder->first_pc = pc;
     trace_trencoder_first_trace_insn(pc);
-    msg_size = rv_etrace_gen_encoded_sync_msg(msg, pc, priv);
+    is_branch_taken = trencoder_addr_is_branch_taken(trencoder, pc);
+    msg_size = rv_etrace_gen_encoded_sync_msg(msg, pc, priv,
+                                              is_branch_taken);
 
     trencoder_send_message_smem(trencoder, msg, msg_size);
 }
-- 
2.51.0


