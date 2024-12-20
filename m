Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45C86E77188
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 04:19:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOUM5-0008LM-Hj; Thu, 19 Dec 2024 23:11:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tOUM2-0008Ji-Uf
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 23:11:11 -0500
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tOUM0-0006Fw-4Z
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 23:11:10 -0500
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-2ee397a82f6so1397958a91.2
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 20:11:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734667867; x=1735272667; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=7T6q101ST/GzSlfq3xqwhdERPg88KHcGu7l3IJfyC/4=;
 b=BE8DKlTh/5DdxDY18c35MigqPr2PTnFXIAtpNDje17mtRaHaO2RBrbdHb8/pP7OgDk
 IFTUnpLEo8qdggB0v+R7u/5kZTb88aVCIOUiebzkUz3EtScMcHYVBeqeh+XSi7DZK8kT
 8YACBAF871HnRP+Uko4qAuv+TYNE4w1sH0D3LOQ0du436lS+HLpC9Iu33DLXnkfDftKX
 Ll8ujOLroxO9Jz7OwE13D/+/6DH3oTMXTnMVfJ0mUFJahh6PAyBll23UdZPfRYkIoKhv
 rf3YGIe2rb3gMYFqtCgOEph1LZ12U9KrRPxGVKiS/fAqpalyynTvfC9YeC6uxmpHafVN
 dBwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734667867; x=1735272667;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7T6q101ST/GzSlfq3xqwhdERPg88KHcGu7l3IJfyC/4=;
 b=F9uE6wy0aUVFcq9Lxfs2I7UUzJpvk0SrHU9Qtu8fK0FZ9+e3S5JTBxuxT5IonXyU7L
 IwsmbN8OVCWqh/H273JggjLMUpIVLDN1lv1jnXZY+MnNH1GD++UHnRpzDVWmZYCEpbFQ
 80WkM+2VqFA3Sg3kOe70/7JXXW6Vhpa2ngTXJxxxLaRKeUsz7dCbrKUdJDgRJ07WXE8/
 L/I1uPPtoNIB2NGzEi94IXAEKAhFB/vVTJ6/poL/fxqAVyrpX7n4a4XHr/nIUisVYtb1
 PH2EXmGthNJmpgQ7i6ka24zfA/AF3oZf2uLYAheyalffrhXivI0S0EtuUPSy+Hs6YQJM
 UfoQ==
X-Gm-Message-State: AOJu0YyskM8mB4BZqe2pTrTpbesNplywkzrzNtwdtPW7/x7EJoHZM9cg
 jW9vBD7GvwgRzGkkVt4TdfanZHZo9BHAgesWzxl1arBlhKrVjC5mAP6RbnDAp5qGW2V6ZDKaVqu
 g
X-Gm-Gg: ASbGncsv6JkIESSqJjlQ3M6gycMUrMXmmDkE96vLZk+o4hIVotLQrIvLmZvt8+NAiza
 TbjjNNljeYbJsOC6qaobgfLOUxMqbLUemFz1H3qrjytgaQCq1kXlq5wJdewis7DKNgsPdccsjRr
 EYx2XMJFyFDO9WU9R+FPY+tltkj07JKBEWJJ0VsKfNMEM7v2vSiWopzFKGg3TAtPaaNBULsKU09
 e0fmv7KZNVnWg43ojZwFp/wl8cOvkZorSl4TbXrfAGSRTEHZX6aOYLmPRDkksc=
X-Google-Smtp-Source: AGHT+IHjHAC2umfW6p5+dcr1ck0yzm30TlqaznBGrJG83bxcsdgwPgfFSG2kTTIP+N28gRIOjHKc5A==
X-Received: by 2002:a17:90b:1f8a:b0:2ee:ad18:b309 with SMTP id
 98e67ed59e1d1-2f452def24cmr2107091a91.3.1734667865486; 
 Thu, 19 Dec 2024 20:11:05 -0800 (PST)
Received: from stoup.. ([71.212.144.252]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f2ee26fc22sm4165260a91.51.2024.12.19.20.11.04
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 20:11:05 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 00/51] tcg: Remove in-flight mask data from OptContext
Date: Thu, 19 Dec 2024 20:10:12 -0800
Message-ID: <20241220041104.53105-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102b.google.com
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

Changes for v2:
  - Introduce fold_affected_mask, to handle a_mask separately from both
    z_mask and s_mask.  There are only a couple of places where we can
    compute a_mask, and handling that separately simplifies some things.
    This means that fold_masks_zsa is gone, and fold_masks_za need not
    be created.

  - Introduce fold_masks_s, as suggested in review.

  - In many places, fetch the TempOptInfo pointers once.  This doesn't
    affect the resulting optimized code, but it's easier to read.

  - There are a couple of logic fixes, separated out to new patches.
  - There are a couple of logic improvements for fold_count_zero
    and fold_deposit.

Patches lacking review:
  02-tcg-optimize-Split-out-fold_affected_mask.patch
  04-tcg-optimize-Split-out-fold_masks_zs.patch
  05-tcg-optimize-Augment-s_mask-from-z_mask-in-fold_m.patch
  10-tcg-optimize-Use-fold_masks_zs-in-fold_count_zero.patch
  13-tcg-optimize-Compute-sign-mask-in-fold_deposit.patch
  29-tcg-optimize-Use-fold_masks_zs-in-fold_qemu_ld.patch
  35-tcg-optimize-Fix-sign-mask-in-fold_negsetcond.patch
  40-tcg-optimize-Canonicalize-s_mask-in-fold_exts-fol.patch
  42-tcg-optimize-Simplify-sign-bit-test-in-fold_shift.patch


r~


Richard Henderson (51):
  tcg/optimize: Split out finish_bb, finish_ebb
  tcg/optimize: Split out fold_affected_mask
  tcg/optimize: Copy mask writeback to fold_masks
  tcg/optimize: Split out fold_masks_zs
  tcg/optimize: Augment s_mask from z_mask in fold_masks_zs
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
  tcg/optimize: Fix sign mask in fold_negsetcond
  tcg/optimize: Use fold_masks_z in fold_setcond2
  tcg/optimize: Use finish_folding in fold_cmp_vec
  tcg/optimize: Use finish_folding in fold_cmpsel_vec
  tcg/optimize: Use fold_masks_zs in fold_sextract
  tcg/optimize: Canonicalize s_mask in fold_exts, fold_sextract
  tcg/optimize: Use fold_masks_zs, fold_masks_s in fold_shift
  tcg/optimize: Simplify sign bit test in fold_shift
  tcg/optimize: Use finish_folding in fold_sub, fold_sub_vec
  tcg/optimize: Use fold_masks_zs in fold_tcg_ld
  tcg/optimize: Use finish_folding in fold_tcg_ld_memcopy
  tcg/optimize: Use fold_masks_zs in fold_xor
  tcg/optimize: Use finish_folding in fold_bitsel_vec
  tcg/optimize: Use finish_folding as default in tcg_optimize
  tcg/optimize: Remove z_mask, s_mask from OptContext
  tcg/optimize: Move fold_bitsel_vec into alphabetic sort
  tcg/optimize: Move fold_cmp_vec, fold_cmpsel_vec into alphabetic sort

 tcg/optimize.c | 776 +++++++++++++++++++++++++++----------------------
 1 file changed, 425 insertions(+), 351 deletions(-)

-- 
2.43.0


