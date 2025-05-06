Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3C5FC3ABAC
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 14:37:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCJOH-0006QL-3h; Tue, 06 May 2025 10:35:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uCJOF-0006Nb-FP
 for qemu-devel@nongnu.org; Tue, 06 May 2025 10:35:23 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uCJOD-000122-80
 for qemu-devel@nongnu.org; Tue, 06 May 2025 10:35:22 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43d0359b1fcso36125135e9.0
 for <qemu-devel@nongnu.org>; Tue, 06 May 2025 07:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746542118; x=1747146918; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7fk0+zfQPUjhKJZd4fHUCreFdVkC6Nw3uJmVrWhWzRI=;
 b=jTxYmF8jIUb2GdsQJNxGKhG2qGp5wE6WLdJxDnt0ytXKkOSudoDMwxjLbEAD/yeUzw
 f7tMZtp5TBYTmcM34IbjnoNXmJRF1XFaycjrt7R44a6NKWl4+pZ8B5aGBp04Pw4tBI3L
 oMNAiAX4jdBGDtOh0KZDlA+53NCR0g73VQzlNaJgvPseBCGm7FmdWZGtPPCi1qNgFlWD
 8BjNvyVowQG8k5uAD2KV8kzf/XcUcZCZds5pT6+gyUdCDfi03sPpEZ42+yd4ruPexSvS
 TPbs4V+tPh9u+fCQml0pK/PajCAPc7XzvHt7TK7dxZDWcDD/0mla5mQQCFb/vd1KODI6
 Pm2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746542118; x=1747146918;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7fk0+zfQPUjhKJZd4fHUCreFdVkC6Nw3uJmVrWhWzRI=;
 b=M9vQW6yKBtMw6M2p125ce5xg0hW7T3L9jGuGZPTmfTrlak2aq+jecmYo4oMKE75D8d
 WREw+2hT1fDMBjTgDJO3IKTWpjjOzvLqYyiFHDEvG6IR27E1hcLwg8emasU8zxk7dYkR
 1gcPvI6YwCNCyCHNYKnNcqem59kG4J+KcrnBkJdVPKp1W5dZ//WqnI72hJ+KNauOcEDg
 wiUCTdgU0t2k/PmePaK6Oh+8Js6e0C3a7d40ax/tSjPETHofIJXS2L8fgscOhklF8FLf
 9QiMaljUCp6P2wJ2wiZeBLi8LFULF6MMkEVoG+MVzsoUVtmTmV33c80ril//Vs8qVsjB
 bHlQ==
X-Gm-Message-State: AOJu0YwuCcicnl6jFhG6G17vi0oMQZ5Abc9u004Td29O9Aexgz6YJrx1
 scp6dGuPvM4Q+ZgrRsStett5fiKds1hySIWykPLU5OLnC67oC8FMKVU/YqrU9t1Qb2Hjbj3uzci
 H
X-Gm-Gg: ASbGncvgZ4oAuGjmKFV5V+tcONOHMsNfu7N7624uqai2CIw2Y2bHhLTu9g5NQQ/oMsh
 PNuWukXL8/PwiPHLLHiWq6aVkYIxNaFCK9rU5zAvs6sY683SAgs84k65k2EHYvta6QiXkbPmf21
 xQA80zdkrdTP/dFQDt5m4b0UdNS0QuvSyet927Tq0q05Gpk9xQSDr/yKNVs6GwUEHRPRvSKLKvS
 6HdcmCZBGeBKiMqNEFDkvH/A9zGpcCVdD/4jJ2spQ7460Bm0W6Nr0Ze+FcKWhvXb8YQneaFUTua
 a7JYxMhNKyC/AR7j9V3Bno0hIrCBXMBoF7tHms1kzrke5AAGdAvcP0eEL4KN7A3NhYH+d1ToU4y
 OC1fZPt4DuQCTLXkzfDUW
X-Google-Smtp-Source: AGHT+IEzIwaQnMopyBzsoc+6NRSMSouI+uLIwGcL4kmv/ZiX1YqrLzUrAZfkKbM6JIy3WV0yKrJp6Q==
X-Received: by 2002:a05:600c:c059:10b0:43c:f509:2bbf with SMTP id
 5b1f17b1804b1-441d0105d86mr21202865e9.15.1746542118116; 
 Tue, 06 May 2025 07:35:18 -0700 (PDT)
Received: from localhost.localdomain (91-163-26-170.subs.proxad.net.
 [91.163.26.170]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-441b89d1636sm171373065e9.13.2025.05.06.07.35.17
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 06 May 2025 07:35:17 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 01/22] bsd-user: add option to enable plugins
Date: Tue,  6 May 2025 16:34:50 +0200
Message-ID: <20250506143512.4315-2-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250506143512.4315-1-philmd@linaro.org>
References: <20250506143512.4315-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Nothing prevent plugins to be enabled on this platform for user
binaries, only the option in the driver is missing.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20250331234228.3475706-1-pierrick.bouvier@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 bsd-user/main.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/bsd-user/main.c b/bsd-user/main.c
index fdb160bed0f..329bd1acc02 100644
--- a/bsd-user/main.c
+++ b/bsd-user/main.c
@@ -175,6 +175,9 @@ static void usage(void)
            "-strace           log system calls\n"
            "-trace            [[enable=]<pattern>][,events=<file>][,file=<file>]\n"
            "                  specify tracing options\n"
+#ifdef CONFIG_PLUGIN
+           "-plugin           [file=]<file>[,<argname>=<argvalue>]\n"
+#endif
            "\n"
            "Environment variables:\n"
            "QEMU_STRACE       Print system calls and arguments similar to the\n"
@@ -225,6 +228,8 @@ static void init_task_state(TaskState *ts)
     };
 }
 
+static QemuPluginList plugins = QTAILQ_HEAD_INITIALIZER(plugins);
+
 void gemu_log(const char *fmt, ...)
 {
     va_list ap;
@@ -307,6 +312,7 @@ int main(int argc, char **argv)
     cpu_model = NULL;
 
     qemu_add_opts(&qemu_trace_opts);
+    qemu_plugin_add_opts();
 
     optind = 1;
     for (;;) {
@@ -399,6 +405,11 @@ int main(int argc, char **argv)
             do_strace = 1;
         } else if (!strcmp(r, "trace")) {
             trace_opt_parse(optarg);
+#ifdef CONFIG_PLUGIN
+        } else if (!strcmp(r, "plugin")) {
+            r = argv[optind++];
+            qemu_plugin_opt_parse(r, &plugins);
+#endif
         } else if (!strcmp(r, "0")) {
             argv0 = argv[optind++];
         } else {
@@ -433,6 +444,7 @@ int main(int argc, char **argv)
         exit(1);
     }
     trace_init_file();
+    qemu_plugin_load_list(&plugins, &error_fatal);
 
     /* Zero out regs */
     memset(regs, 0, sizeof(struct target_pt_regs));
-- 
2.47.1


