Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D647DC982D8
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 22:31:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7h6D-0007qZ-HY; Fri, 18 Sep 2026 18:30:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1x7h69-0007oy-ME
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 18:30:26 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1x7h66-0000ak-4C
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 18:30:25 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 4EC8821EE3;
 Fri, 18 Sep 2026 22:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789770616; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uA9hjfjuOrCCUYezr2q3PaqiVZaDD2CfYnNvjnCwzDA=;
 b=Y9G5v+p1kT/IYPYSjw6TyG8jlegSJfJLuOliy/3ow3Nf5NlM6zXJGM0aAbwRDHJhR8K4DC
 uV83CUFKhi1cFh9UYmcpU/v2l7n/j7WfEgpYNG+HUytiVtBZiFI7aYDhrcjP93T8AJ2P75
 4FyBmGIAG2reXxVoBr8NiiFxqhgbsO8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789770616;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uA9hjfjuOrCCUYezr2q3PaqiVZaDD2CfYnNvjnCwzDA=;
 b=L0Nf8CEtHUWYIPq5LgpOraejtsj0Qcs9ySEDDRCTwxYgSmylhE34Ik8iZ3jylPXb3K6T1c
 DkDOK9Hv3IrlamDw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=jLWmSEZc;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=rnaIfz8R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789770612; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uA9hjfjuOrCCUYezr2q3PaqiVZaDD2CfYnNvjnCwzDA=;
 b=jLWmSEZcFWfTWw/Qm1QkTN7+GddsGiWr935/ongJVTeHy6kkNO1d4m3Azf/R+zXkU9WTyp
 1i7xQNOVz6MrQcTM7+NKYAUtDhC56P5wtzUuI+RZKhTbkZZkg6mh0N2Yfpv83Gtru+LJ/Z
 smi6dl+/sf/E6TgpKQuLf71lQMt3SJs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789770612;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uA9hjfjuOrCCUYezr2q3PaqiVZaDD2CfYnNvjnCwzDA=;
 b=rnaIfz8RNNPfwWQmAsQjT553t/2fOmZQhVuCKwScABIQyPQXkus7ErzQvvqviEqJdT710L
 l285gvbLhAnO3bCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1F144139B3;
 Fri, 18 Sep 2026 22:30:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id hQIbBW27rWrsdQAAD6G6ig:T5
 (envelope-from <farosas@suse.de>); Fri, 18 Sep 2026 22:30:10 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [RFC PATCH 04/14] qemu-options: Add qemu_opts_parse_list
Date: Fri, 18 Sep 2026 19:29:51 -0300
Message-ID: <20260918223002.1892021-5-farosas@suse.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260918223002.1892021-1-farosas@suse.de>
References: <20260918223002.1892021-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4EC8821EE3
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 ARC_NA(0.00)[]; FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[3]; DKIM_TRACE(0.00)[suse.de:+]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
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

Currently the qemu_opts_parse and qemu_opts_parse_noisily functions
are called in one two ways:

1) qemu_opts_parse|_noisily(&some_group_list, ...)
2) qemu_opts_parse|_noisily(qemu_find_opts("some_opt"), ...)

The second form is problematic. Having the result of qemu_find_opts()
going directly into the first argument makes it difficult to handle a
possible NULL pointer retuned by it.

Next patches will change qemu_opts_parse() and
qemu_opts_parse_noisily() to receive the option name and call
qemu_find_opts() in their body so the return of the function can be
handled properly.

Add a new qemu_opts_parse_list() and change all callsites that pass
the list directly to use it. In the next patches this new _list
version will become the inner function, but at this point, simply make
it defer to qemu_opts_parse() to make the refactoring easier.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 include/qemu/option.h       |   2 +
 tests/unit/test-qemu-opts.c | 169 +++++++++++++++++++-----------------
 util/qemu-option.c          |  13 +++
 util/qemu-sockets.c         |   2 +-
 4 files changed, 104 insertions(+), 82 deletions(-)

