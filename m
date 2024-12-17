Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 245C7E7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 17:20:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNbEf-0007rI-Dv; Tue, 17 Dec 2024 12:19:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tNbEc-0007qm-Cv
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 12:19:50 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tNbEW-00068M-0U
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 12:19:49 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3862d6d5765so3831726f8f.3
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2024 09:19:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734455980; x=1735060780; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=9/36KvWVh5CZpYM1n8Wct054yNOoZi4upNBiJ3viOns=;
 b=uLY7yeMH+u7ZkBBm02yse0gSqzDxBKDQyKGWGxpSmXWmixVyQrVK/3LkullV3Nkwrh
 VRM93nGffXv4pHBMeo0LoxV+HWTWgnlK14KBspvtV9cU7nNF7wZKn2eLh5jXwHa7Ljmd
 nEu0+QwUrdpivlhGAZ3yyxvfOQQu7iX6polm7Xkpb1R1DUHRgOJk2iSVGCxqz2pNKUws
 b3ZwXFdtKY/j0y+rb+JlWDw2/6F07ZurI6V32sGdhmnvHP2RXkfXHZh2FKul+rwb329z
 I1jnKpSxsW05j0JHVD6zUSQgHZUQR36XlZx6A0Y+up59CrF2pPiHhV8TBxJ0x9bJu2eT
 QxfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734455980; x=1735060780;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9/36KvWVh5CZpYM1n8Wct054yNOoZi4upNBiJ3viOns=;
 b=FvOdBQPtulakhcT5Z95pG+/Z6jHFqmaMObZ/RzTlP87axXm0//+HYUWWTv1L37htA0
 +xn7PWXd9iJKcDhjxfRLS4a2quwVBF19tOobB5J8WOd4ApYVwGTU1EUri9sqtsoHseVQ
 jVs+0iDpoCAE5eopdbzLgGqkkJZcJWlQVsWAFNzoztMpv2qLazEUeaa2nR8rFBOxtQr3
 sGF17WoxNKql8jC7yXdzwr7R8MLtWgErEfb22gEWARlGIDwlPegDrnGqshNpccpfBkq/
 bwHj2faHfCYeslqsOZ/MAXCNpP1O6u9JOWP0+HypjU84jSOBw1/RtVEpnSeZ0127QKST
 S2hw==
X-Gm-Message-State: AOJu0Yz7W6PV/Qt4e2udORpFALS9cIVLjjDOmGfC5dVcFstNea0ZuB9N
 AVXs3gHyrcWKBov/WkuqE7232a93CdAYD+w8hyBoMestS4Bec+3abf1Y7lfqUrfSsGsKhu+v6Ac
 u
X-Gm-Gg: ASbGncul0AwRIE3xCpZiebML+DM+bhcnB5USqFwfZkMzC0L1N7SYmIloPDdILgF5i5t
 O1N9tbgZKLav0gLGPoSXGiJhdkTyN06nhvNrtl5HDJd/TxG6PYbcpwc6okrP9q/Bn5xPjZUtMzp
 gOynrH1gaMGITabpo3YDidqJTG2Eq7dbbrUXe3yGFNNgvC4elC+7218y8Yl9zsxiWRErtJ7OcBS
 6ll4iZudwLyHDf5Vpv9WZh0NDOxIoSzwk0wH05FjDxJ8KJalaoN4xmANSe6R8o=
X-Google-Smtp-Source: AGHT+IEUx0HjN97ZhpkgAc7gtWPknB+L7wQ9/ZvLa96RPam2PUnMziY/a9yhDIkFnCYTIyEhLMaefA==
X-Received: by 2002:a05:6000:188f:b0:386:5b2:a9d9 with SMTP id
 ffacd0b85a97d-3888e0c04aemr14523523f8f.53.1734455980033; 
 Tue, 17 Dec 2024 09:19:40 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-388c8016389sm11569728f8f.32.2024.12.17.09.19.39
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Dec 2024 09:19:39 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/19] target-arm queue
Date: Tue, 17 Dec 2024 17:19:18 +0000
Message-Id: <20241217171937.3899947-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Hi; this is one last arm pullreq before the end of the year.
Mostly minor cleanups, and also implementation of the
FEAT_XS architectural feature.

