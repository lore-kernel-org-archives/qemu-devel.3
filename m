Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DA63C48BC1
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Feb 2024 20:36:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raLyU-0003gd-Vi; Wed, 14 Feb 2024 15:35:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1raLyS-0003gS-Ti
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 15:35:20 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1raLyQ-0004S1-Px
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 15:35:20 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 4FAC521CD3;
 Wed, 14 Feb 2024 20:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1707942915; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TrTrBnFgL2hhXfS1GOpPABeSQmXwB3hNHyPpF7yMSjA=;
 b=JnroOVf9cd3uGNI77Wl+fn9P3IUOxmdU7TuXt5HGQawqK901RB8J06OcErwaQUEbcf/fKq
 VZkfalmb3zOfSXU+U7ymqOM/EBIvsU64/FNCf1TSkZ1ZGXBiOq0Vfr06Hz5GvfZN/TQITy
 /rfFhsQLHye9saENNbUn9aya9kLeSl0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1707942915;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TrTrBnFgL2hhXfS1GOpPABeSQmXwB3hNHyPpF7yMSjA=;
 b=XJ6AY+c+B141K+mkd2iQ2Ob9Be55Ny49I7V5IqsA7RvfDPIXgnR3du6D8eC4xhrWlEVLCv
 3Vzfj+DlFjnn/YCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1707942915; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TrTrBnFgL2hhXfS1GOpPABeSQmXwB3hNHyPpF7yMSjA=;
 b=JnroOVf9cd3uGNI77Wl+fn9P3IUOxmdU7TuXt5HGQawqK901RB8J06OcErwaQUEbcf/fKq
 VZkfalmb3zOfSXU+U7ymqOM/EBIvsU64/FNCf1TSkZ1ZGXBiOq0Vfr06Hz5GvfZN/TQITy
 /rfFhsQLHye9saENNbUn9aya9kLeSl0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1707942915;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TrTrBnFgL2hhXfS1GOpPABeSQmXwB3hNHyPpF7yMSjA=;
 b=XJ6AY+c+B141K+mkd2iQ2Ob9Be55Ny49I7V5IqsA7RvfDPIXgnR3du6D8eC4xhrWlEVLCv
 3Vzfj+DlFjnn/YCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CF71313A72;
 Wed, 14 Feb 2024 20:35:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id JYkqJQIkzWXacwAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 14 Feb 2024 20:35:14 +0000
From: Fabiano Rosas <farosas@suse.de>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [RFC PATCH 14/14] migration: Fix return-path thread exit
In-Reply-To: <50ca9637-bc18-4002-abc3-52c1bb834038@redhat.com>
References: <20240207133347.1115903-1-clg@redhat.com>
 <20240207133347.1115903-15-clg@redhat.com> <87v86zaxtv.fsf@suse.de>
 <50ca9637-bc18-4002-abc3-52c1bb834038@redhat.com>
Date: Wed, 14 Feb 2024 17:35:12 -0300
Message-ID: <87mss2pywv.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=JnroOVf9;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=XJ6AY+c+
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-5.51 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 BAYES_HAM(-3.00)[100.00%]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 DWL_DNSWL_LOW(-1.00)[suse.de:dkim]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]; MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 RCVD_TLS_ALL(0.00)[]; MID_RHS_MATCH_FROM(0.00)[]
X-Rspamd-Queue-Id: 4FAC521CD3
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

C=C3=A9dric Le Goater <clg@redhat.com> writes:

> Hello Fabiano
>
> On 2/8/24 14:29, Fabiano Rosas wrote:
>> C=C3=A9dric Le Goater <clg@redhat.com> writes:
>>=20
>>> In case of error, close_return_path_on_source() can perform a shutdown
>>> to exit the return-path thread.  However, in migrate_fd_cleanup(),
>>> 'to_dst_file' is closed before calling close_return_path_on_source()
>>> and the shutdown fails, leaving the source and destination waiting for
>>> an event to occur.
>>=20
>> Hi, C=C3=A9dric
>>=20
>> Are you sure this is not caused by patch 13?=20
>
> It happens with upstream QEMU without any patch.

