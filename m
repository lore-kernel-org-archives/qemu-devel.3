Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DC17CAC5B0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 17:27:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4jNj-0001ea-0Q; Fri, 03 Oct 2025 13:15:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v4jLK-0006t1-F1
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 13:13:18 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v4jK6-0007mi-MN
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 13:13:17 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-77f343231fcso1617937b3a.3
 for <qemu-devel@nongnu.org>; Fri, 03 Oct 2025 10:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759511512; x=1760116312; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fkYXB2IGQd05mQ5afzFsBgfy0mMQVz8aK9p7QDnG25I=;
 b=NUJapHA1f2V0/G29K0pjYNB92vySGZLAT+RS/OiEA2Mebhrw+PsdneL+PkcOKY+W4v
 LBS57zwqIwH8fnSXA4XcRO7BpwiI3DDwmW9VLLWSG9ZQUTXK3NvAcT09xKhdyQ+Vk3Su
 ZbBTkPwEHCj5VxE4GHCDrd+qhhtcX12Op5KxPlu2C7MoAcvWUYdKeohgzh8K/zHQiHwL
 D+MGV0lKxAe0hIfyh47a3VrhTBWcSswmwScAgeaByQtRctz0WsS1wh+vKriZaO/yJSJL
 yZYUcfETYsef3czn5a3jcGTLDAAOEDW4Ssac56UCQ56DzuGvU+w65Vpl23AjjeoembaP
 86ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759511512; x=1760116312;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fkYXB2IGQd05mQ5afzFsBgfy0mMQVz8aK9p7QDnG25I=;
 b=O5dXsp0OU3fip99YApFk63vmeG9Rh75XyabaqCqjDlMk5bkEzas1IvwGD8z93CXhBN
 /QNj14a00iUIaeGU9vljUSOsHS+1yXcAx8kdmOji+L0m7+zoxds5ieW7R7Tchyy/1Uby
 RpUEcYOEOzEjufXgks+SVCgXktjnMu8RLFs5xpz7UDCpf/ojo0hwPSl5jz5LbTZgbGOA
 dnmycIbmAWudEPy3Rp55wHLWmTuPui42CkbSstnIwibsKouZJTcKr9dymGfXVUMKZOWv
 qbau1+AX+zfXY7IOfSK3B2jJ8CuJ4omszqzXXX2cqLTSD9mJ36XCoJ5GSWeKYXZkc0ZW
 66zg==
X-Gm-Message-State: AOJu0YwaovZmO0o2U3Yseb4xrvri1otO+M5OgVe+6vrKY7Y4LglD5ffb
 73SFYfhiRxw02aGEICYt2AVa7z+R4+BRsCwYlbXTIQweLCFuioKwr6Nm63XYOlXL4+yxaFJyeO3
 Uh5oubZE=
X-Gm-Gg: ASbGncvDg2LsS4AwEa8ycjXaVFa7heAoPY9TU6z37S37l60+MbHseOraE3oNtdr07Yw
 Ld+YWBkchWWelQ0oUnim13BWiXReQXM++ADDrWWV76bl1tQLpycwOCjU/AJfm7nE/gXcZR+CnU+
 q14lgced7XPLLuxcPSTBHdS1/aWfkw+xa/vDwNltbT3GLakliWLijqXxbNKmQB6AdRO6fQ5I9Ni
 SV0Ip+RGKygRI0DgaAiCITBEnJzz/IR+qLLYQRQljnL9EyTHTBVqpIZ4JLbJ8xQPnSqbWtu/DLo
 CqpuJNwmbw3S3C9sVB2AQaSA1xQSWzhAsdBplS720mSwWxls4NIHZyuxtaAIuHQZM2VMBsIpkxI
 Z591rsrhatn66eNyYwTDsfm8JDORUM0VttxmA7MbFrmNw/nobeaYeJEqf
X-Google-Smtp-Source: AGHT+IHcX6DHwoRwpDotutGtMadkkD1fNk8+rnkMo9//5ni5zRogbTYUsxnDSumtYEQAxCDtNyDlTQ==
X-Received: by 2002:a05:6a20:7f88:b0:309:8e28:503 with SMTP id
 adf61e73a8af0-32b61dfbda5mr5478017637.3.1759511511680; 
 Fri, 03 Oct 2025 10:11:51 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-78b02053a51sm5418769b3a.46.2025.10.03.10.11.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Oct 2025 10:11:51 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v6 55/73] target/arm: Add gcs record for BL
Date: Fri,  3 Oct 2025 10:07:42 -0700
Message-ID: <20251003170800.997167-56-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251003170800.997167-1-richard.henderson@linaro.org>
References: <20251003170800.997167-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
 target/arm/tcg/translate-a64.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 0fefb1301c..acfd086e0d 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -1678,7 +1678,14 @@ static bool trans_B(DisasContext *s, arg_i *a)
 
 static bool trans_BL(DisasContext *s, arg_i *a)
 {
-    gen_pc_plus_diff(s, cpu_reg(s, 30), curr_insn_len(s));
+    TCGv_i64 link = tcg_temp_new_i64();
+
+    gen_pc_plus_diff(s, link, 4);
+    if (s->gcs_en) {
+        gen_add_gcs_record(s, link);
+    }
+    tcg_gen_mov_i64(cpu_reg(s, 30), link);
+
     reset_btype(s);
     gen_goto_tb(s, 0, a->imm);
     return true;
-- 
2.43.0


