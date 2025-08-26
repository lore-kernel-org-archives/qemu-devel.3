Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 899DBCA0FF2
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Aug 2025 16:18:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqwJo-0007aV-Fg; Tue, 26 Aug 2025 12:14:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uqwIy-00062A-1R; Tue, 26 Aug 2025 12:13:52 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uqwIq-0008AG-9U; Tue, 26 Aug 2025 12:13:49 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-323267bc2eeso4339033a91.1; 
 Tue, 26 Aug 2025 09:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756224821; x=1756829621; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YcsuOuyWwjyfdwSMhCo/Q1vq9Xw5uCZDKRhMY5glHGY=;
 b=f3rYBc7A6ucw/TjIbHmx387V9E1QZx+3Dbp+XWqNANcYBtzlYjpMU5Ze2LibYKvnRn
 qZ1IlWq97O+ZoV7XoaN0Xd9ghs444QzeM6qqLKKd/RZc1VSQVsLIS+lx4nOOTKr/jZe0
 luensRkqDAQs5zrfOO5jYcG/xAzWPUujWWM3AomTFB6oJ1Z6KuTH6E7SteOXJ4aTYbIU
 7aHoz86ygkWdQNm0pBjCLICf7UyGccaOUYU/c4eWo8nDV3BTQVTCUImk/LPX0XlWmzxm
 fO4WakfRKqNO2gYUq8ho99KOthobAfSYXcTGMM1z+MxcUcvHE+Jyqcn/CBEpCj3W8Fkz
 kQ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756224821; x=1756829621;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YcsuOuyWwjyfdwSMhCo/Q1vq9Xw5uCZDKRhMY5glHGY=;
 b=NgU7jfI870Zb4vSq5V+sCdqZra6gYsAemo/Ul87BrCUPjWD27Pxt+uCn+orBYVujhY
 cHQ/ZdCpmvWKpiY3QKvqiBzYRtiodB75i3kHtLzLH+FbZUlZ9UynG61Jqhr3Op2bvDCj
 6B4i5pII7ogO4fqhlDhthSgi/tYfkOfDvU9Kh4oEojnfymrexNxBChvHOimw2Y34c5UY
 DzxBB2XemjeuQpSr692E69kRX3atJyPmfM5oV97FUekwtRKA1J+TysJ2iWoXpQwFULpg
 wdQyhZALnvc76E/hudg+t5KUgWhPIJd1bM3OaiMITOg4KPv+rZQbIafcvOf+eo8wCAoV
 7Zvw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQzhBCg/fKFCDQpgW/4YNPINFjatL6tzatP7zPoed9JgtXrOJK9Qjm9XobsxwIoZAf5X7piikyGug6NQ==@nongnu.org,
 AJvYcCWx68/L0Y6U6+snjOJ3FqroIAdVqDn+EvFDK2ZaxTpiApa+xsamaGywVLXhl1rRynA7KYPgfubnxQ==@nongnu.org
X-Gm-Message-State: AOJu0YxR2hf3tvAgqtAi4YwAR44hbxxj7eQeLvzFPJo4ssit92ynrk4K
 N7wjGJoYQxTxsssYhQsg7PLZZ3dQZ4KI4Pzv1vuQldT3ZhsHgASXCVs71lc3Lg==
X-Gm-Gg: ASbGncstkLDe/p/cdy6GmPydXZt0Lhoad4H1RxHHbwxyRdjZxzXFmEQM+Huxu1cy2NB
 t9rQRVyab/4aSrTN87dBYqi4FPv1Nxb1lUDxZInWC03l90YcumEAMF53oGUBecQkVY3t9EK57eE
 VjpKEhhjFhDyVf+XjkuvQP4nYcAHCD8Gxf0S1/TKWWmu9QyZD23VJLb9JzVVi3WzM5faMXsFbtf
 wGqoN3hduBcMLdZI2vVX/FEQ/3ptaR5Mh8P+q4ZjN0za+pY9OlySAia4mdAo49Nn5S7FaAcJG3c
 uDH0PoKCOjw8JrwSqxFYy2S9K1vN+0ZKqQXwrM2dBXgNbZk1nESbHsh2k49whsSgMomcBU0pWdx
 lDG2RT6K0bIF/beH3WzxNqQ==
X-Google-Smtp-Source: AGHT+IGW2sf0/G8qJiPjF40q7nLiDesZnJN6MlJmuYkvbzHQWF1j/NFv8JxgsuoLhIZ97JMh1tNnTA==
X-Received: by 2002:a17:90b:570c:b0:323:7e80:8818 with SMTP id
 98e67ed59e1d1-32517b2e158mr22681344a91.37.1756224821097; 
 Tue, 26 Aug 2025 09:13:41 -0700 (PDT)
Received: from ktock.. ([240d:1a:3b6:8b00:561f:1400:11f5:714b])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-32750bc341asm1749747a91.19.2025.08.26.09.13.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Aug 2025 09:13:40 -0700 (PDT)
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
Subject: [PATCH v2 26/35] tcg/wasm: Add initialization of fundamental registers
Date: Wed, 27 Aug 2025 01:10:31 +0900
Message-ID: <6cad2aa3c86c1b67dc2742a7749bef1e752d1ac9.1756216429.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1756216429.git.ktokunaga.mail@gmail.com>
References: <cover.1756216429.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pj1-x102f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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


