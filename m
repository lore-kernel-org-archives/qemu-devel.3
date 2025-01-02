Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FF7BE77188
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2025 18:21:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTPf2-0000hk-HF; Thu, 02 Jan 2025 13:11:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tTPeb-0007NV-1m
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 13:10:44 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tTPeX-0006EQ-0G
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 13:10:39 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-216401de828so149120605ad.3
 for <qemu-devel@nongnu.org>; Thu, 02 Jan 2025 10:10:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735841436; x=1736446236; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Rb3gdXHzYjItOtUmdK83E8vc0BbdxY1i092TEm+PVdE=;
 b=O1edxxrzLprIyX9/iYVwp336OTxtOeJWPJJOkznNd0NXKfOlJobWlGJEVa67XgyfOn
 wjeBguW4/+k83Hei90t/y/1GzCFNWJcT3D/1LJsGTFoIYYs4iepM9WufKhUwsmut9pcJ
 xD6HbHHG4+d7DUo5sWlavWnl8D25pZPUkep78I/+bxR0c0qv632qdVBWOS68r+V1ZCNY
 KpvlEOlOmNAJaPZtdWFEaj2XeBNSCPSDJUHVT/h2jJKwDTjES2wyasB5IJ0EsnlBKyuI
 +tiFIr38kNunuvC80+dITlvnuvXI7AuTw1mDOD0VPQLKT2fRH3JnrWMDuOLvunhICzCG
 qHNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735841436; x=1736446236;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Rb3gdXHzYjItOtUmdK83E8vc0BbdxY1i092TEm+PVdE=;
 b=Dfi3lbmOEn45q+0FC3Vt1H5rN4sT+WOC3ldhDw7Q4WkDPiljWiu42ZFtOaE4TjwJRq
 SFWZ9ikS3Zx5zrD+VoM4hQV5svEcLzGZ2Ov00X2SU6pxtoWL0FlrkOteeMuk8fji1OVN
 ITTSX+phWirKVo6eVMyeCJFuRx1I9SzWlwS5+15CifLPhElkGBhw0We/Vs9Abx3IjM8m
 uVpi81pQ6y8mOxyKl7yyHbt1nzxyZXmaMibMvaYlwHZvnTu12Riq2jPx+SCUR+aAgYcZ
 OH2PiNhCV/nMQPjAePTK8cz96OMsTMYtqAsM5b1WtdJiAfd5hiW+T/puHzCZjN5/6bok
 6DEg==
X-Gm-Message-State: AOJu0YyJYrKKZKayM5OmzoCu6WqrdQjUy1nxzHBTC62s0lGsrP3kYrCZ
 L/CrDP6JFLdZM4Z5lj5nEWahTWA5Ec9yOj72THY2h/5WvFQafLn0Ec15k7lqFpUsVbBQBOJKyjz
 6
X-Gm-Gg: ASbGncvyDe9gaTmGY8+qVIaXIELbJhoFIzIOHEtqsB1VAube7C0YWP0LkK8T3yy0LmQ
 OqlCBnor1U3squ7h/aXrdb3uLCPmC3CDD54c/flQEUL6MYO943TY2zrqRfzYYFzLPZUJ7u42q+/
 2tziZLEtJYqJE80wkaqH8eArz/GdfaytV3DQtxwz7bH5tv7MABtg+UUD8ktYvMstHa84WvS6PAq
 oJtPpwkpOnaAaltbKDL1o1m79DcA8BjMOCUsS1ztfb5VW/fpDSh42Ae4qKQcA==
X-Google-Smtp-Source: AGHT+IHNC4wF+WNha125YXXOYkg2yUWZgc2ABzgiKZnIEdphQ8pufvWMDjTQuLhynHWMzHgXMPyOfw==
X-Received: by 2002:a05:6a00:a84:b0:725:e957:1dd1 with SMTP id
 d2e1a72fcca58-72abde84685mr71271453b3a.17.1735841435515; 
 Thu, 02 Jan 2025 10:10:35 -0800 (PST)
Received: from stoup.. ([63.239.63.212]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad8dbaf1sm24620827b3a.112.2025.01.02.10.10.34
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jan 2025 10:10:35 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 52/73] tcg: Use tcg_op_supported in process_op_defs
Date: Thu,  2 Jan 2025 10:06:32 -0800
Message-ID: <20250102180654.1420056-53-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250102180654.1420056-1-richard.henderson@linaro.org>
References: <20250102180654.1420056-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

Use the functional interface to query whether the opcode is supported,
and skip argument constraint assignment.  This means that we can drop
the TCG_OPF_NOT_PRESENT bit mapping from TCG_TARGET_HAS_foo in tcg-opc.h.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-opc.h            | 301 +++++++++++++++----------------
 tcg/tcg-common.c                 |   1 -
 tcg/tcg.c                        |  20 +-
 tcg/aarch64/tcg-target-opc.h.inc |   4 +-
 tcg/arm/tcg-target-opc.h.inc     |   6 +-
 tcg/i386/tcg-target-opc.h.inc    |  22 +--
 tcg/ppc/tcg-target-opc.h.inc     |  12 +-
 tcg/s390x/tcg-target-opc.h.inc   |   6 +-
 8 files changed, 177 insertions(+), 195 deletions(-)

diff --git a/include/tcg/tcg-opc.h b/include/tcg/tcg-opc.h
index c0b78aab98..eb64012b62 100644
--- a/include/tcg/tcg-opc.h
+++ b/include/tcg/tcg-opc.h
@@ -33,20 +33,13 @@ DEF(set_label, 0, 0, 1, TCG_OPF_BB_END | TCG_OPF_NOT_PRESENT)
 /* variable number of parameters */
 DEF(call, 0, 0, 3, TCG_OPF_CALL_CLOBBER | TCG_OPF_NOT_PRESENT)
 
-DEF(br, 0, 0, 1, TCG_OPF_BB_END)
+DEF(br, 0, 0, 1, TCG_OPF_BB_END | TCG_OPF_NOT_PRESENT)
 
