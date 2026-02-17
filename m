Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D53A6E909D0
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Feb 2026 16:16:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsNjS-0001BA-84; Tue, 17 Feb 2026 11:15:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vsNjR-0001An-05
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 11:15:25 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vsNjP-00038l-AG
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 11:15:24 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 61ED65BCE9;
 Tue, 17 Feb 2026 16:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1771344903; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=58uwS38Uq+psWbfenxNWR6JD7znOOEGkUWjLg3GIe/Q=;
 b=oEcUqkz5Ffl5xlBAUySTMfmPUa7UGmDA7wGm6N6l/6qiLpiaP/2LhXDceS64ChFSLUkFw6
 g5Gn9J50nqD6iPYpymbCY38QWaYcNnVT1G/sGX4hbbpVCSWv1PQ4J3mj2bLbI/yI//6mjL
 HiJHuMuSjE5LTSpRIC0+1cMW3BpX9bk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1771344903;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=58uwS38Uq+psWbfenxNWR6JD7znOOEGkUWjLg3GIe/Q=;
 b=0+HeBBH3mJEVYhjHK8Z7MHkcdXBEUF8+76iVh2zrzRQgwtqjNK6N95Ez4PgAuZ9HfIwcis
 ddcCl7mu2eSr6SBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1771344903; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=58uwS38Uq+psWbfenxNWR6JD7znOOEGkUWjLg3GIe/Q=;
 b=oEcUqkz5Ffl5xlBAUySTMfmPUa7UGmDA7wGm6N6l/6qiLpiaP/2LhXDceS64ChFSLUkFw6
 g5Gn9J50nqD6iPYpymbCY38QWaYcNnVT1G/sGX4hbbpVCSWv1PQ4J3mj2bLbI/yI//6mjL
 HiJHuMuSjE5LTSpRIC0+1cMW3BpX9bk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1771344903;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=58uwS38Uq+psWbfenxNWR6JD7znOOEGkUWjLg3GIe/Q=;
 b=0+HeBBH3mJEVYhjHK8Z7MHkcdXBEUF8+76iVh2zrzRQgwtqjNK6N95Ez4PgAuZ9HfIwcis
 ddcCl7mu2eSr6SBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 288533EA66;
 Tue, 17 Feb 2026 16:15:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id yFakNwWUlGmHTgAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 17 Feb 2026 16:15:01 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
	Lukas Straub <lukasstraub2@web.de>
Subject: [PULL 09/32] migration: Remove one migration_in_colo_state() occurance
Date: Tue, 17 Feb 2026 13:14:20 -0300
Message-ID: <20260217161443.12738-10-farosas@suse.de>
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
 URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email];
 FROM_HAS_DN(0.00)[]; FREEMAIL_CC(0.00)[redhat.com,web.de];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[web.de]
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

From: Peter Xu <peterx@redhat.com>

Move the send header operation directly into Xen's QMP command, as COLO
doesn't need it.

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Peter Xu <peterx@redhat.com>
Tested-by: Lukas Straub <lukasstraub2@web.de>
Link: https://lore.kernel.org/qemu-devel/20260127185254.3954634-4-peterx@redhat.com
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/savevm.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index 64bf445c98..61e873d90c 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1871,9 +1871,6 @@ int qemu_save_device_state(QEMUFile *f)
     Error *local_err = NULL;
     SaveStateEntry *se;
 
-    if (!migration_in_colo_state()) {
-        qemu_savevm_send_header(f);
-    }
     cpu_synchronize_all_states();
 
     QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
@@ -3335,6 +3332,7 @@ void qmp_xen_save_devices_state(const char *filename, bool has_live, bool live,
     qio_channel_set_name(QIO_CHANNEL(ioc), "migration-xen-save-state");
     f = qemu_file_new_output(QIO_CHANNEL(ioc));
     object_unref(OBJECT(ioc));
+    qemu_savevm_send_header(f);
     ret = qemu_save_device_state(f);
     if (ret < 0 || qemu_fclose(f) < 0) {
         error_setg(errp, "saving Xen device state failed");
-- 
2.51.0


