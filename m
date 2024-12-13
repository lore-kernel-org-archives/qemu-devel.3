Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D8FEE7717F
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 19:21:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMBB7-00052Z-Oy; Fri, 13 Dec 2024 14:18:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMB8I-0008Oa-5U
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 14:15:28 -0500
Received: from mail-qv1-xf31.google.com ([2607:f8b0:4864:20::f31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMB8E-0007ui-AS
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 14:15:24 -0500
Received: by mail-qv1-xf31.google.com with SMTP id
 6a1803df08f44-6d933736380so26020256d6.1
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 11:15:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734117321; x=1734722121; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UCjhN6iwuQ2rffzzVRP2QP4VKFREVJfEhQs1/EOJunM=;
 b=on+JCN112Y9YAwvxcCpUlgfrk2k4pTf1q0CGRF+VnRSTEIFIbKHyevQiNRpaddORiP
 7YiruaTYglgcOBJO0i+J7UaDNt6Q1hAzJ3VrxolmBdB1fthAIYXM8aVoUikyy+RjrJIK
 qXH3x0peiKIS9SjLLxXegQOU6kMhXBa6CyIMXo8cTwBzvTcm/zTszI4MZzG/+Wm/SicW
 hXrwF/9cGy3Yj+MtOmmGyQ6P/oqVY5jRlVIQ1ZghwojyVkLfNsy0/y15dF5nRxdb2vRg
 Blsi1aXVjAxz1tOHYORSXXulJZSzLw+3JkXs9cagGgzcfEEEm0ATJV6RGPUHQQv5UNf9
 5NRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734117321; x=1734722121;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UCjhN6iwuQ2rffzzVRP2QP4VKFREVJfEhQs1/EOJunM=;
 b=AGqL2re6qOTKeg7+z75hDjYSLEFBgjmOdhqODjNex5L7LchtpJFRre31uXmen1YRZm
 YcUNTOLKb4+Klgx/sJTrp2wqwEHot9Q7Jv9V9E/bxs9ePFRKJADNUzOG0JS/qEodkuOw
 zZYN8VqDspvWr+65YTx0QPzdHX8XkqvXUFxy4EcL7zAugX/HRA8Oy/72vC9FxUNeryPJ
 c7KS8ZKXlJX+/lP3GscaDP5THTvqlIexZrq0llduyjfVpXCRhGa3YWzWxHexARce8eJ9
 ZNZnXxzmuCsjFKaw0QwcScXQcS0ft3Ks5GGSTWe6FZ1A5Shnulf0BkUbAc4NHCciCAoF
 rSFg==
X-Gm-Message-State: AOJu0Yx+a+Vh8RjfDkw7e82WmrX2S8K/W5//UqCt1IgCqRsUxnxKtq3w
 edkpez7HfEOpttxlRJZr5d4xJJUq+H8e0zIZDxOUhaqki8QwlcXMemFnOb0UGN6e7MLdrWGxCkH
 6+TCXVOTC
X-Gm-Gg: ASbGncvA+kJcfHozK3ZtylRQfIcP4wYlTffQEnHN0+w5y2lFeHmamNVUhnhZRLbilAd
 NWCS1XJRLAwE1FCB/fVuhqx2CusEZE+ENSE2DR9gSDju5J+2EvJlFJIK0xi4FcECRAMEtxCtX27
 gVl6k0CEfQbdD7LQmGIWRXWvAW0A6WuDFjru7rVE8SjqMfQGgGFu4dj7OaR6WotO1y5hmR/FmUe
 ABmYv7Nnm9G/eKyT2VmCf8WxdheYzR3NAubCkbinF1lm0DMDPXL3E7OjNAynqqH
X-Google-Smtp-Source: AGHT+IGZLLdhYYhKvDrVvCvILw0plyZ5TnmAbjmLlFyKPJze97puJLgEtZCRggCd6qSIURiHCd1Ocw==
X-Received: by 2002:a05:6871:b2c:b0:29e:3132:5897 with SMTP id
 586e51a60fabf-2a3ac537883mr2057944fac.5.1734116887415; 
 Fri, 13 Dec 2024 11:08:07 -0800 (PST)
Received: from stoup.. ([187.217.227.247]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71e4834da91sm29697a34.18.2024.12.13.11.08.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Dec 2024 11:08:07 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Brian Cain <bcain@oss.qualcomm.com>
Subject: [PATCH 03/71] target/hexagon: Constify all Property
Date: Fri, 13 Dec 2024 13:06:36 -0600
Message-ID: <20241213190750.2513964-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241213190750.2513964-1-richard.henderson@linaro.org>
References: <20241213190750.2513964-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f31;
 envelope-from=richard.henderson@linaro.org; helo=mail-qv1-xf31.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hexagon/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
index c9aa9408ec..a70007245e 100644
--- a/target/hexagon/cpu.c
+++ b/target/hexagon/cpu.c
@@ -48,7 +48,7 @@ static ObjectClass *hexagon_cpu_class_by_name(const char *cpu_model)
     return oc;
 }
 
-static Property hexagon_cpu_properties[] = {
+static const Property hexagon_cpu_properties[] = {
     DEFINE_PROP_BOOL("lldb-compat", HexagonCPU, lldb_compat, false),
     DEFINE_PROP_UNSIGNED("lldb-stack-adjust", HexagonCPU, lldb_stack_adjust, 0,
                          qdev_prop_uint32, target_ulong),
-- 
2.43.0


