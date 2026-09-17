Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C7F2C88E72
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 04:29:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x73jh-0003AA-Qq; Thu, 17 Sep 2026 00:28:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x73jb-000399-Dj
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 00:28:32 -0400
Received: from mail-pj2-x10.google.com ([2607:f8b0:4864:39::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x73jZ-0006lC-9Z
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 00:28:31 -0400
Received: by mail-pj2-x10.google.com with SMTP id
 d9443c01a7336-2d747f01363so3391035ad.2
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 21:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789619307; x=1790224107; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=jS3SXwsc9q3LZO25vaxLZgOO+4dx0v5Wx6YxrZANwGM=;
 b=ytDANwpmnuhVPv470sqskBDHE/LeqyMN6HNFFRLY4omijYcDnWPk2scPEQsmrfIh5O
 V+E+p12/D81oxmPgqRnDXQDTgO76eWtseeBpFzGS8uRRkJ+euG7oM2jfYCz9UqEBtc5r
 M5ANAVr0uCpxSZKaESgEfezupRhFRr4ahJryfXQtTABAfk3+nVemPQyITxn+CY2DeaRs
 SAX/Ircj0qQP5oK7rqj6h/fAlP9hPLuTHSF+UBCaI0SQv8f28d6MlgwW7DRddmVUvpym
 0QXh5V7EBUq4RVy0q7HtY22p6bYD6bVe3ICTxF/kHYKMruAL4tygv1o3cgVMncJ7hgJg
 /F5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789619307; x=1790224107;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=jS3SXwsc9q3LZO25vaxLZgOO+4dx0v5Wx6YxrZANwGM=;
 b=GJWoQrfXYnoStsgNjM1CViNlREUqRD2orDVuzq9AvNNbpKdNMEjHSlrWt9Xk4HNM3/
 JLjg4HGRu8zPXtV5/f57fOirfFHx9DnJmDkpSb5Ox1vtPQZXbmws8kCvcpn4+PJ8bUkD
 VtAboZ4NBuW+1hBa28W2lyUtr/BigEOF6zCqWqdCk5g+fFPXltB/9oSwXY7KkG1G8q5d
 gDyoJmU0hT62uVINQyxwc1Th7YxSt/Ys2QXdrKvoVdv5pF2mtGKtMdFyTNWd8sL4WY2u
 xJZN1xA4cjJ4u24QVN/XHTfFjlixr+vjj6UNPOqH2+7SF7/hwhGZXzB50ZECvbmfNLqC
 B+Yw==
X-Gm-Message-State: AFuF++kyM1DGUDaTBlSwPvOFXQpuFPX74bOAIL9Q+kbQ62Rrkq0oIoSd
 BSPLP1riripv51yULVn4Aq18TNwla4FMJ4ZfZJJ4/RDFen9XhAfurYE+l3lK+jXZx278NoiWpTY
 eDpoc7+Q=
X-Gm-Gg: AYBFou3IHmRdwgKdPVIZI7NxlOfRrnZywAIauN2KHotl8SKxWR3qXdxDlcvgto96G39
 aVzs5JL4CaW2cV4YBPuV9xex6wy/uPaeVO/ezphYK2MTaR0OO6cNVT8bZqRiXKk2BUEvUj3MQT5
 xEWVV1eAson3x2UFtFMpadQ8TLMWwca9Fj864INE/z3H8N5pJkW96ZJS6KfUx2LgBHv3Q0ci9NQ
 8bvzwCftCSk9SbXxjPEl6MukbYBgfSyHHdR7tTbP0okaS5uG5lGQZd87fjrOpYJQICB97BE8OXf
 p79qt9kNibZZifIx22e5VsJmg7K2grYSYp9SwSBHFLKPlThawkNUMIpbocIKTDnxgNgY0aMmeu0
 Qd4tlpb4y2lR8eHt3DJUM9w2+qZ2tWV6MQwracc2sefHnnL6ve7Vwmvc8aKtcm+BQ1KNEd+gvAF
 ZrPGOZb8Y7Z3j/WGql0kiDpCFriYh12L4QS3U31X9CSYLGy/61VIZMvYkEvCVsxqPf/xSmzY999
 t1ecwI=
X-Received: by 2002:a17:90b:3147:b0:39e:d2a:e272 with SMTP id
 98e67ed59e1d1-39e1e25b105mr11578725a91.5.1789619306729; 
 Wed, 16 Sep 2026 21:28:26 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:325f:1938:d075:8c13])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14395d771e5sm10458984c88.15.2026.09.16.21.28.25
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 21:28:26 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 000/101] tcg: Generic expansion of most operations
Date: Wed, 16 Sep 2026 18:26:42 -1000
Message-ID: <20260917042823.542588-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::10;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x10.google.com
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

