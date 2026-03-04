Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31F2FEF8FF4
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 15:21:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxo2T-0007gp-Em; Wed, 04 Mar 2026 10:21:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vxo2P-0007g9-Pl
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 10:21:26 -0500
Received: from mail-dy1-x1342.google.com ([2607:f8b0:4864:20::1342])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vxo2N-0004yt-Ly
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 10:21:25 -0500
Received: by mail-dy1-x1342.google.com with SMTP id
 5a478bee46e88-2b4520f6b32so7948531eec.0
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2026 07:21:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772637682; x=1773242482; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=E+/aNxzK/JzNMpr0BILywIZcElsAWaLZhvEmj94st38=;
 b=Dy47mNf2dxcfgriSpyIToWZ5xW2HLo+4OY4YkvO7j2US5uWuRmwQStuhYmXBvueLpg
 MrIF10L8ADSxa5Vvz+yNykfoJsbiysRev+r0sOz57E9+01CJIIJ9Mf/mj+QQbwsvO777
 Qt8ZzxehK0X8sOAi5IMtXEThPr4+oKtTpT2lcqoF9S8hoFv7HwMhGQe5vJKmeULF7jBG
 q/wjwd7vH7ozqsorOTH61sP21WDra6+qUrenlDslM4HNsxSw0dk7fhBANHOkQpomn7Yy
 eW049Efd8U0k+GM5zOC0DNYDeTnD0Z+UwAxRDZfqICD0Rf4550cZcOM3wSY5aqFCgAUi
 /3cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772637682; x=1773242482;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E+/aNxzK/JzNMpr0BILywIZcElsAWaLZhvEmj94st38=;
 b=fTC6pqXlV8E+PhlbSBjqWyu5wedhVroH+2ZLX5sCbbPb6bTi0c4X3hi+0QKmAnSRGS
 HkZPRvhWglgV8fA+WF/aevsuKeI4bCe3KFmKvh6JcuCnXQ0AQySYBTI7QMipcdzEE1i2
 7bG+ZyNHAQv06VwtWmDZhUFDItr2wcvCi+R7KK2IDcLpUCnTHzAfu8idX8yKQTOMjRj1
 cV3/sqLbAl4rk6iJQ9vwrHlIpHwrKCUzBFs/cNxC7x8Af036q3r/tjGl479BCnde+NMG
 TunFfn6Rde6/1VW1ckBopufHslNVS+p2I03AIRIuuCK0IPzRYJaV/l4CQd3YVHG253ay
 fO4w==
X-Gm-Message-State: AOJu0Yx3K3lUJSi+vfbkBecy2g8dm9qUDX/VozKAhu0s6O1OIPrXwR5g
 vZcjR1ZDHbSaFnfjTxjgzChBDhbTyIfG/D/GvSn1/HkuUOwIKlQUWBRn
X-Gm-Gg: ATEYQzx6bvlWs2R+CKy8ZiP3gpOuEH6DK1cuPGMHlXFBKVtZffDxBb5z35hhDX/ZYto
 BsKjR5mS4MyLReohIx3WcYeqQF0Pl+fvz7AIMoDIC2OO7kvKcGolVQzx8I1csEvOEX0CVmONb2S
 6bkJg4If6u8EOLKHEUe8okOPhxAz2g1Bpks7QfRsPKEYvPQv3dReLD/7ofdwoCzJ9jhOJD1Vy95
 +F+LJ7V62XQGZIdSeLskHVuTZ2I5/vtgQC8MMRxiRy7ZKVk2GoB1DijUr1rXccgQArdPjAC1P3b
 D7UDiy/iHGGq2megUCFY8Rwft7YieELi4KeLdNLmMAdlC3TZwPRehAl8y5WU1u9CdSYoG5jthOL
 74XjUfjHOKY2rbH3dqlh87NQFeNaXaTzKJMdZlCIHCCrtB3EazGYk9iB5dLu/K6buYVZZO2z4jl
 QaihMx7HF41tqtS4CIQylxwCUydM0pd/6gKzASRPnTMde0s3zUQNoTYQ1X+1iqpdQjidIJTjiHB
 1k7Dn4efGimr9caeAlXSA8tHX0mUAY=
