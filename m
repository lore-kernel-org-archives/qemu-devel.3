Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85DD7CA0EEB
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Aug 2025 18:26:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoR1z-000382-Q0; Tue, 19 Aug 2025 14:26:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uoR1I-0001dY-Jv; Tue, 19 Aug 2025 14:25:20 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uoR1G-0004QX-Rj; Tue, 19 Aug 2025 14:25:16 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-244581cc971so66763425ad.2; 
 Tue, 19 Aug 2025 11:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755627913; x=1756232713; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i6T+1QDRLYXTheY8fOoVhm2NDU4PgwoPKgJ7RKVMPII=;
 b=Zg/PuwNgFdWRD/7iAO/3qscjyKLlIUu1Y3RR1KJYoBRv8uaoppJtdRWGnxll1p0no1
 fRP+uRG+X5TbjP60Llmx7EXMwYxgshWX9z1OQDnnbRmZS3H3c1zlTqvZYqvCL/292VK6
 s4CXkYtp1izzpTdh54wRCTldeaUGuUDJfV6TaCWukKilJQ90zUJMcBHv9cxDMPvp03Mm
 +a0nllMUMo1lwO3TIEmBF/w7r3Jd8XYE4dKB2vnLEpigdxHZuAaax0Ozm5zxhwsTT2la
 HlkanryGzyyGyxyFLr0U5ezXkNXTDfEPjmZIZ9tgHgIaMzaIWQ66QB0chY9Ry0dciewM
 FKeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755627913; x=1756232713;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=i6T+1QDRLYXTheY8fOoVhm2NDU4PgwoPKgJ7RKVMPII=;
 b=UQ+hhk/Lj6vBw4PjIQ8E3Uyz5YRxlhS/zo9rXtqjZK50Xv87u5AcxbZu0Mh4w3ixRL
 TWsT7EC1Y1NYBxWG8M+4phBIFbSOhzUnMWjJQQAp7WnxOaT2qg6ip+1E8JfsLReQiEVR
 BptPZhSOBaJAZWPLSha3QtxSp7kZo33VkZVTkK7UqXBaxzv8poxhOnEF3qv5As3wivmr
 KaN3ra3N5uNR8HU5O1jh+hAn+dGYw9Ix9amEZjUNVZSEcQTydWSMLQoiwow3H4JW/ssB
 pw5oviZyczYa8mMZI72o8YlhSe6E5ECOwOpjkAGa8786dkcNaQ7WL9nBDUg/RDU6B+4j
 pQAg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUK5xLdR7rw9bqurKzff8Pab0rS0VNPjeJ/1P26cdNS3gYHF7vZBUzzOAQfDuyrwKDw3aU7xcKYRsoeUQ==@nongnu.org,
 AJvYcCXqiN5P33ciGkDT9I2rE0Fsri+MqBrPYAU04fwvmmycr6Z1fFGqyqpM96eo+OuMJoEAtWX6OuRxRw==@nongnu.org
X-Gm-Message-State: AOJu0YzTlQu3AiiDHzuvq9jZ3dD1STRSguZ1ciWk3xhejbVs9U6JYUzs
 qZTyMbcsQDKj+ULTcLEUSDLYYFMogIgEIrEJ9/EPg6Y/pCqQ3PA6A2IK1udk1g==
X-Gm-Gg: ASbGncvj3K1gMWY/JNQgIuBixaeUuLh6n6APve5zDs7IODxdSNLDG9Dz7m5Q6PChDvx
 6rgfdzvQyN4vl499DkJ/JPxhq8knd/BCO13VEyzpPXHDecM87De4LMM4I7KZixFF37Hp7SWe1zW
 rQ9O4NR+//gKtRtdnDRdX00CgkXRm1y1XlhCUO+JPrFBCtbkfq74vxP+mSgnqpXipVKVgwP5+25
 GYj+K8SlCeoZv2inbn3bnoQj6s9f31ZYpldnPk4VCUeA5zdCjFJ4X2pP7vd+oFjqAs7WWRERF4R
 O+YJBlXJfwzaOVh2iwgaOf8dFCrlQzjLmcGopB8sL0I8Ijan25fGYVK+leiwgLLA86LlvLFAiBm
 ro/rfdMd/BX+1KqGSx03Xng==
