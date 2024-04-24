Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1C43C4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 00:02:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzmY0-0008Ju-42; Wed, 24 Apr 2024 20:01:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzmXf-0008B4-Ft
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 20:00:50 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzmXa-0006Em-Ea
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 20:00:44 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1e2b137d666so3042815ad.2
 for <qemu-devel@nongnu.org>; Wed, 24 Apr 2024 17:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714003241; x=1714608041; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ETyNm16Mbl8pyV+lmUKhskc+EtUa8GiG+D+R1+wQrtM=;
 b=KIq13KE/WMBUKz2d0jqL9tAP+1KxbEB1foMTHiV3GPbVaFGR6SJEyikbakK3MyxPiI
 vKhAXvjRyZ1Ay6A60K5otjXaLm5Ax+ucboxjOU8fd42npB+NYTgITNSaH2hfvJuhMAXe
 m2ra52SUF2PXmTUT28LnTzpR4mk4xE902q/EdCXnpvSYrm58CFpN1g310dgB2xB5LfXb
 jY8irXR3TlZa2F+w3ZenK2uOj0tGWAcNStxxLjzsTx/1ASkHwcLK5IilbMoapIXZLDno
 TEYDXLggxzsDgaNn+/WTi4MHnz3H/bqFYClINHQLqWLlOIZV3XsgCzuOf+0XjHpsg6Yn
 lBjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714003241; x=1714608041;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ETyNm16Mbl8pyV+lmUKhskc+EtUa8GiG+D+R1+wQrtM=;
 b=vCaejrMEvWAzYXPy9hg+6bbxaNgZndmZ9rdVfYrtRxuqaX3aA8xD2BHuY2DR60cwkT
 8kNnbffHIXFjABDxs5OtEMYY9pbkWFmTnKKv0q5yiBAu/iSe3rzCKeiojGQv1Q/xMHPn
 NqUmEC9AV2OBrexiulMDtCmz8d6jZrdFyt9Ob2lPaH7RhIKCQ4uJqI/3uLxE/XXjVCJJ
 Y2les1UWKCRVCp3tq44DrmErtZAobgcu0CfgXuto58JsGEQg43f6jHjOjbir+gEh7NVx
 +U8l6umSsAa74g7K+iRMuNxsinwWfzWkVIwSXkLlTNKiv+3C9qpZ9+3XZc+EQmh+ZHkI
 6+sw==
X-Gm-Message-State: AOJu0Yy26lThQh0y0s+ltuerm0XcyZZjXpgV3WD7nwYpR/G4OKQUOV+G
 fWDV5lywTC9ZwqtZMBgRrCrUN6suKQ+miA0f+NS58lu8FcEulExb7u0pZC+2vZCOAb844JwBZI7
 2
X-Google-Smtp-Source: AGHT+IFPiGgIwXUkXD/JmEkYlFVn2Q5YTSKWrFojx3y82PL0EBr7wtwpliwZW9KlKHjmzJfl3NRZ6A==
X-Received: by 2002:a17:902:d2c1:b0:1e7:e7ed:7787 with SMTP id
 n1-20020a170902d2c100b001e7e7ed7787mr4970299plc.51.1714003241021; 
 Wed, 24 Apr 2024 17:00:41 -0700 (PDT)
Received: from stoup.. ([156.19.246.23]) by smtp.gmail.com with ESMTPSA id
 t6-20020a170902e84600b001e604438791sm12465715plg.156.2024.04.24.17.00.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Apr 2024 17:00:40 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 16/45] target/hppa: Always make a copy in do_ibranch_priv
Date: Wed, 24 Apr 2024 16:59:54 -0700
Message-Id: <20240425000023.1002026-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240425000023.1002026-1-richard.henderson@linaro.org>
References: <20240425000023.1002026-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

This simplifies callers, which might otherwise have
to make another copy.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 7e01c21141..dd5193cb6a 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -1966,18 +1966,17 @@ static bool do_ibranch(DisasContext *ctx, TCGv_i64 dest, TCGv_i64 dspc,
  */
 static TCGv_i64 do_ibranch_priv(DisasContext *ctx, TCGv_i64 offset)
 {
-    TCGv_i64 dest;
+    TCGv_i64 dest = tcg_temp_new_i64();
     switch (ctx->privilege) {
     case 0:
         /* Privilege 0 is maximum and is allowed to decrease.  */
-        return offset;
+        tcg_gen_mov_i64(dest, offset);
+        break;
     case 3:
         /* Privilege 3 is minimum and is never allowed to increase.  */
-        dest = tcg_temp_new_i64();
         tcg_gen_ori_i64(dest, offset, 3);
         break;
     default:
-        dest = tcg_temp_new_i64();
         tcg_gen_andi_i64(dest, offset, -4);
         tcg_gen_ori_i64(dest, dest, ctx->privilege);
         tcg_gen_umax_i64(dest, dest, offset);
-- 
2.34.1


