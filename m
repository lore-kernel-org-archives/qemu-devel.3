Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDA38C83033
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Jun 2025 20:01:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWKff-00033B-44; Mon, 30 Jun 2025 16:00:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uWKfc-0002sA-BG
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 16:00:04 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uWKfa-0007Vy-BN
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 16:00:04 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E84EC21161;
 Mon, 30 Jun 2025 19:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1751313584; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TO9MQkpy5elBzth456RHr3PQTP2+a1+cv6uhriX3q8g=;
 b=dM4odMflw16eg9G9Ep3Ai7hEXDxNs3QqtyU6dKxyNU0rVOGA8SaSkyBRuIUgIMenNaW4gD
 Y6IJle2UonHBHttB4AJizb/4rql+796bJ60MhZgz1BROk6jcJk5H08Sa3Wwoo8hRzzvPF8
 y12FN8wkThSa3ggX7fHzkjBj8T5LUEY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1751313584;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TO9MQkpy5elBzth456RHr3PQTP2+a1+cv6uhriX3q8g=;
 b=6dSbpIy/zzgNw/07mfzIyyx+XY7mgNl4QLKMgrjF+gYyfdJGpESQwpRFpP5S89AHNLEbyE
 TGu3wB+0upiR/eAg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=NOWwNHju;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=m2WlQox7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1751313583; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TO9MQkpy5elBzth456RHr3PQTP2+a1+cv6uhriX3q8g=;
 b=NOWwNHjus2EoNuOO9PGkh6uw4H/DEZHx8w0MeNTH6DG2q3OGt5ylx4Tv2d1cx2jOAdKC8Z
 Rs6xXt1s7+i3D6WCyHgvav7fHiVR9kVI2IkR8+pd7yueKQiP02OIgZYQnUxktTFKrlUPVS
 g6C8ZDLKlqDig0lMaisakwZCBw5FUVs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1751313583;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TO9MQkpy5elBzth456RHr3PQTP2+a1+cv6uhriX3q8g=;
 b=m2WlQox7lH398L85sZ5rEMHY/JI1lxeHXBXqKFvv0oRkfcayuprpWqO7kdMZxT8cSllNrL
 ObqIrmDX9rNjA2Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 694FD1399F;
 Mon, 30 Jun 2025 19:59:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id qEfsCq7sYmhQUAAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 30 Jun 2025 19:59:42 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com,
	armbru@redhat.com,
	Peter Xu <peterx@redhat.com>
Subject: [PATCH v2 12/24] migration: Use QAPI_CLONE_MEMBERS in
 migrate_params_test_apply
Date: Mon, 30 Jun 2025 16:59:01 -0300
Message-Id: <20250630195913.28033-13-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250630195913.28033-1-farosas@suse.de>
References: <20250630195913.28033-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+]; TO_DN_SOME(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:mid,suse.de:email];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: E84EC21161
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
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
List-Id: <qemu-devel.nongnu.org>
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

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/options.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/migration/options.c b/migration/options.c
index d07931f922..4564db77f2 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -1225,9 +1225,9 @@ bool migrate_params_check(MigrationParameters *params, Error **errp)
 static void migrate_params_test_apply(MigrationParameters *params,
                                       MigrationParameters *dest)
 {
-    *dest = migrate_get_current()->parameters;
+    MigrationState *s = migrate_get_current();
 
-    /* TODO use QAPI_CLONE() instead of duplicating it inline */
+    QAPI_CLONE_MEMBERS(MigrationParameters, dest, &s->parameters);
 
     if (params->has_throttle_trigger_threshold) {
         dest->throttle_trigger_threshold = params->throttle_trigger_threshold;
@@ -1246,24 +1246,18 @@ static void migrate_params_test_apply(MigrationParameters *params,
     }
 
     if (params->tls_creds) {
+        qapi_free_StrOrNull(dest->tls_creds);
         dest->tls_creds = QAPI_CLONE(StrOrNull, params->tls_creds);
-    } else {
-        /* drop the reference, it's owned by s->parameters */
-        dest->tls_creds = NULL;
     }
 
     if (params->tls_hostname) {
+        qapi_free_StrOrNull(dest->tls_hostname);
         dest->tls_hostname = QAPI_CLONE(StrOrNull, params->tls_hostname);
-    } else {
-        /* drop the reference, it's owned by s->parameters */
-        dest->tls_hostname = NULL;
     }
 
     if (params->tls_authz) {
+        qapi_free_StrOrNull(dest->tls_authz);
         dest->tls_authz = QAPI_CLONE(StrOrNull, params->tls_authz);
-    } else {
-        /* drop the reference, it's owned by s->parameters */
-        dest->tls_authz = NULL;
     }
 
     if (params->has_max_bandwidth) {
@@ -1320,7 +1314,6 @@ static void migrate_params_test_apply(MigrationParameters *params,
     }
 
     if (params->has_block_bitmap_mapping) {
-        dest->has_block_bitmap_mapping = true;
         dest->block_bitmap_mapping = params->block_bitmap_mapping;
     }
 
@@ -1485,6 +1478,14 @@ void qmp_migrate_set_parameters(MigrationParameters *params, Error **errp)
 
     migrate_params_test_apply(params, &tmp);
 
+    /*
+     * Mark block_bitmap_mapping as present now while we have the
+     * params structure with the user input around.
+     */
+    if (params->has_block_bitmap_mapping) {
+        migrate_get_current()->has_block_bitmap_mapping = true;
+    }
+
     if (migrate_params_check(&tmp, errp)) {
         migrate_params_apply(params);
         migrate_post_update_params(params, errp);
-- 
2.35.3


