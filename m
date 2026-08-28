Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FDD8C61DBD
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 16:01:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzyzN-0001PE-Es; Fri, 28 Aug 2026 11:59:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wzyzD-0001OK-MT
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 11:59:24 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wzyz4-0008KC-Eh
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 11:59:21 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id F0D37221EA;
 Fri, 28 Aug 2026 15:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787932749; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OH8PIWdsNXOXaCv296Cw5fvd6R8sSm1H9li+6Zmc81A=;
 b=dzXFzC28eIKFf2VSeHD/7PljeMQY5mtVvOVep7Zsvbhd+bzAaYb0GJNrjUVo/b/k0LZOOx
 KOLqF9AEQSq+ix3nGNAdkpMago5rsoFShZqL8ApNb8b9LE9zmI5eMPOW5mZyGtdY77UB2h
 P9W5VqWzOWYU09BSWJWZJSAjKtgk6Bs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787932749;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OH8PIWdsNXOXaCv296Cw5fvd6R8sSm1H9li+6Zmc81A=;
 b=moigRewz0ri5t9XcX12kgBAD5EQEBkQSFMAtL17/9941tBl7HTkemKuSyycG1SNdK85xY9
 C5iNtpr20vcaEjCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787932744; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OH8PIWdsNXOXaCv296Cw5fvd6R8sSm1H9li+6Zmc81A=;
 b=lhuJB4XumcibCAw76vRknbT7S9qs8nTO2i9ejLpuj3CsQjvFgpiynRRK5sPetIoSdE2NBS
 k5ktq4pKW+x3kzhttLE90JxH+cIe56DfLSWOoV+rvXCX6xehl06HwJ0xbvqJ7T5344nxuJ
 byemXeZF00QEoWI1xvJlJfI01gnhocc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787932744;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OH8PIWdsNXOXaCv296Cw5fvd6R8sSm1H9li+6Zmc81A=;
 b=i4uqP7BWreGS+i0RwEps74AWs1D8Eexdrr8yvY+kPYuQT7hOmdR0GorPdHbiX7UXH/Gn/s
 rwQIKSEWzpNv/0BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E6F9813687;
 Fri, 28 Aug 2026 15:59:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ePJnLUewkWpoBQAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 28 Aug 2026 15:59:03 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
	Aadeshveer Singh <aadeshveer07@gmail.com>
Subject: [PULL v2 11/30] docs/migration: Add documentation for fast snapshot
 load feature
Date: Fri, 28 Aug 2026 12:58:26 -0300
Message-ID: <20260828155845.2874508-12-farosas@suse.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260828155845.2874508-1-farosas@suse.de>
References: <20260828155845.2874508-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.999];
 MIME_GOOD(-0.10)[text/plain]; RCVD_TLS_ALL(0.00)[];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[redhat.com,gmail.com];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; FREEMAIL_ENVRCPT(0.00)[gmail.com]
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


