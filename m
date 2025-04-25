Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65B52C369D5
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 22:20:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8RDn-0001ax-IL; Fri, 25 Apr 2025 18:08:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8RAw-0003hh-OT
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 18:05:43 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8RAu-0001ro-8N
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 18:05:37 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-736ad42dfd6so2479663b3a.3
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 15:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745618735; x=1746223535; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UfCXyMfYb5vmx7EvcmnCYyPIyUrqyZ3ULXyLLGKTMRU=;
 b=s0b/k6bqEg513bUBH+oT5xSa3tzJqPVvpneNuNCHaOeS4l3WWwJYgGv2UFJK88+aAf
 P+SbZaNl9tDqMVk8HCV3L2uAnQeLLPbWkW56N7/bghaDZC76Yrz6lWrH8RZH0cxoUbk1
 5hWATCiu8bdBF55H9zD7D1E0QUBuCnM7QUoqXbZuFdv1PCfBEjgIy9aKj7sfm6222BxO
 nP0SPIZDCevQVEgYmMUKBFe1IapvrWgbbo3/+iEapfqzZeC4+BpMDQryeP1FGbRRl5u3
 1USw+LwhIBU0aL5K1NO1rDOIZoJfop2kZzno+zS+CiKkeByB7+n4KB09uqdkHaRR5u9T
 5L+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745618735; x=1746223535;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UfCXyMfYb5vmx7EvcmnCYyPIyUrqyZ3ULXyLLGKTMRU=;
 b=dniPVO2rzdiq32BTwFNhnnxK6EHCpaZAMm1s6GSSBitmFBP/7ZzlOu0zShAtGpI2Ji
 qar9JaQEkcJ4sgs50hAJayHbBbppIcf44q5RhY0aQ+CWjYXr/I5LwpSHAU6W+uFKK8GE
 Wqe5g2/F7PT+rTiO8yExQwa6gP0Z1L0UeRHGomXF8TVRTkbsgR8UEGmWE94OUs5zF3uc
 hQBuxa8Enf7aO2pjLsAR4CKAr3qmrIxclux8wvYT/NboRf1gh4svDE9LrKN+8FGCiJvS
 89m10gUjDT9ZEMKEHxxKCUsV1cau2dT8+NM4qFsxeDF5t94+Y3XPq4enCQpmDgHA0Pek
 RaJQ==
X-Gm-Message-State: AOJu0Yzjr/03CNiTj6K7Hnns6KDlY1/whYewsLVtw9ye0yS0tXCOrUEw
 mJXGO8wxbGY4FLd8r6QoXw1Ka5vQx4nSA3Scyh4tS8s7zkgGek2KBYEAwnaEX6w2R6lfNXEgGyz
 n
X-Gm-Gg: ASbGncvSqbsfSkhJ1FsQ//rvOyNz7W9XJUzdrzDd3fTGzUQNnn0wuMyswwKKMD5FqT7
 F+seDtj70DAYuPS9RtpIx1LFBW3bLR7z4goeaUtqRUdJkmgMwy9pDoTP35ESGfPu6vjuD7fAcs0
 +Rl90x5LxZesPWZRlLYE7z5X8qJXS7JqgRpzXfjg9Vi8/oqr00pd3RvERD1LRFZOjqKWqmetpxo
 J+frFjJyj95z4/V4yw3NMRUBRLWrfG3DLCkS5tk4LpMnH7jpZyBCSmpih/SkAmhd0GbdBiFFpaq
 zRYOe5ttxrul3A6yF+JX5atze3ueCCiCxg+weUqU+nnlccD9mlu/pwXhrpbr1nzLKaw99mnNQJA
 =
X-Google-Smtp-Source: AGHT+IF7nIZV3YAkViwrkRGO+ajeUghyyJKPeQCvBYUMs/RrzYzrJ4cx9T+OYSf/+vEJ1Ow7AtAjew==
X-Received: by 2002:a05:6a00:b4c:b0:736:34ff:be7 with SMTP id
 d2e1a72fcca58-73fd8b6bd7dmr4621554b3a.15.1745618734939; 
 Fri, 25 Apr 2025 15:05:34 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e25a6a49esm3796573b3a.106.2025.04.25.15.05.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Apr 2025 15:05:34 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 135/159] target/tricore: Use tcg_gen_addcio_i32 for gen_addc_CC
Date: Fri, 25 Apr 2025 14:54:29 -0700
Message-ID: <20250425215454.886111-136-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250425215454.886111-1-richard.henderson@linaro.org>
References: <20250425215454.886111-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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
 target/tricore/translate.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/target/tricore/translate.c b/target/tricore/translate.c
index ede0c92c1e..ba36c9fcc8 100644
--- a/target/tricore/translate.c
+++ b/target/tricore/translate.c
@@ -1346,15 +1346,11 @@ static inline void gen_addi_CC(TCGv ret, TCGv r1, int32_t con)
 
 static inline void gen_addc_CC(TCGv ret, TCGv r1, TCGv r2)
 {
-    TCGv carry = tcg_temp_new_i32();
-    TCGv t0    = tcg_temp_new_i32();
+    TCGv t0     = tcg_temp_new_i32();
     TCGv result = tcg_temp_new_i32();
 
-    tcg_gen_movi_tl(t0, 0);
-    tcg_gen_setcondi_tl(TCG_COND_NE, carry, cpu_PSW_C, 0);
     /* Addition, carry and set C/V/SV bits */
-    tcg_gen_add2_i32(result, cpu_PSW_C, r1, t0, carry, t0);
-    tcg_gen_add2_i32(result, cpu_PSW_C, result, cpu_PSW_C, r2, t0);
+    tcg_gen_addcio_i32(result, cpu_PSW_C, r1, r2, cpu_PSW_C);
     /* calc V bit */
     tcg_gen_xor_tl(cpu_PSW_V, result, r1);
     tcg_gen_xor_tl(t0, r1, r2);
-- 
2.43.0


