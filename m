Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01573C3601A
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Apr 2025 23:52:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0UJt-0000f2-9q; Thu, 03 Apr 2025 19:50:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0UJs-0000ej-9Y
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 19:50:00 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0UJq-0000TG-Fz
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 19:49:59 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-43cf05f0c3eso9179015e9.0
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 16:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743724196; x=1744328996; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mgkLDZ47lJdUOfhv84ZtqSryce3s2ehUhrQmnYvG1gU=;
 b=B18YblHoc7coTxxKHryrzOKiQgh4vH5mhZsCBRbYJuT6gsfBNFyXs4HiW0ZjAfmMJu
 PjYA9SRM+060r+uf79T2WpR44hbHR06pVlSdoPCj9n6cluRJqk5ZCuezlKZIBBSY+9sF
 FC9GA6gYN0hUJhnyJgiyTNACjaV0buynTlR11pGCkR8Fm5JhyK5PVsS/0zdvAivkpCmy
 iv2tJdlZgPpp4iHXtSRTXVpD2Ye4yuu1vQ4PbqmTvUBxoV0Qn9fjDiAAu5KUfU8ijGFN
 5onTVY8UqUiPCVtXXLjxufWX8FSarSHtwjYZ38sinIP5T+vvL7TkSsulJKfD8geNb8J+
 mlTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743724196; x=1744328996;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mgkLDZ47lJdUOfhv84ZtqSryce3s2ehUhrQmnYvG1gU=;
 b=LWPPXESRZWo9yHsr6ckh6lZp+2t95LhLKz1How5qVbGTSSJtLPauLozTNYMDeGXfB7
 lsZQ34TYhTuJuqVpbdB6Lk4d5QtFuXdCDsH7bY1BiI6cAQXYjaApEFWlY1170Kh3onQ1
 LJW4b9/DxJtS2uU693Ab+ZtasZzy0uxUWVx4CysQITPZTbkHzwek/E6rgbP6KvBGEc8W
 SV4GKwVHPZEYNyfAvx/UKljISIY1LDYM2vv2Vyk8cb+jSf0vB7XZ+Jb5UNRktGb3lv+d
 hfAch6nzYqi3MSBW5vN4o1Nu1ePdDbt7BvIchb5m5blFV6uo3mYZ2z7JW7jvCgGNu8BL
 kblA==
X-Gm-Message-State: AOJu0YxUcO4uDjsxxycmi/V/Zq0H0jzdahJqz45b5Y8DdiJK1cuhlUMD
 A97Xvvsf/P/aZnF6sgaIvqn4HrBnLcP2AY5qKceHyy5H/26KQNyZFTV7syQNcS9zVywCiMQ9wYZ
 x
X-Gm-Gg: ASbGncu+BbB7xIHbsVarOtyxbqImxAxezrwWqnNbk0DtyZyYv4npSrPGBQ5iKHrZJ+j
 WS1mSAeaS1lU+cppZxu7257x4ErSRK4JVz/hTbACPWYqduFVoz2EY1s1RdDFXhTeAsE+SuiE18k
 KkJe9MG/3PlBKf8SVr4RMp8eiL5WbXSHZ+A4czT13CeKdpac7/cxhiB3A4XD20fxyAzqQxFTN1Y
 1fLoxBUQyG/iujLFrZyzhJbrcH9Q9BAbvB1GuJnEBAlfIwQEOSC+6/GVdT4sTTLN9Uhe/2QEedL
 HWl9E2YjnWrtTQrkZd5VwvE8oQK8D5Ik5Ezy3Gn3h2Y3QKgnLFXz8xWrUuYCFA1nuBgVgS8NypX
 7+2SvR9TVpqa1KS6hdgs=
X-Google-Smtp-Source: AGHT+IGQaRD6bk+aKugk47ByDk+zkSEEaCeKRFLhA+IN/wEQ5NSkMDnoj6DDZaPsPOSUs+1vJPPeng==
X-Received: by 2002:a05:600c:3b13:b0:43c:f050:fed3 with SMTP id
 5b1f17b1804b1-43ed0bde8a8mr4685965e9.11.1743724196405; 
 Thu, 03 Apr 2025 16:49:56 -0700 (PDT)
Received: from localhost.localdomain (184.170.88.92.rev.sfr.net.
 [92.88.170.184]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec147c9dbsm35295975e9.0.2025.04.03.16.49.55
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Apr 2025 16:49:55 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [RFC PATCH-for-10.1 06/19] target/tricore: Replace TARGET_LONG_BITS
 -> target_long_bits()
Date: Fri,  4 Apr 2025 01:49:01 +0200
Message-ID: <20250403234914.9154-7-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250403234914.9154-1-philmd@linaro.org>
References: <20250403234914.9154-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/tricore/translate.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/target/tricore/translate.c b/target/tricore/translate.c
index 7cd26d8eaba..ad959f3b0a1 100644
--- a/target/tricore/translate.c
+++ b/target/tricore/translate.c
@@ -24,6 +24,7 @@
 #include "tcg/tcg-op.h"
 #include "accel/tcg/cpu-ldst.h"
 #include "qemu/qemu-print.h"
+#include "qemu/target_info.h"
 
 #include "exec/helper-proto.h"
 #include "exec/helper-gen.h"
@@ -5922,6 +5923,7 @@ static void decode_rr_logical_shift(DisasContext *ctx)
 {
     uint32_t op2;
     int r3, r2, r1;
+    unsigned long_bits = target_long_bits();
 
     r3 = MASK_OP_RR_D(ctx->opcode);
     r2 = MASK_OP_RR_S2(ctx->opcode);
@@ -5937,7 +5939,7 @@ static void decode_rr_logical_shift(DisasContext *ctx)
         break;
     case OPC2_32_RR_CLO:
         tcg_gen_not_tl(cpu_gpr_d[r3], cpu_gpr_d[r1]);
-        tcg_gen_clzi_tl(cpu_gpr_d[r3], cpu_gpr_d[r3], TARGET_LONG_BITS);
+        tcg_gen_clzi_tl(cpu_gpr_d[r3], cpu_gpr_d[r3], long_bits);
         break;
     case OPC2_32_RR_CLO_H:
         gen_helper_clo_h(cpu_gpr_d[r3], cpu_gpr_d[r1]);
@@ -5949,7 +5951,7 @@ static void decode_rr_logical_shift(DisasContext *ctx)
         gen_helper_cls_h(cpu_gpr_d[r3], cpu_gpr_d[r1]);
         break;
     case OPC2_32_RR_CLZ:
-        tcg_gen_clzi_tl(cpu_gpr_d[r3], cpu_gpr_d[r1], TARGET_LONG_BITS);
+        tcg_gen_clzi_tl(cpu_gpr_d[r3], cpu_gpr_d[r1], long_bits);
         break;
     case OPC2_32_RR_CLZ_H:
         gen_helper_clz_h(cpu_gpr_d[r3], cpu_gpr_d[r1]);
-- 
2.47.1


