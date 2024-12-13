Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE28CE7717F
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 17:34:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tM9XY-0007LY-Df; Fri, 13 Dec 2024 12:33:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tM9Wq-0006rx-Du
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 12:32:41 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tM9Wk-0001RO-Si
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 12:32:40 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3862f32a33eso985129f8f.3
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 09:32:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734111152; x=1734715952; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=pP6APkB5zDRiL7/tZy5IRL/wZmowU/ekKqLjWtIxsQ0=;
 b=ok63qE5RC1IJv1FfN6RLio18ESsGVtH7KX0e2pHhc3Zn/GNS5zg3okYk1wUytr/NE2
 n6SCP7mTauAR1sfTe8HZIL1peujAkZXIhLAxYIrQC0dyJydnGsDXEWBRtpVEtWedFwZl
 iFBgTD+MKuJpqiIXHpMizR7LzE8AnprSNKPxjN3s/m70060gdbyhut7kQJKhpQDnscNC
 ISQBHh3+EDSJ4FNcFoRkcBvPXFxmTZJmwDqI3hi7d+6wMp24FuciT8FR8HOWCkWbEajm
 PZtOCjY+VonFN22kIX4+knU+YKgeZcC2m75yd8NfA+eVDqzfEtewOmmHmPXyTqQZAMZu
 foUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734111152; x=1734715952;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pP6APkB5zDRiL7/tZy5IRL/wZmowU/ekKqLjWtIxsQ0=;
 b=pl967eS0+RDqXx7GWIWE+2wHwT3nbAmIkMsQLCoBYkAzwclh+VF+VkK/dqN4hLBA+s
 ID8H9iAhStFNPp31v9kE8lxNBBZlDrXw1ep233JJl3yvBY+FrJU/q9cRjRD33XznN12R
 puNHiIlPHGbwkpzbgSTslR0rESkCPeDqDwj2kdl9xB+Zn1+LumIBOjdWMRQxVkgPyr9v
 zTzIt6gLoqyKQECZJ3jdmY1YCQ5qWCXyb0HaJnUMVtx5YjHVx+SPRx/crTDo27gLWac2
 QupkDIq6guvXMGv6tGLa0zPcDrQjZ9cpD4uTCgsRSisVYfKFTyr5iIDEhkt/HeL1YfX3
 CjOQ==
X-Gm-Message-State: AOJu0YzFxneumu4cyc0I/ZKv0Z9ZasvSX7339Cki87iaLpSRFFUoZtZL
 evETX/ctKJvGOpxGz+TfKKms5ZiyAQfnoFd7FkA0OLqiIsmTjN726fQ8czdEtLkzK1zFyQkULP7
 M
X-Gm-Gg: ASbGncs7nIjqZMhoTvZMQiYg4Ln1WfJmEb5vHiZS7ouDpGlDJQ4/KNgGcp+t1T1o2At
 j9UcCCO0BNEUr5Nwp70g21NGxIYQi+BUeE3Nh6E9CT8irBWY80udRI8h+5076mKqVSC6HMt6ML/
 E8L1qndnXFkLHZw+fzzhOfBJ7Rw//Jjo0JnPnTW5d2oF7KfIG+wG/H7BHhO3XLok/lKlXJlW/j6
 J5od+TNLLV2A6Kb9Kg4sQlIM7EEpXvjhl6sK1mV3qS592Pmx4CObI2GHLzl5w==
X-Google-Smtp-Source: AGHT+IEUZFCdXJOJlv2rUJhi4dcDzU6TTjHHfSbPEZnuW70joN9UarbCHPiQDRNJt7Ooshvls9u+eQ==
X-Received: by 2002:a05:6000:702:b0:385:f840:e613 with SMTP id
 ffacd0b85a97d-3889ad337f9mr2510706f8f.51.1734111151743; 
 Fri, 13 Dec 2024 09:32:31 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-388c80162ddsm87026f8f.37.2024.12.13.09.32.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Dec 2024 09:32:30 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/85] target-arm queue
Date: Fri, 13 Dec 2024 17:31:04 +0000
Message-Id: <20241213173229.3308926-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42c.google.com
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

