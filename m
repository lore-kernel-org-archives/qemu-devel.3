Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15917C369D5
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 22:44:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8RBO-00053v-8D; Fri, 25 Apr 2025 18:06:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8RAv-0003ha-Su
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 18:05:43 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8RAs-0001rG-QH
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 18:05:37 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-7369ce5d323so2262772b3a.1
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 15:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745618732; x=1746223532; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9kr5nd/ZituzS7N6ANSAziki2MVGNQqIZBqxjrspSXs=;
 b=u+R5yzK12kYWjdTK6pBKcmNXA94m06aFnJs+WCbPYrucdzgTjsOsawMX9qVlsQlpCw
 lTLWsbQ5M70TOCkN4Mi90gRPh0VBVQg1vwooyd7whW2HawcF6MW68rKYfuZEAgjVaATB
 HqA8n5MXd9rQ7rS/cwL3UTgTOr18k40SU05FRi9/7sSfa85/FGUUTDkjth4u9D7+RPVf
 MBnncS1HdYIvYwDdLqSZ1eyn6g78ePMw8IyVI4+4agTk5cBYva5Z3MTbkakpYtGIPMqe
 6Xb/qFvdhL/G0gL/ixs86rhJetbNHI9wZzIDHGmg66PrkWJnNsBYDDYz2aaL2UVyrhRe
 fIng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745618732; x=1746223532;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9kr5nd/ZituzS7N6ANSAziki2MVGNQqIZBqxjrspSXs=;
 b=qIXcI0dQZb/Mcu+Gk0uPLXILgtgtDwkOiEpSSnFefQ8DuelSHRLseWbeYtqtBU34ZZ
 EQOFMkQ+4Eqp0cHF2i8Ysf5Ap/paKvu8RoG8LJ46XP86MMbEcQlH/WiWSKVIOxT0+8ud
 wRN66oifEdlJK5HdqQnu0HwghYiMFFkoo9L2IJGhBVNleV1OG5hvU4jB99h+vk5cyNUF
 k9JhRGUkHinY+/AW77ux9xtx8e1Csm8YoH/0h1zug+K0M9YVGIujfKPdsH8gSR1FlUKD
 HLy5AGG8GRB6xIEqGocNL10v/5QFbt19Aw+b/5rSMoQZyugichhZy1qxI8R6525xNNjw
 8sVA==
X-Gm-Message-State: AOJu0YxmeX40Eo2B6CTmIAZdtbC8iB/n91+3RvnMkMbArjswinXXeEAu
 U1Iym3MjgNmZIJeBanawqga9r+y8iyUhnB+HbqrryXREmJYLuIqhiPaal+q05kQIk6XUwcMiZ74
 t
X-Gm-Gg: ASbGncuzvsfSzggV3aCGRtoubjxJdG9bnKv0CPpjbCKIaqFAZzv6w8qlzwYvUmMrNso
 zdocWTAx1UOJpV3jOpeOosn42RSPY+lvFjGgH5qHH2nj0LhuvaHivMZ2hDHEAI8ESXifoW/2mjj
 hixz1FUPRfvhAtYGkjJRb41BlMHCzn6jcbjmN5oyGt2ymUkfO1MXCQVi0WsTYGfZHZ4VOVM3J8A
 YPKQzcdSFJxKYPI3G1Id84r5wTpa1Ie8NqmnA4P3KGx5CJbTuc5t1Qf47FK+R6dHG9+uDapMes9
 b4/tVuGGm9oj7zJ65Y0VFW8yalZZQMVRmSWp145Iv7tgnigh7BshhO4UKiLfQltB2ZMsEpALmu8
 =
X-Google-Smtp-Source: AGHT+IEoRhZitMLVBfj6Mr1p1MnCYd2uqSbZjLl9vNzV3D5Gj8/iqoKXvHERtPLvZsli8Jz3U6cG9w==
X-Received: by 2002:a05:6a00:130a:b0:736:32d2:aa93 with SMTP id
 d2e1a72fcca58-73fd8f4d3famr5257356b3a.20.1745618732309; 
 Fri, 25 Apr 2025 15:05:32 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e25a6a49esm3796573b3a.106.2025.04.25.15.05.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Apr 2025 15:05:32 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 131/159] target/ppc: Use tcg_gen_addcio_tl for ADD and SUBF
Date: Fri, 25 Apr 2025 14:54:25 -0700
Message-ID: <20250425215454.886111-132-richard.henderson@linaro.org>
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

Tested-by: Nicholas Piggin <npiggin@gmail.com>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/ppc/translate.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index fea2f2ce23..62dd008e36 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -1746,11 +1746,10 @@ static inline void gen_op_arith_add(DisasContext *ctx, TCGv ret, TCGv arg1,
                 tcg_gen_mov_tl(ca32, ca);
             }
         } else {
-            TCGv zero = tcg_constant_tl(0);
             if (add_ca) {
-                tcg_gen_add2_tl(t0, ca, arg1, zero, ca, zero);
-                tcg_gen_add2_tl(t0, ca, t0, ca, arg2, zero);
+                tcg_gen_addcio_tl(t0, ca, arg1, arg2, ca);
             } else {
+                TCGv zero = tcg_constant_tl(0);
                 tcg_gen_add2_tl(t0, ca, arg1, zero, arg2, zero);
             }
             gen_op_arith_compute_ca32(ctx, t0, arg1, arg2, ca32, 0);
@@ -1949,11 +1948,9 @@ static inline void gen_op_arith_subf(DisasContext *ctx, TCGv ret, TCGv arg1,
                 tcg_gen_mov_tl(cpu_ca32, cpu_ca);
             }
         } else if (add_ca) {
-            TCGv zero, inv1 = tcg_temp_new();
+            TCGv inv1 = tcg_temp_new();
             tcg_gen_not_tl(inv1, arg1);
-            zero = tcg_constant_tl(0);
-            tcg_gen_add2_tl(t0, cpu_ca, arg2, zero, cpu_ca, zero);
-            tcg_gen_add2_tl(t0, cpu_ca, t0, cpu_ca, inv1, zero);
+            tcg_gen_addcio_tl(t0, cpu_ca, arg2, inv1, cpu_ca);
             gen_op_arith_compute_ca32(ctx, t0, inv1, arg2, cpu_ca32, 0);
         } else {
             tcg_gen_setcond_tl(TCG_COND_GEU, cpu_ca, arg2, arg1);
-- 
2.43.0