diff --git a/include/qemu/option.h b/include/qemu/option.h
index 9a00ac0a35..f96d9fae42 100644
--- a/include/qemu/option.h
+++ b/include/qemu/option.h
@@ -132,6 +132,8 @@ QemuOpts *qemu_opts_parse_noisily(QemuOptsList *list, const char *params,
                                   bool permit_abbrev);
 QemuOpts *qemu_opts_parse(QemuOptsList *list, const char *params,
                           bool permit_abbrev, Error **errp);
+QemuOpts *qemu_opts_parse_list(QemuOptsList *list, const char *params,
+                               bool permit_abbrev, Error **errp);
 QemuOpts *qemu_opts_from_qdict(QemuOptsList *list, const QDict *qdict,
                                Error **errp);
 QDict *qemu_opts_to_qdict_filtered(QemuOpts *opts, QDict *qdict,
diff --git a/tests/unit/test-qemu-opts.c b/tests/unit/test-qemu-opts.c
index 8d03a69f7c..1257ef750b 100644
--- a/tests/unit/test-qemu-opts.c
+++ b/tests/unit/test-qemu-opts.c
@@ -349,7 +349,7 @@ static void test_qemu_opt_unset(void)
     int ret;
 
     /* dynamically initialized (parsed) opts */
-    opts = qemu_opts_parse(&opts_list_03, "key=value", false, NULL);
+    opts = qemu_opts_parse_list(&opts_list_03, "key=value", false, NULL);
     g_assert(opts != NULL);
 
     /* check default/parsed value */
@@ -431,95 +431,96 @@ static void test_opts_parse(void)
     QemuOpts *opts;
 
     /* Nothing */
-    opts = qemu_opts_parse(&opts_list_03, "", false, &error_abort);
+    opts = qemu_opts_parse_list(&opts_list_03, "", false, &error_abort);
     g_assert_cmpuint(opts_count(opts), ==, 0);
 
     /* Empty key */
-    opts = qemu_opts_parse(&opts_list_03, "=val", false, &error_abort);
+    opts = qemu_opts_parse_list(&opts_list_03, "=val", false, &error_abort);
     g_assert_cmpuint(opts_count(opts), ==, 1);
     g_assert_cmpstr(qemu_opt_get(opts, ""), ==, "val");
 
     /* Multiple keys, last one wins */
-    opts = qemu_opts_parse(&opts_list_03, "a=1,b=2,,x,a=3",
-                           false, &error_abort);
+    opts = qemu_opts_parse_list(&opts_list_03, "a=1,b=2,,x,a=3",
+                                false, &error_abort);
     g_assert_cmpuint(opts_count(opts), ==, 3);
     g_assert_cmpstr(qemu_opt_get(opts, "a"), ==, "3");
     g_assert_cmpstr(qemu_opt_get(opts, "b"), ==, "2,x");
 
     /* Except when it doesn't */
-    opts = qemu_opts_parse(&opts_list_03, "id=foo,id=bar",
-                           false, &error_abort);
+    opts = qemu_opts_parse_list(&opts_list_03, "id=foo,id=bar",
+                                false, &error_abort);
     g_assert_cmpuint(opts_count(opts), ==, 0);
     g_assert_cmpstr(qemu_opts_id(opts), ==, "foo");
 
     /* TODO Cover low-level access to repeated keys */
 
     /* Trailing comma is ignored */
-    opts = qemu_opts_parse(&opts_list_03, "x=y,", false, &error_abort);
+    opts = qemu_opts_parse_list(&opts_list_03, "x=y,", false, &error_abort);
     g_assert_cmpuint(opts_count(opts), ==, 1);
     g_assert_cmpstr(qemu_opt_get(opts, "x"), ==, "y");
 
     /* Except when it isn't */
-    opts = qemu_opts_parse(&opts_list_03, ",", false, &error_abort);
+    opts = qemu_opts_parse_list(&opts_list_03, ",", false, &error_abort);
     g_assert_cmpuint(opts_count(opts), ==, 1);
     g_assert_cmpstr(qemu_opt_get(opts, ""), ==, "on");
 
     /* Duplicate ID */
-    opts = qemu_opts_parse(&opts_list_03, "x=y,id=foo", false, &err);
+    opts = qemu_opts_parse_list(&opts_list_03, "x=y,id=foo", false, &err);
     error_free_or_abort(&err);
     g_assert(!opts);
     /* TODO Cover .merge_lists = true */
 
     /* Buggy ID recognition (fixed) */
-    opts = qemu_opts_parse(&opts_list_03, "x=,,id=bar", false, &error_abort);
+    opts = qemu_opts_parse_list(&opts_list_03, "x=,,id=bar", false,
+                                &error_abort);
     g_assert_cmpuint(opts_count(opts), ==, 1);
     g_assert(!qemu_opts_id(opts));
     g_assert_cmpstr(qemu_opt_get(opts, "x"), ==, ",id=bar");
 
     /* Anti-social ID */
-    opts = qemu_opts_parse(&opts_list_01, "id=666", false, &err);
+    opts = qemu_opts_parse_list(&opts_list_01, "id=666", false, &err);
     error_free_or_abort(&err);
     g_assert(!opts);
 
     /* Implied value (qemu_opts_parse warns but accepts it) */
-    opts = qemu_opts_parse(&opts_list_03, "an,noaus,noaus=",
-                           false, &error_abort);
+    opts = qemu_opts_parse_list(&opts_list_03, "an,noaus,noaus=",
+                                false, &error_abort);
     g_assert_cmpuint(opts_count(opts), ==, 3);
     g_assert_cmpstr(qemu_opt_get(opts, "an"), ==, "on");
     g_assert_cmpstr(qemu_opt_get(opts, "aus"), ==, "off");
     g_assert_cmpstr(qemu_opt_get(opts, "noaus"), ==, "");
 
     /* Implied value, negated empty key */
-    opts = qemu_opts_parse(&opts_list_03, "no", false, &error_abort);
+    opts = qemu_opts_parse_list(&opts_list_03, "no", false, &error_abort);
     g_assert_cmpuint(opts_count(opts), ==, 1);
     g_assert_cmpstr(qemu_opt_get(opts, ""), ==, "off");
 
     /* Implied key */
-    opts = qemu_opts_parse(&opts_list_03, "an,noaus,noaus=", true,
-                           &error_abort);
+    opts = qemu_opts_parse_list(&opts_list_03, "an,noaus,noaus=", true,
+                                &error_abort);
     g_assert_cmpuint(opts_count(opts), ==, 3);
     g_assert_cmpstr(qemu_opt_get(opts, "implied"), ==, "an");
     g_assert_cmpstr(qemu_opt_get(opts, "aus"), ==, "off");
     g_assert_cmpstr(qemu_opt_get(opts, "noaus"), ==, "");
 
     /* Implied key with empty value */
-    opts = qemu_opts_parse(&opts_list_03, ",", true, &error_abort);
+    opts = qemu_opts_parse_list(&opts_list_03, ",", true, &error_abort);
     g_assert_cmpuint(opts_count(opts), ==, 1);
     g_assert_cmpstr(qemu_opt_get(opts, "implied"), ==, "");
 
     /* Implied key with comma value */
-    opts = qemu_opts_parse(&opts_list_03, ",,,a=1", true, &error_abort);
+    opts = qemu_opts_parse_list(&opts_list_03, ",,,a=1", true, &error_abort);
     g_assert_cmpuint(opts_count(opts), ==, 2);
     g_assert_cmpstr(qemu_opt_get(opts, "implied"), ==, ",");
     g_assert_cmpstr(qemu_opt_get(opts, "a"), ==, "1");
 
     /* Empty key is not an implied key */
-    opts = qemu_opts_parse(&opts_list_03, "=val", true, &error_abort);
+    opts = qemu_opts_parse_list(&opts_list_03, "=val", true, &error_abort);
     g_assert_cmpuint(opts_count(opts), ==, 1);
     g_assert_cmpstr(qemu_opt_get(opts, ""), ==, "val");
 
     /* Unknown key */
-    opts = qemu_opts_parse(&opts_list_01, "nonexistent=", false, &err);
+    opts = qemu_opts_parse_list(&opts_list_01, "nonexistent=", false, &err);
     error_free_or_abort(&err);
     g_assert(!opts);
 
@@ -532,13 +533,13 @@ static void test_opts_parse_bool(void)
     Error *err = NULL;
     QemuOpts *opts;
 
-    opts = qemu_opts_parse(&opts_list_02, "bool1=on,bool2=off",
-                           false, &error_abort);
+    opts = qemu_opts_parse_list(&opts_list_02, "bool1=on,bool2=off",
+                                false, &error_abort);
     g_assert_cmpuint(opts_count(opts), ==, 2);
     g_assert(qemu_opt_get_bool(opts, "bool1", false));
     g_assert(!qemu_opt_get_bool(opts, "bool2", true));
 
-    opts = qemu_opts_parse(&opts_list_02, "bool1=offer", false, &err);
+    opts = qemu_opts_parse_list(&opts_list_02, "bool1=offer", false, &err);
     error_free_or_abort(&err);
     g_assert(!opts);
 
@@ -551,59 +552,60 @@ static void test_opts_parse_number(void)
     QemuOpts *opts;
 
     /* Lower limit zero */
-    opts = qemu_opts_parse(&opts_list_01, "number1=0", false, &error_abort);
+    opts = qemu_opts_parse_list(&opts_list_01, "number1=0", false,
+                                &error_abort);
     g_assert_cmpuint(opts_count(opts), ==, 1);
     g_assert_cmpuint(qemu_opt_get_number(opts, "number1", 1), ==, 0);
 
     /* Upper limit 2^64-1 */
-    opts = qemu_opts_parse(&opts_list_01,
-                           "number1=18446744073709551615,number2=-1",
-                           false, &error_abort);
+    opts = qemu_opts_parse_list(&opts_list_01,
+                                "number1=18446744073709551615,number2=-1",
+                                false, &error_abort);
     g_assert_cmpuint(opts_count(opts), ==, 2);
     g_assert_cmphex(qemu_opt_get_number(opts, "number1", 1), ==, UINT64_MAX);
     g_assert_cmphex(qemu_opt_get_number(opts, "number2", 0), ==, UINT64_MAX);
 
     /* Above upper limit */
-    opts = qemu_opts_parse(&opts_list_01, "number1=18446744073709551616",
-                           false, &err);
+    opts = qemu_opts_parse_list(&opts_list_01, "number1=18446744073709551616",
+                                false, &err);
     error_free_or_abort(&err);
     g_assert(!opts);
 
     /* Below lower limit */
-    opts = qemu_opts_parse(&opts_list_01, "number1=-18446744073709551616",
-                           false, &err);
+    opts = qemu_opts_parse_list(&opts_list_01, "number1=-18446744073709551616",
+                                false, &err);
     error_free_or_abort(&err);
     g_assert(!opts);
 
     /* Hex and octal */
-    opts = qemu_opts_parse(&opts_list_01, "number1=0x2a,number2=052",
-                           false, &error_abort);
+    opts = qemu_opts_parse_list(&opts_list_01, "number1=0x2a,number2=052",
+                                false, &error_abort);
     g_assert_cmpuint(opts_count(opts), ==, 2);
     g_assert_cmpuint(qemu_opt_get_number(opts, "number1", 1), ==, 42);
     g_assert_cmpuint(qemu_opt_get_number(opts, "number2", 0), ==, 42);
 
     /* Invalid */
-    opts = qemu_opts_parse(&opts_list_01, "number1=", false, &err);
+    opts = qemu_opts_parse_list(&opts_list_01, "number1=", false, &err);
     error_free_or_abort(&err);
     g_assert(!opts);
-    opts = qemu_opts_parse(&opts_list_01, "number1=eins", false, &err);
+    opts = qemu_opts_parse_list(&opts_list_01, "number1=eins", false, &err);
     error_free_or_abort(&err);
     g_assert(!opts);
 
     /* Leading whitespace */
-    opts = qemu_opts_parse(&opts_list_01, "number1= \t42",
-                           false, &error_abort);
+    opts = qemu_opts_parse_list(&opts_list_01, "number1= \t42",
+                                false, &error_abort);
     g_assert_cmpuint(opts_count(opts), ==, 1);
     g_assert_cmpuint(qemu_opt_get_number(opts, "number1", 1), ==, 42);
 
     /* Trailing crap */
-    opts = qemu_opts_parse(&opts_list_01, "number1=3.14", false, &err);
+    opts = qemu_opts_parse_list(&opts_list_01, "number1=3.14", false, &err);
     error_free_or_abort(&err);
     g_assert(!opts);
-    opts = qemu_opts_parse(&opts_list_01, "number1=08", false, &err);
+    opts = qemu_opts_parse_list(&opts_list_01, "number1=08", false, &err);
     error_free_or_abort(&err);
     g_assert(!opts);
-    opts = qemu_opts_parse(&opts_list_01, "number1=0 ", false, &err);
+    opts = qemu_opts_parse_list(&opts_list_01, "number1=0 ", false, &err);
     error_free_or_abort(&err);
     g_assert(!opts);
 
@@ -616,18 +618,18 @@ static void test_opts_parse_size(void)
     QemuOpts *opts;
 
     /* Lower limit zero */
-    opts = qemu_opts_parse(&opts_list_02, "size1=0", false, &error_abort);
+    opts = qemu_opts_parse_list(&opts_list_02, "size1=0", false, &error_abort);
     g_assert_cmpuint(opts_count(opts), ==, 1);
     g_assert_cmpuint(qemu_opt_get_size(opts, "size1", 1), ==, 0);
 
     /* Note: full 64 bits of precision */
 
     /* Around double limit of precision: 2^53-1, 2^53, 2^53+1 */
-    opts = qemu_opts_parse(&opts_list_02,
-                           "size1=9007199254740991,"
-                           "size2=9007199254740992,"
-                           "size3=9007199254740993",
-                           false, &error_abort);
+    opts = qemu_opts_parse_list(&opts_list_02,
+                                "size1=9007199254740991,"
+                                "size2=9007199254740992,"
+                                "size3=9007199254740993",
+                                false, &error_abort);
     g_assert_cmpuint(opts_count(opts), ==, 3);
     g_assert_cmphex(qemu_opt_get_size(opts, "size1", 1),
                      ==, 0x1fffffffffffff);
@@ -637,11 +639,12 @@ static void test_opts_parse_size(void)
                      ==, 0x20000000000001);
 
     /* Close to signed int limit: 2^63-1, 2^63, 2^63+1 */
