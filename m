Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 673E2CD5BD0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 13:24:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSEEO-0002F1-CD; Wed, 27 May 2026 09:23:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1wSEEN-0002El-Ku
 for qemu-devel@nongnu.org; Wed, 27 May 2026 09:23:31 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1wSEEL-0001Hn-Fo
 for qemu-devel@nongnu.org; Wed, 27 May 2026 09:23:31 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-3665a90bcd3so12601846a91.1
 for <qemu-devel@nongnu.org>; Wed, 27 May 2026 06:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1779888208; x=1780493008; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=D8z/quLm4a6JbxYQnoiaVZ+kIQI0BNpDq3zCF5OW4+0=;
 b=lDdkK4HPNdN5Xs4j0x5b7WVi1hueF4JJV99A8dQ5fjnbmBQ6dqYxHHUBxFau2E/GvW
 GQ1yVOSvj7gY3YT4/K2g1TXq14W8zojlzBU2Uy5hx+tZWnnWXP3bs9i9aYV4TS8mUAtE
 aClbGmpJRyuh8AI0ZzU0C84/KPSOOPtcEVvhENr7tDk4VodahbvvKjvEpDja4glVi2Ya
 Lm65pKe0lbbQflymNZhdJXsapIJPllgfzE3kDH+1OjpmD3/rFXvCyLMDtRRSyJ+JhCEj
 eAqBtSslYnc8RSL0NXSnK9mARHbyl0zuPm1uVj3RtZX4jXoDt1wwX0KB9vWEnI2QRcs8
 k3ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779888208; x=1780493008;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D8z/quLm4a6JbxYQnoiaVZ+kIQI0BNpDq3zCF5OW4+0=;
 b=kMivugVcAqFgrrLr+e8GF8lXigbL/kUNGUyFaLELXayRrlrI++GRYbg83ceW3kfhb3
 O16g5p6THVaAWuMvsPuWeqNgKgDBlNRNXD8GK4KKj82ZEmpC1l5UG9+WKPYTNZMSAuyu
 yCWg+Ie1Q9U6AgjtEsiUvMpNoqymuw13Y3xLoWxH/1Vs0tEaFNP0qqrxTTSG0p29gWHw
 6Qgi1e81IZbSeXwuu99o4efe2iU+XJSmWVfPXDQg3lp4mGvNGo4QV+RvDKJrPXjKS/h1
 yaaCKeihTdoNLVsJs/aI2bkNHp2lACpFIOLLN+hl0k9bFrt2WW+4P1sEs6m8BatIILQd
 nQ6Q==
X-Gm-Message-State: AOJu0YyOkxIOQENgRm0/xzhOEBQ5biEq/HtiqULEZE2N+yLJw+MRPCWV
 j9bOdsTCULtqsmxGQbteT33Lp5QOJFQGyr4qAmE5DRqjRBa1dIy6xekF48vZYp5wqVk=
X-Gm-Gg: Acq92OExmw+koFsMXxANwC8p2UBbC06ez9c2S9j8dRpD10gSwTyXBjn4LBTkvFs6w+m
 gO0IZTctzolNg31MpuUirMdUQ2HFcJ/nP4Lb0ZpnJdT/cTvjcpHO5oz8pkwkvn8kNDvqu00Irlc
 kw19L7JGUoglmho2kzM9KnNgB9qDVDr2EoTNLTnwLeVysDHIZFJW5buhSg3Rnf5noJZx3OlaJh6
 UfMUYqw9Ok12yq40s7Ht4T54JsL22UJLXeUAEOr0TNPJe83A1dCUZaAZTIdN0xBzcndnOmKBjIt
 Vyj32iZe53M/aMEDUOyBKtIqco+ZOUNYRbOxS/5fGmaZDG4dNw9MheML9sSOpl49CFk8ifdbRgq
 DGTHlTdv9v0UbWrzqIjqgcFS9hPNJl9p1jFsN6vvrNWuuZwuLPbMSbn9/yKaiAp3qllJlBdbXyD
 jcBHyuEHSLKfQMszDm3D2+m4Bug/SYkfE2RroMgMCFKnkio6u7dFg+tPNhq6JDEOamChQCpUPuG
 Q4Y+DglCwsqdw==