Another very large pullreq (this one mostly because it has
RTH's decodetree conversion series in it), but this should be
the last of the really large things in my to-review queue...

thanks
-- PMM

The following changes since commit 83aaec1d5a49f158abaa31797a0f976b3c07e5ca:

  Merge tag 'pull-tcg-20241212' of https://gitlab.com/rth7680/qemu into staging (2024-12-12 18:45:39 -0500)

are available in the Git repository at:

  https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20241213

for you to fetch changes up to 48e652c4bd9570f6f24def25355cb3009a7300f8:

  target/arm: Simplify condition for tlbi_el2_cp_reginfo[] (2024-12-13 15:41:09 +0000)

----------------------------------------------------------------
target-arm queue:
 * Finish conversion of A64 decoder to decodetree
 * Use float_round_to_odd in helper_fcvtx_f64_to_f32
 * Move TLBI insn emulation code out to its own source file
 * docs/system/arm: fix broken links, document undocumented properties
 * MAINTAINERS: correct an email address

----------------------------------------------------------------
Brian Cain (1):
      MAINTAINERS: correct my email address

Peter Maydell (10):
      target/arm: Move some TLBI insns to their own source file
      target/arm: Move TLBI insns for AArch32 EL2 to tlbi_insn_helper.c
      target/arm: Move AArch64 TLBI insns from v8_cp_reginfo[]
      target/arm: Move the AArch64 EL2 TLBI insns
      target/arm: Move AArch64 EL3 TLBI insns
      target/arm: Move TLBI range insns
      target/arm: Move the TLBI OS insns to tlb-insns.c.
      target/arm: Move small helper functions to tlb-insns.c
      target/arm: Move RME TLB insns to tlb-insns.c
      target/arm: Simplify condition for tlbi_el2_cp_reginfo[]

Pierrick Bouvier (4):
      docs/system/arm/orangepi: update links
      docs/system/arm/fby35: document execute-in-place property
      docs/system/arm/xlnx-versal-virt: document ospi-flash property
      docs/system/arm/virt: document missing properties

Richard Henderson (70):
      target/arm: Add section labels for "Data Processing (register)"
      target/arm: Convert UDIV, SDIV to decodetree
      target/arm: Convert LSLV, LSRV, ASRV, RORV to decodetree
      target/arm: Convert CRC32, CRC32C to decodetree
      target/arm: Convert SUBP, IRG, GMI to decodetree
      target/arm: Convert PACGA to decodetree
      target/arm: Convert RBIT, REV16, REV32, REV64 to decodetree
      target/arm: Convert CLZ, CLS to decodetree
      target/arm: Convert PAC[ID]*, AUT[ID]* to decodetree
      target/arm: Convert XPAC[ID] to decodetree
      target/arm: Convert disas_logic_reg to decodetree
      target/arm: Convert disas_add_sub_ext_reg to decodetree
      target/arm: Convert disas_add_sub_reg to decodetree
      target/arm: Convert disas_data_proc_3src to decodetree
      target/arm: Convert disas_adc_sbc to decodetree
      target/arm: Convert RMIF to decodetree
      target/arm: Convert SETF8, SETF16 to decodetree
      target/arm: Convert CCMP, CCMN to decodetree
      target/arm: Convert disas_cond_select to decodetree
      target/arm: Introduce fp_access_check_scalar_hsd
      target/arm: Introduce fp_access_check_vector_hsd
      target/arm: Convert FCMP, FCMPE, FCCMP, FCCMPE to decodetree
      target/arm: Fix decode of fp16 vector fabs, fneg, fsqrt
      target/arm: Convert FMOV, FABS, FNEG (scalar) to decodetree
      target/arm: Pass fpstatus to vfp_sqrt*
      target/arm: Remove helper_sqrt_f16
      target/arm: Convert FSQRT (scalar) to decodetree
      target/arm: Convert FRINT[NPMSAXI] (scalar) to decodetree
      target/arm: Convert BFCVT to decodetree
      target/arm: Convert FRINT{32, 64}[ZX] (scalar) to decodetree
      target/arm: Convert FCVT (scalar) to decodetree
      target/arm: Convert handle_fpfpcvt to decodetree
      target/arm: Convert FJCVTZS to decodetree
      target/arm: Convert handle_fmov to decodetree
      target/arm: Convert SQABS, SQNEG to decodetree
      target/arm: Convert ABS, NEG to decodetree
      target/arm: Introduce gen_gvec_cls, gen_gvec_clz
      target/arm: Convert CLS, CLZ (vector) to decodetree
      target/arm: Introduce gen_gvec_cnt, gen_gvec_rbit
      target/arm: Convert CNT, NOT, RBIT (vector) to decodetree
      target/arm: Convert CMGT, CMGE, GMLT, GMLE, CMEQ (zero) to decodetree
      target/arm: Introduce gen_gvec_rev{16,32,64}
      target/arm: Convert handle_rev to decodetree
      target/arm: Move helper_neon_addlp_{s8, s16} to neon_helper.c
      target/arm: Introduce gen_gvec_{s,u}{add,ada}lp
      target/arm: Convert handle_2misc_pairwise to decodetree
      target/arm: Remove helper_neon_{add,sub}l_u{16,32}
      target/arm: Introduce clear_vec
      target/arm: Convert XTN, SQXTUN, SQXTN, UQXTN to decodetree
      target/arm: Convert FCVTN, BFCVTN to decodetree
      target/arm: Convert FCVTXN to decodetree
      target/arm: Convert SHLL to decodetree
      target/arm: Implement gen_gvec_fabs, gen_gvec_fneg
      target/arm: Convert FABS, FNEG (vector) to decodetree
      target/arm: Convert FSQRT (vector) to decodetree
      target/arm: Convert FRINT* (vector) to decodetree
      target/arm: Convert FCVT* (vector, integer) scalar to decodetree
      target/arm: Convert FCVT* (vector, fixed-point) scalar to decodetree
      target/arm: Convert [US]CVTF (vector, integer) scalar to decodetree
      target/arm: Convert [US]CVTF (vector, fixed-point) scalar to decodetree
      target/arm: Rename helper_gvec_vcvt_[hf][su] with _rz
      target/arm: Convert [US]CVTF (vector) to decodetree
      target/arm: Convert FCVTZ[SU] (vector, fixed-point) to decodetree
      target/arm: Convert FCVT* (vector, integer) to decodetree
      target/arm: Convert handle_2misc_fcmp_zero to decodetree
      target/arm: Convert FRECPE, FRECPX, FRSQRTE to decodetree
      target/arm: Introduce gen_gvec_urecpe, gen_gvec_ursqrte
      target/arm: Convert URECPE and URSQRTE to decodetree
      target/arm: Convert FCVTL to decodetree
      target/arm: Use float_round_to_odd in helper_fcvtx_f64_to_f32

 MAINTAINERS                          |    2 +-
 docs/system/arm/fby35.rst            |    5 +
 docs/system/arm/orangepi.rst         |    4 +-
 docs/system/arm/virt.rst             |   16 +
 docs/system/arm/xlnx-versal-virt.rst |    3 +
 target/arm/helper.h                  |   43 +-
 target/arm/internals.h               |    9 +
 target/arm/tcg/helper-a64.h          |    7 -
 target/arm/tcg/translate.h           |   35 +
 target/arm/tcg/a64.decode            |  502 ++-
 target/arm/helper.c                  | 1208 +-------
 target/arm/tcg-stubs.c               |    5 +
 target/arm/tcg/gengvec.c             |  369 +++
 target/arm/tcg/helper-a64.c          |  122 +-
 target/arm/tcg/neon_helper.c         |  106 +-
 target/arm/tcg/tlb-insns.c           | 1266 ++++++++
 target/arm/tcg/translate-a64.c       | 5670 +++++++++++-----------------------
 target/arm/tcg/translate-neon.c      |  337 +-
 target/arm/tcg/translate-vfp.c       |    6 +-
 target/arm/tcg/vec_helper.c          |   65 +-
 target/arm/vfp_helper.c              |   16 +-
 target/arm/tcg/meson.build           |    1 +
 22 files changed, 4203 insertions(+), 5594 deletions(-)
 create mode 100644 target/arm/tcg/tlb-insns.c

