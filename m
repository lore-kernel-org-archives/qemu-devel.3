Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C1ACCA0EFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 16:53:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usOED-0007aU-Ja; Sat, 30 Aug 2025 12:14:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1usERH-0007Qh-KM
 for qemu-devel@nongnu.org; Sat, 30 Aug 2025 01:47:49 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1usERF-000504-Qc
 for qemu-devel@nongnu.org; Sat, 30 Aug 2025 01:47:47 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-24458272c00so29633645ad.3
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 22:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756532864; x=1757137664; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oVJt4rhBlWqXMofG9EtIBvJoQIzG/f+XQmqCdtXKT94=;
 b=SBPJNbRLNpWlo9mXJ/JyTtxGUYHvzpNDqIYGaBcB4IUhV61L4afysIJ2UNEStxVpPI
 gNwwSiWHAE0C4Liyh8RrpXKHKsnQfyATRSQwtOc79K71IF29M7Ty18YaAaIliq0VRFZ8
 mSLZ+uUwfGIDMV/rsxHV4iYvikzdhDUPHxR6S0969ELsAsXjzoHr2LQfA7uz41Bh0xic
 6RZFkoHh/it+rgXTGhFTIQXcgyjXNCEdXVbKxfaCY1j/yI51K7ISOxlrHoCiLce7wHcr
 pKshK5em5zlHrejoSAz8RBUJW0TlsMQW3dsK4ofvXzt6fpGbRf2ItGIX5V+ehG73y1ah
 MgBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756532864; x=1757137664;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oVJt4rhBlWqXMofG9EtIBvJoQIzG/f+XQmqCdtXKT94=;
 b=Gi2AW9R81kZIQOwI6E4hfcSifBYpl9uBb/Go3Jl2CrDKEgaasm92Y1H+gThMxpA0jH
 cr2EUpKs7UZiD2t7NqkuCt4mYmKjtyH1b4+y6xJ2qJejumOPot/1IBUSQTckZBUHRD3X
 W4CsMQ0VfSr7vusUlKldGhxmtKs+WKZ4fhVRijFQnjUYg/USenpW3N8LAHze+KHnNjNk
 2kYNuWqA9vscCXFoU/8LJP3NGyDEUmjre6WIae/261WsSBh7S45SPlDeUtqaX4dDuy0f
 9PYqXUxgEQqr67gV8drg6+sXpiP82uXShqtgn3RbOfIyOoIOvDSKKnOdBP1m5pCfftSP
 bVhQ==
X-Gm-Message-State: AOJu0Yz5raqvrakjT7E/0dj83y7ok6E2kpo7qe9bxnk6cYVsh+7tfNr7
 AjkZcSzDJTSK4xyYxLYdnGvVhKWCuKQ42LCxBaMc+yN6y5omXfcXfbJZIMwivNJpXywXRuNXWj9
 LogAY+5Y=
X-Gm-Gg: ASbGncuYIohS//ybs6AjQ0/wTmZ1GJc39ctGFxGbzyFrjTyuxmV0csbn0C/KsW/3JJ9
 R7m6vcAzQUY0eA02nksDg+AILfSf8BNxEaWAY/StzCrUj7hqcrApBNsNLFzsGjPb59nCxgAEtlJ
 UNqW4zQBMR/GIuvYajVU3NCSJaVpkFmwsurgBDFtujfY7QRRBRxaB+/VOBi1qmR0DieWpdgc3Rj
 DNMJ7R48VnbfPK9bU+07vju8hKI5+x6m8xaJrjHP/9/Ke7STjzqBFXg4LgHrmq9pBDSYj67voJI
 cnVeyZ4FtOQzAnPy/F1SjJAe2FRWL10Za8W3yLH8XvvtuJRjXi+b0/ied1rneqszNSCeRji+pl1
 Hdx+mxEyUNuFi+mWV/BinqR/WWm8EJK/uFbcdPt0H2qkc6i7u9SIhKOJkktkVqOU=
X-Google-Smtp-Source: AGHT+IHMyFnYxctV1VNdakt+UdDQ+yn3UI7iheiwHcW/zFs1D/Hy/KWchMryK8eG4JexVEZ7O8csgg==
X-Received: by 2002:a17:903:2cf:b0:248:9e56:e806 with SMTP id
 d9443c01a7336-24944870a36mr17372035ad.12.1756532863765; 
 Fri, 29 Aug 2025 22:47:43 -0700 (PDT)
Received: from stoup.. (122-150-204-179.dyn.ip.vocus.au. [122.150.204.179])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2490658999fsm40852715ad.112.2025.08.29.22.47.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 22:47:43 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v4 67/84] target/arm: Add gcs record for BLR
Date: Sat, 30 Aug 2025 15:41:11 +1000
Message-ID: <20250830054128.448363-68-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250830054128.448363-1-richard.henderson@linaro.org>
References: <20250830054128.448363-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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
index 336aac9d1e..8230ac0fab 100644
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


