Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65519C88E56
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2026 02:45:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5aBE-0003W5-P7; Sat, 12 Sep 2026 22:42:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5aBA-0003Hz-Qe
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 22:42:52 -0400
Received: from mail-pz2-x10.google.com ([2607:f8b0:4864:3b::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5aB8-0001xC-SS
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 22:42:52 -0400
Received: by mail-pz2-x10.google.com with SMTP id
 41be03b00d2f7-cc1cea4ae2cso1154237a12.0
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2026 19:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789267369; x=1789872169; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=5jXUshvCPeZYiDXc7WZ4y2W0CT0yd+LK0xnp4MmBzeI=;
 b=c2wZMj3bBz/9k0WiJLQXDSdOGpXAbbK8+Yn/N26hjhWDHUvkt0wraJ8W/veBN2g8mm
 7cB1NuuTc23JvW81IYZWynYHRbFGng2WLSN1x02/OK4XNLMObVCP5zGgS5trYv4RuKyu
 usZQFIV7dsvNMypponC3UYphVjAdc5aDy8GXbNgeqM6b5tQhceb1Kx2eK2SYCCULoZ5D
 N2WsXxGzDZ1gEpluJO68NrLF8q0VyGZa3V2giSuYEuS7FJCZmoZPFymiYkdfvseDOFJe
 UIBErGAMUbflYkT9byGbeZao1ruupgSCh3zPAfwTGSsG4QPLHQNzSqQSXt+IPgqW9zL0
 qrkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789267369; x=1789872169;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=5jXUshvCPeZYiDXc7WZ4y2W0CT0yd+LK0xnp4MmBzeI=;
 b=U7UU4maz6e+k3yPS8w0NgygDjWPP0lmhuhwTHUhJ4r2yL//2BHRgi8Le7joO3KMEzr
 6A4E1UUi4GBkvjJxuXumREfqh8q87GywYIsS6V1m/gKXlqi5NNJqdD1cSsdt3oEyDaDF
 u0WLJFsYPXD8Lu4+p1Gzvv2xUer3Q+rwXIfXtbITYENPpYLgOQN/KxZNxkNJJ8J+6F95
 Mg7Nk6zSiY0Uns0F4McdUrK4oQr+1VKWEjOlxGiP6oGYPA9+4pakylN+spFON0r8p2Qm
 e6o3eo/lTbdv3NRUjPhhrPi+K40VaPEjIRKgQStWNswBH5B7XMZB/NG/YDqa6X4Q51ix
 0l3w==
X-Gm-Message-State: AFuF++nS028c3CZHdR7svf33xlCx8JnYaJ6Fd2AylzS/6ZsKt84Q63WE
 fD/P6NGXsYEOj4Nu9z4RpGEXRL8XOlggccn7HK+w+7RcKHN5iCAm419oPftxvwVI8xTToxwcu7l
 t30tK8Mw=
X-Gm-Gg: AYBFou3OjAP+6yuPBGIlogU6nzeYQg01TIJEzs5SmbXIp2jV9wQvRhu1gXX0VJvzHxO
 GkfC8MLkpElpoE0D8Q+Xe9J7OG+bBdJV+aAFGnpa6VjrcX6eB0d0gIYHwo4rAqIKr70j5aoD+7l
 3aGvRuqqbkyMFj5Bngcdj24jUPcEeiTr2pVFlm7DTWEy98JKEWjb+nV+tdK9bpO+dyykiEqtZh4
 KJ5yiPM5ieUXMIO8ju1Yr+oFl1RUBM19/u2OaaEK5GNljI6wc0NLE5nhSCKjMKzxs6VykYzEzH/
 hUWA0Q6JERe0hYjnc9EUC8H7oIyMbuHdXUYF6CQWn9n5C1mQEgJp85k5dv73v2OV8/tMn3AQaGp
 9sRMYJxgDlgReTG9CAT0hXUUUROQFteQye8jIbs/oCe/MHRNWesvwkkNhIl24H2D6lcSJoUYzv9
 sn+A4cKIpe1U2dpOjYxfIsX/khLIavMkZVeEsb/bkcLbStZIyzisYmm1yPDAQcLlEOFOjHjsz3w
 gYkq/A=
X-Received: by 2002:a05:6a21:699:b0:3c3:7179:a640 with SMTP id
 adf61e73a8af0-3daed0ff231mr19974568637.3.1789267369416; 
 Sat, 12 Sep 2026 19:42:49 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:bf2d:a6f5:e308:cd27])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33ba4fb3ddasm14946556eec.30.2026.09.12.19.42.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 19:42:48 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 63/86] tcg: Generic expansion of tcg_gen_ext8s_*
