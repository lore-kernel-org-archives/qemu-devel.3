Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75C49C88E59
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2026 10:35:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5L4o-0007vH-Mt; Sat, 12 Sep 2026 06:35:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5L4l-0007mq-KJ
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 06:35:15 -0400
Received: from mail-pz2-x10.google.com ([2607:f8b0:4864:3b::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5L4h-00087G-Ck
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 06:35:13 -0400
Received: by mail-pz2-x10.google.com with SMTP id
 41be03b00d2f7-cc1cea4ae2cso799369a12.0
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2026 03:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789209310; x=1789814110; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=zq4EkIXFT7NjETo0Y5t2WPpBzYTIsKrkWkFQvtBy1a8=;
 b=prttyeeklV+UFHAfMaX8u8V04O6acDBYUEV+0K9JDt7y/3rylUeAU91AggHUSUy5sA
 x4zR5i/ites5oAW7RjkVlmi02EdVBr6ed7enb34yF0ybGuAsD42/lxtAc7WOwWlX5qJq
 uuFbJVWUPaMpNPCewc0SuOR7VVts/dHrwL6G0DnpeVpdiEYbznmwMC8fc6EvVrYBm0Ir
 XhCZ14c+hicn8hCfIVI9FWSpnTLi9l8asVAszjD5oha108wwtJib+/3cVrkx1RzMnxfz
 DZNfYJB9A4o5kBeiakhOPVmfDpJW6QABJfZNKsM/nAP/NejwqvyrNgYz0hX09Hy62Yy+
 1UuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789209310; x=1789814110;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=zq4EkIXFT7NjETo0Y5t2WPpBzYTIsKrkWkFQvtBy1a8=;
 b=rbZ/EwVtFdqE614zJA2RKIQtq+Qr4KEsO3PPRd1L6EKJtANAJX/38uDNZGiUsc7T7i
 +Qcc0PSpZCkryMviKZ2P0muCJL2j0bsvjlfDSshgRQ3dziFNvOU1PfJsUCzB7bfk+3L7
 tUPy7y1QC/rI9QXAmCd9vcAIdVVWNiU1XFGt7teFFXnB6uIV3iwOZ0ATxpCC55tBpmia
 i60SmC34GBdEIPdw8P5UHepy0K+oqfkz2P7MEt9wehKA3l9UAnPNnHug4lYMFvcWm7LQ
 P1NGE2uXanMggrEzFHQgvMbusqktYorCorTNk2yyhsPS/Ufu4tjxytY71ArrxP5kY7Ii
 ECkw==
X-Gm-Message-State: AFuF++lKnS/Y60RcTCOQ0TnDjBFBcqbdZOiXfNKMsSrifse1d+4PSw5J
 EC+brhXsaNNqf6J9KowSq3yX4dU3ZX80T9y2CMd/OIpPYNbttpj8FUvc+3MYiczS6XJ1yJWIvYP
 AJqTvirY=
X-Gm-Gg: AYBFou0GA4nSXezLtkWsE5/P5QSEge0SDsTx7ggsFD7UrMiMvb53nm5jVfe7XXJ/ecj
 CIIIsH1v8WnN7A41Q1H8iH3KSQq0c8a4KHMEsKMA9W/AtoCgS6fR0nCaYgId/PrrkBt4LXaLTKb
 uQLGycs3iw8ApQyukVlDBizl5LrWgVf3iTAcTRPhdC7XZl5CR6ji5nJrn9JedMR51TIJccd6PWo
 9n0nJcFiV1V9o+Cmg0vGVU5gEgUsJLK4TtjjamGJYuKjrDkPOXIY0gk0IjFv1dkUtFXtqfY1dSe
 TqTW0eABMcx7sC5u0r86AwRL+o/BA7RR8AIbnKmt7o4ln4eNYuMxmfwuSFpqDx+RWUIU/+YJ1Kj
 XtJk51dxIrQxVpPIBVjgcTCTc/aIj6QtYJ/fVE/nUQRlrPhmnlJD0POcHDhbvZIKRPIBCHS7zEl
 MO1dfJZYM0RyV/F8NXf03TiQXRAw7v9MJvdhEkBAgW16xyJGElm7qfYkrN+L/FfDMpw53iYjYj4
 5GF9OSdqBVWhf6j/n0=
X-Received: by 2002:a05:6a20:258e:b0:3cc:2552:ddd7 with SMTP id
 adf61e73a8af0-3daed0fffb2mr16685430637.5.1789209309732; 
 Sat, 12 Sep 2026 03:35:09 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:bf2d:a6f5:e308:cd27])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33ba4f55735sm13673674eec.24.2026.09.12.03.35.09
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 03:35:09 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 42/82] tcg: Generic expansion of tcg_gen_negsetcondi_*
Date: Sat, 12 Sep 2026 00:30:46 -1000
Message-ID: <20260912103126.598030-43-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260912103126.598030-1-richard.henderson@linaro.org>
References: <20260912103126.598030-1-richard.henderson@linaro.org>
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
 include/tcg/tcg-op-common.h   |  4 ----
 include/tcg/tcg-op-def2.h.inc |  1 +
 tcg/tcg-op.c                  | 18 ++++++------------
 3 files changed, 7 insertions(+), 16 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 59f0f9ee0de..4223229c78b 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -157,8 +157,6 @@ void tcg_gen_sextract_i32(TCGv_i32 ret, TCGv_i32 arg,
                           unsigned int ofs, unsigned int len);
 void tcg_gen_extract2_i32(TCGv_i32 ret, TCGv_i32 al, TCGv_i32 ah,
                           unsigned int ofs);
