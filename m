Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB137E7718E
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Dec 2024 16:25:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tPOlF-0002Yr-E6; Sun, 22 Dec 2024 11:24:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tPOlA-0002Y3-IZ
 for qemu-devel@nongnu.org; Sun, 22 Dec 2024 11:24:52 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tPOl7-0002wX-SJ
 for qemu-devel@nongnu.org; Sun, 22 Dec 2024 11:24:51 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-21649a7bcdcso31420245ad.1
 for <qemu-devel@nongnu.org>; Sun, 22 Dec 2024 08:24:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734884688; x=1735489488; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=iMHeSlbz0591ATzYmtVcUUaYYddFxbpBuy2TMLDdpkQ=;
 b=Q90erX/IxysZ44JIaTPMV+v19VtfXs5cYYlxwOL70KgEA4Zx3syMJ6nNuc5sQ4lKIG
 XCEKSO0CzGugr1ntkB8UMUWqScjpxgrMbnpxAQ7Whl3yGDFzt1yqy5O34k9Awo3L+Pw6
 VI52lxpWRhlQ+ru/kg1zkbZezUo8BmHZK+yxsM4lNNRRIWYL6Gsbt93byQvWd2ShTqLR
 2915QpwFQ6ANGC+ufMUW1+RjQPPlfJN2MSRIS3OUbRC8PN+thUqaMWvQVydCbZr2mN+o
 0LicyZfB05dSyQl8vuNJANoWVk7rEDWqIj+YMq1fuC9RlojFDjHxS+5GkjLvGSPQOKKf
 TEJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734884688; x=1735489488;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iMHeSlbz0591ATzYmtVcUUaYYddFxbpBuy2TMLDdpkQ=;
 b=wShmEIUZ72Yfp5Hw4RX+X33OBhziprXGV00fb9k+IEvOZ41H+tg5ODjkvYp3Iv1ZI6
 aDkzsdYE11Ih43RNqejzD5lxxFzN7GazvfCO4xLzPqTdBinDmqkvX3OfVz8awK3gp/Ys
 q/sAG8U/j6DhGtTCS+6gIe16asgE80YfkMtEhZ5ZWbQfNl/dB0e1nTOc/OIhB4ndYVAP
 JNZNVaO2ipp5kAIL/CTOV8AAanXkI5blsAl+wzQ1mcDiJ7mtAGzbYiwn1gGxMWvikKIj
 ebK6s/5J9gUumUmK3YhRTXLIE8vhz+FBgmOFy0QYLwKhGVsYToq7yT20CFuh4gGC17XP
 eMTQ==
X-Gm-Message-State: AOJu0YzTDjd6mY5TXw/VvjqnbLRNa78RqbZDM9GQ7/aZ16dfL94f8gBS
 KyJVZOJmU+v7rlR6sNAGIP7uaQypkG0ZYwTcOP00FSGq9n2CmrJU9hXWyIX7PQvByVh5SCAYm5o
 ULEQ=
X-Gm-Gg: ASbGncsNwzeXCqnEO4vaaheiMsPnGe8im2clg/sTUVAk8CFZ3sxy54d8sIol9WP/pYb
 +tVj1F+cHSa05mLrGei1q5czw+mvsbw/JPlgpt4h4RoZAiFmnjoxhR5KR4B/VtWDRoilx68/lf2
 DH1KuApuFnlm3hVWKa6xskXe+rp21CLVXJJdJh69Rpehdt6FOoNLQCg3dFvj7O3Kpx5A2113frA
 BAPY+zlgBip53+Y6IMxZ+uuc2Y/k9+t7drdbdnnN2ZitRSM/OiC4KsAM2141/k=
X-Google-Smtp-Source: AGHT+IGtS8X7bef8sTXBY/M3O0CIITHZVtIekCKrNggQQH2OiN78DjhoNfyqlcI+jqER1t4VHgaL4Q==
X-Received: by 2002:a17:902:ce83:b0:216:5b8b:9062 with SMTP id
 d9443c01a7336-219e70dd21cmr147192875ad.54.1734884687888; 
 Sun, 22 Dec 2024 08:24:47 -0800 (PST)
Received: from stoup.. ([71.212.144.252]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-219dc971814sm58461385ad.79.2024.12.22.08.24.47
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Dec 2024 08:24:47 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 00/51] tcg: Remove in-flight mask data from OptContext
Date: Sun, 22 Dec 2024 08:23:55 -0800
Message-ID: <20241222162446.2415717-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

