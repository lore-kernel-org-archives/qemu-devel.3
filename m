Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46FC5CCA471
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 17:30:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4jNQ-0001Lv-5e; Fri, 03 Oct 2025 13:15:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v4jL6-0006fd-He
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 13:13:06 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v4jK3-0007mp-LU
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 13:13:03 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-7811a5ec5b6so2834611b3a.1
 for <qemu-devel@nongnu.org>; Fri, 03 Oct 2025 10:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759511512; x=1760116312; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Th5N6qtDLrIK8tuhabgewKWLUS9KC9Uadn5+0NtuwGw=;
 b=FZq80Z73eJGLh3fEJzyrVanQtoS55yPqBN3xQKiWaStI6rEAaTyJs5+2n1XezovsL6
 mD/icfmpvKKQeyVd4yIhgorX1rqAaVvBbsTuZ8im/HV2N8KQoY5sDKfk1UfVzFgPcbeR
 uKlKY22OM3X5W95/x+pUbFalPAd6vl2i5NOkHIGPjRzQlix/ioQij38Z/7fyPBmdniTv
 9Qgw6QQbW8FGu5gAEt4xtmD5Ngn2erNiJSVYu990ywDA7Epdbd3iTkcMa3CWPUsStQ6O
 1g6Fzd9468GbOfWgFGUEm5KR6AOYCj3DEMXJ+H3UPtXRHgO8LV+WdpJVFPdQwvNhVNej
 sH7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759511512; x=1760116312;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Th5N6qtDLrIK8tuhabgewKWLUS9KC9Uadn5+0NtuwGw=;
 b=aTW9xImex5YF6EcKuV4sobZzOXHWhOfNPVpg8W8SNuMhXw0x0j0uSZ8hWmdQG6gdmG
 Dm1i35qdCZQiJL9yzA12tXJEhseYY72Q4A/3bWUfAGqCCEobutp1qMKcRORc/RQu+6rg
 IaRKf15EPuivUMZVTJ8MMUgRbWkZpXbnRmnAUFKIn8tw+aMsXfd6t2hR94IIxXD68yt7
 eMbc5GwPQyyA68ipz2v+NncQ7q74hF+TId6TGZxkS2GwDqAi5+AwmXXNG49vROJ6Orgp
 fZZd/on5hUgpUqxnXurI4wXJjYtbIBtxJ5hik2sYFzfHwfRdJIaYpOUaAh3pSl9UB3sf
 dAqQ==
X-Gm-Message-State: AOJu0YwTHuQmtjrmuwS6VuVmj9ffTirKPzGUV7PuEzIjeV3mAhyOZL8s
 WcKzX4ojduLuifoVq1nol6fFbU4+/snQkh53/c+AiQDLJQUaQOMmsQd2rhsg1QnM2eUaZndPv9f
 JYqsMZXI=
X-Gm-Gg: ASbGncurCHUUvewvZ5GPpRRoYpdcgchbBGlYa6L4Wm6jnA/rx5S9BK3+4kAeGUWf0lc
 oc+pZ1yxKtCn5zeUk4oBYGrY+3zmzttI+6E4trejjMsnbA54mikL2qkGzW5j+3wTqp2MwWjcmNY
 eCuOObyJgsfftrpqVty5woLiJdLr/kaWLsR+F9ogLJot9coQi9iDbcJVncq6tzf4YTE/z73lZ8+
 4tp20FILc89dwKO74Xngy3Mk62CiB3eTyX9YeSssO5sslMq2NmelvWBzq2l1WJ6Wq1GfgFORD0e
 +5y6TcGqYzjUcOzyQ5xHBnY7oVO5neUimWw717IeKPacHuuvJX3C9B+1N1iiqPZgFb5ZmCIwwtR
 3/UAP/OW3vpQ4EqPcAEHZ7+zbL3Pg8Gv0ntzLFeGCBDqtDXTmgappSPX1
X-Google-Smtp-Source: AGHT+IFLXT5kiNYhztAYVR6/edNHKQHRLKywbhl2mj8YZ/QYvbqrpGIDr6l2PikSX65/xIVyQIfMNA==
X-Received: by 2002:a05:6a20:9389:b0:2cb:519b:33fe with SMTP id
 adf61e73a8af0-32b61d9e05cmr4404087637.21.1759511512460; 
 Fri, 03 Oct 2025 10:11:52 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-78b02053a51sm5418769b3a.46.2025.10.03.10.11.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Oct 2025 10:11:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v6 56/73] target/arm: Add gcs record for BLR
Date: Fri,  3 Oct 2025 10:07:43 -0700
Message-ID: <20251003170800.997167-57-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251003170800.997167-1-richard.henderson@linaro.org>
References: <20251003170800.997167-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
index acfd086e0d..61a75e2a12 100644
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


