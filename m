Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4259E77197
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 18:53:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVxeU-0002IU-HO; Thu, 09 Jan 2025 13:53:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tVxeO-0002HL-Mm
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 13:53:04 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tVxeM-0005sk-T3
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 13:53:00 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9351E2111F;
 Thu,  9 Jan 2025 18:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1736448775; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sMJx2pzWfxVFk6wour7Z8kvLg7qdh3rP3Lxozjx6Gbk=;
 b=qf62MH497ybhErVKEAcnaeXFxZD502EFVflR42WzPJlxI//D8LRe9x6jBgGozpessQ5vdJ
 UrQG5Jb6eDkIBUCpQ//g08I+qxfE8MsciJDgfeq4LbzJJfyowCwyrPnhtvVVXsRdFuOYMf
 fBJFxjuKBi8+B7Fv6xuF1vxz9Hdeumc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1736448775;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sMJx2pzWfxVFk6wour7Z8kvLg7qdh3rP3Lxozjx6Gbk=;
 b=+EhGBDCQrUYn31+Gyvxy9ESUtfGJDlP+zvvtMaAYB0Q53eh2p8cSzZ7uV9NDoHXsLznju4
 VSCxRpskgL0GBxCg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=qf62MH49;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=+EhGBDCQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1736448775; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sMJx2pzWfxVFk6wour7Z8kvLg7qdh3rP3Lxozjx6Gbk=;
 b=qf62MH497ybhErVKEAcnaeXFxZD502EFVflR42WzPJlxI//D8LRe9x6jBgGozpessQ5vdJ
 UrQG5Jb6eDkIBUCpQ//g08I+qxfE8MsciJDgfeq4LbzJJfyowCwyrPnhtvVVXsRdFuOYMf
 fBJFxjuKBi8+B7Fv6xuF1vxz9Hdeumc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1736448775;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sMJx2pzWfxVFk6wour7Z8kvLg7qdh3rP3Lxozjx6Gbk=;
 b=+EhGBDCQrUYn31+Gyvxy9ESUtfGJDlP+zvvtMaAYB0Q53eh2p8cSzZ7uV9NDoHXsLznju4
 VSCxRpskgL0GBxCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 617D2139AB;
 Thu,  9 Jan 2025 18:52:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 4LXsCQYbgGdcMAAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 09 Jan 2025 18:52:54 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
	Thomas Huth <thuth@redhat.com>
Subject: [PATCH v3 1/7] migration: Add more error handling to
 analyze-migration.py
Date: Thu,  9 Jan 2025 15:52:43 -0300
Message-Id: <20250109185249.23952-2-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250109185249.23952-1-farosas@suse.de>
References: <20250109185249.23952-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 9351E2111F
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
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
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
ways. It seems we're reaching the VMSDFieldStruct constructor without
any fields, which would indicate an empty .subsection entry, a
VMSTATE_STRUCT with no fields or a vmsd with no fields. We don't have
any of those, at least not without the unmigratable flag set, so this
should never happen.

Add some debug statements so that we can see what's going on the next
time the issue happens.

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
Message-Id: <20250103141305.8435-1-farosas@suse.de>
---
 scripts/analyze-migration.py | 75 +++++++++++++++++++++---------------
 1 file changed, 45 insertions(+), 30 deletions(-)

diff --git a/scripts/analyze-migration.py b/scripts/analyze-migration.py
index 8a254a5b6a..f2457b1dde 100755
--- a/scripts/analyze-migration.py
+++ b/scripts/analyze-migration.py
@@ -429,6 +429,9 @@ def __init__(self, desc, file):
         super(VMSDFieldStruct, self).__init__(desc, file)
         self.data = collections.OrderedDict()
 
+        if 'fields' not in self.desc['struct']:
+            raise Exception("No fields in struct. VMSD:\n%s" % self.desc)
+
         # When we see compressed array elements, unfold them here
         new_fields = []
         for field in self.desc['struct']['fields']:
