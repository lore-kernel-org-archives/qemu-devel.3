Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12702CA0EDC
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Aug 2025 13:24:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umXeL-00040I-AQ; Thu, 14 Aug 2025 09:05:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1umXdm-0003Eo-3T
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 09:05:10 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1umXdZ-0005Lm-Qi
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 09:05:09 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-76e2e88c6a6so865329b3a.1
 for <qemu-devel@nongnu.org>; Thu, 14 Aug 2025 06:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755176693; x=1755781493; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=219p0B6WHxgpAXzKUyAECcJImn3r2+0sic49ayh7Cg0=;
 b=i9p7wBRM1+NmWgHFCBEHwuLIHbDF5+QXBtl+UrQc6wkS3kt11Xdgcc3th/DJlB8IpL
 PngzD0659KHjDthUNdf4OmkLwA/a/CuQuiZd7Ct4s9OjDzWG42+d9uX5cSb+YAEiXux/
 gV2szy/ghFTJugr0KCgTxtn0wImlWKjyu/4ODmT28fDryMcrZ6r1fz2XsD2jHXt+ysIP
 TIuOMnBCzPWiQetLuhEfBDSITpFApGtvHCCCSRXTcv1f+d7AmjUT09lNC/zuRWdh+h+F
 dHkA0vc7XgtdcjKu2PCZIooG/CJY827dEPa47pB9wSiPPxYccnVRS02lVClXPF+LZGOe
 2MYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755176693; x=1755781493;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=219p0B6WHxgpAXzKUyAECcJImn3r2+0sic49ayh7Cg0=;
 b=MZGCxyIWLestpiv5vDu729bENzf2w/DIAMEoo3HY2Ne3WqN5XDH0t9TzHX6I/zcyOZ
 /z4mxPBOl4Pv3m0ZjWvU7SsKxvaDshxkx/Q34bBeKiPw5LvU+OVxbZTEsduKnDQxYMhw
 Mf9yLmBxi5QEVTSZiC/jgubN7aFDXswuUeHz80nj4cB3mRCL3rFNVGOW4AXPun7iS5/h
 obR1boaq7Wh67H1U5QDPn4AaO94h+p1FPfiSCE1+WptgLJZtm5UkLnPwaL0gdHYafF9R
 gAIcxoCIvwV26ZGw7QcO5Ae5jVnVUqtqEsQUhjoXZo/k9ETwkqA6Cr1qeQ1p2t/Zn/yL
 PCoA==
X-Gm-Message-State: AOJu0YwnEv5JP8FJCtsIyj8CTOo7jCYtvosHc7VwTfeoQyMx8fI/YG5Y
 xbWf+5a7A21YTtFeuXoZ680nCkbx5fNiwKEFfyflZb9r03ccA4FgwrSLUwjsrHy/hpcDcUEozt+
 MzFKh4T8=
X-Gm-Gg: ASbGncuKKjJizLXLnN7D57Zybust2szKTZ3ysdNQuuP4eylptRnEynCQFZiS9pLd8lK
 e4DsZUiWu+rehJuCnn6V40oHyKM3z06LpjdHvp9DjULi7stoN2eciqFlzC+KZ5SvN261J/YJksf
 ALSmbOVKLUVmy8XZxkSt/vxy1aMJzB5l96yembYhvXsapiJeJLpb4y/fnJjoWepjQwNMxMd0PF3
 nuee9meaaeiiAYNP68G037DCtEET0BqbPYSFZnIA15X9U1o/8SBZViXWJRNWCgtZukdpbMqY2/K
 eZpopfAaMyb2Y0Q+zkpzzHL+kiMQvEtSaBARVVAoZUukXmrWnOPliSY+Fr/t9hiXxpUS7enRcZ3
 kZpYzQH3MOU4B9HEIa/JBAWexPu/4Bg/hnXFrFxxYp1phtT2nOxJKjBOALw==
X-Google-Smtp-Source: AGHT+IEfUT04vfTlRAQMmKNWsT43ee2rkhiFL6I8T+q12t3xL+2eqCnDFr7TmUfSsi3z5bICFbkvTw==
X-Received: by 2002:a05:6a00:8c2:b0:76b:ed13:40f5 with SMTP id
 d2e1a72fcca58-76e2fd91a8amr4531119b3a.18.1755176692912; 
 Thu, 14 Aug 2025 06:04:52 -0700 (PDT)
Received: from localhost.localdomain ([206.83.105.236])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-76bcce6f6fesm34480631b3a.26.2025.08.14.06.04.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Aug 2025 06:04:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 70/85] target/arm: Load gcs record for RET with PAuth
Date: Thu, 14 Aug 2025 22:57:37 +1000
Message-ID: <20250814125752.164107-71-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250814125752.164107-1-richard.henderson@linaro.org>
References: <20250814125752.164107-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
 target/arm/tcg/translate-a64.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index e4a298d61d..ddcfff9041 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -1898,7 +1898,12 @@ static bool trans_RETA(DisasContext *s, arg_reta *a)
     }
 
     dst = auth_branch_target(s, cpu_reg(s, 30), cpu_X[31], !a->m);
-    gen_a64_set_pc(s, dst);
+    if (s->gcs_en) {
+        GCSInstructionType it = a->m ? GCS_IT_RET_PauthB : GCS_IT_RET_PauthA;
+        gen_load_check_gcs_record(s, dst, it, 30);
+    } else {
+        gen_a64_set_pc(s, dst);
+    }
     s->base.is_jmp = DISAS_JUMP;
     return true;
 }
-- 
2.43.0


