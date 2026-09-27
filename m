Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75B63C98324
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 09:14:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAksM-0007RD-10; Sun, 27 Sep 2026 05:08:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAkrb-0002Vz-4Q
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 05:08:03 -0400
Received: from mail-pj2-x10.google.com ([2607:f8b0:4864:39::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAkrZ-0008IK-Bg
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 05:08:02 -0400
Received: by mail-pj2-x10.google.com with SMTP id
 98e67ed59e1d1-398cb5615deso1779484a91.3
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 02:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790500080; x=1791104880; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3Xlg19gLajgUhYwe4YmuEahkgDDR3SjKfWeD/LdU7cQ=;
 b=XFd7y9kqsu4vR/sRXwV5hkmuKSxEc7THfZz04NoncFl10A8mPsd9B4pZ/Cq5ant4Ya
 1wkhzj+1nmpuCFj+EKMX3k23wzs4YivtD2H5wlkxwjT9co5F5rR0rVd0dGchVIx8TvRW
 klbVv6bqbYjSQ9qbJzgSHKQuDG//DKW2RCGftHqj8tYbdVIk2veZE36vuMKkCXw4tyn0
 wW59mdYahgEnx6pnRHAmnUBoDcNXpzUMqjVm9fYPxdd+yF2CwTdJyHuA639D0eMqeFYQ
 3WN3wCNwiWdfY5xW9ZzC4tzY0aVAjOnDnZ7jDvhTREyCPH/yO2iI69kxz3QH+ACwmz5m
 gJmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790500080; x=1791104880;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=3Xlg19gLajgUhYwe4YmuEahkgDDR3SjKfWeD/LdU7cQ=;
 b=s8OOvKiO1zKhEdB41Z2XI1ztDcojITEcVySp3UuW+I5BFt1NPs2Zra/zUevmVWdRsR
 sXIRKlxb7nI5cfNB3NydBu/xu8UEKKXn0IP3NgLwOKkGSo9uqHvkA2avd0pkQMNaMFYY
 0QSw0R4RkHsCZg2TwcjHudJ65p0l1WusEE6htr5KE2w/Un/5DKkSA9h6NQiKa/sD2+65
 U4EcjJtvIV6ve4WTXATosS4XUUePpZ/+Bpw8/khn7/YLy5Cngaq+R8wcqO4BuE4yeZgc
 rM9xJAiNbRea7tMxQX1f0uL8g0OLTi7yh6HtuO0FPUOymoP/jauZiuPj+TwkvcrXEY0h
 prtA==
X-Gm-Message-State: AFq9FYIhLmbCxwW/9bD9AL0Xkyx1uQjRl18fHOOZTUSow5xZZmNbAvNz
 UQPu5zza+H/p66FJjHIHRVdyC+VBtlm3IVShvGsSb/z2eIW+VNOCBYnqhdQMYmjKAcYj2jrqZ7V
 7lZX6
X-Gm-Gg: AYBFou3VrHvqGh5oRjhuXM2nOU6z9fzx0tx58FzPMPLwWwIbFYOQwwWJqAhMviy3KHV
 AZrfCZoMswfMkXXn8z/IqUsm+ncaWzBV8Q8E8oZb2/KDcRzpzCiFTWM3cUAzYkZCoM/pw78wsFJ
 WjN9BhmVfcGarGpMyR/aOdf5DXu5XpPNsMecyYc/Jwc/SJtRw951NXDr9jLlm840tCWMBKwzY9B
 yACuzkipt3qDheR2k4ZAO6bULCrR05n8XeovJzLF3111oYseH62tZINaUOaSLvPCZlh1/R7Ni0V
 CjR2OwQT2A0DrBh+zQ8gssvTGyQuejIQ8wwSRiW7okWvcLkNVoPVIWWSBvPxwwvPrqmHKuPouir
 9gTAgPO1j8q4FWNCGfM05M5YxCgVMnw2L672IhItk6Ssd/FRrm9G8ME87OBbZaNf3xqox284YkC
 LOkZ5uJ17bjoHmqtPZECvkUV/kl1ud6y5pC6Y4Zv25l3CXde5gm/bxKsWruBnB9ad9v9FzjcEkU
 RXZWOvOgIuTdNEXy8oGdzF40tkhNw==
X-Received: by 2002:a17:90b:440d:b0:395:7fff:a08f with SMTP id
 98e67ed59e1d1-3a09860fe05mr8348736a91.0.1790500079903; 
 Sun, 27 Sep 2026 02:07:59 -0700 (PDT)
Received: from stoup (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a0e7036e3bsm7144984a91.13.2026.09.27.02.07.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Sep 2026 02:07:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH v5 096/101] tcg: Generic expansion of tcg_gen_dup_*
Date: Sun, 27 Sep 2026 02:00:06 -0700
Message-ID: <20260927090011.10724-97-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260927090011.10724-1-richard.henderson@linaro.org>
References: <20260927090011.10724-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::10;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x10.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-op-common.h  |  6 ------
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op-gvec.c            | 41 ------------------------------------
 tcg/tcg-op.c                 | 16 ++++++++++++++
 4 files changed, 17 insertions(+), 47 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 65b9d828e38..583f6ebb2f5 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -137,9 +137,6 @@ void tcg_gen_bswap32_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_hswap_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_revbit32_i32(TCGv_i32 ret, TCGv_i32 arg);
 
-/* Replicate a value of size @vece from @in to all the lanes in @out */
-void tcg_gen_dup_i32(unsigned vece, TCGv_i32 out, TCGv_i32 in);
-
 /* 64 bit ops */
 
 void tcg_gen_addN_i64(int n, TCGv_i64 *r, TCGv_i64 *a, TCGv_i64 *b);
@@ -153,9 +150,6 @@ void tcg_gen_wswap_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_revbit32_i64(TCGv_i64 ret, TCGv_i64 arg, unsigned flags);
 void tcg_gen_revbit64_i64(TCGv_i64 ret, TCGv_i64 arg);
 
-/* Replicate a value of size @vece from @in to all the lanes in @out */
-void tcg_gen_dup_i64(unsigned vece, TCGv_i64 out, TCGv_i64 in);
-
 void tcg_gen_st32_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
 void tcg_gen_ld32u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index f9dab50a911..556f7470cd6 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -23,6 +23,7 @@ DEF4(deposit_z, TCGV, TCGV, unsigned, unsigned)
 DEF1(discard, TCGV)
 DEF3(div, TCGV, TCGV, TCGV)
 DEF3(divu, TCGV, TCGV, TCGV)
+DEF3(dup, unsigned, TCGV, TCGV)
 DEF3(ext, TCGV, TCGV, MemOp)
 DEF2(ext8s, TCGV, TCGV)
 DEF2(ext8u, TCGV, TCGV)
diff --git a/tcg/tcg-op-gvec.c b/tcg/tcg-op-gvec.c
index 0d649cc13b2..72abb0a08ec 100644
--- a/tcg/tcg-op-gvec.c
+++ b/tcg/tcg-op-gvec.c
@@ -434,47 +434,6 @@ uint64_t (dup_const)(unsigned vece, uint64_t c)
     }
 }
 
