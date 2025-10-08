Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35A81CCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 22:13:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6cDo-0001SD-Cn; Wed, 08 Oct 2025 18:01:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6cD7-0001Bn-RZ
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 18:00:38 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6cCV-0007Oh-JL
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 18:00:37 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-78115430134so215778b3a.1
 for <qemu-devel@nongnu.org>; Wed, 08 Oct 2025 14:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759960791; x=1760565591; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G43r76XjcTrZ8ZUDbYbNqED2qlMoNKLkIEDOEdGlVs0=;
 b=mAXFkfEoelfwuQbHhz21pvarjvvYD9GUHDCoKrCy0WdwFSp1A97Yt8at8Lm0LU7DnP
 W1lGGDcWqWTuc9MOdsGxBGFgMGDLgXre+tAvSuZAck4LqnJgTlII+70tPFFikqzp1T7m
 tObg/sUo7iRNofIIW8sg11nW/iCrS6SVYXVcBMhAa+Jpa3UoY48OMFi+UBSeeYoRELMm
 ht2I37NIElcesV6iN7WIsH88vzflCJA2x2JG9MEbPVjoX4jEzdzugIxv+BEm7drW5rga
 /n1GIPnhLCgLiHd+jWcJ8t6Q8ZTPk7D0fDLqqbrcs621icHfDdwAm74mzSCzp5+5hU1r
 aprQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759960791; x=1760565591;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=G43r76XjcTrZ8ZUDbYbNqED2qlMoNKLkIEDOEdGlVs0=;
 b=BdPzK4CASqE1lEP+rXyk5nHuJjxTk3/mLiI8HkedXkdj0L4N2I4zDCZu+LjoZVyWIL
 SMQz3hM+EVJKREiUwqscmZt8QdLh70CSa4ju5woBly4GuqYqWJvoVZ/E5nimhDvGeLwK
 vytluP1ac3gMFUZOvecDusqJBTDav89hFmhJqQ580XqvWl6DxA9ddOsRtyHxMoGlMyu9
 yJNlGM1qKBMScXxWwSwC8r13ovYnFWcg4hihh0c51e070GT0Pmbt1zvrQENUtShRlT6d
 CT/T0XNFFmP3y+3tZ30pHcYWYPWQ9JB5K2eAI/JgZXQxwj7qxNkirdUk2BK/weM2qIRQ
 0wCw==
X-Gm-Message-State: AOJu0YzRANtS41eywQzrzxBsIpcsObg2zkKXm/EAfcDSwgv7apCZV2GA
 c38GQd9rBU2YtnWC4fa7r8r558KhzL22RqL6OYjrC5rFuvnQYHojW6G83kOnsrohOqzEd43ScrE
 eObDzHwI=
X-Gm-Gg: ASbGncsN+RYK+bK+XXFfGDOLYpsYzbkVfHwHWVIm9JKcXf6fH5oxDYzM64pd8EMe/Nb
 7NUubK6ui+0YVZUxgR51TTXLKTeX4qWBty2kfxefRDarF3HAHopQ4aId8GV0cdxaQapMHd2SLpB
 QgcWNSSiZJGS2CLrZwd7V9TxLGo9/PIy7p2bIkFtNSeiEBLRacQVNi0XE82MJvRAAV8xTv9IccU
 5Bvw2QmDcRJA2zEEhV0SdEebzhkBHTcL24B29EZ4hFWzeGB8GnqA0MfdP/8+Q6UrfzSI+3XARon
 aPBOJ8Wv4mNpC5AQMLWs0elLNyYdiL5KAy/5W50bHLDKM6IbU1eba6ULDjU46haeBFytMsw25IX
 N0JC5LP1sJFkBXJpxjG1GKYvk3JvBxI3Xk6mVrh6bVeQAMQt8v3Jpnzuo
X-Google-Smtp-Source: AGHT+IGRK5MWEBopV4BLlRi159BedB0VPExsDn7kscupooFImhcLuocF67oYIfq2FeMr16DwMb/j8w==
X-Received: by 2002:a05:6a20:72a2:b0:32b:6e33:7cf8 with SMTP id
 adf61e73a8af0-32da83e0614mr6924503637.42.1759960791256; 
 Wed, 08 Oct 2025 14:59:51 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-794e1fc9db6sm740724b3a.66.2025.10.08.14.59.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Oct 2025 14:59:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v7 56/73] target/arm: Add gcs record for BLR
Date: Wed,  8 Oct 2025 14:55:56 -0700
Message-ID: <20251008215613.300150-57-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251008215613.300150-1-richard.henderson@linaro.org>
References: <20251008215613.300150-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 9a564339fa..fcfa4223f5 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -1782,15 +1782,15 @@ static bool trans_BR(DisasContext *s, arg_r *a)
 
 static bool trans_BLR(DisasContext *s, arg_r *a)
 {
-    TCGv_i64 dst = cpu_reg(s, a->rn);
-    TCGv_i64 lr = cpu_reg(s, 30);
-    if (dst == lr) {
-        TCGv_i64 tmp = tcg_temp_new_i64();
-        tcg_gen_mov_i64(tmp, dst);
-        dst = tmp;
+    TCGv_i64 link = tcg_temp_new_i64();
+
+    gen_pc_plus_diff(s, link, 4);
+    if (s->gcs_en) {
+        gen_add_gcs_record(s, link);
     }
-    gen_pc_plus_diff(s, lr, curr_insn_len(s));
-    gen_a64_set_pc(s, dst);
+    gen_a64_set_pc(s, cpu_reg(s, a->rn));
+    tcg_gen_mov_i64(cpu_reg(s, 30), link);
+
     set_btype_for_blr(s);
     s->base.is_jmp = DISAS_JUMP;
     return true;
-- 
2.43.0


