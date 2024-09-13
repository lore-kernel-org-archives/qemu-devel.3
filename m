Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EE4CFC6182
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2024 22:06:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1spEQO-00015u-DY; Fri, 13 Sep 2024 18:05:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1spEQL-0000vY-SG; Fri, 13 Sep 2024 18:05:53 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1spEQK-0002G3-6g; Fri, 13 Sep 2024 18:05:53 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id EB9A8219BA;
 Fri, 13 Sep 2024 22:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1726265150; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iNFQpeR9INnn8cumJTZGZ7/QN8DrjHGu76QMvcMd+Bo=;
 b=Qv2jbnu0Ya4qivo0PNSrGmJ8vAvFxobHIJBQePdN1FUaqntpLTAwCfEJbBgdBTXgK5CHxW
 sG4YBa1Ugevt4YnbF4gfjan6HQiOrwrzCV9dqCw+83Ubg4IiSr9lc9T9kqfIqHo3XLbaaO
 ZLcRyaWvN3GBH0Atrf9bgLjZrqoj2YY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1726265150;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iNFQpeR9INnn8cumJTZGZ7/QN8DrjHGu76QMvcMd+Bo=;
 b=lp3Yuk/p5FtayjI7amnXa3qQCbFNUaeRh+Z62EWzsVie8+W0xMZl0H2M5C0dyO6udZ3ktN
 anVGzNFnraJY6wCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1726265149; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iNFQpeR9INnn8cumJTZGZ7/QN8DrjHGu76QMvcMd+Bo=;
 b=l1MV51RtS0cGcHT8TbGbSIZtuXTUvxgH0yRPHzZdOmCiCt9ZCfNSC9Xqp2qzvGM2oRG8wf
 0q7obuLGkpQT4o4erZHuWVlTua8bVHX9lbfMQylgo3CIcCKhBwFeeGOa2hCM8Pim+EBoZb
 baEyokjulGMclof1sTlwMGcirCnCcBY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1726265149;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iNFQpeR9INnn8cumJTZGZ7/QN8DrjHGu76QMvcMd+Bo=;
 b=8IQZuRfEYjpNgTheWEMyW8J33+d+FIZDE5O2vW+vMw+ndmcabACb/zLUFtXrcf+NlzhVTD
 3kGP2pNAz5frGTCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8B4B113A72;
 Fri, 13 Sep 2024 22:05:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id qERyFDy35GaQQgAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 13 Sep 2024 22:05:48 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-stable@nongnu.org
Subject: [PATCH 2/2] migration/multifd: Fix rb->receivedmap cleanup race
Date: Fri, 13 Sep 2024 19:05:42 -0300
Message-Id: <20240913220542.18305-3-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240913220542.18305-1-farosas@suse.de>
References: <20240913220542.18305-1-farosas@suse.de>
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid];
 RCVD_TLS_ALL(0.00)[]
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
multifd_recv_cleanup() to ensure multifd thread have already exited
when rb->receivedmap is cleared.

The have_listen_thread logic can now be removed because its purpose
was to delay cleanup until postcopy_ram_listen_thread() had finished.

CC: qemu-stable@nongnu.org
Fixes: 5ef7e26bdb ("migration/multifd: solve zero page causing multiple page faults")
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/migration.c | 1 +
 migration/migration.h | 1 -
 migration/savevm.c    | 9 ---------
 3 files changed, 1 insertion(+), 10 deletions(-)

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
diff --git a/migration/migration.h b/migration/migration.h
index 38aa1402d5..20b0a5b66e 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -101,7 +101,6 @@ struct MigrationIncomingState {
     /* Set this when we want the fault thread to quit */
     bool           fault_thread_quit;
 
-    bool           have_listen_thread;
     QemuThread     listen_thread;
 
     /* For the kernel to send us notifications */
diff --git a/migration/savevm.c b/migration/savevm.c
index d0759694fd..532ee5e4b0 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2076,10 +2076,8 @@ static void *postcopy_ram_listen_thread(void *opaque)
      * got a bad migration state).
      */
     migration_incoming_state_destroy();
-    qemu_loadvm_state_cleanup();
 
     rcu_unregister_thread();
-    mis->have_listen_thread = false;
     postcopy_state_set(POSTCOPY_INCOMING_END);
 
     object_unref(OBJECT(migr));
@@ -2130,7 +2128,6 @@ static int loadvm_postcopy_handle_listen(MigrationIncomingState *mis)
         return -1;
     }
 
-    mis->have_listen_thread = true;
     postcopy_thread_create(mis, &mis->listen_thread, "mig/dst/listen",
                            postcopy_ram_listen_thread, QEMU_THREAD_DETACHED);
     trace_loadvm_postcopy_handle_listen("return");
@@ -2978,11 +2975,6 @@ int qemu_loadvm_state(QEMUFile *f)
 
     trace_qemu_loadvm_state_post_main(ret);
 
-    if (mis->have_listen_thread) {
-        /* Listen thread still going, can't clean up yet */
-        return ret;
-    }
-
     if (ret == 0) {
         ret = qemu_file_get_error(f);
     }
@@ -3022,7 +3014,6 @@ int qemu_loadvm_state(QEMUFile *f)
         }
     }
 
-    qemu_loadvm_state_cleanup();
     cpu_synchronize_all_post_init();
 
     return ret;
-- 
2.35.3


