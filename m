Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E962FCD4F3C
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 12:17:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPfrA-0007O6-44; Wed, 20 May 2026 08:17:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPfr2-0007M5-Dt
 for qemu-devel@nongnu.org; Wed, 20 May 2026 08:16:53 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPfqz-00007i-UK
 for qemu-devel@nongnu.org; Wed, 20 May 2026 08:16:52 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-43fe62837baso2735155f8f.3
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 05:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779279407; x=1779884207; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=1iwcJSNrUOiyTxOxV/al4D6PTsQbGMkX0qhlUuJJR8g=;
 b=l7iF/mLzHiUDy8Y4DPeWsHrET6/VyFJGV5zS1NVw1peDDtrx/fEXD4xauKKAYExmqC
 ScNdeByQjZVbtg4Uz+1Ye3OSHhe+iG8qGz2ixEHVZNB1PbnNKgHn9+626H14HtDjKvQp
 oVz7mKFTFMXpplzjljE4wfjGJzwZ3/0u+YSJKBJYOa5ZNCxHOXYHgoTUX6AlchO6u16n
 9HSu1tqvjqQ32O8miXDsU8qvP42f9fsGx1mMrf/2sK9BihjiAzqyeLjWyIKQRX7HwsQh
 YdV+R7p7k9SgUBK53mm6UJyDOaYIjKBo9wXc8kWy5zgtc1sM3MM0uIq6cSrqD4uzgqer
 aLBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779279407; x=1779884207;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1iwcJSNrUOiyTxOxV/al4D6PTsQbGMkX0qhlUuJJR8g=;
 b=CSWtf7/i8JdmMk8pIq+OyAV8LgcFm8XcaMjufhvLCI8V+yIoCdfpP4yDrscq6/g4R6
 taklcilaF6LCnG2ZrDt77DATUg3EVdjgx3LJTr8DgXXx2wjwKb5zE4ZUFZVtZReXtX6O
 VDU+87B05E4UtiWoXnqRjS5WiFI0uEERY/lieqQHBX00QoMh/bxpOyccGl0sUR6Docl4
 szVPv6AKtn+JQxO48tvVUKvrhSMF46U15fW9QWeH/38v72WYXB0Hr3fVnAnG3V2gqqEI
 vcy3GHo7T+gG+AR5n2T9ahZ991n9JDfywQMSj6Nl8fPiwqJaObt5duzJPSDhONB6M2gh
 kLiQ==
X-Gm-Message-State: AOJu0YxjG22f8v3QFkRMTcpRvFxxf0XTqVycwGowmoqsCpryxZ8QtDqZ
 CS89xlddtNy6NOMFx/P7dXWvzbetXV3U8NTsHN0hhnGBQnSz+mxy3dczNKWcLahTPzackPuA/Lf
 b//VULiQ=
X-Gm-Gg: Acq92OHfYkUu540eajfivjO6rRoSt7oXQ/ABnad/CTqljrnRfrpQnKr8ip41hRaqaCf
 wJ1ebXsoub6AsWb0z7TiV0h3HFVOwvw5VszoGSZq8v4TOzN5ooPRE3hhwC++ygkcBmYOEvWgTHu
 3gacfsA5BRbk/+KjQdKtUFCSk8e3PQ7aX93MqUn/066+bIz9ZzdQn8vFPChBs1mRJU8DiHTRJI+
 SPDh7mpVotSUnF5mkGS1xKpcJcB+mQpssF/UA0Zv7JwycLxBV0cKdxMdRkimyGloKdSvOP4O3qU
 bkzsEDu+aCti5xFBmA3i4f33XPVgDVNpUdxq6smTkexFE4ZZYu8tqWjPFFPAvoBVXsEW4CtraRY
 +HJZSvq9WbEP7aGtp6T/P0j3Po0pfFtoB5RQgFHrvIwTkOBe7iz4zmqkNZyKVcEdwuIchkzz/zJ
 aMb113KiCb8VIX+jPPNWXYGXC/hkvWwzMNqbnh4J75hDBGcqpY+7LZnb4+SEfIzeYA0x1zs8EDm
 tOl0g==
X-Received: by 2002:a05:6000:2311:b0:449:a07a:967f with SMTP id
 ffacd0b85a97d-45e5c587a90mr39133222f8f.28.1779279406910; 
 Wed, 20 May 2026 05:16:46 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45d9e767ee0sm50219449f8f.1.2026.05.20.05.16.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 20 May 2026 05:16:46 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: James Hilliard <james.hilliard1@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH] tcg: Factor tcg_zero_i128() helper out
Date: Wed, 20 May 2026 14:16:44 +0200
Message-ID: <20260520121644.10835-1-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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
---
 include/tcg/tcg-op-common.h    |  2 ++
 target/arm/tcg/translate-a64.c |  6 +-----
 tcg/tcg.c                      | 10 ++++++++++
 3 files changed, 13 insertions(+), 5 deletions(-)

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
index 9a27c4c6ec7..506ebff508b 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -4804,18 +4804,14 @@ static bool do_STG(DisasContext *s, arg_ldst_tag *a, bool is_zero, bool is_pair)
 
     if (is_zero) {
         TCGv_i64 clean_addr = clean_data_tbi(s, addr);
-        TCGv_i64 zero64 = tcg_constant_i64(0);
-        TCGv_i128 zero128 = tcg_temp_new_i128();
         int mem_index = get_mem_index(s);
         MemOp mop = finalize_memop(s, MO_128 | MO_ALIGN);
 
-        tcg_gen_concat_i64_i128(zero128, zero64, zero64);
-
         /* This is 1 or 2 atomic 16-byte operations. */
         tcg_gen_qemu_st_i128(zero128, clean_addr, mem_index, mop);
         if (is_pair) {
             tcg_gen_addi_i64(clean_addr, clean_addr, 16);
-            tcg_gen_qemu_st_i128(zero128, clean_addr, mem_index, mop);
+            tcg_gen_qemu_st_i128(tcg_zero_i128(), clean_addr, mem_index, mop);
         }
     }
 
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 2ca44766f64..71c2500ab14 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -2265,6 +2265,16 @@ TCGv_i64 tcg_constant_i64(int64_t val)
     return temp_tcgv_i64(tcg_constant_internal(TCG_TYPE_I64, val));
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
 TCGv_vaddr tcg_constant_vaddr(uintptr_t val)
 {
     return temp_tcgv_vaddr(tcg_constant_internal(TCG_TYPE_PTR, val));
-- 
2.53.0


