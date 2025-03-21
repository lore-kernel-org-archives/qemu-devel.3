Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 166DAC36005
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Mar 2025 18:16:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvgui-000876-Ng; Fri, 21 Mar 2025 14:16:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tvguY-000862-4S
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 14:16:02 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tvguW-0008BP-4x
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 14:16:01 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43d07ca6a80so11328885e9.1
 for <qemu-devel@nongnu.org>; Fri, 21 Mar 2025 11:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742580957; x=1743185757; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hDYLQeEzwKvti/AAv4oJ1/mMbnXRlKRnnyKbgiaN8yY=;
 b=ybM/cJ8/cw7Ne4aDiO/LdR+6sbSKxcAJXOxyO7UUiz8OIs6G46AQIbasl7pvF/uzJn
 Eo3EdcbA6wBQXm9/t89iV8Xkls17INsHUT29P+4NDu9pMhWUbTZTgpNannF3oPVGX8G+
 icdZXMo278BnURMbEDLRbBO5UOvhByxDQQlkOKyKWERjEYzMsuECQzi7kkpvBOmnbIP3
 +69FfD9j/Zfweq9fwvU3vmOK2D0TnlCHAdSEoHbJ53sdMHULWpqyt1lfYvQxqi3nFRt2
 kueXY4J4wRC8Bpj2R48c6qwvTV+1YSJ7MjPIqNz0qv1GlWZQwCyT3Y17sn5zsYhF5XqC
 641w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742580957; x=1743185757;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hDYLQeEzwKvti/AAv4oJ1/mMbnXRlKRnnyKbgiaN8yY=;
 b=LZ5tVa/Sh3mbhirZD+nC6jyANPpDfnkyfir/hMImPXCN/PNA8kbERQZGR1xDDVwmpg
 RvErMW+hfwOwcUczgYobgWjM1amD63TwNt1lbCjn+M7exlPc+5zZhJM3RDz/mB++xxnV
 VrFW7b6+UysB/DDQinvAOqDmJ7FwKa71N6jwr39lR7JjajbPwspG+TTmU1EsKkew3KPJ
 4fzw89GtlXG9UqOaAVJPeb9pP5QaBmOR2sS1Flg5ok3wBLWwH3JL/RF6dILTFfTFEyYy
 6bg1hYNBKiu2py3/U+cjt3sjJVwBN4ctOaol0RMSMC52YAXNveYmeKjtDk/i4Eb1/A5C
 HIpA==
X-Gm-Message-State: AOJu0YznNYjx6BTMLWjlCy6CcqdV5VUSlWDlBuUNggOeunFwGj5f0A7T
 /iXCCNBimATzv0gC4wezQWtjT1EQBTR60fxcaw9LHvxWYEh41UeYhJnj0zUVB7cMtdNWA61uQ7K
 u
X-Gm-Gg: ASbGncvGmOkO3qftRr2xcolszINZ8GU2WR6CX42LjtlOgiOwuCjBy7Vo0p7VsD+7zBq
 Q+RZW2qp/hdClEM1H/beS8D2w6a6xszbWl57BNxf6mSzVIDIqF0NWo0tqq5XOI7sEB6BdRvddaL
 udy70yJuhrpHZJX1QX2lbIwAy8cY/aMppvCl9V2MRijtnFIz5rkWKHgpxQLZRyJnNegIcJ8UcnI
 9lBz4fLL026V2t7CQpCDbxAj4rIg4CaGLIIszu8u8QMMqWvOntmSsU7BKN92eqBYc/ACnYZxgmg
 V4GewdkwLEppMGRaHv1sg2z3zr4jSdZymrKtxd8RAxxY2UiiBUZxyiPLiKJQeqmX1xF1RWk/Aux
 G5XqbeNEuopzm/c0Vssw=
X-Google-Smtp-Source: AGHT+IE47HtKiaoYpWKT3wwixHDdaoB3pjhiZhg4zFey8S0/ytP6D/1tKWYdwzYPdDcq2KgS/3KL+A==
X-Received: by 2002:a05:6000:2b10:b0:391:401f:bfd8 with SMTP id
 ffacd0b85a97d-3997f939a54mr3319477f8f.55.1742580957278; 
 Fri, 21 Mar 2025 11:15:57 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3997f9e65besm3004863f8f.65.2025.03.21.11.15.56
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 21 Mar 2025 11:15:56 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.1 v2 1/7] tcg: Always define TCG_GUEST_DEFAULT_MO
Date: Fri, 21 Mar 2025 19:15:43 +0100
Message-ID: <20250321181549.3331-2-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250321181549.3331-1-philmd@linaro.org>
References: <20250321181549.3331-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

