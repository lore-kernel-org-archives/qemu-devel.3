Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54E37C982D7
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 22:31:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7h6C-0007qB-TO; Fri, 18 Sep 2026 18:30:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1x7h6A-0007p0-Cx
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 18:30:26 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1x7h68-0000eV-Ok
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 18:30:26 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 18EB220005;
 Fri, 18 Sep 2026 22:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789770619; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F86IFDqgDxSfbOjUjcf4cWDqZ8pzBz8lL6Iyy5LIpN8=;
 b=sYvk3TaF9YvQusU9ALfn2iaV/KOf0q0vE28EFjZ0NnmPdUUuvtxwIayjqmPRKAQbelX9Ad
 6iHURQhIvPyJT9DzVRnKgmWGrKsj0bWpAOAL4SX0RSTX4cv07wHxkS63+7GsFSl4iN7Q34
 pYLJo5fSiS6PPyhSelj6DkgsRTU/yMs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789770619;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F86IFDqgDxSfbOjUjcf4cWDqZ8pzBz8lL6Iyy5LIpN8=;
 b=PoowfdRpwHBGT6dTttMoUQ8d8Bt6FG3u/W8+lsdEE2XKYFEWxQXCcnqSFT9+9gx2gUSFqA
 0bRHOGZlHglEvfDA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=zxX9JgzB;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=+5ILHfze
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789770615; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F86IFDqgDxSfbOjUjcf4cWDqZ8pzBz8lL6Iyy5LIpN8=;
 b=zxX9JgzBdV1UzjpvAo4B9FQbTjj0ol9oZlBnVgduNSMGvrYT6a6Nm5ubR88E4XLHAHaxLx
 oJiUwtfQ3kykC72hUiVBEgJr7ERjx6esb9MT5pw1XzVjlkzhNjWAvDOktyQIJ+zgou/y+c
 XiFTTLe+7WaiPVUMrZ97T7HR++9p9dk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789770615;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F86IFDqgDxSfbOjUjcf4cWDqZ8pzBz8lL6Iyy5LIpN8=;
 b=+5ILHfze3ws1I6719zk12U/1QXB3ZNVXuhFdH3XQ02gqAVUdgh3icQUxvPc+Z2ueKC3feS
 JSsOrcW6908jWbDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EE205139B7;
 Fri, 18 Sep 2026 22:30:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id hQIbBW27rWrsdQAAD6G6ig:T7
 (envelope-from <farosas@suse.de>); Fri, 18 Sep 2026 22:30:13 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>
Subject: [RFC PATCH 06/14] qemu-options: Call qemu_opts_print_help() one level
 down
Date: Fri, 18 Sep 2026 19:29:53 -0300
Message-ID: <20260918223002.1892021-7-farosas@suse.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260918223002.1892021-1-farosas@suse.de>
References: <20260918223002.1892021-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 18EB220005
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCPT_COUNT_TWO(0.00)[2];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:email,suse.de:mid];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:email,suse.de:mid];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
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

When calling opts_parse(), there is no need to pass in &help_wanted
only to call qemu_opts_print_help() in case it's true. The opts_parse
function itself can call qemu_opts_print_help() and avoid the
roundtrip.

qemu_opts_print_help() takes a QemuOptsList pointer. opts_parse() can
access the list via opts->list.

Note that this change doesn't avoid the need for opts_parse() to pass
a pointer into get_opt_name_value().

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 util/qemu-option.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/util/qemu-option.c b/util/qemu-option.c
index 2c23841376..bb38d305c9 100644
--- a/util/qemu-option.c
+++ b/util/qemu-option.c
@@ -812,7 +812,7 @@ static const char *get_opt_name_value(const char *params,
 
 static bool opts_do_parse(QemuOpts *opts, const char *params,
                           const char *firstname,
-                          bool warn_on_flag, bool *help_wanted, Error **errp)
+                          bool warn_on_flag, bool help_wanted, Error **errp)
 {
     const char *p;
     QemuOpt *opt;
@@ -820,9 +820,12 @@ static bool opts_do_parse(QemuOpts *opts, const char *params,
     for (p = params; *p;) {
         g_autofree char *option = NULL;
         g_autofree char *value = NULL;
+        bool is_help = false;
 
-        p = get_opt_name_value(p, firstname, warn_on_flag, help_wanted, &option, &value);
-        if (help_wanted && *help_wanted) {
+        p = get_opt_name_value(p, firstname, warn_on_flag, &is_help, &option,
+                               &value);
+        if (help_wanted && is_help) {
+            qemu_opts_print_help(opts->list, true);
             return false;
         }
         firstname = NULL;
@@ -885,12 +888,12 @@ bool has_help_option(const char *params)
 bool qemu_opts_do_parse(QemuOpts *opts, const char *params,
                        const char *firstname, Error **errp)
 {
-    return opts_do_parse(opts, params, firstname, false, NULL, errp);
+    return opts_do_parse(opts, params, firstname, false, false, errp);
 }
 
 static QemuOpts *opts_parse(QemuOptsList *list, const char *params,
                             bool permit_abbrev,
-                            bool warn_on_flag, bool *help_wanted, Error **errp)
+                            bool warn_on_flag, bool help_wanted, Error **errp)
 {
     const char *firstname;
     char *id = opts_parse_id(params);
@@ -935,7 +938,7 @@ QemuOpts *qemu_opts_parse(const char *group, const char *params,
 QemuOpts *qemu_opts_parse_list(QemuOptsList *list, const char *params,
                                bool permit_abbrev, Error **errp)
 {
-    return opts_parse(list, params, permit_abbrev, false, NULL, errp);
+    return opts_parse(list, params, permit_abbrev, false, false, errp);
 }
 
 /**
@@ -951,15 +954,12 @@ QemuOpts *qemu_opts_parse_noisily(QemuOptsList *list, const char *params,
 {
     Error *err = NULL;
     QemuOpts *opts;
-    bool help_wanted = false;
+    bool help_wanted = !opts_accepts_any(list);
 
-    opts = opts_parse(list, params, permit_abbrev, true,
-                      opts_accepts_any(list) ? NULL : &help_wanted,
-                      &err);
+    opts = opts_parse(list, params, permit_abbrev, true, help_wanted, &err);
     if (!opts) {
-        assert(!!err + !!help_wanted == 1);
         if (help_wanted) {
-            qemu_opts_print_help(list, true);
+            assert(!err);
         } else {
             error_report_err(err);
         }
-- 
2.53.0


