Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46D3CC83038
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Jun 2025 20:05:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWKfn-0003n5-S3; Mon, 30 Jun 2025 16:00:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uWKfk-0003Uc-Q9
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 16:00:12 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uWKfi-0007it-Qp
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 16:00:12 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E172E1F388;
 Mon, 30 Jun 2025 19:59:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1751313581; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xRf9yuzVRLp6wekhjVd1IsXwiOjJofkv8ORwwOJUsiw=;
 b=KlN8pW92ObKL9lVKhf2bGrobvv4riKGMDz1XqobKGx/FcbROR3l4AuFPxvaVNrn8VQC8f6
 GBHiCgQdlklyKk6RuojSF9Lynt7QuqZTUcXs5DPBgjjWXXBb6GDt/dGqQFii7Llg6ibTnm
 U+32DHYygGDgnf7E+WZR8wJz+3574Fw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1751313581;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xRf9yuzVRLp6wekhjVd1IsXwiOjJofkv8ORwwOJUsiw=;
 b=qDCZyQTEVjITnYAvPkDrcdrAXdc7BT4g/DbY/aN1Wv2vtPEACjZxIsFa148Kl1vyIxrq3U
 058XFGNAd/QxuTDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1751313581; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xRf9yuzVRLp6wekhjVd1IsXwiOjJofkv8ORwwOJUsiw=;
 b=KlN8pW92ObKL9lVKhf2bGrobvv4riKGMDz1XqobKGx/FcbROR3l4AuFPxvaVNrn8VQC8f6
 GBHiCgQdlklyKk6RuojSF9Lynt7QuqZTUcXs5DPBgjjWXXBb6GDt/dGqQFii7Llg6ibTnm
 U+32DHYygGDgnf7E+WZR8wJz+3574Fw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1751313581;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xRf9yuzVRLp6wekhjVd1IsXwiOjJofkv8ORwwOJUsiw=;
 b=qDCZyQTEVjITnYAvPkDrcdrAXdc7BT4g/DbY/aN1Wv2vtPEACjZxIsFa148Kl1vyIxrq3U
 058XFGNAd/QxuTDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 63B7E1399F;
 Mon, 30 Jun 2025 19:59:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id YFiJCazsYmhQUAAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 30 Jun 2025 19:59:40 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com,
	armbru@redhat.com,
	Peter Xu <peterx@redhat.com>
Subject: [PATCH v2 11/24] migration: Use QAPI_CLONE_MEMBERS in
 query_migrate_parameters
Date: Mon, 30 Jun 2025 16:59:00 -0300
Message-Id: <20250630195913.28033-12-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250630195913.28033-1-farosas@suse.de>
References: <20250630195913.28033-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.999];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+];
 R_RATELIMIT(0.00)[to_ip_from(RLjrdmmf3juheryardexw6jb95)];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo];
 RCVD_TLS_ALL(0.00)[]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

QAPI_CLONE_MEMBERS is a better option than copying parameters one by
one because it operates on the entire struct and follows pointers. It
also avoids the need to alter this function every time a new parameter
is added.

For this to work, the has_* fields of s->parameters need to be already
set beforehand, so move migrate_mark_all_params_present() to the init
routine.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/options.c | 41 +++--------------------------------------
 1 file changed, 3 insertions(+), 38 deletions(-)

diff --git a/migration/options.c b/migration/options.c
index df9f0bd812..d07931f922 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -1021,45 +1021,9 @@ static void migrate_mark_all_params_present(MigrationParameters *p)
 
 MigrationParameters *qmp_query_migrate_parameters(Error **errp)
 {
-    MigrationParameters *params;
     MigrationState *s = migrate_get_current();
-
-    /* TODO use QAPI_CLONE() instead of duplicating it inline */
-    params = g_malloc0(sizeof(*params));
-
-    params->throttle_trigger_threshold = s->parameters.throttle_trigger_threshold;
-    params->cpu_throttle_initial = s->parameters.cpu_throttle_initial;
-    params->cpu_throttle_increment = s->parameters.cpu_throttle_increment;
-    params->cpu_throttle_tailslow = s->parameters.cpu_throttle_tailslow;
-    params->tls_creds = QAPI_CLONE(StrOrNull, s->parameters.tls_creds);
-    params->tls_hostname = QAPI_CLONE(StrOrNull, s->parameters.tls_hostname);
-    params->tls_authz = QAPI_CLONE(StrOrNull, s->parameters.tls_authz);
-    params->max_bandwidth = s->parameters.max_bandwidth;
-    params->avail_switchover_bandwidth = s->parameters.avail_switchover_bandwidth;
-    params->downtime_limit = s->parameters.downtime_limit;
-    params->x_checkpoint_delay = s->parameters.x_checkpoint_delay;
-    params->multifd_channels = s->parameters.multifd_channels;
-    params->multifd_compression = s->parameters.multifd_compression;
-    params->multifd_zlib_level = s->parameters.multifd_zlib_level;
-    params->multifd_qatzip_level = s->parameters.multifd_qatzip_level;
-    params->multifd_zstd_level = s->parameters.multifd_zstd_level;
-    params->xbzrle_cache_size = s->parameters.xbzrle_cache_size;
-    params->max_postcopy_bandwidth = s->parameters.max_postcopy_bandwidth;
-    params->max_cpu_throttle = s->parameters.max_cpu_throttle;
-    params->announce_initial = s->parameters.announce_initial;
-    params->announce_max = s->parameters.announce_max;
-    params->announce_rounds = s->parameters.announce_rounds;
-    params->announce_step = s->parameters.announce_step;
-    params->x_vcpu_dirty_limit_period = s->parameters.x_vcpu_dirty_limit_period;
-    params->vcpu_dirty_limit = s->parameters.vcpu_dirty_limit;
-    params->mode = s->parameters.mode;
-    params->zero_page_detection = s->parameters.zero_page_detection;
-    params->direct_io = s->parameters.direct_io;
-    params->block_bitmap_mapping =
-        QAPI_CLONE(BitmapMigrationNodeAliasList,
-                   s->parameters.block_bitmap_mapping);
-
-    migrate_mark_all_params_present(params);
+    MigrationParameters *params = QAPI_CLONE(MigrationParameters,
+                                             &s->parameters);
 
     /*
      * The block-bitmap-mapping breaks the expected API of
@@ -1077,6 +1041,7 @@ MigrationParameters *qmp_query_migrate_parameters(Error **errp)
 
 void migrate_params_init(MigrationParameters *params)
 {
+    migrate_mark_all_params_present(params);
 }
 
 static void migrate_post_update_params(MigrationParameters *new, Error **errp)
-- 
2.35.3


