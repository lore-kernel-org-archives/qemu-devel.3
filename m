Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C58D9CD5BDE
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 02:01:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wS3Zp-0002yN-Tt; Tue, 26 May 2026 22:00:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1wS3Zn-0002xm-BM
 for qemu-devel@nongnu.org; Tue, 26 May 2026 22:00:55 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1wS3Zl-00069u-6B
 for qemu-devel@nongnu.org; Tue, 26 May 2026 22:00:55 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2bea7176c72so45693835ad.0
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 19:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1779847251; x=1780452051; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=erHI7TnMbsNF/31zwMAwr5bqNv4Yy73OV/FghEhtzhM=;
 b=Hb6i8iNnVpbD/Dvn73lOAFM4D+jM8+qmxIlHeb7wYS+m/8xCsbLrArzdFQlsiLcYdq
 Cml8jdGhW6/OZLRaZgWf5t3BX/LvRO+z/QEVsaGav0NhPXenGBi/mOslluMRRMtJ8GfB
 AVQQiGaLzXUeGmvftYML/hKjMHn4kLBfjsVa/IpziR51unhJn3tOVmhXxs2KQgxdGdua
 Q3V4oVT2kFizNcz/QSPZ4wFiufs+x1dSAptKruNws+BUy2B93By24Rdl54ZaefBj1G6G
 W2caDYdiOm+HtAmDL7alAxpT0xpQ0SEoi72D/z+D6dRIEj8rHHLOb1Wve3WF4cVfI/V/
 Br7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779847251; x=1780452051;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=erHI7TnMbsNF/31zwMAwr5bqNv4Yy73OV/FghEhtzhM=;
 b=ZYDN8CjPp6ngkufBSpCmIHYhyjkIJ7roHSix4rmVvEnopI0nbzCffHplUnU+YjswOT
 WYJ+ysLxlxMOkvFOFAUDQLLhkRtTXXlUFYtI/ZgL9fg7ppK29H+L0t9N1F6Fu+LzpUsa
 L/LCP1QIQPoQAyIqR0fTz0Ek5NIDPSDUH91RWSWCTaZz8jhSYDHIN5yrEBRk0evIzIAj
 aPJUpl6KtS/rPtPAFHRx1C3kJsuoottJcTpsdQ9aLgJD6V1lB0ozDQtfNqQ1U27Vcm7g
 BO3nPklJ23v7mbFE0VKZGnMHRMcR8sWY/3Ea8PdsRXNYaZvBYLpfpsD/bmW16bQpUoxe
 U0uA==
X-Gm-Message-State: AOJu0Yyo6MINPv3B4q/cPqj76+GZ8HVjDI10hsn5oGLCUUBhCIy82bt4
 wH8EtS20+zXsw6xRjFpDA/7Y5Ie53FkG0CNM+/n2zECR7uB9uL4rAudRjbH1svhfJEiXuj+8Udm
 VF7mJlkCT7kcnwS0T2ANK1BfhXbTyqRa8md0ATdadncKiktHaEvyRQc0oMo98l7SDQM6WrVVwQb
 SFhVYyGANso6W/C6Fu3y+k6U+aET/8MnOP4dhx38q2FA==
X-Gm-Gg: Acq92OESlIGZ5VPYYnkOzJTMjzBnGL2PRRG6qfIM0G3r39RQh2BYSFHxEbo2T33FC9L
 G4l1YIMBHsCD87+Fo6usQ6CE59GmHkOaQEuZ137iJ8E5iVl882M8uOAAU3naVu8gf5c9Y8MwgqE
 C3nH+UGOsaUL4uDS3Ss7WwKhQm26zx4qZ8tWogo6KhjyKGSrEQF2Zgx+2nPA3kmXhBVmWwqUbUg
 to6zd/haFNIl2CGtTl297NEvHK+fLUjYB3QbPGtnppoCKemiMT8MM8ppBOQ6ngrLQRQhiYoAqX9
 Jxu9fo7jAhqNe5pTQjMS7NrXV8WHBRjxoIoxQkmh3sboYZ1OD1oPnquEjLY3xF+4uBEfBrJXJhG
 5ootZTJA664dSWPFBYTgH4KEyhcWjU++mZbRVMwmWbP46e5335moWBwCzylcpsByiU29uUurjL4
 keNE1c4O6FpQhMCzO0Tx2mASO/Pm2RKWTm5GmG8fC4Tf1j/6s4boA54VU/e1H5nQAPnxfBqZono
 dI=
