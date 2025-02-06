Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EA1BC02194
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 20:03:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg80W-0007Pu-Fr; Thu, 06 Feb 2025 14:57:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tg80C-0007DM-5g
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 14:57:32 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tg80A-0000Vw-Fw
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 14:57:31 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-21f2f09865bso25154085ad.0
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 11:57:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738871849; x=1739476649; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tyvKoN2K28yYY2BAVom/mjyQ4IAay4Sv47eAXtGmzGo=;
 b=SNUaFVP18IgfcP4te5wCMAoMXCXJAhWoXsYHorJlG9i4WpMS9eGa3LE47Z2mWfIzYI
 mLlREqyLFMjJJpCZwUrqbbkIJFMDuKrbHSFYxp3SzECI+1UP5b+n6rnCtIyPQpw+q048
 36fE8UfZYdMpiUxaorD0U6djFSV/+aKz3h8Xm2iAbsfUJ3giXDWH4o2G1FCtiCwtjHwG
 g+9KsD3q1WQAtjlQUackkBr00s4SpKJJ9aPCqCt/oPQk3gGA8aNZ0f7boZW6DrvwLrhD
 kXQKXu+wokIgxXXMtUV8T0hj+MNJoaRUiJEgZO6j5bP2j8zzWp9h/UZb6Dgla+yQIdhN
 whVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738871849; x=1739476649;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tyvKoN2K28yYY2BAVom/mjyQ4IAay4Sv47eAXtGmzGo=;
 b=TZ575Seji0AZd/FWUeF0zPkzdHhWoy9KZOn9SsGBIBofK87shGjJxaLJZm5/dBowZj
 G6pmTJlej2v9/i+wdfSLmtZ20zMEaGehJGXGimQGp61KGgm5rbPbj3c5lLzOe/nLpKsZ
 OfSN1+u5dphy2qwkGt9y5Ri8MmFkXlXGgGZMa0ZY0W5HopX8wFKa7shye++nqp5OaQJA
 YT67YoTBNaRQZ4B66ZRcN+yj3bYh1N6nLcMJaB1Yd0BMTW0zmqRhuap6LmScoSVdCre6
 WuZYS7SRihsD8kDjXaBZN2S1NK52CV7PQgUxPDYzJQfiXG4fcIipZolEZc+AJPV5Yq5I
 OI9A==
X-Gm-Message-State: AOJu0Ywej/xCYQsMZtnFaauTbgcDyMZsd0s11r1PTRqPyoLBb+FxiU3n
 9JBLmYt3eqCRMUC3kGpQ/4uragpeQVtgDWGbNYLJViMbqYzYO2QhKU9BiM1K8EUPIzjIxIwApIq
 h
X-Gm-Gg: ASbGnctWybXenNSaEQi9HeVI6ZEmIbZDQoKmbFASxdnAK7eFXkRcMJQdI97DSIJwqBs
 BJtFutGt0Sg0ZfRB572CgHVbKj1GBF7sp51YQFaF5p/eHQQPENVofTqqu0tgSo0y4O/RketTI6T
 Q9LXIM0jXqUBSEX7NtcQnkRa80gTLyjM4/zn0LbVEt6/3KiL0GJzIAI6Y4yp1V78c6EXint+QVY
 83YACUHE4UpJn0+GJgj0PgLimpuXut/Ua6/LVBVdZmZrqBn6oveneNxQ82VpWQM1n1QxrvbCQgy
 p8oHtPgp92eRTBUlY+Ty3pjOMjz9DIEKbBbZJ5SW5icJLug=
X-Google-Smtp-Source: AGHT+IGlFWeSKQfIZ5DvzutxRvB95GY9yxTwqTQ2ZfYbYYK5g/uDIgPBgtYlvtmfhBAT0vJ3+jkDQQ==
X-Received: by 2002:a05:6a00:2345:b0:728:f21b:ce4c with SMTP id
 d2e1a72fcca58-7305e3e0accmr440742b3a.5.1738871849178; 
 Thu, 06 Feb 2025 11:57:29 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73048c16370sm1666993b3a.152.2025.02.06.11.57.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2025 11:57:28 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 17/61] target/arm: Implement SME2 MOVT
Date: Thu,  6 Feb 2025 11:56:31 -0800
Message-ID: <20250206195715.2150758-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250206195715.2150758-1-richard.henderson@linaro.org>
References: <20250206195715.2150758-1-richard.henderson@linaro.org>
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-sme.c | 13 +++++++++++++
 target/arm/tcg/sme.decode      |  5 +++++
 2 files changed, 18 insertions(+)

diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index 8b0a33e2ae..13314c5cd7 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -210,6 +210,19 @@ static bool trans_MOVA(DisasContext *s, arg_MOVA *a)
     return true;
 }
 
+static bool do_movt(DisasContext *s, arg_MOVT_rzt *a,
+                    void (*func)(TCGv_i64, TCGv_ptr, tcg_target_long))
+{
+    if (sme2_zt0_enabled_check(s)) {
+        func(cpu_reg(s, a->rt), tcg_env,
+             offsetof(CPUARMState, za_state.zt0) + a->off * 8);
+    }
+    return true;
+}
+
+TRANS_FEAT(MOVT_rzt, aa64_sme2, do_movt, a, tcg_gen_ld_i64)
+TRANS_FEAT(MOVT_ztr, aa64_sme2, do_movt, a, tcg_gen_st_i64)
+
 static bool trans_LDST1(DisasContext *s, arg_LDST1 *a)
 {
     typedef void GenLdSt1(TCGv_env, TCGv_ptr, TCGv_ptr, TCGv, TCGv_i32);
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index cef49c3b29..83ca6a9104 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -39,6 +39,11 @@ MOVA            11000000 esz:2 00001 0 v:1 .. pg:3 0 za_imm:4 zr:5  \
 MOVA            11000000 11    00001 1 v:1 .. pg:3 0 za_imm:4 zr:5  \
                 &mova to_vec=1 rs=%mova_rs esz=4
 
+### SME Move into/from ZT0
+
+MOVT_rzt        1100 0000 0100 1100 0 off:3 00 11111 rt:5
+MOVT_ztr        1100 0000 0100 1110 0 off:3 00 11111 rt:5
+
 ### SME Memory
 
 &ldst           esz rs pg rn rm za_imm v:bool st:bool
-- 
2.43.0


