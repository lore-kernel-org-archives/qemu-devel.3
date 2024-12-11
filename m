Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABDEBE7717D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 16:25:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLPST-0000wX-VY; Wed, 11 Dec 2024 11:21:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tLPSR-0000md-Py
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:21:03 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tLPSQ-0007oR-79
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:21:03 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4361dc6322fso5904925e9.3
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 08:21:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733934061; x=1734538861; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=CCObb/UU4fUvkP8uNIWpNMWZoNgBU5AdL8ALELaxgBI=;
 b=wqooi2zhqE3Yh1iivZaouwgpxTQNYr8xNHCdRDiMH2UwV6B7M11xhuTifE9Z6Y6NbM
 PqLOdmS8Ek6DiuDzbOcTaFcRHGZv9pYBBLkKcRCUTnnC6cFaxq0vdXUv4dRLeuUIo1vt
 4Ir5L06OSv/KrkmYq2K0nknRLl6VP+Kf1CH0YLYmXIbGMdNdwCC6KxTisHx3Ut+WDtaw
 1U7vxu7RguZo7xSRUxgfDrgTMaMRJlI7q85Y/xY1jsRX/+34j7iDzJKpoxHjsJoQmfGY
 T2sMYY3LXJ9NhdLYAymDouQMmCCtQ0nbQA72VQjctSHYAD2qT8jdnU53UMZk8NCFpNpQ
 ROig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733934061; x=1734538861;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CCObb/UU4fUvkP8uNIWpNMWZoNgBU5AdL8ALELaxgBI=;
 b=MbdfZkZM8NzG3AF07iADMjvV9CcVvidGqNUPB0GAjVs5aBkleDxhgZLUtD/GdUKFnW
 6z9tzXPtCYHQj4ZCTjyfkPC6nb4Kb2nSLF2rMzSKvexX5x1EI3JCo6d0saSVTsa0IhUp
 GG6WfY80RAjf5uLtXQA9/DWgCA6PcNSuAvQXkQmCbLPRi57PJtsjaK//pm33Wy538Wfw
 zQ6Fwy8bOl9Xl0MQhXxstDJfbccoV0wHCNayTzFxWVS2VRrQIe1eT3C7zaZre1mQ2X7Z
 ZBOHNrMW0LLVYPx2+tczNVcu56rLbH2TEp1m1IIpINTj0T8JKSnvCPMHvr93qo180UXY
 gDBA==
X-Gm-Message-State: AOJu0YwRy1hX7zvoVvm4BpEsqi4Fq5DbOI6MGlG018rEzfu7BYGUK6AD
 KMNbKgsN9zjLUu+R2QBIdA0zxuKv5Hg7dYCYGB0ozzUTqMIqdwZpGS2e9rp4JyNN5UZJxIKZiJ5
 f
X-Gm-Gg: ASbGncskRQYAwUBYsov3EEum5yKsGS+662XT54ySty7oY8yD3bKhrC4rxlR7ZPoU309
 3YRPOjDv2t6MoDKi8zP/1YpfB0DegwylnGjad7f3VUD1Rhh5jEvH29obzUqpI/8WKafjNZcsMGk
 14qQpBN/1Wd9IGI2Fz3VKnDSG9MkvwVTJ+pkPhnnXRTltWRY/GKLNBDVNmRFPo2nfw07nVI6hfh
 5qfUEgDfwkKrcmtHdNXCSM7IoDloQeyp2JT/WW2+Z5DxR2YxLXwfJCoQ3LJ
X-Google-Smtp-Source: AGHT+IEyHXd0OoHMwMKJ5998KjNjdvlGHORV0UMxv4sDXyuNj02SMCxNvbeWvqfp0yyt//iINNNUew==
X-Received: by 2002:a05:600c:b86:b0:434:f2f4:4c07 with SMTP id
 5b1f17b1804b1-4361c373f5fmr30240815e9.15.1733934060860; 
 Wed, 11 Dec 2024 08:21:00 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434f4dfdcdfsm121460595e9.39.2024.12.11.08.20.59
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 08:20:59 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 47/72] target/loongarch: Set default NaN pattern explicitly
Date: Wed, 11 Dec 2024 16:19:39 +0000
Message-Id: <20241211162004.2795499-48-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241211162004.2795499-1-peter.maydell@linaro.org>
References: <20241211162004.2795499-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
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

Set the default NaN pattern explicitly for loongarch.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20241202131347.498124-42-peter.maydell@linaro.org
---
 target/loongarch/tcg/fpu_helper.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/loongarch/tcg/fpu_helper.c b/target/loongarch/tcg/fpu_helper.c
index aea5e0fe5e6..a83acf64b08 100644
--- a/target/loongarch/tcg/fpu_helper.c
+++ b/target/loongarch/tcg/fpu_helper.c
@@ -38,6 +38,8 @@ void restore_fp_status(CPULoongArchState *env)
      */
     set_float_infzeronan_rule(float_infzeronan_dnan_never, &env->fp_status);
     set_float_3nan_prop_rule(float_3nan_prop_s_cab, &env->fp_status);
+    /* Default NaN: sign bit clear, msb frac bit set */
+    set_float_default_nan_pattern(0b01000000, &env->fp_status);
 }
 
 int ieee_ex_to_loongarch(int xcpt)
-- 
2.34.1


