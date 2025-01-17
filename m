Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A592C02185
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 18:29:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYr1y-00044c-1o; Fri, 17 Jan 2025 13:25:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tYr1v-000418-C3
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 13:25:15 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tYr1t-0007rq-MO
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 13:25:15 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-21bc1512a63so49513685ad.1
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 10:25:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737138311; x=1737743111; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=odcV7Gvy5Hf81zTlTs/tKp0bKYUPWk8WsxFIWicd3Ik=;
 b=P9PQNNq/7zecUpSDw7BAS4XFwvsmguoLZBmCim0vhaF4UHvmeCIW6LqGZQq/Jpf6YI
 dkIaOJ+V4R9nlRQCDd4UogWwwBe9SPF29lj2P7m/9DFdSRs1vQ8U6tIekv76/Vtb/qAx
 5JIPHHqnkEyxhHmD1xPknzL4PTH5SLYnZPTb0ktnnO3Z4GHILj5D4z8Zjrayrr9R/d81
 WxoyuUsd3voks8cglcohfdngs92k/ePoMWoceQvurkJI95NzHFFnghwtWaco0Ui3XOi6
 x6nTVw6gw+kvodzrs8JhqMIAVbzfCETGLSvjQu073Zvgr4BsTChHDg8MpKc8DaYc+bzW
 UtLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737138311; x=1737743111;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=odcV7Gvy5Hf81zTlTs/tKp0bKYUPWk8WsxFIWicd3Ik=;
 b=isFeOV3qGViXO/eN8fHTbQwHhRLcyokcPlUzYvWLUEp1yIYY/QNUwOTXv18FsiZYp5
 Ny+w7zvBRrvkoVHXF+VCA77d/lFL1WpVcIrBU0LAQAsgulxK0sXHNTIFj+44zB4AJGMg
 Ci7orVh22pPpmxH3XTeYcvKdxQ0gim35/pzg5JNpxgdtcZ3a41NPsYAc4SzUlDHwJ5rG
 haJmkTCFpb8iZYXQHp0+gz3l2ARAqwr5w6oNgo6MI/onlG+AT/JGFoFaaRKACdWxXgC9
 mWFOE6Efcyn1ju4R4e6XHueXn5cd0ib28tzzPaPZnBeZUIn35eQb3V/xbb/61f2l4I+1
 tDeA==
X-Gm-Message-State: AOJu0YzK4LG8v7gPintP2Jn9PbmoETNdQ/uDIBs8HvzkrLJIVUKV1pfj
 AFyL9REjXXv9eC3Vv18+vtkRNfbGVEHTM3lqcF1A2Ki7VN3vZbTbse14xjmGQMoq0TLB6kA1+Ck
 c
X-Gm-Gg: ASbGncsQ2ZCHnzVIx5YHbvE4lAwDHXOckjQT1k7LsM6Zr06WWw3qc7RG4UhubkSjHCy
 GFFHXQ7SVvJMwQm3YofH9RfRj5NX2pyG6hRVsl3vwyPsJLzwjz3iL9QkClBpU3K3DYKOkA7Yh2a
 EcziOA7V0+KyP3QLeFcIPJKfdKffzA4YLszVh51QhdqPb/N7P3ovcCadFVd7l8trvIHlUVhbH/B
 5ZlJuPbxj/eaLHI8raqoPWMc/VM5Cv7KSZSaja7QmOdh7NgJvh4z8PPqm6szQMywJhXPn5DNLuY
 vhb8netVsdbXYD0=
X-Google-Smtp-Source: AGHT+IGqVOR6ioxk61jvEJgmaM/7sg7TAczDzlPXJJrEn1aS/na1Ca4B7Lm6qbw+WJ1Ad07xu1opug==
X-Received: by 2002:a17:902:da8b:b0:215:9642:4d7a with SMTP id
 d9443c01a7336-21c34cc9574mr49719305ad.0.1737138310714; 
 Fri, 17 Jan 2025 10:25:10 -0800 (PST)
Received: from stoup.. (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21c2d3acccesm18879005ad.123.2025.01.17.10.25.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2025 10:25:10 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 18/68] tcg: Move fallback tcg_can_emit_vec_op out of line
Date: Fri, 17 Jan 2025 10:24:06 -0800
Message-ID: <20250117182456.2077110-19-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250117182456.2077110-1-richard.henderson@linaro.org>
References: <20250117182456.2077110-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

Don't reference TCG_TARGET_MAYBE_vec in a public header.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg.h | 7 -------
 tcg/tcg.c         | 4 ++++
 2 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index 2671321cb5..fc379bb122 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -1020,17 +1020,10 @@ extern tcg_prologue_fn *tcg_qemu_tb_exec;
 
 void tcg_register_jit(const void *buf, size_t buf_size);
 
-#if TCG_TARGET_MAYBE_vec
 /* Return zero if the tuple (opc, type, vece) is unsupportable;
    return > 0 if it is directly supportable;
    return < 0 if we must call tcg_expand_vec_op.  */
 int tcg_can_emit_vec_op(TCGOpcode, TCGType, unsigned);
-#else
-static inline int tcg_can_emit_vec_op(TCGOpcode o, TCGType t, unsigned ve)
-{
-    return 0;
-}
-#endif
 
 /* Expand the tuple (opc, type, vece) on the given arguments.  */
 void tcg_expand_vec_op(TCGOpcode, TCGType, unsigned, TCGArg, ...);
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 7f5d014973..505e43c128 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -170,6 +170,10 @@ static inline void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
 {
     g_assert_not_reached();
 }
+int tcg_can_emit_vec_op(TCGOpcode o, TCGType t, unsigned ve)
+{
+    return 0;
+}
 #endif
 static void tcg_out_st(TCGContext *s, TCGType type, TCGReg arg, TCGReg arg1,
                        intptr_t arg2);
-- 
2.43.0


