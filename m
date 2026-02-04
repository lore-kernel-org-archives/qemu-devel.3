Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76F08E9D41F
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 17:24:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vngbY-0003pL-G0; Wed, 04 Feb 2026 12:23:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vngbW-0003oe-MP
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 12:23:50 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vngbV-0003GO-0z
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 12:23:50 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D567B5BCF8;
 Wed,  4 Feb 2026 17:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1770225819; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2hXVkzNATR8J0anuapMeOR5MGDaANuJNBMswWbvHgmY=;
 b=kalFuKj35sjlziA2tCMlvWEpMvn7GVCrWUL9w8Ir3+AzwvoZVHD1a3T2M8oXsBKovD2clq
 XdOcXqBcem1vKJzmV86Zd0orFFiJIlNvQNXwqnwgStSrCJ9DPZDEu7jdnDExE/cuHKmttt
 NhRpKi2bzjgKT1TbQMBXcAW6AoH0zjE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1770225819;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2hXVkzNATR8J0anuapMeOR5MGDaANuJNBMswWbvHgmY=;
 b=EjAy9DRwYXP/ILYg6+4CRuHouyqZwwe8MAZkz6yJNagHvJQEWEXt0PxF74tYi8aHBl5z2j
 dp8j3RL+j5UZaUDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1770225818; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2hXVkzNATR8J0anuapMeOR5MGDaANuJNBMswWbvHgmY=;
 b=Pyl+Q2JB4D3jrsW3eLt89v6rckOKVnb67D/ZVN5bccS+rgUygdDcKEYg9M24K4uAHv0RJm
 Q1h3cG95gmhUi9bFYOsc7NtotsFbBIRbKlsDEisO3tqzx5R3bmu4XtAOWdfwXDxL/LeCYM
 wwCrqzmfvVFUIESNJqdNyNJXkVv/xUE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1770225818;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2hXVkzNATR8J0anuapMeOR5MGDaANuJNBMswWbvHgmY=;
 b=PuwhP6Ohg5cyd+ZlTKCaIO7ynTr5NCVUJ/d1gF7Ljf6SLEYHVmSEMIdS0HgFKULYqJfux7
 kDKy5Lkj9uFQLrAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4F6B73EA63;
 Wed,  4 Feb 2026 17:23:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id OGqzBJmAg2nQNgAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 04 Feb 2026 17:23:37 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com,
	berrange@redhat.com,
	peterx@redhat.com
Subject: [PATCH v2 1/4] tests/functional/migration: Use socket_dir
Date: Wed,  4 Feb 2026 14:23:29 -0300
Message-ID: <20260204172332.21367-2-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260204172332.21367-1-farosas@suse.de>
References: <20260204172332.21367-1-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; FROM_EQ_ENVFROM(0.00)[];
 TO_DN_NONE(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email]
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

Use QemuBaseTest.socket_dir instead of calling tempfile directly so
all tests have consistent directory prefixes.

Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/functional/migration.py | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/tests/functional/migration.py b/tests/functional/migration.py
index 2bfb1f7790..0aa873edba 100644
--- a/tests/functional/migration.py
+++ b/tests/functional/migration.py
@@ -11,7 +11,6 @@
 # This work is licensed under the terms of the GNU GPL, version 2 or
 # later.  See the COPYING file in the top-level directory.
 
-import tempfile
 import time
 
 from qemu_test import QemuSystemTest, which
@@ -65,9 +64,8 @@ def migration_with_tcp_localhost(self):
             self.do_migrate(dest_uri)
 
     def migration_with_unix(self):
-        with tempfile.TemporaryDirectory(prefix='socket_') as socket_path:
-            dest_uri = 'unix:%s/qemu-test.sock' % socket_path
-            self.do_migrate(dest_uri)
+        dest_uri = 'unix:%s/migration.sock' % self.socket_dir().name
+        self.do_migrate(dest_uri)
 
     def migration_with_exec(self):
         if not which('ncat'):
-- 
2.51.0


