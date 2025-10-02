Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A49C8CAC5B8
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 11:26:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4HR9-00067I-D5; Thu, 02 Oct 2025 07:25:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1v4HQx-00060o-CN
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 07:25:15 -0400
Received: from mail-yw1-x1131.google.com ([2607:f8b0:4864:20::1131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1v4HQ8-0005uj-QC
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 07:25:15 -0400
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-723ad237d1eso9842797b3.1
 for <qemu-devel@nongnu.org>; Thu, 02 Oct 2025 04:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1759404256; x=1760009056; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pKs9ov2ixuL+RqMiFAsA9MuFLdksDx6N2rtbbtP+VaU=;
 b=pOXDGvvI8ltMhVxwuxsT5IGFA6WDA+mL2MAkwG8xMcHCPFvg4mATABkn18DAdxYDPT
 6yx2OHd+pCJw30hdXCloAZj9E7gKi6GKhji80EVTqYKEFNIl+bmZeGC+SMx/voZKOrpZ
 geXUTjtn+fxxoAymbjbhOp7k3WuWALgoeuD20h3d404KEyuQOpNmwIeWpxSB7Ze54gWQ
 MOIQ0qxjS6kHmL+a+yTexZ4NQXBPYz8KDR8Gg3peYkC7L4n3vkJXKTu9Ak2aJEP3kjDU
 s42QcGzzRmNjHOlPGcP5c/kOinIl4e+vJfaPuXOQbwNBGu+wwK9wFw0OvVUSjQuqYUmL
 17bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759404256; x=1760009056;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pKs9ov2ixuL+RqMiFAsA9MuFLdksDx6N2rtbbtP+VaU=;
 b=cFNUVoP/shQbdRflM5FO9qoR2OPDWrP4VqHlm3etW0oFCJqsDEcGhUFSAc6TpwJSbJ
 QjEWbe65/KKtMVa+3AsoBGVqz8ytvoTF4wVUE1qgnVDUsaDvi/qXemWH+5umy4FBpLmc
 X8X6Qwy50bQf44Mphb7Sm77gWHVFV/wiJn72XDloO4a1Ustx4tEBlD53KVsUPdK6Ym+1
 qo1NIN97n4ZKYXfYKkFhubn0solko8tSZTjoNOjWhGnGyo/RFeea3WJSxea/Ga9Is6XM
 bOQya93m0Ae3bPWnsMqErgwtA14NUf9FuZDT5TCwaQHKsdJ+MpScwum+eRvqA/KPLx0b
 7/qg==
X-Gm-Message-State: AOJu0Yw3DaJ0R+vxRHzb3ZabdV5G70rhcKE1imKj19b7EKnwvEq0jzOv
 JsAdiSEDtLvh5S1X7kQuuYVCbXUsmBgQId1ySjt85VxGn0HKozHvrriQyg4SlG4z8oOYl3J0wV0
 zeK+3uXE=
X-Gm-Gg: ASbGnctWv3yWte8hX0pkQz8SSkNhBXkztykvomwvFHoo8efml9Tmqea8JDfmg+WaugA
 MeRxka7zEw/0T06bt7Fs3/rwV8HshW69kozvNFRKPLScjsiEeRJC6S70avBpOY4c13Xut3lWMh0
 RMZ1mvS07y/VvMOWH3xwf0+FCa0ti5ALiJOd2sGl0PR7MpiYUIhsWa0QFBteUAiIfnhh1+WK5A9
 u14u/D2lAzecUQYSToapgxxTW8Sd20E9LHoEWrbdA/BfYC2aveVpiMinuRq8ANcwpyEmKyor0qr
 6hWQ4KQijwH4jt/OeMp8KXNLDXEhqdjdTN8Rp9zpT8AT5oe3uouf3F0tn3JUlORylLdDAPSLavc
 me1smpUVoaBbSyHsou97MwEHi//1DPiMlWRcGLqRA3DOLTn4uU7xee61TqOuHnOpRgj6MEkiIRq
 w=
X-Google-Smtp-Source: AGHT+IH9UIEa7OPQPk+G8ulVHYnreZXuGVpvaRM52AmjrIWklKsURp0NoxrurW5Rb/0+KPZfc7e0uQ==
X-Received: by 2002:a05:690c:6ac4:b0:77e:d606:cc1e with SMTP id
 00721157ae682-77f6f1358a6mr76251017b3.9.1759404256120; 
 Thu, 02 Oct 2025 04:24:16 -0700 (PDT)
Received: from grind.dc1.ventanamicro.com
 ([2804:7f0:bcc0:b174:a9af:8146:7deb:fbf3])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-77f81c068f6sm7331627b3.5.2025.10.02.04.24.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Oct 2025 04:24:15 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com,
 richard.henderson@linaro.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH 15/17] hw/riscv/rv-trace-messages: add format 1 msgs with
 branch info
Date: Thu,  2 Oct 2025 08:23:33 -0300
Message-ID: <20251002112335.2374517-16-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251002112335.2374517-1-dbarboza@ventanamicro.com>
References: <20251002112335.2374517-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1131;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-yw1-x1131.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

Add encoded message helpers to send branch information trace packets.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 hw/riscv/rv-trace-messages.c | 126 +++++++++++++++++++++++++++++++++++
 hw/riscv/rv-trace-messages.h |   7 ++
 2 files changed, 133 insertions(+)

diff --git a/hw/riscv/rv-trace-messages.c b/hw/riscv/rv-trace-messages.c
index 3fa70ba81c..a93b0adfc6 100644
--- a/hw/riscv/rv-trace-messages.c
+++ b/hw/riscv/rv-trace-messages.c
@@ -64,6 +64,31 @@ typedef struct RVTraceFormat2Payload {
 } RVTraceFormat2Payload;
 #define FORMAT2_PAYLOAD_SIZE_64BITS 9
 
+typedef struct RVTraceFormat1BasePayload {
+    uint8_t format:2;
+    uint8_t branches:5;
+    uint32_t branch_map:31;
+} RVTraceFormat1BasePayload;
+#define FORMAT1_BASE_PAYLOAD_SIZE_64BITS 5
+
+typedef struct RVTraceFormat1Payload {
+    uint8_t format:2;
+    uint8_t branches:5;
+    uint32_t branch_map;
+    uint32_t addressLow;
+    uint32_t addressHigh;
+    uint8_t notify:1;
+    uint8_t updiscon:1;
+    uint8_t irreport:1;
+    uint8_t irdepth:3;
+} RVTraceFormat1Payload;
+
+/*
+ * FORMAT2_PAYLOAD_SIZE_64BITS = 9 plus 5 bits of 'branches',
+ * plus minimal 3 bits of 'branch_map' = 10 bytes.
+ */
+#define FORMAT1_PAYLOAD_MIN_SIZE_64BITS 10
+
 static void rv_etrace_write_bits(uint8_t *bytes, uint32_t bit_pos,
                                  uint32_t num_bits, uint32_t val)
 {
@@ -245,3 +270,104 @@ size_t rv_etrace_gen_encoded_format2_msg(uint8_t *buf, uint64_t addr,
 
     return HEADER_SIZE + header.length;
 }
+
+size_t rv_etrace_gen_encoded_format1_noaddr(uint8_t *buf,
+                                            uint8_t branches,
+                                            uint32_t branch_map)
+{
+    RVTraceMessageHeader header = {.flow = 0, .extend = 0,
+        .length = FORMAT1_BASE_PAYLOAD_SIZE_64BITS};
+    RVTraceFormat1BasePayload payload = {.format = 0b01,
+        .branches = branches, .branch_map = branch_map};
+    uint8_t bit_pos;
+
+    rv_etrace_write_header(buf, header);
+    bit_pos = 8;
+
+    rv_etrace_write_bits(buf, bit_pos, 2, payload.format);
+    bit_pos += 2;
+
+    rv_etrace_write_bits(buf, bit_pos, 5, payload.branches);
+    bit_pos += 5;
+
+    rv_etrace_write_bits(buf, bit_pos, 31, payload.branch_map);
+
+    return HEADER_SIZE + header.length;
+}
+
+/*
+ * Same reservations made in the format 2 helper:
+ *
+ * - irreport and irdepth is always == updiscon;
+ *
+ * - return_stack_size_p + call_counter_size_p is hardcoded
+ * to 3 since we don't implement neither ATM.
+ */
+size_t rv_etrace_gen_encoded_format1(uint8_t *buf,
+                                     uint8_t branches, uint32_t branch_map,
+                                     uint64_t addr,
+                                     bool notify, bool updiscon)
+{
+    RVTraceMessageHeader header = {.flow = 0, .extend = 0};
+    RVTraceFormat1Payload payload = {.format = 0b01,
+                                     .branches = branches,
+                                     .notify = notify,
+                                     .updiscon = updiscon};
+    uint8_t payload_size = FORMAT1_PAYLOAD_MIN_SIZE_64BITS;
+    uint8_t branch_map_size = 0;
+    uint8_t bit_pos;
+
+    g_assert(branches < 32);
+
+    if (branches <= 3) {
+        branch_map_size = 3;
+    } else if (branches <= 7) {
+        branch_map_size = 7;
+        payload_size++;
+    } else if (branches <= 15) {
+        branch_map_size = 15;
+        payload_size += 2;
+    } else {
+        branch_map_size = 31;
+        payload_size += 4;
+    }
+
+    header.length = payload_size;
+
+    rv_etrace_write_header(buf, header);
+    bit_pos = 8;
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
+    rv_etrace_write_bits(buf, bit_pos, 2, payload.format);
+    bit_pos += 2;
+
+    rv_etrace_write_bits(buf, bit_pos, 5, payload.branches);
+    bit_pos += 5;
+
+    rv_etrace_write_bits(buf, bit_pos, branch_map_size, payload.branch_map);
+    bit_pos += branch_map_size;
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
index 50a4a0ef19..2b371641a4 100644
--- a/hw/riscv/rv-trace-messages.h
+++ b/hw/riscv/rv-trace-messages.h
@@ -28,5 +28,12 @@ size_t rv_etrace_gen_encoded_trap_msg(uint8_t *buf, uint64_t trap_addr,
                                       uint64_t tval);
 size_t rv_etrace_gen_encoded_format2_msg(uint8_t *buf, uint64_t addr,
                                          bool notify, bool updiscon);
+size_t rv_etrace_gen_encoded_format1_noaddr(uint8_t *buf,
+                                            uint8_t branches,
+                                            uint32_t branch_map);
+size_t rv_etrace_gen_encoded_format1(uint8_t *buf,
+                                     uint8_t branches, uint32_t branch_map,
+                                     uint64_t addr,
+                                     bool notify, bool updiscon);
 
 #endif
-- 
2.51.0