-#define IMPL(X) (__builtin_constant_p(X) && (X) <= 0 ? TCG_OPF_NOT_PRESENT : 0)
-#if TCG_TARGET_REG_BITS == 32
-# define IMPL64  TCG_OPF_64BIT | TCG_OPF_NOT_PRESENT
-#else
-# define IMPL64  TCG_OPF_64BIT
-#endif
-
-DEF(mb, 0, 0, 1, 0)
+DEF(mb, 0, 0, 1, TCG_OPF_NOT_PRESENT)
 
 DEF(mov_i32, 1, 1, 0, TCG_OPF_NOT_PRESENT)
 DEF(setcond_i32, 1, 2, 1, 0)
-DEF(negsetcond_i32, 1, 2, 1, IMPL(TCG_TARGET_HAS_negsetcond(TCG_TYPE_I32)))
+DEF(negsetcond_i32, 1, 2, 1, 0)
 DEF(movcond_i32, 1, 4, 1, 0)
 /* load/store */
 DEF(ld8u_i32, 1, 1, 1, 0)
@@ -61,12 +54,12 @@ DEF(st_i32, 0, 2, 1, 0)
 DEF(add_i32, 1, 2, 0, 0)
 DEF(sub_i32, 1, 2, 0, 0)
 DEF(mul_i32, 1, 2, 0, 0)
-DEF(div_i32, 1, 2, 0, IMPL(TCG_TARGET_HAS_div(TCG_TYPE_I32)))
-DEF(divu_i32, 1, 2, 0, IMPL(TCG_TARGET_HAS_div(TCG_TYPE_I32)))
-DEF(rem_i32, 1, 2, 0, IMPL(TCG_TARGET_HAS_rem(TCG_TYPE_I32)))
-DEF(remu_i32, 1, 2, 0, IMPL(TCG_TARGET_HAS_rem(TCG_TYPE_I32)))
-DEF(div2_i32, 2, 3, 0, IMPL(TCG_TARGET_HAS_div2(TCG_TYPE_I32)))
-DEF(divu2_i32, 2, 3, 0, IMPL(TCG_TARGET_HAS_div2(TCG_TYPE_I32)))
+DEF(div_i32, 1, 2, 0, 0)
+DEF(divu_i32, 1, 2, 0, 0)
+DEF(rem_i32, 1, 2, 0, 0)
+DEF(remu_i32, 1, 2, 0, 0)
+DEF(div2_i32, 2, 3, 0, 0)
+DEF(divu2_i32, 2, 3, 0, 0)
 DEF(and_i32, 1, 2, 0, 0)
 DEF(or_i32, 1, 2, 0, 0)
 DEF(xor_i32, 1, 2, 0, 0)
@@ -74,113 +67,112 @@ DEF(xor_i32, 1, 2, 0, 0)
 DEF(shl_i32, 1, 2, 0, 0)
 DEF(shr_i32, 1, 2, 0, 0)
 DEF(sar_i32, 1, 2, 0, 0)
-DEF(rotl_i32, 1, 2, 0, IMPL(TCG_TARGET_HAS_rot(TCG_TYPE_I32)))
-DEF(rotr_i32, 1, 2, 0, IMPL(TCG_TARGET_HAS_rot(TCG_TYPE_I32)))
+DEF(rotl_i32, 1, 2, 0, 0)
+DEF(rotr_i32, 1, 2, 0, 0)
 DEF(deposit_i32, 1, 2, 2, 0)
 DEF(extract_i32, 1, 1, 2, 0)
 DEF(sextract_i32, 1, 1, 2, 0)
-DEF(extract2_i32, 1, 2, 1, IMPL(TCG_TARGET_HAS_extract2(TCG_TYPE_I32)))
+DEF(extract2_i32, 1, 2, 1, 0)
 
 DEF(brcond_i32, 0, 2, 2, TCG_OPF_BB_END | TCG_OPF_COND_BRANCH)
 
-DEF(add2_i32, 2, 4, 0, IMPL(TCG_TARGET_HAS_add2(TCG_TYPE_I32)))
-DEF(sub2_i32, 2, 4, 0, IMPL(TCG_TARGET_HAS_sub2(TCG_TYPE_I32)))
-DEF(mulu2_i32, 2, 2, 0, IMPL(TCG_TARGET_HAS_mulu2(TCG_TYPE_I32)))
-DEF(muls2_i32, 2, 2, 0, IMPL(TCG_TARGET_HAS_muls2(TCG_TYPE_I32)))
-DEF(muluh_i32, 1, 2, 0, IMPL(TCG_TARGET_HAS_muluh(TCG_TYPE_I32)))
-DEF(mulsh_i32, 1, 2, 0, IMPL(TCG_TARGET_HAS_mulsh(TCG_TYPE_I32)))
-DEF(brcond2_i32, 0, 4, 2,
-    TCG_OPF_BB_END | TCG_OPF_COND_BRANCH | IMPL(TCG_TARGET_REG_BITS == 32))
-DEF(setcond2_i32, 1, 4, 1, IMPL(TCG_TARGET_REG_BITS == 32))
+DEF(add2_i32, 2, 4, 0, 0)
+DEF(sub2_i32, 2, 4, 0, 0)
+DEF(mulu2_i32, 2, 2, 0, 0)
+DEF(muls2_i32, 2, 2, 0, 0)
+DEF(muluh_i32, 1, 2, 0, 0)
+DEF(mulsh_i32, 1, 2, 0, 0)
+DEF(brcond2_i32, 0, 4, 2, TCG_OPF_BB_END | TCG_OPF_COND_BRANCH)
+DEF(setcond2_i32, 1, 4, 1, 0)
 
-DEF(bswap16_i32, 1, 1, 1, IMPL(TCG_TARGET_HAS_bswap(TCG_TYPE_I32)))
-DEF(bswap32_i32, 1, 1, 1, IMPL(TCG_TARGET_HAS_bswap(TCG_TYPE_I32)))
-DEF(not_i32, 1, 1, 0, IMPL(TCG_TARGET_HAS_not(TCG_TYPE_I32)))
+DEF(bswap16_i32, 1, 1, 1, 0)
+DEF(bswap32_i32, 1, 1, 1, 0)
+DEF(not_i32, 1, 1, 0, 0)
 DEF(neg_i32, 1, 1, 0, 0)
