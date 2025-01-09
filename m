Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1B72E77197
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 18:54:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVxeX-0002J7-Ap; Thu, 09 Jan 2025 13:53:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tVxeQ-0002HW-4L
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 13:53:04 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tVxeO-0005tX-As
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 13:53:01 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E70C52116E;
 Thu,  9 Jan 2025 18:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1736448779; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EffxaSSeSINwWm8q32W+RUAkfUbnkplZk0uvvu2EVCo=;
 b=jWIFUlmlgZuMkyZI0KC74GTveYN5+o2B7tkYK11AdUBkXlWizBVeqWyYBdxPaxADBncvx1
 k95pOzeylFqbNKrUDJKryQeGY6WZB6IgmVSXRy/HYu28fquabYauqEbUoJj65RhHmDEIdU
 0iyQnkmFwCmNDWWjTM8UNpzP4MIqYzA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1736448779;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EffxaSSeSINwWm8q32W+RUAkfUbnkplZk0uvvu2EVCo=;
 b=OwIyb+4eXdbs6a443wtv9Y58SK5cuvq5k6Gq1BnCDYAJxSQTUnYm26SdRU67PCGuAiCbKA
 dKhlHwzJthjwgmDg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=x6itW1Sj;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=xAOmPVGf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1736448778; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EffxaSSeSINwWm8q32W+RUAkfUbnkplZk0uvvu2EVCo=;
 b=x6itW1Sjjsd3WC39om1kxKYUhn1IP0JPzTbuVGHbmGMfIW+2XO0mizMnDgohoq6393uSnN
 xySQwK8vBCJTWzN2VpMpzL65+h8C763UQLR1atF1LhvmG47I9d1tb7A75N00Pi8IghAKMW
 cxQEqgxGH6+IbPCblotdQinwP9xN5AA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1736448778;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EffxaSSeSINwWm8q32W+RUAkfUbnkplZk0uvvu2EVCo=;
 b=xAOmPVGfJLODqZlDcNg1EZgf6Yw9WcPydniTrDXzex3JSCLwrf83jT0vI/z4gzlV87JU7A
 pk8dYySOBv1mhrDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B53BE139AB;
 Thu,  9 Jan 2025 18:52:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id oA1wHgkbgGdcMAAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 09 Jan 2025 18:52:57 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
	Thomas Huth <thuth@redhat.com>
Subject: [PATCH v3 3/7] migration: Fix parsing of s390 stream
Date: Thu,  9 Jan 2025 15:52:45 -0300
Message-Id: <20250109185249.23952-4-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250109185249.23952-1-farosas@suse.de>
References: <20250109185249.23952-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E70C52116E
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,suse.de:mid];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[3]; DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

The parsing for the S390StorageAttributes section is currently leaving
an unconsumed token that is later interpreted by the generic code as
QEMU_VM_EOF, cutting the parsing short.

The migration will issue a STATTR_FLAG_DONE between iterations, which
the script consumes correctly, but there's a final STATTR_FLAG_EOS at
.save_complete that the script is ignoring. Since the EOS flag is a
u64 0x1ULL and the stream is big endian, on little endian hosts a byte
read from it will be 0x0, the same as QEMU_VM_EOF.

Fixes: 81c2c9dd5d ("tests/qtest/migration-test: Fix analyze-migration.py for s390x")
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 scripts/analyze-migration.py | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/scripts/analyze-migration.py b/scripts/analyze-migration.py
index f2457b1dde..fcda11f31d 100755
--- a/scripts/analyze-migration.py
+++ b/scripts/analyze-migration.py
@@ -65,6 +65,9 @@ def readvar(self, size = None):
     def tell(self):
         return self.file.tell()
 
+    def seek(self, a, b):
+        return self.file.seek(a, b)
+
     # The VMSD description is at the end of the file, after EOF. Look for
     # the last NULL byte, then for the beginning brace of JSON.
     def read_migration_debug_json(self):
@@ -272,11 +275,24 @@ def __init__(self, file, version_id, device, section_key):
         self.section_key = section_key
 
     def read(self):
+        pos = 0
         while True:
             addr_flags = self.file.read64()
             flags = addr_flags & 0xfff
-            if (flags & (self.STATTR_FLAG_DONE | self.STATTR_FLAG_EOS)):
+
+            if flags & self.STATTR_FLAG_DONE:
+                pos = self.file.tell()
+                continue
+            elif flags & self.STATTR_FLAG_EOS:
                 return
+            else:
+                # No EOS came after DONE, that's OK, but rewind the
+                # stream because this is not our data.
+                if pos:
+                    self.file.seek(pos, os.SEEK_SET)
+                    return
+                raise Exception("Unknown flags %x", flags)
+
             if (flags & self.STATTR_FLAG_ERROR):
                 raise Exception("Error in migration stream")
             count = self.file.read64()
-- 
2.35.3


