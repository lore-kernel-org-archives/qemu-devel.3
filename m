Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23167E77188
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2025 11:47:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXfOC-0004N4-BU; Tue, 14 Jan 2025 06:47:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tXfNt-0004LM-FE
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 06:47:05 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tXfNr-0006f6-Oh
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 06:47:01 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-437a92d7b96so6034545e9.2
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2025 03:46:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736855217; x=1737460017; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kTnA9glybPs3zdhSbJS9OZOTx27Sx361JrQqUOFibUA=;
 b=bp2hQfHNSu9R7aAhZRUQAToOA4QVoltDXT40U6zVb0rfGthcYocLQ4slT4NHQluvkQ
 PSdUa5bvao3DS3N861oz+YtoLNc7Mfxc4OUFJH4wDtvoJ+iU2sErfl7rPBm1nDBs8GdY
 amr+p6nbEDEImpU4kYi5RU1xeBz3nUwqd2zZT0n2XkNzFGL5GZBMLJQ9bfX/7xEeaybW
 VnFKJXoecaI2/Dmu4A6scduCaQ/OtbrwwCcGsdMylq99X6WMSMcAx6R1SiPVl8FIA+kd
 aett5ww4yHePFpBLngOBUKbPLnTjbMHqFGXaT9YeH9HTZ+PoeBzv2IBhLDb/sBGOcsW0
 PHFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736855217; x=1737460017;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kTnA9glybPs3zdhSbJS9OZOTx27Sx361JrQqUOFibUA=;
 b=w8KpHEqwaGrRaAw3wXopmMi5CWN8WIMBc5xB7LPA2NPPJjzrkuHqpbByR8cCvt4tyg
 +ECxuposhTzWUyg9Rprsb7GBmu5DLRr1yIaxm7V98Z4XEJYW6qzjNhTyVSUpYL8U/NU1
 xAffiA6ylYgl4wrS8AwAgqErAvXZkNCgkXqXaWCw+lrdX0jdOyeB4VhgeyHKFxa9T/g9
 a8Wk90IWyZMI8kUeMSG06oz3bHS+uaa3yAbYoav16xHo+gVHVyhhXXDUHqfscwBeaN9v
 q2ibRLONYAtyHL07OyX2hmEltUHF00J/uQNTqOy6BJ62FwELDaU5NX4Di3IWMhr3O2nU
 QNMQ==
X-Gm-Message-State: AOJu0YyR9ALrszz9FHA10azhr3XciNw6u9MzHwJRWeb0vodnG5WNkPmd
 pttbksfPi33yZDTvw8oRaAEose3slXHY4cGuE+A4myNoMiDJsd8R2oWCXd5XN7s=
X-Gm-Gg: ASbGncukFuxa7WTtB+JQY/Htscx9ovuVJlSK9epDYLIGPkIHKecyCNKJdygiNKlMpft
 wzV7M0dNwLwqMPinsJY8fNSeO2mhCnHUXJJJPhOobhlZfkWVRJCkvPQBk7gHcajm8gY6dfHU4WB
 m48dED2R715dnr+dD4DZbEGz3lK8l7OasTKM9bR0iSFuHwgMVGDGniNWUctOt9ejbg6oL69U6I6
 ppCLCDPrG3bGmB/EZBTZ7KWYWr/9DL0rRdJ3R6xpcsQbpHgPhgLHdw=
X-Google-Smtp-Source: AGHT+IHSUNDh+GcBAAqkL4FkfAxGcBR98ti9n55moS+xcyX7hdsWEPj36o81KOF67pT+FGGYiXXm8Q==
X-Received: by 2002:a05:600c:46d0:b0:431:58cd:b259 with SMTP id
 5b1f17b1804b1-436e26f4d53mr225863455e9.31.1736855216938; 
 Tue, 14 Jan 2025 03:46:56 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436e9d8fd03sm177334135e9.6.2025.01.14.03.46.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jan 2025 03:46:52 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 89ACA5F932;
 Tue, 14 Jan 2025 11:38:23 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefan Weil <sw@weilnetz.de>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: [PATCH v2 19/37] contrib/plugins/hwprofile: fix 32-bit build
