Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDDC7C88E59
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2026 10:35:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5L4w-0008MN-S2; Sat, 12 Sep 2026 06:35:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5L4r-0008AJ-AW
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 06:35:21 -0400
Received: from mail-pj2-x11.google.com ([2607:f8b0:4864:39::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5L4l-0008EC-CD
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 06:35:20 -0400
Received: by mail-pj2-x11.google.com with SMTP id
 d9443c01a7336-2d91ede8035so4586815ad.3
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2026 03:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789209313; x=1789814113; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=6FgJVuIldxZYyhLJnAqKitemkV7wXJkVHFz+nElQZ9s=;
 b=UkkoGGIvpQ/RnmIu5twdneJVusmMh2OkUFTdBXvNY+5SXDa+1ExaLIED6Y/oxM8AXv
 s21owxLHPRoAy4J8KsQFhCgvqmOehrNGLCvgZCbqPXH6Y2QN6KuIS2SmAl1ieFmIkqTp
 Lsux8wol38S5z0F7+/xIpWeQtdXOML6Qfva/H5ug+jD/6mbE824k8gMmk9n/okj9aQXV
 BVL+DVWreMNceG3Qfw/hFXGxD6fXEwNrleI7RB2r+vKSPOpTk4eDXf/GAiOyWm+sBbgD
 FDLpk7ENmw8urZuYVYljp6qMS3V43gvcpXADLBNgTALT73TAWUOP+z5ed2K7RJ7OAH1u
 a+FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789209313; x=1789814113;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=6FgJVuIldxZYyhLJnAqKitemkV7wXJkVHFz+nElQZ9s=;
 b=bbKvPfR6vp12yqOPd+6BPYcqcAyFYnkPNH6GHRGrUp8A1tArYv+qYumN4iaHOlKla9
 fA15y2x0iDEQ93/6+iUBK9czW3IThryddqsbpEsNofHANhwtlo8FK3+OCIWa8hJ25i1Z
 3zQcYbtT9oRpSBymnax2Kj7veprgBfQCqyRDNhiIVdXEvaGRGNDJvJtJk3BKBeWM9nHP
 BpWOVCmoLe2vi+xXQKEQrXQDxoiWZtAyhnzZoJsTTLHSHDttKdyNeDPjdtGSYEQBLtgl
 eQpPD7AfCGR1Wxus1wyQt2g68KfzaMboqsac4DEawOHJ446A6Oiqu5VoywOXil21eAz4
 P2lQ==
X-Gm-Message-State: AFuF++lwMH6TC2tfPiZzf0tQsSOYEwMKyw1T3hYFKbawDcMSzvQGiUoc
 SgGSzsp3bGnZiGuoc9BZXrTacE4i2PtGGVqkI78rMaC3CO9iiLa3mtoukZhtl9E9pgAUQsXfnRf
 cgm9CAyM=
X-Gm-Gg: AYBFou3Z2D031xVIROC82Jey8/jXRUcbewdPGI6/61VokoNBcdx66IQM/DmHjv0M+z/
 evC2OW0g7ot84Ye4/2A8OcJt3eMg26V3cCZr24QcAV9JsFh9Xd1RjnCrEFOinqER9U8fmZwQ+iz
 LrRFi9Mhy3FO6gDzDApdRKW6bJw2vTcIaTN7qULHa7Z49YOsIsVAZvcoh+Vz0+zJwHnEImfEqjv
 1FGZIpjwfRUqexxkECKLYpsDK4W6lqpip+xX4FyNScZQ3sDW0fZSOhjVeQHc7d68di5WPsZhNGM
 EtnnUeuMj+lH0Qd+TgGhQkortYTraeldtgQ4awPv752CWNmnE6lAyWb/MA7y2Ok+D2U/HRoGcSZ
 MJYnAEmbpKqPkYZeNjCIrA3gHDEdKHIjk5mnYcDn0Pq8rbeyXRuUd5xgYrRuMzZjvQqktpuWujg
 oxsF2obzbepxeKpBRKu5vnDFjJMC/8IhX3Ww8A+BNh+4/nsEFfhiNN7fKj5pbQYj4TvHiackoNK
 HG1xG4=
X-Received: by 2002:a17:902:f601:b0:2d9:54:fc69 with SMTP id
 d9443c01a7336-2dd4bc57033mr37628445ad.7.1789209313465; 
 Sat, 12 Sep 2026 03:35:13 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:bf2d:a6f5:e308:cd27])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33ba4f55735sm13673674eec.24.2026.09.12.03.35.12
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 03:35:13 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 46/82] tcg: Split out gen_extrh_i64_i32
Date: Sat, 12 Sep 2026 00:30:50 -1000
Message-ID: <20260912103126.598030-47-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260912103126.598030-1-richard.henderson@linaro.org>
References: <20260912103126.598030-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::11;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x11.google.com
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
 tcg/tcg-op.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index d1eb006b2e6..ba4011ff241 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -366,6 +366,7 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo)
 #undef DEF_CRRI
 #undef DEF_CRRRRR
 
+static void gen_extrh_i64_i32(TCGTemp *dst, TCGTemp *src);
 static void gen_extrl_i64_i32(TCGTemp *dst, TCGTemp *src);
 static void gen_extu_i32_i64(TCGTemp *dst, TCGTemp *src);
 
@@ -495,6 +496,11 @@ static void gen_eqv(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
     }
 }
 
+static void gen_extrh_i64_i32(TCGTemp *dst, TCGTemp *src)
+{
+    gen_op_tt(INDEX_op_extrh_i64_i32, TCG_TYPE_I32, dst, src);
+}
+
 static void gen_extrl_i64_i32(TCGTemp *dst, TCGTemp *src)
 {
     gen_op_tt(INDEX_op_extrl_i64_i32, TCG_TYPE_I32, dst, src);
@@ -2311,8 +2317,7 @@ void tcg_gen_extrl_i64_i32(TCGv_i32 ret, TCGv_i64 arg)
 
 void tcg_gen_extrh_i64_i32(TCGv_i32 ret, TCGv_i64 arg)
 {
-    tcg_gen_op2(INDEX_op_extrh_i64_i32, TCG_TYPE_I32,
-                tcgv_i32_arg(ret), tcgv_i64_arg(arg));
+    gen_extrh_i64_i32(tcgv_i32_temp(ret), tcgv_i64_temp(arg));
 }
 
 void tcg_gen_extu_i32_i64(TCGv_i64 ret, TCGv_i32 arg)
-- 
2.53.0


