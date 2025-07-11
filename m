Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF505C83F21
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 14:10:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaERX-0007MD-FU; Fri, 11 Jul 2025 10:09:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uaEQq-00063a-2U
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 10:08:57 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uaEQm-0005tP-Qd
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 10:08:54 -0400
Received: by mail-pf1-x442.google.com with SMTP id
 d2e1a72fcca58-74b54cead6cso1533765b3a.1
 for <qemu-devel@nongnu.org>; Fri, 11 Jul 2025 07:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752242931; x=1752847731; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=QMUZhfwdRbauaa93S3SRTFEhVzXlgQZWXSfc5DTvMmg=;
 b=uWiUqQV0njoG5MYINxAvoClzIBhFANtNDkQhzoMOVAMDlTc//loXyK9UFzg1zEk4j1
 oIQWfLOoBtXqbps0GmvuKj4tw1/TtBjzIRcxo6b46DuVz+k4T71IxyVNMEPnUu1iTCNc
 gzozY9OsdIbXzGUnx/t0Z6KA/E5M/wBsoD5lPVwFzzLIGkAP1Bpb2CJvEtNWBNttXs5I
 Uin0Fejy+JjjGvjwZ3cZvvOajazvT7jPTXXHZkUKG1Gud0ughC9Ui0VjXBoGvlwXHaP1
 3UpvfaA6IVhn+oVZtIerrITAk4iSA3Nzhsqzg0KiRlqMBdjffCWL17/zeNWlyJj+YWlJ
 g68g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752242931; x=1752847731;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QMUZhfwdRbauaa93S3SRTFEhVzXlgQZWXSfc5DTvMmg=;
 b=WT5GV+j11nzAPz+fS5566ogua7pXCs2YfKYtIz80WcwNk5jAuuEZ+TogJxL1qbmTWx
 zmBkeOeUdtfsgwq+3NvoBfnpaL/CGGTc+enAqvX+pOuLPaMVfUAChnkvxINArg/ABsMF
 Es4bgn0xXnGPTwI1OQWZrb4JryqH4VdQbndLNHsjD/EuJio3IMR6/7yuCKDwgAG4xtjF
 rnugPi3FWXy3139dsrg3zWo4JB7CS+4MOEAmq13L1b36UsKmpdE/Cr34xT0zT9WBfuRH
 knsvMzoYw3hROkFxIAMC3kptozp20z85m7rTkc+dzyL6RO+ThjzSkLjOKI2YgpI/gxUq
 nzmA==
X-Gm-Message-State: AOJu0YxbVIDNVK6vkkYcClnwGgt97MCVeQdlf69SQDFxCCqWaRWu5K2Y
 0kNAnnq5wQmirhgrwC5EFyzYWh72pTdoelbblcnIn+Y166qw2OkNB0wXaFDxytnKr/4=
X-Gm-Gg: ASbGnctCCUCD+IbmbLKcvWZVX0Q0C3hOI2IaahmdEob47q+rNKs5H3yXesxye/fOSv/
 MKeEO4vqt4i8oJLOuJ/cS3mUVOyOY+2FhHuiaAw2ydmo6Qu+yrTxD/Cu/Z01pynfjdXZfiYdFYP
 iZVCWk/xbxGhRHAV909PxGBt9JXp8Oy0MHxjOX1PQ/yT+Ahq3pHGyKZbbjawwJgebgHbGXnTO5r
 tvNTgu4kGV//urHO5H2h7WZ2hA76skTnzFXu6qVAh5TFVmhEWOacSrsWMJ3SUexfyMrr3dASdgK
 DBO42TFwl1Vt9iZiwJWdkjNzQX9FnqrFV2mNYOaD3dcp8UNRuja1BEFWztdmunFXHpSGLDNNCsl
 yxHpZOsXuj9Le6l2edN6XUwCoGji50bGlaaD8weQPiudRHV+rtTZ1V7mfCg==
