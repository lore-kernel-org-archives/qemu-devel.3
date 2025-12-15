Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4782FD5B86F
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Dec 2025 22:04:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVGdO-0002li-Er; Mon, 15 Dec 2025 17:01:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vVGdM-0002lW-3y
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 17:01:36 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vVGdK-0002gE-0r
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 17:01:35 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E94A55BDDC;
 Mon, 15 Dec 2025 22:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1765836081; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EurrJ2AcnBh7V9oMQIQwtMecIqYubUGFdzBsgTxErT0=;
 b=h5tP2j0vNl/dqYdBv/jS5WLAUKr0UMdSXQR7jzFpVEjxOlG113nPk86Fxe8zt5j+WySEsi
 EXAhmzvfVw2kWyCu1Fd2qKKMM+RPMTZ2mLytNfHZTFEDpcUQw1+OUcaaXUnPK96fvasrHp
 UPHYwx6BOlUKTpTulaa5lRdlGt+4v0E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1765836081;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EurrJ2AcnBh7V9oMQIQwtMecIqYubUGFdzBsgTxErT0=;
 b=Rgynr0Cggh+33UUS34Qawoo0D2Bb11abDtjA/cGZv/2VKT+ND62mvyrMiPK6s8lzcN9zrF
 cPU/m8O8BGm9ayBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1765836079; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EurrJ2AcnBh7V9oMQIQwtMecIqYubUGFdzBsgTxErT0=;
 b=Qn1nXqNXI7QEGm2lDh8AKPG8KATBH+bjh4OgcWEyCtIscXhrmUiawpttm5wfeC3k/YNrNF
 9uNs/mHhCYcBzr3LKk7EbKUgTxCol7ZU68B7wGduCwMUtryV5HFkCRHI0f9Abz1TDYBz1N
 z8Yerq5IeUCTC5OkjD37jjASOgx0XGc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1765836079;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EurrJ2AcnBh7V9oMQIQwtMecIqYubUGFdzBsgTxErT0=;
 b=/EPTshsw4BwYbLop0EhrE5SsLZq8KVaFRtO4AwMSIM6/lN+m4tdDzfz3ZctebIxoOeoLVw
 HGkn4pLHaiHQICDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 640563EA63;
 Mon, 15 Dec 2025 22:01:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id QK+sCS6FQGlrMQAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 15 Dec 2025 22:01:18 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com,
	armbru@redhat.com,
	Peter Xu <peterx@redhat.com>
Subject: [PATCH v3 11/51] migration: Do away with usage of
 QERR_INVALID_PARAMETER_VALUE
Date: Mon, 15 Dec 2025 18:59:57 -0300
Message-ID: <20251215220041.12657-12-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251215220041.12657-1-farosas@suse.de>
References: <20251215220041.12657-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.991];
 MIME_GOOD(-0.10)[text/plain]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[4]; RCVD_TLS_ALL(0.00)[]
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

The QERR_INVALID_PARAMETER_VALUE macro is documented as not to be used
in new code. Remove the usage from migration/options.c.

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/migration.c  |  3 +--
 migration/options.c    | 56 +++++++++++++++---------------------------
 migration/page_cache.c |  6 ++---
 migration/ram.c        |  3 +--
 4 files changed, 24 insertions(+), 44 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 35c1826633..2c8acd2ee1 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2327,8 +2327,7 @@ static void qmp_migrate_finish(MigrationAddress *addr, bool resume_requested,
     } else if (addr->transport == MIGRATION_ADDRESS_TYPE_FILE) {
         file_start_outgoing_migration(s, &addr->u.file, &local_err);
     } else {
-        error_setg(&local_err, QERR_INVALID_PARAMETER_VALUE, "uri",
-                   "a valid migration protocol");
+        error_setg(&local_err, "uri is not a valid migration protocol");
         migrate_set_state(&s->state, MIGRATION_STATUS_SETUP,
                           MIGRATION_STATUS_FAILED);
     }
diff --git a/migration/options.c b/migration/options.c
index 855fa980a3..c72e63015c 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -1132,120 +1132,105 @@ bool migrate_params_check(MigrationParameters *params, Error **errp)
 
     if (params->throttle_trigger_threshold < 1 ||
         params->throttle_trigger_threshold > 100) {
-        error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
-                   "throttle_trigger_threshold",
+        error_setg(errp, "Option throttle_trigger_threshold expects "
                    "an integer in the range of 1 to 100");
         return false;
     }
 
     if (params->cpu_throttle_initial < 1 ||
         params->cpu_throttle_initial > 99) {
-        error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
-                   "cpu_throttle_initial",
+        error_setg(errp, "Option cpu_throttle_initial expects "
                    "an integer in the range of 1 to 99");
         return false;
     }
 
     if (params->cpu_throttle_increment < 1 ||
         params->cpu_throttle_increment > 99) {
-        error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
-                   "cpu_throttle_increment",
+        error_setg(errp, "Option cpu_throttle_increment expects "
                    "an integer in the range of 1 to 99");
         return false;
     }
 
     if (params->max_bandwidth > SIZE_MAX) {
-        error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
-                   "max_bandwidth",
+        error_setg(errp, "Option max_bandwidth expects "
                    "an integer in the range of 0 to "stringify(SIZE_MAX)
                    " bytes/second");
         return false;
     }
 
     if (params->avail_switchover_bandwidth > SIZE_MAX) {
-        error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
-                   "avail_switchover_bandwidth",
+        error_setg(errp, "Option avail_switchover_bandwidth expects "
                    "an integer in the range of 0 to "stringify(SIZE_MAX)
                    " bytes/second");
         return false;
     }
 
     if (params->downtime_limit > MAX_MIGRATE_DOWNTIME) {
-        error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
-                   "downtime_limit",
+        error_setg(errp, "Option downtime_limit expects "
                    "an integer in the range of 0 to "
                     stringify(MAX_MIGRATE_DOWNTIME)" ms");
         return false;
     }
 
