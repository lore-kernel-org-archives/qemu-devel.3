Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B859C982D8
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 22:31:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7h6O-00086U-6c; Fri, 18 Sep 2026 18:30:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1x7h6L-0007zq-5S
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 18:30:37 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1x7h6J-0000g5-5H
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 18:30:36 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B15342000B;
 Fri, 18 Sep 2026 22:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789770629; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=32oWMLYxHK1bctb+3A1F7epM0ZGxRvTTPkuEwYrWqxM=;
 b=XTeE+iJ3iLYRQ88tlm6rjdcTEk0o/aKbU+nO3HyRfGILrYmK/sVUe6PLCQV7xmwfwEwUPh
 N8/srD+l95HcesdM9wSq7C9E0KcpjD9+nzs+t/wC4ArVwVGR/eqML1/4PJUrZItRtBNGQ8
 DCAVTWGl/hcxEbXLu9642w1uiRyeVkM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789770629;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=32oWMLYxHK1bctb+3A1F7epM0ZGxRvTTPkuEwYrWqxM=;
 b=BXCb4whNtpvw5N5Xrrt63firv3AiQIZcj0UJPZha0DFxWlTN2xcwGtDMFHrgeh6ucwFAJT
 /SB4YnspfbfQPwBg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="dyeOtG2/";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=MU6bhO8q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789770625; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=32oWMLYxHK1bctb+3A1F7epM0ZGxRvTTPkuEwYrWqxM=;
 b=dyeOtG2/DboAKC12aTNvB2RCwUIaPB3w5ylohvn80VTF9pEXVF2ZG0AAP/ibKtrGG/LgYm
 hzarLnMS/ptzplk2eeYTdVGAp5O0PNEpmcpDWIjkrRm4+qJDqlAcHMf5wiR7AZsfsdDGal
 rSwdKo6fuLEXdK5v9z/6ZGA7viM+GnA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789770625;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=32oWMLYxHK1bctb+3A1F7epM0ZGxRvTTPkuEwYrWqxM=;
 b=MU6bhO8qVWyWpDfTxKZk9YIJxOMNkSiWXO8bfeJrYs3Tokp7+TELlJSAIAr5gGlZp5h5OX
 DIRmwJw2PflY+FAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CE9EF139B3;
 Fri, 18 Sep 2026 22:30:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id hQIbBW27rWrsdQAAD6G6ig:T13
 (envelope-from <farosas@suse.de>); Fri, 18 Sep 2026 22:30:24 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>
Subject: [RFC PATCH 12/14] qemu-options: merge warn and help flags
Date: Fri, 18 Sep 2026 19:29:59 -0300
Message-ID: <20260918223002.1892021-13-farosas@suse.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260918223002.1892021-1-farosas@suse.de>
References: <20260918223002.1892021-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: B15342000B
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+]; TO_DN_SOME(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:email,suse.de:mid];
 URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:email,suse.de:mid];
 DKIM_TRACE(0.00)[suse.de:+]
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

There's no need to propagate two separate flags to perform the "noisy"
parsing. The catch is that the opposite scenario, the "silent" parsing
never sets the flags and always uses the Error object, so we can just
push the opts_accepts_any() check that is exclusive to the noisy case
down the stack.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 util/qemu-option.c | 30 ++++++++++++++----------------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/util/qemu-option.c b/util/qemu-option.c
index 94e06b194d..8dadb47170 100644
--- a/util/qemu-option.c
+++ b/util/qemu-option.c
@@ -813,8 +813,7 @@ static const char *get_opt_name_value(const char *params,
 }
 
 static bool opts_do_parse(QemuOpts *opts, const char *params,
-                          const char *firstname,
-                          bool warn_on_flag, bool help_wanted, Error **errp)
+                          const char *firstname, bool noisily, Error **errp)
 {
     const char *p;
     QemuOpt *opt;
@@ -827,13 +826,15 @@ static bool opts_do_parse(QemuOpts *opts, const char *params,
 
         p = get_opt_name_value(p, firstname, &is_help, &option, &value, &warn);
 
-        if (warn_on_flag && warn) {
-            warn_report_err(warn);
-        }
+        if (noisily) {
+            if (warn) {
+                warn_report_err(warn);
+            }
 
-        if (help_wanted && is_help) {
-            qemu_opts_print_help(opts->list, true);
-            return false;
+            if (is_help && !opts_accepts_any(opts->list)) {
+                qemu_opts_print_help(opts->list, true);
+                return false;
+            }
         }
         firstname = NULL;
 
@@ -895,12 +896,11 @@ bool has_help_option(const char *params)
 bool qemu_opts_do_parse(QemuOpts *opts, const char *params,
                        const char *firstname, Error **errp)
 {
-    return opts_do_parse(opts, params, firstname, false, false, errp);
+    return opts_do_parse(opts, params, firstname, false, errp);
 }
 
 static QemuOpts *opts_parse(QemuOptsList *list, const char *params,
-                            bool permit_abbrev,
-                            bool warn_on_flag, bool help_wanted, Error **errp)
+                            bool permit_abbrev, bool noisily, Error **errp)
 {
     const char *firstname;
     char *id = opts_parse_id(params);
@@ -911,8 +911,7 @@ static QemuOpts *opts_parse(QemuOptsList *list, const char *params,
 
     opts = qemu_opts_create(list, id, !list->merge_lists, errp);
     g_free(id);
-    if (!opts || !opts_do_parse(opts, params, firstname,
-                                warn_on_flag, help_wanted, errp)) {
+    if (!opts || !opts_do_parse(opts, params, firstname, noisily, errp)) {
         qemu_opts_del(opts);
         return NULL;
     }
@@ -956,15 +955,14 @@ QemuOpts *qemu_opts_parse_list(QemuOptsList *list, const char *params,
 
     if (noisily) {
         Error *err = NULL;
-        bool help_wanted = !opts_accepts_any(list);
 
-        opts = opts_parse(list, params, permit_abbrev, true, help_wanted, &err);
+        opts = opts_parse(list, params, permit_abbrev, noisily, &err);
         if (!opts && err) {
             error_report_err(err);
         }
 
     } else {
-        opts = opts_parse(list, params, permit_abbrev, false, false, errp);
+        opts = opts_parse(list, params, permit_abbrev, noisily, errp);
     }
 
     return opts;
-- 
2.53.0


