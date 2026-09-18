Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4471DC982D7
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 22:31:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7h6G-0007rM-1p; Fri, 18 Sep 2026 18:30:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1x7h6B-0007p7-5Q
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 18:30:27 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1x7h68-0000e7-Oz
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 18:30:26 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E1A5021EE4;
 Fri, 18 Sep 2026 22:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789770619; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZohqxSeG85RlIE5adOBOVsTbnvnONZx0NzBIm2rUcc4=;
 b=yZQOnRPD+RJEZTHgDTCaoeAVzAHo++N2RuGAZMFLr0mRXUm2a7HxJvnLkeVUPQ/lH6Nc+m
 tRZeM0ZsuBU1DrjpaB0J+siIY0mjLxyXz8A86vV4U8n1tiJjNwA61A8aENsYkDgT3Qok4I
 k+Rmu5x7fUss6kZGWMzRvqhXb8jJlTA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789770619;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZohqxSeG85RlIE5adOBOVsTbnvnONZx0NzBIm2rUcc4=;
 b=9L7ibfyXJK737bohFI8rAU80rYEmTK2hQPwkMyUuXF03vdQ0e1lQTqHyDKaKi/VmnKn1pt
 TgF1jwc3PCpGJ2Dg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=TFk7Ke0H;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=v+MCsqP5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789770614; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZohqxSeG85RlIE5adOBOVsTbnvnONZx0NzBIm2rUcc4=;
 b=TFk7Ke0HIahpECzK95TTzMZ51tQbwIuVh9zbCqNFKsxG64Vsqs6KAPe2uZPUWaI42yrKAV
 MnsmQJxCoHLNwzqssOMgoQhxaggV0qJHg2LituL9jtp7+1thftaq5hGgtgqH+ECvcOTpbb
 iIg01+mWPTH7jLUxGgssx6qO8evNdNA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789770614;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZohqxSeG85RlIE5adOBOVsTbnvnONZx0NzBIm2rUcc4=;
 b=v+MCsqP5eK2N24VBYQcritInVAGCmeTy9rAZ7mpvTT9USC4GAN5QOEV7drDoVdyHnZRKcg
 UlyAoL7hlzj80tAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 71B94139B6;
 Fri, 18 Sep 2026 22:30:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id hQIbBW27rWrsdQAAD6G6ig:T6
 (envelope-from <farosas@suse.de>); Fri, 18 Sep 2026 22:30:12 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Michael Roth <michael.roth@amd.com>
Subject: [RFC PATCH 05/14] qemu-options: Change qemu_parse_opts() to take the
 group name
Date: Fri, 18 Sep 2026 19:29:52 -0300
Message-ID: <20260918223002.1892021-6-farosas@suse.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260918223002.1892021-1-farosas@suse.de>
References: <20260918223002.1892021-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E1A5021EE4
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
 RCPT_COUNT_THREE(0.00)[4]; DKIM_TRACE(0.00)[suse.de:+]
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

Get rid of the pattern qemu_parse_opts(qemu_find_opts("some-opt")) by
passing the string directly to qemu_parse_opts().

Don't check for NULL list at this time to preserve the old behavior. A
subsequent patch will correct that.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 include/qemu/option.h          |  2 +-
 system/vl.c                    |  5 ++---
 tests/unit/test-opts-visitor.c | 12 ++++--------
 util/qemu-option.c             | 19 +++++++++++--------
 4 files changed, 18 insertions(+), 20 deletions(-)

diff --git a/include/qemu/option.h b/include/qemu/option.h
index f96d9fae42..dfe0d9b893 100644
--- a/include/qemu/option.h
+++ b/include/qemu/option.h
@@ -130,7 +130,7 @@ bool qemu_opts_do_parse(QemuOpts *opts, const char *params,
                         const char *firstname, Error **errp);
 QemuOpts *qemu_opts_parse_noisily(QemuOptsList *list, const char *params,
                                   bool permit_abbrev);
-QemuOpts *qemu_opts_parse(QemuOptsList *list, const char *params,
+QemuOpts *qemu_opts_parse(const char *group, const char *params,
                           bool permit_abbrev, Error **errp);
 QemuOpts *qemu_opts_parse_list(QemuOptsList *list, const char *params,
                                bool permit_abbrev, Error **errp);
diff --git a/system/vl.c b/system/vl.c
index 9bd7664b85..239c537e45 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -1441,10 +1441,9 @@ static void qemu_create_default_devices(void)
     }
 
     if (default_net) {
-        QemuOptsList *net = qemu_find_opts("net");
-        qemu_opts_parse(net, "nic", true, &error_abort);
+        qemu_opts_parse("net", "nic", true, &error_abort);
 #ifdef CONFIG_SLIRP
-        qemu_opts_parse(net, "user", true, &error_abort);
+        qemu_opts_parse("net", "user", true, &error_abort);
 #endif
     }
 
