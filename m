Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC5F2C88E5C
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 13:12:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6pOI-00008y-8R; Wed, 16 Sep 2026 09:09:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6pNO-0006mG-Ce
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:08:41 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6pNI-0001Rm-HN
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:08:36 -0400
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-cc147d86bebso2935635a12.0
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 06:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789564109; x=1790168909; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=mpJLFvW1CmSdR7nI8UnQp9sUj66i1dqPnjl329KIM/Q=;
 b=ZwNubSHehKhr/s2GnK689VsBuiivCp5WFeM3ez6JzMdtFIfcAgbXsj4nwaL5Kv5Ppv
 A0ZLK+6SoCDzqSRujL96VkQgWjLWWvkbIUIt14+/0goXsOe7tYAB+MmeTNNMM73knwaF
 3CY+5P70/oQ/NwoDZVqNX4XL6H3TR3JWSUrLPEVPzQraJ3WOPrTqq73swGkL+y09DNTa
 1ab/J6ujV8vqDZVcAfiZVQdZO4ipqajf3Rek6Zhqm08PUMTgRndzVs+Xv8tyiG8EWGPs
 YJ2AopTMEj7HN0Q5xcyg0GNrxDwhBWFcfvQO5rYbrzdkiOsaxp3aUM13+HEx1rHnk0pv
 lXVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789564109; x=1790168909;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=mpJLFvW1CmSdR7nI8UnQp9sUj66i1dqPnjl329KIM/Q=;
 b=E7VpcN1wYM6LYrMxQpsUli0Q5aUK2/cXtv1bRPT9AwsePoLeu2T0vGwyyjfxmKlgGi
 F9NFtwDJ6isBnwYkj0kaATI2YbaaIQ19bRs36rDud8aOTDFmgGHM7SX5TO6oquWI3L9+
 Jjr/5KsUDzOwHuiuBp60yJjaiT2QuL6ygsxDf5c+hPohibnDUBKXinA48qBAlY0lJklJ
 xF375BiDfbs6o/l+GCPY6IA/0yM4QxKz+00Jh6c1iTjeTS910Z/gNmla/KwfgJivk6qq
 2IweU5ya1BwNvVAqazpWhPRfOD7PGOwN97wZQHxFK0i6sGWn36DgTNsvc01F9u0erzf5
 tvSQ==
X-Gm-Message-State: AFuF++mVbFLK1Y6YKXwVTdt25fUNvEhuGPQvCtNW8fzNPkw56y7eBpQ3
 2pfIA+1y/DlJtWoLbgoxjm23nwPOn6vslWZuGKNImQyuPtLxaYXjfFRjfHKG/uULN9Y0y2zDaCl
 59Em9BFM=
X-Gm-Gg: AYBFou1X8pm0GmFlmvv2XSXGFt640BSTylMqMaqUgcziB4wrp+2cACIKxyNTD3v3aIY
 pBgq179kVsWcmMgnK8QLeiPu51+bM0D1+6wt7Doa4C75LmlhdIsoAx/wPdptj6OodQYU1xgkAsl
 5ew1C9jN+e6DqD7yOyYEgNi9F6mJ/SeT9DSz3B3xT3iB/kKhLCXk3gUW6YFZgxngdBzRXhZKoe+
 mHMPSTKPW9Dx/C52/5hxyJpXFTesgOzxGQaEgXIPwW3Oab7S24sB9krAufbHx2ZNLO1VKTyALvr
 wURcL/Z6G+JOpg8FoDSONc6z/EJ4ENqZDV0XV7E9PyMwUoYp/dUhGUMT/2HWNfb8pGDtA5nJBht
 8bp3NS7tr52Mj78LJHzFrPTjas0b2ytanBhgdy5uE9u6rnvrLIq9v+7X0n1P7FtPwnVeTyV2+gV
 S7NlzHAf4Z+OQgEy/+vOvnK8efp6gpdgIvqt1k+4LltKn+6XSu55xs3ny6M7/2spzrw2hecWBJb
 Un2Eg8=
X-Received: by 2002:a17:90b:4a92:b0:398:9beb:a2b9 with SMTP id
 98e67ed59e1d1-39dfe1ca2dbmr12207754a91.27.1789564107761; 
 Wed, 16 Sep 2026 06:08:27 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:845c:f507:397b:9b72])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33bf5aa1194sm9398056eec.14.2026.09.16.06.08.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 06:08:27 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 54/92] tcg: Generic expansion of tcg_gen_ctpop_*
