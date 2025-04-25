Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E559C369D1
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 22:09:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8RBQ-0005DK-CZ; Fri, 25 Apr 2025 18:06:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8RAr-0003g3-D4
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 18:05:39 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8RAo-0001qI-VO
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 18:05:32 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-73bf5aa95e7so2510583b3a.1
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 15:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745618729; x=1746223529; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Na9RncWEJT5Gatn3V0Wp9/9d/jLQqyi+KtKWrjpgaV4=;
 b=qGzsfA72RXt7RljW1zax8Mf+tw9Kt17Iej8ixKKSrdfs+FR9T7k7CKx5OKfj9k0XIr
 3ymyXWyZ+iNEDMWHmHjg/Iktd5l5EhpAnTislByErsFjC5wft7idYqNqOCGTxfBEtdNf
 8EuICc9Inlp1o53V6DTu/NrRQNZETBQHabvFDLP6GWwunFGKuEEW6Xt7vAGewJy1MqHr
 2U//mahDEhoVwxKmKovO4FH2oLTME6auTt58ub3W9E9GnY6V+5QG0a0tNYTSakqu/era
 JMiKR8+2x1eznixRyTxV8sjlv/7ASO2HNYrKYWYSwyl7+TsB8/IwiaUCCXfzHHPUKujY
 NhFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745618729; x=1746223529;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Na9RncWEJT5Gatn3V0Wp9/9d/jLQqyi+KtKWrjpgaV4=;
 b=vdhS9GNARbacvGXlqIu4VGB+KPTyJsByUW8CwhXN+7lL4D1UI/3v8HegkUuPCUOWzY
 FGGHyQ1TO6Ny/krIGInqPcQRqx0m3LFAVPGsIUAnz2sm95Q8E7SxVINhFlrt4rqEEJge
 3ex3qIGzvKEZ6Ntr32PWHW5IWI9zkM8sCaiJwBgZuonD3T5PW3Mnru5bcxn3ZNkMbUK/
 P//nyUJmzVwHsQa36pOZwZNmDswkWHia4rurj+gtctuHZre67rROFBwE/8VdNyyaIDta
 c5UPM5/fjOSgtvOTrp3PI6d7/3XcTQrm0FoD0q9/DQkkS6Ar1qRU3OXRDWEiN+QL/shG
 PUcQ==
X-Gm-Message-State: AOJu0YzCE1h9eIJTPECYtOBHZgHc3NKKehigWfTzdHm3oo6e0xtZ27Hs
 y+tZHrF6JecoPoFvsyBOovtzeGueBRfWY1JwrVLjTwK+3THULtTePL3oBNlG5G2wJofD9TxPTek
 Y
X-Gm-Gg: ASbGncuxxQC5yv7OocWPfOMTokR+WCvcJra6YQC31l0s/ePYiqb6e4JvjAQttyBk5lj
 Nt60BlSK0JrYg/7XXP9ABp7UFVjYDvCeBunr3C9b+34/G+bL/RVduqBLUOoMlIz+1tDV5cOy9aW
 g4CPV+YqEB90W9H4D2EM0fjHd7AG1o34zymlXdmGw3jQdswfgsWtQy30PaAYmGeAsxRahYtwo0g
 kTCcu7HCYZ/+lxBGCpS6o/iWrYgh72GKAyhkdCFuG/JN50DAX+aQAcy+Jqm09GldM/KseMMiYNe
 12SHtbed/eorGTD86rMjP5yMNFPe3VnJUp00tjbfq0VJq0kmwl2cr60+UP3aG/R6f26YVMULKao
 niJQ7tgBX/w==
X-Google-Smtp-Source: AGHT+IEqmFngR3wmigbvzRl5760WofwBme0A8N05jmSBkvpd4demPszPOb9QBjjmlepqKGWZbf9kjw==
X-Received: by 2002:a05:6a00:3a97:b0:73f:f816:dd7f with SMTP id
 d2e1a72fcca58-73ff816df8cmr666447b3a.15.1745618729320; 
 Fri, 25 Apr 2025 15:05:29 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e25a6a49esm3796573b3a.106.2025.04.25.15.05.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Apr 2025 15:05:29 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 127/159] target/arm: Use tcg_gen_addcio_* for ADCS
