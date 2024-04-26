Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C86A0C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2024 14:21:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s0MRl-00076d-VN; Fri, 26 Apr 2024 10:21:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1s0MRb-00074q-2X
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 10:21:00 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1s0MRZ-0001n5-Bb
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 10:20:54 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C55F9227DD;
 Fri, 26 Apr 2024 14:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1714141251; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c7pq969m/eSku4SA1kn+8rZjTBbc88kbtQ4svsW/Eqg=;
 b=UnOGFWXwhn58pwJAs2sANqUv1JGicl+2e/oYpJNUZwameGB64S2rN2OC4YNGxmm1O3wwjx
 4v/MQBAEMA+gsM8JilBlfu8hXtDwLbpKso7vg7Lh7mZ2GiVRIOZFrJBHIUSMrDEAXi91wF
 9t5Bny/eqPGwCCbe0Jo7iQUSP6VmnlE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1714141251;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c7pq969m/eSku4SA1kn+8rZjTBbc88kbtQ4svsW/Eqg=;
 b=jIJGFD5OHOz9kMy4sLgIQlJmxkVJdmndbFrhgxLuZPQNis8np+N9kGdqWZTWb5GDSbPukP
 7W7N8pQP+HapNcDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1714141251; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c7pq969m/eSku4SA1kn+8rZjTBbc88kbtQ4svsW/Eqg=;
 b=UnOGFWXwhn58pwJAs2sANqUv1JGicl+2e/oYpJNUZwameGB64S2rN2OC4YNGxmm1O3wwjx
 4v/MQBAEMA+gsM8JilBlfu8hXtDwLbpKso7vg7Lh7mZ2GiVRIOZFrJBHIUSMrDEAXi91wF
 9t5Bny/eqPGwCCbe0Jo7iQUSP6VmnlE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1714141251;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c7pq969m/eSku4SA1kn+8rZjTBbc88kbtQ4svsW/Eqg=;
 b=jIJGFD5OHOz9kMy4sLgIQlJmxkVJdmndbFrhgxLuZPQNis8np+N9kGdqWZTWb5GDSbPukP
 7W7N8pQP+HapNcDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ECFB1136DB;
 Fri, 26 Apr 2024 14:20:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 6M13LEG4K2YWcAAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 26 Apr 2024 14:20:49 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, armbru@redhat.com, Peter Xu <peterx@redhat.com>,
 Claudio Fontana <cfontana@suse.de>, Jim Fehlig <jfehlig@suse.com>
Subject: [PATCH 2/9] migration: Fix file migration with fdset
Date: Fri, 26 Apr 2024 11:20:35 -0300
Message-Id: <20240426142042.14573-3-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240426142042.14573-1-farosas@suse.de>
References: <20240426142042.14573-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.991];
 MIME_GOOD(-0.10)[text/plain]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_FIVE(0.00)[6];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 RCVD_TLS_ALL(0.00)[]
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

When the migration using the "file:" URI was implemented, I don't
think any of us noticed that if you pass in a file name with the
format "/dev/fdset/N", this allows a file descriptor to be passed in
to QEMU and that behaves just like the "fd:" URI. So the "file:"
support has been added without regard for the fdset part and we got
some things wrong.

The first issue is that we should not truncate the migration file if
we're allowing an fd + offset. We need to leave the file contents
untouched.

The second issue is that there's an expectation that QEMU removes the
fd after the migration has finished. That's what the "fd:" code
does. Otherwise a second migration on the same VM could attempt to
provide an fdset with the same name and QEMU would reject it.

We can fix the first issue by detecting when we're using the fdset
vs. the plain file name. This requires storing the fdset_id
somewhere. We can then use this stored fdset_id to do cleanup at the
end and also fix the second issue.

Fixes: 385f510df5 ("migration: file URI offset")
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/file.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 46 insertions(+), 2 deletions(-)

diff --git a/migration/file.c b/migration/file.c
index ab18ba505a..8f30999400 100644
--- a/migration/file.c
+++ b/migration/file.c
@@ -10,6 +10,7 @@
 #include "qemu/cutils.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
+#include "qapi/qapi-commands-misc.h"
 #include "channel.h"
 #include "file.h"
 #include "migration.h"
@@ -23,6 +24,7 @@
 
 static struct FileOutgoingArgs {
     char *fname;
+    int64_t fdset_id;
 } outgoing_args;
 
 /* Remove the offset option from @filespec and return it in @offsetp. */
@@ -44,10 +46,39 @@ int file_parse_offset(char *filespec, uint64_t *offsetp, Error **errp)
     return 0;
 }
 
+static void file_remove_fdset(void)
+{
+    if (outgoing_args.fdset_id != -1) {
+        qmp_remove_fd(outgoing_args.fdset_id, false, -1, NULL);
+        outgoing_args.fdset_id = -1;
+    }
+}
+
+static bool file_parse_fdset(const char *filename, int64_t *fdset_id,
+                             Error **errp)
+{
+    const char *fdset_id_str;
+
+    *fdset_id = -1;
+
+    if (!strstart(filename, "/dev/fdset/", &fdset_id_str)) {
+        return true;
+    }
+
+    *fdset_id = qemu_parse_fd(fdset_id_str);
+    if (*fdset_id == -1) {
+        error_setg_errno(errp, EINVAL, "Could not parse fdset %s", fdset_id_str);
+        return false;
+    }
+
+    return true;
+}
+
 void file_cleanup_outgoing_migration(void)
 {
     g_free(outgoing_args.fname);
     outgoing_args.fname = NULL;
+    file_remove_fdset();
 }
 
 bool file_send_channel_create(gpointer opaque, Error **errp)
@@ -81,11 +112,24 @@ void file_start_outgoing_migration(MigrationState *s,
     g_autofree char *filename = g_strdup(file_args->filename);
     uint64_t offset = file_args->offset;
     QIOChannel *ioc;
+    int flags = O_CREAT | O_WRONLY;
 
     trace_migration_file_outgoing(filename);
 
-    fioc = qio_channel_file_new_path(filename, O_CREAT | O_WRONLY | O_TRUNC,
-                                     0600, errp);
+    if (!file_parse_fdset(filename, &outgoing_args.fdset_id, errp)) {
+        return;
+    }
+
+    /*
+     * Only truncate if it's QEMU opening the file. If an fd has been
+     * passed in the file will already contain data written by the
+     * management layer.
+     */
+    if (outgoing_args.fdset_id == -1) {
+        flags |= O_TRUNC;
+    }
+
+    fioc = qio_channel_file_new_path(filename, flags, 0600, errp);
     if (!fioc) {
         return;
     }
-- 
2.35.3


