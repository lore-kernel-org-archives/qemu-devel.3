Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB477C5DF81
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 17:07:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwNCX-0007QV-PB; Tue, 18 Aug 2026 13:02:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wwNCW-0007PX-B5
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 13:02:12 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wwNCU-0004h3-K5
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 13:02:12 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-848593533cbso79384b3a.3
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 10:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787072529; x=1787677329; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=E6YVpdoy244ypcJbSRQXoYkegfXpSIbiPKqsYmd5CbA=;
 b=NaDj47zyPxdHORXsWULNaCngb/vmRLTysYjHvN4I2wdeXh3xDqaB1BfSI97ANZfDaF
 MR/VMYdmlrEbtEOjrBXiY0swMCGAQrh/AErj51ZoHDcWcapwpOkC3eG7mGpnxBujXowf
 x6bbanp0NOjrruf1dvtPTN2O4fP3gV6CFbrDL33JbD9ED/3RU/itTWowuIi1E0MVmlCy
 rlzuTKalBdODLXor/A9Av7Kzu3vkr1P1cwq3ehMBYNVUAOBxPxXk3szh9x45qKRLjngu
 q4gXObz+FoPdA9538QX0FEioOjZL5AA9qJmZdV/A55uAMy9sOVK6p9N69OVpA248pxyr
 +AAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787072529; x=1787677329;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=E6YVpdoy244ypcJbSRQXoYkegfXpSIbiPKqsYmd5CbA=;
 b=Wh9d0qeo5g1kv11pAc0FkfP139ztgrh66yxWcSXeJPN3qTb0ikYIhGLJUxyBU89DAw
 mkq4jgzV5tXNVXnLQkwC20d03eo4Nj8Pkr72ZrTJDZ4qLyaqO/HIeNLZYlSKhhChZxw9
 eJS0Z/RUyAnaxJHBO3YWxcYfQ43E3RNwl/+Vw1j0a7qEq+dnM2U0h3xHOAcG+r3B6aDw
 O5cliwkl8lHiWmKY1jor/YHaPmdavrD3V7Sgk6HbkGeBofUdlSrUzCOhxQB/m5KXPD2r
 SkG/3l5bOFgRY2CHKeEvSNyUfDhNyLvq8HpxMp0W3ElW6vQG4OzcuOhlmmEAUyx4odOl
 4nDw==
X-Gm-Message-State: AOJu0YyCcW2UcIjmhCvLdhCGsq9VSrVlQXVPcOvxQLDVlO1OL9Odc+vr
 5Be8WJl4M9qTcnd7/v1Q47A+1Y9IJLOyUQBF3Y7V9as5dUN96rvfffjwHh//oDUraxOn4YD9vVD
 1CEtENyM=
X-Gm-Gg: AR+sD11gQl4L51URNkxiAgpGyWJmRe1aLec9jzjnPso9N5k1HljbPYvAPpMn7geWX7b
 jwbm7xRkKo59BfbUTHw2WyaFxf2J+PVyP4AYJSqYAr8PRvCbtbIsgZuEi62JUxv+Ty2jSYLHMuT
 uqi4kQVAH1Ba+Q0J46m9Szh+qO0+9tFl/qTRhGCN9x3zditfU8HK8SLCl6EMeF6QUPtslyE/LoD
 5dDyIB+oLMqGjLCn7FWEVa5A0uj2M8BgfzOPAaLvKHo4+0MuK7qKsc2U40NovZyJKVZ0c8fyTdm
 BWRyEZAUjWKEIN3/nZRKLITNA1Wl4NZDU6yoLVh9viPoZnlCl3ncHS/aCPkg71pZdpRITn0TWe3
 /sGZsAC+8rAX/eXcmpDRAvgshD6DvI6iKRLnpm2DxmUmx0m0tMYy6Leo8n9vjPybzeiglCrXHIB
 FyE/Yqxe8Db71Upx/tWF52hrUoqE0eKmyPzdp8IM0nCe5nVXrhtM49vSgU5ZRXscjKJ+Gl5EG6a
 FOqgE0eKaQcAHBB4JE9HtpVdMuvnqZNLhdhSF9xp/TlZ6Q=
X-Received: by 2002:a05:6a00:414b:b0:847:8acd:747c with SMTP id
 d2e1a72fcca58-84fde3da617mr43281471b3a.13.1787072529072; 
 Tue, 18 Aug 2026 10:02:09 -0700 (PDT)
Received: from stoup.. (c-73-181-156-132.hsd1.wa.comcast.net. [73.181.156.132])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-851b401e10bsm2108314b3a.12.2026.08.18.10.02.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 10:02:08 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PULL 09/38] tcg: Simplify bswap/hswap expansion using bitswap
Date: Tue, 18 Aug 2026 10:01:26 -0700
Message-ID: <20260818170155.1907006-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818170155.1907006-1-richard.henderson@linaro.org>
References: <20260818170155.1907006-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
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


