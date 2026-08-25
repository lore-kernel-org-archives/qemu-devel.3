Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B41CCC61DBE
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 14:48:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wysR0-0000hy-EX; Tue, 25 Aug 2026 10:47:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <antikostya2@gmail.com>)
 id 1wys2v-0002vo-M1
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 10:22:37 -0400
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <antikostya2@gmail.com>)
 id 1wys2t-0002BN-KA
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 10:22:37 -0400
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-5b015b2d792so4576365e87.3
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2026 07:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787667754; x=1788272554; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OzW86D2A1WfEQrpaeRRQf+AcujcXbbZ8Qz00fhhJRAU=;
 b=JYsUf+rAG2Ei2iLHb9MZs9wKXU4OWx5ua4UhWDeuQUEIhQDl7IeHOFXnLmE8fCz+64
 So2LBapmyNswFT4AZBAc6J74ed1brMH69HxSrWQgjkoh9nzgfB+gHV6RKNpjwDzbzpoh
 vMID197w5WLfVHEAUzgckWAYp4A9J+gaAtB10kk3ba78X07XIzUqO1JJbdLJvpLdRRsy
 pp3HAhhYMMA0uZsJfe8rdx18ysOvJpuFysI5rn6nZnbfcZA6gnj5LWCIUvWKp2pfyjnR
 X5/B/l0zkm6JD6XrwaWGOHclNcHw7BtDkWgBoHYEDzLlElLceCQMU7K242URQnXBFplI
 4Q7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787667754; x=1788272554;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=OzW86D2A1WfEQrpaeRRQf+AcujcXbbZ8Qz00fhhJRAU=;
 b=NUeGEAkelHZcIS+1icYv+tSSExrRHxxEGS9oHsLbaBkbyHdjUvM646XN/W2vlCrha4
 M1dwcVCtaF7KfyS9w165Vgyk7MzWy/ykJ7u1qbWQB75L3GLUbvqzyrf7aM1L3c2B/oDZ
 E4EFUox2teIG7G+zWTnCoe30alA4iVmAUxSai9kO4iuq6f3QB5W8sFLNerHxqlLw2/TJ
 qtICV35FIXXWT/8V+YDEZ2cpQprfeVhCgjZ1Brahbg3Qp5S+uP0hfx8/ONo4PaIrsoJR
 rxeh4K266rHRASTyqQBVZrskJMB/SM8t6hYjAy9XuKdpzoaLlfkKyyJSVq1XaLO8sPSQ
 pyeg==
X-Gm-Message-State: AFuF++lKZq4Fx5k3AIn056YmrQV9hxBb9nsUxMqUMu6/ya8Rvvev03Mg
 WLYFvT69/WgEqGsSwoP6nKnu4ZEgUSlpR4Z02/trY+QuYyMo/FPTo5tf
X-Gm-Gg: AR+sD12g2gWDkfAbTwr/O9dqjIMHzXSn3E7QgnhuQRyHGQJY3QxQohH5WgA/JBBc4R1
 ECTaKfzUz0m/nbHnOHADW0UvLRkY4rwEV+Ak8cC72pe6e4MJbPyxM1rLJNUWfUIxsAIzHDp8Mcq
 N4XB87NAXDtbm+Evy1xsxxE0I0dwyV+zQY7ZlStZOnultLFGY0hgUBjrPSV8Bw2B7SfmmHSxQS9
 b3HQQtV1gN6cxVwgs+ihXxbqTbrG9zhxDO7QpEf5KGna2YcNZfbsvlzjLDjRLUYkxYFx/+RCEPH
 zq60xcKjREjHe0zg3GH7PRk9hJR3GpXT85q/E7HhEKTXb3HSAjZeW+DgQz8NcWL4OKnA6K9c02L
 qstTP0+YYLwse42iEibrr1Iw45H/BZxhsr9xNxAeiKWRhjtixrC7rABkZ3CL9+HZ219TAepCOdV
 KV6PdQ/IoBhhA67pVcUejC5+is85JpwwxzdhqW6oF8iPIuis23AuklNLgyGHNDzYj46XdfHBCCy
 u1l+OrvBvlYN8fP1Hb9XBhGwpXeSFQL7u1ZVE2p
X-Received: by 2002:a05:6512:8381:b0:5b0:23b4:be97 with SMTP id
 2adb3069b0e04-5b48421a625mr8958086e87.6.1787667753452; 
 Tue, 25 Aug 2026 07:22:33 -0700 (PDT)
