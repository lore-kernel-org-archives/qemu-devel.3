Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56E67C021AD
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2025 17:09:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkR5S-0006XJ-9t; Tue, 18 Feb 2025 12:08:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tkR5Q-0006WT-K8
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 12:08:44 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tkR5P-000680-13
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 12:08:44 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-221057b6ac4so55930215ad.2
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2025 09:08:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739898521; x=1740503321; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=3K22+YVskyblSXAB4oUB8qk58s8rMjdxRxPhzIex0rc=;
 b=QifGozvef9pUlRW+yetzUkVPt1qtDIaIN9hT72zXYrYu2hXqglc1lub6kcNwgymF9/
 cSE+nahzyjp9FluIz23AIupM8PYdjyn7nT+oAMDM/ZqnRbXsLEZgoO7BGvqiZjSU6PMh
 Ps1vjrUOZgIxstHvDD0LXfBfU+N0DDwqQ7hJ9YyN64QzqLy6EHNpYM8mcRbYUDMfxkTm
 twkJGbG8IDe57bxxWfSw8aD79PBk77MS1YQhkO+d4taQMQK7eJG6l8LZZlR9efdRXUOJ
 sJK3m6PjOmi83UqYZJlUJ5QFQvMILA7++tL4Ys/h051QLIIIMU2kWhtd42taz5JWBnvM
 3feg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739898521; x=1740503321;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3K22+YVskyblSXAB4oUB8qk58s8rMjdxRxPhzIex0rc=;
 b=BtANtExVto1hOFIl4OKVTvqRcY9JAACS2Fo2xg8c/2c66CHR6Z/KBr4Pqp9SNmnRl8
 Pq+/JaXTB/rFzBAocNdWiu5NyHovMb3VyYfNp27sN3+UmHfV6l17cgIHG2kWykUe+i0f
 bILnNPHzPHJvAwQ3G76Qz5siP5w477drkLVgo7zmty9PGrv21jOXpH+ylPANipbaUb7q
 cCKbAkCuW35Jc+zMLwXaQlvwnoD7iHfjxgCeEUcMy9RAt/GYil/Oe/QkwUZB8knPAYO+
 pcEXIvuOYXjwRaGOyhI4zg4GKSdkmxusQ1/gflLKxrNYLLh528mWeVC1eQ0pOoO4c8Pp
 8vMQ==
X-Gm-Message-State: AOJu0YwhB3GLxP4QFkZHN4gzMZPRCBLROU2RHHtj/kO50dV0LsO5kDQ5
 /YS/lr6e5Iu0PJbK+JpODKS4LdyqOXyEKOKkZ0HgqUbGE60VURasvIHosZfwqayvYGf9wfFrT4j
 W
X-Gm-Gg: ASbGncvl501F8TMNjkWPwK921t5yvdmCXET1ZdT2IhAaV/KwB7cp5H+x1bdEdgxzAli
 VQfY5v9cFjHn7GPsybr+OsYienozdxmr8IC6GNSvOSj41ELie7I4mij5EdCPptK3JaAUr7eTyAl
 oBHzNB0ehzr98+/7hC+dmdMuEP5/8cngfOosUB0JwkK2dyscdIHPG+WOtE42WtjMThAjl+AqD9Q
 ecp739B3+G6sxhO1RW0JUf90aCcY+kRc1s4O+Kfvc1D/XfxahJsAIhOmiCTkJ6JEA15uXcnmb1x
 QBggipBIB37q0D4CMk21s07KTe4SCruuOUFi3qjhFTpOVkg=
X-Google-Smtp-Source: AGHT+IHQmKdeK7qkCmDqfi7oIoWu78MspEnjfq1lH0D1JtXxRAzW8t6ux9KYZZPOTGSWWpwtzrePFQ==
X-Received: by 2002:a17:902:e88d:b0:215:bb50:6a05 with SMTP id
 d9443c01a7336-22103efc0c7mr226848015ad.9.1739898521463; 
 Tue, 18 Feb 2025 09:08:41 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d5585faasm91917875ad.225.2025.02.18.09.08.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Feb 2025 09:08:41 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 13/28] target/mips: Use VADDR_PRIx for logging pc_next
Date: Tue, 18 Feb 2025 09:08:39 -0800
Message-ID: <20250218170839.81501-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250218170839.81501-1-richard.henderson@linaro.org>
References: <20250218170839.81501-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

DisasContextBase.pc_next has type vaddr; use the correct log format.

Fixes: 85c19af63e7 ("include/exec: Use vaddr in DisasContextBase for virtual addresses")
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/mips/tcg/octeon_translate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
index e25c4cbaa0..d9eb43716e 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -18,8 +18,8 @@ static bool trans_BBIT(DisasContext *ctx, arg_BBIT *a)
     TCGv p;
 
     if (ctx->hflags & MIPS_HFLAG_BMASK) {
-        LOG_DISAS("Branch in delay / forbidden slot at PC 0x"
-                  TARGET_FMT_lx "\n", ctx->base.pc_next);
+        LOG_DISAS("Branch in delay / forbidden slot at PC 0x%" VADDR_PRIx "\n",
+                  ctx->base.pc_next);
         generate_exception_end(ctx, EXCP_RI);
         return true;
     }
-- 
2.43.0


