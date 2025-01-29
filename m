Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2E0AC0218D
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2025 16:08:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdAYH-0000M6-08; Wed, 29 Jan 2025 11:04:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tdAWE-00043q-CR
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 11:02:25 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tdAWC-0005Q6-I2
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 11:02:22 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 4EC801F365;
 Wed, 29 Jan 2025 16:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1738166539; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jfPfKMxQBt5pCWIRgtinMPwNANpq6ecL/d2Cj1p0z6w=;
 b=YZwLQmXRwbXuFC7wI425+vcyYwoPYQqruZVZZKEUFQIL95upKX3iNb/k6RLwhUoQFBJxuJ
 yrtNDp1DR8rgF/67dYBOueVg9iJSC7j+8BJevsxVvCqSRkNcHTrXemP4KUcpip9p+SiSKM
 vpebhA5kvSpD1Q6dq5hx96bUsB66mGs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1738166539;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jfPfKMxQBt5pCWIRgtinMPwNANpq6ecL/d2Cj1p0z6w=;
 b=uQtGD4kcREd2rxgdc4eUkWPZqU0h268kHW7gxv3E+us/U6Pv36ysNZEDQ1MwF3mTD5qF+3
 VwqFIbpy3+OTnEBg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=YZwLQmXR;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=uQtGD4kc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1738166539; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jfPfKMxQBt5pCWIRgtinMPwNANpq6ecL/d2Cj1p0z6w=;
 b=YZwLQmXRwbXuFC7wI425+vcyYwoPYQqruZVZZKEUFQIL95upKX3iNb/k6RLwhUoQFBJxuJ
 yrtNDp1DR8rgF/67dYBOueVg9iJSC7j+8BJevsxVvCqSRkNcHTrXemP4KUcpip9p+SiSKM
 vpebhA5kvSpD1Q6dq5hx96bUsB66mGs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1738166539;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jfPfKMxQBt5pCWIRgtinMPwNANpq6ecL/d2Cj1p0z6w=;
 b=uQtGD4kcREd2rxgdc4eUkWPZqU0h268kHW7gxv3E+us/U6Pv36ysNZEDQ1MwF3mTD5qF+3
 VwqFIbpy3+OTnEBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C24A8137DB;
 Wed, 29 Jan 2025 16:02:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id IKR/IAlRmmffPAAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 29 Jan 2025 16:02:17 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Jiri Denemark <jdenemar@redhat.com>,
 Juraj Marcin <jmarcin@redhat.com>
Subject: [PULL 37/42] migration: Unwrap qemu_savevm_state_complete_precopy()
 in postcopy
Date: Wed, 29 Jan 2025 13:00:54 -0300
Message-Id: <20250129160059.6987-38-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250129160059.6987-1-farosas@suse.de>
References: <20250129160059.6987-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4EC801F365
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCPT_COUNT_THREE(0.00)[4];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
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

Postcopy invokes qemu_savevm_state_complete_precopy() twice for a long
time, and that caused way too much confusions.  Let's clean this up and
make postcopy easier to read.

It's actually fairly straightforward: postcopy starts with saving
non-postcopiable iterables, then later it saves again with non-iterable
only.  Move these two calls out makes everything much easier to follow.
Otherwise it's very unclear what qemu_savevm_state_complete_precopy() did
in either of the calls.

No functional change intended.

Signed-off-by: Peter Xu <peterx@redhat.com>
Tested-by: Jiri Denemark <jdenemar@redhat.com>
Reviewed-by: Juraj Marcin <jmarcin@redhat.com>
Link: https://lore.kernel.org/r/20250114230746.3268797-13-peterx@redhat.com
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/migration.c | 13 +++++++++++--
 migration/savevm.c    |  1 -
 migration/savevm.h    |  1 +
 3 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 72802d6133..d29f7448bd 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2693,7 +2693,11 @@ static int postcopy_start(MigrationState *ms, Error **errp)
      * Cause any non-postcopiable, but iterative devices to
      * send out their final data.
      */
-    qemu_savevm_state_complete_precopy(ms->to_dst_file, true);
+    ret = qemu_savevm_state_complete_precopy_iterable(ms->to_dst_file, true);
+    if (ret) {
+        error_setg(errp, "Postcopy save non-postcopiable iterables failed");
+        goto fail;
+    }
 
     /*
      * in Finish migrate and with the io-lock held everything should
@@ -2732,7 +2736,12 @@ static int postcopy_start(MigrationState *ms, Error **errp)
      */
     qemu_savevm_send_postcopy_listen(fb);
 
-    qemu_savevm_state_complete_precopy(fb, false);
+    ret = qemu_savevm_state_complete_precopy_non_iterable(fb, true);
+    if (ret) {
+        error_setg(errp, "Postcopy save non-iterable device states failed");
+        goto fail_closefb;
+    }
+
     if (migrate_postcopy_ram()) {
         qemu_savevm_send_ping(fb, 3);
     }
diff --git a/migration/savevm.c b/migration/savevm.c
index 9aef2fa3c9..0ddc4c8eb5 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1477,7 +1477,6 @@ void qemu_savevm_state_complete_postcopy(QEMUFile *f)
     qemu_fflush(f);
 }
 
-static
 int qemu_savevm_state_complete_precopy_iterable(QEMUFile *f, bool in_postcopy)
 {
     int64_t start_ts_each, end_ts_each;
diff --git a/migration/savevm.h b/migration/savevm.h
index c48a53e95e..7957460062 100644
--- a/migration/savevm.h
+++ b/migration/savevm.h
@@ -44,6 +44,7 @@ void qemu_savevm_state_pending_exact(uint64_t *must_precopy,
                                      uint64_t *can_postcopy);
 void qemu_savevm_state_pending_estimate(uint64_t *must_precopy,
                                         uint64_t *can_postcopy);
+int qemu_savevm_state_complete_precopy_iterable(QEMUFile *f, bool in_postcopy);
 void qemu_savevm_send_ping(QEMUFile *f, uint32_t value);
 void qemu_savevm_send_open_return_path(QEMUFile *f);
 int qemu_savevm_send_packaged(QEMUFile *f, const uint8_t *buf, size_t len);
-- 
2.35.3