-DEF(andc_i32, 1, 2, 0, IMPL(TCG_TARGET_HAS_andc(TCG_TYPE_I32)))
-DEF(orc_i32, 1, 2, 0, IMPL(TCG_TARGET_HAS_orc(TCG_TYPE_I32)))
-DEF(eqv_i32, 1, 2, 0, IMPL(TCG_TARGET_HAS_eqv(TCG_TYPE_I32)))
-DEF(nand_i32, 1, 2, 0, IMPL(TCG_TARGET_HAS_nand(TCG_TYPE_I32)))
-DEF(nor_i32, 1, 2, 0, IMPL(TCG_TARGET_HAS_nor(TCG_TYPE_I32)))
-DEF(clz_i32, 1, 2, 0, IMPL(TCG_TARGET_HAS_clz(TCG_TYPE_I32)))
-DEF(ctz_i32, 1, 2, 0, IMPL(TCG_TARGET_HAS_ctz(TCG_TYPE_I32)))
-DEF(ctpop_i32, 1, 1, 0, IMPL(TCG_TARGET_HAS_ctpop(TCG_TYPE_I32)))
+DEF(andc_i32, 1, 2, 0, 0)
+DEF(orc_i32, 1, 2, 0, 0)
+DEF(eqv_i32, 1, 2, 0, 0)
+DEF(nand_i32, 1, 2, 0, 0)
+DEF(nor_i32, 1, 2, 0, 0)
+DEF(clz_i32, 1, 2, 0, 0)
+DEF(ctz_i32, 1, 2, 0, 0)
+DEF(ctpop_i32, 1, 1, 0, 0)
 
 DEF(mov_i64, 1, 1, 0, TCG_OPF_64BIT | TCG_OPF_NOT_PRESENT)
-DEF(setcond_i64, 1, 2, 1, IMPL64)
-DEF(negsetcond_i64, 1, 2, 1, IMPL64 | IMPL(TCG_TARGET_HAS_negsetcond(TCG_TYPE_I64)))
-DEF(movcond_i64, 1, 4, 1, IMPL64)
+DEF(setcond_i64, 1, 2, 1, TCG_OPF_64BIT)
+DEF(negsetcond_i64, 1, 2, 1, TCG_OPF_64BIT)
+DEF(movcond_i64, 1, 4, 1, TCG_OPF_64BIT)
 /* load/store */
-DEF(ld8u_i64, 1, 1, 1, IMPL64)
-DEF(ld8s_i64, 1, 1, 1, IMPL64)
-DEF(ld16u_i64, 1, 1, 1, IMPL64)
-DEF(ld16s_i64, 1, 1, 1, IMPL64)
-DEF(ld32u_i64, 1, 1, 1, IMPL64)
-DEF(ld32s_i64, 1, 1, 1, IMPL64)
-DEF(ld_i64, 1, 1, 1, IMPL64)
-DEF(st8_i64, 0, 2, 1, IMPL64)
-DEF(st16_i64, 0, 2, 1, IMPL64)
-DEF(st32_i64, 0, 2, 1, IMPL64)
-DEF(st_i64, 0, 2, 1, IMPL64)
+DEF(ld8u_i64, 1, 1, 1, TCG_OPF_64BIT)
+DEF(ld8s_i64, 1, 1, 1, TCG_OPF_64BIT)
+DEF(ld16u_i64, 1, 1, 1, TCG_OPF_64BIT)
+DEF(ld16s_i64, 1, 1, 1, TCG_OPF_64BIT)
+DEF(ld32u_i64, 1, 1, 1, TCG_OPF_64BIT)
+DEF(ld32s_i64, 1, 1, 1, TCG_OPF_64BIT)
+DEF(ld_i64, 1, 1, 1, TCG_OPF_64BIT)
+DEF(st8_i64, 0, 2, 1, TCG_OPF_64BIT)
+DEF(st16_i64, 0, 2, 1, TCG_OPF_64BIT)
+DEF(st32_i64, 0, 2, 1, TCG_OPF_64BIT)
+DEF(st_i64, 0, 2, 1, TCG_OPF_64BIT)
 /* arith */
-DEF(add_i64, 1, 2, 0, IMPL64)
-DEF(sub_i64, 1, 2, 0, IMPL64)
-DEF(mul_i64, 1, 2, 0, IMPL64)
-DEF(div_i64, 1, 2, 0, IMPL64 | IMPL(TCG_TARGET_HAS_div(TCG_TYPE_I64)))
-DEF(divu_i64, 1, 2, 0, IMPL64 | IMPL(TCG_TARGET_HAS_div(TCG_TYPE_I64)))
-DEF(rem_i64, 1, 2, 0, IMPL64 | IMPL(TCG_TARGET_HAS_rem(TCG_TYPE_I64)))
-DEF(remu_i64, 1, 2, 0, IMPL64 | IMPL(TCG_TARGET_HAS_rem(TCG_TYPE_I64)))
-DEF(div2_i64, 2, 3, 0, IMPL64 | IMPL(TCG_TARGET_HAS_div2(TCG_TYPE_I64)))
-DEF(divu2_i64, 2, 3, 0, IMPL64 | IMPL(TCG_TARGET_HAS_div2(TCG_TYPE_I64)))
-DEF(and_i64, 1, 2, 0, IMPL64)
-DEF(or_i64, 1, 2, 0, IMPL64)
-DEF(xor_i64, 1, 2, 0, IMPL64)
+DEF(add_i64, 1, 2, 0, TCG_OPF_64BIT)
+DEF(sub_i64, 1, 2, 0, TCG_OPF_64BIT)
+DEF(mul_i64, 1, 2, 0, TCG_OPF_64BIT)
+DEF(div_i64, 1, 2, 0, TCG_OPF_64BIT)
+DEF(divu_i64, 1, 2, 0, TCG_OPF_64BIT)
+DEF(rem_i64, 1, 2, 0, TCG_OPF_64BIT)
+DEF(remu_i64, 1, 2, 0, TCG_OPF_64BIT)
+DEF(div2_i64, 2, 3, 0, TCG_OPF_64BIT)
+DEF(divu2_i64, 2, 3, 0, TCG_OPF_64BIT)
+DEF(and_i64, 1, 2, 0, TCG_OPF_64BIT)
+DEF(or_i64, 1, 2, 0, TCG_OPF_64BIT)
+DEF(xor_i64, 1, 2, 0, TCG_OPF_64BIT)
 /* shifts/rotates */
