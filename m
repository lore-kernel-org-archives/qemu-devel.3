Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A35CC61DFD
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 19:00:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x17EV-0001PS-LG; Mon, 31 Aug 2026 14:59:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tgamblin@baylibre.com>)
 id 1x17ET-0001Ob-Fp
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 14:59:49 -0400
Received: from mail-qv1-xf32.google.com ([2607:f8b0:4864:20::f32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tgamblin@baylibre.com>)
 id 1x17EQ-0000B0-Mj
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 14:59:49 -0400
Received: by mail-qv1-xf32.google.com with SMTP id
 6a1803df08f44-90cdebdfe63so419776d6.3
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 11:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1788202785; x=1788807585; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9ZzUZ9M0dAHPjqS+kpTChb3yfXAJvWD9K5TPUlBVbHI=;
 b=MWVuncmm37LZBnYbsRRuDbxr2oILKsF/vO4iFkihXb/WhC2fsbI+IDUhs9RKGz1R0j
 jfn5N7HF+SrEPXOFt+decuJFgc2gqMymTKuZTw96Y/reDHR5uycsBKksW5uOvFQLmKpU
 jsU5yf0QHC3v6XjTBhYHfcS5uNYZCcwlDOMRsCb2A7bDgpyLkrvJQzTgXlRbossdx2E0
 N0mAJotl9FDBgeqVPHhTxJ0TWKhph6WD7up23DW9wVcxQUPlMHcfXLLUlsrIxzQQktKI
 L0xHMHOd+Y1iEHojqdrBKPWH2Vi5fINm+Ngte9fmBxph9h/nfhk1velaT3zxVTh7t6Ex
 pFYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788202785; x=1788807585;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=9ZzUZ9M0dAHPjqS+kpTChb3yfXAJvWD9K5TPUlBVbHI=;
 b=McoxU6IVyqZXjjmFV3Nl8KucM/xZSd6nlDakUl34jlu37h7cN9QojkNKlM16Ih/GeN
 JKNLn2urewVboDcgXu8Z27qy3UlZbF0YWweMYsciomrvEh8prYRRw0D9rXY+SV7pbIrz
 MeRP9jM28G/g/PAmAnU2NkkzsC49hapFkJVnuCcZuW9FPcpFJDY4NiqLERUgEHOJX/CZ
 BAWHbdhVa9EmVubJEIbpTxukvJOlzSaVv/hKMgvX7VgUz17tU4aQp7nGVYuhbyGBfkNv
 17fHenB7jxin9fWzfnGvPjvc3BNG5f2EJLGhyFk2YJLRaz6wG75qVXVq0irweZ6JM5S7
 d0Aw==
X-Gm-Message-State: AFuF++kUFLbHfqRXjIVijrO0xJNoQ/CywUHz1kmB/E0yRgg+ET1Chnuw
 M5gJugcUGRSORlUSnNPKwd/lVHHNbJcrAtVyckOSxHNPoX0PV6r6yCFfwIpu/6kyZig=
X-Gm-Gg: AYBFou08ShJG4FcypTjeGimosYr5qf90MYeO201YooEAp/RJH5spW7TGv8VdaKWPGco
 QeTGz2TB48IwaNrX0+O8e42nsLt3xKuXOR+KGFA8n8B/CT5q0Rr3l/cMjFSaDPxGxvuVpX49CGT
 JHnSboI/rlAII+aFCV5qC3jH/E1gUCfyxTVuZFvOkPtf0fJhkhhvwpTlOqRfHTpgrgE9PHg4S5R
 SLw7qlAZG6GZIyITYqe7FyrKELkYpovj2TSYLpidVgUIoevQoWkpVVVEWeOq42aWXqWTa5zU9Yk
 2HtcUkDMmmPSBWFyX8AY2gtGo4BFxvxizIay6n3zrY6Ib3y8/St+e0OubQ8pq8Z7r00hjNCTemZ
 EtALDwNnxO5zpEnU6fatwYU3vaDL49WhNpuqbajD9f6OFiSP0tRpisDxOrV1QXG6ioH49pZGwl8
 l98XAIq6dxxNleCpnUdmYiBcYbCVIZVnWt5+YJwqeW2tOs6Q0Wth4NvneFQ7Uktf/elJsGVqm1
X-Received: by 2002:ad4:594f:0:b0:90e:8022:b673 with SMTP id
 6a1803df08f44-90e8022b6d5mr173787566d6.9.1788202785311; 
 Mon, 31 Aug 2026 11:59:45 -0700 (PDT)
Received: from [192.168.40.230] ([2001:1970:3847:e000:1977:be2f:4a71:2892])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-90ce44f5695sm90952986d6.26.2026.08.31.11.59.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2026 11:59:44 -0700 (PDT)
From: Trevor Gamblin <tgamblin@baylibre.com>
Date: Mon, 31 Aug 2026 14:59:39 -0400
Subject: [PATCH 1/3] target/riscv: extract sfence_vma_allowed() from
 helper_tlb_flush()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260831-riscv_tlb_page_flush-v1-1-4fc6af95673a@baylibre.com>
References: <20260831-riscv_tlb_page_flush-v1-0-4fc6af95673a@baylibre.com>
In-Reply-To: <20260831-riscv_tlb_page_flush-v1-0-4fc6af95673a@baylibre.com>
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu@processmission.com>, qemu-riscv@nongnu.org, 
 Trevor Gamblin <tgamblin@baylibre.com>
X-Mailer: b4 0.16.0
Received-SPF: pass client-ip=2607:f8b0:4864:20::f32;
 envelope-from=tgamblin@baylibre.com; helo=mail-qv1-xf32.google.com
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
argument directly to it inside the helper_tlb_flush() function.

Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
---
 target/riscv/tcg/op_helper.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/target/riscv/tcg/op_helper.c b/target/riscv/tcg/op_helper.c
index 3e94005d2b..8039df2b48 100644
--- a/target/riscv/tcg/op_helper.c
+++ b/target/riscv/tcg/op_helper.c
@@ -588,18 +588,25 @@ void helper_wrs_nto(CPURISCVState *env)
     }
 }
 
-void helper_tlb_flush(CPURISCVState *env)
+static bool sfence_vma_allowed(CPURISCVState *env, uintptr_t ra)
 {
-    CPUState *cs = env_cpu(env);
     if (!env->virt_enabled &&
         (env->priv == PRV_U ||
          (env->priv == PRV_S && get_field(env->mstatus, MSTATUS_TVM)))) {
-        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, ra);
+        return false;
     } else if (env->virt_enabled &&
                (env->priv == PRV_U || get_field(env->hstatus, HSTATUS_VTVM))) {
-        riscv_raise_exception(env, RISCV_EXCP_VIRT_INSTRUCTION_FAULT, GETPC());
-    } else {
-        tlb_flush(cs);
+        riscv_raise_exception(env, RISCV_EXCP_VIRT_INSTRUCTION_FAULT, ra);
+        return false;
+    }
+    return true;
+}
+
+void helper_tlb_flush(CPURISCVState *env)
+{
+    if (sfence_vma_allowed(env, GETPC())) {
+        tlb_flush(env_cpu(env));
     }
 }
 

-- 
2.55.0


