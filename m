Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1704C0218A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2025 10:58:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdSFD-0001yy-Du; Thu, 30 Jan 2025 05:57:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tdSF4-0001xX-8C
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 05:57:52 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tdSF2-0005ZJ-5G
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 05:57:49 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-385dece873cso299944f8f.0
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2025 02:57:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738234666; x=1738839466; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=fr2CD/GU550QMTVq1Op/yguGo73Udn87bNpQQH97sF8=;
 b=kCdCLxiJQ0hH7CMIrrGy+B92CI+54cANoBd3Yt3OGizFg5tZkeUeCYN/+/8+FO8K7t
 GqU3le6Bn3+WIlpSs/qOIH9t5BQePp2lS9AuIrtf3AoQOSX6jMEouTxkrm5hGJDeF/0c
 Nb9QzeRVxA2+s+i/sJNCIHt8taa9rUf6pGXLYxPBw+wbOj7mrSEIejrB/qiUd+OyJIOt
 OjLtvBq+1kKNel6J2rtHBFv+dFJGtYxLUIK5l7DmiHvJG0Rj4W3EVTtHFUypMJudjI92
 JeBIAwZ2QCG5dmhzlKE71c9xHxhI298Dj2ZNpNE2KmspfsRj8vXS12nd1gmFCGe93LLS
 vLXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738234666; x=1738839466;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fr2CD/GU550QMTVq1Op/yguGo73Udn87bNpQQH97sF8=;
 b=oIOuNFocF6rss1wPjeDNJ6eNSJYEgZ49u8DPdG2Vg9u1cDBkeI8bTV0qiL1W5hvJfe
 NQ1Vf3HGGA3AOS+zyOZHbnD3HxKJ8WvBv0yXz7bwpk1qOkYr7SjuhHOsiMK5DphvPh1L
 7qtl3kjbJ7o7rQ+yY/sLRFC8RDh6oudaA1lrnOtyjDum0LuKgoIc8iG4J/ZwhdhFloCy
 zZca8h20qa22yVrBCe/0HHmRL1k3eiHHpTQMn5znADb0q0fCh9KAkXk2+kwaiolTq4KW
 VsBHXzzSRTkLvXmHFOTZfZ3JP85zvJszLPc3hA0g1iSwhQee104A0QDIPJfiSPJBHiaU
 IPBw==
X-Gm-Message-State: AOJu0Yz45ER6o8UXCYkfYLltgxJm2BMorZz851vq/fcJAh7htPKylPBO
 iu/LPHKpB6MGwHsrtX8U8Z+NeQLEjvXmqTYryK/nQ+HnLp6WhDu1K2zM/iz+p7qvv23yj3Y4YRC
 9XWY=
X-Gm-Gg: ASbGncsx27lm8XSJVL6nNyPwnmmPRqBXGqbbxZgLT7kgMefHXv8KWbb1HVpcd/R+SjB
 lB0jMsscDC3Rzb3nmTGbpvBccC9Ybh81hQZCC3MeZ0x7IiJGOT2VAhidCyFUlRjTk+97d7/rBQP
 +cJE8cA4wUR76TqhSgk5j1jACFoz8mlCpXEIC78To/VLnljemdkHnqfGY/yvIO1yGaG0z4Bs7WR
 0A6p6xzd0ZBkIoud51ENe2+bGmxln/aq5uArEGVtT4iPAoeEbov9cVS0gRYVK2r9eWjtbogWImY
 v2pCg9OZWVrcpdeu9L8THDqZxKmuedf2QHlpQwLQJWtHRvnHQ9nM1M8hq5rF1/fBpQ==
X-Google-Smtp-Source: AGHT+IHiWPCv3g4rNBP1MEfLKRIH15mkf4gbwh9fNgLBInO8fFGWVYA6YfT9Gy0ia7qawe6rSXycrg==
X-Received: by 2002:a5d:59af:0:b0:385:fd24:3303 with SMTP id
 ffacd0b85a97d-38c51664ff5mr6526661f8f.0.1738234665814; 
 Thu, 30 Jan 2025 02:57:45 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c5c0ec7e6sm1647347f8f.19.2025.01.30.02.57.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 30 Jan 2025 02:57:45 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-ppc@nongnu.org, qemu-trivial@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] overall: Remove unnecessary g_strdup_printf() calls
Date: Thu, 30 Jan 2025 11:57:43 +0100
Message-ID: <20250130105743.1355-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

Replace g_strdup_printf("%s", value) -> g_strdup(value)
to avoid unnecessary string formatting.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 crypto/hash-afalg.c | 2 +-
 hw/ppc/spapr_caps.c | 2 +-
 plugins/loader.c    | 2 +-
 target/i386/cpu.c   | 2 +-
 trace/simple.c      | 2 +-
 ui/console.c        | 4 +---
 ui/gtk.c            | 3 +--
 util/module.c       | 2 +-
 8 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/crypto/hash-afalg.c b/crypto/hash-afalg.c
