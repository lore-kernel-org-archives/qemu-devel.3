Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02265C5DF86
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 17:03:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwNCa-0007RG-DX; Tue, 18 Aug 2026 13:02:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wwNCY-0007R1-VR
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 13:02:14 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wwNCX-0004iU-5I
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 13:02:14 -0400
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-cc11a905ba5so8685a12.2
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 10:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787072532; x=1787677332; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Bmvs7eVPvDWK8RxG5EpSR43ByOKageHH4+EN9ul0Uio=;
 b=l34N+H5zIAb1DGiOopJd5cpKdKZckplE1aH0z//TxM0Ngo2DxPJmstkTZp3nTlBtI5
 FkQrmbF4xUQfszc0AbI6a30GdbOnDtUBVkT4pTr2ylFdR2KRdaB6eliXk2bqOx6ZVfV5
 ysbifmbCGEkgTA6xJ5m9OcfMD5YQxOXl1slacQG4OY4GfxEnQhO/1L9oABCUk1W8E3yf
 m0lpLpIdU/BhULFBKCX5z56useGPkWmhdIzNyk0bo32y8MiMpco/wjphrUJBg9FL7U3h
 CzqYIuwQI1FFofvp4rql6ReX8M7dv33tVhpzrnELL72phHpxin8ih5cuwFuUJhNiYnes
 wnng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787072532; x=1787677332;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Bmvs7eVPvDWK8RxG5EpSR43ByOKageHH4+EN9ul0Uio=;
 b=aWjM2pgZV86lkDRxKBp09iQK6ezSGhGQxFxIGbjenxoJdxKNBqbRKvjQ3HY1iriq3n
 HSivNojrwT8w67h/Vrn213+EYKJUlUB4q/VIh53PhusX21unVCITYpVo94Ag4xjU7+ou
 dzPwpcAle49HoNSHIG/dF9Ymp7sHhXPAdEdeVSKAkQ+IqOoyzRiwTfpb85RPCoKnTZN5
 xutJJr6we6S87mqxTLRrmcmNHR9qHP+0Otg4YgvrbhhQcYXrdj+qYT7VEQ8n7pqMDrQT
 VxY5Hhx43IlcX5xLqmtPNyrOyRA8KL7Ultz+7TqNQhEIUOVBbdA8PTW7VMvp34Ma8GZm
 dXJw==
X-Gm-Message-State: AOJu0Ywc8C61hAaJ4Df3R4k8huvrH0WBUQYolUbWNwMI7l2YOj3BvL2f
 ff545erNkAfbsKbt2fWN5FJohSRebASC71wX0NZajOEUPYSoeDiOHqIrOoRgN9H3g7Pfkyb4hR6
 6MeX1HxE=
X-Gm-Gg: AR+sD11Ux6BfN0ubtU2T7hYOWS29f2DStXvszGAeOj/MPAVcW/B4PqBt7CPCnm6FdXu
 SbPr4MxwjmV3ahYOr1fe2v0RzVGaq2rEzydaufeInnSjbiUlWPYGgpvfnA83cnFJVba59voEkfd
 FmOnZ/n2kp4/er/AoWVFwvIVJH/GfOy8EO+BCmtVaxgLtgimw6UR1vNz9F5A856DM9JrcjrIyYN
 W/pF5U7/u0FQl3FpNxwCUkutE6CvRnnoJ4yi0uvQTp0uiPO/IlvFVUNBWQwFehWtxiMm5A0WXrN
 t4E00kpNyoRKwSw4BmngVusMP6wJ/O7GdyUHoutd+5DnPdlfbQd1NyY9YFmdfxLZn+lA84wwAA0
 KfoDtYlgJ/B7/Dt7nv2sPpgIDmyaYaPHZOkuXnX2EWuF913xsL0/HlgmEZ6szTIfOzHBNeGcypA
 bHyS8hNC8Ikz4BB/zctJXQrDm0gdAO5SejSlebvt0Yl6Dvd4lPl5XFBl7fC+9ZZHurwUyAntbFh
 cdTfcDkQWh7ESn33UWLExLqszDo2quhUPM=
X-Received: by 2002:a05:6a00:1489:b0:847:9aa8:d3ce with SMTP id
 d2e1a72fcca58-84fde14ff2emr36148104b3a.2.1787072531510; 
 Tue, 18 Aug 2026 10:02:11 -0700 (PDT)
Received: from stoup.. (c-73-181-156-132.hsd1.wa.comcast.net. [73.181.156.132])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-851b401e10bsm2108314b3a.12.2026.08.18.10.02.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 10:02:11 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Song Gao <17746591750@163.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PULL 11/38] target/loongarch: Use generic tcg_gen_revbit*
Date: Tue, 18 Aug 2026 10:01:28 -0700
Message-ID: <20260818170155.1907006-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818170155.1907006-1-richard.henderson@linaro.org>
References: <20260818170155.1907006-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x533.google.com
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

Reviewed-by: Song Gao <17746591750@163.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/loongarch/tcg/helper.h                 |  4 ----
 target/loongarch/tcg/op_helper.c              | 21 -------------------
 .../loongarch/tcg/insn_trans/trans_bit.c.inc  | 13 ++++++++----
 3 files changed, 9 insertions(+), 29 deletions(-)

