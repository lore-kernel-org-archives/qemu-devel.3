Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCF98C83F1A
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Jul 2025 04:58:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ue52o-0005jE-1U; Tue, 22 Jul 2025 00:56:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ue52X-0005bs-Jt
 for qemu-devel@nongnu.org; Tue, 22 Jul 2025 00:55:47 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ue52T-0004Gp-0Z
 for qemu-devel@nongnu.org; Tue, 22 Jul 2025 00:55:42 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-b34a6d0c9a3so5147418a12.3
 for <qemu-devel@nongnu.org>; Mon, 21 Jul 2025 21:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753160140; x=1753764940; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bTTq9wgcgDFhDutfJJC82sCVw2rH7HCJB+ChDzBs1bA=;
 b=G/yc22ixehPlgLZEg6MPFAm1Xikgx9F4KXyOKHzBNuxCdwsScazFF9WxR6wKFO0j77
 7obrH3nhZdRbOb0y+OxQqzZrSXsKLnclx965JQ68g9FwPk/wNC7X+FJPRY+6g8C46gvG
 hYf58A3Tnt1Rg44Kpk4qLtGphcfpxFVmm1X4JKws+np0pDGnwAHHbqB2VhayOCJxUmEe
 wYXGIL1/wNL4Epc6PY1pXZm5NRvHNKs2aeM094wQBU2wh5hpvG2yhIootgnVO+/A/1rH
 E9yEys//DEbAmZnlL34/zAz61xu+fIuGntrmvGTf6z7owp5lE55iZqoRerGGAYlwMvZL
 K1UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753160140; x=1753764940;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bTTq9wgcgDFhDutfJJC82sCVw2rH7HCJB+ChDzBs1bA=;
 b=weuuvYh53VK41XGTXhnu8IMqvfjPurjKtb3WLLyij/GJratA0VVukNjCuebpqKrm8+
 +w9Vr+RYanb7qlTE94YItZFSeOu029DJ6G99BfulbGQ1zj32NAdikg1FycEIQXmXLm9R
 33AaPCK2M2ANA1lwke+drbXEqKplq4klzghFfuDUJGyFhHO4/3gUaVqmSJJYAEkkvD8Y
 /4zaObyCzb/GHkyRZSKa2WngaVsSUZgX4XD7ItwTZQw29m0A6RV+cjZ45HFWeqhSJVrq
 Riue29j5LVMzLUOtP0JSdjOj8mSQoa0lL4zZ/VVAvIP87gXDcmce+f3JfHtKcqd1qioq
 xRNg==
X-Gm-Message-State: AOJu0Yx9IQ0VXbeI9HxEEovIvmn4ASaOsyIzRZuThqWjE9gl6rkLtSLB
 jVQIptZ0MfezOAkc3LBKySQpQrFmdVNtQjp+WOuvoUvdSBdMy3IFtVO0eEzd2kFUurJ/fkzqP/L
 p+bd2
X-Gm-Gg: ASbGncsONeM4WKjvjK3PLduntMMcI+oI1cnJb/VTOu1FvptNmrm3vny9qVqOkqYJ1u8
 iBUQGPaq7wjOtoR1nzc2/I6Gbs5LXA1JBEA7gqkX/fipoMuSVmfs6nYNDRDDiiYpRx/Oae4FNGT
 f/byAF0/xQi+g2E7+kkUGGEV8TPyiXycy1Sk8BW4sBRUZCXPdAkSuZ2PQD/Q4tl5qcG0e57cZdG
 17dehhaIjUwi8051RJEbxbzZTrJI4tZd2uSxJn5ayp+L4TIQpPdVpc7capk26t9iY7EYkZMziJx
 HNB/TNJwD8vYMMtMD+Atw8lHnFph4J8fJ+Dh7LEyv7RK86B95cKj6N0VwDXTOF6nLUv1K8bedZf
 DGfMvyIzRCzweNd4EnP6U/A==
X-Google-Smtp-Source: AGHT+IHlgmEk3lhAL2fitfb3dr5idsLcP5oz9EnfLvaJ7slKGPk4coF5sss3P7z/Z2QFRUCKQNTsBQ==
X-Received: by 2002:a17:90b:5385:b0:312:e51c:af67 with SMTP id
 98e67ed59e1d1-31c9f3ef43cmr28364310a91.1.1753160139584; 
 Mon, 21 Jul 2025 21:55:39 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-31cc3e5b038sm7065311a91.10.2025.07.21.21.55.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Jul 2025 21:55:39 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Gustavo Romero <gustavo.romero@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 rowan Hart <rowanbhart@gmail.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 4/6] contrib/plugins/uftrace: add
 timestamp-based-on-real-time option
Date: Mon, 21 Jul 2025 21:55:25 -0700
Message-ID: <20250722045527.1164751-5-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250722045527.1164751-1-pierrick.bouvier@linaro.org>
References: <20250722045527.1164751-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x534.google.com
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

usage: timestamp-based-on-real-time=[on|off]

Instead of using number of instructions executed (which is per vcpu), we
use the wall time for timestamps. This is useful when tracing user mode
programs as well.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 contrib/plugins/uftrace.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/contrib/plugins/uftrace.c b/contrib/plugins/uftrace.c
index bd4219db693..9211f273700 100644
--- a/contrib/plugins/uftrace.c
+++ b/contrib/plugins/uftrace.c
@@ -94,8 +94,28 @@ enum uftrace_record_type {
 static struct qemu_plugin_scoreboard *score;
 static uint64_t trace_sample;
 static bool trace_privilege_level;
+static bool timestamp_based_on_real_time;
 static CpuOps arch_ops;
 
+static uint64_t gettime_ns(void)
+{
+#ifdef _WIN32
+    /*
+     * On Windows, timespec_get is available only with UCRT, but not with
+     * MinGW64 environment. Simplify by using only gettimeofday on this
+     * platform.
+     */
+    struct timeval tv;
+    gettimeofday(&tv, NULL);
+    uint64_t now_ns = tv.tv_sec * 1000 * 1000 * 1000 + tv.tv_usec * 1000;
+#else
+    struct timespec ts;
+    timespec_get(&ts, TIME_UTC);
+    uint64_t now_ns = ts.tv_sec * 1000 * 1000 * 1000 + ts.tv_nsec;
+#endif
+    return now_ns;
+}
+
 static void uftrace_write_map(bool system_emulation)
 {
     const char *path = "./uftrace.data/sid-0.map";
@@ -454,6 +474,9 @@ static void cpu_set_new_sample(Cpu *cpu, uint64_t timestamp)
 
 static uint64_t cpu_get_timestamp(const Cpu *cpu)
 {
+    if (timestamp_based_on_real_time) {
+        return gettime_ns();
+    }
     return cpu->insn_count;
 }
 
@@ -866,6 +889,12 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
                 fprintf(stderr, "boolean argument parsing failed: %s\n", opt);
                 return -1;
             }
+        } else if (g_strcmp0(tokens[0], "timestamp-based-on-real-time") == 0) {
+            if (!qemu_plugin_bool_parse(tokens[0], tokens[1],
+                                        &timestamp_based_on_real_time)) {
+                fprintf(stderr, "boolean argument parsing failed: %s\n", opt);
+                return -1;
+            }
         } else {
             fprintf(stderr, "option parsing failed: %s\n", opt);
             return -1;
-- 
2.47.2


