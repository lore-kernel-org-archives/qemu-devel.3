Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9693C02183
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 18:31:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYr5c-0004ty-Tv; Fri, 17 Jan 2025 13:29:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tYr5U-0004JB-0L
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 13:28:57 -0500
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tYr5P-00009k-EF
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 13:28:53 -0500
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-2ee46851b5eso3431723a91.1
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 10:28:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737138530; x=1737743330; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r7eBIyl0wZpu967JUtuB+u2AGsapT9SltfKDQGESryw=;
 b=lwbREm2I3DNLp8lmeCiGi/eMQwfVT1u1jExv4wg3u8QJhSnftpcFHn0iSDUhEPMGoE
 ICnVUQ5Jou5NAxFWLf3IevsYqCt+fbUVR4mg3KR2Vk4Yn01eiONGYNlItjUG/nr4FUVM
 IUjJX36zC5I6LN1AmFlwmgNTaUZQK/+E2EgZ2/0KV+6Mq/lCfZJRr7ghECfquPCR1qHo
 UHMGkHUpZNArQ5Qjf1V+kPCtUTdW6k0ZE3AnAUrCSDAWjvP8IuENXVBBSQ0yuwBjXAxd
 nOzJ+Wb9/NnAFJvuntOdr/MRET8kbwYlKCq0zb3VZpIHvSXtFDXgdnoz63NyUE8oT1kM
 paiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737138530; x=1737743330;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r7eBIyl0wZpu967JUtuB+u2AGsapT9SltfKDQGESryw=;
 b=Jijr3asxZIHENCPN7r+3rtoESYJrWqQ8umjrdb5CaboRow4LZ7kb/GuMlV2Q4ViXvg
 82ZKoS/MB64vDzQHjMzyjvCX06EawXZ1dlIHKh9j401oEoq+PHRodlHhqmSEXEJWuv3I
 1RzVKFjl1K3c54HKB9f6iHxYFCXoJDqX2SRjEO6BoWDoLf7ooDHJxl3KLCEYerP710WD
 3EW8EW+4FSNH0cwj0GcuBwiFPf4nHZxXAMBl9WGoZi6fiJj3vYquHwcSElW+nsztHkYD
 xK5VrdhJxZho1pGtd2ZU1XeTEuv4CorOSplXJ79oymUQHZEOb9InOwztpl1jwA81Npx2
 dUqw==
X-Gm-Message-State: AOJu0Yw0JCfGyp5EoncfM1pjEuZhfBNwWuy4UB6gDVqbE0+CbALwjm1p
 9gLlyR5j5XV85v9nxVfprJzUiyaDOx7ArN1QKPVrko8FfTI9oOFu2EU4y4YEpJNaAFg4Nnw//op
 E
X-Gm-Gg: ASbGnctrPq/D/JwWKlQkKY5/pB4yKaHhS1GN1NZ8jgvt7yUxiMoX8gQUsUUVOzgWPPz
 lnfH056I/LhQdUmpliS2T0GM+Nc/cOM/dA6H38Yt7zeIzbSwGbouLWCbuYSIcf/0w9Tnrb4q0DG
 icIIBOYVfwyr396IcKFvJFx7oeCBiIeGrJvllCRilzkIpnKFT+EE41M6xCinLYKK29IxzCV2bL3
 POj6NNvlPCTLmgAQ5UTNjdD8TFwhhjN2ufesO7LDPQAzBmk9PxlnMrQ6I9twLDJL3qXmxRO5qd9
 9iNaZAQFY/4PP6g=
X-Google-Smtp-Source: AGHT+IEc5fjFbhCWxAX3yq3AbwrqsY77LtLm4cAguC2NrtIYgCgHGiZ85I+l8bwk2riIFKTmTpEqeA==
X-Received: by 2002:a17:90b:2b87:b0:2ee:a127:ba96 with SMTP id
 98e67ed59e1d1-2f782d36030mr4314312a91.23.1737138528518; 
 Fri, 17 Jan 2025 10:28:48 -0800 (PST)
