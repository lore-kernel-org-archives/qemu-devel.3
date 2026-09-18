Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0E4CC982D7
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 22:31:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7h6P-00088F-Fl; Fri, 18 Sep 2026 18:30:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1x7h6N-00085U-Aa
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 18:30:39 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1x7h6L-0000gZ-F7
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 18:30:38 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id EEFA42000C;
 Fri, 18 Sep 2026 22:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789770632; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YxYkFADoxXyzATxVbB7JPwava2v3rFjGlNEKscFuAZY=;
 b=Ef18YtTUPYxOsAGduk17AolLHhdYIcjwNSDUg9B8ggN/ZPMn6czCSXnzYZQCSXn3B3KpfU
 snic5Fswc3YY2zokHfJEzB+K2PIGZm05z1RW45iy44cf35fo7uhotjhsjZZnFaHMZRjlcJ
 /hgOqpL/+9yMYwTIEmjMaNASlZDuuSM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789770632;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YxYkFADoxXyzATxVbB7JPwava2v3rFjGlNEKscFuAZY=;
 b=u0LBExaQEpIbH8gUvCeFwo+FtJsnXE+CtsRVeTYBx2dSSLkXd1/lT5daMSCr6nfLyoVeeh
 QQONriYs7fWCVwDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789770627; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YxYkFADoxXyzATxVbB7JPwava2v3rFjGlNEKscFuAZY=;
 b=SwkG98DHW8LOKBSwnzrulzli2BSxYY/hSRLKQzunUBdn+ca1NimxcdeU+kOvSXmJyTvQ1u
 SHY3zU4JJ/IR1m8J3PWIe9hAnDVnsBzyW2e52t1ZwGf1bBeRmVu1Q+QsudM3ZxWwZNJ8Xs
 jioN3qCUvFi0VvwlLa+Wihg40p+y34o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789770627;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YxYkFADoxXyzATxVbB7JPwava2v3rFjGlNEKscFuAZY=;
 b=elp7zBK7+qqiuavyNLb7D446gpd0oLubRIEJrc7M/v6/Rwkgide5eyqfM0NUNBHIO7cNFi
 Z9nLYgiOZMjlaeCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1A9C3139B6;
 Fri, 18 Sep 2026 22:30:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id hQIbBW27rWrsdQAAD6G6ig:T15
 (envelope-from <farosas@suse.de>); Fri, 18 Sep 2026 22:30:26 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>
Subject: [RFC PATCH 14/14] qemu-options: Remove opts_parse()
Date: Fri, 18 Sep 2026 19:30:01 -0300
Message-ID: <20260918223002.1892021-15-farosas@suse.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260918223002.1892021-1-farosas@suse.de>
References: <20260918223002.1892021-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.997];
 MIME_GOOD(-0.10)[text/plain]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

There's only one caller of opts_parse(): qemu_opts_parse_list().
Merge the two functions.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 util/qemu-option.c | 33 ++++++++++-----------------------
 1 file changed, 10 insertions(+), 23 deletions(-)

diff --git a/util/qemu-option.c b/util/qemu-option.c
index 1e8042a1bd..167c81c17a 100644
--- a/util/qemu-option.c
+++ b/util/qemu-option.c
@@ -899,26 +899,6 @@ bool qemu_opts_do_parse(QemuOpts *opts, const char *params,
     return opts_do_parse(opts, params, firstname, false, errp);
 }
 
-static QemuOpts *opts_parse(QemuOptsList *list, const char *params,
-                            bool permit_abbrev, bool noisily, Error **errp)
-{
-    const char *firstname;
-    char *id = opts_parse_id(params);
-    QemuOpts *opts;
-
-    assert(!permit_abbrev || list->implied_opt_name);
-    firstname = permit_abbrev ? list->implied_opt_name : NULL;
-
-    opts = qemu_opts_create(list, id, !list->merge_lists, errp);
-    g_free(id);
-    if (!opts || !opts_do_parse(opts, params, firstname, noisily, errp)) {
-        qemu_opts_del(opts);
-        return NULL;
-    }
-
-    return opts;
-}
-
 /**
  * Find the @group and create a QemuOpts with options parsed from
  * @params.  If @permit_abbrev, the first key=value in @params may
@@ -948,20 +928,27 @@ QemuOpts *qemu_opts_parse(const char *group, const char *params,
 QemuOpts *qemu_opts_parse_list(QemuOptsList *list, const char *params,
                                bool permit_abbrev, Error **errp)
 {
+    const char *firstname;
+    g_autofree char *id = opts_parse_id(params);
     bool noisily = !errp;
     QemuOpts *opts = NULL;
     Error *err = NULL;
 
     assert(list);
-    opts = opts_parse(list, params, permit_abbrev, noisily, &err);
+    assert(!permit_abbrev || list->implied_opt_name);
+
+    firstname = permit_abbrev ? list->implied_opt_name : NULL;
+
+    opts = qemu_opts_create(list, id, !list->merge_lists, &err);
+    if (!opts || !opts_do_parse(opts, params, firstname, noisily, &err)) {
+        qemu_opts_del(opts);
 
-    if (!opts) {
-        assert(err);
         if (noisily) {
             error_report_err(err);
         } else {
             error_propagate(errp, err);
         }
+        return NULL;
     }
 
     return opts;
-- 
2.53.0


