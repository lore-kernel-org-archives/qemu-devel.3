Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA59DC25B7C
	for <qemu-devel@archiver.kernel.org>; Sun, 26 May 2024 19:47:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBJm4-00006g-Ig; Sun, 26 May 2024 15:43:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sBJm3-0008WF-3c
 for qemu-devel@nongnu.org; Sun, 26 May 2024 15:43:19 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sBJm1-0007k1-E7
 for qemu-devel@nongnu.org; Sun, 26 May 2024 15:43:18 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1f4a6a54416so204415ad.0
 for <qemu-devel@nongnu.org>; Sun, 26 May 2024 12:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716752596; x=1717357396; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EX+QV+CHHePwxPsiyNBRoejlOxczbh35LfPai+gzCtI=;
 b=GLQKT1/dIUBMeCNjt2z/S1XwCc5cZlzm8E0p1/D2q1upttzclH6yPTdffzvKGDBrbx
 4m5A5LYtxm+6tnAmi5jAZ915vJxI22F7pjQ+NXexqGjFXwC/yFYzrJbLAsdqJp/EJ+IQ
 q/SvC5128BRFweY85wiQZxs/b9PkL7UOwjytQh+Xcr6dd20BMFn42kFVPerhJ0gAgk75
 1Qbs5NpiULjLVbA27gBuM4g2GzO8zNC++Fjs+CbOHfMUSd361+EMJDu0LJEmXqor+7w4
 R6ImCx1GpVT3KIEaakvkCCm7z2tdUxF1mlbl0jFJjoXfMgj5orIPBmxC5T+svreK3UsJ
 3lNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716752596; x=1717357396;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EX+QV+CHHePwxPsiyNBRoejlOxczbh35LfPai+gzCtI=;
 b=cmi4m5h/3Janso3AaD6c9mqQ83/mZufmSPOdD3ZrEpVJCLxHwenQl9HwdT4BHokDCk
 9JGLtpg/1c/RYSofEL14PI62r1+DYKYTwTOmvGh3Mzd2o0UnmKxchfDA6iMHup1oeUsH
 wDGBPI5rM9f99/yD1Y6d9XiKNEXIFrOHqKt9BnWLJ6LkYOwMDUQyMQJA7/oaZihrmiQe
 deqJs+BGmLKf6EIsN5rDS8X1R27Cr1fI6cnW9X9YnLTMdgmr19BGiHlmZaOiR7VKkfkY
 ujWG9amTGvPwaPyEsHc+vfwIBdjqE04ON8IWEZVstPWeZdTiUAEVbBpi2HeBaHRbFDmu
 FvpQ==
X-Gm-Message-State: AOJu0YyPpzA0fBgDuYyCMuiBbnPfL8929d4B3XdYTT2fW0EKjxbea5Gz
 KWrx836gsxzG60lHWxtdYU7NrJQxVKIyHejTkrqTzISWZAxcrXhMO2X4q44ra9izMetYEsQk+dn
 L
X-Google-Smtp-Source: AGHT+IHDJRW97hpidsy2uP8UKJkAMir0v/O3fRnnhMjdZ0+aihHjsRee1HlYRAO4/HvH99c9PmzMzw==
X-Received: by 2002:a17:902:d483:b0:1f4:9158:1022 with SMTP id
 d9443c01a7336-1f491581127mr20323155ad.14.1716752596089; 
 Sun, 26 May 2024 12:43:16 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f46ad93c2esm28165935ad.263.2024.05.26.12.43.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 May 2024 12:43:15 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 26/37] target/sparc: Implement XMULX
Date: Sun, 26 May 2024 12:42:43 -0700
Message-Id: <20240526194254.459395-27-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240526194254.459395-1-richard.henderson@linaro.org>
References: <20240526194254.459395-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/helper.h     |  2 ++
 target/sparc/insns.decode |  2 ++
 target/sparc/translate.c  |  4 ++++
 target/sparc/vis_helper.c | 11 +++++++++++
 4 files changed, 19 insertions(+)