diff --git a/target/loongarch/tcg/helper.h b/target/loongarch/tcg/helper.h
index 8a6c62f116..e76c73c775 100644
--- a/target/loongarch/tcg/helper.h
+++ b/target/loongarch/tcg/helper.h
@@ -5,10 +5,6 @@
 
 DEF_HELPER_2(raise_exception, noreturn, env, i32)
 
-DEF_HELPER_FLAGS_1(bitrev_w, TCG_CALL_NO_RWG_SE, tl, tl)
-DEF_HELPER_FLAGS_1(bitrev_d, TCG_CALL_NO_RWG_SE, tl, tl)
-DEF_HELPER_FLAGS_1(bitswap, TCG_CALL_NO_RWG_SE, tl, tl)
-
 DEF_HELPER_FLAGS_3(asrtle_d, TCG_CALL_NO_WG, void, env, tl, tl)
 DEF_HELPER_FLAGS_3(asrtgt_d, TCG_CALL_NO_WG, void, env, tl, tl)
 
diff --git a/target/loongarch/tcg/op_helper.c b/target/loongarch/tcg/op_helper.c
index e63ac66daa..f41f0cb1e6 100644
--- a/target/loongarch/tcg/op_helper.c
+++ b/target/loongarch/tcg/op_helper.c
@@ -22,27 +22,6 @@ void helper_raise_exception(CPULoongArchState *env, uint32_t exception)
     do_raise_exception(env, exception, GETPC());
 }
 
-target_ulong helper_bitrev_w(target_ulong rj)
-{
-    return (int32_t)revbit32(rj);
-}
-
-target_ulong helper_bitrev_d(target_ulong rj)
-{
-    return revbit64(rj);
-}
-
-target_ulong helper_bitswap(target_ulong v)
-{
-    v = ((v >> 1) & (target_ulong)0x5555555555555555ULL) |
-        ((v & (target_ulong)0x5555555555555555ULL) << 1);
-    v = ((v >> 2) & (target_ulong)0x3333333333333333ULL) |
-        ((v & (target_ulong)0x3333333333333333ULL) << 2);
-    v = ((v >> 4) & (target_ulong)0x0F0F0F0F0F0F0F0FULL) |
-        ((v & (target_ulong)0x0F0F0F0F0F0F0F0FULL) << 4);
-    return v;
-}
-
 /* loongarch assert op */
 void helper_asrtle_d(CPULoongArchState *env, target_ulong rj, target_ulong rk)
 {
diff --git a/target/loongarch/tcg/insn_trans/trans_bit.c.inc b/target/loongarch/tcg/insn_trans/trans_bit.c.inc
index ee5fa003ce..b91bb7eaa6 100644
--- a/target/loongarch/tcg/insn_trans/trans_bit.c.inc
+++ b/target/loongarch/tcg/insn_trans/trans_bit.c.inc
@@ -178,6 +178,11 @@ static void gen_masknez(TCGv dest, TCGv src1, TCGv src2)
     tcg_gen_movcond_tl(TCG_COND_NE, dest, src2, zero, zero, src1);
 }
 
+static void gen_bitrev_w(TCGv dest, TCGv src)
+{
+    tcg_gen_revbit32_tl(dest, src, TCG_BSWAP_OS);
+}
+
 TRANS(ext_w_h, ALL, gen_rr, EXT_NONE, EXT_NONE, tcg_gen_ext16s_tl)
 TRANS(ext_w_b, ALL, gen_rr, EXT_NONE, EXT_NONE, tcg_gen_ext8s_tl)
 TRANS(clo_w, ALL, gen_rr, EXT_NONE, EXT_NONE, gen_clo_w)
@@ -194,10 +199,10 @@ TRANS(revb_2w, 64, gen_rr, EXT_NONE, EXT_NONE, gen_revb_2w)
 TRANS(revb_d, 64, gen_rr, EXT_NONE, EXT_NONE, tcg_gen_bswap64_i64)
 TRANS(revh_2w, 64, gen_rr, EXT_NONE, EXT_NONE, gen_revh_2w)
 TRANS(revh_d, 64, gen_rr, EXT_NONE, EXT_NONE, gen_revh_d)
-TRANS(bitrev_4b, ALL, gen_rr, EXT_ZERO, EXT_SIGN, gen_helper_bitswap)
-TRANS(bitrev_8b, 64, gen_rr, EXT_NONE, EXT_NONE, gen_helper_bitswap)
-TRANS(bitrev_w, ALL, gen_rr, EXT_NONE, EXT_SIGN, gen_helper_bitrev_w)
-TRANS(bitrev_d, 64, gen_rr, EXT_NONE, EXT_NONE, gen_helper_bitrev_d)
+TRANS(bitrev_4b, ALL, gen_rr, EXT_NONE, EXT_SIGN, tcg_gen_revbit8_i64)
+TRANS(bitrev_8b, 64, gen_rr, EXT_NONE, EXT_NONE, tcg_gen_revbit8_i64)
+TRANS(bitrev_w, ALL, gen_rr, EXT_NONE, EXT_NONE, gen_bitrev_w)
+TRANS(bitrev_d, 64, gen_rr, EXT_NONE, EXT_NONE, tcg_gen_revbit64_i64)
 TRANS(maskeqz, ALL, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, gen_maskeqz)
 TRANS(masknez, ALL, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, gen_masknez)
 TRANS(bytepick_w, ALL, gen_rrr_sa, EXT_NONE, EXT_NONE, gen_bytepick_w)
-- 
2.43.0


