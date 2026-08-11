Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9F1CC5AC67
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 04:58:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wteX7-0005Iy-VR; Tue, 11 Aug 2026 00:56:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wteX7-0005Gg-3D
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 00:56:13 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wteX5-0002lX-B3
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 00:56:12 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-38dfe7eb825so2214531a91.0
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2026 21:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786424170; x=1787028970; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=9r/RPoADAT80eBobVILqHUdTEZOiVoznykVAQV/AHDU=;
 b=ns3t8seDwXRJ9E/M6dGtLe4PEvM7MO52G/hgQteDBN0JO7TM+6JCy4ujd1WrgHt8lA
 gder1IZx3+akK+yG8FlVOZCcMw+yPbtdUSj7ENFZ6oD8V3u2wa+SzVZ2E8q9yrGOh89u
 YnY3PyB6d4FePkskKklsgMyNYq6PKLteg2ADEltBjXMfRz9Yb4hsbQpTjkpCTgz8II5y
 x80a+Ha22A62KJC5eXpHh8PI4aQ6QT7r0CSagUVyGQ658StmxFq292atx7mnjzHxrHX9
 cOd9wD3U+qq/3McXwdqCP/ZbQY71scJ7saHQQEnle+3r2TKszUIXa10brAYoU8NCtX55
 5JQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786424170; x=1787028970;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=9r/RPoADAT80eBobVILqHUdTEZOiVoznykVAQV/AHDU=;
 b=HDeOipzRMk78MLvZ2hOljCrxP7bTpqRAd2N6x58qdfc967qgii8Wdjo9KroHQY4XU8
 1vkYv1F2xYKnF/XwO+jDXl6hDoB27qNKy0bF1G1lvDwq7cOrWz634rBtew4hLJ2alvYw
 RNuqt2t2kYHmfPlT8UKJDiQVkaa+ZDsV7AwP7qjToKfrtd7skvLwKIxcMcH+cyoA49Rn
 TPbVbaJf+iWa6LMR0l/6ku9YynGupzDQEaRU4ZSE6MnY2VqgGl6hIEDdI4xzTetWXy5H
 IyN7DkwHDaXn/+iNwXKrp09tUQQ/yh9kCBKO3VdC040elBqBnt9tAbL+grV7XWOfsWwD
 c6wQ==
X-Gm-Message-State: AOJu0Yz41BbWt9uU/iRY4P3D496Meqr5TNYOXynxW38VPWQH9u0zPw6C
 1Yy+9PEAJGPQDk0aqGWJPsi182GZVZQmejYPoKOJwOdSZSXeVSeWrL35wD9iASdIOVUXqG1jv0N
 WzimV
X-Gm-Gg: AR+sD11dXe8Cvr7lPDZZyDrV72ebS9ilt9QvziGu5ZY5YTdNXKoYmFJ5cpt3wIAW37z
 3VWr6hOE+cQ33xJd5rADJ7rX+45HL3PqF1hxlTfhy/pyWmfUG80apsa+Dn/9p5hKilcWoL+ySqe
 27AVo8WH+J1lvhHYxyKYQnbjMZNmIFWDbNr0hPbqEHRJWNY8jY6IuALbaFzBUOm9rN/bY6d3NaQ
 zjOsUmV3LDS0VHBpEbW7RJ5iwaK1A+cdtH77+QKKHvU8uAuq9aSVR9Xib9u/WS3eLo0GNNplzwJ
 PJerRBnyVsS5yoxEBpk0v1o4/sRhaXCbiAlEdiNaiGiIHRab/ehGyoN7lyz9semx90DR90pxryy
 h5Nb+HV51w+WOONrkSYdZJQDFKJad3HIDCANA5stwBGvzIvDlf+ihR/cP+QTlHFON3qSvZtDFfe
 7pBvhE5MZwqzEufHjtXvfJCFuushS7vPz5edSWyS8UqaRvwErObib+6jkrtBLCcz3873eHM8IdA
 YR4R5uNXyMhBGbD74hU
X-Received: by 2002:a17:90b:1c8b:b0:392:7f74:58c9 with SMTP id
 98e67ed59e1d1-392ec6169e3mr592501a91.15.1786424169803; 
 Mon, 10 Aug 2026 21:56:09 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-392ee3084d0sm156818a91.8.2026.08.10.21.56.08
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Aug 2026 21:56:09 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 03/16] tcg: Simplify bswap/hswap expansion using bitswap
Date: Mon, 10 Aug 2026 21:55:52 -0700
Message-ID: <20260811045605.1246543-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260811045605.1246543-1-richard.henderson@linaro.org>
References: <20260811045605.1246543-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102a.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg-op.c | 72 ++++++----------------------------------------------
 1 file changed, 8 insertions(+), 64 deletions(-)

diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 3d28280785..c24a7962fc 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -1252,23 +1252,8 @@ void tcg_gen_bswap32_i32(TCGv_i32 ret, TCGv_i32 arg)
     if (tcg_op_supported(INDEX_op_bswap32, TCG_TYPE_I32, 0)) {
         tcg_gen_op3i_i32(INDEX_op_bswap32, ret, arg, 0);
     } else {
-        TCGv_i32 t0 = tcg_temp_ebb_new_i32();
-        TCGv_i32 t1 = tcg_temp_ebb_new_i32();
-        TCGv_i32 t2 = tcg_constant_i32(0x00ff00ff);
-
-                                        /* arg = abcd */
-        tcg_gen_shri_i32(t0, arg, 8);   /*  t0 = .abc */
-        tcg_gen_and_i32(t1, arg, t2);   /*  t1 = .b.d */
-        tcg_gen_and_i32(t0, t0, t2);    /*  t0 = .a.c */
-        tcg_gen_shli_i32(t1, t1, 8);    /*  t1 = b.d. */
-        tcg_gen_or_i32(ret, t0, t1);    /* ret = badc */
-
-        tcg_gen_shri_i32(t0, ret, 16);  /*  t0 = ..ba */
-        tcg_gen_shli_i32(t1, ret, 16);  /*  t1 = dc.. */
-        tcg_gen_or_i32(ret, t0, t1);    /* ret = dcba */
-
-        tcg_temp_free_i32(t0);
-        tcg_temp_free_i32(t1);
+        gen_bitswap_i32(ret, arg, 0x00ff00ff);
+        tcg_gen_hswap_i32(ret, ret);
     }
 }
 