Received: from stoup.. (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f77629bf96sm2614105a91.36.2025.01.17.10.28.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2025 10:28:46 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 44/68] tcg: Drop implementation checks from tcg-opc.h
Date: Fri, 17 Jan 2025 10:24:32 -0800
Message-ID: <20250117182456.2077110-45-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250117182456.2077110-1-richard.henderson@linaro.org>
References: <20250117182456.2077110-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1032.google.com
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

Now that we use a functional interface to query whether the opcode
is supported, we can drop the TCG_OPF_NOT_PRESENT bit mapping from
TCG_TARGET_HAS_foo in tcg-opc.h

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-opc.h | 306 +++++++++++++++++++-----------------------
 1 file changed, 141 insertions(+), 165 deletions(-)

diff --git a/include/tcg/tcg-opc.h b/include/tcg/tcg-opc.h
index eb17a21f21..559f5971e6 100644
--- a/include/tcg/tcg-opc.h
+++ b/include/tcg/tcg-opc.h
@@ -35,18 +35,11 @@ DEF(call, 0, 0, 3, TCG_OPF_CALL_CLOBBER | TCG_OPF_NOT_PRESENT)
 
 DEF(br, 0, 0, 1, TCG_OPF_BB_END | TCG_OPF_NOT_PRESENT)
 
-#define IMPL(X) (__builtin_constant_p(X) && (X) <= 0 ? TCG_OPF_NOT_PRESENT : 0)
-#if TCG_TARGET_REG_BITS == 32
-# define IMPL64  TCG_OPF_NOT_PRESENT
-#else
-# define IMPL64  0
-#endif
-
 DEF(mb, 0, 0, 1, TCG_OPF_NOT_PRESENT)
 
 DEF(mov_i32, 1, 1, 0, TCG_OPF_NOT_PRESENT)
 DEF(setcond_i32, 1, 2, 1, 0)
-DEF(negsetcond_i32, 1, 2, 1, IMPL(TCG_TARGET_HAS_negsetcond_i32))
+DEF(negsetcond_i32, 1, 2, 1, 0)
 DEF(movcond_i32, 1, 4, 1, 0)
 /* load/store */
 DEF(ld8u_i32, 1, 1, 1, 0)
@@ -61,12 +54,12 @@ DEF(st_i32, 0, 2, 1, 0)
 DEF(add_i32, 1, 2, 0, 0)
 DEF(sub_i32, 1, 2, 0, 0)
 DEF(mul_i32, 1, 2, 0, 0)
-DEF(div_i32, 1, 2, 0, IMPL(TCG_TARGET_HAS_div_i32))
-DEF(divu_i32, 1, 2, 0, IMPL(TCG_TARGET_HAS_div_i32))
-DEF(rem_i32, 1, 2, 0, IMPL(TCG_TARGET_HAS_rem_i32))
-DEF(remu_i32, 1, 2, 0, IMPL(TCG_TARGET_HAS_rem_i32))
-DEF(div2_i32, 2, 3, 0, IMPL(TCG_TARGET_HAS_div2_i32))
-DEF(divu2_i32, 2, 3, 0, IMPL(TCG_TARGET_HAS_div2_i32))
+DEF(div_i32, 1, 2, 0, 0)
+DEF(divu_i32, 1, 2, 0, 0)
+DEF(rem_i32, 1, 2, 0, 0)
+DEF(remu_i32, 1, 2, 0, 0)
+DEF(div2_i32, 2, 3, 0, 0)
+DEF(divu2_i32, 2, 3, 0, 0)
 DEF(and_i32, 1, 2, 0, 0)
 DEF(or_i32, 1, 2, 0, 0)
 DEF(xor_i32, 1, 2, 0, 0)
@@ -74,119 +67,114 @@ DEF(xor_i32, 1, 2, 0, 0)
 DEF(shl_i32, 1, 2, 0, 0)
 DEF(shr_i32, 1, 2, 0, 0)
 DEF(sar_i32, 1, 2, 0, 0)