-DEF(shl_i64, 1, 2, 0, IMPL64)
-DEF(shr_i64, 1, 2, 0, IMPL64)
-DEF(sar_i64, 1, 2, 0, IMPL64)
-DEF(rotl_i64, 1, 2, 0, IMPL64 | IMPL(TCG_TARGET_HAS_rot(TCG_TYPE_I64)))
-DEF(rotr_i64, 1, 2, 0, IMPL64 | IMPL(TCG_TARGET_HAS_rot(TCG_TYPE_I64)))
-DEF(deposit_i64, 1, 2, 2, IMPL64)
-DEF(extract_i64, 1, 1, 2, IMPL64)
-DEF(sextract_i64, 1, 1, 2, IMPL64)
-DEF(extract2_i64, 1, 2, 1, IMPL64 | IMPL(TCG_TARGET_HAS_extract2(TCG_TYPE_I64)))
+DEF(shl_i64, 1, 2, 0, TCG_OPF_64BIT)
+DEF(shr_i64, 1, 2, 0, TCG_OPF_64BIT)
+DEF(sar_i64, 1, 2, 0, TCG_OPF_64BIT)
+DEF(rotl_i64, 1, 2, 0, TCG_OPF_64BIT)
+DEF(rotr_i64, 1, 2, 0, TCG_OPF_64BIT)
+DEF(deposit_i64, 1, 2, 2, TCG_OPF_64BIT)
+DEF(extract_i64, 1, 1, 2, TCG_OPF_64BIT)
+DEF(sextract_i64, 1, 1, 2, TCG_OPF_64BIT)
+DEF(extract2_i64, 1, 2, 1, TCG_OPF_64BIT)
 
 /* size changing ops */
-DEF(ext_i32_i64, 1, 1, 0, IMPL64)
-DEF(extu_i32_i64, 1, 1, 0, IMPL64)
-DEF(extrl_i64_i32, 1, 1, 0, TCG_TARGET_REG_BITS == 32 ? TCG_OPF_NOT_PRESENT : 0)
-DEF(extrh_i64_i32, 1, 1, 0, TCG_TARGET_REG_BITS == 32 ? TCG_OPF_NOT_PRESENT : 0)
+DEF(ext_i32_i64, 1, 1, 0, TCG_OPF_64BIT)
+DEF(extu_i32_i64, 1, 1, 0, TCG_OPF_64BIT)
+DEF(extrl_i64_i32, 1, 1, 0, 0)
+DEF(extrh_i64_i32, 1, 1, 0, 0)
 
-DEF(brcond_i64, 0, 2, 2, TCG_OPF_BB_END | TCG_OPF_COND_BRANCH | IMPL64)
-DEF(bswap16_i64, 1, 1, 1, IMPL64 | IMPL(TCG_TARGET_HAS_bswap(TCG_TYPE_I64)))
-DEF(bswap32_i64, 1, 1, 1, IMPL64 | IMPL(TCG_TARGET_HAS_bswap(TCG_TYPE_I64)))
-DEF(bswap64_i64, 1, 1, 1, IMPL64 | IMPL(TCG_TARGET_HAS_bswap(TCG_TYPE_I64)))
-DEF(not_i64, 1, 1, 0, IMPL64 | IMPL(TCG_TARGET_HAS_not(TCG_TYPE_I64)))
-DEF(neg_i64, 1, 1, 0, IMPL64)
-DEF(andc_i64, 1, 2, 0, IMPL64 | IMPL(TCG_TARGET_HAS_andc(TCG_TYPE_I64)))
-DEF(orc_i64, 1, 2, 0, IMPL64 | IMPL(TCG_TARGET_HAS_orc(TCG_TYPE_I64)))
-DEF(eqv_i64, 1, 2, 0, IMPL64 | IMPL(TCG_TARGET_HAS_eqv(TCG_TYPE_I64)))
-DEF(nand_i64, 1, 2, 0, IMPL64 | IMPL(TCG_TARGET_HAS_nand(TCG_TYPE_I64)))
-DEF(nor_i64, 1, 2, 0, IMPL64 | IMPL(TCG_TARGET_HAS_nor(TCG_TYPE_I64)))
-DEF(clz_i64, 1, 2, 0, IMPL64 | IMPL(TCG_TARGET_HAS_clz(TCG_TYPE_I64)))
-DEF(ctz_i64, 1, 2, 0, IMPL64 | IMPL(TCG_TARGET_HAS_ctz(TCG_TYPE_I64)))
-DEF(ctpop_i64, 1, 1, 0, IMPL64 | IMPL(TCG_TARGET_HAS_ctpop(TCG_TYPE_I64)))
+DEF(brcond_i64, 0, 2, 2, TCG_OPF_BB_END | TCG_OPF_COND_BRANCH | TCG_OPF_64BIT)
+DEF(bswap16_i64, 1, 1, 1, TCG_OPF_64BIT)
+DEF(bswap32_i64, 1, 1, 1, TCG_OPF_64BIT)
+DEF(bswap64_i64, 1, 1, 1, TCG_OPF_64BIT)
+DEF(not_i64, 1, 1, 0, TCG_OPF_64BIT)
+DEF(neg_i64, 1, 1, 0, TCG_OPF_64BIT)
+DEF(andc_i64, 1, 2, 0, TCG_OPF_64BIT)
+DEF(orc_i64, 1, 2, 0, TCG_OPF_64BIT)
+DEF(eqv_i64, 1, 2, 0, TCG_OPF_64BIT)
+DEF(nand_i64, 1, 2, 0, TCG_OPF_64BIT)
+DEF(nor_i64, 1, 2, 0, TCG_OPF_64BIT)
+DEF(clz_i64, 1, 2, 0, TCG_OPF_64BIT)
+DEF(ctz_i64, 1, 2, 0, TCG_OPF_64BIT)
+DEF(ctpop_i64, 1, 1, 0, TCG_OPF_64BIT)
 
