Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14024D1D885
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 15:48:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0jlH-00039A-48; Tue, 15 Oct 2024 11:47:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t0jki-0001Ij-Vw
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 11:46:29 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t0jkh-0000qq-AR
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 11:46:28 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-20cb89a4e4cso24755355ad.3
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2024 08:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729007185; x=1729611985; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WPZ3O54SfWAZW6QbB+o6pdTzqrBR+joOSB0w++8bQOE=;
 b=rC1Whf0i32nTidP7DBpmvre+0GG7GZSoOxE+BazDM0/seSH0iUTx3tVti4wB2/MWqT
 ZZOe/BHbNFK2OFSHIPHH7e0+NHY+fsKEnd1A6H/lNDR5HEMgt/+UcEgN8DMswKHNXZTY
 sfBCtHn6Gf9wQzh0/2n0Un3matLBCADSy3bZcGhJMbohfZufVGZiW4pShMk4HKdpVG7Q
 gmizJ59LD912ko97pukBVydgvRcu/2nQUvjts3NtzKzYiWprnxGajQoTh0hIuRmF9/ii
 4YCYM+aOAFpxMdixKeWrwvdPmIvKz0c1iml+lyCC3xbrFD6u1EP6kX0+BdUdESWrJcKB
 rUHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729007185; x=1729611985;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WPZ3O54SfWAZW6QbB+o6pdTzqrBR+joOSB0w++8bQOE=;
 b=WT+1Ob/piHgG8FnOGyN/Kle4+/Y//cCAZAFvuWL5fMEC05bc0UJ2m04qPqcDFdQxdR
 YE3uvcyhHM/ibFZoI93/yJGA0C+W3Fhp000rj++WKj+VkXQUYNbc+gZmU1zYtvwjI9Mm
 r3N+ZdSixMYw2NN2oM5UmtsdLH7v7ajS5vvFKqhrpTvYRKrkH3VgtrtSmMWlfHv3jC2R
 I/jjbZaAIGsvH6veaxOUEakGqqKBhALnwYu92SVeHu4MKoRPre0iyjrJNYa7IQJUWZx+
 9u5nIbQpFrHKkEjyNaNQlzGR1jtU/n5kMXzBsCnHdWfv/mDGZUfqZrcDAuXZ+0L/VxI3
 4uDA==
X-Gm-Message-State: AOJu0YzlIcbVw7F4bP7+c9ujx0LQe9QJWZEjlNjucXlKYYa8p67rjH7b
 HsD1WRUB/K/12BIK1k1s8r1dHFNTqpsblnG/I25rzzCk0hd0GriOOdu0O0U/LW1bXfgefNCHwEi
 A
X-Google-Smtp-Source: AGHT+IHNrH5aeLxab4iEA0Gx5smKxNHh95eveecRpONFnpmScd38jOAlZOvb67Qwpkr06672VLvCtA==
X-Received: by 2002:a17:902:d584:b0:20c:9d79:cf85 with SMTP id
 d9443c01a7336-20d27f2805fmr9244255ad.54.1729007185052; 
 Tue, 15 Oct 2024 08:46:25 -0700 (PDT)
Received: from localhost.localdomain ([45.176.88.167])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20d1806c6a9sm13489765ad.302.2024.10.15.08.46.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 15 Oct 2024 08:46:24 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 14/33] target/tricore: Use tcg_constant_tl() instead of
 tcg_gen_movi_tl()
Date: Tue, 15 Oct 2024 12:44:23 -0300
Message-ID: <20241015154443.71763-15-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241015154443.71763-1-philmd@linaro.org>
References: <20241015154443.71763-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=philmd@linaro.org; helo=mail-pl1-x62d.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Directly use tcg_constant_tl() for constant integer,
this save a call to tcg_gen_movi_tl().

Inspired-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20241004202621.4321-3-philmd@linaro.org>
---
 target/tricore/translate.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/target/tricore/translate.c b/target/tricore/translate.c
index a46a03e1fd8..4a12d2ca191 100644
--- a/target/tricore/translate.c
+++ b/target/tricore/translate.c
@@ -2732,8 +2732,7 @@ static inline void gen_insert(TCGv ret, TCGv r1, TCGv r2, TCGv width, TCGv pos)
     TCGv temp = tcg_temp_new();
     TCGv temp2 = tcg_temp_new();
 
-    tcg_gen_movi_tl(mask, 1);
-    tcg_gen_shl_tl(mask, mask, width);
+    tcg_gen_shl_tl(mask, tcg_constant_tl(1), width);
     tcg_gen_subi_tl(mask, mask, 1);
     tcg_gen_shl_tl(mask, mask, pos);
 
-- 
2.45.2


