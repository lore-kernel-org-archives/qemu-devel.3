Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6C1FC4345F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 01:15:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3mqI-0001Le-FB; Sun, 05 May 2024 21:08:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s3mpd-0007eI-2h
 for qemu-devel@nongnu.org; Sun, 05 May 2024 21:07:54 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s3mpW-0003MI-1v
 for qemu-devel@nongnu.org; Sun, 05 May 2024 21:07:52 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-6f44e3fd382so897783b3a.1
 for <qemu-devel@nongnu.org>; Sun, 05 May 2024 18:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714957665; x=1715562465; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OWoN8rIDjYKzkHikiqSLDwjV9UowPQlh2PhAhnTcBuo=;
 b=WEuWDBZQ3oRBlSFq0pnrNfD4P9U/su8exWwXoYOQdm1vdO9MYTAqb0B83M+S/yj6Mo
 6+LKAHQvw1Qnm4yRulFHsaUKoeHTZ40FaA/2UShHhCLjwxTPNIlIfvQ+StvXRAdluSeo
 /mqOGU2yGKnyh6AWjZA/mzbJH930O6t5xA/yuOJhlP8pcnIN4peXFr9K1xs8sOFlrzD1
 /eFUM/gEmfM6dDxwnOuGo6mhBJmwgae9tFWHBFNu2ANXUwdagCpOM0s+W/1DNanDuwX1
 HPXj1/YPkmUYxn1bo/GCNKHgxTyt5Yu3zMiv7IjDOgHj5/WdPDE/fAChc9fJQXmKke+K
 RzIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714957665; x=1715562465;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OWoN8rIDjYKzkHikiqSLDwjV9UowPQlh2PhAhnTcBuo=;
 b=BhwNbvSsh5ZKOOXC44z96y1POEseSYyLkVsFQFTh9JndZA4r4b3xX/w35+nzKUa/v2
 /+Ynw0n7zencY8DFL3R3d+qLGvEFxoEiauFHnBseLsszWpT9V1506dTjYsGExR+qNFBV
 kkSjJFrnoWC+QaakGh19h/DthP2PpNcLOrpz0y4G08fHDcmjJKThwUx3wcvQATBU3CrO
 0Uz7ifktKClur4u1WAKEF9wGrOHpa4mJdXF9s9+ioHeR6NLtEkjmH1k3fJ8LkcCHUAi8
 V4enLG5PMSS3shhzb4OmT5g8vXmdsgUndYpXJYti5FtE49Ao3GEkOKDsyTzlRwwa5WHZ
 3Usw==
X-Gm-Message-State: AOJu0YwabAsUJ9DxkbOarEXgb3aKQWVauJfIFONrhaKauuMRppqsfcbb
 D7PtM0qE5mig0k/H3xR2pwMChW+PonPPoPexngU2exB3GAz6vtMZsbCEW32BgLeW4oUOxzlQFAy
 S
X-Google-Smtp-Source: AGHT+IE5yQYKImDcYB35BZ0iksz6NyUcYmOKn7LOOIwmlkZBxABIOukD54sDtxJfpv4DiO/T3AUqEQ==
X-Received: by 2002:a05:6a21:9184:b0:1af:a1bc:b4ff with SMTP id
 tp4-20020a056a21918400b001afa1bcb4ffmr3713754pzb.37.1714957664715; 
 Sun, 05 May 2024 18:07:44 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 kp4-20020a056a00464400b006e580678dfbsm6577287pfb.193.2024.05.05.18.07.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 May 2024 18:07:44 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 47/57] target/arm: Convert SHADD, UHADD to decodetree
Date: Sun,  5 May 2024 18:03:53 -0700
Message-Id: <20240506010403.6204-48-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240506010403.6204-1-richard.henderson@linaro.org>
References: <20240506010403.6204-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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
 target/arm/tcg/a64.decode      |  2 ++
 target/arm/tcg/translate-a64.c | 11 +++--------
 2 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index d97390cacb..0881f00ecf 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -912,6 +912,8 @@ CMGE_v          0.00 1110 ..1 ..... 00111 1 ..... ..... @qrrr_e
 CMHS_v          0.10 1110 ..1 ..... 00111 1 ..... ..... @qrrr_e
 CMTST_v         0.00 1110 ..1 ..... 10001 1 ..... ..... @qrrr_e
 CMEQ_v          0.10 1110 ..1 ..... 10001 1 ..... ..... @qrrr_e
+SHADD_v         0.00 1110 ..1 ..... 00000 1 ..... ..... @qrrr_e
+UHADD_v         0.10 1110 ..1 ..... 00000 1 ..... ..... @qrrr_e
 
 ### Advanced SIMD scalar x indexed element
 
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 4f7d03b5f2..c70c3cec2a 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -5455,6 +5455,8 @@ TRANS(UQRSHL_v, do_gvec_fn3, a, gen_neon_uqrshl)
 
 TRANS(ADD_v, do_gvec_fn3, a, tcg_gen_gvec_add)
 TRANS(SUB_v, do_gvec_fn3, a, tcg_gen_gvec_sub)
+TRANS(SHADD_v, do_gvec_fn3_no64, a, gen_gvec_shadd)
+TRANS(UHADD_v, do_gvec_fn3_no64, a, gen_gvec_uhadd)
 
 static bool do_cmop_v(DisasContext *s, arg_qrrr_e *a, TCGCond cond)
 {
@@ -10914,7 +10916,6 @@ static void disas_simd_3same_int(DisasContext *s, uint32_t insn)
             return;
         }
         /* fall through */
-    case 0x0: /* SHADD, UHADD */
     case 0x2: /* SRHADD, URHADD */
     case 0x4: /* SHSUB, UHSUB */
     case 0xc: /* SMAX, UMAX */
@@ -10940,6 +10941,7 @@ static void disas_simd_3same_int(DisasContext *s, uint32_t insn)
         }
         break;
 
+    case 0x0: /* SHADD, UHADD */
     case 0x01: /* SQADD, UQADD */
     case 0x05: /* SQSUB, UQSUB */
     case 0x06: /* CMGT, CMHI */
@@ -10959,13 +10961,6 @@ static void disas_simd_3same_int(DisasContext *s, uint32_t insn)
     }
 
     switch (opcode) {
-    case 0x00: /* SHADD, UHADD */
-        if (u) {
-            gen_gvec_fn3(s, is_q, rd, rn, rm, gen_gvec_uhadd, size);
-        } else {
-            gen_gvec_fn3(s, is_q, rd, rn, rm, gen_gvec_shadd, size);
-        }
-        return;
     case 0x0c: /* SMAX, UMAX */
         if (u) {
             gen_gvec_fn3(s, is_q, rd, rn, rm, tcg_gen_gvec_umax, size);
-- 
2.34.1


