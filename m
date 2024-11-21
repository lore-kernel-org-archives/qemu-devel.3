Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2879CD743FD
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2024 01:49:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDwHk-0001Z6-4q; Wed, 20 Nov 2024 20:47:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1tDwHg-0001WK-Hk
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 20:47:04 -0500
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1tDwHf-0004Wh-3t
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 20:47:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=6XkMx9+DoHnFbLoWD6EoNo07s+PU1JscoSTTclMp8dU=; b=nLAB8cvvpufIY0H
 hMM3lQjbM/DZ5UBaRHI4u8hsk6kW+CbzeDg897UWlu25YJ4frprfiusYojTfY2iK38N2Njepa42Ae
 wjBtpRH1QYzf4mLAivD0wuEOJCJVdPHrPgdBffB2YZB23eGAcRvp71oOkhui1aJ68bTtlQ7D2JrUq
 Wk=;
To: qemu-devel@nongnu.org
Cc: ale@rev.ng, ltaylorsimpson@gmail.com, bcain@quicinc.com,
 richard.henderson@linaro.org, philmd@linaro.org, alex.bennee@linaro.org
Subject: [RFC PATCH v1 05/43] tcg: Add helper function dispatcher and hook
 tcg_gen_callN
Date: Thu, 21 Nov 2024 02:49:09 +0100
Message-ID: <20241121014947.18666-6-anjo@rev.ng>
In-Reply-To: <20241121014947.18666-1-anjo@rev.ng>
References: <20241121014947.18666-1-anjo@rev.ng>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Adds a function pointer to the TCGContext which may be set by targets via
the TARGET_HELPER_DISPATCHER macro.  The dispatcher is function

  (void *func, TCGTemp *ret, int nargs, TCGTemp **args) -> bool

which allows targets to hook the generation of helper calls in TCG and
take over translation.  Specifically, this will be used by helper-to-tcg
to replace helper function translation, without having to modify frontends.

Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 accel/tcg/translate-all.c | 4 ++++
 include/tcg/tcg.h         | 4 ++++
 tcg/tcg.c                 | 5 +++++
 3 files changed, 13 insertions(+)

diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index fdf6d8ac19..814aae93ae 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -352,6 +352,10 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
     tcg_ctx->guest_mo = TCG_MO_ALL;
 #endif
 
+#if defined(CONFIG_HELPER_TO_TCG) && defined(TARGET_HELPER_DISPATCHER)
+    tcg_ctx->helper_dispatcher = TARGET_HELPER_DISPATCHER;
+#endif
+
  restart_translate:
     trace_translate_block(tb, pc, tb->tc.ptr);
 
diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index a77ed12b9d..d3e820568f 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -549,6 +549,10 @@ struct TCGContext {
 
     /* Exit to translator on overflow. */
     sigjmp_buf jmp_trans;
+
+
+    bool (*helper_dispatcher)(void *func, TCGTemp *ret_temp,
+                              int nargs, TCGTemp **args);
 };
 
 static inline bool temp_readonly(TCGTemp *ts)
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 0babae1b88..5f03bef688 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -2252,6 +2252,11 @@ static void tcg_gen_callN(void *func, TCGHelperInfo *info,
     }
 
     total_args = info->nr_out + info->nr_in + 2;
+    if (unlikely(tcg_ctx->helper_dispatcher) &&
+        tcg_ctx->helper_dispatcher(info->func, ret, total_args, args)) {
+        return;
+    }
+
     op = tcg_op_alloc(INDEX_op_call, total_args);
 
 #ifdef CONFIG_PLUGIN
-- 
2.45.2


