Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42FBAE67A62
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 17:34:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxTd1-0001F8-6r; Tue, 03 Mar 2026 12:33:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vxTcz-0001Ew-8p
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 12:33:49 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vxTcx-0005zs-Mr
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 12:33:49 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B528A5BE14;
 Tue,  3 Mar 2026 17:33:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1772559211; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ovzj9oJIHtiVUljGCATbj3fPCXtNEzo9kyOqCRfJvEM=;
 b=CUpmbfAQZ3CyFIq89DK4DH9OkmSVxAlhWPC0+DxJbSdck+hitP4+tBJVce4059cd/Wh6Oo
 CvEiWh64KfBHm9HME/RpGW9CI7OGuyZsAA6TeICf8xJnpCz0vY7GYFAzvEn3QRARyQaezd
 f5MLTVa3Zo07B+yzy8C2oNTRPIbGLOk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1772559211;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ovzj9oJIHtiVUljGCATbj3fPCXtNEzo9kyOqCRfJvEM=;
 b=BYUP67W3A6TDs8O4QUdEAjVGq6IJ5Sw2VuA5QY7xn3xaNkkbI5Ju6npdZ82Ea4UtcerIEG
 qLBixCWL9vy5xgBw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=CUpmbfAQ;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=BYUP67W3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1772559211; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ovzj9oJIHtiVUljGCATbj3fPCXtNEzo9kyOqCRfJvEM=;
 b=CUpmbfAQZ3CyFIq89DK4DH9OkmSVxAlhWPC0+DxJbSdck+hitP4+tBJVce4059cd/Wh6Oo
 CvEiWh64KfBHm9HME/RpGW9CI7OGuyZsAA6TeICf8xJnpCz0vY7GYFAzvEn3QRARyQaezd
 f5MLTVa3Zo07B+yzy8C2oNTRPIbGLOk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1772559211;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ovzj9oJIHtiVUljGCATbj3fPCXtNEzo9kyOqCRfJvEM=;
 b=BYUP67W3A6TDs8O4QUdEAjVGq6IJ5Sw2VuA5QY7xn3xaNkkbI5Ju6npdZ82Ea4UtcerIEG
 qLBixCWL9vy5xgBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 115A13EA69;
 Tue,  3 Mar 2026 17:33:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id +GbEMWkbp2n+VAAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 03 Mar 2026 17:33:29 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: adityag@linux.ibm.com, thuth@redhat.com, berrange@redhat.com,
 peterx@redhat.com
Subject: [PATCH v4 3/4] tests/functional/migration: Use the migrate_vms helper
Date: Tue,  3 Mar 2026 14:33:19 -0300
Message-ID: <20260303173320.10942-4-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260303173320.10942-1-farosas@suse.de>
References: <20260303173320.10942-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5]; TO_DN_NONE(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns, suse.de:mid, suse.de:dkim, suse.de:email]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: B528A5BE14
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.322,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=1.141, SPF_HELO_NONE=0.001,
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

Change do_migrate() to call the migrate_vms() helper and provide it
with the two VMs already created. Rename do_migrate -> migrate and
adjust the callers.

While here, standardize on the "src" and "dst" names.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/functional/migration.py | 34 ++++++++++++++++++----------------
 1 file changed, 18 insertions(+), 16 deletions(-)

diff --git a/tests/functional/migration.py b/tests/functional/migration.py
index 3362e5c743..49347a30bb 100644
--- a/tests/functional/migration.py
+++ b/tests/functional/migration.py
@@ -45,17 +45,19 @@ def migrate_vms(self, dst_uri, src_uri, dst_vm, src_vm):
         src_vm.qmp('migrate', uri=src_uri)
         self.assert_migration(src_vm, dst_vm)
 
-    def do_migrate(self, dest_uri, src_uri=None):
-        dest_vm = self.get_vm('-incoming', dest_uri, name="dest-qemu")
-        dest_vm.add_args('-nodefaults')
-        dest_vm.launch()
+    def migrate(self, dst_uri, src_uri=None):
+        dst_vm = self.get_vm('-incoming', 'defer', name="dst-qemu")
+        dst_vm.add_args('-nodefaults')
+        dst_vm.launch()
+
+        src_vm = self.get_vm(name="src-qemu")
+        src_vm.add_args('-nodefaults')
+        src_vm.launch()
+
         if src_uri is None:
-            src_uri = dest_uri
-        source_vm = self.get_vm(name="source-qemu")
-        source_vm.add_args('-nodefaults')
-        source_vm.launch()
-        source_vm.qmp('migrate', uri=src_uri)
-        self.assert_migration(source_vm, dest_vm)
+            src_uri = dst_uri
+
+        self.migrate_vms(dst_uri, src_uri, dst_vm, src_vm)
 
     def _get_free_port(self, ports):
         port = ports.find_free_port()
@@ -65,18 +67,18 @@ def _get_free_port(self, ports):
 
     def migration_with_tcp_localhost(self):
         with Ports() as ports:
-            dest_uri = 'tcp:localhost:%u' % self._get_free_port(ports)
-            self.do_migrate(dest_uri)
+            dst_uri = 'tcp:localhost:%u' % self._get_free_port(ports)
+            self.migrate(dst_uri)
 
     def migration_with_unix(self):
-        dest_uri = 'unix:%s/migration.sock' % self.socket_dir().name
-        self.do_migrate(dest_uri)
+        dst_uri = 'unix:%s/migration.sock' % self.socket_dir().name
+        self.migrate(dst_uri)
 
     def migration_with_exec(self):
         if not which('ncat'):
             self.skipTest('ncat is not available')
         with Ports() as ports:
             free_port = self._get_free_port(ports)
-            dest_uri = 'exec:ncat -l localhost %u' % free_port
+            dst_uri = 'exec:ncat -l localhost %u' % free_port
             src_uri = 'exec:ncat localhost %u' % free_port
-            self.do_migrate(dest_uri, src_uri)
+            self.migrate(dst_uri, src_uri)
-- 
2.51.0