Date: Tue, 14 Jan 2025 11:38:03 +0000
Message-Id: <20250114113821.768750-20-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250114113821.768750-1-alex.bennee@linaro.org>
References: <20250114113821.768750-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32b.google.com
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-Id: <20241217224306.2900490-10-pierrick.bouvier@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 contrib/plugins/hwprofile.c | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/contrib/plugins/hwprofile.c b/contrib/plugins/hwprofile.c
index 739ac0c66b..2a4cbc47d4 100644
--- a/contrib/plugins/hwprofile.c
+++ b/contrib/plugins/hwprofile.c
@@ -43,6 +43,8 @@ typedef struct {
 
 static GMutex lock;
 static GHashTable *devices;
+static struct qemu_plugin_scoreboard *source_pc_scoreboard;
+static qemu_plugin_u64 source_pc;
 
 /* track the access pattern to a piece of HW */
 static bool pattern;
@@ -159,7 +161,7 @@ static DeviceCounts *new_count(const char *name, uint64_t base)
     count->name = name;
     count->base = base;
     if (pattern || source) {
-        count->detail = g_hash_table_new(NULL, NULL);
+        count->detail = g_hash_table_new(g_int64_hash, g_int64_equal);
     }
     g_hash_table_insert(devices, (gpointer) name, count);
     return count;
@@ -169,7 +171,7 @@ static IOLocationCounts *new_location(GHashTable *table, uint64_t off_or_pc)
 {
     IOLocationCounts *loc = g_new0(IOLocationCounts, 1);
     loc->off_or_pc = off_or_pc;
-    g_hash_table_insert(table, (gpointer) off_or_pc, loc);
+    g_hash_table_insert(table, &loc->off_or_pc, loc);
     return loc;
 }
 
@@ -224,12 +226,12 @@ static void vcpu_haddr(unsigned int cpu_index, qemu_plugin_meminfo_t meminfo,
 
         /* either track offsets or source of access */
         if (source) {
-            off = (uint64_t) udata;
+            off = qemu_plugin_u64_get(source_pc, cpu_index);
         }
 
         if (pattern || source) {
             IOLocationCounts *io_count = g_hash_table_lookup(counts->detail,
-                                                             (gpointer) off);
+                                                             &off);
             if (!io_count) {
                 io_count = new_location(counts->detail, off);
             }
@@ -247,10 +249,14 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
 
     for (i = 0; i < n; i++) {
         struct qemu_plugin_insn *insn = qemu_plugin_tb_get_insn(tb, i);
-        gpointer udata = (gpointer) (source ? qemu_plugin_insn_vaddr(insn) : 0);
+        if (source) {
+            uint64_t pc = qemu_plugin_insn_vaddr(insn);
+            qemu_plugin_register_vcpu_mem_inline_per_vcpu(
+                    insn, rw, QEMU_PLUGIN_INLINE_STORE_U64,
+                    source_pc, pc);
+        }
         qemu_plugin_register_vcpu_mem_cb(insn, vcpu_haddr,
-                                         QEMU_PLUGIN_CB_NO_REGS,
-                                         rw, udata);
+                                         QEMU_PLUGIN_CB_NO_REGS, rw, NULL);
     }
 }
 
@@ -306,10 +312,9 @@ int qemu_plugin_install(qemu_plugin_id_t id, const qemu_info_t *info,
         return -1;
     }
 
-    /* Just warn about overflow */
-    if (info->system.smp_vcpus > 64 ||
-        info->system.max_vcpus > 64) {
-        fprintf(stderr, "hwprofile: can only track up to 64 CPUs\n");
+    if (source) {
+        source_pc_scoreboard = qemu_plugin_scoreboard_new(sizeof(uint64_t));
+        source_pc = qemu_plugin_scoreboard_u64(source_pc_scoreboard);
     }
 
     plugin_init();
-- 
2.39.5


