Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94535C88E77
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 13:13:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6pOM-0000Qo-8f; Wed, 16 Sep 2026 09:09:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6pNV-0006sW-KV
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:08:45 -0400
Received: from mail-oo2-x0d.google.com ([2607:f8b0:4864:31::d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6pNS-0001UN-2V
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:08:45 -0400
Received: by mail-oo2-x0d.google.com with SMTP id
 006d021491bc7-6b1ae736c64so723570eaf.2
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 06:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789564120; x=1790168920; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=JY69n4RidASFaEMke1aPjNGTxsA8yN/rDVnP23X9eLY=;
 b=DyS1gPwSIItIGhPmmvK8QG03k/yGVEv2o6EgxuurCBG3+BCPRy9a423Gbvtf7wB6NG
 HnXT5Sb3fiI06nCgZPgWfhUl9fLbXq6XaRQBy+saj/1FRzjuWJNwzppTkw0cvo1gGpVK
 k/EXvEkQHXEGxcZ8OyY35fkhC6enZ28IW/HL7vLFXFiN3RttIboD0evLUyZTgUhEzgXk
 P+t/yUI4XxrNFIqOJNlM+j3V3yvdv27dIZ829FB0cP9NyG1eMlPXkD8BR5nxJX+ippjL
 kw2DAn0NO7SY1GKCpxNK+yLzDvZXX2CPOzvstf2iYZW8xiY4NANumG9Q8VU56GgeUiqk
 wWEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789564120; x=1790168920;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=JY69n4RidASFaEMke1aPjNGTxsA8yN/rDVnP23X9eLY=;
 b=ewUfw+vE3If3ZXtfyzzgxwXhl1JVk9pmdAiZOShmBS660WoCI6tYZ9SfEYnODqHFCC
 HG6+SGc4GlvN7F6Y+qcmqmo84qoM3thAcpfX59orzId3e0qlIHUfLLplgrHDKhRPu0DL
 c6Yp5X2cflvUnqryvYLXR9GGo6YPPHND4EI4xiLCW6tQMoYJuWa6VVdvi310wCdq1y0M
 FKytuh+ayExm6jYYFeVg8IrOFZe6JAjAk0iJUEUNb8eXeyZyOdypSXaEWIy0huESJgmd
 5bdL+Ks9KH/OFwNFwbalKujpi1IvYF+nSlMEhBoaA3d116UEbw1+VRm9+bG6keur4IxJ
 GK9Q==
X-Gm-Message-State: AFuF++n2Pfb4ZEWMfGD/HHOp+10Ehmu4cKPRrohDWc8qj/sCidnF1/9W
 Cr7KRR/gHVpHtxJDXnisoGaigvljXrAgJspc/xj57O2ISVeB0CHDE6HH4yTKqdnDG/bNPe2CeHL
 IgI2C+0o=
X-Gm-Gg: AYBFou2qgOUzPsKiRHQyN95pTVcN6GH9vJR1wwmBDdRVtdQR4wwIQxYNEAF+4jdfi14
 TQp7TZNCJD5GOG1bDrR5Lp7Wp2WXsZJLRb/rmSLLbcTKaatWTm8UC8lPUewmPaUIbVmVgLN/A50
 y1akDrQ3XBEIBocsqbBpCPX+xWaIJ9U4TgMRQeFgEvohxKfcVBXReu0yGUeiBTSomHXEKOJNn2m
 cH3ieRU2jAcUo2SQ6IKHzUxTEBMGy4WOtaNPiQVOgsFZV0aiAvo4NmZ7s9oX7AlJyHwoasiNTiU
 DL6IDzDDVlfBz6QPuK2CfMUg0lL/6SaPNenn6CeRCr/PQs/GiIxoHZBW60NpdjdFphX0gYTyqoO
 fEJO/I8cmeEvIaveR9LT7JsD/o+Ubev52yA3lfG9t2vzLzRl33WrGhshj1NaleldLahyUwbxAeB
 yxfXIjie6EBxH3F8zD63Lg2ShfYWitw/K2cpRu6TjUpOCIcIx1OgdaPlrXN9eAPgAHHONqPPaU/
 LXR0qw=
X-Received: by 2002:a4a:e913:0:b0:6be:139:c031 with SMTP id
 006d021491bc7-6c7d27e0c77mr2352328eaf.39.1789564120260; 
 Wed, 16 Sep 2026 06:08:40 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:845c:f507:397b:9b72])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33bf5aa1194sm9398056eec.14.2026.09.16.06.08.39
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 06:08:39 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 67/92] tcg: Generic expansion of tcg_gen_ext8u_*
Date: Wed, 16 Sep 2026 03:03:42 -1000
Message-ID: <20260916130409.3382710-68-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916130409.3382710-1-richard.henderson@linaro.org>
References: <20260916130409.3382710-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:31::d;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo2-x0d.google.com
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
 include/tcg/tcg-op-common.h  |  2 --
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 15 +++++----------
 3 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index cae95b3d42a..cabcd394ab5 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -144,7 +144,6 @@ void tcg_gen_mulu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_muls2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_mulsu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_ext16s_i32(TCGv_i32 ret, TCGv_i32 arg);
