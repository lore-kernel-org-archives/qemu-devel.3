Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B42FCC9EC95
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 14:34:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfIzb-0002f5-Im; Mon, 12 Jan 2026 09:34:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frolov@swemel.ru>) id 1vfIzJ-0002cq-U3
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 09:33:47 -0500
Received: from mx.swemel.ru ([95.143.211.150])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frolov@swemel.ru>) id 1vfIzG-0006n3-Tq
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 09:33:45 -0500
From: Dmitry Frolov <frolov@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
 t=1768228416;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=+4Vc8OMcWWcX37Tmnsv38hD9MEh3PyeqecHoWN8Fz1k=;
 b=ZFlzUTnkKr1+rmoJ9plLevLH8+jAYdw9gH2hKZb4SdYVASX3t+BtdiZrEZnXBvRb62czY9
 GibwREXs8hjk4y1WF4hyTPJWAsAXRhsROnabAhCcycV18dipyL8qN1OXc3VW5/I+mLmKl2
 hr7Ove5ajsTGRSxKtR4XyuIlESFUlUo=
To: alex.bennee@linaro.org
Cc: sdl.qemu@linuxtesting.org, qemu-devel@nongnu.org,
 Dmitry Frolov <frolov@swemel.ru>
Subject: [PATCH] fix NULL-dereference after g_strsplit()
Date: Mon, 12 Jan 2026 17:32:09 +0300
Message-Id: <20260112143208.1047235-1-frolov@swemel.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=95.143.211.150; envelope-from=frolov@swemel.ru;
 helo=mx.swemel.ru
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

If there is no delimiter in the parsed sting, then the
second element (eg.: token[1]) in the returned from the
g_strsplit() array will be NULL.

When tokens[1] is passed only to qemu_plugin_bool_parse(),
no additional check is needed - there is an internal check.
Also, there is no need to check tokens and tokens[0] in all
mentionaed cases, because argv[i] is guaranteed to be
not NULL and delimiter is a string constant (also not NULL).
So, g_strsplit() will never return NULL, and the first
array element (tokens[0]) will never be NULL.
But tokens[1] has to be checked for NULL before usage.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Dmitry Frolov <frolov@swemel.ru>
---
 contrib/plugins/bbv.c         |  2 +-
 contrib/plugins/cache.c       | 24 ++++++++++++------------
 contrib/plugins/cflow.c       |  2 +-
 contrib/plugins/drcov.c       |  2 +-
 contrib/plugins/execlog.c     |  6 +++---
 contrib/plugins/hotpages.c    |  6 +++---
 contrib/plugins/hwprofile.c   |  8 ++++----
 contrib/plugins/ips.c         |  4 ++--
 contrib/plugins/stoptrigger.c |  4 ++--
 tests/tcg/plugins/insn.c      |  2 +-
 tests/tcg/plugins/mem.c       |  2 +-
 tests/tcg/plugins/patch.c     |  4 ++--
 12 files changed, 33 insertions(+), 33 deletions(-)

