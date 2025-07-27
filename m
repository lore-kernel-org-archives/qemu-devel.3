Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B17BDC87FCC
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Jul 2025 08:19:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufwRi-0004fG-Ry; Sun, 27 Jul 2025 04:09:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ufwPf-00039h-2u
 for qemu-devel@nongnu.org; Sun, 27 Jul 2025 04:07:19 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ufwPd-0004q9-3K
 for qemu-devel@nongnu.org; Sun, 27 Jul 2025 04:07:18 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-237311f5a54so28276225ad.2
 for <qemu-devel@nongnu.org>; Sun, 27 Jul 2025 01:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753603635; x=1754208435; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gIx4SJW5J1RoTFpdEMgpD6LEdku6UeK6pLsBjwXWXNo=;
 b=YduySLf9ZW9JR5lD0IxivZS+Ep/17O3Yj3Ip1WG+De0+zjTZyZZaVveENBLs5tRd0Q
 cGyPoMAoHLd5e89SrTa/Pio3veDMhbHnGp8SYBe6yMwfkOpfQtIfKRK0gTSJlH9eo3Hr
 +cv54nUQhI2q77Gg+VLgOL5ZsAMkT2RQ5oKVmIc+dfmP5bb0g2Pkk5GMJ/M85/DscRWd
 N4/R5VwwBaoknRgmKWPxn0zZ+5O38khQ3R/3Q1gmOnvUEjATHHAg7OZrUe4lc87xHpcL
 lQkM88gHfzFowjDTDF+IMoDS6I/keF8+O7Aa9PbDx+J4WD5N2xsjKpK2t0mbGjboCaEX
 mORg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753603635; x=1754208435;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gIx4SJW5J1RoTFpdEMgpD6LEdku6UeK6pLsBjwXWXNo=;
 b=bars68lJGuU0XkuklLfe09Xx3TL9bGuoMfuqZo571T4Fu8kkYP9eMUjo8DJX4VuSLR
 k/+NKHyW2EKLdbBJNmdNh+Eudd+qM3oPZFxef6GH2vKFMet0GljgWA+3m8lwlcW9jwS5
 L/Or2MOdAKIUBAVx60U8jp4pEs47bPrJegw30f4AXL3omR2MfHhdCaVnxbzTf+zkiPOq
 C587rWSzaNGlwhyjdBuR9Ab9lDA7XWQn6mBSf4CwNMeX1sRhWWW575lobUN1FwNnoQPs
 fc1xSjKm2fu/7WoshjUcfNieI6UY5JXoM98z0g8hM9zGuNTsYkRUQWrX+qcXBjtK/CsF
 cjsw==
X-Gm-Message-State: AOJu0Yy8W6E3+CO4GQEn70yyB1Hmsz24qp0jJ+fPpAaHzJ0m29eGVCIw
 ktyZzay1pbvLzPunkYOqHlkDNxD0DLPzxzn6hpwePWLhCTr50vk2PlsPtMIEfwR4C29M6rewU9m
 nLvDb
X-Gm-Gg: ASbGnctlE9KJ3wCQy8k2i3LRZFbWjjJC4nWNF59yQvdoB7uBP1dR7XVoIcIM8Dr0cso
 k56IQERUDvfGXL929OIfnx/Chlcv/oixQYJO7dwMuxpmHYhl9UWpvZcBYZGEvjtNOiTNcVcnBVq
 s4NEVodHJ2OLkWEwlEY0IuBTNPDJJIQziHUIgDI+WAll9juiQIqNtpqfM1bFTzcv5BroDm2wcqk
 yaoYHADUeUSCjEWn8agXrSfUZJPvb+6wX64MwTRk4BW1+nMQKogfSXcq/6VCM8nuT8rJdmVg+z9
 G+oEmc6Jz9AkAw3Tc5SsEdBjf3AoVJoVfzC4FWBoNesxogERgwlzTTbsb7I/A4qRhYp/KAevuVL
 PHmowTCeugL3ytkRhzvijJjQXdISpixlaKulCF8QYnJA+GIOzznFc/eIqdZ+FCJAq+IGi+mqYJu
 J4BTqGqsXi8w==
X-Google-Smtp-Source: AGHT+IGzoSI76uclgP4CqGdNrsMo8Qo/wReLVP3GIu8OH5J9u3/hOjlkb8ZnmvGfvdE6Lsz0FOA/1Q==
X-Received: by 2002:a17:902:dacd:b0:234:a734:4ab1 with SMTP id
 d9443c01a7336-23fb307cde0mr126460925ad.3.1753603634680; 
 Sun, 27 Jul 2025 01:07:14 -0700 (PDT)
Received: from localhost.localdomain (syn-098-150-199-049.res.spectrum.com.
 [98.150.199.49]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-24011d5bcbesm3908065ad.10.2025.07.27.01.07.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Jul 2025 01:07:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 64/82] target/arm: Add gcs record for BLR
Date: Sat, 26 Jul 2025 22:02:36 -1000
Message-ID: <20250727080254.83840-65-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250727080254.83840-1-richard.henderson@linaro.org>
References: <20250727080254.83840-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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
 target/arm/tcg/translate-a64.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 6fd3032613..4c3cc3d943 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -1771,15 +1771,15 @@ static bool trans_BR(DisasContext *s, arg_r *a)
 
 static bool trans_BLR(DisasContext *s, arg_r *a)
 {
-    TCGv_i64 dst = cpu_reg(s, a->rn);
-    TCGv_i64 lr = cpu_reg(s, 30);
-    if (dst == lr) {
-        TCGv_i64 tmp = tcg_temp_new_i64();
-        tcg_gen_mov_i64(tmp, dst);
-        dst = tmp;
+    TCGv_i64 link = tcg_temp_new_i64();
+
+    gen_pc_plus_diff(s, link, 4);
+    if (s->gcs_en) {
+        gen_add_gcs_record(s, link);
     }
-    gen_pc_plus_diff(s, lr, curr_insn_len(s));
-    gen_a64_set_pc(s, dst);
+    gen_a64_set_pc(s, cpu_reg(s, a->rn));
+    tcg_gen_mov_i64(cpu_reg(s, 30), link);
+
     set_btype_for_blr(s);
     s->base.is_jmp = DISAS_JUMP;
     return true;
-- 
2.43.0


