Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DF07C3271E
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 15:39:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPkzy-0002bq-Fn; Fri, 05 Jul 2024 11:37:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sPkzt-0002aZ-P8
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 11:37:17 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sPkzr-0001Gv-Ma
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 11:37:17 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-58b966b41fbso2492910a12.1
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2024 08:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720193834; x=1720798634; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0dlqVxV0N2PAZeKsvqSde0gH8murih16mQWVBlzmyoo=;
 b=opyRY+Z6F3kWtt5Q+gralYQACf1pNgoKANX1Nd/L5WCeE0NIwSMflaM/q4O2uzixO7
 O3YkX9KXz0iwPpugj0/fjE9TERNVPNBlwC0d/V+4NvZbiOJV3BQ1BKiFOFZAreKLxsWm
 vHERnryTXtb0vid5KOcoqpGFk5Qrcs9A+9NhFVQMPHQ/4JpC9A7AiEDiYj8lmDCVWEab
 qRZRlPpAyiN7n+TPDW4wMcFShcZ1DOMmLWMv/hWNHPlcFABl+Xc/0no3CpA98Mkr1Pyx
 +hzifHzqZHw3baajGhAZAvWnwE711P3pDEsosPHoBuYmKKdYynvXQMd0r/dXooFcKfH8
 GOww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720193834; x=1720798634;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0dlqVxV0N2PAZeKsvqSde0gH8murih16mQWVBlzmyoo=;
 b=J20LyX025Wz5hENEZhz2r7gxL3C9BouAqEcKkHqCbDcUuCUOpuL5TuN2hyanFga7wi
 XmRBcvGGyTOOkRISZjHzltMSXNiZWSi6tA25jbljmAE6ni+KKh4iANuWAZQrtCY5IdZw
 uUQHLKLeQLagG0tR9B951CTZuIqrhIKcg79vmcLjsrLf/d7DvV8u54nKq/jILrgVNCmp
 g4s/BjgN1vffM+AAeLzbSKSgV8jWjQeU0VtyJDEO6PZGECue53DFRcPujBM7gH8XHEQe
 zrXLwOiPNdOUnhgI2T3rieDa2ROSJeqTq2yO/O96Z3/HY+4GAERh/XZUI01YP+AsAY3Q
 mcfQ==
X-Gm-Message-State: AOJu0YzTm/mCWB0TUhAS2ERm/JD38FAYRWKLWFApsqXyWtY6cI/hwKuM
 Wmhf2hY3BFCgqEWDnAxWcG28Nk85Pn5T9iptxcSOGDPStRHNNpEyA9JFkdiMO6M=
X-Google-Smtp-Source: AGHT+IHw9YfQcIfOXRyMYZqDzbPJA9O7N83TExhGNDUBJ9JzqYXNTOKPz9MmwFsOuBpNU/MwPMlY8A==
X-Received: by 2002:a17:907:76d4:b0:a77:dd5c:d7f4 with SMTP id
 a640c23a62f3a-a77dd5ce42cmr45292866b.15.1720193834020; 
 Fri, 05 Jul 2024 08:37:14 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a77cdc2e039sm56103766b.28.2024.07.05.08.37.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jul 2024 08:37:11 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 086EB6213B;
 Fri,  5 Jul 2024 16:30:55 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 21/40] test/plugin: make insn plugin less noisy by default
Date: Fri,  5 Jul 2024 16:30:33 +0100
Message-Id: <20240705153052.1219696-22-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240705153052.1219696-1-alex.bennee@linaro.org>
References: <20240705153052.1219696-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x532.google.com
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

While the match functionality is useful lets make the verbosity
optional while we are actually running.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240705084047.857176-22-alex.bennee@linaro.org>

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


