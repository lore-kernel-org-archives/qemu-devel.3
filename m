Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3DC0CD129A
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 15:01:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruCxe-0002lV-8W; Tue, 09 Apr 2024 11:00:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1ruCxI-0002OU-Ob; Tue, 09 Apr 2024 11:00:16 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1ruCxD-0006Bk-Uz; Tue, 09 Apr 2024 11:00:11 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3F07B33A58;
 Tue,  9 Apr 2024 15:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1712674806; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PK1BOaSiznR5Y3Tqkn92pIJcwhfufC71cNAlVZbSpgA=;
 b=H2unQWHkXDZqT18q+YNVpxXjfsj1RiOnqjlqp1rSdV7sYsvE2d2HiVlyP6gG/3ibCwFT4e
 rPtJaQirrdBMokM9dHpr22f5wDVePpxfIC6Zbn4VUxjXK1MWuWPx9ljMXmY2gih6gDS1Og
 45fTAvApYLb4VZNyJbZJupGniP93014=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1712674806;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PK1BOaSiznR5Y3Tqkn92pIJcwhfufC71cNAlVZbSpgA=;
 b=t36fCesvaDe8JTtSXiXKMXCDXMuNNWF6z3ptpFDqdNCCQFdzgJ0P0MnmuSUYJWQhWMR/fa
 fMAkH9xU9IDWNjBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1712674806; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PK1BOaSiznR5Y3Tqkn92pIJcwhfufC71cNAlVZbSpgA=;
 b=H2unQWHkXDZqT18q+YNVpxXjfsj1RiOnqjlqp1rSdV7sYsvE2d2HiVlyP6gG/3ibCwFT4e
 rPtJaQirrdBMokM9dHpr22f5wDVePpxfIC6Zbn4VUxjXK1MWuWPx9ljMXmY2gih6gDS1Og
 45fTAvApYLb4VZNyJbZJupGniP93014=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1712674806;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PK1BOaSiznR5Y3Tqkn92pIJcwhfufC71cNAlVZbSpgA=;
 b=t36fCesvaDe8JTtSXiXKMXCDXMuNNWF6z3ptpFDqdNCCQFdzgJ0P0MnmuSUYJWQhWMR/fa
 fMAkH9xU9IDWNjBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0EF0A13313;
 Tue,  9 Apr 2024 15:00:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id CCfqMfJXFWZGOAAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 09 Apr 2024 15:00:02 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Jo=C3=A3o=20Silva?= <jsilva@suse.de>, Lin Ma <lma@suse.com>,
 Claudio Fontana <cfontana@suse.de>, Dario Faggioli <dfaggioli@suse.com>,
 Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v3 11/11] block: Add a thread-pool version of fstat
Date: Tue,  9 Apr 2024 11:59:17 -0300
Message-Id: <20240409145917.6780-12-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240409145917.6780-1-farosas@suse.de>
References: <20240409145917.6780-1-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; TO_DN_SOME(0.00)[];
 RCPT_COUNT_TWELVE(0.00)[12]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 R_RATELIMIT(0.00)[to_ip_from(RL14emxp6ck9fz14jedoy69s36)];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email]
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

From: João Silva <jsilva@suse.de>

The fstat call can take a long time to finish when running over
NFS. Add a version of it that runs in the thread pool.

Adapt one of its users, raw_co_get_allocated_file size to use the new
version. That function is called via QMP under the qemu_global_mutex
so it has a large chance of blocking VCPU threads in case it takes too
long to finish.

Reviewed-by: Claudio Fontana <cfontana@suse.de>
Reviewed-by: Hanna Czenczek <hreitz@redhat.com>
Signed-off-by: João Silva <jsilva@suse.de>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 block/file-posix.c      | 40 +++++++++++++++++++++++++++++++++++++---
 include/block/raw-aio.h |  4 +++-
 2 files changed, 40 insertions(+), 4 deletions(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index 35684f7e21..6fbf961244 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -226,6 +226,9 @@ typedef struct RawPosixAIOData {
         struct {
             unsigned long op;
         } zone_mgmt;
+        struct {
+            struct stat *st;
+        } fstat;
     };
 } RawPosixAIOData;
 
@@ -2616,6 +2619,34 @@ static void raw_close(BlockDriverState *bs)
     }
 }
 
+static int handle_aiocb_fstat(void *opaque)
+{
+    RawPosixAIOData *aiocb = opaque;
+
+    if (fstat(aiocb->aio_fildes, aiocb->fstat.st) < 0) {
+        return -errno;
+    }
+
+    return 0;
+}
+
+static int coroutine_fn raw_co_fstat(BlockDriverState *bs, struct stat *st)
+{
+    BDRVRawState *s = bs->opaque;
+    RawPosixAIOData acb;
+
+    acb = (RawPosixAIOData) {
+        .bs             = bs,
+        .aio_fildes     = s->fd,
+        .aio_type       = QEMU_AIO_FSTAT,
+        .fstat          = {
+            .st = st,
+        },
+    };
+
+    return raw_thread_pool_submit(handle_aiocb_fstat, &acb);
+}
+
 /**
  * Truncates the given regular file @fd to @offset and, when growing, fills the
  * new space according to @prealloc.
@@ -2860,11 +2891,14 @@ static int64_t coroutine_fn raw_co_getlength(BlockDriverState *bs)
 static int64_t coroutine_fn raw_co_get_allocated_file_size(BlockDriverState *bs)
 {
     struct stat st;
-    BDRVRawState *s = bs->opaque;
+    int ret;
 
-    if (fstat(s->fd, &st) < 0) {
-        return -errno;
+    ret = raw_co_fstat(bs, &st);
+
+    if (ret) {
+        return ret;
     }
+
     return (int64_t)st.st_blocks * 512;
 }
 
diff --git a/include/block/raw-aio.h b/include/block/raw-aio.h
index 20e000b8ef..0c6af8dc32 100644
--- a/include/block/raw-aio.h
+++ b/include/block/raw-aio.h
@@ -31,6 +31,7 @@
 #define QEMU_AIO_ZONE_REPORT  0x0100
 #define QEMU_AIO_ZONE_MGMT    0x0200
 #define QEMU_AIO_ZONE_APPEND  0x0400
+#define QEMU_AIO_FSTAT        0x0800
 #define QEMU_AIO_TYPE_MASK \
         (QEMU_AIO_READ | \
          QEMU_AIO_WRITE | \
@@ -42,7 +43,8 @@
          QEMU_AIO_TRUNCATE | \
          QEMU_AIO_ZONE_REPORT | \
          QEMU_AIO_ZONE_MGMT | \
-         QEMU_AIO_ZONE_APPEND)
+         QEMU_AIO_ZONE_APPEND | \
+         QEMU_AIO_FSTAT)
 
 /* AIO flags */
 #define QEMU_AIO_MISALIGNED   0x1000
-- 
2.35.3


