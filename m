Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7759C88E59
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2026 10:36:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5L5M-0002Xg-7u; Sat, 12 Sep 2026 06:35:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5L4v-0008OH-TL
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 06:35:26 -0400
Received: from mail-pz2-x16.google.com ([2607:f8b0:4864:3b::16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5L4p-00087z-7O
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 06:35:23 -0400
Received: by mail-pz2-x16.google.com with SMTP id
 41be03b00d2f7-cc4bdf8abaaso798335a12.2
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2026 03:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789209312; x=1789814112; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=5OH+ftdL6EWEe+MJJ1Z9BwINTcNGJFazqZu6cvfVV74=;
 b=m9y3Qvuyg0d18gWMUp+s/609l9Ba4QySEIVkL/z556Z7XpVLxFC6QosToCesf1lRrd
 lsN6hFfoici1ei9FbIv2DwFT/RcxaQNzWUdxxO++GFowpHMhA1c7mdJSd6zu1IN6sWyI
 dWEGnwML6Wpjq+T6VYwMDFTMwB4zokSxwmXIt5y8L7ZsvBD03xpIff8MiNFxgZL8RYxT
 zZkN6aGo5fk0Q27cYuf79juUXGns33mAAWS91HvLcxQKtrODqyfQLKz0/aQZuLTk/ihM
 VSaQg7V0mojcro213WVjvcA7Dkc2vdyvF9CJBMneNQWAj2agmGw66cYOn2yqY2Dvq8pE
 ZfOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789209312; x=1789814112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=5OH+ftdL6EWEe+MJJ1Z9BwINTcNGJFazqZu6cvfVV74=;
 b=Q2Ao/1QaF5Bnw52+BB14EFe31cp05Han0Q+lJPheW7m9puNkj/0ERA+/K6r2VhiTC2
 quwoJvvnI+Cd4ri6khs2VtvD3FfyV42VM4LI6H4uadVsr+D1zixvHYTaHIhlq+JS7fh8
 YhaR4KXxULVVKxCLRBMrZPWVyGg9nqJ8B1qLcND0tC8YTKOrSL6PieLOdQGuXQoPJWyC
 tLzePgcHxVuj6PM2Xkmb0IeB36VmBO8qol5u6MB3jqe2Tq9WdqKk+bCTZyRSaeDYw4x7
 s4mMcPddolMdw4wWwLQKMRY1h6Np++v5URPCWtPtfMUjSFeySvJcV4pYVkaH1lvtmkQc
 FdzQ==
X-Gm-Message-State: AFuF++kE243HffKuY2Qkn8syNKJPB//+fce9vcqrLrvxNH5u4uubmyLc
 /c+h6LqHu6b7GdtqWdB8PC3UkWyLnm5qVlU4pB7p9b2caPfbovMlL3QyGM6OgzxHuAVsdEEGrmV
 fzbj8q7o=
X-Gm-Gg: AYBFou3hL6tx+a62vMutmmiZGyKF+BfNoNh/qmbyAtetQ3x8OVwPBRuR7WQDUIYKliq
 O5vwIz8IsM+k/JoWzxUN7F9q3xdpR1csdISXEW6O+CWAe+X1E6TGFAi16PdSK1AIJMWXEhjJ2uH
 eGRathf4P0pnCCemA9uKGuj75j7/T634TR/6PfZpIXdH+qH2aABUi/wfsFvQZFQFD1s1PAdlNva
 t8JQKbeTJ62X5j74bCR4UCY0cpKdP/RaejM13bXa5/mVnnTtAFYdYDf5ptJ0NSptlceDv0Fm6gl
 wsOGGkWzBKxAeCgi6y90ePyYIy0swcjZ014/jTwAIjiAd9a9WnR6Puw5iQtVQPN7tBKbanffrhR
 Rm+NHZL2BPz0T0lIHJTUjMPvZvHkQejrH7W266vbFD28+GNFkFm8R+4y5+9lOiz2JajJGU2gw/M
 K0b/N2SIt8jKJK8Ymv5Ttxeimh/mYexnroG9guqL6Zf91MwOj9bBwhLF5IW61mhjhfJTXDV88Ro
 nvWfz2i
X-Received: by 2002:a05:6a20:cf85:b0:3d3:aec2:4dce with SMTP id
 adf61e73a8af0-3daed3ff609mr15230933637.26.1789209311645; 
 Sat, 12 Sep 2026 03:35:11 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:bf2d:a6f5:e308:cd27])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33ba4f55735sm13673674eec.24.2026.09.12.03.35.10
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 03:35:11 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 44/82] tcg: Split out gen_extrl_i64_i32
Date: Sat, 12 Sep 2026 00:30:48 -1000
Message-ID: <20260912103126.598030-45-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260912103126.598030-1-richard.henderson@linaro.org>
References: <20260912103126.598030-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::16;
 envelope-from=richard.henderson@linaro.org; helo=mail-pz2-x16.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

We'll need this for other generic expansions.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg-op.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 6145a171665..f3b1ee1fe43 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -366,6 +366,8 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo)
 #undef DEF_CRRI
 #undef DEF_CRRRRR
 
+static void gen_extrl_i64_i32(TCGTemp *dst, TCGTemp *src);
+
 /*
  * Generic expansions for templated operations.
  * We have used compiler type checks to ensure all operands
@@ -492,6 +494,11 @@ static void gen_eqv(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
     }
 }
 
+static void gen_extrl_i64_i32(TCGTemp *dst, TCGTemp *src)
+{
+    gen_op_tt(INDEX_op_extrl_i64_i32, TCG_TYPE_I32, dst, src);
+}
+
 static void gen_mov(TCGType type, TCGTemp *dst, TCGTemp *src)
 {
     if (src != dst) {
@@ -2293,8 +2300,7 @@ void tcg_gen_abs_i64(TCGv_i64 ret, TCGv_i64 a)
 
 void tcg_gen_extrl_i64_i32(TCGv_i32 ret, TCGv_i64 arg)
 {
-    tcg_gen_op2(INDEX_op_extrl_i64_i32, TCG_TYPE_I32,
-                tcgv_i32_arg(ret), tcgv_i64_arg(arg));
+    gen_extrl_i64_i32(tcgv_i32_temp(ret), tcgv_i64_temp(arg));
 }
 
 void tcg_gen_extrh_i64_i32(TCGv_i32 ret, TCGv_i64 arg)
-- 
2.53.0


