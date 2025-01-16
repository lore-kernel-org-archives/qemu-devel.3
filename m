Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1620C02188
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 16:14:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYSUU-0004RL-4z; Thu, 16 Jan 2025 11:13:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tYSTi-0003Vt-PF
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 11:12:19 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tYSTd-0004SH-KM
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 11:12:18 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-38633b5dbcfso1245666f8f.2
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2025 08:12:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737043932; x=1737648732; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kTnA9glybPs3zdhSbJS9OZOTx27Sx361JrQqUOFibUA=;
 b=GrMyWh77BuK5ZnWghuQ68UwzBMwX0pOX2WYvCuniuLvWXAlAlEQs1GibfRv5JV5gAT
 gricQFT/oJIedGBlCcJcdjqL+kgtID82ndbbLBBYipj4fuwsEcfzD679FCFsqr+aaNig
 j0Z7L6fcrUZtB9DRQlG3JkyWmJ2nvFo4PoRVd3UGN/1BjCxGM6LPdj5uCDh/hRlXvuF/
 oKXndqG6Xy3xw6QZg9ABrXdW+H9gdbbC2/EAR9WvK1WcYIirEv0+dBakk+Lc95wFPmN5
 v/XozvEraeBg91tLJLl2W11jEy5dDOnEB5S5E2vF176BcCeHoLMteeKr17S0rRmsDyov
 mJug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737043932; x=1737648732;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kTnA9glybPs3zdhSbJS9OZOTx27Sx361JrQqUOFibUA=;
 b=HclcsZaTIzRMKyPlbGP1EnZFNMxFsaw06jOioGrISISoiOfzoGdmGbj1dqriq/8iMS
 1mDGeHn+AkiJbawjOaZl1vxnM7r8PtRnxSRk9pNv3sF1wIXVh9qjVoyxVXjtxbI9aYVF
 fvq17YKjRGg9XwWtubEN9dBHbPlKik/j+0QhAXyvyoWgavf28L3xjPzHeU9YS5M55gNf
 /VN7shEQmdoDyZY89UrBGIfrAMVsdj+oIXIzopJmAJV5GsS5DdBO2M1RGgJs+u6ggOlu
 zq/PU1ErPQRZGvBIhuJkzCPGl8EwzoorndJP5BEY3/er0B8HUVU5jdkoGKxOUjrz9zNP
 lLVw==
X-Gm-Message-State: AOJu0YxzD+Qg9dJWTr0QsYnT1L/Fp8J4Ur/C8Q81TalAQDm9aGGfTD14
 QzHzJqRuVzSaCm0KbJtUuiJX/5RkerXpK6IhrubUVapMnbsS5Cn/A4Jw20w38P8=
X-Gm-Gg: ASbGncsCqR9Sv/eiOta7sPOhXso5MBkJGY11tD7NByucVJjJa2xPIlVRqjp7dsbCm1O
 ulFlj4F16z6a4+tYKMXi3NFsfr95Eq72JbYy4pTJoIYxVvGyuUEeVquKkHy0c1qLWs10z4+q4w3
 i31oz90GfRg1/rq20Y/Rcrkt2J/jOhMjMNRAIEcjyjskIEWPDsTcr0B7Ulg0y+b2gKkpd5SijbG
 GDmCkQz0fg8l2ytIwN5JxjEGe1lYNViq32t2NQ48QnuSl2SlWQY0YE=
X-Google-Smtp-Source: AGHT+IGvtjX2xsiveTduwOnA0JLVAZWs/Xv9QW0KwwvS0uANAGT5sCVzNb0nZ+RlpmfU5Cvp4SHb0A==
X-Received: by 2002:a5d:59ab:0:b0:385:eb7c:5d0f with SMTP id
 ffacd0b85a97d-38a8730db6cmr30348488f8f.26.1737043931956; 
 Thu, 16 Jan 2025 08:12:11 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38bf3275995sm221666f8f.74.2025.01.16.08.12.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jan 2025 08:12:11 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 511FE608B7;
 Thu, 16 Jan 2025 16:03:08 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 Jason Wang <jasowang@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefan Weil <sw@weilnetz.de>, Stefano Garzarella <sgarzare@redhat.com>,
 qemu-arm@nongnu.org, Michael Roth <michael.roth@amd.com>,
 Laurent Vivier <laurent@vivier.eu>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 Konstantin Kostiuk <kkostiuk@redhat.com>, Kyle Evans <kevans@freebsd.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>, David Hildenbrand <david@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Alexandre Iooss <erdnaxe@crans.org>,
 Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Warner Losh <imp@bsdimp.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v3 19/37] contrib/plugins/hwprofile: fix 32-bit build
Date: Thu, 16 Jan 2025 16:02:48 +0000
Message-Id: <20250116160306.1709518-20-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250116160306.1709518-1-alex.bennee@linaro.org>
References: <20250116160306.1709518-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x431.google.com
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