-DEF(rotl_i32, 1, 2, 0, IMPL(TCG_TARGET_HAS_rot_i32))
-DEF(rotr_i32, 1, 2, 0, IMPL(TCG_TARGET_HAS_rot_i32))
-DEF(deposit_i32, 1, 2, 2, IMPL(TCG_TARGET_HAS_deposit_i32))
-DEF(extract_i32, 1, 1, 2, IMPL(TCG_TARGET_HAS_extract_i32))
-DEF(sextract_i32, 1, 1, 2, IMPL(TCG_TARGET_HAS_sextract_i32))
-DEF(extract2_i32, 1, 2, 1, IMPL(TCG_TARGET_HAS_extract2_i32))
+DEF(rotl_i32, 1, 2, 0, 0)
+DEF(rotr_i32, 1, 2, 0, 0)
+DEF(deposit_i32, 1, 2, 2, 0)
+DEF(extract_i32, 1, 1, 2, 0)
+DEF(sextract_i32, 1, 1, 2, 0)
+DEF(extract2_i32, 1, 2, 1, 0)
 
 DEF(brcond_i32, 0, 2, 2, TCG_OPF_BB_END | TCG_OPF_COND_BRANCH)
 
-DEF(add2_i32, 2, 4, 0, IMPL(TCG_TARGET_HAS_add2_i32))
-DEF(sub2_i32, 2, 4, 0, IMPL(TCG_TARGET_HAS_sub2_i32))
-DEF(mulu2_i32, 2, 2, 0, IMPL(TCG_TARGET_HAS_mulu2_i32))
-DEF(muls2_i32, 2, 2, 0, IMPL(TCG_TARGET_HAS_muls2_i32))
-DEF(muluh_i32, 1, 2, 0, IMPL(TCG_TARGET_HAS_muluh_i32))
-DEF(mulsh_i32, 1, 2, 0, IMPL(TCG_TARGET_HAS_mulsh_i32))
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
 
-DEF(ext8s_i32, 1, 1, 0, IMPL(TCG_TARGET_HAS_ext8s_i32))
-DEF(ext16s_i32, 1, 1, 0, IMPL(TCG_TARGET_HAS_ext16s_i32))
-DEF(ext8u_i32, 1, 1, 0, IMPL(TCG_TARGET_HAS_ext8u_i32))
-DEF(ext16u_i32, 1, 1, 0, IMPL(TCG_TARGET_HAS_ext16u_i32))
-DEF(bswap16_i32, 1, 1, 1, IMPL(TCG_TARGET_HAS_bswap16_i32))
-DEF(bswap32_i32, 1, 1, 1, IMPL(TCG_TARGET_HAS_bswap32_i32))
-DEF(not_i32, 1, 1, 0, IMPL(TCG_TARGET_HAS_not_i32))
+DEF(ext8s_i32, 1, 1, 0, 0)
+DEF(ext16s_i32, 1, 1, 0, 0)
+DEF(ext8u_i32, 1, 1, 0, 0)
+DEF(ext16u_i32, 1, 1, 0, 0)
+DEF(bswap16_i32, 1, 1, 1, 0)
+DEF(bswap32_i32, 1, 1, 1, 0)
+DEF(not_i32, 1, 1, 0, 0)
 DEF(neg_i32, 1, 1, 0, 0)
-DEF(andc_i32, 1, 2, 0, IMPL(TCG_TARGET_HAS_andc_i32))
-DEF(orc_i32, 1, 2, 0, IMPL(TCG_TARGET_HAS_orc_i32))
-DEF(eqv_i32, 1, 2, 0, IMPL(TCG_TARGET_HAS_eqv_i32))
-DEF(nand_i32, 1, 2, 0, IMPL(TCG_TARGET_HAS_nand_i32))
-DEF(nor_i32, 1, 2, 0, IMPL(TCG_TARGET_HAS_nor_i32))
-DEF(clz_i32, 1, 2, 0, IMPL(TCG_TARGET_HAS_clz_i32))
-DEF(ctz_i32, 1, 2, 0, IMPL(TCG_TARGET_HAS_ctz_i32))
-DEF(ctpop_i32, 1, 1, 0, IMPL(TCG_TARGET_HAS_ctpop_i32))
+DEF(andc_i32, 1, 2, 0, 0)
+DEF(orc_i32, 1, 2, 0, 0)
+DEF(eqv_i32, 1, 2, 0, 0)
+DEF(nand_i32, 1, 2, 0, 0)
+DEF(nor_i32, 1, 2, 0, 0)
+DEF(clz_i32, 1, 2, 0, 0)
+DEF(ctz_i32, 1, 2, 0, 0)
+DEF(ctpop_i32, 1, 1, 0, 0)
 
 DEF(mov_i64, 1, 1, 0, TCG_OPF_NOT_PRESENT)
