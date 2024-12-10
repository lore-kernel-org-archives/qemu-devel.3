Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6706CE7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 16:19:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tL2xP-0003n4-MP; Tue, 10 Dec 2024 11:19:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL2xC-00035u-Ay
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 11:19:19 -0500
Received: from mail-lf1-x130.google.com ([2a00:1450:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL2xA-0006UB-HD
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 11:19:17 -0500
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-54021daa6cbso1929698e87.0
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2024 08:19:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733847555; x=1734452355; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q83e90ulUVLQbtHavUT3vQ1rYdZ/bzv60n0aSWIs0jE=;
 b=ycJ/NGjrBCStnRUG+hkJ8WQqVUNPfHsyufSMgqOmc+5FP01tNhUlN4Xm+4IgPX+33M
 4acRW/A9ocIorcyVaNvlvlYYQoUGx646Wb/RGXBTbvS0kv/YXCUV+AB37Ce1pjb3Wa/y
 zYchIufcrPmjfULn0BNv7/5vs3qBxpUBDHD8UUNd2qxi1EjiVvP6/g55PoQx7f6e796B
 XgKdP0ZI0E+jAiZ8DQdPYdDYPvGMisofJLu1xw2swdSzQSSCcBogGopeCRi6HSrS2yTy
 eZt+TsRKjGEa521Cu999epPIfOBdVKlNvb4pcHojI+SoBPaG514SZWrhiXsUflU4109o
 jzuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733847555; x=1734452355;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=q83e90ulUVLQbtHavUT3vQ1rYdZ/bzv60n0aSWIs0jE=;
 b=P1PljuC8SlGsqZWBjzEb2s63JPX/UlJyRWuPBPxR4gX0FhELW+uigReuF1gCUJm029
 N5VvVEmR4ICrFwzGyCT+v6EbCQj+hehSe5/Rg7bZth3qy6vd8JPdLVcbFKR/rRUxFzQH
 jgJEd4x+TjFtY8z+Arz35pbmy0GAdcx/4dsxcMJy0hFHBrR9Q6XyXPbF748FzgYHQriE
 fGTjEA7zI/9VYMdbpySOwgz2j12x4+MRcxqv8kaL1Td9dONtmjxNLtZCDC0v/lTJ3ImV
 IRM6nHCIbfSycLecfbkQUy1WlL7cLWOYOK5Nygeqo4nYO7UOYbC09qR78VJMSigwLdA9
 gsow==
X-Gm-Message-State: AOJu0YxPSJwn+gqwoqMtkN7CJ+ne77mGPMfet0NnQ3N0cG2BWY6cRpka
 X+1/iuYltOequ2KTmQs2m0au8FZAR8gFsHBoT7K2QxZagALk7eUgE7b2M0bYEZOmuUgkDXLjZvz
 swS8cEzgs
X-Gm-Gg: ASbGncvLpl8RWX8FXWPZ4hbD1UmViaQkmijox8VAfhvQb2HO8dZ0xciUjzK/Yzi5jvk
 a8HtRIaZXQc0BwnBeILRTL6DAaSoA8v8QtwAaVyubsPdZja/VZhJWObhpURPDVE1wu8LeX7l13N
 r1K/bP+8qMc7a1JqgHq9Z0RCVio2F+HCegQYZws9xNvXkA+VbpVVcaLVyjJqDbWs+zx/atq3bV+
 FnaeSP9QPojKJ7eghXl1CXy67Ih3kk8yxBL+Ks+j1imxxbR9IQ6ZsIIJlU=
X-Google-Smtp-Source: AGHT+IGr1/c34XFZ1Fj2wIZquHAz4VlxpxMuzyKmnrXpwavgZNDjfnUiV9Jknfb0KZx6sPtKihzHeQ==
X-Received: by 2002:a05:6512:3b29:b0:540:1c18:4e23 with SMTP id
 2adb3069b0e04-5402410f8f3mr2275741e87.47.1733847554763; 
 Tue, 10 Dec 2024 08:19:14 -0800 (PST)
Received: from stoup.. ([91.209.212.80]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-53f93377eefsm1026343e87.67.2024.12.10.08.19.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Dec 2024 08:19:13 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 23/69] target/arm: Fix decode of fp16 vector fabs, fneg
Date: Tue, 10 Dec 2024 10:16:47 -0600
Message-ID: <20241210161733.1830573-24-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241210161733.1830573-1-richard.henderson@linaro.org>
References: <20241210161733.1830573-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::130;
 envelope-from=richard.henderson@linaro.org; helo=mail-lf1-x130.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

These opcodes are only supported as vector operations,
not as advsimd scalar.  Set only_in_vector, and remove
the unreachable implementation of scalar fneg.

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index a99f3d0d13..f67360c4c5 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -10816,6 +10816,7 @@ static void disas_simd_two_reg_misc_fp16(DisasContext *s, uint32_t insn)
         break;
     case 0x2f: /* FABS */
     case 0x6f: /* FNEG */
+        only_in_vector = true;
         need_fpst = false;
         break;
     case 0x7d: /* FRSQRTE */
@@ -10877,9 +10878,6 @@ static void disas_simd_two_reg_misc_fp16(DisasContext *s, uint32_t insn)
         case 0x7b: /* FCVTZU */
             gen_helper_advsimd_f16touinth(tcg_res, tcg_op, tcg_fpstatus);
             break;
-        case 0x6f: /* FNEG */
-            tcg_gen_xori_i32(tcg_res, tcg_op, 0x8000);
-            break;
         case 0x7d: /* FRSQRTE */
             gen_helper_rsqrte_f16(tcg_res, tcg_op, tcg_fpstatus);
             break;
-- 
2.43.0


