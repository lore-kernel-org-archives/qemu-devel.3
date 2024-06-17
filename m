Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51B7DC27C79
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2024 19:00:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJHYZ-0003w8-9o; Mon, 17 Jun 2024 14:58:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sJHYX-0003vi-DT
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 14:58:17 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sJHYV-0004v9-HE
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 14:58:17 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 41C741F7A6;
 Mon, 17 Jun 2024 18:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1718650694; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dpaA8UyxtRDsfB5RjDLzg2FDrDvAArW4wQMiSrS11Zc=;
 b=wASqEzQmQuQYa6iRWJL/VKvh9H+L2Bk3skkYbpAofBZqkDVtpL+B7Nk62FnQOkUwKFRwbb
 yAQJzHOsb7GXyA+6YCt1wGTD4Y5e24QgeDzt2xYNAYIw4jb2SNPugOBFCQ5sjm07kKUyHX
 yWXPihA/f45AHAoi7ObXZBd4EdGFigk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1718650694;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dpaA8UyxtRDsfB5RjDLzg2FDrDvAArW4wQMiSrS11Zc=;
 b=1np21OVr7AxYYxIS9oSXXieS9XzzcjD2QzmDYKmRUo5IZ8Mu3Is6CiRyf6Rk3QASCWZtkg
 dqjE+CIKPuVIygCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1718650694; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dpaA8UyxtRDsfB5RjDLzg2FDrDvAArW4wQMiSrS11Zc=;
 b=wASqEzQmQuQYa6iRWJL/VKvh9H+L2Bk3skkYbpAofBZqkDVtpL+B7Nk62FnQOkUwKFRwbb
 yAQJzHOsb7GXyA+6YCt1wGTD4Y5e24QgeDzt2xYNAYIw4jb2SNPugOBFCQ5sjm07kKUyHX
 yWXPihA/f45AHAoi7ObXZBd4EdGFigk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1718650694;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dpaA8UyxtRDsfB5RjDLzg2FDrDvAArW4wQMiSrS11Zc=;
 b=1np21OVr7AxYYxIS9oSXXieS9XzzcjD2QzmDYKmRUo5IZ8Mu3Is6CiRyf6Rk3QASCWZtkg
 dqjE+CIKPuVIygCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 659A6139AB;
 Mon, 17 Jun 2024 18:58:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id EG5EC0SHcGYJKAAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 17 Jun 2024 18:58:12 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, armbru@redhat.com, Peter Xu <peterx@redhat.com>,
 Claudio Fontana <cfontana@suse.de>, Jim Fehlig <jfehlig@suse.com>
Subject: [PATCH v3 15/16] migration: Add documentation for fdset with multifd
 + file
Date: Mon, 17 Jun 2024 15:57:30 -0300
Message-Id: <20240617185731.9725-16-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240617185731.9725-1-farosas@suse.de>
References: <20240617185731.9725-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_FIVE(0.00)[6];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
 RCVD_TLS_ALL(0.00)[]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
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

With the last few changes to the fdset infrastructure, we now allow
multifd to use an fdset when migrating to a file. This is useful for
the scenario where the management layer wants to have control over the
migration file.

By receiving the file descriptors directly, QEMU can delegate some
high level operating system operations to the management layer (such
as mandatory access control). The management layer might also want to
add its own headers before the migration stream.

Document the "file:/dev/fdset/#" syntax for the multifd migration with
mapped-ram. The requirements for the fdset mechanism are:

- the fdset must contain two fds that are not duplicates between
  themselves;

- if direct-io is to be used, exactly one of the fds must have the
  O_DIRECT flag set;

- the file must be opened with WRONLY on the migration source side;

- the file must be opened with RDONLY on the migration destination
  side.

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 docs/devel/migration/main.rst       | 24 +++++++++++++++++++-----
 docs/devel/migration/mapped-ram.rst |  6 +++++-
 2 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/docs/devel/migration/main.rst b/docs/devel/migration/main.rst
index 495cdcb112..784c899dca 100644
--- a/docs/devel/migration/main.rst
+++ b/docs/devel/migration/main.rst
@@ -47,11 +47,25 @@ over any transport.
   QEMU interference. Note that QEMU does not flush cached file
   data/metadata at the end of migration.
 
-In addition, support is included for migration using RDMA, which
-transports the page data using ``RDMA``, where the hardware takes care of
-transporting the pages, and the load on the CPU is much lower.  While the
-internals of RDMA migration are a bit different, this isn't really visible
-outside the RAM migration code.
+  The file migration also supports using a file that has already been
+  opened. A set of file descriptors is passed to QEMU via an "fdset"
+  (see add-fd QMP command documentation). This method allows a
+  management application to have control over the migration file
+  opening operation. There are, however, strict requirements to this
+  interface if the multifd capability is enabled:
+
+    - the fdset must contain two file descriptors that are not
+      duplicates between themselves;
+    - if the direct-io capability is to be used, exactly one of the
+      file descriptors must have the O_DIRECT flag set;
+    - the file must be opened with WRONLY on the migration source side
+      and RDONLY on the migration destination side.
+
+- rdma migration: support is included for migration using RDMA, which
+  transports the page data using ``RDMA``, where the hardware takes
+  care of transporting the pages, and the load on the CPU is much
+  lower.  While the internals of RDMA migration are a bit different,
+  this isn't really visible outside the RAM migration code.
 
 All these migration protocols use the same infrastructure to
 save/restore state devices.  This infrastructure is shared with the
diff --git a/docs/devel/migration/mapped-ram.rst b/docs/devel/migration/mapped-ram.rst
index fa4cefd9fc..d352b546e9 100644
--- a/docs/devel/migration/mapped-ram.rst
+++ b/docs/devel/migration/mapped-ram.rst
@@ -16,7 +16,7 @@ location in the file, rather than constantly being added to a
 sequential stream. Having the pages at fixed offsets also allows the
 usage of O_DIRECT for save/restore of the migration stream as the
 pages are ensured to be written respecting O_DIRECT alignment
-restrictions (direct-io support not yet implemented).
+restrictions.
 
 Usage
 -----
@@ -35,6 +35,10 @@ Use a ``file:`` URL for migration:
 Mapped-ram migration is best done non-live, i.e. by stopping the VM on
 the source side before migrating.
 
+For best performance enable the ``direct-io`` parameter as well:
+
+    ``migrate_set_parameter direct-io on``
+
 Use-cases
 ---------
 
-- 
2.35.3


