Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C595E909D4
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Feb 2026 16:20:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsNk5-0002Nz-IA; Tue, 17 Feb 2026 11:16:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vsNk2-00021o-My
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 11:16:02 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vsNjz-0003D6-Ez
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 11:16:02 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1B6545BCFD;
 Tue, 17 Feb 2026 16:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1771344922; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Cp1/L9VLv4rwmbtSW57Mya9oHqi4a5jOhw+l/VFHbiE=;
 b=VYUC/s84tUOtW/O9BOny8MYlrBeBknI4Y/Q/2wbFXMKQLj++B1sVPww0ZOICL7G7k6UslC
 8VWlIXNTbanjqa2kLH8a4wKxjyXrFj5B8xy/oQXq0F9hCou4OYCFnIwoUBtI2b6U9ZlKrX
 s6eePPZ1yzKGBpcLErIg+Y1efuTY+zM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1771344922;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Cp1/L9VLv4rwmbtSW57Mya9oHqi4a5jOhw+l/VFHbiE=;
 b=XIglfEJNxbFDPVpizqFngSD9e1Hn8yFJ/Z/x1m5ZxUftl6RFR/inrdo/ipBmQjr4zFHymU
 8RASO1a5TuiiF7DA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1771344922; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Cp1/L9VLv4rwmbtSW57Mya9oHqi4a5jOhw+l/VFHbiE=;
 b=VYUC/s84tUOtW/O9BOny8MYlrBeBknI4Y/Q/2wbFXMKQLj++B1sVPww0ZOICL7G7k6UslC
 8VWlIXNTbanjqa2kLH8a4wKxjyXrFj5B8xy/oQXq0F9hCou4OYCFnIwoUBtI2b6U9ZlKrX
 s6eePPZ1yzKGBpcLErIg+Y1efuTY+zM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1771344922;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Cp1/L9VLv4rwmbtSW57Mya9oHqi4a5jOhw+l/VFHbiE=;
 b=XIglfEJNxbFDPVpizqFngSD9e1Hn8yFJ/Z/x1m5ZxUftl6RFR/inrdo/ipBmQjr4zFHymU
 8RASO1a5TuiiF7DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D5ED13EA66;
 Tue, 17 Feb 2026 16:15:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id UJFIJhiUlGmHTgAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 17 Feb 2026 16:15:20 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
	Lukas Straub <lukasstraub2@web.de>
Subject: [PULL 20/32] migration: Introduce qemu_savevm_state_end()
Date: Tue, 17 Feb 2026 13:14:31 -0300
Message-ID: <20260217161443.12738-21-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260217161443.12738-1-farosas@suse.de>
References: <20260217161443.12738-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; TO_DN_SOME(0.00)[];
 ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 URIBL_BLOCKED(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo];
 FROM_HAS_DN(0.00)[]; FREEMAIL_CC(0.00)[redhat.com,web.de];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[web.de]
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

From: Peter Xu <peterx@redhat.com>

Introduce a helper to end a migration stream.

Signed-off-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Tested-by: Lukas Straub <lukasstraub2@web.de>
Link: https://lore.kernel.org/qemu-devel/20260127185254.3954634-15-peterx@redhat.com
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/colo.c   |  2 +-
 migration/savevm.c | 12 +++++++++---
 migration/savevm.h |  1 +
 3 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/migration/colo.c b/migration/colo.c
index 0b1a58cd8f..db804b25a9 100644
--- a/migration/colo.c
+++ b/migration/colo.c
@@ -470,7 +470,7 @@ static int colo_do_checkpoint_transaction(MigrationState *s,
      * to be blocked here.
      */
     qemu_savevm_state_complete_precopy_iterable(s->to_dst_file, false);
-    qemu_put_byte(s->to_dst_file, QEMU_VM_EOF);
+    qemu_savevm_state_end(s->to_dst_file);
 
     /*
      * We need the size of the VMstate data in Secondary side,
diff --git a/migration/savevm.c b/migration/savevm.c
index d41e89228d..a787691352 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1065,6 +1065,12 @@ static int vmstate_save(QEMUFile *f, SaveStateEntry *se, JSONWriter *vmdesc,
     }
     return 0;
 }
+
+void qemu_savevm_state_end(QEMUFile *f)
+{
+    qemu_put_byte(f, QEMU_VM_EOF);
+}
+
 /**
  * qemu_savevm_command_send: Send a 'QEMU_VM_COMMAND' type element with the
  *                           command and associated data.
@@ -1555,7 +1561,7 @@ void qemu_savevm_state_complete_postcopy(QEMUFile *f)
         }
     }
 
-    qemu_put_byte(f, QEMU_VM_EOF);
+    qemu_savevm_state_end(f);
     qemu_fflush(f);
 }
 
@@ -1699,7 +1705,7 @@ int qemu_savevm_state_complete_precopy_non_iterable(QEMUFile *f,
 
     if (!in_postcopy) {
         /* Postcopy stream will still be going */
-        qemu_put_byte(f, QEMU_VM_EOF);
+        qemu_savevm_state_end(f);
 
         if (vmdesc) {
             json_writer_end_array(vmdesc);
@@ -1879,7 +1885,7 @@ int qemu_save_device_state(QEMUFile *f)
         }
     }
 
-    qemu_put_byte(f, QEMU_VM_EOF);
+    qemu_savevm_state_end(f);
 
     return qemu_file_get_error(f);
 }
diff --git a/migration/savevm.h b/migration/savevm.h
index ea01ca63ec..d0596d1d62 100644
--- a/migration/savevm.h
+++ b/migration/savevm.h
@@ -49,6 +49,7 @@ void qemu_savevm_state_pending_estimate(uint64_t *must_precopy,
                                         uint64_t *can_postcopy);
 int qemu_savevm_state_complete_precopy_iterable(QEMUFile *f, bool in_postcopy);
 bool qemu_savevm_state_postcopy_prepare(QEMUFile *f, Error **errp);
+void qemu_savevm_state_end(QEMUFile *f);
 void qemu_savevm_send_ping(QEMUFile *f, uint32_t value);
 void qemu_savevm_send_open_return_path(QEMUFile *f);
 int qemu_savevm_send_packaged(QEMUFile *f, const uint8_t *buf, size_t len);
-- 
2.51.0


