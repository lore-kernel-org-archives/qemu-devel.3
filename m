Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71709C87FC9
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Aug 2025 23:48:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiLtH-0006be-2N; Sat, 02 Aug 2025 19:43:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLnz-0005ak-U4
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:38:28 -0400
Received: from mail-oa1-x2d.google.com ([2001:4860:4864:20::2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLny-0006J3-5c
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:38:23 -0400
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-30b7448b777so514003fac.0
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 16:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754177901; x=1754782701; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U+KcO3RwrbURwPiGEiM0k/8PzgvqrFmZdld21Sd1wzw=;
 b=r645oQwOPO6HW7lSPAL4u11tkC/0WrWggMCR3mSDkTDzBHNBoZvLfxb0xsTbTe9IjL
 L+r1tTvK+91ylqZ8epErdREHiMwRAtt0o4G37lzDQUHl3c2oNTLHOMB+iXJahfGdcr/+
 hx1I1uOMe50h5RL4WZfZJw/M/jbrkW8l7ovT8DfG57vrqMMbSSGs2wth5c6/ElqL7k+D
 YbF0Sc1ZdISKrWgzBs/OI9k8SCzL1TwnNu8pcj0GxFbG6ijirYLTKHVMbj6dnD8a+Z69
 991nxarm+u7eHnpl+02ejkub3/ThS3zLz9QDaXx7jphEzL9ikWmkUcXmz1leXxTdfpcw
 5C3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754177901; x=1754782701;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=U+KcO3RwrbURwPiGEiM0k/8PzgvqrFmZdld21Sd1wzw=;
 b=aQHoENhaH2zQPv4a54skIvHWWy/kZDsxmAV5h+M9AG6/Aysw/4WehczaHzSDyMnUVS
 QlP2/Os2GYxDMOFwReo77fyrzXS8TDKMBKKpa56feqbY2KkPQPNLKGSvmp/K+CXxP5Ou
 6KrT6dl5o9WeT5Xouz3cenQ5YE4BxoNYEf207j0RjCHToWOVzCwawJWq1GdrS9Zsnk2+
 SJCY59fFLexJICmnUWbZTKBXT87JCpO8b9em81BIOfaAjmGh6fZskKmarrdbz2rnTQsK
 fPpeE3iPxRbAfvD+SxiYZ6p+L2X8CWvHtuC2dMCGOSkpZe72qXLrP5vfLShfvCQbUTQC
 m4rQ==
X-Gm-Message-State: AOJu0YzpRExssj8T8D9nIeILNSWyesu1dw5KsviCCD51K/aOHlK+1oU9
 rba/Srp6Cwztk3s5nhbU84og4GVPGE4DhLb5lJAzeP9OjdMFBy3MsqNK3B8EiTEFRBWBVqqtsxD
 ERamPasI=
X-Gm-Gg: ASbGncs0MbkESDyASO0fY3yP1UwLBgByH9iB74cWtsRuSPRwyG6HO66JEzFZqCP7CCR
 3YGCph04chw6SPtWJngbLU7xnb9X8G4iDmxfXH+sVkBcjUMCSp+gmZlPcrLgJHnfRubKrQE+Zsb
 6XTmEpBpXORn9KV3T8ZFwscMzB8ROzz1Pw3U3xr5s65LO0tRAFH6LOPotieVu7CBOKPy9qhCtXY
 4yTE81i+p5xTqM+x8QupE7dXxJnpfU+68uJ//fhgm5dXkmrrEhtOom+Edt+gIQ8bczzr93TxNT+
 9QebKyu4fKqYudSqu6Zmm7stnBqZH7rHXcu1Cn1GZyUY/U7ltbMh8tkhkFG2xrPv11mUiH7VNnd
 v1Rc6fYEn5LYRre8ApPaaw4Qg4TiO6no7yEcVW0ef1eMLUemaVgdb
X-Google-Smtp-Source: AGHT+IHxX9Cmf2XGJW+9jNfSBRoymrGA7LUe6Iv99m2+G/JTMksu4sdJW/wpLyeGj7pyKa2UE1Milg==
X-Received: by 2002:a05:6870:b1c5:b0:2d5:2955:aa5c with SMTP id
 586e51a60fabf-30b670b9c63mr2525534fac.0.1754177901045; 
 Sat, 02 Aug 2025 16:38:21 -0700 (PDT)
Received: from stoup.. ([172.58.111.133]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-741a71dc78asm380409a34.30.2025.08.02.16.38.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Aug 2025 16:38:20 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 67/85] target/arm: Add gcs record for BLR
Date: Sun,  3 Aug 2025 09:29:35 +1000
Message-ID: <20250802232953.413294-68-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250802232953.413294-1-richard.henderson@linaro.org>
References: <20250802232953.413294-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2d;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2d.google.com
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 6fd3032613..4c3cc3d943 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -1771,15 +1771,15 @@ static bool trans_BR(DisasContext *s, arg_r *a)
 
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


