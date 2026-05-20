Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5FBBCD5BAB
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 18:33:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPlcV-0004fC-Ok; Wed, 20 May 2026 14:26:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wPlc5-0003zh-Sc
 for qemu-devel@nongnu.org; Wed, 20 May 2026 14:25:50 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wPlc3-00021F-S5
 for qemu-devel@nongnu.org; Wed, 20 May 2026 14:25:49 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-c828daf83e2so2454062a12.2
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 11:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779301546; x=1779906346; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rijKST64WZpELrwBb6/Q5we+Vkq4bBbLxG5KgrYkJ+U=;
 b=axyU+hdiZ/CLJGixeMVhStR0+ra5iADi8zjKl5EmgFrSzbQID1aNecdOMM3fG9ozWp
 zokfZCbdAl+rlDFe0x1vkX9S6rWi+/yp6IwhEbZ7PwZcMT7BlLKOrhrbWkRl3qB63skz
 l+CSgiRjJ7LwvrDytFGTBflRqcm8oqw5Im19c9yEv9KlFIzASbFsrOMXiCcsVooSVsO/
 zTBkE55g81/pwNjY4fwGf0Tv5r46P41RkoeWfuVcYEkpHkGJZWFAQnFUBFWSgUPJD+mG
 36kTkYGu5p1fga86qUecEZ6rM+bu5MYWQiL7uynJ/dTKXPCuQr8UTBjiRjHot7tg6jP4
 ee4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779301546; x=1779906346;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rijKST64WZpELrwBb6/Q5we+Vkq4bBbLxG5KgrYkJ+U=;
 b=hvHiv+SKHXfMB29UfqZG5hteW30lX56AN647esNnPVYnA55ztUzJB8ZxLeWK+C1XVt
 kWk7D5x4EgEMbl75A1iuTudutilmJalugn7aTX0eoRFtsJS1VigttSYpHxlFxM8l21aP
 0O2Buz6a9ZpiTqDeeG/NKLGMkAsZu9Lh1dwF2Ug5S7I3IvR8j20xxHVZAihBviy160Fr
 eaN16L6eZGD31kex0Zgt+d+XyGE1IfDNAadudtwKaMoSWs3Jh9r6ItZCAEq/9NlY1UYz
 HFxuEdgFo4VNRL627YEs8x/meUSY5gXe1Ol7UxgQX0oJB7QkQdEoUQja7vsGK8+76bmc
 DZng==
X-Gm-Message-State: AOJu0Yx5Pbav9CK3pU+Bcxf34D01YwjYZYJxp1jioiWxRQA/LJU/6XrA
 kXYL8IhJKe9C8bJlxL4itaSZiwxMiZjT3hq8SICvzkkG77WCtB2fg4XKqiz/+I56+vyPHwu/YkB
 gMpyGUpo=
X-Gm-Gg: Acq92OEgAACsOqKpw7k0zNMeGUchinlII7uxdcnZ6GdidEAzPYVtP7pP89l9qamRc4C
 hs89dfwFggzNwQFthR0t0iNGONod7BLCVaMkNnwdk6SbjXCPSMITW81+2JuLfTVJOMbaK3ueq2I
 ohVyMrTNoVgGwO7DgR3rW18nmv2C+dPuq/SIHZmbOJNH8lYvBxqF3eTrD8uZj6ICZ889vEIqZvw
 5CLRqOJs8nLgEmh8Vz0erZTbADHNKZUYyG0GnFjOuQtP45W9twcezWhmiO9T4nR+YaZmLICbUgh
 fcbsZuHuEjhTYi8Y+hyjXalLXi9ajWl/a0K1rvc0suy+5IZgRb5VIZPxiA/Hr7i5rEDAyBlKd91
 XJYdPIbxTlTas75HN2by6RVofhyImA7QgcUHTAMcG0/fr0wpqQW35WO6xwAF29GDxHlU4rVA9qP
 o/eCRpNb0WJ/c/+LSm/OhbuIBH4cUj
X-Received: by 2002:a17:90b:58cb:b0:368:6998:b49e with SMTP id
 98e67ed59e1d1-369519c3208mr22347809a91.9.1779301546157; 
 Wed, 20 May 2026 11:25:46 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2bd5c0605ddsm217413925ad.32.2026.05.20.11.25.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 11:25:45 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v6 43/64] target/arm: Implement MOVT (vector to table)
Date: Wed, 20 May 2026 11:21:52 -0700
Message-ID: <20260520182213.872945-44-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260520182213.872945-1-richard.henderson@linaro.org>
References: <20260520182213.872945-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52f.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu-features.h      |  5 +++++
 target/arm/tcg/translate-sme.c | 18 ++++++++++++++++++
 target/arm/tcg/sme.decode      |  2 ++
 3 files changed, 25 insertions(+)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 811f2a7291..29d0464a03 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1570,6 +1570,11 @@ static inline bool isar_feature_aa64_sme_fa64(const ARMISARegisters *id)
     return FIELD_EX64_IDREG(id, ID_AA64SMFR0, FA64);
 }
 
+static inline bool isar_feature_aa64_sme_lutv2(const ARMISARegisters *id)
+{
+    return FIELD_EX64_IDREG(id, ID_AA64SMFR0, LUTv2);
+}
+
 static inline bool isar_feature_aa64_sme2(const ARMISARegisters *id)
 {
     return FIELD_EX64_IDREG(id, ID_AA64SMFR0, SMEVER) != 0;
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index 2f79c458e1..214427db1f 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -391,6 +391,24 @@ static bool do_movt(DisasContext *s, arg_MOVT_rzt *a,
 TRANS_FEAT(MOVT_rzt, aa64_sme2, do_movt, a, tcg_gen_ld_i64)
 TRANS_FEAT(MOVT_ztr, aa64_sme2, do_movt, a, tcg_gen_st_i64)
 
+static bool trans_MOVT_ztz(DisasContext *s, arg_MOVT_ztz *a)
+{
+    if (!dc_isar_feature(aa64_sme_lutv2, s)) {
+        return false;
+    }
+    if (sme_sm_enabled_check(s) && sme2_zt0_enabled_check(s)) {
+        int svl = streaming_vec_reg_size(s);
+        int tsize = MIN(svl, 64);
+        int offset = (a->off % (64 / tsize)) * tsize;
+
+        tcg_gen_gvec_mov(MO_64,
+                         offsetof(CPUARMState, za_state.zt0) + offset,
+                         vec_full_reg_offset(s, a->rt), tsize,
+                         offset ? tsize : 64);
+    }
+    return true;
+}
+
 static bool trans_LDST1(DisasContext *s, arg_LDST1 *a)
 {
     typedef void GenLdSt1(TCGv_env, TCGv_ptr, TCGv_ptr, TCGv, TCGv_i64);
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index 2b9e41a75a..339de72b8a 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -141,6 +141,8 @@ MOVAZ_zt4       11000000 11 00011 0 v:1 .. 00110 za:3 zr:3 00 \
 MOVT_rzt        1100 0000 0100 1100 0 off:3 00 11111 rt:5
 MOVT_ztr        1100 0000 0100 1110 0 off:3 00 11111 rt:5
 
+MOVT_ztz        1100 0000 0100 1111 00 off:2 00 11111 rt:5
+
 ### SME Memory
 
 &ldst           esz rs pg rn rm za off v:bool st:bool
-- 
2.43.0


