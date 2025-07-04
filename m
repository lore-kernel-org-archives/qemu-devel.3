Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DC0EC83F03
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 14:45:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXhRD-0006WJ-Dg; Fri, 04 Jul 2025 10:30:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXhLz-0004D6-PQ
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:25:31 -0400
Received: from mail-ot1-x329.google.com ([2607:f8b0:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXhLt-000813-Gd
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:25:25 -0400
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-73ac40e810eso292191a34.1
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 07:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751639119; x=1752243919; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dsYysXcZkima1baFMVzzoBbLhp7LXwciifgJtCyU2bM=;
 b=NnCcRML0OUrZ/4NC7ken683dwwknMB8LdTDD6jl5/FUwMa+ep16ZzjGIgzX2wasm/v
 wYcgzb75n/Q0LsTI6TljVzy0Cf8GrFie55tykzo6rb8/SSQuYAypzip1ZYbzFlRHPqQd
 CtXmGTmdmcFv5XvoIw7KUdc/xpuzU5kB37YMVJqzZEW9RUxF3pVagTqUxlTknKJEh/PK
 t6ANMqrJiLHHxvyYXhOdORrNLGwxzNq1jiRpbTEcdCFd/KDpfcERXjaCLVluUypttDlN
 a+A2LmjYZN7ZPKS01GkPqT79MmN60NxYd9Y4NObsj4vRPUMWyK0I6R8Ag/n+W4uY6T2O
 TqVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751639119; x=1752243919;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dsYysXcZkima1baFMVzzoBbLhp7LXwciifgJtCyU2bM=;
 b=HIs5qhElLPbXPOsQgSXRUZ37Tu9noVQi/yrjOYI3RY2aikoMAKeq5VTeQrXuHT5lNg
 AZLO6zO6Y66GuTfSt4k0j+ud2+TtYB4Bc38BbcFcneIWop0fbIXvQW8QAzCe+FvlXiIV
 NMrb7Y9yQgkrnHqcRrPXpNlawapLWGrg4Qo7jcWC9am/9OlWkj/NU9Kv4NYs2k7DvKca
 QOetZLj3rPcmXxL0nIa9i+LpPJUxHMDH9ijww7LxSACbAQBfrtpu2H2Gr6wpP6BS/heH
 uXLOMolQlM60v2DlNlG8/d3TuP2jYv6EAr11ByVys930sx1OE3ojjsTMBS3fgeE+QlAR
 0zig==
X-Gm-Message-State: AOJu0YzRl4Af8SKPgkV0xEO0AtGc6tsTMHOx0pmhEQQpwrvTGph2nvNu
 ahU5d6dLdsU1dLiTwdL4K8Lr6YWEsu9IyILea56rX1jodPhoZzB2ubU8OZ/ivqfXTiPRthOoZto
 Gc3F/JCs=
X-Gm-Gg: ASbGncvCnWj6e0zeREoHNsubbPv2EpI3SdkrNcrhU4tfEtxCe8YZO8QtOODB9dWCfJ7
 LFyKD4yYgkx9Sfb2l6u0krE6RsojwWrJcurxZad0zmFmnkIT0I801rfRGagI4jAdxbIzPD76CmC
 W5XwxGRVfd7j8had8sleQdbOylYtnaSaeh25chanqvB4JYwrh46Io65NX/XRuKfG4CRh7OnxLSe
 Po9KiR9bYBiZVg28sw+ozZyyKU49TGy8O+mr+KWnlaVuNsmbUfxUNVI911b3qxS1KYaOkbKTjjS
 ivaMmWIsIipL+OSmDfF/ec168BNAnr3yg1NNZF4M/0GzovVMkTyCijn0Rzu3dDjyNFkH+6aeTWB
 MMikWk+q2SFxRhZ1baenYztv41DN0Z11vFEW6/VkUHetTGkTX/qZQ5lC/Aqg=
X-Google-Smtp-Source: AGHT+IGLMzxa9gVTE9ERu0S/tPUUGSzPTgOY+hJVFIaWVJpS8oZM4gNWmXV0ywpqgGQUycVanpeLHA==
X-Received: by 2002:a05:6830:71a1:b0:727:36a0:a2ae with SMTP id
 46e09a7af769-73ca49ec32bmr1209047a34.14.1751639119127; 
 Fri, 04 Jul 2025 07:25:19 -0700 (PDT)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6138e5ac5eesm310233eaf.29.2025.07.04.07.25.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 07:25:18 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	peter.maydell@linaro.org
Subject: [PATCH v4 060/108] target/arm: Implement SQCVTN, UQCVTN,
 SQCVTUN for SME2/SVE2p1
Date: Fri,  4 Jul 2025 08:20:23 -0600
Message-ID: <20250704142112.1018902-61-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704142112.1018902-1-richard.henderson@linaro.org>
References: <20250704142112.1018902-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::329;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x329.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-sve.c |  7 +++++++
 target/arm/tcg/sve.decode      | 20 ++++++++++++++++----
 2 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 10261e25f9..ac4dc7db46 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -7427,3 +7427,10 @@ static void gen_uclamp(unsigned vece, uint32_t d, uint32_t n, uint32_t m,
 }
 
 TRANS_FEAT(UCLAMP, aa64_sme, gen_gvec_fn_arg_zzzz, gen_uclamp, a)
+
+TRANS_FEAT(SQCVTN_sh, aa64_sme2_or_sve2p1, gen_gvec_ool_zz,
+           gen_helper_sme2_sqcvtn_sh, a->rd, a->rn, 0)
+TRANS_FEAT(UQCVTN_sh, aa64_sme2_or_sve2p1, gen_gvec_ool_zz,
+           gen_helper_sme2_uqcvtn_sh, a->rd, a->rn, 0)
+TRANS_FEAT(SQCVTUN_sh, aa64_sme2_or_sve2p1, gen_gvec_ool_zz,
+           gen_helper_sme2_sqcvtun_sh, a->rd, a->rn, 0)
diff --git a/target/arm/tcg/sve.decode b/target/arm/tcg/sve.decode
index 83c259def6..f808362f23 100644
--- a/target/arm/tcg/sve.decode
+++ b/target/arm/tcg/sve.decode
@@ -57,6 +57,8 @@
 # as propagated via the MOVPRFX instruction.
 %reg_movprfx    0:5
 
+%rn_ax2         6:4 !function=times_2
+
 ###########################################################################
 # Named attribute sets.  These are used to make nice(er) names
 # when creating helpers common to those for the individual
@@ -102,6 +104,7 @@
 # Two operand
 @pd_pn          ........ esz:2 .. .... ....... rn:4 . rd:4      &rr_esz
 @rd_rn          ........ esz:2 ...... ...... rn:5 rd:5          &rr_esz
+@rd_rnx2        ........ ... ..... ...... ..... rd:5            &rr_esz rn=%rn_ax2
 
 # Two operand with governing predicate, flags setting
 @pd_pg_pn_s     ........ . s:1 ...... .. pg:4 . rn:4 . rd:4     &rpr_s
@@ -1507,13 +1510,22 @@ UABA            01000101 .. 0 ..... 11111 1 ..... .....  @rd_rn_rm
 #### SVE2 Narrowing
 
 ## SVE2 saturating extract narrow
-
 # Bits 23, 18-16 are zero, limited in the translator via esz < 3 & imm == 0.
-SQXTNB          01000101 .. 1 ..... 010 000 ..... .....  @rd_rn_tszimm_shl
+
+{
+  SQCVTN_sh     01000101 00 1 10001 010 000 ....0 .....  @rd_rnx2 esz=1
+  SQXTNB        01000101 .. 1 ..... 010 000 ..... .....  @rd_rn_tszimm_shl
+}
 SQXTNT          01000101 .. 1 ..... 010 001 ..... .....  @rd_rn_tszimm_shl
-UQXTNB          01000101 .. 1 ..... 010 010 ..... .....  @rd_rn_tszimm_shl
+{
+  UQCVTN_sh     01000101 00 1 10001 010 010 ....0 .....  @rd_rnx2 esz=1
+  UQXTNB        01000101 .. 1 ..... 010 010 ..... .....  @rd_rn_tszimm_shl
+}
 UQXTNT          01000101 .. 1 ..... 010 011 ..... .....  @rd_rn_tszimm_shl
-SQXTUNB         01000101 .. 1 ..... 010 100 ..... .....  @rd_rn_tszimm_shl
+{
+  SQCVTUN_sh    01000101 00 1 10001 010 100 ....0 .....  @rd_rnx2 esz=1
+  SQXTUNB       01000101 .. 1 ..... 010 100 ..... .....  @rd_rn_tszimm_shl
+}
 SQXTUNT         01000101 .. 1 ..... 010 101 ..... .....  @rd_rn_tszimm_shl
 
 ## SVE2 bitwise shift right narrow
-- 
2.43.0


