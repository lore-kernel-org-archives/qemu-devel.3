Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BEA8CD4F3D
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 19:27:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPmYp-0002yj-2l; Wed, 20 May 2026 15:26:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPmYk-0002Wl-Uy
 for qemu-devel@nongnu.org; Wed, 20 May 2026 15:26:27 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPmYi-0002cc-Q7
 for qemu-devel@nongnu.org; Wed, 20 May 2026 15:26:26 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-488d2079582so50989205e9.2
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 12:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779305183; x=1779909983; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=+IShrOJdoAnXhE6bNJkPoCD2JYelB8KnTrT0I3ViK0Q=;
 b=Bd2SGz2ED+vCEDlg7BkfvT1+A1ShzEsmf4BEniKcqieN/jwcYy/6bd0TVFKNRpbIMy
 HVmqvo11YaqwwKw7iv+x4zYaCwUDCOpqgMQBQTh1Jna/qzGtq/LuOfR9wVzk6tp4Ug1p
 H2EObrW9EQMTPZfPEfBHUib8vEqOIrTjICCQ/z2cBFZBBsFVqDk6proLLiXSpn/jYqw/
 YV1UVwmuew1SuCdHhZjUesc+7J+BEku3JvtHZpUt2a1NVxPN81EJVjOsA5r4aBc6ud6k
 Q0c/KlCxzht14QhPlax2DUzUipK/rdhTDWvViIBwLt1bhTaz6fev7fbMHdHqbZgXjVJD
 4Uyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779305183; x=1779909983;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=+IShrOJdoAnXhE6bNJkPoCD2JYelB8KnTrT0I3ViK0Q=;
 b=d3tifDKH8YL61LTdqEnwtDT1sZY/GYP7CkByOZrKNzOksOdhNpQjW+U+gvOMDB4Rrj
 9zGgWTpK7nBaljUQZG4Au2D424Ab4nTaAft7+xsvkFTqdm9PJk39At1xf6vgsPRurBk1
 UCReDgAfjtIcEZCfyMe6AAtwSknigC4WiDvB+zASXrwmqaO/R/FHRSnSh28w1hNR9Ee5
 YJBymP8iQT8SrLo8k70sVXmZyC8TNQFBufpVJwiexeiRdebvj/qlqVJDTOrkAojPFklV
 ITFmpuJ0H+oKB2VCXQog83C2xQFqAzfE5CymC3owBObzBgzBLhI30JSsQMQ7CAio4KS9
 u2Wg==
X-Gm-Message-State: AOJu0Ywr7vbjpnD5nSYkl0Xwj7Kl/r+VUIqpRPfFOsb3uPLOsP5wcQTP
 YCv6Zyr/ABixx3zhnUZvge8AN9fKrtgfpt662/Ev126wrNWxMxwKbisjHFtASRSn0M/rGCXys8+
 sX3yGhLE=
X-Gm-Gg: Acq92OH823YuTuXVNrGECMDVrYnDHRt2g8c80/9zkIihbr8eYNLE5eW1oXeYfznJ3WI
 i+QEVFI0ROXrf5bjamSSSLJ5X4bKSldjcVNvsxPlAGi+FvG83q59mG2bawLMolf6EZLFMNlbqzb
 P2ohAqhIyxG4w8GXIotR+106qXlyqmFvHcPhLcySwYWoOTaAd8QPmMlBwgiI69qKZtX2m7MvNyk
 F1Bci341yemKZ6XfzEUuiqmDuXC4G+XB5BqexwqqQFZwSRKGQb3QgmFd5fal4nM7EfehXJcw/0O
 mW17Hg/cR5LLk38KiUlwyLW/EvRUk9oqh77nEMZNJTjoJPrC0o9iVvQ1Emz4Ql6CfymXpu8VIYa
 oej+iV2W1OxXVWQxMVn5Z/pn0tlCV8MqK0Cq6r3G6tqO6kJZ5vnkVeRj1MzkgmnHedSKkDdyLA4
 F5rYRTZskiUYuIxl7tjrd9NmR1kHf9l3nHGPbbIyFoif9bw+DoeWJtI9Xryk3wYz6ux3LQriSr
X-Received: by 2002:a05:600c:138f:b0:488:ae6c:42c6 with SMTP id
 5b1f17b1804b1-48ff4f4f44dmr308996675e9.14.1779305183141; 
 Wed, 20 May 2026 12:26:23 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45da0fe2464sm57109780f8f.32.2026.05.20.12.26.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 20 May 2026 12:26:22 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 23/33] tcg: Introduce tcg_zero_i128()
Date: Wed, 20 May 2026 21:23:28 +0200
Message-ID: <20260520192338.40036-24-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260520192338.40036-1-philmd@linaro.org>
References: <20260520192338.40036-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

Extract tcg_zero_i128() helper for re-use.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20260520121644.10835-1-philmd@linaro.org>
[rth: Move the function to tcg-op.c]
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-op-common.h    |  2 ++
 target/arm/tcg/translate-a64.c |  5 +----
 tcg/tcg-op.c                   | 10 ++++++++++
 3 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index e02f209c093..aff99754160 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -18,6 +18,8 @@ TCGv_vaddr tcg_constant_vaddr(uintptr_t val);
 TCGv_vec tcg_constant_vec(TCGType type, unsigned vece, int64_t val);
 TCGv_vec tcg_constant_vec_matching(TCGv_vec match, unsigned vece, int64_t val);
 
+TCGv_i128 tcg_zero_i128(void);
+
 TCGv_i32 tcg_temp_new_i32(void);
 TCGv_i64 tcg_temp_new_i64(void);
 TCGv_ptr tcg_temp_new_ptr(void);
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 9a27c4c6ec7..3e3971db3fb 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -4804,13 +4804,10 @@ static bool do_STG(DisasContext *s, arg_ldst_tag *a, bool is_zero, bool is_pair)
 
     if (is_zero) {
         TCGv_i64 clean_addr = clean_data_tbi(s, addr);
-        TCGv_i64 zero64 = tcg_constant_i64(0);
-        TCGv_i128 zero128 = tcg_temp_new_i128();
+        TCGv_i128 zero128 = tcg_zero_i128();
         int mem_index = get_mem_index(s);
         MemOp mop = finalize_memop(s, MO_128 | MO_ALIGN);
 
-        tcg_gen_concat_i64_i128(zero128, zero64, zero64);
-
         /* This is 1 or 2 atomic 16-byte operations. */
         tcg_gen_qemu_st_i128(zero128, clean_addr, mem_index, mop);
         if (is_pair) {
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index d8ae57d6047..971ac2fb359 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -2475,6 +2475,16 @@ void tcg_gen_concat_i64_i128(TCGv_i128 ret, TCGv_i64 lo, TCGv_i64 hi)
     tcg_gen_mov_i64(TCGV128_HIGH(ret), hi);
 }
 
+TCGv_i128 tcg_zero_i128(void)
+{
+    TCGv_i64 zero64 = tcg_constant_i64(0);
+    TCGv_i128 zero128 = tcg_temp_new_i128();
+
+    tcg_gen_concat_i64_i128(zero128, zero64, zero64);
+
+    return zero128;
+}
+
 void tcg_gen_mov_i128(TCGv_i128 dst, TCGv_i128 src)
 {
     if (dst != src) {
-- 
2.53.0


