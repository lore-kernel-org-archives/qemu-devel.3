Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17056FF887E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 00:26:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIFDx-0006dL-NE; Wed, 29 Apr 2026 20:25:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIFDe-0006QZ-Qm
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 20:25:35 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIFDY-0007Tg-RF
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 20:25:26 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-362bb3260f1so188755a91.2
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 17:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777508723; x=1778113523; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aaacGOh8gwX3lVHScHw0vooo3S9NCC3dC/eSJzjcavA=;
 b=XI9upLLuXm+Pyc7oDBaFUl45gPZ8D/w1rXRqA/QR88nXOKKLpVixxXkrVlZBKHAQfe
 BugH2i/AjmCHuaxekpsD8bp2rM38tGSHBM7OBGyiohb6smuvNVjIE4DoWxrMBLviwy4l
 rsSFf3vnM+tcC9XX5+Cw1I59ks6tlEKstWO2NeKH/tkQqyuyitiTmCLYlmB9mt2n1ivk
 AtgKwaCgi2/408pzvmLn9r0qZqegjpinv/qdegA9rCygDVbrlayRF2X96dMcvyiVZff7
 M3QT3+/Kqr8MtVS6rbM+fBtj6gJ+WTh7vYgG1arOWnQqVR149qjdP0OLrCOMnUTnmQOV
 OxCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777508723; x=1778113523;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=aaacGOh8gwX3lVHScHw0vooo3S9NCC3dC/eSJzjcavA=;
 b=Qg0JPSp+YDWDpW9a5T+v4Cbt5z4rRbMsRaZmPK0QuND53NvMBBkaUz6/7esXsgz4oi
 NHumIiF+KkM3TzPyKz1JacvZipSy27ikF0pLgbHpu6em+7oHF9im8mpGLvoFaU7UvHva
 kcEolUyYJcD6dQK+YLG4e+9ZQCN43X3aRrAsYoIHliHjKOH2K/wBGLaNGoNfCIrUp2MN
 dccaQhSUnbDVRr+XX10EM3ATmPczXhs58GIPZFOmeI0bIE5OaqU9vHPhv2i468gqSOLo
 l6+mQvb0LN6SyeF+xZWHfQYAQAFo9Y6z75ES+GLqSGdbcQ77p5WfWziXBuyWWuaIWbIW
 /5rA==
X-Gm-Message-State: AOJu0YxCUC9Y3MP615iaig5nVyu4c7kEayEfA3+NduWYBoI+v6b0thpY
 3fGxlp2s4iZTIrH1we9zZMJ1xlHOvLnQV1FkjpQJdWP+4q0DXL4GDIm6gBf4CKN5d17ugW6IMpZ
 GV4URgw0=
X-Gm-Gg: AeBDievtfA5eIrCi9M6IYU9L8ySKKfVEfIDX0YngAAwYzxPYnZqViDSlsSYe31ZxkPG
 an7y2ObyZYqZZjl8+h8aliaOQoP3uXCRjbZwBCHGM7LfGHR80IaQAMT8CY9KJ/qfgBHTywTXG0J
 z8vAVhHcwWZXf6Q5XFQfhQXJ1/N5rc8B7TBlKL3gpI+FOYa05IbwUG6llRdrfZNxyhOj+qyTnRT
 qigN8ldANZjgMNhG7gTNB34UmKXtuszdI3AksL2lnSrYqq6eUEtFeuJct8eHRM1qX/E7vBvp97D
 EgN8B1QSD/0QgVTZOYDwI4tU0rLGozAEpbxQv23ABAsLsOrg3rrT/hE+n7SVCz+dUMdTmxcHY2x
 jyLyFtC5qmdmtURJS8cDUCf66X7P9i9tlZsGF/9Hk/nNzs1INg+DRThdoaPh02MBRrL/DKzhYbX
 pOi3TrDVgVSafGeJxZHUuZ0JjxUJyldQ/qgY/25pWW
X-Received: by 2002:a05:6a20:a106:b0:3a0:d88:6d7f with SMTP id
 adf61e73a8af0-3a3cf861605mr714215637.42.1777508723068; 
 Wed, 29 Apr 2026 17:25:23 -0700 (PDT)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c7fd64f21b4sm3204112a12.21.2026.04.29.17.25.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 17:25:22 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v3 40/47] target/arm: Implement MOVT (vector to table)
Date: Thu, 30 Apr 2026 10:20:39 +1000
Message-ID: <20260430002046.59739-41-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260430002046.59739-1-richard.henderson@linaro.org>
References: <20260430002046.59739-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102f.google.com
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
index 15e9821ce5..4b228b4f3b 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1556,6 +1556,11 @@ static inline bool isar_feature_aa64_sme_fa64(const ARMISARegisters *id)
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


