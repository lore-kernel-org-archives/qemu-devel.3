Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 532ADCAC592
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 19:06:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0li7-0000Xy-Er; Mon, 22 Sep 2025 14:56:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v0lfx-000532-MU
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 14:54:18 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v0lfM-000505-Mi
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 14:54:12 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2445806e03cso60745685ad.1
 for <qemu-devel@nongnu.org>; Mon, 22 Sep 2025 11:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758567211; x=1759172011; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AH0Uenjp2D4e4yuH/PEh4ImofNJohar5VRmQYhtWJng=;
 b=YrGgzJe0NsqcjW7s05CpJq0n4Q45MBTG5VDcOHI2AZD4o28MvEK4v3mu9X+hzvz+7I
 PBWTeAmilp79DW4P4b61hUe6XwyBc8aYKwydIgRzwSeystlj9iuEutbvh+1u/AUjzX+L
 AlTpg0/rcMdGHDilYmAdpOeuWbHeZezG8Kl1WAGO7T9i8aJyF66n2do5J0eywOPL30M2
 zeChgMKDmGPQDsgJTbOyjUIkthON8wn5kOSvkFFUzOVjk4/IFzeIwkhmmVcZM4xbiD7E
 S72Q4slIhsc5xvhPOOKWrh8hl2RYhXIoQl6S2g9dKn511yPiw3KhXGJ/eObIZz1TZLCf
 P/Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758567211; x=1759172011;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AH0Uenjp2D4e4yuH/PEh4ImofNJohar5VRmQYhtWJng=;
 b=ka0GKpL7SS7/184PubaNhvThF3PT+CH9x39PunhZnIfm9voPhw7Fd/p9zyySOCET+w
 qWZashWr8ziSP+TrTlmVJAXQ4ATtL4veX6lhR76JYhfVDbUDHgA9VmHPH51OClyTGEVi
 UMEpp0/e4HK72EwWR8+Vn3gseL42ycfXHSR+c+OqCH4zlW73wVITBO3R3FTS/SYIasbh
 /ga0cL98471j4x6ZMv5keDKHhuzM4MbzcOBpm4ikr8i5Ic21aJ+iHHA6OmsXmj9KWbkN
 p/Ycai1tzUIFWj1PnF2ujham6zbFkX42kDOnHDdr0Q1IhVOJ/q+/gyOf3+s4mR6XHhhV
 tYbA==
X-Gm-Message-State: AOJu0YzNXf9M7KtqxnuOXRZUkygC7vSubBfi3NiYJP0tD5h0nhC+Y+g7
 RFCCYkPcNXCW69B4ME7quGPiVJLg7cJMI3XIg+zk5IEownQBagOtuNzWL93TXgBwp7C9fqoxBfR
 jzB89
X-Gm-Gg: ASbGnctXnyql/vttC7swlJQfuP0m2/aXBImAwPFrA6fMbI9bJ21RRJkQeLkxqdQC0JO
 srkeyzIdBTK4Ch6Q6pL7H/9HRdzO3MYSYSx8Ts0Ym9Vp74yjXj6wv8DtKgyN8v5U01XtbQinMZ0
 Awzp8FA6+EpgD3AcV6i6U7URnrPxR1dHYWRio005gB0IfbMpT6tg2S2h/8t+Dj9lvQC9svS3K2P
 knFIhqZ9/yjq73+uULjvSCwhZAU+hX/ii1C/xLQebWJrvZg+t6BuqzWD+SNQoLWPiyWjB0rtYjm
 cVtznKZ6XMHbZgAP3kxtJOXCXMSY8bT97T23XPbwWM8l6ri43lf77HvUO1JNRcgRMI7woRe1MPz
 A4j6emCbQdszArN92OMAoL2l2LtUv
X-Google-Smtp-Source: AGHT+IE2q1p3jgJmVNlqItbB/dkvtPUXzJSNPxEBiPQ6wBzi+g7I8Is3Ed0SBb6KKvgoA0NFB46LQw==
X-Received: by 2002:a17:903:94e:b0:269:9ae5:26af with SMTP id
 d9443c01a7336-269ba43a000mr184654645ad.13.1758567210860; 
 Mon, 22 Sep 2025 11:53:30 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2698018a472sm138554795ad.58.2025.09.22.11.53.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Sep 2025 11:53:30 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v5 59/76] target/arm: Add gcs record for BLR
Date: Mon, 22 Sep 2025 11:49:07 -0700
Message-ID: <20250922184924.2754205-60-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250922184924.2754205-1-richard.henderson@linaro.org>
References: <20250922184924.2754205-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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
index 6eca241f12..79fc7b8c3d 100644
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


