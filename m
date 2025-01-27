Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14D56C02190
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 08:18:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcgcd-0006x7-Ft; Tue, 28 Jan 2025 03:07:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tcgar-0002Hn-Bg; Tue, 28 Jan 2025 03:05:15 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tcgap-0002mP-2v; Tue, 28 Jan 2025 03:05:09 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 2C559E1B70;
 Tue, 28 Jan 2025 10:57:09 +0300 (MSK)
Received: from localhost.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 9C3741A6323;
 Tue, 28 Jan 2025 10:57:34 +0300 (MSK)
Received: by localhost.tls.msk.ru (Postfix, from userid 1000)
 id 2D7B6520D7; Tue, 28 Jan 2025 10:57:34 +0300 (MSK)
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Peter Xu <peterx@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.1.3 41/58] migration: Add more error handling to
 analyze-migration.py
Date: Mon, 27 Jan 2025 23:25:27 +0300
Message-Id: <20250127202547.3723716-41-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-9.1.3-20250127232536@cover.tls.msk.ru>
References: <qemu-stable-9.1.3-20250127232536@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Michael Tokarev <mjt@tls.msk.ru>
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_06_12=1.543,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

The analyze-migration script was seen failing in s390x in misterious
ways. It seems we're reaching the VMSDFieldStruct constructor without
any fields, which would indicate an empty .subsection entry, a
VMSTATE_STRUCT with no fields or a vmsd with no fields. We don't have
any of those, at least not without the unmigratable flag set, so this
should never happen.

Add some debug statements so that we can see what's going on the next
time the issue happens.

Reviewed-by: Peter Xu <peterx@redhat.com>
Message-Id: <20250109185249.23952-2-farosas@suse.de>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
(cherry picked from commit 86bee9e0c761a3d0e67c43b44001fd752f894cb0)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

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
+if not any([args.extract, args.dump == "state", args.dump == "desc"]):
+    raise Exception("Please specify either -x, -d state or -d desc")
 
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
+try:
     dump = MigrationDump(args.file)
-    dump.read(desc_only = True)
-    print(jsonenc.encode(dump.vmsd_desc))
-else:
-    raise Exception("Please specify either -x, -d state or -d desc")
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
2.39.5