Date: Sat, 12 Sep 2026 16:38:14 -1000
Message-ID: <20260913023837.741866-64-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260913023837.741866-1-richard.henderson@linaro.org>
References: <20260913023837.741866-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::10;
 envelope-from=richard.henderson@linaro.org; helo=mail-pz2-x10.google.com
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
 include/tcg/tcg-op-common.h  |  2 --
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 15 +++++----------
 3 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 572cb53bf67..94eb510a1a9 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -143,7 +143,6 @@ void tcg_gen_addcio_i32(TCGv_i32 r, TCGv_i32 co,
 void tcg_gen_mulu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_muls2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_mulsu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2);
-void tcg_gen_ext8s_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_ext16s_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_ext8u_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_ext16u_i32(TCGv_i32 ret, TCGv_i32 arg);
@@ -187,7 +186,6 @@ void tcg_gen_addN_i64(int n, TCGv_i64 *r, TCGv_i64 *a, TCGv_i64 *b);
 void tcg_gen_mulu2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_muls2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_mulsu2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2);
-void tcg_gen_ext8s_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_ext16s_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_ext32s_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_ext8u_i64(TCGv_i64 ret, TCGv_i64 arg);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 3b44db51f55..afb8bac515b 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -18,6 +18,7 @@ DEF4(deposit_z, TCGV, TCGV, unsigned, unsigned)
 DEF1(discard, TCGV)
 DEF3(div, TCGV, TCGV, TCGV)
 DEF3(divu, TCGV, TCGV, TCGV)
+DEF2(ext8s, TCGV, TCGV)
 DEF4(extract, TCGV, TCGV, unsigned, unsigned)
 DEF3(eqv, TCGV, TCGV, TCGV)
 DEF2(mov, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 49870f6df73..b7a8cf108b8 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -694,6 +694,11 @@ static void gen_eqv(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
     }
 }
 
+static void gen_ext8s(TCGType type, TCGTemp *dst, TCGTemp *src)
+{
+    gen_sextract(type, dst, src, 0, 8);
+}
+
 static void gen_extract(TCGType type, TCGTemp *dst, TCGTemp *src,
                         unsigned int ofs, unsigned int len)
 {
@@ -1284,11 +1289,6 @@ void tcg_gen_mulsu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2)
     tcg_temp_free_i64(t1);
 }
 
-void tcg_gen_ext8s_i32(TCGv_i32 ret, TCGv_i32 arg)
-{
-    tcg_gen_sextract_i32(ret, arg, 0, 8);
-}
-
 void tcg_gen_ext16s_i32(TCGv_i32 ret, TCGv_i32 arg)
 {
     tcg_gen_sextract_i32(ret, arg, 0, 16);
@@ -1590,11 +1590,6 @@ void tcg_gen_st_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset)
     tcg_gen_ldst_op_i64(INDEX_op_st, arg1, arg2, offset);
 }
 
-void tcg_gen_ext8s_i64(TCGv_i64 ret, TCGv_i64 arg)
-{
-    tcg_gen_sextract_i64(ret, arg, 0, 8);
-}
-
 void tcg_gen_ext16s_i64(TCGv_i64 ret, TCGv_i64 arg)
 {
     tcg_gen_sextract_i64(ret, arg, 0, 16);
-- 
2.53.0


