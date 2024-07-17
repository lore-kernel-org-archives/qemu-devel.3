Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0C32C3DA42
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 06:09:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTxqs-0003h6-M5; Wed, 17 Jul 2024 02:09:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sTxqn-0003b0-SF
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 02:09:17 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sTxqm-0002zv-7b
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 02:09:17 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-70af4868d3dso4867572b3a.3
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 23:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721196553; x=1721801353; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KWgoYLfzMnfDNpgTk3QgWKgKCgGOVK31L1W5B2Ww47g=;
 b=veWzBQxD0YVDv6FJjCz+6Ju1yJ99iN2ZlHVsffzKZNgi33aRdisbUzD7Lo6uWWlxO5
 mDycysinnE9PAjS5PMVmAs4vS2OLQL9A/wxxQ/ncduje1RMxZEqejurQ7qXAyBCRbk9z
 ME5apeYRetdh/PxJkBO44BrGMfnTbS+23HoUV9OTAAmLl1oJOBxRIX27byoWEe3gQpm1
 AoJB+WkTVfrIWsA+nNEEzGb5kMzlGUnx0TowSOI47XYcZkyIWTgzbcpuG81j0906WRK2
 OIGMvSCBTTOgBvwPrBgD8yPffkA8M4QB+Xmoka8GTLVitgPUnB9v8qvGxfgqgb5qb33K
 kijQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721196553; x=1721801353;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KWgoYLfzMnfDNpgTk3QgWKgKCgGOVK31L1W5B2Ww47g=;
 b=dNxrX/4lDRnEnEAnCh50rugnocmdU5V2PTiuEUxMbEC+LYGMwPelkhkp/G+I2r95+G
 6G2H4ryASx4O9MqBVc/U3Go38GcUW8fx8FT3ZVLtgYOknaD2E20WrMmGb4/woQ2L6Dqg
 Gb9xVG9tNtHHSwgv849f0Za1fELyqnlVT7+2LfKu/nCi+QNNXZ6Pi6eKA2AfL3L7lQY0
 UzjGNZ6V4bkvhZrlotnebdLlcAC/EILoWwN+3ZgryCot42N3JXGT64hFd6oqryoRVKcl
 ADohph6Fcwk00imkl1o+YWMjuekmZqXdiFTn29E4kdYEHVf+KgIAWwxjhZyLx2tJd784
 ywmw==
X-Gm-Message-State: AOJu0YwFphwd0GMf4j9cSFZTGjyBBlxHZSU0L01N06R8KDvSgYq1GqRx
 d0FJBk/XsZDgqWmYhHRDB842yXAp2MvGpNrGSrak1Xv1rMHzXmk7SF6Ss90m0cbHGxkZCAU28QR
 w3HM=
X-Google-Smtp-Source: AGHT+IENJdX+sd2EvgsVhhsmOOBx+QxXg372T2mXj71VnuhB1YP3b5epQuoEYW2wyfr1bbUsEBv83A==
X-Received: by 2002:a05:6a00:2d28:b0:704:209a:c59e with SMTP id
 d2e1a72fcca58-70ce4fb5cfdmr788811b3a.9.1721196553444; 
 Tue, 16 Jul 2024 23:09:13 -0700 (PDT)
Received: from stoup.. ([203.56.128.103]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70b7ecd603bsm7330404b3a.219.2024.07.16.23.09.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jul 2024 23:09:13 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 01/17] target/arm: Use tcg_gen_extract2_i64 for EXT
Date: Wed, 17 Jul 2024 16:08:47 +1000
Message-ID: <20240717060903.205098-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240717060903.205098-1-richard.henderson@linaro.org>
References: <20240717060903.205098-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The extract2 tcg op performs the same operation
as the do_ext64 function.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c | 23 +++--------------------
 1 file changed, 3 insertions(+), 20 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 559a6cd799..e4c8a20f39 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -8849,23 +8849,6 @@ static void disas_data_proc_fp(DisasContext *s, uint32_t insn)
     }
 }
 
-static void do_ext64(DisasContext *s, TCGv_i64 tcg_left, TCGv_i64 tcg_right,
-                     int pos)
-{
-    /* Extract 64 bits from the middle of two concatenated 64 bit
-     * vector register slices left:right. The extracted bits start
-     * at 'pos' bits into the right (least significant) side.
-     * We return the result in tcg_right, and guarantee not to
-     * trash tcg_left.
-     */
-    TCGv_i64 tcg_tmp = tcg_temp_new_i64();
-    assert(pos > 0 && pos < 64);
-
-    tcg_gen_shri_i64(tcg_right, tcg_right, pos);
-    tcg_gen_shli_i64(tcg_tmp, tcg_left, 64 - pos);
-    tcg_gen_or_i64(tcg_right, tcg_right, tcg_tmp);
-}
-
 /* EXT
  *   31  30 29         24 23 22  21 20  16 15  14  11 10  9    5 4    0
  * +---+---+-------------+-----+---+------+---+------+---+------+------+
@@ -8903,7 +8886,7 @@ static void disas_simd_ext(DisasContext *s, uint32_t insn)
         read_vec_element(s, tcg_resl, rn, 0, MO_64);
         if (pos != 0) {
             read_vec_element(s, tcg_resh, rm, 0, MO_64);
-            do_ext64(s, tcg_resh, tcg_resl, pos);
+            tcg_gen_extract2_i64(tcg_resl, tcg_resl, tcg_resh, pos);
         }
     } else {
         TCGv_i64 tcg_hh;
@@ -8924,10 +8907,10 @@ static void disas_simd_ext(DisasContext *s, uint32_t insn)
         read_vec_element(s, tcg_resh, elt->reg, elt->elt, MO_64);
         elt++;
         if (pos != 0) {
-            do_ext64(s, tcg_resh, tcg_resl, pos);
+            tcg_gen_extract2_i64(tcg_resl, tcg_resl, tcg_resh, pos);
             tcg_hh = tcg_temp_new_i64();
             read_vec_element(s, tcg_hh, elt->reg, elt->elt, MO_64);
-            do_ext64(s, tcg_hh, tcg_resh, pos);
+            tcg_gen_extract2_i64(tcg_resh, tcg_resh, tcg_hh, pos);
         }
     }
 
-- 
2.43.0