-DEF(add2_i64, 2, 4, 0, IMPL64 | IMPL(TCG_TARGET_HAS_add2(TCG_TYPE_I64)))
-DEF(sub2_i64, 2, 4, 0, IMPL64 | IMPL(TCG_TARGET_HAS_sub2(TCG_TYPE_I64)))
-DEF(mulu2_i64, 2, 2, 0, IMPL64 | IMPL(TCG_TARGET_HAS_mulu2(TCG_TYPE_I64)))
-DEF(muls2_i64, 2, 2, 0, IMPL64 | IMPL(TCG_TARGET_HAS_muls2(TCG_TYPE_I64)))
-DEF(muluh_i64, 1, 2, 0, IMPL64 | IMPL(TCG_TARGET_HAS_muluh(TCG_TYPE_I64)))
-DEF(mulsh_i64, 1, 2, 0, IMPL64 | IMPL(TCG_TARGET_HAS_mulsh(TCG_TYPE_I64)))
+DEF(add2_i64, 2, 4, 0, TCG_OPF_64BIT)
+DEF(sub2_i64, 2, 4, 0, TCG_OPF_64BIT)
+DEF(mulu2_i64, 2, 2, 0, TCG_OPF_64BIT)
+DEF(muls2_i64, 2, 2, 0, TCG_OPF_64BIT)
+DEF(muluh_i64, 1, 2, 0, TCG_OPF_64BIT)
+DEF(mulsh_i64, 1, 2, 0, TCG_OPF_64BIT)
 
 #define DATA64_ARGS  (TCG_TARGET_REG_BITS == 64 ? 1 : 2)
 
 /* There are tcg_ctx->insn_start_words here, not just one. */
 DEF(insn_start, 0, 0, DATA64_ARGS, TCG_OPF_NOT_PRESENT)
 
-DEF(exit_tb, 0, 0, 1, TCG_OPF_BB_EXIT | TCG_OPF_BB_END)
-DEF(goto_tb, 0, 0, 1, TCG_OPF_BB_EXIT | TCG_OPF_BB_END)
+DEF(exit_tb, 0, 0, 1, TCG_OPF_BB_EXIT | TCG_OPF_BB_END | TCG_OPF_NOT_PRESENT)
+DEF(goto_tb, 0, 0, 1, TCG_OPF_BB_EXIT | TCG_OPF_BB_END | TCG_OPF_NOT_PRESENT)
 DEF(goto_ptr, 0, 1, 0, TCG_OPF_BB_EXIT | TCG_OPF_BB_END)
 
 DEF(plugin_cb, 0, 0, 1, TCG_OPF_NOT_PRESENT)
@@ -207,90 +199,79 @@ DEF(qemu_st_a64_i64, 0, DATA64_ARGS + DATA64_ARGS, 1,
 
 /* Only used by i386 to cope with stupid register constraints. */
 DEF(qemu_st8_a32_i32, 0, 1 + 1, 1,
-    TCG_OPF_CALL_CLOBBER | TCG_OPF_SIDE_EFFECTS |
-    IMPL(TCG_TARGET_HAS_qemu_st8_i32))
+    TCG_OPF_CALL_CLOBBER | TCG_OPF_SIDE_EFFECTS)
 DEF(qemu_st8_a64_i32, 0, 1 + DATA64_ARGS, 1,
-    TCG_OPF_CALL_CLOBBER | TCG_OPF_SIDE_EFFECTS |
-    IMPL(TCG_TARGET_HAS_qemu_st8_i32))
+    TCG_OPF_CALL_CLOBBER | TCG_OPF_SIDE_EFFECTS)
 
 /* Only for 64-bit hosts at the moment. */
 DEF(qemu_ld_a32_i128, 2, 1, 1,
-    TCG_OPF_CALL_CLOBBER | TCG_OPF_SIDE_EFFECTS | TCG_OPF_64BIT |
-    IMPL(TCG_TARGET_HAS_qemu_ldst_i128))
+    TCG_OPF_CALL_CLOBBER | TCG_OPF_SIDE_EFFECTS | TCG_OPF_64BIT)
 DEF(qemu_ld_a64_i128, 2, 1, 1,
-    TCG_OPF_CALL_CLOBBER | TCG_OPF_SIDE_EFFECTS | TCG_OPF_64BIT |
-    IMPL(TCG_TARGET_HAS_qemu_ldst_i128))
+    TCG_OPF_CALL_CLOBBER | TCG_OPF_SIDE_EFFECTS | TCG_OPF_64BIT)
 DEF(qemu_st_a32_i128, 0, 3, 1,
-    TCG_OPF_CALL_CLOBBER | TCG_OPF_SIDE_EFFECTS | TCG_OPF_64BIT |
-    IMPL(TCG_TARGET_HAS_qemu_ldst_i128))
+    TCG_OPF_CALL_CLOBBER | TCG_OPF_SIDE_EFFECTS | TCG_OPF_64BIT)
 DEF(qemu_st_a64_i128, 0, 3, 1,
-    TCG_OPF_CALL_CLOBBER | TCG_OPF_SIDE_EFFECTS | TCG_OPF_64BIT |
-    IMPL(TCG_TARGET_HAS_qemu_ldst_i128))
+    TCG_OPF_CALL_CLOBBER | TCG_OPF_SIDE_EFFECTS | TCG_OPF_64BIT)
 
 /* Host vector support.  */
 
-#define IMPLVEC  TCG_OPF_VECTOR | IMPL(TCG_TARGET_MAYBE_vec)
-
 DEF(mov_vec, 1, 1, 0, TCG_OPF_VECTOR | TCG_OPF_NOT_PRESENT)
 
