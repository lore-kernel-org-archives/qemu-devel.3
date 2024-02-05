Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E83AEC4828F
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Feb 2024 02:40:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWou0-0001SW-Rj; Sun, 04 Feb 2024 21:40:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rWotz-0001S4-7G
 for qemu-devel@nongnu.org; Sun, 04 Feb 2024 21:40:07 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rWotu-0003cH-9H
 for qemu-devel@nongnu.org; Sun, 04 Feb 2024 21:40:06 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1d7881b1843so34531245ad.3
 for <qemu-devel@nongnu.org>; Sun, 04 Feb 2024 18:40:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707100801; x=1707705601; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sZmcF1GRwYwwi8dNdMLWDecX4dRVBRfMWi8JTDZKlnQ=;
 b=zFw6vEfv8/PtS1edV+w4FMlUKXQFbhGgIUa/vwC3ns70k0rYW45Ztc9YT1tHO7eMhO
 sHMy1Ib6QXSRE77VqSY6G2JVk45I9YXOkloZo86h7VhxO92/gndTYt8kTz8mAczDD9Yz
 rvY32NHB0V27Djcd+QrEpOam/bw/vzQtgM66+w8yiwVIq3utwIxietHU83ovi2ibS12z
 BW0lkv9QDA7B546J+75XG+jRnFw6EC3a6y8nuwcV4AyPg0hJpmVoF0fmQLq/+5LDksUU
 urxPIE1i640AT0u0Gm/xDmWKy8it2x5fxCnavUVTg/UPSp/5XsADdVMqQfzapGMZ9WkP
 UpGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707100801; x=1707705601;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sZmcF1GRwYwwi8dNdMLWDecX4dRVBRfMWi8JTDZKlnQ=;
 b=Jxq83Ed7yom0Exd2qnj+fZ3M/p7FcpGe0wAMQ8GYyypr+yeiC7bwIb77XmjMzgaeg2
 4nLpH+fWWfUlCICCvvy4tBr9oLQU9R/mUtMeV7yv/oTfLB5gWV61J7RA76F59g7cAao9
 RG2BnGA/LZ9BhYYw/b9nVkpmLn8j9W2J6/wLtFLzNVZ+gxHnOKHbSLoREYFNi1PEwZNU
 gvYfW8+R+KdFaNzyEvceKpYCUw3GP/q8b0E9ZdVclwdPBkG240EtUv7LjXhEt/QrK9ih
 RqQFI9pGg3XuE+04Z0Qdp0I5bzELYF0GH1ovDcUMoINyOVIoTR6PtXaKzeIj2662zgts
 90jQ==
X-Gm-Message-State: AOJu0YziNSkFZO3HlvX0U3vpM6bYjGQwfaJO1yS2XZ87gHIIIl0ojDCl
 +/Pe/K8Bx7XslVZN/FcjzHpf6QzMtsXwQNeqIlyoZeTYa/Obep9QSpbeafyOagoQrSx3a6IxCzB
 CDmk=
X-Google-Smtp-Source: AGHT+IGq2S/lwOT+XM/uwX4hGdYDUwEtrpKqevNV/c+nz9xDlg70EINc7rXDUR8EyK6WKyF7snLZlg==
X-Received: by 2002:a17:903:11ce:b0:1d9:dcd:c726 with SMTP id
 q14-20020a17090311ce00b001d90dcdc726mr10814980plh.17.1707100800126; 
 Sun, 04 Feb 2024 18:40:00 -0800 (PST)
Received: from stoup.. ([43.252.112.156]) by smtp.gmail.com with ESMTPSA id
 d20-20020a170903209400b001d98942d290sm3292130plc.124.2024.02.04.18.39.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Feb 2024 18:39:59 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: gustavo.romero@linaro.org
Subject: [PATCH 3/3] target/arm: Split mtedesc from vector desc
Date: Mon,  5 Feb 2024 12:39:48 +1000
Message-Id: <20240205023948.25476-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240205023948.25476-1-richard.henderson@linaro.org>
References: <20240205023948.25476-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The simd_desc field (32 - SIMD_DATA_SHIFT) is 22 bits.
Subtracting SVE_MTEDESC_SHIFT leaves 17 bits.
Skipping over MTEDESC_ALIGN leaves 5 bits for MTEDESC_SIZEM1.
However, we need 10 bits to represent the size for LD4/ST4
with maximum length vectors (16 * 16 * 4 - 1 = 1023).

Pass the mte and vector descriptors as separate parameters
rather than try to pack them into one.

Adding an extra parameter to only the *_mte helpers would
break the common ABI between mte and non-mte, making the
translation code more complicated.  Instead, drop the split
between mte and non-mte helpers and always pass mtedesc.

By inspection this appears to have been broken incrementally:
  - all bits fit with no spare in 206adacfb8d (2020-06-25)
  - simd desc grew by 3 bits in e2e7168a214 (2020-08-30)
  - mte desc grew by 3 bits in 523da6b9634 (2023-06-06)

All of which *still* worked with linux default SVE vector
size of 32 bytes.  However, larger vector sizes would
trigger the assert in simd_desc().

Reported-by: Gustavo Romero <gustavo.romero@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/internals.h         |    8 +-
 target/arm/tcg/helper-sme.h    |  108 +--
 target/arm/tcg/helper-sve.h    | 1255 ++++++++------------------------
 target/arm/tcg/sme_helper.c    |  123 +---
 target/arm/tcg/sve_helper.c    |  355 ++-------
 target/arm/tcg/translate-sme.c |   33 +-
 target/arm/tcg/translate-sve.c | 1246 +++++++++++--------------------
 7 files changed, 906 insertions(+), 2222 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index fc337fe40e..981621cff2 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1266,19 +1266,13 @@ FIELD(PREDDESC, OPRSZ, 0, 6)
 FIELD(PREDDESC, ESZ, 6, 2)
 FIELD(PREDDESC, DATA, 8, 24)
 
-/*
- * The SVE simd_data field, for memory ops, contains either
- * rd (5 bits) or a shift count (2 bits).
- */
-#define SVE_MTEDESC_SHIFT 5
-
 /* Bits within a descriptor passed to the helper_mte_check* functions. */
 FIELD(MTEDESC, MIDX,  0, 4)
 FIELD(MTEDESC, TBI,   4, 2)
 FIELD(MTEDESC, TCMA,  6, 2)
 FIELD(MTEDESC, WRITE, 8, 1)
 FIELD(MTEDESC, ALIGN, 9, 3)
-FIELD(MTEDESC, SIZEM1, 12, SIMD_DATA_BITS - 12)  /* size - 1 */
+FIELD(MTEDESC, SIZEM1, 12, 10)  /* size - 1 */
 
 bool mte_probe(CPUARMState *env, uint32_t desc, uint64_t ptr);
 uint64_t mte_check(CPUARMState *env, uint32_t desc, uint64_t ptr, uintptr_t ra);