X-Received: by 2002:a05:7301:6781:b0:2be:22b0:8bf3 with SMTP id
 5a478bee46e88-2be310abb31mr830418eec.30.1772637680403; 
 Wed, 04 Mar 2026 07:21:20 -0800 (PST)
Received: from ZEVORN-PC.localdomain ([38.95.120.198])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2be2880e755sm2605979eec.6.2026.03.04.07.21.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Mar 2026 07:21:19 -0800 (PST)
Date: Wed, 4 Mar 2026 23:20:54 +0800
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Max Chou <max.chou@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH v4 00/14] Add OCP FP8/FP4 and RISC-V
 Zvfofp8min/Zvfofp4min extension support
Message-ID: <aahNUTQSZZBw9Xbe@ZEVORN-PC.localdomain>
References: <20260304134006.2908449-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260304134006.2908449-1-max.chou@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1342;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-dy1-x1342.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Hi Max,

On Wed, Mar 04, 2026 at 09:39:52PM +0800, Max Chou wrote:
> This patchset adds support for the RISC-V Zvfofp8min and Zvfofp4min isa
> extensions that provide conversion operations for OCP FP8/FP4 formats.
> 
> * Zvfofp8min (Version 0.2.1):
>   The Zvfofp8min extension provides minimal vector conversion support
>   for OFP8 formats. It requires the Zve32f extension and leverages the
>   altfmt field in the VTYPE CSR (introduced by Zvfbfa) to select between
>   E4M3 (altfmt=0) and E5M2 (altfmt=1) formats.
>   - Canonical NaN for both E4M3 and E5M2 is 0x7f
>   - All NaNs are treated as quiet NaNs
>   Instructions added/extended:
>   - vfwcvtbf16.f.f.v: OFP8 to BF16 widening conversion
>   - vfncvtbf16.f.f.w: BF16 to OFP8 narrowing conversion
>   - vfncvtbf16.sat.f.f.w: BF16 to OFP8 with saturation (new)
>   - vfncvt.f.f.q: FP32 to OFP8 quad-narrowing conversion (new)
>   - vfncvt.sat.f.f.q: FP32 to OFP8 with saturation (new)
> 
> * Zvfofp4min (Version 0.1):
>   The Zvfofp4min extension provides minimal vector conversion support
>   for the OFP4 E2M1 format. It requires the Zve32f extension.
>   Instructions added:
>   - vfext.vf2: OFP4 E2M1 to OFP8 E4M3 widening conversion
> 
> Chagnes in v4
> - Rebase on riscv-to-apply.next (commit 21101a7)
> - Remove the softfloat library related patches (Thanks for RH's help to
>   split this part)
> - Add missing illegal ALTFMT SEW pattern checking for Zvfofp8min in
>   patch 4 (target/riscv: rvv: Make vfwcvtbf16.f.f.v support OFP8 to BF16
>   conversion for Zvfofp8min extension)
> 
Thanks for this v4 series! I learned a lot about the OCP
FP8/FP4 formats and the Zvfofp8min/Zvfofp4min extensions
while reviewing these patches.

I've been preparing an RFC patchset that provides basic
tests for the OCP FP8/FP4 specification, to complement
QEMU's existing fp test coverage. It's not quite ready
yet, but I plan to post it upstream soon for discussion.

A few minor issues noted in individual patch replies
(missing REQUIRE_FPU in patch 12, typos in commit
subjects). Otherwise the series looks good overall.

