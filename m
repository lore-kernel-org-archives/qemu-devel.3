Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07EDDC88E72
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 04:33:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x73nm-00025J-PG; Thu, 17 Sep 2026 00:32:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x73nJ-0001U3-0D
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 00:32:22 -0400
Received: from mail-pj2-x11.google.com ([2607:f8b0:4864:39::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x73nF-0007DG-2K
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 00:32:18 -0400
Received: by mail-pj2-x11.google.com with SMTP id
 98e67ed59e1d1-398c066106cso295705a91.1
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 21:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789619535; x=1790224335; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=dXkmkZQRdy1MWhyM8kA5bqNu3zOHMZSLy0pvwRwNPE0=;
 b=wZK5or4bVn0qpXfh8gGWV/v+vGDN3tEMb8tYR+ZceL8yTZXb70yUc4MlynHjf+nnBh
 PVwLYTNJgDgME6Jk7eaEtUkc1sU5/zJSec1pUKdVpYnnYATV9LHNIhA3pcuYuR4c/GyZ
 jxs1pkLFpJO6IEDoMVAeF0uJEIWsFyKbJZKpn3yJZYjSM1o78pW2pHIG5Z2DNnChBxSb
 /VxY6jhqT40ZauTLa0TaG9qIINY4pCL8d1XEsPzGllFWieI+HRWhRPjvfbp4OZVR2pTz
 bE6lEtVyV8OZOol9f9393UuLd72+PXkxQABxTyOnFIE/NnvVlyfbraQzGB1VnuM+7o0u
 rWIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789619535; x=1790224335;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=dXkmkZQRdy1MWhyM8kA5bqNu3zOHMZSLy0pvwRwNPE0=;
 b=0APR1X99kqw3tpQ9YfmBv9+2tlLxXnMavmTARqYXUzLfk29eOMu4plDW6yiMINhYSR
 MqIfV6lb9Hjv+c+oLzY3XUz1itLCNZGBE0ByPVD4N7kS7rfGoilrzd2W6vYseRpFQBRN
 vpPEESgtJ1vf7npeNYigYo1j3TqkutEwYaaAsjOtISwUVNEcPuzH2TfSIpdOziSozJiL
 YXugX56mKXx2Zg+B/TMTJzH3J0cPymCVQVhgHqRsMmGQ/S5aQsYXVSyE+DJNcKMHinEj
 bfMj5vqlc1764nRIC6WPK/526y2yyTyqnifnG+hvJtuCaWcbX5CT+MftNHpT8ojCIe8x
 DHiQ==
X-Gm-Message-State: AFuF++knOGecBg57BSVv7tbhfB4gDgYJoPiTDTDLvew64u/WccvItU/p
 ejlNHaIWeoxTCQV+GhKoC6aN1VsmHkgd3UN1GpnDTz+1nn5BLuL6r+qXV78UWsqDRKyN20TlohE
 R70VG0u0=
X-Gm-Gg: AYBFou3RPSe7TiW4iSoDKGF9oBSLO07uk5g+VlqprfzN7zAH8mEm8+Igpei4ih/GmV8
 9THhplXPHNBW/KlJQt7RlupG1RaYZekvqkk99fmW7+CJuBZJ9nCAdRaQNZ1om60WdIuVVfH1FzD
 wIaLrahSaSIN3Z3Pf0kgQChoSt6KZtkHex3jcCAQX/EZS3kEizGQvKyc5ialy/xnS8AnktOAYir
 mfBKcQgIkujTQEEiXQHMfb5j6S/GqBvkbG/ZGdSpDwfCboLipyx8c+SagsFoOk+VIlgHTaKrJen
 1JTte7GVKrLMTD2Zpfjw9M4+RifM3gKEGlHc/weOnISsLkbc20vPiFojZTH3Q8u3p4LbkkBwz75
 uW2jIvTkPZ844QBFU0gwic8x4hDIfwhqfpsXPFy5CB/sKh5cgb2EjTrdMuPk7Bhc3hYauZT2cWL
 0JSZRfdqdC54Fp7iXyg6RZNcf4PHizt633iQuSxLOLUPA0bFq7wwLaPiwjrv3jHenuPK1YrP7ww
 y0MqKw=
X-Received: by 2002:a17:90b:544e:b0:39e:35e4:d31b with SMTP id
 98e67ed59e1d1-39e35e4d992mr8960344a91.5.1789619535471; 
 Wed, 16 Sep 2026 21:32:15 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:325f:1938:d075:8c13])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14395d13cb7sm10501878c88.7.2026.09.16.21.32.14
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 21:32:15 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 046/101] tcg: Generic expansion of tcg_gen_setcondi_*
Date: Wed, 16 Sep 2026 18:27:28 -1000
Message-ID: <20260917042823.542588-47-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917042823.542588-1-richard.henderson@linaro.org>
References: <20260917042823.542588-1-richard.henderson@linaro.org>
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-op-common.h  |  4 ----
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 18 ++++++------------
 3 files changed, 7 insertions(+), 16 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 2df3fe5f6a8..c3fd467400e 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -146,8 +146,6 @@ void tcg_gen_sextract_i32(TCGv_i32 ret, TCGv_i32 arg,
                           unsigned int ofs, unsigned int len);
 void tcg_gen_extract2_i32(TCGv_i32 ret, TCGv_i32 al, TCGv_i32 ah,
                           unsigned int ofs);
