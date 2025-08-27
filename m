Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87B9CCA0FF0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 01:06:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ur4b9-0003Vm-5A; Tue, 26 Aug 2025 21:05:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ur4b7-0003VR-Oy
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 21:05:09 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ur4b4-00074H-Nh
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 21:05:09 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-770530175a6so2132488b3a.3
 for <qemu-devel@nongnu.org>; Tue, 26 Aug 2025 18:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756256703; x=1756861503; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=NcG6Wtwuu8aUNgPha7rYWbXyXySoDRQtTWPzFZmxwPc=;
 b=dIVbXsbAsL5JzvScn8FfswkvcHCiyqNX8ebGbrwljNIKgFMu6Loh3NUUSI4MUVyzsM
 NSFA8AOleThVeKg4IAIEAnyzbNqD5BrSXHDmfMQMAM4tR0LlHSqLGRSVqTNksJ2Cyv1d
 cZxjIBBGtUNHt4Mdbr0JWv34+m8TbSLPxQbINCbodWMzauyfa3Qhf59nvx5S1DEX4TL6
 UCMcjmpxQf0cbW3SvvzTx7bRFDzkCNfTTgEy2Z7yqsLSWyfHzcSFyOEWukSpJtsTgnjI
 RrN/jobBsm01XYmrbVVNaSwgOAuYTNqXssUXHeQNNVanHU58PFa5YVRdwgJNoK5ifnvP
 O5vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756256703; x=1756861503;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NcG6Wtwuu8aUNgPha7rYWbXyXySoDRQtTWPzFZmxwPc=;
 b=VkIOcSkzwOiut6HyXuTOjWA/rIETyw8vo+mEKZ+ITywI1FJsJ9pnOYoKK9lqolYysf
 ksacYlELf0re3OfJD41vJyWxATftg6iRzuDxLUiyhHMkQTVjsGhBhXoU/60lSrO9BZgB
 1dZlEYMV/ngFCMgOy5VTdecOlsQYt17sszaAXYPPe/ijx55p2eSGpG0owlpHiz97h5Uo
 hMn8eetW83HS29j0YKrwIg/XXfI77/4IMr744zxZfBQcZNg3JKM5So1XoajyFn571XMT
 seZKZ+xbfY7mZx//zD2Wec18GZBKzOdt8GJoH0tVv49WVfQKi1fPzBnrSTI6vhrKQAdW
 b73g==
X-Gm-Message-State: AOJu0YzOpWSI5Qv72ygtLwWjj6ue1tfY68EOaMuix2IrLb9FEapdg1pI
 5x0gDuwG7pb5y2iZ6hOLoYCoFbBfLPQRVLg67OzrA6Fr6or+39P9tCUJ/vr6c9euFVUVQXTugeI
 2faaAF7g=
X-Gm-Gg: ASbGnctLtFFxsnwlOnJIxQxNXH4maayedXrdahfZcSlO+GoJocqCKbTvs8HUpeKBwUr
 e50RVPAV3P+GeGT0OAM95fX5MXmJEM46j57Pq/S7CQoMYHlaZrAbJlKWRFyCt0b+JNT40PxmKZ4
 9m7OATOoBzTkkvCfHx7qc8lOZSO1uL+wtm5sMbeV34FkAMe+HUmaV1eSX7pyZsGrR1//wTeL5X1
 TVaWONvNU57TAnLDk1eGDtng9BcFCycR5scyVE3UY7cHTUTSkk3bpYPUwMqe5gh9rFPdkFXX1Gy
 jxx7rMZdaeXdjojdIe+xd2dGtPXHDOTCuwn6x7fl+LGJyNxT8oRvFjMti+8emhLxTpdPFKdoqBO
 RS8bl+F99ahtfIaOqFcpqDA4KxVi8ZCRSpW1U/38g+dYWfHM=
X-Google-Smtp-Source: AGHT+IHlOFwmmCzIPenRLXFac1/mIbVgg/umHLMxPdJdClkbWFczbQq3x0zhdIUhTGxYNnv5qZsT6Q==
X-Received: by 2002:a05:6a21:6d8f:b0:238:e08:f283 with SMTP id
 adf61e73a8af0-24340c0fad3mr27152867637.13.1756256702504; 
 Tue, 26 Aug 2025 18:05:02 -0700 (PDT)
