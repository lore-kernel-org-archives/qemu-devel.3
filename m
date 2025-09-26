Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79FCECAC5AE
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 14:10:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v298C-00077V-5O; Fri, 26 Sep 2025 10:09:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v2989-00075Z-Dk
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 10:09:01 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v2983-0005cX-D4
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 10:09:01 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3fa528f127fso1672298f8f.1
 for <qemu-devel@nongnu.org>; Fri, 26 Sep 2025 07:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758895726; x=1759500526; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=/dMwIyh1iNIO97lphlkJ/89s8F24iW7pVMUpbZbQCCc=;
 b=xNjFzjXdW6Rj22XUmQvnOpI+mIBhcd39kHIrYkybb93XtXfkriOPG4RyLAnrdEU1DA
 z6tRiJTzQvKtSHSz45z6ZFZI74JJDkZOG//gdO00MLuzE+fM5yr4ukXQp3UQPS0V2qit
 q8wzKm/KRLda9O77+5rRJA8E+lL92llbJ+EoEfu/PMuK5Zz1ygZjgLRArEvj7H4CDZ9a
 Lv4evVVeZpW/O2DvKa5dfefIG1/c046Z2KkOfQNy9cNTpX/EyuxxPNXUO1/ehrnJYXBh
 L85VWXZLL8Js45x9kS6BYLalgLhqRX/DlY5eThu+DQFjZQcyjlRdurEMZcs/aw3HvMmh
 iP6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758895726; x=1759500526;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/dMwIyh1iNIO97lphlkJ/89s8F24iW7pVMUpbZbQCCc=;
 b=cGifMMOWqt38FOnwyVF61g1kgiOa4mjh9xu1Xftl8G/Rn0RfwOpcJ5Fhxs4RYLwSn5
 dpKYaNU073RpE/01Im1i9HYPPRFwUwKw2qIWHSfzgGDP9DKK3GuFrVvpf+pOyrwD43k5
 goiZ/myUFmxmvHI+5XW3+O0p4U5nor3UF00jzuY1qJ76OUzr3NGeuEmNSbWJpako6G3D
 2fSyrEn5pmVy7wU6gapM4IMTpqtbjRRy/hEGIhkEht1VRkkzgzdE9RpOl/n4fBg6B3j0
 5fsB8nKlm2p3+E1ERgmvjonUUTz2v80eHvGfyxDAt4ajuYuXdfiZHDMt2SCuRJFGLMih
 5Nlw==
X-Gm-Message-State: AOJu0YxJAQyOkmnQA/ULuyYbN0lB964fm7XcltAfFNPhG6tTv55Nhh6a
 LPGzIoxA7t715q8RbYcyU9ewImgqATGFn0AnFR3YPs6FTcaHeNHiVnsw96QodlwaPz1az+Xnd9T
 MdeWQ
X-Gm-Gg: ASbGncvZ2jpUxq3BPjTp1H9fIZB8uNU1z9Xhbdbib5e63eomfqqX5aGOHeI5NF8Di1y
 UDeyXJUXWSYu9LOizM7E/BA9oW3srN7k1eBZlufNGUtGu/xPUbcLM2/Fh9x9gwgnA5CJolL1R9X
 nm0uXQt/r6ZcLfqt0CaGHhdcFi5lrxXsQTcNUfz+BK9HYrj/kcF0IuAMQKSM2sBhFfuO4+nruJU
 PSs/1eqiYZ/Yc+X/gNcJWk7Kwpzc0WGej3No4IeAhSIVc9E9uaXYhE0Vvh7aZxnB8qgvnpzjuJ9
 vUbIly1glJAiA5bKWr7FPZJd/b//wm1Vq+aR4ZXI3ZiqksyZ/Xwsy1N7zJTrMLKZwtKDq4Bu7Cx
 X1iwnQRxJl7uq6VFFotLSx0Ies2gBm6ilkfHpLoc=
X-Google-Smtp-Source: AGHT+IFqbUrd7f14j83l2UZUgtPi566lW0ve2euI2ru8yGy0wjpTzt54xPQiqK98wyg64oD2OhUtEA==
X-Received: by 2002:a05:6000:220b:b0:3ea:6680:8fb9 with SMTP id
 ffacd0b85a97d-40f5f60d329mr6749086f8f.3.1758895726300; 
 Fri, 26 Sep 2025 07:08:46 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-410f2007372sm6338315f8f.16.2025.09.26.07.08.45
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Sep 2025 07:08:45 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/44] target-arm queue
Date: Fri, 26 Sep 2025 15:08:00 +0100
Message-ID: <20250926140844.1493020-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x431.google.com
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

Hi; here's an arm pullreq...

thanks
-- PMM

The following changes since commit 95b9e0d2ade5d633fd13ffba96a54e87c65baf39:

  Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into staging (2025-09-24 12:04:18 -0700)

are available in the Git repository at:

  https://gitlab.com/pm215/qemu.git tags/pull-target-arm-20250926