-DEF(setcond_i64, 1, 2, 1, IMPL64)
-DEF(negsetcond_i64, 1, 2, 1, IMPL64 | IMPL(TCG_TARGET_HAS_negsetcond_i64))
-DEF(movcond_i64, 1, 4, 1, IMPL64)
+DEF(setcond_i64, 1, 2, 1, 0)
+DEF(negsetcond_i64, 1, 2, 1, 0)
+DEF(movcond_i64, 1, 4, 1, 0)
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
+DEF(ld8u_i64, 1, 1, 1, 0)
+DEF(ld8s_i64, 1, 1, 1, 0)
+DEF(ld16u_i64, 1, 1, 1, 0)
+DEF(ld16s_i64, 1, 1, 1, 0)
+DEF(ld32u_i64, 1, 1, 1, 0)
+DEF(ld32s_i64, 1, 1, 1, 0)
+DEF(ld_i64, 1, 1, 1, 0)
+DEF(st8_i64, 0, 2, 1, 0)
+DEF(st16_i64, 0, 2, 1, 0)
+DEF(st32_i64, 0, 2, 1, 0)
+DEF(st_i64, 0, 2, 1, 0)
 /* arith */
-DEF(add_i64, 1, 2, 0, IMPL64)
-DEF(sub_i64, 1, 2, 0, IMPL64)
-DEF(mul_i64, 1, 2, 0, IMPL64)
-DEF(div_i64, 1, 2, 0, IMPL64 | IMPL(TCG_TARGET_HAS_div_i64))
-DEF(divu_i64, 1, 2, 0, IMPL64 | IMPL(TCG_TARGET_HAS_div_i64))
-DEF(rem_i64, 1, 2, 0, IMPL64 | IMPL(TCG_TARGET_HAS_rem_i64))
-DEF(remu_i64, 1, 2, 0, IMPL64 | IMPL(TCG_TARGET_HAS_rem_i64))
-DEF(div2_i64, 2, 3, 0, IMPL64 | IMPL(TCG_TARGET_HAS_div2_i64))
-DEF(divu2_i64, 2, 3, 0, IMPL64 | IMPL(TCG_TARGET_HAS_div2_i64))
-DEF(and_i64, 1, 2, 0, IMPL64)
-DEF(or_i64, 1, 2, 0, IMPL64)
-DEF(xor_i64, 1, 2, 0, IMPL64)
+DEF(add_i64, 1, 2, 0, 0)
+DEF(sub_i64, 1, 2, 0, 0)
+DEF(mul_i64, 1, 2, 0, 0)
+DEF(div_i64, 1, 2, 0, 0)
+DEF(divu_i64, 1, 2, 0, 0)
+DEF(rem_i64, 1, 2, 0, 0)
+DEF(remu_i64, 1, 2, 0, 0)
+DEF(div2_i64, 2, 3, 0, 0)
+DEF(divu2_i64, 2, 3, 0, 0)
+DEF(and_i64, 1, 2, 0, 0)
+DEF(or_i64, 1, 2, 0, 0)
+DEF(xor_i64, 1, 2, 0, 0)
 /* shifts/rotates */