-    opts = qemu_opts_parse(&opts_list_02,
-                           "size1=9223372036854775807," /* 7fffffffffffffff */
-                           "size2=9223372036854775808," /* 8000000000000000 */
-                           "size3=9223372036854775809", /* 8000000000000001 */
-                           false, &error_abort);
+    opts = qemu_opts_parse_list(
+        &opts_list_02,
+        "size1=9223372036854775807," /* 7fffffffffffffff */
+        "size2=9223372036854775808," /* 8000000000000000 */
+        "size3=9223372036854775809", /* 8000000000000001 */
+        false, &error_abort);
     g_assert_cmpuint(opts_count(opts), ==, 3);
     g_assert_cmphex(qemu_opt_get_size(opts, "size1", 1),
                      ==, 0x7fffffffffffffff);
@@ -651,10 +654,11 @@ static void test_opts_parse_size(void)
                      ==, 0x8000000000000001);
 
     /* Close to actual upper limit 0xfffffffffffff800 (53 msbs set) */
-    opts = qemu_opts_parse(&opts_list_02,
-                           "size1=18446744073709549568," /* fffffffffffff800 */
-                           "size2=18446744073709550591", /* fffffffffffffbff */
-                           false, &error_abort);
+    opts = qemu_opts_parse_list(
+        &opts_list_02,
+        "size1=18446744073709549568," /* fffffffffffff800 */
+        "size2=18446744073709550591", /* fffffffffffffbff */
+        false, &error_abort);
     g_assert_cmpuint(opts_count(opts), ==, 2);
     g_assert_cmphex(qemu_opt_get_size(opts, "size1", 1),
                      ==, 0xfffffffffffff800);
