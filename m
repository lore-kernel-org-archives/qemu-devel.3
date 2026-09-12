Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EACFAC79FB6
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2026 10:36:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5L5G-0001ku-8l; Sat, 12 Sep 2026 06:35:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5L55-0000cl-Az
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 06:35:35 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5L52-0008QZ-N0
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 06:35:35 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-8520161fdb9so2010915b3a.3
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2026 03:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789209331; x=1789814131; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=FMezBfWh0T1f9Xgh+I0DAAlpbdPSUWlPZxpdljX35x4=;
 b=GPOuujD2Jlro0Rb7OArZzpKZOQcJyVcvCOAH4eek7cPUPkUMf+UK1rTDuVYtOmaFA+
 xV5Uj0tuVz0gYTwL054/ypWbe/gipHHRPpGBC2hZFTnb7pElWMFe4JKAyQEdWF62QXOe
 ZikbbbYx9cDlFXrJjzXxLh+PTnOY/wvD+OmbligryNEjvni2p4mIUCYbMQnbKmBmvWIv
 qvlSzlTHJDGwoB6qnAzwdrdu+/rOUmsltKtm0b6/Wjy9VuW0zwhUfZTIpV/d3czzHPaU
 /1r3EGomFZDj3CtUBEufVyBcTGKQVP2gKjr1omMS2nIBRGOXV5tybXXgX6YoyA3mxwQi
 CSjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789209331; x=1789814131;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=FMezBfWh0T1f9Xgh+I0DAAlpbdPSUWlPZxpdljX35x4=;
 b=aZM4juzxp6KpivQgpmbuJuB9OpLgsHEBMkmw+ksVtS80tX5GKcgLgn03env6X90QdX
 WNDZWrCLmmh/LFQVYlTmhep3oMYEP2UWE7u9zxGHRJNM+HoudSdXxaEPQFLL/PZh6sMx
 aJ9qyRuEyZvTiqZ8D3ywrW35isM7d+ARu4hy7MOM2zwfNfuoEJv/tNYyrwD9j7dkqbtb
 5M2BoZFlRIhZG90n0ZlJGgHdW0Bi1FtbuUe1mChRZYg31HajJulkkY+T6CEMIsR/Ut/c
 DvatI/q32aDk5Jm9wpK4evXmVWLnwwwms5Er5pMus7JB2XYGZ7f1bej8FeSSYGpS5F3L
 fbMQ==
X-Gm-Message-State: AFuF++nt1vokBEJ2V0XSbg8Cx35mtLjGZCKqUPDOIwRo0BTO/Tu6cfQo
 +IyKVD5NriRzlUNACqgEbtnKbUwuRe+aAZlgAQAi3hEZb81QTf20b5sXxOGMhLRh/97npA8ZWOf
 0zU8WAvw=
X-Gm-Gg: AYBFou1CmqFMs5Go8i6ek63pEDrd5yoCMMNgweVMJoaHccGRPstCxLRo+/e3DPV0D4M
 WEtJTACkNI0LsNqGYeTQMzlcIDtj2BPH9P3CnnFgxawjUp3jYlWrfcs1n0on6UjWLESvCjcq0fm
 O+O3XoG2FyZHmfM8EXbe+bTGcH0VLocVRrE1S0NmVkQCffPnngmIY3eTEYAmi0HMTUK7hm11sjL
 xbMZ40dgCZ+Pe7IGBOUnVB++38FUVyNeyzOlW9a4RTVzFgLxA3SqywbLhR80wZW3OomkzCvk3hT
 nMdIDxmMvNXqkZB2d3HEDZ7B+EcTXko9JIDTOuOMvmplmpRZiZz/lzX9zY3EyGKPLRm46Q76rhY
 j0Hu66gk6t7T1slCGKC+kstq20Lm+456t0WyhkKXjZrOM1UJxSB8Wq9LO6lG/EelLpikpLTLlCx
 JtHmTBM3hofVx3SZa+ASso9PAxA6q/AKuu3e+CADmMP7boHUCtnZBePUUosHmlQFcj7pU6yt3UT
 OKd/e85ewcx3X6M9w==
X-Received: by 2002:a05:6a20:9147:b0:3d3:ae50:97cd with SMTP id
 adf61e73a8af0-3daed880077mr13793994637.26.1789209330887; 
 Sat, 12 Sep 2026 03:35:30 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:bf2d:a6f5:e308:cd27])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33ba4f55735sm13673674eec.24.2026.09.12.03.35.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 03:35:30 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 64/82] tcg: Generic expansion of tcg_gen_ext8u_*
Date: Sat, 12 Sep 2026 00:31:08 -1000
Message-ID: <20260912103126.598030-65-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260912103126.598030-1-richard.henderson@linaro.org>
References: <20260912103126.598030-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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
 include/tcg/tcg-op-common.h   |  2 --
 include/tcg/tcg-op-def2.h.inc |  1 +
 tcg/tcg-op.c                  | 15 +++++----------
 3 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 1851577860e..25464d67306 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -163,7 +163,6 @@ void tcg_gen_mulu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_muls2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_mulsu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_ext16s_i32(TCGv_i32 ret, TCGv_i32 arg);
-void tcg_gen_ext8u_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_ext16u_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_ext_i32(TCGv_i32 ret, TCGv_i32 val, MemOp opc);
 void tcg_gen_bswap16_i32(TCGv_i32 ret, TCGv_i32 arg, int flags);
@@ -207,7 +206,6 @@ void tcg_gen_muls2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_mulsu2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_ext16s_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_ext32s_i64(TCGv_i64 ret, TCGv_i64 arg);
-void tcg_gen_ext8u_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_ext16u_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_ext32u_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_ext_i64(TCGv_i64 ret, TCGv_i64 val, MemOp opc);
diff --git a/include/tcg/tcg-op-def2.h.inc b/include/tcg/tcg-op-def2.h.inc
index 9174fd3db63..05162cdaa87 100644
--- a/include/tcg/tcg-op-def2.h.inc
+++ b/include/tcg/tcg-op-def2.h.inc
@@ -13,6 +13,7 @@ DEF_RIR(subfi)
 DEF_RR(clrsb)
 DEF_RR(ctpop)
 DEF_RR(ext8s)
+DEF_RR(ext8u)
 DEF_RR(mov)
 DEF_RR(neg)
 DEF_RR(not)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 756492548df..7a617d2093a 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -653,6 +653,11 @@ static void gen_ext8s(TCGType type, TCGTemp *dst, TCGTemp *src)
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
@@ -1324,11 +1329,6 @@ void tcg_gen_ext16s_i32(TCGv_i32 ret, TCGv_i32 arg)
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
@@ -1630,11 +1630,6 @@ void tcg_gen_ext32s_i64(TCGv_i64 ret, TCGv_i64 arg)
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