for you to fetch changes up to b71e2b281a23aca474e128a8487efb07e29f4019:

  target/arm: Implement ID_AA64PFR2_EL1 (2025-09-26 13:43:33 +0100)

----------------------------------------------------------------
target-arm queue:
 * reimplement VHE alias register handling
 * replace magic GIC values by proper definitions
 * convert power control DPRINTF() uses to trace events
 * better reset related tracepoints
 * implement ID_AA64PFR2_EL1
 * hw/usb/hcd-uhci: don't assert for SETUP to non-0 endpoint
 * net/passt: Fix build failure due to missing GIO dependency

----------------------------------------------------------------
Laurent Vivier (1):
      net/passt: Fix build failure due to missing GIO dependency

Peter Maydell (3):
      hw/usb/hcd-uhci: don't assert for SETUP to non-0 endpoint
      target/arm: Move ID register field defs to cpu-features.h
      target/arm: Implement ID_AA64PFR2_EL1

Philippe Mathieu-Daudé (4):
      target/arm: Replace magic GIC values by proper definitions
      target/arm: Convert power control DPRINTF() uses to trace events
      target/arm: Trace emulated firmware reset call
      target/arm: Trace vCPU reset call

Richard Henderson (36):
      target/arm: Introduce KVMID_AA64_SYS_REG64
      target/arm: Move compare_u64 to helper.c
      target/arm/hvf: Split out sysreg.c.inc
      target/arm/hvf: Reorder DEF_SYSREG arguments
      target/arm/hvf: Add KVMID_TO_HVF, HVF_TO_KVMID
      target/arm/hvf: Remove hvf_sreg_match.key
      target/arm/hvf: Replace hvf_sreg_match with hvf_sreg_list
      target/arm/hvf: Sort the cpreg_indexes array
      target/arm/hvf: Use raw_read, raw_write to access
      target/arm: Use raw_write in cp_reg_reset
      target/arm: Rename all ARMCPRegInfo from opaque to ri
      target/arm: Drop define_one_arm_cp_reg_with_opaque
      target/arm: Restrict the scope of CPREG_FIELD32, CPREG_FIELD64
      target/arm: Replace cpreg_field_is_64bit with cpreg_field_type
      target/arm: Add CP_REG_AA32_64BIT_{SHIFT,MASK}
      target/arm: Rename CP_REG_AA32_NS_{SHIFT,MASK}
      target/arm: Convert init_cpreg_list to g_hash_table_foreach
      target/arm: Remove cp argument to ENCODE_AA64_CP_REG
      target/arm: Reorder ENCODE_AA64_CP_REG arguments
      target/arm: Split out add_cpreg_to_hashtable_aa{32, 64}
      target/arm: Improve asserts in define_one_arm_cp_reg
      target/arm: Move cp processing to define_one_arm_cp_reg
      target/arm: Move cpreg elimination to define_one_arm_cp_reg
      target/arm: Add key parameter to add_cpreg_to_hashtable
      target/arm: Split out alloc_cpreg
      target/arm: Hoist the allocation of ARMCPRegInfo
      target/arm: Remove name argument to alloc_cpreg
      target/arm: Move alias setting for wildcards
      target/arm: Move writeback of CP_ANY fields
      target/arm: Move endianness fixup for 32-bit registers
      target/arm: Rename TBFLAG_A64_NV2_MEM_E20 with *_E2H
      target/arm: Split out redirect_cpreg
      target/arm: Redirect VHE FOO_EL1 -> FOO_EL2 during translation
      target/arm: Redirect VHE FOO_EL12 to FOO_EL1 during translation
      target/arm: Rename some cpreg to their aarch64 names
      target/arm: Remove define_arm_vh_e2h_redirects_aliases

 meson.build                    |   1 +
 linux-user/arm/target_proc.h   |   2 +
 target/arm/cpregs.h            | 111 ++---
 target/arm/cpu-features.h      | 415 ++++++++++++++++++
 target/arm/cpu.h               | 413 +-----------------
 target/arm/internals.h         |   3 +
 target/arm/kvm-consts.h        |  14 +-
 target/arm/tcg/translate.h     |   2 +
 target/arm/cpu-sysregs.h.inc   |   1 +
 hw/intc/arm_gicv3_cpuif.c      |  10 +-
 hw/usb/hcd-uhci.c              |  10 +-
 target/arm/arm-powerctl.c      |  26 +-
 target/arm/cpu.c               |  16 +-
 target/arm/gdbstub.c           |  14 +-
 target/arm/helper.c            | 933 +++++++++++++++++++----------------------
 target/arm/hvf/hvf.c           | 240 +++--------
 target/arm/kvm.c               |  12 +-
 target/arm/tcg/hflags.c        |   8 +-
 target/arm/tcg/translate-a64.c |  47 ++-
 target/arm/hvf/sysreg.c.inc    | 147 +++++++
 target/arm/trace-events        |  10 +
 21 files changed, 1199 insertions(+), 1236 deletions(-)
 create mode 100644 target/arm/hvf/sysreg.c.inc

