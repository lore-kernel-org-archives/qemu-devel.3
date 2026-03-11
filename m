Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79DC0103E2E6
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 21:36:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0RCZ-0005O6-Ns; Wed, 11 Mar 2026 17:34:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1w0RCX-0005Nw-TB
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 17:34:45 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1w0RCW-00036R-9R
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 17:34:45 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 9400E5BD98;
 Wed, 11 Mar 2026 21:34:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1773264867; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AR7PLUvSbBLT70HkEnsn7rXXK9qRCLWS1OcibFDk2p0=;
 b=Pw3QTn1RtD92Ev2QgR7jfcQf6J7EEOonXVvzwWRdAVnSxnqz1rNaM3IyYUS1REJf6u3qsD
 0okt1wegePfKmTgS9AGSAwqnCSK4m8txkdYSnUROHvq1GIpvmfclHNZZDNe/JLtoVNQS5d
 pHQ3kqBrun/O4EipgsnhD9GGgFXa+U8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1773264867;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AR7PLUvSbBLT70HkEnsn7rXXK9qRCLWS1OcibFDk2p0=;
 b=eJfSIdz+IYPluNO8xva7tvjor+ad2+xQmlHv3Xkq9ap4ChTUNIfLLhkjSBv2L3d/1pZGwg
 PqZXbt5ocamL06CA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1773264867; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AR7PLUvSbBLT70HkEnsn7rXXK9qRCLWS1OcibFDk2p0=;
 b=Pw3QTn1RtD92Ev2QgR7jfcQf6J7EEOonXVvzwWRdAVnSxnqz1rNaM3IyYUS1REJf6u3qsD
 0okt1wegePfKmTgS9AGSAwqnCSK4m8txkdYSnUROHvq1GIpvmfclHNZZDNe/JLtoVNQS5d
 pHQ3kqBrun/O4EipgsnhD9GGgFXa+U8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1773264867;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AR7PLUvSbBLT70HkEnsn7rXXK9qRCLWS1OcibFDk2p0=;
 b=eJfSIdz+IYPluNO8xva7tvjor+ad2+xQmlHv3Xkq9ap4ChTUNIfLLhkjSBv2L3d/1pZGwg
 PqZXbt5ocamL06CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E98623FC1F;
 Wed, 11 Mar 2026 21:34:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id WN8HKuHfsWngUgAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 11 Mar 2026 21:34:25 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Prasad Pandit <ppandit@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 2/5] io: Fix TLS bye task leak
Date: Wed, 11 Mar 2026 18:34:15 -0300
Message-ID: <20260311213418.16951-3-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260311213418.16951-1-farosas@suse.de>
References: <20260311213418.16951-1-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.987]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
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

Recent fixes to TLS tasks memory handling have left the TLS bye task
uncovered. Fix by freeing the task in the same way the handshake task
is freed.

Direct leak of 704 byte(s) in 4 object(s) allocated from:
    #1 0x7f5909b1d6a0 in g_malloc0 ../glib/gmem.c:163
    #2 0x557650496d61 in qio_task_new ../io/task.c:58:12
    #3 0x557650475d7f in qio_channel_tls_bye ../io/channel-tls.c:352:12
    #4 0x55764f7a1bb4 in migration_tls_channel_end ../migration/tls.c:159:5
    #5 0x55764f709750 in migration_ioc_shutdown_gracefully ../migration/multifd.c:462:9
    #6 0x55764f6fcf53 in multifd_send_terminate_threads ../migration/multifd.c:493:13
    #7 0x55764f6fcafb in multifd_send_shutdown ../migration/multifd.c:580:5
    #8 0x55764f6e1b14 in migration_cleanup ../migration/migration.c:1323:9
    #9 0x55764f6f5bac in migration_cleanup_bh ../migration/migration.c:1350:5

Fixes: d39d0f3acd ("io: fix cleanup for TLS I/O source data on cancellation")
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Acked-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 io/channel-tls.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/io/channel-tls.c b/io/channel-tls.c
index 940fc3c6d1..31ec4d236d 100644
--- a/io/channel-tls.c
+++ b/io/channel-tls.c
@@ -352,7 +352,9 @@ void qio_channel_tls_bye(QIOChannelTLS *ioc, Error **errp)
     task = qio_task_new(OBJECT(ioc), propagate_error, errp, NULL);
 
     trace_qio_channel_tls_bye_start(ioc);
-    qio_channel_tls_bye_task(ioc, task, NULL);
+    if (qio_channel_tls_bye_task(ioc, task, NULL)) {
+        qio_task_free(task);
+    }
 }
 
 static void qio_channel_tls_init(Object *obj G_GNUC_UNUSED)
-- 
2.51.0