Thanks,
Chao
> Changes in v3
> - Add floatN_nan_is_snan to simply the quiet/signaling NaN checking flow
>   in patch 2 & 3
> - Add patch 4 to fix pseudo-NaN handling in FPATAN/FYL2XP1/FYL2X helpers
> 
> Changes in v2
> - Merged v1 patch 2 & 3 to v2 patch 3, v1 patch 4 & 5 to v2 patch 4
> - Added new v2 patch 2 to refactor the IEEE format NaN classification
>   functions (float16, bfloat16, float32, float64) to use internal helper
>   functions, reducing code duplication and improving maintainability.
>   The OCP FP8 NaN classification functions follow the same pattern.
> - Refactored softfloat implementation to use capability-based FloatFmt
>   flags (no_infinity, limited_nan, overflow_raises_invalid, normal_frac_max)
>   instead of monolithic flags
> - Removed ocp_fp8e5m2_no_signal_nan and ocp_fp8_same_canonical_nan flags
>   from float_status; now using local float_status with no_signaling_nans
>   and default_nan_pattern for RISC-V Zvfofp8min instructions
> - Rebased on latest riscv-to-apply.next with zvfbfa v3 patchset
> 
> v3: <20260204051756.667397-1-max.chou@sifive.com>
> v2: <20260127063723.442734-1-max.chou@sifive.com>
> v1: <20260108151650.16329-1-max.chou@sifive.com>
> 
> References
> * OCP FP8 specification:
>   https://www.opencompute.org/documents/ocp-8-bit-floating-point-specification-ofp8-revision-1-0-2023-12-01-pdf-1
> * Zvfofp8min specification (v0.2.1 commit e1e20a7):
>   https://github.com/aswaterman/riscv-misc/blob/main/isa/zvfofp8min.adoc
> * Zvfofp4min specification (v0.1 commit e1e20a7):
>   https://github.com/aswaterman/riscv-misc/blob/main/isa/zvfofp4min.adoc
> 
> Based-on: <20260304132514.2889449-1-max.chou@sifive.com>
> ([v4,0/9] Add Zvfbfa extension support)
> Based-on: <20260226071817.1417875-1-max.chou@sifive.com>
> ([v2,0/2] fpu: Fix OCP FP8 E4M3 conversion issues)
> 
> rnax
> 
> 
> Max Chou (14):
>   target/riscv: rvv: Fix NOP_UU_B vs2 width
>   target/riscv: Add cfg properity for Zvfofp8min extension
>   target/riscv: Add implied rules for Zvfofp8min extension
>   target/riscv: rvv: Make vfwcvtbf16.f.f.v support OFP8 to BF16
>     conversion for Zvfofp8min extension
>   target/riscv: rvv: Make vfncvtbf16.f.f.w support BF16 to OFP8
>     conversion for Zvfofp8min extension
>   target/riscv: rvv: Add vfncvtbf16.sat.f.f.w instruction for Zvfofp8min
>     extension
>   target/riscv: rvv: Add vfncvt.f.f.q and vfncvt.sat.f.f.q instructions
>     for Zvfofp8min extension
>   target/riscv: Expose Zvfofp8min properity
>   disas/riscv: Add support of Zvfofp8min extension
>   target/riscv: Add cfg properity for Zvfofp4min extension
>   target/riscv: Add implied rules for Zvfofp4min extension
>   target/riscv: rvv: Add vfext.vf2 instruction for Zvfofp4min extension
>   target/riscv: Expose Zvfofp4min properity
>   disas/riscv: Add support of Zvfofp4min extension
> 
>  disas/riscv.c                              |  12 ++
>  target/riscv/cpu.c                         |  29 ++++-
>  target/riscv/cpu_cfg_fields.h.inc          |   2 +
>  target/riscv/helper.h                      |  15 +++
>  target/riscv/insn32.decode                 |   8 ++
>  target/riscv/insn_trans/trans_rvbf16.c.inc |  32 +++--
>  target/riscv/insn_trans/trans_rvofp4.c.inc |  43 +++++++
>  target/riscv/insn_trans/trans_rvofp8.c.inc | 105 ++++++++++++++++
>  target/riscv/insn_trans/trans_rvv.c.inc    |  39 ++++++
>  target/riscv/tcg/tcg-cpu.c                 |  10 ++
>  target/riscv/translate.c                   |   2 +
>  target/riscv/vector_helper.c               | 137 ++++++++++++++++++++-
>  12 files changed, 421 insertions(+), 13 deletions(-)
>  create mode 100644 target/riscv/insn_trans/trans_rvofp4.c.inc
>  create mode 100644 target/riscv/insn_trans/trans_rvofp8.c.inc
> 
> -- 
> 2.52.0
> 