diff --git a/target/sparc/helper.h b/target/sparc/helper.h
index 4ae97866af..fe0d8bc593 100644
--- a/target/sparc/helper.h
+++ b/target/sparc/helper.h
@@ -135,6 +135,8 @@ DEF_HELPER_FLAGS_2(fcmpeq8, TCG_CALL_NO_RWG_SE, i64, i64, i64)
 DEF_HELPER_FLAGS_2(fcmpne8, TCG_CALL_NO_RWG_SE, i64, i64, i64)
 DEF_HELPER_FLAGS_2(fcmpule8, TCG_CALL_NO_RWG_SE, i64, i64, i64)
 DEF_HELPER_FLAGS_2(fcmpugt8, TCG_CALL_NO_RWG_SE, i64, i64, i64)
+DEF_HELPER_FLAGS_2(xmulx, TCG_CALL_NO_RWG_SE, i64, i64, i64)
+DEF_HELPER_FLAGS_2(xmulxhi, TCG_CALL_NO_RWG_SE, i64, i64, i64)
 #endif
 #undef VIS_HELPER
 #undef VIS_CMPHELPER
diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index 508175eccd..1d54de5367 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -391,6 +391,8 @@ FCMPEq      10 000 cc:2 110101 .....  0 0101 0111 .....    \
     ADDXCcc     10 ..... 110110 ..... 0 0001 0011 .....    @r_r_r
     UMULXHI     10 ..... 110110 ..... 0 0001 0110 .....    @r_r_r
     LZCNT       10 ..... 110110 00000 0 0001 0111 .....    @r_r2
+    XMULX       10 ..... 110110 ..... 1 0001 0101 .....    @r_r_r
+    XMULXHI     10 ..... 110110 ..... 1 0001 0110 .....    @r_r_r
 
     ALIGNADDR   10 ..... 110110 ..... 0 0001 1000 .....    @r_r_r
     ALIGNADDRL  10 ..... 110110 ..... 0 0001 1010 .....    @r_r_r
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 7bf1e7687e..11c933af75 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -90,6 +90,8 @@
 # define gen_helper_fxtoq                ({ qemu_build_not_reached(); NULL; })
 # define gen_helper_fxtos                ({ qemu_build_not_reached(); NULL; })
 # define gen_helper_pdist                ({ qemu_build_not_reached(); NULL; })
+# define gen_helper_xmulx                ({ qemu_build_not_reached(); NULL; })
+# define gen_helper_xmulxhi              ({ qemu_build_not_reached(); NULL; })
 # define MAXTL_MASK                             0
 #endif
 
@@ -5084,6 +5086,8 @@ TRANS(FPCMPULE8, VIS3B, do_rdd, a, gen_helper_fcmpule8)
 TRANS(FPCMPUGT8, VIS3B, do_rdd, a, gen_helper_fcmpugt8)
 
 TRANS(PDISTN, VIS3, do_rdd, a, gen_op_pdistn)
+TRANS(XMULX, VIS3, do_rrr, a, gen_helper_xmulx)
+TRANS(XMULXHI, VIS3, do_rrr, a, gen_helper_xmulxhi)
 
 static bool do_env_ddd(DisasContext *dc, arg_r_r_r *a,
                        void (*func)(TCGv_i64, TCGv_env, TCGv_i64, TCGv_i64))
diff --git a/target/sparc/vis_helper.c b/target/sparc/vis_helper.c
index c21522c533..c927a054b8 100644
--- a/target/sparc/vis_helper.c
+++ b/target/sparc/vis_helper.c
@@ -20,6 +20,7 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "exec/helper-proto.h"
+#include "crypto/clmul.h"
 
 target_ulong helper_array8(target_ulong rs1, target_ulong rs2)
 {
@@ -509,3 +510,13 @@ uint64_t helper_fslas32(uint64_t src1, uint64_t src2)
 
     return r.ll;
 }
+
+uint64_t helper_xmulx(uint64_t src1, uint64_t src2)
+{
+    return int128_getlo(clmul_64(src1, src2));
+}
+
+uint64_t helper_xmulxhi(uint64_t src1, uint64_t src2)
+{
+    return int128_gethi(clmul_64(src1, src2));
+}
-- 
2.34.1


