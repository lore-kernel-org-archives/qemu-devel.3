Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B2BCC48297
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 21:52:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXTLs-0008AS-Dt; Tue, 06 Feb 2024 16:51:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1rXTLk-000866-En; Tue, 06 Feb 2024 16:51:29 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1rXTLi-00088H-Eq; Tue, 06 Feb 2024 16:51:28 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D86192213C;
 Tue,  6 Feb 2024 21:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1707256285; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ycq1DKWOHGRISoq+AdX4R7quKU3E+TkylEAGSaqJFSM=;
 b=ZE/hvJT0POy8bKbKBj/VmbeBMmSnstpwHb5aYBF8+HTaaQinkaH9jHeyjybjJS9G+fUeC0
 CwTFso9q7OqV1aScJsCXql9qYa5Fp9wIyM1tYz3SYVxIMdz3aKcB7ic1HFa7Rkr0e9MBmO
 a4h63J/3IKmyUZi6Ts5M7cqZ+Q0i4+o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1707256285;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ycq1DKWOHGRISoq+AdX4R7quKU3E+TkylEAGSaqJFSM=;
 b=udRlnSufKfNQyLxZ3cvNZ8EymMxXaoTGh6zIzAOCkcMp48fXG8cJS8i5wsZXN+IIpV/E32
 Zx6ENlv5sTy4rOAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1707256284; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ycq1DKWOHGRISoq+AdX4R7quKU3E+TkylEAGSaqJFSM=;
 b=UU9g24n5pqGbFvAhuGdoUl/toHugxB6XSOJ3Zlb0jYCu9mqLLunXiqOpOdY334tIU7ybGg
 fddDgYU/PJKcD67nRinscb/hB+uwHlT+mGMlXxAh2yzqAoOmV8fFQmrZjaGBD8t1R+ogxy
 +2znQ5utpCh0I1KgWq+9MQCIt2WI6d4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1707256284;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ycq1DKWOHGRISoq+AdX4R7quKU3E+TkylEAGSaqJFSM=;
 b=J1zRs4I3ISjzjZqouB6nyJ11+qEfSSFm+sfcz1CnXxvvBocate+BnJ0gMp0sqU+NdoKad4
 GG24xpdhv2mP6DCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3FA01132DD;
 Tue,  6 Feb 2024 21:51:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id kAsDAtupwmWzQAAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 06 Feb 2024 21:51:23 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Avihai Horon <avihaih@nvidia.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-stable <qemu-stable@nongnu.org>
Subject: [PATCH v3 1/6] migration/multifd: Join the TLS thread
Date: Tue,  6 Feb 2024 18:51:13 -0300
Message-Id: <20240206215118.6171-2-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240206215118.6171-1-farosas@suse.de>
References: <20240206215118.6171-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [0.70 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; R_MISSING_CHARSET(2.50)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 BROKEN_CONTENT_TYPE(1.50)[]; RCPT_COUNT_FIVE(0.00)[5];
 NEURAL_HAM_LONG(-1.00)[-1.000]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-3.00)[100.00%]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

We're currently leaking the resources of the TLS thread by not joining
it and also overwriting the p->thread pointer altogether.

Fixes: a1af605bd5 ("migration/multifd: fix hangup with TLS-Multifd due to blocking handshake")
Cc: qemu-stable <qemu-stable@nongnu.org>
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/multifd.c | 8 +++++++-
 migration/multifd.h | 2 ++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/migration/multifd.c b/migration/multifd.c
index ef13e2e781..8195c1daf3 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -630,6 +630,10 @@ static void multifd_send_terminate_threads(void)
     for (i = 0; i < migrate_multifd_channels(); i++) {
         MultiFDSendParams *p = &multifd_send_state->params[i];
 
+        if (p->tls_thread_created) {
+            qemu_thread_join(&p->tls_thread);
+        }
+
         if (p->running) {
             qemu_thread_join(&p->thread);
         }
@@ -921,7 +925,9 @@ static bool multifd_tls_channel_connect(MultiFDSendParams *p,
     trace_multifd_tls_outgoing_handshake_start(ioc, tioc, hostname);
     qio_channel_set_name(QIO_CHANNEL(tioc), "multifd-tls-outgoing");
     p->c = QIO_CHANNEL(tioc);
-    qemu_thread_create(&p->thread, "multifd-tls-handshake-worker",
+
+    p->tls_thread_created = true;
+    qemu_thread_create(&p->tls_thread, "multifd-tls-handshake-worker",
                        multifd_tls_handshake_thread, p,
                        QEMU_THREAD_JOINABLE);
     return true;
diff --git a/migration/multifd.h b/migration/multifd.h
index 78a2317263..720c9d50db 100644
--- a/migration/multifd.h
+++ b/migration/multifd.h
@@ -73,6 +73,8 @@ typedef struct {
     char *name;
     /* channel thread id */
     QemuThread thread;
+    QemuThread tls_thread;
+    bool tls_thread_created;
     /* communication channel */
     QIOChannel *c;
     /* is the yank function registered */
-- 
2.35.3


