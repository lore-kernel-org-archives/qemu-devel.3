Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEDB2EE6426
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 02:46:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soZm0-00032p-G3; Wed, 11 Sep 2024 22:41:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1soZls-0002Y8-Vt
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 22:41:25 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1soZlq-00048G-Vv
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 22:41:24 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-205909af9b5so4843015ad.3
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 19:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726108881; x=1726713681; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hCg9x0mWGGumEFO2TzIOUcSJLT2z1d9b8LgujqgHrcQ=;
 b=M96BesC8+ranaxrZVRoK0ii5RnS7u+2YOJ+twAhaPXPh4Sx07x3CyfX/yupHI1rSZT
 11tFi4/xhpms1gqS/wweCA58rzEUkUgexdSRI29tk9h9pNwjHYUwvDkuOpWAqlyhpYHp
 ScoyjZST5O9fj4pSJ5xS9npDKfWu6bCKDO3vr7rB7tL6p+2iB96bu3yGkgCvsF0Jn7bW
 IyN6BlstV70Phr90MC1a/d6Gm4bcaYKOTE9eoPJWLxTwAliud/N6ZV1vgaOFiuVTNUMq
 QZ/6DUXiEPykLJgygYDnkm9V9fPXXTsBWgFAu9/PFTlhsZL/8B4n9Fi11DVsM+B/ScbI
 tG0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726108881; x=1726713681;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hCg9x0mWGGumEFO2TzIOUcSJLT2z1d9b8LgujqgHrcQ=;
 b=agyXJUwDrhNuAsyViKajFbg1oh4bjds+xz7bC3ll0MH5Qqe34oMiW5hM2rayDsZmII
 aJoAaDwXGrxWFA5vLlfMzT1paM2LFfTsOHqJ8AKduZRiDb38kkfWJAp3DDVvQRNbg7Kh
 KsGVbIGVRlb0ftugi7sg+8JpUGD+szv9PmGNlPTSHxif4Qx5s1SOqlHkz+ndpjZDBQyN
 GR0syhigbJvxyvH4nq1wwuKzHivEN2/vaLuqaNVeZKMe+DQDy1nA99/LA23HlX/jid2I
 cn6guti8WDDtDkBlyfPDyw5uMRF4YToX3miwOcQhPfN7Pnrm9GfZHwOourhtpWEML9m5
 n4HQ==
X-Gm-Message-State: AOJu0YwPVx+UuKWgox2pEbM4fwpw2qbSpJyK1+I1h52HSEjSqd8SVHxh
 QLlOpTz0B5H4I2DPES8rIeCKlfmLwALTXfSh0BbTK9ArtJ+dusX2QbEetXhdKKSxgUv1fyvb3B0
 O
X-Google-Smtp-Source: AGHT+IFEZmRj29/TzxoOD+1SbMd48hn4OPd3U+E2TCkhZzH4Y6MFgMVy7LNSGeZVqby0aFDPknXXdQ==
X-Received: by 2002:a17:903:2302:b0:207:20c5:42c with SMTP id
 d9443c01a7336-2076e40be2dmr22874495ad.45.1726108881334; 
 Wed, 11 Sep 2024 19:41:21 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2076afe9c61sm5635915ad.231.2024.09.11.19.41.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2024 19:41:20 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v3 05/29] target/arm: Use tcg_gen_extract2_i64 for EXT
Date: Wed, 11 Sep 2024 19:40:50 -0700
Message-ID: <20240912024114.1097832-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240912024114.1097832-1-richard.henderson@linaro.org>
References: <20240912024114.1097832-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

The extract2 tcg op performs the same operation
as the do_ext64 function.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c | 23 +++--------------------
 1 file changed, 3 insertions(+), 20 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 6d5f12e8f5..1a0b2bb33b 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -8890,23 +8890,6 @@ static void disas_data_proc_fp(DisasContext *s, uint32_t insn)
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
@@ -8944,7 +8927,7 @@ static void disas_simd_ext(DisasContext *s, uint32_t insn)
         read_vec_element(s, tcg_resl, rn, 0, MO_64);
         if (pos != 0) {
             read_vec_element(s, tcg_resh, rm, 0, MO_64);
-            do_ext64(s, tcg_resh, tcg_resl, pos);
+            tcg_gen_extract2_i64(tcg_resl, tcg_resl, tcg_resh, pos);
         }
     } else {
         TCGv_i64 tcg_hh;
@@ -8965,10 +8948,10 @@ static void disas_simd_ext(DisasContext *s, uint32_t insn)
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