-void tcg_gen_setcondi_i32(TCGCond cond, TCGv_i32 ret,
-                          TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_negsetcond_i32(TCGCond cond, TCGv_i32 ret,
                             TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_negsetcondi_i32(TCGCond cond, TCGv_i32 ret,
@@ -215,8 +213,6 @@ void tcg_gen_sextract_i64(TCGv_i64 ret, TCGv_i64 arg,
                           unsigned int ofs, unsigned int len);
 void tcg_gen_extract2_i64(TCGv_i64 ret, TCGv_i64 al, TCGv_i64 ah,
                           unsigned int ofs);
-void tcg_gen_setcondi_i64(TCGCond cond, TCGv_i64 ret,
-                          TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_negsetcond_i64(TCGCond cond, TCGv_i64 ret,
                             TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_negsetcondi_i64(TCGCond cond, TCGv_i64 ret,
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 6ce86d2005a..42e0fde523a 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -27,6 +27,7 @@ DEF3(remu, TCGV, TCGV, TCGV)
 DEF3(sar, TCGV, TCGV, TCGV)
 DEF3(sari, TCGV, TCGV, TINT)
 DEF4(setcond, TCGCond, TCGV, TCGV, TCGV)
+DEF4(setcondi, TCGCond, TCGV, TCGV, TINT)
 DEF3(shl, TCGV, TCGV, TCGV)
 DEF3(shli, TCGV, TCGV, TINT)
 DEF3(shr, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 762888aef40..38902e4b54b 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -691,6 +691,12 @@ static void gen_setcond(TCGType type, TCGCond cond, TCGTemp *dst,
     }
 }
 
+static void gen_setcondi(TCGType type, TCGCond cond, TCGTemp *dst,
+                         TCGTemp *src1, int64_t src2)
+{
+    gen_setcond(type, cond, dst, src1, tcg_constant_internal(type, src2));
+}
+
 static void gen_shl(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     gen_op_ttt(INDEX_op_shl, type, dst, src1, src2);
@@ -759,12 +765,6 @@ static void gen_xori(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
 
 /* 32 bit ops */
 
-void tcg_gen_setcondi_i32(TCGCond cond, TCGv_i32 ret,
-                          TCGv_i32 arg1, int32_t arg2)
-{
-    tcg_gen_setcond_i32(cond, ret, arg1, tcg_constant_i32(arg2));
-}
-
 void tcg_gen_negsetcond_i32(TCGCond cond, TCGv_i32 ret,
                             TCGv_i32 arg1, TCGv_i32 arg2)
 {
@@ -1537,12 +1537,6 @@ void tcg_gen_st_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset)
     tcg_gen_ldst_op_i64(INDEX_op_st, arg1, arg2, offset);
 }
 
-void tcg_gen_setcondi_i64(TCGCond cond, TCGv_i64 ret,
-                          TCGv_i64 arg1, int64_t arg2)
-{
-    tcg_gen_setcond_i64(cond, ret, arg1, tcg_constant_i64(arg2));
-}
-
 void tcg_gen_negsetcondi_i64(TCGCond cond, TCGv_i64 ret,
                              TCGv_i64 arg1, int64_t arg2)
 {
-- 
2.53.0


