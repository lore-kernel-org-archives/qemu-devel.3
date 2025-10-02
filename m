Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98C98CAC5B0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 11:31:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4HQj-0005sj-U3; Thu, 02 Oct 2025 07:25:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1v4HQg-0005rs-6y
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 07:24:59 -0400
Received: from mail-yw1-x1132.google.com ([2607:f8b0:4864:20::1132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1v4HQ2-0005tR-4D
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 07:24:57 -0400
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-72e565bf2feso10547027b3.3
 for <qemu-devel@nongnu.org>; Thu, 02 Oct 2025 04:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1759404252; x=1760009052; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WjI9dJxX94W6y/LElLrzjNkdEE1XUWa9/CAhU7PpN88=;
 b=QufWiOfW2GxwMdR360bRL+883dGxXTHlJ8aXOvWPagEA9VQwdEeIaSZfc+8swClt6v
 weT9J1/2Q2fIHhmh77D3IcCgs+qnBDGLN25Zp9SmaIy9awhOSxwvAAj5OoN04z6RcOvD
 zu5KApU+c3iv0Xrak/gv0HJRMGjIPZliRILhEYUdamZcyDjWKt07ZHX8BgzpgPpb1o4d
 p5GjqmmfpUkjm9GKmO99vEGmXB5XgSIq+hiR43jOZJjunqNWiGhoqbrdYbcpi+FUAjOf
 9spUiJfBZBKQTPTsyjLHHGSNFFw2krYe/vP54OSQeyLi3b7zJmHtHD1yY+mnCjTKr56b
 e4hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759404252; x=1760009052;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WjI9dJxX94W6y/LElLrzjNkdEE1XUWa9/CAhU7PpN88=;
 b=qHrFVFjVDA1YltZx/7sGbIfYFf0CME0xYvGJj5TNkUEg0hmhaenuuehiRascgVxfuV
 h4cKzp4iWWv+6qEOb6xm6o09RU+4gaZEd1ipfOPJUikv5z0m5+j+dmav65pJX0k//XZT
 VN9vNXDQAZ0vuM/9WVJ74OgGfHkHzlF4O4B395/APF+hKaG2C5PS5khpANgWmmOu9mrX
 tCK6tr9hUhXaUKjFyn3IahOpiATlAF8/im9mbC2MZF3rzK60jIfRITjmR0FqQlRzIU2x
 oA7sGARct+3zsECoA4ZKbyb5Lvy2PBDmkLffkyrcgOgykr1rg3a6Ey1P7jM1eRa8EolK
 zfBg==
X-Gm-Message-State: AOJu0YxiUSJvyJCEzvsk2euMQGnORIQG8hV1SyBticd2hP/2QatEG7tN
 ofls0RccN5xI3DD14tyAzvvh6aK68YtHo2aBxM/mmv7gHAvOk6CUhHFHzZysxe18Msh5wEDhBvH
 18cTXQkM=
X-Gm-Gg: ASbGnct7sLjJ6e7iFOUTXxyW4nJYEpyMYlxpD0EjAOd5Hyv2OSgC4uBomczIrmQSX7G
 xb162BVQmDRwMoRSUd6OnJ1p9OamDhgqVmy8TeQ4NGS0CFekEU5bO6a/K3YXwRAmUghcQLiIY2t
 iU6sQYzDbea845yVWS6doU5+6FAmExFojDIrx+UGt47j4Kso01inlUx2TA/R8lkn0JrBHk969nm
 0AuTqkbOZYXlI9jq3/RzgMb3BH4+sKwnmLG83bztbKfFPQgYJFK+dEv8v6BMiOH7maacNjrAnhX
 jzx0qLwiqGWAFLFXg4UKJCTR98zXIblTn0/BkMU78MHipGZz/UWdro5LqkHldsLCaDmOhom1tKa
 GZTZUn2PY+6VUFZNTJ0RpsQId7LGQoqKH2CNRqZj7On5I5ZIQ9mlJQSdULz+xl3ciQ4GhtowlBF
 LT/eu/6HJVeg==
X-Google-Smtp-Source: AGHT+IGQo06LyiYb2yPkhFVc/YlDGIiH9UGxZr9nts6qclBkbLalJ9SAo0nSBth89cI+TYWnMZH2tg==
X-Received: by 2002:a0d:e7c5:0:b0:771:dda2:f1fd with SMTP id
 00721157ae682-77f6f26efe1mr65948307b3.18.1759404251961; 
 Thu, 02 Oct 2025 04:24:11 -0700 (PDT)
Received: from grind.dc1.ventanamicro.com
 ([2804:7f0:bcc0:b174:a9af:8146:7deb:fbf3])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-77f81c068f6sm7331627b3.5.2025.10.02.04.24.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Oct 2025 04:24:11 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com,
 richard.henderson@linaro.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH 13/17] hw/riscv/trace: add format2 msg helper
Date: Thu,  2 Oct 2025 08:23:31 -0300
Message-ID: <20251002112335.2374517-14-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251002112335.2374517-1-dbarboza@ventanamicro.com>
References: <20251002112335.2374517-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1132;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-yw1-x1132.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Before handling updiscon (uninferable PC discontinuity) cases add the
encoded message we're going to use, format 2. Format 1 will be added
when we add the branch map.

There are design decisions worth documenting in this patch. For irreport,
the e-trace-encap spec [1] in section 7.6. "Format 2 packets",  says that
we should make this bit !updiscon if we're either:

"following a return because its address differs from the predicted return
address at the top of the implicit_return return address stack, or the
last retired before an exception, interrupt, privilege change or resync
because it is necessary to report the current address stack depth or
nested call count."

We do not implement any form of call/return prediction in the encoder,
and TCG will always retire a single insn per cycle. This means that
we'll never set irreport, i.e. irreport will always be equal to
updiscon. If this interpretation turns out to be wrong we'll revisit
this helper.

Likewise, irdepth is also not implemented since we'll always return a
package where irreport == updiscon. The size of the field is arbitrarily
set to '3' to avoid adding padding in the end of the msg to complete an
extra byte.

[1] https://github.com/riscv-non-isa/e-trace-encap/releases/tag/v1.0

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 hw/riscv/rv-trace-messages.c | 59 ++++++++++++++++++++++++++++++++++++
 hw/riscv/rv-trace-messages.h |  2 ++
 2 files changed, 61 insertions(+)

diff --git a/hw/riscv/rv-trace-messages.c b/hw/riscv/rv-trace-messages.c
index 3e9466633d..3fa70ba81c 100644
--- a/hw/riscv/rv-trace-messages.c
+++ b/hw/riscv/rv-trace-messages.c
@@ -53,6 +53,17 @@ typedef struct RVTraceTrapPayload {
 } RVTraceTrapPayload;
 #define TRAP_PAYLOAD_SIZE_64BITS 18
 
+typedef struct RVTraceFormat2Payload {
+    uint8_t format:2;
+    uint32_t addressLow;
+    uint32_t addressHigh;
+    uint8_t notify:1;
+    uint8_t updiscon:1;
+    uint8_t irreport:1;
+    uint8_t irdepth:3;
+} RVTraceFormat2Payload;
+#define FORMAT2_PAYLOAD_SIZE_64BITS 9
+
 static void rv_etrace_write_bits(uint8_t *bytes, uint32_t bit_pos,
                                  uint32_t num_bits, uint32_t val)
 {
@@ -186,3 +197,51 @@ size_t rv_etrace_gen_encoded_trap_msg(uint8_t *buf, uint64_t trap_addr,
 out:
     return HEADER_SIZE + header.length;
 }
+
+/*
+ * Note: irreport and irdepth is always == updiscon.
+ *
+ * return_stack_size_p + call_counter_size_p is hardcoded
+ * to 3 since we don't implement neither ATM.
+ */
+size_t rv_etrace_gen_encoded_format2_msg(uint8_t *buf, uint64_t addr,
+                                         bool notify, bool updiscon)
+{
+    RVTraceFormat2Payload payload = {.format = 0b11,
+                                     .notify = notify,
+                                     .updiscon = updiscon};
+    RVTraceMessageHeader header = {.flow = 0, .extend = 0,
+                                   .length = FORMAT2_PAYLOAD_SIZE_64BITS};
+    uint8_t bit_pos;
+
+    payload.addressLow = extract64(addr, 0, 32);
+    payload.addressHigh = extract64(addr, 32, 32);
+
+    payload.irreport = updiscon;
+    if (updiscon) {
+        payload.irdepth = 0b111;
+    } else {
+        payload.irdepth = 0;
+    }
+
+    rv_etrace_write_header(buf, header);
+    bit_pos = 8;
+
+    rv_etrace_write_bits(buf, bit_pos, 2, payload.format);
+    bit_pos += 2;
+
+    rv_etrace_write_bits(buf, bit_pos, 32, payload.addressLow);
+    bit_pos += 32;
+    rv_etrace_write_bits(buf, bit_pos, 32, payload.addressHigh);
+    bit_pos += 32;
+
+    rv_etrace_write_bits(buf, bit_pos, 1, payload.notify);
+    bit_pos += 1;
+    rv_etrace_write_bits(buf, bit_pos, 1, payload.updiscon);
+    bit_pos += 1;
+    rv_etrace_write_bits(buf, bit_pos, 1, payload.irreport);
+    bit_pos += 1;
+    rv_etrace_write_bits(buf, bit_pos, 3, payload.irdepth);
+
+    return HEADER_SIZE + header.length;
+}
diff --git a/hw/riscv/rv-trace-messages.h b/hw/riscv/rv-trace-messages.h
index f3e38b571f..50a4a0ef19 100644
--- a/hw/riscv/rv-trace-messages.h
+++ b/hw/riscv/rv-trace-messages.h
@@ -26,5 +26,7 @@ size_t rv_etrace_gen_encoded_trap_msg(uint8_t *buf, uint64_t trap_addr,
                                       uint8_t ecause,
                                       bool is_interrupt,
                                       uint64_t tval);
+size_t rv_etrace_gen_encoded_format2_msg(uint8_t *buf, uint64_t addr,
+                                         bool notify, bool updiscon);
 
 #endif
-- 
2.51.0


