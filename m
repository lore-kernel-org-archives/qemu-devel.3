Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C7E4C71157
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Jun 2025 00:00:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uT82x-00040v-T1; Sat, 21 Jun 2025 19:54:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT82H-00022z-9j
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 19:54:13 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT82D-0004ve-1J
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 19:54:11 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-749248d06faso638087b3a.2
 for <qemu-devel@nongnu.org>; Sat, 21 Jun 2025 16:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750550047; x=1751154847; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=FPNpBuDdapv1Ccj1OQEx3hc8sS8fhaZVcZxaQplCf2A=;
 b=u6CmYBTTC+4a5kF4NhoVY1zRptMh6PRPNdQHEl898z5mlWUbHSvBNT67oCLyhgEPlv
 FW0FBuAZNcsd4WNcX5YvgPr6Ntk7xe9WYsTtAlhC0o10cePzo7KWSk5c3rJ3OCy//Wo0
 QIjKO9Zi+rnlLwgEbtxQRJzfjKCJH2Cn/J4Ueb9AXhNDQ2oaHJBGilvucDfuTF4TrAUL
 3hAaeQNV2EFgbL5zoqc3uYT9pdhvGei8TUtK6471JbJtJ+Le6dxGC/UbM5EvIlqOn/PW
 e0/ZKMXc5PBHf+o2gmzye04neQ9wwWyzDFxa1x/eN7svaORaQawlfK/rifkdWi7HsN/l
 r7SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750550047; x=1751154847;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FPNpBuDdapv1Ccj1OQEx3hc8sS8fhaZVcZxaQplCf2A=;
 b=NaU5lezOLfV4UvoK03Q8c0z4caYecIa1DA+MhRlrYjebEFz40KiZ/WWLxz/cwFn0cY
 7s8ySkDiB/yPcw8WWY/62IT9EIXTFQ4jFcHuWd79Z0D/TEeK+gGK+1bU9xLNYPnA3R7g
 dBoXFVxTszKphx35cfDs6P6s8ndNXkaIS6B1rie9m881eNWvuC2quVbLYYbXVpVWQGlZ
 pcX5fOo54fFMGzjhcbJZon6dxVivU0NZ0e6DFbmIuxbmCWX6/EB8UfvezSHfg/hzSWZo
 TCxrC/UhIBtvMqnBeJ1SNVE5lpuCTMsrGPLRgTkBUBPYQs+1Xakrk0/ZS7wDb3CuNNyu
 cOZQ==
X-Gm-Message-State: AOJu0Yzy8q4uikR/CW3Rl0uk8fgPEKVijM4TIYK7CHebN2Sp3hR/SFab
 49x35dbmIeEFCUSfZj63Tv06ODuwybFT9qNTmpX1Yuofc6VayeiBkCsJWH9ZYEct+CrMClfFeF5
 NaxH4nJQ=
X-Gm-Gg: ASbGnctudhu/VikM5M9zVtn1GyVb7aZC37elZFqcvWzLID3hUKvB1nXvwkEQKyth0Is
 uuyyZEGEO/CJnuXtJ0naGh0H+gvyp0d7FuiQaHsStfncSPZtoe9qvAPzgLxfv+SwXofVvAQK6sj
 DUSxMWU+cRhZLl5MxTsH38NW5iWFXaAtR5S/hezoFBUmuJ1zDj+IcTmZwai7hQt7X9pWvn3Whql
 B0MJQfsFCrm2q9eYcLotOkAam0nUKcsXr21IjJwy6cYWgQqjYEkMVczJlVb0qf9BGuYLwDdngxr
 x/cmgSd+aR6wmC3ySPos0l6a0AVWRLdSdyxzZMQhHWcsZn6cCTI+1VIDr3FMv7lcm2pgCHR7Pqw
 Vq39Nj9cbd3pn22SB2MLZ
X-Google-Smtp-Source: AGHT+IFLFCEr/4GCtlDldaGgW1aoubWN/FTuVgB+vhYVlYLmD7ckn/qMppQK8Yq4zxHBm15JiO2aLA==
X-Received: by 2002:a05:6a00:2386:b0:748:e150:ac77 with SMTP id
 d2e1a72fcca58-7490d6c3b5fmr9750763b3a.22.1750550047077; 
 Sat, 21 Jun 2025 16:54:07 -0700 (PDT)
Received: from stoup.. (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7490a46b590sm4970051b3a.27.2025.06.21.16.54.06
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Jun 2025 16:54:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 043/101] target/arm: Implement SDOT,
 UDOT (2-way) for SME2/SVE2p1
