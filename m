Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2ABEC369D8
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 00:59:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7ktd-0005oM-Cs; Wed, 23 Apr 2025 20:56:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7ktM-0005bh-29
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:56:40 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7ktJ-000542-QH
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:56:39 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-73712952e1cso396431b3a.1
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 17:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745456196; x=1746060996; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I0+phgtXpTHu4kCbYiaq4DT5v48KX8xhY8CEe+xz2e0=;
 b=hxUZikZ8YAUWDnqCvH5c4nOdOqrvRevkrycP34nOmtsPMGZQcNYNVYUdnOC32HgKWB
 IAq9IjRox1u7pIpqsowfk4o3GEwoaSx75l/ckAgRSJnZ15ZvfABiLNub9XitTX1AvF+d
 wY1yrnesaROoDZ6FVQOclNvqYFbG6fx6V4byBJ1GaX47L4EaZmgr79AmVNmhKQIGg621
 ud8vcfgT1p0L2fAMkXiGEJZfsuOAuCXiMWWGy6s3bl8yr81ZphxAG/YcRg46glaLaQ78
 Zk+PwPdzzIM5Pl1ppI8cR2U/pYttDaF7MRfIA/Z9wDHt1rEAkQNkRXxOgog3f7ywZZSN
 65UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745456196; x=1746060996;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I0+phgtXpTHu4kCbYiaq4DT5v48KX8xhY8CEe+xz2e0=;
 b=Zai8prwz7WubjaHZJQCN4sQgve3PTXK2RXZHwos7jOvFTtOWSpUyaGCfxRaiIgP+c2
 nzJNc411Or7227zKMvSZAaDOhIs6uq3zsGWtwLspM/7QqMvUKAMn/U94f/oYcvNeYgsy
 bQqT9tk//9xhTtKHmhLo6rGE3CIn861WxGuX8nyh1DQ5HSyN3tTT7LuO1IhV22JxPi4H
 LeBD8VS3EtgIsTQ39PBo1ETYDfegEWvRyGJkjHKLQuqI3uTDJTkAyvvXjZ4311qtXjG9
 71HPF57BjkxYUxQa2GrNwiy4kn+hRcwC0msuHZ9I/L7VAbOthH7Lskbp/SMj0hxaZxu6
 7knw==
X-Gm-Message-State: AOJu0Yw4J2ImvbGzrJ7BpC2Mmau7RkpKeJ7vdcFhpzoCgoJpUYLDOhph
 mzl5xzrJD97e6L8TpYouHXWIdl9TV68ACT5pNc62S1WB4aM7qDJQn+6Hm0pJBEQN87VJJgQqEhL
 F
X-Gm-Gg: ASbGncuDcBcOeoyQYVWUV+4zKqxTpnoiJT0+vqNGuzpc3VhcN8y3NGZC6pADzRh7DeF
 hS3vn7uMJU0lR1gj5GyH80Icy1CCQEInuxar3gYoMyHfaIzjNmMcFnqkjUNt2nKKMYyIHUjdzG7
 xzb52r/R6cEM688Ko2l0RZJUGWSLycPQEoAkP1RGXFhGLdMm2Eo5wGnSYhVQw8UFJX+KghJN8ra
 epcqioLtyKTChb3zRELLuzYjKyRZgG6hiDD9htSklrz9UbW9E29ISXDi/0KHgYqgK0/nZlAjEwf
 TDWnE+fxLnQ5AQe3KNKnQ0QAAWkMxg1ubAuyAJKDxL9M3DiTml5r1Cie0Z0HMdMdgS5OomZxWy8
 =
X-Google-Smtp-Source: AGHT+IGLQi9lkuLe811EoIRurFLIZsGq+Un/jvpvGFhO2EtWJXgCDxoyr0PHASiBHpFtet2+vj8/hg==
X-Received: by 2002:a05:6a21:33a3:b0:1f5:59e5:8adb with SMTP id
 adf61e73a8af0-20444d1f250mr899488637.0.1745456195960; 
 Wed, 23 Apr 2025 17:56:35 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b15fa907fcdsm119775a12.54.2025.04.23.17.56.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 17:56:35 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 082/148] target/m68k: Restrict SoftMMU mmu_index() to TCG
Date: Wed, 23 Apr 2025 17:48:27 -0700
Message-ID: <20250424004934.598783-83-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250424004934.598783-1-richard.henderson@linaro.org>
References: <20250424004934.598783-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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
Message-ID: <20250401080938.32278-12-philmd@linaro.org>
---
 target/m68k/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
index 0065e1c1ca..4409d8941c 100644
--- a/target/m68k/cpu.c
+++ b/target/m68k/cpu.c
@@ -592,6 +592,7 @@ static const TCGCPUOps m68k_tcg_ops = {
     .initialize = m68k_tcg_init,
     .translate_code = m68k_translate_code,
     .restore_state_to_opc = m68k_restore_state_to_opc,
+    .mmu_index = m68k_cpu_mmu_index,
 
 #ifndef CONFIG_USER_ONLY
     .tlb_fill = m68k_cpu_tlb_fill,
@@ -615,7 +616,6 @@ static void m68k_cpu_class_init(ObjectClass *c, void *data)
                                        &mcc->parent_phases);
 
     cc->class_by_name = m68k_cpu_class_by_name;
-    cc->mmu_index = m68k_cpu_mmu_index;
     cc->dump_state = m68k_cpu_dump_state;
     cc->set_pc = m68k_cpu_set_pc;
     cc->get_pc = m68k_cpu_get_pc;
-- 
2.43.0


