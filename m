Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C08B7C982C1
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 04:36:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x73nx-0003H9-RZ; Thu, 17 Sep 2026 00:33:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x73nS-0001dk-Fx
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 00:32:38 -0400
Received: from mail-pj2-x10.google.com ([2607:f8b0:4864:39::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x73nP-0007Fq-JK
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 00:32:29 -0400
Received: by mail-pj2-x10.google.com with SMTP id
 d9443c01a7336-2d747ed9866so3621745ad.2
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 21:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789619545; x=1790224345; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Vqgt5jQxfHsAz9mPEINxMsMXNnZD8enw6McDQyzh04A=;
 b=ExsfbxD7fPbIG5nU4ZUrYw3Hp6Gr+JISSnZWBSVuDaaMt+HkK+MzCXV/o34LZtKXfR
 8moovGA2XMENqI/8ufuHE3GHgpjtKlGddADdoxLaG/q3spLmivC+QCs9gKdb3BaxFA1J
 EdxRZmHNARCm+MfcwIx7sDaBFzzgCKHWP6QiP6xWw5wm0ukajpFZ8Q0rSTDIUdNNDtTp
 gWUP3x+PChsz7JX6A7O+fFBItczrKjBBl/CxohcsYazDJPlcrkri6jOXP3MMWj646bs5
 z788kigwk1A48ZZveh28USFLVYUrKheIK3Jx5fEaXfxdVXHZriSkPO2voH6Yv3KiafaQ
 lvLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789619545; x=1790224345;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Vqgt5jQxfHsAz9mPEINxMsMXNnZD8enw6McDQyzh04A=;
 b=Z14Wwgp8gBjptXjtMJsjSy9uf9R8Op18dVTLooNZmAuy6Nqq//4fwFpHOPer+DfORy
 pxSulNaFLKbHVhaFsIZqSI5j5UdpaC3p2u9Zh7DTR8e/o7V3e6Nf3ey65X1BZ6HZNfHx
 svaJ049C+w9EDdeh8buxMN1Vl/el4jSbC8IdwGvjxQp/cIMupiUfUnwiXV9nC+cWVb2W
 pAcLtDkP1EsDMshMkFJwhpcLebie4okvPWfhIrw66UA/97kR+9GOgUauYkb0RpXmgXk3
 21sATwUEcRGzgzhN/yzTh9U8UnuPC0P0fV6DaRoMtT18uqlRdWeCZGHOD5ABRtj4tBgW
 XsfA==
X-Gm-Message-State: AFuF++k2QQEwMW7KNJu2/9zHV8ha2WqDEHsehoDaHDR5UMMv77FhDrYP
 rWgQzExSi/WTIT3qF864mtLeSXCET5sdepnUlmwom+3T4RkWkbjmzTuqoAafHc97JN58HXENMxr
 dIg2RwyI=
X-Gm-Gg: AYBFou2oGbwIDZhbDDDXKz0V5mmiFV3fUZxroFkwthyKouAwoF89t0Axhf38rFwxkFA
 cEPs5SuTzuACYSqoqc7N0eM7vilq1PT67dGIO26L9AN7h493K8jtqEo902W9bVifUNxSMLfs/Ij
 jy2hXrfctTr5MpCIlGla6bGXcMo3TzaRzQ5a1EPr83H0ufErVAx3R/SGitfWxJdeSrQAsWusmmk
 Ds4mizmkvlLx8ro5zqDQx8ByaG6ip9sMP9SdmVGnxmTaQaZoXDADdhxHPi7b97tJl/DBGLW5r4Q
 WH7qDmjHJmXy29WaWfx7O1Ea8mu2/Hmj30tSdImQx2VLpF+ZPwoU1bgf6ZHQywPcMXZw5y/Q/dW
 +I17s0xrq7mXmFtQSFVO6ZGXvKZYsoOT7fnYDCMFLvNsxnSkyn6k53eJE7Vgp9Y59nsfIYJXvV9
 Q1SehxyKGyzqe14oGGKBlu7mqoYLsrhMrMSh71Y5QGxQPdm+y0JYSiUZTkAbxzZtDw+vuB6WfAP
 3qiFfY=
X-Received: by 2002:a17:90b:1d8d:b0:39b:92bb:9ef0 with SMTP id
 98e67ed59e1d1-39e1e48a200mr11307031a91.20.1789619544961; 
 Wed, 16 Sep 2026 21:32:24 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:325f:1938:d075:8c13])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14395d13cb7sm10501878c88.7.2026.09.16.21.32.24
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 21:32:24 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 056/101] tcg: Generic expansion of tcg_gen_clzi_*
Date: Wed, 16 Sep 2026 18:27:38 -1000
Message-ID: <20260917042823.542588-57-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917042823.542588-1-richard.henderson@linaro.org>
References: <20260917042823.542588-1-richard.henderson@linaro.org>
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
index 425a7e90e5d..afab6fd3c82 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -518,6 +518,11 @@ static void gen_clz(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
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
@@ -845,11 +850,6 @@ static void gen_xori(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
 
 /* 32 bit ops */
 
-void tcg_gen_clzi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
-{
-    tcg_gen_clz_i32(ret, arg1, tcg_constant_i32(arg2));
-}
-
 void tcg_gen_ctz_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
     TCGv_i32 z, t;
@@ -1766,11 +1766,6 @@ void tcg_gen_revbit64_i64(TCGv_i64 ret, TCGv_i64 arg)
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


