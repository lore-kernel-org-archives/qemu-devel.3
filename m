Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5D6FC25B78
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2024 22:21:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9uKH-0005Rf-2F; Wed, 22 May 2024 18:20:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1s9uKE-0005Qz-MJ
 for qemu-devel@nongnu.org; Wed, 22 May 2024 18:20:46 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1s9uKD-0003jG-16
 for qemu-devel@nongnu.org; Wed, 22 May 2024 18:20:46 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 506A221C22;
 Wed, 22 May 2024 22:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1716416442; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ew10UfF+EsVVsf2jekqvCwSdcpTxG4Fq96bsyCk5mbU=;
 b=RkVib5YvxP8+aWE6IbEJeBqaEw0jeGl8eFgf9xeBmn2EX3gTVMnFPGLqkC5J7+wvp8O/Eo
 3XFpAtwJ3dIUj3/PXAf23cmrFbbPP7moXIeOwMDNqirKYkVAGUrOGIBiMtrk6iHcdkKgIu
 ILqGvCNZ6VZzsE2rpaAFytVRJHd0ZrY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1716416442;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ew10UfF+EsVVsf2jekqvCwSdcpTxG4Fq96bsyCk5mbU=;
 b=+ViRDCxsCqNVdyXGsu/moSiZ4JuQ0mO0ASGWJHMjzs7r+b7cbhdDhnpMuRifc+yd/nCHWQ
 bJyGuthC8qZwuqAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1716416442; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ew10UfF+EsVVsf2jekqvCwSdcpTxG4Fq96bsyCk5mbU=;
 b=RkVib5YvxP8+aWE6IbEJeBqaEw0jeGl8eFgf9xeBmn2EX3gTVMnFPGLqkC5J7+wvp8O/Eo
 3XFpAtwJ3dIUj3/PXAf23cmrFbbPP7moXIeOwMDNqirKYkVAGUrOGIBiMtrk6iHcdkKgIu
 ILqGvCNZ6VZzsE2rpaAFytVRJHd0ZrY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1716416442;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ew10UfF+EsVVsf2jekqvCwSdcpTxG4Fq96bsyCk5mbU=;
 b=+ViRDCxsCqNVdyXGsu/moSiZ4JuQ0mO0ASGWJHMjzs7r+b7cbhdDhnpMuRifc+yd/nCHWQ
 bJyGuthC8qZwuqAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B0D3813A6B;
 Wed, 22 May 2024 22:20:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id aCPjHbhvTmaABAAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 22 May 2024 22:20:40 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Li Zhijian <lizhijian@fujitsu.com>, Zhang Chen <chen.zhang@intel.com>
Subject: [PULL 2/9] migration/colo: make colo_incoming_co() return void
Date: Wed, 22 May 2024 19:20:27 -0300
Message-Id: <20240522222034.4001-3-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240522222034.4001-1-farosas@suse.de>
References: <20240522222034.4001-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
 RCVD_TLS_ALL(0.00)[]
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

From: Li Zhijian <lizhijian@fujitsu.com>

Currently, it always returns 0, no need to check the return value at all.
In addition, enter colo coroutine only if migration_incoming_colo_enabled()
is true.
Once the destination side enters the COLO* state, the COLO process will
take over the remaining processes until COLO exits.

Cc: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Zhang Chen <chen.zhang@intel.com>
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
[fixed mangled author email address]
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 include/migration/colo.h | 2 +-
 migration/colo-stubs.c   | 3 +--
 migration/colo.c         | 9 ++-------
 migration/migration.c    | 6 +++---
 4 files changed, 7 insertions(+), 13 deletions(-)

diff --git a/include/migration/colo.h b/include/migration/colo.h
index eaac07f26d..43222ef5ae 100644
--- a/include/migration/colo.h
+++ b/include/migration/colo.h
@@ -49,7 +49,7 @@ void colo_checkpoint_delay_set(void);
  *
  * Called with BQL locked, may temporary release BQL.
  */
-int coroutine_fn colo_incoming_co(void);
+void coroutine_fn colo_incoming_co(void);
 
 void colo_shutdown(void);
 #endif
diff --git a/migration/colo-stubs.c b/migration/colo-stubs.c
index f8c069b739..e22ce65234 100644
--- a/migration/colo-stubs.c
+++ b/migration/colo-stubs.c
@@ -9,9 +9,8 @@ void colo_shutdown(void)
 {
 }
 
-int coroutine_fn colo_incoming_co(void)
+void coroutine_fn colo_incoming_co(void)
 {
-    return 0;
 }
 
 void colo_checkpoint_delay_set(void)
diff --git a/migration/colo.c b/migration/colo.c
index e2b450c132..ca37b932ac 100644
--- a/migration/colo.c
+++ b/migration/colo.c
@@ -928,16 +928,13 @@ out:
     return NULL;
 }
 
-int coroutine_fn colo_incoming_co(void)
+void coroutine_fn colo_incoming_co(void)
 {
     MigrationIncomingState *mis = migration_incoming_get_current();
     QemuThread th;
 
     assert(bql_locked());
-
-    if (!migration_incoming_colo_enabled()) {
-        return 0;
-    }
+    assert(migration_incoming_colo_enabled());
 
     qemu_thread_create(&th, "COLO incoming", colo_process_incoming_thread,
                        mis, QEMU_THREAD_JOINABLE);
@@ -953,6 +950,4 @@ int coroutine_fn colo_incoming_co(void)
 
     /* We hold the global BQL, so it is safe here */
     colo_release_ram_cache();
-
-    return 0;
 }
diff --git a/migration/migration.c b/migration/migration.c
index 995f0ca923..c004637d29 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -776,9 +776,9 @@ process_incoming_migration_co(void *opaque)
         goto fail;
     }
 
-    if (colo_incoming_co() < 0) {
-        error_setg(&local_err, "colo incoming failed");
-        goto fail;
+    if (migration_incoming_colo_enabled()) {
+        /* yield until COLO exit */
+        colo_incoming_co();
     }
 
     migration_bh_schedule(process_incoming_migration_bh, mis);
-- 
2.35.3


