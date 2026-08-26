Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F37F0C61DBD
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 17:42:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzHdn-0008Pq-TA; Wed, 26 Aug 2026 13:42:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wzHdk-0008OO-4F
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 13:42:21 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wzHdi-0004jT-HI
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 13:42:19 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-8534d507f59so1407675b3a.0
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 10:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787766137; x=1788370937; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Knl3agZwHM4DlSg58E1Lmhm2HbRy2QdppL2P2wfWmEM=;
 b=eLG1j97sgdXDxGjX2gX+sg4P0gMjK6xna4P7U46t6NYEijBvqe8lrHACum0mR7Zm7P
 tgbt6Wz6OaacisJHPAE7B2sOtF1KzHFTMZr2h8xAGxKu7+HUHCF1x2pm+4N8ieHPhRpv
 0hoIVMCbAwtfJV3bBhC6ozESNoopO7cTKNPHSsF1lMoCr7AkpHJ7Fg6a1DNSMxhpRrqI
 SKdqrdZoNmGaE1o7xApry9NFvLhlyEmpyj1iiBWGZtgaNHUnV+sBSu+McGUOOzmBHPZJ
 MswadqrLiwfZLpzFt6TQt6w0pwbfkd5PtUktYcK29C1t8IhudXCBCWmQb8K1TV18kECc
 SLCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787766137; x=1788370937;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Knl3agZwHM4DlSg58E1Lmhm2HbRy2QdppL2P2wfWmEM=;
 b=bGEJ3+ciSKiUY/jkxG+Ghnb5kpv/dCCWrCa8HTndUKQOiqMGUkNvdP7sxb0BkNoka9
 IrFXqoAjVI0v31ChNHy1OTsVmLAr0oG0ou+tp+AgHFbIHR9kj+fEgUofb+DuOehUR0kw
 lnOIVdrO0UT5uIt6AQon/xftq2kIUs5vc4lbhl/L+hgWNXNhTauqV/ohevP/Fpw2sIFU
 4/x0+8p84Mg+EaJWkQp90lpYZrwlDb96gQqsQTSkAY3O6PRJ+GV45b7ZxRDaSP82IXar
 B0ajCYNwSJ+n0qMoef1t8s1nz0M2Krdb5gNZYK62bLakbNjP0BUpq8hN74iTu10qUVkQ
 dr2w==
X-Gm-Message-State: AFuF++mRsXM8GSqr/DR/wBs3md3Hzz/f1lX1b4UAvZEn+wgDwSF4dZqW
 t0GlIcM2N1tmuEhhqmf18E2gV9v/6DuGWSSkG6hO2K9DxAErul8NvZf41947THdrUYvRQ8w64yl
 cLverGQA=
X-Gm-Gg: AR+sD10Ei05Oxj8P4tiexFyf61frdiZFBqFN/jgmUgtRW8AOVbnE3bOXFHFvFu/hJcg
 rYQW44LjVN9nMGjVF0w+wIBrFWtmSpc/3BdD66iOIYdysTOLeSPnsZ4xREkdMxvafRhv8W8VOAw
 DjBeCQ1K3LtjibBgBuaYOud2LmuzLtmisOJdNQMDx3Kt/dgLSIJDJH4dRaHkfX7GBkJqoXZOyCK
 bWAFCItwbdm+EkPQ7MIZPsPtXaasFWw9yed2PHsW5OjBJQdxNm8tr8KjCEnokRccweDpZOfDDdK
 qVJQS5FngAq9gUf36lUVVPXfS/T94QuiE38nd+gUO+lC7jhy/lhO5wroSNWQUzGzWX5q8/rf24f
 f9o8OYF90/ofNqyoaB7Rp99IZ8teCpSoDv3rkpEn0VzEYx0OZTUQWERbG52V6lWDq5V2haFccSk
 j3Otxng09Fo/6a8uFIkPGp/d9sjFe5//D1dWRgNTdCEFmw6yv5VembL3ThzFfJZ0FhSrz7lvOH5
 ne6Sx//7kgl3Z2AwoTwsn8gYMCp
X-Received: by 2002:a05:6a00:4ac6:b0:845:e9e8:645c with SMTP id
 d2e1a72fcca58-85372ba1874mr17324628b3a.6.1787766136587; 
 Wed, 26 Aug 2026 10:42:16 -0700 (PDT)
Received: from stoup (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc1bec66020sm1260072a12.21.2026.08.26.10.42.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 10:42:15 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v2 00/25] target/arm: Implement FEAT_SME2p2 etc
Date: Wed, 26 Aug 2026 10:41:47 -0700
Message-ID: <20260826174213.614571-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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

Based-on: 20260825213000.221822-1-richard.henderson@linaro.org
("[PATCH v3 0/4] target/arm: Introduce cpu types max-v8 and max-v9")

Changes for v2:
  - Based on max-v9 split.
  - Minor patch review changes.

r~

Richard Henderson (25):
  target/arm: Split zdn in do_z2z_n1 and do_z2z_n1_fpst
  target/arm: Split zdn in do_z2z_nn and do_z2z_nn_fpst
  target/arm: Split decode of BFloat SME FMAX/FMIN
  target/arm: Implement FMUL (multiple/multiple and single vectors)
  target/arm: Enable FEAT_SVE2p2 and FEAT_SME2p2 for -cpu max
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
 target/arm/cpu-features.h          |  33 +++-
 target/arm/tcg/helper-a64-defs.h   |   1 +
 target/arm/tcg/helper-defs.h       |   5 +
 target/arm/tcg/helper-sve-defs.h   |   5 +
 linux-user/aarch64/elfload.c       |  13 +-
 target/arm/tcg/cpu64.c             |  10 +-
 target/arm/tcg/crypto_helper.c     | 164 ++++++++++++++---
 target/arm/tcg/sve_helper.c        |   1 +
 target/arm/tcg/translate-sme.c     | 190 ++++++++++---------
 target/arm/tcg/translate-sve.c     | 282 +++++++++++++++++++++--------
 target/arm/tcg/vec_helper64.c      |  35 ++++
 docs/system/arm/emulation.rst      |   5 +
 target/arm/tcg/sme.decode          | 154 +++++++++++++---
 target/arm/tcg/sve.decode          |  70 ++++++-
 15 files changed, 732 insertions(+), 244 deletions(-)

-- 
2.53.0