We only require the TCG_GUEST_DEFAULT_MO for MTTCG-enabled
frontends, otherwise we use a default value of TCG_MO_ALL.

In order to simplify, require the definition for all targets,
defining it for hexagon, m68k, rx, sh4 and tricore.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/hexagon/cpu-param.h | 3 +++
 target/m68k/cpu-param.h    | 3 +++
 target/rx/cpu-param.h      | 3 +++
 target/sh4/cpu-param.h     | 3 +++
 target/tricore/cpu-param.h | 3 +++
 accel/tcg/translate-all.c  | 4 ----
 6 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/target/hexagon/cpu-param.h b/target/hexagon/cpu-param.h
index 45ee7b46409..2d57ea6caf9 100644
--- a/target/hexagon/cpu-param.h
+++ b/target/hexagon/cpu-param.h
@@ -23,4 +23,7 @@
 #define TARGET_PHYS_ADDR_SPACE_BITS 36
 #define TARGET_VIRT_ADDR_SPACE_BITS 32
 
+/* MTTCG not yet supported: require strict ordering */
+#define TCG_GUEST_DEFAULT_MO        TCG_MO_ALL
+
 #endif
diff --git a/target/m68k/cpu-param.h b/target/m68k/cpu-param.h
index 7afbf6d302d..1a909eaa13e 100644
--- a/target/m68k/cpu-param.h
+++ b/target/m68k/cpu-param.h
@@ -17,4 +17,7 @@
 #define TARGET_PHYS_ADDR_SPACE_BITS 32
 #define TARGET_VIRT_ADDR_SPACE_BITS 32
 
+/* MTTCG not yet supported: require strict ordering */
+#define TCG_GUEST_DEFAULT_MO        TCG_MO_ALL
+
 #endif
diff --git a/target/rx/cpu-param.h b/target/rx/cpu-param.h
index ef1970a09e9..2ce199164d7 100644
--- a/target/rx/cpu-param.h
+++ b/target/rx/cpu-param.h
@@ -24,4 +24,7 @@
 #define TARGET_PHYS_ADDR_SPACE_BITS 32
 #define TARGET_VIRT_ADDR_SPACE_BITS 32
 
+/* MTTCG not yet supported: require strict ordering */
+#define TCG_GUEST_DEFAULT_MO        TCG_MO_ALL
+
 #endif
diff --git a/target/sh4/cpu-param.h b/target/sh4/cpu-param.h
index 2b6e11dd0ac..1bc90d4695e 100644
--- a/target/sh4/cpu-param.h
+++ b/target/sh4/cpu-param.h
@@ -16,4 +16,7 @@
 # define TARGET_VIRT_ADDR_SPACE_BITS 32
 #endif
 
+/* MTTCG not yet supported: require strict ordering */
+#define TCG_GUEST_DEFAULT_MO        TCG_MO_ALL
+
 #endif
diff --git a/target/tricore/cpu-param.h b/target/tricore/cpu-param.h
index 790242ef3d2..923459370cc 100644
--- a/target/tricore/cpu-param.h
+++ b/target/tricore/cpu-param.h
@@ -12,4 +12,7 @@
 #define TARGET_PHYS_ADDR_SPACE_BITS 32
 #define TARGET_VIRT_ADDR_SPACE_BITS 32
 
+/* MTTCG not yet supported: require strict ordering */
+#define TCG_GUEST_DEFAULT_MO        TCG_MO_ALL
+
 #endif
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 82bc16bd535..fb9f83dbba3 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -349,11 +349,7 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
     tcg_ctx->tlb_dyn_max_bits = CPU_TLB_DYN_MAX_BITS;
 #endif
     tcg_ctx->insn_start_words = TARGET_INSN_START_WORDS;
-#ifdef TCG_GUEST_DEFAULT_MO
     tcg_ctx->guest_mo = TCG_GUEST_DEFAULT_MO;
-#else
-    tcg_ctx->guest_mo = TCG_MO_ALL;
-#endif
 
  restart_translate:
     trace_translate_block(tb, pc, tb->tc.ptr);
-- 
2.47.1


