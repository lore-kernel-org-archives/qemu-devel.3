Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0248ACD1296
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Apr 2024 23:08:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsWAW-00028f-DF; Thu, 04 Apr 2024 19:06:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rsWAG-00023g-N4
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 19:06:38 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rsWAE-0007mr-1J
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 19:06:36 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-29e0a1fd9a7so1051770a91.2
 for <qemu-devel@nongnu.org>; Thu, 04 Apr 2024 16:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712271991; x=1712876791; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/FK2WWMw+RB5io7Nzuf8LNknc8niTsj2ljKDgkXD3m0=;
 b=F9CJpeEfEUFzmK1dXcHzQO4J1bwknYXvsXlH5xtTkPB0AEMRrqb68RErjx1WJi5zca
 ZZJt1zvB4z/RRUsy82HdVkA4va0Am4uWj0FdqqrI0k7eZtntRGrpht+PRPVERUYzxlkQ
 yGZhHtNgwZinDnf5XIS+DzimhtZiluJfWopO3pxraXK06BUgB2pCDpB/cuXscVhDdiUe
 M+hEsMWsC2JVe89gTQhsyl6ikx8Vx69+lT1yHSxKVxXcMrCGtkzppGAMYznA3QCD/hqJ
 hdDXterdblGTQgnx6AqBUPELt5HDJTI1lAB61/TyvHvvqJXOHZjW9W0qz5m1cbjUzH1T
 DFaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712271991; x=1712876791;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/FK2WWMw+RB5io7Nzuf8LNknc8niTsj2ljKDgkXD3m0=;
 b=PnkEY3Tsabgh8ldPtNkGVxx7BAk3eGkoO9d7QM0NahNdP2huRYFUa5J5z2sbmKeDoW
 kgOVk8b2pHVAI4F8ELCzLsTN5e+hhGqs4fbAWvFqSX98vIcrRXD36SW3Z+0Si2u9Wcu0
 04lqSu50FkDPFTZh/zH8OnRpsNN9Z8zgcvpGysOST7IvbnO+3utKyUopmVp8lpa/O8mV
 IXQd1h1f1pV/YF2MUGSxpXYCf2HJqcIeYDE9BmF2rUHXaA77QKknKzKPXdjSTa/7Wn0R
 J604afjcymReG4UO/3JuwGlSKtGUIYgIVOKLoC+9NKWIr4Rll7E0/TBDojUrSoOxnuNT
 eSyw==
X-Gm-Message-State: AOJu0YzQ5yWVUWBBbAcbJx4d2rENgzWI93MG5SmVhYQOr7U2WPAz7oyz
 LtMKBPJBamOEjWqySceooQXJ0JYQB+MKi1byCkmDLtZubjtqp91M9/2A0hk6iBu3zAJq0XP0ZA1
 k
X-Google-Smtp-Source: AGHT+IHCl/wJUf8xVC7A5HZIlVttNikbfcOWXUEC2/1VmOkWtI2NSPPtdt9OAJMckQmWQZjFzfUDCA==
X-Received: by 2002:a17:90a:898a:b0:2a2:d009:75f2 with SMTP id
 v10-20020a17090a898a00b002a2d00975f2mr3065446pjn.28.1712271991587; 
 Thu, 04 Apr 2024 16:06:31 -0700 (PDT)
Received: from stoup.. (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 q36-20020a17090a17a700b002a2f3cfc92asm1052592pja.16.2024.04.04.16.06.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Apr 2024 16:06:31 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 13/21] tcg: Remove TCG_CALL_PLUGIN
Date: Thu,  4 Apr 2024 13:06:03 -1000
Message-Id: <20240404230611.21231-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240404230611.21231-1-richard.henderson@linaro.org>
References: <20240404230611.21231-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102e.google.com
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


