Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11B43C88E5C
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 13:10:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6pOJ-0000FK-JK; Wed, 16 Sep 2026 09:09:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6pNI-0006kI-PM
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:08:39 -0400
Received: from mail-pz2-x10.google.com ([2607:f8b0:4864:3b::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6pNF-0001RQ-Bm
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:08:31 -0400
Received: by mail-pz2-x10.google.com with SMTP id
 41be03b00d2f7-cc1cea4bfd1so667998a12.0
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 06:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789564107; x=1790168907; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=RNLVWHJbOHYwr6+vchucwTrRkycNA9wJPdmPF4L4TXk=;
 b=x0td+JV20nimvhbyGAYdkqliSZZyqLRlcCrK9LciSwZUSEHOezDLyDTh4O8OixuApG
 j7wDAEiF4Xe4XWfsNbgek0j1gYxGYCpHkdRQ2pk6g4iqP1G87VgGIi+uVWAqwIp1Xjn2
 aI5VPcoMmwd9fI0KQNswtWWYFZCecrHC3GIlsOWV9+YJ3OFCf/xZ0Knc4vf4zZxaUS6l
 8JkP1S/VXwmreu00YX/aej55MFocW+NmvkkC030LSffhcCX1KU1xMZmZwGkzqkspIfuB
 4UQP0eVbWRv7WR4ziXrRcA5lhTtO6pzNEtwFk5/7nDCM2Gk7NGRnMh/onu2cChCzvYC9
 JKLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789564107; x=1790168907;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=RNLVWHJbOHYwr6+vchucwTrRkycNA9wJPdmPF4L4TXk=;
 b=KvQscJlBdWOvQOFhfib29w2SM7y3T6GfEmjipW4YD3R6068EZ0ZF5neiLmLfb3+KC1
 5eydFEIcsETlS8Eh+OIWedqaskC0pXxSfADoFp+mCKXx2MUOhsIa+kUjBp8ibJ/iClA7
 9oCDcoGdtgHEbWuGabcrSKQ4y8mjzLtLVFATmiBtk6k5pKZkNkrSMw4SIOu8l7ejMTVE
 QyAKXK3jkOx02sLgSXoxaeG1fNWBnIrLMmPeoTidiHK0Liqb6bPwWPuKajHmYWdMKiiA
 qDbueS1eUX7cLYz+Dfm6AJelbQ3K6Penzu5GOvsadEMMd0kd5Eb40mgf6nEcdkv7Yz8i
 NB5w==
X-Gm-Message-State: AFuF++kzdM1bGZU7M0uQqiBT5O+ufegrIiRl4UMffkkby545imHk2Oam
 xpNndOFWdjpOKxXcb6QV1IdoQVqypopd23v2QbL1263/a7Ig3RiM5kOWqb5L586TUcAArxEoXPn
 MJdcD/cI=
X-Gm-Gg: AYBFou2sXC7nWP77lb6lpBDDAQ89Wc/oOuKD7UohH/ODWwu+u91POCJeeb75It0wiCn
 IwExELfQFVKaDWtTvox9vW+7Tj7ZFsMENQdfMA4f5pxOrH7UUiTm3eiTkXVBhsYKGRzykDVGug5
 FGFkdiY+lE5RiaUXR464Gr8cVkHV/h3k1jC9nLqjSu+KPxlZwnMGQXIi2Jz3z9dZvU7rx5X1iRE
 7uCukMnKoDRuHqL+uavXdZUNo/FSTE2hq4xHGoxghIroKOqSxyj6J377lUOuRdFWpi/cbZ6crXS
 2/nTQuDgOtG1+5IyW578zRUemYjtCux3CLWK6apQuoblPOIPIOUkKSfRgdKBQhNPSIidDiwVeEa
 YG+S0P2ycUtEPdQi0xVOIOb4GI5E+TsMYkiWn7wMiu783JSj/x67feF+KQej+xJL2WpvYi+WiL5
 59PzOeWM9hdS8Yjbfk0Ng7LhHOkoelH4W8GazwYKNaz2GQyE6/hd/SmOvepITvrr1pHK0/10QU9
 Qw949M=
X-Received: by 2002:a17:90b:4c49:b0:366:3517:1aa2 with SMTP id
 98e67ed59e1d1-39e1df6e4edmr5857843a91.0.1789564106878; 
 Wed, 16 Sep 2026 06:08:26 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:845c:f507:397b:9b72])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33bf5aa1194sm9398056eec.14.2026.09.16.06.08.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 06:08:26 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 53/92] tcg: Generic expansion of tcg_gen_clzi_*
Date: Wed, 16 Sep 2026 03:03:28 -1000
Message-ID: <20260916130409.3382710-54-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916130409.3382710-1-richard.henderson@linaro.org>
References: <20260916130409.3382710-1-richard.henderson@linaro.org>
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
index 0e8203fd836..b477d980a3e 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -130,7 +130,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 /* 32 bit ops */
 
 void tcg_gen_ctz_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
-void tcg_gen_clzi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_ctzi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_clrsb_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_ctpop_i32(TCGv_i32 a1, TCGv_i32 a2);
@@ -190,7 +189,6 @@ void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 /* 64 bit ops */
 
 void tcg_gen_ctz_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
-void tcg_gen_clzi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_ctzi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_clrsb_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_ctpop_i64(TCGv_i64 a1, TCGv_i64 a2);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 202df7a62a8..7d0d219918f 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -8,6 +8,7 @@ DEF3(andc, TCGV, TCGV, TCGV)
 DEF4(brcond, TCGCond, TCGV, TCGV, TCGLabelPtr)
 DEF4(brcondi, TCGCond, TCGV, TINT, TCGLabelPtr)
 DEF3(clz, TCGV, TCGV, TCGV)
+DEF3(clzi, TCGV, TCGV, TINT)
 DEF1(discard, TCGV)
 DEF3(div, TCGV, TCGV, TCGV)
 DEF3(divu, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 0a2e92d53d9..e43b3cf4f76 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -521,6 +521,11 @@ static void gen_clz(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
     }
 }
 
+static void gen_clzi(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
+{
+    gen_clz(type, dst, src1, tcg_constant_internal(type, src2));
+}
+
 static void gen_discard(TCGType type, TCGTemp *src)
 {
     tcg_gen_op1(INDEX_op_discard, type, temp_arg(src));
@@ -853,11 +858,6 @@ static void gen_xori(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
 
 /* 32 bit ops */
 
-void tcg_gen_clzi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
-{
-    tcg_gen_clz_i32(ret, arg1, tcg_constant_i32(arg2));
-}
-
 void tcg_gen_ctz_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
     TCGv_i32 z, t;
@@ -1774,11 +1774,6 @@ void tcg_gen_revbit64_i64(TCGv_i64 ret, TCGv_i64 arg)
     }
 }
 
-void tcg_gen_clzi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
-{
-    tcg_gen_clz_i64(ret, arg1, tcg_constant_i64(arg2));
-}
-
 void tcg_gen_ctz_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
     TCGv_i64 z, t;
-- 
2.53.0


