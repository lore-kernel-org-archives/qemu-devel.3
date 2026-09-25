Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1083C98325
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2026 15:41:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xA82b-0006mZ-EE; Fri, 25 Sep 2026 11:40:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1xA82Z-0006ls-MV
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 11:40:47 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1xA82Y-0004dc-3K
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 11:40:47 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 98AB01F7B9;
 Fri, 25 Sep 2026 15:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1790350840; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZXM6n2K9OZ73m3J3n6F63FRlHXCPIFdAsdyaQqGrOOw=;
 b=IXb+gnmQbofmt44Xo0X2nqZMpIjBlB2z8FT/VmVXfrxz+J1XWov6yb1mT3O/dDS8fjEsRy
 oQ9K9r4jkJbaxCUHJbaMSUx/zyTzAOSjNpGJ0x3amqyvEygCEBjxueD7I14vD4MsGXoZuS
 xduLxzAyXaW6e8XlLUlG/hKdK5b1TX8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1790350840;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZXM6n2K9OZ73m3J3n6F63FRlHXCPIFdAsdyaQqGrOOw=;
 b=U2IY8tOvz2ztoIwmyOj0vqs+lLuQYfztdLN3c7WNmAqw4JhOn4DD1OwPC8Z62xAUanPzUm
 ruqxSVIJVOPDIhBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1790350836; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZXM6n2K9OZ73m3J3n6F63FRlHXCPIFdAsdyaQqGrOOw=;
 b=cGtRVYWC3+4R/+v2X8A4A5YTuZzmTxggWoXgpAC05WIOR2/n7H05kren5RCasfgW3ZyDXa
 R0nBHEXoNCkK9GuNmZduRdVnb7uzKIoUArgllQTRy1mrp8NRKVRFdNoQleytJQe2bl04SC
 nAxwzbhUgxxr61pFy/poMv2WpPWFb5o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1790350836;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZXM6n2K9OZ73m3J3n6F63FRlHXCPIFdAsdyaQqGrOOw=;
 b=3GMVy6nhU574R1dsWOLn6TYm8FOdAnjQJ5l38iF2XnowsIXy5SJNmMjr+C9Mh9CqHlHuWh
 s1rgVaiWxWSMtaAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8A977132DD;
 Fri, 25 Sep 2026 15:40:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id xxRgCd2VtmqjOwAAD6G6ig:T17
 (envelope-from <farosas@suse.de>); Fri, 25 Sep 2026 15:40:35 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
	Prasad Pandit <ppandit@redhat.com>
Subject: [PULL 16/19] migration: Open code migrate_params_apply
Date: Fri, 25 Sep 2026 12:40:07 -0300
Message-ID: <20260925154010.599247-17-farosas@suse.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260925154010.599247-1-farosas@suse.de>
References: <20260925154010.599247-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.997];
 MIME_GOOD(-0.10)[text/plain]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[3]; TO_DN_SOME(0.00)[];
 FROM_HAS_DN(0.00)[]; RCVD_TLS_ALL(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.de:mid,
 suse.de:email]
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

Remove migrate_params_apply so the logic of setting migration
parameters is all in one spot.

Suggested-by: Prasad Pandit <ppandit@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/options.c | 28 ++++++++++------------------
 1 file changed, 10 insertions(+), 18 deletions(-)

diff --git a/migration/options.c b/migration/options.c
index 0f7478aa6a..12f884caa4 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -1393,21 +1393,6 @@ bool migrate_params_check(MigrationParameters *params, Error **errp)
     return true;
 }
 
-/*
- * Caller must ensure the has_* fields of @params are true so they all
- * get copied and the pointer members don't dangle.
- */
-static void migrate_params_apply(MigrationParameters *params)
-{
-    MigrationState *s = migrate_get_current();
-    MigrationParameters *cur = &s->parameters;
-
-    migrate_tls_opts_free(cur);
-    qapi_free_BitmapMigrationNodeAliasList(cur->block_bitmap_mapping);
-    qapi_free_strList(cur->cpr_exec_command);
-    QAPI_CLONE_MEMBERS(MigrationParameters, cur, params);
-}
-
 void qmp_migrate_set_parameters(MigrationParameters *input, Error **errp)
 {
     MigrationParameters *cur = &migrate_get_current()->parameters;
@@ -1430,8 +1415,15 @@ void qmp_migrate_set_parameters(MigrationParameters *input, Error **errp)
         return;
     }
 
-    if (migrate_params_check(new, errp)) {
-        migrate_params_apply(new);
-        migrate_post_update_params(input, errp);
+    if (!migrate_params_check(new, errp)) {
+        return;
     }
+
+    migrate_tls_opts_free(cur);
+    qapi_free_BitmapMigrationNodeAliasList(cur->block_bitmap_mapping);
+    qapi_free_strList(cur->cpr_exec_command);
+
+    QAPI_CLONE_MEMBERS(MigrationParameters, cur, new);
+
+    migrate_post_update_params(input, errp);
 }
-- 
2.53.0