diff --git a/target/arm/tcg/helper-sme.h b/target/arm/tcg/helper-sme.h
index 27eef49a11..ffd1e6d309 100644
--- a/target/arm/tcg/helper-sme.h
+++ b/target/arm/tcg/helper-sme.h
@@ -33,87 +33,51 @@ DEF_HELPER_FLAGS_4(sme_mova_zc_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sme_mova_cz_q, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sme_mova_zc_q, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 
-DEF_HELPER_FLAGS_5(sme_ld1b_h, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_5(sme_ld1b_v, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_5(sme_ld1b_h_mte, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_5(sme_ld1b_v_mte, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sme_ld1b_h, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_6(sme_ld1b_v, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i32, i32)
 
-DEF_HELPER_FLAGS_5(sme_ld1h_be_h, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_5(sme_ld1h_le_h, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_5(sme_ld1h_be_v, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_5(sme_ld1h_le_v, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_5(sme_ld1h_be_h_mte, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_5(sme_ld1h_le_h_mte, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_5(sme_ld1h_be_v_mte, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_5(sme_ld1h_le_v_mte, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sme_ld1h_be_h, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_6(sme_ld1h_le_h, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_6(sme_ld1h_be_v, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_6(sme_ld1h_le_v, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i32, i32)
 
-DEF_HELPER_FLAGS_5(sme_ld1s_be_h, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_5(sme_ld1s_le_h, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_5(sme_ld1s_be_v, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_5(sme_ld1s_le_v, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_5(sme_ld1s_be_h_mte, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_5(sme_ld1s_le_h_mte, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_5(sme_ld1s_be_v_mte, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_5(sme_ld1s_le_v_mte, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sme_ld1s_be_h, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_6(sme_ld1s_le_h, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_6(sme_ld1s_be_v, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_6(sme_ld1s_le_v, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i32, i32)
 
-DEF_HELPER_FLAGS_5(sme_ld1d_be_h, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_5(sme_ld1d_le_h, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_5(sme_ld1d_be_v, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_5(sme_ld1d_le_v, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_5(sme_ld1d_be_h_mte, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_5(sme_ld1d_le_h_mte, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_5(sme_ld1d_be_v_mte, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_5(sme_ld1d_le_v_mte, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sme_ld1d_be_h, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_6(sme_ld1d_le_h, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_6(sme_ld1d_be_v, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_6(sme_ld1d_le_v, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i32, i32)
 
-DEF_HELPER_FLAGS_5(sme_ld1q_be_h, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_5(sme_ld1q_le_h, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_5(sme_ld1q_be_v, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_5(sme_ld1q_le_v, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_5(sme_ld1q_be_h_mte, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_5(sme_ld1q_le_h_mte, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_5(sme_ld1q_be_v_mte, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_5(sme_ld1q_le_v_mte, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sme_ld1q_be_h, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_6(sme_ld1q_le_h, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_6(sme_ld1q_be_v, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_6(sme_ld1q_le_v, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i32, i32)
 
-DEF_HELPER_FLAGS_5(sme_st1b_h, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_5(sme_st1b_v, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_5(sme_st1b_h_mte, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_5(sme_st1b_v_mte, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sme_st1b_h, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_6(sme_st1b_v, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i32, i32)
 
-DEF_HELPER_FLAGS_5(sme_st1h_be_h, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_5(sme_st1h_le_h, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_5(sme_st1h_be_v, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_5(sme_st1h_le_v, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_5(sme_st1h_be_h_mte, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_5(sme_st1h_le_h_mte, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_5(sme_st1h_be_v_mte, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_5(sme_st1h_le_v_mte, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sme_st1h_be_h, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_6(sme_st1h_le_h, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_6(sme_st1h_be_v, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_6(sme_st1h_le_v, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i32, i32)
 
-DEF_HELPER_FLAGS_5(sme_st1s_be_h, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_5(sme_st1s_le_h, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_5(sme_st1s_be_v, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_5(sme_st1s_le_v, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_5(sme_st1s_be_h_mte, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_5(sme_st1s_le_h_mte, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_5(sme_st1s_be_v_mte, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_5(sme_st1s_le_v_mte, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sme_st1s_be_h, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_6(sme_st1s_le_h, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_6(sme_st1s_be_v, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_6(sme_st1s_le_v, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i32, i32)
 
-DEF_HELPER_FLAGS_5(sme_st1d_be_h, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_5(sme_st1d_le_h, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_5(sme_st1d_be_v, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_5(sme_st1d_le_v, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_5(sme_st1d_be_h_mte, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_5(sme_st1d_le_h_mte, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_5(sme_st1d_be_v_mte, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_5(sme_st1d_le_v_mte, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sme_st1d_be_h, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_6(sme_st1d_le_h, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_6(sme_st1d_be_v, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_6(sme_st1d_le_v, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i32, i32)
 
-DEF_HELPER_FLAGS_5(sme_st1q_be_h, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_5(sme_st1q_le_h, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_5(sme_st1q_be_v, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_5(sme_st1q_le_v, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_5(sme_st1q_be_h_mte, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_5(sme_st1q_le_h_mte, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_5(sme_st1q_be_v_mte, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_5(sme_st1q_le_v_mte, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sme_st1q_be_h, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_6(sme_st1q_le_h, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_6(sme_st1q_be_v, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_6(sme_st1q_le_v, TCG_CALL_NO_WG, void, env, ptr, ptr, tl, i32, i32)
 
 DEF_HELPER_FLAGS_5(sme_addha_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(sme_addva_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
diff --git a/target/arm/tcg/helper-sve.h b/target/arm/tcg/helper-sve.h
index cc4e1d8948..7f8c85e252 100644
--- a/target/arm/tcg/helper-sve.h
+++ b/target/arm/tcg/helper-sve.h
@@ -1427,945 +1427,322 @@ DEF_HELPER_FLAGS_4(sve2_usubw_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sve2_usubw_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sve2_usubw_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 
-DEF_HELPER_FLAGS_4(sve_ld1bb_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ld2bb_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ld3bb_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ld4bb_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-
-DEF_HELPER_FLAGS_4(sve_ld1hh_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ld2hh_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ld3hh_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ld4hh_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-
-DEF_HELPER_FLAGS_4(sve_ld1hh_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ld2hh_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ld3hh_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ld4hh_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-
-DEF_HELPER_FLAGS_4(sve_ld1ss_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ld2ss_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ld3ss_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ld4ss_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-
-DEF_HELPER_FLAGS_4(sve_ld1ss_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ld2ss_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ld3ss_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ld4ss_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-
-DEF_HELPER_FLAGS_4(sve_ld1dd_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ld2dd_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ld3dd_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ld4dd_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-
-DEF_HELPER_FLAGS_4(sve_ld1dd_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ld2dd_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ld3dd_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ld4dd_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-
-DEF_HELPER_FLAGS_4(sve_ld1bhu_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ld1bsu_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ld1bdu_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ld1bhs_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ld1bss_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ld1bds_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-
-DEF_HELPER_FLAGS_4(sve_ld1hsu_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ld1hdu_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ld1hss_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ld1hds_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-
-DEF_HELPER_FLAGS_4(sve_ld1hsu_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ld1hdu_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ld1hss_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ld1hds_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-
-DEF_HELPER_FLAGS_4(sve_ld1sdu_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ld1sds_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-
-DEF_HELPER_FLAGS_4(sve_ld1sdu_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ld1sds_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-
-DEF_HELPER_FLAGS_4(sve_ld1bb_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ld2bb_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ld3bb_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ld4bb_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-
-DEF_HELPER_FLAGS_4(sve_ld1hh_le_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ld2hh_le_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ld3hh_le_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ld4hh_le_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-
-DEF_HELPER_FLAGS_4(sve_ld1hh_be_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ld2hh_be_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ld3hh_be_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ld4hh_be_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-
-DEF_HELPER_FLAGS_4(sve_ld1ss_le_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ld2ss_le_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ld3ss_le_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ld4ss_le_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-
-DEF_HELPER_FLAGS_4(sve_ld1ss_be_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ld2ss_be_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ld3ss_be_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ld4ss_be_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-
-DEF_HELPER_FLAGS_4(sve_ld1dd_le_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ld2dd_le_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ld3dd_le_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ld4dd_le_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-
-DEF_HELPER_FLAGS_4(sve_ld1dd_be_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ld2dd_be_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ld3dd_be_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ld4dd_be_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-
-DEF_HELPER_FLAGS_4(sve_ld1bhu_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ld1bsu_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ld1bdu_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ld1bhs_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ld1bss_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ld1bds_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-
-DEF_HELPER_FLAGS_4(sve_ld1hsu_le_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ld1hdu_le_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ld1hss_le_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ld1hds_le_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-
-DEF_HELPER_FLAGS_4(sve_ld1hsu_be_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ld1hdu_be_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ld1hss_be_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ld1hds_be_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-
-DEF_HELPER_FLAGS_4(sve_ld1sdu_le_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ld1sds_le_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-
-DEF_HELPER_FLAGS_4(sve_ld1sdu_be_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ld1sds_be_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-
-DEF_HELPER_FLAGS_4(sve_ldff1bb_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ldff1bhu_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ldff1bsu_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ldff1bdu_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ldff1bhs_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ldff1bss_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ldff1bds_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-
-DEF_HELPER_FLAGS_4(sve_ldff1hh_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ldff1hsu_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ldff1hdu_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ldff1hss_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ldff1hds_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-
-DEF_HELPER_FLAGS_4(sve_ldff1hh_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ldff1hsu_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ldff1hdu_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ldff1hss_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ldff1hds_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-
-DEF_HELPER_FLAGS_4(sve_ldff1ss_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ldff1sdu_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ldff1sds_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-
-DEF_HELPER_FLAGS_4(sve_ldff1ss_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ldff1sdu_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ldff1sds_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-
-DEF_HELPER_FLAGS_4(sve_ldff1dd_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ldff1dd_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-
-DEF_HELPER_FLAGS_4(sve_ldff1bb_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ldff1bhu_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ldff1bsu_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ldff1bdu_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ldff1bhs_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ldff1bss_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ldff1bds_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-
-DEF_HELPER_FLAGS_4(sve_ldff1hh_le_r_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ldff1hsu_le_r_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ldff1hdu_le_r_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ldff1hss_le_r_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ldff1hds_le_r_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, tl, i32)
-
-DEF_HELPER_FLAGS_4(sve_ldff1hh_be_r_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ldff1hsu_be_r_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ldff1hdu_be_r_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ldff1hss_be_r_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ldff1hds_be_r_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, tl, i32)
-
-DEF_HELPER_FLAGS_4(sve_ldff1ss_le_r_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ldff1sdu_le_r_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ldff1sds_le_r_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, tl, i32)
-
-DEF_HELPER_FLAGS_4(sve_ldff1ss_be_r_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ldff1sdu_be_r_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ldff1sds_be_r_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, tl, i32)
-
-DEF_HELPER_FLAGS_4(sve_ldff1dd_le_r_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ldff1dd_be_r_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, tl, i32)
-
-DEF_HELPER_FLAGS_4(sve_ldnf1bb_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ldnf1bhu_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ldnf1bsu_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ldnf1bdu_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ldnf1bhs_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ldnf1bss_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ldnf1bds_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-
-DEF_HELPER_FLAGS_4(sve_ldnf1hh_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ldnf1hsu_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ldnf1hdu_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ldnf1hss_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ldnf1hds_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-
-DEF_HELPER_FLAGS_4(sve_ldnf1hh_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ldnf1hsu_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ldnf1hdu_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ldnf1hss_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ldnf1hds_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-
-DEF_HELPER_FLAGS_4(sve_ldnf1ss_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ldnf1sdu_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ldnf1sds_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-
-DEF_HELPER_FLAGS_4(sve_ldnf1ss_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ldnf1sdu_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ldnf1sds_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-
-DEF_HELPER_FLAGS_4(sve_ldnf1dd_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ldnf1dd_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-
-DEF_HELPER_FLAGS_4(sve_ldnf1bb_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ldnf1bhu_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ldnf1bsu_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ldnf1bdu_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ldnf1bhs_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ldnf1bss_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ldnf1bds_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-
-DEF_HELPER_FLAGS_4(sve_ldnf1hh_le_r_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ldnf1hsu_le_r_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ldnf1hdu_le_r_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ldnf1hss_le_r_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ldnf1hds_le_r_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, tl, i32)
-
-DEF_HELPER_FLAGS_4(sve_ldnf1hh_be_r_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ldnf1hsu_be_r_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ldnf1hdu_be_r_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ldnf1hss_be_r_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ldnf1hds_be_r_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, tl, i32)
-
-DEF_HELPER_FLAGS_4(sve_ldnf1ss_le_r_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ldnf1sdu_le_r_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ldnf1sds_le_r_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, tl, i32)
-
-DEF_HELPER_FLAGS_4(sve_ldnf1ss_be_r_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ldnf1sdu_be_r_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ldnf1sds_be_r_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, tl, i32)
-
-DEF_HELPER_FLAGS_4(sve_ldnf1dd_le_r_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_ldnf1dd_be_r_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, tl, i32)
-
-DEF_HELPER_FLAGS_4(sve_st1bb_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_st2bb_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_st3bb_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_st4bb_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-
-DEF_HELPER_FLAGS_4(sve_st1hh_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_st2hh_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_st3hh_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_st4hh_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-
-DEF_HELPER_FLAGS_4(sve_st1hh_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_st2hh_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_st3hh_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_st4hh_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-
-DEF_HELPER_FLAGS_4(sve_st1ss_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_st2ss_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_st3ss_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_st4ss_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-
-DEF_HELPER_FLAGS_4(sve_st1ss_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_st2ss_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_st3ss_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_st4ss_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-
-DEF_HELPER_FLAGS_4(sve_st1dd_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_st2dd_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_st3dd_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_st4dd_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-
-DEF_HELPER_FLAGS_4(sve_st1dd_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_st2dd_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_st3dd_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_st4dd_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-
-DEF_HELPER_FLAGS_4(sve_st1bh_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_st1bs_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_st1bd_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-
-DEF_HELPER_FLAGS_4(sve_st1hs_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_st1hd_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_st1hs_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_st1hd_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-
-DEF_HELPER_FLAGS_4(sve_st1sd_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_st1sd_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-
-DEF_HELPER_FLAGS_4(sve_st1bb_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_st2bb_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_st3bb_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_st4bb_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-
-DEF_HELPER_FLAGS_4(sve_st1hh_le_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_st2hh_le_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_st3hh_le_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_st4hh_le_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-
-DEF_HELPER_FLAGS_4(sve_st1hh_be_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_st2hh_be_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_st3hh_be_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_st4hh_be_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-
-DEF_HELPER_FLAGS_4(sve_st1ss_le_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_st2ss_le_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_st3ss_le_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_st4ss_le_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-
-DEF_HELPER_FLAGS_4(sve_st1ss_be_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_st2ss_be_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_st3ss_be_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_st4ss_be_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-
-DEF_HELPER_FLAGS_4(sve_st1dd_le_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_st2dd_le_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_st3dd_le_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_st4dd_le_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-
-DEF_HELPER_FLAGS_4(sve_st1dd_be_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_st2dd_be_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_st3dd_be_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_st4dd_be_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-
-DEF_HELPER_FLAGS_4(sve_st1bh_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_st1bs_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_st1bd_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-
-DEF_HELPER_FLAGS_4(sve_st1hs_le_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_st1hd_le_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_st1hs_be_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_st1hd_be_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-
-DEF_HELPER_FLAGS_4(sve_st1sd_le_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-DEF_HELPER_FLAGS_4(sve_st1sd_be_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
-
-DEF_HELPER_FLAGS_6(sve_ldbsu_zsu, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldhsu_le_zsu, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldhsu_be_zsu, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldss_le_zsu, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldss_be_zsu, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldbss_zsu, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldhss_le_zsu, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldhss_be_zsu, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-
-DEF_HELPER_FLAGS_6(sve_ldbsu_zss, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldhsu_le_zss, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldhsu_be_zss, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldss_le_zss, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldss_be_zss, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldbss_zss, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldhss_le_zss, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldhss_be_zss, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-
-DEF_HELPER_FLAGS_6(sve_ldbdu_zsu, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldhdu_le_zsu, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldhdu_be_zsu, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldsdu_le_zsu, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldsdu_be_zsu, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_lddd_le_zsu, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_lddd_be_zsu, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldbds_zsu, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldhds_le_zsu, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldhds_be_zsu, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldsds_le_zsu, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldsds_be_zsu, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-
-DEF_HELPER_FLAGS_6(sve_ldbdu_zss, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldhdu_le_zss, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldhdu_be_zss, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldsdu_le_zss, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldsdu_be_zss, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_lddd_le_zss, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_lddd_be_zss, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldbds_zss, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldhds_le_zss, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldhds_be_zss, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldsds_le_zss, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldsds_be_zss, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-
-DEF_HELPER_FLAGS_6(sve_ldbdu_zd, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldhdu_le_zd, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldhdu_be_zd, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldsdu_le_zd, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldsdu_be_zd, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_lddd_le_zd, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_lddd_be_zd, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldbds_zd, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldhds_le_zd, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldhds_be_zd, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldsds_le_zd, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldsds_be_zd, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-
-DEF_HELPER_FLAGS_6(sve_ldbsu_zsu_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldhsu_le_zsu_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldhsu_be_zsu_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldss_le_zsu_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldss_be_zsu_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldbss_zsu_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldhss_le_zsu_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldhss_be_zsu_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-
-DEF_HELPER_FLAGS_6(sve_ldbsu_zss_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldhsu_le_zss_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldhsu_be_zss_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldss_le_zss_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldss_be_zss_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldbss_zss_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldhss_le_zss_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldhss_be_zss_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-
-DEF_HELPER_FLAGS_6(sve_ldbdu_zsu_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldhdu_le_zsu_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldhdu_be_zsu_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldsdu_le_zsu_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldsdu_be_zsu_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_lddd_le_zsu_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_lddd_be_zsu_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldbds_zsu_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldhds_le_zsu_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldhds_be_zsu_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldsds_le_zsu_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldsds_be_zsu_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-
-DEF_HELPER_FLAGS_6(sve_ldbdu_zss_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldhdu_le_zss_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldhdu_be_zss_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldsdu_le_zss_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldsdu_be_zss_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_lddd_le_zss_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_lddd_be_zss_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldbds_zss_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldhds_le_zss_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldhds_be_zss_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldsds_le_zss_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldsds_be_zss_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-
-DEF_HELPER_FLAGS_6(sve_ldbdu_zd_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldhdu_le_zd_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldhdu_be_zd_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldsdu_le_zd_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldsdu_be_zd_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_lddd_le_zd_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_lddd_be_zd_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldbds_zd_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldhds_le_zd_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldhds_be_zd_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldsds_le_zd_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldsds_be_zd_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-
-DEF_HELPER_FLAGS_6(sve_ldffbsu_zsu, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldffhsu_le_zsu, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldffhsu_be_zsu, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldffss_le_zsu, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldffss_be_zsu, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldffbss_zsu, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldffhss_le_zsu, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldffhss_be_zsu, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-
-DEF_HELPER_FLAGS_6(sve_ldffbsu_zss, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldffhsu_le_zss, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldffhsu_be_zss, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldffss_le_zss, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldffss_be_zss, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldffbss_zss, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldffhss_le_zss, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldffhss_be_zss, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-
-DEF_HELPER_FLAGS_6(sve_ldffbdu_zsu, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldffhdu_le_zsu, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldffhdu_be_zsu, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldffsdu_le_zsu, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldffsdu_be_zsu, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldffdd_le_zsu, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldffdd_be_zsu, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldffbds_zsu, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldffhds_le_zsu, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldffhds_be_zsu, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldffsds_le_zsu, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldffsds_be_zsu, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-
-DEF_HELPER_FLAGS_6(sve_ldffbdu_zss, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldffhdu_le_zss, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldffhdu_be_zss, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldffsdu_le_zss, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldffsdu_be_zss, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldffdd_le_zss, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldffdd_be_zss, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldffbds_zss, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldffhds_le_zss, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldffhds_be_zss, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldffsds_le_zss, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldffsds_be_zss, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-
-DEF_HELPER_FLAGS_6(sve_ldffbdu_zd, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldffhdu_le_zd, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldffhdu_be_zd, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldffsdu_le_zd, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldffsdu_be_zd, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldffdd_le_zd, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldffdd_be_zd, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldffbds_zd, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldffhds_le_zd, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldffhds_be_zd, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldffsds_le_zd, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldffsds_be_zd, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-
-DEF_HELPER_FLAGS_6(sve_ldffbsu_zsu_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldffhsu_le_zsu_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldffhsu_be_zsu_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldffss_le_zsu_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldffss_be_zsu_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldffbss_zsu_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldffhss_le_zsu_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldffhss_be_zsu_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-
-DEF_HELPER_FLAGS_6(sve_ldffbsu_zss_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldffhsu_le_zss_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldffhsu_be_zss_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldffss_le_zss_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldffss_be_zss_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldffbss_zss_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldffhss_le_zss_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldffhss_be_zss_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-
-DEF_HELPER_FLAGS_6(sve_ldffbdu_zsu_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldffhdu_le_zsu_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldffhdu_be_zsu_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldffsdu_le_zsu_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldffsdu_be_zsu_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldffdd_le_zsu_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldffdd_be_zsu_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldffbds_zsu_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldffhds_le_zsu_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldffhds_be_zsu_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldffsds_le_zsu_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldffsds_be_zsu_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-
-DEF_HELPER_FLAGS_6(sve_ldffbdu_zss_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldffhdu_le_zss_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldffhdu_be_zss_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldffsdu_le_zss_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldffsdu_be_zss_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldffdd_le_zss_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldffdd_be_zss_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldffbds_zss_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldffhds_le_zss_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldffhds_be_zss_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldffsds_le_zss_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldffsds_be_zss_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-
-DEF_HELPER_FLAGS_6(sve_ldffbdu_zd_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldffhdu_le_zd_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldffhdu_be_zd_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldffsdu_le_zd_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldffsdu_be_zd_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldffdd_le_zd_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldffdd_be_zd_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldffbds_zd_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldffhds_le_zd_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldffhds_be_zd_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldffsds_le_zd_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_ldffsds_be_zd_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-
-DEF_HELPER_FLAGS_6(sve_stbs_zsu, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_sths_le_zsu, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_sths_be_zsu, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_stss_le_zsu, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_stss_be_zsu, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-
-DEF_HELPER_FLAGS_6(sve_stbs_zss, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_sths_le_zss, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_sths_be_zss, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_stss_le_zss, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_stss_be_zss, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-
-DEF_HELPER_FLAGS_6(sve_stbd_zsu, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_sthd_le_zsu, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_sthd_be_zsu, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_stsd_le_zsu, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_stsd_be_zsu, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_stdd_le_zsu, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_stdd_be_zsu, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-
-DEF_HELPER_FLAGS_6(sve_stbd_zss, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_sthd_le_zss, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_sthd_be_zss, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_stsd_le_zss, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_stsd_be_zss, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_stdd_le_zss, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_stdd_be_zss, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-
-DEF_HELPER_FLAGS_6(sve_stbd_zd, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_sthd_le_zd, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_sthd_be_zd, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_stsd_le_zd, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_stsd_be_zd, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_stdd_le_zd, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_stdd_be_zd, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-
-DEF_HELPER_FLAGS_6(sve_stbs_zsu_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_sths_le_zsu_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_sths_be_zsu_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_stss_le_zsu_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_stss_be_zsu_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-
-DEF_HELPER_FLAGS_6(sve_stbs_zss_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_sths_le_zss_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_sths_be_zss_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_stss_le_zss_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_stss_be_zss_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-
-DEF_HELPER_FLAGS_6(sve_stbd_zsu_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_sthd_le_zsu_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_sthd_be_zsu_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_stsd_le_zsu_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_stsd_be_zsu_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_stdd_le_zsu_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_stdd_be_zsu_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-
-DEF_HELPER_FLAGS_6(sve_stbd_zss_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_sthd_le_zss_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_sthd_be_zss_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_stsd_le_zss_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_stsd_be_zss_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_stdd_le_zss_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_stdd_be_zss_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-
-DEF_HELPER_FLAGS_6(sve_stbd_zd_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_sthd_le_zd_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_sthd_be_zd_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_stsd_le_zd_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_stsd_be_zd_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_stdd_le_zd_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
-DEF_HELPER_FLAGS_6(sve_stdd_be_zd_mte, TCG_CALL_NO_WG,
-                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_5(sve_ld1bb_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_5(sve_ld2bb_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_5(sve_ld3bb_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_5(sve_ld4bb_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32, i32)
+
+DEF_HELPER_FLAGS_5(sve_ld1hh_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_5(sve_ld2hh_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_5(sve_ld3hh_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_5(sve_ld4hh_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32, i32)
+
+DEF_HELPER_FLAGS_5(sve_ld1hh_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_5(sve_ld2hh_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_5(sve_ld3hh_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_5(sve_ld4hh_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32, i32)
+
+DEF_HELPER_FLAGS_5(sve_ld1ss_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_5(sve_ld2ss_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_5(sve_ld3ss_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_5(sve_ld4ss_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32, i32)
+
+DEF_HELPER_FLAGS_5(sve_ld1ss_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_5(sve_ld2ss_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_5(sve_ld3ss_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_5(sve_ld4ss_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32, i32)
+
+DEF_HELPER_FLAGS_5(sve_ld1dd_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_5(sve_ld2dd_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_5(sve_ld3dd_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_5(sve_ld4dd_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32, i32)
+
+DEF_HELPER_FLAGS_5(sve_ld1dd_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_5(sve_ld2dd_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_5(sve_ld3dd_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_5(sve_ld4dd_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32, i32)
+
+DEF_HELPER_FLAGS_5(sve_ld1bhu_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_5(sve_ld1bsu_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_5(sve_ld1bdu_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_5(sve_ld1bhs_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_5(sve_ld1bss_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_5(sve_ld1bds_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32, i32)
+
+DEF_HELPER_FLAGS_5(sve_ld1hsu_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_5(sve_ld1hdu_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_5(sve_ld1hss_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_5(sve_ld1hds_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32, i32)
+
+DEF_HELPER_FLAGS_5(sve_ld1hsu_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_5(sve_ld1hdu_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_5(sve_ld1hss_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_5(sve_ld1hds_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32, i32)
+
+DEF_HELPER_FLAGS_5(sve_ld1sdu_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_5(sve_ld1sds_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32, i32)
+
+DEF_HELPER_FLAGS_5(sve_ld1sdu_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_5(sve_ld1sds_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32, i32)
+
+DEF_HELPER_FLAGS_5(sve_ldff1bb_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_5(sve_ldff1bhu_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_5(sve_ldff1bsu_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_5(sve_ldff1bdu_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_5(sve_ldff1bhs_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_5(sve_ldff1bss_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_5(sve_ldff1bds_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32, i32)
+
+DEF_HELPER_FLAGS_5(sve_ldff1hh_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_5(sve_ldff1hsu_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_5(sve_ldff1hdu_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_5(sve_ldff1hss_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_5(sve_ldff1hds_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32, i32)
+
+DEF_HELPER_FLAGS_5(sve_ldff1hh_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_5(sve_ldff1hsu_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_5(sve_ldff1hdu_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_5(sve_ldff1hss_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_5(sve_ldff1hds_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32, i32)
+
+DEF_HELPER_FLAGS_5(sve_ldff1ss_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_5(sve_ldff1sdu_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_5(sve_ldff1sds_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32, i32)
+
+DEF_HELPER_FLAGS_5(sve_ldff1ss_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_5(sve_ldff1sdu_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_5(sve_ldff1sds_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32, i32)
+
+DEF_HELPER_FLAGS_5(sve_ldff1dd_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_5(sve_ldff1dd_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32, i32)
+
+DEF_HELPER_FLAGS_5(sve_ldnf1bb_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_5(sve_ldnf1bhu_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_5(sve_ldnf1bsu_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_5(sve_ldnf1bdu_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_5(sve_ldnf1bhs_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_5(sve_ldnf1bss_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_5(sve_ldnf1bds_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32, i32)
+
+DEF_HELPER_FLAGS_5(sve_ldnf1hh_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_5(sve_ldnf1hsu_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_5(sve_ldnf1hdu_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_5(sve_ldnf1hss_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_5(sve_ldnf1hds_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32, i32)
+
+DEF_HELPER_FLAGS_5(sve_ldnf1hh_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_5(sve_ldnf1hsu_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_5(sve_ldnf1hdu_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_5(sve_ldnf1hss_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_5(sve_ldnf1hds_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32, i32)
+
+DEF_HELPER_FLAGS_5(sve_ldnf1ss_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_5(sve_ldnf1sdu_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_5(sve_ldnf1sds_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32, i32)
+
+DEF_HELPER_FLAGS_5(sve_ldnf1ss_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_5(sve_ldnf1sdu_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_5(sve_ldnf1sds_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32, i32)
+
+DEF_HELPER_FLAGS_5(sve_ldnf1dd_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_5(sve_ldnf1dd_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32, i32)
+
+DEF_HELPER_FLAGS_5(sve_st1bb_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_5(sve_st2bb_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_5(sve_st3bb_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_5(sve_st4bb_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32, i32)
+
+DEF_HELPER_FLAGS_5(sve_st1hh_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_5(sve_st2hh_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_5(sve_st3hh_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_5(sve_st4hh_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32, i32)
+
+DEF_HELPER_FLAGS_5(sve_st1hh_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_5(sve_st2hh_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_5(sve_st3hh_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_5(sve_st4hh_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32, i32)
+
+DEF_HELPER_FLAGS_5(sve_st1ss_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_5(sve_st2ss_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_5(sve_st3ss_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_5(sve_st4ss_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32, i32)
+
+DEF_HELPER_FLAGS_5(sve_st1ss_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_5(sve_st2ss_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_5(sve_st3ss_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_5(sve_st4ss_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32, i32)
+
+DEF_HELPER_FLAGS_5(sve_st1dd_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_5(sve_st2dd_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_5(sve_st3dd_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_5(sve_st4dd_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32, i32)
+
+DEF_HELPER_FLAGS_5(sve_st1dd_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_5(sve_st2dd_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_5(sve_st3dd_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_5(sve_st4dd_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32, i32)
+
+DEF_HELPER_FLAGS_5(sve_st1bh_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_5(sve_st1bs_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_5(sve_st1bd_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32, i32)
+
+DEF_HELPER_FLAGS_5(sve_st1hs_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_5(sve_st1hd_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_5(sve_st1hs_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_5(sve_st1hd_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32, i32)
+
+DEF_HELPER_FLAGS_5(sve_st1sd_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_5(sve_st1sd_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32, i32)
+
+DEF_HELPER_FLAGS_7(sve_ldbsu_zsu, TCG_CALL_NO_WG, void, env, ptr, ptr, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_7(sve_ldhsu_le_zsu, TCG_CALL_NO_WG, void, env, ptr, ptr, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_7(sve_ldhsu_be_zsu, TCG_CALL_NO_WG, void, env, ptr, ptr, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_7(sve_ldss_le_zsu, TCG_CALL_NO_WG, void, env, ptr, ptr, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_7(sve_ldss_be_zsu, TCG_CALL_NO_WG, void, env, ptr, ptr, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_7(sve_ldbss_zsu, TCG_CALL_NO_WG, void, env, ptr, ptr, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_7(sve_ldhss_le_zsu, TCG_CALL_NO_WG, void, env, ptr, ptr, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_7(sve_ldhss_be_zsu, TCG_CALL_NO_WG, void, env, ptr, ptr, ptr, tl, i32, i32)
+
+DEF_HELPER_FLAGS_7(sve_ldbsu_zss, TCG_CALL_NO_WG, void, env, ptr, ptr, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_7(sve_ldhsu_le_zss, TCG_CALL_NO_WG, void, env, ptr, ptr, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_7(sve_ldhsu_be_zss, TCG_CALL_NO_WG, void, env, ptr, ptr, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_7(sve_ldss_le_zss, TCG_CALL_NO_WG, void, env, ptr, ptr, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_7(sve_ldss_be_zss, TCG_CALL_NO_WG, void, env, ptr, ptr, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_7(sve_ldbss_zss, TCG_CALL_NO_WG, void, env, ptr, ptr, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_7(sve_ldhss_le_zss, TCG_CALL_NO_WG, void, env, ptr, ptr, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_7(sve_ldhss_be_zss, TCG_CALL_NO_WG, void, env, ptr, ptr, ptr, tl, i32, i32)
+
+DEF_HELPER_FLAGS_7(sve_ldbdu_zsu, TCG_CALL_NO_WG, void, env, ptr, ptr, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_7(sve_ldhdu_le_zsu, TCG_CALL_NO_WG, void, env, ptr, ptr, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_7(sve_ldhdu_be_zsu, TCG_CALL_NO_WG, void, env, ptr, ptr, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_7(sve_ldsdu_le_zsu, TCG_CALL_NO_WG, void, env, ptr, ptr, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_7(sve_ldsdu_be_zsu, TCG_CALL_NO_WG, void, env, ptr, ptr, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_7(sve_lddd_le_zsu, TCG_CALL_NO_WG, void, env, ptr, ptr, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_7(sve_lddd_be_zsu, TCG_CALL_NO_WG, void, env, ptr, ptr, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_7(sve_ldbds_zsu, TCG_CALL_NO_WG, void, env, ptr, ptr, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_7(sve_ldhds_le_zsu, TCG_CALL_NO_WG, void, env, ptr, ptr, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_7(sve_ldhds_be_zsu, TCG_CALL_NO_WG, void, env, ptr, ptr, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_7(sve_ldsds_le_zsu, TCG_CALL_NO_WG, void, env, ptr, ptr, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_7(sve_ldsds_be_zsu, TCG_CALL_NO_WG, void, env, ptr, ptr, ptr, tl, i32, i32)
+
+DEF_HELPER_FLAGS_7(sve_ldbdu_zss, TCG_CALL_NO_WG, void, env, ptr, ptr, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_7(sve_ldhdu_le_zss, TCG_CALL_NO_WG, void, env, ptr, ptr, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_7(sve_ldhdu_be_zss, TCG_CALL_NO_WG, void, env, ptr, ptr, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_7(sve_ldsdu_le_zss, TCG_CALL_NO_WG, void, env, ptr, ptr, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_7(sve_ldsdu_be_zss, TCG_CALL_NO_WG, void, env, ptr, ptr, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_7(sve_lddd_le_zss, TCG_CALL_NO_WG, void, env, ptr, ptr, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_7(sve_lddd_be_zss, TCG_CALL_NO_WG, void, env, ptr, ptr, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_7(sve_ldbds_zss, TCG_CALL_NO_WG, void, env, ptr, ptr, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_7(sve_ldhds_le_zss, TCG_CALL_NO_WG, void, env, ptr, ptr, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_7(sve_ldhds_be_zss, TCG_CALL_NO_WG, void, env, ptr, ptr, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_7(sve_ldsds_le_zss, TCG_CALL_NO_WG, void, env, ptr, ptr, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_7(sve_ldsds_be_zss, TCG_CALL_NO_WG, void, env, ptr, ptr, ptr, tl, i32, i32)
+
+DEF_HELPER_FLAGS_7(sve_ldbdu_zd, TCG_CALL_NO_WG, void, env, ptr, ptr, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_7(sve_ldhdu_le_zd, TCG_CALL_NO_WG, void, env, ptr, ptr, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_7(sve_ldhdu_be_zd, TCG_CALL_NO_WG, void, env, ptr, ptr, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_7(sve_ldsdu_le_zd, TCG_CALL_NO_WG, void, env, ptr, ptr, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_7(sve_ldsdu_be_zd, TCG_CALL_NO_WG, void, env, ptr, ptr, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_7(sve_lddd_le_zd, TCG_CALL_NO_WG, void, env, ptr, ptr, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_7(sve_lddd_be_zd, TCG_CALL_NO_WG, void, env, ptr, ptr, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_7(sve_ldbds_zd, TCG_CALL_NO_WG, void, env, ptr, ptr, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_7(sve_ldhds_le_zd, TCG_CALL_NO_WG, void, env, ptr, ptr, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_7(sve_ldhds_be_zd, TCG_CALL_NO_WG, void, env, ptr, ptr, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_7(sve_ldsds_le_zd, TCG_CALL_NO_WG, void, env, ptr, ptr, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_7(sve_ldsds_be_zd, TCG_CALL_NO_WG, void, env, ptr, ptr, ptr, tl, i32, i32)
+
+DEF_HELPER_FLAGS_7(sve_ldffbsu_zsu, TCG_CALL_NO_WG, void, env, ptr, ptr, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_7(sve_ldffhsu_le_zsu, TCG_CALL_NO_WG, void, env, ptr, ptr, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_7(sve_ldffhsu_be_zsu, TCG_CALL_NO_WG, void, env, ptr, ptr, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_7(sve_ldffss_le_zsu, TCG_CALL_NO_WG, void, env, ptr, ptr, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_7(sve_ldffss_be_zsu, TCG_CALL_NO_WG, void, env, ptr, ptr, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_7(sve_ldffbss_zsu, TCG_CALL_NO_WG, void, env, ptr, ptr, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_7(sve_ldffhss_le_zsu, TCG_CALL_NO_WG, void, env, ptr, ptr, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_7(sve_ldffhss_be_zsu, TCG_CALL_NO_WG, void, env, ptr, ptr, ptr, tl, i32, i32)
+
+DEF_HELPER_FLAGS_7(sve_ldffbsu_zss, TCG_CALL_NO_WG, void, env, ptr, ptr, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_7(sve_ldffhsu_le_zss, TCG_CALL_NO_WG, void, env, ptr, ptr, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_7(sve_ldffhsu_be_zss, TCG_CALL_NO_WG, void, env, ptr, ptr, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_7(sve_ldffss_le_zss, TCG_CALL_NO_WG, void, env, ptr, ptr, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_7(sve_ldffss_be_zss, TCG_CALL_NO_WG, void, env, ptr, ptr, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_7(sve_ldffbss_zss, TCG_CALL_NO_WG, void, env, ptr, ptr, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_7(sve_ldffhss_le_zss, TCG_CALL_NO_WG, void, env, ptr, ptr, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_7(sve_ldffhss_be_zss, TCG_CALL_NO_WG, void, env, ptr, ptr, ptr, tl, i32, i32)
+
+DEF_HELPER_FLAGS_7(sve_ldffbdu_zsu, TCG_CALL_NO_WG, void, env, ptr, ptr, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_7(sve_ldffhdu_le_zsu, TCG_CALL_NO_WG, void, env, ptr, ptr, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_7(sve_ldffhdu_be_zsu, TCG_CALL_NO_WG, void, env, ptr, ptr, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_7(sve_ldffsdu_le_zsu, TCG_CALL_NO_WG, void, env, ptr, ptr, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_7(sve_ldffsdu_be_zsu, TCG_CALL_NO_WG, void, env, ptr, ptr, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_7(sve_ldffdd_le_zsu, TCG_CALL_NO_WG, void, env, ptr, ptr, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_7(sve_ldffdd_be_zsu, TCG_CALL_NO_WG, void, env, ptr, ptr, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_7(sve_ldffbds_zsu, TCG_CALL_NO_WG, void, env, ptr, ptr, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_7(sve_ldffhds_le_zsu, TCG_CALL_NO_WG, void, env, ptr, ptr, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_7(sve_ldffhds_be_zsu, TCG_CALL_NO_WG, void, env, ptr, ptr, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_7(sve_ldffsds_le_zsu, TCG_CALL_NO_WG, void, env, ptr, ptr, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_7(sve_ldffsds_be_zsu, TCG_CALL_NO_WG, void, env, ptr, ptr, ptr, tl, i32, i32)
+
+DEF_HELPER_FLAGS_7(sve_ldffbdu_zss, TCG_CALL_NO_WG, void, env, ptr, ptr, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_7(sve_ldffhdu_le_zss, TCG_CALL_NO_WG, void, env, ptr, ptr, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_7(sve_ldffhdu_be_zss, TCG_CALL_NO_WG, void, env, ptr, ptr, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_7(sve_ldffsdu_le_zss, TCG_CALL_NO_WG, void, env, ptr, ptr, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_7(sve_ldffsdu_be_zss, TCG_CALL_NO_WG, void, env, ptr, ptr, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_7(sve_ldffdd_le_zss, TCG_CALL_NO_WG, void, env, ptr, ptr, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_7(sve_ldffdd_be_zss, TCG_CALL_NO_WG, void, env, ptr, ptr, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_7(sve_ldffbds_zss, TCG_CALL_NO_WG, void, env, ptr, ptr, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_7(sve_ldffhds_le_zss, TCG_CALL_NO_WG, void, env, ptr, ptr, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_7(sve_ldffhds_be_zss, TCG_CALL_NO_WG, void, env, ptr, ptr, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_7(sve_ldffsds_le_zss, TCG_CALL_NO_WG, void, env, ptr, ptr, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_7(sve_ldffsds_be_zss, TCG_CALL_NO_WG, void, env, ptr, ptr, ptr, tl, i32, i32)
+
+DEF_HELPER_FLAGS_7(sve_ldffbdu_zd, TCG_CALL_NO_WG, void, env, ptr, ptr, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_7(sve_ldffhdu_le_zd, TCG_CALL_NO_WG, void, env, ptr, ptr, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_7(sve_ldffhdu_be_zd, TCG_CALL_NO_WG, void, env, ptr, ptr, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_7(sve_ldffsdu_le_zd, TCG_CALL_NO_WG, void, env, ptr, ptr, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_7(sve_ldffsdu_be_zd, TCG_CALL_NO_WG, void, env, ptr, ptr, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_7(sve_ldffdd_le_zd, TCG_CALL_NO_WG, void, env, ptr, ptr, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_7(sve_ldffdd_be_zd, TCG_CALL_NO_WG, void, env, ptr, ptr, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_7(sve_ldffbds_zd, TCG_CALL_NO_WG, void, env, ptr, ptr, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_7(sve_ldffhds_le_zd, TCG_CALL_NO_WG, void, env, ptr, ptr, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_7(sve_ldffhds_be_zd, TCG_CALL_NO_WG, void, env, ptr, ptr, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_7(sve_ldffsds_le_zd, TCG_CALL_NO_WG, void, env, ptr, ptr, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_7(sve_ldffsds_be_zd, TCG_CALL_NO_WG, void, env, ptr, ptr, ptr, tl, i32, i32)
+
+DEF_HELPER_FLAGS_7(sve_stbs_zsu, TCG_CALL_NO_WG, void, env, ptr, ptr, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_7(sve_sths_le_zsu, TCG_CALL_NO_WG, void, env, ptr, ptr, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_7(sve_sths_be_zsu, TCG_CALL_NO_WG, void, env, ptr, ptr, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_7(sve_stss_le_zsu, TCG_CALL_NO_WG, void, env, ptr, ptr, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_7(sve_stss_be_zsu, TCG_CALL_NO_WG, void, env, ptr, ptr, ptr, tl, i32, i32)
+
+DEF_HELPER_FLAGS_7(sve_stbs_zss, TCG_CALL_NO_WG, void, env, ptr, ptr, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_7(sve_sths_le_zss, TCG_CALL_NO_WG, void, env, ptr, ptr, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_7(sve_sths_be_zss, TCG_CALL_NO_WG, void, env, ptr, ptr, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_7(sve_stss_le_zss, TCG_CALL_NO_WG, void, env, ptr, ptr, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_7(sve_stss_be_zss, TCG_CALL_NO_WG, void, env, ptr, ptr, ptr, tl, i32, i32)
+
+DEF_HELPER_FLAGS_7(sve_stbd_zsu, TCG_CALL_NO_WG, void, env, ptr, ptr, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_7(sve_sthd_le_zsu, TCG_CALL_NO_WG, void, env, ptr, ptr, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_7(sve_sthd_be_zsu, TCG_CALL_NO_WG, void, env, ptr, ptr, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_7(sve_stsd_le_zsu, TCG_CALL_NO_WG, void, env, ptr, ptr, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_7(sve_stsd_be_zsu, TCG_CALL_NO_WG, void, env, ptr, ptr, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_7(sve_stdd_le_zsu, TCG_CALL_NO_WG, void, env, ptr, ptr, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_7(sve_stdd_be_zsu, TCG_CALL_NO_WG, void, env, ptr, ptr, ptr, tl, i32, i32)
+
+DEF_HELPER_FLAGS_7(sve_stbd_zss, TCG_CALL_NO_WG, void, env, ptr, ptr, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_7(sve_sthd_le_zss, TCG_CALL_NO_WG, void, env, ptr, ptr, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_7(sve_sthd_be_zss, TCG_CALL_NO_WG, void, env, ptr, ptr, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_7(sve_stsd_le_zss, TCG_CALL_NO_WG, void, env, ptr, ptr, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_7(sve_stsd_be_zss, TCG_CALL_NO_WG, void, env, ptr, ptr, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_7(sve_stdd_le_zss, TCG_CALL_NO_WG, void, env, ptr, ptr, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_7(sve_stdd_be_zss, TCG_CALL_NO_WG, void, env, ptr, ptr, ptr, tl, i32, i32)
+
+DEF_HELPER_FLAGS_7(sve_stbd_zd, TCG_CALL_NO_WG, void, env, ptr, ptr, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_7(sve_sthd_le_zd, TCG_CALL_NO_WG, void, env, ptr, ptr, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_7(sve_sthd_be_zd, TCG_CALL_NO_WG, void, env, ptr, ptr, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_7(sve_stsd_le_zd, TCG_CALL_NO_WG, void, env, ptr, ptr, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_7(sve_stsd_be_zd, TCG_CALL_NO_WG, void, env, ptr, ptr, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_7(sve_stdd_le_zd, TCG_CALL_NO_WG, void, env, ptr, ptr, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_7(sve_stdd_be_zd, TCG_CALL_NO_WG, void, env, ptr, ptr, ptr, tl, i32, i32)
 
 DEF_HELPER_FLAGS_4(sve2_sqdmull_zzz_h, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, i32)
diff --git a/target/arm/tcg/sme_helper.c b/target/arm/tcg/sme_helper.c
index b3e0ba9b29..db283804c4 100644
--- a/target/arm/tcg/sme_helper.c
+++ b/target/arm/tcg/sme_helper.c
@@ -431,8 +431,8 @@ DO_STQ(sve_st1qq_le, sme_st1q_le, 0, stq_le_p, cpu_stq_le_data_ra)
 
 static inline QEMU_ALWAYS_INLINE
 void sme_ld1(CPUARMState *env, void *za, uint64_t *vg,
-             const target_ulong addr, uint32_t desc, const uintptr_t ra,
-             const int esz, uint32_t mtedesc, bool vertical,
+             const target_ulong addr, uint32_t desc, uint32_t mtedesc,
+             const uintptr_t ra, const int esz, bool vertical,
              sve_ldst1_host_fn *host_fn,
              sve_ldst1_tlb_fn *tlb_fn,
              ClearFn *clr_fn,
@@ -550,52 +550,22 @@ void sme_ld1(CPUARMState *env, void *za, uint64_t *vg,
     }
 }
 
-static inline QEMU_ALWAYS_INLINE
-void sme_ld1_mte(CPUARMState *env, void *za, uint64_t *vg,
-                 target_ulong addr, uint32_t desc, uintptr_t ra,
-                 const int esz, bool vertical,
-                 sve_ldst1_host_fn *host_fn,
-                 sve_ldst1_tlb_fn *tlb_fn,
-                 ClearFn *clr_fn,
-                 CopyFn *cpy_fn)
-{
-    uint32_t mtedesc = desc >> (SIMD_DATA_SHIFT + SVE_MTEDESC_SHIFT);
-
-    /* Remove mtedesc from the normal sve descriptor. */
-    desc = extract32(desc, 0, SIMD_DATA_SHIFT + SVE_MTEDESC_SHIFT);
-
-    sme_ld1(env, za, vg, addr, desc, ra, esz, mtedesc, vertical,
-            host_fn, tlb_fn, clr_fn, cpy_fn);
-}
-
-#define DO_LD(L, END, ESZ)                                                 \
-void HELPER(sme_ld1##L##END##_h)(CPUARMState *env, void *za, void *vg,     \
-                                 target_ulong addr, uint32_t desc)         \
-{                                                                          \
-    sme_ld1(env, za, vg, addr, desc, GETPC(), ESZ, 0, false,               \
-            sve_ld1##L##L##END##_host, sve_ld1##L##L##END##_tlb,           \
-            clear_horizontal, copy_horizontal);                            \
-}                                                                          \
-void HELPER(sme_ld1##L##END##_v)(CPUARMState *env, void *za, void *vg,     \
-                                 target_ulong addr, uint32_t desc)         \
-{                                                                          \
-    sme_ld1(env, za, vg, addr, desc, GETPC(), ESZ, 0, true,                \
-            sme_ld1##L##END##_v_host, sme_ld1##L##END##_v_tlb,             \
-            clear_vertical_##L, copy_vertical_##L);                        \
-}                                                                          \
-void HELPER(sme_ld1##L##END##_h_mte)(CPUARMState *env, void *za, void *vg, \
-                                     target_ulong addr, uint32_t desc)     \
-{                                                                          \
-    sme_ld1_mte(env, za, vg, addr, desc, GETPC(), ESZ, false,              \
-                sve_ld1##L##L##END##_host, sve_ld1##L##L##END##_tlb,       \
-                clear_horizontal, copy_horizontal);                        \
-}                                                                          \
-void HELPER(sme_ld1##L##END##_v_mte)(CPUARMState *env, void *za, void *vg, \
-                                     target_ulong addr, uint32_t desc)     \
-{                                                                          \
-    sme_ld1_mte(env, za, vg, addr, desc, GETPC(), ESZ, true,               \
-                sme_ld1##L##END##_v_host, sme_ld1##L##END##_v_tlb,         \
-                clear_vertical_##L, copy_vertical_##L);                    \
+#define DO_LD(L, END, ESZ)                                              \
+void HELPER(sme_ld1##L##END##_h)(CPUARMState *env, void *za, void *vg,  \
+                                 target_ulong addr, uint32_t desc,      \
+                                 uint32_t mtedesc)                      \
+{                                                                       \
+    sme_ld1(env, za, vg, addr, desc, mtedesc, GETPC(), ESZ, false,      \
+            sve_ld1##L##L##END##_host, sve_ld1##L##L##END##_tlb,        \
+            clear_horizontal, copy_horizontal);                         \
+}                                                                       \
+void HELPER(sme_ld1##L##END##_v)(CPUARMState *env, void *za, void *vg,  \
+                                 target_ulong addr, uint32_t desc,      \
+                                 uint32_t mtedesc)                      \
+{                                                                       \
+    sme_ld1(env, za, vg, addr, desc, mtedesc, GETPC(), ESZ, true,       \
+            sme_ld1##L##END##_v_host, sme_ld1##L##END##_v_tlb,          \
+            clear_vertical_##L, copy_vertical_##L);                     \
 }
 
 DO_LD(b, , MO_8)
@@ -616,8 +586,8 @@ DO_LD(q, _le, MO_128)
 
 static inline QEMU_ALWAYS_INLINE
 void sme_st1(CPUARMState *env, void *za, uint64_t *vg,
-             const target_ulong addr, uint32_t desc, const uintptr_t ra,
-             const int esz, uint32_t mtedesc, bool vertical,
+             const target_ulong addr, uint32_t desc, uint32_t mtedesc,
+             const uintptr_t ra, const int esz, bool vertical,
              sve_ldst1_host_fn *host_fn,
              sve_ldst1_tlb_fn *tlb_fn)
 {
@@ -716,45 +686,20 @@ void sme_st1(CPUARMState *env, void *za, uint64_t *vg,
     }
 }
 
-static inline QEMU_ALWAYS_INLINE
-void sme_st1_mte(CPUARMState *env, void *za, uint64_t *vg, target_ulong addr,
-                 uint32_t desc, uintptr_t ra, int esz, bool vertical,
-                 sve_ldst1_host_fn *host_fn,
-                 sve_ldst1_tlb_fn *tlb_fn)
-{
-    uint32_t mtedesc = desc >> (SIMD_DATA_SHIFT + SVE_MTEDESC_SHIFT);
-
-    /* Remove mtedesc from the normal sve descriptor. */
-    desc = extract32(desc, 0, SIMD_DATA_SHIFT + SVE_MTEDESC_SHIFT);
-
-    sme_st1(env, za, vg, addr, desc, ra, esz, mtedesc,
-            vertical, host_fn, tlb_fn);
-}
-
-#define DO_ST(L, END, ESZ)                                                 \
-void HELPER(sme_st1##L##END##_h)(CPUARMState *env, void *za, void *vg,     \
-                                 target_ulong addr, uint32_t desc)         \
-{                                                                          \
-    sme_st1(env, za, vg, addr, desc, GETPC(), ESZ, 0, false,               \
-            sve_st1##L##L##END##_host, sve_st1##L##L##END##_tlb);          \
-}                                                                          \
-void HELPER(sme_st1##L##END##_v)(CPUARMState *env, void *za, void *vg,     \
-                                 target_ulong addr, uint32_t desc)         \
-{                                                                          \
-    sme_st1(env, za, vg, addr, desc, GETPC(), ESZ, 0, true,                \
-            sme_st1##L##END##_v_host, sme_st1##L##END##_v_tlb);            \
-}                                                                          \
-void HELPER(sme_st1##L##END##_h_mte)(CPUARMState *env, void *za, void *vg, \
-                                     target_ulong addr, uint32_t desc)     \
-{                                                                          \
-    sme_st1_mte(env, za, vg, addr, desc, GETPC(), ESZ, false,              \
-                sve_st1##L##L##END##_host, sve_st1##L##L##END##_tlb);      \
-}                                                                          \
-void HELPER(sme_st1##L##END##_v_mte)(CPUARMState *env, void *za, void *vg, \
-                                     target_ulong addr, uint32_t desc)     \
-{                                                                          \
-    sme_st1_mte(env, za, vg, addr, desc, GETPC(), ESZ, true,               \
-                sme_st1##L##END##_v_host, sme_st1##L##END##_v_tlb);        \
+#define DO_ST(L, END, ESZ)                                              \
+void HELPER(sme_st1##L##END##_h)(CPUARMState *env, void *za, void *vg,  \
+                                 target_ulong addr, uint32_t desc,      \
+                                 uint32_t mtedesc)                      \
+{                                                                       \
+    sme_st1(env, za, vg, addr, desc, mtedesc, GETPC(), ESZ, false,      \
+            sve_st1##L##L##END##_host, sve_st1##L##L##END##_tlb);       \
+}                                                                       \
+void HELPER(sme_st1##L##END##_v)(CPUARMState *env, void *za, void *vg,  \
+                                 target_ulong addr, uint32_t desc,      \
+                                 uint32_t mtedesc)                      \
+{                                                                       \
+    sme_st1(env, za, vg, addr, mtedesc, desc, GETPC(), ESZ, true,       \
+            sme_st1##L##END##_v_host, sme_st1##L##END##_v_tlb);         \
 }
 
 DO_ST(b, , MO_8)
diff --git a/target/arm/tcg/sve_helper.c b/target/arm/tcg/sve_helper.c
index 9fd469b00f..214faa5702 100644
--- a/target/arm/tcg/sve_helper.c
+++ b/target/arm/tcg/sve_helper.c
@@ -5656,8 +5656,8 @@ void sve_cont_ldst_mte_check(SVEContLdSt *info, CPUARMState *env,
  */
 static inline QEMU_ALWAYS_INLINE
 void sve_ldN_r(CPUARMState *env, uint64_t *vg, const target_ulong addr,
-               uint32_t desc, const uintptr_t retaddr,
-               const int esz, const int msz, const int N, uint32_t mtedesc,
+               uint32_t desc, uint32_t mtedesc, const uintptr_t retaddr,
+               const int esz, const int msz, const int N,
                sve_ldst1_host_fn *host_fn,
                sve_ldst1_tlb_fn *tlb_fn)
 {
@@ -5788,59 +5788,28 @@ void sve_ldN_r(CPUARMState *env, uint64_t *vg, const target_ulong addr,
     }
 }
 
-static inline QEMU_ALWAYS_INLINE
-void sve_ldN_r_mte(CPUARMState *env, uint64_t *vg, target_ulong addr,
-                   uint32_t desc, const uintptr_t ra,
-                   const int esz, const int msz, const int N,
-                   sve_ldst1_host_fn *host_fn,
-                   sve_ldst1_tlb_fn *tlb_fn)
-{
-    uint32_t mtedesc = desc >> (SIMD_DATA_SHIFT + SVE_MTEDESC_SHIFT);
-
-    /* Remove mtedesc from the normal sve descriptor. */
-    desc = extract32(desc, 0, SIMD_DATA_SHIFT + SVE_MTEDESC_SHIFT);
-
-    sve_ldN_r(env, vg, addr, desc, ra, esz, msz, N, mtedesc, host_fn, tlb_fn);
-}
-
 #define DO_LD1_1(NAME, ESZ)                                             \
-void HELPER(sve_##NAME##_r)(CPUARMState *env, void *vg,                 \
-                            target_ulong addr, uint32_t desc)           \
+void HELPER(sve_##NAME##_r)(CPUARMState *env, void *vg, target_ulong addr, \
+                            uint32_t desc, uint32_t mtedesc)            \
 {                                                                       \
-    sve_ldN_r(env, vg, addr, desc, GETPC(), ESZ, MO_8, 1, 0,            \
+    sve_ldN_r(env, vg, addr, desc, mtedesc, GETPC(), ESZ, MO_8, 1,      \
               sve_##NAME##_host, sve_##NAME##_tlb);                     \
-}                                                                       \
-void HELPER(sve_##NAME##_r_mte)(CPUARMState *env, void *vg,             \
-                                target_ulong addr, uint32_t desc)       \
-{                                                                       \
-    sve_ldN_r_mte(env, vg, addr, desc, GETPC(), ESZ, MO_8, 1,           \
-                  sve_##NAME##_host, sve_##NAME##_tlb);                 \
 }
 
 #define DO_LD1_2(NAME, ESZ, MSZ)                                        \
 void HELPER(sve_##NAME##_le_r)(CPUARMState *env, void *vg,              \
-                               target_ulong addr, uint32_t desc)        \
+                               target_ulong addr, uint32_t desc,        \
+                               uint32_t mtedesc)                        \
 {                                                                       \
-    sve_ldN_r(env, vg, addr, desc, GETPC(), ESZ, MSZ, 1, 0,             \
+    sve_ldN_r(env, vg, addr, desc, mtedesc, GETPC(), ESZ, MSZ, 1,       \
               sve_##NAME##_le_host, sve_##NAME##_le_tlb);               \
 }                                                                       \
 void HELPER(sve_##NAME##_be_r)(CPUARMState *env, void *vg,              \
-                               target_ulong addr, uint32_t desc)        \
+                               target_ulong addr, uint32_t desc,        \
+                               uint32_t mtedesc)                        \
 {                                                                       \
-    sve_ldN_r(env, vg, addr, desc, GETPC(), ESZ, MSZ, 1, 0,             \
+    sve_ldN_r(env, vg, addr, desc, mtedesc, GETPC(), ESZ, MSZ, 1,       \
               sve_##NAME##_be_host, sve_##NAME##_be_tlb);               \
-}                                                                       \
-void HELPER(sve_##NAME##_le_r_mte)(CPUARMState *env, void *vg,          \
-                                   target_ulong addr, uint32_t desc)    \
-{                                                                       \
-    sve_ldN_r_mte(env, vg, addr, desc, GETPC(), ESZ, MSZ, 1,            \
-                  sve_##NAME##_le_host, sve_##NAME##_le_tlb);           \
-}                                                                       \
-void HELPER(sve_##NAME##_be_r_mte)(CPUARMState *env, void *vg,          \
-                                   target_ulong addr, uint32_t desc)    \
-{                                                                       \
-    sve_ldN_r_mte(env, vg, addr, desc, GETPC(), ESZ, MSZ, 1,            \
-                  sve_##NAME##_be_host, sve_##NAME##_be_tlb);           \
 }
 
 DO_LD1_1(ld1bb,  MO_8)
@@ -5867,43 +5836,27 @@ DO_LD1_2(ld1dd,  MO_64, MO_64)
 #undef DO_LD1_2
 
 #define DO_LDN_1(N)                                                     \
-void HELPER(sve_ld##N##bb_r)(CPUARMState *env, void *vg,                \
-                             target_ulong addr, uint32_t desc)          \
+void HELPER(sve_ld##N##bb_r)(CPUARMState *env, void *vg, target_ulong addr, \
+                             uint32_t desc, uint32_t mtedesc)           \
 {                                                                       \
-    sve_ldN_r(env, vg, addr, desc, GETPC(), MO_8, MO_8, N, 0,           \
+    sve_ldN_r(env, vg, addr, desc, mtedesc, GETPC(), MO_8, MO_8, N,     \
               sve_ld1bb_host, sve_ld1bb_tlb);                           \
-}                                                                       \
-void HELPER(sve_ld##N##bb_r_mte)(CPUARMState *env, void *vg,            \
-                                 target_ulong addr, uint32_t desc)      \
-{                                                                       \
-    sve_ldN_r_mte(env, vg, addr, desc, GETPC(), MO_8, MO_8, N,          \
-                  sve_ld1bb_host, sve_ld1bb_tlb);                       \
 }
 
 #define DO_LDN_2(N, SUFF, ESZ)                                          \
 void HELPER(sve_ld##N##SUFF##_le_r)(CPUARMState *env, void *vg,         \
-                                    target_ulong addr, uint32_t desc)   \
+                                    target_ulong addr, uint32_t desc,   \
+                                    uint32_t mtedesc)                   \
 {                                                                       \
-    sve_ldN_r(env, vg, addr, desc, GETPC(), ESZ, ESZ, N, 0,             \
+    sve_ldN_r(env, vg, addr, desc, mtedesc, GETPC(), ESZ, ESZ, N,       \
               sve_ld1##SUFF##_le_host, sve_ld1##SUFF##_le_tlb);         \
 }                                                                       \
 void HELPER(sve_ld##N##SUFF##_be_r)(CPUARMState *env, void *vg,         \
-                                    target_ulong addr, uint32_t desc)   \
+                                    target_ulong addr, uint32_t desc,   \
+                                    uint32_t mtedesc)                   \
 {                                                                       \
-    sve_ldN_r(env, vg, addr, desc, GETPC(), ESZ, ESZ, N, 0,             \
+    sve_ldN_r(env, vg, addr, desc, mtedesc, GETPC(), ESZ, ESZ, N,       \
               sve_ld1##SUFF##_be_host, sve_ld1##SUFF##_be_tlb);         \
-}                                                                       \
-void HELPER(sve_ld##N##SUFF##_le_r_mte)(CPUARMState *env, void *vg,     \
-                                        target_ulong addr, uint32_t desc) \
-{                                                                       \
-    sve_ldN_r_mte(env, vg, addr, desc, GETPC(), ESZ, ESZ, N,            \
-                  sve_ld1##SUFF##_le_host, sve_ld1##SUFF##_le_tlb);     \
-}                                                                       \
-void HELPER(sve_ld##N##SUFF##_be_r_mte)(CPUARMState *env, void *vg,     \
-                                        target_ulong addr, uint32_t desc) \
-{                                                                       \
-    sve_ldN_r_mte(env, vg, addr, desc, GETPC(), ESZ, ESZ, N,            \
-                  sve_ld1##SUFF##_be_host, sve_ld1##SUFF##_be_tlb);     \
 }
 
 DO_LDN_1(2)
@@ -5961,7 +5914,7 @@ static void record_fault(CPUARMState *env, uintptr_t i, uintptr_t oprsz)
  */
 static inline QEMU_ALWAYS_INLINE
 void sve_ldnfff1_r(CPUARMState *env, void *vg, const target_ulong addr,
-                   uint32_t desc, const uintptr_t retaddr, uint32_t mtedesc,
+                   uint32_t desc, uint32_t mtedesc, const uintptr_t retaddr,
                    const int esz, const int msz, const SVEContFault fault,
                    sve_ldst1_host_fn *host_fn,
                    sve_ldst1_tlb_fn *tlb_fn)
@@ -6140,96 +6093,56 @@ void sve_ldnfff1_r(CPUARMState *env, void *vg, const target_ulong addr,
     record_fault(env, reg_off, reg_max);
 }
 
-static inline QEMU_ALWAYS_INLINE
-void sve_ldnfff1_r_mte(CPUARMState *env, void *vg, target_ulong addr,
-                       uint32_t desc, const uintptr_t retaddr,
-                       const int esz, const int msz, const SVEContFault fault,
-                       sve_ldst1_host_fn *host_fn,
-                       sve_ldst1_tlb_fn *tlb_fn)
-{
-    uint32_t mtedesc = desc >> (SIMD_DATA_SHIFT + SVE_MTEDESC_SHIFT);
-
-    /* Remove mtedesc from the normal sve descriptor. */
-    desc = extract32(desc, 0, SIMD_DATA_SHIFT + SVE_MTEDESC_SHIFT);
-
-    sve_ldnfff1_r(env, vg, addr, desc, retaddr, mtedesc,
-                  esz, msz, fault, host_fn, tlb_fn);
-}
-
 #define DO_LDFF1_LDNF1_1(PART, ESZ)                                     \
 void HELPER(sve_ldff1##PART##_r)(CPUARMState *env, void *vg,            \
-                                 target_ulong addr, uint32_t desc)      \
+                                 target_ulong addr, uint32_t desc,      \
+                                 uint32_t mtedesc)                      \
 {                                                                       \
-    sve_ldnfff1_r(env, vg, addr, desc, GETPC(), 0, ESZ, MO_8, FAULT_FIRST, \
+    sve_ldnfff1_r(env, vg, addr, desc, mtedesc, GETPC(),                \
+                  ESZ, MO_8, FAULT_FIRST,                               \
                   sve_ld1##PART##_host, sve_ld1##PART##_tlb);           \
 }                                                                       \
 void HELPER(sve_ldnf1##PART##_r)(CPUARMState *env, void *vg,            \
-                                 target_ulong addr, uint32_t desc)      \
+                                 target_ulong addr, uint32_t desc,      \
+                                 uint32_t mtedesc)                      \
 {                                                                       \
-    sve_ldnfff1_r(env, vg, addr, desc, GETPC(), 0, ESZ, MO_8, FAULT_NO, \
-                  sve_ld1##PART##_host, sve_ld1##PART##_tlb);           \
-}                                                                       \
-void HELPER(sve_ldff1##PART##_r_mte)(CPUARMState *env, void *vg,        \
-                                     target_ulong addr, uint32_t desc)  \
-{                                                                       \
-    sve_ldnfff1_r_mte(env, vg, addr, desc, GETPC(), ESZ, MO_8, FAULT_FIRST, \
-                      sve_ld1##PART##_host, sve_ld1##PART##_tlb);       \
-}                                                                       \
-void HELPER(sve_ldnf1##PART##_r_mte)(CPUARMState *env, void *vg,        \
-                                     target_ulong addr, uint32_t desc)  \
-{                                                                       \
-    sve_ldnfff1_r_mte(env, vg, addr, desc, GETPC(), ESZ, MO_8, FAULT_NO, \
+    sve_ldnfff1_r(env, vg, addr, desc, mtedesc, GETPC(),                \
+                  ESZ, MO_8, FAULT_NO,                                  \
                   sve_ld1##PART##_host, sve_ld1##PART##_tlb);           \
 }
 
 #define DO_LDFF1_LDNF1_2(PART, ESZ, MSZ)                                \
 void HELPER(sve_ldff1##PART##_le_r)(CPUARMState *env, void *vg,         \
-                                    target_ulong addr, uint32_t desc)   \
+                                    target_ulong addr, uint32_t desc,   \
+                                    uint32_t mtedesc)                   \
 {                                                                       \
-    sve_ldnfff1_r(env, vg, addr, desc, GETPC(), 0, ESZ, MSZ, FAULT_FIRST, \
+    sve_ldnfff1_r(env, vg, addr, desc, mtedesc, GETPC(),                \
+                  ESZ, MSZ, FAULT_FIRST,                                \
                   sve_ld1##PART##_le_host, sve_ld1##PART##_le_tlb);     \
 }                                                                       \
 void HELPER(sve_ldnf1##PART##_le_r)(CPUARMState *env, void *vg,         \
-                                    target_ulong addr, uint32_t desc)   \
+                                    target_ulong addr, uint32_t desc,   \
+                                    uint32_t mtedesc)                   \
 {                                                                       \
-    sve_ldnfff1_r(env, vg, addr, desc, GETPC(), 0, ESZ, MSZ, FAULT_NO,  \
+    sve_ldnfff1_r(env, vg, addr, desc, mtedesc, GETPC(),                \
+                  ESZ, MSZ, FAULT_NO,                                   \
                   sve_ld1##PART##_le_host, sve_ld1##PART##_le_tlb);     \
 }                                                                       \
 void HELPER(sve_ldff1##PART##_be_r)(CPUARMState *env, void *vg,         \
-                                    target_ulong addr, uint32_t desc)   \
+                                    target_ulong addr, uint32_t desc,   \
+                                    uint32_t mtedesc)                   \
 {                                                                       \
-    sve_ldnfff1_r(env, vg, addr, desc, GETPC(), 0, ESZ, MSZ, FAULT_FIRST, \
+    sve_ldnfff1_r(env, vg, addr, desc, mtedesc, GETPC(),                \
+                  ESZ, MSZ, FAULT_FIRST,                                \
                   sve_ld1##PART##_be_host, sve_ld1##PART##_be_tlb);     \
 }                                                                       \
 void HELPER(sve_ldnf1##PART##_be_r)(CPUARMState *env, void *vg,         \
-                                    target_ulong addr, uint32_t desc)   \
+                                    target_ulong addr, uint32_t desc,   \
+                                    uint32_t mtedesc)                   \
 {                                                                       \
-    sve_ldnfff1_r(env, vg, addr, desc, GETPC(), 0, ESZ, MSZ, FAULT_NO,  \
+    sve_ldnfff1_r(env, vg, addr, desc, mtedesc, GETPC(),                \
+                  ESZ, MSZ, FAULT_NO,                                   \
                   sve_ld1##PART##_be_host, sve_ld1##PART##_be_tlb);     \
-}                                                                       \
-void HELPER(sve_ldff1##PART##_le_r_mte)(CPUARMState *env, void *vg,     \
-                                        target_ulong addr, uint32_t desc) \
-{                                                                       \
-    sve_ldnfff1_r_mte(env, vg, addr, desc, GETPC(), ESZ, MSZ, FAULT_FIRST, \
-                      sve_ld1##PART##_le_host, sve_ld1##PART##_le_tlb); \
-}                                                                       \
-void HELPER(sve_ldnf1##PART##_le_r_mte)(CPUARMState *env, void *vg,     \
-                                        target_ulong addr, uint32_t desc) \
-{                                                                       \
-    sve_ldnfff1_r_mte(env, vg, addr, desc, GETPC(), ESZ, MSZ, FAULT_NO, \
-                      sve_ld1##PART##_le_host, sve_ld1##PART##_le_tlb); \
-}                                                                       \
-void HELPER(sve_ldff1##PART##_be_r_mte)(CPUARMState *env, void *vg,     \
-                                        target_ulong addr, uint32_t desc) \
-{                                                                       \
-    sve_ldnfff1_r_mte(env, vg, addr, desc, GETPC(), ESZ, MSZ, FAULT_FIRST, \
-                      sve_ld1##PART##_be_host, sve_ld1##PART##_be_tlb); \
-}                                                                       \
-void HELPER(sve_ldnf1##PART##_be_r_mte)(CPUARMState *env, void *vg,     \
-                                        target_ulong addr, uint32_t desc) \
-{                                                                       \
-    sve_ldnfff1_r_mte(env, vg, addr, desc, GETPC(), ESZ, MSZ, FAULT_NO, \
-                      sve_ld1##PART##_be_host, sve_ld1##PART##_be_tlb); \
 }
 
 DO_LDFF1_LDNF1_1(bb,  MO_8)
@@ -6261,8 +6174,8 @@ DO_LDFF1_LDNF1_2(dd,  MO_64, MO_64)
 
 static inline QEMU_ALWAYS_INLINE
 void sve_stN_r(CPUARMState *env, uint64_t *vg, target_ulong addr,
-               uint32_t desc, const uintptr_t retaddr,
-               const int esz, const int msz, const int N, uint32_t mtedesc,
+               uint32_t desc, uint32_t mtedesc, const uintptr_t retaddr,
+               const int esz, const int msz, const int N,
                sve_ldst1_host_fn *host_fn,
                sve_ldst1_tlb_fn *tlb_fn)
 {
@@ -6381,59 +6294,29 @@ void sve_stN_r(CPUARMState *env, uint64_t *vg, target_ulong addr,
     }
 }
 
-static inline QEMU_ALWAYS_INLINE
-void sve_stN_r_mte(CPUARMState *env, uint64_t *vg, target_ulong addr,
-                   uint32_t desc, const uintptr_t ra,
-                   const int esz, const int msz, const int N,
-                   sve_ldst1_host_fn *host_fn,
-                   sve_ldst1_tlb_fn *tlb_fn)
-{
-    uint32_t mtedesc = desc >> (SIMD_DATA_SHIFT + SVE_MTEDESC_SHIFT);
-
-    /* Remove mtedesc from the normal sve descriptor. */
-    desc = extract32(desc, 0, SIMD_DATA_SHIFT + SVE_MTEDESC_SHIFT);
-
-    sve_stN_r(env, vg, addr, desc, ra, esz, msz, N, mtedesc, host_fn, tlb_fn);
-}
-
 #define DO_STN_1(N, NAME, ESZ)                                          \
 void HELPER(sve_st##N##NAME##_r)(CPUARMState *env, void *vg,            \
-                                 target_ulong addr, uint32_t desc)      \
+                                 target_ulong addr, uint32_t desc,      \
+                                 uint32_t mtedesc)                      \
 {                                                                       \
-    sve_stN_r(env, vg, addr, desc, GETPC(), ESZ, MO_8, N, 0,            \
+    sve_stN_r(env, vg, addr, desc, mtedesc, GETPC(), ESZ, MO_8, N,      \
               sve_st1##NAME##_host, sve_st1##NAME##_tlb);               \
-}                                                                       \
-void HELPER(sve_st##N##NAME##_r_mte)(CPUARMState *env, void *vg,        \
-                                     target_ulong addr, uint32_t desc)  \
-{                                                                       \
-    sve_stN_r_mte(env, vg, addr, desc, GETPC(), ESZ, MO_8, N,           \
-                  sve_st1##NAME##_host, sve_st1##NAME##_tlb);           \
 }
 
 #define DO_STN_2(N, NAME, ESZ, MSZ)                                     \
 void HELPER(sve_st##N##NAME##_le_r)(CPUARMState *env, void *vg,         \
-                                    target_ulong addr, uint32_t desc)   \
+                                    target_ulong addr, uint32_t desc,   \
+                                    uint32_t mtedesc)                   \
 {                                                                       \
-    sve_stN_r(env, vg, addr, desc, GETPC(), ESZ, MSZ, N, 0,             \
+    sve_stN_r(env, vg, addr, desc, mtedesc, GETPC(), ESZ, MSZ, N,       \
               sve_st1##NAME##_le_host, sve_st1##NAME##_le_tlb);         \
 }                                                                       \
 void HELPER(sve_st##N##NAME##_be_r)(CPUARMState *env, void *vg,         \
-                                    target_ulong addr, uint32_t desc)   \
+                                    target_ulong addr, uint32_t desc,   \
+                                    uint32_t mtedesc)                   \
 {                                                                       \
-    sve_stN_r(env, vg, addr, desc, GETPC(), ESZ, MSZ, N, 0,             \
+    sve_stN_r(env, vg, addr, desc, mtedesc, GETPC(), ESZ, MSZ, N,       \
               sve_st1##NAME##_be_host, sve_st1##NAME##_be_tlb);         \
-}                                                                       \
-void HELPER(sve_st##N##NAME##_le_r_mte)(CPUARMState *env, void *vg,     \
-                                        target_ulong addr, uint32_t desc) \
-{                                                                       \
-    sve_stN_r_mte(env, vg, addr, desc, GETPC(), ESZ, MSZ, N,            \
-                  sve_st1##NAME##_le_host, sve_st1##NAME##_le_tlb);     \
-}                                                                       \
-void HELPER(sve_st##N##NAME##_be_r_mte)(CPUARMState *env, void *vg,     \
-                                        target_ulong addr, uint32_t desc) \
-{                                                                       \
-    sve_stN_r_mte(env, vg, addr, desc, GETPC(), ESZ, MSZ, N,            \
-                  sve_st1##NAME##_be_host, sve_st1##NAME##_be_tlb);     \
 }
 
 DO_STN_1(1, bb, MO_8)
@@ -6501,8 +6384,8 @@ static target_ulong off_zd_d(void *reg, intptr_t reg_ofs)
 
 static inline QEMU_ALWAYS_INLINE
 void sve_ld1_z(CPUARMState *env, void *vd, uint64_t *vg, void *vm,
-               target_ulong base, uint32_t desc, uintptr_t retaddr,
-               uint32_t mtedesc, int esize, int msize,
+               target_ulong base, uint32_t desc, uint32_t mtedesc,
+               uintptr_t retaddr, int esize, int msize,
                zreg_off_fn *off_fn,
                sve_ldst1_host_fn *host_fn,
                sve_ldst1_tlb_fn *tlb_fn)
@@ -6563,48 +6446,23 @@ void sve_ld1_z(CPUARMState *env, void *vd, uint64_t *vg, void *vm,
     memcpy(vd, &scratch, reg_max);
 }
 
-static inline QEMU_ALWAYS_INLINE
-void sve_ld1_z_mte(CPUARMState *env, void *vd, uint64_t *vg, void *vm,
-                   target_ulong base, uint32_t desc, uintptr_t retaddr,
-                   int esize, int msize, zreg_off_fn *off_fn,
-                   sve_ldst1_host_fn *host_fn,
-                   sve_ldst1_tlb_fn *tlb_fn)
-{
-    uint32_t mtedesc = desc >> (SIMD_DATA_SHIFT + SVE_MTEDESC_SHIFT);
-    /* Remove mtedesc from the normal sve descriptor. */
-    desc = extract32(desc, 0, SIMD_DATA_SHIFT + SVE_MTEDESC_SHIFT);
-
-    sve_ld1_z(env, vd, vg, vm, base, desc, retaddr, mtedesc,
-              esize, msize, off_fn, host_fn, tlb_fn);
-}
-
 #define DO_LD1_ZPZ_S(MEM, OFS, MSZ) \
 void HELPER(sve_ld##MEM##_##OFS)(CPUARMState *env, void *vd, void *vg,       \
-                                 void *vm, target_ulong base, uint32_t desc) \
+                                 void *vm, target_ulong base,                \
+                                 uint32_t desc, uint32_t mtedesc)            \
 {                                                                            \
-    sve_ld1_z(env, vd, vg, vm, base, desc, GETPC(), 0, 4, 1 << MSZ,          \
+    sve_ld1_z(env, vd, vg, vm, base, desc, mtedesc, GETPC(), 4, 1 << MSZ,    \
               off_##OFS##_s, sve_ld1##MEM##_host, sve_ld1##MEM##_tlb);       \
-}                                                                            \
-void HELPER(sve_ld##MEM##_##OFS##_mte)(CPUARMState *env, void *vd, void *vg, \
-     void *vm, target_ulong base, uint32_t desc)                             \
-{                                                                            \
-    sve_ld1_z_mte(env, vd, vg, vm, base, desc, GETPC(), 4, 1 << MSZ,         \
-                  off_##OFS##_s, sve_ld1##MEM##_host, sve_ld1##MEM##_tlb);   \
 }
 
 #define DO_LD1_ZPZ_D(MEM, OFS, MSZ) \
 void HELPER(sve_ld##MEM##_##OFS)(CPUARMState *env, void *vd, void *vg,       \
-                                 void *vm, target_ulong base, uint32_t desc) \
+                                 void *vm, target_ulong base,                \
+                                 uint32_t desc, uint32_t mtedesc)            \
 {                                                                            \
-    sve_ld1_z(env, vd, vg, vm, base, desc, GETPC(), 0, 8, 1 << MSZ,          \
+    sve_ld1_z(env, vd, vg, vm, base, desc, mtedesc, GETPC(), 8, 1 << MSZ,    \
               off_##OFS##_d, sve_ld1##MEM##_host, sve_ld1##MEM##_tlb);       \
 }                                                                            \
-void HELPER(sve_ld##MEM##_##OFS##_mte)(CPUARMState *env, void *vd, void *vg, \
-    void *vm, target_ulong base, uint32_t desc)                              \
-{                                                                            \
-    sve_ld1_z_mte(env, vd, vg, vm, base, desc, GETPC(), 8, 1 << MSZ,         \
-                  off_##OFS##_d, sve_ld1##MEM##_host, sve_ld1##MEM##_tlb);   \
-}
 
 DO_LD1_ZPZ_S(bsu, zsu, MO_8)
 DO_LD1_ZPZ_S(bsu, zss, MO_8)
@@ -6681,8 +6539,8 @@ DO_LD1_ZPZ_D(dd_be, zd, MO_64)
 
 static inline QEMU_ALWAYS_INLINE
 void sve_ldff1_z(CPUARMState *env, void *vd, uint64_t *vg, void *vm,
-                 target_ulong base, uint32_t desc, uintptr_t retaddr,
-                 uint32_t mtedesc, const int esz, const int msz,
+                 target_ulong base, uint32_t desc, uint32_t mtedesc,
+                 uintptr_t retaddr, const int esz, const int msz,
                  zreg_off_fn *off_fn,
                  sve_ldst1_host_fn *host_fn,
                  sve_ldst1_tlb_fn *tlb_fn)
@@ -6714,9 +6572,7 @@ void sve_ldff1_z(CPUARMState *env, void *vd, uint64_t *vg, void *vm,
      * Probe the first element, allowing faults.
      */
     addr = base + (off_fn(vm, reg_off) << scale);
-    if (mtedesc) {
-        mte_check(env, mtedesc, addr, retaddr);
-    }
+    mte_check(env, mtedesc, addr, retaddr);
     tlb_fn(env, vd, reg_off, addr, retaddr);
 
     /* After any fault, zero the other elements. */
@@ -6764,52 +6620,22 @@ void sve_ldff1_z(CPUARMState *env, void *vd, uint64_t *vg, void *vm,
     record_fault(env, reg_off, reg_max);
 }
 
-static inline QEMU_ALWAYS_INLINE
-void sve_ldff1_z_mte(CPUARMState *env, void *vd, uint64_t *vg, void *vm,
-                     target_ulong base, uint32_t desc, uintptr_t retaddr,
-                     const int esz, const int msz,
-                     zreg_off_fn *off_fn,
-                     sve_ldst1_host_fn *host_fn,
-                     sve_ldst1_tlb_fn *tlb_fn)
-{
-    uint32_t mtedesc = desc >> (SIMD_DATA_SHIFT + SVE_MTEDESC_SHIFT);
-    /* Remove mtedesc from the normal sve descriptor. */
-    desc = extract32(desc, 0, SIMD_DATA_SHIFT + SVE_MTEDESC_SHIFT);
-
-    sve_ldff1_z(env, vd, vg, vm, base, desc, retaddr, mtedesc,
-                esz, msz, off_fn, host_fn, tlb_fn);
-}
-
 #define DO_LDFF1_ZPZ_S(MEM, OFS, MSZ)                                   \
 void HELPER(sve_ldff##MEM##_##OFS)                                      \
     (CPUARMState *env, void *vd, void *vg,                              \
-     void *vm, target_ulong base, uint32_t desc)                        \
+     void *vm, target_ulong base, uint32_t desc, uint32_t mtedesc)      \
 {                                                                       \
-    sve_ldff1_z(env, vd, vg, vm, base, desc, GETPC(), 0, MO_32, MSZ,    \
+    sve_ldff1_z(env, vd, vg, vm, base, desc, mtedesc, GETPC(), MO_32, MSZ, \
                 off_##OFS##_s, sve_ld1##MEM##_host, sve_ld1##MEM##_tlb); \
-}                                                                       \
-void HELPER(sve_ldff##MEM##_##OFS##_mte)                                \
-    (CPUARMState *env, void *vd, void *vg,                              \
-     void *vm, target_ulong base, uint32_t desc)                        \
-{                                                                       \
-    sve_ldff1_z_mte(env, vd, vg, vm, base, desc, GETPC(), MO_32, MSZ,   \
-                    off_##OFS##_s, sve_ld1##MEM##_host, sve_ld1##MEM##_tlb); \
 }
 
 #define DO_LDFF1_ZPZ_D(MEM, OFS, MSZ)                                   \
 void HELPER(sve_ldff##MEM##_##OFS)                                      \
     (CPUARMState *env, void *vd, void *vg,                              \
-     void *vm, target_ulong base, uint32_t desc)                        \
+     void *vm, target_ulong base, uint32_t desc, uint32_t mtedesc)      \
 {                                                                       \
-    sve_ldff1_z(env, vd, vg, vm, base, desc, GETPC(), 0, MO_64, MSZ,    \
+    sve_ldff1_z(env, vd, vg, vm, base, desc, mtedesc, GETPC(), MO_64, MSZ, \
                 off_##OFS##_d, sve_ld1##MEM##_host, sve_ld1##MEM##_tlb); \
-}                                                                       \
-void HELPER(sve_ldff##MEM##_##OFS##_mte)                                \
-    (CPUARMState *env, void *vd, void *vg,                              \
-     void *vm, target_ulong base, uint32_t desc)                        \
-{                                                                       \
-    sve_ldff1_z_mte(env, vd, vg, vm, base, desc, GETPC(), MO_64, MSZ,   \
-                    off_##OFS##_d, sve_ld1##MEM##_host, sve_ld1##MEM##_tlb); \
 }
 
 DO_LDFF1_ZPZ_S(bsu, zsu, MO_8)
@@ -6880,8 +6706,8 @@ DO_LDFF1_ZPZ_D(dd_be, zd, MO_64)
 
 static inline QEMU_ALWAYS_INLINE
 void sve_st1_z(CPUARMState *env, void *vd, uint64_t *vg, void *vm,
-               target_ulong base, uint32_t desc, uintptr_t retaddr,
-               uint32_t mtedesc, int esize, int msize,
+               target_ulong base, uint32_t desc, uint32_t mtedesc,
+               uintptr_t retaddr, int esize, int msize,
                zreg_off_fn *off_fn,
                sve_ldst1_host_fn *host_fn,
                sve_ldst1_tlb_fn *tlb_fn)
@@ -6961,47 +6787,20 @@ void sve_st1_z(CPUARMState *env, void *vd, uint64_t *vg, void *vm,
     } while (reg_off < reg_max);
 }
 
-static inline QEMU_ALWAYS_INLINE
-void sve_st1_z_mte(CPUARMState *env, void *vd, uint64_t *vg, void *vm,
-                   target_ulong base, uint32_t desc, uintptr_t retaddr,
-                   int esize, int msize, zreg_off_fn *off_fn,
-                   sve_ldst1_host_fn *host_fn,
-                   sve_ldst1_tlb_fn *tlb_fn)
-{
-    uint32_t mtedesc = desc >> (SIMD_DATA_SHIFT + SVE_MTEDESC_SHIFT);
-    /* Remove mtedesc from the normal sve descriptor. */
-    desc = extract32(desc, 0, SIMD_DATA_SHIFT + SVE_MTEDESC_SHIFT);
-
-    sve_st1_z(env, vd, vg, vm, base, desc, retaddr, mtedesc,
-              esize, msize, off_fn, host_fn, tlb_fn);
-}
-
 #define DO_ST1_ZPZ_S(MEM, OFS, MSZ)                                     \
 void HELPER(sve_st##MEM##_##OFS)(CPUARMState *env, void *vd, void *vg,  \
-                                 void *vm, target_ulong base, uint32_t desc) \
+    void *vm, target_ulong base, uint32_t desc, uint32_t mtedesc)       \
 {                                                                       \
-    sve_st1_z(env, vd, vg, vm, base, desc, GETPC(), 0, 4, 1 << MSZ,     \
+    sve_st1_z(env, vd, vg, vm, base, desc, mtedesc, GETPC(), 4, 1 << MSZ, \
               off_##OFS##_s, sve_st1##MEM##_host, sve_st1##MEM##_tlb);  \
-}                                                                       \
-void HELPER(sve_st##MEM##_##OFS##_mte)(CPUARMState *env, void *vd, void *vg, \
-    void *vm, target_ulong base, uint32_t desc)                         \
-{                                                                       \
-    sve_st1_z_mte(env, vd, vg, vm, base, desc, GETPC(), 4, 1 << MSZ,    \
-                  off_##OFS##_s, sve_st1##MEM##_host, sve_st1##MEM##_tlb); \
 }
 
 #define DO_ST1_ZPZ_D(MEM, OFS, MSZ)                                     \
 void HELPER(sve_st##MEM##_##OFS)(CPUARMState *env, void *vd, void *vg,  \
-                                 void *vm, target_ulong base, uint32_t desc) \
+    void *vm, target_ulong base, uint32_t desc, uint32_t mtedesc)       \
 {                                                                       \
-    sve_st1_z(env, vd, vg, vm, base, desc, GETPC(), 0, 8, 1 << MSZ,     \
+    sve_st1_z(env, vd, vg, vm, base, desc, mtedesc, GETPC(), 8, 1 << MSZ, \
               off_##OFS##_d, sve_st1##MEM##_host, sve_st1##MEM##_tlb);  \
-}                                                                       \
-void HELPER(sve_st##MEM##_##OFS##_mte)(CPUARMState *env, void *vd, void *vg, \
-    void *vm, target_ulong base, uint32_t desc)                         \
-{                                                                       \
-    sve_st1_z_mte(env, vd, vg, vm, base, desc, GETPC(), 8, 1 << MSZ,    \
-                  off_##OFS##_d, sve_st1##MEM##_host, sve_st1##MEM##_tlb); \
 }
 
 DO_ST1_ZPZ_S(bs, zsu, MO_8)
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index 8f0dfc884e..efd9e02848 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -178,20 +178,20 @@ static bool trans_MOVA(DisasContext *s, arg_MOVA *a)
 
 static bool trans_LDST1(DisasContext *s, arg_LDST1 *a)
 {
-    typedef void GenLdSt1(TCGv_env, TCGv_ptr, TCGv_ptr, TCGv, TCGv_i32);
+    typedef void GenLdSt1(TCGv_env, TCGv_ptr, TCGv_ptr, TCGv,
+                          TCGv_i32, TCGv_i32);
 
     /*
-     * Indexed by [esz][be][v][mte][st], which is (except for load/store)
+     * Indexed by [esz][be][v][st], which is (except for load/store)
      * also the order in which the elements appear in the function names,
      * and so how we must concatenate the pieces.
      */
 
 #define FN_LS(F)     { gen_helper_sme_ld1##F, gen_helper_sme_st1##F }
-#define FN_MTE(F)    { FN_LS(F), FN_LS(F##_mte) }
-#define FN_HV(F)     { FN_MTE(F##_h), FN_MTE(F##_v) }
+#define FN_HV(F)     { FN_LS(F##_h), FN_LS(F##_v) }
 #define FN_END(L, B) { FN_HV(L), FN_HV(B) }
 
-    static GenLdSt1 * const fns[5][2][2][2][2] = {
+    static GenLdSt1 * const fns[5][2][2][2] = {
         FN_END(b, b),
         FN_END(h_le, h_be),
         FN_END(s_le, s_be),
@@ -206,9 +206,8 @@ static bool trans_LDST1(DisasContext *s, arg_LDST1 *a)
 
     TCGv_ptr t_za, t_pg;
     TCGv_i64 addr;
-    int svl, desc = 0;
+    int svl, desc, mtedesc = 0;
     bool be = s->be_data == MO_BE;
-    bool mte = s->mte_active[0];
 
     if (!dc_isar_feature(aa64_sme, s)) {
         return false;
@@ -224,21 +223,21 @@ static bool trans_LDST1(DisasContext *s, arg_LDST1 *a)
     tcg_gen_shli_i64(addr, cpu_reg(s, a->rm), a->esz);
     tcg_gen_add_i64(addr, addr, cpu_reg_sp(s, a->rn));
 
-    if (mte) {
-        desc = FIELD_DP32(desc, MTEDESC, MIDX, get_mem_index(s));
-        desc = FIELD_DP32(desc, MTEDESC, TBI, s->tbid);
-        desc = FIELD_DP32(desc, MTEDESC, TCMA, s->tcma);
-        desc = FIELD_DP32(desc, MTEDESC, WRITE, a->st);
-        desc = FIELD_DP32(desc, MTEDESC, SIZEM1, (1 << a->esz) - 1);
-        desc <<= SVE_MTEDESC_SHIFT;
+    if (s->mte_active[0]) {
+        mtedesc = FIELD_DP32(mtedesc, MTEDESC, MIDX, get_mem_index(s));
+        mtedesc = FIELD_DP32(mtedesc, MTEDESC, TBI, s->tbid);
+        mtedesc = FIELD_DP32(mtedesc, MTEDESC, TCMA, s->tcma);
+        mtedesc = FIELD_DP32(mtedesc, MTEDESC, WRITE, a->st);
+        mtedesc = FIELD_DP32(mtedesc, MTEDESC, SIZEM1, (1 << a->esz) - 1);
     } else {
         addr = clean_data_tbi(s, addr);
     }
     svl = streaming_vec_reg_size(s);
-    desc = simd_desc(svl, svl, desc);
+    desc = simd_desc(svl, svl, 0);
 
-    fns[a->esz][be][a->v][mte][a->st](tcg_env, t_za, t_pg, addr,
-                                      tcg_constant_i32(desc));
+    fns[a->esz][be][a->v][a->st](tcg_env, t_za, t_pg, addr,
+                                 tcg_constant_i32(desc),
+                                 tcg_constant_i32(mtedesc));
     return true;
 }
 
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 296e7d1ce2..e5e9507f6b 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -31,9 +31,11 @@ typedef void gen_helper_gvec_flags_3(TCGv_i32, TCGv_ptr, TCGv_ptr,
 typedef void gen_helper_gvec_flags_4(TCGv_i32, TCGv_ptr, TCGv_ptr,
                                      TCGv_ptr, TCGv_ptr, TCGv_i32);
 
-typedef void gen_helper_gvec_mem(TCGv_env, TCGv_ptr, TCGv_i64, TCGv_i32);
+typedef void gen_helper_gvec_mem(TCGv_env, TCGv_ptr, TCGv_i64,
+                                 TCGv_i32, TCGv_i32);
 typedef void gen_helper_gvec_mem_scatter(TCGv_env, TCGv_ptr, TCGv_ptr,
-                                         TCGv_ptr, TCGv_i64, TCGv_i32);
+                                         TCGv_ptr, TCGv_i64,
+                                         TCGv_i32, TCGv_i32);
 
 /*
  * Helpers for extracting complex instruction fields.
@@ -4443,7 +4445,7 @@ static void do_mem_zpa(DisasContext *s, int zt, int pg, TCGv_i64 addr,
 {
     unsigned vsz = vec_full_reg_size(s);
     TCGv_ptr t_pg;
-    int desc = 0;
+    int desc, mtedesc = 0;
 
     /*
      * For e.g. LD4, there are not enough arguments to pass all 4
@@ -4453,147 +4455,79 @@ static void do_mem_zpa(DisasContext *s, int zt, int pg, TCGv_i64 addr,
     if (s->mte_active[0]) {
         int msz = dtype_msz(dtype);
 
-        desc = FIELD_DP32(desc, MTEDESC, MIDX, get_mem_index(s));
-        desc = FIELD_DP32(desc, MTEDESC, TBI, s->tbid);
-        desc = FIELD_DP32(desc, MTEDESC, TCMA, s->tcma);
-        desc = FIELD_DP32(desc, MTEDESC, WRITE, is_write);
-        desc = FIELD_DP32(desc, MTEDESC, SIZEM1, (mte_n << msz) - 1);
-        desc <<= SVE_MTEDESC_SHIFT;
+        mtedesc = FIELD_DP32(mtedesc, MTEDESC, MIDX, get_mem_index(s));
+        mtedesc = FIELD_DP32(mtedesc, MTEDESC, TBI, s->tbid);
+        mtedesc = FIELD_DP32(mtedesc, MTEDESC, TCMA, s->tcma);
+        mtedesc = FIELD_DP32(mtedesc, MTEDESC, WRITE, is_write);
+        mtedesc = FIELD_DP32(mtedesc, MTEDESC, SIZEM1, (mte_n << msz) - 1);
     } else {
         addr = clean_data_tbi(s, addr);
     }
 
-    desc = simd_desc(vsz, vsz, zt | desc);
+    desc = simd_desc(vsz, vsz, zt);
     t_pg = tcg_temp_new_ptr();
 
     tcg_gen_addi_ptr(t_pg, tcg_env, pred_full_reg_offset(s, pg));
-    fn(tcg_env, t_pg, addr, tcg_constant_i32(desc));
+    fn(tcg_env, t_pg, addr, tcg_constant_i32(desc), tcg_constant_i32(mtedesc));
 }
 
-/* Indexed by [mte][be][dtype][nreg] */
-static gen_helper_gvec_mem * const ldr_fns[2][2][16][4] = {
-    { /* mte inactive, little-endian */
-      { { gen_helper_sve_ld1bb_r, gen_helper_sve_ld2bb_r,
+/* Indexed by [be][dtype][nreg] */
+static gen_helper_gvec_mem * const ldr_fns[2][16][4] = {
+    /* little-endian */
+    { { gen_helper_sve_ld1bb_r, gen_helper_sve_ld2bb_r,
           gen_helper_sve_ld3bb_r, gen_helper_sve_ld4bb_r },
-        { gen_helper_sve_ld1bhu_r, NULL, NULL, NULL },
-        { gen_helper_sve_ld1bsu_r, NULL, NULL, NULL },
-        { gen_helper_sve_ld1bdu_r, NULL, NULL, NULL },
+      { gen_helper_sve_ld1bhu_r, NULL, NULL, NULL },
+      { gen_helper_sve_ld1bsu_r, NULL, NULL, NULL },
+      { gen_helper_sve_ld1bdu_r, NULL, NULL, NULL },
 
-        { gen_helper_sve_ld1sds_le_r, NULL, NULL, NULL },
-        { gen_helper_sve_ld1hh_le_r, gen_helper_sve_ld2hh_le_r,
-          gen_helper_sve_ld3hh_le_r, gen_helper_sve_ld4hh_le_r },
-        { gen_helper_sve_ld1hsu_le_r, NULL, NULL, NULL },
-        { gen_helper_sve_ld1hdu_le_r, NULL, NULL, NULL },
+      { gen_helper_sve_ld1sds_le_r, NULL, NULL, NULL },
+      { gen_helper_sve_ld1hh_le_r, gen_helper_sve_ld2hh_le_r,
+        gen_helper_sve_ld3hh_le_r, gen_helper_sve_ld4hh_le_r },
+      { gen_helper_sve_ld1hsu_le_r, NULL, NULL, NULL },
+      { gen_helper_sve_ld1hdu_le_r, NULL, NULL, NULL },
 
-        { gen_helper_sve_ld1hds_le_r, NULL, NULL, NULL },
-        { gen_helper_sve_ld1hss_le_r, NULL, NULL, NULL },
-        { gen_helper_sve_ld1ss_le_r, gen_helper_sve_ld2ss_le_r,
-          gen_helper_sve_ld3ss_le_r, gen_helper_sve_ld4ss_le_r },
-        { gen_helper_sve_ld1sdu_le_r, NULL, NULL, NULL },
+      { gen_helper_sve_ld1hds_le_r, NULL, NULL, NULL },
+      { gen_helper_sve_ld1hss_le_r, NULL, NULL, NULL },
+      { gen_helper_sve_ld1ss_le_r, gen_helper_sve_ld2ss_le_r,
+        gen_helper_sve_ld3ss_le_r, gen_helper_sve_ld4ss_le_r },
+      { gen_helper_sve_ld1sdu_le_r, NULL, NULL, NULL },
 
-        { gen_helper_sve_ld1bds_r, NULL, NULL, NULL },
-        { gen_helper_sve_ld1bss_r, NULL, NULL, NULL },
-        { gen_helper_sve_ld1bhs_r, NULL, NULL, NULL },
-        { gen_helper_sve_ld1dd_le_r, gen_helper_sve_ld2dd_le_r,
-          gen_helper_sve_ld3dd_le_r, gen_helper_sve_ld4dd_le_r } },
+      { gen_helper_sve_ld1bds_r, NULL, NULL, NULL },
+      { gen_helper_sve_ld1bss_r, NULL, NULL, NULL },
+      { gen_helper_sve_ld1bhs_r, NULL, NULL, NULL },
+      { gen_helper_sve_ld1dd_le_r, gen_helper_sve_ld2dd_le_r,
+        gen_helper_sve_ld3dd_le_r, gen_helper_sve_ld4dd_le_r } },
 
-      /* mte inactive, big-endian */
-      { { gen_helper_sve_ld1bb_r, gen_helper_sve_ld2bb_r,
+    /* big-endian */
+    { { gen_helper_sve_ld1bb_r, gen_helper_sve_ld2bb_r,
           gen_helper_sve_ld3bb_r, gen_helper_sve_ld4bb_r },
-        { gen_helper_sve_ld1bhu_r, NULL, NULL, NULL },
-        { gen_helper_sve_ld1bsu_r, NULL, NULL, NULL },
-        { gen_helper_sve_ld1bdu_r, NULL, NULL, NULL },
+      { gen_helper_sve_ld1bhu_r, NULL, NULL, NULL },
+      { gen_helper_sve_ld1bsu_r, NULL, NULL, NULL },
+      { gen_helper_sve_ld1bdu_r, NULL, NULL, NULL },
 
-        { gen_helper_sve_ld1sds_be_r, NULL, NULL, NULL },
-        { gen_helper_sve_ld1hh_be_r, gen_helper_sve_ld2hh_be_r,
-          gen_helper_sve_ld3hh_be_r, gen_helper_sve_ld4hh_be_r },
-        { gen_helper_sve_ld1hsu_be_r, NULL, NULL, NULL },
-        { gen_helper_sve_ld1hdu_be_r, NULL, NULL, NULL },
+      { gen_helper_sve_ld1sds_be_r, NULL, NULL, NULL },
+      { gen_helper_sve_ld1hh_be_r, gen_helper_sve_ld2hh_be_r,
+        gen_helper_sve_ld3hh_be_r, gen_helper_sve_ld4hh_be_r },
+      { gen_helper_sve_ld1hsu_be_r, NULL, NULL, NULL },
+      { gen_helper_sve_ld1hdu_be_r, NULL, NULL, NULL },
 
-        { gen_helper_sve_ld1hds_be_r, NULL, NULL, NULL },
-        { gen_helper_sve_ld1hss_be_r, NULL, NULL, NULL },
-        { gen_helper_sve_ld1ss_be_r, gen_helper_sve_ld2ss_be_r,
-          gen_helper_sve_ld3ss_be_r, gen_helper_sve_ld4ss_be_r },
-        { gen_helper_sve_ld1sdu_be_r, NULL, NULL, NULL },
+      { gen_helper_sve_ld1hds_be_r, NULL, NULL, NULL },
+      { gen_helper_sve_ld1hss_be_r, NULL, NULL, NULL },
+      { gen_helper_sve_ld1ss_be_r, gen_helper_sve_ld2ss_be_r,
+        gen_helper_sve_ld3ss_be_r, gen_helper_sve_ld4ss_be_r },
+      { gen_helper_sve_ld1sdu_be_r, NULL, NULL, NULL },
 
-        { gen_helper_sve_ld1bds_r, NULL, NULL, NULL },
-        { gen_helper_sve_ld1bss_r, NULL, NULL, NULL },
-        { gen_helper_sve_ld1bhs_r, NULL, NULL, NULL },
-        { gen_helper_sve_ld1dd_be_r, gen_helper_sve_ld2dd_be_r,
-          gen_helper_sve_ld3dd_be_r, gen_helper_sve_ld4dd_be_r } } },
-
-    { /* mte active, little-endian */
-      { { gen_helper_sve_ld1bb_r_mte,
-          gen_helper_sve_ld2bb_r_mte,
-          gen_helper_sve_ld3bb_r_mte,
-          gen_helper_sve_ld4bb_r_mte },
-        { gen_helper_sve_ld1bhu_r_mte, NULL, NULL, NULL },
-        { gen_helper_sve_ld1bsu_r_mte, NULL, NULL, NULL },
-        { gen_helper_sve_ld1bdu_r_mte, NULL, NULL, NULL },
-
-        { gen_helper_sve_ld1sds_le_r_mte, NULL, NULL, NULL },
-        { gen_helper_sve_ld1hh_le_r_mte,
-          gen_helper_sve_ld2hh_le_r_mte,
-          gen_helper_sve_ld3hh_le_r_mte,
-          gen_helper_sve_ld4hh_le_r_mte },
-        { gen_helper_sve_ld1hsu_le_r_mte, NULL, NULL, NULL },
-        { gen_helper_sve_ld1hdu_le_r_mte, NULL, NULL, NULL },
-
-        { gen_helper_sve_ld1hds_le_r_mte, NULL, NULL, NULL },
-        { gen_helper_sve_ld1hss_le_r_mte, NULL, NULL, NULL },
-        { gen_helper_sve_ld1ss_le_r_mte,
-          gen_helper_sve_ld2ss_le_r_mte,
-          gen_helper_sve_ld3ss_le_r_mte,
-          gen_helper_sve_ld4ss_le_r_mte },
-        { gen_helper_sve_ld1sdu_le_r_mte, NULL, NULL, NULL },
-
-        { gen_helper_sve_ld1bds_r_mte, NULL, NULL, NULL },
-        { gen_helper_sve_ld1bss_r_mte, NULL, NULL, NULL },
-        { gen_helper_sve_ld1bhs_r_mte, NULL, NULL, NULL },
-        { gen_helper_sve_ld1dd_le_r_mte,
-          gen_helper_sve_ld2dd_le_r_mte,
-          gen_helper_sve_ld3dd_le_r_mte,
-          gen_helper_sve_ld4dd_le_r_mte } },
-
-      /* mte active, big-endian */
-      { { gen_helper_sve_ld1bb_r_mte,
-          gen_helper_sve_ld2bb_r_mte,
-          gen_helper_sve_ld3bb_r_mte,
-          gen_helper_sve_ld4bb_r_mte },
-        { gen_helper_sve_ld1bhu_r_mte, NULL, NULL, NULL },
-        { gen_helper_sve_ld1bsu_r_mte, NULL, NULL, NULL },
-        { gen_helper_sve_ld1bdu_r_mte, NULL, NULL, NULL },
-
-        { gen_helper_sve_ld1sds_be_r_mte, NULL, NULL, NULL },
-        { gen_helper_sve_ld1hh_be_r_mte,
-          gen_helper_sve_ld2hh_be_r_mte,
-          gen_helper_sve_ld3hh_be_r_mte,
-          gen_helper_sve_ld4hh_be_r_mte },
-        { gen_helper_sve_ld1hsu_be_r_mte, NULL, NULL, NULL },
-        { gen_helper_sve_ld1hdu_be_r_mte, NULL, NULL, NULL },
-
-        { gen_helper_sve_ld1hds_be_r_mte, NULL, NULL, NULL },
-        { gen_helper_sve_ld1hss_be_r_mte, NULL, NULL, NULL },
-        { gen_helper_sve_ld1ss_be_r_mte,
-          gen_helper_sve_ld2ss_be_r_mte,
-          gen_helper_sve_ld3ss_be_r_mte,
-          gen_helper_sve_ld4ss_be_r_mte },
-        { gen_helper_sve_ld1sdu_be_r_mte, NULL, NULL, NULL },
-
-        { gen_helper_sve_ld1bds_r_mte, NULL, NULL, NULL },
-        { gen_helper_sve_ld1bss_r_mte, NULL, NULL, NULL },
-        { gen_helper_sve_ld1bhs_r_mte, NULL, NULL, NULL },
-        { gen_helper_sve_ld1dd_be_r_mte,
-          gen_helper_sve_ld2dd_be_r_mte,
-          gen_helper_sve_ld3dd_be_r_mte,
-          gen_helper_sve_ld4dd_be_r_mte } } },
+      { gen_helper_sve_ld1bds_r, NULL, NULL, NULL },
+      { gen_helper_sve_ld1bss_r, NULL, NULL, NULL },
+      { gen_helper_sve_ld1bhs_r, NULL, NULL, NULL },
+      { gen_helper_sve_ld1dd_be_r, gen_helper_sve_ld2dd_be_r,
+        gen_helper_sve_ld3dd_be_r, gen_helper_sve_ld4dd_be_r } }
 };
 
 static void do_ld_zpa(DisasContext *s, int zt, int pg,
                       TCGv_i64 addr, int dtype, int nreg)
 {
-    gen_helper_gvec_mem *fn
-        = ldr_fns[s->mte_active[0]][s->be_data == MO_BE][dtype][nreg];
+    gen_helper_gvec_mem *fn = ldr_fns[s->be_data == MO_BE][dtype][nreg];
 
     /*
      * While there are holes in the table, they are not
@@ -4637,90 +4571,48 @@ static bool trans_LD_zpri(DisasContext *s, arg_rpri_load *a)
 
 static bool trans_LDFF1_zprr(DisasContext *s, arg_rprr_load *a)
 {
-    static gen_helper_gvec_mem * const fns[2][2][16] = {
-        { /* mte inactive, little-endian */
-          { gen_helper_sve_ldff1bb_r,
-            gen_helper_sve_ldff1bhu_r,
-            gen_helper_sve_ldff1bsu_r,
-            gen_helper_sve_ldff1bdu_r,
+    static gen_helper_gvec_mem * const fns[2][16] = {
+        /* little-endian */
+        { gen_helper_sve_ldff1bb_r,
+          gen_helper_sve_ldff1bhu_r,
+          gen_helper_sve_ldff1bsu_r,
+          gen_helper_sve_ldff1bdu_r,
 
-            gen_helper_sve_ldff1sds_le_r,
-            gen_helper_sve_ldff1hh_le_r,
-            gen_helper_sve_ldff1hsu_le_r,
-            gen_helper_sve_ldff1hdu_le_r,
+          gen_helper_sve_ldff1sds_le_r,
+          gen_helper_sve_ldff1hh_le_r,
+          gen_helper_sve_ldff1hsu_le_r,
+          gen_helper_sve_ldff1hdu_le_r,
 
-            gen_helper_sve_ldff1hds_le_r,
-            gen_helper_sve_ldff1hss_le_r,
-            gen_helper_sve_ldff1ss_le_r,
-            gen_helper_sve_ldff1sdu_le_r,
+          gen_helper_sve_ldff1hds_le_r,
+          gen_helper_sve_ldff1hss_le_r,
+          gen_helper_sve_ldff1ss_le_r,
+          gen_helper_sve_ldff1sdu_le_r,
 
-            gen_helper_sve_ldff1bds_r,
-            gen_helper_sve_ldff1bss_r,
-            gen_helper_sve_ldff1bhs_r,
-            gen_helper_sve_ldff1dd_le_r },
+          gen_helper_sve_ldff1bds_r,
+          gen_helper_sve_ldff1bss_r,
+          gen_helper_sve_ldff1bhs_r,
+          gen_helper_sve_ldff1dd_le_r },
 
-          /* mte inactive, big-endian */
-          { gen_helper_sve_ldff1bb_r,
-            gen_helper_sve_ldff1bhu_r,
-            gen_helper_sve_ldff1bsu_r,
-            gen_helper_sve_ldff1bdu_r,
+        /* big-endian */
+        { gen_helper_sve_ldff1bb_r,
+          gen_helper_sve_ldff1bhu_r,
+          gen_helper_sve_ldff1bsu_r,
+          gen_helper_sve_ldff1bdu_r,
 
-            gen_helper_sve_ldff1sds_be_r,
-            gen_helper_sve_ldff1hh_be_r,
-            gen_helper_sve_ldff1hsu_be_r,
-            gen_helper_sve_ldff1hdu_be_r,
+          gen_helper_sve_ldff1sds_be_r,
+          gen_helper_sve_ldff1hh_be_r,
+          gen_helper_sve_ldff1hsu_be_r,
+          gen_helper_sve_ldff1hdu_be_r,
 
-            gen_helper_sve_ldff1hds_be_r,
-            gen_helper_sve_ldff1hss_be_r,
-            gen_helper_sve_ldff1ss_be_r,
-            gen_helper_sve_ldff1sdu_be_r,
+          gen_helper_sve_ldff1hds_be_r,
+          gen_helper_sve_ldff1hss_be_r,
+          gen_helper_sve_ldff1ss_be_r,
+          gen_helper_sve_ldff1sdu_be_r,
 
-            gen_helper_sve_ldff1bds_r,
-            gen_helper_sve_ldff1bss_r,
-            gen_helper_sve_ldff1bhs_r,
-            gen_helper_sve_ldff1dd_be_r } },
-
-        { /* mte active, little-endian */
-          { gen_helper_sve_ldff1bb_r_mte,
-            gen_helper_sve_ldff1bhu_r_mte,
-            gen_helper_sve_ldff1bsu_r_mte,
-            gen_helper_sve_ldff1bdu_r_mte,
-
-            gen_helper_sve_ldff1sds_le_r_mte,
-            gen_helper_sve_ldff1hh_le_r_mte,
-            gen_helper_sve_ldff1hsu_le_r_mte,
-            gen_helper_sve_ldff1hdu_le_r_mte,
-
-            gen_helper_sve_ldff1hds_le_r_mte,
-            gen_helper_sve_ldff1hss_le_r_mte,
-            gen_helper_sve_ldff1ss_le_r_mte,
-            gen_helper_sve_ldff1sdu_le_r_mte,
-
-            gen_helper_sve_ldff1bds_r_mte,
-            gen_helper_sve_ldff1bss_r_mte,
-            gen_helper_sve_ldff1bhs_r_mte,
-            gen_helper_sve_ldff1dd_le_r_mte },
-
-          /* mte active, big-endian */
-          { gen_helper_sve_ldff1bb_r_mte,
-            gen_helper_sve_ldff1bhu_r_mte,
-            gen_helper_sve_ldff1bsu_r_mte,
-            gen_helper_sve_ldff1bdu_r_mte,
-
-            gen_helper_sve_ldff1sds_be_r_mte,
-            gen_helper_sve_ldff1hh_be_r_mte,
-            gen_helper_sve_ldff1hsu_be_r_mte,
-            gen_helper_sve_ldff1hdu_be_r_mte,
-
-            gen_helper_sve_ldff1hds_be_r_mte,
-            gen_helper_sve_ldff1hss_be_r_mte,
-            gen_helper_sve_ldff1ss_be_r_mte,
-            gen_helper_sve_ldff1sdu_be_r_mte,
-
-            gen_helper_sve_ldff1bds_r_mte,
-            gen_helper_sve_ldff1bss_r_mte,
-            gen_helper_sve_ldff1bhs_r_mte,
-            gen_helper_sve_ldff1dd_be_r_mte } },
+          gen_helper_sve_ldff1bds_r,
+          gen_helper_sve_ldff1bss_r,
+          gen_helper_sve_ldff1bhs_r,
+          gen_helper_sve_ldff1dd_be_r }
     };
 
     if (!dc_isar_feature(aa64_sve, s)) {
@@ -4732,97 +4624,55 @@ static bool trans_LDFF1_zprr(DisasContext *s, arg_rprr_load *a)
         tcg_gen_shli_i64(addr, cpu_reg(s, a->rm), dtype_msz(a->dtype));
         tcg_gen_add_i64(addr, addr, cpu_reg_sp(s, a->rn));
         do_mem_zpa(s, a->rd, a->pg, addr, a->dtype, 1, false,
-                   fns[s->mte_active[0]][s->be_data == MO_BE][a->dtype]);
+                   fns[s->be_data == MO_BE][a->dtype]);
     }
     return true;
 }
 
 static bool trans_LDNF1_zpri(DisasContext *s, arg_rpri_load *a)
 {
-    static gen_helper_gvec_mem * const fns[2][2][16] = {
-        { /* mte inactive, little-endian */
-          { gen_helper_sve_ldnf1bb_r,
-            gen_helper_sve_ldnf1bhu_r,
-            gen_helper_sve_ldnf1bsu_r,
-            gen_helper_sve_ldnf1bdu_r,
+    static gen_helper_gvec_mem * const fns[2][16] = {
+        /* little-endian */
+        { gen_helper_sve_ldnf1bb_r,
+          gen_helper_sve_ldnf1bhu_r,
+          gen_helper_sve_ldnf1bsu_r,
+          gen_helper_sve_ldnf1bdu_r,
 
-            gen_helper_sve_ldnf1sds_le_r,
-            gen_helper_sve_ldnf1hh_le_r,
-            gen_helper_sve_ldnf1hsu_le_r,
-            gen_helper_sve_ldnf1hdu_le_r,
+          gen_helper_sve_ldnf1sds_le_r,
+          gen_helper_sve_ldnf1hh_le_r,
+          gen_helper_sve_ldnf1hsu_le_r,
+          gen_helper_sve_ldnf1hdu_le_r,
 
-            gen_helper_sve_ldnf1hds_le_r,
-            gen_helper_sve_ldnf1hss_le_r,
-            gen_helper_sve_ldnf1ss_le_r,
-            gen_helper_sve_ldnf1sdu_le_r,
+          gen_helper_sve_ldnf1hds_le_r,
+          gen_helper_sve_ldnf1hss_le_r,
+          gen_helper_sve_ldnf1ss_le_r,
+          gen_helper_sve_ldnf1sdu_le_r,
 
-            gen_helper_sve_ldnf1bds_r,
-            gen_helper_sve_ldnf1bss_r,
-            gen_helper_sve_ldnf1bhs_r,
-            gen_helper_sve_ldnf1dd_le_r },
+          gen_helper_sve_ldnf1bds_r,
+          gen_helper_sve_ldnf1bss_r,
+          gen_helper_sve_ldnf1bhs_r,
+          gen_helper_sve_ldnf1dd_le_r },
 
-          /* mte inactive, big-endian */
-          { gen_helper_sve_ldnf1bb_r,
-            gen_helper_sve_ldnf1bhu_r,
-            gen_helper_sve_ldnf1bsu_r,
-            gen_helper_sve_ldnf1bdu_r,
+        /* big-endian */
+        { gen_helper_sve_ldnf1bb_r,
+          gen_helper_sve_ldnf1bhu_r,
+          gen_helper_sve_ldnf1bsu_r,
+          gen_helper_sve_ldnf1bdu_r,
 
-            gen_helper_sve_ldnf1sds_be_r,
-            gen_helper_sve_ldnf1hh_be_r,
-            gen_helper_sve_ldnf1hsu_be_r,
-            gen_helper_sve_ldnf1hdu_be_r,
+          gen_helper_sve_ldnf1sds_be_r,
+          gen_helper_sve_ldnf1hh_be_r,
+          gen_helper_sve_ldnf1hsu_be_r,
+          gen_helper_sve_ldnf1hdu_be_r,
 
-            gen_helper_sve_ldnf1hds_be_r,
-            gen_helper_sve_ldnf1hss_be_r,
-            gen_helper_sve_ldnf1ss_be_r,
-            gen_helper_sve_ldnf1sdu_be_r,
+          gen_helper_sve_ldnf1hds_be_r,
+          gen_helper_sve_ldnf1hss_be_r,
+          gen_helper_sve_ldnf1ss_be_r,
+          gen_helper_sve_ldnf1sdu_be_r,
 
-            gen_helper_sve_ldnf1bds_r,
-            gen_helper_sve_ldnf1bss_r,
-            gen_helper_sve_ldnf1bhs_r,
-            gen_helper_sve_ldnf1dd_be_r } },
-
-        { /* mte inactive, little-endian */
-          { gen_helper_sve_ldnf1bb_r_mte,
-            gen_helper_sve_ldnf1bhu_r_mte,
-            gen_helper_sve_ldnf1bsu_r_mte,
-            gen_helper_sve_ldnf1bdu_r_mte,
-
-            gen_helper_sve_ldnf1sds_le_r_mte,
-            gen_helper_sve_ldnf1hh_le_r_mte,
-            gen_helper_sve_ldnf1hsu_le_r_mte,
-            gen_helper_sve_ldnf1hdu_le_r_mte,
-
-            gen_helper_sve_ldnf1hds_le_r_mte,
-            gen_helper_sve_ldnf1hss_le_r_mte,
-            gen_helper_sve_ldnf1ss_le_r_mte,
-            gen_helper_sve_ldnf1sdu_le_r_mte,
-
-            gen_helper_sve_ldnf1bds_r_mte,
-            gen_helper_sve_ldnf1bss_r_mte,
-            gen_helper_sve_ldnf1bhs_r_mte,
-            gen_helper_sve_ldnf1dd_le_r_mte },
-
-          /* mte inactive, big-endian */
-          { gen_helper_sve_ldnf1bb_r_mte,
-            gen_helper_sve_ldnf1bhu_r_mte,
-            gen_helper_sve_ldnf1bsu_r_mte,
-            gen_helper_sve_ldnf1bdu_r_mte,
-
-            gen_helper_sve_ldnf1sds_be_r_mte,
-            gen_helper_sve_ldnf1hh_be_r_mte,
-            gen_helper_sve_ldnf1hsu_be_r_mte,
-            gen_helper_sve_ldnf1hdu_be_r_mte,
-
-            gen_helper_sve_ldnf1hds_be_r_mte,
-            gen_helper_sve_ldnf1hss_be_r_mte,
-            gen_helper_sve_ldnf1ss_be_r_mte,
-            gen_helper_sve_ldnf1sdu_be_r_mte,
-
-            gen_helper_sve_ldnf1bds_r_mte,
-            gen_helper_sve_ldnf1bss_r_mte,
-            gen_helper_sve_ldnf1bhs_r_mte,
-            gen_helper_sve_ldnf1dd_be_r_mte } },
+          gen_helper_sve_ldnf1bds_r,
+          gen_helper_sve_ldnf1bss_r,
+          gen_helper_sve_ldnf1bhs_r,
+          gen_helper_sve_ldnf1dd_be_r }
     };
 
     if (!dc_isar_feature(aa64_sve, s)) {
@@ -4837,7 +4687,7 @@ static bool trans_LDNF1_zpri(DisasContext *s, arg_rpri_load *a)
 
         tcg_gen_addi_i64(addr, cpu_reg_sp(s, a->rn), off);
         do_mem_zpa(s, a->rd, a->pg, addr, a->dtype, 1, false,
-                   fns[s->mte_active[0]][s->be_data == MO_BE][a->dtype]);
+                   fns[s->be_data == MO_BE][a->dtype]);
     }
     return true;
 }
@@ -4846,7 +4696,7 @@ static void do_ldrq(DisasContext *s, int zt, int pg, TCGv_i64 addr, int dtype)
 {
     unsigned vsz = vec_full_reg_size(s);
     TCGv_ptr t_pg;
-    int poff;
+    int poff, mtedesc = 0;
 
     /* Load the first quadword using the normal predicated load helpers.  */
     poff = pred_full_reg_offset(s, pg);
@@ -4870,9 +4720,18 @@ static void do_ldrq(DisasContext *s, int zt, int pg, TCGv_i64 addr, int dtype)
     t_pg = tcg_temp_new_ptr();
     tcg_gen_addi_ptr(t_pg, tcg_env, poff);
 
-    gen_helper_gvec_mem *fn
-        = ldr_fns[s->mte_active[0]][s->be_data == MO_BE][dtype][0];
-    fn(tcg_env, t_pg, addr, tcg_constant_i32(simd_desc(16, 16, zt)));
+    if (s->mte_active[0]) {
+        int msz = dtype_msz(dtype);
+
+        mtedesc = FIELD_DP32(mtedesc, MTEDESC, MIDX, get_mem_index(s));
+        mtedesc = FIELD_DP32(mtedesc, MTEDESC, TBI, s->tbid);
+        mtedesc = FIELD_DP32(mtedesc, MTEDESC, TCMA, s->tcma);
+        mtedesc = FIELD_DP32(mtedesc, MTEDESC, SIZEM1, (1 << msz) - 1);
+    }
+
+    gen_helper_gvec_mem *fn = ldr_fns[s->be_data == MO_BE][dtype][0];
+    fn(tcg_env, t_pg, addr, tcg_constant_i32(simd_desc(16, 16, zt)),
+       tcg_constant_i32(mtedesc));
 
     /* Replicate that first quadword.  */
     if (vsz > 16) {
@@ -4914,7 +4773,7 @@ static void do_ldro(DisasContext *s, int zt, int pg, TCGv_i64 addr, int dtype)
     unsigned vsz = vec_full_reg_size(s);
     unsigned vsz_r32;
     TCGv_ptr t_pg;
-    int poff, doff;
+    int poff, doff, mtedesc = 0;
 
     if (vsz < 32) {
         /*
@@ -4949,9 +4808,18 @@ static void do_ldro(DisasContext *s, int zt, int pg, TCGv_i64 addr, int dtype)
     t_pg = tcg_temp_new_ptr();
     tcg_gen_addi_ptr(t_pg, tcg_env, poff);
 
-    gen_helper_gvec_mem *fn
-        = ldr_fns[s->mte_active[0]][s->be_data == MO_BE][dtype][0];
-    fn(tcg_env, t_pg, addr, tcg_constant_i32(simd_desc(32, 32, zt)));
+    if (s->mte_active[0]) {
+        int msz = dtype_msz(dtype);
+
+        mtedesc = FIELD_DP32(mtedesc, MTEDESC, MIDX, get_mem_index(s));
+        mtedesc = FIELD_DP32(mtedesc, MTEDESC, TBI, s->tbid);
+        mtedesc = FIELD_DP32(mtedesc, MTEDESC, TCMA, s->tcma);
+        mtedesc = FIELD_DP32(mtedesc, MTEDESC, SIZEM1, (1 << msz) - 1);
+    }
+
+    gen_helper_gvec_mem *fn = ldr_fns[s->be_data == MO_BE][dtype][0];
+    fn(tcg_env, t_pg, addr, tcg_constant_i32(simd_desc(32, 32, zt)),
+       tcg_constant_i32(mtedesc));
 
     /*
      * Replicate that first octaword.
@@ -5057,122 +4925,71 @@ static bool trans_LD1R_zpri(DisasContext *s, arg_rpri_load *a)
 static void do_st_zpa(DisasContext *s, int zt, int pg, TCGv_i64 addr,
                       int msz, int esz, int nreg)
 {
-    static gen_helper_gvec_mem * const fn_single[2][2][4][4] = {
-        { { { gen_helper_sve_st1bb_r,
-              gen_helper_sve_st1bh_r,
-              gen_helper_sve_st1bs_r,
-              gen_helper_sve_st1bd_r },
-            { NULL,
-              gen_helper_sve_st1hh_le_r,
-              gen_helper_sve_st1hs_le_r,
-              gen_helper_sve_st1hd_le_r },
-            { NULL, NULL,
-              gen_helper_sve_st1ss_le_r,
-              gen_helper_sve_st1sd_le_r },
-            { NULL, NULL, NULL,
-              gen_helper_sve_st1dd_le_r } },
-          { { gen_helper_sve_st1bb_r,
-              gen_helper_sve_st1bh_r,
-              gen_helper_sve_st1bs_r,
-              gen_helper_sve_st1bd_r },
-            { NULL,
-              gen_helper_sve_st1hh_be_r,
-              gen_helper_sve_st1hs_be_r,
-              gen_helper_sve_st1hd_be_r },
-            { NULL, NULL,
-              gen_helper_sve_st1ss_be_r,
-              gen_helper_sve_st1sd_be_r },
-            { NULL, NULL, NULL,
-              gen_helper_sve_st1dd_be_r } } },
-
-        { { { gen_helper_sve_st1bb_r_mte,
-              gen_helper_sve_st1bh_r_mte,
-              gen_helper_sve_st1bs_r_mte,
-              gen_helper_sve_st1bd_r_mte },
-            { NULL,
-              gen_helper_sve_st1hh_le_r_mte,
-              gen_helper_sve_st1hs_le_r_mte,
-              gen_helper_sve_st1hd_le_r_mte },
-            { NULL, NULL,
-              gen_helper_sve_st1ss_le_r_mte,
-              gen_helper_sve_st1sd_le_r_mte },
-            { NULL, NULL, NULL,
-              gen_helper_sve_st1dd_le_r_mte } },
-          { { gen_helper_sve_st1bb_r_mte,
-              gen_helper_sve_st1bh_r_mte,
-              gen_helper_sve_st1bs_r_mte,
-              gen_helper_sve_st1bd_r_mte },
-            { NULL,
-              gen_helper_sve_st1hh_be_r_mte,
-              gen_helper_sve_st1hs_be_r_mte,
-              gen_helper_sve_st1hd_be_r_mte },
-            { NULL, NULL,
-              gen_helper_sve_st1ss_be_r_mte,
-              gen_helper_sve_st1sd_be_r_mte },
-            { NULL, NULL, NULL,
-              gen_helper_sve_st1dd_be_r_mte } } },
+    static gen_helper_gvec_mem * const fn_single[2][4][4] = {
+        { { gen_helper_sve_st1bb_r,
+            gen_helper_sve_st1bh_r,
+            gen_helper_sve_st1bs_r,
+            gen_helper_sve_st1bd_r },
+          { NULL,
+            gen_helper_sve_st1hh_le_r,
+            gen_helper_sve_st1hs_le_r,
+            gen_helper_sve_st1hd_le_r },
+          { NULL, NULL,
+            gen_helper_sve_st1ss_le_r,
+            gen_helper_sve_st1sd_le_r },
+          { NULL, NULL, NULL,
+            gen_helper_sve_st1dd_le_r } },
+        { { gen_helper_sve_st1bb_r,
+            gen_helper_sve_st1bh_r,
+            gen_helper_sve_st1bs_r,
+            gen_helper_sve_st1bd_r },
+          { NULL,
+            gen_helper_sve_st1hh_be_r,
+            gen_helper_sve_st1hs_be_r,
+            gen_helper_sve_st1hd_be_r },
+          { NULL, NULL,
+            gen_helper_sve_st1ss_be_r,
+            gen_helper_sve_st1sd_be_r },
+          { NULL, NULL, NULL,
+            gen_helper_sve_st1dd_be_r } }
     };
-    static gen_helper_gvec_mem * const fn_multiple[2][2][3][4] = {
-        { { { gen_helper_sve_st2bb_r,
-              gen_helper_sve_st2hh_le_r,
-              gen_helper_sve_st2ss_le_r,
-              gen_helper_sve_st2dd_le_r },
-            { gen_helper_sve_st3bb_r,
-              gen_helper_sve_st3hh_le_r,
-              gen_helper_sve_st3ss_le_r,
-              gen_helper_sve_st3dd_le_r },
-            { gen_helper_sve_st4bb_r,
-              gen_helper_sve_st4hh_le_r,
-              gen_helper_sve_st4ss_le_r,
-              gen_helper_sve_st4dd_le_r } },
-          { { gen_helper_sve_st2bb_r,
-              gen_helper_sve_st2hh_be_r,
-              gen_helper_sve_st2ss_be_r,
-              gen_helper_sve_st2dd_be_r },
-            { gen_helper_sve_st3bb_r,
-              gen_helper_sve_st3hh_be_r,
-              gen_helper_sve_st3ss_be_r,
-              gen_helper_sve_st3dd_be_r },
-            { gen_helper_sve_st4bb_r,
-              gen_helper_sve_st4hh_be_r,
-              gen_helper_sve_st4ss_be_r,
-              gen_helper_sve_st4dd_be_r } } },
-        { { { gen_helper_sve_st2bb_r_mte,
-              gen_helper_sve_st2hh_le_r_mte,
-              gen_helper_sve_st2ss_le_r_mte,
-              gen_helper_sve_st2dd_le_r_mte },
-            { gen_helper_sve_st3bb_r_mte,
-              gen_helper_sve_st3hh_le_r_mte,
-              gen_helper_sve_st3ss_le_r_mte,
-              gen_helper_sve_st3dd_le_r_mte },
-            { gen_helper_sve_st4bb_r_mte,
-              gen_helper_sve_st4hh_le_r_mte,
-              gen_helper_sve_st4ss_le_r_mte,
-              gen_helper_sve_st4dd_le_r_mte } },
-          { { gen_helper_sve_st2bb_r_mte,
-              gen_helper_sve_st2hh_be_r_mte,
-              gen_helper_sve_st2ss_be_r_mte,
-              gen_helper_sve_st2dd_be_r_mte },
-            { gen_helper_sve_st3bb_r_mte,
-              gen_helper_sve_st3hh_be_r_mte,
-              gen_helper_sve_st3ss_be_r_mte,
-              gen_helper_sve_st3dd_be_r_mte },
-            { gen_helper_sve_st4bb_r_mte,
-              gen_helper_sve_st4hh_be_r_mte,
-              gen_helper_sve_st4ss_be_r_mte,
-              gen_helper_sve_st4dd_be_r_mte } } },
+    static gen_helper_gvec_mem * const fn_multiple[2][3][4] = {
+        { { gen_helper_sve_st2bb_r,
+            gen_helper_sve_st2hh_le_r,
+            gen_helper_sve_st2ss_le_r,
+            gen_helper_sve_st2dd_le_r },
+          { gen_helper_sve_st3bb_r,
+            gen_helper_sve_st3hh_le_r,
+            gen_helper_sve_st3ss_le_r,
+            gen_helper_sve_st3dd_le_r },
+          { gen_helper_sve_st4bb_r,
+            gen_helper_sve_st4hh_le_r,
+            gen_helper_sve_st4ss_le_r,
+            gen_helper_sve_st4dd_le_r } },
+        { { gen_helper_sve_st2bb_r,
+            gen_helper_sve_st2hh_be_r,
+            gen_helper_sve_st2ss_be_r,
+            gen_helper_sve_st2dd_be_r },
+          { gen_helper_sve_st3bb_r,
+            gen_helper_sve_st3hh_be_r,
+            gen_helper_sve_st3ss_be_r,
+            gen_helper_sve_st3dd_be_r },
+          { gen_helper_sve_st4bb_r,
+            gen_helper_sve_st4hh_be_r,
+            gen_helper_sve_st4ss_be_r,
+            gen_helper_sve_st4dd_be_r } }
     };
     gen_helper_gvec_mem *fn;
     int be = s->be_data == MO_BE;
 
     if (nreg == 0) {
         /* ST1 */
-        fn = fn_single[s->mte_active[0]][be][msz][esz];
+        fn = fn_single[be][msz][esz];
         nreg = 1;
     } else {
         /* ST2, ST3, ST4 -- msz == esz, enforced by encoding */
         assert(msz == esz);
-        fn = fn_multiple[s->mte_active[0]][be][nreg - 1][msz];
+        fn = fn_multiple[be][nreg - 1][msz];
     }
     assert(fn != NULL);
     do_mem_zpa(s, zt, pg, addr, msz_dtype(s, msz), nreg, true, fn);
@@ -5227,357 +5044,195 @@ static void do_mem_zpz(DisasContext *s, int zt, int pg, int zm,
     TCGv_ptr t_zm = tcg_temp_new_ptr();
     TCGv_ptr t_pg = tcg_temp_new_ptr();
     TCGv_ptr t_zt = tcg_temp_new_ptr();
-    int desc = 0;
+    int desc, mtedesc = 0;
 
     if (s->mte_active[0]) {
-        desc = FIELD_DP32(desc, MTEDESC, MIDX, get_mem_index(s));
-        desc = FIELD_DP32(desc, MTEDESC, TBI, s->tbid);
-        desc = FIELD_DP32(desc, MTEDESC, TCMA, s->tcma);
-        desc = FIELD_DP32(desc, MTEDESC, WRITE, is_write);
-        desc = FIELD_DP32(desc, MTEDESC, SIZEM1, (1 << msz) - 1);
-        desc <<= SVE_MTEDESC_SHIFT;
+        mtedesc = FIELD_DP32(desc, MTEDESC, MIDX, get_mem_index(s));
+        mtedesc = FIELD_DP32(desc, MTEDESC, TBI, s->tbid);
+        mtedesc = FIELD_DP32(desc, MTEDESC, TCMA, s->tcma);
+        mtedesc = FIELD_DP32(desc, MTEDESC, WRITE, is_write);
+        mtedesc = FIELD_DP32(desc, MTEDESC, SIZEM1, (1 << msz) - 1);
     }
-    desc = simd_desc(vsz, vsz, desc | scale);
+    desc = simd_desc(vsz, vsz, scale);
 
     tcg_gen_addi_ptr(t_pg, tcg_env, pred_full_reg_offset(s, pg));
     tcg_gen_addi_ptr(t_zm, tcg_env, vec_full_reg_offset(s, zm));
     tcg_gen_addi_ptr(t_zt, tcg_env, vec_full_reg_offset(s, zt));
-    fn(tcg_env, t_zt, t_pg, t_zm, scalar, tcg_constant_i32(desc));
+    fn(tcg_env, t_zt, t_pg, t_zm, scalar,
+       tcg_constant_i32(desc), tcg_constant_i32(mtedesc));
 }
 
-/* Indexed by [mte][be][ff][xs][u][msz].  */
+/* Indexed by [be][ff][xs][u][msz].  */
 static gen_helper_gvec_mem_scatter * const
-gather_load_fn32[2][2][2][2][2][3] = {
-    { /* MTE Inactive */
-        { /* Little-endian */
-            { { { gen_helper_sve_ldbss_zsu,
-                  gen_helper_sve_ldhss_le_zsu,
-                  NULL, },
-                { gen_helper_sve_ldbsu_zsu,
-                  gen_helper_sve_ldhsu_le_zsu,
-                  gen_helper_sve_ldss_le_zsu, } },
-              { { gen_helper_sve_ldbss_zss,
-                  gen_helper_sve_ldhss_le_zss,
-                  NULL, },
-                { gen_helper_sve_ldbsu_zss,
-                  gen_helper_sve_ldhsu_le_zss,
-                  gen_helper_sve_ldss_le_zss, } } },
+gather_load_fn32[2][2][2][2][3] = {
+    /* Little-endian */
+    { { { { gen_helper_sve_ldbss_zsu,
+            gen_helper_sve_ldhss_le_zsu,
+            NULL, },
+          { gen_helper_sve_ldbsu_zsu,
+            gen_helper_sve_ldhsu_le_zsu,
+            gen_helper_sve_ldss_le_zsu, } },
+        { { gen_helper_sve_ldbss_zss,
+            gen_helper_sve_ldhss_le_zss,
+            NULL, },
+          { gen_helper_sve_ldbsu_zss,
+            gen_helper_sve_ldhsu_le_zss,
+            gen_helper_sve_ldss_le_zss, } } },
 
-            /* First-fault */
-            { { { gen_helper_sve_ldffbss_zsu,
-                  gen_helper_sve_ldffhss_le_zsu,
-                  NULL, },
-                { gen_helper_sve_ldffbsu_zsu,
-                  gen_helper_sve_ldffhsu_le_zsu,
-                  gen_helper_sve_ldffss_le_zsu, } },
-              { { gen_helper_sve_ldffbss_zss,
-                  gen_helper_sve_ldffhss_le_zss,
-                  NULL, },
-                { gen_helper_sve_ldffbsu_zss,
-                  gen_helper_sve_ldffhsu_le_zss,
-                  gen_helper_sve_ldffss_le_zss, } } } },
+      /* First-fault */
+      { { { gen_helper_sve_ldffbss_zsu,
+            gen_helper_sve_ldffhss_le_zsu,
+            NULL, },
+          { gen_helper_sve_ldffbsu_zsu,
+            gen_helper_sve_ldffhsu_le_zsu,
+            gen_helper_sve_ldffss_le_zsu, } },
+        { { gen_helper_sve_ldffbss_zss,
+            gen_helper_sve_ldffhss_le_zss,
+            NULL, },
+          { gen_helper_sve_ldffbsu_zss,
+            gen_helper_sve_ldffhsu_le_zss,
+            gen_helper_sve_ldffss_le_zss, } } } },
 
-        { /* Big-endian */
-            { { { gen_helper_sve_ldbss_zsu,
-                  gen_helper_sve_ldhss_be_zsu,
-                  NULL, },
-                { gen_helper_sve_ldbsu_zsu,
-                  gen_helper_sve_ldhsu_be_zsu,
-                  gen_helper_sve_ldss_be_zsu, } },
-              { { gen_helper_sve_ldbss_zss,
-                  gen_helper_sve_ldhss_be_zss,
-                  NULL, },
-                { gen_helper_sve_ldbsu_zss,
-                  gen_helper_sve_ldhsu_be_zss,
-                  gen_helper_sve_ldss_be_zss, } } },
+    /* Big-endian */
+    { { { { gen_helper_sve_ldbss_zsu,
+            gen_helper_sve_ldhss_be_zsu,
+            NULL, },
+          { gen_helper_sve_ldbsu_zsu,
+            gen_helper_sve_ldhsu_be_zsu,
+            gen_helper_sve_ldss_be_zsu, } },
+        { { gen_helper_sve_ldbss_zss,
+            gen_helper_sve_ldhss_be_zss,
+            NULL, },
+          { gen_helper_sve_ldbsu_zss,
+            gen_helper_sve_ldhsu_be_zss,
+            gen_helper_sve_ldss_be_zss, } } },
 
-            /* First-fault */
-            { { { gen_helper_sve_ldffbss_zsu,
-                  gen_helper_sve_ldffhss_be_zsu,
-                  NULL, },
-                { gen_helper_sve_ldffbsu_zsu,
-                  gen_helper_sve_ldffhsu_be_zsu,
-                  gen_helper_sve_ldffss_be_zsu, } },
-              { { gen_helper_sve_ldffbss_zss,
-                  gen_helper_sve_ldffhss_be_zss,
-                  NULL, },
-                { gen_helper_sve_ldffbsu_zss,
-                  gen_helper_sve_ldffhsu_be_zss,
-                  gen_helper_sve_ldffss_be_zss, } } } } },
-    { /* MTE Active */
-        { /* Little-endian */
-            { { { gen_helper_sve_ldbss_zsu_mte,
-                  gen_helper_sve_ldhss_le_zsu_mte,
-                  NULL, },
-                { gen_helper_sve_ldbsu_zsu_mte,
-                  gen_helper_sve_ldhsu_le_zsu_mte,
-                  gen_helper_sve_ldss_le_zsu_mte, } },
-              { { gen_helper_sve_ldbss_zss_mte,
-                  gen_helper_sve_ldhss_le_zss_mte,
-                  NULL, },
-                { gen_helper_sve_ldbsu_zss_mte,
-                  gen_helper_sve_ldhsu_le_zss_mte,
-                  gen_helper_sve_ldss_le_zss_mte, } } },
-
-            /* First-fault */
-            { { { gen_helper_sve_ldffbss_zsu_mte,
-                  gen_helper_sve_ldffhss_le_zsu_mte,
-                  NULL, },
-                { gen_helper_sve_ldffbsu_zsu_mte,
-                  gen_helper_sve_ldffhsu_le_zsu_mte,
-                  gen_helper_sve_ldffss_le_zsu_mte, } },
-              { { gen_helper_sve_ldffbss_zss_mte,
-                  gen_helper_sve_ldffhss_le_zss_mte,
-                  NULL, },
-                { gen_helper_sve_ldffbsu_zss_mte,
-                  gen_helper_sve_ldffhsu_le_zss_mte,
-                  gen_helper_sve_ldffss_le_zss_mte, } } } },
-
-        { /* Big-endian */
-            { { { gen_helper_sve_ldbss_zsu_mte,
-                  gen_helper_sve_ldhss_be_zsu_mte,
-                  NULL, },
-                { gen_helper_sve_ldbsu_zsu_mte,
-                  gen_helper_sve_ldhsu_be_zsu_mte,
-                  gen_helper_sve_ldss_be_zsu_mte, } },
-              { { gen_helper_sve_ldbss_zss_mte,
-                  gen_helper_sve_ldhss_be_zss_mte,
-                  NULL, },
-                { gen_helper_sve_ldbsu_zss_mte,
-                  gen_helper_sve_ldhsu_be_zss_mte,
-                  gen_helper_sve_ldss_be_zss_mte, } } },
-
-            /* First-fault */
-            { { { gen_helper_sve_ldffbss_zsu_mte,
-                  gen_helper_sve_ldffhss_be_zsu_mte,
-                  NULL, },
-                { gen_helper_sve_ldffbsu_zsu_mte,
-                  gen_helper_sve_ldffhsu_be_zsu_mte,
-                  gen_helper_sve_ldffss_be_zsu_mte, } },
-              { { gen_helper_sve_ldffbss_zss_mte,
-                  gen_helper_sve_ldffhss_be_zss_mte,
-                  NULL, },
-                { gen_helper_sve_ldffbsu_zss_mte,
-                  gen_helper_sve_ldffhsu_be_zss_mte,
-                  gen_helper_sve_ldffss_be_zss_mte, } } } } },
+      /* First-fault */
+      { { { gen_helper_sve_ldffbss_zsu,
+            gen_helper_sve_ldffhss_be_zsu,
+            NULL, },
+          { gen_helper_sve_ldffbsu_zsu,
+            gen_helper_sve_ldffhsu_be_zsu,
+            gen_helper_sve_ldffss_be_zsu, } },
+        { { gen_helper_sve_ldffbss_zss,
+            gen_helper_sve_ldffhss_be_zss,
+            NULL, },
+          { gen_helper_sve_ldffbsu_zss,
+            gen_helper_sve_ldffhsu_be_zss,
+            gen_helper_sve_ldffss_be_zss, } } } }
 };
 
 /* Note that we overload xs=2 to indicate 64-bit offset.  */
 static gen_helper_gvec_mem_scatter * const
-gather_load_fn64[2][2][2][3][2][4] = {
-    { /* MTE Inactive */
-        { /* Little-endian */
-            { { { gen_helper_sve_ldbds_zsu,
-                  gen_helper_sve_ldhds_le_zsu,
-                  gen_helper_sve_ldsds_le_zsu,
-                  NULL, },
-                { gen_helper_sve_ldbdu_zsu,
-                  gen_helper_sve_ldhdu_le_zsu,
-                  gen_helper_sve_ldsdu_le_zsu,
-                  gen_helper_sve_lddd_le_zsu, } },
-              { { gen_helper_sve_ldbds_zss,
-                  gen_helper_sve_ldhds_le_zss,
-                  gen_helper_sve_ldsds_le_zss,
-                  NULL, },
-                { gen_helper_sve_ldbdu_zss,
-                  gen_helper_sve_ldhdu_le_zss,
-                  gen_helper_sve_ldsdu_le_zss,
-                  gen_helper_sve_lddd_le_zss, } },
-              { { gen_helper_sve_ldbds_zd,
-                  gen_helper_sve_ldhds_le_zd,
-                  gen_helper_sve_ldsds_le_zd,
-                  NULL, },
-                { gen_helper_sve_ldbdu_zd,
-                  gen_helper_sve_ldhdu_le_zd,
-                  gen_helper_sve_ldsdu_le_zd,
-                  gen_helper_sve_lddd_le_zd, } } },
+gather_load_fn64[2][2][3][2][4] = {
+    /* Little-endian */
+    { { { { gen_helper_sve_ldbds_zsu,
+            gen_helper_sve_ldhds_le_zsu,
+            gen_helper_sve_ldsds_le_zsu,
+            NULL, },
+          { gen_helper_sve_ldbdu_zsu,
+            gen_helper_sve_ldhdu_le_zsu,
+            gen_helper_sve_ldsdu_le_zsu,
+            gen_helper_sve_lddd_le_zsu, } },
+        { { gen_helper_sve_ldbds_zss,
+            gen_helper_sve_ldhds_le_zss,
+            gen_helper_sve_ldsds_le_zss,
+            NULL, },
+          { gen_helper_sve_ldbdu_zss,
+            gen_helper_sve_ldhdu_le_zss,
+            gen_helper_sve_ldsdu_le_zss,
+            gen_helper_sve_lddd_le_zss, } },
+        { { gen_helper_sve_ldbds_zd,
+            gen_helper_sve_ldhds_le_zd,
+            gen_helper_sve_ldsds_le_zd,
+            NULL, },
+          { gen_helper_sve_ldbdu_zd,
+            gen_helper_sve_ldhdu_le_zd,
+            gen_helper_sve_ldsdu_le_zd,
+            gen_helper_sve_lddd_le_zd, } } },
 
-            /* First-fault */
-            { { { gen_helper_sve_ldffbds_zsu,
-                  gen_helper_sve_ldffhds_le_zsu,
-                  gen_helper_sve_ldffsds_le_zsu,
-                  NULL, },
-                { gen_helper_sve_ldffbdu_zsu,
-                  gen_helper_sve_ldffhdu_le_zsu,
-                  gen_helper_sve_ldffsdu_le_zsu,
-                  gen_helper_sve_ldffdd_le_zsu, } },
-              { { gen_helper_sve_ldffbds_zss,
-                  gen_helper_sve_ldffhds_le_zss,
-                  gen_helper_sve_ldffsds_le_zss,
-                  NULL, },
-                { gen_helper_sve_ldffbdu_zss,
-                  gen_helper_sve_ldffhdu_le_zss,
-                  gen_helper_sve_ldffsdu_le_zss,
-                  gen_helper_sve_ldffdd_le_zss, } },
-              { { gen_helper_sve_ldffbds_zd,
-                  gen_helper_sve_ldffhds_le_zd,
-                  gen_helper_sve_ldffsds_le_zd,
-                  NULL, },
-                { gen_helper_sve_ldffbdu_zd,
-                  gen_helper_sve_ldffhdu_le_zd,
-                  gen_helper_sve_ldffsdu_le_zd,
-                  gen_helper_sve_ldffdd_le_zd, } } } },
-        { /* Big-endian */
-            { { { gen_helper_sve_ldbds_zsu,
-                  gen_helper_sve_ldhds_be_zsu,
-                  gen_helper_sve_ldsds_be_zsu,
-                  NULL, },
-                { gen_helper_sve_ldbdu_zsu,
-                  gen_helper_sve_ldhdu_be_zsu,
-                  gen_helper_sve_ldsdu_be_zsu,
-                  gen_helper_sve_lddd_be_zsu, } },
-              { { gen_helper_sve_ldbds_zss,
-                  gen_helper_sve_ldhds_be_zss,
-                  gen_helper_sve_ldsds_be_zss,
-                  NULL, },
-                { gen_helper_sve_ldbdu_zss,
-                  gen_helper_sve_ldhdu_be_zss,
-                  gen_helper_sve_ldsdu_be_zss,
-                  gen_helper_sve_lddd_be_zss, } },
-              { { gen_helper_sve_ldbds_zd,
-                  gen_helper_sve_ldhds_be_zd,
-                  gen_helper_sve_ldsds_be_zd,
-                  NULL, },
-                { gen_helper_sve_ldbdu_zd,
-                  gen_helper_sve_ldhdu_be_zd,
-                  gen_helper_sve_ldsdu_be_zd,
-                  gen_helper_sve_lddd_be_zd, } } },
+      /* First-fault */
+      { { { gen_helper_sve_ldffbds_zsu,
+            gen_helper_sve_ldffhds_le_zsu,
+            gen_helper_sve_ldffsds_le_zsu,
+            NULL, },
+          { gen_helper_sve_ldffbdu_zsu,
+            gen_helper_sve_ldffhdu_le_zsu,
+            gen_helper_sve_ldffsdu_le_zsu,
+            gen_helper_sve_ldffdd_le_zsu, } },
+        { { gen_helper_sve_ldffbds_zss,
+            gen_helper_sve_ldffhds_le_zss,
+            gen_helper_sve_ldffsds_le_zss,
+            NULL, },
+          { gen_helper_sve_ldffbdu_zss,
+            gen_helper_sve_ldffhdu_le_zss,
+            gen_helper_sve_ldffsdu_le_zss,
+            gen_helper_sve_ldffdd_le_zss, } },
+        { { gen_helper_sve_ldffbds_zd,
+            gen_helper_sve_ldffhds_le_zd,
+            gen_helper_sve_ldffsds_le_zd,
+            NULL, },
+          { gen_helper_sve_ldffbdu_zd,
+            gen_helper_sve_ldffhdu_le_zd,
+            gen_helper_sve_ldffsdu_le_zd,
+            gen_helper_sve_ldffdd_le_zd, } } } },
+    /* Big-endian */
+    { { { { gen_helper_sve_ldbds_zsu,
+            gen_helper_sve_ldhds_be_zsu,
+            gen_helper_sve_ldsds_be_zsu,
+            NULL, },
+          { gen_helper_sve_ldbdu_zsu,
+            gen_helper_sve_ldhdu_be_zsu,
+            gen_helper_sve_ldsdu_be_zsu,
+            gen_helper_sve_lddd_be_zsu, } },
+        { { gen_helper_sve_ldbds_zss,
+            gen_helper_sve_ldhds_be_zss,
+            gen_helper_sve_ldsds_be_zss,
+            NULL, },
+          { gen_helper_sve_ldbdu_zss,
+            gen_helper_sve_ldhdu_be_zss,
+            gen_helper_sve_ldsdu_be_zss,
+            gen_helper_sve_lddd_be_zss, } },
+        { { gen_helper_sve_ldbds_zd,
+            gen_helper_sve_ldhds_be_zd,
+            gen_helper_sve_ldsds_be_zd,
+            NULL, },
+          { gen_helper_sve_ldbdu_zd,
+            gen_helper_sve_ldhdu_be_zd,
+            gen_helper_sve_ldsdu_be_zd,
+            gen_helper_sve_lddd_be_zd, } } },
 
-            /* First-fault */
-            { { { gen_helper_sve_ldffbds_zsu,
-                  gen_helper_sve_ldffhds_be_zsu,
-                  gen_helper_sve_ldffsds_be_zsu,
-                  NULL, },
-                { gen_helper_sve_ldffbdu_zsu,
-                  gen_helper_sve_ldffhdu_be_zsu,
-                  gen_helper_sve_ldffsdu_be_zsu,
-                  gen_helper_sve_ldffdd_be_zsu, } },
-              { { gen_helper_sve_ldffbds_zss,
-                  gen_helper_sve_ldffhds_be_zss,
-                  gen_helper_sve_ldffsds_be_zss,
-                  NULL, },
-                { gen_helper_sve_ldffbdu_zss,
-                  gen_helper_sve_ldffhdu_be_zss,
-                  gen_helper_sve_ldffsdu_be_zss,
-                  gen_helper_sve_ldffdd_be_zss, } },
-              { { gen_helper_sve_ldffbds_zd,
-                  gen_helper_sve_ldffhds_be_zd,
-                  gen_helper_sve_ldffsds_be_zd,
-                  NULL, },
-                { gen_helper_sve_ldffbdu_zd,
-                  gen_helper_sve_ldffhdu_be_zd,
-                  gen_helper_sve_ldffsdu_be_zd,
-                  gen_helper_sve_ldffdd_be_zd, } } } } },
-    { /* MTE Active */
-        { /* Little-endian */
-            { { { gen_helper_sve_ldbds_zsu_mte,
-                  gen_helper_sve_ldhds_le_zsu_mte,
-                  gen_helper_sve_ldsds_le_zsu_mte,
-                  NULL, },
-                { gen_helper_sve_ldbdu_zsu_mte,
-                  gen_helper_sve_ldhdu_le_zsu_mte,
-                  gen_helper_sve_ldsdu_le_zsu_mte,
-                  gen_helper_sve_lddd_le_zsu_mte, } },
-              { { gen_helper_sve_ldbds_zss_mte,
-                  gen_helper_sve_ldhds_le_zss_mte,
-                  gen_helper_sve_ldsds_le_zss_mte,
-                  NULL, },
-                { gen_helper_sve_ldbdu_zss_mte,
-                  gen_helper_sve_ldhdu_le_zss_mte,
-                  gen_helper_sve_ldsdu_le_zss_mte,
-                  gen_helper_sve_lddd_le_zss_mte, } },
-              { { gen_helper_sve_ldbds_zd_mte,
-                  gen_helper_sve_ldhds_le_zd_mte,
-                  gen_helper_sve_ldsds_le_zd_mte,
-                  NULL, },
-                { gen_helper_sve_ldbdu_zd_mte,
-                  gen_helper_sve_ldhdu_le_zd_mte,
-                  gen_helper_sve_ldsdu_le_zd_mte,
-                  gen_helper_sve_lddd_le_zd_mte, } } },
-
-            /* First-fault */
-            { { { gen_helper_sve_ldffbds_zsu_mte,
-                  gen_helper_sve_ldffhds_le_zsu_mte,
-                  gen_helper_sve_ldffsds_le_zsu_mte,
-                  NULL, },
-                { gen_helper_sve_ldffbdu_zsu_mte,
-                  gen_helper_sve_ldffhdu_le_zsu_mte,
-                  gen_helper_sve_ldffsdu_le_zsu_mte,
-                  gen_helper_sve_ldffdd_le_zsu_mte, } },
-              { { gen_helper_sve_ldffbds_zss_mte,
-                  gen_helper_sve_ldffhds_le_zss_mte,
-                  gen_helper_sve_ldffsds_le_zss_mte,
-                  NULL, },
-                { gen_helper_sve_ldffbdu_zss_mte,
-                  gen_helper_sve_ldffhdu_le_zss_mte,
-                  gen_helper_sve_ldffsdu_le_zss_mte,
-                  gen_helper_sve_ldffdd_le_zss_mte, } },
-              { { gen_helper_sve_ldffbds_zd_mte,
-                  gen_helper_sve_ldffhds_le_zd_mte,
-                  gen_helper_sve_ldffsds_le_zd_mte,
-                  NULL, },
-                { gen_helper_sve_ldffbdu_zd_mte,
-                  gen_helper_sve_ldffhdu_le_zd_mte,
-                  gen_helper_sve_ldffsdu_le_zd_mte,
-                  gen_helper_sve_ldffdd_le_zd_mte, } } } },
-        { /* Big-endian */
-            { { { gen_helper_sve_ldbds_zsu_mte,
-                  gen_helper_sve_ldhds_be_zsu_mte,
-                  gen_helper_sve_ldsds_be_zsu_mte,
-                  NULL, },
-                { gen_helper_sve_ldbdu_zsu_mte,
-                  gen_helper_sve_ldhdu_be_zsu_mte,
-                  gen_helper_sve_ldsdu_be_zsu_mte,
-                  gen_helper_sve_lddd_be_zsu_mte, } },
-              { { gen_helper_sve_ldbds_zss_mte,
-                  gen_helper_sve_ldhds_be_zss_mte,
-                  gen_helper_sve_ldsds_be_zss_mte,
-                  NULL, },
-                { gen_helper_sve_ldbdu_zss_mte,
-                  gen_helper_sve_ldhdu_be_zss_mte,
-                  gen_helper_sve_ldsdu_be_zss_mte,
-                  gen_helper_sve_lddd_be_zss_mte, } },
-              { { gen_helper_sve_ldbds_zd_mte,
-                  gen_helper_sve_ldhds_be_zd_mte,
-                  gen_helper_sve_ldsds_be_zd_mte,
-                  NULL, },
-                { gen_helper_sve_ldbdu_zd_mte,
-                  gen_helper_sve_ldhdu_be_zd_mte,
-                  gen_helper_sve_ldsdu_be_zd_mte,
-                  gen_helper_sve_lddd_be_zd_mte, } } },
-
-            /* First-fault */
-            { { { gen_helper_sve_ldffbds_zsu_mte,
-                  gen_helper_sve_ldffhds_be_zsu_mte,
-                  gen_helper_sve_ldffsds_be_zsu_mte,
-                  NULL, },
-                { gen_helper_sve_ldffbdu_zsu_mte,
-                  gen_helper_sve_ldffhdu_be_zsu_mte,
-                  gen_helper_sve_ldffsdu_be_zsu_mte,
-                  gen_helper_sve_ldffdd_be_zsu_mte, } },
-              { { gen_helper_sve_ldffbds_zss_mte,
-                  gen_helper_sve_ldffhds_be_zss_mte,
-                  gen_helper_sve_ldffsds_be_zss_mte,
-                  NULL, },
-                { gen_helper_sve_ldffbdu_zss_mte,
-                  gen_helper_sve_ldffhdu_be_zss_mte,
-                  gen_helper_sve_ldffsdu_be_zss_mte,
-                  gen_helper_sve_ldffdd_be_zss_mte, } },
-              { { gen_helper_sve_ldffbds_zd_mte,
-                  gen_helper_sve_ldffhds_be_zd_mte,
-                  gen_helper_sve_ldffsds_be_zd_mte,
-                  NULL, },
-                { gen_helper_sve_ldffbdu_zd_mte,
-                  gen_helper_sve_ldffhdu_be_zd_mte,
-                  gen_helper_sve_ldffsdu_be_zd_mte,
-                  gen_helper_sve_ldffdd_be_zd_mte, } } } } },
+      /* First-fault */
+      { { { gen_helper_sve_ldffbds_zsu,
+            gen_helper_sve_ldffhds_be_zsu,
+            gen_helper_sve_ldffsds_be_zsu,
+            NULL, },
+          { gen_helper_sve_ldffbdu_zsu,
+            gen_helper_sve_ldffhdu_be_zsu,
+            gen_helper_sve_ldffsdu_be_zsu,
+            gen_helper_sve_ldffdd_be_zsu, } },
+        { { gen_helper_sve_ldffbds_zss,
+            gen_helper_sve_ldffhds_be_zss,
+            gen_helper_sve_ldffsds_be_zss,
+            NULL, },
+          { gen_helper_sve_ldffbdu_zss,
+            gen_helper_sve_ldffhdu_be_zss,
+            gen_helper_sve_ldffsdu_be_zss,
+            gen_helper_sve_ldffdd_be_zss, } },
+        { { gen_helper_sve_ldffbds_zd,
+            gen_helper_sve_ldffhds_be_zd,
+            gen_helper_sve_ldffsds_be_zd,
+            NULL, },
+          { gen_helper_sve_ldffbdu_zd,
+            gen_helper_sve_ldffhdu_be_zd,
+            gen_helper_sve_ldffsdu_be_zd,
+            gen_helper_sve_ldffdd_be_zd, } } } }
 };
 
 static bool trans_LD1_zprz(DisasContext *s, arg_LD1_zprz *a)
 {
     gen_helper_gvec_mem_scatter *fn = NULL;
     bool be = s->be_data == MO_BE;
-    bool mte = s->mte_active[0];
 
     if (!dc_isar_feature(aa64_sve, s)) {
         return false;
@@ -5589,10 +5244,10 @@ static bool trans_LD1_zprz(DisasContext *s, arg_LD1_zprz *a)
 
     switch (a->esz) {
     case MO_32:
-        fn = gather_load_fn32[mte][be][a->ff][a->xs][a->u][a->msz];
+        fn = gather_load_fn32[be][a->ff][a->xs][a->u][a->msz];
         break;
     case MO_64:
-        fn = gather_load_fn64[mte][be][a->ff][a->xs][a->u][a->msz];
+        fn = gather_load_fn64[be][a->ff][a->xs][a->u][a->msz];
         break;
     }
     assert(fn != NULL);
@@ -5606,7 +5261,6 @@ static bool trans_LD1_zpiz(DisasContext *s, arg_LD1_zpiz *a)
 {
     gen_helper_gvec_mem_scatter *fn = NULL;
     bool be = s->be_data == MO_BE;
-    bool mte = s->mte_active[0];
 
     if (a->esz < a->msz || (a->esz == a->msz && !a->u)) {
         return false;
@@ -5621,10 +5275,10 @@ static bool trans_LD1_zpiz(DisasContext *s, arg_LD1_zpiz *a)
 
     switch (a->esz) {
     case MO_32:
-        fn = gather_load_fn32[mte][be][a->ff][0][a->u][a->msz];
+        fn = gather_load_fn32[be][a->ff][0][a->u][a->msz];
         break;
     case MO_64:
-        fn = gather_load_fn64[mte][be][a->ff][2][a->u][a->msz];
+        fn = gather_load_fn64[be][a->ff][2][a->u][a->msz];
         break;
     }
     assert(fn != NULL);
@@ -5641,7 +5295,6 @@ static bool trans_LDNT1_zprz(DisasContext *s, arg_LD1_zprz *a)
 {
     gen_helper_gvec_mem_scatter *fn = NULL;
     bool be = s->be_data == MO_BE;
-    bool mte = s->mte_active[0];
 
     if (a->esz < a->msz + !a->u) {
         return false;
@@ -5656,10 +5309,10 @@ static bool trans_LDNT1_zprz(DisasContext *s, arg_LD1_zprz *a)
 
     switch (a->esz) {
     case MO_32:
-        fn = gather_load_fn32[mte][be][0][0][a->u][a->msz];
+        fn = gather_load_fn32[be][0][0][a->u][a->msz];
         break;
     case MO_64:
-        fn = gather_load_fn64[mte][be][0][2][a->u][a->msz];
+        fn = gather_load_fn64[be][0][2][a->u][a->msz];
         break;
     }
     assert(fn != NULL);
@@ -5669,103 +5322,58 @@ static bool trans_LDNT1_zprz(DisasContext *s, arg_LD1_zprz *a)
     return true;
 }
 
-/* Indexed by [mte][be][xs][msz].  */
-static gen_helper_gvec_mem_scatter * const scatter_store_fn32[2][2][2][3] = {
-    { /* MTE Inactive */
-        { /* Little-endian */
-            { gen_helper_sve_stbs_zsu,
-              gen_helper_sve_sths_le_zsu,
-              gen_helper_sve_stss_le_zsu, },
-            { gen_helper_sve_stbs_zss,
-              gen_helper_sve_sths_le_zss,
-              gen_helper_sve_stss_le_zss, } },
-        { /* Big-endian */
-            { gen_helper_sve_stbs_zsu,
-              gen_helper_sve_sths_be_zsu,
-              gen_helper_sve_stss_be_zsu, },
-            { gen_helper_sve_stbs_zss,
-              gen_helper_sve_sths_be_zss,
-              gen_helper_sve_stss_be_zss, } } },
-    { /* MTE Active */
-        { /* Little-endian */
-            { gen_helper_sve_stbs_zsu_mte,
-              gen_helper_sve_sths_le_zsu_mte,
-              gen_helper_sve_stss_le_zsu_mte, },
-            { gen_helper_sve_stbs_zss_mte,
-              gen_helper_sve_sths_le_zss_mte,
-              gen_helper_sve_stss_le_zss_mte, } },
-        { /* Big-endian */
-            { gen_helper_sve_stbs_zsu_mte,
-              gen_helper_sve_sths_be_zsu_mte,
-              gen_helper_sve_stss_be_zsu_mte, },
-            { gen_helper_sve_stbs_zss_mte,
-              gen_helper_sve_sths_be_zss_mte,
-              gen_helper_sve_stss_be_zss_mte, } } },
+/* Indexed by [be][xs][msz].  */
+static gen_helper_gvec_mem_scatter * const scatter_store_fn32[2][2][3] = {
+    /* Little-endian */
+    { { gen_helper_sve_stbs_zsu,
+        gen_helper_sve_sths_le_zsu,
+        gen_helper_sve_stss_le_zsu, },
+      { gen_helper_sve_stbs_zss,
+        gen_helper_sve_sths_le_zss,
+        gen_helper_sve_stss_le_zss, } },
+    /* Big-endian */
+    { { gen_helper_sve_stbs_zsu,
+        gen_helper_sve_sths_be_zsu,
+        gen_helper_sve_stss_be_zsu, },
+      { gen_helper_sve_stbs_zss,
+        gen_helper_sve_sths_be_zss,
+        gen_helper_sve_stss_be_zss, } }
 };
 
 /* Note that we overload xs=2 to indicate 64-bit offset.  */
-static gen_helper_gvec_mem_scatter * const scatter_store_fn64[2][2][3][4] = {
-    { /* MTE Inactive */
-         { /* Little-endian */
-             { gen_helper_sve_stbd_zsu,
-               gen_helper_sve_sthd_le_zsu,
-               gen_helper_sve_stsd_le_zsu,
-               gen_helper_sve_stdd_le_zsu, },
-             { gen_helper_sve_stbd_zss,
-               gen_helper_sve_sthd_le_zss,
-               gen_helper_sve_stsd_le_zss,
-               gen_helper_sve_stdd_le_zss, },
-             { gen_helper_sve_stbd_zd,
-               gen_helper_sve_sthd_le_zd,
-               gen_helper_sve_stsd_le_zd,
-               gen_helper_sve_stdd_le_zd, } },
-         { /* Big-endian */
-             { gen_helper_sve_stbd_zsu,
-               gen_helper_sve_sthd_be_zsu,
-               gen_helper_sve_stsd_be_zsu,
-               gen_helper_sve_stdd_be_zsu, },
-             { gen_helper_sve_stbd_zss,
-               gen_helper_sve_sthd_be_zss,
-               gen_helper_sve_stsd_be_zss,
-               gen_helper_sve_stdd_be_zss, },
-             { gen_helper_sve_stbd_zd,
-               gen_helper_sve_sthd_be_zd,
-               gen_helper_sve_stsd_be_zd,
-               gen_helper_sve_stdd_be_zd, } } },
-    { /* MTE Inactive */
-         { /* Little-endian */
-             { gen_helper_sve_stbd_zsu_mte,
-               gen_helper_sve_sthd_le_zsu_mte,
-               gen_helper_sve_stsd_le_zsu_mte,
-               gen_helper_sve_stdd_le_zsu_mte, },
-             { gen_helper_sve_stbd_zss_mte,
-               gen_helper_sve_sthd_le_zss_mte,
-               gen_helper_sve_stsd_le_zss_mte,
-               gen_helper_sve_stdd_le_zss_mte, },
-             { gen_helper_sve_stbd_zd_mte,
-               gen_helper_sve_sthd_le_zd_mte,
-               gen_helper_sve_stsd_le_zd_mte,
-               gen_helper_sve_stdd_le_zd_mte, } },
-         { /* Big-endian */
-             { gen_helper_sve_stbd_zsu_mte,
-               gen_helper_sve_sthd_be_zsu_mte,
-               gen_helper_sve_stsd_be_zsu_mte,
-               gen_helper_sve_stdd_be_zsu_mte, },
-             { gen_helper_sve_stbd_zss_mte,
-               gen_helper_sve_sthd_be_zss_mte,
-               gen_helper_sve_stsd_be_zss_mte,
-               gen_helper_sve_stdd_be_zss_mte, },
-             { gen_helper_sve_stbd_zd_mte,
-               gen_helper_sve_sthd_be_zd_mte,
-               gen_helper_sve_stsd_be_zd_mte,
-               gen_helper_sve_stdd_be_zd_mte, } } },
+static gen_helper_gvec_mem_scatter * const scatter_store_fn64[2][3][4] = {
+    /* Little-endian */
+    { { gen_helper_sve_stbd_zsu,
+        gen_helper_sve_sthd_le_zsu,
+        gen_helper_sve_stsd_le_zsu,
+        gen_helper_sve_stdd_le_zsu, },
+      { gen_helper_sve_stbd_zss,
+        gen_helper_sve_sthd_le_zss,
+        gen_helper_sve_stsd_le_zss,
+        gen_helper_sve_stdd_le_zss, },
+      { gen_helper_sve_stbd_zd,
+        gen_helper_sve_sthd_le_zd,
+        gen_helper_sve_stsd_le_zd,
+        gen_helper_sve_stdd_le_zd, } },
+    /* Big-endian */
+    { { gen_helper_sve_stbd_zsu,
+        gen_helper_sve_sthd_be_zsu,
+        gen_helper_sve_stsd_be_zsu,
+        gen_helper_sve_stdd_be_zsu, },
+      { gen_helper_sve_stbd_zss,
+        gen_helper_sve_sthd_be_zss,
+        gen_helper_sve_stsd_be_zss,
+        gen_helper_sve_stdd_be_zss, },
+      { gen_helper_sve_stbd_zd,
+        gen_helper_sve_sthd_be_zd,
+        gen_helper_sve_stsd_be_zd,
+        gen_helper_sve_stdd_be_zd, } }
 };
 
 static bool trans_ST1_zprz(DisasContext *s, arg_ST1_zprz *a)
 {
     gen_helper_gvec_mem_scatter *fn;
     bool be = s->be_data == MO_BE;
-    bool mte = s->mte_active[0];
 
     if (a->esz < a->msz || (a->msz == 0 && a->scale)) {
         return false;
@@ -5779,10 +5387,10 @@ static bool trans_ST1_zprz(DisasContext *s, arg_ST1_zprz *a)
     }
     switch (a->esz) {
     case MO_32:
-        fn = scatter_store_fn32[mte][be][a->xs][a->msz];
+        fn = scatter_store_fn32[be][a->xs][a->msz];
         break;
     case MO_64:
-        fn = scatter_store_fn64[mte][be][a->xs][a->msz];
+        fn = scatter_store_fn64[be][a->xs][a->msz];
         break;
     default:
         g_assert_not_reached();
@@ -5796,7 +5404,6 @@ static bool trans_ST1_zpiz(DisasContext *s, arg_ST1_zpiz *a)
 {
     gen_helper_gvec_mem_scatter *fn = NULL;
     bool be = s->be_data == MO_BE;
-    bool mte = s->mte_active[0];
 
     if (a->esz < a->msz) {
         return false;
@@ -5811,10 +5418,10 @@ static bool trans_ST1_zpiz(DisasContext *s, arg_ST1_zpiz *a)
 
     switch (a->esz) {
     case MO_32:
-        fn = scatter_store_fn32[mte][be][0][a->msz];
+        fn = scatter_store_fn32[be][0][a->msz];
         break;
     case MO_64:
-        fn = scatter_store_fn64[mte][be][2][a->msz];
+        fn = scatter_store_fn64[be][2][a->msz];
         break;
     }
     assert(fn != NULL);
@@ -5831,7 +5438,6 @@ static bool trans_STNT1_zprz(DisasContext *s, arg_ST1_zprz *a)
 {
     gen_helper_gvec_mem_scatter *fn;
     bool be = s->be_data == MO_BE;
-    bool mte = s->mte_active[0];
 
     if (a->esz < a->msz) {
         return false;
@@ -5846,10 +5452,10 @@ static bool trans_STNT1_zprz(DisasContext *s, arg_ST1_zprz *a)
 
     switch (a->esz) {
     case MO_32:
-        fn = scatter_store_fn32[mte][be][0][a->msz];
+        fn = scatter_store_fn32[be][0][a->msz];
         break;
     case MO_64:
-        fn = scatter_store_fn64[mte][be][2][a->msz];
+        fn = scatter_store_fn64[be][2][a->msz];
         break;
     default:
         g_assert_not_reached();
-- 
2.34.1