Changes for v4:
  - Introduce the use of g_autoptr() for TCGTemp.
  - Convert the host memory operations.

Changes for v3:
  - Introduce and use QEMU_*_NONNULL.

Changes for v2:
  - Use DEF<n> instead of DEF_<fmt>, which requires even less boilerplate.
  - Convert a few more operations which are made feasable by the above.

Requires 
  20260914220000.1757165-1-richard.henderson@linaro.org
  ("[PATCH] target/i386/tcg: Always initialize CCPrepare.reg")
  20260914230901.1781309-1-richard.henderson@linaro.org
  ("[PATCH 0/6] target/mips/tcg: MXU fixes and cleanups")
to build cleanly, as the nonnull annotations break them.

https://gitlab.com/rth7680/qemu/-/tree/tcg-regen


r~


Richard Henderson (101):
  include/qemu/compiler: Add QEMU_*_NONNULL attributes
  include/qemu/compiler: Define QEMU_ALIAS
  tcg: Annontate functions in tcg.h with QEMU_*_NONNULL
  tcg: Annontate functions in tcg-op-mem.h with QEMU_*_NONNULL
  tcg: Annontate functions in tcg-internal.h with QEMU_*_NONNULL
  tcg: Use QEMU_ALIAS to define most tcg_gen_*_ptr
  tcg: Use QEMU_*_NONULL with all tcg_gen_*_ptr
  tcg: Prepare for easy temp lifetimes
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
  tcg: Generic expansion of tcg_gen_ld_*
  tcg: Generic expansion of tcg_gen_ld8s_*
  tcg: Generic expansion of tcg_gen_ld8u_*
  tcg: Generic expansion of tcg_gen_ld16s_*
  tcg: Generic expansion of tcg_gen_ld16u_*
  tcg: Generic expansion of tcg_gen_st_*
  tcg: Generic expansion of tcg_gen_st8_*
  tcg: Generic expansion of tcg_gen_st16_*
  tcg: Generic expansion of tcg_gen_dup_*
  tcg: Expand missing mulu2_i64 during liveness
  tcg: Annontate functions in tcg-op-common.h with QEMU_*_NONNULL

 accel/tcg/tcg-runtime.h                    |   13 -
 include/qemu/compiler.h                    |   15 +
 include/tcg/tcg-op-common.h                |  579 ++--
 include/tcg/tcg-op-mem.h                   |   20 +-
 include/tcg/tcg-temp-internal.h            |    2 +
 include/tcg/tcg.h                          |   59 +-
 tcg/tcg-internal.h                         |   43 +-
 include/tcg/tcg-op-def.h.inc               |   84 +
 accel/tcg/tcg-runtime.c                    |   58 -
 tcg/tcg-op-gvec.c                          |   41 -
 tcg/tcg-op-ldst.c                          |   54 -
 tcg/tcg-op.c                               | 3086 ++++++++------------
 tcg/tcg.c                                  |  214 +-
 target/ppc/translate/fixedpoint-impl.c.inc |    4 +-
 14 files changed, 1735 insertions(+), 2537 deletions(-)
 create mode 100644 include/tcg/tcg-op-def.h.inc

-- 
2.53.0