@@ -662,47 +666,48 @@ static void test_opts_parse_size(void)
                      ==, 0xfffffffffffffbff);
 
     /* Actual limit, 2^64-1 */
-    opts = qemu_opts_parse(&opts_list_02,
-                           "size1=18446744073709551615", /* ffffffffffffffff */
-                           false, &error_abort);
+    opts = qemu_opts_parse_list(
+        &opts_list_02,
+        "size1=18446744073709551615", /* ffffffffffffffff */
+        false, &error_abort);
     g_assert_cmpuint(opts_count(opts), ==, 1);
     g_assert_cmphex(qemu_opt_get_size(opts, "size1", 1),
                      ==, 0xffffffffffffffff);
 
     /* Beyond limits */
-    opts = qemu_opts_parse(&opts_list_02, "size1=-1", false, &err);
+    opts = qemu_opts_parse_list(&opts_list_02, "size1=-1", false, &err);
     error_free_or_abort(&err);
     g_assert(!opts);
-    opts = qemu_opts_parse(&opts_list_02,
-                           "size1=18446744073709551616", /* 2^64 */
-                           false, &err);
+    opts = qemu_opts_parse_list(&opts_list_02,
+                                "size1=18446744073709551616", /* 2^64 */
+                                false, &err);
     error_free_or_abort(&err);
     g_assert(!opts);
 
     /* Suffixes */
