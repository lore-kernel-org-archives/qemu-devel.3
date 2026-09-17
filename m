Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14FA8C88E72
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 04:38:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x73pI-00060s-K4; Thu, 17 Sep 2026 00:34:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x73ne-0001hi-1k
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 00:32:44 -0400
Received: from mail-pz2-x0e.google.com ([2607:f8b0:4864:3b::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x73nc-0007J0-E0
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 00:32:41 -0400
Received: by mail-pz2-x0e.google.com with SMTP id
 d2e1a72fcca58-85469b35601so248990b3a.3
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 21:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789619559; x=1790224359; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=XztffOjXf9LxP/DcqZAETnR5D5sXnPM5bhymA4lx6uk=;
 b=gphYL4qw8gaip70nt6PJy7JrU30MQQmlHxM6I/7bjOjYagd9Ey6AWZfsOv/9jpf1Si
 Q0D8AqsStndS6RjStt3OJeDt+VYVqWqWFsxCsbrR/b/NyKwDcxnqmR5RXqtFhSb3/cUe
 q969svo2gnh8gltGZF1Jf6Aoc5QNgcRoBhXiTsTnsdlHJ6wP3oo+kyBTSK4yC+08Q+57
 NPTBM3tIW8LbG4XN13F7Oiasx0NBuJwyIemY7ElvI/eo6G31zlwp4L/k0Bp6m2MyklOS
 /QqkSv4YTA8FP/BSOrblUuIAC91x+FE54X8rA++q000NBit37sSPtA1ZqhggGi+4XhJa
 oilg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789619559; x=1790224359;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=XztffOjXf9LxP/DcqZAETnR5D5sXnPM5bhymA4lx6uk=;
 b=JxmS/BIKWWA8PoFrHy4GrAgrQ0pU/gll4zkfeQytnNvoQMBXVEZyO99EAh3GOSs/Ks
 kpSkDvnSpTUw34C7jB1ybsV5VK06IONdgYbFe9OAw/hWnfoNdEehq7tWchABu9bACvwF
 wdtiiriagNG1HN4AtHXHeAYxBUq138w9WH1zf8KIRZOFNskXiDdKNem3WSzCCBtc/3E1
 S6vo70OrHi66UCzsVjN3m/7jo8+p4Y4kyOFLXqhMqMt3kZbqFF9oT+g05PyTSzpXGONz
 k0fdN3P7LiEfFWDZhr/IA/+3mnmyPPRuFIbpc9/bH2i2/BmCTpwq7ZLSN96FVREeXg9m
 AxhQ==
X-Gm-Message-State: AFuF++mfH5xoZLaBfsGSHANG/1lRNehodZL0ZylARFIuAiMQDHtLyZHY
 iU6FMYW9Zhj7W22lBrAnsEpqSnxnZ58g7pDf6BLe9v3fskNmSAUjs3e4Kex2yM1E1wbvnUtRcGl
 pZnbTsGs=
X-Gm-Gg: AYBFou2TQUVL0y4LAco9AuhUodhLxvC81TIiv6qml3SS2hwTPW7DCbpMt4bg7M8vVao
 gsi60ZeejQGdC6ux0YWrwL/Xm96KlWp/06EqknPHwppOvH1zfNvRk7U7PDNiL5mU3UPeJLVI72Z
 9KxOQ0aRdTWJYAN3DcCDwLYc+mob2zBpAsWYWtn3vBNjtxxYgKVsdbKXO+c6vde+ROMmIFXBZfc
 2hB3vSa90YDcIHk+Bn2bX5d82XwbHhd2IOwqvO5PneaGcd7DR9vQErunGLoareA4cCz9SWXSnnp
 aopcWYfQInpsAbIE3z+3RPvx2uh22dF4a7h5OhpfWkwcz+mbsOVGDOS7+7MM2xQ8/e8AhmySRwt
 KX/qUFw5fZA0uL4Qm3EO9IcFnTWOOWZXsfKvOgu2mf9Hg+Ncf5dXgSw/w3N8Isk3cUGngNs43oQ
 5O+AvWoxGN6WypEOqKLOWYbXPrxlp7LxkbfGo9xfCGLL8NoH8kKfnLJPrUVcrtuAHItBF8s57yG
 RymsPA=
X-Received: by 2002:a05:6a20:2586:b0:3d3:ad3c:49a6 with SMTP id
 adf61e73a8af0-3dd5f73ef7bmr13043919637.20.1789619558935; 
 Wed, 16 Sep 2026 21:32:38 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:325f:1938:d075:8c13])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14395d13cb7sm10501878c88.7.2026.09.16.21.32.38
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 21:32:38 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 069/101] tcg: Generic expansion of tcg_gen_ext8s_*
Date: Wed, 16 Sep 2026 18:27:51 -1000
Message-ID: <20260917042823.542588-70-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917042823.542588-1-richard.henderson@linaro.org>
References: <20260917042823.542588-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pz2-x0e.google.com
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
index 4838e06f1d4..cae95b3d42a 100644
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
index fdcff596a03..ead551edf42 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -684,6 +684,11 @@ static void gen_eqv(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
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
@@ -1269,11 +1274,6 @@ void tcg_gen_mulsu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2)
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
@@ -1575,11 +1575,6 @@ void tcg_gen_st_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset)
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


