Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0E1DCD4F49
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2026 00:37:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOPS9-0006t1-Jx; Sat, 16 May 2026 20:34:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOPRy-0006MB-Gs
 for qemu-devel@nongnu.org; Sat, 16 May 2026 20:33:46 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOPRv-0006nG-Cc
 for qemu-devel@nongnu.org; Sat, 16 May 2026 20:33:46 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-8354461da74so445540b3a.1
 for <qemu-devel@nongnu.org>; Sat, 16 May 2026 17:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778978022; x=1779582822; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rijKST64WZpELrwBb6/Q5we+Vkq4bBbLxG5KgrYkJ+U=;
 b=QJMsIKFYy0J47fbGj5JNyB2KfQL2uRGpGbF71wpwUqswfsRORvSkWpoDXK9QYazH7+
 mLIg3pTEIZhxsw3IwmlrGK05Kc1O6j1uqZbol1GXlWzHKJfWUaLAKzrz+WZOSrpZJ5Xq
 0awiTBk6WwpOEV38cG3yGoxL/LJXBW5HUI3clKYfOQAjRKndhyhvOtstSDIecmkdkpBS
 tX26Q1piMdnzJBmrsZgabmZwKZYGJ1eYN8jjLu10903GAd6aYyjNQ65+V5yaUq828blL
 uL6BGIqfLjHCuKlmRM8oIS+DGV3ANVIBpA9B5nVgKr1Wp4xd7LDXSeV+JWT4Iz5Snb/3
 s/Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778978022; x=1779582822;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rijKST64WZpELrwBb6/Q5we+Vkq4bBbLxG5KgrYkJ+U=;
 b=UC6rFy7utDUvsexbjpG8da0AsN6LmzpUbYEs8E2+9cyJUVRCySu0DnsljnPyP4ksj6
 LQ04oDM1sGfU52v+zmNG9tl0xTp9XyiijxPISTTy6FQYs9WtZMYKDC6y6EWNt0I3Nk9n
 YbBixKvj9RAzA2oiTUxNQZ0ArIEofHMbJNoAW3ki+C45IsHdPbi+vixchAwSQ37zKKCj
 zqc5mQoyTveNOxSWIfHpT83sAh6bUgFXCkxXVQWvL+KC7WqkCBKYBUzGHu/bXuZK+FfW
 JiaqnUVXEEaqAE6JAtCORwMKTiDb7UsuU9pFKdfoItxY8zxQIo8LjeulGIB0jkL88/ok
 Qo/A==
X-Gm-Message-State: AOJu0Yz7R1A26Xg0H5XUNoRVJq0MeVRVCMfziqtTOAc06mAN43f2V4DY
 m1Ftt4Dziq/gpglBvm3Wh0RBCZ37bd1cg4TTqNeJ//N8P7Ua5h+LO4yisLFVMF5xzbGKi1ZlWdh
 ZEkbQ
X-Gm-Gg: Acq92OHAr4UoqV7qmQvKPwxH+k4Gx25WrHgTqzsAPdk5XydpQAUimOwVWrst30UaZSM
 dpwG3v1dnEKJWjBRjH16ojOSR7IPrFIU4IYZTAOC3j315DCQrXlhuV7e2y1oaz/vkFVWfOvVYMw
 I6GeNdhW7X96tb2IANk96X2Vfw9VUKGPeYP7pRPdgvBXmfPIqonkf5fhU0naoOoiaMlYMJM+K2c
 f7F0/JT3y95lqZHjKz3la5vUDc5b8J5GUMyLcPKI+zm+XS8KW58wfUrmcZRu0Qd7s/niFOgsUub
 Q7axAbnFItbVcqMRpke4WvQFf4FdnfEei11G6H0WowTi97ocjYOUoXU99WrILsbbpOIFmP4LdQB
 zOt6obSWmPXV/8ZED6T8pL3oy8kBGXPvyv+re6soMxZpPb/yeeU6Vfc1Cw8TyULacQC2qASrzVa
 CXhbYQo0HrSdpoI7gYXLHzZ03i4ytJ
X-Received: by 2002:a05:6a21:32a7:b0:398:7eea:50a0 with SMTP id
 adf61e73a8af0-3b22eba10c7mr10819262637.18.1778978021954; 
 Sat, 16 May 2026 17:33:41 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c82da93df0dsm3010559a12.19.2026.05.16.17.33.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 May 2026 17:33:41 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v5 42/63] target/arm: Implement MOVT (vector to table)
Date: Sat, 16 May 2026 17:29:41 -0700
Message-ID: <20260517003002.321430-43-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260517003002.321430-1-richard.henderson@linaro.org>
References: <20260517003002.321430-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
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