-/* Duplicate IN into OUT as per VECE.  */
-void tcg_gen_dup_i32(unsigned vece, TCGv_i32 out, TCGv_i32 in)
-{
-    switch (vece) {
-    case MO_8:
-        tcg_gen_ext8u_i32(out, in);
-        tcg_gen_muli_i32(out, out, 0x01010101);
-        break;
-    case MO_16:
-        tcg_gen_deposit_i32(out, in, in, 16, 16);
-        break;
-    case MO_32:
-        tcg_gen_mov_i32(out, in);
-        break;
-    default:
-        g_assert_not_reached();
-    }
-}
-
-void tcg_gen_dup_i64(unsigned vece, TCGv_i64 out, TCGv_i64 in)
-{
-    switch (vece) {
-    case MO_8:
-        tcg_gen_ext8u_i64(out, in);
-        tcg_gen_muli_i64(out, out, 0x0101010101010101ull);
-        break;
-    case MO_16:
-        tcg_gen_ext16u_i64(out, in);
-        tcg_gen_muli_i64(out, out, 0x0001000100010001ull);
-        break;
-    case MO_32:
-        tcg_gen_deposit_i64(out, in, in, 32, 32);
-        break;
-    case MO_64:
-        tcg_gen_mov_i64(out, in);
-        break;
-    default:
-        g_assert_not_reached();
-    }
-}
-
 /* Select a supported vector type for implementing an operation on SIZE
  * bytes.  If OP is 0, assume that the real operation to be performed is
  * required by all backends.  Otherwise, make sure than OP can be performed
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 2e8087c938c..924b94414b7 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -661,6 +661,22 @@ void tcg_gen_divu(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
     }
 }
 
+void tcg_gen_dup(TCGType type, unsigned vece, TCGTemp *dst, TCGTemp *src)
+{
+    unsigned t_width = tcg_type_size(type) * 8;
+    unsigned e_width = memop_size(vece) * 8;
+
+    tcg_debug_assert(e_width <= t_width);
+    if (t_width == e_width) {
+        tcg_gen_mov(type, dst, src);
+    } else if (t_width == e_width * 2) {
+        tcg_gen_deposit(type, dst, src, src, e_width, e_width);
+    } else {
+        tcg_gen_extract(type, dst, src, 0, e_width);
+        tcg_gen_muli(type, dst, dst, ~0ull / MAKE_64BIT_MASK(0, e_width));
+    }
+}
+
 void tcg_gen_eqv(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     if (tcg_op_supported(INDEX_op_eqv, type, 0)) {
-- 
2.53.0