Received: from [127.0.1.1] (broadband-90-154-73-22.ip.moscow.rt.ru.
 [90.154.73.22]) by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3a1c82f6b02sm22457551fa.41.2026.08.25.07.22.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 07:22:32 -0700 (PDT)
From: Konstantin Semichastnov <antikostya2@gmail.com>
Date: Tue, 25 Aug 2026 17:22:27 +0300
Subject: [PATCH 03/13] hw/riscv: add n-trace encoder with ProgTraceSync message
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260825-upstream-ntrace_core-v1-3-f8be2f40d2fd@gmail.com>
References: <20260825-upstream-ntrace_core-v1-0-f8be2f40d2fd@gmail.com>
In-Reply-To: <20260825-upstream-ntrace_core-v1-0-f8be2f40d2fd@gmail.com>
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Alexei Filippov <halip0503@gmail.com>, 
 Konstantin Semichastnov <antikostya2@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=8283; i=antikostya2@gmail.com; 
 h=from:subject:message-id;
 bh=hWSIj6Fg7DbARIuisjiJMlp8YHlOaERfE21onkZwFs8=; 
 b=owEBbQKS/ZANAwAKAUiKpW6lUN52AcsmYgBqjaUiGqP9GtW0ntxoZujT3oAAdQDpETYCHr+yV
 H0lBdwIVXaJAjMEAAEKAB0WIQRMBWLx2o+linEPEBhIiqVupVDedgUCao2lIgAKCRBIiqVupVDe
 dljqEACE3JXKlfrhukYWtU1tBftjyHMcfp76CxheuAvUO+kqabrZ/BDz9b88WkRXwik8LQsG+bS
 OFppQEBuiTfcKaq9myVa6HlduqLyZvX75FdoovWXhnpfi5KjlcXdFw/gHlrhqr6oKUvjL9r/bkV
 CSkLpAFzQgCKcMyAi7HRRkrbpTJ7d9mk/T3X+b5KJ29hEkMjy0d+ysXwI+JRHynLy8yLfun6/L4
 IaCQ2CzgGZ1pEo+geKd1GbBCDwT6CIZw4OUvN9UhQPmAfi1MeDAOHHjx10SkM2O1eijZetIUlHD
 NbX4Aq/bs9pNdZdYcvVyUFg2LHtnPvu2wPzSAEII+LA/TfLkGB+kYnS4u5Kkgi6drh73nuZgQYX
 7014ilgwB59UyiHsiq6+uW443k2+7t+4Zpy6OZLwGLpt9ts7LzMRleA9HV8vSyG2WvIJ0rFZcvs
 4OIYysTaQ5Shnmput249k1w3K6hEGw8+ju8HnUnS9Vev1WLvNfT7g6sOjoPPsW1+iC72K2qHAZ3
 NYogCXdAYuM3w8Y0pgPQARqRr+XbMrrFwkLbotwNMNjgsbyGjQP6qA1hCzMfzQNRyWyRKkFy4Mn
 iI3+nLFun3/kEh6sIgYPtoaHfMHyvwQd4gIshCBH2pwwd8T5F3orl9Y9KYfo3YeAhnSaTTv6HI8
 WMMq5M0CtB8HLow==
X-Developer-Key: i=antikostya2@gmail.com; a=openpgp;
 fpr=4C0562F1DA8FA58A710F1018488AA56EA550DE76
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=antikostya2@gmail.com; helo=mail-lf1-x133.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 25 Aug 2026 10:47:29 -0400
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

Introduce N-Trace format message encoder, based on "RISC-V n-trace
(Nexus-based Trace) Specificationand" Version 1.0.

Add generation, encoding and sending logic for ProgTraceSync message

Signed-off-by: Konstantin Semichastnov <antikostya2@gmail.com>
---
 hw/riscv/rv-trace-messages.c | 154 +++++++++++++++++++++++++++++++++++++++++++
 hw/riscv/rv-trace-messages.h |   1 +
 hw/riscv/trace-encoder.c     |  29 +++++++-
 hw/riscv/trace-encoder.h     |   1 +
 4 files changed, 184 insertions(+), 1 deletion(-)

diff --git a/hw/riscv/rv-trace-messages.c b/hw/riscv/rv-trace-messages.c
index 932f3ae499..0b90d6a437 100644
--- a/hw/riscv/rv-trace-messages.c
+++ b/hw/riscv/rv-trace-messages.c
@@ -338,3 +338,157 @@ size_t rv_etrace_gen_encoded_format1(uint8_t *buf,
 
     return HEADER_SIZE + header.length;
 }
