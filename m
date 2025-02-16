Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33643C02198
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2025 23:36:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjnuZ-0004ie-GJ; Sun, 16 Feb 2025 18:18:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjntK-0002sA-6I
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:17:38 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjntG-00063o-Vk
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:17:36 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2211cd4463cso11956405ad.2
 for <qemu-devel@nongnu.org>; Sun, 16 Feb 2025 15:17:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739747853; x=1740352653; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=1RvvgZaKuSF9edcsX84Gnnmj3wiiQW6WmhJ/O+pUWs0=;
 b=VoYR2HM9kzDDCEgxrLUI2PCGViDCN5+Fk/wCyD8SXQ1SZQfW0c64ArktWZJJsXG2fX
 O2TGFN70Mybfh9fM5Rp3d/sBsnxqCfd8pGaqTXaK3THs6CXNhHvmSoV8vjlHP+0Hx4wJ
 wjJbOSTTc8igUx2wUpGcGK7oi0TU/CFQ5MZF/upxIoQngEeM6hAoKwFMdPpgfSVEALSp
 +WFFnOv1I7IoPSDDfDLO3ZDjEoyNICQsPYxJPLI/eLDfn81QvnOxefuhfsDIsiaV/gcQ
 ooTyAMfCmNGQsIfUQ1XmyH9I3JJWzUsieforzbwAx19sIc0va536T4jFBhhgVfgrpyFb
 fphg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739747853; x=1740352653;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1RvvgZaKuSF9edcsX84Gnnmj3wiiQW6WmhJ/O+pUWs0=;
 b=r74g63pblWoKES21SW+xVkc3JREcxFRNxJmwbMpahQIg1MSNX7gyrkYbbmwmjui8KL
 pQ8bmn98FUboEqAWpFA8gA2F/NUp4B2tz+rp1M6XanbzTjrvKE5Mp9ibgrvndFiXe0qb
 U21YN8F9UlE4ck+cBX0Fe8BU0Q66V8cHZSqu6XvL7HM4V2MmroZYJYbl2C/cwM+lNudf
 UGghDHIaCYbpQ0Ox9rng6lXdsmeUzQzjlZce4THJAeNsYzyX3SK6gfKV9p6sRMR7GPT4
 32wKwjuis6aSGYDXKBJmEItlmihx5piviIXBCOiCJFGspTW31unM/tX2sYNns7cX3O+h
 G1kg==
X-Gm-Message-State: AOJu0YzFQQ2j38tBBF9jJ8TBFFMzUFsqtgUhnssfRC2irEWHSd6HUbIH
 z4XNhpUSpwrA5By1gLoiYA28p3bZTfOH5Myv5xRdOOkRXhCJN9udZ/VO+lBCir+U1LcPaAxA1aC
 b
X-Gm-Gg: ASbGnct8gpd6Uit/vbbFMZWW0g3xNKIlrli1lpowRz+4Ih3rVFG0nKYrQyfPrsGm0zO
 h5vGwPO5w+8zW/VV3jCvqYn41c7H890pfwJFwkmWb/xv4Zboc8vDtU2hc/R7dGy4s0I9CvodEqI
 2bpMUSft3gvdsEdEAm8xaWV/ZyV+RqdR+Do+crj42pBx+GiyuQ5he1FhGMLRM57woHreHB7BiZl
 QUwq4idiyxk9M+SgGqA/A2n9zp4v6LfF68GHl1L0uJ7Z4To1VVVsKXfrlUFsKHLFett9JH1347A
 eLqwxI25DQOs3dnGPrNJ9+K0FQNIVXxrvyr1B5WGlIFQapE=
X-Google-Smtp-Source: AGHT+IEtdGnQ9YdZBzzgDpdh/cpBdIupSgZ+e5zR13ZOwRjgd+t5QxYcAhxqjhDmtCuKRToq/UAyjQ==
X-Received: by 2002:a17:902:f651:b0:216:6283:5a8c with SMTP id
 d9443c01a7336-221040b1310mr127153465ad.39.1739747853328; 
 Sun, 16 Feb 2025 15:17:33 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2213394d6c8sm5449885ad.181.2025.02.16.15.17.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2025 15:17:32 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 105/162] tcg: Expand fallback add2 with 32-bit operations
Date: Sun, 16 Feb 2025 15:09:14 -0800
Message-ID: <20250216231012.2808572-106-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250216231012.2808572-1-richard.henderson@linaro.org>
References: <20250216231012.2808572-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

No need to expand to i64 to perform the add.
This may smaller on a loongarch64 host, e.g.

	bstrpick_d  r28, r27, 31, 0
	bstrpick_d  r29, r24, 31, 0
	add_d       r28, r28, r29
	addi_w      r29, r28, 0
	srai_d      r28, r28, 32
  ---
	add_w       r28, r27, r24
	sltu        r29, r28, r24

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg-op.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index edbb214f7c..8b1356c526 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -1105,14 +1105,15 @@ void tcg_gen_add2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 al,
     if (TCG_TARGET_HAS_add2_i32) {
         tcg_gen_op6_i32(INDEX_op_add2_i32, rl, rh, al, ah, bl, bh);
     } else {
-        TCGv_i64 t0 = tcg_temp_ebb_new_i64();
-        TCGv_i64 t1 = tcg_temp_ebb_new_i64();
-        tcg_gen_concat_i32_i64(t0, al, ah);
-        tcg_gen_concat_i32_i64(t1, bl, bh);
-        tcg_gen_add_i64(t0, t0, t1);
-        tcg_gen_extr_i64_i32(rl, rh, t0);
-        tcg_temp_free_i64(t0);
-        tcg_temp_free_i64(t1);
+        TCGv_i32 t0 = tcg_temp_ebb_new_i32();
+        TCGv_i32 t1 = tcg_temp_ebb_new_i32();
+        tcg_gen_add_i32(t0, al, bl);
+        tcg_gen_setcond_i32(TCG_COND_LTU, t1, t0, al);
+        tcg_gen_add_i32(rh, ah, bh);
+        tcg_gen_add_i32(rh, rh, t1);
+        tcg_gen_mov_i32(rl, t0);
+        tcg_temp_free_i32(t0);
+        tcg_temp_free_i32(t1);
     }
 }
 
-- 
2.43.0


