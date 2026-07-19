Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57DD2C4451B
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jul 2026 17:50:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlVds-0000jH-JR; Sun, 19 Jul 2026 13:49:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wlVde-0000ej-BG
 for qemu-devel@nongnu.org; Sun, 19 Jul 2026 13:49:18 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wlVdc-0003CJ-Pu
 for qemu-devel@nongnu.org; Sun, 19 Jul 2026 13:49:18 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2cae1a3a744so70753645ad.3
 for <qemu-devel@nongnu.org>; Sun, 19 Jul 2026 10:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784483355; x=1785088155; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cmppddNv7Pj2UPySj8zRnZ2ypnKj0mTQMSjcsVIS5c8=;
 b=iDLGH7QBRs+Lkq4Dt9BC6JhH1Pqxe9TwUcgfo8O68OSkJ+DxUcKUHTJXfXZCN10PSm
 sWtdTH0smqowqtAl+I/rNRijLRZsOfj57YJxiY+wjrotgD5qK9FE4wb7R0JokslUE7RV
 jPyZ3zbi5XV/3+K8jzvTB4ed22X4GNHzCSBq+D9qQhvuDo4rDOdugwOyhIZUjYuINX+h
 tyMAH1XwQhX+71v8tSXkjyimMVL2u0bNL2lrXornbkkDmrFluM8RRntegIub1MXLYtux
 alcwNmezhodWkIx6c1Y9lnTvqhTNAllbQcPjbJcVVtToNucYmaXExe1ym5g8YfBBxrF3
 6kgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784483355; x=1785088155;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=cmppddNv7Pj2UPySj8zRnZ2ypnKj0mTQMSjcsVIS5c8=;
 b=f/IkmiEd3ezrZdEgdUnfHNGpYQQAz9fU4Qplt//5XT+3YB2v7LAjpiLLxVIJsXic3s
 0/S9zFVpOTe9IxKwIkYtVlVph1d3ts9J8tP27Qkguw2K4gba7cIJS6X37tm6s7VTMUcn
 pRyBpkh9ilMSPB6kMhUR6v1JKM82tiIcg/abyANYx/c5DH13lAQe5hB27or782f30ZH4
 G7/oQj67lRQt6pzwWclD417/9Xod3EpY6h1di/zrMKsq1gPGQn51YMWEO23b6mHkfP7f
 6/Ldv6DWypDFYc54dt3JvX8ZdY6b/eR05oxgOCYqbQPkjiu+j90yb/I1AyYhu3R5OTPZ
 oCFQ==
X-Gm-Message-State: AOJu0YzgBA7euuCzUSjkVelvRr8+ScwPpl8R1MYM/ECc5l2ONHEdSCUs
 E3P/YWr6qbxxPQoaPjTSF/dGiHOi/XxX5gFatLgE3GAyJVLgsg8LRKHBOWCckD2FHGfaz5LC5mK
 p03Mq
X-Gm-Gg: AfdE7ckxXFVJy0BZqSebvk0iyKreyzGoZ/c9afQwEIe2KGWH0g9P5yoTCdl1tw1CkRY
 cwlw34H4vEq2Cs0c7VjSaZ2Gezm3Md5WUTHcvm18L3Vtr+WUgEN1gbKtuF9rTNlER12fYBG3k2r
 aHaCHY2HfWbjjdcsr0m7Mn9xRsqqrb7DMKEOXzjgmnOehhgwb+bmfjPFSjuHpACj0CI4MaevOcg
 Edk77dJDfUdarkiVT4kV5YZJxdVaj3M6OniUEZMX4xEOcYtn1uztNMaIaOUSTcbkyNwS0fb+284
 4fQqnDCt011UEnpmR3xGAsyv0F6gNk12J7YZtzZCAxgd79t4glUEZR0IFFU6VqdlQh+qtC5vcbi
 6z7VlspSqeCVkZeEnfrGMMdRuM8+t0Iphs8Ntkx/IZyaCsGKU4cWlkekj5fro2II680e7FPVPen
 BGK+unhpw=
X-Received: by 2002:a05:6a20:2583:b0:3c3:8d86:9855 with SMTP id
 adf61e73a8af0-3c3ad668353mr11543722637.7.1784483355068; 
 Sun, 19 Jul 2026 10:49:15 -0700 (PDT)
Received: from stoup.. ([32.140.233.50]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3142a20c158sm30471881eec.29.2026.07.19.10.49.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Jul 2026 10:49:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	qemu-stable@nongnu.org
Subject: [PATCH 3/6] target/arm: Fix b16b16 feature test for SME2 BFCLAMP,
 BFMAX, BFMIN
Date: Sun, 19 Jul 2026 10:49:02 -0700
Message-ID: <20260719174905.420725-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260719174905.420725-1-richard.henderson@linaro.org>
References: <20260719174905.420725-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

These are controlled by FEAT_SVE_B16B16 not FEAT_SME_B16B16.

Cc: qemu-stable@nongnu.org
Fixes: bc65d2bd1cb ("target/arm: Implement SME2 Multiple and Single SVE Destructive")
Fixes: 930760eb753 ("target/arm: Implement SME2 Multiple Vectors SVE Destructive")
Fixes: 8b61eff8e72 ("target/arm: Implement SME2 FCLAMP, SCLAMP, UCLAMP")
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-sme.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index 5f02d462d3..ca88b3cdcc 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -758,7 +758,7 @@ static bool do_zzz_n1_fpst(DisasContext *s, arg_zzz_en *a,
         return false;
     }
     /* These insns use MO_8 to encode BFloat16. */
-    if (esz == MO_8 && !dc_isar_feature(aa64_sme_b16b16, s)) {
+    if (esz == MO_8 && !dc_isar_feature(aa64_sve_b16b16, s)) {
         return false;
     }
     if (!sme_sm_enabled_check(s)) {
@@ -795,7 +795,7 @@ static bool do_zzz_nn_fpst(DisasContext *s, arg_zzz_en *a,
     if (fn == NULL) {
         return false;
     }
-    if (esz == MO_8 && !dc_isar_feature(aa64_sme_b16b16, s)) {
+    if (esz == MO_8 && !dc_isar_feature(aa64_sve_b16b16, s)) {
         return false;
     }
     if (!sme_sm_enabled_check(s)) {
@@ -1850,7 +1850,7 @@ static bool trans_FCLAMP(DisasContext *s, arg_zzz_en *a)
         return false;
     }
     /* This insn uses MO_8 to encode BFloat16. */
-    if (a->esz == MO_8 && !dc_isar_feature(aa64_sme_b16b16, s)) {
+    if (a->esz == MO_8 && !dc_isar_feature(aa64_sve_b16b16, s)) {
         return false;
     }
     if (!sme_sm_enabled_check(s)) {
-- 
2.43.0


