Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18791E77184
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 22:43:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNgHe-0004J9-VO; Tue, 17 Dec 2024 17:43:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tNgHc-0004Ii-Sb
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 17:43:16 -0500
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tNgHa-000194-SX
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 17:43:16 -0500
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-725abf74334so5130225b3a.3
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2024 14:43:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734475393; x=1735080193; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FtDnDxoim/xhxV1Wp1Am01Tmaf0WaBzRac6ychlNj2g=;
 b=vgrUOOB9Bm9Qh4mcnM3QtJ9vigBbpDj2gykRBjWtvCJk6/D7ribXa5KlRq2/gr/X+2
 7tisHupeBuYUPZ1GQLOEZDnNCriHlbSVeuy+djXgSYS4swJqZAslGEYGoyfGWDfdrdlq
 lZyhevSKhsVrOzYhGRnfF8Fpdzb0utKbsNgMGcYW2d1vYx6gIQaA2YpqNxlZOqVyYJhk
 8EvjXIV/rZTRJJ5CyLaep3j/Kna6KrAJtzS/bPC0WnWU5aoUQnXtjOfhXNMNcqMtmgOI
 p39v/8Y7OXHW4jaqU5znf7q/FvLkzxTIRPvhiLc9Bi/nCIGQ7uAk4JHrl1K9fGFoYYUS
 QI0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734475393; x=1735080193;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FtDnDxoim/xhxV1Wp1Am01Tmaf0WaBzRac6ychlNj2g=;
 b=jCt4f+yNdJW3sHw3G8yJw1mlioAmF+juGWbWxmz1h6es49+GTrcYpAaR9L+dB7Y2yo
 i269zl1bTmMBCYB5KId6qPAG8ugipK4iihey5tTy1lgmL0jxT/p4o252aA8Ztbs3rLcx
 Yu+N+28OvOu8Z1kHAUAvGC1Ud6d6pDMsuQW0CXDo+OdOoV7M9iD4LoelHLr3/JfICf1Y
 rsiJeQqBSxGi7ug/o4s7l/LM5sRqLK367zptNQ3e6/yC1Gu6CUlXX5TTowikMvmVAyH+
 594M+yzgxCmHkMf2gIA3o6/mJjbUlpWQ5zndg8FhHohbyWB2FsFEKKJSwxiAzTpnQ5Qk
 dVmg==
X-Gm-Message-State: AOJu0YyeFYGc4iFZ2jnVGGV5IiKca3MX02YUaC32/y7vrk//tFSzfA6S
 B0O03RnSy3JFpUYkNXXZ7bR6QuHnT+pFJ+x4nQHrjlkGUt0fXx+105UE9TB+BucUaLMr/dm/aOb
 5Sys=
X-Gm-Gg: ASbGncvMN8/yYV97u5KfFf//MP8TZPwct63FG0PWueUCsDFJZLC5CU7HWi1VbQRUnr2
 JaOYK+SGsp7OzjVHgtUU3BPQxkEgpwMy3MHXE65V7lWyNtj67jr4fqbEDO7N4ylG3rqpO3byRX9
 XmNOdSmgxIGSHqs3rIXNptv48vLJZ1ijhUgFFAizXABxaFrpleJdYi7lqQsze1zLs5vCi7fXa9t
 MdHCl6h97d8r2j47+UxTslEtMfb1pIwUMQNTkmkbddChdGVkwhstkNW
X-Google-Smtp-Source: AGHT+IHZvji7vI6NXTxDkqPGf7cm9WpgcjO9tCO+7PdQI9oDOSSnUb4p/D9NiyVWNZjZTw6ITCFtMw==
X-Received: by 2002:a05:6a20:9183:b0:1e2:2e4:689a with SMTP id
 adf61e73a8af0-1e5b489b0c1mr1147195637.41.1734475393437; 
 Tue, 17 Dec 2024 14:43:13 -0800 (PST)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72918ac53f3sm7463214b3a.27.2024.12.17.14.43.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Dec 2024 14:43:13 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, philmd@linaro.org,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Thomas Huth <thuth@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v3 03/11] tests/tcg/plugins/syscall: fix 32-bit build
Date: Tue, 17 Dec 2024 14:42:58 -0800
Message-Id: <20241217224306.2900490-4-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241217224306.2900490-1-pierrick.bouvier@linaro.org>
References: <20241217224306.2900490-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x432.google.com
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 tests/tcg/plugins/syscall.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tests/tcg/plugins/syscall.c b/tests/tcg/plugins/syscall.c
index ff452178b18..47aad55fc1b 100644
--- a/tests/tcg/plugins/syscall.c
+++ b/tests/tcg/plugins/syscall.c
@@ -76,12 +76,12 @@ static int64_t write_sysno = -1;
 static SyscallStats *get_or_create_entry(int64_t num)
 {
     SyscallStats *entry =
-        (SyscallStats *) g_hash_table_lookup(statistics, GINT_TO_POINTER(num));
+        (SyscallStats *) g_hash_table_lookup(statistics, &num);
 
     if (!entry) {
         entry = g_new0(SyscallStats, 1);
         entry->num = num;
-        g_hash_table_insert(statistics, GINT_TO_POINTER(num), (gpointer) entry);
+        g_hash_table_insert(statistics, &entry->num, entry);
     }
 
     return entry;
@@ -232,7 +232,7 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
     }
 
     if (!do_print) {
-        statistics = g_hash_table_new_full(NULL, g_direct_equal, NULL, g_free);
+        statistics = g_hash_table_new_full(g_int64_hash, g_int64_equal, NULL, g_free);
     }
 
     if (do_log_writes) {
-- 
2.39.5