-    opts = qemu_opts_parse(&opts_list_02, "size1=8b,size2=1.5k,size3=2M",
-                           false, &error_abort);
+    opts = qemu_opts_parse_list(&opts_list_02, "size1=8b,size2=1.5k,size3=2M",
+                                false, &error_abort);
     g_assert_cmpuint(opts_count(opts), ==, 3);
     g_assert_cmphex(qemu_opt_get_size(opts, "size1", 0), ==, 8);
     g_assert_cmphex(qemu_opt_get_size(opts, "size2", 0), ==, 1536);
     g_assert_cmphex(qemu_opt_get_size(opts, "size3", 0), ==, 2 * MiB);
-    opts = qemu_opts_parse(&opts_list_02, "size1=0.1G,size2=16777215T",
-                           false, &error_abort);
+    opts = qemu_opts_parse_list(&opts_list_02, "size1=0.1G,size2=16777215T",
+                                false, &error_abort);
     g_assert_cmpuint(opts_count(opts), ==, 2);
     g_assert_cmphex(qemu_opt_get_size(opts, "size1", 0), ==, GiB / 10);
     g_assert_cmphex(qemu_opt_get_size(opts, "size2", 0), ==, 16777215ULL * TiB);
 
     /* Beyond limit with suffix */
-    opts = qemu_opts_parse(&opts_list_02, "size1=16777216T",
-                           false, &err);
+    opts = qemu_opts_parse_list(&opts_list_02, "size1=16777216T",
+                                false, &err);
     error_free_or_abort(&err);
     g_assert(!opts);
 
     /* Trailing crap */