-DEF(shl_i64, 1, 2, 0, IMPL64)
-DEF(shr_i64, 1, 2, 0, IMPL64)
-DEF(sar_i64, 1, 2, 0, IMPL64)
-DEF(rotl_i64, 1, 2, 0, IMPL64 | IMPL(TCG_TARGET_HAS_rot_i64))
-DEF(rotr_i64, 1, 2, 0, IMPL64 | IMPL(TCG_TARGET_HAS_rot_i64))
-DEF(deposit_i64, 1, 2, 2, IMPL64 | IMPL(TCG_TARGET_HAS_deposit_i64))
-DEF(extract_i64, 1, 1, 2, IMPL64 | IMPL(TCG_TARGET_HAS_extract_i64))
-DEF(sextract_i64, 1, 1, 2, IMPL64 | IMPL(TCG_TARGET_HAS_sextract_i64))
-DEF(extract2_i64, 1, 2, 1, IMPL64 | IMPL(TCG_TARGET_HAS_extract2_i64))
+DEF(shl_i64, 1, 2, 0, 0)
+DEF(shr_i64, 1, 2, 0, 0)
+DEF(sar_i64, 1, 2, 0, 0)
+DEF(rotl_i64, 1, 2, 0, 0)
+DEF(rotr_i64, 1, 2, 0, 0)
+DEF(deposit_i64, 1, 2, 2, 0)
+DEF(extract_i64, 1, 1, 2, 0)
+DEF(sextract_i64, 1, 1, 2, 0)
+DEF(extract2_i64, 1, 2, 1, 0)
 
 /* size changing ops */
-DEF(ext_i32_i64, 1, 1, 0, IMPL64)
-DEF(extu_i32_i64, 1, 1, 0, IMPL64)
-DEF(extrl_i64_i32, 1, 1, 0,
-    IMPL(TCG_TARGET_HAS_extr_i64_i32)
-    | (TCG_TARGET_REG_BITS == 32 ? TCG_OPF_NOT_PRESENT : 0))
-DEF(extrh_i64_i32, 1, 1, 0,
-    IMPL(TCG_TARGET_HAS_extr_i64_i32)
-    | (TCG_TARGET_REG_BITS == 32 ? TCG_OPF_NOT_PRESENT : 0))
+DEF(ext_i32_i64, 1, 1, 0, 0)
+DEF(extu_i32_i64, 1, 1, 0, 0)
+DEF(extrl_i64_i32, 1, 1, 0, 0)
+DEF(extrh_i64_i32, 1, 1, 0, 0)
 
