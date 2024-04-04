Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88055CD1292
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Apr 2024 23:09:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsWAV-00028E-Fk; Thu, 04 Apr 2024 19:06:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rsWAG-00023i-OH
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 19:06:38 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rsWAE-0007nB-6O
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 19:06:36 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-5bdbe2de25fso1232192a12.3
 for <qemu-devel@nongnu.org>; Thu, 04 Apr 2024 16:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712271993; x=1712876793; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QUzW5EpE6psTv3wNqcRJ2QohJfV0nsRef4r1zjcLMwE=;
 b=e8B9cHem6j0ZzFeE78hJvb147gfpw9lisYxfUmI/HS9IrbNqi0juzFHBaXRos7/Wr9
 0yGYYTGgnW8jS/rQvyFcjjJ4sFhRsSZkM3UgEJQlIqg8m3OprLFoT9qIRhnh6jRf949S
 BtkOfEFTv/6CMmDvwyJdn9QKlWT+cCL6WVajnFArsay+RQaCdGpURSDUN8baus0Y4/oJ
 GU92plT8w3fqG+kM+iNcqAVLu4csybAJUyMCnvlZbkbrvBVr0FngPS4fcrkYWjk0WASw
 nDqZH7ULoM1JUNMM2hJCdxG1CGiJVRETtMSUjJfVLJohOyXf68W/fgFPfpVFzZFBLdmt
 LXIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712271993; x=1712876793;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QUzW5EpE6psTv3wNqcRJ2QohJfV0nsRef4r1zjcLMwE=;
 b=T44Xi2GHSuAfcDRG87+V8t5RCZtE7fWDmiLpMSAUcJY+TIH+DWGCtXyXRzFSzIQY8d
 +/7EQFd+yO58xvyOBD22HZP1absIb1vpDN7bJWmggkG02CATeNTb2HGcN2yt3+TyxV3a
 j0e7oh2as24PWZVFyWQDhJovmHDXKJGP7nTZ7ED0lCH3gypZq84bR4r9OK2b2pSHUkum
 y7oBH47aP4/Y7ed6agWOMlt1le5u4/1ixRKRm4wWYPCOkHHmIvznDABHuMOy55Txp0EU
 ovKdqPk/fBWJBASPe7GPS7aRXm3tcfsA14d8YrDk768x0ElNk9RW8Oo2YglgRDKIPaMk
 ah+Q==
X-Gm-Message-State: AOJu0YyR4fYl3OoiXxe61LfD3/YbLEwgX747HDwXWISWDqgZgQl2/8Pz
 ZgN7iFVhDcIcP8bDv5oGVO4igSWOoYvMz/FCDWrzSYa1O4R6Dyvd1OicCaBusuEiG1CU2iMK+FY
 4
X-Google-Smtp-Source: AGHT+IFwG0REnhUJ3sfYSyMlKB3tQf+lk78F56zM2n60gxmSEweVTSNj5y3OOnlxy8kkh/3/k6GODQ==
X-Received: by 2002:a17:90b:78b:b0:2a2:8a0e:1b81 with SMTP id
 l11-20020a17090b078b00b002a28a0e1b81mr3803893pjz.30.1712271992859; 
 Thu, 04 Apr 2024 16:06:32 -0700 (PDT)
Received: from stoup.. (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 q36-20020a17090a17a700b002a2f3cfc92asm1052592pja.16.2024.04.04.16.06.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Apr 2024 16:06:32 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 14/21] tcg: Remove INDEX_op_plugin_cb_{start,end}
Date: Thu,  4 Apr 2024 13:06:04 -1000
Message-Id: <20240404230611.21231-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240404230611.21231-1-richard.henderson@linaro.org>
References: <20240404230611.21231-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x532.google.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

These opcodes are no longer used.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-op-common.h |  2 --
 include/tcg/tcg-opc.h       |  2 --
 accel/tcg/plugin-gen.c      | 18 ------------------
 tcg/tcg-op.c                | 10 ----------
 4 files changed, 32 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 72b80b20d0..009e2778c5 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -76,8 +76,6 @@ void tcg_gen_lookup_and_goto_ptr(void);
 
 void tcg_gen_plugin_cb(unsigned from);
 void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
-void tcg_gen_plugin_cb_start(unsigned from, unsigned type, unsigned wr);
-void tcg_gen_plugin_cb_end(void);
 
 /* 32 bit ops */
 
diff --git a/include/tcg/tcg-opc.h b/include/tcg/tcg-opc.h
index be9e36e386..546eb49c11 100644
--- a/include/tcg/tcg-opc.h
+++ b/include/tcg/tcg-opc.h
@@ -199,8 +199,6 @@ DEF(goto_ptr, 0, 1, 0, TCG_OPF_BB_EXIT | TCG_OPF_BB_END)
 
 DEF(plugin_cb, 0, 0, 1, TCG_OPF_NOT_PRESENT)
 DEF(plugin_mem_cb, 0, 1, 1, TCG_OPF_NOT_PRESENT)
-DEF(plugin_cb_start, 0, 0, 3, TCG_OPF_NOT_PRESENT)
-DEF(plugin_cb_end, 0, 0, 0, TCG_OPF_NOT_PRESENT)
 
 /* Replicate ld/st ops for 32 and 64-bit guest addresses. */
 DEF(qemu_ld_a32_i32, 1, 1, 1,
diff --git a/accel/tcg/plugin-gen.c b/accel/tcg/plugin-gen.c
index fb77585ac0..d9ee9bb2ec 100644
--- a/accel/tcg/plugin-gen.c
+++ b/accel/tcg/plugin-gen.c
@@ -52,29 +52,11 @@
 #include "exec/plugin-gen.h"
 #include "exec/translator.h"
 
-/*
- * plugin_cb_start TCG op args[]:
- * 0: enum plugin_gen_from
- * 1: enum plugin_gen_cb
- * 2: set to 1 for mem callback that is a write, 0 otherwise.
- */
-
 enum plugin_gen_from {
     PLUGIN_GEN_FROM_TB,
     PLUGIN_GEN_FROM_INSN,
     PLUGIN_GEN_AFTER_INSN,
     PLUGIN_GEN_AFTER_TB,
-    PLUGIN_GEN_N_FROMS,
-};
-
-enum plugin_gen_cb {
-    PLUGIN_GEN_CB_UDATA,
-    PLUGIN_GEN_CB_UDATA_R,
-    PLUGIN_GEN_CB_INLINE,
-    PLUGIN_GEN_CB_MEM,
-    PLUGIN_GEN_ENABLE_MEM_HELPER,
-    PLUGIN_GEN_DISABLE_MEM_HELPER,
-    PLUGIN_GEN_N_CBS,
 };
 
 static void plugin_gen_empty_callback(enum plugin_gen_from from)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 0ae12fa49d..eff3728622 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -322,16 +322,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo)
     tcg_gen_op2(INDEX_op_plugin_mem_cb, tcgv_i64_arg(addr), meminfo);
 }
 
-void tcg_gen_plugin_cb_start(unsigned from, unsigned type, unsigned wr)
-{
-    tcg_gen_op3(INDEX_op_plugin_cb_start, from, type, wr);
-}
-
-void tcg_gen_plugin_cb_end(void)
-{
-    tcg_emit_op(INDEX_op_plugin_cb_end, 0);
-}
-
 /* 32 bit ops */
 
 void tcg_gen_discard_i32(TCGv_i32 arg)
-- 
2.34.1


