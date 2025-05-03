Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E933C369C2
	for <qemu-devel@archiver.kernel.org>; Sat,  3 May 2025 21:27:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBKOB-00050h-QL; Sat, 03 May 2025 17:27:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uBKO9-0004zy-El
 for qemu-devel@nongnu.org; Sat, 03 May 2025 17:27:13 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uBKO7-0006gO-Ls
 for qemu-devel@nongnu.org; Sat, 03 May 2025 17:27:13 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-af908bb32fdso2880999a12.1
 for <qemu-devel@nongnu.org>; Sat, 03 May 2025 14:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746307629; x=1746912429; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=dpD2X/N2/eUTIVGHaEd0dhhaplJWtNKEoeYbSNFy2KA=;
 b=kJ5ogs2f+rDeX7zMvFHqdKU4BJwPgHEsmHN0lANTTlvetxmXD5ySc8R+RFU/1XzYB3
 pwZgs9Ju9PtTOD25h1eB7GeR6eJppDv4YaxstC/pR+tyy+bL9pZ5ZZERvth2rVjECcIs
 0PAGOwP9l07oI5YoB97alzAIObr2+OWtIUKY71R6Bej6LqaMgw8rxB8q1X5ioyYzRBLB
 LpBFjyiiCs0/t2Z2wFOmDHKfacvZbFMd9i03b48OjILzPF4kHQe9jN0jvgVJ8GVvkpdq
 9UyI1vlezGB3ZW6g0/iNR1rlnSu4bemZIWbNTooGuRPds42g3312tkc+NOf2mf5GBBLc
 lWuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746307629; x=1746912429;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dpD2X/N2/eUTIVGHaEd0dhhaplJWtNKEoeYbSNFy2KA=;
 b=k/omfSN/KtFFrfewrXZe7nvm157QKentLTaepb6MPWxieiR97r6lz4fZuG+aFX4EsI
 mHKERGFrDvzhJbjYTpITwrO1ZYqLlyZjaxJ39akoYP1OZBkIqIlvPiw46R9KTOV9wBV/
 xr68ge6jlB9i3UH77jldeBQnJwP0XmsSo3QIUnB83341IbP3O16K4u5T3+mDqTeZLAK4
 XGytnKkKRtKchVMElt+oCRsG7jamASBAtyAhWTJGF/CZOFB6YwTvThAJkDlZwt65kzHG
 qnTCXZ9C7acOMCd/g5JZBkuCPmGIVtAJNza7Gxz8eN6p2DU7sSGnfTOeQCKW4e4Uvmke
 KS9g==
X-Gm-Message-State: AOJu0YwYF77AegciG3j+ANNKqduUV/FCt/n9XJOnaOQ/7qLrAzIh4WQ0
 NZIs+bWnUeWnM755jV3BL4LIS8bmlD+uv+oFTm8xoDyUfKk6z1LrkNYjzb3Zhk/WxtdvvlZ93eO
 O
X-Gm-Gg: ASbGncscfov4jl6PXaPZcGjBGgcqAQyHUFOva0bsxcjaP+ADtqtDTSHYfejnqBmQhm8
 3UqE3ruC9PrBaftOIDQtEi48YZAjaZqzO7Td29mOfegmXOR3ykbO1UdN6wE4vUOIiCrxGJqWinS
 CEKlgjVmZqJ4YIeuf0GS1hDWyiNrocae8IgoccfL94XQ3VmtJK5saw8O2OFR7Upilu1cnQcrUKB
 K+JUTtyQqzmNKfBe1rC+pCrETXTbVaxnofAvl7iXCHnUdXIoaOe4nB6QfFStH0zJC5lerB0Rgk1
 v8kV8NfJ2NYwKz2F11dcVS8VvXLRrEdbWlUcL0KXYZuCGbsQi0vXY5GmhBfqTGwKisJHebhbTfU
 =
X-Google-Smtp-Source: AGHT+IHUl/mXDKAKQfb3QXVWkK5mPun9gAU4KJHVj4nRRoG5FDX6ufHB3zc2dQRMjhB9KRzQbKqI0Q==
X-Received: by 2002:a17:902:d486:b0:21f:40de:ae4e with SMTP id
 d9443c01a7336-22e100563eemr104409825ad.9.1746307629354; 
 Sat, 03 May 2025 14:27:09 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e1521fa1csm28334885ad.133.2025.05.03.14.27.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 May 2025 14:27:08 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: ysato@users.sourceforge.jp
Subject: [PATCH] target/sh4: Use MO_ALIGN for system UNALIGN()
Date: Sat,  3 May 2025 14:27:08 -0700
Message-ID: <20250503212708.3235806-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52f.google.com
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

This should have been done before removing TARGET_ALIGNED_ONLY,
as we did for hppa and alpha.

Fixes: 8244189419f9 ("target/sh4: Remove TARGET_ALIGNED_ONLY")
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sh4/translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index bf8828fce8..70fd13aa3f 100644
--- a/target/sh4/translate.c
+++ b/target/sh4/translate.c
@@ -54,7 +54,7 @@ typedef struct DisasContext {
 #define UNALIGN(C)   (ctx->tbflags & TB_FLAG_UNALIGN ? MO_UNALN : MO_ALIGN)
 #else
 #define IS_USER(ctx) (!(ctx->tbflags & (1u << SR_MD)))
-#define UNALIGN(C)   0
+#define UNALIGN(C)   MO_ALIGN
 #endif
 
 /* Target-specific values for ctx->base.is_jmp.  */
-- 
2.43.0