Changes for v3:
  - Testing on non-x86 hosts with full-featured deposit ops showed
    some issues with some of the new computations of sign mask, which
    turn out to be a representational issue which leads to easy
    off-by-one errors.

    Change the representation of s_mask to include the sign itself
    not just repetitions.  Disable optimizations based on s_mask
    until the conversion is complete.

    Bitwise logical operations require no change.

    Extension, and sign-extending loads, now use INTn_MIN instead
    of MAKE_64BIT_MASK(n, 64 - n).

    The existing shift and the new deposit s_mask operations require
    no change, but that's only because they were buggy before.

Patches 6 and 49 are new.  Minor changes scattered in between.


r~


Richard Henderson (51):
  tcg/optimize: Split out finish_bb, finish_ebb
  tcg/optimize: Split out fold_affected_mask
  tcg/optimize: Copy mask writeback to fold_masks
  tcg/optimize: Split out fold_masks_zs
  tcg/optimize: Augment s_mask from z_mask in fold_masks_zs
  tcg/optimize: Change representation of s_mask
  tcg/optimize: Use finish_folding in fold_add, fold_add_vec,
    fold_addsub2
  tcg/optimize: Use fold_masks_zs in fold_and
  tcg/optimize: Use fold_masks_zs in fold_andc
  tcg/optimize: Use fold_masks_zs in fold_bswap
  tcg/optimize: Use fold_masks_zs in fold_count_zeros
  tcg/optimize: Use fold_masks_z in fold_ctpop
  tcg/optimize: Use fold_and and fold_masks_z in fold_deposit
  tcg/optimize: Compute sign mask in fold_deposit
  tcg/optimize: Use finish_folding in fold_divide
  tcg/optimize: Use finish_folding in fold_dup, fold_dup2
  tcg/optimize: Use fold_masks_s in fold_eqv
  tcg/optimize: Use fold_masks_z in fold_extract
  tcg/optimize: Use finish_folding in fold_extract2
  tcg/optimize: Use fold_masks_zs in fold_exts
  tcg/optimize: Use fold_masks_z in fold_extu
  tcg/optimize: Use fold_masks_zs in fold_movcond
  tcg/optimize: Use finish_folding in fold_mul*
  tcg/optimize: Use fold_masks_s in fold_nand
  tcg/optimize: Use fold_masks_z in fold_neg_no_const
  tcg/optimize: Use fold_masks_s in fold_nor
  tcg/optimize: Use fold_masks_s in fold_not
  tcg/optimize: Use fold_masks_zs in fold_or
  tcg/optimize: Use fold_masks_zs in fold_orc
  tcg/optimize: Use fold_masks_zs in fold_qemu_ld
  tcg/optimize: Return true from fold_qemu_st, fold_tcg_st
  tcg/optimize: Use finish_folding in fold_remainder
  tcg/optimize: Distinguish simplification in fold_setcond_zmask
  tcg/optimize: Use fold_masks_z in fold_setcond
  tcg/optimize: Use fold_masks_s in fold_negsetcond
  tcg/optimize: Use fold_masks_z in fold_setcond2
  tcg/optimize: Use finish_folding in fold_cmp_vec
  tcg/optimize: Use finish_folding in fold_cmpsel_vec
  tcg/optimize: Use fold_masks_zs in fold_sextract
  tcg/optimize: Use fold_masks_zs, fold_masks_s in fold_shift
  tcg/optimize: Simplify sign bit test in fold_shift
  tcg/optimize: Use finish_folding in fold_sub, fold_sub_vec
  tcg/optimize: Use fold_masks_zs in fold_tcg_ld
  tcg/optimize: Use finish_folding in fold_tcg_ld_memcopy
  tcg/optimize: Use fold_masks_zs in fold_xor
  tcg/optimize: Use finish_folding in fold_bitsel_vec
  tcg/optimize: Use finish_folding as default in tcg_optimize
  tcg/optimize: Remove z_mask, s_mask from OptContext
  tcg/optimize: Re-enable sign-mask optimizations
  tcg/optimize: Move fold_bitsel_vec into alphabetic sort
  tcg/optimize: Move fold_cmp_vec, fold_cmpsel_vec into alphabetic sort

 tcg/optimize.c | 834 +++++++++++++++++++++++++------------------------
 1 file changed, 432 insertions(+), 402 deletions(-)

-- 
2.43.0


