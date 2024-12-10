Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F30BBE7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 15:24:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tL25u-0004By-G7; Tue, 10 Dec 2024 10:24:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL25s-0004Bb-Rw
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 10:24:12 -0500
Received: from mail-oi1-x236.google.com ([2607:f8b0:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL25q-0008IN-RI
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 10:24:12 -0500
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-3eb551be83cso640269b6e.2
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2024 07:24:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733844249; x=1734449049; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=B3eoOth1Df8ZAOOZFPr4dKRCNNlzU0ZCe3W+Yx0ygDE=;
 b=gLXkFaNqN4xE92mZDtDH8uCCgZGacoVyqXsKGomztRLjb3RO60hoqU18fp32mN/rru
 NQZ/3XeSsZxMfq5JMirPeiFFHIlwHOSum81aSyX16hGx2gSLa8WTB/SFVsvo3JsH6LnG
 bvybyVI2RSB1ioC6g8lsBfOXPjtK4L2oDwIBtkSa5UY4SrKf/BKb0bzOs9ZQufFgWJlp
 MPWH7GD9bMywCqDGDVGGVPwV3zBJd4VPuxaKzrnkEaJugXT39cggZWxLsiOtOGpItrEv
 rWovb8AnbL5rlfzhFz5BbshsJIoUQHDnsZgbKvd5xX0icu+9GBNsZeGMtulXYRkU4JLg
 9H3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733844249; x=1734449049;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=B3eoOth1Df8ZAOOZFPr4dKRCNNlzU0ZCe3W+Yx0ygDE=;
 b=LGx/Qs5ZU4JNZ3qBrB3vfSHNJFGsJsg6+u0Xtd1CdIfi8iupve57nYMZVT1Zpm0lNT
 PS3e36Eq9oNo34xHlFZ9pajJ3N9yJyl3hoiy9QkrebI58ehw+eacelvA39RJfVrCfzMm
 QxAUGE4PaWvoB/LdXr4bXjP6sPoL+73/jo2WeYjNg5oOEn6M2xtZRSWrm0omjejaLIju
 HRnk3C/L5qmH8kPzeT4aYrnNJQ93jFe3GXIzk52r/vZqIo4AeTp0auqZANW+KkSiBFI/
 5pHx8U9RL5CJULf6iHrUXHSaPHfpU06j3X2Ij4xMqq0lyWCOU80NOG+xIdsQ8dDKpGdN
 rOBg==
X-Gm-Message-State: AOJu0YzJ9aWXRkDpg/cPayfU6VUKn4WydqSflkZLqrUAYQ6wAcHhsg7+
 0jTdD0uXbVIfXJzVEoAU4MBVscsiAxp4kqYN3DIGi3c3MGUSLgsFSwSTk8r9XUHD+83DolAdMg0
 9QZ2XzDXp
X-Gm-Gg: ASbGncuGnr8Bd8cZukjL8fNLYfz8mSR+zq+NNv87Dhgz8XXFeh7OyCJhXe4hQ3xtcFw
 Tn1bc/LyHssH3X0QfLhgExT1+RRmVQ3nEGfxvjQ5kIwPaa+VksJu0Ar2IazzUaSG28CtbiLlmwT
 0ktenwXsmJE9eQBRpXo3islxMgqbKL0AoEP9ST7lVTKQ9alo//F9IDqQI7j7pxl8bDe6XhW0rqA
 F1bmzIdSD5N5hG7u2h701jpkPbkKbzJg9qlAFlz86DDjvq2p4ueCA6dP/WrDg==
X-Google-Smtp-Source: AGHT+IFQOBt7S803W81Af6MwyOqyi86LxfFtRBxr189Irk6q00m1fXu7crXoZ88yDkLy9TcT/7UFxQ==
X-Received: by 2002:a05:6808:10c8:b0:3e6:147:6c5 with SMTP id
 5614622812f47-3eb66df077emr3674955b6e.10.1733844249023; 
 Tue, 10 Dec 2024 07:24:09 -0800 (PST)
Received: from stoup.. ([187.217.227.247]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3eb076b9168sm2776435b6e.14.2024.12.10.07.24.07
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Dec 2024 07:24:08 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 00/46] tcg: Remove in-flight mask data from OptContext
Date: Tue, 10 Dec 2024 09:23:15 -0600
Message-ID: <20241210152401.1823648-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::236;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x236.google.com
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

The desire is to start re-using some of the fold_* functions
while lowering or simplifying operations during tcg_optmize.

Many of these fold_* functions set z_mask, s_mask, and a_mask,
which hang around until the end of the tcg_optmize loop and
are applied by finish_folding.  This disconnect between set
and apply is a problem -- we would no longer be applying the
masks to the correct opcode.

Fix this by making the masks local variables, passed down to
be applied immediately to the opcode being processed.


r~


Richard Henderson (46):
  tcg/optimize: Split out finish_bb, finish_ebb
  tcg/optimize: Copy mask writeback to fold_masks
  tcg/optimize: Add fold_masks_zsa, fold_masks_zs, fold_masks_z
  tcg/optimize: Use finish_folding in fold_add, fold_add_vec
  tcg/optimize: Use finish_folding in fold_addsub2
  tcg/optimize: Use fold_masks_zsa in fold_and
  tcg/optimize: Use fold_masks_zsa in fold_andc
  tcg/optimize: Use fold_masks_zs in fold_bswap
  tcg/optimize: Use fold_masks_z in fold_count_zeros
  tcg/optimize: Use fold_masks_z in fold_ctpop
  tcg/optimize: Use fold_and and fold_masks_z in fold_deposit
  tcg/optimize: Use finish_folding in fold_divide
  tcg/optimize: Use finish_folding in fold_dup, fold_dup2
  tcg/optimize: Use fold_masks_zs in fold_eqv
  tcg/optimize: Use fold_masks_zsa in fold_extract
  tcg/optimize: Use finish_folding in fold_extract2
  tcg/optimize: Use fold_masks_zsa in fold_exts
  tcg/optimize: Use fold_masks_zsa in fold_extu
  tcg/optimize: Use fold_masks_zs in fold_movcond
  tcg/optimize: Use finish_folding in fold_mul*
  tcg/optimize: Use fold_masks_zs in fold_nand
  tcg/optimize: Use fold_masks_z in fold_neg_no_const
  tcg/optimize: Use fold_masks_zs in fold_nor
  tcg/optimize: Use fold_masks_zs in fold_not
  tcg/optimize: Use fold_masks_zs in fold_or
  tcg/optimize: Use fold_masks_zs in fold_orc
  tcg/optimize: Use fold_masks_zs in fold_qemu_ld
  tcg/optimize: Return true from fold_qemu_st, fold_tcg_st
  tcg/optimize: Use finish_folding in fold_remainder
  tcg/optimize: Distinguish simplification in fold_setcond_zmask
  tcg/optimize: Use fold_masks_z in fold_setcond
  tcg/optimize: Use fold_masks_zs in fold_negsetcond
  tcg/optimize: Use fold_masks_z in fold_setcond2
  tcg/optimize: Use finish_folding in fold_cmp_vec
  tcg/optimize: Use finish_folding in fold_cmpsel_vec
  tcg/optimize: Use fold_masks_zsa in fold_sextract
  tcg/optimize: Use fold_masks_zs in fold_shift
  tcg/optimize: Use finish_folding in fold_sub, fold_sub_vec
  tcg/optimize: Use fold_masks_zs in fold_tcg_ld
  tcg/optimize: Use finish_folding in fold_tcg_ld_memcopy
  tcg/optimize: Use fold_masks_zs in fold_xor
  tcg/optimize: Use finish_folding in fold_bitsel_vec
  tcg/optimize: Use finish_folding as default in tcg_optimize
  tcg/optimize: Remove [zsa]_mask from OptContext
  tcg/optimize: Move fold_bitsel_vec into alphabetic sort
  tcg/optimize: Move fold_cmp_vec, fold_cmpsel_vec into alphabetic sort

 tcg/optimize.c | 597 ++++++++++++++++++++++++++-----------------------
 1 file changed, 315 insertions(+), 282 deletions(-)

-- 
2.43.0


