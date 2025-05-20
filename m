Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B52B5C3DA6D
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 13:06:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHMV2-0004ZH-Qx; Tue, 20 May 2025 08:55:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uHMUf-0003AO-0k; Tue, 20 May 2025 08:54:53 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uHMUb-00013Q-LS; Tue, 20 May 2025 08:54:52 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-30ecc762cb7so2331624a91.1; 
 Tue, 20 May 2025 05:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747745682; x=1748350482; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VMl+BLj6shot1+8OfcaCTtS5NXf/RyeuCk4yd6sbvuo=;
 b=E2lYGbaXmWH+5v7FIpilWZjsivnVVMXQU+HGLbg8ihEmP3O3esilmjRsIK/SmQGmqq
 iLIQz7k3q0dDXohHBrMlG1wkeOwt7sSLo0o0V5ti//jZqap9OydZukifGW3sNjYPM3HP
 KouiMFKFZrQF8kEibsngmERxpQTfnMWXo1s5JDSWXXkUEtOffNheMqKd/ytbTMJ3ntaT
 o/tAr08GYLlhhsYMCr2egDxa/GnQ9gWjNTrGS9GYSxN3upXjffGtg3J042Pfv1R+URWj
 S+eP4/eiz26UwTFquxkPm3lawwKdTAI64W11SXj9+JsBtjPPhVjUdl9ALFLUd7HwtXVW
 XC+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747745682; x=1748350482;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VMl+BLj6shot1+8OfcaCTtS5NXf/RyeuCk4yd6sbvuo=;
 b=q2nlCgMcZShpZCO7ksuBxnHECtBX21dvSBupcmyn6UGCixVIu5tG6gD71WqQM5wCep
 quhZOonh8M/tGjEjlorvgcIbl1Dzwm1AqPToHruGtrtRIZt6+Z4mQ609J5oadfjkPw17
 9CumSUsSWpHt7TJqE7c8aqYrlZt1ry5yI/r6N1ggJc/DNp5uPeBE291I6En9R5qHMDlz
 Km5V8zcbN6kw/gTzbnJ7wB7FRxt70ubvjqAIgjnNPjqDirX7QzcRbmvNPhcahv7h53gI
 aZgff52cJbrLFsaWIOPWUQjMr+qZLl4fdN3LiS9vrSX5y+wso/ThVKHdJylaALnoN6z7
 pS8Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCV64DX7NsI6uRs03+RqjzxliIOqc9xbTpjtkuD4fLlBh9mW9R4zddM/GMfYb+79XqGjCanyRKrGxQ==@nongnu.org,
 AJvYcCWLrZHKe2CiZGAaYxKeH5Q/CMmAvssumqQDMxDfoakSvAazj9/yXFeORKQQLk4GCNvqrHI+QH7vlFPXPA==@nongnu.org
X-Gm-Message-State: AOJu0Ywlt3rMTk+QEi0nxj/C/X6/ZjL0cx9d9gZBvi0MH9g5OY3TIwSU
 LmXo8kkOk1MHO7GZtuDxmh+8T96NpZPdBtvVTCvXTLfxcZbOnW1hUuJKostMGLs2
X-Gm-Gg: ASbGncukI6QTtlzkHdbuYwNba13yx6HtIUbspFDed9jkCjSBHaNtcRzVi7PBs1n4HF5
 s2pn43sdoMR+IRzmNNdd+zss0O/uNdNWXO/7+4LX3uiKkl45RFW6/fSLDup8D4mW7Eo+xP7moIm
 j0Nd8wk45f2u3iwPJ5jKEf4ihVw/Hl/nQ2gJupCSdtW3qeSAGaQURICTa5jyVA2/Vogz+uDPCjC
 2aWqn0CyySHVLxK/WY5LIIwFye+QIcNHAj1o2anevxpjVv9AHA9RihY/7SI9iuD2Z8NONES4/OB
 FSHneA9gGXIG32HCQRHzeFvLIID9RdjdbzoybrZKuUdrHp4qnGIKIdXmAlSCkg==
