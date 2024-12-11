Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FDFAE7717D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 16:46:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLPcN-0003tI-R7; Wed, 11 Dec 2024 11:31:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tLPc7-0002pW-Tg
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:31:04 -0500
Received: from mail-qt1-x82b.google.com ([2607:f8b0:4864:20::82b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tLPc5-00017v-F0
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:31:03 -0500
Received: by mail-qt1-x82b.google.com with SMTP id
 d75a77b69052e-4677675abd5so12796271cf.1
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 08:31:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733934660; x=1734539460; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=pq8nZT5Gnqwy8LaCbH8GMbC7AkzzD+F/2z9SWgAl6Cs=;
 b=Zp1OFZlzgu1L8GqbykEwR1Fww/9jFjoLA9eFyiQJow/J3YuiIoSrrR6EaCQAU9gA4R
 RUGFmaq2oeRjR8eT4V/NVS4mmyyOwRyYKcI0z0YQpUx5o+VEzOvKhxppb0d8pmuP//nS
 Vc2wTGG4+qzuny+DKDOxzI3ULJAPYXAKiE2pcenxGFxbMNNJi9rNAm3UIBIzqPprEVwi
 4hNBE7KlrcSqHGrW2turX2Bp2mtfr2iZdSE11E1yiuszQxZpNmwiw4QeH0zgWHnHsjCj
 RB6ZnWJI3K7Bn/Fa1Gm64T3xYLBanjKiv/89+a5PNt70l63JrwHQ43GCB8tMt2vf7pRt
 tqMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733934660; x=1734539460;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pq8nZT5Gnqwy8LaCbH8GMbC7AkzzD+F/2z9SWgAl6Cs=;
 b=hxQTkKydCBnurbHRcZ3TrlhTKhZe7KlzRLm3U4KUT7oXZOfY/bheM0kzJ+rCZamOTd
 oY//XbPeQzjo4vN+Kg8ZBNQh9dLH7HGlUbUwCO4J00ewOYuu6VR1xg9ovGRa972jV6p1
 60GS9Y5tdODT/W+WsEDdEm5wMwMsuMYOTiS+8+31+AQ0fyzfjt7LEG/2iNAX1OMoKPTb
 x/Swzqekq4KfduwiuYiuN3mCtqx+15zwZYeakRuWTATZ3Sl18Meoa5+CqBrHZbyEVQGo
 rw84rg9OO1ij6hLjwyx7wcWk5JtCttKwFdpu8O9sFcrHIkNfASIhSE/cFjupUFYNJTI+
 XOlQ==
X-Gm-Message-State: AOJu0Yy7tAdNSAp+4LKIZ7UZ0iom/WvTwtyX9udrrWYTXGq6FAg4K7z0
 XUcIB/7YBPGmuTlzmDqu9C7Nb2KBO+eFOB72brh4Yc9MNhDbv0//WVnndn9e14lnjDv8m2uLqcT
 cLWpysWKb
X-Gm-Gg: ASbGnct2wN0DgGuYbG63cjRK2p7NwlFYJPmv3z/6l8EtLg+4950+XQWtXFD30/EP8fx
 bSHSmqfijn3kMTVs6u3nMz+gSBjwp//DbrmFHuR39gyb4GIVitIsk8+Vs45Mvtk0HKXtuXTUpSo
 9/u7BqiexEAORTkVUBBo/u5RDUFGELICSRHZ5JCQXr3dGJJEalOyHL+Sdz3tQz9iIPQ9xOBNKGH
 OnbNLU8qoUNUaa7BkrQ97F0gimGyx2bCJNW056EDRXta/gqKLIdvLGMtC9tew==
X-Google-Smtp-Source: AGHT+IGVXP8C3TFkWiqYCrl3Hyaf3zNwBqfDGcAXtJa4oPHv63jTypX+NRZfemAGCI49WL6VR+H49Q==
X-Received: by 2002:ac8:58cf:0:b0:462:b36a:73b8 with SMTP id
 d75a77b69052e-467953f4614mr5201761cf.43.1733934659857; 
 Wed, 11 Dec 2024 08:30:59 -0800 (PST)
Received: from stoup.. ([187.217.227.247]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46755db613csm43849381cf.70.2024.12.11.08.30.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 08:30:59 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v3 00/69] target/arm: AArch64 decodetree conversion, final part
Date: Wed, 11 Dec 2024 10:29:27 -0600
Message-ID: <20241211163036.2297116-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::82b;
 envelope-from=richard.henderson@linaro.org; helo=mail-qt1-x82b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Finish the conversion of all aarch64 instructions to decodetree.

Changes for v3:
  - Fix decode for f16 fsqrt (vector) in patch 23, prior to conversion.
    This is the only patch without R-B.


r~


Richard Henderson (69):
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
  target/arm: Convert FRINT{32,64}[ZX] (scalar) to decodetree
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
  target/arm: Move helper_neon_addlp_{s8,s16} to neon_helper.c
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
  target/arm: Convert [US]CVTF (vector, fixed-point) scalar to
    decodetree
  target/arm: Rename helper_gvec_vcvt_[hf][su] with _rz
  target/arm: Convert [US]CVTF (vector) to decodetree
  target/arm: Convert FCVTZ[SU] (vector, fixed-point) to decodetree
  target/arm: Convert FCVT* (vector, integer) to decodetree
  target/arm: Convert handle_2misc_fcmp_zero to decodetree
  target/arm: Convert FRECPE, FRECPX, FRSQRTE to decodetree
  target/arm: Introduce gen_gvec_urecpe, gen_gvec_ursqrte
  target/arm: Convert URECPE and URSQRTE to decodetree
  target/arm: Convert FCVTL to decodetree

 target/arm/helper.h             |   43 +-
 target/arm/tcg/helper-a64.h     |    7 -
 target/arm/tcg/translate.h      |   35 +
 target/arm/tcg/gengvec.c        |  369 ++
 target/arm/tcg/helper-a64.c     |  104 -
 target/arm/tcg/neon_helper.c    |  106 +-
 target/arm/tcg/translate-a64.c  | 5670 ++++++++++---------------------
 target/arm/tcg/translate-neon.c |  337 +-
 target/arm/tcg/translate-vfp.c  |    6 +-
 target/arm/tcg/vec_helper.c     |   65 +-
 target/arm/vfp_helper.c         |   16 +-
 target/arm/tcg/a64.decode       |  502 ++-
 12 files changed, 2888 insertions(+), 4372 deletions(-)

-- 
2.43.0


