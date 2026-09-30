Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D51BCA5FC4
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 22:13:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xC2Wi-0007wA-MH; Wed, 30 Sep 2026 18:11:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1xC2Wg-0007vq-C2
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 18:11:46 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1xC2Wd-00052M-O3
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 18:11:45 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B352221F52;
 Wed, 30 Sep 2026 22:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1790806297; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vdgtygysyR7XstxwHmcdv3SLotaep1DmOn9ckWztz7A=;
 b=AgRmtRzeP+bxXC51qTAiFKytW32IbpTFZPqZifb6WIXgJfPnHhNq0LqxSXS3zlnsAK1pLE
 ONyJCh5OKl2xn9qC5VPKmtrR0BTJSeVWXrpNH8ajPqm5SJOGQkdBYt9tBwiXDk8x9mTvw3
 4UzaTOXyNCIhv3UyDBB1LsXGNNpPblE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1790806297;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vdgtygysyR7XstxwHmcdv3SLotaep1DmOn9ckWztz7A=;
 b=43bSZi0f/1Xm02HkjLXO0FdHtVqDhzItfbFba0UNPLuiYZEDdFBk1dt7980B2N/Cp+tlJs
 yHZc1IBJn9i6ibBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1790806293; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vdgtygysyR7XstxwHmcdv3SLotaep1DmOn9ckWztz7A=;
 b=x2c1KJ4YVP/2pCVHm8TWBAO0OWq/2zu7NMxHLLIWfMhYUeQHH4AXKPFq2cDNQuH5epgiwB
 vudWVB3WHbqF1KSF7U8pRtM7Q6KWS6U9upvzaEf67HcXRqrYvXycj3AQMa5JuMprHhpICI
 MzdDGjR5Y+PFz9HQZVh7+1AEscKGzkc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1790806293;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vdgtygysyR7XstxwHmcdv3SLotaep1DmOn9ckWztz7A=;
 b=OwG2psBn4xvcqKCSD0gXl95fqqp1hLcheAIRXaXGBA7gWGJ38FdUt00S+Ox8vFGjmEfJgz
 2slO9NsraRO/QYBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2434413B26;
 Wed, 30 Sep 2026 22:11:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id befqOAqJvWpwXAAAD6G6ig:T7
 (envelope-from <farosas@suse.de>); Wed, 30 Sep 2026 22:11:31 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Michael Roth <michael.roth@amd.com>
Subject: [PATCH v2 06/11] qemu-option: Change qemu_parse_opts() to take the
 group name
Date: Wed, 30 Sep 2026 19:11:00 -0300
Message-ID: <20260930221105.2262063-7-farosas@suse.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260930221105.2262063-1-farosas@suse.de>
References: <20260930221105.2262063-1-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.993]; MIME_GOOD(-0.10)[text/plain];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.de:email,
 suse.de:mid]
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

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
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
index 468a9fc247..87398cc8d0 100644
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
index 218bb8ae58..7cb45f0710 100644
--- a/util/qemu-option.c
+++ b/util/qemu-option.c
@@ -26,6 +26,7 @@
 #include "qemu/osdep.h"
 
 #include "qapi/error.h"
+#include "qemu/config-file.h"
 #include "qemu/error-report.h"
 #include "qobject/qbool.h"
 #include "qobject/qdict.h"
@@ -927,16 +928,18 @@ static QemuOpts *opts_parse(QemuOptsList *list, const char *params,
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
-    return opts_parse(list, params, permit_abbrev, errp);
+    QemuOptsList *list = qemu_find_opts_err(group, errp);
+
+    return qemu_opts_parse_list(list, params, permit_abbrev, errp);
 }
 
 /**
@@ -949,7 +952,7 @@ QemuOpts *qemu_opts_parse(QemuOptsList *list, const char *params,
 QemuOpts *qemu_opts_parse_list(QemuOptsList *list, const char *params,
                                bool permit_abbrev, Error **errp)
 {
-    return qemu_opts_parse(list, params, permit_abbrev, errp);
+    return opts_parse(list, params, permit_abbrev, errp);
 }
 
 /**
-- 
2.53.0


