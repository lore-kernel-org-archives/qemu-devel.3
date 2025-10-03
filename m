Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 049D1CCA471
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 17:39:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4jMX-0000Q8-5u; Fri, 03 Oct 2025 13:14:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v4jLG-0006n0-ER
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 13:13:16 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v4jK5-0007nP-HT
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 13:13:13 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-7841da939deso2509175b3a.2
 for <qemu-devel@nongnu.org>; Fri, 03 Oct 2025 10:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759511515; x=1760116315; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cyJLOi++bO/6i8m8qjDJ11TBCktBJC1VSQqXpenLZ0U=;
 b=G3syM8BtHJgbws24QBLq+J1rRqsLUgYchlRLyLO6JaJ8Q6bbYE4EYRp2V1X27xbKKx
 KHaaZa62RdUfggs/gBjb7P9boEfj5qhVtIIBQuJdYvH/IZ5P/oAifbl3U1AA6/QWSlP+
 3iwENUdeJOHJQekPC8VNSxmBKbOrVXy7x44gNgOcN4YuiiHIsaqBPmNqzRxZrkZ7zf75
 YRdSFBnmd630fnwteSNeTm5g1PRzyd0t8kkciCqSQaNG5X6Gy5akygKoj+Dqt5xhShWP
 KiUODexs79HD1vGDi2W5A/RyoFcoa7KolFdWCBccAT1skh+2mewYmpC3ks0L28VU255h
 A+XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759511515; x=1760116315;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cyJLOi++bO/6i8m8qjDJ11TBCktBJC1VSQqXpenLZ0U=;
 b=PqoqpgkQvhwNyhmv62LYTPkBZWNk0A1aNr58NXzFIBHden1j/IYMQgr83mrJC4L2Jy
 FMpINC2ilSC43Brj8SIfEKNC83w3kRBrBKE6aTNxF2+8J+stpeRWKOEZdj7eCnvWK7IC
 EsrxZ9KRqDv3hydgHlwkT3eVth00RScxn2MCgbGCzavFbHaMT0FpmfPXjoJourzPybi4
 fPSmGGIbSY9HIqpML64/zIF6JT7O37houywcfvBHq57tKNvnECs/5wg2iV8aEr/xebK8
 MtBQ6jmNk89R2GbCWPLC3jMPDhYXYfpay4UOQZ2aLpypXWggwLmNzW7j4n611RcRRV30
 l6dQ==
X-Gm-Message-State: AOJu0YwnP2NH0+OKQ5CEMjbkXdE3Z6TDCEViyCyQLtFCC7seZpkYdveR
 zJetOf1w6SHkG0w7EJjLpYt18Gf3DkLQzHKfjCMidPzU/SwCCJPGlWFjIcezMg8eN5d+8fUPwV9
 +117HLTc=
X-Gm-Gg: ASbGncsM/uQ4c74DwwzFLmpeApX0XTbeFx5LadWq1fj83/fBBysKKEf0MjAbQFnXpaD
 mt7MtISSp8VWJ+vqY82UezlvnS6fzTU9xo/ui5ur1HDWjORR69gz1EkvuE/4s/cfomHumMQMiLf
 q51hSB7NKyUPnKAHiKjvOv8xlfnM3Gbsohk7XzY5Y5fCjEImpNtxNPktlo6/0x6D9BwnBU/VwrH
 yQIJ17l4d252Vb0gBHMkK0+NjbNxVIn94XEtVZnaQSVq2J3+u3TMoD78O8lc8cJjBf2iJd5YEaf
 nArjkiYzEVTKS+krmLzQP+g1nA9sJtzeYsD5gPnnQcHzD2Q0xJhRvQkOi8e4EQgZsv6tbid1//v
 lc2CsWaf3qQQn0ZGu74iFK2lM5AXgIy9udOG5cVJOFpRDj+Qh3xVKbs3R
X-Google-Smtp-Source: AGHT+IHkXfTqEAGaglyP9C27GfARHsahf3eeKRgHYWekFiPtWiJtzalxWcAwVJOdhU9oKpD8qyliCg==
X-Received: by 2002:a05:6a00:3e0e:b0:783:c2c4:9aa5 with SMTP id
 d2e1a72fcca58-78c98cf8581mr5692078b3a.32.1759511514790; 
 Fri, 03 Oct 2025 10:11:54 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-78b02053a51sm5418769b3a.46.2025.10.03.10.11.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Oct 2025 10:11:54 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v6 59/73] target/arm: Load gcs record for RET with PAuth
Date: Fri,  3 Oct 2025 10:07:46 -0700
Message-ID: <20251003170800.997167-60-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251003170800.997167-1-richard.henderson@linaro.org>
References: <20251003170800.997167-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
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
 target/arm/tcg/translate-a64.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 6e51a0f6f2..d174696c87 100644
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


