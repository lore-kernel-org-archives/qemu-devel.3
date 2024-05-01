Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22391C4345F
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2024 14:40:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2B6G-0002t0-M0; Wed, 01 May 2024 10:38:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s2B5n-0002h4-JA
 for qemu-devel@nongnu.org; Wed, 01 May 2024 10:37:58 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s2B5l-00029R-T0
 for qemu-devel@nongnu.org; Wed, 01 May 2024 10:37:55 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1e9ffd3f96eso55769025ad.3
 for <qemu-devel@nongnu.org>; Wed, 01 May 2024 07:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714574272; x=1715179072; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P3yOz4ai1P+rruJtDN+ly5UPZeaVEUB8c8mUXDe5M74=;
 b=ARnzWV576Oz9GXZnOhd1lYdVggI6tOwLMzVnh91FiP7xJD5w12cy51pVtvC0vHjjZq
 5zJI0IVKYptBJJ/TasrvHTiS8YGeMX1LMhgpQ608+KYvcRP6fJb3PvrvRgncsF8so0fi
 eRhOBNbNqeer9njUIF/aAZRvsl+CW1uqvDrYPg7myvNQQEo0On4HRVVt/vqtRLEtFaZE
 EADbGQT+R+YARCCn9DH/yPP317MtY1Cu/58sEaFHlsS4w/FmlB0d37HgT7eSDiYGH2XF
 uyw2+O3X2G9G/kRYgUOkKQ/czDB4bsfWC4TqenCj7547s+1L8ZuZybMGEfi/+BIACfoa
 0O/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714574272; x=1715179072;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=P3yOz4ai1P+rruJtDN+ly5UPZeaVEUB8c8mUXDe5M74=;
 b=agSQEZzz3YLQm+zHil3QJN77FG9jvc3M6E5cCbLFMG8xHnZDts2uwWec+CxtSymX/C
 tvfEt1EVPMA1M8mJbOPNpWtdITMwPLag4mzqTjOMt65JqQAvcQv8xSviclwnSLN0pl1A
 PyKB34r6RRVenwTNoKfAU2alqtEoYqrluADjeTxIy8xVGmU12vlkKPzmouNk9hrSXuBW
 ElgKF10nKVrP+SJRY8sVptUHbglQWmRhnseT8crqrUFt5WRnmiFQ7e30cGJ+OU415IZh
 IFV6D8p7IK/zDTJ97yZBLr/eW8dbD2hZteaW2Sm8DaVuVKP2vjQ4EhfYC7s+08T03InI
 1h7Q==
X-Gm-Message-State: AOJu0YwfiHcHA7mdME5+W4PiN8WDezFnPXXv21OHZ9cz6pp+wp7rjmD2
 SZ5Cfr85g0m9TEME2uHc3fm6Dn8S1H0Vv3ow3lvJCgkGM/aGf459WzTkujCHpF8FPrqhiIAu89P
 w
X-Google-Smtp-Source: AGHT+IEjuFz5l/8a2TPRk/skB82/pPCFgqeRa2KOfTjgQRh9zReCwI8lNdi9yOCv0g4xGbu3vNbD2w==
X-Received: by 2002:a17:902:6506:b0:1eb:1fdc:25e7 with SMTP id
 b6-20020a170902650600b001eb1fdc25e7mr2775459plk.19.1714574272575; 
 Wed, 01 May 2024 07:37:52 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 h12-20020a170902f54c00b001ebd73f61fcsm5751573plf.121.2024.05.01.07.37.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 May 2024 07:37:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 12/20] tcg: Remove TCG_CALL_PLUGIN
Date: Wed,  1 May 2024 07:37:31 -0700
Message-Id: <20240501143739.10541-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240501143739.10541-1-richard.henderson@linaro.org>
References: <20240501143739.10541-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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
index 7484a07722..cfcf9122d6 100644
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


