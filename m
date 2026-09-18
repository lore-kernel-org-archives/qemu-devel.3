Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E08CC982D7
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 22:30:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7h69-0007oe-1L; Fri, 18 Sep 2026 18:30:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1x7h64-0007o5-Ul
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 18:30:21 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1x7h63-0000ZD-AL
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 18:30:20 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D2EE421ECF;
 Fri, 18 Sep 2026 22:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789770614; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GXUyeGboVwCGzOGFtHmMgzBd3At9yTet3cRQx4+5wCQ=;
 b=HsEUA33H9pE+YC+xbpcX9vdw/sz25dVXDTHTUqASZ2NJ26WWUGiwVV2ZpTImGG1LH7U/vc
 7noIN9w3EHXGbwxamQ5H8MPAuP8wd2B6bMVgwZe/FJfrdRtriMFAIPdQijTlgNHV536oKq
 G1P2eKXHJfvakEiZNo1jIx9LSno45hc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789770614;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GXUyeGboVwCGzOGFtHmMgzBd3At9yTet3cRQx4+5wCQ=;
 b=NaNi0kES3kTREtA3O+efPs+7JbHAfxqM9IkTo/eNJcAoIfm68l3KW4+5biaa4+qF/hFBV9
 J9lbi2rCGGpanuDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789770609; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GXUyeGboVwCGzOGFtHmMgzBd3At9yTet3cRQx4+5wCQ=;
 b=NABI06tMSDxOmEk5hI5zVm8Et4VPo3SC78Y8T6MAiUtGvzuoasGPQetD/0ESf7m4OpxnGI
 ivmOmYDaahDOU/U0D31Yg3giDJPqkUn/zRWUAAfqRf7Yvdp0c4qVt/PbUsK4PL3os0VBaD
 DK85tBmSKHsxjutrCbZOaHcBCpl0E08=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789770609;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GXUyeGboVwCGzOGFtHmMgzBd3At9yTet3cRQx4+5wCQ=;
 b=etKZD2yTuJphhRBXQ3xfns0GKpGboVy29yrk0JOKWsa5qidBnzEcgLXgmQ4XpcwG2+ebeS
 nBpJ+RTXMkWDbCDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CBE0013991;
 Fri, 18 Sep 2026 22:30:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id hQIbBW27rWrsdQAAD6G6ig:T3
 (envelope-from <farosas@suse.de>); Fri, 18 Sep 2026 22:30:08 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>
Subject: [RFC PATCH 02/14] qemu-options: Use g_autofree when calling
 get_opt_name_value()
Date: Fri, 18 Sep 2026 19:29:49 -0300
Message-ID: <20260918223002.1892021-3-farosas@suse.de>
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
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
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

The get_opt_name_value function takes two pointer arguments that must
be freed by the callers when not used. This is a good situation to use
g_autofree. Steal the pointers that need to be passed forward.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 util/qemu-option.c | 26 +++++++++++---------------
 1 file changed, 11 insertions(+), 15 deletions(-)

diff --git a/util/qemu-option.c b/util/qemu-option.c
index 9fbf425f86..557d5d929c 100644
--- a/util/qemu-option.c
+++ b/util/qemu-option.c
@@ -813,27 +813,24 @@ static bool opts_do_parse(QemuOpts *opts, const char *params,
                           const char *firstname,
                           bool warn_on_flag, bool *help_wanted, Error **errp)
 {
-    char *option, *value;
     const char *p;
     QemuOpt *opt;
 
     for (p = params; *p;) {
+        g_autofree char *option = NULL;
+        g_autofree char *value = NULL;
+
         p = get_opt_name_value(p, firstname, warn_on_flag, help_wanted, &option, &value);
         if (help_wanted && *help_wanted) {
-            g_free(option);
-            g_free(value);
             return false;
         }
         firstname = NULL;
 
         if (!strcmp(option, "id")) {
-            g_free(option);
-            g_free(value);
             continue;
         }
 
-        opt = opt_create(opts, option, value);
-        g_free(option);
+        opt = opt_create(opts, option, g_steal_pointer(&value));
         if (!opt_validate(opt, errp)) {
             qemu_opt_del(opt);
             return false;
@@ -846,16 +843,15 @@ static bool opts_do_parse(QemuOpts *opts, const char *params,
 static char *opts_parse_id(const char *params)
 {
     const char *p;
-    char *name, *value;
 
     for (p = params; *p;) {
+        g_autofree char *name = NULL;
+        g_autofree char *value = NULL;
+
         p = get_opt_name_value(p, NULL, false, NULL, &name, &value);
         if (!strcmp(name, "id")) {
-            g_free(name);
-            return value;
+            return g_steal_pointer(&value);
         }
-        g_free(name);
-        g_free(value);
     }
 
     return NULL;
@@ -864,13 +860,13 @@ static char *opts_parse_id(const char *params)
 bool has_help_option(const char *params)
 {
     const char *p;
-    char *name, *value;
     bool ret = false;
 
     for (p = params; *p;) {
+        g_autofree char *name = NULL;
+        g_autofree char *value = NULL;
+
         p = get_opt_name_value(p, NULL, false, &ret, &name, &value);
-        g_free(name);
-        g_free(value);
         if (ret) {
             return true;
         }
-- 
2.53.0


