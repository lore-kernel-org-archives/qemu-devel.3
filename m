Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67AB6F9D0FB
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2026 22:37:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCmO7-0003qR-39; Tue, 14 Apr 2026 18:37:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wCmO4-0003pZ-V1
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 18:37:40 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wCmO3-0008HE-3B
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 18:37:40 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 759576A8E9;
 Tue, 14 Apr 2026 22:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1776206257; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=WNOsvQPN/mjRJ8dQDJAMMsNsxvctAmMjLUyub5lQrgc=;
 b=dyk73w7vS7oxSQHHhS9nns1lp1zIaOfvd/e1Z7eUIxTcImgh+z5uMd9KEoIK0M0+LI0wQa
 VHt4CJ030KTjK7QlV5Sd2rVcYsMn8f7zSomOZBibtvNl+v4yYqozVzEj9+yNbPK352aXLq
 f3keQsfEv5j3BTjlPGpPUMaXuaW9bFY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1776206257;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=WNOsvQPN/mjRJ8dQDJAMMsNsxvctAmMjLUyub5lQrgc=;
 b=6hsgq//Z+lTR8uQrKhVHQAhEUonH+q3bkArpiTvAaPzZaZrv6wzFBEtj5W2ish3jYES/Cv
 kQXckk90co5GUuBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1776206256; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=WNOsvQPN/mjRJ8dQDJAMMsNsxvctAmMjLUyub5lQrgc=;
 b=iYT9gdC1dbt/qCVEo2J6DLw+Vu8+d4ZUmT7ILKD8QXrL9Wfw+tGjPyt7uYfmntNF4mLry6
 JO8GDYe6ePlwW7phXQsDFQ73S4JYBZiVVCAm8u5MuDCQsIC7jlcKzvYgz5SV+zcHOdXNlI
 BDu+XvFqCXcDYgpfv72pewsXlOSdZas=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1776206256;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=WNOsvQPN/mjRJ8dQDJAMMsNsxvctAmMjLUyub5lQrgc=;
 b=s5VhVk8iZMtM03UDpYzI+3izWoX2Zo8B0smdkpp36+UJER+/DkzEXNZOK8yewbyS2tcePO
 ssmUIUpScnjJWSAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5560D4B6A3;
 Tue, 14 Apr 2026 22:37:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id QAXPCa/B3mlmVwAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 14 Apr 2026 22:37:35 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Subject: [PATCH v1] migration: Use QAPI_CLONE_MEMBERS in
 migrate_params_test_apply
Date: Tue, 14 Apr 2026 19:37:18 -0300
Message-ID: <20260414223718.23965-1-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[4]; RCVD_TLS_ALL(0.00)[]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Use QAPI_CLONE_MEMBERS instead of making an assignment. The QAPI
method makes the handling of the TLS strings more intuitive because it
clones them as well.

This also fixes a segfault when a NULL TLS option is accessed as part
of a validation check for another option (e.g. in the zero-copy +
multifd compression case). Details follow:

Currently, after copying s->parameters to the temporary
MigrationParameters object before migrate_params_check(), the
references in temporary object to the TLS options are dropped, either
because:

a) the user set a new option, in which case that's fine as
   s->parameters still holds the reference to the old memory or,

b) the user did not set a new option, in which case keeping the
   references in the temporary object would later cause them to be
   freed along with it, leading to double-free when s->parameters is
   also freed later on.

In this second case, it was overlooked that the TLS options can be
accessed already during migrate_params_check() as part of validation
of another option. Those pointers should not have been cleared.

Using QAPI_CLONE_MEMBERS fixes the issue because the temporary object
is not stealing a reference from s->parameters anymore.

Fixes: aed97f0563 ("migration: Normalize tls arguments")
Reported-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
Link: https://lore.kernel.org/r/a65a1049-9f19-460a-8e27-a62bb30d2727@maciej.szmigiero.name
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
NOTE#1: For the release we could have a simpler fix just checking for
NULL, but that would allow two unsupported configurations to be
accepted: zero-copy with either multifd compression or TLS.

NOTE#2: CI is red due to pre-existing failure in functional tests with
"exec:socat" migration.
---
 migration/options.c | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/migration/options.c b/migration/options.c
index 7556fbc06b..68441f0276 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -1279,9 +1279,9 @@ bool migrate_params_check(MigrationParameters *params, Error **errp)
 static void migrate_params_test_apply(MigrationParameters *params,
                                       MigrationParameters *dest)
 {
-    *dest = migrate_get_current()->parameters;
+    MigrationState *s = migrate_get_current();
 
-    /* TODO use QAPI_CLONE() instead of duplicating it inline */
+    QAPI_CLONE_MEMBERS(MigrationParameters, dest, &s->parameters);
 
     if (params->has_throttle_trigger_threshold) {
         dest->throttle_trigger_threshold = params->throttle_trigger_threshold;
@@ -1300,24 +1300,18 @@ static void migrate_params_test_apply(MigrationParameters *params,
     }
 
     if (params->tls_creds) {
+        qapi_free_StrOrNull(dest->tls_creds);
         dest->tls_creds = QAPI_CLONE(StrOrNull, params->tls_creds);
-    } else {
-        /* clear the reference, it's owned by s->parameters */
-        dest->tls_creds = NULL;
     }
 
     if (params->tls_hostname) {
+        qapi_free_StrOrNull(dest->tls_hostname);
         dest->tls_hostname = QAPI_CLONE(StrOrNull, params->tls_hostname);
-    } else {
-        /* clear the reference, it's owned by s->parameters */
-        dest->tls_hostname = NULL;
     }
 
     if (params->tls_authz) {
+        qapi_free_StrOrNull(dest->tls_authz);
         dest->tls_authz = QAPI_CLONE(StrOrNull, params->tls_authz);
-    } else {
-        /* clear the reference, it's owned by s->parameters */
-        dest->tls_authz = NULL;
     }
 
     if (params->has_max_bandwidth) {
@@ -1374,8 +1368,9 @@ static void migrate_params_test_apply(MigrationParameters *params,
     }
 
     if (params->has_block_bitmap_mapping) {
-        dest->has_block_bitmap_mapping = true;
-        dest->block_bitmap_mapping = params->block_bitmap_mapping;
+        qapi_free_BitmapMigrationNodeAliasList(dest->block_bitmap_mapping);
+        dest->block_bitmap_mapping = QAPI_CLONE(BitmapMigrationNodeAliasList,
+                                                params->block_bitmap_mapping);
     }
 
     if (params->has_x_vcpu_dirty_limit_period) {
@@ -1399,7 +1394,8 @@ static void migrate_params_test_apply(MigrationParameters *params,
     }
 
     if (params->has_cpr_exec_command) {
-        dest->cpr_exec_command = params->cpr_exec_command;
+        qapi_free_strList(dest->cpr_exec_command);
+        dest->cpr_exec_command = QAPI_CLONE(strList, params->cpr_exec_command);
     }
 }
 
@@ -1555,4 +1551,6 @@ void qmp_migrate_set_parameters(MigrationParameters *params, Error **errp)
     }
 
     migrate_tls_opts_free(&tmp);
+    qapi_free_BitmapMigrationNodeAliasList(tmp.block_bitmap_mapping);
+    qapi_free_strList(tmp.cpr_exec_command);
 }
-- 
2.51.0


