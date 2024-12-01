Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98B47D49771
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Dec 2024 15:21:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tHlWe-0001AO-2P; Sun, 01 Dec 2024 10:06:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tHlWa-00019M-Oh
 for qemu-devel@nongnu.org; Sun, 01 Dec 2024 10:06:16 -0500
Received: from mail-ot1-x336.google.com ([2607:f8b0:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tHlWW-00041B-8V
 for qemu-devel@nongnu.org; Sun, 01 Dec 2024 10:06:14 -0500
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-71d4182b2cbso1292244a34.2
 for <qemu-devel@nongnu.org>; Sun, 01 Dec 2024 07:06:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733065570; x=1733670370; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=fasd9IhA2SmNuJt0njre9SauhWKB0jfxt6O24qYfxCk=;
 b=SHRUrkLrw42cBjQBul9H/jSYbf/NpecH6R4+tCpB//MB7yh38IMtD5LpE1VzP4ulUl
 9TEQrLWb/tA9WchJbVOwIyyTS9Dlwxc567eCUK8EaKHyr12GG6XUTITjY2c4it1DCXuG
 vh+o/iTp4zKIG3tu+THsYXOwYkhLHeELLqDa0W/8xUB2YAE2zEs0zOy3vI0I+OJJNT4A
 0XmMgFxiX68rMwp1ZK9anDPq0kjLPz8D6gKaE1ca44OPxbZBQff9yT7iXTOrCKQXh4uE
 GhsUvveKpqf7K8Myv/cu+gsWMwlekwA6eORC1aAEwiRHpwN+Ogdg8rtqWZhahUC4nCka
 4dFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733065570; x=1733670370;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fasd9IhA2SmNuJt0njre9SauhWKB0jfxt6O24qYfxCk=;
 b=ha/FxxrccbhPwFc4kgKq73I3ibeSoTX89a32HJX3gFp9viBYVQ6E4Lac7+A8RWhuRi
 vSneR4UC46k+am/MIFNeGNY2SniYMdgrW/3RSM+HZoKM0xAUt2uS4rMBs98BQQqVKRfk
 4jMC68FR/Rjn9mKE6q9L1sWRkTUSmj65DwtZpArDjkVJjZVpFUx6nUDFc+fz/uVubEs2
 FvNoIrl0hZiQDAv0qK+mI4c9V0d2CLTfQ14KNv0cHxmbckk4yilxauLemvAWyRi50egj
 eOzGPXVwYr/ra2Fb3pfVUNB2DRWsBjZgPtcr3nCaY4YtQyvtc1rKtWguh/HSB1HTzCFA
 YSGQ==
X-Gm-Message-State: AOJu0YzbfqdbNFQGM+agNTTlQr0+mCB3O2C8Qx7fkI0eYoMuKA/ERRV8
 wvgswB5ZuHonBtnjewqlvTNQHjK0UZvI3XEKgvdhaa730O859QeREalqLtV9nZRNvruFyxqLBmD
 xl+8=
X-Gm-Gg: ASbGncsOJKCWPjuN74+8qGrdlNZfwgBdSsqztuPV3dtmyCKsRbLhPqMSwWb4GJrWMF3
 lhMokWK8M9cyLNhwL2x68THXvfG3dTGGwKz+bsC3tPv1tCVw+l3xkTy0W1FuLErGzruIbLPPKDg
 wIBB3SvDROILRKKi/+mp7j+8tpiDK8Gg9+7TKfVs0i2hdpMl98Z62MnDGk0h9kMXXyg+nDcZ7At
 XyOQpupFjNKALd2KgTHGgcrdJupduBvhKwMyc7o2gzDFeBVxmQ9rmGWLqcR/EBhnMaIwjHnNWHg
 a70z9ziVX/ljBMWIo7iGh0tNAeP5XJdFc6/T
X-Google-Smtp-Source: AGHT+IH2r6pTW7PBDdiji4AKdtbezp+NsVLNt4jZeYvN/YhEbOh7jZcwrPqXqhb5aOxmm1RFA9cg8A==
X-Received: by 2002:a05:6830:3c04:b0:71a:8048:403c with SMTP id
 46e09a7af769-71d65cfa86cmr13670562a34.19.1733065569755; 
 Sun, 01 Dec 2024 07:06:09 -0800 (PST)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71d7254473asm1822220a34.27.2024.12.01.07.06.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Dec 2024 07:06:09 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 00/67] target/arm: AArch64 decodetree conversion, final part
Date: Sun,  1 Dec 2024 09:04:59 -0600
Message-ID: <20241201150607.12812-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::336;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x336.google.com
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

Finish the conversion of all aarch64 instructions to decodetree.

r~

Richard Henderson (67):
  target/arm: Use ### to separate 3rd-level sections in a64.decode
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
 target/arm/tcg/translate.h      |   29 +
 target/arm/tcg/gengvec.c        |  355 ++
 target/arm/tcg/helper-a64.c     |  104 -
 target/arm/tcg/neon_helper.c    |  106 +-
 target/arm/tcg/translate-a64.c  | 5674 ++++++++++---------------------
 target/arm/tcg/translate-neon.c |  317 +-
 target/arm/tcg/translate-vfp.c  |    6 +-
 target/arm/tcg/vec_helper.c     |   65 +-
 target/arm/vfp_helper.c         |   16 +-
 target/arm/tcg/a64.decode       |  502 ++-
 12 files changed, 2874 insertions(+), 4350 deletions(-)

-- 
2.43.0


