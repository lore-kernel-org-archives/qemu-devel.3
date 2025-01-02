Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97867E77198
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2025 18:59:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTQP5-0002eG-Nx; Thu, 02 Jan 2025 13:58:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tTQP3-0002dA-E4
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 13:58:41 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tTQP1-0003kU-LF
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 13:58:41 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D2562210F4;
 Thu,  2 Jan 2025 18:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1735844316; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=RkL3sor7e1q+V4xc+xliHFdjO9OZp5mhWG8r62MFuOA=;
 b=0qRnhpDWFdQF7mf7MhOksjgcxTy07jg7dMWd4X+WMCkhUhr/8Wt1cQAjxTUKYKz2ynVb6Q
 usxtAB/e8OZjwUsGJ1wydH99s5dWJr3QSOkXlHvo8UNNzCFUWG0+suGKhyEOfu4966VzOa
 rJkAx1DwVfLIONiwhI3Vk57iwUeXPhQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1735844316;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=RkL3sor7e1q+V4xc+xliHFdjO9OZp5mhWG8r62MFuOA=;
 b=6wyDWvzAvebnCp6OFKLJMtsH8EiarPWNP+mGAYW0dU0xIW3tYz9SSneIqQIZ6rEs2KK8SO
 RdOebMKFZm19ojDw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=aejWFVs7;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=6ta+M5WI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1735844315; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=RkL3sor7e1q+V4xc+xliHFdjO9OZp5mhWG8r62MFuOA=;
 b=aejWFVs7FXJlYQ9wyyqoM6ANLCdjpUYpqLwcZ5qblz4fOdNX5CO2icxHUyDO1H9LrO0/09
 UYRSQJujTxG8GEhXKlbeiWNRyNgmExT61jm+68ATReWRTeQJy1KwktDwa+uZkWzUoTAJ/L
 oUxPIUdBctKCY4+0pPEoa6Vr8NWvqZ4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1735844315;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=RkL3sor7e1q+V4xc+xliHFdjO9OZp5mhWG8r62MFuOA=;
 b=6ta+M5WINA3TNg53rfyuhRdkGq4aunusXDs7uoosVDms9N8r4J+oCbtSQOr9T0raS7Jdwg
 htAMFFMduQgERJAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9DA0E13418;
 Thu,  2 Jan 2025 18:58:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id YwYuGNrhdmeoUQAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 02 Jan 2025 18:58:34 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
	Thomas Huth <thuth@redhat.com>
Subject: [PATCH] migration: Add more error handling to analyze-migration.py
Date: Thu,  2 Jan 2025 15:58:31 -0300
Message-Id: <20250102185831.4324-1-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D2562210F4
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.00 / 50.00]; BAYES_HAM(-2.99)[99.96%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_COUNT_TWO(0.00)[2]; ARC_NA(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_TLS_ALL(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[3]; DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

The analyze-migration script was seen failing in s390x in misterious
ways. It seems we're reaching the subsection constructor without any
fields, which would indicate an empty .subsection entry in the vmstate
definition. We don't have any of those, at least not without the
unmigratable flag set, so this should never happen.

Add some debug statements so that we can see what's going on the next
time the issue happens.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 scripts/analyze-migration.py | 33 +++++++++++++++++++++++++++------
 1 file changed, 27 insertions(+), 6 deletions(-)

diff --git a/scripts/analyze-migration.py b/scripts/analyze-migration.py
index 8a254a5b6a..1dd98f1d5a 100755
--- a/scripts/analyze-migration.py
+++ b/scripts/analyze-migration.py
@@ -429,6 +429,10 @@ def __init__(self, desc, file):
         super(VMSDFieldStruct, self).__init__(desc, file)
         self.data = collections.OrderedDict()
 
+        if 'fields' not in self.desc['struct']:
+            raise Exception("No fields in subsection key=%s name=%s" %
+                            (self.section_key, self.vmsd_name))
+
         # When we see compressed array elements, unfold them here
         new_fields = []
         for field in self.desc['struct']['fields']:
@@ -477,6 +481,11 @@ def read(self):
                     raise Exception("Subsection %s not found at offset %x" % ( subsection['vmsd_name'], self.file.tell()))
                 name = self.file.readstr()
                 version_id = self.file.read32()
+
+                if not subsection:
+                    raise Exception("Empty description for subsection %s" %
+                                    name)
+
                 self.data[name] = VMSDSection(self.file, version_id, subsection, (name, 0))
                 self.data[name].read()
 
@@ -575,9 +584,8 @@ def __init__(self, filename):
         self.filename = filename
         self.vmsd_desc = None
 
-    def read(self, desc_only = False, dump_memory = False, write_memory = False):
-        # Read in the whole file
-        file = MigrationFile(self.filename)
+    def _read(self, file, vmsd_json, desc_only = False, dump_memory = False,
+              write_memory = False):
 
         # File magic
         data = file.read32()
@@ -589,7 +597,7 @@ def read(self, desc_only = False, dump_memory = False, write_memory = False):
         if data != self.QEMU_VM_FILE_VERSION:
             raise Exception("Invalid version number %d" % data)
 
-        self.load_vmsd_json(file)
+        self.load_vmsd_json(file, vmsd_json)
 
         # Read sections
         self.sections = collections.OrderedDict()
@@ -632,12 +640,25 @@ def read(self, desc_only = False, dump_memory = False, write_memory = False):
                     raise Exception("Mismatched section footer: %x vs %x" % (read_section_id, section_id))
             else:
                 raise Exception("Unknown section type: %d" % section_type)
-        file.close()
 
-    def load_vmsd_json(self, file):
+    def read(self, desc_only = False, dump_memory = False,
+             write_memory = False):
+        file = MigrationFile(self.filename)
         vmsd_json = file.read_migration_debug_json()
+
+        try:
+            self._read(file, vmsd_json, desc_only, dump_memory, write_memory)
+        except:
+            raise Exception("Full JSON dump:\n%s", vmsd_json)
+        finally:
+            file.close()
+
+    def load_vmsd_json(self, file, vmsd_json):
         self.vmsd_desc = json.loads(vmsd_json, object_pairs_hook=collections.OrderedDict)
         for device in self.vmsd_desc['devices']:
+            if 'fields' not in device:
+                raise Exception("vmstate for device %s has no fields" %
+                                device['name'])
             key = (device['name'], device['instance_id'])
             value = ( VMSDSection, device )
             self.section_classes[key] = value
-- 
2.35.3