diff --git a/tests/unit/test-opts-visitor.c b/tests/unit/test-opts-visitor.c
index 23e897061c..a9e45c0251 100644
--- a/tests/unit/test-opts-visitor.c
+++ b/tests/unit/test-opts-visitor.c
@@ -39,8 +39,7 @@ setup_fixture(OptsVisitorFixture *f, gconstpointer test_data)
     QemuOpts *opts;
     Visitor *v;
 
-    opts = qemu_opts_parse(qemu_find_opts("userdef"), opts_string, false,
-                           NULL);
+    opts = qemu_opts_parse("userdef", opts_string, false, NULL);
     g_assert(opts != NULL);
 
     v = opts_visitor_new(opts);
@@ -181,8 +180,7 @@ test_opts_range_unvisited(void)
     QemuOpts *opts;
     Visitor *v;
 
-    opts = qemu_opts_parse(qemu_find_opts("userdef"), "ilist=0-2", false,
-                           &error_abort);
+    opts = qemu_opts_parse("userdef", "ilist=0-2", false, &error_abort);
 
     v = opts_visitor_new(opts);
 
@@ -222,8 +220,7 @@ test_opts_range_beyond(void)
     Visitor *v;
     int64_t val;
 
-    opts = qemu_opts_parse(qemu_find_opts("userdef"), "ilist=0", false,
-                           &error_abort);
+    opts = qemu_opts_parse("userdef", "ilist=0", false, &error_abort);
 
     v = opts_visitor_new(opts);
 
@@ -257,8 +254,7 @@ test_opts_dict_unvisited(void)
     Visitor *v;
     UserDefOptions *userdef;
 
-    opts = qemu_opts_parse(qemu_find_opts("userdef"), "i64x=0,bogus=1", false,
-                           &error_abort);
+    opts = qemu_opts_parse("userdef", "i64x=0,bogus=1", false, &error_abort);
 
     v = opts_visitor_new(opts);
     visit_type_UserDefOptions(v, NULL, &userdef, &err);
diff --git a/util/qemu-option.c b/util/qemu-option.c
index aa879b78f8..2c23841376 100644
--- a/util/qemu-option.c
+++ b/util/qemu-option.c
@@ -26,6 +26,7 @@
 #include "qemu/osdep.h"
 
 #include "qapi/error.h"
+#include "qemu/config-file.h"
 #include "qemu/error-report.h"
 #include "qobject/qbool.h"
 #include "qobject/qdict.h"
@@ -910,16 +911,18 @@ static QemuOpts *opts_parse(QemuOptsList *list, const char *params,
 }
 
 /**
- * Create a QemuOpts in @list and with options parsed from @params.
- * If @permit_abbrev, the first key=value in @params may omit key=,
- * and is treated as if key was @list->implied_opt_name.
- * On error, store an error object through @errp if non-null.
- * Return the new QemuOpts on success, null pointer on error.
+ * Find the @group and create a QemuOpts with options parsed from
+ * @params.  If @permit_abbrev, the first key=value in @params may
+ * omit key=.  On error, store an error object through @errp if
+ * non-null.  Return the new QemuOpts on success, null pointer on
+ * error.
  */
-QemuOpts *qemu_opts_parse(QemuOptsList *list, const char *params,
+QemuOpts *qemu_opts_parse(const char *group, const char *params,
                           bool permit_abbrev, Error **errp)
 {
-    return opts_parse(list, params, permit_abbrev, false, NULL, errp);
+    QemuOptsList *list = qemu_find_opts_err(group, errp);
+
+    return qemu_opts_parse_list(list, params, permit_abbrev, errp);
 }
 
 /**
@@ -932,7 +935,7 @@ QemuOpts *qemu_opts_parse(QemuOptsList *list, const char *params,
 QemuOpts *qemu_opts_parse_list(QemuOptsList *list, const char *params,
                                bool permit_abbrev, Error **errp)
 {
-    return qemu_opts_parse(list, params, permit_abbrev, errp);
+    return opts_parse(list, params, permit_abbrev, false, NULL, errp);
 }
 
 /**
-- 
2.53.0