-DEF(brcond_i64, 0, 2, 2, TCG_OPF_BB_END | TCG_OPF_COND_BRANCH | IMPL64)
-DEF(ext8s_i64, 1, 1, 0, IMPL64 | IMPL(TCG_TARGET_HAS_ext8s_i64))
-DEF(ext16s_i64, 1, 1, 0, IMPL64 | IMPL(TCG_TARGET_HAS_ext16s_i64))
-DEF(ext32s_i64, 1, 1, 0, IMPL64 | IMPL(TCG_TARGET_HAS_ext32s_i64))
-DEF(ext8u_i64, 1, 1, 0, IMPL64 | IMPL(TCG_TARGET_HAS_ext8u_i64))
-DEF(ext16u_i64, 1, 1, 0, IMPL64 | IMPL(TCG_TARGET_HAS_ext16u_i64))
-DEF(ext32u_i64, 1, 1, 0, IMPL64 | IMPL(TCG_TARGET_HAS_ext32u_i64))
-DEF(bswap16_i64, 1, 1, 1, IMPL64 | IMPL(TCG_TARGET_HAS_bswap16_i64))
-DEF(bswap32_i64, 1, 1, 1, IMPL64 | IMPL(TCG_TARGET_HAS_bswap32_i64))
-DEF(bswap64_i64, 1, 1, 1, IMPL64 | IMPL(TCG_TARGET_HAS_bswap64_i64))
-DEF(not_i64, 1, 1, 0, IMPL64 | IMPL(TCG_TARGET_HAS_not_i64))
-DEF(neg_i64, 1, 1, 0, IMPL64)
-DEF(andc_i64, 1, 2, 0, IMPL64 | IMPL(TCG_TARGET_HAS_andc_i64))
-DEF(orc_i64, 1, 2, 0, IMPL64 | IMPL(TCG_TARGET_HAS_orc_i64))
-DEF(eqv_i64, 1, 2, 0, IMPL64 | IMPL(TCG_TARGET_HAS_eqv_i64))
-DEF(nand_i64, 1, 2, 0, IMPL64 | IMPL(TCG_TARGET_HAS_nand_i64))
-DEF(nor_i64, 1, 2, 0, IMPL64 | IMPL(TCG_TARGET_HAS_nor_i64))
-DEF(clz_i64, 1, 2, 0, IMPL64 | IMPL(TCG_TARGET_HAS_clz_i64))
-DEF(ctz_i64, 1, 2, 0, IMPL64 | IMPL(TCG_TARGET_HAS_ctz_i64))
-DEF(ctpop_i64, 1, 1, 0, IMPL64 | IMPL(TCG_TARGET_HAS_ctpop_i64))
+DEF(brcond_i64, 0, 2, 2, TCG_OPF_BB_END | TCG_OPF_COND_BRANCH)
+DEF(ext8s_i64, 1, 1, 0, 0)
+DEF(ext16s_i64, 1, 1, 0, 0)
+DEF(ext32s_i64, 1, 1, 0, 0)
+DEF(ext8u_i64, 1, 1, 0, 0)
+DEF(ext16u_i64, 1, 1, 0, 0)
+DEF(ext32u_i64, 1, 1, 0, 0)
+DEF(bswap16_i64, 1, 1, 1, 0)
+DEF(bswap32_i64, 1, 1, 1, 0)
+DEF(bswap64_i64, 1, 1, 1, 0)
+DEF(not_i64, 1, 1, 0, 0)
+DEF(neg_i64, 1, 1, 0, 0)
+DEF(andc_i64, 1, 2, 0, 0)
+DEF(orc_i64, 1, 2, 0, 0)
+DEF(eqv_i64, 1, 2, 0, 0)
+DEF(nand_i64, 1, 2, 0, 0)
+DEF(nor_i64, 1, 2, 0, 0)
+DEF(clz_i64, 1, 2, 0, 0)
+DEF(ctz_i64, 1, 2, 0, 0)
+DEF(ctpop_i64, 1, 1, 0, 0)
 
-DEF(add2_i64, 2, 4, 0, IMPL64 | IMPL(TCG_TARGET_HAS_add2_i64))
-DEF(sub2_i64, 2, 4, 0, IMPL64 | IMPL(TCG_TARGET_HAS_sub2_i64))
-DEF(mulu2_i64, 2, 2, 0, IMPL64 | IMPL(TCG_TARGET_HAS_mulu2_i64))
-DEF(muls2_i64, 2, 2, 0, IMPL64 | IMPL(TCG_TARGET_HAS_muls2_i64))
-DEF(muluh_i64, 1, 2, 0, IMPL64 | IMPL(TCG_TARGET_HAS_muluh_i64))
-DEF(mulsh_i64, 1, 2, 0, IMPL64 | IMPL(TCG_TARGET_HAS_mulsh_i64))
+DEF(add2_i64, 2, 4, 0, 0)
+DEF(sub2_i64, 2, 4, 0, 0)
+DEF(mulu2_i64, 2, 2, 0, 0)
+DEF(muls2_i64, 2, 2, 0, 0)
+DEF(muluh_i64, 1, 2, 0, 0)
+DEF(mulsh_i64, 1, 2, 0, 0)
 
 #define DATA64_ARGS  (TCG_TARGET_REG_BITS == 64 ? 1 : 2)
 
