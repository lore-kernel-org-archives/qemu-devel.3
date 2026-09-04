Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42BB7C79F82
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 18:43:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2Ysf-0007eF-PO; Fri, 04 Sep 2026 14:43:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tgamblin@baylibre.com>)
 id 1x2Ysb-0007bW-Cn
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 14:43:15 -0400
Received: from mail-qv1-xf35.google.com ([2607:f8b0:4864:20::f35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tgamblin@baylibre.com>)
 id 1x2YsY-0007FE-Et
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 14:43:13 -0400
Received: by mail-qv1-xf35.google.com with SMTP id
 6a1803df08f44-90e95a18c92so19802466d6.2
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 11:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1788547388; x=1789152188; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=E+pG4qBbSeUEKSM2bhtmJlr1wyo0TQnVA/1AeBtIvkg=;
 b=OBQUKcq6vSncp62sYOnMSESylDYMLRWssNrkliOCDP7SqxBUUGrbWiHA7D2/qbJJDz
 VsDRD6YM1iSPuCqI/1RkUcK5viwHMSauO0XpMyVyrTYIxS/cXH3Pw8gOQcZVpnyibuaI
 QlHHy1AEj4SQZcH62a4a+T2banLTyDKOKmHt8DNX1qHvZRHTKeOLWLjaL+8OcX3SyOBV
 6z38sOCwFN87J0ewb1fnu8aKLGRUzYFjP1AJLWcvlOc8dQvzbRIVmyw9CGCerK+zAizB
 87VwMpE5Fper9nnWMz9nran7JtXi3EUwD+eQzLw7MFPuCG77minGt6QKRhgoJ63/dT2r
 aCZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788547388; x=1789152188;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=E+pG4qBbSeUEKSM2bhtmJlr1wyo0TQnVA/1AeBtIvkg=;
 b=K7BWZ4MdLvctRBQMMxzrLsTUeSwQ/MkbgZlyrJg6YgTZwJ4i1UPsJT4NfmkDTTr57q
 KQDFbJdx1c82kxOjZoghJ6sz7AgxQwwkIzEv/9aF3f+Pui10g1NacWnpjeVxZMnzQWwd
 qoOW4kw+D7F8ZaOa4jMSdC4XC34xwZwsDWb6trIB40Umie6KkF9nUy7JGXLgQPNs04xE
 sjX5/Nv8xQYBeLi9rndbazQ/jNEedzmQs4OlORywB4+GSM2OlyM5WJuVnFfZlmtkfO3N
 RbUiNY06hPgEqjTzPLcOf7x3NPbqcatwa/1YQs7VRXpSW3xCLMHFFhqXodhPfUVI17FD
 Ys9A==
X-Gm-Message-State: AFuF++l99UCffT1uERnO9fQAmYyJ+4PsGt31JQTyeGbd6WD/lMBXauyw
 MFqk0M+moHlOrCCUPwP65KmRuLxGuYNH6RdPLwQrUj96Iw7lnK41YNW1LZxm4FdpBD8=
X-Gm-Gg: AYBFou1yPwRmTfUS4ovGhOgUDhD4C81/p2vkh8s9M9zJPxa76m63qsbxknEXXtNV7sN
 INKYhG9ZL1VKNO9MXmrJupy/tI5tLcsXCloww+ebUK8mrHjElAIQ9OdztHVMmFbRJdQXkIFDX3n
 8Kx3BkhrxW8TG+P7Cr+aI7SS3UFaIZP/AXG+pJuPju8dwjN08iVKsR5/cF7m6edkBOuxbgdYNfL
 v/YuI4jcTtiw9pRIe4UpJ29CKzPXRQN1pCXAabuoQYb5amTjNa4mxywFf5DOnl09xYPjq6CWVk4
 tEjthsBgYmthVHeOHAm72LilMgiuBUIdo7gRoRD9OEtrxLm6G/ykq3pHWmgcltP16teS9KVpNSK
 DHC63ONdUTcF4+L6cCBhnOTDoK4k02vHpJxlYRTqZd7yHJy4yMebGreTN2WxjkdFMqbFb0ju4Uz
 Xen8zaE4Wj4M01J2Gpo7bImHfiPFVDKSog5LqpTdo90SNfQ2hOt33K9osKkGCN5XYCDGs+ny/K
X-Received: by 2002:a05:620a:8423:b0:938:fc91:91ce with SMTP id
 af79cd13be357-9398036365cmr630114185a.20.1788547388181; 
 Fri, 04 Sep 2026 11:43:08 -0700 (PDT)
Received: from [192.168.40.230] ([2001:1970:3847:e000:1977:be2f:4a71:2892])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9397fb36129sm277111985a.19.2026.09.04.11.43.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 11:43:07 -0700 (PDT)
From: Trevor Gamblin <tgamblin@baylibre.com>
Date: Fri, 04 Sep 2026 14:43:04 -0400
Subject: [PATCH v2 1/2] target/riscv: extract check_sfence_vma() from
 helper_tlb_flush()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260904-riscv_tlb_page_flush-v2-1-defec3f29312@baylibre.com>
References: <20260904-riscv_tlb_page_flush-v2-0-defec3f29312@baylibre.com>
In-Reply-To: <20260904-riscv_tlb_page_flush-v2-0-defec3f29312@baylibre.com>
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu@processmission.com>, qemu-riscv@nongnu.org, 
 Trevor Gamblin <tgamblin@baylibre.com>
X-Mailer: b4 0.16.0
Received-SPF: pass client-ip=2607:f8b0:4864:20::f35;
 envelope-from=tgamblin@baylibre.com; helo=mail-qv1-xf35.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Create a new function to encapsulate the privilege/hypervisor checks
performed inside helper_tlb_flush(). The idea is to pass GETPC() as an
argument directly to it inside the helper_tlb_flush() function. We'll
use this function in the following patch for helper_tlb_flush_page().

Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
---
 target/riscv/tcg/op_helper.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/target/riscv/tcg/op_helper.c b/target/riscv/tcg/op_helper.c
index 3e94005d2b..7f63f3ada5 100644
--- a/target/riscv/tcg/op_helper.c
+++ b/target/riscv/tcg/op_helper.c
@@ -588,21 +588,25 @@ void helper_wrs_nto(CPURISCVState *env)
     }
 }
 
-void helper_tlb_flush(CPURISCVState *env)
+static void check_sfence_vma(CPURISCVState *env, uintptr_t ra)
 {
-    CPUState *cs = env_cpu(env);
     if (!env->virt_enabled &&
         (env->priv == PRV_U ||
          (env->priv == PRV_S && get_field(env->mstatus, MSTATUS_TVM)))) {
-        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, ra);
     } else if (env->virt_enabled &&
                (env->priv == PRV_U || get_field(env->hstatus, HSTATUS_VTVM))) {
-        riscv_raise_exception(env, RISCV_EXCP_VIRT_INSTRUCTION_FAULT, GETPC());
-    } else {
-        tlb_flush(cs);
+        riscv_raise_exception(env, RISCV_EXCP_VIRT_INSTRUCTION_FAULT, ra);
     }
 }
 
+void helper_tlb_flush(CPURISCVState *env)
+{
+    CPUState *cs = env_cpu(env);
+    check_sfence_vma(env, GETPC());
+    tlb_flush(cs);
+}
+
 void helper_tlb_flush_all(CPURISCVState *env)
 {
     CPUState *cs = env_cpu(env);

-- 
2.55.0