thanks
-- PMM

The following changes since commit 8032c78e556cd0baec111740a6c636863f9bd7c8:

  Merge tag 'firmware-20241216-pull-request' of https://gitlab.com/kraxel/qemu into staging (2024-12-16 14:20:33 -0500)

are available in the Git repository at:

  https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20241217

for you to fetch changes up to e91254250acb8570bd7b8a8f89d30e6d18291d02:

  tests/functional: update sbsa-ref firmware used in test (2024-12-17 15:21:06 +0000)

----------------------------------------------------------------
target-arm queue:
 * remove a line of redundant code
 * convert various TCG helper fns to use 'fpst' alias
 * Use float_status in helper_fcvtx_f64_to_f32
 * Use float_status in helper_vfp_fcvt{ds,sd}
 * Implement FEAT_XS
 * hw/intc/arm_gicv3_its: Zero initialize local DTEntry etc structs
 * tests/functional: update sbsa-ref firmware used in test

----------------------------------------------------------------
Denis Rastyogin (1):
      target/arm: remove redundant code

Manos Pitsidianakis (3):
      target/arm: Add decodetree entry for DSB nXS variant
      target/arm: Enable FEAT_XS for the max cpu
      tests/tcg/aarch64: add system test for FEAT_XS

Marcin Juszkiewicz (1):
      tests/functional: update sbsa-ref firmware used in test

Peter Maydell (4):
      target/arm: Implement fine-grained-trap handling for FEAT_XS
      target/arm: Add ARM_CP_ADD_TLBI_NXS type flag for NXS insns
      target/arm: Add ARM_CP_ADD_TLBI_NXS type flag to TLBI insns
      hw/intc/arm_gicv3_its: Zero initialize local DTEntry etc structs

Richard Henderson (10):
      target/arm: Convert vfp_helper.c to fpst alias
      target/arm: Convert helper-a64.c to fpst alias
      target/arm: Convert vec_helper.c to fpst alias
      target/arm: Convert neon_helper.c to fpst alias
      target/arm: Convert sve_helper.c to fpst alias
      target/arm: Convert sme_helper.c to fpst alias
      target/arm: Convert vec_helper.c to use env alias
      target/arm: Convert neon_helper.c to use env alias
      target/arm: Use float_status in helper_fcvtx_f64_to_f32
      target/arm: Use float_status in helper_vfp_fcvt{ds,sd}

 docs/system/arm/emulation.rst            |   1 +
 target/arm/cpregs.h                      |  80 ++--
 target/arm/cpu-features.h                |   5 +
 target/arm/helper.h                      | 638 +++++++++++++++----------------
 target/arm/tcg/helper-a64.h              | 116 +++---
 target/arm/tcg/helper-sme.h              |   4 +-
 target/arm/tcg/helper-sve.h              | 426 ++++++++++-----------
 target/arm/tcg/a64.decode                |   3 +
 hw/intc/arm_gicv3_its.c                  |  44 +--
 target/arm/helper.c                      |  30 +-
 target/arm/tcg/cpu64.c                   |   1 +
 target/arm/tcg/helper-a64.c              | 101 ++---
 target/arm/tcg/neon_helper.c             |  27 +-
 target/arm/tcg/op_helper.c               |  11 +-
 target/arm/tcg/sme_helper.c              |   8 +-
 target/arm/tcg/sve_helper.c              |  96 ++---
 target/arm/tcg/tlb-insns.c               | 202 ++++++----
 target/arm/tcg/translate-a64.c           |  26 +-
 target/arm/tcg/translate-vfp.c           |   4 +-
 target/arm/tcg/vec_helper.c              |  81 ++--
 target/arm/vfp_helper.c                  | 130 +++----
 tests/tcg/aarch64/system/feat-xs.c       |  27 ++
 tests/functional/test_aarch64_sbsaref.py |  20 +-
 23 files changed, 1083 insertions(+), 998 deletions(-)
 create mode 100644 tests/tcg/aarch64/system/feat-xs.c

