Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 513B8C02183
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 13:53:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYmm1-0002Vn-05; Fri, 17 Jan 2025 08:52:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tYmlw-0002Uw-9w
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 08:52:29 -0500
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tYmls-0003lO-Ip
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 08:52:28 -0500
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5d3cf094768so3717321a12.0
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 05:52:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737121942; x=1737726742; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JBfBDXCVyBtlkqh3uo0WHdnPDpdgRN/7dgUNkr6m4ig=;
 b=oYdEr0tLeIXa35+ulMDHAwtOtYBuxz7WiPOoENlZgAARDbkyQ9mhCcLvKVq+D4NNcA
 /VSFbYKrV20DLqr7pov4e4n8hRcaqnVz9VtnY9fWU7OeFp5hZfot0mNKkKDALFFLAkig
 302H4JK6nJMfuETnnJ/IVKVT719SEM/BKxIrkB0FRLV7zJeDLyjPkXlwAxpyH0tJ6o3e
 HQiFG8oKBJ1gstEHNhPLwyAd5jFzdAV6ZnKbVq0xGM+3Itb/oT/RFAW/Klt5GcBODpq/
 SNONLIqebBq2fTz+A74cZmg/lXyKu5Ds+IS1R7yADdulGPpuNR5GrlR9jssx7XH2QmdT
 29LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737121942; x=1737726742;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JBfBDXCVyBtlkqh3uo0WHdnPDpdgRN/7dgUNkr6m4ig=;
 b=Zy6BywZ4dCgdTq9/Xh7qaYYLRlDYOYqFMaBFk57mkQZuDUmxGm0SNL8iBMLKfCj8FQ
 SwGZPKcyroJr0dVV1aF0RDJoCVaYs6Vt66ucJ5tXyhbJkjstWf54nUMKsQBqjt+B/pYF
 FcGA4U+NzdLJR3ND2S8cgj1FBB234RQKWk6SbD+RhrC59S7ObSol++FVOVehb05t76r8
 FyYuAy79cXcbq8gWe8sUU1UMQ1qEBuLE4tBx0CmRNtwoeNfw808clU9iRA3cPxCPTFX9
 QSXrC9QeQcEScqAoSWUhQsB5AuedWtClSVPnPDzFeCFgKCngs5S0pEPT3GMMDlcE3eoE
 AkFg==
X-Gm-Message-State: AOJu0YzC9hUFPW+zEaREaEKmUwc0fh7ibBeHgpFxLgsZCnmqJSOag22v
 UH2Lw282Aq8rf3+jkFV1amg6oxo4U6hx6ZhEzHhRw0T6MKbaRM5sCFKtfBhOY/E=
X-Gm-Gg: ASbGnct9e/IsrzyEOxDM5VSA50cxD4s2gTwz0tI7y59uWGtS2eXUoewMtZJN1b/pAAK
 Ii3YFH57UxediMVG8FUxesih+GjZlMFHwyyrJTzccCymWE/nhe90RMhkQRzlQ9XOGpvJQ3f3e/g
 v324tyvk6oDUeQMAkKwM6y0CYJlPv7WCz1Se3RZoDv/km1dFYoLNDZqacAVgQXYsmSwWJUgoyE+
 0ULuvKVkRI2xgdyoxXS7hOkYr+wbUwBz3yArZXa8qOT5SNUDpmhXtA=
X-Google-Smtp-Source: AGHT+IE+w31ZcADARboEYhGfhBhF94IenOA5NPWXTkrCLoYjWsiIZWCk01l9C0XQpdim+MeRoJKw6Q==
X-Received: by 2002:a05:6402:2695:b0:5da:d16:7378 with SMTP id
 4fb4d7f45d1cf-5db7d8271b8mr2176781a12.21.1737121942008; 
 Fri, 17 Jan 2025 05:52:22 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5db7364272esm1484346a12.12.2025.01.17.05.52.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2025 05:52:19 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id AFCA1608C3;
 Fri, 17 Jan 2025 13:42:58 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: [PULL 19/37] contrib/plugins/hwprofile: fix 32-bit build
Date: Fri, 17 Jan 2025 13:42:38 +0000
Message-Id: <20250117134256.2079356-20-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250117134256.2079356-1-alex.bennee@linaro.org>
References: <20250117134256.2079356-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52f.google.com
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
Message-Id: <20250116160306.1709518-20-alex.bennee@linaro.org>

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