X-Received: by 2002:a17:90b:358f:b0:36a:a62e:e50d with SMTP id
 98e67ed59e1d1-36aa62ef235mr10701062a91.6.1779888207835; 
 Wed, 27 May 2026 06:23:27 -0700 (PDT)
Received: from sifive.com ([136.226.240.165]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36b2482c24asm979470a91.0.2026.05.27.06.23.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 May 2026 06:23:27 -0700 (PDT)
Date: Wed, 27 May 2026 21:23:24 +0800
From: Max Chou <max.chou@sifive.com>
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu.zevorn@gmail.com>, alistair23@gmail.com
Subject: Re: [PATCH v5 0/9] target/riscv: Add RISC-V Zvfofp8min extension
 support
Message-ID: <ahbv6a1gRykHYxXc@sifive.com>
References: <20260427060928.2322570-1-max.chou@sifive.com>
 <ahZQDCgHelFQfHQM@sifive.com>
 <1e6c1a0a-7d20-492d-ac18-74f6f1630e9a@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1e6c1a0a-7d20-492d-ac18-74f6f1630e9a@oss.qualcomm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=max.chou@sifive.com; helo=mail-pj1-x102f.google.com
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

Hi Daniel,

Thank you for the information.
I'll rebase this patchset and send out v6

Thank,
rnax

On 2026-05-27 10:03, Daniel Henrique Barboza wrote:
> Hi Max!
> 
> On 5/26/2026 11:00 PM, Max Chou wrote:
> > Gental ping.
> 
> 
> I believe we'll need a resend with a rebase due to changes done in the
> last PR, in particular a change I did where I removed the riscv_cpu_*
> arrays.  In other words: we don't need patch 8 anymore.
> 
> 
> Thanks,
> Daniel
> 
> > 
> > On 2026-04-27 14:09, Max Chou wrote:
> > > This patchset adds support for the RISC-V Zvfofp8min isa extension that
> > > provide conversion operations for OCP FP formats.
> > > 
> > > * riscv-isa-manual tag: https://github.com/riscv/riscv-isa-manual/releases/tag/zvfofp8min-0.9
> > > 
> > > Zvfofp8min (v0.9):
> > >    The Zvfofp8min extension provides minimal vector conversion support
> > >    for OFP8 formats. It requires the Zve32f extension and leverages the
> > >    altfmt field in the VTYPE CSR (introduced by Zvfbfa) to select between
> > >    E4M3 (altfmt=0) and E5M2 (altfmt=1) formats.
> > >    - Canonical NaN for both E4M3 and E5M2 is 0x7f
> > >    - All NaNs are treated as quiet NaNs
> > >    Instructions added/extended:
> > >    - vfwcvtbf16.f.f.v: OFP8 to BF16 widening conversion
> > >    - vfncvtbf16.f.f.w: BF16 to OFP8 narrowing conversion
> > >    - vfncvtbf16.sat.f.f.w: BF16 to OFP8 with saturation (new)
> > >    - vfncvt.f.f.q: FP32 to OFP8 quad-narrowing conversion (new)
> > >    - vfncvt.sat.f.f.q: FP32 to OFP8 with saturation (new)
> > > 
> > > Changes in v5
> > > - Drop Zvfofp4min which is not going through the RVIA ratification
> > >    process yet.
> > > - Fix typos.
> > > - Rebase on riscv-to-apply.next (commit bf76a00)
> > > 
> > > Chagnes in v4
> > > - Rebase on riscv-to-apply.next (commit 21101a7)
> > > - Remove the softfloat library related patches (Thanks for RH's help to
> > >    split this part)
> > > - Add missing illegal ALTFMT SEW pattern checking for Zvfofp8min in
> > >    patch 4 (target/riscv: rvv: Make vfwcvtbf16.f.f.v support OFP8 to BF16
> > >    conversion for Zvfofp8min extension)
> > > 
> > > Changes in v3
> > > - Add floatN_nan_is_snan to simply the quiet/signaling NaN checking flow
> > >    in patch 2 & 3
> > > - Add patch 4 to fix pseudo-NaN handling in FPATAN/FYL2XP1/FYL2X helpers
> > > 
> > > Changes in v2
> > > - Merged v1 patch 2 & 3 to v2 patch 3, v1 patch 4 & 5 to v2 patch 4
> > > - Added new v2 patch 2 to refactor the IEEE format NaN classification
> > >    functions (float16, bfloat16, float32, float64) to use internal helper
> > >    functions, reducing code duplication and improving maintainability.
> > >    The OCP FP8 NaN classification functions follow the same pattern.
> > > - Refactored softfloat implementation to use capability-based FloatFmt
> > >    flags (no_infinity, limited_nan, overflow_raises_invalid, normal_frac_max)
> > >    instead of monolithic flags
> > > - Removed ocp_fp8e5m2_no_signal_nan and ocp_fp8_same_canonical_nan flags
> > >    from float_status; now using local float_status with no_signaling_nans
> > >    and default_nan_pattern for RISC-V Zvfofp8min instructions
> > > - Rebased on latest riscv-to-apply.next with zvfbfa v3 patchset
> > > 
> > > v4: <20260304134006.2908449-1-max.chou@sifive.com>
> > > v3: <20260204051756.667397-1-max.chou@sifive.com>
> > > v2: <20260127063723.442734-1-max.chou@sifive.com>
> > > v1: <20260108151650.16329-1-max.chou@sifive.com>
> > > 
> > > References
> > > * OCP FP8 specification:
> > >    https://www.opencompute.org/documents/ocp-8-bit-floating-point-specification-ofp8-revision-1-0-2023-12-01-pdf-1
> > > 
> > > 
> > > Max Chou (9):
> > >    target/riscv: rvv: Fix NOP_UU_B vs2 width
> > >    target/riscv: Add cfg property for Zvfofp8min extension
> > >    target/riscv: Add implied rules for Zvfofp8min extension
> > >    target/riscv: rvv: Make vfwcvtbf16.f.f.v support OFP8 to BF16
> > >      conversion for Zvfofp8min extension
> > >    target/riscv: rvv: Make vfncvtbf16.f.f.w support BF16 to OFP8
> > >      conversion for Zvfofp8min extension
> > >    target/riscv: rvv: Add vfncvtbf16.sat.f.f.w instruction for Zvfofp8min
> > >      extension
> > >    target/riscv: rvv: Add vfncvt.f.f.q and vfncvt.sat.f.f.q instructions
> > >      for Zvfofp8min extension
> > >    target/riscv: Expose Zvfofp8min property
> > >    disas/riscv: Add support of Zvfofp8min extension
> > > 
> > >   disas/riscv.c                              |   9 ++
> > >   target/riscv/cpu.c                         |  15 ++-
> > >   target/riscv/cpu_cfg_fields.h.inc          |   1 +
> > >   target/riscv/helper.h                      |  12 +++
> > >   target/riscv/insn32.decode                 |   5 +
> > >   target/riscv/insn_trans/trans_rvbf16.c.inc |  32 +++++--
> > >   target/riscv/insn_trans/trans_rvofp8.c.inc | 105 +++++++++++++++++++++
> > >   target/riscv/insn_trans/trans_rvv.c.inc    |  39 ++++++++
> > >   target/riscv/tcg/tcg-cpu.c                 |   5 +
> > >   target/riscv/translate.c                   |   1 +
> > >   target/riscv/vector_helper.c               | 104 +++++++++++++++++++-
> > >   11 files changed, 315 insertions(+), 13 deletions(-)
> > >   create mode 100644 target/riscv/insn_trans/trans_rvofp8.c.inc
> > > 
> > > -- 
> > > 2.52.0
> > > 
> 

