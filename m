Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C893FC88E53
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2026 10:32:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5L1I-0004mt-BW; Sat, 12 Sep 2026 06:31:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5L1B-0004lo-MD
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 06:31:34 -0400
Received: from mail-pj2-x11.google.com ([2607:f8b0:4864:39::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5L19-0007EB-Cb
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 06:31:33 -0400
Received: by mail-pj2-x11.google.com with SMTP id
 98e67ed59e1d1-396ccda24a3so457709a91.0
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2026 03:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789209089; x=1789813889; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=83QiJLtleLuVFKtWwfOkiieuWjf3v2IFKZgfrveiKVI=;
 b=MTJYNqf6tJkgrw9jzb2Dx9rwO+/4frLdEioicrrM7pw0mJ34xIXJnhxC/86hZT99/L
 5kxq7xiKJ6gqZj9PeFTiJLbAmTZmFbS/pmY2BozqGle1usw3Z4Ws7jov2KZxFaO9cCFV
 NQ8SJ0Z0SQ1FHQC0XtKWgFJr2y/znDem5qdd8gLQHMXurMcDT7Yu0ad3gMz93+OvhWUB
 GLA1/+suf2vHeiXEc1VK5LuzcOIjOUqe2X9GMzNW58/h5gqyIPzK8R2fgFZ5J30zVeQS
 uUhFGK8vmmBnY9QWRK3Oi1XLrefuX3EiHlBNsymS4hp/D3N22bUIRMoDZgKBWuRZjykH
 vdUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789209089; x=1789813889;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=83QiJLtleLuVFKtWwfOkiieuWjf3v2IFKZgfrveiKVI=;
 b=D/w1oDeVEPXSme8LZAsCxAbOUOJ4DWgp19FNFahOWUg9B0HE179UsoDu+q7/X08N5q
 9Q5ufpTHyPqK8Ff1Rrq8W3QiUIEYNzvGjA4YigIxc3VnpJqHsUJRhrN7XSTYPOrlKTnN
 1JtFHIkFtMdFv7Uuvb5FswUBQd53q84o4UnFtQ7TwRVw8np26T4dtwT7BNiPxhmPxMiF
 /iDU9H2KAILhaDXR73nqoYtWRxbFO5+D4LhbXV/b7/YOOfTrPnTanMKwTmmNSLalNSF1
 yTD9PsmsSgxwDAMMbUzpwfqwJq+Wtf8ud3T4dhiU1FDoqK993iMcZANp9E9NBGyAReqf
 Z6Zw==
X-Gm-Message-State: AFuF++ktjeJ4KuptRE2xSQ8wyjmTSyNkwaDnelBFAazLr1GRe6M3Io9R
 Mf6o5zO/KagA7m7nlKVMFbkG7ES9PMjHW1R+IjD9mPrwbk5Tv+hdQ1VHL9LdgVhqPU2hcQiTt0R
 hJKuNMDw=
X-Gm-Gg: AYBFou3yNZvqapSDQRFCp+xDEjbuEBPKaf3ozQ1uN9koSN66r4cOEB/G0dt0jcJA0vO
 pP9YNAsL/kk5EmxLE4YhQOp81Vqbbob1ZTj07k8jyAMLlfc3QF/ih8YA81qaZJCRw++De5HY1px
 zSgmQfrgiizalwWPnryioXHReKJjV/uuFsCrSgrSc/E0+PWQ7BHVcAGmfH6e6Ptp/48w+G+5RTX
 QJnQwtBL7r8BA3nLzHMdWd92o20AneP6JhJkF98QKKIrVYjQnIpKyyGGd34U9FnK5okk0O/CqRr
 adojD7Ber/M6ks4RmDNSqQ8j5dzpv8xl9ITqNlKA7iBftvrLd0r5FWSkOeVuwmsaKZDRm3BSiwF
 LyiCcwGb8dgsfpWRmhOYmIeFju3+ij5hePvsAdbmIvg1VO/luxMnN/J9R4XrAo0SQhHuEqIyNEN
 M9KNrJOz835+hynCvWkUoO7vv7U1ig+g1cULm+Gorsv2KYK/MSp3w0JNI+kOd/ZjKLhlPSUWTXX
 EyXJ0RZqtX1nO8UyA==
X-Received: by 2002:a17:90b:4c85:b0:398:9be6:f997 with SMTP id
 98e67ed59e1d1-39d9c3756d7mr12982532a91.22.1789209089169; 
 Sat, 12 Sep 2026 03:31:29 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:bf2d:a6f5:e308:cd27])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14365b8ead8sm12628226c88.10.2026.09.12.03.31.28
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 03:31:28 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 00/82] tcg: Generic expansion of most operations
Date: Sat, 12 Sep 2026 00:30:04 -1000
Message-ID: <20260912103126.598030-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::11;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x11.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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


r~


Richard Henderson (82):
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
  tcg: Expand missing mulu2_i64 during liveness

 accel/tcg/tcg-runtime.h                    |   13 -
 include/qemu/compiler.h                    |    7 +
 include/tcg/tcg-op-common.h                |  347 +--
 include/tcg/tcg-op-def.h.inc               |   29 +
 include/tcg/tcg-op-def2.h.inc              |   72 +
 accel/tcg/tcg-runtime.c                    |   58 -
 tcg/tcg-op-ldst.c                          |   54 -
 tcg/tcg-op.c                               | 2850 ++++++++------------
 tcg/tcg.c                                  |  214 +-
 target/ppc/translate/fixedpoint-impl.c.inc |    4 +-
 10 files changed, 1535 insertions(+), 2113 deletions(-)
 create mode 100644 include/tcg/tcg-op-def.h.inc
 create mode 100644 include/tcg/tcg-op-def2.h.inc

-- 
2.53.0


