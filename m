Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52F24C4452D
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 18:49:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmFVi-0001K3-JV; Tue, 21 Jul 2026 14:48:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wmFUe-00010O-FG
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 14:47:11 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wmFUb-0006b1-Ci
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 14:47:03 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-383cb94f742so10876487a91.3
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 11:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784659620; x=1785264420; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=tBJ1VylVaFeZRC94KoZhqi25ATrrizFkXy95hkDl5Mk=;
 b=A02G0s/N2RBBVNv5jy1vj+gqVKsPg5mOuutwqgSf4rTpf3WyqY8Hkbuyts4IaiaIiE
 M5pFUyfq/YKZ790TJrWylNZFhbVCp/wAHiX2haWgcIhG9vNgNgP+Q5mLAFU/CqwLcB2y
 SglXbERH198EKHMfpE0Hj8+3ubAHTC3sKGbA4UyqIpnBEEZrCouAN6UgXSS2R7ch9fII
 YYIC0PzyT3tTHcSPQa5CoZYlliEZnwA9O9x/S43yb0CU42Df/A3ik16W+N6ZaM6UaooG
 lpZxTiekLYMKbok9SfG+Boya1uQ42IJP72nXpzTaTqsaceH77b6yNQkyHlSQbwSg2NNG
 gIog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784659620; x=1785264420;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tBJ1VylVaFeZRC94KoZhqi25ATrrizFkXy95hkDl5Mk=;
 b=EqFjotIKSuv4ZYttjoC93cPFmL5/Maow9namk0UeP8VmH6apdSaqxCpn4914bvh8p/
 4GNf6DvLIDsGXI4Umep+AIzhgrDkqqLUtkdXpgv47w/sOJqF6BZNZz3F3g8ef0diLtuC
 30Nc4XPkcslXktz0m0b3pdwjU9NxxTINk+Be/T7fS3xlkTN7AnQomLeWXgDQ/OSUZ77k
 4vG+n2rBwgGv66E3DPQdGi8RploVnEzxgqmK5A8ocZs8Lk41MXjsaO6n3ZCn9snsvllq
 7XK+RA8KEWDGL36y0as3ch+wU2TLbDCdNJxjaxuNvpqbLYLvLyJA6q9+F4Cft9qWz4nj
 qtKw==
X-Gm-Message-State: AOJu0YxgdDZVKR1hlkmDQD1vO4bwyH9A8ztHkcf/DchCh3PIqsVE4KjG
 Q6TXlOdczcn84ADcXFUd2TmgG3U8RAKZRZTvnrIB7/9D/kmSplIlbxhzBpa2YtBwFJiD5xo2gK1
 Y/UmR
X-Gm-Gg: AR+sD11IBs7mf+B5k4cgtakyiI3EePExwXPpY//HvIkacyH5991l9viJWTjFB0Q49uY
 gVXewdSnFLnS0RqXUlXItTts80mXP+3HoxVV7tyQRB824uZBEWRhV4bnkTsvSdtWVJCX2mDwdHS
 HjM50N60Fl4fvfGgwL2s1pecxXpX1Rx6zABMMTMW06XlfCQsstCEKWcVNZrgJQmpB/I908kRtEz
 Td11uOcGVLM/Ii3E8LViPlCK6+nvdGlPHfkGR9AVmTZPXgAYb0yxaGq3M6Pn3el76agsAuFS67X
 uJXBkoMTh250cGGXrranL2g0VT9+Vsy903T/7fH//XND2ZdDhIagn+by5EZ+REPrjDwYtRMhku0
 6KkCO7EhifbePkJ8MeDMlkDCptQJr2oQmqBVlpkM0G1jyibQm9tUyxVt9hJToY1wQOfWwqEjtT1
 T288fG/Uo=
X-Received: by 2002:a17:90b:2416:b0:38e:712a:be66 with SMTP id
 98e67ed59e1d1-38e712ac411mr7526041a91.33.1784659619389; 
 Tue, 21 Jul 2026 11:46:59 -0700 (PDT)
Received: from stoup.. ([32.140.233.50]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13ce29e340esm41108094c88.5.2026.07.21.11.46.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 11:46:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 00/20] target/arm: Implement FEAT_SVE_{BFSCALE,BitPerm,AES2}
Date: Tue, 21 Jul 2026 11:46:36 -0700
Message-ID: <20260721184656.530230-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102b.google.com
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

Based-on: 20260719174905.420725-1-richard.henderson@linaro.org
("[PATCH for-11.2 0/6] target/arm: Implement FEAT_SME2p2")

I believe these are the last 3 SVE extensions present in
the ARM revision M.c.


r~


Richard Henderson (20):
  target/arm: Remove DO_ZPZZ_FP from translate-sme.c
  target/arm: Remove DO_ZPZZ_FP_B16 from translate-sme.c
  target/arm: Remove DO_ZPZZ_AH_FP from translate-sme.c
  target/arm: Remove DO_ZPZZ_AH_FP_B16 from translate-sme.c
  target/arm: Split decode of BFloat SVE FADD, FSUB, FMUL, FMIN*, FMAX*
  target/arm: Implement SVE BFSCALE
  target/arm: Implement SME BFSCALE
  target/arm: Implement SME BFMUL
  target/arm: Enable FEAT_SVE_BFSCALE for -cpu max
  target/arm: Rename isar_feature_aa64_sve_pmull128
  target/arm: Rename isar_feature_aa64_sve_bitperm
  target/arm: Rename isar_feature_aa64_sve_sha3
  target/arm: Rename isar_feature_aa64_sve_sm4
  target/arm: Implement and enable FEAT_SSVE_BitPerm for -cpu max
  target/arm: Implement AESE (indexed)
  target/arm: Implement AESD (indexed)
  target/arm: Implement AESEMC
  target/arm: Implement AESDIMC
  target/arm: Implement PMULL, PMLAL
  target/arm: Enable FEAT_SVE_AES2 for -cpu max

 bsd-user/aarch64/target_arch_elf.h |   8 +-
 target/arm/cpu-features.h          |  28 ++-
 target/arm/tcg/helper-a64-defs.h   |   1 +
 target/arm/tcg/helper-defs.h       |   5 +
 target/arm/tcg/helper-sve-defs.h   |   5 +
 linux-user/aarch64/elfload.c       |  11 +-
 target/arm/tcg/cpu64.c             |   6 +-
 target/arm/tcg/crypto_helper.c     | 164 ++++++++++++++---
 target/arm/tcg/sve_helper.c        |   1 +
 target/arm/tcg/translate-sme.c     |   8 +
 target/arm/tcg/translate-sve.c     | 282 +++++++++++++++++++++--------
 target/arm/tcg/vec_helper64.c      |  31 ++++
 docs/system/arm/emulation.rst      |   3 +
 target/arm/tcg/sme.decode          |  44 ++++-
 target/arm/tcg/sve.decode          |  70 ++++++-
 15 files changed, 533 insertions(+), 134 deletions(-)

-- 
2.43.0


