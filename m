Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15DFAC19F4E
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 23:03:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzldU-0003n4-DK; Wed, 24 Apr 2024 19:02:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzldS-0003le-9H
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 19:02:42 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzldQ-0002eG-K0
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 19:02:42 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-6ed04c91c46so446802b3a.0
 for <qemu-devel@nongnu.org>; Wed, 24 Apr 2024 16:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713999759; x=1714604559; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/FK2WWMw+RB5io7Nzuf8LNknc8niTsj2ljKDgkXD3m0=;
 b=fB62EToblP/73xujJ8oVS/pD/uf8LigxMIO9Tg5vlVJHBW34IXV8NTrB1WUtmswUXA
 NHEojeIP89HT/d17Ycjd3/04/pMzPEVuoRab94TMw+VktNsUyT+FFOQBLc/t2Vs74++w
 pstNt9lBr7TfDhiKVdhFTsXUprIjSce5d2aGjgq1WI7FcGmFWKXy2PQ3Xd725XHhr7wq
 TutEiH32b+E+RYK9unh9eiOcQo74yV4+FQh4sIyvGCXOjyoOwuaJsRcWU9g/oxCb5175
 e+5qkYXLJlDY/IxDJb7qn0RDJIJDCEUsJVgbaz019rSsberdeOYAoHxPrFpFcgZOIYjK
 P40Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713999759; x=1714604559;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/FK2WWMw+RB5io7Nzuf8LNknc8niTsj2ljKDgkXD3m0=;
 b=DC7IZ1lyL7vAGrXEzhy/QdUhxeeYad8OtZRBm7hGZVOkDnnNfa6ew8xKweWR3efoQ+
 uhIFMwAHnjrSUphEDyBJCmwlKPF2MfXQvy+gWVa4znZk4Dogp6AfsJ6EspI9x2KjNCZx
 GV76tP+ladxHxmF/84jbbujeuFyttwEcsxcUFtMdFOO7n96sw7k/FB3RDWl9Yr/tORuK
 SxIbIxAWqY+AvpjXrh1bhrhQy2cn464lTJxJvWV4U4J6vpOOjvwMkEN8T+JFDz9kwALz
 YTpPuf0JJ9DEiFXsaiSJ6OGV5QKWuZpI0HFbfAgyOPq0TzZshZFLogxPSCiQ/Yuop63U
 4GFw==
X-Gm-Message-State: AOJu0Yw2FOWexQjo6AXmAmKblPgv+OpD4bkIQgs12NMZBT174CEAnptD
 Ol/YR+bZRWm+xfIzqij75BxldSsbmHYADsdxfS9eNepDTxvLthKMMzNF6C1VLtacJWNWDkGdl65
 T
X-Google-Smtp-Source: AGHT+IEwev4judT9SFE7p97AhGlPG3UbAcggxBFCAs6hlsR3I6gqgyFl7v/O8t7GrDiHDcup5aPvWQ==
X-Received: by 2002:a05:6a20:5b22:b0:1aa:bde:8c78 with SMTP id
 kl34-20020a056a205b2200b001aa0bde8c78mr3450969pzb.54.1713999759249; 
 Wed, 24 Apr 2024 16:02:39 -0700 (PDT)
Received: from stoup.. ([156.19.246.23]) by smtp.gmail.com with ESMTPSA id
 h5-20020a056a00000500b006ed4aa9d5c0sm11981405pfk.188.2024.04.24.16.02.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Apr 2024 16:02:38 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 12/20] tcg: Remove TCG_CALL_PLUGIN
Date: Wed, 24 Apr 2024 16:02:16 -0700
Message-Id: <20240424230224.941028-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240424230224.941028-1-richard.henderson@linaro.org>
References: <20240424230224.941028-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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

Since we no longer emit plugin helpers during the initial code
translation phase, we don't need to specially mark plugin helpers.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg.h |  2 --
 plugins/core.c    | 10 ++++------
 tcg/tcg.c         |  4 +---
 3 files changed, 5 insertions(+), 11 deletions(-)

diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index 8d9f6585ff..196e3b7ba1 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -353,8 +353,6 @@ typedef TCGv_ptr TCGv_env;
 #define TCG_CALL_NO_SIDE_EFFECTS    0x0004
 /* Helper is G_NORETURN.  */
 #define TCG_CALL_NO_RETURN          0x0008
-/* Helper is part of Plugins.  */
-#define TCG_CALL_PLUGIN             0x0010
 
 /* convenience version of most used call flags */
 #define TCG_CALL_NO_RWG         TCG_CALL_NO_READ_GLOBALS
diff --git a/plugins/core.c b/plugins/core.c
index b0a2e80874..b0615f1e7f 100644
--- a/plugins/core.c
+++ b/plugins/core.c
@@ -339,9 +339,8 @@ void plugin_register_dyn_cb__udata(GArray **arr,
                                    void *udata)
 {
     static TCGHelperInfo info[3] = {
-        [QEMU_PLUGIN_CB_NO_REGS].flags = TCG_CALL_NO_RWG | TCG_CALL_PLUGIN,
-        [QEMU_PLUGIN_CB_R_REGS].flags = TCG_CALL_NO_WG | TCG_CALL_PLUGIN,
-        [QEMU_PLUGIN_CB_RW_REGS].flags = TCG_CALL_PLUGIN,
+        [QEMU_PLUGIN_CB_NO_REGS].flags = TCG_CALL_NO_RWG,
+        [QEMU_PLUGIN_CB_R_REGS].flags = TCG_CALL_NO_WG,
         /*
          * Match qemu_plugin_vcpu_udata_cb_t:
          *   void (*)(uint32_t, void *)
@@ -375,9 +374,8 @@ void plugin_register_vcpu_mem_cb(GArray **arr,
         !__builtin_types_compatible_p(qemu_plugin_meminfo_t, int32_t));
 
     static TCGHelperInfo info[3] = {
-        [QEMU_PLUGIN_CB_NO_REGS].flags = TCG_CALL_NO_RWG | TCG_CALL_PLUGIN,
-        [QEMU_PLUGIN_CB_R_REGS].flags = TCG_CALL_NO_WG | TCG_CALL_PLUGIN,
-        [QEMU_PLUGIN_CB_RW_REGS].flags = TCG_CALL_PLUGIN,
+        [QEMU_PLUGIN_CB_NO_REGS].flags = TCG_CALL_NO_RWG,
+        [QEMU_PLUGIN_CB_R_REGS].flags = TCG_CALL_NO_WG,
         /*
          * Match qemu_plugin_vcpu_mem_cb_t:
          *   void (*)(uint32_t, qemu_plugin_meminfo_t, uint64_t, void *)
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 0bf218314b..363a065e28 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -2269,9 +2269,7 @@ static void tcg_gen_callN(void *func, TCGHelperInfo *info,
 
 #ifdef CONFIG_PLUGIN
     /* Flag helpers that may affect guest state */
-    if (tcg_ctx->plugin_insn &&
-        !(info->flags & TCG_CALL_PLUGIN) &&
-        !(info->flags & TCG_CALL_NO_SIDE_EFFECTS)) {
+    if (tcg_ctx->plugin_insn && !(info->flags & TCG_CALL_NO_SIDE_EFFECTS)) {
         tcg_ctx->plugin_insn->calls_helpers = true;
     }
 #endif
-- 
2.34.1


