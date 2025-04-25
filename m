Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5A5FC369D3
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 15:34:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8L2o-0001Cs-II; Fri, 25 Apr 2025 11:32:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u8L2e-0000j1-Mh
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 11:32:41 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u8L2c-0004BW-Vt
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 11:32:40 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-39ee682e0ddso1558511f8f.1
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 08:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745595157; x=1746199957; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rvDHJU1UOeR53jCA4eCatusxWWLU+33hruvcuMV01ik=;
 b=RJm98sH0aKupMb6SSN9HeE1CBxa/HqjAOEofLX6a/PIMl9VLYI61xF4XB5k2P9zC53
 yUokvReff6yfUePLbkx+Vr/embwMsXbaEPgQCnHhoYQwLsgRBwZifQqC8FOyN5hh3bQ5
 ddF0rD+ddgWAq2sqcHEsyvrIIN1FoxlzSkmG9/vwiugDfPCTEPr+HrqKTYiYuHaUz3jc
 K94bnwz5geaend1oH94AnMEDCIfbtMlO3YlZny47xN1khaWbNXSb3S91LeVQnsB2FwYH
 mKpXOzWhYvcJJ5pxLDoz1kTA6SbJrT+0DkOCyWm4kmti0WuP3IIa05AEaMha4VX69JvS
 krwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745595157; x=1746199957;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rvDHJU1UOeR53jCA4eCatusxWWLU+33hruvcuMV01ik=;
 b=J9VCGJBFDbx8iF83v1AaMsDdO7hLJT42evI6WSvZjiykhBopc0mGAIt0i5bimo38MJ
 nkG/ME2dGaL+zlooG25iGUdyRCrJQHIi2LgMHYRc7WxuW1JFtXrNd5AsebxWcXWT5fx3
 j7DIEAWqiMjPxpByZo6xMXB/K7tF6aSBAQI84ttM8NoQ6qJtVEA96UcA4O9TUfATu5gm
 xWdMmmzhTAyqEuPl18t1dmTOngmX4gSnZ69WOe1pd9vc/07DFfTm4Nd6KaIeol3UburH
 Un46ujjz5UfFs5or4Wnd9Ki2N0k06L40Jcl+KES5tYen95zfiePsW9zoHSs9yukElN1O
 6ByA==
X-Gm-Message-State: AOJu0YzXhIDU5rebCdiNc9+RHiQf2ug1mdsiaY1ZLLjR3wrj41Y5CQF2
 oaVhZL9+sXs4/PoN67NMxzchEpydfSW05EiCFZ+opeGezWj75Jlf4OFdcQ+lIPxDuwZsMm3rmNW
 1
X-Gm-Gg: ASbGnctMojJM8Su5A9SEm7OFLWm3bhUAOCmk3eo9AdncQv854dX6ENHbM0mFMV04F8I
 KXnXXA6T4Eq+leUFY48t/QIjWGyetaBLAlYwloUTsXiRXoW4t4Bfx4Ko2DnPWweS+9trmQ0CWcH
 lb0ryAxYzC5f0TBet9RVU+Y32Kcm/Isf0JdEhXmzUpmmUkcr627aNAHruuYUzenoLSz6m/MNzaI
 k8nWzIW+oTPBwUA1y0dbekXA9gV/mf7r+AQ5BwnQ7hXFr3LsdjhH/M24kahfvfYbpordotc8nQk
 CXW1jUDf+M7kHMsXh/qxDAF4zmSZYCb9JFAjR5UrmwTkFFWjlAUoq2R6jG1o72M1IU39ftNZYCL
 Vwf3rMRyImCJh1MI=
X-Google-Smtp-Source: AGHT+IGPT4qSY+rN3N6uoHMJFatRmGXWuJWKUARUu/TFX2PDFbyhKiTklTuStNJLyD4yMTmIEY2Utw==
X-Received: by 2002:a05:6000:1844:b0:39e:e217:28c0 with SMTP id
 ffacd0b85a97d-3a074e0fb35mr2402272f8f.10.1745595157003; 
 Fri, 25 Apr 2025 08:32:37 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073e5d479sm2729337f8f.92.2025.04.25.08.32.36
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 25 Apr 2025 08:32:36 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 47/58] target/xtensa: Evaluate TARGET_BIG_ENDIAN at compile time
Date: Fri, 25 Apr 2025 17:28:31 +0200
Message-ID: <20250425152843.69638-48-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250425152843.69638-1-philmd@linaro.org>
References: <20250425152843.69638-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

Rather than evaluating TARGET_BIG_ENDIAN at preprocessing
time via #ifdef'ry, do it in C at compile time

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20250417131004.47205-6-philmd@linaro.org>
---
 target/xtensa/translate.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/target/xtensa/translate.c b/target/xtensa/translate.c
index 5ebd4a512c9..2af83c07c2e 100644
--- a/target/xtensa/translate.c
+++ b/target/xtensa/translate.c
@@ -1395,11 +1395,11 @@ static void translate_bbi(DisasContext *dc, const OpcodeArg arg[],
                           const uint32_t par[])
 {
     TCGv_i32 tmp = tcg_temp_new_i32();
-#if TARGET_BIG_ENDIAN
-    tcg_gen_andi_i32(tmp, arg[0].in, 0x80000000u >> arg[1].imm);
-#else
-    tcg_gen_andi_i32(tmp, arg[0].in, 0x00000001u << arg[1].imm);
-#endif
+    if (TARGET_BIG_ENDIAN) {
+        tcg_gen_andi_i32(tmp, arg[0].in, 0x80000000u >> arg[1].imm);
+    } else {
+        tcg_gen_andi_i32(tmp, arg[0].in, 0x00000001u << arg[1].imm);
+    }
     gen_brcondi(dc, par[0], tmp, 0, arg[2].imm);
 }
 
-- 
2.47.1