-    opts = qemu_opts_parse(&opts_list_02, "size1=16E", false, &err);
+    opts = qemu_opts_parse_list(&opts_list_02, "size1=16E", false, &err);
     error_free_or_abort(&err);
     g_assert(!opts);
-    opts = qemu_opts_parse(&opts_list_02, "size1=16Gi", false, &err);
+    opts = qemu_opts_parse_list(&opts_list_02, "size1=16Gi", false, &err);
     error_free_or_abort(&err);
     g_assert(!opts);
 
@@ -737,13 +742,13 @@ static void test_has_help_option(void)
     for (i = 0; i < ARRAY_SIZE(test); i++) {
         g_assert_cmpint(has_help_option(test[i].params),
                         ==, test[i].expect);
-        opts = qemu_opts_parse(&opts_list_03, test[i].params, false,
-                               &error_abort);
+        opts = qemu_opts_parse_list(&opts_list_03, test[i].params, false,
+                                    &error_abort);
         g_assert_cmpint(qemu_opt_has_help_opt(opts),
                         ==, test[i].expect);
         qemu_opts_del(opts);
-        opts = qemu_opts_parse(&opts_list_03, test[i].params, true,
-                               &error_abort);
+        opts = qemu_opts_parse_list(&opts_list_03, test[i].params, true,
+                                    &error_abort);
         g_assert_cmpint(qemu_opt_has_help_opt(opts),
                         ==, test[i].expect_implied);
         qemu_opts_del(opts);
@@ -877,8 +882,9 @@ static void test_opts_to_qdict_basic(void)
     QemuOpts *opts;
     QDict *dict;
 
-    opts = qemu_opts_parse(&opts_list_01, "str1=foo,str2=,str3=bar,number1=42",
-                           false, &error_abort);
+    opts = qemu_opts_parse_list(&opts_list_01,
+                                "str1=foo,str2=,str3=bar,number1=42",
+                                false, &error_abort);
     g_assert(opts != NULL);
 
     dict = qemu_opts_to_qdict(opts, NULL);
@@ -903,9 +909,9 @@ static void test_opts_to_qdict_filtered(void)
     first = qemu_opts_append(NULL, &opts_list_02);
     merged = qemu_opts_append(first, &opts_list_01);
 
-    opts = qemu_opts_parse(merged,
-                           "str1=foo,str2=,str3=bar,bool1=off,number1=42",
-                           false, &error_abort);
+    opts = qemu_opts_parse_list(
+        merged, "str1=foo,str2=,str3=bar,bool1=off,number1=42",
+        false, &error_abort);
     g_assert(opts != NULL);
 
     /* Convert to QDict without deleting from opts */
@@ -962,7 +968,8 @@ static void test_opts_to_qdict_duplicates(void)
     QemuOpt *opt;
     QDict *dict;
 
-    opts = qemu_opts_parse(&opts_list_03, "foo=a,foo=b", false, &error_abort);
+    opts = qemu_opts_parse_list(&opts_list_03, "foo=a,foo=b", false,
+                                &error_abort);
     g_assert(opts != NULL);
 
     /* Verify that opts has two options with the same name */
diff --git a/util/qemu-option.c b/util/qemu-option.c
index e115e1acef..aa879b78f8 100644
--- a/util/qemu-option.c
+++ b/util/qemu-option.c
@@ -922,6 +922,19 @@ QemuOpts *qemu_opts_parse(QemuOptsList *list, const char *params,
     return opts_parse(list, params, permit_abbrev, false, NULL, errp);
 }
 
+/**
+ * Create a QemuOpts from @list with options parsed from @params.  If
+ * @permit_abbrev, the first key=value in @params may omit key= and is
+ * treated as if key was @list->implied_opt_name.  On error, store an
+ * error object through @errp if non-null.  Return the new QemuOpts on
+ * success, null pointer on error.
+ */
+QemuOpts *qemu_opts_parse_list(QemuOptsList *list, const char *params,
+                               bool permit_abbrev, Error **errp)
+{
+    return qemu_opts_parse(list, params, permit_abbrev, errp);
+}
+
 /**
  * Create a QemuOpts in @list and with options parsed from @params.
  * If @permit_abbrev, the first key=value in @params may omit key=,
diff --git a/util/qemu-sockets.c b/util/qemu-sockets.c
index 4773755fd5..30226671a9 100644
--- a/util/qemu-sockets.c
+++ b/util/qemu-sockets.c
@@ -704,7 +704,7 @@ static QemuOptsList inet_opts = {
 
 int inet_parse(InetSocketAddress *addr, const char *str, Error **errp)
 {
-    QemuOpts *opts = qemu_opts_parse(&inet_opts, str, true, errp);
+    QemuOpts *opts = qemu_opts_parse_list(&inet_opts, str, true, errp);
     if (!opts) {
         return -1;
     }
-- 
2.53.0


