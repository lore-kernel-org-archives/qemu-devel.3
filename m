Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99A19C48286
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Feb 2024 21:43:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWkEy-000277-6r; Sun, 04 Feb 2024 16:41:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rWkEw-000267-C4
 for qemu-devel@nongnu.org; Sun, 04 Feb 2024 16:41:26 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rWkEu-0003Wk-Ri
 for qemu-devel@nongnu.org; Sun, 04 Feb 2024 16:41:26 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1d958e0d73dso19351635ad.1
 for <qemu-devel@nongnu.org>; Sun, 04 Feb 2024 13:41:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707082883; x=1707687683; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Mppe2/7nayBXlypsR6xMk/9OKA8uIp/hf0zJVbJSgnk=;
 b=QrBqKVJuFlBzRqgz/UF3XyZ7jYEH7N9K3r3pzZL1/iR/ffTvACmJi7y9PgFqbo5y9J
 hnwCQioDmql1P6hx10a4fT55wp4FRf/yht8PvP9ECYAzvCE+tj7eO+0Hzpe8OlVnk1is
 Bx3A/HUFSlPme8y23Ih8SqXwR2ATOwD92Bj0xrn3DDCPeavDSYRytsZPFcCwrA7EcHlO
 qHkVamgrpWz60ec3eBG5GEtAsj48xfVjSg/RONAD4f7vy0mAmOJX9LDe7Xf0cksaN0v0
 R25wDcIfjNz2ZRZ4OLhCA5gnzZ5qbOdSLeggjBn2d1X1apcieXuHWwYnRxY8gicdVBv4
 BKow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707082883; x=1707687683;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Mppe2/7nayBXlypsR6xMk/9OKA8uIp/hf0zJVbJSgnk=;
 b=tp1hJI8//TvrtBwwSs+bU6Tp3zVpJIZKrpnBoIlbYlz/dyAasvLV6ax69F3re7mLuU
 W8AK5Q5xXJm53o7NilGXDwAZXZXhHqHCWNuj1NtrrlKs03FGsB9rYm7AuMMF4ULTZQst
 KjKaHBgZvcOwKDhurX9dNr3LNKyYPeSNe9YAn+ddYKs+ypDGpfe8Ou1E2pnigyiE8uj0
 34+2l17bULHW2AiaHPnIfY/kc9U+YjTgtnB9ro6JSfmTMLxB48HWa0qIo9PmuQa1K/M3
 DrE6fat52SxLepVRIjQ5MZana2PixO2j8dKrm+nZoDcmA9Er4wg3HrVzlEAQYviZHqPb
 ipaA==
X-Gm-Message-State: AOJu0YwM8OvvhyzR5Dkg3FONzgPYSNdmvPL/TKIm7yvlWRcE3JP3Xu6A
 pryNPo0aOt4K0JtVjl3hQ5RKsDs+1cMs3SGFi536ZWL6xbnMbHOY6ZfXwr63c4RSfJvielQTaJy
 c2gE=
X-Google-Smtp-Source: AGHT+IE4YHFAqSWva9tMDmT2JERJYBJBV5WfR9AS61htQuXII9uyLhzWpwgFQr2SXM2sx6bx0Orwvg==
X-Received: by 2002:a17:902:e752:b0:1d7:57e1:5202 with SMTP id
 p18-20020a170902e75200b001d757e15202mr6877929plf.20.1707082883626; 
 Sun, 04 Feb 2024 13:41:23 -0800 (PST)
Received: from stoup.. ([43.252.112.156]) by smtp.gmail.com with ESMTPSA id
 mf11-20020a170902fc8b00b001d8f5560503sm4953670plb.222.2024.02.04.13.41.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Feb 2024 13:41:23 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 13/39] target/sparc: Use TCG_COND_TSTEQ in gen_op_mulscc
Date: Mon,  5 Feb 2024 07:40:26 +1000
Message-Id: <20240204214052.5639-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240204214052.5639-1-richard.henderson@linaro.org>
References: <20240204214052.5639-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/translate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 7df6f83b13..d9304a5bc4 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -488,6 +488,7 @@ static void gen_op_subccc(TCGv dst, TCGv src1, TCGv src2)
 static void gen_op_mulscc(TCGv dst, TCGv src1, TCGv src2)
 {
     TCGv zero = tcg_constant_tl(0);
+    TCGv one = tcg_constant_tl(1);
     TCGv t_src1 = tcg_temp_new();
     TCGv t_src2 = tcg_temp_new();
     TCGv t0 = tcg_temp_new();
@@ -499,8 +500,7 @@ static void gen_op_mulscc(TCGv dst, TCGv src1, TCGv src2)
      * if (!(env->y & 1))
      *   src2 = 0;
      */
-    tcg_gen_andi_tl(t0, cpu_y, 0x1);
-    tcg_gen_movcond_tl(TCG_COND_EQ, t_src2, t0, zero, zero, t_src2);
+    tcg_gen_movcond_tl(TCG_COND_TSTEQ, t_src2, cpu_y, one, zero, t_src2);
 
     /*
      * b2 = src1 & 1;
-- 
2.34.1


