Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF3F8C7EE2A
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Jun 2025 23:59:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uT85y-0007fZ-Uv; Sat, 21 Jun 2025 19:58:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT85a-00055q-3a
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 19:57:38 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT85Y-0006bO-64
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 19:57:37 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-748d982e97cso2671637b3a.1
 for <qemu-devel@nongnu.org>; Sat, 21 Jun 2025 16:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750550254; x=1751155054; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=lhyVTVG4FPa5Td4vV9btePrCSR2pHo2M/kgNmKDfcvs=;
 b=FeNLt2xbb/waq2z3EKovqfw739K4ZXX3MJSZflwcvuTcBcr/L7a7AM/kGWV3Ony8eg
 uyMEVIQ31XtorUQCV7FPMYKQPk/9FJ3s29edBUZv2/Ww58KzQFM0E1uO4DF6hU+EigCN
 EFS+KkIgYMNNtkMRESoixPZvMkUEH5tMmmWJbE9OA9Wlcs1rVgclker6uZyMWDWjzv4t
 NCLP5Xci0Goj6DexLtg3WuQUzxs0tuXXY/u07hM4djrjFZwj4t+gfw23G2yiaHGn8QlN
 VCq5DRCwU96BBtrAgy+LIs95VRNUCbr3qB218g5tpnMRbOHqKan5ArusFANkIMNTe3AL
 0Rvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750550254; x=1751155054;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lhyVTVG4FPa5Td4vV9btePrCSR2pHo2M/kgNmKDfcvs=;
 b=Kjbv10gEvYl0YaOx+OqrFvJRyqTk8amV3iAkvxh6PNDn9q83jNCJuzoWraZ5dUuZCd
 V2zT5cSMn0yBk66Tl9xTD0WyxlXwrpJkao/t8YZNcuiTeCZyZGHBMiVsnm3bl8Hk/JcH
 VgBAh1LUT6fNew7yYQm8xMDEKZa13kLhya4zg0aSMB2zmMuRfldEjkF/go8zzUeFWsRP
 +qKRfLLUWcwJNfVdwE0o0BQ/GWpeQSfjDs1SR3g5JP0AgLtBNF+xI/rkRM95NmIdOK8e
 aiV6XzthrHTAQssKRuCogt1Scm+fgBLM1OoMPbT+iBvPmTMaYPOm0/I5nX86sNsFfG+U
 dUXg==
X-Gm-Message-State: AOJu0YxxSw/MD/Dh/IoLCwgF2XDuk02LUSslH9C/O29igKEttm3HGsBA
 8EzNCKvh/mww358JQo4EsmcCPUwbqrUnSmAIt/sSFzyaV65IYjQf7xIs4eZvl7W82P3FZ+IIepk
 dqB7fJ2o=
X-Gm-Gg: ASbGncsaSNO67cYtw7TAffxI544SMHeHc0dkUBwDL3a3HhqOIBTmChSzO1zRC6I48Q5
 oZ41oKbKeWnO1QkSGFIK2Bm4dB/w53dj6wQbQD+kERbE/tjYBf5eA8IUDTdiq5Y4KaveefVETQQ
 gCdpUuYA1rJ3NZqJnH34sNYKeHayF7sJY/0UByqfW0sUwaSwnqWbGku7AF+BcnfQmB+x919vw5w
 Zxxrsv8/ZxT9LcNyBkR08FhW0GIDYjSPClAjwzVOshkLBlcyUnhrgNMafmEslCfIltCFA2F3QR7
 l1hHHodYp+8IaI+8jObt2B+Reb1FDBMTxvqSWOFfb9tLPoDRVpx66yl12NU+JOtO5nwOUfD1LZa
 S1VXdyc0W0ByE23ypbeYP
X-Google-Smtp-Source: AGHT+IGTcc7DdnZiCdVN+u7BiFcN71l25e0yCgpioM76g5dWPWgP1IV3BaYZx/4Hvp/jre8zyDB1Qw==
X-Received: by 2002:a05:6a21:15c9:b0:1f5:8fe3:4e29 with SMTP id
 adf61e73a8af0-22026e13226mr12253119637.3.1750550254169; 
 Sat, 21 Jun 2025 16:57:34 -0700 (PDT)
Received: from stoup.. (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b31f12584cbsm4551790a12.55.2025.06.21.16.57.33
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Jun 2025 16:57:33 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 086/101] target/arm: Implement DUPQ for SME2p1/SVE2p1
Date: Sat, 21 Jun 2025 16:50:22 -0700
Message-ID: <20250621235037.74091-87-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250621235037.74091-1-richard.henderson@linaro.org>
References: <20250621235037.74091-1-richard.henderson@linaro.org>
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
 target/arm/tcg/translate-sve.c | 21 +++++++++++++++++++++
 target/arm/tcg/sve.decode      |  6 ++++++
 2 files changed, 27 insertions(+)

diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 62ace5d300..8e48b8aafa 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -2249,6 +2249,27 @@ static bool trans_DUP_x(DisasContext *s, arg_DUP_x *a)
     return true;
 }
 
+static bool trans_DUPQ(DisasContext *s, arg_DUPQ *a)
+{
+    unsigned vl, dofs, nofs;
+
+    if (!dc_isar_feature(aa64_sme2p1_or_sve2p1, s)) {
+        return false;
+    }
+    if (!sve_access_check(s)) {
+        return true;
+    }
+
+    vl = vec_full_reg_size(s);
+    dofs = vec_full_reg_offset(s, a->rd);
+    nofs = vec_reg_offset(s, a->rn, a->imm, a->esz);
+
+    for (unsigned i = 0; i < vl; i += 16) {
+        tcg_gen_gvec_dup_mem(a->esz, dofs + i, nofs + i, 16, 16);
+    }
+    return true;
+}
+
 static void do_insr_i64(DisasContext *s, arg_rrr_esz *a, TCGv_i64 val)
 {
     typedef void gen_insr(TCGv_ptr, TCGv_ptr, TCGv_i64, TCGv_i32);
diff --git a/target/arm/tcg/sve.decode b/target/arm/tcg/sve.decode
index f3db790460..03e771b129 100644
--- a/target/arm/tcg/sve.decode
+++ b/target/arm/tcg/sve.decode
@@ -577,6 +577,12 @@ DUP_s           00000101 .. 1 00000 001110 ..... .....          @rd_rn
 DUP_x           00000101 .. 1 ..... 001000 rn:5 rd:5 \
                 &rri imm=%imm7_22_16
 
+# SVE Permute Vector - one source quadwords
+DUPQ            00000101 001 imm:4    1 001001 rn:5 rd:5        &rri_esz esz=0
+DUPQ            00000101 001 imm:3   10 001001 rn:5 rd:5        &rri_esz esz=1
+DUPQ            00000101 001 imm:2  100 001001 rn:5 rd:5        &rri_esz esz=2
+DUPQ            00000101 001 imm:1 1000 001001 rn:5 rd:5        &rri_esz esz=3
+
 # SVE insert SIMD&FP scalar register
 INSR_f          00000101 .. 1 10100 001110 ..... .....          @rdn_rm
 
-- 
2.43.0


