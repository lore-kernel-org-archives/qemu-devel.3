Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAED7CDD578
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2024 13:18:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1srGwk-0006Dd-KT; Thu, 19 Sep 2024 09:11:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1srGwP-00053B-Ue
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 09:11:26 -0400
Received: from mail-lj1-x230.google.com ([2a00:1450:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1srGwJ-00011p-4K
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 09:11:22 -0400
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2f7528f4658so7180291fa.3
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2024 06:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726751477; x=1727356277; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=dD+vF7VmxRugqVzyEsydLmIdMP99vP2j/3rSmzOsQ5c=;
 b=tzJSv8VA1zW6A+t11i35McsanVxF/r6zQR/xanefWltxoABYFHhmMxOfNLHp4UvQHr
 Y1B4TAOm91RhHU2CqhruC2rAX6K6LN62uW5aLETd9Jf8eJiEhlHJgczvshy8VRQpVzGz
 G4/I/kw9zY1kwbEfOnmvemQYcK46/+F/vacL4rwIadEQye8BJcQppE4n9UCqUierzzXy
 X4N5fgOumI+m0CUV0GESFwzVzsl5FOm2o8G8LZequP11oXGHoPyXipU/McvROXBZcfMj
 y2HGc8ad22NgKsIAZxRMBaczO8Y6LMhiEyD9bv44QwZ/q7JgSQDC+DyhwkPEIBbL2Oup
 6Auw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726751477; x=1727356277;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dD+vF7VmxRugqVzyEsydLmIdMP99vP2j/3rSmzOsQ5c=;
 b=wPqcAMETC6NTMXRpQEiQdtul7cDRTepMeQiSqSxHkaSTjTeFeoqGprZNjgoIjLc3D8
 57Q0UOweJyXgoNIQ4WX6cCwtTku5gbYnHzjH9ac3YYaMx+ydoXwbjs/PNC/CK5LrFl74
 d3wtpcI0RmMENZIgiruPNNpuaPYhJu6PtH7epQ07ZGUWxirWMkkPQXyN/Ul7qqJWmXQt
 COJ/1Na5kyHi1T5Znf2XPeBGHV5mrWziiircnoBH8x40i8RqnnE4dgJSjti5uVpiNY2U
 ruzfCpILDlK1PKSDRYo9jRwhF51cCZRKZ3mFN+ABeSx9e8mFWJYCnyrkRfoPNzV7aFJv
 ptEA==
X-Gm-Message-State: AOJu0YwU9IPz1NXiBGkWERIUrGYzkVM2ErlrtNyYAziQokSQPrt30dRd
 9z7Q+QmstooqsOYONeZ/SRzubPrn8CQg21zHEXd46OGCG+GmAA05/FYJBptkNLteffHZum6kkKZ
 4
X-Google-Smtp-Source: AGHT+IGykG25rMmD/ty4iMP8Yb4UrSZjC7WOlcK3SpY4tf8Tp2jDfXLRJ3k8LWsCxxlRbDrmSPipnQ==
X-Received: by 2002:a2e:4e11:0:b0:2f3:b582:a914 with SMTP id
 38308e7fff4ca-2f791b5cf4amr100144841fa.41.1726751476597; 
 Thu, 19 Sep 2024 06:11:16 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42e754091d3sm21667845e9.10.2024.09.19.06.11.15
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Sep 2024 06:11:16 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 15/38] target/arm: Fix whitespace near gen_srshr64_i64
Date: Thu, 19 Sep 2024 14:10:43 +0100
Message-Id: <20240919131106.3362543-16-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240919131106.3362543-1-peter.maydell@linaro.org>
References: <20240919131106.3362543-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::230;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x230.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20240912024114.1097832-16-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/gengvec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/tcg/gengvec.c b/target/arm/tcg/gengvec.c
index 33c5084ea64..3abdc572022 100644
--- a/target/arm/tcg/gengvec.c
+++ b/target/arm/tcg/gengvec.c
@@ -304,7 +304,7 @@ void gen_srshr32_i32(TCGv_i32 d, TCGv_i32 a, int32_t sh)
     tcg_gen_add_i32(d, d, t);
 }
 
- void gen_srshr64_i64(TCGv_i64 d, TCGv_i64 a, int64_t sh)
+void gen_srshr64_i64(TCGv_i64 d, TCGv_i64 a, int64_t sh)
 {
     TCGv_i64 t = tcg_temp_new_i64();
 
-- 
2.34.1