X-Google-Smtp-Source: AGHT+IHZ137PLyHh7NqdG3sMmdhVAm+MWYlcrvh+sYlSncmd2oURWpCvrkBplRLc+PLRn6mkXSbSrA==
X-Received: by 2002:a05:6a20:12d6:b0:220:33e9:15da with SMTP id
 adf61e73a8af0-2311e04b261mr6087823637.2.1752242931015; 
 Fri, 11 Jul 2025 07:08:51 -0700 (PDT)
Received: from gromero0.. (189-47-46-41.dsl.telesp.net.br. [189.47.46.41])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74eb9dd5d3esm5702280b3a.4.2025.07.11.07.08.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Jul 2025 07:08:50 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-arm@nongnu.org, richard.henderson@linaro.org, alex.bennee@linaro.org,
 peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org,
	gustavo.romero@linaro.org
Subject: [PATCH-for-10.1 v7 0/6] target/arm: Add FEAT_MEC to max cpu
Date: Fri, 11 Jul 2025 14:08:22 +0000
Message-Id: <20250711140828.1714666-1-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::442;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pf1-x442.google.com
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

Since v4:

- Moved MECID_WIDTH from cpu.h to internal.h
- Fixed stray ';'s in access and write functions
- Use of GET_IDREG/FIELD_DP64/SET_IDREG for setting feature in ID regs
- Sorted correctly isar_feature_aa64_* AA64MMFR3 tests
- Simplified/unified accessfn for cache instructions
- Fixed how cache instruction-related registers are registered in the cpu

Since v5:

- Fixed missing checks for ARM_FEATURE_EL3 in sctlr2_el2_access and
  tcr2_el2_access functions

Since v6:
 
- Added missing feature checks in aliases[] that made 'make check' fail in v6 (pmm)
- Set feature bits in SCR_EL3 in arm_emulate_firmware_reset for Linux (pmm)
- Rebased on pmm's target-arm.next

v1: https://mail.gnu.org/archive/html/qemu-devel/2025-06/msg04598.html 
v2: https://mail.gnu.org/archive/html/qemu-devel/2025-07/msg01799.html
v3: https://mail.gnu.org/archive/html/qemu-devel/2025-07/msg02338.html
v4: https://mail.gnu.org/archive/html/qemu-devel/2025-07/msg02488.html
v5: https://mail.gnu.org/archive/html/qemu-devel/2025-07/msg02689.html
v6: https://mail.gnu.org/archive/html/qemu-devel/2025-07/msg02731.html


This series adds support for all FEAT_MEC registers and cache instructions to
the Arm64 max CPU.

It includes the FEAT_MEC registers and cache maintenance instructions, but does
not modify the translation regimes to support the MECIDs, so no encryption is
supported yet. However, software stacks that rely on FEAT_MEC should work
properly at this point.

I'm currently exploring possibilities to support FEAT_MEC encryption (or
obfuscation, for testing purposes) in QEMU for the various translation regimes
on arm64, hence the encryption part of FEAT_MEC will be contributed later and is
not targeted for QEMU 10.1.


Cheers,
Gustavo

Gustavo Romero (6):
  target/arm: Add the MECEn SCR_EL3 bit
  target/arm: Add FEAT_MEC registers
  target/arm: Add FEAT_SCTLR2
  target/arm: Add FEAT_TCR2
  target/arm: Implement FEAT_MEC cache instructions
  target/arm: Advertise FEAT_MEC in cpu max

 docs/system/arm/emulation.rst |   5 +
 target/arm/cpu-features.h     |  15 +++
 target/arm/cpu.c              |   9 ++
 target/arm/cpu.h              |  27 ++++
 target/arm/helper.c           | 236 ++++++++++++++++++++++++++++++++++
 target/arm/internals.h        |  23 ++++
 target/arm/tcg/cpu64.c        |   7 +-
 7 files changed, 321 insertions(+), 1 deletion(-)

-- 
2.34.1


