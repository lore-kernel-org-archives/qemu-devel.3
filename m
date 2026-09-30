Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 521D4CA5FCC
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 22:13:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xC2X1-0007yD-K1; Wed, 30 Sep 2026 18:12:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1xC2Wc-0007vE-8J
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 18:11:45 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1xC2WZ-00051z-Um
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 18:11:41 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 763FE1FB9C;
 Wed, 30 Sep 2026 22:11:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1790806294; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IAbqzYN6qR2qqTDjflBVZPREghLvnsUT3GgJOI5aYN8=;
 b=yghaE4U6/xhIzXkj7j1uzE0WSdIFaH3iL3l+IO1K2CI8jPR+IazmPbtOwmI87rQbQjyCxi
 5uw9vRppURTaf/Kj4ttKCw+K6jW4SHxe0g5AaXjFl/b+YV213FJ7+JtO2kPxrqMB/Cgyk1
 IsbetFZKUQUbb8+/FGgtZY+MLOk0cqA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1790806294;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IAbqzYN6qR2qqTDjflBVZPREghLvnsUT3GgJOI5aYN8=;
 b=7P44AehnoONLK1ZG34Onwu6ApzAi/m/QAf8TcKbpmhG77qYTrpv6/6fnJvPWePaSDCwbhX
 ILy8U9rX4IvWM4Bg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1790806290; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IAbqzYN6qR2qqTDjflBVZPREghLvnsUT3GgJOI5aYN8=;
 b=gVbRP+/R2kM1BD4IQj3rF6jFEBl4UIKR+yqKnUhBXrDx5gLOEq14Xk1QqSB06Gwl5PLtz0
 c+HhTBQhc1QBop3Po8Mb0U8eAgGHoC1pHP1H2TJ4bxlDPHusnak8+hZzOMhtlTxr82QRKR
 PKAEg/RhnheFDdrOUOGmo9C3ZihvPpA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1790806290;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IAbqzYN6qR2qqTDjflBVZPREghLvnsUT3GgJOI5aYN8=;
 b=OF6kzFYSTWX3HFxxO9aBHkChF2OupE6aICvQx/CQIsjd+qUiLQtAeU/0oZ4SHUhsH1ddmC
 ZLwjgegGNV9gWCDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 40BBD13B24;
 Wed, 30 Sep 2026 22:11:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id befqOAqJvWpwXAAAD6G6ig:T5
 (envelope-from <farosas@suse.de>); Wed, 30 Sep 2026 22:11:29 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 04/11] qemu-option: Fix 'help' parameter parsing
Date: Wed, 30 Sep 2026 19:10:58 -0300
Message-ID: <20260930221105.2262063-5-farosas@suse.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260930221105.2262063-1-farosas@suse.de>
References: <20260930221105.2262063-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.999];
 MIME_GOOD(-0.10)[text/plain]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Reject invalid values such as help= and help=foo.

Reject valid, but not applicable values such has help=on and help=off.

To achieve the above:

Add an 'is_help' member to QemuOpt so that information can be stored
while creating the option. This allows moving the help handling out of
get_opt_name_value(), which is necessary because that function doesn't
take an Error.

At the caller, opts_do_parse(), let the QemuOpt be created with the
name and value fields as they come out of get_opt_name_value().

With a new routine, validate the new QemuOpt against the 'help'
parameter rules (to fix the bug), then let the existing opt_validate()
reject any NULL values. The two validations need to be separate
because in between there needs to be a setting of opt->str to "on"
whenever the special short-form parameters require it.

The "on" value is required because of the conversions of QemuOpts
from/to QDict since QDict cannot take a NULL value. The conversions
also cause opt_validate() to be reentrant via qemu_opt_set(), so the
initial validation of 'help' needs to be out of that function,
otherwise there's no way to distinguish an user-set help=on vs. the
help=on set for compatibility with QDict (the "in between" part from
the previous paragraph).

The passing around of help_wanted becomes redundant since opt->is_help
can be checked throughout. Remove that argument everywhere.

Stop returning false from opts_do_parse() when is_help=true. Only
return false when there's an error and let the callers decide what to
do when is_help=true. However, still break the loop when is_help=true
to keep the behavior of stopping parsing once the 'help' parameter is
seen.

At qemu_opts_parse_noisily(), due to the change of return value
mentioned above, it becomes clear when to report the error and when to
print the help text. Use qemu_opt_has_help_opt() to obtain the
is_help information from QemuOpt.

Since get_opt_name_value() can now return while value=NULL, the other
two callsites need to be updated. At opts_parse_id(), assert value !=
NULL. At has_help_option(), use the NULL value to keep the existing
behavior of rejecting anything but 'help'.

