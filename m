Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC3EDC87FD3
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Aug 2025 00:17:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiLsP-0004ge-SY; Sat, 02 Aug 2025 19:42:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLnv-0005Xz-Ob
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:38:22 -0400
Received: from mail-ot1-x32a.google.com ([2607:f8b0:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLnt-0006H4-9S
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:38:18 -0400
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-741b1657dd8so52596a34.2
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 16:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754177896; x=1754782696; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=btTy/xuxxPZif0L5vFjFow988XjxZLXwQbU1+T1I7Ec=;
 b=YL68KsBGMzX8ZDDJnOCwod7eUatVB3/vyaRMQ1AKAmgK8ZdNY+jcoAfzdUT4rVOQI0
 +B2SNAmW/n5IMFRWrWSmOk+bigatVth5tiW/fcy+q6vT/ObKNPadbLe1teDa8poK0r67
 A3DedF73j5pnh7+cqymd8OezRFg1iVc1L1/t1Z0zeEqe2euvRfH6Veuq+rlvuW8UcrQI
 j/JU7bPcN3MBHO473lO3FCga6U1iYjETPg4QCLnmZ2x4pLlnFY8GDdkIlvL72iMYN1GV
 AsV6hhDnXTiJiNtNd1GjIDyGtbHFbwYw19FGIkH2UY2ZpP7PkFoGsX1fxg8jGc7oTYe4
 0eiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754177896; x=1754782696;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=btTy/xuxxPZif0L5vFjFow988XjxZLXwQbU1+T1I7Ec=;
 b=kf4yqOgQZ3Wu26spNxsI7KrePKfb+dFyFtokliKHx/3WJSw1CWwVfra7AiuR1558rW
 KjFKQPdHDgGujx6ptHRWrcpjBhDCEy4IOyRVpw75ajsDuPscuygX+boAkeTbZJPc6PFZ
 h+bKEBStCRjJB0tj7MmsQPMGW+kJNOFnEF37cjCO4sIWJH3nDb9hWOtZ8vaq9yGJV2EI
 mgV1XY6w2osaW5CZrngTD14TgqRKdMx8EFCREeLsVHovc0cf9RP59ojn64cgY6R24x1U
 OXvhAXwzEpaQ1gznJTgCNjJ8dRPL9+ZUgRLh1C1rSEjUYS2bXnq3roEfWUXr55+jHukQ
 pZAQ==
X-Gm-Message-State: AOJu0YygWPRfK3Sxc5FQHw405l6AmkRhd/9H+5v74wI8u/1EJREhSgd8
 y8dWSWVmIFoGNItE1oCVTWfiSB7ozDSTwZuDFxzYF96SDzcSD4dVdVoDqTTnMkPmUKNea6YZWXI
 8kj7lltw=
X-Gm-Gg: ASbGnctWSs2C7JNwTgbdFQcpnAMw3qki6dyYs3diAVwrdS7vX8lqfvUcebnizcd2Hs+
 GT+flZpBKHtc0r3jm5uNCnx0TFwg0oY36U/NQLlsovTv6+ua+Po78yPlAHbS3rDh2yFM0eAyY0H
 zTDkDo8xvFCTaGQHK5fmANCIyY/L5qghrhOW4lpzlq0PVKiW7ib6bajfebGDTrQ3R9EmAAfjSOB
 VRpiimMGgev9njz09gL5nKzBtZlLECb/58QVyHAOR9064OQVkVekV1YAYeSlnyCnUWTYKpwsgSQ
 /MH2TWrVwfaDDyI1PQTFbYQ+6XloqdGazqhg/3eDBYNEmmUii7m/I8ViqCGyMaIge2kdRKi8Ok5
 6tYhSEdoCmhUSO19T7GGmpxOqR8u3j6ZyJyTGLvS05mwRB71zhGRJ
X-Google-Smtp-Source: AGHT+IFfW/VOhELQyAK1RRVMLp33MerZKerr1BG7dgrViRqJqs2qb0/KKsthf7RfPQU7kkF1k+DyBA==
X-Received: by 2002:a05:6830:3345:b0:741:a4a2:88bc with SMTP id
 46e09a7af769-741a4a28c5bmr1527662a34.8.1754177896186; 
 Sat, 02 Aug 2025 16:38:16 -0700 (PDT)
Received: from stoup.. ([172.58.111.133]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-741a71dc78asm380409a34.30.2025.08.02.16.38.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Aug 2025 16:38:15 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 66/85] target/arm: Add gcs record for BL
Date: Sun,  3 Aug 2025 09:29:34 +1000
Message-ID: <20250802232953.413294-67-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250802232953.413294-1-richard.henderson@linaro.org>
References: <20250802232953.413294-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32a;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32a.google.com
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 88fe5ac4ef..6fd3032613 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -1667,7 +1667,14 @@ static bool trans_B(DisasContext *s, arg_i *a)
 
 static bool trans_BL(DisasContext *s, arg_i *a)
 {
-    gen_pc_plus_diff(s, cpu_reg(s, 30), curr_insn_len(s));
+    TCGv_i64 link = tcg_temp_new_i64();
+
+    gen_pc_plus_diff(s, link, 4);
+    if (s->gcs_en) {
+        gen_add_gcs_record(s, link);
+    }
+    tcg_gen_mov_i64(cpu_reg(s, 30), link);
+
     reset_btype(s);
     gen_goto_tb(s, 0, a->imm);
     return true;
-- 
2.43.0


