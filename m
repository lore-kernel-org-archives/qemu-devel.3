Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05E8CCA5FC4
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 22:12:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xC2Wi-0007w8-HD; Wed, 30 Sep 2026 18:11:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1xC2Wc-0007vG-IS
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 18:11:45 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1xC2WZ-00051q-DZ
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 18:11:42 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 2A6CE1FB9A;
 Wed, 30 Sep 2026 22:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1790806293; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gq+/f3g4cnZFtacHHHaIK0bjD9eBRDuOiCpQiSAMofU=;
 b=yIJjDN0olLiSgVcUyt9kHHkknVPWR7W/cHbFTpWgPg7YegRxygX+7oQavmNG24XKMm3+po
 e1wFhJ9oJr/Ke/iXmvA7r0HxWzghhsF/cKh0sJoKRThmeavHeeVzIKiSj7wj11tzvZxGtJ
 K5Fg2wCTUF1jNpKX6d8RYonQTLsLtkY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1790806293;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gq+/f3g4cnZFtacHHHaIK0bjD9eBRDuOiCpQiSAMofU=;
 b=qcLwiilKfJPnkvIbF2WF+nDDo/iGAgAE00lwT7FYXnpVlfhlTdjKMJPm0aT5gqutJeOgP/
 yW7LVDUQLqPGATAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1790806289; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gq+/f3g4cnZFtacHHHaIK0bjD9eBRDuOiCpQiSAMofU=;
 b=1wU7zzyhk9y0KBiwJ/vQ94cc74LLTRWEbxbU9xsI/O6zWS1cy2VwPpV1NU5rcBZzBcwqA5
 nsxR0Du72k+rHIFQiG3IYAMDCJELSumgYyyQ64VXy5fyxveLKX12EX2b79MRiPrvOxihus
 yjs2+SfiLhztR5mC6sbzAwI9OpjRtrc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1790806289;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gq+/f3g4cnZFtacHHHaIK0bjD9eBRDuOiCpQiSAMofU=;
 b=BZipXHydAHHAYrXAe47QzjwOV+h00szHNZV3hIyl0hGLIEuNNZy0SOvk3ph5ePH5pNz38p
 3KtGQ18Che4rbwBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5AA1913B23;
 Wed, 30 Sep 2026 22:11:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id befqOAqJvWpwXAAAD6G6ig:T4
 (envelope-from <farosas@suse.de>); Wed, 30 Sep 2026 22:11:27 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Subject: [PATCH v2 03/11] qemu-option: Remove short form options support
Date: Wed, 30 Sep 2026 19:10:57 -0300
Message-ID: <20260930221105.2262063-4-farosas@suse.de>
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
 RCPT_COUNT_FIVE(0.00)[6]; FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email];
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

Option parameters without a value (i.e. key vs. key=val) are
deprecated. The missing value is currently implied to be either "on"
or "off" depending on whether the parameter name starts with "no".

Remove the implied behavior and start rejecting option parameters
without values by emitting the error message:

 "Parameter 'foo' without a value."

Two special cases remain:

1) The 'help' parameter is special and still supported. Keep a
   positive value attached to it ("on").

   Note that currently there is no validation for the value (if any)
   attached to the help parameter. help, help=on, help=off, help=foo
   all result in the help text being emitted. This is not changed by
   this patch.

2) The empty value is allowed if the key is also empty. This can be
   achieved in the command line by adding commas.
   E.g.: share=on,, is parsed as:
     key:"share" value:"on" and
     key:"" value:"on"

One effect of this change that might not be obvious is that parameter
combinations of the form:

 id=mem0,share,help

no longer produce the help output. The lack of value for the 'share'
parameter is reported with precedence. Users will need to either use a
valid value or omit the parameter entirely:

 id=mem0,share=on,help
 id=mem0,help

About testing:

A few strings from the test_has_help_option test were removed because
they now trigger the missing value error during parsing and therefore
cannot be used for testing the qemu_opt_has_help_opt() routine which
needs the parsed QemuOpts.

The two "Implied value" tests were replaced with 8 new tests.

The "Implied key" test has had the extra parameters with implied
values removed, otherwise the implied key cannot be tested due to the
rejected missing values.

