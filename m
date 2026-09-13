Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C655C88E5A
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2026 02:40:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5a7h-0008Si-Le; Sat, 12 Sep 2026 22:39:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5a7B-0008NQ-Fc
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 22:38:46 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5a79-0000wS-KU
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 22:38:45 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2db3305f94fso32705365ad.0
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2026 19:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789267121; x=1789871921; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=oBl2z3s2IT4kI/J/ZPcuWmh9hoUoWkv/E9ictuw5/Ng=;
 b=FcmqOmZk3q6ebo0Ti+ra7UEROba5mrimU/LGFvQt3cvhQqDRjhNasQXMuxjSYU68LB
 PTQuxPNR2i9Iq87/DNGC8UKCw4m4TUotRr4wrBrcPHDCHXDJD6sPr4reUYmVe/1QkyxB
 R5jYVztjfacmXMkan3j83tcRmGQXfhHuS6+CPUVoQD/LsPj7xRBrW3DCSYprv7KO4Z3t
 NAu6A2CF95r4vDrGI14a5z+T6Vrd31n8J5OFk29T/D/IPUHJk+/5t8N4NzBlYKvJYKjV
 IAvKfDpTXFxiMiAwHkeJTnnwhU7eWF5qJEipvRYs7cJCVA7mUS8MEsg8U2joTBWEgWpr
 XEYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789267121; x=1789871921;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=oBl2z3s2IT4kI/J/ZPcuWmh9hoUoWkv/E9ictuw5/Ng=;
 b=ASxgFTRNO0iX56D+ZtPE4BgtCAbuQRY26AONN8RPvgG3maOjrkplM+Nx0Ub01h5Er8
 /+lPnB70pXQHYrcVvMEQeECsoMZYm2GRecDt1aPz8dyLq1kONO9UT16RsIAB/GHMgwGt
 EazXBYZOebp/RlQMrsb9EQe7bROAivFXCSDPlNkfxrl8OBNSHIkSkTTRz4najlePvS9h
 rsaJ2BMUSv7DpoDYXsHuVkHuQrvsSgTvBfaTP13TB+b7uTHgjnAzyFwQtmQs9iMisyuP
 gwnxz1yPCVeQRRVR4KWBOFvQiq0YW67Ea7CLorKB+SY7sMv3AFLIyutAVBI1oXFBUdFv
 PPkA==
X-Gm-Message-State: AFuF++n8CDPvIUjaDFDwtP4x81MgEh+onWubfon4mKJ/Cw3GA5v1Ejby
 ehYRMj9fyk4NtRl2Z/qltwyUFFWJprjBKicDenEFiia830+GH47Q/ZEDFsIdEBksY23ARbeEMgk
 chytyeAI=
X-Gm-Gg: AYBFou2jxGQlZO707hLua0k9X5BK7F47LM+mPLLo05UabORwyqHjM3taRB3yRd7NRi/
 FQt/twOFEyyexzv9PwdQFhYhTgFMiw1SELTd09c2dvOlVcAi8p3/avbX834RUXimLMZ6CRV196T
 Bx4DjvsWqBbUrR7m5wRFQOEkRsyDqYSD99O7iNqO8yhYRs29iSfnyu536qNZWg69ZSrvVJFN+LU
 yQ4YQTDRjZMMLbRBExPEUzhGPKm9kqEz6wRYelWsVvsiSbC8duGF08KdaoBEyAOYoVk2a1sX3At
 3mff0GTyPY/IlSNfksl1fpgyK0RHfLEs6xiR5mFSae/Qk+PEM4W84gljMU34DKb6+fPWpDfd1BV
 3HepCFeh+lUFP3MU/+aYim7Sb0/idgjctyXRGo2ByIOTzQv+OdRy+E/Hrn+1bnY0soVdZ4TlWoT
 UVc65PW4iWiFJBWs7PN5wjMV3gD88OpkgBDo7LhclXci8qi2E1FftSv3nP+/fYH50Hv+WIMf2LW
 +tpNOC2M+CMPsEV0fA=
X-Received: by 2002:a17:90a:e710:b0:398:d843:cad9 with SMTP id
 98e67ed59e1d1-39d9c202f33mr21542665a91.19.1789267120976; 
 Sat, 12 Sep 2026 19:38:40 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:bf2d:a6f5:e308:cd27])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14365b8ead8sm16174535c88.10.2026.09.12.19.38.39
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 19:38:40 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 00/86] tcg: Generic expansion of most operations
Date: Sat, 12 Sep 2026 16:37:11 -1000
Message-ID: <20260913023837.741866-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

The driver here is the boilerplate I needed to write for the
recent lea opcode addition.

This eliminates the majority of the code duplication between
the _i32 and _i64 expanders.  What remains are those expanders
that truly differ between the two widths, or that are only
present for one width.

Of course, due to touching most opcode expansion, I noticed a
few cleanups and improvements in the process.

Changes for v2:
  - Use DEF<n> instead of DEF_<fmt>, which requires even less boilerplate.
  - Convert a few more operations which are made feasable by the above.


r~