-DEF(dup_vec, 1, 1, 0, IMPLVEC)
-DEF(dup2_vec, 1, 2, 0, IMPLVEC | IMPL(TCG_TARGET_REG_BITS == 32))
+DEF(dup_vec, 1, 1, 0, TCG_OPF_VECTOR)
+DEF(dup2_vec, 1, 2, 0, TCG_OPF_VECTOR)
 
-DEF(ld_vec, 1, 1, 1, IMPLVEC)
-DEF(st_vec, 0, 2, 1, IMPLVEC)
-DEF(dupm_vec, 1, 1, 1, IMPLVEC)
+DEF(ld_vec, 1, 1, 1, TCG_OPF_VECTOR)
+DEF(st_vec, 0, 2, 1, TCG_OPF_VECTOR)
+DEF(dupm_vec, 1, 1, 1, TCG_OPF_VECTOR)
 
-DEF(add_vec, 1, 2, 0, IMPLVEC)
-DEF(sub_vec, 1, 2, 0, IMPLVEC)
-DEF(mul_vec, 1, 2, 0, IMPLVEC | IMPL(TCG_TARGET_HAS_mul_vec))
-DEF(neg_vec, 1, 1, 0, IMPLVEC | IMPL(TCG_TARGET_HAS_neg_vec))
-DEF(abs_vec, 1, 1, 0, IMPLVEC | IMPL(TCG_TARGET_HAS_abs_vec))
-DEF(ssadd_vec, 1, 2, 0, IMPLVEC | IMPL(TCG_TARGET_HAS_sat_vec))
-DEF(usadd_vec, 1, 2, 0, IMPLVEC | IMPL(TCG_TARGET_HAS_sat_vec))
-DEF(sssub_vec, 1, 2, 0, IMPLVEC | IMPL(TCG_TARGET_HAS_sat_vec))
-DEF(ussub_vec, 1, 2, 0, IMPLVEC | IMPL(TCG_TARGET_HAS_sat_vec))
-DEF(smin_vec, 1, 2, 0, IMPLVEC | IMPL(TCG_TARGET_HAS_minmax_vec))
-DEF(umin_vec, 1, 2, 0, IMPLVEC | IMPL(TCG_TARGET_HAS_minmax_vec))
-DEF(smax_vec, 1, 2, 0, IMPLVEC | IMPL(TCG_TARGET_HAS_minmax_vec))
-DEF(umax_vec, 1, 2, 0, IMPLVEC | IMPL(TCG_TARGET_HAS_minmax_vec))
+DEF(add_vec, 1, 2, 0, TCG_OPF_VECTOR)
+DEF(sub_vec, 1, 2, 0, TCG_OPF_VECTOR)
+DEF(mul_vec, 1, 2, 0, TCG_OPF_VECTOR)
+DEF(neg_vec, 1, 1, 0, TCG_OPF_VECTOR)
+DEF(abs_vec, 1, 1, 0, TCG_OPF_VECTOR)
+DEF(ssadd_vec, 1, 2, 0, TCG_OPF_VECTOR)
+DEF(usadd_vec, 1, 2, 0, TCG_OPF_VECTOR)
+DEF(sssub_vec, 1, 2, 0, TCG_OPF_VECTOR)
+DEF(ussub_vec, 1, 2, 0, TCG_OPF_VECTOR)
+DEF(smin_vec, 1, 2, 0, TCG_OPF_VECTOR)
+DEF(umin_vec, 1, 2, 0, TCG_OPF_VECTOR)
+DEF(smax_vec, 1, 2, 0, TCG_OPF_VECTOR)
+DEF(umax_vec, 1, 2, 0, TCG_OPF_VECTOR)
 
-DEF(and_vec, 1, 2, 0, IMPLVEC)
-DEF(or_vec, 1, 2, 0, IMPLVEC)
-DEF(xor_vec, 1, 2, 0, IMPLVEC)
-DEF(andc_vec, 1, 2, 0, IMPLVEC | IMPL(TCG_TARGET_HAS_andc(TCG_TYPE_V64)))
-DEF(orc_vec, 1, 2, 0, IMPLVEC | IMPL(TCG_TARGET_HAS_orc(TCG_TYPE_V64)))
-DEF(nand_vec, 1, 2, 0, IMPLVEC | IMPL(TCG_TARGET_HAS_nand(TCG_TYPE_V64)))
-DEF(nor_vec, 1, 2, 0, IMPLVEC | IMPL(TCG_TARGET_HAS_nor(TCG_TYPE_V64)))
-DEF(eqv_vec, 1, 2, 0, IMPLVEC | IMPL(TCG_TARGET_HAS_eqv(TCG_TYPE_V64)))
-DEF(not_vec, 1, 1, 0, IMPLVEC | IMPL(TCG_TARGET_HAS_not(TCG_TYPE_V64)))
+DEF(and_vec, 1, 2, 0, TCG_OPF_VECTOR)
+DEF(or_vec, 1, 2, 0, TCG_OPF_VECTOR)
+DEF(xor_vec, 1, 2, 0, TCG_OPF_VECTOR)
+DEF(andc_vec, 1, 2, 0, TCG_OPF_VECTOR)
+DEF(orc_vec, 1, 2, 0, TCG_OPF_VECTOR)
+DEF(nand_vec, 1, 2, 0, TCG_OPF_VECTOR)
+DEF(nor_vec, 1, 2, 0, TCG_OPF_VECTOR)
+DEF(eqv_vec, 1, 2, 0, TCG_OPF_VECTOR)
+DEF(not_vec, 1, 1, 0, TCG_OPF_VECTOR)
 
-DEF(shli_vec, 1, 1, 1, IMPLVEC | IMPL(TCG_TARGET_HAS_shi_vec))
-DEF(shri_vec, 1, 1, 1, IMPLVEC | IMPL(TCG_TARGET_HAS_shi_vec))
-DEF(sari_vec, 1, 1, 1, IMPLVEC | IMPL(TCG_TARGET_HAS_shi_vec))
-DEF(rotli_vec, 1, 1, 1, IMPLVEC | IMPL(TCG_TARGET_HAS_roti_vec))
+DEF(shli_vec, 1, 1, 1, TCG_OPF_VECTOR)
+DEF(shri_vec, 1, 1, 1, TCG_OPF_VECTOR)
+DEF(sari_vec, 1, 1, 1, TCG_OPF_VECTOR)
+DEF(rotli_vec, 1, 1, 1, TCG_OPF_VECTOR)
 