Date: Sat, 21 Jun 2025 16:49:39 -0700
Message-ID: <20250621235037.74091-44-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250621235037.74091-1-richard.henderson@linaro.org>
References: <20250621235037.74091-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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
 target/arm/tcg/translate-sve.c | 10 ++++++++++
 target/arm/tcg/sve.decode      |  8 +++++++-
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 29b6f09260..95121cce8e 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -3409,6 +3409,11 @@ TRANS_FEAT(SUDOT_zzxw_4s, aa64_sve_i8mm, gen_gvec_ool_arg_zzxz,
 TRANS_FEAT(USDOT_zzxw_4s, aa64_sve_i8mm, gen_gvec_ool_arg_zzxz,
            gen_helper_gvec_usdot_idx_4b, a)
 
+TRANS_FEAT(SDOT_zzxw_2s, aa64_sme2_or_sve2p1, gen_gvec_ool_arg_zzxz,
+           gen_helper_gvec_sdot_idx_2h, a)
+TRANS_FEAT(UDOT_zzxw_2s, aa64_sme2_or_sve2p1, gen_gvec_ool_arg_zzxz,
+           gen_helper_gvec_udot_idx_2h, a)
+
 #define DO_SVE2_RRX(NAME, FUNC) \
     TRANS_FEAT(NAME, aa64_sve, gen_gvec_ool_zzz, FUNC,          \
                a->rd, a->rn, a->rm, a->index)
@@ -7108,6 +7113,11 @@ TRANS_FEAT(SQRDCMLAH_zzzz, aa64_sve2, gen_gvec_ool_zzzz,
 TRANS_FEAT(USDOT_zzzz_4s, aa64_sve_i8mm, gen_gvec_ool_arg_zzzz,
            gen_helper_gvec_usdot_4b, a, 0)
 
+TRANS_FEAT(SDOT_zzzz_2s, aa64_sme2_or_sve2p1, gen_gvec_ool_arg_zzzz,
+           gen_helper_gvec_sdot_2h, a, 0)
+TRANS_FEAT(UDOT_zzzz_2s, aa64_sme2_or_sve2p1, gen_gvec_ool_arg_zzzz,
+           gen_helper_gvec_udot_2h, a, 0)
+
 TRANS_FEAT_NONSTREAMING(AESMC, aa64_sve2_aes, gen_gvec_ool_zz,
                         gen_helper_crypto_aesmc, a->rd, a->rd, 0)
 TRANS_FEAT_NONSTREAMING(AESIMC, aa64_sve2_aes, gen_gvec_ool_zz,
diff --git a/target/arm/tcg/sve.decode b/target/arm/tcg/sve.decode
index 7ed186c9bd..5234d0f0ae 100644
--- a/target/arm/tcg/sve.decode
+++ b/target/arm/tcg/sve.decode
@@ -856,6 +856,9 @@ SDOT_zzxw_4d    01000100 11 1 ..... 000000 ..... .....   @rrxr_1 esz=3
 UDOT_zzxw_4s    01000100 10 1 ..... 000001 ..... .....   @rrxr_2 esz=2
 UDOT_zzxw_4d    01000100 11 1 ..... 000001 ..... .....   @rrxr_1 esz=3
 
+SDOT_zzxw_2s    01000100 10 0 ..... 110010 ..... .....   @rrxr_2 esz=2
+UDOT_zzxw_2s    01000100 10 0 ..... 110011 ..... .....   @rrxr_2 esz=2
+
 # SVE2 integer multiply-add (indexed)
 MLA_zzxz_h      01000100 0. 1 ..... 000010 ..... .....   @rrxr_3 esz=1
 MLA_zzxz_s      01000100 10 1 ..... 000010 ..... .....   @rrxr_2 esz=2
@@ -1597,7 +1600,10 @@ UMLSLT_zzzw     01000100 .. 0 ..... 010 111 ..... .....  @rda_rn_rm
 CMLA_zzzz       01000100 esz:2 0 rm:5 0010 rot:2 rn:5 rd:5  ra=%reg_movprfx
 SQRDCMLAH_zzzz  01000100 esz:2 0 rm:5 0011 rot:2 rn:5 rd:5  ra=%reg_movprfx
 
-## SVE mixed sign dot product
+## SVE dot product
+
+SDOT_zzzz_2s    01000100 00 0 ..... 110 010 ..... .....  @rda_rn_rm_e0
+UDOT_zzzz_2s    01000100 00 0 ..... 110 011 ..... .....  @rda_rn_rm_e0
 
 USDOT_zzzz_4s   01000100 10 0 ..... 011 110 ..... .....  @rda_rn_rm_e0
 
-- 
2.43.0