@@ -1823,14 +1808,9 @@ void tcg_gen_bswap32_i64(TCGv_i64 ret, TCGv_i64 arg, int flags)
     } else {
         TCGv_i64 t0 = tcg_temp_ebb_new_i64();
         TCGv_i64 t1 = tcg_temp_ebb_new_i64();
-        TCGv_i64 t2 = tcg_constant_i64(0x00ff00ff);
 
-                                            /* arg = xxxxabcd */
-        tcg_gen_shri_i64(t0, arg, 8);       /*  t0 = .xxxxabc */
-        tcg_gen_and_i64(t1, arg, t2);       /*  t1 = .....b.d */
-        tcg_gen_and_i64(t0, t0, t2);        /*  t0 = .....a.c */
-        tcg_gen_shli_i64(t1, t1, 8);        /*  t1 = ....b.d. */
-        tcg_gen_or_i64(ret, t0, t1);        /* ret = ....badc */
+                                                /* arg = xxxxabcd */
+        gen_bitswap_i64(ret, arg, 0x00ff00ff);  /* ret = ....badc */
 
         tcg_gen_shli_i64(t1, ret, 48);      /*  t1 = dc...... */
         tcg_gen_shri_i64(t0, ret, 16);      /*  t0 = ......ba */
@@ -1857,32 +1837,8 @@ void tcg_gen_bswap64_i64(TCGv_i64 ret, TCGv_i64 arg)
     if (tcg_op_supported(INDEX_op_bswap64, TCG_TYPE_I64, 0)) {
         tcg_gen_op3i_i64(INDEX_op_bswap64, ret, arg, 0);
     } else {
-        TCGv_i64 t0 = tcg_temp_ebb_new_i64();
-        TCGv_i64 t1 = tcg_temp_ebb_new_i64();
-        TCGv_i64 t2 = tcg_temp_ebb_new_i64();
-
-                                        /* arg = abcdefgh */
-        tcg_gen_movi_i64(t2, 0x00ff00ff00ff00ffull);
-        tcg_gen_shri_i64(t0, arg, 8);   /*  t0 = .abcdefg */
-        tcg_gen_and_i64(t1, arg, t2);   /*  t1 = .b.d.f.h */
-        tcg_gen_and_i64(t0, t0, t2);    /*  t0 = .a.c.e.g */
-        tcg_gen_shli_i64(t1, t1, 8);    /*  t1 = b.d.f.h. */
-        tcg_gen_or_i64(ret, t0, t1);    /* ret = badcfehg */
-
-        tcg_gen_movi_i64(t2, 0x0000ffff0000ffffull);
-        tcg_gen_shri_i64(t0, ret, 16);  /*  t0 = ..badcfe */
-        tcg_gen_and_i64(t1, ret, t2);   /*  t1 = ..dc..hg */
-        tcg_gen_and_i64(t0, t0, t2);    /*  t0 = ..ba..fe */
-        tcg_gen_shli_i64(t1, t1, 16);   /*  t1 = dc..hg.. */
-        tcg_gen_or_i64(ret, t0, t1);    /* ret = dcbahgfe */
-
-        tcg_gen_shri_i64(t0, ret, 32);  /*  t0 = ....dcba */
-        tcg_gen_shli_i64(t1, ret, 32);  /*  t1 = hgfe.... */
-        tcg_gen_or_i64(ret, t0, t1);    /* ret = hgfedcba */
-
-        tcg_temp_free_i64(t0);
-        tcg_temp_free_i64(t1);
-        tcg_temp_free_i64(t2);
+        gen_bitswap_i64(ret, arg, 0x00ff00ff00ff00ffull);
+        tcg_gen_hswap_i64(ret, ret);
     }
 }
 
@@ -1894,20 +1850,8 @@ void tcg_gen_bswap64_i64(TCGv_i64 ret, TCGv_i64 arg)
  */
 void tcg_gen_hswap_i64(TCGv_i64 ret, TCGv_i64 arg)
 {
-    uint64_t m = 0x0000ffff0000ffffull;
-    TCGv_i64 t0 = tcg_temp_ebb_new_i64();
-    TCGv_i64 t1 = tcg_temp_ebb_new_i64();
-
-                                        /* arg = abcdefgh */
-    tcg_gen_rotli_i64(t1, arg, 32);     /*  t1 = efghabcd */
-    tcg_gen_andi_i64(t0, t1, m);        /*  t0 = ..gh..cd */
-    tcg_gen_shli_i64(t0, t0, 16);       /*  t0 = gh..cd.. */
-    tcg_gen_shri_i64(t1, t1, 16);       /*  t1 = ..efghab */
-    tcg_gen_andi_i64(t1, t1, m);        /*  t1 = ..ef..ab */
-    tcg_gen_or_i64(ret, t0, t1);        /* ret = ghefcdab */
-
-    tcg_temp_free_i64(t0);
-    tcg_temp_free_i64(t1);
+    gen_bitswap_i64(ret, ret, 0x0000ffff0000ffffull);
+    tcg_gen_wswap_i64(ret, ret);
 }
 
 /*
-- 
2.43.0


