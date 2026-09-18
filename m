Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3606FC982E0
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 22:31:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7h6D-0007qd-Ku; Fri, 18 Sep 2026 18:30:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1x7h6C-0007px-EX
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 18:30:28 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1x7h6A-0000er-Jc
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 18:30:28 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 301D221EDD;
 Fri, 18 Sep 2026 22:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789770621; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xKw/qSlgEJX8NppOT5mW4Ogp1/OYlPI6vcH8jQThncI=;
 b=1CIaPbNTyyrzsHHT1kvsurHvzyEVQza+/QxQvsOHMNh7iNqHQuYzaUO3rx6i+bCMRjDSHO
 znw0R2cZZj31RPOmVWfeV68NlEy2pahJGiSh3poaxJFbzWgz32vsQyvDgjIBojvk/1odKB
 ROVUFWd96SCugvSE/QBuN2NEOMJazCg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789770621;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xKw/qSlgEJX8NppOT5mW4Ogp1/OYlPI6vcH8jQThncI=;
 b=2w6et1sWOKP3hkmSLV//ddi609/93GuymC+My68UyyL9OggnX+QReABluT14AUyh1m0HmO
 PxBSKhwE6iLaBGDg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=eoAqlQtL;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=xm1uDZZv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789770617; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xKw/qSlgEJX8NppOT5mW4Ogp1/OYlPI6vcH8jQThncI=;
 b=eoAqlQtLhgC3gp4jJs9OKlcu8m1ltA3lF0JKKzhRxvccu21QklDrnrfLfOhYU1IQeXDrG4
 bEI2EUOp2XL+JYEhJlQjMtOqkR1b9PPfWJLk0lOjv7WCQ2J5jm9wnxjOKo3uk60xBn18jH
 JVC+sZvT6tzDwEgfoDqYYZwdRPzPHIw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789770617;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xKw/qSlgEJX8NppOT5mW4Ogp1/OYlPI6vcH8jQThncI=;
 b=xm1uDZZvsTy9Kh9W/9ei789uv9eOx3qPq59eikQuZlHi8ZxMXyUUoulzYpdoZ1UQmlWGX0
 yTv3Sn7a9Yf8ZjCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1E3381348F;
 Fri, 18 Sep 2026 22:30:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id hQIbBW27rWrsdQAAD6G6ig:T8
 (envelope-from <farosas@suse.de>); Fri, 18 Sep 2026 22:30:14 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>
Subject: [RFC PATCH 07/14] qemu-options: Consolidate qemu_opts_parse* functions
Date: Fri, 18 Sep 2026 19:29:54 -0300
Message-ID: <20260918223002.1892021-8-farosas@suse.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260918223002.1892021-1-farosas@suse.de>
References: <20260918223002.1892021-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 301D221EDD
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 URIBL_BLOCKED(0.00)[suse.de:dkim,suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:email,suse.de:mid];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]
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

The qemu_opts_parse, qemu_opts_parse_list and qemu_opts_parse_noisily
functions all call opts_parse(), they can reuse code.

Consolidate them at qemu_opts_parse_list(). Use the presence of the
Error pointer to determine whether the caller wants to be noisy: if
there is an Error pointer, then use it, otherwise print the message.

This makes the code more opaque, so keep the qemu_opts_parse and
qemu_opts_parse_noisily functions as wrappers to make sure the intent
at the callers is still clear.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/unit/test-opts-visitor.c |  2 +-
 util/qemu-option.c             | 32 ++++++++++++++++++--------------
 2 files changed, 19 insertions(+), 15 deletions(-)

diff --git a/tests/unit/test-opts-visitor.c b/tests/unit/test-opts-visitor.c
index a9e45c0251..dd9a8faf12 100644
--- a/tests/unit/test-opts-visitor.c
+++ b/tests/unit/test-opts-visitor.c
@@ -39,7 +39,7 @@ setup_fixture(OptsVisitorFixture *f, gconstpointer test_data)
     QemuOpts *opts;
     Visitor *v;
 
-    opts = qemu_opts_parse("userdef", opts_string, false, NULL);
+    opts = qemu_opts_parse("userdef", opts_string, false, &error_abort);
     g_assert(opts != NULL);
 
     v = opts_visitor_new(opts);
diff --git a/util/qemu-option.c b/util/qemu-option.c
index bb38d305c9..c8e552823b 100644
--- a/util/qemu-option.c
+++ b/util/qemu-option.c
@@ -938,7 +938,23 @@ QemuOpts *qemu_opts_parse(const char *group, const char *params,
 QemuOpts *qemu_opts_parse_list(QemuOptsList *list, const char *params,
                                bool permit_abbrev, Error **errp)
 {
-    return opts_parse(list, params, permit_abbrev, false, false, errp);
+    bool noisily = !errp;
+    QemuOpts *opts = NULL;
+
+    if (noisily) {
+        Error *err = NULL;
+        bool help_wanted = !opts_accepts_any(list);
+
+        opts = opts_parse(list, params, permit_abbrev, true, help_wanted, &err);
+        if (!opts && err) {
+            error_report_err(err);
+        }
+
+    } else {
+        opts = opts_parse(list, params, permit_abbrev, false, false, errp);
+    }
+
+    return opts;
 }
 
 /**
@@ -952,19 +968,7 @@ QemuOpts *qemu_opts_parse_list(QemuOptsList *list, const char *params,
 QemuOpts *qemu_opts_parse_noisily(QemuOptsList *list, const char *params,
                                   bool permit_abbrev)
 {
-    Error *err = NULL;
-    QemuOpts *opts;
-    bool help_wanted = !opts_accepts_any(list);
-
-    opts = opts_parse(list, params, permit_abbrev, true, help_wanted, &err);
-    if (!opts) {
-        if (help_wanted) {
-            assert(!err);
-        } else {
-            error_report_err(err);
-        }
-    }
-    return opts;
+    return qemu_opts_parse_list(list, params, permit_abbrev, NULL);
 }
 
 static bool qemu_opts_from_qdict_entry(QemuOpts *opts,
-- 
2.53.0