+
+#define MDO_BITS_NUM  6
+#define MSEO_BITS_NUM 2
+
+#define MSEO_VAR_FIELD_FINISHED 0b01
+#define MSEO_END_OF_MESSAGE     0b11
+
+typedef enum {
+    FIELD_END = 0,
+    FIELD_FIXED,
+    FIELD_VAR,
+} NTraceFieldType;
+
+typedef enum {
+    WIDTH_TCODE  = 6,
+    WIDTH_SYNC   = 4,
+    WIDTH_ICNT   = 22,
+    WIDTH_FADDR  = 63,
+} NTraceFieldWidth;
+
+typedef enum {
+    TCODE_PROG_TRACE_SYNC        = 0x9,
+} NTraceTcodeFieldValues;
+
+typedef enum {
+    SYNC_PERIODIC      = 2,
+    SYNC_TRACE_ENABLED = 5,
+} NTraceSyncFieldValues;
+
+typedef struct NTraceFieldPayload {
+    NTraceFieldType type;
+    NTraceFieldWidth width;
+    uint64_t value;
+} NTraceFieldPayload;
+
+#define PAYLOAD_TCODE(val)    \
+    {                         \
+        .type = FIELD_FIXED,  \
+        .width = WIDTH_TCODE, \
+        .value = (val),       \
+    }
+
+#define PAYLOAD_SYNC(val)    \
+    {                        \
+        .type = FIELD_FIXED, \
+        .width = WIDTH_SYNC, \
+        .value = (val),      \
+    }
+
+#define PAYLOAD_ICNT(val)    \
+    {                        \
+        .type = FIELD_VAR,   \
+        .width = WIDTH_ICNT, \
+        .value = (val),      \
+    }
+
+#define PAYLOAD_FADDR(val)    \
+    {                         \
+        .type = FIELD_VAR,    \
+        .width = WIDTH_FADDR, \
+        .value = (val),       \
+    }
+#define PAYLOAD_END()      \
+    {                      \
+        .type = FIELD_END, \
+        .width = 0,        \
+        .value = 0,        \
+    }
+
+static size_t rv_ntrace_gen_encoded_msg(uint8_t *buf,
+                                        const NTraceFieldPayload *payload)
+{
+    uint8_t buf_byte   = 0;
+    uint8_t packed_bit = 0;
+    uint8_t packed_cur = 0;
+    uint8_t nr_move    = 0;
+
+    /*
+     * as described in "Chapter 3. N-Trace Transmission Protocol" of N-Trace
+     * spec each byte has only bits[7:2] filled with data, called MDO bits.
+     * Lowest 2 bits[1:0] are called MSEO bits and used to signal about
+     * boundaries between message fields and messages
+     */
+
+    while (payload->type != FIELD_END) {
+        for (uint8_t offset = 0; offset < payload->width; offset += nr_move) {
+            nr_move = MIN(MDO_BITS_NUM - packed_bit, payload->width - offset);
+            uint8_t chunk = extract64(payload->value, offset, nr_move);
+
+            packed_cur = deposit32(packed_cur, packed_bit, nr_move, chunk);
+            packed_bit += nr_move;
+
+            if (packed_bit == MDO_BITS_NUM) {
+                buf[buf_byte++] = packed_cur << MSEO_BITS_NUM;
+                packed_bit = 0;
+                packed_cur = 0;
+            }
+        }
+
+        /*
+         * if field has variable length - last byte of this field should have
+         * MSEO (lowest 2) bits set to 01, and zero filled to end of byte
+         *
+         * N-Trace spec: 3.1. MSEO Sequences.
+         */
+        if (payload->type == FIELD_VAR) {
+            if (packed_bit != 0) {
+                /* last chunk was not finished, leave remaining bits cleared */
+                buf[buf_byte++] = packed_cur << MSEO_BITS_NUM;
+                packed_bit = 0;
+                packed_cur = 0;
+            }
+
+            /* correct last chunk MSEO bits */
+            buf[buf_byte - 1] = deposit32(buf[buf_byte - 1], 0,
+                                          MSEO_BITS_NUM,
+                                          MSEO_VAR_FIELD_FINISHED);
+        }
+
+        payload++;
+    }
+
+    if (packed_bit != 0) {
+        /* last chunk was not finished, so finish it now */
+        buf[buf_byte++] = packed_cur;
+    }
+
+    /*
+     * last byte of message should have MSEO (lowest 2) bits set to 11
+     *
+     * N-Trace spec: 3.1. MSEO Sequences.
+     */
+    buf[buf_byte - 1] = deposit32(buf[buf_byte - 1], 0,
+                                  MSEO_BITS_NUM,
+                                  MSEO_END_OF_MESSAGE);
+
+    return buf_byte;
+}
+
+size_t rv_ntrace_gen_encoded_prog_trace_sync_msg(uint8_t *buf, uint64_t faddr)
+{
+    const NTraceFieldPayload msg_fields[] = {
+        PAYLOAD_TCODE(TCODE_PROG_TRACE_SYNC),
+        /* SRC field is not supported for now */
+        PAYLOAD_SYNC(SYNC_TRACE_ENABLED),
+        PAYLOAD_ICNT(0),
+        PAYLOAD_FADDR(faddr),
+        /* TSTAMP field is not supported for now */
+        PAYLOAD_END(),
+    };
+
+    return rv_ntrace_gen_encoded_msg(buf, msg_fields);
+}
+
diff --git a/hw/riscv/rv-trace-messages.h b/hw/riscv/rv-trace-messages.h
index 6f700eac8e..635e498393 100644
--- a/hw/riscv/rv-trace-messages.h
+++ b/hw/riscv/rv-trace-messages.h
@@ -37,4 +37,5 @@ size_t rv_etrace_gen_encoded_format1(uint8_t *buf,
                                      uint64_t addr,
                                      bool notify, bool updiscon);
 