X-Received: by 2002:a17:903:3c6b:b0:2b2:49a7:a5bc with SMTP id
 d9443c01a7336-2beb0715592mr226540065ad.39.1779847251348; 
 Tue, 26 May 2026 19:00:51 -0700 (PDT)
Received: from sifive.com ([136.226.240.165]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2beb5695c40sm126634085ad.5.2026.05.26.19.00.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 19:00:51 -0700 (PDT)
Date: Wed, 27 May 2026 10:00:48 +0800
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <Alistair.Francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu.zevorn@gmail.com>, alistair23@gmail.com
Subject: Re: [PATCH v5 0/9] target/riscv: Add RISC-V Zvfofp8min extension
 support
Message-ID: <ahZQDCgHelFQfHQM@sifive.com>
References: <20260427060928.2322570-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260427060928.2322570-1-max.chou@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=max.chou@sifive.com; helo=mail-pl1-x630.google.com
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

Gental ping.

On 2026-04-27 14:09, Max Chou wrote:
> This patchset adds support for the RISC-V Zvfofp8min isa extension that
> provide conversion operations for OCP FP formats.
> 
> * riscv-isa-manual tag: https://github.com/riscv/riscv-isa-manual/releases/tag/zvfofp8min-0.9
> 
> Zvfofp8min (v0.9):
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
> Changes in v5
> - Drop Zvfofp4min which is not going through the RVIA ratification
>   process yet.
> - Fix typos.
> - Rebase on riscv-to-apply.next (commit bf76a00)
> 
> Chagnes in v4
> - Rebase on riscv-to-apply.next (commit 21101a7)
> - Remove the softfloat library related patches (Thanks for RH's help to
>   split this part)
> - Add missing illegal ALTFMT SEW pattern checking for Zvfofp8min in
>   patch 4 (target/riscv: rvv: Make vfwcvtbf16.f.f.v support OFP8 to BF16
>   conversion for Zvfofp8min extension)
> 
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
> v4: <20260304134006.2908449-1-max.chou@sifive.com>
> v3: <20260204051756.667397-1-max.chou@sifive.com>
> v2: <20260127063723.442734-1-max.chou@sifive.com>
> v1: <20260108151650.16329-1-max.chou@sifive.com>
> 
> References
> * OCP FP8 specification:
>   https://www.opencompute.org/documents/ocp-8-bit-floating-point-specification-ofp8-revision-1-0-2023-12-01-pdf-1
> 
> 
> Max Chou (9):
>   target/riscv: rvv: Fix NOP_UU_B vs2 width
>   target/riscv: Add cfg property for Zvfofp8min extension
>   target/riscv: Add implied rules for Zvfofp8min extension
>   target/riscv: rvv: Make vfwcvtbf16.f.f.v support OFP8 to BF16
>     conversion for Zvfofp8min extension
>   target/riscv: rvv: Make vfncvtbf16.f.f.w support BF16 to OFP8
>     conversion for Zvfofp8min extension
>   target/riscv: rvv: Add vfncvtbf16.sat.f.f.w instruction for Zvfofp8min
>     extension
>   target/riscv: rvv: Add vfncvt.f.f.q and vfncvt.sat.f.f.q instructions
>     for Zvfofp8min extension
>   target/riscv: Expose Zvfofp8min property
>   disas/riscv: Add support of Zvfofp8min extension
> 
>  disas/riscv.c                              |   9 ++
>  target/riscv/cpu.c                         |  15 ++-
>  target/riscv/cpu_cfg_fields.h.inc          |   1 +
>  target/riscv/helper.h                      |  12 +++
>  target/riscv/insn32.decode                 |   5 +
>  target/riscv/insn_trans/trans_rvbf16.c.inc |  32 +++++--
>  target/riscv/insn_trans/trans_rvofp8.c.inc | 105 +++++++++++++++++++++
>  target/riscv/insn_trans/trans_rvv.c.inc    |  39 ++++++++
>  target/riscv/tcg/tcg-cpu.c                 |   5 +
>  target/riscv/translate.c                   |   1 +
>  target/riscv/vector_helper.c               | 104 +++++++++++++++++++-
>  11 files changed, 315 insertions(+), 13 deletions(-)
>  create mode 100644 target/riscv/insn_trans/trans_rvofp8.c.inc
> 
> -- 
> 2.52.0
> 

