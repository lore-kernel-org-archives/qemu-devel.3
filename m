Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40B18C369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 22:15:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8RBg-0006JI-LR; Fri, 25 Apr 2025 18:06:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8R7o-0005ek-9x
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 18:02:24 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8R7k-0001OK-N4
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 18:02:23 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-22409077c06so44325505ad.1
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 15:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745618539; x=1746223339; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X4qDfrPFg1A+HsqWBVQovPa9Xet+i9wtHFpQlqn9CU8=;
 b=djdHXjSyg4M4RRbSjeUUKAT56XaGNa+pBMsisweOKOlJoEO88ocVTjfmh9mpCh4nt5
 gmwjWBbLK1y6Br2943wf0mw6UxahA3sIjNFlViKapiKC7OdNaH/3FIDXmtc0jdjhpky3
 3d7bjjDb3O4Abzypp2HnJMQJ9lItRrfq+xgREwJ58w+rLPhTA3CwHKpG8xERUugnbfJA
 ensnhGkQviHaYNkhKNN1IyN+zLoWgAoz54VD27EAyvh2JQun8vEjsFoeDtyT3pXOjtDB
 rG8c3IZL4x6PCL3NRVvVtHhvL7cwq902SyGYGyrKHouGNb3P6YCod3B0AMF5EC/jZBPC
 ICvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745618539; x=1746223339;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=X4qDfrPFg1A+HsqWBVQovPa9Xet+i9wtHFpQlqn9CU8=;
 b=oMj4UWy6LyY82uR45HmryLLzxOmpxxuMXsrizggk4/0Kut4HuJJwX8ZzQ7IskBCN5p
 kvt5uM1QtnIQfqa1C2kr5A9VKxavx+NV9yoTjDh8MVUXJcFf+xD4KIh1VVA8ZYZAXnoX
 1ErlAbxKh061B++Z4FrJr+REReNzlekhE0FhgzsAwZyggYd90GiQZ/DSCqpOf6ttSFBo
 CN6lrFajB/zifyNgCpW81L/TZGb3zJKOYRKTzKifrIyaTn56qnQBH0Q6dMD8KTngUjYW
 /FV+fRPoWtWn+RDb6O46PtuCY8OEAAZ0GbhsXSBM3ePp6Xekrww9zt9OsVowZQj4RrsM
 v/Wg==
X-Gm-Message-State: AOJu0YxrDtYvkySFzDoyxHN4XPTojsoNGZKKF3MA8ACziQaJo4HD272M
 etlqs/po4RGx0WLEGEZbRKha2uUFm5X+IfPdPiOjPGTqggPF7aecB6WxAUo2O+lXxw6W8Qbv7PV
 A
X-Gm-Gg: ASbGncshEJ4XtZqsLhHfKdq9xFiIjx7mxAk31W80k1MwU2PUydJ/UOsmqFZmLeJ5x04
 ilx60rPO/jmvACCDfIJGbeoJZDZwN1wmDR2YmlFWluKr/VkeZoVySu5wM07aAFuEMXdi/QgT+g4
 bpzbDri3hamHcWCBM84M8uPusN1i1RA6AqaUKacRs+y0P0Za2QKjUPMiXzI/LMj+XTrE93s3AeL
 NSWzZ1etwAUVzPI06bKUXWsVNsEOzzkhkIRfwwOLzggj+86qVqpQ/ilprNVtBkPXliaBwPQda+f
 PQtFA3g6QnnjkihYH4BddeImpLZ0PiWmulYDKQ5w7z/72V9A3VS+NNXbg82W054SKmzzEo7r2hr
 HuyipWsmF4A==
X-Google-Smtp-Source: AGHT+IGkQ4dkUcqx/UOQ1+oaCbYamm6mmJUptUGXtMU+Q6X80iT8wlXA/B9Kyr6J3H2vWCKkhLmEpA==
X-Received: by 2002:a17:902:d4ca:b0:220:f87d:9d5b with SMTP id
 d9443c01a7336-22dbf5faf1emr65418675ad.24.1745618538912; 
 Fri, 25 Apr 2025 15:02:18 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-309f7765c88sm2212961a91.28.2025.04.25.15.02.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Apr 2025 15:02:18 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 111/159] tcg: Expand fallback sub2 with 32-bit operations
Date: Fri, 25 Apr 2025 14:54:05 -0700
Message-ID: <20250425215454.886111-112-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250425215454.886111-1-richard.henderson@linaro.org>
References: <20250425215454.886111-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

No need to expand to i64 to perform the subtract.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg-op.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 8b1356c526..127338b994 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -1123,14 +1123,15 @@ void tcg_gen_sub2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 al,
     if (TCG_TARGET_HAS_sub2_i32) {
         tcg_gen_op6_i32(INDEX_op_sub2_i32, rl, rh, al, ah, bl, bh);
     } else {
-        TCGv_i64 t0 = tcg_temp_ebb_new_i64();
-        TCGv_i64 t1 = tcg_temp_ebb_new_i64();
-        tcg_gen_concat_i32_i64(t0, al, ah);
-        tcg_gen_concat_i32_i64(t1, bl, bh);
-        tcg_gen_sub_i64(t0, t0, t1);
-        tcg_gen_extr_i64_i32(rl, rh, t0);
-        tcg_temp_free_i64(t0);
-        tcg_temp_free_i64(t1);
+        TCGv_i32 t0 = tcg_temp_ebb_new_i32();
+        TCGv_i32 t1 = tcg_temp_ebb_new_i32();
+        tcg_gen_sub_i32(t0, al, bl);
+        tcg_gen_setcond_i32(TCG_COND_LTU, t1, al, bl);
+        tcg_gen_sub_i32(rh, ah, bh);
+        tcg_gen_sub_i32(rh, rh, t1);
+        tcg_gen_mov_i32(rl, t0);
+        tcg_temp_free_i32(t0);
+        tcg_temp_free_i32(t1);
     }
 }
 
-- 
2.43.0