The unit tests are updated accordingly.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 include/qemu/option_int.h   |   1 +
 tests/unit/test-qemu-opts.c |   9 ++--
 util/qemu-option.c          | 104 ++++++++++++++++++++----------------
 3 files changed, 63 insertions(+), 51 deletions(-)

diff --git a/include/qemu/option_int.h b/include/qemu/option_int.h
index 5dd9a5162d..c31bd6e3ab 100644
--- a/include/qemu/option_int.h
+++ b/include/qemu/option_int.h
@@ -32,6 +32,7 @@
 struct QemuOpt {
     char *name;
     char *str;
+    bool is_help;
 
     const QemuOptDesc *desc;
     union {
diff --git a/tests/unit/test-qemu-opts.c b/tests/unit/test-qemu-opts.c
index 07ede50920..7cedfba332 100644
--- a/tests/unit/test-qemu-opts.c
+++ b/tests/unit/test-qemu-opts.c
@@ -777,16 +777,15 @@ static void test_has_help_option_with_value(void)
     };
     int i;
     QemuOpts *opts;
+    Error *err = NULL;
 
     for (i = 0; i < ARRAY_SIZE(test); i++) {
         /* reject all */
         g_assert_cmpint(has_help_option(test[i].params), ==, false);
 
-        /* accept all */
-        opts = qemu_opts_parse(&opts_list_03, test[i].params, false,
-                               &error_abort);
-        g_assert_cmpint(qemu_opt_has_help_opt(opts), ==, true);
-        qemu_opts_del(opts);
+        opts = qemu_opts_parse(&opts_list_03, test[i].params, false, &err);
+        error_free_or_abort(&err);
+        g_assert(!opts);
     }
 }
 
