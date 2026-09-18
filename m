Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAD0AC982D7
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 22:31:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7h6M-000836-8P; Fri, 18 Sep 2026 18:30:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1x7h6K-0007x4-A0
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 18:30:36 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1x7h6I-0000fu-1D
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 18:30:35 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 90A9521EE0;
 Fri, 18 Sep 2026 22:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789770628; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Pil+c5ItAOj/L/psslVm/o4LvQJFfan0el4xUxvvKmw=;
 b=FK1BR9QOwtm6cbyuV2Ex0/nuPEDgQx/SQKnnGvChPbB8P/Fs3+juPBwp9dLrHbuepzPO4T
 v/EvUWONKm6oryShjG47mVAHx3iIARAaAMvNZf0LRgc7ZvzdgQzfZISF8WE8gAkP4Q8Etd
 AsIEhUxJ4oCO5DAL8zr3CtiTCsmxpyo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789770628;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Pil+c5ItAOj/L/psslVm/o4LvQJFfan0el4xUxvvKmw=;
 b=ovYgVvAkBUZ7tve8tphe8sJSHFbbgQwyY/y9w1WIvWn6BG41dvqLRHwpzCGkOU0kd2K/uD
 102cL73ryFSYNqAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789770624; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Pil+c5ItAOj/L/psslVm/o4LvQJFfan0el4xUxvvKmw=;
 b=2YlzxAYDv7ajKXDyCYAwC2k/EcjNWIZTq2N+8BsQSkQrvFcOlEUG8EQ3YIrfW6560lBNEE
 U7ai1f5n6Rxfze7WRUOxec9Nv2Inn/AhBq9eL5ZUO8X7ZNha70m7HN6gOBKW5D2+Ko8/RQ
 SE6/kZJndZUL7Qn1T+ND8e/UFPE9JeU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789770624;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Pil+c5ItAOj/L/psslVm/o4LvQJFfan0el4xUxvvKmw=;
 b=iGA4Dbg4VfKKTIuLw5yxHrmx4dOplTbpTDWk2gPkeLHcsuf9bjGPd7GkfkG39bbm49/Yot
 /BEHLZz9cyDJKNDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AFE91139B1;
 Fri, 18 Sep 2026 22:30:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id hQIbBW27rWrsdQAAD6G6ig:T12
 (envelope-from <farosas@suse.de>); Fri, 18 Sep 2026 22:30:23 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>
Subject: [RFC PATCH 11/14] qemu-options: pass an Error into get_opt_name_value
Date: Fri, 18 Sep 2026 19:29:58 -0300
Message-ID: <20260918223002.1892021-12-farosas@suse.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260918223002.1892021-1-farosas@suse.de>
References: <20260918223002.1892021-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.996];
 MIME_GOOD(-0.10)[text/plain]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[]
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

Passing a boolean into get_opt_name_value() is to put too much
responsibility into this low-level routine. Have it just fill an Error
object and let the caller decide what to do with it. Setting an Error
is an easily recognizable pattern so it saves the reader from mentally
parsing the boolean logic.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 util/qemu-option.c | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/util/qemu-option.c b/util/qemu-option.c
index 37e6d68f02..94e06b194d 100644
--- a/util/qemu-option.c
+++ b/util/qemu-option.c
@@ -756,9 +756,9 @@ void qemu_opts_print(QemuOpts *opts, const char *separator)
 
 static const char *get_opt_name_value(const char *params,
                                       const char *firstname,
-                                      bool warn_on_flag,
                                       bool *help_wanted,
-                                      char **name, char **value)
+                                      char **name, char **value,
+                                      Error **errp)
 {
     const char *p;
     const char *prefix = "";
@@ -783,13 +783,15 @@ static const char *get_opt_name_value(const char *params,
                 *value = g_strdup("on");
                 is_help = is_help_option(*name);
             }
-            if (!is_help && warn_on_flag) {
-                warn_report("short-form boolean option '%s%s' deprecated", prefix, *name);
+            if (!is_help) {
                 if (g_str_equal(*name, "delay")) {
-                    error_printf("Please use nodelay=%s instead\n", prefix[0] ? "on" : "off");
+                    error_setg(errp, "Please use nodelay=%s instead",
+                               prefix[0] ? "on" : "off");
                 } else {
-                    error_printf("Please use %s=%s instead\n", *name, *value);
+                    error_setg(errp, "Please use %s=%s instead", *name, *value);
                 }
+                error_prepend(errp, "short-form boolean option '%s%s' "
+                              "deprecated", prefix, *name);
             }
         }
     } else {
@@ -821,9 +823,14 @@ static bool opts_do_parse(QemuOpts *opts, const char *params,
         g_autofree char *option = NULL;
         g_autofree char *value = NULL;
         bool is_help = false;
+        Error *warn = NULL;
+
+        p = get_opt_name_value(p, firstname, &is_help, &option, &value, &warn);
+
+        if (warn_on_flag && warn) {
+            warn_report_err(warn);
+        }
 
-        p = get_opt_name_value(p, firstname, warn_on_flag, &is_help, &option,
-                               &value);
         if (help_wanted && is_help) {
             qemu_opts_print_help(opts->list, true);
             return false;
@@ -852,7 +859,7 @@ static char *opts_parse_id(const char *params)
         g_autofree char *name = NULL;
         g_autofree char *value = NULL;
 
-        p = get_opt_name_value(p, NULL, false, NULL, &name, &value);
+        p = get_opt_name_value(p, NULL, NULL, &name, &value, NULL);
         if (!strcmp(name, "id")) {
             return g_steal_pointer(&value);
         }
@@ -870,7 +877,7 @@ bool has_help_option(const char *params)
         g_autofree char *name = NULL;
         g_autofree char *value = NULL;
 
-        p = get_opt_name_value(p, NULL, false, &ret, &name, &value);
+        p = get_opt_name_value(p, NULL, &ret, &name, &value, NULL);
         if (ret) {
             return true;
         }
-- 
2.53.0