I might have taken that "shutdown fails" in the commit message too
literaly. Anyway, I have a proposed solution:

-->8--
From 729aa7b5b7f130f756d41649fdd0862bd2e90430 Mon Sep 17 00:00:00 2001
From: Fabiano Rosas <farosas@suse.de>
Date: Wed, 14 Feb 2024 16:45:43 -0300
Subject: [PATCH] migration: Join the return path thread before releasing
 to_dst_file
MIME-Version: 1.0
Content-Type: text/plain; charset=3DUTF-8
Content-Transfer-Encoding: 8bit

The return path thread might hang at a blocking system call. Before
joining the thread we might need to issue a shutdown() on the socket
file descriptor to release it. To determine whether the shutdown() is
necessary we look at the QEMUFile error.

Make sure we only clean up the QEMUFile after the return path has been
waited for.

This fixes a hang when qemu_savevm_state_setup() produced an error
that was detected by migration_detect_error(). That skips
migration_completion() so close_return_path_on_source() would get
stuck waiting for the RP thread to terminate.

At migrate_fd_cleanup() I'm keeping the relative order of joining the
migration thread and the return path just in case.

Reported-by: C=C3=A9dric Le Goater <clg@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/migration.c | 36 ++++++++++++++++--------------------
 1 file changed, 16 insertions(+), 20 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index ab21de2cad..f0b70e8a9d 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1326,17 +1326,19 @@ static void migrate_fd_cleanup(MigrationState *s)
=20
     qemu_savevm_state_cleanup();
=20
+    bql_unlock();
+    if (s->migration_thread_running) {
+        qemu_thread_join(&s->thread);
+        s->migration_thread_running =3D false;
+    }
+    bql_lock();
+
+    close_return_path_on_source(s);
+
     if (s->to_dst_file) {
         QEMUFile *tmp;
=20
         trace_migrate_fd_cleanup();
-        bql_unlock();
-        if (s->migration_thread_running) {
-            qemu_thread_join(&s->thread);
-            s->migration_thread_running =3D false;
-        }
-        bql_lock();
-
         multifd_send_shutdown();
         qemu_mutex_lock(&s->qemu_file_lock);
         tmp =3D s->to_dst_file;
@@ -1350,12 +1352,6 @@ static void migrate_fd_cleanup(MigrationState *s)
         qemu_fclose(tmp);
     }
=20
-    /*
-     * We already cleaned up to_dst_file, so errors from the return
-     * path might be due to that, ignore them.
-     */
-    close_return_path_on_source(s);
-
     assert(!migration_is_active(s));
=20
     if (s->state =3D=3D MIGRATION_STATUS_CANCELLING) {
@@ -2874,6 +2870,13 @@ static MigThrError postcopy_pause(MigrationState *s)
     while (true) {
         QEMUFile *file;
=20
+        /*
+         * We're already pausing, so ignore any errors on the return
+         * path and just wait for the thread to finish. It will be
+         * re-created when we resume.
+         */
+        close_return_path_on_source(s);
+
         /*
          * Current channel is possibly broken. Release it.  Note that this=
 is
          * guaranteed even without lock because to_dst_file should only be
@@ -2893,13 +2896,6 @@ static MigThrError postcopy_pause(MigrationState *s)
         qemu_file_shutdown(file);
         qemu_fclose(file);
=20
-        /*
-         * We're already pausing, so ignore any errors on the return
-         * path and just wait for the thread to finish. It will be
-         * re-created when we resume.
-         */
-        close_return_path_on_source(s);
-
         migrate_set_state(&s->state, s->state,
                           MIGRATION_STATUS_POSTCOPY_PAUSED);
=20
--=20
2.35.3

