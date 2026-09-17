Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E84B3C982D1
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 04:34:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x73p8-0005Yn-4R; Thu, 17 Sep 2026 00:34:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x73nf-0001jA-4w
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 00:32:44 -0400
Received: from mail-oo2-x0d.google.com ([2607:f8b0:4864:31::d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x73nd-0007JF-5n
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 00:32:42 -0400
Received: by mail-oo2-x0d.google.com with SMTP id
 006d021491bc7-6b4bff33ceaso202022eaf.0
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 21:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789619560; x=1790224360; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=bSuOS95+7HSBwL1ZUhYKJeVJRpZFaCsLp6ZUzmv6zxs=;
 b=B6sCxOVkBgoyl5WPdQUiPA2hKmTEgeCnVtyYqBj1Aj2a6b1+ACOS4XLFstpg/L3FQl
 hFtONtK9sr3yGYpJLKxdul3FzLLrqBXkGIsD+ztchWSzZ0+w/fjLswmXKHuSRV7N2SSS
 Pco2uLlUkm6M2gLEyBwevju051PzFMoNzeZZZ/TkLForEE3Jqnc2w7pOXXbQa74B2Sc3
 CHGlIkqh9E2XLdk2W/5MZX4nb0yuSc/sM+j+h4Mmk5yx4NycL/lQW9zOIScBBdjm2KQH
 pDcXxpGpuIcs36VKn6ui6eXADr7aNw1kUDgkuJxcNzhN04Q5kjpR0NPPdizDO8eCwS7r
 1KdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789619560; x=1790224360;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=bSuOS95+7HSBwL1ZUhYKJeVJRpZFaCsLp6ZUzmv6zxs=;
 b=CB8MbpwPgmIl/qTq5P1Q2d2AeNeKbkStXBuo+IFXZG1lIdLaXZiLeI9/JwtHeS0YVe
 /yiyYWkGjQ5wc1Zvnn3qC83+3/bldRoIpB+CRX7fkKEY4W9JNnEdujkgbUoTOn7WKEtp
 bw6F3ew9Ato1XdsTM7ZiHy1+3u/11yGlTSFO0xTBLW3Q/blk5uX6474Q3zUgktpinjaU
 r0n1uTEq0nNdgQFASk2kJyuVjzvtht0vHkZBozYCD1XB1EHSvUoYi90BMAT8oJ1lyub8
 gCi8Mhb4YhU01KZHzwbw4OIFWSuVRYb4dvL2JaWf2p0tomw05C9rhRaGiftmkOHQC1yR
 X3XA==
X-Gm-Message-State: AFuF++mH3+T2wQZG4uKcHb0IyUsyQ9O/+3Zd+iEgqUC91Azn5V+2SK9Q
 CJ2K94I62EuHjnFi4ZVV6BHAn1PolLCp6s2g6NohmpJwKWnK0gBgWFf0FsVmo3umns68E/+Ix+k
 eTP19Bdk=
X-Gm-Gg: AYBFou1B/OpBBfSgsz+Dx4lgPUTCMWNObwLdGlhOVeX/yIZ5OzfNtO1JYmqN77crvkm
 5jwBc5JugXHL518tU9ruE3vnOtnZDd+voXHJziumrFC1nX6ko7pfRTVnpCk7wH1C6qcYaF6BaTh
 mjYGdF/sUcyZSyuuOMgaB2gwEmfw+Wgq2PLHC4iTfUDGW9GjjsSnGxoJSkFrBPoYCYtQOt9CKE2
 a7Z8dqDCTrQr0+u3IHG+wUW47br3G9wJj9HuwMeepVYlwz+79JdHTHm4iGQgOUmbCCqix6JLImh
 q5O6vBlpAzwu7dzJk7mHjzcutpbKY6DXmlh9iRCT07xmOHJsYGP8o63vlx9nnwTI5dZI2b8tRLJ
 l3/U/HyDr2y7y3CbrA1TT/OMb8kqltQGLbeKrveWtP9Wi5aUgQU3ioNIbC4+zCWalZ5EuSl+hvd
 KVreIlb5FgyUiy9iuit+yk1C2As6VQ1clp7RTFSadyS7nRuLPEtacM1NlYMjg7YGJ/KnjUQXlS5
 jEJk5c=
X-Received: by 2002:a05:6820:f09:b0:6b7:46fc:1cd with SMTP id
 006d021491bc7-6c7d36fb925mr4600531eaf.44.1789619559959; 
 Wed, 16 Sep 2026 21:32:39 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:325f:1938:d075:8c13])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14395d13cb7sm10501878c88.7.2026.09.16.21.32.39
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 21:32:39 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 070/101] tcg: Generic expansion of tcg_gen_ext8u_*
Date: Wed, 16 Sep 2026 18:27:52 -1000
Message-ID: <20260917042823.542588-71-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917042823.542588-1-richard.henderson@linaro.org>
References: <20260917042823.542588-1-richard.henderson@linaro.org>
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
index ead551edf42..c7fbe825ba3 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -689,6 +689,11 @@ static void gen_ext8s(TCGType type, TCGTemp *dst, TCGTemp *src)
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
@@ -1279,11 +1284,6 @@ void tcg_gen_ext16s_i32(TCGv_i32 ret, TCGv_i32 arg)
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
@@ -1585,11 +1585,6 @@ void tcg_gen_ext32s_i64(TCGv_i64 ret, TCGv_i64 arg)
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


