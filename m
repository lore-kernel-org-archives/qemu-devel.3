Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C335C0218A
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2025 01:41:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcx2l-0000lP-Tv; Tue, 28 Jan 2025 20:39:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcx2k-0000kj-Jl
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 20:39:02 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcx2j-0003T8-14
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 20:39:02 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2164b1f05caso109556275ad.3
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2025 17:38:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738114739; x=1738719539; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=rEz/rxVFuaNhY5aNbxmZnAlfH1891I8iOgPRaSkJaMM=;
 b=m5RP4SNkI3xFoHYNyAKuB7Pt1lGm618IDNzqtGctsiWoQ9TyrKpT8sz57aHQNaxZ7X
 4YDjZhacj8ccSJ4vWWPhOfvF/bifENWrNTg40MN1qzDG/ALWIBuKnfYN93PnZA5QMOus
 QyyparGrDiBcBEbeensbB8ZoGmyuttWLXtg/btVGl4MpqZlbPL2X5B++MmrfJoAt0UhF
 v+xlV5K3aypBnm5VbtxJ6YigsTSFc4Rj2GWMQ7+OtMggLOLwd3m3WQVjN69giiV6ru5E
 kMY/nqWfEiTc5hbL0LzrwajNkZHybc3nv2i1qJuU6a+ROC2J3I38GBFskh6IG1o24zJN
 3QQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738114739; x=1738719539;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rEz/rxVFuaNhY5aNbxmZnAlfH1891I8iOgPRaSkJaMM=;
 b=CqKFW/jbLkk9seqSVHWHzQubRnJcRuqV2nbhbZrLDW9KxcuVleR5UnHCpwvOYCLH1P
 4g6o8vcwmQGUdOU1jMkk1t5ysm48f3MnyMkwJM4CQ3inO6K8twr8AUyXUrB6Cqp3GGlQ
 gbeQ8y5JFm+4FO8B9u/MPjKlM1roEipM6t7mUocix9yz7/gAxDKPtDcBqSi9iu7AeC3c
 UwjOesk4GOHmpBePjWp/8r6VIxl795HryJmrK+wdrq56OPytJejsDVkX6VTDJI2YGe49
 xp4BJ/QmArcs8eM2YWLI0sHhhMqq11dJv8EDEpqXOgu2sc8mRPakpNyg/UlKu/M0HsG5
 nNVA==
X-Gm-Message-State: AOJu0Yx28/ET+AtlE4NKfcIUQAmg1SG6nxTgHomlu2lWMsJpNU9zdJt0
 K3yAG1KmRJnlvhPee7gXNtjzwpo4m6qZWKpf8CN6F1MfOhilVyxcLG8dWCgvaPm1rsjvu6INNjn
 A
X-Gm-Gg: ASbGncucMHiYNsP9wqgmoTm6I0GVFlULNMoUX2xnaH/NgbN7i8D2KoFK859mugbBBma
 YJzbYMYVcHaL5oTN+XDs9Euwu05eDqlFfKls1Teh+z9lrNnX+klkkj2TyAnmF/bP+pGhWWk8e6K
 4XRESx49lliWklXh+xRL49hxJJs98DzW70TbG11FnSoEwOiaMAc2dj6pZ0DD0wjysjD1c6/fxc4
 BefdqN5qZRj8yAkli3AIdWXPJFKDBGwRkakxybJ5f4QdfbBAf2/VW1n+J+WA8B/iS0LbRQHI8en
 sPphKSRfiBb2CBtsWl6v5gvqImAh+GdNBS7SUGRhE7dfPpNizQ==
X-Google-Smtp-Source: AGHT+IGjsOVgJjRiHz9yGggR9Zf+W/gckHUcZXfIPqOiMUXbnFbiK+cL0QbIYilFOwmd0qAtw5/vkQ==
X-Received: by 2002:a17:903:1cb:b0:21c:2f41:f4cd with SMTP id
 d9443c01a7336-21dd7dea7b3mr19877305ad.43.1738114738734; 
 Tue, 28 Jan 2025 17:38:58 -0800 (PST)