Date: Fri, 25 Apr 2025 14:54:21 -0700
Message-ID: <20250425215454.886111-128-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250425215454.886111-1-richard.henderson@linaro.org>
References: <20250425215454.886111-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c |  8 ++------
 target/arm/tcg/translate.c     | 17 +++--------------
 2 files changed, 5 insertions(+), 20 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index e076d4aa05..d9305f9d26 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -1076,11 +1076,9 @@ static void gen_adc_CC(int sf, TCGv_i64 dest, TCGv_i64 t0, TCGv_i64 t1)
         TCGv_i64 cf_64 = tcg_temp_new_i64();
         TCGv_i64 vf_64 = tcg_temp_new_i64();
         TCGv_i64 tmp = tcg_temp_new_i64();
-        TCGv_i64 zero = tcg_constant_i64(0);
 
         tcg_gen_extu_i32_i64(cf_64, cpu_CF);
-        tcg_gen_add2_i64(result, cf_64, t0, zero, cf_64, zero);
-        tcg_gen_add2_i64(result, cf_64, result, cf_64, t1, zero);
+        tcg_gen_addcio_i64(result, cf_64, t0, t1, cf_64);
         tcg_gen_extrl_i64_i32(cpu_CF, cf_64);
         gen_set_NZ64(result);
 
@@ -1094,12 +1092,10 @@ static void gen_adc_CC(int sf, TCGv_i64 dest, TCGv_i64 t0, TCGv_i64 t1)
         TCGv_i32 t0_32 = tcg_temp_new_i32();
         TCGv_i32 t1_32 = tcg_temp_new_i32();
         TCGv_i32 tmp = tcg_temp_new_i32();
-        TCGv_i32 zero = tcg_constant_i32(0);
 
         tcg_gen_extrl_i64_i32(t0_32, t0);
         tcg_gen_extrl_i64_i32(t1_32, t1);
-        tcg_gen_add2_i32(cpu_NF, cpu_CF, t0_32, zero, cpu_CF, zero);
-        tcg_gen_add2_i32(cpu_NF, cpu_CF, cpu_NF, cpu_CF, t1_32, zero);
+        tcg_gen_addcio_i32(cpu_NF, cpu_CF, t0_32, t1_32, cpu_CF);
 
         tcg_gen_mov_i32(cpu_ZF, cpu_NF);
         tcg_gen_xor_i32(cpu_VF, cpu_NF, t0_32);
diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index 273b860d57..88df9c482a 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -494,20 +494,9 @@ static void gen_add_CC(TCGv_i32 dest, TCGv_i32 t0, TCGv_i32 t1)
 static void gen_adc_CC(TCGv_i32 dest, TCGv_i32 t0, TCGv_i32 t1)
 {
     TCGv_i32 tmp = tcg_temp_new_i32();
-    if (tcg_op_supported(INDEX_op_add2_i32, TCG_TYPE_I32, 0)) {
-        tcg_gen_movi_i32(tmp, 0);
-        tcg_gen_add2_i32(cpu_NF, cpu_CF, t0, tmp, cpu_CF, tmp);
-        tcg_gen_add2_i32(cpu_NF, cpu_CF, cpu_NF, cpu_CF, t1, tmp);
-    } else {
-        TCGv_i64 q0 = tcg_temp_new_i64();
-        TCGv_i64 q1 = tcg_temp_new_i64();
-        tcg_gen_extu_i32_i64(q0, t0);
-        tcg_gen_extu_i32_i64(q1, t1);
-        tcg_gen_add_i64(q0, q0, q1);
-        tcg_gen_extu_i32_i64(q1, cpu_CF);
-        tcg_gen_add_i64(q0, q0, q1);
-        tcg_gen_extr_i64_i32(cpu_NF, cpu_CF, q0);
-    }
+
+    tcg_gen_addcio_i32(cpu_NF, cpu_CF, t0, t1, cpu_CF);
+
     tcg_gen_mov_i32(cpu_ZF, cpu_NF);
     tcg_gen_xor_i32(cpu_VF, cpu_NF, t0);
     tcg_gen_xor_i32(tmp, t0, t1);
-- 
2.43.0


