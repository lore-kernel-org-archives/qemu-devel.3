Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6029CA5FC5
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 22:13:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xC2Wh-0007w7-T7; Wed, 30 Sep 2026 18:11:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1xC2WX-0007ui-Ln
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 18:11:38 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1xC2WW-00051T-1D
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 18:11:37 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D586A1F7EE;
 Wed, 30 Sep 2026 22:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1790806290; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IL7p26SMX/LMSZIFbyh1Y8RvPwXs2rZDpFVWpTHGhwQ=;
 b=SMsKWyQoxuCAw5WqzBsgh0cyvWnQd0LKHsC2AXWkjR2WV8XIbA4hc4L6+kRZg5hFDrWyb3
 H9bGG12Yox3E79fy06k6uufulKc3pweZ9ClXx6ZPDdwWWhkY0sqsz625SsWDKLhB4zyYwR
 cVf0kmqW9J/l2wO/QLHP2gpmKMVpm6M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1790806290;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IL7p26SMX/LMSZIFbyh1Y8RvPwXs2rZDpFVWpTHGhwQ=;
 b=ibgZL+VoQzVfYtOcuegQF48X3sYQeYHWl7X77YVdgpAWgowoVgXzDgnoLy8UEITQnipjPG
 0QayUGqD64qBVeBQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=hPJUR0L0;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=wjW5a5uJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1790806285; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IL7p26SMX/LMSZIFbyh1Y8RvPwXs2rZDpFVWpTHGhwQ=;
 b=hPJUR0L0TYP5iWjVt0vtaaZhsNZ0ezTf/vy2j0vwVP0mis6CiycFA5W4RiPTEkyVXsDURn
 QJOIcHtx+9/MnExv/IG/fSmZhxFKokb0X/pTTzlsz4qejJDO380P69kIMJ1l7gtGYBo6B3
 twqErhs8gO97tFXgIB+zVeLKPlPvUXA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1790806285;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IL7p26SMX/LMSZIFbyh1Y8RvPwXs2rZDpFVWpTHGhwQ=;
 b=wjW5a5uJH/kvoc1qamhUfdhEBAcnARdaS9UbVMk4F7Ayl9L4LEoxAdQ26vHC/RXL5ok7Os
 O1d00KfJySuQwFBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A4F1613B21;
 Wed, 30 Sep 2026 22:11:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id befqOAqJvWpwXAAAD6G6ig:T2
 (envelope-from <farosas@suse.de>); Wed, 30 Sep 2026 22:11:24 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 01/11] qemu-option: Use g_autofree when calling
 get_opt_name_value()
Date: Wed, 30 Sep 2026 19:10:55 -0300
Message-ID: <20260930221105.2262063-2-farosas@suse.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260930221105.2262063-1-farosas@suse.de>
References: <20260930221105.2262063-1-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: D586A1F7EE
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
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

The get_opt_name_value function takes two pointer arguments that must
be freed by the callers when not used. This is a good situation to use
g_autofree. Steal the pointers that need to be passed forward.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
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