X-Google-Smtp-Source: AGHT+IF4it6/RPjibYLZoKOzO6MtaQFbtQBalU0FKjcuo3N6I392a8XCOhA6Nk4m/QRx3UV+6X38XQ==
X-Received: by 2002:a17:903:fab:b0:240:1f25:d443 with SMTP id
 d9443c01a7336-245e047f53bmr49652015ad.30.1755627912677; 
 Tue, 19 Aug 2025 11:25:12 -0700 (PDT)
Received: from ktock.. ([240d:1a:3b6:8b00:29ce:ef58:c2c9:e52f])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-245ed33b4c2sm3725125ad.25.2025.08.19.11.25.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Aug 2025 11:25:12 -0700 (PDT)
From: Kohei Tokunaga <ktokunaga.mail@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 WANG Xuerui <git@xen0n.name>, Aurelien Jarno <aurelien@aurel32.net>,
 Huacai Chen <chenhuacai@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, Stefan Weil <sw@weilnetz.de>,
 qemu-arm@nongnu.org, qemu-riscv@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, ktokunaga.mail@gmail.com
Subject: [PATCH 28/35] tcg/wasm: Add initialization of fundamental registers
Date: Wed, 20 Aug 2025 03:21:57 +0900
Message-ID: <2e9d7dfd8cc6bf87295714e926561c8a1d0705cc.1755623522.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1755623521.git.ktokunaga.mail@gmail.com>
References: <cover.1755623521.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pl1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

This commit adds initialization of TCG_AREG0 and TCG_REG_CALL_STACK at the
beginning of each TB. The CPUArchState struct and the stack array are passed
from the caller via the WasmContext structure. The BLOCK_IDX variable is
initialized to 0 as TB execution begins at the first block.

Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
---
 tcg/wasm.h                | 10 ++++++++++
 tcg/wasm/tcg-target.c.inc | 19 +++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/tcg/wasm.h b/tcg/wasm.h
index fba8b16503..91567bb964 100644
--- a/tcg/wasm.h
+++ b/tcg/wasm.h
@@ -22,6 +22,16 @@ struct WasmContext {
      * Buffer to store 128bit return value on call.
      */
     void *buf128;
+
+    /*
+     * Pointer to the CPUArchState struct.
+     */
+    CPUArchState *env;
+
+    /*
+     * Pointer to a stack array.
+     */
+    uint64_t *stack;
 };
 
 #endif
diff --git a/tcg/wasm/tcg-target.c.inc b/tcg/wasm/tcg-target.c.inc
index 6b8df4e9d7..0182d072ca 100644
--- a/tcg/wasm/tcg-target.c.inc
+++ b/tcg/wasm/tcg-target.c.inc
@@ -2419,11 +2419,30 @@ static inline void tcg_target_qemu_prologue(TCGContext *s)
 
 static void tcg_out_tb_start(TCGContext *s)
 {
+    intptr_t ofs;
+
     init_sub_buf();
     init_blocks();
     init_label_info();
     init_helpers();
 
+    /* Initialize fundamental registers */
+    tcg_wasm_out_op_idx(s, OPC_GLOBAL_GET, REG_IDX(TCG_AREG0));
+    tcg_wasm_out_op(s, OPC_I64_EQZ);
+    tcg_wasm_out_op_block(s, OPC_IF, BLOCK_NORET);
+
+    ofs = tcg_wasm_out_get_ctx(s, CTX_OFFSET(env));
+    tcg_wasm_out_op_ldst(s, OPC_I64_LOAD, 0, ofs);
+    tcg_wasm_out_op_idx(s, OPC_GLOBAL_SET, REG_IDX(TCG_AREG0));
+
+    ofs = tcg_wasm_out_get_ctx(s, CTX_OFFSET(stack));
+    tcg_wasm_out_op_ldst(s, OPC_I64_LOAD, 0, ofs);
+    tcg_wasm_out_op_idx(s, OPC_GLOBAL_SET, REG_IDX(TCG_REG_CALL_STACK));
+    tcg_wasm_out_op(s, OPC_END);
+
+    tcg_wasm_out_op_const(s, OPC_I64_CONST, 0);
+    tcg_wasm_out_op_idx(s, OPC_GLOBAL_SET, BLOCK_IDX);
+
     tcg_wasm_out_op_block(s, OPC_LOOP, BLOCK_NORET);
     tcg_wasm_out_op_idx(s, OPC_GLOBAL_GET, BLOCK_IDX);
     tcg_wasm_out_op(s, OPC_I64_EQZ);
-- 
2.43.0


