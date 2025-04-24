Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAE94C369CB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 01:26:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7kuI-00072b-D9; Wed, 23 Apr 2025 20:57:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7ktV-0005pc-TA
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:56:52 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7ktS-000567-HJ
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:56:49 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-22928d629faso4316585ad.3
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 17:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745456205; x=1746061005; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sWIZdxiQwNCWQMc8BJaWdVB87by5vfdybCIjbCIrMGM=;
 b=bwt/inqLk23cNdHk7CBS4p+U9AMmmcHhyQu+Uq8dzxUcTBeRUXKTmS2EDSZRhSGxQ2
 tx6m+UiJCMGdbQrN8wAvZdFYrXFsVVbpyNK9K3FF4iP9FTuvoF9qitNOoIGBA8T0imIL
 yTs6ly48oaKmh9qaUHTgISi98x8ZMTXh+3NL8InrYUkCMlDAon6zw7mpFN1x5YNE/fCb
 jJDAXIw3PuMqDzUxST0llGIn5SYkVysZp4z2vM9Jtd95Wh9eMEM3FYD9TbkDDKbXNlme
 soTw6csEMsGagn5DTOz2tZz1UrZ40L/cIfYWHsgikQDqU96NqPNb7SzBlKDoLMehyxy4
 WBHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745456205; x=1746061005;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sWIZdxiQwNCWQMc8BJaWdVB87by5vfdybCIjbCIrMGM=;
 b=pp06mnhAJAFpxy1r1h25Vhkuyu7eIBDZy4YcYi1MYHAJZ4zqZz8Z2j3t19/5dJtIlO
 iOfTV6kTq2gBtMpIUWJTfd9FDlvkvTkE7Y3a5F0uHnh3DIZrCaA0axL57W4xM4/QHNS9
 my27s4+4SszYn+aIDvYImHH/E++T679HuQdI4EKOGHFurG978QsYBUpqBjpUfSZlbTlR
 KE7TGFXheVU8Zs6zAC+KU+7vUW9NNX4EzccsQMtXATvxDmzfEqpMtrUjlzEeljjNUjxF
 SWUM8WklGX4aUkpsAT6WubXgmPJLF5uCKTFNTQJyUitHY7LQWjOdxrSFjnUkaVQmhWEE
 OsIw==
X-Gm-Message-State: AOJu0Yz4PQskAJzXDPK3o2el2dUM5ndb1jJYhQ18wucCzebrtX+74LYb
 qcolphAVsm3vDAxft58wYz4B6YexslCszlUYIm2FPjj1Que//dV9VhLN96rq2uPvzUimc2RxA+n
 z
X-Gm-Gg: ASbGncv6A7JkzWw3mHzCltlbJxHWgktW2uJswDRyV+XI4ezDWpCIraAOFVhP+JHHGkc
 M0sCdgjS5ulUb0EhL+pfU0xQ1xrxmiTNz7PjdAp6XMNy2V+uDMSR7OAVc4jvY0PO9ddgzWahGxI
 8A2u30jRn4UmcOmMJG5GfBudma5+OoC6pGKm6In2fH8jfa1MHa8lOEkWxSJU5sZ1uVo043jjCN/
 OX6X6bmjKqQrBdxh65kuxMc28N6TBi1jyLjwmbQtJRbaSnqmthdGCmq6feOW5Yo2/KnUFnB5XTv
 xYMznKvMjGVGP4MfxPZH8/2Iw5kyFajANtPNK9uh8PSmh5vxvzscful94Zj2gggfkN74l+GeDN8
 =
X-Google-Smtp-Source: AGHT+IGIioqYHNkrDkvG6Qtva/t11YQxMHj762xJqHIJj4pULWvZrglRU2mx4hv0MBZJNLcvCWTo0w==
X-Received: by 2002:a17:903:19e3:b0:223:fabd:4f99 with SMTP id
 d9443c01a7336-22db3bbb17emr9192145ad.5.1745456204606; 
 Wed, 23 Apr 2025 17:56:44 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b15fa907fcdsm119775a12.54.2025.04.23.17.56.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 17:56:44 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 095/148] hw/core/cpu: Remove CPUClass::mmu_index()
Date: Wed, 23 Apr 2025 17:48:40 -0700
Message-ID: <20250424004934.598783-96-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250424004934.598783-1-richard.henderson@linaro.org>
References: <20250424004934.598783-1-richard.henderson@linaro.org>
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

All targets have been converted to TCGCPUOps::mmu_index(),
remove the now unused CPUClass::mmu_index().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250401080938.32278-24-philmd@linaro.org>
---
 include/accel/tcg/cpu-mmu-index.h | 4 +---
 include/hw/core/cpu.h             | 2 --
 accel/tcg/cpu-exec.c              | 1 +
 3 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/include/accel/tcg/cpu-mmu-index.h b/include/accel/tcg/cpu-mmu-index.h
index f1ca385d3c..e681a90844 100644
--- a/include/accel/tcg/cpu-mmu-index.h
+++ b/include/accel/tcg/cpu-mmu-index.h
@@ -34,9 +34,7 @@ static inline int cpu_mmu_index(CPUState *cs, bool ifetch)
 # endif
 #endif
 
-    const TCGCPUOps *tcg_ops = cs->cc->tcg_ops;
-    int ret = tcg_ops->mmu_index ? tcg_ops->mmu_index(cs, ifetch)
-                                 : cs->cc->mmu_index(cs, ifetch);
+    int ret = cs->cc->tcg_ops->mmu_index(cs, ifetch);
     tcg_debug_assert(ret >= 0 && ret < NB_MMU_MODES);
     return ret;
 }
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 29f6419050..28bd27b8ed 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -104,7 +104,6 @@ struct SysemuCPUOps;
  *                 instantiatable CPU type.
  * @parse_features: Callback to parse command line arguments.
  * @reset_dump_flags: #CPUDumpFlags to use for reset logging.
- * @mmu_index: Callback for choosing softmmu mmu index.
  * @memory_rw_debug: Callback for GDB memory access.
  * @dump_state: Callback for dumping state.
  * @query_cpu_fast:
@@ -151,7 +150,6 @@ struct CPUClass {
     ObjectClass *(*class_by_name)(const char *cpu_model);
     void (*parse_features)(const char *typename, char *str, Error **errp);
 
-    int (*mmu_index)(CPUState *cpu, bool ifetch);
     int (*memory_rw_debug)(CPUState *cpu, vaddr addr,
                            uint8_t *buf, size_t len, bool is_write);
     void (*dump_state)(CPUState *cpu, FILE *, int flags);
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 034c2ded6b..9e15105533 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -1075,6 +1075,7 @@ bool tcg_exec_realizefn(CPUState *cpu, Error **errp)
         assert(tcg_ops->cpu_exec_interrupt);
 #endif /* !CONFIG_USER_ONLY */
         assert(tcg_ops->translate_code);
+        assert(tcg_ops->mmu_index);
         tcg_ops->initialize();
         tcg_target_initialized = true;
     }
-- 
2.43.0