X-Google-Smtp-Source: AGHT+IFLR9WZD1ZfyejmhDg0dIA5O+JyaV0hB93IqpSi5hqodoOEgtN1hNTLUEDuyzBJRJYgqpPyVg==
X-Received: by 2002:a17:90a:e7c2:b0:2ff:6e58:89f5 with SMTP id
 98e67ed59e1d1-30e7dc4ed52mr24245041a91.6.1747745682506; 
 Tue, 20 May 2025 05:54:42 -0700 (PDT)
Received: from ktock.. ([240d:1a:3b6:8b00:1bde:8310:e993:5dcc])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30f36364f9asm1625916a91.4.2025.05.20.05.54.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 May 2025 05:54:42 -0700 (PDT)
From: Kohei Tokunaga <ktokunaga.mail@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 WANG Xuerui <git@xen0n.name>, Aurelien Jarno <aurelien@aurel32.net>,
 Huacai Chen <chenhuacai@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, Stefan Weil <sw@weilnetz.de>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Kohei Tokunaga <ktokunaga.mail@gmail.com>, qemu-arm@nongnu.org,
 qemu-riscv@nongnu.org
Subject: [PATCH 26/33] tcg/wasm32: Add initialization of fundamental registers
Date: Tue, 20 May 2025 21:51:28 +0900
Message-ID: <0e9635f3bd25e31fd39eea32242101c2b847784d.1747744132.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1747744132.git.ktokunaga.mail@gmail.com>
References: <cover.1747744132.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pj1-x102e.google.com
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
from the caller via the wasmContext structure. Since TB execution begins at
the first block, the BLOCK_PTR_IDX variable is initialized to 0.

Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
---
 tcg/wasm32.h                | 10 ++++++++++
 tcg/wasm32/tcg-target.c.inc | 17 +++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/tcg/wasm32.h b/tcg/wasm32.h
index 1944249891..ab23e26eca 100644
--- a/tcg/wasm32.h
+++ b/tcg/wasm32.h
@@ -22,6 +22,16 @@ struct wasmContext {
      * Buffer to store 128bit return value on call.
      */
     void *buf128;
+
+    /*
+     * Pointer to CPUArchState struct.
+     */
+    CPUArchState *env;
+
+    /*
+     * Pointer to a stack array.
+     */
+    uint64_t *stack;
 };
 
 #endif
diff --git a/tcg/wasm32/tcg-target.c.inc b/tcg/wasm32/tcg-target.c.inc
index df34097267..4b7cd784cb 100644
--- a/tcg/wasm32/tcg-target.c.inc
+++ b/tcg/wasm32/tcg-target.c.inc
@@ -3258,6 +3258,23 @@ static void tcg_out_tb_start(TCGContext *s)
     init_label_info();
     init_helpers();
 
+    /* generate wasm code to initialize fundamental registers */
+    tcg_wasm_out_op_global_get_r(s, TCG_AREG0);
+    tcg_wasm_out_op_i64_eqz(s);
+    tcg_wasm_out_op_if_noret(s);
+
+    tcg_wasm_out_ctx_i32_load(s, env);
+    tcg_wasm_out_op_i64_extend_i32_u(s);
+    tcg_wasm_out_op_global_set_r(s, TCG_AREG0);
+
+    tcg_wasm_out_ctx_i32_load(s, stack);
+    tcg_wasm_out_op_i64_extend_i32_u(s);
+    tcg_wasm_out_op_global_set_r(s, TCG_REG_CALL_STACK);
+    tcg_wasm_out_op_end(s);
+
+    tcg_wasm_out_op_i64_const(s, 0);
+    tcg_wasm_out_op_global_set(s, BLOCK_PTR_IDX);
+
     tcg_wasm_out_op_loop_noret(s);
     tcg_wasm_out_op_global_get(s, BLOCK_PTR_IDX);
     tcg_wasm_out_op_i64_eqz(s);
-- 
2.43.0


