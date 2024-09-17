Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52DE2CAC596
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2024 18:58:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqdOx-0000ct-Ei; Tue, 17 Sep 2024 14:58:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1sqdOv-0000VJ-DF; Tue, 17 Sep 2024 14:58:13 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1sqdOt-0007t8-Et; Tue, 17 Sep 2024 14:58:13 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E70ED20174;
 Tue, 17 Sep 2024 18:58:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1726599490; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LbLygEtJVaBxRuqfrAcm5XUtKM9vMfxUGYr2q5ibimI=;
 b=bK3AtvCdJ21UMnG9f/3zfSff8dW0JNr/WvrwG7Bx1z1uaqipugqRcFwfIH/mdR+gOz49vM
 qiPMgKOQmiQOrgVQ4q8qCMOGB3q/hnai+MlGp/hnnvdE66lgC4YkpHhk3c+Szr1QMc8EEo
 wk7fhZ97G1xOqnYQ6GrPVoiHSVZjeQ0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1726599490;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LbLygEtJVaBxRuqfrAcm5XUtKM9vMfxUGYr2q5ibimI=;
 b=SZYqFQOad25/HJJMIV17IlJxLkZBYpTsYP+I8/+FwD3GrPIFAeucevViusds4fhmkdx2ie
 hHr+9vudTuSTDQDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1726599489; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LbLygEtJVaBxRuqfrAcm5XUtKM9vMfxUGYr2q5ibimI=;
 b=yMXLrmGH/PAvcqb40LAVHTcHDn7gZw6Knzbet6JeHVW/TZjvYuG2xMBnFEW4mI48EyOdEr
 RDkZI26VMMZ8iUfGleqoHmanLTz78R0ikHMO4Ffzm2+WDCgzb+V4mchhpjmUjOFL7rpJJh
 ldBEwt7fQemIbuMDQU9Oy1XqHpgSajc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1726599489;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LbLygEtJVaBxRuqfrAcm5XUtKM9vMfxUGYr2q5ibimI=;
 b=C8I6jADYs8IzIkzKedjpoPfUgz3WB1udg6BCY6a6K2ov4tYu83HKq6DFj+xrk5OHFztQ0I
 GxwRef+I/9mphZDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 88A03139CE;
 Tue, 17 Sep 2024 18:58:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 8D/fE0DR6WYiDgAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 17 Sep 2024 18:58:08 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-stable@nongnu.org
Subject: [PATCH 2/2] migration/multifd: Fix rb->receivedmap cleanup race
Date: Tue, 17 Sep 2024 15:58:02 -0300
Message-Id: <20240917185802.15619-3-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240917185802.15619-1-farosas@suse.de>
References: <20240917185802.15619-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo];
 RCVD_TLS_ALL(0.00)[]
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

Fix a segmentation fault in multifd when rb->receivedmap is cleared
too early.

After commit 5ef7e26bdb ("migration/multifd: solve zero page causing
multiple page faults"), multifd started using the rb->receivedmap
bitmap, which belongs to ram.c and is initialized and *freed* from the
ram SaveVMHandlers.

Multifd threads are live until migration_incoming_state_destroy(),
which is called after qemu_loadvm_state_cleanup(), leading to a crash
when accessing rb->receivedmap.

process_incoming_migration_co()        ...
  qemu_loadvm_state()                  multifd_nocomp_recv()
    qemu_loadvm_state_cleanup()          ramblock_recv_bitmap_set_offset()
      rb->receivedmap = NULL               set_bit_atomic(..., rb->receivedmap)
  ...
  migration_incoming_state_destroy()
    multifd_recv_cleanup()
      multifd_recv_terminate_threads(NULL)

Move the loadvm cleanup into migration_incoming_state_destroy(), after
multifd_recv_cleanup() to ensure multifd threads have already exited
when rb->receivedmap is cleared.

Adjust the postcopy listen thread comment to indicate that we still
want to skip the cpu synchronization.

CC: qemu-stable@nongnu.org
Fixes: 5ef7e26bdb ("migration/multifd: solve zero page causing multiple page faults")
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/migration.c | 1 +
 migration/savevm.c    | 6 ++++--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 3dea06d577..b190a574b1 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -378,6 +378,7 @@ void migration_incoming_state_destroy(void)
     struct MigrationIncomingState *mis = migration_incoming_get_current();
 
     multifd_recv_cleanup();
+    qemu_loadvm_state_cleanup();
 
     if (mis->to_src_file) {
         /* Tell source that we are done */
diff --git a/migration/savevm.c b/migration/savevm.c
index d0759694fd..7e1e27182a 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2979,7 +2979,10 @@ int qemu_loadvm_state(QEMUFile *f)
     trace_qemu_loadvm_state_post_main(ret);
 
     if (mis->have_listen_thread) {
-        /* Listen thread still going, can't clean up yet */
+        /*
+         * Postcopy listen thread still going, don't synchronize the
+         * cpus yet.
+         */
         return ret;
     }
 
@@ -3022,7 +3025,6 @@ int qemu_loadvm_state(QEMUFile *f)
         }
     }
 
-    qemu_loadvm_state_cleanup();
     cpu_synchronize_all_post_init();
 
     return ret;
-- 
2.35.3


