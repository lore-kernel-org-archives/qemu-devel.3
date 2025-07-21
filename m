Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14F59C83F26
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 19:36:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udwIX-0004BW-W0; Mon, 21 Jul 2025 15:35:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1udwGr-0002c6-T2
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 15:34:00 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1udwGp-0003Uo-Qj
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 15:33:57 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-235f9e87f78so43302935ad.2
 for <qemu-devel@nongnu.org>; Mon, 21 Jul 2025 12:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753126434; x=1753731234; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BBOR3bawaV5LsRRquIEasW/Jg5XqUZiqsCVsDF+w8YY=;
 b=aKtSk+0X8+eLZ5ho9FE3Icnscl5pbbxPlW4pHIcGzswxDMSbKPyf4ZFagzNXtJTuXy
 d+wnBo5npguDUyU8/kHz0fwFNA/mc4WrfM9VNF+YJYnZ0RueWNMD0uD2/rfmRuRCC8tD
 5ssnH69Zse82I9mEb7CdUITMdzL2gSWF05Mvw84XOKqTDvMpbe2D4UMNNi6d5SVgeZaF
 HDEpPJHsOO6yXAKHM9Yd1n3zM5tv0OSF/U4lhSBPSY9PcrlsRxZ0ri4TKP1MdA9Oioa9
 F54F1x70rEIDj5jNwCfGeDCHvcefkHKq7msq9zYPAVwvUJtPDXDqXOaZzKfOqd8CGEVe
 7kCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753126434; x=1753731234;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BBOR3bawaV5LsRRquIEasW/Jg5XqUZiqsCVsDF+w8YY=;
 b=Fm3KuvhPmWHYfcOy59Tw2D9itUnaVa9+/i1ZN+gwxS27/dPmWGpq90ZTgZiOHhFzJQ
 BCCgZ1KdzbZ7zSfpEhkJxbdpToSDtWg71QWxHGdkEY2LpO1vvpIY3a3/iIjnHpvJJl3K
 weM4XkN+mv7uOdFQzPlm4dmULYmNfy/ZavXb6t3ahosLj4DI2XaF4SxtoHMY1jrmE/uu
 CFe0VXVlvlVcn1wdd/5Aq9p2K0DBeLoB+53VCMnb4QUXiR7l4xIO8fLObm2oe8F9sVuL
 JT4qT15BAoU9ZQ+BYI6PS+UiiQ5x2/4eBMHQvejqIMJt9ej+59SIPiJ5lkp5EV3QdolH
 voOw==
X-Gm-Message-State: AOJu0YyS5XBTwjD74r2yi4kyjWpcRowkVoEvQGXBhEgwDA8pxfi3+idG
 uRWdxPE287/C8+YZh0TLRuCuZf03UOe7cJHyIVPvtGtRSU60XUAmb3G4Yw4ZNcqF0BnAR97eLJH
 zoPkQ
X-Gm-Gg: ASbGncutum2Nhc6iaPeQScruInnXLBvy5VKQT+VwY0VuTSmT6d8CoXy9JRZtQ6fdYYN
 MhLC4XU6728VfkjakV56cNk3dstlLAVz+etP06v+lUrEkpe6l7P42OZIGGOBbv3+XrWRO0hcl4a
 UtSIc9j5ImGHdd5CsBWN0HfVH/rMNlUGz+lUoZdazdmV/D3WQxiHpGJ3Bo6cZ9+S/lMag8yEkQB
 zR1nxyCj2Db67hggCFmusyEVXh63YR2VGnwUDM71DJh4g3IUlC2ocx4rjDb9CHR5BwXwax8OolF
 hOeMZ+tOrp3DtSMdp4Cm7p16fZv2piPu//r3KV4HB7Xwx+okc6ffha+LOItSjGo+kKiztEryP+l
 zVorvId1iP4KhGVWCx2J0Cw==
X-Google-Smtp-Source: AGHT+IFGq14liDmmWxsUqf8oZE2YiHYUpdBbMGcsXsgTqCJppiCXqBw0f2d1eGlVxIeDi0LG7TjC8g==
X-Received: by 2002:a17:903:faf:b0:235:799:eca5 with SMTP id
 d9443c01a7336-23e2576e67cmr318939825ad.44.1753126434521; 
 Mon, 21 Jul 2025 12:33:54 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23e3b5e4750sm62238685ad.6.2025.07.21.12.33.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Jul 2025 12:33:54 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, rowan Hart <rowanbhart@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: [PATCH v2 4/6] contrib/plugins/uftrace: add
 timestamp-based-on-real-time option
Date: Mon, 21 Jul 2025 12:33:38 -0700
Message-ID: <20250721193340.1059019-5-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250721193340.1059019-1-pierrick.bouvier@linaro.org>
References: <20250721193340.1059019-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62e.google.com
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
index ff4dcb4e9bf..6709b38918e 100644
--- a/contrib/plugins/uftrace.c
+++ b/contrib/plugins/uftrace.c
@@ -93,8 +93,28 @@ enum uftrace_record_type {
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
@@ -453,6 +473,9 @@ static void cpu_set_new_sample(Cpu *cpu, uint64_t timestamp)
 
 static uint64_t cpu_get_timestamp(const Cpu *cpu)
 {
+    if (timestamp_based_on_real_time) {
+        return gettime_ns();
+    }
     return cpu->insn_count;
 }
 
@@ -865,6 +888,12 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
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