-    /* x_checkpoint_delay is now always positive */
-
     if (params->multifd_channels < 1) {
-        error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
-                   "multifd_channels",
+        error_setg(errp, "Option multifd_channels expects "
                    "a value between 1 and 255");
         return false;
     }
 
     if (params->multifd_zlib_level > 9) {
-        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "multifd_zlib_level",
+        error_setg(errp, "Option multifd_zlib_level expects "
                    "a value between 0 and 9");
         return false;
     }
 
     if (params->multifd_qatzip_level > 9 ||
         params->multifd_qatzip_level < 1) {
-        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "multifd_qatzip_level",
+        error_setg(errp, "Option multifd_qatzip_level expects "
                    "a value between 1 and 9");
         return false;
     }
 
     if (params->multifd_zstd_level > 20) {
-        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "multifd_zstd_level",
+        error_setg(errp, "Option multifd_zstd_level expects "
                    "a value between 0 and 20");
         return false;
     }
 
     if (params->xbzrle_cache_size < qemu_target_page_size() ||
         !is_power_of_2(params->xbzrle_cache_size)) {
-        error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
-                   "xbzrle_cache_size",
+        error_setg(errp, "Option xbzrle_cache_size expects "
                    "a power of two no less than the target page size");
         return false;
     }
 
     if (params->max_cpu_throttle < params->cpu_throttle_initial ||
         params->max_cpu_throttle > 99) {
-        error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
-                   "max_cpu_throttle",
+        error_setg(errp, "max_Option cpu_throttle expects "
                    "an integer in the range of cpu_throttle_initial to 99");
         return false;
     }
 
     if (params->announce_initial > 100000) {
-        error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
-                   "announce_initial",
+        error_setg(errp, "Option announce_initial expects "
                    "a value between 0 and 100000");
         return false;
     }
     if (params->announce_max > 100000) {
-        error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
-                   "announce_max",
+        error_setg(errp, "Option announce_max expects "
                    "a value between 0 and 100000");
-       return false;
+        return false;
     }
     if (params->announce_rounds > 1000) {
-        error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
-                   "announce_rounds",
+        error_setg(errp, "Option announce_rounds expects "
                    "a value between 0 and 1000");
-       return false;
+        return false;
     }
     if (params->announce_step < 1 ||
         params->announce_step > 10000) {
-        error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
-                   "announce_step",
+        error_setg(errp, "Option announce_step expects "
                    "a value between 0 and 10000");
-       return false;
+        return false;
     }
 
     if (!check_dirty_bitmap_mig_alias_map(params->block_bitmap_mapping, errp)) {
@@ -1271,8 +1256,7 @@ bool migrate_params_check(MigrationParameters *params, Error **errp)
 
     if (params->x_vcpu_dirty_limit_period < 1 ||
         params->x_vcpu_dirty_limit_period > 1000) {
-        error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
-                   "x-vcpu-dirty-limit-period",
+        error_setg(errp, "Option x-vcpu-dirty-limit-period expects "
                    "a value between 1 and 1000");
         return false;
     }
diff --git a/migration/page_cache.c b/migration/page_cache.c
index 6d4f7a9bbc..650b15e48c 100644
--- a/migration/page_cache.c
+++ b/migration/page_cache.c
@@ -45,15 +45,13 @@ PageCache *cache_init(uint64_t new_size, size_t page_size, Error **errp)
     PageCache *cache;
 
     if (new_size < page_size) {
-        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "cache size",
-                   "is smaller than one target page size");
+        error_setg(errp, "cache size is smaller than target page size");
         return NULL;
     }
 
     /* round down to the nearest power of 2 */
     if (!is_power_of_2(num_pages)) {
-        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "cache size",
-                   "is not a power of two number of pages");
+        error_setg(errp, "number of pages is not a power of two");
         return NULL;
     }
 
diff --git a/migration/ram.c b/migration/ram.c
index a49afbd995..3eda85b110 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -193,8 +193,7 @@ int xbzrle_cache_resize(uint64_t new_size, Error **errp)
 
     /* Check for truncation */
     if (new_size != (size_t)new_size) {
-        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "cache size",
-                   "exceeding address space");
+        error_setg(errp, "xbzrle cache size integer overflow");
         return -1;
     }
 
-- 
2.51.0


