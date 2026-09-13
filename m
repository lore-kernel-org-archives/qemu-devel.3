Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD8F9C88E53
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2026 02:45:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5aB0-0002Cu-Fi; Sat, 12 Sep 2026 22:42:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5aAu-0001fj-Qy
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 22:42:37 -0400
Received: from mail-pz2-x10.google.com ([2607:f8b0:4864:3b::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5aAr-0001rp-Hv
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 22:42:36 -0400
Received: by mail-pz2-x10.google.com with SMTP id
 d2e1a72fcca58-85469d249c6so1155953b3a.1
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2026 19:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789267352; x=1789872152; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=EOAHEGKetRzJkEKBWy0hUUF53K6lRXkpf5AW6HX3/i4=;
 b=dPxTL3PaGAFwdxPGc9f0ALqNVd0cZu3/1Bq3BFSGEcNb4GTc92kab/0XdkiajIenTU
 2NQXyraQsTEFsXApgkphoKaanx+JzCWvvIMwpD7dIEq9yU2sJzktN99VUBaLH6GU4iGr
 b6kpZ1+SY5T9/hxu4O7DMYzxviGVGF34jGbAF2hRNuCK33/I7PgHkO0Mc54RTPSK2cff
 2Ng783X5hqrtvrbxqZTyZhdO6h9Bh3tO6H5zcQYUohUAWAp2GRgymfanhVde4Bo1Ndnd
 zv3cNGUpP8T3So9IFEcEXVYqyUIgPdvbhNNTGRx16B1Fn36ogPkw4ZVl4gcm2347nSn+
 8hoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789267352; x=1789872152;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=EOAHEGKetRzJkEKBWy0hUUF53K6lRXkpf5AW6HX3/i4=;
 b=ss7tUPWWl1A+bj1SytO9HRePx4s9fAbMS4yOItg711lu+RiKSeYG1aGm/Svdn0zETx
 o06fTuYWVdEuwmo5lDYx93G6uxpp8vxMZqnsqW81yYsI2345CCLNSgNKTFyB8xitCTjp
 xU1ZOShzwCqdagqNJ4y9isl4Tf3/cwhFNxOEtBLZnpbe7qFdr5oSiw/W2ICpi7In43RJ
 3ftuO0Tn3mZVqIOkTPcFziTsqojSfb0wXiuCeJZ1F8am5u0ZEPITB0Gyorc64We27Ifr
 sOVt/r2+Q/Vago87w5Xn1S9rEWxZ/TE0G9IciIiL/k8ohctzyuIj0eImhs8iIddze/J+
 HMqA==
X-Gm-Message-State: AFuF++nRxPJIJA2+i56GWGQKdqBskwUPjQPvLgsaZZ+AqLoZXcp3Ytf1
 YQc9fVaxwIslWvKng2CkKHwWFtIncdzfoH4OyXxy+uwKvVo+dzyLWOW1VWa/ibTvUOlzdejh+7p
 cYqDwNsM=
X-Gm-Gg: AYBFou3K3fFXdAxwXTJ2M1YNKQZCMnyIEWBbedWvmUOJOoOmV69o4NGT5/kYHaonvtC
 XjiQ5Quq26olDB3p9JU0U8Ne+3lxOMuduCmFNxdkQRn3EmtdMUs88heJr61MpRXPBhnlpdkf1ni
 WEgfY9RbyhueHM0sdxQ7z9pE2ubZcyFpETdNk3Q2LG0wQ9WnFFZo33sCCdrAzq7YPCMRt/6dMOq
 axVhHHdCKhcbCQBL0/6ZPNBqRGXqlnw5eUDP+T94RdbRH5je6j9GeVfLFXXDhUsXmK3Dr+To7mp
 DH7FtJBR8tu37Qs/4vqwYOxp4uWtZzh7+4BCN3PBLAzvkKjv/DDHXRbyZ7niMGRFWOstzaU5tkU
 zyRSaevAcEB4hurREHex/tYWG4bdWY/BrMAaYC2m4QvOwfgxGOmySzl/bp98DBRnfk2E1PhAYQy
 BKVNj/bnrtFDy9OMVMYd1nBEFq9fWwOtAg1l7xBGotcbVJqsz7nY+za23xL3a/QbigwkXN7vki3
 aCZWts=
X-Received: by 2002:a05:6a20:da0d:b0:3d0:d1f1:6ec5 with SMTP id
 adf61e73a8af0-3daed0ff5b2mr22795205637.4.1789267352042; 
 Sat, 12 Sep 2026 19:42:32 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:bf2d:a6f5:e308:cd27])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33ba4fb3ddasm14946556eec.30.2026.09.12.19.42.31
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 19:42:31 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 46/86] tcg: Split out gen_extrh_i64_i32
Date: Sat, 12 Sep 2026 16:37:57 -1000
Message-ID: <20260913023837.741866-47-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260913023837.741866-1-richard.henderson@linaro.org>
References: <20260913023837.741866-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::10;
 envelope-from=richard.henderson@linaro.org; helo=mail-pz2-x10.google.com
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

We'll need this for other generic expansions.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg-op.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 1b297652661..8268762f182 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -411,6 +411,7 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo)
 #undef DEF4
 #undef DEF6
 
+static void gen_extrh_i64_i32(TCGTemp *dst, TCGTemp *src);
 static void gen_extrl_i64_i32(TCGTemp *dst, TCGTemp *src);
 static void gen_extu_i32_i64(TCGTemp *dst, TCGTemp *src);
 
@@ -540,6 +541,11 @@ static void gen_eqv(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
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
@@ -2291,8 +2297,7 @@ void tcg_gen_extrl_i64_i32(TCGv_i32 ret, TCGv_i64 arg)
 
 void tcg_gen_extrh_i64_i32(TCGv_i32 ret, TCGv_i64 arg)
 {
-    tcg_gen_op2(INDEX_op_extrh_i64_i32, TCG_TYPE_I32,
-                tcgv_i32_arg(ret), tcgv_i64_arg(arg));
+    gen_extrh_i64_i32(tcgv_i32_temp(ret), tcgv_i64_temp(arg));
 }
 
 void tcg_gen_extu_i32_i64(TCGv_i64 ret, TCGv_i32 arg)
-- 
2.53.0


