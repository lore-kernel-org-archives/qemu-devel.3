Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE35CC982C1
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 04:34:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x73nn-0002CE-Bn; Thu, 17 Sep 2026 00:32:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x73nK-0001Ua-U3
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 00:32:23 -0400
Received: from mail-oo2-x2b.google.com ([2607:f8b0:4864:31::2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x73nI-0007Dj-P7
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 00:32:22 -0400
Received: by mail-oo2-x2b.google.com with SMTP id
 006d021491bc7-6b4bff33d18so159959eaf.3
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 21:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789619539; x=1790224339; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=xcnVaWYwKuRJkZD8NRUMBmVfxids9+SS5T9dm6c9GC0=;
 b=rKowqsmgQw/wuUaZGcE934VNZNrioJo7ih28m6YQUEYqZwIV1f/aKEZCM6A+hjGTmP
 i5EPYEVHv/RYWBM6zvg9LOzoi/UUiBsHuU3tjfLUuQWdFqGe7rvsvX1GlpNoJEmFosAB
 LHQMkoUa4fB+vRIkouIL0kX5MWHAHvjC+3MqKQ/PndVXGfYYPDh9LxXcp0AHwG0rufhR
 y+Vz8QLHgJ5WXi1orgXJwbchyPg79GVzjqWPuGxMMMirg+Hx7wUByl3fNBqcvQB3mfuW
 aygHrLO9VwT4mz9hIuLC/rsijfNbLooU8cPFCcwN+k5bP9WTzeycDqtnhfk6ESbM4H/f
 /5Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789619539; x=1790224339;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=xcnVaWYwKuRJkZD8NRUMBmVfxids9+SS5T9dm6c9GC0=;
 b=wAMlxfwUr0G7clcnUqvE1anQYqeM3+gGqn4bKaHDcOEC8ZSJgNU0NtTE0/iXwvpsVH
 j38Q/hL8+PRtG1+061jR/HTT37O/hKMfzdOfHq5MnQOjZwLO4v1G2BZtJjGG+5v04QsS
 tSZN+9EhGXOcIUBKpgoRCZHRbOZssTZ0+L+8yJApZ37z5+zXdOsQKoNE3lY6sFin7ZmY
 D8OZNAJZHd+KkRxfzt34NwVhrt/gLcejBMRxBjn1P8+kiTFmhPMsh0VpQOQpRNhGOum5
 SNX9zd6AuSOqsR+TCqnOB8auqeO7jeOl4b8lz5CTYBvVofTT1mzPSqu1pzAT9wtjCLCN
 UEvg==
X-Gm-Message-State: AFuF++mApXuCTzpevNR0Mn/muTHJZInpWe0FNgK05lbabIy7d8+vtOiE
 gNaMk4amdD51dAJ07lTsFlqY0JUWoQI+7VvY4UvZi/gOCnTE5RpFU+lePA7QDeTR69Fe/Xvaher
 Dunnm31s=
X-Gm-Gg: AYBFou1ALBJYAuzCLwVyHV1J7F9IsrH7PryFLn9LfYJoh4mLPvoVnV0CUtkpHD812KO
 EOSQC4TXz7E/jwsoRrFvIiBEGt/OHgB8P+3EXR/TeKM9XQeaVFUj/NbdDO0MQujZ00JyYaQvxLW
 KEQLWXsRceE4zp5Hw5hCpdQ3GKr7uJ/ivm0/a6XoJw2Y8Ap7qOUsPC1DyKlaK5NIBGXZflXK1R7
 5hVRQi9oo2+JJK2uAXiL0FGpc4UbDJx5bKiTCtLqoJlYlI8SqqTyjhjFECDuQUoYDlJXYl09x4F
 Uj35Mb0lE90wOGctxYxctb0OGfbV+F8C8Rv6tFoVnebju6POTk2bv2S1iXpCxy6MtKT1Yb3xxsy
 j6L4xLDAuwhcV/jTYQmTyRZCPkUyu+G11P3shP87RhD97uE7EU2YeTnYMIwY4y0XuyLLoX2tebC
 bgBqUv3uEawxQgLa29naF9nHNvJ/EcapW/LiOzSTxhqYHc9I3QXmRBn5BerrixNrj66pCYk9pwW
 +85JRg=
X-Received: by 2002:a05:6820:198f:b0:6c0:7620:fccf with SMTP id
 006d021491bc7-6c7d45e15e3mr2122170eaf.57.1789619539255; 
 Wed, 16 Sep 2026 21:32:19 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:325f:1938:d075:8c13])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14395d13cb7sm10501878c88.7.2026.09.16.21.32.18
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 21:32:18 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 050/101] tcg: Split out gen_extrl_i64_i32
Date: Wed, 16 Sep 2026 18:27:32 -1000
Message-ID: <20260917042823.542588-51-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917042823.542588-1-richard.henderson@linaro.org>
References: <20260917042823.542588-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:31::2b;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo2-x2b.google.com
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
index 9cddfd370ff..801ea56498d 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -411,6 +411,8 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo)
 #undef DEF4
 #undef DEF6
 
+static void gen_extrl_i64_i32(TCGTemp *dst, TCGTemp *src);
+
 /*
  * Generic expansions for templated operations.
  * We have used compiler type checks to ensure all TCGTemp
@@ -534,6 +536,11 @@ static void gen_eqv(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
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
@@ -2267,8 +2274,7 @@ void tcg_gen_abs_i64(TCGv_i64 ret, TCGv_i64 a)
 
 void tcg_gen_extrl_i64_i32(TCGv_i32 ret, TCGv_i64 arg)
 {
-    tcg_gen_op2(INDEX_op_extrl_i64_i32, TCG_TYPE_I32,
-                tcgv_i32_arg(ret), tcgv_i64_arg(arg));
+    gen_extrl_i64_i32(tcgv_i32_temp(ret), tcgv_i64_temp(arg));
 }
 
 void tcg_gen_extrh_i64_i32(TCGv_i32 ret, TCGv_i64 arg)
-- 
2.53.0