index 8c0ce5b5200..bd3fe3b4272 100644
--- a/crypto/hash-afalg.c
+++ b/crypto/hash-afalg.c
@@ -59,7 +59,7 @@ qcrypto_afalg_hash_format_name(QCryptoHashAlgo alg,
     if (is_hmac) {
         name = g_strdup_printf("hmac(%s)", alg_name);
     } else {
-        name = g_strdup_printf("%s", alg_name);
+        name = g_strdup(alg_name);
     }
 
     return name;
diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
index 7edd1383601..904bff87ce1 100644
--- a/hw/ppc/spapr_caps.c
+++ b/hw/ppc/spapr_caps.c
@@ -1034,7 +1034,7 @@ void spapr_caps_add_properties(SpaprMachineClass *smc)
     for (i = 0; i < ARRAY_SIZE(capability_table); i++) {
         SpaprCapabilityInfo *cap = &capability_table[i];
         g_autofree char *name = g_strdup_printf("cap-%s", cap->name);
-        g_autofree char *desc = g_strdup_printf("%s", cap->description);
+        g_autofree char *desc = g_strdup(cap->description);
 
         object_class_property_add(klass, name, cap->type,
                                   cap->get, cap->set,
diff --git a/plugins/loader.c b/plugins/loader.c
index ebc01da9c6e..99686b54666 100644
--- a/plugins/loader.c
+++ b/plugins/loader.c
@@ -128,7 +128,7 @@ static int plugin_add(void *opaque, const char *name, const char *value,
                 /* Will treat arg="argname" as "argname=on" */
                 fullarg = g_strdup_printf("%s=%s", value, "on");
             } else {
-                fullarg = g_strdup_printf("%s", value);
+                fullarg = g_strdup(value);
             }
             warn_report("using 'arg=%s' is deprecated", value);
             error_printf("Please use '%s' directly\n", fullarg);
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index b5dd60d2812..72ab147e851 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -6166,7 +6166,7 @@ static void x86_cpu_list_entry(gpointer data, gpointer user_data)
         desc = g_strdup_printf("%s [%s]", model_id, cc->model->note);
     }
     if (!desc) {
-        desc = g_strdup_printf("%s", model_id);
+        desc = g_strdup(model_id);
     }
 
     if (cc->model && cc->model->cpudef->deprecation_note) {
diff --git a/trace/simple.c b/trace/simple.c
index 18af590cf7b..c0aba00cb7f 100644
--- a/trace/simple.c
+++ b/trace/simple.c
@@ -366,7 +366,7 @@ void st_set_trace_file(const char *file)
         /* Type cast needed for Windows where getpid() returns an int. */
         trace_file_name = g_strdup_printf(CONFIG_TRACE_FILE "-" FMT_pid, (pid_t)getpid());
     } else {
-        trace_file_name = g_strdup_printf("%s", file);
+        trace_file_name = g_strdup(file);
     }
 
     st_set_trace_file_enabled(saved_enable);
diff --git a/ui/console.c b/ui/console.c
index 914ed2cc76b..6456e8dd908 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -1386,9 +1386,7 @@ char *qemu_console_get_label(QemuConsole *con)
                                        object_get_typename(c->device),
                                        c->head);
             } else {
-                return g_strdup_printf("%s", dev->id ?
-                                       dev->id :
-                                       object_get_typename(c->device));
+                return g_strdup(dev->id ? : object_get_typename(c->device));
             }
         }
         return g_strdup("VGA");
diff --git a/ui/gtk.c b/ui/gtk.c
index c0237431489..59bda83da65 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -1944,8 +1944,7 @@ static GSList *gd_vc_vte_init(GtkDisplayState *s, VirtualConsole *vc,
     vcd->console = vc;
 
     snprintf(buffer, sizeof(buffer), "vc%d", idx);
-    vc->label = g_strdup_printf("%s", vc->vte.chr->label
-                                ? vc->vte.chr->label : buffer);
+    vc->label = g_strdup(vc->vte.chr->label ? : buffer);
     group = gd_vc_menu_init(s, vc, idx, group, view_menu);
 
     vc->vte.terminal = vte_terminal_new();
diff --git a/util/module.c b/util/module.c
index 3eb0f06df16..1aa2079d013 100644
--- a/util/module.c
+++ b/util/module.c
@@ -234,7 +234,7 @@ int module_load(const char *prefix, const char *name, Error **errp)
 
     search_dir = getenv("QEMU_MODULE_DIR");
     if (search_dir != NULL) {
-        dirs[n_dirs++] = g_strdup_printf("%s", search_dir);
+        dirs[n_dirs++] = g_strdup(search_dir);
     }
     dirs[n_dirs++] = get_relocated_path(CONFIG_QEMU_MODDIR);
 
-- 
2.47.1