The test_inet_parse_all_implicit_bool_good was removed entirely
because it only tested the use case that is being removed.

A few block tests were updated to use the key=value form.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 docs/about/deprecated.rst      | 13 -------
 tests/qemu-iotests/084         |  2 +-
 tests/qemu-iotests/146         |  2 +-
 tests/qemu-iotests/197         |  2 +-
 tests/qemu-iotests/215         |  2 +-
 tests/unit/test-qemu-opts.c    | 67 +++++++++++++++++++++-------------
 tests/unit/test-util-sockets.c | 33 -----------------
 util/qemu-option.c             | 57 ++++++++++++++---------------
 8 files changed, 73 insertions(+), 105 deletions(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index ccbc421949..f54905eba9 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -30,19 +30,6 @@ deprecated.
 System emulator command line arguments
 --------------------------------------
 
-Short-form boolean options (since 6.0)
-''''''''''''''''''''''''''''''''''''''
-
-Boolean options such as ``share=on``/``share=off`` could be written
-in short form as ``share`` and ``noshare``.  This is now deprecated
-and will cause a warning.
-
-``delay`` option for socket character devices (since 6.0)
-'''''''''''''''''''''''''''''''''''''''''''''''''''''''''
-
-The replacement for the ``nodelay`` short-form boolean option is ``nodelay=on``
-rather than ``delay=off``.
-
 Plugin argument passing through ``arg=<string>`` (since 6.1)
 ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
 
diff --git a/tests/qemu-iotests/084 b/tests/qemu-iotests/084
index 1181cb7cd0..f905396e72 100755
--- a/tests/qemu-iotests/084
+++ b/tests/qemu-iotests/084
@@ -51,7 +51,7 @@ bii_offset=384 # block in image field offset
 echo
 echo "=== Statically allocated image creation ==="
 echo
-_make_test_img $size -o static
+_make_test_img $size -o static=on
 _img_info
 stat -c"disk image file size in bytes: %s" "${TEST_IMG}"
 _cleanup_test_img
diff --git a/tests/qemu-iotests/146 b/tests/qemu-iotests/146
index f63291d0ff..a7853e03c9 100755
--- a/tests/qemu-iotests/146
+++ b/tests/qemu-iotests/146
@@ -165,7 +165,7 @@ echo
 echo === Testing Image create, force_size ===
 echo
 
-_make_test_img -o force_size 4G
+_make_test_img -o force_size=on 4G
 
 echo
 echo === Read created image, default opts ====
diff --git a/tests/qemu-iotests/197 b/tests/qemu-iotests/197
index 69849c800e..271d1283c5 100755
--- a/tests/qemu-iotests/197
+++ b/tests/qemu-iotests/197
@@ -63,7 +63,7 @@ echo
 # Prep the images
 # VPC rounds image sizes to a specific geometry, force a specific size.
 if [ "$IMGFMT" = "vpc" ]; then
-    IMGOPTS=$(_optstr_add "$IMGOPTS" "force_size")
+    IMGOPTS=$(_optstr_add "$IMGOPTS" "force_size=on")
 fi
 _make_test_img 4G
 $QEMU_IO -c "write -P 55 3G 1k" "$TEST_IMG" | _filter_qemu_io
diff --git a/tests/qemu-iotests/215 b/tests/qemu-iotests/215
index 6babbcdc1f..6a518a9f57 100755
--- a/tests/qemu-iotests/215
+++ b/tests/qemu-iotests/215
@@ -60,7 +60,7 @@ echo
 # Prep the images
 # VPC rounds image sizes to a specific geometry, force a specific size.
 if [ "$IMGFMT" = "vpc" ]; then
-    IMGOPTS=$(_optstr_add "$IMGOPTS" "force_size")
+    IMGOPTS=$(_optstr_add "$IMGOPTS" "force_size=on")
 fi
 _make_test_img 4G
 $QEMU_IO -c "write -P 55 3G 1k" "$TEST_IMG" | _filter_qemu_io
diff --git a/tests/unit/test-qemu-opts.c b/tests/unit/test-qemu-opts.c
index 4ccb79d406..07ede50920 100644
--- a/tests/unit/test-qemu-opts.c
+++ b/tests/unit/test-qemu-opts.c
@@ -481,26 +481,10 @@ static void test_opts_parse(void)
     error_free_or_abort(&err);
     g_assert(!opts);
 
-    /* Implied value (qemu_opts_parse warns but accepts it) */
-    opts = qemu_opts_parse(&opts_list_03, "an,noaus,noaus=",
-                           false, &error_abort);
-    g_assert_cmpuint(opts_count(opts), ==, 3);
-    g_assert_cmpstr(qemu_opt_get(opts, "an"), ==, "on");
-    g_assert_cmpstr(qemu_opt_get(opts, "aus"), ==, "off");
-    g_assert_cmpstr(qemu_opt_get(opts, "noaus"), ==, "");
-
-    /* Implied value, negated empty key */
-    opts = qemu_opts_parse(&opts_list_03, "no", false, &error_abort);
-    g_assert_cmpuint(opts_count(opts), ==, 1);
-    g_assert_cmpstr(qemu_opt_get(opts, ""), ==, "off");
-
     /* Implied key */
-    opts = qemu_opts_parse(&opts_list_03, "an,noaus,noaus=", true,
-                           &error_abort);
-    g_assert_cmpuint(opts_count(opts), ==, 3);
+    opts = qemu_opts_parse(&opts_list_03, "an", true, &error_abort);
+    g_assert_cmpuint(opts_count(opts), ==, 1);
     g_assert_cmpstr(qemu_opt_get(opts, "implied"), ==, "an");
-    g_assert_cmpstr(qemu_opt_get(opts, "aus"), ==, "off");
-    g_assert_cmpstr(qemu_opt_get(opts, "noaus"), ==, "");
 
     /* Implied key with empty value */
     opts = qemu_opts_parse(&opts_list_03, ",", true, &error_abort);
@@ -523,6 +507,45 @@ static void test_opts_parse(void)
     error_free_or_abort(&err);
     g_assert(!opts);
 
+    /* Implied value */
+    opts = qemu_opts_parse(&opts_list_03, "an", false, &err);
+    error_free_or_abort(&err);
+    g_assert(!opts);
+
+    /* Implied value, unknown key */
+    opts = qemu_opts_parse(&opts_list_01, "nonexistent", false, &err);
+    error_free_or_abort(&err);
+    g_assert(!opts);
+
+    /* Implied value, negated key */
+    opts = qemu_opts_parse(&opts_list_03, "noaus", false, &err);
+    error_free_or_abort(&err);
+    g_assert(!opts);
+
+    /* Implied value, negated empty key */
+    opts = qemu_opts_parse(&opts_list_03, "no", false, &err);
+    error_free_or_abort(&err);
+    g_assert(!opts);
+
+    /* Empty value */
+    opts = qemu_opts_parse(&opts_list_03, "aus=", false, &error_abort);
+    g_assert_cmpuint(opts_count(opts), ==, 1);
+
+    /* Implied key */
+    opts = qemu_opts_parse(&opts_list_03, "an", true, &error_abort);
+    g_assert_cmpuint(opts_count(opts), ==, 1);
+
+    /* Implied key, implied value */
+    opts = qemu_opts_parse(&opts_list_03, "an,noaus,noaus=", true, &err);
+    error_free_or_abort(&err);
+    g_assert(!opts);
+
+    /* Implied key, empty value */
+    opts = qemu_opts_parse(&opts_list_03, "an,noaus=", true, &error_abort);
+    g_assert_cmpuint(opts_count(opts), ==, 2);
+    g_assert_cmpstr(qemu_opt_get(opts, "implied"), ==, "an");
+    g_assert_cmpstr(qemu_opt_get(opts, "noaus"), ==, "");
+
     qemu_opts_reset(&opts_list_01);
     qemu_opts_reset(&opts_list_03);
 }
@@ -720,16 +743,8 @@ static void test_has_help_option(void)
     } test[] = {
         { "help", true, false },
         { "?", true, false },
-        { "helpme", false, false },
-        { "?me", false, false },
-        { "a,help", true, true },
-        { "a,?", true, true },
-        { "a=0,help,b", true, true },
-        { "a=0,?,b", true, true },
         { "help,b=1", true, false },
         { "?,b=1", true, false },
-        { "a,b,,help", true, true },
-        { "a,b,,?", true, true },
     };
     int i;
     QemuOpts *opts;
diff --git a/tests/unit/test-util-sockets.c b/tests/unit/test-util-sockets.c
index 006f5e579c..2875c547a0 100644
--- a/tests/unit/test-util-sockets.c
+++ b/tests/unit/test-util-sockets.c
@@ -516,36 +516,6 @@ static void test_inet_parse_all_options_good(void)
         , &exp_addr, true);
 }
 
-static void test_inet_parse_all_implicit_bool_good(void)
-{
-    char host[] = "::1";
-    char port[] = "5000";
-    InetSocketAddress exp_addr = {
-        .host = host,
-        .port = port,
-        .has_numeric = true,
-        .numeric =  true,
-        .has_to = true,
-        .to = 5006,
-        .has_ipv4 = true,
-        .ipv4 = true,
-        .has_ipv6 = true,
-        .ipv6 = true,
-        .has_keep_alive = true,
-        .keep_alive = true,
-#ifdef HAVE_IPPROTO_MPTCP
-        .has_mptcp = true,
-        .mptcp = true,
-#endif
-    };
-    inet_parse_test_helper(
-        "[::1]:5000,numeric,to=5006,ipv4,ipv6,keep-alive"
-#ifdef HAVE_IPPROTO_MPTCP
-        ",mptcp"
-#endif
-        , &exp_addr, true);
-}
-
 int main(int argc, char **argv)
 {
     bool has_ipv4, has_ipv6;
@@ -613,9 +583,6 @@ int main(int argc, char **argv)
                     test_inet_parse_hostname_good);
     g_test_add_func("/util/socket/inet-parse/all-options-good",
                     test_inet_parse_all_options_good);
-    g_test_add_func("/util/socket/inet-parse/all-bare-bool-good",
-                    test_inet_parse_all_implicit_bool_good);
-
 end:
     return g_test_run();
 }
diff --git a/util/qemu-option.c b/util/qemu-option.c
index 557d5d929c..8ac848bbc0 100644
--- a/util/qemu-option.c
+++ b/util/qemu-option.c
@@ -509,6 +509,11 @@ static bool opt_validate(QemuOpt *opt, Error **errp)
     const QemuOptDesc *desc;
     const QemuOptsList *list = opt->opts->list;
 
+    if (!opt->str) {
+        error_setg(errp, "Parameter '%s' without a value", opt->name);
+        return false;
+    }
+
     desc = find_desc_by_name(list->desc, opt->name);
     if (!desc && !opts_accepts_any(list)) {
         error_setg(errp, "Invalid parameter '%s'", opt->name);
@@ -755,12 +760,10 @@ void qemu_opts_print(QemuOpts *opts, const char *separator)
 
 static const char *get_opt_name_value(const char *params,
                                       const char *firstname,
-                                      bool warn_on_flag,
                                       bool *help_wanted,
                                       char **name, char **value)
 {
     const char *p;
-    const char *prefix = "";
     size_t len;
     bool is_help = false;
 
@@ -772,23 +775,22 @@ static const char *get_opt_name_value(const char *params,
             *name = g_strdup(firstname);
             p = get_opt_value(params, value);
         } else {
-            /* option without value, must be a flag */
             p = get_opt_name(params, name, len);
-            if (strncmp(*name, "no", 2) == 0) {
-                memmove(*name, *name + 2, strlen(*name + 2) + 1);
-                *value = g_strdup("off");
-                prefix = "no";
-            } else {
+
+            /*
+             * Short-form flags (i.e. without any value) are not
+             * supported, except for two cases:
+             */
+
+            /* the 'help' or '?' flag */
+            is_help = is_help_option(*name);
+            if (is_help) {
                 *value = g_strdup("on");
-                is_help = is_help_option(*name);
             }
-            if (!is_help && warn_on_flag) {
-                warn_report("short-form boolean option '%s%s' deprecated", prefix, *name);
-                if (g_str_equal(*name, "delay")) {
-                    error_printf("Please use nodelay=%s instead\n", prefix[0] ? "on" : "off");
-                } else {
-                    error_printf("Please use %s=%s instead\n", *name, *value);
-                }
+
+            /* a missing, non-implicit key, i.e. a single comma ',' */
+            if (g_str_equal(*name, "") && *p == ',') {
+                *value = g_strdup("on");
             }
         }
     } else {
@@ -811,7 +813,7 @@ static const char *get_opt_name_value(const char *params,
 
 static bool opts_do_parse(QemuOpts *opts, const char *params,
                           const char *firstname,
-                          bool warn_on_flag, bool *help_wanted, Error **errp)
+                          bool *help_wanted, Error **errp)
 {
     const char *p;
     QemuOpt *opt;
@@ -820,7 +822,7 @@ static bool opts_do_parse(QemuOpts *opts, const char *params,
         g_autofree char *option = NULL;
         g_autofree char *value = NULL;
 
-        p = get_opt_name_value(p, firstname, warn_on_flag, help_wanted, &option, &value);
+        p = get_opt_name_value(p, firstname, help_wanted, &option, &value);
         if (help_wanted && *help_wanted) {
             return false;
         }
@@ -848,7 +850,7 @@ static char *opts_parse_id(const char *params)
         g_autofree char *name = NULL;
         g_autofree char *value = NULL;
 
-        p = get_opt_name_value(p, NULL, false, NULL, &name, &value);
+        p = get_opt_name_value(p, NULL, NULL, &name, &value);
         if (!strcmp(name, "id")) {
             return g_steal_pointer(&value);
         }
@@ -866,7 +868,7 @@ bool has_help_option(const char *params)
         g_autofree char *name = NULL;
         g_autofree char *value = NULL;
 
-        p = get_opt_name_value(p, NULL, false, &ret, &name, &value);
+        p = get_opt_name_value(p, NULL, &ret, &name, &value);
         if (ret) {
             return true;
         }
@@ -884,12 +886,11 @@ bool has_help_option(const char *params)
 bool qemu_opts_do_parse(QemuOpts *opts, const char *params,
                        const char *firstname, Error **errp)
 {
-    return opts_do_parse(opts, params, firstname, false, NULL, errp);
+    return opts_do_parse(opts, params, firstname, NULL, errp);
 }
 
 static QemuOpts *opts_parse(QemuOptsList *list, const char *params,
-                            bool permit_abbrev,
-                            bool warn_on_flag, bool *help_wanted, Error **errp)
+                            bool permit_abbrev, bool *help_wanted, Error **errp)
 {
     const char *firstname;
     char *id = opts_parse_id(params);
@@ -904,8 +905,7 @@ static QemuOpts *opts_parse(QemuOptsList *list, const char *params,
         return NULL;
     }
 
-    if (!opts_do_parse(opts, params, firstname,
-                       warn_on_flag, help_wanted, errp)) {
+    if (!opts_do_parse(opts, params, firstname, help_wanted, errp)) {
         qemu_opts_del(opts);
         return NULL;
     }
@@ -923,7 +923,7 @@ static QemuOpts *opts_parse(QemuOptsList *list, const char *params,
 QemuOpts *qemu_opts_parse(QemuOptsList *list, const char *params,
                           bool permit_abbrev, Error **errp)
 {
-    return opts_parse(list, params, permit_abbrev, false, NULL, errp);
+    return opts_parse(list, params, permit_abbrev, NULL, errp);
 }
 
 /**
@@ -941,9 +941,8 @@ QemuOpts *qemu_opts_parse_noisily(QemuOptsList *list, const char *params,
     QemuOpts *opts;
     bool help_wanted = false;
 
-    opts = opts_parse(list, params, permit_abbrev, true,
-                      opts_accepts_any(list) ? NULL : &help_wanted,
-                      &err);
+    opts = opts_parse(list, params, permit_abbrev,
+                      opts_accepts_any(list) ? NULL : &help_wanted, &err);
     if (!opts) {
         assert(!!err + !!help_wanted == 1);
         if (help_wanted) {
-- 
2.53.0


