Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D048C369D7
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 19:43:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7JRG-0001cI-V4; Tue, 22 Apr 2025 15:37:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JOr-00054W-Hx
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:35:29 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JOp-00071T-9T
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:35:21 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-227d6b530d8so58417335ad.3
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 12:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745350516; x=1745955316; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LfrM+ZFsKrY5Zrl+zb7ZsXPhOM4tj+2Yc0NhZX/EHbY=;
 b=wJnZCeQZ769Dt4h2CLR7m9QaAKaF0SkR/CcwRKNQO1ZhhCAhET0BTnkZWz5MNlyOmy
 QWvny42EjxTYH940+UnLpQtMGlDwqytcj/6nLLnLyP/OmSymvruVaQV5qUFl81cWGCu9
 J215Ru5Tc6hIUhvSfLqGvWYu4QJ0k3xyghr/eKokzAz7I96xFfHqDhJDwMDTt14DFK8n
 /TLBD4qqT8X+aBHJv/WsC1onoz5uFCYUfjwgCpAZCEAQwdbIr4jemU+lFxsDw+RJAxO5
 Bnm8GVg3Z2GUc1QI2CAZDi8rgzn/9r6cM26BnZDjFBLeebN/EOeXS2WVS5ByekS8K1lV
 QFhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745350516; x=1745955316;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LfrM+ZFsKrY5Zrl+zb7ZsXPhOM4tj+2Yc0NhZX/EHbY=;
 b=wPkoPy/Sw7os2767+BnEEIBXXeTqC5a7Y19yrS+mp/LjQOgdAQnYQjKcYdkk5XjVea
 QqoBjcaJ32+tN6k+lqTCuZ4eI9XQU9l2rG72mHSonS0TUicRJ5fSBhUk9poeW1BU/gv0
 ZMf7dOnppwDc7KAdj7OmqieDUQxnKXugV7f3OvIr2Eh82tGQ1FcWdmzjkiQjHJFy2dpj
 3tU/xTb9HNR6xRbKSiiM4zBf7HaVGeSi63IRB5gzBYc3QVqI64Zqp4wOH1MyAJHcNuCH
 ANLq+DDsSjqbdu0TMO5SHLqYRdYlyb+ixDsh2MWgXktrueqbVbextztemTU2KvA9/IFv
 Py2A==
X-Gm-Message-State: AOJu0YwQQgfyt+pcKM2v8xUEaoH6Moycm+RUyo7dnQOvv6Lx2iA4W8wc
 LvtPL7UzVM/Q8AqTttkoE4wJKhx5D+CCjMgBc/DudnUhianT/RWVCM3KLjn96IW4lynp9ym7wBU
 f
X-Gm-Gg: ASbGncuGclHpuM65tAxVAHxispMocgL9ZIvsy5VD10J5u1Hi6ID1s4px6+DCtJfFRy5
 I/ur+UQXY7Pl/QJamR42upo8KisVB8Scd0nlIfRvYX+LPyHY9DH1OzJAagprgKta21CgiB2uz1e
 GSmC9Qal9zcPrrHRJlHCUWVMg4iFjAMpzT+xOqagj2wx0QARZC+r//SGd6JZpXDDF2GulZ88xhx
 dexQcQetAy53W9OLrNJQEqpeedz8xWFQepqaHh7qjN0ErqnsxJg2TfA2nP9SsVozBlAYHGtlc8X
 /yDUIbtUjTgBoPOtyQLwNMgxVCBXtoz9fdhN5M7Ljdz4V2+ZQVljO0edgTrPr1DYg1jZOYq7GgA
 =
X-Google-Smtp-Source: AGHT+IGI4Ceo/Ix2iA/v5RkAozMwtrq5ApxrTKx71DxUK5EShe11/pcGf9TEFYCHd29uF1+p3+1EWw==
X-Received: by 2002:a17:903:230b:b0:224:1c41:a4c0 with SMTP id
 d9443c01a7336-22c5356e2ecmr240592555ad.9.1745350516591; 
 Tue, 22 Apr 2025 12:35:16 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50fdf1f1sm88996795ad.237.2025.04.22.12.35.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Apr 2025 12:35:16 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 085/147] target/openrisc: Restrict SoftMMU mmu_index() to TCG
Date: Tue, 22 Apr 2025 12:27:14 -0700
Message-ID: <20250422192819.302784-86-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250422192819.302784-1-richard.henderson@linaro.org>
References: <20250422192819.302784-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250401080938.32278-15-philmd@linaro.org>
---
 target/openrisc/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/openrisc/cpu.c b/target/openrisc/cpu.c
index e8abf1f8b5..dc55594a7d 100644
--- a/target/openrisc/cpu.c
+++ b/target/openrisc/cpu.c
@@ -247,6 +247,7 @@ static const TCGCPUOps openrisc_tcg_ops = {
     .translate_code = openrisc_translate_code,
     .synchronize_from_tb = openrisc_cpu_synchronize_from_tb,
     .restore_state_to_opc = openrisc_restore_state_to_opc,
+    .mmu_index = openrisc_cpu_mmu_index,
 
 #ifndef CONFIG_USER_ONLY
     .tlb_fill = openrisc_cpu_tlb_fill,
@@ -269,7 +270,6 @@ static void openrisc_cpu_class_init(ObjectClass *oc, void *data)
                                        &occ->parent_phases);
 
     cc->class_by_name = openrisc_cpu_class_by_name;
-    cc->mmu_index = openrisc_cpu_mmu_index;
     cc->dump_state = openrisc_cpu_dump_state;
     cc->set_pc = openrisc_cpu_set_pc;
     cc->get_pc = openrisc_cpu_get_pc;
-- 
2.43.0


