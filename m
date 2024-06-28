Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D209EC2BD09
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 12:45:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sNAx6-0005GK-Ka; Fri, 28 Jun 2024 08:43:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sNAwV-0004oO-T0
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 08:43:08 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sNAwU-0005fs-6W
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 08:43:07 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-584ee8da49aso3089524a12.0
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 05:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719578584; x=1720183384; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rvGmIc/IqaQmuLkCI/kfZ02beHV2np9KXDzigOomwVY=;
 b=LQ2i+wzo/qi5MzmYH5uZWE7RY2FTOZzYPF2qAltQjgnVzLLQnM2jYS4mhXUUzlSizY
 u8pg2LESNTV/pdACZILIaf9I57ltdkhyQZiyluUTrb5IpQKtoHwO3pTxWUa0zbPY2UKO
 F3BclslVtRW7YCIeEygP6xQB0U1GekLBbiP2M5cfXnp2LJKq1Urx4jadjM2CgpHiAx32
 OD65MUJ0sflErC0p4QvxDaHvsKWe6J9iKgZIdjtylmyOpZWuLvdG/mF50ZIeb9pZYOr+
 YJJ6QlnFB5OD0AhSChOMs0gqVDG0vdtxzHOJbdr+BYvVXqIyxqERGTu4mUjK1rcl1bv4
 TXmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719578584; x=1720183384;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rvGmIc/IqaQmuLkCI/kfZ02beHV2np9KXDzigOomwVY=;
 b=nknmRAEkrFXRZh7dkR1XXJpLdKEfkNKEgtXBK6SI/PQyjaWC6r9MZAnvkWqT/VQuRb
 b0D4BWkODXT1ZPz3GcQ3Qettd2VKZZLljFkSv+7XhYx5VS/UPTs/GJwVWS6U27bdqHlA
 YjSmCHLPKmsREg/DsV8qRb2xBjqhd1ysmFcFfKV/GYY174EOLdUwpI//2Dvg/2BduPyX
 yHfh0rQixpN0TbCKdgm2XkPzsIbhYZjt9jwwl25AEF9YBpl07BAwxEk2Xs+kD/ZmuTi0
 X7LFAiuweK3K267QAfTcz1bVA33j+30hkVkziPQ+Imxh7Op3IJmHifuTsDH63UGhOdhK
 Re2A==
X-Gm-Message-State: AOJu0Yw76eWvNw/R3IEUsCCMz5q8zXZL6roPKzZsbSdktmOkLjYtSAlq
 W/xNjibMjxPbGgBNIbemXyK4t/bABusvuKwzBRcUE9g6anwsabKn/B9m8B+7f4k=
X-Google-Smtp-Source: AGHT+IEYYV3YJQeizporoofEsJYAFW1V8ZfOcmyW0NWTINkOfBKyfZgVbjC3k1twcoJS4y9EGymywg==
X-Received: by 2002:a05:6402:440a:b0:57d:1d9e:d1fe with SMTP id
 4fb4d7f45d1cf-5865c1f6e88mr1438298a12.9.1719578584324; 
 Fri, 28 Jun 2024 05:43:04 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5861381756esm988562a12.56.2024.06.28.05.43.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Jun 2024 05:43:03 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id A04135FA12;
 Fri, 28 Jun 2024 13:42:59 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>, Beraldo Leal <bleal@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-arm@nongnu.org,
 Peter Xu <peterx@redhat.com>, Mads Ynddal <mads@ynddal.dk>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH 07/23] test/plugin: make insn plugin less noisy by default
Date: Fri, 28 Jun 2024 13:42:42 +0100
Message-Id: <20240628124258.832466-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240628124258.832466-1-alex.bennee@linaro.org>
References: <20240628124258.832466-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x530.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

While the match functionality is useful lets make the verbosity
optional while we are actually running.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/plugin/insn.c | 36 +++++++++++++++++++++---------------
 1 file changed, 21 insertions(+), 15 deletions(-)

diff --git a/tests/plugin/insn.c b/tests/plugin/insn.c
index 5e0aa03223..524f9ddde8 100644
--- a/tests/plugin/insn.c
+++ b/tests/plugin/insn.c
@@ -20,6 +20,7 @@ static qemu_plugin_u64 insn_count;
 
 static bool do_inline;
 static bool do_size;
+static bool do_trace;
 static GArray *sizes;
 
 typedef struct {
@@ -73,30 +74,30 @@ static void vcpu_insn_matched_exec_before(unsigned int cpu_index, void *udata)
     MatchCount *match = qemu_plugin_scoreboard_find(insn_match->counts,
                                                     cpu_index);
 
-    g_autoptr(GString) ts = g_string_new("");
-
     insn->hits++;
-    g_string_append_printf(ts, "0x%" PRIx64 ", '%s', %"PRId64 " hits",
-                           insn->vaddr, insn->disas, insn->hits);
 
     uint64_t icount = qemu_plugin_u64_get(insn_count, cpu_index);
     uint64_t delta = icount - match->last_hit;
 
     match->hits++;
     match->total_delta += delta;
-
-    g_string_append_printf(ts,
-                           " , cpu %u,"
-                           " %"PRId64" match hits,"
-                           " Δ+%"PRId64 " since last match,"
-                           " %"PRId64 " avg insns/match\n",
-                           cpu_index,
-                           match->hits, delta,
-                           match->total_delta / match->hits);
-
     match->last_hit = icount;
 
-    qemu_plugin_outs(ts->str);
+    if (do_trace) {
+        g_autoptr(GString) ts = g_string_new("");
+        g_string_append_printf(ts, "0x%" PRIx64 ", '%s', %"PRId64 " hits",
+                               insn->vaddr, insn->disas, insn->hits);
+        g_string_append_printf(ts,
+                               " , cpu %u,"
+                               " %"PRId64" match hits,"
+                               " Δ+%"PRId64 " since last match,"
+                               " %"PRId64 " avg insns/match\n",
+                               cpu_index,
+                               match->hits, delta,
+                               match->total_delta / match->hits);
+
+        qemu_plugin_outs(ts->str);
+    }
 }
 
 static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
@@ -216,6 +217,11 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
             }
         } else if (g_strcmp0(tokens[0], "match") == 0) {
             parse_match(tokens[1]);
+        } else if (g_strcmp0(tokens[0], "trace") == 0) {
+            if (!qemu_plugin_bool_parse(tokens[0], tokens[1], &do_trace)) {
+                fprintf(stderr, "boolean argument parsing failed: %s\n", opt);
+                return -1;
+            }
         } else {
             fprintf(stderr, "option parsing failed: %s\n", opt);
             return -1;
-- 
2.39.2


