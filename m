Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E16DFE77184
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 22:45:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNgHm-0004NN-Iz; Tue, 17 Dec 2024 17:43:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tNgHj-0004Ls-In
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 17:43:23 -0500
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tNgHg-0001Ap-Io
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 17:43:23 -0500
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-728ea1e0bdbso4575847b3a.0
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2024 14:43:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734475399; x=1735080199; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Rw327xVdkany76CVhD99+3VcZY22zDM8k532HNs8NjQ=;
 b=sACk+fdIJD3tCbI1JA8tK8/Ur0x+MvfyypoCURus24y10/wgEAXYK/dqMtMxo2m0vs
 /BqD2r46E8ydMkypLwwHlgHSPSaOH7rfQsWSINZEei+x8RIryLaNvBxQWRksDTNulb83
 zXXtPx4fSkInSSxtorr6gYYFJB/7TFvjRoXbGa6VVTRMRFTjDgsUp3Y+WBw2m/iRvDrg
 Dv9q9u6GbqiNwTJ4e/MTQF6GfQQ0l4F2guTh4pcK5/p5EEtocKOXScIGEk9AXZKOeRaQ
 sqoaOw+axbz98isnHwCevTwA7OzusdQfAibCZJCcnjMt0NQ70ZE4+GqKd2fspDUWnbWy
 aj6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734475399; x=1735080199;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Rw327xVdkany76CVhD99+3VcZY22zDM8k532HNs8NjQ=;
 b=Fabu5T0TnQeevEFiUWf19LfkkIF1evzAZ2IGWsJNr0NCnUV91SBza9CSMc9hYEnu3T
 FmpbDaxMvA6ukaAlsjTWT52mVuDvXmVjUF8Tae+x03VaAOpmy9/6wX7mlnswXoxuWxQJ
 vwYJVHHCIKmJRtb4fyFXmTYFteIQVeFhkqAdqSMUVQmDr16RCi3ufUJgASSiWZyiaEqf
 HHH0RvVKJlO8A3OpAZDRUiO5SyIy4eNypU6m4Ro2H3ARd3owPP6ubiOnVmwfZF1c2+Mk
 4m61E28j5O625b59+jT3Dgf9PapOPCXpg+ep65BhCMewCRDZKCDxEbrCYOjY9OyA6ePu
 Ysrg==
X-Gm-Message-State: AOJu0YyQkrhWB3SfMm7FAQ17beaGUYpddX1wyKQNg13o7INssoKD/MVf
 GdVtzRofZVVzz2oKZDKqCFzJVWXz3RAmTW/KjREU7xMzPKRROXu3YR0elctvPHsrPGByyYfE6JT
 e6kk=
X-Gm-Gg: ASbGnctS/+53ehHrPpoEs0FbKkgG5QUKvdPpCdKCrUIRyoLx55IsQYHiNJZaergk+fd
 WcvV7IJMWNGaFmAkOY67b4is87aCZOnHi4v9VrQpJ3lbqVY5hBjNPMhBulf0aa00c8u5pI+2ksh
 bexb0rQLeeJ4UVWv0so0LNmYLz6+wJWp98fO/WFf3STZBxZ8J7eJo2TZUXQS/TQy9YB//0dGfX8
 1l1czX0Wtm5CD69hDL0u4IrqiQLPfCtAanjUK1jyCmCLFaPw+rE1Rb7
X-Google-Smtp-Source: AGHT+IGvulE8p89xg5rjVFNmDmQpdz8FWCJ+fhfTbUtW69SqDfMXrBulO+W1ETGlPSnGgYJQbe9O0A==
X-Received: by 2002:a05:6a21:1646:b0:1e0:d73b:15e4 with SMTP id
 adf61e73a8af0-1e5b487e05fmr1261600637.29.1734475399007; 
 Tue, 17 Dec 2024 14:43:19 -0800 (PST)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72918ac53f3sm7463214b3a.27.2024.12.17.14.43.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Dec 2024 14:43:18 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, philmd@linaro.org,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Thomas Huth <thuth@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v3 09/11] contrib/plugins/hwprofile: fix 32-bit build
Date: Tue, 17 Dec 2024 14:43:04 -0800
Message-Id: <20241217224306.2900490-10-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241217224306.2900490-1-pierrick.bouvier@linaro.org>
References: <20241217224306.2900490-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42e.google.com
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
 contrib/plugins/hwprofile.c | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/contrib/plugins/hwprofile.c b/contrib/plugins/hwprofile.c
index 739ac0c66b5..2a4cbc47d40 100644
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