Richard Henderson (86):
  include/qemu: Define QEMU_ALIAS
  tcg: Use QEMU_ALIAS to define most tcg_gen_*_ptr
  tcg: Generic expansion of tcg_gen_mov_*
  tcg: Generic expansion of tcg_gen_movi_*
  tcg: Generic expansion of tcg_gen_discard_*
  tcg: Generic expansion of tcg_gen_add_*
  tcg: Generic expansion of tcg_gen_addi_*
  tcg: Generic expansion of tcg_gen_sub_*
  tcg: Generic expansion of tcg_gen_subi_*
  tcg: Generic expansion of tcg_gen_neg_*
  tcg: Generic expansion of tcg_gen_subfi_*
  tcg: Generic expansion of tcg_gen_and_*
  tcg: Generic expansion of tcg_gen_or_*
  tcg: Generic expansion of tcg_gen_xor_*
  tcg: Generic expansion of tcg_gen_shl_*
  tcg: Generic expansion of tcg_gen_shr_*
  tcg: Generic expansion of tcg_gen_sar_*
  tcg: Generic expansion of tcg_gen_mul_*
  tcg: Generic expansion of tcg_gen_shli_*
  tcg: Generic expansion of tcg_gen_shri_*
  tcg: Generic expansion of tcg_gen_sari_*
  tcg: Generic expansion of tcg_gen_andi_*
  tcg: Generic expansion of tcg_gen_ori_*
  tcg: Generic expansion of tcg_gen_xori_*
  tcg: Generic expansion of tcg_gen_muli_*
  tcg: Generic expansion of tcg_gen_not_*
  tcg: Drop division helpers
  tcg: Generic expansion of tcg_gen_div_*
  tcg: Generic expansion of tcg_gen_rem_*
  tcg: Generic expansion of tcg_gen_divu_*
  tcg: Generic expansion of tcg_gen_remu_*
  tcg: Generic expansion of tcg_gen_andc_*
  tcg: Generic expansion of tcg_gen_eqv_*
  tcg: Generic expansion of tcg_gen_nand_*
  tcg: Generic expansion of tcg_gen_nor_*
  tcg: Generic expansion of tcg_gen_orc_*
  tcg: Generic expansion of tcg_gen_brcond_*
  tcg: Generic expansion of tcg_gen_brcondi_*
  tcg: Generic expansion of tcg_gen_setcond_*
  tcg: Generic expansion of tcg_gen_setcondi_*
  tcg: Generic expansion of tcg_gen_negsetcond_*
  tcg: Generic expansion of tcg_gen_negsetcondi_*
  tcg: Generic expansion of tcg_gen_movcond_*
  tcg: Split out gen_extrl_i64_i32
  tcg: Split out gen_extu_i32_i64
  tcg: Split out gen_extrh_i64_i32
  tcg: Split out gen_ext_i32_i64
  tcg: Generic expansion of tcg_gen_clz_*
  tcg: Use signed integer for tcg_gen_{clz,ctz}i_{i32,i64}
  tcg: Generic expansion of tcg_gen_clzi_*
  tcg: Generic expansion of tcg_gen_ctpop_*
  tcg: Generic expansion of tcg_gen_ctz_*
  tcg: Generic expansion of tcg_gen_ctzi_*
  tcg: Generic expansion of tcg_gen_clrsb_*
  tcg: Generic expansion of tcg_gen_rotl_*
  tcg: Generic expansion of tcg_gen_rotr_*
  tcg: Generic expansion of tcg_gen_rotri_*
  tcg: Generic expansion of tcg_gen_rotli_*
  tcg: Generic expansion of tcg_gen_deposit_*
  tcg: Generic expansion of tcg_gen_extract_*
  tcg: Generic expansion of tcg_gen_sextract_*
  tcg: Generic expansion of tcg_gen_deposit_z_*
  tcg: Generic expansion of tcg_gen_ext8s_*
  tcg: Generic expansion of tcg_gen_ext8u_*
  tcg: Generic expansion of tcg_gen_ext16s_*
  tcg: Generic expansion of tcg_gen_ext16u_*
  tcg: Generic expansion of tcg_gen_ext_*
  tcg: Generic expansion of tcg_gen_smin_*
  tcg: Generic expansion of tcg_gen_smax_*
  tcg: Generic expansion of tcg_gen_umin_*
  tcg: Generic expansion of tcg_gen_umax_*
  tcg: Generic expansion of tcg_gen_abs_*
  tcg: Use smax in abs if available
  tcg: Generic expansion of tcg_gen_ussub_*
  tcg: Use umax in ussub if available
  tcg: Generic expansion of tcg_gen_extract2_*
  tcg: Generic expansion of tcg_gen_addcio_*
  tcg: Generic expansion of tcg_gen_add2_*
  tcg: Generic expansion of tcg_gen_sub2_*
  tcg: Generic expansion of tcg_gen_mulu2_*
  tcg: Generic expansion of tcg_gen_muls2_*
  tcg: Use unsigned for flags for bswap and revbit operations
  tcg: Generic expansion of tcg_gen_bswap16_*
  tcg: Split out gen_bitswap
  tcg: Generic expansion of tcg_gen_revbit8_*
  tcg: Expand missing mulu2_i64 during liveness

 accel/tcg/tcg-runtime.h                    |   13 -
 include/qemu/compiler.h                    |    7 +
 include/tcg/tcg-op-common.h                |  321 +--
 include/tcg/tcg.h                          |    1 +
 include/tcg/tcg-op-def.h.inc               |   75 +
 accel/tcg/tcg-runtime.c                    |   58 -
 tcg/tcg-op-ldst.c                          |   54 -
 tcg/tcg-op.c                               | 2966 ++++++++------------
 tcg/tcg.c                                  |  214 +-
 target/ppc/translate/fixedpoint-impl.c.inc |    4 +-
 10 files changed, 1462 insertions(+), 2251 deletions(-)
 create mode 100644 include/tcg/tcg-op-def.h.inc

-- 
2.53.0


