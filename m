Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E94B6C369D7
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 19:53:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7JQX-0000Hq-8B; Tue, 22 Apr 2025 15:37:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JOv-0005AG-Rh
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:35:30 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JOt-000732-R1
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:35:25 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2279915e06eso58645325ad.1
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 12:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745350521; x=1745955321; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XOzE7rPFSES9/s5906mqBQxSMctIAbl+hzNfrPQ2HWo=;
 b=JTv1zoSmtEq7UrnsEOC0/7KuGg73dBjGEcvuQ576+dVn0rXcYvsLcbFNtjFQwDMdM+
 2v4lrozPjERIOzGkLypuup4mActraz1W6mVke/MDapPMC5xTqhLUlpcSMXaxSAGeYnkE
 QuF3sl5l2mJguZbStNwT0aC6LAi7juY9zi8qr1ubS/NtMpdEVLeyLF6A7KGdDbeo0Chs
 Pa05uL9c1byl2v2UZr33HaqVjQs9Yr7TiEYHc2HT70UmTUpfBmI+yuy8b3Mhv9MJ5E1z
 AFd/tGZARuRfsGZK2OFPJ5axW/R4xEhyJfAV9SN1/kdZfAq1Yz0CGSTiioQRSh61nw01
 VLFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745350521; x=1745955321;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XOzE7rPFSES9/s5906mqBQxSMctIAbl+hzNfrPQ2HWo=;
 b=qHVUEWKSPcKN+yCPK1tvW+KVSsNqSv0BsHlRndHTmxl1rGk2PmXrr2VhlYRs1EyN4q
 mkgCujqpB8JAfhUvjgTyut/15eB7FGR/KFDfYIaHBwv085h1BcEKAvVzZkMXwBfVFCyG
 Rv+CKBooxXPTT8eGBTl8eLTrX4GyV0tJq/7isqx2q6nZlPl9tEYCN+wfH43IGQa2D/Oe
 fSXZo1I7p6qJrnM+4nhqlsqVFNuWTaJnJtEN/MqGM8NsbUUbxW/qtA5DOW1DYzJai89V
 r0BKerej38eR3yXMpAATV0OfU76cP3HBHSw2n0if3MCX4hM0dTR2FxFMQstcoyjKnqRQ
 fq8w==
X-Gm-Message-State: AOJu0YwNZLIhpM2qw4znYroDXzadNBglXsNeYiFZJzPusskC5H3ZTDd/
 snBKg0Uyh6WY8XeOQEcFQYXVNKZtUeqEDkiPTH9YzSJd9thOBPAeB3iKQ1L88aytyNV0brwOvY/
 1
X-Gm-Gg: ASbGncvw/ejpNpT3SIeCb4/oYfB1nnX+mEF3wlVuQBae8JfE/q71JNgXzR7JtbSUVYz
 I7TIO/RvOLMjqwFN78rHZD/1ENYKkMkH2O5Hu7xUfjcBEALq7bQMfBYAKZD3IJhqAZpsjqRIwkM
 rjTNChX6ekLM6BK4vHfvZ/5WOoPoUzUMaqfbUlQ2o8r7ZCmkzzRVTzl+pDhGzGWREjeGzK1a4lh
 tLVndQ+RciuGosQj89qMdavx8TpauR2VFKGkOqwtLIwK+7B6u0mm5qzxXVEa4FsYBUKdG7Yav1b
 O+ZEIMrK7poqgZUaFrSrth1pLTfuhhXYt6ghoXSQtD7955LNla2HY7uCXLpDSDicHP/e2dx3WRY
 =
X-Google-Smtp-Source: AGHT+IEfeRxRc6v3i3/80kKQojoqgGqwIqX7mJqW5+Z7xIr2paF7oC+u8iBcH3IXAFSnIBaJB1sScw==
X-Received: by 2002:a17:903:2304:b0:22c:3294:f038 with SMTP id
 d9443c01a7336-22c5359e53cmr229613065ad.18.1745350521601; 
 Tue, 22 Apr 2025 12:35:21 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50fdf1f1sm88996795ad.237.2025.04.22.12.35.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Apr 2025 12:35:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 093/147] target/xtensa: Restrict SoftMMU mmu_index() to TCG
Date: Tue, 22 Apr 2025 12:27:22 -0700
Message-ID: <20250422192819.302784-94-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250422192819.302784-1-richard.henderson@linaro.org>
References: <20250422192819.302784-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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
Message-ID: <20250401080938.32278-23-philmd@linaro.org>
---
 target/xtensa/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/xtensa/cpu.c b/target/xtensa/cpu.c
index ec6a0a8b66..51f9ee9e89 100644
--- a/target/xtensa/cpu.c
+++ b/target/xtensa/cpu.c
@@ -236,6 +236,7 @@ static const TCGCPUOps xtensa_tcg_ops = {
     .translate_code = xtensa_translate_code,
     .debug_excp_handler = xtensa_breakpoint_handler,
     .restore_state_to_opc = xtensa_restore_state_to_opc,
+    .mmu_index = xtensa_cpu_mmu_index,
 
 #ifndef CONFIG_USER_ONLY
     .tlb_fill = xtensa_cpu_tlb_fill,
@@ -262,7 +263,6 @@ static void xtensa_cpu_class_init(ObjectClass *oc, void *data)
                                        &xcc->parent_phases);
 
     cc->class_by_name = xtensa_cpu_class_by_name;
-    cc->mmu_index = xtensa_cpu_mmu_index;
     cc->dump_state = xtensa_cpu_dump_state;
     cc->set_pc = xtensa_cpu_set_pc;
     cc->get_pc = xtensa_cpu_get_pc;
-- 
2.43.0


