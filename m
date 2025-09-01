Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19FDBCA0FFD
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 11:56:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ut33e-0006Po-ML; Mon, 01 Sep 2025 07:50:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1ut31E-0002zw-8K; Mon, 01 Sep 2025 07:48:16 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1ut30z-0001lW-CH; Mon, 01 Sep 2025 07:48:11 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-249036375a1so28531635ad.2; 
 Mon, 01 Sep 2025 04:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756727271; x=1757332071; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YcsuOuyWwjyfdwSMhCo/Q1vq9Xw5uCZDKRhMY5glHGY=;
 b=DDi9sIfalZlUKL+uZv5ryvaDk8S2uIUbNBxErpmkvIVEo25kfR9DXLOrUf7PXwWw74
 Hz61HNyrUgaYHs0SAor/mPIdR1B52xvnw0oAv6KNTmi61zL7ryYbTrUc7CZsIGNZXczs
 lJzhmLhpS0S2ivhbHf7H0j4cAePvZn+QOPFcSt1oeFb9DWFtDziNJw0GX8Mk5oZU6K5w
 qISn64Q5ewDYBfmVmHFUIEITkNvoqX2BprhvluVZL6Pa0j3vpbBM+BAZpmz6e/cFiLag
 VM3qd3YLM7DYBePSNiBqHiQS+K9kYAgZrgnqXEpqudslHU+EpT4drhx0AMjoMwEn3RSv
 Mebw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756727271; x=1757332071;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YcsuOuyWwjyfdwSMhCo/Q1vq9Xw5uCZDKRhMY5glHGY=;
 b=s7BWwXz4AAJa4FHMBKsbKWQ3Lsx2fVYiZK38DXmfOuRLCZ7kBkyROm6rNgsOilrUYJ
 iT8DK5AvlvHR8FVmBGMstr2P5Kk3z0fjGb2Po/AN7L5SDgSZQseg6yILoARWaAP2zskb
 CLs5KH/e3lw+xq/OpcqSOCkF3ejRRnE4dQqJtLA3AuAyxIgLE3/PgFNyptZfEu8VApYQ
 KFDLKGeeM2tx8dRdwBv0lOhSQfeHeqI5o0FrsKKOzMWA7x4tPcSYRXCf2iOCZkPtXexg
 xCk5afckQic086GKd7/Ko2zUgGeZiElW+UJor1Js0MowIB+eGntPTBH/Xs3elZuw56qc
 K/5Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCX3QzalOD5vUKS37aL2cgI9p7Y0l2MquzuMoZrPR2IbVZ9zv5udu2+xEI40wRDmbZ2QhsrpcQUJq5tyLw==@nongnu.org,
 AJvYcCXBbSq8kXC2JkIzjhzo+NIWYkQatE7v/FISvqcy00hu50AhwvlkKaVzxgg7AYJ+kl1iXhBYjYiPBg==@nongnu.org
X-Gm-Message-State: AOJu0YzjRFlzFDU/Zoy313IHmo/6s5WTegDAktj1lDWOEiPV1Mqx4Fq+
 IEgqk7P/H7hYnzBoOZoP0WJqOyuvxb5s/fRQgC/CIezUrNe45tNT/fGwwk3zIA==
X-Gm-Gg: ASbGncvfFThFW3ndrCzp8qiZwgJwA0JLbQWaGZPAcuapdMXrFjxJIabLaDfQsphr2CJ
 FnietEvv2ZmPh04iS5kWjF97pL9TUCakwJOWxsvcQqlP1pTVxJbB/Ka3Y37Bs8Cpv6KEcAEn5aB
 BLdxdFO5rpbPS99ozp7SsC5DjwGQM8lIYSnuR+0xolsSp0Z2n+6yEILMfheGP/Nt0HLRK8Jb3Tg
 oTsZkRhYb1AXYj5llGn2SIKWqts9WTtC01G15PxS1qKkDQ+gwbCD1B0IX9Z2PshGVtd1/VZ/RXB
 YF119twHAVIp7xHa2elVYfwSrDykyE9Ta3fOYMowj2u3xNKAQm/jRQa6BAj5TkA2R63Pl3m3DBF
 JS2RRe/8FpmvRudpiKhqwVCsT2QcbN1uw
X-Google-Smtp-Source: AGHT+IF4k9JW28yu2OtLJ1XqaF1j/293B4OszVExYt/QthFRfpgB1k2PmXcco84Bp6e1958f9Pusig==
X-Received: by 2002:a17:903:1585:b0:24a:8d33:96e3 with SMTP id
 d9443c01a7336-24a8d339832mr92663785ad.19.1756727271304; 
 Mon, 01 Sep 2025 04:47:51 -0700 (PDT)
Received: from ktock.. ([240d:1a:3b6:8b00:750a:cb0b:f0f9:68f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-249065a8036sm103038775ad.129.2025.09.01.04.47.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Sep 2025 04:47:50 -0700 (PDT)
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
Subject: [PATCH v3 26/35] tcg/wasm: Add initialization of fundamental registers
Date: Mon,  1 Sep 2025 20:44:28 +0900
Message-ID: <6cad2aa3c86c1b67dc2742a7749bef1e752d1ac9.1756724464.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1756724464.git.ktokunaga.mail@gmail.com>
References: <cover.1756724464.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pl1-x633.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
index a3631b34a8..f2b67c1099 100644
--- a/tcg/wasm.h
+++ b/tcg/wasm.h
@@ -20,6 +20,16 @@ struct WasmContext {
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
index 598db7b4bd..ba7a5efb5a 100644
--- a/tcg/wasm/tcg-target.c.inc
+++ b/tcg/wasm/tcg-target.c.inc
@@ -2071,11 +2071,30 @@ static void tcg_out_set_carry(TCGContext *s)
 
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


