Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87CB0CAC5A7
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 02:41:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0swi-0004Ps-AX; Mon, 22 Sep 2025 22:40:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v0swY-0004Hr-BE
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 22:39:50 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v0swI-0003hL-3u
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 22:39:49 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-77ee6e252e5so3235900b3a.2
 for <qemu-devel@nongnu.org>; Mon, 22 Sep 2025 19:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758595170; x=1759199970; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qS0fPDEjjEFNBj0a5/ZuFmBU5kXyQi82F4E0DRl2Q9k=;
 b=N8zxI9zQKdDLynZXPermtYgFcou6PQTSKogS8Ts+kXcRd5A0caKBDQ3VV+h/mbYVjb
 k35QnF+ceU/hzSY9qSqeLOIkhGPwej6fCulUqvX0vko+tG0B/IwtbOTAuA5fbIZ4RNQj
 JHNuXMLyMoQTrUzbs6MQOF6iaxwUS7jlgipnDt2DIpzL7ZaJKsFvZmtMcvFAb2KHzmUl
 UtbjBl3zFf2KPpc4vPzEHLeiDFJPUJCVENQqT8UHTo8WMwTh6uJs1E8ZcAbnTdDRMOyu
 Ho2wIQkqgX8oSkUd+Lk9JLU+LhYGPK3wmNYX/1q6OUJSDNBVr7eS3NGlGJ2mc6zn/tqs
 vp6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758595170; x=1759199970;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qS0fPDEjjEFNBj0a5/ZuFmBU5kXyQi82F4E0DRl2Q9k=;
 b=E4SKtX41M1MOA1ScdIPuhDV9ayd76gZxr31l1SMLHkyprEd/HKGe8logLiJplTSoJi
 AKPN2iIZXqiJhaohIlHmv6mE+lxs2ilOJM0J8R6ZqaprOmbV59Y0IRlXi43boi01QF8g
 fyn18Ek8pEoDe4e19IFb0axiNlmI1g7ktV4jkKHntL1rH/uiNHjnoJktm3YiGfyS5piA
 vdIue/0oEf0h0t4RPSirNzM2wlI7ZBkWmy8RCNELl049JlY19J/vWtvezksR2DQSIq7z
 oJVY8gA6HIGqSlW36ao6dNugH9oeXi+d8ui7c8lmHQNg5vY5Za7vGmKTwQ686keasZBQ
 w8zg==
X-Gm-Message-State: AOJu0YzsU15q2X1LNXv+uExoyfP3lV5nPXhK7a7b1M/gCqdlDdptIMbQ
 MrqnbXgPVvfwWtt+AcxsN4lXkR1in2Ril89LI9DhXnJPgxkQk70Hzad9bMKsbSt2nMV2Z4cLQBI
 Nz3MO
X-Gm-Gg: ASbGncswcEGBaRUPdNVyYW8lj4e5PTNetPFqRZT8BmDMmVBnCgs5tzWSGo7gAy6lzc6
 AGBUlFL5USPJKZ8GsMfuqTH5uwPePK94VuBCcRIrVpGC4vlaPLTYK+zpp8WhWy21VJu4mKmce/g
 Xpiek3BXzh+0fmm1R8ULCoUeu5yXp04lyfAmeomUeFT/brgPbQTz5xXN0/fAtNBd5AUnYfere1t
 ufdAbAG/E+yRo5nr7QGFzGib/MriZOlL/8L3DQQC2adcCTMomq9CriRPK5kidAslBnIxwQImSvJ
 80NrBM3hDcQUTppjtdnlmEcP8vIRfWWuCuVKPA4afIznvMe30/jlxCiX3/wpqrJjWxt4QbvqnaU
 H7qJOfW6uMnb7rfDO/W5z3FK2CHEH
X-Google-Smtp-Source: AGHT+IEjHWeduhO57cwwSSsxxTgBXRA4AhkTTRrnAFnzyAEeMLV3d47mcO5/d7DFR1c+iBFo4nqD2g==
X-Received: by 2002:a05:6a00:1790:b0:776:1de0:4617 with SMTP id
 d2e1a72fcca58-77f538b5d05mr1060677b3a.11.1758595169898; 
 Mon, 22 Sep 2025 19:39:29 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-77f0da43089sm9899622b3a.90.2025.09.22.19.39.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Sep 2025 19:39:29 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 08/12] plugins: Use tb_flush__exclusive
Date: Mon, 22 Sep 2025 19:39:12 -0700
Message-ID: <20250923023922.3102471-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250923023922.3102471-1-richard.henderson@linaro.org>
References: <20250923023922.3102471-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

In all cases, we are already within start_exclusive.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
Cc: Alex Bennée" <alex.bennee@linaro.org>
Cc: Alexandre Iooss <erdnaxe@crans.org>
Cc: Mahmoud Mandour <ma.mandourr@gmail.com>
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 plugins/core.c   | 6 ++----
 plugins/loader.c | 2 +-
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/plugins/core.c b/plugins/core.c
index c6e9ef1478..4ae1a6ae17 100644
--- a/plugins/core.c
+++ b/plugins/core.c
@@ -248,7 +248,7 @@ static void plugin_grow_scoreboards__locked(CPUState *cpu)
         }
         plugin.scoreboard_alloc_size = scoreboard_size;
         /* force all tb to be flushed, as scoreboard pointers were changed. */
-        tb_flush(cpu);
+        tb_flush__exclusive();
     }
     end_exclusive();
 }
@@ -684,8 +684,6 @@ void qemu_plugin_user_exit(void)
      * with the one in fork_start(). That is:
      * - start_exclusive(), which acquires qemu_cpu_list_lock,
      *   must be called before acquiring plugin.lock.
-     * - tb_flush(), which acquires mmap_lock(), must be called
-     *   while plugin.lock is not held.
      */
     start_exclusive();
 
@@ -705,7 +703,7 @@ void qemu_plugin_user_exit(void)
     }
     qemu_rec_mutex_unlock(&plugin.lock);
 
-    tb_flush(current_cpu);
+    tb_flush__exclusive();
     end_exclusive();
 
     /* now it's safe to handle the exit case */
diff --git a/plugins/loader.c b/plugins/loader.c
index 8f0d75c904..6849e1c518 100644
--- a/plugins/loader.c
+++ b/plugins/loader.c
@@ -378,7 +378,7 @@ static void plugin_flush_destroy(CPUState *cpu, run_on_cpu_data arg)
     struct qemu_plugin_reset_data *data = arg.host_ptr;
 
     g_assert(cpu_in_exclusive_context(cpu));
-    tb_flush(cpu);
+    tb_flush__exclusive();
     plugin_reset_destroy(data);
 }
 
-- 
2.43.0