-void tcg_gen_negsetcondi_i32(TCGCond cond, TCGv_i32 ret,
-                             TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_movcond_i32(TCGCond cond, TCGv_i32 ret, TCGv_i32 c1,
                          TCGv_i32 c2, TCGv_i32 v1, TCGv_i32 v2);
 void tcg_gen_add2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 al,
@@ -222,8 +220,6 @@ void tcg_gen_sextract_i64(TCGv_i64 ret, TCGv_i64 arg,
                           unsigned int ofs, unsigned int len);
 void tcg_gen_extract2_i64(TCGv_i64 ret, TCGv_i64 al, TCGv_i64 ah,
                           unsigned int ofs);
-void tcg_gen_negsetcondi_i64(TCGCond cond, TCGv_i64 ret,
-                             TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_movcond_i64(TCGCond cond, TCGv_i64 ret, TCGv_i64 c1,
                          TCGv_i64 c2, TCGv_i64 v1, TCGv_i64 v2);
 void tcg_gen_add2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 al,
diff --git a/include/tcg/tcg-op-def2.h.inc b/include/tcg/tcg-op-def2.h.inc
index 5343b99f622..bc27e1b2af6 100644
--- a/include/tcg/tcg-op-def2.h.inc
+++ b/include/tcg/tcg-op-def2.h.inc
@@ -1,6 +1,7 @@
 /* SPDX-License-Identifier: MIT */
 
 DEF_CRIL(brcondi)
+DEF_CRRI(negsetcondi)
 DEF_CRRI(setcondi)
 DEF_CRRL(brcond)
 DEF_CRRR(negsetcond)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index a04a55c186a..14139fa5784 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -550,6 +550,12 @@ static void gen_negsetcond(TCGType type, TCGCond cond, TCGTemp *dst,
     }
 }
 
+static void gen_negsetcondi(TCGType type, TCGCond cond, TCGTemp *dst,
+                            TCGTemp *src1, int64_t src2)
+{
+    gen_negsetcond(type, cond, dst, src1, tcg_constant_internal(type, src2));
+}
+
 static void gen_not(TCGType type, TCGTemp *dst, TCGTemp *src)
 {
     if (tcg_op_supported(INDEX_op_not, type, 0)) {
@@ -802,12 +808,6 @@ static void gen_xori(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
 
 /* 32 bit ops */
 
-void tcg_gen_negsetcondi_i32(TCGCond cond, TCGv_i32 ret,
-                             TCGv_i32 arg1, int32_t arg2)
-{
-    tcg_gen_negsetcond_i32(cond, ret, arg1, tcg_constant_i32(arg2));
-}
-
 void tcg_gen_clz_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
     if (tcg_op_supported(INDEX_op_clz, TCG_TYPE_I32, 0)) {
@@ -1562,12 +1562,6 @@ void tcg_gen_st_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset)
     tcg_gen_ldst_op_i64(INDEX_op_st, arg1, arg2, offset);
 }
 
-void tcg_gen_negsetcondi_i64(TCGCond cond, TCGv_i64 ret,
-                             TCGv_i64 arg1, int64_t arg2)
-{
-    tcg_gen_negsetcond_i64(cond, ret, arg1, tcg_constant_i64(arg2));
-}
-
 void tcg_gen_ext8s_i64(TCGv_i64 ret, TCGv_i64 arg)
 {
     tcg_gen_sextract_i64(ret, arg, 0, 8);
-- 
2.53.0


