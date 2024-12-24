Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81779E7718E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Dec 2024 20:07:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQBAb-0003YU-LW; Tue, 24 Dec 2024 15:06:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tQBA3-0002ok-1T
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 15:05:47 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tQBA0-0002a0-S6
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 15:05:46 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-216426b0865so55668565ad.0
 for <qemu-devel@nongnu.org>; Tue, 24 Dec 2024 12:05:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735070742; x=1735675542; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QpM1VqzEizRAO5S933D2pTQEw1V6cPopLqjkgjzXZkM=;
 b=YEBRN/AlCXpPLkL6xDfw2zQmd/eSk+cbYpFBLQt68HcmYAW7dP04ozrawc/0Xqo8nl
 7WWZdo4/n4stHTQdApxOxvVXJtvvU3i0o55Io/Odz4iAbuLSvqi9akvd/9rZVgsiqFMh
 xx/t7Upd3Li0HnDbGgt/Yhkr8yE80jL5zq518mfZWPKlKUdUQ/QP6S29/3eciL4Z9HMV
 Vv+YR0rtbzX0gToIcvjDmYu/O+qKdft21D7BFuNVnf9lGrlKksByBW9Ird8Dqafe4Vfw
 0p5sWpsXocmPTaso3Ambt2xQwqGS2ZI4affDNY97lap/DgGfDK5g2dE/I05ihllnlC4u
 0jLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735070742; x=1735675542;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QpM1VqzEizRAO5S933D2pTQEw1V6cPopLqjkgjzXZkM=;
 b=pV/P1Vmwxq31kO1wB3zTZEyYHW/enG63jzvlJXUjexzeZVGO319v0wj4Zf3nAw4mCb
 gQQN3Qt8ezfBMQvEgGafafkjKiNuBOspQePAwTePRckb7Tv++qef1qbyFLIdRThPUrpm
 iX/UYAsSzJ3xqRIHysv5PS4wcPS+5Z5beucUyTcwkECZL43XNW6Mp8R5nO2XfqWtYCK7
 FnMjmSnFgyjV8N4APEYJVywMW5WpQOs0toDZc19BM3fdwJPPxQjHQ9JvkuAWY0et+mDm
 GiSXkEpogbrgLwJuvw5V8FgBDh0NcXwEe4JfANWngWoalD0Zoi6BFkWbK+M8ggVLwP5V
 ka3w==
X-Gm-Message-State: AOJu0YxlOwEuJEPA24ZrWOyeNOa+4pI1ojSS7hky86gC+ysgVEXBTm2y
 zqPHHCsg4b3fyXQ9Otm5DnHc6M2nUdd/flnXnpFYje1OQzLp5f6ozcQ5vvUnYZhJBkt/JD3b2Us
 PC7E=
X-Gm-Gg: ASbGnctTUJ2OhzFUGHDO44T6osXLqf5y+Gf0LptPSZiKnO7G6RpRc+cpJJ+u0xwERjv
 PhN3fGY4KnDP+XEW868tbz6z8UUjLeUsxesc0fZsZGvT/rCfE2HQ4BzPRCE66mFc7V7xBKLtYc4
 fc2INMv9syA+LKg9vTTSYr/G3AnL6UYUZmIBHiPCcvQG/F0Gt/KnCZwisAdsxZACMjZTY3TThBc
 YocoxvyCW+uSBwJsZZqb2aHP3vSRsUymJNcFN0rlF0JHP2B0r+I0oYvAAKIYsdA5O0kuJDBGC0X
 RR+QVcznNjHfrAmNDpn6ioDzIg==
X-Google-Smtp-Source: AGHT+IGxtQETXxvCEhak7u4e50AcxRPQmV/GhVfvDbQ1BL5UhxDex2XjxJ5ab5ZC6UKMGnVUao0H/Q==
X-Received: by 2002:a05:6a00:4ac5:b0:725:f18a:da52 with SMTP id
 d2e1a72fcca58-72abdd3c1d4mr27143519b3a.4.1735070742443; 
 Tue, 24 Dec 2024 12:05:42 -0800 (PST)
Received: from stoup.. (syn-156-019-246-023.biz.spectrum.com. [156.19.246.23])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad8fb895sm10027159b3a.162.2024.12.24.12.05.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Dec 2024 12:05:42 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 21/72] tcg/optimize: Use fold_masks_z in fold_extract
Date: Tue, 24 Dec 2024 12:04:30 -0800
Message-ID: <20241224200521.310066-22-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241224200521.310066-1-richard.henderson@linaro.org>
References: <20241224200521.310066-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

Avoid the use of the OptContext slots.  Find TempOptInfo once.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index f948cc48c9..8111c120af 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1739,25 +1739,22 @@ static bool fold_eqv(OptContext *ctx, TCGOp *op)
 static bool fold_extract(OptContext *ctx, TCGOp *op)
 {
     uint64_t z_mask_old, z_mask;
+    TempOptInfo *t1 = arg_info(op->args[1]);
     int pos = op->args[2];
     int len = op->args[3];
 
-    if (arg_is_const(op->args[1])) {
-        uint64_t t;
-
-        t = arg_info(op->args[1])->val;
-        t = extract64(t, pos, len);
-        return tcg_opt_gen_movi(ctx, op, op->args[0], t);
+    if (ti_is_const(t1)) {
+        return tcg_opt_gen_movi(ctx, op, op->args[0],
+                                extract64(ti_const_val(t1), pos, len));
     }
 
-    z_mask_old = arg_info(op->args[1])->z_mask;
+    z_mask_old = t1->z_mask;
     z_mask = extract64(z_mask_old, pos, len);
     if (pos == 0 && fold_affected_mask(ctx, op, z_mask_old ^ z_mask)) {
         return true;
     }
-    ctx->z_mask = z_mask;
 
-    return fold_masks(ctx, op);
+    return fold_masks_z(ctx, op, z_mask);
 }
 
 static bool fold_extract2(OptContext *ctx, TCGOp *op)
-- 
2.43.0


