Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99062C02190
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2025 16:12:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdAXX-00063o-Pq; Wed, 29 Jan 2025 11:03:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tdAVt-0003Pj-Pl
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 11:02:01 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tdAVr-0005Lk-OW
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 11:02:01 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 26474210F3;
 Wed, 29 Jan 2025 16:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1738166517; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=d9OwKEecvHd/Vyp3yOnRxSM7avvn8QcGX4AyWNVPiSs=;
 b=dOU70xENjoc1dOG4FZhWDHsc6hzmmyr5gx/PpqwcHl3rp/5bRlsRORwWQ75BZ7fgTMDkjo
 HdCmjTR1MhDHxTy01LE8mF/oPymlFk5m2nzVzONboh20cLzhwPBi2nQs1SLsMgHt4X2HvS
 6KfVlBmnH4lEqsT404/89mr+7Awqq9A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1738166517;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=d9OwKEecvHd/Vyp3yOnRxSM7avvn8QcGX4AyWNVPiSs=;
 b=ZKCggB5Aq4Itvsg64t5PLEwC86leeeC29UxuYSDkUcXBDw3FT6zfUlsTTwm9cwTWIv9FlB
 C1N1CTxHaSOSuvBw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=dOU70xEN;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=ZKCggB5A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1738166517; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=d9OwKEecvHd/Vyp3yOnRxSM7avvn8QcGX4AyWNVPiSs=;
 b=dOU70xENjoc1dOG4FZhWDHsc6hzmmyr5gx/PpqwcHl3rp/5bRlsRORwWQ75BZ7fgTMDkjo
 HdCmjTR1MhDHxTy01LE8mF/oPymlFk5m2nzVzONboh20cLzhwPBi2nQs1SLsMgHt4X2HvS
 6KfVlBmnH4lEqsT404/89mr+7Awqq9A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1738166517;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=d9OwKEecvHd/Vyp3yOnRxSM7avvn8QcGX4AyWNVPiSs=;
 b=ZKCggB5Aq4Itvsg64t5PLEwC86leeeC29UxuYSDkUcXBDw3FT6zfUlsTTwm9cwTWIv9FlB
 C1N1CTxHaSOSuvBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8F2CC137DB;
 Wed, 29 Jan 2025 16:01:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id WG2kE/NQmmffPAAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 29 Jan 2025 16:01:55 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Jiri Denemark <jdenemar@redhat.com>,
 Juraj Marcin <jmarcin@redhat.com>
Subject: [PULL 26/42] migration: Remove postcopy implications in
 should_send_vmdesc()
Date: Wed, 29 Jan 2025 13:00:43 -0300
Message-Id: <20250129160059.6987-27-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250129160059.6987-1-farosas@suse.de>
References: <20250129160059.6987-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 26474210F3
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,suse.de:mid];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCPT_COUNT_THREE(0.00)[4];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
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

From: Peter Xu <peterx@redhat.com>

should_send_vmdesc() has a hack inside (which was not reflected in the
function name) in that it tries to detect global postcopy state and that
will affect the value to be returned.

It's easier to keep the helper simple by only check the suppress-vmdesc
property.  Then:

  - On the sender side of its usage, there's already in_postcopy variable
    that we can use: postcopy doesn't send vmdesc at all, so directly skip
    everything for postcopy.

  - On the recv side, when reaching vmdesc processing it must be precopy
    code already, hence that hack check never used to work anyway.

No functional change intended, except a trivial side effect that QEMU
source will start to avoid running some JSON helper in postcopy path, but
that would only reduce the postcopy blackout window a bit, rather than any
other bad side effect.

Signed-off-by: Peter Xu <peterx@redhat.com>
Tested-by: Jiri Denemark <jdenemar@redhat.com>
Reviewed-by: Juraj Marcin <jmarcin@redhat.com>
Link: https://lore.kernel.org/r/20250114230746.3268797-2-peterx@redhat.com
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/savevm.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index 6e56d4cf1d..b8859d367f 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1427,8 +1427,8 @@ int qemu_savevm_state_iterate(QEMUFile *f, bool postcopy)
 static bool should_send_vmdesc(void)
 {
     MachineState *machine = MACHINE(qdev_get_machine());
-    bool in_postcopy = migration_in_postcopy();
-    return !machine->suppress_vmdesc && !in_postcopy;
+
+    return !machine->suppress_vmdesc;
 }
 
 /*
@@ -1563,16 +1563,16 @@ int qemu_savevm_state_complete_precopy_non_iterable(QEMUFile *f,
     if (!in_postcopy) {
         /* Postcopy stream will still be going */
         qemu_put_byte(f, QEMU_VM_EOF);
-    }
 
-    json_writer_end_array(vmdesc);
-    json_writer_end_object(vmdesc);
-    vmdesc_len = strlen(json_writer_get(vmdesc));
+        json_writer_end_array(vmdesc);
+        json_writer_end_object(vmdesc);
+        vmdesc_len = strlen(json_writer_get(vmdesc));
 
-    if (should_send_vmdesc()) {
-        qemu_put_byte(f, QEMU_VM_VMDESCRIPTION);
-        qemu_put_be32(f, vmdesc_len);
-        qemu_put_buffer(f, (uint8_t *)json_writer_get(vmdesc), vmdesc_len);
+        if (should_send_vmdesc()) {
+            qemu_put_byte(f, QEMU_VM_VMDESCRIPTION);
+            qemu_put_be32(f, vmdesc_len);
+            qemu_put_buffer(f, (uint8_t *)json_writer_get(vmdesc), vmdesc_len);
+        }
     }
 
     /* Free it now to detect any inconsistencies. */
@@ -2965,6 +2965,7 @@ int qemu_loadvm_state(QEMUFile *f)
         return ret;
     }
 
+    /* When reaching here, it must be precopy */
     if (ret == 0) {
         ret = qemu_file_get_error(f);
     }
-- 
2.35.3


