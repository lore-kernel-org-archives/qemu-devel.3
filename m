Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EE61C5DF97
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 14:30:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzEdF-000191-7T; Wed, 26 Aug 2026 10:29:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wzEdD-00018h-Tw
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 10:29:35 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wzEdC-0001m1-2Z
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 10:29:35 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 8DD121F811;
 Wed, 26 Aug 2026 14:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787754568; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OH8PIWdsNXOXaCv296Cw5fvd6R8sSm1H9li+6Zmc81A=;
 b=sRDUzboQSqVZXdecJ/woiz74cIWGZ1wRofMAgHABwgJope/PM9BTAxtTrZ6hWwmoAtCZ52
 ucL4MnB7YsfcDpZJIpUt0uE0Sn5u70D/Pc+vXVocy5NWjpCcStXVLe7weaZX0Hmse/+vw5
 l3+sx9GMmqmhDVgwiEYoKqrVUHuR6IQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787754568;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OH8PIWdsNXOXaCv296Cw5fvd6R8sSm1H9li+6Zmc81A=;
 b=5iRuVbEkteLt+GSXvbvUSSaWMjsVFkBLIPvySVnAmVe7t1yoC1+Z5vw1wkDfzcMF6FF6ya
 RSbDgu5tdUNR5VAg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="j/ryIHZI";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="UNsEXp/n"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787754564; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OH8PIWdsNXOXaCv296Cw5fvd6R8sSm1H9li+6Zmc81A=;
 b=j/ryIHZIbJ/NE0K3pk7pslg2T4o1mysOmHXEwo6xhZWZevyzcS0VSehpMpIf6v1UBfKeQH
 Qrp32nQbk+6YeDtlKt/isYSJz75/zby6/0cgeSLwch/LaIx9VfYFBN1rchaVG0JlR6Mq2W
 e5X9rep6MoEpKjfgeWC4tKMIxBhXVVc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787754564;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OH8PIWdsNXOXaCv296Cw5fvd6R8sSm1H9li+6Zmc81A=;
 b=UNsEXp/nhqXekIfEt2T3dKCXjex3LTvjM9gSSxXeFacy3JEJ29ObvCpF5S6eAQ/TQ8RL1k
 1E9zyOQ0dEpcRcBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9C5631364F;
 Wed, 26 Aug 2026 14:29:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id sAFMG0P4jmpTJAAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 26 Aug 2026 14:29:23 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
	Aadeshveer Singh <aadeshveer07@gmail.com>
Subject: [PULL 11/30] docs/migration: Add documentation for fast snapshot load
 feature
Date: Wed, 26 Aug 2026 11:28:46 -0300
Message-ID: <20260826142905.2315503-12-farosas@suse.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260826142905.2315503-1-farosas@suse.de>
References: <20260826142905.2315503-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 URIBL_BLOCKED(0.00)[suse.de:email,suse.de:mid,suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_HAS_DN(0.00)[]; FREEMAIL_CC(0.00)[redhat.com,gmail.com];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DKIM_TRACE(0.00)[suse.de:+]; RCPT_COUNT_THREE(0.00)[3];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Rspamd-Queue-Id: 8DD121F811
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
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

From: Aadeshveer Singh <aadeshveer07@gmail.com>

Add documenatation for fast snapshot load covering an overview, the
architecture, usage and limitations.

Signed-off-by: Aadeshveer Singh <aadeshveer07@gmail.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 docs/devel/migration/fast-snapshot-load.rst | 82 +++++++++++++++++++++
 docs/devel/migration/features.rst           |  1 +
 2 files changed, 83 insertions(+)
 create mode 100644 docs/devel/migration/fast-snapshot-load.rst

diff --git a/docs/devel/migration/fast-snapshot-load.rst b/docs/devel/migration/fast-snapshot-load.rst
new file mode 100644
index 00000000000..fe2361d6fe1
--- /dev/null
+++ b/docs/devel/migration/fast-snapshot-load.rst
@@ -0,0 +1,82 @@
+==================
+Fast Snapshot Load
+==================
+
+Overview
+========
+Fast snapshot load is an extension of the postcopy migration feature
+to disk loads.
+
+Unlike a usual snapshot load, which requires all VM data (RAM as well
+as device states) to be loaded into host RAM from the snapshot file
+for the guest to run, fast snapshot load uses postcopy infrastructure
+to load in only the required device states and allows RAM pages to
+be loaded after the guest starts execution. The idea is to start the
+guest and serve its page faults on the go, reducing the perceived
+resume time for large snapshots.
+
+Architecture
+============
+This feature combines postcopy migration and mapped-ram capabilities
+to load RAM pages on demand. It is done by catching guest faults using
+Linux ``userfaultfd`` and loading the page by calculating the offset
+of its location in the snapshot file using mapped-ram capabilities.
+
+Fault Thread
+------------
+The fault thread uses Linux ``userfaultfd`` to catch page faults caused
+by guest and directly load the page from the snapshot file. It is
+very similar to network postcopy fault thread, with primary difference
+being it loads pages directly by reading from the snapshot file.
+
+Eager Thread
+------------
+Eager thread iterates over all pages in RAM and loads each page not
+yet loaded by fault thread. It is required as unlike network postcopy
+where majority of RAM has already been loaded via precopy, here entire
+RAM is waiting to be loaded. If there is no eager loading thread each
+page will only be loaded when it is required by guest. In case there
+are some background pages that are never/rarely accessed by guest,
+the system will be locked in migration state indefinitely.
+
+Synchronization
+---------------
+In order to make sure both of these threads do not load the same page
+twice potentially overwriting and corrupting user RAM, a bitmap is
+used (``RAMBlock->pending_bmap``) which tracks the pages claimed to
+be loaded by threads. This prevents race condition when one thread
+is loading the page and other one tries to do the same.
+
+Usage
+=====
+
+Simply enable ``mapped-ram`` and ``postcopy-ram`` capabilities on
+the destination:
+
+.. code-block:: text
+
+    migrate_set_capability mapped-ram on
+    migrate_set_capability postcopy-ram on
+
+Use a ``file:`` URI for migration:
+
+.. code-block:: text
+
+    migrate_incoming file:/path/to/snapshot/file
+
+Limitations
+===========
+
+ - Multifd
+    Fast snapshot load is currently incompatible with ``multifd``
+    capability. While ``mapped-ram`` allows for parallel disk I/O,
+    coupling it with ``postcopy`` capability requires additional
+    infrastructure.
+
+ - Host OS support
+    Because this feautre essentially depends on ``userfaultfd``
+    to trap page faults, it is supported only on Linux hosts.
+
+ - vhost-user
+    Fast snapshot load does not currently support ``vhost-user``
+    backends.
diff --git a/docs/devel/migration/features.rst b/docs/devel/migration/features.rst
index 9aef79e7fa4..23c2a93173c 100644
--- a/docs/devel/migration/features.rst
+++ b/docs/devel/migration/features.rst
@@ -11,6 +11,7 @@ Migration has plenty of features to support different use cases.
    vfio
    virtio
    mapped-ram
+   fast-snapshot-load
    CPR
    qpl-compression
    uadk-compression
-- 
2.53.0