-DEF(shls_vec, 1, 2, 0, IMPLVEC | IMPL(TCG_TARGET_HAS_shs_vec))
-DEF(shrs_vec, 1, 2, 0, IMPLVEC | IMPL(TCG_TARGET_HAS_shs_vec))
-DEF(sars_vec, 1, 2, 0, IMPLVEC | IMPL(TCG_TARGET_HAS_shs_vec))
-DEF(rotls_vec, 1, 2, 0, IMPLVEC | IMPL(TCG_TARGET_HAS_rots_vec))
+DEF(shls_vec, 1, 2, 0, TCG_OPF_VECTOR)
+DEF(shrs_vec, 1, 2, 0, TCG_OPF_VECTOR)
+DEF(sars_vec, 1, 2, 0, TCG_OPF_VECTOR)
+DEF(rotls_vec, 1, 2, 0, TCG_OPF_VECTOR)
 
-DEF(shlv_vec, 1, 2, 0, IMPLVEC | IMPL(TCG_TARGET_HAS_shv_vec))
-DEF(shrv_vec, 1, 2, 0, IMPLVEC | IMPL(TCG_TARGET_HAS_shv_vec))
-DEF(sarv_vec, 1, 2, 0, IMPLVEC | IMPL(TCG_TARGET_HAS_shv_vec))
-DEF(rotlv_vec, 1, 2, 0, IMPLVEC | IMPL(TCG_TARGET_HAS_rotv_vec))
-DEF(rotrv_vec, 1, 2, 0, IMPLVEC | IMPL(TCG_TARGET_HAS_rotv_vec))
+DEF(shlv_vec, 1, 2, 0, TCG_OPF_VECTOR)
+DEF(shrv_vec, 1, 2, 0, TCG_OPF_VECTOR)
+DEF(sarv_vec, 1, 2, 0, TCG_OPF_VECTOR)
+DEF(rotlv_vec, 1, 2, 0, TCG_OPF_VECTOR)
+DEF(rotrv_vec, 1, 2, 0, TCG_OPF_VECTOR)
 
-DEF(cmp_vec, 1, 2, 1, IMPLVEC)
+DEF(cmp_vec, 1, 2, 1, TCG_OPF_VECTOR)
 
-DEF(bitsel_vec, 1, 3, 0, IMPLVEC | IMPL(TCG_TARGET_HAS_bitsel_vec))
-DEF(cmpsel_vec, 1, 4, 1, IMPLVEC | IMPL(TCG_TARGET_HAS_cmpsel_vec))
+DEF(bitsel_vec, 1, 3, 0, TCG_OPF_VECTOR)
+DEF(cmpsel_vec, 1, 4, 1, TCG_OPF_VECTOR)
 
 DEF(last_generic, 0, 0, 0, TCG_OPF_NOT_PRESENT)
 
 #include "tcg-target-opc.h.inc"
 
 #undef DATA64_ARGS
-#undef IMPL
-#undef IMPL64
-#undef IMPLVEC
 #undef DEF
diff --git a/tcg/tcg-common.c b/tcg/tcg-common.c
index e98b3e5fdd..1ebcd9cb1c 100644
--- a/tcg/tcg-common.c
+++ b/tcg/tcg-common.c
@@ -24,7 +24,6 @@
 
 #include "qemu/osdep.h"
 #include "tcg/tcg.h"