diff --git a/util/qemu-option.c b/util/qemu-option.c
index 8ac848bbc0..483e6cbf70 100644
--- a/util/qemu-option.c
+++ b/util/qemu-option.c
@@ -331,7 +331,7 @@ bool qemu_opt_has_help_opt(QemuOpts *opts)
     QemuOpt *opt;
 
     QTAILQ_FOREACH_REVERSE(opt, &opts->head, next) {
-        if (is_help_option(opt->name)) {
+        if (opt->is_help) {
             return true;
         }
     }
@@ -499,6 +499,7 @@ static QemuOpt *opt_create(QemuOpts *opts, const char *name, char *value)
     opt->name = g_strdup(name);
     opt->str = value;
     opt->opts = opts;
+    opt->is_help = is_help_option(name);
     QTAILQ_INSERT_TAIL(&opts->head, opt, next);
 
     return opt;
@@ -760,12 +761,10 @@ void qemu_opts_print(QemuOpts *opts, const char *separator)
 
 static const char *get_opt_name_value(const char *params,
                                       const char *firstname,
-                                      bool *help_wanted,
                                       char **name, char **value)
 {
     const char *p;
     size_t len;
-    bool is_help = false;
 
     len = strcspn(params, "=,");
     if (params[len] != '=') {
@@ -776,22 +775,6 @@ static const char *get_opt_name_value(const char *params,
             p = get_opt_value(params, value);
         } else {
             p = get_opt_name(params, name, len);
-
-            /*
-             * Short-form flags (i.e. without any value) are not
-             * supported, except for two cases:
-             */
-
-            /* the 'help' or '?' flag */
-            is_help = is_help_option(*name);
-            if (is_help) {
-                *value = g_strdup("on");
-            }
-
-            /* a missing, non-implicit key, i.e. a single comma ',' */
-            if (g_str_equal(*name, "") && *p == ',') {
-                *value = g_strdup("on");
-            }
         }
     } else {
         /* found "foo=bar,more" */
@@ -802,18 +785,46 @@ static const char *get_opt_name_value(const char *params,
     }
 
     assert(!*p || *p == ',');
-    if (help_wanted && is_help) {
-        *help_wanted = true;
-    }
     if (*p == ',') {
         p++;
     }
     return p;
 }
 
+/*
+ * Short-form parameters (i.e. without any value) are not
+ * supported, except for two cases:
+ *
+ * - the 'help' or '?' flag
+ * - the empty, non-implicit key combined with an empty
+ *   non-implicit value, i.e. a single comma ','
+ *
+ * The rest of the code is not prepared to deal with empty values, set
+ * the special cases to "on".
+ */
+static bool opt_short_form_compat(QemuOpt *opt, Error **errp)
+{
+    if (opt->str) {
+        /*
+         * Validate the 'help' parameter at this point because the
+         * opt_validate() routine can be reentrant and this very check
+         * would fail once the "on" value is set below.
+         */
+        if (opt->is_help) {
+            error_setg(errp, "Parameter '%s' doesn't take any values",
+                       opt->name);
+            return false;
+        }
+    } else {
+        if (opt->is_help || g_str_equal(opt->name, "")) {
+            opt->str = g_strdup("on");
+        }
+    }
+    return true;
+}
+
 static bool opts_do_parse(QemuOpts *opts, const char *params,
-                          const char *firstname,
-                          bool *help_wanted, Error **errp)
+                          const char *firstname, Error **errp)
 {
     const char *p;
     QemuOpt *opt;
@@ -822,10 +833,7 @@ static bool opts_do_parse(QemuOpts *opts, const char *params,
         g_autofree char *option = NULL;
         g_autofree char *value = NULL;
 
-        p = get_opt_name_value(p, firstname, help_wanted, &option, &value);
-        if (help_wanted && *help_wanted) {
-            return false;
-        }
+        p = get_opt_name_value(p, firstname, &option, &value);
         firstname = NULL;
 
         if (!strcmp(option, "id")) {
@@ -833,10 +841,15 @@ static bool opts_do_parse(QemuOpts *opts, const char *params,
         }
 
         opt = opt_create(opts, option, g_steal_pointer(&value));
-        if (!opt_validate(opt, errp)) {
+        if (!opt_short_form_compat(opt, errp) ||
+            !opt_validate(opt, errp)) {
             qemu_opt_del(opt);
             return false;
         }
+
+        if (opt->is_help) {
+            return true;
+        }
     }
 
     return true;
@@ -850,8 +863,9 @@ static char *opts_parse_id(const char *params)
         g_autofree char *name = NULL;
         g_autofree char *value = NULL;
 
-        p = get_opt_name_value(p, NULL, NULL, &name, &value);
+        p = get_opt_name_value(p, NULL, &name, &value);
         if (!strcmp(name, "id")) {
+            assert(value);
             return g_steal_pointer(&value);
         }
     }
@@ -862,14 +876,13 @@ static char *opts_parse_id(const char *params)
 bool has_help_option(const char *params)
 {
     const char *p;
-    bool ret = false;
 
     for (p = params; *p;) {
         g_autofree char *name = NULL;
         g_autofree char *value = NULL;
 
-        p = get_opt_name_value(p, NULL, &ret, &name, &value);
-        if (ret) {
+        p = get_opt_name_value(p, NULL, &name, &value);
+        if (is_help_option(name) && !value) {
             return true;
         }
     }
@@ -886,11 +899,11 @@ bool has_help_option(const char *params)
 bool qemu_opts_do_parse(QemuOpts *opts, const char *params,
                        const char *firstname, Error **errp)
 {
-    return opts_do_parse(opts, params, firstname, NULL, errp);
+    return opts_do_parse(opts, params, firstname, errp);
 }
 
 static QemuOpts *opts_parse(QemuOptsList *list, const char *params,
-                            bool permit_abbrev, bool *help_wanted, Error **errp)
+                            bool permit_abbrev, Error **errp)
 {
     const char *firstname;
     char *id = opts_parse_id(params);
@@ -905,7 +918,7 @@ static QemuOpts *opts_parse(QemuOptsList *list, const char *params,
         return NULL;
     }
 
-    if (!opts_do_parse(opts, params, firstname, help_wanted, errp)) {
+    if (!opts_do_parse(opts, params, firstname, errp)) {
         qemu_opts_del(opts);
         return NULL;
     }
@@ -923,7 +936,7 @@ static QemuOpts *opts_parse(QemuOptsList *list, const char *params,
 QemuOpts *qemu_opts_parse(QemuOptsList *list, const char *params,
                           bool permit_abbrev, Error **errp)
 {
-    return opts_parse(list, params, permit_abbrev, NULL, errp);
+    return opts_parse(list, params, permit_abbrev, errp);
 }
 
 /**
@@ -939,17 +952,16 @@ QemuOpts *qemu_opts_parse_noisily(QemuOptsList *list, const char *params,
 {
     Error *err = NULL;
     QemuOpts *opts;
-    bool help_wanted = false;
 
-    opts = opts_parse(list, params, permit_abbrev,
-                      opts_accepts_any(list) ? NULL : &help_wanted, &err);
+    opts = opts_parse(list, params, permit_abbrev, &err);
     if (!opts) {
-        assert(!!err + !!help_wanted == 1);
-        if (help_wanted) {
-            qemu_opts_print_help(list, true);
-        } else {
-            error_report_err(err);
-        }
+        error_report_err(err);
+        return NULL;
+    }
+
+    if (qemu_opt_has_help_opt(opts) && !opts_accepts_any(list)) {
+        qemu_opts_print_help(list, true);
+        return NULL;
     }
     return opts;
 }
-- 
2.53.0