Received: from stoup.. ([144.6.121.55]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7720274534esm1419241b3a.47.2025.08.26.18.04.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Aug 2025 18:05:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [RFC PATCH 00/61] target/arm: Implement FEAT_SYSREG128
Date: Wed, 27 Aug 2025 11:03:47 +1000
Message-ID: <20250827010453.4059782-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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

Requesting feedback on the implementation of 128-bit registers.

Note that there ought to be no functional change with all of this,
because 128-bit sysregs are not hereing enabled.  Despite all of the
different FEAT_* names, it's all indivisible from FEAT_D128.

I've used Int128 throughout, which seems sensible at first glance,
but *really* complicates the definition of the registers within
ARMCPU, especially when the low part is aliased with AArch32.
The only saving grace is that there are so few 128-bit registers.

Gettng there isn't trivial either.  I wasn't happy with the idea
of replicating the orig_{read,write,access} set of hooks used by
VHE, so I've rewritten that to perform the VHE redirection at
translation time, much like how we do for NV2.

In the process of rewriting VHE, re-organize registration to
simplify memory management and reduce the number of arguments
to the inner helper functions.

At one point in development, I did not have CP_REG_AA64_128BIT_MASK,
which was going to require cpreg_to_kvm_id to also take a
ARMCPRegInfo pointer.  There aren't a whole lot of calls to that
helper, but the one in hvf required reorganization to handle.
With CP_REG_AA64_128BIT_MASK, that reorganization is not required,
but I still think it's a good cleanup so I have kept it.

Alternate implementation strategies:

  (1) Disconnect the 64-bit halves of the sysregs.
      Cons:
        - The 128-bit-ness isn't screamingly obvious.
      Pros:
        - Avoid having to rearrange the ARMCPU layout, and simpler
          integration with AArch32.
        - Avoid Int128 most places, since we wind up doing quite a
          lot of packing and unpacking the structure.
        - Because Int128 *isn't* a structure for most 64-bit builds,
          we can accidentally assign a 64-bit local to a 128-bit field.
        - Possibly easier migration changes; I havn't thought about
          that too much.

  (2) Avoid adding read128fn, raw_*128fn, and most write128fn, at
      least for now, because no defined sysregs need such handling.
      E.g. the 128-bit write of TTBR0_EL1 could call the existing
      writefn for the low half and directly store the high half.
      We do still need write128fn for the TLBIP set of insns, not
      yet implemented here, but even that could avoid Int128 by
      having 2 64-bit arguments.


Thoughts?


r~


Richard Henderson (61):
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
  target/arm: Split out add_cpreg_to_hashtable_aa{32,64}
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
  target/arm: Implement isar tests for FEAT_SYSREG128, FEAT_SYSINSTR128
  target/arm: Define CP_REG_SIZE_U128
  target/arm: Update ARMCPRegInfo for 128-bit sysregs
  target/arm: Assert ARM_CP_128BIT only with ARM_CP_STATE_AA64
  target/arm: Split add_cpreg_to_hashtable_aa64
  target/arm: Add raw_read128, raw_write128
  target/arm: Add read_raw_cp_reg128, write_raw_cp_reg128
  target/arm: Put 128-bit sysregs into a separate list
  target/arm/kvm: Assert no 128-bit sysregs in kvm_arm_init_cpreg_list
  target/arm/hvf: Assert no 128-bit sysregs in hvf_arch_init_vcpu
  migration: Add vmstate_info_int128
  target/arm: Migrate cpreg128 registers
  target/arm: Add syn_aa64_sysreg128trap
  target/arm: Introduce helper_{get,set}_cp_reg128
  target/arm: Implement MRRS, MSRR, SYSP
  include/qemu/compiler: Introduce HOST_ENDIAN_FIELDS
  include/hw/core/cpu: Use HOST_ENDIAN_FIELDS in IcountDecr
  include/qemu/host-utils: Use HOST_ENDIAN_FIELDS in muldiv64_rounding
  target/arm: Use HOST_ENDIAN_FIELDS in CPUARMState
  target/arm: Consolidate definitions of PAR
  target/arm: Extend PAR_EL1 to 128-bit
  target/arm: Consolidate definitions of TTBR[01]
  target/arm: Split out flush_if_asid_change
  target/arm: Use flush_if_asid_change in vmsa_ttbr_write
  target/arm: Extend TTBR system registers to 128-bit

 include/hw/core/cpu.h          |    8 +-
 include/migration/vmstate.h    |    1 +
 include/qemu/compiler.h        |   11 +
 include/qemu/host-utils.h      |    6 +-
 target/arm/cpregs.h            |  134 +--
 target/arm/cpu-features.h      |   10 +
 target/arm/cpu.h               |   95 +-
 target/arm/internals.h         |    4 +
 target/arm/kvm-consts.h        |   16 +-
 target/arm/syndrome.h          |   10 +
 target/arm/tcg/helper.h        |    2 +
 target/arm/tcg/translate.h     |    2 +
 hw/intc/arm_gicv3_cpuif.c      |   10 +-
 migration/vmstate-types.c      |   30 +
 target/arm/cpu.c               |   10 +-
 target/arm/gdbstub.c           |   14 +-
 target/arm/helper.c            | 1536 +++++++++++++++++++-------------
 target/arm/hvf/hvf.c           |  243 ++---
 target/arm/kvm.c               |   13 +-
 target/arm/machine.c           |   50 ++
 target/arm/ptw.c               |   14 +-
 target/arm/tcg/cpregs-at.c     |    4 +-
 target/arm/tcg/hflags.c        |    8 +-
 target/arm/tcg/op_helper.c     |   28 +
 target/arm/tcg/translate-a64.c |  207 ++++-
 target/arm/hvf/sysreg.c.inc    |  146 +++
 target/arm/tcg/a64.decode      |   12 +-
 27 files changed, 1595 insertions(+), 1029 deletions(-)
 create mode 100644 target/arm/hvf/sysreg.c.inc

-- 
2.43.0