-#include "tcg-has.h"
 
 const TCGOpDef tcg_op_defs[] = {
 #define DEF(s, oargs, iargs, cargs, flags) \
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 7871e349d4..7ba6c45824 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -3327,14 +3327,16 @@ static void process_op_defs(TCGContext *s)
         const TCGOpDef *def = &tcg_op_defs[op];
         const TCGConstraintSet *tdefs;
         unsigned con_set;
-        int nb_args;
+        TCGType type;
 
-        nb_args = def->nb_iargs + def->nb_oargs;
-        if (nb_args == 0) {
+        if (def->flags & TCG_OPF_NOT_PRESENT) {
             continue;
         }
 
-        if (def->flags & TCG_OPF_NOT_PRESENT) {
+        type = (def->flags & TCG_OPF_VECTOR ? TCG_TYPE_V64
+                : def->flags & TCG_OPF_64BIT ? TCG_TYPE_I64
+                : TCG_TYPE_I32);
+        if (!tcg_op_supported(op, type)) {
             continue;
         }
 
@@ -3355,17 +3357,17 @@ static void process_op_defs(TCGContext *s)
 
 static const TCGArgConstraint *opcode_args_ct(const TCGOp *op)
 {
-    const TCGOpDef *def = &tcg_op_defs[op->opc];
+    TCGOpcode opc = op->opc;
+    const TCGOpDef *def = &tcg_op_defs[opc];
     unsigned con_set;
 
-    if (def->nb_iargs + def->nb_oargs == 0) {
-        return NULL;
-    }
     if (def->flags & TCG_OPF_NOT_PRESENT) {
         return empty_cts;
     }
 
-    con_set = tcg_target_op_def(op->opc);
+    tcg_debug_assert(tcg_op_supported(opc, op->type));
+
+    con_set = tcg_target_op_def(opc);
     tcg_debug_assert(con_set < ARRAY_SIZE(constraint_sets));
     return all_args_cts[con_set];
 }
diff --git a/tcg/aarch64/tcg-target-opc.h.inc b/tcg/aarch64/tcg-target-opc.h.inc
index bce30accd9..5382315c41 100644
--- a/tcg/aarch64/tcg-target-opc.h.inc
+++ b/tcg/aarch64/tcg-target-opc.h.inc
@@ -11,5 +11,5 @@
  * consider these to be UNSPEC with names.
  */
 
-DEF(aa64_sshl_vec, 1, 2, 0, IMPLVEC)
-DEF(aa64_sli_vec, 1, 2, 1, IMPLVEC)
+DEF(aa64_sshl_vec, 1, 2, 0, TCG_OPF_VECTOR)
+DEF(aa64_sli_vec, 1, 2, 1, TCG_OPF_VECTOR)
diff --git a/tcg/arm/tcg-target-opc.h.inc b/tcg/arm/tcg-target-opc.h.inc
index d38af9a808..70394e0282 100644
--- a/tcg/arm/tcg-target-opc.h.inc
+++ b/tcg/arm/tcg-target-opc.h.inc
@@ -11,6 +11,6 @@
  * consider these to be UNSPEC with names.
  */
 
-DEF(arm_sli_vec, 1, 2, 1, IMPLVEC)
-DEF(arm_sshl_vec, 1, 2, 0, IMPLVEC)
-DEF(arm_ushl_vec, 1, 2, 0, IMPLVEC)
+DEF(arm_sli_vec, 1, 2, 1, TCG_OPF_VECTOR)
+DEF(arm_sshl_vec, 1, 2, 0, TCG_OPF_VECTOR)
+DEF(arm_ushl_vec, 1, 2, 0, TCG_OPF_VECTOR)
diff --git a/tcg/i386/tcg-target-opc.h.inc b/tcg/i386/tcg-target-opc.h.inc
index 4ffc084bda..8cc0dbaeaf 100644
--- a/tcg/i386/tcg-target-opc.h.inc
+++ b/tcg/i386/tcg-target-opc.h.inc
@@ -24,14 +24,14 @@
  * consider these to be UNSPEC with names.
  */
 
-DEF(x86_shufps_vec, 1, 2, 1, IMPLVEC)
-DEF(x86_blend_vec, 1, 2, 1, IMPLVEC)
-DEF(x86_packss_vec, 1, 2, 0, IMPLVEC)
-DEF(x86_packus_vec, 1, 2, 0, IMPLVEC)
-DEF(x86_psrldq_vec, 1, 1, 1, IMPLVEC)
-DEF(x86_vperm2i128_vec, 1, 2, 1, IMPLVEC)
-DEF(x86_punpckl_vec, 1, 2, 0, IMPLVEC)
-DEF(x86_punpckh_vec, 1, 2, 0, IMPLVEC)
-DEF(x86_vpshldi_vec, 1, 2, 1, IMPLVEC)
-DEF(x86_vpshldv_vec, 1, 3, 0, IMPLVEC)
-DEF(x86_vpshrdv_vec, 1, 3, 0, IMPLVEC)
+DEF(x86_shufps_vec, 1, 2, 1, TCG_OPF_VECTOR)
+DEF(x86_blend_vec, 1, 2, 1, TCG_OPF_VECTOR)
+DEF(x86_packss_vec, 1, 2, 0, TCG_OPF_VECTOR)
+DEF(x86_packus_vec, 1, 2, 0, TCG_OPF_VECTOR)
+DEF(x86_psrldq_vec, 1, 1, 1, TCG_OPF_VECTOR)
+DEF(x86_vperm2i128_vec, 1, 2, 1, TCG_OPF_VECTOR)
+DEF(x86_punpckl_vec, 1, 2, 0, TCG_OPF_VECTOR)
+DEF(x86_punpckh_vec, 1, 2, 0, TCG_OPF_VECTOR)
+DEF(x86_vpshldi_vec, 1, 2, 1, TCG_OPF_VECTOR)
+DEF(x86_vpshldv_vec, 1, 3, 0, TCG_OPF_VECTOR)
+DEF(x86_vpshrdv_vec, 1, 3, 0, TCG_OPF_VECTOR)
diff --git a/tcg/ppc/tcg-target-opc.h.inc b/tcg/ppc/tcg-target-opc.h.inc
index db514403c3..c3635831b5 100644
--- a/tcg/ppc/tcg-target-opc.h.inc
+++ b/tcg/ppc/tcg-target-opc.h.inc
@@ -24,9 +24,9 @@
  * consider these to be UNSPEC with names.
  */
 
-DEF(ppc_mrgh_vec, 1, 2, 0, IMPLVEC)
-DEF(ppc_mrgl_vec, 1, 2, 0, IMPLVEC)
-DEF(ppc_msum_vec, 1, 3, 0, IMPLVEC)
-DEF(ppc_muleu_vec, 1, 2, 0, IMPLVEC)
-DEF(ppc_mulou_vec, 1, 2, 0, IMPLVEC)
-DEF(ppc_pkum_vec, 1, 2, 0, IMPLVEC)
+DEF(ppc_mrgh_vec, 1, 2, 0, TCG_OPF_VECTOR)
+DEF(ppc_mrgl_vec, 1, 2, 0, TCG_OPF_VECTOR)
+DEF(ppc_msum_vec, 1, 3, 0, TCG_OPF_VECTOR)
+DEF(ppc_muleu_vec, 1, 2, 0, TCG_OPF_VECTOR)
+DEF(ppc_mulou_vec, 1, 2, 0, TCG_OPF_VECTOR)
+DEF(ppc_pkum_vec, 1, 2, 0, TCG_OPF_VECTOR)
diff --git a/tcg/s390x/tcg-target-opc.h.inc b/tcg/s390x/tcg-target-opc.h.inc
index 0eb2350fb3..61237b39cd 100644
--- a/tcg/s390x/tcg-target-opc.h.inc
+++ b/tcg/s390x/tcg-target-opc.h.inc
@@ -10,6 +10,6 @@
  * emitted by tcg_expand_vec_op.  For those familiar with GCC internals,
  * consider these to be UNSPEC with names.
  */
-DEF(s390_vuph_vec, 1, 1, 0, IMPLVEC)
-DEF(s390_vupl_vec, 1, 1, 0, IMPLVEC)
-DEF(s390_vpks_vec, 1, 2, 0, IMPLVEC)
+DEF(s390_vuph_vec, 1, 1, 0, TCG_OPF_VECTOR)
+DEF(s390_vupl_vec, 1, 1, 0, TCG_OPF_VECTOR)
+DEF(s390_vpks_vec, 1, 2, 0, TCG_OPF_VECTOR)
-- 
2.43.0


