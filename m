Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 269E6C27C52
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 17:27:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEuM6-00064o-61; Wed, 05 Jun 2024 13:23:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sEuM5-00062u-83
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 13:23:21 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sEuM3-0003sz-IY
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 13:23:20 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-7026ad046a2so10817b3a.2
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 10:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717608198; x=1718212998; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tnK4IZB9wru/DRu1KrRLv1CRpfWd7Vg7Mr6mdfp81eY=;
 b=z41DyVDerQEQsUMZyYm+pDlAwPF73EbLfy8xsgQuSW7BBFvS2pxom1138mnd+XDxHU
 H6P66Izdo7I8NZ+EP8JlH2zjEm2ATqWwPJYosGKhaYY84ACBE7+C7NtFNX6XpAlI+PNo
 4t0CXjGhvtA0KwKPNDlxF1oVPMXv1CrpSs6zd1RTpkxBbHNaxVHqv2MmR1f9kGbqPBlK
 fy0fRNZHDaQZNn8pZFyF5PWD2+5IV0DZht4NWEuNgM9rw9oEKW4MDmIlaFlpzhZR1Z6q
 dxPY8Ib9hO0EOhQq3pY9UGCsKZ/Md7SJyhVl4nWnImkXHWYGYrtiBOybKF8L9n3Qfoq6
 KMVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717608198; x=1718212998;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tnK4IZB9wru/DRu1KrRLv1CRpfWd7Vg7Mr6mdfp81eY=;
 b=ML+/wodxgA+NciHuKHb+DvbtR5AuOo8YiWUBaf5lSCpszCdYGijqJFz408h4Kk81ib
 Dhn0a1NEExcYa5W1hR8ziaEjZR7rt8I5oiNThkDFxrSkkGgzPxUC41ZGJyGg5aGw1GjF
 zXdo2N2woh21/8izdD/fiLZ+C78MJjMW3oDkUpA4HEyPhCpekgP5P7/UuMSdr/iT7L//
 +5+cGTM3gPYF3UeLdrBpsFopaBkBHdkiHx/ASe2kIjlui0lZJQKcaCuXxTJ7cnKM/S3q
 nsMZO2SWE2i2XzqU1yIvEIgVzPEeNqGE+XmorRDVlLlo1XLWLFWCjXsZgDhRrEJxnABM
 ygnw==
X-Gm-Message-State: AOJu0YyFyiRQeH6P3NjhNQRK3W+6fkMyKCy06ooXDz6HNqVYGYpJ051J
 dgYgp+dgvjSzGHenEXePJdFv4k+HPQ4xN6kVusTpUpit+9RK3OULey+kLvBUe+k4872hG3sTe3V
 3
X-Google-Smtp-Source: AGHT+IG25ESla7oQ6nR0SmvQVh4JlmSB7IpmodPLYTOVjQuG5+NqAdHNzVAT4z+n147/UFnGrLjeUA==
X-Received: by 2002:a05:6a20:7fa4:b0:1af:f92c:de8e with SMTP id
 adf61e73a8af0-1b2b717ba09mr3580760637.52.1717608198225; 
 Wed, 05 Jun 2024 10:23:18 -0700 (PDT)
Received: from stoup.. ([71.212.132.216]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c28066d511sm1720915a91.9.2024.06.05.10.23.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jun 2024 10:23:17 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 25/38] target/sparc: Implement PDISTN
Date: Wed,  5 Jun 2024 10:22:40 -0700
Message-Id: <20240605172253.356302-26-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240605172253.356302-1-richard.henderson@linaro.org>
References: <20240605172253.356302-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/insns.decode |  1 +
 target/sparc/translate.c  | 11 +++++++++++
 2 files changed, 12 insertions(+)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index e0e9248982..09c8adca37 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -435,6 +435,7 @@ FCMPEq      10 000 cc:2 110101 .....  0 0101 0111 .....    \
     FPACKFIX    10 ..... 110110 00000 0 0011 1101 .....    @r_d2
     PDIST       10 ..... 110110 ..... 0 0011 1110 .....    \
                 &r_r_r_r rd=%dfp_rd rs1=%dfp_rd rs2=%dfp_rs1 rs3=%dfp_rs2
+    PDISTN      10 ..... 110110 ..... 0 0011 1111 .....    @r_d_d
 
     FMEAN16     10 ..... 110110 ..... 0 0100 0000 .....    @d_d_d
     FCHKSM16    10 ..... 110110 ..... 0 0100 0100 .....    @d_d_d
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 496d490cdd..2480eed1e7 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -817,6 +817,15 @@ static void gen_op_bshuffle(TCGv_i64 dst, TCGv_i64 src1, TCGv_i64 src2)
 #endif
 }
 
+static void gen_op_pdistn(TCGv dst, TCGv_i64 src1, TCGv_i64 src2)
+{
+#ifdef TARGET_SPARC64
+    gen_helper_pdist(dst, tcg_constant_i64(0), src1, src2);
+#else
+    g_assert_not_reached();
+#endif
+}
+
 static void gen_op_fmul8x16al(TCGv_i64 dst, TCGv_i32 src1, TCGv_i32 src2)
 {
     tcg_gen_ext16s_i32(src2, src2);
@@ -5070,6 +5079,8 @@ TRANS(FPCMPNE8, VIS3B, do_rdd, a, gen_helper_fcmpne8)
 TRANS(FPCMPULE8, VIS3B, do_rdd, a, gen_helper_fcmpule8)
 TRANS(FPCMPUGT8, VIS3B, do_rdd, a, gen_helper_fcmpugt8)
 
+TRANS(PDISTN, VIS3, do_rdd, a, gen_op_pdistn)
+
 static bool do_env_ddd(DisasContext *dc, arg_r_r_r *a,
                        void (*func)(TCGv_i64, TCGv_env, TCGv_i64, TCGv_i64))
 {
-- 
2.34.1