Received: from stoup.. (71-212-32-190.tukw.qwest.net. [71.212.32.190])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21da3ea4200sm89341745ad.88.2025.01.28.17.38.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2025 17:38:58 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH v2 00/34] target/arm: FEAT_AFP followups for FEAT_SME2
Date: Tue, 28 Jan 2025 17:38:23 -0800
Message-ID: <20250129013857.135256-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

Hi Peter,

I know you've sent a PR with some of this, but I don't have a
complete tree against which to rebase.  So this is still

Based-on: 20250124162836.2332150-1-peter.maydell@linaro.org
("[PATCH 00/76] target/arm: Implement FEAT_AFP and FEAT_RPRES")

Up to patch 22 is unchanged; after patch 22 is all new.

Most of them simplify floatN_muladd to use float_muladd_negate_*.
Five of them (25, 26, 27, 31, 32) address functions missed in
your v1 patchset.

Patch 30 was easier to write with the reversion in patch 29 first.
Obviously I wouldn't think you'd apply as-is.


r~


Richard Henderson (34):
  target/arm: Rename FPST_FPCR_A32 to FPST_A32
  target/arm: Rename FPST_FPCR_A64 to FPST_A64
  target/arm: Rename FPST_FPCR_F16_A32 to FPST_A32_F16
  target/arm: Rename FPST_FPCR_F16_A64 to FPST_A64_F16
  target/arm: Rename FPST_FPCR_AH* to FPST_AH*
  target/arm: Introduce CPUARMState.vfp.fp_status[]
  target/arm: Remove standard_fp_status_f16
  target/arm: Remove standard_fp_status
  target/arm: Remove ah_fp_status_f16
  target/arm: Remove ah_fp_status
  target/arm: Remove fp_status_f16_a64
  target/arm: Remove fp_status_f16_a32
  target/arm: Remove fp_status_a64
  target/arm: Remove fp_status_a32
  target/arm: Simplify fp_status indexing in mve_helper.c
  target/arm: Simplify DO_VFP_cmp in vfp_helper.c
  target/arm: Move float*_ah_chs to vec_internal.h
  target/arm: Introduce float*_maybe_ah_chs
  target/arm: Use float*_maybe_ah_chs in sve_ftssel_*
  target/arm: Use float*_maybe_ah_chs in sve_fcadd_*
  target/arm: Use float*_maybe_ah_chs in sve_fcadd_*
  target/arm: Use flags for AH negation in do_fmla_zpzzz_*
  target/arm: Use flags for AH negation in sve_ftmad_*
  target/arm: Use flags for AH negation in float*_ah_mulsub_f
  target/arm: Handle FPCR.AH in gvec_fcmla[hsd]
  target/arm: Handle FPCR.AH in gvec_fcmla[hs]_idx
  target/arm: Handle FPCR.AH in sve_fcmla_zpzzz_*
  target/arm: Split gvec_fmla_idx_* for fmls and ah_fmls
  Revert "target/arm: Handle FPCR.AH in FMLSL"
  target/arm: Handle FPCR.AH in gvec_fmlal_a64
  target/arm: Handle FPCR.AH in sve2_fmlal_zzxw_s
  target/arm: Handle FPCR.AH in sve2_fmlal_zzzw_s
  target/arm: Read fz16 from env->vfp.fpcr
  target/arm: Sink fp_status and fpcr access into do_fmlal*

 target/arm/cpu.h               | 107 +++++-----
 target/arm/helper.h            |  14 ++
 target/arm/tcg/translate.h     |  68 +------
 target/arm/tcg/vec_internal.h  |  35 ++++
 target/arm/cpu.c               |  28 +--
 target/arm/tcg/helper-a64.c    |  15 +-
 target/arm/tcg/mve_helper.c    |  44 ++---
 target/arm/tcg/sme_helper.c    |   4 +-
 target/arm/tcg/sve_helper.c    | 234 +++++++++++-----------
 target/arm/tcg/translate-a64.c | 125 ++++++------
 target/arm/tcg/translate-sme.c |   4 +-
 target/arm/tcg/translate-sve.c | 157 +++++++--------
 target/arm/tcg/translate-vfp.c |  78 ++++----
 target/arm/tcg/vec_helper.c    | 346 +++++++++++++++++----------------
 target/arm/vfp_helper.c        |  94 ++++-----
 15 files changed, 681 insertions(+), 672 deletions(-)

-- 
2.43.0


