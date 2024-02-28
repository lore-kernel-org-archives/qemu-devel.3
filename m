Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67BE8C47DD9
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 15:23:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfLl9-0006hO-7N; Wed, 28 Feb 2024 10:22:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rfLl7-0006gD-4t
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 10:22:13 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rfLl3-0005F7-DS
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 10:22:12 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 4878C225BC;
 Wed, 28 Feb 2024 15:22:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1709133728; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A2b3t0dTIqBXcfpvqDqjao42bKkuPsmaNxYUbr7y5yk=;
 b=rfPsVp7hJjUHv93Gv9/PGnflcQYPgWUw8dOom7kuS6RisfjPfYsttkrT3nIyekrHg6n9uf
 FY6nPd4/uKqsyrVtL6ZwowAYnPxMpbwSFOcBpxpwNPzXMGjyH8FdPJnHAf1YoG3pxrWt82
 68Y52JTRROHGhYkiK7zVD6X/rSqCqOc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1709133728;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A2b3t0dTIqBXcfpvqDqjao42bKkuPsmaNxYUbr7y5yk=;
 b=NFsMPz2uvmFN9kmeH1wRE17Jp9rXVHqrhoDb2xhdy1kO4MZvTesGZrJxkj4AQyUtG2XVLW
 LFIX5FnI7f6uSSDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1709133728; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A2b3t0dTIqBXcfpvqDqjao42bKkuPsmaNxYUbr7y5yk=;
 b=rfPsVp7hJjUHv93Gv9/PGnflcQYPgWUw8dOom7kuS6RisfjPfYsttkrT3nIyekrHg6n9uf
 FY6nPd4/uKqsyrVtL6ZwowAYnPxMpbwSFOcBpxpwNPzXMGjyH8FdPJnHAf1YoG3pxrWt82
 68Y52JTRROHGhYkiK7zVD6X/rSqCqOc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1709133728;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A2b3t0dTIqBXcfpvqDqjao42bKkuPsmaNxYUbr7y5yk=;
 b=NFsMPz2uvmFN9kmeH1wRE17Jp9rXVHqrhoDb2xhdy1kO4MZvTesGZrJxkj4AQyUtG2XVLW
 LFIX5FnI7f6uSSDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A966113A5D;
 Wed, 28 Feb 2024 15:22:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id QJ3AG55P32UPAwAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 28 Feb 2024 15:22:06 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, armbru@redhat.com, Peter Xu <peterx@redhat.com>,
 Claudio Fontana <cfontana@suse.de>
Subject: [PATCH v5 16/23] migration/multifd: Add a wrapper for channels_created
Date: Wed, 28 Feb 2024 12:21:20 -0300
Message-Id: <20240228152127.18769-17-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240228152127.18769-1-farosas@suse.de>
References: <20240228152127.18769-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [1.37 / 50.00]; ARC_NA(0.00)[];
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
 BAYES_HAM(-2.33)[96.89%]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
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

We'll need to access multifd_send_state->channels_created from outside
multifd.c, so introduce a helper for that.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/multifd.c | 7 ++++++-
 migration/multifd.h | 1 +
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/migration/multifd.c b/migration/multifd.c
index d470af73ba..3574fd3953 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -101,6 +101,11 @@ static bool multifd_use_packets(void)
     return !migrate_mapped_ram();
 }
 
+void multifd_send_channel_created(void)
+{
+    qemu_sem_post(&multifd_send_state->channels_created);
+}
+
 /* Multifd without compression */
 
 /**
@@ -1023,7 +1028,7 @@ out:
      * Here we're not interested whether creation succeeded, only that
      * it happened at all.
      */
-    qemu_sem_post(&multifd_send_state->channels_created);
+    multifd_send_channel_created();
 
     if (ret) {
         return;
diff --git a/migration/multifd.h b/migration/multifd.h
index 1be985978e..1d8bbaf96b 100644
--- a/migration/multifd.h
+++ b/migration/multifd.h
@@ -17,6 +17,7 @@ typedef struct MultiFDRecvData MultiFDRecvData;
 
 bool multifd_send_setup(void);
 void multifd_send_shutdown(void);
+void multifd_send_channel_created(void);
 int multifd_recv_setup(Error **errp);
 void multifd_recv_cleanup(void);
 void multifd_recv_shutdown(void);
-- 
2.35.3


