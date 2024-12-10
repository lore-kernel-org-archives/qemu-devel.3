Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A44EBE7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 15:33:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tL29i-00071h-MC; Tue, 10 Dec 2024 10:28:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL29c-0006Pr-23
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 10:28:05 -0500
Received: from mail-ot1-x331.google.com ([2607:f8b0:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL29a-0000Jc-EN
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 10:28:03 -0500
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-71e163493efso22799a34.3
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2024 07:28:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733844481; x=1734449281; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=lDI/3EszdlfHW9G8ekets9xBkYRtBXLFL38K4nvEAbA=;
 b=kYogpjaPl/ZsqFO9uQTXjLIeST8q4fCClHZtzrLhSbQv8pd6k07xMQWEIEAEhR2Sq1
 pf8o/VGBIItLVP0kMMOZHSmjInbOMJDvm59+kFMl/UhJ42tFluJQ+UEntwo5m1w0VH7P
 fbt036/oVS4Eqt7AmNHHEhnwNENbzgdqPRVq1Hfo/KkdH9fwhAa4RkvcAFPvo1ubIGkm
 j/ZrTRnFLq23f8AE3fBzlWPUo90Emt6Y4p3mw0b12pUyss0ZH0nvMrNpKFqcFMS6DIC+
 t90aBD6i1fkVREBVza0QQ2jz3+v6qSmdUV+b4zKl1IUhwX+RNw+RGiZJICQUpKbSfd19
 12iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733844481; x=1734449281;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lDI/3EszdlfHW9G8ekets9xBkYRtBXLFL38K4nvEAbA=;
 b=SBshqPr3MolbOQ33SBxr6tQKrnao6AnjRPiLHtjp5ea1NNu3zyCn03mNLVU5ogLQVE
 xhQ7CHLa9Jo3HJU0zijmJrftGxSKS/a5GFjYA4C0p90uBYIcKC9rJD+pjjmjRsia0mge
 sMkT7HpD4JakeErv2XaTcWk+kqPPsY8JfqF+1Ok4gfGTp2XAcdi4GwOpv9GVCMrcH1Iu
 9t65vU/6eRBZanReRlGd/lnrEn3B7zuJFtCOq+za5F0ACmgtVqKQu8nKSRCyNRew8wuM
 +KEfxzukpaGlftrB9naRwF5mnefC3ACVUNsmf1KOmSNIKo4ND4asEhpK9scxTB3ycqx9
 B5lQ==
X-Gm-Message-State: AOJu0YygVvA1tgtwl0wkZOHfM454z2wU3UYgUdjRfsvAES0TpIheha2f
 m1XzJ6CNCGuUx6Erjlrn8SJTtRKyixigr6Ug2xkLvOKpEnNqNTveP/Xx62F636qJHzxxe16MyoR
 lD4FfLQAW
X-Gm-Gg: ASbGncvHolOskhPx/O79Xe2eSGH5NJqPqkj4edA2X+hqAzSGAPIVP1ZR/mqSmj881Jn
 p7dRmL/TS1nXNHlfxGMxUpfOtPJ9uwKeDPGySRY3paEU7ocR/9e+YatT6+kNrpc1InkbM1Hdx4L
 1amloXmX0zdE2ARYrmxXvh0AP6iB7XJQiXXvNw0PSdrjO8JjfyG+1MU4NvOvcs4t7nCPYrltfHr
 NO8wfBH6yuPrjPbu5Jyiks9ctkag/1k1YlS5vZgVKLLeyoU1qFpY/6Z0LhzSQ==
X-Google-Smtp-Source: AGHT+IH43qhOKP3Mqyui0/CibepsAomfmTPV9PVIuxONYCo70s+C7iCD7E5WeOSP7FO+6Lb6eMszyw==
X-Received: by 2002:a05:6830:65c2:b0:71d:ee65:7c38 with SMTP id
 46e09a7af769-71dee6581cbmr6580907a34.22.1733844480944; 
 Tue, 10 Dec 2024 07:28:00 -0800 (PST)
Received: from stoup.. ([187.217.227.247]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71dc4a0267esm2785955a34.52.2024.12.10.07.28.00
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Dec 2024 07:28:00 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 43/46] tcg/optimize: Use finish_folding as default in
 tcg_optimize
Date: Tue, 10 Dec 2024 09:23:58 -0600
Message-ID: <20241210152401.1823648-44-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241210152401.1823648-1-richard.henderson@linaro.org>
References: <20241210152401.1823648-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::331;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x331.google.com
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

All non-default cases now finish folding within each function.
Do the same with the default case and assert it is done after.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 24ec14f476..94e942e1cf 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -3085,11 +3085,9 @@ void tcg_optimize(TCGContext *s)
             done = true;
             break;
         default:
+            done = finish_folding(&ctx, op);
             break;
         }
-
-        if (!done) {
-            finish_folding(&ctx, op);
-        }
+        tcg_debug_assert(done);
     }
 }
-- 
2.43.0


