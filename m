Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8831ECCF9E3
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Nov 2025 11:51:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vImsU-0000wq-Td; Tue, 11 Nov 2025 06:49:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vImre-0007pW-KT
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 06:48:46 -0500
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vImrc-0004Zm-Ec
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 06:48:46 -0500
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-b994baabfcfso2547417a12.3
 for <qemu-devel@nongnu.org>; Tue, 11 Nov 2025 03:48:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1762861722; x=1763466522; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ivUquUYiwaXXCD1dXO2VwN1hIYAeG2qwuYKXR8Yl3go=;
 b=N344eOHodYbTS1W/XLuXZpR8sn0rYVcerZXDkioBPa6EZfuP2qGvDZAeEqVvWFqATR
 MeqUIXCqD+Q3DoaiFtR8nWJi9jwMGTuzDb/+Ws+nXIw6CkSH8Iw9fke0aXMlQjmsSR2I
 VgvgqfADU8jrgojRLTkGzbNmVLZaNymrYRsBAxIpUskSnLKqW2XKLjpf98//DT5YGrV8
 QTY0u3p13FVVbkfSo58oRBBIWm86h76wbwXtVZGp7k43yM8RgpSLnVD9KYSkRB/zxluU
 hh3gAGbuGn4Y3UM3ppHVxlXoC/+Yc14gW54GMKXqma1r0kHJho2GokZyJ9NbWUGX8ZPb
 KdZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762861722; x=1763466522;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ivUquUYiwaXXCD1dXO2VwN1hIYAeG2qwuYKXR8Yl3go=;
 b=FsP/QwujV/NMzsnNSC0USq/Mu7XJjjGfj3KXmhDVjCDZhx+hRFG9AxmxvWWFBgTu+j
 3GofOagMxIibBNHYubPL+diCsvBVuhCCTokzbV7jBqC93LNU7IFMmZyn+K7d4iOD/WeO
 vqmDnzDfAcHP5i4N1UwT8/SZaOlyOLaExD9w3mw1KzAO4gEiJVIT9C6GPgE2i4jwE2ry
 6Y4BeaLKoyRtobVZNcoqSIJP4pcY4AD33FAQECx0h8ggfFTBqIBA2iINvuE3yezvxniN
 +kpqMuATnMIXWEDXxsat3XLjnamrZBrlUOygsqDQgrOW9GzOq2GOKfd+wJkmE0WOjk6p
 PwUA==
X-Gm-Message-State: AOJu0YzVx3OrHmsShl45S5LQZXvYXP+v1wrVwEbVAYdDmXZe3rzVVqln
 mQFlSfvyyZDJ2ZldS2hC3msDVbMIw+xp5L142rxTkvqRVcL6V4N0kzjS8OiPy6aEdmzzVbljNK/
 sT/zrrKk=
X-Gm-Gg: ASbGnct/oZ+iWkRzGlFtvxsTnpGNC9rgU/8O9zVswNM6gwdUJ6V01VJpJ4UjLQ1KzyS
 7TJd0bMJ9yNR5zRB1wPaOZp+RZ945TnYe8iFOBAGNyvsqSXzjl/4x1Dl1u0Y6JEWxOBjhBDzyku
 hvovDzXkqpLr8fL9zymZc3hGPxx5YlB+/XhaA+jHIwooWFHmYm1BSPKK5aKw16rYEeyEd+R6T48
 mX9L38IczqgqqDwlTscFsgCSPhF8ABQGqfO42GKnnGPmqB/awS+O5WjqzDN2VU81rrE1smGgiJD
 tcs7Oj3JW+si/OgC55AHrgXbmmnAfrMNrRbKWU9L9OXBOvQ0z2pt6QR5kj5sZNfmaTF/MyyMqUf
 iGt6tIW+Cw1p6rHFmUSv3yywV3VCLicpUFUK0L9Fxp7CgRSRKqWxdz0GcvyfteVCCeNsFO9tnj9
 tCwRhVNPuKHo2NXHl2Y67mzHCTAgs=
X-Google-Smtp-Source: AGHT+IHPPmjHiYmtcQd6TJYSSaltcKlRmr4hQ8mCkU45m7nMaJ1AXhW1TeazFNrtFH1SAzJT+T48hA==
X-Received: by 2002:a17:902:f707:b0:297:f09a:51db with SMTP id
 d9443c01a7336-297f09a5380mr131373575ad.15.1762861722509; 
 Tue, 11 Nov 2025 03:48:42 -0800 (PST)
Received: from grind.dc1.ventanamicro.com ([179.93.21.233])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29651c747d1sm177533125ad.63.2025.11.11.03.48.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Nov 2025 03:48:42 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v2 15/17] hw/riscv/rv-trace-messages: add format 1 msgs with
 branch info
Date: Tue, 11 Nov 2025 08:46:54 -0300
Message-ID: <20251111114656.2285048-16-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251111114656.2285048-1-dbarboza@ventanamicro.com>
References: <20251111114656.2285048-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pg1-x530.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
2.51.1