Date: Wed, 16 Sep 2026 03:03:29 -1000
Message-ID: <20260916130409.3382710-55-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916130409.3382710-1-richard.henderson@linaro.org>
References: <20260916130409.3382710-1-richard.henderson@linaro.org>
MIME-Version: 1.0
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-op-common.h  |  2 --
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 42 ++++++++++++++++--------------------
 3 files changed, 19 insertions(+), 26 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index b477d980a3e..b3cd4bbf63b 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -132,7 +132,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 void tcg_gen_ctz_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_ctzi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_clrsb_i32(TCGv_i32 ret, TCGv_i32 arg);
-void tcg_gen_ctpop_i32(TCGv_i32 a1, TCGv_i32 a2);
 void tcg_gen_rotl_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_rotli_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_rotr_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
@@ -191,7 +190,6 @@ void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ctz_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_ctzi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_clrsb_i64(TCGv_i64 ret, TCGv_i64 arg);
-void tcg_gen_ctpop_i64(TCGv_i64 a1, TCGv_i64 a2);
 void tcg_gen_rotl_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_rotli_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_rotr_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 7d0d219918f..2de0aacd93c 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -9,6 +9,7 @@ DEF4(brcond, TCGCond, TCGV, TCGV, TCGLabelPtr)
 DEF4(brcondi, TCGCond, TCGV, TINT, TCGLabelPtr)
 DEF3(clz, TCGV, TCGV, TCGV)
 DEF3(clzi, TCGV, TCGV, TINT)
+DEF2(ctpop, TCGV, TCGV)
 DEF1(discard, TCGV)
 DEF3(div, TCGV, TCGV, TCGV)
 DEF3(divu, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index e43b3cf4f76..bcc176e3cae 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -526,6 +526,24 @@ static void gen_clzi(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
     gen_clz(type, dst, src1, tcg_constant_internal(type, src2));
 }
 
+static void gen_ctpop(TCGType type, TCGTemp *dst, TCGTemp *src)
+{
+    if (tcg_op_supported(INDEX_op_ctpop, type, 0)) {
+        gen_op_tt(INDEX_op_ctpop, type, dst, src);
+    } else if (type == TCG_TYPE_I64) {
+        gen_helper_ctpop_i64(temp_tcgv_i64(dst), temp_tcgv_i64(src));
+    } else if (tcg_op_supported(INDEX_op_ctpop, TCG_TYPE_I64, 0)) {
+        TCGTemp *tmp = tcg_temp_new_internal(TCG_TYPE_I64, TEMP_EBB);
+
+        gen_extu_i32_i64(tmp, src);
+        gen_op_tt(INDEX_op_ctpop, TCG_TYPE_I64, tmp, src);
+        gen_extrl_i64_i32(dst, tmp);
+        tcg_temp_free_internal(tmp);
+    } else {
+        gen_helper_ctpop_i32(temp_tcgv_i32(dst), temp_tcgv_i32(src));
+    }
+}
+
 static void gen_discard(TCGType type, TCGTemp *src)
 {
     tcg_gen_op1(INDEX_op_discard, type, temp_arg(src));
@@ -928,21 +946,6 @@ void tcg_gen_clrsb_i32(TCGv_i32 ret, TCGv_i32 arg)
     }
 }
 
-void tcg_gen_ctpop_i32(TCGv_i32 ret, TCGv_i32 arg1)
-{
-    if (tcg_op_supported(INDEX_op_ctpop, TCG_TYPE_I32, 0)) {
-        tcg_gen_op2_i32(INDEX_op_ctpop, ret, arg1);
-    } else if (tcg_op_supported(INDEX_op_ctpop, TCG_TYPE_I64, 0)) {
-        TCGv_i64 t = tcg_temp_ebb_new_i64();
-        tcg_gen_extu_i32_i64(t, arg1);
-        tcg_gen_ctpop_i64(t, t);
-        tcg_gen_extrl_i64_i32(ret, t);
-        tcg_temp_free_i64(t);
-    } else {
-        gen_helper_ctpop_i32(ret, arg1);
-    }
-}
-
 void tcg_gen_rotl_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
     if (tcg_op_supported(INDEX_op_rotl, TCG_TYPE_I32, 0)) {
@@ -1833,15 +1836,6 @@ void tcg_gen_clrsb_i64(TCGv_i64 ret, TCGv_i64 arg)
     }
 }
 
-void tcg_gen_ctpop_i64(TCGv_i64 ret, TCGv_i64 arg1)
-{
-    if (tcg_op_supported(INDEX_op_ctpop, TCG_TYPE_I64, 0)) {
-        tcg_gen_op2_i64(INDEX_op_ctpop, ret, arg1);
-    } else {
-        gen_helper_ctpop_i64(ret, arg1);
-    }
-}
-
 void tcg_gen_rotl_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
     if (tcg_op_supported(INDEX_op_rotl, TCG_TYPE_I64, 0)) {
-- 
2.53.0


