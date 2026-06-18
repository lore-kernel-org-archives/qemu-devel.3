Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44249CD98DE
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 04:08:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wa42L-0000s4-Kf; Thu, 18 Jun 2026 00:07:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wa42G-0000qf-1b
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 00:07:25 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wa42E-00044R-JA
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 00:07:23 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-36baeec21dcso219377a91.3
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 21:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781755640; x=1782360440; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=4Q2VUV0l7hwzaun46dVIEJHwiUnFL2anc4WfanKbEJk=;
 b=Ius4oUuIUq5FMOYwQADSTogukLpuwM2c7PDEGoVQGDKGYGXKY8PcP62QeSqdDEHKmX
 6So5s7d16YKAQdgHeIU1sPEK8HnpmB58CILPerIvlj18+31jcWy5eP1m1+8hZXsxGSn5
 4WKHjMHbUPFaytX0N09F1LE9fKEdM0yl9upuZXVjD7Cf2/HL69ZsFnwZXl0FvLWZSlJz
 gxl3hynX02As3eQ9UcFTLtBQoavoO17r5ef6/DB2zzznfhjKmCNWCugJ8Hgpyhfcl85L
 CmFSKxryl/7GEJsGgL8aFAgiSsfg+DPF4yCmWfaSrG17LctKkMM3em+V0gIBIojTfJsU
 kIgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781755640; x=1782360440;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4Q2VUV0l7hwzaun46dVIEJHwiUnFL2anc4WfanKbEJk=;
 b=VcIO1iWfAyKZ3of4kEa4xqjmGo+6Nbp7gbkDUF4BxWCRH2git+bSOSz/FKrGSTeUmq
 y+k4O48MnVnewd0dkgPOL0o9HLYQ41jU/CuhjBtYuru2sLGoOPgzLEYOm9VkWwCnnuJP
 wSVb5hLYsHoybafFAQLyrCP69e/TCXigSeMaYfDWFJ267FJesU0HkLJprfMDiv6tX/kI
 RUTTEXZCxv/dBLOYYFzkrA2sY6EDVspISznIXFxSRfSn9lF6RzFXnlUJDaDjpMwfyloz
 d5x+hOUTKGfzVY2lUEcZnu8jHdTJkcYkyv9y8NAkF/5eZ5eYjzGwp9NwcUjbCvDHgbQ3
 yXNA==
X-Gm-Message-State: AOJu0YxJXEuRLxs+gmSEKdGgJs9qgunALwbYqrfMTm6WqosU5tYzTImo
 ypCifVR+ZBLFP1Lc6+IGTAIvqTukOlspbnVN3w83rlHLqnPKKda3jYHmTzsQu2K4TzTmFikmMtz
 Rr58r
X-Gm-Gg: AfdE7cmh1pOtsoskF/EE4JNtM/KWMdO5r+lS1itFTVHWwZKqEBdpRUrfcWywa/FSnUt
 O8KjtHlPY4En0rwueUN9vL8ivd35SNrg4Yx2Erx4h/K6midBKnjDuHYJskIJ9IYdy/uESzLDOsU
 BsQzZaBOOhQYEPqHbylUKVNAaXCvPnQCFlXcTb9GFGxjoS9YcJLNhSgdRe6rGSJ1aXwdBsBY+3l
 wjlTxBIX1siFuh0/uGdmxNYPoXZGs1rs7s5J7gQj3yBJfengnGsPIEXasRPaU3bDEwx4wqzqUTh
 7CaTmX3d/Dxjs9RN5qSL3HwxVJc3dbkYu+LnfExdfJKJkUb1mOyC32NUMXfvqkXNzDUfBOqPqvg
 VRXTuIfw/6Goddb1pQj5R8vOyzASa5HNkRddVkU2wOxcwhbiThXNyqeFYsp7zSeyb5RpJ1dbWfs
 MfayFXwGjcmEO52nwZQkMq1lR8Pl6BhNxYxKgTn/s3i/xtylefPw==
X-Received: by 2002:a17:90b:3c52:b0:36b:9835:cf96 with SMTP id
 98e67ed59e1d1-37c9da78e74mr6111230a91.2.1781755640124; 
 Wed, 17 Jun 2026 21:07:20 -0700 (PDT)
Received: from stoup.. (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-37c5222e042sm8830476a91.16.2026.06.17.21.07.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2026 21:07:19 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v2 0/8] target/arm: Implement FEAT_SVE2p2
Date: Wed, 17 Jun 2026 21:07:10 -0700
Message-ID: <20260618040718.572950-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1032.google.com
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

Changes for v2:
  - 18 patches merged
  - Enablement of the feature for -cpu max is deferred until
    FEAT_SME2p2 is complete as well.
  - Dropped sve2p2 helper prefixes.
  - Renamed sve2_aes to sve_aes; there are more isar functions
    that want renaming, but this one touches the same lines as
    FEAT_SSVE_AES.
  - Other minor tweaks to helpers per review.
  - Unrelated bug fix for FEAT_FPMR.


r~


Richard Henderson (8):
  target/arm: Enable SCTLR_EL1.EnFPM for user-only
  target/arm: Implement EXPAND
  target/arm: Generalize sve_compact_[sd]
  target/arm: Implement COMPACT for byte/halfword
  target/arm: Implement FIRSTP, LASTP
  target/arm: Rename isar_feature_aa64_sve_aes
  target/arm: Implement FEAT_SSVE_AES
  target/arm: Use expand_pred_N for helper_sve_not_zpz_N

 bsd-user/aarch64/target_arch_elf.h |   2 +-
 target/arm/cpu-features.h          |   7 +-
 target/arm/tcg/helper-sve-defs.h   |  10 ++
 linux-user/aarch64/elfload.c       |   3 +-
 target/arm/cpu.c                   |   4 +
 target/arm/tcg/cpu64.c             |   1 +
 target/arm/tcg/sve_helper.c        | 150 ++++++++++++++++++++++-------
 target/arm/tcg/translate-sve.c     | 105 +++++++++++++++++---
 docs/system/arm/emulation.rst      |   1 +
 target/arm/tcg/sve.decode          |   6 +-
 10 files changed, 237 insertions(+), 52 deletions(-)

-- 
2.43.0


