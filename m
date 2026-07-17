Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87C4AC44516
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 23:26:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkru0-0001br-KT; Fri, 17 Jul 2026 19:23:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wkrty-0001au-Ah
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 19:23:30 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wkrtw-00071q-9n
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 19:23:29 -0400
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-c9c26a5fb98so1527499a12.0
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 16:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784330607; x=1784935407; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hoKL+T5ZAMVBhG4qjN+wRa38usEFNIxUeO3xCWyHIIM=;
 b=m3IRTIyUUrImJNcPSCcQ8eGPJpHyemnqZ9yDLIrsUyiGFLhLoTVZstCoC8Ox6hQKzi
 ogXtQ5LSYKPsg1d3mGKOUJsBSpu1ys6QwwChau7YdHlVI0ES3IFy9g9gfBRQrQp7QIqh
 b2T9ar5zMiWOS874HvZu9KDvfAytDXuBqgdtFtFWWV64Lap4cO9JR3NJ/UYhRjcdr7S9
 Ci/9n+G3fO/j8D4ImlJJV0pyjErDjBqmXYqSU/fLIWZBw6SCwjoNgcnm0IDtdG/mGAc/
 UnZsqTRcHINVYI1e433V5gWtqShZ59BhZWFsqIp74KpvQV7pBiK3hAQ+sxGuh3db7u/C
 I52g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784330607; x=1784935407;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=hoKL+T5ZAMVBhG4qjN+wRa38usEFNIxUeO3xCWyHIIM=;
 b=I1X7jT+ZLtRwd6pOErTRpcnvulYXOzUELeM98YvOY5OW8nuP79ZPIMAcQhyXXkWwY6
 AfEUKJzvzoLilszHbWKcbGbjEch2VAA2iUE7kvxBjOK/NduYXoNkMcbeN15rLbqUpw6Z
 dL3avCK2/ijJpag8gCKUt6o4tJEpU8VSHOPIwm3Vtu8z19SMXuLXmUvEqy+K7AnFYR5C
 1dOEpd0zEGDYoGw8Cd1Ygf4FKzOC+UkSHMf2PcEIbV5r8I96K6yssytUxBw1/cH27WW8
 vdFtSMqPYvNBFoG8Jo0dDXx0/0G5FqkP0gU/YCtmH2KSrx4QsuUG/S3VyqHksKWQPwZK
 V8SQ==
X-Gm-Message-State: AOJu0YzLDCaF0YnW+6znRiT4rb1d3uwYYdreoV7I+lgb/7SkuCfBoumE
 V7d/jU5viH0vgBRJBsmM9ott30aiRZpg6Xi3JeVu32Zsl+UtMGz5jnH7hzpw0VAWgONb3BoWSkb
 qZKoH
X-Gm-Gg: AfdE7ck7fyqSxz2GY6snx3Wrp42qC57WoZClYCmNaMm8h7bD4x0eMueGkWsPEJR/ZqL
 9u04YKp0N1dOnapTYSu+tbWp9QT6StyZ2+hFA479sP7ejICncKprOXgXEZhAzzj9PuhPkzW6Hzd
 xVW0c64j+nqGOBjNCmsIqnbys0ekMgf70xe7wlz8wvJ+mePWbOzvqXudibBambSj/vUStrFP9sK
 Lo/OC8T6LDxn7skvj8ZvWrNh3zwy3QQXYXz2ezfFAR9yJ8OC3BbEasUJBRUC1KoCy1YmLBM3ShU
 LRk/BXWnCN1KXjlcI7zANV0Tr1iVDWMHwIR+rfSNFe1uIgI+tgo7maAisxGF0N1207eFCT0FN3N
 qpoH3NG3vQ3SgFq/oByzKkuQWNRJvLVfXMm27JsHSG+BkEa9Co2AY9Jyf1/DEFlmV4nGN0KfwWP
 /46HVmgtA=
X-Received: by 2002:a17:90b:1345:b0:37e:1620:dabc with SMTP id
 98e67ed59e1d1-38e3cfd30a6mr9211116a91.0.1784330606704; 
 Fri, 17 Jul 2026 16:23:26 -0700 (PDT)
Received: from stoup.. ([32.140.233.50]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13ce2a18a47sm8186261c88.8.2026.07.17.16.23.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jul 2026 16:23:26 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 14/17] target/arm: Drop clean_addr_tbi before helper_dc_zva
Date: Fri, 17 Jul 2026 16:23:02 -0700
Message-ID: <20260717232306.378988-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260717232306.378988-1-richard.henderson@linaro.org>
References: <20260717232306.378988-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52b.google.com
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

Now that probe_write always handles tagged pointers, we
don't need to handle this during translation.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 590c7d8064..24a0cd8345 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -3142,7 +3142,7 @@ static void handle_sys(DisasContext *s, bool isread,
             gen_helper_mte_check_zva(tcg_rt, tcg_env, gen_mtedesc_zva(s),
                                      cpu_reg(s, rt));
         } else {
-            tcg_rt = clean_data_tbi(s, cpu_reg(s, rt));
+            tcg_rt = cpu_reg(s, rt);
         }
         gen_helper_dc_zva(tcg_env, tcg_rt);
         return;
@@ -4763,7 +4763,7 @@ static bool trans_LD_single_repl(DisasContext *s, arg_LD_single_repl *a)
 
 static bool trans_STZGM(DisasContext *s, arg_ldst_tag *a)
 {
-    TCGv_i64 addr, clean_addr, tcg_rt;
+    TCGv_i64 addr, tcg_rt;
 
     if (!dc_isar_feature(aa64_mte, s)) {
         return false;
@@ -4787,9 +4787,8 @@ static bool trans_STZGM(DisasContext *s, arg_ldst_tag *a)
      * The non-tags portion of STZGM is mostly like DC_ZVA,
      * except the alignment happens before the access.
      */
-    clean_addr = clean_data_tbi(s, addr);
-    tcg_gen_andi_i64(clean_addr, clean_addr, -s->dcz_blocksize);
-    gen_helper_dc_zva(tcg_env, clean_addr);
+    tcg_gen_andi_i64(addr, addr, -s->dcz_blocksize);
+    gen_helper_dc_zva(tcg_env, addr);
     return true;
 }
 
-- 
2.43.0