+size_t rv_ntrace_gen_encoded_prog_trace_sync_msg(uint8_t *buf, uint64_t faddr);
 #endif
diff --git a/hw/riscv/trace-encoder.c b/hw/riscv/trace-encoder.c
index 34c8f60ce1..10e52e207e 100644
--- a/hw/riscv/trace-encoder.c
+++ b/hw/riscv/trace-encoder.c
@@ -255,7 +255,13 @@ static void trencoder_te_ctrl_postw(RegisterInfo *reg, uint64_t val)
     if (!te->trace_running && trTeInstTracing) {
         /* Starting trace. Ask the CPU for the first trace insn */
         if (te->ntrace) {
-            /* send ProgTraceSync message */
+            /*
+             * N-Trace require to trace from very first instruction,
+             * not from next instruction, after enabling the trace,
+             * like E-Trace. So we need to send message here, instead of
+             * using te->trace_next_insn
+             */
+            trencoder_send_prog_trace_sync(OBJECT(te), env->pc);
         } else {
             te->trace_next_insn = true;
         }
@@ -508,6 +514,27 @@ void trencoder_set_first_trace_insn(Object *trencoder_obj, uint64_t pc)
     trencoder_send_message_smem(trencoder, msg, msg_size);
 }
 
+static uint64_t rv_ntrace_encode_faddr(uint64_t pc)
+{
+    return pc >> 1ul;
+}
+
+void trencoder_send_prog_trace_sync(Object *trencoder_obj, uint64_t pc)
+{
+    TraceEncoder *trencoder = TRACE_ENCODER(trencoder_obj);
+    g_autofree uint8_t *msg = g_malloc0(TRACE_MSG_MAX_SIZE);
+    uint8_t msg_size;
+
+    uint64_t faddr = rv_ntrace_encode_faddr(pc);
+
+    g_assert(trencoder->ntrace);
+
+    msg_size = rv_ntrace_gen_encoded_prog_trace_sync_msg(msg, faddr);
+
+    trencoder_send_message_smem(trencoder, msg, msg_size);
+}
+
+
 void trencoder_trace_trap_insn(Object *trencoder_obj,
                                uint64_t pc, uint32_t ecause,
                                bool is_interrupt,
diff --git a/hw/riscv/trace-encoder.h b/hw/riscv/trace-encoder.h
index fed0ef9a48..96324d2b9a 100644
--- a/hw/riscv/trace-encoder.h
+++ b/hw/riscv/trace-encoder.h
@@ -53,6 +53,7 @@ struct TraceEncoder {
 OBJECT_DECLARE_SIMPLE_TYPE(TraceEncoder, TRACE_ENCODER)
 
 void trencoder_set_first_trace_insn(Object *trencoder_obj, uint64_t pc);
+void trencoder_send_prog_trace_sync(Object *trencoder_obj, uint64_t pc);
 void trencoder_trace_trap_insn(Object *trencoder_obj,
                                uint64_t pc, uint32_t ecause,
                                bool is_interrupt,

-- 
2.43.0