@@ -221,34 +209,24 @@ DEF(qemu_st_a64_i64, 0, DATA64_ARGS + DATA64_ARGS, 1,
 
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
-DEF(qemu_ld_a32_i128, 2, 1, 1,
-    TCG_OPF_CALL_CLOBBER | TCG_OPF_SIDE_EFFECTS |
-    IMPL(TCG_TARGET_HAS_qemu_ldst_i128))
-DEF(qemu_ld_a64_i128, 2, 1, 1,
-    TCG_OPF_CALL_CLOBBER | TCG_OPF_SIDE_EFFECTS |
-    IMPL(TCG_TARGET_HAS_qemu_ldst_i128))
-DEF(qemu_st_a32_i128, 0, 3, 1,
-    TCG_OPF_CALL_CLOBBER | TCG_OPF_SIDE_EFFECTS |
-    IMPL(TCG_TARGET_HAS_qemu_ldst_i128))
-DEF(qemu_st_a64_i128, 0, 3, 1,
-    TCG_OPF_CALL_CLOBBER | TCG_OPF_SIDE_EFFECTS |
-    IMPL(TCG_TARGET_HAS_qemu_ldst_i128))
+DEF(qemu_ld_a32_i128, 2, 1, 1, TCG_OPF_CALL_CLOBBER | TCG_OPF_SIDE_EFFECTS)
+DEF(qemu_ld_a64_i128, 2, 1, 1, TCG_OPF_CALL_CLOBBER | TCG_OPF_SIDE_EFFECTS)
+DEF(qemu_st_a32_i128, 0, 3, 1, TCG_OPF_CALL_CLOBBER | TCG_OPF_SIDE_EFFECTS)
+DEF(qemu_st_a64_i128, 0, 3, 1, TCG_OPF_CALL_CLOBBER | TCG_OPF_SIDE_EFFECTS)
 
 /* Host vector support.  */
 
-#define IMPLVEC  TCG_OPF_VECTOR | IMPL(TCG_TARGET_MAYBE_vec)
+#define IMPLVEC  TCG_OPF_VECTOR
 
 DEF(mov_vec, 1, 1, 0, TCG_OPF_VECTOR | TCG_OPF_NOT_PRESENT)
 
 DEF(dup_vec, 1, 1, 0, IMPLVEC)
-DEF(dup2_vec, 1, 2, 0, IMPLVEC | IMPL(TCG_TARGET_REG_BITS == 32))
+DEF(dup2_vec, 1, 2, 0, IMPLVEC)
 
 DEF(ld_vec, 1, 1, 1, IMPLVEC)
 DEF(st_vec, 0, 2, 1, IMPLVEC)
@@ -256,55 +234,53 @@ DEF(dupm_vec, 1, 1, 1, IMPLVEC)
 
 DEF(add_vec, 1, 2, 0, IMPLVEC)
 DEF(sub_vec, 1, 2, 0, IMPLVEC)
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
+DEF(mul_vec, 1, 2, 0, IMPLVEC)
+DEF(neg_vec, 1, 1, 0, IMPLVEC)
+DEF(abs_vec, 1, 1, 0, IMPLVEC)
+DEF(ssadd_vec, 1, 2, 0, IMPLVEC)
+DEF(usadd_vec, 1, 2, 0, IMPLVEC)
+DEF(sssub_vec, 1, 2, 0, IMPLVEC)
+DEF(ussub_vec, 1, 2, 0, IMPLVEC)
+DEF(smin_vec, 1, 2, 0, IMPLVEC)
+DEF(umin_vec, 1, 2, 0, IMPLVEC)
+DEF(smax_vec, 1, 2, 0, IMPLVEC)
+DEF(umax_vec, 1, 2, 0, IMPLVEC)
 
 DEF(and_vec, 1, 2, 0, IMPLVEC)
 DEF(or_vec, 1, 2, 0, IMPLVEC)
 DEF(xor_vec, 1, 2, 0, IMPLVEC)
-DEF(andc_vec, 1, 2, 0, IMPLVEC | IMPL(TCG_TARGET_HAS_andc_vec))
-DEF(orc_vec, 1, 2, 0, IMPLVEC | IMPL(TCG_TARGET_HAS_orc_vec))
-DEF(nand_vec, 1, 2, 0, IMPLVEC | IMPL(TCG_TARGET_HAS_nand_vec))
-DEF(nor_vec, 1, 2, 0, IMPLVEC | IMPL(TCG_TARGET_HAS_nor_vec))
-DEF(eqv_vec, 1, 2, 0, IMPLVEC | IMPL(TCG_TARGET_HAS_eqv_vec))
-DEF(not_vec, 1, 1, 0, IMPLVEC | IMPL(TCG_TARGET_HAS_not_vec))
+DEF(andc_vec, 1, 2, 0, IMPLVEC)
+DEF(orc_vec, 1, 2, 0, IMPLVEC)
+DEF(nand_vec, 1, 2, 0, IMPLVEC)
+DEF(nor_vec, 1, 2, 0, IMPLVEC)
+DEF(eqv_vec, 1, 2, 0, IMPLVEC)
+DEF(not_vec, 1, 1, 0, IMPLVEC)
 
-DEF(shli_vec, 1, 1, 1, IMPLVEC | IMPL(TCG_TARGET_HAS_shi_vec))
-DEF(shri_vec, 1, 1, 1, IMPLVEC | IMPL(TCG_TARGET_HAS_shi_vec))
-DEF(sari_vec, 1, 1, 1, IMPLVEC | IMPL(TCG_TARGET_HAS_shi_vec))
-DEF(rotli_vec, 1, 1, 1, IMPLVEC | IMPL(TCG_TARGET_HAS_roti_vec))
+DEF(shli_vec, 1, 1, 1, IMPLVEC)
+DEF(shri_vec, 1, 1, 1, IMPLVEC)
+DEF(sari_vec, 1, 1, 1, IMPLVEC)
+DEF(rotli_vec, 1, 1, 1, IMPLVEC)
 
-DEF(shls_vec, 1, 2, 0, IMPLVEC | IMPL(TCG_TARGET_HAS_shs_vec))
-DEF(shrs_vec, 1, 2, 0, IMPLVEC | IMPL(TCG_TARGET_HAS_shs_vec))
-DEF(sars_vec, 1, 2, 0, IMPLVEC | IMPL(TCG_TARGET_HAS_shs_vec))
-DEF(rotls_vec, 1, 2, 0, IMPLVEC | IMPL(TCG_TARGET_HAS_rots_vec))
+DEF(shls_vec, 1, 2, 0, IMPLVEC)
+DEF(shrs_vec, 1, 2, 0, IMPLVEC)
+DEF(sars_vec, 1, 2, 0, IMPLVEC)
+DEF(rotls_vec, 1, 2, 0, IMPLVEC)
 
-DEF(shlv_vec, 1, 2, 0, IMPLVEC | IMPL(TCG_TARGET_HAS_shv_vec))
-DEF(shrv_vec, 1, 2, 0, IMPLVEC | IMPL(TCG_TARGET_HAS_shv_vec))
-DEF(sarv_vec, 1, 2, 0, IMPLVEC | IMPL(TCG_TARGET_HAS_shv_vec))
-DEF(rotlv_vec, 1, 2, 0, IMPLVEC | IMPL(TCG_TARGET_HAS_rotv_vec))
-DEF(rotrv_vec, 1, 2, 0, IMPLVEC | IMPL(TCG_TARGET_HAS_rotv_vec))
+DEF(shlv_vec, 1, 2, 0, IMPLVEC)
+DEF(shrv_vec, 1, 2, 0, IMPLVEC)
+DEF(sarv_vec, 1, 2, 0, IMPLVEC)
+DEF(rotlv_vec, 1, 2, 0, IMPLVEC)
+DEF(rotrv_vec, 1, 2, 0, IMPLVEC)
 
 DEF(cmp_vec, 1, 2, 1, IMPLVEC)
 
-DEF(bitsel_vec, 1, 3, 0, IMPLVEC | IMPL(TCG_TARGET_HAS_bitsel_vec))
-DEF(cmpsel_vec, 1, 4, 1, IMPLVEC | IMPL(TCG_TARGET_HAS_cmpsel_vec))
+DEF(bitsel_vec, 1, 3, 0, IMPLVEC)
+DEF(cmpsel_vec, 1, 4, 1, IMPLVEC)
 
 DEF(last_generic, 0, 0, 0, TCG_OPF_NOT_PRESENT)
 
 #include "tcg-target-opc.h.inc"
 
 #undef DATA64_ARGS
-#undef IMPL
-#undef IMPL64
 #undef IMPLVEC
 #undef DEF
-- 
2.43.0