@@ -477,6 +480,10 @@ def read(self):
                     raise Exception("Subsection %s not found at offset %x" % ( subsection['vmsd_name'], self.file.tell()))
                 name = self.file.readstr()
                 version_id = self.file.read32()
+
+                if not subsection:
+                    raise Exception("Empty description for subsection: %s" % name)
+
                 self.data[name] = VMSDSection(self.file, version_id, subsection, (name, 0))
                 self.data[name].read()
 
@@ -574,10 +581,13 @@ def __init__(self, filename):
         }
         self.filename = filename
         self.vmsd_desc = None
+        self.vmsd_json = ""
 
-    def read(self, desc_only = False, dump_memory = False, write_memory = False):
+    def read(self, desc_only = False, dump_memory = False,
+             write_memory = False):
         # Read in the whole file
         file = MigrationFile(self.filename)
+        self.vmsd_json = file.read_migration_debug_json()
 
         # File magic
         data = file.read32()
@@ -635,9 +645,11 @@ def read(self, desc_only = False, dump_memory = False, write_memory = False):
         file.close()
 
     def load_vmsd_json(self, file):
-        vmsd_json = file.read_migration_debug_json()
-        self.vmsd_desc = json.loads(vmsd_json, object_pairs_hook=collections.OrderedDict)
+        self.vmsd_desc = json.loads(self.vmsd_json,
+                                    object_pairs_hook=collections.OrderedDict)
         for device in self.vmsd_desc['devices']:
+            if 'fields' not in device:
+                raise Exception("vmstate for device %s has no fields" % device['name'])
             key = (device['name'], device['instance_id'])
             value = ( VMSDSection, device )
             self.section_classes[key] = value
@@ -666,31 +678,34 @@ def default(self, o):
 
 jsonenc = JSONEncoder(indent=4, separators=(',', ': '))
 
-if args.extract:
-    dump = MigrationDump(args.file)
-
-    dump.read(desc_only = True)
-    print("desc.json")
-    f = open("desc.json", "w")
-    f.truncate()
-    f.write(jsonenc.encode(dump.vmsd_desc))
-    f.close()
-
-    dump.read(write_memory = True)
-    dict = dump.getDict()
-    print("state.json")
-    f = open("state.json", "w")
-    f.truncate()
-    f.write(jsonenc.encode(dict))
-    f.close()
-elif args.dump == "state":
-    dump = MigrationDump(args.file)
-    dump.read(dump_memory = args.memory)
-    dict = dump.getDict()
-    print(jsonenc.encode(dict))
-elif args.dump == "desc":
-    dump = MigrationDump(args.file)
-    dump.read(desc_only = True)
-    print(jsonenc.encode(dump.vmsd_desc))
-else:
+if not any([args.extract, args.dump == "state", args.dump == "desc"]):
     raise Exception("Please specify either -x, -d state or -d desc")
+
+try:
+    dump = MigrationDump(args.file)
+
+    if args.extract:
+        dump.read(desc_only = True)
+
+        print("desc.json")
+        f = open("desc.json", "w")
+        f.truncate()
+        f.write(jsonenc.encode(dump.vmsd_desc))
+        f.close()
+
+        dump.read(write_memory = True)
+        dict = dump.getDict()
+        print("state.json")
+        f = open("state.json", "w")
+        f.truncate()
+        f.write(jsonenc.encode(dict))
+        f.close()
+    elif args.dump == "state":
+        dump.read(dump_memory = args.memory)
+        dict = dump.getDict()
+        print(jsonenc.encode(dict))
+    elif args.dump == "desc":
+        dump.read(desc_only = True)
+        print(jsonenc.encode(dump.vmsd_desc))
+except Exception:
+    raise Exception("Full JSON dump:\n%s", dump.vmsd_json)
-- 
2.35.3