-void tcg_gen_ext8u_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_ext16u_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_ext_i32(TCGv_i32 ret, TCGv_i32 val, MemOp opc);
 void tcg_gen_bswap16_i32(TCGv_i32 ret, TCGv_i32 arg, int flags);
@@ -188,7 +187,6 @@ void tcg_gen_muls2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_mulsu2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_ext16s_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_ext32s_i64(TCGv_i64 ret, TCGv_i64 arg);
-void tcg_gen_ext8u_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_ext16u_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_ext32u_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_ext_i64(TCGv_i64 ret, TCGv_i64 val, MemOp opc);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index afb8bac515b..80807eac2b4 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -19,6 +19,7 @@ DEF1(discard, TCGV)
 DEF3(div, TCGV, TCGV, TCGV)
 DEF3(divu, TCGV, TCGV, TCGV)
 DEF2(ext8s, TCGV, TCGV)
+DEF2(ext8u, TCGV, TCGV)
 DEF4(extract, TCGV, TCGV, unsigned, unsigned)
 DEF3(eqv, TCGV, TCGV, TCGV)
 DEF2(mov, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 32c65e38d17..b666073df34 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -699,6 +699,11 @@ static void gen_ext8s(TCGType type, TCGTemp *dst, TCGTemp *src)
     gen_sextract(type, dst, src, 0, 8);
 }
 
+static void gen_ext8u(TCGType type, TCGTemp *dst, TCGTemp *src)
+{
+    gen_extract(type, dst, src, 0, 8);
+}
+
 static void gen_extract(TCGType type, TCGTemp *dst, TCGTemp *src,
                         unsigned int ofs, unsigned int len)
 {
@@ -1294,11 +1299,6 @@ void tcg_gen_ext16s_i32(TCGv_i32 ret, TCGv_i32 arg)
     tcg_gen_sextract_i32(ret, arg, 0, 16);
 }
 
-void tcg_gen_ext8u_i32(TCGv_i32 ret, TCGv_i32 arg)
-{
-    tcg_gen_extract_i32(ret, arg, 0, 8);
-}
-
 void tcg_gen_ext16u_i32(TCGv_i32 ret, TCGv_i32 arg)
 {
     tcg_gen_extract_i32(ret, arg, 0, 16);
@@ -1600,11 +1600,6 @@ void tcg_gen_ext32s_i64(TCGv_i64 ret, TCGv_i64 arg)
     tcg_gen_sextract_i64(ret, arg, 0, 32);
 }
 
-void tcg_gen_ext8u_i64(TCGv_i64 ret, TCGv_i64 arg)
-{
-    tcg_gen_extract_i64(ret, arg, 0, 8);
-}
-
 void tcg_gen_ext16u_i64(TCGv_i64 ret, TCGv_i64 arg)
 {
     tcg_gen_extract_i64(ret, arg, 0, 16);
-- 
2.53.0