diff --git a/contrib/plugins/bbv.c b/contrib/plugins/bbv.c
index b9da6f815e..b186daf797 100644
--- a/contrib/plugins/bbv.c
+++ b/contrib/plugins/bbv.c
@@ -132,7 +132,7 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
     for (int i = 0; i < argc; i++) {
         char *opt = argv[i];
         g_auto(GStrv) tokens = g_strsplit(opt, "=", 2);
-        if (g_strcmp0(tokens[0], "interval") == 0) {
+        if (g_strcmp0(tokens[0], "interval") == 0 && tokens[1]) {
             interval = g_ascii_strtoull(tokens[1], NULL, 10);
         } else if (g_strcmp0(tokens[0], "outfile") == 0) {
             filename = tokens[1];
diff --git a/contrib/plugins/cache.c b/contrib/plugins/cache.c
index 56508587d3..c9f818f9d9 100644
--- a/contrib/plugins/cache.c
+++ b/contrib/plugins/cache.c
@@ -767,29 +767,29 @@ int qemu_plugin_install(qemu_plugin_id_t id, const qemu_info_t *info,
         char *opt = argv[i];
         g_auto(GStrv) tokens = g_strsplit(opt, "=", 2);
 
-        if (g_strcmp0(tokens[0], "iblksize") == 0) {
+        if (g_strcmp0(tokens[0], "iblksize") == 0 && tokens[1]) {
             l1_iblksize = STRTOLL(tokens[1]);
-        } else if (g_strcmp0(tokens[0], "iassoc") == 0) {
+        } else if (g_strcmp0(tokens[0], "iassoc") == 0 && tokens[1]) {
             l1_iassoc = STRTOLL(tokens[1]);
-        } else if (g_strcmp0(tokens[0], "icachesize") == 0) {
+        } else if (g_strcmp0(tokens[0], "icachesize") == 0 && tokens[1]) {
             l1_icachesize = STRTOLL(tokens[1]);
-        } else if (g_strcmp0(tokens[0], "dblksize") == 0) {
+        } else if (g_strcmp0(tokens[0], "dblksize") == 0 && tokens[1]) {
             l1_dblksize = STRTOLL(tokens[1]);
-        } else if (g_strcmp0(tokens[0], "dassoc") == 0) {
+        } else if (g_strcmp0(tokens[0], "dassoc") == 0 && tokens[1]) {
             l1_dassoc = STRTOLL(tokens[1]);
-        } else if (g_strcmp0(tokens[0], "dcachesize") == 0) {
+        } else if (g_strcmp0(tokens[0], "dcachesize") == 0 && tokens[1]) {
             l1_dcachesize = STRTOLL(tokens[1]);
-        } else if (g_strcmp0(tokens[0], "limit") == 0) {
+        } else if (g_strcmp0(tokens[0], "limit") == 0 && tokens[1]) {
             limit = STRTOLL(tokens[1]);
-        } else if (g_strcmp0(tokens[0], "cores") == 0) {
+        } else if (g_strcmp0(tokens[0], "cores") == 0 && tokens[1]) {
             cores = STRTOLL(tokens[1]);
-        } else if (g_strcmp0(tokens[0], "l2cachesize") == 0) {
+        } else if (g_strcmp0(tokens[0], "l2cachesize") == 0 && tokens[1]) {
             use_l2 = true;
             l2_cachesize = STRTOLL(tokens[1]);
-        } else if (g_strcmp0(tokens[0], "l2blksize") == 0) {
+        } else if (g_strcmp0(tokens[0], "l2blksize") == 0 && tokens[1]) {
             use_l2 = true;
             l2_blksize = STRTOLL(tokens[1]);
-        } else if (g_strcmp0(tokens[0], "l2assoc") == 0) {
+        } else if (g_strcmp0(tokens[0], "l2assoc") == 0 && tokens[1]) {
             use_l2 = true;
             l2_assoc = STRTOLL(tokens[1]);
         } else if (g_strcmp0(tokens[0], "l2") == 0) {
@@ -797,7 +797,7 @@ int qemu_plugin_install(qemu_plugin_id_t id, const qemu_info_t *info,
                 fprintf(stderr, "boolean argument parsing failed: %s\n", opt);
                 return -1;
             }
-        } else if (g_strcmp0(tokens[0], "evict") == 0) {
+        } else if (g_strcmp0(tokens[0], "evict") == 0 && tokens[1]) {
             if (g_strcmp0(tokens[1], "rand") == 0) {
                 policy = RAND;
             } else if (g_strcmp0(tokens[1], "lru") == 0) {
diff --git a/contrib/plugins/cflow.c b/contrib/plugins/cflow.c
index b5e33f25f9..9db078024a 100644
--- a/contrib/plugins/cflow.c
+++ b/contrib/plugins/cflow.c
@@ -368,7 +368,7 @@ int qemu_plugin_install(qemu_plugin_id_t id, const qemu_info_t *info,
     for (int i = 0; i < argc; i++) {
         char *opt = argv[i];
         g_auto(GStrv) tokens = g_strsplit(opt, "=", 2);
-        if (g_strcmp0(tokens[0], "sort") == 0) {
+        if (g_strcmp0(tokens[0], "sort") == 0 && tokens[1]) {
             if (g_strcmp0(tokens[1], "hottest") == 0) {
                 report = SORT_HOTTEST;
             } else if (g_strcmp0(tokens[1], "early") == 0) {
diff --git a/contrib/plugins/drcov.c b/contrib/plugins/drcov.c
index 5edc94dcaf..d803231bb6 100644
--- a/contrib/plugins/drcov.c
+++ b/contrib/plugins/drcov.c
@@ -149,7 +149,7 @@ int qemu_plugin_install(qemu_plugin_id_t id, const qemu_info_t *info,
 {
     for (int i = 0; i < argc; i++) {
         g_auto(GStrv) tokens = g_strsplit(argv[i], "=", 2);
-        if (g_strcmp0(tokens[0], "filename") == 0) {
+        if (g_strcmp0(tokens[0], "filename") == 0 && tokens[1]) {
             file_name = g_strdup(tokens[1]);
         }
     }
diff --git a/contrib/plugins/execlog.c b/contrib/plugins/execlog.c
index 811f320319..7d615b9f3b 100644
--- a/contrib/plugins/execlog.c
+++ b/contrib/plugins/execlog.c
@@ -460,11 +460,11 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
     for (int i = 0; i < argc; i++) {
         char *opt = argv[i];
         g_auto(GStrv) tokens = g_strsplit(opt, "=", 2);
-        if (g_strcmp0(tokens[0], "ifilter") == 0) {
+        if (g_strcmp0(tokens[0], "ifilter") == 0 && tokens[1]) {
             parse_insn_match(tokens[1]);
-        } else if (g_strcmp0(tokens[0], "afilter") == 0) {
+        } else if (g_strcmp0(tokens[0], "afilter") == 0 && tokens[1]) {
             parse_vaddr_match(tokens[1]);
-        } else if (g_strcmp0(tokens[0], "reg") == 0) {
+        } else if (g_strcmp0(tokens[0], "reg") == 0 && tokens[1]) {
             add_regpat(tokens[1]);
         } else if (g_strcmp0(tokens[0], "rdisas") == 0) {
             if (!qemu_plugin_bool_parse(tokens[0], tokens[1], &disas_assist)) {
diff --git a/contrib/plugins/hotpages.c b/contrib/plugins/hotpages.c
index 9d48ac969e..d6ba8020de 100644
--- a/contrib/plugins/hotpages.c
+++ b/contrib/plugins/hotpages.c
@@ -171,7 +171,7 @@ int qemu_plugin_install(qemu_plugin_id_t id, const qemu_info_t *info,
         char *opt = argv[i];
         g_auto(GStrv) tokens = g_strsplit(opt, "=", -1);
 
-        if (g_strcmp0(tokens[0], "sortby") == 0) {
+        if (g_strcmp0(tokens[0], "sortby") == 0 && tokens[1]) {
             if (g_strcmp0(tokens[1], "reads") == 0) {
                 sort_by = SORT_R;
             } else if (g_strcmp0(tokens[1], "writes") == 0) {
@@ -182,12 +182,12 @@ int qemu_plugin_install(qemu_plugin_id_t id, const qemu_info_t *info,
                 fprintf(stderr, "invalid value to sortby: %s\n", tokens[1]);
                 return -1;
             }
-        } else if (g_strcmp0(tokens[0], "io") == 0) {
+        } else if (g_strcmp0(tokens[0], "io") == 0 && tokens[1]) {
             if (!qemu_plugin_bool_parse(tokens[0], tokens[1], &track_io)) {
                 fprintf(stderr, "boolean argument parsing failed: %s\n", opt);
                 return -1;
             }
-        } else if (g_strcmp0(tokens[0], "pagesize") == 0) {
+        } else if (g_strcmp0(tokens[0], "pagesize") == 0 && tokens[1]) {
             page_size = g_ascii_strtoull(tokens[1], NULL, 10);
         } else {
             fprintf(stderr, "option parsing failed: %s\n", opt);
diff --git a/contrib/plugins/hwprofile.c b/contrib/plugins/hwprofile.c
index a9838ccc87..cfb031b132 100644
--- a/contrib/plugins/hwprofile.c
+++ b/contrib/plugins/hwprofile.c
@@ -271,7 +271,7 @@ int qemu_plugin_install(qemu_plugin_id_t id, const qemu_info_t *info,
         char *opt = argv[i];
         g_auto(GStrv) tokens = g_strsplit(opt, "=", 2);
 
-        if (g_strcmp0(tokens[0], "track") == 0) {
+        if (g_strcmp0(tokens[0], "track") == 0 && tokens[1]) {
             if (g_strcmp0(tokens[1], "read") == 0) {
                 rw = QEMU_PLUGIN_MEM_R;
             } else if (g_strcmp0(tokens[1], "write") == 0) {
@@ -280,17 +280,17 @@ int qemu_plugin_install(qemu_plugin_id_t id, const qemu_info_t *info,
                 fprintf(stderr, "invalid value for track: %s\n", tokens[1]);
                 return -1;
             }
-        } else if (g_strcmp0(tokens[0], "pattern") == 0) {
+        } else if (g_strcmp0(tokens[0], "pattern") == 0 && tokens[1]) {
             if (!qemu_plugin_bool_parse(tokens[0], tokens[1], &pattern)) {
                 fprintf(stderr, "boolean argument parsing failed: %s\n", opt);
                 return -1;
             }
-        } else if (g_strcmp0(tokens[0], "source") == 0) {
+        } else if (g_strcmp0(tokens[0], "source") == 0 && tokens[1]) {
             if (!qemu_plugin_bool_parse(tokens[0], tokens[1], &source)) {
                 fprintf(stderr, "boolean argument parsing failed: %s\n", opt);
                 return -1;
             }
-        } else if (g_strcmp0(tokens[0], "match") == 0) {
+        } else if (g_strcmp0(tokens[0], "match") == 0 && tokens[1]) {
             check_match = true;
             g_string_append_printf(matches_raw, "%s,", tokens[1]);
         } else {
diff --git a/contrib/plugins/ips.c b/contrib/plugins/ips.c
index f110c565bc..20de6a8473 100644
--- a/contrib/plugins/ips.c
+++ b/contrib/plugins/ips.c
@@ -150,7 +150,7 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
     for (int i = 0; i < argc; i++) {
         char *opt = argv[i];
         g_auto(GStrv) tokens = g_strsplit(opt, "=", 2);
-        if (g_strcmp0(tokens[0], "ips") == 0) {
+        if (g_strcmp0(tokens[0], "ips") == 0 && tokens[1]) {
             char *endptr = NULL;
             max_insn_per_second = g_ascii_strtoull(tokens[1], &endptr, 10);
             if (!max_insn_per_second && errno) {
@@ -177,7 +177,7 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
                     return -1;
                 }
             }
-        } else if (g_strcmp0(tokens[0], "ipq") == 0) {
+        } else if (g_strcmp0(tokens[0], "ipq") == 0 && tokens[1]) {
             max_insn_per_quantum = g_ascii_strtoull(tokens[1], NULL, 10);
 
             if (!max_insn_per_quantum) {
diff --git a/contrib/plugins/stoptrigger.c b/contrib/plugins/stoptrigger.c
index b3a6ed66a7..733c1f3569 100644
--- a/contrib/plugins/stoptrigger.c
+++ b/contrib/plugins/stoptrigger.c
@@ -114,7 +114,7 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
     for (int i = 0; i < argc; i++) {
         char *opt = argv[i];
         g_auto(GStrv) tokens = g_strsplit(opt, "=", 2);
-        if (g_strcmp0(tokens[0], "icount") == 0) {
+        if (g_strcmp0(tokens[0], "icount") == 0 && tokens[1]) {
             g_auto(GStrv) icount_tokens = g_strsplit(tokens[1], ":", 2);
             icount = g_ascii_strtoull(icount_tokens[0], NULL, 0);
             if (icount < 1 || g_strrstr(icount_tokens[0], "-") != NULL) {
@@ -128,7 +128,7 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
                 icount_exit_code = g_ascii_strtoull(icount_tokens[1], NULL, 0);
             }
             exit_on_icount = true;
-        } else if (g_strcmp0(tokens[0], "addr") == 0) {
+        } else if (g_strcmp0(tokens[0], "addr") == 0 && tokens[1]) {
             g_auto(GStrv) addr_tokens = g_strsplit(tokens[1], ":", 2);
             ExitInfo *ei = g_malloc(sizeof(ExitInfo));
             ei->exit_addr = g_ascii_strtoull(addr_tokens[0], NULL, 0);
diff --git a/tests/tcg/plugins/insn.c b/tests/tcg/plugins/insn.c
index 0c723cb9ed..190cdae942 100644
--- a/tests/tcg/plugins/insn.c
+++ b/tests/tcg/plugins/insn.c
@@ -279,7 +279,7 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
                 fprintf(stderr, "boolean argument parsing failed: %s\n", opt);
                 return -1;
             }
-        } else if (g_strcmp0(tokens[0], "match") == 0) {
+        } else if (g_strcmp0(tokens[0], "match") == 0 && tokens[1]) {
             parse_match(tokens[1]);
         } else if (g_strcmp0(tokens[0], "trace") == 0) {
             if (!qemu_plugin_bool_parse(tokens[0], tokens[1], &do_trace)) {
diff --git a/tests/tcg/plugins/mem.c b/tests/tcg/plugins/mem.c
index 9649bce99c..d10ff01e75 100644
--- a/tests/tcg/plugins/mem.c
+++ b/tests/tcg/plugins/mem.c
@@ -338,7 +338,7 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
                 fprintf(stderr, "boolean argument parsing failed: %s\n", opt);
                 return -1;
             }
-        } else if (g_strcmp0(tokens[0], "track") == 0) {
+        } else if (g_strcmp0(tokens[0], "track") == 0 && tokens[1]) {
             if (g_strcmp0(tokens[1], "r") == 0) {
                 rw = QEMU_PLUGIN_MEM_R;
             } else if (g_strcmp0(tokens[1], "w") == 0) {
diff --git a/tests/tcg/plugins/patch.c b/tests/tcg/plugins/patch.c
index 111c5c1f16..5407f69d12 100644
--- a/tests/tcg/plugins/patch.c
+++ b/tests/tcg/plugins/patch.c
@@ -208,14 +208,14 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
                         "Failed to parse boolean argument use_hwaddr\n");
                 return -1;
             }
-        } else if (g_strcmp0(tokens[0], "target") == 0) {
+        } else if (g_strcmp0(tokens[0], "target") == 0 && tokens[1]) {
             target_data = str_to_bytes(tokens[1]);
             if (!target_data) {
                 fprintf(stderr,
                          "Failed to parse target bytes.\n");
                 return -1;
             }
-        } else if (g_strcmp0(tokens[0], "patch") == 0) {
+        } else if (g_strcmp0(tokens[0], "patch") == 0 && tokens[1]) {
             patch_data = str_to_bytes(tokens[1]);
             if (!patch_data) {
                 fprintf(stderr, "Failed to parse patch bytes.\n");
-- 
2.34.1


