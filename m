Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9592C369D5
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 13:01:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9O59-00080w-6q; Mon, 28 Apr 2025 08:59:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1u9O52-0007tc-AX
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 08:59:30 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1u9O4y-00036q-28
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 08:59:27 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-ac2aeada833so927775566b.0
 for <qemu-devel@nongnu.org>; Mon, 28 Apr 2025 05:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745845162; x=1746449962; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OpcnbbS7NZaVAROUGSORdG952tVH4km68aGL3qTrH6E=;
 b=b08SX4nxgTdy0psISi+SAexoeWfKko/2u93q4wCGJqfMJXUERMF4PYZ60pH5LhjrC+
 gybFPF9H3BVGQwp3Qo08g4u1d0SBdHx7u0okknKLNwkzRy+sb/0pCsJUjNmPgQL8hxVY
 KDzKcSXeLSaNWO5o2I0gxH3TXOJn+RRkJIvHhA5zkpkMj38Bc3JZzQG9aPs+hNaxVoNt
 TWfOknUKs7/aDVR/DI2R9pZKlpQGbzrILUk8o+CGdbvNxpM0pmdJrv0NJpqVn50cILlr
 /N9QlrwYGAKVU6qpD9TrM2cIx7POFCvvE3UhMh7FVsa5eWlUCu7HgT3h6OQ5irSoTJ8P
 a75w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745845162; x=1746449962;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OpcnbbS7NZaVAROUGSORdG952tVH4km68aGL3qTrH6E=;
 b=i9EoQfIPKDvqcpZWdmDY3FxBRdxRiArLJ4h4Ih/JHS7TIspg0oRzepArAkRm76edq0
 auYPRq9+BSl4J4cI1lZSNvggXbnLB3YKCKNAW1rua+6awajW96jXMfX/IXMDJZTnVDP2
 dJ5HCgsJ/FRcAeQNvhQrkyQiahtdtidyY7qFEib2EmKWXLS5UNwqJlKRbDj+Xyl6P++3
 WoysLN27YTb8T6Lp6RgSAkFG/ze/CcVqpvU9zW1DY7w+Wd6mE1bjHmHFh7u/7+qNODzX
 ffDbzIYexF87LowxB5F1wE0dwAQDvswgMnn4YnyvgruW2sewWV0T9W2wsSvaDgBAylkW
 5HOg==
X-Gm-Message-State: AOJu0YzVLXbiEaxvizpNcdiL19OJj9JJJgEim93mH6NSDg8vODNSt41Z
 skkYqqZgwFCHIu2+DZcxe6PHly8C3ec2/ZpxBNpy7edjY1uaSIxvo6Y37wYQtU0=
X-Gm-Gg: ASbGncvHodIvLfi2cPGXxYIlXrUkxk+6rAgOeL/PSbB2E8ifFkxdejn5syOwriN8wG4
 BpUT3LxJEFsc0UmiBPXL1eWBMv4adOpaia32OCxsGuxUyOi1TAT5cidDKuVgwvjQiwx5pepX7ue
 rU8AIIC+ox4/U3dsarnC4uRxjNze6Yee9helq6mLxBNp6nAFLKby7sFASXDkL9ICB7+DO5nr+qQ
 7HP/AK+esECLxD4XE4Y0OjCA4Whorr2QZ/iDYRT9jrELzdx/tBhBbth3BzkR0gGmsQBlxT1bjZ6
 JUrsxnz1vmvlmTv4b6GQ3ybfmhnMUI52fdpFVBVsGec=
X-Google-Smtp-Source: AGHT+IFA+vcJn5ICuqxtYAOvoGPN0+KQnqHYxJ8bIDhjpjRprm0RjxiDAccIJ73FlzewTYkrcdZYAw==
X-Received: by 2002:a17:907:9804:b0:aca:d276:fa5 with SMTP id
 a640c23a62f3a-ace73167e83mr1087497466b.0.1745845162449; 
 Mon, 28 Apr 2025 05:59:22 -0700 (PDT)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ace6ed70611sm627048766b.143.2025.04.28.05.59.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Apr 2025 05:59:20 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 9B2F45FAEC;
 Mon, 28 Apr 2025 13:59:18 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 David Hildenbrand <david@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: [PATCH 4/9] contrib/plugins: add a scaling factor to the ips arg
Date: Mon, 28 Apr 2025 13:59:13 +0100
Message-Id: <20250428125918.449346-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250428125918.449346-1-alex.bennee@linaro.org>
References: <20250428125918.449346-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62d.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

It's easy to get lost in zeros while setting the numbers of
instructions per second. Add a scaling suffix to make things simpler.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 contrib/plugins/ips.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/contrib/plugins/ips.c b/contrib/plugins/ips.c
index e5297dbb01..1952e0866d 100644
--- a/contrib/plugins/ips.c
+++ b/contrib/plugins/ips.c
@@ -20,6 +20,8 @@
 
 QEMU_PLUGIN_EXPORT int qemu_plugin_version = QEMU_PLUGIN_VERSION;
 
+#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
+
 /* how many times do we update time per sec */
 #define NUM_TIME_UPDATE_PER_SEC 10
 #define NSEC_IN_ONE_SEC (1000 * 1000 * 1000)
@@ -129,6 +131,18 @@ static void plugin_exit(qemu_plugin_id_t id, void *udata)
     qemu_plugin_scoreboard_free(vcpus);
 }
 
+typedef struct {
+    const char* suffix;
+    unsigned long multipler;
+} scale_entry;
+
+/* a bit like units.h but not binary */
+static scale_entry scales[] = {
+    { "khz", 1000 },
+    { "mhz", 1000 * 1000 },
+    { "ghz", 1000 * 1000 * 1000 },
+};
+
 QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
                                            const qemu_info_t *info, int argc,
                                            char **argv)
@@ -137,12 +151,19 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
         char *opt = argv[i];
         g_auto(GStrv) tokens = g_strsplit(opt, "=", 2);
         if (g_strcmp0(tokens[0], "ips") == 0) {
-            max_insn_per_second = g_ascii_strtoull(tokens[1], NULL, 10);
+            char *endptr = NULL;
+            max_insn_per_second = g_ascii_strtoull(tokens[1], &endptr, 10);
             if (!max_insn_per_second && errno) {
                 fprintf(stderr, "%s: couldn't parse %s (%s)\n",
                         __func__, tokens[1], g_strerror(errno));
                 return -1;
             }
+            for (int j = 0; j < ARRAY_SIZE(scales); j++) {
+                if (g_str_has_suffix(endptr, scales[j].suffix)) {
+                        max_insn_per_second *= scales[j].multipler;
+                        break;
+                }
+            }
         } else {
             fprintf(stderr, "option parsing failed: %s\n", opt);
             return -1;
-- 
2.39.5


